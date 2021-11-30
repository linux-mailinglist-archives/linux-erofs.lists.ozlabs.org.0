Return-Path: <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>
X-Original-To: lists+linux-erofs@lfdr.de
Delivered-To: lists+linux-erofs@lfdr.de
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2404:9400:2:0:216:3eff:fee1:b9f1])
	by mail.lfdr.de (Postfix) with ESMTPS id BF5C8462C63
	for <lists+linux-erofs@lfdr.de>; Tue, 30 Nov 2021 06:56:21 +0100 (CET)
Received: from boromir.ozlabs.org (localhost [IPv6:::1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4J3BKv4cWtz3c57
	for <lists+linux-erofs@lfdr.de>; Tue, 30 Nov 2021 16:56:19 +1100 (AEDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=lists.ozlabs.org;
	s=201707; t=1638251779;
	bh=DQOgoLXV1vqMD6SBnxkOvTnN/9Gr43l4y8+xwO1C6jU=;
	h=Date:In-Reply-To:References:Subject:To:List-Id:List-Unsubscribe:
	 List-Archive:List-Post:List-Help:List-Subscribe:From:Reply-To:Cc:
	 From;
	b=I/6BAiTKgYQ3jCZLQ1gixpcxNtEFPh1vi/0kTBbzNpXP+Rf2AtwI2M+e9/AB411m3
	 5NSktl3vkDiopUD8o3zzhUOTcPuqDGVcPa1l8MgxQG+8kQcikuDwDajL6fJljXWECP
	 4DhiU4aCQefEMYXOLcX9wswk+kvkkK5cxSvoI+x55/u9vwTE3KLTFK/vFdY8mDtumz
	 loLUhyNimKTCDDxYI/mXuw04FJf1D2lGfmCeSjBtbcjE0mM/I58y2ppg7EmZ+a6fSs
	 /6qupKbGDJCbYZPrWIfffaeW12ULoIPKhj8yVxf46rJBcUTEcqJszLhN5rvzUoQHVZ
	 SbXoiqdbS/pQw==
X-Original-To: linux-erofs@lists.ozlabs.org
Delivered-To: linux-erofs@lists.ozlabs.org
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized)
 smtp.mailfrom=flex--zhangkelvin.bounces.google.com
 (client-ip=2607:f8b0:4864:20::749; helo=mail-qk1-x749.google.com;
 envelope-from=3-bylyqskcx4tb4hae8fpchaiiaf8.6igfchor-8li9mfcmnm.itf45m.ila@flex--zhangkelvin.bounces.google.com;
 receiver=<UNKNOWN>)
Authentication-Results: lists.ozlabs.org; dkim=pass (2048-bit key;
 unprotected) header.d=google.com header.i=@google.com header.a=rsa-sha256
 header.s=20210112 header.b=dC/qXN43; dkim-atps=neutral
Received: from mail-qk1-x749.google.com (mail-qk1-x749.google.com
 [IPv6:2607:f8b0:4864:20::749])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 4J3BKm3b90z304y
 for <linux-erofs@lists.ozlabs.org>; Tue, 30 Nov 2021 16:56:12 +1100 (AEDT)
Received: by mail-qk1-x749.google.com with SMTP id
 v13-20020a05620a440d00b00468380f4407so27371434qkp.17
 for <linux-erofs@lists.ozlabs.org>; Mon, 29 Nov 2021 21:56:12 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=x-gm-message-state:date:in-reply-to:message-id:mime-version
 :references:subject:from:to:cc;
 bh=DQOgoLXV1vqMD6SBnxkOvTnN/9Gr43l4y8+xwO1C6jU=;
 b=gH5kxZb/H0QHXM3wqGJJS8pLlL9zLABs1ixb2EoUd5lFfXB7eXXxmwrsqwx2Uv0k6V
 3xsKBRox7Xk83p6BgcLAS5vvLKnOgm7xrKwVMHIUXYwaUWya/ea1zK+2GtlXgXV+2M5V
 U+LPoIVJNSD0b12ntZfy/Ua7neNkqDZCuTO6n1fjAwcgZDVUpgI+SfhzvpHNRyfztiHt
 VMO2sJe9RrE/sewqfyzV0eigOrbgnKxMRbuQUkEh+0kb7HPXUkGl6OagEMA7+JRIU/lN
 4uyW+iVZdvDKT4GHykZQwBmVgk7WAhJjwht+E7uQhnOvsDEoyS9FCIILCVAYFijJRByV
 HB8A==
X-Gm-Message-State: AOAM533plCK9Q5AH2RFLsrumf3FX544hRScikP7lkbWFIuLh5tXqy6yW
 fMh4fhKnqxGiIbC83738jjTrLHI4w6rmjHSOLZ4d8yKAFBo22DK8/OIAAgvpyzsmmCa5ijMcpx+
 JisHoygj5XsMKdofKZhkivGS7jVRt0hQPY5kOaXAtOow/6cFsacClAoMCTIVlCuBR9fvO0fWCn0
 UGCb3Xy6E=
X-Google-Smtp-Source: ABdhPJzkhJTVuCwYfIT1XFV8JZZRP8XjBuU+0yXMNiZHDg/iFNE5cjz+iZBNYBvjVtmsgBnRtMb7Shd0AJbtvtyEjA==
X-Received: from zhangkelvin-big.c.googlers.com
 ([fda3:e722:ac3:cc00:14:4d90:c0a8:1f4a])
 (user=zhangkelvin job=sendgmr) by 2002:a05:622a:307:: with SMTP id
 q7mr48862727qtw.330.1638251769517; Mon, 29 Nov 2021 21:56:09 -0800 (PST)
Date: Mon, 29 Nov 2021 21:56:04 -0800
In-Reply-To: <20211130055604.2876828-1-zhangkelvin@google.com>
Message-Id: <20211130055604.2876828-2-zhangkelvin@google.com>
Mime-Version: 1.0
References: <YaWYErBYsG4Yjboh@B-P7TQMD6M-0146.local>
 <20211130055604.2876828-1-zhangkelvin@google.com>
X-Mailer: git-send-email 2.34.0.rc2.393.gf8c9666880-goog
Subject: [PATCH v3 2/2] erofs-utils: Make erofs-utils more C++ friendly
To: linux-erofs mailing list <linux-erofs@lists.ozlabs.org>,
 Miao Xie <miaoxie@huawei.com>, Fang Wei <fangwei1@huawei.com>
Content-Type: text/plain; charset="UTF-8"
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
From: Kelvin Zhang via Linux-erofs <linux-erofs@lists.ozlabs.org>
Reply-To: Kelvin Zhang <zhangkelvin@google.com>
Cc: Kelvin Zhang <zhangkelvin@google.com>
Errors-To: linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org
Sender: "Linux-erofs"
 <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>

1. Add extern "C" wrappers to headers, so that they can be included from
C++
2. Add const keyworkds to certain pointer type params

Change-Id: Ica96c5626de7cc511ffa9a73e0e5ddf7601a7451
Signed-off-by: Kelvin Zhang <zhangkelvin@google.com>
---
 include/erofs/blobchunk.h      | 10 ++++++++++
 include/erofs/block_list.h     | 10 ++++++++++
 include/erofs/cache.h          |  9 +++++++++
 include/erofs/compress.h       |  9 +++++++++
 include/erofs/compress_hints.h | 10 ++++++++++
 include/erofs/config.h         | 20 +++++++++-----------
 include/erofs/decompress.h     |  9 +++++++++
 include/erofs/defs.h           | 20 ++++++++++++++++++++
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
 include/erofs_fs.h             |  9 +++++++++
 lib/config.c                   |  1 +
 lib/erofs_selinux.h            | 13 +++++++++++++
 lib/inode.c                    |  1 +
 lib/xattr.c                    |  2 ++
 25 files changed, 224 insertions(+), 11 deletions(-)
 create mode 100644 lib/erofs_selinux.h

diff --git a/include/erofs/blobchunk.h b/include/erofs/blobchunk.h
index 59a4701..6d62804 100644
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
@@ -16,4 +21,9 @@ void erofs_blob_exit(void);
 int erofs_blob_init(const char *blobfile_path);
 int erofs_generate_devtable(void);
 
+#ifdef __cplusplus
+extern "C"
+}
+#endif
+
 #endif
diff --git a/include/erofs/block_list.h b/include/erofs/block_list.h
index 40df228..ca8053e 100644
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
index b19d54e..72b849d 100644
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
index 4434aaa..fdbf5ff 100644
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
index a5772c7..43f80e1 100644
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
index 2040dc6..6ba1a30 100644
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
 #endif
+
+#endif // EROFS_CONFIG_H_
diff --git a/include/erofs/decompress.h b/include/erofs/decompress.h
index 3d0d963..e649c80 100644
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
index 6398cbb..4960dd6 100644
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
@@ -82,11 +87,16 @@ typedef int64_t         s64;
 #endif
 #endif
 
+#ifdef __cplusplus
+#define BUILD_BUG_ON(condition) static_assert(!(condition))
+#else
+
 #ifndef __OPTIMIZE__
 #define BUILD_BUG_ON(condition) ((void)sizeof(char[1 - 2 * !!(condition)]))
 #else
 #define BUILD_BUG_ON(condition) assert(!(condition))
 #endif
+#endif
 
 #define DIV_ROUND_UP(n, d) (((n) + (d) - 1) / (d))
 
@@ -110,6 +120,9 @@ typedef int64_t         s64;
 }							\
 )
 
