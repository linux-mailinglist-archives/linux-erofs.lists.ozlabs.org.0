Return-Path: <linux-erofs+bounces-481-lists+linux-erofs=lfdr.de@lists.ozlabs.org>
X-Original-To: lists+linux-erofs@lfdr.de
Delivered-To: lists+linux-erofs@lfdr.de
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	by mail.lfdr.de (Postfix) with ESMTPS id D4B5BAE2926
	for <lists+linux-erofs@lfdr.de>; Sat, 21 Jun 2025 15:29:01 +0200 (CEST)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4bPZtd3Y5Cz2yF0;
	Sat, 21 Jun 2025 23:28:57 +1000 (AEST)
X-Original-To: linux-erofs@lists.ozlabs.org
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip=115.124.30.132
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1750512537;
	cv=none; b=UhLE8LJrBz7uF+wJV5HUQC/HlSJ6fLhBuS40P07gyIGP2t9o1ywrC0Rkq/W4D1TXMPRVGzQnlZqCbup1g08G78HZZAebPJVXAbMUHVS019nnL59WjG62pfjtDYLJIGvSlq/gFaudDz9GvNX6zfEMqy2eiiq5FgATTVFAOpYVBlKWVcWkQGQZCvKI/CIDPUf8ksP+J+q4n0vzSEexLIcv4FTCZLkJGwN7B7QA3TO09AuGkLvARU99r2NpU/Z78yE+i08Pp/rsKwsMSnTbmUVfTp/ji9KooQZkZgwLlkXn6A6L5bbRd4ZkLJPCVX+yvoSTwGRr3JfyHWBk7JUrNR40YA==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1750512537; c=relaxed/relaxed;
	bh=a6S+zxvGX1IZfxP9RCzs1ytrTxQnzasPnq/yLVf6yjk=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=fIRXt8bMYFlQUA8ZyWDLVr6G/RHdsFrM84PO+8aFOO87YpMNm2RjA+B8RMxw1rG39RFGQc7SvFG3NdbrRaHvDvph4LGY0NHOAKCd4ucltuqL1Z7PCRK3Ni6VuF/+Mf2LU8RtYtdshbZhdjiuBmS23rKVXSCSFIyDmaFiM26CSk12UEKJ0KIw3RzKqbefKX4VUh0s4jsMszC7ucOC+xxWMSZgHLpKqLv4QcS0ATnBpF1ptFJlpkN9rnPLc6D0TP0mo7bEOOi/FOGuvCrJ+fbhyCv7EYlB+hb+mD05MnV6I3k8m7GAyz7CvUZbSjj3tcC7wqbIZ3U5aSBJbFslmN7zKg==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com; dkim=pass (1024-bit key; unprotected) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.a=rsa-sha256 header.s=default header.b=pcq3VnZg; dkim-atps=neutral; spf=pass (client-ip=115.124.30.132; helo=out30-132.freemail.mail.aliyun.com; envelope-from=hsiangkao@linux.alibaba.com; receiver=lists.ozlabs.org) smtp.mailfrom=linux.alibaba.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (1024-bit key; unprotected) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.a=rsa-sha256 header.s=default header.b=pcq3VnZg;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=linux.alibaba.com (client-ip=115.124.30.132; helo=out30-132.freemail.mail.aliyun.com; envelope-from=hsiangkao@linux.alibaba.com; receiver=lists.ozlabs.org)
Received: from out30-132.freemail.mail.aliyun.com (out30-132.freemail.mail.aliyun.com [115.124.30.132])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4bPZtX1Q10z2xlL
	for <linux-erofs@lists.ozlabs.org>; Sat, 21 Jun 2025 23:28:51 +1000 (AEST)
DKIM-Signature:v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=linux.alibaba.com; s=default;
	t=1750512527; h=From:To:Subject:Date:Message-ID:MIME-Version;
	bh=a6S+zxvGX1IZfxP9RCzs1ytrTxQnzasPnq/yLVf6yjk=;
	b=pcq3VnZg/WcHNcOIFGM2ApEfVfHBz5Y2qth567lpu84s/DshN1dgWvRRhL94bPjEUvTFTxKE+/oWGTN6lYLoZvnWh05OehHADZvUnRBZk7TOZx0r97hF3knWDl+oyULfN3nETn42mH+TW/weY5xrNW+iKLx8R4ftPIZW5RhsX90=
