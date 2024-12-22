const path = require('path');

const publicDir = path.join(__dirname, 'public');
const productImagesDir = path.join(publicDir, 'product-images');

module.exports =
{
    publicDir,
    productImagesDir
}