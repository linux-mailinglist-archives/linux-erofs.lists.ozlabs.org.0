Return-Path: <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>
X-Original-To: lists+linux-erofs@lfdr.de
Delivered-To: lists+linux-erofs@lfdr.de
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2404:9400:2:0:216:3eff:fee1:b9f1])
	by mail.lfdr.de (Postfix) with ESMTPS id CA792764A14
	for <lists+linux-erofs@lfdr.de>; Thu, 27 Jul 2023 10:06:49 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=lists.ozlabs.org;
	s=201707; t=1690445207;
	bh=hMz0NiXWW4aad/y0uXjwCFa/Ag/H17CXQFU4sIH/+zs=;
	h=To:Subject:Date:In-Reply-To:References:List-Id:List-Unsubscribe:
	 List-Archive:List-Post:List-Help:List-Subscribe:From:Reply-To:Cc:
	 From;
	b=Wui67o/YwfzWOIy6/9auuux9D/cs9/gd1qEo71YOPHf4Rq9e4N76h63VQka45Aspd
	 CEoqwFRo2y6I65KreFx3YdR+MZa3Ns6i9XvSPLAcKRWdl2eDOtFZhI0TEfcfnF0nOa
	 6QW1fzrxyN4FGXeJq5/AnOA/KsMaQyWIhyAO13dmHAL/DhnjxFCV5cYPDwCNIfryUL
	 2FNM3VEwEsj95GQNAAOKYgZ5opFE8dWd6+igQRICUPxZy2Higywtf+iL4B9xdYVxZy
	 /HQiirhr9B1t0ZMKNp2d8ioQw/pF8SSLoln//cGaa6YrmmvkX2RN3GrdcGeklySzd1
	 sgOgbaSxljoJQ==
