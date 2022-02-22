Return-Path: <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>
X-Original-To: lists+linux-erofs@lfdr.de
Delivered-To: lists+linux-erofs@lfdr.de
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	by mail.lfdr.de (Postfix) with ESMTPS id 319AD4BF013
	for <lists+linux-erofs@lfdr.de>; Tue, 22 Feb 2022 04:31:46 +0100 (CET)
Received: from boromir.ozlabs.org (localhost [IPv6:::1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4K2l8H2MrQz3bPM
	for <lists+linux-erofs@lfdr.de>; Tue, 22 Feb 2022 14:31:43 +1100 (AEDT)
X-Original-To: linux-erofs@lists.ozlabs.org
Delivered-To: linux-erofs@lists.ozlabs.org
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized)
 smtp.mailfrom=linux.alibaba.com (client-ip=115.124.30.132;
 helo=out30-132.freemail.mail.aliyun.com;
 envelope-from=hsiangkao@linux.alibaba.com; receiver=<UNKNOWN>)
Received: from out30-132.freemail.mail.aliyun.com
 (out30-132.freemail.mail.aliyun.com [115.124.30.132])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 4K2l891ZbHz2yHZ
 for <linux-erofs@lists.ozlabs.org>; Tue, 22 Feb 2022 14:31:35 +1100 (AEDT)
X-Alimail-AntiSpam: AC=PASS; BC=-1|-1; BR=01201311R111e4; CH=green; DM=||false|;
 DS=||; FP=0|-1|-1|-1|0|-1|-1|-1; HT=e01e04395; MF=hsiangkao@linux.alibaba.com;
 NM=1; PH=DS; RN=5; SR=0; TI=SMTPD_---0V5Ar7K1_1645500681; 
Received: from
 e18g06460.et15sqa.tbsite.net(mailfrom:hsiangkao@linux.alibaba.com
 fp:SMTPD_---0V5Ar7K1_1645500681) by smtp.aliyun-inc.com(127.0.0.1);
 Tue, 22 Feb 2022 11:31:26 +0800
From: Gao Xiang <hsiangkao@linux.alibaba.com>
To: linux-erofs@lists.ozlabs.org, Chao Yu <chao@kernel.org>,
 Yue Hu <huyue2@yulong.com>
Subject: [PATCH] erofs: fix ztailpacking on > 4GiB filesystems
Date: Tue, 22 Feb 2022 11:31:18 +0800
Message-Id: <20220222033118.20540-1-hsiangkao@linux.alibaba.com>
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
Cc: Gao Xiang <hsiangkao@linux.alibaba.com>,
 LKML <linux-kernel@vger.kernel.org>
Errors-To: linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org
Sender: "Linux-erofs"
 <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>

z_idataoff here is an absolute physical offset, so it should use
erofs_off_t (64 bits at least). Otherwise, it'll get trimmed and
cause the decompresion failure.

Fixes: ab92184ff8f1 ("erofs: add on-disk compressed tail-packing inline support")
Signed-off-by: Gao Xiang <hsiangkao@linux.alibaba.com>
---
 fs/erofs/internal.h | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/fs/erofs/internal.h b/fs/erofs/internal.h
index b8272fb95fd6..5aa2cf2c2f80 100644
--- a/fs/erofs/internal.h
+++ b/fs/erofs/internal.h
@@ -325,7 +325,7 @@ struct erofs_inode {
 			unsigned char  z_algorithmtype[2];
 			unsigned char  z_logical_clusterbits;
 			unsigned long  z_tailextent_headlcn;
-			unsigned int   z_idataoff;
+			erofs_off_t    z_idataoff;
 			unsigned short z_idata_size;
 		};
 #endif	/* CONFIG_EROFS_FS_ZIP */
-- 
2.24.4

