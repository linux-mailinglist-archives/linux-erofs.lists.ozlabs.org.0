Return-Path: <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>
X-Original-To: lists+linux-erofs@lfdr.de
Delivered-To: lists+linux-erofs@lfdr.de
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2401:3900:2:1::3])
	by mail.lfdr.de (Postfix) with ESMTPS id D9FF565A0C
	for <lists+linux-erofs@lfdr.de>; Thu, 11 Jul 2019 17:09:04 +0200 (CEST)
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2401:3900:2:1::3])
	by lists.ozlabs.org (Postfix) with ESMTP id 45kzwZ14TRzDqS1
	for <lists+linux-erofs@lfdr.de>; Fri, 12 Jul 2019 01:09:02 +1000 (AEST)
X-Original-To: linux-erofs@lists.ozlabs.org
Delivered-To: linux-erofs@lists.ozlabs.org
Authentication-Results: lists.ozlabs.org;
 spf=pass (mailfrom) smtp.mailfrom=huawei.com
 (client-ip=45.249.212.190; helo=huawei.com;
 envelope-from=gaoxiang25@huawei.com; receiver=<UNKNOWN>)
Authentication-Results: lists.ozlabs.org;
 dmarc=none (p=none dis=none) header.from=huawei.com
Received: from huawei.com (szxga04-in.huawei.com [45.249.212.190])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 45kzhY2SNhzDqQq
 for <linux-erofs@lists.ozlabs.org>; Fri, 12 Jul 2019 00:58:36 +1000 (AEST)
Received: from DGGEMS409-HUB.china.huawei.com (unknown [172.30.72.58])
 by Forcepoint Email with ESMTP id 5C0D93D75B48E1E60CE8;
 Thu, 11 Jul 2019 22:58:33 +0800 (CST)
Received: from architecture4.huawei.com (10.140.130.215) by smtp.huawei.com
 (10.3.19.209) with Microsoft SMTP Server (TLS) id 14.3.439.0; Thu, 11 Jul
 2019 22:58:25 +0800
From: Gao Xiang <gaoxiang25@huawei.com>
To: Alexander Viro <viro@zeniv.linux.org.uk>, Greg Kroah-Hartman
 <gregkh@linuxfoundation.org>, Andrew Morton <akpm@linux-foundation.org>,
 Theodore Ts'o <tytso@mit.edu>, Linus Torvalds <torvalds@linux-foundation.org>
Subject: [PATCH v2 09/24] erofs: support tracepoint
Date: Thu, 11 Jul 2019 22:57:40 +0800
Message-ID: <20190711145755.33908-10-gaoxiang25@huawei.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20190711145755.33908-1-gaoxiang25@huawei.com>
References: <20190711145755.33908-1-gaoxiang25@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.140.130.215]
X-CFilter-Loop: Reflected
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
Cc: devel@driverdev.osuosl.org, linux-erofs@lists.ozlabs.org,
 LKML <linux-kernel@vger.kernel.org>, linux-fsdevel@vger.kernel.org,
 Miao Xie <miaoxie@huawei.com>
Errors-To: linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org
Sender: "Linux-erofs"
 <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>

Add basic tracepoints for ->readpage{,s}, ->lookup,
->destroy_inode, fill_inode and map_blocks.

Signed-off-by: Gao Xiang <gaoxiang25@huawei.com>
---
 include/trace/events/erofs.h | 241 +++++++++++++++++++++++++++++++++++
 1 file changed, 241 insertions(+)
 create mode 100644 include/trace/events/erofs.h

