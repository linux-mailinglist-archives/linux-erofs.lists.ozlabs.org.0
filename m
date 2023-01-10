Return-Path: <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>
X-Original-To: lists+linux-erofs@lfdr.de
Delivered-To: lists+linux-erofs@lfdr.de
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	by mail.lfdr.de (Postfix) with ESMTPS id 03016663A2A
	for <lists+linux-erofs@lfdr.de>; Tue, 10 Jan 2023 08:49:52 +0100 (CET)
Received: from boromir.ozlabs.org (localhost [IPv6:::1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4NrjdT1J2dz3c9Q
	for <lists+linux-erofs@lfdr.de>; Tue, 10 Jan 2023 18:49:49 +1100 (AEDT)
X-Original-To: linux-erofs@lists.ozlabs.org
Delivered-To: linux-erofs@lists.ozlabs.org
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=linux.alibaba.com (client-ip=115.124.30.7; helo=out30-7.freemail.mail.aliyun.com; envelope-from=hsiangkao@linux.alibaba.com; receiver=<UNKNOWN>)
Received: from out30-7.freemail.mail.aliyun.com (out30-7.freemail.mail.aliyun.com [115.124.30.7])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4NrjdN0CqMz2xH6
	for <linux-erofs@lists.ozlabs.org>; Tue, 10 Jan 2023 18:49:42 +1100 (AEDT)
X-Alimail-AntiSpam: AC=PASS;BC=-1|-1;BR=01201311R241e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=ay29a033018045168;MF=hsiangkao@linux.alibaba.com;NM=1;PH=DS;RN=7;SR=0;TI=SMTPD_---0VZIMt1I_1673336968;
Received: from e18g06460.et15sqa.tbsite.net(mailfrom:hsiangkao@linux.alibaba.com fp:SMTPD_---0VZIMt1I_1673336968)
          by smtp.aliyun-inc.com;
          Tue, 10 Jan 2023 15:49:37 +0800
From: Gao Xiang <hsiangkao@linux.alibaba.com>
To: linux-erofs@lists.ozlabs.org,
	Chao Yu <chao@kernel.org>,
	Yue Hu <huyue2@coolpad.com>,
	Jeffle Xu <jefflexu@linux.alibaba.com>
Subject: [PATCH v2] erofs: fix kvcalloc() misuse with __GFP_NOFAIL
Date: Tue, 10 Jan 2023 15:49:27 +0800
Message-Id: <20230110074927.41651-1-hsiangkao@linux.alibaba.com>
X-Mailer: git-send-email 2.24.4
In-Reply-To: <20230106031937.113318-1-hsiangkao@linux.alibaba.com>
References: <20230106031937.113318-1-hsiangkao@linux.alibaba.com>
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
Cc: Gao Xiang <hsiangkao@linux.alibaba.com>, LKML <linux-kernel@vger.kernel.org>, syzbot+c3729cda01706a04fb98@syzkaller.appspotmail.com
Errors-To: linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org
Sender: "Linux-erofs" <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>

As reported by syzbot [1], kvcalloc() cannot work with  __GFP_NOFAIL.
Let's use kcalloc() instead.

[1] https://lore.kernel.org/r/0000000000007796bd05f1852ec2@google.com
Reported-by: syzbot+c3729cda01706a04fb98@syzkaller.appspotmail.com
Fixes: fe3e5914e6dc ("erofs: try to leave (de)compressed_pages on stack if possible")
Fixes: 4f05687fd703 ("erofs: introduce struct z_erofs_decompress_backend")
Reviewed-by: Chao Yu <chao@kernel.org>
Signed-off-by: Gao Xiang <hsiangkao@linux.alibaba.com>
---
changes since v1:
 - should use kfree() instead of kvfree() as well (Chao);
 - add Chao's r-v-b.

 fs/erofs/zdata.c | 12 ++++++------
 1 file changed, 6 insertions(+), 6 deletions(-)

diff --git a/fs/erofs/zdata.c b/fs/erofs/zdata.c
index ccf7c55d477f..5200bb86e264 100644
--- a/fs/erofs/zdata.c
+++ b/fs/erofs/zdata.c
@@ -1032,12 +1032,12 @@ static int z_erofs_decompress_pcluster(struct z_erofs_decompress_backend *be,
 
 	if (!be->decompressed_pages)
 		be->decompressed_pages =
-			kvcalloc(be->nr_pages, sizeof(struct page *),
-				 GFP_KERNEL | __GFP_NOFAIL);
+			kcalloc(be->nr_pages, sizeof(struct page *),
+				GFP_KERNEL | __GFP_NOFAIL);
 	if (!be->compressed_pages)
 		be->compressed_pages =
-			kvcalloc(pclusterpages, sizeof(struct page *),
-				 GFP_KERNEL | __GFP_NOFAIL);
+			kcalloc(pclusterpages, sizeof(struct page *),
+				GFP_KERNEL | __GFP_NOFAIL);
 
 	z_erofs_parse_out_bvecs(be);
 	err2 = z_erofs_parse_in_bvecs(be, &overlapped);
@@ -1085,7 +1085,7 @@ static int z_erofs_decompress_pcluster(struct z_erofs_decompress_backend *be,
 	}
 	if (be->compressed_pages < be->onstack_pages ||
 	    be->compressed_pages >= be->onstack_pages + Z_EROFS_ONSTACK_PAGES)
-		kvfree(be->compressed_pages);
+		kfree(be->compressed_pages);
 	z_erofs_fill_other_copies(be, err);
 
 	for (i = 0; i < be->nr_pages; ++i) {
@@ -1104,7 +1104,7 @@ static int z_erofs_decompress_pcluster(struct z_erofs_decompress_backend *be,
 	}
 
 	if (be->decompressed_pages != be->onstack_pages)
-		kvfree(be->decompressed_pages);
+		kfree(be->decompressed_pages);
 
 	pcl->length = 0;
 	pcl->partial = true;
-- 
2.24.4

