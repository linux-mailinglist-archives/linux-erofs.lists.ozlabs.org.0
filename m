Return-Path: <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>
X-Original-To: lists+linux-erofs@lfdr.de
Delivered-To: lists+linux-erofs@lfdr.de
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	by mail.lfdr.de (Postfix) with ESMTPS id D8F646DD6FA
	for <lists+linux-erofs@lfdr.de>; Tue, 11 Apr 2023 11:35:54 +0200 (CEST)
Received: from boromir.ozlabs.org (localhost [IPv6:::1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4Pwggr0sGtz3cNM
	for <lists+linux-erofs@lfdr.de>; Tue, 11 Apr 2023 19:35:52 +1000 (AEST)
X-Original-To: linux-erofs@lists.ozlabs.org
Delivered-To: linux-erofs@lists.ozlabs.org
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=linux.alibaba.com (client-ip=115.124.30.119; helo=out30-119.freemail.mail.aliyun.com; envelope-from=jefflexu@linux.alibaba.com; receiver=<UNKNOWN>)
Received: from out30-119.freemail.mail.aliyun.com (out30-119.freemail.mail.aliyun.com [115.124.30.119])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4Pwggj3f7Tz3c9L
	for <linux-erofs@lists.ozlabs.org>; Tue, 11 Apr 2023 19:35:44 +1000 (AEST)
X-Alimail-AntiSpam: AC=PASS;BC=-1|-1;BR=01201311R181e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=ay29a033018046051;MF=jefflexu@linux.alibaba.com;NM=1;PH=DS;RN=5;SR=0;TI=SMTPD_---0Vfrhsq-_1681205737;
Received: from localhost(mailfrom:jefflexu@linux.alibaba.com fp:SMTPD_---0Vfrhsq-_1681205737)
          by smtp.aliyun-inc.com;
          Tue, 11 Apr 2023 17:35:38 +0800
From: Jingbo Xu <jefflexu@linux.alibaba.com>
To: xiang@kernel.org,
	chao@kernel.org,
	huyue2@coolpad.com,
	linux-erofs@lists.ozlabs.org
Subject: [PATCH v3 6/7] erofs: handle long xattr name prefixes properly
Date: Tue, 11 Apr 2023 17:35:37 +0800
Message-Id: <20230411093537.127286-1-jefflexu@linux.alibaba.com>
X-Mailer: git-send-email 2.19.1.6.gb485710b
In-Reply-To: <20230410063918.47215-1-jefflexu@linux.alibaba.com>
References: <20230410063918.47215-1-jefflexu@linux.alibaba.com>
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
v3: introduce infix_len to struct getxattr_iter, and refactor the
implementation of xattr_entrymatch(), erofs_xattr_long_entrymatch(), and
xattr_namematch() accordingly.

The erofs_xattr_long_entrymatch() of v2 version will advance
it->name.name pointer by pf->infix_len prematurely, as the following
xattr_namematch() may fail (-ENOATTR) since mismatching.  And then
it->name.name will be compared with the next xattr entry, while
it->name.name has been mistakenly modified in the previous round.  This
will cause -ENOATTR error on the existing xattr.

---
 fs/erofs/xattr.c | 68 +++++++++++++++++++++++++++++++++++++++---------
 1 file changed, 56 insertions(+), 12 deletions(-)

diff --git a/fs/erofs/xattr.c b/fs/erofs/xattr.c
index 684571e83a2c..a04724c816e5 100644
--- a/fs/erofs/xattr.c
+++ b/fs/erofs/xattr.c
@@ -297,17 +297,45 @@ struct getxattr_iter {
 	struct xattr_iter it;
 
 	char *buffer;
-	int buffer_size, index;
+	int buffer_size, index, infix_len;
 	struct qstr name;
 };
 
+static int erofs_xattr_long_entrymatch(struct getxattr_iter *it,
+				       struct erofs_xattr_entry *entry)
+{
+	struct erofs_sb_info *sbi = EROFS_SB(it->it.sb);
+	struct erofs_xattr_prefix_item *pf = sbi->xattr_prefixes +
+		(entry->e_name_index & EROFS_XATTR_LONG_PREFIX_MASK);
+
+	if (pf >= sbi->xattr_prefixes + sbi->xattr_prefix_count)
+		return -ENOATTR;
+
+	if (it->index != pf->prefix->base_index ||
+	    it->name.len != entry->e_name_len + pf->infix_len)
+		return -ENOATTR;
+
+	if (memcmp(it->name.name, pf->prefix->infix, pf->infix_len))
+		return -ENOATTR;
+
+	it->infix_len = pf->infix_len;
+	return 0;
+}
+
 static int xattr_entrymatch(struct xattr_iter *_it,
 			    struct erofs_xattr_entry *entry)
 {
 	struct getxattr_iter *it = container_of(_it, struct getxattr_iter, it);
 
-	return (it->index != entry->e_name_index ||
-		it->name.len != entry->e_name_len) ? -ENOATTR : 0;
+	/* should also match the infix for long name prefixes */
+	if (entry->e_name_index & EROFS_XATTR_LONG_PREFIX)
+		return erofs_xattr_long_entrymatch(it, entry);
+
+	if (it->index != entry->e_name_index ||
+	    it->name.len != entry->e_name_len)
+		return -ENOATTR;
+	it->infix_len = 0;
+	return 0;
 }
 
 static int xattr_namematch(struct xattr_iter *_it,
@@ -315,7 +343,9 @@ static int xattr_namematch(struct xattr_iter *_it,
 {
 	struct getxattr_iter *it = container_of(_it, struct getxattr_iter, it);
 
-	return memcmp(buf, it->name.name + processed, len) ? -ENOATTR : 0;
+	if (memcmp(buf, it->name.name + it->infix_len + processed, len))
+		return -ENOATTR;
+	return 0;
 }
 
 static int xattr_checkbuffer(struct xattr_iter *_it,
@@ -487,12 +517,24 @@ static int xattr_entrylist(struct xattr_iter *_it,
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
+		struct erofs_xattr_prefix_item *pf = sbi->xattr_prefixes +
+			(entry->e_name_index & EROFS_XATTR_LONG_PREFIX_MASK);
+
+		if (pf >= sbi->xattr_prefixes + sbi->xattr_prefix_count)
+			return 1;
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

