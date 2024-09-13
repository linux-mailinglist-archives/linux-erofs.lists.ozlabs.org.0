Return-Path: <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>
X-Original-To: lists+linux-erofs@lfdr.de
Delivered-To: lists+linux-erofs@lfdr.de
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2404:9400:2:0:216:3eff:fee1:b9f1])
	by mail.lfdr.de (Postfix) with ESMTPS id 8BC4597796E
	for <lists+linux-erofs@lfdr.de>; Fri, 13 Sep 2024 09:21:17 +0200 (CEST)
Received: from boromir.ozlabs.org (localhost [IPv6:::1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4X4m2228rLz2ypj
	for <lists+linux-erofs@lfdr.de>; Fri, 13 Sep 2024 17:21:14 +1000 (AEST)
X-Original-To: linux-erofs@lists.ozlabs.org
Delivered-To: linux-erofs@lists.ozlabs.org
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip=115.124.30.119
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1726212071;
	cv=none; b=oywm48VkvWI7NZWMkJhst9RZS8Z7sqD3SLrLr/hE4Qft8trhZEWUswo/RZpaxFrKp3TgwT7ntTYLbAUXP5t2nEqA3ognHpm/c27XeLLHdCoNvB3r8JtL76f0pFoA9y8ukDtgPjUWotM31NFu34J33X3zuITeBGyMsL+Rj4hVlwyw/bjawEVRrIbHEzQClthI7PKUI9/9GeG94/gUIRe7cmCOtgkWQ8qt/cbUWPS7IGN/Nk2xXPsayGX+kERPCxGGBPDrKs8vepyha1Fk2Isg0yLVTTyzdupLrLziyHlEyjtb7zbeIOw4zEPwpXWRkbAEI8ufs3LFs4yZ/jBz5u6e2w==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1726212071; c=relaxed/relaxed;
	bh=Oq+4UMzGkKKAFJxXUHYdbnn8FTsWA2uYXys+jktwC8s=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=mef82MuolSRFBJqShvFonO9uBM9xU2RRElyn3nDwVxG+1HvX9wCboxlegfOnf7HjQj1ioKajslIRcL7kj712vCLpqelavjl9xs0fxw6nIUhW/alwIrucvbEHgsUhLdeKbIAyuUYncFTykWxRgeyhhUv0QlCjSL2dGnpgp3MjzjR+zZmXqvzyFPow9FW2dsAkLirzikeHvAE+08IDSALBXoSwVnxPhTwrCGBOadCU1tXg0Xe5AOzbKXzYlJjJU5qRxSTxhUHNBEgA2sCcah32GtGwTq8jLsoXCxtAtidhFvs09gD06kxmbVEi9VGrCtwO/DUPZHvS3+XXEn916pUNBA==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com; dkim=pass (1024-bit key; unprotected) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.a=rsa-sha256 header.s=default header.b=t8aOQ7cv; dkim-atps=neutral; spf=pass (client-ip=115.124.30.119; helo=out30-119.freemail.mail.aliyun.com; envelope-from=hongzhen@linux.alibaba.com; receiver=lists.ozlabs.org) smtp.mailfrom=linux.alibaba.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (1024-bit key; unprotected) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.a=rsa-sha256 header.s=default header.b=t8aOQ7cv;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=linux.alibaba.com (client-ip=115.124.30.119; helo=out30-119.freemail.mail.aliyun.com; envelope-from=hongzhen@linux.alibaba.com; receiver=lists.ozlabs.org)
Received: from out30-119.freemail.mail.aliyun.com (out30-119.freemail.mail.aliyun.com [115.124.30.119])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4X4m1y39Lqz2ydR
	for <linux-erofs@lists.ozlabs.org>; Fri, 13 Sep 2024 17:21:07 +1000 (AEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=linux.alibaba.com; s=default;
	t=1726212062; h=From:To:Subject:Date:Message-ID:MIME-Version;
	bh=Oq+4UMzGkKKAFJxXUHYdbnn8FTsWA2uYXys+jktwC8s=;
	b=t8aOQ7cvy6Gue836VnXjhkDOClDjNgoCe8qTFJ+O1k8G993vcgIpbyn74cZb6CcKrpYL7b/tHdR1MzvP1URHLDOTUNBVqhLl8t1q1GwpfguENp8OUa8gRdBjqNCZkzoaZ4aMuXoQxa9b+Xb6jZAYIo3qqPajKKsarl4c4JPCABU=
Received: from localhost(mailfrom:hongzhen@linux.alibaba.com fp:SMTPD_---0WEtzALS_1726212061)
          by smtp.aliyun-inc.com;
          Fri, 13 Sep 2024 15:21:02 +0800
From: Hongzhen Luo <hongzhen@linux.alibaba.com>
To: linux-erofs@lists.ozlabs.org
Subject: [PATCH v10 1/2] erofs-utils: lib: expose erofs_xattr_prefix_matches()
Date: Fri, 13 Sep 2024 15:20:59 +0800
Message-ID: <20240913072100.577753-1-hongzhen@linux.alibaba.com>
X-Mailer: git-send-email 2.43.5
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-BeenThere: linux-erofs@lists.ozlabs.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: Development of Linux EROFS file system <linux-erofs.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linux-erofs>,
 <mailto:linux-erofs-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linux-erofs/>
List-Post: <mailto:linux-erofs@lists.ozlabs.org>
List-Help: <mailto:linux-erofs-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linux-erofs>,
 <mailto:linux-erofs-request@lists.ozlabs.org?subject=subscribe>
Errors-To: linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org
Sender: "Linux-erofs" <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>

Prepare for the feature of exporting extended attributes for
`fsck.erofs`.

Signed-off-by: Hongzhen Luo <hongzhen@linux.alibaba.com>
---
v5: No changes.
v4: https://lore.kernel.org/all/20240913064913.537850-1-hongzhen@linux.alibaba.com/
v3: https://lore.kernel.org/all/20240912131108.3742683-1-hongzhen@linux.alibaba.com/
v2: https://lore.kernel.org/all/20240906095853.3167228-1-hongzhen@linux.alibaba.com/
v1: https://lore.kernel.org/all/20240906083849.3090392-1-hongzhen@linux.alibaba.com/
---
 include/erofs/xattr.h |  3 +++
 lib/xattr.c           | 12 +++++++-----
 2 files changed, 10 insertions(+), 5 deletions(-)

diff --git a/include/erofs/xattr.h b/include/erofs/xattr.h
index 7643611..804f565 100644
--- a/include/erofs/xattr.h
+++ b/include/erofs/xattr.h
@@ -61,6 +61,9 @@ void erofs_clear_opaque_xattr(struct erofs_inode *inode);
 int erofs_set_origin_xattr(struct erofs_inode *inode);
 int erofs_read_xattrs_from_disk(struct erofs_inode *inode);
 
+bool erofs_xattr_prefix_matches(const char *key, unsigned int *index,
+				unsigned int *len);
+
 #ifdef __cplusplus
 }
 #endif
diff --git a/lib/xattr.c b/lib/xattr.c
index 9f31f2d..63c7fce 100644
--- a/lib/xattr.c
+++ b/lib/xattr.c
@@ -138,8 +138,8 @@ struct ea_type_node {
 static LIST_HEAD(ea_name_prefixes);
 static unsigned int ea_prefix_count;
 
-static bool match_prefix(const char *key, unsigned int *index,
-			 unsigned int *len)
+bool erofs_xattr_prefix_matches(const char *key, unsigned int *index,
+				unsigned int *len)
 {
 	struct xattr_prefix *p;
 
@@ -196,7 +196,8 @@ static struct xattr_item *get_xattritem(char *kvbuf, unsigned int len[2])
 	if (!item)
 		return ERR_PTR(-ENOMEM);
 
-	if (!match_prefix(kvbuf, &item->base_index, &item->prefix_len)) {
+	if (!erofs_xattr_prefix_matches(kvbuf, &item->base_index,
+					&item->prefix_len)) {
 		free(item);
 		return ERR_PTR(-ENODATA);
 	}
@@ -1425,7 +1426,7 @@ int erofs_getxattr(struct erofs_inode *vi, const char *name, char *buffer,
 	if (ret)
 		return ret;
 
-	if (!match_prefix(name, &prefix, &prefixlen))
+	if (!erofs_xattr_prefix_matches(name, &prefix, &prefixlen))
 		return -ENODATA;
 
 	it.it.sbi = vi->sbi;
@@ -1600,7 +1601,8 @@ int erofs_xattr_insert_name_prefix(const char *prefix)
 	if (!tnode)
 		return -ENOMEM;
 
-	if (!match_prefix(prefix, &tnode->base_index, &tnode->base_len)) {
+	if (!erofs_xattr_prefix_matches(prefix, &tnode->base_index,
+					&tnode->base_len)) {
 		free(tnode);
 		return -ENODATA;
 	}
-- 
2.43.5

