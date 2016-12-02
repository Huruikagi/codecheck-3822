import ceylon.http.server {
    Server,
    newServer,
    startsWith,
    Endpoint,
    Request,
    Response
}
import ceylon.http.server.websocket {
    WebSocketChannel,
    WebSocketEndpoint,
    CloseReason
}
import ceylon.io { SocketAddress }
import ceylon.collection { HashSet }


"チャットのもろもろの処理を行うサーバー"
class ChatServer(chatPath, middlewares) {

    "WebSocketを待ち受けるパス"
    shared String chatPath;

    "間に咬ませる処理"
    ChatMiddleware[] middlewares;

    "現在接続中のソケット一覧"
    value channelPool = HashSet<WebSocketChannel>();

    "サーバー本体"
    Server httpServer = newServer {

        Endpoint {
            path = startsWith("/hello");
            void service(Request request, Response response)
                => response.writeString("Hello");
        },

        WebSocketEndpoint {
            path = startsWith(chatPath);

            // ソケットが開いたとき：チャンネルプールに追加
            void onOpen(WebSocketChannel channel)
                => channelPool.add(channel);

            // ソケットが閉じたとき：チャンネルプールから削除
            void onClose(WebSocketChannel channel, CloseReason closeReason)
                    => channelPool.remove(channel);

            // テキスト受信時
            void onText(WebSocketChannel channel, String text) {

                print("text: " + text);

                // クライアントから受信したJSON形式のテキストをパースする
                value userMessage = UserMessage(text);

                // ミドルウェアに処理を任せる
                for (middleware in middlewares) {
                    value complete = middleware.interrupt(channelPool, channel, userMessage);
                    print("complete: " + complete.string);
                    if (complete) { break; }
                }
            }
        }
    };


    "サーバーを起動するためのメソッド"
    shared void open(SocketAddress socketAddress) {
        httpServer.start(socketAddress);
    }

}
