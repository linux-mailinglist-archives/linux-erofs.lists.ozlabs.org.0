Return-Path: <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>
X-Original-To: lists+linux-erofs@lfdr.de
Delivered-To: lists+linux-erofs@lfdr.de
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2404:9400:2:0:216:3eff:fee1:b9f1])
	by mail.lfdr.de (Postfix) with ESMTPS id 9F7AC7E202F
	for <lists+linux-erofs@lfdr.de>; Mon,  6 Nov 2023 12:40:56 +0100 (CET)
Authentication-Results: lists.ozlabs.org;
	dkim=fail reason="signature verification failed" (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.a=rsa-sha256 header.s=google header.b=d6V5I7Di;
	dkim-atps=neutral
Received: from boromir.ozlabs.org (localhost [IPv6:::1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4SP8Yf18tmz3by8
	for <lists+linux-erofs@lfdr.de>; Mon,  6 Nov 2023 22:40:54 +1100 (AEDT)
X-Original-To: linux-erofs@lists.ozlabs.org
Delivered-To: linux-erofs@lists.ozlabs.org
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.a=rsa-sha256 header.s=google header.b=d6V5I7Di;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=linaro.org (client-ip=2607:f8b0:4864:20::429; helo=mail-pf1-x429.google.com; envelope-from=masahisa.kojima@linaro.org; receiver=lists.ozlabs.org)
Received: from mail-pf1-x429.google.com (mail-pf1-x429.google.com [IPv6:2607:f8b0:4864:20::429])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4SP8YX12ZGz2xgw
	for <linux-erofs@lists.ozlabs.org>; Mon,  6 Nov 2023 22:40:45 +1100 (AEDT)
Received: by mail-pf1-x429.google.com with SMTP id d2e1a72fcca58-6b1e46ca282so4681977b3a.2
        for <linux-erofs@lists.ozlabs.org>; Mon, 06 Nov 2023 03:40:45 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1699270841; x=1699875641; darn=lists.ozlabs.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=TMp02tF2/jn50c0fdB6OUXNmWJ9Af2C5T6zhn2D5BPI=;
        b=d6V5I7DiOZcws8AiTkcV+w0NRfCHlX28f229Gv5s+6LoHPrEvdbe7fDsn+3BA06b+v
         PZ7UHSw5PI8+e8Vsg7ZvR6WbhOdH5Qrmby+riSuaqvxl0wJCcs1TN0sp7ewVoj7R0iWr
         FVgXfOd/kVGPyeNB9P9cHFlWcostd/GOCgjEa0E7wiIhHTimyQ6NEyt4av452+sWq366
         VJraEGtBXlNOvEg6bN5y5KwsW5X1yZhVPkEMKa6mIQB4/EsUWm6rPa7WppmGwpOAqd+m
         ynlhNO185H5Zt7SbEyXj5aH2stVUzJ33CI5iMTH/dmlcYuvWeT0G5xvHH09Koz5O3yUV
         6BEA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1699270841; x=1699875641;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=TMp02tF2/jn50c0fdB6OUXNmWJ9Af2C5T6zhn2D5BPI=;
        b=ZmDtA9G24C380+f1SYjNIi9E6YZqwmKFq6+fKOdVsQCZ2n1NhGum8cnSi/QZpTIOL0
         q7fcMz8EJ6G2YY5xd56fqy5V9P1/hSXkLVJ7YizzuUmm/EMVXwwCSldy81fi2gT3k8NK
         ZaPMiOJ8CYIsn3MNY2VjqlUsAxyYf1leGLttu4ZYsZy7VvQ5gOaVBLaAcM+n+s15hEnW
         sgV8DFu1rY0k2nq+grQamYu8Tkixqfw3jp1UT3zuBDL/tq1vHf0dezJ3yvuaYtCzv4eX
         SxV3JNENvWktER8l/U/3lGDvxaektEdgHNiq3HnWQlog4VF1nTCZRIJg2af1C4MXmToz
         gt5Q==
X-Gm-Message-State: AOJu0Ywyzg53ac44cNzD3ltCbWBHw8Ou0+ISySzp7LBWBDkWgEIjEUuD
	NfnIyNcFaaCxAQjO7dDZaLMUxg==
X-Google-Smtp-Source: AGHT+IEjRAoQY7AnLknmGN3+mvDSRuFR6a0j//I3lrh2iV3Vcc2wUGj2q5Fh1dIS/mFiEFikF6n2BA==
X-Received: by 2002:a05:6a20:12c4:b0:181:275f:3b4f with SMTP id v4-20020a056a2012c400b00181275f3b4fmr16503100pzg.11.1699270841495;
        Mon, 06 Nov 2023 03:40:41 -0800 (PST)
Received: from localhost ([164.70.16.189])
        by smtp.gmail.com with ESMTPSA id j8-20020a170903024800b001c9d968563csm5700803plh.79.2023.11.06.03.40.40
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 06 Nov 2023 03:40:40 -0800 (PST)
From: Masahisa Kojima <masahisa.kojima@linaro.org>
To: u-boot@lists.denx.de
Subject: [RESEND PATCH v10 4/9] efi_loader: Boot var automatic management
Date: Mon,  6 Nov 2023 20:39:15 +0900
Message-Id: <20231106113920.3631591-5-masahisa.kojima@linaro.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20231106113920.3631591-1-masahisa.kojima@linaro.org>
References: <20231106113920.3631591-1-masahisa.kojima@linaro.org>
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
Cc: Raymond Mao <raymond.mao@linaro.org>, Joao Marcos Costa <jmcosta944@gmail.com>, Heinrich Schuchardt <xypron.glpk@gmx.de>, Simon Glass <sjg@chromium.org>, Ilias Apalodimas <ilias.apalodimas@linaro.org>, linux-erofs@lists.ozlabs.org, Takahiro Akashi <takahiro.akashi@linaro.org>, Thomas Petazzoni <thomas.petazzoni@bootlin.com>, Miquel Raynal <miquel.raynal@bootlin.com>, Masahisa Kojima <masahisa.kojima@linaro.org>, Michal Simek <michal.simek@amd.com>
Errors-To: linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org
Sender: "Linux-erofs" <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>

From: Raymond Mao <raymond.mao@linaro.org>

Changes for complying to EFI spec §3.5.1.1
'Removable Media Boot Behavior'.
Boot variables can be automatically generated during a removable
media is probed. At the same time, unused boot variables will be
detected and removed.

Please note that currently the function 'efi_disk_remove' has no
ability to distinguish below two scenarios
a) Unplugging of a removable media under U-Boot
b) U-Boot exiting and booting an OS
Thus currently the boot variables management is not added into
'efi_disk_remove' to avoid boot options being added/erased
repeatedly under scenario b) during power cycles
See TODO comments under function 'efi_disk_remove' for more details

