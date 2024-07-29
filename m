Return-Path: <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>
X-Original-To: lists+linux-erofs@lfdr.de
Delivered-To: lists+linux-erofs@lfdr.de
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	by mail.lfdr.de (Postfix) with ESMTPS id 0949393EF04
	for <lists+linux-erofs@lfdr.de>; Mon, 29 Jul 2024 09:50:50 +0200 (CEST)
Authentication-Results: lists.ozlabs.org;
	dkim=pass (1024-bit key; unprotected) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.a=rsa-sha256 header.s=default header.b=troKMr15;
	dkim-atps=neutral
Received: from boromir.ozlabs.org (localhost [IPv6:::1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4WXVsK2kVfz3cWY
	for <lists+linux-erofs@lfdr.de>; Mon, 29 Jul 2024 17:50:45 +1000 (AEST)
X-Original-To: linux-erofs@lists.ozlabs.org
Delivered-To: linux-erofs@lists.ozlabs.org
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (1024-bit key; unprotected) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.a=rsa-sha256 header.s=default header.b=troKMr15;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=linux.alibaba.com (client-ip=115.124.30.98; helo=out30-98.freemail.mail.aliyun.com; envelope-from=hsiangkao@linux.alibaba.com; receiver=lists.ozlabs.org)
Received: from out30-98.freemail.mail.aliyun.com (out30-98.freemail.mail.aliyun.com [115.124.30.98])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4WXVsD0Hqwz2yhZ
	for <linux-erofs@lists.ozlabs.org>; Mon, 29 Jul 2024 17:50:37 +1000 (AEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=linux.alibaba.com; s=default;
	t=1722239432; h=From:To:Subject:Date:Message-ID:MIME-Version;
	bh=DkSut+F0s3tJ6fwih1FQQ87F5mUqIwbRqdY+jROuswg=;
	b=troKMr15gJIsTu60Jscq8t9UfFM3FfG6TDA9JEPPzyaIcYG9AbqQnnMrXdc7yLwhZPD6IX20eLTaKzdqKX6+2d7T/T05Q9JFUoO2GBjzCd8u5IseHhMcrmL6e6wunqdSCk0yA7GEaRm0rzYQLjhbQxYte2ccBxS22JtS9une2pM=
X-Alimail-AntiSpam: AC=PASS;BC=-1|-1;BR=01201311R171e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=maildocker-contentspam033045220184;MF=hsiangkao@linux.alibaba.com;NM=1;PH=DS;RN=2;SR=0;TI=SMTPD_---0WBW8tyq_1722239428;
Received: from x31i01179.sqa.na131.tbsite.net(mailfrom:hsiangkao@linux.alibaba.com fp:SMTPD_---0WBW8tyq_1722239428)
          by smtp.aliyun-inc.com;
          Mon, 29 Jul 2024 15:50:31 +0800
From: Gao Xiang <hsiangkao@linux.alibaba.com>
To: linux-erofs@lists.ozlabs.org
Subject: [PATCH 1/2] erofs-utils: lib: allow xattr e_name_index as 0
Date: Mon, 29 Jul 2024 15:50:26 +0800
Message-ID: <20240729075027.712339-1-hsiangkao@linux.alibaba.com>
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
Cc: Gao Xiang <hsiangkao@linux.alibaba.com>
Errors-To: linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org
Sender: "Linux-erofs" <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>

Since it's implicitly supported since the initial EROFS kernel version.

It is particularly useful as an on-disk inode xattr placeholder for
on-disk core inode in-place updates, especially for root inodes because
"root_nid" recorded in the on-disk superblock is limited to 16 bits
for now.

Fixes: 1e429b74bff8 ("erofs-utils: lib: fix potential out-of-bound in xattr_entrylist()")
Signed-off-by: Gao Xiang <hsiangkao@linux.alibaba.com>
---
 lib/xattr.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/lib/xattr.c b/lib/xattr.c
index 52c0ea4..563c688 100644
--- a/lib/xattr.c
+++ b/lib/xattr.c
@@ -1450,7 +1450,7 @@ static int xattr_entrylist(struct xattr_iter *_it,
 		base_index = pf->prefix->base_index;
 	}
 
-	if (base_index >= ARRAY_SIZE(xattr_types))
+	if (!base_index || base_index >= ARRAY_SIZE(xattr_types))
 		return 1;
 	prefix = xattr_types[base_index].prefix;
 	prefix_len = xattr_types[base_index].prefix_len;
-- 
2.43.5

