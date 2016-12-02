import ceylon.json {
    Object
}

"ユーザーに投げ返すためのJSONをラップするモデルクラス"
class ServerResponse(type, text, success) {
    String type;
    String text;
    Boolean success;

    shared String jsonString = Object {
        "type" -> type,
        "text" -> text,
        "success" -> success
    }.string;
}
