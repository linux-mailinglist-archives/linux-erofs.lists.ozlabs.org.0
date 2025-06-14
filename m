Return-Path: <linux-erofs+bounces-405-lists+linux-erofs=lfdr.de@lists.ozlabs.org>
X-Original-To: lists+linux-erofs@lfdr.de
Delivered-To: lists+linux-erofs@lfdr.de
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2404:9400:2:0:216:3eff:fee1:b9f1])
	by mail.lfdr.de (Postfix) with ESMTPS id 3EC21AD99AF
	for <lists+linux-erofs@lfdr.de>; Sat, 14 Jun 2025 04:33:20 +0200 (CEST)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4bK0gG68N0z2xS2;
	Sat, 14 Jun 2025 12:33:14 +1000 (AEST)
X-Original-To: linux-erofs@lists.ozlabs.org
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip=115.124.30.118
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1749868394;
	cv=none; b=k+bkq9xs3wcmsW+g29v6LggyXL8xRF54dj+LB7nSV1BX7g2frptE7z1dRKal34rc+9EoHQY9VdIIYudbQ/RJ2YxCVHewOt03eFFh0Xv4S8vz/WTbhW57kHHSqWoC8uJJS44bldk0A3pvyKC5lRF9TARMbD2z4I5Zmdg/4c6xvM8l030+LLEamyPb96FcT3Bv4Uq3YBLCNJElLKod9hZ1+ZHi6q+mni/lY0gNv8KDk8kV671RfNQkehcD5nLj2cG0brVTGf3S5wQ6x4093mK5wJPV0bnh8HiSKIu0A7N14Q9djufnuQHBn60o7ud2niyyQw/RWWWlMhVjLMzVASXqbw==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1749868394; c=relaxed/relaxed;
	bh=+Zp/Oyp/ryc4XKaaks5lqJQuMClnsY3iUPW4KRUKIrI=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=KXNPDxoVdjecy4fG+cvyzM7P2wABSKfXqhnTNQmHxals9uUa+yC0PAOV7dpUDRyrwMLy8WljblcI1f1wI2EYoZ2w2uwbB1kKpth100Fb7ewC7m1d/NFwFX21OAtVZ0ryHcckpw63rF6zw/Z9u7WtHSOkAXY2L//hExtG2fOnqeyDjBTzxyEKAD3fD3apyJDNGUpvyDrTK+jj9/AIGmeYRlHT7GFKfHuwOM5frbWCwIwGGhnzboJ7LP57cZpBCxcsaGS4ttvTpHK9qptGhKRhV8+No0AEhKVpEpkYmAJkrSsbWQod7h322uqD0+/5btkVi6YjoxRdPce/nTqvC/c37g==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com; dkim=pass (1024-bit key; unprotected) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.a=rsa-sha256 header.s=default header.b=WcArZsRG; dkim-atps=neutral; spf=pass (client-ip=115.124.30.118; helo=out30-118.freemail.mail.aliyun.com; envelope-from=hsiangkao@linux.alibaba.com; receiver=lists.ozlabs.org) smtp.mailfrom=linux.alibaba.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (1024-bit key; unprotected) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.a=rsa-sha256 header.s=default header.b=WcArZsRG;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=linux.alibaba.com (client-ip=115.124.30.118; helo=out30-118.freemail.mail.aliyun.com; envelope-from=hsiangkao@linux.alibaba.com; receiver=lists.ozlabs.org)
Received: from out30-118.freemail.mail.aliyun.com (out30-118.freemail.mail.aliyun.com [115.124.30.118])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4bK0gC4Zx8z2xKh
	for <linux-erofs@lists.ozlabs.org>; Sat, 14 Jun 2025 12:33:10 +1000 (AEST)
DKIM-Signature:v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=linux.alibaba.com; s=default;
	t=1749868386; h=From:To:Subject:Date:Message-ID:MIME-Version;
	bh=+Zp/Oyp/ryc4XKaaks5lqJQuMClnsY3iUPW4KRUKIrI=;
	b=WcArZsRGzzUr2Xj8E8303/bVY1Eyegc+AhlUoO0ZmObEeR8z282bmvnCs/GUvfHm64cSgukFtrMENyQx0LNyEIfUbuHXs0N05pGxatogtkTEMHvdQnnfzN74iVE8lXuxiFYSH/EHcl7oV2cNmv4OoOXSy6JpBJLbBB/7LO7qKz8=
