Return-Path: <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>
X-Original-To: lists+linux-erofs@lfdr.de
Delivered-To: lists+linux-erofs@lfdr.de
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	by mail.lfdr.de (Postfix) with ESMTPS id 0668735629B
	for <lists+linux-erofs@lfdr.de>; Wed,  7 Apr 2021 06:39:55 +0200 (CEST)
Received: from boromir.ozlabs.org (localhost [IPv6:::1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4FFWs50VRrz303x
	for <lists+linux-erofs@lfdr.de>; Wed,  7 Apr 2021 14:39:53 +1000 (AEST)
Authentication-Results: lists.ozlabs.org;
	dkim=fail reason="signature verification failed" (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20201202 header.b=VXSgKfA0;
	dkim-atps=neutral
X-Original-To: linux-erofs@lists.ozlabs.org
Delivered-To: linux-erofs@lists.ozlabs.org
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized)
 smtp.mailfrom=kernel.org (client-ip=198.145.29.99; helo=mail.kernel.org;
 envelope-from=xiang@kernel.org; receiver=<UNKNOWN>)
Authentication-Results: lists.ozlabs.org; dkim=pass (2048-bit key;
 unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256
 header.s=k20201202 header.b=VXSgKfA0; 
 dkim-atps=neutral
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 4FFWs23mHkz30Cp
 for <linux-erofs@lists.ozlabs.org>; Wed,  7 Apr 2021 14:39:50 +1000 (AEST)
Received: by mail.kernel.org (Postfix) with ESMTPSA id 270A3613D2;
 Wed,  7 Apr 2021 04:39:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=k20201202; t=1617770388;
 bh=VaOTJJwaYZ0oj1eLhKkPFkxEI4HP6r9UeKiJkJc6GH4=;
 h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
 b=VXSgKfA0EICILYq6SuU7wzmRCG5BqpKLWtuf+CW5ulQ188/KlYwUHe2fML5K+PemT
 xoHqzfq69SdjTjTQm1kLC+9RJ/piDJskHJahG8SSoZA/Pkn3S+B6683VpcqikY6WnK
 jkUchsd1vE91QMkCwJJ513ueV8tRjpgxWwj9sqCXZn6FjcoFYgEKA49qzEwO/5x+xs
 jWoAunxMuy9ta6zeH86Zpr2P8cJgWx+e4sCBDo4yKq7BMcrZ8xGTfPU6qWeB7X4kAd
 3r8yl28ErJTMgYuBoIshpGpqO6inj+ELTPCFDghFtZ2+pDlE4A68LT4fHN6hLqpH8Y
 phpJ6VA7xGHrg==
From: Gao Xiang <xiang@kernel.org>
To: linux-erofs@lists.ozlabs.org, Chao Yu <yuchao0@huawei.com>,
 Chao Yu <chao@kernel.org>
Subject: [PATCH v3 06/10] erofs: adjust per-CPU buffers according to
 max_pclusterblks
Date: Wed,  7 Apr 2021 12:39:23 +0800
Message-Id: <20210407043927.10623-7-xiang@kernel.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20210407043927.10623-1-xiang@kernel.org>
References: <20210407043927.10623-1-xiang@kernel.org>
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
Cc: LKML <linux-kernel@vger.kernel.org>
Errors-To: linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org
Sender: "Linux-erofs"
 <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>

From: Gao Xiang <hsiangkao@redhat.com>

Adjust per-CPU buffers on demand since big pcluster definition is
available. Also, bail out unsupported pcluster size according to
Z_EROFS_PCLUSTER_MAX_SIZE.

Acked-by: Chao Yu <yuchao0@huawei.com>
Signed-off-by: Gao Xiang <hsiangkao@redhat.com>
---
 fs/erofs/decompressor.c | 20 ++++++++++++++++----
 fs/erofs/internal.h     |  2 ++
 2 files changed, 18 insertions(+), 4 deletions(-)

diff --git a/fs/erofs/decompressor.c b/fs/erofs/decompressor.c
index fb4838c0f0df..900de4725d35 100644
--- a/fs/erofs/decompressor.c
+++ b/fs/erofs/decompressor.c
@@ -32,6 +32,7 @@ int z_erofs_load_lz4_config(struct super_block *sb,
 			    struct erofs_super_block *dsb,
 			    struct z_erofs_lz4_cfgs *lz4, int size)
 {
+	struct erofs_sb_info *sbi = EROFS_SB(sb);
 	u16 distance;
 
 	if (lz4) {
@@ -40,16 +41,27 @@ int z_erofs_load_lz4_config(struct super_block *sb,
 			return -EINVAL;
 		}
 		distance = le16_to_cpu(lz4->max_distance);
+
+		sbi->lz4.max_pclusterblks = le16_to_cpu(lz4->max_pclusterblks);
+		if (!sbi->lz4.max_pclusterblks) {
+			sbi->lz4.max_pclusterblks = 1;	/* reserved case */
+		} else if (sbi->lz4.max_pclusterblks >
+			   Z_EROFS_PCLUSTER_MAX_SIZE / EROFS_BLKSIZ) {
+			erofs_err(sb, "too large lz4 pclusterblks %u",
+				  sbi->lz4.max_pclusterblks);
+			return -EINVAL;
+		} else if (sbi->lz4.max_pclusterblks >= 2) {
+			erofs_info(sb, "EXPERIMENTAL big pcluster feature in use. Use at your own risk!");
+		}
 	} else {
 		distance = le16_to_cpu(dsb->u1.lz4_max_distance);
+		sbi->lz4.max_pclusterblks = 1;
 	}
 
-	EROFS_SB(sb)->lz4.max_distance_pages = distance ?
+	sbi->lz4.max_distance_pages = distance ?
 					DIV_ROUND_UP(distance, PAGE_SIZE) + 1 :
 					LZ4_MAX_DISTANCE_PAGES;
-
-	/* TODO: use max pclusterblks after bigpcluster is enabled */
-	return erofs_pcpubuf_growsize(1);
+	return erofs_pcpubuf_growsize(sbi->lz4.max_pclusterblks);
 }
 
 static int z_erofs_lz4_prepare_destpages(struct z_erofs_decompress_req *rq,
diff --git a/fs/erofs/internal.h b/fs/erofs/internal.h
index c4b3938a7e56..f1305af50f67 100644
--- a/fs/erofs/internal.h
+++ b/fs/erofs/internal.h
@@ -63,6 +63,8 @@ struct erofs_fs_context {
 struct erofs_sb_lz4_info {
 	/* # of pages needed for EROFS lz4 rolling decompression */
 	u16 max_distance_pages;
+	/* maximum possible blocks for pclusters in the filesystem */
+	u16 max_pclusterblks;
 };
 
 struct erofs_sb_info {
-- 
2.20.1

