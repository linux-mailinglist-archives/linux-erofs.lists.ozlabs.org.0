Return-Path: <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>
X-Original-To: lists+linux-erofs@lfdr.de
Delivered-To: lists+linux-erofs@lfdr.de
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	by mail.lfdr.de (Postfix) with ESMTPS id 972C18FCC38
	for <lists+linux-erofs@lfdr.de>; Wed,  5 Jun 2024 14:15:17 +0200 (CEST)
Authentication-Results: lists.ozlabs.org;
	dkim=pass (1024-bit key; unprotected) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.a=rsa-sha256 header.s=default header.b=e6ijcEHt;
	dkim-atps=neutral
Received: from boromir.ozlabs.org (localhost [IPv6:::1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4VvRHQ4D74z30Vg
	for <lists+linux-erofs@lfdr.de>; Wed,  5 Jun 2024 22:15:14 +1000 (AEST)
X-Original-To: linux-erofs@lists.ozlabs.org
Delivered-To: linux-erofs@lists.ozlabs.org
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (1024-bit key; unprotected) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.a=rsa-sha256 header.s=default header.b=e6ijcEHt;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=linux.alibaba.com (client-ip=115.124.30.98; helo=out30-98.freemail.mail.aliyun.com; envelope-from=hsiangkao@linux.alibaba.com; receiver=lists.ozlabs.org)
Received: from out30-98.freemail.mail.aliyun.com (out30-98.freemail.mail.aliyun.com [115.124.30.98])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4VvRH94ZFYz30TZ
	for <linux-erofs@lists.ozlabs.org>; Wed,  5 Jun 2024 22:14:59 +1000 (AEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=linux.alibaba.com; s=default;
	t=1717589695; h=From:To:Subject:Date:Message-Id:MIME-Version;
	bh=8Yqmd9HLqaKpIs22NQE+6u1lEfNsF4lZnmZnaeuVIoo=;
	b=e6ijcEHtR4tc7lZV1cJgGu0wsZZBgF2/HJ8wEZEQnMNdBnqoJeFnFXD7FhqRN4XHLmHv7tTUcu4m2onyrNDD7IBDAtgpj1aHP8PyIPx72/dphZTPycae1vc6JnsubyadHSdaXPNC5wIi+sC+xSAB05es4t/pUML1xbuzLk3oJsI=
X-Alimail-AntiSpam: AC=PASS;BC=-1|-1;BR=01201311R191e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=maildocker-contentspam033037067113;MF=hsiangkao@linux.alibaba.com;NM=1;PH=DS;RN=2;SR=0;TI=SMTPD_---0W7v6Fam_1717589689;
Received: from x31i01179.sqa.na131.tbsite.net(mailfrom:hsiangkao@linux.alibaba.com fp:SMTPD_---0W7v6Fam_1717589689)
          by smtp.aliyun-inc.com;
          Wed, 05 Jun 2024 20:14:54 +0800
From: Gao Xiang <hsiangkao@linux.alibaba.com>
To: linux-erofs@lists.ozlabs.org
Subject: [PATCH 1/2] erofs-utils: introduce z_erofs_parse_cfgs()
Date: Wed,  5 Jun 2024 20:14:47 +0800
Message-Id: <20240605121448.3816160-1-hsiangkao@linux.alibaba.com>
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

This userspace implementation will be mainly used for the upcoming
Intel In-Memory Analytics Accelerator integration.

Signed-off-by: Gao Xiang <hsiangkao@linux.alibaba.com>
---
 include/erofs/internal.h |  1 +
 lib/decompress.c         | 41 ++++++++++++++++++++++++++++++++++++++++
 lib/super.c              |  7 +++----
 3 files changed, 45 insertions(+), 4 deletions(-)

diff --git a/include/erofs/internal.h b/include/erofs/internal.h
index 9fdff71..d52bcc6 100644
--- a/include/erofs/internal.h
+++ b/include/erofs/internal.h
@@ -410,6 +410,7 @@ int z_erofs_read_one_data(struct erofs_inode *inode,
 			erofs_off_t skip, erofs_off_t length, bool trimmed);
 void *erofs_read_metadata(struct erofs_sb_info *sbi, erofs_nid_t nid,
 			  erofs_off_t *offset, int *lengthp);
+int z_erofs_parse_cfgs(struct erofs_sb_info *sbi, struct erofs_super_block *dsb);
 
 static inline int erofs_get_occupied_size(const struct erofs_inode *inode,
 					  erofs_off_t *size)
diff --git a/lib/decompress.c b/lib/decompress.c
index e65b924..2842f51 100644
--- a/lib/decompress.c
+++ b/lib/decompress.c
@@ -382,3 +382,44 @@ int z_erofs_decompress(struct z_erofs_decompress_req *rq)
 #endif
 	return -EOPNOTSUPP;
 }
+
+int z_erofs_parse_cfgs(struct erofs_sb_info *sbi, struct erofs_super_block *dsb)
+{
+	unsigned int algs, alg;
+	erofs_off_t offset;
+	int size, ret = 0;
+
+	if (!erofs_sb_has_compr_cfgs(sbi)) {
+		sbi->available_compr_algs = 1 << Z_EROFS_COMPRESSION_LZ4;
+		sbi->lz4_max_distance = le16_to_cpu(dsb->u1.lz4_max_distance);
+		return 0;
+	}
+
+	sbi->available_compr_algs = le16_to_cpu(dsb->u1.available_compr_algs);
+	if (sbi->available_compr_algs & ~Z_EROFS_ALL_COMPR_ALGS) {
+		erofs_err("unidentified algorithms %x, please upgrade erofs-utils",
+			  sbi->available_compr_algs & ~Z_EROFS_ALL_COMPR_ALGS);
+		return -EOPNOTSUPP;
+	}
+
+	offset = EROFS_SUPER_OFFSET + sbi->sb_size;
+	alg = 0;
+	for (algs = sbi->available_compr_algs; algs; algs >>= 1, ++alg) {
+		void *data;
+
+		if (!(algs & 1))
+			continue;
+
+		data = erofs_read_metadata(sbi, 0, &offset, &size);
+		if (IS_ERR(data)) {
+			ret = PTR_ERR(data);
+			break;
+		}
+
+		ret = 0;
+		free(data);
+		if (ret)
+			break;
+	}
+	return ret;
+}
diff --git a/lib/super.c b/lib/super.c
index 4d16d29..61a1618 100644
--- a/lib/super.c
+++ b/lib/super.c
@@ -126,10 +126,9 @@ int erofs_read_superblock(struct erofs_sb_info *sbi)
 
 	memcpy(&sbi->uuid, dsb->uuid, sizeof(dsb->uuid));
 
-	if (erofs_sb_has_compr_cfgs(sbi))
-		sbi->available_compr_algs = le16_to_cpu(dsb->u1.available_compr_algs);
-	else
-		sbi->lz4_max_distance = le16_to_cpu(dsb->u1.lz4_max_distance);
+	ret = z_erofs_parse_cfgs(sbi, dsb);
+	if (ret)
+		return ret;
 
 	ret = erofs_init_devices(sbi, dsb);
 	if (ret)
-- 
2.39.3

