Return-Path: <linux-erofs+bounces-114-lists+linux-erofs=lfdr.de@lists.ozlabs.org>
X-Original-To: lists+linux-erofs@lfdr.de
Delivered-To: lists+linux-erofs@lfdr.de
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2404:9400:2:0:216:3eff:fee1:b9f1])
	by mail.lfdr.de (Postfix) with ESMTPS id 0DC1CA6CC73
	for <lists+linux-erofs@lfdr.de>; Sat, 22 Mar 2025 21:44:07 +0100 (CET)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4ZKrrb0FHRz2yd7;
	Sun, 23 Mar 2025 07:43:59 +1100 (AEDT)
X-Original-To: linux-erofs@lists.ozlabs.org
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip=172.234.252.31
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1742676238;
	cv=none; b=j50Wk8Yk2pU4JukMHMmn1KHzCDi+3YpyQxNGlvBHOoedNcrUV4u6fjA4URwQ7jqXkWgoylKCnf1WG4pped+jDykjQWjTBO6KUKoS6ERfIdmwquU5OnQHFr10pK635Ruy86fWDFQ78fP5e6kcFZugsDnMQkXyq//ejbhvtYTU1NIfKbU+zTmt1xgXR2PZlU1uuJd1+odGp7GstXEVDaSUciIKc83lacTFXZo388rd5HNr/uO6iKv0DjLYBFnd+NjeRNuyJDGwUUxiu6HQ5ohemaGgofQXKipKrc+um86N/22yO4uZupLzhYzygLpJEN5t1PSX7uuF7+oA5fu7CRf4ZQ==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1742676238; c=relaxed/relaxed;
	bh=wRynNQpOron2dOwaxm8ZBzRWJhfAvYCDYWPd0viM9X8=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=fyuGFSPDMyekLXOb3hVPCDKuwtJ/mEWUTyEGIwjiY2SXiSMPAEPR4bzeHeA6NXGsI4ICa5b9QqvkRtBWwXfZkWW4BifeV7zMonje4Io53fL1sERK0OS2I7T4fsn7sGSR4iVsRmysYSq+/s9ikQ++vc4clN8tGfjPk0E1xkY7kF7QrD9WOBfvidPGedZE7n838Es/+qhhrhNGQduJZxcoBJ881dxwaNjU0C6cZIdQAw8L9CeETTSaw3v7iw3wm31T9hGx1joaaeUe2XuTaPHso02/XEhRy4ofHXLdUZnUxkh2eCrHFH0NWB9zcP0dOwX7fR91YYzRG+tHKLmMhHVGNA==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=kernel.org; dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20201202 header.b=R/wc4fVk; dkim-atps=neutral; spf=pass (client-ip=172.234.252.31; helo=sea.source.kernel.org; envelope-from=devnull+julian.stecklina.cyberus-technology.de@kernel.org; receiver=lists.ozlabs.org) smtp.mailfrom=kernel.org
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=kernel.org
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20201202 header.b=R/wc4fVk;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=kernel.org (client-ip=172.234.252.31; helo=sea.source.kernel.org; envelope-from=devnull+julian.stecklina.cyberus-technology.de@kernel.org; receiver=lists.ozlabs.org)
Received: from sea.source.kernel.org (sea.source.kernel.org [172.234.252.31])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits))
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4ZKrrX6hHCz2ydQ
	for <linux-erofs@lists.ozlabs.org>; Sun, 23 Mar 2025 07:43:56 +1100 (AEDT)
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
	by sea.source.kernel.org (Postfix) with ESMTP id AAB1A44030;
	Sat, 22 Mar 2025 20:35:15 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id 7E4A6C4CEFF;
	Sat, 22 Mar 2025 20:35:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1742675715;
	bh=CGLJl1zEmiCISwzcev9qeEVvn+4xnW6/oap/uXff3ko=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:Reply-To:From;
	b=R/wc4fVkDIP+pjdeKOjGNRZlhkfRErVXjcoSVJkAhNbpwZ7QyIZbx7sZkeWvbAKai
	 qNNZJNjqbFbJwBxL17trCKvX4uSpPJ7FY4XcWNwa5Bt69/64flpcJJii0vwObyEGUO
	 hXiat1wm3Xg47MSjjy81dVhNZFqjdoyqVnPhgS8fJ9nvnQogvvoV685Y+VEgaH7F85
	 Xc3nguWyTFepgiPs+xAypo+L1hJNwOdh4iEA/AnGdbvegrCmOlUGQBappo7Nv0Js4w
	 W5pJHoaxRrkwp23ExdBNbxOAUxhSWDL5PjCsne5KyKh97YafvB2z5LqqEh8+w3b81e
	 wXKu7gJ3DSVAw==
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7241DC35FFC;
	Sat, 22 Mar 2025 20:35:15 +0000 (UTC)
