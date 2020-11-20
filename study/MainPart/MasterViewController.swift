//
//  MasterViewController.swift
//  study
//
//  Created by 渡辺奈央騎 on 2020/07/20.
//  Copyright © 2020 渡辺奈央騎. All rights reserved.
//

import UIKit
import CoreData

class MasterViewController: UITableViewController, NSFetchedResultsControllerDelegate, send_any_data, UIPopoverPresentationControllerDelegate, UIViewControllerTransitioningDelegate{

    var detailViewController: DetailViewController? = nil
    var managedObjectContext: NSManagedObjectContext? = nil
    
    
    /**セルのタイトルを変えるか確認するcell_check値**/
    var title_changer_checker:cell_check = .None
    
    /**セルの数字を保存**/
    var cell_row_num : IndexPath?
    

    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Do any additional setup after loading the view.
        
        let time = UserDefaults.standard.integer(forKey: "TIME")
        let grade = UserDefaults.standard.integer(forKey: "GRADE")
        
        if time < 30 || time > 120 {
            UserDefaults.standard.setValue(75, forKey: "TIME")
        }
        
        if grade < 1 || grade > 9 {
            UserDefaults.standard.setValue(5, forKey: "GRADE")
        }
        
        //I want to save this screenSize
        
        let APPDelegate:AppDelegate = UIApplication.shared.delegate as! AppDelegate
        APPDelegate.screen_size = self.view.frame.size
        
        self.isEditing = false
        
        create_EditButton()
        
        let addButton = UIBarButtonItem(barButtonSystemItem: .add, target: self, action: #selector(insertNewObject(_:)))
        navigationItem.rightBarButtonItem = addButton
        /**detailViewController変数にDetailViewControllerクラスを代入**/
        if let split = splitViewController {
            let controllers = split.viewControllers
            detailViewController = (controllers[controllers.count-1] as! UINavigationController).topViewController as? DetailViewController
        }
    }

    override func viewWillAppear(_ animated: Bool) {
        if cell_row_num != nil {
            
            if title_changer_checker == .Clear {
                title_changer_checker = .None
            }
        }
        
        /**DetailViewControllerから戻った時に呼ばれる**/
        clearsSelectionOnViewWillAppear = splitViewController!.isCollapsed
        super.viewWillAppear(animated)
    }

    @objc
    func insertNewObject(_ sender: Any) {
        let context = self.fetchedResultsController.managedObjectContext
        let newPastData = Past_Data(context: context)
             
        // If appropriate, configure the new managed object.
        newPastData.enum_CellCheck = 0
        newPastData.day = Date()
        newPastData.cellTouchEnable = true
        
        // Save the context.
        do {
            try context.save()
        } catch {
            // Replace this implementation with code to handle the error appropriately.
            // fatalError() causes the application to generate a crash log and terminate. You should not use this function in a shipping application, although it may be useful during development.
            let nserror = error as NSError
            fatalError("Unresolved error \(nserror), \(nserror.userInfo)")
        }
    }

