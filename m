Return-Path: <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>
X-Original-To: lists+linux-erofs@lfdr.de
Delivered-To: lists+linux-erofs@lfdr.de
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	by mail.lfdr.de (Postfix) with ESMTPS id 74EF7764A62
	for <lists+linux-erofs@lfdr.de>; Thu, 27 Jul 2023 10:09:16 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=lists.ozlabs.org;
	s=201707; t=1690445354;
	bh=XxxR7cKF9GXj8MC2HKPXqv6o5/ypcgPst5/afOqmqdU=;
	h=To:Subject:Date:In-Reply-To:References:List-Id:List-Unsubscribe:
	 List-Archive:List-Post:List-Help:List-Subscribe:From:Reply-To:Cc:
	 From;
	b=Uhc0E2L1io7ViiXuRwHTUE94vKGj7nyGkNzVBNtk7Fv7lXkIpyh6FKHu/p1hCPAfu
	 0a9/KaWIvgWtYN+5nJhrUy1lNKUQ6xWTBRaxR4kYO4ip1W4KxamUlGVZp06pbuAU5G
	 gX3TDly9nd63vj1qaR/z+qdkLDTpWhsWSBhMLkoJCO7JUKRWRbQQ5wV6vF3cL8cGKZ
	 uiOPnEthLBYE6ffq5IxkBvrC0CZPGDZio9hKlh/ICv/QTIR6vSV4STSPbmKg35WkCq
	 fxo2XxiDLmvrc9mps1vr54iYjfF8313VW0YAlDfO22z1bLwmOeDyopTbj4m/JF6Cvn
	 CiR/Y519UfHuw==
