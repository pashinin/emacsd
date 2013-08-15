# -*- Makefile -*-

EMACS = emacs

TEST_DIR = elisp
TRAVIS_FILE = .travis.yml
COMMONEL = elisp/init-common.el

# Compile with noninteractive and relatively clean environment.
BATCHFLAGS = -batch -q --no-site-file

clean:
	find . -name "*.elc" -exec rm -rf {} \;

compile:
	${EMACS} -L elisp/extensions/workgroups2 -L elisp -L src -l ${COMMONEL} $(BATCHFLAGS) -f batch-byte-compile $(TEST_DIR)/*.el

test:
	${EMACS} -L elisp/extensions/workgroups2 -L elisp -L src -l ${COMMONEL} $(BATCHFLAGS) -f batch-byte-compile $(TEST_DIR)/*.el

# TODO:
# test loading packages
# test packages versions
