#!/usr/bin/env python3

# Thanks to Jacob Vlijim for this scripts
# Edited a bit by Ichirou2910 for easier customizing
# Source: https://askubuntu.com/questions/556723/make-a-text-file-my-automatically-updated-background

# Update 8 Feb 2020:
#   - You can use tab, define your tab so it will replace the "TAB" you enter
#   - Remove strip() when reading from file to be able to use tab

import subprocess
import os
import time

curr_dir = os.path.dirname(os.path.realpath(__file__))
curr_wall = curr_dir + "/" + "wallpaper.jpg"
notes = curr_dir + "/" + "notes.txt"

# -- CUSTOM PARAMETERS
shell = "/bin/zsh"              # your shell binary path, I use zsh

# font = "Comic-Sans-MS-Bold"     # execute convert -list font for possible font choices
font = "Choco-cooky"
text_color = "black"            # text color
size = "50"                     # text size (real size depends on the scale factor of your wallpaper)
tab = "    "                    # Imagemagick doesn't accept \t so just define it yourself
done = "×"                      # Completed mark. Use whatever you want.
borderX = 250                   # x offset
borderY = 350                   # y offset
columns = 1                     # (max) number of columns
n_lines = 18                    # (max) number of lines per column
set_bg_cmd = "feh --bg-scale "  # your command to change background goes here, but without the path to image
# --


def run_command(cmd):
    subprocess.call([shell, "-c", cmd])


def get_value(cmd):
    return subprocess.check_output([shell, "-c", cmd]).decode("utf-8").strip()


def read_text(file):
    with open(file) as src:
        if os.stat(file).st_size != 0:
            return [l.replace('\t', tab).replace("\\x", done) for l in src.readlines()]
        return ['(None)']


def slice_lines(lines, n_lines, columns):
    markers = [i for i in range(len(lines)) if i % n_lines == 0]
    last = len(lines)
    markers = markers + [last] if markers[-1] != last else markers
    textblocks = [lines[markers[i]:markers[i + 1]] for i in range(len(markers) - 1)]
    filled_blocks = len(textblocks)
    if filled_blocks < columns:
        for n in range(columns - filled_blocks):
            textblocks.insert(len(textblocks), [])
    for i in range(columns):
        textblocks[i] = ("").join(textblocks[i])
    return textblocks[:columns]


def create_section(psize, text, layer):
    print(text)
    run_command("convert -background none"
                + " -fill " + text_color
                + " -border " + str(borderX) + "x" + str(borderY)
                + " -bordercolor none"
                + " -pointsize " + size
                + " -size " + psize
                + " -font " + font
                + " caption:" + '"' + text + '" ' + layer)


# def combine_sections(layers):
#     run_command("convert " + image_1 +" " + image_2 + " " + "+append " + span_image)
#     pass


def set_overlay():
    boxes = slice_lines(read_text(notes), n_lines, columns)
    resolution = get_value('identify -format "%wx%h" ' + curr_wall).split("x")
    w = str(int(int(resolution[0]) / columns) - 2 * borderX)
    h = str(int(resolution[1]) - 2 * borderY)
    layers = []
    for i in range(len(boxes)):
        layer = curr_dir + "/" + "layer_" + str(i + 1) + ".png"
        create_section(w + "x" + h, boxes[i], layer)
        layers.append(layer)
    run_command("convert " + (" ").join(layers) + " " + "+append " + curr_dir + "/" + "layer_span.png")
    wall_img = curr_dir + "/" + "walltext.jpg"
    run_command("convert " + curr_wall + " " + curr_dir + "/" + "layer_span.png" + " -background None -layers merge " + wall_img)

    run_command(set_bg_cmd + wall_img)
    for img in [img for img in os.listdir(curr_dir) if img.startswith("layer_")]:
        os.remove(curr_dir + "/" + img)


while True:
    text_1 = read_text(notes)
    time.sleep(5)
    text_2 = read_text(notes)
    if text_2 != text_1:
        set_overlay()
