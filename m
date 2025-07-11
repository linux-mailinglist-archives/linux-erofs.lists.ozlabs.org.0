Return-Path: <linux-erofs+bounces-594-lists+linux-erofs=lfdr.de@lists.ozlabs.org>
X-Original-To: lists+linux-erofs@lfdr.de
Delivered-To: lists+linux-erofs@lfdr.de
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2404:9400:2:0:216:3eff:fee1:b9f1])
	by mail.lfdr.de (Postfix) with ESMTPS id D6212B0257C
	for <lists+linux-erofs@lfdr.de>; Fri, 11 Jul 2025 21:58:45 +0200 (CEST)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4bf2b715Wxz2ys0;
	Sat, 12 Jul 2025 05:58:43 +1000 (AEST)
X-Original-To: linux-erofs@lists.ozlabs.org
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip=115.124.30.98
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1752263923;
	cv=none; b=A/IuudmA2Z/odCY11yNDJ90ikU/NMNyAyIA0ChzeTuNB7jnYFxpd1qysnq+725X/s72djBarnHhDdv0gi3A7gI/9Y8qq9ClfJMRcQQJ7WPIrwTFP6Ceg53EjUnTUvu5o1tn18w0zuPwPhG69mVLd26Eqq41ygMOFKBRV6wIffapHxTCGXt41rLHkWQnKnXgFvVaBdEuACKeBMedtKSrAoJCG6wut5pqR/qh8ZnFqg6E06IdFORhszFljpZvIaqkZSVb/UQdPskCCo0QO6/fv7/NY+QUlJN7OXtuPGp3pBi/iro0/E56YDmQ8YZZOfItSpNVpg3WxAp7tl/ETJuxMSg==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1752263923; c=relaxed/relaxed;
	bh=odfWDvqu6DkbM3v/1M/WfbIdcwX+3SShHCrXamf+WSc=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=adTDUg+UcqD3UYqZFcBVYFpbZVZVIgIdU4l84i27tP0TTj/EBaboDv8Dl4GkatSPwFv6agbx0hybf/b/ainKp6WPX1B/kmuTCpSWPu9rl6rhLWoNcoUr6+H2j+L9gnoGIVQSov+SaoU3tQgqVDffsBZ0TYN1CIOeMjwuCSJchLc0wgDtJSqofnyRcxxbjhlf9AE1qX2yVEIdmwloBvrS3p84dVfs+9yAO+ilT5cS56jBKQxefZk0drHDPJW7FW1Eu8zvkSq/UhM/Nyfn8RLatJy6CHMWMYFA+akmZCWK7SWtm8NQgJ4U5HB8CvKL+J2UVWdAD5wXHox+anhUmC/Mag==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com; dkim=pass (1024-bit key; unprotected) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.a=rsa-sha256 header.s=default header.b=RbHFAiZq; dkim-atps=neutral; spf=pass (client-ip=115.124.30.98; helo=out30-98.freemail.mail.aliyun.com; envelope-from=hsiangkao@linux.alibaba.com; receiver=lists.ozlabs.org) smtp.mailfrom=linux.alibaba.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (1024-bit key; unprotected) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.a=rsa-sha256 header.s=default header.b=RbHFAiZq;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=linux.alibaba.com (client-ip=115.124.30.98; helo=out30-98.freemail.mail.aliyun.com; envelope-from=hsiangkao@linux.alibaba.com; receiver=lists.ozlabs.org)
Received: from out30-98.freemail.mail.aliyun.com (out30-98.freemail.mail.aliyun.com [115.124.30.98])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4bf2b40zWyz2ym2
	for <linux-erofs@lists.ozlabs.org>; Sat, 12 Jul 2025 05:58:38 +1000 (AEST)
DKIM-Signature:v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=linux.alibaba.com; s=default;
	t=1752263914; h=From:To:Subject:Date:Message-ID:MIME-Version;
	bh=odfWDvqu6DkbM3v/1M/WfbIdcwX+3SShHCrXamf+WSc=;
	b=RbHFAiZqQxpfMtn15FMvammK4Usmyp7MUwTbt4OWOdYWvptwQI8gP2/+ceN5XX9mHrmnyrmy5kJXo4f7v9FLa1El2JoyMczb6UmaNzLiB32NBvzN5t6e14nFJ4qsQv0+OmVSKRH3eE1yWUMMqKi5DwASNUvRK0COwkee3Ec5TlE=
Received: from x31i01179.sqa.na131.tbsite.net(mailfrom:hsiangkao@linux.alibaba.com fp:SMTPD_---0Wihw24S_1752263907 cluster:ay36)
          by smtp.aliyun-inc.com;
          Sat, 12 Jul 2025 03:58:32 +0800
From: Gao Xiang <hsiangkao@linux.alibaba.com>
To: linux-erofs@lists.ozlabs.org
Cc: LKML <linux-kernel@vger.kernel.org>,
	Gao Xiang <hsiangkao@linux.alibaba.com>,
	Axel Fontaine <axel@axelfontaine.com>
Subject: [PATCH v2] erofs: fix large fragment handling
Date: Sat, 12 Jul 2025 03:58:26 +0800
Message-ID: <20250711195826.3601157-1-hsiangkao@linux.alibaba.com>
X-Mailer: git-send-email 2.43.5
In-Reply-To: <20250711174257.3427562-1-hsiangkao@linux.alibaba.com>
References: <20250711174257.3427562-1-hsiangkao@linux.alibaba.com>
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

