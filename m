Return-Path: <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>
X-Original-To: lists+linux-erofs@lfdr.de
Delivered-To: lists+linux-erofs@lfdr.de
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	by mail.lfdr.de (Postfix) with ESMTPS id 8F680A43DE3
	for <lists+linux-erofs@lfdr.de>; Tue, 25 Feb 2025 12:40:58 +0100 (CET)
Received: from boromir.ozlabs.org (localhost [IPv6:::1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4Z2FzW5qFJz30WX
	for <lists+linux-erofs@lfdr.de>; Tue, 25 Feb 2025 22:40:55 +1100 (AEDT)
X-Original-To: linux-erofs@lists.ozlabs.org
Delivered-To: linux-erofs@lists.ozlabs.org
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip=115.124.30.101
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1740483653;
	cv=none; b=M5BWXaeo+rSzHcIOxJrXM1u2x5xgEiwhMaZr8Ix+gNhUU5uYuGvSiKmdhYk5CLh2zvoRBD3DC3P7MLvTSpFkpvu++fNrNsdt7Hhjtkti8siGj7GQ8agaCkdvqTf2JjZWSI0yw0+eQszJlz4hkZzrQ7hQA+v9KG7KiLbHoIM/2LHPZOeTBMyhOpb9QJQPBxfbsUR5mq+pkv56DJ/QHvWgUGrZV2rj8b0qqcbdFmOFUzb5yBDQQcnIrlkG8zo/uIu2EizTPNUyVfxGUjk4SsjW6dhLkweRvyZ9KfxKaj6XAMl4W9Nn+Qh8hjjB01m+SKAyHQ9aMB7+u+m5covlY908CA==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1740483653; c=relaxed/relaxed;
	bh=7gz1sWlPL/imZ77uyvUW1lHoH0Aq1FR0LZkvlkecKL0=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=fOYw+OMPN5tC7aLxPqNhrduzB0L02sw038c2BhDvlQj9lOWG48YjzfRT6qiqdoZGswiTDMroZg/0xzIO5VbVkZbBQBaVfCAFOtGU/rosv+NRPhxIcMbGMID3OMWIOUYHG03RAF/iPq+e7urn/V+GWtmFJbfkFProV7Fjznw1yEh0ylQx34PmMp+aDlWA9iEkzva12QQhIB29NNzvVstba8E6MHK8KksJG5jZthQWyPnf9Lpg/4yXl9okRXbkY7AHAeDE/ZUwnpoRxJzIOCfY2SKC6yBZckIfRgV9mkPCBXPKzeXc86c/+S9E4B2lbEyHEhfyddDZwqt0FDGIMdgNRg==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com; dkim=pass (1024-bit key; unprotected) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.a=rsa-sha256 header.s=default header.b=K/u0gkoc; dkim-atps=neutral; spf=pass (client-ip=115.124.30.101; helo=out30-101.freemail.mail.aliyun.com; envelope-from=hsiangkao@linux.alibaba.com; receiver=lists.ozlabs.org) smtp.mailfrom=linux.alibaba.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (1024-bit key; unprotected) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.a=rsa-sha256 header.s=default header.b=K/u0gkoc;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=linux.alibaba.com (client-ip=115.124.30.101; helo=out30-101.freemail.mail.aliyun.com; envelope-from=hsiangkao@linux.alibaba.com; receiver=lists.ozlabs.org)
Received: from out30-101.freemail.mail.aliyun.com (out30-101.freemail.mail.aliyun.com [115.124.30.101])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4Z2FzS06qFz30Vl
	for <linux-erofs@lists.ozlabs.org>; Tue, 25 Feb 2025 22:40:50 +1100 (AEDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=linux.alibaba.com; s=default;
	t=1740483646; h=From:To:Subject:Date:Message-ID:MIME-Version;
	bh=7gz1sWlPL/imZ77uyvUW1lHoH0Aq1FR0LZkvlkecKL0=;
	b=K/u0gkoc8HwJBgdCyksh+BIhzgwratla2FTfr3sAUh7C43hTuicfB9lBQnPsXOWYkL71d4xLwkWxfhrdk8lcAB8SeXmaTi8fcHSGznWn5IL7AQpgdjHR2LRK+MLEJBWevwU9Ds56j6vGT8XaeGl3Hy36aCcZe/SBxJkZMgIoKXI=
Received: from x31i01179.sqa.na131.tbsite.net(mailfrom:hsiangkao@linux.alibaba.com fp:SMTPD_---0WQEf9J3_1740483638 cluster:ay36)
          by smtp.aliyun-inc.com;
          Tue, 25 Feb 2025 19:40:42 +0800
From: Gao Xiang <hsiangkao@linux.alibaba.com>
To: linux-erofs@lists.ozlabs.org
Subject: [PATCH v3 1/2] erofs: simplify tail inline pcluster handling
Date: Tue, 25 Feb 2025 19:40:38 +0800
Message-ID: <20250225114038.3259726-1-hsiangkao@linux.alibaba.com>
X-Mailer: git-send-email 2.43.5
In-Reply-To: <26db55bd-31a1-4fb8-8ac1-add64c971841@linux.alibaba.com>
References: <26db55bd-31a1-4fb8-8ac1-add64c971841@linux.alibaba.com>
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
Cc: Gao Xiang <hsiangkao@linux.alibaba.com>, LKML <linux-kernel@vger.kernel.org>
Errors-To: linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org
Sender: "Linux-erofs" <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>

Use `z_idata_size != 0` to indicate that ztailpacking is enabled.
`Z_EROFS_ADVISE_INLINE_PCLUSTER` cannot be ignored, as `h_idata_size`
could be non-zero prior to erofs-utils 1.6 [1].

Additionally, merge `z_idataoff` and `z_fragmentoff` since these two
features are mutually exclusive for a given inode.

[1] https://git.kernel.org/xiang/erofs-utils/c/547bea3cb71a
Signed-off-by: Gao Xiang <hsiangkao@linux.alibaba.com>
---
change since v2:
 - should not ignore `Z_EROFS_ADVISE_INLINE_PCLUSTER` as mentioned in
   the new commit message.

 fs/erofs/internal.h |  9 ++-------
 fs/erofs/zmap.c     | 20 ++++++++++----------
 2 files changed, 12 insertions(+), 17 deletions(-)

diff --git a/fs/erofs/internal.h b/fs/erofs/internal.h
index b452b6557aa5..b357cbbce764 100644
--- a/fs/erofs/internal.h
+++ b/fs/erofs/internal.h
@@ -263,13 +263,8 @@ struct erofs_inode {
 			unsigned char  z_algorithmtype[2];
 			unsigned char  z_logical_clusterbits;
 			unsigned long  z_tailextent_headlcn;
-			union {
-				struct {
-					erofs_off_t    z_idataoff;
-					unsigned short z_idata_size;
-				};
-				erofs_off_t z_fragmentoff;
-			};
+			erofs_off_t    z_fragmentoff;
+			unsigned short z_idata_size;
 		};
 #endif	/* CONFIG_EROFS_FS_ZIP */
 	};
diff --git a/fs/erofs/zmap.c b/fs/erofs/zmap.c
index a0c1c6450a55..ba4533eabc6a 100644
--- a/fs/erofs/zmap.c
+++ b/fs/erofs/zmap.c
@@ -395,8 +395,8 @@ static int z_erofs_do_map_blocks(struct inode *inode,
 				 struct erofs_map_blocks *map, int flags)
 {
 	struct erofs_inode *const vi = EROFS_I(inode);
-	bool ztailpacking = vi->z_advise & Z_EROFS_ADVISE_INLINE_PCLUSTER;
 	bool fragment = vi->z_advise & Z_EROFS_ADVISE_FRAGMENT_PCLUSTER;
+	bool ztailpacking = vi->z_idata_size;
 	struct z_erofs_maprecorder m = {
 		.inode = inode,
 		.map = map,
@@ -415,9 +415,8 @@ static int z_erofs_do_map_blocks(struct inode *inode,
 	if (err)
 		goto unmap_out;
 
-	if (ztailpacking && (flags & EROFS_GET_BLOCKS_FINDTAIL))
-		vi->z_idataoff = m.nextpackoff;
-
+	if ((flags & EROFS_GET_BLOCKS_FINDTAIL) && ztailpacking)
+		vi->z_fragmentoff = m.nextpackoff;
 	map->m_flags = EROFS_MAP_MAPPED | EROFS_MAP_ENCODED;
 	end = (m.lcn + 1ULL) << lclusterbits;
 
@@ -472,7 +471,7 @@ static int z_erofs_do_map_blocks(struct inode *inode,
 	}
 	if (ztailpacking && m.lcn == vi->z_tailextent_headlcn) {
 		map->m_flags |= EROFS_MAP_META;
-		map->m_pa = vi->z_idataoff;
+		map->m_pa = vi->z_fragmentoff;
 		map->m_plen = vi->z_idata_size;
 	} else if (fragment && m.lcn == vi->z_tailextent_headlcn) {
 		map->m_flags |= EROFS_MAP_FRAGMENT;
@@ -565,6 +564,10 @@ static int z_erofs_fill_inode_lazy(struct inode *inode)
 	vi->z_advise = le16_to_cpu(h->h_advise);
 	vi->z_algorithmtype[0] = h->h_algorithmtype & 15;
 	vi->z_algorithmtype[1] = h->h_algorithmtype >> 4;
+	if (vi->z_advise & Z_EROFS_ADVISE_FRAGMENT_PCLUSTER)
+		vi->z_fragmentoff = le32_to_cpu(h->h_fragmentoff);
+	else if (vi->z_advise & Z_EROFS_ADVISE_INLINE_PCLUSTER)
+		vi->z_idata_size = le16_to_cpu(h->h_idata_size);
 
 	headnr = 0;
 	if (vi->z_algorithmtype[0] >= Z_EROFS_COMPRESSION_MAX ||
@@ -593,18 +596,16 @@ static int z_erofs_fill_inode_lazy(struct inode *inode)
 		goto out_put_metabuf;
 	}
 
-	if (vi->z_advise & Z_EROFS_ADVISE_INLINE_PCLUSTER) {
+	if (vi->z_idata_size) {
 		struct erofs_map_blocks map = {
 			.buf = __EROFS_BUF_INITIALIZER
 		};
 
-		vi->z_idata_size = le16_to_cpu(h->h_idata_size);
 		err = z_erofs_do_map_blocks(inode, &map,
 					    EROFS_GET_BLOCKS_FINDTAIL);
 		erofs_put_metabuf(&map.buf);
 
-		if (!map.m_plen ||
-		    erofs_blkoff(sb, map.m_pa) + map.m_plen > sb->s_blocksize) {
+		if (erofs_blkoff(sb, map.m_pa) + map.m_plen > sb->s_blocksize) {
 			erofs_err(sb, "invalid tail-packing pclustersize %llu",
 				  map.m_plen);
 			err = -EFSCORRUPTED;
@@ -619,7 +620,6 @@ static int z_erofs_fill_inode_lazy(struct inode *inode)
 			.buf = __EROFS_BUF_INITIALIZER
 		};
 
-		vi->z_fragmentoff = le32_to_cpu(h->h_fragmentoff);
 		err = z_erofs_do_map_blocks(inode, &map,
 					    EROFS_GET_BLOCKS_FINDTAIL);
 		erofs_put_metabuf(&map.buf);
-- 
2.43.5

