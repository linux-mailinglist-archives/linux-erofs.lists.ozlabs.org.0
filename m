Return-Path: <linux-erofs+bounces-170-lists+linux-erofs=lfdr.de@lists.ozlabs.org>
X-Original-To: lists+linux-erofs@lfdr.de
Delivered-To: lists+linux-erofs@lfdr.de
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2404:9400:2:0:216:3eff:fee1:b9f1])
	by mail.lfdr.de (Postfix) with ESMTPS id 92EAAA82C73
	for <lists+linux-erofs@lfdr.de>; Wed,  9 Apr 2025 18:33:21 +0200 (CEST)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4ZXpQz1xs6z30Kg;
	Thu, 10 Apr 2025 02:33:15 +1000 (AEST)
X-Original-To: linux-erofs@lists.ozlabs.org
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip=115.124.30.132
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1744216395;
	cv=none; b=HFdj7XUtyGuYOBaBfdpr0pdY5zdgj8GBCdh6ucW+mlOd57dCJtdsCAelPgt3ZZv7bfw4CsEH8fs1DgBUDfDc4uSNREQmFT8YpCJ1wNphru7jTKynoDC7VYJJcCscCa8/IbzNbBGqUeTiiQZuWptFIwxi16NsPe9D9K/WoDDie5WsIzAUYVFmyCOfkmqGaMCKw+Y7W4tIUHKv0pH9CwnsXL+uZRbpsUCn5d16EpIwSdhM2r2P5ElQlw3/OU4NWvT956KPwNZUOCWOxGsR1+qvaNjxWF3yI/Zbbkv+1+kcmsuhXBGTFMGZgSiS7XExm1Zvz88h4R+ShUbr4hnv1Z9TXw==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1744216395; c=relaxed/relaxed;
	bh=otgbvuFqUXOAeD1kAAT+KV2OC6allCpXUP62KB7tiMc=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=bJ8X5jBaYYN8QxdRr2jYJpBp23eMOSJSPWMAKC8Wb/1AQtdfd1zTojoU8iYQ6qE1DoPlxjIjPkgP/2pMMQAmufg4GqzVLRBZKya2bxuJlERi+C5FhEfqhECKDP+i5lxBebBJE6Ye2jA5Pi8MiaJZp+wRuMElpRHV2TFtjZlOdcLnYoalHfqLh1cqWHGsDZOOJKe2+9mnocqRxdXP8htn0g98CGAxeK1dMvEWmkttaWC45cMcmnfoSptfK2s9DCnWPOq3Sf4K4SAnEHi9BTymoPQrf2Yj7E+lx3ElV9blrZ/CzrD2fvyGAGM+uncFTJqhr+WxL7rq1eHH4Gdk2K8sEw==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com; dkim=pass (1024-bit key; unprotected) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.a=rsa-sha256 header.s=default header.b=WK4Af++Y; dkim-atps=neutral; spf=pass (client-ip=115.124.30.132; helo=out30-132.freemail.mail.aliyun.com; envelope-from=hsiangkao@linux.alibaba.com; receiver=lists.ozlabs.org) smtp.mailfrom=linux.alibaba.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (1024-bit key; unprotected) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.a=rsa-sha256 header.s=default header.b=WK4Af++Y;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=linux.alibaba.com (client-ip=115.124.30.132; helo=out30-132.freemail.mail.aliyun.com; envelope-from=hsiangkao@linux.alibaba.com; receiver=lists.ozlabs.org)
Received: from out30-132.freemail.mail.aliyun.com (out30-132.freemail.mail.aliyun.com [115.124.30.132])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4ZXpQw6Lq2z30VV
	for <linux-erofs@lists.ozlabs.org>; Thu, 10 Apr 2025 02:33:11 +1000 (AEST)
DKIM-Signature:v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=linux.alibaba.com; s=default;
	t=1744216386; h=From:To:Subject:Date:Message-ID:MIME-Version;
	bh=otgbvuFqUXOAeD1kAAT+KV2OC6allCpXUP62KB7tiMc=;
	b=WK4Af++YmbRrCzBgwX+vb79UYX7r40CDNLjbEReRTlkaAJA8lCE13AS4NUaawPdxkcCTtDnwxTSoF+DlIonoEKXg0boI8mOdYa428vdMmqFcCZqF+CQi3C9G80ErEop634H35RKHE+cztM9kv5dEB/muyihBWkHT9xHYsmJ4BLA=
