Return-Path: <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>
X-Original-To: lists+linux-erofs@lfdr.de
Delivered-To: lists+linux-erofs@lfdr.de
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2404:9400:2:0:216:3eff:fee1:b9f1])
	by mail.lfdr.de (Postfix) with ESMTPS id 2D20686F91C
	for <lists+linux-erofs@lfdr.de>; Mon,  4 Mar 2024 04:54:07 +0100 (CET)
Authentication-Results: lists.ozlabs.org;
	dkim=pass (1024-bit key; unprotected) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.a=rsa-sha256 header.s=default header.b=nVcl/CXU;
	dkim-atps=neutral
Received: from boromir.ozlabs.org (localhost [IPv6:::1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4Tp4Z460hWz3cGY
	for <lists+linux-erofs@lfdr.de>; Mon,  4 Mar 2024 14:54:04 +1100 (AEDT)
X-Original-To: linux-erofs@lists.ozlabs.org
Delivered-To: linux-erofs@lists.ozlabs.org
Authentication-Results: lists.ozlabs.org;
	dkim=pass (1024-bit key; unprotected) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.a=rsa-sha256 header.s=default header.b=nVcl/CXU;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=linux.alibaba.com (client-ip=115.124.30.99; helo=out30-99.freemail.mail.aliyun.com; envelope-from=hsiangkao@linux.alibaba.com; receiver=lists.ozlabs.org)
Received: from out30-99.freemail.mail.aliyun.com (out30-99.freemail.mail.aliyun.com [115.124.30.99])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4Tp4Yw5fN2z2ygX
	for <linux-erofs@lists.ozlabs.org>; Mon,  4 Mar 2024 14:53:53 +1100 (AEDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=linux.alibaba.com; s=default;
	t=1709524429; h=From:To:Subject:Date:Message-Id:MIME-Version;
	bh=tWOaTiza0KnzciAsTzWfF+Y4WXogwxZOxLtOTQabvJ4=;
	b=nVcl/CXU8LBaUY/5Zrps9Wlt/+VhQmFpZxPDx/B9TR/c3kThhA3DPwt4ak62ONOTlX/5Z2WzD0u0FvgRdaOvRr4dga9HvT7G7BU/4RXetLYtyZ+RUswQYcMl/G9PZukC+dj50hyFdyF1ScApJrcTy5dGFMaJABuDT5hnHT3xf9Y=
X-Alimail-AntiSpam: AC=PASS;BC=-1|-1;BR=01201311R101e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=ay29a033018045176;MF=hsiangkao@linux.alibaba.com;NM=1;PH=DS;RN=8;SR=0;TI=SMTPD_---0W1iD3p9_1709524421;
Received: from e69b19392.et15sqa.tbsite.net(mailfrom:hsiangkao@linux.alibaba.com fp:SMTPD_---0W1iD3p9_1709524421)
          by smtp.aliyun-inc.com;
          Mon, 04 Mar 2024 11:53:47 +0800
From: Gao Xiang <hsiangkao@linux.alibaba.com>
To: linux-erofs@lists.ozlabs.org
Subject: [PATCH] erofs: fix uninitialized page cache reported by KMSAN
Date: Mon,  4 Mar 2024 11:53:39 +0800
Message-Id: <20240304035339.425857-1-hsiangkao@linux.alibaba.com>
X-Mailer: git-send-email 2.39.3
In-Reply-To: <ab2a337d-c2dd-437d-9ab8-e3b837f1ff1a@I-love.SAKURA.ne.jp>
References: <ab2a337d-c2dd-437d-9ab8-e3b837f1ff1a@I-love.SAKURA.ne.jp>
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
Cc: syzbot+7bc44a489f0ef0670bd5@syzkaller.appspotmail.com, Tetsuo Handa <penguin-kernel@I-love.SAKURA.ne.jp>, syzkaller-bugs@googlegroups.com, LKML <linux-kernel@vger.kernel.org>, Roberto Sassu <roberto.sassu@huaweicloud.com>, linux-fsdevel@vger.kernel.org, Gao Xiang <hsiangkao@linux.alibaba.com>
Errors-To: linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org
Sender: "Linux-erofs" <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>

syzbot reports a KMSAN reproducer [1] which generates a crafted
filesystem image and causes IMA to read uninitialized page cache.

Later, (rq->outputsize > rq->inputsize) will be formally supported
after either large uncompressed pclusters (> block size) or big
lclusters are landed.  However, currently there is no way to generate
such filesystems by using mkfs.erofs.

Thus, let's mark this condition as unsupported for now.

[1] https://lore.kernel.org/r/0000000000002be12a0611ca7ff8@google.com

Reported-by: syzbot+7bc44a489f0ef0670bd5@syzkaller.appspotmail.com
Fixes: 1ca01520148a ("erofs: refine z_erofs_transform_plain() for sub-page block support")
Signed-off-by: Gao Xiang <hsiangkao@linux.alibaba.com>
---
 fs/erofs/decompressor.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/fs/erofs/decompressor.c b/fs/erofs/decompressor.c
index d4cee95af14c..2ec9b2bb628d 100644
--- a/fs/erofs/decompressor.c
+++ b/fs/erofs/decompressor.c
@@ -323,7 +323,8 @@ static int z_erofs_transform_plain(struct z_erofs_decompress_req *rq,
 	unsigned int cur = 0, ni = 0, no, pi, po, insz, cnt;
 	u8 *kin;
 
-	DBG_BUGON(rq->outputsize > rq->inputsize);
+	if (rq->outputsize > rq->inputsize)
+		return -EOPNOTSUPP;
 	if (rq->alg == Z_EROFS_COMPRESSION_INTERLACED) {
 		cur = bs - (rq->pageofs_out & (bs - 1));
 		pi = (rq->pageofs_in + rq->inputsize - cur) & ~PAGE_MASK;
-- 
2.39.3

