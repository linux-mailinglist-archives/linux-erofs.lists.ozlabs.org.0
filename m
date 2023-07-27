Return-Path: <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>
X-Original-To: lists+linux-erofs@lfdr.de
Delivered-To: lists+linux-erofs@lfdr.de
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	by mail.lfdr.de (Postfix) with ESMTPS id 2678A764A37
	for <lists+linux-erofs@lfdr.de>; Thu, 27 Jul 2023 10:07:47 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=lists.ozlabs.org;
	s=201707; t=1690445265;
	bh=bO4yc6b0222dRNj48HoFyPuU9QjRVolFKKVhhMGpLKw=;
	h=To:Subject:Date:In-Reply-To:References:List-Id:List-Unsubscribe:
	 List-Archive:List-Post:List-Help:List-Subscribe:From:Reply-To:Cc:
	 From;
	b=OvddN40btnfnHuoYyWnFQ0pho2npwlDlM7zIv74t3OAj+C5yApjWkd4liownu09QH
	 FCmAhAzxZDu4FeNqAC7GWyXeVM3x4eLSeBhU6/Lt3lQpecYZ2lS0oDJiu7mFUCF6hQ
	 WvMCkMXW+qkmMGWtodwYuNMxUkLeRtHpOgAIAaPttLKH4iX70G5NXOQHcdobeD+W56
	 F4s3JmHqnW341WIJMGP77qlj+XF32fxoGbK9oZ0k1XRtSX38v6Bh09OPLl2fegAZsp
	 eM30uHjHgSzcSEfqDwvzHlTgOp70lK2/0xwPFfOY59uOqtoZKRpXlZZmA8K1bW8iFH
	 o779Bj/aDl67Q==