The original efi_secboot tests expect that BootOrder EFI variable
is not defined. With this commit, the BootOrder EFI variable is
automatically added when the disk is detected. The original
efi_secboot tests end up with unexpected failure.
The efi_secboot tests need to be modified to explicitly set
the BootOrder EFI variable.

squashfs and erofs ls tests are also affected by this modification,
need to clear the previous state before squashfs ls test starts.

Co-developed-by: Masahisa Kojima <masahisa.kojima@linaro.org>
Signed-off-by: Masahisa Kojima <masahisa.kojima@linaro.org>
Signed-off-by: Raymond Mao <raymond.mao@linaro.org>
Reviewed-by: Heinrich Schuchardt <xypron.glpk@gmx.de>
Reviewed-by: Ilias Apalodimas <ilias.apalodimas@linaro.org>
Reviewed-by: Joao Marcos Costa <jmcosta944@gmail.com>
---
 lib/efi_loader/efi_disk.c                     | 18 ++++++++
 lib/efi_loader/efi_setup.c                    |  7 ++++
 test/py/tests/test_efi_secboot/test_signed.py | 42 +++++++++----------
 .../test_efi_secboot/test_signed_intca.py     | 14 +++----
 .../tests/test_efi_secboot/test_unsigned.py   | 14 +++----
 test/py/tests/test_fs/test_erofs.py           |  9 ++++
 .../test_fs/test_squashfs/test_sqfs_ls.py     |  9 ++++
 7 files changed, 78 insertions(+), 35 deletions(-)

