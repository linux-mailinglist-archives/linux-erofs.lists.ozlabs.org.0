Return-Path: <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>
X-Original-To: lists+linux-erofs@lfdr.de
Delivered-To: lists+linux-erofs@lfdr.de
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2401:3900:2:1::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 28E9E7815C
	for <lists+linux-erofs@lfdr.de>; Sun, 28 Jul 2019 22:00:37 +0200 (CEST)
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2401:3900:2:1::3])
	by lists.ozlabs.org (Postfix) with ESMTP id 45xYb54P9qzDqRR
	for <lists+linux-erofs@lfdr.de>; Mon, 29 Jul 2019 06:00:33 +1000 (AEST)
X-Original-To: linux-erofs@lists.ozlabs.org
Delivered-To: linux-erofs@lists.ozlabs.org
Authentication-Results: lists.ozlabs.org;
 spf=none (mailfrom) smtp.mailfrom=grr.la
 (client-ip=142.11.246.176; helo=grr.la;
 envelope-from=htyuxe+dhbrei4sq0df8@grr.la; receiver=<UNKNOWN>)
Authentication-Results: lists.ozlabs.org;
 dmarc=none (p=none dis=none) header.from=grr.la
X-Greylist: delayed 825 seconds by postgrey-1.36 at bilbo;
 Mon, 29 Jul 2019 06:00:23 AEST
Received: from grr.la (hwsrv-520519.hostwindsdns.com [142.11.246.176])
 by lists.ozlabs.org (Postfix) with ESMTP id 45xYZv0lTLzDqQc
 for <linux-erofs@lists.ozlabs.org>; Mon, 29 Jul 2019 06:00:22 +1000 (AEST)
Date: Sat, 26 Jul 2019 09:50:30 -0200
To: linux-erofs@lists.ozlabs.org
From: htyuxe+dhbrei4sq0df8@grr.la
Subject: [PATCH] erofs-utils: introduce xattr support
Message-Id: <20190726095030.012035@grr.la>
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

load xattrs from source files and pack them into target image.
---
 include/erofs/hashtable.h | 502 ++++++++++++++++++++++++++++++++++++++
 include/erofs/internal.h  |   2 +-
 include/erofs/xattr.h     |  22 ++
 lib/Makefile.am           |   3 +-
 lib/inode.c               |  23 ++
 lib/xattr.c               | 319 ++++++++++++++++++++++++
 6 files changed, 869 insertions(+), 2 deletions(-)
 create mode 100644 include/erofs/hashtable.h
 create mode 100644 include/erofs/xattr.h
 create mode 100644 lib/xattr.c

