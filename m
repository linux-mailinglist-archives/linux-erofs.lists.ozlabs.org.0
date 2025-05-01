Return-Path: <linux-erofs+bounces-272-lists+linux-erofs=lfdr.de@lists.ozlabs.org>
X-Original-To: lists+linux-erofs@lfdr.de
Delivered-To: lists+linux-erofs@lfdr.de
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	by mail.lfdr.de (Postfix) with ESMTPS id 4D91FAA62CB
	for <lists+linux-erofs@lfdr.de>; Thu,  1 May 2025 20:30:15 +0200 (CEST)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4ZpMzm6npxz2yPd;
	Fri,  2 May 2025 04:30:12 +1000 (AEST)
X-Original-To: linux-erofs@lists.ozlabs.org
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip="2607:f8b0:4864:20::64a"
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1746124212;
	cv=none; b=KzEiwAzsp+s0o+uBwQ3iB0IWQrSoTmV9HF++5fe39xiutOws56ILCyNdphClbluR9vV59w8re2ALLslhQ+kXHOYOHuSD/5y5cspRykEvpTTmUkBlWxIkcrf5BfV0VWz7T6eHffIwo0zVNNn+NhTrXIS3XIHK3hwD+Yu1X9lKHD9MNcotG2NE9+eYfqOTfxIORSA1rQIAAPlktnJiRRnl8AwsdVTsDGI6QNnh/51ABdXx8eNkT+9RIh9w1+BKqMf7v2RcFsU9Y0Umt1ED3dUPB7T9EipMJUSlnc3+D0ROMY83t7nWyfZUaplZo6Z7WLN68buMYCDtYob0avZufGqUPQ==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1746124212; c=relaxed/relaxed;
	bh=3rG8w2g5pnqsJKJGWGYS1RxgDYNaSDTgSGnqF5xlTZ8=;
	h=Date:Mime-Version:Message-ID:Subject:From:To:Cc:Content-Type; b=AQ84EWgOcDV40zXp36aRuqBzlVDVGUnSfITxeNkZB9Q1g8T3YZXwfGQ6Q0JcEpDcC4ydQRRdcILzjqgMR1bMcynpzbylXXAUClI8WvM2LIC3yWdBXBlltSv2LAlBojEXshPgIQh7VMtAbG7h+eaUcCukCHOU92rr8z/AKMOSEsq/4vLpGrJ6IB7ArTAuhTspUGCvu5zhxVNT7xrVcUWEHpOefsJjY+UG2SVECLsA3JROUNIWe1IaTpGQXGfHx0f771dZA6a4o0nOkbHcwbLPzfNx2zMmujzxCZPDQ8SEIBnvKKQYdHVmIjwFniKGQCtzqglUe9dt5Ps+k8hpL7Dh3A==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=reject dis=none) header.from=google.com; dkim=pass (2048-bit key; unprotected) header.d=google.com header.i=@google.com header.a=rsa-sha256 header.s=20230601 header.b=HmzcwC9q; dkim-atps=neutral; spf=pass (client-ip=2607:f8b0:4864:20::64a; helo=mail-pl1-x64a.google.com; envelope-from=3r70taackc8ajng1grkmuumrk.iusrot03-kxulyroyzy.u5rghy.uxm@flex--dhavale.bounces.google.com; receiver=lists.ozlabs.org) smtp.mailfrom=flex--dhavale.bounces.google.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=google.com header.i=@google.com header.a=rsa-sha256 header.s=20230601 header.b=HmzcwC9q;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=flex--dhavale.bounces.google.com (client-ip=2607:f8b0:4864:20::64a; helo=mail-pl1-x64a.google.com; envelope-from=3r70taackc8ajng1grkmuumrk.iusrot03-kxulyroyzy.u5rghy.uxm@flex--dhavale.bounces.google.com; receiver=lists.ozlabs.org)
