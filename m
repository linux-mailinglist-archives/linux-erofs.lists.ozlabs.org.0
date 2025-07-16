Return-Path: <linux-erofs+bounces-634-lists+linux-erofs=lfdr.de@lists.ozlabs.org>
X-Original-To: lists+linux-erofs@lfdr.de
Delivered-To: lists+linux-erofs@lfdr.de
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	by mail.lfdr.de (Postfix) with ESMTPS id 9391FB06E28
	for <lists+linux-erofs@lfdr.de>; Wed, 16 Jul 2025 08:44:43 +0200 (CEST)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4bhmkZ5t4Mz2xS9;
	Wed, 16 Jul 2025 16:44:38 +1000 (AEST)
X-Original-To: linux-erofs@lists.ozlabs.org
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip=115.124.30.110
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1752648278;
	cv=none; b=mN8DLXUvaWLvZMks6l5cRVOZDDc4fKZaTgBzpUJ1kQ/PdMLmhKAfU8skXh80VzQXXi262N9DrY4T4Oa2gNXxrWrxPwF4k5Q3oaPiyr4ngNABLwI6VYY7r36UXOYm92EKXvR6DVya49jvdb/DORKLkJIhM4De5V/Gp58DfHix97zhKUKIlIGL6VBE3yXPgaOVq7ed9Aeif2KBBzSVMIUxvWjeCEi/UHSDvePJ+qSmCwCzmSOE6tJJwwcpujbAxLQOc/Kxal/nq8SnWQVFKRHisXgFMHF5dJfv1UgKENBc21Ta4Itdg9JP8f+mvZKy/3HladeImZ+lmOuKEHfvYfxWMw==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1752648278; c=relaxed/relaxed;
	bh=RYcHHDGKG22FuVlkAHRB4rfI+ekqEKqG/7U15GMIscY=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=FxLUwo2NDYkqJ0v6yxjg7NWudrW9f6xpIK4USRFepqF42W6cwslX+vyXqgu/p49m6FkGkCLONsQaNraCnepriJiybZKFbN8/OGdvnpSNBYrHPvbzJcjQasRjaNXoXF1qWMsyuA1yjaLQV9yDkVzxe3KFFiLvzRweqXUZNzdATdWZMg2Dod2ldHIbR7HAgfChkH5WRDAAUoMcAIPq4iAxrtjrtuaxsiO66K+NvV9BpozlJtjDIb8CTxwnt2wub5LiA9aigC1fyuPNtY2AFHwSnRtxYD+N5tmytzJbReO6hpioHCmZB/zu6Dn1mKkivOPDLn2Fv+wzXubACTa3/Kj4+w==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com; dkim=pass (1024-bit key; unprotected) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.a=rsa-sha256 header.s=default header.b=gSaniCWw; dkim-atps=neutral; spf=pass (client-ip=115.124.30.110; helo=out30-110.freemail.mail.aliyun.com; envelope-from=hsiangkao@linux.alibaba.com; receiver=lists.ozlabs.org) smtp.mailfrom=linux.alibaba.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (1024-bit key; unprotected) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.a=rsa-sha256 header.s=default header.b=gSaniCWw;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=linux.alibaba.com (client-ip=115.124.30.110; helo=out30-110.freemail.mail.aliyun.com; envelope-from=hsiangkao@linux.alibaba.com; receiver=lists.ozlabs.org)
Received: from out30-110.freemail.mail.aliyun.com (out30-110.freemail.mail.aliyun.com [115.124.30.110])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4bhmh64G1Sz2yN1
	for <linux-erofs@lists.ozlabs.org>; Wed, 16 Jul 2025 16:42:24 +1000 (AEST)
DKIM-Signature:v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=linux.alibaba.com; s=default;
	t=1752648118; h=From:To:Subject:Date:Message-ID:MIME-Version;
	bh=RYcHHDGKG22FuVlkAHRB4rfI+ekqEKqG/7U15GMIscY=;
	b=gSaniCWwZBVu2AYzZHDeVWtDmqpcrrh8m7eyJcEjmiNobYL7GLkxufj86cyFO29yy7cpKypsVdLsU/xiHgiwz6IMjn7UEBrRVW/RVa+Z5Gln2UUdRtJ1d3APCPGXluZihYApC3h+YMjkxyLcY0SHev1EYr6T8uxgvIVXN0pMrKM=
Received: from x31i01179.sqa.na131.tbsite.net(mailfrom:hsiangkao@linux.alibaba.com fp:SMTPD_---0Wj33g3N_1752648113 cluster:ay36)
          by smtp.aliyun-inc.com;
          Wed, 16 Jul 2025 14:41:57 +0800
From: Gao Xiang <hsiangkao@linux.alibaba.com>
To: linux-erofs@lists.ozlabs.org
Cc: LMKL <linux-kernel@vger.kernel.org>,
	Gao Xiang <hsiangkao@linux.alibaba.com>
Subject: [PATCH v2 2/2] erofs: unify meta buffers in z_erofs_fill_inode()
Date: Wed, 16 Jul 2025 14:41:52 +0800
Message-ID: <20250716064152.3537457-1-hsiangkao@linux.alibaba.com>
X-Mailer: git-send-email 2.43.5
In-Reply-To: <20250714090907.4095645-2-hsiangkao@linux.alibaba.com>
References: <20250714090907.4095645-2-hsiangkao@linux.alibaba.com>
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

