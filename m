Return-Path: <linux-erofs+bounces-169-lists+linux-erofs=lfdr.de@lists.ozlabs.org>
X-Original-To: lists+linux-erofs@lfdr.de
Delivered-To: lists+linux-erofs@lfdr.de
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	by mail.lfdr.de (Postfix) with ESMTPS id E162CA82C72
	for <lists+linux-erofs@lfdr.de>; Wed,  9 Apr 2025 18:33:19 +0200 (CEST)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4ZXpQy4n7Bz30VR;
	Thu, 10 Apr 2025 02:33:14 +1000 (AEST)
X-Original-To: linux-erofs@lists.ozlabs.org
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip=115.124.30.124
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1744216394;
	cv=none; b=Mf2l5L6hIm6QCJPSlPHMfT4EY0HJOZh6DCKFWUEAJ0TfwLW45Oi7BUil4rAvncDTsijR/cC+F2JgfPd5ndsk5JKhJWxJG7f83pDxUzoG5poFYo8IJgz5Bc21s4EWj3yw4YTfI/DxHvWZa4HUpd1xS8+mEFyg+uUMSN+62dsPNN7b7J1gIXYkz693fHB1dDNexMtXaWVx46UmfjRSzmOjuYTQYpxxDFRi2YaVueQDKmfoZJOCl3RME2OpCJ/swIxbVWE4siTWN0ZBTcP/7qYOU03QpVvqAWXhaj+Swtopry71on5aDoNJAljLxqw+0d7cqcrOLF7Xm9QNJ40S5mlTZA==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1744216394; c=relaxed/relaxed;
	bh=BB9U2ROrfWmbzi5lqZ5wA4hn/FKv9fP150TX73miL3o=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=ZwJK39P+MQzbmaprSm43u+8aA1VoDTTChau3e5S2uUaqshh5C+ngrJnd5hjJ27Yc6l/xrkNk+/tA4UX95alO/zHxIlvXf6di12JJh8LW6nQgy6poj6sF7XN+rZY4mgQr2S+K6G8vLvhyqby1DZZ622wBpbLPTwSegC6aEArSBFywTfWFyri7BPdFCaISE91l5fjnzbNq0k5l18Z5PS64R68gAK+sohjeSue1WEFQRlpgTCHtehaaslyQM/Jwk+TqRqUNxmmoWn28AeLK78uTivWocFFV1mbaxXZyqrUMmLk/TdGN8JKXHXrwrSLN/vaVCT4ZNNeZ9Jitsmi23QeFHg==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com; dkim=pass (1024-bit key; unprotected) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.a=rsa-sha256 header.s=default header.b=j2+OiirZ; dkim-atps=neutral; spf=pass (client-ip=115.124.30.124; helo=out30-124.freemail.mail.aliyun.com; envelope-from=hsiangkao@linux.alibaba.com; receiver=lists.ozlabs.org) smtp.mailfrom=linux.alibaba.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (1024-bit key; unprotected) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.a=rsa-sha256 header.s=default header.b=j2+OiirZ;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=linux.alibaba.com (client-ip=115.124.30.124; helo=out30-124.freemail.mail.aliyun.com; envelope-from=hsiangkao@linux.alibaba.com; receiver=lists.ozlabs.org)
Received: from out30-124.freemail.mail.aliyun.com (out30-124.freemail.mail.aliyun.com [115.124.30.124])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4ZXpQw4npyz30Kg
	for <linux-erofs@lists.ozlabs.org>; Thu, 10 Apr 2025 02:33:10 +1000 (AEST)
DKIM-Signature:v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=linux.alibaba.com; s=default;
	t=1744216387; h=From:To:Subject:Date:Message-ID:MIME-Version;
	bh=BB9U2ROrfWmbzi5lqZ5wA4hn/FKv9fP150TX73miL3o=;
	b=j2+OiirZknOCquGpWZlrTBSwSu2wcA2lxH57tHKHtYZk9aMB8C0jip8ODsrNsUFZEtvbXhc/k9BYV8gXLrqddRFCURovelB5lbkTekCLRvxm2yle/QmxWPiwN+sxDF0SZ1vOYZqH3zGYxd+jDRQZ26UqkA3cjmhj794muP60jIY=
