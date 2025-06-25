Return-Path: <linux-erofs+bounces-489-lists+linux-erofs=lfdr.de@lists.ozlabs.org>
X-Original-To: lists+linux-erofs@lfdr.de
Delivered-To: lists+linux-erofs@lfdr.de
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	by mail.lfdr.de (Postfix) with ESMTPS id 942D1AE7759
	for <lists+linux-erofs@lfdr.de>; Wed, 25 Jun 2025 08:47:17 +0200 (CEST)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4bRsnH1Hx8z30DP;
	Wed, 25 Jun 2025 16:47:15 +1000 (AEST)
X-Original-To: linux-erofs@lists.ozlabs.org
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip=115.124.30.118
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1750834035;
	cv=none; b=mB5Bf9ad8Wno4fknuayKowvRLqgWFhdXn5oweMcZJ9SH4u2qZij+Z9Qs6K6lgtBurVJJwRyXp33mSK2hVAG/qzSvGWR7gGR4B0limdxePVM+gx17g7mRGcwyqpDjL+C6k0Qdd5xsFYaoTRfZXJmtxWSilSRmwXygAaZlf5ITjmYqzWI+44czuZ42t6Qg/wO+mzfDPX5X3jIup4O4vHJkomzq7w/8Zjkbb/wvNBhlaGedszQrI02zDM6p0T90RXt7JzNtlTm0U7ti1AcBqxUvGasQ7a70XQTJZH4OLSjwBClVjIH41NjlMUIDzsyneSdIUJrOY8V9Cepjp+B9jQn7dg==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1750834035; c=relaxed/relaxed;
	bh=DpQHFPwbf2uY2A4gceXVboj8M4r1bgNv8jivfM80Blk=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=JbFe7VSRMPan6gj8b73HzBOgjCWuoFeEuw1XAHdKljnRn2n9NA8KKq4Dr+xK4XMbz2mMkXiAYnFH9Zz0RNymp8aAAkKOyPcxOQTdaOiIj7oZi43OgF19fleMYpGiUWwXhQVqZyZLsm/H8bh24g7VlJQ8BMrY+gFqoEHdahaQcB/xkn1WUzTVnKY3Mjpf1rC/dYT2SLvnx/SgmpzApLWmEf0MZto1SIr2q2d4hh7nSAf0z6Le97GKF3eFJGvsDirZnTMba8iRdGPMeAmI7/f3E+Z7a53DdaQv+TcFdOvKl4IR7/xropDGgudE7GCqyioGvcuFAlWkEB3gjdRhnJeXQg==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com; dkim=pass (1024-bit key; unprotected) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.a=rsa-sha256 header.s=default header.b=HMKE/Rt3; dkim-atps=neutral; spf=pass (client-ip=115.124.30.118; helo=out30-118.freemail.mail.aliyun.com; envelope-from=hsiangkao@linux.alibaba.com; receiver=lists.ozlabs.org) smtp.mailfrom=linux.alibaba.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (1024-bit key; unprotected) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.a=rsa-sha256 header.s=default header.b=HMKE/Rt3;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=linux.alibaba.com (client-ip=115.124.30.118; helo=out30-118.freemail.mail.aliyun.com; envelope-from=hsiangkao@linux.alibaba.com; receiver=lists.ozlabs.org)
Received: from out30-118.freemail.mail.aliyun.com (out30-118.freemail.mail.aliyun.com [115.124.30.118])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4bRsnD3BLwz2yKq
	for <linux-erofs@lists.ozlabs.org>; Wed, 25 Jun 2025 16:47:10 +1000 (AEST)
DKIM-Signature:v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=linux.alibaba.com; s=default;
	t=1750834015; h=From:To:Subject:Date:Message-ID:MIME-Version;
	bh=DpQHFPwbf2uY2A4gceXVboj8M4r1bgNv8jivfM80Blk=;
	b=HMKE/Rt3vPd6ZvspvgauqK4BMqf/yua2Lyuw4Ix+k/PJOnSyBVn57aqb0OwcqpiU8hCExs3rcOFqO0argwquhXR9eY7mZPH0qlMNw51X3kslfF9glfVEEaoPsaWZeom3HHwD32goUwuOvVMKtpvuQxUwTKKGwDoaxaSaHcu8xGk=
Received: from x31i01179.sqa.na131.tbsite.net(mailfrom:hsiangkao@linux.alibaba.com fp:SMTPD_---0Weu6h7S_1750834009 cluster:ay36)
          by smtp.aliyun-inc.com;
          Wed, 25 Jun 2025 14:46:54 +0800
