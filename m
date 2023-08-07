Return-Path: <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>
X-Original-To: lists+linux-erofs@lfdr.de
Delivered-To: lists+linux-erofs@lfdr.de
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2404:9400:2:0:216:3eff:fee1:b9f1])
	by mail.lfdr.de (Postfix) with ESMTPS id F310C772006
	for <lists+linux-erofs@lfdr.de>; Mon,  7 Aug 2023 13:13:31 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=lists.ozlabs.org;
	s=201707; t=1691406809;
	bh=4VJlLpDqVGiuvI83ez+3bl7yR5bVuWalBgtTU2vfBLE=;
	h=To:Subject:Date:In-Reply-To:References:List-Id:List-Unsubscribe:
	 List-Archive:List-Post:List-Help:List-Subscribe:From:Reply-To:Cc:
	 From;
	b=ZoZEsdNpmQbsUgdcySW+AICpCWpowd7bhjceLLzX+cGOpMS0PYbWURU+8TL2dzNF8
	 me0g/ctVdMQd4km9JH0ZYTtfy8wcgrbZ0Apr9K3wDn8cekzr07Xo9nmBTfvJ8UQ7Io
	 vtVdHBUCLo8f/2ttK1XMHGSBBdTduYhi8184haVhJnf9MFl1yqxWfZ4xzQios3m/S4
	 l9llA0AFn18rfJJedsv2sYXzZvsI1vxFFn2Cv2fMz2xZ+fT3bRcYe9+JdINj2IWguT
	 7+N2bSnu4AbkS38V3MtVt4vgGBbTNadIbAWRjtMshqTOUCm5GFpYrRmW/xSVDQgRwL
	 d+sRMeQ8U3+tA==
