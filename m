Return-Path: <linux-erofs+bounces-915-lists+linux-erofs=lfdr.de@lists.ozlabs.org>
X-Original-To: lists+linux-erofs@lfdr.de
Delivered-To: lists+linux-erofs@lfdr.de
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2404:9400:2:0:216:3eff:fee1:b9f1])
	by mail.lfdr.de (Postfix) with ESMTPS id A0311B37A2B
	for <lists+linux-erofs@lfdr.de>; Wed, 27 Aug 2025 08:09:14 +0200 (CEST)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4cBYyJ02NSz30T8;
	Wed, 27 Aug 2025 16:09:12 +1000 (AEST)
X-Original-To: linux-erofs@lists.ozlabs.org
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip="2607:f8b0:4864:20::102f"
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1756274951;
	cv=none; b=CsdWD0budtIhDlSKJjv4ijZdP6T2EsG2gKIL1/CfoReCdJ5zsKTeXmrvTlIxD+ZEuUFmXO47CHpExWW8s2Ph94bht2i+z21NkTLcUPmgcvqhEidDWzKReqlL+DTVlxChE7spuGRm6W3fSIitp+k6u0uXtq2PVPe8XOkNngevvFtD57xUzdH0fH38De2NiSwvhjHf4xXXYXid6VeVY6uOfocsJC8/0dBSRDH3FLrqpdmbn8C3z6y4jTUm394pzre5ajH3lU8VmG5bk97lHisGdNJ6aci+BODNRkxku24FNmA5UQBDAjqrBoL0qUQdw3R+4S0E4Tkei6aITpwfgcTnUQ==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1756274951; c=relaxed/relaxed;
	bh=mPeXiJMDW7GWrzLcvUgAMuJREDOHOPtlB9iXb25bXbc=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=gw319pTrtxKGWU8wG2vqzz+/XkgTtoA64TQkepSX4fjIsuVa2omnRbLV1wPT9LbTI81zH8Hpx6LBnXKIbxFxfCmhX5DwtMy/XzqEOWtUbbhXTqOkRJe5hd8fPIZlVR/gzeYEv8UFSVfj7LzPY987UHBiRv78alvvqM6XnLhJLhy5OAmiri+Ag3yMTiwAl+hDBbI+NSr9mGxHTvJqrvKcEF+XxeNrKCnL8QH1su6pSklR6/a5h+TC8+8GQaT65hhC2oviexhUdQUG9TW4CBgMBRWuBUJANpZDLu792fGZIrcDx5KMuZil04vvUZw5acNtGr8XoEj8nZdJ8fCrlYbAqg==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=none (p=none dis=none) header.from=sijam.com; dkim=pass (2048-bit key; unprotected) header.d=sijam-com.20230601.gappssmtp.com header.i=@sijam-com.20230601.gappssmtp.com header.a=rsa-sha256 header.s=20230601 header.b=s9m/g7Tc; dkim-atps=neutral; spf=none (client-ip=2607:f8b0:4864:20::102f; helo=mail-pj1-x102f.google.com; envelope-from=asai@sijam.com; receiver=lists.ozlabs.org) smtp.mailfrom=sijam.com
Authentication-Results: lists.ozlabs.org; dmarc=none (p=none dis=none) header.from=sijam.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=sijam-com.20230601.gappssmtp.com header.i=@sijam-com.20230601.gappssmtp.com header.a=rsa-sha256 header.s=20230601 header.b=s9m/g7Tc;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=none (no SPF record) smtp.mailfrom=sijam.com (client-ip=2607:f8b0:4864:20::102f; helo=mail-pj1-x102f.google.com; envelope-from=asai@sijam.com; receiver=lists.ozlabs.org)
Received: from mail-pj1-x102f.google.com (mail-pj1-x102f.google.com [IPv6:2607:f8b0:4864:20::102f])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4cBYyG4XPjz2yDH
	for <linux-erofs@lists.ozlabs.org>; Wed, 27 Aug 2025 16:09:09 +1000 (AEST)