From: Gao Xiang <hsiangkao@linux.alibaba.com>
To: linux-erofs@lists.ozlabs.org
Cc: Gao Xiang <hsiangkao@linux.alibaba.com>
Subject: [PATCH] erofs-utils: fix superblock checksum for sub-page block filesystems
Date: Wed, 25 Jun 2025 14:46:48 +0800
Message-ID: <20250625064648.1766956-1-hsiangkao@linux.alibaba.com>
X-Mailer: git-send-email 2.43.5
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
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-15.7 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,DKIM_VALID_EF,ENV_AND_HDR_SPF_MATCH,RCVD_IN_DNSWL_NONE,
	SPF_HELO_NONE,SPF_PASS,UNPARSEABLE_RELAY,USER_IN_DEF_DKIM_WL,
	USER_IN_DEF_SPF_WL autolearn=disabled version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-25) on lists.ozlabs.org

 - sb_csum isn't generated properly for 512- or 1024-byte filesystem block sizes.

 - Add `--no-sbcrc` option to fsck.erofs to bypass the sb_csum check.

Signed-off-by: Gao Xiang <hsiangkao@linux.alibaba.com>
---
 fsck/main.c              | 40 ++++++++-----------------------
 include/erofs/internal.h |  1 +
 lib/super.c              | 51 ++++++++++++++++++++++++++++++----------
 man/fsck.erofs.1         |  3 +++
 4 files changed, 52 insertions(+), 43 deletions(-)

diff --git a/fsck/main.c b/fsck/main.c
index cb4758b..91c193f 100644
--- a/fsck/main.c
+++ b/fsck/main.c
@@ -41,6 +41,7 @@ struct erofsfsck_cfg {
 	bool preserve_owner;
 	bool preserve_perms;
 	bool dump_xattrs;
+	bool nosbcrc;
 };
 static struct erofsfsck_cfg fsckcfg;
 
@@ -60,6 +61,7 @@ static struct option long_options[] = {
 	{"offset", required_argument, 0, 12},
 	{"xattrs", no_argument, 0, 13},
 	{"no-xattrs", no_argument, 0, 14},
+	{"no-sbcrc", no_argument, 0, 512},
 	{0, 0, 0, 0},
 };
 
@@ -110,6 +112,7 @@ static void usage(int argc, char **argv)
 		" --extract[=X]          check if all files are well encoded, optionally\n"
 		"                        extract to X\n"
 		" --offset=#             skip # bytes at the beginning of IMAGE\n"
+		" --no-sbcrc             bypass the superblock checksum verification\n"
 		" --[no-]xattrs          whether to dump extended attributes (default off)\n"
 		"\n"
 		" -a, -A, -y             no-op, for compatibility with fsck of other filesystems\n"
@@ -244,6 +247,9 @@ static int erofsfsck_parse_options_cfg(int argc, char **argv)
 		case 14:
 			fsckcfg.dump_xattrs = false;
 			break;
+		case 512:
+			fsckcfg.nosbcrc = true;
+			break;
 		default:
 			return -EINVAL;
 		}
@@ -322,35 +328,6 @@ static void erofsfsck_set_attributes(struct erofs_inode *inode, char *path)
 	}
 }
 
-static int erofs_check_sb_chksum(void)
-{
-#ifndef FUZZING
-	u8 buf[EROFS_MAX_BLOCK_SIZE];
-	u32 crc;
-	struct erofs_super_block *sb;
-	int ret;
-
-	ret = erofs_blk_read(&g_sbi, 0, buf, 0, 1);
-	if (ret) {
-		erofs_err("failed to read superblock to check checksum: %d",
-			  ret);
-		return -1;
-	}
-
-	sb = (struct erofs_super_block *)(buf + EROFS_SUPER_OFFSET);
-	sb->checksum = 0;
-
-	crc = erofs_crc32c(~0, (u8 *)sb, erofs_blksiz(&g_sbi) - EROFS_SUPER_OFFSET);
-	if (crc != g_sbi.checksum) {
-		erofs_err("superblock chksum doesn't match: saved(%08xh) calculated(%08xh)",
-			  g_sbi.checksum, crc);
-		fsckcfg.corrupted = true;
-		return -1;
-	}
-#endif
-	return 0;
-}
-
 static int erofs_verify_xattr(struct erofs_inode *inode)
 {
 	struct erofs_sb_info *sbi = inode->sbi;
@@ -1066,6 +1043,7 @@ int main(int argc, char *argv[])
 
 #ifdef FUZZING
 	cfg.c_dbg_lvl = -1;
+	fsckcfg.nosbcrc = true;
 #endif
 
 	err = erofs_dev_open(&g_sbi, cfg.c_img_path, O_RDONLY);
@@ -1080,7 +1058,9 @@ int main(int argc, char *argv[])
 		goto exit_dev_close;
 	}
 