diff --git a/lib/efi_loader/efi_disk.c b/lib/efi_loader/efi_disk.c
index f0d76113b0..b808a7fe62 100644
--- a/lib/efi_loader/efi_disk.c
+++ b/lib/efi_loader/efi_disk.c
@@ -690,6 +690,13 @@ int efi_disk_probe(void *ctx, struct event *event)
 			return -1;
 	}
 
+	/* only do the boot option management when UEFI sub-system is initialized */
+	if (IS_ENABLED(CONFIG_CMD_BOOTEFI_BOOTMGR) && efi_obj_list_initialized == EFI_SUCCESS) {
+		ret = efi_bootmgr_update_media_device_boot_option();
+		if (ret != EFI_SUCCESS)
+			return -1;
+	}
+
 	return 0;
 }
 
@@ -742,6 +749,17 @@ int efi_disk_remove(void *ctx, struct event *event)
 	dev_tag_del(dev, DM_TAG_EFI);
 
 	return 0;
+
+	/*
+	 * TODO A flag to distinguish below 2 different scenarios of this
+	 * function call is needed:
+	 * a) Unplugging of a removable media under U-Boot
+	 * b) U-Boot exiting and booting an OS
+	 * In case of scenario a), efi_bootmgr_update_media_device_boot_option()
+	 * needs to be invoked here to update the boot options and remove the
+	 * unnecessary ones.
+	 */
+
 }
 
 /**
diff --git a/lib/efi_loader/efi_setup.c b/lib/efi_loader/efi_setup.c
index ad719afd63..c02569cb6d 100644
--- a/lib/efi_loader/efi_setup.c
+++ b/lib/efi_loader/efi_setup.c
@@ -245,6 +245,13 @@ efi_status_t efi_init_obj_list(void)
 	if (ret != EFI_SUCCESS)
 		goto out;
 
+	if (IS_ENABLED(CONFIG_CMD_BOOTEFI_BOOTMGR)) {
+		/* update boot option after variable service initialized */
+		ret = efi_bootmgr_update_media_device_boot_option();
+		if (ret != EFI_SUCCESS)
+			goto out;
+	}
+
 	/* Define supported languages */
 	ret = efi_init_platform_lang();
 	if (ret != EFI_SUCCESS)
diff --git a/test/py/tests/test_efi_secboot/test_signed.py b/test/py/tests/test_efi_secboot/test_signed.py
index ca52e853d8..2f862a259a 100644
--- a/test/py/tests/test_efi_secboot/test_signed.py
+++ b/test/py/tests/test_efi_secboot/test_signed.py
@@ -29,7 +29,7 @@ class TestEfiSignedImage(object):
             output = u_boot_console.run_command_list([
                 'host bind 0 %s' % disk_img,
                 'efidebug boot add -b 1 HELLO1 host 0:1 /helloworld.efi.signed -s ""',
-                'efidebug boot next 1',
+                'efidebug boot order 1',
                 'bootefi bootmgr'])
             assert 'Hello, world!' in ''.join(output)
 
@@ -37,7 +37,7 @@ class TestEfiSignedImage(object):
             # Test Case 1b, run unsigned image if no PK
             output = u_boot_console.run_command_list([
                 'efidebug boot add -b 2 HELLO2 host 0:1 /helloworld.efi -s ""',
-                'efidebug boot next 2',
+                'efidebug boot order 2',
                 'bootefi bootmgr'])
             assert 'Hello, world!' in ''.join(output)
 
@@ -59,13 +59,13 @@ class TestEfiSignedImage(object):
             assert 'Failed to set EFI variable' not in ''.join(output)
             output = u_boot_console.run_command_list([
                 'efidebug boot add -b 1 HELLO1 host 0:1 /helloworld.efi.signed -s ""',
-                'efidebug boot next 1',
+                'efidebug boot order 1',
                 'efidebug test bootmgr'])
             assert('\'HELLO1\' failed' in ''.join(output))
             assert('efi_start_image() returned: 26' in ''.join(output))
             output = u_boot_console.run_command_list([
                 'efidebug boot add -b 2 HELLO2 host 0:1 /helloworld.efi -s ""',
-                'efidebug boot next 2',
+                'efidebug boot order 2',
                 'efidebug test bootmgr'])
             assert '\'HELLO2\' failed' in ''.join(output)
             assert 'efi_start_image() returned: 26' in ''.join(output)
