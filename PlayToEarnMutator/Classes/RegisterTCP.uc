class RegisterTCP extends TcpLink;

var string PendingData;
var string UniqueID;

function SetUniqueID(string ID)
{
    UniqueID = ID;
}

event Resolved(IpAddr Addr)
{
    Addr.Port = 8000;
    BindPort();
    Open(Addr);
}

event Opened()
{
    local string Body, Request, CRLF;

    `log("[PTE-RegisterTCP] TCP Opened");

    CRLF = Chr(13) $ Chr(10);
    Body = "{\"uniqueid\": \"" $ UniqueID $ "\"}";

    Request = "POST /register HTTP/1.1" $ CRLF;
    Request $= "Host: 127.0.0.1:8000" $ CRLF;
    Request $= "Content-Type: application/json" $ CRLF;
    Request $= "From: killingfloor2" $ CRLF;
    Request $= "Content-Length: " $ Len(Body) $ CRLF;
    Request $= CRLF;
    Request $= Body;

    `log("[PTE-RegisterTCP] REQUEST SENDED:");
    `log(Request);

    SendText(Request);
}

event ReceivedText(string Text)
{
    `log("[PTE-RegisterTCP] MESSAGE RECEIVED:");
    `log(Text);
}

event ConnectionError(string Error)
{
    `log("[PTE-RegisterTCP] Connection error: " $ Error);
}

event ReceiveError(string Error)
{
    `log("[PTE-RegisterTCP] Receive error: " $ Error);
}

event Closed()
{
    `log("[PTE-RegisterTCP] TCP Connection closed!");
    Destroy();
}