-	if (erofs_sb_has_sb_chksum(&g_sbi) && erofs_check_sb_chksum()) {
+	if (!fsckcfg.nosbcrc && erofs_sb_has_sb_chksum(&g_sbi) &&
+	    erofs_superblock_csum_verify(&g_sbi)) {
+		fsckcfg.corrupted = true;
 		erofs_err("failed to verify superblock checksum");
 		goto exit_put_super;
 	}
diff --git a/include/erofs/internal.h b/include/erofs/internal.h
index bf3efb5..d380c45 100644
--- a/include/erofs/internal.h
+++ b/include/erofs/internal.h
@@ -419,6 +419,7 @@ struct erofs_buffer_head *erofs_reserve_sb(struct erofs_bufmgr *bmgr);
 int erofs_mkfs_init_devices(struct erofs_sb_info *sbi, unsigned int devices);
 int erofs_write_device_table(struct erofs_sb_info *sbi);
 int erofs_enable_sb_chksum(struct erofs_sb_info *sbi, u32 *crc);
+int erofs_superblock_csum_verify(struct erofs_sb_info *sbi);
 
 /* namei.c */
 int erofs_read_inode_from_disk(struct erofs_inode *vi);
diff --git a/lib/super.c b/lib/super.c
index 8efef50..5b90db5 100644
--- a/lib/super.c
+++ b/lib/super.c
@@ -259,19 +259,22 @@ int erofs_enable_sb_chksum(struct erofs_sb_info *sbi, u32 *crc)
 	unsigned int len;
 	struct erofs_super_block *sb;
 
-	ret = erofs_blk_read(sbi, 0, buf, 0, erofs_blknr(sbi, EROFS_SUPER_END) + 1);
+	/*
+	 * skip the first 1024 bytes, to allow for the installation
+	 * of x86 boot sectors and other oddities.
+	 */
+	if (erofs_blksiz(sbi) > EROFS_SUPER_OFFSET)
+		len = erofs_blksiz(sbi) - EROFS_SUPER_OFFSET;
+	else
+		len = erofs_blksiz(sbi);
+	ret = erofs_dev_read(sbi, 0, buf, EROFS_SUPER_OFFSET, len);
 	if (ret) {
 		erofs_err("failed to read superblock to set checksum: %s",
 			  erofs_strerror(ret));
 		return ret;
 	}
 
-	/*
-	 * skip the first 1024 bytes, to allow for the installation
-	 * of x86 boot sectors and other oddities.
-	 */
-	sb = (struct erofs_super_block *)(buf + EROFS_SUPER_OFFSET);
-
+	sb = (struct erofs_super_block *)buf;
 	if (le32_to_cpu(sb->magic) != EROFS_SUPER_MAGIC_V1) {
 		erofs_err("internal error: not an erofs valid image");
 		return -EFAULT;
@@ -280,25 +283,47 @@ int erofs_enable_sb_chksum(struct erofs_sb_info *sbi, u32 *crc)
 	/* turn on checksum feature */
 	sb->feature_compat = cpu_to_le32(le32_to_cpu(sb->feature_compat) |
 					 EROFS_FEATURE_COMPAT_SB_CHKSUM);
-	if (erofs_blksiz(sbi) > EROFS_SUPER_OFFSET)
-		len = erofs_blksiz(sbi) - EROFS_SUPER_OFFSET;
-	else
-		len = erofs_blksiz(sbi);
 	*crc = erofs_crc32c(~0, (u8 *)sb, len);
 
 	/* set up checksum field to erofs_super_block */
 	sb->checksum = cpu_to_le32(*crc);
 
-	ret = erofs_blk_write(sbi, buf, 0, 1);
+	ret = erofs_dev_write(sbi, buf, EROFS_SUPER_OFFSET, len);
 	if (ret) {
 		erofs_err("failed to write checksummed superblock: %s",
 			  erofs_strerror(ret));
 		return ret;
 	}
-
 	return 0;
 }
 
+int erofs_superblock_csum_verify(struct erofs_sb_info *sbi)
+{
+	u32 len = erofs_blksiz(sbi), crc;
+	u8 buf[EROFS_MAX_BLOCK_SIZE];
+	struct erofs_super_block *sb;
+	int ret;
+
+	if (len > EROFS_SUPER_OFFSET)
+		len -= EROFS_SUPER_OFFSET;
+	ret = erofs_dev_read(sbi, 0, buf, EROFS_SUPER_OFFSET, len);
+	if (ret) {
+		erofs_err("failed to read superblock to calculate sbcsum: %d",
+			  ret);
+		return -1;
+	}
+
+	sb = (struct erofs_super_block *)buf;
+	sb->checksum = 0;
+
+	crc = erofs_crc32c(~0, (u8 *)sb, len);
+	if (crc == sbi->checksum)
+		return 0;
+	erofs_err("invalid checksum 0x%08x, 0x%08x expected",
+		  sbi->checksum, crc);
+	return -EBADMSG;
+}
+
 int erofs_mkfs_init_devices(struct erofs_sb_info *sbi, unsigned int devices)
 {
 	struct erofs_buffer_head *bh;
diff --git a/man/fsck.erofs.1 b/man/fsck.erofs.1
index af0e6ab..fb255b4 100644
--- a/man/fsck.erofs.1
+++ b/man/fsck.erofs.1
@@ -34,6 +34,9 @@ take a long time depending on the image size.
 
 Optionally extract contents of the \fIIMAGE\fR to \fIdirectory\fR.
 .TP
+.B "--no-sbcrc"
+Bypass the on-disk superblock checksum verification.
+.TP
 .BI "--[no-]xattrs"
 Whether to dump extended attributes during extraction (default off).
 .TP
-- 
2.43.5


