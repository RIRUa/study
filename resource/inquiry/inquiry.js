
/**
 * 
 * @param selectedValue selectで選択されたoptionの文字列
 * @author watanao
 * 
 * もし，selectedValueが未選択の「"not_chosen"」に変わったなら，未選択を選択できなくする．
 * 
 */

function changed_inquiryAbout( selectedValue ) {

    if (selectedValue != "not_chosen") {
        let not_allow = document.getElementById("not_chosen");
        not_allow.disabled = true;
    }

}

/**
 * 
 * @param void
 * @author watanao
 * 
 * 送信ボタンを押した時の処理
 * 
 * 
 */

function put_sendButton() {

    let accountName = document.getElementById("accountName");
    let value_accountName = accountName.value;

    if ( value_accountName == "" ) {
        alert("アカウント名を入力してください");
        return;
    }

    let inquiryAbout = document.getElementById("inquiryAbout");
    let value_from_inquiryAbout = inquiryAbout.value;

    if (value_from_inquiryAbout == "not_chosen") {

        /**　問い合わせ内容が選択されてない時　**/
        alert("お問い合わせ内容の種類を選択してください");
        return;
    }

    let inquiryDetail = document.getElementById("inquiryDetail");
    let value_from_inquiryDetail = inquiryDetail.value;

    if ( value_from_inquiryDetail == "" ) {
        /**　詳細に文字がなかったら　**/
        alert("詳細を入力してください");
        return;
    }

    switch ( value_from_inquiryAbout ) {
        case "Forced＿Closed":
            value_from_inquiryAbout = "強制終了された";
            break;

        case "clear_become_fail":
            value_from_inquiryAbout = "正解が不正解になった";
            break;

        case "fail_become_clear":
            value_from_inquiryAbout = "不正解が正解になった";
            break;

        case "not_response_by_button":
            value_from_inquiryAbout = "ボタンを押したが反応しない";

        case "other":
            value_from_inquiryAbout = "その他";

        case "unknown":
            value_from_inquiryAbout = "わからない";
    
        default:
            break;
    }

    /**　replace(置き換え前の文字列, 置き換え後の文字列) 
     * 
     *        / 文字 /g ・・・正規表現での指定．gのもじで全てという意味になる．
     * 
     **/

    value_from_inquiryDetail = value_from_inquiryDetail.replace(/\n/g,'%0D%0A　　　');

    if ( value_from_inquiryDetail.match(/\n/) != null ) {
        alert("改行文字が含まれているため表示できません");
    }

    location.href = "mailto:mathlearn.watanaocompany@gmail.com?subject=お問い合わせ&body=アカウント名：" + value_accountName + "%0D%0Aお問い合わせ理由：" + value_from_inquiryAbout + "%0D%0A詳細：" + value_from_inquiryDetail;
}