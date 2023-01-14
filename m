Return-Path: <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>
X-Original-To: lists+linux-erofs@lfdr.de
Delivered-To: lists+linux-erofs@lfdr.de
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2404:9400:2:0:216:3eff:fee1:b9f1])
	by mail.lfdr.de (Postfix) with ESMTPS id E258366AB6B
	for <lists+linux-erofs@lfdr.de>; Sat, 14 Jan 2023 13:58:21 +0100 (CET)
Received: from boromir.ozlabs.org (localhost [IPv6:::1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4NvJHb48Zbz3cdQ
	for <lists+linux-erofs@lfdr.de>; Sat, 14 Jan 2023 23:58:19 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org;
	dkim=fail reason="signature verification failed" (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20201202 header.b=MAHizgaA;
	dkim-atps=neutral
X-Original-To: linux-erofs@lists.ozlabs.org
Delivered-To: linux-erofs@lists.ozlabs.org
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=kernel.org (client-ip=2604:1380:4601:e00::1; helo=ams.source.kernel.org; envelope-from=xiang@kernel.org; receiver=<UNKNOWN>)
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20201202 header.b=MAHizgaA;
	dkim-atps=neutral
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4NvJHW1lxjz3c6q
	for <linux-erofs@lists.ozlabs.org>; Sat, 14 Jan 2023 23:58:15 +1100 (AEDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.source.kernel.org (Postfix) with ESMTPS id 2C91AB80113;
	Sat, 14 Jan 2023 12:58:10 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CF333C433EF;
	Sat, 14 Jan 2023 12:58:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1673701088;
	bh=vD+R0I/+XGCpx3ixVZETPZPrWFSY/wd9ViAO+3HiKA8=;
	h=From:To:Cc:Subject:Date:From;
	b=MAHizgaAGK4UjLpHpTuBL8u+ujeeQm9FMSmRsrz56wUUmzBwUfH2Cygm+YE34KrYE
	 Rj+cJSq4bF3xbzP0liu1AGzpZYyTIXI80E3V6J0jAx3GwwVke/p04tXpOb+up96g5H
	 wt15siRsXSXn75N00mAIJ9EUxaMTp1eVIu7zLRKfLnQcHfjoKttiXxarSR4CWvOgIF
	 ZadcO3HLTkFV1ePRtPDffVgxHqojiAlC3ANy62KoDe4zcNhAzJHLlVv/QD7uNeT21X
	 hTne/2fnf/A5C72M5B/IEC3yh2Q8j6fCp2aRtEGaUDX8MuRz6IHEWlJDXlNCvV11jm
	 YWuRN1rTQqqPg==
From: Gao Xiang <xiang@kernel.org>
To: linux-erofs@lists.ozlabs.org,
	Chao Yu <chao@kernel.org>,
	Yue Hu <huyue2@coolpad.com>,
	Jingbo Xu <jefflexu@linux.alibaba.com>
Subject: [PATCH 1/2] erofs: get rid of debug_one_dentry()
Date: Sat, 14 Jan 2023 20:57:45 +0800
Message-Id: <20230114125746.399253-1-xiang@kernel.org>
X-Mailer: git-send-email 2.30.2
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
Cc: Gao Xiang <hsiangkao@linux.alibaba.com>, LKML <linux-kernel@vger.kernel.org>
Errors-To: linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org
Sender: "Linux-erofs" <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>

From: Gao Xiang <hsiangkao@linux.alibaba.com>

Since erofsdump is available, no need to keep this debugging
functionality at all.

Also drop a useless comment since it's the VFS behavior.

Signed-off-by: Gao Xiang <hsiangkao@linux.alibaba.com>
---
 fs/erofs/dir.c | 17 -----------------
 1 file changed, 17 deletions(-)

diff --git a/fs/erofs/dir.c b/fs/erofs/dir.c
index ecf28f66b97d..6970b09b8307 100644
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
2.30.2

