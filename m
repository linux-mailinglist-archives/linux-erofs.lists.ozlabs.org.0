Return-Path: <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>
X-Original-To: lists+linux-erofs@lfdr.de
Delivered-To: lists+linux-erofs@lfdr.de
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2401:3900:2:1::3])
	by mail.lfdr.de (Postfix) with ESMTPS id CC61A1F18D8
	for <lists+linux-erofs@lfdr.de>; Mon,  8 Jun 2020 14:35:07 +0200 (CEST)
Received: from bilbo.ozlabs.org (lists.ozlabs.org [IPv6:2401:3900:2:1::3])
	by lists.ozlabs.org (Postfix) with ESMTP id 49gXlD4VfJzDqSZ
	for <lists+linux-erofs@lfdr.de>; Mon,  8 Jun 2020 22:35:04 +1000 (AEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=lists.ozlabs.org;
	s=201707; t=1591619704;
	bh=QwUV49BdVat/vIjCrZRafVEK6byBUHFK7Inc/rUoHsU=;
	h=To:Subject:Date:In-Reply-To:References:List-Id:List-Unsubscribe:
	 List-Archive:List-Post:List-Help:List-Subscribe:From:Reply-To:Cc:
	 From;
	b=Wrp7sA8Lj/Q6/VkWVKrj1CFM+JZis1yglh7098/eFWyCtLdsw65X++pdjjMP0JSkM
	 UM0Ae9wwr6RyDIhCCaHY+qFATLTn92grGGPZp+lQR1KflmXGpoLWLT3hM0G1rRc7Uq
	 KmhsZ46J+9FCLVHO1EIFbXGLXhrg/zne01oACJkjog8fp42kQFjiz8FLeI1ByZLUkS
	 mMi32XpBDBDXjAnDO7pPlTCNiNcXJlvKSVPBsKDLCbgSICCufVWabepATOwUzNBwxD
	 3riU1m4uaAlIqy+0mrNhBoyNu4CZvGn52QMsP/XOjHsE6t5b5y83eB71GGo6whReM0
	 0SK1Jmz+MkD7Q==
X-Original-To: linux-erofs@lists.ozlabs.org
Delivered-To: linux-erofs@lists.ozlabs.org
Authentication-Results: lists.ozlabs.org;
 spf=pass (sender SPF authorized) smtp.mailfrom=aol.com
 (client-ip=98.137.65.146; helo=sonic309-20.consmr.mail.gq1.yahoo.com;
 envelope-from=hsiangkao@aol.com; receiver=<UNKNOWN>)
Authentication-Results: lists.ozlabs.org;
 dmarc=pass (p=reject dis=none) header.from=aol.com
Authentication-Results: lists.ozlabs.org; dkim=pass (2048-bit key;
 unprotected) header.d=aol.com header.i=@aol.com header.a=rsa-sha256
 header.s=a2048 header.b=TVit5wXo; dkim-atps=neutral
Received: from sonic309-20.consmr.mail.gq1.yahoo.com
 (sonic309-20.consmr.mail.gq1.yahoo.com [98.137.65.146])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 49gXkv0RyfzDqLF
 for <linux-erofs@lists.ozlabs.org>; Mon,  8 Jun 2020 22:34:37 +1000 (AEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=aol.com; s=a2048;
 t=1591619668; bh=z0VIplKWJXByiJYjfCchhh4yHI1ioCnTj5vn5S4PkA8=;
 h=From:To:Cc:Subject:Date:In-Reply-To:References:From:Subject;
 b=TVit5wXolhvxgZd05dVILw+iP8eet5ocAKih58MZbmuNIsPHJUanHIkXgIelKpWmMjAm3PBMKjO6lhBq+v7rLlcBb1+CmolvtIYtfUmk2ME+LbOOrMmoLWokmQvNOhJjlEjeNyYbD5TMTMwuMlNvbI6ic4A7yz3iSFRgdM+xHgIV13PAX3CkG0lgAGeJmoIh3Ymp0tb2F/O4h9o8av7rWPY4uRJYLkCzTNk8CJQpc8zWwxF92iij7hViWTmQIoGnxbh/oqi3zNWtZf0m06f29AtxMOnOcDo3EI8O9blg0kpMp954nEWnutouV3ebHB1rQFuoRDk7AxB3EtSNQ+Aimg==
X-YMail-OSG: MhCzv7AVM1kCDMFKPE8NNtJCknhuXQi7fyjt41aMLUm8qQ8MnJ3JHuJ61AJO_rP
 wGr39l8t6FWMqHZ7yDZPtjgMZYfop3KR9mOqdRymlSu7LMNM9KiG7k1aXaCpQHvvEQtEhPl1PrxX
 K.ON2N.dGKTFDRZRC518dg62RDvaEe5_q1VUkqn55Jwfno4wSeRTovgh9PDZeh22lOIXw96G2aJO
 8pkaRefZJn2dJdZ27yv_s_ImCBTsB4IGLXD50glm_XZBNgnKsSk0H9._.mM5a0sthFqro6Pcrs4M
 9eCDVgRRJEsQDiCC2UMplDZFQrNWzCA0_PSFSutrB9YmARcoSs9HBJCSfXtaGnbvUAR1HVE18Vew
 iQ8nO8D3c3ad41DuuNCvJKvuJ6XezJCeLwSh1nJ7d90GiCeeTShC4UuVc.62X2sVRSNrBSL_uf3T
 MeUcavXoH0fAvEwVVZyfKT9yzbEAVoRE.rme3OiLKGUvCnzDEauNtisJarXmtdVLkjWUVPN6V0bs
 KL9s87BpTyuKbyxgjZD4lLjnsMBNyHCwjEVEv009Dbgz7TM6CdzyTFl.YoPnnivQuvaxujmHy1rn
 tEtrd30K5fhUop5fZ84aQmwQm.z09D8wyNgLKuqTF4rWef_aWxIQlteEC2NuxT6p1C1Ev10xuNtb
 S625siUcA.1QbH5rM0jZiE9ajvu15V9zjTd5m4m2r4m71g6VNKHgEJ70Ds2ouHOJQWGtmemIsrZY
 LQ_PX9t3_2sIQnTWKSvZKAoTk10VyDagMZ6fTEnfj3U75gmfy6nNU9Y7norHPGRTwiq_MKMoIynD
 XLmL1vk4QlbGIiYBhUEpZoWuOnySOUpR7CV7_.e0zHifAR.1vzW.HSSn5jtqen6Rq7KIC.ufrQt9
 5VF8sS5jdeSB_0DZ02ad6n5yZHouOKhKxf5d12tMKkxJ4myJ0MNIjZzENYNdzs0N3VsfMuO5Sf1v
 iiKjjfvQO47XyreIBHsx_YDt78kqDL3RWHEKTqaBGyeYWAnZ696nAoLYPMKQ5YIUIfP38J5YQUPX
 1QMBJUk.THzg6mrOkpqh4Ex0RuWjhVt3s37Zryh3eUpMBE1SJ9oY6JRp1hBDYz8WoHhC6LMzoOF5
 dV0_JKOGWa.q3ePwd5uAkwb7czfN21rbK4hV7ZL1fDcMUO9.BhUqgHem2T.oCZWUg7EmE477PPZJ
 L5k2tjuuZLS35Eyk0kOprIcs4bSgWH2vgMq99ultRchtsu6f3Rfv8mbKBsSxEaUSX4lEJktLHuw1
 b80Z1EVIaAF50VIkLr1mEnS5FkLytdBf4V0oy7NAHoAxXG..D4webvjtiLBJGC.8BqTy1ZdiGU4s
 EBmytjDnRnXB28_QFLH4LajSXzPIniJrkhdxJbzMUO0j0JXEjkBR9rxGzH59rq3PRP4m1Y3AVrbf
 pF2vu5RvSvlSurFBty3GghJj7ww--
Received: from sonic.gate.mail.ne1.yahoo.com by
 sonic309.consmr.mail.gq1.yahoo.com with HTTP; Mon, 8 Jun 2020 12:34:28 +0000
Received: by smtp431.mail.gq1.yahoo.com (VZM Hermes SMTP Server) with ESMTPA
 ID d565ec533e9d335b9d38e5c07e052fbd; 
 Mon, 08 Jun 2020 12:34:27 +0000 (UTC)
To: linux-erofs@lists.ozlabs.org
Subject: [PATCH v3] erofs-utils: support selinux file contexts
Date: Mon,  8 Jun 2020 20:34:14 +0800
Message-Id: <20200608123414.12572-1-hsiangkao@aol.com>
X-Mailer: git-send-email 2.24.0
In-Reply-To: <20200606081752.27848-1-hsiangkao@redhat.com>
References: <20200606081752.27848-1-hsiangkao@redhat.com>
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
From: Gao Xiang via Linux-erofs <linux-erofs@lists.ozlabs.org>
Reply-To: hsiangkao@aol.com
Cc: Li Guifu <bluce.lee@aliyun.com>
Errors-To: linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org
Sender: "Linux-erofs"
 <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>

From: Gao Xiang <hsiangkao@redhat.com>

Add --file-contexts flag that allows passing a selinux
file_context file to setup file selabels.

Reviewed-and-tested-by: Li Guifu <bluce.lee@aliyun.com>
Signed-off-by: Gao Xiang <hsiangkao@redhat.com>
---
changes since v2:
 - fix variable "secontext" memory leak in erofs_get_selabel_xattr.

 configure.ac           |  27 +++++++++
 include/erofs/config.h |  21 +++++++
 include/erofs/xattr.h  |   3 +-
 lib/config.c           |  42 +++++++++++++
 lib/exclude.c          |  12 +---
 lib/inode.c            |   3 +-
 lib/xattr.c            | 132 ++++++++++++++++++++++++++++++++---------
 man/mkfs.erofs.1       |   3 +
 mkfs/Makefile.am       |   4 +-
 mkfs/main.c            |  15 ++++-
 10 files changed, 219 insertions(+), 43 deletions(-)

diff --git a/configure.ac b/configure.ac
index 870dfb9..5145971 100644
--- a/configure.ac
+++ b/configure.ac
@@ -67,6 +67,15 @@ AC_ARG_WITH(uuid,
    [AS_HELP_STRING([--without-uuid],
       [Ignore presence of libuuid and disable uuid support @<:@default=enabled@:>@])])
 
+AC_ARG_WITH(selinux,
+   [AS_HELP_STRING([--with-selinux],
+      [enable and build with selinux support @<:@default=no@:>@])],
+   [case "$with_selinux" in
+      yes|no) ;;
+      *) AC_MSG_ERROR([invalid argument to --with-selinux])
+      ;;
+    esac], [with_selinux=no])
+
 # Checks for libraries.
 # Use customized LZ4 library path when specified.
 AC_ARG_WITH(lz4-incdir,
@@ -160,6 +169,20 @@ return 0;
   LIBS="${saved_LIBS}"
   CPPFLAGS="${saved_CPPFLAGS}"], [have_uuid="no"])
 
