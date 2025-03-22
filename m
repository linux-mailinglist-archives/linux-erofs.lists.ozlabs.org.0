Return-Path: <linux-erofs+bounces-106-lists+linux-erofs=lfdr.de@lists.ozlabs.org>
X-Original-To: lists+linux-erofs@lfdr.de
Delivered-To: lists+linux-erofs@lfdr.de
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2404:9400:2:0:216:3eff:fee1:b9f1])
	by mail.lfdr.de (Postfix) with ESMTPS id DD787A6CC47
	for <lists+linux-erofs@lfdr.de>; Sat, 22 Mar 2025 21:35:24 +0100 (CET)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4ZKrfc6q3bz2yd7;
	Sun, 23 Mar 2025 07:35:20 +1100 (AEDT)
X-Original-To: linux-erofs@lists.ozlabs.org
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip="2604:1380:45d1:ec00::3"
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1742675720;
	cv=none; b=O4Q5XZLK4HDPfTnP1fiiiRMVHOK7xJt3Y5GDoZpgY2SVVZEXG2/4fGBnYXSfnzsjCo3SrZF8vVAfYtCAU0oQgDz8P/pAKSpSgUweKs53W4JpPbWmnOaaqUNngXA0i4VAM0VcsaFyKTMAIove04huDkWdp/X2PThxHlC/8UM0uP3q32YHOE3bxZbYwwAQFrkKGGlI2I9XP8pfgxLFsBAJKY3XdfohKDrIg/E11I1ZrQYuVXB2jXXPf6VbbsEMvMYu6a+8gyLzD5ZUQH9yEIY8JrbwnIqA1HJR1PbUtrgp2GEXcr+9IK7xSkCeOXLRQAPx9ygQIWwj3mOp2wkujwjz6Q==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1742675720; c=relaxed/relaxed;
	bh=gmsji7VHNIS3XGvEgWy5fB+tzjeTEiXEgOVybsG3l9k=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=do7TFzXbOWJ2YNPnZUHxhVmNNKv/6DQBEG8UGAdl8BNGwteNgGy04qUN6l3iLsEdE6zHfmmUaaBfAOMSTTBr9A8k4fJJMlAwOZH59r17U8mF/jsPo8m9qllSnjBdwmb8Jq8Aqnv5vMTN6q+Ssg6j9u29asXr2NXeadhor+KLvWSPHZNpRn+TRATMA2MFG8Hpf2CjV3cMjxi51cPfYqgJy54rvQWP7LsU4bRyJRnXEecfxsiQ1aD9iskq9EcJKGtiSoqkIG/ZIcnZMUO03vToekJJQ/BGvH69JpRbC/ZiVzJz0cnf5/JSgrBjgJk5RJpOC6VLcWvYoQwi6N6NNv/AFw==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=kernel.org; dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20201202 header.b=eJfYfbPo; dkim-atps=neutral; spf=pass (client-ip=2604:1380:45d1:ec00::3; helo=nyc.source.kernel.org; envelope-from=devnull+julian.stecklina.cyberus-technology.de@kernel.org; receiver=lists.ozlabs.org) smtp.mailfrom=kernel.org
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=kernel.org
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20201202 header.b=eJfYfbPo;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=kernel.org (client-ip=2604:1380:45d1:ec00::3; helo=nyc.source.kernel.org; envelope-from=devnull+julian.stecklina.cyberus-technology.de@kernel.org; receiver=lists.ozlabs.org)
Received: from nyc.source.kernel.org (nyc.source.kernel.org [IPv6:2604:1380:45d1:ec00::3])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4ZKrfb323cz2ySh
	for <linux-erofs@lists.ozlabs.org>; Sun, 23 Mar 2025 07:35:19 +1100 (AEDT)
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
	by nyc.source.kernel.org (Postfix) with ESMTP id DE859A4A3A2;
	Sat, 22 Mar 2025 20:29:46 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id 8B99FC113CF;
	Sat, 22 Mar 2025 20:35:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1742675715;
	bh=qlYnspgvq4aayarEVcEiEabLCbx6xRYkDWQEk4WspNA=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:Reply-To:From;
	b=eJfYfbPo+BZJFO9jFoPzDBYrkzPsHCEFgP7PrKjVBtSNsv0FIy7ms/A2f6J3Z4dNm
	 gT/20YuneiiNIS13XA/fCJvIJ2tSeCYmsPSg62QllK8MxzHZVqweoIvwyJCnmY22Da
	 s7sZQmcA0/ZJNLSpF8cjU5DYFjO5Yt/YofdS9reJYgf3Cav8arEliufA3oXaY5kotC
	 7xd4rdmBtX/woAHpZsWYiwIagjvH5zJIKZWr3217oxHd3oyWlevzanN1hr1+LQ7NZw
	 BopzREDJFX6SO9R0lqyNHbu2ojhdCz/8ioOS/SkKgx88T8zmLEhVYZVzRgi9wi0fDI
	 NVaB7+GFGlVUQ==
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 82135C3600B;
	Sat, 22 Mar 2025 20:35:15 +0000 (UTC)
