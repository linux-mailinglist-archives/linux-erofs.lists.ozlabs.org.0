Return-Path: <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>
X-Original-To: lists+linux-erofs@lfdr.de
Delivered-To: lists+linux-erofs@lfdr.de
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	by mail.lfdr.de (Postfix) with ESMTPS id C848E945624
	for <lists+linux-erofs@lfdr.de>; Fri,  2 Aug 2024 03:55:55 +0200 (CEST)
Authentication-Results: lists.ozlabs.org;
	dkim=pass (1024-bit key; unprotected) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.a=rsa-sha256 header.s=default header.b=qgtKSzwE;
	dkim-atps=neutral
Received: from boromir.ozlabs.org (localhost [IPv6:::1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4WZpp15FLdz3dGt
	for <lists+linux-erofs@lfdr.de>; Fri,  2 Aug 2024 11:55:53 +1000 (AEST)
X-Original-To: linux-erofs@lists.ozlabs.org
Delivered-To: linux-erofs@lists.ozlabs.org
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (1024-bit key; unprotected) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.a=rsa-sha256 header.s=default header.b=qgtKSzwE;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=linux.alibaba.com (client-ip=115.124.30.119; helo=out30-119.freemail.mail.aliyun.com; envelope-from=hsiangkao@linux.alibaba.com; receiver=lists.ozlabs.org)
Received: from out30-119.freemail.mail.aliyun.com (out30-119.freemail.mail.aliyun.com [115.124.30.119])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4WZpnm6hrZz3ck2
	for <linux-erofs@lists.ozlabs.org>; Fri,  2 Aug 2024 11:55:39 +1000 (AEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=linux.alibaba.com; s=default;
	t=1722563736; h=From:To:Subject:Date:Message-ID:MIME-Version;
	bh=r6Xia3c95nYmQAMm0vQ+U5YX5eUhHfMQBeyP0G1CWBY=;
	b=qgtKSzwENzUklw2++hjjnt8o1Vx44mB9fGcN/g7UcZxnuDuUOQOYxku4+FNOMQq80d8wAw9JRO8VdW0jW/vRNZL9u0R3l3mrPVVQIiYTBri/0+7VQf3JYV8oLkPlA4Xcd1oChl6YF9ZZOUP2SV9jaAT7+OqwjxMd2USr5+XPkdI=
X-Alimail-AntiSpam: AC=PASS;BC=-1|-1;BR=01201311R901e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=maildocker-contentspam033037067110;MF=hsiangkao@linux.alibaba.com;NM=1;PH=DS;RN=2;SR=0;TI=SMTPD_---0WBvVrBH_1722563734;
Received: from x31i01179.sqa.na131.tbsite.net(mailfrom:hsiangkao@linux.alibaba.com fp:SMTPD_---0WBvVrBH_1722563734)
          by smtp.aliyun-inc.com;
          Fri, 02 Aug 2024 09:55:35 +0800
From: Gao Xiang <hsiangkao@linux.alibaba.com>
To: linux-erofs@lists.ozlabs.org
Subject: [PATCH 3/3] erofs-utils: lib: fix fd leak on failure in erofs_dev_open()
Date: Fri,  2 Aug 2024 09:55:27 +0800
Message-ID: <20240802015527.2113797-3-hsiangkao@linux.alibaba.com>
X-Mailer: git-send-email 2.43.5
In-Reply-To: <20240802015527.2113797-1-hsiangkao@linux.alibaba.com>
References: <20240802015527.2113797-1-hsiangkao@linux.alibaba.com>
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

Coverity-id: 502356
Signed-off-by: Gao Xiang <hsiangkao@linux.alibaba.com>
---
 lib/io.c | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/lib/io.c b/lib/io.c
index 4937db5..6bfae69 100644
--- a/lib/io.c
+++ b/lib/io.c
@@ -258,8 +258,10 @@ repeat:
 #if defined(HAVE_SYS_STATFS_H) && defined(HAVE_FSTATFS)
 			struct statfs stfs;
 
-			if (again)
+			if (again) {
+				close(fd);
 				return -ENOTEMPTY;
+			}
 
 			/*
 			 * fses like EXT4 and BTRFS will flush dirty blocks
-- 
2.43.5

