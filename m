Return-Path: <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>
X-Original-To: lists+linux-erofs@lfdr.de
Delivered-To: lists+linux-erofs@lfdr.de
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2404:9400:2:0:216:3eff:fee1:b9f1])
	by mail.lfdr.de (Postfix) with ESMTPS id 18FBB92AE23
	for <lists+linux-erofs@lfdr.de>; Tue,  9 Jul 2024 04:20:50 +0200 (CEST)
Authentication-Results: lists.ozlabs.org;
	dkim=pass (1024-bit key; unprotected) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.a=rsa-sha256 header.s=default header.b=epMc2CNx;
	dkim-atps=neutral
Received: from boromir.ozlabs.org (localhost [IPv6:::1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4WJ4Tp4FmZz3cNV
	for <lists+linux-erofs@lfdr.de>; Tue,  9 Jul 2024 12:20:46 +1000 (AEST)
X-Original-To: linux-erofs@lists.ozlabs.org
Delivered-To: linux-erofs@lists.ozlabs.org
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (1024-bit key; unprotected) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.a=rsa-sha256 header.s=default header.b=epMc2CNx;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=linux.alibaba.com (client-ip=115.124.30.119; helo=out30-119.freemail.mail.aliyun.com; envelope-from=hongzhen@linux.alibaba.com; receiver=lists.ozlabs.org)
Received: from out30-119.freemail.mail.aliyun.com (out30-119.freemail.mail.aliyun.com [115.124.30.119])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4WJ4Tj4JJmz2ysg
	for <linux-erofs@lists.ozlabs.org>; Tue,  9 Jul 2024 12:20:38 +1000 (AEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=linux.alibaba.com; s=default;
	t=1720491634; h=From:To:Subject:Date:Message-ID:MIME-Version;
	bh=BCMKHQaYkubxnIn7k6ABlFn86+rfwlC9FD4bdUR9c1E=;
	b=epMc2CNxvmX1ZXfrHxUTR9Z/3ywmTQ2RFgXE7MHvTM1CwZDx9I9ln3e/ppTA5wrFnJB155bxvibk7u1yZGTJRYVy4qg8GUBtw8PbOIo7U0v06gqJVHVCRli/TjHqPLVn2FzmlMZFEVCc44963JeP1Oo2nKe3tPtgV8D89LK9GDs=
X-Alimail-AntiSpam: AC=PASS;BC=-1|-1;BR=01201311R161e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=maildocker-contentspam033037067109;MF=hongzhen@linux.alibaba.com;NM=1;PH=DS;RN=2;SR=0;TI=SMTPD_---0WA9lV8._1720491632;
Received: from localhost(mailfrom:hongzhen@linux.alibaba.com fp:SMTPD_---0WA9lV8._1720491632)
          by smtp.aliyun-inc.com;
          Tue, 09 Jul 2024 10:20:33 +0800
From: Hongzhen Luo <hongzhen@linux.alibaba.com>
To: linux-erofs@lists.ozlabs.org
Subject: [PATCH] erofs-utils: fix bitops fls_long
Date: Tue,  9 Jul 2024 10:20:31 +0800
Message-ID: <20240709022031.2752872-1-hongzhen@linux.alibaba.com>
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

Signed-off-by: Hongzhen Luo <hongzhen@linux.alibaba.com>
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

