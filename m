Return-Path: <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>
X-Original-To: lists+linux-erofs@lfdr.de
Delivered-To: lists+linux-erofs@lfdr.de
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2404:9400:2:0:216:3eff:fee1:b9f1])
	by mail.lfdr.de (Postfix) with ESMTPS id 07CE179C41F
	for <lists+linux-erofs@lfdr.de>; Tue, 12 Sep 2023 05:27:29 +0200 (CEST)
Received: from boromir.ozlabs.org (localhost [IPv6:::1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4Rl8Cf0jHZz3c4l
	for <lists+linux-erofs@lfdr.de>; Tue, 12 Sep 2023 13:27:26 +1000 (AEST)
X-Original-To: linux-erofs@lists.ozlabs.org
Delivered-To: linux-erofs@lists.ozlabs.org
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=linux.alibaba.com (client-ip=115.124.30.101; helo=out30-101.freemail.mail.aliyun.com; envelope-from=hsiangkao@linux.alibaba.com; receiver=lists.ozlabs.org)
Received: from out30-101.freemail.mail.aliyun.com (out30-101.freemail.mail.aliyun.com [115.124.30.101])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4Rl8CV4ggMz2yh5
	for <linux-erofs@lists.ozlabs.org>; Tue, 12 Sep 2023 13:27:16 +1000 (AEST)
X-Alimail-AntiSpam: AC=PASS;BC=-1|-1;BR=01201311R121e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=ay29a033018046056;MF=hsiangkao@linux.alibaba.com;NM=1;PH=DS;RN=2;SR=0;TI=SMTPD_---0Vrv0RbX_1694489224;
Received: from localhost.localdomain(mailfrom:hsiangkao@linux.alibaba.com fp:SMTPD_---0Vrv0RbX_1694489224)
          by smtp.aliyun-inc.com;
          Tue, 12 Sep 2023 11:27:11 +0800
From: Gao Xiang <hsiangkao@linux.alibaba.com>
To: linux-erofs@lists.ozlabs.org
Subject: [PATCH] erofs-utils: lib: suppress a false-positive warning in kite-deflate
Date: Tue, 12 Sep 2023 11:27:01 +0800
Message-Id: <20230912032701.8288-1-hsiangkao@linux.alibaba.com>
X-Mailer: git-send-email 2.40.1
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

`gcc (Debian 13.2.0-2) 13.2.0` gives the following report:

kite_deflate.c: In function 'kite_deflate_writeblock':
kite_deflate.c:428:57: warning: 'distLevels' may be used uninitialized
[-Wmaybe-uninitialized]
428 |                                   fixed ? 5 :
    distLevels[distSlot]);
|                                                         ^
kite_deflate.c:393:34: note: 'distLevels' was declared here
  393 |         const u8 *litLenLevels, *distLevels;

Actually, distLevels won't be used in the static-huffman mode.

Signed-off-by: Gao Xiang <hsiangkao@linux.alibaba.com>
---
 lib/kite_deflate.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/lib/kite_deflate.c b/lib/kite_deflate.c
index 91019e3..8667954 100644
--- a/lib/kite_deflate.c
+++ b/lib/kite_deflate.c
@@ -405,6 +405,7 @@ static void kite_deflate_writeblock(struct kite_deflate *s, bool fixed)
 		distCodes = kstaticHuff_distCodes;
 
 		litLenLevels = kstaticHuff_litLenLevels;
+		distLevels = NULL;
 	}
 
 	for (i = 0; i < s->symbols; ++i) {
-- 
2.40.1

