Return-Path: <linux-erofs+bounces-110-lists+linux-erofs=lfdr.de@lists.ozlabs.org>
X-Original-To: lists+linux-erofs@lfdr.de
Delivered-To: lists+linux-erofs@lfdr.de
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2404:9400:2:0:216:3eff:fee1:b9f1])
	by mail.lfdr.de (Postfix) with ESMTPS id 3BC27A6CC6F
	for <lists+linux-erofs@lfdr.de>; Sat, 22 Mar 2025 21:44:01 +0100 (CET)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4ZKrrY6KMcz2ydq;
	Sun, 23 Mar 2025 07:43:57 +1100 (AEDT)
X-Original-To: linux-erofs@lists.ozlabs.org
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip=172.234.252.31
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1742676237;
	cv=none; b=YvONwFD2xv1i6rIxTjV7dEef3t+rshQGkyb3xhJKsbzwDmRs6G7kOYclrLS5df7cBuxggFnCOctHqosw46DenRHUDY0FUV/v2X9qDk6EY5kKpjgzSua84w+wrzN2BvlcS7xlpdJPEpvnAbe4PvRCdQzHZFn9KlaM9kAIT97+wOGUwLrZmh3eYOMIzSy0lb/w9aqKfkGUWFg4EoSmZK3P/Vv0NZMANym+nTwoJMPA2A/G7Gy5TcHPryDNwwjO5DytKwBJfcpnK6CQbbEWFxaghUwKEXjxW9eEq9jc/XeELqcMyC5vrLeyFKCRq6LNyV855BfkkUYa9ufkco+QkTutZg==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1742676237; c=relaxed/relaxed;
	bh=e07rR+Vv1yvnpfDL0i+Bgt6lJlZzBE/PnI1f4AbHQvE=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=melQjx3Llv6WNtjdXJCFISVy393vvZwooKjS9nhsxGKL32iBU7n0QcH73nIVjSkbwdcHpsTYrrhbG/lCIFbBbd9jFT5Bb5lVS72PaAmUEiES1spscoTy1oykjkbVL3cEfhakj2ADI/X1MZL02mDcn1flv1o/kyDVNSyIwsfLsEL4Zoi5GrpyG/qCmPGyPLVOsS6zWlyPBivSpVd3+QL/KBw3BJm8wr41rYFtvGid1pIElOgXoZ7YDAEs36ro4V5mhfQ1PzH5YdkYCUbKTXgD32EvY6qzFD0HaClNGZLFq1+0bo6ZKLujNU1ejb+5Rtdp9BbUgejTD7SaU1pXXAumfA==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=kernel.org; dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20201202 header.b=k44MrFzW; dkim-atps=neutral; spf=pass (client-ip=172.234.252.31; helo=sea.source.kernel.org; envelope-from=devnull+julian.stecklina.cyberus-technology.de@kernel.org; receiver=lists.ozlabs.org) smtp.mailfrom=kernel.org
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=kernel.org
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20201202 header.b=k44MrFzW;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=kernel.org (client-ip=172.234.252.31; helo=sea.source.kernel.org; envelope-from=devnull+julian.stecklina.cyberus-technology.de@kernel.org; receiver=lists.ozlabs.org)
X-Greylist: delayed 517 seconds by postgrey-1.37 at boromir; Sun, 23 Mar 2025 07:43:56 AEDT
Received: from sea.source.kernel.org (sea.source.kernel.org [172.234.252.31])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits))
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4ZKrrX4Y3sz2ySl
	for <linux-erofs@lists.ozlabs.org>; Sun, 23 Mar 2025 07:43:56 +1100 (AEDT)
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
	by sea.source.kernel.org (Postfix) with ESMTP id 9A5864401B;
	Sat, 22 Mar 2025 20:35:15 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id 56576C4CEFA;
	Sat, 22 Mar 2025 20:35:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1742675715;
	bh=FrtM44ukRwWbBGgAYIVqwpenB+RHshAApE0vzjyKwU0=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:Reply-To:From;
	b=k44MrFzWcFXtPbIIxLbreLAZYvt5ZAmVfavSYKytxqNbHJv3PayQ3FzHfBmp5wlyD
	 B9KW5JFEyp/ssxR2rwZvXc9qopTGl4JrY9cNdqMCSaAhx1vbWZyF70s8nvmW70Bw6A
	 WvMpiwAwd9UlpnQa/+JXlsB08i20vr3NL/scxkOm2B8xxfWBwA+foet28o/cH1iKDe
	 IaqbychWLWlLmKqXD3x0y7IV/rNUaxXUvQ7ppIUif3cnr0zeyQEw6UwkQFQ0fNH5Lf
	 LLw5WfrUabvo+VdyMszwOEZm2w3ZCJgHJD6qBHgdTuFU5xisv2ff97AcFrP0nq1IZQ
	 hoADOITOYjmCQ==
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4B809C36008;
	Sat, 22 Mar 2025 20:35:15 +0000 (UTC)
