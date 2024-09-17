Return-Path: <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>
X-Original-To: lists+linux-erofs@lfdr.de
Delivered-To: lists+linux-erofs@lfdr.de
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2404:9400:2:0:216:3eff:fee1:b9f1])
	by mail.lfdr.de (Postfix) with ESMTPS id 9A3A597B095
	for <lists+linux-erofs@lfdr.de>; Tue, 17 Sep 2024 15:08:25 +0200 (CEST)
Received: from boromir.ozlabs.org (localhost [IPv6:::1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4X7MXk432zz2yGf
	for <lists+linux-erofs@lfdr.de>; Tue, 17 Sep 2024 23:08:22 +1000 (AEST)
X-Original-To: linux-erofs@lists.ozlabs.org
Delivered-To: linux-erofs@lists.ozlabs.org
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip=115.124.30.112
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1726578499;
	cv=none; b=UHHMCXTUUmNa8PByl2YfsSGS3WL315IuRN7a3Av1l7v+NBs4XS7J1nVCs0p8cEA62iZp62STjdfoN8X4aiPDJCu7Arl61sQO0W12glSdjpnDNOcIQY09vgTwzKY6zIdzc+g/LzpwbDMLpAnO05pT6tCnCkvSLlXW+psKvPolhIWuE+Fb/skRbQKWkJI0IAGdaUyAKLpdBfOAH3YmmRAE3G5zwhZG6MlCbZPyn8OjfLd8Tsre3Eln9pMOyu/2c6ncX3DpN0VZ/aT7jY4seE2uMCkppES5dwbEx4//212mupNhQf6fZRriPJTzxXJydhwzH3cS5telhtHZhQktd0OU2g==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1726578499; c=relaxed/relaxed;
	bh=hlDVpKGZvqffbAlVD5qaDM5mbqYPYdsGsfyPEohCPpQ=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=d5pRnlOXUAg1lGdveeo6/a4HA0nW5ckC/ao7opR0JLVuAqT11BRFjHZ/XuWyQsTb+SQyxkTVAmbAlSSPLFvm/zWrQcqXq28NUCbbUD2peHhbfey9rCZD3C7SHODclMTcAtzLuiCs/wdAKlQVadNRu0ITAZ7Rl2bIBlrAZqv8rg1sdACwUPBkebpfy3ndvof8GnB1QMcbYKqdVfaW1BRqqlgRvUVp4EdEYshYOSC80PR41NXCPb921aEbdaqPzwlOltnzbnsOw6mFOzTBlEcFqHYpAICOM20zBseBmO4lY2tGiBsrhmDgnOMCM4aRyYktxPTWoi8iA/59IIpYkUmKcg==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com; dkim=pass (1024-bit key; unprotected) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.a=rsa-sha256 header.s=default header.b=FB2NHjcQ; dkim-atps=neutral; spf=pass (client-ip=115.124.30.112; helo=out30-112.freemail.mail.aliyun.com; envelope-from=hsiangkao@linux.alibaba.com; receiver=lists.ozlabs.org) smtp.mailfrom=linux.alibaba.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (1024-bit key; unprotected) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.a=rsa-sha256 header.s=default header.b=FB2NHjcQ;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=linux.alibaba.com (client-ip=115.124.30.112; helo=out30-112.freemail.mail.aliyun.com; envelope-from=hsiangkao@linux.alibaba.com; receiver=lists.ozlabs.org)
Received: from out30-112.freemail.mail.aliyun.com (out30-112.freemail.mail.aliyun.com [115.124.30.112])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4X7MXf2Vgcz2xBm
	for <linux-erofs@lists.ozlabs.org>; Tue, 17 Sep 2024 23:08:14 +1000 (AEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=linux.alibaba.com; s=default;
	t=1726578489; h=From:To:Subject:Date:Message-ID:MIME-Version;
	bh=hlDVpKGZvqffbAlVD5qaDM5mbqYPYdsGsfyPEohCPpQ=;
	b=FB2NHjcQMJLLcjXXCAppg9jla6bPk9l97FCJDjHqIhjCsXOcqn5hk8NRtVN0mLOSv4KTF2w4UgHw9pVHhIyQKZ9OAEV34ZeLxM5MdcQDFez4xnZg+CEfkYWuHLkNFri2bCW4USDWqHPEJStMRtG5OW3pHyrVvXV1hkqTszScPwU=
Received: from x31i01179.sqa.na131.tbsite.net(mailfrom:hsiangkao@linux.alibaba.com fp:SMTPD_---0WFAtkZY_1726578487)
          by smtp.aliyun-inc.com;
          Tue, 17 Sep 2024 21:08:08 +0800
From: Gao Xiang <hsiangkao@linux.alibaba.com>
To: linux-erofs@lists.ozlabs.org
Subject: [PATCH v2] erofs: ensure regular inodes for file-backed mounts
Date: Tue, 17 Sep 2024 21:08:03 +0800
Message-ID: <20240917130803.32418-1-hsiangkao@linux.alibaba.com>
X-Mailer: git-send-email 2.43.5
In-Reply-To: <00000000000011bdde0622498ee3@google.com>
References: <00000000000011bdde0622498ee3@google.com>
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
Cc: syzbot+001306cd9c92ce0df23f@syzkaller.appspotmail.com, Gao Xiang <hsiangkao@linux.alibaba.com>, LKML <linux-kernel@vger.kernel.org>
Errors-To: linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org
Sender: "Linux-erofs" <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>

Only regular inodes are allowed for file-backed mounts, not directories
(as seen in the original syzbot case) or special inodes.

Also ensure that .read_folio() is implemented on the underlying fs
for the primary device.

Fixes: fb176750266a ("erofs: add file-backed mount support")
Reported-by: syzbot+001306cd9c92ce0df23f@syzkaller.appspotmail.com
Closes: https://lore.kernel.org/r/00000000000011bdde0622498ee3@google.com
Tested-by: syzbot+001306cd9c92ce0df23f@syzkaller.appspotmail.com
Signed-off-by: Gao Xiang <hsiangkao@linux.alibaba.com>
---
change since v1:
 - need to handle multi-device/blob cases too.

 fs/erofs/super.c | 13 ++++++++++---
 1 file changed, 10 insertions(+), 3 deletions(-)

diff --git a/fs/erofs/super.c b/fs/erofs/super.c
index 666873f745da..320d586c3896 100644
--- a/fs/erofs/super.c
+++ b/fs/erofs/super.c
@@ -191,10 +191,14 @@ static int erofs_init_device(struct erofs_buf *buf, struct super_block *sb,
 		if (IS_ERR(file))
 			return PTR_ERR(file);
 
-		dif->file = file;
-		if (!erofs_is_fileio_mode(sbi))
+		if (!erofs_is_fileio_mode(sbi)) {
 			dif->dax_dev = fs_dax_get_by_bdev(file_bdev(file),
 					&dif->dax_part_off, NULL, NULL);
+		} else if (!S_ISREG(file_inode(file)->i_mode)) {
+			fput(file);
+			return -EINVAL;
+		}
+		dif->file = file;
 	}
 
 	dif->blocks = le32_to_cpu(dis->blocks);
@@ -714,7 +718,10 @@ static int erofs_fc_get_tree(struct fs_context *fc)
 		if (IS_ERR(sbi->fdev))
 			return PTR_ERR(sbi->fdev);
 
-		return get_tree_nodev(fc, erofs_fc_fill_super);
+		if (S_ISREG(file_inode(sbi->fdev)->i_mode) &&
+		    sbi->fdev->f_mapping->a_ops->read_folio)
+			return get_tree_nodev(fc, erofs_fc_fill_super);
+		fput(sbi->fdev);
 	}
 #endif
 	return ret;
-- 
2.43.5

