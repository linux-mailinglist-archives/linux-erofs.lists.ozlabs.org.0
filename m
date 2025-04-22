Return-Path: <linux-erofs+bounces-210-lists+linux-erofs=lfdr.de@lists.ozlabs.org>
X-Original-To: lists+linux-erofs@lfdr.de
Delivered-To: lists+linux-erofs@lfdr.de
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2404:9400:2:0:216:3eff:fee1:b9f1])
	by mail.lfdr.de (Postfix) with ESMTPS id F0098A96AB0
	for <lists+linux-erofs@lfdr.de>; Tue, 22 Apr 2025 14:45:33 +0200 (CEST)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4Zhhm65GMVz3bmk;
	Tue, 22 Apr 2025 22:45:26 +1000 (AEST)
X-Original-To: linux-erofs@lists.ozlabs.org
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip=45.249.212.255
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1745325926;
	cv=none; b=bMGbG5Nd9acwTwlZn2GLHKlwPexT6UXrVAlVeNQPoxpV6H2jdlekouwGB2fKN3sv7eSlWzXn5rvqAvZhIhw3g1slCWB0E20HYmbVhuKL1p2uVrFb8XkTIf6jYqChnSW8Dac4ly+mXVU7NY6UDQ3ECmxJYC+Ys0D4S+zbkltABDugOqmcJqDq+qYe0b/JeO8dLoONv5z8IyOABbM2PICz3Z4ngjsWXrB7ZPpy6L5b60H0Nl6s08rKlty8BDaU5BALjh/6ArMBXwygxxl4Y64hfl8ouJxjt9NTk4OTj4EkR9PfZCU9lodOHm24LGQqZqGibAmroazLN3fuvSpa2bYQFg==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1745325926; c=relaxed/relaxed;
	bh=l1o+ONtqvPXhJM1YyRPF4dB5gfG4kiBxM/89PcCsOIQ=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=JsSuoGVBsqN51qHfEr7tasBNkCyBSglF5ENVlwsDDS81HtMK8rvGJgdi/3sBNtZbiYWKNgbDbovRTNVq8yA8msO7uKkguW8ndfaV0XUufKAQlpqL4VRQLIfZVSTD5Il2zn/mMiwWE5aEs/+BGtgg+jCEY+ZWpPMGA2X5t/9+3ASG4tlfKlPbmBO76SAK2YdTXHG+XiVv8jKzlL+1eSrRmm69+AHkIGynpRRXFeXBuGX4AAKwKWjnGx0Q75tEGR7PCho4g/7OPHtY0dE2B6qD/W/4x/cFARBinyJIuW+KXc3g0iVNATTUxI+fmElsbDLKK4F+zunycej4XToQcnv8/w==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass (client-ip=45.249.212.255; helo=szxga08-in.huawei.com; envelope-from=lihongbo22@huawei.com; receiver=lists.ozlabs.org) smtp.mailfrom=huawei.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=huawei.com (client-ip=45.249.212.255; helo=szxga08-in.huawei.com; envelope-from=lihongbo22@huawei.com; receiver=lists.ozlabs.org)
Received: from szxga08-in.huawei.com (szxga08-in.huawei.com [45.249.212.255])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4Zhhm36XCgz3bsR
	for <linux-erofs@lists.ozlabs.org>; Tue, 22 Apr 2025 22:45:23 +1000 (AEST)
Received: from mail.maildlp.com (unknown [172.19.163.252])
	by szxga08-in.huawei.com (SkyGuard) with ESMTP id 4Zhhks5Zngz1d107;
	Tue, 22 Apr 2025 20:44:21 +0800 (CST)
Received: from kwepemo500009.china.huawei.com (unknown [7.202.194.199])
	by mail.maildlp.com (Postfix) with ESMTPS id 7D7E7180B50;
	Tue, 22 Apr 2025 20:45:19 +0800 (CST)
Received: from huawei.com (10.67.174.162) by kwepemo500009.china.huawei.com
 (7.202.194.199) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.11; Tue, 22 Apr
 2025 20:45:18 +0800
From: Hongbo Li <lihongbo22@huawei.com>
To: <xiang@kernel.org>, <chao@kernel.org>, <huyue2@coolpad.com>,
	<jefflexu@linux.alibaba.com>
