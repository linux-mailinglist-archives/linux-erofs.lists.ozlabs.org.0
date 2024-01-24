Return-Path: <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>
X-Original-To: lists+linux-erofs@lfdr.de
Delivered-To: lists+linux-erofs@lfdr.de
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2404:9400:2:0:216:3eff:fee1:b9f1])
	by mail.lfdr.de (Postfix) with ESMTPS id 4115983A501
	for <lists+linux-erofs@lfdr.de>; Wed, 24 Jan 2024 10:16:44 +0100 (CET)
Received: from boromir.ozlabs.org (localhost [IPv6:::1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4TKdcn4sNWz3by2
	for <lists+linux-erofs@lfdr.de>; Wed, 24 Jan 2024 20:16:41 +1100 (AEDT)
X-Original-To: linux-erofs@lists.ozlabs.org
Delivered-To: linux-erofs@lists.ozlabs.org
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=linux.alibaba.com (client-ip=115.124.30.133; helo=out30-133.freemail.mail.aliyun.com; envelope-from=hsiangkao@linux.alibaba.com; receiver=lists.ozlabs.org)
Received: from out30-133.freemail.mail.aliyun.com (out30-133.freemail.mail.aliyun.com [115.124.30.133])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4TKdcg578Zz3bYx
	for <linux-erofs@lists.ozlabs.org>; Wed, 24 Jan 2024 20:16:33 +1100 (AEDT)
X-Alimail-AntiSpam: AC=PASS;BC=-1|-1;BR=01201311R131e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=ay29a033018045170;MF=hsiangkao@linux.alibaba.com;NM=1;PH=DS;RN=3;SR=0;TI=SMTPD_---0W.G4gW6_1706087782;
Received: from e69b19392.et15sqa.tbsite.net(mailfrom:hsiangkao@linux.alibaba.com fp:SMTPD_---0W.G4gW6_1706087782)
          by smtp.aliyun-inc.com;
          Wed, 24 Jan 2024 17:16:26 +0800
From: Gao Xiang <hsiangkao@linux.alibaba.com>
To: linux-erofs@lists.ozlabs.org
Subject: [PATCH] erofs-utils: lib: reset hc to avoid 32-bit overflow of kite-deflate
Date: Wed, 24 Jan 2024 17:16:21 +0800
Message-Id: <20240124091621.2413606-1-hsiangkao@linux.alibaba.com>
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
Cc: Gao Xiang <hsiangkao@linux.alibaba.com>, Yifan Zhao <zhaoyifan@sjtu.edu.cn>
Errors-To: linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org
Sender: "Linux-erofs" <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>

Yifan reported a "segmentation fault (core dumped)" error days ago
with a large dataset (enwik9 x 5).   Let's fix it.

Reported-by: Yifan Zhao <zhaoyifan@sjtu.edu.cn>
Fixes: 861037f4fc15 ("erofs-utils: add a built-in DEFLATE compressor")
Signed-off-by: Gao Xiang <hsiangkao@linux.alibaba.com>
---
 include/erofs/defs.h |  3 +++
 lib/kite_deflate.c   | 12 ++++++++++++
 2 files changed, 15 insertions(+)

diff --git a/include/erofs/defs.h b/include/erofs/defs.h
index e7384a1..4ea9a55 100644
--- a/include/erofs/defs.h
+++ b/include/erofs/defs.h
@@ -343,6 +343,9 @@ unsigned long __roundup_pow_of_two(unsigned long n)
 #define ST_MTIM_NSEC(stbuf) 0
 #endif
 
+#define likely(x)      __builtin_expect(!!(x), 1)
+#define unlikely(x)    __builtin_expect(!!(x), 0)
+
 #ifdef __cplusplus
 }
 #endif
diff --git a/lib/kite_deflate.c b/lib/kite_deflate.c
index 8667954..cb81626 100644
--- a/lib/kite_deflate.c
+++ b/lib/kite_deflate.c
@@ -859,6 +859,18 @@ static void kite_mf_reset(struct kite_matchfinder *mf,
 	 */
 	mf->base += mf->offset + kHistorySize32 + 1;
 
+	/*
+	 * Unlike other LZ encoders like liblzma [1], we simply reset the hash
+	 * chain instead of normalization.  This avoids extra complexity, as we
+	 * don't consider extreme large input buffers in one go.
+	 *
+	 * [1] https://github.com/tukaani-project/xz/blob/v5.4.0/src/liblzma/lz/lz_encoder_mf.c#L94
+	 */
+	if (unlikely(mf->base > ((typeof(mf->base))-1) >> 1)) {
+		mf->base = kHistorySize32 + 1;
+		memset(mf->hash, 0, 0x10000 * sizeof(mf->hash[0]));
+		memset(mf->chain, 0, sizeof(mf->chain[0]) * mf->wsiz);
+	}
 	mf->offset = 0;
 	mf->cyclic_pos = 0;
 
-- 
2.39.3

