Return-Path: <linux-erofs+bounces-1705-lists+linux-erofs=lfdr.de@lists.ozlabs.org>
X-Original-To: lists+linux-erofs@lfdr.de
Delivered-To: lists+linux-erofs@lfdr.de
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	by mail.lfdr.de (Postfix) with ESMTPS id C6E13D00B14
	for <lists+linux-erofs@lfdr.de>; Thu, 08 Jan 2026 03:38:49 +0100 (CET)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4dmpxg165zz2yG3;
	Thu, 08 Jan 2026 13:38:47 +1100 (AEDT)
X-Original-To: linux-erofs@lists.ozlabs.org
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip=115.124.30.130
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1767839927;
	cv=none; b=DKAGd3yrMtyxAcIPpHNdQ4WVUjDIPMml3NS0wNPU+OxYrMdxKLDYWf6BiJp7NimQJyvzgKMb5CavDcLZ4jhdvRDWt9VwTlNihX3Vzv0TnbHRuuHjjoxESihZuMA9FErzuA6Fs+aeXndUuLBJBy5MUzmMKy3ESe4uqVlHMdvzd19pZN89nb69rdueVuj0CyxdOaevHJen/S2ZEB2i2WZVsW70gGSTDeazbeFzP9peFPD7ZRAbzr6qjT/qaKJ4GAEnApySHu/TyoOy0mi5zZw4C/FzfQzmi1Z3IgKGYntvHne5uhIFxTSfjWB3X7Ca+mbOZHfJZfLGFzXYA/6tFR+wOQ==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1767839927; c=relaxed/relaxed;
	bh=W7nr+reNeMmKn20VCZiGbi5+jcRMYMQEwOTPVt+E9Ok=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=JHaXuIh8dmKDT2LuwyfvPOB4drXlReeoYhaCCSLeZSfD0Tt/K72pXGmMG+H7GNYyofO+kq4nMFu257If4THV4rzJtEziW1SwNcWURKNv/+7Mt7sZNSHR4W2yaPgPCVNozMwqrUmgn3zLfzFi2YhQCFiM75JHN6blay+cR/auSL/fJ8zRg1rENdZBWh3hr6sgdZmP9QCBNRFOTCYLFwORPRn9Te+PiNYhiCLCMsZ084bVBNFCynbPjDl6OLL89T4lsanLvYnpavtIzIFT9S6LP/pkI2ph6SPad31xWQQVroqzSAl89I3w6jH59L07Ug1rjGAp3Ni85vCeH3XqwEcEQw==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com; dkim=pass (1024-bit key; unprotected) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.a=rsa-sha256 header.s=default header.b=ThnY7Svn; dkim-atps=neutral; spf=pass (client-ip=115.124.30.130; helo=out30-130.freemail.mail.aliyun.com; envelope-from=hsiangkao@linux.alibaba.com; receiver=lists.ozlabs.org) smtp.mailfrom=linux.alibaba.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (1024-bit key; unprotected) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.a=rsa-sha256 header.s=default header.b=ThnY7Svn;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=linux.alibaba.com (client-ip=115.124.30.130; helo=out30-130.freemail.mail.aliyun.com; envelope-from=hsiangkao@linux.alibaba.com; receiver=lists.ozlabs.org)
Received: from out30-130.freemail.mail.aliyun.com (out30-130.freemail.mail.aliyun.com [115.124.30.130])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4dmpxc13HTz2yFq
	for <linux-erofs@lists.ozlabs.org>; Thu, 08 Jan 2026 13:38:42 +1100 (AEDT)
DKIM-Signature:v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=linux.alibaba.com; s=default;
	t=1767839918; h=From:To:Subject:Date:Message-ID:MIME-Version:Content-Type;
	bh=W7nr+reNeMmKn20VCZiGbi5+jcRMYMQEwOTPVt+E9Ok=;
	b=ThnY7Svn1yzrM+b0972N39X0m2+AJbYk1vAuvpqJjLNCEouI1ATUyZ+ksmdFp7RsT1XOkXZBt3LUct7cTnCOt5mVDeoGgApWYjfr3uwRHYMuioVL4iFrx31/fGQQzID+uNhlWGrVQ8eYZsDm09pCDPQPQwn27uVZeZxthZAqzE0=
Received: from x31i01179.sqa.na131.tbsite.net(mailfrom:hsiangkao@linux.alibaba.com fp:SMTPD_---0Wwaxb7U_1767839912 cluster:ay36)
          by smtp.aliyun-inc.com;
          Thu, 08 Jan 2026 10:38:37 +0800
