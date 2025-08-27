Return-Path: <linux-erofs+bounces-918-lists+linux-erofs=lfdr.de@lists.ozlabs.org>
X-Original-To: lists+linux-erofs@lfdr.de
Delivered-To: lists+linux-erofs@lfdr.de
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	by mail.lfdr.de (Postfix) with ESMTPS id 47C00B37A41
	for <lists+linux-erofs@lfdr.de>; Wed, 27 Aug 2025 08:22:58 +0200 (CEST)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4cBZG73LFTz30W9;
	Wed, 27 Aug 2025 16:22:55 +1000 (AEST)
X-Original-To: linux-erofs@lists.ozlabs.org
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip="2607:f8b0:4864:20::530"
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1756275775;
	cv=none; b=WQBCbOqun44r91l9kJY1ip8Nrny2Sa0MVz0lSUMbX2yEfACIIkp7RjlBGpkvbBJpKGBIcC9qZti4OKEQumTE1Loh7Z1Ob1p6tC8Of0stJLdkLWycr1YvLcB7xtWG+wPAuNzaqg/y9upTsSjBj8/RyxzzlzmzcVCsJ+jPqLsyFDc2Snpr3uMc7bqFafaw5mgIXZ/b82q0IqIo+n/lO5qgs9l9XU3qCyEqwhkDEjl1+Z+y0AKnm+CdUDODjPQE7N6mvPd844hICNq7cFjdRkKljjSy3kXDizHJ92Lzsc8pSNxflM+g6mP6DkPRZHy6Ld7VfrQgYxYqHlcng56Vb/bz/w==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1756275775; c=relaxed/relaxed;
	bh=6kGJcSbF1Ktb6QjWEGXdjs5XR54l9rpMSu7MaUH5XUs=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=bTxb7O664ZHXqrkAvtdAiOp9B+SR0zE6RHnufet4/1ZzAFdcCY0bpAWuZDLGXCwpifvHGBfcMyDi8G6O6hC/+pg2LjXO5xWWPzDLqWrqPm8BapxCFhaSNq4tL27pWd0wwsBP6yoMVbu138v1B324t9jYCq4hgT4OhL5pvOV31bS1WjIqjmvfdzLeMvclEs5n2P0dgBQ+0edi4gzfP5c1VIIZUy0m45qClxpgvxsZNQLbNg+bVOZRWi8kiVaeqsdTgjSGq7riOy74uef9HAShlsBQOS4qviKVq2G5mFtTzhJdyCedk/gJ4XOHUe0ZJd5+WYLxHlbZrwCAMwTjYcFwOw==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=none (p=none dis=none) header.from=sijam.com; dkim=pass (2048-bit key; unprotected) header.d=sijam-com.20230601.gappssmtp.com header.i=@sijam-com.20230601.gappssmtp.com header.a=rsa-sha256 header.s=20230601 header.b=f1dshkCT; dkim-atps=neutral; spf=none (client-ip=2607:f8b0:4864:20::530; helo=mail-pg1-x530.google.com; envelope-from=asai@sijam.com; receiver=lists.ozlabs.org) smtp.mailfrom=sijam.com
Authentication-Results: lists.ozlabs.org; dmarc=none (p=none dis=none) header.from=sijam.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=sijam-com.20230601.gappssmtp.com header.i=@sijam-com.20230601.gappssmtp.com header.a=rsa-sha256 header.s=20230601 header.b=f1dshkCT;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=none (no SPF record) smtp.mailfrom=sijam.com (client-ip=2607:f8b0:4864:20::530; helo=mail-pg1-x530.google.com; envelope-from=asai@sijam.com; receiver=lists.ozlabs.org)
Received: from mail-pg1-x530.google.com (mail-pg1-x530.google.com [IPv6:2607:f8b0:4864:20::530])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4cBZG648h3z30T8
	for <linux-erofs@lists.ozlabs.org>; Wed, 27 Aug 2025 16:22:53 +1000 (AEST)
