Return-Path: <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>
X-Original-To: lists+linux-erofs@lfdr.de
Delivered-To: lists+linux-erofs@lfdr.de
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2404:9400:2:0:216:3eff:fee1:b9f1])
	by mail.lfdr.de (Postfix) with ESMTPS id 1E6FD7B199D
	for <lists+linux-erofs@lfdr.de>; Thu, 28 Sep 2023 13:05:15 +0200 (CEST)
Authentication-Results: lists.ozlabs.org;
	dkim=fail reason="signature verification failed" (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20201202 header.b=B+LiYngF;
	dkim-atps=neutral
Received: from boromir.ozlabs.org (localhost [IPv6:::1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4Rx9cS6dQ7z3cg1
	for <lists+linux-erofs@lfdr.de>; Thu, 28 Sep 2023 21:05:12 +1000 (AEST)
X-Original-To: linux-erofs@lists.ozlabs.org
Delivered-To: linux-erofs@lists.ozlabs.org
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20201202 header.b=B+LiYngF;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=kernel.org (client-ip=139.178.84.217; helo=dfw.source.kernel.org; envelope-from=jlayton@kernel.org; receiver=lists.ozlabs.org)
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits))
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4Rx9c16NKFz3cPK
	for <linux-erofs@lists.ozlabs.org>; Thu, 28 Sep 2023 21:04:49 +1000 (AEST)
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
	by dfw.source.kernel.org (Postfix) with ESMTP id 1B827615A9;
	Thu, 28 Sep 2023 11:04:48 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2C7B7C43391;
	Thu, 28 Sep 2023 11:04:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1695899087;
	bh=xLy8ovC/T/DJkHAEAuHt2zyXkBkARonBG5h9l4hgO0A=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=B+LiYngFvmRQJSi8FMS9rA/4kkZ1X9bA5G4LPi7q6jnThxNY8Xq3HC/urRnR2qAiL
	 JHvqriASpJ1H91QoeNbEM1ZaFMQrMunUWdE8MjbtWxamzNeIEE7R8r6HXliwW0NNQB
	 UnQnoyL/b+fRkjeOgV+wOfJKUjXEx+hTD+PXptAQZ5K8x0BFGrs7qurgsxz3yvmMVt
	 GgI2twG3wZUmigYXw/dIaoMnUMGbzqs2ow49shRLU0dwXY56zd3s4XZvC9E/n/hUX5
	 ifNrA//wb4zsSWj5I6RHkHjqGp/0RRxK0LUdieb4g0/XR8KimcqW4rQPfj5lqKs2fv
	 5FaZa0ddIgoBQ==
From: Jeff Layton <jlayton@kernel.org>
To: Alexander Viro <viro@zeniv.linux.org.uk>,
	Christian Brauner <brauner@kernel.org>,
	linux-fsdevel@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH 31/87] fs/erofs: convert to new inode {a,m}time accessors
Date: Thu, 28 Sep 2023 07:02:40 -0400
Message-ID: <20230928110413.33032-30-jlayton@kernel.org>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20230928110413.33032-1-jlayton@kernel.org>
References: <20230928110300.32891-1-jlayton@kernel.org>
 <20230928110413.33032-1-jlayton@kernel.org>
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
Cc: Yue Hu <huyue2@coolpad.com>, linux-erofs@lists.ozlabs.org
Errors-To: linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org
Sender: "Linux-erofs" <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>

Signed-off-by: Jeff Layton <jlayton@kernel.org>
---
 fs/erofs/inode.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/fs/erofs/inode.c b/fs/erofs/inode.c
index edc8ec7581b8..b8ad05b4509d 100644
--- a/fs/erofs/inode.c
+++ b/fs/erofs/inode.c
@@ -175,7 +175,8 @@ static void *erofs_read_inode(struct erofs_buf *buf,
 		vi->chunkbits = sb->s_blocksize_bits +
 			(vi->chunkformat & EROFS_CHUNK_FORMAT_BLKBITS_MASK);
 	}
-	inode->i_mtime = inode->i_atime = inode_get_ctime(inode);
+	inode_set_mtime_to_ts(inode,
+			      inode_set_atime_to_ts(inode, inode_get_ctime(inode)));
 
 	inode->i_flags &= ~S_DAX;
 	if (test_opt(&sbi->opt, DAX_ALWAYS) && S_ISREG(inode->i_mode) &&
-- 
2.41.0

