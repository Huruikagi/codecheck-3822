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
    server.open(SocketAddress("ec2-54-147-114-181.compute-1.amazonaws.com", 3000));
}
