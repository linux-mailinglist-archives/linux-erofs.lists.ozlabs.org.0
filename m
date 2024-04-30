Return-Path: <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>
X-Original-To: lists+linux-erofs@lfdr.de
Delivered-To: lists+linux-erofs@lfdr.de
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2404:9400:2:0:216:3eff:fee1:b9f1])
	by mail.lfdr.de (Postfix) with ESMTPS id B432F8B6A8F
	for <lists+linux-erofs@lfdr.de>; Tue, 30 Apr 2024 08:38:09 +0200 (CEST)
Authentication-Results: lists.ozlabs.org;
	dkim=fail reason="signature verification failed" (2048-bit key; unprotected) header.d=sijam-com.20230601.gappssmtp.com header.i=@sijam-com.20230601.gappssmtp.com header.a=rsa-sha256 header.s=20230601 header.b=fE7fvmI2;
	dkim-atps=neutral
Received: from boromir.ozlabs.org (localhost [IPv6:::1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4VT9W32cnZz3cQf
	for <lists+linux-erofs@lfdr.de>; Tue, 30 Apr 2024 16:38:07 +1000 (AEST)
X-Original-To: linux-erofs@lists.ozlabs.org
Delivered-To: linux-erofs@lists.ozlabs.org
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=sijam-com.20230601.gappssmtp.com header.i=@sijam-com.20230601.gappssmtp.com header.a=rsa-sha256 header.s=20230601 header.b=fE7fvmI2;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=none (no SPF record) smtp.mailfrom=sijam.com (client-ip=2607:f8b0:4864:20::633; helo=mail-pl1-x633.google.com; envelope-from=asai@sijam.com; receiver=lists.ozlabs.org)
Received: from mail-pl1-x633.google.com (mail-pl1-x633.google.com [IPv6:2607:f8b0:4864:20::633])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4VT9Vh3R2vz2xPc
	for <linux-erofs@lists.ozlabs.org>; Tue, 30 Apr 2024 16:37:47 +1000 (AEST)
Received: by mail-pl1-x633.google.com with SMTP id d9443c01a7336-1e3f17c6491so43937475ad.2
        for <linux-erofs@lists.ozlabs.org>; Mon, 29 Apr 2024 23:37:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=sijam-com.20230601.gappssmtp.com; s=20230601; t=1714459064; x=1715063864; darn=lists.ozlabs.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=NYtgXGub8xTUvHs0bxemP67FiG4qUdL0cEfK6+FnaWs=;
        b=fE7fvmI2knloRunzOimnm/aI+XS8Goed9oNEmKoYquCe9fzdxn4pk06ZpdeSc0/OFW
         HS29QE8nSzmVf1Vs2rwYXEVnUsalhjuSD/Pnz1+Kln3hoDl6qHsG8Er8vF2/BCo6dOkS
         Gu9lL0McROLXSWBxFbNJL/qV8kI89fp9f4I3JAlLzr2HHSqvhgX4KIwNmV7jSNKQnS+e
         te2YEF/ViHhHXNg65kDjwdE+c50r9IyUc+H1bRGLFkEhZEVOGspVYJimRaaV6xl/1qOq
         79k9vn1p+KVW27kxVCaJs3XdvEpkeY15hvwhDUBEjzWp7MyTg7739PKbU2WA0VY50moB
         UEFQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1714459064; x=1715063864;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=NYtgXGub8xTUvHs0bxemP67FiG4qUdL0cEfK6+FnaWs=;
        b=Ehcur2Mv89CAtIX/qrwSfJ5mGZqWiQ9FcbbCKkZcDMUxheeAUug/NfTcZJrvDBfn4i
         eic4ZtW4EA5FSdraSk5oe1NrVUC8q58RImnWoZt1FOhNNGy9kMb1fCMQMdL1f5XoavLR
         wIzWL2B9mRSi26El1bYmTw3fZyhSetVOZJFIm8W5F9r2VgC34jXtImy+FeL+p0EOxxvc
         XmZCVw2Ts623i/mwFZA7OL9/p4wYr+o5v5f4KOzuWxrf8uzJaMLWD+xs5OZ0nGGBb3bA
         EJ/kk+Pa7WsLT0F2z3d4YD3t/VwFBL7zRRnpS0z6LfRgb8xjoJXJwyLSMmVkjd/rMhTP
         NS3A==
X-Gm-Message-State: AOJu0YxWMivBGA6Ak6cdsnEy/BOoOlEPR0oTRa5wULS+MT9Hs/Sx2JzD
	GBrY+h1R71xHhwBpZ+1nkdBZZlyuQ6c8INUPNJvHNbgjCySxlgEmbZqng/cmjNQ=
X-Google-Smtp-Source: AGHT+IHaRhTf4Ih2p6sTDvibfVeU0l7Q8KStfihaKearWqBmplHUK5kX4Qvt+sjVBM/UV8JlddB97Q==
X-Received: by 2002:a17:902:fc4c:b0:1eb:73c2:6b4a with SMTP id me12-20020a170902fc4c00b001eb73c26b4amr9425493plb.8.1714459063621;
        Mon, 29 Apr 2024 23:37:43 -0700 (PDT)
Received: from elric.localdomain (i121-112-72-48.s41.a027.ap.plala.or.jp. [121.112.72.48])
        by smtp.gmail.com with ESMTPSA id f8-20020a170902684800b001e83a70d774sm21889057pln.187.2024.04.29.23.37.42
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 29 Apr 2024 23:37:43 -0700 (PDT)
From: Noboru Asai <asai@sijam.com>
To: hsiangkao@linux.alibaba.com
Subject: [PATCH] erofs-utils: simplify file handling
Date: Tue, 30 Apr 2024 15:37:31 +0900
Message-ID: <20240430063731.1013892-1-asai@sijam.com>
X-Mailer: git-send-email 2.44.0
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
Cc: linux-erofs@lists.ozlabs.org
Errors-To: linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org
Sender: "Linux-erofs" <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>

Opening files again when data compression doesn't save space,
simplify file handling.

* remove dup and lseek.
* call pthread_cond_signal once per file.

I think the probability of the above case occurring is a few percent.

Signed-off-by: Noboru Asai <asai@sijam.com>
---
 lib/compress.c | 11 ++++++-----
 lib/inode.c    | 24 ++++++++++++------------
 2 files changed, 18 insertions(+), 17 deletions(-)

diff --git a/lib/compress.c b/lib/compress.c
index 7fef698..4c7351f 100644
--- a/lib/compress.c
+++ b/lib/compress.c
@@ -1261,8 +1261,10 @@ void z_erofs_mt_workfn(struct erofs_work *work, void *tlsp)
 out:
 	cwork->errcode = ret;
 	pthread_mutex_lock(&ictx->mutex);
-	++ictx->nfini;
-	pthread_cond_signal(&ictx->cond);
+	if (++ictx->nfini == ictx->seg_num) {
+		close(ictx->fd);
+		pthread_cond_signal(&ictx->cond);
+	}
 	pthread_mutex_unlock(&ictx->mutex);
 }
 
@@ -1406,7 +1408,6 @@ int erofs_mt_write_compressed_file(struct z_erofs_compress_ictx *ictx)
 			blkaddr - compressed_blocks, compressed_blocks);
 
 out:
