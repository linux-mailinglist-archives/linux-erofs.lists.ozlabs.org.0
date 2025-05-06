Return-Path: <linux-erofs+bounces-282-lists+linux-erofs=lfdr.de@lists.ozlabs.org>
X-Original-To: lists+linux-erofs@lfdr.de
Delivered-To: lists+linux-erofs@lfdr.de
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2404:9400:2:0:216:3eff:fee1:b9f1])
	by mail.lfdr.de (Postfix) with ESMTPS id 149B4AAD140
	for <lists+linux-erofs@lfdr.de>; Wed,  7 May 2025 00:57:58 +0200 (CEST)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4ZsYhL2vFdz2yPS;
	Wed,  7 May 2025 08:57:54 +1000 (AEST)
X-Original-To: linux-erofs@lists.ozlabs.org
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip="2607:f8b0:4864:20::649"
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1746572274;
	cv=none; b=nYkwL/aTXPbRWJStkeaBk/KrhGHafeOpqgkaTgWQ1VBw8BKOmtiADMhwXIJcRDj4k8avNbAEJDU2iASvMhBUG7yTDC6NWCSV7PklzgbluTSa+PTviOqKya3FzTU2lnTdQ2FxjRLEKexOJqwh6gAslno+wkQszNXqHJEcGwe77DHPNYdozCbctpqQX1ggi6VihLlbsdl+DR2VcH9Oe20bsEBzye9QggZYh+ky09BNswWDDzqYsV1KdUYEhTsrFvoP3DdjHByruCmgBhVROGycLI05jGAXN8GEklhYhsWdPKg/EbgAnhucasojsg0aWygoP3FTz0qFljJ2PdDgzNGy6A==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1746572274; c=relaxed/relaxed;
	bh=6eDff5j1BSe64nzccDcAn4Qo86/NWyx+D0Je4IAcyac=;
	h=Date:Mime-Version:Message-ID:Subject:From:To:Cc:Content-Type; b=EDj7oS0gLXokLDlDbKu0YkLvNIfc4xzuTbqNHJhAakf9VRd7WkGGc26iWngbl0XZrIPECs+lD9eS5bfKEXHpR9huOuK9IdZEql8Ef8r+KWLzEAbdyH9uq8xBLVogYkYoNvVlzkkoTbrrknLkaElyqByjDNBLGtebcNbm02fhrO0memLjOf40hsNd8tpepe3oqB41vDJ9ADs7MSGZKRXF8SMsIuG7jAOhOe/a/difgIQIZmSfecKgu8RV+6m++aLREoWxhae9tRaNd06kVKV+VwMjKxQ7cvSmAqrhLyS1mJJEKQXVHz9LV+LGQTZEoHCAAr0NxdgOtCdBN9IroJ6hgw==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=reject dis=none) header.from=google.com; dkim=pass (2048-bit key; unprotected) header.d=google.com header.i=@google.com header.a=rsa-sha256 header.s=20230601 header.b=XeEHeYfh; dkim-atps=neutral; spf=pass (client-ip=2607:f8b0:4864:20::649; helo=mail-pl1-x649.google.com; envelope-from=37jmaaackc8uosl6lwprzzrwp.nzxwty58-p2zq3wt343.zawlm3.z2r@flex--dhavale.bounces.google.com; receiver=lists.ozlabs.org) smtp.mailfrom=flex--dhavale.bounces.google.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=google.com header.i=@google.com header.a=rsa-sha256 header.s=20230601 header.b=XeEHeYfh;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=flex--dhavale.bounces.google.com (client-ip=2607:f8b0:4864:20::649; helo=mail-pl1-x649.google.com; envelope-from=37jmaaackc8uosl6lwprzzrwp.nzxwty58-p2zq3wt343.zawlm3.z2r@flex--dhavale.bounces.google.com; receiver=lists.ozlabs.org)
Received: from mail-pl1-x649.google.com (mail-pl1-x649.google.com [IPv6:2607:f8b0:4864:20::649])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4ZsYhJ502xz2yNB
	for <linux-erofs@lists.ozlabs.org>; Wed,  7 May 2025 08:57:51 +1000 (AEST)
