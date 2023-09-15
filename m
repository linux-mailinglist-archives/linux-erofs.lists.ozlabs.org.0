Return-Path: <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>
X-Original-To: lists+linux-erofs@lfdr.de
Delivered-To: lists+linux-erofs@lfdr.de
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2404:9400:2:0:216:3eff:fee1:b9f1])
	by mail.lfdr.de (Postfix) with ESMTPS id BF7D97A18C4
	for <lists+linux-erofs@lfdr.de>; Fri, 15 Sep 2023 10:27:44 +0200 (CEST)
Received: from boromir.ozlabs.org (localhost [IPv6:::1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4Rn6kk2cTjz3cGK
	for <lists+linux-erofs@lfdr.de>; Fri, 15 Sep 2023 18:27:42 +1000 (AEST)
X-Original-To: linux-erofs@lists.ozlabs.org
Delivered-To: linux-erofs@lists.ozlabs.org
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=linux.alibaba.com (client-ip=115.124.30.111; helo=out30-111.freemail.mail.aliyun.com; envelope-from=jefflexu@linux.alibaba.com; receiver=lists.ozlabs.org)
Received: from out30-111.freemail.mail.aliyun.com (out30-111.freemail.mail.aliyun.com [115.124.30.111])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4Rn6kb2ZKKz3c27
	for <linux-erofs@lists.ozlabs.org>; Fri, 15 Sep 2023 18:27:34 +1000 (AEST)
X-Alimail-AntiSpam: AC=PASS;BC=-1|-1;BR=01201311R131e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=ay29a033018046051;MF=jefflexu@linux.alibaba.com;NM=1;PH=DS;RN=5;SR=0;TI=SMTPD_---0Vs6XKuq_1694766448;
Received: from localhost(mailfrom:jefflexu@linux.alibaba.com fp:SMTPD_---0Vs6XKuq_1694766448)
          by smtp.aliyun-inc.com;
          Fri, 15 Sep 2023 16:27:29 +0800
From: Jingbo Xu <jefflexu@linux.alibaba.com>
To: xiang@kernel.org,
	chao@kernel.org,
	linux-erofs@lists.ozlabs.org
Subject: [RESEND PATCH] erofs: relax the constraint of non-empty device tag in flatdev mode
Date: Fri, 15 Sep 2023 16:27:28 +0800
Message-Id: <20230915082728.56588-1-jefflexu@linux.alibaba.com>
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
Cc: huyue2@coolpad.com
Errors-To: linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org
Sender: "Linux-erofs" <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>

The device tag is not required in flatdev mode, and thus relax this
constraint in flatdev mode.

Signed-off-by: Jingbo Xu <jefflexu@linux.alibaba.com>
---
Sorry I forget to cc linux-erofs@lists.ozlabs.org in the former patch.
---
 fs/erofs/super.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/fs/erofs/super.c b/fs/erofs/super.c
index 44a24d573f1f..3700af9ee173 100644
--- a/fs/erofs/super.c
+++ b/fs/erofs/super.c
@@ -235,7 +235,7 @@ static int erofs_init_device(struct erofs_buf *buf, struct super_block *sb,
 		return PTR_ERR(ptr);
 	dis = ptr + erofs_blkoff(sb, *pos);
 
-	if (!dif->path) {
+	if (!sbi->devs->flatdev && !dif->path) {
 		if (!dis->tag[0]) {
 			erofs_err(sb, "empty device tag @ pos %llu", *pos);
 			return -EINVAL;
-- 
2.19.1.6.gb485710b