There is no need to keep additional local metabufs since we already
have one in `struct erofs_map_blocks`.

This was actually a leftover when applying meta buffers to zmap
operations, see commit 09c543798c3c ("erofs: use meta buffers for
zmap operations").

Signed-off-by: Gao Xiang <hsiangkao@linux.alibaba.com>
---
v1: https://lore.kernel.org/r/20250714090907.4095645-2-hsiangkao@linux.alibaba.com
change since v1:
 - Fix a regresssion since EROFS_GET_BLOCKS_FINDTAIL will update the
   original map to the tail extent so just keep using a new `map`.

 fs/erofs/zmap.c | 23 ++++++++++-------------
 1 file changed, 10 insertions(+), 13 deletions(-)

diff --git a/fs/erofs/zmap.c b/fs/erofs/zmap.c
index ff1d0751fc61..b72a0e3f9362 100644
--- a/fs/erofs/zmap.c
+++ b/fs/erofs/zmap.c
@@ -620,13 +620,12 @@ static int z_erofs_map_blocks_ext(struct inode *inode,
 	return 0;
 }
 
-static int z_erofs_fill_inode_lazy(struct inode *inode)
+static int z_erofs_fill_inode(struct inode *inode, struct erofs_map_blocks *map)
 {
 	struct erofs_inode *const vi = EROFS_I(inode);
 	struct super_block *const sb = inode->i_sb;
 	int err, headnr;
 	erofs_off_t pos;
-	struct erofs_buf buf = __EROFS_BUF_INITIALIZER;
 	struct z_erofs_map_header *h;
 
 	if (test_bit(EROFS_I_Z_INITED_BIT, &vi->flags)) {
@@ -646,7 +645,7 @@ static int z_erofs_fill_inode_lazy(struct inode *inode)
 		goto out_unlock;
 
 	pos = ALIGN(erofs_iloc(inode) + vi->inode_isize + vi->xattr_isize, 8);
-	h = erofs_read_metabuf(&buf, sb, pos);
+	h = erofs_read_metabuf(&map->buf, sb, pos);
 	if (IS_ERR(h)) {
 		err = PTR_ERR(h);
 		goto out_unlock;
@@ -684,7 +683,7 @@ static int z_erofs_fill_inode_lazy(struct inode *inode)
 		erofs_err(sb, "unknown HEAD%u format %u for nid %llu, please upgrade kernel",
 			  headnr + 1, vi->z_algorithmtype[headnr], vi->nid);
 		err = -EOPNOTSUPP;
-		goto out_put_metabuf;
+		goto out_unlock;
 	}
 
 	if (!erofs_sb_has_big_pcluster(EROFS_SB(sb)) &&
@@ -693,7 +692,7 @@ static int z_erofs_fill_inode_lazy(struct inode *inode)
 		erofs_err(sb, "per-inode big pcluster without sb feature for nid %llu",
 			  vi->nid);
 		err = -EFSCORRUPTED;
-		goto out_put_metabuf;
+		goto out_unlock;
 	}
 	if (vi->datalayout == EROFS_INODE_COMPRESSED_COMPACT &&
 	    !(vi->z_advise & Z_EROFS_ADVISE_BIG_PCLUSTER_1) ^
@@ -701,27 +700,25 @@ static int z_erofs_fill_inode_lazy(struct inode *inode)
 		erofs_err(sb, "big pcluster head1/2 of compact indexes should be consistent for nid %llu",
 			  vi->nid);
 		err = -EFSCORRUPTED;
-		goto out_put_metabuf;
+		goto out_unlock;
 	}
 
 	if (vi->z_idata_size ||
 	    (vi->z_advise & Z_EROFS_ADVISE_FRAGMENT_PCLUSTER)) {
-		struct erofs_map_blocks map = {
+		struct erofs_map_blocks tm = {
 			.buf = __EROFS_BUF_INITIALIZER
 		};
 
-		err = z_erofs_map_blocks_fo(inode, &map,
+		err = z_erofs_map_blocks_fo(inode, &tm,
 					    EROFS_GET_BLOCKS_FINDTAIL);
-		erofs_put_metabuf(&map.buf);
+		erofs_put_metabuf(&tm.buf);
 		if (err < 0)
-			goto out_put_metabuf;
+			goto out_unlock;
 	}
 done:
 	/* paired with smp_mb() at the beginning of the function */
 	smp_mb();
 	set_bit(EROFS_I_Z_INITED_BIT, &vi->flags);
-out_put_metabuf:
-	erofs_put_metabuf(&buf);
 out_unlock:
 	clear_and_wake_up_bit(EROFS_I_BL_Z_BIT, &vi->flags);
 	return err;
@@ -739,7 +736,7 @@ int z_erofs_map_blocks_iter(struct inode *inode, struct erofs_map_blocks *map,
 		map->m_la = inode->i_size;
 		map->m_flags = 0;
 	} else {
-		err = z_erofs_fill_inode_lazy(inode);
+		err = z_erofs_fill_inode(inode, map);
 		if (!err) {
 			if (vi->datalayout == EROFS_INODE_COMPRESSED_FULL &&
 			    (vi->z_advise & Z_EROFS_ADVISE_EXTENTS))
-- 
2.43.5


