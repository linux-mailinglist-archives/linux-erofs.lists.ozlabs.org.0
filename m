Return-Path: <linux-erofs+bounces-1139-lists+linux-erofs=lfdr.de@lists.ozlabs.org>
X-Original-To: lists+linux-erofs@lfdr.de
Delivered-To: lists+linux-erofs@lfdr.de
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2404:9400:2:0:216:3eff:fee1:b9f1])
	by mail.lfdr.de (Postfix) with ESMTPS id 47DBBBABACD
	for <lists+linux-erofs@lfdr.de>; Tue, 30 Sep 2025 08:39:15 +0200 (CEST)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4cbT142T63z3cZR;
	Tue, 30 Sep 2025 16:39:04 +1000 (AEST)
X-Original-To: linux-erofs@lists.ozlabs.org
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip=115.124.30.112
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1759214344;
	cv=none; b=IyhGRGAHDpksau0c3yuJ3hahLnBAZnIoQgcRrmyO7FPEO4TmV4LZu6o4435JhRMTVCALDyMdM6V1KaV3YC3CDFKg+AST7EaKhV30TrtCZjskbexCm4EBek42/tI14qVoeIBm0e+iz/p85cqLvuQ9UFOuDNSl3UYqIJHj3puZ/XS6r0dKp2v4Cioz/M9gVcHppRjyibwZr2xDy9OtW320jWkp3nNQ1BwEdosvWR/yY/U2jGULdOP2kixDBpqdRzAr4uah5CterQ7E/luVjGHd1vfQCskbBbtThkLTMP34UKA9Hi3X0lcF5r9H+Ij872tayIbxuP8RDsPxeZqGhki7sg==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1759214344; c=relaxed/relaxed;
	bh=vI+SzmJ4vPRB0PbDbEqEFnI+hVtn6dacPgy4wbruS/o=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=f0RJAMeqzV5GaQGE4Ut2o0R2NaN2vG40ywO0PWsy+fxoY3b8KBjPvJBNycm1kclEOi3+hob1Tg+Pkm1ZGubYhP32KwVBb1YqnU9lak4C+kYod7t5RSv8/rrGSS4KJLNsN5eRIJEP+S5heIzED4OsFp+cDfKc/SVrh5dbrDVT7jOHFk3HSR/DeIQ5AtZzYnAwT0E8S1S2zXdpDL6eG1ZxWsL6BplDdX3A3LGjs1zpkglTWLx01r3KPJ7ThlBwDMc21oG63xZp64AlKnJ8Gc3aDePQBmn5rZP/wV/0349qWR2VjEOxpDWhCJmIdcCt8dXtWo7PK4aKeRld9uIpepNzhQ==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com; dkim=pass (1024-bit key; unprotected) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.a=rsa-sha256 header.s=default header.b=jHG8sc0z; dkim-atps=neutral; spf=pass (client-ip=115.124.30.112; helo=out30-112.freemail.mail.aliyun.com; envelope-from=hsiangkao@linux.alibaba.com; receiver=lists.ozlabs.org) smtp.mailfrom=linux.alibaba.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (1024-bit key; unprotected) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.a=rsa-sha256 header.s=default header.b=jHG8sc0z;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=linux.alibaba.com (client-ip=115.124.30.112; helo=out30-112.freemail.mail.aliyun.com; envelope-from=hsiangkao@linux.alibaba.com; receiver=lists.ozlabs.org)
Received: from out30-112.freemail.mail.aliyun.com (out30-112.freemail.mail.aliyun.com [115.124.30.112])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4cbT1031rgz3cZd
	for <linux-erofs@lists.ozlabs.org>; Tue, 30 Sep 2025 16:38:59 +1000 (AEST)
DKIM-Signature:v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=linux.alibaba.com; s=default;
	t=1759214335; h=From:To:Subject:Date:Message-ID:MIME-Version;
	bh=vI+SzmJ4vPRB0PbDbEqEFnI+hVtn6dacPgy4wbruS/o=;
	b=jHG8sc0zXgsoqdGKKSzKEyN52TMW9S+h2kRSZ647mXEa5GIEoIeKVBcdtw2YxYIyUtM+xivuOJ5OqzFHPnR6gdrczZhnmLz2tZtZd84f+LiugyWuFBdwknboKMkHf08sQ2BrgBrgSrsNVGTbZklvEvvm8hjqmsmgaGLrN8e7e2A=
