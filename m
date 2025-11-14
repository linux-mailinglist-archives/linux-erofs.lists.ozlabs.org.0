Return-Path: <linux-erofs+bounces-1364-lists+linux-erofs=lfdr.de@lists.ozlabs.org>
X-Original-To: lists+linux-erofs@lfdr.de
Delivered-To: lists+linux-erofs@lfdr.de
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2404:9400:2:0:216:3eff:fee1:b9f1])
	by mail.lfdr.de (Postfix) with ESMTPS id E176FC5C538
	for <lists+linux-erofs@lfdr.de>; Fri, 14 Nov 2025 10:40:45 +0100 (CET)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4d7Bvv58ppz2yxl;
	Fri, 14 Nov 2025 20:40:43 +1100 (AEDT)
X-Original-To: linux-erofs@lists.ozlabs.org
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip=113.46.200.220
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1763113243;
	cv=none; b=CsKhqP88W46SYnXFH6fYAlgjxBceU1XhOUQ8x6tf1atfeSBZHd06tmoIvRAi6C4nsl4RfvnbERfmcTC02odVm0IjuP9pzs0jq/vC/0dPStiQKWm4Tv0I3IubKFLoFFGLnnA89YKSBtsMWw2b0xHL1Nb9wku+bKsgD5yFF+eouFOSN0G4Cf5EMwzC0Kiqaw1l19g7APeLCOFM5AU5NJgxGHREcoz1nR5wVz5k5z7FHDVPBVJdqkQWHdqVBgqjPPvj7eB/GzKVqVsTLb0pNvseJPtZDu24+eH3wXmvwf2dzjJvVe80JzxwfJK2QYJ3YdxEHrVFQOov57xXGYMFLwILbg==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1763113243; c=relaxed/relaxed;
	bh=nGgWr0kipJ5E0wWdigyiC5O5Pq+qTGGfj2uTaWcc3xM=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=TALRFtPCGwmGD2dF4VAP3Cgadk9CRTT38MUAluEpORwoEUreB+dTs2HrSm8dYjQIuCh1Edw1wUgjn22lKf/fb1U/fh0lnOKz/spGfUGpOLcOW5EKsxHZPyo9LcCJn5ISqRufHQ4nGMZqN+wCJ8nuIihrNnvGEnqOZBpZl0cC1hvIev0Je6SIbsEwGWWBJoGDjl0ciMaV9r8B+Ovp4xtlBYin5J1FpXCMOLmmgif03EQPt+mRwRY8lcBlv7ZcX09XoJyApEmJgGEadw1zkQdhseIao7wJgblhh9fs6Fj3YDX9Ah9MfVVWnDzLgucwJNStz/2gSdJpzn6hkMwAlGQKmQ==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; dkim=pass (1024-bit key; unprotected) header.d=huawei.com header.i=@huawei.com header.a=rsa-sha256 header.s=dkim header.b=fjx2YYET; dkim-atps=neutral; spf=pass (client-ip=113.46.200.220; helo=canpmsgout05.his.huawei.com; envelope-from=lihongbo22@huawei.com; receiver=lists.ozlabs.org) smtp.mailfrom=huawei.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (1024-bit key; unprotected) header.d=huawei.com header.i=@huawei.com header.a=rsa-sha256 header.s=dkim header.b=fjx2YYET;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=huawei.com (client-ip=113.46.200.220; helo=canpmsgout05.his.huawei.com; envelope-from=lihongbo22@huawei.com; receiver=lists.ozlabs.org)
Received: from canpmsgout05.his.huawei.com (canpmsgout05.his.huawei.com [113.46.200.220])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4d7Bvr3qFxz2xqk
	for <linux-erofs@lists.ozlabs.org>; Fri, 14 Nov 2025 20:40:38 +1100 (AEDT)
dkim-signature: v=1; a=rsa-sha256; d=huawei.com; s=dkim;
	c=relaxed/relaxed; q=dns/txt;
	h=From;
	bh=nGgWr0kipJ5E0wWdigyiC5O5Pq+qTGGfj2uTaWcc3xM=;
	b=fjx2YYETns/TidnEM0QoG5X+VPwAiY8wMgMAOFbl5H3BqM3M/XHxE9oe8+MLfa27Cc1mCC7Tl
	3YhsPu+gHUbPTBjPyDW1ISa3Y0XhQjebJKmheqUcGhRs7arYOFB79zF42hq7dZ77/jwesqGgypv
	3L7Y0SIQScv9HdNVVcSWPOs=
Received: from mail.maildlp.com (unknown [172.19.88.105])
	by canpmsgout05.his.huawei.com (SkyGuard) with ESMTPS id 4d7Bst30XTz12LFQ;
	Fri, 14 Nov 2025 17:38:58 +0800 (CST)
