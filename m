Return-Path: <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>
X-Original-To: lists+linux-erofs@lfdr.de
Delivered-To: lists+linux-erofs@lfdr.de
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2404:9400:2:0:216:3eff:fee1:b9f1])
	by mail.lfdr.de (Postfix) with ESMTPS id 25C9A7B8B7A
	for <lists+linux-erofs@lfdr.de>; Wed,  4 Oct 2023 20:54:47 +0200 (CEST)
Authentication-Results: lists.ozlabs.org;
	dkim=fail reason="signature verification failed" (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20201202 header.b=SYXkeAxA;
	dkim-atps=neutral
Received: from boromir.ozlabs.org (localhost [IPv6:::1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4S13lS70DBz3dF9
	for <lists+linux-erofs@lfdr.de>; Thu,  5 Oct 2023 05:54:44 +1100 (AEDT)
X-Original-To: linux-erofs@lists.ozlabs.org
Delivered-To: linux-erofs@lists.ozlabs.org
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20201202 header.b=SYXkeAxA;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=kernel.org (client-ip=145.40.73.55; helo=sin.source.kernel.org; envelope-from=jlayton@kernel.org; receiver=lists.ozlabs.org)
Received: from sin.source.kernel.org (sin.source.kernel.org [145.40.73.55])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits))
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4S13l44FSrz3cgW
	for <linux-erofs@lists.ozlabs.org>; Thu,  5 Oct 2023 05:54:24 +1100 (AEDT)
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
	by sin.source.kernel.org (Postfix) with ESMTP id 26D41CE1C02;
	Wed,  4 Oct 2023 18:54:23 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BB20DC433CC;
	Wed,  4 Oct 2023 18:54:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1696445662;
	bh=NKCGSIQYRSxC2JawkYr7/YEsyOK3p0HchI8AY3G83h0=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=SYXkeAxA6GIsUxWdFXlhz0b1EoS94hY6W+5ZE496QCIGR6BNog3PmkPhDJUR+hf0F
	 j94xjhCefWxR0P6uPlC/k3Dl2Tf/q4/w9SCwaLsjcO4KSdIuDi+f5MREUd9HpfyqN9
	 qfTlqAupj6ao/VhswuFB8CVLXK9n4XTZJEphvPMq+0SjUf481wKGqONpaozmOTHz1F
	 Zy5OpfvyMzcIwNvid3b9NbGYc0dfw1p97dDsxv9ZPr4QPACKm9TjV2aPM+i6gGwLUP
	 1rYokv2LmDEv2qKfpNT1m7awfHwGPlaxpHCG2jVDxDzQvYe99QiwMJDIG/ujR7a91w
	 XgxekVcEqySnA==
From: Jeff Layton <jlayton@kernel.org>
To: Alexander Viro <viro@zeniv.linux.org.uk>,
	Christian Brauner <brauner@kernel.org>,
	linux-fsdevel@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH v2 32/89] erofs: convert to new timestamp accessors
Date: Wed,  4 Oct 2023 14:52:17 -0400
Message-ID: <20231004185347.80880-30-jlayton@kernel.org>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20231004185347.80880-1-jlayton@kernel.org>
References: <20231004185221.80802-1-jlayton@kernel.org>
 <20231004185347.80880-1-jlayton@kernel.org>
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

Convert to using the new inode timestamp accessor functions.

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

