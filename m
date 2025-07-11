Return-Path: <linux-erofs+bounces-592-lists+linux-erofs=lfdr.de@lists.ozlabs.org>
X-Original-To: lists+linux-erofs@lfdr.de
Delivered-To: lists+linux-erofs@lfdr.de
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	by mail.lfdr.de (Postfix) with ESMTPS id 071AFB022E4
	for <lists+linux-erofs@lfdr.de>; Fri, 11 Jul 2025 19:43:20 +0200 (CEST)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4bdzZp2cm5z2ys0;
	Sat, 12 Jul 2025 03:43:14 +1000 (AEST)
X-Original-To: linux-erofs@lists.ozlabs.org
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip=115.124.30.124
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1752255794;
	cv=none; b=afrftpmHpYN1OXK6z2ENpWyygE0O8+sChTiSLmVjSq8ep9kIsvTOS3mQWVYypZbqFm3hqgZ596wSXzAuWT8LsYwb54J33Amd4Olfw26JqlZ4E2kEDILv1pOhZFYD6+t39GIi6t2QDIMG8ZRNOtrNJ0t4AxpKZZUeAoqGppGhZq1z3vT5idlRN+iR0twwr/RtX2MfFGoL3y3oy25/Xu7Hy7vpndIk7aPHIBDhwyhZAPhr+KEjHjDGI6zfv6Ew0HcvdM6yFup67Fx0eAUUnHFQfPoNQT/geqIJwLhHHYAiJlA25PY9zy3fO7otdz33PdLeqNieWTMPwcjUo6PmZn2o/w==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1752255794; c=relaxed/relaxed;
	bh=v+obGjGNZ7DcaJP0+2r+47ioTeGjRbyq9DzXi0xXDoY=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=oDrBAOZt7N5vxyVm3r+PqLtwILNSA7rBBDr2Alxah+Tw/Xatm2gySGI2qWk49M5dDtx0cM68Td6wZkMxUTn9occ65UbgFZmMX+NDg9UAeM/Is8ezicF+1IN1FljkXIfDuvKzCJzkwe9u8DGBIda36PPjZvoq2s1bH+Gokoa9quqxz6Zq+OCqAZ59V9DhfuiSasOtexfbSYNpcRnQeLXE5DUXQoqvAWT7ZjyG7F2wa/0HiSiIe9uEHYWanZz6PclS8zTFewDPAXU+ojsiaEXniiN+91wk2DbPmFM1hJJVGOvcwXSdIAj+SE9S1mN/+HPLGYaVg58TYkPqQMjyHjZtqA==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com; dkim=pass (1024-bit key; unprotected) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.a=rsa-sha256 header.s=default header.b=x1clU0DX; dkim-atps=neutral; spf=pass (client-ip=115.124.30.124; helo=out30-124.freemail.mail.aliyun.com; envelope-from=hsiangkao@linux.alibaba.com; receiver=lists.ozlabs.org) smtp.mailfrom=linux.alibaba.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (1024-bit key; unprotected) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.a=rsa-sha256 header.s=default header.b=x1clU0DX;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=linux.alibaba.com (client-ip=115.124.30.124; helo=out30-124.freemail.mail.aliyun.com; envelope-from=hsiangkao@linux.alibaba.com; receiver=lists.ozlabs.org)
Received: from out30-124.freemail.mail.aliyun.com (out30-124.freemail.mail.aliyun.com [115.124.30.124])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4bdzZm1fgdz2ym2
	for <linux-erofs@lists.ozlabs.org>; Sat, 12 Jul 2025 03:43:10 +1000 (AEST)
DKIM-Signature:v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=linux.alibaba.com; s=default;
	t=1752255786; h=From:To:Subject:Date:Message-ID:MIME-Version;
	bh=v+obGjGNZ7DcaJP0+2r+47ioTeGjRbyq9DzXi0xXDoY=;
	b=x1clU0DXWXsrLDxz3cRyHDmVTDheJDJHhupMj6kSd2tBp5+WBjrqWSjYWS4Hhw0oB4ecbGKsLZtnmNEqm5JUOLeNfhNgipk2RC88QwFgF0Yf+4igPwEUV0BqwQ8Kc80IyOirRKWQwYx4+CI+5mV9P3YKpYGjYf6X76CzdbbIGqQ=
Received: from x31i01179.sqa.na131.tbsite.net(mailfrom:hsiangkao@linux.alibaba.com fp:SMTPD_---0WihkUVt_1752255778 cluster:ay36)
          by smtp.aliyun-inc.com;
          Sat, 12 Jul 2025 01:43:05 +0800
From: Gao Xiang <hsiangkao@linux.alibaba.com>
To: linux-erofs@lists.ozlabs.org
Cc: LKML <linux-kernel@vger.kernel.org>,
	Gao Xiang <hsiangkao@linux.alibaba.com>,
	Axel Fontaine <axel@axelfontaine.com>
Subject: [PATCH] erofs: fix large fragment handling
Date: Sat, 12 Jul 2025 01:42:57 +0800
Message-ID: <20250711174257.3427562-1-hsiangkao@linux.alibaba.com>
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
	DKIM_VALID_AU,DKIM_VALID_EF,ENV_AND_HDR_SPF_MATCH,SPF_HELO_NONE,
	SPF_PASS,UNPARSEABLE_RELAY,USER_IN_DEF_DKIM_WL,USER_IN_DEF_SPF_WL
	autolearn=disabled version=4.0.1
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
 fs/erofs/internal.h | 4 +++-
 fs/erofs/zmap.c     | 7 +++----
 2 files changed, 6 insertions(+), 5 deletions(-)

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
 
diff --git a/fs/erofs/zmap.c b/fs/erofs/zmap.c
index 431199452542..07a6810a076b 100644
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
-- 
2.43.5


