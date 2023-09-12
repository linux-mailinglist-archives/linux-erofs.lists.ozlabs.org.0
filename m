Return-Path: <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>
X-Original-To: lists+linux-erofs@lfdr.de
Delivered-To: lists+linux-erofs@lfdr.de
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2404:9400:2:0:216:3eff:fee1:b9f1])
	by mail.lfdr.de (Postfix) with ESMTPS id 5B66879C91C
	for <lists+linux-erofs@lfdr.de>; Tue, 12 Sep 2023 10:00:32 +0200 (CEST)
Received: from boromir.ozlabs.org (localhost [IPv6:::1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4RlGGk1TjNz3cCc
	for <lists+linux-erofs@lfdr.de>; Tue, 12 Sep 2023 18:00:30 +1000 (AEST)
X-Original-To: linux-erofs@lists.ozlabs.org
Delivered-To: linux-erofs@lists.ozlabs.org
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=linux.alibaba.com (client-ip=115.124.30.110; helo=out30-110.freemail.mail.aliyun.com; envelope-from=jefflexu@linux.alibaba.com; receiver=lists.ozlabs.org)
Received: from out30-110.freemail.mail.aliyun.com (out30-110.freemail.mail.aliyun.com [115.124.30.110])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4RlGGg13Cxz3c9m
	for <linux-erofs@lists.ozlabs.org>; Tue, 12 Sep 2023 18:00:25 +1000 (AEST)
X-Alimail-AntiSpam: AC=PASS;BC=-1|-1;BR=01201311R191e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=ay29a033018046060;MF=jefflexu@linux.alibaba.com;NM=1;PH=DS;RN=2;SR=0;TI=SMTPD_---0Vrw-8Gm_1694505616;
Received: from localhost(mailfrom:jefflexu@linux.alibaba.com fp:SMTPD_---0Vrw-8Gm_1694505616)
          by smtp.aliyun-inc.com;
          Tue, 12 Sep 2023 16:00:16 +0800
From: Jingbo Xu <jefflexu@linux.alibaba.com>
To: hsiangkao@linux.alibaba.com,
	linux-erofs@lists.ozlabs.org
Subject: [PATCH 1/2] erofs-utils: lib: fix memleak in error path of erofs_build_shared_xattrs_from_path()
Date: Tue, 12 Sep 2023 16:00:14 +0800
Message-Id: <20230912080015.111464-1-jefflexu@linux.alibaba.com>
X-Mailer: git-send-email 2.19.1.6.gb485710b
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
Errors-To: linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org
Sender: "Linux-erofs" <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>

Free the allocated sorted_n[] buffer when error occurced.

Signed-off-by: Jingbo Xu <jefflexu@linux.alibaba.com>
---
 lib/xattr.c | 5 ++++-
 1 file changed, 4 insertions(+), 1 deletion(-)

diff --git a/lib/xattr.c b/lib/xattr.c
index d755760..54a6ae2 100644
--- a/lib/xattr.c
+++ b/lib/xattr.c
@@ -800,11 +800,14 @@ int erofs_build_shared_xattrs_from_path(struct erofs_sb_info *sbi, const char *p
 	qsort(sorted_n, shared_xattrs_count, sizeof(n), comp_shared_xattr_item);
 
 	buf = calloc(1, shared_xattrs_size);
-	if (!buf)
+	if (!buf) {
+		free(sorted_n);
 		return -ENOMEM;
+	}
 
 	bh = erofs_balloc(XATTR, shared_xattrs_size, 0, 0);
 	if (IS_ERR(bh)) {
+		free(sorted_n);
 		free(buf);
 		return PTR_ERR(bh);
 	}
-- 
2.19.1.6.gb485710b

