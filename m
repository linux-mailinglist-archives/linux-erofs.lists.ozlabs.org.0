Return-Path: <linux-erofs+bounces-139-lists+linux-erofs=lfdr.de@lists.ozlabs.org>
X-Original-To: lists+linux-erofs@lfdr.de
Delivered-To: lists+linux-erofs@lfdr.de
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	by mail.lfdr.de (Postfix) with ESMTPS id AB8B3A79688
	for <lists+linux-erofs@lfdr.de>; Wed,  2 Apr 2025 22:27:42 +0200 (CEST)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4ZSbyf316dz2yHj;
	Thu,  3 Apr 2025 07:27:38 +1100 (AEDT)
X-Original-To: linux-erofs@lists.ozlabs.org
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip="2607:f8b0:4864:20::549"
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1743625658;
	cv=none; b=g6CsdZqMB0iU/vZ+MR8LZdSUECMMTkRzJz8ctjBQuNBmLPx8eVH2EL2kox8Eq8kasWtR5c+NVWXWxgYzVDcEidb9I/0CkpVTGK2DrgB/FtS3R/usiHSCou5ClAJyw9mEizonn27CaGNyqfs5ogeIvLc4z5wJmcJ982jHR+eH84omkKO65gmXCBgwTj3uNisotrmRC90KTwbzlzDGmMZ9aFRFowzYD7BAPcR9srgq3O+n63OdnPzeQaz+Rzav5dZhleCVcwIoiTBPghX00bXE2aTgCLZMoGKDtdqzu88RhmlYyqSChFBzAPgB7C7Gh5FxJMn45mCm7OE/lC1+4c136w==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1743625658; c=relaxed/relaxed;
	bh=AgkA3Y29OmmQYCAZrMmGPHeXSG+tG3DycR1OgdCrTAE=;
	h=Date:Mime-Version:Message-ID:Subject:From:To:Cc:Content-Type; b=Twbta1dB9H6jiakPkf9DUEP0Kj7vhItWObom+wET3BhSKmKyQPS6BGJvqCCcE4oY24tQKp3vplU9xdRHD1RnuGE6gAbN8x6+y7hXBVDKKyBaYQ0SILfXXqO+mEQWoX0RGiijKr7cBQ75XAFDdpAvSHa1gGCSIW235fpvL3Is6ER0AONM0McnwlBZbuUzfsDsxrki3IYfPqedNbKZD/XBEiPj7ni+/gjviUfj0W1LTGPZuf8n0uyscCuB4HwAV8lFH4ikOXUR30JRKb8u59IfCjyAPpPvXFoBxOanWcLFqPk+Jd4trU2R6ntdAdS+a/CHSS+0Td72B9nnwuZqSs9oHQ==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=reject dis=none) header.from=google.com; dkim=pass (2048-bit key; unprotected) header.d=google.com header.i=@google.com header.a=rsa-sha256 header.s=20230601 header.b=iaY3quWn; dkim-atps=neutral; spf=pass (client-ip=2607:f8b0:4864:20::549; helo=mail-pg1-x549.google.com; envelope-from=3tj3tzwckc-squninyrtbbtyr.pbzyvahk-rebsfyvfgf.bmynof.bet@flex--dhavale.bounces.google.com; receiver=lists.ozlabs.org) smtp.mailfrom=flex--dhavale.bounces.google.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=google.com header.i=@google.com header.a=rsa-sha256 header.s=20230601 header.b=iaY3quWn;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=flex--dhavale.bounces.google.com (client-ip=2607:f8b0:4864:20::549; helo=mail-pg1-x549.google.com; envelope-from=3tj3tzwckc-squninyrtbbtyr.pbzyvahk-rebsfyvfgf.bmynof.bet@flex--dhavale.bounces.google.com; receiver=lists.ozlabs.org)
Received: from mail-pg1-x549.google.com (mail-pg1-x549.google.com [IPv6:2607:f8b0:4864:20::549])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4ZSbyc3pRNz2yDk
	for <linux-erofs@lists.ozlabs.org>; Thu,  3 Apr 2025 07:27:35 +1100 (AEDT)
