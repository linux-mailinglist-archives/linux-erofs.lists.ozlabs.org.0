Return-Path: <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>
X-Original-To: lists+linux-erofs@lfdr.de
Delivered-To: lists+linux-erofs@lfdr.de
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	by mail.lfdr.de (Postfix) with ESMTPS id 31DEC915984
	for <lists+linux-erofs@lfdr.de>; Tue, 25 Jun 2024 00:02:32 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=lists.ozlabs.org;
	s=201707; t=1719266548;
	bh=s+EfJ0AoKGlj/+Y6NKu6RGkBJo/MER6SHrvQPfBXON4=;
	h=Date:Subject:To:List-Id:List-Unsubscribe:List-Archive:List-Post:
	 List-Help:List-Subscribe:From:Reply-To:Cc:From;
	b=T3GjO6VFB7dJNSMgzt0+47urUBXN8SH3BV95HXAUVx4Gt6HLRXwsI6YzuO+xFr2Ge
	 khUfE1k2QQHq1VumnvxsxqkzoFebpvvopRSdP2WDKmvOisGmHLp6ynunldbNxBngQ+
	 qZ1LwBu4f4C+j91oWmcoCQnv95OqVyU8AOcrLkBa673An8Tsgqh/h5dz8Q9LNNC3wy
	 gK3gxmuLYQdoOKbLCZeJDiZrQ0Q4QXiNfUyeixbEsBxBPr/iUvblChqiwmpQcGcDd6
	 yfg36AWb8kGFrjn5Z5ggKRgpXBmKF6odj3YsfurHdbudYEHK/iaGxYrDVs4ZaCqi/4
	 B+KDM8ANOAQCA==
