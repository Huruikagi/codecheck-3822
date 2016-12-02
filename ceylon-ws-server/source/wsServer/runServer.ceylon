import ceylon.io {
    SocketAddress
}


"Run the module `wsServer`."
shared void runServer() {

    // サーバーの生成
    value server = ChatServer {
        chatPath = "/ws";
        middlewares = [

        ];
    };

    // サーバー起動
    server.open(SocketAddress("127.0.0.1", 3000));
}
