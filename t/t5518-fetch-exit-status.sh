#!/bin/sh
#
# Copyright (c) 2008 Dmitry V. Levin
#

test_description='fetch exit status test'

GIT_TEST_DEFAULT_INITIAL_BRANCH_NAME=master
export GIT_TEST_DEFAULT_INITIAL_BRANCH_NAME

. ./test-lib.sh

test_expect_success setup '

	>file &&
	git add file &&
	git commit -m initial &&

	git checkout -b side &&
	echo side >file &&
	git commit -a -m side &&

	git checkout master &&
	echo next >file &&
	git commit -a -m next
'

test_expect_success 'non-fast-forward fetch' '

	test_must_fail git fetch . master:side

'

test_expect_success 'forced update' '

	git fetch . +master:side

'

test_done
