class Tag_a {
    constructor(title, fileName) {
        this.title = title;
        this.normalFile = fileName + ".html";
        this.spareFile = "../" + fileName　+ "/" + fileName + ".html";
    }
}


function makeheader() {
    /**
     * タイトルの作成
     */
    //<div id="pictPosition">の位置の入手
    const pictPosition = document.getElementById("pictPosition");

    //<img>の作成
    var imageElement = document.createElement("img");
    //imageElement.src = "header.png";                //画像の登録（スマホ用）
    imageElement.src = "../header.png";           //画像の登録（PC用）
    imageElement.alt = "headerPictuer";
    imageElement.onerror = function() {
        imageElement.src = "../header.png";
    }
    imageElement.width = 200;                   //サイズ調整

    //<a>の作成
    var aTag = document.createElement("a");
    aTag.href = "../index.html";                //パスの設定（PC用）
    //aTag.href = "index.html";                   //パスの設定（スマホ用）
    //<a><img></a>にするために登録
    aTag.appendChild(imageElement);
    
    /**
     *  <div>
     *      <a>
     *          <img>
     *      </a>
     *  </div>
     * にするために登録
     * **/
    pictPosition.appendChild(aTag);


    /**
     * 他ページへの遷移用テーブルの作成
    **/

    let title_array = ["お問い合わせ","プライバシーポリシー","制作理念","利用規約"];
    let name_array = ["inquiry","privacy_policy","production_philosophy","terms_of_service"];
    var fileArray = [];

    for (let i = 0; i < name_array.length; i++) {
        let file_aTag = new Tag_a(title_array[i],name_array[i]);
        fileArray.push(file_aTag);
    }

    //fileArray内の確認用
    /*
    fileArray.forEach(function(value,index){
        console.log(value.title + "   " + value.normalFile + "   " + value.spareFile);
    })
    */


    const tablePosi = document.getElementById("tablePosition");
    var table = document.createElement("table");

    table.id = "AccessTable";

    for (let i = 0; i < 2; i++) {
        table.insertRow();

        for (let j = 0; j < 2; j++) {
            let positionNum = 2*i+j;
            table.rows[i].insertCell();
            table.rows[i].cells[j].className = "cells";
            var a = document.createElement("a");
            a.text = fileArray[positionNum].title;

            /** 配信用 **/
            //a.href = fileArray[positionNum].normalFile;

            /** pcでの実験用 **/
            a.href = fileArray[positionNum].spareFile;


            table.rows[i].cells[j].appendChild(a);
        }
    }

    tablePosi.appendChild(table);
}

