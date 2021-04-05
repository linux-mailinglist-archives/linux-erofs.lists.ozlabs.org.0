Return-Path: <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>
X-Original-To: lists+linux-erofs@lfdr.de
Delivered-To: lists+linux-erofs@lfdr.de
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2404:9400:2:0:216:3eff:fee1:b9f1])
	by mail.lfdr.de (Postfix) with ESMTPS id A102E353D59
	for <lists+linux-erofs@lfdr.de>; Mon,  5 Apr 2021 11:39:00 +0200 (CEST)
Received: from boromir.ozlabs.org (localhost [IPv6:::1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4FDQb64L0Kz30CF
	for <lists+linux-erofs@lfdr.de>; Mon,  5 Apr 2021 19:38:58 +1000 (AEST)
X-Original-To: linux-erofs@lists.ozlabs.org
Delivered-To: linux-erofs@lists.ozlabs.org
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized)
 smtp.mailfrom=mail.scut.edu.cn (client-ip=202.38.213.20; helo=mail.scut.edu.cn;
 envelope-from=sehuww@mail.scut.edu.cn; receiver=<UNKNOWN>)
Received: from mail.scut.edu.cn (stumail1.scut.edu.cn [202.38.213.20])
 by lists.ozlabs.org (Postfix) with ESMTP id 4FDQb35tc8z30BF
 for <linux-erofs@lists.ozlabs.org>; Mon,  5 Apr 2021 19:38:54 +1000 (AEST)
Received: from laptop.huww98.cn (unknown [125.216.246.30])
 by front (Coremail) with SMTP id AWSowADHztaS2mpgJtMZAA--.11274S4;
 Mon, 05 Apr 2021 17:38:27 +0800 (CST)
From: Hu Weiwen <sehuww@mail.scut.edu.cn>
To: hsiangkao@redhat.com,
	linux-erofs@lists.ozlabs.org
Subject: [PATCH v2] erofs-utils: use qsort() to sort dir->i_subdirs
Date: Mon,  5 Apr 2021 17:38:16 +0800
Message-Id: <20210405093816.149621-1-sehuww@mail.scut.edu.cn>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20210402021741.GB4011659@xiangao.remote.csb>
References: <20210402021741.GB4011659@xiangao.remote.csb>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID: AWSowADHztaS2mpgJtMZAA--.11274S4
X-Coremail-Antispam: 1UD129KBjvJXoWxWF1xGryDKryUtFWkWw1xZrb_yoWrJr4DpF
 4YyryxJ3ykXF97urn3tr4DZayFqF4xta18C3yxWa4rtw15Ar1IqF4xJr1DCrW3GrWkCrWa
 qF4q9w1UGr47KF7anT9S1TB71UUUUUUqnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
 9KBjDU0xBIdaVrnRJUUUyC14x267AKxVWUJVW8JwAFc2x0x2IEx4CE42xK8VAvwI8IcIk0
 rVWrJVCq3wAFIxvE14AKwVWUJVWUGwA2ocxC64kIII0Yj41l84x0c7CEw4AK67xGY2AK02
 1l84ACjcxK6xIIjxv20xvE14v26r1j6r1xM28EF7xvwVC0I7IYx2IY6xkF7I0E14v26r1j
 6r4UM28EF7xvwVC2z280aVAFwI0_Cr0_Gr1UM28EF7xvwVC2z280aVCY1x0267AKxVW8Jr
 0_Cr1UM2AIxVAIcxkEcVAq07x20xvEncxIr21l5I8CrVACY4xI64kE6c02F40Ex7xfMcIj
 6xIIjxv20xvE14v26r1j6r18McIj6I8E87Iv67AKxVWUJVW8JwAm72CE4IkC6x0Yz7v_Jr
 0_Gr1lF7xvr2IYc2Ij64vIr41lF7I21c0EjII2zVCS5cI20VAGYxC7MxAIw28IcxkI7VAK
 I48JMxC20s026xCaFVCjc4AY6r1j6r4UMI8I3I0E5I8CrVAFwI0_Jr0_Jr4lx2IqxVCjr7
 xvwVAFwI0_JrI_JrWlx4CE17CEb7AF67AKxVWUXVWUAwCIc40Y0x0EwIxGrwCI42IY6xII
 jxv20xvE14v26r1j6r1xMIIF0xvE2Ix0cI8IcVCY1x0267AKxVWUJVW8JwCI42IY6xAIw2
 0EY4v20xvaj40_WFyUJVCq3wCI42IY6I8E87Iv67AKxVWUJVW8JwCI42IY6I8E87Iv6xkF
 7I0E14v26r1j6r4UYxBIdaVFxhVjvjDU0xZFpf9x0JUywZ7UUUUU=
X-CM-SenderInfo: qsqrljqqwxllyrt6zt1loo2ulxwovvfxof0/1tbiAQASBlepTBMIEQAZs0
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

Original implementation use insertion sort, and its time complexity is
O(n^2). This patch use qsort instead. When I create a directory with
100k entries, this reduces the user space time from around 3 mins to
0.5s.

Create such a large directory for benchmark with:
mkdir large; cd large; touch $(seq 100000);

Signed-off-by: Hu Weiwen <sehuww@mail.scut.edu.cn>
---
 lib/inode.c | 53 +++++++++++++++++++++++++++++++++--------------------
 1 file changed, 33 insertions(+), 20 deletions(-)

diff --git a/lib/inode.c b/lib/inode.c
index d52facf..ef55e88 100644
--- a/lib/inode.c
+++ b/lib/inode.c
@@ -96,21 +96,6 @@ unsigned int erofs_iput(struct erofs_inode *inode)
 	return 0;
 }

