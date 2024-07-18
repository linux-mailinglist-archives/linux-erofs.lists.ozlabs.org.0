Return-Path: <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>
X-Original-To: lists+linux-erofs@lfdr.de
Delivered-To: lists+linux-erofs@lfdr.de
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	by mail.lfdr.de (Postfix) with ESMTPS id A73409349F7
	for <lists+linux-erofs@lfdr.de>; Thu, 18 Jul 2024 10:33:02 +0200 (CEST)
Authentication-Results: lists.ozlabs.org;
	dkim=pass (1024-bit key; unprotected) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.a=rsa-sha256 header.s=default header.b=LAqiCaYZ;
	dkim-atps=neutral
Received: from boromir.ozlabs.org (localhost [IPv6:::1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4WPmK849bsz3dFS
	for <lists+linux-erofs@lfdr.de>; Thu, 18 Jul 2024 18:33:00 +1000 (AEST)
X-Original-To: linux-erofs@lists.ozlabs.org
Delivered-To: linux-erofs@lists.ozlabs.org
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (1024-bit key; unprotected) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.a=rsa-sha256 header.s=default header.b=LAqiCaYZ;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=linux.alibaba.com (client-ip=115.124.30.112; helo=out30-112.freemail.mail.aliyun.com; envelope-from=hsiangkao@linux.alibaba.com; receiver=lists.ozlabs.org)
Received: from out30-112.freemail.mail.aliyun.com (out30-112.freemail.mail.aliyun.com [115.124.30.112])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4WPmK33FWSz3cPf
	for <linux-erofs@lists.ozlabs.org>; Thu, 18 Jul 2024 18:32:53 +1000 (AEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=linux.alibaba.com; s=default;
	t=1721291569; h=From:To:Subject:Date:Message-ID:MIME-Version;
	bh=yeE4Ova5Bd1gXPT3NGRB3DgKWcltl+BFY40NsxJzq/A=;
	b=LAqiCaYZtmetJPDOHAleokNFjnxiiGl2mY4R1eixGjRbkRuqSut3Fg0vulZnvWjHg7xgig/LSsSOdvAaEatCqSc5yNrOohiDQAUGJBJYMzejumHADAmDnJIY7rLw1qsOQMQOOR2paoh/Mp4FcLL5BeIll20jKwmCWSojWJc4aAg=
X-Alimail-AntiSpam: AC=PASS;BC=-1|-1;BR=01201311R161e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=maildocker-contentspam033068173054;MF=hsiangkao@linux.alibaba.com;NM=1;PH=DS;RN=5;SR=0;TI=SMTPD_---0WAns83J_1721291564;
Received: from x31i01179.sqa.na131.tbsite.net(mailfrom:hsiangkao@linux.alibaba.com fp:SMTPD_---0WAns83J_1721291564)
          by smtp.aliyun-inc.com;
          Thu, 18 Jul 2024 16:32:48 +0800
From: Gao Xiang <hsiangkao@linux.alibaba.com>
To: linux-erofs@lists.ozlabs.org,
	Chao Yu <chao@kernel.org>
Subject: [PATCH v3] erofs: support STATX_DIOALIGN
Date: Thu, 18 Jul 2024 16:32:43 +0800
Message-ID: <20240718083243.2485437-1-hsiangkao@linux.alibaba.com>
X-Mailer: git-send-email 2.43.5
In-Reply-To: <20240718063756.2982763-1-lihongbo22@huawei.com>
References: <20240718063756.2982763-1-lihongbo22@huawei.com>
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
Cc: Gao Xiang <hsiangkao@linux.alibaba.com>, LKML <linux-kernel@vger.kernel.org>
Errors-To: linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org
Sender: "Linux-erofs" <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>

From: Hongbo Li via Linux-erofs <linux-erofs@lists.ozlabs.org>

Add support for STATX_DIOALIGN to erofs, so that direct I/O
alignment restrictions are exposed to userspace in a generic
way.

[Before]
```
./statx_test /mnt/erofs/testfile
statx(/mnt/erofs/testfile) = 0
dio mem align:0
dio offset align:0
```

[After]
```
./statx_test /mnt/erofs/testfile
statx(/mnt/erofs/testfile) = 0
dio mem align:512
dio offset align:512
```

Signed-off-by: Hongbo Li <lihongbo22@huawei.com>
Signed-off-by: Gao Xiang <hsiangkao@linux.alibaba.com>
---
Hi Hongbo,

I tidy up the patch a bit according to the current codebase,
I will apply this later for this cycle.

Also r-v-bs are always welcome...

Thanks,
Gao Xiang

 fs/erofs/inode.c | 19 +++++++++++++++++--
 1 file changed, 17 insertions(+), 2 deletions(-)

diff --git a/fs/erofs/inode.c b/fs/erofs/inode.c
index 5f6439a63af7..43c09aae2afc 100644
--- a/fs/erofs/inode.c
+++ b/fs/erofs/inode.c
@@ -334,14 +334,29 @@ int erofs_getattr(struct mnt_idmap *idmap, const struct path *path,
 		  unsigned int query_flags)
 {
 	struct inode *const inode = d_inode(path->dentry);
+	bool compressed =
+		erofs_inode_is_data_compressed(EROFS_I(inode)->datalayout);
 
-	if (erofs_inode_is_data_compressed(EROFS_I(inode)->datalayout))
+	if (compressed)
 		stat->attributes |= STATX_ATTR_COMPRESSED;
-
 	stat->attributes |= STATX_ATTR_IMMUTABLE;
 	stat->attributes_mask |= (STATX_ATTR_COMPRESSED |
 				  STATX_ATTR_IMMUTABLE);
 
+	/*
+	 * Return the DIO alignment restrictions if requested.
+	 *
+	 * In EROFS, STATX_DIOALIGN is not supported in ondemand mode and
+	 * compressed files, so in these cases we report no DIO support.
+	 */
+	if ((request_mask & STATX_DIOALIGN) && S_ISREG(inode->i_mode)) {
+		stat->result_mask |= STATX_DIOALIGN;
+		if (!erofs_is_fscache_mode(inode->i_sb) && !compressed) {
+			stat->dio_mem_align =
+				bdev_logical_block_size(inode->i_sb->s_bdev);
+			stat->dio_offset_align = stat->dio_mem_align;
+		}
+	}
 	generic_fillattr(idmap, request_mask, inode, stat);
 	return 0;
 }
-- 
2.43.5

