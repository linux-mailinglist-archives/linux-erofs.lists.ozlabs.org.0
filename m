Return-Path: <linux-erofs+bounces-548-lists+linux-erofs=lfdr.de@lists.ozlabs.org>
X-Original-To: lists+linux-erofs@lfdr.de
Delivered-To: lists+linux-erofs@lfdr.de
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	by mail.lfdr.de (Postfix) with ESMTPS id 92C2FAFC116
	for <lists+linux-erofs@lfdr.de>; Tue,  8 Jul 2025 04:58:16 +0200 (CEST)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4bbm521k4Dz3064;
	Tue,  8 Jul 2025 12:58:14 +1000 (AEST)
X-Original-To: linux-erofs@lists.ozlabs.org
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip=115.124.30.113
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1751943494;
	cv=none; b=nrVZA+rlFYcD5JuMnkmzLiG6OK19qphuUROXbahKHF7WeA9oDIRPNeewUwWx1frxbD4mqet9p/YcciqYLWPD6KQ/DXv19v1HKxgE7rhzRdkIUaWO1fZxvWrhxzrAvSlyxdrRn94Z5rfdafZS1+C2iXVG+ARq6jUOjyMfpIRLai49bB5dRvdQM3b5oCHRJsTUdCezCYNpLErkwrncKclMc1XjOboI5sUWSJtN2B2oXUG8PzLamc+QdxsPK8TZhgpfOx8g37vVdQd6OR/RcSIUMVY+OfUkz+4mAyaab00meiEKC5jTZd6Qwljy1g/enhY1VP8rcvQFGqBKKLrLhaFoNw==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1751943494; c=relaxed/relaxed;
	bh=D/SQkQyiBiqr7Hn8p76kER8Q8ghEeOvxX581xJ16oHI=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=TTWqBWNEyk1aRCwvX7AGSJmjeWWE17yKC/d+hPVejmfh6/yNBOIpDuVzA5O2XbDQpzy6NZWqMHzr88JInYG5AakKMUwhcBGGKA5jWvub4c593Fu4JAo1gH7jTud0PIl9Sc9KKzUiAZLUUzWZrKRYcEYFN064G2wVfKvbEDxxGczglKUMJsEE+pxT6JTcx+lSEytuVBqwet/cr5ascNJPjLtWp7qD1B9Ih4Q+onbwcHZal3GLLiGtqafZs21rIKxm67XclrxtB0L6XZEctX/veUHSAPHXy78pRRQXNcSz6rxpXDcTjtqvZ4ZbIAESkOCSkwgOswEbCj3kcij4OToiOA==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com; dkim=pass (1024-bit key; unprotected) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.a=rsa-sha256 header.s=default header.b=rOwVxH+F; dkim-atps=neutral; spf=pass (client-ip=115.124.30.113; helo=out30-113.freemail.mail.aliyun.com; envelope-from=hsiangkao@linux.alibaba.com; receiver=lists.ozlabs.org) smtp.mailfrom=linux.alibaba.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (1024-bit key; unprotected) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.a=rsa-sha256 header.s=default header.b=rOwVxH+F;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=linux.alibaba.com (client-ip=115.124.30.113; helo=out30-113.freemail.mail.aliyun.com; envelope-from=hsiangkao@linux.alibaba.com; receiver=lists.ozlabs.org)
Received: from out30-113.freemail.mail.aliyun.com (out30-113.freemail.mail.aliyun.com [115.124.30.113])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4bbm502Gl8z2yFP
	for <linux-erofs@lists.ozlabs.org>; Tue,  8 Jul 2025 12:58:10 +1000 (AEST)
DKIM-Signature:v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=linux.alibaba.com; s=default;
	t=1751943487; h=Message-ID:Date:MIME-Version:Subject:To:From:Content-Type;
	bh=D/SQkQyiBiqr7Hn8p76kER8Q8ghEeOvxX581xJ16oHI=;
	b=rOwVxH+FFSZMXY8KBESRKSfAgHFVo7wrPLcr10p5wxsa7xKWyZBlOCLX9ScLlJeJ/Iw6k4ULwb+GcmnBVAiKhBU4zseSxch0z3wUCEdrbzPh2e2jaemA73+X/UBdJ9mWoiAB9mJ83fJahAZ/c9I04vQXUwzN7k1ySY1egyTSt3A=
Received: from 30.221.131.215(mailfrom:hsiangkao@linux.alibaba.com fp:SMTPD_---0WiJ79iY_1751943484 cluster:ay36)
          by smtp.aliyun-inc.com;
          Tue, 08 Jul 2025 10:58:05 +0800
Message-ID: <e367f45a-b511-4f64-a528-807317004a2e@linux.alibaba.com>
Date: Tue, 8 Jul 2025 10:58:04 +0800
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
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] erofs: do sanity check on m->type in
 z_erofs_load_compact_lcluster()
To: Chao Yu <chao@kernel.org>, xiang@kernel.org
Cc: linux-erofs@lists.ozlabs.org, linux-kernel@vger.kernel.org,
 Yue Hu <zbestahu@gmail.com>, Jeffle Xu <jefflexu@linux.alibaba.com>,
 Sandeep Dhavale <dhavale@google.com>, Hongbo Li <lihongbo22@huawei.com>
