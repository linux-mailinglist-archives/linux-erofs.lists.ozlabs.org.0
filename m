Return-Path: <linux-erofs+bounces-1811-lists+linux-erofs=lfdr.de@lists.ozlabs.org>
X-Original-To: lists+linux-erofs@lfdr.de
Delivered-To: lists+linux-erofs@lfdr.de
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	by mail.lfdr.de (Postfix) with ESMTPS id 3516CD0D56C
	for <lists+linux-erofs@lfdr.de>; Sat, 10 Jan 2026 12:47:39 +0100 (CET)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4dpH1n5Yxvz2y8c;
	Sat, 10 Jan 2026 22:47:25 +1100 (AEDT)
X-Original-To: linux-erofs@lists.ozlabs.org
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip=115.124.30.133
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1768045645;
	cv=none; b=OS6Icq0/2SIBw1JhhYqhOo6WxTwG6tjxrJ8tlmIGdNLBPkR1svbIrsuj3Iq2ubGvARiItN8DyLxrxp+FYViEUcFIV3FF3swq+giD5uv7pOLw0pTsLPYraT0PmFoFvMfo9HVuKJg5dndGc4wSGrzE55fqRU8TRfhyN33LxBKy2JhDr06wXMgt6qyIdUcW5gPs3A38QcCxWFVyQdM4BDxXP6PLVIKocmZ9gpbKLcBm5GhUmMOjJfHZpkF4oE8RTRun7n3ZzCZOHZVUlkKgc4n5Ph9Jy4aKKSe8HCbaacC3INrYRvcMAnugnQI3tgXTiQ6DNFsWD+d4GV06jvQf1PHeTQ==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1768045645; c=relaxed/relaxed;
	bh=/xVX2xwp86WqwqboDTxGebQFvu/A9/i4zeyqWjKoYTI=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=lVzoRjqEfcoUk4pqWyJK75kmQA31ktwrASDnYKMd7YQjSK7qJsjm1NSRPkPx2X+ufkDZZd7hZUhx4nljBskOYfuf2KUb/ecLnwhu4ubNmPvyWGhNFBfFHcHEra/cDwgI6QfmSydFYePtkACgac9XSxowdyTa7Jz1Wki5HBg5orIGTDAeLhQmjXFZ8kZJbKqIvHhatyemYl5+FbyZpfyAPLyqJ7kZjU6i5OI6+tUEMfabKAWF5QGr59+EqQ4nMVL+rZe6WSxVWvFcVmliBv2zIiqJWAJLMu4vqMXj/PFdYfMp2NB4r1MbTA3Tbqfy0fhKvSSELJ7t2c9rpLKSC0GDng==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com; dkim=pass (1024-bit key; unprotected) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.a=rsa-sha256 header.s=default header.b=ROvioUeB; dkim-atps=neutral; spf=pass (client-ip=115.124.30.133; helo=out30-133.freemail.mail.aliyun.com; envelope-from=hsiangkao@linux.alibaba.com; receiver=lists.ozlabs.org) smtp.mailfrom=linux.alibaba.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (1024-bit key; unprotected) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.a=rsa-sha256 header.s=default header.b=ROvioUeB;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=linux.alibaba.com (client-ip=115.124.30.133; helo=out30-133.freemail.mail.aliyun.com; envelope-from=hsiangkao@linux.alibaba.com; receiver=lists.ozlabs.org)
Received: from out30-133.freemail.mail.aliyun.com (out30-133.freemail.mail.aliyun.com [115.124.30.133])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4dpH1k4LQTz2xQs
	for <linux-erofs@lists.ozlabs.org>; Sat, 10 Jan 2026 22:47:20 +1100 (AEDT)
DKIM-Signature:v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=linux.alibaba.com; s=default;
	t=1768045632; h=From:To:Subject:Date:Message-ID:MIME-Version;
	bh=/xVX2xwp86WqwqboDTxGebQFvu/A9/i4zeyqWjKoYTI=;
	b=ROvioUeBGy7xR7PRRW1JhIlmcRBKQu9yAyk15JtPMV3YFx/KdVDnP2ANYT+D6hJYLYk33aecZ8dDgaDeOKvLMlFEyj41mJ2fXgRKBWjoQHnLr5y/hoFmAkRQzDiIA1IQ9Dr3qljfgv/ctXGHpeefrhuzd/SJNteSnJZkEi9nOa0=
Received: from x31i01179.sqa.na131.tbsite.net(mailfrom:hsiangkao@linux.alibaba.com fp:SMTPD_---0WwjsW9U_1768045624 cluster:ay36)
          by smtp.aliyun-inc.com;
          Sat, 10 Jan 2026 19:47:09 +0800