From: Julian Stecklina via B4 Relay <devnull+julian.stecklina.cyberus-technology.de@kernel.org>
Date: Sat, 22 Mar 2025 21:34:20 +0100
Subject: [PATCH v2 8/9] fs: ext2, ext4: register an initrd fs detector
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
Message-Id: <20250322-initrd-erofs-v2-8-d66ee4a2c756@cyberus-technology.de>
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
X-Developer-Signature: v=1; a=ed25519-sha256; t=1742675713; l=4918;
 i=julian.stecklina@cyberus-technology.de; s=20250320;
 h=from:subject:message-id;
 bh=LdAKuZmUbrCiaWrR+heLI+KjXz18b4SY7NnyYc6FMGI=;
 b=YFZIJjXxsx7J3kcAizftmxjRIVimZ/jqPa2fg7X4xVMF3sKQ2pEExGPq0hGEBNEjEyJlkcvWA
 8IMeR63U5XPCTg3wo7m/f2h+syZWCXdcsZ51TJMQgQPTbzyqG0NGint
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

Port ext2fs to the new initrd_fs_detect API. There are minor
functional changes, because I thought that relying on a 16-bit magic
number alone is too error-prone. I also removed ext2_image_size from
linux/ext2_fs.h, because the initrd code is the only user.

Given that both the ext2 and ext4 module can handle ext2 filesystems,
we have to add the code to either module depending on the
configuration options.

Signed-off-by: Julian Stecklina <julian.stecklina@cyberus-technology.de>
---
 fs/ext2/Makefile        |  5 +++++
 fs/ext2/initrd.c        | 27 +++++++++++++++++++++++++++
 fs/ext4/Makefile        |  4 ++++
 include/linux/ext2_fs.h |  9 ---------
 init/do_mounts_rd.c     | 19 -------------------
 5 files changed, 36 insertions(+), 28 deletions(-)

diff --git a/fs/ext2/Makefile b/fs/ext2/Makefile
index 8860948ef9ca4e0a9c3f90311c3cecf0c5b70c63..c38a5b209023f93c84e8a6b8995d1db0214bb01a 100644
--- a/fs/ext2/Makefile
+++ b/fs/ext2/Makefile
@@ -14,3 +14,8 @@ CFLAGS_trace.o := -I$(src)
 ext2-$(CONFIG_EXT2_FS_XATTR)	 += xattr.o xattr_user.o xattr_trusted.o
 ext2-$(CONFIG_EXT2_FS_POSIX_ACL) += acl.o
 ext2-$(CONFIG_EXT2_FS_SECURITY)	 += xattr_security.o