Received: from x31i01179.sqa.na131.tbsite.net(mailfrom:hsiangkao@linux.alibaba.com fp:SMTPD_---0WeO-ZRI_1750512525 cluster:ay36)
          by smtp.aliyun-inc.com;
          Sat, 21 Jun 2025 21:28:45 +0800
From: Gao Xiang <hsiangkao@linux.alibaba.com>
To: linux-erofs@lists.ozlabs.org
Cc: Gao Xiang <hsiangkao@linux.alibaba.com>
Subject: [PATCH 2/2] erofs-utils: mkfs: skip xattrs where getxattr() returns ENODATA
Date: Sat, 21 Jun 2025 21:28:40 +0800
Message-ID: <20250621132840.3036887-2-hsiangkao@linux.alibaba.com>
X-Mailer: git-send-email 2.43.5
In-Reply-To: <20250621132840.3036887-1-hsiangkao@linux.alibaba.com>
References: <20250621132840.3036887-1-hsiangkao@linux.alibaba.com>
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

For example, unprivileged users may not have access to the `trusted.*`
namespace.

It also dumps unidentified xattrs with index 0, which the kernel/FUSE
implementations will ignore.

Signed-off-by: Gao Xiang <hsiangkao@linux.alibaba.com>
---
 lib/xattr.c | 27 +++++++++++----------------
 1 file changed, 11 insertions(+), 16 deletions(-)

diff --git a/lib/xattr.c b/lib/xattr.c
index b382ee4..091c88c 100644
--- a/lib/xattr.c
+++ b/lib/xattr.c
@@ -165,6 +165,8 @@ bool erofs_xattr_prefix_matches(const char *key, unsigned int *index,
 {
 	struct xattr_prefix *p;
 
+	*index = 0;
+	*len = 0;
 	for (p = xattr_types; p < xattr_types + ARRAY_SIZE(xattr_types); ++p) {
 		if (p->prefix && !strncmp(p->prefix, key, p->prefix_len)) {
 			*len = p->prefix_len;
@@ -219,13 +221,9 @@ static struct xattr_item *get_xattritem(char *kvbuf, unsigned int len[2])
 	if (!item)
 		return ERR_PTR(-ENOMEM);
 
-	if (!erofs_xattr_prefix_matches(kvbuf, &item->base_index,
-					&item->prefix_len)) {
-		free(item);
-		return ERR_PTR(-ENODATA);
-	}
+	(void)erofs_xattr_prefix_matches(kvbuf, &item->base_index,
+					 &item->prefix_len);
 	DBG_BUGON(len[0] < item->prefix_len);
-
 	INIT_HLIST_NODE(&item->node);
 	item->count = 1;
 	item->kvbuf = kvbuf;
@@ -292,12 +290,7 @@ static struct xattr_item *parse_one_xattr(const char *path, const char *key,
 	item = get_xattritem(kvbuf, len);
 	if (!IS_ERR(item))
 		return item;
-	if (item == ERR_PTR(-ENODATA)) {
-		erofs_warn("skipped unidentified xattr: %s", key);
-		ret = 0;
-	} else {
-		ret = PTR_ERR(item);
-	}
+	ret = PTR_ERR(item);
 out:
 	free(kvbuf);
 	return ERR_PTR(ret);
@@ -443,13 +436,16 @@ static int read_xattrs_from_file(const char *path, mode_t mode,
 			continue;
 
 		item = parse_one_xattr(path, key, keylen);
+		/* skip inaccessible xattrs */
+		if (item == ERR_PTR(-ENODATA) || !item) {
+			erofs_warn("skipped inaccessible xattr %s in %s",
+				   key, path);
+			continue;
+		}
 		if (IS_ERR(item)) {
 			ret = PTR_ERR(item);
 			goto err;
 		}
-		/* skip unidentified xattrs */
-		if (!item)
-			continue;
 
 		ret = erofs_xattr_add(ixattrs, item);
 		if (ret < 0)
@@ -1430,7 +1426,6 @@ int erofs_getxattr(struct erofs_inode *vi, const char *name, char *buffer,
 
 	if (!erofs_xattr_prefix_matches(name, &prefix, &prefixlen))
 		return -ENODATA;
-
 	it.it.sbi = vi->sbi;
 	it.index = prefix;
 	it.name = name + prefixlen;
-- 
2.43.5


