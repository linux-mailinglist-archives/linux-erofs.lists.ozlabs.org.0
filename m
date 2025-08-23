Return-Path: <linux-erofs+bounces-890-lists+linux-erofs=lfdr.de@lists.ozlabs.org>
X-Original-To: lists+linux-erofs@lfdr.de
Delivered-To: lists+linux-erofs@lfdr.de
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2404:9400:2:0:216:3eff:fee1:b9f1])
	by mail.lfdr.de (Postfix) with ESMTPS id F09C6B327ED
	for <lists+linux-erofs@lfdr.de>; Sat, 23 Aug 2025 11:30:43 +0200 (CEST)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4c8Bcd2BBRz3dDM;
	Sat, 23 Aug 2025 19:30:41 +1000 (AEST)
X-Original-To: linux-erofs@lists.ozlabs.org
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip=115.124.30.124
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1755941441;
	cv=none; b=h7vLJLnQ3W2nmgTMKqk4Rp/arSxNBRRtCaBumOGHrE58KDSz8R6y+X9KXEPX9E98L5dMSzMFzqsorV9KCERDbqTpGeUdgmJzELO0okuto7N1M0VVEZ3uN3GIW0c30QEorH8yWEEdMNTI0k8er2AdUCib4LxTbuOGE3TChEkAKL7kg3mi0cCJ0EUGWChMTSq9uQURV40QE/dCYUqsPUMV0eY8pZbdzv/eLF0kai7o6ai/BqOmv9NDUBu6QqA0mMkDzGHuQWnu1wjEpNHPb8Qz4dK5EK9rsur3rB93tWYyYs+bF/IAU+l00hLNZtZEtsMUVBGU/MmVWHmhUj3fQELLKA==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1755941441; c=relaxed/relaxed;
	bh=J6aSH8OxgyIIVxm80DI9gVrd+vT5zftoxnUeR9pqwoQ=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=UBqYeU4rilrUGjx68cS7QYjU0WDoY4mRbGrNM0nqNnl9SmF93vcFva+248CowQZYYSOaMuAlNApDaC5VtYlR8Ymy+ATINcq+U5DmkBnMSmD4bZcDMlT/ml/3hYiUosMBFUYCoLVVUnN37lyPtOFeP4x/IOlcqImaCzjQfSgS+F/0XNx/h4DkD1ZBtvOdeSGWzVERyNVFsEpgkAOYX/zkN62HiKL/FVRy8WsId+i1vWNsT96fohdI4HjPoKjMKlugdGtfOxT+YEkWXLAdADwRc+INZLqrFqGdAqiWGqw+NLNIrq9XD4vpFmTsMSuwnANPGjy2CBzLlNzpKKXQS4dRyw==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com; dkim=pass (1024-bit key; unprotected) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.a=rsa-sha256 header.s=default header.b=eUYAVTBR; dkim-atps=neutral; spf=pass (client-ip=115.124.30.124; helo=out30-124.freemail.mail.aliyun.com; envelope-from=hsiangkao@linux.alibaba.com; receiver=lists.ozlabs.org) smtp.mailfrom=linux.alibaba.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (1024-bit key; unprotected) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.a=rsa-sha256 header.s=default header.b=eUYAVTBR;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=linux.alibaba.com (client-ip=115.124.30.124; helo=out30-124.freemail.mail.aliyun.com; envelope-from=hsiangkao@linux.alibaba.com; receiver=lists.ozlabs.org)
Received: from out30-124.freemail.mail.aliyun.com (out30-124.freemail.mail.aliyun.com [115.124.30.124])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4c8Bcb50pKz3d9t
	for <linux-erofs@lists.ozlabs.org>; Sat, 23 Aug 2025 19:30:38 +1000 (AEST)
DKIM-Signature:v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=linux.alibaba.com; s=default;
	t=1755941434; h=From:To:Subject:Date:Message-ID:MIME-Version;
	bh=J6aSH8OxgyIIVxm80DI9gVrd+vT5zftoxnUeR9pqwoQ=;
	b=eUYAVTBRRwlDnY/NvISfAGKcWiuqQb9F7BVHYF9Hw22uwZN+h9uIrqj0vSWLr8bQWy2pvL0UJw+d6Wz+IU1ozL9OGQ/HvXAugvciFaimX4aqJD21nIsQ7cCCwvXu39uXnyMcK2rcPA01RBWeTpmvt+Zb1Fw5kFLH4YE6kRwQfVU=
