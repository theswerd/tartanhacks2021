exports.javascript = (req, res) => {
    res.send(req.body.code.replace("\\n", "\n"));
};
