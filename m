Return-Path: <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>
X-Original-To: lists+linux-erofs@lfdr.de
Delivered-To: lists+linux-erofs@lfdr.de
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2401:3900:2:1::3])
	by mail.lfdr.de (Postfix) with ESMTPS id A97A6D55B0
	for <lists+linux-erofs@lfdr.de>; Sun, 13 Oct 2019 12:50:02 +0200 (CEST)
Received: from bilbo.ozlabs.org (lists.ozlabs.org [IPv6:2401:3900:2:1::3])
	by lists.ozlabs.org (Postfix) with ESMTP id 46rdkC217hzDqZ3
	for <lists+linux-erofs@lfdr.de>; Sun, 13 Oct 2019 21:49:55 +1100 (AEDT)
X-Original-To: linux-erofs@lists.ozlabs.org
Delivered-To: linux-erofs@lists.ozlabs.org
Authentication-Results: lists.ozlabs.org;
 spf=pass (mailfrom) smtp.mailfrom=gmail.com
 (client-ip=2607:f8b0:4864:20::441; helo=mail-pf1-x441.google.com;
 envelope-from=pratikshinde320@gmail.com; receiver=<UNKNOWN>)
Authentication-Results: lists.ozlabs.org;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: lists.ozlabs.org; dkim=pass (2048-bit key;
 unprotected) header.d=gmail.com header.i=@gmail.com header.b="et+Z1QQL"; 
 dkim-atps=neutral
Received: from mail-pf1-x441.google.com (mail-pf1-x441.google.com
 [IPv6:2607:f8b0:4864:20::441])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 46rdjz0pd3zDqXC
 for <linux-erofs@lists.ozlabs.org>; Sun, 13 Oct 2019 21:49:42 +1100 (AEDT)
Received: by mail-pf1-x441.google.com with SMTP id h195so8723924pfe.5
 for <linux-erofs@lists.ozlabs.org>; Sun, 13 Oct 2019 03:49:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=from:to:cc:subject:date:message-id;
 bh=0SnUefjZ4E69fEGTgs22anzt1YloMIA3wAMDB3CiTew=;
 b=et+Z1QQLm7x0MXFfHyFa6XtwX8NHjxnp9yQlixc2+JCGRf+1ua0BWLiJ9sA3P/5Pov
 muhk2XVCp25QAfL02z8ltdLgGRDIwvJxIGBh+ockzc7G1+yTtHCwSPxZYy/2cLa6Dhcy
 5XzXabEqhUgtuV2wxM7Ke/fQvvfyqIrt9wCPF83WQlyNhgkhdmwMNlLCpQQc/vB7ozXO
 ZJ4aVd+Ftu98FQU0WIYYzcjj7WwZjJeTFA7lTYBfNP+uWN141p4dlrt/d/mlnkiyvJ8D
 Kj85dcjNc+J3MbAYbAQGemsd+BNBH+8EuAm9kyyb15ukU/LnCcRGmCzDqlZhfFzUUsGE
 S/BQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id;
 bh=0SnUefjZ4E69fEGTgs22anzt1YloMIA3wAMDB3CiTew=;
 b=FeU/axAyQIN66qkbnhmSX4HamQ7jqAYIHQyxGRdAZqKofuaKLnrVrx9OCPby1rGm2x
 YUEPXy4q7M/EVDWr2fu6EK238WKoZ7sTTcsQTCKvtgt04YizCTk3ofjPzPOOSG4ejGdR
 KoLziyOCBSYvAOvc7Wccap8aZDFV4vPh66qVaymH/D0ekjd6DOMOWhpQ/pHWoA2ON/DO
 5KF2cS07t2tlszO5eP8KeTCEPJf+Ux1EC4XcgWEA/pnf4VLnpUDwWL5I3AQ4fDwU4Qg3
 1Et4ghhlJA/3gdmVRNHXIchRrKTW8tCRZVyQlDMgq8wfGxx3SaZGtooBPVWL7VCvA1dW
 hB6w==
X-Gm-Message-State: APjAAAWxqAgKiRXjLPHQwgM6Q/mzk5ECeDt3LIXbsComVR8s+8WxRzp7
 s9eJlgsLLL5cl1IIBano6tpeNr6xRo7TAw==
X-Google-Smtp-Source: APXvYqxoNzTBcd4o4qrM61g5ykI1tbnHKOv9SYRTJTtGdoyi82j8fGvadJpwOqAfYuTDN4SWlhh3Cg==
X-Received: by 2002:aa7:8046:: with SMTP id y6mr26424692pfm.222.1570963778365; 
 Sun, 13 Oct 2019 03:49:38 -0700 (PDT)
