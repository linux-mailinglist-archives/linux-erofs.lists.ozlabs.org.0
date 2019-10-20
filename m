Return-Path: <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>
X-Original-To: lists+linux-erofs@lfdr.de
Delivered-To: lists+linux-erofs@lfdr.de
Received: from lists.ozlabs.org (lists.ozlabs.org [203.11.71.2])
	by mail.lfdr.de (Postfix) with ESMTPS id 7336ADDE85
	for <lists+linux-erofs@lfdr.de>; Sun, 20 Oct 2019 15:03:55 +0200 (CEST)
Received: from bilbo.ozlabs.org (lists.ozlabs.org [IPv6:2401:3900:2:1::3])
	by lists.ozlabs.org (Postfix) with ESMTP id 46x0MX2w7TzDqP2
	for <lists+linux-erofs@lfdr.de>; Mon, 21 Oct 2019 00:03:52 +1100 (AEDT)
X-Original-To: linux-erofs@lists.ozlabs.org
Delivered-To: linux-erofs@lists.ozlabs.org
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized)
 smtp.mailfrom=gmail.com (client-ip=2607:f8b0:4864:20::542;
 helo=mail-pg1-x542.google.com; envelope-from=pratikshinde320@gmail.com;
 receiver=<UNKNOWN>)
Authentication-Results: lists.ozlabs.org;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: lists.ozlabs.org; dkim=pass (2048-bit key;
 unprotected) header.d=gmail.com header.i=@gmail.com header.b="kMAfrjX3"; 
 dkim-atps=neutral
Received: from mail-pg1-x542.google.com (mail-pg1-x542.google.com
 [IPv6:2607:f8b0:4864:20::542])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 46x0MK0zCfzDqKD
 for <linux-erofs@lists.ozlabs.org>; Mon, 21 Oct 2019 00:03:40 +1100 (AEDT)
Received: by mail-pg1-x542.google.com with SMTP id t3so5970935pga.8
 for <linux-erofs@lists.ozlabs.org>; Sun, 20 Oct 2019 06:03:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=from:to:cc:subject:date:message-id;
 bh=nR5/PUycvY3vVFKY1gw3WwFO6bJ14K3sXYLBVXSi9VY=;
 b=kMAfrjX3hz8AKNUPnyt1C30+pni8KyNeN4WT79xNxdBWuLnrIEqi0wW/waGEsrzqrZ
 0aSHQxIDR4SanqgFSl04f5EEwVFwumwULuWo11nh96x682mjTXxmRznYEmHAhEtweMHv
 AieBABN0WRgpDoLf6P1mVhvLQLYg+gY1TLklfvlOfdghRorDmM+2Q2W+SzHJVVGzx/c6
 /fPDXIbbrjKyZ3d9YTfT1nNzuv92nEFJR4BhrlyGysXyqFMOH62ft+o7oOkBgdJT/UA4
 t2HITzPp0qTbkhQYpcymtaWYabg3OV5UkO8NcL31SzD6NjRVm3k+gOHBv4NMlGmti7cv
 gOBw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id;
 bh=nR5/PUycvY3vVFKY1gw3WwFO6bJ14K3sXYLBVXSi9VY=;
 b=nP9sgeS2RpB2Kd2gVyU4af7D2LFqDk1GYWtlNdCMhTapNayjSR4Bq/NdMEe7nTlU1h
 51GND+NCf63wyOKYHgMM1//TavV1xmkJqtYDS0gYeEqCIDytPbigHTRQMNrGmIDWRGWf
 uDslpv70loXWN0JZGmHQLY/dWy11G7MszY0ZGnd/luA45PxN64GDz07ECAU07I0RVNdo
 V6dVCb/pR7vQ58l0Rq1Vcr4AdwNaURdOV7Ipi9mgvj/p1eFOJKP+UaWm39EcU9IDIF0R
 cDUrVbPKvoBkycgis3i5fSvS1PuB373z4o5vli+jjDtYteG56S2SWKPs5jcJkTkvV5p2
 ICUw==
X-Gm-Message-State: APjAAAVdDY9tUTeP8GAX9Ncngyvq2QxUOZP61P+qDjbcUg1fdQPdekmo
 mkipObRw5Ld/R2APHXgm8ejNcIm21uUQlA==
X-Google-Smtp-Source: APXvYqwMkAsYmPcEbXIC0VqSknpvJtpvlH9AXsbtVbQOBs29vruNDRj7akGTLf0uM5JBahC3dNUJUw==
X-Received: by 2002:a17:90a:86c2:: with SMTP id
 y2mr22220394pjv.105.1571576616591; 
 Sun, 20 Oct 2019 06:03:36 -0700 (PDT)
