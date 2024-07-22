Return-Path: <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>
X-Original-To: lists+linux-erofs@lfdr.de
Delivered-To: lists+linux-erofs@lfdr.de
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2404:9400:2:0:216:3eff:fee1:b9f1])
	by mail.lfdr.de (Postfix) with ESMTPS id 1B91F9387CE
	for <lists+linux-erofs@lfdr.de>; Mon, 22 Jul 2024 05:51:35 +0200 (CEST)
Authentication-Results: lists.ozlabs.org;
	dkim=pass (1024-bit key; unprotected) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.a=rsa-sha256 header.s=default header.b=VBWpB4FK;
	dkim-atps=neutral
Received: from boromir.ozlabs.org (localhost [IPv6:::1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4WS5tX3g1Cz3cSX
	for <lists+linux-erofs@lfdr.de>; Mon, 22 Jul 2024 13:51:32 +1000 (AEST)
X-Original-To: linux-erofs@lists.ozlabs.org
Delivered-To: linux-erofs@lists.ozlabs.org
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (1024-bit key; unprotected) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.a=rsa-sha256 header.s=default header.b=VBWpB4FK;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=linux.alibaba.com (client-ip=115.124.30.110; helo=out30-110.freemail.mail.aliyun.com; envelope-from=hsiangkao@linux.alibaba.com; receiver=lists.ozlabs.org)
Received: from out30-110.freemail.mail.aliyun.com (out30-110.freemail.mail.aliyun.com [115.124.30.110])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4WS5tQ4jwDz2xYY
	for <linux-erofs@lists.ozlabs.org>; Mon, 22 Jul 2024 13:51:24 +1000 (AEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=linux.alibaba.com; s=default;
	t=1721620278; h=From:To:Subject:Date:Message-ID:MIME-Version;
	bh=gG41asDe00WrhOVbN58kYIBjCmdqNSzuFI+5LAtSebs=;
	b=VBWpB4FKDpnvFmZU7NyGXsuls3oLe08HmB5CSXcA7+DlhjE5GSnUsaqu2CZLkNJ3RrbYQFB1i6kLmIHFW9UkKltqg8ItCgXiK/YUV3pB5B+aqt64Mdcy/NNozsucgsD/yz41dX5S3LRT/iFnS9WcVtqO33L2KFCegr/kH/AzCY8=
X-Alimail-AntiSpam: AC=PASS;BC=-1|-1;BR=01201311R581e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=maildocker-contentspam033037067110;MF=hsiangkao@linux.alibaba.com;NM=1;PH=DS;RN=5;SR=0;TI=SMTPD_---0WAyY.Ac_1721620271;
Received: from x31i01179.sqa.na131.tbsite.net(mailfrom:hsiangkao@linux.alibaba.com fp:SMTPD_---0WAyY.Ac_1721620271)
          by smtp.aliyun-inc.com;
          Mon, 22 Jul 2024 11:51:16 +0800
From: Gao Xiang <hsiangkao@linux.alibaba.com>
To: linux-erofs@lists.ozlabs.org
Subject: [PATCH] erofs: fix race in z_erofs_get_gbuf()
Date: Mon, 22 Jul 2024 11:51:10 +0800
Message-ID: <20240722035110.3456740-1-hsiangkao@linux.alibaba.com>
X-Mailer: git-send-email 2.43.5
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
Cc: Gao Xiang <hsiangkao@linux.alibaba.com>, LKML <linux-kernel@vger.kernel.org>, stable@vger.kernel.org, Chunhai Guo <guochunhai@vivo.com>
Errors-To: linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org
Sender: "Linux-erofs" <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>

In z_erofs_get_gbuf(), the current task may be migrated to another
CPU between `z_erofs_gbuf_id()` and `spin_lock(&gbuf->lock)`.

Therefore, z_erofs_put_gbuf() will trigger the following issue
which was found by stress test:

<2>[772156.434168] kernel BUG at fs/erofs/zutil.c:58!
..
<4>[772156.435007]
<4>[772156.439237] CPU: 0 PID: 3078 Comm: stress Kdump: loaded Tainted: G            E      6.10.0-rc7+ #2
<4>[772156.439239] Hardware name: Alibaba Cloud Alibaba Cloud ECS, BIOS 1.0.0 01/01/2017
<4>[772156.439241] pstate: 83400005 (Nzcv daif +PAN -UAO +TCO +DIT -SSBS BTYPE=--)
<4>[772156.439243] pc : z_erofs_put_gbuf+0x64/0x70 [erofs]
<4>[772156.439252] lr : z_erofs_lz4_decompress+0x600/0x6a0 [erofs]
..
<6>[772156.445958] stress (3127): drop_caches: 1
<4>[772156.446120] Call trace:
<4>[772156.446121]  z_erofs_put_gbuf+0x64/0x70 [erofs]
<4>[772156.446761]  z_erofs_lz4_decompress+0x600/0x6a0 [erofs]
<4>[772156.446897]  z_erofs_decompress_queue+0x740/0xa10 [erofs]
<4>[772156.447036]  z_erofs_runqueue+0x428/0x8c0 [erofs]
<4>[772156.447160]  z_erofs_readahead+0x224/0x390 [erofs]
..

Fixes: f36f3010f676 ("erofs: rename per-CPU buffers to global buffer pool and make it configurable")
Cc: <stable@vger.kernel.org> # 6.10+
Cc: Chunhai Guo <guochunhai@vivo.com>
Signed-off-by: Gao Xiang <hsiangkao@linux.alibaba.com>
---
 fs/erofs/zutil.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/fs/erofs/zutil.c b/fs/erofs/zutil.c
index b80f612867c2..9b53883e5caf 100644
--- a/fs/erofs/zutil.c
+++ b/fs/erofs/zutil.c
@@ -38,11 +38,13 @@ void *z_erofs_get_gbuf(unsigned int requiredpages)
 {
 	struct z_erofs_gbuf *gbuf;
 
+	migrate_disable();
 	gbuf = &z_erofs_gbufpool[z_erofs_gbuf_id()];
 	spin_lock(&gbuf->lock);
 	/* check if the buffer is too small */
 	if (requiredpages > gbuf->nrpages) {
 		spin_unlock(&gbuf->lock);
+		migrate_enable();
 		/* (for sparse checker) pretend gbuf->lock is still taken */
 		__acquire(gbuf->lock);
 		return NULL;
@@ -57,6 +59,7 @@ void z_erofs_put_gbuf(void *ptr) __releases(gbuf->lock)
 	gbuf = &z_erofs_gbufpool[z_erofs_gbuf_id()];
 	DBG_BUGON(gbuf->ptr != ptr);
 	spin_unlock(&gbuf->lock);
+	migrate_enable();
 }
 
 int z_erofs_gbuf_growsize(unsigned int nrpages)
-- 
2.43.5

