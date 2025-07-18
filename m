Return-Path: <linux-erofs+bounces-669-lists+linux-erofs=lfdr.de@lists.ozlabs.org>
X-Original-To: lists+linux-erofs@lfdr.de
Delivered-To: lists+linux-erofs@lfdr.de
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	by mail.lfdr.de (Postfix) with ESMTPS id 6816EB09BC2
	for <lists+linux-erofs@lfdr.de>; Fri, 18 Jul 2025 08:54:42 +0200 (CEST)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4bk0s70fJMz3blF;
	Fri, 18 Jul 2025 16:54:35 +1000 (AEST)
X-Original-To: linux-erofs@lists.ozlabs.org
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip=115.124.30.100
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1752821675;
	cv=none; b=ZltWwzQf8CUqGXwd2K0sJQrUIj2j86Juac8GxJPbsxee3ELXpJZIF1OwYWUhu/ETM+BPz6coWCxBe+o/OEy7c+rzozAX3Zc496jcVdgE4j1sHJMo26lVj/UdMqxz/5OFq2VFr04tNbGiWBxMScZuUk9JVrBPT5lJMxa8cbFs+WxEniRII0taPaPYTVPP1VMgCHFb73rUDmPXW+PqY/cd3PVScCoOX2DZfyb9eRduRLLB1d8XAXLxLPJENfsAsGYXqLYIWJ8eBYm/n+bJU/pdc+xhbJVx79/wboQTcBFMjmMsdQJxU7wWmbNgvsi5wnrWnhtHoFe1hsnD+XV+DdeETA==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1752821675; c=relaxed/relaxed;
	bh=ywlHn9ukO+LWo18EMhDiU661Cu+jmCMqX73Ndgjp2sU=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=LIEkSEbpYodL/MPsiKX3w8bOJKlbah5dB8y9vx+mc6MLPxv89kp6QNO1vNfk7gXb3RHi+pevDocbsnHw/MbOrcwW3Q4GE4DtOJRJ74b3oBHk6hvdSQyWvLKN/4lRi2alRDA2KAqDxBi4HsToBo6vHnq2frPdducfHFejAzt+o5eRKRSc0PdxeqbXnA2zVBNjVkH7iDHYY08DvpRsNZlrs0Gi/tATV6Lzv8YlYpDTJlLyJnMY34Q8P2sHnaYudwD2QNlPM2/qYLYzR5PO1q2jLEvFS2TIpNppHOEY6T2CNGr+x+ehQjqETTjs7nza9A+TqC81ItJwwDeE4ZyQLBXa6A==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com; dkim=pass (1024-bit key; unprotected) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.a=rsa-sha256 header.s=default header.b=Na6bsJGf; dkim-atps=neutral; spf=pass (client-ip=115.124.30.100; helo=out30-100.freemail.mail.aliyun.com; envelope-from=hsiangkao@linux.alibaba.com; receiver=lists.ozlabs.org) smtp.mailfrom=linux.alibaba.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (1024-bit key; unprotected) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.a=rsa-sha256 header.s=default header.b=Na6bsJGf;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=linux.alibaba.com (client-ip=115.124.30.100; helo=out30-100.freemail.mail.aliyun.com; envelope-from=hsiangkao@linux.alibaba.com; receiver=lists.ozlabs.org)
Received: from out30-100.freemail.mail.aliyun.com (out30-100.freemail.mail.aliyun.com [115.124.30.100])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4bk0s51XtHz30WT
	for <linux-erofs@lists.ozlabs.org>; Fri, 18 Jul 2025 16:54:32 +1000 (AEST)
DKIM-Signature:v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=linux.alibaba.com; s=default;
	t=1752821669; h=From:To:Subject:Date:Message-ID:MIME-Version;
	bh=ywlHn9ukO+LWo18EMhDiU661Cu+jmCMqX73Ndgjp2sU=;
	b=Na6bsJGfyqdvewKiCW6QJacVzY+vu/e9tSaiIAKGyHT+WWyYLQ7E2UNpUFT81aEPk4Hp8QCuyXrv6o0IVop/V+P0/GzbSisRaUMbv5JRFEe14u3bzuTRNb8F1SxGaltlt04bzrkJiou36Kn94EPutaMOLOgeX65zguxNsfHBFms=
