Return-Path: <linux-erofs+bounces-109-lists+linux-erofs=lfdr.de@lists.ozlabs.org>
X-Original-To: lists+linux-erofs@lfdr.de
Delivered-To: lists+linux-erofs@lfdr.de
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	by mail.lfdr.de (Postfix) with ESMTPS id EEAC7A6CC4B
	for <lists+linux-erofs@lfdr.de>; Sat, 22 Mar 2025 21:35:31 +0100 (CET)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4ZKrff17vfz2ySm;
	Sun, 23 Mar 2025 07:35:22 +1100 (AEDT)
X-Original-To: linux-erofs@lists.ozlabs.org
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip="2604:1380:4641:c500::1"
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1742675722;
	cv=none; b=Yli8MAAwKtqWlgQ18Evf56p8bMn311duGBscrHlDx80UNkXqoWaQ1d7rSvy4C8WAXBFXUtPnr9Tz+PyEi8yRxI2iLxOsGehvpYjGtavAamS9EyoSCevNb3/8+pC8I7qAeSGTAGZzlq8S7BdeBC5g23gz7N7YyI1nb996Zttgv5et7iGd5KjgSsCqWQNiLs+poBDI5q1ie2F4uhmhljqSfZioGcKqSl3ODMIbW+mA6cJJRS587q2wB2W8tHGZ5MJYkq5Iag1GYDqjCfR2/bbOSPqmOviCXY1RYhpikQ5ZWikSlFwoI3q0GOeOcJXKp21Rceekq+f4uQe3RzKOKfVeiQ==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1742675722; c=relaxed/relaxed;
	bh=fp9nrKcTCrpEdEd+GCPDFSzun6HjAaLEP6+jd9ZS3Fg=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=m8eA42QKnjImkf7NZISm+Ki7bKJHxhNZImoA+fLGzHKYNwolKLbyBR9W9ZYEIUTtFM5QF839GyfcrqG2IhavyvrFDMqwXbWzk75+iWymPbcQWuV7Zq/IMr2beadvwXTRGmUDdWHN+ptTdmyNuY3P6y24OPZq6nElRGkTwwltuoiMVS7308SRuyU5CwQt85Dy/CMqP9apPWQlW6FcyiUTE+rR7NgJgqFy2Gpu/lsgHm3f8oPGYF3HVETQH/MKlOdjBDMt9hILcr/uY2Ad2ctqs8dwwanAKmoWP+BUcpWbDpCZNv+Sb4HzMDNRGvZLKgl+/8AIFeFUtkpLPrvK/Cmo/g==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=kernel.org; dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20201202 header.b=q/LalmDt; dkim-atps=neutral; spf=pass (client-ip=2604:1380:4641:c500::1; helo=dfw.source.kernel.org; envelope-from=devnull+julian.stecklina.cyberus-technology.de@kernel.org; receiver=lists.ozlabs.org) smtp.mailfrom=kernel.org
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=kernel.org
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20201202 header.b=q/LalmDt;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=kernel.org (client-ip=2604:1380:4641:c500::1; helo=dfw.source.kernel.org; envelope-from=devnull+julian.stecklina.cyberus-technology.de@kernel.org; receiver=lists.ozlabs.org)
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4ZKrfb1zLVz2ySJ
	for <linux-erofs@lists.ozlabs.org>; Sun, 23 Mar 2025 07:35:18 +1100 (AEDT)
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
	by dfw.source.kernel.org (Postfix) with ESMTP id F24105C59F3;
	Sat, 22 Mar 2025 20:32:58 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id 2C191C4CEF0;
	Sat, 22 Mar 2025 20:35:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1742675715;
	bh=TDhbyo9F/ZSQ2RUuUaTZZ0o9x6DAYOKYzNLlrAq8L1I=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:Reply-To:From;
	b=q/LalmDtJOUAJrZHrgHxJkI2oI09js3AZcqdeCniUFAecfSyWNCit8xl6Gnwf105n
	 9SchH1kvzhhghyYBJYt7i86OHBq6i/rk+MFsh/lSdEplNrDm37JTWV6OvN8XY2dUpd
	 boDRzh6n0bTigRewigYWSR9Bv9Bd7UdU+FcERoZZ6qJKjQW8rLu2mLLuwjNSsc38eg
	 cQ419jrRsQo3YkOtDb3ZV72NDNuJBjH4rNUrFSGYZLQKoliY+Sm9j+ScDmFiMhb+zf
	 H/Qngo6n++qHSxGPo6UGJ7o6bMET9oSN2dxow/lwAtliJdJv4b4tAEJ8hgVnrPMn3C
	 powEUC9VQS67g==
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1CEBEC35FFC;
	Sat, 22 Mar 2025 20:35:15 +0000 (UTC)