Received: by mail-pg1-x530.google.com with SMTP id 41be03b00d2f7-b4717543ed9so4354894a12.3
        for <linux-erofs@lists.ozlabs.org>; Tue, 26 Aug 2025 23:22:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=sijam-com.20230601.gappssmtp.com; s=20230601; t=1756275771; x=1756880571; darn=lists.ozlabs.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=6kGJcSbF1Ktb6QjWEGXdjs5XR54l9rpMSu7MaUH5XUs=;
        b=f1dshkCTthY7LbmcKgWIDH+mMn7j65fqHKp6YXheJ9T8Xi8QDF22HYnj77VLrzHwrD
         cX3bE4OicygW5ELWUXPsE1W0I8NbGqUyIxpNM4Q0vHbwVp9tbpAKdttCM/+bQbDjkGPr
         o7DE+JCpju/2JPrA2GI5wyqoxIHF8e+pGaCXDzgpRTevm1Z/8THEG6jOR6rDxf5bbDxC
         Sz5xmDk/FMeTXrH795DwV1zFMZxCBl3Sw6p5Wlap1eVfWsBfmTyj03XYXxPUiIxhoHXu
         ArhWCYm4s/+WkPbqELBlND7XxTaOiqv+t3sP+V5uEyRWrl4Tdio46t0P5BpfivQ5EI9F
         LS5Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1756275771; x=1756880571;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=6kGJcSbF1Ktb6QjWEGXdjs5XR54l9rpMSu7MaUH5XUs=;
        b=BHFYd36UUvkY6xdDBBWt8ZepqgHfKBlp8NVo2YfroTjfPQD0Q+fp3usrcd2xxEE+2e
         gY0JNQt0JL+QN4cvSQl77ZGFlO37Sfx69Mj2WxSDD03WTHgJLm8qnaZotBD8X4K8S648
         pIMZDg3vCt6jULYyyvmt0eXWFYeXEiIc0SjnnsGeaVdmhautvyVJ3lsqsmALhvUNWYqM
         YZ67kT3RApJjp5NbI53NAUKCpbzmWsCGHgr7C6Drj80tmEwe11igP1gcSCKzsztr5rpW
         as3HsO1KB6c0xnrzZNOe82d6r0todmR61vBdlgrlwkOHMkIhy1aG4kqP9/sWcET/Irht
         9mZw==
X-Gm-Message-State: AOJu0Yxb4g4cfzQL3Kmj/aV+DplUL96Q/0Ot8XGbhXV1qRKH0z7fxHmJ
	C7gXxC5l+dxSF2rT3UcE2MHgnKz11DuwBs3AChUtofwHWrbZxUoXZWUCbLI1qPAKXEWmX+ixoRo
	jGCte
X-Gm-Gg: ASbGncsbZLhJZZz5r25F2RtOFNhKbZZGXZr4uVSFFwIqjKrd5q+66u6Xiu19YN8vGoY
	+3mtNtMKdHy/1i/jgrL83mpBPAszADZBM/JUWEBUSizDzelQgpDYtKkMAudd+W+vThLv9Tv4uur
	ll89k6v7H9a47iH+l8DrQoq3wh0Nf/4W/qdcMByAEwh6pt3zEWEJBSMqL9l5Cy1KcaSB2FzTpyy
	WptXvr6FEY854GEwR5SyjtktyAZWXYiUll/ICeu9MJdkGXSUnF0QR6m8R186J99eWRk7DSUPHDh
	KWWuuyLQzJG1fanOgKXgiGnwLHAQnur4GUVulmJ5klMZjZCwSNEzRs1QFOgGSfJ8/Ro2ELDAVCj
	BihJcUkXHU0V/p2tCIgDaSG4gg8Flrb/R+XYIOH0aJ4KbZipsoW3693GNb1YVGoU+M/YJ5veI
X-Google-Smtp-Source: AGHT+IFPRSaao741dWwUZS9IlEAhJaBUbgTz2YmN6Sm2tB7uJqMPpl8GTeyTXeLEh/NGs+DkaTxcFg==
X-Received: by 2002:a17:902:e890:b0:246:bcf4:c82d with SMTP id d9443c01a7336-246bcf4cc37mr138311015ad.52.1756275771141;
        Tue, 26 Aug 2025 23:22:51 -0700 (PDT)
