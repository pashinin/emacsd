#!/usr/bin/env python
# -*- coding: utf-8 -*-

import os, sys, re
import mutagen
import argparse
from mutagen.mp3 import MP3
from mutagen.id3 import ID3
from mutagen.easyid3 import EasyID3

if __name__ == "__main__":
    # PARSE ARGS
    parser = argparse.ArgumentParser(description='Remove tags that can contain garbage.')
    parser.add_argument('filename', help="MP3 file to clean")
    args = parser.parse_args()

    filename = args.filename

    try:
        audio = MP3(filename)
        #print audio.pprint()
        for k in ["TCOP", "TENC", "WCOM", "WCOP", "WOAF", "WOAR",
                  "WOAS", "WORS", "WPAY", "WPUB", "WXXX"]:
            if k in audio: del(audio[k])
        audio.save()
    except:
        print "Error"
    #else:
    #    audio.save()
