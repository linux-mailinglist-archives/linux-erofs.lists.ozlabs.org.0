Return-Path: <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>
X-Original-To: lists+linux-erofs@lfdr.de
Delivered-To: lists+linux-erofs@lfdr.de
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2401:3900:2:1::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 7F8786A296
	for <lists+linux-erofs@lfdr.de>; Tue, 16 Jul 2019 09:04:54 +0200 (CEST)
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2401:3900:2:1::3])
	by lists.ozlabs.org (Postfix) with ESMTP id 45nrxb39NTzDqWh
	for <lists+linux-erofs@lfdr.de>; Tue, 16 Jul 2019 17:04:51 +1000 (AEST)
X-Original-To: linux-erofs@lists.ozlabs.org
Delivered-To: linux-erofs@lists.ozlabs.org
Authentication-Results: lists.ozlabs.org;
 spf=pass (mailfrom) smtp.mailfrom=huawei.com
 (client-ip=45.249.212.35; helo=huawei.com; envelope-from=gaoxiang25@huawei.com;
 receiver=<UNKNOWN>)
Authentication-Results: lists.ozlabs.org;
 dmarc=none (p=none dis=none) header.from=huawei.com
Received: from huawei.com (szxga07-in.huawei.com [45.249.212.35])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 45nrxM4cY1zDqWd
 for <linux-erofs@lists.ozlabs.org>; Tue, 16 Jul 2019 17:04:39 +1000 (AEST)
Received: from DGGEMS405-HUB.china.huawei.com (unknown [172.30.72.60])
 by Forcepoint Email with ESMTP id 89490D8C539A84F774FA;
 Tue, 16 Jul 2019 15:04:35 +0800 (CST)
Received: from architecture4.huawei.com (10.140.130.215) by smtp.huawei.com
 (10.3.19.205) with Microsoft SMTP Server (TLS) id 14.3.439.0; Tue, 16 Jul
 2019 15:04:25 +0800
From: Gao Xiang <gaoxiang25@huawei.com>
To: Li Guifu <bluce.liguifu@huawei.com>, Fang Wei <fangwei1@huawei.com>
Subject: [PATCH v2 02/17] erofs-utils: introduce erofs-utils basic headers
Date: Tue, 16 Jul 2019 15:04:04 +0800
Message-ID: <20190716070419.30203-3-gaoxiang25@huawei.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20190716070419.30203-1-gaoxiang25@huawei.com>
References: <20190716070419.30203-1-gaoxiang25@huawei.com>
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
Cc: Miao Xie <miaoxie@huawei.com>, linux-erofs@lists.ozlabs.org
Errors-To: linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org
Sender: "Linux-erofs"
 <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>

From: Li Guifu <bluce.liguifu@huawei.com>

This patch adds basic definitions, and a simple
kernel-like list implementaion.

Signed-off-by: Li Guifu <bluce.liguifu@huawei.com>
Signed-off-by: Miao Xie <miaoxie@huawei.com>
Signed-off-by: Fang Wei <fangwei1@huawei.com>
Signed-off-by: Gao Xiang <gaoxiang25@huawei.com>
---
 include/erofs/defs.h     | 159 +++++++++++++++++++++++++++++++++++++++
 include/erofs/err.h      |  34 +++++++++
 include/erofs/internal.h | 123 ++++++++++++++++++++++++++++++
 include/erofs/list.h     | 110 +++++++++++++++++++++++++++
 4 files changed, 426 insertions(+)
 create mode 100644 include/erofs/defs.h
 create mode 100644 include/erofs/err.h
 create mode 100644 include/erofs/internal.h
 create mode 100644 include/erofs/list.h

