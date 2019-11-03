Return-Path: <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>
X-Original-To: lists+linux-erofs@lfdr.de
Delivered-To: lists+linux-erofs@lfdr.de
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2401:3900:2:1::3])
	by mail.lfdr.de (Postfix) with ESMTPS id EA3ECED3B3
	for <lists+linux-erofs@lfdr.de>; Sun,  3 Nov 2019 16:31:44 +0100 (CET)
Received: from bilbo.ozlabs.org (lists.ozlabs.org [IPv6:2401:3900:2:1::3])
	by lists.ozlabs.org (Postfix) with ESMTP id 475fzd64bDzDrJ1
	for <lists+linux-erofs@lfdr.de>; Mon,  4 Nov 2019 02:31:41 +1100 (AEDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=lists.ozlabs.org;
	s=201707; t=1572795101;
	bh=uuuGd1kgDtEBkx21NE/ytcSoRfcXODJDJnC/aQsgOdk=;
	h=To:Subject:Date:References:List-Id:List-Unsubscribe:List-Archive:
	 List-Post:List-Help:List-Subscribe:From:Reply-To:Cc:From;
	b=bOjGfC8zNvNuNUPyspxcbv3Z7PJjuUEFQXZVsfnCgN1MX8LECHwnm/QNAUTgc1QSy
	 2XcPxKh0Ah6SsCZOpMs8sfe30VVhXAiCcutTaEFPTI6FcEqQt+n46onu0RVlFqPIn2
	 prXtd/CmBzrkVw48MxIBSgZVaHzOFonq2Dzcrkc2/dRCdlLwUHMfg/XQrrmKvLiAN6
	 kFoq7Y2OImgeCAtz7/EGe9M7MBqzOBwjxa5vA/MwQgMSsyVPVp82C1HQyUjE7Ezjw+
	 kYl9hhZLHuG+p9+WTisX074cu51xUxoNnpjkMJZJDNtzQYyqW8Sw+FpxOSbd8f0rfe
	 gRyJyd2Ld0ZUw==
X-Original-To: linux-erofs@lists.ozlabs.org
Delivered-To: linux-erofs@lists.ozlabs.org
Authentication-Results: lists.ozlabs.org;
 spf=pass (sender SPF authorized) smtp.mailfrom=aol.com
 (client-ip=98.137.65.205; helo=sonic311-24.consmr.mail.gq1.yahoo.com;
 envelope-from=hsiangkao@aol.com; receiver=<UNKNOWN>)
Authentication-Results: lists.ozlabs.org;
 dmarc=pass (p=reject dis=none) header.from=aol.com
Authentication-Results: lists.ozlabs.org; dkim=pass (2048-bit key;
 unprotected) header.d=aol.com header.i=@aol.com header.b="fao4WoXb"; 
 dkim-atps=neutral
Received: from sonic311-24.consmr.mail.gq1.yahoo.com
 (sonic311-24.consmr.mail.gq1.yahoo.com [98.137.65.205])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 475fzL39MJzDqZL
 for <linux-erofs@lists.ozlabs.org>; Mon,  4 Nov 2019 02:31:24 +1100 (AEDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=aol.com; s=a2048;
 t=1572795080; bh=6C2L0nR5xC/VgaZ/aZ7HjNajUT3aE8WNd4EMaz1+6o8=;
 h=From:To:Cc:Subject:Date:References:From:Subject;
 b=fao4WoXb07QazAFPj7UK18gLEwmIyQALhr3s5S8iHOt4HaI06iEb48axEXITSDV0aHRkZvirQQCL9UEhH8bHLdVPg/aH9RmuwBHgMCfGTZ3SM2qQ5YG8uSMZ7d6yl6KHwRZklp6qISev8kPKdfyRvTlXgJYR6LflKQIO7WFVFoAtTKL8/Ln6zCa49tY33fsdlifpwtz1FzpCxTRvdVgDYjP7Ewpce9gn+uXN2SjP+kdspdFm4rIuS8t8Sz82RWq3ecTQAX5H6TTV3GsQRoIacEKKFWtSxm0udh08LKr3j8n+TP9YbHXuHeGfsiGXiPtQbJDyWywna/7+HVFcGVesfQ==
X-YMail-OSG: 56UsztAVM1l68CzR7looqzm2ELiEpq_MiYpookDxLDSrTaqZYBbLTnU8maE5Uld
 gUOTuw4YVlQFAtRpdiPhU73CKBdEy4Pd8__dgZde9CTntnZLP19TfBa_CRYykzv.Kku7Jwf9Rrau
 eOkAS4TptchwT8u99xhRSz5TDEm7Ep.VZjIUH.G2xhrJqDIzb7SjQEdVlIxEapAuU99nBQXuNk.u
 FZ4Wy3DfgAQWe5CY7PbMDOjC2maz9fMJl8ZwIcESnuj3c00TWe7RHEXcM29efbcJevjbqevOAdjY
 0CJzVMmmD3C90pODcEfRcnu7hYxN2kQSFG933FqjAHsEonKi40pngJ33Rs_OPWIRdb_xfoESYsXV
 ZWAXcaJkr6NpXdi.rR_ihrpN.a_1pWTpluDbHv31STq_nIxmNX54QZXkHSYs.YmZKO.i_E.dcqzO
 2wlb0nG6Dlh2XMG0DA1tWVwuHFok74i5OhscdV0.MEN2cPeYikb95wtJ3.aTGsQ32431mOjk8RTk
 XiPlZs7EeL5kbhi7rPCqcrATpyS7IU779aHsJRfE6vbHYK25K.TGwXImBKyFj5EvPTbS9hlLMeG0
 Pme0laJhVE7oDhjuMtRcyc8E8oaE5aH_.rrnYrXcmvftZmgffF.Ruqwc5TFQizUFc7Ku322NYlG.
 Kc1.FTknYdiElpQnz_DeiYcUupf1xdczFheVAjNU0dYHxjaAiD0bk3zGQmv4yeFEezX1TMfXYGNm
 o4zFKQ7OxKevuuQfzTXjQK4lwfckp0GTpKZAVBRu9kBj4plYLqd_izyYL6aXp8_53CWK1BTvyPj7
 D22ME4iZpjtATKKaV.iX2rErPgdcPhH0GD3XwHu0QjBE8twYhV7fPskVt9HlMTJ6Vtj0rCR3kSEY
 EZhukBB3UrMBwb0bYPUhw6iuqGME1SjPVcUzUYvkeW0v_pv231aT33vk_RvxMvKu3ignJy7M81j7
 CQh2KSfEVdE471MXbKuXRAFHDjY8qG365L1DcoUR_SNiLs46VFEGJRSU_IiKKC8tNUTKouXURgPe
 y2x6k52NIcU2NOoPZc0icYBXjQl3rqXLeKuJFF75bAqNHp0dl3hulNa.UK3f3roPB4w97Mlcgr_W
 C0oiboarF5VcCCIhl0okVN7TuXKLHWlUtSIPS3BxdiX0LDX1L.42gaRU1qLf9C4jH86FK65six9k
 E2pthvvEq39F4F0rDbHifhvy3MyNVsQq_mNF_pi0MrdJYdbC91EBc6oScxCsjO4rfW.IlGmkpCdd
 WF8OCi71CFHnJaTVzGNmz6igX_Xcw6lV78lxOGQ2ae2j7rRrMkYMjNRkDxUpqYv9k5E0pNqt1iYO
 lb_8Z9qkc8ejlYmLecgtRkctnL_Ipr7Kls9X4rcht87mn_lh1KtX8GwNnoWK7gg0jqp52XCMhR.6
 xbaEX4NmqBxKh
Received: from sonic.gate.mail.ne1.yahoo.com by
 sonic311.consmr.mail.gq1.yahoo.com with HTTP; Sun, 3 Nov 2019 15:31:20 +0000
Received: by smtp404.mail.ir2.yahoo.com (Oath Hermes SMTP Server) with ESMTPA
 ID f24b5b2ef490fb6c4b107b2d97cf1d16; 
 Sun, 03 Nov 2019 15:31:15 +0000 (UTC)
To: Li Guifu <bluce.liguifu@huawei.com>,
	linux-erofs@lists.ozlabs.org
Subject: [PATCH] erofs-utils: add manual for mkfs.erofs
Date: Sun,  3 Nov 2019 23:30:55 +0800
Message-Id: <20191103153055.11471-1-hsiangkao@aol.com>
X-Mailer: git-send-email 2.17.1
References: <20191103153055.11471-1-hsiangkao.ref@aol.com>
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

This patch adds mkfs.erofs manpage, which is a requirement of a
debian binary package (See Debian Policy Manual section 12.1 [1].)

[1] https://www.debian.org/doc/debian-policy/ch-docs.html#manual-pages
Signed-off-by: Gao Xiang <hsiangkao@aol.com>
---
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
index 0000000..7fb1464
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
+Set extended options for the filesystem.  Extended options are comma separated,
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
+Set all files to this given UNIX timestamp. Reproducible builds requires setting
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