Received: from localhost.localdomain ([42.106.200.99])
 by smtp.gmail.com with ESMTPSA id q132sm13032611pfq.16.2019.10.20.06.03.33
 (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
 Sun, 20 Oct 2019 06:03:35 -0700 (PDT)
From: Pratik Shinde <pratikshinde320@gmail.com>
To: linux-erofs@lists.ozlabs.org,
	gaoxiang25@huawei.com,
	yuchao0@huawei.com
Subject: [PATCH] erofs: code for verifying superblock checksum of an erofs
 image.
Date: Sun, 20 Oct 2019 18:33:20 +0530
Message-Id: <20191020130320.10193-1-pratikshinde320@gmail.com>
X-Mailer: git-send-email 2.9.3
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
Errors-To: linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org
Sender: "Linux-erofs"
 <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>

Patch for kernel side changes of checksum feature.I used kernel's
crc32c library for calculating the checksum.

Signed-off-by: Pratik Shinde <pratikshinde320@gmail.com>
---
 fs/erofs/erofs_fs.h |  5 +++--
 fs/erofs/internal.h |  2 +-
 fs/erofs/super.c    | 50 ++++++++++++++++++++++++++++++++++++++++++++++----
 3 files changed, 50 insertions(+), 7 deletions(-)

diff --git a/fs/erofs/erofs_fs.h b/fs/erofs/erofs_fs.h
index b1ee565..bab5506 100644
--- a/fs/erofs/erofs_fs.h
+++ b/fs/erofs/erofs_fs.h
@@ -17,6 +17,7 @@
  */
 #define EROFS_FEATURE_INCOMPAT_LZ4_0PADDING	0x00000001
 #define EROFS_ALL_FEATURE_INCOMPAT		EROFS_FEATURE_INCOMPAT_LZ4_0PADDING
+#define EROFS_FEATURE_SB_CHKSUM 0x0001
 
 /* 128-byte erofs on-disk super block */
 struct erofs_super_block {
@@ -37,8 +38,8 @@ struct erofs_super_block {
 	__u8 uuid[16];          /* 128-bit uuid for volume */
 	__u8 volume_name[16];   /* volume name */
 	__le32 feature_incompat;
-
-	__u8 reserved2[44];
+	__le32 chksum_blocks;	/* number of blocks used for checksum */
+	__u8 reserved2[40];
 };
 
 /*
diff --git a/fs/erofs/internal.h b/fs/erofs/internal.h
index 544a453..cd3af45 100644
--- a/fs/erofs/internal.h
+++ b/fs/erofs/internal.h
@@ -86,7 +86,7 @@ struct erofs_sb_info {
 	u8 uuid[16];                    /* 128-bit uuid for volume */
 	u8 volume_name[16];             /* volume name */
 	u32 feature_incompat;
-
+	u32 features;
 	unsigned int mount_opt;
 };
 
diff --git a/fs/erofs/super.c b/fs/erofs/super.c
index 0e36949..94e1d6a 100644
--- a/fs/erofs/super.c
+++ b/fs/erofs/super.c
@@ -9,6 +9,7 @@
 #include <linux/statfs.h>
 #include <linux/parser.h>
 #include <linux/seq_file.h>
+#include <linux/crc32c.h>
 #include "xattr.h"
 
 #define CREATE_TRACE_POINTS
@@ -46,6 +47,45 @@ void _erofs_info(struct super_block *sb, const char *function,
 	va_end(args);
 }
 
+static int erofs_validate_sb_chksum(struct erofs_super_block *dsb,
+				       struct super_block *sb)
+{
+	u32 disk_chksum = le32_to_cpu(dsb->checksum);
+	u32 nblocks = le32_to_cpu(dsb->chksum_blocks);
+	u32 crc;
+	struct erofs_super_block *dsb2;
+	char *buf;
+	unsigned int off = 0;
+	void *kaddr;
+	struct page *page;
+	int i, ret = -EINVAL;
+
+	buf = kmalloc(nblocks * EROFS_BLKSIZ, GFP_KERNEL);
+	if (!buf)
+		goto out;
+	for (i = 0; i < nblocks; i++) {
+		page = erofs_get_meta_page(sb, i);
+		if (IS_ERR(page))
+			goto out;
+		kaddr = kmap_atomic(page);
+		(void) memcpy(buf + off, kaddr, EROFS_BLKSIZ);
+		kunmap_atomic(kaddr);
+		unlock_page(page);
+		/* first page will be released by erofs_read_superblock */
+		if (i != 0)
+			put_page(page);
+		off += EROFS_BLKSIZ;
+	}
+	dsb2 = (struct erofs_super_block *)(buf + EROFS_SUPER_OFFSET);
+	dsb2->checksum = 0;
+	crc = crc32c(0, buf, nblocks * EROFS_BLKSIZ);
+	if (crc != disk_chksum)
+		goto out;
+	ret = 0;
+out:	kfree(buf);
+	return ret;
+}
+
 static void erofs_inode_init_once(void *ptr)
 {
 	struct erofs_inode *vi = ptr;
@@ -109,18 +149,20 @@ static int erofs_read_superblock(struct super_block *sb)
 		erofs_err(sb, "cannot read erofs superblock");
 		return PTR_ERR(page);
 	}
-
 	sbi = EROFS_SB(sb);
-
 	data = kmap_atomic(page);
 	dsb = (struct erofs_super_block *)(data + EROFS_SUPER_OFFSET);
-
 	ret = -EINVAL;
 	if (le32_to_cpu(dsb->magic) != EROFS_SUPER_MAGIC_V1) {
 		erofs_err(sb, "cannot find valid erofs superblock");
 		goto out;
 	}
-
+	if (dsb->feature_compat & EROFS_FEATURE_SB_CHKSUM) {
+		if (erofs_validate_sb_chksum(dsb, sb)) {
+			erofs_err(sb, "super block checksum incorrect");
+			goto out;
+		}
+	}
 	blkszbits = dsb->blkszbits;
 	/* 9(512 bytes) + LOG_SECTORS_PER_BLOCK == LOG_BLOCK_SIZE */
 	if (blkszbits != LOG_BLOCK_SIZE) {
-- 
2.9.3

