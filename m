Return-Path: <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>
X-Original-To: lists+linux-erofs@lfdr.de
Delivered-To: lists+linux-erofs@lfdr.de
Received: from lists.ozlabs.org (lists.ozlabs.org [203.11.71.2])
	by mail.lfdr.de (Postfix) with ESMTPS id ED120D65BA
	for <lists+linux-erofs@lfdr.de>; Mon, 14 Oct 2019 17:00:24 +0200 (CEST)
Received: from bilbo.ozlabs.org (lists.ozlabs.org [IPv6:2401:3900:2:1::3])
	by lists.ozlabs.org (Postfix) with ESMTP id 46sMDk0ndczDqpv
	for <lists+linux-erofs@lfdr.de>; Tue, 15 Oct 2019 02:00:22 +1100 (AEDT)
X-Original-To: linux-erofs@lists.ozlabs.org
Delivered-To: linux-erofs@lists.ozlabs.org
Authentication-Results: lists.ozlabs.org;
 spf=pass (mailfrom) smtp.mailfrom=gmail.com
 (client-ip=2607:f8b0:4864:20::441; helo=mail-pf1-x441.google.com;
 envelope-from=pratikshinde320@gmail.com; receiver=<UNKNOWN>)
Authentication-Results: lists.ozlabs.org;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: lists.ozlabs.org; dkim=pass (2048-bit key;
 unprotected) header.d=gmail.com header.i=@gmail.com header.b="THHyxk+o"; 
 dkim-atps=neutral
Received: from mail-pf1-x441.google.com (mail-pf1-x441.google.com
 [IPv6:2607:f8b0:4864:20::441])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 46sMDb5pQ4zDqpd
 for <linux-erofs@lists.ozlabs.org>; Tue, 15 Oct 2019 02:00:15 +1100 (AEDT)
Received: by mail-pf1-x441.google.com with SMTP id q5so10526993pfg.13
 for <linux-erofs@lists.ozlabs.org>; Mon, 14 Oct 2019 08:00:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=from:to:cc:subject:date:message-id;
 bh=mldgPsfkpxqeu2vkiiRje5Lhm/EhiZb/ffyZSGZAD+s=;
 b=THHyxk+ozIYg9EcYUuN+yGwiyE2GpCKbkcJ8b6huTT0DE4lnyLTllmMzJqfYTPgnkd
 W/91qwC12KHD7BLpGC/VBGSP51hXxwVwio+ZSOv7HonfDMftNrDwq0rtzGfrJeFruox/
 hV5ReLyVqUgIuJwRWyHsexRR8jCS8Hfl9HQ6m7j69o3buwO0ox9k5BCItWW7PNjnKj4V
 mZGaVBWotzVRCw038Duovdav/CwHj/7ZjLhmFKrRwFVkYRl6u5F47upvFOG1mpdxtAyc
 vnyyaVhcMPLHlRBLu6rk+CqE+nYel1g6WZBSvH6RSqHZQ9ikAERatGnG0+Ok8seIXsWK
 WY9g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id;
 bh=mldgPsfkpxqeu2vkiiRje5Lhm/EhiZb/ffyZSGZAD+s=;
 b=sC8GihdNJygQPtWKKEoRthdLKA7Z/1XcyWo7eA0LXQTQ3e2HEZ1pXx5xlFBWpenw8y
 AAc51XbvNH01HYwSQe7+m6fcwDotHM2bai2bhi+9gl2bnWylhFjg/RPaeWDBUm/q6LcE
 Y93cMPPaarzpqqjeibwEOWNC6Zx9ZcLpAe0jfTeAOn543IUNbYCcbJWR33dnqB2GmW4I
 iVKYKyv5Y4oQwwaMOtsPmUya1qiSGvcUMwP+opd+Dzexkmar2CHw88sT09Y7b6AiM+VV
 +BIL7HMNLpvNqSSApNu8KHBHyqCi5jQVCPdgQACZFBcuRErMFr8unANDwzGn1LcLDBkv
 Nszg==
