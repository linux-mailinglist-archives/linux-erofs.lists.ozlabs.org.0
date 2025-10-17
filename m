Return-Path: <linux-erofs+bounces-1196-lists+linux-erofs=lfdr.de@lists.ozlabs.org>
X-Original-To: lists+linux-erofs@lfdr.de
Delivered-To: lists+linux-erofs@lfdr.de
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2404:9400:2:0:216:3eff:fee1:b9f1])
	by mail.lfdr.de (Postfix) with ESMTPS id 5DA60BE6DFE
	for <lists+linux-erofs@lfdr.de>; Fri, 17 Oct 2025 09:05:58 +0200 (CEST)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4cnwpC6CZtz2yMh;
	Fri, 17 Oct 2025 18:05:55 +1100 (AEDT)
X-Original-To: linux-erofs@lists.ozlabs.org
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip=115.124.30.133
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1760684755;
	cv=none; b=DapdVsav+oVplhuFk2VWjk6xzgR1tL1hoqxZviaUbfCLlFWanQmJJ6AO50v33RVvYzF2Y4Co6FPaRAJfAxNI5yJoWsJBPeRmbIIyXnodDNgkxnch/p2NJ1JsaM1CXTx2xbe1j8O5+cPhubudH/ay+ENbrMSORUlocCeoZCCDR9JX32RpOcWKOSI1CtBrOj3BU5+l3pEyXrtDPcLU8f4Cj1sILwUaQ/Kn850sRzH4SwU8/6kd5ulHhYx4QxQokxmO/P/KDctfmB8MzwMoV6TfvG+Xx+rxPqmxqll2UAteOhMw6GqT/uXbGT8eceWtayctSyXr+FhI+FHo9yRYjbRU3g==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1760684755; c=relaxed/relaxed;
	bh=HQ7W+r503Iw+EOno8tbHH25ahpTKxYi2lcfSqIDRr1E=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=S68NkrhkINkfveW586s6VZaOU3PMZo+dpsOPuU1vKr17OJo+FsW70IFTKtoNA8QWrytAKR/q7MhMtp2jDyb8LDeyA/rJpY6ZySIlZq6V+3nssTWUiWhiXGf67NUUvK7dw3PEXBsohq85vVQ32VwGEFRczHQpN7tOYpTnFfDzJvdoC9rYkNHxavjIZriktzCzBVhGqnBSEv4gYac0ngzhyZJ3N1REZADo+W5zfG4xMRe9Crl/23zIv3B7njgf5DPhVYAYVm3psnHLX0zVSfUJghwfgJyZoavHAGow9FfyxUP22li50Omog0ummLCh6lvtrFOhpfQuivun90tNmT9atw==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com; dkim=pass (1024-bit key; unprotected) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.a=rsa-sha256 header.s=default header.b=Zbfqvzp0; dkim-atps=neutral; spf=pass (client-ip=115.124.30.133; helo=out30-133.freemail.mail.aliyun.com; envelope-from=hsiangkao@linux.alibaba.com; receiver=lists.ozlabs.org) smtp.mailfrom=linux.alibaba.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (1024-bit key; unprotected) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.a=rsa-sha256 header.s=default header.b=Zbfqvzp0;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=linux.alibaba.com (client-ip=115.124.30.133; helo=out30-133.freemail.mail.aliyun.com; envelope-from=hsiangkao@linux.alibaba.com; receiver=lists.ozlabs.org)
Received: from out30-133.freemail.mail.aliyun.com (out30-133.freemail.mail.aliyun.com [115.124.30.133])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4cnwp94Bmpz2xQ2
	for <linux-erofs@lists.ozlabs.org>; Fri, 17 Oct 2025 18:05:52 +1100 (AEDT)
DKIM-Signature:v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=linux.alibaba.com; s=default;
	t=1760684747; h=From:To:Subject:Date:Message-ID:MIME-Version;
	bh=HQ7W+r503Iw+EOno8tbHH25ahpTKxYi2lcfSqIDRr1E=;
	b=Zbfqvzp0QV/0iAbcsPqftKvJjF3g2F8j82CYu8OSgRt9KjQLiD5c7KBrbXQC75LE+ZO61jjQQf4p5R6LXaeL7LOquY8E0GdsLTwzJMefsYXfk1Ap4r/FBl9Dilc+m0FjeMwiXEbItb4m/CUps5CptSWeJs4k8Tzfx5XlLe//miE=
Received: from x31i01179.sqa.na131.tbsite.net(mailfrom:hsiangkao@linux.alibaba.com fp:SMTPD_---0WqOynSt_1760684740 cluster:ay36)
          by smtp.aliyun-inc.com;
          Fri, 17 Oct 2025 15:05:45 +0800
