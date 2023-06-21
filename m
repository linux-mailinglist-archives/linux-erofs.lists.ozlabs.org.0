Return-Path: <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>
X-Original-To: lists+linux-erofs@lfdr.de
Delivered-To: lists+linux-erofs@lfdr.de
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2404:9400:2:0:216:3eff:fee1:b9f1])
	by mail.lfdr.de (Postfix) with ESMTPS id 6EE837387A9
	for <lists+linux-erofs@lfdr.de>; Wed, 21 Jun 2023 16:48:37 +0200 (CEST)
Authentication-Results: lists.ozlabs.org;
	dkim=fail reason="signature verification failed" (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20201202 header.b=hcsmB7v6;
	dkim-atps=neutral
Received: from boromir.ozlabs.org (localhost [IPv6:::1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4QmRFv2RDWz3btc
	for <lists+linux-erofs@lfdr.de>; Thu, 22 Jun 2023 00:48:35 +1000 (AEST)
X-Original-To: linux-erofs@lists.ozlabs.org
Delivered-To: linux-erofs@lists.ozlabs.org
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20201202 header.b=hcsmB7v6;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=kernel.org (client-ip=139.178.84.217; helo=dfw.source.kernel.org; envelope-from=jlayton@kernel.org; receiver=lists.ozlabs.org)
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits))
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4QmRFb5ZCyz3bnf
	for <linux-erofs@lists.ozlabs.org>; Thu, 22 Jun 2023 00:48:19 +1000 (AEST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits))
	(No client certificate requested)
	by dfw.source.kernel.org (Postfix) with ESMTPS id E3B67615A2;
	Wed, 21 Jun 2023 14:48:17 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7A180C433C0;
	Wed, 21 Jun 2023 14:48:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1687358897;
	bh=cPzAVbFk9R0HnrShvi8rLzBxv97vtXRMRe2hrktiDrk=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=hcsmB7v6zbEyvEiZhHfjQHIdGckqwKegVeEVgJ4Igrqhii8bcPxx1YnlpDrpZFirt
	 mxZ4y5XlQKvC2fmPnr2y0g7pGzBBgLi3oM4egpOaxz7t2sS/uDiRn4Pwky3B+39Un4
	 DxF5i0YIVMefv25QXIkzZfvBkc9fbEbs2xRcoYFa+dtuRekYdpqrNaCPEUlCZDKahg
	 pYTF19rBuLHzyN6Imn9cfxrPQSXHdZPZ/FX2vLnzeDGIWU99DBBz34MOlO8F1IFRUh
	 pEGwQ8EqQ+MOwkxxCXi+h+x9kLxdPv1Q3l/lWUzV7oJKvqKHcjQMkHF6e4aoXDDFvy
	 CrYAbHgYPlRrg==
From: Jeff Layton <jlayton@kernel.org>
To: Christian Brauner <brauner@kernel.org>,
	Gao Xiang <xiang@kernel.org>,
	Chao Yu <chao@kernel.org>,
	Yue Hu <huyue2@coolpad.com>,
	Jeffle Xu <jefflexu@linux.alibaba.com>
Subject: [PATCH 26/79] erofs: switch to new ctime accessors
Date: Wed, 21 Jun 2023 10:45:39 -0400
Message-ID: <20230621144735.55953-25-jlayton@kernel.org>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20230621144735.55953-1-jlayton@kernel.org>
References: <20230621144507.55591-1-jlayton@kernel.org>
 <20230621144735.55953-1-jlayton@kernel.org>
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
Cc: linux-erofs@lists.ozlabs.org, Jan Kara <jack@suse.cz>, Al Viro <viro@zeniv.linux.org.uk>, linux-kernel@vger.kernel.org
Errors-To: linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org
Sender: "Linux-erofs" <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>

In later patches, we're going to change how the ctime.tv_nsec field is
utilized. Switch to using accessor functions instead of raw accesses of
inode->i_ctime.

Signed-off-by: Jeff Layton <jlayton@kernel.org>
---
 fs/erofs/inode.c | 16 ++++++++--------
 1 file changed, 8 insertions(+), 8 deletions(-)

diff --git a/fs/erofs/inode.c b/fs/erofs/inode.c
index d70b12b81507..8af56d6d0ff3 100644
--- a/fs/erofs/inode.c
+++ b/fs/erofs/inode.c
@@ -105,8 +105,8 @@ static void *erofs_read_inode(struct erofs_buf *buf,
 		set_nlink(inode, le32_to_cpu(die->i_nlink));
 
 		/* extended inode has its own timestamp */
-		inode->i_ctime.tv_sec = le64_to_cpu(die->i_mtime);
-		inode->i_ctime.tv_nsec = le32_to_cpu(die->i_mtime_nsec);
+		inode_ctime_set_sec(inode, le64_to_cpu(die->i_mtime));
+		inode_ctime_set_nsec(inode, le32_to_cpu(die->i_mtime_nsec));
 
 		inode->i_size = le64_to_cpu(die->i_size);
 
@@ -148,8 +148,8 @@ static void *erofs_read_inode(struct erofs_buf *buf,
 		set_nlink(inode, le16_to_cpu(dic->i_nlink));
 
 		/* use build time for compact inodes */
-		inode->i_ctime.tv_sec = sbi->build_time;
-		inode->i_ctime.tv_nsec = sbi->build_time_nsec;
+		inode_ctime_set_sec(inode, sbi->build_time);
+		inode_ctime_set_nsec(inode, sbi->build_time_nsec);
 
 		inode->i_size = le32_to_cpu(dic->i_size);
 		if (erofs_inode_is_data_compressed(vi->datalayout))
@@ -176,10 +176,10 @@ static void *erofs_read_inode(struct erofs_buf *buf,
 		vi->chunkbits = sb->s_blocksize_bits +
 			(vi->chunkformat & EROFS_CHUNK_FORMAT_BLKBITS_MASK);
 	}
-	inode->i_mtime.tv_sec = inode->i_ctime.tv_sec;
-	inode->i_atime.tv_sec = inode->i_ctime.tv_sec;
-	inode->i_mtime.tv_nsec = inode->i_ctime.tv_nsec;
-	inode->i_atime.tv_nsec = inode->i_ctime.tv_nsec;
+	inode->i_mtime.tv_sec = inode_ctime_peek(inode).tv_sec;
+	inode->i_atime.tv_sec = inode_ctime_peek(inode).tv_sec;
+	inode->i_mtime.tv_nsec = inode_ctime_peek(inode).tv_nsec;
+	inode->i_atime.tv_nsec = inode_ctime_peek(inode).tv_nsec;
 
 	inode->i_flags &= ~S_DAX;
 	if (test_opt(&sbi->opt, DAX_ALWAYS) && S_ISREG(inode->i_mode) &&
-- 
2.41.0

