Return-Path: <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>
X-Original-To: lists+linux-erofs@lfdr.de
Delivered-To: lists+linux-erofs@lfdr.de
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2404:9400:2:0:216:3eff:fee1:b9f1])
	by mail.lfdr.de (Postfix) with ESMTPS id 58BBF4C544D
	for <lists+linux-erofs@lfdr.de>; Sat, 26 Feb 2022 08:06:22 +0100 (CET)
Received: from boromir.ozlabs.org (localhost [IPv6:::1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4K5Hk341bLz3bcl
	for <lists+linux-erofs@lfdr.de>; Sat, 26 Feb 2022 18:06:19 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org;
	dkim=fail reason="signature verification failed" (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20210112 header.b=RAQEE4Sc;
	dkim-atps=neutral
X-Original-To: linux-erofs@lists.ozlabs.org
Delivered-To: linux-erofs@lists.ozlabs.org
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized)
 smtp.mailfrom=gmail.com (client-ip=2607:f8b0:4864:20::102a;
 helo=mail-pj1-x102a.google.com; envelope-from=jnhuang95@gmail.com;
 receiver=<UNKNOWN>)
Authentication-Results: lists.ozlabs.org; dkim=pass (2048-bit key;
 unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256
 header.s=20210112 header.b=RAQEE4Sc; dkim-atps=neutral
Received: from mail-pj1-x102a.google.com (mail-pj1-x102a.google.com
 [IPv6:2607:f8b0:4864:20::102a])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 4K5Hjs5jK0z3c9h
 for <linux-erofs@lists.ozlabs.org>; Sat, 26 Feb 2022 18:06:09 +1100 (AEDT)
Received: by mail-pj1-x102a.google.com with SMTP id d15so3318987pjg.1
 for <linux-erofs@lists.ozlabs.org>; Fri, 25 Feb 2022 23:06:10 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20210112;
 h=from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=4VZhjdRZzAxoLU5A7/ahKuJ/zBr6PkQC/UsYuDOEIK0=;
 b=RAQEE4Sc2WvxaX4GhmoGgkuxT70Dr4X41LYnChZb2VHkp81QXRLGmY4SsBbHq1yuy6
 VJLybtUkxlfvNVYJlTJTMkzA00Zeu/gVqsSNHWeKas4BYkEEMbx4FqJWnivSnP2EY80v
 Z7uWk0j/4o2ZaAVAdY9uKegR8Ku8/XRQw1HUFw3a9cqw8sB+kHHuU3kWtlEg5vmhZ4Ko
 BM32kiwG3NHqe6mglJaaX0bn0mj+LrNEdEaDX8zwdmYViIiDXqBoXpbi/PTAtzSTNbTX
 qXstwjqIVojZ8vh2p/LLnA6pSyEUKvyyNlrDo7sUR/UsU/at8Gk1a3y94EAjA0SDFN8Y
 CbWQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=4VZhjdRZzAxoLU5A7/ahKuJ/zBr6PkQC/UsYuDOEIK0=;
 b=vh+MEPSIz7Ouu/Dt6iPUbqR8sKaqobyF+71ouoaJlgAT+VdvF3cQ7KW5g82NIaom/o
 p3NHWj0NksycetuAb3pCwRcvbCEjCopWzvE8PhlMLhsGveKMi6qCYstUhvkPQFcz3gmZ
 yhy5asHxnzgAY3OqnnA2NUFGn37SjxHD9QQh1QOr+lV9hcp1++T1Q829jpmxBdyWV2dn
 amsBzN+qh/o0k6YpUTA6ngwZNk2fCZFeM0cuBsyQGPYzse38ub8TR8beHWUyIMCDO78N
 3fWp9+R2fE6PhMzlLZV1PAYadmNGPSKaEhFUHdtlBkfVLoDVSxBXfGw26CDjN7RAueyT
 g6og==
X-Gm-Message-State: AOAM5316JpDl8KQA4P9MYBGouEygH1UMhcS+013WYK1EWiK5v0+61UwG
 9QihDlKPL8nL+IdIxwiNXjo=
X-Google-Smtp-Source: ABdhPJyzX/5UJUNBLH8fi78AIZ8MYR4aL4rdS/7OAj0X+ufSsRxYqFqzKZ7Q9X6SkKthWT78mIYyEA==
X-Received: by 2002:a17:903:22c6:b0:14d:8a9b:a9ad with SMTP id
 y6-20020a17090322c600b0014d8a9ba9admr11067093plg.141.1645859168232; 
 Fri, 25 Feb 2022 23:06:08 -0800 (PST)
Received: from hjn-PC.localdomain (li1080-207.members.linode.com.
 [45.33.61.207]) by smtp.gmail.com with ESMTPSA id
 e20-20020a17090ab39400b001bc4f9ad3cbsm11044489pjr.3.2022.02.25.23.06.06
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 25 Feb 2022 23:06:07 -0800 (PST)
From: Huang Jianan <jnhuang95@gmail.com>
To: u-boot@lists.denx.de,
	trini@konsulko.com
Subject: [PATCH v4 5/5] test/py: Add tests for the erofs
Date: Sat, 26 Feb 2022 15:05:51 +0800
Message-Id: <20220226070551.9833-6-jnhuang95@gmail.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20220226070551.9833-1-jnhuang95@gmail.com>
References: <20220226070551.9833-1-jnhuang95@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-BeenThere: linux-erofs@lists.ozlabs.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: Development of Linux EROFS file system <linux-erofs.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linux-erofs>,
 <mailto:linux-erofs-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linux-erofs/>
List-Post: <mailto:linux-erofs@lists.ozlabs.org>
List-Help: <mailto:linux-erofs-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linux-erofs>,
 <mailto:linux-erofs-request@lists.ozlabs.org?subject=subscribe>
Cc: linux-erofs@lists.ozlabs.org
Errors-To: linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org
Sender: "Linux-erofs"
 <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>

Add Python scripts to test 'ls' and 'load' commands, as well as
test related filesystem functions.

Signed-off-by: Huang Jianan <jnhuang95@gmail.com>
---
 MAINTAINERS                         |   1 +
 configs/sandbox_defconfig           |   1 +
 test/py/tests/test_fs/test_erofs.py | 211 ++++++++++++++++++++++++++++
 tools/docker/Dockerfile             |   1 +
 4 files changed, 214 insertions(+)
 create mode 100644 test/py/tests/test_fs/test_erofs.py

diff --git a/MAINTAINERS b/MAINTAINERS
index bd8835619e..e1c6b986f0 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -815,6 +815,7 @@ S:	Maintained
 F:	cmd/erofs.c
 F:	fs/erofs/
 F:	include/erofs.h
+F:	test/py/tests/test_fs/test_erofs.py
 
 FASTBOOT
 S:	Orphaned
diff --git a/configs/sandbox_defconfig b/configs/sandbox_defconfig
index 7ebeb89264..47fd33e8bc 100644
--- a/configs/sandbox_defconfig
+++ b/configs/sandbox_defconfig
@@ -105,6 +105,7 @@ CONFIG_CMD_TPM_TEST=y
 CONFIG_CMD_BTRFS=y
 CONFIG_CMD_CBFS=y
 CONFIG_CMD_CRAMFS=y
+CONFIG_CMD_EROFS=y
 CONFIG_CMD_EXT4_WRITE=y
 CONFIG_CMD_SQUASHFS=y
 CONFIG_CMD_MTDPARTS=y
diff --git a/test/py/tests/test_fs/test_erofs.py b/test/py/tests/test_fs/test_erofs.py
new file mode 100644
index 0000000000..458a52ba79
--- /dev/null
+++ b/test/py/tests/test_fs/test_erofs.py
@@ -0,0 +1,211 @@
+# SPDX-License-Identifier: GPL-2.0+
+# Copyright (C) 2022 Huang Jianan <jnhuang95@gmail.com>
+# Author: Huang Jianan <jnhuang95@gmail.com>
+
+import os
+import pytest
+import shutil
+import subprocess
+
+EROFS_SRC_DIR = 'erofs_src_dir'
+EROFS_IMAGE_NAME = 'erofs.img'
+
+def generate_file(name, size):
+    """
+    Generates a file filled with 'x'.
+    """
+    content = 'x' * size
+    file = open(name, 'w')
+    file.write(content)
+    file.close()
+
+def make_erofs_image(build_dir):
+    """
+    Makes the EROFS images used for the test.
+
+    The image is generated at build_dir with the following structure:
+    erofs_src_dir/
+    ├── f4096
+    ├── f7812
+    ├── subdir/
+    │   └── subdir-file
+    ├── symdir -> subdir
+    └── symfile -> f5096
+    """
+    root = os.path.join(build_dir, EROFS_SRC_DIR)
+    os.makedirs(root)
+
+    # 4096: uncompressed file
+    generate_file(os.path.join(root, 'f4096'), 4096)
+
+    # 7812: Compressed file
+    generate_file(os.path.join(root, 'f7812'), 7812)
+
+    # sub-directory with a single file inside
+    subdir_path = os.path.join(root, 'subdir')
+    os.makedirs(subdir_path)
+    generate_file(os.path.join(subdir_path, 'subdir-file'), 100)
+
+    # symlink
+    os.symlink('subdir', os.path.join(root, 'symdir'))
+    os.symlink('f7812', os.path.join(root, 'symfile'))
+
+    input_path = os.path.join(build_dir, EROFS_SRC_DIR)
+    output_path = os.path.join(build_dir, EROFS_IMAGE_NAME)
+    args = ' '.join([output_path, input_path])
+    subprocess.run(['mkfs.erofs -zlz4 ' + args], shell=True, check=True,
+                   stdout=subprocess.DEVNULL)
+
+def clean_erofs_image(build_dir):
+    """
+    Deletes the image and src_dir at build_dir.
+    """
+    path = os.path.join(build_dir, EROFS_SRC_DIR)
+    shutil.rmtree(path)
+    image_path = os.path.join(build_dir, EROFS_IMAGE_NAME)
+    os.remove(image_path)
+
+def erofs_ls_at_root(u_boot_console):
+    """
+    Test if all the present files and directories were listed.
+    """
+    no_slash = u_boot_console.run_command('erofsls host 0')
+    slash = u_boot_console.run_command('erofsls host 0 /')
+    assert no_slash == slash
+
+    expected_lines = ['./', '../', '4096   f4096', '7812   f7812', 'subdir/',
+                      '<SYM>   symdir', '<SYM>   symfile', '4 file(s), 3 dir(s)']
+
+    output = u_boot_console.run_command('erofsls host 0')
+    for line in expected_lines:
+        assert line in output
+
+def erofs_ls_at_subdir(u_boot_console):
+    """
+    Test if the path resolution works.
+    """
+    expected_lines = ['./', '../', '100   subdir-file', '1 file(s), 2 dir(s)']
+    output = u_boot_console.run_command('erofsls host 0 subdir')
+    for line in expected_lines:
+        assert line in output
+
+def erofs_ls_at_symlink(u_boot_console):
+    """
+    Test if the symbolic link's target resolution works.
+    """
+    output = u_boot_console.run_command('erofsls host 0 symdir')
+    output_subdir = u_boot_console.run_command('erofsls host 0 subdir')
+    assert output == output_subdir
+
+    expected_lines = ['./', '../', '100   subdir-file', '1 file(s), 2 dir(s)']
+    for line in expected_lines:
+        assert line in output
+
+def erofs_ls_at_non_existent_dir(u_boot_console):
+    """
+    Test if the EROFS support will crash when get a nonexistent directory.
+    """
+    out_non_existent = u_boot_console.run_command('erofsls host 0 fff')
+    out_not_dir = u_boot_console.run_command('erofsls host 0 f1000')
+    assert out_non_existent == out_not_dir
+    assert '' in out_non_existent
+
+def erofs_load_files(u_boot_console, files, sizes, address):
+    """
+    Loads files and asserts their checksums.
+    """
+    build_dir = u_boot_console.config.build_dir
+    for (file, size) in zip(files, sizes):
+        out = u_boot_console.run_command('erofsload host 0 {} {}'.format(address, file))
+
+        # check if the right amount of bytes was read
+        assert size in out
+
+        # calculate u-boot file's checksum
+        out = u_boot_console.run_command('md5sum {} {}'.format(address, hex(int(size))))
+        u_boot_checksum = out.split()[-1]
+
+        # calculate original file's checksum
+        original_file_path = os.path.join(build_dir, EROFS_SRC_DIR + '/' + file)
+        out = subprocess.run(['md5sum ' + original_file_path], shell=True, check=True,
+                             capture_output=True, text=True)
+        original_checksum = out.stdout.split()[0]
+
+        # compare checksum
+        assert u_boot_checksum == original_checksum
+
+def erofs_load_files_at_root(u_boot_console):
+    """
+    Test load file from the root directory.
+    """
+    files = ['f4096', 'f7812']
+    sizes = ['4096', '7812']
+    address = '$kernel_addr_r'
+    erofs_load_files(u_boot_console, files, sizes, address)
+
+def erofs_load_files_at_subdir(u_boot_console):
+    """
+    Test load file from the subdirectory.
+    """
+    files = ['subdir/subdir-file']
+    sizes = ['100']
+    address = '$kernel_addr_r'
+    erofs_load_files(u_boot_console, files, sizes, address)
+
+def erofs_load_files_at_symlink(u_boot_console):
+    """
+    Test load file from the symlink.
+    """
+    files = ['symfile']
+    sizes = ['7812']
+    address = '$kernel_addr_r'
+    erofs_load_files(u_boot_console, files, sizes, address)
+
+def erofs_load_non_existent_file(u_boot_console):
+    """
+    Test if the EROFS support will crash when load a nonexistent file.
+    """
+    address = '$kernel_addr_r'
+    file = 'non-existent'
+    out = u_boot_console.run_command('erofsload host 0 {} {}'.format(address, file))
+    assert 'Failed to load' in out
+
+def erofs_run_all_tests(u_boot_console):
+    """
+    Runs all test cases.
+    """
+    erofs_ls_at_root(u_boot_console)
+    erofs_ls_at_subdir(u_boot_console)
+    erofs_ls_at_symlink(u_boot_console)
+    erofs_ls_at_non_existent_dir(u_boot_console)
+    erofs_load_files_at_root(u_boot_console)
+    erofs_load_files_at_subdir(u_boot_console)
+    erofs_load_files_at_symlink(u_boot_console)
+    erofs_load_non_existent_file(u_boot_console)
+
+@pytest.mark.boardspec('sandbox')
+@pytest.mark.buildconfigspec('cmd_fs_generic')
+@pytest.mark.buildconfigspec('cmd_erofs')
+@pytest.mark.buildconfigspec('fs_erofs')
+@pytest.mark.requiredtool('mkfs.erofs')
+@pytest.mark.requiredtool('md5sum')
+
+def test_erofs(u_boot_console):
+    """
+    Executes the erofs test suite.
+    """
+    build_dir = u_boot_console.config.build_dir
+
+    try:
+        # setup test environment
+        make_erofs_image(build_dir)
+        image_path = os.path.join(build_dir, EROFS_IMAGE_NAME)
+        u_boot_console.run_command('host bind 0 {}'.format(image_path))
+        # run all tests
+        erofs_run_all_tests(u_boot_console)
+    except:
+        clean_erofs_image(build_dir)
+        raise AssertionError
+
+    # clean test environment
+    clean_erofs_image(build_dir)
diff --git a/tools/docker/Dockerfile b/tools/docker/Dockerfile
index 7a3f5cbade..8e7a4a7072 100644
--- a/tools/docker/Dockerfile
+++ b/tools/docker/Dockerfile
@@ -48,6 +48,7 @@ RUN apt-get update && apt-get install -y \
 	dosfstools \
 	e2fsprogs \
 	efitools \
+	erofs-utils \
 	expect \
 	fakeroot \
 	flex \
-- 
2.25.1

