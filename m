Return-Path: <linux-erofs+bounces-698-lists+linux-erofs=lfdr.de@lists.ozlabs.org>
X-Original-To: lists+linux-erofs@lfdr.de
Delivered-To: lists+linux-erofs@lfdr.de
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	by mail.lfdr.de (Postfix) with ESMTPS id 320D7B0D67C
	for <lists+linux-erofs@lfdr.de>; Tue, 22 Jul 2025 12:00:46 +0200 (CEST)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4bmXp34vgmz3bV6;
	Tue, 22 Jul 2025 20:00:43 +1000 (AEST)
X-Original-To: linux-erofs@lists.ozlabs.org
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip=115.124.30.133
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1753178443;
	cv=none; b=Ggl9YtQRBKJJ/rzKw8t9zY8JOEIbuemGw6Wq8dflZIm7C9IJN4H72jM3HITpvmDeMenVX4X5frlu5KfRkLC7s2zDw+y5E3KUfsstxSm5nCEbJyi3/55MDSpaEzv0h+hx/TET2aaqNFGBOytE/K7W3N9RuCoH8FqoZLkzDx1J4qqMTA9eihyLlDH2Hu2GrCZ5Pyy30chu3t4cx4WOvWB+iP+ixYtAOCqoL9jHjzpTQ9n/uY1vcKQDpR3TDc7a9efIFkM5f3o0zJYJTe4lkSdjN7cNS6aTOi9O8xTl1VVmW17VOTUYuanpPqv7YMX5Ak9WMCnP8TyczKQaL9ZiStD86g==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1753178443; c=relaxed/relaxed;
	bh=ZF3uulUA+O49eHkCxAbB2EunI3MkghBKmd/YNGAhKRU=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=J15znD8TAGnQJlnvweHN3SGiu8KCZzgzsNH1+gtOpqVmvcW6Eugyp+EWCdfoyLRrlbMp/KGyMh81KEZ/tSL+eAjzt0/oI7dFa85B+MSGkbWJJ94Xi+QLinSw0o7Qyt379CFbjjFk3V4Wi2UiVRzHiLe7pmOIy+WZ7EFYHgXKgbTlsTzZAEmqc8r6HuPaSK1+yoM40XebkAb5eKZuVce3jq2vhhu9IExm5avBRPpmLhHLSlHGg/1v0ST5NX3WPwpPljceZXC9y5lULDnVs0LKK/cgBhmP7DZXivhBWx/KJvOayqC8zy8/U8ZHukKDVl4om73UauSh/RHIMwwgtpz5ZA==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com; dkim=pass (1024-bit key; unprotected) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.a=rsa-sha256 header.s=default header.b=lSWBxzAV; dkim-atps=neutral; spf=pass (client-ip=115.124.30.133; helo=out30-133.freemail.mail.aliyun.com; envelope-from=hsiangkao@linux.alibaba.com; receiver=lists.ozlabs.org) smtp.mailfrom=linux.alibaba.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (1024-bit key; unprotected) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.a=rsa-sha256 header.s=default header.b=lSWBxzAV;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=linux.alibaba.com (client-ip=115.124.30.133; helo=out30-133.freemail.mail.aliyun.com; envelope-from=hsiangkao@linux.alibaba.com; receiver=lists.ozlabs.org)
Received: from out30-133.freemail.mail.aliyun.com (out30-133.freemail.mail.aliyun.com [115.124.30.133])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4bmXp231vQz2yb9
	for <linux-erofs@lists.ozlabs.org>; Tue, 22 Jul 2025 20:00:40 +1000 (AEST)
DKIM-Signature:v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=linux.alibaba.com; s=default;
	t=1753178437; h=From:To:Subject:Date:Message-ID:MIME-Version;
	bh=ZF3uulUA+O49eHkCxAbB2EunI3MkghBKmd/YNGAhKRU=;
	b=lSWBxzAVejulqNtCsU0y5NODdHNzLOr51Zh38/TRsMS5ePNBkCJLBED+lyrU4FTHoDoc08iRor+YwqhuQTCth5DKeb9josVFdK/VM3DXK/hqPBFlgzl16MZY+KehaPSHbDtEFJE65XJqadl+769Ajds4g5Y16JnD8XY788r+aJc=
