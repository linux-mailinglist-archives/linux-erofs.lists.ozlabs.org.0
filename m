Return-Path: <linux-erofs+bounces-511-lists+linux-erofs=lfdr.de@lists.ozlabs.org>
X-Original-To: lists+linux-erofs@lfdr.de
Delivered-To: lists+linux-erofs@lfdr.de
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2404:9400:2:0:216:3eff:fee1:b9f1])
	by mail.lfdr.de (Postfix) with ESMTPS id 93C96AF89D8
	for <lists+linux-erofs@lfdr.de>; Fri,  4 Jul 2025 09:45:59 +0200 (CEST)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4bYQfl39Ltz2ynh;
	Fri,  4 Jul 2025 17:45:51 +1000 (AEST)
X-Original-To: linux-erofs@lists.ozlabs.org
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip=115.124.30.101
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1751615151;
	cv=none; b=lunH4sI/pX0AajelvJgYwswNCnoWU+W5o+biGyDkAWuD3UArkqD+Dtru+VYdT3XoRFPLvqr9UQUTnjjEapWJcil4naCthfV1FdBsKWglX0LdMNEA2EXQFiBdDrecTZFcVT29YiJOcJXpqg5q6MxIrx72Ib8RUpK85JPb5iFTvi6nlaeLoXPgrCyo7JmQwYxd7R56HtV5yz+m6Gqoz51nye8eiIa/EEc6hI/YvnHlRHJbWWoCctjlAkbEFoxfcM+PoCbUAPb4pf+PlNKUz63XDSqL/fSJgnA8dwQS2HV3ekhyZGRtYA35dQqN76fCiODG0WkYA9Uy9HfrvdNAgKEBLQ==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1751615151; c=relaxed/relaxed;
	bh=isu+kA4ICp0GbMRH1oBwLdBMymozvrX/Zx9pdaos+yA=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=MJhPyKajzPcEK18acxhuDmJdSWvQghfNcth2b1EnLvtgiBoXAM/+m+L0lgeJpQM3jS8zr+Hjd0IbI5Ijao9E+vqe8t2SqS256SR/2zAghL8sqHyGOs5BgLSex5OeavxjA9Y0ZLDoaaHgoSdefpbyTj+PAJuXnzoYP+qpQh7DXKNtZZ3DfvDFNje4F/pROfJGIhD8ofwKcsKivETlYWhT4vukiGoHYVq/2Nd6V3D4KpFUAyJ5/ypWaaQWtJk2wt7w+77hmD0DW8RjWrLqgEzYxmukMs4LNivtkMfyl8lcl9wb3fSiH6KJcPL1qJZf5cBKVJrOXO2IJFSUNd/PxIEmlQ==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com; dkim=pass (1024-bit key; unprotected) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.a=rsa-sha256 header.s=default header.b=bfzTaCcU; dkim-atps=neutral; spf=pass (client-ip=115.124.30.101; helo=out30-101.freemail.mail.aliyun.com; envelope-from=hsiangkao@linux.alibaba.com; receiver=lists.ozlabs.org) smtp.mailfrom=linux.alibaba.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (1024-bit key; unprotected) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.a=rsa-sha256 header.s=default header.b=bfzTaCcU;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=linux.alibaba.com (client-ip=115.124.30.101; helo=out30-101.freemail.mail.aliyun.com; envelope-from=hsiangkao@linux.alibaba.com; receiver=lists.ozlabs.org)
Received: from out30-101.freemail.mail.aliyun.com (out30-101.freemail.mail.aliyun.com [115.124.30.101])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4bYQfh4GBrz30MY
	for <linux-erofs@lists.ozlabs.org>; Fri,  4 Jul 2025 17:45:48 +1000 (AEST)