Received: from x31i01179.sqa.na131.tbsite.net(mailfrom:hsiangkao@linux.alibaba.com fp:SMTPD_---0WmLr4rS_1755941419 cluster:ay36)
          by smtp.aliyun-inc.com;
          Sat, 23 Aug 2025 17:30:31 +0800
From: Gao Xiang <hsiangkao@linux.alibaba.com>
To: linux-erofs@lists.ozlabs.org
Cc: LKML <linux-kernel@vger.kernel.org>,
	Gao Xiang <hsiangkao@linux.alibaba.com>,
	syzbot+5a398eb460ddaa6f242f@syzkaller.appspotmail.com
Subject: [PATCH] erofs: fix invalid algorithm for encoded extents
Date: Sat, 23 Aug 2025 17:30:18 +0800
Message-ID: <20250823093018.3117864-1-hsiangkao@linux.alibaba.com>
X-Mailer: git-send-email 2.43.5
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

The current algorithm sanity checks do not properly apply to new
encoded extents.

Unify the algorithm format check with Z_EROFS_COMPRESSION_MAX and
ensure consistency with sbi->available_compr_algs.

Reported-by: syzbot+5a398eb460ddaa6f242f@syzkaller.appspotmail.com
Closes: https://lore.kernel.org/r/68a8bd20.050a0220.37038e.005a.GAE@google.com
Fixes: 1d191b4ca51d ("erofs: implement encoded extent metadata")
Thanks-to: Edward Adam Davis <eadavis@qq.com>
Signed-off-by: Gao Xiang <hsiangkao@linux.alibaba.com>
---
 fs/erofs/zmap.c | 66 +++++++++++++++++++++++++++----------------------
 1 file changed, 36 insertions(+), 30 deletions(-)

diff --git a/fs/erofs/zmap.c b/fs/erofs/zmap.c
index a93efd95c555..d5755da33235 100644
--- a/fs/erofs/zmap.c
+++ b/fs/erofs/zmap.c
@@ -394,10 +394,10 @@ static int z_erofs_map_blocks_fo(struct inode *inode,
 		.map = map,
 		.in_mbox = erofs_inode_in_metabox(inode),
 	};
-	int err = 0;
-	unsigned int endoff, afmt;
+	unsigned int endoff;
 	unsigned long initial_lcn;
 	unsigned long long ofs, end;
+	int err;
 
 	ofs = flags & EROFS_GET_BLOCKS_FINDTAIL ? inode->i_size - 1 : map->m_la;
 	if (fragment && !(flags & EROFS_GET_BLOCKS_FINDTAIL) &&
@@ -482,20 +482,15 @@ static int z_erofs_map_blocks_fo(struct inode *inode,
 			err = -EFSCORRUPTED;
 			goto unmap_out;
 		}
-		afmt = vi->z_advise & Z_EROFS_ADVISE_INTERLACED_PCLUSTER ?
-			Z_EROFS_COMPRESSION_INTERLACED :
-			Z_EROFS_COMPRESSION_SHIFTED;
+		if (vi->z_advise & Z_EROFS_ADVISE_INTERLACED_PCLUSTER)
+			map->m_algorithmformat = Z_EROFS_COMPRESSION_INTERLACED;
+		else
+			map->m_algorithmformat = Z_EROFS_COMPRESSION_SHIFTED;
+	} else if (m.headtype == Z_EROFS_LCLUSTER_TYPE_HEAD2) {
+		map->m_algorithmformat = vi->z_algorithmtype[1];
 	} else {
-		afmt = m.headtype == Z_EROFS_LCLUSTER_TYPE_HEAD2 ?
-			vi->z_algorithmtype[1] : vi->z_algorithmtype[0];
-		if (!(EROFS_I_SB(inode)->available_compr_algs & (1 << afmt))) {
-			erofs_err(sb, "inconsistent algorithmtype %u for nid %llu",
-				  afmt, vi->nid);
-			err = -EFSCORRUPTED;
-			goto unmap_out;
-		}
+		map->m_algorithmformat = vi->z_algorithmtype[0];
 	}