Received: by mail-pl1-x649.google.com with SMTP id d9443c01a7336-2254e0b4b85so3225115ad.0
        for <linux-erofs@lists.ozlabs.org>; Tue, 06 May 2025 15:57:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1746572269; x=1747177069; darn=lists.ozlabs.org;
        h=cc:to:from:subject:message-id:mime-version:date:from:to:cc:subject
         :date:message-id:reply-to;
        bh=6eDff5j1BSe64nzccDcAn4Qo86/NWyx+D0Je4IAcyac=;
        b=XeEHeYfhqaZD5/7A2JZ4XARhKPZDav8eVlpcVhMNnphs3WOrwNrJavOm6dQP/O2wcH
         n3RO/Z5zHRge5ulY+v+c5XIgv590T788xhouRgqSTXJaHMbil/irpC82wQAANOp88JvT
         1OK4m2LT1fAC4YrywhikfTYO+c/QzpuaYvUbHwQjWWUorrQcW2zsT1zwLSWbNVo8VwmA
         3uwNwFn90ZsCzL/MCQDRoHfJumCL9SaRdC8buoDUOXiZJcq9rxjeTSfe2ALKEvTv1zaD
         80PPZjDENblDyxRfYw1s2nnICB0ErbD+zEhRlttE+GqwQdPMgLPEZrIQHA4fEPXG0HLL
         t/DQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1746572269; x=1747177069;
        h=cc:to:from:subject:message-id:mime-version:date:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=6eDff5j1BSe64nzccDcAn4Qo86/NWyx+D0Je4IAcyac=;
        b=d9uzPGFV24ltbk8cwAczwik4Lu5masCyats4m1wiJRcTctPM8a1JjFvJI71GhuVYdB
         iZ1AJNKrET0F00lUlGj8zGXPXRI2NX5YEQBF4snsaYmOeER7+Rsnzs1pAdpWj8kWqd5X
         TtZ3W+kLuyZnwE4cDaMqh90FBsrKruxt5qdCttSEv7VMCZNDGZ1cqNyaK2yF5rEZT6gX
         fwVTQ+wMceTC4SzUftEG6Ps+cPCGtLZlxyCzmN+PoipUq/8kKRbPNNEP17Z302oBO31K
         koqE4ZQhMKdZDIbJjlMl7onlbvvgmV4J2vcZkWvK0JNuxEK1+CAg9lUpyTk927SKLvaQ
         z8Lg==
X-Gm-Message-State: AOJu0YxIeflx8tnwTFxo5yhWbHAG/OYXmlbLLafdH1bA29OHjjxCQgQF
	wbd6UtFla84hxI9VpS2nWpkKFMlHF64AGOQ+/pcvNXGh527jk/Ht/9kIw3MSAsspnjkjU3P0HwA
	6d3Sku7jiAfATn6qvLX+S8YSrurmeCHND6TUHnTLfV4ABZZB5IGWoZSnxNJV6RivxmVY+EHwh35
	MTXfgGeLX2zNJXFfBA7Z5vzdNenhrphJo1IKUEb0K8F9YBhg==
X-Google-Smtp-Source: AGHT+IE1PDhDMNYoRtAJX1/3t5lH5zhttLLAu5JIa3TnRr7p4kKvsPCcHCn5sIfILdSU9kfOSkh2gGL3Frja
X-Received: from pgvt21.prod.google.com ([2002:a65:64d5:0:b0:b0d:bc6d:106])
 (user=dhavale job=prod-delivery.src-stubby-dispatcher) by 2002:a17:902:e78c:b0:223:3eed:f680
 with SMTP id d9443c01a7336-22e5d9d6114mr22067365ad.18.1746572268748; Tue, 06
 May 2025 15:57:48 -0700 (PDT)
Date: Tue,  6 May 2025 15:57:41 -0700
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
X-Mailer: git-send-email 2.49.0.987.g0cc8ee98dc-goog
Message-ID: <20250506225743.308517-1-dhavale@google.com>
Subject: [PATCH v6] erofs: lazily initialize per-CPU workers and CPU hotplug hooks
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
v5: https://lore.kernel.org/linux-erofs/20250501183003.1125531-1-dhavale@google.com/
Changes since v5:
- Pass sb to z_erofs_init_pcpu_workers so we can log success/failure
  messages, so we know the context in which the event happened as
  suggested by Gao.
