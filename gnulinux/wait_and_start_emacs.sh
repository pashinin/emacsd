#!/bin/sh
sleep 2
/usr/local/bin/emacsclient -c -a "" -F "((fullscreen . maximized))" -e "(run-with-timer 0.1 nil 'load-workgroups-if-needed)"
