Return-Path: <linux-erofs+bounces-217-lists+linux-erofs=lfdr.de@lists.ozlabs.org>
X-Original-To: lists+linux-erofs@lfdr.de
Delivered-To: lists+linux-erofs@lfdr.de
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	by mail.lfdr.de (Postfix) with ESMTPS id 3B89CA97ECE
	for <lists+linux-erofs@lfdr.de>; Wed, 23 Apr 2025 08:10:39 +0200 (CEST)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4Zj7y21q9pz2yKr;
	Wed, 23 Apr 2025 16:10:34 +1000 (AEST)
X-Original-To: linux-erofs@lists.ozlabs.org
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip="2607:f8b0:4864:20::54a"
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1745388634;
	cv=none; b=QRf6l5b1pL1HRfRiCrLmX6odK6jhajFRcvxpgpi9M7V4v4boJv/Yo+FXF80hhvTHk0/smEw/odYLs//iKC5UTrD33drvj3MTDWX0crCJzdG3WEYyXm+e4CYIm5Bk5UgtmpBJK4HU+bq63eHePE0bcrAWmxE4AXB0vTI/ArItDuFr+mIAv59Z4XMR/Ixv4sUHKuPWReTo8tgvzQ9t9oh6fmdsmN8qyX33x6cQlf9emvcp5LnfOTRHhFiQAzt1V3lwCmGXzDKL/RzGHAc6WHqJFvMtnPly/SI2O/ht3NVRxYq4TODBr9KhtfMsJS2ImgI8pHZ8ADoED+LPSIxe579elQ==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1745388634; c=relaxed/relaxed;
	bh=1efO1jpxBkR5cfyumCuhwJzAxqy4mFoXfnTTvHZB6UQ=;
	h=Date:Mime-Version:Message-ID:Subject:From:To:Cc:Content-Type; b=MtR6ivrfI1p9lxZvxxVGtRqx/T1Fbh0R0X8mM6R/SV3XcfHlpo24yEJsfQZsptMoCuNOBdcwS8yu6/sIehDgZKiXuRPKn6oD8QuDP5GGD8Fjq8jehLYFKZ12g6MzABP/68mLX6VpJMf8TAy2oeqCLe31Z73/5dhPENHiv65zhtJCpKTFp4fPOQTzy0QSSK5OBXWD2U1kTBMHUs00qefTgZr7yHTNryGnXeGs+K4riNDK4YU6ljHwf3GreqLV2pvIkryTa8hjPSHm8DfwiULrFpUTSHvhxFjJXxIxGq84uTLbcgSoC7OZRjgA2PjS9eEweGk9mOLJlrIjAb0EofAD2g==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=reject dis=none) header.from=google.com; dkim=pass (2048-bit key; unprotected) header.d=google.com header.i=@google.com header.a=rsa-sha256 header.s=20230601 header.b=QixHGnvT; dkim-atps=neutral; spf=pass (client-ip=2607:f8b0:4864:20::54a; helo=mail-pg1-x54a.google.com; envelope-from=3viqiaackc8uosl6lwprzzrwp.nzxwty58-p2zq3wt343.zawlm3.z2r@flex--dhavale.bounces.google.com; receiver=lists.ozlabs.org) smtp.mailfrom=flex--dhavale.bounces.google.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=google.com header.i=@google.com header.a=rsa-sha256 header.s=20230601 header.b=QixHGnvT;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=flex--dhavale.bounces.google.com (client-ip=2607:f8b0:4864:20::54a; helo=mail-pg1-x54a.google.com; envelope-from=3viqiaackc8uosl6lwprzzrwp.nzxwty58-p2zq3wt343.zawlm3.z2r@flex--dhavale.bounces.google.com; receiver=lists.ozlabs.org)
Received: from mail-pg1-x54a.google.com (mail-pg1-x54a.google.com [IPv6:2607:f8b0:4864:20::54a])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4Zj7y067Sdz2yGf
	for <linux-erofs@lists.ozlabs.org>; Wed, 23 Apr 2025 16:10:32 +1000 (AEST)
