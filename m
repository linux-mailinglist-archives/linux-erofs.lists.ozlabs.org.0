Return-Path: <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>
X-Original-To: lists+linux-erofs@lfdr.de
Delivered-To: lists+linux-erofs@lfdr.de
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2404:9400:2:0:216:3eff:fee1:b9f1])
	by mail.lfdr.de (Postfix) with ESMTPS id 3BC2F69FBB6
	for <lists+linux-erofs@lfdr.de>; Wed, 22 Feb 2023 20:08:35 +0100 (CET)
Received: from boromir.ozlabs.org (localhost [IPv6:::1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4PMQfn0nv9z3bh1
	for <lists+linux-erofs@lfdr.de>; Thu, 23 Feb 2023 06:08:33 +1100 (AEDT)
X-Original-To: linux-erofs@lists.ozlabs.org
Delivered-To: linux-erofs@lists.ozlabs.org
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=linux.alibaba.com (client-ip=115.124.30.132; helo=out30-132.freemail.mail.aliyun.com; envelope-from=hsiangkao@linux.alibaba.com; receiver=<UNKNOWN>)
Received: from out30-132.freemail.mail.aliyun.com (out30-132.freemail.mail.aliyun.com [115.124.30.132])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4PMQfj3tKrz3bwQ
	for <linux-erofs@lists.ozlabs.org>; Thu, 23 Feb 2023 06:08:28 +1100 (AEDT)
X-Alimail-AntiSpam: AC=PASS;BC=-1|-1;BR=01201311R101e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=ay29a033018046060;MF=hsiangkao@linux.alibaba.com;NM=1;PH=DS;RN=2;SR=0;TI=SMTPD_---0VcHjprx_1677092895;
Received: from e18g06460.et15sqa.tbsite.net(mailfrom:hsiangkao@linux.alibaba.com fp:SMTPD_---0VcHjprx_1677092895)
          by smtp.aliyun-inc.com;
          Thu, 23 Feb 2023 03:08:22 +0800
From: Gao Xiang <hsiangkao@linux.alibaba.com>
To: linux-erofs@lists.ozlabs.org
Subject: [PATCH] erofs-utils: get rid of PAGE_SIZE leftovers
Date: Thu, 23 Feb 2023 03:08:14 +0800
Message-Id: <20230222190814.102585-1-hsiangkao@linux.alibaba.com>
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

commit c47df5aa2d16 ("erofs-utils: fuse: introduce xattr support")
introduced two new references.

Signed-off-by: Gao Xiang <hsiangkao@linux.alibaba.com>
---
 lib/xattr.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/lib/xattr.c b/lib/xattr.c
index 0ca89a4..024ecbe 100644
--- a/lib/xattr.c
+++ b/lib/xattr.c
@@ -915,7 +915,7 @@ static int xattr_foreach(struct xattr_iter *it,
 			it->ofs = 0;
 		}
 
-		slice = min_t(unsigned int, PAGE_SIZE - it->ofs,
+		slice = min_t(unsigned int, EROFS_BLKSIZ - it->ofs,
 			      entry.e_name_len - processed);
 
 		/* handle name */
@@ -950,7 +950,7 @@ static int xattr_foreach(struct xattr_iter *it,
 			it->ofs = 0;
 		}
 
-		slice = min_t(unsigned int, PAGE_SIZE - it->ofs,
+		slice = min_t(unsigned int, EROFS_BLKSIZ - it->ofs,
 			      value_sz - processed);
 		op->value(it, processed, it->kaddr + it->ofs, slice);
 		it->ofs += slice;
-- 
2.24.4

