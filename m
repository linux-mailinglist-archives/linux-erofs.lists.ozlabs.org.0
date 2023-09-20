Return-Path: <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>
X-Original-To: lists+linux-erofs@lfdr.de
Delivered-To: lists+linux-erofs@lfdr.de
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	by mail.lfdr.de (Postfix) with ESMTPS id 832817A89A9
	for <lists+linux-erofs@lfdr.de>; Wed, 20 Sep 2023 18:41:51 +0200 (CEST)
Received: from boromir.ozlabs.org (localhost [IPv6:::1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4RrPSX6QHqz3cCm
	for <lists+linux-erofs@lfdr.de>; Thu, 21 Sep 2023 02:41:48 +1000 (AEST)
X-Original-To: linux-erofs@lists.ozlabs.org
Delivered-To: linux-erofs@lists.ozlabs.org
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=linux.alibaba.com (client-ip=115.124.30.98; helo=out30-98.freemail.mail.aliyun.com; envelope-from=hsiangkao@linux.alibaba.com; receiver=lists.ozlabs.org)
Received: from out30-98.freemail.mail.aliyun.com (out30-98.freemail.mail.aliyun.com [115.124.30.98])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4RrPSR4R14z2yGv
	for <linux-erofs@lists.ozlabs.org>; Thu, 21 Sep 2023 02:41:41 +1000 (AEST)
X-Alimail-AntiSpam: AC=PASS;BC=-1|-1;BR=01201311R151e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=ay29a033018045168;MF=hsiangkao@linux.alibaba.com;NM=1;PH=DS;RN=2;SR=0;TI=SMTPD_---0VsVaYri_1695228089;
Received: from e69b19392.et15sqa.tbsite.net(mailfrom:hsiangkao@linux.alibaba.com fp:SMTPD_---0VsVaYri_1695228089)
          by smtp.aliyun-inc.com;
          Thu, 21 Sep 2023 00:41:35 +0800
From: Gao Xiang <hsiangkao@linux.alibaba.com>
To: linux-erofs@lists.ozlabs.org
Subject: [PATCH] erofs-utils: manpages: update new options of mkfs.erofs
Date: Thu, 21 Sep 2023 00:41:28 +0800
Message-Id: <20230920164128.1637554-1-hsiangkao@linux.alibaba.com>
X-Mailer: git-send-email 2.39.3
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
Cc: Gao Xiang <hsiangkao@linux.alibaba.com>
Errors-To: linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org
Sender: "Linux-erofs" <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>

 -b block-size
 -E ^xattr-name-filter
 --gzip
 --tar=[fi]
 --xattr-prefix=X

Signed-off-by: Gao Xiang <hsiangkao@linux.alibaba.com>
---
 man/mkfs.erofs.1 | 23 +++++++++++++++++++++++
 1 file changed, 23 insertions(+)

diff --git a/man/mkfs.erofs.1 b/man/mkfs.erofs.1
index 1cfde28..5dd718d 100644
--- a/man/mkfs.erofs.1
+++ b/man/mkfs.erofs.1
@@ -26,6 +26,11 @@ compression level (1 to 12 for LZ4HC, 0 to 9 for LZMA and 100 to 109 for LZMA
 extreme compression) separated by a comma.  Alternative algorithms could be
 specified and separated by colons.
 .TP
+.BI "\-b " block-size
+Set the fundamental block size of the filesystem in bytes.  In other words,
+specify the smallest amount of data that can be accessed at a time.  The
+default is the system page size.  It cannot be less than 512 bytes.
+.TP
 .BI "\-C " max-pcluster-size
 Specify the maximum size of compress physical cluster in bytes.
 This may cause the big pcluster feature to be enabled (Linux v5.13+).
@@ -79,6 +84,9 @@ for compatibility with Linux pre-v5.4.
 .BI noinline_data
 Don't inline regular files to enable FSDAX for these files (Linux v5.15+).
 .TP
+.B ^xattr-name-filter
+Turn off/on xattr name filter to optimize negative xattr lookups (Linux v6.6+).
+.TP
 .BI ztailpacking
 Pack the tail part (pcluster) of compressed files into its metadata to save
 more space and the tail part I/O. (Linux v5.17+)
@@ -152,6 +160,9 @@ When this option is used together with
 the final file gids are
 set to \fIGID\fR + \fIGID-OFFSET\fR.
 .TP
+.B \-\-gzip
+Filter tarball streams through gzip.
+.TP
 .B \-\-help
 Display help string and exit.
 .TP
@@ -169,12 +180,24 @@ Use extended inodes instead of compact inodes if the file modification time
 would overflow compact inodes. This is the default. Overrides
 .BR --ignore-mtime .
 .TP
+.B "\-\-tar=f"
+Generate a full EROFS image from a tarball.
+.TP
+.B "\-\-tar=i"
+Generate an meta-only EROFS image from a tarball.
+.TP
 .BI "\-\-uid-offset=" UIDOFFSET
 Add \fIUIDOFFSET\fR to all file UIDs.
 When this option is used together with
 .BR --force-uid ,
 the final file uids are
 set to \fIUID\fR + \fIUIDOFFSET\fR.
+.TP
+.BI "\-\-xattr-prefix=" PREFIX
+Specify a customized extended attribute namespace prefix for space saving,
+e.g. "trusted.overlay.".  You may give multiple
+.B --xattr-prefix
+options. (Linux v6.4+)
 .SH AUTHOR
 This version of \fBmkfs.erofs\fR is written by Li Guifu <blucerlee@gmail.com>,
 Miao Xie <miaoxie@huawei.com> and Gao Xiang <xiang@kernel.org> with
-- 
2.39.3

