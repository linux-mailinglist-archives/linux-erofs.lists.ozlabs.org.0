Return-Path: <linux-erofs+bounces-128-lists+linux-erofs=lfdr.de@lists.ozlabs.org>
X-Original-To: lists+linux-erofs@lfdr.de
Delivered-To: lists+linux-erofs@lfdr.de
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2404:9400:2:0:216:3eff:fee1:b9f1])
	by mail.lfdr.de (Postfix) with ESMTPS id 86887A75DC7
	for <lists+linux-erofs@lfdr.de>; Mon, 31 Mar 2025 04:20:36 +0200 (CEST)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4ZQvxF5bwFz2yf1;
	Mon, 31 Mar 2025 13:20:33 +1100 (AEDT)
X-Original-To: linux-erofs@lists.ozlabs.org
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip="2607:f8b0:4864:20::1049"
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1743387633;
	cv=none; b=gX+cLZr8kMtsQNoUa0qrexLoeRESDiRDQD6XLcLUjuv5h+li8FajPEqt1jvUsoMcsS+aaozgL+2sAoH84gwckq5sJhnOxLvK/1nhmP8P9PHYoFKmLC09VZekOG+dSs5czQTW/PAl9ErXng9/5vIsk+zHZS0utsxsNNKjujttLNfkjkJQOu6l3N1j7wu3+///j86kFn+aeKajKUGIX+JuKRGJ5TOdHsxbMHpiH5p/U7JoGMejhvfA7tVbjIBqpvkRPTwj65F9YrbMoS+7yA93QghFZl08XZJlOJgOXVYU9y0ueg/x9pYiE0LlNf21Z1ryfLu0dAJd57Nx8AZzZoS3DA==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1743387633; c=relaxed/relaxed;
	bh=BWo5igrEPXFMOZGYJoDbqOqkIE246nBzf9T+In+irrM=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=m7i/Qq50Pl4a4Gb+lOpxHC0QCeCr4SG3/dhXIuY2BiCi2qaDEZNxL0tEXm1h7iyDAwbu5v45Mbi18NQbXxGVSN7TBPiBfmKfN7fCwD1p7h4ZqIv8w077bOwXj6UMAdY/yfWWMBVh/WlEiACwj0YLPUXTHdQn5f9OfDtMtPCgUsDuIk0xPq8R3pWZy9hVzSnKnVCFWZpJRWZxCLjV3EJyuakD3ZXDi9NhjvMi1vUeVdAf1ai+Gkw3WGg0zIjzd+H4pEO2csyRhjnUdDNr0OftFbgKp6JWJcDYdJsi4nqzVNvYUEN7ebh4fAVIZMfG4Ksjh9Xeyce5HRpWIMX4ZzQ06w==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=reject dis=none) header.from=google.com; dkim=pass (2048-bit key; unprotected) header.d=google.com header.i=@google.com header.a=rsa-sha256 header.s=20230601 header.b=sYb/RNcH; dkim-atps=neutral; spf=pass (client-ip=2607:f8b0:4864:20::1049; helo=mail-pj1-x1049.google.com; envelope-from=37vvpzwckc9m26zkza35dd5a3.1dba7cjm-3gd4ha7hih.doaz0h.dg5@flex--dhavale.bounces.google.com; receiver=lists.ozlabs.org) smtp.mailfrom=flex--dhavale.bounces.google.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=google.com header.i=@google.com header.a=rsa-sha256 header.s=20230601 header.b=sYb/RNcH;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=flex--dhavale.bounces.google.com (client-ip=2607:f8b0:4864:20::1049; helo=mail-pj1-x1049.google.com; envelope-from=37vvpzwckc9m26zkza35dd5a3.1dba7cjm-3gd4ha7hih.doaz0h.dg5@flex--dhavale.bounces.google.com; receiver=lists.ozlabs.org)
Received: from mail-pj1-x1049.google.com (mail-pj1-x1049.google.com [IPv6:2607:f8b0:4864:20::1049])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4ZQvxF00VPz2yFP
	for <linux-erofs@lists.ozlabs.org>; Mon, 31 Mar 2025 13:20:32 +1100 (AEDT)