Received: from x31i01179.sqa.na131.tbsite.net(mailfrom:hsiangkao@linux.alibaba.com fp:SMTPD_---0Wdm5aFX_1749868384 cluster:ay36)
          by smtp.aliyun-inc.com;
          Sat, 14 Jun 2025 10:33:05 +0800
From: Gao Xiang <hsiangkao@linux.alibaba.com>
To: linux-erofs@lists.ozlabs.org
Cc: Gao Xiang <hsiangkao@linux.alibaba.com>
Subject: [PATCH 2/3] erofs-utils: mkfs: limit the default asynchronous queue size
Date: Sat, 14 Jun 2025 10:32:58 +0800
Message-ID: <20250614023259.1688845-2-hsiangkao@linux.alibaba.com>
X-Mailer: git-send-email 2.43.5
In-Reply-To: <20250614023259.1688845-1-hsiangkao@linux.alibaba.com>
References: <20250614023259.1688845-1-hsiangkao@linux.alibaba.com>
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

Limit the default asynchronous queue size based on the maximum file
descriptor limit.

Otherwise, exceeding the FD limit will result in EMFILE errors.

Note that EROFS reuses the file page cache instead of duplicating all
file contents into process memory, though this is constrained by the
maximum FD limit.

Fixes: 9bd592bfed10 ("erofs-utils: mkfs: increase the maximum size of the asynchronous queue")
Signed-off-by: Gao Xiang <hsiangkao@linux.alibaba.com>
---
 configure.ac |  2 ++
 lib/inode.c  | 31 ++++++++++++++++++++++++++++++-
 2 files changed, 32 insertions(+), 1 deletion(-)

diff --git a/configure.ac b/configure.ac
index a73a9ba..5c2737c 100644
--- a/configure.ac
+++ b/configure.ac
@@ -211,6 +211,7 @@ AC_CHECK_HEADERS(m4_flatten([
 	sys/ioctl.h
 	sys/mman.h
 	sys/random.h
+	sys/resource.h
 	sys/sendfile.h
 	sys/stat.h
 	sys/statfs.h
@@ -265,6 +266,7 @@ AC_CHECK_FUNCS(m4_flatten([
 	backtrace
 	copy_file_range
 	fallocate
+	getrlimit
 	gettimeofday
 	lgetxattr
 	llistxattr
diff --git a/lib/inode.c b/lib/inode.c
index 7bd1047..39ffebc 100644
--- a/lib/inode.c
+++ b/lib/inode.c
@@ -1888,6 +1888,28 @@ static int __erofs_mkfs_build_tree(struct erofs_mkfs_buildtree_ctx *ctx)
 }
 
 #ifdef EROFS_MT_ENABLED
+
+#ifdef HAVE_SYS_RESOURCE_H
+#include <sys/resource.h>
+#endif
+
+static int erofs_get_fdlimit(void)
+{
+#if defined(HAVE_SYS_RESOURCE_H) && defined(HAVE_GETRLIMIT)
+	struct rlimit rlim;
+	int err;
+
+	err = getrlimit(RLIMIT_NOFILE, &rlim);
+	if (err < 0)
+		return _POSIX_OPEN_MAX;
+	if (rlim.rlim_cur == RLIM_INFINITY)
+		return 0;
+	return rlim.rlim_cur;
+#else
+	return _POSIX_OPEN_MAX;
+#endif
+}
+
 static int erofs_mkfs_build_tree(struct erofs_mkfs_buildtree_ctx *ctx)
 {
 	struct erofs_mkfs_dfops *q;
@@ -1898,7 +1920,14 @@ static int erofs_mkfs_build_tree(struct erofs_mkfs_buildtree_ctx *ctx)
 	if (!q)
 		return -ENOMEM;
 
-	q->entries = cfg.c_mt_async_queue_limit ?: 32768;
+	if (cfg.c_mt_async_queue_limit) {
+		q->entries = cfg.c_mt_async_queue_limit;
+	} else {
+		err = roundup_pow_of_two(erofs_get_fdlimit()) >> 1;
+		q->entries = err && err < 32768 ? err : 32768;
+	}
+	erofs_dbg("Set the asynchronous queue size to %u", q->entries);
+
 	q->queue = malloc(q->entries * sizeof(*q->queue));
 	if (!q->queue) {
 		free(q);
-- 
2.43.5


