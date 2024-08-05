Return-Path: <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>
X-Original-To: lists+linux-erofs@lfdr.de
Delivered-To: lists+linux-erofs@lfdr.de
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	by mail.lfdr.de (Postfix) with ESMTPS id 252A29473CF
	for <lists+linux-erofs@lfdr.de>; Mon,  5 Aug 2024 05:25:35 +0200 (CEST)
Authentication-Results: lists.ozlabs.org;
	dkim=pass (1024-bit key; unprotected) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.a=rsa-sha256 header.s=default header.b=xEa3gMkj;
	dkim-atps=neutral
Received: from boromir.ozlabs.org (localhost [IPv6:::1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4Wchf50c5Pz3cY0
	for <lists+linux-erofs@lfdr.de>; Mon,  5 Aug 2024 13:25:33 +1000 (AEST)
X-Original-To: linux-erofs@lists.ozlabs.org
Delivered-To: linux-erofs@lists.ozlabs.org
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (1024-bit key; unprotected) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.a=rsa-sha256 header.s=default header.b=xEa3gMkj;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=linux.alibaba.com (client-ip=115.124.30.113; helo=out30-113.freemail.mail.aliyun.com; envelope-from=hongzhen@linux.alibaba.com; receiver=lists.ozlabs.org)
Received: from out30-113.freemail.mail.aliyun.com (out30-113.freemail.mail.aliyun.com [115.124.30.113])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4Wchdz6S8Pz2y71
	for <linux-erofs@lists.ozlabs.org>; Mon,  5 Aug 2024 13:25:26 +1000 (AEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=linux.alibaba.com; s=default;
	t=1722828322; h=From:To:Subject:Date:Message-ID:MIME-Version;
	bh=U+SrWWxX9SVcxf5n7k1KoZldkhREYThJLL8jzZgaYK8=;
	b=xEa3gMkjk5DOPts35UcKpjf9Dstl9U/2MSODAMmHsIGu2DW0Er7DCM1S00wOxpaMG3jKt2LrZg9k1YUupWRU5pnWiiU8OYw6GR/jN5UnWZcULOaBqW7jtIo9rHa7r6ou3XQ7rThLCZwhKtU03SSBr5lEHHzP61/TkGp1HEHKTbw=
X-Alimail-AntiSpam: AC=PASS;BC=-1|-1;BR=01201311R631e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=maildocker-contentspam033032019045;MF=hongzhen@linux.alibaba.com;NM=1;PH=DS;RN=2;SR=0;TI=SMTPD_---0WC2a7re_1722828320;
Received: from localhost(mailfrom:hongzhen@linux.alibaba.com fp:SMTPD_---0WC2a7re_1722828320)
          by smtp.aliyun-inc.com;
          Mon, 05 Aug 2024 11:25:21 +0800
From: Hongzhen Luo <hongzhen@linux.alibaba.com>
To: linux-erofs@lists.ozlabs.org
Subject: [PATCH] erofs-utils: lib: fix potential overflow issue
Date: Mon,  5 Aug 2024 11:25:10 +0800
Message-ID: <20240805032510.2637488-1-hongzhen@linux.alibaba.com>
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

Coverity-id: 502377

Signed-off-by: Hongzhen Luo <hongzhen@linux.alibaba.com>
---
 lib/kite_deflate.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/lib/kite_deflate.c b/lib/kite_deflate.c
index a5ebd66..e52e382 100644
--- a/lib/kite_deflate.c
+++ b/lib/kite_deflate.c
@@ -817,7 +817,8 @@ static const struct kite_matchfinder_cfg {
 /* 9 */ {32, 258, 258, 4096, true},	/* maximum compression */
 };
 
-static int kite_mf_init(struct kite_matchfinder *mf, int wsiz, int level)
+static int kite_mf_init(struct kite_matchfinder *mf, unsigned int wsiz,
+			int level)
 {
 	const struct kite_matchfinder_cfg *cfg;
 
-- 
2.43.5