@@ -77,12 +77,12 @@ class TestEfiSignedImage(object):
                 'setenv -e -nv -bs -rt -at -i 4000000:$filesize db'])
             assert 'Failed to set EFI variable' not in ''.join(output)
             output = u_boot_console.run_command_list([
-                'efidebug boot next 2',
+                'efidebug boot order 2',
                 'efidebug test bootmgr'])
             assert '\'HELLO2\' failed' in ''.join(output)
             assert 'efi_start_image() returned: 26' in ''.join(output)
             output = u_boot_console.run_command_list([
-                'efidebug boot next 1',
+                'efidebug boot order 1',
                 'bootefi bootmgr'])
             assert 'Hello, world!' in ''.join(output)
 
@@ -105,7 +105,7 @@ class TestEfiSignedImage(object):
             assert 'Failed to set EFI variable' not in ''.join(output)
             output = u_boot_console.run_command_list([
                 'efidebug boot add -b 1 HELLO host 0:1 /helloworld.efi.signed -s ""',
-                'efidebug boot next 1',
+                'efidebug boot order 1',
                 'efidebug test bootmgr'])
             assert '\'HELLO\' failed' in ''.join(output)
             assert 'efi_start_image() returned: 26' in ''.join(output)
@@ -117,7 +117,7 @@ class TestEfiSignedImage(object):
                 'setenv -e -nv -bs -rt -at -i 4000000:$filesize db'])
             assert 'Failed to set EFI variable' not in ''.join(output)
             output = u_boot_console.run_command_list([
-                'efidebug boot next 1',
+                'efidebug boot order 1',
                 'efidebug test bootmgr'])
             assert '\'HELLO\' failed' in ''.join(output)
             assert 'efi_start_image() returned: 26' in ''.join(output)
@@ -143,7 +143,7 @@ class TestEfiSignedImage(object):
             assert 'Failed to set EFI variable' not in ''.join(output)
             output = u_boot_console.run_command_list([
                 'efidebug boot add -b 1 HELLO host 0:1 /helloworld.efi.signed -s ""',
-                'efidebug boot next 1',
+                'efidebug boot order 1',
                 'efidebug test bootmgr'])
             assert '\'HELLO\' failed' in ''.join(output)
             assert 'efi_start_image() returned: 26' in ''.join(output)
@@ -170,7 +170,7 @@ class TestEfiSignedImage(object):
             assert 'Failed to set EFI variable' not in ''.join(output)
             output = u_boot_console.run_command_list([
                 'efidebug boot add -b 1 HELLO host 0:1 /helloworld.efi.signed_2sigs -s ""',
-                'efidebug boot next 1',
+                'efidebug boot order 1',
                 'efidebug test bootmgr'])
             assert 'Hello, world!' in ''.join(output)
 
@@ -181,7 +181,7 @@ class TestEfiSignedImage(object):
                 'setenv -e -nv -bs -rt -at -a -i 4000000:$filesize db'])
             assert 'Failed to set EFI variable' not in ''.join(output)
             output = u_boot_console.run_command_list([
-                'efidebug boot next 1',
+                'efidebug boot order 1',
                 'efidebug test bootmgr'])
             assert 'Hello, world!' in ''.join(output)
 
@@ -193,7 +193,7 @@ class TestEfiSignedImage(object):
                 'setenv -e -nv -bs -rt -at -i 4000000:$filesize dbx'])
             assert 'Failed to set EFI variable' not in ''.join(output)
             output = u_boot_console.run_command_list([
-                'efidebug boot next 1',
+                'efidebug boot order 1',
                 'efidebug test bootmgr'])
             assert '\'HELLO\' failed' in ''.join(output)
             assert 'efi_start_image() returned: 26' in ''.join(output)
@@ -205,7 +205,7 @@ class TestEfiSignedImage(object):
                 'setenv -e -nv -bs -rt -at -a -i 4000000:$filesize dbx'])
             assert 'Failed to set EFI variable' not in ''.join(output)
             output = u_boot_console.run_command_list([
-                'efidebug boot next 1',
+                'efidebug boot order 1',
                 'efidebug test bootmgr'])
             assert '\'HELLO\' failed' in ''.join(output)
             assert 'efi_start_image() returned: 26' in ''.join(output)
