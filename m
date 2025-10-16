Return-Path: <linux-erofs+bounces-1185-lists+linux-erofs=lfdr.de@lists.ozlabs.org>
X-Original-To: lists+linux-erofs@lfdr.de
Delivered-To: lists+linux-erofs@lfdr.de
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2404:9400:2:0:216:3eff:fee1:b9f1])
	by mail.lfdr.de (Postfix) with ESMTPS id 20157BE14F2
	for <lists+linux-erofs@lfdr.de>; Thu, 16 Oct 2025 04:48:34 +0200 (CEST)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4cnC7d1zQKz3bjb;
	Thu, 16 Oct 2025 13:48:29 +1100 (AEDT)
X-Original-To: linux-erofs@lists.ozlabs.org
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip=115.124.30.124
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1760582909;
	cv=none; b=HRK6h38ajqzVdl3uZ/itNNrZUh1PBTOo5a4VjkRvPQD8sk8+44EOuhvj1Ma5zKWCIyfkHZCRyNc5gmiU6In6ThxSELpCOdkWIpr9ZPjilzeccUnrsvOBYs+bn+GovGOsXKkmwquUom/PrIghnhopRvYfAd9qkiYHe35/1pj0ioo+8HUzicTEmKb1m/dTpy276lLNDmM0NtQNa9ACTbg8ZNJueVVOHkuWeVLuNABGezbjHymlEfbYOqqA2HN44Wbpebdy6ClV3YCb6dDIEtD/5vhVmpMHAmbgWBJ/Lebf+bu3KmOAcVqkZPpwswoRUxZzIT4nq+h7jgxxQ6VIuJ47ug==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1760582909; c=relaxed/relaxed;
	bh=QRrROHYBGpgX+D/McKJreLaBI03/bs+9OC8p3Rhaz8U=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=b3m/xbRhMmWlVwGGrpoPFUPkMYClSUUST2CgnlJKhZJ0kHQL0MUoVQ57cETQt23pFqTA8MPEdAHO89DrpIs04+PIs7JJK2qpaB6BUo35mE574aqpQPa8t8nvpOYWC2YyPvOJbhv6fDawxI4LXHUJX/vBE+/l5gBorMJ/8PpM7ll+qKYaxua6rlrq4Z4iHh3q4SExCPQVis01B78YpTqgiIbXrRwQJ6824ez34JG9s/vwX2eJQ2dczAkz95vYbL3m8HZzdq+/+D5yt76SRGZOk7T5T0DAArHUiONRQ2Cw9BU9ib1M5n7SEk8z27ll9hUi3zlESaT1vmloTnYuZDZpuw==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com; dkim=pass (1024-bit key; unprotected) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.a=rsa-sha256 header.s=default header.b=MI0xzSgT; dkim-atps=neutral; spf=pass (client-ip=115.124.30.124; helo=out30-124.freemail.mail.aliyun.com; envelope-from=hsiangkao@linux.alibaba.com; receiver=lists.ozlabs.org) smtp.mailfrom=linux.alibaba.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (1024-bit key; unprotected) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.a=rsa-sha256 header.s=default header.b=MI0xzSgT;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=linux.alibaba.com (client-ip=115.124.30.124; helo=out30-124.freemail.mail.aliyun.com; envelope-from=hsiangkao@linux.alibaba.com; receiver=lists.ozlabs.org)
Received: from out30-124.freemail.mail.aliyun.com (out30-124.freemail.mail.aliyun.com [115.124.30.124])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4cnC7b3N0hz301N
	for <linux-erofs@lists.ozlabs.org>; Thu, 16 Oct 2025 13:48:26 +1100 (AEDT)
DKIM-Signature:v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=linux.alibaba.com; s=default;
	t=1760582903; h=From:To:Subject:Date:Message-ID:MIME-Version;
	bh=QRrROHYBGpgX+D/McKJreLaBI03/bs+9OC8p3Rhaz8U=;
	b=MI0xzSgTffqAzx7ywcxgAZIpdz/NsH5viXDwcZehgo9j3Kb1AU1btAQGinwkFiXcZF0LAf8acAoQGKoG/Wc5jjZ5e4qE63FvYA2S6j9iMtFVBRoF84EqAylxZBlW3hCsnJak2IKKby5iGERBs7ETf8FU7GYWH7xad2fS7KCUaa4=
Received: from x31i01179.sqa.na131.tbsite.net(mailfrom:hsiangkao@linux.alibaba.com fp:SMTPD_---0WqIZVip_1760582900 cluster:ay36)
          by smtp.aliyun-inc.com;
          Thu, 16 Oct 2025 10:48:21 +0800
From: Gao Xiang <hsiangkao@linux.alibaba.com>
To: linux-erofs@lists.ozlabs.org
Cc: Gao Xiang <hsiangkao@linux.alibaba.com>
Subject: [PATCH 2/7] erofs-utils: mkfs: separate pnid fixup for incremental builds from `validnid`
Date: Thu, 16 Oct 2025 10:48:10 +0800
Message-ID: <20251016024815.2750927-2-hsiangkao@linux.alibaba.com>
X-Mailer: git-send-email 2.43.5
In-Reply-To: <20251016024815.2750927-1-hsiangkao@linux.alibaba.com>
References: <20251016024815.2750927-1-hsiangkao@linux.alibaba.com>
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

