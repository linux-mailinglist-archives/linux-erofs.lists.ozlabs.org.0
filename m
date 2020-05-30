Return-Path: <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>
X-Original-To: lists+linux-erofs@lfdr.de
Delivered-To: lists+linux-erofs@lfdr.de
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2401:3900:2:1::3])
	by mail.lfdr.de (Postfix) with ESMTPS id E18CE1E9285
	for <lists+linux-erofs@lfdr.de>; Sat, 30 May 2020 18:12:47 +0200 (CEST)
Received: from bilbo.ozlabs.org (lists.ozlabs.org [IPv6:2401:3900:2:1::3])
	by lists.ozlabs.org (Postfix) with ESMTP id 49Z60X55gCzDqWG
	for <lists+linux-erofs@lfdr.de>; Sun, 31 May 2020 02:12:44 +1000 (AEST)
X-Original-To: linux-erofs@lists.ozlabs.org
Delivered-To: linux-erofs@lists.ozlabs.org
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized)
 smtp.mailfrom=redhat.com (client-ip=207.211.31.120;
 helo=us-smtp-1.mimecast.com; envelope-from=hsiangkao@redhat.com;
 receiver=<UNKNOWN>)
Authentication-Results: lists.ozlabs.org;
 dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: lists.ozlabs.org; dkim=pass (1024-bit key;
 unprotected) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256
 header.s=mimecast20190719 header.b=TawwtZhY; 
 dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com
 header.a=rsa-sha256 header.s=mimecast20190719 header.b=TawwtZhY; 
 dkim-atps=neutral