Received: from localhost.localdomain ([42.106.202.50])
 by smtp.gmail.com with ESMTPSA id e16sm3928162pgt.68.2019.10.13.03.49.34
 (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
 Sun, 13 Oct 2019 03:49:36 -0700 (PDT)
From: Pratik Shinde <pratikshinde320@gmail.com>
To: linux-erofs@lists.ozlabs.org, bluce.liguifu@huawei.com, miaoxie@huawei.com,
 fangwei1@huawei.com
Subject: [PATCH] code for calculating crc checksum of erofs blocks.
Date: Sun, 13 Oct 2019 16:19:11 +0530
Message-Id: <20191013104911.30358-1-pratikshinde320@gmail.com>
X-Mailer: git-send-email 2.9.3
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
Errors-To: linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org
Sender: "Linux-erofs"
 <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>

Added code for calculating crc of erofs blocks (4K size).for now it calculates
checksum of first block. but can modified to calculate crc for any no. of blocks.

Signed-off-by: Pratik Shinde <pratikshinde320@gmail.com>
---
 include/erofs/config.h |  3 +++
 include/erofs/io.h     |  8 ++++++
 lib/config.c           |  2 ++
 lib/io.c               | 27 +++++++++++++++++++
 mkfs/main.c            | 73 ++++++++++++++++++++++++++++++++++++++++++++++++++
 5 files changed, 113 insertions(+)

diff --git a/include/erofs/config.h b/include/erofs/config.h
index 9711638..e167cd4 100644
--- a/include/erofs/config.h
+++ b/include/erofs/config.h
@@ -16,6 +16,8 @@ enum {
 	FORCE_INODE_EXTENDED,
 };
 
+#define EROFS_FEATURE_BLK_CKSUM		1
+
 struct erofs_configure {
 	const char *c_version;
 	int c_dbg_lvl;
@@ -29,6 +31,7 @@ struct erofs_configure {
 	int c_compr_level_master;
 	int c_force_inodeversion;
 	u64 c_unix_timestamp;
+	int c_blk_cksum;
 };
 
 extern struct erofs_configure cfg;
diff --git a/include/erofs/io.h b/include/erofs/io.h
index 9775047..e0ca8d9 100644
--- a/include/erofs/io.h
+++ b/include/erofs/io.h
@@ -19,6 +19,7 @@
 int dev_open(const char *devname);
 void dev_close(void);
 int dev_write(const void *buf, u64 offset, size_t len);
+int dev_read(void *buf, u64 offset, size_t len);
 int dev_fillzero(u64 offset, size_t len, bool padding);
 int dev_fsync(void);
 int dev_resize(erofs_blk_t nblocks);
@@ -31,5 +32,12 @@ static inline int blk_write(const void *buf, erofs_blk_t blkaddr,
 			 blknr_to_addr(nblocks));
 }
 
+static inline int blk_read(void *buf, erofs_blk_t start,
+			    u32 nblocks)
+{
+	return dev_read(buf, blknr_to_addr(start),
+			 blknr_to_addr(nblocks));
+}
+
 #endif
 
diff --git a/lib/config.c b/lib/config.c
index 46625d7..b5ddff8 100644
--- a/lib/config.c
+++ b/lib/config.c
@@ -9,6 +9,7 @@
 #include <string.h>
 #include "erofs/print.h"
 #include "erofs/internal.h"
+#include "erofs/config.h"
 
 struct erofs_configure cfg;
 
@@ -22,6 +23,7 @@ void erofs_init_configure(void)
 	cfg.c_compr_level_master = -1;
 	cfg.c_force_inodeversion = 0;
 	cfg.c_unix_timestamp = -1;
+	cfg.c_blk_cksum = EROFS_FEATURE_BLK_CKSUM;
 }
 
 void erofs_show_config(void)
diff --git a/lib/io.c b/lib/io.c
index 7f5f94d..52f9424 100644
--- a/lib/io.c
+++ b/lib/io.c
@@ -207,3 +207,30 @@ int dev_resize(unsigned int blocks)
 	return dev_fillzero(st.st_size, length, true);
 }
 
