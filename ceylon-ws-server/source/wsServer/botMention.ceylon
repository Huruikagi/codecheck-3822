import ceylon.http.server.websocket { WebSocketChannel }
import ceylon.regex { regex }


object botMention satisfies ChatMiddleware {

    // ボットに対するメンションとして認識するやつの正規表現
    value botExpressions = [
        regex("^bot[ |　]"),
        regex("^@bot[ |　]"),
        regex("^bot:")
    ];


    shared actual Boolean interrupt(Set<WebSocketChannel> sockets, WebSocketChannel current, UserMessage userMessage) {

        // 各正規表現毎にテストを行う
        for (exp in botExpressions) {

            // 正規表現に一致するかどうか
            if (exp.test(userMessage.body)) {
                // 一致した場合
                // メッセージからコマンド部分を取り出す
                value command = exp.replace(userMessage.body, "");

                // TODO ここに埋め込まない
                if (command == "ping") {
                    // pingコマンド

                    // レスポンスを生成
                    value serverResponse = ServerResponse("bot", "pong", true);

                    // pongをブロードキャスト
                    sockets.each((WebSocketChannel channel) => channel.sendText(serverResponse.jsonString));

                    // このメッセージに対する処理完了
                    return false;

                } else {
                    // 未知のコマンドだった場合
                    value serverResponse = ServerResponse("bot", "unknown command", false);
                    current.sendText(serverResponse.jsonString);
                    return false;
                }
            }
        }

        // ヒットしなかったのでブロードキャストに投げる
        return false;
    }

}
