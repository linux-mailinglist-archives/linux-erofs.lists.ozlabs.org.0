Return-Path: <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>
X-Original-To: lists+linux-erofs@lfdr.de
Delivered-To: lists+linux-erofs@lfdr.de
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2404:9400:2:0:216:3eff:fee1:b9f1])
	by mail.lfdr.de (Postfix) with ESMTPS id 44B9665FA10
	for <lists+linux-erofs@lfdr.de>; Fri,  6 Jan 2023 04:19:58 +0100 (CET)
Received: from boromir.ozlabs.org (localhost [IPv6:::1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4Np7qw0nh3z3c1p
	for <lists+linux-erofs@lfdr.de>; Fri,  6 Jan 2023 14:19:56 +1100 (AEDT)
X-Original-To: linux-erofs@lists.ozlabs.org
Delivered-To: linux-erofs@lists.ozlabs.org
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=linux.alibaba.com (client-ip=115.124.30.131; helo=out30-131.freemail.mail.aliyun.com; envelope-from=hsiangkao@linux.alibaba.com; receiver=<UNKNOWN>)
Received: from out30-131.freemail.mail.aliyun.com (out30-131.freemail.mail.aliyun.com [115.124.30.131])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4Np7qm3Zrrz2ypJ
	for <linux-erofs@lists.ozlabs.org>; Fri,  6 Jan 2023 14:19:47 +1100 (AEDT)
X-Alimail-AntiSpam: AC=PASS;BC=-1|-1;BR=01201311R191e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=ay29a033018045176;MF=hsiangkao@linux.alibaba.com;NM=1;PH=DS;RN=7;SR=0;TI=SMTPD_---0VYy7CO9_1672975177;
Received: from e18g06460.et15sqa.tbsite.net(mailfrom:hsiangkao@linux.alibaba.com fp:SMTPD_---0VYy7CO9_1672975177)
          by smtp.aliyun-inc.com;
          Fri, 06 Jan 2023 11:19:42 +0800
From: Gao Xiang <hsiangkao@linux.alibaba.com>
To: linux-erofs@lists.ozlabs.org,
	Chao Yu <chao@kernel.org>,
	Yue Hu <huyue2@coolpad.com>,
	Jeffle Xu <jefflexu@linux.alibaba.com>
Subject: [PATCH] erofs: fix kvcalloc() misuse with __GFP_NOFAIL
Date: Fri,  6 Jan 2023 11:19:37 +0800
Message-Id: <20230106031937.113318-1-hsiangkao@linux.alibaba.com>
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
Cc: Gao Xiang <hsiangkao@linux.alibaba.com>, LKML <linux-kernel@vger.kernel.org>, syzbot+c3729cda01706a04fb98@syzkaller.appspotmail.com
Errors-To: linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org
Sender: "Linux-erofs" <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>

As reported by syzbot [1], kvcalloc() cannot work with  __GFP_NOFAIL.
Let's use kcalloc() instead.

[1] https://lore.kernel.org/r/0000000000007796bd05f1852ec2@google.com
Reported-by: syzbot+c3729cda01706a04fb98@syzkaller.appspotmail.com
Signed-off-by: Gao Xiang <hsiangkao@linux.alibaba.com>
---
 fs/erofs/zdata.c | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/fs/erofs/zdata.c b/fs/erofs/zdata.c
index ccf7c55d477f..08e982c77985 100644
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
-- 
2.24.4

