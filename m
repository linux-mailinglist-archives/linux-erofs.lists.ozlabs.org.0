Return-Path: <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>
X-Original-To: lists+linux-erofs@lfdr.de
Delivered-To: lists+linux-erofs@lfdr.de
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	by mail.lfdr.de (Postfix) with ESMTPS id CC2824D513F
	for <lists+linux-erofs@lfdr.de>; Thu, 10 Mar 2022 19:28:10 +0100 (CET)
Received: from boromir.ozlabs.org (localhost [IPv6:::1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4KDyHD4zvVz309k
	for <lists+linux-erofs@lfdr.de>; Fri, 11 Mar 2022 05:28:08 +1100 (AEDT)
X-Original-To: linux-erofs@lists.ozlabs.org
Delivered-To: linux-erofs@lists.ozlabs.org
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized)
 smtp.mailfrom=linux.alibaba.com (client-ip=115.124.30.56;
 helo=out30-56.freemail.mail.aliyun.com;
 envelope-from=hsiangkao@linux.alibaba.com; receiver=<UNKNOWN>)
Received: from out30-56.freemail.mail.aliyun.com
 (out30-56.freemail.mail.aliyun.com [115.124.30.56])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 4KDyH44mNLz2yLX
 for <linux-erofs@lists.ozlabs.org>; Fri, 11 Mar 2022 05:27:58 +1100 (AEDT)
X-Alimail-AntiSpam: AC=PASS; BC=-1|-1; BR=01201311R201e4; CH=green; DM=||false|;
 DS=||; FP=0|-1|-1|-1|0|-1|-1|-1; HT=e01e04394; MF=hsiangkao@linux.alibaba.com;
 NM=1; PH=DS; RN=4; SR=0; TI=SMTPD_---0V6pgl69_1646936864; 
Received: from
 e18g06460.et15sqa.tbsite.net(mailfrom:hsiangkao@linux.alibaba.com
 fp:SMTPD_---0V6pgl69_1646936864) by smtp.aliyun-inc.com(127.0.0.1);
 Fri, 11 Mar 2022 02:27:50 +0800
From: Gao Xiang <hsiangkao@linux.alibaba.com>
To: linux-erofs@lists.ozlabs.org,
	Chao Yu <chao@kernel.org>
Subject: [PATCH 1/2] erofs: clean up z_erofs_extent_lookback
Date: Fri, 11 Mar 2022 02:27:42 +0800
Message-Id: <20220310182743.102365-1-hsiangkao@linux.alibaba.com>
X-Mailer: git-send-email 2.24.4
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
Cc: Gao Xiang <hsiangkao@linux.alibaba.com>,
 LKML <linux-kernel@vger.kernel.org>
Errors-To: linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org
Sender: "Linux-erofs"
 <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>

Avoid the unnecessary tail recursion since it can be converted into
a loop directly in order to prevent potential stack overflow.

It's a pretty straightforward conversion.

Signed-off-by: Gao Xiang <hsiangkao@linux.alibaba.com>
---
 fs/erofs/zmap.c | 67 ++++++++++++++++++++++++-------------------------
 1 file changed, 33 insertions(+), 34 deletions(-)

diff --git a/fs/erofs/zmap.c b/fs/erofs/zmap.c
index b4059b9c3bac..572f0b8151ba 100644
--- a/fs/erofs/zmap.c
+++ b/fs/erofs/zmap.c
@@ -431,48 +431,47 @@ static int z_erofs_extent_lookback(struct z_erofs_maprecorder *m,
 				   unsigned int lookback_distance)
 {
 	struct erofs_inode *const vi = EROFS_I(m->inode);
-	struct erofs_map_blocks *const map = m->map;
 	const unsigned int lclusterbits = vi->z_logical_clusterbits;
-	unsigned long lcn = m->lcn;
-	int err;
 
-	if (lcn < lookback_distance) {
-		erofs_err(m->inode->i_sb,
-			  "bogus lookback distance @ nid %llu", vi->nid);
-		DBG_BUGON(1);
-		return -EFSCORRUPTED;
-	}
+	while (m->lcn >= lookback_distance) {
+		unsigned long lcn = m->lcn - lookback_distance;
+		int err;
 
-	/* load extent head logical cluster if needed */
-	lcn -= lookback_distance;
-	err = z_erofs_load_cluster_from_disk(m, lcn, false);
-	if (err)
-		return err;
+		/* load extent head logical cluster if needed */
+		err = z_erofs_load_cluster_from_disk(m, lcn, false);
+		if (err)
+			return err;
 
-	switch (m->type) {
-	case Z_EROFS_VLE_CLUSTER_TYPE_NONHEAD:
-		if (!m->delta[0]) {
+		switch (m->type) {
+		case Z_EROFS_VLE_CLUSTER_TYPE_NONHEAD:
+			if (!m->delta[0]) {
+				erofs_err(m->inode->i_sb,
+					  "invalid lookback distance 0 @ nid %llu",
+					  vi->nid);
+				DBG_BUGON(1);
+				return -EFSCORRUPTED;
+			}
+			lookback_distance = m->delta[0];
+			continue;
+		case Z_EROFS_VLE_CLUSTER_TYPE_PLAIN:
+		case Z_EROFS_VLE_CLUSTER_TYPE_HEAD1:
+		case Z_EROFS_VLE_CLUSTER_TYPE_HEAD2:
+			m->headtype = m->type;
+			m->map->m_la = (lcn << lclusterbits) | m->clusterofs;
+			return 0;
+		default:
 			erofs_err(m->inode->i_sb,
-				  "invalid lookback distance 0 @ nid %llu",
-				  vi->nid);
+				  "unknown type %u @ lcn %lu of nid %llu",
+				  m->type, lcn, vi->nid);
 			DBG_BUGON(1);
-			return -EFSCORRUPTED;
+			return -EOPNOTSUPP;
 		}
-		return z_erofs_extent_lookback(m, m->delta[0]);
-	case Z_EROFS_VLE_CLUSTER_TYPE_PLAIN:
-	case Z_EROFS_VLE_CLUSTER_TYPE_HEAD1:
-	case Z_EROFS_VLE_CLUSTER_TYPE_HEAD2:
-		m->headtype = m->type;
-		map->m_la = (lcn << lclusterbits) | m->clusterofs;
-		break;
-	default:
-		erofs_err(m->inode->i_sb,
-			  "unknown type %u @ lcn %lu of nid %llu",
-			  m->type, lcn, vi->nid);
-		DBG_BUGON(1);
-		return -EOPNOTSUPP;
 	}
-	return 0;
+
+	erofs_err(m->inode->i_sb, "bogus lookback distance @ nid %llu",
+		  vi->nid);
+	DBG_BUGON(1);
+	return -EFSCORRUPTED;
 }
 
 static int z_erofs_get_extent_compressedlen(struct z_erofs_maprecorder *m,
-- 
2.24.4