From: Julian Stecklina via B4 Relay <devnull+julian.stecklina.cyberus-technology.de@kernel.org>
Date: Sat, 22 Mar 2025 21:34:19 +0100
Subject: [PATCH v2 7/9] fs: squashfs: register an initrd fs detector
X-Mailing-List: linux-erofs@lists.ozlabs.org
List-Id: <linux-erofs.lists.ozlabs.org>
List-Help: <mailto:linux-erofs+help@lists.ozlabs.org>
List-Owner: <mailto:linux-erofs+owner@lists.ozlabs.org>
List-Post: <mailto:linux-erofs@lists.ozlabs.org>
List-Subscribe: <mailto:linux-erofs+subscribe@lists.ozlabs.org>,
  <mailto:linux-erofs+subscribe-digest@lists.ozlabs.org>,
  <mailto:linux-erofs+subscribe-nomail@lists.ozlabs.org>
List-Unsubscribe: <mailto:linux-erofs+unsubscribe@lists.ozlabs.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250322-initrd-erofs-v2-7-d66ee4a2c756@cyberus-technology.de>
References: <20250322-initrd-erofs-v2-0-d66ee4a2c756@cyberus-technology.de>
In-Reply-To: <20250322-initrd-erofs-v2-0-d66ee4a2c756@cyberus-technology.de>
To: Christoph Hellwig <hch@lst.de>, Al Viro <viro@zeniv.linux.org.uk>, 
 Christian Brauner <brauner@kernel.org>
Cc: Linus Torvalds <torvalds@linux-foundation.org>, 
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>, 
 "Rafael J. Wysocki" <rafael@kernel.org>, Gao Xiang <xiang@kernel.org>, 
 linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org, 
 linux-erofs@lists.ozlabs.org, 
 Julian Stecklina <julian.stecklina@cyberus-technology.de>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1742675713; l=3201;
 i=julian.stecklina@cyberus-technology.de; s=20250320;
 h=from:subject:message-id;
 bh=zysxuXEy456UHMgFgfSEAGox0ynSn0NVemXDz0PKiSU=;
 b=nZrNbSLcFivZ71KUl0X/nNQRHCoVKonroEdGfu+uTmwQBjJeOyVqHGkumj6SPGTNn0sy1YrD3
 ejVMVfXX5AHAbW52Bbp6N3qM1+EdspO5bbB9w5pauYrKxkHm/r0zGG2
X-Developer-Key: i=julian.stecklina@cyberus-technology.de; a=ed25519;
 pk=m051/8gQfs5AmkACfykwRcD6CUr2T7DQ9OA5eBgyy7c=
X-Endpoint-Received: by B4 Relay for
 julian.stecklina@cyberus-technology.de/20250320 with auth_id=363
X-Original-From: Julian Stecklina <julian.stecklina@cyberus-technology.de>
Reply-To: julian.stecklina@cyberus-technology.de
X-Spam-Status: No, score=-1.2 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS
	autolearn=disabled version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-25) on lists.ozlabs.org

From: Julian Stecklina <julian.stecklina@cyberus-technology.de>

Port squashfs from to the new initrd_fs_detect API. There are no
functional changes.

Signed-off-by: Julian Stecklina <julian.stecklina@cyberus-technology.de>
---
 fs/squashfs/Makefile |  5 +++++
 fs/squashfs/initrd.c | 23 +++++++++++++++++++++++
 init/do_mounts_rd.c  | 14 --------------
 3 files changed, 28 insertions(+), 14 deletions(-)

