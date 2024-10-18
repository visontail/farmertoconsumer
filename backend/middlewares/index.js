const authenticate = async (req, res) => {
    try {
        await req.jwtVerify();
    } catch (err) {
        res.send(err);
    }
}

module.exports = { authenticate }