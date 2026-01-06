Return-Path: <linux-erofs+bounces-1688-lists+linux-erofs=lfdr.de@lists.ozlabs.org>
X-Original-To: lists+linux-erofs@lfdr.de
Delivered-To: lists+linux-erofs@lfdr.de
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	by mail.lfdr.de (Postfix) with ESMTPS id A839ACF987A
	for <lists+linux-erofs@lfdr.de>; Tue, 06 Jan 2026 18:05:24 +0100 (CET)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4dlyGV0fGNz2yFQ;
	Wed, 07 Jan 2026 04:05:22 +1100 (AEDT)
X-Original-To: linux-erofs@lists.ozlabs.org
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip=115.124.30.130
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1767719122;
	cv=none; b=J84hM07VTu4SS+/BmMv1bnhSMklfekXXJjMwAez+ajRmgAWIQsNWSm/ruf7rgjIiNbu0CTz50oIzSAGchVoMGFzbTdWViYH7wNyA2OWBXNZvBhTQPZTH4reApx1+2/Y2cXxVjIaKUhlncorr7pkE6HuJSRIhxsuJba+fNdgDTLpsqVbekHTRVebT53/Y98j6bE3dcdw10J+IYVwmdzB3NhMkto1C5SfSp3J/by3r5NSZNn2uVttGw1fenvcUBsyaaEx2avfixX22lWDZmqi7mkHwwZeGr2z53bj1e/xpZ9hMKRP6d55J4nkN9xEqHtrpF2ACOY44a82lxG4Hy3liwQ==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1767719122; c=relaxed/relaxed;
	bh=aXch4jQohpoHYe81cmyhNlHvkkcIBdkhTQgc/2+yrkU=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=fKE7OzGTZi5ac1K7vihV869bMZC/FrLPHxg8ARRWwyDSbR7EaPAocAYO1ikjklU+wC733fwQTx4aG1ITVdVYHeptHslhMuaMsnoB1fdFc68k1p1OWeY1ca/ub1okmrjIKqAkx+/zwU7W80il92ViUKD43DS2kBnfgW/gyhjHCHakPj91KBF/t5qvWxfswX5JiyeRbZMm/B/rbLxfxG944rf4SoQr2BWo5v1MLx/PpdsflVAKNjkZZ0EBwn+CSG5w8aWdfac8+q5P0zYnuzLpUPlgQbFb0nRnQEZDoR36mYb+Xi1ZOFllv8dHdIltFDUCiCJl06c+3RDSEx/ZXy2Z6Q==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com; dkim=pass (1024-bit key; unprotected) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.a=rsa-sha256 header.s=default header.b=LWJj23xZ; dkim-atps=neutral; spf=pass (client-ip=115.124.30.130; helo=out30-130.freemail.mail.aliyun.com; envelope-from=hsiangkao@linux.alibaba.com; receiver=lists.ozlabs.org) smtp.mailfrom=linux.alibaba.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (1024-bit key; unprotected) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.a=rsa-sha256 header.s=default header.b=LWJj23xZ;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=linux.alibaba.com (client-ip=115.124.30.130; helo=out30-130.freemail.mail.aliyun.com; envelope-from=hsiangkao@linux.alibaba.com; receiver=lists.ozlabs.org)
Received: from out30-130.freemail.mail.aliyun.com (out30-130.freemail.mail.aliyun.com [115.124.30.130])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4dlyGR158wz2xHt
	for <linux-erofs@lists.ozlabs.org>; Wed, 07 Jan 2026 04:05:16 +1100 (AEDT)
DKIM-Signature:v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=linux.alibaba.com; s=default;
	t=1767719112; h=From:To:Subject:Date:Message-ID:MIME-Version:Content-Type;
	bh=aXch4jQohpoHYe81cmyhNlHvkkcIBdkhTQgc/2+yrkU=;
	b=LWJj23xZrJcN2Ac3S4gf3VEHxZtmlavg6E4BLPDrEs4/24YFnUWQZ+9itGoK/+MClw6A0LeAyRrj3zUZaP+hC7T1LJgUHnAb+rRCNqH5MUSxRtYCdiolAh3BtTOSgsqMguIosKUHL7fmk+G3JiEN9zPda0b6hlIt3P/2FwphOvM=
Received: from x31i01179.sqa.na131.tbsite.net(mailfrom:hsiangkao@linux.alibaba.com fp:SMTPD_---0WwW6HPW_1767719105 cluster:ay36)
          by smtp.aliyun-inc.com;
          Wed, 07 Jan 2026 01:05:11 +0800
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
Subject: [PATCH v2] erofs: don't bother with s_stack_depth increasing for now
Date: Wed,  7 Jan 2026 01:05:03 +0800
Message-ID: <20260106170504.674070-1-hsiangkao@linux.alibaba.com>
X-Mailer: git-send-email 2.43.5
In-Reply-To: <0c34f3fa-c573-4343-b8ea-6832530f0069@linux.alibaba.com>
References: <0c34f3fa-c573-4343-b8ea-6832530f0069@linux.alibaba.com>
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
Reported-by: Dusty Mabe <dusty@dustymabe.com>
Reported-by: Timothée Ravier <tim@siosm.fr>
Closes: https://github.com/coreos/fedora-coreos-tracker/issues/2087 [1]
Reported-by: "Alekséi Naidénov" <an@digitaltide.io>
Closes: https://lore.kernel.org/r/CAFHtUiYv4+=+JP_-JjARWjo6OwcvBj1wtYN=z0QXwCpec9sXtg@mail.gmail.com
Acked-by: Amir Goldstein <amir73il@gmail.com>
Cc: Alexander Larsson <alexl@redhat.com>
Cc: Christian Brauner <brauner@kernel.org>
Cc: Miklos Szeredi <mszeredi@redhat.com>
Cc: Sheng Yong <shengyong1@xiaomi.com>
Cc: Zhiguo Niu <niuzhiguo84@gmail.com>
Signed-off-by: Gao Xiang <hsiangkao@linux.alibaba.com>
---
v2:
 - Update commit message (suggested by Amir in 1-on-1 talk);
 - Add proper `Reported-by:`.

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