Received: by mail-pj1-x1049.google.com with SMTP id 98e67ed59e1d1-3032f4eacd8so6339483a91.3
        for <linux-erofs@lists.ozlabs.org>; Sun, 30 Mar 2025 19:20:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1743387631; x=1743992431; darn=lists.ozlabs.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=BWo5igrEPXFMOZGYJoDbqOqkIE246nBzf9T+In+irrM=;
        b=sYb/RNcHnzTsvn4NGsXlWgI7KS96oqIoiiGrgCBn1wjreWp7POcd0hOTDgNdoA5MdL
         Ek8US9q2JpO5BbLnYrxGXKfTUixP3Y/v2atjmZ6EiBU8Lo/db2dxlOUjhmEgyautsya7
         VWYgpwHK6iN6IVyzUe+TFqxvF6dUSFjC8FuUufO7jJ993oHQ4DFbFpOq/eGNLqO3rMOg
         PJjbmCem1LwyAn/+zGKWXqi0eQRTYjKdCdCd2VlfJCZqITWCMxW1cxhuUiYaeUah3Pk7
         9FCOMZtaFJUtAbF/rZL7mTlj/ltc218gOtuIrNNxp2sXNefDP0uHRlnDl+Xppee7B2u4
         CmPg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1743387631; x=1743992431;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=BWo5igrEPXFMOZGYJoDbqOqkIE246nBzf9T+In+irrM=;
        b=U4Ahh72Z7j0WuZE9/1rVGmd0MTNoxHWQgnYOOeK8637wP1fijFzrUqEit3jULOHqs4
         tworr9jiXBkai/+wAqST1fTRjvPVRpFi45xrkzHpVHiTIa8d4gsoZ1XvAG4ZJ6zoKn+K
         dwc+Y38JV+DrA6GQpL8JJHlYkj0bNweipiRROZWxnWadV7R1e9tZ1zrYgz4MWXJzVNl6
         BupaHf/8DAE+aDoonTB46yvYpl/tAx2bcGBOulvTrpv6c5Tl2cYDttatUtbafK/g6des
         pCW8sHefh3IUAeiw3TMSPHu/ixaYmHlxoQEM770Cd+6wnb8w8kFJslvoyrVU6kmM9SWU
         6Icw==
X-Gm-Message-State: AOJu0YwYcyusNwSpIhpn28qU5dxguLRGUpWttKAe/eciU/aFzyrL9iQJ
	eEm7aFnbCZ6t1b8DOYzhV52JznPESzKzHw6XeFewvFRq9XGAll+vdHPqfYow2i/B4jYOGuyfw7z
	q7t8h0JkcBs1+KxT8LJ7RTcJiMr92EIp1MzRxeGCZIOuJ25lWtaq3NhlMjF/+J7DJDdDNRgMx8f
	IeLUU0ndfim79Vqu+PcXovXmlr41U3JH+ndXK3lP1TUQZfUg==
X-Google-Smtp-Source: AGHT+IFEPXf/Mt+Lxupw8oElteSR68csVTfxhv8Ao5MIFQc5+2vOisI5ACmq74jcfR3FVUwMpkznpQSdMVBE
X-Received: from pgh12.prod.google.com ([2002:a05:6a02:4e0c:b0:af2:448e:a04d])
 (user=dhavale job=prod-delivery.src-stubby-dispatcher) by 2002:a05:6a21:9202:b0:1f5:6e00:14db
 with SMTP id adf61e73a8af0-2009f5fd679mr12747317637.14.1743387630666; Sun, 30
 Mar 2025 19:20:30 -0700 (PDT)
Date: Sun, 30 Mar 2025 19:20:08 -0700
In-Reply-To: <20250331022011.645533-1-dhavale@google.com>
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
References: <20250331022011.645533-1-dhavale@google.com>
X-Mailer: git-send-email 2.49.0.472.ge94155a9ec-goog
Message-ID: <20250331022011.645533-2-dhavale@google.com>
Subject: [PATCH v1 1/1] erofs: lazily initialize per-CPU workers and CPU
 hotplug hooks
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

Defer initialization of per-CPU workers and registration for CPU hotplug
events until the first mount. Similarly, unregister from hotplug events
and destroy per-CPU workers when the last mount is unmounted.

Signed-off-by: Sandeep Dhavale <dhavale@google.com>
---
 fs/erofs/internal.h |  5 +++++
 fs/erofs/super.c    | 27 +++++++++++++++++++++++++++
 fs/erofs/zdata.c    | 35 +++++++++++++++++++++++------------
 3 files changed, 55 insertions(+), 12 deletions(-)

diff --git a/fs/erofs/internal.h b/fs/erofs/internal.h
index 4ac188d5d894..c88cba4da3eb 100644
--- a/fs/erofs/internal.h
+++ b/fs/erofs/internal.h
@@ -450,6 +450,8 @@ int z_erofs_gbuf_growsize(unsigned int nrpages);
 int __init z_erofs_gbuf_init(void);
 void z_erofs_gbuf_exit(void);
 int z_erofs_parse_cfgs(struct super_block *sb, struct erofs_super_block *dsb);
