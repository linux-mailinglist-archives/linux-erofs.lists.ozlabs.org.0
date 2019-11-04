Return-Path: <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>
X-Original-To: lists+linux-erofs@lfdr.de
Delivered-To: lists+linux-erofs@lfdr.de
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2401:3900:2:1::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 9AF9BED9E2
	for <lists+linux-erofs@lfdr.de>; Mon,  4 Nov 2019 08:28:53 +0100 (CET)
Received: from bilbo.ozlabs.org (lists.ozlabs.org [IPv6:2401:3900:2:1::3])
	by lists.ozlabs.org (Postfix) with ESMTP id 4764D23GRxzF4tN
	for <lists+linux-erofs@lfdr.de>; Mon,  4 Nov 2019 18:28:50 +1100 (AEDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=lists.ozlabs.org;
	s=201707; t=1572852530;
	bh=5wGoFffOyLhbrtaBRTjaBZv+quolhmSq3FmD5wsquYI=;
	h=To:Subject:Date:In-Reply-To:References:List-Id:List-Unsubscribe:
	 List-Archive:List-Post:List-Help:List-Subscribe:From:Reply-To:Cc:
	 From;
	b=dcccMauzTA6XgVw0lEhGvfHsVTc8JTE3GFpZNRRaXtMEmFcwkPUDicf99FKANtugL
	 f94wUHgRCqnv1P3cu6puuzp5gc9VZd5OJ0lqxoYmXpqo6B8okoFXyPO8UpN4rnMwcL
	 esGMPwogGTf6LsruMwYECt+8AH0IGmVDwT90vvPXGlBTdvaOIU8BauOKxDnRPnA6bB
	 D3+GAZjVQ2dJ6bA40HZZ0tGOJSF11FetG0ayt3oblArYbBbN1L9ncNc/rdqVNHP+LO
	 wMKbqyA7Ala595t8q8z1o4ttvAdKZ3gvsU0mjOZmYDm/91Vi6NX1/1E8WAlOARZFpc
	 qygnH5jbgTgoQ==
X-Original-To: linux-erofs@lists.ozlabs.org
Delivered-To: linux-erofs@lists.ozlabs.org
Authentication-Results: lists.ozlabs.org;
 spf=pass (sender SPF authorized) smtp.mailfrom=aol.com
 (client-ip=98.137.65.32; helo=sonic315-8.consmr.mail.gq1.yahoo.com;
 envelope-from=hsiangkao@aol.com; receiver=<UNKNOWN>)
Authentication-Results: lists.ozlabs.org;
 dmarc=pass (p=reject dis=none) header.from=aol.com
Authentication-Results: lists.ozlabs.org; dkim=pass (2048-bit key;
 unprotected) header.d=aol.com header.i=@aol.com header.b="qrKq07Be"; 
 dkim-atps=neutral
Received: from sonic315-8.consmr.mail.gq1.yahoo.com
 (sonic315-8.consmr.mail.gq1.yahoo.com [98.137.65.32])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 4764Cs6sSzzF4sh
 for <linux-erofs@lists.ozlabs.org>; Mon,  4 Nov 2019 18:28:39 +1100 (AEDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=aol.com; s=a2048;
 t=1572852516; bh=0eE0bcdVbuhPkLFS1oEwBg99TCBZogdb2RCTwHcRTIU=;
 h=From:To:Cc:Subject:Date:In-Reply-To:References:From:Subject;
 b=qrKq07Be6U1OT8w5sOmxggdG4vwfxiEkrzV2GFh9RVSQl9EqtE+X2+45zY9wWApkP12XWnxA1Y9QI8d3Ko7fbISpsRK7iLvBWolHKjNP2wCJqDtjF3kA0/Jm+86TV1QURi1fY36jaFli/XvOjyaPKHWkcRUobyAN4nbMFgXKtbwtgSW1x6CU/KnpxS599OfwflaaOfENSMRnanbF26M51WnHs7O6uHir367C1lY12RZK3aL0V4iVruiyW87c2YemM7qQvBsj6hxqAgq7Dl1oMxHym+4Kqqq9wb7adlqTKZOQ8LCtq3Vw9OYsxIsDO9lxnE7LNSY4fU558JFR+v2KIg==
X-YMail-OSG: RR_ZlGwVM1lCID_sZgbsouDUrrgmTKPesWnJlIcZNYXlQSF11rfGMs_gDyOPuGI
 z5JOZ2XSZMYf8PcmECYk89dM64i2cqCtM4dmkX_wzDKwz.1qpkvQoUu1amw3HCC5AV8b7I0maza6
 RAKyzmCWYiiLTPXEFzzfl7S._ATpY_Ktbzkqdempq6FRvQaLA2OllGp2B7c7BfSJHqIZeg6ZbXwN
 nc9rjmQ9tfFaxBg2lejKyeO1DrSoJ552CRBczLRytYokTHnPIQFTsPGLY7XwrCQEqlgNc7lfcsFc
 JYI3R0z_JCGzaAYkSDs4T8emiBjR8otOp2RRjqT0hfuctFU7htFHFUFD1fLP1F29tlQjoXdUh3Qo
 Jy5tq4SKSmsvzPOg3Of_vAR_8gFwT8yyFeA0ewmBnjUc7..fCT6CHdkheJt7qId9zL5z.paURZ42
 wjGaIv00Us1.qqpDmJc_2rqH8xM4N_7k_H7Yc4zDiK1A2yh9CPR3q2.gJuOgyf95LjfafeRqTAX8
 sGrGQKbIHmUYCySSZ.SMnI2Pu2jHHSQ9Yj2Ej6p4lGQowmUE6LCTB54YscX1YHiL0qn9DsXl.G20
 _MRSjQJEyPXDZP0bjLt051Nmk4FofKVYFYSxcXVw2moyRgyUSY2gitP7RG4kk27Z2oSQN2aXt5IJ
 Via2jvppa88aXhAN4WlIYaDJurgic7j3QA4e_p9Pdo_bclscAKPFc1JhJWEBUci6RvShdOhrvt46
 77ANJS0Wg0V5g.WWNhL2C0RVzo9cm3iEakn2s7epb8RQuAlngPih0lfc6R0GBZeRMtslhg0NjM4E
 D5chpBfY5pMlzL22OvRUglorORCcfjvi80xk4fHnXJt5908nVeOaFT3__1nUYmj8dhuFEr3co1Ap
 HIIoL70e_6FNBdXjxaOcY8D3.n4LH6lO1qQaYOZG1cemrN6W7sVS1YiTPOsHe6cIdFiXFisF8sx4
 ACBl_Bjqe76fLkZSRgh5AMEdGeNx_YbvR6zzHz8QNpbsCXlua4aV_Cd2NQOMDveIMBTeQ8vEO6Kf
 ow3atRAxefZDKRIXZQbbLj8Fcr533cdftNjjGdDbAcsrrKJRPQmJKP5FDeCaW.bYAqooi7.2TseS
 GcNAzqKGC5As5Ep14ZxADSnf6YMZdSlrwcYmM7M0fsy8LrkAVwv3VXquU.Qdd1fY8poV1yQyZIdy
 CgCao.URqMJFxnEakqVJB7k8b_7YUKIIvWCoSshMkmuCv152TDjPX79Ng8skQ9mWShWNzaHKu3gQ
 eWbjjldiMyATXHKuj7VZbIGnM0qXNgBNYcnK3safkxiNYA3tyvytwRP0cYEVj3NjyeiiM9uz0uOv
 eeqizZ9t6CxdtgZGp9FpnkcHSMRwm0yCmFnr4vf2nwboyt7Q5Dv2Pn_peA.WNRn6B0.1RiyTIrdP
 VFknawa5L7Sg5MYqU4bPGwA--
Received: from sonic.gate.mail.ne1.yahoo.com by
 sonic315.consmr.mail.gq1.yahoo.com with HTTP; Mon, 4 Nov 2019 07:28:36 +0000
Received: by smtp422.mail.gq1.yahoo.com (Oath Hermes SMTP Server) with ESMTPA
 ID 239129679cb26c683ce7e2126d239ff8; 
 Mon, 04 Nov 2019 07:28:34 +0000 (UTC)
To: Li Guifu <bluce.liguifu@huawei.com>,
	linux-erofs@lists.ozlabs.org
Subject: [PATCH v2] erofs-utils: add manual for mkfs.erofs
Date: Mon,  4 Nov 2019 15:28:17 +0800
Message-Id: <20191104072817.7936-1-hsiangkao@aol.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20191103153055.11471-1-hsiangkao@aol.com>
References: <20191103153055.11471-1-hsiangkao@aol.com>
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
From: Gao Xiang via Linux-erofs <linux-erofs@lists.ozlabs.org>
Reply-To: Gao Xiang <hsiangkao@aol.com>
Cc: Miao Xie <miaoxie@huawei.com>
Errors-To: linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org
Sender: "Linux-erofs"
 <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>

This patch adds mkfs.erofs manpage, which is a requirement of
a debian binary package (See Debian Policy Manual section 12.1 [1].)

[1] https://www.debian.org/doc/debian-policy/ch-docs.html#manual-pages
Signed-off-by: Gao Xiang <hsiangkao@aol.com>
---
changes since v1:
 - remove redundant whitespace in the previous version;
 - adjust long lines.

 Makefile.am      |  2 +-
 configure.ac     |  1 +
 man/Makefile.am  |  5 ++++
 man/mkfs.erofs.1 | 68 ++++++++++++++++++++++++++++++++++++++++++++++++
 4 files changed, 75 insertions(+), 1 deletion(-)
 create mode 100644 man/Makefile.am
 create mode 100644 man/mkfs.erofs.1

diff --git a/Makefile.am b/Makefile.am
index d94ab73..1d20577 100644
--- a/Makefile.am
+++ b/Makefile.am
@@ -3,4 +3,4 @@
 
 ACLOCAL_AMFLAGS = -I m4
 
-SUBDIRS=lib mkfs
+SUBDIRS = man lib mkfs
diff --git a/configure.ac b/configure.ac
index 4f88678..a93767f 100644
--- a/configure.ac
+++ b/configure.ac
@@ -173,6 +173,7 @@ AM_CONDITIONAL([ENABLE_LZ4], [test "x${have_lz4}" = "xyes"])
 AM_CONDITIONAL([ENABLE_LZ4HC], [test "x${have_lz4hc}" = "xyes"])
 
 AC_CONFIG_FILES([Makefile
+		 man/Makefile
 		 lib/Makefile
 		 mkfs/Makefile])
 AC_OUTPUT
diff --git a/man/Makefile.am b/man/Makefile.am
new file mode 100644
index 0000000..dcdbb35
--- /dev/null
+++ b/man/Makefile.am
@@ -0,0 +1,5 @@
+# SPDX-License-Identifier: GPL-2.0+
+# Makefile.am
+
+dist_man_MANS = mkfs.erofs.1
+
diff --git a/man/mkfs.erofs.1 b/man/mkfs.erofs.1
new file mode 100644
index 0000000..d6bf828
--- /dev/null
+++ b/man/mkfs.erofs.1
@@ -0,0 +1,68 @@
+.\" Copyright (c) 2019 Gao Xiang <xiang@kernel.org>
+.\"
+.TH MKFS.EROFS 1
+.SH NAME
+mkfs.erofs \- tool to create an EROFS filesystem
+.SH SYNOPSIS
+\fBmkfs.erofs\fR [\fIOPTIONS\fR] \fIDESTINATION\fR \fISOURCE\fR
+.SH DESCRIPTION
+EROFS is a new enhanced lightweight linux read-only filesystem with modern
+designs (eg. no buffer head, reduced metadata, inline xattrs/data, etc.) for
+scenarios which need high-performance read-only requirements, e.g. Android OS
+for smartphones and LIVECDs.
+.PP
+It also provides fixed-sized output compression support, which improves storage
+density, keeps relatively higher compression ratios, which is more useful to
+achieve high performance for embedded devices with limited memory since it has
+unnoticable memory overhead and page cache thrashing.
+.PP
+mkfs.erofs is used to create such EROFS filesystem \fIDESTINATION\fR image file
+from \fISOURCE\fR directory.
+.SH OPTIONS
+.TP
+.BI "\-z " compression-algorithm " [" ",#" "]"
+Set an algorithm for file compression, which can be set with an optional
+compression level separated by a comma.
+.TP
+.BI "\-d " #
+Specify the level of debugging messages. The default is 0.
+.TP
+.BI "\-x " #
+Specify the upper limit of an xattr which is still inlined. The default is 2.
+Disable storing xattrs if < 0.
+.TP
+.BI "\-E " extended-option " [,...]"
+Set extended options for the filesystem. Extended options are comma separated,
+and may take an argument using the equals ('=') sign.
+The following extended options are supported:
+.RS 1.2i
+.TP
+.BI legacy-compress
+Disable "decompression in-place" and "compacted indexes" support, which is used
+when generating EROFS images for kernel version < 5.3.
+.TP
+.BI force-inode-compact
+Forcely generate compact inodes (32-byte inodes) to output.
+.TP
+.BI force-inode-extended
+Forcely generate extended inodes (64-byte inodes) to output.
+.RE
+.TP
+.BI "\-T " #
+Set all files to the given UNIX timestamp. Reproducible builds requires setting
+all to a specific one.
+.TP
+.B \-\-help
+Display this help and exit.
+.SH AUTHOR
+This version of \fBmkfs.erofs\fR is written by Li Guifu <blucerlee@gmail.com>,
+Miao Xie <miaoxie@huawei.com> and Gao Xiang <xiang@kernel.org> with
+continuously improvements from others.
+.PP
+This manual page was written by Gao Xiang <xiang@kernel.org>.
+.SH AVAILABILITY
+\fBmkfs.erofs\fR is part of erofs-utils package and is available from
+git://git.kernel.org/pub/scm/linux/kernel/git/xiang/erofs-utils.git.
+.SH SEE ALSO
+.BR mkfs (8).
+
-- 
2.17.1

