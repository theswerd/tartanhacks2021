const express = require('express');

const { filesUpload } = require('./middleware');


app = express();

app.get('/upload', filesUpload, function(req, res) {
  res.send('Alr now its express')
  // will contain all text fields
  // req.body 
  // // will contain an array of file objects
  // /*
  //   {
  //     fieldname: 'image',       String - name of the field used in the form
  //     originalname,             String - original filename of the uploaded image
  //     encoding,                 String - encoding of the image (e.g. "7bit")
  //     mimetype,                 String - MIME type of the file (e.g. "image/jpeg")
  //     buffer,                   Buffer - buffer containing binary data
  //     size,                     Number - size of buffer in bytes
  //   }
  // */
  // req.files 
})

exports = app;