Fragments aren't limited by Z_EROFS_PCLUSTER_MAX_DSIZE. However, if
a fragment's logical length is larger than Z_EROFS_PCLUSTER_MAX_DSIZE
but the fragment is not the whole inode, it currently returns
-EOPNOTSUPP because m_flags has the wrong EROFS_MAP_ENCODED flag set.
It is not intended by design but should be rare, as it can only be
reproduced by mkfs with `-Eall-fragments` in a specific case.

Let's normalize fragment m_flags using the new EROFS_MAP_FRAGMENT.

Reported-by: Axel Fontaine <axel@axelfontaine.com>
Closes: https://github.com/erofs/erofs-utils/issues/23
Fixes: 7c3ca1838a78 ("erofs: restrict pcluster size limitations")
Signed-off-by: Gao Xiang <hsiangkao@linux.alibaba.com>
---
changes since v1:
 - should replace the old EROFS_MAP_FRAGMENT checks too.

 fs/erofs/internal.h | 4 +++-
 fs/erofs/zdata.c    | 2 +-
 fs/erofs/zmap.c     | 9 ++++-----
 3 files changed, 8 insertions(+), 7 deletions(-)

diff --git a/fs/erofs/internal.h b/fs/erofs/internal.h
index 0d19bde8c094..06b867d2fc3b 100644
--- a/fs/erofs/internal.h
+++ b/fs/erofs/internal.h
@@ -315,10 +315,12 @@ static inline struct folio *erofs_grab_folio_nowait(struct address_space *as,
 /* The length of extent is full */
 #define EROFS_MAP_FULL_MAPPED	0x0008
 /* Located in the special packed inode */
-#define EROFS_MAP_FRAGMENT	0x0010
+#define __EROFS_MAP_FRAGMENT	0x0010
 /* The extent refers to partial decompressed data */
 #define EROFS_MAP_PARTIAL_REF	0x0020
 
+#define EROFS_MAP_FRAGMENT	(EROFS_MAP_MAPPED | __EROFS_MAP_FRAGMENT)
+
 struct erofs_map_blocks {
 	struct erofs_buf buf;
 
diff --git a/fs/erofs/zdata.c b/fs/erofs/zdata.c
index 6f8402ed5b28..5e0240b7b7db 100644
--- a/fs/erofs/zdata.c
+++ b/fs/erofs/zdata.c
@@ -1033,7 +1033,7 @@ static int z_erofs_scan_folio(struct z_erofs_frontend *f,
 		if (!(map->m_flags & EROFS_MAP_MAPPED)) {
 			folio_zero_segment(folio, cur, end);
 			tight = false;
-		} else if (map->m_flags & EROFS_MAP_FRAGMENT) {
+		} else if (map->m_flags & __EROFS_MAP_FRAGMENT) {
 			erofs_off_t fpos = offset + cur - map->m_la;
 
 			err = z_erofs_read_fragment(inode->i_sb, folio, cur,
diff --git a/fs/erofs/zmap.c b/fs/erofs/zmap.c
index 431199452542..312ec54668aa 100644
--- a/fs/erofs/zmap.c
+++ b/fs/erofs/zmap.c
@@ -403,8 +403,7 @@ static int z_erofs_map_blocks_fo(struct inode *inode,
 	    !vi->z_tailextent_headlcn) {
 		map->m_la = 0;
 		map->m_llen = inode->i_size;
-		map->m_flags = EROFS_MAP_MAPPED |
-			EROFS_MAP_FULL_MAPPED | EROFS_MAP_FRAGMENT;
+		map->m_flags = EROFS_MAP_FRAGMENT;
 		return 0;
 	}
 	initial_lcn = ofs >> lclusterbits;
@@ -468,7 +467,7 @@ static int z_erofs_map_blocks_fo(struct inode *inode,
 			goto unmap_out;
 		}
 	} else if (fragment && m.lcn == vi->z_tailextent_headlcn) {
-		map->m_flags |= EROFS_MAP_FRAGMENT;
+		map->m_flags = EROFS_MAP_FRAGMENT;
 	} else {
 		map->m_pa = erofs_pos(sb, m.pblk);
 		err = z_erofs_get_extent_compressedlen(&m, initial_lcn);
@@ -596,7 +595,7 @@ static int z_erofs_map_blocks_ext(struct inode *inode,
 	if (lstart < lend) {
 		map->m_la = lstart;
 		if (last && (vi->z_advise & Z_EROFS_ADVISE_FRAGMENT_PCLUSTER)) {
-			map->m_flags |= EROFS_MAP_MAPPED | EROFS_MAP_FRAGMENT;
+			map->m_flags = EROFS_MAP_FRAGMENT;
 			vi->z_fragmentoff = map->m_plen;
 			if (recsz > offsetof(struct z_erofs_extent, pstart_lo))
 				vi->z_fragmentoff |= map->m_pa << 32;
@@ -776,7 +775,7 @@ static int z_erofs_iomap_begin_report(struct inode *inode, loff_t offset,
 	iomap->length = map.m_llen;
 	if (map.m_flags & EROFS_MAP_MAPPED) {
 		iomap->type = IOMAP_MAPPED;
-		iomap->addr = map.m_flags & EROFS_MAP_FRAGMENT ?
+		iomap->addr = map.m_flags & __EROFS_MAP_FRAGMENT ?
 			      IOMAP_NULL_ADDR : map.m_pa;
 	} else {
 		iomap->type = IOMAP_HOLE;
-- 
2.43.5


