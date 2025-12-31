Return-Path: <linux-erofs+bounces-1671-lists+linux-erofs=lfdr.de@lists.ozlabs.org>
X-Original-To: lists+linux-erofs@lfdr.de
Delivered-To: lists+linux-erofs@lfdr.de
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	by mail.lfdr.de (Postfix) with ESMTPS id 331C7CEC895
	for <lists+linux-erofs@lfdr.de>; Wed, 31 Dec 2025 21:42:45 +0100 (CET)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4dhMN21tPxz2xS6;
	Thu, 01 Jan 2026 07:42:42 +1100 (AEDT)
X-Original-To: linux-erofs@lists.ozlabs.org
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip=115.124.30.118
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1767213762;
	cv=none; b=CsoC5SyR4OeDzjX0KW+tYkA2SDiqITcJxMdTOzeVwY3J3k2AQjE1Jgmhf14050JKZ3OxbIwWK3fDrLScpj8i6UUgtV8vbYM7O5G2HwOoNayXOyg+hDlnQgNosa13QBQCA6K0unzlZPNxSLC18mtacI73C+tvFSgougPFAu0M3CcR45bZY/hwAWIpabedW/zi42ymSr5zeTMS9tEd07gF2HRa451bEYa7GfYyDgAXnM9kdV5q1EVAZEEogB+N9fxFWXvUfW5jrdFJjh7wY+XfLImErCetIZiA/cPBmS97GhqPD1ziiItih3UmrdXA4Y9PIDnuI7kvtEyO0MNUNcCeCQ==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1767213762; c=relaxed/relaxed;
	bh=Bw8yz9UYkEEoUZSlDqyPzOJKY0KLWNDhlh8GnINWqQ4=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=Qj3Knat23FUAQemFMVRxHWvT1pRmIs7ZorHKpiiTStlUC9f/So8SWADzR2fu7H5X87mkawpOnMbLOJ/JFS6PCmHL43FmEZ/NK8R5k7Vk6PyLbUsBIzzCBlJmp4rSQSEoEC8JnfRH6adl6A9S/hg74EhXoIa9YgqfARoN5sENvFdQbtMfA/VsiB7ODn2MtBDy5MScYezqwUOd/f8TXxijqkfrSIJvAoizVmS7ap9kIc3+OHDbE/+9tPfZ7exM1AJY8L6LWBGDc9BguF57amDpL8h4ZKd+o8elG0rsMX8NYRuo61Rg5YMDPROFNcptn7YACrS1ng2URGSbtTDDftfkIw==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com; dkim=pass (1024-bit key; unprotected) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.a=rsa-sha256 header.s=default header.b=UU/y0haa; dkim-atps=neutral; spf=pass (client-ip=115.124.30.118; helo=out30-118.freemail.mail.aliyun.com; envelope-from=hsiangkao@linux.alibaba.com; receiver=lists.ozlabs.org) smtp.mailfrom=linux.alibaba.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (1024-bit key; unprotected) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.a=rsa-sha256 header.s=default header.b=UU/y0haa;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=linux.alibaba.com (client-ip=115.124.30.118; helo=out30-118.freemail.mail.aliyun.com; envelope-from=hsiangkao@linux.alibaba.com; receiver=lists.ozlabs.org)
Received: from out30-118.freemail.mail.aliyun.com (out30-118.freemail.mail.aliyun.com [115.124.30.118])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4dhMMy6D6Sz2xKx
	for <linux-erofs@lists.ozlabs.org>; Thu, 01 Jan 2026 07:42:37 +1100 (AEDT)
DKIM-Signature:v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=linux.alibaba.com; s=default;
	t=1767213752; h=From:To:Subject:Date:Message-ID:MIME-Version;
	bh=Bw8yz9UYkEEoUZSlDqyPzOJKY0KLWNDhlh8GnINWqQ4=;
	b=UU/y0haaZCQ/Tq5wY+7Xr053S9qUiACdrDpR3AEq0NlxFKWH78nrJO84EnyCdJcNSEjpn57qQZ+TJzMUD5zs9JLWhz+yYF0KSRoz/0gtbO4UTAAtCt0oMN84Xb+PXWFBM4/BE00Ke7fu+18UEQXawLG51qdW3fX5b6ysGVoqCJw=
Received: from x31i01179.sqa.na131.tbsite.net(mailfrom:hsiangkao@linux.alibaba.com fp:SMTPD_---0Ww21VLm_1767213745 cluster:ay36)
          by smtp.aliyun-inc.com;
          Thu, 01 Jan 2026 04:42:30 +0800
From: Gao Xiang <hsiangkao@linux.alibaba.com>
To: linux-erofs@lists.ozlabs.org
Cc: LKML <linux-kernel@vger.kernel.org>,
	Gao Xiang <hsiangkao@linux.alibaba.com>,
	Amir Goldstein <amir73il@gmail.com>,
	Alexander Larsson <alexl@redhat.com>,
	Christian Brauner <brauner@kernel.org>,
	Miklos Szeredi <mszeredi@redhat.com>
