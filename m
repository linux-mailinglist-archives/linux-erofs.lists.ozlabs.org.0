Return-Path: <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>
X-Original-To: lists+linux-erofs@lfdr.de
Delivered-To: lists+linux-erofs@lfdr.de
Received: from lists.ozlabs.org (lists.ozlabs.org [203.11.71.2])
	by mail.lfdr.de (Postfix) with ESMTPS id CF68B1509E5
	for <lists+linux-erofs@lfdr.de>; Mon,  3 Feb 2020 16:38:55 +0100 (CET)
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2401:3900:2:1::3])
	by lists.ozlabs.org (Postfix) with ESMTP id 48BBnS5GcJzDqN9
	for <lists+linux-erofs@lfdr.de>; Tue,  4 Feb 2020 02:38:52 +1100 (AEDT)
X-Original-To: linux-erofs@lists.ozlabs.org
Delivered-To: linux-erofs@lists.ozlabs.org
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized)
 smtp.mailfrom=sina.com (client-ip=202.108.3.21;
 helo=r3-21.sinamail.sina.com.cn; envelope-from=blucerlee@sina.com;
 receiver=<UNKNOWN>)
Authentication-Results: lists.ozlabs.org;
 dmarc=none (p=none dis=none) header.from=sina.com
Received: from r3-21.sinamail.sina.com.cn (r3-21.sinamail.sina.com.cn
 [202.108.3.21])
 by lists.ozlabs.org (Postfix) with SMTP id 48BBnF3h6NzDqHf
 for <linux-erofs@lists.ozlabs.org>; Tue,  4 Feb 2020 02:38:24 +1100 (AEDT)
Received: from unknown (HELO localhost)([112.65.61.167]) by sina.com with ESMTP
 id 5E383E670002A396; Mon, 3 Feb 2020 23:38:17 +0800 (CST)
X-Sender: blucerlee@sina.com
X-Auth-ID: blucerlee@sina.com
X-SMAIL-MID: 407313628748
From: Li Guifu <blucerlee@sina.com>
To: linux-erofs@lists.ozlabs.org
Subject: [PATCH v2] erofs-utils: introduce exclude dirs and files
Date: Mon,  3 Feb 2020 23:38:11 +0800
Message-Id: <20200203153811.5239-1-blucerlee@sina.com>
X-Mailer: git-send-email 2.17.1
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
Sender: "Linux-erofs"
 <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>


From: Li Guifu <blucer.lee@foxmail.com>

Add excluded file feature "--exclude-path=", which can be used
to build EROFS image without some user specific files or dirs.
Such multiple files can be seperated by ','.

Signed-off-by: Li Guifu <blucer.lee@foxmail.com>
---
 include/erofs/exclude.h |  28 ++++++++
 lib/Makefile.am         |   2 +-
 lib/exclude.c           | 149 ++++++++++++++++++++++++++++++++++++++++
 lib/inode.c             |  10 +++
 mkfs/main.c             |  11 +++
 5 files changed, 199 insertions(+), 1 deletion(-)
 create mode 100644 include/erofs/exclude.h
 create mode 100644 lib/exclude.c

diff --git a/include/erofs/exclude.h b/include/erofs/exclude.h
new file mode 100644
index 0000000..3581046
--- /dev/null
+++ b/include/erofs/exclude.h
@@ -0,0 +1,28 @@
+// SPDX-License-Identifier: GPL-2.0+
+/*
+ * exclude.h
+ * Created by Li Guifu <blucer.lee@foxmail.com>
+ */
+
+#ifndef __EROFS_EXCLUDE_H
+#define __EROFS_EXCLUDE_H
+
+struct exclude_rule {
+	struct list_head list;
+	struct list_head hlist;
+	char *pattern;
+};
+
+void erofs_init_exclude_rules(void);
+void erofs_free_exclude_rules(void);
+int erofs_parse_exclude_path(const char *args);
+struct exclude_rule *erofs_pattern_matched(const char *s);
+struct exclude_rule *erofs_entry_matched(struct exclude_rule *e,
+					 const char *s, unsigned int len);
+
+static inline int erofs_is_pattern_end(struct exclude_rule *e)
+{
+	return list_empty(&e->hlist);
+}
+#endif
+
diff --git a/lib/Makefile.am b/lib/Makefile.am
index 1ff81f9..e4b51e6 100644
--- a/lib/Makefile.am
+++ b/lib/Makefile.am
@@ -3,7 +3,7 @@
 
 noinst_LTLIBRARIES = liberofs.la
 liberofs_la_SOURCES = config.c io.c cache.c inode.c xattr.c \
