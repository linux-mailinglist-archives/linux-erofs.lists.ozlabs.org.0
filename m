Return-Path: <linux-erofs+bounces-1140-lists+linux-erofs=lfdr.de@lists.ozlabs.org>
X-Original-To: lists+linux-erofs@lfdr.de
Delivered-To: lists+linux-erofs@lfdr.de
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	by mail.lfdr.de (Postfix) with ESMTPS id 9E0AEBABACE
	for <lists+linux-erofs@lfdr.de>; Tue, 30 Sep 2025 08:39:15 +0200 (CEST)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4cbT143sHTz3cZd;
	Tue, 30 Sep 2025 16:39:04 +1000 (AEST)
X-Original-To: linux-erofs@lists.ozlabs.org
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip=115.124.30.110
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1759214344;
	cv=none; b=grpYOln+FutG92fmb0f4QZXVXWXynPDigfwmoiMo8n4jB93HYfGcsr8ShuOIA9LUNxEj9QIfk4OlJMFVb6xDrOklttZTAeBjCP9bASF6458R4p/FyQAtfQWkEV6pV+QfHQyCaBtHmdapbWy2Dqws+SwgdzcwrDtZoheRzUkKb6cjnULPibnnYG1Egox2R2GMVIpzq7+YRC33LhL2VVFUtzeU3lDmkHp7FTh5C6MurtyCAzeugiHUJ0qG1VfLzrWU1xe5dLytJ1H27vSaaF6nRRRM0RNUhTn5nYahphCaGctwPNyaLleUzgIcOGHhrhY6vI8B5hxAtHKRlC97vYb1aA==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1759214344; c=relaxed/relaxed;
	bh=DdH4HBSCUv/yeUEYwJzq9uzu2y8iUQeaRHlMPi+9l6k=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=G0oiTgN0trmbof4V4fmHlCGQHHAb9LlSk2Ugqvn2FHvJLt7ceFbUjw3e12cUvgoKHOkU9nX74ha5Fo1HjujbgAEqzPIzY71pLgKndWNSS87WdiJKxD9oeXUnhnieVPxmtLevN3MnwDRty44BcnvXwHHiuMFVLSn4VA0nzCVYvpHR80lkCFSbSG9dlN5jm6JeE9ScoW9VxYPQdhlwbZKrfoTHSvqYs9d/fRVK8Fxqw6tgbeQI0v8+8oTWFWV1lY49Ev3ZJVUnAByjSLYwv8IeirmYSpXfhSXfyyNyVZaC3OJ7tY20AkjFxP2+KE+q0SP45rWW4p3yDrwAmtLHF8tRUA==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com; dkim=pass (1024-bit key; unprotected) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.a=rsa-sha256 header.s=default header.b=M0nppuN+; dkim-atps=neutral; spf=pass (client-ip=115.124.30.110; helo=out30-110.freemail.mail.aliyun.com; envelope-from=hsiangkao@linux.alibaba.com; receiver=lists.ozlabs.org) smtp.mailfrom=linux.alibaba.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (1024-bit key; unprotected) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.a=rsa-sha256 header.s=default header.b=M0nppuN+;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=linux.alibaba.com (client-ip=115.124.30.110; helo=out30-110.freemail.mail.aliyun.com; envelope-from=hsiangkao@linux.alibaba.com; receiver=lists.ozlabs.org)
Received: from out30-110.freemail.mail.aliyun.com (out30-110.freemail.mail.aliyun.com [115.124.30.110])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4cbT112JNwz3cZt
	for <linux-erofs@lists.ozlabs.org>; Tue, 30 Sep 2025 16:39:00 +1000 (AEST)
DKIM-Signature:v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=linux.alibaba.com; s=default;
	t=1759214337; h=From:To:Subject:Date:Message-ID:MIME-Version;
	bh=DdH4HBSCUv/yeUEYwJzq9uzu2y8iUQeaRHlMPi+9l6k=;
	b=M0nppuN+zfazmDWDRfd9bvPEHgrxW9hi8hPVFqU92zmDqpCfoVKZqamHAOpLAQ6DZXepVObrot+yKoEXCoUig2Mw/RzMnbe05R8Cruv50fzeX3ws25wbBbusRS7Xtn5dPFiku+eKOJtyMEewjb6bz6249vl+vbzHjlqJp4//a8A=