@@ -230,7 +230,7 @@ class TestEfiSignedImage(object):
             assert 'Failed to set EFI variable' not in ''.join(output)
             output = u_boot_console.run_command_list([
                 'efidebug boot add -b 1 HELLO host 0:1 /helloworld.efi.signed_2sigs -s ""',
-                'efidebug boot next 1',
+                'efidebug boot order 1',
                 'efidebug test bootmgr'])
             assert '\'HELLO\' failed' in ''.join(output)
             assert 'efi_start_image() returned: 26' in ''.join(output)
@@ -254,7 +254,7 @@ class TestEfiSignedImage(object):
             assert 'Failed to set EFI variable' not in ''.join(output)
             output = u_boot_console.run_command_list([
                 'efidebug boot add -b 1 HELLO host 0:1 /helloworld.efi.signed -s ""',
-                'efidebug boot next 1',
+                'efidebug boot order 1',
                 'bootefi bootmgr'])
             assert 'Hello, world!' in ''.join(output)
 
@@ -265,7 +265,7 @@ class TestEfiSignedImage(object):
                 'setenv -e -nv -bs -rt -at -i 4000000:$filesize dbx'])
             assert 'Failed to set EFI variable' not in ''.join(output)
             output = u_boot_console.run_command_list([
-                'efidebug boot next 1',
+                'efidebug boot order 1',
                 'efidebug test bootmgr'])
             assert '\'HELLO\' failed' in ''.join(output)
             assert 'efi_start_image() returned: 26' in ''.join(output)
@@ -279,7 +279,7 @@ class TestEfiSignedImage(object):
                 'setenv -e -nv -bs -rt -at -i 4000000:$filesize dbx'])
             assert 'Failed to set EFI variable' not in ''.join(output)
             output = u_boot_console.run_command_list([
-                'efidebug boot next 1',
+                'efidebug boot order 1',
                 'efidebug test bootmgr'])
             assert '\'HELLO\' failed' in ''.join(output)
             assert 'efi_start_image() returned: 26' in ''.join(output)
@@ -307,7 +307,7 @@ class TestEfiSignedImage(object):
             assert 'Failed to set EFI variable' not in ''.join(output)
             output = u_boot_console.run_command_list([
                 'efidebug boot add -b 1 HELLO host 0:1 /helloworld.efi.signed_2sigs -s ""',
-                'efidebug boot next 1',
+                'efidebug boot order 1',
                 'efidebug test bootmgr'])
             assert '\'HELLO\' failed' in ''.join(output)
             assert 'efi_start_image() returned: 26' in ''.join(output)
@@ -330,7 +330,7 @@ class TestEfiSignedImage(object):
             assert 'Failed to set EFI variable' not in ''.join(output)
             output = u_boot_console.run_command_list([
                 'efidebug boot add -b 1 HELLO host 0:1 /helloworld.efi.signed_2sigs -s ""',
-                'efidebug boot next 1',
+                'efidebug boot order 1',
                 'efidebug test bootmgr'])
             assert '\'HELLO\' failed' in ''.join(output)
             assert 'efi_start_image() returned: 26' in ''.join(output)
@@ -349,7 +349,7 @@ class TestEfiSignedImage(object):
             output = u_boot_console.run_command_list([
                 'host bind 0 %s' % disk_img,
                 'efidebug boot add -b 1 HELLO1 host 0:1 /helloworld_forged.efi.signed -s ""',
-                'efidebug boot next 1',
+                'efidebug boot order 1',
                 'efidebug test bootmgr'])
             assert('hELLO, world!' in ''.join(output))
 
@@ -364,7 +364,7 @@ class TestEfiSignedImage(object):
                 'setenv -e -nv -bs -rt -at -i 4000000:$filesize PK'])
             assert 'Failed to set EFI variable' not in ''.join(output)
             output = u_boot_console.run_command_list([
-                'efidebug boot next 1',
+                'efidebug boot order 1',
                 'efidebug test bootmgr'])
             assert(not 'hELLO, world!' in ''.join(output))
             assert('\'HELLO1\' failed' in ''.join(output))
