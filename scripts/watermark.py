from PIL import Image, ImageDraw, ImageFont
import sys, os

BOLD = "/usr/share/fonts/truetype/dejavu/DejaVuSans-Bold.ttf"
EMBER = (232, 68, 44)
BLACK = (20, 16, 16)
OFF = (242, 237, 228)
LINE = (51, 40, 33)

def add_watermark(path, out_path, bar_frac=0.09):
    im = Image.open(path).convert("RGB")
    W, H = im.size
    bar_h = max(56, int(H * bar_frac))
    new_im = Image.new("RGB", (W, H + bar_h), BLACK)
    new_im.paste(im, (0, 0))
    d = ImageDraw.Draw(new_im)
    d.line([(0, H), (W, H)], fill=EMBER, width=3)
    font_size = int(bar_h * 0.42)
    font = ImageFont.truetype(BOLD, font_size)
    text = "TRAP TO FIRE"
    tw = d.textlength(text, font=font)
    tx = (W - tw) / 2
    ty = H + (bar_h - font_size) / 2 - 4
    d.text((tx, ty), text, font=font, fill=OFF)
    # small flame glyph before text using ember dot as simple accent
    new_im.save(out_path, quality=92)

if __name__ == "__main__":
    add_watermark(sys.argv[1], sys.argv[2])