Received: from x31i01179.sqa.na131.tbsite.net(mailfrom:hsiangkao@linux.alibaba.com fp:SMTPD_---0WpARbkw_1759214333 cluster:ay36)
          by smtp.aliyun-inc.com;
          Tue, 30 Sep 2025 14:38:54 +0800
From: Gao Xiang <hsiangkao@linux.alibaba.com>
To: linux-erofs@lists.ozlabs.org
Cc: Gao Xiang <hsiangkao@linux.alibaba.com>
Subject: [PATCH 3/5] erofs-utils: lib: switch to per-sb `struct erofs_xattrmgr`
Date: Tue, 30 Sep 2025 14:38:45 +0800
Message-ID: <20250930063847.2143732-3-hsiangkao@linux.alibaba.com>
X-Mailer: git-send-email 2.43.5
In-Reply-To: <20250930063847.2143732-1-hsiangkao@linux.alibaba.com>
References: <20250930063847.2143732-1-hsiangkao@linux.alibaba.com>
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

It allows the xattr generator to be used for multiple instances.

Signed-off-by: Gao Xiang <hsiangkao@linux.alibaba.com>
---
 include/erofs/internal.h |   2 +
 include/erofs/xattr.h    |   4 +-
 lib/importer.c           |   4 +-
 lib/super.c              |   2 +-
 lib/xattr.c              | 123 ++++++++++++++++++++++++---------------
 5 files changed, 85 insertions(+), 50 deletions(-)

