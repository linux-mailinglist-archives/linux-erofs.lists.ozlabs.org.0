Return-Path: <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>
X-Original-To: lists+linux-erofs@lfdr.de
Delivered-To: lists+linux-erofs@lfdr.de
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2401:3900:2:1::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 2B7F6E0799
	for <lists+linux-erofs@lfdr.de>; Tue, 22 Oct 2019 17:40:28 +0200 (CEST)
Received: from bilbo.ozlabs.org (lists.ozlabs.org [IPv6:2401:3900:2:1::3])
	by lists.ozlabs.org (Postfix) with ESMTP id 46yHlD4TkkzDqLG
	for <lists+linux-erofs@lfdr.de>; Wed, 23 Oct 2019 02:40:24 +1100 (AEDT)
X-Original-To: linux-erofs@lists.ozlabs.org
Delivered-To: linux-erofs@lists.ozlabs.org
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized)
 smtp.mailfrom=gmail.com (client-ip=2607:f8b0:4864:20::443;
 helo=mail-pf1-x443.google.com; envelope-from=pratikshinde320@gmail.com;
 receiver=<UNKNOWN>)
Authentication-Results: lists.ozlabs.org;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: lists.ozlabs.org; dkim=pass (2048-bit key;
 unprotected) header.d=gmail.com header.i=@gmail.com header.b="ptV9anfs"; 
 dkim-atps=neutral
Received: from mail-pf1-x443.google.com (mail-pf1-x443.google.com
 [IPv6:2607:f8b0:4864:20::443])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 46yHl5051bzDqKL
 for <linux-erofs@lists.ozlabs.org>; Wed, 23 Oct 2019 02:40:14 +1100 (AEDT)
Received: by mail-pf1-x443.google.com with SMTP id q5so10871057pfg.13
 for <linux-erofs@lists.ozlabs.org>; Tue, 22 Oct 2019 08:40:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=from:to:cc:subject:date:message-id;
 bh=+0awgcrU0T0gJr+sSnKtP3Vx7pwyrZ4ja7Mttfvl/RM=;
 b=ptV9anfs6GPxZoupqgTAdWXbToAEdpkjso3HaFKaHa87FGi+1V9TCAfkSJBHlxcDl4
 KZ/BGcCqnStgrkx4RojbK921FbE80nYktDJMw1d1TfC2I7WMFECpNFfOqliYL/sqqygc
 o89ONML8Vgzkeu5Jk/23T2PUEJPIl/o3xv0Iq0huanxL+DlJvVHLopetTpNMZCmuEdPI
 sdjQwc/PZL5aHdSkDfBpCSQPjoWPF8k5h/RBsKoh+2alue0colVNMdmB+gipEu1Jqk6J
 XU7WDAZ+pe85eRf//yjQEke8MnXe45cdn06w4/gqgN1lTUX/QeEy6hdmLZnWCjz979KY
 MYHw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id;
 bh=+0awgcrU0T0gJr+sSnKtP3Vx7pwyrZ4ja7Mttfvl/RM=;
 b=QxDiyRe9fQT8RBz/ZWJJRnRVqPk3kgy0nrlwAqDodxAYUWotFK6fr97Ac8RuFNFuPq
 2Jdw2yo+y3D5iwqDyVtAv0/0PKl5KZAD4jVpUjPNf97/KrjDvGj9fT1pNsrMJandRdGb
 bVVvTb8bo+A60XAXtIUzsDoDyWr9zNuTipGKVEJyaHt+h0+Pgezr01ApD35jF1iV83SO
 wQQsa7aKpAeYVKRlNAhpbYjxKgosTz2gCPgZqjICmuI8RKPhyjAKMKIafG2ZODnNQWdD
 Ui15NfwXUBpTg5gvdG7lT8r2/E4w5dM/E1Ou5M5heSV6CyfCFLUeBXdBOHT8EFswl659
 b0GA==
X-Gm-Message-State: APjAAAVBLLT55q9rs8RpSgUN4f3uW1LIKp3vnrPdsjBtH6jNALOQOjfw
 wfqZrRmGViPdGc7D+oAcPsG9CeNAcgLscA==
X-Google-Smtp-Source: APXvYqyhOzqPkG9SY667uXj7vH84dggmUhKFAaW+1vl+BwIHPrCdFqxt+lrxu5e11Q/329BPT36VxA==
X-Received: by 2002:a62:ae06:: with SMTP id q6mr5021963pff.96.1571758810041;
 Tue, 22 Oct 2019 08:40:10 -0700 (PDT)
