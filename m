Return-Path: <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>
X-Original-To: lists+linux-erofs@lfdr.de
Delivered-To: lists+linux-erofs@lfdr.de
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	by mail.lfdr.de (Postfix) with ESMTPS id D507A4AE12A
	for <lists+linux-erofs@lfdr.de>; Tue,  8 Feb 2022 19:43:33 +0100 (CET)
Received: from boromir.ozlabs.org (localhost [IPv6:::1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4JtX2q3sh0z3bTT
	for <lists+linux-erofs@lfdr.de>; Wed,  9 Feb 2022 05:43:31 +1100 (AEDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=lists.ozlabs.org;
	s=201707; t=1644345811;
	bh=cGo6qhj9mPFrI0ABrWIq8yrJ6K24RlP92l+fnqIdelU=;
	h=Date:In-Reply-To:References:Subject:To:List-Id:List-Unsubscribe:
	 List-Archive:List-Post:List-Help:List-Subscribe:From:Reply-To:Cc:
	 From;
	b=EbZE4MYuZtN6xs+aNCLmD+hdOH8ULm+FwCK91HdFmc1TCw0uxxVZYez1YSdkyDe4a
	 fWq79b1/b2BgggcWzqRX3uRSnk34yeM+YpP2YX5uwOe0GmsbjKAJrxpbyYrqdKccpo
	 +o1uoxa31q13JANe1JCN6mFxs4xEEOAx5dsGQYuZ7O9NEOQxHQ8DCgF5D/bYtETe3W
	 NSttz2Tu9973axfPObIUKfP2A1YIH49MSzW/JgRBib8o2t0ZfedUBFIiqLWZBFcZSi
	 9hsL+MS/QW5Xop6l0wIRbYDJ310vYlNbDUL+i/ZueudHEF6/JjwK7Qtv3amSA44aB0
	 lKXs2N2pR0rfg==
X-Original-To: linux-erofs@lists.ozlabs.org
Delivered-To: linux-erofs@lists.ozlabs.org
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized)
 smtp.mailfrom=flex--zhangkelvin.bounces.google.com
 (client-ip=2607:f8b0:4864:20::a4a; helo=mail-vk1-xa4a.google.com;
 envelope-from=3ybkcygskc14vd6jcgahrejckkcha.8kihejqt-ankboheopo.kvh67o.knc@flex--zhangkelvin.bounces.google.com;
 receiver=<UNKNOWN>)
Authentication-Results: lists.ozlabs.org; dkim=pass (2048-bit key;
 unprotected) header.d=google.com header.i=@google.com header.a=rsa-sha256
 header.s=20210112 header.b=mJ2JH/A7; dkim-atps=neutral
Received: from mail-vk1-xa4a.google.com (mail-vk1-xa4a.google.com
 [IPv6:2607:f8b0:4864:20::a4a])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 4JtX2m5XN8z30LY
 for <linux-erofs@lists.ozlabs.org>; Wed,  9 Feb 2022 05:43:26 +1100 (AEDT)
Received: by mail-vk1-xa4a.google.com with SMTP id
 35-20020a056122072300b0032591f1a5e7so2304041vki.14
 for <linux-erofs@lists.ozlabs.org>; Tue, 08 Feb 2022 10:43:26 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=x-gm-message-state:date:in-reply-to:message-id:mime-version
 :references:subject:from:to:cc;
 bh=cGo6qhj9mPFrI0ABrWIq8yrJ6K24RlP92l+fnqIdelU=;
 b=3XoN1KhL0G+DY7GfB8HF6/rAxlTW6+pOda8AU1JKLycVM9nbq3j/T4gLCJwPwbnT4w
 2KYqgvIcdCPEb6sUbH88By8dkt9N5j2aJeNV/oyFMzzDw2o2hiknEkLHUy8Zu3C5TrN6
 EQ0LTCct2L1rI9eaES3g0yZ/tS3uoambdvZSRV3lu87bedbBQNzikx2py2nhRr/SoULq
 pEyPuRPY0MjbKExeIp5Yf8uxoLBsx6DIVsSZ49PM766MV3foStSRQ6IaL0WFsuZXMIG7
 r+Ms7YoSenXZKnxnejh0SNhRHH2jCVqT+R0GmvByC8zzTGf8SbmYN6NpS28mtI3akbp0
 KgZg==
X-Gm-Message-State: AOAM530jaweKDgBnjewu6IwCUA2MncuXks9O7YHXCTMlMgciQJNrEC7a
 gPhVqkIxJlRj2nuQNqXtnYgD/GrqQcvC33n9AGUDPATsbL97Djd2tDnZc/8r52E5x2J3kMonGdg
 TlO+SfUNNGdCIN/jfF9/7Tb9Xqy0r+xPeRaeWruijZ2p3tDtMTV+gHSHFta7BDeN6zclzvqEflt
 QCvobFRoE=
X-Google-Smtp-Source: ABdhPJxavLIw7eM+pHZkREGZm06TdfBfsmh5f/RaGntM+WzMxtkGKEaC5RBeQc4SO6zam4fclaBlbl2TujkXdbPfxQ==
X-Received: from zhangkelvin-big.c.googlers.com
 ([fda3:e722:ac3:cc00:14:4d90:c0a8:1f4a])
 (user=zhangkelvin job=sendgmr) by 2002:a05:6122:c8f:: with SMTP id
 ba15mr2308940vkb.39.1644345801507; Tue, 08 Feb 2022 10:43:21 -0800 (PST)
Date: Tue,  8 Feb 2022 10:43:17 -0800
In-Reply-To: <YgGUL3aWmPmBvJ7z@B-P7TQMD6M-0146.local>
Message-Id: <20220208184317.3639405-1-zhangkelvin@google.com>
Mime-Version: 1.0
References: <YgGUL3aWmPmBvJ7z@B-P7TQMD6M-0146.local>
X-Mailer: git-send-email 2.35.0.263.gb82422642f-goog
Subject: [PATCH v3] erofs-utils: lib: Fix 8MB bug on uncompressed extent size
To: linux-erofs mailing list <linux-erofs@lists.ozlabs.org>,
 Miao Xie <miaoxie@huawei.com>, Fang Wei <fangwei1@huawei.com>
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
From: Kelvin Zhang via Linux-erofs <linux-erofs@lists.ozlabs.org>
Reply-To: Kelvin Zhang <zhangkelvin@google.com>
Cc: Kelvin Zhang <zhangkelvin@google.com>
Errors-To: linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org
Sender: "Linux-erofs"
 <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>

Previously, uncompressed extent can be at most 8MB before mkfs.erofs
crashes on some error condition. This is due to a minor bug in how
compressed indices are encoded. This patch fixes the issue.

Signed-off-by: Kelvin Zhang <zhangkelvin@google.com>
---
 lib/compress.c | 18 +++++++++++++++++-
 1 file changed, 17 insertions(+), 1 deletion(-)

diff --git a/lib/compress.c b/lib/compress.c
index 98be7a2..add95f5 100644
--- a/lib/compress.c
+++ b/lib/compress.c
@@ -97,7 +97,23 @@ static void vle_write_indexes(struct z_erofs_vle_compress_ctx *ctx,
 		} else if (d0) {
 			type = Z_EROFS_VLE_CLUSTER_TYPE_NONHEAD;
 
-			di.di_u.delta[0] = cpu_to_le16(d0);
+			/*
+			 * If the |Z_EROFS_VLE_DI_D0_CBLKCNT| bit is set, parser
+			 * will interpret |delta[0]| as size of pcluster, rather
+			 * than distance to last head cluster. Normally this
+			 * isn't a problem, because uncompressed extent size are
+			 * below Z_EROFS_VLE_DI_D0_CBLKCNT * BLOCK_SIZE = 8MB.
+			 * But with large pcluster it's possible to go over this
+			 * number, resulting in corrupted compressed indices.
+			 * To solve this, we replace d0 with
+			 * Z_EROFS_VLE_DI_D0_CBLKCNT-1.
+			 */
+			if (d0 > Z_EROFS_VLE_DI_D0_CBLKCNT) {
+				di.di_u.delta[0] = cpu_to_le16(
+					Z_EROFS_VLE_DI_D0_CBLKCNT-1);
+			} else {
+				di.di_u.delta[0] = cpu_to_le16(d0);
+			}
 			di.di_u.delta[1] = cpu_to_le16(d1);
 		} else {
 			type = raw ? Z_EROFS_VLE_CLUSTER_TYPE_PLAIN :
-- 
2.35.0.263.gb82422642f-goog

