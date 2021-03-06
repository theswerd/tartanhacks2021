require("dotenv").config();
const express = require("express");
const { Storage } = require("@google-cloud/storage");

const { format } = require("util");
const multer = require('multer');
)
const bodyParser = require("body-parser");

const upload = multer({
  storage: multer.memoryStorage(),
  limits: {
    fileSize: 10 * 1024 * 1024, // no larger than 10mb, you can change as needed.
  },
});
const storage = new Storage();
const bucket = storage.bucket("albums");

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

  // Create a new blob in the bucket and upload the file data.
  const blob = bucket.file(Date() + ".jpeg");
  const blobStream = blob.createWriteStream();
  blobStream.on("error", (err) => {
    res.status(500).send(err);
  });

  blobStream.on("finish", () => {
    // The public URL can be used to directly access the file via HTTP.
    const publicUrl = format(
      `https://storage.googleapis.com/icodeassets/${blob.name}`
    );
    res.send(publicUrl);
  });

  blobStream.end(req.file.buffer);
});

app.listen(port, () => {
  console.log(`Example app listening at http://localhost:${port}`);
});
