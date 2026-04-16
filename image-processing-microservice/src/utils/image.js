import { Jimp } from "jimp";

export async function filterImageFromURL(inputURL) {
  try {
    const photo = await Jimp.read(inputURL);
    const outpath = "/tmp/filtered." + Math.floor(Math.random() * 2000) + ".jpg";
    const outputPhoto = await photo
      .resize({ w: 256, h: 256 })
      .greyscale()
      .write(outpath);
    return outpath;
  } catch (error) {
    console.error("Error processing image", error);
    throw error
  }

}