Received: by mail-pg1-x549.google.com with SMTP id 41be03b00d2f7-af5310c1ac1so120861a12.2
        for <linux-erofs@lists.ozlabs.org>; Wed, 02 Apr 2025 13:27:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1743625652; x=1744230452; darn=lists.ozlabs.org;
        h=cc:to:from:subject:message-id:mime-version:date:from:to:cc:subject
         :date:message-id:reply-to;
        bh=AgkA3Y29OmmQYCAZrMmGPHeXSG+tG3DycR1OgdCrTAE=;
        b=iaY3quWn0VY6Cb8mFpyrd03dvlHA5VV/IIuJqPmJHg+A77BDSrmlcf/IIMCThvw8rX
         NKtIhpLu4FuoUwV9Cwz6rqbvN5VKXlqzZNPMKrFuhtTG320e3IPGVG8DlxtMYMz6+KuS
         vJa/GD5visaFiuuOza9kmYdnazVb1g7Auy6J9x3ERdtfQoHB2Hgc2THTWaDbuSFeVjik
         ImQm0u9dMfxB9gsyZq5El+gwT/3RLEDiHCLCGs7yUByLih5zmm+lU6VHzUK0Byq+FPLR
         HYhD1nt8KMR9CCFESHa8KaXUAPTMWiGI5oQ/Q0q/79He4xLDl8dAVZqavYJq4YB7GbZO
         xQxQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1743625652; x=1744230452;
        h=cc:to:from:subject:message-id:mime-version:date:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=AgkA3Y29OmmQYCAZrMmGPHeXSG+tG3DycR1OgdCrTAE=;
        b=SSLsVl55t9f6sypCZwNdMaHZYhNN3Qg3ouLHhPWWOeHCjbfn4lef5pQ+DUGMe6Wq3h
         2UK/BDjORZPI708jAL+XkeAb1Taify0ICOdthrhUYQSTUJAnp/qx+1DfgItRp+hryzJY
         p55+8dozk3OgAaQlVBZcTEMOc+FcavyBtSuKtxym8a/FO5Dbxn2IySRItcQsaN6PkDXv
         iqpprHMzm0KlgonwEa9yHGpBw/S7a9sYunh38CzAI0gna+EYBgpeAL+UIJ6kSXkstoh8
         EFmnfwd9v6KjldjX9euRgdOASjS0v7uVctT7Xrk2ugo9OK2aQG4wpwuVGlHUxBtG22hV
         3Pcw==
X-Gm-Message-State: AOJu0Yw391/VE5laX4y7oGeUN4YKj5PqivEhdlSltpya4q9amJHOezdn
	ggfAEZ9Vu2/W4MlJoCEUauckJ4hXFpmLo2RzeSLKYrGEg5HOHJwFWvyPXgfXbw8cHBaA8KYgaPz
	/Q8LFEDJsH9FFyEatoumnRoIeRtadz8Gag0Q8oRsz5fvN8qzByHVWKkbP8Sky/GVRvuOihRa/+I
	CFZPJsfEI8IGqLFqWcaeYR6gyziG+s2q3LI1UJuZBFAw3G1A==
X-Google-Smtp-Source: AGHT+IFUCBZtSd1jZaMyOQlfeHsrVKzPZUbE0VX+8I/AuOG8PteyiNItlgbzNisHH17oq/SzIZQITbASOFLm
X-Received: from plbko16.prod.google.com ([2002:a17:903:7d0:b0:220:ca3c:96bc])
 (user=dhavale job=prod-delivery.src-stubby-dispatcher) by 2002:a17:902:e88f:b0:221:78a1:27fb
 with SMTP id d9443c01a7336-2295be31744mr117782815ad.11.1743625652512; Wed, 02
 Apr 2025 13:27:32 -0700 (PDT)
