Return-Path: <linux-erofs+bounces-1556-lists+linux-erofs=lfdr.de@lists.ozlabs.org>
X-Original-To: lists+linux-erofs@lfdr.de
Delivered-To: lists+linux-erofs@lfdr.de
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	by mail.lfdr.de (Postfix) with ESMTPS id 24EC0CD8729
	for <lists+linux-erofs@lfdr.de>; Tue, 23 Dec 2025 09:30:45 +0100 (CET)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4db7W50DMGz2xlP;
	Tue, 23 Dec 2025 19:30:41 +1100 (AEDT)
X-Original-To: linux-erofs@lists.ozlabs.org
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip=115.124.30.99
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1766478640;
	cv=none; b=S7tpC0OonqcPHE+ZVsxfLcivCDYwH2yOxqyr1sE6eKcXWPvi25hYlr3yvrwls9PqUp7Q/q3ORFsUigq51H0tYOGyNaP1q5RWnX0S0w/sM2b2RC+8R+I1OXvePAlSyNtXAkiAR/Lb3hxVeuc3IQrwgOum2sx1sfDV+TI4Mch53GtHZz/kBt/5jcRyONldQZC7SdubbwkE1V5dQNKBvnemJvB/uIBJv21m8rK9aLdGrAPPC6nnZ4F4gVmg1MrQuIe0hz8UFIbxSXgEqBdjc43iCcLbHVRTFshQI13WTfymNUttseXcRrgPalJ6GQtZBRw/JFS4ARVnevEsrX+0zCbZ6w==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1766478640; c=relaxed/relaxed;
	bh=7NSX3ycYQmxGLNK4vFDMYYQPstREQCLVPQ9/mSmRTFU=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=D0PCM987+pbZINMBw8Q3P9LOMHyTsc+h8Kum9waaRijqYouRrm4BPy0NEjL/XYFT05IRkPQTxZEfOzGkVvjvxG9GSAfzdNlaDLd3ET+QzT3PMo3i/5aD3jdVfJ/JC6K6u4bah8qrRw8ljxoMzOp74Dgn5Xf7jK45dq8jBHcwO1J8kaVeTDWJKHkSsa79tLYWXrqkoDeJ3feHUUl4xNxyd8ph00GxEZX4deu3RbphldzZcWSbDYYHy/G2n2KstuIXBq+zJWFVv6F7Pbc72R0HG/pqKhjFr3eBt5uJUwLNO4bM7/PIuG6iNrf4mO8nOG2fUj6oFa8S33btIIqDfLKASg==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com; dkim=pass (1024-bit key; unprotected) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.a=rsa-sha256 header.s=default header.b=sdESPZwN; dkim-atps=neutral; spf=pass (client-ip=115.124.30.99; helo=out30-99.freemail.mail.aliyun.com; envelope-from=hsiangkao@linux.alibaba.com; receiver=lists.ozlabs.org) smtp.mailfrom=linux.alibaba.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (1024-bit key; unprotected) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.a=rsa-sha256 header.s=default header.b=sdESPZwN;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=linux.alibaba.com (client-ip=115.124.30.99; helo=out30-99.freemail.mail.aliyun.com; envelope-from=hsiangkao@linux.alibaba.com; receiver=lists.ozlabs.org)
Received: from out30-99.freemail.mail.aliyun.com (out30-99.freemail.mail.aliyun.com [115.124.30.99])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4db7W24xktz2xQK
	for <linux-erofs@lists.ozlabs.org>; Tue, 23 Dec 2025 19:30:36 +1100 (AEDT)
DKIM-Signature:v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=linux.alibaba.com; s=default;
	t=1766478630; h=Message-ID:Date:MIME-Version:Subject:To:From:Content-Type;
	bh=7NSX3ycYQmxGLNK4vFDMYYQPstREQCLVPQ9/mSmRTFU=;
	b=sdESPZwNcuD0VZCL+jkELac2nHcVDpSkJxVAKgcLOMwxn63YxeTbDqR/XP7nWbaaGH1iVPEZIJn1uShRQH6C7HT9MGdY4qLtZvN4Sl4PaePBN7xj3a/+M+u950ImAyUHfL5QjwkHteGaNkYn2RRPtaqbfg4uS7wlRm1ZacECc1Q=
Received: from 30.221.131.244(mailfrom:hsiangkao@linux.alibaba.com fp:SMTPD_---0WvX6LtN_1766478629 cluster:ay36)
          by smtp.aliyun-inc.com;
          Tue, 23 Dec 2025 16:30:30 +0800
Message-ID: <79c97f96-bb07-46f3-8c9a-5e3c867f6cab@linux.alibaba.com>
Date: Tue, 23 Dec 2025 16:30:29 +0800
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
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v10 04/10] erofs: move `struct erofs_anon_fs_type` to
 super.c
To: Hongbo Li <lihongbo22@huawei.com>
Cc: linux-fsdevel@vger.kernel.org, linux-erofs@lists.ozlabs.org,
 linux-kernel@vger.kernel.org, Chao Yu <chao@kernel.org>,
 Christian Brauner <brauner@kernel.org>, "Darrick J. Wong"
 <djwong@kernel.org>, Amir Goldstein <amir73il@gmail.com>,
 Christoph Hellwig <hch@lst.de>
