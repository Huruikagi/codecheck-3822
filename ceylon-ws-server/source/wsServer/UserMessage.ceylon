import ceylon.json {
    parse,
    Object
}


"ユーザーから送信されたメッセージをラップするモデルクラス"
class UserMessage(String text) {

    value parsedJson = parse(text);

    print("AAA");

    value msg = if (is Object parsedJson) then parsedJson["text"] else "";

    shared String body = if (is String msg) then msg else "";

}