From: Julian Stecklina via B4 Relay <devnull+julian.stecklina.cyberus-technology.de@kernel.org>
Date: Sat, 22 Mar 2025 21:34:15 +0100
Subject: [PATCH v2 3/9] initrd: add a generic mechanism to add fs detectors
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
Message-Id: <20250322-initrd-erofs-v2-3-d66ee4a2c756@cyberus-technology.de>
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
X-Developer-Signature: v=1; a=ed25519-sha256; t=1742675713; l=5291;
 i=julian.stecklina@cyberus-technology.de; s=20250320;
 h=from:subject:message-id;
 bh=55Wh0MWl4j4HdLagTcgFYbNKFaTKj1GqG+lEyJb27TU=;
 b=OGbHoFniZHWRPY2giReYmVqjd13V7KvnyKGwIuoxXzLG+X8S0AOkCmqZtNSa/bEz/ox8kmn5P
 3SEJs2yPUFYAnv2JT9E89Ihwls7xnW3A4QYDVuDzcQopJf7R7NZH9fE
X-Developer-Key: i=julian.stecklina@cyberus-technology.de; a=ed25519;
 pk=m051/8gQfs5AmkACfykwRcD6CUr2T7DQ9OA5eBgyy7c=
X-Endpoint-Received: by B4 Relay for
 julian.stecklina@cyberus-technology.de/20250320 with auth_id=363
X-Original-From: Julian Stecklina <julian.stecklina@cyberus-technology.de>
Reply-To: julian.stecklina@cyberus-technology.de
X-Spam-Status: No, score=-1.2 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
	SPF_HELO_NONE,SPF_PASS autolearn=disabled version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-25) on lists.ozlabs.org

From: Julian Stecklina <julian.stecklina@cyberus-technology.de>

So far all filesystems that are supported as initrd have their
filesystem detection code implemented in init/do_mounts_rd.c. A better
approach is to let filesystem implementations register a detection
hook. This allows the filesystem detection code to live with the rest
of the filesystem implementation.

We could have done a more flexible mechanism than passing a block of
data, but this simple solution works for all filesystems and keeps the
boilerplate low.

The following patches will convert each of the filesystems.

Suggested-by: Al Viro <viro@zeniv.linux.org.uk>
Signed-off-by: Julian Stecklina <julian.stecklina@cyberus-technology.de>
---
 include/asm-generic/vmlinux.lds.h |  6 ++++++
 include/linux/initrd.h            | 37 +++++++++++++++++++++++++++++++++++++
 init/do_mounts_rd.c               | 28 +++++++++++++++++++++++++++-
 3 files changed, 70 insertions(+), 1 deletion(-)

diff --git a/include/asm-generic/vmlinux.lds.h b/include/asm-generic/vmlinux.lds.h
index 0d5b186abee86d27f3b02a49299155453a8c8e9e..d0816e6c41a9bbedf8f5a68c33b6f3e18014019a 100644
--- a/include/asm-generic/vmlinux.lds.h
+++ b/include/asm-generic/vmlinux.lds.h
@@ -968,8 +968,13 @@ defined(CONFIG_AUTOFDO_CLANG) || defined(CONFIG_PROPELLER_CLANG)
 	KEEP(*(.init.ramfs))						\
 	. = ALIGN(8);							\
 	KEEP(*(.init.ramfs.info))
+
+#define INITRD_FS_DETECT()						\
+	. = ALIGN(16);							\
+	BOUNDED_SECTION(_initrd_fs_detect)
 #else
 #define INIT_RAM_FS
+#define INITRD_FS_DETECT()
 #endif
 
 /*
@@ -1170,6 +1175,7 @@ defined(CONFIG_AUTOFDO_CLANG) || defined(CONFIG_PROPELLER_CLANG)
 		INIT_CALLS						\
 		CON_INITCALL						\
 		INIT_RAM_FS						\
+		INITRD_FS_DETECT()					\
 	}
 
 #define BSS_SECTION(sbss_align, bss_align, stop_align)			\
diff --git a/include/linux/initrd.h b/include/linux/initrd.h
index f1a1f4c92ded3921bf56d53bee3e20b549d851fb..25463ce9c26ad4e4e9d3b333aa9f5596585c1762 100644
--- a/include/linux/initrd.h
+++ b/include/linux/initrd.h
@@ -3,6 +3,9 @@
 #ifndef __LINUX_INITRD_H
 #define __LINUX_INITRD_H
 
+#include <linux/init.h>
+#include <linux/types.h>
+
 #define INITRD_MINOR 250 /* shouldn't collide with /dev/ram* too soon ... */
 
 /* starting block # of image */
