exports.javascript = (req, res) => {
    let returnVal = eval(req.body.code.replace("\\n", "\n"));
    res.send(returnVal);
};