+// Can easily conflict with C++'s std::min
+#ifndef __cplusplus
+
 #define min(x, y) ({				\
 	typeof(x) _min1 = (x);			\
 	typeof(y) _min2 = (y);			\
@@ -122,6 +135,8 @@ typedef int64_t         s64;
 	(void) (&_max1 == &_max2);		\
 	_max1 > _max2 ? _max1 : _max2; })
 
+#endif
+
 /*
  * ..and if you can't take the strict types, you can specify one yourself.
  * Or don't use min/max at all, of course.
@@ -308,4 +323,9 @@ unsigned long __roundup_pow_of_two(unsigned long n)
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
index a33bdd1..18f152a 100644
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
index 6930f2b..599f018 100644
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
index 59168d0..9b1642f 100644
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
index 024a14e..3d38578 100644
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
index 90eb84e..3c4dfc1 100644
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
index d5343c2..e23d65f 100644
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
index 666d1f2..a68de32 100644
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
index 10a3681..6f51e06 100644
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
index d2bc704..fd5358d 100644
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
index 91f864b..2213d1d 100644
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
index d70d236..893e16c 100644
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
index f0c4c26..8e68812 100644
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
diff --git a/include/erofs_fs.h b/include/erofs_fs.h
index 9a91877..62359c5 100644
--- a/include/erofs_fs.h
+++ b/include/erofs_fs.h
@@ -9,6 +9,11 @@
 #ifndef __EROFS_FS_H
 #define __EROFS_FS_H
 
+#ifdef __cplusplus
+extern "C"
+{
+#endif
+
 #define EROFS_SUPER_MAGIC_V1    0xE0F5E1E2
 #define EROFS_SUPER_OFFSET      1024
 
@@ -425,4 +430,8 @@ static inline void erofs_check_ondisk_layout_definitions(void)
 		     Z_EROFS_VLE_CLUSTER_TYPE_MAX - 1);
 }
 
+#ifdef __cplusplus
+}
+#endif
+
 #endif
diff --git a/lib/config.c b/lib/config.c
index 363dcc5..9fe5b85 100644
--- a/lib/config.c
+++ b/lib/config.c
@@ -8,6 +8,7 @@
 #include <stdlib.h>
 #include "erofs/print.h"
 #include "erofs/internal.h"
+#include "erofs_selinux.h"
 
 struct erofs_configure cfg;
 struct erofs_sb_info sbi;
diff --git a/lib/erofs_selinux.h b/lib/erofs_selinux.h
new file mode 100644
index 0000000..696e6fd
--- /dev/null
+++ b/lib/erofs_selinux.h
@@ -0,0 +1,13 @@
+
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
\ No newline at end of file
diff --git a/lib/inode.c b/lib/inode.c
index 2fa74e2..3a66d55 100644
--- a/lib/inode.c
+++ b/lib/inode.c
@@ -25,6 +25,7 @@
 #include "erofs/block_list.h"
 #include "erofs/compress_hints.h"
 #include "erofs/blobchunk.h"
+#include "erofs_selinux.h"
 
 #define S_SHIFT                 12
 static unsigned char erofs_ftype_by_mode[S_IFMT >> S_SHIFT] = {
diff --git a/lib/xattr.c b/lib/xattr.c
index 196133a..9fbc7c7 100644
--- a/lib/xattr.c
+++ b/lib/xattr.c
@@ -18,6 +18,8 @@
 #include "erofs/cache.h"
 #include "erofs/io.h"
 
+#include "erofs_selinux.h"
+
 #define EA_HASHTABLE_BITS 16
 
 struct xattr_item {
-- 
2.34.0.rc2.393.gf8c9666880-goog

