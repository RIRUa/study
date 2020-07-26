//
//  MasterViewController.swift
//  study
//
//  Created by 渡辺奈央騎 on 2020/07/20.
//  Copyright © 2020 渡辺奈央騎. All rights reserved.
//

import UIKit
import CoreData

class MasterViewController: UITableViewController, NSFetchedResultsControllerDelegate, send_any_data {

    var detailViewController: DetailViewController? = nil
    var managedObjectContext: NSManagedObjectContext? = nil
    
    
    private static var persistentContainer: NSPersistentContainer! = (UIApplication.shared.delegate as? AppDelegate)?.persistentContainer
    
    /**セルのタイトルを変えるか確認するcell_check値**/
    var title_changer_checker:cell_check = .None
    
    /**セルに対するクリアしたかどうかの情報を保存する配列**/
    var data_of_cells_cellcheck:[cell_check] = []
    var data_of_cells_PastDatas:[Past_Datas] = []
    
    /**セルの数字を保存**/
    var cell_row_num : IndexPath?
    

    override func viewDidLoad() {
        super.viewDidLoad()
        
        data_of_cells_PastDatas = get_All_PastDatas()
        delete_PastData(datas: data_of_cells_PastDatas)
        
        // Do any additional setup after loading the view.
        navigationItem.leftBarButtonItem = editButtonItem
        let addButton = UIBarButtonItem(barButtonSystemItem: .add, target: self, action: #selector(insertNewObject(_:)))
        navigationItem.rightBarButtonItem = addButton
        /**detailViewController変数にDetailViewControllerクラスを代入**/
        if let split = splitViewController {
            let controllers = split.viewControllers
            detailViewController = (controllers[controllers.count-1] as! UINavigationController).topViewController as? DetailViewController
        }
    }

    override func viewWillAppear(_ animated: Bool) {
        
        var cell:UITableViewCell
        
        if cell_row_num != nil {
            cell = tableView.cellForRow(at: cell_row_num!)!
            
            if title_changer_checker == .Clear {
                cell.textLabel?.text = "Cleared"
                data_of_cells_cellcheck[cell_row_num!.row] = .Clear
                title_changer_checker = .None
            }
            
        }
        
        print("\(data_of_cells_cellcheck)")
        
        save()
        
        /**DetailViewControllerから戻った時に呼ばれる**/
        clearsSelectionOnViewWillAppear = splitViewController!.isCollapsed
        super.viewWillAppear(animated)
    }

    @objc
    func insertNewObject(_ sender: Any) {
        let context = self.fetchedResultsController.managedObjectContext
        let newEvent = Event(context: context)
             
        // If appropriate, configure the new managed object.
        newEvent.timestamp = Date()

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
                next_controller.bool_sender = self
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
        let event = fetchedResultsController.object(at: indexPath)
        
        data_of_cells_cellcheck.insert(.None, at: 0)
        
        configureCell(cell, withEvent: event)
        
        print("\(indexPath.row)")
        
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
            
            /**自作部分**/
            
            data_of_cells_cellcheck.remove(at: indexPath.row)
            
            /**自作部分終了**/
            
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
        let cell = tableView.cellForRow(at: indexPath)
        cell?.textLabel?.text = "Chosen"
        
    }

    func configureCell(_ cell: UITableViewCell, withEvent event: Event) {
        
        cell.textLabel!.text = "UNCLEARED"
        
    }

    // MARK: - Fetched results controller

    var fetchedResultsController: NSFetchedResultsController<Event> {
        if _fetchedResultsController != nil {
            return _fetchedResultsController!
        }
        
        let fetchRequest: NSFetchRequest<Event> = Event.fetchRequest()
        
        // バッチサイズを適切な数値に設定します。
        fetchRequest.fetchBatchSize = 20
        
        // 必要に応じてソートキーを編集します。
        let sortDescriptor = NSSortDescriptor(key: "timestamp", ascending: false)
        
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
    var _fetchedResultsController: NSFetchedResultsController<Event>? = nil

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
                configureCell(tableView.cellForRow(at: indexPath!)!, withEvent: anObject as! Event)
            case .move:
                configureCell(tableView.cellForRow(at: indexPath!)!, withEvent: anObject as! Event)
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
    
    func send_bool(data: cell_check) {
        title_changer_checker = data
    }
    
    
    // MARK: - Core Data stack
    
    func new_PastDatas() -> Past_Datas {
        let context = MasterViewController.persistentContainer.viewContext
        
        let a_past_data = NSEntityDescription.insertNewObject(forEntityName: "Past_Datas", into: context) as! Past_Datas
        
        return a_past_data
    }
    
    func save(){
        MasterViewController.persistentContainer.saveContext()
    }
    
    func get_All_PastDatas()->[Past_Datas]{
        let context = MasterViewController.persistentContainer.viewContext
        let request = NSFetchRequest<NSFetchRequestResult>(entityName: "Past_Datas")
        
        do {
            let past_datas:[Past_Datas] = try context.fetch(request) as! [Past_Datas]
            
            for data in past_datas {
                self.data_of_cells_cellcheck.append(CoreData_to_enumCell(data: data))
            }
            
            return past_datas
            
        } catch  {
            fatalError()
        }
    }
    
    func delete_PastData(datas: [Past_Datas]) {
        
        let context = MasterViewController.persistentContainer.viewContext
        
        for data in datas {
            context.delete(data)
        }
        
    }
    
}