Received: from boromir.ozlabs.org (localhost [IPv6:::1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4RBNfn0R9sz3cTm
	for <lists+linux-erofs@lfdr.de>; Thu, 27 Jul 2023 18:07:45 +1000 (AEST)
X-Original-To: linux-erofs@lists.ozlabs.org
Delivered-To: linux-erofs@lists.ozlabs.org
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=bytedance.com header.i=@bytedance.com header.a=rsa-sha256 header.s=google header.b=OaYrF17g;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=bytedance.com (client-ip=2607:f8b0:4864:20::42d; helo=mail-pf1-x42d.google.com; envelope-from=zhengqi.arch@bytedance.com; receiver=lists.ozlabs.org)
Received: from mail-pf1-x42d.google.com (mail-pf1-x42d.google.com [IPv6:2607:f8b0:4864:20::42d])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4RBNfj47r1z3cGx
	for <linux-erofs@lists.ozlabs.org>; Thu, 27 Jul 2023 18:07:41 +1000 (AEST)
Received: by mail-pf1-x42d.google.com with SMTP id d2e1a72fcca58-682ae5d4184so170627b3a.1
        for <linux-erofs@lists.ozlabs.org>; Thu, 27 Jul 2023 01:07:41 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1690445260; x=1691050060;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=bO4yc6b0222dRNj48HoFyPuU9QjRVolFKKVhhMGpLKw=;
        b=OPPYdNDf4yZHb9yoeCS95OzyvktpdTc1453FBI/FFJF5Td0GJY+7ZEb7lWgRtSLmxC
         0ry/7KCPthyNw1sALSkr4b0/BxG5RLoI33jj19RioYUl6YXSSURKUxiK7nELPbR1nYnu
         UxEMMWi85JdvFjt02w0qv2PO5NilqQz5svkxaz8cVKQ5DH8+LRGu7J6gY6oqltYETcvk
         +dRj3yms9l7x/EUWOXiMnB0AGE/SElFhQvct3imjeyzHPinJpdJYZRxu87/1COYcITrl
         73uBrOI8x8g4Dx1i3aSG/2OYwQ9uYOL/bYVcpneHBgY42MtN4mxaoec7zvlW0e9myFIx
         xuiw==
X-Gm-Message-State: ABy/qLZgqZztKiNVIw8PWeTocKDKQXZHQrPdhKWki/RkyfVMGKM7VLgu
	eSjnKZJz0AjKjRYItWOlit2BUw==
X-Google-Smtp-Source: APBJJlEtjuu7JvMViG/zI1+BRK6QgnXajX34xFKdSMMqB1WswZOW9mIhLIlLvIrLtx031P4ulw5hGg==
X-Received: by 2002:a05:6a20:9381:b0:137:8f19:1de7 with SMTP id x1-20020a056a20938100b001378f191de7mr6160325pzh.0.1690445259706;
        Thu, 27 Jul 2023 01:07:39 -0700 (PDT)
Received: from C02DW0BEMD6R.bytedance.net ([203.208.167.147])
        by smtp.gmail.com with ESMTPSA id j8-20020aa78d08000000b006828e49c04csm885872pfe.75.2023.07.27.01.07.26
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 27 Jul 2023 01:07:39 -0700 (PDT)
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
Subject: [PATCH v3 09/49] xenbus/backend: dynamically allocate the xen-backend shrinker
Date: Thu, 27 Jul 2023 16:04:22 +0800
Message-Id: <20230727080502.77895-10-zhengqi.arch@bytedance.com>
X-Mailer: git-send-email 2.24.3 (Apple Git-128)
In-Reply-To: <20230727080502.77895-1-zhengqi.arch@bytedance.com>
References: <20230727080502.77895-1-zhengqi.arch@bytedance.com>
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
Cc: kvm@vger.kernel.org, dri-devel@lists.freedesktop.org, virtualization@lists.linux-foundation.org, linux-mm@kvack.org, dm-devel@redhat.com, linux-mtd@lists.infradead.org, x86@kernel.org, cluster-devel@redhat.com, xen-devel@lists.xenproject.org, linux-ext4@vger.kernel.org, linux-arm-msm@vger.kernel.org, rcu@vger.kernel.org, linux-bcache@vger.kernel.org, Qi Zheng <zhengqi.arch@bytedance.com>, Muchun Song <songmuchun@bytedance.com>, linux-raid@vger.kernel.org, linux-nfs@vger.kernel.org, netdev@vger.kernel.org, linux-kernel@vger.kernel.org, linux-f2fs-devel@lists.sourceforge.net, linux-xfs@vger.kernel.org, linux-fsdevel@vger.kernel.org, linux-erofs@lists.ozlabs.org, linux-btrfs@vger.kernel.org
Errors-To: linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org
Sender: "Linux-erofs" <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>

Use new APIs to dynamically allocate the xen-backend shrinker.

Signed-off-by: Qi Zheng <zhengqi.arch@bytedance.com>
Reviewed-by: Muchun Song <songmuchun@bytedance.com>
---
 drivers/xen/xenbus/xenbus_probe_backend.c | 18 +++++++++++-------
 1 file changed, 11 insertions(+), 7 deletions(-)

diff --git a/drivers/xen/xenbus/xenbus_probe_backend.c b/drivers/xen/xenbus/xenbus_probe_backend.c
index da96c260e26b..929c41a5ccee 100644
--- a/drivers/xen/xenbus/xenbus_probe_backend.c
+++ b/drivers/xen/xenbus/xenbus_probe_backend.c
@@ -284,13 +284,9 @@ static unsigned long backend_shrink_memory_count(struct shrinker *shrinker,
 	return 0;
 }
 
-static struct shrinker backend_memory_shrinker = {
-	.count_objects = backend_shrink_memory_count,
-	.seeks = DEFAULT_SEEKS,
-};
-
 static int __init xenbus_probe_backend_init(void)
 {
+	struct shrinker *backend_memory_shrinker;
 	static struct notifier_block xenstore_notifier = {
 		.notifier_call = backend_probe_and_watch
 	};
@@ -305,8 +301,16 @@ static int __init xenbus_probe_backend_init(void)
 
 	register_xenstore_notifier(&xenstore_notifier);
 
-	if (register_shrinker(&backend_memory_shrinker, "xen-backend"))
-		pr_warn("shrinker registration failed\n");
+	backend_memory_shrinker = shrinker_alloc(0, "xen-backend");
+	if (!backend_memory_shrinker) {
+		pr_warn("shrinker allocation failed\n");
+		return 0;
+	}
+
+	backend_memory_shrinker->count_objects = backend_shrink_memory_count;
+	backend_memory_shrinker->seeks = DEFAULT_SEEKS;
+
+	shrinker_register(backend_memory_shrinker);
 
 	return 0;
 }
-- 
2.30.2

