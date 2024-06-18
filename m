Return-Path: <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>
X-Original-To: lists+linux-erofs@lfdr.de
Delivered-To: lists+linux-erofs@lfdr.de
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	by mail.lfdr.de (Postfix) with ESMTPS id 128E390C4E6
	for <lists+linux-erofs@lfdr.de>; Tue, 18 Jun 2024 10:25:19 +0200 (CEST)
Authentication-Results: lists.ozlabs.org;
	dkim=pass (1024-bit key; unprotected) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.a=rsa-sha256 header.s=default header.b=NKuxkKHn;
	dkim-atps=neutral
Received: from boromir.ozlabs.org (localhost [IPv6:::1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4W3KZ35RYTz3cLk
	for <lists+linux-erofs@lfdr.de>; Tue, 18 Jun 2024 18:25:15 +1000 (AEST)
X-Original-To: linux-erofs@lists.ozlabs.org
Delivered-To: linux-erofs@lists.ozlabs.org
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (1024-bit key; unprotected) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.a=rsa-sha256 header.s=default header.b=NKuxkKHn;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=linux.alibaba.com (client-ip=115.124.30.111; helo=out30-111.freemail.mail.aliyun.com; envelope-from=hsiangkao@linux.alibaba.com; receiver=lists.ozlabs.org)
Received: from out30-111.freemail.mail.aliyun.com (out30-111.freemail.mail.aliyun.com [115.124.30.111])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4W3KYK2Yf5z3bYR
	for <linux-erofs@lists.ozlabs.org>; Tue, 18 Jun 2024 18:24:36 +1000 (AEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=linux.alibaba.com; s=default;
	t=1718699074; h=From:To:Subject:Date:Message-Id:MIME-Version;
	bh=NsK5PK+jC1n2bL8kQrYYRjaaSP4EmPdmnAwBUZOxAsc=;
	b=NKuxkKHn2+nLmOoiUqYQkwqi+Zzuzv9Ngar4Ha0DK3WuZ/paKHay4ek+n5IZbqOYFc2flchWHvWUj2zg2i6hVYPQpOaDykTNzlSI7Mmx6HcSMzqEpMIw18OOR2KqUT3OeA9swik9Esn30gpXDYwgqxZxuUYbYoOKJrXiwp0TYtE=
X-Alimail-AntiSpam: AC=PASS;BC=-1|-1;BR=01201311R181e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=maildocker-contentspam033068173054;MF=hsiangkao@linux.alibaba.com;NM=1;PH=DS;RN=2;SR=0;TI=SMTPD_---0W8jcNBL_1718699072;
Received: from x31i01179.sqa.na131.tbsite.net(mailfrom:hsiangkao@linux.alibaba.com fp:SMTPD_---0W8jcNBL_1718699072)
          by smtp.aliyun-inc.com;
          Tue, 18 Jun 2024 16:24:33 +0800
From: Gao Xiang <hsiangkao@linux.alibaba.com>
To: linux-erofs@lists.ozlabs.org
Subject: [PATCH v2 07/10] erofs-utils: fix incremental builds for tarerofs index mode
Date: Tue, 18 Jun 2024 16:24:12 +0800
Message-Id: <20240618082414.47876-7-hsiangkao@linux.alibaba.com>
X-Mailer: git-send-email 2.39.3
In-Reply-To: <20240618082414.47876-1-hsiangkao@linux.alibaba.com>
References: <20240618082414.47876-1-hsiangkao@linux.alibaba.com>
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

The blob data area should be considered in the total block number to
prevent overlap during incremental builds.

Fixes: b6749839e710 ("erofs-utils: generate preallocated extents for tarerofs")
Signed-off-by: Gao Xiang <hsiangkao@linux.alibaba.com>
---
 lib/blobchunk.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/lib/blobchunk.c b/lib/blobchunk.c
index dc1bf3c..9af223d 100644
--- a/lib/blobchunk.c
+++ b/lib/blobchunk.c
@@ -517,7 +517,7 @@ int erofs_mkfs_dump_blobs(struct erofs_sb_info *sbi)
 		return 0;
 	}
 
-	bh = erofs_balloc(DATA, blobfile ? datablob_size : 0, 0, 0);
+	bh = erofs_balloc(DATA, datablob_size, 0, 0);
 	if (IS_ERR(bh))
 		return PTR_ERR(bh);
 
@@ -532,7 +532,7 @@ int erofs_mkfs_dump_blobs(struct erofs_sb_info *sbi)
 				sbi->bdev.fd, &pos_out, datablob_size);
 		ret = ret < datablob_size ? -EIO : 0;
 	} else {
-		ret = 0;
+		ret = erofs_io_ftruncate(&sbi->bdev, pos_out + datablob_size);
 	}
 	bh->op = &erofs_drop_directly_bhops;
 	erofs_bdrop(bh, false);
-- 
2.39.3

