Return-Path: <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>
X-Original-To: lists+linux-erofs@lfdr.de
Delivered-To: lists+linux-erofs@lfdr.de
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2401:3900:2:1::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 97318305ED
	for <lists+linux-erofs@lfdr.de>; Fri, 31 May 2019 02:51:50 +0200 (CEST)
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2401:3900:2:1::3])
	by lists.ozlabs.org (Postfix) with ESMTP id 45FQrM6c5kzDqTL
	for <lists+linux-erofs@lfdr.de>; Fri, 31 May 2019 10:51:47 +1000 (AEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=lists.ozlabs.org;
	s=201707; t=1559263907;
	bh=OECq1TBmoRB3XEHtjqNfa+vXnoDRuiEk0IgWk99wpWQ=;
	h=To:Subject:Date:In-Reply-To:References:List-Id:List-Unsubscribe:
	 List-Archive:List-Post:List-Help:List-Subscribe:From:Reply-To:Cc:
	 From;
	b=oO7da5maALjJ5N3MPrC88Sgcxh+g1OHnUAwdOMGKS0KDT6rhFF2I1rG8F5TugaYo/
	 nvupzABSCXCxe3mlrcxfaH1rqjg/WtIdDfKa7O+bHyAuMq4GJ0XYsoheYXtAG0iM8E
	 LJNclkAAQ4EggEjzMx3CH5nhiFaNx6IerJg6Y64PK+6NlEkFg073uBA19qLiBqJhvT
	 QlM81rXIyNSNZ/m62iKaqez9J82qMBYAgW2LrsOiB75FVfqQ+xXUd2wOPmxubICXf5
	 E1Z8Zf4tq+9devmJOJtGvUpno03lxh/R/mUlltO+iqhKkWv1RGqQVcxQD19PJUGh9f
	 O46qlaomNt8yg==
X-Original-To: linux-erofs@lists.ozlabs.org
Delivered-To: linux-erofs@lists.ozlabs.org
Authentication-Results: lists.ozlabs.org;
 spf=pass (mailfrom) smtp.mailfrom=aol.com
 (client-ip=98.137.68.206; helo=sonic304-25.consmr.mail.gq1.yahoo.com;
 envelope-from=hsiangkao@aol.com; receiver=<UNKNOWN>)
Authentication-Results: lists.ozlabs.org;
 dmarc=pass (p=reject dis=none) header.from=aol.com
Authentication-Results: lists.ozlabs.org; dkim=pass (2048-bit key;
 unprotected) header.d=aol.com header.i=@aol.com header.b="rVLefuKF"; 
 dkim-atps=neutral
Received: from sonic304-25.consmr.mail.gq1.yahoo.com
 (sonic304-25.consmr.mail.gq1.yahoo.com [98.137.68.206])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 45FQqx50lXzDqT2
 for <linux-erofs@lists.ozlabs.org>; Fri, 31 May 2019 10:51:25 +1000 (AEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=aol.com; s=a2048;
 t=1559263882; bh=KONZ+Tf+RGGVrH/wxPuiOAIpRlRWWGLcDuKnOK7FvW0=;
 h=From:To:Cc:Subject:Date:In-Reply-To:References:From:Subject;
 b=rVLefuKFWSslEj94Lneb8qafU48IxXb+ViiKgxOT1vYEWvPsKpP/pXeDZWfF0zoxvBneF3uL1eSiVsqUI8LzyGaUPhC68PXdKZuexvolzqYFCY+XGcQ/7LqanYtKC6xdKGctB46PmpUSIWu38xaf3hl99ofrhsc3w/l6a5hJoAus0B9Yd/ykXPal8NmfSrOjsytufDXhuDKMoJ0UBzD2Qsz55kE99XTTDLRnbZJRLbAS2hIfUdpUgbQIYqqCN+eFXuy8lQOAhtV7+ri/GWf+WcygLAY1P/mVnwDTdxMW4iBRoldf8Fxghi8dTse0eJ+5jgJ9FJA/mQKVnRXoc9UzPA==
X-YMail-OSG: YQA9PVIVM1nrNg9YCO3i1P_FGK_NwiVOZto.NBZQu7Ejsy_pt6WF1A5dyPew0eA
 eAa52zNf1n2OXI9Vr7mpa1EGatSMvzLxalqleByZUydmIP._IE4Zw74QuG.ZX_ctct887AolaO.c
 va3H8sdzIjpEzB.MQZWYWt48_h02SmOamgdUcMx7uOC0erMLVialhK_JmN8nAHz0XqSksQm2tzVt
 sabYvxypmR5t5K3rxB59t5M8puNAaiHUJwkG5avXYfiULK_0RaSZ3mJEjSE2hEwLHZKI1mq6TBSA
 IdScU5zloNF65.o6bNtzDdsUhYMsp58An6pv04jBRxMl5YyCKZ0PW9r7_XLHWJVk2.VHKXxxEwoq
 FFYv8cTsJN8YvJA06CyJJAMP7qNZYWsGXC0zsW.GSjxAy8xx90ZGCx4fO4IEQOplLK57P8absR5C
 e5ZRNRfIV9_pwQb4eCNZHIv_kbWF5a2gqg1OUOkCsjLog.RwL6EEplH4kqouesmyuPLBUcSvqiZ4
 FEJCpsPdTj7giqK4_uW7AykYZ_k_BGWjBjq3vA_9FLBs6GwXLNjWmu6yQBk3rwySCMQ48HcKBMVJ
 Y7A6C.n7AcN.wpZAszeba01dICD1MaNOJgKolsDxOfCqIZQzKeCCxp0OpmJpKxtPEnlGb_adt.Gq
 lNnlSjZKQkv90XOpqV2a10A5yrxw6Bd5fVEuE2psEfHIJgmfj6Z0ATrF6rRgtVFSvK8Aj7pWHWOn
 4stMOLrO3mJkHiVqZzYvYCYornX5b6w65hV79tg5PiUMcK0vIEVuLNRTN2s6yZWLo5cqkr0_oa3i
 msb53hia6U0eXZDQOeg73A9gs00UTCSEky4trBVe264svdDAYMcTi7U9Fzz6fg7yExFduuMV9jay
 jmWGqiqNXYZhM9isP.o.shp7pr5uxLy0YA_5W8JF9DFHVMSdMy125gTm9nOyGicD1pmUE6M8cuRm
 1oQ40Q0DXwTw46VSDv51mPlkra.wHQyEUeYucDlxKYxlRljuKKv4PzCRdxCQMMwemEvd4aFY1Awp
 IixmLSlrDahgkV_9LjnxraE6T4_ikUNkoeJrXG4v2LIPNYi.WURin.v_OJDeC_WbWa1Er2wJnoWc
 6xsQTE3agxJgJqt4aaPs.STVMILuwx8MbOvfSr4PA_e6x5ZDZLibZptu3L7Nw80Z4x3lnc0XPhmA
 zIGjH6qZia3zsZ8Yk_PmdEcjCD3U3xyeRQ0REKVR9DYG4qti8Tq4joeVhf1lSr36rlU8g
Received: from sonic.gate.mail.ne1.yahoo.com by
 sonic304.consmr.mail.gq1.yahoo.com with HTTP; Fri, 31 May 2019 00:51:22 +0000
Received: from 125.120.86.223 (EHLO localhost.localdomain) ([125.120.86.223])
 by smtp417.mail.gq1.yahoo.com (Oath Hermes SMTP Server) with ESMTPA
 ID a9e989b6e54ef4fb7ecb5a20a6091749; 
 Fri, 31 May 2019 00:51:21 +0000 (UTC)
To: linux-erofs@lists.ozlabs.org
Subject: [PATCH 05/13] erofs-utils: introduce buffer cache
Date: Fri, 31 May 2019 08:50:39 +0800
Message-Id: <20190531005047.22093-6-hsiangkao@aol.com>
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
Cc: Miao Xie <miaoxie@huawei.com>
Errors-To: linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org
Sender: "Linux-erofs"
 <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>

From: Gao Xiang <gaoxiang25@huawei.com>

This patch adds a buffer cache mainly to manage
incomplete metadata blocks. mkfs logic is also
simplified with the help of buffer cache.

Signed-off-by: Miao Xie <miaoxie@huawei.com>
[ Gao Xiang: with heavy changes. ]
Signed-off-by: Gao Xiang <gaoxiang25@huawei.com>
---
 include/erofs/cache.h | 104 +++++++++++++
 lib/Makefile.am       |   2 +-
 lib/cache.c           | 343 ++++++++++++++++++++++++++++++++++++++++++
 3 files changed, 448 insertions(+), 1 deletion(-)
 create mode 100644 include/erofs/cache.h
 create mode 100644 lib/cache.c

diff --git a/include/erofs/cache.h b/include/erofs/cache.h
new file mode 100644
index 0000000..108757a
--- /dev/null
+++ b/include/erofs/cache.h
@@ -0,0 +1,104 @@
+/* SPDX-License-Identifier: GPL-2.0+ */
+/*
+ * erofs_utils/include/erofs/cache.h
+ *
+ * Copyright (C) 2018 HUAWEI, Inc.
+ *             http://www.huawei.com/
+ * Created by Miao Xie <miaoxie@huawei.com>
+ * with heavy changes by Gao Xiang <gaoxiang25@huawei.com>
+ */
+#ifndef __EROFS_CACHE_H
+#define __EROFS_CACHE_H
+
+#include "internal.h"
+
+struct erofs_buffer_head;
+struct erofs_buffer_block;
+
+#define DATA		0
+#define META		1
+/* including inline xattrs, extent */
+#define INODE		2
+/* shared xattrs */
+#define XATTR		3
+
+struct erofs_bhops {
+	bool (*preflush)(struct erofs_buffer_head *bh);
+	bool (*flush)(struct erofs_buffer_head *bh);
+};
+
+struct erofs_buffer_head {
+	struct list_head list;
+	struct erofs_buffer_block *block;
+
+	unsigned int off;
+	struct erofs_bhops *op;
+
+	void *fsprivate;
+};
+
+struct erofs_buffer_block {
+	struct list_head list;
+
+	erofs_blk_t blkaddr;
+	int type;
+
+	struct erofs_buffer_head buffers;
+};
+
+static inline const int get_alignsize(int type, int *type_ret)
+{
+	if (type == DATA)
+		return EROFS_BLKSIZ;
+
+	if (type == INODE) {
+		*type_ret = META;
+		return sizeof(struct erofs_inode_v1);
+	} else if (type == XATTR) {
+		*type_ret = META;
+		return sizeof(struct erofs_xattr_entry);
+	}
+
+	if (type == META)
+		return 1;
+	return -EINVAL;
+}
+
+extern struct erofs_bhops erofs_drop_directly_bhops;
+extern struct erofs_bhops erofs_skip_write_bhops;
+extern struct erofs_bhops erofs_buf_write_bhops;
+
+static inline erofs_off_t erofs_btell(struct erofs_buffer_head *bh, bool end)
+{
+	const struct erofs_buffer_block *bb = bh->block;
+
+	if (bb->blkaddr == NULL_ADDR)
+		return NULL_ADDR_UL;
+
+	return blknr_to_addr(bb->blkaddr) +
+		(end ? list_next_entry(bh, list)->off : bh->off);
+}
+
+static inline bool erofs_bh_flush_generic_end(struct erofs_buffer_head *bh)
+{
+	list_del(&bh->list);
+	free(bh);
+	return true;
+}
+
+struct erofs_buffer_head *erofs_buffer_init(void);
+int erofs_bh_balloon(struct erofs_buffer_head *bh, unsigned int incr);
+
+struct erofs_buffer_head *erofs_balloc(int type, unsigned int size,
+				       unsigned int required_ext,
+				       unsigned int inline_ext);
+struct erofs_buffer_head *erofs_battach(struct erofs_buffer_head *bh,
+					int type, int size);
+
+erofs_blk_t erofs_mapbh(struct erofs_buffer_block *bb, bool end);
+bool erofs_bflush(struct erofs_buffer_block *bb);
+
+void erofs_bdrop(struct erofs_buffer_head *bh, bool tryrevoke);
+
+#endif
+
diff --git a/lib/Makefile.am b/lib/Makefile.am
index a2c1b24..8508660 100644
--- a/lib/Makefile.am
+++ b/lib/Makefile.am
@@ -2,6 +2,6 @@
 # Makefile.am
 
 noinst_LTLIBRARIES = liberofs.la
-liberofs_la_SOURCES = config.c io.c
+liberofs_la_SOURCES = config.c io.c cache.c
 liberofs_la_CFLAGS = -Wall -Werror -I$(top_srcdir)/include
 
diff --git a/lib/cache.c b/lib/cache.c
new file mode 100644
index 0000000..967b543
--- /dev/null
+++ b/lib/cache.c
@@ -0,0 +1,343 @@
+// SPDX-License-Identifier: GPL-2.0+
+/*
+ * erofs_utils/lib/cache.c
+ *
+ * Copyright (C) 2018-2019 HUAWEI, Inc.
+ *             http://www.huawei.com/
+ * Created by Miao Xie <miaoxie@huawei.com>
+ * with heavy changes by Gao Xiang <gaoxiang25@huawei.com>
+ */
+#include <stdlib.h>
+#include <erofs/cache.h>
+#include "erofs/io.h"
+#include "erofs/print.h"
+
+static struct erofs_buffer_block blkh = {
+	.list = LIST_HEAD_INIT(blkh.list),
+	.blkaddr = NULL_ADDR,
+};
+static erofs_blk_t tail_blkaddr;
+
+static bool erofs_bh_flush_drop_directly(struct erofs_buffer_head *bh)
+{
+	return erofs_bh_flush_generic_end(bh);
+}
+
+struct erofs_bhops erofs_drop_directly_bhops = {
+	.flush = erofs_bh_flush_drop_directly,
+};
+
+static bool erofs_bh_flush_skip_write(struct erofs_buffer_head *bh)
+{
+	return false;
+}
+
+struct erofs_bhops erofs_skip_write_bhops = {
+	.flush = erofs_bh_flush_skip_write,
+};
+
+int erofs_bh_flush_generic_write(struct erofs_buffer_head *bh, void *buf)
+{
+	struct erofs_buffer_head *nbh = list_next_entry(bh, list);
+	erofs_off_t offset = erofs_btell(bh, false);
+
+	DBG_BUGON(nbh->off < bh->off);
+	return dev_write(buf, offset, nbh->off - bh->off);
+}
+
+static bool erofs_bh_flush_buf_write(struct erofs_buffer_head *bh)
+{
+	int err = erofs_bh_flush_generic_write(bh, bh->fsprivate);
+
+	if (err)
+		return false;
+	free(bh->fsprivate);
+	return erofs_bh_flush_generic_end(bh);
+}
+
+struct erofs_bhops erofs_buf_write_bhops = {
+	.flush = erofs_bh_flush_buf_write,
+};
+
+/* return buffer_head of erofs super block (with size 0) */
+struct erofs_buffer_head *erofs_buffer_init(void)
+{
+	struct erofs_buffer_head *bh = erofs_balloc(META, 0, 0, 0);
+
+	if (IS_ERR(bh))
+		return bh;
+
+	bh->op = &erofs_skip_write_bhops;
+	return bh;
+}
+
+/* return occupied bytes in specific buffer block if succeed */
+static int __erofs_battach(struct erofs_buffer_block *bb,
+			   struct erofs_buffer_head *bh,
+			   unsigned int incr,
+			   unsigned int alignsize,
+			   unsigned int extrasize,
+			   bool dryrun)
+{
+	const unsigned int alignedoffset = roundup(bb->buffers.off, alignsize);
+	const int oob = alignedoffset + incr + extrasize -
+			roundup(bb->buffers.off + 1, EROFS_BLKSIZ);
+	bool tailupdate = false;
+	erofs_blk_t blkaddr;
+
+	if (oob >= 0) {
+		/* the next buffer block should be NULL_ADDR all the time */
+		if (oob && list_next_entry(bb, list)->blkaddr != NULL_ADDR)
+			return -EINVAL;
+
+		blkaddr = bb->blkaddr;
+		if (blkaddr != NULL_ADDR) {
+			tailupdate = (tail_blkaddr == blkaddr +
+				      BLK_ROUND_UP(bb->buffers.off));
+			if (oob && !tailupdate)
+				return -EINVAL;
+		}
+	}
+
+	if (!dryrun) {
+		if (bh) {
+			bh->off = alignedoffset;
+			bh->block = bb;
+			list_add_tail(&bh->list, &bb->buffers.list);
+		}
+		bb->buffers.off = alignedoffset + incr;
+		/* need to update the tail_blkaddr */
+		if (tailupdate)
+			tail_blkaddr = blkaddr + BLK_ROUND_UP(bb->buffers.off);
+	}
+	return (alignedoffset + incr) % EROFS_BLKSIZ;
+}
+
+int erofs_bh_balloon(struct erofs_buffer_head *bh, unsigned int incr)
+{
+	struct erofs_buffer_block *const bb = bh->block;
+
+	/* should be the tail bh in the corresponding buffer block */
+	if (bh->list.next != &bb->buffers.list)
+		return -EINVAL;
+
+	return __erofs_battach(bb, NULL, incr, 1, 0, false);
+}
+
+struct erofs_buffer_head *erofs_balloc(int type, unsigned int size,
+				       unsigned int required_ext,
+				       unsigned int inline_ext)
+{
+	struct erofs_buffer_block *cur, *bb;
+	struct erofs_buffer_head *bh;
+	unsigned int alignsize, used0, usedmax;
+
+	int ret = get_alignsize(type, &type);
+
+	if (ret < 0)
+		return ERR_PTR(ret);
+	alignsize = ret;
+
+	used0 = (size + required_ext) % EROFS_BLKSIZ + inline_ext;
+	usedmax = 0;
+	bb = NULL;
+
+	list_for_each_entry(cur, &blkh.list, list) {
+		unsigned int used_before, used;
+
+		used_before = cur->buffers.off % EROFS_BLKSIZ;
+
+		/* skip if buffer block is just full */
+		if (!used_before)
+			continue;
+
+		/* skip if the entry which has different type */
+		if (cur->type != type)
+			continue;
+
+		ret = __erofs_battach(cur, NULL, size, alignsize,
+				      required_ext + inline_ext, true);
+		if (ret < 0)
+			continue;
+
+		used = (ret + required_ext) % EROFS_BLKSIZ + inline_ext;
+
+		/* should contain inline data in current block */
+		if (used > EROFS_BLKSIZ)
+			continue;
+
+		/*
+		 * remaining should be smaller than before or
+		 * larger than allocating a new buffer block
+		 */
+		if (used < used_before && used < used0)
+			continue;
+
+		if (usedmax < used) {
+			bb = cur;
+			usedmax = used;
+		}
+	}
+
+	if (bb) {
+		bh = malloc(sizeof(struct erofs_buffer_head));
+		if (!bh)
+			return ERR_PTR(-ENOMEM);
+		goto found;
+	}
+
+	/* allocate a new buffer block */
+	if (used0 > EROFS_BLKSIZ)
+		return ERR_PTR(-ENOSPC);
+
+	bb = malloc(sizeof(struct erofs_buffer_block));
+	if (!bb)
+		return ERR_PTR(-ENOMEM);
+
+	bb->type = type;
+	bb->blkaddr = NULL_ADDR;
+	bb->buffers.off = 0;
+	init_list_head(&bb->buffers.list);
+	list_add_tail(&bb->list, &blkh.list);
+
+	bh = malloc(sizeof(struct erofs_buffer_head));
+	if (!bh) {
+		free(bb);
+		return ERR_PTR(-ENOMEM);
+	}
+found:
+	ret = __erofs_battach(bb, bh, size, alignsize,
+			      required_ext + inline_ext, false);
+	if (ret < 0)
+		return ERR_PTR(ret);
+	return bh;
+}
+
+struct erofs_buffer_head *erofs_battach(struct erofs_buffer_head *bh,
+					int type, int size)
+{
+	struct erofs_buffer_block *const bb = bh->block;
+	struct erofs_buffer_head *nbh;
+	unsigned int alignsize;
+	int ret = get_alignsize(type, &type);
+
+	if (ret < 0)
+		return ERR_PTR(ret);
+	alignsize = ret;
+
+	/* should be the tail bh in the corresponding buffer block */
+	if (bh->list.next != &bb->buffers.list)
+		return ERR_PTR(-EINVAL);
+
+	nbh = malloc(sizeof(*nbh));
+	if (!nbh)
+		return ERR_PTR(-ENOMEM);
+
+	ret = __erofs_battach(bb, nbh, size, alignsize, 0, false);
+	if (ret < 0) {
+		free(nbh);
+		return ERR_PTR(ret);
+	}
+	return nbh;
+
+}
+
+static erofs_blk_t __erofs_mapbh(struct erofs_buffer_block *bb)
+{
+	erofs_blk_t blkaddr;
+
+	if (bb->blkaddr == NULL_ADDR)
+		bb->blkaddr = tail_blkaddr;
+
+	blkaddr = bb->blkaddr + BLK_ROUND_UP(bb->buffers.off);
+	if (blkaddr > tail_blkaddr)
+		tail_blkaddr = blkaddr;
+
+	return blkaddr;
+}
+
+erofs_blk_t erofs_mapbh(struct erofs_buffer_block *bb, bool end)
+{
+	struct erofs_buffer_block *t, *nt;
+
+	if (!bb || bb->blkaddr == NULL_ADDR) {
+		list_for_each_entry_safe(t, nt, &blkh.list, list) {
+			if (!end && (t == bb || nt == &blkh))
+				break;
+			(void)__erofs_mapbh(t);
+			if (end && t == bb)
+				break;
+		}
+	}
+	return tail_blkaddr;
+}
+
+bool erofs_bflush(struct erofs_buffer_block *bb)
+{
+	static const char zero[EROFS_BLKSIZ] = {0};
+	struct erofs_buffer_block *p, *n;
+	erofs_blk_t blkaddr;
+
+	list_for_each_entry_safe(p, n, &blkh.list, list) {
+		struct erofs_buffer_head *bh, *nbh;
+		unsigned int padding;
+		bool skip = false;
+
+		if (p == bb)
+			break;
+
+		/* check if the buffer block can flush */
+		list_for_each_entry(bh, &p->buffers.list, list)
+			if (bh->op->preflush && !bh->op->preflush(bh))
+				return false;
+
+		blkaddr = __erofs_mapbh(p);
+
+		list_for_each_entry_safe(bh, nbh, &p->buffers.list, list) {
+			/* flush and remove bh */
+			if (!bh->op->flush(bh))
+				skip = true;
+		}
+
+		if (skip)
+			continue;
+
+		padding = EROFS_BLKSIZ - p->buffers.off % EROFS_BLKSIZ;
+		if (padding != EROFS_BLKSIZ)
+			dev_write(zero, blknr_to_addr(blkaddr) - padding,
+				  padding);
+
+		DBG_BUGON(!list_empty(&p->buffers.list));
+
+		erofs_dbg("block %u to %u flushed", p->blkaddr, blkaddr - 1);
+
+		list_del(&p->list);
+		free(p);
+	}
+	return true;
+}
+
+void erofs_bdrop(struct erofs_buffer_head *bh, bool tryrevoke)
+{
+	struct erofs_buffer_block *const bb = bh->block;
+	const erofs_blk_t blkaddr = bh->block->blkaddr;
+	bool rollback = false;
+
+	/* tail_blkaddr could be rolled back after revoking all bhs */
+	if (tryrevoke && blkaddr != NULL_ADDR &&
+	    tail_blkaddr == blkaddr + BLK_ROUND_UP(bb->buffers.off))
+		rollback = true;
+
+	bh->op = &erofs_drop_directly_bhops;
+	erofs_bh_flush_generic_end(bh);
+
+	if (!list_empty(&bb->buffers.list))
+		return;
+
+	list_del(&bb->list);
+	free(bb);
+
+	if (rollback)
+		tail_blkaddr = blkaddr;
+}
+
-- 
2.17.1