Received: from mail-pl1-x64a.google.com (mail-pl1-x64a.google.com [IPv6:2607:f8b0:4864:20::64a])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4ZpMzl0hdSz2yPS
	for <linux-erofs@lists.ozlabs.org>; Fri,  2 May 2025 04:30:10 +1000 (AEST)
Received: by mail-pl1-x64a.google.com with SMTP id d9443c01a7336-22651aca434so10559195ad.1
        for <linux-erofs@lists.ozlabs.org>; Thu, 01 May 2025 11:30:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1746124208; x=1746729008; darn=lists.ozlabs.org;
        h=cc:to:from:subject:message-id:mime-version:date:from:to:cc:subject
         :date:message-id:reply-to;
        bh=3rG8w2g5pnqsJKJGWGYS1RxgDYNaSDTgSGnqF5xlTZ8=;
        b=HmzcwC9qlFlfJy4LR731mtA6P8ItPpikcfRCsexCyc1WkkOuPjQchep9OkFsKVeSum
         3pO5v6kIdB66HMXdN5atn03UVJ2skTgSnYPjATU8ODw2AMXTGvu+bqq5Z1FSuTMchVub
         agtsw8QA5dCzuk06LBCUMhyxNGlcrLaehttUjiADO2eQAEllapJWH2ShXBJGK2IW0GPU
         bbJTbPZxlNn0zMesPFwYK5pMTpc9u+MZUNB/HrrWeSQ5olsJhAKHJ3e5xoPNEMdDhA+B
         HBEh9fQQq7UKdQtUs5kcUEPkhcMnkhpYGf646VnacxQjCD/80kXI5g0LaLv0wkGsImpo
         4+iw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1746124208; x=1746729008;
        h=cc:to:from:subject:message-id:mime-version:date:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=3rG8w2g5pnqsJKJGWGYS1RxgDYNaSDTgSGnqF5xlTZ8=;
        b=qwBn/A92WQEdZdaj5Uw2yOUPwVrruPApVlWFXX1iXPJIkrB2M5Z5cU2M1eLx9jyMWZ
         iQ6mXy7G/dp0sm+HZ5nMADfvPjrLFvxriorc9uHNkyo3TbkM2dF+ZESz9kTCxxBgPWzK
         F5BzWLBsbiAY0Yg22MOQrn+noxC+/oMGQarNRW6uZrYEBdKSQcik5hKQp0iIWAkmVxpV
         RUp9ygPe55R75P2IjrzPOWJ0fpf77Akfhziacm5fx6Wwwlq0CVujGkbh0Rn7zvPMBjKX
         fZAOe1n1awbovo9jFQhpQ1UrhglIcc/Vvs0u/zjYeVBWpjUa9+Tef0ufEQr9SLlgYpOM
         HwRA==
X-Gm-Message-State: AOJu0YxRYFI/vCYUA+1ExlUHyVpByrRlNvvaUMWHGtO1ZiFwYF3pvEfB
	STnrVwxu5OU8hIiFCeSvUK6PlNeKqy+yOXbBnOv1376qb/HPe8it3T56Cav7G0ZzOIMQK2t3q2T
	Ctc2DXP2kv+D6kHJhfPqqdWJ/tWIIhcwqOvt9iuN+EShMvOsdN2aJIETJWonRt3g2Yn5V9hFtAB
	ZS+nUlV0Dkm9t9RXnfNPPlzwL7yYwiJy1wObtiVzF9N6ujsg==
X-Google-Smtp-Source: AGHT+IFCy3Tkgv0lUGNjpXI1njfh0c72fTF/eesLs+bEJmYiPDIlmtCy5LdBflB4Lquh+wEYnVrZKxdwPGHp
X-Received: from plll1.prod.google.com ([2002:a17:902:d041:b0:223:5416:c809])
 (user=dhavale job=prod-delivery.src-stubby-dispatcher) by 2002:a17:903:234b:b0:227:e74a:a066
 with SMTP id d9443c01a7336-22e1035e3f0mr1126485ad.28.1746124207650; Thu, 01
 May 2025 11:30:07 -0700 (PDT)
