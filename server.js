var http = require("http");

const hostname = '::';
const port = 8888;

const prepareResponse = (_, res) => {
  res.statusCode = 200;
  res.setHeader('Content-Type', 'text/plain');
  res.write("Hello World. This page is running Node.js version: ");
  res.write(process.version);
  res.write('\n');
  res.end('Hello World\n');
}

const server = http.createServer(prepareResponse);
server.listen(port, hostname, () => {
  console.log(`Server running at http://${hostname}:${port}/`);
});

// http.createServer(function (request, response) {
//   response.writeHead(200, { "Content-Type": "text/plain" });
//   response.write("Hello World. This page is running Node.js version: ");
//   response.write(process.version);
//   response.end();
// }).listen(8888);
