Return-Path: <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>
X-Original-To: lists+linux-erofs@lfdr.de
Delivered-To: lists+linux-erofs@lfdr.de
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2401:3900:2:1::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 4489574AC4
	for <lists+linux-erofs@lfdr.de>; Thu, 25 Jul 2019 11:58:58 +0200 (CEST)
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2401:3900:2:1::3])
	by lists.ozlabs.org (Postfix) with ESMTP id 45vSNH0qF1zDqPl
	for <lists+linux-erofs@lfdr.de>; Thu, 25 Jul 2019 19:58:55 +1000 (AEST)
X-Original-To: linux-erofs@lists.ozlabs.org
Delivered-To: linux-erofs@lists.ozlabs.org
Authentication-Results: lists.ozlabs.org;
 spf=pass (mailfrom) smtp.mailfrom=huawei.com
 (client-ip=45.249.212.35; helo=huawei.com; envelope-from=gaoxiang25@huawei.com;
 receiver=<UNKNOWN>)
Authentication-Results: lists.ozlabs.org;
 dmarc=none (p=none dis=none) header.from=huawei.com
Received: from huawei.com (szxga07-in.huawei.com [45.249.212.35])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 45vSLl4hxBzDqPN
 for <linux-erofs@lists.ozlabs.org>; Thu, 25 Jul 2019 19:57:35 +1000 (AEST)
Received: from DGGEMS410-HUB.china.huawei.com (unknown [172.30.72.60])
 by Forcepoint Email with ESMTP id 9ECA5EDCA0DA55BD06D7;
 Thu, 25 Jul 2019 17:57:31 +0800 (CST)
Received: from architecture4.huawei.com (10.140.130.215) by smtp.huawei.com
 (10.3.19.210) with Microsoft SMTP Server (TLS) id 14.3.439.0; Thu, 25 Jul
 2019 17:57:23 +0800
From: Gao Xiang <gaoxiang25@huawei.com>
To: Alexander Viro <viro@zeniv.linux.org.uk>, Greg Kroah-Hartman
 <gregkh@linuxfoundation.org>, Andrew Morton <akpm@linux-foundation.org>,
 Stephen Rothwell <sfr@canb.auug.org.au>, Theodore Ts'o <tytso@mit.edu>,
 "David Sterba" <dsterba@suse.cz>, Amir Goldstein <amir73il@gmail.com>, Linus
 Torvalds <torvalds@linux-foundation.org>
Subject: [PATCH v4 10/24] erofs: update Kconfig and Makefile
Date: Thu, 25 Jul 2019 17:56:44 +0800
Message-ID: <20190725095658.155779-11-gaoxiang25@huawei.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20190725095658.155779-1-gaoxiang25@huawei.com>
References: <20190725095658.155779-1-gaoxiang25@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.140.130.215]
X-CFilter-Loop: Reflected
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
Cc: devel@driverdev.osuosl.org, linux-erofs@lists.ozlabs.org,
 LKML <linux-kernel@vger.kernel.org>, linux-fsdevel@vger.kernel.org,
 Miao Xie <miaoxie@huawei.com>
Errors-To: linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org
Sender: "Linux-erofs"
 <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>

This commit adds Makefile and Kconfig for erofs, and
updates Makefile and Kconfig files in the fs directory.

Signed-off-by: Gao Xiang <gaoxiang25@huawei.com>
---
 fs/Kconfig        |  1 +
 fs/Makefile       |  1 +
 fs/erofs/Kconfig  | 36 ++++++++++++++++++++++++++++++++++++
 fs/erofs/Makefile |  9 +++++++++
 4 files changed, 47 insertions(+)
 create mode 100644 fs/erofs/Kconfig
 create mode 100644 fs/erofs/Makefile

diff --git a/fs/Kconfig b/fs/Kconfig
index f1046cf6ad85..529a174cbb9c 100644
--- a/fs/Kconfig
+++ b/fs/Kconfig
@@ -262,6 +262,7 @@ source "fs/romfs/Kconfig"
 source "fs/pstore/Kconfig"
 source "fs/sysv/Kconfig"
 source "fs/ufs/Kconfig"
+source "fs/erofs/Kconfig"
 
 endif # MISC_FILESYSTEMS
 
diff --git a/fs/Makefile b/fs/Makefile
index c9aea23aba56..6166f533abf7 100644
--- a/fs/Makefile
+++ b/fs/Makefile
@@ -130,3 +130,4 @@ obj-$(CONFIG_F2FS_FS)		+= f2fs/
 obj-$(CONFIG_CEPH_FS)		+= ceph/
 obj-$(CONFIG_PSTORE)		+= pstore/
 obj-$(CONFIG_EFIVAR_FS)		+= efivarfs/
+obj-$(CONFIG_EROFS_FS)		+= erofs/
diff --git a/fs/erofs/Kconfig b/fs/erofs/Kconfig
new file mode 100644
index 000000000000..98f05043448a
--- /dev/null
+++ b/fs/erofs/Kconfig
@@ -0,0 +1,36 @@
+# SPDX-License-Identifier: GPL-2.0-only
+
+config EROFS_FS
+	tristate "EROFS filesystem support"
+	depends on BLOCK
+	help
+	  EROFS (Enhanced Read-Only File System) is a lightweight
+	  read-only file system with modern designs (eg. page-sized
+	  blocks, inline xattrs/data, etc.) for scenarios which need
+	  high-performance read-only requirements, e.g. Android OS
+	  for mobile phones and LIVECDs.
+
+	  It also provides fixed-sized output compression support,
+	  which improves storage density, keeps relatively higher
+	  compression ratios, which is more useful to achieve high
+	  performance for embedded devices with limited memory.
+
+	  If unsure, say N.
+
+config EROFS_FS_DEBUG
+	bool "EROFS debugging feature"
+	depends on EROFS_FS
+	help
+	  Print debugging messages and enable more BUG_ONs which check
+	  filesystem consistency and find potential issues aggressively,
+	  which can be used for Android eng build, for example.
+
+	  For daily use, say N.
+
+config EROFS_FAULT_INJECTION
+	bool "EROFS fault injection facility"
+	depends on EROFS_FS
+	help
+	  Test EROFS to inject faults such as ENOMEM, EIO, and so on.
+	  If unsure, say N.
+
diff --git a/fs/erofs/Makefile b/fs/erofs/Makefile
new file mode 100644
index 000000000000..c3f4e549ef90
--- /dev/null
+++ b/fs/erofs/Makefile
@@ -0,0 +1,9 @@
+# SPDX-License-Identifier: GPL-2.0-only
+
+EROFS_VERSION = "1.0"
+
+ccflags-y += -DEROFS_VERSION=\"$(EROFS_VERSION)\"
+
+obj-$(CONFIG_EROFS_FS) += erofs.o
+erofs-objs := super.o inode.o data.o namei.o dir.o
+
-- 
2.17.1