From: Gao Xiang <hsiangkao@linux.alibaba.com>
To: Linus Torvalds <torvalds@linux-foundation.org>,
	linux-erofs@lists.ozlabs.org
Cc: LKML <linux-kernel@vger.kernel.org>,
	Amir Goldstein <amir73il@gmail.com>,
	Alexander Larsson <alexl@redhat.com>,
	Dusty Mabe <dusty@dustymabe.com>,
	Chao Yu <chao@kernel.org>,
	Sheng Yong <shengyong1@xiaomi.com>,
	Zhiguo Niu <zhiguo.niu@unisoc.com>,
	Christian Brauner <brauner@kernel.org>,
	Miklos Szeredi <mszeredi@redhat.com>,
	Gao Xiang <hsiangkao@linux.alibaba.com>
Subject: [PATCH] erofs: fix file-backed mounts no longer working on EROFS partitions
Date: Sat, 10 Jan 2026 19:47:03 +0800
Message-ID: <20260110114703.3461706-1-hsiangkao@linux.alibaba.com>
X-Mailer: git-send-email 2.43.5
In-Reply-To: <CAOQ4uxht2EWvryy9bZw6uRsCyAc6WCHHvAjP=X92x9Pk9CaM0g@mail.gmail.com>
References: <CAOQ4uxht2EWvryy9bZw6uRsCyAc6WCHHvAjP=X92x9Pk9CaM0g@mail.gmail.com>
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

Sheng Yong reported [1] that Android APEX images didn't work with
[PATCH v2] of upstream commit 072a7c7cdbea ("erofs: don't bother
with s_stack_depth increasing for now") because "EROFS-formatted APEX
file images can be stored within an EROFS-formatted Android system
partition."

In response, I sent a quick fat-fingered [PATCH v3] to address the
report.  Unfortunately, the updated condition was incorrect:

         if (erofs_is_fileio_mode(sbi)) {
-            sb->s_stack_depth =
-                file_inode(sbi->dif0.file)->i_sb->s_stack_depth + 1;
-            if (sb->s_stack_depth > FILESYSTEM_MAX_STACK_DEPTH) {
-                erofs_err(sb, "maximum fs stacking depth exceeded");
+            inode = file_inode(sbi->dif0.file);
+            if ((inode->i_sb->s_op == &erofs_sops && !sb->s_bdev) || 
+                inode->i_sb->s_stack_depth) {

The condition `!sb->s_bdev` is always true for all file-backed EROFS
mounts, making the check effectively a no-op.

The real fix tested and confirmed by Sheng Yong [2] at that time was
[PATCH v3 RESEND], which correctly ensures the following EROFS^2 setup
works:
    EROFS (on a block device) + EROFS (file-backed mount)

But sadly I screwed it up again by upstreaming the outdated [PATCH v3]
and I should be blamed.

This patch applies the same logic as the delta between the upstream
[PATCH v3] and the real fix [PATCH v3 RESEND].

Reported-by: Sheng Yong <shengyong1@xiaomi.com>
Closes: https://lore.kernel.org/r/3acec686-4020-4609-aee4-5dae7b9b0093@gmail.com [1]
Fixes: 072a7c7cdbea ("erofs: don't bother with s_stack_depth increasing for now")
Link: https://lore.kernel.org/r/243f57b8-246f-47e7-9fb1-27a771e8e9e8@gmail.com [2]
Signed-off-by: Gao Xiang <hsiangkao@linux.alibaba.com>
---
Hi Linus,

As suggested by Amir, I send out the patch to fix the broken fix.

If possible, could you help apply this patch directly?

If you perfer another pull request I will do later too after a sleep,
but I guess I will just repeat my stupid mistake again in the pull
request and the tag message.

Thanks,
Gao Xiang

 fs/erofs/super.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/fs/erofs/super.c b/fs/erofs/super.c
index e93264034b5d..5136cda5972a 100644
--- a/fs/erofs/super.c
+++ b/fs/erofs/super.c
@@ -655,7 +655,8 @@ static int erofs_fc_fill_super(struct super_block *sb, struct fs_context *fc)
 		 */
 		if (erofs_is_fileio_mode(sbi)) {
 			inode = file_inode(sbi->dif0.file);
-			if ((inode->i_sb->s_op == &erofs_sops && !sb->s_bdev) ||
+			if ((inode->i_sb->s_op == &erofs_sops &&
+			     !inode->i_sb->s_bdev) ||
 			    inode->i_sb->s_stack_depth) {
 				erofs_err(sb, "file-backed mounts cannot be applied to stacked fses");
 				return -ENOTBLK;
-- 
2.43.5


