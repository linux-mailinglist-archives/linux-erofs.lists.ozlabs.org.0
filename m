Return-Path: <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>
X-Original-To: lists+linux-erofs@lfdr.de
Delivered-To: lists+linux-erofs@lfdr.de
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2404:9400:2:0:216:3eff:fee1:b9f1])
	by mail.lfdr.de (Postfix) with ESMTPS id 44A419347AB
	for <lists+linux-erofs@lfdr.de>; Thu, 18 Jul 2024 07:40:55 +0200 (CEST)
Authentication-Results: lists.ozlabs.org;
	dkim=pass (1024-bit key; unprotected) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.a=rsa-sha256 header.s=default header.b=U1AKJtyg;
	dkim-atps=neutral
Received: from boromir.ozlabs.org (localhost [IPv6:::1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4WPhVY1Nvhz3dK4
	for <lists+linux-erofs@lfdr.de>; Thu, 18 Jul 2024 15:40:53 +1000 (AEST)
X-Original-To: linux-erofs@lists.ozlabs.org
Delivered-To: linux-erofs@lists.ozlabs.org
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (1024-bit key; unprotected) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.a=rsa-sha256 header.s=default header.b=U1AKJtyg;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=linux.alibaba.com (client-ip=115.124.30.97; helo=out30-97.freemail.mail.aliyun.com; envelope-from=hongzhen@linux.alibaba.com; receiver=lists.ozlabs.org)
Received: from out30-97.freemail.mail.aliyun.com (out30-97.freemail.mail.aliyun.com [115.124.30.97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4WPhVC3JnTz3bc2
	for <linux-erofs@lists.ozlabs.org>; Thu, 18 Jul 2024 15:40:35 +1000 (AEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=linux.alibaba.com; s=default;
	t=1721281231; h=From:To:Subject:Date:Message-ID:MIME-Version;
	bh=s54/hRTPFtXFSAOIYieJ65JuagOxISkaCa98mc0eapU=;
	b=U1AKJtygVirC19i3v7J+kU0RRKHX7nWeTiBGsCSC0heF1EXFMllgIpLMudKpbnIfrVtcTMSDSs+CbdFJKNJX72JY3n0UzOkS8Rpoc0LQTi2IOtJL/WZToD9MLlB2x1wEQ3WVekIfv3aH1+2l51yZX7c4H+QpVOGrVnFpNYVuLAE=
X-Alimail-AntiSpam: AC=PASS;BC=-1|-1;BR=01201311R361e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=maildocker-contentspam033032014031;MF=hongzhen@linux.alibaba.com;NM=1;PH=DS;RN=2;SR=0;TI=SMTPD_---0WAnE6dp_1721281230;
Received: from localhost(mailfrom:hongzhen@linux.alibaba.com fp:SMTPD_---0WAnE6dp_1721281230)
          by smtp.aliyun-inc.com;
          Thu, 18 Jul 2024 13:40:30 +0800
From: Hongzhen Luo <hongzhen@linux.alibaba.com>
To: linux-erofs@lists.ozlabs.org
Subject: [PATCH 3/3] erofs-utils: lib: enhance erofs_rebuild_get_dentry with bloom filter
Date: Thu, 18 Jul 2024 13:40:25 +0800
Message-ID: <20240718054025.427439-3-hongzhen@linux.alibaba.com>
X-Mailer: git-send-email 2.43.5
In-Reply-To: <20240718054025.427439-1-hongzhen@linux.alibaba.com>
References: <20240718054025.427439-1-hongzhen@linux.alibaba.com>
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

Add a bloom filter to exclude entries that are not in `pwd->i_subdirs`,
thereby improving the performance of `erofs_rebuild_get_dentry`. Below
are the results for different # of files in the same directory:

+---------+--------------------+
| # files | time reduction (%) |
+---------+--------------------+
|   1e4   |         55%        |
+---------+--------------------+
|   1e5   |         98%        |
+---------+--------------------+
|   2e5   |         98%        |
+---------+--------------------+
|   3e5   |         99%        |
+---------+--------------------+

Signed-off-by: Hongzhen Luo <hongzhen@linux.alibaba.com>
---
 lib/rebuild.c | 61 ++++++++++++++++++++++++++++++++++++++++++++-------
 lib/super.c   |  2 ++
 mkfs/main.c   |  4 ++++
 3 files changed, 59 insertions(+), 8 deletions(-)

diff --git a/lib/rebuild.c b/lib/rebuild.c
index 9e8bf8f..3fd3ea0 100644
--- a/lib/rebuild.c
+++ b/lib/rebuild.c
@@ -15,6 +15,7 @@
 #include "erofs/xattr.h"
 #include "erofs/blobchunk.h"
 #include "erofs/internal.h"
+#include "erofs/bloom_filter.h"
 #include "liberofs_uuid.h"
 
 #ifdef HAVE_LINUX_AUFS_TYPE_H
@@ -62,14 +63,48 @@ struct erofs_dentry *erofs_rebuild_get_dentry(struct erofs_inode *pwd,
 		char *path, bool aufs, bool *whout, bool *opq, bool to_head)
 {
 	struct erofs_dentry *d = NULL;
-	unsigned int len = strlen(path);
-	char *s = path;
+	unsigned int len, p = 0;
+	char *s;
+	struct erofs_sb_info *sbi = pwd->sbi;
+	char buf[4096];
 
 	*whout = false;
 	*opq = false;
 
+	s = pwd->i_srcpath;
+	len = strlen(pwd->i_srcpath);
+	/* normalize the pwd path, e.g., /./../xxx/yyy -> /xxx/yyy */
+	buf[p++] = '/';
+	while (s < pwd->i_srcpath + len) {
+		char *slash = memchr(s, '/', pwd->i_srcpath + len - s);
+		if (slash) {
+			if (s == slash) {
+				while(*++s == '/');
+				continue;;
+			}
+			*slash = '\0';
+		}
+		if (memcmp(s, ".", 2) && memcmp(s, "..", 3)) {
+			memcpy(buf + p, s, strlen(s));
+			p += strlen(s);
+			buf[p++] = '/';
+
+		}
+		if (slash) {
+			*slash = '/';
+			s = slash + 1;
+		} else{
+			break;
+		}
+	}
+	if (buf[p - 1] != '/')
+		buf[p++] = '/';
+
+	s = path;
+	len = strlen(path);
 	while (s < path + len) {
 		char *slash = memchr(s, '/', path + len - s);
+		int bloom, slen;
 
 		if (slash) {
 			if (s == slash) {
@@ -97,13 +132,19 @@ struct erofs_dentry *erofs_rebuild_get_dentry(struct erofs_inode *pwd,
 				}
 			}
 
-			list_for_each_entry(d, &pwd->i_subdirs, d_child) {
-				if (!strcmp(d->name, s)) {
-					if (d->type != EROFS_FT_DIR && slash)
-						return ERR_PTR(-EIO);
-					inode = d->inode;
-					break;
+			slen = strlen(s);
+			memcpy(buf + p, s, slen);
+			p += slen;
+			if ((bloom = erofs_bloom_test(sbi, buf, p)) > 0) {
+				list_for_each_entry(d, &pwd->i_subdirs, d_child) {
+					if (!strcmp(d->name, s)) {
+						if (d->type != EROFS_FT_DIR && slash)
+							return ERR_PTR(-EIO);
+						inode = d->inode;
+						break;
+					}
 				}
+
 			}
 
 			if (inode) {
@@ -124,6 +165,10 @@ struct erofs_dentry *erofs_rebuild_get_dentry(struct erofs_inode *pwd,
 					return d;
 				pwd = d->inode;
 			}
+			if (!bloom && erofs_bloom_add(sbi, buf, p))
+				return ERR_PTR(-EINVAL);
+			if (slash)
+				buf[p++] = '/';
 		}
 		if (slash) {
 			*slash = '/';
diff --git a/lib/super.c b/lib/super.c
index 45233c4..7289236 100644
--- a/lib/super.c
+++ b/lib/super.c
@@ -7,6 +7,7 @@
 #include "erofs/print.h"
 #include "erofs/xattr.h"
 #include "erofs/cache.h"
+#include "erofs/bloom_filter.h"
 
 static bool check_layout_compatibility(struct erofs_sb_info *sbi,
 				       struct erofs_super_block *dsb)
@@ -153,6 +154,7 @@ void erofs_put_super(struct erofs_sb_info *sbi)
 		erofs_buffer_exit(sbi->bmgr);
 		sbi->bmgr = NULL;
 	}
+	erofs_bloom_exit(sbi);
 }
 
 int erofs_writesb(struct erofs_sb_info *sbi, struct erofs_buffer_head *sb_bh,
diff --git a/mkfs/main.c b/mkfs/main.c
index 20f12fc..27a2ea0 100644
--- a/mkfs/main.c
+++ b/mkfs/main.c
@@ -31,6 +31,7 @@
 #include "../lib/liberofs_private.h"
 #include "../lib/liberofs_uuid.h"
 #include "../lib/compressor.h"
+#include "erofs/bloom_filter.h"
 
 static struct option long_options[] = {
 	{"version", no_argument, 0, 'V'},
@@ -1344,6 +1345,9 @@ int main(int argc, char **argv)
 	}
 
 	erofs_inode_manager_init();
+	srand(time(NULL));
+	/* 1000000 should be enough */
+	erofs_bloom_init(&g_sbi, 5, 1000000, rand());
 
 	if (tar_mode) {
 		root = erofs_rebuild_make_root(&g_sbi);
-- 
2.43.5

