Return-Path: <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>
X-Original-To: lists+linux-erofs@lfdr.de
Delivered-To: lists+linux-erofs@lfdr.de
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2404:9400:2:0:216:3eff:fee1:b9f1])
	by mail.lfdr.de (Postfix) with ESMTPS id F382D76C951
	for <lists+linux-erofs@lfdr.de>; Wed,  2 Aug 2023 11:18:38 +0200 (CEST)
Received: from boromir.ozlabs.org (localhost [IPv6:::1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4RG5xn0MvZz3cHc
	for <lists+linux-erofs@lfdr.de>; Wed,  2 Aug 2023 19:18:37 +1000 (AEST)
X-Original-To: linux-erofs@lists.ozlabs.org
Delivered-To: linux-erofs@lists.ozlabs.org
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=linux.alibaba.com (client-ip=115.124.30.133; helo=out30-133.freemail.mail.aliyun.com; envelope-from=jefflexu@linux.alibaba.com; receiver=lists.ozlabs.org)
Received: from out30-133.freemail.mail.aliyun.com (out30-133.freemail.mail.aliyun.com [115.124.30.133])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4RG5xD3R64z3c1W
	for <linux-erofs@lists.ozlabs.org>; Wed,  2 Aug 2023 19:18:08 +1000 (AEST)
X-Alimail-AntiSpam: AC=PASS;BC=-1|-1;BR=01201311R101e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=ay29a033018046050;MF=jefflexu@linux.alibaba.com;NM=1;PH=DS;RN=2;SR=0;TI=SMTPD_---0VouSZKn_1690967882;
Received: from localhost(mailfrom:jefflexu@linux.alibaba.com fp:SMTPD_---0VouSZKn_1690967882)
          by smtp.aliyun-inc.com;
          Wed, 02 Aug 2023 17:18:03 +0800
From: Jingbo Xu <jefflexu@linux.alibaba.com>
To: xiang@kernel.org,
	linux-erofs@lists.ozlabs.org
Subject: [PATCH v2 12/16] erofs-utils: add erofs image helper
Date: Wed,  2 Aug 2023 17:17:46 +0800
Message-Id: <20230802091750.74181-12-jefflexu@linux.alibaba.com>
X-Mailer: git-send-email 2.19.1.6.gb485710b
In-Reply-To: <20230802091750.74181-1-jefflexu@linux.alibaba.com>
References: <20230802091750.74181-1-jefflexu@linux.alibaba.com>
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

Later we are going to introduce new feature of merging multiple erofs
images generated from tarfs mode.  Add helpers registering and cleaning
these images.

Signed-off-by: Jingbo Xu <jefflexu@linux.alibaba.com>
---
 include/erofs/rebuild.h | 12 +++++++++++
 lib/rebuild.c           | 45 +++++++++++++++++++++++++++++++++++++++++
 2 files changed, 57 insertions(+)

diff --git a/include/erofs/rebuild.h b/include/erofs/rebuild.h
index 92873c9..df7613a 100644
--- a/include/erofs/rebuild.h
+++ b/include/erofs/rebuild.h
@@ -9,6 +9,18 @@ extern "C"
 
 #include "internal.h"
 
+struct erofs_img {
+	struct list_head list;
+	char *path;
+	dev_t dev;
+	struct erofs_sb_info sbi;
+};
+
+extern unsigned int imgs_count;
+struct erofs_img *erofs_get_img(const char *path);
+int erofs_add_img(const char *path);
+void erofs_cleanup_imgs(void);
+
 struct erofs_dentry *erofs_rebuild_get_dentry(struct erofs_inode *pwd,
 		char *path, bool aufs, bool *whout, bool *opq);
 
diff --git a/lib/rebuild.c b/lib/rebuild.c
index 7aaa071..e2f6c1d 100644
--- a/lib/rebuild.c
+++ b/lib/rebuild.c
@@ -16,6 +16,9 @@
 #define AUFS_WH_DIROPQ		AUFS_WH_PFX AUFS_DIROPQ_NAME
 #endif
 
+unsigned int imgs_count;
+static LIST_HEAD(imgs_list);
+
 static struct erofs_dentry *erofs_rebuild_mkdir(struct erofs_inode *dir,
 						const char *s)
 {
@@ -115,3 +118,45 @@ struct erofs_dentry *erofs_rebuild_get_dentry(struct erofs_inode *pwd,
 	}
 	return d;
 }
+
+struct erofs_img *erofs_get_img(const char *path)
+{
+	struct erofs_img *img = malloc(sizeof(*img));
+
+	if (!img)
+		return ERR_PTR(-ENOMEM);
+
+	img->path = realpath(path, NULL);
+	if (!img->path) {
+		erofs_err("failed to parse image file (%s): %s",
+			  path, erofs_strerror(-errno));
+		free(img);
+		return ERR_PTR(-ENOENT);
+	}
+
+	img->dev = ++imgs_count;
+	return img;
+}
+
+int erofs_add_img(const char *path)
+{
+	struct erofs_img *img = erofs_get_img(path);
+
+	if (IS_ERR(img))
+		return PTR_ERR(img);
+
+	list_add_tail(&img->list, &imgs_list);
+	return 0;
+}
+
+void erofs_cleanup_imgs(void)
+{
+	struct erofs_img *img, *n;
+
+	list_for_each_entry_safe(img, n, &imgs_list, list) {
+		list_del(&img->list);
+		free(img->path);
+		free(img);
+	}
+	imgs_count = 0;
+}
-- 
2.19.1.6.gb485710b