References: <20250707084723.2725437-1-chao@kernel.org>
From: Gao Xiang <hsiangkao@linux.alibaba.com>
In-Reply-To: <20250707084723.2725437-1-chao@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-15.7 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,DKIM_VALID_EF,ENV_AND_HDR_SPF_MATCH,RCVD_IN_DNSWL_NONE,
	SPF_HELO_NONE,SPF_PASS,UNPARSEABLE_RELAY,USER_IN_DEF_DKIM_WL,
	USER_IN_DEF_SPF_WL autolearn=disabled version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-25) on lists.ozlabs.org

Hi Chao,

On 2025/7/7 16:47, Chao Yu wrote:
> All below functions will do sanity check on m->type, let's move sanity
> check to z_erofs_load_compact_lcluster() for cleanup.
> - z_erofs_map_blocks_fo
> - z_erofs_get_extent_compressedlen
> - z_erofs_get_extent_decompressedlen
> - z_erofs_extent_lookback
> 
> Signed-off-by: Chao Yu <chao@kernel.org>
How about appending the following diff to tidy up the code
a bit further (avoid `goto map_block` and `goto out`)?


  fs/erofs/zmap.c | 67 +++++++++++++++++++++++--------------------------
  1 file changed, 31 insertions(+), 36 deletions(-)

diff --git a/fs/erofs/zmap.c b/fs/erofs/zmap.c
index e530b152e14e..431199452542 100644
--- a/fs/erofs/zmap.c
+++ b/fs/erofs/zmap.c
@@ -327,21 +327,18 @@ static int z_erofs_get_extent_compressedlen(struct z_erofs_maprecorder *m,
  	DBG_BUGON(lcn == initial_lcn &&
  		  m->type == Z_EROFS_LCLUSTER_TYPE_NONHEAD);
  
-	if (m->type == Z_EROFS_LCLUSTER_TYPE_NONHEAD) {
-		if (m->delta[0] != 1) {
-			erofs_err(sb, "bogus CBLKCNT @ lcn %lu of nid %llu", lcn, vi->nid);
-			DBG_BUGON(1);
-			return -EFSCORRUPTED;
-		}
-		if (m->compressedblks)
-			goto out;
+	if (m->type == Z_EROFS_LCLUSTER_TYPE_NONHEAD && m->delta[0] != 1) {
+		erofs_err(sb, "bogus CBLKCNT @ lcn %lu of nid %llu", lcn, vi->nid);
+		DBG_BUGON(1);
+		return -EFSCORRUPTED;
  	}
  
  	/*
  	 * if the 1st NONHEAD lcluster is actually PLAIN or HEAD type rather
  	 * than CBLKCNT, it's a 1 block-sized pcluster.
  	 */
-	m->compressedblks = 1;
+	if (m->type != Z_EROFS_LCLUSTER_TYPE_NONHEAD || !m->compressedblks)
+		m->compressedblks = 1;
  out:
  	m->map->m_plen = erofs_pos(sb, m->compressedblks);
  	return 0;
@@ -422,36 +419,34 @@ static int z_erofs_map_blocks_fo(struct inode *inode,
  	map->m_flags = EROFS_MAP_MAPPED | EROFS_MAP_ENCODED;
  	end = (m.lcn + 1ULL) << lclusterbits;
  
-	if (m.type != Z_EROFS_LCLUSTER_TYPE_NONHEAD) {
-		if (endoff >= m.clusterofs) {
-			m.headtype = m.type;
-			map->m_la = (m.lcn << lclusterbits) | m.clusterofs;
-			/*
-			 * For ztailpacking files, in order to inline data more
-			 * effectively, special EOF lclusters are now supported
-			 * which can have three parts at most.
-			 */
-			if (ztailpacking && end > inode->i_size)
-				end = inode->i_size;
-			goto map_block;
+	if (m.type != Z_EROFS_LCLUSTER_TYPE_NONHEAD && endoff >= m.clusterofs) {
+		m.headtype = m.type;
+		map->m_la = (m.lcn << lclusterbits) | m.clusterofs;
+		/*
+		 * For ztailpacking files, in order to inline data more
+		 * effectively, special EOF lclusters are now supported
+		 * which can have three parts at most.
+		 */
+		if (ztailpacking && end > inode->i_size)
+			end = inode->i_size;
+	} else {
+		if (m.type != Z_EROFS_LCLUSTER_TYPE_NONHEAD) {
+			/* m.lcn should be >= 1 if endoff < m.clusterofs */
+			if (!m.lcn) {
+				erofs_err(sb, "invalid logical cluster 0 at nid %llu",
+					  vi->nid);
+				err = -EFSCORRUPTED;
+				goto unmap_out;
+			}
+			end = (m.lcn << lclusterbits) | m.clusterofs;
+			map->m_flags |= EROFS_MAP_FULL_MAPPED;
+			m.delta[0] = 1;
  		}
-		/* m.lcn should be >= 1 if endoff < m.clusterofs */
-		if (!m.lcn) {
-			erofs_err(sb, "invalid logical cluster 0 at nid %llu",
-				  vi->nid);
-			err = -EFSCORRUPTED;
+		/* get the corresponding first chunk */
+		err = z_erofs_extent_lookback(&m, m.delta[0]);
+		if (err)
  			goto unmap_out;
-		}
-		end = (m.lcn << lclusterbits) | m.clusterofs;
-		map->m_flags |= EROFS_MAP_FULL_MAPPED;
-		m.delta[0] = 1;
  	}
-
-	/* get the corresponding first chunk */
-	err = z_erofs_extent_lookback(&m, m.delta[0]);
-	if (err)
-		goto unmap_out;
-map_block:
  	if (m.partialref)
  		map->m_flags |= EROFS_MAP_PARTIAL_REF;
  	map->m_llen = end - map->m_la;
-- 
2.43.5




