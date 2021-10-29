Return-Path: <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>
X-Original-To: lists+linux-erofs@lfdr.de
Delivered-To: lists+linux-erofs@lfdr.de
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2404:9400:2:0:216:3eff:fee1:b9f1])
	by mail.lfdr.de (Postfix) with ESMTPS id 32EA443F961
	for <lists+linux-erofs@lfdr.de>; Fri, 29 Oct 2021 11:06:31 +0200 (CEST)
Received: from boromir.ozlabs.org (localhost [IPv6:::1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4Hgc450gWWz2yPP
	for <lists+linux-erofs@lfdr.de>; Fri, 29 Oct 2021 20:06:29 +1100 (AEDT)
X-Original-To: linux-erofs@lists.ozlabs.org
Delivered-To: linux-erofs@lists.ozlabs.org
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized)
 smtp.mailfrom=huawei.com (client-ip=45.249.212.187; helo=szxga01-in.huawei.com;
 envelope-from=guoxuenan@huawei.com; receiver=<UNKNOWN>)
Received: from szxga01-in.huawei.com (szxga01-in.huawei.com [45.249.212.187])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256
 bits)) (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 4Hgc415143z2x9S
 for <linux-erofs@lists.ozlabs.org>; Fri, 29 Oct 2021 20:06:25 +1100 (AEDT)
Received: from dggemv703-chm.china.huawei.com (unknown [172.30.72.57])
 by szxga01-in.huawei.com (SkyGuard) with ESMTP id 4Hgc146kJMzZcYw;
 Fri, 29 Oct 2021 17:03:52 +0800 (CST)
Received: from kwepemm600004.china.huawei.com (7.193.23.242) by
 dggemv703-chm.china.huawei.com (10.3.19.46) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2308.15; Fri, 29 Oct 2021 17:05:51 +0800
Received: from huawei.com (10.175.101.6) by kwepemm600004.china.huawei.com
 (7.193.23.242) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2308.15; Fri, 29 Oct
 2021 17:05:50 +0800
From: Guo Xuenan <guoxuenan@huawei.com>
To: <xiang@kernel.org>, <linux-erofs@lists.ozlabs.org>
Subject: [PATCH v3 5/5] erofs-utils: manpage: add dump.erofs manpage.
Date: Fri, 29 Oct 2021 17:12:44 +0800
Message-ID: <20211029091244.1162119-5-guoxuenan@huawei.com>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <20211029091244.1162119-1-guoxuenan@huawei.com>
References: <20211029091244.1162119-1-guoxuenan@huawei.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.175.101.6]
X-ClientProxiedBy: dggems703-chm.china.huawei.com (10.3.19.180) To
 kwepemm600004.china.huawei.com (7.193.23.242)
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
Cc: mpiglet@outlook.com
Errors-To: linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org
Sender: "Linux-erofs"
 <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>

This patch adds dump.erofs manpage.

Signed-off-by: Guo Xuenan <guoxuenan@huawei.com>
---
 man/Makefile.am  |  2 +-
 man/dump.erofs.1 | 58 ++++++++++++++++++++++++++++++++++++++++++++++++
 2 files changed, 59 insertions(+), 1 deletion(-)
 create mode 100644 man/dump.erofs.1

diff --git a/man/Makefile.am b/man/Makefile.am
index d62d6e2..769b557 100644
--- a/man/Makefile.am
+++ b/man/Makefile.am
@@ -1,6 +1,6 @@
 # SPDX-License-Identifier: GPL-2.0+
 
-dist_man_MANS = mkfs.erofs.1
+dist_man_MANS = mkfs.erofs.1 dump.erofs.1
 
 EXTRA_DIST = erofsfuse.1
 if ENABLE_FUSE
diff --git a/man/dump.erofs.1 b/man/dump.erofs.1
new file mode 100644
index 0000000..98be560
--- /dev/null
+++ b/man/dump.erofs.1
@@ -0,0 +1,58 @@
+.\" Copyright (c) 2021 Guo Xuenan <guoxuenan@huawei.com>
+.\"
+.TH DUMP.EROFS 1
+.SH NAME
+dump.erofs \- retrieve directory and file entries, show specific file
+or overall disk statistics information from an EROFS-formatted image.
+.SH SYNOPSIS
+.B dump.erofs
+[
+.B \--nid
+.I inode number
+]
+[
+.B \-e
+]
+[
+.B \-s
+]
+[
+.B \-S
+]
+[
+.B \-V
+]
+.I IMAGE
+.SH DESCRIPTION
+.B dump.erofs
+is used to retrieve erofs metadata from \fIIMAGE\fP and demonstrate
+1) overall disk statistics,
+2) erofs superblock information,
+3) file information of given inode number,
+4) file extent information.
+.SH OPTIONS
+.TP
+.BI \--nid " inode number"
+Specify an inode number to print its file information.
+.TP
+.BI \-e
+Show the file extent information, the option depends on option --nid to specify nid.
+.TP
+.BI \-V
+Print the version number and exit.
+.TP
+.BI \-s
+Show superblock information of the an EROFS-formated image.
+.TP
+.BI \-S
+Show EROFS disk statistics, including file type/size distribution, number of (un)compressed files, compression ratio of the whole image, etc.
+.SH AUTHOR
+Initial code was written by Wang Qi <mpiglet@outlook.com>, Guo Xuenan <guoxuenan@huawei.com>.
+.PP
+This manual page was written by Guo Xuenan <guoxuenan@huawei.com>
+.SH AVAILABILITY
+.B dump.erofs
+is part of erofs-utils package and is available from git://git.kernel.org/pub/scm/linux/kernel/git/xiang/erofs-utils.git.
+.SH SEE ALSO
+.BR mkfs.erofs(1),
+.BR fsck.erofs(1)
-- 
2.31.1

