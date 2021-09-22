Return-Path: <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>
X-Original-To: lists+linux-erofs@lfdr.de
Delivered-To: lists+linux-erofs@lfdr.de
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2404:9400:2:0:216:3eff:fee1:b9f1])
	by mail.lfdr.de (Postfix) with ESMTPS id 4778F415042
	for <lists+linux-erofs@lfdr.de>; Wed, 22 Sep 2021 20:56:56 +0200 (CEST)
Received: from boromir.ozlabs.org (localhost [IPv6:::1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4HF6wQ0WFTz2yKK
	for <lists+linux-erofs@lfdr.de>; Thu, 23 Sep 2021 04:56:54 +1000 (AEST)
X-Original-To: linux-erofs@lists.ozlabs.org
Delivered-To: linux-erofs@lists.ozlabs.org
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized)
 smtp.mailfrom=linux.alibaba.com (client-ip=115.124.30.130;
 helo=out30-130.freemail.mail.aliyun.com;
 envelope-from=hsiangkao@linux.alibaba.com; receiver=<UNKNOWN>)
Received: from out30-130.freemail.mail.aliyun.com
 (out30-130.freemail.mail.aliyun.com [115.124.30.130])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 4HF6wB6cjtz2yKK
 for <linux-erofs@lists.ozlabs.org>; Thu, 23 Sep 2021 04:56:42 +1000 (AEST)
X-Alimail-AntiSpam: AC=PASS; BC=-1|-1; BR=01201311R541e4; CH=green; DM=||false|;
 DS=||; FP=0|-1|-1|-1|0|-1|-1|-1; HT=e01e04423; MF=hsiangkao@linux.alibaba.com;
 NM=1; PH=DS; RN=5; SR=0; TI=SMTPD_---0UpFo0Io_1632336968; 
Received: from
 e18g09479.et15sqa.tbsite.net(mailfrom:hsiangkao@linux.alibaba.com
 fp:SMTPD_---0UpFo0Io_1632336968) by smtp.aliyun-inc.com(127.0.0.1);
 Thu, 23 Sep 2021 02:56:26 +0800
From: Gao Xiang <hsiangkao@linux.alibaba.com>
To: linux-erofs@lists.ozlabs.org
Subject: [PATCH v3 2/5] erofs-utils: introduce hashmap from git source
Date: Thu, 23 Sep 2021 02:56:04 +0800
Message-Id: <20210922185607.49909-3-hsiangkao@linux.alibaba.com>
X-Mailer: git-send-email 2.24.4
In-Reply-To: <20210922185607.49909-1-hsiangkao@linux.alibaba.com>
References: <20210922185607.49909-1-hsiangkao@linux.alibaba.com>
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
Cc: Gao Xiang <hsiangkao@linux.alibaba.com>,
 Liu Jiang <gerry@linux.alibaba.com>, Liu Bo <bo.liu@linux.alibaba.com>,
 Peng Tao <tao.peng@linux.alibaba.com>
Errors-To: linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org
Sender: "Linux-erofs"
 <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>

Copied from git source (it's already workable).

Signed-off-by: Gao Xiang <hsiangkao@linux.alibaba.com>
---
 include/erofs/flex-array.h | 147 +++++++++++++++++++
 include/erofs/hashmap.h    | 103 ++++++++++++++
 lib/Makefile.am            |   3 +-
 lib/hashmap.c              | 284 +++++++++++++++++++++++++++++++++++++
 4 files changed, 536 insertions(+), 1 deletion(-)
 create mode 100644 include/erofs/flex-array.h
 create mode 100644 include/erofs/hashmap.h
 create mode 100644 lib/hashmap.c

diff --git a/include/erofs/flex-array.h b/include/erofs/flex-array.h
new file mode 100644
index 000000000000..59168d05ee5a
--- /dev/null
+++ b/include/erofs/flex-array.h
@@ -0,0 +1,147 @@
+/* SPDX-License-Identifier: GPL-2.0 */
+#ifndef __EROFS_FLEX_ARRAY_H
+#define __EROFS_FLEX_ARRAY_H
+
+#include <stdio.h>
+#include <stdlib.h>
+#include <limits.h>
+#include <stdint.h>
+
+#include "defs.h"
+#include "print.h"
+
+/*
+ * flex-array.h
+ *
+ * Some notes to make sense of the code.
+ *
+ * Flex-arrays:
+ *   - Flex-arrays became standard in C99 and are defined by "array[]" (at the
+ *     end of a struct)
+ *   - Pre-C99 flex-arrays can be accomplished by "array[1]"
+ *   - There is a GNU extension where they are defined using "array[0]"
+ *     Allegedly there is/was a bug in gcc whereby foo[1] generated incorrect
+ *     code, so it's safest to use [0] (https://lkml.org/lkml/2015/2/18/407).
+ *
+ * For C89 and C90, __STDC__ is 1
+ * For later standards, __STDC_VERSION__ is defined according to the standard.
+ * For example: 199901L or 201112L
+ *
+ * Whilst we're on the subject, in version 5 of gcc, the default std was
+ * changed from gnu89 to gnu11. In jgmenu, CFLAGS therefore contains -std=gnu89
+ * You can check your default gcc std by doing:
+ * gcc -dM -E - </dev/null | grep '__STDC_VERSION__\|__STDC__'
+ *
+ * The code below is copied from git's git-compat-util.h in support of
+ * hashmap.c
+ */
+
+#ifndef FLEX_ARRAY
+#if defined(__STDC_VERSION__) && (__STDC_VERSION__ >= 199901L) && \
+	(!defined(__SUNPRO_C) || (__SUNPRO_C > 0x580))
+# define FLEX_ARRAY /* empty */
+#elif defined(__GNUC__)
+# if (__GNUC__ >= 3)
+#  define FLEX_ARRAY /* empty */
+# else
+#  define FLEX_ARRAY 0 /* older GNU extension */
+# endif
+#endif
+
+/* Otherwise, default to safer but a bit wasteful traditional style */
+#ifndef FLEX_ARRAY
+# define FLEX_ARRAY 1
+#endif
+#endif
+
+#define bitsizeof(x) (CHAR_BIT * sizeof(x))
+
+#define maximum_signed_value_of_type(a) \
+	(INTMAX_MAX >> (bitsizeof(intmax_t) - bitsizeof(a)))
+
+#define maximum_unsigned_value_of_type(a) \
+	(UINTMAX_MAX >> (bitsizeof(uintmax_t) - bitsizeof(a)))
+
+/*
+ * Signed integer overflow is undefined in C, so here's a helper macro
+ * to detect if the sum of two integers will overflow.
+ * Requires: a >= 0, typeof(a) equals typeof(b)
+ */
+#define signed_add_overflows(a, b) \
+	((b) > maximum_signed_value_of_type(a) - (a))
+
+#define unsigned_add_overflows(a, b) \
+	((b) > maximum_unsigned_value_of_type(a) - (a))
+
+static inline size_t st_add(size_t a, size_t b)
+{
+	if (unsigned_add_overflows(a, b)) {
+		erofs_err("size_t overflow: %llu + %llu", a | 0ULL, b | 0ULL);
+		BUG_ON(1);
+		return -1;
+	}
+	return a + b;
+}
+
+#define st_add3(a, b, c) st_add(st_add((a), (b)), (c))
+#define st_add4(a, b, c, d) st_add(st_add3((a), (b), (c)), (d))
+
+/*
+ * These functions help you allocate structs with flex arrays, and copy
+ * the data directly into the array. For example, if you had:
+ *
+ *   struct foo {
+ *     int bar;
+ *     char name[FLEX_ARRAY];
+ *   };
+ *
+ * you can do:
+ *
+ *   struct foo *f;
+ *   FLEX_ALLOC_MEM(f, name, src, len);
+ *
+ * to allocate a "foo" with the contents of "src" in the "name" field.
+ * The resulting struct is automatically zero'd, and the flex-array field
+ * is NUL-terminated (whether the incoming src buffer was or not).
+ *
+ * The FLEXPTR_* variants operate on structs that don't use flex-arrays,
+ * but do want to store a pointer to some extra data in the same allocated
+ * block. For example, if you have:
+ *
+ *   struct foo {
+ *     char *name;
+ *     int bar;
+ *   };
+ *
+ * you can do:
+ *
+ *   struct foo *f;
+ *   FLEXPTR_ALLOC_STR(f, name, src);
+ *
+ * and "name" will point to a block of memory after the struct, which will be
+ * freed along with the struct (but the pointer can be repointed anywhere).
+ *
+ * The *_STR variants accept a string parameter rather than a ptr/len
+ * combination.
+ *
+ * Note that these macros will evaluate the first parameter multiple
+ * times, and it must be assignable as an lvalue.
+ */
+#define FLEX_ALLOC_MEM(x, flexname, buf, len) do { \
+	size_t flex_array_len_ = (len); \
+	(x) = calloc(1, st_add3(sizeof(*(x)), flex_array_len_, 1)); \
+	BUG_ON(!(x)); \
+	memcpy((void *)(x)->flexname, (buf), flex_array_len_); \
+} while (0)
+#define FLEXPTR_ALLOC_MEM(x, ptrname, buf, len) do { \
+	size_t flex_array_len_ = (len); \
+	(x) = xcalloc(1, st_add3(sizeof(*(x)), flex_array_len_, 1)); \
+	memcpy((x) + 1, (buf), flex_array_len_); \
+	(x)->ptrname = (void *)((x) + 1); \
+} while (0)
+#define FLEX_ALLOC_STR(x, flexname, str) \
+	FLEX_ALLOC_MEM((x), flexname, (str), strlen(str))
+#define FLEXPTR_ALLOC_STR(x, ptrname, str) \
+	FLEXPTR_ALLOC_MEM((x), ptrname, (str), strlen(str))
+
+#endif
diff --git a/include/erofs/hashmap.h b/include/erofs/hashmap.h
new file mode 100644
index 000000000000..024a14e497d4
--- /dev/null
+++ b/include/erofs/hashmap.h
@@ -0,0 +1,103 @@
+/* SPDX-License-Identifier: GPL-2.0 */
+#ifndef __EROFS_HASHMAP_H
+#define __EROFS_HASHMAP_H
+
+/* Copied from https://github.com/git/git.git */
+#include <stdio.h>
+#include <stdlib.h>
+#include <string.h>
+
+#include "flex-array.h"
+
+/*
+ * Generic implementation of hash-based key-value mappings.
+ * See Documentation/technical/api-hashmap.txt.
+ */
+
+/* FNV-1 functions */
+unsigned int strhash(const char *str);
+unsigned int strihash(const char *str);
+unsigned int memhash(const void *buf, size_t len);
+unsigned int memihash(const void *buf, size_t len);
+
+static inline unsigned int sha1hash(const unsigned char *sha1)
+{
+	/*
+	 * Equivalent to 'return *(unsigned int *)sha1;', but safe on
+	 * platforms that don't support unaligned reads.
+	 */
+	unsigned int hash;
+
+	memcpy(&hash, sha1, sizeof(hash));
+	return hash;
+}
+
+/* data structures */
+struct hashmap_entry {
+	struct hashmap_entry *next;
+	unsigned int hash;
+};
+
+typedef int (*hashmap_cmp_fn)(const void *entry, const void *entry_or_key,
+		const void *keydata);
+
+struct hashmap {
+	struct hashmap_entry **table;
+	hashmap_cmp_fn cmpfn;
+	unsigned int size, tablesize, grow_at, shrink_at;
+};
+
+struct hashmap_iter {
+	struct hashmap *map;
+	struct hashmap_entry *next;
+	unsigned int tablepos;
+};
+
+/* hashmap functions */
+void hashmap_init(struct hashmap *map, hashmap_cmp_fn equals_function,
+		  size_t initial_size);
+void hashmap_free(struct hashmap *map, int free_entries);
+
+/* hashmap_entry functions */
+static inline void hashmap_entry_init(void *entry, unsigned int hash)
+{
+	struct hashmap_entry *e = entry;
+
+	e->hash = hash;
+	e->next = NULL;
+}
+
+void *hashmap_get(const struct hashmap *map, const void *key, const void *keydata);
+void *hashmap_get_next(const struct hashmap *map, const void *entry);
+void hashmap_add(struct hashmap *map, void *entry);
+void *hashmap_put(struct hashmap *map, void *entry);
+void *hashmap_remove(struct hashmap *map, const void *key, const void *keydata);
+
+static inline void *hashmap_get_from_hash(const struct hashmap *map,
+					  unsigned int hash,
+					  const void *keydata)
+{
+	struct hashmap_entry key;
+
+	hashmap_entry_init(&key, hash);
+	return hashmap_get(map, &key, keydata);
+}
+
+/* hashmap_iter functions */
+void hashmap_iter_init(struct hashmap *map, struct hashmap_iter *iter);
+void *hashmap_iter_next(struct hashmap_iter *iter);
+static inline void *hashmap_iter_first(struct hashmap *map,
+				       struct hashmap_iter *iter)
+{
+	hashmap_iter_init(map, iter);
+	return hashmap_iter_next(iter);
+}
+
+/* string interning */
+const void *memintern(const void *data, size_t len);
+static inline const char *strintern(const char *string)
+{
+	return memintern(string, strlen(string));
+}
+
+#endif
diff --git a/lib/Makefile.am b/lib/Makefile.am
index 5a33e297c194..7d00bf5fafdc 100644
--- a/lib/Makefile.am
+++ b/lib/Makefile.am
@@ -21,7 +21,8 @@ noinst_HEADERS = $(top_srcdir)/include/erofs_fs.h \
 
 noinst_HEADERS += compressor.h
 liberofs_la_SOURCES = config.c io.c cache.c super.c inode.c xattr.c exclude.c \