Date: Wed,  2 Apr 2025 13:27:25 -0700
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
X-Mailer: git-send-email 2.49.0.472.ge94155a9ec-goog
Message-ID: <20250402202728.2157627-1-dhavale@google.com>
Subject: [PATCH v2] erofs: lazily initialize per-CPU workers and CPU hotplug hooks
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
v1: https://lore.kernel.org/linux-erofs/20250331022011.645533-2-dhavale@google.com/
Changes since v1:
- Get rid of erofs_mount_count based init and tear down of resources
- Initialize resource in z_erofs_init_super() as suggested by Gao
- Introduce z_erofs_init_workers_once() and track it using atomic bool
- Improve commit message

 fs/erofs/internal.h |  2 ++
 fs/erofs/zdata.c    | 57 ++++++++++++++++++++++++++++++++++-----------
 2 files changed, 46 insertions(+), 13 deletions(-)

diff --git a/fs/erofs/internal.h b/fs/erofs/internal.h
index 4ac188d5d894..bbc92ee41846 100644
--- a/fs/erofs/internal.h
+++ b/fs/erofs/internal.h
@@ -450,6 +450,7 @@ int z_erofs_gbuf_growsize(unsigned int nrpages);
 int __init z_erofs_gbuf_init(void);
 void z_erofs_gbuf_exit(void);
 int z_erofs_parse_cfgs(struct super_block *sb, struct erofs_super_block *dsb);
+int z_erofs_init_workers_once(void);
 #else
 static inline void erofs_shrinker_register(struct super_block *sb) {}
 static inline void erofs_shrinker_unregister(struct super_block *sb) {}
@@ -458,6 +459,7 @@ static inline void erofs_exit_shrinker(void) {}
 static inline int z_erofs_init_subsystem(void) { return 0; }
 static inline void z_erofs_exit_subsystem(void) {}
 static inline int z_erofs_init_super(struct super_block *sb) { return 0; }
+static inline int z_erofs_init_workers_once(void) { return 0; };
 #endif	/* !CONFIG_EROFS_FS_ZIP */
 
 #ifdef CONFIG_EROFS_FS_BACKED_BY_FILE
diff --git a/fs/erofs/zdata.c b/fs/erofs/zdata.c
index 0671184d9cf1..75f0adcff97b 100644
--- a/fs/erofs/zdata.c
+++ b/fs/erofs/zdata.c
@@ -11,6 +11,7 @@
 
 #define Z_EROFS_PCLUSTER_MAX_PAGES	(Z_EROFS_PCLUSTER_MAX_SIZE / PAGE_SIZE)
 #define Z_EROFS_INLINE_BVECS		2
+static atomic_t erofs_percpu_workers_initialized = ATOMIC_INIT(0);
 
 struct z_erofs_bvec {
 	struct page *page;
@@ -403,10 +404,44 @@ static inline int erofs_cpu_hotplug_init(void) { return 0; }
 static inline void erofs_cpu_hotplug_destroy(void) {}
 #endif
 
-void z_erofs_exit_subsystem(void)
+static int z_erofs_init_workers(void)
 {
-	erofs_cpu_hotplug_destroy();
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
 	erofs_destroy_percpu_workers();
+err_init_percpu_workers:
+	atomic_set(&erofs_percpu_workers_initialized, 0);
+	return err;
+}
+
+int z_erofs_init_workers_once(void)
+{
+	if (atomic_xchg(&erofs_percpu_workers_initialized, 1))
+		return 0;
+	return z_erofs_init_workers();
+}
+
+static void z_erofs_destroy_workers(void)
+{
+	if (atomic_xchg(&erofs_percpu_workers_initialized, 0)) {
+		erofs_cpu_hotplug_destroy();
+		erofs_destroy_percpu_workers();
+	}
+}
+
+void z_erofs_exit_subsystem(void)
+{
+	z_erofs_destroy_workers();
 	destroy_workqueue(z_erofs_workqueue);
 	z_erofs_destroy_pcluster_pool();
 	z_erofs_exit_decompressor();
@@ -430,19 +465,8 @@ int __init z_erofs_init_subsystem(void)
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
@@ -645,6 +669,13 @@ static const struct address_space_operations z_erofs_cache_aops = {
 int z_erofs_init_super(struct super_block *sb)
 {
 	struct inode *const inode = new_inode(sb);
+	int err;
+
+	err = z_erofs_init_workers_once();
+	if (err) {
+		iput(inode);
+		return err;
+	}
 
 	if (!inode)
 		return -ENOMEM;
-- 
2.49.0.472.ge94155a9ec-goog


