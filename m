Return-Path: <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>
X-Original-To: lists+linux-erofs@lfdr.de
Delivered-To: lists+linux-erofs@lfdr.de
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2404:9400:2:0:216:3eff:fee1:b9f1])
	by mail.lfdr.de (Postfix) with ESMTPS id 390679DA4C2
	for <lists+linux-erofs@lfdr.de>; Wed, 27 Nov 2024 10:29:12 +0100 (CET)
Received: from boromir.ozlabs.org (localhost [IPv6:::1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4XyvK15JqFz30PF
	for <lists+linux-erofs@lfdr.de>; Wed, 27 Nov 2024 20:29:09 +1100 (AEDT)
X-Original-To: linux-erofs@lists.ozlabs.org
Delivered-To: linux-erofs@lists.ozlabs.org
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip=115.124.30.118
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1732699748;
	cv=none; b=FM1ezAWunRN0sdhQ/txmT9BSom8dbV9gHcJO3QtpkKnh9tivF3cRtQcUW/WPFJ2Kq97Lju0CKmdmpsMjLB9QsaZMCgeug4aOwfrF8W846TbaqsN5hHUh7rIo46kcUPnMl0ud8vrCnfBkRbQbJbyIsv89TJx8UNjchqUkL5O8Syd8LDQ0KqXDuA5EgL3vJ+WOfIigOJhoxB0jQTjoIDoJ6l8f4oo6HCXzGo1ir6ufEk4/u0mimL2yz0p5EWdRra8bm0M95DLOs0DWbcPq43UV7s+JsY/Wti1412goC2/8G2WnW7Nqs4FMTWoFTUEAwXjBYJ7GnKVacpV9YZqVStg5dA==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1732699748; c=relaxed/relaxed;
	bh=U8WnxbFXvO/Sq/oCkuIMzYvg15EKsZnP2G01AV51MmA=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=l9aq42P2gjBVtSwdGXZ8CBcJUTlcMQn7tFP/P4z5rxmjmMHy8f8VTtKDYga3LUzXuaAaNeegs90ziNOqDjU2M/JUVS+Mti5M+PIrflNNGlWl/qdPvJFNKK237T4gwu77WN3EaCypeoaHjAEmSDpukfF6aMELYo1ymGAEDZiGvsRLoN63+Vf+ycXf8BjMmqMJekJ98m0iQj6fGcSRdrBHacsM96w5LyF3TVnGdcT2X2aSjEpOHW6M2U5mwzbZc0ANqauDDlg6PcJq0YkcfpTM4Q9AUOpXii8iPr6KVda6S9ewTw5vrYyFc3ZWUfWsqRYRStZkuAii3kKJEPAFeBiryg==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com; dkim=pass (1024-bit key; unprotected) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.a=rsa-sha256 header.s=default header.b=ou5E+J1F; dkim-atps=neutral; spf=pass (client-ip=115.124.30.118; helo=out30-118.freemail.mail.aliyun.com; envelope-from=hongzhen@linux.alibaba.com; receiver=lists.ozlabs.org) smtp.mailfrom=linux.alibaba.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (1024-bit key; unprotected) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.a=rsa-sha256 header.s=default header.b=ou5E+J1F;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=linux.alibaba.com (client-ip=115.124.30.118; helo=out30-118.freemail.mail.aliyun.com; envelope-from=hongzhen@linux.alibaba.com; receiver=lists.ozlabs.org)
Received: from out30-118.freemail.mail.aliyun.com (out30-118.freemail.mail.aliyun.com [115.124.30.118])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4XyvJz3sMhz2xjd
	for <linux-erofs@lists.ozlabs.org>; Wed, 27 Nov 2024 20:29:07 +1100 (AEDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=linux.alibaba.com; s=default;
	t=1732699743; h=From:To:Subject:Date:Message-ID:MIME-Version;
	bh=U8WnxbFXvO/Sq/oCkuIMzYvg15EKsZnP2G01AV51MmA=;
	b=ou5E+J1FEtRDyY5MZrPnORFpWsNzThb8LUomtE/3VrT/9hvGpO0Dh7UuZvfS15caGnW8J0KxonQHcJn7Jek8yWm87KlUZK5h2xzO+nwKiutQkOj+eQkHYSe6Tk3UiYMkVlIW4MHrq/DRha9q5FLWZhFrZYyvOQ/v0qXD28K5vpI=
Received: from localhost(mailfrom:hongzhen@linux.alibaba.com fp:SMTPD_---0WKMA4oh_1732699740 cluster:ay36)
          by smtp.aliyun-inc.com;
          Wed, 27 Nov 2024 17:29:01 +0800
From: Hongzhen Luo <hongzhen@linux.alibaba.com>
To: linux-erofs@lists.ozlabs.org
Subject: [PATCH 2/2] erofs-utils: rebuild: set the appropriate `dev` field for dirs
Date: Wed, 27 Nov 2024 17:28:56 +0800
Message-ID: <20241127092856.4106149-2-hongzhen@linux.alibaba.com>
X-Mailer: git-send-email 2.43.5
In-Reply-To: <20241127092856.4106149-1-hongzhen@linux.alibaba.com>
References: <20241127092856.4106149-1-hongzhen@linux.alibaba.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-15.7 required=5.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,DKIM_VALID_EF,ENV_AND_HDR_SPF_MATCH,RCVD_IN_DNSWL_NONE,
	SPF_HELO_NONE,SPF_PASS,UNPARSEABLE_RELAY,USER_IN_DEF_DKIM_WL,
	USER_IN_DEF_SPF_WL autolearn=disabled version=4.0.0
X-Spam-Checker-Version: SpamAssassin 4.0.0 (2022-12-13) on lists.ozlabs.org
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

Currently, setting a default `dev` value (i.e., 0) for directories
during parsing tar files can lead to the following error:

<E> erofs: bogus i_mode (0) @ nid 0
<E> erofs: failed to read inode @ 0

Consider the following incremental build scenario, where the path
"dir1/dir2" is currently being parsed in tarerofs_parse_tar() and
the directory "dir1" has never appeared before. erofs_rebuild_get_dentry()
will call erofs_rebuild_mkdir() to allocate a new inode for "dir1",
with its `dev` field set to 0 by default.

During the dump tree phase, since `dir1->dev` matches `sbi->dev` (both are 0),
erofs_rebuild_load_basedir() will be called to read the contents of directory
"dir1" from the disk. However, since there is no information for the new directory
"dir1" on the disk, the above error occurs.

This patch resolves the above issue by setting the appropriate value
for the directory's `dev` field during the tar file parsing phase.

Fixes: f64d9d02576b ("erofs-utils: introduce incremental builds")
Signed-off-by: Hongzhen Luo <hongzhen@linux.alibaba.com>
---
 include/erofs/rebuild.h | 1 +
 lib/rebuild.c           | 7 +++++--
 lib/tar.c               | 2 ++
 3 files changed, 8 insertions(+), 2 deletions(-)

diff --git a/include/erofs/rebuild.h b/include/erofs/rebuild.h
index b37bc80e8a3c..b71cfdf1fff4 100644
--- a/include/erofs/rebuild.h
+++ b/include/erofs/rebuild.h
@@ -22,6 +22,7 @@ struct erofs_rebuild_getdentry_ctx {
 	bool *whout;
 	bool *opq;
 	bool to_head;
+	int dev;
 };
 
 struct erofs_dentry *erofs_rebuild_get_dentry(struct erofs_rebuild_getdentry_ctx *ctx);
diff --git a/lib/rebuild.c b/lib/rebuild.c
index 58f1701b3721..3fcb5c92b562 100644
--- a/lib/rebuild.c
+++ b/lib/rebuild.c
@@ -27,7 +27,7 @@
 #endif
 
 static struct erofs_dentry *erofs_rebuild_mkdir(struct erofs_inode *dir,
-						const char *s)
+						const char *s, int dev)
 {
 	struct erofs_inode *inode;
 	struct erofs_dentry *d;
@@ -47,6 +47,7 @@ static struct erofs_dentry *erofs_rebuild_mkdir(struct erofs_inode *dir,
 	inode->i_gid = getgid();
 	inode->i_mtime = inode->sbi->build_time;
 	inode->i_mtime_nsec = inode->sbi->build_time_nsec;
+	inode->dev = dev;
 	erofs_init_empty_dir(inode);
 
 	d = erofs_d_alloc(dir, s);
@@ -119,7 +120,7 @@ struct erofs_dentry *erofs_rebuild_get_dentry(struct erofs_rebuild_getdentry_ctx
 				d->type = EROFS_FT_UNKNOWN;
 				d->inode = ctx->pwd;
 			} else {
-				d = erofs_rebuild_mkdir(ctx->pwd, s);
+				d = erofs_rebuild_mkdir(ctx->pwd, s, ctx->dev);
 				if (IS_ERR(d))
 					return d;
 				ctx->pwd = d->inode;
@@ -292,6 +293,7 @@ static int erofs_rebuild_dirent_iter(struct erofs_dir_context *ctx)
 	dctx.aufs = false;
 	dctx.whout = dctx.opq = &dumb;
 	dctx.to_head = false;
+	dctx.dev = dir->sbi->dev;
 	d = erofs_rebuild_get_dentry(&dctx);
 	if (IS_ERR(d)) {
 		ret = PTR_ERR(d);
@@ -460,6 +462,7 @@ static int erofs_rebuild_basedir_dirent_iter(struct erofs_dir_context *ctx)
 	dctx.aufs = false;
 	dctx.whout = dctx.opq = &dumb;
 	dctx.to_head = false;
+	dctx.dev = dir->sbi->dev;
 	d = erofs_rebuild_get_dentry(&dctx);
 	if (IS_ERR(d)) {
 		ret = PTR_ERR(d);
diff --git a/lib/tar.c b/lib/tar.c
index 60f12cc539c9..a118c4fd76de 100644
--- a/lib/tar.c
+++ b/lib/tar.c
@@ -914,6 +914,7 @@ out_eot:
 	dctx.whout = &whout;
 	dctx.opq = &opq;
 	dctx.to_head = true;
+	dctx.dev = tar->dev;
 	d = erofs_rebuild_get_dentry(&dctx);
 	if (IS_ERR(d)) {
 		ret = PTR_ERR(d);
@@ -957,6 +958,7 @@ out_eot:
 		dctx.aufs = tar->aufs;
 		dctx.whout = dctx.opq = &dumb;
 		dctx.to_head = false;
+		dctx.dev = tar->dev;
 		d2 = erofs_rebuild_get_dentry(&dctx);
 		if (IS_ERR(d2)) {
 			ret = PTR_ERR(d2);
-- 
2.43.5