Received: from x31i01179.sqa.na131.tbsite.net(mailfrom:hsiangkao@linux.alibaba.com fp:SMTPD_---0WWKsZSN_1744216385 cluster:ay36)
          by smtp.aliyun-inc.com;
          Thu, 10 Apr 2025 00:33:06 +0800
From: Gao Xiang <hsiangkao@linux.alibaba.com>
To: linux-erofs@lists.ozlabs.org
Cc: Gao Xiang <hsiangkao@linux.alibaba.com>
Subject: [PATCH v2 02/10] erofs-utils: lib: simplify tail inline pcluster handling
Date: Thu, 10 Apr 2025 00:32:51 +0800
Message-ID: <20250409163259.2077865-2-hsiangkao@linux.alibaba.com>
X-Mailer: git-send-email 2.43.5
In-Reply-To: <20250409163259.2077865-1-hsiangkao@linux.alibaba.com>
References: <20250409163259.2077865-1-hsiangkao@linux.alibaba.com>
X-Mailing-List: linux-erofs@lists.ozlabs.org
List-Id: <linux-erofs.lists.ozlabs.org>
List-Help: <mailto:linux-erofs+help@lists.ozlabs.org>
List-Owner: <mailto:linux-erofs+owner@lists.ozlabs.org>
List-Post: <mailto:linux-erofs@lists.ozlabs.org>
List-Subscribe: <mailto:linux-erofs+subscribe@lists.ozlabs.org>,
  <mailto:linux-erofs+subscribe-digest@lists.ozlabs.org>,
  <mailto:linux-erofs+subscribe-nomail@lists.ozlabs.org>
List-Unsubscribe: <mailto:linux-erofs+unsubscribe@lists.ozlabs.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-15.7 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,DKIM_VALID_EF,ENV_AND_HDR_SPF_MATCH,RCVD_IN_DNSWL_NONE,
	SPF_HELO_NONE,SPF_PASS,UNPARSEABLE_RELAY,USER_IN_DEF_DKIM_WL,
	USER_IN_DEF_SPF_WL autolearn=disabled version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-25) on lists.ozlabs.org

Source kernel commit: b7710262d743aca112877d12abed61ce8a5d0d98

Signed-off-by: Gao Xiang <hsiangkao@linux.alibaba.com>
---
 include/erofs/internal.h |  4 ++--
 lib/zmap.c               | 20 ++++++++++----------
 2 files changed, 12 insertions(+), 12 deletions(-)

diff --git a/include/erofs/internal.h b/include/erofs/internal.h
index 90bee07..36df13a 100644
--- a/include/erofs/internal.h
+++ b/include/erofs/internal.h
@@ -270,8 +270,8 @@ struct erofs_inode {
 				erofs_off_t fragment_size;
 			};
 			union {
-				unsigned int z_idataoff;
-				erofs_off_t fragmentoff;
+				erofs_off_t	fragmentoff;
+				erofs_off_t	z_fragmentoff;
 			};
 #define z_idata_size	idata_size
 		};
