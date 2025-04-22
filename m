Return-Path: <linux-erofs+bounces-213-lists+linux-erofs=lfdr.de@lists.ozlabs.org>
X-Original-To: lists+linux-erofs@lfdr.de
Delivered-To: lists+linux-erofs@lfdr.de
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2404:9400:2:0:216:3eff:fee1:b9f1])
	by mail.lfdr.de (Postfix) with ESMTPS id 55156A97B2D
	for <lists+linux-erofs@lfdr.de>; Wed, 23 Apr 2025 01:45:59 +0200 (CEST)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4ZhzQF12C8z3bmN;
	Wed, 23 Apr 2025 09:45:57 +1000 (AEST)
X-Original-To: linux-erofs@lists.ozlabs.org
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip="2607:f8b0:4864:20::549"
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1745365557;
	cv=none; b=grnVbCir8Ku5a0DVVYj4z2dKWK+ztZsXNkx0qqrO7SfezDOB2WdyPJVULnEm7fNXA/iqy9WZqc3LrWPdqLw7xS02Hcv0vsJaL16iSLzQ7L2soEItUHbtaTwXHK3YHCKEUQoMRVXI9LpNwCxIP14/DiOfOdwnIe4BkJqkXt3f2hZ94t1+DwZ104C2nv0WNKhvu8BCZJnOpdUEnLShLuMuNY7TtS85gjIFbSQwjgsPEHs6yA470TmfqqHT+n1gkmDDc5YpBeduDIBsEsb8q3hsn16ipLXYrtXnTP2gnMXc1+VtPHxCgHHyOEUoh+Pz5HxgoazoQDIUQXlvPbvwRf4HNg==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1745365557; c=relaxed/relaxed;
	bh=9PvQfpQ8pnvLyCSJcqeNFDDW25RW7LzCs+kk0KAuRMI=;
	h=Date:Mime-Version:Message-ID:Subject:From:To:Cc:Content-Type; b=LcNenlKZqeujD0aKlFFAF+DfkAa/6Z96/xOwZ5pilLMs5FoWD66RPZAzRvcGaJDaL6ZoY6XgAtaUTyMta78RO6/e4zIvl4/V4pLO97K2EpniQS2nUvWKBtj+TrsQEKOLlYCRpaB1fs93Zy0CXDVFyvyb9r7zaY/bfywBW8BVeTEqt/nCZi7sO0XX5ju8V0gKZHga2z0EK7HrPhKdRIpKbQsEf9dmwgMggRE/wMRRWD2iIKO4DsNt0LqpiOQdUPN/gjhh07pqsnPvwyoMx1AJbFHPpbF/eKBeNkOc4NcAtkrZnf+WbWXgVV/VONnvTbOvmkgC3VoH8cM/jlInQpM2Ug==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=reject dis=none) header.from=google.com; dkim=pass (2048-bit key; unprotected) header.d=google.com header.i=@google.com header.a=rsa-sha256 header.s=20230601 header.b=I5RY1sbh; dkim-atps=neutral; spf=pass (client-ip=2607:f8b0:4864:20::549; helo=mail-pg1-x549.google.com; envelope-from=3mcoiaackc-squninyrtbbtyr.pbzyvahk-rebsfyvfgf.bmynof.bet@flex--dhavale.bounces.google.com; receiver=lists.ozlabs.org) smtp.mailfrom=flex--dhavale.bounces.google.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=google.com header.i=@google.com header.a=rsa-sha256 header.s=20230601 header.b=I5RY1sbh;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=flex--dhavale.bounces.google.com (client-ip=2607:f8b0:4864:20::549; helo=mail-pg1-x549.google.com; envelope-from=3mcoiaackc-squninyrtbbtyr.pbzyvahk-rebsfyvfgf.bmynof.bet@flex--dhavale.bounces.google.com; receiver=lists.ozlabs.org)
Received: from mail-pg1-x549.google.com (mail-pg1-x549.google.com [IPv6:2607:f8b0:4864:20::549])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4ZhzQC71BRz3bb2
	for <linux-erofs@lists.ozlabs.org>; Wed, 23 Apr 2025 09:45:55 +1000 (AEST)
