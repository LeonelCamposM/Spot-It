const express = require("express");
const http = require("http");

const app = express();
const port = process.env.PORT || 3000;
var server = http.createServer(app);
var socket_io = require("socket.io")(server);

app.use(express.json());

socket_io.on("connection", (socket) => {
    console.log("connected!");
    socket.on("createRoom", async ({ userName }) => {
        console.log(userName);
    });
});
    
server.listen(port, "0.0.0.0", () => {
    console.log(`Server started and running on port ${port}`);
});