CC: <linux-erofs@lists.ozlabs.org>, <linux-kernel@vger.kernel.org>,
	<lihongbo22@huawei.com>
Subject: [PATCH RFC 3/4] erofs-utils: lib: add --meta_only format option
Date: Tue, 22 Apr 2025 12:36:11 +0000
Message-ID: <20250422123612.261764-4-lihongbo22@huawei.com>
X-Mailer: git-send-email 2.22.0
In-Reply-To: <20250422123612.261764-1-lihongbo22@huawei.com>
References: <20250422123612.261764-1-lihongbo22@huawei.com>
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
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.67.174.162]
X-ClientProxiedBy: dggems703-chm.china.huawei.com (10.3.19.180) To
 kwepemo500009.china.huawei.com (7.202.194.199)
X-Spam-Status: No, score=-2.3 required=3.0 tests=RCVD_IN_DNSWL_MED,
	SPF_HELO_NONE,SPF_PASS autolearn=disabled version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-25) on lists.ozlabs.org

This option is used to drop the data part based on --meta_fix.
It allows the user can only get the metadata part of the erofs
images.

Signed-off-by: Hongbo Li <lihongbo22@huawei.com>
---
 include/erofs/blobraw.h |  3 ++-
 include/erofs/config.h  |  1 +
 lib/blobraw.c           | 42 ++++++++++++++++++++++++-----------------
 lib/inode.c             |  2 +-
 mkfs/main.c             | 12 ++++++++++++
 5 files changed, 41 insertions(+), 19 deletions(-)

diff --git a/include/erofs/blobraw.h b/include/erofs/blobraw.h
index d56bb46..68df6b8 100755
--- a/include/erofs/blobraw.h
+++ b/include/erofs/blobraw.h
@@ -14,8 +14,9 @@ extern "C"
 
 #include "erofs/internal.h"
 
+erofs_blk_t erofs_blobraw_total(struct erofs_sb_info *sbi);
 void erofs_blobraw_remap_blkaddr(struct erofs_inode *inode);
-int erofs_blobraw_write_file(struct erofs_inode *inode, int fd);
+int erofs_blobraw_write_file(struct erofs_inode *inode, int fd, bool drop_blob);
 int erofs_blobraw_init();
 void erofs_blobraw_exit();
 int erofs_mkfs_dump_rawblob(struct erofs_sb_info *sbi, bool drop_blob);
