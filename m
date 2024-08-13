Return-Path: <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>
X-Original-To: lists+linux-erofs@lfdr.de
Delivered-To: lists+linux-erofs@lfdr.de
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	by mail.lfdr.de (Postfix) with ESMTPS id 84919950485
	for <lists+linux-erofs@lfdr.de>; Tue, 13 Aug 2024 14:10:36 +0200 (CEST)
Authentication-Results: lists.ozlabs.org;
	dkim=pass (1024-bit key; unprotected) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.a=rsa-sha256 header.s=default header.b=CkqWSpt1;
	dkim-atps=neutral
Received: from boromir.ozlabs.org (localhost [IPv6:::1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4WjqwB3BNSz2yNj
	for <lists+linux-erofs@lfdr.de>; Tue, 13 Aug 2024 22:10:34 +1000 (AEST)
X-Original-To: linux-erofs@lists.ozlabs.org
Delivered-To: linux-erofs@lists.ozlabs.org
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (1024-bit key; unprotected) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.a=rsa-sha256 header.s=default header.b=CkqWSpt1;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=linux.alibaba.com (client-ip=115.124.30.99; helo=out30-99.freemail.mail.aliyun.com; envelope-from=hongzhen@linux.alibaba.com; receiver=lists.ozlabs.org)
Received: from out30-99.freemail.mail.aliyun.com (out30-99.freemail.mail.aliyun.com [115.124.30.99])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4Wjqw70Xk7z2xWV
	for <linux-erofs@lists.ozlabs.org>; Tue, 13 Aug 2024 22:10:30 +1000 (AEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=linux.alibaba.com; s=default;
	t=1723551027; h=From:To:Subject:Date:Message-ID:MIME-Version;
	bh=d0ApG6ccrOYmJfLmmx2nvf/DozGEZmEE/LIqCIP6S14=;
	b=CkqWSpt1hKiBpAzyorU0Olxli3AEGI5YpdWZIC5Esx0V0MS32S9/9ePmdh7EMsBc/AswTqyGtOYNPdwikqWt447TEdX9afgODTAxIjsSRGJVAb5jJng5JAByY+3NVDwQR+lNM/GcMuz2YU7FIeEP+7z+bJGQtwIYYeJMa9RX9+U=
Received: from localhost(mailfrom:hongzhen@linux.alibaba.com fp:SMTPD_---0WCoynui_1723551024)
          by smtp.aliyun-inc.com;
          Tue, 13 Aug 2024 20:10:25 +0800
From: Hongzhen Luo <hongzhen@linux.alibaba.com>
To: linux-erofs@lists.ozlabs.org
Subject: [PATCH] erofs-utils: lib: fix potential overflow issue
Date: Tue, 13 Aug 2024 20:10:23 +0800
Message-ID: <20240813121023.781122-1-hongzhen@linux.alibaba.com>
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
Errors-To: linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org
Sender: "Linux-erofs" <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>

Coverity-id: 502353

Change 8U to 8ULL to avoid arithmetic multiplication overflow.

Signed-off-by: Hongzhen Luo <hongzhen@linux.alibaba.com>
---
 lib/kite_deflate.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/lib/kite_deflate.c b/lib/kite_deflate.c
index 8581834..4b1068b 100644
--- a/lib/kite_deflate.c
+++ b/lib/kite_deflate.c
@@ -892,7 +892,7 @@ static bool deflate_count_code(struct kite_deflate *s, bool literal,
 {
 	struct kite_deflate_table *t = s->tab;
 	unsigned int lenbase = (literal ? 0 : kSymbolMatch);
-	u64 rem = (s->outlen - s->pos_out) * 8 - s->bitpos;
+	u64 rem = (s->outlen - s->pos_out) * 8ULL - s->bitpos;
 	bool recalc = false;
 	unsigned int bits;
 
-- 
2.43.5

