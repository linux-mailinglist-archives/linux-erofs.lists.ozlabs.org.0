Return-Path: <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>
X-Original-To: lists+linux-erofs@lfdr.de
Delivered-To: lists+linux-erofs@lfdr.de
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2404:9400:2:0:216:3eff:fee1:b9f1])
	by mail.lfdr.de (Postfix) with ESMTPS id CFFAD748CD5
	for <lists+linux-erofs@lfdr.de>; Wed,  5 Jul 2023 21:04:26 +0200 (CEST)
Authentication-Results: lists.ozlabs.org;
	dkim=fail reason="signature verification failed" (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20201202 header.b=aTZ/kFDN;
	dkim-atps=neutral
Received: from boromir.ozlabs.org (localhost [IPv6:::1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4Qx8Gc59ZDz3bnN
	for <lists+linux-erofs@lfdr.de>; Thu,  6 Jul 2023 05:04:24 +1000 (AEST)
X-Original-To: linux-erofs@lists.ozlabs.org
Delivered-To: linux-erofs@lists.ozlabs.org
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20201202 header.b=aTZ/kFDN;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=kernel.org (client-ip=139.178.84.217; helo=dfw.source.kernel.org; envelope-from=jlayton@kernel.org; receiver=lists.ozlabs.org)
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits))
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4Qx8GN4vtzz3btl
	for <linux-erofs@lists.ozlabs.org>; Thu,  6 Jul 2023 05:04:12 +1000 (AEST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits))
	(No client certificate requested)
	by dfw.source.kernel.org (Postfix) with ESMTPS id CFFE7616FD;
	Wed,  5 Jul 2023 19:04:10 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4EC62C433C8;
	Wed,  5 Jul 2023 19:04:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1688583850;
	bh=drNbTch4MFALaAjIb0HJv1jQX0IS4DSN9KjY5vGKrAs=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=aTZ/kFDNnI/Q6Nnc34HxC0VQoYl3zKC53va1kTdUOoKojmOoKUesyDkj6ouWjcOtI
	 0gUwxaA1JhO3R/Y9Z37Kz2eaLuN2OAKZxD/1gnOpT9+sTwL0oO91GR5FxC+/cYLBrq
	 CrC5ozhtoNq9y2bUf3uhRcHTw34CtkUS2tVrSvNUW6pPPQxmW82waJY4frYpdAN8PX
	 AcaM5AAxI+JqFd4dTebrgPUmDqtcERFteRq2GId1n65B7XxKbFnVAOtwhQUHVSSnqM
	 +nxbzXjZX2a6JctMRh4Cw/pXqAo9VrTmqBv5YZdytZjTSqtoej4pEjmQBbApJIocru
	 FYni8LeZ11A3A==
From: Jeff Layton <jlayton@kernel.org>
To: Christian Brauner <brauner@kernel.org>,
	Gao Xiang <xiang@kernel.org>,
	Chao Yu <chao@kernel.org>,
	Yue Hu <huyue2@coolpad.com>,
	Jeffle Xu <jefflexu@linux.alibaba.com>
Subject: [PATCH v2 39/92] erofs: convert to ctime accessor functions
Date: Wed,  5 Jul 2023 15:01:04 -0400
Message-ID: <20230705190309.579783-37-jlayton@kernel.org>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20230705190309.579783-1-jlayton@kernel.org>
References: <20230705185755.579053-1-jlayton@kernel.org>
 <20230705190309.579783-1-jlayton@kernel.org>
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
Cc: linux-fsdevel@vger.kernel.org, linux-erofs@lists.ozlabs.org, Jan Kara <jack@suse.cz>, Al Viro <viro@zeniv.linux.org.uk>, linux-kernel@vger.kernel.org
Errors-To: linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org
Sender: "Linux-erofs" <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>

In later patches, we're going to change how the inode's ctime field is
used. Switch to using accessor functions instead of raw accesses of
inode->i_ctime.

Acked-by: Gao Xiang <xiang@kernel.org>
Signed-off-by: Jeff Layton <jlayton@kernel.org>
---
 fs/erofs/inode.c | 15 +++++++--------
 1 file changed, 7 insertions(+), 8 deletions(-)

diff --git a/fs/erofs/inode.c b/fs/erofs/inode.c
index d70b12b81507..806374d866d1 100644
--- a/fs/erofs/inode.c
+++ b/fs/erofs/inode.c
@@ -105,8 +105,8 @@ static void *erofs_read_inode(struct erofs_buf *buf,
 		set_nlink(inode, le32_to_cpu(die->i_nlink));
 
 		/* extended inode has its own timestamp */
-		inode->i_ctime.tv_sec = le64_to_cpu(die->i_mtime);
-		inode->i_ctime.tv_nsec = le32_to_cpu(die->i_mtime_nsec);
+		inode_set_ctime(inode, le64_to_cpu(die->i_mtime),
+				le32_to_cpu(die->i_mtime_nsec));
 
 		inode->i_size = le64_to_cpu(die->i_size);
 
@@ -148,8 +148,7 @@ static void *erofs_read_inode(struct erofs_buf *buf,
 		set_nlink(inode, le16_to_cpu(dic->i_nlink));
 
 		/* use build time for compact inodes */
-		inode->i_ctime.tv_sec = sbi->build_time;
-		inode->i_ctime.tv_nsec = sbi->build_time_nsec;
+		inode_set_ctime(inode, sbi->build_time, sbi->build_time_nsec);
 
 		inode->i_size = le32_to_cpu(dic->i_size);
 		if (erofs_inode_is_data_compressed(vi->datalayout))
@@ -176,10 +175,10 @@ static void *erofs_read_inode(struct erofs_buf *buf,
 		vi->chunkbits = sb->s_blocksize_bits +
 			(vi->chunkformat & EROFS_CHUNK_FORMAT_BLKBITS_MASK);
 	}
-	inode->i_mtime.tv_sec = inode->i_ctime.tv_sec;
-	inode->i_atime.tv_sec = inode->i_ctime.tv_sec;
-	inode->i_mtime.tv_nsec = inode->i_ctime.tv_nsec;
-	inode->i_atime.tv_nsec = inode->i_ctime.tv_nsec;
+	inode->i_mtime.tv_sec = inode_get_ctime(inode).tv_sec;
+	inode->i_atime.tv_sec = inode_get_ctime(inode).tv_sec;
+	inode->i_mtime.tv_nsec = inode_get_ctime(inode).tv_nsec;
+	inode->i_atime.tv_nsec = inode_get_ctime(inode).tv_nsec;
 
 	inode->i_flags &= ~S_DAX;
 	if (test_opt(&sbi->opt, DAX_ALWAYS) && S_ISREG(inode->i_mode) &&
-- 
2.41.0