-		      compress.c compressor.c
+		      compress.c compressor.c exclude.c
 liberofs_la_CFLAGS = -Wall -Werror -I$(top_srcdir)/include
 if ENABLE_LZ4
 liberofs_la_CFLAGS += ${LZ4_CFLAGS}
diff --git a/lib/exclude.c b/lib/exclude.c
new file mode 100644
index 0000000..1c65fb9
--- /dev/null
+++ b/lib/exclude.c
@@ -0,0 +1,149 @@
+// SPDX-License-Identifier: GPL-2.0+
+/*
+ * exclude.c
+ * Created by Li Guifu <blucer.lee@foxmail.com>
+ */
+
+#include <string.h>
+#include <errno.h>
+#include <stdlib.h>
+#include "erofs/err.h"
+#include "erofs/defs.h"
+#include "erofs/list.h"
+#include "erofs/print.h"
+#include "erofs/exclude.h"
+
+static struct exclude_rule exclude_rules;
+
+static struct exclude_rule *new_rule(const char *s, unsigned int len)
+{
+	struct exclude_rule *e = malloc(sizeof(struct exclude_rule));
+
+	if (!e)
+		return ERR_PTR(-ENOMEM);
+
+	e->pattern = strndup(s, len);
+	if (!e->pattern)
+		goto err_strdup;
+
+	init_list_head(&e->hlist);
+	init_list_head(&e->list);
+
+	return e;
+
+err_strdup:
+	free(e);
+	return ERR_PTR(-ENOMEM);
+}
+
+struct exclude_rule *erofs_entry_matched(struct exclude_rule *e,
+					 const char *s, unsigned int len)
+{
+	struct exclude_rule *pos;
+
+	while (*s == '/') {
+		s++;
+		len--;
+	}
+	list_for_each_entry(pos, &e->hlist, list) {
+		unsigned int l = strlen(pos->pattern);
+
+		if (l == len && !strcmp(pos->pattern, s))
+			return pos;
+	}
+
+	return ERR_PTR(-ENOMEM);
+}
+
+static int add_exclude_rules(struct exclude_rule *e, const char *s)
+{
+	const char *ptr;
+	struct exclude_rule *erule;
+
+	while (*s == '/')
+		s++;
+	ptr = s;
+
+forward:
+	while(*ptr != '/' && *ptr != '\0')
+		ptr++;
+
+	erule = erofs_entry_matched(e, s, ptr - s);
+	if (IS_ERR(erule)) {
+		struct exclude_rule *r = new_rule(s, ptr - s);
+
+		if (IS_ERR(r))
+			return PTR_ERR(r);
+		list_add_tail(&r->list, &e->hlist);
+		erule = r;
+	}
+	e = erule;
+
+	if (*ptr++ != '\0') {
+		s = ptr;
+		goto forward;
+	}
+
+	return 0;
+}
+
+static void free_exclude_rules(struct list_head *h)
+{
+	struct exclude_rule *e, *n;
+
+	list_for_each_entry_safe(e, n, h, list) {
+		list_del(&e->list);
+		free_exclude_rules(&e->hlist);
+		free(e->pattern);
+		free(e);
+	}
+}
+void erofs_init_exclude_rules(void)
+{
+	init_list_head(&exclude_rules.list);
+	init_list_head(&exclude_rules.hlist);
+	exclude_rules.pattern = "/";
+}
+
+void erofs_free_exclude_rules(void)
+{
+	free_exclude_rules(&exclude_rules.hlist);
+}
+
+int erofs_parse_exclude_path(const char *args)
+{
+	const char *str, *ptr = args;
+	const char sep = ',';
+
+forward:
+	while(*ptr != sep && *ptr != '\0')
+		ptr++;
+
+	str = strndup(args, ptr - args);
+	if (!str)
+		goto err_free_paths;
+
+	if (add_exclude_rules(&exclude_rules, str))
+		goto err_free_paths;
+
+	if (*ptr++ != '\0') {
+		args = ptr;
+		goto forward;
+	}
+
+	return 0;
+
+err_free_paths:
+	erofs_free_exclude_rules();
+	return -ENOMEM;
+}
+
+struct exclude_rule *erofs_pattern_matched(const char *s)
+{
+	unsigned int len = strlen(s);
+
+	if (!len)
+		return &exclude_rules;
+
+	return erofs_entry_matched(&exclude_rules, s, len);
+}
diff --git a/lib/inode.c b/lib/inode.c
index bd0652b..567f1b8 100644
--- a/lib/inode.c
+++ b/lib/inode.c
@@ -20,6 +20,7 @@
 #include "erofs/io.h"
 #include "erofs/compress.h"
 #include "erofs/xattr.h"
