Return-Path: <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>
X-Original-To: lists+linux-erofs@lfdr.de
Delivered-To: lists+linux-erofs@lfdr.de
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	by mail.lfdr.de (Postfix) with ESMTPS id D79E577D948
	for <lists+linux-erofs@lfdr.de>; Wed, 16 Aug 2023 05:50:07 +0200 (CEST)
Received: from boromir.ozlabs.org (localhost [IPv6:::1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4RQZ0F5mlyz3cVh
	for <lists+linux-erofs@lfdr.de>; Wed, 16 Aug 2023 13:50:05 +1000 (AEST)
X-Original-To: linux-erofs@lists.ozlabs.org
Delivered-To: linux-erofs@lists.ozlabs.org
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=linux.alibaba.com (client-ip=115.124.30.130; helo=out30-130.freemail.mail.aliyun.com; envelope-from=jefflexu@linux.alibaba.com; receiver=lists.ozlabs.org)
Received: from out30-130.freemail.mail.aliyun.com (out30-130.freemail.mail.aliyun.com [115.124.30.130])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4RQYzz60M5z2yW7
	for <linux-erofs@lists.ozlabs.org>; Wed, 16 Aug 2023 13:49:49 +1000 (AEST)
X-Alimail-AntiSpam: AC=PASS;BC=-1|-1;BR=01201311R661e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=ay29a033018045176;MF=jefflexu@linux.alibaba.com;NM=1;PH=DS;RN=2;SR=0;TI=SMTPD_---0VpuGnyN_1692157783;
Received: from localhost(mailfrom:jefflexu@linux.alibaba.com fp:SMTPD_---0VpuGnyN_1692157783)
          by smtp.aliyun-inc.com;
          Wed, 16 Aug 2023 11:49:44 +0800
From: Jingbo Xu <jefflexu@linux.alibaba.com>
To: xiang@kernel.org,
	linux-erofs@lists.ozlabs.org
Subject: [PATCH v2 2/4] erofs-utils: lib: add match_base_prefix() helper
Date: Wed, 16 Aug 2023 11:49:39 +0800
Message-Id: <20230816034941.126866-3-jefflexu@linux.alibaba.com>
X-Mailer: git-send-email 2.19.1.6.gb485710b
In-Reply-To: <20230816034941.126866-1-jefflexu@linux.alibaba.com>
References: <20230816034941.126866-1-jefflexu@linux.alibaba.com>
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

Since the introduction of long xattr name prefix, match_prefix() will
search among the long xattr name prefixes first and return the matched
prefix, while erofs_getxattr() expects a base prefix even when the
queried xattr name matches a long prefix.

Thus introduce match_base_prefix() helper to do this.

Signed-off-by: Jingbo Xu <jefflexu@linux.alibaba.com>
---
 lib/xattr.c | 25 ++++++++++++++++---------
 1 file changed, 16 insertions(+), 9 deletions(-)

diff --git a/lib/xattr.c b/lib/xattr.c
index 2548750..4091fe6 100644
--- a/lib/xattr.c
+++ b/lib/xattr.c
@@ -137,27 +137,34 @@ static struct xattr_item *get_xattritem(u8 prefix, char *kvbuf,
 	return item;
 }
 
-static bool match_prefix(const char *key, u8 *index, u16 *len)
+static bool match_base_prefix(const char *key, u8 *index, u16 *len)
 {
 	struct xattr_prefix *p;
-	struct ea_type_node *tnode;
 
-	list_for_each_entry(tnode, &ea_name_prefixes, list) {
-		p = &tnode->type;
+	for (p = xattr_types; p < xattr_types + ARRAY_SIZE(xattr_types); ++p) {
 		if (p->prefix && !strncmp(p->prefix, key, p->prefix_len)) {
 			*len = p->prefix_len;
-			*index = tnode->index;
+			*index = p - xattr_types;
 			return true;
 		}
 	}
-	for (p = xattr_types; p < xattr_types + ARRAY_SIZE(xattr_types); ++p) {
+	return false;
+}
+
+static bool match_prefix(const char *key, u8 *index, u16 *len)
+{
+	struct xattr_prefix *p;
+	struct ea_type_node *tnode;
+
+	list_for_each_entry(tnode, &ea_name_prefixes, list) {
+		p = &tnode->type;
 		if (p->prefix && !strncmp(p->prefix, key, p->prefix_len)) {
 			*len = p->prefix_len;
-			*index = p - xattr_types;
+			*index = tnode->index;
 			return true;
 		}
 	}
-	return false;
+	return match_base_prefix(key, index, len);
 }
 
 static struct xattr_item *parse_one_xattr(const char *path, const char *key,
@@ -1198,7 +1205,7 @@ int erofs_getxattr(struct erofs_inode *vi, const char *name, char *buffer,
 	if (ret)
 		return ret;
 
-	if (!match_prefix(name, &prefix, &prefixlen))
+	if (!match_base_prefix(name, &prefix, &prefixlen))
 		return -ENODATA;
 
 	it.it.sbi = vi->sbi;
-- 
2.19.1.6.gb485710b

