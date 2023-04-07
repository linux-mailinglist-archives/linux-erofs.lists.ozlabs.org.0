Return-Path: <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>
X-Original-To: lists+linux-erofs@lfdr.de
Delivered-To: lists+linux-erofs@lfdr.de
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	by mail.lfdr.de (Postfix) with ESMTPS id 4D0766DAE9A
	for <lists+linux-erofs@lfdr.de>; Fri,  7 Apr 2023 16:09:23 +0200 (CEST)
Received: from boromir.ozlabs.org (localhost [IPv6:::1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4PtKxF1jmKz3fDd
	for <lists+linux-erofs@lfdr.de>; Sat,  8 Apr 2023 00:09:21 +1000 (AEST)
X-Original-To: linux-erofs@lists.ozlabs.org
Delivered-To: linux-erofs@lists.ozlabs.org
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=linux.alibaba.com (client-ip=115.124.30.131; helo=out30-131.freemail.mail.aliyun.com; envelope-from=jefflexu@linux.alibaba.com; receiver=<UNKNOWN>)
Received: from out30-131.freemail.mail.aliyun.com (out30-131.freemail.mail.aliyun.com [115.124.30.131])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4PtKx05BDPz3fSf
	for <linux-erofs@lists.ozlabs.org>; Sat,  8 Apr 2023 00:09:08 +1000 (AEST)
X-Alimail-AntiSpam: AC=PASS;BC=-1|-1;BR=01201311R181e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=ay29a033018046060;MF=jefflexu@linux.alibaba.com;NM=1;PH=DS;RN=2;SR=0;TI=SMTPD_---0VfX8bVu_1680876544;
Received: from localhost(mailfrom:jefflexu@linux.alibaba.com fp:SMTPD_---0VfX8bVu_1680876544)
          by smtp.aliyun-inc.com;
          Fri, 07 Apr 2023 22:09:04 +0800
From: Jingbo Xu <jefflexu@linux.alibaba.com>
To: xiang@kernel.org,
	linux-erofs@lists.ozlabs.org
Subject: [PATCH v2 3/3] erofs-utils: build xattrs upon extra long name prefixes
Date: Fri,  7 Apr 2023 22:09:02 +0800
Message-Id: <20230407140902.97275-3-jefflexu@linux.alibaba.com>
X-Mailer: git-send-email 2.19.1.6.gb485710b
In-Reply-To: <20230407140902.97275-1-jefflexu@linux.alibaba.com>
References: <20230407140902.97275-1-jefflexu@linux.alibaba.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
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
Sender: "Linux-erofs" <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>

Extra long xattr name prefixes are also considered when generating
xattr entries.

Note that the given user-specified extra long xattr name prefixes
are preferred to the pre-defined xattr name prefixes.

Signed-off-by: Jingbo Xu <jefflexu@linux.alibaba.com>
---
 include/erofs/config.h   |   1 +
 include/erofs/internal.h |   4 ++
 include/erofs/xattr.h    |   4 ++
 include/erofs_fs.h       |   4 +-
 lib/xattr.c              | 134 +++++++++++++++++++++++++++++++++++++++
 mkfs/main.c              |  24 ++++++-
 6 files changed, 168 insertions(+), 3 deletions(-)

diff --git a/include/erofs/config.h b/include/erofs/config.h
index 648a3e8..8f52d2c 100644
--- a/include/erofs/config.h
+++ b/include/erofs/config.h
@@ -52,6 +52,7 @@ struct erofs_configure {
 	bool c_dedupe;
 	bool c_ignore_mtime;
 	bool c_showprogress;
+	bool c_extra_ea_name_prefixes;
 
 #ifdef HAVE_LIBSELINUX
 	struct selabel_handle *sehnd;
diff --git a/include/erofs/internal.h b/include/erofs/internal.h
index 641a795..b3d04be 100644
--- a/include/erofs/internal.h
+++ b/include/erofs/internal.h
@@ -102,6 +102,9 @@ struct erofs_sb_info {
 		u16 device_id_mask;		/* used for others */
 	};
 	erofs_nid_t packed_nid;
+
+	u32 xattr_prefix_start;
+	u8 xattr_prefix_count;
 };
 
 /* make sure that any user of the erofs headers has atleast 64bit off_t type */
@@ -134,6 +137,7 @@ EROFS_FEATURE_FUNCS(device_table, incompat, INCOMPAT_DEVICE_TABLE)
 EROFS_FEATURE_FUNCS(ztailpacking, incompat, INCOMPAT_ZTAILPACKING)
 EROFS_FEATURE_FUNCS(fragments, incompat, INCOMPAT_FRAGMENTS)
 EROFS_FEATURE_FUNCS(dedupe, incompat, INCOMPAT_DEDUPE)
+EROFS_FEATURE_FUNCS(xattr_prefixes, incompat, INCOMPAT_XATTR_PREFIXES)
 EROFS_FEATURE_FUNCS(sb_chksum, compat, COMPAT_SB_CHKSUM)
 
 #define EROFS_I_EA_INITED	(1 << 0)
diff --git a/include/erofs/xattr.h b/include/erofs/xattr.h
index 9efadc5..8fd41ae 100644
--- a/include/erofs/xattr.h
+++ b/include/erofs/xattr.h
@@ -70,6 +70,10 @@ int erofs_prepare_xattr_ibody(struct erofs_inode *inode);
 char *erofs_export_xattr_ibody(struct list_head *ixattrs, unsigned int size);
 int erofs_build_shared_xattrs_from_path(const char *path);
 
+int erofs_xattr_insert_name_prefix(const char *prefix);
+void erofs_xattr_cleanup_name_prefixes(void);
+int erofs_xattr_write_name_prefixes(FILE *f);
+
 #ifdef __cplusplus
 }
 #endif
diff --git a/include/erofs_fs.h b/include/erofs_fs.h
index 48d08a5..9107cc5 100644
--- a/include/erofs_fs.h
+++ b/include/erofs_fs.h
@@ -27,6 +27,7 @@
 #define EROFS_FEATURE_INCOMPAT_ZTAILPACKING	0x00000010
 #define EROFS_FEATURE_INCOMPAT_FRAGMENTS	0x00000020
 #define EROFS_FEATURE_INCOMPAT_DEDUPE		0x00000020
+#define EROFS_FEATURE_INCOMPAT_XATTR_PREFIXES	0x00000040
 #define EROFS_ALL_FEATURE_INCOMPAT		\
 	(EROFS_FEATURE_INCOMPAT_LZ4_0PADDING | \
 	 EROFS_FEATURE_INCOMPAT_COMPR_CFGS | \
@@ -35,7 +36,8 @@
 	 EROFS_FEATURE_INCOMPAT_DEVICE_TABLE | \
 	 EROFS_FEATURE_INCOMPAT_ZTAILPACKING | \
 	 EROFS_FEATURE_INCOMPAT_FRAGMENTS | \
-	 EROFS_FEATURE_INCOMPAT_DEDUPE)
+	 EROFS_FEATURE_INCOMPAT_DEDUPE | \
+	 EROFS_FEATURE_INCOMPAT_XATTR_PREFIXES)
 
 #define EROFS_SB_EXTSLOT_SIZE	16
 