diff --git a/include/erofs/config.h b/include/erofs/config.h
index ac6dd9b..491b3aa 100644
--- a/include/erofs/config.h
+++ b/include/erofs/config.h
@@ -67,6 +67,7 @@ struct erofs_configure {
 	bool c_ovlfs_strip;
 	bool c_hard_dereference;
 	bool c_meta_fix;
+	bool c_meta_only;
 
 #ifdef HAVE_LIBSELINUX
 	struct selabel_handle *sehnd;
diff --git a/lib/blobraw.c b/lib/blobraw.c
index 248fc30..9113a49 100755
--- a/lib/blobraw.c
+++ b/lib/blobraw.c
@@ -17,13 +17,19 @@ static int blobfile = -1;		/* tmp fd for blob buffer */
 static erofs_blk_t remapped_base;	/* metadata block end address */
 static erofs_off_t bloboff;		/* current blob file offset */
 
+erofs_blk_t erofs_blobraw_total(struct erofs_sb_info *sbi)
+{
+	return erofs_blknr(sbi, bloboff);
+}
+
 void erofs_blobraw_remap_blkaddr(struct erofs_inode *inode)
 {
 	if (inode->i_size > 0)
 		inode->u.i_blkaddr += remapped_base;
 }
 
-int erofs_blobraw_write_file(struct erofs_inode *inode, int fd)
+int erofs_blobraw_write_file(struct erofs_inode *inode,
+				     int fd, bool drop_blob)
 {
 	static u8 zeroed[EROFS_MAX_BLOCK_SIZE];
 	struct erofs_sb_info *sbi = inode->sbi;
@@ -32,22 +38,24 @@ int erofs_blobraw_write_file(struct erofs_inode *inode, int fd)
 	ssize_t length, ret, isize = inode->i_size;
 	u64 pos_in, pos_out = bloboff;
 
-	pos_in = 0;
-	do {
-		length = min_t(erofs_off_t, isize,  SSIZE_MAX);
-		ret = erofs_copy_file_range(fd, &pos_in,
-				blobfile, &pos_out, length);
-	} while (ret > 0 && (isize -= ret));
-
-	foff = lseek(blobfile, inode->i_size, SEEK_CUR);
-	DBG_BUGON(foff != bloboff + inode->i_size);
-
-	padding = erofs_blkoff(sbi, inode->i_size);
-	if (padding) {
-		padding = erofs_blksiz(sbi) - padding;
-		ret = __erofs_io_write(blobfile, zeroed, padding);
-		if (ret > 0 && ret != padding)
-			return -EIO;
+	if (!drop_blob) {
+		pos_in = 0;
+		do {
+			length = min_t(erofs_off_t, isize,  SSIZE_MAX);
+			ret = erofs_copy_file_range(fd, &pos_in,
+					blobfile, &pos_out, length);
+		} while (ret > 0 && (isize -= ret));
+
+		foff = lseek(blobfile, inode->i_size, SEEK_CUR);
+		DBG_BUGON(foff != bloboff + inode->i_size);
+
+		padding = erofs_blkoff(sbi, inode->i_size);
+		if (padding) {
+			padding = erofs_blksiz(sbi) - padding;
+			ret = __erofs_io_write(blobfile, zeroed, padding);
+			if (ret > 0 && ret != padding)
+				return -EIO;
+		}
 	}
 
 	inode->datalayout = EROFS_INODE_FLAT_PLAIN;
diff --git a/lib/inode.c b/lib/inode.c
index 39257c7..6eb275b 100644
--- a/lib/inode.c
+++ b/lib/inode.c
@@ -581,7 +581,7 @@ int erofs_write_unencoded_file(struct erofs_inode *inode, int fd, u64 fpos)
 	}
 
 	if (cfg.c_meta_fix)
-		return erofs_blobraw_write_file(inode, fd);
+		return erofs_blobraw_write_file(inode, fd, cfg.c_meta_only);
 	/* fallback to all data uncompressed */
 	return write_uncompressed_file_from_fd(inode, fd);
 }
diff --git a/mkfs/main.c b/mkfs/main.c
index 82db452..be3ee7f 100644
--- a/mkfs/main.c
+++ b/mkfs/main.c
@@ -89,6 +89,7 @@ static struct option long_options[] = {
 	{"hard-dereference", no_argument, NULL, 528},
 	{"dsunit", required_argument, NULL, 529},
 	{"meta_fix", no_argument, NULL, 530},
+	{"meta_only", no_argument, NULL, 531},
 	{0, 0, 0, 0},
 };
 
@@ -194,6 +195,7 @@ static void usage(int argc, char **argv)
 		" --ovlfs-strip=<0,1>   strip overlayfs metadata in the target image (e.g. whiteouts)\n"
 		" --quiet               quiet execution (do not write anything to standard output.)\n"
 		" --meta_fix            make metadata area fixed at the front of the image file\n"
+		" --meta_only           only keep the metadata area in image file\n"
 #ifndef NDEBUG
 		" --random-pclusterblks randomize pclusterblks for big pcluster (debugging only)\n"
 		" --random-algorithms   randomize per-file algorithms (debugging only)\n"
@@ -892,6 +894,9 @@ static int mkfs_parse_options_cfg(int argc, char *argv[])
 		case 530:
 			cfg.c_meta_fix = true;
 			break;
+		case 531:
+			cfg.c_meta_only = true;
+			break;
 		case 'V':
 			version();
 			exit(0);
@@ -909,6 +914,11 @@ static int mkfs_parse_options_cfg(int argc, char *argv[])
 		return -EINVAL;
 	}
 
+	if (cfg.c_meta_only && !cfg.c_meta_fix) {
+		erofs_err("--meta_only must be used together with --meta_fix");
+		return -EINVAL;
+	}
+
 	if (cfg.c_meta_fix) {
 		if (cfg.c_compr_opts[0].alg) {
 			erofs_err("--meta_fix cannot be used with compress case");
@@ -1529,6 +1539,8 @@ int main(int argc, char **argv)
 	if (err)
 		goto exit;
 
+	if (cfg.c_meta_only)
+		nblocks -= erofs_blobraw_total(&g_sbi);
 	err = erofs_dev_resize(&g_sbi, nblocks);
 
 	if (!err && erofs_sb_has_sb_chksum(&g_sbi)) {
-- 
2.22.0


