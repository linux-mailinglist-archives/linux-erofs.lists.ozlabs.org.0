Return-Path: <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>
X-Original-To: lists+linux-erofs@lfdr.de
Delivered-To: lists+linux-erofs@lfdr.de
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	by mail.lfdr.de (Postfix) with ESMTPS id 3352D76A690
	for <lists+linux-erofs@lfdr.de>; Tue,  1 Aug 2023 03:48:03 +0200 (CEST)
Received: from boromir.ozlabs.org (localhost [IPv6:::1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4RFJ0K0sKZz2ypx
	for <lists+linux-erofs@lfdr.de>; Tue,  1 Aug 2023 11:48:01 +1000 (AEST)
X-Original-To: linux-erofs@lists.ozlabs.org
Delivered-To: linux-erofs@lists.ozlabs.org
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=linux.alibaba.com (client-ip=115.124.30.112; helo=out30-112.freemail.mail.aliyun.com; envelope-from=hsiangkao@linux.alibaba.com; receiver=lists.ozlabs.org)
Received: from out30-112.freemail.mail.aliyun.com (out30-112.freemail.mail.aliyun.com [115.124.30.112])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4RFJ0F5XP7z2yV5
	for <linux-erofs@lists.ozlabs.org>; Tue,  1 Aug 2023 11:47:56 +1000 (AEST)
X-Alimail-AntiSpam: AC=PASS;BC=-1|-1;BR=01201311R131e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=ay29a033018046050;MF=hsiangkao@linux.alibaba.com;NM=1;PH=DS;RN=6;SR=0;TI=SMTPD_---0VoiopYR_1690854460;
Received: from e18g06460.et15sqa.tbsite.net(mailfrom:hsiangkao@linux.alibaba.com fp:SMTPD_---0VoiopYR_1690854460)
          by smtp.aliyun-inc.com;
          Tue, 01 Aug 2023 09:47:49 +0800
From: Gao Xiang <hsiangkao@linux.alibaba.com>
To: linux-erofs@lists.ozlabs.org
Subject: [PATCH] erofs: drop unnecessary WARN_ON() in erofs_kill_sb()
Date: Tue,  1 Aug 2023 09:47:37 +0800
Message-Id: <20230801014737.28614-1-hsiangkao@linux.alibaba.com>
X-Mailer: git-send-email 2.24.4
In-Reply-To: <20230731-flugbereit-wohnlage-78acdf95ab7e@brauner>
References: <20230731-flugbereit-wohnlage-78acdf95ab7e@brauner>
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
Cc: linux-fsdevel@vger.kernel.org, Gao Xiang <hsiangkao@linux.alibaba.com>, Christian Brauner <brauner@kernel.org>, LKML <linux-kernel@vger.kernel.org>, Christoph Hellwig <hch@lst.de>
Errors-To: linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org
Sender: "Linux-erofs" <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>

Previously, .kill_sb() will be called only after fill_super fails.
It will be changed [1].

Besides, checking for s_magic in erofs_kill_sb() is unnecessary from
any point of view.  Let's get rid of it now.

[1] https://lore.kernel.org/r/20230731-flugbereit-wohnlage-78acdf95ab7e@brauner
Signed-off-by: Gao Xiang <hsiangkao@linux.alibaba.com>
---
will upstream this commit later this week after it lands -next.

 fs/erofs/super.c | 2 --
 1 file changed, 2 deletions(-)

diff --git a/fs/erofs/super.c b/fs/erofs/super.c
index 9d6a3c6158bd..566f68ddfa36 100644
--- a/fs/erofs/super.c
+++ b/fs/erofs/super.c
@@ -889,8 +889,6 @@ static void erofs_kill_sb(struct super_block *sb)
 {
 	struct erofs_sb_info *sbi;
 
-	WARN_ON(sb->s_magic != EROFS_SUPER_MAGIC);
-
 	/* pseudo mount for anon inodes */
 	if (sb->s_flags & SB_KERNMOUNT) {
 		kill_anon_super(sb);
-- 
2.24.4

