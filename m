Return-Path: <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>
X-Original-To: lists+linux-erofs@lfdr.de
Delivered-To: lists+linux-erofs@lfdr.de
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2404:9400:2:0:216:3eff:fee1:b9f1])
	by mail.lfdr.de (Postfix) with ESMTPS id 04854A2BFC4
	for <lists+linux-erofs@lfdr.de>; Fri,  7 Feb 2025 10:45:29 +0100 (CET)
Received: from boromir.ozlabs.org (localhost [IPv6:::1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4Yq8GZ3hNNz30VQ
	for <lists+linux-erofs@lfdr.de>; Fri,  7 Feb 2025 20:45:26 +1100 (AEDT)
X-Original-To: linux-erofs@lists.ozlabs.org
Delivered-To: linux-erofs@lists.ozlabs.org
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip=115.124.30.100
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1738921524;
	cv=none; b=oaTaSvkBzGkJAizyiDfFOTeuJG4b1yT4bryZKkD0zHzCPqYoyTUFcaPp7oExQ3x1tJQ8Rfj6Va4WmgST5CHAWKd3xSSc1ZA5vZBaNPO0o4epiZLnr12uZWLX/94VSp6cV+Vio2QCDe8Usb4eLwyWyb2Rk2aq1GMT3J7JxEOngN45W/PyoP2MwRmciOEoVQslg6N6bdOk3LDw6oXnXdmJrM4HzcrUpAQ3iCDpCibzSqlbAVFALt/SulfdVJ+cgW8nKp0TEeDOfU8DYsd29peYu1qiQTMIH3bS1Qzb1rfM8tBSuO+Wh6+NqxCGxxzi322wnB1KRo/oqKrJvuFQ+KYD6g==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1738921524; c=relaxed/relaxed;
	bh=aTHN72xtRcyr6BkEOOv9TbB/8fJMYWIMeTR8LpKalDM=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=R8bDrT1VNQRc6uN4pAk8UYqyYAChDBx1/K86OWdaCfl4VE9dLQR69578lCH+nNX+k+61rKlP0ET3ObdzGuCjPzTnrE0i32yJc/KHe6f8hvllgjYYjTJfrGactJ6TabW40xlRCXKk54WlX4pvAlth+gHmX36LqnkvkoIoKN2qkwceoCL5jIzk137Q9V/qbeWJxtiAGOhCy7j5Ob4zuL3L+PzH1R1/XGZt6x9y42c4bp2oZEiBZUr47SifpE4G2vkEzONFPLSARIugqR71Y4Pa2BhqW90UYZlaWJ300q+/uck9rF5l/A28BoH4xwsQQXFMfgCZiBmFOZ/l0qb+Z2gSnw==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com; dkim=pass (1024-bit key; unprotected) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.a=rsa-sha256 header.s=default header.b=gvVXP67f; dkim-atps=neutral; spf=pass (client-ip=115.124.30.100; helo=out30-100.freemail.mail.aliyun.com; envelope-from=hongzhen@linux.alibaba.com; receiver=lists.ozlabs.org) smtp.mailfrom=linux.alibaba.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (1024-bit key; unprotected) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.a=rsa-sha256 header.s=default header.b=gvVXP67f;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=linux.alibaba.com (client-ip=115.124.30.100; helo=out30-100.freemail.mail.aliyun.com; envelope-from=hongzhen@linux.alibaba.com; receiver=lists.ozlabs.org)
Received: from out30-100.freemail.mail.aliyun.com (out30-100.freemail.mail.aliyun.com [115.124.30.100])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4Yq8GW3rNGz30Pp
	for <linux-erofs@lists.ozlabs.org>; Fri,  7 Feb 2025 20:45:22 +1100 (AEDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=linux.alibaba.com; s=default;
	t=1738921518; h=From:To:Subject:Date:Message-ID:MIME-Version;
	bh=aTHN72xtRcyr6BkEOOv9TbB/8fJMYWIMeTR8LpKalDM=;
	b=gvVXP67fd1m2g363+9Le3McMW9W5h3nkTvEWB2p7Q109TvkuXHAU4WEJpjho4L4liMvkMy1xVv71VzcC1XX1bR+YThKe/txb/St/Qul1QoxeaRZc6tpbLlK5D34PagXkcd5Yn+m4hNFj/xYiujFk8EaLGZgiq0M4UOnc7ESrzLc=
Received: from localhost(mailfrom:hongzhen@linux.alibaba.com fp:SMTPD_---0WOz4p76_1738921517 cluster:ay36)
          by smtp.aliyun-inc.com;
          Fri, 07 Feb 2025 17:45:18 +0800
From: Hongzhen Luo <hongzhen@linux.alibaba.com>
To: linux-erofs@lists.ozlabs.org
Subject: [PATCH v4] erofs: use Z_EROFS_LCLUSTER_TYPE_MAX to simplify switches
Date: Fri,  7 Feb 2025 17:45:15 +0800
Message-ID: <20250207094515.2589242-1-hongzhen@linux.alibaba.com>
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
v4: Get rid of `goto err_bogus;`.
v3: https://lore.kernel.org/all/20250207085056.2502010-1-hongzhen@linux.alibaba.com/
v2: https://lore.kernel.org/all/20250207080829.2405528-1-hongzhen@linux.alibaba.com/
v1: https://lore.kernel.org/all/20250207064135.2249529-1-hongzhen@linux.alibaba.com/
---
 fs/erofs/zmap.c | 72 ++++++++++++++++++++-----------------------------
 1 file changed, 29 insertions(+), 43 deletions(-)

diff --git a/fs/erofs/zmap.c b/fs/erofs/zmap.c
index 689437e99a5a..5a2bc4905f45 100644
--- a/fs/erofs/zmap.c
+++ b/fs/erofs/zmap.c
@@ -265,29 +265,26 @@ static int z_erofs_extent_lookback(struct z_erofs_maprecorder *m,
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
-			if (!lookback_distance)
-				goto err_bogus;
+			if (!lookback_distance) {
+				erofs_err(sb, "bogus lookback distance %u @ lcn %lu of nid %llu",
+					  lookback_distance, m->lcn, vi->nid);
+				DBG_BUGON(1);
+				return -EFSCORRUPTED;
+			}
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
-	erofs_err(sb, "bogus lookback distance %u @ lcn %lu of nid %llu",
-		  lookback_distance, m->lcn, vi->nid);
-	DBG_BUGON(1);
 	return -EFSCORRUPTED;
 }
 
@@ -329,35 +326,28 @@ static int z_erofs_get_extent_compressedlen(struct z_erofs_maprecorder *m,
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
@@ -386,9 +376,7 @@ static int z_erofs_get_extent_decompressedlen(struct z_erofs_maprecorder *m)
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
@@ -452,8 +440,7 @@ static int z_erofs_do_map_blocks(struct inode *inode,
 		}
 		/* m.lcn should be >= 1 if endoff < m.clusterofs */
 		if (!m.lcn) {
-			erofs_err(inode->i_sb,
-				  "invalid logical cluster 0 at nid %llu",
+			erofs_err(inode->i_sb, "invalid logical cluster 0 at nid %llu",
 				  vi->nid);
 			err = -EFSCORRUPTED;
 			goto unmap_out;
@@ -469,8 +456,7 @@ static int z_erofs_do_map_blocks(struct inode *inode,
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