From: Julian Stecklina via B4 Relay <devnull+julian.stecklina.cyberus-technology.de@kernel.org>
Date: Sat, 22 Mar 2025 21:34:17 +0100
Subject: [PATCH v2 5/9] fs: cramfs: register an initrd fs detector
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
Message-Id: <20250322-initrd-erofs-v2-5-d66ee4a2c756@cyberus-technology.de>
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
X-Developer-Signature: v=1; a=ed25519-sha256; t=1742675713; l=4205;
 i=julian.stecklina@cyberus-technology.de; s=20250320;
 h=from:subject:message-id;
 bh=T+YHuo2Ev8aOIZof+FXA1HNY64MvcwqvCtTXx1JM/p0=;
 b=RV3KMe/LiD+IsfUYYqELk6OGsa0r5a2gi+Mp3Mt0zAMlzR7vGEW8+fcQxMvwhUxUdHoEwczYQ
 s1kE0Q/P68VBeXE1Z9xP0ClFGrMA10OA9KEhkXMn1ftHbf3Zuk1Tjgg
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

Port cramfs to the new initrd_fs_detect API. There are no functional
changes.

Signed-off-by: Julian Stecklina <julian.stecklina@cyberus-technology.de>
---
 fs/cramfs/Makefile  |  5 +++++
 fs/cramfs/initrd.c  | 41 +++++++++++++++++++++++++++++++++++++++++
 init/do_mounts_rd.c | 28 ++--------------------------
 3 files changed, 48 insertions(+), 26 deletions(-)

diff --git a/fs/cramfs/Makefile b/fs/cramfs/Makefile
index 8c3ed298241924b0312fb489b1fb54d274d25c22..d10e2b72aae06bf9ac42690e3967cfd90ac34d4f 100644
--- a/fs/cramfs/Makefile
+++ b/fs/cramfs/Makefile
@@ -6,3 +6,8 @@
 obj-$(CONFIG_CRAMFS) += cramfs.o
 
 cramfs-objs := inode.o uncompress.o