From: Gao Xiang <hsiangkao@linux.alibaba.com>
To: linux-erofs@lists.ozlabs.org
Cc: LKML <linux-kernel@vger.kernel.org>,
	Gao Xiang <hsiangkao@linux.alibaba.com>,
	Robert Morris <rtm@csail.mit.edu>
Subject: [PATCH 1/2] erofs: avoid infinite loops due to corrupted subpage compact indexes
Date: Fri, 17 Oct 2025 15:05:38 +0800
Message-ID: <20251017070539.901367-1-hsiangkao@linux.alibaba.com>
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

Robert reported an infinite loop observed by two crafted images.

The root cause is that `clusterofs` can be larger than `lclustersize`
for !NONHEAD `lclusters` in corrupted subpage compact indexes, e.g.:

  blocksize = lclustersize = 512   lcn = 6   clusterofs = 515

Move the corresponding check for full compress indexes to
`z_erofs_load_lcluster_from_disk()` to also cover subpage compact
compress indexes.

It also fixes the position of `m->type >= Z_EROFS_LCLUSTER_TYPE_MAX`
check, since it should be placed right after
`z_erofs_load_{compact,full}_lcluster()`.

Fixes: 8d2517aaeea3 ("erofs: fix up compacted indexes for block size < 4096")
Fixes: 1a5223c182fd ("erofs: do sanity check on m->type in z_erofs_load_compact_lcluster()")
Reported-by: Robert Morris <rtm@csail.mit.edu>
Closes: https://lore.kernel.org/r/35167.1760645886@localhost
Signed-off-by: Gao Xiang <hsiangkao@linux.alibaba.com>
---
 fs/erofs/zmap.c | 32 ++++++++++++++++++--------------
 1 file changed, 18 insertions(+), 14 deletions(-)

diff --git a/fs/erofs/zmap.c b/fs/erofs/zmap.c
index e5581dbeb4c2..6aca228cd2a5 100644
--- a/fs/erofs/zmap.c
+++ b/fs/erofs/zmap.c
@@ -55,10 +55,6 @@ static int z_erofs_load_full_lcluster(struct z_erofs_maprecorder *m,
 	} else {
 		m->partialref = !!(advise & Z_EROFS_LI_PARTIAL_REF);
 		m->clusterofs = le16_to_cpu(di->di_clusterofs);
-		if (m->clusterofs >= 1 << vi->z_lclusterbits) {
-			DBG_BUGON(1);
-			return -EFSCORRUPTED;
-		}
 		m->pblk = le32_to_cpu(di->di_u.blkaddr);
 	}
 	return 0;
@@ -240,21 +236,29 @@ static int z_erofs_load_compact_lcluster(struct z_erofs_maprecorder *m,
 static int z_erofs_load_lcluster_from_disk(struct z_erofs_maprecorder *m,
 					   unsigned int lcn, bool lookahead)
 {
+	struct erofs_inode *vi = EROFS_I(m->inode);
+	int err;
+
+	if (vi->datalayout == EROFS_INODE_COMPRESSED_COMPACT) {
+		err = z_erofs_load_compact_lcluster(m, lcn, lookahead);
+	} else {
+		DBG_BUGON(vi->datalayout != EROFS_INODE_COMPRESSED_FULL);
+		err = z_erofs_load_full_lcluster(m, lcn);
+	}
+	if (err)
+		return err;
+
 	if (m->type >= Z_EROFS_LCLUSTER_TYPE_MAX) {
 		erofs_err(m->inode->i_sb, "unknown type %u @ lcn %u of nid %llu",
-				m->type, lcn, EROFS_I(m->inode)->nid);
+			  m->type, lcn, EROFS_I(m->inode)->nid);
 		DBG_BUGON(1);
 		return -EOPNOTSUPP;
+	} else if (m->type != Z_EROFS_LCLUSTER_TYPE_NONHEAD &&
+		   m->clusterofs >= (1 << vi->z_lclusterbits)) {
+		DBG_BUGON(1);
+		return -EFSCORRUPTED;
 	}
-
-	switch (EROFS_I(m->inode)->datalayout) {
-	case EROFS_INODE_COMPRESSED_FULL:
-		return z_erofs_load_full_lcluster(m, lcn);
-	case EROFS_INODE_COMPRESSED_COMPACT:
-		return z_erofs_load_compact_lcluster(m, lcn, lookahead);
-	default:
-		return -EINVAL;
-	}
+	return 0;
 }
 
 static int z_erofs_extent_lookback(struct z_erofs_maprecorder *m,
-- 
2.43.5


