Return-Path: <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>
X-Original-To: lists+linux-erofs@lfdr.de
Delivered-To: lists+linux-erofs@lfdr.de
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	by mail.lfdr.de (Postfix) with ESMTPS id 920166DAEBA
	for <lists+linux-erofs@lfdr.de>; Fri,  7 Apr 2023 16:17:39 +0200 (CEST)
Received: from boromir.ozlabs.org (localhost [IPv6:::1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4PtL6n3mZrz3fYR
	for <lists+linux-erofs@lfdr.de>; Sat,  8 Apr 2023 00:17:37 +1000 (AEST)
X-Original-To: linux-erofs@lists.ozlabs.org
Delivered-To: linux-erofs@lists.ozlabs.org
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=linux.alibaba.com (client-ip=115.124.30.99; helo=out30-99.freemail.mail.aliyun.com; envelope-from=jefflexu@linux.alibaba.com; receiver=<UNKNOWN>)
Received: from out30-99.freemail.mail.aliyun.com (out30-99.freemail.mail.aliyun.com [115.124.30.99])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4PtL6V5PDhz3fVv
	for <linux-erofs@lists.ozlabs.org>; Sat,  8 Apr 2023 00:17:22 +1000 (AEST)
X-Alimail-AntiSpam: AC=PASS;BC=-1|-1;BR=01201311R201e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=ay29a033018046056;MF=jefflexu@linux.alibaba.com;NM=1;PH=DS;RN=5;SR=0;TI=SMTPD_---0VfX8ext_1680877037;
Received: from localhost(mailfrom:jefflexu@linux.alibaba.com fp:SMTPD_---0VfX8ext_1680877037)
          by smtp.aliyun-inc.com;
          Fri, 07 Apr 2023 22:17:18 +0800
From: Jingbo Xu <jefflexu@linux.alibaba.com>
To: xiang@kernel.org,
	chao@kernel.org,
	huyue2@coolpad.com,
	linux-erofs@lists.ozlabs.org
Subject: [PATCH 6/7] erofs: handle long xattr name prefixes properly
Date: Fri,  7 Apr 2023 22:17:09 +0800
Message-Id: <20230407141710.113882-7-jefflexu@linux.alibaba.com>
X-Mailer: git-send-email 2.19.1.6.gb485710b
In-Reply-To: <20230407141710.113882-1-jefflexu@linux.alibaba.com>
References: <20230407141710.113882-1-jefflexu@linux.alibaba.com>
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
Cc: linux-kernel@vger.kernel.org
Errors-To: linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org
Sender: "Linux-erofs" <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>

Make .{list,get}xattr routines adapted to long xattr name prefixes.
When the bit 7 of erofs_xattr_entry.e_name_index is set, it indicates
that it refers to a long xattr name prefix.

Signed-off-by: Jingbo Xu <jefflexu@linux.alibaba.com>
---
 fs/erofs/xattr.c | 60 +++++++++++++++++++++++++++++++++++++++++-------
 1 file changed, 52 insertions(+), 8 deletions(-)

diff --git a/fs/erofs/xattr.c b/fs/erofs/xattr.c
index 684571e83a2c..8d81593655e8 100644
--- a/fs/erofs/xattr.c
+++ b/fs/erofs/xattr.c
@@ -301,11 +301,39 @@ struct getxattr_iter {
 	struct qstr name;
 };
 
+static int erofs_xattr_long_entrymatch(struct getxattr_iter *it,
+				       struct erofs_xattr_entry *entry)
+{
+	struct erofs_sb_info *sbi = EROFS_SB(it->it.sb);
+	u8 idx = entry->e_name_index & EROFS_XATTR_LONG_PREFIX_MASK;
+	struct erofs_xattr_prefix_item *pf;
+
+	if (idx >= sbi->xattr_prefix_count)
+		return -ENOATTR;
+
+	pf = &sbi->xattr_prefixes[idx];
+	if (it->index != pf->prefix->base_index)
+		return -ENOATTR;
+
+	if (strncmp(it->name.name, pf->prefix->infix, pf->infix_len))
+		return -ENOATTR;
+
+	it->name.name += pf->infix_len;
+	it->name.len -= pf->infix_len;
+	if (it->name.len != entry->e_name_len)
+		return -ENOATTR;
+	return 0;
+}
+
 static int xattr_entrymatch(struct xattr_iter *_it,
 			    struct erofs_xattr_entry *entry)
 {
 	struct getxattr_iter *it = container_of(_it, struct getxattr_iter, it);
 
+	/* should also match the infix for long name prefixes */
+	if (entry->e_name_index & EROFS_XATTR_LONG_PREFIX)
+		return erofs_xattr_long_entrymatch(it, entry);
+
 	return (it->index != entry->e_name_index ||
 		it->name.len != entry->e_name_len) ? -ENOATTR : 0;
 }
@@ -487,12 +515,26 @@ static int xattr_entrylist(struct xattr_iter *_it,
 {
 	struct listxattr_iter *it =
 		container_of(_it, struct listxattr_iter, it);
-	unsigned int prefix_len;
-	const char *prefix;
-
-	const struct xattr_handler *h =
-		erofs_xattr_handler(entry->e_name_index);
+	unsigned int base_index = entry->e_name_index;
+	unsigned int prefix_len, infix_len = 0;
+	const char *prefix, *infix = NULL;
+	const struct xattr_handler *h;
+
+	if (entry->e_name_index & EROFS_XATTR_LONG_PREFIX) {
+		struct erofs_sb_info *sbi = EROFS_SB(_it->sb);
+		u8 idx = entry->e_name_index & EROFS_XATTR_LONG_PREFIX_MASK;
+		struct erofs_xattr_prefix_item *pf;
+
+		if (idx >= sbi->xattr_prefix_count)
+			return 1;
+
+		pf = &sbi->xattr_prefixes[idx];
+		infix = pf->prefix->infix;
+		infix_len = pf->infix_len;
+		base_index = pf->prefix->base_index;
+	}
 
+	h = erofs_xattr_handler(base_index);
 	if (!h || (h->list && !h->list(it->dentry)))
 		return 1;
 
@@ -500,16 +542,18 @@ static int xattr_entrylist(struct xattr_iter *_it,
 	prefix_len = strlen(prefix);
 
 	if (!it->buffer) {
-		it->buffer_ofs += prefix_len + entry->e_name_len + 1;
+		it->buffer_ofs += prefix_len + infix_len +
+					entry->e_name_len + 1;
 		return 1;
 	}
 
-	if (it->buffer_ofs + prefix_len
+	if (it->buffer_ofs + prefix_len + infix_len +
 		+ entry->e_name_len + 1 > it->buffer_size)
 		return -ERANGE;
 
 	memcpy(it->buffer + it->buffer_ofs, prefix, prefix_len);
-	it->buffer_ofs += prefix_len;
+	memcpy(it->buffer + it->buffer_ofs + prefix_len, infix, infix_len);
+	it->buffer_ofs += prefix_len + infix_len;
 	return 0;
 }
 
-- 
2.19.1.6.gb485710b

