Return-Path: <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>
X-Original-To: lists+linux-erofs@lfdr.de
Delivered-To: lists+linux-erofs@lfdr.de
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2404:9400:2:0:216:3eff:fee1:b9f1])
	by mail.lfdr.de (Postfix) with ESMTPS id D4E0375EFB3
	for <lists+linux-erofs@lfdr.de>; Mon, 24 Jul 2023 11:47:12 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=lists.ozlabs.org;
	s=201707; t=1690192030;
	bh=cYIc2pFR4p2fEyppjqJhI12Ags43zx4+1Vguh7yPn/A=;
	h=To:Subject:Date:In-Reply-To:References:List-Id:List-Unsubscribe:
	 List-Archive:List-Post:List-Help:List-Subscribe:From:Reply-To:Cc:
	 From;
	b=eotX+dUDdlfmx4gJ1+PoFMVHPYMdlVABqacZGoQ1cEnZRdwvedR3KNFw3xY+RulCi
	 x3o3sjuNuKIePqOCBkxT4+lkNkzoxD9PwU/1Ky+Y5YesVZgTMJqiBLDXEEBOfktSkf
	 fAM7uOw1+cbo1W4cWm98ZzPjEjEKcIz3CxYrqjqbDpkXW8AOB/3k4l5N4ekXHLWj9w
	 HsED8B0BLBkxhpvaBqaA+Xro3Ds1KSZbn8eXkDNqTUDd1ymJ+uuYP4qeMPYnuYCSMA
	 LYj7zgF/qrYEeWcsQM6s0i/lVgtdDpk8bM5VwnTJ2/vxHcYzpKNCnodQrFpkJbMLgE
	 afOgDucPs8iKQ==