@@ -18,12 +21,46 @@ extern int initrd_below_start_ok;
 extern unsigned long initrd_start, initrd_end;
 extern void free_initrd_mem(unsigned long, unsigned long);
 
+struct file;
+
 #ifdef CONFIG_BLK_DEV_INITRD
 extern void __init reserve_initrd_mem(void);
 extern void wait_for_initramfs(void);
+
+/*
+ * Detect a filesystem on the initrd. You get 1 KiB (BLOCK_SIZE) of
+ * data to work with. The offset of the block is specified in
+ * initrd_fs_detect().
+ *
+ * @block_data: A pointer to BLOCK_SIZE of data
+ *
+ * Returns the size of the filesystem in bytes or 0, if the filesystem
+ * was not detected.
+ */
+typedef size_t initrd_fs_detect_fn(void * const block_data);
+
+struct initrd_detect_fs {
+	initrd_fs_detect_fn *detect_fn;
+	loff_t detect_byte_offset;
+};
+
+extern struct initrd_detect_fs __start_initrd_fs_detect[];
+extern struct initrd_detect_fs __stop_initrd_fs_detect[];
+
+/*
+ * Add a filesystem detector for initrds. See the documentation of
+ * initrd_fs_detect_fn above.
+ */
+#define initrd_fs_detect(fn, byte_offset)					\
+	static const struct initrd_detect_fs __initrd_fs_detect_ ## fn		\
+	__used __section("_initrd_fs_detect") =					\
+		{ .detect_fn = fn, .detect_byte_offset = byte_offset}
+
 #else
 static inline void __init reserve_initrd_mem(void) {}
 static inline void wait_for_initramfs(void) {}
+
+#define initrd_fs_detect(detectfn)
 #endif
 
 extern phys_addr_t phys_initrd_start;
diff --git a/init/do_mounts_rd.c b/init/do_mounts_rd.c
index d026df401afa0b7458ab1f266b21830aab974b92..56c1fa935c7ee780870142923046a3d2fd2d6d96 100644
--- a/init/do_mounts_rd.c
+++ b/init/do_mounts_rd.c
@@ -58,7 +58,7 @@ static int __init
 identify_ramdisk_image(struct file *file, loff_t pos,
 		decompress_fn *decompressor)
 {
-	const int size = 512;
+	const int size = BLOCK_SIZE;
 	struct minix_super_block *minixsb;
 	struct romfs_super_block *romfsb;
 	struct cramfs_super *cramfsb;
@@ -68,6 +68,7 @@ identify_ramdisk_image(struct file *file, loff_t pos,
 	const char *compress_name;
 	unsigned long n;
 	int start_block = rd_image_start;
+	struct initrd_detect_fs *detect_fs;
 
 	buf = kmalloc(size, GFP_KERNEL);
 	if (!buf)
@@ -165,6 +166,31 @@ identify_ramdisk_image(struct file *file, loff_t pos,
 		goto done;
 	}
 
+	/* Try to find a filesystem in the initrd */
+	for (detect_fs = __start_initrd_fs_detect;
+	     detect_fs < __stop_initrd_fs_detect;
+	     detect_fs++
+	     ) {
+		size_t fs_size;
+
+		pos = (start_block * BLOCK_SIZE) + detect_fs->detect_byte_offset;
+		kernel_read(file, buf, size, &pos);
+
+		fs_size = detect_fs->detect_fn(buf);
+
+		if (fs_size == 0)
+			continue;
+
+		nblocks = (fs_size + BLOCK_SIZE + 1)
+			>> BLOCK_SIZE_BITS;
+
+		printk(KERN_NOTICE
+		       "RAMDISK: filesystem found (%d blocks)\n",
+		       nblocks);
+
+		goto done;
+	}
+
 	printk(KERN_NOTICE
 	       "RAMDISK: Couldn't find valid RAM disk image starting at %d.\n",
 	       start_block);

-- 
2.47.0



