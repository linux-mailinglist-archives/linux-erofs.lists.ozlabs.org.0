Return-Path: <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>
X-Original-To: lists+linux-erofs@lfdr.de
Delivered-To: lists+linux-erofs@lfdr.de
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	by mail.lfdr.de (Postfix) with ESMTPS id B5F5E7E54B4
	for <lists+linux-erofs@lfdr.de>; Wed,  8 Nov 2023 12:08:11 +0100 (CET)
Authentication-Results: lists.ozlabs.org;
	dkim=fail reason="signature verification failed" (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.a=rsa-sha256 header.s=google header.b=FefbNdtp;
	dkim-atps=neutral
Received: from boromir.ozlabs.org (localhost [IPv6:::1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4SQMkw6CCvz3cHH
	for <lists+linux-erofs@lfdr.de>; Wed,  8 Nov 2023 22:08:08 +1100 (AEDT)
X-Original-To: linux-erofs@lists.ozlabs.org
Delivered-To: linux-erofs@lists.ozlabs.org
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.a=rsa-sha256 header.s=google header.b=FefbNdtp;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=linaro.org (client-ip=2607:f8b0:4864:20::635; helo=mail-pl1-x635.google.com; envelope-from=masahisa.kojima@linaro.org; receiver=lists.ozlabs.org)
Received: from mail-pl1-x635.google.com (mail-pl1-x635.google.com [IPv6:2607:f8b0:4864:20::635])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4SQMkr0T7nz3c5P
	for <linux-erofs@lists.ozlabs.org>; Wed,  8 Nov 2023 22:08:01 +1100 (AEDT)
Received: by mail-pl1-x635.google.com with SMTP id d9443c01a7336-1cc3216b2a1so54827895ad.2
        for <linux-erofs@lists.ozlabs.org>; Wed, 08 Nov 2023 03:08:01 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1699441678; x=1700046478; darn=lists.ozlabs.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=TMp02tF2/jn50c0fdB6OUXNmWJ9Af2C5T6zhn2D5BPI=;
        b=FefbNdtp20ogOWCHDtTOGldHi62SqgdEXTSbrbmTTkACkP1X83hj7j2CYo3UypfcO7
         RQFc09fcCO6K4C8KC1EHQOAnQlO5tQGKQj9gmko/+X4eXLq+eA12T9rQzjpQ9uLYBRmm
         Pa9C+EvTfV0tGNT8lZWdy4LPo6gGWmmOJBCNl2RvSPPL8koB1OtpcHbfJZ6Mrv+XJcMw
         EqupQ2ttpkFi+MMTp7V5pV5EyjzsRzyOBjn07LOuohEAWNcq3Gdw8EftWxDDgOAMdT2i
         umvSDGRSSEqaorg04p7UEfgoIJjSNw2kNtXq4mly3CHfqZsQjcTRLGnFFccmmwoWrv9I
         kawA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1699441678; x=1700046478;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=TMp02tF2/jn50c0fdB6OUXNmWJ9Af2C5T6zhn2D5BPI=;
        b=w58z6pJ/FqyuEOaSB7Z/XOj3bHaiXbht99IU30mBZAtJA+oQKAVM8xwxk34O8o1eHT
         E3nlX7I8AmlMvHzGANQoXNuGD3OBNt4a+l2j7QoG4P7SxdH3FMbEBPA80X5e1KcDj03M
         bvcyCurD5pQQ7juyBq3Wsj4P7RorM5AtqKOL9w2y1zoFZxbXkdPnNtw9d26wtp3im4qi
         PATSplypdyQspKFbcMXM5gQo5Z7m0JI7m6J9jxVn5wa/J5itrTzNZ58xNRZWplUkjQf1
         vaRnUkXFHbp+iMjkwZrN0756L8GyKS1W6mbkwc7ya5XyQW9HqwzcS58h3k9FfnIgJuwN
         f/sQ==
X-Gm-Message-State: AOJu0YwGUordBsqfb24BsqUoWUVB658Vf0enkd6yFk9HZ5EWRYBF/wBu
	qIcEYDkKKor6oEFfWEcUFEIQNA==
X-Google-Smtp-Source: AGHT+IESy/qpddJ2OA7fkI8T412Y6bWiXcZY1yKsXHhmjKzTykkMWFEuDQO6o57mm/vOAgpVYSxwSg==
X-Received: by 2002:a17:903:230d:b0:1cc:5f51:b1ed with SMTP id d13-20020a170903230d00b001cc5f51b1edmr1813471plh.47.1699441678299;
        Wed, 08 Nov 2023 03:07:58 -0800 (PST)
Received: from localhost ([164.70.16.189])
        by smtp.gmail.com with ESMTPSA id z19-20020a1709028f9300b001c9c47d6cb9sm1499834plo.99.2023.11.08.03.07.57
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 08 Nov 2023 03:07:57 -0800 (PST)
From: Masahisa Kojima <masahisa.kojima@linaro.org>
To: u-boot@lists.denx.de
Subject: [PATCH v11 4/9] efi_loader: Boot var automatic management
Date: Wed,  8 Nov 2023 20:06:31 +0900
Message-Id: <20231108110637.3691441-5-masahisa.kojima@linaro.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20231108110637.3691441-1-masahisa.kojima@linaro.org>
References: <20231108110637.3691441-1-masahisa.kojima@linaro.org>
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

