Return-Path: <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>
X-Original-To: lists+linux-erofs@lfdr.de
Delivered-To: lists+linux-erofs@lfdr.de
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	by mail.lfdr.de (Postfix) with ESMTPS id 56C4576452C
	for <lists+linux-erofs@lfdr.de>; Thu, 27 Jul 2023 06:57:55 +0200 (CEST)
Received: from boromir.ozlabs.org (localhost [IPv6:::1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4RBJRj21kwz3cCQ
	for <lists+linux-erofs@lfdr.de>; Thu, 27 Jul 2023 14:57:53 +1000 (AEST)
X-Original-To: linux-erofs@lists.ozlabs.org
Delivered-To: linux-erofs@lists.ozlabs.org
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=linux.alibaba.com (client-ip=115.124.30.100; helo=out30-100.freemail.mail.aliyun.com; envelope-from=jefflexu@linux.alibaba.com; receiver=lists.ozlabs.org)
Received: from out30-100.freemail.mail.aliyun.com (out30-100.freemail.mail.aliyun.com [115.124.30.100])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4RBJR83LK9z30CT
	for <linux-erofs@lists.ozlabs.org>; Thu, 27 Jul 2023 14:57:24 +1000 (AEST)
X-Alimail-AntiSpam: AC=PASS;BC=-1|-1;BR=01201311R121e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=ay29a033018045176;MF=jefflexu@linux.alibaba.com;NM=1;PH=DS;RN=4;SR=0;TI=SMTPD_---0VoJJeTa_1690433839;
Received: from localhost(mailfrom:jefflexu@linux.alibaba.com fp:SMTPD_---0VoJJeTa_1690433839)
          by smtp.aliyun-inc.com;
          Thu, 27 Jul 2023 12:57:20 +0800
From: Jingbo Xu <jefflexu@linux.alibaba.com>
To: hsiangkao@linux.alibaba.com,
	chao@kernel.org,
	huyue2@coolpad.com,
	linux-erofs@lists.ozlabs.org
Subject: [PATCH 7/9] erofs-utils: make erofs_get_dentry() global
Date: Thu, 27 Jul 2023 12:57:10 +0800
Message-Id: <20230727045712.45226-7-jefflexu@linux.alibaba.com>
X-Mailer: git-send-email 2.19.1.6.gb485710b
In-Reply-To: <20230727045712.45226-1-jefflexu@linux.alibaba.com>
References: <20230727045712.45226-1-jefflexu@linux.alibaba.com>
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

Rename tarerofs_get_dentry() to erofs_get_dentry() and make it global.

Also make `whout` and 'opq' parameter optional when `aufs` is false.

Signed-off-by: Jingbo Xu <jefflexu@linux.alibaba.com>
---
 include/erofs/tar.h |  2 ++
 lib/tar.c           | 14 ++++++++------
 2 files changed, 10 insertions(+), 6 deletions(-)

diff --git a/include/erofs/tar.h b/include/erofs/tar.h
index a14f8ac..8699cb5 100644
--- a/include/erofs/tar.h
+++ b/include/erofs/tar.h
@@ -26,4 +26,6 @@ int tarerofs_parse_tar(struct erofs_inode *root, struct erofs_tarfile *tar);
 int tarerofs_reserve_devtable(struct erofs_sb_info *sbi, unsigned int devices);
 int tarerofs_write_devtable(struct erofs_sb_info *sbi, struct erofs_tarfile *tar);
 
+struct erofs_dentry *erofs_get_dentry(struct erofs_inode *pwd, char *path,
+				      bool aufs, bool *whout, bool *opq);
 #endif
diff --git a/lib/tar.c b/lib/tar.c
index 2932980..10ae89c 100644
--- a/lib/tar.c
+++ b/lib/tar.c
@@ -158,15 +158,17 @@ static struct erofs_dentry *tarerofs_mkdir(struct erofs_inode *dir, const char *
 	return d;
 }
 
-static struct erofs_dentry *tarerofs_get_dentry(struct erofs_inode *pwd, char *path,
-					        bool aufs, bool *whout, bool *opq)
+struct erofs_dentry *erofs_get_dentry(struct erofs_inode *pwd, char *path,
+				      bool aufs, bool *whout, bool *opq)
 {
 	struct erofs_dentry *d = NULL;
 	unsigned int len = strlen(path);
 	char *s = path;
 
-	*whout = false;
-	*opq = false;
+	if (aufs) {
+		*whout = false;
+		*opq = false;
+	}
 
 	while (s < path + len) {
 		char *slash = memchr(s, '/', path + len - s);
@@ -611,7 +613,7 @@ restart:
 
 	erofs_dbg("parsing %s (mode %05o)", eh.path, st.st_mode);
 
-	d = tarerofs_get_dentry(root, eh.path, tar->aufs, &whout, &opq);
+	d = erofs_get_dentry(root, eh.path, tar->aufs, &whout, &opq);
 	if (IS_ERR(d)) {
 		ret = PTR_ERR(d);
 		goto out;
@@ -644,7 +646,7 @@ restart:
 		}
 		d->inode = NULL;
 
-		d2 = tarerofs_get_dentry(root, eh.link, tar->aufs, &dumb, &dumb);
+		d2 = erofs_get_dentry(root, eh.link, tar->aufs, &dumb, &dumb);
 		if (IS_ERR(d2)) {
 			ret = PTR_ERR(d2);
 			goto out;
-- 
2.19.1.6.gb485710b