Received: from us-smtp-1.mimecast.com (us-smtp-delivery-1.mimecast.com
 [207.211.31.120])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 49Z60M3DcwzDqZq
 for <linux-erofs@lists.ozlabs.org>; Sun, 31 May 2020 02:12:32 +1000 (AEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1590855148;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:content-type:content-type;
 bh=1oD5iU/onAMxXpv/Rz+Yeb4Y/ORFriBHgI7PUE+k5yg=;
 b=TawwtZhYUxPAVgxcZrpTPPAio64+gi6HAWFbVISNuHO50bMVvt/8WlM40/luqg2FhCU0DB
 xytCCcWeSHAPefXW8fLzjgb4Us5A0sDKjWep0SXDaHC91XQzEVkknkoMuWPb2tOhnBJuZI
 fQgQeiyz+rW3+nVCsti3/BfAIiRoE2Y=
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1590855148;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:content-type:content-type;
 bh=1oD5iU/onAMxXpv/Rz+Yeb4Y/ORFriBHgI7PUE+k5yg=;
 b=TawwtZhYUxPAVgxcZrpTPPAio64+gi6HAWFbVISNuHO50bMVvt/8WlM40/luqg2FhCU0DB
 xytCCcWeSHAPefXW8fLzjgb4Us5A0sDKjWep0SXDaHC91XQzEVkknkoMuWPb2tOhnBJuZI
 fQgQeiyz+rW3+nVCsti3/BfAIiRoE2Y=
Received: from mail-pg1-f200.google.com (mail-pg1-f200.google.com
 [209.85.215.200]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-99-EGX7FKWXN2GCgBoD2jGPeQ-1; Sat, 30 May 2020 12:12:11 -0400
X-MC-Unique: EGX7FKWXN2GCgBoD2jGPeQ-1
Received: by mail-pg1-f200.google.com with SMTP id q5so1985719pgt.16
 for <linux-erofs@lists.ozlabs.org>; Sat, 30 May 2020 09:12:11 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id;
 bh=1oD5iU/onAMxXpv/Rz+Yeb4Y/ORFriBHgI7PUE+k5yg=;
 b=DjjNG7Sl4VJEaqFEh857QUZsIDIPTrwW5iqWzbB4lrOLxSEh/Awt9S2u9mbE0O6gRn
 w4bxIn7up51Ql5NuHHwTpS/y4TGOHBAf1bRvckx559+COMI0FhNUXKLTqXcyoNrrBbs7
 LoMVQr/4JN6rnSggbgK1N/gu7tcI7GLZx2JboCQYLaTt9n1uBOnXQ15liZEdcO0rKTvc
 tAzYyDrbUgpSWSCZGOFI8PVl+SQ/pvQGpG7T9vJcVfediCXDiVpBBtznfRlQS1O//Ckc
 JlxN3d7joob3u10KAdFXrwjZqLFyGIcCeJVy1E8jLCyX1wN2yUoC1xWjVLd9MEkK1zVY
 zhdQ==
X-Gm-Message-State: AOAM532NskH3hNZbJHf+N4DliWkLzZudZaVzEZ+41C08bdDuXB+uYKug
 gB2TlbUl6pTB5zmRVaTfPNWZ9YW7lrhRRWrfGuPb5RsstB9NCheyDQqY8yKvG0vVoSrtZNPK+jE
 pLjlL6jvdKN72ct06RRxLIBNo
X-Received: by 2002:a62:dd03:: with SMTP id w3mr13242304pff.76.1590855130499; 
 Sat, 30 May 2020 09:12:10 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJyhUuRJufX+9U9Z3D1UOhPxAuM7mLiTyWMs6lo13pgRWAXUAfvhCu2DHnHPg9DXYvl2qHtVzQ==
X-Received: by 2002:a62:dd03:: with SMTP id w3mr13242275pff.76.1590855130102; 
 Sat, 30 May 2020 09:12:10 -0700 (PDT)
Received: from xiangao.remote.csb ([209.132.188.80])
 by smtp.gmail.com with ESMTPSA id h35sm2576498pje.29.2020.05.30.09.12.06
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sat, 30 May 2020 09:12:09 -0700 (PDT)
From: Gao Xiang <hsiangkao@redhat.com>
To: linux-erofs@lists.ozlabs.org
Subject: [PATCH] erofs-utils: support selinux file contexts
Date: Sun, 31 May 2020 00:11:27 +0800
Message-Id: <20200530161127.16750-1-hsiangkao@redhat.com>
X-Mailer: git-send-email 2.18.1
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=US-ASCII
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
Cc: Shung Wang <waterbird0806@gmail.com>
Errors-To: linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org
Sender: "Linux-erofs"
 <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>

Add --file-contexts flag that allows passing a selinux
file_context file to setup file selabels.

Signed-off-by: Gao Xiang <hsiangkao@redhat.com>
---
prelimiary version.

 configure.ac           |  27 +++++++++
 include/erofs/config.h |  11 ++++
 include/erofs/xattr.h  |   3 +-
 lib/config.c           |  19 +++++++
 lib/exclude.c          |  12 +---
 lib/inode.c            |   3 +-
 lib/xattr.c            | 122 ++++++++++++++++++++++++++++++++---------
 man/mkfs.erofs.1       |   3 +
 mkfs/Makefile.am       |   4 +-
 mkfs/main.c            |  29 +++++++++-
 10 files changed, 190 insertions(+), 43 deletions(-)

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
index 2be05ee..825abaf 100644
--- a/include/erofs/config.h
+++ b/include/erofs/config.h
@@ -11,6 +11,11 @@
 
 #include "defs.h"
 
+#ifdef HAVE_LIBSELINUX
+#include <selinux/selinux.h>
+#include <selinux/label.h>
+#endif
+
 enum {
 	FORCE_INODE_COMPACT = 1,
 	FORCE_INODE_EXTENDED,
@@ -22,6 +27,9 @@ struct erofs_configure {
 	bool c_dry_run;
 	bool c_legacy_compress;
 
+#ifdef HAVE_LIBSELINUX
+	struct selabel_handle *sehnd;
+#endif
 	/* related arguments for mkfs.erofs */
 	char *c_img_path;
 	char *c_src_path;
@@ -39,5 +47,8 @@ void erofs_init_configure(void);
 void erofs_show_config(void);
 void erofs_exit_configure(void);
 
+void erofs_set_fs_root(const char *rootdir);
+const char *erofs_fspath(const char *fullpath);
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
index cbbecce..ae21252 100644
--- a/lib/config.c
+++ b/lib/config.c
@@ -36,6 +36,25 @@ void erofs_show_config(void)
 
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
 
+	while (*s == '/')
+		s++;
+	return s;
 }
 
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
index 1564016..698c237 100644
--- a/lib/xattr.c
+++ b/lib/xattr.c
@@ -186,6 +186,43 @@ static struct xattr_item *parse_one_xattr(const char *path, const char *key,
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
+			erofs_err("cannot lookup selabel for %s", srcpath);
+			/* secontext = strdup("u:object_r:unlabeled:s0"); */
+			return ERR_PTR(ret);
+		}
+
+		len[0] = sizeof("selinux") - 1;
+		len[1] = strlen(secontext);
+		kvbuf = malloc(len[0] + len[1] + 1);
+		if (!kvbuf)
+			return ERR_PTR(-ENOMEM);
+
+		sprintf(kvbuf, "selinux%s", secontext);
+		return get_xattritem(EROFS_XATTR_INDEX_SECURITY, kvbuf, len);
+	}
+#endif
+	return NULL;
+}
+
 static int inode_xattr_add(struct list_head *hlist, struct xattr_item *item)
 {
 	struct inode_xattr_node *node = malloc(sizeof(*node));
@@ -215,19 +252,48 @@ static int shared_xattr_add(struct xattr_item *item)
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
@@ -246,36 +312,38 @@ static int read_xattrs_from_file(const char *path, struct list_head *ixattrs)
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
+out:
+	item = erofs_get_selabel_xattr(path, mode);
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
@@ -284,7 +352,7 @@ int erofs_prepare_xattr_ibody(const char *path, struct list_head *ixattrs)
 	if (cfg.c_inline_xattr_tolerance < 0)
 		return 0;
 
-	ret = read_xattrs_from_file(path, ixattrs);
+	ret = read_xattrs_from_file(path, mode, ixattrs);
 	if (ret < 0)
 		return ret;
 
@@ -345,16 +413,16 @@ static int erofs_count_all_xattrs_from_path(const char *path)
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
index 940d4e8..7de929f 100644
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
@@ -198,6 +204,27 @@ static int mkfs_parse_options_cfg(int argc, char *argv[])
 				return opt;
 			}
 			break;
+
+#ifdef HAVE_LIBSELINUX
+		case 4: {
+			struct selinux_opt seopts[] = {
+				{ .type = SELABEL_OPT_PATH, .value = optarg }
+			};
+
+			if (cfg.sehnd) {
+				erofs_info("ignore duplicated file contexts \"%s\"",
+					   optarg);
+				break;
+			}
+			cfg.sehnd = selabel_open(SELABEL_CTX_FILE, seopts, 1);
+			if (!cfg.sehnd) {
+				erofs_err("failed to open file contexts \"%s\"",
+					  optarg);
+				return -EINVAL;
+			}
+			break;
+		}
+#endif
 		case 1:
 			usage();
 			exit(0);
@@ -392,7 +419,7 @@ int main(int argc, char **argv)
 	}
 
 	erofs_show_config();
-	erofs_exclude_set_root(cfg.c_src_path);
+	erofs_set_fs_root(cfg.c_src_path);
 
 	sb_bh = erofs_buffer_init();
 	if (IS_ERR(sb_bh)) {
-- 
2.18.1

