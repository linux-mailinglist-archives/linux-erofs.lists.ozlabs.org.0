Return-Path: <linux-erofs+bounces-495-lists+linux-erofs=lfdr.de@lists.ozlabs.org>
X-Original-To: lists+linux-erofs@lfdr.de
Delivered-To: lists+linux-erofs@lfdr.de
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2404:9400:2:0:216:3eff:fee1:b9f1])
	by mail.lfdr.de (Postfix) with ESMTPS id CC583AE9937
	for <lists+linux-erofs@lfdr.de>; Thu, 26 Jun 2025 10:55:17 +0200 (CEST)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4bSXZT6nGvz2xRw;
	Thu, 26 Jun 2025 18:55:13 +1000 (AEST)
X-Original-To: linux-erofs@lists.ozlabs.org
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip=115.124.30.130
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1750928113;
	cv=none; b=UKlsMucO/JCNIAphbDKxUUO4jl84GPDslwMoTgxMHIsQoKBA3qQXjYIy2/KWVfpkawEV5lCiZjQs1umrdjPpAEqSQ3JZ4CI9wxEwyrv6D+ZRz/xkzN3JcIo5mYZX/NI2Kt6Yde/at9qNgoGrF3T0qpGUUR/GuQh57U+tVAFxqC577UL+QxH632oBnYKqXd9eH1DLEslo4HlRpipoXVP9r7p6p0qeSYl5v1N+vcM5Ndlwod9OMhfqvX9piAIGzcLZuTo/FsR83hXWCCCgeQbBGUxDIcPglRtlmdeMZkPtqaF5YFeAaPAs34PoT+Ry5PxYVXH4+8nMFdmAfZLhz+/CEQ==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1750928113; c=relaxed/relaxed;
	bh=rqPrmNEJ3dusfEAN0LnjIzSUm4cuAkh0p1L4y60E3qk=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=h/EFdzn53lR5hw6KmKAqF5oV/9yC2UAb6DKfOlkIUhDhcB/8xhe9bVPmt21YvYnjKBw0toaU2geFcGk6OcesUqn+3Qoq41vosb3HgQ/FJvTf1rbM0JXcKREvsXQhcHBL9XcjMAbchPBA+F8QCSiEHNww8XBJb6rjzE+tkSb43EbAyLJjI5wb6R4eaR5Jjofy6gAf/KUAqjonm409D0g3wx3ZSK1F3QwbnnlYEeIDG4TnjUyQ4OZ3JsvQKyMVcOSLp8HpTlrt4FqhGOlAu2MnnsmBxvn/UuUzElnJNLOWohTUjWrkvC6cka+CI/32GiGA0Z9P8ZVFSw7wdty81s2qAA==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com; dkim=pass (1024-bit key; unprotected) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.a=rsa-sha256 header.s=default header.b=S5KfzP6Q; dkim-atps=neutral; spf=pass (client-ip=115.124.30.130; helo=out30-130.freemail.mail.aliyun.com; envelope-from=hsiangkao@linux.alibaba.com; receiver=lists.ozlabs.org) smtp.mailfrom=linux.alibaba.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (1024-bit key; unprotected) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.a=rsa-sha256 header.s=default header.b=S5KfzP6Q;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=linux.alibaba.com (client-ip=115.124.30.130; helo=out30-130.freemail.mail.aliyun.com; envelope-from=hsiangkao@linux.alibaba.com; receiver=lists.ozlabs.org)
Received: from out30-130.freemail.mail.aliyun.com (out30-130.freemail.mail.aliyun.com [115.124.30.130])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4bSXZR6tpWz2xJ1
	for <linux-erofs@lists.ozlabs.org>; Thu, 26 Jun 2025 18:55:10 +1000 (AEST)