Received: from boromir.ozlabs.org (localhost [IPv6:::1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4R8b0t5NDsz2yhS
	for <lists+linux-erofs@lfdr.de>; Mon, 24 Jul 2023 19:47:10 +1000 (AEST)
X-Original-To: linux-erofs@lists.ozlabs.org
Delivered-To: linux-erofs@lists.ozlabs.org
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=bytedance.com header.i=@bytedance.com header.a=rsa-sha256 header.s=google header.b=Mkbkj7G5;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=bytedance.com (client-ip=2607:f8b0:4864:20::633; helo=mail-pl1-x633.google.com; envelope-from=zhengqi.arch@bytedance.com; receiver=lists.ozlabs.org)
Received: from mail-pl1-x633.google.com (mail-pl1-x633.google.com [IPv6:2607:f8b0:4864:20::633])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4R8b0r5L0jz2yhS
	for <linux-erofs@lists.ozlabs.org>; Mon, 24 Jul 2023 19:47:08 +1000 (AEST)
Received: by mail-pl1-x633.google.com with SMTP id d9443c01a7336-1bb91c20602so2227375ad.0
        for <linux-erofs@lists.ozlabs.org>; Mon, 24 Jul 2023 02:47:08 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1690192027; x=1690796827;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=cYIc2pFR4p2fEyppjqJhI12Ags43zx4+1Vguh7yPn/A=;
        b=WFrDRnJPyhYXR3TUdsnwKy/RGw3ApZfDgFmamY5VbUv/sI9kLKCDcx/G9acBK3v82u
         Ocluf/R7WgLqk1mlLms66aUFfkJR7fiyn8cXsubHVDIcATrU6d4Cq4AjFOBNWpxHJjWE
         YldoQ4Jzzv3aFjxdviuUXz0Y7msiDtsd93EcRD2LbKDS2FwmKuQ5H9336F9mfGVFdUZz
         TJeiSuAXSWFx1z/9+wqSdyUXXwTNyICcUBpPtxc7bSl9GEdRqt/kfuM6SQiUvB0y3f2W
         vKZnyOO7RhsjUcHk3hixnrgIVrxeMjQJzQB8C30fotwcjHHFYe6i0o0bs6Goe6CQzd1V
         YE1w==
X-Gm-Message-State: ABy/qLasudtjHhmdaR5Mcr4b82crLzGfHlXUgYXn8U7mCCQuhi0roVdY
	vdJdjYYfyot7YUSXMu+kebnSBw==
X-Google-Smtp-Source: APBJJlE71N8j7jMrL1FzeS7v4yJrry2TgN0JWUZm9wk55uK2Ve/eQ/bXmY0X5mXvJcfiEdGHzkgvbw==
X-Received: by 2002:a17:902:ec8b:b0:1b3:d8ac:8db3 with SMTP id x11-20020a170902ec8b00b001b3d8ac8db3mr12337602plg.6.1690192026938;
        Mon, 24 Jul 2023 02:47:06 -0700 (PDT)
Received: from C02DW0BEMD6R.bytedance.net ([203.208.167.147])
        by smtp.gmail.com with ESMTPSA id d5-20020a170902c18500b001bb20380bf2sm8467233pld.13.2023.07.24.02.46.55
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 24 Jul 2023 02:47:06 -0700 (PDT)
To: akpm@linux-foundation.org,
	david@fromorbit.com,
	tkhai@ya.ru,
	vbabka@suse.cz,
	roman.gushchin@linux.dev,
	djwong@kernel.org,
	brauner@kernel.org,
	paulmck@kernel.org,
	tytso@mit.edu,
	steven.price@arm.com,
	cel@kernel.org,
	senozhatsky@chromium.org,
	yujie.liu@intel.com,
	gregkh@linuxfoundation.org,
	muchun.song@linux.dev
Subject: [PATCH v2 10/47] gfs2: dynamically allocate the gfs2-glock shrinker
Date: Mon, 24 Jul 2023 17:43:17 +0800
Message-Id: <20230724094354.90817-11-zhengqi.arch@bytedance.com>
X-Mailer: git-send-email 2.24.3 (Apple Git-128)
In-Reply-To: <20230724094354.90817-1-zhengqi.arch@bytedance.com>
References: <20230724094354.90817-1-zhengqi.arch@bytedance.com>
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
From: Qi Zheng via Linux-erofs <linux-erofs@lists.ozlabs.org>
Reply-To: Qi Zheng <zhengqi.arch@bytedance.com>
Cc: kvm@vger.kernel.org, dri-devel@lists.freedesktop.org, virtualization@lists.linux-foundation.org, linux-mm@kvack.org, dm-devel@redhat.com, linux-mtd@lists.infradead.org, x86@kernel.org, cluster-devel@redhat.com, xen-devel@lists.xenproject.org, linux-ext4@vger.kernel.org, linux-arm-msm@vger.kernel.org, rcu@vger.kernel.org, linux-bcache@vger.kernel.org, Qi Zheng <zhengqi.arch@bytedance.com>, linux-raid@vger.kernel.org, linux-nfs@vger.kernel.org, netdev@vger.kernel.org, linux-kernel@vger.kernel.org, linux-f2fs-devel@lists.sourceforge.net, linux-xfs@vger.kernel.org, linux-fsdevel@vger.kernel.org, linux-erofs@lists.ozlabs.org, linux-btrfs@vger.kernel.org
Errors-To: linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org
Sender: "Linux-erofs" <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>

Use new APIs to dynamically allocate the gfs2-glock shrinker.

Signed-off-by: Qi Zheng <zhengqi.arch@bytedance.com>
---
 fs/gfs2/glock.c | 20 +++++++++++---------
 1 file changed, 11 insertions(+), 9 deletions(-)

diff --git a/fs/gfs2/glock.c b/fs/gfs2/glock.c
index 1438e7465e30..77da354667d9 100644
--- a/fs/gfs2/glock.c
+++ b/fs/gfs2/glock.c
@@ -2046,11 +2046,7 @@ static unsigned long gfs2_glock_shrink_count(struct shrinker *shrink,
 	return vfs_pressure_ratio(atomic_read(&lru_count));
 }
 
-static struct shrinker glock_shrinker = {
-	.seeks = DEFAULT_SEEKS,
-	.count_objects = gfs2_glock_shrink_count,
-	.scan_objects = gfs2_glock_shrink_scan,
-};
+static struct shrinker *glock_shrinker;
 
 /**
  * glock_hash_walk - Call a function for glock in a hash bucket
@@ -2472,13 +2468,19 @@ int __init gfs2_glock_init(void)
 		return -ENOMEM;
 	}
 
-	ret = register_shrinker(&glock_shrinker, "gfs2-glock");
-	if (ret) {
+	glock_shrinker = shrinker_alloc(0, "gfs2-glock");
+	if (!glock_shrinker) {
 		destroy_workqueue(glock_workqueue);
 		rhashtable_destroy(&gl_hash_table);
-		return ret;
+		return -ENOMEM;
 	}
 
+	glock_shrinker->count_objects = gfs2_glock_shrink_count;
+	glock_shrinker->scan_objects = gfs2_glock_shrink_scan;
+	glock_shrinker->seeks = DEFAULT_SEEKS;
+
+	shrinker_register(glock_shrinker);
+
 	for (i = 0; i < GLOCK_WAIT_TABLE_SIZE; i++)
 		init_waitqueue_head(glock_wait_table + i);
 
@@ -2487,7 +2489,7 @@ int __init gfs2_glock_init(void)
 
 void gfs2_glock_exit(void)
 {
-	unregister_shrinker(&glock_shrinker);
+	shrinker_unregister(glock_shrinker);
 	rhashtable_destroy(&gl_hash_table);
 	destroy_workqueue(glock_workqueue);
 }
-- 
2.30.2

