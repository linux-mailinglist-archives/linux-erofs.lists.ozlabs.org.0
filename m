Return-Path: <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>
X-Original-To: lists+linux-erofs@lfdr.de
Delivered-To: lists+linux-erofs@lfdr.de
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	by mail.lfdr.de (Postfix) with ESMTPS id 14F6579E5F8
	for <lists+linux-erofs@lfdr.de>; Wed, 13 Sep 2023 13:12:22 +0200 (CEST)
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20201202 header.b=tjOkq3D8;
	dkim-atps=neutral
Received: from boromir.ozlabs.org (localhost [IPv6:::1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4RlyTc02Y8z3c4V
	for <lists+linux-erofs@lfdr.de>; Wed, 13 Sep 2023 21:12:20 +1000 (AEST)
X-Original-To: linux-erofs@lists.ozlabs.org
Delivered-To: linux-erofs@lists.ozlabs.org
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20201202 header.b=tjOkq3D8;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=kernel.org (client-ip=139.178.84.217; helo=dfw.source.kernel.org; envelope-from=xiang@kernel.org; receiver=lists.ozlabs.org)
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4RlyTS0GFxz30hj
	for <linux-erofs@lists.ozlabs.org>; Wed, 13 Sep 2023 21:12:11 +1000 (AEST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits))
	(No client certificate requested)
	by dfw.source.kernel.org (Postfix) with ESMTPS id 7DF85618D9;
	Wed, 13 Sep 2023 11:12:09 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CC253C433C7;
	Wed, 13 Sep 2023 11:12:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1694603529;
	bh=nYoI6bTE6Arz3tEnqgwl3d/QsKhywMB6Iyr10kJCbLE=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=tjOkq3D8qLJE5tjIKtnLZevwLBOwMZi5AIH8GJ91DvS2kgdP4cxOOtifM55Uh+6Yq
	 TDJxhY9mDHzbcPAKVjQ4xxEGscAoVpu3a6uFeKtOSoeB5aCxF3W45z7/8/7nSQoxux
	 4qzdXtoqp6JtAPnCd9qXzboQcZK5GcXxwpap2/cl6cKTGK6jwCv4shdMmEyR5Lhmxv
	 bkoC+/+6/r4teD4wiDNQ08pzCZezo8p5hD3nbptnQ526Ja0X8ujqZU7R0RrWQaMHKe
	 IF1XcSvlP8BM5bq5pEzIB7vmWvYYrjlpsK0DSBbefkm6qQZ1Iisqdp/llSz4LTmOOe
	 uzbFM4J8Pu+YQ==
Date: Wed, 13 Sep 2023 19:11:57 +0800
From: Gao Xiang <xiang@kernel.org>
To: Jingbo Xu <jefflexu@linux.alibaba.com>
Subject: Re: [PATCH v3] erofs-utils: lib: refactor extended attribute name
 prefixes
Message-ID: <ZQGY/fdTiGmtSgNV@debian>
Mail-Followup-To: Jingbo Xu <jefflexu@linux.alibaba.com>,
	hsiangkao@linux.alibaba.com, linux-erofs@lists.ozlabs.org
References: <20230913031804.84819-1-jefflexu@linux.alibaba.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20230913031804.84819-1-jefflexu@linux.alibaba.com>
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
Cc: hsiangkao@linux.alibaba.com, linux-erofs@lists.ozlabs.org
Errors-To: linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org
Sender: "Linux-erofs" <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>

On Wed, Sep 13, 2023 at 11:18:04AM +0800, Jingbo Xu wrote:
> Previously, the extended attribute name in xattr_item was actually the
> part with the matched prefix stripped, which makes it clumsy to strip
> or delete a specific attribute from one file.
> 
> To fix this, make the complete attribute name stored in xattr_item.
> One thing worth noting is that the attribute name in xattr_item has a
> trailing '\0' for ease of name comparison, while the trailing '\0' will
> get stripped when writing to on-disk erofs_xattr_entry.
> 
> Signed-off-by: Jingbo Xu <jefflexu@linux.alibaba.com>
> ---
> v3:
> - introduce EROFS_XATTR_KSIZE() and EROFS_XATTR_KVSIZE() macro
> - make the full long name prefix (instead of the infix in v2) stored in
>   ea_type_node; and thus compare with the full long name prefix in
>   get_xattritem() directly
> - convert the data type of in-memory prefix index and prefix_len from
>   u8/u16 to unsigned int
> ---

Applied with the following diff:

diff --git a/lib/xattr.c b/lib/xattr.c
index 8119013..bf63a81 100644
--- a/lib/xattr.c
+++ b/lib/xattr.c
@@ -78,16 +78,16 @@
 
 #define EA_HASHTABLE_BITS 16
 
-/* extra one byte for the trailing `\0` of attribute name */
+/* one extra byte for the trailing `\0` of attribute name */
 #define EROFS_XATTR_KSIZE(kvlen)	(kvlen[0] + 1)
 #define EROFS_XATTR_KVSIZE(kvlen)	(EROFS_XATTR_KSIZE(kvlen) + kvlen[1])
 
 /*
- * @base_index:	the index of matched predefined short prefix
- * @prefix:	the index of matched long prefix if any;
+ * @base_index:	the index of the matched predefined short prefix
+ * @prefix:	the index of the matched long prefix, if any;
  *		same as base_index otherwise
- * @prefix_len:	the length of matched long prefix if any;
- *		the length of matched predefined short prefix otherwise
+ * @prefix_len:	the length of the matched long prefix if any;
+ *		the length of the matched predefined short prefix otherwise
  */
 struct xattr_item {
 	struct xattr_item *next_shared_xattr;
@@ -185,6 +185,7 @@ static unsigned int put_xattritem(struct xattr_item *item)
 static struct xattr_item *get_xattritem(char *kvbuf, unsigned int len[2])
 {
 	struct xattr_item *item;
+	struct ea_type_node *tnode;
 	unsigned int hash[2], hkey;
 
 	hkey = xattr_item_hash(kvbuf, len, hash);
@@ -221,20 +222,15 @@ static struct xattr_item *get_xattritem(char *kvbuf, unsigned int len[2])
 	item->shared_xattr_id = -1;
 	item->prefix = item->base_index;
 
-	if (cfg.c_extra_ea_name_prefixes) {
-		struct ea_type_node *tnode;
-
-		list_for_each_entry(tnode, &ea_name_prefixes, list) {
-			if (item->base_index == tnode->base_index &&
-			    !strncmp(tnode->type.prefix, kvbuf,
-				     tnode->type.prefix_len)) {
-				item->prefix = tnode->index;
-				item->prefix_len = tnode->type.prefix_len;
-				break;
-			}
+	list_for_each_entry(tnode, &ea_name_prefixes, list) {
+		if (item->base_index == tnode->base_index &&
+		    !strncmp(tnode->type.prefix, kvbuf,
+			     tnode->type.prefix_len)) {
+			item->prefix = tnode->index;
+			item->prefix_len = tnode->type.prefix_len;
+			break;
 		}
 	}
-
 	hash_add(ea_hashtable, &item->node, hkey);
 	return item;
 }
@@ -267,7 +263,7 @@ static struct xattr_item *parse_one_xattr(const char *path, const char *key,
 	kvbuf = malloc(EROFS_XATTR_KVSIZE(len));
 	if (!kvbuf)
 		return ERR_PTR(-ENOMEM);
-	sprintf(kvbuf, "%s", key);
+	memcpy(kvbuf, key, EROFS_XATTR_KSIZE(len));
 	if (len[1]) {
 		/* copy value to buffer */
 #ifdef HAVE_LGETXATTR
@@ -492,7 +488,7 @@ int erofs_setxattr(struct erofs_inode *inode, char *key,
 	if (!kvbuf)
 		return -ENOMEM;
 
-	sprintf(kvbuf, "%s", key);
+	memcpy(kvbuf, key, EROFS_XATTR_KSIZE(len));
 	memcpy(kvbuf + EROFS_XATTR_KSIZE(len), value, size);
 
 	item = get_xattritem(kvbuf, len);