From: Gao Xiang <hsiangkao@linux.alibaba.com>
To: linux-erofs@lists.ozlabs.org
Cc: LKML <linux-kernel@vger.kernel.org>,
	linux-fsdevel <linux-fsdevel@vger.kernel.org>,
	Gao Xiang <hsiangkao@linux.alibaba.com>,
	Dusty Mabe <dusty@dustymabe.com>,
	=?UTF-8?q?Timoth=C3=A9e=20Ravier?= <tim@siosm.fr>,
	=?UTF-8?q?Aleks=C3=A9i=20Naid=C3=A9nov?= <an@digitaltide.io>,
	Amir Goldstein <amir73il@gmail.com>,
	Alexander Larsson <alexl@redhat.com>,
	Christian Brauner <brauner@kernel.org>,
	Miklos Szeredi <mszeredi@redhat.com>,
	Sheng Yong <shengyong1@xiaomi.com>,
	Zhiguo Niu <niuzhiguo84@gmail.com>
Subject: [PATCH v3] erofs: don't bother with s_stack_depth increasing for now
Date: Thu,  8 Jan 2026 10:38:31 +0800
Message-ID: <20260108023831.3263544-1-hsiangkao@linux.alibaba.com>
X-Mailer: git-send-email 2.43.5
In-Reply-To: <3acec686-4020-4609-aee4-5dae7b9b0093@gmail.com>
References: <3acec686-4020-4609-aee4-5dae7b9b0093@gmail.com>
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
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-15.7 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,DKIM_VALID_EF,ENV_AND_HDR_SPF_MATCH,RCVD_IN_DNSWL_NONE,
	SPF_HELO_NONE,SPF_PASS,UNPARSEABLE_RELAY,USER_IN_DEF_DKIM_WL,
	USER_IN_DEF_SPF_WL autolearn=disabled version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-25) on lists.ozlabs.org

Previously, commit d53cd891f0e4 ("erofs: limit the level of fs stacking
for file-backed mounts") bumped `s_stack_depth` by one to avoid kernel
stack overflow when stacking an unlimited number of EROFS on top of
each other.

This fix breaks composefs mounts, which need EROFS+ovl^2 sometimes
(and such setups are already used in production for quite a long time).

One way to fix this regression is to bump FILESYSTEM_MAX_STACK_DEPTH
from 2 to 3, but proving that this is safe in general is a high bar.

After a long discussion on GitHub issues [1] about possible solutions,
one conclusion is that there is no need to support nesting file-backed
EROFS mounts on stacked filesystems, because there is always the option
to use loopback devices as a fallback.

As a quick fix for the composefs regression for this cycle, instead of
bumping `s_stack_depth` for file backed EROFS mounts, we disallow
nesting file-backed EROFS over EROFS and over filesystems with
`s_stack_depth` > 0.

This works for all known file-backed mount use cases (composefs,
containerd, and Android APEX for some Android vendors), and the fix is
self-contained.

Essentially, we are allowing one extra unaccounted fs stacking level of
EROFS below stacking filesystems, but EROFS can only be used in the read
path (i.e. overlayfs lower layers), which typically has much lower stack
usage than the write path.

We can consider increasing FILESYSTEM_MAX_STACK_DEPTH later, after more
stack usage analysis or using alternative approaches, such as splitting
the `s_stack_depth` limitation according to different combinations of
stacking.

Fixes: d53cd891f0e4 ("erofs: limit the level of fs stacking for file-backed mounts")
Reported-and-tested-by: Dusty Mabe <dusty@dustymabe.com>
Reported-by: Timothée Ravier <tim@siosm.fr>
Closes: https://github.com/coreos/fedora-coreos-tracker/issues/2087 [1]
Reported-by: "Alekséi Naidénov" <an@digitaltide.io>
Closes: https://lore.kernel.org/r/CAFHtUiYv4+=+JP_-JjARWjo6OwcvBj1wtYN=z0QXwCpec9sXtg@mail.gmail.com
Acked-by: Amir Goldstein <amir73il@gmail.com>
Acked-by: Alexander Larsson <alexl@redhat.com>
Cc: Christian Brauner <brauner@kernel.org>
Cc: Miklos Szeredi <mszeredi@redhat.com>
Cc: Sheng Yong <shengyong1@xiaomi.com>
Cc: Zhiguo Niu <niuzhiguo84@gmail.com>
Signed-off-by: Gao Xiang <hsiangkao@linux.alibaba.com>
---
v3:
 - Exclude bdev-backed EROFS mounts since it will be a real terminal fs
   as pointed out by Sheng Yong (APEX will rely on this);
 - Preserve previous "Acked-by:" and "Tested-by:" since it's trivial.

 fs/erofs/super.c | 18 ++++++++++++------
 1 file changed, 12 insertions(+), 6 deletions(-)

diff --git a/fs/erofs/super.c b/fs/erofs/super.c
index 937a215f626c..e93264034b5d 100644
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
+			if ((inode->i_sb->s_op == &erofs_sops && !sb->s_bdev) ||
+			    inode->i_sb->s_stack_depth) {
+				erofs_err(sb, "file-backed mounts cannot be applied to stacked fses");
 				return -ENOTBLK;
 			}
 		}
-- 
2.43.5


