Return-Path: <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>
X-Original-To: lists+linux-erofs@lfdr.de
Delivered-To: lists+linux-erofs@lfdr.de
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2401:3900:2:1::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 0E133DD940
	for <lists+linux-erofs@lfdr.de>; Sat, 19 Oct 2019 17:08:55 +0200 (CEST)
Received: from bilbo.ozlabs.org (lists.ozlabs.org [IPv6:2401:3900:2:1::3])
	by lists.ozlabs.org (Postfix) with ESMTP id 46wRB95LrrzDqQC
	for <lists+linux-erofs@lfdr.de>; Sun, 20 Oct 2019 02:08:49 +1100 (AEDT)
X-Original-To: linux-erofs@lists.ozlabs.org
Delivered-To: linux-erofs@lists.ozlabs.org
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized)
 smtp.mailfrom=gmail.com (client-ip=2607:f8b0:4864:20::443;
 helo=mail-pf1-x443.google.com; envelope-from=pratikshinde320@gmail.com;
 receiver=<UNKNOWN>)
Authentication-Results: lists.ozlabs.org;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: lists.ozlabs.org; dkim=pass (2048-bit key;
 unprotected) header.d=gmail.com header.i=@gmail.com header.b="SN7IOSuY"; 
 dkim-atps=neutral
Received: from mail-pf1-x443.google.com (mail-pf1-x443.google.com
 [IPv6:2607:f8b0:4864:20::443])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 46wRB01KQwzDqNT
 for <linux-erofs@lists.ozlabs.org>; Sun, 20 Oct 2019 02:08:37 +1100 (AEDT)
Received: by mail-pf1-x443.google.com with SMTP id a2so5640763pfo.10
 for <linux-erofs@lists.ozlabs.org>; Sat, 19 Oct 2019 08:08:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=from:to:cc:subject:date:message-id;
 bh=RBNdnWNGd/fDZuum7rUNULtPk/0kje1pR/G1QQe9Z/0=;
 b=SN7IOSuY0oSU8/w8m0ckyBG6nxUDI6dW3vqHl/0tdXNswKCMjjHZFgqYolEpT/12aS
 N17GpD1EH2Q3PrccFRvJzUKh4QSKSj3JjuakgIHmIdz7iLg0Cmw2qd01qgbqavBHb9ob
 srcEYu4fL/tV7R8E9sNPINSsBbpHi4VHKSiY+FG1gC4qrJV+8J+zd+vnaj0bDQZri3DQ
 0AbiLTqFEY+f3O7OVLq4mt+O/r3GnEK8WUpoCOaRuA5WNa9kBBoQgmWoc782aKLC+Nq+
 QxQ7cwdYfB8R1aN26PGrj/qbqn8lhHe4QrFslx0yH6HLHaAVvQgwxfzraG5CJ+jV9zdi
 wOGw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id;
 bh=RBNdnWNGd/fDZuum7rUNULtPk/0kje1pR/G1QQe9Z/0=;
 b=H6z3KvUdkGQXuSMggYp5IALKN85YoLB5LVtK1vM78UrwqTxRdMJYuAMx/NIBDwkJre
 VKoS9kbIOcRLWA6UNnKTobhD5laL+JgTVUani5E2M7bqj7ZStPJ5kv3wtG8+bTiqEr//
 P2wYetH+yRBhyNfX5wBiqL4CMqpSq1tGtQrQ8AcvXiR/kIGgSEHFUxdF+BJOnpduafrt
 8b1GbsAQO6uhSdjZEki6D2ZDO4nleDZY3izm2v6JdL6rat9e8zQmEr7zm1R3/YO1htZH
 NHaY8av9HWztq/j0VyJtOlCj+7llOb+GA7H7M9FkDShQMwm7nBANxHfzElo6q5+gVZXQ
 fsZg==
X-Gm-Message-State: APjAAAV5GRuJpNaQyDpD1CkaO5ZsLVLe0OCtNk+aYgfiuyq8iOXK//jE
 a/L1s/qcve0WWYKNiYfM7BmdcOR8+NQ=
X-Google-Smtp-Source: APXvYqxkekhE3Asxriez2T0uiOWNieE23tUquJFJEvMdM98sTYl+oDbMWjsWOEdXR8VqJdTf4AQiPA==
X-Received: by 2002:a17:90a:2ec3:: with SMTP id
 h3mr17860231pjs.131.1571497705244; 
 Sat, 19 Oct 2019 08:08:25 -0700 (PDT)
