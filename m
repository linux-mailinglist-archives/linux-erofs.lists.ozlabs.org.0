Return-Path: <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>
X-Original-To: lists+linux-erofs@lfdr.de
Delivered-To: lists+linux-erofs@lfdr.de
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2404:9400:2:0:216:3eff:fee1:b9f1])
	by mail.lfdr.de (Postfix) with ESMTPS id AE78B9778F4
	for <lists+linux-erofs@lfdr.de>; Fri, 13 Sep 2024 08:49:27 +0200 (CEST)
Received: from boromir.ozlabs.org (localhost [IPv6:::1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4X4lKK1mlZz2ypP
	for <lists+linux-erofs@lfdr.de>; Fri, 13 Sep 2024 16:49:25 +1000 (AEST)
X-Original-To: linux-erofs@lists.ozlabs.org
Delivered-To: linux-erofs@lists.ozlabs.org
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip=115.124.30.133
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1726210162;
	cv=none; b=N4gD3FEoqx4ZGEutoxLkWBNd9KdjUEyv71l3RUeIdVrAN7gFJEv/Lm7UsbC7nLuWoRByAbY1RTdwWxDH0RGeJOO0UpDcoNN4E4wgzHwvxySw7fjxp0CcIOmpUhlUG70pYYGS13SepTXaSOZ/t0OKq0gjIrMyc7gAJlXWNtan3pdaTlz0hxBBHZQSUMpUkRIRaQa4zBhVq6oSoV/qBfFGoTGlpRDj1Ra0Ajc8YEWKiRm8Gq6I96X/os9z6WWdfFdiwJu6P9g/l943cwDWk5im6dZbmyy04tkO9QMO6tV4S7i9yNSP2/1PoImAGq2fFTMlsZhGPJXzGXc4ItQODpWpBQ==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1726210162; c=relaxed/relaxed;
	bh=eIXqirSq+nzp/lN6SvLAMBt0NtmEVHQdkyi+RgHNhc0=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=LSWkgn8zEEGLWJgzi7ee+iuYCcxhoHBDUo5mPj6PEiPPStcpj4/QhyqNC4txuQkWKsZSzhDeCAJxaljgAjx1fYv6HApR/0PrVzWuhZx7InTo5nHLPujMxILpIuE6x9Z9yj1sSQypVRg3nV9F767bVbKXCAjRp3iIdo0hvVqUxaqL2l2dJcycmrA4Tvf4GQtIhqWhyhBLyCAJhz/bFO9qlSg0jkXENb+LaEdracwvk/49uSnKj8KlwP3YMzmuCjSkxRdsTvS9Qj+03shAU+DJzMg/iyeEUWizpB8a0qy+nUy7YmpeAPjTCdSSZK6/PdSR+c+/Henis8p6S1eQOpLhSQ==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com; dkim=pass (1024-bit key; unprotected) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.a=rsa-sha256 header.s=default header.b=aJZODTdl; dkim-atps=neutral; spf=pass (client-ip=115.124.30.133; helo=out30-133.freemail.mail.aliyun.com; envelope-from=hongzhen@linux.alibaba.com; receiver=lists.ozlabs.org) smtp.mailfrom=linux.alibaba.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (1024-bit key; unprotected) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.a=rsa-sha256 header.s=default header.b=aJZODTdl;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=linux.alibaba.com (client-ip=115.124.30.133; helo=out30-133.freemail.mail.aliyun.com; envelope-from=hongzhen@linux.alibaba.com; receiver=lists.ozlabs.org)
Received: from out30-133.freemail.mail.aliyun.com (out30-133.freemail.mail.aliyun.com [115.124.30.133])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4X4lKF260Bz2yYy
	for <linux-erofs@lists.ozlabs.org>; Fri, 13 Sep 2024 16:49:19 +1000 (AEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=linux.alibaba.com; s=default;
	t=1726210155; h=From:To:Subject:Date:Message-ID:MIME-Version;
	bh=eIXqirSq+nzp/lN6SvLAMBt0NtmEVHQdkyi+RgHNhc0=;
	b=aJZODTdldu0jZxLac662SzBimuWdicqfY113RJUn5t5FGERivV4ZLvsyJHCS2xT6e60gPZ8DT3BJ0taOc25j4GAf1PUGUIsL2r5V6Ot1iypME/b5bbNNJlkaM7ZvaJnVw70YC/O+D6wQYmzYfiGN3CUmEkDwjbVyaW7Te0cJdvA=
Received: from localhost(mailfrom:hongzhen@linux.alibaba.com fp:SMTPD_---0WEtoHE4_1726210153)
          by smtp.aliyun-inc.com;
          Fri, 13 Sep 2024 14:49:14 +0800
From: Hongzhen Luo <hongzhen@linux.alibaba.com>
To: linux-erofs@lists.ozlabs.org
Subject: [PATCH v9 1/2] erofs-utils: lib: expose erofs_xattr_prefix_matches()
Date: Fri, 13 Sep 2024 14:49:12 +0800
Message-ID: <20240913064913.537850-1-hongzhen@linux.alibaba.com>
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
v4: No changes.
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

