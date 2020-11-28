function accessToComsMailAddress() {

    //メールアドレス
    let mailAddress = "mathlearn.watanaocompany@gmail.com";

    // 件名
    let subject = "お問い合わせ";
    // 本文
    let body = "アカウント名：%0D%0AアカウントID：%0D%0A問い合わせ内容の種類：%0D%0A詳細：";
    
    let target = document.getElementById("askSomeQuestion");

    target.href = "mailto:" + mailAddress + "?subject=" + subject + "&body=" + body;

}