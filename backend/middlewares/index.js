const authenticate = async (req, res) => {
    try {
        await req.jwtVerify();
    } catch (err) {
        res.status(401).send({ message: "Unauthorized" });
    }
}

module.exports = { authenticate }