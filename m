Return-Path: <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>
X-Original-To: lists+linux-erofs@lfdr.de
Delivered-To: lists+linux-erofs@lfdr.de
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	by mail.lfdr.de (Postfix) with ESMTPS id 0236E92B151
	for <lists+linux-erofs@lfdr.de>; Tue,  9 Jul 2024 09:38:35 +0200 (CEST)
Authentication-Results: lists.ozlabs.org;
	dkim=pass (1024-bit key; unprotected) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.a=rsa-sha256 header.s=default header.b=K1QTR3cK;
	dkim-atps=neutral
Received: from boromir.ozlabs.org (localhost [IPv6:::1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4WJCXS5q7Sz3cXw
	for <lists+linux-erofs@lfdr.de>; Tue,  9 Jul 2024 17:38:32 +1000 (AEST)
X-Original-To: linux-erofs@lists.ozlabs.org
Delivered-To: linux-erofs@lists.ozlabs.org
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (1024-bit key; unprotected) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.a=rsa-sha256 header.s=default header.b=K1QTR3cK;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=linux.alibaba.com (client-ip=115.124.30.99; helo=out30-99.freemail.mail.aliyun.com; envelope-from=hongzhen@linux.alibaba.com; receiver=lists.ozlabs.org)
Received: from out30-99.freemail.mail.aliyun.com (out30-99.freemail.mail.aliyun.com [115.124.30.99])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4WJCXN3DMJz2ysD
	for <linux-erofs@lists.ozlabs.org>; Tue,  9 Jul 2024 17:38:25 +1000 (AEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=linux.alibaba.com; s=default;
	t=1720510701; h=From:To:Subject:Date:Message-ID:MIME-Version;
	bh=H/X1DCi5G428Yb0df7b2j8rCETv3GJ5VWu53bPVzxPc=;
	b=K1QTR3cK0Cxw2X9nz/+3WBB7GTiFe0eZFvEe5V0D4GIdfDqvQwhB4crMrPyOFTU2LHs9g48zsLJS3e8utqUxhNnP4pKjWacZJepwb4ybOLiVQn+INoqrpJlpf0d/JUJhSqYUv2N57jAUTNtllSeWxCx/GC5MoQZC8zgYWg+ZuQ0=
X-Alimail-AntiSpam: AC=PASS;BC=-1|-1;BR=01201311R181e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=maildocker-contentspam033045046011;MF=hongzhen@linux.alibaba.com;NM=1;PH=DS;RN=2;SR=0;TI=SMTPD_---0WAB1gb0_1720510700;
Received: from localhost(mailfrom:hongzhen@linux.alibaba.com fp:SMTPD_---0WAB1gb0_1720510700)
          by smtp.aliyun-inc.com;
          Tue, 09 Jul 2024 15:38:20 +0800
From: Hongzhen Luo <hongzhen@linux.alibaba.com>
To: linux-erofs@lists.ozlabs.org
Subject: [PATCH v3] erofs-utils: fix bitops fls_long()
Date: Tue,  9 Jul 2024 15:38:19 +0800
Message-ID: <20240709073819.3061805-1-hongzhen@linux.alibaba.com>
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
Cc: Hongzhen Luo <hongzhen@linux.alibaba.com>
Errors-To: linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org
Sender: "Linux-erofs" <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>

The `__builtin_clz` is for unsigned int, while it is applied
to unsigned long. This fixes it by using `__builtin_clzl`.

It does not impact any existing use cases in the whole codebase,
since the only caller of `fls_long` is `roundup_pow_of_two` in
`erofs_init_devices`, and the default compile optimization level
is O2. At this level, the argument passed to `roundup_pow_of_two`
is optimized into a constant, bypassing the logic of `fls_long`.

Signed-off-by: Hongzhen Luo <hongzhen@linux.alibaba.com>
---
v3: Update the commit message. 
v2: https://lore.kernel.org/all/20240709050700.2911563-1-hongzhen@linux.alibaba.com/
v1: https://lore.kernel.org/all/20240709022031.2752872-1-hongzhen@linux.alibaba.com/
---
 include/erofs/defs.h | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/include/erofs/defs.h b/include/erofs/defs.h
index e0798c8..310a6ab 100644
--- a/include/erofs/defs.h
+++ b/include/erofs/defs.h
@@ -288,7 +288,7 @@ static inline u32 get_unaligned_le64(const void *p)
 
 static inline unsigned int fls_long(unsigned long x)
 {
-	return x ? sizeof(x) * 8 - __builtin_clz(x) : 0;
+	return x ? sizeof(x) * 8 - __builtin_clzl(x) : 0;
 }
 
 static inline unsigned long lowbit(unsigned long n)
-- 
2.43.5