Subject: [PATCH] erofs: don't bother with s_stack_depth increasing for now
Date: Thu,  1 Jan 2026 04:42:25 +0800
Message-ID: <20251231204225.2752893-1-hsiangkao@linux.alibaba.com>
X-Mailer: git-send-email 2.43.5
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
	DKIM_VALID_AU,DKIM_VALID_EF,ENV_AND_HDR_SPF_MATCH,SPF_HELO_NONE,
	SPF_PASS,UNPARSEABLE_RELAY,USER_IN_DEF_DKIM_WL,USER_IN_DEF_SPF_WL
	autolearn=disabled version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-25) on lists.ozlabs.org

Previously, commit d53cd891f0e4 ("erofs: limit the level of fs stacking
for file-backed mounts") bumped `s_stack_depth` by one to avoid kernel
stack overflow, but it breaks composefs mounts, which need erofs+ovl^2
sometimes (and such setups are already used in production for quite long
time) since `s_stack_depth` can be 3 (i.e., FILESYSTEM_MAX_STACK_DEPTH
needs to change from 2 to 3).

After a long discussion on GitHub issues [1] about possible solutions,
it seems there is no need to support nesting file-backed mounts as one
conclusion (especially when increasing FILESYSTEM_MAX_STACK_DEPTH to 3).
So let's disallow this right now, since there is always a way to use
loopback devices as a fallback.

Then, I started to wonder about an alternative EROFS quick fix to
address the composefs mounts directly for this cycle: since EROFS is the
only fs to support file-backed mounts and other stacked fses will just
bump up `FILESYSTEM_MAX_STACK_DEPTH`, just check that `s_stack_depth`
!= 0 and the backing inode is not from EROFS instead.

At least it works for all known file-backed mount use cases (composefs,
containerd, and Android APEX for some Android vendors), and the fix is
self-contained.

Let's defer increasing FILESYSTEM_MAX_STACK_DEPTH for now.

Fixes: d53cd891f0e4 ("erofs: limit the level of fs stacking for file-backed mounts")
Closes: https://github.com/coreos/fedora-coreos-tracker/issues/2087 [1]
Closes: https://lore.kernel.org/r/CAFHtUiYv4+=+JP_-JjARWjo6OwcvBj1wtYN=z0QXwCpec9sXtg@mail.gmail.com
Cc: Amir Goldstein <amir73il@gmail.com>
Cc: Alexander Larsson <alexl@redhat.com>
Cc: Christian Brauner <brauner@kernel.org>
Cc: Miklos Szeredi <mszeredi@redhat.com>
Signed-off-by: Gao Xiang <hsiangkao@linux.alibaba.com>
---
 fs/erofs/super.c | 18 ++++++++++++------
 1 file changed, 12 insertions(+), 6 deletions(-)

diff --git a/fs/erofs/super.c b/fs/erofs/super.c
index 937a215f626c..0cf41ed7ced8 100644
--- a/fs/erofs/super.c
+++ b/fs/erofs/super.c
@@ -644,14 +644,20 @@ static int erofs_fc_fill_super(struct super_block *sb, struct fs_context *fc)
 		 * fs contexts (including its own) due to self-controlled RO
 		 * accesses/contexts and no side-effect changes that need to
 		 * context save & restore so it can reuse the current thread
-		 * context.  However, it still needs to bump `s_stack_depth` to
-		 * avoid kernel stack overflow from nested filesystems.
+		 * context.
+		 * However, we still need to prevent kernel stack overflow due
+		 * to filesystem nesting: just ensure that s_stack_depth is 0
+		 * to disallow mounting EROFS on stacked filesystems.
+		 * Note: s_stack_depth is not incremented here for now, since
+		 * EROFS is the only fs supporting file-backed mounts for now.
+		 * It MUST change if another fs plans to support them, which
+		 * may also require adjusting FILESYSTEM_MAX_STACK_DEPTH.
 		 */
 		if (erofs_is_fileio_mode(sbi)) {
-			sb->s_stack_depth =
-				file_inode(sbi->dif0.file)->i_sb->s_stack_depth + 1;
-			if (sb->s_stack_depth > FILESYSTEM_MAX_STACK_DEPTH) {
-				erofs_err(sb, "maximum fs stacking depth exceeded");
+			inode = file_inode(sbi->dif0.file);
+			if (inode->i_sb->s_op == &erofs_sops ||
+			    inode->i_sb->s_stack_depth) {
+				erofs_err(sb, "file-backed mounts cannot be applied to stacked fses");
 				return -ENOTBLK;
 			}
 		}
-- 
2.43.5


