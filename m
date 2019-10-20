Return-Path: <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>
X-Original-To: lists+linux-erofs@lfdr.de
Delivered-To: lists+linux-erofs@lfdr.de
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2401:3900:2:1::3])
	by mail.lfdr.de (Postfix) with ESMTPS id BBA7CDE037
	for <lists+linux-erofs@lfdr.de>; Sun, 20 Oct 2019 21:29:08 +0200 (CEST)
Received: from bilbo.ozlabs.org (lists.ozlabs.org [IPv6:2401:3900:2:1::3])
	by lists.ozlabs.org (Postfix) with ESMTP id 46x8w03vxwzDqPN
	for <lists+linux-erofs@lfdr.de>; Mon, 21 Oct 2019 06:29:04 +1100 (AEDT)
X-Original-To: linux-erofs@lists.ozlabs.org
Delivered-To: linux-erofs@lists.ozlabs.org
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized)
 smtp.mailfrom=gmail.com (client-ip=2607:f8b0:4864:20::542;
 helo=mail-pg1-x542.google.com; envelope-from=pratikshinde320@gmail.com;
 receiver=<UNKNOWN>)
Authentication-Results: lists.ozlabs.org;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: lists.ozlabs.org; dkim=pass (2048-bit key;
 unprotected) header.d=gmail.com header.i=@gmail.com header.b="Wjk/GMBQ"; 
 dkim-atps=neutral
Received: from mail-pg1-x542.google.com (mail-pg1-x542.google.com
 [IPv6:2607:f8b0:4864:20::542])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 46x8vp5QyRzDqKg
 for <linux-erofs@lists.ozlabs.org>; Mon, 21 Oct 2019 06:28:53 +1100 (AEDT)
Received: by mail-pg1-x542.google.com with SMTP id p1so6319157pgi.4
 for <linux-erofs@lists.ozlabs.org>; Sun, 20 Oct 2019 12:28:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=from:to:cc:subject:date:message-id;
 bh=nR5/PUycvY3vVFKY1gw3WwFO6bJ14K3sXYLBVXSi9VY=;
 b=Wjk/GMBQLsHEzT2/w1aDaC/FhEwRz5PVMC+wyOxAnn+YhUDJzFix/mmNmDYxsOIygj
 Z5U1v2OphFon6mejTVenFgy4cfkeY3YzrbtTE2WBn8KzgvPyUc9Uao66q7JI6B6SMHaL
 xcmH0FWJB6Px8d5ILH9yeEWdKP9+EE8BMifIxZ+VAei9LRX5dfpeo7YD04u1RAIeN0bp
 zlcPXLnkL4vezEXbBewAZXmjPUuRkiMKSw2QNrNWuwXFvnbh16tXx+Szyu7jNoq2FC8d
 DbOkKX3nuSZ8OwHwUO2gGq1UICUFEbf0JGCiLPaQtWOK70WqId6DZFbFULBAANvKDhvz
 zDkQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id;
 bh=nR5/PUycvY3vVFKY1gw3WwFO6bJ14K3sXYLBVXSi9VY=;
 b=WYzSl3o97p604wqwfFaYmoyZ296J/huWHN52aDZNjf2uPoDaF/dPrG/7mT4NTdoVd9
 gBzFbJherLhWgxumgNbJ/p2i1XJfHIGWic7LFJm1KQgCG9R1CYhh5yyvf8O2XSSgepPn
 RV4FzdbVUbG2a0zCWTauQGHfIQj/pYV42fnuaS/eO4po8ugGukzvh39uWGZPWjsQd7y1
 On9wEYKbcTxWN3qcs4lSda7moQE8TwfzF1hOFF6ZiaBnBvdumrP6WMAu3qstArDRqGt3
 2TvtwT0KY12EgI6fYcuepJSu3bfFALNWHKlM59QHAuJivGIzYx5PtQv1cbDQbj5TKtLX
 4sRw==
X-Gm-Message-State: APjAAAXbggId/e01afMdOMMCjSBRU4B8Z0yv3bviOZWD99lqLimi/sF8
 B+4oNGcgx95hyJRDNrbTEPwsGeEi3CoiFA==
X-Google-Smtp-Source: APXvYqwp7wjSNWzeTWuX/bI6akg2I4lMGylDNLvJ0EkJJHQpeuRn8Aza+tyzcHjom9yq8uEbMs2mOA==
X-Received: by 2002:a17:90a:d588:: with SMTP id
 v8mr23905743pju.51.1571599729521; 
 Sun, 20 Oct 2019 12:28:49 -0700 (PDT)
Received: from localhost.localdomain ([103.97.240.176])
 by smtp.gmail.com with ESMTPSA id p88sm12494994pjp.22.2019.10.20.12.28.46
 (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
 Sun, 20 Oct 2019 12:28:48 -0700 (PDT)
From: Pratik Shinde <pratikshinde320@gmail.com>
To: linux-erofs@lists.ozlabs.org,
	gaoxiang25@huawei.com,
	yuchao0@huawei.com
Subject: [PATCH] erofs: code for verifying superblock checksum of an erofs
 image.
Date: Mon, 21 Oct 2019 00:58:28 +0530
Message-Id: <20191020192828.10772-1-pratikshinde320@gmail.com>
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
Cc: linux-kernel@vger.kernel.org
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

