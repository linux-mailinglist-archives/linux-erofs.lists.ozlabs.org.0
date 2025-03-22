Return-Path: <linux-erofs+bounces-112-lists+linux-erofs=lfdr.de@lists.ozlabs.org>
X-Original-To: lists+linux-erofs@lfdr.de
Delivered-To: lists+linux-erofs@lfdr.de
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2404:9400:2:0:216:3eff:fee1:b9f1])
	by mail.lfdr.de (Postfix) with ESMTPS id B17D2A6CC71
	for <lists+linux-erofs@lfdr.de>; Sat, 22 Mar 2025 21:44:03 +0100 (CET)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4ZKrrZ5W0Tz2ySl;
	Sun, 23 Mar 2025 07:43:58 +1100 (AEDT)
X-Original-To: linux-erofs@lists.ozlabs.org
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip="2600:3c0a:e001:78e:0:1991:8:25"
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1742676238;
	cv=none; b=lwiFaR0BKi3viAf84IfxqsPgzboMJdj9DS8mM6L1i2DTw/jJTDxMWG+/9rSlxdJfSinN9PCP1dwFmd65FbQ7lf2cma10NA5tetAcJERYOqOaBDpLxuoZw9zuLnkAduK2q9k3RFQ9WX8Rdnx2AK2zmc76bG25VoQdIoUzzYDKzUiaZFDwKqXRMzhrJ2P0RWDL76SQ86bzdKfYdr9R2W2E74H4e9C5djn1aJqvpzVHypoxO0q4ygjFVCXpHzaGCYFHF9swO6fLK1XP0EcDkQmOgl5YtaABF7FaRJ6vVIF8scZbM8kSGfp0mkf8suZ7jXkTI0BuccWnsDXAS9IEHoT1Kw==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1742676238; c=relaxed/relaxed;
	bh=8UP0ZLU/+R+1uLPLB7x2N1pkVLWfZ5ygOssdp7xrBJ4=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=GCLQESE6YMQlTs21GoDAZ3CCZvMDr1a7K3oMQ7j1yTCWdyX04YWN+A506F7agqfOMqKJTXx56u26vkcBRWycJe8g8IwzYzJJEENuYcd1aEZTPKcN9Dj6Uj9O84rk41/2ZcaUOl/hG1aq39RVKSFDO5npoOWiyD8CP2Evg/3sw2qrnlnO5+WvjQe98ZFM+LYUVGrc0YFj8S8wAGHYTMZy1oxdPzOZL0ahIcX1IL9KaJzOwLlyJ5qyBPfrznTuqzsCYYf340+ZsjCz9lyPZK3SzqiZ4qeJegCSv6YHbcIJ1VrQMJeI61x1jZ6TRz6ja7z1E8J0dLez+qcDCAd4rosSIA==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=kernel.org; dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20201202 header.b=oXfCiNhP; dkim-atps=neutral; spf=pass (client-ip=2600:3c0a:e001:78e:0:1991:8:25; helo=sea.source.kernel.org; envelope-from=devnull+julian.stecklina.cyberus-technology.de@kernel.org; receiver=lists.ozlabs.org) smtp.mailfrom=kernel.org
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=kernel.org
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20201202 header.b=oXfCiNhP;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=kernel.org (client-ip=2600:3c0a:e001:78e:0:1991:8:25; helo=sea.source.kernel.org; envelope-from=devnull+julian.stecklina.cyberus-technology.de@kernel.org; receiver=lists.ozlabs.org)
X-Greylist: delayed 518 seconds by postgrey-1.37 at boromir; Sun, 23 Mar 2025 07:43:56 AEDT
Received: from sea.source.kernel.org (sea.source.kernel.org [IPv6:2600:3c0a:e001:78e:0:1991:8:25])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits))
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4ZKrrX5dBnz2yd7
	for <linux-erofs@lists.ozlabs.org>; Sun, 23 Mar 2025 07:43:56 +1100 (AEDT)
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
	by sea.source.kernel.org (Postfix) with ESMTP id 9CC0A44021;
	Sat, 22 Mar 2025 20:35:15 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id 6B947C4CEFD;
	Sat, 22 Mar 2025 20:35:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1742675715;
	bh=WxuPWwzWQb6OHqAvqAIEXUyCRmvLthXZsVF3HZREUFs=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:Reply-To:From;
	b=oXfCiNhP3/PFBFCePwmcQkQjbUbkzbCpLxSUtIZB/l2qkM/BghyAMKt00hsqBJRPl
	 NZGX9ezmHU04ao2mu8uowtv/4s1bFGoR2pJ1r+6hWhX4++T7MYf2Rr4ASycPod+YaQ
	 jTwJ5GVQjGmxTl8/dwFns9bRFOW3A8CHDB3BQ79z25cDnSMZKTvdkZnJS3PmkD4yMc
	 9R4jBBl/ZMBMD0BDypQSa+itA7eG01zPjwIpSN7N+cf84bY4Qeen+wtJZMdpbYg1f+
	 rVJop+DdLD8jgFB2y/3USfjraPlGpG88pLV4/MP0LODoOfxYBmDH2ZZU9xrKVjh+x7
	 N7l7rQycJBXqg==
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 61DFFC3600B;
	Sat, 22 Mar 2025 20:35:15 +0000 (UTC)
