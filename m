Return-Path: <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>
X-Original-To: lists+linux-erofs@lfdr.de
Delivered-To: lists+linux-erofs@lfdr.de
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2404:9400:2:0:216:3eff:fee1:b9f1])
	by mail.lfdr.de (Postfix) with ESMTPS id 80F60A2A8D3
	for <lists+linux-erofs@lfdr.de>; Thu,  6 Feb 2025 13:51:09 +0100 (CET)
Received: from boromir.ozlabs.org (localhost [IPv6:::1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4YpcR71hRjz3cp1
	for <lists+linux-erofs@lfdr.de>; Thu,  6 Feb 2025 23:50:59 +1100 (AEDT)
X-Original-To: linux-erofs@lists.ozlabs.org
Delivered-To: linux-erofs@lists.ozlabs.org
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip=115.124.30.99
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1738846255;
	cv=none; b=KKrYgHVF9/ehrzYfNL60OELEr8+XYtDSgc5avcqUhQXQYwaEkj7YLOCv+UPXo+2ALdjpRjiRvbm0Wn+5oNnb/vvI24YkJw3+L8mE3SfKapwwRUCey3JpOH5iGhbp4THgOD3i3mb8kah7oAvki0CUfNAb/Py086XvIGyZNLDMetRk8n9g35fM+6o+zBCIArxznJdSH/gYTCTGjlz1hzKilQ2C3mYY17actI71JYswYl8hCnpWwYZJX6I7/zxM5BuBiC0cURXa0eFCKkFuWfGPYBFhjuJBThygV5uUlpdiMzmvkvEQHkq57MXIoGud8JTRzaoKvyol9RqAUuWRAER6Zw==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1738846255; c=relaxed/relaxed;
	bh=M+e9oVc/L9fE0eOiNJm65p0H8wHZ7HKQpCZeJG2vr8o=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=dQ2UJoxJcaDVFXm8UkkZkwRlWRsDhBgk/afn2mwJGag61PZJmO8mr7YdCs6gl9hx7cl99qY0ETjVmuhtN+2lGS+IDidrHWTXrY9aQQD2CQDQFaXSrYDS/pjbjkFSeYwtrKqQn1yD4sAOKym+jTZEigwocZpJQKf3RamXrT6RxPQFEq/BDASMhFYBt9HVrklnCB5e9SsedINEFej4DRrIClz7Tperbqdpwe6fDIHHtAh7pEfph5o5GT0oLHpPt9Q3MOinr9PeEjooNc77QJx/ta3E2qYuJxLwru68uMkBnhyPg1BVTLoXbzsm44aN/56yJ5bXxF8vI8bWSn7N91KcjA==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com; dkim=pass (1024-bit key; unprotected) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.a=rsa-sha256 header.s=default header.b=KOHM5OEa; dkim-atps=neutral; spf=pass (client-ip=115.124.30.99; helo=out30-99.freemail.mail.aliyun.com; envelope-from=hsiangkao@linux.alibaba.com; receiver=lists.ozlabs.org) smtp.mailfrom=linux.alibaba.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (1024-bit key; unprotected) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.a=rsa-sha256 header.s=default header.b=KOHM5OEa;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=linux.alibaba.com (client-ip=115.124.30.99; helo=out30-99.freemail.mail.aliyun.com; envelope-from=hsiangkao@linux.alibaba.com; receiver=lists.ozlabs.org)
Received: from out30-99.freemail.mail.aliyun.com (out30-99.freemail.mail.aliyun.com [115.124.30.99])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4YpcR24B9wz30Vm
	for <linux-erofs@lists.ozlabs.org>; Thu,  6 Feb 2025 23:50:54 +1100 (AEDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=linux.alibaba.com; s=default;
	t=1738846251; h=From:To:Subject:Date:Message-ID:MIME-Version;
	bh=M+e9oVc/L9fE0eOiNJm65p0H8wHZ7HKQpCZeJG2vr8o=;
	b=KOHM5OEai6sxozPdaLo88gpdH+V3HZzAG7lYJ5+DgOZdmYXc5i+JuIAUPHSif6/QCd7TgwDuEBG4hKH2fhUY24mP6U7jFHKJmjk6Rf9JSPkGD3xovHyXPq7g8ZmnWz7b9s06WpkafxJoxV/eFgriB0ERowk07QFuqQ3JiRSlGqA=
Received: from x31i01179.sqa.na131.tbsite.net(mailfrom:hsiangkao@linux.alibaba.com fp:SMTPD_---0WOwMl7J_1738846249 cluster:ay36)
          by smtp.aliyun-inc.com;
          Thu, 06 Feb 2025 20:50:49 +0800
From: Gao Xiang <hsiangkao@linux.alibaba.com>
To: linux-erofs@lists.ozlabs.org
Subject: [PATCH 8/9] erofs-utils: lib: refine z_erofs_get_extent_compressedlen()
Date: Thu,  6 Feb 2025 20:50:33 +0800
Message-ID: <20250206125034.1462966-8-hsiangkao@linux.alibaba.com>
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

Source kernel commit: 8f9530aeeb4f756bdfa70510b40e5d28ea3c742e
Signed-off-by: Gao Xiang <hsiangkao@linux.alibaba.com>
---
 lib/zmap.c | 30 ++++++++++++------------------
 1 file changed, 12 insertions(+), 18 deletions(-)

diff --git a/lib/zmap.c b/lib/zmap.c
index b2aa483..24bdff7 100644
--- a/lib/zmap.c
+++ b/lib/zmap.c
@@ -320,26 +320,20 @@ static int z_erofs_get_extent_compressedlen(struct z_erofs_maprecorder *m,
 {
 	struct erofs_inode *const vi = m->inode;
 	struct erofs_sb_info *sbi = vi->sbi;
-	struct erofs_map_blocks *const map = m->map;
-	const unsigned int lclusterbits = vi->z_logical_clusterbits;
-	unsigned long lcn;
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
-		map->m_plen = 1 << lclusterbits;
-		return 0;
-	}
+	if ((m->headtype == Z_EROFS_LCLUSTER_TYPE_HEAD1 && !bigpcl1) ||
+	    ((m->headtype == Z_EROFS_LCLUSTER_TYPE_PLAIN ||
+	      m->headtype == Z_EROFS_LCLUSTER_TYPE_HEAD2) && !bigpcl2) ||
+	    (lcn << vi->z_logical_clusterbits) >= vi->i_size)
+		m->compressedblks = 1;
 
-	lcn = m->lcn + 1;
 	if (m->compressedblks)
 		goto out;
 
@@ -364,9 +358,9 @@ static int z_erofs_get_extent_compressedlen(struct z_erofs_maprecorder *m,
 	case Z_EROFS_LCLUSTER_TYPE_HEAD2:
 		/*
 		 * if the 1st NONHEAD lcluster is actually PLAIN or HEAD type
-		 * rather than CBLKCNT, it's a 1 lcluster-sized pcluster.
+		 * rather than CBLKCNT, it's a 1 block-sized pcluster.
 		 */
-		m->compressedblks = 1 << (lclusterbits - sbi->blkszbits);
+		m->compressedblks = 1;
 		break;
 	case Z_EROFS_LCLUSTER_TYPE_NONHEAD:
 		if (m->delta[0] != 1)
@@ -381,7 +375,7 @@ static int z_erofs_get_extent_compressedlen(struct z_erofs_maprecorder *m,
 		return -EFSCORRUPTED;
 	}
 out:
-	map->m_plen = m->compressedblks << sbi->blkszbits;
+	m->map->m_plen = erofs_pos(sbi, m->compressedblks);
 	return 0;
 err_bonus_cblkcnt:
 	erofs_err("bogus CBLKCNT @ lcn %lu of nid %llu",
-- 
2.43.5