diff --git a/test/py/tests/test_efi_secboot/test_signed_intca.py b/test/py/tests/test_efi_secboot/test_signed_intca.py
index d8d599d22f..8d9a5f3e7f 100644
--- a/test/py/tests/test_efi_secboot/test_signed_intca.py
+++ b/test/py/tests/test_efi_secboot/test_signed_intca.py
@@ -40,7 +40,7 @@ class TestEfiSignedImageIntca(object):
 
             output = u_boot_console.run_command_list([
                 'efidebug boot add -b 1 HELLO_a host 0:1 /helloworld.efi.signed_a -s ""',
-                'efidebug boot next 1',
+                'efidebug boot order 1',
                 'efidebug test bootmgr'])
             assert '\'HELLO_a\' failed' in ''.join(output)
             assert 'efi_start_image() returned: 26' in ''.join(output)
@@ -49,7 +49,7 @@ class TestEfiSignedImageIntca(object):
             # Test Case 1b, signed and authenticated by root CA
             output = u_boot_console.run_command_list([
                 'efidebug boot add -b 2 HELLO_ab host 0:1 /helloworld.efi.signed_ab -s ""',
-                'efidebug boot next 2',
+                'efidebug boot order 2',
                 'bootefi bootmgr'])
             assert 'Hello, world!' in ''.join(output)
 
@@ -71,7 +71,7 @@ class TestEfiSignedImageIntca(object):
 
             output = u_boot_console.run_command_list([
                 'efidebug boot add -b 1 HELLO_abc host 0:1 /helloworld.efi.signed_abc -s ""',
-                'efidebug boot next 1',
+                'efidebug boot order 1',
                 'efidebug test bootmgr'])
             assert '\'HELLO_abc\' failed' in ''.join(output)
             assert 'efi_start_image() returned: 26' in ''.join(output)
@@ -81,7 +81,7 @@ class TestEfiSignedImageIntca(object):
             output = u_boot_console.run_command_list([
                 'fatload host 0:1 4000000 db_b.auth',
                 'setenv -e -nv -bs -rt -at -i 4000000:$filesize db',
-                'efidebug boot next 1',
+                'efidebug boot order 1',
                 'efidebug test bootmgr'])
             assert '\'HELLO_abc\' failed' in ''.join(output)
             assert 'efi_start_image() returned: 26' in ''.join(output)
@@ -91,7 +91,7 @@ class TestEfiSignedImageIntca(object):
             output = u_boot_console.run_command_list([
                 'fatload host 0:1 4000000 db_c.auth',
                 'setenv -e -nv -bs -rt -at -i 4000000:$filesize db',
-                'efidebug boot next 1',
+                'efidebug boot order 1',
                 'efidebug test bootmgr'])
             assert 'Hello, world!' in ''.join(output)
 
@@ -117,7 +117,7 @@ class TestEfiSignedImageIntca(object):
 
             output = u_boot_console.run_command_list([
                 'efidebug boot add -b 1 HELLO_abc host 0:1 /helloworld.efi.signed_abc -s ""',
-                'efidebug boot next 1',
+                'efidebug boot order 1',
                 'efidebug test bootmgr'])
             assert 'Hello, world!' in ''.join(output)
             # Or,
@@ -129,7 +129,7 @@ class TestEfiSignedImageIntca(object):
             output = u_boot_console.run_command_list([
                 'fatload host 0:1 4000000 dbx_c.auth',
                 'setenv -e -nv -bs -rt -at -i 4000000:$filesize dbx',
-                'efidebug boot next 1',
+                'efidebug boot order 1',
                 'efidebug test bootmgr'])
             assert '\'HELLO_abc\' failed' in ''.join(output)
             assert 'efi_start_image() returned: 26' in ''.join(output)
diff --git a/test/py/tests/test_efi_secboot/test_unsigned.py b/test/py/tests/test_efi_secboot/test_unsigned.py
index df63f0df08..7c078f220d 100644
--- a/test/py/tests/test_efi_secboot/test_unsigned.py
+++ b/test/py/tests/test_efi_secboot/test_unsigned.py
@@ -36,11 +36,11 @@ class TestEfiUnsignedImage(object):
 
             output = u_boot_console.run_command_list([
                 'efidebug boot add -b 1 HELLO host 0:1 /helloworld.efi -s ""',
-                'efidebug boot next 1',
+                'efidebug boot order 1',
                 'bootefi bootmgr'])
             assert '\'HELLO\' failed' in ''.join(output)
             output = u_boot_console.run_command_list([
-                'efidebug boot next 1',
+                'efidebug boot order 1',
                 'efidebug test bootmgr'])
             assert 'efi_start_image() returned: 26' in ''.join(output)
             assert 'Hello, world!' not in ''.join(output)
