Return-Path: <linux-erofs+bounces-1599-lists+linux-erofs=lfdr.de@lists.ozlabs.org>
X-Original-To: lists+linux-erofs@lfdr.de
Delivered-To: lists+linux-erofs@lfdr.de
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2404:9400:21b9:f100::1])
	by mail.lfdr.de (Postfix) with ESMTPS id BC201CDD00B
	for <lists+linux-erofs@lfdr.de>; Wed, 24 Dec 2025 19:32:06 +0100 (CET)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4dc0pM1dc3z2yVP;
	Thu, 25 Dec 2025 05:31:55 +1100 (AEDT)
X-Original-To: linux-erofs@lists.ozlabs.org
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip=115.124.30.101
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1766601115;
	cv=none; b=YdHpPFDrQSZC8d5S2VcJ0e9jYHPSARCtwKDL62fCHgJ5WayiIwpFSbwoQOtdZl2NCIRN3neEHWHHtlyQXTwRern2wMvcT1ieqAkEI0YZhqVt2IoGxhTidcaCvq/hanQC3Ij59Mp6U93dWEp5vypmFk/zd70PJsE+lNfIPmEmN4rnO9mO/ZAcgChszZO6HkMnJys9gAWFfvvSSGUQM+xsDRmGW/+f2YLda6kqOcz3OJPI60ZUamY2LuD77yPYfHTcFfam4W1fV9T4pfw+zBD7h9SjIlB24Go1QxcEMhvwXyTBlaIz8UCN6VlmzPxMClXW867XFQSuWgCboCV1HysHzQ==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1766601115; c=relaxed/relaxed;
	bh=QurGb1AQoNicrGyprIu+jRQT5lvXuoXYpYtPu75piFA=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=I+lExzFZXAZT/5jQ9KDs6reYZXcdYyQgwGp8cRkK2poaxEdh+jY2Ebc75UlilFxGmyGU40e15TFK0rq2U5JaielItuZYvUaLTNO6qC4roJ09fms/B9+Yv4viGN7T/wfDe5mVoHq8lGO3+Afy9Jy7PX7ioQzi5G7N4uEyPurB2shHqOrYrX68gXcR1NStMy4u3k8IDX9IV0zYTCcdOS2Igpqk5BWs5rocwMzex9X97XRJaa20n/QjTzJFXin1KxEEGBiigJNXgwHkie3TF3//9Xk7SFQidEsX32Xv5ysnp9hTaSEX8L7DSAiZKnjtBLSa+ho41q97207upEUeHDshGQ==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com; dkim=pass (1024-bit key; unprotected) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.a=rsa-sha256 header.s=default header.b=CXJHcxc8; dkim-atps=neutral; spf=pass (client-ip=115.124.30.101; helo=out30-101.freemail.mail.aliyun.com; envelope-from=hsiangkao@linux.alibaba.com; receiver=lists.ozlabs.org) smtp.mailfrom=linux.alibaba.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (1024-bit key; unprotected) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.a=rsa-sha256 header.s=default header.b=CXJHcxc8;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=linux.alibaba.com (client-ip=115.124.30.101; helo=out30-101.freemail.mail.aliyun.com; envelope-from=hsiangkao@linux.alibaba.com; receiver=lists.ozlabs.org)
Received: from out30-101.freemail.mail.aliyun.com (out30-101.freemail.mail.aliyun.com [115.124.30.101])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4dc0pL1mSbz2yTH
	for <linux-erofs@lists.ozlabs.org>; Thu, 25 Dec 2025 05:31:53 +1100 (AEDT)
DKIM-Signature:v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=linux.alibaba.com; s=default;
	t=1766601109; h=From:To:Subject:Date:Message-ID:MIME-Version;
	bh=QurGb1AQoNicrGyprIu+jRQT5lvXuoXYpYtPu75piFA=;
	b=CXJHcxc88uimGAvjUTYuiuc36xu6zg68lK2fBYAYBcA0QNlltczJvtqxJ1JC7r6saVlW4C2fuI/5hwS0t1vgEFpT4nOIP8cfQnsYZ2ix1cIoP+8dzEdSq+K2TMCL7LUVyECgiDimfJV/n4p1Uy/rbsR9gQHDQEWe4x5FOTf414U=
Received: from x31i01179.sqa.na131.tbsite.net(mailfrom:hsiangkao@linux.alibaba.com fp:SMTPD_---0Wvc8152_1766601107 cluster:ay36)
          by smtp.aliyun-inc.com;
          Thu, 25 Dec 2025 02:31:48 +0800
From: Gao Xiang <hsiangkao@linux.alibaba.com>
To: linux-erofs@lists.ozlabs.org
Cc: Gao Xiang <hsiangkao@linux.alibaba.com>
Subject: [PATCH 9/9] erofs-utils: lib: remove ENOATTR definition
Date: Thu, 25 Dec 2025 02:31:31 +0800
Message-ID: <20251224183131.2302377-9-hsiangkao@linux.alibaba.com>
X-Mailer: git-send-email 2.43.5
In-Reply-To: <20251224183131.2302377-1-hsiangkao@linux.alibaba.com>
References: <20251224183131.2302377-1-hsiangkao@linux.alibaba.com>
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

Source kernel commit: 7ca972a2dca29926928baa5a57de00748ce4ca0c

Signed-off-by: Gao Xiang <hsiangkao@linux.alibaba.com>
---
 include/erofs/xattr.h |  4 ----
 lib/xattr.c           | 28 ++++++++++++++--------------
 2 files changed, 14 insertions(+), 18 deletions(-)

