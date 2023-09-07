Return-Path: <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>
X-Original-To: lists+linux-erofs@lfdr.de
Delivered-To: lists+linux-erofs@lfdr.de
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	by mail.lfdr.de (Postfix) with ESMTPS id 9B165796F3D
	for <lists+linux-erofs@lfdr.de>; Thu,  7 Sep 2023 05:20:20 +0200 (CEST)
Received: from boromir.ozlabs.org (localhost [IPv6:::1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4Rh4Hg6wjBz3bhp
	for <lists+linux-erofs@lfdr.de>; Thu,  7 Sep 2023 13:20:15 +1000 (AEST)
X-Original-To: linux-erofs@lists.ozlabs.org
Delivered-To: linux-erofs@lists.ozlabs.org
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=linux.alibaba.com (client-ip=115.124.30.124; helo=out30-124.freemail.mail.aliyun.com; envelope-from=hsiangkao@linux.alibaba.com; receiver=lists.ozlabs.org)
Received: from out30-124.freemail.mail.aliyun.com (out30-124.freemail.mail.aliyun.com [115.124.30.124])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4Rh4Hb3qGXz307h
	for <linux-erofs@lists.ozlabs.org>; Thu,  7 Sep 2023 13:20:09 +1000 (AEST)
X-Alimail-AntiSpam: AC=PASS;BC=-1|-1;BR=01201311R131e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=ay29a033018045192;MF=hsiangkao@linux.alibaba.com;NM=1;PH=DS;RN=2;SR=0;TI=SMTPD_---0VrVmiyK_1694056793;
Received: from e18g06460.et15sqa.tbsite.net(mailfrom:hsiangkao@linux.alibaba.com fp:SMTPD_---0VrVmiyK_1694056793)
          by smtp.aliyun-inc.com;
          Thu, 07 Sep 2023 11:20:01 +0800
From: Gao Xiang <hsiangkao@linux.alibaba.com>
To: linux-erofs@lists.ozlabs.org
Subject: [PATCH] erofs-utils: lib: fix an overflow issue of unmapped extents
Date: Thu,  7 Sep 2023 11:19:53 +0800
Message-Id: <20230907031953.14356-1-hsiangkao@linux.alibaba.com>
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

`fuzz_erofsfsck` reports an issue [1] that:

$ fsck/fuzz_erofsfsck t2/erofsfsck_libfuzzer_jUknVp
==430136==ERROR: AddressSanitizer: stack-buffer-overflow on address 0x7ffe44a8de02 at pc 0x55932ea3640c bp 0x7ffe44a8b990 sp 0x7ffe44a8b160
WRITE of size 201338902 at 0x7ffe44a8de02 thread T0
    #0 0x55932ea3640b in __asan_memset (/root/erofs-utils/fsck/fuzz_erofsfsck+0xf340b) (BuildId: 0bba6c9ddccb99f520b59bca08a3991a456f7cd4)
    #1 0x55932ea8a8e2 in z_erofs_read_data /root/erofs-utils/lib/data.c:335:4
    #2 0x55932ea8b136 in erofs_pread /root/erofs-utils/lib/data.c:369:10

Here the size should be `length - skip`, otherwise it could cause
buffer overflow.

[1] https://github.com/erofs/erofsnightly/actions/runs/6104429691/job/16566461154

Fixes: 6c20a6afd871 ("erofs-utils: fuse: fix random readlink error")
Signed-off-by: Gao Xiang <hsiangkao@linux.alibaba.com>
---
 lib/data.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/lib/data.c b/lib/data.c
index 662e922..a87053f 100644
--- a/lib/data.c
+++ b/lib/data.c
@@ -332,7 +332,7 @@ static int z_erofs_read_data(struct erofs_inode *inode, char *buffer,
 		}
 
 		if (!(map.m_flags & EROFS_MAP_MAPPED)) {
-			memset(buffer + end - offset, 0, length);
+			memset(buffer + end - offset, 0, length - skip);
 			end = map.m_la;
 			continue;
 		}
-- 
2.24.4