    // MARK: - Segues

    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "showDetail" {
            if let indexPath = tableView.indexPathForSelectedRow {
                
                cell_row_num = indexPath
                
                let object = fetchedResultsController.object(at: indexPath)
                //次のコントローラーの定義
                let next_controller = (segue.destination as! UINavigationController).topViewController as! DetailViewController
                next_controller.detailItem = object
                next_controller.navigationItem.leftBarButtonItem = splitViewController?.displayModeButtonItem
                next_controller.navigationItem.leftItemsSupplementBackButton = true
                detailViewController = next_controller
                next_controller.cell_check_sender = self
            }
        }
    }

    // MARK: - Table View

    override func numberOfSections(in tableView: UITableView) -> Int {
        return fetchedResultsController.sections?.count ?? 0
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        let sectionInfo = fetchedResultsController.sections![section]
        return sectionInfo.numberOfObjects
    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "Cell", for: indexPath)
        let object = fetchedResultsController.object(at: indexPath)
        
        configureCell(cell, withData: object)
        
        return cell
    }

    override func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        // 指定したアイテムを編集可能にしたくない場合はfalseを返します。
        
        return true
    }

    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            let context = fetchedResultsController.managedObjectContext
            context.delete(fetchedResultsController.object(at: indexPath))
            
            do {
                try context.save()
            } catch {
                // この実装をコードに置き換えて、エラーを適切に処理します。
                // fatalError（）により、アプリケーションはクラッシュログを生成して終了します。 この機能は、開発中に役立つ場合がありますが、出荷アプリケーションでは使用しないでください。
                let nserror = error as NSError
                fatalError("Unresolved error \(nserror), \(nserror.userInfo)")
            }
        }
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        /**セルを選択した時呼ばれる**/
        
        /**検索条件のDATE情報の取得とnilデータの排除**/
        let object = fetchedResultsController.object(at: indexPath)
        let Date_DATA = object.day
        if (Date_DATA == nil) {
            return
        }
        /**検索条件のDATE情報の取得とnilデータの排除**/
            // 読み込むエンティティを指定
            let fetchRequest = NSFetchRequest<NSManagedObject>(entityName: "Past_Data")
            //条件指定
            fetchRequest.predicate = NSPredicate(format: "day == %@", Date_DATA! as CVarArg)
            
            do {
                if managedObjectContext == nil {
                    return
                }
                
                let myResult = try managedObjectContext!.fetch(fetchRequest)
                
                let mydata = myResult[0]
                
                mydata.setValue(false, forKey: "cellTouchEnable")
                mydata.setValue(1, forKey: "enum_CellCheck")
                
                try managedObjectContext!.save()
            } catch {
                print("ERROR")
            }
    }
        
    
    override func tableView(_ tableView: UITableView, shouldHighlightRowAt indexPath: IndexPath) -> Bool {
        
        /**検索条件のDATE情報の取得とnilデータの排除**/
        let object = fetchedResultsController.object(at: indexPath)
        let cell_change_enable = object.cellTouchEnable
        if cell_change_enable == false {
            return false
        }
        
        return true
    }
    
    override func tableView(_ tableView: UITableView, editingStyleForRowAt indexPath: IndexPath) -> UITableViewCell.EditingStyle {
        if tableView.isEditing {
            return .delete
        }
        return .none
    }
    
    func configureCell(_ cell: UITableViewCell, withData Data: Past_Data) {
        
        cell.textLabel!.text = "UNCLEARED"
        
        if Data.enum_CellCheck == 0 {
            cell.textLabel!.text = "UNCLEARED"
        }else if Data.enum_CellCheck == 1 {
            cell.textLabel!.text = "Fail"
        }else if Data.enum_CellCheck == 2 {
            cell.textLabel!.text = "CLEARED"
        }else{
            cell.textLabel!.text = "「ERROR」 OR 「HUCKED NOW」"
        }
        
    }

    // MARK: - Fetched results controller

    var fetchedResultsController: NSFetchedResultsController<Past_Data> {
        if _fetchedResultsController != nil {
            return _fetchedResultsController!
        }
        
        let fetchRequest: NSFetchRequest<Past_Data> = Past_Data.fetchRequest()
        
        // バッチサイズを適切な数値に設定します。
        fetchRequest.fetchBatchSize = 20
        
        // 必要に応じてソートキーを編集します。
        let sortDescriptor = NSSortDescriptor(key: "day", ascending: false)
        
        fetchRequest.sortDescriptors = [sortDescriptor]
        
        // 必要に応じて、セクション名のキーパスとキャッシュ名を編集します。
        // セクション名キーパスのnilは「セクションなし」を意味します。
        let aFetchedResultsController = NSFetchedResultsController(fetchRequest: fetchRequest, managedObjectContext: self.managedObjectContext!, sectionNameKeyPath: nil, cacheName: "Master")
        aFetchedResultsController.delegate = self
        _fetchedResultsController = aFetchedResultsController
        
        do {
            try _fetchedResultsController!.performFetch()
        } catch {
             // この実装をコードに置き換えて、エラーを適切に処理します。
             // fatalError（）により、アプリケーションはクラッシュログを生成して終了します。 この機能は、開発中に役立つ場合がありますが、出荷アプリケーションでは使用しないでください。
             let nserror = error as NSError
             fatalError("Unresolved error \(nserror), \(nserror.userInfo)")
        }
        
        return _fetchedResultsController!
    }    
    var _fetchedResultsController: NSFetchedResultsController<Past_Data>? = nil

    func controllerWillChangeContent(_ controller: NSFetchedResultsController<NSFetchRequestResult>) {
        tableView.beginUpdates()
    }

    func controller(_ controller: NSFetchedResultsController<NSFetchRequestResult>, didChange sectionInfo: NSFetchedResultsSectionInfo, atSectionIndex sectionIndex: Int, for type: NSFetchedResultsChangeType) {
        switch type {
            case .insert:
                tableView.insertSections(IndexSet(integer: sectionIndex), with: .fade)
            case .delete:
                tableView.deleteSections(IndexSet(integer: sectionIndex), with: .fade)
            default:
                return
        }
    }

    func controller(_ controller: NSFetchedResultsController<NSFetchRequestResult>, didChange anObject: Any, at indexPath: IndexPath?, for type: NSFetchedResultsChangeType, newIndexPath: IndexPath?) {
        
        switch type {
            case .insert:
                tableView.insertRows(at: [newIndexPath!], with: .fade)
            case .delete:
                tableView.deleteRows(at: [indexPath!], with: .fade)
            case .update:
                configureCell(tableView.cellForRow(at: indexPath!)!, withData: anObject as! Past_Data)
            case .move:
                configureCell(tableView.cellForRow(at: indexPath!)!, withData: anObject as! Past_Data)
                tableView.moveRow(at: indexPath!, to: newIndexPath!)
            default:
                return
        }
    }

    func controllerDidChangeContent(_ controller: NSFetchedResultsController<NSFetchRequestResult>) {
        tableView.endUpdates()
    }

    /*
     // 個々の変更に応じてテーブルビューを更新するために上記のメソッドを実装すると、多数の変更が同時に行われる場合、パフォーマンスに影響する可能性があります。 これが問題であることが判明した場合は、代わりにすべてのセクションとオブジェクトの変更が処理されたことをデリゲートに通知するcontrollerDidChangeContent：を実装できます。
     
     func controllerDidChangeContent(controller: NSFetchedResultsController) {
         // In the simplest, most efficient, case, reload the table view.
         tableView.reloadData()
     }
     */
    
    // MARK: -DetailViewControllerクラスからのデータの遷移
    
    func send_data(data: cell_check) {
        title_changer_checker = data
        
        let A_data:NSNumber = NSNumber(value: data.rawValue)
        
        /**検索条件のDATE情報の取得とnilデータの排除**/
        let object = fetchedResultsController.object(at: cell_row_num!)
        let Date_DATA = object.day
        if (Date_DATA == nil) {
            return
        }
        /**検索条件のDATE情報の取得とnilデータの排除**/
        // 読み込むエンティティを指定
        let fetchRequest = NSFetchRequest<NSManagedObject>(entityName: "Past_Data")
        //条件指定
        fetchRequest.predicate = NSPredicate(format: "day == %@", Date_DATA! as CVarArg)
        
        do {
            if managedObjectContext == nil {
                return
            }
            
            let myResult = try managedObjectContext!.fetch(fetchRequest)
            
            let mydata = myResult[0]
            
            mydata.setValue(A_data, forKey: "enum_CellCheck")
            
            try managedObjectContext!.save()
        } catch {
            print("ERROR")
        }
    }
    
    // MARK:- popup用関数群
    
    // iPhoneで表示させる場合に必要
    func presentationController(forPresented presented: UIViewController, presenting: UIViewController?, source: UIViewController) -> UIPresentationController? {
        return CustomPresentationController(presentedViewController: presented, presenting: presenting)
    }
    
    private func makePopupView() {
        
        let storyBoard = UIStoryboard(name: "popup", bundle: nil)
        let PopupViewController = storyBoard.instantiateViewController(identifier: "popupViewController") as! popupViewController
        PopupViewController.modalPresentationStyle = .custom
        PopupViewController.transitioningDelegate = self
        PopupViewController.masterViewController = self
        present(PopupViewController, animated: true, completion: nil)
        
    }
    
    //Editが押された時
    @objc func tuppedEditButton() {
        makePopupView()
        
    }
    
    //Doneが押された時
    @objc func tuppedEdit_In_MasterVC(){
        print("tupped")
        create_EditButton()
        self.isEditing = false
    }
    
    private func create_EditButton(){
        let editButton = UIBarButtonItem(barButtonSystemItem: .edit, target: self, action: #selector(tuppedEditButton))
        navigationItem.leftBarButtonItem = editButton
    }
    
}