This ensures they are not buried in the `validnid` dump.

Signed-off-by: Gao Xiang <hsiangkao@linux.alibaba.com>
---
 include/erofs/internal.h |  8 +++++---
 lib/inode.c              | 13 +++++++------
 lib/rebuild.c            |  6 ++++--
 3 files changed, 16 insertions(+), 11 deletions(-)

diff --git a/include/erofs/internal.h b/include/erofs/internal.h
index e8d8667..4de6563 100644
--- a/include/erofs/internal.h
+++ b/include/erofs/internal.h
@@ -338,15 +338,17 @@ static inline struct erofs_inode *erofs_parent_inode(struct erofs_inode *inode)
 #define IS_ROOT(x)	((x) == erofs_parent_inode(x))
 
 #define EROFS_DENTRY_NAME_ALIGNMENT	4
+
+#define EROFS_DENTRY_FLAG_VALIDNID	0x01
+#define EROFS_DENTRY_FLAG_FIXUP_PNID	0x02
 struct erofs_dentry {
 	struct list_head d_child;	/* child of parent list */
 	union {
 		struct erofs_inode *inode;
 		erofs_nid_t nid;
 	};
-	u8 namelen;
-	u8 type;
-	bool validnid;
+	u8 namelen, type;
+	u8 flags;
 	char name[];
 };
 
diff --git a/lib/inode.c b/lib/inode.c
index 4a834b4..d16468d 100644
--- a/lib/inode.c
+++ b/lib/inode.c
@@ -187,7 +187,7 @@ struct erofs_dentry *erofs_d_alloc(struct erofs_inode *parent,
 	d->inode = NULL;
 	d->namelen = namelen;
 	d->type = EROFS_FT_UNKNOWN;
-	d->validnid = false;
+	d->flags = 0;
 	list_add_tail(&d->d_child, &parent->i_subdirs);
 	return d;
 }
@@ -425,10 +425,10 @@ static void erofs_d_invalidate(struct erofs_dentry *d)
 {
 	struct erofs_inode *const inode = d->inode;
 
-	if (d->validnid)
+	if (d->flags & EROFS_DENTRY_FLAG_VALIDNID)
 		return;
 	d->nid = erofs_lookupnid(inode);
-	d->validnid = true;
+	d->flags |= EROFS_DENTRY_FLAG_VALIDNID;
 	erofs_iput(inode);
 }
 
@@ -536,7 +536,7 @@ static int erofs_write_dir_file(struct erofs_inode *dir)
 		unsigned int len = d->namelen + sizeof(struct erofs_dirent);
 
 		/* XXX: a bit hacky, but to avoid another traversal */
-		if (d->validnid && d->type == EROFS_FT_DIR) {
+		if (d->flags & EROFS_DENTRY_FLAG_FIXUP_PNID) {
 			ret = erofs_rebuild_inode_fix_pnid(dir, d->nid);
 			if (ret)
 				return ret;
@@ -1690,7 +1690,7 @@ err_closedir:
 
 bool erofs_dentry_is_wht(struct erofs_sb_info *sbi, struct erofs_dentry *d)
 {
-	if (!d->validnid)
+	if (!(d->flags & EROFS_DENTRY_FLAG_VALIDNID))
 		return erofs_inode_is_whiteout(d->inode);
 	if (d->type == EROFS_FT_CHRDEV) {
 		struct erofs_inode ei = { .sbi = sbi, .nid = d->nid };
@@ -1933,7 +1933,8 @@ static int erofs_mkfs_dump_tree(struct erofs_importer *im, bool rebuild,
 		list_for_each_entry(d, &dir->i_subdirs, d_child) {
 			struct erofs_inode *inode = d->inode;
 
-			if (is_dot_dotdot(d->name) || d->validnid)
+			if (is_dot_dotdot(d->name) ||
+			    (d->flags & EROFS_DENTRY_FLAG_VALIDNID))
 				continue;
 
 			if (!erofs_inode_visited(inode)) {
diff --git a/lib/rebuild.c b/lib/rebuild.c
index c5b44d5..f89a17c 100644
--- a/lib/rebuild.c
+++ b/lib/rebuild.c
@@ -484,12 +484,14 @@ static int erofs_rebuild_basedir_dirent_iter(struct erofs_dir_context *ctx)
 	if (d->type == EROFS_FT_UNKNOWN) {
 		d->nid = ctx->de_nid;
 		d->type = ctx->de_ftype;
-		d->validnid = true;
+		d->flags |= EROFS_DENTRY_FLAG_VALIDNID;
+		if (d->type == EROFS_FT_DIR)
+			d->flags |= EROFS_DENTRY_FLAG_FIXUP_PNID;
 		if (!mergedir->whiteouts && erofs_dentry_is_wht(dir->sbi, d))
 			mergedir->whiteouts = true;
 		*rctx->i_nlink += (ctx->de_ftype == EROFS_FT_DIR);
 		++*rctx->nr_subdirs;
-	} else if (__erofs_unlikely(d->validnid)) {
+	} else if (__erofs_unlikely(d->flags & EROFS_DENTRY_FLAG_VALIDNID)) {
 		/* The base image appears to be corrupted */
 		DBG_BUGON(1);
 		ret = -EFSCORRUPTED;
-- 
2.43.5