DKIM-Signature:v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=linux.alibaba.com; s=default;
	t=1750928106; h=From:To:Subject:Date:Message-ID:MIME-Version;
	bh=rqPrmNEJ3dusfEAN0LnjIzSUm4cuAkh0p1L4y60E3qk=;
	b=S5KfzP6QlH8fznPZLlViCDeIF2bUC7uTBADGKi7hoKQom4lLsRLdOBXFApT5ypFZA9eHc9011IWiTiMWLqsMZ4cUEh28ZTf7SwGYf4DtF+n55gFpLEcEG6CCSFX0nnTdXLk5YMLq1RXBl0Z742o30f5kSb/KOuvn8y0coWlPDW8=
Received: from x31i01179.sqa.na131.tbsite.net(mailfrom:hsiangkao@linux.alibaba.com fp:SMTPD_---0Wf9zk5V_1750928100 cluster:ay36)
          by smtp.aliyun-inc.com;
          Thu, 26 Jun 2025 16:55:05 +0800
From: Gao Xiang <hsiangkao@linux.alibaba.com>
To: linux-erofs@lists.ozlabs.org
Cc: LKML <linux-kernel@vger.kernel.org>,
	Gao Xiang <hsiangkao@linux.alibaba.com>
Subject: [PATCH] erofs: get rid of {get,put}_page() for ztailpacking data
Date: Thu, 26 Jun 2025 16:54:59 +0800
Message-ID: <20250626085459.339830-1-hsiangkao@linux.alibaba.com>
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
	RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS,UNPARSEABLE_RELAY,
	USER_IN_DEF_DKIM_WL,USER_IN_DEF_SPF_WL autolearn=disabled version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-25) on lists.ozlabs.org

The compressed data for the ztailpacking feature is fetched from
the metadata inode (e.g., bd_inode), which is folio-based.

Therefore, the folio interface should be used instead.

Signed-off-by: Gao Xiang <hsiangkao@linux.alibaba.com>
---
 fs/erofs/zdata.c | 14 ++++++--------
 1 file changed, 6 insertions(+), 8 deletions(-)

diff --git a/fs/erofs/zdata.c b/fs/erofs/zdata.c
index fe8071844724..d80e3bf4fa79 100644
--- a/fs/erofs/zdata.c
+++ b/fs/erofs/zdata.c
@@ -805,6 +805,7 @@ static int z_erofs_pcluster_begin(struct z_erofs_frontend *fe)
 	struct erofs_map_blocks *map = &fe->map;
 	struct super_block *sb = fe->inode->i_sb;
 	struct z_erofs_pcluster *pcl = NULL;
+	void *ptr;
 	int ret;
 
 	DBG_BUGON(fe->pcl);
@@ -854,15 +855,13 @@ static int z_erofs_pcluster_begin(struct z_erofs_frontend *fe)
 		/* bind cache first when cached decompression is preferred */
 		z_erofs_bind_cache(fe);
 	} else {
-		void *mptr;
-
-		mptr = erofs_read_metabuf(&map->buf, sb, map->m_pa, false);
-		if (IS_ERR(mptr)) {
-			ret = PTR_ERR(mptr);
+		ptr = erofs_read_metabuf(&map->buf, sb, map->m_pa, false);
+		if (IS_ERR(ptr)) {
+			ret = PTR_ERR(ptr);
 			erofs_err(sb, "failed to get inline data %d", ret);
 			return ret;
 		}
-		get_page(map->buf.page);
+		folio_get(page_folio(map->buf.page));
 		WRITE_ONCE(fe->pcl->compressed_bvecs[0].page, map->buf.page);
 		fe->pcl->pageofs_in = map->m_pa & ~PAGE_MASK;
 		fe->mode = Z_EROFS_PCLUSTER_FOLLOWED_NOINPLACE;
@@ -1325,9 +1324,8 @@ static int z_erofs_decompress_pcluster(struct z_erofs_backend *be, int err)
 
 	/* must handle all compressed pages before actual file pages */
 	if (pcl->from_meta) {
-		page = pcl->compressed_bvecs[0].page;
+		folio_put(page_folio(pcl->compressed_bvecs[0].page));
 		WRITE_ONCE(pcl->compressed_bvecs[0].page, NULL);
-		put_page(page);
 	} else {
 		/* managed folios are still left in compressed_bvecs[] */
 		for (i = 0; i < pclusterpages; ++i) {
-- 
2.43.5