Received: from boromir.ozlabs.org (localhost [IPv6:::1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4W7MQD5KxWz3c6n
	for <lists+linux-erofs@lfdr.de>; Tue, 25 Jun 2024 08:02:28 +1000 (AEST)
X-Original-To: linux-erofs@lists.ozlabs.org
Delivered-To: linux-erofs@lists.ozlabs.org
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=google.com header.i=@google.com header.a=rsa-sha256 header.s=20230601 header.b=ovqvvoMO;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=flex--dhavale.bounces.google.com (client-ip=2607:f8b0:4864:20::b4a; helo=mail-yb1-xb4a.google.com; envelope-from=34-x5zgckc94dhavalegoogle.comlinux-erofslists.ozlabs.org@flex--dhavale.bounces.google.com; receiver=lists.ozlabs.org)
Received: from mail-yb1-xb4a.google.com (mail-yb1-xb4a.google.com [IPv6:2607:f8b0:4864:20::b4a])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4W7MQ54mplz3020
	for <linux-erofs@lists.ozlabs.org>; Tue, 25 Jun 2024 08:02:19 +1000 (AEST)
Received: by mail-yb1-xb4a.google.com with SMTP id 3f1490d57ef6-dfefc2c8569so9562215276.3
        for <linux-erofs@lists.ozlabs.org>; Mon, 24 Jun 2024 15:02:21 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1719266532; x=1719871332;
        h=cc:to:from:subject:message-id:mime-version:date:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=s+EfJ0AoKGlj/+Y6NKu6RGkBJo/MER6SHrvQPfBXON4=;
        b=ivei6bCNuQ8L8HzV1aT68tiZB/Da+zDUncuf3wKNbIhqfMPLKwG6ib6IJ7xrdNHhrh
         roVfEtyjZBSKIPZp9ygo/rV6sMWOdBrPGA6auH3s3UDt3aI9mewpkxSAKVyoisTjHrn+
         Ci6WAp/06cgQaDtCVe77YhShm3H3MqBIQAR2vtqYoU3dBxGMAOztodwJEAWV0oWSV6uY
         VE46XHarEdKzslOQMcup1rwLj/Nes2ptXzuTx3l5+fGbAVo2d7F4XreRA2B7dQBoybIe
         pPmmulOdzFsrbnsmxLBOS4eKu925uB5KfKSsWhQLG4D7TxUKZJHsF3nD+8jUQp0pJgzZ
         FLcA==
X-Gm-Message-State: AOJu0Yyr1B81tdZUrTfQozq5TnbT6FB7oTTrqJG4R+CH39DbVvLcCmVb
	/ewwkaveqYcV/6HYbb+QHsWNox8AgB9iMgAwO1P97OCz5QDTi3eUsAp145sf9lyfcV3ErHmrHTr
	vBHebTDpXydfJ/BqeCvJjb2tti8bBiNAaDf10AYXpzgcX6mOEGcZb6WuE0l+CbOoocDuMQjzNY3
	+N4c5DcdHU40/xg+RMTWkYrNVUyP0v9PU78HSLrhRuxTa6jw==
X-Google-Smtp-Source: AGHT+IHLhxwyVv9nMVrC3Jwu4bpC9flEqE3SXuk9eeKuPJOpyr4XzP7jLnmABDJo9hUdNQV/1SKqydFBjFpL
X-Received: from dhavale-desktop.mtv.corp.google.com ([2620:15c:211:201:307c:c43a:8b68:c64f])
 (user=dhavale job=sendgmr) by 2002:a05:6902:1241:b0:dff:3ec0:71c1 with SMTP
 id 3f1490d57ef6-e0303fbf483mr103883276.8.1719266531828; Mon, 24 Jun 2024
 15:02:11 -0700 (PDT)
Date: Mon, 24 Jun 2024 15:02:05 -0700
Mime-Version: 1.0
X-Mailer: git-send-email 2.45.2.741.gdbec12cfda-goog
Message-ID: <20240624220206.3373197-1-dhavale@google.com>
Subject: [PATCH v1] erofs: fix possible memory leak in z_erofs_gbuf_exit()
To: linux-erofs@lists.ozlabs.org, Gao Xiang <xiang@kernel.org>, 
	Chao Yu <chao@kernel.org>, Yue Hu <huyue2@coolpad.com>, 
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
Cc: hsiangkao@linux.alibaba.com, kernel-team@android.com, linux-kernel@vger.kernel.org
Errors-To: linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org
Sender: "Linux-erofs" <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>

Because we incorrectly reused of variable `i` in `z_erofs_gbuf_exit()`
for inner loop, we may exit early from outer loop resulting in memory
leak. Fix this by using separate variable for iterating through inner loop.

Fixes: f36f3010f676 ("erofs: rename per-CPU buffers to global buffer pool and make it configurable")

Signed-off-by: Sandeep Dhavale <dhavale@google.com>
---
 fs/erofs/zutil.c | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/fs/erofs/zutil.c b/fs/erofs/zutil.c
index 036024bce9f7..b80f612867c2 100644
--- a/fs/erofs/zutil.c
+++ b/fs/erofs/zutil.c
@@ -148,7 +148,7 @@ int __init z_erofs_gbuf_init(void)
 
 void z_erofs_gbuf_exit(void)
 {
-	int i;
+	int i, j;
 
 	for (i = 0; i < z_erofs_gbuf_count + (!!z_erofs_rsvbuf); ++i) {
 		struct z_erofs_gbuf *gbuf = &z_erofs_gbufpool[i];
@@ -161,9 +161,9 @@ void z_erofs_gbuf_exit(void)
 		if (!gbuf->pages)
 			continue;
 
-		for (i = 0; i < gbuf->nrpages; ++i)
-			if (gbuf->pages[i])
-				put_page(gbuf->pages[i]);
+		for (j = 0; j < gbuf->nrpages; ++j)
+			if (gbuf->pages[j])
+				put_page(gbuf->pages[j]);
 		kfree(gbuf->pages);
 		gbuf->pages = NULL;
 	}
-- 
2.45.2.741.gdbec12cfda-goog