Received: from boromir.ozlabs.org (localhost [IPv6:::1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4RBNhV2hb7z3d8t
	for <lists+linux-erofs@lfdr.de>; Thu, 27 Jul 2023 18:09:14 +1000 (AEST)
X-Original-To: linux-erofs@lists.ozlabs.org
Delivered-To: linux-erofs@lists.ozlabs.org
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=bytedance.com header.i=@bytedance.com header.a=rsa-sha256 header.s=google header.b=f78FOiI4;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=bytedance.com (client-ip=2607:f8b0:4864:20::434; helo=mail-pf1-x434.google.com; envelope-from=zhengqi.arch@bytedance.com; receiver=lists.ozlabs.org)
Received: from mail-pf1-x434.google.com (mail-pf1-x434.google.com [IPv6:2607:f8b0:4864:20::434])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4RBNhL5d8xz3d9K
	for <linux-erofs@lists.ozlabs.org>; Thu, 27 Jul 2023 18:09:06 +1000 (AEST)
Received: by mail-pf1-x434.google.com with SMTP id d2e1a72fcca58-682b1768a0bso174897b3a.0
        for <linux-erofs@lists.ozlabs.org>; Thu, 27 Jul 2023 01:09:06 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1690445345; x=1691050145;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=XxxR7cKF9GXj8MC2HKPXqv6o5/ypcgPst5/afOqmqdU=;
        b=j1+T7EBcUs17nXn7tD/ZILAQMf2hL8YWKkVCCJFcCpfNlZ5D63m1X5iB6sIA5liGIb
         a2Ua+9h3goNZsXsmuFhQsDJws1YR5Z2OZRnygS3VkaVR1kphSyjmENfnkCOhV8AK3Dme
         GI47hm1J0CfS4VHko0nKTklBOLq2YqhRpJx4PKapt96Sn7+CK1155ksfdTGlOCG+ec+b
         hrvBUQrJA6KcSqyXLkG7+C+AhKbYm6FIz/Jc2v2+M6VowZdj6pb1bLrd+uUcFywQJ1Xt
         LArMaoqpLgN8f0UkdsV6u02F6HucN/KfF8OX72nEscsWDO5gr2HIyjySzSCl/45CBI7S
         ztkQ==
X-Gm-Message-State: ABy/qLaFCL1qHWyG9mPRwdKhxQlBy/I57lmxnlU3JH9dSuKr3kSNQCIx
	YcdwZcx/vWFp5J+Bt8AmxXbAYA==
X-Google-Smtp-Source: APBJJlFoKDsbKkERIQGnm+LFaFeLpxhRzI1EaDrRxfTAKZLr632PKwn78Yey2tH1KRLEMSWua5HIxg==
X-Received: by 2002:a05:6a00:4a10:b0:686:b990:560f with SMTP id do16-20020a056a004a1000b00686b990560fmr4379620pfb.2.1690445344746;
        Thu, 27 Jul 2023 01:09:04 -0700 (PDT)
Received: from C02DW0BEMD6R.bytedance.net ([203.208.167.147])
        by smtp.gmail.com with ESMTPSA id j8-20020aa78d08000000b006828e49c04csm885872pfe.75.2023.07.27.01.08.53
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 27 Jul 2023 01:09:04 -0700 (PDT)
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
Subject: [PATCH v3 16/49] nfsd: dynamically allocate the nfsd-filecache shrinker
Date: Thu, 27 Jul 2023 16:04:29 +0800
Message-Id: <20230727080502.77895-17-zhengqi.arch@bytedance.com>
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

Use new APIs to dynamically allocate the nfsd-filecache shrinker.

Signed-off-by: Qi Zheng <zhengqi.arch@bytedance.com>
Reviewed-by: Muchun Song <songmuchun@bytedance.com>
---
 fs/nfsd/filecache.c | 22 ++++++++++++----------
 1 file changed, 12 insertions(+), 10 deletions(-)

diff --git a/fs/nfsd/filecache.c b/fs/nfsd/filecache.c
index ee9c923192e0..872eb9501965 100644
--- a/fs/nfsd/filecache.c
+++ b/fs/nfsd/filecache.c
@@ -521,11 +521,7 @@ nfsd_file_lru_scan(struct shrinker *s, struct shrink_control *sc)
 	return ret;
 }
 
-static struct shrinker	nfsd_file_shrinker = {
-	.scan_objects = nfsd_file_lru_scan,
-	.count_objects = nfsd_file_lru_count,
-	.seeks = 1,
-};
+static struct shrinker *nfsd_file_shrinker;
 
 /**
  * nfsd_file_cond_queue - conditionally unhash and queue a nfsd_file
@@ -746,12 +742,18 @@ nfsd_file_cache_init(void)
 		goto out_err;
 	}
 
-	ret = register_shrinker(&nfsd_file_shrinker, "nfsd-filecache");
-	if (ret) {
-		pr_err("nfsd: failed to register nfsd_file_shrinker: %d\n", ret);
+	nfsd_file_shrinker = shrinker_alloc(0, "nfsd-filecache");
+	if (!nfsd_file_shrinker) {
+		pr_err("nfsd: failed to allocate nfsd_file_shrinker\n");
 		goto out_lru;
 	}
 
+	nfsd_file_shrinker->count_objects = nfsd_file_lru_count;
+	nfsd_file_shrinker->scan_objects = nfsd_file_lru_scan;
+	nfsd_file_shrinker->seeks = 1;
+
+	shrinker_register(nfsd_file_shrinker);
+
 	ret = lease_register_notifier(&nfsd_file_lease_notifier);
 	if (ret) {
 		pr_err("nfsd: unable to register lease notifier: %d\n", ret);
@@ -774,7 +776,7 @@ nfsd_file_cache_init(void)
 out_notifier:
 	lease_unregister_notifier(&nfsd_file_lease_notifier);
 out_shrinker:
-	unregister_shrinker(&nfsd_file_shrinker);
+	shrinker_free(nfsd_file_shrinker);
 out_lru:
 	list_lru_destroy(&nfsd_file_lru);
 out_err:
@@ -891,7 +893,7 @@ nfsd_file_cache_shutdown(void)
 		return;
 
 	lease_unregister_notifier(&nfsd_file_lease_notifier);
-	unregister_shrinker(&nfsd_file_shrinker);
+	shrinker_free(nfsd_file_shrinker);
 	/*
 	 * make sure all callers of nfsd_file_lru_cb are done before
 	 * calling nfsd_file_cache_purge
-- 
2.30.2

