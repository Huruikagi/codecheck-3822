import ceylon.http.server.websocket {
    WebSocketChannel
}


interface ChatMiddleware {

    shared formal Boolean interrupt(
        Set<WebSocketChannel> sockets,
        WebSocketChannel current,
        UserMessage userMessage
    );

}