Received: from x31i01179.sqa.na131.tbsite.net(mailfrom:hsiangkao@linux.alibaba.com fp:SMTPD_---0WpARblo_1759214335 cluster:ay36)
          by smtp.aliyun-inc.com;
          Tue, 30 Sep 2025 14:38:56 +0800
From: Gao Xiang <hsiangkao@linux.alibaba.com>
To: linux-erofs@lists.ozlabs.org
Cc: Gao Xiang <hsiangkao@linux.alibaba.com>
Subject: [PATCH 5/5] erofs-utils: lib: remove `erofs/hashtable.h`
Date: Tue, 30 Sep 2025 14:38:47 +0800
Message-ID: <20250930063847.2143732-5-hsiangkao@linux.alibaba.com>
X-Mailer: git-send-email 2.43.5
In-Reply-To: <20250930063847.2143732-1-hsiangkao@linux.alibaba.com>
References: <20250930063847.2143732-1-hsiangkao@linux.alibaba.com>
X-Mailing-List: linux-erofs@lists.ozlabs.org
List-Id: <linux-erofs.lists.ozlabs.org>
List-Help: <mailto:linux-erofs+help@lists.ozlabs.org>
List-Owner: <mailto:linux-erofs+owner@lists.ozlabs.org>
List-Post: <mailto:linux-erofs@lists.ozlabs.org>
List-Subscribe: <mailto:linux-erofs+subscribe@lists.ozlabs.org>,
  <mailto:linux-erofs+subscribe-digest@lists.ozlabs.org>,
  <mailto:linux-erofs+subscribe-nomail@lists.ozlabs.org>
List-Unsubscribe: <mailto:linux-erofs+unsubscribe@lists.ozlabs.org>
Precedence: list
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-15.7 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,DKIM_VALID_EF,ENV_AND_HDR_SPF_MATCH,RCVD_IN_DNSWL_NONE,
	SPF_HELO_NONE,SPF_PASS,UNPARSEABLE_RELAY,USER_IN_DEF_DKIM_WL,
	USER_IN_DEF_SPF_WL autolearn=disabled version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-25) on lists.ozlabs.org

There is no in-tree user anymore.

Signed-off-by: Gao Xiang <hsiangkao@linux.alibaba.com>
---
 include/erofs/hashtable.h | 392 --------------------------------------
 lib/Makefile.am           |   1 -
 2 files changed, 393 deletions(-)
 delete mode 100644 include/erofs/hashtable.h

