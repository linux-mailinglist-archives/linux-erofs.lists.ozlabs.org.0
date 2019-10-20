Return-Path: <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>
X-Original-To: lists+linux-erofs@lfdr.de
Delivered-To: lists+linux-erofs@lfdr.de
Received: from lists.ozlabs.org (lists.ozlabs.org [203.11.71.2])
	by mail.lfdr.de (Postfix) with ESMTPS id 1BCCEDDECC
	for <lists+linux-erofs@lfdr.de>; Sun, 20 Oct 2019 16:12:05 +0200 (CEST)
Received: from bilbo.ozlabs.org (lists.ozlabs.org [IPv6:2401:3900:2:1::3])
	by lists.ozlabs.org (Postfix) with ESMTP id 46x1tB0JcYzDqNN
	for <lists+linux-erofs@lfdr.de>; Mon, 21 Oct 2019 01:12:02 +1100 (AEDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=lists.ozlabs.org;
	s=201707; t=1571580722;
	bh=hSKflkgzaMNNDGK8slvxNserl/JGSzqmgz4sGIJkiAE=;
	h=Date:To:Subject:References:In-Reply-To:List-Id:List-Unsubscribe:
	 List-Archive:List-Post:List-Help:List-Subscribe:From:Reply-To:Cc:
	 From;
	b=Gd+1M4DUQolhP3A6S4CFDbHfBrorKJCNsyju1BvQUvEJdNMjBnpq+4knsRWOMLt7Q
	 50jpldTIKAXh+8NnTpX5xSDKZQiO5Eq57LWv5uQg0foOOPqgC8D5+uktV5REDMEL0P
	 Gutk9Vd9qisaOhhCN5QfD41MdxuXKsi32EMn9Ym4oen2w0iMScyvxSoSiZTMVLPe6r
	 ENWNki81+kmc7yhJvDqQfoRWRzyKAb6S9cvNJuoiR/9WAMiBLHE1x4hm4+ccs5ENDw
	 coDcKmpkiAEcuXghUUZEhg10e4RPrxAI4tIYIASYEeYoUqRe0rOJ1Z7yElNji9pIAK
	 f5/ynKXKIcCQg==
X-Original-To: linux-erofs@lists.ozlabs.org
Delivered-To: linux-erofs@lists.ozlabs.org
Authentication-Results: lists.ozlabs.org;
 spf=pass (sender SPF authorized) smtp.mailfrom=aol.com
 (client-ip=77.238.177.32; helo=sonic310-11.consmr.mail.ir2.yahoo.com;
 envelope-from=hsiangkao@aol.com; receiver=<UNKNOWN>)
Authentication-Results: lists.ozlabs.org;
 dmarc=pass (p=reject dis=none) header.from=aol.com
Authentication-Results: lists.ozlabs.org; dkim=pass (2048-bit key;
 unprotected) header.d=aol.com header.i=@aol.com header.b="r8f5ICqf"; 
 dkim-atps=neutral
Received: from sonic310-11.consmr.mail.ir2.yahoo.com
 (sonic310-11.consmr.mail.ir2.yahoo.com [77.238.177.32])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 46x1t31YVLzDqNC
 for <linux-erofs@lists.ozlabs.org>; Mon, 21 Oct 2019 01:11:51 +1100 (AEDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=aol.com; s=a2048;
 t=1571580707; bh=Y1l0wx18wuQstkaZXyva39/EUcH7QH1CR9o9Tzt6myQ=;
 h=Date:From:To:Cc:Subject:References:In-Reply-To:From:Subject;
 b=r8f5ICqf8TJx/Uvb6200rXnFcvwgdJK4C0iUY9R6UxnsdoAIKk30Mdp/LGhqMO/5pcjk6JwoKQrvp1Y4S9kKzwK6GXScmajE7jJmbZTJO5sAYLNhQsqRNDyci3tDNI7gZXb34fOTSKqPDqgIj/J7trZAG8LPvH+VITDz3piR4J4LERbcxOQdIpLYR2PsAQLeqDkSmblo3LDunuNaH7lqMD1eYw83wzKeSzc7HyMz0gXGcu09rhSJrYPC0Ecitd40JiVoE9j1yJgrPdJaDgolUJva3VasrVKfqgQmwKYa0UzC/c1jyZA0FT4ajRp7zVn0OqeYt1yn7+/dHJ8JRR2Ntw==
X-YMail-OSG: ZGuNK_EVM1loGjrAD314aA2Pg4zyXu.CBSUneM26SvywW6_DOKfB8VFQNAnbB1.
 XdoGnGfFuLEJC1ld9cLFSfOeyLLQlM_Q14oMrZhv.1Ol0Bu264Xb6LUiS9Kd24dajILskuHyVLKN
 PMhDvkzb24SzKgt2rKdqdY7hiTb42.CFuAgnI1MLNHZK8oqDxvq0y3rvorC92ai.aiHoqlVTvQ.U
 5fM2EQnR6b2BSRiEbnhJ7LlGVASBHefQIY2PKlqBbIGx24Y9OJqBkQOJWZRFKdlpnPKE4CtUcYRy
 r7TiSAi9PdN9frkj_LT5o45FaGM.2_zyCIDAzi6mKZOQ3vKM3kHQ38yMRkY0R1eloC4DURPKBHcY
 LGh8nGjyjkkmKj9TnhlfPGlVIVnOPGBnJx9_HNKSPx5JqGjC12jORqANlXC7lCMuf0BRxw12t0Xk
 YpZq.dtTqcgTgbtccyEWCbLYdQLWciJC4HEqc4yKrxngx4HQbhdRMsJWXT8knVEhA01jZNzEp4oY
 rrFDqRpsggU7ZY1Y12kZM8CbOlruxSGQY7Gj.IZfVjnkrzGUZqsq_dAtTN1kFM67ONhjNh8_.s7E
 r.Op4saMpsFkkoc2ufY7b2TqSi5MNk7Xz70ZoC1YjVGH.M4g3VTDEMom0sJmhlbNPaFKHc6ui5ju
 HZMOzC4jDqLnNvzuJIYvshUTnh4YxPC67K3bPv3K2xSZ5WE5qnvp9mMDlzIuoM5UpJRg1JS5q772
 bu69LMRAruVkm.kAzUpBUIBaVzGK0SPHxH7axl.Uh9hW03ASPbQLezOiZnnO543s92_3zgqslZFa
 twEg8hVeIW2nV2kS4zgFjidPC2Mq0IUNmiL.IsJ_iVOd6zZUwUkNHCve9R.nflae5y9xzB9Jgp6j
 9C0eNf5q_ikbHeuz8XkE69szBO_cyN.RYIxWZl1Ty2uXoA1zcfdS2mIivGEquzTXNzFEyg6c34UD
 newK50ZT15j8AIRaBfBRlvKfoWegUOo5fsiFrcFkNTw4a5RS3n5mfouhf.Luzk5QYKzSUME9RtnP
 cDmQ70PdsGsuygnBMPxsArouN4TWMmr6RPgVwgXE9JC.cMLzBydvhLvD_AHrcotq3vXitydhnhGb
 4uVb0PRdQgqszxEvPqJb4i_sYFK7_55SkCMQq6IDEy6CFcWHvWL2qFq2eB9oe7GGsF90E2yuDVM7
 mv_KKceQPqSMspdnha0VIrov1tdzxpaBVAepkbPEVSt3R67gLcsYHuxbskhm8_w4LFL6I9FZEI3W
 mJXGhijCZXeraSTfNAfPZVYOALm_AxJhNUZY6SdW4HrGzHPDXDwemsjLTVXNhz_HnJimphPB6Vau
 wMTzAIZerKshqY3KiUDLbM3Zr7IMOAyjaHng-
Received: from sonic.gate.mail.ne1.yahoo.com by
 sonic310.consmr.mail.ir2.yahoo.com with HTTP; Sun, 20 Oct 2019 14:11:47 +0000
Received: by smtp420.mail.ir2.yahoo.com (Oath Hermes SMTP Server) with ESMTPA
 ID f2862740572f26a0d438836b0b942179; 
 Sun, 20 Oct 2019 14:11:42 +0000 (UTC)
Date: Sun, 20 Oct 2019 22:11:09 +0800
To: Pratik Shinde <pratikshinde320@gmail.com>
Subject: Re: [PATCH-v5] erofs-utils:code for calculating crc checksum of
 erofs blocks
Message-ID: <20191020141102.GA30399@hsiangkao-HP-ZHAN-66-Pro-G1>
References: <20191019150803.9259-1-pratikshinde320@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20191019150803.9259-1-pratikshinde320@gmail.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
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
From: Gao Xiang via Linux-erofs <linux-erofs@lists.ozlabs.org>
Reply-To: Gao Xiang <hsiangkao@aol.com>
Cc: miaoxie@huawei.com, linux-erofs@lists.ozlabs.org
Errors-To: linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org
Sender: "Linux-erofs"
 <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>

Hi Pratik and other folks,

On Sat, Oct 19, 2019 at 08:38:03PM +0530, Pratik Shinde wrote:
> Added code for calculating crc of erofs blocks (4K size).for now it calculates
> checksum of first block. but can modified to calculate crc for any no. of blocks
> 
> Fill 'feature_compat' field of erofs_super_block so that it
> can be used on kernel side. also fixing one typo.
> 
> Signed-off-by: Pratik Shinde <pratikshinde320@gmail.com>

I will submit the following patch to experimental branch, some
TODOs in it (and an additional TODO which is not mentioned in code
is to move crc32c() to include/erofs/crc32.h).

Further updates or comments for this version are welcomed.

BTW, for all valid fields in feature_compat or feature_incompat,
I'd like to introduce a -O option to toggle them as well (e.g.
-O +sbcrc or -O -sbcrc), which is not in this version as well...

Thanks,
Gao Xiang

From d96b797f86f2526e4f94a483d6b6442b53e61861 Mon Sep 17 00:00:00 2001
From: Pratik Shinde <pratikshinde320@gmail.com>
Date: Sat, 19 Oct 2019 20:38:03 +0530
Subject: [PATCH v6] erofs-utils: code for calculating crc checksum of erofs
 blocks

Added code for calculating crc of erofs blocks (4K size).
For now it calculates checksum of first block. but it can
be modified to calculate crc for any no. of blocks

Fill 'feature_compat' field of erofs_super_block so that it
can be used on kernel side. also fixing one typo.

Signed-off-by: Pratik Shinde <pratikshinde320@gmail.com>
[ Gao Xiang: minor updates based on Pratik patch. ]
Signed-off-by: Gao Xiang <hsiangkao@aol.com>
---
change since v5:
 - rename 'feature' to 'feature_compat' (so does related macro).
 - add some print messages;
 - fill all checksum fields in erofs_write_sb_checksum();
 - fix a memory leak in error handling path.

 include/erofs/internal.h |  1 +
 include/erofs/io.h       |  8 ++++
 include/erofs_fs.h       |  6 ++-
 lib/io.c                 | 27 ++++++++++++
 mkfs/main.c              | 92 ++++++++++++++++++++++++++++++++++++++++
 5 files changed, 132 insertions(+), 2 deletions(-)

diff --git a/include/erofs/internal.h b/include/erofs/internal.h
index 25ce7b5..9e2bb9c 100644
--- a/include/erofs/internal.h
+++ b/include/erofs/internal.h
@@ -52,6 +52,7 @@ struct erofs_sb_info {
 	erofs_blk_t meta_blkaddr;
 	erofs_blk_t xattr_blkaddr;
 
+	u32 feature_compat;
 	u32 feature_incompat;
 	u64 build_time;
 	u32 build_time_nsec;
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
index f29aa25..8daf043 100644
--- a/include/erofs_fs.h
+++ b/include/erofs_fs.h
@@ -13,6 +13,8 @@
 #define EROFS_SUPER_MAGIC_V1    0xE0F5E1E2
 #define EROFS_SUPER_OFFSET      1024
 
+#define EROFS_FEATURE_COMPAT_SB_CHKSUM		0x00000001
+
 /*
  * Any bits that aren't in EROFS_ALL_FEATURE_INCOMPAT should
  * be incompatible with this kernel version.
@@ -39,8 +41,8 @@ struct erofs_super_block {
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
index 71c81f5..fe84441 100644
--- a/mkfs/main.c
+++ b/mkfs/main.c
@@ -23,6 +23,9 @@
 
 #define EROFS_SUPER_END (EROFS_SUPER_OFFSET + sizeof(struct erofs_super_block))
 
+/* number of blocks for calculating checksum */
+#define EROFS_CKSUM_BLOCKS	1
+
 static void usage(void)
 {
 	fprintf(stderr, "usage: [options] FILE DIRECTORY\n\n");
@@ -87,6 +90,12 @@ static int parse_extended_opts(const char *opts)
 				return -EINVAL;
 			cfg.c_force_inodeversion = FORCE_INODE_EXTENDED;
 		}
+
+		if (MATCH_EXTENTED_OPT("nosbcrc", token, keylen)) {
+			if (vallen)
+				return -EINVAL;
+			sbi.feature_compat &= ~EROFS_FEATURE_COMPAT_SB_CHKSUM;
+		}
 	}
 	return 0;
 }
