Return-Path: <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>
X-Original-To: lists+linux-erofs@lfdr.de
Delivered-To: lists+linux-erofs@lfdr.de
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2404:9400:2:0:216:3eff:fee1:b9f1])
	by mail.lfdr.de (Postfix) with ESMTPS id E3E5BA2A8CD
	for <lists+linux-erofs@lfdr.de>; Thu,  6 Feb 2025 13:51:01 +0100 (CET)
Received: from boromir.ozlabs.org (localhost [IPv6:::1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4YpcR40m11z3bPR
	for <lists+linux-erofs@lfdr.de>; Thu,  6 Feb 2025 23:50:56 +1100 (AEDT)
X-Original-To: linux-erofs@lists.ozlabs.org
Delivered-To: linux-erofs@lists.ozlabs.org
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip=115.124.30.98
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1738846252;
	cv=none; b=YNsPJT2gMKky/Gu8pHbkp5aoDFfg5m17GPjSsdjblAV2yz33lQmg1t4E8BdTj7xKKOu+f6513jvNdlYGd7UEPRIicvJZP4Rbc+lJLtgcqa0K7qM2Ql0qrjhcjhYGfuztI2FB0R/3PMob/RD72382NogzOqgBgrufL3YJyQuoByGr+LRINRuB/gDAFPOWSjZuSdnrTdC0uDrBs8YE3IXpAQD8V4lqclSus0icU1nxg08vN14eCOiWCa1AjFak+k/1o/ZOoMhYmRULKoO6PLdG6w337+9HgKotv+OaVOK03wklD3Y3Vy7QF2ihgiAcBf3aa1sc0Muw7FIdfwkViPusOQ==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1738846252; c=relaxed/relaxed;
	bh=Kt9TJEPzmU0eAZxjwd5ATUc5mPBeL6NJFuVh6vb/F0U=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=MmulWxaHe+3ypfvjevnA4HyIhCPCE5vkkQUU5eoYNv+HP+rd3ucQSTGGy4oaLvX8nB6j1Bf4zHnG3kBbKbgYXnEXVcbKnZcqp8OI263bQK/ffcOS+k6dQkiATEoD0C1QaX0MTqsSsXBJ3IjXbzZXHrb3WzXNZ/u0opFokFNr/AH3iWTAeLOi88T+jbzfYKAeu6kSMyn/3dmU5PytYD/zTk0nzYly+tNOpmVTcOPkXr3o667NOhTRApYr5krlZHAJ/Q/b0xOuhv8ofJhILp4AAPZprT6E7Vxz6Zpjza+k8b90zhFxIXREYYFkwZhPOZhxTyxBUX5Rfpg1N1UCBHBgnA==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com; dkim=pass (1024-bit key; unprotected) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.a=rsa-sha256 header.s=default header.b=UmQbqeZ9; dkim-atps=neutral; spf=pass (client-ip=115.124.30.98; helo=out30-98.freemail.mail.aliyun.com; envelope-from=hsiangkao@linux.alibaba.com; receiver=lists.ozlabs.org) smtp.mailfrom=linux.alibaba.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (1024-bit key; unprotected) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.a=rsa-sha256 header.s=default header.b=UmQbqeZ9;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=linux.alibaba.com (client-ip=115.124.30.98; helo=out30-98.freemail.mail.aliyun.com; envelope-from=hsiangkao@linux.alibaba.com; receiver=lists.ozlabs.org)
Received: from out30-98.freemail.mail.aliyun.com (out30-98.freemail.mail.aliyun.com [115.124.30.98])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4YpcQz1Wpcz30Gf
	for <linux-erofs@lists.ozlabs.org>; Thu,  6 Feb 2025 23:50:50 +1100 (AEDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=linux.alibaba.com; s=default;
	t=1738846247; h=From:To:Subject:Date:Message-ID:MIME-Version;
	bh=Kt9TJEPzmU0eAZxjwd5ATUc5mPBeL6NJFuVh6vb/F0U=;
	b=UmQbqeZ9tcXh6yR6xS1Wedufq5ikDEMIFR0KeZ83hEYvEamxDHtlDHbVyixiEBdFrhUSCACnpIRPOtT6AgoYCGG2/W3xpQ2RB63wDK6AST4+u7Lh4zdK7GvYm1OvrlIzlVlHX/Iko5TRaEUSH6vIznBYVbrL8TX1ZTxXZuYEsU4=
Received: from x31i01179.sqa.na131.tbsite.net(mailfrom:hsiangkao@linux.alibaba.com fp:SMTPD_---0WOwMl57_1738846245 cluster:ay36)
          by smtp.aliyun-inc.com;
          Thu, 06 Feb 2025 20:50:46 +0800
From: Gao Xiang <hsiangkao@linux.alibaba.com>
To: linux-erofs@lists.ozlabs.org
Subject: [PATCH 4/9] erofs-utils: lib: introduce the secondary compression head
Date: Thu,  6 Feb 2025 20:50:29 +0800
Message-ID: <20250206125034.1462966-4-hsiangkao@linux.alibaba.com>
X-Mailer: git-send-email 2.43.5
In-Reply-To: <20250206125034.1462966-1-hsiangkao@linux.alibaba.com>
References: <20250206125034.1462966-1-hsiangkao@linux.alibaba.com>
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

Source kernel commit: 72bb52620fdffca95a14ee52188a33cd84e574e2
Signed-off-by: Gao Xiang <hsiangkao@linux.alibaba.com>
---
 lib/zmap.c | 46 ++++++++++++++++++++++++++++++----------------
 1 file changed, 30 insertions(+), 16 deletions(-)

diff --git a/lib/zmap.c b/lib/zmap.c
index 0a9bc6a..ee0af1f 100644
--- a/lib/zmap.c
+++ b/lib/zmap.c
@@ -71,7 +71,8 @@ static int z_erofs_load_full_lcluster(struct z_erofs_maprecorder *m,
 		m->clusterofs = 1 << vi->z_logical_clusterbits;
 		m->delta[0] = le16_to_cpu(di->di_u.delta[0]);
 		if (m->delta[0] & Z_EROFS_LI_D0_CBLKCNT) {
-			if (!(vi->z_advise & Z_EROFS_ADVISE_BIG_PCLUSTER_1)) {
+			if (!(vi->z_advise & (Z_EROFS_ADVISE_BIG_PCLUSTER_1 |
+					      Z_EROFS_ADVISE_BIG_PCLUSTER_2))) {
 				DBG_BUGON(1);
 				return -EFSCORRUPTED;
 			}
@@ -327,6 +328,7 @@ static int z_erofs_extent_lookback(struct z_erofs_maprecorder *m,
 		return z_erofs_extent_lookback(m, m->delta[0]);
 	case Z_EROFS_LCLUSTER_TYPE_PLAIN:
 	case Z_EROFS_LCLUSTER_TYPE_HEAD1:
+	case Z_EROFS_LCLUSTER_TYPE_HEAD2:
 		m->headtype = m->type;
 		map->m_la = (lcn << lclusterbits) | m->clusterofs;
 		break;
@@ -350,10 +352,15 @@ static int z_erofs_get_extent_compressedlen(struct z_erofs_maprecorder *m,
 	int err;
 
 	DBG_BUGON(m->type != Z_EROFS_LCLUSTER_TYPE_PLAIN &&
-		  m->type != Z_EROFS_LCLUSTER_TYPE_HEAD1);
+		  m->type != Z_EROFS_LCLUSTER_TYPE_HEAD1 &&
+		  m->type != Z_EROFS_LCLUSTER_TYPE_HEAD2);
+	DBG_BUGON(m->type != m->headtype);
 
 	if (m->headtype == Z_EROFS_LCLUSTER_TYPE_PLAIN ||
-	    !(vi->z_advise & Z_EROFS_ADVISE_BIG_PCLUSTER_1)) {
+	    ((m->headtype == Z_EROFS_LCLUSTER_TYPE_HEAD1) &&
+	     !(vi->z_advise & Z_EROFS_ADVISE_BIG_PCLUSTER_1)) ||
+	    ((m->headtype == Z_EROFS_LCLUSTER_TYPE_HEAD2) &&
+	     !(vi->z_advise & Z_EROFS_ADVISE_BIG_PCLUSTER_2))) {
 		map->m_plen = 1 << lclusterbits;
 		return 0;
 	}
@@ -380,6 +387,7 @@ static int z_erofs_get_extent_compressedlen(struct z_erofs_maprecorder *m,
 	switch (m->type) {
 	case Z_EROFS_LCLUSTER_TYPE_PLAIN:
 	case Z_EROFS_LCLUSTER_TYPE_HEAD1:
+	case Z_EROFS_LCLUSTER_TYPE_HEAD2:
 		/*
 		 * if the 1st NONHEAD lcluster is actually PLAIN or HEAD type
 		 * rather than CBLKCNT, it's a 1 lcluster-sized pcluster.
@@ -431,7 +439,8 @@ static int z_erofs_get_extent_decompressedlen(struct z_erofs_maprecorder *m)
 			DBG_BUGON(!m->delta[1] &&
 				  m->clusterofs != 1 << lclusterbits);
 		} else if (m->type == Z_EROFS_LCLUSTER_TYPE_PLAIN ||
-			   m->type == Z_EROFS_LCLUSTER_TYPE_HEAD1) {
+			   m->type == Z_EROFS_LCLUSTER_TYPE_HEAD1 ||
+			   m->type == Z_EROFS_LCLUSTER_TYPE_HEAD2) {
 			/* go on until the next HEAD lcluster */
 			if (lcn != headlcn)
 				break;
@@ -484,6 +493,7 @@ static int z_erofs_do_map_blocks(struct erofs_inode *vi,
 	switch (m.type) {
 	case Z_EROFS_LCLUSTER_TYPE_PLAIN:
 	case Z_EROFS_LCLUSTER_TYPE_HEAD1:
+	case Z_EROFS_LCLUSTER_TYPE_HEAD2:
 		if (endoff >= m.clusterofs) {
 			m.headtype = m.type;
 			map->m_la = (m.lcn << lclusterbits) | m.clusterofs;
@@ -553,6 +563,8 @@ static int z_erofs_do_map_blocks(struct erofs_inode *vi,
 		else
 			map->m_algorithmformat =
 				Z_EROFS_COMPRESSION_SHIFTED;
+	} else if (m.headtype == Z_EROFS_LCLUSTER_TYPE_HEAD2) {
+		map->m_algorithmformat = vi->z_algorithmtype[1];
 	} else {
 		map->m_algorithmformat = vi->z_algorithmtype[0];
 	}
@@ -572,18 +584,18 @@ out:
 
 static int z_erofs_fill_inode_lazy(struct erofs_inode *vi)
 {
-	int ret;
 	erofs_off_t pos;
 	struct z_erofs_map_header *h;
 	char buf[sizeof(struct z_erofs_map_header)];
 	struct erofs_sb_info *sbi = vi->sbi;
+	int err, headnr;
 
 	if (vi->flags & EROFS_I_Z_INITED)
 		return 0;
 
 	pos = round_up(erofs_iloc(vi) + vi->inode_isize + vi->xattr_isize, 8);
-	ret = erofs_dev_read(sbi, 0, buf, pos, sizeof(buf));
-	if (ret < 0)
+	err = erofs_dev_read(sbi, 0, buf, pos, sizeof(buf));
+	if (err < 0)
 		return -EIO;
 
 	h = (struct z_erofs_map_header *)buf;
@@ -602,9 +614,11 @@ static int z_erofs_fill_inode_lazy(struct erofs_inode *vi)
 	vi->z_algorithmtype[0] = h->h_algorithmtype & 15;
 	vi->z_algorithmtype[1] = h->h_algorithmtype >> 4;
 
-	if (vi->z_algorithmtype[0] >= Z_EROFS_COMPRESSION_MAX) {
-		erofs_err("unknown compression format %u for nid %llu",
-			  vi->z_algorithmtype[0], (unsigned long long)vi->nid);
+	headnr = 0;
+	if (vi->z_algorithmtype[0] >= Z_EROFS_COMPRESSION_MAX ||
+	    vi->z_algorithmtype[++headnr] >= Z_EROFS_COMPRESSION_MAX) {
+		erofs_err("unknown HEAD%u format %u for nid %llu",
+			  headnr + 1, vi->z_algorithmtype[0], vi->nid | 0ULL);
 		return -EOPNOTSUPP;
 	}
 
@@ -621,7 +635,7 @@ static int z_erofs_fill_inode_lazy(struct erofs_inode *vi)
 		struct erofs_map_blocks map = { .index = UINT_MAX };
 
 		vi->idata_size = le16_to_cpu(h->h_idata_size);
-		ret = z_erofs_do_map_blocks(vi, &map,
+		err = z_erofs_do_map_blocks(vi, &map,
 					    EROFS_GET_BLOCKS_FINDTAIL);
 		if (!map.m_plen ||
 		    erofs_blkoff(sbi, map.m_pa) + map.m_plen > erofs_blksiz(sbi)) {
@@ -629,18 +643,18 @@ static int z_erofs_fill_inode_lazy(struct erofs_inode *vi)
 				  map.m_plen | 0ULL);
 			return -EFSCORRUPTED;
 		}
-		if (ret < 0)
-			return ret;
+		if (err < 0)
+			return err;
 	}
 	if (vi->z_advise & Z_EROFS_ADVISE_FRAGMENT_PCLUSTER &&
 	    !(h->h_clusterbits >> Z_EROFS_FRAGMENT_INODE_BIT)) {
 		struct erofs_map_blocks map = { .index = UINT_MAX };
 
 		vi->fragmentoff = le32_to_cpu(h->h_fragmentoff);
-		ret = z_erofs_do_map_blocks(vi, &map,
+		err = z_erofs_do_map_blocks(vi, &map,
 					    EROFS_GET_BLOCKS_FINDTAIL);
-		if (ret < 0)
-			return ret;
+		if (err < 0)
+			return err;
 	}
 out:
 	vi->flags |= EROFS_I_Z_INITED;
-- 
2.43.5

