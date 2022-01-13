Return-Path: <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>
X-Original-To: lists+linux-erofs@lfdr.de
Delivered-To: lists+linux-erofs@lfdr.de
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2404:9400:2:0:216:3eff:fee1:b9f1])
	by mail.lfdr.de (Postfix) with ESMTPS id 1FDA148D1D2
	for <lists+linux-erofs@lfdr.de>; Thu, 13 Jan 2022 06:19:11 +0100 (CET)
Received: from boromir.ozlabs.org (localhost [IPv6:::1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4JZCQh6qSLz2ybK
	for <lists+linux-erofs@lfdr.de>; Thu, 13 Jan 2022 16:19:08 +1100 (AEDT)
X-Original-To: linux-erofs@lists.ozlabs.org
Delivered-To: linux-erofs@lists.ozlabs.org
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized)
 smtp.mailfrom=linux.alibaba.com (client-ip=115.124.30.45;
 helo=out30-45.freemail.mail.aliyun.com;
 envelope-from=hsiangkao@linux.alibaba.com; receiver=<UNKNOWN>)
Received: from out30-45.freemail.mail.aliyun.com
 (out30-45.freemail.mail.aliyun.com [115.124.30.45])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 4JZCQd1ldVz2x9p
 for <linux-erofs@lists.ozlabs.org>; Thu, 13 Jan 2022 16:18:58 +1100 (AEDT)
X-Alimail-AntiSpam: AC=PASS; BC=-1|-1; BR=01201311R161e4; CH=green; DM=||false|;
 DS=||; FP=0|-1|-1|-1|0|-1|-1|-1; HT=e01e01424; MF=hsiangkao@linux.alibaba.com;
 NM=1; PH=DS; RN=5; SR=0; TI=SMTPD_---0V1i7JHA_1642051126; 
Received: from
 e18g09479.et15sqa.tbsite.net(mailfrom:hsiangkao@linux.alibaba.com
 fp:SMTPD_---0V1i7JHA_1642051126) by smtp.aliyun-inc.com(127.0.0.1);
 Thu, 13 Jan 2022 13:18:50 +0800
From: Gao Xiang <hsiangkao@linux.alibaba.com>
To: linux-erofs@lists.ozlabs.org, Chao Yu <chao@kernel.org>,
 Christoph Hellwig <hch@lst.de>
Subject: [PATCH] erofs: fix fsdax partition offset handling
Date: Thu, 13 Jan 2022 13:18:45 +0800
Message-Id: <20220113051845.244461-1-hsiangkao@linux.alibaba.com>
X-Mailer: git-send-email 2.24.4
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
Cc: Gao Xiang <hsiangkao@linux.alibaba.com>,
 LKML <linux-kernel@vger.kernel.org>
Errors-To: linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org
Sender: "Linux-erofs"
 <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>

After seeking time on testing today upstream fsdax, I found it
actually doesn't work well as below:

[  186.492983] ------------[ cut here ]------------
[  186.493629] WARNING: CPU: 1 PID: 205 at fs/iomap/iter.c:33 iomap_iter+0x2f6/0x310

The problem is that m_dax_part_off should be applied to physical
addresses and very sorry about that I didn't catch this eariler.

Anyway, let's fix it up now. Also, I need to find a way to set up
a standalone testcase to look after this later.

Fixes: de2051147771 ("fsdax: shift partition offset handling into the file systems")
Signed-off-by: Gao Xiang <hsiangkao@linux.alibaba.com>
---
 fs/erofs/data.c | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/fs/erofs/data.c b/fs/erofs/data.c
index fa7ddb7ad980..226a57c57ee6 100644
--- a/fs/erofs/data.c
+++ b/fs/erofs/data.c
@@ -252,12 +252,10 @@ static int erofs_iomap_begin(struct inode *inode, loff_t offset, loff_t length,
 		return ret;
 
 	iomap->offset = map.m_la;
-	if (flags & IOMAP_DAX) {
+	if (flags & IOMAP_DAX)
 		iomap->dax_dev = mdev.m_daxdev;
-		iomap->offset += mdev.m_dax_part_off;
-	} else {
+	else
 		iomap->bdev = mdev.m_bdev;
-	}
 	iomap->length = map.m_llen;
 	iomap->flags = 0;
 	iomap->private = NULL;
@@ -284,6 +282,8 @@ static int erofs_iomap_begin(struct inode *inode, loff_t offset, loff_t length,
 	} else {
 		iomap->type = IOMAP_MAPPED;
 		iomap->addr = mdev.m_pa;
+		if (flags & IOMAP_DAX)
+			iomap->addr += mdev.m_dax_part_off;
 	}
 	return 0;
 }
-- 
2.24.4