Date: Thu,  1 May 2025 11:30:02 -0700
X-Mailing-List: linux-erofs@lists.ozlabs.org
List-Id: <linux-erofs.lists.ozlabs.org>
List-Help: <mailto:linux-erofs+help@lists.ozlabs.org>
List-Owner: <mailto:linux-erofs+owner@lists.ozlabs.org>
List-Post: <mailto:linux-erofs@lists.ozlabs.org>
List-Subscribe: <mailto:linux-erofs+subscribe@lists.ozlabs.org>,
  <mailto:linux-erofs+subscribe-digest@lists.ozlabs.org>,
  <mailto:linux-erofs+subscribe-nomail@lists.ozlabs.org>
List-Unsubscribe: <mailto:linux-erofs+unsubscribe@lists.ozlabs.org>
Precedence: list
Mime-Version: 1.0
X-Mailer: git-send-email 2.49.0.967.g6a0df3ecc3-goog
Message-ID: <20250501183003.1125531-1-dhavale@google.com>
Subject: [PATCH v5] erofs: lazily initialize per-CPU workers and CPU hotplug hooks
From: Sandeep Dhavale <dhavale@google.com>
To: linux-erofs@lists.ozlabs.org, Gao Xiang <xiang@kernel.org>, 
	Chao Yu <chao@kernel.org>, Yue Hu <zbestahu@gmail.com>, 
	Jeffle Xu <jefflexu@linux.alibaba.com>, Sandeep Dhavale <dhavale@google.com>
Cc: hsiangkao@linux.alibaba.com, kernel-team@android.com, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-7.6 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
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
v4: https://lore.kernel.org/linux-erofs/20250423061023.131354-1-dhavale@google.com/
Changes since v4:
- remove redundant blank line as suggested by Gao
- add a log for failure path as suggested by Chao
- also add success log which will help in case there was a failure
  before, else stale failure log could cause unnecessary concern

 fs/erofs/zdata.c | 65 ++++++++++++++++++++++++++++++++++++------------
 1 file changed, 49 insertions(+), 16 deletions(-)

diff --git a/fs/erofs/zdata.c b/fs/erofs/zdata.c
index 0671184d9cf1..a5d3aef319b2 100644
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
@@ -336,9 +339,45 @@ static int erofs_init_percpu_workers(void)
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
+	if (err) {
+		erofs_err(NULL, "per-cpu workers: failed to allocate.");
+		goto err_init_percpu_workers;
+	}
+
+	err = erofs_cpu_hotplug_init();
+	if (err < 0) {
+		erofs_err(NULL, "per-cpu workers: failed CPU hotplug init.");
+		goto err_cpuhp_init;
+	}
+	erofs_info(NULL, "initialized per-cpu workers successfully.");
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
@@ -405,8 +444,7 @@ static inline void erofs_cpu_hotplug_destroy(void) {}
 
 void z_erofs_exit_subsystem(void)
 {
-	erofs_cpu_hotplug_destroy();
-	erofs_destroy_percpu_workers();
+	z_erofs_destroy_pcpu_workers();
 	destroy_workqueue(z_erofs_workqueue);
 	z_erofs_destroy_pcluster_pool();
 	z_erofs_exit_decompressor();
@@ -430,19 +468,8 @@ int __init z_erofs_init_subsystem(void)
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
@@ -644,8 +671,14 @@ static const struct address_space_operations z_erofs_cache_aops = {
 
 int z_erofs_init_super(struct super_block *sb)
 {
-	struct inode *const inode = new_inode(sb);
+	struct inode *inode;
+	int err;
+
+	err = z_erofs_init_pcpu_workers();
+	if (err)
+		return err;
 
+	inode = new_inode(sb);
 	if (!inode)
 		return -ENOMEM;
 	set_nlink(inode, 1);
-- 
2.49.0.967.g6a0df3ecc3-goog