diff --git a/include/erofs/hashtable.h b/include/erofs/hashtable.h
new file mode 100644
index 0000000..349a655
--- /dev/null
+++ b/include/erofs/hashtable.h
@@ -0,0 +1,502 @@
+/* SPDX-License-Identifier: GPL-2.0+ */
+/*
+ * include/erofs/hashtable.h
+ *
+ */
+
+#ifndef __EROFS_HASHTABLE_H
+#define __EROFS_HASHTABLE_H
+
+#define BITS_PER_LONG 32
+#ifndef __always_inline
+#define __always_inline inline
+#endif
+
+/* 2^31 + 2^29 - 2^25 + 2^22 - 2^19 - 2^16 + 1 */
+#define GOLDEN_RATIO_PRIME_32 0x9e370001UL
+/*  2^63 + 2^61 - 2^57 + 2^54 - 2^51 - 2^18 + 1 */
+#define GOLDEN_RATIO_PRIME_64 0x9e37fffffffc0001UL
+
+#if BITS_PER_LONG == 32
+#define GOLDEN_RATIO_PRIME GOLDEN_RATIO_PRIME_32
+#define hash_long(val, bits) hash_32(val, bits)
+#elif BITS_PER_LONG == 64
+#define hash_long(val, bits) hash_64(val, bits)
+#define GOLDEN_RATIO_PRIME GOLDEN_RATIO_PRIME_64
+#else
+#error Wordsize not 32 or 64
+#endif
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
+#undef offsetof
+#ifdef __compiler_offsetof
+#define offsetof(TYPE, MEMBER) __compiler_offsetof(TYPE, MEMBER)
+#else
+#define offsetof(TYPE, MEMBER) ((size_t) &((TYPE *)0)->MEMBER)
+#endif
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
+#define hlist_for_each_entry_safe(pos, n, head, member) 		\
+	for (pos = hlist_entry_safe((head)->first, typeof(*pos), member);\
+		pos && ({ n = pos->member.next; 1; });			\
+		pos = hlist_entry_safe(n, typeof(*pos), member))
+
+static __always_inline u64 hash_64(u64 val, unsigned int bits)
+{
+	u64 hash = val;
+
+#if defined(CONFIG_ARCH_HAS_FAST_MULTIPLIER) && BITS_PER_LONG == 64
+	hash = hash * GOLDEN_RATIO_PRIME_64;
+#else
+	/*  Sigh, gcc can't optimise this alone like it does for 32 bits. */
+	u64 n = hash;
+
+	n <<= 18;
+	hash -= n;
+	n <<= 33;
+	hash -= n;
+	n <<= 3;
+	hash += n;
+	n <<= 3;
+	hash -= n;
+	n <<= 4;
+	hash += n;
+	n <<= 2;
+	hash += n;
+#endif
+
+	/* High bits are more random, so use them. */
+	return hash >> (64 - bits);
+}
+
+static inline u32 hash_32(u32 val, unsigned int bits)
+{
+	/* On some cpus multiply is faster, on others gcc will do shifts */
+	u32 hash = val * GOLDEN_RATIO_PRIME_32;
+
+	/* High bits are more random, so use them. */
+	return hash >> (32 - bits);
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
+static const uint16_t crc16tab[256] = {
+	0x0000, 0x1021, 0x2042, 0x3063, 0x4084, 0x50a5, 0x60c6, 0x70e7,
+	0x8108, 0x9129, 0xa14a, 0xb16b, 0xc18c, 0xd1ad, 0xe1ce, 0xf1ef,
+	0x1231, 0x0210, 0x3273, 0x2252, 0x52b5, 0x4294, 0x72f7, 0x62d6,
+	0x9339, 0x8318, 0xb37b, 0xa35a, 0xd3bd, 0xc39c, 0xf3ff, 0xe3de,
+	0x2462, 0x3443, 0x0420, 0x1401, 0x64e6, 0x74c7, 0x44a4, 0x5485,
+	0xa56a, 0xb54b, 0x8528, 0x9509, 0xe5ee, 0xf5cf, 0xc5ac, 0xd58d,
+	0x3653, 0x2672, 0x1611, 0x0630, 0x76d7, 0x66f6, 0x5695, 0x46b4,
+	0xb75b, 0xa77a, 0x9719, 0x8738, 0xf7df, 0xe7fe, 0xd79d, 0xc7bc,
+	0x48c4, 0x58e5, 0x6886, 0x78a7, 0x0840, 0x1861, 0x2802, 0x3823,
+	0xc9cc, 0xd9ed, 0xe98e, 0xf9af, 0x8948, 0x9969, 0xa90a, 0xb92b,
+	0x5af5, 0x4ad4, 0x7ab7, 0x6a96, 0x1a71, 0x0a50, 0x3a33, 0x2a12,
+	0xdbfd, 0xcbdc, 0xfbbf, 0xeb9e, 0x9b79, 0x8b58, 0xbb3b, 0xab1a,
+	0x6ca6, 0x7c87, 0x4ce4, 0x5cc5, 0x2c22, 0x3c03, 0x0c60, 0x1c41,
+	0xedae, 0xfd8f, 0xcdec, 0xddcd, 0xad2a, 0xbd0b, 0x8d68, 0x9d49,
+	0x7e97, 0x6eb6, 0x5ed5, 0x4ef4, 0x3e13, 0x2e32, 0x1e51, 0x0e70,
+	0xff9f, 0xefbe, 0xdfdd, 0xcffc, 0xbf1b, 0xaf3a, 0x9f59, 0x8f78,
+	0x9188, 0x81a9, 0xb1ca, 0xa1eb, 0xd10c, 0xc12d, 0xf14e, 0xe16f,
+	0x1080, 0x00a1, 0x30c2, 0x20e3, 0x5004, 0x4025, 0x7046, 0x6067,
+	0x83b9, 0x9398, 0xa3fb, 0xb3da, 0xc33d, 0xd31c, 0xe37f, 0xf35e,
+	0x02b1, 0x1290, 0x22f3, 0x32d2, 0x4235, 0x5214, 0x6277, 0x7256,
+	0xb5ea, 0xa5cb, 0x95a8, 0x8589, 0xf56e, 0xe54f, 0xd52c, 0xc50d,
+	0x34e2, 0x24c3, 0x14a0, 0x0481, 0x7466, 0x6447, 0x5424, 0x4405,
+	0xa7db, 0xb7fa, 0x8799, 0x97b8, 0xe75f, 0xf77e, 0xc71d, 0xd73c,
+	0x26d3, 0x36f2, 0x0691, 0x16b0, 0x6657, 0x7676, 0x4615, 0x5634,
+	0xd94c, 0xc96d, 0xf90e, 0xe92f, 0x99c8, 0x89e9, 0xb98a, 0xa9ab,
+	0x5844, 0x4865, 0x7806, 0x6827, 0x18c0, 0x08e1, 0x3882, 0x28a3,
+	0xcb7d, 0xdb5c, 0xeb3f, 0xfb1e, 0x8bf9, 0x9bd8, 0xabbb, 0xbb9a,
+	0x4a75, 0x5a54, 0x6a37, 0x7a16, 0x0af1, 0x1ad0, 0x2ab3, 0x3a92,
+	0xfd2e, 0xed0f, 0xdd6c, 0xcd4d, 0xbdaa, 0xad8b, 0x9de8, 0x8dc9,
+	0x7c26, 0x6c07, 0x5c64, 0x4c45, 0x3ca2, 0x2c83, 0x1ce0, 0x0cc1,
+	0xef1f, 0xff3e, 0xcf5d, 0xdf7c, 0xaf9b, 0xbfba, 0x8fd9, 0x9ff8,
+	0x6e17, 0x7e36, 0x4e55, 0x5e74, 0x2e93, 0x3eb2, 0x0ed1, 0x1ef0
+};
+
+uint16_t crc16(const char *buf, int len)
+{
+	int counter;
+	uint16_t crc = 0;
+
+	for (counter = 0; counter < len; counter++)
+		crc = (crc<<8) ^ crc16tab[((crc>>8) ^ *buf++)&0x00FF];
+	return crc;
+}
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
index b7ce6f8..33a72b5 100644
--- a/include/erofs/internal.h
+++ b/include/erofs/internal.h
@@ -59,7 +59,7 @@ struct erofs_sb_info {
 extern struct erofs_sb_info sbi;
 
 struct erofs_inode {
-	struct list_head i_hash, i_subdirs;
+	struct list_head i_hash, i_subdirs, i_xattrs;
 
 	unsigned int i_count;
 	struct erofs_inode *i_parent;
diff --git a/include/erofs/xattr.h b/include/erofs/xattr.h
new file mode 100644
index 0000000..dff9fd6
--- /dev/null
+++ b/include/erofs/xattr.h
@@ -0,0 +1,22 @@
+// SPDX-License-Identifier: GPL-2.0+
+/*
+ * include/erofs/xattr.h
+ *
+ */
+
+#ifndef __EROFS_XATTR_H
+#define __EROFS_XATTR_H
+
+#define XATTR_COUNT(_size)	({\
+	u32 __size = le16_to_cpu(_size); \
+	((__size) == 0) ? 0 : \
+	(_size - sizeof(struct erofs_xattr_ibody_header)) / \
+	sizeof(struct erofs_xattr_entry) + 1; })
+
+
+int cust_xattr(struct list_head *hlist);
+int read_xattr_from_src(const char *path, struct list_head *hlist);
+int xattr_entry_size(struct list_head *hlist);
+char *xattr_data(struct list_head *hlist, int size);
+
+#endif
diff --git a/lib/Makefile.am b/lib/Makefile.am
index dea82f7..cbe3243 100644
--- a/lib/Makefile.am
+++ b/lib/Makefile.am
@@ -2,7 +2,8 @@
 # Makefile.am
 
 noinst_LTLIBRARIES = liberofs.la
-liberofs_la_SOURCES = config.c io.c cache.c inode.c compress.c compressor.c
+liberofs_la_SOURCES = config.c io.c cache.c inode.c compress.c compressor.c \
+		      xattr.c
 liberofs_la_CFLAGS = -Wall -Werror -I$(top_srcdir)/include
 if ENABLE_LZ4
 liberofs_la_CFLAGS += ${LZ4_CFLAGS}
diff --git a/lib/inode.c b/lib/inode.c
index 8b38270..615f117 100644
--- a/lib/inode.c
+++ b/lib/inode.c
@@ -18,6 +18,7 @@
 #include "erofs/cache.h"
 #include "erofs/io.h"
 #include "erofs/compress.h"
+#include "erofs/xattr.h"
 
 struct erofs_sb_info sbi;
 
@@ -364,8 +365,10 @@ static bool erofs_bh_flush_write_inode(struct erofs_buffer_head *bh)
 	/* let's support v1 currently */
 	struct erofs_inode_v1 v1 = {0};
 	int ret;
+	uint16_t count = XATTR_COUNT(inode->xattr_isize);
 
 	v1.i_advise = cpu_to_le16(0 | (inode->data_mapping_mode << 1));
+	v1.i_xattr_icount = cpu_to_le16(count);
 	v1.i_mode = cpu_to_le16(inode->i_mode);
 	v1.i_nlink = cpu_to_le16(inode->i_nlink);
 	v1.i_size = cpu_to_le32((u32)inode->i_size);
@@ -399,6 +402,20 @@ static bool erofs_bh_flush_write_inode(struct erofs_buffer_head *bh)
 		return false;
 	off += inode->inode_isize;
 
+	if (inode->xattr_isize) {
+		char *pbuf = xattr_data(&inode->i_xattrs, inode->xattr_isize);
+
+		if (IS_ERR(pbuf))
+			return false;
+
+		ret = dev_write(pbuf, off, inode->xattr_isize);
+		free(pbuf);
+		if (ret)
+			return false;
+
+		off += inode->xattr_isize;
+	}
+
 	if (inode->extent_isize) {
 		/* write compression metadata */
 		off = Z_EROFS_VLE_EXTENT_ALIGN(off);
@@ -452,6 +469,7 @@ int erofs_prepare_inode_buffer(struct erofs_inode *inode)
 
 	DBG_BUGON(inode->bh || inode->bh_inline);
 
+	inode->xattr_isize = xattr_entry_size(&inode->i_xattrs);
 	inodesize = inode->inode_isize + inode->xattr_isize +
 		    inode->extent_isize;
 
@@ -612,6 +630,7 @@ struct erofs_inode *erofs_new_inode(void)
 	inode->i_count = 1;
 
 	init_list_head(&inode->i_subdirs);
+	init_list_head(&inode->i_xattrs);
 	inode->xattr_isize = 0;
 	inode->extent_isize = 0;
 
@@ -699,6 +718,10 @@ struct erofs_inode *erofs_mkfs_build_tree(struct erofs_inode *dir)
 	struct dirent *dp;
 	struct erofs_dentry *d;
 
+	ret = read_xattr_from_src(dir->i_srcpath, &dir->i_xattrs);
+	if (ret)
+		return ERR_PTR(ret);
+
 	if (!S_ISDIR(dir->i_mode)) {
 		if (S_ISLNK(dir->i_mode)) {
 			char *const symlink = malloc(dir->i_size);
diff --git a/lib/xattr.c b/lib/xattr.c
new file mode 100644
index 0000000..6278abc
--- /dev/null
+++ b/lib/xattr.c
@@ -0,0 +1,319 @@
+// SPDX-License-Identifier: GPL-2.0+
+/*
+ * lib/xattr.c
+ *
+ */
+
+#include <stdlib.h>
+#include <sys/types.h>
+#include <sys/xattr.h>
+#include <linux/xattr.h>
+#include <errno.h>
+#include <string.h>
+
+#include "erofs/defs.h"
+#include "erofs/print.h"
+#include "erofs/list.h"
+#include "erofs/internal.h"
+#include "erofs/hashtable.h"
+#include "err.h"
+#define EROFS_XATTR_HASH_TABLE_BITS 16
+
+struct xattr_item {
+	const char *buf;
+	unsigned int keylen;
+	unsigned int vallen;
+	unsigned int count;
+	u8 index;
+	struct hlist_node node;
+};
+
+struct xattr_list {
+	struct xattr_item *item;
+	struct list_head list;
+};
+
+DECLARE_HASHTABLE(my_hash_table, EROFS_XATTR_HASH_TABLE_BITS);
+
+struct xattr_prefix {
+	const char *prefix;
+	uint16_t prefix_len;
+	u8 index;
+} prefix[] = {
+	{
+		XATTR_USER_PREFIX,
+		XATTR_USER_PREFIX_LEN,
+		EROFS_XATTR_INDEX_USER
+	},
+	{
+		XATTR_SECURITY_PREFIX,
+		XATTR_SYSTEM_PREFIX_LEN,
+		EROFS_XATTR_INDEX_SECURITY
+	},
+	{
+		XATTR_TRUSTED_PREFIX,
+		XATTR_TRUSTED_PREFIX_LEN,
+		EROFS_XATTR_INDEX_TRUSTED
+	},
+	{NULL, 0, 0},
+};
+
+static inline void hxattr_add(struct hlist_node *node, uint16_t key)
+{
+	hash_add(my_hash_table, node, key);
+}
+
+static inline void hxattr_del(struct hlist_node *node)
+{
+	hash_del(node);
+}
+
+static struct xattr_item *hxattr_match(const char *buf, int len, u8 index)
+{
+	struct xattr_item *item;
+	uint16_t mkey = crc16(buf, len);
+
+	hash_for_each_possible(my_hash_table, item, node, mkey) {
+		if (index == item->index &&
+		    len == (item->keylen + item->vallen) &&
+		    !memcmp(buf, item->buf, len)) {
+			return item;
+		}
+	}
+
+	return ERR_PTR(-ENOENT);
+}
+
+static bool match_index(const char *key, u8 *index, uint16_t *len)
+{
+	struct xattr_prefix *p = prefix;
+
+	while (p->prefix) {
+		if (strncmp(p->prefix, key, p->prefix_len)) {
+			*len = p->prefix_len;
+			*index = p->index;
+			return true;
+		}
+		p++;
+	}
+
+	return false;
+}
+
+static struct xattr_item *new_xattr(const char *buf, u8 index,
+				    int keylen, int vallen)
+{
+	struct xattr_item *item = malloc(sizeof(*item));
+
+	if (!item)
+		return ERR_PTR(-ENOMEM);
+
+	memset(item, 0, sizeof(*item));
+	INIT_HLIST_NODE(&item->node);
+	item->buf = buf;
+	item->keylen = keylen;
+	item->vallen = vallen;
+	item->count = 1;
+	item->index = index;
+	if (!item->index)
+		return ERR_PTR(-EPERM);
+
+	return item;
+}
+
+static int xattr_add(struct list_head *hlist, struct xattr_item *item)
+{
+	struct xattr_list *mlist = malloc(sizeof(*mlist));
+
+	if (!mlist)
+		return -ENOMEM;
+
+	init_list_head(&mlist->list);
+	mlist->item = item;
+	list_add(&mlist->list, hlist);
+	return 0;
+}
+
+static struct xattr_item *list_xattr_value(const char *path, const char *key)
+{
+	ssize_t keylen, vallen;
+	char *kxattr;
+	struct xattr_item *item;
+	u8 index;
+	uint16_t prelen, suflen;
+
+	/* Output attribute key.*/
+	erofs_info("path:%s key: [%s] ", path, key);
+
+	keylen = strlen(key);
+	if (!match_index(key, &index, &prelen))
+		return ERR_PTR(-ENODATA);
+
+	BUG_ON(keylen < prelen);
+	/* Determine length of the value.*/
+	vallen = lgetxattr(path, key, NULL, 0);
+	if (vallen == -1)
+		return ERR_PTR(-errno);
+
+	/*
+	 * Allocate value buffer.
+	 * One extra byte is needed to append 0x00.
+	 */
+	suflen = keylen - prelen;
+	kxattr = malloc(suflen + vallen + 1);
+	if (!kxattr)
+		return ERR_PTR(-ENOMEM);
+
+	if (vallen == 0)
+		goto value_0;
+
+	/* Copy value to buffer.*/
+	vallen = lgetxattr(path, key, kxattr + suflen, vallen);
+	if (vallen == -1) {
+		free(kxattr);
+		return ERR_PTR(-errno);
+	}
+
+value_0:
+	memcpy(kxattr, key + prelen, suflen);
+	/* Output attribute value.*/
+	kxattr[suflen + vallen] = '\0';
+	erofs_info("value: [%s]", kxattr + suflen);
+
+	/* kxattr is used at xattr_add(), neednt free if SUCCESS */
+	item = hxattr_match(kxattr, suflen + vallen, index);
+	if (!IS_ERR(item)) {
+		item->count++;
+		free(kxattr);
+		return item;
+	}
+
+	item = new_xattr(kxattr, index, suflen, vallen);
+	if (IS_ERR(item))
+		free(kxattr);
+
+	return item;
+}
+
+int read_xattr_from_src(const char *path, struct list_head *hlist)
+{
+	int ret = 0;
+	char *kbuf, *key;
+	ssize_t buflen = llistxattr(path, NULL, 0);
+
+	if (buflen == -1)
+		return -errno;
+	else if (buflen == 0)
+		return 0;
+
+	/* Allocate the buffer.*/
+	kbuf = malloc(buflen);
+	if (!kbuf)
+		return -errno;
+
+	/* Copy the list of attribute keys to the buffer.*/
+	buflen = llistxattr(path, kbuf, buflen);
+	if (buflen == -1) {
+		ret = -errno;
+		goto exit_err;
+	}
+
+	/*
+	 * Loop over the list of zero terminated strings with the
+	 * attribute keys. Use the remaining buffer length to determine
+	 * the end of the list.
+	 */
+	key = kbuf;
+	while (buflen > 0) {
+		size_t keylen = strlen(key) + 1;
+		struct xattr_item *item = list_xattr_value(path, key);
+
+		if (!item) {
+			ret = -errno;
+			goto exit_err;
+		}
+
+		if (!hash_hashed(&item->node)) {
+			uint16_t mkey;
+
+			mkey = crc16(item->buf, item->keylen + item->vallen);
+			hxattr_add(&item->node, mkey);
+		}
+
+		if (hlist) {
+			ret = xattr_add(hlist, item);
+			if (ret < 0)
+				goto exit_err;
+		}
+
+		buflen -= keylen;
+		key += keylen;
+	}
+
+exit_err:
+	free(kbuf);
+	return ret;
+
+}
+
+int xattr_entry_size(struct list_head *hlist)
+{
+	int sum = 0;
+	struct xattr_list *lst;
+
+	if (list_empty(hlist))
+		return 0;
+
+	list_for_each_entry(lst, hlist, list) {
+		struct xattr_item *item = lst->item;
+
+		sum += sizeof(struct erofs_xattr_entry);
+		sum += item->keylen + item->vallen;
+		sum = EROFS_XATTR_ALIGN(sum);
+	}
+
+	sum += sizeof(struct erofs_xattr_ibody_header);
+
+	return EROFS_XATTR_ALIGN(sum);
+}
+
+char *xattr_data(struct list_head *hlist, int xattr_size)
+{
+	struct xattr_list *lst;
+	char *buf, *pbuf;
+	unsigned int size = 0;
+	struct erofs_xattr_ibody_header header = {
+		.h_checksum = 0,
+		.h_shared_count = 0,
+	};
+
+	erofs_info("xattr_size=%d", xattr_size);
+	buf = malloc(xattr_size);
+	if (!buf)
+		return ERR_PTR(-ENOMEM);
+
+	memset(buf, 0, xattr_size);
+	pbuf = buf + sizeof(struct erofs_xattr_ibody_header);
+
+	list_for_each_entry(lst, hlist, list) {
+		struct erofs_xattr_entry entry;
+		struct xattr_item *item = lst->item;
+
+		entry.e_name_index = item->index;
+		entry.e_name_len = item->keylen;
+		entry.e_value_size = cpu_to_le16(item->vallen);
+
+		BUG_ON(size > xattr_size);
+		memcpy(pbuf + size, &entry, sizeof(entry));
+
+		size += sizeof(struct erofs_xattr_entry);
+		memcpy(pbuf + size, item->buf, item->keylen + item->vallen);
+		size += item->keylen + item->vallen;
+		size = EROFS_XATTR_ALIGN(size);
+	}
+
+	memcpy(buf, &header, sizeof(header));
+
+	return buf;
+}
+
-- 
2.17.1



