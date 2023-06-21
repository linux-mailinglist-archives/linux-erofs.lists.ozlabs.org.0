Return-Path: <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>
X-Original-To: lists+linux-erofs@lfdr.de
Delivered-To: lists+linux-erofs@lfdr.de
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2404:9400:2:0:216:3eff:fee1:b9f1])
	by mail.lfdr.de (Postfix) with ESMTPS id 21CE7737DD0
	for <lists+linux-erofs@lfdr.de>; Wed, 21 Jun 2023 10:49:49 +0200 (CEST)
Received: from boromir.ozlabs.org (localhost [IPv6:::1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4QmHHt6tvPz3dKM
	for <lists+linux-erofs@lfdr.de>; Wed, 21 Jun 2023 18:49:46 +1000 (AEST)
X-Original-To: linux-erofs@lists.ozlabs.org
Delivered-To: linux-erofs@lists.ozlabs.org
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=linux.alibaba.com (client-ip=115.124.30.99; helo=out30-99.freemail.mail.aliyun.com; envelope-from=jefflexu@linux.alibaba.com; receiver=lists.ozlabs.org)
Received: from out30-99.freemail.mail.aliyun.com (out30-99.freemail.mail.aliyun.com [115.124.30.99])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4QmH4M2Sdqz3dFY
	for <linux-erofs@lists.ozlabs.org>; Wed, 21 Jun 2023 18:39:47 +1000 (AEST)
X-Alimail-AntiSpam: AC=PASS;BC=-1|-1;BR=01201311R181e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=ay29a033018045168;MF=jefflexu@linux.alibaba.com;NM=1;PH=DS;RN=5;SR=0;TI=SMTPD_---0VlfEcl3_1687336782;
Received: from localhost(mailfrom:jefflexu@linux.alibaba.com fp:SMTPD_---0VlfEcl3_1687336782)
          by smtp.aliyun-inc.com;
          Wed, 21 Jun 2023 16:39:43 +0800
From: Jingbo Xu <jefflexu@linux.alibaba.com>
To: hsiangkao@linux.alibaba.com,
	chao@kernel.org,
	huyue2@coolpad.com,
	linux-erofs@lists.ozlabs.org
Subject: [RFC 3/3] erofs-utils: mkfs: enable xattr bloom filter
Date: Wed, 21 Jun 2023 16:39:39 +0800
Message-Id: <20230621083939.128961-4-jefflexu@linux.alibaba.com>
X-Mailer: git-send-email 2.19.1.6.gb485710b
In-Reply-To: <20230621083939.128961-1-jefflexu@linux.alibaba.com>
References: <20230621083939.128961-1-jefflexu@linux.alibaba.com>
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
Cc: alexl@redhat.com
Errors-To: linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org
Sender: "Linux-erofs" <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>

Introduce --xattr-bloom option to enable this feature.

Be noted that for xattrs with long xattr name prefixes, the
corresponding bloom filter is calculated upon the xattr name after
stripping the corresponding short predefined xattr name prefix rather
than the long xattr name prefix, to cater to kernel's processing
procedure for xattr.

Signed-off-by: Jingbo Xu <jefflexu@linux.alibaba.com>
---
 include/erofs/config.h   |  1 +
 include/erofs/internal.h |  1 +
 lib/xattr.c              | 62 ++++++++++++++++++++++++++++++++++++++--
 mkfs/main.c              |  6 ++++
 4 files changed, 67 insertions(+), 3 deletions(-)

diff --git a/include/erofs/config.h b/include/erofs/config.h
index 8f52d2c..d22e2e5 100644
--- a/include/erofs/config.h
+++ b/include/erofs/config.h
@@ -53,6 +53,7 @@ struct erofs_configure {
 	bool c_ignore_mtime;
 	bool c_showprogress;
 	bool c_extra_ea_name_prefixes;
+	bool c_xattr_bloom;
 
 #ifdef HAVE_LIBSELINUX
 	struct selabel_handle *sehnd;
diff --git a/include/erofs/internal.h b/include/erofs/internal.h
index b3d04be..41c4083 100644
--- a/include/erofs/internal.h
+++ b/include/erofs/internal.h
@@ -139,6 +139,7 @@ EROFS_FEATURE_FUNCS(fragments, incompat, INCOMPAT_FRAGMENTS)
 EROFS_FEATURE_FUNCS(dedupe, incompat, INCOMPAT_DEDUPE)
 EROFS_FEATURE_FUNCS(xattr_prefixes, incompat, INCOMPAT_XATTR_PREFIXES)
 EROFS_FEATURE_FUNCS(sb_chksum, compat, COMPAT_SB_CHKSUM)
+EROFS_FEATURE_FUNCS(xattr_bloom, compat, COMPAT_XATTR_BLOOM)
 
 #define EROFS_I_EA_INITED	(1 << 0)
 #define EROFS_I_Z_INITED	(1 << 1)
diff --git a/lib/xattr.c b/lib/xattr.c
index 5e9e413..ff5d579 100644
--- a/lib/xattr.c
+++ b/lib/xattr.c
@@ -18,6 +18,7 @@
 #include "erofs/cache.h"
 #include "erofs/io.h"
 #include "erofs/fragments.h"
+#include "erofs/xxhash.h"
 #include "liberofs_private.h"
 
 #define EA_HASHTABLE_BITS 16
@@ -27,6 +28,7 @@ struct xattr_item {
 	const char *kvbuf;
 	unsigned int hash[2], len[2], count;
 	int shared_xattr_id;
+	u32 bloom_map;
 	u8 prefix;
 	struct hlist_node node;
 };
@@ -101,7 +103,7 @@ static unsigned int put_xattritem(struct xattr_item *item)
 }
 
 static struct xattr_item *get_xattritem(u8 prefix, char *kvbuf,
-					unsigned int len[2])
+					unsigned int len[2], u32 map)
 {
 	struct xattr_item *item;
 	unsigned int hash[2], hkey;
@@ -133,10 +135,45 @@ static struct xattr_item *get_xattritem(u8 prefix, char *kvbuf,
 	item->hash[1] = hash[1];
 	item->shared_xattr_id = -1;
 	item->prefix = prefix;
+	item->bloom_map = map;
 	hash_add(ea_hashtable, &item->node, hkey);
 	return item;
 }
 
+static u32 erofs_xattr_calc_bloom_map(u8 prefix, const char *key, unsigned int len)
+{
+	u32 map = 0;
+	unsigned int i, bit;
+
+	if (!cfg.c_xattr_bloom)
+		return 0;
+
+	for (i = 0; i < EROFS_XATTR_BLOOM_COUNTS; i++) {
+		bit = xxh32(key, len, prefix + i) & EROFS_XATTR_BLOOM_MASK;
+		map |= (1UL << bit);
+	}
+	return map;
+}
+
+static bool erofs_xattr_bloom_map(const char *key, u32 *map)
+{
+	struct xattr_prefix *p;
+	unsigned int index, len;
+	const char *name;
+
+	for (p = xattr_types; p < xattr_types + ARRAY_SIZE(xattr_types); ++p) {
+		if (p->prefix && !strncmp(p->prefix, key, p->prefix_len)) {
+			index = p - xattr_types;
+			name = key + p->prefix_len;
+			len = strlen(key) - p->prefix_len;
+			*map = erofs_xattr_calc_bloom_map(index, name, len);
+			return true;
+		}
+	}
+	erofs_err("unmatched xattr name prefix");
+	return false;
+}
+
 static bool match_prefix(const char *key, u8 *index, u16 *len)
 {
 	struct xattr_prefix *p;
@@ -166,6 +203,7 @@ static struct xattr_item *parse_one_xattr(const char *path, const char *key,
 	ssize_t ret;
 	u8 prefix;
 	u16 prefixlen;
+	u32 map;
 	unsigned int len[2];
 	char *kvbuf;
 
@@ -174,6 +212,9 @@ static struct xattr_item *parse_one_xattr(const char *path, const char *key,
 	if (!match_prefix(key, &prefix, &prefixlen))
 		return ERR_PTR(-ENODATA);
 
+	if (!erofs_xattr_bloom_map(key, &map))
+		return ERR_PTR(-ENODATA);
+
 	DBG_BUGON(keylen < prefixlen);
 
 	/* determine length of the value */
@@ -216,7 +257,7 @@ static struct xattr_item *parse_one_xattr(const char *path, const char *key,
 			len[1] = ret;
 		}
 	}
-	return get_xattritem(prefix, kvbuf, len);
+	return get_xattritem(prefix, kvbuf, len, map);
 }
 
 static struct xattr_item *erofs_get_selabel_xattr(const char *srcpath,
@@ -228,6 +269,7 @@ static struct xattr_item *erofs_get_selabel_xattr(const char *srcpath,
 		int ret;
 		unsigned int len[2];
 		char *kvbuf, *fspath;
+		u32 map;
 
 		if (cfg.mount_point)
 			ret = asprintf(&fspath, "/%s/%s", cfg.mount_point,
@@ -260,7 +302,8 @@ static struct xattr_item *erofs_get_selabel_xattr(const char *srcpath,
 		}
 		sprintf(kvbuf, "selinux%s", secontext);
 		freecon(secontext);
-		return get_xattritem(EROFS_XATTR_INDEX_SECURITY, kvbuf, len);
+		map = erofs_xattr_calc_bloom_map(EROFS_XATTR_INDEX_SECURITY, "selinux", len[0]);
+		return get_xattritem(EROFS_XATTR_INDEX_SECURITY, kvbuf, len, map);
 	}
 #endif
 	return NULL;
@@ -411,6 +454,7 @@ static int erofs_droid_xattr_set_caps(struct erofs_inode *inode)
 	unsigned int len[2];
 	struct vfs_cap_data caps;
 	struct xattr_item *item;
+	u32 map;
 
 	if (!capabilities)
 		return 0;
@@ -430,6 +474,7 @@ static int erofs_droid_xattr_set_caps(struct erofs_inode *inode)
 	caps.data[1].inheritable = 0;
 	memcpy(kvbuf + len[0], &caps, len[1]);
 
+	map = erofs_xattr_calc_bloom_map(EROFS_XATTR_INDEX_SECURITY, "capability", len[0]);
 	item = get_xattritem(EROFS_XATTR_INDEX_SECURITY, kvbuf, len);
 	if (IS_ERR(item))
 		return PTR_ERR(item);
@@ -755,6 +800,17 @@ char *erofs_export_xattr_ibody(struct list_head *ixattrs, unsigned int size)
 	header = (struct erofs_xattr_ibody_header *)buf;
 	header->h_shared_count = 0;
 
+	if (cfg.c_xattr_bloom) {
+		u32 bloom_map = 0;
+
+		list_for_each_entry_safe(node, n, ixattrs, list) {
+			struct xattr_item *const item = node->item;
+			bloom_map |= item->bloom_map;
+		}
+		bloom_map = EROFS_XATTR_BLOOM_DEFAULT & ~bloom_map;
+		header->h_map = cpu_to_le32(bloom_map);
+	}
+
 	p = sizeof(struct erofs_xattr_ibody_header);
 	list_for_each_entry_safe(node, n, ixattrs, list) {
 		struct xattr_item *const item = node->item;
diff --git a/mkfs/main.c b/mkfs/main.c
index 3ec4903..08619f0 100644
--- a/mkfs/main.c
+++ b/mkfs/main.c
@@ -58,6 +58,7 @@ static struct option long_options[] = {
 	{"gid-offset", required_argument, NULL, 17},
 	{"mount-point", required_argument, NULL, 512},
 	{"xattr-prefix", required_argument, NULL, 19},
+	{"xattr-bloom", no_argument, NULL, 20},
 #ifdef WITH_ANDROID
 	{"product-out", required_argument, NULL, 513},
 	{"fs-config-file", required_argument, NULL, 514},
@@ -118,6 +119,7 @@ static void usage(void)
 	      " --random-algorithms   randomize per-file algorithms (debugging only)\n"
 #endif
 	      " --xattr-prefix=X      X=extra xattr name prefix\n"
+	      " --xattr-bloom	      enable xattr bloom filter\n"
 	      " --mount-point=X       X=prefix of target fs path (default: /)\n"
 #ifdef WITH_ANDROID
 	      "\nwith following android-specific options:\n"
@@ -482,6 +484,10 @@ static int mkfs_parse_options_cfg(int argc, char *argv[])
 			}
 			cfg.c_extra_ea_name_prefixes = true;
 			break;
+		case 20:
+			cfg.c_xattr_bloom = true;
+			erofs_sb_set_xattr_bloom();
+			break;
 		case 1:
 			usage();
 			exit(0);
-- 
2.19.1.6.gb485710b