Received: from x31i01179.sqa.na131.tbsite.net(mailfrom:hsiangkao@linux.alibaba.com fp:SMTPD_---0WjBMlSR_1752821668 cluster:ay36)
          by smtp.aliyun-inc.com;
          Fri, 18 Jul 2025 14:54:28 +0800
From: Gao Xiang <hsiangkao@linux.alibaba.com>
To: linux-erofs@lists.ozlabs.org
Cc: Gao Xiang <hsiangkao@linux.alibaba.com>
Subject: [PATCH 06/11] erofs-utils: lib: use meta buffers for inode operations
Date: Fri, 18 Jul 2025 14:54:14 +0800
Message-ID: <20250718065419.3338307-6-hsiangkao@linux.alibaba.com>
X-Mailer: git-send-email 2.43.5
In-Reply-To: <20250718065419.3338307-1-hsiangkao@linux.alibaba.com>
References: <20250718065419.3338307-1-hsiangkao@linux.alibaba.com>
X-Mailing-List: linux-erofs@lists.ozlabs.org
List-Id: <linux-erofs.lists.ozlabs.org>
List-Help: <mailto:linux-erofs+help@lists.ozlabs.org>
List-Owner: <mailto:linux-erofs+owner@lists.ozlabs.org>
List-Post: <mailto:linux-erofs@lists.ozlabs.org>
List-Subscribe: <mailto:linux-erofs+subscribe@lists.ozlabs.org>,
  <mailto:linux-erofs+subscribe-digest@lists.ozlabs.org>,
  <mailto:linux-erofs+subscribe-nomail@lists.ozlabs.org>
List-Unsubscribe: <mailto:linux-erofs+unsubscribe@lists.ozlabs.org>
Precedence: list
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-15.7 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,DKIM_VALID_EF,ENV_AND_HDR_SPF_MATCH,RCVD_IN_DNSWL_NONE,
	SPF_HELO_NONE,SPF_PASS,UNPARSEABLE_RELAY,USER_IN_DEF_DKIM_WL,
	USER_IN_DEF_SPF_WL autolearn=disabled version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-25) on lists.ozlabs.org

Source kernel commit: c521e3ad6cc980df6f3bdd2616808ecb973af880

Signed-off-by: Gao Xiang <hsiangkao@linux.alibaba.com>
---
 lib/namei.c | 78 ++++++++++++++++++++++++++++++++++++++---------------
 1 file changed, 56 insertions(+), 22 deletions(-)