Received: from x31i01179.sqa.na131.tbsite.net(mailfrom:hsiangkao@linux.alibaba.com fp:SMTPD_---0WWKsZPg_1744216380 cluster:ay36)
          by smtp.aliyun-inc.com;
          Thu, 10 Apr 2025 00:33:05 +0800
From: Gao Xiang <hsiangkao@linux.alibaba.com>
To: linux-erofs@lists.ozlabs.org
Cc: Gao Xiang <hsiangkao@linux.alibaba.com>
Subject: [PATCH v2 01/10] erofs-utils: lib: use Z_EROFS_LCLUSTER_TYPE_MAX to simplify switches
Date: Thu, 10 Apr 2025 00:32:50 +0800
Message-ID: <20250409163259.2077865-1-hsiangkao@linux.alibaba.com>
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
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-15.7 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,DKIM_VALID_EF,ENV_AND_HDR_SPF_MATCH,RCVD_IN_DNSWL_NONE,
	SPF_HELO_NONE,SPF_PASS,UNPARSEABLE_RELAY,USER_IN_DEF_DKIM_WL,
	USER_IN_DEF_SPF_WL autolearn=disabled version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-25) on lists.ozlabs.org

Source kernel commit: 3b7781aeaefb627d4e07c1af9be923f9e8047d8b

Signed-off-by: Gao Xiang <hsiangkao@linux.alibaba.com>
---
 lib/zmap.c | 60 ++++++++++++++++++++++--------------------------------
 1 file changed, 24 insertions(+), 36 deletions(-)

diff --git a/lib/zmap.c b/lib/zmap.c
index 2a9baba..30bb7e3 100644
--- a/lib/zmap.c
+++ b/lib/zmap.c
@@ -282,26 +282,22 @@ static int z_erofs_extent_lookback(struct z_erofs_maprecorder *m,
 		if (err)
 			return err;
 
-		switch (m->type) {
-		case Z_EROFS_LCLUSTER_TYPE_NONHEAD:
+		if (m->type >= Z_EROFS_LCLUSTER_TYPE_MAX) {
+			erofs_err("unknown type %u @ lcn %lu of nid %llu",
+				  m->type, lcn, vi->nid | 0ULL);
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
-			erofs_err("unknown type %u @ lcn %lu of nid %llu",
-				  m->type, lcn, vi->nid | 0ULL);
-			DBG_BUGON(1);
-			return -EOPNOTSUPP;
 		}
 	}
-err_bogus:
 	erofs_err("bogus lookback distance %u @ lcn %lu of nid %llu",
 		  lookback_distance, m->lcn | 0ULL, vi->nid);
 	DBG_BUGON(1);
@@ -345,36 +341,30 @@ static int z_erofs_get_extent_compressedlen(struct z_erofs_maprecorder *m,
 	DBG_BUGON(lcn == initial_lcn &&
 		  m->type == Z_EROFS_LCLUSTER_TYPE_NONHEAD);
 
-	switch (m->type) {
-	case Z_EROFS_LCLUSTER_TYPE_PLAIN:
-	case Z_EROFS_LCLUSTER_TYPE_HEAD1:
-	case Z_EROFS_LCLUSTER_TYPE_HEAD2:
+	if (m->type == Z_EROFS_LCLUSTER_TYPE_NONHEAD) {
+		if (m->delta[0] != 1) {
+			erofs_err("bogus CBLKCNT @ lcn %lu of nid %llu",
+				  lcn, vi->nid | 0ULL);
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
-		/* fallthrough */
-	default:
-		erofs_err("cannot found CBLKCNT @ lcn %lu of nid %llu",
-			  lcn, vi->nid | 0ULL);
-		DBG_BUGON(1);
-		return -EFSCORRUPTED;
+		goto out;
 	}
-out:
-	m->map->m_plen = erofs_pos(sbi, m->compressedblks);
-	return 0;
-err_bonus_cblkcnt:
-	erofs_err("bogus CBLKCNT @ lcn %lu of nid %llu",
+	erofs_err("cannot found CBLKCNT @ lcn %lu of nid %llu",
 		  lcn, vi->nid | 0ULL);
 	DBG_BUGON(1);
 	return -EFSCORRUPTED;
+out:
+	m->map->m_plen = erofs_pos(sbi, m->compressedblks);
+	return 0;
 }
 
 static int z_erofs_get_extent_decompressedlen(struct z_erofs_maprecorder *m)
@@ -402,9 +392,7 @@ static int z_erofs_get_extent_decompressedlen(struct z_erofs_maprecorder *m)
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
-- 
2.43.5


