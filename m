Return-Path: <linux-erofs+bounces-1706-lists+linux-erofs=lfdr.de@lists.ozlabs.org>
X-Original-To: lists+linux-erofs@lfdr.de
Delivered-To: lists+linux-erofs@lfdr.de
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	by mail.lfdr.de (Postfix) with ESMTPS id 73CB1D00C8C
	for <lists+linux-erofs@lfdr.de>; Thu, 08 Jan 2026 04:07:28 +0100 (CET)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4dmqZj6BSGz2yFq;
	Thu, 08 Jan 2026 14:07:25 +1100 (AEDT)
X-Original-To: linux-erofs@lists.ozlabs.org
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip=115.124.30.118
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1767841645;
	cv=none; b=EJ9qTQVqmA7W/W2aoz3e7bPJ2aH0XDwP1n5DUcBEBkwgSuU6t5TjL109ft2i545e5eZuHp/2vC/40Ucy4paXkdWjpffeSlFYQkAnkbQZRrJR1vlKmZNrHJd0p7MzIyrAQd7sEE0XP+4hXS5RfTuLqPplEN9sMlkWbtIsPP44C4cJ/jQZqLLUetLLPbOkB75/WVNZUAG+iQwjWy/2uJoasrR8XhXho6IGiqCPMTYuesoEQZ391SRXhzyqJ+SpMyeic0Kgf3zylAm6R1eql66JnQoHalTH7NVi7wCuQasJ4wQmQW2AdOrSM0TSdGaWT1zm43BcHzZuYueU7RaSn4C/HQ==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1767841645; c=relaxed/relaxed;
	bh=oQheF5fgsLWjFmn4sCy3TBSdl1g+pvd4CN8mZqdibpE=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=QoNRgjOuLB2tSEewk55UOTluG1c9aWFjwHz5Xznfiyy/MJk1ktmAiM2YtR9JTYeNqI6rF+00mBySiaxU24MYDMWUHod4aJ10+92O0n7L7Ou+P7og//qDVpSfyuvEVLrKxE16Jl3/tmzdD+bw7mM+ipqwSzSUEb+6lfn6XzNgnzvUpEXcnECRZ+w4qcrnzq+tQ4zhNZyIkJiUpQtDP3C1HjhGFDx0xTLNJElty4Bo4oXi/dSFi5bEY06AHchUlmyhLg9JwPNKFoGMe2PBdno5MiGrEyO+K2A5cb4g89PWf2BB4eIR91d7kfnuPH/R3AZoIfG/KVk8q/gsOOxzcrCwZQ==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com; dkim=pass (1024-bit key; unprotected) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.a=rsa-sha256 header.s=default header.b=MvF2hgrW; dkim-atps=neutral; spf=pass (client-ip=115.124.30.118; helo=out30-118.freemail.mail.aliyun.com; envelope-from=hsiangkao@linux.alibaba.com; receiver=lists.ozlabs.org) smtp.mailfrom=linux.alibaba.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (1024-bit key; unprotected) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.a=rsa-sha256 header.s=default header.b=MvF2hgrW;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=linux.alibaba.com (client-ip=115.124.30.118; helo=out30-118.freemail.mail.aliyun.com; envelope-from=hsiangkao@linux.alibaba.com; receiver=lists.ozlabs.org)
Received: from out30-118.freemail.mail.aliyun.com (out30-118.freemail.mail.aliyun.com [115.124.30.118])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4dmqZg30Glz2yF1
	for <linux-erofs@lists.ozlabs.org>; Thu, 08 Jan 2026 14:07:21 +1100 (AEDT)
DKIM-Signature:v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=linux.alibaba.com; s=default;
	t=1767841637; h=From:To:Subject:Date:Message-ID:MIME-Version:Content-Type;
	bh=oQheF5fgsLWjFmn4sCy3TBSdl1g+pvd4CN8mZqdibpE=;
	b=MvF2hgrWTSQPFckj0AlfeKh7td3IrlNgf1NAfZepRrnm3r6YUO1WIFIaikez7N18mb1xJG7ashrId5i1nsnH/JT0MiXMetg8PJCifpI8iDxJHsdKkF4S2GPQtzzaNeFeVrmHLuRfuvXkAbrSK6XOci0vp37FXGkZXlmlDC4U/30=
Received: from x31i01179.sqa.na131.tbsite.net(mailfrom:hsiangkao@linux.alibaba.com fp:SMTPD_---0Wwb0Z-x_1767841631 cluster:ay36)
          by smtp.aliyun-inc.com;
          Thu, 08 Jan 2026 11:07:15 +0800
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
Subject: [PATCH v3 RESEND] erofs: don't bother with s_stack_depth increasing for now
Date: Thu,  8 Jan 2026 11:07:09 +0800
Message-ID: <20260108030709.3305545-1-hsiangkao@linux.alibaba.com>
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
v2->v3 RESEND:
 - Exclude bdev-backed EROFS mounts since it will be a real terminal fs
   as pointed out by Sheng Yong (APEX will rely on this);

 - Preserve previous "Acked-by:" and "Tested-by:" since it's trivial.

 fs/erofs/super.c | 19 +++++++++++++------
 1 file changed, 13 insertions(+), 6 deletions(-)

diff --git a/fs/erofs/super.c b/fs/erofs/super.c
index 937a215f626c..5136cda5972a 100644
--- a/fs/erofs/super.c
+++ b/fs/erofs/super.c
@@ -644,14 +644,21 @@ static int erofs_fc_fill_super(struct super_block *sb, struct fs_context *fc)
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
+			if ((inode->i_sb->s_op == &erofs_sops &&
+			     !inode->i_sb->s_bdev) ||
+			    inode->i_sb->s_stack_depth) {
+				erofs_err(sb, "file-backed mounts cannot be applied to stacked fses");
 				return -ENOTBLK;
 			}
 		}
-- 
2.43.5


