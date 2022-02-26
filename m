Return-Path: <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>
X-Original-To: lists+linux-erofs@lfdr.de
Delivered-To: lists+linux-erofs@lfdr.de
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	by mail.lfdr.de (Postfix) with ESMTPS id 08E8B4C544C
	for <lists+linux-erofs@lfdr.de>; Sat, 26 Feb 2022 08:06:20 +0100 (CET)
Received: from boromir.ozlabs.org (localhost [IPv6:::1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4K5Hk116D9z3cBN
	for <lists+linux-erofs@lfdr.de>; Sat, 26 Feb 2022 18:06:17 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org;
	dkim=fail reason="signature verification failed" (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20210112 header.b=mi3aLMIm;
	dkim-atps=neutral
X-Original-To: linux-erofs@lists.ozlabs.org
Delivered-To: linux-erofs@lists.ozlabs.org
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized)
 smtp.mailfrom=gmail.com (client-ip=2607:f8b0:4864:20::629;
 helo=mail-pl1-x629.google.com; envelope-from=jnhuang95@gmail.com;
 receiver=<UNKNOWN>)
Authentication-Results: lists.ozlabs.org; dkim=pass (2048-bit key;
 unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256
 header.s=20210112 header.b=mi3aLMIm; dkim-atps=neutral
Received: from mail-pl1-x629.google.com (mail-pl1-x629.google.com
 [IPv6:2607:f8b0:4864:20::629])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 4K5Hjq52Cyz2yQC
 for <linux-erofs@lists.ozlabs.org>; Sat, 26 Feb 2022 18:06:07 +1100 (AEDT)
Received: by mail-pl1-x629.google.com with SMTP id x11so6556150pll.10
 for <linux-erofs@lists.ozlabs.org>; Fri, 25 Feb 2022 23:06:08 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20210112;
 h=from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=Zj2h7hC96i9fwVGiOwk3zzYDG/ev94rSlFZo8o6IeFg=;
 b=mi3aLMImp8EoOA51MpPxnwQTQxIcM+G8xNiUVuJGFBjD0JwNNam6I8xJEC2AhRc5tt
 IlgbWOqcaO7OTTtGaMnkOE4wiC28asmK84wVmYvDnas3VdkcM+YNPLCzjSLrdnXXWW9j
 tf4SqPONHT16lYh/r09sc94PeQLm5k9s5zYbcTwFzjWxJ/9TeSqidPdhA/r86xUeP2ci
 OxeOWG+q8ULFmK85tYkA2WgoTVZEzet4j8uDxD080AckqN9DBSG3nQWOLWlS7QYelyi6
 H5m2jXvyFK3cYVc5D3ShtAYQ23nerogigyY6w6CKmcUYF7NvXBuAQyF89/JEJ8tPmNIp
 tzoQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=Zj2h7hC96i9fwVGiOwk3zzYDG/ev94rSlFZo8o6IeFg=;
 b=qYc3iCx83E5UPkChhOUUW8ItLrAHXp7H13INbj50pjtizyPB/RjM8s1G1HWU5CcANv
 VDUCkQqkKMFkjOTeGZISroDJsGdr6AdcXr7Ban7cYwkLKO/xily9dUdjByB3IWq0tHv7
 DXCYc2z7dklbmiMtTuGdiQgRZcqaAuCLukAN/a1rT1JZsDmtdMU8QNYesCwZrxcwghCN
 mtREO2uUsH4Cl1YpXyFrLO05CTysCnFKAyEHJdBIuvde9+VPHCwVWp+2XMfVGqSCgvz9
 4z+5X12g//ZWW8dcHYfnNI6yN+kryBy9H8/EIik/FFYdXc3HVzURrA98PCwTWBpGGluu
 Vhvw==
X-Gm-Message-State: AOAM533jqo4jgKq/3ksT8qoVLv1M5/xxTJdx9Pg6bURQkfG4WuSa6miT
 WtUhAh+f4f6LJzpGdW3kW4w=
X-Google-Smtp-Source: ABdhPJyVxgMYqRdH8T0VEJ2h7Lr5SXIMiLst+bJFouvomV5DQ8QXpFRcJlRNUECklneNYyB2uM83VQ==
X-Received: by 2002:a17:90a:10d0:b0:1bc:a943:b6e5 with SMTP id
 b16-20020a17090a10d000b001bca943b6e5mr6785967pje.86.1645859166220; 
 Fri, 25 Feb 2022 23:06:06 -0800 (PST)
Received: from hjn-PC.localdomain (li1080-207.members.linode.com.
 [45.33.61.207]) by smtp.gmail.com with ESMTPSA id
 e20-20020a17090ab39400b001bc4f9ad3cbsm11044489pjr.3.2022.02.25.23.06.04
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 25 Feb 2022 23:06:06 -0800 (PST)
From: Huang Jianan <jnhuang95@gmail.com>
To: u-boot@lists.denx.de,
	trini@konsulko.com
Subject: [PATCH v4 4/5] fs/erofs: add filesystem commands
Date: Sat, 26 Feb 2022 15:05:50 +0800
Message-Id: <20220226070551.9833-5-jnhuang95@gmail.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20220226070551.9833-1-jnhuang95@gmail.com>
References: <20220226070551.9833-1-jnhuang95@gmail.com>
MIME-Version: 1.0
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

Add 'ls' and 'load' commands.

Signed-off-by: Huang Jianan <jnhuang95@gmail.com>
---
 MAINTAINERS  |  1 +
 cmd/Kconfig  |  6 ++++++
 cmd/Makefile |  1 +
 cmd/erofs.c  | 42 ++++++++++++++++++++++++++++++++++++++++++
 4 files changed, 50 insertions(+)
 create mode 100644 cmd/erofs.c

diff --git a/MAINTAINERS b/MAINTAINERS
index dd2ce8143c..bd8835619e 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -812,6 +812,7 @@ EROFS
 M:	Huang Jianan <jnhuang95@gmail.com>
 L:	linux-erofs@lists.ozlabs.org
 S:	Maintained
+F:	cmd/erofs.c
 F:	fs/erofs/
 F:	include/erofs.h
 
diff --git a/cmd/Kconfig b/cmd/Kconfig
index 5e25e45fd2..50b8f33434 100644
--- a/cmd/Kconfig
+++ b/cmd/Kconfig
@@ -2176,6 +2176,12 @@ config CMD_CRAMFS
 	     cramfsls   - lists files in a cramfs image
 	     cramfsload - loads a file from a cramfs image
 
+config CMD_EROFS
+	bool "EROFS command support"
+	select FS_EROFS
+	help
+	  Support for the EROFS fs
+
 config CMD_EXT2
 	bool "ext2 command support"
 	select FS_EXT4
diff --git a/cmd/Makefile b/cmd/Makefile
index 166c652d98..d668b3c62d 100644
--- a/cmd/Makefile
+++ b/cmd/Makefile
@@ -60,6 +60,7 @@ obj-$(CONFIG_CMD_EEPROM) += eeprom.o
 obj-$(CONFIG_EFI) += efi.o
 obj-$(CONFIG_CMD_EFIDEBUG) += efidebug.o
 obj-$(CONFIG_CMD_ELF) += elf.o
+obj-$(CONFIG_CMD_EROFS) += erofs.o
 obj-$(CONFIG_HUSH_PARSER) += exit.o
 obj-$(CONFIG_CMD_EXT4) += ext4.o
 obj-$(CONFIG_CMD_EXT2) += ext2.o
diff --git a/cmd/erofs.c b/cmd/erofs.c
new file mode 100644
index 0000000000..add80b8b59
--- /dev/null
+++ b/cmd/erofs.c
@@ -0,0 +1,42 @@
+// SPDX-License-Identifier: GPL-2.0+
+/*
+ * Copyright (C) 2022 Huang Jianan <jnhuang95@gmail.com>
+ *
+ * Author: Huang Jianan <jnhuang95@gmail.com>
+ *
+ * erofs.c:	implements EROFS related commands
+ */
+
+#include <command.h>
+#include <fs.h>
+#include <erofs.h>
+
+static int do_erofs_ls(struct cmd_tbl *cmdtp, int flag, int argc, char * const argv[])
+{
+	return do_ls(cmdtp, flag, argc, argv, FS_TYPE_EROFS);
+}
+
+U_BOOT_CMD(erofsls, 4, 1, do_erofs_ls,
+	   "List files in directory. Default: root (/).",
+	   "<interface> [<dev[:part]>] [directory]\n"
+	   "    - list files from 'dev' on 'interface' in 'directory'\n"
+);
+
+static int do_erofs_load(struct cmd_tbl *cmdtp, int flag, int argc, char * const argv[])
+{
+	return do_load(cmdtp, flag, argc, argv, FS_TYPE_EROFS);
+}
+
+U_BOOT_CMD(erofsload, 7, 0, do_erofs_load,
+	   "load binary file from a EROFS filesystem",
+	   "<interface> [<dev[:part]> [<addr> [<filename> [bytes [pos]]]]]\n"
+	   "    - Load binary file 'filename' from 'dev' on 'interface'\n"
+	   "      to address 'addr' from EROFS filesystem.\n"
+	   "      'pos' gives the file position to start loading from.\n"
+	   "      If 'pos' is omitted, 0 is used. 'pos' requires 'bytes'.\n"
+	   "      'bytes' gives the size to load. If 'bytes' is 0 or omitted,\n"
+	   "      the load stops on end of file.\n"
+	   "      If either 'pos' or 'bytes' are not aligned to\n"
+	   "      ARCH_DMA_MINALIGN then a misaligned buffer warning will\n"
+	   "      be printed and performance will suffer for the load."
+);
-- 
2.25.1

