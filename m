Return-Path: <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>
X-Original-To: lists+linux-erofs@lfdr.de
Delivered-To: lists+linux-erofs@lfdr.de
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2404:9400:2:0:216:3eff:fee1:b9f1])
	by mail.lfdr.de (Postfix) with ESMTPS id 5992275EFAF
	for <lists+linux-erofs@lfdr.de>; Mon, 24 Jul 2023 11:47:02 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=lists.ozlabs.org;
	s=201707; t=1690192020;
	bh=hKcV3vb4MClJJQ+mNTta07ndMYtKKP0SAkTwCVeOX0w=;
	h=To:Subject:Date:In-Reply-To:References:List-Id:List-Unsubscribe:
	 List-Archive:List-Post:List-Help:List-Subscribe:From:Reply-To:Cc:
	 From;
	b=POSyHnVSZCBJdvbNZx35ILrqt7qPCw0eTExD8b179gKofEtCewJEl7ai0F0I9xhNC
	 OPJQh6bvQOcSlwYl8s10yvm3FTIGTfemcGfvG8ki6mIVuTNL2HRj35DgzlI22HNFdc
	 9iroN2Axg8boKReRu91wllKeiDEIH9wi01hRSvMOZNB5dbY8DSOBEuQYvmrNELnl1h
	 0Ulp4GvH55mO8kOHlwEqXjVIPcVWNNNlpI2Yi5ehW7PfnZ/HXQmFYF0Wb2uXiDi4HF
	 lr4pWxvq6jo53balxDP5y4PnNnsxJNPOgKfRU+LZ5ysKOf3g/b0DvrHGHhfM1y3zlI
	 x5d4HKjh5onhQ==
