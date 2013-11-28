Kata Challenge
==

These two scripts are based upon [this blog post](http://codekata.pragprog.com/2007/01/kata_eight_conf.html) here.

Both scripts accept the following flags:

* `-d` or `--dictionary`: The path to the dictionary on the system.
* `-w` or `--word-length`: The length of word to search for concatenations from.

The threaded script accepts the following additional flag:

* `-t` or `--threads`: The number of threads to use.

Dictionaries
-

On OS X systems, a full dictionary can be found here `/usr/share/dict/web2`. The small example dictionary from the blog post can be found inside `dictionaries/kata`.