Return-Path: <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>
X-Original-To: lists+linux-erofs@lfdr.de
Delivered-To: lists+linux-erofs@lfdr.de
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	by mail.lfdr.de (Postfix) with ESMTPS id 84E54A2E2C0
	for <lists+linux-erofs@lfdr.de>; Mon, 10 Feb 2025 04:29:35 +0100 (CET)
Received: from boromir.ozlabs.org (localhost [IPv6:::1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4YrqnT0mVMz3050
	for <lists+linux-erofs@lfdr.de>; Mon, 10 Feb 2025 14:29:33 +1100 (AEDT)
X-Original-To: linux-erofs@lists.ozlabs.org
Delivered-To: linux-erofs@lists.ozlabs.org
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip=115.124.30.133
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1739158171;
	cv=none; b=gkNQjYv/+NsMWvn7CXCL9gGwiPlG3LWqLHujwswfesUkiCukxUwNp5GHCVSgZKPpiI9nZ8n0NGLJmeN26i9p4HjqBcRqZ5NLD3OhsJOLG3EZdnEdt/mKmV2F5yWz310SU6KXrAjsvOrVEXoLhGI2C5tVvvIDhWj+Fh+hQA82v9FDcm9Z6t4IYlRuT1XjOSE339+D1HBnNR6Nh6T4PUxDyQQLGkVPGbioqRKwXgS4CRZKzUOuEbDpqCuHBygOyVIcGmgNKLzNkdY2iQfWumHZef3FfVXVJPjn9BESm/vapZ1GRj0EIZXETfJDZh8kqQOwJb9GlDj7QY+rYmV18n+8mA==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1739158171; c=relaxed/relaxed;
	bh=Qs9PUV3rYLxbnto2T61Zi+jRgEogtBhw2UcQ6K27XWw=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=JucqqZxdst2y5gnRiQRO5L+jS+Nwq2+iglBgx7slAu0mS9EYDRjtnHDrA4qml1R1ivTF1++1oquNhZR5ijJyoi9MyiOBEBvichOfRxI4aSpSjV8kHcp1ieLrUSjMTII2KeD6kGoNcycvrBKNHG9RLY6qWuUZPooStB0xTW5L/V1wiooTvxOO7AkXy55/LnMwhWPPZVE0175MNnZDTIVsKxVqbPplxb5bNc6LBySzu4dQBnY6IaIWUFqDloAfT1pFjR4XxM0MX7RVxqcE3IlRTv63JYXCerWG8fDkEqKTCfKpDD6JehYPBxKjIdag6rlSWCVyoWQ16oUzreHgPPo6vw==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com; dkim=pass (1024-bit key; unprotected) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.a=rsa-sha256 header.s=default header.b=KMZzOjvI; dkim-atps=neutral; spf=pass (client-ip=115.124.30.133; helo=out30-133.freemail.mail.aliyun.com; envelope-from=hongzhen@linux.alibaba.com; receiver=lists.ozlabs.org) smtp.mailfrom=linux.alibaba.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (1024-bit key; unprotected) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.a=rsa-sha256 header.s=default header.b=KMZzOjvI;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=linux.alibaba.com (client-ip=115.124.30.133; helo=out30-133.freemail.mail.aliyun.com; envelope-from=hongzhen@linux.alibaba.com; receiver=lists.ozlabs.org)
Received: from out30-133.freemail.mail.aliyun.com (out30-133.freemail.mail.aliyun.com [115.124.30.133])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4YrqnP4j5Gz2xgp
	for <linux-erofs@lists.ozlabs.org>; Mon, 10 Feb 2025 14:29:28 +1100 (AEDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=linux.alibaba.com; s=default;
	t=1739158165; h=From:To:Subject:Date:Message-ID:MIME-Version;
	bh=Qs9PUV3rYLxbnto2T61Zi+jRgEogtBhw2UcQ6K27XWw=;
	b=KMZzOjvI7QGmdlnyoY3BcMvTybuWibo5CtHC9M4ThfzbmWXfBqWl+6+wYOQXPGWW4SVGcNuVLFXIDh/Qj3jE5FEqFLVYS87++dbt9TzkF0zch6s0Y5k/kGqzNOOR1fHF6yJM7Z2ntHcVnTUIz4GCFei9oOBdNwWrFn+/jcZ9kBM=
Received: from localhost(mailfrom:hongzhen@linux.alibaba.com fp:SMTPD_---0WP4g7Xo_1739158164 cluster:ay36)
          by smtp.aliyun-inc.com;
          Mon, 10 Feb 2025 11:29:24 +0800
From: Hongzhen Luo <hongzhen@linux.alibaba.com>
To: linux-erofs@lists.ozlabs.org
Subject: [PATCH v5] erofs: use Z_EROFS_LCLUSTER_TYPE_MAX to simplify switches
Date: Mon, 10 Feb 2025 11:29:23 +0800
Message-ID: <20250210032923.3382136-1-hongzhen@linux.alibaba.com>
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
Cc: linux-kernel@vger.kernel.org
Errors-To: linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org
Sender: "Linux-erofs" <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>

There's no need to enumerate each type.  No logic changes.

Signed-off-by: Hongzhen Luo <hongzhen@linux.alibaba.com>
---
v5: Exit the loop and return EOPNOTSUPP when `!lookback_distance`.
v4: https://lore.kernel.org/linux-erofs/20250207094515.2589242-1-hongzhen@linux.alibaba.com/
v3: https://lore.kernel.org/all/20250207085056.2502010-1-hongzhen@linux.alibaba.com/
v2: https://lore.kernel.org/all/20250207080829.2405528-1-hongzhen@linux.alibaba.com/
v1: https://lore.kernel.org/all/20250207064135.2249529-1-hongzhen@linux.alibaba.com/
---
 fs/erofs/zmap.c | 63 +++++++++++++++++++------------------------------
 1 file changed, 24 insertions(+), 39 deletions(-)

diff --git a/fs/erofs/zmap.c b/fs/erofs/zmap.c
index 689437e99a5a..d278ebd60281 100644
--- a/fs/erofs/zmap.c
+++ b/fs/erofs/zmap.c
@@ -265,26 +265,22 @@ static int z_erofs_extent_lookback(struct z_erofs_maprecorder *m,
 		if (err)
 			return err;
 
-		switch (m->type) {
-		case Z_EROFS_LCLUSTER_TYPE_NONHEAD:
+		if (m->type >= Z_EROFS_LCLUSTER_TYPE_MAX) {
+			erofs_err(sb, "unknown type %u @ lcn %lu of nid %llu",
+				  m->type, lcn, vi->nid);
+			DBG_BUGON(1);
+			return -EOPNOTSUPP;
+		} else if (m->type == Z_EROFS_LCLUSTER_TYPE_NONHEAD) {
 			lookback_distance = m->delta[0];
 			if (!lookback_distance)
-				goto err_bogus;
+				break;
 			continue;
-		case Z_EROFS_LCLUSTER_TYPE_PLAIN:
-		case Z_EROFS_LCLUSTER_TYPE_HEAD1:
-		case Z_EROFS_LCLUSTER_TYPE_HEAD2:
+		} else {
 			m->headtype = m->type;
 			m->map->m_la = (lcn << lclusterbits) | m->clusterofs;
 			return 0;
-		default:
-			erofs_err(sb, "unknown type %u @ lcn %lu of nid %llu",
-				  m->type, lcn, vi->nid);
-			DBG_BUGON(1);
-			return -EOPNOTSUPP;
 		}
 	}
-err_bogus:
 	erofs_err(sb, "bogus lookback distance %u @ lcn %lu of nid %llu",
 		  lookback_distance, m->lcn, vi->nid);
 	DBG_BUGON(1);
@@ -329,35 +325,28 @@ static int z_erofs_get_extent_compressedlen(struct z_erofs_maprecorder *m,
 	DBG_BUGON(lcn == initial_lcn &&
 		  m->type == Z_EROFS_LCLUSTER_TYPE_NONHEAD);
 
-	switch (m->type) {
-	case Z_EROFS_LCLUSTER_TYPE_PLAIN:
-	case Z_EROFS_LCLUSTER_TYPE_HEAD1:
-	case Z_EROFS_LCLUSTER_TYPE_HEAD2:
+	if (m->type == Z_EROFS_LCLUSTER_TYPE_NONHEAD) {
+		if (m->delta[0] != 1) {
+			erofs_err(sb, "bogus CBLKCNT @ lcn %lu of nid %llu", lcn, vi->nid);
+			DBG_BUGON(1);
+			return -EFSCORRUPTED;
+		}
+		if (m->compressedblks)
+			goto out;
+	} else if (m->type < Z_EROFS_LCLUSTER_TYPE_MAX) {
 		/*
 		 * if the 1st NONHEAD lcluster is actually PLAIN or HEAD type
 		 * rather than CBLKCNT, it's a 1 block-sized pcluster.
 		 */
 		m->compressedblks = 1;
-		break;
-	case Z_EROFS_LCLUSTER_TYPE_NONHEAD:
-		if (m->delta[0] != 1)
-			goto err_bonus_cblkcnt;
-		if (m->compressedblks)
-			break;
-		fallthrough;
-	default:
-		erofs_err(sb, "cannot found CBLKCNT @ lcn %lu of nid %llu", lcn,
-			  vi->nid);
-		DBG_BUGON(1);
-		return -EFSCORRUPTED;
+		goto out;
 	}
+	erofs_err(sb, "cannot found CBLKCNT @ lcn %lu of nid %llu", lcn, vi->nid);
+	DBG_BUGON(1);
+	return -EFSCORRUPTED;
 out:
 	m->map->m_plen = erofs_pos(sb, m->compressedblks);
 	return 0;
-err_bonus_cblkcnt:
-	erofs_err(sb, "bogus CBLKCNT @ lcn %lu of nid %llu", lcn, vi->nid);
-	DBG_BUGON(1);
-	return -EFSCORRUPTED;
 }
 
 static int z_erofs_get_extent_decompressedlen(struct z_erofs_maprecorder *m)
@@ -386,9 +375,7 @@ static int z_erofs_get_extent_decompressedlen(struct z_erofs_maprecorder *m)
 				m->delta[1] = 1;
 				DBG_BUGON(1);
 			}
-		} else if (m->type == Z_EROFS_LCLUSTER_TYPE_PLAIN ||
-			   m->type == Z_EROFS_LCLUSTER_TYPE_HEAD1 ||
-			   m->type == Z_EROFS_LCLUSTER_TYPE_HEAD2) {
+		} else if (m->type < Z_EROFS_LCLUSTER_TYPE_MAX) {
 			if (lcn != headlcn)
 				break;	/* ends at the next HEAD lcluster */
 			m->delta[1] = 1;
@@ -452,8 +439,7 @@ static int z_erofs_do_map_blocks(struct inode *inode,
 		}
 		/* m.lcn should be >= 1 if endoff < m.clusterofs */
 		if (!m.lcn) {
-			erofs_err(inode->i_sb,
-				  "invalid logical cluster 0 at nid %llu",
+			erofs_err(inode->i_sb, "invalid logical cluster 0 at nid %llu",
 				  vi->nid);
 			err = -EFSCORRUPTED;
 			goto unmap_out;
@@ -469,8 +455,7 @@ static int z_erofs_do_map_blocks(struct inode *inode,
 			goto unmap_out;
 		break;
 	default:
-		erofs_err(inode->i_sb,
-			  "unknown type %u @ offset %llu of nid %llu",
+		erofs_err(inode->i_sb, "unknown type %u @ offset %llu of nid %llu",
 			  m.type, ofs, vi->nid);
 		err = -EOPNOTSUPP;
 		goto unmap_out;
-- 
2.43.5

