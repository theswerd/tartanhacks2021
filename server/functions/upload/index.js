require("dotenv").config();
const express = require("express");
const { Storage } = require("@google-cloud/storage");

const { format } = require("util");
const multer = require("multer");

const fetch = require("node-fetch");
//const bodyParser = require("body-parser");

const upload = multer({
  storage: multer.memoryStorage(),
  limits: {
    fileSize: 10 * 1024 * 1024, // no larger than 10mb, you can change as needed.
  },
});
const storage = new Storage();
const bucket = storage.bucket("icodeassets");

const app = express();
const port = process.env.PORT ?? 3000;

app.get("/", (req, res) => {
  res.send("Operational");
});

app.post("/", upload.single("file"), (req, res) => {
  if (!req.file) {
    res.status(400).send("No file uploaded.");
    return;
  }

  var d = new Date();
  var n = d.getTime();
  // Create a new blob in the bucket and upload the file data.
  const blob = bucket.file(n.toString() + ".jpeg");
  const blobStream = blob.createWriteStream();
  blobStream.on("error", (err) => {
    res.status(500).send(err);
  });

  blobStream.on("finish", () => {
    const publicUrl = format(
      `https://storage.googleapis.com/icodeassets/${blob.name}`
    );
    fetch(
      "https://swerd.cognitiveservices.azure.com/vision/v3.1/read/analyze?language=en",
      {
        method: "POST",
        headers: {
          "Content-Type": "application/json",
          //TODO: ENVIRONMENTIZE
          "Ocp-Apim-Subscription-Key": "6d83436887804cf38765a1fe2f09fb7a",
        },
        
        body: {
          url: "http://35.190.38.218/"+blob.name,
        }.toString(),
      }
    ).then(async (response) => {
      if (response.status == 202) {
        res.send(response.headers);
      } else {
        res.status(501).send({
          headers: response.headers,
          status: response.status,
          body: await response.text(),
          imageURL: publicUrl,
        });
      }
    });
  });

  blobStream.end(req.file.buffer);
});

app.listen(port, () => {
  console.log(`Example app listening at http://localhost:${port}`);
});
