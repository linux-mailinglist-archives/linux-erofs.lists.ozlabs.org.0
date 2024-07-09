Return-Path: <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>
X-Original-To: lists+linux-erofs@lfdr.de
Delivered-To: lists+linux-erofs@lfdr.de
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2404:9400:2:0:216:3eff:fee1:b9f1])
	by mail.lfdr.de (Postfix) with ESMTPS id C9F7F92AF41
	for <lists+linux-erofs@lfdr.de>; Tue,  9 Jul 2024 07:07:16 +0200 (CEST)
Authentication-Results: lists.ozlabs.org;
	dkim=pass (1024-bit key; unprotected) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.a=rsa-sha256 header.s=default header.b=uOU07uM3;
	dkim-atps=neutral
Received: from boromir.ozlabs.org (localhost [IPv6:::1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4WJ89t3xfTz3fRk
	for <lists+linux-erofs@lfdr.de>; Tue,  9 Jul 2024 15:07:14 +1000 (AEST)
X-Original-To: linux-erofs@lists.ozlabs.org
Delivered-To: linux-erofs@lists.ozlabs.org
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (1024-bit key; unprotected) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.a=rsa-sha256 header.s=default header.b=uOU07uM3;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=linux.alibaba.com (client-ip=115.124.30.113; helo=out30-113.freemail.mail.aliyun.com; envelope-from=hongzhen@linux.alibaba.com; receiver=lists.ozlabs.org)
Received: from out30-113.freemail.mail.aliyun.com (out30-113.freemail.mail.aliyun.com [115.124.30.113])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4WJ89n4gRpz30Np
	for <linux-erofs@lists.ozlabs.org>; Tue,  9 Jul 2024 15:07:08 +1000 (AEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=linux.alibaba.com; s=default;
	t=1720501624; h=From:To:Subject:Date:Message-ID:MIME-Version;
	bh=DgSMPu33pQncI+m+5gylaFI6dVuX3ozhEYFyqI3NlTs=;
	b=uOU07uM3hX1pjTFBmeJgoJVJyOelp3EYIfwyoHuhNqwk3MSijrYDbejESO/RWux+fsieug9tQLf53uyldHxyUhkNqgpOW6YqJGMNQjSpwOIEVVu8nZkvZaCSlYcswpCRjIqa3NqTlvsVBiOk+klcMStqd1pc6Qmabo5+9h2r8DY=
X-Alimail-AntiSpam: AC=PASS;BC=-1|-1;BR=01201311R151e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=maildocker-contentspam033037067112;MF=hongzhen@linux.alibaba.com;NM=1;PH=DS;RN=2;SR=0;TI=SMTPD_---0WAARAV3_1720501621;
Received: from localhost(mailfrom:hongzhen@linux.alibaba.com fp:SMTPD_---0WAARAV3_1720501621)
          by smtp.aliyun-inc.com;
          Tue, 09 Jul 2024 13:07:02 +0800
From: Hongzhen Luo <hongzhen@linux.alibaba.com>
To: linux-erofs@lists.ozlabs.org
Subject: [PATCH v2] erofs-utils: fix bitops fls_long
Date: Tue,  9 Jul 2024 13:07:00 +0800
Message-ID: <20240709050700.2911563-1-hongzhen@linux.alibaba.com>
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

The __builtin_clz is for unsigned int, while it is applied
to unsigned long. This fixes it by using __builtin_clzl.

The parameter types for the calls referencing fls_long have
been adjusted (e.g., roundup_pow_of_two in erofs_init_devices).

Signed-off-by: Hongzhen Luo <hongzhen@linux.alibaba.com>
---
v2: The parameter types for the function calls affected by this fix have been updated.
v1: https://lore.kernel.org/all/20240709022031.2752872-1-hongzhen@linux.alibaba.com/
---
 include/erofs/defs.h | 2 +-
 lib/super.c          | 2 +-
 2 files changed, 2 insertions(+), 2 deletions(-)

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
diff --git a/lib/super.c b/lib/super.c
index 3fbaf66..2d3180e 100644
--- a/lib/super.c
+++ b/lib/super.c
@@ -27,7 +27,7 @@ static bool check_layout_compatibility(struct erofs_sb_info *sbi,
 static int erofs_init_devices(struct erofs_sb_info *sbi,
 			      struct erofs_super_block *dsb)
 {
-	unsigned int ondisk_extradevs, i;
+	unsigned long ondisk_extradevs, i;
 	erofs_off_t pos;
 
 	sbi->total_blocks = sbi->primarydevice_blocks;
-- 
2.43.5

