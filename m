Return-Path: <linux-erofs+bounces-897-lists+linux-erofs=lfdr.de@lists.ozlabs.org>
X-Original-To: lists+linux-erofs@lfdr.de
Delivered-To: lists+linux-erofs@lfdr.de
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2404:9400:2:0:216:3eff:fee1:b9f1])
	by mail.lfdr.de (Postfix) with ESMTPS id 9EE28B33117
	for <lists+linux-erofs@lfdr.de>; Sun, 24 Aug 2025 17:12:19 +0200 (CEST)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4c8y8K0xKgz300M;
	Mon, 25 Aug 2025 01:12:17 +1000 (AEST)
X-Original-To: linux-erofs@lists.ozlabs.org
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip=115.124.30.101
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1756048337;
	cv=none; b=QeMocIDjsVljHIkaMTuEg1fVKarxLTFslM6LhGc1dz1Do0sIQMiXE1J6jd1NB9j2hS07rxpfJmm92aeRqKWPmFLzuou4vNrRecCbdCMbknNWOGNpb+o5RLFEG/SigFzj1hcFAGBlXIEmyNh0qcbog7Oabm4r+8NBhwQuXpMHYV/JeZO/xdk7JuFIxwWQ3VYE/kNW7eKHVeRcPwfxtCNa9eXhRrDZ+PE7HF0A9iYK3cEZv2nMbbmWF3ez4y3iPgl384m0z4cft8hXbqa4RmSCtrczcADtNUDksy1n+PwcqXZG6A+5vU/OIXGnSHSZBWeMXtVnIXf2G/9NWdvsteF8oQ==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1756048337; c=relaxed/relaxed;
	bh=hK5XLprToS2HpWr+A1tVE+AZ/QnOKtjAsUATr5kHsAw=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=lw0KS1GV6oXRPyUsF56vOMPdFhUmON1zTJ2cIOTxna0f8phcW3KiIS00PrLOxlyhY6tq0M7FH9RvrV3Gzn7QPqvponlTAotykuCx2zV9iRFLHQu2tVV04PasOUP9eldW1CJMcFImIhGPvIYwCFqCA57bdjimjkGw6jstt/oA9kXcHnFd9oKNBTH3hQc5ZTuWIVZXcEZajP2jM5j0M/0yAyC0A83z9SvPTCBJ8dsIlMHRXxSA19eehf7pxYi3jCfnj/Or6gUl/aRKXuhNaPX1CZZtETMY3xlcqLFL8RjEvqq8aYO5xHhF2rOxtHhYTcduJUa6ZUfWhmTnRU7qrKPMEw==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com; dkim=pass (1024-bit key; unprotected) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.a=rsa-sha256 header.s=default header.b=wNw8go2t; dkim-atps=neutral; spf=pass (client-ip=115.124.30.101; helo=out30-101.freemail.mail.aliyun.com; envelope-from=hsiangkao@linux.alibaba.com; receiver=lists.ozlabs.org) smtp.mailfrom=linux.alibaba.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (1024-bit key; unprotected) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.a=rsa-sha256 header.s=default header.b=wNw8go2t;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=linux.alibaba.com (client-ip=115.124.30.101; helo=out30-101.freemail.mail.aliyun.com; envelope-from=hsiangkao@linux.alibaba.com; receiver=lists.ozlabs.org)
Received: from out30-101.freemail.mail.aliyun.com (out30-101.freemail.mail.aliyun.com [115.124.30.101])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4c8y8D4sNNz2ytg
	for <linux-erofs@lists.ozlabs.org>; Mon, 25 Aug 2025 01:12:10 +1000 (AEST)
DKIM-Signature:v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=linux.alibaba.com; s=default;
	t=1756048326; h=From:To:Subject:Date:Message-ID:MIME-Version;
	bh=hK5XLprToS2HpWr+A1tVE+AZ/QnOKtjAsUATr5kHsAw=;
	b=wNw8go2tN1gmaVmmivyR3l6fNGNsRRIj+w9wXekkQG5kU6DGnuPf2FjpdXsqz0xDF69usxoZ5mo/z/w4ME+x91KYqnkXbyjDZEJ4UJwNBGIHjopWuMm7R7g97A2PxtD7kfT8Qt3LXrWeRyOXy1wIbEXtmdRaciYeq+8iosL1Leg=
Received: from x31i01179.sqa.na131.tbsite.net(mailfrom:hsiangkao@linux.alibaba.com fp:SMTPD_---0WmOoz.C_1756048318 cluster:ay36)
          by smtp.aliyun-inc.com;
          Sun, 24 Aug 2025 23:12:02 +0800
From: Gao Xiang <hsiangkao@linux.alibaba.com>
To: linux-erofs@lists.ozlabs.org
Cc: LKML <linux-kernel@vger.kernel.org>,
	Gao Xiang <hsiangkao@linux.alibaba.com>,
	syzbot+5a398eb460ddaa6f242f@syzkaller.appspotmail.com
Subject: [PATCH v3] erofs: fix invalid algorithm for encoded extents
Date: Sun, 24 Aug 2025 23:11:57 +0800
Message-ID: <20250824151157.1138706-1-hsiangkao@linux.alibaba.com>
X-Mailer: git-send-email 2.43.5
In-Reply-To: <20250823093018.3117864-1-hsiangkao@linux.alibaba.com>
References: <20250823093018.3117864-1-hsiangkao@linux.alibaba.com>
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

Reported-and-tested-by: syzbot+5a398eb460ddaa6f242f@syzkaller.appspotmail.com
Closes: https://lore.kernel.org/r/68a8bd20.050a0220.37038e.005a.GAE@google.com
Fixes: 1d191b4ca51d ("erofs: implement encoded extent metadata")
Thanks-to: Edward Adam Davis <eadavis@qq.com>
Signed-off-by: Gao Xiang <hsiangkao@linux.alibaba.com>
---
v3:
 - plain extents shouldn't be targeted for the consistency check.

 fs/erofs/zmap.c | 67 +++++++++++++++++++++++++++----------------------
 1 file changed, 37 insertions(+), 30 deletions(-)

diff --git a/fs/erofs/zmap.c b/fs/erofs/zmap.c
index a93efd95c555..798223e6da9c 100644
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
@@ -726,6 +711,30 @@ static int z_erofs_fill_inode(struct inode *inode, struct erofs_map_blocks *map)
 	return err;
 }
 
+static int z_erofs_map_sanity_check(struct inode *inode,
+				    struct erofs_map_blocks *map)
+{
+	struct erofs_sb_info *sbi = EROFS_I_SB(inode);
+
+	if (!(map->m_flags & EROFS_MAP_ENCODED))
+		return 0;
+	if (unlikely(map->m_algorithmformat >= Z_EROFS_COMPRESSION_RUNTIME_MAX)) {
+		erofs_err(inode->i_sb, "unknown algorithm %d @ pos %llu for nid %llu, please upgrade kernel",
+			  map->m_algorithmformat, map->m_la, EROFS_I(inode)->nid);
+		return -EOPNOTSUPP;
+	}
+	if (unlikely(map->m_algorithmformat < Z_EROFS_COMPRESSION_MAX &&
+		     !(sbi->available_compr_algs & (1 << map->m_algorithmformat)))) {
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
@@ -746,10 +755,8 @@ int z_erofs_map_blocks_iter(struct inode *inode, struct erofs_map_blocks *map,
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