@@ -65,7 +65,7 @@ class TestEfiUnsignedImage(object):
 
             output = u_boot_console.run_command_list([
                 'efidebug boot add -b 1 HELLO host 0:1 /helloworld.efi -s ""',
-                'efidebug boot next 1',
+                'efidebug boot order 1',
                 'bootefi bootmgr'])
             assert 'Hello, world!' in ''.join(output)
 
@@ -89,11 +89,11 @@ class TestEfiUnsignedImage(object):
 
             output = u_boot_console.run_command_list([
                 'efidebug boot add -b 1 HELLO host 0:1 /helloworld.efi -s ""',
-                'efidebug boot next 1',
+                'efidebug boot order 1',
                 'bootefi bootmgr'])
             assert '\'HELLO\' failed' in ''.join(output)
             output = u_boot_console.run_command_list([
-                'efidebug boot next 1',
+                'efidebug boot order 1',
                 'efidebug test bootmgr'])
             assert 'efi_start_image() returned: 26' in ''.join(output)
             assert 'Hello, world!' not in ''.join(output)
@@ -107,11 +107,11 @@ class TestEfiUnsignedImage(object):
 
             output = u_boot_console.run_command_list([
                 'efidebug boot add -b 1 HELLO host 0:1 /helloworld.efi -s ""',
-                'efidebug boot next 1',
+                'efidebug boot order 1',
                 'bootefi bootmgr'])
             assert '\'HELLO\' failed' in ''.join(output)
             output = u_boot_console.run_command_list([
-                'efidebug boot next 1',
+                'efidebug boot order 1',
                 'efidebug test bootmgr'])
             assert 'efi_start_image() returned: 26' in ''.join(output)
             assert 'Hello, world!' not in ''.join(output)
diff --git a/test/py/tests/test_fs/test_erofs.py b/test/py/tests/test_fs/test_erofs.py
index 458a52ba79..87ad8f2d5f 100644
--- a/test/py/tests/test_fs/test_erofs.py
+++ b/test/py/tests/test_fs/test_erofs.py
@@ -196,6 +196,15 @@ def test_erofs(u_boot_console):
     """
     build_dir = u_boot_console.config.build_dir
 
+    # If the EFI subsystem is enabled and initialized, EFI subsystem tries to
+    # add EFI boot option when the new disk is detected. If there is no EFI
+    # System Partition exists, EFI subsystem outputs error messages and
+    # it ends up with test failure.
+    # Restart U-Boot to clear the previous state.
+    # TODO: Ideally EFI test cases need to be fixed, but it will
+    # increase the number of system reset.
+    u_boot_console.restart_uboot()
+
     try:
         # setup test environment
         make_erofs_image(build_dir)
diff --git a/test/py/tests/test_fs/test_squashfs/test_sqfs_ls.py b/test/py/tests/test_fs/test_squashfs/test_sqfs_ls.py
index 527a556ed8..a20a7d1a66 100644
--- a/test/py/tests/test_fs/test_squashfs/test_sqfs_ls.py
+++ b/test/py/tests/test_fs/test_squashfs/test_sqfs_ls.py
@@ -118,6 +118,15 @@ def test_sqfs_ls(u_boot_console):
     """
     build_dir = u_boot_console.config.build_dir
 
+    # If the EFI subsystem is enabled and initialized, EFI subsystem tries to
+    # add EFI boot option when the new disk is detected. If there is no EFI
+    # System Partition exists, EFI subsystem outputs error messages and
+    # it ends up with test failure.
+    # Restart U-Boot to clear the previous state.
+    # TODO: Ideally EFI test cases need to be fixed, but it will
+    # increase the number of system reset.
+    u_boot_console.restart_uboot()
+
     # setup test environment
     check_mksquashfs_version()
     generate_sqfs_src_dir(build_dir)
-- 
2.34.1

