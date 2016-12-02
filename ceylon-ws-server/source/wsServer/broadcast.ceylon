import ceylon.http.server.websocket {
    WebSocketChannel
}


"ユーザーから受け取ったメッセージを接続中の全チャンネルにブロードキャストします。"
object broadcast satisfies ChatMiddleware {

    shared actual Boolean interrupt(Set<WebSocketChannel> sockets, WebSocketChannel current, UserMessage userMessage) {

        // 返却用のメッセージを生成
        value response = ServerResponse("message", userMessage.body, true);

        // 接続中の各チャンネルにメッセージを転送
        sockets.each((WebSocketChannel channel) => channel.sendText(response.jsonString));

        // 最終手段なので常にtrueを返却する
        return true;
    }

}