Received: by mail-pj1-x102f.google.com with SMTP id 98e67ed59e1d1-327705d0a9bso279648a91.0
        for <linux-erofs@lists.ozlabs.org>; Tue, 26 Aug 2025 23:09:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=sijam-com.20230601.gappssmtp.com; s=20230601; t=1756274947; x=1756879747; darn=lists.ozlabs.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=mPeXiJMDW7GWrzLcvUgAMuJREDOHOPtlB9iXb25bXbc=;
        b=s9m/g7Tc6vm7VgYt4SAJzlHi1Qsk9kYK5A15oKgNrGU0ffD2Sgq5ShcWRpGvIBFUOH
         zgKOMZToN6waEtUrkeOXX0FbiVgkCFF697Yy97zozMW0VzmNzrsJ7BITPQsWt4ZlXGNo
         XWhZrF/6SLGzpsbGcayp623JliKC51bruirbvxtpDiYGYyLvq8ZxliUaN/zWGMY3tRXj
         ccueHMCmuwJydbsClmNWmKcXO4wh54nVuSPUnibajxWO+l2HaQ+b/25SjVWWWP3IAhIF
         xU17wW3lIOcjq+RwmgwTGzJaQdTyWqAtHQmGUOBp4isvGlM6ZiyQ4HT8zUvBAg+toyHW
         ssxw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1756274947; x=1756879747;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=mPeXiJMDW7GWrzLcvUgAMuJREDOHOPtlB9iXb25bXbc=;
        b=MG4kyvdXQ1w7I0nZkbKhtKQfCuFI4W0//w9M4/adzfs3qAbbtzf5CC0YujbOVzGzdo
         4pc2YddHs2fap7/CMpisSuuLmubBdZPgfSg2NTAhPI50j0KAdoPkyWs32SH4oElkG1LW
         lB5waLmHhHHaqrzZYRlKvO2EaDX+lmjKLWaXGr/1dn7coMFM1L62KZNu/2uAOB0jBA1h
         Y/825NjCMX5Xbg9WeDgUVacRIttLJoKK9oyPE2hhbqZsvLb0efW35i0utCMXLgz5urfl
         YRFXCXq+WftOhLX481BHl8cIR5weFQyBalzw0sruaRQ0+Z/rZsm0sbmWlCCyXec7LehW
         dg4A==
X-Gm-Message-State: AOJu0Ywqbr2amHT0pR3L/lhsKH5wIX9oAK/k/BZOjDoIyeyxtIO76571
	1/dS81LoXiIOmp3f3dsg7WRhZa4vHARhze4uU63DqwjavoULqzD+BadSWjphJHrmIaw+dwFVLgp
	5fyo2
X-Gm-Gg: ASbGnctCbqx+5jD5q1d6kZ1PHcGHXmsNX0PpB16JHFzOG5sZVfmYAzIMoKsUVfWDFVw
	dBS4Q4sDidSYwSV9h6TnWiQGC9FHJA9adYNNaQvj0/+Jar0qxXNrE7Hw0tgAgEGJz193KTjdAFN
	/cEzOpWJY5gcHygmirGx8n1Gw5YHZ7FY8I5VktHZGIwBOrRGwkwOYflJxgXK8grYzzmpyjuy+p7
	d00dXPPrJaBz/F0V2iEXoA/oaCww7EeJ0VTmpLLQVqBCUrKNcc1NHQuUdOwrepIt8bqVXaCFzGw
	Jk2zkbI2dVUK064G8Jj57o7WovooviG/T5kTIiCROUwRjND2KUTFJTJF2faQu1pLE9sKpv++ghk
	6xlEzyvBIvMzxg3zCjUAq0ujJy4HMiohm7/qHOaKqFAjzJ791Peiv3zV41U66QR5SafK3dMzDWD
	jdij1+PXI=
X-Google-Smtp-Source: AGHT+IEr8DXOuDgtZQRdHgS6MxNB8+AV1x4D+YcEsZfrh/fTDoyaTfZ2iJrNBNU7SQo/1bF1NaQmpA==
X-Received: by 2002:a17:90b:2ec7:b0:2fe:85f0:e115 with SMTP id 98e67ed59e1d1-32517b2f78dmr22523237a91.26.1756274947040;
        Tue, 26 Aug 2025 23:09:07 -0700 (PDT)
