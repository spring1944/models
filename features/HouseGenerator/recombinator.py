from os import listdir
from os.path import isfile, join
from PIL import Image, ImageOps
import itertools


def get_image_names(prefix):
    return [f for f in listdir('./') \
        if f.startswith(prefix) and isfile(join('./', f))]


# Load the base image
im = Image.open('base.png')
im_spec = Image.open('base_specular.png')
im_norm = Image.open('base_normal.png')

# Setup the image files combinational list
raw = []
prefixes = ['1stcorner.', 'facade.', 'roof.', 'shop.']
for prefix in prefixes:
    raw.append(get_image_names(prefix))
combs = list(itertools.product(*raw))

# Combine images and save them
for i,comb in enumerate(combs):
    fpath = '../FeaturesHouse_{:03d}.png'.format(i + 1)
    new = im.copy()
    for img_path in comb:
        add = Image.open(img_path)
        new.paste(add, (0,0), add)
    new.save(fpath)
    fpath = '../FeaturesHouseSpecular_{:03d}.png'.format(i + 1)
    new = im_spec.copy()
    for img_path in comb:
        add = Image.open(img_path[:-8] + '_specular' + img_path[-8:])
        new.paste(add, (0,0), add)
    new.save(fpath)
    fpath = '../FeaturesHouseNormal_{:03d}.png'.format(i + 1)
    new = im_norm.copy()
    for img_path in comb:
        add = Image.open(img_path[:-8] + '_normal' + img_path[-8:])
        new.paste(add, (0,0), add)
    new = ImageOps.flip(new)
    new.save(fpath)