Received: from kwepemr500015.china.huawei.com (unknown [7.202.195.162])
	by mail.maildlp.com (Postfix) with ESMTPS id C63B1140136;
	Fri, 14 Nov 2025 17:40:28 +0800 (CST)
Received: from huawei.com (10.67.174.162) by kwepemr500015.china.huawei.com
 (7.202.195.162) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.11; Fri, 14 Nov
 2025 17:40:28 +0800
From: Hongbo Li <lihongbo22@huawei.com>
To: <hsiangkao@linux.alibaba.com>, <chao@kernel.org>
CC: <linux-erofs@lists.ozlabs.org>, <linux-kernel@vger.kernel.org>,
	<lihongbo22@huawei.com>
Subject: [PATCH] erofs-utils: introduce --ishare_key option for local dir to support shared page cache
Date: Fri, 14 Nov 2025 09:28:45 +0000
Message-ID: <20251114092845.207368-1-lihongbo22@huawei.com>
X-Mailer: git-send-email 2.22.0
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
Content-Type: text/plain
X-Originating-IP: [10.67.174.162]
X-ClientProxiedBy: kwepems500002.china.huawei.com (7.221.188.17) To
 kwepemr500015.china.huawei.com (7.202.195.162)
X-Spam-Status: No, score=-0.2 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS autolearn=disabled
	version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-25) on lists.ozlabs.org

For uncoming page cache sharing feature, we provide the --ishare_key
option to calculate the sha256 on content for localdir. The usage
is like:
  mkfs.erofs --ishare_key=trusted.erofs.fingerprint foo.img foo/

Signed-off-by: Hongbo Li <lihongbo22@huawei.com>
---
 include/erofs/config.h   |  1 +
 include/erofs/internal.h |  3 +++
 include/erofs/xattr.h    |  3 ++-
 include/erofs_fs.h       |  6 ++++--
 lib/inode.c              |  7 +++++++
 lib/super.c              |  2 ++
 lib/xattr.c              | 35 +++++++++++++++++++++++++++++++++--
 mkfs/main.c              | 26 +++++++++++++++++++++-----
 8 files changed, 73 insertions(+), 10 deletions(-)