Received: by mail-pg1-x549.google.com with SMTP id 41be03b00d2f7-896c1845cb9so329763a12.1
        for <linux-erofs@lists.ozlabs.org>; Tue, 22 Apr 2025 16:45:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1745365553; x=1745970353; darn=lists.ozlabs.org;
        h=cc:to:from:subject:message-id:mime-version:date:from:to:cc:subject
         :date:message-id:reply-to;
        bh=9PvQfpQ8pnvLyCSJcqeNFDDW25RW7LzCs+kk0KAuRMI=;
        b=I5RY1sbhhMGWkDbgQPaa11hr6bcdJ3KrKI2gVaRVJX98dYfgnSdjYLPcbC4M4ek0LB
         j5iYKP926LC9EZa+0IkmCNdepv2pEQHsfbFmLAzd9xAFCBbL0+B6HIDzJraA+MOQc2Wh
         dGcMfO2Nr/H7loThidUOMGwupHJJVrwbLlHZbg4A/50DwvNL9oIhDOK29mGoqlE9Mwrf
         NIo1OYM28pG25GnAL5lYE3CgXw3Ydx672xaQrbrKONtPCeyGYOxTarBK81M3RBoSdaMs
         /t6p1yODizDfZmQm2QsFJgvnXtSHKz19QdCyc27hv4ftg9qe60cQDI4oZOtcvSScAO7q
         k0OQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1745365553; x=1745970353;
        h=cc:to:from:subject:message-id:mime-version:date:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=9PvQfpQ8pnvLyCSJcqeNFDDW25RW7LzCs+kk0KAuRMI=;
        b=X1RkxQcYeXJmYB3+INS70MVVhWPiFZk5SNCNvBCgQizImvRas9ZCVTfQEKiHmHDNwy
         6s/cAEgZ+290P4FzUaF8ZAjZxICQhOeQVOiHaUon0VPN9bMINeWDRXDQNx9Gw90aT6FU
         uJ6l41XOXlCnzxJoJfBU7h8F4wim3jxAgKS5kBVCFCKNKB4MXwpR2dRnErcFytnd3n2E
         PuDN7mQVUHzcjn8spbsEzLZS/QTzNmWnk8xxLhfml++Fc0wKI5g8UgAhUiFyOjuhpCp9
         i4694Lct1XjGFrmoYWlHlwHBEvMsijgggLKGxKDrP/G2usXacAr1kJvdXkc7ox6iEyQB
         uzYw==
X-Gm-Message-State: AOJu0YyJCxKqrQSQYsc1G3SpVoiNFBaPbclXfDWFyMKIvIvMJn2mdIwI
	e1j8dUN4gg+5JzDQjbV4Cp7lEwUfexgviIGve1O5Df7ummI9vbx3Sa0OKfuzCxVPdTX6DNtLFaa
	fwXaTNj2xgzPCQIyBdE0XyG1agktv5d1pv3katccaBVfAWpLanjE0caGNn3BuwmA5hAYiZbNBpi
	vH6HIirtpBZzpnABDxVpeQqPzi4/8ndJ/Xm803vrBqQkC32A==
X-Google-Smtp-Source: AGHT+IGdDc6uxDvgdNGP8MLKpkib8gYXEO4AzgKzce0SH2VXvDWB3/IIqU044dM0qE2hgKmn+YZOBO4dGbHm
X-Received: from pgbbx34.prod.google.com ([2002:a05:6a02:522:b0:b05:23fb:ed46])
 (user=dhavale job=prod-delivery.src-stubby-dispatcher) by 2002:a05:6a21:a4c4:b0:1ee:ab52:b8cc
 with SMTP id adf61e73a8af0-2042e9071d9mr1213858637.21.1745365552645; Tue, 22
 Apr 2025 16:45:52 -0700 (PDT)
Date: Tue, 22 Apr 2025 16:45:43 -0700
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
Message-ID: <20250422234546.2932092-1-dhavale@google.com>
Subject: [PATCH v3] erofs: lazily initialize per-CPU workers and CPU hotplug hooks
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
v2: https://lore.kernel.org/linux-erofs/20250402202728.2157627-1-dhavale@google.com/
Changes since v2:
- Renamed functions to use pcpu so it is clear.
- Removed z_erofs_init_workers_once() declaration from internal.h as
  there is no need.
- Removed empty stubs for helpers erofs_init_percpu_workers() and
  erofs_destroy_percpu_workers().
- Moved erofs_percpu_workers_initialized under
  CONFIG_EROFS_FS_PCPU_KTHREAD as further cleanup.

 fs/erofs/zdata.c | 65 ++++++++++++++++++++++++++++++++++++------------
 1 file changed, 49 insertions(+), 16 deletions(-)

diff --git a/fs/erofs/zdata.c b/fs/erofs/zdata.c
index 0671184d9cf1..e12df8b914b6 100644
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
@@ -336,9 +339,44 @@ static int erofs_init_percpu_workers(void)
 	}
 	return 0;
 }
+
+static int z_erofs_init_pcpu_workers(void)
+{
+	int err;
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
+static int z_erofs_init_workers_once(void)
+{
+	if (atomic_xchg(&erofs_percpu_workers_initialized, 1))
+		return 0;
+	return z_erofs_init_pcpu_workers();
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
+static inline int z_erofs_init_workers_once(void) { return 0; }
+static inline void z_erofs_destroy_pcpu_workers(void) {}
 #endif
 
 #if defined(CONFIG_HOTPLUG_CPU) && defined(CONFIG_EROFS_FS_PCPU_KTHREAD)
@@ -405,8 +443,7 @@ static inline void erofs_cpu_hotplug_destroy(void) {}
 
 void z_erofs_exit_subsystem(void)
 {
-	erofs_cpu_hotplug_destroy();
-	erofs_destroy_percpu_workers();
+	z_erofs_destroy_pcpu_workers();
 	destroy_workqueue(z_erofs_workqueue);
 	z_erofs_destroy_pcluster_pool();
 	z_erofs_exit_decompressor();
@@ -430,19 +467,8 @@ int __init z_erofs_init_subsystem(void)
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
@@ -644,10 +670,17 @@ static const struct address_space_operations z_erofs_cache_aops = {
 
 int z_erofs_init_super(struct super_block *sb)
 {
-	struct inode *const inode = new_inode(sb);
+	struct inode *inode;
+	int err;
 
+	err = z_erofs_init_workers_once();
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


