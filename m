Return-Path: <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>
X-Original-To: lists+linux-erofs@lfdr.de
Delivered-To: lists+linux-erofs@lfdr.de
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	by mail.lfdr.de (Postfix) with ESMTPS id A2BCE464F2E
	for <lists+linux-erofs@lfdr.de>; Wed,  1 Dec 2021 14:53:52 +0100 (CET)
Received: from boromir.ozlabs.org (localhost [IPv6:::1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4J40tQ3pmNz30GN
	for <lists+linux-erofs@lfdr.de>; Thu,  2 Dec 2021 00:53:50 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org;
	dkim=fail reason="signature verification failed" (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20201202 header.b=jRUt+aAT;
	dkim-atps=neutral
X-Original-To: linux-erofs@lists.ozlabs.org
Delivered-To: linux-erofs@lists.ozlabs.org
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized)
 smtp.mailfrom=kernel.org (client-ip=2604:1380:40e1:4800::1;
 helo=sin.source.kernel.org; envelope-from=xiang@kernel.org;
 receiver=<UNKNOWN>)
Authentication-Results: lists.ozlabs.org; dkim=pass (2048-bit key;
 unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256
 header.s=k20201202 header.b=jRUt+aAT; 
 dkim-atps=neutral
Received: from sin.source.kernel.org (sin.source.kernel.org
 [IPv6:2604:1380:40e1:4800::1])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 4J40tL56r2z2ypn
 for <linux-erofs@lists.ozlabs.org>; Thu,  2 Dec 2021 00:53:46 +1100 (AEDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by sin.source.kernel.org (Postfix) with ESMTPS id 94EE7CE1ECE;
 Wed,  1 Dec 2021 13:53:39 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 348F4C53FCC;
 Wed,  1 Dec 2021 13:53:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=k20201202; t=1638366817;
 bh=DUCxrN5nPfnRTzq5itpIwUzOApdUP7SWACrUgY2f8Gc=;
 h=From:To:Cc:Subject:Date:From;
 b=jRUt+aATnC6QDQ9WAc6FS+UA7M7/jxvhfZnUc/E3RLeb8sRrzN5PiS3kksfwFIKjz
 VJKkBgQfOlbogfT/hOsJipKALso1VeofNHpDwtxMSxh+HQUzmjC8EdcBSLre81DWm6
 wUzPnlsYcIAOUkq5MknSSm026Lx+z4Z901jOgaw1igZnkG5sau1fF+JyuUbRAYuP4p
 X4am5RzHIa4zRfFCzoDcv1rPpCV92EFOWvhd5Fzia6CIxszh75KQaU5fromDTfJAy/
 FFModqlrpXNa7WRJVM/IL98YvQ52DxaNurWhPRVdn//mxH/xYq8IlyMITE/yOkUNSD
 rpUCBCQ2WusQA==
From: Gao Xiang <xiang@kernel.org>
To: linux-erofs@lists.ozlabs.org
Subject: [PATCH] erofs-utils: make liberofs more C++ friendly
Date: Wed,  1 Dec 2021 21:53:15 +0800
Message-Id: <20211201135315.3732-1-xiang@kernel.org>
X-Mailer: git-send-email 2.20.1
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
Cc: Kelvin Zhang <zhangkelvin@google.com>
Errors-To: linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org
Sender: "Linux-erofs"
 <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>

From: Kelvin Zhang <zhangkelvin@google.com>

1. Add extern "C" wrappers to headers, so that they can be included
   from C++
2. Add const keywords to certain pointer type params

Signed-off-by: Kelvin Zhang <zhangkelvin@google.com>
Signed-off-by: Gao Xiang <xiang@kernel.org>
---
v3: https://lore.kernel.org/r/20211130055604.2876828-2-zhangkelvin@google.com/
Hi Kelvin,

Please help check if this patch meets your requirement.
And I've applied to experimental branch.

Thanks,
Gao Xiang

 include/erofs/blobchunk.h      |  9 +++++++++
 include/erofs/block_list.h     | 10 ++++++++++
 include/erofs/cache.h          |  9 +++++++++
 include/erofs/compress.h       |  9 +++++++++
 include/erofs/compress_hints.h | 10 ++++++++++
 include/erofs/config.h         | 20 +++++++++-----------
 include/erofs/decompress.h     |  9 +++++++++
 include/erofs/defs.h           | 17 ++++++++++++++++-
 include/erofs/err.h            |  9 +++++++++
 include/erofs/exclude.h        | 10 ++++++++++
 include/erofs/flex-array.h     |  9 +++++++++
 include/erofs/hashmap.h        |  9 +++++++++
 include/erofs/hashtable.h      |  9 +++++++++
 include/erofs/inode.h          |  9 +++++++++
 include/erofs/internal.h       |  9 +++++++++
 include/erofs/io.h             | 11 +++++++++++
 include/erofs/list.h           | 10 ++++++++++
 include/erofs/print.h          |  9 +++++++++
 include/erofs/trace.h          |  9 +++++++++
 include/erofs/xattr.h          |  9 +++++++++
 lib/Makefile.am                |  3 ++-
 lib/config.c                   |  1 +
 lib/inode.c                    |  1 +
 lib/liberofs_private.h         | 13 +++++++++++++
 lib/xattr.c                    |  1 +
 25 files changed, 211 insertions(+), 13 deletions(-)
 create mode 100644 lib/liberofs_private.h

diff --git a/include/erofs/blobchunk.h b/include/erofs/blobchunk.h
index 59a47013017f..4e1ae79938d6 100644
--- a/include/erofs/blobchunk.h
+++ b/include/erofs/blobchunk.h
@@ -7,6 +7,11 @@
 #ifndef __EROFS_BLOBCHUNK_H
 #define __EROFS_BLOBCHUNK_H
 
+#ifdef __cplusplus
+extern "C"
+{
+#endif
+
 #include "erofs/internal.h"
 
 int erofs_blob_write_chunk_indexes(struct erofs_inode *inode, erofs_off_t off);
@@ -16,4 +21,8 @@ void erofs_blob_exit(void);
 int erofs_blob_init(const char *blobfile_path);
 int erofs_generate_devtable(void);
 
+#ifdef __cplusplus
+}
+#endif
+
 #endif
diff --git a/include/erofs/block_list.h b/include/erofs/block_list.h
index 40df2282bf0c..ca8053ed28b7 100644
--- a/include/erofs/block_list.h
+++ b/include/erofs/block_list.h
@@ -6,6 +6,11 @@
 #ifndef __EROFS_BLOCK_LIST_H
 #define __EROFS_BLOCK_LIST_H
 
+#ifdef __cplusplus
+extern "C"
+{
+#endif
+
 #include "internal.h"
 
 #ifdef WITH_ANDROID
@@ -29,4 +34,9 @@ erofs_droid_blocklist_write_extent(struct erofs_inode *inode,
 				   erofs_blk_t blk_start, erofs_blk_t nblocks,
 				   bool first_extent, bool last_extent) {}
 #endif
+
+#ifdef __cplusplus
+}
+#endif
+
 #endif
diff --git a/include/erofs/cache.h b/include/erofs/cache.h
index 87cd51d9473b..7957ee5d0b73 100644
--- a/include/erofs/cache.h
+++ b/include/erofs/cache.h
@@ -8,6 +8,11 @@
 #ifndef __EROFS_CACHE_H
 #define __EROFS_CACHE_H
 
+#ifdef __cplusplus
+extern "C"
+{
+#endif
+
 #include "internal.h"
 
 struct erofs_buffer_head;
@@ -104,4 +109,8 @@ bool erofs_bflush(struct erofs_buffer_block *bb);
 
 void erofs_bdrop(struct erofs_buffer_head *bh, bool tryrevoke);
 
+#ifdef __cplusplus
+}
+#endif
+
 #endif
diff --git a/include/erofs/compress.h b/include/erofs/compress.h
index 4434aaa75b54..fdbf5ff66558 100644
--- a/include/erofs/compress.h
+++ b/include/erofs/compress.h
@@ -7,6 +7,11 @@
 #ifndef __EROFS_COMPRESS_H
 #define __EROFS_COMPRESS_H
 
+#ifdef __cplusplus
+extern "C"
+{
+#endif
+
 #include "internal.h"
 
 /* workaround for an upstream lz4 compression issue, which can crash us */
@@ -21,4 +26,8 @@ int z_erofs_compress_exit(void);
 
 const char *z_erofs_list_available_compressors(unsigned int i);
 
+#ifdef __cplusplus
+}
+#endif
+
 #endif
diff --git a/include/erofs/compress_hints.h b/include/erofs/compress_hints.h
index a5772c72b1c4..43f80e117816 100644
--- a/include/erofs/compress_hints.h
+++ b/include/erofs/compress_hints.h
@@ -6,6 +6,11 @@
 #ifndef __EROFS_COMPRESS_HINTS_H
 #define __EROFS_COMPRESS_HINTS_H
 
+#ifdef __cplusplus
+extern "C"
+{
+#endif
+
 #include "erofs/internal.h"
 #include <sys/types.h>
 #include <regex.h>
@@ -20,4 +25,9 @@ struct erofs_compress_hints {
 bool z_erofs_apply_compress_hints(struct erofs_inode *inode);
 void erofs_cleanup_compress_hints(void);
 int erofs_load_compress_hints(void);
+
+#ifdef __cplusplus
+}
+#endif
+
 #endif
diff --git a/include/erofs/config.h b/include/erofs/config.h
index 2040dc6ff154..cb064b651835 100644
--- a/include/erofs/config.h
+++ b/include/erofs/config.h
@@ -7,20 +7,14 @@
 #ifndef __EROFS_CONFIG_H
 #define __EROFS_CONFIG_H
 
+#ifdef __cplusplus
+extern "C"
+{
+#endif
+
 #include "defs.h"
 #include "err.h"
 
-#ifdef HAVE_LIBSELINUX
-#include <selinux/selinux.h>
-#include <selinux/label.h>
-#endif
-
-#ifdef WITH_ANDROID
-#include <selinux/android.h>
-#include <private/android_filesystem_config.h>
-#include <private/canned_fs_config.h>
-#include <private/fs_config.h>
-#endif
 
 enum {
 	FORCE_INODE_COMPACT = 1,
@@ -96,4 +90,8 @@ static inline int erofs_selabel_open(const char *file_contexts)
 }
 #endif
 
+#ifdef __cplusplus
+}
+#endif
+
 #endif
diff --git a/include/erofs/decompress.h b/include/erofs/decompress.h
index 3d0d9633865d..e649c80cf3a7 100644
--- a/include/erofs/decompress.h
+++ b/include/erofs/decompress.h
@@ -6,6 +6,11 @@
 #ifndef __EROFS_DECOMPRESS_H
 #define __EROFS_DECOMPRESS_H
 
+#ifdef __cplusplus
+extern "C"
+{
+#endif
+
 #include "internal.h"
 
 struct z_erofs_decompress_req {
@@ -25,4 +30,8 @@ struct z_erofs_decompress_req {
 
 int z_erofs_decompress(struct z_erofs_decompress_req *rq);
 
+#ifdef __cplusplus
+}
+#endif
+
 #endif
diff --git a/include/erofs/defs.h b/include/erofs/defs.h
index 6398cbb2aa4d..4db237f4dfb0 100644
--- a/include/erofs/defs.h
+++ b/include/erofs/defs.h
@@ -8,6 +8,11 @@
 #ifndef __EROFS_DEFS_H
 #define __EROFS_DEFS_H
 
+#ifdef __cplusplus
+extern "C"
+{
+#endif
+
 #include <stddef.h>
 #include <stdint.h>
 #include <assert.h>
@@ -82,7 +87,9 @@ typedef int64_t         s64;
 #endif
 #endif
 
-#ifndef __OPTIMIZE__
+#ifdef __cplusplus
+#define BUILD_BUG_ON(condition) static_assert(!(condition))
+#elif !defined(__OPTIMIZE__)
 #define BUILD_BUG_ON(condition) ((void)sizeof(char[1 - 2 * !!(condition)]))
 #else
 #define BUILD_BUG_ON(condition) assert(!(condition))
@@ -110,6 +117,8 @@ typedef int64_t         s64;
 }							\
 )
 
+/* Can easily conflict with C++'s std::min */
+#ifndef __cplusplus
 #define min(x, y) ({				\
 	typeof(x) _min1 = (x);			\
 	typeof(y) _min2 = (y);			\
@@ -121,6 +130,7 @@ typedef int64_t         s64;
 	typeof(y) _max2 = (y);			\
 	(void) (&_max1 == &_max2);		\
 	_max1 > _max2 ? _max1 : _max2; })
+#endif
 
 /*
  * ..and if you can't take the strict types, you can specify one yourself.
@@ -308,4 +318,9 @@ unsigned long __roundup_pow_of_two(unsigned long n)
 #define stat64		stat
 #define lstat64		lstat
 #endif
+
+#ifdef __cplusplus
+}
+#endif
+
 #endif
diff --git a/include/erofs/err.h b/include/erofs/err.h
index a33bdd137879..18f152aa4608 100644
--- a/include/erofs/err.h
+++ b/include/erofs/err.h
@@ -7,6 +7,11 @@
 #ifndef __EROFS_ERR_H
 #define __EROFS_ERR_H
 
+#ifdef __cplusplus
+extern "C"
+{
+#endif
+
 #include <errno.h>
 
 #define MAX_ERRNO (4095)
@@ -28,4 +33,8 @@ static inline long PTR_ERR(const void *ptr)
 	return (long) ptr;
 }
 
+#ifdef __cplusplus
+}
+#endif
+
 #endif
diff --git a/include/erofs/exclude.h b/include/erofs/exclude.h
index 6930f2b43a47..599f01895807 100644
--- a/include/erofs/exclude.h
+++ b/include/erofs/exclude.h
@@ -5,6 +5,11 @@
 #ifndef __EROFS_EXCLUDE_H
 #define __EROFS_EXCLUDE_H
 
+#ifdef __cplusplus
+extern "C"
+{
+#endif
+
 #include <sys/types.h>
 #include <regex.h>
 
@@ -21,4 +26,9 @@ void erofs_cleanup_exclude_rules(void);
 int erofs_parse_exclude_path(const char *args, bool is_regex);
 struct erofs_exclude_rule *erofs_is_exclude_path(const char *dir,
 						 const char *name);
+
+#ifdef __cplusplus
+}
+#endif
+
 #endif
diff --git a/include/erofs/flex-array.h b/include/erofs/flex-array.h
index 59168d05ee5a..9b1642f77740 100644
--- a/include/erofs/flex-array.h
+++ b/include/erofs/flex-array.h
@@ -2,6 +2,11 @@
 #ifndef __EROFS_FLEX_ARRAY_H
 #define __EROFS_FLEX_ARRAY_H
 
+#ifdef __cplusplus
+extern "C"
+{
+#endif
+
 #include <stdio.h>
 #include <stdlib.h>
 #include <limits.h>
@@ -144,4 +149,8 @@ static inline size_t st_add(size_t a, size_t b)
 #define FLEXPTR_ALLOC_STR(x, ptrname, str) \
 	FLEXPTR_ALLOC_MEM((x), ptrname, (str), strlen(str))
 
+#ifdef __cplusplus
+}
+#endif
+
 #endif
diff --git a/include/erofs/hashmap.h b/include/erofs/hashmap.h
index 024a14e497d4..3d3857890077 100644
--- a/include/erofs/hashmap.h
+++ b/include/erofs/hashmap.h
@@ -2,6 +2,11 @@
 #ifndef __EROFS_HASHMAP_H
 #define __EROFS_HASHMAP_H
 
+#ifdef __cplusplus
+extern "C"
+{
+#endif
+
 /* Copied from https://github.com/git/git.git */
 #include <stdio.h>
 #include <stdlib.h>
@@ -100,4 +105,8 @@ static inline const char *strintern(const char *string)
 	return memintern(string, strlen(string));
 }
 
+#ifdef __cplusplus
+}
+#endif
+
 #endif
diff --git a/include/erofs/hashtable.h b/include/erofs/hashtable.h
index 90eb84ee8598..3c4dfc128eaa 100644
--- a/include/erofs/hashtable.h
+++ b/include/erofs/hashtable.h
@@ -5,6 +5,11 @@
 #ifndef __EROFS_HASHTABLE_H
 #define __EROFS_HASHTABLE_H
 
+#ifdef __cplusplus
+extern "C"
+{
+#endif
+
 /*
  * Fast hashing routine for ints,  longs and pointers.
  * (C) 2002 Nadia Yvette Chambers, IBM
@@ -380,4 +385,8 @@ static inline void hash_del(struct hlist_node *node)
 #define hash_for_each_possible(name, obj, member, key)			\
 	hlist_for_each_entry(obj, &name[hash_min(key, HASH_BITS(name))], member)
 
+#ifdef __cplusplus
+}
+#endif
+
 #endif
diff --git a/include/erofs/inode.h b/include/erofs/inode.h
index d5343c242aee..e23d65f42249 100644
--- a/include/erofs/inode.h
+++ b/include/erofs/inode.h
@@ -8,6 +8,11 @@
 #ifndef __EROFS_INODE_H
 #define __EROFS_INODE_H
 
+#ifdef __cplusplus
+extern "C"
+{
+#endif
+
 #include "erofs/internal.h"
 
 unsigned char erofs_mode_to_ftype(umode_t mode);
@@ -17,4 +22,8 @@ erofs_nid_t erofs_lookupnid(struct erofs_inode *inode);
 struct erofs_inode *erofs_mkfs_build_tree_from_path(struct erofs_inode *parent,
 						    const char *path);
 
+#ifdef __cplusplus
+}
+#endif
+
 #endif
diff --git a/include/erofs/internal.h b/include/erofs/internal.h
index 666d1f2df466..a68de325da39 100644
--- a/include/erofs/internal.h
+++ b/include/erofs/internal.h
@@ -7,6 +7,11 @@
 #ifndef __EROFS_INTERNAL_H
 #define __EROFS_INTERNAL_H
 
+#ifdef __cplusplus
+extern "C"
+{
+#endif
+
 #include "list.h"
 #include "err.h"
 
@@ -331,4 +336,8 @@ static inline u32 erofs_crc32c(u32 crc, const u8 *in, size_t len)
 	return crc;
 }
 
+#ifdef __cplusplus
+}
+#endif
+
 #endif
diff --git a/include/erofs/io.h b/include/erofs/io.h
index 10a3681882e1..6f51e06ee7c2 100644
--- a/include/erofs/io.h
+++ b/include/erofs/io.h
@@ -7,7 +7,14 @@
 #ifndef __EROFS_IO_H
 #define __EROFS_IO_H
 
+#ifdef __cplusplus
+extern "C"
+{
+#endif
+
+#ifndef _GNU_SOURCE
 #define _GNU_SOURCE
+#endif
 #include <unistd.h>
 #include "internal.h"
 
@@ -47,4 +54,8 @@ static inline int blk_read(int device_id, void *buf,
 			 blknr_to_addr(nblocks));
 }
 
+#ifdef __cplusplus
+}
 #endif
+
+#endif // EROFS_IO_H_
diff --git a/include/erofs/list.h b/include/erofs/list.h
index d2bc704ae64b..fd5358d6bd19 100644
--- a/include/erofs/list.h
+++ b/include/erofs/list.h
@@ -7,6 +7,11 @@
 #ifndef __EROFS_LIST_HEAD_H
 #define __EROFS_LIST_HEAD_H
 
+#ifdef __cplusplus
+extern "C"
+{
+#endif
+
 #include "defs.h"
 
 struct list_head {
@@ -105,4 +110,9 @@ static inline int list_empty(struct list_head *head)
 	     &pos->member != (head);                                           \
 	     pos = n, n = list_next_entry(n, member))
 
+
+#ifdef __cplusplus
+}
+#endif
+
 #endif
diff --git a/include/erofs/print.h b/include/erofs/print.h
index 91f864bacd55..2213d1d58de5 100644
--- a/include/erofs/print.h
+++ b/include/erofs/print.h
@@ -7,6 +7,11 @@
 #ifndef __EROFS_PRINT_H
 #define __EROFS_PRINT_H
 
+#ifdef __cplusplus
+extern "C"
+{
+#endif
+
 #include "config.h"
 #include <stdio.h>
 
@@ -72,4 +77,8 @@ enum {
 
 #define erofs_dump(fmt, ...) fprintf(stderr, fmt, ##__VA_ARGS__)
 
+#ifdef __cplusplus
+}
+#endif
+
 #endif
diff --git a/include/erofs/trace.h b/include/erofs/trace.h
index d70d23674c1a..893e16c5d6c1 100644
--- a/include/erofs/trace.h
+++ b/include/erofs/trace.h
@@ -5,7 +5,16 @@
 #ifndef __EROFS_TRACE_H
 #define __EROFS_TRACE_H
 
+#ifdef __cplusplus
+extern "C"
+{
+#endif
+
 #define trace_erofs_map_blocks_flatmode_enter(inode, map, flags) ((void)0)
 #define trace_erofs_map_blocks_flatmode_exit(inode, map, flags, ret) ((void)0)
 
+#ifdef __cplusplus
+}
+#endif
+
 #endif
diff --git a/include/erofs/xattr.h b/include/erofs/xattr.h
index f0c4c268fecc..8e6881247f42 100644
--- a/include/erofs/xattr.h
+++ b/include/erofs/xattr.h
@@ -7,6 +7,11 @@
 #ifndef __EROFS_XATTR_H
 #define __EROFS_XATTR_H
 
+#ifdef __cplusplus
+extern "C"
+{
+#endif
+
 #include "internal.h"
 
 #define EROFS_INODE_XATTR_ICOUNT(_size)	({\
@@ -44,4 +49,8 @@ int erofs_prepare_xattr_ibody(struct erofs_inode *inode);
 char *erofs_export_xattr_ibody(struct list_head *ixattrs, unsigned int size);
 int erofs_build_shared_xattrs_from_path(const char *path);
 
+#ifdef __cplusplus
+}
+#endif
+
 #endif
diff --git a/lib/Makefile.am b/lib/Makefile.am
index 395c712811b8..67ba798672b9 100644
--- a/lib/Makefile.am
+++ b/lib/Makefile.am
@@ -21,7 +21,8 @@ noinst_HEADERS = $(top_srcdir)/include/erofs_fs.h \
       $(top_srcdir)/include/erofs/print.h \
       $(top_srcdir)/include/erofs/trace.h \
       $(top_srcdir)/include/erofs/xattr.h \
-      $(top_srcdir)/include/erofs/compress_hints.h
+      $(top_srcdir)/include/erofs/compress_hints.h \
+      $(top_srcdir)/lib/liberofs_private.h
 
 noinst_HEADERS += compressor.h
 liberofs_la_SOURCES = config.c io.c cache.c super.c inode.c xattr.c exclude.c \
diff --git a/lib/config.c b/lib/config.c
index 363dcc5a0525..f1c8edfda2dc 100644
--- a/lib/config.c
+++ b/lib/config.c
@@ -8,6 +8,7 @@
 #include <stdlib.h>
 #include "erofs/print.h"
 #include "erofs/internal.h"
+#include "liberofs_private.h"
 
 struct erofs_configure cfg;
 struct erofs_sb_info sbi;
diff --git a/lib/inode.c b/lib/inode.c
index 2fa74e2686c9..461c7978dbdf 100644
--- a/lib/inode.c
+++ b/lib/inode.c
@@ -25,6 +25,7 @@
 #include "erofs/block_list.h"
 #include "erofs/compress_hints.h"
 #include "erofs/blobchunk.h"
+#include "liberofs_private.h"
 
 #define S_SHIFT                 12
 static unsigned char erofs_ftype_by_mode[S_IFMT >> S_SHIFT] = {
diff --git a/lib/liberofs_private.h b/lib/liberofs_private.h
new file mode 100644
index 000000000000..c2312e8e7a31
--- /dev/null
+++ b/lib/liberofs_private.h
@@ -0,0 +1,13 @@
+/* SPDX-License-Identifier: GPL-2.0-only OR Apache-2.0 */
+
+#ifdef HAVE_LIBSELINUX
+#include <selinux/selinux.h>
+#include <selinux/label.h>
+#endif
+
+#ifdef WITH_ANDROID
+#include <selinux/android.h>
+#include <private/android_filesystem_config.h>
+#include <private/canned_fs_config.h>
+#include <private/fs_config.h>
+#endif
diff --git a/lib/xattr.c b/lib/xattr.c
index 196133a1a798..00fb963c68ef 100644
--- a/lib/xattr.c
+++ b/lib/xattr.c
@@ -17,6 +17,7 @@
 #include "erofs/xattr.h"
 #include "erofs/cache.h"
 #include "erofs/io.h"
+#include "liberofs_private.h"
 
 #define EA_HASHTABLE_BITS 16
 
-- 
2.20.1