diff --git a/include/erofs/defs.h b/include/erofs/defs.h
new file mode 100644
index 0000000..111b703
--- /dev/null
+++ b/include/erofs/defs.h
@@ -0,0 +1,159 @@
+/* SPDX-License-Identifier: GPL-2.0+ */
+/*
+ * erofs_utils/include/erofs/defs.h
+ *
+ * Copyright (C) 2018 HUAWEI, Inc.
+ *             http://www.huawei.com/
+ * Created by Li Guifu <bluce.liguifu@huawei.com>
+ * Modified by Gao Xiang <gaoxiang25@huawei.com>
+ */
+#ifndef __EROFS_DEFS_H
+#define __EROFS_DEFS_H
+
+#include <stddef.h>
+#include <stdint.h>
+#include <assert.h>
+#include <inttypes.h>
+
+#include <stdbool.h>
+
+#ifdef HAVE_CONFIG_H
+#include <config.h>
+#endif
+
+#ifdef HAVE_LINUX_TYPES_H
+#include <linux/types.h>
+#endif
+
+/*
+ * container_of - cast a member of a structure out to the containing structure
+ * @ptr:	the pointer to the member.
+ * @type:	the type of the container struct this is embedded in.
+ * @member:	the name of the member within the struct.
+ */
+#define container_of(ptr, type, member) ({			\
+	const typeof(((type *)0)->member) *__mptr = (ptr);	\
+	(type *)((char *)__mptr - offsetof(type, member)); })
+
+typedef uint8_t         u8;
+typedef uint16_t        u16;
+typedef uint32_t        u32;
+typedef uint64_t        u64;
+
+#ifndef HAVE_LINUX_TYPES_H
+typedef u8	__u8;
+typedef u16	__u16;
+typedef u32	__u32;
+typedef u64	__u64;
+typedef u16	__le16;
+typedef u32	__le32;
+typedef u64	__le64;
+typedef u16	__be16;
+typedef u32	__be32;
+typedef u64	__be64;
+#endif
+
+typedef int8_t          s8;
+typedef int16_t         s16;
+typedef int32_t         s32;
+typedef int64_t         s64;
+
+
+#if __BYTE_ORDER == __LITTLE_ENDIAN
+/*
+ * The host byte order is the same as network byte order,
+ * so these functions are all just identity.
+ */
+#define cpu_to_le16(x) ((__u16)(x))
+#define cpu_to_le32(x) ((__u32)(x))
+#define cpu_to_le64(x) ((__u64)(x))
+#define le16_to_cpu(x) ((__u16)(x))
+#define le32_to_cpu(x) ((__u32)(x))
+#define le64_to_cpu(x) ((__u64)(x))
+
+#else
+#if __BYTE_ORDER == __BIG_ENDIAN
+#define cpu_to_le16(x) (__builtin_bswap16(x))
+#define cpu_to_le32(x) (__builtin_bswap32(x))
+#define cpu_to_le64(x) (__builtin_bswap64(x))
+#define le16_to_cpu(x) (__builtin_bswap16(x))
+#define le32_to_cpu(x) (__builtin_bswap32(x))
+#define le64_to_cpu(x) (__builtin_bswap64(x))
+#else
+#pragma error
+#endif
+#endif
+
+#ifndef __OPTIMIZE__
+#define BUILD_BUG_ON(condition) ((void)sizeof(char[1 - 2 * !!(condition)]))
+#else
+#define BUILD_BUG_ON(condition) assert(condition)
+#endif
+
+#define DIV_ROUND_UP(n, d) (((n) + (d) - 1) / (d))
+
+#define __round_mask(x, y)      ((__typeof__(x))((y)-1))
+#define round_up(x, y)          ((((x)-1) | __round_mask(x, y))+1)
+#define round_down(x, y)        ((x) & ~__round_mask(x, y))
+
+/* The `const' in roundup() prevents gcc-3.3 from calling __divdi3 */
+#define roundup(x, y) (					\
+{							\
+	const typeof(y) __y = y;			\
+	(((x) + (__y - 1)) / __y) * __y;		\
+}							\
+)
+#define rounddown(x, y) (				\
+{							\
+	typeof(x) __x = (x);				\
+	__x - (__x % (y));				\
+}							\
+)
+
+#define min(x, y) ({				\
+	typeof(x) _min1 = (x);			\
+	typeof(y) _min2 = (y);			\
+	(void) (&_min1 == &_min2);		\
+	_min1 < _min2 ? _min1 : _min2; })
+
+#define max(x, y) ({				\
+	typeof(x) _max1 = (x);			\
+	typeof(y) _max2 = (y);			\
+	(void) (&_max1 == &_max2);		\
+	_max1 > _max2 ? _max1 : _max2; })
+
+/*
+ * ..and if you can't take the strict types, you can specify one yourself.
+ * Or don't use min/max at all, of course.
+ */
+#define min_t(type, x, y) ({			\
+	type __min1 = (x);			\
+	type __min2 = (y);			\
+	__min1 < __min2 ? __min1: __min2; })
+
+#define max_t(type, x, y) ({			\
+	type __max1 = (x);			\
+	type __max2 = (y);			\
+	__max1 > __max2 ? __max1: __max2; })
+
+#define ARRAY_SIZE(arr)	(sizeof(arr) / sizeof((arr)[0]))
+
+#define BIT(nr)             (1UL << (nr))
+#define BIT_ULL(nr)         (1ULL << (nr))
+#define BIT_MASK(nr)        (1UL << ((nr) % BITS_PER_LONG))
+#define BIT_WORD(nr)        ((nr) / BITS_PER_LONG)
+#define BIT_ULL_MASK(nr)    (1ULL << ((nr) % BITS_PER_LONG_LONG))
+#define BIT_ULL_WORD(nr)    ((nr) / BITS_PER_LONG_LONG)
+#define BITS_PER_BYTE       8
+#define BITS_TO_LONGS(nr)   DIV_ROUND_UP(nr, BITS_PER_BYTE * sizeof(long))
+
+#define BUG_ON(cond)        assert(!(cond))
+
+#ifdef NDEBUG
+#define DBG_BUGON(condition)	((void)(condition))
+#else
+#define DBG_BUGON(condition)	BUG_ON(condition)
+#endif
+
+#endif
+
diff --git a/include/erofs/err.h b/include/erofs/err.h
new file mode 100644
index 0000000..fd4c873
--- /dev/null
+++ b/include/erofs/err.h
@@ -0,0 +1,34 @@
+/* SPDX-License-Identifier: GPL-2.0+ */
+/*
+ * erofs_utils/include/erofs/err.h
+ *
+ * Copyright (C) 2018 HUAWEI, Inc.
+ *             http://www.huawei.com/
+ * Created by Li Guifu <bluce.liguifu@huawei.com>
+ */
+#ifndef __EROFS_ERR_H
+#define __EROFS_ERR_H
+
+#include <errno.h>
+
+#define MAX_ERRNO (4095)
+#define IS_ERR_VALUE(x)                                                        \
+	((unsigned long)(void *)(x) >= (unsigned long)-MAX_ERRNO)
+
+static inline void *ERR_PTR(long error)
+{
+	return (void *)error;
+}
+
+static inline int IS_ERR(const void *ptr)
+{
+	return IS_ERR_VALUE((unsigned long)ptr);
+}
+
+static inline long PTR_ERR(const void *ptr)
+{
+	return (long) ptr;
+}
+
+#endif
+
diff --git a/include/erofs/internal.h b/include/erofs/internal.h
new file mode 100644
index 0000000..4789471
--- /dev/null
+++ b/include/erofs/internal.h
@@ -0,0 +1,123 @@
+/* SPDX-License-Identifier: GPL-2.0+ */
+/*
+ * erofs_utils/include/erofs/internal.h
+ *
+ * Copyright (C) 2019 HUAWEI, Inc.
+ *             http://www.huawei.com/
+ * Created by Gao Xiang <gaoxiang25@huawei.com>
+ */
+#ifndef __EROFS_INTERNAL_H
+#define __EROFS_INTERNAL_H
+
+#include "list.h"
+#include "err.h"
+
+typedef unsigned short umode_t;
+
+#define __packed __attribute__((__packed__))
+
+#include "erofs_fs.h"
+#include <fcntl.h>
+
+#ifndef PATH_MAX
+#define PATH_MAX        4096    /* # chars in a path name including nul */
+#endif
+
+#define PAGE_SHIFT		(12)
+#define PAGE_SIZE		(1U << PAGE_SHIFT)
+
+#define LOG_BLOCK_SIZE          (12)
+#define EROFS_BLKSIZ            (1U << LOG_BLOCK_SIZE)
+
+#define EROFS_ISLOTBITS		5
+#define EROFS_SLOTSIZE		(1U << EROFS_ISLOTBITS)
+
+typedef u64 erofs_off_t;
+typedef u64 erofs_nid_t;
+/* data type for filesystem-wide blocks number */
+typedef u32 erofs_blk_t;
+
+#define NULL_ADDR	((unsigned int)-1)
+#define NULL_ADDR_UL	((unsigned long)-1)
+
+#define erofs_blknr(addr)       ((addr) / EROFS_BLKSIZ)
+#define erofs_blkoff(addr)      ((addr) % EROFS_BLKSIZ)
+#define blknr_to_addr(nr)       ((erofs_off_t)(nr) * EROFS_BLKSIZ)
+
+#define BLK_ROUND_UP(addr)	DIV_ROUND_UP(addr, EROFS_BLKSIZ)
+
+struct erofs_buffer_head;
+
+struct erofs_sb_info {
+	erofs_blk_t meta_blkaddr;
+	erofs_blk_t xattr_blkaddr;
+};
+
+/* global sbi */
+extern struct erofs_sb_info sbi;
+
+struct erofs_inode {
+	struct list_head i_hash, i_subdirs;
+
+	unsigned int i_count;
+	struct erofs_inode *i_parent;
+
+	umode_t i_mode;
+	erofs_off_t i_size;
+
+	u64 i_ino[2];
+	u32 i_uid;
+	u32 i_gid;
+	u64 i_ctime;
+	u32 i_ctime_nsec;
+	u32 i_nlink;
+
+	union {
+		u32 i_blkaddr;
+		u32 i_blocks;
+		u32 i_rdev;
+	} u;
+
+	char i_srcpath[PATH_MAX + 1];
+
+	unsigned char data_mapping_mode;
+	unsigned char inode_isize;
+	/* inline tail-end packing size */
+	unsigned short idata_size;
+
+	unsigned int xattr_isize;
+	unsigned int extent_isize;
+
+	erofs_nid_t nid;
+	struct erofs_buffer_head *bh;
+	struct erofs_buffer_head *bh_inline, *bh_data;
+
+	void *idata;
+};
+
+#define IS_ROOT(x)	((x) == (x)->i_parent)
+
+struct erofs_dentry {
+	struct list_head d_child;	/* child of parent list */
+
+	unsigned int type;
+	char name[EROFS_NAME_LEN];
+	union {
+		struct erofs_inode *inode;
+		erofs_nid_t nid;
+	};
+};
+
+#include <stdio.h>
+#include <string.h>
+
+static inline const char *erofs_strerror(int err)
+{
+	static char msg[256];
+
+	sprintf(msg, "[Error %d] %s", -err, strerror(-err));
+	return msg;
+}
+
+#endif
+
diff --git a/include/erofs/list.h b/include/erofs/list.h
new file mode 100644
index 0000000..e290843
--- /dev/null
+++ b/include/erofs/list.h
@@ -0,0 +1,110 @@
+/* SPDX-License-Identifier: GPL-2.0+ */
+/*
+ * erofs_utils/include/erofs/list.h
+ *
+ * Copyright (C) 2018 HUAWEI, Inc.
+ *             http://www.huawei.com/
+ * Created by Li Guifu <bluce.liguifu@huawei.com>
+ */
+#ifndef __EROFS_LIST_HEAD_H
+#define __EROFS_LIST_HEAD_H
+
+#include "defs.h"
+
+struct list_head {
+	struct list_head *prev;
+	struct list_head *next;
+};
+
+#define LIST_HEAD_INIT(name)                                                   \
+	{                                                                      \
+		&(name), &(name)                                               \
+	}
+
+#define LIST_HEAD(name) struct list_head name = LIST_HEAD_INIT(name)
+
+static inline void init_list_head(struct list_head *list)
+{
+	list->prev = list;
+	list->next = list;
+}
+
+static inline void __list_add(struct list_head *entry,
+			      struct list_head *prev,
+			      struct list_head *next)
+{
+	entry->prev = prev;
+	entry->next = next;
+	prev->next  = entry;
+	next->prev  = entry;
+}
+
+static inline void list_add(struct list_head *entry, struct list_head *head)
+{
+	__list_add(entry, head, head->next);
+}
+
+static inline void list_add_tail(struct list_head *entry,
+				 struct list_head *head)
+{
+	__list_add(entry, head->prev, head);
+}
+
+static inline void __list_del(struct list_head *prev, struct list_head *next)
+{
+	prev->next = next;
+	next->prev = prev;
+}
+
+static inline void list_del(struct list_head *entry)
+{
+	__list_del(entry->prev, entry->next);
+	entry->prev = entry->next = NULL;
+}
+
+static inline int list_empty(struct list_head *head)
+{
+	return head->next == head;
+}
+
+#define list_entry(ptr, type, member) container_of(ptr, type, member)
+
+#define list_first_entry(ptr, type, member)                                    \
+	list_entry((ptr)->next, type, member)
+
+#define list_last_entry(ptr, type, member)                                     \
+	list_entry((ptr)->prev, type, member)
+
+#define list_next_entry(pos, member)                                           \
+	list_entry((pos)->member.next, typeof(*(pos)), member)
+
+#define list_prev_entry(pos, member)                                           \
+	list_entry((pos)->member.prev, typeof(*(pos)), member)
+
+#define list_for_each(pos, head)                                               \
+	for (pos = (head)->next; pos != (head); pos = pos->next)
+
+#define list_for_each_safe(pos, n, head)                                       \
+	for (pos = (head)->next, n = pos->next; pos != (head);                 \
+	     pos = n, n = pos->next)
+
+#define list_for_each_entry(pos, head, member)                                 \
+	for (pos = list_first_entry(head, typeof(*pos), member);               \
+	     &pos->member != (head);                                           \
+	     pos = list_next_entry(pos, member))
+
+#define list_for_each_entry_reverse(pos, head, member)                         \
+	for (pos = list_last_entry(head, typeof(*pos), member);               \
+	     &pos->member != (head);                                           \
+	     pos = list_prev_entry(pos, member))
+
+#define list_for_each_entry_from(pos, head, member)                            \
+	for (; &pos->member != (head); pos = list_next_entry(pos, member))
+
+#define list_for_each_entry_safe(pos, n, head, member)                         \
+	for (pos = list_first_entry(head, typeof(*pos), member),               \
+	    n    = list_next_entry(pos, member);                               \
+	     &pos->member != (head);                                           \
+	     pos = n, n = list_next_entry(n, member))
+
+#endif
-- 
2.17.1