+int dev_read(void *buf, u64 offset, size_t len)
+{
+	int ret;
+
+	if (cfg.c_dry_run)
+		return 0;
+
+	if (!buf) {
+		erofs_err("buf is NULL");
+		return -EINVAL;
+	}
+	if (offset >= erofs_devsz || len > erofs_devsz ||
+	    offset > erofs_devsz - len) {
+		erofs_err("read posion[%" PRIu64 ", %zd] is too large beyond"
+			  "the end of device(%" PRIu64 ").",
+			  offset, len, erofs_devsz);
+		return -EINVAL;
+	}
+
+	ret = pread64(erofs_devfd, buf, len, (off64_t)offset);
+	if (ret != (int)len) {
+		erofs_err("Failed to read data from device - %s:[%" PRIu64 ", %zd].",
+			  erofs_devname, offset, len);
+		return -errno;
+	}
+	return 0;
+}
diff --git a/mkfs/main.c b/mkfs/main.c
index 91a018f..239d6e7 100644
--- a/mkfs/main.c
+++ b/mkfs/main.c
@@ -22,6 +22,9 @@
 
 #define EROFS_SUPER_END (EROFS_SUPER_OFFSET + sizeof(struct erofs_super_block))
 
+// number of blocks for calculating checksum
+#define EROFS_CKSUM_BLOCKS	1
+
 static void usage(void)
 {
 	fprintf(stderr, "usage: [options] FILE DIRECTORY\n\n");
@@ -85,6 +88,10 @@ static int parse_extended_opts(const char *opts)
 				return -EINVAL;
 			cfg.c_force_inodeversion = FORCE_INODE_EXTENDED;
 		}
+
+		if (MATCH_EXTENTED_OPT("nocrc", token, keylen)) {
+			cfg.c_blk_cksum = ~EROFS_FEATURE_BLK_CKSUM;
+		}
 	}
 	return 0;
 }
@@ -180,6 +187,7 @@ int erofs_mkfs_update_super_block(struct erofs_buffer_head *bh,
 		.meta_blkaddr  = sbi.meta_blkaddr,
 		.xattr_blkaddr = 0,
 		.feature_incompat = cpu_to_le32(sbi.feature_incompat),
+		.checksum = 0
 	};
 	const unsigned int sb_blksize =
 		round_up(EROFS_SUPER_END, EROFS_BLKSIZ);
@@ -202,6 +210,68 @@ int erofs_mkfs_update_super_block(struct erofs_buffer_head *bh,
 	return 0;
 }
 
+#define CRCPOLY	0x82F63B78
+static inline u32 crc32c(u32 seed, unsigned char const *in, size_t len)
+{
+	int i;
+	u32 crc = seed;
+
+	while (len--) {
+		crc ^= *in++;
+		for (i = 0; i < 8; i++) {
+			crc = (crc >> 1) ^ ((crc & 1) ? CRCPOLY : 0);
+		}
+	}
+	return crc;
+}
+
+// calculate checksum for first n blocks
+u32 erofs_blk_checksum(erofs_blk_t nblks, u32 *crc) {
+	char *buf;
+	int err = 0;
+
+	buf = malloc(nblks * EROFS_BLKSIZ);
+	err = blk_read(buf, 0, nblks);
+	if (err) {
+		erofs_err("Failed to calculate erofs checksum - %s",
+			  erofs_strerror(err));
+		return err;
+	}
+	*crc = crc32c(0, (const unsigned char *)buf, nblks * EROFS_BLKSIZ);
+	free(buf);
+	return 0;
+}
+
+void erofs_set_checksum() {
+	struct erofs_super_block *sb;
+	char buf[EROFS_BLKSIZ];
+	int ret = 0;
+	u32 crc;
+
+	ret = erofs_blk_checksum(EROFS_CKSUM_BLOCKS, &crc);
+	if (ret) {
+		return;
+	}
+	ret = blk_read(buf, 0, 1);
+	if (ret) {
+		erofs_err("error reading super-block structure");
+		return;
+	}
+
+	sb = (struct erofs_super_block *)((u8 *)buf + EROFS_SUPER_OFFSET);
+	if (le32_to_cpu(sb->magic) != EROFS_SUPER_MAGIC_V1) {
+		erofs_err("not an erofs image");
+		return;
+	}
+	sb->checksum = cpu_to_le32(crc);
+	ret = blk_write(buf, 0, 1);
+	if (ret) {
+		erofs_err("error writing 0th block to disk - %s",
+			  erofs_strerror(ret));
+		return;
+	}
+}
+
 int main(int argc, char **argv)
 {
 	int err = 0;
@@ -301,6 +371,9 @@ int main(int argc, char **argv)
 		err = -EIO;
 	else
 		err = dev_resize(nblocks);
+	if (cfg.c_blk_cksum & EROFS_FEATURE_BLK_CKSUM) {
+		erofs_set_checksum();
+	}
 exit:
 	z_erofs_compress_exit();
 	dev_close();
-- 
2.9.3