References: <20251223015618.485626-1-lihongbo22@huawei.com>
 <20251223015618.485626-5-lihongbo22@huawei.com>
From: Gao Xiang <hsiangkao@linux.alibaba.com>
In-Reply-To: <20251223015618.485626-5-lihongbo22@huawei.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-15.7 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,DKIM_VALID_EF,ENV_AND_HDR_SPF_MATCH,RCVD_IN_DNSWL_NONE,
	SPF_HELO_NONE,SPF_PASS,UNPARSEABLE_RELAY,USER_IN_DEF_DKIM_WL,
	USER_IN_DEF_SPF_WL autolearn=disabled version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-25) on lists.ozlabs.org



On 2025/12/23 09:56, Hongbo Li wrote:
> From: Hongzhen Luo <hongzhen@linux.alibaba.com>
> 
> Move the `struct erofs_anon_fs_type` to the super.c and
> expose it in preparation for the upcoming page cache share
> feature.
> 
> Signed-off-by: Hongzhen Luo <hongzhen@linux.alibaba.com>
> Signed-off-by: Hongbo Li <lihongbo22@huawei.com>

Can you just replace this one with the following patch?


From: Gao Xiang <hsiangkao@linux.alibaba.com>
Date: Tue, 23 Dec 2025 16:27:17 +0800
Subject: [PATCH] erofs: decouple `struct erofs_anon_fs_type`

  - Move the `struct erofs_anon_fs_type` to super.c and expose it
    in preparation for the upcoming page cache share feature;

  - Remove the `.owner` field, as they are all internal mounts and
    fully managed by EROFS.  Retaining `.owner` would unnecessarily
    increment module reference counts, preventing the EROFS kernel
    module from being unloaded.

Signed-off-by: Gao Xiang <hsiangkao@linux.alibaba.com>
---
  fs/erofs/fscache.c  | 13 -------------
  fs/erofs/internal.h |  2 ++
  fs/erofs/super.c    | 14 ++++++++++++++
  3 files changed, 16 insertions(+), 13 deletions(-)

diff --git a/fs/erofs/fscache.c b/fs/erofs/fscache.c
index 7a346e20f7b7..f4937b025038 100644
--- a/fs/erofs/fscache.c
+++ b/fs/erofs/fscache.c
@@ -3,7 +3,6 @@
   * Copyright (C) 2022, Alibaba Cloud
   * Copyright (C) 2022, Bytedance Inc. All rights reserved.
   */
-#include <linux/pseudo_fs.h>
  #include <linux/fscache.h>
  #include "internal.h"

@@ -13,18 +12,6 @@ static LIST_HEAD(erofs_domain_list);
  static LIST_HEAD(erofs_domain_cookies_list);
  static struct vfsmount *erofs_pseudo_mnt;

-static int erofs_anon_init_fs_context(struct fs_context *fc)
-{
-	return init_pseudo(fc, EROFS_SUPER_MAGIC) ? 0 : -ENOMEM;
-}
-
-static struct file_system_type erofs_anon_fs_type = {
-	.owner		= THIS_MODULE,
-	.name           = "pseudo_erofs",
-	.init_fs_context = erofs_anon_init_fs_context,
-	.kill_sb        = kill_anon_super,
-};
-
  struct erofs_fscache_io {
  	struct netfs_cache_resources cres;
  	struct iov_iter		iter;
diff --git a/fs/erofs/internal.h b/fs/erofs/internal.h
index f7f622836198..98fe652aea33 100644
--- a/fs/erofs/internal.h
+++ b/fs/erofs/internal.h
@@ -188,6 +188,8 @@ static inline bool erofs_is_fileio_mode(struct erofs_sb_info *sbi)
  	return IS_ENABLED(CONFIG_EROFS_FS_BACKED_BY_FILE) && sbi->dif0.file;
  }

+extern struct file_system_type erofs_anon_fs_type;
+
  static inline bool erofs_is_fscache_mode(struct super_block *sb)
  {
  	return IS_ENABLED(CONFIG_EROFS_FS_ONDEMAND) &&
diff --git a/fs/erofs/super.c b/fs/erofs/super.c
index 937a215f626c..f18f43b78fca 100644
--- a/fs/erofs/super.c
+++ b/fs/erofs/super.c
@@ -11,6 +11,7 @@
  #include <linux/fs_parser.h>
  #include <linux/exportfs.h>
  #include <linux/backing-dev.h>
+#include <linux/pseudo_fs.h>
  #include "xattr.h"

  #define CREATE_TRACE_POINTS
@@ -936,6 +937,19 @@ static struct file_system_type erofs_fs_type = {
  };
  MODULE_ALIAS_FS("erofs");

+#if defined(CONFIG_EROFS_FS_ONDEMAND)
+static int erofs_anon_init_fs_context(struct fs_context *fc)
+{
+	return init_pseudo(fc, EROFS_SUPER_MAGIC) ? 0 : -ENOMEM;
+}
+
+struct file_system_type erofs_anon_fs_type = {
+	.name           = "pseudo_erofs",
+	.init_fs_context = erofs_anon_init_fs_context,
+	.kill_sb        = kill_anon_super,
+};
+#endif
+
  static int __init erofs_module_init(void)
  {
  	int err;
--
2.43.5