Received: by mail-pg1-x54a.google.com with SMTP id 41be03b00d2f7-b115fb801bcso2859060a12.3
        for <linux-erofs@lists.ozlabs.org>; Tue, 22 Apr 2025 23:10:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1745388629; x=1745993429; darn=lists.ozlabs.org;
        h=cc:to:from:subject:message-id:mime-version:date:from:to:cc:subject
         :date:message-id:reply-to;
        bh=1efO1jpxBkR5cfyumCuhwJzAxqy4mFoXfnTTvHZB6UQ=;
        b=QixHGnvTOxAl0bMnwtfqM6YVVi2mM28y08TDGiC4JLud5pVAegSa6krunlyuX3CshI
         CjrLumr7EVdVI4MK+xuZFKWzK73NIaFhYNc2UTDr+iMV9cMffaEIxkapt8fHlKyW9o6W
         BJOLY+NV23PkKNj5N7QwJAVOqieeCKXCY81Z8baXuniWkL75bdqe0jNDNqbg5CEMTIFV
         sO0xCnWM5ARG/k78I8b4kfwE2FAVZeUWeRmly+7uq4FAwGVGMb1G6rAdcagQC7fclyfP
         XYh3SVe66ZZxCghfxlJciEnYVjsNAbv4KyufARSj4X+EsT1p/BtioskNTkBt6jx3139e
         ec7g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1745388629; x=1745993429;
        h=cc:to:from:subject:message-id:mime-version:date:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=1efO1jpxBkR5cfyumCuhwJzAxqy4mFoXfnTTvHZB6UQ=;
        b=YnqPbMlctsB5t0xjKKvNcHqZwq0v7htNIayqwTpGmO8lV1M/tfZR5z5zBcB0zdWvR8
         VcG/tEw4Nax+7+HbctbVBFY0eKxguYDWAjHFIu1FVnkutRKqcxZL2qwOmEHdb84ajI05
         B7ZxI2bnRx9DSyWOMY1wXzbyG/NKwyIKkpG8CfhHInlt5iVfd493PF6ya6h8rtpPOqMr
         CeGKBW4ybtNHYK42dxUJsjz4wZX6GNzzZyeWeb7R1q9PtC39qcbozNfE18pVjaUXz9VQ
         RLiW/cTDlHeWFrmV+HuQ8AUa7vG3Mw8JWKh2F01wm2pTVM+/dZvdgXH6G1H7buoDAFMU
         SUbg==
X-Gm-Message-State: AOJu0Yw7+PBuQK5FXFUn71DEwKOeg0Id4xzlIRmWCnKZ88h9e5lQTWww
	rjdKxQ0euFAXSsYg3eoEOE5R37DnoB+okfbKFyC7uBVkV9h3yQ0OSHEbb9ODx1cS212/7lDXM7g
	bl7Sl1iFGa3bctF08VnVn4Z42eqcUb7qreDq19/FmRjvt52TGn7uEMegZMjXyu8MMLwiTYN97wr
	aYl4nOkc6XEavSSNYaVq6S0H1A0lPMvLejGNYgOUIiP6ZvYg==
X-Google-Smtp-Source: AGHT+IEzKaRCFUgt9qizCVhIYTkdVYONdfcIk3A5M/eXiNVkCRLgzBfUAzVE+CS+TyKYi3EZjV/34Sq+4T6u
X-Received: from pgbdn8.prod.google.com ([2002:a05:6a02:e08:b0:b0b:2032:ef98])
 (user=dhavale job=prod-delivery.src-stubby-dispatcher) by 2002:a05:6a20:6f03:b0:1f5:80a3:b008
 with SMTP id adf61e73a8af0-203cbcd6e19mr32803263637.32.1745388628715; Tue, 22
 Apr 2025 23:10:28 -0700 (PDT)
Date: Tue, 22 Apr 2025 23:10:21 -0700
X-Mailing-List: linux-erofs@lists.ozlabs.org
List-Id: <linux-erofs.lists.ozlabs.org>
List-Help: <mailto:linux-erofs+help@lists.ozlabs.org>
List-Owner: <mailto:linux-erofs+owner@lists.ozlabs.org>
List-Post: <mailto:linux-erofs@lists.ozlabs.org>
List-Subscribe: <mailto:linux-erofs+subscribe@lists.ozlabs.org>,
  <mailto:linux-erofs+subscribe-digest@lists.ozlabs.org>,
  <mailto:linux-erofs+subscribe-nomail@lists.ozlabs.org>
List-Unsubscribe: <mailto:linux-erofs+unsubscribe@lists.ozlabs.org>
Mime-Version: 1.0
X-Mailer: git-send-email 2.49.0.805.g082f7c87e0-goog
Message-ID: <20250423061023.131354-1-dhavale@google.com>
Subject: [PATCH v4] erofs: lazily initialize per-CPU workers and CPU hotplug hooks
From: Sandeep Dhavale <dhavale@google.com>
To: linux-erofs@lists.ozlabs.org, Gao Xiang <xiang@kernel.org>, 
	Chao Yu <chao@kernel.org>, Yue Hu <zbestahu@gmail.com>, 
	Jeffle Xu <jefflexu@linux.alibaba.com>, Sandeep Dhavale <dhavale@google.com>
Cc: hsiangkao@linux.alibaba.com, kernel-team@android.com, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-8.6 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
	USER_IN_DEF_DKIM_WL autolearn=disabled version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-25) on lists.ozlabs.org

Currently, when EROFS is built with per-CPU workers, the workers are
started and CPU hotplug hooks are registered during module initialization.
This leads to unnecessary worker start/stop cycles during CPU hotplug
events, particularly on Android devices that frequently suspend and resume.