diff --git a/include/trace/events/erofs.h b/include/trace/events/erofs.h
new file mode 100644
index 000000000000..188c28e48289
--- /dev/null
+++ b/include/trace/events/erofs.h
@@ -0,0 +1,241 @@
+/* SPDX-License-Identifier: GPL-2.0 */
+#undef TRACE_SYSTEM
+#define TRACE_SYSTEM erofs
+
+#if !defined(_TRACE_EROFS_H) || defined(TRACE_HEADER_MULTI_READ)
+#define _TRACE_EROFS_H
+
+#include <linux/tracepoint.h>
+
+#define show_dev(dev)		MAJOR(dev), MINOR(dev)
+#define show_dev_nid(entry)	show_dev(entry->dev), entry->nid
+
+#define show_file_type(type)						\
+	__print_symbolic(type,						\
+		{ 0,		"FILE" },				\
+		{ 1,		"DIR" })
+
+#define show_map_flags(flags) __print_flags(flags, "|",	\
+	{ EROFS_GET_BLOCKS_RAW,	"RAW" })
+
+#define show_mflags(flags) __print_flags(flags, "",	\
+	{ EROFS_MAP_MAPPED,	"M" },			\
+	{ EROFS_MAP_META,	"I" })
+
+TRACE_EVENT(erofs_lookup,
+
+	TP_PROTO(struct inode *dir, struct dentry *dentry, unsigned int flags),
+
+	TP_ARGS(dir, dentry, flags),
+
+	TP_STRUCT__entry(
+		__field(dev_t,		dev	)
+		__field(erofs_nid_t,	nid	)
+		__field(const char *,	name	)
+		__field(unsigned int,	flags	)
+	),
+
+	TP_fast_assign(
+		__entry->dev	= dir->i_sb->s_dev;
+		__entry->nid	= EROFS_V(dir)->nid;
+		__entry->name	= dentry->d_name.name;
+		__entry->flags	= flags;
+	),
+
+	TP_printk("dev = (%d,%d), pnid = %llu, name:%s, flags:%x",
+		show_dev_nid(__entry),
+		__entry->name,
+		__entry->flags)
+);
+
+TRACE_EVENT(erofs_fill_inode,
+	TP_PROTO(struct inode *inode, int isdir),
+	TP_ARGS(inode, isdir),
+
+	TP_STRUCT__entry(
+		__field(dev_t,		dev	)
+		__field(erofs_nid_t,	nid	)
+		__field(erofs_blk_t,	blkaddr )
+		__field(unsigned int,	ofs	)
+		__field(int,		isdir	)
+	),
+
+	TP_fast_assign(
+		__entry->dev		= inode->i_sb->s_dev;
+		__entry->nid		= EROFS_V(inode)->nid;
+		__entry->blkaddr	= erofs_blknr(iloc(EROFS_I_SB(inode), __entry->nid));
+		__entry->ofs		= erofs_blkoff(iloc(EROFS_I_SB(inode), __entry->nid));
+		__entry->isdir		= isdir;
+	),
+
+	TP_printk("dev = (%d,%d), nid = %llu, blkaddr %u ofs %u, isdir %d",
+		  show_dev_nid(__entry),
+		  __entry->blkaddr, __entry->ofs,
+		  __entry->isdir)
+);
+
+TRACE_EVENT(erofs_readpage,
+
+	TP_PROTO(struct page *page, bool raw),
+
+	TP_ARGS(page, raw),
+
+	TP_STRUCT__entry(
+		__field(dev_t,		dev	)
+		__field(erofs_nid_t,    nid     )
+		__field(int,		dir	)
+		__field(pgoff_t,	index	)
+		__field(int,		uptodate)
+		__field(bool,		raw	)
+	),
+
+	TP_fast_assign(
+		__entry->dev	= page->mapping->host->i_sb->s_dev;
+		__entry->nid	= EROFS_V(page->mapping->host)->nid;
+		__entry->dir	= S_ISDIR(page->mapping->host->i_mode);
+		__entry->index	= page->index;
+		__entry->uptodate = PageUptodate(page);
+		__entry->raw = raw;
+	),
+
+	TP_printk("dev = (%d,%d), nid = %llu, %s, index = %lu, uptodate = %d "
+		"raw = %d",
+		show_dev_nid(__entry),
+		show_file_type(__entry->dir),
+		(unsigned long)__entry->index,
+		__entry->uptodate,
+		__entry->raw)
+);
+
+TRACE_EVENT(erofs_readpages,
+
+	TP_PROTO(struct inode *inode, struct page *page, unsigned int nrpage,
+		bool raw),
+
+	TP_ARGS(inode, page, nrpage, raw),
+
+	TP_STRUCT__entry(
+		__field(dev_t,		dev	)
+		__field(erofs_nid_t,	nid	)
+		__field(pgoff_t,	start	)
+		__field(unsigned int,	nrpage	)
+		__field(bool,		raw	)
+	),
+
+	TP_fast_assign(
+		__entry->dev	= inode->i_sb->s_dev;
+		__entry->nid	= EROFS_V(inode)->nid;
+		__entry->start	= page->index;
+		__entry->nrpage	= nrpage;
+		__entry->raw	= raw;
+	),
+
+	TP_printk("dev = (%d,%d), nid = %llu, start = %lu nrpage = %u raw = %d",
+		show_dev_nid(__entry),
+		(unsigned long)__entry->start,
+		__entry->nrpage,
+		__entry->raw)
+);
+
+DECLARE_EVENT_CLASS(erofs__map_blocks_enter,
+	TP_PROTO(struct inode *inode, struct erofs_map_blocks *map,
+		 unsigned int flags),
+
+	TP_ARGS(inode, map, flags),
+
+	TP_STRUCT__entry(
+		__field(	dev_t,		dev		)
+		__field(	erofs_nid_t,	nid		)
+		__field(	erofs_off_t,	la		)
+		__field(	u64,		llen		)
+		__field(	unsigned int,	flags		)
+	),
+
+	TP_fast_assign(
+		__entry->dev    = inode->i_sb->s_dev;
+		__entry->nid    = EROFS_V(inode)->nid;
+		__entry->la	= map->m_la;
+		__entry->llen	= map->m_llen;
+		__entry->flags	= flags;
+	),
+
+	TP_printk("dev = (%d,%d), nid = %llu, la %llu llen %llu flags %s",
+		  show_dev_nid(__entry),
+		  __entry->la, __entry->llen,
+		  __entry->flags ? show_map_flags(__entry->flags) : "NULL")
+);
+
+DEFINE_EVENT(erofs__map_blocks_enter, erofs_map_blocks_flatmode_enter,
+	TP_PROTO(struct inode *inode, struct erofs_map_blocks *map,
+		 unsigned flags),
+
+	TP_ARGS(inode, map, flags)
+);
+
+DECLARE_EVENT_CLASS(erofs__map_blocks_exit,
+	TP_PROTO(struct inode *inode, struct erofs_map_blocks *map,
+		 unsigned int flags, int ret),
+
+	TP_ARGS(inode, map, flags, ret),
+
+	TP_STRUCT__entry(
+		__field(	dev_t,		dev		)
+		__field(	erofs_nid_t,	nid		)
+		__field(        unsigned int,   flags           )
+		__field(	erofs_off_t,	la		)
+		__field(	erofs_off_t,	pa		)
+		__field(	u64,		llen		)
+		__field(	u64,		plen		)
+		__field(        unsigned int,	mflags		)
+		__field(	int,		ret		)
+	),
+
+	TP_fast_assign(
+		__entry->dev    = inode->i_sb->s_dev;
+		__entry->nid    = EROFS_V(inode)->nid;
+		__entry->flags	= flags;
+		__entry->la	= map->m_la;
+		__entry->pa	= map->m_pa;
+		__entry->llen	= map->m_llen;
+		__entry->plen	= map->m_plen;
+		__entry->mflags	= map->m_flags;
+		__entry->ret	= ret;
+	),
+
+	TP_printk("dev = (%d,%d), nid = %llu, flags %s "
+		  "la %llu pa %llu llen %llu plen %llu mflags %s ret %d",
+		  show_dev_nid(__entry),
+		  __entry->flags ? show_map_flags(__entry->flags) : "NULL",
+		  __entry->la, __entry->pa, __entry->llen, __entry->plen,
+		  show_mflags(__entry->mflags), __entry->ret)
+);
+
+DEFINE_EVENT(erofs__map_blocks_exit, erofs_map_blocks_flatmode_exit,
+	TP_PROTO(struct inode *inode, struct erofs_map_blocks *map,
+		 unsigned flags, int ret),
+
+	TP_ARGS(inode, map, flags, ret)
+);
+
+TRACE_EVENT(erofs_destroy_inode,
+	TP_PROTO(struct inode *inode),
+
+	TP_ARGS(inode),
+
+	TP_STRUCT__entry(
+		__field(	dev_t,		dev		)
+		__field(	erofs_nid_t,	nid		)
+	),
+
+	TP_fast_assign(
+		__entry->dev	= inode->i_sb->s_dev;
+		__entry->nid	= EROFS_V(inode)->nid;
+	),
+
+	TP_printk("dev = (%d,%d), nid = %llu", show_dev_nid(__entry))
+);
+
+#endif /* _TRACE_EROFS_H */
+
+ /* This part must be outside protection */
+#include <trace/define_trace.h>
-- 
2.17.1

