Return-Path: <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>
X-Original-To: lists+linux-erofs@lfdr.de
Delivered-To: lists+linux-erofs@lfdr.de
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2401:3900:2:1::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 815A0D618A
	for <lists+linux-erofs@lfdr.de>; Mon, 14 Oct 2019 13:42:41 +0200 (CEST)
Received: from bilbo.ozlabs.org (lists.ozlabs.org [IPv6:2401:3900:2:1::3])
	by lists.ozlabs.org (Postfix) with ESMTP id 46sGrY74PSzDqWp
	for <lists+linux-erofs@lfdr.de>; Mon, 14 Oct 2019 22:42:37 +1100 (AEDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=lists.ozlabs.org;
	s=201707; t=1571053358;
	bh=ZXjE/CK5K+aUXELje4dyfz7rPvAeUPKPmhXkPVgTjvs=;
	h=To:Subject:Date:In-Reply-To:References:List-Id:List-Unsubscribe:
	 List-Archive:List-Post:List-Help:List-Subscribe:From:Reply-To:Cc:
	 From;
	b=FVOWVR1Ncmc57PGfuoaBTyITWUFsfbLa2iflPbo1ZL/7CH5CtvFqS6/q8eyItTdw8
	 eRcSXMXj0rcpoUFD6vS6LCApqamlBfHYY4xUoDjfc8LnHA9KKUzWfsNcKR4BnzLKJ4
	 dYA8fFw2hqskce37g6YTmtr0nFElqIRPM1Pm/y2OSMYJ+aMXdkepR9PVSmo+nhWQfv
	 hECoQqKXUsd5loaCCmeJ5v9iPgtWYTQIJxKMDsyVX24Kc319W5CsLyOZfcQe6VmQ8r
	 PuZJoV/P4ML+VVInELljKBGwjn+ScHxy0B6S9zVYuOUygoB9YyuE2w1RgRkbm9STEF
	 KAaSiaNRKTS7A==
X-Original-To: linux-erofs@lists.ozlabs.org
Delivered-To: linux-erofs@lists.ozlabs.org
Authentication-Results: lists.ozlabs.org;
 spf=pass (mailfrom) smtp.mailfrom=aol.com
 (client-ip=98.137.65.204; helo=sonic311-23.consmr.mail.gq1.yahoo.com;
 envelope-from=hsiangkao@aol.com; receiver=<UNKNOWN>)
Authentication-Results: lists.ozlabs.org;
 dmarc=pass (p=reject dis=none) header.from=aol.com
Authentication-Results: lists.ozlabs.org; dkim=pass (2048-bit key;
 unprotected) header.d=aol.com header.i=@aol.com header.b="M0/68uxt"; 
 dkim-atps=neutral
Received: from sonic311-23.consmr.mail.gq1.yahoo.com
 (sonic311-23.consmr.mail.gq1.yahoo.com [98.137.65.204])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 46sGrL6d8dzDqS7
 for <linux-erofs@lists.ozlabs.org>; Mon, 14 Oct 2019 22:42:23 +1100 (AEDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=aol.com; s=a2048;
 t=1571053338; bh=qhdYHb+uvT7L0JVjbzN965AV0UOGI184bzh9K4sSKJA=;
 h=From:To:Cc:Subject:Date:In-Reply-To:References:From:Subject;
 b=M0/68uxtZbtSXggVw4DQ4IK3QfR3kgZTI2kQ2N5gEZ9QIlW3hFGJJuSSrsy+lKcIUvFsxjpew+aTIVfc5K7RGWwC5AmfMhgtQLwZ3MFHngOfdy2XBf7OL30JQXA8+tRN9DbJfhdqxSoHpiXnFEfafJFGXRrdKnDYli0M9kSk9usZXn9vxocdb0CuyHVRs5v2vEmQfNBUkLdaU5XGxeJGiyJA6yz/E8T83HCtV8ym5duhPpJZcc89eyz1/BMG/EP/w4F6XbWwAAnIJTZQ/TEHuocPMo5eMb9qjds4Kqv3cpiChEJy390qPFezoPgeNvrOiZarqaHWTKoB/y08y23qmg==
X-YMail-OSG: ZeyyVN4VM1kZlvfPkDbiJr4FNHRWSs25JRa8B.boDZitnKVrwaDfTm4qT6Ne30u
 tXpW882sEG2zmFNXTDDStCFIwFrLRzuQ7aRPDEpNLzgOKOhqLHNvvgVb6Xpeawh0inljcpdR7meA
 tv7g7AQ8MGHsjxB9E7XxblLrsQ9Mjxz2xOG0kfr9K07XhTp2gCWpipihSJV_T4Gg1FhacerFk8bp
 GBGI76WtlUFKa2b.1Ur2V90zjozpI8Cshh0G_57xXtDPebtzBa9BC1M3c5IuZzbvWYVCABo.mdgE
 XciVH2UD85VwUnei9_cSjWZyNfgjaDb8RfKyZ40cWDBiLWZcPeIDealMCCQlQBGkbgSRBI60PeMs
 bnEknrvZChiSRWD.VBnfXno4wXstEJ2dQ4y5qoEy_a1678BVDjlCjD58UMsk1olyubdIryt.J56f
 krVEcc1gE2_4dpzIqaUpQ6UhjzQl_GfkcrECvrBvR01uvwUpJbfd7omNtN0_eMrndavpdGMqvn5h
 Ptyfckc5uae1L1ykugpHuWram_nsLM.2pY1YtKGSkiHsTG9eWz95NkHvzZHVlJ8FSem_v2Jo71e8
 bchckGee_2skhjnwNRrzXh.tHGJR1wfG5pliSV9cPwBn5WAHFHV6CDDKF6RoUjdw9S7fhFwwGGz6
 H.aWK2rWPnng_LovNfswWriwwX2lFq2pK6fWCHyPE6HGuoBKeg54FSsKc.kH_vvC95Nh2UMgHetD
 IaYe9iczPpey.KzlWRv3n1s7ujgElt0csfSPubYWZoiib5EhCfo3hGRosm34uLNcIi8oSIFwiasI
 sZcqleZ3xwNg5fN15f9RbDR27mLD8JDU3Mo9OE5o9O8qocbmJyls1eTK5SIGQlrGuZ3ElAAkNp2T
 Zn7tc5lqYX6Kl50Q39OdR3.Lr9h2EPxVAAyT.O_jLUzVOSepOI7BniszPlLIEnQSKf6UeHrHRETr
 GmtW4oSSu23Q36Ta3GmBmTFcQmFVprbmfC6vo5ONB5W.nXY_xOGhEiSsP6Gf2MgQYNMSLJvvdEGv
 Iq8XSd47s21Xux2quySj4b1c4EY1HzXrczO9j9m5p3KXlRimaDrlyviHJJ6Yq9UKzZdQKBDvZjwP
 20rgaqfWTjnAGL2L4Ck0ONR62dyFfLo2rgFTWaRL4ncXVhlePM6pVF3rw5dwPT345orNQ8WietaO
 PSeB8lqw6IUrKPo27u3abq57Vbeghoz7JX1jR3YjDCgNQL2U2wZuLKP.Twv5qlrZpKOmcqtRbG3m
 EmUhQwXgVVgicuXfAQUOjJNLV47BpoRePpgtVq3hfvmcCP_UQVyBquOFqWYPH22gU1t4tqIA2rx8
 yPWqsc14ilhRoQcrg4h1ShhQw
Received: from sonic.gate.mail.ne1.yahoo.com by
 sonic311.consmr.mail.gq1.yahoo.com with HTTP; Mon, 14 Oct 2019 11:42:18 +0000
Received: by smtp409.mail.gq1.yahoo.com (Oath Hermes SMTP Server) with ESMTPA
 ID 3d33a07be7c77bc3a7b4f85fda679caa; 
 Mon, 14 Oct 2019 11:42:17 +0000 (UTC)
To: Li Guifu <bluce.liguifu@huawei.com>,
	linux-erofs@lists.ozlabs.org
Subject: [PATCH v4 1/2] erofs-utils: introduce inline xattr support
Date: Mon, 14 Oct 2019 19:42:05 +0800
Message-Id: <20191014114206.590-1-hsiangkao@aol.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20191006050104.GA24328@hsiangkao-HP-ZHAN-66-Pro-G1>
References: <20191006050104.GA24328@hsiangkao-HP-ZHAN-66-Pro-G1>
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
Cc: Miao Xie <miaoxie@huawei.com>,
 "htyuxe+dhbrei4sq0df8@grr.la" <htyuxe+dhbrei4sq0df8@grr.la>
Errors-To: linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org
Sender: "Linux-erofs"
 <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>

From: "htyuxe+dhbrei4sq0df8@grr.la" <htyuxe+dhbrei4sq0df8@grr.la>

Load xattrs from source files and pack them into target image.

Signed-off-by: htyuxe+dhbrei4sq0df8@grr.la <htyuxe+dhbrei4sq0df8@grr.la>
Signed-off-by: Li Guifu <blucerlee@gmail.com>
Signed-off-by: Gao Xiang <hsiangkao@aol.com>
---
changes since v3:
 - add a option "-x" to indicate minimal refcount of a shared xattr or
   xattr disabled;
 - introduce put_xattritem() for unused xattr cleanup.

 configure.ac              |   1 +
 include/erofs/config.h    |   2 +
 include/erofs/defs.h      |   6 +
 include/erofs/hashtable.h | 462 ++++++++++++++++++++++++++++++++++++++
 include/erofs/internal.h  |   2 +-
 include/erofs/xattr.h     |  48 ++++
 lib/Makefile.am           |   3 +-
 lib/config.c              |   1 +
 lib/inode.c               |  31 ++-
 lib/xattr.c               | 309 +++++++++++++++++++++++++
 mkfs/main.c               |  12 +-
 11 files changed, 872 insertions(+), 5 deletions(-)
 create mode 100644 include/erofs/hashtable.h
 create mode 100644 include/erofs/xattr.h
 create mode 100644 lib/xattr.c

diff --git a/configure.ac b/configure.ac
index 07e034e..8c31cb7 100644
--- a/configure.ac
+++ b/configure.ac
@@ -75,6 +75,7 @@ AC_CHECK_HEADERS(m4_flatten([
 	linux/falloc.h
 	linux/fs.h
 	linux/types.h
+	linux/xattr.h
 	limits.h
 	stddef.h
 	stdint.h
diff --git a/include/erofs/config.h b/include/erofs/config.h
index 9711638..2be05ee 100644
--- a/include/erofs/config.h
+++ b/include/erofs/config.h
@@ -28,6 +28,8 @@ struct erofs_configure {
 	char *c_compr_alg_master;
 	int c_compr_level_master;
 	int c_force_inodeversion;
+	/* < 0, xattr disabled and INT_MAX, always use inline xattrs */
+	int c_inline_xattr_tolerance;
 	u64 c_unix_timestamp;
 };
 
diff --git a/include/erofs/defs.h b/include/erofs/defs.h
index db51350..aa127d0 100644
--- a/include/erofs/defs.h
+++ b/include/erofs/defs.h
@@ -152,6 +152,12 @@ typedef int64_t         s64;
 #define BITS_PER_BYTE       8
 #define BITS_TO_LONGS(nr)   DIV_ROUND_UP(nr, BITS_PER_BYTE * sizeof(long))
 
+#ifdef __SIZEOF_LONG__
+#define BITS_PER_LONG (__CHAR_BIT__ * __SIZEOF_LONG__)
+#else
+#define BITS_PER_LONG __WORDSIZE
+#endif
+
 #define BUG_ON(cond)        assert(!(cond))
 
 #ifdef NDEBUG
diff --git a/include/erofs/hashtable.h b/include/erofs/hashtable.h
new file mode 100644
index 0000000..ab57b56
--- /dev/null
+++ b/include/erofs/hashtable.h
@@ -0,0 +1,462 @@
+/* SPDX-License-Identifier: GPL-2.0 */
+/*
+ * erofs_utils/include/erofs/hashtable.h
+ *
+ * Original code taken from 'linux/include/linux/hash{,table}.h'
+ */
+#ifndef __EROFS_HASHTABLE_H
+#define __EROFS_HASHTABLE_H
+
+/*
+ * Fast hashing routine for ints,  longs and pointers.
+ * (C) 2002 Nadia Yvette Chambers, IBM
+ */
+
+/*
+ * Statically sized hash table implementation
+ * (C) 2012  Sasha Levin <levinsasha928@gmail.com>
+ */
+
+#include "defs.h"
+
+/*
+ * The "GOLDEN_RATIO_PRIME" is used in ifs/btrfs/brtfs_inode.h and
+ * fs/inode.c.  It's not actually prime any more (the previous primes
+ * were actively bad for hashing), but the name remains.
+ */
+#if BITS_PER_LONG == 32
+#define GOLDEN_RATIO_PRIME GOLDEN_RATIO_32
+#define hash_long(val, bits) hash_32(val, bits)
+#elif BITS_PER_LONG == 64
+#define hash_long(val, bits) hash_64(val, bits)
+#define GOLDEN_RATIO_PRIME GOLDEN_RATIO_64
+#else
+#error Wordsize not 32 or 64
+#endif
+
+/*
+ * This hash multiplies the input by a large odd number and takes the
+ * high bits.  Since multiplication propagates changes to the most
+ * significant end only, it is essential that the high bits of the
+ * product be used for the hash value.
+ *
+ * Chuck Lever verified the effectiveness of this technique:
+ * http://www.citi.umich.edu/techreports/reports/citi-tr-00-1.pdf
+ *
+ * Although a random odd number will do, it turns out that the golden
+ * ratio phi = (sqrt(5)-1)/2, or its negative, has particularly nice
+ * properties.  (See Knuth vol 3, section 6.4, exercise 9.)
+ *
+ * These are the negative, (1 - phi) = phi**2 = (3 - sqrt(5))/2,
+ * which is very slightly easier to multiply by and makes no
+ * difference to the hash distribution.
+ */
+#define GOLDEN_RATIO_32 0x61C88647
+#define GOLDEN_RATIO_64 0x61C8864680B583EBull
+
+struct hlist_head {
+	struct hlist_node *first;
+};
+
+struct hlist_node {
+	struct hlist_node *next, **pprev;
+};
+
+/*
+ * Architectures might want to move the poison pointer offset
+ * into some well-recognized area such as 0xdead000000000000,
+ * that is also not mappable by user-space exploits:
+ */
+#ifdef CONFIG_ILLEGAL_POINTER_VALUE
+# define POISON_POINTER_DELTA _AC(CONFIG_ILLEGAL_POINTER_VALUE, UL)
+#else
+# define POISON_POINTER_DELTA 0
+#endif
+
+/*
+ * These are non-NULL pointers that will result in page faults
+ * under normal circumstances, used to verify that nobody uses
+ * non-initialized list entries.
+ */
+#define LIST_POISON1 ((void *) 0x00100100 + POISON_POINTER_DELTA)
+#define LIST_POISON2 ((void *) 0x00200200 + POISON_POINTER_DELTA)
+
+/*
+ * Double linked lists with a single pointer list head.
+ * Mostly useful for hash tables where the two pointer list head is
+ * too wasteful.
+ * You lose the ability to access the tail in O(1).
+ */
+
+#define HLIST_HEAD_INIT { .first = NULL }
+#define HLIST_HEAD(name) struct hlist_head name = { .first = NULL }
+#define INIT_HLIST_HEAD(ptr) ((ptr)->first = NULL)
+static inline void INIT_HLIST_NODE(struct hlist_node *h)
+{
+	h->next = NULL;
+	h->pprev = NULL;
+}
+
+static inline int hlist_unhashed(const struct hlist_node *h)
+{
+	return !h->pprev;
+}
+
+static inline int hlist_empty(const struct hlist_head *h)
+{
+	return !h->first;
+}
+
+static inline void __hlist_del(struct hlist_node *n)
+{
+	struct hlist_node *next = n->next;
+	struct hlist_node **pprev = n->pprev;
+
+	*pprev = next;
+	if (next)
+		next->pprev = pprev;
+}
+
+static inline void hlist_del(struct hlist_node *n)
+{
+	__hlist_del(n);
+	n->next = LIST_POISON1;
+	n->pprev = LIST_POISON2;
+}
+
+static inline void hlist_del_init(struct hlist_node *n)
+{
+	if (!hlist_unhashed(n)) {
+		__hlist_del(n);
+		INIT_HLIST_NODE(n);
+	}
+}
+
+static inline void hlist_add_head(struct hlist_node *n, struct hlist_head *h)
+{
+	struct hlist_node *first = h->first;
+
+	n->next = first;
+	if (first)
+		first->pprev = &n->next;
+	h->first = n;
+	n->pprev = &h->first;
+}
+
+/* next must be != NULL */
+static inline void hlist_add_before(struct hlist_node *n,
+					struct hlist_node *next)
+{
+	n->pprev = next->pprev;
+	n->next = next;
+	next->pprev = &n->next;
+	*(n->pprev) = n;
+}
+
+static inline void hlist_add_behind(struct hlist_node *n,
+				    struct hlist_node *prev)
+{
+	n->next = prev->next;
+	prev->next = n;
+	n->pprev = &prev->next;
+
+	if (n->next)
+		n->next->pprev  = &n->next;
+}
+
+/* after that we'll appear to be on some hlist and hlist_del will work */
+static inline void hlist_add_fake(struct hlist_node *n)
+{
+	n->pprev = &n->next;
+}
+
+/*
+ * Move a list from one list head to another. Fixup the pprev
+ * reference of the first entry if it exists.
+ */
+static inline void hlist_move_list(struct hlist_head *old,
+				   struct hlist_head *new)
+{
+	new->first = old->first;
+	if (new->first)
+		new->first->pprev = &new->first;
+	old->first = NULL;
+}
+
+#define hlist_entry(ptr, type, member) container_of(ptr, type, member)
+
+#define hlist_for_each(pos, head) \
+	for (pos = (head)->first; pos; pos = pos->next)
+
+#define hlist_for_each_safe(pos, n, head) \
+	for (pos = (head)->first; pos && ({ n = pos->next; 1; }); \
+	     pos = n)
+
+#define hlist_entry_safe(ptr, type, member) \
+	({ typeof(ptr) ____ptr = (ptr); \
+	   ____ptr ? hlist_entry(____ptr, type, member) : NULL; \
+	})
+
+/**
+ * hlist_for_each_entry	- iterate over list of given type
+ * @pos:the type * to use as a loop cursor.
+ * @head:the head for your list.
+ * @member:the name of the hlist_node within the struct.
+ */
+#define hlist_for_each_entry(pos, head, member)				\
+	for (pos = hlist_entry_safe((head)->first, typeof(*(pos)), member);\
+	     pos;							\
+	     pos = hlist_entry_safe((pos)->member.next, typeof(*(pos)), member))
+
+/**
+ * hlist_for_each_entry_continue
+ * iterate over a hlist continuing after current point
+ * @pos:the type * to use as a loop cursor.
+ * @member:the name of the hlist_node within the struct.
+ */
+#define hlist_for_each_entry_continue(pos, member)			\
+	for (pos = hlist_entry_safe((pos)->member.next, typeof(*(pos)), member);\
+	     pos;							\
+	     pos = hlist_entry_safe((pos)->member.next, typeof(*(pos)), member))
+
+/**
+ * hlist_for_each_entry_from
+ * iterate over a hlist continuing from current point
+ * @pos:	the type * to use as a loop cursor.
+ * @member:	the name of the hlist_node within the struct.
+ */
+#define hlist_for_each_entry_from(pos, member)				\
+	for (; pos;							\
+	     pos = hlist_entry_safe((pos)->member.next, typeof(*(pos)), member))
+
+/**
+ * hlist_for_each_entry_safe
+ * iterate over list of given type safe against removal of list entry
+ * @pos:the type * to use as a loop cursor.
+ * @n:another &struct hlist_node to use as temporary storage
+ * @head:the head for your list.
+ * @member:the name of the hlist_node within the struct.
+ */
+#define hlist_for_each_entry_safe(pos, n, head, member)			\
+	for (pos = hlist_entry_safe((head)->first, typeof(*pos), member);\
+		pos && ({ n = pos->member.next; 1; });			\
+		pos = hlist_entry_safe(n, typeof(*pos), member))
+
+static inline u32 __hash_32(u32 val)
+{
+	return val * GOLDEN_RATIO_32;
+}
+
+static inline u32 hash_32(u32 val, unsigned int bits)
+{
+	/* High bits are more random, so use them. */
+	return __hash_32(val) >> (32 - bits);
+}
+
+static __always_inline u32 hash_64(u64 val, unsigned int bits)
+{
+#if BITS_PER_LONG == 64
+	/* 64x64-bit multiply is efficient on all 64-bit processors */
+	return val * GOLDEN_RATIO_64 >> (64 - bits);
+#else
+	/* Hash 64 bits using only 32x32-bit multiply. */
+	return hash_32((u32)val ^ __hash_32(val >> 32), bits);
+#endif
+}
+
+/**
+ * ilog2 - log of base 2 of 32-bit or a 64-bit unsigned value
+ * @n - parameter
+ *
+ * constant-capable log of base 2 calculation
+ * - this can be used to initialise global variables from constant data, hence
+ *   the massive ternary operator construction
+ *
+ * selects the appropriately-sized optimised version depending on sizeof(n)
+ */
+#define ilog2(n)				\
+(								\
+	(n) & (1ULL << 63) ? 63 :	\
+	(n) & (1ULL << 62) ? 62 :	\
+	(n) & (1ULL << 61) ? 61 :	\
+	(n) & (1ULL << 60) ? 60 :	\
+	(n) & (1ULL << 59) ? 59 :	\
+	(n) & (1ULL << 58) ? 58 :	\
+	(n) & (1ULL << 57) ? 57 :	\
+	(n) & (1ULL << 56) ? 56 :	\
+	(n) & (1ULL << 55) ? 55 :	\
+	(n) & (1ULL << 54) ? 54 :	\
+	(n) & (1ULL << 53) ? 53 :	\
+	(n) & (1ULL << 52) ? 52 :	\
+	(n) & (1ULL << 51) ? 51 :	\
+	(n) & (1ULL << 50) ? 50 :	\
+	(n) & (1ULL << 49) ? 49 :	\
+	(n) & (1ULL << 48) ? 48 :	\
+	(n) & (1ULL << 47) ? 47 :	\
+	(n) & (1ULL << 46) ? 46 :	\
+	(n) & (1ULL << 45) ? 45 :	\
+	(n) & (1ULL << 44) ? 44 :	\
+	(n) & (1ULL << 43) ? 43 :	\
+	(n) & (1ULL << 42) ? 42 :	\
+	(n) & (1ULL << 41) ? 41 :	\
+	(n) & (1ULL << 40) ? 40 :	\
+	(n) & (1ULL << 39) ? 39 :	\
+	(n) & (1ULL << 38) ? 38 :	\
+	(n) & (1ULL << 37) ? 37 :	\
+	(n) & (1ULL << 36) ? 36 :	\
+	(n) & (1ULL << 35) ? 35 :	\
+	(n) & (1ULL << 34) ? 34 :	\
+	(n) & (1ULL << 33) ? 33 :	\
+	(n) & (1ULL << 32) ? 32 :	\
+	(n) & (1ULL << 31) ? 31 :	\
+	(n) & (1ULL << 30) ? 30 :	\
+	(n) & (1ULL << 29) ? 29 :	\
+	(n) & (1ULL << 28) ? 28 :	\
+	(n) & (1ULL << 27) ? 27 :	\
+	(n) & (1ULL << 26) ? 26 :	\
+	(n) & (1ULL << 25) ? 25 :	\
+	(n) & (1ULL << 24) ? 24 :	\
+	(n) & (1ULL << 23) ? 23 :	\
+	(n) & (1ULL << 22) ? 22 :	\
+	(n) & (1ULL << 21) ? 21 :	\
+	(n) & (1ULL << 20) ? 20 :	\
+	(n) & (1ULL << 19) ? 19 :	\
+	(n) & (1ULL << 18) ? 18 :	\
+	(n) & (1ULL << 17) ? 17 :	\
+	(n) & (1ULL << 16) ? 16 :	\
+	(n) & (1ULL << 15) ? 15 :	\
+	(n) & (1ULL << 14) ? 14 :	\
+	(n) & (1ULL << 13) ? 13 :	\
+	(n) & (1ULL << 12) ? 12 :	\
+	(n) & (1ULL << 11) ? 11 :	\
+	(n) & (1ULL << 10) ? 10 :	\
+	(n) & (1ULL <<  9) ?  9 :	\
+	(n) & (1ULL <<  8) ?  8 :	\
+	(n) & (1ULL <<  7) ?  7 :	\
+	(n) & (1ULL <<  6) ?  6 :	\
+	(n) & (1ULL <<  5) ?  5 :	\
+	(n) & (1ULL <<  4) ?  4 :	\
+	(n) & (1ULL <<  3) ?  3 :	\
+	(n) & (1ULL <<  2) ?  2 :	\
+	(n) & (1ULL <<  1) ?  1 : 0	\
+)
+
+#define DEFINE_HASHTABLE(name, bits)					\
+	struct hlist_head name[1 << (bits)] =				\
+			{ [0 ... ((1 << (bits)) - 1)] = HLIST_HEAD_INIT }
+
+#define DECLARE_HASHTABLE(name, bits)					\
+	struct hlist_head name[1 << (bits)]
+
+#define HASH_SIZE(name) (ARRAY_SIZE(name))
+#define HASH_BITS(name) ilog2(HASH_SIZE(name))
+
+/* Use hash_32 when possible to allow for fast 32bit hashing in 64bit kernels*/
+#define hash_min(val, bits)						\
+	(sizeof(val) <= 4 ? hash_32(val, bits) : hash_long(val, bits))
+
+static inline void __hash_init(struct hlist_head *ht, unsigned int sz)
+{
+	unsigned int i;
+
+	for (i = 0; i < sz; i++)
+		INIT_HLIST_HEAD(&ht[i]);
+}
+
+/**
+ * hash_init - initialize a hash table
+ * @hashtable: hashtable to be initialized
+ *
+ * Calculates the size of the hashtable from the given parameter, otherwise
+ * same as hash_init_size.
+ *
+ * This has to be a macro since HASH_BITS() will not work on pointers since
+ * it calculates the size during preprocessing.
+ */
+#define hash_init(hashtable) __hash_init(hashtable, HASH_SIZE(hashtable))
+
+/**
+ * hash_add - add an object to a hashtable
+ * @hashtable: hashtable to add to
+ * @node: the &struct hlist_node of the object to be added
+ * @key: the key of the object to be added
+ */
+#define hash_add(hashtable, node, key)					\
+	hlist_add_head(node, &hashtable[hash_min(key, HASH_BITS(hashtable))])
+
+/**
+ * hash_hashed - check whether an object is in any hashtable
+ * @node: the &struct hlist_node of the object to be checked
+ */
+static inline bool hash_hashed(struct hlist_node *node)
+{
+	return !hlist_unhashed(node);
+}
+
+static inline bool __hash_empty(struct hlist_head *ht, unsigned int sz)
+{
+	unsigned int i;
+
+	for (i = 0; i < sz; i++)
+		if (!hlist_empty(&ht[i]))
+			return false;
+
+	return true;
+}
+
+/**
+ * hash_empty - check whether a hashtable is empty
+ * @hashtable: hashtable to check
+ *
+ * This has to be a macro since HASH_BITS() will not work on pointers since
+ * it calculates the size during preprocessing.
+ */
+#define hash_empty(hashtable) __hash_empty(hashtable, HASH_SIZE(hashtable))
+
+/**
+ * hash_del - remove an object from a hashtable
+ * @node: &struct hlist_node of the object to remove
+ */
+static inline void hash_del(struct hlist_node *node)
+{
+	hlist_del_init(node);
+}
+
+/**
+ * hash_for_each - iterate over a hashtable
+ * @name: hashtable to iterate
+ * @bkt: integer to use as bucket loop cursor
+ * @obj: the type * to use as a loop cursor for each entry
+ * @member: the name of the hlist_node within the struct
+ */
+#define hash_for_each(name, bkt, obj, member)				\
+	for ((bkt) = 0, obj = NULL; obj == NULL && (bkt) < HASH_SIZE(name);\
+			(bkt)++)\
+		hlist_for_each_entry(obj, &name[bkt], member)
+
+/**
+ * hash_for_each_safe - iterate over a hashtable safe against removal of
+ * hash entry
+ * @name: hashtable to iterate
+ * @bkt: integer to use as bucket loop cursor
+ * @tmp: a &struct used for temporary storage
+ * @obj: the type * to use as a loop cursor for each entry
+ * @member: the name of the hlist_node within the struct
+ */
+#define hash_for_each_safe(name, bkt, tmp, obj, member)			\
+	for ((bkt) = 0, obj = NULL; obj == NULL && (bkt) < HASH_SIZE(name);\
+			(bkt)++)\
+		hlist_for_each_entry_safe(obj, tmp, &name[bkt], member)
+
+/**
+ * hash_for_each_possible - iterate over all possible objects hashing to the
+ * same bucket
+ * @name: hashtable to iterate
+ * @obj: the type * to use as a loop cursor for each entry
+ * @member: the name of the hlist_node within the struct
+ * @key: the key of the objects to iterate over
+ */
+#define hash_for_each_possible(name, obj, member, key)			\
+	hlist_for_each_entry(obj, &name[hash_min(key, HASH_BITS(name))], member)
+
+#endif
diff --git a/include/erofs/internal.h b/include/erofs/internal.h
index 5384946..25ce7b5 100644
--- a/include/erofs/internal.h
+++ b/include/erofs/internal.h
@@ -61,7 +61,7 @@ struct erofs_sb_info {
 extern struct erofs_sb_info sbi;
 
 struct erofs_inode {
-	struct list_head i_hash, i_subdirs;
+	struct list_head i_hash, i_subdirs, i_xattrs;
 
 	unsigned int i_count;
 	struct erofs_inode *i_parent;
diff --git a/include/erofs/xattr.h b/include/erofs/xattr.h
new file mode 100644
index 0000000..29df025
--- /dev/null
+++ b/include/erofs/xattr.h
@@ -0,0 +1,48 @@
+// SPDX-License-Identifier: GPL-2.0+
+/*
+ * erofs_utils/include/erofs/xattr.h
+ *
+ * Originally contributed by an anonymous person,
+ * heavily changed by Li Guifu <blucerlee@gmail.com>
+ *                and Gao Xiang <xiang@kernel.org>
+ */
+#ifndef __EROFS_XATTR_H
+#define __EROFS_XATTR_H
+
+#include "internal.h"
+
+#define EROFS_INODE_XATTR_ICOUNT(_size)	({\
+	u32 __size = le16_to_cpu(_size); \
+	((__size) == 0) ? 0 : \
+	(_size - sizeof(struct erofs_xattr_ibody_header)) / \
+	sizeof(struct erofs_xattr_entry) + 1; })
+
+#ifndef XATTR_USER_PREFIX
+#define XATTR_USER_PREFIX	"user."
+#endif
+#ifndef XATTR_USER_PREFIX_LEN
+#define XATTR_USER_PREFIX_LEN (sizeof(XATTR_USER_PREFIX) - 1)
+#endif
+#ifndef XATTR_SECURITY_PREFIX
+#define XATTR_SECURITY_PREFIX	"security."
+#endif
+#ifndef XATTR_SECURITY_PREFIX_LEN
+#define XATTR_SECURITY_PREFIX_LEN (sizeof(XATTR_SECURITY_PREFIX) - 1)
+#endif
+#ifndef XATTR_TRUSTED_PREFIX
+#define XATTR_TRUSTED_PREFIX	"trusted."
+#endif
+#ifndef XATTR_TRUSTED_PREFIX_LEN
+#define XATTR_TRUSTED_PREFIX_LEN (sizeof(XATTR_TRUSTED_PREFIX) - 1)
+#endif
+#ifndef XATTR_NAME_POSIX_ACL_ACCESS
+#define XATTR_NAME_POSIX_ACL_ACCESS "system.posix_acl_access"
+#endif
+#ifndef XATTR_NAME_POSIX_ACL_DEFAULT
+#define XATTR_NAME_POSIX_ACL_DEFAULT "system.posix_acl_default"
+#endif
+
+int erofs_prepare_xattr_ibody(const char *path, struct list_head *ixattrs);
+char *erofs_export_xattr_ibody(struct list_head *ixattrs, unsigned int size);
+
+#endif
diff --git a/lib/Makefile.am b/lib/Makefile.am
index dea82f7..1ff81f9 100644
--- a/lib/Makefile.am
+++ b/lib/Makefile.am
@@ -2,7 +2,8 @@
 # Makefile.am
 
 noinst_LTLIBRARIES = liberofs.la
-liberofs_la_SOURCES = config.c io.c cache.c inode.c compress.c compressor.c
+liberofs_la_SOURCES = config.c io.c cache.c inode.c xattr.c \
+		      compress.c compressor.c
 liberofs_la_CFLAGS = -Wall -Werror -I$(top_srcdir)/include
 if ENABLE_LZ4
 liberofs_la_CFLAGS += ${LZ4_CFLAGS}
diff --git a/lib/config.c b/lib/config.c
index 46625d7..cb42706 100644
--- a/lib/config.c
+++ b/lib/config.c
@@ -21,6 +21,7 @@ void erofs_init_configure(void)
 	cfg.c_dry_run  = false;
 	cfg.c_compr_level_master = -1;
 	cfg.c_force_inodeversion = 0;
+	cfg.c_inline_xattr_tolerance = 1;
 	cfg.c_unix_timestamp = -1;
 }
 
diff --git a/lib/inode.c b/lib/inode.c
index 395caae..b7121e0 100644
--- a/lib/inode.c
+++ b/lib/inode.c
@@ -20,6 +20,7 @@
 #include "erofs/cache.h"
 #include "erofs/io.h"
 #include "erofs/compress.h"
+#include "erofs/xattr.h"
 
 struct erofs_sb_info sbi;
 
@@ -365,6 +366,7 @@ fail:
 static bool erofs_bh_flush_write_inode(struct erofs_buffer_head *bh)
 {
 	struct erofs_inode *const inode = bh->fsprivate;
+	const u16 icount = EROFS_INODE_XATTR_ICOUNT(inode->xattr_isize);
 	erofs_off_t off = erofs_btell(bh, false);
 	union {
 		struct erofs_inode_compact dic;
@@ -375,6 +377,7 @@ static bool erofs_bh_flush_write_inode(struct erofs_buffer_head *bh)
 	switch (inode->inode_isize) {
 	case sizeof(struct erofs_inode_compact):
 		u.dic.i_format = cpu_to_le16(0 | (inode->datalayout << 1));
+		u.dic.i_xattr_icount = cpu_to_le16(icount);
 		u.dic.i_mode = cpu_to_le16(inode->i_mode);
 		u.dic.i_nlink = cpu_to_le16(inode->i_nlink);
 		u.dic.i_size = cpu_to_le32((u32)inode->i_size);
@@ -404,6 +407,7 @@ static bool erofs_bh_flush_write_inode(struct erofs_buffer_head *bh)
 		break;
 	case sizeof(struct erofs_inode_extended):
 		u.die.i_format = cpu_to_le16(1 | (inode->datalayout << 1));
+		u.die.i_xattr_icount = cpu_to_le16(icount);
 		u.die.i_mode = cpu_to_le16(inode->i_mode);
 		u.die.i_nlink = cpu_to_le32(inode->i_nlink);
 		u.die.i_size = cpu_to_le64(inode->i_size);
@@ -445,6 +449,20 @@ static bool erofs_bh_flush_write_inode(struct erofs_buffer_head *bh)
 		return false;
 	off += inode->inode_isize;
 
+	if (inode->xattr_isize) {
+		char *xattrs = erofs_export_xattr_ibody(&inode->i_xattrs,
+							inode->xattr_isize);
+		if (IS_ERR(xattrs))
+			return false;
+
+		ret = dev_write(xattrs, off, inode->xattr_isize);
+		free(xattrs);
+		if (ret)
+			return false;
+
+		off += inode->xattr_isize;
+	}
+
 	if (inode->extent_isize) {
 		/* write compression metadata */
 		off = Z_EROFS_VLE_EXTENT_ALIGN(off);
@@ -499,8 +517,10 @@ int erofs_prepare_inode_buffer(struct erofs_inode *inode)
 
 	DBG_BUGON(inode->bh || inode->bh_inline);
 
-	inodesize = inode->inode_isize + inode->xattr_isize +
-		    inode->extent_isize;
+	inodesize = inode->inode_isize + inode->xattr_isize;
+	if (inode->extent_isize)
+		inodesize = Z_EROFS_VLE_EXTENT_ALIGN(inodesize) +
+			    inode->extent_isize;
 
 	if (is_inode_layout_compression(inode))
 		goto noinline;
@@ -707,6 +727,8 @@ struct erofs_inode *erofs_new_inode(void)
 	inode->i_count = 1;
 
 	init_list_head(&inode->i_subdirs);
+	init_list_head(&inode->i_xattrs);
+
 	inode->idata_size = 0;
 	inode->xattr_isize = 0;
 	inode->extent_isize = 0;
@@ -795,6 +817,11 @@ struct erofs_inode *erofs_mkfs_build_tree(struct erofs_inode *dir)
 	struct dirent *dp;
 	struct erofs_dentry *d;
 
+	ret = erofs_prepare_xattr_ibody(dir->i_srcpath, &dir->i_xattrs);
+	if (ret < 0)
+		return ERR_PTR(ret);
+	dir->xattr_isize = ret;
+
 	if (!S_ISDIR(dir->i_mode)) {
 		if (S_ISLNK(dir->i_mode)) {
 			char *const symlink = malloc(dir->i_size);
diff --git a/lib/xattr.c b/lib/xattr.c
new file mode 100644
index 0000000..d07d325
--- /dev/null
+++ b/lib/xattr.c
@@ -0,0 +1,309 @@
+// SPDX-License-Identifier: GPL-2.0+
+/*
+ * erofs_utils/lib/xattr.c
+ *
+ * Originally contributed by an anonymous person,
+ * heavily changed by Li Guifu <blucerlee@gmail.com>
+ *                and Gao Xiang <hsiangkao@aol.com>
+ */
+#include <stdlib.h>
+#include <sys/xattr.h>
+#ifdef HAVE_LINUX_XATTR_H
+#include <linux/xattr.h>
+#endif
+#include "erofs/print.h"
+#include "erofs/hashtable.h"
+#include "erofs/xattr.h"
+
+#define EA_HASHTABLE_BITS 16
+
+struct xattr_item {
+	const char *kvbuf;
+	unsigned int hash[2], len[2], count;
+	u8 prefix;
+	struct hlist_node node;
+};
+
+struct inode_xattr_node {
+	struct list_head list;
+	struct xattr_item *item;
+};
+
+static DECLARE_HASHTABLE(ea_hashtable, EA_HASHTABLE_BITS);
+
+static struct xattr_prefix {
+	const char *prefix;
+	u16 prefix_len;
+} xattr_types[] = {
+	[EROFS_XATTR_INDEX_USER] = {
+		XATTR_USER_PREFIX,
+		XATTR_USER_PREFIX_LEN
+	}, [EROFS_XATTR_INDEX_POSIX_ACL_ACCESS] = {
+		XATTR_NAME_POSIX_ACL_ACCESS,
+		sizeof(XATTR_NAME_POSIX_ACL_ACCESS) - 1
+	}, [EROFS_XATTR_INDEX_POSIX_ACL_DEFAULT] = {
+		XATTR_NAME_POSIX_ACL_DEFAULT,
+		sizeof(XATTR_NAME_POSIX_ACL_DEFAULT) - 1
+	}, [EROFS_XATTR_INDEX_TRUSTED] = {
+		XATTR_TRUSTED_PREFIX,
+		XATTR_TRUSTED_PREFIX_LEN
+	}, [EROFS_XATTR_INDEX_SECURITY] = {
+		XATTR_SECURITY_PREFIX,
+		XATTR_SECURITY_PREFIX_LEN
+	}
+};
+
+static unsigned int BKDRHash(char *str, unsigned int len)
+{
+	const unsigned int seed = 131313;
+	unsigned int hash = 0;
+
+	while (len) {
+		hash = hash * seed + (*str++);
+		--len;
+	}
+	return hash;
+}
+
+static unsigned int xattr_item_hash(u8 prefix, char *buf,
+				    unsigned int len[2], unsigned int hash[2])
+{
+	hash[0] = BKDRHash(buf, len[0]);	/* key */
+	hash[1] = BKDRHash(buf + len[0], len[1]);	/* value */
+
+	return prefix ^ hash[0] ^ hash[1];
+}
+
+static unsigned int put_xattritem(struct xattr_item *item)
+{
+	if (item->count > 1)
+		return --item->count;
+	free(item);
+	return 0;
+}
+
+static struct xattr_item *get_xattritem(u8 prefix, char *kvbuf,
+					unsigned int len[2])
+{
+	struct xattr_item *item;
+	unsigned int hash[2], hkey;
+
+	hkey = xattr_item_hash(prefix, kvbuf, len, hash);
+
+	hash_for_each_possible(ea_hashtable, item, node, hkey) {
+		if (prefix == item->prefix &&
+		    item->len[0] == len[0] && item->len[1] == len[1] &&
+		    item->hash[0] == hash[0] && item->hash[1] == hash[1] &&
+		    !memcmp(kvbuf, item->kvbuf, len[0] + len[1])) {
+			free(kvbuf);
+			++item->count;
+			return item;
+		}
+	}
+
+	item = malloc(sizeof(*item));
+	if (!item) {
+		free(kvbuf);
+		return ERR_PTR(-ENOMEM);
+	}
+	INIT_HLIST_NODE(&item->node);
+	item->count = 1;
+	item->kvbuf = kvbuf;
+	item->len[0] = len[0];
+	item->len[1] = len[1];
+	item->hash[0] = hash[0];
+	item->hash[1] = hash[1];
+	item->prefix = prefix;
+	hash_add(ea_hashtable, &item->node, hkey);
+	return item;
+}
+
+static bool match_prefix(const char *key, u8 *index, u16 *len)
+{
+	struct xattr_prefix *p;
+
+	for (p = xattr_types; p < xattr_types + ARRAY_SIZE(xattr_types); ++p) {
+		if (p->prefix && !strncmp(p->prefix, key, p->prefix_len)) {
+			*len = p->prefix_len;
+			*index = p - xattr_types;
+			return true;
+		}
+	}
+	return false;
+}
+
+static struct xattr_item *parse_one_xattr(const char *path, const char *key,
+					  unsigned int keylen)
+{
+	ssize_t ret;
+	u8 prefix;
+	u16 prefixlen;
+	unsigned int len[2];
+	char *kvbuf;
+
+	erofs_dbg("parse xattr [%s] of %s", path, key);
+
+	if (!match_prefix(key, &prefix, &prefixlen))
+		return ERR_PTR(-ENODATA);
+
+	DBG_BUGON(keylen < prefixlen);
+
+	/* determine length of the value */
+	ret = lgetxattr(path, key, NULL, 0);
+	if (ret < 0)
+		return ERR_PTR(-errno);
+	len[1] = ret;
+
+	/* allocate key-value buffer */
+	len[0] = keylen - prefixlen;
+
+	kvbuf = malloc(len[0] + len[1]);
+	if (!kvbuf)
+		return ERR_PTR(-ENOMEM);
+
+	memcpy(kvbuf, key + prefixlen, len[0]);
+	if (len[1]) {
+		/* copy value to buffer */
+		ret = lgetxattr(path, key, kvbuf + len[0], len[1]);
+		if (ret < 0) {
+			free(kvbuf);
+			return ERR_PTR(-errno);
+		}
+		if (len[1] != ret) {
+			erofs_err("size of xattr value got changed just now (%u-> %ld)",
+				  len[1], (long)ret);
+			len[1] = ret;
+		}
+	}
+	return get_xattritem(prefix, kvbuf, len);
+}
+
+static int inode_xattr_add(struct list_head *hlist, struct xattr_item *item)
+{
+	struct inode_xattr_node *node = malloc(sizeof(*node));
+
+	if (!node)
+		return -ENOMEM;
+	init_list_head(&node->list);
+	node->item = item;
+	list_add(&node->list, hlist);
+	return 0;
+}
+
+static int read_xattrs_from_file(const char *path, struct list_head *ixattrs)
+{
+	int ret = 0;
+	char *keylst, *key;
+	ssize_t kllen = llistxattr(path, NULL, 0);
+
+	if (kllen < 0 && errno != ENODATA) {
+		erofs_err("llistxattr to get the size of names for %s failed",
+			  path);
+		return -errno;
+	}
+	if (kllen <= 1)
+		return 0;
+
+	keylst = malloc(kllen);
+	if (!keylst)
+		return -ENOMEM;
+
+	/* copy the list of attribute keys to the buffer.*/
+	kllen = llistxattr(path, keylst, kllen);
+	if (kllen < 0) {
+		erofs_err("llistxattr to get names for %s failed", path);
+		ret = -errno;
+		goto err;
+	}
+
+	/*
+	 * loop over the list of zero terminated strings with the
+	 * attribute keys. Use the remaining buffer length to determine
+	 * the end of the list.
+	 */
+	key = keylst;
+	while (kllen > 0) {
+		unsigned int keylen = strlen(key);
+		struct xattr_item *item = parse_one_xattr(path, key, keylen);
+
+		if (IS_ERR(item)) {
+			ret = PTR_ERR(item);
+			goto err;
+		}
+
+		if (ixattrs) {
+			ret = inode_xattr_add(ixattrs, item);
+			if (ret < 0)
+				goto err;
+		}
+		kllen -= keylen + 1;
+		key += keylen + 1;
+	}
+err:
+	free(keylst);
+	return ret;
+
+}
+
+int erofs_prepare_xattr_ibody(const char *path, struct list_head *ixattrs)
+{
+	int ret;
+	struct inode_xattr_node *node;
+
+	/* check if xattr is disabled */
+	if (cfg.c_inline_xattr_tolerance < 0)
+		return 0;
+
+	ret = read_xattrs_from_file(path, ixattrs);
+	if (ret < 0)
+		return ret;
+
+	if (list_empty(ixattrs))
+		return 0;
+
+	/* get xattr ibody size */
+	ret = sizeof(struct erofs_xattr_ibody_header);
+	list_for_each_entry(node, ixattrs, list) {
+		const struct xattr_item *item = node->item;
+
+		ret += sizeof(struct erofs_xattr_entry);
+		ret = EROFS_XATTR_ALIGN(ret + item->len[0] + item->len[1]);
+	}
+	return ret;
+}
+
+char *erofs_export_xattr_ibody(struct list_head *ixattrs, unsigned int size)
+{
+	struct inode_xattr_node *node, *n;
+	struct erofs_xattr_ibody_header *header;
+	unsigned int p;
+	char *buf = calloc(1, size);
+
+	if (!buf)
+		return ERR_PTR(-ENOMEM);
+
+	header = (struct erofs_xattr_ibody_header *)buf;
+	header->h_shared_count = 0;
+
+	p = sizeof(struct erofs_xattr_ibody_header);
+	list_for_each_entry_safe(node, n, ixattrs, list) {
+		struct xattr_item *const item = node->item;
+		const struct erofs_xattr_entry entry = {
+			.e_name_index = item->prefix,
+			.e_name_len = item->len[0],
+			.e_value_size = cpu_to_le16(item->len[1])
+		};
+
+		memcpy(buf + p, &entry, sizeof(entry));
+		p += sizeof(struct erofs_xattr_entry);
+		memcpy(buf + p, item->kvbuf, item->len[0] + item->len[1]);
+		p = EROFS_XATTR_ALIGN(p + item->len[0] + item->len[1]);
+
+		list_del(&node->list);
+		free(node);
+		put_xattritem(item);
+	}
+	DBG_BUGON(p > size);
+	return buf;
+}
+
diff --git a/mkfs/main.c b/mkfs/main.c
index 536b784..0df2a96 100644
--- a/mkfs/main.c
+++ b/mkfs/main.c
@@ -28,6 +28,7 @@ static void usage(void)
 	fprintf(stderr, "Generate erofs image from DIRECTORY to FILE, and [options] are:\n");
 	fprintf(stderr, " -zX[,Y]   X=compressor (Y=compression level, optional)\n");
 	fprintf(stderr, " -d#       set output message level to # (maximum 9)\n");
+	fprintf(stderr, " -x#       set xattr tolerance to # (< 0, disable xattrs; default 1)\n");
 	fprintf(stderr, " -EX[,...] X=extended options\n");
 	fprintf(stderr, " -T#       set a fixed UNIX timestamp # to all files\n");
 }
@@ -94,7 +95,7 @@ static int mkfs_parse_options_cfg(int argc, char *argv[])
 	char *endptr;
 	int opt, i;
 
-	while ((opt = getopt(argc, argv, "d:z:E:T:")) != -1) {
+	while ((opt = getopt(argc, argv, "d:x:z:E:T:")) != -1) {
 		switch (opt) {
 		case 'z':
 			if (!optarg) {
@@ -122,6 +123,15 @@ static int mkfs_parse_options_cfg(int argc, char *argv[])
 			cfg.c_dbg_lvl = i;
 			break;
 
+		case 'x':
+			i = strtol(optarg, &endptr, 0);
+			if (*endptr != '\0') {
+				erofs_err("invalid xattr tolerance %s", optarg);
+				return -EINVAL;
+			}
+			cfg.c_inline_xattr_tolerance = i;
+			break;
+
 		case 'E':
 			opt = parse_extended_opts(optarg);
 			if (opt)
-- 
2.17.1