-	map->m_algorithmformat = afmt;
 
 	if ((flags & EROFS_GET_BLOCKS_FIEMAP) ||
 	    ((flags & EROFS_GET_BLOCKS_READMORE) &&
@@ -626,9 +621,9 @@ static int z_erofs_fill_inode(struct inode *inode, struct erofs_map_blocks *map)
 {
 	struct erofs_inode *const vi = EROFS_I(inode);
 	struct super_block *const sb = inode->i_sb;
-	int err, headnr;
-	erofs_off_t pos;
 	struct z_erofs_map_header *h;
+	erofs_off_t pos;
+	int err = 0;
 
 	if (test_bit(EROFS_I_Z_INITED_BIT, &vi->flags)) {
 		/*
@@ -642,7 +637,6 @@ static int z_erofs_fill_inode(struct inode *inode, struct erofs_map_blocks *map)
 	if (wait_on_bit_lock(&vi->flags, EROFS_I_BL_Z_BIT, TASK_KILLABLE))
 		return -ERESTARTSYS;
 
-	err = 0;
 	if (test_bit(EROFS_I_Z_INITED_BIT, &vi->flags))
 		goto out_unlock;
 
@@ -679,15 +673,6 @@ static int z_erofs_fill_inode(struct inode *inode, struct erofs_map_blocks *map)
 	else if (vi->z_advise & Z_EROFS_ADVISE_INLINE_PCLUSTER)
 		vi->z_idata_size = le16_to_cpu(h->h_idata_size);
 
-	headnr = 0;
-	if (vi->z_algorithmtype[0] >= Z_EROFS_COMPRESSION_MAX ||
-	    vi->z_algorithmtype[++headnr] >= Z_EROFS_COMPRESSION_MAX) {
-		erofs_err(sb, "unknown HEAD%u format %u for nid %llu, please upgrade kernel",
-			  headnr + 1, vi->z_algorithmtype[headnr], vi->nid);
-		err = -EOPNOTSUPP;
-		goto out_unlock;
-	}
-
 	if (!erofs_sb_has_big_pcluster(EROFS_SB(sb)) &&
 	    vi->z_advise & (Z_EROFS_ADVISE_BIG_PCLUSTER_1 |
 			    Z_EROFS_ADVISE_BIG_PCLUSTER_2)) {
@@ -726,6 +711,29 @@ static int z_erofs_fill_inode(struct inode *inode, struct erofs_map_blocks *map)
 	return err;
 }
 
+static int z_erofs_map_sanity_check(struct inode *inode,
+				    struct erofs_map_blocks *map)
+{
+	struct erofs_sb_info *sbi = EROFS_I_SB(inode);
+
+	if (!(map->m_flags & EROFS_MAP_ENCODED))
+		return 0;
+	if (unlikely(map->m_algorithmformat >= Z_EROFS_COMPRESSION_MAX)) {
+		erofs_err(inode->i_sb, "unknown algorithm %d @ pos %llu for nid %llu, please upgrade kernel",
+			  map->m_algorithmformat, map->m_la, EROFS_I(inode)->nid);
+		return -EOPNOTSUPP;
+	}
+	if (unlikely(!(sbi->available_compr_algs & (1 << map->m_algorithmformat)))) {
+		erofs_err(inode->i_sb, "inconsistent algorithmtype %u for nid %llu",
+			  map->m_algorithmformat, EROFS_I(inode)->nid);
+		return -EFSCORRUPTED;
+	}
+	if (unlikely(map->m_plen > Z_EROFS_PCLUSTER_MAX_SIZE ||
+		     map->m_llen > Z_EROFS_PCLUSTER_MAX_DSIZE))
+		return -EOPNOTSUPP;
+	return 0;
+}
+
 int z_erofs_map_blocks_iter(struct inode *inode, struct erofs_map_blocks *map,
 			    int flags)
 {
@@ -746,10 +754,8 @@ int z_erofs_map_blocks_iter(struct inode *inode, struct erofs_map_blocks *map,
 			else
 				err = z_erofs_map_blocks_fo(inode, map, flags);
 		}
-		if (!err && (map->m_flags & EROFS_MAP_ENCODED) &&
-		    unlikely(map->m_plen > Z_EROFS_PCLUSTER_MAX_SIZE ||
-			     map->m_llen > Z_EROFS_PCLUSTER_MAX_DSIZE))
-			err = -EOPNOTSUPP;
+		if (!err)
+			err = z_erofs_map_sanity_check(inode, map);
 		if (err)
 			map->m_llen = 0;
 	}
-- 
2.43.5