@@ -191,6 +200,8 @@ int erofs_mkfs_update_super_block(struct erofs_buffer_head *bh,
 		.meta_blkaddr  = sbi.meta_blkaddr,
 		.xattr_blkaddr = sbi.xattr_blkaddr,
 		.feature_incompat = cpu_to_le32(sbi.feature_incompat),
+		.feature_compat = cpu_to_le32(sbi.feature_compat &
+					      ~EROFS_FEATURE_COMPAT_SB_CHKSUM),
 	};
 	const unsigned int sb_blksize =
 		round_up(EROFS_SUPER_END, EROFS_BLKSIZ);
@@ -213,6 +224,83 @@ int erofs_mkfs_update_super_block(struct erofs_buffer_head *bh,
 	return 0;
 }
 
+#define CRCPOLY	0x82F63B78
+static inline u32 crc32c(u32 seed, const u8 *in, size_t len)
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
+static int erofs_calc_blk_checksum(erofs_blk_t nblks, u32 *crc)
+{
+	char *buf;
+	int err;
+
+	/* TODO: limit memory size by mutiple reads */
+	buf = malloc(nblks * EROFS_BLKSIZ);
+	if (!buf)
+		return -ENOMEM;
+
+	err = blk_read(buf, 0, nblks);
+	if (err)
+		goto out;
+
+	*crc = crc32c(0, (const u8 *)buf, nblks * EROFS_BLKSIZ);
+out:
+	free(buf);
+	return err;
+}
+
+static int erofs_write_sb_checksum(void)
+{
+	struct erofs_super_block *sb;
+	char buf[EROFS_BLKSIZ];
+	int ret;
+	u32 crc;
+
+	ret = erofs_calc_blk_checksum(EROFS_CKSUM_BLOCKS, &crc);
+	if (ret) {
+		erofs_err("failed to calculate checksum: %s",
+			  erofs_strerror(ret));
+		return ret;
+	}
+
+	/* TODO: no need to reread super block */
+	ret = blk_read(buf, 0, 1);
+	if (ret) {
+		erofs_err("failed to read superblock to fill checksum");
+		return -EIO;
+	}
+
+	sb = (struct erofs_super_block *)((u8 *)buf + EROFS_SUPER_OFFSET);
+	if (le32_to_cpu(sb->magic) != EROFS_SUPER_MAGIC_V1) {
+		erofs_err("internal error: not an erofs valid image");
+		return -EFAULT;
+	}
+	/* set up checksum field to erofs_super_block */
+	sb->feature_compat = cpu_to_le32(le32_to_cpu(sb->feature_compat) |
+					 EROFS_FEATURE_COMPAT_SB_CHKSUM);
+	sb->chksum_blocks = cpu_to_le32(EROFS_CKSUM_BLOCKS);
+	sb->checksum = cpu_to_le32(crc);
+	ret = blk_write(buf, 0, 1);
+	if (ret) {
+		erofs_err("failed to write checksumed superblock: %s",
+			  erofs_strerror(ret));
+		return ret;
+	}
+	erofs_info("superblock checksum 0x%08x written", crc);
+	return 0;
+}
+
 int main(int argc, char **argv)
 {
 	int err = 0;
@@ -228,6 +316,7 @@ int main(int argc, char **argv)
 
 	cfg.c_legacy_compress = false;
 	sbi.feature_incompat = EROFS_FEATURE_INCOMPAT_LZ4_0PADDING;
+	sbi.feature_compat = EROFS_FEATURE_COMPAT_SB_CHKSUM;
 
 	err = mkfs_parse_options_cfg(argc, argv);
 	if (err) {
@@ -310,6 +399,9 @@ int main(int argc, char **argv)
 		err = -EIO;
 	else
 		err = dev_resize(nblocks);
+
+	if (sbi.feature_compat & EROFS_FEATURE_COMPAT_SB_CHKSUM)
+		erofs_write_sb_checksum();
 exit:
 	z_erofs_compress_exit();
 	dev_close();
-- 
2.17.1


