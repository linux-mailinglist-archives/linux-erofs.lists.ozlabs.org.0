Return-Path: <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>
X-Original-To: lists+linux-erofs@lfdr.de
Delivered-To: lists+linux-erofs@lfdr.de
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	by mail.lfdr.de (Postfix) with ESMTPS id 884C668296F
	for <lists+linux-erofs@lfdr.de>; Tue, 31 Jan 2023 10:48:28 +0100 (CET)
Received: from boromir.ozlabs.org (localhost [IPv6:::1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4P5gGf2hYbz3cGk
	for <lists+linux-erofs@lfdr.de>; Tue, 31 Jan 2023 20:48:26 +1100 (AEDT)
X-Original-To: linux-erofs@lists.ozlabs.org
Delivered-To: linux-erofs@lists.ozlabs.org
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=linux.alibaba.com (client-ip=115.124.30.99; helo=out30-99.freemail.mail.aliyun.com; envelope-from=hsiangkao@linux.alibaba.com; receiver=<UNKNOWN>)
Received: from out30-99.freemail.mail.aliyun.com (out30-99.freemail.mail.aliyun.com [115.124.30.99])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4P5gGZ1ndjz303P
	for <linux-erofs@lists.ozlabs.org>; Tue, 31 Jan 2023 20:48:21 +1100 (AEDT)
X-Alimail-AntiSpam: AC=PASS;BC=-1|-1;BR=01201311R251e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=ay29a033018045170;MF=hsiangkao@linux.alibaba.com;NM=1;PH=DS;RN=2;SR=0;TI=SMTPD_---0VaWFsiw_1675158488;
Received: from e18g06460.et15sqa.tbsite.net(mailfrom:hsiangkao@linux.alibaba.com fp:SMTPD_---0VaWFsiw_1675158488)
          by smtp.aliyun-inc.com;
          Tue, 31 Jan 2023 17:48:15 +0800
From: Gao Xiang <hsiangkao@linux.alibaba.com>
To: linux-erofs@lists.ozlabs.org
Subject: [PATCH] erofs-utils: fix chunk-based image handling without real data
Date: Tue, 31 Jan 2023 17:48:08 +0800
Message-Id: <20230131094808.67525-1-hsiangkao@linux.alibaba.com>
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
Cc: Gao Xiang <hsiangkao@linux.alibaba.com>
Errors-To: linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org
Sender: "Linux-erofs" <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>

Otherwise it will report:
 <I> erofs: total metadata: 982 blocks
 <E> erofs: 	Could not format the device : [Error 5] Input/output error

Fixes: 03cbf7b8f7f7 ("erofs-utils: mkfs: support chunk-based uncompressed files")
Signed-off-by: Gao Xiang <hsiangkao@linux.alibaba.com>
---
 lib/blobchunk.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/lib/blobchunk.c b/lib/blobchunk.c
index 744d054..55e3f85 100644
--- a/lib/blobchunk.c
+++ b/lib/blobchunk.c
@@ -276,6 +276,8 @@ int erofs_blob_remap(void)
 		erofs_bdrop(bh_devt, false);
 		return 0;
 	}
+	if (!length)	/* bail out if there is no chunked data */
+		return 0;
 	bh = erofs_balloc(DATA, length, 0, 0);
 	if (IS_ERR(bh))
 		return PTR_ERR(bh);
-- 
2.24.4