Received: from boromir.ozlabs.org (localhost [IPv6:::1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4RKDG15hrSz2yhT
	for <lists+linux-erofs@lfdr.de>; Mon,  7 Aug 2023 21:13:29 +1000 (AEST)
X-Original-To: linux-erofs@lists.ozlabs.org
Delivered-To: linux-erofs@lists.ozlabs.org
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=bytedance.com header.i=@bytedance.com header.a=rsa-sha256 header.s=google header.b=i2oZ2Se5;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=bytedance.com (client-ip=2607:f8b0:4864:20::d32; helo=mail-io1-xd32.google.com; envelope-from=zhengqi.arch@bytedance.com; receiver=lists.ozlabs.org)
Received: from mail-io1-xd32.google.com (mail-io1-xd32.google.com [IPv6:2607:f8b0:4864:20::d32])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4RKDFy5G72z2yGB
	for <linux-erofs@lists.ozlabs.org>; Mon,  7 Aug 2023 21:13:26 +1000 (AEST)
Received: by mail-io1-xd32.google.com with SMTP id ca18e2360f4ac-790b6761117so45037439f.0
        for <linux-erofs@lists.ozlabs.org>; Mon, 07 Aug 2023 04:13:26 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1691406804; x=1692011604;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=4VJlLpDqVGiuvI83ez+3bl7yR5bVuWalBgtTU2vfBLE=;
        b=FxWHdOWuubBe4Bwj6VuyUtbEzzM6T9sOGCPH7aItZ3ffA/9I2yw0HdNcRs3gCN1c9c
         0Z6gm7J6CJ46DJKEaQMmP21zrjXr1Kgterk6zCV5BhACerMLTEmU8uv60qA15VAO0Pt+
         HuYvf6MBCsQTZlgUWG5QSulebWiXkghsd8HDhmwjUnB5aMDnoncat8U1k6Z5jc1wKCbc
         Q6PCFH+vu+wLq5G4HzyPLfWh5swuSWJ7yWXHTOj7W9qEzlOSaCRr2VCF1uDX8IJ5/slT
         qrbLI5zLlQ7tHI8+A4/0kO9+T+PvDf1krttf5IkM+cxgT1CyP94jabKeBsaZHX3f0Gkb
         Z/9A==
X-Gm-Message-State: ABy/qLYvkpaSURXi9hqL+oPZBsi5BjjJ6GRxr+TkOZ2KYi7bKVDE/aUt
	sYomH3FB5aFE7dMPNxV0Savt4A==
X-Google-Smtp-Source: APBJJlG6KxjpSP18cuDMGPLwCal+2Q6XOYkRmOlR+93TSEU+QOz0TNU1VRvfHZPrdEq648UTFq+gsw==
X-Received: by 2002:a92:d944:0:b0:349:3c78:fd14 with SMTP id l4-20020a92d944000000b003493c78fd14mr13499018ilq.1.1691406803912;
        Mon, 07 Aug 2023 04:13:23 -0700 (PDT)
Received: from C02DW0BEMD6R.bytedance.net ([203.208.167.146])
        by smtp.gmail.com with ESMTPSA id y13-20020a17090aca8d00b0025be7b69d73sm5861191pjt.12.2023.08.07.04.13.11
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 07 Aug 2023 04:13:23 -0700 (PDT)
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
	muchun.song@linux.dev,
	simon.horman@corigine.com,
	dlemoal@kernel.org
Subject: [PATCH v4 16/48] quota: dynamically allocate the dquota-cache shrinker
Date: Mon,  7 Aug 2023 19:09:04 +0800
Message-Id: <20230807110936.21819-17-zhengqi.arch@bytedance.com>
X-Mailer: git-send-email 2.24.3 (Apple Git-128)
In-Reply-To: <20230807110936.21819-1-zhengqi.arch@bytedance.com>
References: <20230807110936.21819-1-zhengqi.arch@bytedance.com>
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

Use new APIs to dynamically allocate the dquota-cache shrinker.

Signed-off-by: Qi Zheng <zhengqi.arch@bytedance.com>
Reviewed-by: Muchun Song <songmuchun@bytedance.com>
---
 fs/quota/dquot.c | 18 ++++++++++--------
 1 file changed, 10 insertions(+), 8 deletions(-)

diff --git a/fs/quota/dquot.c b/fs/quota/dquot.c
index 9e72bfe8bbad..c303cffdf433 100644
--- a/fs/quota/dquot.c
+++ b/fs/quota/dquot.c
@@ -791,12 +791,6 @@ dqcache_shrink_count(struct shrinker *shrink, struct shrink_control *sc)
 	percpu_counter_read_positive(&dqstats.counter[DQST_FREE_DQUOTS]));
 }
 
-static struct shrinker dqcache_shrinker = {
-	.count_objects = dqcache_shrink_count,
-	.scan_objects = dqcache_shrink_scan,
-	.seeks = DEFAULT_SEEKS,
-};
-
 /*
  * Safely release dquot and put reference to dquot.
  */
@@ -2956,6 +2950,7 @@ static int __init dquot_init(void)
 {
 	int i, ret;
 	unsigned long nr_hash, order;
+	struct shrinker *dqcache_shrinker;
 
 	printk(KERN_NOTICE "VFS: Disk quotas %s\n", __DQUOT_VERSION__);
 
@@ -2990,8 +2985,15 @@ static int __init dquot_init(void)
 	pr_info("VFS: Dquot-cache hash table entries: %ld (order %ld,"
 		" %ld bytes)\n", nr_hash, order, (PAGE_SIZE << order));
 
-	if (register_shrinker(&dqcache_shrinker, "dquota-cache"))
-		panic("Cannot register dquot shrinker");
+	dqcache_shrinker = shrinker_alloc(0, "dquota-cache");
+	if (!dqcache_shrinker)
+		panic("Cannot allocate dquot shrinker");
+
+	dqcache_shrinker->count_objects = dqcache_shrink_count;
+	dqcache_shrinker->scan_objects = dqcache_shrink_scan;
+	dqcache_shrinker->seeks = DEFAULT_SEEKS;
+
+	shrinker_register(dqcache_shrinker);
 
 	return 0;
 }
-- 
2.30.2