diff --git a/lib/zmap.c b/lib/zmap.c
index 30bb7e3..d47ed6b 100644
--- a/lib/zmap.c
+++ b/lib/zmap.c
@@ -414,8 +414,8 @@ static int z_erofs_do_map_blocks(struct erofs_inode *vi,
 				 int flags)
 {
 	struct erofs_sb_info *sbi = vi->sbi;
-	bool ztailpacking = vi->z_advise & Z_EROFS_ADVISE_INLINE_PCLUSTER;
 	bool fragment = vi->z_advise & Z_EROFS_ADVISE_FRAGMENT_PCLUSTER;
+	bool ztailpacking = vi->z_idata_size;
 	struct z_erofs_maprecorder m = {
 		.inode = vi,
 		.map = map,
@@ -435,9 +435,8 @@ static int z_erofs_do_map_blocks(struct erofs_inode *vi,
 	if (err)
 		goto out;
 
-	if (ztailpacking && (flags & EROFS_GET_BLOCKS_FINDTAIL))
-		vi->z_idataoff = m.nextpackoff;
-
+	if ((flags & EROFS_GET_BLOCKS_FINDTAIL) && ztailpacking)
+		vi->z_fragmentoff = m.nextpackoff;
 	map->m_flags = EROFS_MAP_MAPPED | EROFS_MAP_ENCODED;
 	end = (m.lcn + 1ULL) << lclusterbits;
 
@@ -492,7 +491,7 @@ static int z_erofs_do_map_blocks(struct erofs_inode *vi,
 	}
 	if (ztailpacking && m.lcn == vi->z_tailextent_headlcn) {
 		map->m_flags |= EROFS_MAP_META;
-		map->m_pa = vi->z_idataoff;
+		map->m_pa = vi->z_fragmentoff;
 		map->m_plen = vi->z_idata_size;
 	} else if (fragment && m.lcn == vi->z_tailextent_headlcn) {
 		map->m_flags |= EROFS_MAP_FRAGMENT;
@@ -568,6 +567,10 @@ static int z_erofs_fill_inode_lazy(struct erofs_inode *vi)
 	vi->z_advise = le16_to_cpu(h->h_advise);
 	vi->z_algorithmtype[0] = h->h_algorithmtype & 15;
 	vi->z_algorithmtype[1] = h->h_algorithmtype >> 4;
+	if (vi->z_advise & Z_EROFS_ADVISE_FRAGMENT_PCLUSTER)
+		vi->z_fragmentoff = le32_to_cpu(h->h_fragmentoff);
+	else if (vi->z_advise & Z_EROFS_ADVISE_INLINE_PCLUSTER)
+		vi->z_idata_size = le16_to_cpu(h->h_idata_size);
 
 	headnr = 0;
 	if (vi->z_algorithmtype[0] >= Z_EROFS_COMPRESSION_MAX ||
@@ -586,14 +589,12 @@ static int z_erofs_fill_inode_lazy(struct erofs_inode *vi)
 		return -EFSCORRUPTED;
 	}
 
-	if (vi->z_advise & Z_EROFS_ADVISE_INLINE_PCLUSTER) {
+	if (vi->z_idata_size) {
 		struct erofs_map_blocks map = { .index = UINT_MAX };
 
-		vi->idata_size = le16_to_cpu(h->h_idata_size);
 		err = z_erofs_do_map_blocks(vi, &map,
 					    EROFS_GET_BLOCKS_FINDTAIL);
-		if (!map.m_plen ||
-		    erofs_blkoff(sbi, map.m_pa) + map.m_plen > erofs_blksiz(sbi)) {
+		if (erofs_blkoff(sbi, map.m_pa) + map.m_plen > erofs_blksiz(sbi)) {
 			erofs_err("invalid tail-packing pclustersize %llu",
 				  map.m_plen | 0ULL);
 			return -EFSCORRUPTED;
@@ -605,7 +606,6 @@ static int z_erofs_fill_inode_lazy(struct erofs_inode *vi)
 	    !(h->h_clusterbits >> Z_EROFS_FRAGMENT_INODE_BIT)) {
 		struct erofs_map_blocks map = { .index = UINT_MAX };
 
-		vi->fragmentoff = le32_to_cpu(h->h_fragmentoff);
 		err = z_erofs_do_map_blocks(vi, &map,
 					    EROFS_GET_BLOCKS_FINDTAIL);
 		if (err < 0)
-- 
2.43.5


