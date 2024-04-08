Return-Path: <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>
X-Original-To: lists+linux-erofs@lfdr.de
Delivered-To: lists+linux-erofs@lfdr.de
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2404:9400:2:0:216:3eff:fee1:b9f1])
	by mail.lfdr.de (Postfix) with ESMTPS id 69FF889CDDE
	for <lists+linux-erofs@lfdr.de>; Mon,  8 Apr 2024 23:55:05 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=lists.ozlabs.org;
	s=201707; t=1712613303;
	bh=amcZSzW3yyTzEXypL37TcjBNZBV4M3dWgOvIguTbuzI=;
	h=Date:Subject:To:List-Id:List-Unsubscribe:List-Archive:List-Post:
	 List-Help:List-Subscribe:From:Reply-To:Cc:From;
	b=ltNCKvdu+Gi+wt2TkqzqpfE9jS+Pbwt8qqxZAAeYMwZ0kqQq2JuxL+7cG5xX1LFKd
	 ht3aEAj8PXVxGgcDa1TCzDQJpox82K375pK4t3DGQYEM3UtEDUDzz8ZDkXzMUklv49
	 ATre6bnbZqIQh4tNDD2qJGCfp4axfB10xYZU8VcFEB3cNZ8oMfpkGKZKtq2lfmKNdd
	 mlUyd/J+dVsLVtUYF+4Ldx8G9igGL4ve01uMmBKA0ITB9h/wvEog0NivUfAp5dRyAT
	 ir1LKtfWirXYZ/eJqOop+X7Y2Kunn72kbtsD3Gg6WkWLOcMknBsNunv3xVUqFGs6JB
	 A69c8u/NIt8vA==
Received: from boromir.ozlabs.org (localhost [IPv6:::1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4VD2vC1C1Nz3vbd
	for <lists+linux-erofs@lfdr.de>; Tue,  9 Apr 2024 07:55:03 +1000 (AEST)
X-Original-To: linux-erofs@lists.ozlabs.org
Delivered-To: linux-erofs@lists.ozlabs.org
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=google.com header.i=@google.com header.a=rsa-sha256 header.s=20230601 header.b=OwwstqlY;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=flex--dhavale.bounces.google.com (client-ip=2607:f8b0:4864:20::1149; helo=mail-yw1-x1149.google.com; envelope-from=3jgcuzgckc3scgzuzkdfnnfkd.bnlkhmtw-dqnerkhrsr.nykzar.nqf@flex--dhavale.bounces.google.com; receiver=lists.ozlabs.org)
Received: from mail-yw1-x1149.google.com (mail-yw1-x1149.google.com [IPv6:2607:f8b0:4864:20::1149])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4VD2rV5FJPz3vZ0
	for <linux-erofs@lists.ozlabs.org>; Tue,  9 Apr 2024 07:52:41 +1000 (AEST)
Received: by mail-yw1-x1149.google.com with SMTP id 00721157ae682-61510f72bb3so83963757b3.0
        for <linux-erofs@lists.ozlabs.org>; Mon, 08 Apr 2024 14:52:41 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1712613156; x=1713217956;
        h=cc:to:from:subject:message-id:mime-version:date:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=amcZSzW3yyTzEXypL37TcjBNZBV4M3dWgOvIguTbuzI=;
        b=Soa4b740Ut0yS7weoVMltDDwuYfzSCl5u64C+rCPJZP8QjikRXFknk7cXBxYBvceat
         CnGZdCtUfH+plWM/lXsbaGWYfYJ4FSeXsiCZmrIAof+KKpvOnLYcZgOd9vZ3rRJPMFbf
         JPvrmjZetN732FAii62HwAxlDh8DOsIw47bvKiNdvBICH/+pQQoCG/R7EFOvvtSASOlF
         1lGFD73lh2KYSmBqDDCNHUowx4DwkKINEELkKoNivHSQzbPJQ5tfWR6UJ7O2hl86nEmV
         J/C8aKXx+c1RhvTVTgdlr20MN53B/O+hBUCAD8YpkzWroIMgJ7UJeoCyO6DCFj4xiC3+
         zSMQ==
X-Gm-Message-State: AOJu0Yzslz0VKNfCcSduBINIA5oLCsxD20eeHhtpyiUtlBxy2FHfaFSW
	QodV/RreoAo3tNVW0yY5M+nvI0Fz8amLtin2QoqKKwdskueVNwH2YH31B72Qu/TSrXdTRxtqvYD
	vuXzGoA==
X-Google-Smtp-Source: AGHT+IEkq+yrPhgyYDRCrGfUbGremKSvF9Tls/NyM9Ex8fLO1ww0uaL+bHkVzWJv2HGc6KYIwiPvmzeEyS36
X-Received: from dhavale-desktop.mtv.corp.google.com ([2620:15c:211:201:9081:5db7:4b17:a606])
 (user=dhavale job=sendgmr) by 2002:a81:ff05:0:b0:615:12a5:49c9 with SMTP id
 k5-20020a81ff05000000b0061512a549c9mr2538367ywn.3.1712613156122; Mon, 08 Apr
 2024 14:52:36 -0700 (PDT)
Date: Mon,  8 Apr 2024 14:52:29 -0700
Mime-Version: 1.0
X-Mailer: git-send-email 2.44.0.478.gd926399ef9-goog
Message-ID: <20240408215231.3376659-1-dhavale@google.com>
Subject: [PATCH v1] erofs: use raw_smp_processor_id() to get buffer from
 global buffer pool
To: Gao Xiang <xiang@kernel.org>, Chao Yu <chao@kernel.org>, Yue Hu <huyue2@coolpad.com>, 
	Jeffle Xu <jefflexu@linux.alibaba.com>, Sandeep Dhavale <dhavale@google.com>, 
	Chunhai Guo <guochunhai@vivo.com>
Content-Type: text/plain; charset="UTF-8"
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
From: Sandeep Dhavale via Linux-erofs <linux-erofs@lists.ozlabs.org>
Reply-To: Sandeep Dhavale <dhavale@google.com>
Cc: kernel-team@android.com, syzbot+27cc650ef45b379dfe5a@syzkaller.appspotmail.com, linux-erofs@lists.ozlabs.org, linux-kernel@vger.kernel.org
Errors-To: linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org
Sender: "Linux-erofs" <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>

erofs will decompress in the preemptible context (kworker or per cpu
thread). As smp_processor_id() cannot be used in preemptible contexts,
use raw_smp_processor_id() instead to index into global buffer pool.

Reported-by: syzbot+27cc650ef45b379dfe5a@syzkaller.appspotmail.com
Fixes: 7a7513292cc6 ("erofs: rename per-CPU buffers to global buffer pool and make it configurable")
Signed-off-by: Sandeep Dhavale <dhavale@google.com>
---
 fs/erofs/zutil.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/fs/erofs/zutil.c b/fs/erofs/zutil.c
index b9b99158bb4e..036024bce9f7 100644
--- a/fs/erofs/zutil.c
+++ b/fs/erofs/zutil.c
@@ -30,7 +30,7 @@ static struct shrinker *erofs_shrinker_info;
 
 static unsigned int z_erofs_gbuf_id(void)
 {
-	return smp_processor_id() % z_erofs_gbuf_count;
+	return raw_smp_processor_id() % z_erofs_gbuf_count;
 }
 
 void *z_erofs_get_gbuf(unsigned int requiredpages)
-- 
2.44.0.478.gd926399ef9-goog

