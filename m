Return-Path: <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>
X-Original-To: lists+linux-erofs@lfdr.de
Delivered-To: lists+linux-erofs@lfdr.de
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2404:9400:2:0:216:3eff:fee1:b9f1])
	by mail.lfdr.de (Postfix) with ESMTPS id 564264ADAC8
	for <lists+linux-erofs@lfdr.de>; Tue,  8 Feb 2022 15:05:53 +0100 (CET)
Received: from boromir.ozlabs.org (localhost [IPv6:::1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4JtPtR02r2z3bV1
	for <lists+linux-erofs@lfdr.de>; Wed,  9 Feb 2022 01:05:51 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org;
	dkim=fail reason="signature verification failed" (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20210112 header.b=RzsA+yKi;
	dkim-atps=neutral
X-Original-To: linux-erofs@lists.ozlabs.org
Delivered-To: linux-erofs@lists.ozlabs.org
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized)
 smtp.mailfrom=gmail.com (client-ip=2607:f8b0:4864:20::436;
 helo=mail-pf1-x436.google.com; envelope-from=jnhuang95@gmail.com;
 receiver=<UNKNOWN>)
Authentication-Results: lists.ozlabs.org; dkim=pass (2048-bit key;
 unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256
 header.s=20210112 header.b=RzsA+yKi; dkim-atps=neutral
Received: from mail-pf1-x436.google.com (mail-pf1-x436.google.com
 [IPv6:2607:f8b0:4864:20::436])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 4JtPtM5CT6z3bcC
 for <linux-erofs@lists.ozlabs.org>; Wed,  9 Feb 2022 01:05:47 +1100 (AEDT)
Received: by mail-pf1-x436.google.com with SMTP id y5so18096083pfe.4
 for <linux-erofs@lists.ozlabs.org>; Tue, 08 Feb 2022 06:05:47 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20210112;
 h=from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=tZoiCU6/aiDbBEDQJM9Td+nFGQmb+92uK6kM97ktQS4=;
 b=RzsA+yKi0ahz7V3+qkLwhW4dTSfrppEh3MQuAft7QdD15ZMvQ2u0+cwATst39nI7PP
 LDp46blTBvX1S5TlLZ7FRe2bd2LMGL3jDbZZ4flBbW090h4DyyB7PiiqNx2nCyVVXj6w
 Hc98CrFvAeOdtkxLsfIuXFmSu6zsfIr3TSSJbeafFjBqt97Ab9BNrs5zcPgTZA8vJFWS
 gUSqaYMhGvWZcESJqu5jR5U30HasDV+EdH1E7cnnwId2hzgebrXrn9mutToQ0H5pwK2Y
 mNcuH7t6zlznmQik4Bl16rIq21YNEJM+xGakMz7Z2Kd8kEZ+Zhppzl5akXirYRmXzPIe
 ZIGg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=tZoiCU6/aiDbBEDQJM9Td+nFGQmb+92uK6kM97ktQS4=;
 b=EPKddcBVJbBQcNbUsMlBK9cXCInf/k2Ht3BejxvS6bUxqTiY4yuQ9hMHUYPSUavaeJ
 F0Jpi8r6q6ToX7100P72LoFKtlwVHikO3sVhmBTkdo147j9A6t93RIJOxGYTHtJwmsJW
 EQcwMjQ20cuDxBLFlnH/CiI22xpbf+hPLpoMclZj4OFaemvYU/BCof5+6T1f460yaGyu
 yToBhE1ZW/CxKxqwq82iLJkYF+WaLemnIzmV+CXg8BGdPBAmXT73y/m5WS9YtifNTTkb
 W29CSiy8XMdLo6BBeuQbkg6WwnbeUAZximRfuuZuDevUAu58Y1l00HbabHb9n9WYC+Q0
 3otA==
X-Gm-Message-State: AOAM532STM7UFshEgMuQ56PbSPc4Y0+toYM24JDALqCSQDIDvaTeP9Qx
 +224utwQD675v3bAV8HWAoijw4Ezca0=
X-Google-Smtp-Source: ABdhPJzpPc1iRlwfwhsNeujI2gA+etw28EovEPEu9EaRGrxkm4X8axflp8SUaQcgYSqwIK03cbPnWA==
X-Received: by 2002:a63:5144:: with SMTP id r4mr3604052pgl.382.1644329145740; 
 Tue, 08 Feb 2022 06:05:45 -0800 (PST)
Received: from hjn-PC.localdomain (li1080-207.members.linode.com.
 [45.33.61.207])
 by smtp.gmail.com with ESMTPSA id pj4sm3012006pjb.43.2022.02.08.06.05.39
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 08 Feb 2022 06:05:45 -0800 (PST)
From: Huang Jianan <jnhuang95@gmail.com>
To: u-boot@lists.denx.de,
	trini@konsulko.com
Subject: [PATCH v3 5/5] test/py: Add tests for the erofs
Date: Tue,  8 Feb 2022 22:05:13 +0800
Message-Id: <20220208140513.30570-6-jnhuang95@gmail.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20220208140513.30570-1-jnhuang95@gmail.com>
References: <20210823123646.9765-1-jnhuang95@gmail.com>
 <20220208140513.30570-1-jnhuang95@gmail.com>
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
 3 files changed, 213 insertions(+)
 create mode 100644 test/py/tests/test_fs/test_erofs.py

diff --git a/MAINTAINERS b/MAINTAINERS
index aa417bc44f..23ffdbc488 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -801,6 +801,7 @@ S:	Maintained
 F:	cmd/erofs.c
 F:	fs/erofs/
 F:	include/erofs.h
+F:	test/py/tests/test_fs/test_erofs.py
 
 FASTBOOT
 S:	Orphaned
diff --git a/configs/sandbox_defconfig b/configs/sandbox_defconfig
index f85274353d..78962ab4c8 100644
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
index 0000000000..27d3ccdf4e
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
+    subprocess.run(['mkfs.erofs -zlz4hc ' + args], shell=True, check=True,
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
-- 
2.25.1