-static int dentry_add_sorted(struct erofs_dentry *d, struct list_head *head)
-{
-	struct list_head *pos;
-
-	list_for_each(pos, head) {
-		struct erofs_dentry *d2 =
-			container_of(pos, struct erofs_dentry, d_child);
-
-		if (strcmp(d->name, d2->name) < 0)
-			break;
-	}
-	list_add_tail(&d->d_child, pos);
-	return 0;
-}
-
 struct erofs_dentry *erofs_d_alloc(struct erofs_inode *parent,
 				   const char *name)
 {
@@ -122,7 +107,7 @@ struct erofs_dentry *erofs_d_alloc(struct erofs_inode *parent,
 	strncpy(d->name, name, EROFS_NAME_LEN - 1);
 	d->name[EROFS_NAME_LEN - 1] = '\0';

-	dentry_add_sorted(d, &parent->i_subdirs);
+	list_add_tail(&d->d_child, &parent->i_subdirs);
 	return d;
 }

@@ -156,10 +141,19 @@ static int __allocate_inode_bh_data(struct erofs_inode *inode,
 	return 0;
 }

+static int comp_subdir(const void *a, const void *b)
+{
+	const struct erofs_dentry *da, *db;
+
+	da = *((const struct erofs_dentry **)a);
+	db = *((const struct erofs_dentry **)b);
+	return strcmp(da->name, db->name);
+}
+
-int erofs_prepare_dir_file(struct erofs_inode *dir)
+int erofs_prepare_dir_file(struct erofs_inode *dir, unsigned int nr_subdirs)
 {
-	struct erofs_dentry *d;
-	unsigned int d_size, i_nlink;
+	struct erofs_dentry *d, *n, **sorted_d;
+	unsigned int d_size, i_nlink, i;
 	int ret;

 	/* dot is pointed to the current dir inode */
@@ -172,6 +166,22 @@ int erofs_prepare_dir_file(struct erofs_inode *dir)
 	d->inode = erofs_igrab(dir->i_parent);
 	d->type = EROFS_FT_DIR;

+	/* sort subdirs */
+	nr_subdirs += 2;
+	sorted_d = malloc(nr_subdirs * sizeof(d));
+	if (!sorted_d)
+		return -ENOMEM;
+	i = 0;
+	list_for_each_entry_safe(d, n, &dir->i_subdirs, d_child) {
+		list_del(&d->d_child);
+		sorted_d[i++] = d;
+	}
+	DBG_BUGON(i != nr_subdirs);
+	qsort(sorted_d, nr_subdirs, sizeof(d), comp_subdir);
+	for (i = 0; i < nr_subdirs; i++)
+		list_add_tail(&sorted_d[i]->d_child, &dir->i_subdirs);
+	free(sorted_d);
+
 	/* let's calculate dir size and update i_nlink */
 	d_size = 0;
 	i_nlink = 0;
@@ -922,6 +932,7 @@ struct erofs_inode *erofs_mkfs_build_tree(struct erofs_inode *dir)
 	DIR *_dir;
 	struct dirent *dp;
 	struct erofs_dentry *d;
+	unsigned int nr_subdirs;

 	ret = erofs_prepare_xattr_ibody(dir);
 	if (ret < 0)
@@ -961,6 +972,7 @@ struct erofs_inode *erofs_mkfs_build_tree(struct erofs_inode *dir)
 		return ERR_PTR(-errno);
 	}

+	nr_subdirs = 0;
 	while (1) {
 		/*
 		 * set errno to 0 before calling readdir() in order to
@@ -984,6 +996,7 @@ struct erofs_inode *erofs_mkfs_build_tree(struct erofs_inode *dir)
 			ret = PTR_ERR(d);
 			goto err_closedir;
 		}
+		nr_subdirs++;

 		/* to count i_nlink for directories */
 		d->type = (dp->d_type == DT_DIR ?
@@ -996,7 +1009,7 @@ struct erofs_inode *erofs_mkfs_build_tree(struct erofs_inode *dir)
 	}
 	closedir(_dir);

-	ret = erofs_prepare_dir_file(dir);
+	ret = erofs_prepare_dir_file(dir, nr_subdirs);
 	if (ret)
 		goto err;

--
2.25.1