X-Gm-Message-State: APjAAAWcPEy1UIZ/KRIp5wZHrVCclsor3rV7BsD6MVDeTQ/LsHtCHHfy
 woYQYdzS4zMIjrTx3J8WGHiGCgzMUP1grQ==
X-Google-Smtp-Source: APXvYqymPzvUw0mDIAlCmssyeEjR5Ncgzs6O3uYfUx2Srd2o3bw0kownDw43QZQ7SUm77iBdaMF2Ig==
X-Received: by 2002:a63:5949:: with SMTP id j9mr33282285pgm.371.1571065211574; 
 Mon, 14 Oct 2019 08:00:11 -0700 (PDT)
Received: from localhost.localdomain ([139.5.48.178])
 by smtp.gmail.com with ESMTPSA id h2sm26902457pfq.108.2019.10.14.08.00.08
 (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
 Mon, 14 Oct 2019 08:00:10 -0700 (PDT)
From: Pratik Shinde <pratikshinde320@gmail.com>
To: linux-erofs@lists.ozlabs.org, bluce.liguifu@huawei.com, miaoxie@huawei.com,
 fangwei1@huawei.com
Subject: [PATCH-v2] erofs-utils:code for calculating crc checksum of erofs
 blocks.
Date: Mon, 14 Oct 2019 20:29:43 +0530
Message-Id: <20191014145943.2653-1-pratikshinde320@gmail.com>
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

modified patch based on review comments.

Signed-off-by: Pratik Shinde <pratikshinde320@gmail.com>
---
 include/erofs/internal.h |  1 +
 include/erofs/io.h       |  8 +++++
 lib/io.c                 | 27 +++++++++++++++++
 mkfs/main.c              | 76 ++++++++++++++++++++++++++++++++++++++++++++++++
 4 files changed, 112 insertions(+)

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
index 91a018f..baaf02a 100644
--- a/mkfs/main.c
+++ b/mkfs/main.c
@@ -22,6 +22,10 @@
 
 #define EROFS_SUPER_END (EROFS_SUPER_OFFSET + sizeof(struct erofs_super_block))
 
+/* number of blocks for calculating checksum */
+#define EROFS_CKSUM_BLOCKS	1
+#define EROFS_FEATURE_SB_CHKSUM	0x0001
+
 static void usage(void)
 {
 	fprintf(stderr, "usage: [options] FILE DIRECTORY\n\n");
@@ -85,6 +89,10 @@ static int parse_extended_opts(const char *opts)
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
@@ -180,6 +188,7 @@ int erofs_mkfs_update_super_block(struct erofs_buffer_head *bh,
 		.meta_blkaddr  = sbi.meta_blkaddr,
 		.xattr_blkaddr = 0,
 		.feature_incompat = cpu_to_le32(sbi.feature_incompat),
+		.checksum = 0
 	};
 	const unsigned int sb_blksize =
 		round_up(EROFS_SUPER_END, EROFS_BLKSIZ);
@@ -202,6 +211,70 @@ int erofs_mkfs_update_super_block(struct erofs_buffer_head *bh,
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
+		erofs_err("Failed to calculate erofs checksum - %s",
+			  erofs_strerror(err));
+		return err;
+	}
+	*crc = crc32c(0, (const unsigned char *)buf, nblks * EROFS_BLKSIZ);
+	free(buf);
+	return 0;
+}
+
+void erofs_write_checksum()
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
@@ -217,6 +290,7 @@ int main(int argc, char **argv)
 
 	cfg.c_legacy_compress = false;
 	sbi.feature_incompat = EROFS_FEATURE_INCOMPAT_LZ4_0PADDING;
+	sbi.feature = EROFS_FEATURE_SB_CHKSUM;
 
 	err = mkfs_parse_options_cfg(argc, argv);
 	if (err) {
@@ -301,6 +375,8 @@ int main(int argc, char **argv)
 		err = -EIO;
 	else
 		err = dev_resize(nblocks);
+	if (sbi.feature & EROFS_FEATURE_SB_CHKSUM)
+		erofs_write_checksum();
 exit:
 	z_erofs_compress_exit();
 	dev_close();
-- 
2.9.3

