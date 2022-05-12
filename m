Return-Path: <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>
X-Original-To: lists+linux-erofs@lfdr.de
Delivered-To: lists+linux-erofs@lfdr.de
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	by mail.lfdr.de (Postfix) with ESMTPS id 16645524C39
	for <lists+linux-erofs@lfdr.de>; Thu, 12 May 2022 13:59:09 +0200 (CEST)
Received: from boromir.ozlabs.org (localhost [IPv6:::1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4KzVgH0Lrbz3br4
	for <lists+linux-erofs@lfdr.de>; Thu, 12 May 2022 21:59:07 +1000 (AEST)
X-Original-To: linux-erofs@lists.ozlabs.org
Delivered-To: linux-erofs@lists.ozlabs.org
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized)
 smtp.mailfrom=linux.alibaba.com (client-ip=47.90.199.14;
 helo=out199-14.us.a.mail.aliyun.com; envelope-from=hsiangkao@linux.alibaba.com;
 receiver=<UNKNOWN>)
Received: from out199-14.us.a.mail.aliyun.com (out199-14.us.a.mail.aliyun.com
 [47.90.199.14])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 4KzVg72S1Nz3bY8
 for <linux-erofs@lists.ozlabs.org>; Thu, 12 May 2022 21:58:57 +1000 (AEST)
X-Alimail-AntiSpam: AC=PASS; BC=-1|-1; BR=01201311R201e4; CH=green; DM=||false|;
 DS=||; FP=0|-1|-1|-1|0|-1|-1|-1; HT=e01e04426; MF=hsiangkao@linux.alibaba.com;
 NM=1; PH=DS; RN=5; SR=0; TI=SMTPD_---0VD-jm4z_1652356714; 
Received: from
 e18g06460.et15sqa.tbsite.net(mailfrom:hsiangkao@linux.alibaba.com
 fp:SMTPD_---0VD-jm4z_1652356714) by smtp.aliyun-inc.com(127.0.0.1);
 Thu, 12 May 2022 19:58:40 +0800
From: Gao Xiang <hsiangkao@linux.alibaba.com>
To: linux-erofs@lists.ozlabs.org,
	Chao Yu <chao@kernel.org>
Subject: [PATCH] erofs: fix buffer copy overflow of ztailpacking feature
Date: Thu, 12 May 2022 19:58:33 +0800
Message-Id: <20220512115833.24175-1-hsiangkao@linux.alibaba.com>
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
Cc: Gao Xiang <hsiangkao@linux.alibaba.com>, Yue Hu <huyue2@yulong.com>,
 LKML <linux-kernel@vger.kernel.org>
Errors-To: linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org
Sender: "Linux-erofs"
 <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>

I got some KASAN report as below:

[   46.959738] ==================================================================
[   46.960430] BUG: KASAN: use-after-free in z_erofs_shifted_transform+0x2bd/0x370
[   46.960430] Read of size 4074 at addr ffff8880300c2f8e by task fssum/188
...
[   46.960430] Call Trace:
[   46.960430]  <TASK>
[   46.960430]  dump_stack_lvl+0x41/0x5e
[   46.960430]  print_report.cold+0xb2/0x6b7
[   46.960430]  ? z_erofs_shifted_transform+0x2bd/0x370
[   46.960430]  kasan_report+0x8a/0x140
[   46.960430]  ? z_erofs_shifted_transform+0x2bd/0x370
[   46.960430]  kasan_check_range+0x14d/0x1d0
[   46.960430]  memcpy+0x20/0x60
[   46.960430]  z_erofs_shifted_transform+0x2bd/0x370
[   46.960430]  z_erofs_decompress_pcluster+0xaae/0x1080

The root cause is that the tail pcluster won't be a complete filesystem
block anymore. So if ztailpacking is used, the second part of an
uncompresed tail pcluster may not be ``rq->pageofs_out``.

Fixes: ab749badf9f4 ("erofs: support unaligned data decompression")
Fixes: cecf864d3d76 ("erofs: support inline data decompression")
Signed-off-by: Gao Xiang <hsiangkao@linux.alibaba.com>
---
 fs/erofs/decompressor.c | 5 +++--
 1 file changed, 3 insertions(+), 2 deletions(-)

diff --git a/fs/erofs/decompressor.c b/fs/erofs/decompressor.c
index 0f445f7e1df8..6dca1900c733 100644
--- a/fs/erofs/decompressor.c
+++ b/fs/erofs/decompressor.c
@@ -320,6 +320,7 @@ static int z_erofs_shifted_transform(struct z_erofs_decompress_req *rq,
 		PAGE_ALIGN(rq->pageofs_out + rq->outputsize) >> PAGE_SHIFT;
 	const unsigned int righthalf = min_t(unsigned int, rq->outputsize,
 					     PAGE_SIZE - rq->pageofs_out);
+	const unsigned int lefthalf = rq->outputsize - righthalf;
 	unsigned char *src, *dst;
 
 	if (nrpages_out > 2) {
@@ -342,10 +343,10 @@ static int z_erofs_shifted_transform(struct z_erofs_decompress_req *rq,
 	if (nrpages_out == 2) {
 		DBG_BUGON(!rq->out[1]);
 		if (rq->out[1] == *rq->in) {
-			memmove(src, src + righthalf, rq->pageofs_out);
+			memmove(src, src + righthalf, lefthalf);
 		} else {
 			dst = kmap_atomic(rq->out[1]);
-			memcpy(dst, src + righthalf, rq->pageofs_out);
+			memcpy(dst, src + righthalf, lefthalf);
 			kunmap_atomic(dst);
 		}
 	}
-- 
2.24.4

