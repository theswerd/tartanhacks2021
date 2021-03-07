exports.javascript = (req, res) => {
    try {
        let returnVal = eval(req.body.code.replace("\\n", "\n"));
        res.send(returnVal);

    } catch (error) {
        res.status(500).send(error);

    }
};
