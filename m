Return-Path: <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>
X-Original-To: lists+linux-erofs@lfdr.de
Delivered-To: lists+linux-erofs@lfdr.de
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2404:9400:2:0:216:3eff:fee1:b9f1])
	by mail.lfdr.de (Postfix) with ESMTP id D8EE58C9A13
	for <lists+linux-erofs@lfdr.de>; Mon, 20 May 2024 11:06:38 +0200 (CEST)
Authentication-Results: lists.ozlabs.org;
	dkim=pass (1024-bit key; unprotected) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.a=rsa-sha256 header.s=default header.b=OIV+rFSx;
	dkim-atps=neutral
Received: from boromir.ozlabs.org (localhost [IPv6:::1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4VjWl70yRPz3fwd
	for <lists+linux-erofs@lfdr.de>; Mon, 20 May 2024 19:01:23 +1000 (AEST)
X-Original-To: linux-erofs@lists.ozlabs.org
Delivered-To: linux-erofs@lists.ozlabs.org
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (1024-bit key; unprotected) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.a=rsa-sha256 header.s=default header.b=OIV+rFSx;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=linux.alibaba.com (client-ip=115.124.30.119; helo=out30-119.freemail.mail.aliyun.com; envelope-from=hsiangkao@linux.alibaba.com; receiver=lists.ozlabs.org)
Received: from out30-119.freemail.mail.aliyun.com (out30-119.freemail.mail.aliyun.com [115.124.30.119])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4VjWl208hBz3fwL
	for <linux-erofs@lists.ozlabs.org>; Mon, 20 May 2024 19:01:16 +1000 (AEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=linux.alibaba.com; s=default;
	t=1716195673; h=From:To:Subject:Date:Message-Id:MIME-Version;
	bh=+kDVR19ysmhcpcyTyT19ZSJuTM3Y2KTmTiRTyEtjSE4=;
	b=OIV+rFSx2RpVau67Ws9HokKN1NZTIw+qcLpwMgJDv1aXE3ytEcooS8lQVq4Z+xmSojfgL53qiWRvbd7e97Jgrl0ZTJncopCA7kgGIUrucHLT1hHMrgvzIvf50jbqHT6VHgSQ5piJJK2SJdiTnidiz4MhgA9g/HwS7RA5Hy5RXys=
X-Alimail-AntiSpam: AC=PASS;BC=-1|-1;BR=01201311R161e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=maildocker-contentspam033037067109;MF=hsiangkao@linux.alibaba.com;NM=1;PH=DS;RN=4;SR=0;TI=SMTPD_---0W6qDeFY_1716195667;
Received: from x31i01179.sqa.na131.tbsite.net(mailfrom:hsiangkao@linux.alibaba.com fp:SMTPD_---0W6qDeFY_1716195667)
          by smtp.aliyun-inc.com;
          Mon, 20 May 2024 17:01:12 +0800
From: Gao Xiang <hsiangkao@linux.alibaba.com>
To: linux-erofs@lists.ozlabs.org
Subject: [PATCH] erofs: avoid allocating DEFLATE streams before mounting
Date: Mon, 20 May 2024 17:01:06 +0800
Message-Id: <20240520090106.2898681-1-hsiangkao@linux.alibaba.com>
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
Cc: Gao Xiang <hsiangkao@linux.alibaba.com>, LKML <linux-kernel@vger.kernel.org>, stable@vger.kernel.org
Errors-To: linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org
Sender: "Linux-erofs" <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>

Currently, each DEFLATE stream takes one 32 KiB permanent internal
window buffer even if there is no running instance which uses DEFLATE
algorithm.

It's unexpected and wasteful on embedded devices with limited resources
and servers with hundreds of CPU cores if DEFLATE is enabled but unused.

Fixes: ffa09b3bd024 ("erofs: DEFLATE compression support")
Cc: <stable@vger.kernel.org> # 6.6+
Signed-off-by: Gao Xiang <hsiangkao@linux.alibaba.com>
---
 fs/erofs/decompressor_deflate.c | 55 +++++++++++++++++----------------
 1 file changed, 29 insertions(+), 26 deletions(-)

diff --git a/fs/erofs/decompressor_deflate.c b/fs/erofs/decompressor_deflate.c
index 81e65c453ef0..3a3461561a3c 100644
--- a/fs/erofs/decompressor_deflate.c
+++ b/fs/erofs/decompressor_deflate.c
@@ -46,39 +46,15 @@ int __init z_erofs_deflate_init(void)
 	/* by default, use # of possible CPUs instead */
 	if (!z_erofs_deflate_nstrms)
 		z_erofs_deflate_nstrms = num_possible_cpus();
-
-	for (; z_erofs_deflate_avail_strms < z_erofs_deflate_nstrms;
-	     ++z_erofs_deflate_avail_strms) {
-		struct z_erofs_deflate *strm;
-
-		strm = kzalloc(sizeof(*strm), GFP_KERNEL);
-		if (!strm)
-			goto out_failed;
-
-		/* XXX: in-kernel zlib cannot shrink windowbits currently */
-		strm->z.workspace = vmalloc(zlib_inflate_workspacesize());
-		if (!strm->z.workspace) {
-			kfree(strm);
-			goto out_failed;
-		}
-
-		spin_lock(&z_erofs_deflate_lock);
-		strm->next = z_erofs_deflate_head;
-		z_erofs_deflate_head = strm;
-		spin_unlock(&z_erofs_deflate_lock);
-	}
 	return 0;
-
-out_failed:
-	erofs_err(NULL, "failed to allocate zlib workspace");
-	z_erofs_deflate_exit();
-	return -ENOMEM;
 }
 
 int z_erofs_load_deflate_config(struct super_block *sb,
 			struct erofs_super_block *dsb, void *data, int size)
 {
 	struct z_erofs_deflate_cfgs *dfl = data;
+	static DEFINE_MUTEX(deflate_resize_mutex);
+	static bool inited;
 
 	if (!dfl || size < sizeof(struct z_erofs_deflate_cfgs)) {
 		erofs_err(sb, "invalid deflate cfgs, size=%u", size);
@@ -89,9 +65,36 @@ int z_erofs_load_deflate_config(struct super_block *sb,
 		erofs_err(sb, "unsupported windowbits %u", dfl->windowbits);
 		return -EOPNOTSUPP;
 	}
+	mutex_lock(&deflate_resize_mutex);
+	if (!inited) {
+		for (; z_erofs_deflate_avail_strms < z_erofs_deflate_nstrms;
+		     ++z_erofs_deflate_avail_strms) {
+			struct z_erofs_deflate *strm;
+
+			strm = kzalloc(sizeof(*strm), GFP_KERNEL);
+			if (!strm)
+				goto failed;
+			/* XXX: in-kernel zlib cannot customize windowbits */
+			strm->z.workspace = vmalloc(zlib_inflate_workspacesize());
+			if (!strm->z.workspace) {
+				kfree(strm);
+				goto failed;
+			}
 
+			spin_lock(&z_erofs_deflate_lock);
+			strm->next = z_erofs_deflate_head;
+			z_erofs_deflate_head = strm;
+			spin_unlock(&z_erofs_deflate_lock);
+		}
+		inited = true;
+	}
+	mutex_unlock(&deflate_resize_mutex);
 	erofs_info(sb, "EXPERIMENTAL DEFLATE feature in use. Use at your own risk!");
 	return 0;
+failed:
+	mutex_unlock(&deflate_resize_mutex);
+	z_erofs_deflate_exit();
+	return -ENOMEM;
 }
 
 int z_erofs_deflate_decompress(struct z_erofs_decompress_req *rq,
-- 
2.39.3

