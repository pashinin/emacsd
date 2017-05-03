# -*- Makefile -*-

EMACS = emacs

TEST_DIR = elisp
TRAVIS_FILE = .travis.yml
COMMONEL = elisp/init-common.el

# Compile with noninteractive and relatively clean environment.
BATCHFLAGS = -batch -q --no-site-file --debug-init

clean:
	find . -name '*.elc' -delete
# find ./elisp -name '*.elc' -delete

#${EMACS} -L elisp/extensions/workgroups2 -L elisp -L src -l ${COMMONEL} $(BATCHFLAGS) -f batch-byte-compile $(TEST_DIR)/*.el

compile:
	# emacs -batch -f batch-byte-compile *.el
	emacs -batch --eval '(byte-recompile-directory "~/.emacs.d/elpa")'

.PHONY: install
install:
	git submodule init
	git submodule update

test:
# just load all files
	${EMACS} -L elisp -L elisp/extensions $(BATCHFLAGS) -f batch-byte-compile elisp/init-packages.el
	${EMACS} -L elisp -L elisp/extensions $(BATCHFLAGS) -f batch-byte-compile init.el
#${EMACS} -L elisp/extensions/workgroups2 -L elisp -L src -l ${COMMONEL} $(BATCHFLAGS) -f batch-byte-compile $(TEST_DIR)/*.el

# TODO:
# test loading packages
# test packages versions