+int z_erofs_init_workers(void);
+void z_erofs_destroy_workers(void);
 #else
 static inline void erofs_shrinker_register(struct super_block *sb) {}
 static inline void erofs_shrinker_unregister(struct super_block *sb) {}
@@ -458,6 +460,9 @@ static inline void erofs_exit_shrinker(void) {}
 static inline int z_erofs_init_subsystem(void) { return 0; }
 static inline void z_erofs_exit_subsystem(void) {}
 static inline int z_erofs_init_super(struct super_block *sb) { return 0; }
+static inline int z_erofs_init_workers(void) { return 0; };
+static inline  z_erofs_exit_workers(void);
+
 #endif	/* !CONFIG_EROFS_FS_ZIP */
 
 #ifdef CONFIG_EROFS_FS_BACKED_BY_FILE
diff --git a/fs/erofs/super.c b/fs/erofs/super.c
index cadec6b1b554..8e8d3a7c8dba 100644
--- a/fs/erofs/super.c
+++ b/fs/erofs/super.c
@@ -17,6 +17,7 @@
 #include <trace/events/erofs.h>
 
 static struct kmem_cache *erofs_inode_cachep __read_mostly;
+static atomic_t erofs_mount_count = ATOMIC_INIT(0);
 
 void _erofs_printk(struct super_block *sb, const char *fmt, ...)
 {
@@ -777,9 +778,28 @@ static const struct fs_context_operations erofs_context_ops = {
 	.free		= erofs_fc_free,
 };
 
+static inline int erofs_init_zip_workers_if_needed(void)
+{
+	int ret;
+
+	if (atomic_inc_return(&erofs_mount_count) == 1) {
+		ret = z_erofs_init_workers();
+		if (ret)
+			return ret;
+	}
+	return 0;
+}
+
+static inline void erofs_destroy_zip_workers_if_last(void)
+{
+	if (atomic_dec_and_test(&erofs_mount_count))
+		z_erofs_destroy_workers();
+}
+
 static int erofs_init_fs_context(struct fs_context *fc)
 {
 	struct erofs_sb_info *sbi;
+	int err;
 
 	sbi = kzalloc(sizeof(*sbi), GFP_KERNEL);
 	if (!sbi)
@@ -790,6 +810,12 @@ static int erofs_init_fs_context(struct fs_context *fc)
 		kfree(sbi);
 		return -ENOMEM;
 	}
+	err = erofs_init_zip_workers_if_needed();
+	if (err) {
+		kfree(sbi->devs);
+		kfree(sbi);
+		return err;
+	}
 	fc->s_fs_info = sbi;
 
 	idr_init(&sbi->devs->tree);
@@ -823,6 +849,7 @@ static void erofs_kill_sb(struct super_block *sb)
 	erofs_fscache_unregister_fs(sb);
 	erofs_sb_free(sbi);
 	sb->s_fs_info = NULL;
+	erofs_destroy_zip_workers_if_last();
 }
 
 static void erofs_put_super(struct super_block *sb)
diff --git a/fs/erofs/zdata.c b/fs/erofs/zdata.c
index 0671184d9cf1..4cd91b798716 100644
--- a/fs/erofs/zdata.c
+++ b/fs/erofs/zdata.c
@@ -403,10 +403,32 @@ static inline int erofs_cpu_hotplug_init(void) { return 0; }
 static inline void erofs_cpu_hotplug_destroy(void) {}
 #endif
 
-void z_erofs_exit_subsystem(void)
+int z_erofs_init_workers(void)
+{
+	int err;
+
+	err = erofs_init_percpu_workers();
+	if (err)
+		return err;
+
+	err = erofs_cpu_hotplug_init();
+	if (err < 0)
+		goto err_cpuhp_init;
+	return err;
+
+err_cpuhp_init:
+	erofs_destroy_percpu_workers();
+	return err;
+}
+
+void z_erofs_destroy_workers(void)
 {
 	erofs_cpu_hotplug_destroy();
 	erofs_destroy_percpu_workers();
+}
+
+void z_erofs_exit_subsystem(void)
+{
 	destroy_workqueue(z_erofs_workqueue);
 	z_erofs_destroy_pcluster_pool();
 	z_erofs_exit_decompressor();
@@ -430,19 +452,8 @@ int __init z_erofs_init_subsystem(void)
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
-- 
2.49.0.472.ge94155a9ec-goog


