Return-Path: <linux-erofs+bounces-1404-lists+linux-erofs=lfdr.de@lists.ozlabs.org>
X-Original-To: lists+linux-erofs@lfdr.de
Delivered-To: lists+linux-erofs@lfdr.de
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2404:9400:2:0:216:3eff:fee1:b9f1])
	by mail.lfdr.de (Postfix) with ESMTPS id 59FE0C66FAA
	for <lists+linux-erofs@lfdr.de>; Tue, 18 Nov 2025 03:10:57 +0100 (CET)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4d9Sl30vXMz2yG5;
	Tue, 18 Nov 2025 13:10:55 +1100 (AEDT)
X-Original-To: linux-erofs@lists.ozlabs.org
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip=113.46.200.227
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1763431855;
	cv=none; b=LF32MA3Kofo/1bGd8B64nMwuDbGAoJIAnbcktY0k7pbb0JSkuYLK9QphVc3K1+uZW9r6rZYg5BZsjpCfa5LKGtRvuM+MT9aq6o0CNTCuszHqGeIpp99R7SkMyPBN18bdcbxFXOXdPP2KUVDccd/RyRVq4vLrVP1+Yw+0AUwTSszdP1+O74K75k7jfJDw+Y1gBalHzIC6u948f6NHnuyhVkaGLCBhGlQ9S7Qt4o7Uxqa8DQhYgsYQ30FldCqxdc/tNgksp/UuphfmjSvAOxTJ3rYmMOFiPb+sefwjZDxrq4Da+ojZD1VNpDioo0JN8++kDdK5iBy7LF+R6+SRByJe8Q==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1763431855; c=relaxed/relaxed;
	bh=maCpeDUW32MuzuP5dydiseQ/n1MjVteCpkL15HmNg4Y=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=dXgiU87A6fsdxrRa1mC1aod2G/LtMW/CoZWUT/ompDun16JI8zQRMMqpVzKV/r24JicyEwyPn7de56oNFabfAyq6iNzX81H03J+vy6z2VSZs9PHEUH8fc3ScPspCfBzQikL2d3XX2xOwVFyXWHfcCw+dtkr5RvT0aFMq+lxzeP/5LQGY7QoD0pWo2hogjNyzxqvJOGnxrKW6Z9hJCgi6WeFfE6fptn5AI+UwDM0UnxQdzxWV2vlkKw3+IntuPnWEn5SniGE8c+bS6BdR7HTx6kGXl5povwHRolwWEgyZytZEBVqQQkk/a8/sTptpFhfe1EUQCXtoOIL9Cf16rYT+kw==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; dkim=pass (1024-bit key; unprotected) header.d=huawei.com header.i=@huawei.com header.a=rsa-sha256 header.s=dkim header.b=F9DVcDiH; dkim-atps=neutral; spf=pass (client-ip=113.46.200.227; helo=canpmsgout12.his.huawei.com; envelope-from=lihongbo22@huawei.com; receiver=lists.ozlabs.org) smtp.mailfrom=huawei.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (1024-bit key; unprotected) header.d=huawei.com header.i=@huawei.com header.a=rsa-sha256 header.s=dkim header.b=F9DVcDiH;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=huawei.com (client-ip=113.46.200.227; helo=canpmsgout12.his.huawei.com; envelope-from=lihongbo22@huawei.com; receiver=lists.ozlabs.org)
Received: from canpmsgout12.his.huawei.com (canpmsgout12.his.huawei.com [113.46.200.227])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4d9Skt0D5pz2xqr
	for <linux-erofs@lists.ozlabs.org>; Tue, 18 Nov 2025 13:10:43 +1100 (AEDT)
dkim-signature: v=1; a=rsa-sha256; d=huawei.com; s=dkim;
	c=relaxed/relaxed; q=dns/txt;
	h=From;
	bh=maCpeDUW32MuzuP5dydiseQ/n1MjVteCpkL15HmNg4Y=;
	b=F9DVcDiHifC7pnovs8OZ2wADq+Ij6Ae9899sctBmhwchG8ZmXqc4R7SrUrd1LesdKaM23r4m7
	qtFh1UAhLPhDxhjz9upDioTI8d+9131r3vAzjZdPsUZ4ZSFkL6bPLNxaP+kA+XPI8Pkhuxo5dJU
	BHJ0VktMsJ50vvzHbwUBFLE=
Received: from mail.maildlp.com (unknown [172.19.162.112])
	by canpmsgout12.his.huawei.com (SkyGuard) with ESMTPS id 4d9Shm1lRmznTW4;
	Tue, 18 Nov 2025 10:08:56 +0800 (CST)
Received: from kwepemr500015.china.huawei.com (unknown [7.202.195.162])
	by mail.maildlp.com (Postfix) with ESMTPS id 756D31401F1;
	Tue, 18 Nov 2025 10:10:24 +0800 (CST)
Received: from huawei.com (10.67.174.162) by kwepemr500015.china.huawei.com
 (7.202.195.162) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.11; Tue, 18 Nov
 2025 10:10:23 +0800
From: Hongbo Li <lihongbo22@huawei.com>
To: <hsiangkao@linux.alibaba.com>, <chao@kernel.org>
CC: <linux-erofs@lists.ozlabs.org>, <linux-kernel@vger.kernel.org>,
	<lihongbo22@huawei.com>
