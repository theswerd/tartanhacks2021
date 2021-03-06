exports.upload = (req, res) => {
    let message = req.query.message || req.body.message || 'Deployment worked!';
    res.status(200).send(message);
  };
  