- Move the CONFIG_CPU_HOTPLUG code inside CONFIG_EROFS_FS_PCPU_KTHREAD
  so it is much more readable and also avoids forward declaration for
  some functions.
 fs/erofs/zdata.c | 70 ++++++++++++++++++++++++++++++++++--------------
 1 file changed, 50 insertions(+), 20 deletions(-)

diff --git a/fs/erofs/zdata.c b/fs/erofs/zdata.c
index 0671184d9cf1..0afbdabe8d3e 100644
--- a/fs/erofs/zdata.c
+++ b/fs/erofs/zdata.c
@@ -291,6 +291,7 @@ static struct workqueue_struct *z_erofs_workqueue __read_mostly;
 
 #ifdef CONFIG_EROFS_FS_PCPU_KTHREAD
 static struct kthread_worker __rcu **z_erofs_pcpu_workers;
+static atomic_t erofs_percpu_workers_initialized = ATOMIC_INIT(0);
 
 static void erofs_destroy_percpu_workers(void)
 {
@@ -336,12 +337,8 @@ static int erofs_init_percpu_workers(void)
 	}
 	return 0;
 }
-#else
-static inline void erofs_destroy_percpu_workers(void) {}
-static inline int erofs_init_percpu_workers(void) { return 0; }
-#endif
 
-#if defined(CONFIG_HOTPLUG_CPU) && defined(CONFIG_EROFS_FS_PCPU_KTHREAD)
+#ifdef CONFIG_HOTPLUG_CPU
 static DEFINE_SPINLOCK(z_erofs_pcpu_worker_lock);
 static enum cpuhp_state erofs_cpuhp_state;
 
@@ -398,15 +395,53 @@ static void erofs_cpu_hotplug_destroy(void)
 	if (erofs_cpuhp_state)
 		cpuhp_remove_state_nocalls(erofs_cpuhp_state);
 }
-#else /* !CONFIG_HOTPLUG_CPU || !CONFIG_EROFS_FS_PCPU_KTHREAD */
+#else /* !CONFIG_HOTPLUG_CPU  */
 static inline int erofs_cpu_hotplug_init(void) { return 0; }
 static inline void erofs_cpu_hotplug_destroy(void) {}
-#endif
+#endif/* CONFIG_HOTPLUG_CPU */
+static int z_erofs_init_pcpu_workers(struct super_block *sb)
+{
+	int err;
 
-void z_erofs_exit_subsystem(void)
+	if (atomic_xchg(&erofs_percpu_workers_initialized, 1))
+		return 0;
+
+	err = erofs_init_percpu_workers();
+	if (err) {
+		erofs_err(sb, "per-cpu workers: failed to allocate.");
+		goto err_init_percpu_workers;
+	}
+
+	err = erofs_cpu_hotplug_init();
+	if (err < 0) {
+		erofs_err(sb, "per-cpu workers: failed CPU hotplug init.");
+		goto err_cpuhp_init;
+	}
+	erofs_info(sb, "initialized per-cpu workers successfully.");
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
 {
+	if (!atomic_xchg(&erofs_percpu_workers_initialized, 0))
+		return;
 	erofs_cpu_hotplug_destroy();
 	erofs_destroy_percpu_workers();
+}
+#else /* !CONFIG_EROFS_FS_PCPU_KTHREAD */
+static inline int z_erofs_init_pcpu_workers(struct super_block *sb) { return 0; }
+static inline void z_erofs_destroy_pcpu_workers(void) {}
+#endif/* CONFIG_EROFS_FS_PCPU_KTHREAD */
+
+void z_erofs_exit_subsystem(void)
+{
+	z_erofs_destroy_pcpu_workers();
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
@@ -644,8 +668,14 @@ static const struct address_space_operations z_erofs_cache_aops = {
 
 int z_erofs_init_super(struct super_block *sb)
 {
-	struct inode *const inode = new_inode(sb);
+	struct inode *inode;
+	int err;
+
+	err = z_erofs_init_pcpu_workers(sb);
+	if (err)
+		return err;
 
+	inode = new_inode(sb);
 	if (!inode)
 		return -ENOMEM;
 	set_nlink(inode, 1);
-- 
2.49.0.987.g0cc8ee98dc-goog