Received: from x31i01179.sqa.na131.tbsite.net(mailfrom:hsiangkao@linux.alibaba.com fp:SMTPD_---0WjVvTpN_1753178435 cluster:ay36)
          by smtp.aliyun-inc.com;
          Tue, 22 Jul 2025 18:00:36 +0800
From: Gao Xiang <hsiangkao@linux.alibaba.com>
To: stable@vger.kernel.org,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Jan Kiszka <jan.kiszka@siemens.com>,
	Stefan Kerkmann <s.kerkmann@pengutronix.de>
Cc: linux-erofs@lists.ozlabs.org,
	LKML <linux-kernel@vger.kernel.org>,
	Gao Xiang <hsiangkao@linux.alibaba.com>,
	Yue Hu <huyue2@coolpad.com>,
	Jingbo Xu <jefflexu@linux.alibaba.com>,
	Chao Yu <chao@kernel.org>
Subject: [PATCH 6.1.y 1/5] erofs: get rid of debug_one_dentry()
Date: Tue, 22 Jul 2025 18:00:25 +0800
Message-ID: <20250722100029.3052177-2-hsiangkao@linux.alibaba.com>
X-Mailer: git-send-email 2.43.5
In-Reply-To: <20250722100029.3052177-1-hsiangkao@linux.alibaba.com>
References: <20250722100029.3052177-1-hsiangkao@linux.alibaba.com>
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

commit e324eaa9790614577c93e819651e0a83963dac79 upstream.

Since erofsdump is available, no need to keep this debugging
functionality at all.

Also drop a useless comment since it's the VFS behavior.

Link: https://lore.kernel.org/r/20230114125746.399253-1-xiang@kernel.org
Reviewed-by: Yue Hu <huyue2@coolpad.com>
Reviewed-by: Jingbo Xu <jefflexu@linux.alibaba.com>
Reviewed-by: Chao Yu <chao@kernel.org>
Signed-off-by: Gao Xiang <hsiangkao@linux.alibaba.com>
---
 fs/erofs/dir.c | 17 -----------------
 1 file changed, 17 deletions(-)

diff --git a/fs/erofs/dir.c b/fs/erofs/dir.c
index 966a88cc529e..963bbed0b699 100644
--- a/fs/erofs/dir.c
+++ b/fs/erofs/dir.c
@@ -6,21 +6,6 @@
  */
 #include "internal.h"
 
-static void debug_one_dentry(unsigned char d_type, const char *de_name,
-			     unsigned int de_namelen)
-{
-#ifdef CONFIG_EROFS_FS_DEBUG
-	/* since the on-disk name could not have the trailing '\0' */
-	unsigned char dbg_namebuf[EROFS_NAME_LEN + 1];
-
-	memcpy(dbg_namebuf, de_name, de_namelen);
-	dbg_namebuf[de_namelen] = '\0';
-
-	erofs_dbg("found dirent %s de_len %u d_type %d", dbg_namebuf,
-		  de_namelen, d_type);
-#endif
-}
-
 static int erofs_fill_dentries(struct inode *dir, struct dir_context *ctx,
 			       void *dentry_blk, struct erofs_dirent *de,
 			       unsigned int nameoff, unsigned int maxsize)
@@ -52,10 +37,8 @@ static int erofs_fill_dentries(struct inode *dir, struct dir_context *ctx,
 			return -EFSCORRUPTED;
 		}
 
-		debug_one_dentry(d_type, de_name, de_namelen);
 		if (!dir_emit(ctx, de_name, de_namelen,
 			      le64_to_cpu(de->nid), d_type))
-			/* stopped by some reason */
 			return 1;
 		++de;
 		ctx->pos += sizeof(struct erofs_dirent);
-- 
2.43.5


