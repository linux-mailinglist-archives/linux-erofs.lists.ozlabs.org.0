Return-Path: <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>
X-Original-To: lists+linux-erofs@lfdr.de
Delivered-To: lists+linux-erofs@lfdr.de
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2404:9400:2:0:216:3eff:fee1:b9f1])
	by mail.lfdr.de (Postfix) with ESMTPS id ED2D9A1AED8
	for <lists+linux-erofs@lfdr.de>; Fri, 24 Jan 2025 03:47:29 +0100 (CET)
Received: from boromir.ozlabs.org (localhost [IPv6:::1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4YfMfl0jPnz30QX
	for <lists+linux-erofs@lfdr.de>; Fri, 24 Jan 2025 13:47:27 +1100 (AEDT)
X-Original-To: linux-erofs@lists.ozlabs.org
Delivered-To: linux-erofs@lists.ozlabs.org
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip=115.124.30.133
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1737686845;
	cv=none; b=moBWoYsQeJ0lqbvhtEWtj10S6qhw/5+vl5LRXlQlzyRar9obYWXDM5q9Uc13yVeaWKJg5CZ8cn0Rn4VNDXII1JWvuMzERCRDZL8ARxI+y/zryclRAafbqcWelmuxrs+LNRTcJ/6gzSvJGQJlP9xRvHiGmvscTnhZzqUpjmou1ZhxSpHm+Nphp/TXn90qyPOSrwAmoAo3f627qYIwMYTJpEzyFZQ7KJcgUNxMmRrPHPmNFRGbNroFJ1nOL2PtdCBIyhYbsHU4/eiGgF3Lmkbr78lAmKrXF5YvrvjqS3Y7K/snolvXFtodqJ270xL1AaRQrxp/yQk8ZUJjkAwd9aGYag==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1737686845; c=relaxed/relaxed;
	bh=omVyYtcfGHSsIbFE2TsLXX+Zn6woRsryFWRi+UlB2T0=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=M30B3JVXOhFkTGN5EDlD9FKq5cKhfuD1iZbKZznBvyCES3fVqDIiAbXHYYJw4Gn6C8ikCqgTm8I8s+uAQ06dBPvupAdfVeA/zqC4EYYUWw4FBKlJ9jtYnz9url70Pw5+OFwJszpLamZ+VCFCS0Cr6jKuOBznquPzfeDefvZUI31twG0YoYOeSgYa3ZcmMbum0U6nfXVabSxzuhHVnL5JxEQhZY4E/EHLh8vynyp6fozsyjGzQztws670kLHmJHwSfiqBmJ1CSBkEMsFDqtMsnvIb2/EmOHzPpcrvwHo377qy1XpM4vTI1vq8R93O+JcYltFG6TjJv4a0G+BaZaiLMg==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com; dkim=pass (1024-bit key; unprotected) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.a=rsa-sha256 header.s=default header.b=kpM+z0kv; dkim-atps=neutral; spf=pass (client-ip=115.124.30.133; helo=out30-133.freemail.mail.aliyun.com; envelope-from=hsiangkao@linux.alibaba.com; receiver=lists.ozlabs.org) smtp.mailfrom=linux.alibaba.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (1024-bit key; unprotected) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.a=rsa-sha256 header.s=default header.b=kpM+z0kv;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=linux.alibaba.com (client-ip=115.124.30.133; helo=out30-133.freemail.mail.aliyun.com; envelope-from=hsiangkao@linux.alibaba.com; receiver=lists.ozlabs.org)
Received: from out30-133.freemail.mail.aliyun.com (out30-133.freemail.mail.aliyun.com [115.124.30.133])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4YfMfh0jyhz2yMF
	for <linux-erofs@lists.ozlabs.org>; Fri, 24 Jan 2025 13:47:22 +1100 (AEDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=linux.alibaba.com; s=default;
	t=1737686837; h=From:To:Subject:Date:Message-ID:MIME-Version;
	bh=omVyYtcfGHSsIbFE2TsLXX+Zn6woRsryFWRi+UlB2T0=;
	b=kpM+z0kvi8ZyKurrfcserJs642kZcz8uqtXW4CQEmCuG/3mLog0GGV7f24qZPrR+lTWe2lq1U/woEpENH7TW5K5AtsrAX3bgJ4YI6gPneuwgPEGFaXyEFKkk84+8pr+62rcCzZT+jJXQ6I1Vb70TqTcsPnPYiGgJYzpImzh7iwA=
Received: from x31i01179.sqa.na131.tbsite.net(mailfrom:hsiangkao@linux.alibaba.com fp:SMTPD_---0WOD30dn_1737686832 cluster:ay36)
          by smtp.aliyun-inc.com;
          Fri, 24 Jan 2025 10:47:16 +0800
From: Gao Xiang <hsiangkao@linux.alibaba.com>
To: linux-erofs@lists.ozlabs.org
Subject: [PATCH] erofs-utils: manpages: update new option of mkfs.erofs
Date: Fri, 24 Jan 2025 10:47:11 +0800
Message-ID: <20250124024711.2320620-1-hsiangkao@linux.alibaba.com>
X-Mailer: git-send-email 2.43.5
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-15.7 required=5.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,DKIM_VALID_EF,ENV_AND_HDR_SPF_MATCH,RCVD_IN_DNSWL_NONE,
	SPF_HELO_NONE,SPF_PASS,UNPARSEABLE_RELAY,USER_IN_DEF_DKIM_WL,
	USER_IN_DEF_SPF_WL autolearn=disabled version=4.0.0
X-Spam-Checker-Version: SpamAssassin 4.0.0 (2022-12-13) on lists.ozlabs.org
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

Add `-E fragdedupe` and revise some descriptions.

Signed-off-by: Gao Xiang <hsiangkao@linux.alibaba.com>
---
 man/mkfs.erofs.1 | 33 +++++++++++++++++++++++++--------
 1 file changed, 25 insertions(+), 8 deletions(-)

diff --git a/man/mkfs.erofs.1 b/man/mkfs.erofs.1
index 0093839..698ed5b 100644
--- a/man/mkfs.erofs.1
+++ b/man/mkfs.erofs.1
@@ -45,9 +45,10 @@ warning messages.
 Limit how many xattrs will be inlined. The default is 2.
 Disables storing xattrs if < 0.
 .TP
-.BI "\-E " extended-option \fR[\fP, ... \fR]\fP
+.BI "\-E " [^]extended-option \fR[\fP, ... \fR]\fP
 Set extended options for the filesystem. Extended options are comma separated,
-and may take an extra argument using the equals ('=') sign.
+and may take an extra argument using the equals ('=') sign.  To disable a
+feature, usually prefix the extended option name with a caret ('^') character.
 The following extended options are supported:
 .RS 1.2i
 .TP
@@ -74,20 +75,36 @@ Force generation of inode chunk format as a 4-byte block address array.
 .BI force-chunk-indexes
 Forcely generate inode chunk format as an 8-byte chunk index (with device ID).
 .TP
+.BI [^]fragdedupe\fR[\fP= <inode|full> \fR]\fP
+Set the mode for fragment data deduplication.  It's effective only when
+\fI-E(all)-fragments\fR is used together.  If a caret ('^') character is set,
+fragment data deduplication is disabled.
+.RS 1.2i
+.TP
+.I inode
+Deduplicate fragment data only when the inode data is identical.  This option
+will result in faster image generation with the current codebase
+.TP
+.I full
+Always deduplicate fragment data if possible
+.RE
+.TP
 .BI fragments\fR[\fP= size \fR]\fP
 Pack the tail part (pcluster) of compressed files, or entire files, into a
 special inode for smaller image sizes, and it may take an argument as the
 pcluster size of the packed inode in bytes. (Linux v6.1+)
 .TP
+.BI ^inline_data
+Don't inline regular files.  It's typically useful to enable FSDAX (Linux 5.15+)
+for those images, however, there could be other use cases too.
+.TP
 .BI legacy-compress
 Disable "inplace decompression" and "compacted indexes",
 for compatibility with Linux pre-v5.4.
 .TP
-.BI noinline_data
-Don't inline regular files to enable FSDAX for these files (Linux v5.15+).
-.TP
-.B ^xattr-name-filter
-Turn off/on xattr name filter to optimize negative xattr lookups (Linux v6.6+).
+.B xattr-name-filter
+Enable a name filter for extended attributes to optimize negative lookups.
+(Linux v6.6+).
 .TP
 .BI ztailpacking
 Pack the tail part (pcluster) of compressed files into its metadata to save
@@ -97,7 +114,7 @@ more space and the tail part I/O. (Linux v5.17+)
 .BI "\-L " volume-label
 Set the volume label for the filesystem to
 .IR volume-label .
-The maximum length of the volume label is 16 bytes.
+The maximum length of the volume label is 15 bytes.
 .TP
 .BI "\-T " #
 Specify a UNIX timestamp for image creation time for reproducible builds.
-- 
2.43.5