From: Julian Stecklina via B4 Relay <devnull+julian.stecklina.cyberus-technology.de@kernel.org>
Date: Sat, 22 Mar 2025 21:34:18 +0100
Subject: [PATCH v2 6/9] fs: romfs: register an initrd fs detector
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
Message-Id: <20250322-initrd-erofs-v2-6-d66ee4a2c756@cyberus-technology.de>
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
X-Developer-Signature: v=1; a=ed25519-sha256; t=1742675713; l=3189;
 i=julian.stecklina@cyberus-technology.de; s=20250320;
 h=from:subject:message-id;
 bh=DjTVlMjJ9fly1JjbbQ1cABQpspedV4SfXIZDQ9hYyJw=;
 b=bYQM009Se+/99LClCNXj1HPpoPjNjrjKzdTybPVuJsdmCzDLeuSC5fNA+iESxAR+1ZgnWKYDX
 Ev6I3qHnmlqAj9w8p+pdBCatDMx3r8QKy5KB7shQWM2fafgd9gjbT/5
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

Port romfs from to the new initrd_fs_detect API. There are no
functional changes.

Signed-off-by: Julian Stecklina <julian.stecklina@cyberus-technology.de>
---
 fs/romfs/Makefile   |  4 ++++
 fs/romfs/initrd.c   | 22 ++++++++++++++++++++++
 init/do_mounts_rd.c | 14 --------------
 3 files changed, 26 insertions(+), 14 deletions(-)

diff --git a/fs/romfs/Makefile b/fs/romfs/Makefile
index 844928f1571160abed9d5aff54152b5508eaf7be..eb15dc3a78721d7f650560a404a92706260e9b63 100644
--- a/fs/romfs/Makefile
+++ b/fs/romfs/Makefile
@@ -11,3 +11,7 @@ ifneq ($(CONFIG_MMU),y)
 romfs-$(CONFIG_ROMFS_ON_MTD) += mmap-nommu.o
 endif
 
+# If we are built-in, we provide support for romfs on initrds.
+ifeq ($(CONFIG_ROMFS_FS),y)
+romfs-y += initrd.o
+endif
diff --git a/fs/romfs/initrd.c b/fs/romfs/initrd.c
new file mode 100644
index 0000000000000000000000000000000000000000..0ec7b4c9d1f79fac892b7fb1d8e17122092008a8
--- /dev/null
+++ b/fs/romfs/initrd.c
@@ -0,0 +1,22 @@
+// SPDX-License-Identifier: GPL-2.0-only
+
+#include <linux/fs.h>
+#include <linux/initrd.h>
+#include <linux/magic.h>
+#include <linux/romfs_fs.h>
+
+static size_t __init detect_romfs(void *block_data)
+{
+	struct romfs_super_block *romfsb
+		= (struct romfs_super_block *)block_data;
+	BUILD_BUG_ON(sizeof(*romfsb) > BLOCK_SIZE);
+
+	/* The definitions of ROMSB_WORD* already handle endianness. */
+	if (romfsb->word0 != ROMSB_WORD0 ||
+	    romfsb->word1 != ROMSB_WORD1)
+		return 0;
+
+	return be32_to_cpu(romfsb->size);
+}
+
+initrd_fs_detect(detect_romfs, 0);
diff --git a/init/do_mounts_rd.c b/init/do_mounts_rd.c
index cdc39baaf3a1a65daad5fe6571a82faf3fc95b62..9f9a04cce505e532d444e2aef77037bc2b01da08 100644
--- a/init/do_mounts_rd.c
+++ b/init/do_mounts_rd.c
@@ -2,7 +2,6 @@
 #include <linux/kernel.h>
 #include <linux/fs.h>
 #include <linux/ext2_fs.h>
-#include <linux/romfs_fs.h>
 
 #include <linux/initrd.h>
 #include <linux/string.h>
@@ -42,7 +41,6 @@ static int __init crd_load(decompress_fn deco);
  *
  * We currently check for the following magic numbers:
  *	ext2
- *	romfs
  *	squashfs
  *	gzip
  *	bzip2
@@ -56,7 +54,6 @@ identify_ramdisk_image(struct file *file, loff_t pos,
 		decompress_fn *decompressor)
 {
 	const int size = BLOCK_SIZE;
-	struct romfs_super_block *romfsb;
 
 	struct squashfs_super_block *squashfsb;
 	int nblocks = -1;
@@ -70,7 +67,6 @@ identify_ramdisk_image(struct file *file, loff_t pos,
 	if (!buf)
 		return -ENOMEM;
 
-	romfsb = (struct romfs_super_block *) buf;
 	squashfsb = (struct squashfs_super_block *) buf;
 	memset(buf, 0xe5, size);
 
@@ -92,16 +88,6 @@ identify_ramdisk_image(struct file *file, loff_t pos,
 		goto done;
 	}
 
-	/* romfs is at block zero too */
-	if (romfsb->word0 == ROMSB_WORD0 &&
-	    romfsb->word1 == ROMSB_WORD1) {
-		printk(KERN_NOTICE
-		       "RAMDISK: romfs filesystem found at block %d\n",
-		       start_block);
-		nblocks = (ntohl(romfsb->size)+BLOCK_SIZE-1)>>BLOCK_SIZE_BITS;
-		goto done;
-	}
-
 	/* squashfs is at block zero too */
 	if (le32_to_cpu(squashfsb->s_magic) == SQUASHFS_MAGIC) {
 		printk(KERN_NOTICE

-- 
2.47.0



