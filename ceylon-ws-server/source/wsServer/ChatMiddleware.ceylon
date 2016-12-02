import ceylon.http.server.websocket {
    WebSocketChannel
}


interface ChatMiddleware {

    shared formal void interrupt(
        Set<WebSocketChannel> sockets,
        WebSocketChannel current,
        String text
    );

}