Subject: [PATCH v2] erofs-utils: introduce --ishare_key option for local dir to support shared page cache
Date: Tue, 18 Nov 2025 01:58:49 +0000
Message-ID: <20251118015849.228939-1-lihongbo22@huawei.com>
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
X-ClientProxiedBy: kwepems200002.china.huawei.com (7.221.188.68) To
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
 include/erofs/internal.h |  2 ++
 include/erofs/xattr.h    |  3 ++-
 include/erofs_fs.h       |  4 +++-
 lib/inode.c              |  7 ++++++
 lib/super.c              |  4 ++++
 lib/xattr.c              | 48 ++++++++++++++++++++++++++++++++++++++--
 mkfs/main.c              | 26 +++++++++++++++++-----
 8 files changed, 86 insertions(+), 9 deletions(-)

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
index 62594b8..6d1b7b9 100644
--- a/include/erofs/internal.h
+++ b/include/erofs/internal.h
@@ -130,6 +130,7 @@ struct erofs_sb_info {
 
 	u32 xattr_prefix_start;
 	u8 xattr_prefix_count;
+	u8 ishare_xattr_pfx;
 	struct erofs_xattr_prefix_item *xattr_prefixes;
 
 	struct erofs_vfile bdev;
@@ -189,6 +190,7 @@ EROFS_FEATURE_FUNCS(metabox, incompat, INCOMPAT_METABOX)
 EROFS_FEATURE_FUNCS(sb_chksum, compat, COMPAT_SB_CHKSUM)
 EROFS_FEATURE_FUNCS(xattr_filter, compat, COMPAT_XATTR_FILTER)
 EROFS_FEATURE_FUNCS(plain_xattr_pfx, compat, COMPAT_PLAIN_XATTR_PFX)
+EROFS_FEATURE_FUNCS(ishare_key, compat, COMPAT_ISHARE_KEY)
 
 #define EROFS_I_EA_INITED_BIT	0
 #define EROFS_I_Z_INITED_BIT	1
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
index 887f37f..a379752 100644
--- a/include/erofs_fs.h
+++ b/include/erofs_fs.h
@@ -17,6 +17,7 @@
 #define EROFS_FEATURE_COMPAT_MTIME              0x00000002
 #define EROFS_FEATURE_COMPAT_XATTR_FILTER	0x00000004
 #define EROFS_FEATURE_COMPAT_PLAIN_XATTR_PFX	0x00000010
+#define EROFS_FEATURE_COMPAT_ISHARE_KEY		0x00000020
 
 /*
  * Any bits that aren't in EROFS_ALL_FEATURE_INCOMPAT should
@@ -82,7 +83,8 @@ struct erofs_super_block {
 	__le32 xattr_prefix_start;	/* start of long xattr prefixes */
 	__le64 packed_nid;	/* nid of the special packed inode */
 	__u8 xattr_filter_reserved; /* reserved for xattr name filter */
-	__u8 reserved[3];
+	__u8 ishare_xattr_prefix_id;	/* start of ishare key */
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
index d626c7c..7e41ef8 100644
--- a/lib/super.c
+++ b/lib/super.c
@@ -137,6 +137,9 @@ int erofs_read_superblock(struct erofs_sb_info *sbi)
 	sbi->inos = le64_to_cpu(dsb->inos);
 	sbi->checksum = le32_to_cpu(dsb->checksum);
 
+	if (erofs_sb_has_ishare_key(sbi))
+		sbi->ishare_xattr_pfx =
+			dsb->ishare_xattr_prefix_id & EROFS_XATTR_LONG_PREFIX_MASK;
 	sbi->epoch = (s64)le64_to_cpu(dsb->epoch);
 	sbi->fixed_nsec = le32_to_cpu(dsb->fixed_nsec);
 	sbi->build_time = le32_to_cpu(dsb->build_time);
@@ -196,6 +199,7 @@ int erofs_writesb(struct erofs_sb_info *sbi)
 		.xattr_blkaddr = cpu_to_le32(sbi->xattr_blkaddr),
 		.xattr_prefix_count = sbi->xattr_prefix_count,
 		.xattr_prefix_start = cpu_to_le32(sbi->xattr_prefix_start),
+		.ishare_xattr_prefix_id = sbi->ishare_xattr_pfx,
 		.feature_incompat = cpu_to_le32(sbi->feature_incompat),
 		.feature_compat = cpu_to_le32(sbi->feature_compat &
 					      ~EROFS_FEATURE_COMPAT_SB_CHKSUM),
diff --git a/lib/xattr.c b/lib/xattr.c
index 8f0332b..d27e037 100644
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
@@ -1718,6 +1749,19 @@ int erofs_xattr_prefixes_init(struct erofs_sb_info *sbi)
 		pfs[i].infix_len = len - sizeof(struct erofs_xattr_long_prefix);
 	}
 out:
+	if (!ret && erofs_sb_has_ishare_key(sbi)) {
+		struct erofs_xattr_prefix_item *pf = pfs + sbi->ishare_xattr_pfx;
+		struct erofs_xattr_long_prefix *newpfx;
+
+		newpfx = realloc(pf->prefix,
+				 sizeof(*newpfx) + pf->infix_len + 1);
+		if (newpfx) {
+			newpfx->infix[pf->infix_len] = '\0';
+			pf->prefix = newpfx;
+		} else {
+			ret = -ENOMEM;
+		}
+	}
 	sbi->xattr_prefixes = pfs;
 	if (ret)
 		erofs_xattr_prefixes_cleanup(sbi);
diff --git a/mkfs/main.c b/mkfs/main.c
index 76bf843..5eb5bf8 100644
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
+			g_sbi.ishare_xattr_pfx = opt;
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


