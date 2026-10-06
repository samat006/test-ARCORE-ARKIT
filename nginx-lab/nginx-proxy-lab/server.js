const http = require("http");

const server = http.createServer((req, res) => {
    res.writeHead(200, {
        "Content-Type": "text/plain"
    });

    res.end("Bonjour ! Je suis l'application backend.\n");
});

server.listen(3000, () => {
    console.log("Backend écoute sur le port 3000");
});