Received: from boromir.ozlabs.org (localhost [IPv6:::1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4RBNdg56BBz3dGM
	for <lists+linux-erofs@lfdr.de>; Thu, 27 Jul 2023 18:06:47 +1000 (AEST)
X-Original-To: linux-erofs@lists.ozlabs.org
Delivered-To: linux-erofs@lists.ozlabs.org
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=bytedance.com header.i=@bytedance.com header.a=rsa-sha256 header.s=google header.b=AHxGvLfH;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=bytedance.com (client-ip=2607:f8b0:4864:20::429; helo=mail-pf1-x429.google.com; envelope-from=zhengqi.arch@bytedance.com; receiver=lists.ozlabs.org)
Received: from mail-pf1-x429.google.com (mail-pf1-x429.google.com [IPv6:2607:f8b0:4864:20::429])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4RBNd21Rs0z3cS5
	for <linux-erofs@lists.ozlabs.org>; Thu, 27 Jul 2023 18:06:13 +1000 (AEST)
Received: by mail-pf1-x429.google.com with SMTP id d2e1a72fcca58-6748a616e17so182238b3a.1
        for <linux-erofs@lists.ozlabs.org>; Thu, 27 Jul 2023 01:06:13 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1690445172; x=1691049972;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=hMz0NiXWW4aad/y0uXjwCFa/Ag/H17CXQFU4sIH/+zs=;
        b=LIGQAhXDpmtHzIu4gFwPS2sJoAjLv7XBnpc/MxqkQzbEuo8J2w4sVomPTOdGsU+inO
         5Pe1RSNo7N5WJ7sILe6BZp2EV45tKsrVMmfWjndPlGU1kw6LQQwk5FCuKK7P6G/MRSId
         QIUb10oyroR4T6E1VAt060oJk0V0Fm6X0QcsXP2Uneyhnt7gDcroo5iiS6peqkL3ZPLk
         qiCjtcpZOUEtKKwd/6wIoIno3zJ94GvxJWaTtcBJ7YHjBi8cG0qXySDU7Ja8e8rkVlM6
         biU3FGmAE6Wu+iKjUqIFflAxZhRxfixXC1cIs1+YtNiqSlDW5SzilMpDO0x+vajuNx2c
         /UFQ==
X-Gm-Message-State: ABy/qLauCoEiIMz/RwbwwG/Fp/v7QGcBNkEGWR5ALWv74rIwSD87VaM8
	Btxj/GC64l1DDJ0AEE4vxrYc9w==
X-Google-Smtp-Source: APBJJlELtr5cWJQ0To//AtRPEOYgFBMbhSo+p4MsXdX0IoPp5bJSVuIL2HKgeywTxbzsVW+qtVe8tQ==
X-Received: by 2002:a05:6a00:4792:b0:668:834d:4bd with SMTP id dh18-20020a056a00479200b00668834d04bdmr4674312pfb.0.1690445172123;
        Thu, 27 Jul 2023 01:06:12 -0700 (PDT)
Received: from C02DW0BEMD6R.bytedance.net ([203.208.167.147])
        by smtp.gmail.com with ESMTPSA id j8-20020aa78d08000000b006828e49c04csm885872pfe.75.2023.07.27.01.06.00
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 27 Jul 2023 01:06:11 -0700 (PDT)
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
Subject: [PATCH v3 02/49] mm: move some shrinker-related function declarations to mm/internal.h
Date: Thu, 27 Jul 2023 16:04:15 +0800
Message-Id: <20230727080502.77895-3-zhengqi.arch@bytedance.com>
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
Cc: kvm@vger.kernel.org, dri-devel@lists.freedesktop.org, virtualization@lists.linux-foundation.org, linux-mm@kvack.org, dm-devel@redhat.com, linux-mtd@lists.infradead.org, x86@kernel.org, cluster-devel@redhat.com, xen-devel@lists.xenproject.org, linux-ext4@vger.kernel.org, linux-arm-msm@vger.kernel.org, rcu@vger.kernel.org, linux-bcache@vger.kernel.org, Qi Zheng <zhengqi.arch@bytedance.com>, linux-raid@vger.kernel.org, linux-nfs@vger.kernel.org, netdev@vger.kernel.org, linux-kernel@vger.kernel.org, linux-f2fs-devel@lists.sourceforge.net, linux-xfs@vger.kernel.org, linux-fsdevel@vger.kernel.org, linux-erofs@lists.ozlabs.org, linux-btrfs@vger.kernel.org
Errors-To: linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org
Sender: "Linux-erofs" <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>

The following functions are only used inside the mm subsystem, so it's
better to move their declarations to the mm/internal.h file.

1. shrinker_debugfs_add()
2. shrinker_debugfs_detach()
3. shrinker_debugfs_remove()

Signed-off-by: Qi Zheng <zhengqi.arch@bytedance.com>
---
 include/linux/shrinker.h | 19 -------------------
 mm/internal.h            | 28 ++++++++++++++++++++++++++++
 2 files changed, 28 insertions(+), 19 deletions(-)

diff --git a/include/linux/shrinker.h b/include/linux/shrinker.h
index 224293b2dd06..8dc15aa37410 100644
--- a/include/linux/shrinker.h
+++ b/include/linux/shrinker.h
@@ -106,28 +106,9 @@ extern void free_prealloced_shrinker(struct shrinker *shrinker);
 extern void synchronize_shrinkers(void);
 
 #ifdef CONFIG_SHRINKER_DEBUG
-extern int shrinker_debugfs_add(struct shrinker *shrinker);
-extern struct dentry *shrinker_debugfs_detach(struct shrinker *shrinker,
-					      int *debugfs_id);
-extern void shrinker_debugfs_remove(struct dentry *debugfs_entry,
-				    int debugfs_id);
 extern int __printf(2, 3) shrinker_debugfs_rename(struct shrinker *shrinker,
 						  const char *fmt, ...);
 #else /* CONFIG_SHRINKER_DEBUG */
-static inline int shrinker_debugfs_add(struct shrinker *shrinker)
-{
-	return 0;
-}
-static inline struct dentry *shrinker_debugfs_detach(struct shrinker *shrinker,
-						     int *debugfs_id)
-{
-	*debugfs_id = -1;
-	return NULL;
-}
-static inline void shrinker_debugfs_remove(struct dentry *debugfs_entry,
-					   int debugfs_id)
-{
-}
 static inline __printf(2, 3)
 int shrinker_debugfs_rename(struct shrinker *shrinker, const char *fmt, ...)
 {
diff --git a/mm/internal.h b/mm/internal.h
index 5a03bc4782a2..8aeaf16ae039 100644
--- a/mm/internal.h
+++ b/mm/internal.h
@@ -1135,4 +1135,32 @@ struct vma_prepare {
 	struct vm_area_struct *remove;
 	struct vm_area_struct *remove2;
 };
+
+/*
+ * shrinker related functions
+ */
+
+#ifdef CONFIG_SHRINKER_DEBUG
+extern int shrinker_debugfs_add(struct shrinker *shrinker);
+extern struct dentry *shrinker_debugfs_detach(struct shrinker *shrinker,
+					      int *debugfs_id);
+extern void shrinker_debugfs_remove(struct dentry *debugfs_entry,
+				    int debugfs_id);
+#else /* CONFIG_SHRINKER_DEBUG */
+static inline int shrinker_debugfs_add(struct shrinker *shrinker)
+{
+	return 0;
+}
+static inline struct dentry *shrinker_debugfs_detach(struct shrinker *shrinker,
+						     int *debugfs_id)
+{
+	*debugfs_id = -1;
+	return NULL;
+}
+static inline void shrinker_debugfs_remove(struct dentry *debugfs_entry,
+					   int debugfs_id)
+{
+}
+#endif /* CONFIG_SHRINKER_DEBUG */
+
 #endif	/* __MM_INTERNAL_H */
-- 
2.30.2