Received: from localhost.localdomain ([42.107.68.84])
 by smtp.gmail.com with ESMTPSA id j10sm19681856pfn.128.2019.10.22.08.40.06
 (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
 Tue, 22 Oct 2019 08:40:09 -0700 (PDT)
From: Pratik Shinde <pratikshinde320@gmail.com>
To: linux-erofs@lists.ozlabs.org,
	gaoxiang25@huawei.com,
	yuchao0@huawei.com
Subject: [PATCH-v2] erofs: code for verifying superblock checksum of an erofs
 image.
Date: Tue, 22 Oct 2019 21:09:56 +0530
Message-Id: <20191022153956.16867-1-pratikshinde320@gmail.com>
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

Patch for kernel side changes of checksum feature.Used kernel's
crc32c library for calculating the checksum.

Signed-off-by: Pratik Shinde <pratikshinde320@gmail.com>
---
 fs/erofs/erofs_fs.h |  5 +++--
 fs/erofs/internal.h |  3 ++-
 fs/erofs/super.c    | 33 +++++++++++++++++++++++++++++++++
 3 files changed, 38 insertions(+), 3 deletions(-)

diff --git a/fs/erofs/erofs_fs.h b/fs/erofs/erofs_fs.h
index b1ee565..4d8097a 100644
--- a/fs/erofs/erofs_fs.h
+++ b/fs/erofs/erofs_fs.h
@@ -17,6 +17,7 @@
  */
 #define EROFS_FEATURE_INCOMPAT_LZ4_0PADDING	0x00000001
 #define EROFS_ALL_FEATURE_INCOMPAT		EROFS_FEATURE_INCOMPAT_LZ4_0PADDING
+#define EROFS_FEATURE_COMPAT_SB_CHKSUM 		0x00000001
 
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
index 544a453..cec27ca 100644
--- a/fs/erofs/internal.h
+++ b/fs/erofs/internal.h
@@ -86,7 +86,7 @@ struct erofs_sb_info {
 	u8 uuid[16];                    /* 128-bit uuid for volume */
 	u8 volume_name[16];             /* volume name */
 	u32 feature_incompat;
-
+	u32 feature_compat;
 	unsigned int mount_opt;
 };
 
@@ -426,6 +426,7 @@ static inline void z_erofs_exit_zip_subsystem(void) {}
 #endif	/* !CONFIG_EROFS_FS_ZIP */
 
 #define EFSCORRUPTED    EUCLEAN         /* Filesystem is corrupted */
+#define EFSBADCRC	EBADMSG		/* Bad crc found */
 
 #endif	/* __EROFS_INTERNAL_H */
 
diff --git a/fs/erofs/super.c b/fs/erofs/super.c
index 0e36949..9cda72d 100644
--- a/fs/erofs/super.c
+++ b/fs/erofs/super.c
@@ -9,6 +9,7 @@
 #include <linux/statfs.h>
 #include <linux/parser.h>
 #include <linux/seq_file.h>
+#include <linux/crc32c.h>
 #include "xattr.h"
 
 #define CREATE_TRACE_POINTS
@@ -46,6 +47,31 @@ void _erofs_info(struct super_block *sb, const char *function,
 	va_end(args);
 }
 
+static int erofs_validate_sb_chksum(struct erofs_super_block *dsb,
+				       struct super_block *sb)
+{
+	u32 disk_chksum, nblocks, crc = 0;
+	void *kaddr;
+	struct page *page;
+	int i;
+
+	disk_chksum = le32_to_cpu(dsb->checksum);
+	nblocks = le32_to_cpu(dsb->chksum_blocks);
+	dsb->checksum = 0;
+	for (i = 0; i < nblocks; i++) {
+		page = erofs_get_meta_page(sb, i);
+		if (IS_ERR(page))
+			return PTR_ERR(page);
+		kaddr = kmap(page);
+		crc = crc32c(crc, kaddr, EROFS_BLKSIZ);
+		kunmap(page);
+		unlock_page(page);
+	}
+	if (crc != disk_chksum)
+		return -EFSBADCRC;
+	return 0;
+}
+
 static void erofs_inode_init_once(void *ptr)
 {
 	struct erofs_inode *vi = ptr;
@@ -121,6 +147,13 @@ static int erofs_read_superblock(struct super_block *sb)
 		goto out;
 	}
 
+	if (dsb->feature_compat & EROFS_FEATURE_COMPAT_SB_CHKSUM) {
+		ret = erofs_validate_sb_chksum(dsb, sb);
+		if (ret < 0) {
+			erofs_err(sb, "super block checksum incorrect");
+			goto out;
+		}
+	}
 	blkszbits = dsb->blkszbits;
 	/* 9(512 bytes) + LOG_SECTORS_PER_BLOCK == LOG_BLOCK_SIZE */
 	if (blkszbits != LOG_BLOCK_SIZE) {
-- 
2.9.3