DKIM-Signature:v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=linux.alibaba.com; s=default;
	t=1751615144; h=From:To:Subject:Date:Message-ID:MIME-Version;
	bh=isu+kA4ICp0GbMRH1oBwLdBMymozvrX/Zx9pdaos+yA=;
	b=bfzTaCcU17qLy5a7Mlwe8WcH0bouug3l5kD7bJqnDD6AHrEiNkRtHvQEU2t9533WXcatRS4aE5NoM69lYIXLPC9KbvVJdN5H/zvAviGad510iwW70JUznDvLLk4e3j3aflNzn+4hureM9a8qF7VAQbKW1xHybE1yUobv6gOTVcA=
Received: from x31i01179.sqa.na131.tbsite.net(mailfrom:hsiangkao@linux.alibaba.com fp:SMTPD_---0WhDC7AA_1751615142 cluster:ay36)
          by smtp.aliyun-inc.com;
          Fri, 04 Jul 2025 15:45:43 +0800
From: Gao Xiang <hsiangkao@linux.alibaba.com>
To: linux-erofs@lists.ozlabs.org
Cc: Gao Xiang <hsiangkao@linux.alibaba.com>
Subject: [PATCH v3 for-merge 2/9] erofs-utils: lib: clean up header parsing for ztailpacking and fragments
Date: Fri,  4 Jul 2025 15:45:28 +0800
Message-ID: <20250704074535.2308212-3-hsiangkao@linux.alibaba.com>
X-Mailer: git-send-email 2.43.5
In-Reply-To: <20250704074535.2308212-1-hsiangkao@linux.alibaba.com>
References: <20250704074535.2308212-1-hsiangkao@linux.alibaba.com>
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

Source kernel commit: 540787d38b10dbc16a7d2bc2845752ab1605403a

Signed-off-by: Gao Xiang <hsiangkao@linux.alibaba.com>
---
 lib/zmap.c | 22 +++++++---------------
 1 file changed, 7 insertions(+), 15 deletions(-)

diff --git a/lib/zmap.c b/lib/zmap.c
index d47ed6b8..07c6a83c 100644
--- a/lib/zmap.c
+++ b/lib/zmap.c
@@ -493,6 +493,11 @@ static int z_erofs_do_map_blocks(struct erofs_inode *vi,
 		map->m_flags |= EROFS_MAP_META;
 		map->m_pa = vi->z_fragmentoff;
 		map->m_plen = vi->z_idata_size;
+		if (erofs_blkoff(sbi, map->m_pa) + map->m_plen > erofs_blksiz(sbi)) {
+			erofs_err("invalid tail-packing pclustersize %llu",
+				  map->m_plen | 0ULL);
+			goto out;
+		}
 	} else if (fragment && m.lcn == vi->z_tailextent_headlcn) {
 		map->m_flags |= EROFS_MAP_FRAGMENT;
 	} else {
@@ -589,21 +594,8 @@ static int z_erofs_fill_inode_lazy(struct erofs_inode *vi)
 		return -EFSCORRUPTED;
 	}
 
-	if (vi->z_idata_size) {
-		struct erofs_map_blocks map = { .index = UINT_MAX };
-
-		err = z_erofs_do_map_blocks(vi, &map,
-					    EROFS_GET_BLOCKS_FINDTAIL);
-		if (erofs_blkoff(sbi, map.m_pa) + map.m_plen > erofs_blksiz(sbi)) {
-			erofs_err("invalid tail-packing pclustersize %llu",
-				  map.m_plen | 0ULL);
-			return -EFSCORRUPTED;
-		}
-		if (err < 0)
-			return err;
-	}
-	if (vi->z_advise & Z_EROFS_ADVISE_FRAGMENT_PCLUSTER &&
-	    !(h->h_clusterbits >> Z_EROFS_FRAGMENT_INODE_BIT)) {
+	if (vi->z_idata_size ||
+	    (vi->z_advise & Z_EROFS_ADVISE_FRAGMENT_PCLUSTER)) {
 		struct erofs_map_blocks map = { .index = UINT_MAX };
 
 		err = z_erofs_do_map_blocks(vi, &map,
-- 
2.43.5