+
+# If we are built-in, we provide support for cramfs on initrds.
+ifeq ($(CONFIG_CRAMFS),y)
+cramfs-objs += initrd.o
+endif
diff --git a/fs/cramfs/initrd.c b/fs/cramfs/initrd.c
new file mode 100644
index 0000000000000000000000000000000000000000..c16df09c118226e6350b9f5877863ef31322ab7b
--- /dev/null
+++ b/fs/cramfs/initrd.c
@@ -0,0 +1,41 @@
+// SPDX-License-Identifier: GPL-2.0-only
+
+#include <linux/fs.h>
+#include <linux/initrd.h>
+#include <uapi/linux/cramfs_fs.h>
+
+/*
+ * The filesystem start maybe padded by this many bytes to make space
+ * for boot loaders.
+ */
+#define CRAMFS_PAD_OFFSET 512
+
+static size_t __init check_cramfs_sb(struct cramfs_super *cramfsb)
+{
+	if (cramfsb->magic != CRAMFS_MAGIC)
+		return 0;
+
+	return cramfsb->size;
+}
+
+static size_t __init detect_cramfs(void *block_data)
+{
+	size_t fssize;
+
+	BUILD_BUG_ON(sizeof(struct cramfs_super) + CRAMFS_PAD_OFFSET
+		     > BLOCK_SIZE);
+
+	fssize = check_cramfs_sb((struct cramfs_super *)block_data);
+	if (fssize)
+		return fssize;
+
+	/*
+	 * The header padding doesn't influence the total length of
+	 * the filesystem.
+	 */
+	block_data = (char *)block_data + CRAMFS_PAD_OFFSET;
+	fssize = check_cramfs_sb((struct cramfs_super *)block_data);
+	return fssize;
+}
+
+initrd_fs_detect(detect_cramfs, 0);
diff --git a/init/do_mounts_rd.c b/init/do_mounts_rd.c
index f7e5d4ccf029b2707bc8524ecdbe200c8b305b00..cdc39baaf3a1a65daad5fe6571a82faf3fc95b62 100644
--- a/init/do_mounts_rd.c
+++ b/init/do_mounts_rd.c
@@ -3,7 +3,7 @@
 #include <linux/fs.h>
 #include <linux/ext2_fs.h>
 #include <linux/romfs_fs.h>
-#include <uapi/linux/cramfs_fs.h>
+
 #include <linux/initrd.h>
 #include <linux/string.h>
 #include <linux/slab.h>
@@ -43,7 +43,6 @@ static int __init crd_load(decompress_fn deco);
  * We currently check for the following magic numbers:
  *	ext2
  *	romfs
- *	cramfs
  *	squashfs
  *	gzip
  *	bzip2
@@ -58,7 +57,7 @@ identify_ramdisk_image(struct file *file, loff_t pos,
 {
 	const int size = BLOCK_SIZE;
 	struct romfs_super_block *romfsb;
-	struct cramfs_super *cramfsb;
+
 	struct squashfs_super_block *squashfsb;
 	int nblocks = -1;
 	unsigned char *buf;
@@ -72,7 +71,6 @@ identify_ramdisk_image(struct file *file, loff_t pos,
 		return -ENOMEM;
 
 	romfsb = (struct romfs_super_block *) buf;
-	cramfsb = (struct cramfs_super *) buf;
 	squashfsb = (struct squashfs_super_block *) buf;
 	memset(buf, 0xe5, size);
 
@@ -104,14 +102,6 @@ identify_ramdisk_image(struct file *file, loff_t pos,
 		goto done;
 	}
 
-	if (cramfsb->magic == CRAMFS_MAGIC) {
-		printk(KERN_NOTICE
-		       "RAMDISK: cramfs filesystem found at block %d\n",
-		       start_block);
-		nblocks = (cramfsb->size + BLOCK_SIZE - 1) >> BLOCK_SIZE_BITS;
-		goto done;
-	}
-
 	/* squashfs is at block zero too */
 	if (le32_to_cpu(squashfsb->s_magic) == SQUASHFS_MAGIC) {
 		printk(KERN_NOTICE
@@ -122,20 +112,6 @@ identify_ramdisk_image(struct file *file, loff_t pos,
 		goto done;
 	}
 
-	/*
-	 * Read 512 bytes further to check if cramfs is padded
-	 */
-	pos = start_block * BLOCK_SIZE + 0x200;
-	kernel_read(file, buf, size, &pos);
-
-	if (cramfsb->magic == CRAMFS_MAGIC) {
-		printk(KERN_NOTICE
-		       "RAMDISK: cramfs filesystem found at block %d\n",
-		       start_block);
-		nblocks = (cramfsb->size + BLOCK_SIZE - 1) >> BLOCK_SIZE_BITS;
-		goto done;
-	}
-
 	/*
 	 * Read block 1 to test for ext2 superblock
 	 */

-- 
2.47.0