diff --git a/include/erofs/internal.h b/include/erofs/internal.h
index f022a0c..e8d8667 100644
--- a/include/erofs/internal.h
+++ b/include/erofs/internal.h
@@ -85,6 +85,7 @@ struct erofs_xattr_prefix_item {
 
 struct erofs_mkfs_dfops;
 struct erofs_packed_inode;
+struct erofs_xattrmgr;
 struct z_erofs_mgr;
 struct erofs_metaboxmgr;
 
@@ -147,6 +148,7 @@ struct erofs_sb_info {
 	struct erofs_mkfs_dfops *mkfs_dfops;
 #endif
 	struct erofs_bufmgr *bmgr;
+	struct erofs_xattrmgr *xamgr;
 	struct z_erofs_mgr *zmgr;
 	struct erofs_metaboxmgr *m2gr;
 	struct erofs_packed_inode *packedinode;
diff --git a/include/erofs/xattr.h b/include/erofs/xattr.h
index dc1e3ed..67f6199 100644
--- a/include/erofs/xattr.h
+++ b/include/erofs/xattr.h
@@ -45,7 +45,7 @@ static inline unsigned int xattrblock_offset(struct erofs_inode *vi,
 
 struct erofs_importer;
 
-void erofs_xattr_init(struct erofs_sb_info *sbi);
+int erofs_xattr_init(struct erofs_sb_info *sbi);
 int erofs_scan_file_xattrs(struct erofs_inode *inode);
 int erofs_prepare_xattr_ibody(struct erofs_inode *inode, bool noroom);
 char *erofs_export_xattr_ibody(struct erofs_inode *inode);
@@ -54,7 +54,6 @@ int erofs_build_shared_xattrs_from_path(struct erofs_sb_info *sbi, const char *p
 int erofs_xattr_insert_name_prefix(const char *prefix);
 void erofs_xattr_cleanup_name_prefixes(void);
 int erofs_xattr_flush_name_prefixes(struct erofs_importer *im, bool plain);
-void erofs_xattr_prefixes_cleanup(struct erofs_sb_info *sbi);
 int erofs_xattr_prefixes_init(struct erofs_sb_info *sbi);
 
 int erofs_setxattr(struct erofs_inode *inode, char *key,
@@ -66,6 +65,7 @@ int erofs_read_xattrs_from_disk(struct erofs_inode *inode);
 
 bool erofs_xattr_prefix_matches(const char *key, unsigned int *index,
 				unsigned int *len);
+void erofs_xattr_exit(struct erofs_sb_info *sbi);
 
 #ifdef __cplusplus
 }
diff --git a/lib/importer.c b/lib/importer.c
index 48d6640..fed7bab 100644
--- a/lib/importer.c
+++ b/lib/importer.c
@@ -48,7 +48,9 @@ int erofs_importer_init(struct erofs_importer *im)
 	erofs_importer_global_init();
 
 	subsys = "xattr";
-	erofs_xattr_init(sbi);
+	err = erofs_xattr_init(sbi);
+	if (err)
+		goto out_err;
 
 	subsys = "compression";
 	err = z_erofs_compress_init(im);
diff --git a/lib/super.c b/lib/super.c
index 0540b15..9760265 100644
--- a/lib/super.c
+++ b/lib/super.c
@@ -171,12 +171,12 @@ void erofs_put_super(struct erofs_sb_info *sbi)
 		free(sbi->devs);
 		sbi->devs = NULL;
 	}
-	erofs_xattr_prefixes_cleanup(sbi);
 	if (sbi->bmgr) {
 		erofs_buffer_exit(sbi->bmgr);
 		sbi->bmgr = NULL;
 	}
 	z_erofs_compress_exit(sbi);
+	erofs_xattr_exit(sbi);
 	sbi->sb_valid = false;
 }
 
diff --git a/lib/xattr.c b/lib/xattr.c
index ec3eb5e..6e1958b 100644
--- a/lib/xattr.c
+++ b/lib/xattr.c
@@ -124,20 +124,28 @@ struct erofs_inode_xattr_node {
 	struct erofs_xattritem *item;
 };
 
-static struct erofs_xattrmgr {
+struct erofs_xattrmgr {
 	struct list_head hash[1 << 14];
 	struct erofs_xattritem *shared_xattrs;
 	unsigned int sharedxattr_count;
-} g_xattrmgr;
+};
 
-void erofs_xattr_init(struct erofs_sb_info *sbi)
+int erofs_xattr_init(struct erofs_sb_info *sbi)
 {
+	struct erofs_xattrmgr *xamgr = sbi->xamgr;
 	unsigned int i;
 
-	if (g_xattrmgr.hash[0].next)
-		return;
-	for (i = 0; i < ARRAY_SIZE(g_xattrmgr.hash); ++i)
-		init_list_head(&g_xattrmgr.hash[i]);
+	if (xamgr)
+		return 0;
+
+	xamgr = malloc(sizeof(struct erofs_xattrmgr));
+	if (!xamgr)
+		return -ENOMEM;
+
+	for (i = 0; i < ARRAY_SIZE(xamgr->hash); ++i)
+		init_list_head(&xamgr->hash[i]);
+	sbi->xamgr = xamgr;
+	return 0;
 }
 
 static struct erofs_xattr_prefix {
@@ -210,8 +218,10 @@ static unsigned int put_xattritem(struct erofs_xattritem *item)
 	return 0;
 }
 
-static struct erofs_xattritem *get_xattritem(char *kvbuf, unsigned int len[2])
+static struct erofs_xattritem *get_xattritem(struct erofs_sb_info *sbi,
+					     char *kvbuf, unsigned int len[2])
 {
+	struct erofs_xattrmgr *xamgr = sbi->xamgr;
 	struct erofs_xattritem *item;
 	struct ea_type_node *tnode;
 	struct list_head *head;
@@ -219,8 +229,8 @@ static struct erofs_xattritem *get_xattritem(char *kvbuf, unsigned int len[2])
 
 	hash[0] = BKDRHash(kvbuf, len[0]);
 	hash[1] = BKDRHash(kvbuf + EROFS_XATTR_KSIZE(len), len[1]);
-	hkey = (hash[0] ^ hash[1]) & (ARRAY_SIZE(g_xattrmgr.hash) - 1);
-	head = g_xattrmgr.hash + hkey;
+	hkey = (hash[0] ^ hash[1]) & (ARRAY_SIZE(xamgr->hash) - 1);
+	head = xamgr->hash + hkey;
 	list_for_each_entry(item, head, node) {
 		if (item->len[0] == len[0] && item->len[1] == len[1] &&
 		    item->hash[0] == hash[0] && item->hash[1] == hash[1] &&
@@ -261,7 +271,8 @@ static struct erofs_xattritem *get_xattritem(char *kvbuf, unsigned int len[2])
 	return item;
 }
 
-static struct erofs_xattritem *parse_one_xattr(const char *path, const char *key,
+static struct erofs_xattritem *parse_one_xattr(struct erofs_sb_info *sbi,
+					       const char *path, const char *key,
 					       unsigned int keylen)
 {
 	ssize_t ret;
@@ -301,7 +312,7 @@ static struct erofs_xattritem *parse_one_xattr(const char *path, const char *key
 		}
 	}
 
-	item = get_xattritem(kvbuf, len);
+	item = get_xattritem(sbi, kvbuf, len);
 	if (!IS_ERR(item))
 		return item;
 	ret = PTR_ERR(item);
@@ -310,7 +321,8 @@ out:
 	return ERR_PTR(ret);
 }
 
-static struct erofs_xattritem *erofs_get_selabel_xattr(const char *srcpath,
+static struct erofs_xattritem *erofs_get_selabel_xattr(struct erofs_sb_info *sbi,
+						       const char *srcpath,
 						       mode_t mode)
 {
 #ifdef HAVE_LIBSELINUX
@@ -353,7 +365,7 @@ static struct erofs_xattritem *erofs_get_selabel_xattr(const char *srcpath,
 		sprintf(kvbuf, "%s", XATTR_NAME_SECURITY_SELINUX);
 		memcpy(kvbuf + EROFS_XATTR_KSIZE(len), secontext, len[1]);
 		freecon(secontext);
-		item = get_xattritem(kvbuf, len);
+		item = get_xattritem(sbi, kvbuf, len);
 		if (IS_ERR(item))
 			free(kvbuf);
 		return item;
@@ -374,15 +386,18 @@ static int inode_xattr_add(struct list_head *hlist, struct erofs_xattritem *item
 	return 0;
 }
 
-static int erofs_xattr_add(struct list_head *ixattrs, struct erofs_xattritem *item)
+static int erofs_xattr_add(struct erofs_sb_info *sbi, struct list_head *ixattrs,
+			   struct erofs_xattritem *item)
 {
+	struct erofs_xattrmgr *xamgr = sbi->xamgr;
+
 	if (ixattrs)
 		return inode_xattr_add(ixattrs, item);
 
 	if (item->count == cfg.c_inline_xattr_tolerance + 1) {
-		item->next_shared_xattr = g_xattrmgr.shared_xattrs;
-		g_xattrmgr.shared_xattrs = item;
-		++g_xattrmgr.sharedxattr_count;
+		item->next_shared_xattr = xamgr->shared_xattrs;
+		xamgr->shared_xattrs = item;
+		++xamgr->sharedxattr_count;
 	}
 	return 0;
 }
@@ -397,8 +412,8 @@ static bool erofs_is_skipped_xattr(const char *key)
 	return false;
 }
 
-static int read_xattrs_from_file(const char *path, mode_t mode,
-				 struct list_head *ixattrs)
+static int read_xattrs_from_file(struct erofs_sb_info *sbi, const char *path,
+				 mode_t mode, struct list_head *ixattrs)
 {
 	ssize_t kllen = erofs_sys_llistxattr(path, NULL, 0);
 	char *keylst, *key, *klend;
@@ -441,7 +456,7 @@ static int read_xattrs_from_file(const char *path, mode_t mode,
 		if (erofs_is_skipped_xattr(key))
 			continue;
 
-		item = parse_one_xattr(path, key, keylen);
+		item = parse_one_xattr(sbi, path, key, keylen);
 		/* skip inaccessible xattrs */
 		if (item == ERR_PTR(-ENODATA) || !item) {
 			erofs_warn("skipped inaccessible xattr %s in %s",
@@ -453,7 +468,7 @@ static int read_xattrs_from_file(const char *path, mode_t mode,
 			goto err;
 		}
 
-		ret = erofs_xattr_add(ixattrs, item);
+		ret = erofs_xattr_add(sbi, ixattrs, item);
 		if (ret < 0)
 			goto err;
 	}
@@ -461,11 +476,11 @@ static int read_xattrs_from_file(const char *path, mode_t mode,
 
 out:
 	/* if some selabel is avilable, need to add right now */
-	item = erofs_get_selabel_xattr(path, mode);
+	item = erofs_get_selabel_xattr(sbi, path, mode);
 	if (IS_ERR(item))
 		return PTR_ERR(item);
 	if (item)
-		ret = erofs_xattr_add(ixattrs, item);
+		ret = erofs_xattr_add(sbi, ixattrs, item);
 	return ret;
 
 err:
@@ -476,6 +491,7 @@ err:
 int erofs_setxattr(struct erofs_inode *inode, char *key,
 		   const void *value, size_t size)
 {
+	struct erofs_sb_info *sbi = inode->sbi;
 	char *kvbuf;
 	unsigned int len[2];
 	struct erofs_xattritem *item;
@@ -490,14 +506,14 @@ int erofs_setxattr(struct erofs_inode *inode, char *key,
 	memcpy(kvbuf, key, EROFS_XATTR_KSIZE(len));
 	memcpy(kvbuf + EROFS_XATTR_KSIZE(len), value, size);
 
-	item = get_xattritem(kvbuf, len);
+	item = get_xattritem(sbi, kvbuf, len);
 	if (IS_ERR(item)) {
 		free(kvbuf);
 		return PTR_ERR(item);
 	}
 	DBG_BUGON(!item);
 
-	return erofs_xattr_add(&inode->i_xattrs, item);
+	return erofs_xattr_add(sbi, &inode->i_xattrs, item);
 }
 
 static void erofs_removexattr(struct erofs_inode *inode, const char *key)
@@ -531,6 +547,7 @@ int erofs_set_origin_xattr(struct erofs_inode *inode)
 #ifdef WITH_ANDROID
 static int erofs_droid_xattr_set_caps(struct erofs_inode *inode)
 {
+	struct erofs_sb_info *sbi = inode->sbi;
 	const u64 capabilities = inode->capabilities;
 	char *kvbuf;
 	unsigned int len[2];
@@ -555,14 +572,14 @@ static int erofs_droid_xattr_set_caps(struct erofs_inode *inode)
 	caps.data[1].inheritable = 0;
 	memcpy(kvbuf + EROFS_XATTR_KSIZE(len), &caps, len[1]);
 
-	item = get_xattritem(kvbuf, len);
+	item = get_xattritem(sbi, kvbuf, len);
 	if (IS_ERR(item)) {
 		free(kvbuf);
 		return PTR_ERR(item);
 	}
 	DBG_BUGON(!item);
 
-	return erofs_xattr_add(&inode->i_xattrs, item);
+	return erofs_xattr_add(sbi, &inode->i_xattrs, item);
 }
 #else
 static int erofs_droid_xattr_set_caps(struct erofs_inode *inode)
@@ -580,7 +597,8 @@ int erofs_scan_file_xattrs(struct erofs_inode *inode)
 	if (cfg.c_inline_xattr_tolerance < 0)
 		return 0;
 
-	ret = read_xattrs_from_file(inode->i_srcpath, inode->i_mode, ixattrs);
+	ret = read_xattrs_from_file(inode->sbi, inode->i_srcpath,
+				    inode->i_mode, ixattrs);
 	if (ret < 0)
 		return ret;
 
@@ -705,7 +723,8 @@ out:
 	return ret;
 }
 
-static int erofs_count_all_xattrs_from_path(const char *path)
+static int erofs_count_all_xattrs_from_path(struct erofs_sb_info *sbi,
+					    const char *path)
 {
 	int ret;
 	DIR *_dir;
@@ -732,8 +751,7 @@ static int erofs_count_all_xattrs_from_path(const char *path)
 		if (!dp)
 			break;
 
-		if (is_dot_dotdot(dp->d_name) ||
-		    !strncmp(dp->d_name, "lost+found", strlen("lost+found")))
+		if (is_dot_dotdot(dp->d_name))
 			continue;
 
 		ret = snprintf(buf, PATH_MAX, "%s/%s", path, dp->d_name);
@@ -750,14 +768,14 @@ static int erofs_count_all_xattrs_from_path(const char *path)
 			goto fail;
 		}
 
-		ret = read_xattrs_from_file(buf, st.st_mode, NULL);
+		ret = read_xattrs_from_file(sbi, buf, st.st_mode, NULL);
 		if (ret)
 			goto fail;
 
 		if (!S_ISDIR(st.st_mode))
 			continue;
 
-		ret = erofs_count_all_xattrs_from_path(buf);
+		ret = erofs_count_all_xattrs_from_path(sbi, buf);
 		if (ret)
 			goto fail;
 	}
@@ -770,13 +788,13 @@ fail:
 	return ret;
 }
 
-static void erofs_cleanxattrs(bool sharedxattrs)
+static void erofs_cleanxattrs(struct erofs_xattrmgr *xamgr, bool sharedxattrs)
 {
 	struct erofs_xattritem *item, *n;
 	unsigned int i;
 
-	for (i = 0; i < ARRAY_SIZE(g_xattrmgr.hash); ++i) {
-		list_for_each_entry_safe(item, n, g_xattrmgr.hash + i, node) {
+	for (i = 0; i < ARRAY_SIZE(xamgr->hash); ++i) {
+		list_for_each_entry_safe(item, n, xamgr->hash + i, node) {
 			if (sharedxattrs && item->shared_xattr_id >= 0)
 				continue;
 			list_del(&item->node);
@@ -787,7 +805,7 @@ static void erofs_cleanxattrs(bool sharedxattrs)
 
 	if (sharedxattrs)
 		return;
-	g_xattrmgr.sharedxattr_count = 0;
+	xamgr->sharedxattr_count = 0;
 }
 
 static int comp_shared_xattritem(const void *a, const void *b)
@@ -921,6 +939,7 @@ static void erofs_write_xattr_entry(char *buf, struct erofs_xattritem *item)
 
 int erofs_build_shared_xattrs_from_path(struct erofs_sb_info *sbi, const char *path)
 {
+	struct erofs_xattrmgr *xamgr = sbi->xamgr;
 	struct erofs_xattritem *item, *n, **sorted_n;
 	unsigned int sharedxattr_count, p, i;
 	struct erofs_buffer_head *bh;
@@ -934,15 +953,15 @@ int erofs_build_shared_xattrs_from_path(struct erofs_sb_info *sbi, const char *p
 	    cfg.c_inline_xattr_tolerance == INT_MAX)
 		return 0;
 
-	if (g_xattrmgr.sharedxattr_count) {
+	if (xamgr->sharedxattr_count) {
 		DBG_BUGON(1);
 		return -EINVAL;
 	}
 
-	ret = erofs_count_all_xattrs_from_path(path);
+	ret = erofs_count_all_xattrs_from_path(sbi, path);
 	if (ret)
 		return ret;
-	sharedxattr_count = g_xattrmgr.sharedxattr_count;
+	sharedxattr_count = xamgr->sharedxattr_count;
 	if (!sharedxattr_count)
 		goto out;
 
@@ -951,10 +970,10 @@ int erofs_build_shared_xattrs_from_path(struct erofs_sb_info *sbi, const char *p
 		return -ENOMEM;
 
 	i = 0;
-	while (g_xattrmgr.shared_xattrs) {
-		item = g_xattrmgr.shared_xattrs;
+	while (xamgr->shared_xattrs) {
+		item = xamgr->shared_xattrs;
 		sorted_n[i++] = item;
-		g_xattrmgr.shared_xattrs = item->next_shared_xattr;
+		xamgr->shared_xattrs = item->next_shared_xattr;
 		shared_xattrs_size = erofs_next_xattr_align(shared_xattrs_size,
 							    item);
 	}
@@ -989,14 +1008,14 @@ int erofs_build_shared_xattrs_from_path(struct erofs_sb_info *sbi, const char *p
 		item->shared_xattr_id = (off + p) / sizeof(__le32);
 		p = erofs_next_xattr_align(p, item);
 	}
-	g_xattrmgr.shared_xattrs = sorted_n[0];
+	xamgr->shared_xattrs = sorted_n[0];
 	free(sorted_n);
 	bh->op = &erofs_drop_directly_bhops;
 	ret = erofs_dev_write(sbi, buf, erofs_btell(bh, false), shared_xattrs_size);
 	free(buf);
 	erofs_bdrop(bh, false);
 out:
-	erofs_cleanxattrs(true);
+	erofs_cleanxattrs(xamgr, true);
 	return ret;
 }
 
@@ -1726,3 +1745,15 @@ out:
 		erofs_xattr_prefixes_cleanup(sbi);
 	return ret;
 }
+
+void erofs_xattr_exit(struct erofs_sb_info *sbi)
+{
+	struct erofs_xattrmgr *xamgr = sbi->xamgr;
+
+	erofs_xattr_prefixes_cleanup(sbi);
+	if (!xamgr)
+		return;
+	erofs_cleanxattrs(xamgr, false);
+	sbi->xamgr = NULL;
+	free(xamgr);
+}
-- 
2.43.5