diff --git a/fs/squashfs/Makefile b/fs/squashfs/Makefile
index 477c89a519ee8825e4dfc88f76e09fd733e90625..fa64f0b9a45e52e9b3e78bd16446474c0b3dc158 100644
--- a/fs/squashfs/Makefile
+++ b/fs/squashfs/Makefile
@@ -17,3 +17,8 @@ squashfs-$(CONFIG_SQUASHFS_LZO) += lzo_wrapper.o
 squashfs-$(CONFIG_SQUASHFS_XZ) += xz_wrapper.o
 squashfs-$(CONFIG_SQUASHFS_ZLIB) += zlib_wrapper.o
 squashfs-$(CONFIG_SQUASHFS_ZSTD) += zstd_wrapper.o
+
+# If we are built-in, we provide support for squashfs on initrds.
+ifeq ($(CONFIG_SQUASHFS),y)
+squashfs-y += initrd.o
+endif
diff --git a/fs/squashfs/initrd.c b/fs/squashfs/initrd.c
new file mode 100644
index 0000000000000000000000000000000000000000..bb99fc40083c6c5fdf47b2e28bcdc525d36520b4
--- /dev/null
+++ b/fs/squashfs/initrd.c
@@ -0,0 +1,23 @@
+// SPDX-License-Identifier: GPL-2.0-only
+
+#include <linux/initrd.h>
+#include <linux/fs.h>
+#include <linux/magic.h>
+
+#include "squashfs_fs.h"
+
+static size_t __init detect_squashfs(void *block_data)
+{
+	struct squashfs_super_block *squashfsb
+		= (struct squashfs_super_block *)block_data;
+	BUILD_BUG_ON(sizeof(*squashfsb) > BLOCK_SIZE);
+
+		/* squashfs is at block zero too */
+	if (le32_to_cpu(squashfsb->s_magic) != SQUASHFS_MAGIC)
+		return 0;
+
+
+	return le64_to_cpu(squashfsb->bytes_used);
+}
+
+initrd_fs_detect(detect_squashfs, 0);
diff --git a/init/do_mounts_rd.c b/init/do_mounts_rd.c
index 9f9a04cce505e532d444e2aef77037bc2b01da08..2a6cb08d0b4872ef8e861a813ef89dc1e9a150af 100644
--- a/init/do_mounts_rd.c
+++ b/init/do_mounts_rd.c
@@ -8,7 +8,6 @@
 #include <linux/slab.h>
 
 #include "do_mounts.h"
-#include "../fs/squashfs/squashfs_fs.h"
 
 #include <linux/decompress/generic.h>
 
@@ -41,7 +40,6 @@ static int __init crd_load(decompress_fn deco);
  *
  * We currently check for the following magic numbers:
  *	ext2
- *	squashfs
  *	gzip
  *	bzip2
  *	lzma
@@ -55,7 +53,6 @@ identify_ramdisk_image(struct file *file, loff_t pos,
 {
 	const int size = BLOCK_SIZE;
 
-	struct squashfs_super_block *squashfsb;
 	int nblocks = -1;
 	unsigned char *buf;
 	const char *compress_name;
@@ -67,7 +64,6 @@ identify_ramdisk_image(struct file *file, loff_t pos,
 	if (!buf)
 		return -ENOMEM;
 
-	squashfsb = (struct squashfs_super_block *) buf;
 	memset(buf, 0xe5, size);
 
 	/*
@@ -88,16 +84,6 @@ identify_ramdisk_image(struct file *file, loff_t pos,
 		goto done;
 	}
 
-	/* squashfs is at block zero too */
-	if (le32_to_cpu(squashfsb->s_magic) == SQUASHFS_MAGIC) {
-		printk(KERN_NOTICE
-		       "RAMDISK: squashfs filesystem found at block %d\n",
-		       start_block);
-		nblocks = (le64_to_cpu(squashfsb->bytes_used) + BLOCK_SIZE - 1)
-			 >> BLOCK_SIZE_BITS;
-		goto done;
-	}
-
 	/*
 	 * Read block 1 to test for ext2 superblock
 	 */

-- 
2.47.0



