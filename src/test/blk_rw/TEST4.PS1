#
# Copyright 2014-2016, Intel Corporation
# Copyright (c) 2016, Microsoft Corporation. All rights reserved.
#
# Redistribution and use in source and binary forms, with or without
# modification, are permitted provided that the following conditions
# are met:
#
#     * Redistributions of source code must retain the above copyright
#       notice, this list of conditions and the following disclaimer.
#
#     * Redistributions in binary form must reproduce the above copyright
#       notice, this list of conditions and the following disclaimer in
#       the documentation and/or other materials provided with the
#       distribution.
#
#     * Neither the name of the copyright holder nor the names of its
#       contributors may be used to endorse or promote products derived
#       from this software without specific prior written permission.
#
# THIS SOFTWARE IS PROVIDED BY THE COPYRIGHT HOLDERS AND CONTRIBUTORS
# "AS IS" AND ANY EXPRESS OR IMPLIED WARRANTIES, INCLUDING, BUT NOT
# LIMITED TO, THE IMPLIED WARRANTIES OF MERCHANTABILITY AND FITNESS FOR
# A PARTICULAR PURPOSE ARE DISCLAIMED. IN NO EVENT SHALL THE COPYRIGHT
# OWNER OR CONTRIBUTORS BE LIABLE FOR ANY DIRECT, INDIRECT, INCIDENTAL,
# SPECIAL, EXEMPLARY, OR CONSEQUENTIAL DAMAGES (INCLUDING, BUT NOT
# LIMITED TO, PROCUREMENT OF SUBSTITUTE GOODS OR SERVICES; LOSS OF USE,
# DATA, OR PROFITS; OR BUSINESS INTERRUPTION) HOWEVER CAUSED AND ON ANY
# THEORY OF LIABILITY, WHETHER IN CONTRACT, STRICT LIABILITY, OR TORT
# (INCLUDING NEGLIGENCE OR OTHERWISE) ARISING IN ANY WAY OUT OF THE USE
# OF THIS SOFTWARE, EVEN IF ADVISED OF THE POSSIBILITY OF SUCH DAMAGE.
#

#
# src\test\blk_rw\TEST4 -- unit test for pmemblk_read\write\set_zero\set_error
#
[CmdletBinding(PositionalBinding=$false)]
Param(
    [alias("d")]
    $DIR = ""
    )
$Env:UNITTEST_NAME = "blk_rw\TEST4"
$Env:UNITTEST_NUM = "4"


# standard unit test setup
. ..\unittest\unittest.ps1

# doesn't make sense to run in local directory
require_fs_type pmem non-pmem

setup

# write re-use test case
create_holey_file 1G $DIR\testfile1
expect_normal_exit $Env:EXE_DIR\blk_rw$Env:EXESUFFIX 512 $DIR\testfile1 c `
	w:0 w:1 w:2 w:3 w:4 r:4 r:3 r:2 r:1 r:0
expect_normal_exit $Env:EXE_DIR\blk_rw$Env:EXESUFFIX 512 $DIR\testfile1 o `
	w:0 r:4 r:3 r:2 r:1 r:0 w:0 r:0

check_pool $DIR\testfile1

check