Received: from boromir.ozlabs.org (localhost [IPv6:::1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4R8b0h1tTRz2yth
	for <lists+linux-erofs@lfdr.de>; Mon, 24 Jul 2023 19:47:00 +1000 (AEST)
X-Original-To: linux-erofs@lists.ozlabs.org
Delivered-To: linux-erofs@lists.ozlabs.org
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=bytedance.com header.i=@bytedance.com header.a=rsa-sha256 header.s=google header.b=a7lFhyKp;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=bytedance.com (client-ip=2607:f8b0:4864:20::630; helo=mail-pl1-x630.google.com; envelope-from=zhengqi.arch@bytedance.com; receiver=lists.ozlabs.org)
Received: from mail-pl1-x630.google.com (mail-pl1-x630.google.com [IPv6:2607:f8b0:4864:20::630])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4R8b0f0ZyJz2yhS
	for <linux-erofs@lists.ozlabs.org>; Mon, 24 Jul 2023 19:46:57 +1000 (AEST)
Received: by mail-pl1-x630.google.com with SMTP id d9443c01a7336-1b8c364ad3bso8857565ad.1
        for <linux-erofs@lists.ozlabs.org>; Mon, 24 Jul 2023 02:46:57 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1690192015; x=1690796815;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=hKcV3vb4MClJJQ+mNTta07ndMYtKKP0SAkTwCVeOX0w=;
        b=P7bb+MC3PdrFDB3af/4ElE5WXxdAXr1okr01e0sjYVy+yNsqWQujXyNrNs3rmAFZpp
         J3W1+rKyznYBaNcaywlPdHW/h7YTB9zboLU0pHAqFrf33t1Po0w5KCXWquwAQabh00tZ
         DhqSIC1kTdOQ6f9+j/uvDxnQzdNmcpI8VNIFoqmDIR0AhsJ9q/jttTngRe370XHoMtEl
         K6AccaH2LK0/o9alWNXXvRuFUKBrOBC3HbgCFpH2NCtkxg1cOhfsp4mcQ5xtWhxfgGSb
         yOg9xkpR8fw7Pc0YWWKZH5Kx6Rw8gORyvhnfDFFMUlCUsnxnHKsQF1oTeMQhV39Luyrg
         ndPw==
X-Gm-Message-State: ABy/qLYFHt6TFPnVkOL5nCeg8rudg0Iai8XyecY2q0K7M1Y3RaAn3EAh
	PveJ/G+sbcC4A1WDWH1X8ieh4g==
X-Google-Smtp-Source: APBJJlFJGAUudAfwbE4FzEeIId9jY33sdTrNWRyhFQwrzl0Tx9fNVh9CNxBzY73cH6rP3yfMJCnueA==
X-Received: by 2002:a17:902:dace:b0:1b8:811:b079 with SMTP id q14-20020a170902dace00b001b80811b079mr12305026plx.0.1690192015077;
        Mon, 24 Jul 2023 02:46:55 -0700 (PDT)
Received: from C02DW0BEMD6R.bytedance.net ([203.208.167.147])
        by smtp.gmail.com with ESMTPSA id d5-20020a170902c18500b001bb20380bf2sm8467233pld.13.2023.07.24.02.46.42
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 24 Jul 2023 02:46:54 -0700 (PDT)
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
Subject: [PATCH v2 09/47] f2fs: dynamically allocate the f2fs-shrinker
Date: Mon, 24 Jul 2023 17:43:16 +0800
Message-Id: <20230724094354.90817-10-zhengqi.arch@bytedance.com>
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

Use new APIs to dynamically allocate the f2fs-shrinker.

Signed-off-by: Qi Zheng <zhengqi.arch@bytedance.com>
---
 fs/f2fs/super.c | 32 ++++++++++++++++++++++++--------
 1 file changed, 24 insertions(+), 8 deletions(-)

diff --git a/fs/f2fs/super.c b/fs/f2fs/super.c
index ca31163da00a..8b08473db358 100644
--- a/fs/f2fs/super.c
+++ b/fs/f2fs/super.c
@@ -83,11 +83,27 @@ void f2fs_build_fault_attr(struct f2fs_sb_info *sbi, unsigned int rate,
 #endif
 
 /* f2fs-wide shrinker description */
-static struct shrinker f2fs_shrinker_info = {
-	.scan_objects = f2fs_shrink_scan,
-	.count_objects = f2fs_shrink_count,
-	.seeks = DEFAULT_SEEKS,
-};
+static struct shrinker *f2fs_shrinker_info;
+
+static int f2fs_init_shrinker(void)
+{
+	f2fs_shrinker_info = shrinker_alloc(0, "f2fs-shrinker");
+	if (!f2fs_shrinker_info)
+		return -ENOMEM;
+
+	f2fs_shrinker_info->count_objects = f2fs_shrink_count;
+	f2fs_shrinker_info->scan_objects = f2fs_shrink_scan;
+	f2fs_shrinker_info->seeks = DEFAULT_SEEKS;
+
+	shrinker_register(f2fs_shrinker_info);
+
+	return 0;
+}
+
+static void f2fs_exit_shrinker(void)
+{
+	shrinker_unregister(f2fs_shrinker_info);
+}
 
 enum {
 	Opt_gc_background,
@@ -4941,7 +4957,7 @@ static int __init init_f2fs_fs(void)
 	err = f2fs_init_sysfs();
 	if (err)
 		goto free_garbage_collection_cache;
-	err = register_shrinker(&f2fs_shrinker_info, "f2fs-shrinker");
+	err = f2fs_init_shrinker();
 	if (err)
 		goto free_sysfs;
 	err = register_filesystem(&f2fs_fs_type);
@@ -4986,7 +5002,7 @@ static int __init init_f2fs_fs(void)
 	f2fs_destroy_root_stats();
 	unregister_filesystem(&f2fs_fs_type);
 free_shrinker:
-	unregister_shrinker(&f2fs_shrinker_info);
+	f2fs_exit_shrinker();
 free_sysfs:
 	f2fs_exit_sysfs();
 free_garbage_collection_cache:
@@ -5018,7 +5034,7 @@ static void __exit exit_f2fs_fs(void)
 	f2fs_destroy_post_read_processing();
 	f2fs_destroy_root_stats();
 	unregister_filesystem(&f2fs_fs_type);
-	unregister_shrinker(&f2fs_shrinker_info);
+	f2fs_exit_shrinker();
 	f2fs_exit_sysfs();
 	f2fs_destroy_garbage_collection_cache();
 	f2fs_destroy_extent_cache();
-- 
2.30.2

