Return-Path: <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>
X-Original-To: lists+linux-erofs@lfdr.de
Delivered-To: lists+linux-erofs@lfdr.de
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	by mail.lfdr.de (Postfix) with ESMTPS id A1DEE4ADAC7
	for <lists+linux-erofs@lfdr.de>; Tue,  8 Feb 2022 15:05:49 +0100 (CET)
Received: from boromir.ozlabs.org (localhost [IPv6:::1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4JtPtM2WZZz3bP9
	for <lists+linux-erofs@lfdr.de>; Wed,  9 Feb 2022 01:05:47 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org;
	dkim=fail reason="signature verification failed" (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20210112 header.b=BryKG7G5;
	dkim-atps=neutral
X-Original-To: linux-erofs@lists.ozlabs.org
Delivered-To: linux-erofs@lists.ozlabs.org
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized)
 smtp.mailfrom=gmail.com (client-ip=2607:f8b0:4864:20::1033;
 helo=mail-pj1-x1033.google.com; envelope-from=jnhuang95@gmail.com;
 receiver=<UNKNOWN>)
Authentication-Results: lists.ozlabs.org; dkim=pass (2048-bit key;
 unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256
 header.s=20210112 header.b=BryKG7G5; dkim-atps=neutral
Received: from mail-pj1-x1033.google.com (mail-pj1-x1033.google.com
 [IPv6:2607:f8b0:4864:20::1033])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 4JtPtF4hzzz3bbP
 for <linux-erofs@lists.ozlabs.org>; Wed,  9 Feb 2022 01:05:41 +1100 (AEDT)
Received: by mail-pj1-x1033.google.com with SMTP id y9so8733621pjf.1
 for <linux-erofs@lists.ozlabs.org>; Tue, 08 Feb 2022 06:05:41 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20210112;
 h=from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=5RJJgZEqevtZkRkz8FenDXgVFgtdJIpOEWVfv8gBZ/M=;
 b=BryKG7G5WyuprH8Dg+cMbpf4pYoKIHrCyi0yrZuPRr+w4RPmo47hD7Y/MBFsDjzLkU
 TSAw5OAMH4/ZSaZP5hR/OueeIhmm4MXC7EHf7CnFcRqwcRX6CqaexsZHVvRaQgw7LKcP
 wd63Z4hIfZsvCmiw8lJQUO8ibt4ZAsalsaKhAM4zBzOsI6WPDYKnX4BxCBnIL0UlCDBW
 f+K5wKW9Nu7KOotoEwBoxaSp2YiuaQi+cB4pq1yODVmcdPwUnQPUEzBgn4JZE7AHZ/pP
 BBq96r0uGdpTaX1+Jk2GTUewYz/bv8VCS0WySWFls+c0YZOy1GRW06epDp4ScLjG3+7Y
 TpRg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=5RJJgZEqevtZkRkz8FenDXgVFgtdJIpOEWVfv8gBZ/M=;
 b=A7NTkTm36mofjn1+aScB6ks5M6MJygmt0dxWBARWvIBOcwIiZgzlp17LObJjAL6GQC
 l1/E0NZW0ecqyhLndjVotbrvOgwmqlvKaKBaLt6mRTHbnEwHtSspWlXsq+h1GoyK/cno
 uTpZEQMroQXWKX1WgcPupvhKw/tTP52sxhOu3dD/IGbOj0EY/pardgIwfrTcLL/qJqL6
 vHoSMOKNB6aXifB+FlOIsh38xSZYwOdi+X1I/DQHUwu0cD6vP0aoUTir9DWMVp43HfJ5
 DjwJc4Kf/ZCVaVCbvI4hnAI0mvUNw13LsNH/rwHhPiaFYJ4EQ1viiK/LPZeM/LGStgkU
 djZQ==
X-Gm-Message-State: AOAM533XAVGZqZ5fnDRyAR+WTgeLsLvDd5c8VbpzlIOf4fd3yGv6+D1y
 YhRBFzn0QNDOxuQQJxG/r0sqtGytnSo=
X-Google-Smtp-Source: ABdhPJzdA08HZ8N5hKUddDQqhMwUtru2rgQeIbmHJoRM0bQc2Ouc69uG9R1kRzO3f4DhrfkeRP+8RA==
X-Received: by 2002:a17:902:8f8e:: with SMTP id
 z14mr4865246plo.28.1644329139640; 
 Tue, 08 Feb 2022 06:05:39 -0800 (PST)
Received: from hjn-PC.localdomain (li1080-207.members.linode.com.
 [45.33.61.207])
 by smtp.gmail.com with ESMTPSA id pj4sm3012006pjb.43.2022.02.08.06.05.37
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 08 Feb 2022 06:05:39 -0800 (PST)
From: Huang Jianan <jnhuang95@gmail.com>
To: u-boot@lists.denx.de,
	trini@konsulko.com
Subject: [PATCH v3 4/5] fs/erofs: add filesystem commands
Date: Tue,  8 Feb 2022 22:05:12 +0800
Message-Id: <20220208140513.30570-5-jnhuang95@gmail.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20220208140513.30570-1-jnhuang95@gmail.com>
References: <20210823123646.9765-1-jnhuang95@gmail.com>
 <20220208140513.30570-1-jnhuang95@gmail.com>
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
index 571a64bf7e..aa417bc44f 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -798,6 +798,7 @@ EROFS
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

