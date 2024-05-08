Return-Path: <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>
X-Original-To: lists+linux-erofs@lfdr.de
Delivered-To: lists+linux-erofs@lfdr.de
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2404:9400:2:0:216:3eff:fee1:b9f1])
	by mail.lfdr.de (Postfix) with ESMTPS id B8CDB8BFD37
	for <lists+linux-erofs@lfdr.de>; Wed,  8 May 2024 14:34:28 +0200 (CEST)
Authentication-Results: lists.ozlabs.org;
	dkim=pass (1024-bit key; unprotected) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.a=rsa-sha256 header.s=default header.b=Ksh45C9V;
	dkim-atps=neutral
Received: from boromir.ozlabs.org (localhost [IPv6:::1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4VZF2V2Vv8z3cF4
	for <lists+linux-erofs@lfdr.de>; Wed,  8 May 2024 22:34:26 +1000 (AEST)
X-Original-To: linux-erofs@lists.ozlabs.org
Delivered-To: linux-erofs@lists.ozlabs.org
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (1024-bit key; unprotected) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.a=rsa-sha256 header.s=default header.b=Ksh45C9V;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=linux.alibaba.com (client-ip=115.124.30.100; helo=out30-100.freemail.mail.aliyun.com; envelope-from=hsiangkao@linux.alibaba.com; receiver=lists.ozlabs.org)
Received: from out30-100.freemail.mail.aliyun.com (out30-100.freemail.mail.aliyun.com [115.124.30.100])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4VZF2H2W6pz30TL
	for <linux-erofs@lists.ozlabs.org>; Wed,  8 May 2024 22:34:12 +1000 (AEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=linux.alibaba.com; s=default;
	t=1715171646; h=From:To:Subject:Date:Message-Id:MIME-Version;
	bh=yw11G1gLE8iNd8Cfpyqtd9XhzkVzZPbalt0cTW63xQw=;
	b=Ksh45C9VYZla5QTsA1zzn2hCXClzQXC/nNQLnR74ZV8i66xhVS9WISzNQ4x5b1tB2b6o9jJ0eBpiZGwNi5vDaE3Dhx2WoxVpgbKbdnG0H1MfcfdkM4Fhxl9HceZhqaFa7H2m9IdrmTHH2ZON/ZAuRna0+bN64DEpPqTc5AhWrEI=
X-Alimail-AntiSpam: AC=PASS;BC=-1|-1;BR=01201311R611e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=maildocker-contentspam033032014031;MF=hsiangkao@linux.alibaba.com;NM=1;PH=DS;RN=4;SR=0;TI=SMTPD_---0W63ZZzu_1715171638;
Received: from x31i01179.sqa.na131.tbsite.net(mailfrom:hsiangkao@linux.alibaba.com fp:SMTPD_---0W63ZZzu_1715171638)
          by smtp.aliyun-inc.com;
          Wed, 08 May 2024 20:34:03 +0800
From: Gao Xiang <hsiangkao@linux.alibaba.com>
To: linux-erofs@lists.ozlabs.org
Subject: [PATCH] erofs: clean up z_erofs_load_full_lcluster()
Date: Wed,  8 May 2024 20:33:57 +0800
Message-Id: <20240508123357.3266173-1-hsiangkao@linux.alibaba.com>
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
Cc: Gao Xiang <hsiangkao@linux.alibaba.com>, LKML <linux-kernel@vger.kernel.org>
Errors-To: linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org
Sender: "Linux-erofs" <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>

Only four lcluster types here, remove redundant code.
No real logic changes.

Signed-off-by: Gao Xiang <hsiangkao@linux.alibaba.com>
---
Some random cleanup out of the upcoming big lclusters..

 fs/erofs/erofs_fs.h |  5 +----
 fs/erofs/zmap.c     | 21 +++++----------------
 2 files changed, 6 insertions(+), 20 deletions(-)

diff --git a/fs/erofs/erofs_fs.h b/fs/erofs/erofs_fs.h
index 4bc11602aac8..6c0c270c42e1 100644
--- a/fs/erofs/erofs_fs.h
+++ b/fs/erofs/erofs_fs.h
@@ -406,8 +406,7 @@ enum {
 	Z_EROFS_LCLUSTER_TYPE_MAX
 };
 
-#define Z_EROFS_LI_LCLUSTER_TYPE_BITS        2
-#define Z_EROFS_LI_LCLUSTER_TYPE_BIT         0
+#define Z_EROFS_LI_LCLUSTER_TYPE_MASK	(Z_EROFS_LCLUSTER_TYPE_MAX - 1)
 
 /* (noncompact only, HEAD) This pcluster refers to partial decompressed data */
 #define Z_EROFS_LI_PARTIAL_REF		(1 << 15)
@@ -461,8 +460,6 @@ static inline void erofs_check_ondisk_layout_definitions(void)
 		     sizeof(struct z_erofs_lcluster_index));
 	BUILD_BUG_ON(sizeof(struct erofs_deviceslot) != 128);
 
-	BUILD_BUG_ON(BIT(Z_EROFS_LI_LCLUSTER_TYPE_BITS) <
-		     Z_EROFS_LCLUSTER_TYPE_MAX - 1);
 	/* exclude old compiler versions like gcc 7.5.0 */
 	BUILD_BUG_ON(__builtin_constant_p(fmh) ?
 		     fmh != cpu_to_le64(1ULL << 63) : 0);
diff --git a/fs/erofs/zmap.c b/fs/erofs/zmap.c
index e313c936351d..26637a60eba5 100644
--- a/fs/erofs/zmap.c
+++ b/fs/erofs/zmap.c
@@ -31,7 +31,7 @@ static int z_erofs_load_full_lcluster(struct z_erofs_maprecorder *m,
 			vi->inode_isize + vi->xattr_isize) +
 			lcn * sizeof(struct z_erofs_lcluster_index);
 	struct z_erofs_lcluster_index *di;
-	unsigned int advise, type;
+	unsigned int advise;
 
 	m->kaddr = erofs_read_metabuf(&m->map->buf, inode->i_sb,
 				      erofs_blknr(inode->i_sb, pos), EROFS_KMAP);
@@ -43,10 +43,8 @@ static int z_erofs_load_full_lcluster(struct z_erofs_maprecorder *m,
 	di = m->kaddr + erofs_blkoff(inode->i_sb, pos);
 
 	advise = le16_to_cpu(di->di_advise);
-	type = (advise >> Z_EROFS_LI_LCLUSTER_TYPE_BIT) &
-		((1 << Z_EROFS_LI_LCLUSTER_TYPE_BITS) - 1);
-	switch (type) {
-	case Z_EROFS_LCLUSTER_TYPE_NONHEAD:
+	m->type = advise & Z_EROFS_LI_LCLUSTER_TYPE_MASK;
+	if (m->type == Z_EROFS_LCLUSTER_TYPE_NONHEAD) {
 		m->clusterofs = 1 << vi->z_logical_clusterbits;
 		m->delta[0] = le16_to_cpu(di->di_u.delta[0]);
 		if (m->delta[0] & Z_EROFS_LI_D0_CBLKCNT) {
@@ -60,24 +58,15 @@ static int z_erofs_load_full_lcluster(struct z_erofs_maprecorder *m,
 			m->delta[0] = 1;
 		}
 		m->delta[1] = le16_to_cpu(di->di_u.delta[1]);
-		break;
-	case Z_EROFS_LCLUSTER_TYPE_PLAIN:
-	case Z_EROFS_LCLUSTER_TYPE_HEAD1:
-	case Z_EROFS_LCLUSTER_TYPE_HEAD2:
-		if (advise & Z_EROFS_LI_PARTIAL_REF)
-			m->partialref = true;
+	} else {
+		m->partialref = !!(advise & Z_EROFS_LI_PARTIAL_REF);
 		m->clusterofs = le16_to_cpu(di->di_clusterofs);
 		if (m->clusterofs >= 1 << vi->z_logical_clusterbits) {
 			DBG_BUGON(1);
 			return -EFSCORRUPTED;
 		}
 		m->pblk = le32_to_cpu(di->di_u.blkaddr);
-		break;
-	default:
-		DBG_BUGON(1);
-		return -EOPNOTSUPP;
 	}
-	m->type = type;
 	return 0;
 }
 
-- 
2.39.3

