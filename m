Return-Path: <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>
X-Original-To: lists+linux-erofs@lfdr.de
Delivered-To: lists+linux-erofs@lfdr.de
Received: from lists.ozlabs.org (lists.ozlabs.org [203.11.71.2])
	by mail.lfdr.de (Postfix) with ESMTPS id 157FB305EE
	for <lists+linux-erofs@lfdr.de>; Fri, 31 May 2019 02:51:53 +0200 (CEST)
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2401:3900:2:1::3])
	by lists.ozlabs.org (Postfix) with ESMTP id 45FQrQ4XS2zDqXT
	for <lists+linux-erofs@lfdr.de>; Fri, 31 May 2019 10:51:50 +1000 (AEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=lists.ozlabs.org;
	s=201707; t=1559263910;
	bh=TjzCoF8V0guPAx+e2xlE9oF1aCtdV6ZAHhgInAipZ4g=;
	h=To:Subject:Date:In-Reply-To:References:List-Id:List-Unsubscribe:
	 List-Archive:List-Post:List-Help:List-Subscribe:From:Reply-To:
	 From;
	b=T/uEOOfBOyO3bqQQo/9ifB2C/M/JtzR1A05xtkFRmjg/hLuuCyPh8MAx+Joo1/Q7t
	 nLmfbKHx7FeldNxt++jhi6bDKw5PYZi4qHtRde6G2qD/jVi10wnge9jTIkRYgSLbQg
	 dkW3gi48ONQw8nxDC7WHAGs/exALLos8HN8QXr/Vn+OMnnbojaGKw5/Rm+3dYNmrp+
	 Q5gopCvGsg6F9+4lYobagPOlVBBSNwPHrv4inQ80j6TQD6SAL8KeOSEfND369ox38z
	 Xw8hJK+ou7bJc6mEF1IRM1nMEyUzQeiN05ywO43EyOwqI7me5DbITxq2j0JEV+O8ue
	 vypga3wIY4MFg==
X-Original-To: linux-erofs@lists.ozlabs.org
Delivered-To: linux-erofs@lists.ozlabs.org
Authentication-Results: lists.ozlabs.org;
 spf=pass (mailfrom) smtp.mailfrom=aol.com
 (client-ip=98.137.64.146; helo=sonic301-20.consmr.mail.gq1.yahoo.com;
 envelope-from=hsiangkao@aol.com; receiver=<UNKNOWN>)
Authentication-Results: lists.ozlabs.org;
 dmarc=pass (p=reject dis=none) header.from=aol.com
Authentication-Results: lists.ozlabs.org; dkim=pass (2048-bit key;
 unprotected) header.d=aol.com header.i=@aol.com header.b="M1F2g+Aa"; 
 dkim-atps=neutral
Received: from sonic301-20.consmr.mail.gq1.yahoo.com
 (sonic301-20.consmr.mail.gq1.yahoo.com [98.137.64.146])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 45FQr13F9KzDqV5
 for <linux-erofs@lists.ozlabs.org>; Fri, 31 May 2019 10:51:28 +1000 (AEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=aol.com; s=a2048;
 t=1559263886; bh=lS2INq3pkY8wx9U5QwjHIl7/nquK9Y6ivdh5P9gyiZo=;
 h=From:To:Cc:Subject:Date:In-Reply-To:References:From:Subject;
 b=M1F2g+AapgUY/M36N0cyhI2vX7Y1zbDPpjw55Q5slbKYaUKpB8M7cOMAzxjWM1e+OakncLjS/IxhCB5+kA39LSTdD6rwbfqkZtKE+/G0B1rwvgNChY0hyyk07c6Whs8JE539/Fv2Y/kjYjwmAyD7AaJHzUdNcUFj4w85qkL+wwFqzAUYoOtAMc8oQds9uzN6kTUR1a/WpMVf4i4zENMqq18A6MXZU+GiUNFrnWdDUJpdLV0oqgsSpoYiRQltcZ0p/VdhQeZgzXeZDv+UZ7IdS0+DUlz1vy1Jqfu8VoBETdEPdO8vBZw49Vdv6Y3r4yyqz7Hwz6p6vfUg9Vk94b1D+Q==
X-YMail-OSG: 7fix_RcVM1k4MN.vDYk0NBO0qN.U0.pm3y4tp5ZuVvw5uRIL2qsnAFqGh.r1.1H
 JZ7R49BzmlCzrK7_4Htl.eupK4pc6piYV745TYnZ0H_88sdcL0iAf_qaG9s7ZntvZLuXDWaVcQRc
 owKXeoRnMvY_iGiXy2HkhPNmjll3s7bLot6R3JrlEtQqWWWAiDrHv9iL7f5R9ehH4bSKvRqLMZu3
 VTtsTKUezuySFr_7EgHfRPj_ochATq8KUD2YTrkrrw87lxTL3ryXVzQh3lGVtg7VcKDfwzLnCyEu
 SjMk1P9tjJqUc57bgW1F93KllrCDQX11X8Hq_s1rwAmRXb1lbEAZRV2plhvBOLV5D56mMw9VL3Cc
 vWR.yubSi47C3j5fSZMI4hMFeCPCHvkioB8zAZKvr230lCglL85ZHRsXlUujV.p0YKerhc4B.W4c
 DAic9L_OcmuQoGFNwuFFDbdO0mPM99zi2v5TBvK.mR.Qa5zkSR8ExUFCzJTNREFUUldewO5M5txy
 61EE7b4jzvUwwFAPhUyTHjNUZTjtlMmszhNgos4kTFYGkq7S6asXJAWiiKl_wt2IMCpSGW11iBXl
 QL3k8QbtF2E3_6bJWsZ4uM0nAwjiIJLQphaACdY40E_PjuiXtAJBI9TxhRLb7ecdzgGZHx4JyfdB
 zKJW.CK1njZ1uLo8G8I6kfEPV6spNxV.jYtskLyx2dDrnPVg1rV7hL26HGWZsAKLykoHPnDpsOZu
 9dw7lc_r_gF0LjpUrJYlupu1NBRzvkRUEge.X5MqVH3Dona3i4lkObspP4zAooh203HZri2_GjCa
 Ps6IyFsZj4jdJzAuQK5UiGr2HOQnxTNqYJ6CnJPzZtsGE94okOCTSqO5aqGc4sHxiqzJle827_2K
 txaUUtW8QUeSW5ryzvnxws2knxnQEalbe2wgoLpmVEg.gSlQYxyppf7lkarIuguuQZYmBtbG9R5R
 AI4.XINFI21S5rSnUsHd0f.3lKMYX30kwwLol0aIRr3NbDVaO3YVgDI3U.91wm_MtIOcWoel0CmW
 WYcxvCpBh6vsPcRtgEEe_PFAplJGBR7j7BuaxZ0UylIJHg3_71f4uWF0LXU3O0IhkZIpBbLRHIpl
 IJxmbXoG_3lEU_NY4p9Cjydiz37370mN.OE9W1zZkKJVMYmRsrqONd5NALzWttHu9yFTSuF2PxR6
 Os8PhQ4mAl7as2guqRJdEIbQqllvBq4T8DDVyuBjKiSk__6RS2ilWSmVf0frifv4rNn9ndQ--
Received: from sonic.gate.mail.ne1.yahoo.com by
 sonic301.consmr.mail.gq1.yahoo.com with HTTP; Fri, 31 May 2019 00:51:26 +0000
Received: from 125.120.86.223 (EHLO localhost.localdomain) ([125.120.86.223])
 by smtp417.mail.gq1.yahoo.com (Oath Hermes SMTP Server) with ESMTPA
 ID a9e989b6e54ef4fb7ecb5a20a6091749; 
 Fri, 31 May 2019 00:51:24 +0000 (UTC)
To: linux-erofs@lists.ozlabs.org
Subject: [PATCH 06/13] erofs-utils: introduce inode operations
Date: Fri, 31 May 2019 08:50:40 +0800
Message-Id: <20190531005047.22093-7-hsiangkao@aol.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20190531005047.22093-1-hsiangkao@aol.com>
References: <20190531005047.22093-1-hsiangkao@aol.com>
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
Reply-To: Gao Xiang <hsiangkao@aol.com>
Errors-To: linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org
Sender: "Linux-erofs"
 <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>

From: Gao Xiang <gaoxiang25@huawei.com>

This patch adds core inode and dentry operations
to build the target image.

Signed-off-by: Li Guifu <bluce.liguifu@huawei.com>
[ Gao Xiang: with heavy changes. ]
Signed-off-by: Gao Xiang <gaoxiang25@huawei.com>
---
 include/erofs/inode.h    |  21 ++
 include/erofs/internal.h |  10 +-
 lib/Makefile.am          |   2 +-
 lib/inode.c              | 752 +++++++++++++++++++++++++++++++++++++++
 4 files changed, 782 insertions(+), 3 deletions(-)
 create mode 100644 include/erofs/inode.h
 create mode 100644 lib/inode.c

diff --git a/include/erofs/inode.h b/include/erofs/inode.h
new file mode 100644
index 0000000..43aee93
--- /dev/null
+++ b/include/erofs/inode.h
@@ -0,0 +1,21 @@
+/* SPDX-License-Identifier: GPL-2.0+ */
+/*
+ * erofs_utils/include/erofs/inode.h
+ *
+ * Copyright (C) 2018-2019 HUAWEI, Inc.
+ *             http://www.huawei.com/
+ * Created by Li Guifu <bluce.liguifu@huawei.com>
+ * with heavy changes by Gao Xiang <gaoxiang25@huawei.com>
+ */
+#ifndef __EROFS_INODE_H
+#define __EROFS_INODE_H
+
+#include "erofs/internal.h"
+
+void erofs_inode_manager_init(void);
+unsigned int erofs_iput(struct erofs_inode *inode);
+erofs_nid_t erofs_lookupnid(struct erofs_inode *inode);
+struct erofs_inode *erofs_mkfs_build_tree_from_path(struct erofs_inode *parent,
+						    const char *path);
+
+#endif
diff --git a/include/erofs/internal.h b/include/erofs/internal.h
index 238a076..dfa6173 100644
--- a/include/erofs/internal.h
+++ b/include/erofs/internal.h
@@ -82,8 +82,6 @@ struct erofs_inode {
 	char i_srcpath[PATH_MAX + 1];
 
 	unsigned char data_mapping_mode;
-	bool compression_disabled;
-
 	unsigned char inode_isize;
 	/* inline tail-end packing size */
 	unsigned short idata_size;
@@ -111,6 +109,14 @@ struct erofs_dentry {
 	};
 };
 
+static inline bool is_dot_dotdot(const char *name)
+{
+	if (name[0] != '.')
+		return false;
+
+	return name[1] == '\0' || (name[1] == '.' && name[2] == '\0');
+}
+
 #include <stdio.h>
 #include <string.h>
 
diff --git a/lib/Makefile.am b/lib/Makefile.am
index 8508660..5257d71 100644
--- a/lib/Makefile.am
+++ b/lib/Makefile.am
@@ -2,6 +2,6 @@
 # Makefile.am
 
 noinst_LTLIBRARIES = liberofs.la
-liberofs_la_SOURCES = config.c io.c cache.c
+liberofs_la_SOURCES = config.c io.c cache.c inode.c
 liberofs_la_CFLAGS = -Wall -Werror -I$(top_srcdir)/include
 
diff --git a/lib/inode.c b/lib/inode.c
new file mode 100644
index 0000000..d3e5ed8
--- /dev/null
+++ b/lib/inode.c
@@ -0,0 +1,752 @@
+// SPDX-License-Identifier: GPL-2.0+
+/*
+ * erofs_utils/lib/inode.c
+ *
+ * Copyright (C) 2018-2019 HUAWEI, Inc.
+ *             http://www.huawei.com/
+ * Created by Li Guifu <bluce.liguifu@huawei.com>
+ * with heavy changes by Gao Xiang <gaoxiang25@huawei.com>
+ */
+#define _GNU_SOURCE
+#include <string.h>
+#include <stdlib.h>
+#include <stdio.h>
+#include <sys/stat.h>
+#include <dirent.h>
+#include "erofs/print.h"
+#include "erofs/inode.h"
+#include "erofs/cache.h"
+#include "erofs/io.h"
+
+struct erofs_sb_info sbi;
+
+#define S_SHIFT                 12
+static unsigned char erofs_type_by_mode[S_IFMT >> S_SHIFT] = {
+	[S_IFREG >> S_SHIFT]  = EROFS_FT_REG_FILE,
+	[S_IFDIR >> S_SHIFT]  = EROFS_FT_DIR,
+	[S_IFCHR >> S_SHIFT]  = EROFS_FT_CHRDEV,
+	[S_IFBLK >> S_SHIFT]  = EROFS_FT_BLKDEV,
+	[S_IFIFO >> S_SHIFT]  = EROFS_FT_FIFO,
+	[S_IFSOCK >> S_SHIFT] = EROFS_FT_SOCK,
+	[S_IFLNK >> S_SHIFT]  = EROFS_FT_SYMLINK,
+};
+
+#define NR_INODE_HASHTABLE	64
+
+struct list_head inode_hashtable[NR_INODE_HASHTABLE];
+
+void erofs_inode_manager_init(void)
+{
+	unsigned int i;
+
+	for (i = 0; i < NR_INODE_HASHTABLE; ++i)
+		init_list_head(&inode_hashtable[i]);
+}
+
+static struct erofs_inode *erofs_igrab(struct erofs_inode *inode)
+{
+	++inode->i_count;
+	return inode;
+}
+
+/* get the inode from the (source) inode # */
+struct erofs_inode *erofs_iget(ino_t ino)
+{
+	struct list_head *head =
+		&inode_hashtable[ino % NR_INODE_HASHTABLE];
+	struct erofs_inode *inode;
+
+	list_for_each_entry(inode, head, i_hash)
+		if (inode->i_ino[1] == ino)
+			return erofs_igrab(inode);
+	return NULL;
+}
+
+struct erofs_inode *erofs_iget_by_nid(erofs_nid_t nid)
+{
+	struct list_head *head =
+		&inode_hashtable[nid % NR_INODE_HASHTABLE];
+	struct erofs_inode *inode;
+
+	list_for_each_entry(inode, head, i_hash)
+		if (inode->nid == nid)
+			return erofs_igrab(inode);
+	return NULL;
+}
+
+unsigned int erofs_iput(struct erofs_inode *inode)
+{
+	struct erofs_dentry *d, *t;
+
+	if (inode->i_count > 1)
+		return --inode->i_count;
+
+	list_for_each_entry_safe(d, t, &inode->i_subdirs, d_child)
+		free(d);
+
+	list_del(&inode->i_hash);
+	free(inode);
+	return 0;
+}
+
+static int dentry_add_sorted(struct erofs_dentry *d, struct list_head *head)
+{
+	struct list_head *pos;
+
+	list_for_each(pos, head) {
+		struct erofs_dentry *d2 =
+			container_of(pos, struct erofs_dentry, d_child);
+
+		if (strcmp(d->name, d2->name) < 0)
+			break;
+	}
+	list_add_tail(&d->d_child, pos);
+	return 0;
+}
+
+struct erofs_dentry *erofs_d_alloc(struct erofs_inode *parent,
+				   const char *name)
+{
+	struct erofs_dentry *d = malloc(sizeof(*d));
+
+	if (!d)
+		return ERR_PTR(-ENOMEM);
+
+	strncpy(d->name, name, EROFS_NAME_LEN - 1);
+	d->name[EROFS_NAME_LEN - 1] = '\0';
+
+	dentry_add_sorted(d, &parent->i_subdirs);
+	return d;
+}
+
+/* allocate main data for a inode */
+static int __allocate_inode_bh_data(struct erofs_inode *inode,
+				    unsigned long nblocks)
+{
+	struct erofs_buffer_head *bh;
+	int ret;
+
+	if (!nblocks) {
+		inode->bh_data = NULL;
+		/* it has only tail-end inlined data */
+		inode->u.i_blkaddr = NULL_ADDR;
+		return 0;
+	}
+
+	/* allocate main data buffer */
+	bh = erofs_balloc(DATA, blknr_to_addr(nblocks), 0, 0);
+	if (IS_ERR(bh))
+		return PTR_ERR(bh);
+
+	bh->op = &erofs_skip_write_bhops;
+	inode->bh_data = bh;
+
+	/* get blkaddr of the bh */
+	ret = erofs_mapbh(bh->block, true);
+	DBG_BUGON(ret < 0);
+
+	/* write blocks except for the tail-end block */
+	inode->u.i_blkaddr = bh->block->blkaddr;
+	return 0;
+}
+
+int erofs_prepare_dir_file(struct erofs_inode *dir)
+{
+	struct erofs_dentry *d;
+	unsigned int d_size;
+	int ret;
+
+	/* dot is pointed to the current dir inode */
+	d = erofs_d_alloc(dir, ".");
+	d->inode = erofs_igrab(dir);
+	d->type = EROFS_FT_DIR;
+
+	/* dotdot is pointed to the parent dir */
+	d = erofs_d_alloc(dir, "..");
+	d->inode = erofs_igrab(dir->i_parent);
+	d->type = EROFS_FT_DIR;
+
+	/* let's calculate dir size */
+	d_size = 0;
+	list_for_each_entry(d, &dir->i_subdirs, d_child) {
+		int len = strlen(d->name) + sizeof(struct erofs_dirent);
+
+		if (d_size % EROFS_BLKSIZ + len > EROFS_BLKSIZ)
+			d_size = round_up(d_size, EROFS_BLKSIZ);
+		d_size += len;
+	}
+	dir->i_size = d_size;
+
+	/* no compression for all dirs */
+	dir->data_mapping_mode = EROFS_INODE_LAYOUT_INLINE;
+
+	/* allocate dir main data */
+	ret = __allocate_inode_bh_data(dir, erofs_blknr(d_size));
+	if (ret)
+		return ret;
+
+	/* it will be used in erofs_prepare_inode_buffer */
+	dir->idata_size = d_size % EROFS_BLKSIZ;
+	return 0;
+}
+
+static void fill_dirblock(char *buf, unsigned int size, unsigned int q,
+			  struct erofs_dentry *head, struct erofs_dentry *end)
+{
+	unsigned int p = 0;
+
+	/* write out all erofs_dirents + filenames */
+	while (head != end) {
+		const unsigned int namelen = strlen(head->name);
+		struct erofs_dirent d = {
+			.nid = cpu_to_le64(head->nid),
+			.nameoff = cpu_to_le16(q),
+			.file_type = head->type,
+		};
+
+		memcpy(buf + p, &d, sizeof(d));
+		memcpy(buf + q, head->name, namelen);
+		p += sizeof(d);
+		q += namelen;
+
+		head = list_next_entry(head, d_child);
+	}
+	memset(buf + q, 0, size - q);
+}
+
+int erofs_write_dir_file(struct erofs_inode *dir)
+{
+	struct erofs_dentry *head = list_first_entry(&dir->i_subdirs,
+						     struct erofs_dentry,
+						     d_child);
+	struct erofs_dentry *d;
+	int ret;
+	unsigned int q, used, blkno;
+
+	q = used = blkno = 0;
+
+	list_for_each_entry(d, &dir->i_subdirs, d_child) {
+		const unsigned int len = strlen(d->name) +
+			sizeof(struct erofs_dirent);
+
+		if (used + len > EROFS_BLKSIZ) {
+			char buf[EROFS_BLKSIZ];
+
+			fill_dirblock(buf, EROFS_BLKSIZ, q, head, d);
+			ret = blk_write(buf, dir->u.i_blkaddr + blkno, 1);
+			if (ret)
+				return ret;
+
+			head = d;
+			q = used = 0;
+			++blkno;
+		}
+		used += len;
+		q += sizeof(struct erofs_dirent);
+	}
+	DBG_BUGON(used != dir->i_size % EROFS_BLKSIZ);
+	if (used) {
+		/* fill tail-end dir block */
+		dir->idata = malloc(used);
+		fill_dirblock(dir->idata, dir->idata_size, q, head, d);
+	}
+	return 0;
+}
+
+int erofs_write_file_from_buffer(struct erofs_inode *inode, char *buf)
+{
+	const unsigned int nblocks = erofs_blknr(inode->i_size);
+	int ret;
+
+	inode->data_mapping_mode = EROFS_INODE_LAYOUT_INLINE;
+
+	ret = __allocate_inode_bh_data(inode, nblocks);
+	if (ret)
+		return ret;
+
+	if (nblocks)
+		blk_write(buf, inode->u.i_blkaddr, nblocks);
+	inode->idata_size = inode->i_size % EROFS_BLKSIZ;
+	if (inode->idata_size) {
+		inode->idata = malloc(inode->idata_size);
+		memcpy(inode->idata, buf + blknr_to_addr(nblocks),
+		       inode->idata_size);
+	}
+	return 0;
+}
+
+/* rules to decide whether a file could be compressed or not */
+static bool erofs_file_is_compressible(struct erofs_inode *inode)
+{
+	return true;
+}
+
+int erofs_write_file(struct erofs_inode *inode)
+{
+	unsigned int nblocks, i;
+	int ret, fd;
+
+	if (erofs_file_is_compressible(inode)) {
+		/* to be implemented */
+	}
+
+	/* fallback to all data uncompressed */
+	inode->data_mapping_mode = EROFS_INODE_LAYOUT_INLINE;
+	nblocks = inode->i_size / EROFS_BLKSIZ;
+
+	ret = __allocate_inode_bh_data(inode, nblocks);
+	if (ret)
+		return ret;
+
+	fd = open(inode->i_srcpath, O_RDONLY | O_BINARY);
+	if (fd < 0)
+		return -errno;
+
+	for (i = 0; i < nblocks; ++i) {
+		char buf[EROFS_BLKSIZ];
+
+		ret = read(fd, buf, EROFS_BLKSIZ);
+		if (ret != EROFS_BLKSIZ) {
+			if (ret < 0)
+				goto fail;
+			close(fd);
+			return -EAGAIN;
+		}
+
+		ret = blk_write(buf, inode->u.i_blkaddr + i, 1);
+		if (ret)
+			goto fail;
+	}
+
+	/* read the tail-end data */
+	inode->idata_size = inode->i_size % EROFS_BLKSIZ;
+	if (inode->idata_size) {
+		inode->idata = malloc(inode->idata_size);
+
+		ret = read(fd, inode->idata, inode->idata_size);
+		if (ret < inode->idata_size) {
+			close(fd);
+			return -EIO;
+		}
+	}
+	close(fd);
+	return 0;
+fail:
+	ret = -errno;
+	close(fd);
+	return ret;
+}
+
+static bool erofs_bh_flush_write_inode(struct erofs_buffer_head *bh)
+{
+	struct erofs_inode *const inode = bh->fsprivate;
+	const erofs_off_t off = erofs_btell(bh, false);
+
+	/* let's support v1 currently */
+	struct erofs_inode_v1 v1 = {0};
+	int ret;
+
+	v1.i_advise = cpu_to_le16(0 | (inode->data_mapping_mode << 1));
+	v1.i_mode = cpu_to_le16(inode->i_mode);
+	v1.i_nlink = cpu_to_le16(inode->i_nlink);
+	v1.i_size = cpu_to_le32((u32)inode->i_size);
+
+	v1.i_ino = cpu_to_le32(inode->i_ino[0]);
+
+	v1.i_uid = cpu_to_le16((u16)inode->i_uid);
+	v1.i_gid = cpu_to_le16((u16)inode->i_gid);
+
+	switch ((inode->i_mode) >> S_SHIFT) {
+	case S_IFCHR:
+	case S_IFBLK:
+	case S_IFIFO:
+	case S_IFSOCK:
+		v1.i_u.rdev = cpu_to_le32(inode->u.i_rdev);
+		break;
+
+	default:
+		if (inode->data_mapping_mode == EROFS_INODE_LAYOUT_COMPRESSION)
+			v1.i_u.compressed_blocks =
+				cpu_to_le32(inode->u.i_blocks);
+		else
+			v1.i_u.raw_blkaddr =
+				cpu_to_le32(inode->u.i_blkaddr);
+		break;
+	}
+	v1.i_checksum = 0;
+
+	ret = dev_write(&v1, off, sizeof(struct erofs_inode_v1));
+	if (ret)
+		return false;
+
+	erofs_iput(inode);
+	return erofs_bh_flush_generic_end(bh);
+}
+
+static struct erofs_bhops erofs_write_inode_bhops = {
+	.flush = erofs_bh_flush_write_inode,
+};
+
+int erofs_prepare_inode_buffer(struct erofs_inode *inode)
+{
+	unsigned int inodesize;
+	struct erofs_buffer_head *bh, *ibh;
+
+	DBG_BUGON(inode->bh || inode->bh_inline);
+
+	inodesize = inode->inode_isize + inode->xattr_isize +
+		    inode->extent_isize;
+
+	if (inode->data_mapping_mode == EROFS_INODE_LAYOUT_COMPRESSION)
+		goto noinline;
+
+	/*
+	 * if the file size is block-aligned for uncompressed files,
+	 * should use EROFS_INODE_LAYOUT_PLAIN data mapping mode.
+	 */
+	if (!inode->idata_size)
+		inode->data_mapping_mode = EROFS_INODE_LAYOUT_PLAIN;
+
+	bh = erofs_balloc(INODE, inodesize, 0, inode->idata_size);
+	if (bh == ERR_PTR(-ENOSPC)) {
+		inode->data_mapping_mode = EROFS_INODE_LAYOUT_PLAIN;
+noinline:
+		bh = erofs_balloc(INODE, inodesize, 0, 0);
+		if (IS_ERR(bh))
+			return PTR_ERR(bh);
+	} else if (IS_ERR(bh)) {
+		return PTR_ERR(bh);
+	} else if (inode->idata_size) {
+		inode->data_mapping_mode = EROFS_INODE_LAYOUT_INLINE;
+
+		/* allocate inline buffer */
+		ibh = erofs_battach(bh, META, inode->idata_size);
+		if (IS_ERR(ibh))
+			return PTR_ERR(ibh);
+
+		ibh->op = &erofs_skip_write_bhops;
+		inode->bh_inline = ibh;
+	}
+
+	bh->fsprivate = erofs_igrab(inode);
+	bh->op = &erofs_write_inode_bhops;
+	inode->bh = bh;
+	return 0;
+}
+
+static bool erofs_bh_flush_write_inline(struct erofs_buffer_head *bh)
+{
+	struct erofs_inode *const inode = bh->fsprivate;
+	const erofs_off_t off = erofs_btell(bh, false);
+	int ret;
+
+	ret = dev_write(inode->idata, off, inode->idata_size);
+	if (ret)
+		return false;
+
+	inode->idata_size = 0;
+	free(inode->idata);
+	inode->idata = NULL;
+
+	erofs_iput(inode);
+	return erofs_bh_flush_generic_end(bh);
+}
+
+static struct erofs_bhops erofs_write_inline_bhops = {
+	.flush = erofs_bh_flush_write_inline,
+};
+
+int erofs_write_tail_end(struct erofs_inode *inode)
+{
+	struct erofs_buffer_head *bh, *ibh;
+
+	bh = inode->bh_data;
+
+	if (!inode->idata_size)
+		goto out;
+
+	/* have enough room to inline data */
+	if (inode->bh_inline) {
+		ibh = inode->bh_inline;
+
+		ibh->fsprivate = erofs_igrab(inode);
+		ibh->op = &erofs_write_inline_bhops;
+	} else {
+		int ret;
+		erofs_off_t off;
+
+		if (bh) {
+			/* expend a block (should be successful) */
+			ret = erofs_bh_balloon(bh, EROFS_BLKSIZ);
+			DBG_BUGON(ret);
+
+			erofs_mapbh(bh->block, true);
+			off = erofs_btell(bh, true) - EROFS_BLKSIZ;
+		} else {
+			bh = erofs_balloc(DATA, EROFS_BLKSIZ, 0, 0);
+			if (IS_ERR(bh))
+				return PTR_ERR(bh);
+
+			bh->op = &erofs_skip_write_bhops;
+			erofs_mapbh(bh->block, true);
+			off = erofs_btell(bh, false);
+			inode->u.i_blkaddr = erofs_blknr(off);
+			inode->bh_data = bh;
+		}
+
+		ret = dev_write(inode->idata, off, inode->idata_size);
+		if (ret)
+			return ret;
+
+		inode->idata_size = 0;
+		free(inode->idata);
+		inode->idata = NULL;
+	}
+out:
+	/* now bh_data can drop directly */
+	if (bh) {
+		/*
+		 * Don't leave DATA buffers which were written in the global
+		 * buffer list. It will make balloc() slowly.
+		 */
+#if 0
+		bh->op = &erofs_drop_directly_bhops;
+#else
+		erofs_bdrop(bh, false);
+#endif
+		inode->bh_data = NULL;
+	}
+	return 0;
+}
+
+int erofs_fill_inode(struct erofs_inode *inode,
+		     struct stat64 *st,
+		     const char *path)
+{
+	inode->i_mode = st->st_mode;
+	inode->i_uid = st->st_uid;
+	inode->i_gid = st->st_gid;
+	inode->i_nlink = 1;	/* fix up later if needed */
+
+	if (!S_ISDIR(inode->i_mode))
+		inode->i_size = st->st_size;
+	else
+		inode->i_size = 0;
+
+	strncpy(inode->i_srcpath, path, sizeof(inode->i_srcpath) - 1);
+	inode->i_srcpath[sizeof(inode->i_srcpath) - 1] = '\0';
+
+	inode->i_ino[1] = st->st_ino;
+	inode->inode_isize = sizeof(struct erofs_inode_v1);
+
+	list_add(&inode->i_hash,
+		 &inode_hashtable[st->st_ino % NR_INODE_HASHTABLE]);
+	return 0;
+}
+
+struct erofs_inode *erofs_new_inode(void)
+{
+	static unsigned int counter;
+	struct erofs_inode *inode;
+
+	inode = malloc(sizeof(struct erofs_inode));
+	if (!inode)
+		return ERR_PTR(-ENOMEM);
+
+	inode->i_parent = NULL;	/* also used to indicate a new inode */
+
+	inode->i_ino[0] = counter++;	/* inode serial number */
+	inode->i_count = 1;
+
+	init_list_head(&inode->i_subdirs);
+	inode->xattr_isize = 0;
+	inode->extent_isize = 0;
+
+	inode->bh = inode->bh_inline = inode->bh_data = NULL;
+	inode->idata = NULL;
+	return inode;
+}
+
+/* get the inode from the (source) path */
+struct erofs_inode *erofs_iget_from_path(const char *path, bool is_src)
+{
+	struct stat64 st;
+	struct erofs_inode *inode;
+	int ret;
+
+	/* currently, only source path is supported */
+	if (!is_src)
+		return ERR_PTR(-EINVAL);
+
+	ret = lstat64(path, &st);
+	if (ret)
+		return ERR_PTR(-errno);
+
+	inode = erofs_iget(st.st_ino);
+	if (inode)
+		return inode;
+
+	/* cannot find in the inode cache */
+	inode = erofs_new_inode();
+	if (IS_ERR(inode))
+		return inode;
+
+	ret = erofs_fill_inode(inode, &st, path);
+	if (ret)
+		return ERR_PTR(ret);
+
+	return inode;
+}
+
+erofs_nid_t erofs_lookupnid(struct erofs_inode *inode)
+{
+	struct erofs_buffer_block *const bb = inode->bh->block;
+	erofs_off_t off, meta_offset;
+
+	if (!inode->bh)
+		return inode->nid;
+
+	erofs_mapbh(bb, true);
+	off = erofs_btell(inode->bh, false);
+	meta_offset = blknr_to_addr(sbi.meta_blkaddr);
+
+	if (off - blknr_to_addr(sbi.meta_blkaddr) > 0xffff) {
+		if (IS_ROOT(inode)) {
+			meta_offset = round_up(off - 0xffff, EROFS_BLKSIZ);
+			sbi.meta_blkaddr = meta_offset / EROFS_BLKSIZ;
+		}
+	}
+	return inode->nid = (off - meta_offset) >> EROFS_ISLOTBITS;
+}
+
+void erofs_d_invalidate(struct erofs_dentry *d)
+{
+	struct erofs_inode *const inode = d->inode;
+
+	d->nid = erofs_lookupnid(inode);
+	erofs_iput(inode);
+}
+
+struct erofs_inode *erofs_mkfs_build_tree(struct erofs_inode *dir)
+{
+	int ret;
+	DIR *_dir;
+	struct dirent *dp;
+	struct erofs_dentry *d;
+
+	if (!S_ISDIR(dir->i_mode)) {
+		if (S_ISLNK(dir->i_mode)) {
+			char *const symlink = malloc(dir->i_size);
+
+			ret = readlink(dir->i_srcpath, symlink, dir->i_size);
+			if (ret < 0)
+				return ERR_PTR(-errno);
+
+			erofs_write_file_from_buffer(dir, symlink);
+			free(symlink);
+		} else {
+			erofs_write_file(dir);
+		}
+
+		erofs_prepare_inode_buffer(dir);
+		erofs_write_tail_end(dir);
+		return dir;
+	}
+
+	_dir = opendir(dir->i_srcpath);
+	if (!_dir) {
+		erofs_err("%s, failed to opendir at %s: %s",
+			  __func__, dir->i_srcpath, erofs_strerror(errno));
+		return ERR_PTR(-errno);
+	}
+
+	while (1) {
+		/*
+		 * set errno to 0 before calling readdir() in order to
+		 * distinguish end of stream and from an error.
+		 */
+		errno = 0;
+		dp = readdir(_dir);
+		if (!dp)
+			break;
+
+		if (is_dot_dotdot(dp->d_name) ||
+		    !strncmp(dp->d_name, "lost+found", strlen("lost+found")))
+			continue;
+
+		d = erofs_d_alloc(dir, dp->d_name);
+		if (IS_ERR(d)) {
+			ret = PTR_ERR(d);
+			goto err_closedir;
+		}
+	}
+
+	if (errno) {
+		ret = -errno;
+		goto err_closedir;
+	}
+	closedir(_dir);
+
+	erofs_prepare_dir_file(dir);
+	erofs_prepare_inode_buffer(dir);
+
+	list_for_each_entry(d, &dir->i_subdirs, d_child) {
+		char buf[PATH_MAX];
+
+		if (is_dot_dotdot(d->name)) {
+			erofs_d_invalidate(d);
+			continue;
+		}
+
+		ret = snprintf(buf, PATH_MAX, "%s/%s",
+			       dir->i_srcpath, d->name);
+		if (ret < 0 || ret >= PATH_MAX) {
+			/* ignore the too long path */
+			goto fail;
+		}
+
+		d->inode = erofs_mkfs_build_tree_from_path(dir, buf);
+		if (IS_ERR(d->inode)) {
+fail:
+			d->inode = NULL;
+			d->type = EROFS_FT_UNKNOWN;
+			continue;
+		}
+
+		d->type = erofs_type_by_mode[d->inode->i_mode >> S_SHIFT];
+		erofs_d_invalidate(d);
+		erofs_info("add file %s/%s (nid %lu, type %d)",
+			   dir->i_srcpath, d->name, d->nid, d->type);
+	}
+	erofs_write_dir_file(dir);
+	erofs_write_tail_end(dir);
+	return dir;
+
+err_closedir:
+	closedir(_dir);
+	return ERR_PTR(ret);
+}
+
+struct erofs_inode *erofs_mkfs_build_tree_from_path(struct erofs_inode *parent,
+						    const char *path)
+{
+	struct erofs_inode *const inode = erofs_iget_from_path(path, true);
+
+	if (IS_ERR(inode))
+		return inode;
+
+	/* a hardlink to the existed inode */
+	if (inode->i_parent) {
+		++inode->i_nlink;
+		return inode;
+	}
+
+	/* a completely new inode is found */
+	if (parent)
+		inode->i_parent = parent;
+	else
+		inode->i_parent = inode;	/* rootdir mark */
+
+	return erofs_mkfs_build_tree(inode);
+}
+
-- 
2.17.1

