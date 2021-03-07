exports.javascript = (req, res) => {
    res.send(req.body.replace("\\n", "\n"));
};