diff --git a/include/erofs/config.h b/include/erofs/config.h
index 525a8cd..dd4fa73 100644
--- a/include/erofs/config.h
+++ b/include/erofs/config.h
@@ -61,6 +61,7 @@ struct erofs_configure {
 	u64 c_unix_timestamp;
 	const char *mount_point;
 	u32 c_root_xattr_isize;
+	const char *ishare_key;
 #ifdef EROFS_MT_ENABLED
 	u64 c_mkfs_segment_size;
 	u32 c_mt_workers;
diff --git a/include/erofs/internal.h b/include/erofs/internal.h
index 62594b8..482bee2 100644
--- a/include/erofs/internal.h
+++ b/include/erofs/internal.h
@@ -132,6 +132,8 @@ struct erofs_sb_info {
 	u8 xattr_prefix_count;
 	struct erofs_xattr_prefix_item *xattr_prefixes;
 
+	u8 ishare_key_start;
+
 	struct erofs_vfile bdev;
 	int devblksz;
 	u64 devsz;
@@ -186,6 +188,7 @@ EROFS_FEATURE_FUNCS(dedupe, incompat, INCOMPAT_DEDUPE)
 EROFS_FEATURE_FUNCS(xattr_prefixes, incompat, INCOMPAT_XATTR_PREFIXES)
 EROFS_FEATURE_FUNCS(48bit, incompat, INCOMPAT_48BIT)
 EROFS_FEATURE_FUNCS(metabox, incompat, INCOMPAT_METABOX)
+EROFS_FEATURE_FUNCS(ishare_key, incompat, INCOMPAT_ISHARE_KEY)
 EROFS_FEATURE_FUNCS(sb_chksum, compat, COMPAT_SB_CHKSUM)
 EROFS_FEATURE_FUNCS(xattr_filter, compat, COMPAT_XATTR_FILTER)
 EROFS_FEATURE_FUNCS(plain_xattr_pfx, compat, COMPAT_PLAIN_XATTR_PFX)
diff --git a/include/erofs/xattr.h b/include/erofs/xattr.h
index ef80123..c1a4205 100644
--- a/include/erofs/xattr.h
+++ b/include/erofs/xattr.h
@@ -46,6 +46,7 @@ static inline unsigned int xattrblock_offset(struct erofs_inode *vi,
 struct erofs_importer;
 
 int erofs_xattr_init(struct erofs_sb_info *sbi);
+int erofs_hook_ishare_xattrs(struct erofs_inode *inode, const char *ishare_key);
 int erofs_scan_file_xattrs(struct erofs_inode *inode);
 int erofs_prepare_xattr_ibody(struct erofs_inode *inode, bool noroom);
 char *erofs_export_xattr_ibody(struct erofs_inode *inode);
@@ -56,7 +57,7 @@ void erofs_xattr_cleanup_name_prefixes(void);
 int erofs_xattr_flush_name_prefixes(struct erofs_importer *im, bool plain);
 int erofs_xattr_prefixes_init(struct erofs_sb_info *sbi);
 
-int erofs_setxattr(struct erofs_inode *inode, char *key,
+int erofs_setxattr(struct erofs_inode *inode, const char *key,
 		   const void *value, size_t size);
 int erofs_set_opaque_xattr(struct erofs_inode *inode);
 void erofs_clear_opaque_xattr(struct erofs_inode *inode);
diff --git a/include/erofs_fs.h b/include/erofs_fs.h
index 887f37f..1869844 100644
--- a/include/erofs_fs.h
+++ b/include/erofs_fs.h
@@ -34,8 +34,9 @@
 #define EROFS_FEATURE_INCOMPAT_XATTR_PREFIXES	0x00000040
 #define EROFS_FEATURE_INCOMPAT_48BIT		0x00000080
 #define EROFS_FEATURE_INCOMPAT_METABOX		0x00000100
+#define EROFS_FEATURE_INCOMPAT_ISHARE_KEY	0x00000200
 #define EROFS_ALL_FEATURE_INCOMPAT		\
-	((EROFS_FEATURE_INCOMPAT_METABOX << 1) - 1)
+	((EROFS_FEATURE_INCOMPAT_ISHARE_KEY << 1) - 1)
 
 #define EROFS_SB_EXTSLOT_SIZE	16
 
@@ -82,7 +83,8 @@ struct erofs_super_block {
 	__le32 xattr_prefix_start;	/* start of long xattr prefixes */
 	__le64 packed_nid;	/* nid of the special packed inode */
 	__u8 xattr_filter_reserved; /* reserved for xattr name filter */
-	__u8 reserved[3];
+	__u8 ishare_key_start;	/* start of ishare key */
+	__u8 reserved[2];
 	__le32 build_time;	/* seconds added to epoch for mkfs time */
 	__le64 rootnid_8b;	/* (48BIT on) nid of root directory */
 	__le64 reserved2;
diff --git a/lib/inode.c b/lib/inode.c
index d993c8f..92ecce7 100644
--- a/lib/inode.c
+++ b/lib/inode.c
@@ -1899,6 +1899,13 @@ static int erofs_mkfs_handle_inode(struct erofs_importer *im,
 			return ret;
 	}
 
+	if (!rebuild && cfg.ishare_key &&
+	     S_ISREG(inode->i_mode) && inode->i_size) {
+		ret = erofs_hook_ishare_xattrs(inode, cfg.ishare_key);
+		if (ret < 0)
+			return ret;
+	}
+
 	if (!rebuild && !params->no_xattrs) {
 		ret = erofs_scan_file_xattrs(inode);
 		if (ret < 0)
diff --git a/lib/super.c b/lib/super.c
index d626c7c..f9ce1b7 100644
--- a/lib/super.c
+++ b/lib/super.c
@@ -137,6 +137,7 @@ int erofs_read_superblock(struct erofs_sb_info *sbi)
 	sbi->inos = le64_to_cpu(dsb->inos);
 	sbi->checksum = le32_to_cpu(dsb->checksum);
 
+	sbi->ishare_key_start = dsb->ishare_key_start;
 	sbi->epoch = (s64)le64_to_cpu(dsb->epoch);
 	sbi->fixed_nsec = le32_to_cpu(dsb->fixed_nsec);
 	sbi->build_time = le32_to_cpu(dsb->build_time);
@@ -196,6 +197,7 @@ int erofs_writesb(struct erofs_sb_info *sbi)
 		.xattr_blkaddr = cpu_to_le32(sbi->xattr_blkaddr),
 		.xattr_prefix_count = sbi->xattr_prefix_count,
 		.xattr_prefix_start = cpu_to_le32(sbi->xattr_prefix_start),
+		.ishare_key_start = sbi->ishare_key_start,
 		.feature_incompat = cpu_to_le32(sbi->feature_incompat),
 		.feature_compat = cpu_to_le32(sbi->feature_compat &
 					      ~EROFS_FEATURE_COMPAT_SB_CHKSUM),
diff --git a/lib/xattr.c b/lib/xattr.c
index 8f0332b..1548f8e 100644
--- a/lib/xattr.c
+++ b/lib/xattr.c
@@ -21,6 +21,7 @@
 #include "liberofs_metabox.h"
 #include "liberofs_xxhash.h"
 #include "liberofs_private.h"
+#include "sha256.h"
 
 #ifndef XATTR_SYSTEM_PREFIX
 #define XATTR_SYSTEM_PREFIX	"system."
@@ -475,7 +476,7 @@ err:
 	return ret;
 }
 
-int erofs_setxattr(struct erofs_inode *inode, char *key,
+int erofs_setxattr(struct erofs_inode *inode, const char *key,
 		   const void *value, size_t size)
 {
 	struct erofs_sb_info *sbi = inode->sbi;
@@ -573,6 +574,36 @@ static int erofs_droid_xattr_set_caps(struct erofs_inode *inode)
 }
 #endif
 
+int erofs_hook_ishare_xattrs(struct erofs_inode *inode, const char *ishare_key)
+{
+	erofs_off_t isize = inode->i_size;
+	void *buffer;
+	u8 sha256[32];
+	int ret, fd;
+
+	buffer = malloc(isize);
+	if (!buffer)
+		return -ENOMEM;
+
+	fd = open(inode->i_srcpath, O_RDONLY | O_BINARY);
+	if (fd < 0) {
+		ret = -errno;
+		goto free_err;
+	}
+	ret = erofs_io_pread(&(struct erofs_vfile){ .fd = fd }, buffer, isize, 0);
+	if (ret != isize) {
+		ret = -errno;
+		goto close_err;
+	}
+	erofs_sha256(buffer, isize, sha256);
+	ret = erofs_setxattr(inode, ishare_key, sha256, 32);
+close_err:
+	close(fd);
+free_err:
+	free(buffer);
+	return ret;
+}
+
 int erofs_scan_file_xattrs(struct erofs_inode *inode)
 {
 	int ret;
@@ -1653,7 +1684,7 @@ int erofs_xattr_insert_name_prefix(const char *prefix)
 	ea_prefix_count++;
 	init_list_head(&tnode->list);
 	list_add_tail(&tnode->list, &ea_name_prefixes);
-	return 0;
+	return tnode->index;
 }
 
 void erofs_xattr_cleanup_name_prefixes(void)
diff --git a/mkfs/main.c b/mkfs/main.c
index 76bf843..66507c3 100644
--- a/mkfs/main.c
+++ b/mkfs/main.c
@@ -102,6 +102,7 @@ static struct option long_options[] = {
 #endif
 	{"zD", optional_argument, NULL, 536},
 	{"ZI", optional_argument, NULL, 537},
+	{"ishare_key", required_argument, NULL, 538},
 	{0, 0, 0, 0},
 };
 
@@ -1261,7 +1262,7 @@ static int mkfs_parse_options_cfg(struct erofs_importer_params *params,
 		case 19:
 			errno = 0;
 			opt = erofs_xattr_insert_name_prefix(optarg);
-			if (opt) {
+			if (opt < 0) {
 				erofs_err("failed to parse xattr name prefix: %s",
 					  erofs_strerror(opt));
 				return opt;
@@ -1421,6 +1422,18 @@ static int mkfs_parse_options_cfg(struct erofs_importer_params *params,
 			else
 				mkfscfg.inode_metazone = false;
 			break;
+		case 538:
+			opt = erofs_xattr_insert_name_prefix(optarg);
+			if (opt < 0) {
+				erofs_err("failed to parse xattr name prefix: %s",
+					  erofs_strerror(opt));
+				return opt;
+			}
+			cfg.ishare_key = optarg;
+			g_sbi.ishare_key_start = opt;
+			cfg.c_extra_ea_name_prefixes = true;
+			erofs_sb_set_ishare_key(&g_sbi);
+			break;
 		case 'V':
 			version();
 			exit(0);
@@ -1875,10 +1888,6 @@ int main(int argc, char **argv)
 			goto exit;
 		}
 
-		if (cfg.c_extra_ea_name_prefixes)
-			erofs_xattr_flush_name_prefixes(&importer,
-							mkfs_plain_xattr_pfx);
-
 		root = erofs_new_inode(&g_sbi);
 		if (IS_ERR(root)) {
 			err = PTR_ERR(root);
@@ -1965,6 +1974,13 @@ int main(int argc, char **argv)
 			goto exit;
 	}
 
+	if (cfg.c_extra_ea_name_prefixes) {
+		err = erofs_xattr_flush_name_prefixes(&importer,
+						      mkfs_plain_xattr_pfx);
+		if (err)
+			goto exit;
+	}
+
 	err = erofs_importer_flush_all(&importer);
 	if (err)
 		goto exit;
-- 
2.22.0


