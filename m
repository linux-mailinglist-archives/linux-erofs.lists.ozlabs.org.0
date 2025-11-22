Return-Path: <linux-erofs+bounces-1424-lists+linux-erofs=lfdr.de@lists.ozlabs.org>
X-Original-To: lists+linux-erofs@lfdr.de
Delivered-To: lists+linux-erofs@lfdr.de
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	by mail.lfdr.de (Postfix) with ESMTPS id BDA99C7C894
	for <lists+linux-erofs@lfdr.de>; Sat, 22 Nov 2025 07:23:58 +0100 (CET)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4dD29830xpz30B7;
	Sat, 22 Nov 2025 17:23:56 +1100 (AEDT)
X-Original-To: linux-erofs@lists.ozlabs.org
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip=115.124.30.118
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1763792636;
	cv=none; b=oJeZz+w1W09xmues7I+FX0x1/kGZkY7SSY+l191L6pE1Ejz9SsPbO4AFi95l+EBeGUm9yxNfLl8NakaCgunEh9h2P3hmzK9fQ9pJY3cUEQwXmK3takyYPfnN/Izv5CYVjxBj5CVd83tJ+ib7MZRTC1EAmC7tpODG4IUAbRlOWWMhFfmA8xLmYiF6jW4zM73w2IBttHiXoT2J4/KaxryQj89kkI41ayng0GT/1rfcaiYJOeDDIjZuey86JgXq/M6r7wOPT02keulVI75vHpfwDxt5HtWEgdgG5pGiyKrK9b0faJrzT3ebgGMUA0UPcbB1D1DN5AZrCVtTOjAUBgu2Ig==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1763792636; c=relaxed/relaxed;
	bh=BtUfsyquN9hxwRTgOZsv8MVWTwMe9z1a+cT1ilPEt98=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=ni5ikij+CC6gOW71UzqME1uU11Vnw0Zuj6Ft2ClQzdCO3Ks0ov0H6bYs68AbH5dPH/V/vhfGYG980HRjYJ3WpaBfDvZDJ6+6b3zbvA8eo+nAek59i06fPR+QZfH8sw4s87fNzaMloquX/mdMG8I2XiJxBPyE+c346l/QB/McrdpIUGckFMX4RQV8Fo9rWelAWBKOhTfVd9oZ2ytGPrLTpELhQr30yP1FySlLUr4D+lKOu1bHmdyklXbvEtk1GuMUA+j4UcrxxSZgeqhBPoBZ7ExKPcPTrnfGgGeP9+qpsVob2w11QxL+aa2pU5CC+EcAlhTTLDIfkM3EbHQ/hA/KtA==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com; dkim=pass (1024-bit key; unprotected) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.a=rsa-sha256 header.s=default header.b=R58u5pJ5; dkim-atps=neutral; spf=pass (client-ip=115.124.30.118; helo=out30-118.freemail.mail.aliyun.com; envelope-from=hsiangkao@linux.alibaba.com; receiver=lists.ozlabs.org) smtp.mailfrom=linux.alibaba.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (1024-bit key; unprotected) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.a=rsa-sha256 header.s=default header.b=R58u5pJ5;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=linux.alibaba.com (client-ip=115.124.30.118; helo=out30-118.freemail.mail.aliyun.com; envelope-from=hsiangkao@linux.alibaba.com; receiver=lists.ozlabs.org)
Received: from out30-118.freemail.mail.aliyun.com (out30-118.freemail.mail.aliyun.com [115.124.30.118])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4dD2954zR8z2yv8
	for <linux-erofs@lists.ozlabs.org>; Sat, 22 Nov 2025 17:23:50 +1100 (AEDT)
DKIM-Signature:v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=linux.alibaba.com; s=default;
	t=1763792625; h=From:To:Subject:Date:Message-ID:MIME-Version;
	bh=BtUfsyquN9hxwRTgOZsv8MVWTwMe9z1a+cT1ilPEt98=;
	b=R58u5pJ5Trepnu++I6PBEdtB5sPDX/LlDJmTsq0xGtRLZwTqUGVmYbPeKwxSQuwwKC5Weq1bV1kqh7DTil7raYOTLLIdgU/5ezM5lsgDwJCmtK+YVlGaXTlG87NKw4Nk7ROI0luqirvaslyLAK/13aowyuBQvW5GMj481w+EpzY=
Received: from x31i01179.sqa.na131.tbsite.net(mailfrom:hsiangkao@linux.alibaba.com fp:SMTPD_---0Wt3AgA3_1763792614 cluster:ay36)
          by smtp.aliyun-inc.com;
          Sat, 22 Nov 2025 14:23:40 +0800
From: Gao Xiang <hsiangkao@linux.alibaba.com>
To: linux-erofs@lists.ozlabs.org
Cc: LKML <linux-kernel@vger.kernel.org>,
	Christian Brauner <brauner@kernel.org>,
	Jan Kara <jack@suse.cz>,
	Gao Xiang <hsiangkao@linux.alibaba.com>,
	Sheng Yong <shengyong1@xiaomi.com>
Subject: [PATCH v2] erofs: limit the level of fs stacking for file-backed mounts
Date: Sat, 22 Nov 2025 14:23:32 +0800
Message-ID: <20251122062332.1408580-1-hsiangkao@linux.alibaba.com>
X-Mailer: git-send-email 2.43.5
In-Reply-To: <20251121134647.104354-1-hsiangkao@linux.alibaba.com>
References: <20251121134647.104354-1-hsiangkao@linux.alibaba.com>
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

Otherwise, it could cause potential kernel stack overflow (e.g., EROFS
mounting itself).

Reviewed-by: Sheng Yong <shengyong1@xiaomi.com>
Fixes: fb176750266a ("erofs: add file-backed mount support")
Signed-off-by: Gao Xiang <hsiangkao@linux.alibaba.com>
---
Change since v1:
 - Return -ENOTBLK instead of -EINVAL since userspace tools like
   util-linux will fall back to using loop to mount again.

   Don't use -ELOOP compared to other stacked fses, since -ENOTBLK is
   more suitable: it means the kernel can't handle it anymore.

 fs/erofs/super.c | 16 ++++++++++++++++
 1 file changed, 16 insertions(+)

diff --git a/fs/erofs/super.c b/fs/erofs/super.c
index f3f8d8c066e4..2db534f76464 100644
--- a/fs/erofs/super.c
+++ b/fs/erofs/super.c
@@ -639,6 +639,22 @@ static int erofs_fc_fill_super(struct super_block *sb, struct fs_context *fc)
 
 	sbi->blkszbits = PAGE_SHIFT;
 	if (!sb->s_bdev) {
+		/*
+		 * (File-backed mounts) EROFS claims it's safe to nest other
+		 * fs contexts (including its own) due to self-controlled RO
+		 * accesses/contexts and no side-effect changes that need to
+		 * context save & restore so it can reuse the current thread
+		 * context.  However, it still needs to bump `s_stack_depth` to
+		 * avoid kernel stack overflow from nested filesystems.
+		 */
+		if (erofs_is_fileio_mode(sbi)) {
+			sb->s_stack_depth =
+				file_inode(sbi->dif0.file)->i_sb->s_stack_depth + 1;
+			if (sb->s_stack_depth > FILESYSTEM_MAX_STACK_DEPTH) {
+				erofs_err(sb, "maximum fs stacking depth exceeded");
+				return -ENOTBLK;
+			}
+		}
 		sb->s_blocksize = PAGE_SIZE;
 		sb->s_blocksize_bits = PAGE_SHIFT;
 
-- 
2.43.5