This change defers the initialization of per-CPU workers and the
registration of CPU hotplug hooks until the first EROFS mount. This
ensures that these resources are only allocated and managed when EROFS is
actually in use.

The tear down of per-CPU workers and unregistration of CPU hotplug hooks
still occurs during z_erofs_exit_subsystem(), but only if they were
initialized.

Signed-off-by: Sandeep Dhavale <dhavale@google.com>
---
v3: https://lore.kernel.org/linux-erofs/20250422234546.2932092-1-dhavale@google.com/
Changes since v3:
- fold z_erofs_init_pcpu_workers() in the caller and rename the caller

 fs/erofs/zdata.c | 61 +++++++++++++++++++++++++++++++++++-------------
 1 file changed, 45 insertions(+), 16 deletions(-)

diff --git a/fs/erofs/zdata.c b/fs/erofs/zdata.c
index 0671184d9cf1..647a8340c9a1 100644
--- a/fs/erofs/zdata.c
+++ b/fs/erofs/zdata.c
@@ -291,6 +291,9 @@ static struct workqueue_struct *z_erofs_workqueue __read_mostly;
 
 #ifdef CONFIG_EROFS_FS_PCPU_KTHREAD
 static struct kthread_worker __rcu **z_erofs_pcpu_workers;
+static atomic_t erofs_percpu_workers_initialized = ATOMIC_INIT(0);
+static int erofs_cpu_hotplug_init(void);
+static void erofs_cpu_hotplug_destroy(void);
 
 static void erofs_destroy_percpu_workers(void)
 {
@@ -336,9 +339,40 @@ static int erofs_init_percpu_workers(void)
 	}
 	return 0;
 }
+
+static int z_erofs_init_pcpu_workers(void)
+{
+	int err;
+
+	if (atomic_xchg(&erofs_percpu_workers_initialized, 1))
+		return 0;
+
+	err = erofs_init_percpu_workers();
+	if (err)
+		goto err_init_percpu_workers;
+
+	err = erofs_cpu_hotplug_init();
+	if (err < 0)
+		goto err_cpuhp_init;
+	return err;
+
+err_cpuhp_init:
+	erofs_destroy_percpu_workers();
+err_init_percpu_workers:
+	atomic_set(&erofs_percpu_workers_initialized, 0);
+	return err;
+}
+
+static void z_erofs_destroy_pcpu_workers(void)
+{
+	if (!atomic_xchg(&erofs_percpu_workers_initialized, 0))
+		return;
+	erofs_cpu_hotplug_destroy();
+	erofs_destroy_percpu_workers();
+}
 #else
-static inline void erofs_destroy_percpu_workers(void) {}
-static inline int erofs_init_percpu_workers(void) { return 0; }
+static inline int z_erofs_init_pcpu_workers(void) { return 0; }
+static inline void z_erofs_destroy_pcpu_workers(void) {}
 #endif
 
 #if defined(CONFIG_HOTPLUG_CPU) && defined(CONFIG_EROFS_FS_PCPU_KTHREAD)
@@ -405,8 +439,7 @@ static inline void erofs_cpu_hotplug_destroy(void) {}
 
 void z_erofs_exit_subsystem(void)
 {
-	erofs_cpu_hotplug_destroy();
-	erofs_destroy_percpu_workers();
+	z_erofs_destroy_pcpu_workers();
 	destroy_workqueue(z_erofs_workqueue);
 	z_erofs_destroy_pcluster_pool();
 	z_erofs_exit_decompressor();
@@ -430,19 +463,8 @@ int __init z_erofs_init_subsystem(void)
 		goto err_workqueue_init;
 	}
 
-	err = erofs_init_percpu_workers();
-	if (err)
-		goto err_pcpu_worker;
-
-	err = erofs_cpu_hotplug_init();
-	if (err < 0)
-		goto err_cpuhp_init;
 	return err;
 
-err_cpuhp_init:
-	erofs_destroy_percpu_workers();
-err_pcpu_worker:
-	destroy_workqueue(z_erofs_workqueue);
 err_workqueue_init:
 	z_erofs_destroy_pcluster_pool();
 err_pcluster_pool:
@@ -644,10 +666,17 @@ static const struct address_space_operations z_erofs_cache_aops = {
 
 int z_erofs_init_super(struct super_block *sb)
 {
-	struct inode *const inode = new_inode(sb);
+	struct inode *inode;
+	int err;
 
+	err = z_erofs_init_pcpu_workers();
+	if (err)
+		return err;
+
+	inode = new_inode(sb);
 	if (!inode)
 		return -ENOMEM;
+
 	set_nlink(inode, 1);
 	inode->i_size = OFFSET_MAX;
 	inode->i_mapping->a_ops = &z_erofs_cache_aops;
-- 
2.49.0.805.g082f7c87e0-goog