diff --git a/include/erofs/xattr.h b/include/erofs/xattr.h
index 3ec51bad5175..83aca44f8e44 100644
--- a/include/erofs/xattr.h
+++ b/include/erofs/xattr.h
@@ -9,10 +9,6 @@ extern "C"
 
 #include "internal.h"
 
-#ifndef ENOATTR
-#define ENOATTR	ENODATA
-#endif
-
 static inline unsigned int inlinexattr_header_size(struct erofs_inode *vi)
 {
 	return sizeof(struct erofs_xattr_ibody_header) +
diff --git a/lib/xattr.c b/lib/xattr.c
index 6598845ed46d..e991c56e384d 100644
--- a/lib/xattr.c
+++ b/lib/xattr.c
@@ -1135,7 +1135,7 @@ static int erofs_init_inode_xattrs(struct erofs_inode *vi)
 			DBG_BUGON(1);
 			return -EFSCORRUPTED;	/* xattr ondisk layout error */
 		}
-		return -ENOATTR;
+		return -ENODATA;
 	}
 
 	it.buf = __EROFS_BUF_INITIALIZER;
@@ -1263,20 +1263,20 @@ static int erofs_getxattr_foreach(struct erofs_xattr_iter *it)
 			(entry.e_name_index & EROFS_XATTR_LONG_PREFIX_MASK);
 
 		if (pf >= sbi->xattr_prefixes + sbi->xattr_prefix_count)
-			return -ENOATTR;
+			return -ENODATA;
 
 		if (it->index != pf->prefix->base_index ||
 		    it->len != entry.e_name_len + pf->infix_len)
-			return -ENOATTR;
+			return -ENODATA;
 
 		if (memcmp(it->name, pf->prefix->infix, pf->infix_len))
-			return -ENOATTR;
+			return -ENODATA;
 
 		it->infix_len = pf->infix_len;
 	} else {
 		if (it->index != entry.e_name_index ||
 		    it->len != entry.e_name_len)
-			return -ENOATTR;
+			return -ENODATA;
 
 		it->infix_len = 0;
 	}
@@ -1292,7 +1292,7 @@ static int erofs_getxattr_foreach(struct erofs_xattr_iter *it)
 			      entry.e_name_len - processed);
 		if (memcmp(it->name + it->infix_len + processed,
 			   it->kaddr, slice))
-			return -ENOATTR;
+			return -ENODATA;
 		it->pos += slice;
 	}
 
@@ -1319,7 +1319,7 @@ static int erofs_xattr_iter_inline(struct erofs_xattr_iter *it,
 			sizeof(u32) * vi->xattr_shared_count;
 	if (xattr_header_sz >= vi->xattr_isize) {
 		DBG_BUGON(xattr_header_sz > vi->xattr_isize);
-		return -ENOATTR;
+		return -ENODATA;
 	}
 
 	remaining = vi->xattr_isize - xattr_header_sz;
@@ -1342,7 +1342,7 @@ static int erofs_xattr_iter_inline(struct erofs_xattr_iter *it,
 			ret = erofs_getxattr_foreach(it);
 		else
 			ret = erofs_listxattr_foreach(it);
-		if ((getxattr && ret != -ENOATTR) || (!getxattr && ret))
+		if ((getxattr && ret != -ENODATA) || (!getxattr && ret))
 			break;
 
 		it->pos = next_pos;
@@ -1355,7 +1355,7 @@ static int erofs_xattr_iter_shared(struct erofs_xattr_iter *it,
 {
 	struct erofs_sb_info *sbi = vi->sbi;
 	unsigned int i;
-	int ret = -ENOATTR;
+	int ret = -ENODATA;
 
 	for (i = 0; i < vi->xattr_shared_count; ++i) {
 		it->pos = erofs_pos(sbi, sbi->xattr_blkaddr) +
@@ -1368,7 +1368,7 @@ static int erofs_xattr_iter_shared(struct erofs_xattr_iter *it,
 			ret = erofs_getxattr_foreach(it);
 		else
 			ret = erofs_listxattr_foreach(it);
-		if ((getxattr && ret != -ENOATTR) || (!getxattr && ret))
+		if ((getxattr && ret != -ENODATA) || (!getxattr && ret))
 			break;
 	}
 	return ret;
@@ -1404,7 +1404,7 @@ int erofs_getxattr(struct erofs_inode *vi, const char *name, char *buffer,
 	it.buffer_ofs = 0;
 
 	ret = erofs_xattr_iter_inline(&it, vi, true);
-	if (ret == -ENOATTR)
+	if (ret == -ENODATA)
 		ret = erofs_xattr_iter_shared(&it, vi, true);
 	erofs_put_metabuf(&it.buf);
 	return ret ? ret : it.buffer_ofs;
@@ -1416,7 +1416,7 @@ int erofs_listxattr(struct erofs_inode *vi, char *buffer, size_t buffer_size)
 	struct erofs_xattr_iter it;
 
 	ret = erofs_init_inode_xattrs(vi);
-	if (ret == -ENOATTR)
+	if (ret == -ENODATA)
 		return 0;
 	if (ret)
 		return ret;
@@ -1429,9 +1429,9 @@ int erofs_listxattr(struct erofs_inode *vi, char *buffer, size_t buffer_size)
 	it.buffer_ofs = 0;
 
 	ret = erofs_xattr_iter_inline(&it, vi, false);
-	if (!ret || ret == -ENOATTR)
+	if (!ret || ret == -ENODATA)
 		ret = erofs_xattr_iter_shared(&it, vi, false);
-	if (ret == -ENOATTR)
+	if (ret == -ENODATA)
 		ret = 0;
 	erofs_put_metabuf(&it.buf);
 	return ret ? ret : it.buffer_ofs;
-- 
2.43.5