Received: from werdna.flets-west.jp (i118-17-115-173.s41.a027.ap.plala.or.jp. [118.17.115.173])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-7709434d708sm8407882b3a.99.2025.08.26.23.09.05
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 26 Aug 2025 23:09:06 -0700 (PDT)
From: Noboru Asai <asai@sijam.com>
To: linux-erofs@lists.ozlabs.org
Cc: xiang@kernel.org,
	Noboru Asai <asai@sijam.com>
Subject: [PATCH] erofs-utils: lib: rename `fallthrough` to `erofs_fallthrough`
Date: Wed, 27 Aug 2025 15:09:02 +0900
Message-ID: <20250827060902.207447-1-asai@sijam.com>
X-Mailer: git-send-email 2.51.0
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
X-Spam-Status: No, score=0.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_NONE autolearn=disabled
	version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-25) on lists.ozlabs.org

In order to fix compile errors with libxxhash,
since `fallthrough` is used in xxhash.h.

Signed-off-by: Noboru Asai <asai@sijam.com>
---
 include/erofs/defs.h | 4 ++--
 lib/namei.c          | 2 +-
 lib/rebuild.c        | 2 +-
 lib/zmap.c           | 2 +-
 4 files changed, 5 insertions(+), 5 deletions(-)

diff --git a/include/erofs/defs.h b/include/erofs/defs.h
index 0f3e754..b705149 100644
--- a/include/erofs/defs.h
+++ b/include/erofs/defs.h
@@ -370,9 +370,9 @@ unsigned long __roundup_pow_of_two(unsigned long n)
 #define __erofs_unlikely(x)    __builtin_expect(!!(x), 0)
 
 #if __has_attribute(__fallthrough__)
-# define fallthrough	__attribute__((__fallthrough__))
+# define erofs_fallthrough	__attribute__((__fallthrough__))
 #else
-# define fallthrough	do {} while (0)  /* fallthrough */
+# define erofs_fallthrough	do {} while (0)  /* fallthrough */
 #endif
 
 #ifdef __cplusplus
diff --git a/lib/namei.c b/lib/namei.c
index e0a6085..beede1e 100644
--- a/lib/namei.c
+++ b/lib/namei.c
@@ -133,7 +133,7 @@ int erofs_read_inode_from_disk(struct erofs_inode *vi)
 	switch (vi->i_mode & S_IFMT) {
 	case S_IFDIR:
 		vi->dot_omitted = (ifmt >> EROFS_I_DOT_OMITTED_BIT) & 1;
-		fallthrough;
+		erofs_fallthrough;
 	case S_IFREG:
 	case S_IFLNK:
 		vi->u.i_blkaddr = le32_to_cpu(copied.i_u.startblk_lo) |
diff --git a/lib/rebuild.c b/lib/rebuild.c
index 95a8b3f..26c572e 100644
--- a/lib/rebuild.c
+++ b/lib/rebuild.c
@@ -231,7 +231,7 @@ static int erofs_rebuild_update_inode(struct erofs_sb_info *dst_sb,
 	case S_IFCHR:
 		if (erofs_inode_is_whiteout(inode))
 			inode->i_parent->whiteouts = true;
-		fallthrough;
+		erofs_fallthrough;
 	case S_IFBLK:
 	case S_IFIFO:
 	case S_IFSOCK:
diff --git a/lib/zmap.c b/lib/zmap.c
index 916b0d2..7ab78c1 100644
--- a/lib/zmap.c
+++ b/lib/zmap.c
@@ -460,7 +460,7 @@ static int z_erofs_map_blocks_fo(struct erofs_inode *vi,
 		end = (m.lcn << lclusterbits) | m.clusterofs;
 		map->m_flags |= EROFS_MAP_FULL_MAPPED;
 		m.delta[0] = 1;
-		fallthrough;
+		erofs_fallthrough;
 	case Z_EROFS_LCLUSTER_TYPE_NONHEAD:
 		/* get the corresponding first chunk */
 		err = z_erofs_extent_lookback(&m, m.delta[0]);
-- 
2.51.0


