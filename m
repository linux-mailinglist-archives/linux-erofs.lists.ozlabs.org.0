Return-Path: <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>
X-Original-To: lists+linux-erofs@lfdr.de
Delivered-To: lists+linux-erofs@lfdr.de
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	by mail.lfdr.de (Postfix) with ESMTPS id 0717DA1A04A
	for <lists+linux-erofs@lfdr.de>; Thu, 23 Jan 2025 10:01:33 +0100 (CET)
Received: from boromir.ozlabs.org (localhost [IPv6:::1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4Ydw0k2Hmvz304s
	for <lists+linux-erofs@lfdr.de>; Thu, 23 Jan 2025 20:01:26 +1100 (AEDT)
X-Original-To: linux-erofs@lists.ozlabs.org
Delivered-To: linux-erofs@lists.ozlabs.org
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip=115.124.30.124
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1737622884;
	cv=none; b=cbiQQs1qgQ1xruAnH8PEVjA4stsYFyBu0ic7Zss65aHsfGZSB8s38ir01uGMCZVbU4SzyXuaaGVIhW2xv2etJ5vLvt+9rHL8n0ovHitCnOCo6yF2xQ1GGH9URjF+oHqQIKVRR59edhdcxU7Jjf7F7cipYM11IrdF544Mdvp2Ie/Vov7LebjUiUOT4NbFD90FhiZcokqhvzvy+vj7tIdEJfJcfnkOXMI5r7U4e4U4fArw4H/cAPwczXMumd1niiQTuuKpuwrAG2LvUDKb+HdyN02Lp4XWhSVkFlo9ZbwmUl7SX3VLj3ANt03YYFeiTndLofdDKji9hOKGA+x5jwUdFQ==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1737622884; c=relaxed/relaxed;
	bh=PpA2IB08pHCZzk9POa/pWBkRxPW6FVtTAzux8QczCPc=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=Ing/VjkyFUfDQwaa5zYMOc26g1d4a7+xjSV7RKCGaAd7+33YphFm9xjb0dzKR48pX60MSvGX0UtVQSXzcMpNJ5PcYybVIOnK3+9aHVVJPIv1GYwVW9oJmZUSMwBBc9JBqz3/1C02lWFRlSZWI18PZmXnVBMGMpa4iDkshI30iPqduR3j6Bt9z+0I1ZeJKgBuSC38XQR6XU+sVCu5bhajGr9rnnkEZLkVLALjwUWPou0KLGMdu/gqaQFzC5V0Qh4EACbwmG86aEdPLSyu67/4XtmLogN6FEDWOIeIi0OFYvoQGrMsSwQq6QwsVNHwAfZyIeQ/vmO6aKe2SECJq7deiA==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com; dkim=pass (1024-bit key; unprotected) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.a=rsa-sha256 header.s=default header.b=F2OiD4BZ; dkim-atps=neutral; spf=pass (client-ip=115.124.30.124; helo=out30-124.freemail.mail.aliyun.com; envelope-from=hsiangkao@linux.alibaba.com; receiver=lists.ozlabs.org) smtp.mailfrom=linux.alibaba.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (1024-bit key; unprotected) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.a=rsa-sha256 header.s=default header.b=F2OiD4BZ;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=linux.alibaba.com (client-ip=115.124.30.124; helo=out30-124.freemail.mail.aliyun.com; envelope-from=hsiangkao@linux.alibaba.com; receiver=lists.ozlabs.org)
Received: from out30-124.freemail.mail.aliyun.com (out30-124.freemail.mail.aliyun.com [115.124.30.124])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4Ydw0g2TBnz2yyx
	for <linux-erofs@lists.ozlabs.org>; Thu, 23 Jan 2025 20:01:21 +1100 (AEDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=linux.alibaba.com; s=default;
	t=1737622876; h=From:To:Subject:Date:Message-ID:MIME-Version;
	bh=PpA2IB08pHCZzk9POa/pWBkRxPW6FVtTAzux8QczCPc=;
	b=F2OiD4BZ1uw4jSJcYdkQy+1mHz8seJtTuKVnycSgYrjYAlgOU6XzgBg5scbh7++XI9NmgrGb2QcIAA7DG+tPdnHI2FPp5yN/CX80yEYCR625y6+RvE/daUUxhe5GBPjxhimH+frncWtQW2bqTFtxsnDgJGYiojxEzg+y88N0fjs=
Received: from x31i01179.sqa.na131.tbsite.net(mailfrom:hsiangkao@linux.alibaba.com fp:SMTPD_---0WOBAKEy_1737622870 cluster:ay36)
          by smtp.aliyun-inc.com;
          Thu, 23 Jan 2025 17:01:15 +0800
From: Gao Xiang <hsiangkao@linux.alibaba.com>
To: linux-erofs@lists.ozlabs.org
Subject: [PATCH] erofs: refine z_erofs_get_extent_compressedlen()
Date: Thu, 23 Jan 2025 17:01:09 +0800
Message-ID: <20250123090109.973463-1-hsiangkao@linux.alibaba.com>
X-Mailer: git-send-email 2.43.5
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

 - Set `compressedblks = 1` directly for non-bigpcluster cases.  This
   simplifies the logic a bit since lcluster sizes larger than one block
   are unsupported and the details remain unclear.

 - For Z_EROFS_LCLUSTER_TYPE_PLAIN pclusters, avoid assuming
   `compressedblks = 1` by default.  Instead, check if
   Z_EROFS_ADVISE_BIG_PCLUSTER_2 is set.

It basically has no impact to existing valid images, but it's useful to
find the gap to prepare for large PLAIN pclusters.

Signed-off-by: Gao Xiang <hsiangkao@linux.alibaba.com>
---
 fs/erofs/zmap.c | 36 ++++++++++++++++--------------------
 1 file changed, 16 insertions(+), 20 deletions(-)

diff --git a/fs/erofs/zmap.c b/fs/erofs/zmap.c
index b9e35089c9b8..689437e99a5a 100644
--- a/fs/erofs/zmap.c
+++ b/fs/erofs/zmap.c
@@ -294,27 +294,23 @@ static int z_erofs_extent_lookback(struct z_erofs_maprecorder *m,
 static int z_erofs_get_extent_compressedlen(struct z_erofs_maprecorder *m,
 					    unsigned int initial_lcn)
 {
-	struct super_block *sb = m->inode->i_sb;
-	struct erofs_inode *const vi = EROFS_I(m->inode);
-	struct erofs_map_blocks *const map = m->map;
-	const unsigned int lclusterbits = vi->z_logical_clusterbits;
-	unsigned long lcn;
+	struct inode *inode = m->inode;
+	struct super_block *sb = inode->i_sb;
+	struct erofs_inode *vi = EROFS_I(inode);
+	bool bigpcl1 = vi->z_advise & Z_EROFS_ADVISE_BIG_PCLUSTER_1;
+	bool bigpcl2 = vi->z_advise & Z_EROFS_ADVISE_BIG_PCLUSTER_2;
+	unsigned long lcn = m->lcn + 1;
 	int err;
 
-	DBG_BUGON(m->type != Z_EROFS_LCLUSTER_TYPE_PLAIN &&
-		  m->type != Z_EROFS_LCLUSTER_TYPE_HEAD1 &&
-		  m->type != Z_EROFS_LCLUSTER_TYPE_HEAD2);
+	DBG_BUGON(m->type == Z_EROFS_LCLUSTER_TYPE_NONHEAD);
 	DBG_BUGON(m->type != m->headtype);
 
-	if (m->headtype == Z_EROFS_LCLUSTER_TYPE_PLAIN ||
-	    ((m->headtype == Z_EROFS_LCLUSTER_TYPE_HEAD1) &&
-	     !(vi->z_advise & Z_EROFS_ADVISE_BIG_PCLUSTER_1)) ||
-	    ((m->headtype == Z_EROFS_LCLUSTER_TYPE_HEAD2) &&
-	     !(vi->z_advise & Z_EROFS_ADVISE_BIG_PCLUSTER_2))) {
-		map->m_plen = 1ULL << lclusterbits;
-		return 0;
-	}
-	lcn = m->lcn + 1;
+	if ((m->headtype == Z_EROFS_LCLUSTER_TYPE_HEAD1 && !bigpcl1) ||
+	    ((m->headtype == Z_EROFS_LCLUSTER_TYPE_PLAIN ||
+	      m->headtype == Z_EROFS_LCLUSTER_TYPE_HEAD2) && !bigpcl2) ||
+	    (lcn << vi->z_logical_clusterbits) >= inode->i_size)
+		m->compressedblks = 1;
+
 	if (m->compressedblks)
 		goto out;
 
@@ -339,9 +335,9 @@ static int z_erofs_get_extent_compressedlen(struct z_erofs_maprecorder *m,
 	case Z_EROFS_LCLUSTER_TYPE_HEAD2:
 		/*
 		 * if the 1st NONHEAD lcluster is actually PLAIN or HEAD type
-		 * rather than CBLKCNT, it's a 1 lcluster-sized pcluster.
+		 * rather than CBLKCNT, it's a 1 block-sized pcluster.
 		 */
-		m->compressedblks = 1 << (lclusterbits - sb->s_blocksize_bits);
+		m->compressedblks = 1;
 		break;
 	case Z_EROFS_LCLUSTER_TYPE_NONHEAD:
 		if (m->delta[0] != 1)
@@ -356,7 +352,7 @@ static int z_erofs_get_extent_compressedlen(struct z_erofs_maprecorder *m,
 		return -EFSCORRUPTED;
 	}
 out:
-	map->m_plen = erofs_pos(sb, m->compressedblks);
+	m->map->m_plen = erofs_pos(sb, m->compressedblks);
 	return 0;
 err_bonus_cblkcnt:
 	erofs_err(sb, "bogus CBLKCNT @ lcn %lu of nid %llu", lcn, vi->nid);
-- 
2.43.5