+# Configure selinux
+AS_IF([test "x$with_selinux" != "xno"], [
+  PKG_CHECK_MODULES([libselinux], [libselinux])
+  # Paranoia: don't trust the result reported by pkgconfig before trying out
+  saved_LIBS="$LIBS"
+  saved_CPPFLAGS=${CPPFLAGS}
+  CPPFLAGS="${libselinux_CFLAGS} ${CPPFLAGS}"
+  LIBS="${libselinux_LIBS} $LIBS"
+  AC_CHECK_LIB(selinux, selabel_lookup, [
+    have_selinux="yes" ], [
+    AC_MSG_ERROR([libselinux doesn't work properly])])
+  LIBS="${saved_LIBS}"
+  CPPFLAGS="${saved_CPPFLAGS}"], [have_selinux="no"])
+
 # Configure lz4
 test -z $LZ4_LIBS && LZ4_LIBS='-llz4'
 
@@ -199,6 +222,10 @@ if test "x$have_uuid" = "xyes"; then
   AC_DEFINE([HAVE_LIBUUID], 1, [Define to 1 if libuuid is found])
 fi
 
+if test "x$have_selinux" = "xyes"; then
+  AC_DEFINE([HAVE_LIBSELINUX], 1, [Define to 1 if libselinux is found])
+fi
+
 if test "x${have_lz4}" = "xyes"; then
   AC_DEFINE([LZ4_ENABLED], [1], [Define to 1 if lz4 is enabled.])
 
diff --git a/include/erofs/config.h b/include/erofs/config.h
index 2be05ee..2f09749 100644
--- a/include/erofs/config.h
+++ b/include/erofs/config.h
@@ -10,6 +10,12 @@
 #define __EROFS_CONFIG_H
 
 #include "defs.h"
+#include "err.h"
+
+#ifdef HAVE_LIBSELINUX
+#include <selinux/selinux.h>
+#include <selinux/label.h>
+#endif
 
 enum {
 	FORCE_INODE_COMPACT = 1,
@@ -22,6 +28,9 @@ struct erofs_configure {
 	bool c_dry_run;
 	bool c_legacy_compress;
 
+#ifdef HAVE_LIBSELINUX
+	struct selabel_handle *sehnd;
+#endif
 	/* related arguments for mkfs.erofs */
 	char *c_img_path;
 	char *c_src_path;
@@ -39,5 +48,17 @@ void erofs_init_configure(void);
 void erofs_show_config(void);
 void erofs_exit_configure(void);
 
+void erofs_set_fs_root(const char *rootdir);
+const char *erofs_fspath(const char *fullpath);
+
+#ifdef HAVE_LIBSELINUX
+int erofs_selabel_open(const char *file_contexts);
+#else
+static inline int erofs_selabel_open(const char *file_contexts)
+{
+	return -EINVAL;
+}
+#endif
+
 #endif
 
diff --git a/include/erofs/xattr.h b/include/erofs/xattr.h
index 3dff1ea..2e99669 100644
--- a/include/erofs/xattr.h
+++ b/include/erofs/xattr.h
@@ -42,7 +42,8 @@
 #define XATTR_NAME_POSIX_ACL_DEFAULT "system.posix_acl_default"
 #endif
 
-int erofs_prepare_xattr_ibody(const char *path, struct list_head *ixattrs);
+int erofs_prepare_xattr_ibody(const char *path, mode_t mode,
+			      struct list_head *ixattrs);
 char *erofs_export_xattr_ibody(struct list_head *ixattrs, unsigned int size);
 int erofs_build_shared_xattrs_from_path(const char *path);
 
diff --git a/lib/config.c b/lib/config.c
index cbbecce..da0c260 100644
--- a/lib/config.c
+++ b/lib/config.c
@@ -36,6 +36,48 @@ void erofs_show_config(void)
 
 void erofs_exit_configure(void)
 {
+#ifdef HAVE_LIBSELINUX
+	if (cfg.sehnd)
+		selabel_close(cfg.sehnd);
+#endif
+}
+
+static unsigned int fullpath_prefix;	/* root directory prefix length */
+
+void erofs_set_fs_root(const char *rootdir)
+{
+	fullpath_prefix = strlen(rootdir);
+}
+
+const char *erofs_fspath(const char *fullpath)
+{
+	const char *s = fullpath + fullpath_prefix;
+
+	while (*s == '/')
+		s++;
+	return s;
+}
+
+#ifdef HAVE_LIBSELINUX
+int erofs_selabel_open(const char *file_contexts)
+{
+	struct selinux_opt seopts[] = {
+		{ .type = SELABEL_OPT_PATH, .value = file_contexts }
+	};
+
+	if (cfg.sehnd) {
+		erofs_info("ignore duplicated file contexts \"%s\"",
+			   file_contexts);
+		return -EBUSY;
+	}
 
+	cfg.sehnd = selabel_open(SELABEL_CTX_FILE, seopts, 1);
+	if (!cfg.sehnd) {
+		erofs_err("failed to open file contexts \"%s\"",
+			  file_contexts);
+		return -EINVAL;
+	}
+	return 0;
 }
+#endif
 
diff --git a/lib/exclude.c b/lib/exclude.c
index 47b467d..73b3720 100644
--- a/lib/exclude.c
+++ b/lib/exclude.c
@@ -17,13 +17,6 @@
 static LIST_HEAD(exclude_head);
 static LIST_HEAD(regex_exclude_head);
 
-static unsigned int rpathlen;		/* root directory prefix length */
-
-void erofs_exclude_set_root(const char *rootdir)
-{
-	rpathlen = strlen(rootdir);
-}
-
 static void dump_regerror(int errcode, const char *s, const regex_t *preg)
 {
 	char str[512];
@@ -120,10 +113,7 @@ struct erofs_exclude_rule *erofs_is_exclude_path(const char *dir,
 		s = buf;
 	}
 
-	s += rpathlen;
-	while (*s == '/')
-		s++;
-
+	s = erofs_fspath(s);
 	list_for_each_entry(r, &exclude_head, list) {
 		if (!strcmp(r->pattern, s))
 			return r;
diff --git a/lib/inode.c b/lib/inode.c
index 7114023..dff5f2c 100644
--- a/lib/inode.c
+++ b/lib/inode.c
@@ -827,7 +827,8 @@ struct erofs_inode *erofs_mkfs_build_tree(struct erofs_inode *dir)
 	struct dirent *dp;
 	struct erofs_dentry *d;
 
-	ret = erofs_prepare_xattr_ibody(dir->i_srcpath, &dir->i_xattrs);
+	ret = erofs_prepare_xattr_ibody(dir->i_srcpath,
+					dir->i_mode, &dir->i_xattrs);
 	if (ret < 0)
 		return ERR_PTR(ret);
 	dir->xattr_isize = ret;
diff --git a/lib/xattr.c b/lib/xattr.c
index 1564016..543ed71 100644
--- a/lib/xattr.c
+++ b/lib/xattr.c
@@ -186,6 +186,49 @@ static struct xattr_item *parse_one_xattr(const char *path, const char *key,
 	return get_xattritem(prefix, kvbuf, len);
 }
 
+static struct xattr_item *erofs_get_selabel_xattr(const char *srcpath,
+						  mode_t mode)
+{
+#ifdef HAVE_LIBSELINUX
+	if (cfg.sehnd) {
+		char *secontext;
+		int ret;
+		unsigned int len[2];
+		char *kvbuf, *fspath;
+
+		ret = asprintf(&fspath, "/%s", erofs_fspath(srcpath));
+		if (ret <= 0)
+			return ERR_PTR(-ENOMEM);
+
+		ret = selabel_lookup(cfg.sehnd, &secontext, fspath, mode);
+		free(fspath);
+
+		if (ret) {
+			ret = -errno;
+			if (ret != -ENOENT) {
+				erofs_err("failed to lookup selabel for %s: %s",
+					  srcpath, erofs_strerror(ret));
+				return ERR_PTR(ret);
+			}
+			/* secontext = "u:object_r:unlabeled:s0"; */
+			return NULL;
+		}
+
+		len[0] = sizeof("selinux") - 1;
+		len[1] = strlen(secontext);
+		kvbuf = malloc(len[0] + len[1] + 1);
+		if (!kvbuf) {
+			free(secontext);
+			return ERR_PTR(-ENOMEM);
+		}
+		sprintf(kvbuf, "selinux%s", secontext);
+		free(secontext);
+		return get_xattritem(EROFS_XATTR_INDEX_SECURITY, kvbuf, len);
+	}
+#endif
+	return NULL;
+}
+
 static int inode_xattr_add(struct list_head *hlist, struct xattr_item *item)
 {
 	struct inode_xattr_node *node = malloc(sizeof(*node));
@@ -215,19 +258,48 @@ static int shared_xattr_add(struct xattr_item *item)
 	return ++shared_xattrs_count;
 }
 
-static int read_xattrs_from_file(const char *path, struct list_head *ixattrs)
+static int erofs_xattr_add(struct list_head *ixattrs, struct xattr_item *item)
+{
+	if (ixattrs)
+		return inode_xattr_add(ixattrs, item);
+
+	if (item->count == cfg.c_inline_xattr_tolerance + 1) {
+		int ret = shared_xattr_add(item);
+
+		if (ret < 0)
+			return ret;
+	}
+	return 0;
+}
+
+static bool erofs_is_skipped_xattr(const char *key)
+{
+#ifdef HAVE_LIBSELINUX
+	/* if sehnd is valid, selabels will be overridden */
+	if (cfg.sehnd && !strcmp(key, XATTR_SECURITY_PREFIX "selinux"))
+		return true;
+#endif
+	return false;
+}
+
+static int read_xattrs_from_file(const char *path, mode_t mode,
+				 struct list_head *ixattrs)
 {
-	int ret = 0;
-	char *keylst, *key;
 	ssize_t kllen = llistxattr(path, NULL, 0);
+	int ret;
+	char *keylst, *key, *klend;
+	unsigned int keylen;
+	struct xattr_item *item;
 
 	if (kllen < 0 && errno != ENODATA) {
 		erofs_err("llistxattr to get the size of names for %s failed",
 			  path);
 		return -errno;
 	}
+
+	ret = 0;
 	if (kllen <= 1)
-		return 0;
+		goto out;
 
 	keylst = malloc(kllen);
 	if (!keylst)
@@ -246,36 +318,42 @@ static int read_xattrs_from_file(const char *path, struct list_head *ixattrs)
 	 * attribute keys. Use the remaining buffer length to determine
 	 * the end of the list.
 	 */
-	key = keylst;
-	while (kllen > 0) {
-		unsigned int keylen = strlen(key);
-		struct xattr_item *item = parse_one_xattr(path, key, keylen);
+	klend = keylst + kllen;
+	ret = 0;
+
+	for (key = keylst; key != klend; key += keylen + 1) {
+		keylen = strlen(key);
+		if (erofs_is_skipped_xattr(key))
+			continue;
 
+		item = parse_one_xattr(path, key, keylen);
 		if (IS_ERR(item)) {
 			ret = PTR_ERR(item);
 			goto err;
 		}
 
-		if (ixattrs) {
-			ret = inode_xattr_add(ixattrs, item);
-			if (ret < 0)
-				goto err;
-		} else if (item->count == cfg.c_inline_xattr_tolerance + 1) {
-			ret = shared_xattr_add(item);
-			if (ret < 0)
-				goto err;
-			ret = 0;
-		}
-		kllen -= keylen + 1;
-		key += keylen + 1;
+		ret = erofs_xattr_add(ixattrs, item);
+		if (ret < 0)
+			goto err;
 	}
-err:
 	free(keylst);
+
+out:
+	/* if some selabel is avilable, need to add right now */
+	item = erofs_get_selabel_xattr(path, mode);
+	if (IS_ERR(item))
+		return PTR_ERR(item);
+	if (item)
+		ret = erofs_xattr_add(ixattrs, item);
 	return ret;
 
+err:
+	free(keylst);
+	return ret;
 }
 
-int erofs_prepare_xattr_ibody(const char *path, struct list_head *ixattrs)
+int erofs_prepare_xattr_ibody(const char *path, mode_t mode,
+			      struct list_head *ixattrs)
 {
 	int ret;
 	struct inode_xattr_node *node;
@@ -284,7 +362,7 @@ int erofs_prepare_xattr_ibody(const char *path, struct list_head *ixattrs)
 	if (cfg.c_inline_xattr_tolerance < 0)
 		return 0;
 
-	ret = read_xattrs_from_file(path, ixattrs);
+	ret = read_xattrs_from_file(path, mode, ixattrs);
 	if (ret < 0)
 		return ret;
 
@@ -345,16 +423,16 @@ static int erofs_count_all_xattrs_from_path(const char *path)
 			goto fail;
 		}
 
-		ret = read_xattrs_from_file(buf, NULL);
-		if (ret)
-			goto fail;
-
 		ret = lstat64(buf, &st);
 		if (ret) {
 			ret = -errno;
 			goto fail;
 		}
 
+		ret = read_xattrs_from_file(buf, st.st_mode, NULL);
+		if (ret)
+			goto fail;
+
 		if (!S_ISDIR(st.st_mode))
 			continue;
 
diff --git a/man/mkfs.erofs.1 b/man/mkfs.erofs.1
index d47207a..891c5a8 100644
--- a/man/mkfs.erofs.1
+++ b/man/mkfs.erofs.1
@@ -60,6 +60,9 @@ You may give multiple `--exclude-path' options.
 Ignore files that match the given regular expression.
 You may give multiple `--exclude-regex` options.
 .TP
+.BI "\-\-file-contexts=" file
+Specify a \fIfile_contexts\fR file to setup / override selinux labels.
+.TP
 .B \-\-help
 Display this help and exit.
 .SH AUTHOR
diff --git a/mkfs/Makefile.am b/mkfs/Makefile.am
index 9ce06d6..97ba148 100644
--- a/mkfs/Makefile.am
+++ b/mkfs/Makefile.am
@@ -3,8 +3,8 @@
 
 AUTOMAKE_OPTIONS = foreign
 bin_PROGRAMS     = mkfs.erofs
-AM_CPPFLAGS = ${libuuid_CFLAGS}
+AM_CPPFLAGS = ${libuuid_CFLAGS} ${libselinux_CFLAGS}
 mkfs_erofs_SOURCES = main.c
 mkfs_erofs_CFLAGS = -Wall -Werror -I$(top_srcdir)/include
-mkfs_erofs_LDADD = $(top_builddir)/lib/liberofs.la ${libuuid_LIBS}
+mkfs_erofs_LDADD = $(top_builddir)/lib/liberofs.la ${libuuid_LIBS} ${libselinux_LIBS}
 
diff --git a/mkfs/main.c b/mkfs/main.c
index 940d4e8..94bf1e6 100644
--- a/mkfs/main.c
+++ b/mkfs/main.c
@@ -33,6 +33,9 @@ static struct option long_options[] = {
 	{"help", no_argument, 0, 1},
 	{"exclude-path", required_argument, NULL, 2},
 	{"exclude-regex", required_argument, NULL, 3},
+#ifdef HAVE_LIBSELINUX
+	{"file-contexts", required_argument, NULL, 4},
+#endif
 	{0, 0, 0, 0},
 };
 
@@ -60,6 +63,9 @@ static void usage(void)
 	      " -T#               set a fixed UNIX timestamp # to all files\n"
 	      " --exclude-path=X  avoid including file X (X = exact literal path)\n"
 	      " --exclude-regex=X avoid including files that match X (X = regular expression)\n"
+#ifdef HAVE_LIBSELINUX
+	      " --file-contexts=X specify a file contexts file to setup selinux labels\n"
+#endif
 	      " --help            display this help and exit\n"
 	      "\nAvailable compressors are: ", stderr);
 	print_available_compressors(stderr, ", ");
@@ -198,6 +204,13 @@ static int mkfs_parse_options_cfg(int argc, char *argv[])
 				return opt;
 			}
 			break;
+
+		case 4:
+			opt = erofs_selabel_open(optarg);
+			if (opt && opt != -EBUSY)
+				return opt;
+			break;
+
 		case 1:
 			usage();
 			exit(0);
@@ -392,7 +405,7 @@ int main(int argc, char **argv)
 	}
 
 	erofs_show_config();
-	erofs_exclude_set_root(cfg.c_src_path);
+	erofs_set_fs_root(cfg.c_src_path);
 
 	sb_bh = erofs_buffer_init();
 	if (IS_ERR(sb_bh)) {
-- 
2.24.0