diff --git a/lib/xattr.c b/lib/xattr.c
index a292f2c..9947433 100644
--- a/lib/xattr.c
+++ b/lib/xattr.c
@@ -17,6 +17,7 @@
 #include "erofs/xattr.h"
 #include "erofs/cache.h"
 #include "erofs/io.h"
+#include "erofs/fragments.h"
 #include "liberofs_private.h"
 
 #define EA_HASHTABLE_BITS 16
@@ -61,6 +62,14 @@ static struct xattr_prefix {
 	}
 };
 
+struct ea_type_node {
+	struct list_head list;
+	struct xattr_prefix type;
+	u8 index;
+};
+static LIST_HEAD(ea_name_prefixes);
+static unsigned int ea_prefix_count;
+
 static unsigned int BKDRHash(char *str, unsigned int len)
 {
 	const unsigned int seed = 131313;
@@ -130,7 +139,16 @@ static struct xattr_item *get_xattritem(u8 prefix, char *kvbuf,
 static bool match_prefix(const char *key, u8 *index, u16 *len)
 {
 	struct xattr_prefix *p;
+	struct ea_type_node *tnode;
 
+	list_for_each_entry(tnode, &ea_name_prefixes, list) {
+		p = &tnode->type;
+		if (p->prefix && !strncmp(p->prefix, key, p->prefix_len)) {
+			*len = p->prefix_len;
+			*index = tnode->index;
+			return true;
+		}
+	}
 	for (p = xattr_types; p < xattr_types + ARRAY_SIZE(xattr_types); ++p) {
 		if (p->prefix && !strncmp(p->prefix, key, p->prefix_len)) {
 			*len = p->prefix_len;
@@ -579,6 +597,72 @@ static int comp_xattr_item(const void *a, const void *b)
 	return la > lb;
 }
 
+static inline int erofs_xattr_index_by_prefix(const char *prefix, int *len)
+{
+	if (!strncmp(prefix, XATTR_USER_PREFIX, XATTR_USER_PREFIX_LEN)){
+		*len = XATTR_USER_PREFIX_LEN;
+		return EROFS_XATTR_INDEX_USER;
+	} else if (!strncmp(prefix, XATTR_TRUSTED_PREFIX, XATTR_TRUSTED_PREFIX_LEN)) {
+		*len = XATTR_TRUSTED_PREFIX_LEN;
+		return EROFS_XATTR_INDEX_TRUSTED;
+	} else if (!strncmp(prefix, XATTR_SECURITY_PREFIX, XATTR_SECURITY_PREFIX_LEN)) {
+		*len = XATTR_SECURITY_PREFIX_LEN;
+		return EROFS_XATTR_INDEX_SECURITY;
+	}
+	return -ENODATA;
+}
+
+int erofs_xattr_write_name_prefixes(FILE *f)
+{
+	struct ea_type_node *tnode;
+	struct xattr_prefix *p;
+	off_t offset;
+
+	if (!ea_prefix_count)
+		return 0;
+	offset = ftello(f);
+	if (offset < 0)
+		return -errno;
+	if (offset > UINT32_MAX)
+		return -EOVERFLOW;
+
+	offset = round_up(offset, 4);
+	if (fseek(f, offset, SEEK_SET))
+		return -errno;
+	sbi.xattr_prefix_start = (u32)offset >> 2;
+	sbi.xattr_prefix_count = ea_prefix_count;
+
+	list_for_each_entry(tnode, &ea_name_prefixes, list) {
+		union {
+			struct {
+				__le16 size;
+				struct erofs_xattr_long_prefix prefix;
+			} s;
+			u8 data[EROFS_NAME_LEN + 2 +
+				sizeof(struct erofs_xattr_long_prefix)];
+		} u;
+		int ret, len;
+
+		p = &tnode->type;
+		ret = erofs_xattr_index_by_prefix(p->prefix, &len);
+		if (ret < 0)
+			return ret;
+		u.s.prefix.base_index = ret;
+		memcpy(u.s.prefix.infix, p->prefix + len, p->prefix_len - len);
+		len = sizeof(struct erofs_xattr_long_prefix) +
+			p->prefix_len - len;
+		u.s.size = cpu_to_le16(len);
+		if (fwrite(&u.s, sizeof(__le16) + len, 1, f) != 1)
+			return -EIO;
+		offset = round_up(offset + sizeof(__le16) + len, 4);
+		if (fseek(f, offset, SEEK_SET))
+			return -errno;
+	}
+	erofs_sb_set_fragments();
+	erofs_sb_set_xattr_prefixes();
+	return 0;
+}
+
 int erofs_build_shared_xattrs_from_path(const char *path)
 {
 	int ret;
@@ -1222,3 +1306,53 @@ int erofs_listxattr(struct erofs_inode *vi, char *buffer, size_t buffer_size)
 		return ret;
 	return shared_listxattr(vi, &it);
 }
+
+int erofs_xattr_insert_name_prefix(const char *prefix)
+{
+	struct ea_type_node *tnode;
+	struct xattr_prefix *p;
+	bool matched = false;
+	char *s;
+
+	if (ea_prefix_count >= 0x80 || strlen(prefix) > UINT8_MAX)
+		return -EOVERFLOW;
+
+	for (p = xattr_types; p < xattr_types + ARRAY_SIZE(xattr_types); ++p) {
+		if (!strncmp(p->prefix, prefix, p->prefix_len)) {
+			matched = true;
+			break;
+		}
+	}
+	if (!matched)
+		return -ENODATA;
+
+	s = strdup(prefix);
+	if (!s)
+		return -ENOMEM;
+
+	tnode = malloc(sizeof(*tnode));
+	if (!tnode) {
+		free(s);
+		return -ENOMEM;
+	}
+
+	tnode->type.prefix = s;
+	tnode->type.prefix_len = strlen(prefix);
+
+	tnode->index = EROFS_XATTR_LONG_PREFIX | ea_prefix_count;
+	ea_prefix_count++;
+	init_list_head(&tnode->list);
+	list_add_tail(&tnode->list, &ea_name_prefixes);
+	return 0;
+}
+
+void erofs_xattr_cleanup_name_prefixes(void)
+{
+	struct ea_type_node *tnode, *n;
+
+	list_for_each_entry_safe(tnode, n, &ea_name_prefixes, list) {
+		list_del(&tnode->list);
+		free((void *)tnode->type.prefix);
+		free(tnode);
+	}
+}
diff --git a/mkfs/main.c b/mkfs/main.c
index cb52058..cc3fa62 100644
--- a/mkfs/main.c
+++ b/mkfs/main.c
@@ -57,6 +57,7 @@ static struct option long_options[] = {
 	{"uid-offset", required_argument, NULL, 16},
 	{"gid-offset", required_argument, NULL, 17},
 	{"mount-point", required_argument, NULL, 512},
+	{"xattr-prefix", required_argument, NULL, 19},
 #ifdef WITH_ANDROID
 	{"product-out", required_argument, NULL, 513},
 	{"fs-config-file", required_argument, NULL, 514},
@@ -116,6 +117,7 @@ static void usage(void)
 	      " --random-pclusterblks randomize pclusterblks for big pcluster (debugging only)\n"
 	      " --random-algorithms   randomize per-file algorithms (debugging only)\n"
 #endif
+	      " --xattr-prefix=X      X=extra xattr name prefix\n"
 	      " --mount-point=X       X=prefix of target fs path (default: /)\n"
 #ifdef WITH_ANDROID
 	      "\nwith following android-specific options:\n"
@@ -475,6 +477,16 @@ static int mkfs_parse_options_cfg(int argc, char *argv[])
 				return -EINVAL;
 			}
 			break;
+		case 19:
+			errno = 0;
+			opt = erofs_xattr_insert_name_prefix(optarg);
+			if (opt) {
+				erofs_err("failed to parse xattr name prefix: %s",
+					  erofs_strerror(opt));
+				return opt;
+			}
+			cfg.c_extra_ea_name_prefixes = true;
+			break;
 		case 1:
 			usage();
 			exit(0);
@@ -572,6 +584,8 @@ int erofs_mkfs_update_super_block(struct erofs_buffer_head *bh,
 		.blocks = 0,
 		.meta_blkaddr  = sbi.meta_blkaddr,
 		.xattr_blkaddr = sbi.xattr_blkaddr,
+		.xattr_prefix_count = sbi.xattr_prefix_count,
+		.xattr_prefix_start = cpu_to_le32(sbi.xattr_prefix_start),
 		.feature_incompat = cpu_to_le32(sbi.feature_incompat),
 		.feature_compat = cpu_to_le32(sbi.feature_compat &
 					      ~EROFS_FEATURE_COMPAT_SB_CHKSUM),
@@ -771,7 +785,7 @@ int main(int argc, char **argv)
 	}
 #endif
 	erofs_show_config();
-	if (cfg.c_fragments) {
+	if (cfg.c_fragments || cfg.c_extra_ea_name_prefixes) {
 		if (!cfg.c_pclusterblks_packed)
 			cfg.c_pclusterblks_packed = cfg.c_pclusterblks_def;
 
@@ -780,7 +794,9 @@ int main(int argc, char **argv)
 			erofs_err("failed to initialize packedfile");
 			return 1;
 		}
+	}
 
+	if (cfg.c_fragments) {
 		err = z_erofs_fragments_init();
 		if (err) {
 			erofs_err("failed to initialize fragments");
@@ -876,6 +892,9 @@ int main(int argc, char **argv)
 		goto exit;
 	}
 
+	if (cfg.c_extra_ea_name_prefixes)
+		erofs_xattr_write_name_prefixes(packedfile);
+
 	root_nid = erofs_lookupnid(root_inode);
 	erofs_iput(root_inode);
 
@@ -887,7 +906,7 @@ int main(int argc, char **argv)
 	}
 
 	packed_nid = 0;
-	if (cfg.c_fragments && erofs_sb_has_fragments()) {
+	if (erofs_sb_has_fragments()) {
 		erofs_update_progressinfo("Handling packed_file ...");
 		packed_inode = erofs_mkfs_build_packedfile();
 		if (IS_ERR(packed_inode)) {
@@ -925,6 +944,7 @@ exit:
 	if (cfg.c_fragments)
 		z_erofs_fragments_exit();
 	erofs_packedfile_exit();
+	erofs_xattr_cleanup_name_prefixes();
 	erofs_exit_configure();
 
 	if (err) {
-- 
2.19.1.6.gb485710b