Received: from localhost.localdomain ([42.108.227.22])
 by smtp.gmail.com with ESMTPSA id v12sm9340995pgc.41.2019.10.19.08.08.21
 (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
 Sat, 19 Oct 2019 08:08:24 -0700 (PDT)
From: Pratik Shinde <pratikshinde320@gmail.com>
To: linux-erofs@lists.ozlabs.org, bluce.liguifu@huawei.com, miaoxie@huawei.com,
 fangwei1@huawei.com
Subject: [PATCH-v5] erofs-utils:code for calculating crc checksum of erofs
 blocks
Date: Sat, 19 Oct 2019 20:38:03 +0530
Message-Id: <20191019150803.9259-1-pratikshinde320@gmail.com>
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
checksum of first block. but can modified to calculate crc for any no. of blocks

Fill 'feature_compat' field of erofs_super_block so that it
can be used on kernel side. also fixing one typo.

Signed-off-by: Pratik Shinde <pratikshinde320@gmail.com>
---
 include/erofs/internal.h |  1 +
 include/erofs/io.h       |  8 ++++++
 include/erofs_fs.h       |  5 ++--
 lib/io.c                 | 27 ++++++++++++++++++
 mkfs/main.c              | 71 ++++++++++++++++++++++++++++++++++++++++++++++++
 5 files changed, 110 insertions(+), 2 deletions(-)

diff --git a/include/erofs/internal.h b/include/erofs/internal.h
index 5384946..53335bc 100644
--- a/include/erofs/internal.h
+++ b/include/erofs/internal.h
@@ -55,6 +55,7 @@ struct erofs_sb_info {
 	u32 feature_incompat;
 	u64 build_time;
 	u32 build_time_nsec;
+	u32 feature;
 };
 
 /* global sbi */
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
 
diff --git a/include/erofs_fs.h b/include/erofs_fs.h
index f29aa25..9eda6c2 100644
--- a/include/erofs_fs.h
+++ b/include/erofs_fs.h
@@ -19,6 +19,7 @@
  */
 #define EROFS_FEATURE_INCOMPAT_LZ4_0PADDING	0x00000001
 #define EROFS_ALL_FEATURE_INCOMPAT		EROFS_FEATURE_INCOMPAT_LZ4_0PADDING
+#define EROFS_FEATURE_SB_CHKSUM	0x0001
 
 /* 128-byte erofs on-disk super block */
 struct erofs_super_block {
@@ -39,8 +40,8 @@ struct erofs_super_block {
 	__u8 uuid[16];          /* 128-bit uuid for volume */
 	__u8 volume_name[16];   /* volume name */
 	__le32 feature_incompat;
-
-	__u8 reserved2[44];
+	__le32 chksum_blocks;	/* number of blocks used for checksum */
+	__u8 reserved2[40];
 };
 
 /*
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
index 91a018f..c7cb923 100644
--- a/mkfs/main.c
+++ b/mkfs/main.c
@@ -22,6 +22,9 @@
 
 #define EROFS_SUPER_END (EROFS_SUPER_OFFSET + sizeof(struct erofs_super_block))
 
+/* number of blocks for calculating checksum */
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
+			sbi.feature &= ~EROFS_FEATURE_SB_CHKSUM;
+		}
 	}
 	return 0;
 }
@@ -180,6 +187,9 @@ int erofs_mkfs_update_super_block(struct erofs_buffer_head *bh,
 		.meta_blkaddr  = sbi.meta_blkaddr,
 		.xattr_blkaddr = 0,
 		.feature_incompat = cpu_to_le32(sbi.feature_incompat),
+		.feature_compat = cpu_to_le32(sbi.feature),
+		.checksum = 0,
+		.chksum_blocks = cpu_to_le32(EROFS_CKSUM_BLOCKS)
 	};
 	const unsigned int sb_blksize =
 		round_up(EROFS_SUPER_END, EROFS_BLKSIZ);
@@ -202,6 +212,64 @@ int erofs_mkfs_update_super_block(struct erofs_buffer_head *bh,
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
+/* calculate checksum for first n blocks */
+u32 erofs_calc_blk_checksum(erofs_blk_t nblks, u32 *crc)
+{
+	char *buf;
+	int err = 0;
+
+	buf = malloc(nblks * EROFS_BLKSIZ);
+	err = blk_read(buf, 0, nblks);
+	if (err) {
+		return err;
+	}
+	*crc = crc32c(0, (const unsigned char *)buf, nblks * EROFS_BLKSIZ);
+	free(buf);
+	return 0;
+}
+
+void erofs_write_sb_checksum()
+{
+	struct erofs_super_block *sb;
+	char buf[EROFS_BLKSIZ];
+	int ret = 0;
+	u32 crc;
+
+	ret = erofs_calc_blk_checksum(EROFS_CKSUM_BLOCKS, &crc);
+	if (ret) {
+		return;
+	}
+	ret = blk_read(buf, 0, 1);
+	if (ret) {
+		return;
+	}
+
+	sb = (struct erofs_super_block *)((u8 *)buf + EROFS_SUPER_OFFSET);
+	if (le32_to_cpu(sb->magic) != EROFS_SUPER_MAGIC_V1) {
+		return;
+	}
+	sb->checksum = cpu_to_le32(crc);
+	ret = blk_write(buf, 0, 1);
+	if (ret) {
+		return;
+	}
+}
+
 int main(int argc, char **argv)
 {
 	int err = 0;
@@ -217,6 +285,7 @@ int main(int argc, char **argv)
 
 	cfg.c_legacy_compress = false;
 	sbi.feature_incompat = EROFS_FEATURE_INCOMPAT_LZ4_0PADDING;
+	sbi.feature = EROFS_FEATURE_SB_CHKSUM;
 
 	err = mkfs_parse_options_cfg(argc, argv);
 	if (err) {
@@ -301,6 +370,8 @@ int main(int argc, char **argv)
 		err = -EIO;
 	else
 		err = dev_resize(nblocks);
+	if (sbi.feature & EROFS_FEATURE_SB_CHKSUM)
+		erofs_write_sb_checksum();
 exit:
 	z_erofs_compress_exit();
 	dev_close();
-- 
2.9.3