+#include "erofs/exclude.h"
 
 struct erofs_sb_info sbi;
 
@@ -825,6 +826,7 @@ struct erofs_inode *erofs_mkfs_build_tree(struct erofs_inode *dir)
 	DIR *_dir;
 	struct dirent *dp;
 	struct erofs_dentry *d;
+	struct exclude_rule *e;
 
 	ret = erofs_prepare_xattr_ibody(dir->i_srcpath, &dir->i_xattrs);
 	if (ret < 0)
@@ -863,6 +865,7 @@ struct erofs_inode *erofs_mkfs_build_tree(struct erofs_inode *dir)
 		return ERR_PTR(-errno);
 	}
 
+	e = erofs_pattern_matched(dir->i_srcpath + strlen(cfg.c_src_path));
 	while (1) {
 		/*
 		 * set errno to 0 before calling readdir() in order to
@@ -876,7 +879,14 @@ struct erofs_inode *erofs_mkfs_build_tree(struct erofs_inode *dir)
 		if (is_dot_dotdot(dp->d_name) ||
 		    !strncmp(dp->d_name, "lost+found", strlen("lost+found")))
 			continue;
+		if (!IS_ERR(e)) {
+			struct exclude_rule *le;
 
+			le = erofs_entry_matched(e, dp->d_name,
+						 strlen(dp->d_name));
+			if (!IS_ERR(le) && erofs_is_pattern_end(le))
+				continue;
+		}
 		d = erofs_d_alloc(dir, dp->d_name);
 		if (IS_ERR(d)) {
 			ret = PTR_ERR(d);
diff --git a/mkfs/main.c b/mkfs/main.c
index 817a6c1..6f32c60 100644
--- a/mkfs/main.c
+++ b/mkfs/main.c
@@ -21,6 +21,7 @@
 #include "erofs/io.h"
 #include "erofs/compress.h"
 #include "erofs/xattr.h"
+#include "erofs/exclude.h"
 
 #ifdef HAVE_LIBUUID
 #include <uuid/uuid.h>
@@ -30,6 +31,7 @@
 
 static struct option long_options[] = {
 	{"help", no_argument, 0, 1},
+	{"exclude-path", required_argument, NULL, 2},
 	{0, 0, 0, 0},
 };
 
@@ -178,6 +180,13 @@ static int mkfs_parse_options_cfg(int argc, char *argv[])
 			}
 			break;
 
+		case 2:
+			if (erofs_parse_exclude_path(optarg)) {
+				usage();
+				exit(0);
+			}
+			break;
+
 		case 1:
 			usage();
 			exit(0);
@@ -334,6 +343,7 @@ int main(int argc, char **argv)
 	struct timeval t;
 
 	erofs_init_configure();
+	erofs_init_exclude_rules();
 	fprintf(stderr, "%s %s\n", basename(argv[0]), cfg.c_version);
 
 	cfg.c_legacy_compress = false;
@@ -429,6 +439,7 @@ exit:
 	z_erofs_compress_exit();
 	dev_close();
 	erofs_exit_configure();
+	erofs_free_exclude_rules();
 
 	if (err) {
 		erofs_err("\tCould not format the device : %s\n",
-- 
2.17.1


