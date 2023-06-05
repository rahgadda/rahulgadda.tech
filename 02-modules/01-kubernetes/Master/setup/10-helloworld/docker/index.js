const express = require("express");
require("dotenv").config();

const app = express();
const port = process.env.PORT || 3000;
const url_path = process.env.URL_PATH || "helloworld";

app.get(`/${url_path}`, (request, response) => {
    if (request.headers['accept'] === "application/json"){
        response.setHeader('Content-Type', 'application/json');
        response.send(JSON.stringify({message:"hello-world"}));
    }else{
        response.setHeader('Content-Type', 'text/plain');
        response.send('Hello World!');
    } 
});

app.listen(port, () => {
  console.log(`Server is running on the port ${port} and URL /${url_path}`);
});