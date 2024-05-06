import pywal
import argparse

def main():
    parser = argparse.ArgumentParser()
    parser.add_argument('-cache-dir', type=str, help="cache directory", default="/home/camel/.cache/wal/")
    parser.add_argument('-image', type=str, help="image directory")
    parser.add_argument('-template', type=str, help="template name")
    parser.add_argument('-alpha', type=str, default="100")
    args = parser.parse_args()

    template_dir = "/home/camel/.config/wal/templates/"

    pywal.util.Color.alpha_num = "70"
    colors = pywal.colors.get(img=args.image, cache_dir=args.cache_dir)
    pywal.export.color(colors, f"{template_dir}{args.template}", f"{args.cache_dir}{args.template}")

main()