+
+# If we are built-in, we provide support for ext2 on initrds.
+ifeq ($(CONFIG_EXT2_FS),y)
+ext2-y += initrd.o
+endif
diff --git a/fs/ext2/initrd.c b/fs/ext2/initrd.c
new file mode 100644
index 0000000000000000000000000000000000000000..572930512b8b3bee0d733553117a026af6e2f833
--- /dev/null
+++ b/fs/ext2/initrd.c
@@ -0,0 +1,27 @@
+// SPDX-License-Identifier: GPL-2.0-only
+
+#include <linux/initrd.h>
+#include <linux/fs.h>
+
+#include "ext2.h"
+
+static size_t __init detect_ext2fs(void *block_data)
+{
+	struct ext2_super_block *ext2sb
+		= (struct ext2_super_block *)block_data;
+	BUILD_BUG_ON(sizeof(*ext2sb) > BLOCK_SIZE);
+
+	/*
+	 * The 16-bit magic number is not a lot to reliably detect the
+	 * filesystem. We check the revision as well to decrease the
+	 * chance of false positives.
+	 */
+	if (le16_to_cpu(ext2sb->s_magic) != EXT2_SUPER_MAGIC ||
+	    le32_to_cpu(ext2sb->s_rev_level) > EXT2_MAX_SUPP_REV)
+		return 0;
+
+	return le32_to_cpu(ext2sb->s_blocks_count)
+		<< (le32_to_cpu(ext2sb->s_log_block_size) + BLOCK_SIZE_BITS);
+}
+
+initrd_fs_detect(detect_ext2fs, BLOCK_SIZE);
diff --git a/fs/ext4/Makefile b/fs/ext4/Makefile
index 72206a2926765feba6fc59332ffeca7c03c8677b..907c80c33c8fc1e5dee85f8e862c8b27615f1a04 100644
--- a/fs/ext4/Makefile
+++ b/fs/ext4/Makefile
@@ -18,3 +18,7 @@ ext4-inode-test-objs			+= inode-test.o
 obj-$(CONFIG_EXT4_KUNIT_TESTS)		+= ext4-inode-test.o
 ext4-$(CONFIG_FS_VERITY)		+= verity.o
 ext4-$(CONFIG_FS_ENCRYPTION)		+= crypto.o
+
+ifeq ($(CONFIG_EXT4_FS),y)
+ext4-$(CONFIG_EXT4_USE_FOR_EXT2) += ../ext2/initrd.o
+endif
diff --git a/include/linux/ext2_fs.h b/include/linux/ext2_fs.h
index 1fef885690370e5c039871ac8dd99d649d72aa64..0662827c0c69c3b77fb74850e1b0f3626c14c713 100644
--- a/include/linux/ext2_fs.h
+++ b/include/linux/ext2_fs.h
@@ -31,13 +31,4 @@
 #define EXT2_SB_BLOCKS_OFFSET	0x04
 #define EXT2_SB_BSIZE_OFFSET	0x18
 
-static inline u64 ext2_image_size(void *ext2_sb)
-{
-	__u8 *p = ext2_sb;
-	if (*(__le16 *)(p + EXT2_SB_MAGIC_OFFSET) != cpu_to_le16(EXT2_SUPER_MAGIC))
-		return 0;
-	return (u64)le32_to_cpup((__le32 *)(p + EXT2_SB_BLOCKS_OFFSET)) <<
-		le32_to_cpup((__le32 *)(p + EXT2_SB_BSIZE_OFFSET));
-}
-
 #endif	/* _LINUX_EXT2_FS_H */
diff --git a/init/do_mounts_rd.c b/init/do_mounts_rd.c
index 2a6cb08d0b4872ef8e861a813ef89dc1e9a150af..45d2c5f7da044166524bef808bb97bee46c3324b 100644
--- a/init/do_mounts_rd.c
+++ b/init/do_mounts_rd.c
@@ -1,7 +1,6 @@
 // SPDX-License-Identifier: GPL-2.0
 #include <linux/kernel.h>
 #include <linux/fs.h>
-#include <linux/ext2_fs.h>
 
 #include <linux/initrd.h>
 #include <linux/string.h>
@@ -39,7 +38,6 @@ static int __init crd_load(decompress_fn deco);
  * numbers could not be found.
  *
  * We currently check for the following magic numbers:
- *	ext2
  *	gzip
  *	bzip2
  *	lzma
@@ -56,7 +54,6 @@ identify_ramdisk_image(struct file *file, loff_t pos,
 	int nblocks = -1;
 	unsigned char *buf;
 	const char *compress_name;
-	unsigned long n;
 	int start_block = rd_image_start;
 	struct initrd_detect_fs *detect_fs;
 
@@ -84,22 +81,6 @@ identify_ramdisk_image(struct file *file, loff_t pos,
 		goto done;
 	}
 
-	/*
-	 * Read block 1 to test for ext2 superblock
-	 */
-	pos = (start_block + 1) * BLOCK_SIZE;
-	kernel_read(file, buf, size, &pos);
-
-	/* Try ext2 */
-	n = ext2_image_size(buf);
-	if (n) {
-		printk(KERN_NOTICE
-		       "RAMDISK: ext2 filesystem found at block %d\n",
-		       start_block);
-		nblocks = n;
-		goto done;
-	}
-
 	/* Try to find a filesystem in the initrd */
 	for (detect_fs = __start_initrd_fs_detect;
 	     detect_fs < __stop_initrd_fs_detect;

-- 
2.47.0