-		      namei.c data.c compress.c compressor.c zmap.c decompress.c compress_hints.c
+		      namei.c data.c compress.c compressor.c zmap.c decompress.c \
+		      compress_hints.c hashmap.c
 liberofs_la_CFLAGS = -Wall -Werror -I$(top_srcdir)/include
 if ENABLE_LZ4
 liberofs_la_CFLAGS += ${LZ4_CFLAGS}
diff --git a/lib/hashmap.c b/lib/hashmap.c
new file mode 100644
index 000000000000..e11bd8da94c1
--- /dev/null
+++ b/lib/hashmap.c
@@ -0,0 +1,284 @@
+// SPDX-License-Identifier: GPL-2.0
+/*
+ * Copied from https://github.com/git/git.git
+ * Generic implementation of hash-based key value mappings.
+ */
+#include "erofs/hashmap.h"
+
+#define FNV32_BASE ((unsigned int)0x811c9dc5)
+#define FNV32_PRIME ((unsigned int)0x01000193)
+
+unsigned int strhash(const char *str)
+{
+	unsigned int c, hash = FNV32_BASE;
+
+	while ((c = (unsigned char)*str++))
+		hash = (hash * FNV32_PRIME) ^ c;
+	return hash;
+}
+
+unsigned int strihash(const char *str)
+{
+	unsigned int c, hash = FNV32_BASE;
+
+	while ((c = (unsigned char)*str++)) {
+		if (c >= 'a' && c <= 'z')
+			c -= 'a' - 'A';
+		hash = (hash * FNV32_PRIME) ^ c;
+	}
+	return hash;
+}
+
+unsigned int memhash(const void *buf, size_t len)
+{
+	unsigned int hash = FNV32_BASE;
+	unsigned char *ucbuf = (unsigned char *)buf;
+
+	while (len--) {
+		unsigned int c = *ucbuf++;
+
+		hash = (hash * FNV32_PRIME) ^ c;
+	}
+	return hash;
+}
+
+unsigned int memihash(const void *buf, size_t len)
+{
+	unsigned int hash = FNV32_BASE;
+	unsigned char *ucbuf = (unsigned char *)buf;
+
+	while (len--) {
+		unsigned int c = *ucbuf++;
+
+		if (c >= 'a' && c <= 'z')
+			c -= 'a' - 'A';
+		hash = (hash * FNV32_PRIME) ^ c;
+	}
+	return hash;
+}
+
+#define HASHMAP_INITIAL_SIZE 64
+/* grow / shrink by 2^2 */
+#define HASHMAP_RESIZE_BITS 2
+/* load factor in percent */
+#define HASHMAP_LOAD_FACTOR 80
+
+static void alloc_table(struct hashmap *map, unsigned int size)
+{
+	map->tablesize = size;
+	map->table = calloc(size, sizeof(struct hashmap_entry *));
+	BUG_ON(!map->table);
+
+	/* calculate resize thresholds for new size */
+	map->grow_at = (unsigned int)((uint64_t)size * HASHMAP_LOAD_FACTOR / 100);
+	if (size <= HASHMAP_INITIAL_SIZE)
+		map->shrink_at = 0;
+	else
+		/*
+		 * The shrink-threshold must be slightly smaller than
+		 * (grow-threshold / resize-factor) to prevent erratic resizing,
+		 * thus we divide by (resize-factor + 1).
+		 */
+		map->shrink_at = map->grow_at / ((1 << HASHMAP_RESIZE_BITS) + 1);
+}
+
+static inline int entry_equals(const struct hashmap *map,
+			       const struct hashmap_entry *e1,
+			       const struct hashmap_entry *e2,
+			       const void *keydata)
+{
+	return (e1 == e2) || (e1->hash == e2->hash && !map->cmpfn(e1, e2, keydata));
+}
+
+static inline unsigned int bucket(const struct hashmap *map,
+				  const struct hashmap_entry *key)
+{
+	return key->hash & (map->tablesize - 1);
+}
+
+static void rehash(struct hashmap *map, unsigned int newsize)
+{
+	unsigned int i, oldsize = map->tablesize;
+	struct hashmap_entry **oldtable = map->table;
+
+	alloc_table(map, newsize);
+	for (i = 0; i < oldsize; i++) {
+		struct hashmap_entry *e = oldtable[i];
+
+		while (e) {
+			struct hashmap_entry *next = e->next;
+			unsigned int b = bucket(map, e);
+
+			e->next = map->table[b];
+			map->table[b] = e;
+			e = next;
+		}
+	}
+	free(oldtable);
+}
+
+static inline struct hashmap_entry **find_entry_ptr(const struct hashmap *map,
+						    const struct hashmap_entry *key,
+						    const void *keydata)
+{
+	struct hashmap_entry **e = &map->table[bucket(map, key)];
+
+	while (*e && !entry_equals(map, *e, key, keydata))
+		e = &(*e)->next;
+	return e;
+}
+
+static int always_equal(const void *unused1, const void *unused2, const void *unused3)
+{
+	return 0;
+}
+
+void hashmap_init(struct hashmap *map, hashmap_cmp_fn equals_function,
+		  size_t initial_size)
+{
+	unsigned int size = HASHMAP_INITIAL_SIZE;
+
+	map->size = 0;
+	map->cmpfn = equals_function ? equals_function : always_equal;
+
+	/* calculate initial table size and allocate the table */
+	initial_size = (unsigned int)((uint64_t)initial_size * 100
+			/ HASHMAP_LOAD_FACTOR);
+	while (initial_size > size)
+		size <<= HASHMAP_RESIZE_BITS;
+	alloc_table(map, size);
+}
+
+void hashmap_free(struct hashmap *map, int free_entries)
+{
+	if (!map || !map->table)
+		return;
+	if (free_entries) {
+		struct hashmap_iter iter;
+		struct hashmap_entry *e;
+
+		hashmap_iter_init(map, &iter);
+		while ((e = hashmap_iter_next(&iter)))
+			free(e);
+	}
+	free(map->table);
+	memset(map, 0, sizeof(*map));
+}
+
+void *hashmap_get(const struct hashmap *map, const void *key, const void *keydata)
+{
+	return *find_entry_ptr(map, key, keydata);
+}
+
+void *hashmap_get_next(const struct hashmap *map, const void *entry)
+{
+	struct hashmap_entry *e = ((struct hashmap_entry *)entry)->next;
+
+	for (; e; e = e->next)
+		if (entry_equals(map, entry, e, NULL))
+			return e;
+	return NULL;
+}
+
+void hashmap_add(struct hashmap *map, void *entry)
+{
+	unsigned int b = bucket(map, entry);
+
+	/* add entry */
+	((struct hashmap_entry *)entry)->next = map->table[b];
+	map->table[b] = entry;
+
+	/* fix size and rehash if appropriate */
+	map->size++;
+	if (map->size > map->grow_at)
+		rehash(map, map->tablesize << HASHMAP_RESIZE_BITS);
+}
+
+void *hashmap_remove(struct hashmap *map, const void *key, const void *keydata)
+{
+	struct hashmap_entry *old;
+	struct hashmap_entry **e = find_entry_ptr(map, key, keydata);
+
+	if (!*e)
+		return NULL;
+
+	/* remove existing entry */
+	old = *e;
+	*e = old->next;
+	old->next = NULL;
+
+	/* fix size and rehash if appropriate */
+	map->size--;
+	if (map->size < map->shrink_at)
+		rehash(map, map->tablesize >> HASHMAP_RESIZE_BITS);
+	return old;
+}
+
+void *hashmap_put(struct hashmap *map, void *entry)
+{
+	struct hashmap_entry *old = hashmap_remove(map, entry, NULL);
+
+	hashmap_add(map, entry);
+	return old;
+}
+
+void hashmap_iter_init(struct hashmap *map, struct hashmap_iter *iter)
+{
+	iter->map = map;
+	iter->tablepos = 0;
+	iter->next = NULL;
+}
+
+void *hashmap_iter_next(struct hashmap_iter *iter)
+{
+	struct hashmap_entry *current = iter->next;
+
+	for (;;) {
+		if (current) {
+			iter->next = current->next;
+			return current;
+		}
+
+		if (iter->tablepos >= iter->map->tablesize)
+			return NULL;
+
+		current = iter->map->table[iter->tablepos++];
+	}
+}
+
+struct pool_entry {
+	struct hashmap_entry ent;
+	size_t len;
+	unsigned char data[FLEX_ARRAY];
+};
+
+static int pool_entry_cmp(const struct pool_entry *e1,
+			  const struct pool_entry *e2,
+			  const unsigned char *keydata)
+{
+	return e1->data != keydata &&
+	       (e1->len != e2->len || memcmp(e1->data, keydata, e1->len));
+}
+
+const void *memintern(const void *data, size_t len)
+{
+	static struct hashmap map;
+	struct pool_entry key, *e;
+
+	/* initialize string pool hashmap */
+	if (!map.tablesize)
+		hashmap_init(&map, (hashmap_cmp_fn)pool_entry_cmp, 0);
+
+	/* lookup interned string in pool */
+	hashmap_entry_init(&key, memhash(data, len));
+	key.len = len;
+	e = hashmap_get(&map, &key, data);
+	if (!e) {
+		/* not found: create it */
+		FLEX_ALLOC_MEM(e, data, data, len);
+		hashmap_entry_init(e, key.ent.hash);
+		e->len = len;
+		hashmap_add(&map, e);
+	}
+	return e->data;
+}
-- 
2.24.4

