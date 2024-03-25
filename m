Return-Path: <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>
X-Original-To: lists+linux-erofs@lfdr.de
Delivered-To: lists+linux-erofs@lfdr.de
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2404:9400:2:0:216:3eff:fee1:b9f1])
	by mail.lfdr.de (Postfix) with ESMTPS id CE5A78884CC
	for <lists+linux-erofs@lfdr.de>; Mon, 25 Mar 2024 01:51:48 +0100 (CET)
Authentication-Results: lists.ozlabs.org;
	dkim=pass (1024-bit key; unprotected) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.a=rsa-sha256 header.s=default header.b=h60W55IK;
	dkim-atps=neutral
Received: from boromir.ozlabs.org (localhost [IPv6:::1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4V2vX24BJGz3cZ8
	for <lists+linux-erofs@lfdr.de>; Mon, 25 Mar 2024 11:51:46 +1100 (AEDT)
X-Original-To: linux-erofs@lists.ozlabs.org
Delivered-To: linux-erofs@lists.ozlabs.org
Authentication-Results: lists.ozlabs.org;
	dkim=pass (1024-bit key; unprotected) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.a=rsa-sha256 header.s=default header.b=h60W55IK;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=linux.alibaba.com (client-ip=115.124.30.110; helo=out30-110.freemail.mail.aliyun.com; envelope-from=hsiangkao@linux.alibaba.com; receiver=lists.ozlabs.org)
Received: from out30-110.freemail.mail.aliyun.com (out30-110.freemail.mail.aliyun.com [115.124.30.110])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4V2vWx1Gn1z2yhZ
	for <linux-erofs@lists.ozlabs.org>; Mon, 25 Mar 2024 11:51:39 +1100 (AEDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=linux.alibaba.com; s=default;
	t=1711327894; h=From:To:Subject:Date:Message-Id:MIME-Version;
	bh=CpPQ5+N9JSD3TuX+GeGtJ95cCrFjaJOvUAapG+YGKlQ=;
	b=h60W55IK81oC3i5IBZmgXV2GFoVOXNcJISHjJ820RYDmWr5K30E4IZ4xeGUYqZzh3jO1DO46lDxAKuzpwOaCDTebG47UNM6l09g0Edc9ojvVw8XgrUFRZGAWLd+yh998LhO6MSDUAR6Ck/dDJJp1JWUmqAiSE0Hqavh5hpzbcpU=
X-Alimail-AntiSpam: AC=PASS;BC=-1|-1;BR=01201311R691e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=ay29a033018045168;MF=hsiangkao@linux.alibaba.com;NM=1;PH=DS;RN=3;SR=0;TI=SMTPD_---0W37scbo_1711327880;
Received: from e69b19392.et15sqa.tbsite.net(mailfrom:hsiangkao@linux.alibaba.com fp:SMTPD_---0W37scbo_1711327880)
          by smtp.aliyun-inc.com;
          Mon, 25 Mar 2024 08:51:32 +0800
From: Gao Xiang <hsiangkao@linux.alibaba.com>
To: linux-erofs@lists.ozlabs.org
Subject: [PATCH] erofs: drop experimental warning for FSDAX
Date: Mon, 25 Mar 2024 08:51:16 +0800
Message-Id: <20240325005116.106351-1-hsiangkao@linux.alibaba.com>
X-Mailer: git-send-email 2.39.3
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
Cc: Gao Xiang <hsiangkao@linux.alibaba.com>, LKML <linux-kernel@vger.kernel.org>
Errors-To: linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org
Sender: "Linux-erofs" <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>

As EXT4/XFS filesystems, FSDAX functionality is considered to be stable.
Let's drop this warning.

Signed-off-by: Gao Xiang <hsiangkao@linux.alibaba.com>
---
 fs/erofs/super.c | 1 -
 1 file changed, 1 deletion(-)

diff --git a/fs/erofs/super.c b/fs/erofs/super.c
index 6fbb1fba2d31..fc60a5a7794f 100644
--- a/fs/erofs/super.c
+++ b/fs/erofs/super.c
@@ -430,7 +430,6 @@ static bool erofs_fc_set_dax_mode(struct fs_context *fc, unsigned int mode)
 
 	switch (mode) {
 	case EROFS_MOUNT_DAX_ALWAYS:
-		warnfc(fc, "DAX enabled. Warning: EXPERIMENTAL, use at your own risk");
 		set_opt(&ctx->opt, DAX_ALWAYS);
 		clear_opt(&ctx->opt, DAX_NEVER);
 		return true;
-- 
2.39.3

