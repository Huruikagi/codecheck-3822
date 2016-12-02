import ceylon.json {
    parse,
    Object
}


"ユーザーから送信されたメッセージをラップするモデルクラス"
class UserMessage(String text) {

    print("A");

    value parsedJson = parse(text);

    assert(is Object parsedJson, is String msg = parsedJson["text"]);

    shared String body = msg;

    print("B");
}