diff --git a/include/erofs/hashtable.h b/include/erofs/hashtable.h
deleted file mode 100644
index f4eca8d..0000000
--- a/include/erofs/hashtable.h
+++ /dev/null
@@ -1,392 +0,0 @@
-/* SPDX-License-Identifier: GPL-2.0 */
-/*
- * Original code taken from 'linux/include/linux/hash{,table}.h'
- */
-#ifndef __EROFS_HASHTABLE_H
-#define __EROFS_HASHTABLE_H
-
-#ifdef __cplusplus
-extern "C"
-{
-#endif
-
-/*
- * Fast hashing routine for ints,  longs and pointers.
- * (C) 2002 Nadia Yvette Chambers, IBM
- */
-
-/*
- * Statically sized hash table implementation
- * (C) 2012  Sasha Levin <levinsasha928@gmail.com>
- */
-
-#include "defs.h"
-
-/*
- * The "GOLDEN_RATIO_PRIME" is used in ifs/btrfs/brtfs_inode.h and
- * fs/inode.c.  It's not actually prime any more (the previous primes
- * were actively bad for hashing), but the name remains.
- */
-#if BITS_PER_LONG == 32
-#define GOLDEN_RATIO_PRIME GOLDEN_RATIO_32
-#define hash_long(val, bits) hash_32(val, bits)
-#elif BITS_PER_LONG == 64
-#define hash_long(val, bits) hash_64(val, bits)
-#define GOLDEN_RATIO_PRIME GOLDEN_RATIO_64
-#else
-#error Wordsize not 32 or 64
-#endif
-
-/*
- * This hash multiplies the input by a large odd number and takes the
- * high bits.  Since multiplication propagates changes to the most
- * significant end only, it is essential that the high bits of the
- * product be used for the hash value.
- *
- * Chuck Lever verified the effectiveness of this technique:
- * http://www.citi.umich.edu/techreports/reports/citi-tr-00-1.pdf
- *
- * Although a random odd number will do, it turns out that the golden
- * ratio phi = (sqrt(5)-1)/2, or its negative, has particularly nice
- * properties.  (See Knuth vol 3, section 6.4, exercise 9.)
- *
- * These are the negative, (1 - phi) = phi**2 = (3 - sqrt(5))/2,
- * which is very slightly easier to multiply by and makes no
- * difference to the hash distribution.
- */
-#define GOLDEN_RATIO_32 0x61C88647
-#define GOLDEN_RATIO_64 0x61C8864680B583EBull
-
-struct hlist_head {
-	struct hlist_node *first;
-};
-
-struct hlist_node {
-	struct hlist_node *next, **pprev;
-};
-
-/*
- * Architectures might want to move the poison pointer offset
- * into some well-recognized area such as 0xdead000000000000,
- * that is also not mappable by user-space exploits:
- */
-#ifdef CONFIG_ILLEGAL_POINTER_VALUE
-# define POISON_POINTER_DELTA _AC(CONFIG_ILLEGAL_POINTER_VALUE, UL)
-#else
-# define POISON_POINTER_DELTA 0
-#endif
-
-/*
- * These are non-NULL pointers that will result in page faults
- * under normal circumstances, used to verify that nobody uses
- * non-initialized list entries.
- */
-#define LIST_POISON1 ((void *) 0x00100100 + POISON_POINTER_DELTA)
-#define LIST_POISON2 ((void *) 0x00200200 + POISON_POINTER_DELTA)
-
-/*
- * Double linked lists with a single pointer list head.
- * Mostly useful for hash tables where the two pointer list head is
- * too wasteful.
- * You lose the ability to access the tail in O(1).
- */
-
-#define HLIST_HEAD_INIT { .first = NULL }
-#define HLIST_HEAD(name) struct hlist_head name = { .first = NULL }
-#define INIT_HLIST_HEAD(ptr) ((ptr)->first = NULL)
-static inline void INIT_HLIST_NODE(struct hlist_node *h)
-{
-	h->next = NULL;
-	h->pprev = NULL;
-}
-
-static inline int hlist_unhashed(const struct hlist_node *h)
-{
-	return !h->pprev;
-}
-
-static inline int hlist_empty(const struct hlist_head *h)
-{
-	return !h->first;
-}
-
-static inline void __hlist_del(struct hlist_node *n)
-{
-	struct hlist_node *next = n->next;
-	struct hlist_node **pprev = n->pprev;
-
-	*pprev = next;
-	if (next)
-		next->pprev = pprev;
-}
-
-static inline void hlist_del(struct hlist_node *n)
-{
-	__hlist_del(n);
-	n->next = LIST_POISON1;
-	n->pprev = LIST_POISON2;
-}
-
-static inline void hlist_del_init(struct hlist_node *n)
-{
-	if (!hlist_unhashed(n)) {
-		__hlist_del(n);
-		INIT_HLIST_NODE(n);
-	}
-}
-
-static inline void hlist_add_head(struct hlist_node *n, struct hlist_head *h)
-{
-	struct hlist_node *first = h->first;
-
-	n->next = first;
-	if (first)
-		first->pprev = &n->next;
-	h->first = n;
-	n->pprev = &h->first;
-}
-
-/* next must be != NULL */
-static inline void hlist_add_before(struct hlist_node *n,
-					struct hlist_node *next)
-{
-	n->pprev = next->pprev;
-	n->next = next;
-	next->pprev = &n->next;
-	*(n->pprev) = n;
-}
-
-static inline void hlist_add_behind(struct hlist_node *n,
-				    struct hlist_node *prev)
-{
-	n->next = prev->next;
-	prev->next = n;
-	n->pprev = &prev->next;
-
-	if (n->next)
-		n->next->pprev  = &n->next;
-}
-
-/* after that we'll appear to be on some hlist and hlist_del will work */
-static inline void hlist_add_fake(struct hlist_node *n)
-{
-	n->pprev = &n->next;
-}
-
-/*
- * Move a list from one list head to another. Fixup the pprev
- * reference of the first entry if it exists.
- */
-static inline void hlist_move_list(struct hlist_head *old,
-				   struct hlist_head *new)
-{
-	new->first = old->first;
-	if (new->first)
-		new->first->pprev = &new->first;
-	old->first = NULL;
-}
-
-#define hlist_entry(ptr, type, member) container_of(ptr, type, member)
-
-#define hlist_for_each(pos, head) \
-	for (pos = (head)->first; pos; pos = pos->next)
-
-#define hlist_for_each_safe(pos, n, head) \
-	for (pos = (head)->first; pos && ({ n = pos->next; 1; }); \
-	     pos = n)
-
-#define hlist_entry_safe(ptr, type, member) \
-	({ typeof(ptr) ____ptr = (ptr); \
-	   ____ptr ? hlist_entry(____ptr, type, member) : NULL; \
-	})
-
-/**
- * hlist_for_each_entry	- iterate over list of given type
- * @pos:the type * to use as a loop cursor.
- * @head:the head for your list.
- * @member:the name of the hlist_node within the struct.
- */
-#define hlist_for_each_entry(pos, head, member)				\
-	for (pos = hlist_entry_safe((head)->first, typeof(*(pos)), member);\
-	     pos;							\
-	     pos = hlist_entry_safe((pos)->member.next, typeof(*(pos)), member))
-
-/**
- * hlist_for_each_entry_continue
- * iterate over a hlist continuing after current point
- * @pos:the type * to use as a loop cursor.
- * @member:the name of the hlist_node within the struct.
- */
-#define hlist_for_each_entry_continue(pos, member)			\
-	for (pos = hlist_entry_safe((pos)->member.next, typeof(*(pos)), member);\
-	     pos;							\
-	     pos = hlist_entry_safe((pos)->member.next, typeof(*(pos)), member))
-
-/**
- * hlist_for_each_entry_from
- * iterate over a hlist continuing from current point
- * @pos:	the type * to use as a loop cursor.
- * @member:	the name of the hlist_node within the struct.
- */
-#define hlist_for_each_entry_from(pos, member)				\
-	for (; pos;							\
-	     pos = hlist_entry_safe((pos)->member.next, typeof(*(pos)), member))
-
-/**
- * hlist_for_each_entry_safe
- * iterate over list of given type safe against removal of list entry
- * @pos:the type * to use as a loop cursor.
- * @n:another &struct hlist_node to use as temporary storage
- * @head:the head for your list.
- * @member:the name of the hlist_node within the struct.
- */
-#define hlist_for_each_entry_safe(pos, n, head, member)			\
-	for (pos = hlist_entry_safe((head)->first, typeof(*pos), member);\
-		pos && ({ n = pos->member.next; 1; });			\
-		pos = hlist_entry_safe(n, typeof(*pos), member))
-
-static inline u32 __hash_32(u32 val)
-{
-	return val * GOLDEN_RATIO_32;
-}
-
-static inline u32 hash_32(u32 val, unsigned int bits)
-{
-	/* High bits are more random, so use them. */
-	return __hash_32(val) >> (32 - bits);
-}
-
-static inline u32 hash_64(u64 val, unsigned int bits)
-{
-#if BITS_PER_LONG == 64
-	/* 64x64-bit multiply is efficient on all 64-bit processors */
-	return val * GOLDEN_RATIO_64 >> (64 - bits);
-#else
-	/* Hash 64 bits using only 32x32-bit multiply. */
-	return hash_32((u32)val ^ __hash_32(val >> 32), bits);
-#endif
-}
-
-#define DEFINE_HASHTABLE(name, bits)					\
-	struct hlist_head name[1 << (bits)] =				\
-			{ [0 ... ((1 << (bits)) - 1)] = HLIST_HEAD_INIT }
-
-#define DECLARE_HASHTABLE(name, bits)					\
-	struct hlist_head name[1 << (bits)]
-
-#define HASH_SIZE(name) (ARRAY_SIZE(name))
-#define HASH_BITS(name) ilog2(HASH_SIZE(name))
-
-/* Use hash_32 when possible to allow for fast 32bit hashing in 64bit kernels*/
-#define hash_min(val, bits)						\
-	(sizeof(val) <= 4 ? hash_32(val, bits) : hash_long(val, bits))
-
-static inline void __hash_init(struct hlist_head *ht, unsigned int sz)
-{
-	unsigned int i;
-
-	for (i = 0; i < sz; i++)
-		INIT_HLIST_HEAD(&ht[i]);
-}
-
-/**
- * hash_init - initialize a hash table
- * @hashtable: hashtable to be initialized
- *
- * Calculates the size of the hashtable from the given parameter, otherwise
- * same as hash_init_size.
- *
- * This has to be a macro since HASH_BITS() will not work on pointers since
- * it calculates the size during preprocessing.
- */
-#define hash_init(hashtable) __hash_init(hashtable, HASH_SIZE(hashtable))
-
-/**
- * hash_add - add an object to a hashtable
- * @hashtable: hashtable to add to
- * @node: the &struct hlist_node of the object to be added
- * @key: the key of the object to be added
- */
-#define hash_add(hashtable, node, key)					\
-	hlist_add_head(node, &hashtable[hash_min(key, HASH_BITS(hashtable))])
-
-/**
- * hash_hashed - check whether an object is in any hashtable
- * @node: the &struct hlist_node of the object to be checked
- */
-static inline bool hash_hashed(struct hlist_node *node)
-{
-	return !hlist_unhashed(node);
-}
-
-static inline bool __hash_empty(struct hlist_head *ht, unsigned int sz)
-{
-	unsigned int i;
-
-	for (i = 0; i < sz; i++)
-		if (!hlist_empty(&ht[i]))
-			return false;
-
-	return true;
-}
-
-/**
- * hash_empty - check whether a hashtable is empty
- * @hashtable: hashtable to check
- *
- * This has to be a macro since HASH_BITS() will not work on pointers since
- * it calculates the size during preprocessing.
- */
-#define hash_empty(hashtable) __hash_empty(hashtable, HASH_SIZE(hashtable))
-
-/**
- * hash_del - remove an object from a hashtable
- * @node: &struct hlist_node of the object to remove
- */
-static inline void hash_del(struct hlist_node *node)
-{
-	hlist_del_init(node);
-}
-
-/**
- * hash_for_each - iterate over a hashtable
- * @name: hashtable to iterate
- * @bkt: integer to use as bucket loop cursor
- * @obj: the type * to use as a loop cursor for each entry
- * @member: the name of the hlist_node within the struct
- */
-#define hash_for_each(name, bkt, obj, member)				\
-	for ((bkt) = 0, obj = NULL; obj == NULL && (bkt) < HASH_SIZE(name);\
-			(bkt)++)\
-		hlist_for_each_entry(obj, &name[bkt], member)
-
-/**
- * hash_for_each_safe - iterate over a hashtable safe against removal of
- * hash entry
- * @name: hashtable to iterate
- * @bkt: integer to use as bucket loop cursor
- * @tmp: a &struct used for temporary storage
- * @obj: the type * to use as a loop cursor for each entry
- * @member: the name of the hlist_node within the struct
- */
-#define hash_for_each_safe(name, bkt, tmp, obj, member)			\
-	for ((bkt) = 0, obj = NULL; obj == NULL && (bkt) < HASH_SIZE(name);\
-			(bkt)++)\
-		hlist_for_each_entry_safe(obj, tmp, &name[bkt], member)
-
-/**
- * hash_for_each_possible - iterate over all possible objects hashing to the
- * same bucket
- * @name: hashtable to iterate
- * @obj: the type * to use as a loop cursor for each entry
- * @member: the name of the hlist_node within the struct
- * @key: the key of the objects to iterate over
- */
-#define hash_for_each_possible(name, obj, member, key)			\
-	hlist_for_each_entry(obj, &name[hash_min(key, HASH_BITS(name))], member)
-
-#ifdef __cplusplus
-}
-#endif
-
-#endif
diff --git a/lib/Makefile.am b/lib/Makefile.am
index 4c73012..9991119 100644
--- a/lib/Makefile.am
+++ b/lib/Makefile.am
@@ -12,7 +12,6 @@ noinst_HEADERS = $(top_srcdir)/include/erofs_fs.h \
       $(top_srcdir)/include/erofs/exclude.h \
       $(top_srcdir)/include/erofs/flex-array.h \
       $(top_srcdir)/include/erofs/hashmap.h \
-      $(top_srcdir)/include/erofs/hashtable.h \
       $(top_srcdir)/include/erofs/inode.h \
       $(top_srcdir)/include/erofs/internal.h \
       $(top_srcdir)/include/erofs/io.h \
-- 
2.43.5