diff --git a/lib/namei.c b/lib/namei.c
index d6013e5c..c3ddd590 100644
--- a/lib/namei.c
+++ b/lib/namei.c
@@ -24,39 +24,67 @@ static dev_t erofs_new_decode_dev(u32 dev)
 
 int erofs_read_inode_from_disk(struct erofs_inode *vi)
 {
-	int ret, ifmt;
-	char buf[sizeof(struct erofs_inode_extended)];
-	erofs_off_t inode_loc = erofs_iloc(vi);
 	struct erofs_sb_info *sbi = vi->sbi;
+	erofs_blk_t blkaddr = erofs_blknr(sbi, erofs_iloc(vi));
+	unsigned int ofs = erofs_blkoff(sbi, erofs_iloc(vi));
+	struct erofs_buf buf = __EROFS_BUF_INITIALIZER;
 	erofs_blk_t addrmask = BIT_ULL(48) - 1;
 	struct erofs_inode_extended *die, copied;
 	struct erofs_inode_compact *dic;
+	unsigned int ifmt;
+	void *ptr;
+	int err = 0;
+
+	ptr = erofs_read_metabuf(&buf, sbi, erofs_pos(sbi, blkaddr));
+	if (IS_ERR(ptr)) {
+		err = PTR_ERR(ptr);
+		erofs_err("failed to get inode (nid: %llu) page, err %d",
+			  vi->nid, err);
+		goto err_out;
+	}
 
-	DBG_BUGON(!sbi);
-	ret = erofs_dev_read(sbi, 0, buf, inode_loc, sizeof(*dic));
-	if (ret < 0)
-		return -EIO;
-
-	dic = (struct erofs_inode_compact *)buf;
+	dic = ptr + ofs;
 	ifmt = le16_to_cpu(dic->i_format);
+	if (ifmt & ~EROFS_I_ALL) {
+		erofs_err("unsupported i_format %u of nid %llu",
+			  ifmt, vi->nid);
+		err = -EOPNOTSUPP;
+		goto err_out;
+	}
 
 	vi->datalayout = erofs_inode_datalayout(ifmt);
 	if (vi->datalayout >= EROFS_INODE_DATALAYOUT_MAX) {
 		erofs_err("unsupported datalayout %u of nid %llu",
 			  vi->datalayout, vi->nid | 0ULL);
-		return -EOPNOTSUPP;
+		err = -EOPNOTSUPP;
+		goto err_out;
 	}
+
 	switch (erofs_inode_version(ifmt)) {
 	case EROFS_INODE_LAYOUT_EXTENDED:
 		vi->inode_isize = sizeof(struct erofs_inode_extended);
-
-		ret = erofs_dev_read(sbi, 0, buf + sizeof(*dic),
-			       inode_loc + sizeof(*dic),
-			       sizeof(*die) - sizeof(*dic));
-		if (ret < 0)
-			return -EIO;
-
-		die = (struct erofs_inode_extended *)buf;
+		/* check if the extended inode acrosses block boundary */
+		if (ofs + vi->inode_isize <= erofs_blksiz(sbi)) {
+			ofs += vi->inode_isize;
+			die = (struct erofs_inode_extended *)dic;
+			copied.i_u = die->i_u;
+			copied.i_nb = die->i_nb;
+		} else {
+			const unsigned int gotten = erofs_blksiz(sbi) - ofs;
+
+			memcpy(&copied, dic, gotten);
+			ptr = erofs_read_metabuf(&buf, sbi,
+					erofs_pos(sbi, blkaddr + 1));
+			if (IS_ERR(ptr)) {
+				err = PTR_ERR(ptr);
+				erofs_err("failed to get inode payload block (nid: %llu), err %d",
+					  vi->nid, err);
+				goto err_out;
+			}
+			ofs = vi->inode_isize - gotten;
+			memcpy((u8 *)&copied + gotten, ptr, ofs);
+			die = &copied;
+		}
 		vi->xattr_isize = erofs_xattr_ibody_size(die->i_xattr_icount);
 		vi->i_mode = le16_to_cpu(die->i_mode);
 		vi->i_ino[0] = le32_to_cpu(die->i_ino);
@@ -72,6 +100,7 @@ int erofs_read_inode_from_disk(struct erofs_inode *vi)
 		break;
 	case EROFS_INODE_LAYOUT_COMPACT:
 		vi->inode_isize = sizeof(struct erofs_inode_compact);
+		ofs += vi->inode_isize;
 		vi->xattr_isize = erofs_xattr_ibody_size(dic->i_xattr_icount);
 		vi->i_mode = le16_to_cpu(dic->i_mode);
 		vi->i_ino[0] = le32_to_cpu(dic->i_ino);
@@ -96,7 +125,8 @@ int erofs_read_inode_from_disk(struct erofs_inode *vi)
 	default:
 		erofs_err("unsupported on-disk inode version %u of nid %llu",
 			  erofs_inode_version(ifmt), vi->nid | 0ULL);
-		return -EOPNOTSUPP;
+		err = -EOPNOTSUPP;
+		goto err_out;
 	}
 
 	switch (vi->i_mode & S_IFMT) {
@@ -122,7 +152,8 @@ int erofs_read_inode_from_disk(struct erofs_inode *vi)
 	default:
 		erofs_err("bogus i_mode (%o) @ nid %llu", vi->i_mode,
 			  vi->nid | 0ULL);
-		return -EFSCORRUPTED;
+		err = -EFSCORRUPTED;
+		goto err_out;
 	}
 
 	vi->flags = 0;
@@ -132,12 +163,15 @@ int erofs_read_inode_from_disk(struct erofs_inode *vi)
 		if (vi->u.chunkformat & ~EROFS_CHUNK_FORMAT_ALL) {
 			erofs_err("unsupported chunk format %x of nid %llu",
 				  vi->u.chunkformat, vi->nid | 0ULL);
-			return -EOPNOTSUPP;
+			err = -EOPNOTSUPP;
+			goto err_out;
 		}
 		vi->u.chunkbits = sbi->blkszbits +
 			(vi->u.chunkformat & EROFS_CHUNK_FORMAT_BLKBITS_MASK);
 	}
-	return 0;
+err_out:
+	erofs_put_metabuf(&buf);
+	return err;
 }
 
 struct erofs_dirent *find_target_dirent(erofs_nid_t pnid,
-- 
2.43.5


