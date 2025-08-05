Return-Path: <linux-erofs+bounces-768-lists+linux-erofs=lfdr.de@lists.ozlabs.org>
X-Original-To: lists+linux-erofs@lfdr.de
Delivered-To: lists+linux-erofs@lfdr.de
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	by mail.lfdr.de (Postfix) with ESMTPS id 89EB8B1AD00
	for <lists+linux-erofs@lfdr.de>; Tue,  5 Aug 2025 06:02:04 +0200 (CEST)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4bx09h5HjFz3bh6;
	Tue,  5 Aug 2025 14:02:00 +1000 (AEST)
X-Original-To: linux-erofs@lists.ozlabs.org
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip=115.124.30.112
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1754366520;
	cv=none; b=dZE0Q/i5/8MnwB42VT5mlKH89YIiFbCEStaFPfps+Wfc0ilRBgP1WEHxlWOHM12UScqd0Vbl4w/SRu8MpQ87pVfxa6ACFDNF3AR56+1pTJ6n2VlzbY1OJQ0WmcTCZf+W9kNUEfADXJOm18CoFs+ZneiQ+RARdGyi3mbJI8IMsOj6LdFm5urj4oe1Bo8r3CbfjHlL9Jj95Zrj8nODOYmZm6hfCpGrbajrR+0zZbDbureU3bmfGkB+RE7OoN4Cqd0Pb4w7lWksQF+VFK2/CPYlUxyqlRGsyhhHx8uJQTY8/QObwIIR6SG2RsjlxwCor/QVH8bybYOQ30XAuBWfZZIGvA==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1754366520; c=relaxed/relaxed;
	bh=eqXwUf9fTJhdr3go57cUAxNq7LfRRLTqratmxfrUPX8=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=OtS6+RD+nNvwxHkIX5nFK/R4oC9obtyCgY4bVc2m2hSoN9aT8WPcoLCm0D0RZi/XSLL9yWZFul4eA00s07j5+hjI9fw12RODQYIHwOwNhgQUTYndX//91pIyuQegR4EGQRToafVDZiH1oFg5CWO9N4gXuu3Rm+lGPDZ88ZqaVcdLSRE1cMxTXTH4xVQ+ef7vtjO1RLGOkBkqTQAM/blZVHC0gnTk1ml1Cgzuv6R4Y10wiJLQcklU0ocssQ931LBqGORYLo3KFjbnCd5apafF720kDWWkipCpR1no2fKeBbq1PhGrphZ/9SFOsCnKq7dS6ju5LPnARU4zCn+hWwwpDg==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com; dkim=pass (1024-bit key; unprotected) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.a=rsa-sha256 header.s=default header.b=imLpCh2q; dkim-atps=neutral; spf=pass (client-ip=115.124.30.112; helo=out30-112.freemail.mail.aliyun.com; envelope-from=hsiangkao@linux.alibaba.com; receiver=lists.ozlabs.org) smtp.mailfrom=linux.alibaba.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (1024-bit key; unprotected) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.a=rsa-sha256 header.s=default header.b=imLpCh2q;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=linux.alibaba.com (client-ip=115.124.30.112; helo=out30-112.freemail.mail.aliyun.com; envelope-from=hsiangkao@linux.alibaba.com; receiver=lists.ozlabs.org)
Received: from out30-112.freemail.mail.aliyun.com (out30-112.freemail.mail.aliyun.com [115.124.30.112])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4bx09f2Fplz3064
	for <linux-erofs@lists.ozlabs.org>; Tue,  5 Aug 2025 14:01:56 +1000 (AEST)
DKIM-Signature:v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=linux.alibaba.com; s=default;
	t=1754366512; h=From:To:Subject:Date:Message-ID:MIME-Version;
	bh=eqXwUf9fTJhdr3go57cUAxNq7LfRRLTqratmxfrUPX8=;
	b=imLpCh2qH0g4cl3jknvpqrQuFoPkNQEAMGDLCNu/R0VJRKpHLdkHM9mDsLLmM8wLuNJ9+/xTiluTMAQf5e5xBYbIM2Nr3+vqFl72Jt55D7wRlnDJjoQQXDdFCCTJravwvCTldgFPWbh0c+Mb8sqeM90fD7EIfcckWysmQQJec/0=
Received: from x31i01179.sqa.na131.tbsite.net(mailfrom:hsiangkao@linux.alibaba.com fp:SMTPD_---0Wl3YRXZ_1754366507 cluster:ay36)
          by smtp.aliyun-inc.com;
          Tue, 05 Aug 2025 12:01:50 +0800
From: Gao Xiang <hsiangkao@linux.alibaba.com>
To: linux-erofs@lists.ozlabs.org
Cc: Gao Xiang <hsiangkao@linux.alibaba.com>
Subject: [PATCH] erofs-utils: fuse: fix compile error with older libfuse versions
Date: Tue,  5 Aug 2025 12:01:46 +0800
Message-ID: <20250805040146.3122204-1-hsiangkao@linux.alibaba.com>
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
	SPF_HELO_NONE,SPF_PASS,UNPARSEABLE_RELAY,USER_IN_DEF_DKIM_WL,
	USER_IN_DEF_SPF_WL autolearn=disabled version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-25) on lists.ozlabs.org

Fixes: a43529e6c912 ("erofs-utils: fuse: kernel caching for readdir")
Signed-off-by: Gao Xiang <hsiangkao@linux.alibaba.com>
---
 configure.ac | 5 +++++
 fuse/main.c  | 4 ++++
 2 files changed, 9 insertions(+)

diff --git a/configure.ac b/configure.ac
index 2d42b1f..da6ae48 100644
--- a/configure.ac
+++ b/configure.ac
@@ -403,6 +403,11 @@ AS_IF([test "x$enable_fuse" != "xno"], [
       have_fuse="yes"
     ], [have_fuse="no"])
   ])
+  AC_CHECK_MEMBERS([struct fuse_file_info.cache_readdir, struct fuse_file_info.keep_cache],
+    [], [], [[
+#include <fuse.h>
+  ]])
+
   LIBS="${saved_LIBS}"
   CPPFLAGS="${saved_CPPFLAGS}"], [have_fuse="no"])
 
diff --git a/fuse/main.c b/fuse/main.c
index c754805..c129a0c 100644
--- a/fuse/main.c
+++ b/fuse/main.c
@@ -301,8 +301,12 @@ static void erofsfuse_opendir(fuse_req_t req, fuse_ino_t ino,
 	}
 
 	fi->fh = (uint64_t)vi;
+#ifdef HAVE_STRUCT_FUSE_FILE_INFO_CACHE_READDIR
 	fi->cache_readdir = 1;
+#endif
+#ifdef HAVE_STRUCT_FUSE_FILE_INFO_KEEP_CACHE
 	fi->keep_cache = 1;
+#endif
 	fuse_reply_open(req, fi);
 	return;
 
-- 
2.43.5