-	close(ictx->fd);
 	free(ictx);
 	return ret;
 }
@@ -1456,7 +1457,6 @@ void *erofs_begin_compressed_file(struct erofs_inode *inode, int fd, u64 fpos)
 		ictx = malloc(sizeof(*ictx));
 		if (!ictx)
 			return ERR_PTR(-ENOMEM);
-		ictx->fd = dup(fd);
 	} else {
 #ifdef EROFS_MT_ENABLED
 		pthread_mutex_lock(&g_ictx.mutex);
@@ -1466,8 +1466,8 @@ void *erofs_begin_compressed_file(struct erofs_inode *inode, int fd, u64 fpos)
 		pthread_mutex_unlock(&g_ictx.mutex);
 #endif
 		ictx = &g_ictx;
-		ictx->fd = fd;
 	}
+	ictx->fd = fd;
 
 	ictx->ccfg = &erofs_ccfg[inode->z_algorithmtype[0]];
 	inode->z_algorithmtype[0] = ictx->ccfg->algorithmtype;
@@ -1551,6 +1551,7 @@ int erofs_write_compressed_file(struct z_erofs_compress_ictx *ictx)
 	init_list_head(&sctx.extents);
 
 	ret = z_erofs_compress_segment(&sctx, -1, blkaddr);
+	close(ictx->fd);
 	if (ret)
 		goto err_free_idata;
 
diff --git a/lib/inode.c b/lib/inode.c
index 44d684f..a30975b 100644
--- a/lib/inode.c
+++ b/lib/inode.c
@@ -1112,27 +1112,27 @@ static void erofs_fixup_meta_blkaddr(struct erofs_inode *rootdir)
 struct erofs_mkfs_job_ndir_ctx {
 	struct erofs_inode *inode;
 	void *ictx;
-	int fd;
 };
 
 static int erofs_mkfs_job_write_file(struct erofs_mkfs_job_ndir_ctx *ctx)
 {
 	struct erofs_inode *inode = ctx->inode;
+	int fd;
 	int ret;
 
 	if (ctx->ictx) {
 		ret = erofs_write_compressed_file(ctx->ictx);
 		if (ret != -ENOSPC)
-			goto out;
-		if (lseek(ctx->fd, 0, SEEK_SET) < 0) {
-			ret = -errno;
-			goto out;
-		}
+			return ret;
 	}
+
 	/* fallback to all data uncompressed */
-	ret = erofs_write_unencoded_file(inode, ctx->fd, 0);
-out:
-	close(ctx->fd);
+	fd = open(inode->i_srcpath, O_RDONLY | O_BINARY);
+	if (fd < 0)
+		return -errno;
+	ret = erofs_write_unencoded_file(inode, fd, 0);
+	close(fd);
+
 	return ret;
 }
 
@@ -1393,14 +1393,14 @@ static int erofs_mkfs_handle_inode(struct erofs_inode *inode)
 		struct erofs_mkfs_job_ndir_ctx ctx = { .inode = inode };
 
 		if (!S_ISLNK(inode->i_mode) && inode->i_size) {
-			ctx.fd = open(inode->i_srcpath, O_RDONLY | O_BINARY);
-			if (ctx.fd < 0)
+			int fd = open(inode->i_srcpath, O_RDONLY | O_BINARY);
+			if (fd < 0)
 				return -errno;
 
 			if (cfg.c_compr_opts[0].alg &&
 			    erofs_file_is_compressible(inode)) {
 				ctx.ictx = erofs_begin_compressed_file(inode,
-								ctx.fd, 0);
+								fd, 0);
 				if (IS_ERR(ctx.ictx))
 					return PTR_ERR(ctx.ictx);
 			}
-- 
2.44.0