Received: from werdna.flets-west.jp (i118-17-115-173.s41.a027.ap.plala.or.jp. [118.17.115.173])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2466885efc8sm112507465ad.90.2025.08.26.23.22.49
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 26 Aug 2025 23:22:50 -0700 (PDT)
From: Noboru Asai <asai@sijam.com>
To: linux-erofs@lists.ozlabs.org
Cc: xiang@kernel.org,
	Noboru Asai <asai@sijam.com>
Subject: [PATCH v2] erofs-utils: lib: rename `fallthrough` to `__erofs_fallthrough`
Date: Wed, 27 Aug 2025 15:22:35 +0900
Message-ID: <20250827062235.213715-1-asai@sijam.com>
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
Changes since v1:
- from `erofs_fallthrough` to `__erofs_fallthrough`
---
 include/erofs/defs.h | 4 ++--
 lib/namei.c          | 2 +-
 lib/rebuild.c        | 2 +-
 lib/zmap.c           | 2 +-
 4 files changed, 5 insertions(+), 5 deletions(-)

diff --git a/include/erofs/defs.h b/include/erofs/defs.h
index 0f3e754..2ae0cbe 100644
--- a/include/erofs/defs.h
+++ b/include/erofs/defs.h
@@ -370,9 +370,9 @@ unsigned long __roundup_pow_of_two(unsigned long n)
 #define __erofs_unlikely(x)    __builtin_expect(!!(x), 0)
 
 #if __has_attribute(__fallthrough__)
-# define fallthrough	__attribute__((__fallthrough__))
+# define __erofs_fallthrough	__attribute__((__fallthrough__))
 #else
-# define fallthrough	do {} while (0)  /* fallthrough */
+# define __erofs_fallthrough	do {} while (0)  /* fallthrough */
 #endif
 
 #ifdef __cplusplus
diff --git a/lib/namei.c b/lib/namei.c
index e0a6085..896e348 100644
--- a/lib/namei.c
+++ b/lib/namei.c
@@ -133,7 +133,7 @@ int erofs_read_inode_from_disk(struct erofs_inode *vi)
 	switch (vi->i_mode & S_IFMT) {
 	case S_IFDIR:
 		vi->dot_omitted = (ifmt >> EROFS_I_DOT_OMITTED_BIT) & 1;
-		fallthrough;
+		__erofs_fallthrough;
 	case S_IFREG:
 	case S_IFLNK:
 		vi->u.i_blkaddr = le32_to_cpu(copied.i_u.startblk_lo) |
diff --git a/lib/rebuild.c b/lib/rebuild.c
index 95a8b3f..0358567 100644
--- a/lib/rebuild.c
+++ b/lib/rebuild.c
@@ -231,7 +231,7 @@ static int erofs_rebuild_update_inode(struct erofs_sb_info *dst_sb,
 	case S_IFCHR:
 		if (erofs_inode_is_whiteout(inode))
 			inode->i_parent->whiteouts = true;
-		fallthrough;
+		__erofs_fallthrough;
 	case S_IFBLK:
 	case S_IFIFO:
 	case S_IFSOCK:
diff --git a/lib/zmap.c b/lib/zmap.c
index 916b0d2..61cddb2 100644
--- a/lib/zmap.c
+++ b/lib/zmap.c
@@ -460,7 +460,7 @@ static int z_erofs_map_blocks_fo(struct erofs_inode *vi,
 		end = (m.lcn << lclusterbits) | m.clusterofs;
 		map->m_flags |= EROFS_MAP_FULL_MAPPED;
 		m.delta[0] = 1;
-		fallthrough;
+		__erofs_fallthrough;
 	case Z_EROFS_LCLUSTER_TYPE_NONHEAD:
 		/* get the corresponding first chunk */
 		err = z_erofs_extent_lookback(&m, m.delta[0]);
-- 
2.51.0


