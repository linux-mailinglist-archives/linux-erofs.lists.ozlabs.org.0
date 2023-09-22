Return-Path: <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>
X-Original-To: lists+linux-erofs@lfdr.de
Delivered-To: lists+linux-erofs@lfdr.de
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	by mail.lfdr.de (Postfix) with ESMTPS id C8B057AB92D
	for <lists+linux-erofs@lfdr.de>; Fri, 22 Sep 2023 20:31:25 +0200 (CEST)
Received: from boromir.ozlabs.org (localhost [IPv6:::1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4Rsgp2346Cz3ckH
	for <lists+linux-erofs@lfdr.de>; Sat, 23 Sep 2023 04:31:22 +1000 (AEST)
X-Original-To: linux-erofs@lists.ozlabs.org
Delivered-To: linux-erofs@lists.ozlabs.org
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=linux.alibaba.com (client-ip=115.124.30.119; helo=out30-119.freemail.mail.aliyun.com; envelope-from=hsiangkao@linux.alibaba.com; receiver=lists.ozlabs.org)
Received: from out30-119.freemail.mail.aliyun.com (out30-119.freemail.mail.aliyun.com [115.124.30.119])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4Rsgnt4v4rz3c5c
	for <linux-erofs@lists.ozlabs.org>; Sat, 23 Sep 2023 04:31:13 +1000 (AEST)
X-Alimail-AntiSpam: AC=PASS;BC=-1|-1;BR=01201311R101e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=ay29a033018045168;MF=hsiangkao@linux.alibaba.com;NM=1;PH=DS;RN=2;SR=0;TI=SMTPD_---0VseCboc_1695407465;
Received: from e69b19392.et15sqa.tbsite.net(mailfrom:hsiangkao@linux.alibaba.com fp:SMTPD_---0VseCboc_1695407465)
          by smtp.aliyun-inc.com;
          Sat, 23 Sep 2023 02:31:07 +0800
From: Gao Xiang <hsiangkao@linux.alibaba.com>
To: linux-erofs@lists.ozlabs.org
Subject: [PATCH 2/3] erofs-utils: switch dedupe_{sub,}tree[] to a hash table
Date: Sat, 23 Sep 2023 02:30:54 +0800
Message-Id: <20230922183055.1583756-2-hsiangkao@linux.alibaba.com>
X-Mailer: git-send-email 2.39.3
In-Reply-To: <20230922183055.1583756-1-hsiangkao@linux.alibaba.com>
References: <20230922183055.1583756-1-hsiangkao@linux.alibaba.com>
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
Cc: Gao Xiang <hsiangkao@linux.alibaba.com>
Errors-To: linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org
Sender: "Linux-erofs" <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>

This rb-tree implementation is too slow and there is no benefits of it.

As a result, it could decrease time by 81.1% (5m7.755s -> 0m58.255s)
with the same dataset, sigh.

Signed-off-by: Gao Xiang <hsiangkao@linux.alibaba.com>
---
 lib/Makefile.am |   2 +-
 lib/dedupe.c    | 116 +++++------
 lib/rb_tree.c   | 512 ------------------------------------------------
 lib/rb_tree.h   | 104 ----------
 4 files changed, 62 insertions(+), 672 deletions(-)
 delete mode 100644 lib/rb_tree.c
 delete mode 100644 lib/rb_tree.h

diff --git a/lib/Makefile.am b/lib/Makefile.am
index 470e095..54b9c9c 100644
--- a/lib/Makefile.am
+++ b/lib/Makefile.am
@@ -33,7 +33,7 @@ noinst_HEADERS += compressor.h
 liberofs_la_SOURCES = config.c io.c cache.c super.c inode.c xattr.c exclude.c \
 		      namei.c data.c compress.c compressor.c zmap.c decompress.c \
 		      compress_hints.c hashmap.c sha256.c blobchunk.c dir.c \
-		      fragments.c rb_tree.c dedupe.c uuid_unparse.c uuid.c tar.c \
+		      fragments.c dedupe.c uuid_unparse.c uuid.c tar.c \
 		      block_list.c xxhash.c rebuild.c diskbuf.c
 
 liberofs_la_CFLAGS = -Wall ${libuuid_CFLAGS} -I$(top_srcdir)/include
diff --git a/lib/dedupe.c b/lib/dedupe.c
index 2f86f8d..4b0edbf 100644
--- a/lib/dedupe.c
+++ b/lib/dedupe.c
@@ -2,9 +2,9 @@
 /*
  * Copyright (C) 2022 Alibaba Cloud
  */
+#include <stdlib.h>
 #include "erofs/dedupe.h"
 #include "erofs/print.h"
-#include "rb_tree.h"
 #include "rolling_hash.h"
 #include "xxhash.h"
 #include "sha256.h"
@@ -62,9 +62,12 @@ out_bytes:
 }
 
 static unsigned int window_size, rollinghash_rm;
-static struct rb_tree *dedupe_tree, *dedupe_subtree;
+static struct list_head dedupe_tree[65536];
+struct z_erofs_dedupe_item *dedupe_subtree;
 
 struct z_erofs_dedupe_item {
+	struct list_head list;
+	struct z_erofs_dedupe_item *chain;
 	long long	hash;
 	u8		prefix_sha256[32];
 	u64		prefix_xxh64;
@@ -77,22 +80,13 @@ struct z_erofs_dedupe_item {
 	u8		extra_data[];
 };
 
-static int z_erofs_dedupe_rbtree_cmp(struct rb_tree *self,
-		struct rb_node *node_a, struct rb_node *node_b)
-{
-	struct z_erofs_dedupe_item *e_a = node_a->value;
-	struct z_erofs_dedupe_item *e_b = node_b->value;
-
-	return (e_a->hash > e_b->hash) - (e_a->hash < e_b->hash);
-}
-
 int z_erofs_dedupe_match(struct z_erofs_dedupe_ctx *ctx)
 {
 	struct z_erofs_dedupe_item e_find;
 	u8 *cur;
 	bool initial = true;
 
-	if (!dedupe_tree)
+	if (!window_size)
 		return -ENOENT;
 
 	if (ctx->cur > ctx->end - window_size)
@@ -102,8 +96,10 @@ int z_erofs_dedupe_match(struct z_erofs_dedupe_ctx *ctx)
 
 	/* move backward byte-by-byte */
 	for (; cur >= ctx->start; --cur) {
+		struct list_head *p;
 		struct z_erofs_dedupe_item *e;
-		unsigned int extra;
+
+		unsigned int extra = 0;
 		u64 xxh64_csum;
 		u8 sha256[32];
 
@@ -116,15 +112,19 @@ int z_erofs_dedupe_match(struct z_erofs_dedupe_ctx *ctx)
 				rollinghash_rm, cur[window_size], cur[0]);
 		}
 
-		e = rb_tree_find(dedupe_tree, &e_find);
-		if (!e) {
-			e = rb_tree_find(dedupe_subtree, &e_find);
-			if (!e)
+		p = &dedupe_tree[e_find.hash & (ARRAY_SIZE(dedupe_tree) - 1)];
+		list_for_each_entry(e, p, list) {
+			if (e->hash != e_find.hash)
 				continue;
+			if (!extra) {
+				xxh64_csum = xxh64(cur, window_size, 0);
+				extra = 1;
+			}
+			if (e->prefix_xxh64 == xxh64_csum)
+				break;
 		}
 
-		xxh64_csum = xxh64(cur, window_size, 0);
-		if (e->prefix_xxh64 != xxh64_csum)
+		if (&e->list == p)
 			continue;
 
 		erofs_sha256(cur, window_size, sha256);
@@ -151,9 +151,10 @@ int z_erofs_dedupe_match(struct z_erofs_dedupe_ctx *ctx)
 int z_erofs_dedupe_insert(struct z_erofs_inmem_extent *e,
 			  void *original_data)
 {
-	struct z_erofs_dedupe_item *di;
+	struct list_head *p;
+	struct z_erofs_dedupe_item *di, *k;
 
-	if (!dedupe_subtree || e->length < window_size)
+	if (!window_size || e->length < window_size)
 		return 0;
 
 	di = malloc(sizeof(*di) + e->length - window_size);
@@ -173,52 +174,44 @@ int z_erofs_dedupe_insert(struct z_erofs_inmem_extent *e,
 	di->partial = e->partial;
 	di->raw = e->raw;
 
-	/* with the same rolling hash */
-	if (!rb_tree_insert(dedupe_subtree, di))
-		free(di);
+	/* skip the same xxh64 hash */
+	p = &dedupe_tree[di->hash & (ARRAY_SIZE(dedupe_tree) - 1)];
+	list_for_each_entry(k, p, list) {
+		if (k->prefix_xxh64 == di->prefix_xxh64) {
+			free(di);
+			return 0;
+		}
+	}
+	di->chain = dedupe_subtree;
+	dedupe_subtree = di;
+	list_add_tail(&di->list, p);
 	return 0;
 }
 
-static void z_erofs_dedupe_node_free_cb(struct rb_tree *self,
-					struct rb_node *node)
-{
-	free(node->value);
-	rb_tree_node_dealloc_cb(self, node);
-}
-
 void z_erofs_dedupe_commit(bool drop)
 {
 	if (!dedupe_subtree)
 		return;
-	if (!drop) {
-		struct rb_iter iter;
-		struct z_erofs_dedupe_item *di;
-
-		di = rb_iter_first(&iter, dedupe_subtree);
-		while (di) {
-			if (!rb_tree_insert(dedupe_tree, di))
-				DBG_BUGON(1);
-			di = rb_iter_next(&iter);
+	if (drop) {
+		struct z_erofs_dedupe_item *di, *n;
+
+		for (di = dedupe_subtree; di; di = n) {
+			n = di->chain;
+			list_del(&di->list);
+			free(di);
 		}
-		/*rb_iter_dealloc(iter);*/
-		rb_tree_dealloc(dedupe_subtree, rb_tree_node_dealloc_cb);
-	} else {
-		rb_tree_dealloc(dedupe_subtree, z_erofs_dedupe_node_free_cb);
 	}
-	dedupe_subtree = rb_tree_create(z_erofs_dedupe_rbtree_cmp);
+	dedupe_subtree = NULL;
 }
 
 int z_erofs_dedupe_init(unsigned int wsiz)
 {
-	dedupe_tree = rb_tree_create(z_erofs_dedupe_rbtree_cmp);
-	if (!dedupe_tree)
-		return -ENOMEM;
+	struct list_head *p;
+
+	for (p = dedupe_tree;
+		p < dedupe_tree + ARRAY_SIZE(dedupe_tree); ++p)
+		init_list_head(p);
 
-	dedupe_subtree = rb_tree_create(z_erofs_dedupe_rbtree_cmp);
-	if (!dedupe_subtree) {
-		rb_tree_dealloc(dedupe_subtree, NULL);
-		return -ENOMEM;
-	}
 	window_size = wsiz;
 	rollinghash_rm = erofs_rollinghash_calc_rm(window_size);
 	return 0;
@@ -226,7 +219,20 @@ int z_erofs_dedupe_init(unsigned int wsiz)
 
 void z_erofs_dedupe_exit(void)
 {
+	struct z_erofs_dedupe_item *di, *n;
+	struct list_head *p;
+
+	if (!window_size)
+		return;
+
 	z_erofs_dedupe_commit(true);
-	rb_tree_dealloc(dedupe_subtree, NULL);
-	rb_tree_dealloc(dedupe_tree, z_erofs_dedupe_node_free_cb);
+
+	for (p = dedupe_tree;
+		p < dedupe_tree + ARRAY_SIZE(dedupe_tree); ++p) {
+		list_for_each_entry_safe(di, n, p, list) {
+			list_del(&di->list);
+			free(di);
+		}
+	}
+	dedupe_subtree = NULL;
 }
diff --git a/lib/rb_tree.c b/lib/rb_tree.c
deleted file mode 100644
index 28800a9..0000000
--- a/lib/rb_tree.c
+++ /dev/null
@@ -1,512 +0,0 @@
-// SPDX-License-Identifier: Unlicense
-//
-// Based on Julienne Walker's <http://eternallyconfuzzled.com/> rb_tree
-// implementation.
-//
-// Modified by Mirek Rusin <http://github.com/mirek/rb_tree>.
-//
-// This is free and unencumbered software released into the public domain.
-//
-// Anyone is free to copy, modify, publish, use, compile, sell, or
-// distribute this software, either in source code form or as a compiled
-// binary, for any purpose, commercial or non-commercial, and by any
-// means.
-//
-// In jurisdictions that recognize copyright laws, the author or authors
-// of this software dedicate any and all copyright interest in the
-// software to the public domain. We make this dedication for the benefit
-// of the public at large and to the detriment of our heirs and
-// successors. We intend this dedication to be an overt act of
-// relinquishment in perpetuity of all present and future rights to this
-// software under copyright law.
-//
-// THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND,
-// EXPRESS OR IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF
-// MERCHANTABILITY, FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT.
-// IN NO EVENT SHALL THE AUTHORS BE LIABLE FOR ANY CLAIM, DAMAGES OR
-// OTHER LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE,
-// ARISING FROM, OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR
-// OTHER DEALINGS IN THE SOFTWARE.
-//
-// For more information, please refer to <http://unlicense.org/>
-//
-
-#include "rb_tree.h"
-
-// rb_node
-
-struct rb_node *
-rb_node_alloc () {
-    return malloc(sizeof(struct rb_node));
-}
-
-struct rb_node *
-rb_node_init (struct rb_node *self, void *value) {
-    if (self) {
-        self->red = 1;
-        self->link[0] = self->link[1] = NULL;
-        self->value = value;
-    }
-    return self;
-}
-
-struct rb_node *
-rb_node_create (void *value) {
-    return rb_node_init(rb_node_alloc(), value);
-}
-
-void
-rb_node_dealloc (struct rb_node *self) {
-    if (self) {
-        free(self);
-    }
-}
-
-static int
-rb_node_is_red (const struct rb_node *self) {
-    return self ? self->red : 0;
-}
-
-static struct rb_node *
-rb_node_rotate (struct rb_node *self, int dir) {
-    struct rb_node *result = NULL;
-    if (self) {
-        result = self->link[!dir];
-        self->link[!dir] = result->link[dir];
-        result->link[dir] = self;
-        self->red = 1;
-        result->red = 0;
-    }
-    return result;
-}
-
-static struct rb_node *
-rb_node_rotate2 (struct rb_node *self, int dir) {
-    struct rb_node *result = NULL;
-    if (self) {
-        self->link[!dir] = rb_node_rotate(self->link[!dir], !dir);
-        result = rb_node_rotate(self, dir);
-    }
-    return result;
-}
-
-// rb_tree - default callbacks
-
-int
-rb_tree_node_cmp_ptr_cb (struct rb_tree *self, struct rb_node *a, struct rb_node *b) {
-    return (a->value > b->value) - (a->value < b->value);
-}
-
-void
-rb_tree_node_dealloc_cb (struct rb_tree *self, struct rb_node *node) {
-    if (self) {
-        if (node) {
-            rb_node_dealloc(node);
-        }
-    }
-}
-
-// rb_tree
-
-struct rb_tree *
-rb_tree_alloc () {
-    return malloc(sizeof(struct rb_tree));
-}
-
-struct rb_tree *
-rb_tree_init (struct rb_tree *self, rb_tree_node_cmp_f node_cmp_cb) {
-    if (self) {
-        self->root = NULL;
-        self->size = 0;
-        self->cmp = node_cmp_cb ? node_cmp_cb : rb_tree_node_cmp_ptr_cb;
-    }
-    return self;
-}
-
-struct rb_tree *
-rb_tree_create (rb_tree_node_cmp_f node_cb) {
-    return rb_tree_init(rb_tree_alloc(), node_cb);
-}
-
-void
-rb_tree_dealloc (struct rb_tree *self, rb_tree_node_f node_cb) {
-    if (self) {
-        if (node_cb) {
-            struct rb_node *node = self->root;
-            struct rb_node *save = NULL;
-
-            // Rotate away the left links so that
-            // we can treat this like the destruction
-            // of a linked list
-            while (node) {
-                if (node->link[0] == NULL) {
-
-                    // No left links, just kill the node and move on
-                    save = node->link[1];
-                    node_cb(self, node);
-                    node = NULL;
-                } else {
-
-                    // Rotate away the left link and check again
-                    save = node->link[0];
-                    node->link[0] = save->link[1];
-                    save->link[1] = node;
-                }
-                node = save;
-            }
-        }
-        free(self);
-    }
-}
-
-int
-rb_tree_test (struct rb_tree *self, struct rb_node *root) {
-    int lh, rh;
-
-    if ( root == NULL )
-        return 1;
-    else {
-        struct rb_node *ln = root->link[0];
-        struct rb_node *rn = root->link[1];
-
-        /* Consecutive red links */
-        if (rb_node_is_red(root)) {
-            if (rb_node_is_red(ln) || rb_node_is_red(rn)) {
-                printf("Red violation");
-                return 0;
-            }
-        }
-
-        lh = rb_tree_test(self, ln);
-        rh = rb_tree_test(self, rn);
-
-        /* Invalid binary search tree */
-        if ( ( ln != NULL && self->cmp(self, ln, root) >= 0 )
-            || ( rn != NULL && self->cmp(self, rn, root) <= 0))
-        {
-            puts ( "Binary tree violation" );
-            return 0;
-        }
-
-        /* Black height mismatch */
-        if ( lh != 0 && rh != 0 && lh != rh ) {
-            puts ( "Black violation" );
-            return 0;
-        }
-
-        /* Only count black links */
-        if ( lh != 0 && rh != 0 )
-            return rb_node_is_red ( root ) ? lh : lh + 1;
-        else
-            return 0;
-    }
-}
-
-void *
-rb_tree_find(struct rb_tree *self, void *value) {
-    void *result = NULL;
-    if (self) {
-        struct rb_node node = { .value = value };
-        struct rb_node *it = self->root;
-        int cmp = 0;
-        while (it) {
-            if ((cmp = self->cmp(self, it, &node))) {
-
-                // If the tree supports duplicates, they should be
-                // chained to the right subtree for this to work
-                it = it->link[cmp < 0];
-            } else {
-                break;
-            }
-        }
-        result = it ? it->value : NULL;
-    }
-    return result;
-}
-
-// Creates (malloc'ates)
-int
-rb_tree_insert (struct rb_tree *self, void *value) {
-    return rb_tree_insert_node(self, rb_node_create(value));
-}
-
-// Returns 1 on success, 0 otherwise.
-int
-rb_tree_insert_node (struct rb_tree *self, struct rb_node *node) {
-    if (self && node) {
-        if (self->root == NULL) {
-            self->root = node;
-        } else {
-            struct rb_node head = { 0 }; // False tree root
-            struct rb_node *g, *t;       // Grandparent & parent
-            struct rb_node *p, *q;       // Iterator & parent
-            int dir = 0, last = 0;
-
-            // Set up our helpers
-            t = &head;
-            g = p = NULL;
-            q = t->link[1] = self->root;
-
-            // Search down the tree for a place to insert
-            while (1) {
-                if (q == NULL) {
-
-                    // Insert node at the first null link.
-                    p->link[dir] = q = node;
-                } else if (rb_node_is_red(q->link[0]) && rb_node_is_red(q->link[1])) {
-
-                    // Simple red violation: color flip
-                    q->red = 1;
-                    q->link[0]->red = 0;
-                    q->link[1]->red = 0;
-                }
-
-                if (rb_node_is_red(q) && rb_node_is_red(p)) {
-
-                    // Hard red violation: rotations necessary
-                    int dir2 = t->link[1] == g;
-                    if (q == p->link[last]) {
-                        t->link[dir2] = rb_node_rotate(g, !last);
-                    } else {
-                        t->link[dir2] = rb_node_rotate2(g, !last);
-                    }
-                }
-
-                // Stop working if we inserted a node. This
-                // check also disallows duplicates in the tree
-                if (self->cmp(self, q, node) == 0) {
-                    break;
-                }
-
-                last = dir;
-                dir = self->cmp(self, q, node) < 0;
-
-                // Move the helpers down
-                if (g != NULL) {
-                    t = g;
-                }
-
-                g = p, p = q;
-                q = q->link[dir];
-            }
-
-            // Update the root (it may be different)
-            self->root = head.link[1];
-        }
-
-        // Make the root black for simplified logic
-        self->root->red = 0;
-        ++self->size;
-        return 1;
-    }
-    return 0;
-}
-
-// Returns 1 if the value was removed, 0 otherwise. Optional node callback
-// can be provided to dealloc node and/or user data. Use rb_tree_node_dealloc
-// default callback to deallocate node created by rb_tree_insert(...).
-int
-rb_tree_remove_with_cb (struct rb_tree *self, void *value, rb_tree_node_f node_cb) {
-    if (self->root != NULL) {
-        struct rb_node head = {0}; // False tree root
-        struct rb_node node = { .value = value }; // Value wrapper node
-        struct rb_node *q, *p, *g; // Helpers
-        struct rb_node *f = NULL;  // Found item
-        int dir = 1;
-
-        // Set up our helpers
-        q = &head;
-        g = p = NULL;
-        q->link[1] = self->root;
-
-        // Search and push a red node down
-        // to fix red violations as we go
-        while (q->link[dir] != NULL) {
-            int last = dir;
-
-            // Move the helpers down
-            g = p, p = q;
-            q = q->link[dir];
-            dir = self->cmp(self, q, &node) < 0;
-
-            // Save the node with matching value and keep
-            // going; we'll do removal tasks at the end
-            if (self->cmp(self, q, &node) == 0) {
-                f = q;
-            }
-
-            // Push the red node down with rotations and color flips
-            if (!rb_node_is_red(q) && !rb_node_is_red(q->link[dir])) {
-                if (rb_node_is_red(q->link[!dir])) {
-                    p = p->link[last] = rb_node_rotate(q, dir);
-                } else if (!rb_node_is_red(q->link[!dir])) {
-                    struct rb_node *s = p->link[!last];
-                    if (s) {
-                        if (!rb_node_is_red(s->link[!last]) && !rb_node_is_red(s->link[last])) {
-
-                            // Color flip
-                            p->red = 0;
-                            s->red = 1;
-                            q->red = 1;
-                        } else {
-                            int dir2 = g->link[1] == p;
-                            if (rb_node_is_red(s->link[last])) {
-                                g->link[dir2] = rb_node_rotate2(p, last);
-                            } else if (rb_node_is_red(s->link[!last])) {
-                                g->link[dir2] = rb_node_rotate(p, last);
-                            }
-
-                            // Ensure correct coloring
-                            q->red = g->link[dir2]->red = 1;
-                            g->link[dir2]->link[0]->red = 0;
-                            g->link[dir2]->link[1]->red = 0;
-                        }
-                    }
-                }
-            }
-        }
-
-        // Replace and remove the saved node
-        if (f) {
-            void *tmp = f->value;
-            f->value = q->value;
-            q->value = tmp;
-
-            p->link[p->link[1] == q] = q->link[q->link[0] == NULL];
-
-            if (node_cb) {
-                node_cb(self, q);
-            }
-            q = NULL;
-        }
-
-        // Update the root (it may be different)
-        self->root = head.link[1];
-
-        // Make the root black for simplified logic
-        if (self->root != NULL) {
-            self->root->red = 0;
-        }
-
-        --self->size;
-    }
-    return 1;
-}
-
-int
-rb_tree_remove (struct rb_tree *self, void *value) {
-    int result = 0;
-    if (self) {
-        result = rb_tree_remove_with_cb(self, value, rb_tree_node_dealloc_cb);
-    }
-    return result;
-}
-
-size_t
-rb_tree_size (struct rb_tree *self) {
-    size_t result = 0;
-    if (self) {
-        result = self->size;
-    }
-    return result;
-}
-
-// rb_iter
-
-struct rb_iter *
-rb_iter_alloc () {
-    return malloc(sizeof(struct rb_iter));
-}
-
-struct rb_iter *
-rb_iter_init (struct rb_iter *self) {
-    if (self) {
-        self->tree = NULL;
-        self->node = NULL;
-        self->top = 0;
-    }
-    return self;
-}
-
-struct rb_iter *
-rb_iter_create () {
-    return rb_iter_init(rb_iter_alloc());
-}
-
-void
-rb_iter_dealloc (struct rb_iter *self) {
-    if (self) {
-        free(self);
-    }
-}
-
-// Internal function, init traversal object, dir determines whether
-// to begin traversal at the smallest or largest valued node.
-static void *
-rb_iter_start (struct rb_iter *self, struct rb_tree *tree, int dir) {
-    void *result = NULL;
-    if (self) {
-        self->tree = tree;
-        self->node = tree->root;
-        self->top = 0;
-
-        // Save the path for later selfersal
-        if (self->node != NULL) {
-            while (self->node->link[dir] != NULL) {
-                self->path[self->top++] = self->node;
-                self->node = self->node->link[dir];
-            }
-        }
-
-        result = self->node == NULL ? NULL : self->node->value;
-    }
-    return result;
-}
-
-// Traverse a red black tree in the user-specified direction (0 asc, 1 desc)
-static void *
-rb_iter_move (struct rb_iter *self, int dir) {
-    if (self->node->link[dir] != NULL) {
-
-        // Continue down this branch
-        self->path[self->top++] = self->node;
-        self->node = self->node->link[dir];
-        while ( self->node->link[!dir] != NULL ) {
-            self->path[self->top++] = self->node;
-            self->node = self->node->link[!dir];
-        }
-    } else {
-
-        // Move to the next branch
-        struct rb_node *last = NULL;
-        do {
-            if (self->top == 0) {
-                self->node = NULL;
-                break;
-            }
-            last = self->node;
-            self->node = self->path[--self->top];
-        } while (last == self->node->link[dir]);
-    }
-    return self->node == NULL ? NULL : self->node->value;
-}
-
-void *
-rb_iter_first (struct rb_iter *self, struct rb_tree *tree) {
-    return rb_iter_start(self, tree, 0);
-}
-
-void *
-rb_iter_last (struct rb_iter *self, struct rb_tree *tree) {
-    return rb_iter_start(self, tree, 1);
-}
-
-void *
-rb_iter_next (struct rb_iter *self) {
-    return rb_iter_move(self, 1);
-}
-
-void *
-rb_iter_prev (struct rb_iter *self) {
-    return rb_iter_move(self, 0);
-}
diff --git a/lib/rb_tree.h b/lib/rb_tree.h
deleted file mode 100644
index 67ec0a7..0000000
--- a/lib/rb_tree.h
+++ /dev/null
@@ -1,104 +0,0 @@
-/* SPDX-License-Identifier: Unlicense */
-//
-// Based on Julienne Walker's <http://eternallyconfuzzled.com/> rb_tree
-// implementation.
-//
-// Modified by Mirek Rusin <http://github.com/mirek/rb_tree>.
-//
-// This is free and unencumbered software released into the public domain.
-//
-// Anyone is free to copy, modify, publish, use, compile, sell, or
-// distribute this software, either in source code form or as a compiled
-// binary, for any purpose, commercial or non-commercial, and by any
-// means.
-//
-// In jurisdictions that recognize copyright laws, the author or authors
-// of this software dedicate any and all copyright interest in the
-// software to the public domain. We make this dedication for the benefit
-// of the public at large and to the detriment of our heirs and
-// successors. We intend this dedication to be an overt act of
-// relinquishment in perpetuity of all present and future rights to this
-// software under copyright law.
-//
-// THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND,
-// EXPRESS OR IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF
-// MERCHANTABILITY, FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT.
-// IN NO EVENT SHALL THE AUTHORS BE LIABLE FOR ANY CLAIM, DAMAGES OR
-// OTHER LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE,
-// ARISING FROM, OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR
-// OTHER DEALINGS IN THE SOFTWARE.
-//
-// For more information, please refer to <http://unlicense.org/>
-//
-
-#ifndef __RB_TREE_H__
-#define __RB_TREE_H__ 1
-
-#include <stdio.h>
-#include <stdint.h>
-#include <stddef.h>
-#include <stdlib.h>
-
-#ifndef RB_ITER_MAX_HEIGHT
-#define RB_ITER_MAX_HEIGHT 64 // Tallest allowable tree to iterate
-#endif
-
-struct rb_node;
-struct rb_tree;
-
-typedef int  (*rb_tree_node_cmp_f) (struct rb_tree *self, struct rb_node *a, struct rb_node *b);
-typedef void (*rb_tree_node_f)     (struct rb_tree *self, struct rb_node *node);
-
-struct rb_node {
-    int             red;     // Color red (1), black (0)
-    struct rb_node *link[2]; // Link left [0] and right [1]
-    void           *value;   // User provided, used indirectly via rb_tree_node_cmp_f.
-};
-
-struct rb_tree {
-    struct rb_node    *root;
-    rb_tree_node_cmp_f cmp;
-    size_t             size;
-    void              *info; // User provided, not used by rb_tree.
-};
-
-struct rb_iter {
-    struct rb_tree *tree;
-    struct rb_node *node;                     // Current node
-    struct rb_node *path[RB_ITER_MAX_HEIGHT]; // Traversal path
-    size_t          top;                      // Top of stack
-    void           *info;                     // User provided, not used by rb_iter.
-};
-
-int             rb_tree_node_cmp_ptr_cb (struct rb_tree *self, struct rb_node *a, struct rb_node *b);
-void            rb_tree_node_dealloc_cb (struct rb_tree *self, struct rb_node *node);
-
-struct rb_node *rb_node_alloc           ();
-struct rb_node *rb_node_create          (void *value);
-struct rb_node *rb_node_init            (struct rb_node *self, void *value);
-void            rb_node_dealloc         (struct rb_node *self);
-
-struct rb_tree *rb_tree_alloc           ();
-struct rb_tree *rb_tree_create          (rb_tree_node_cmp_f cmp);
-struct rb_tree *rb_tree_init            (struct rb_tree *self, rb_tree_node_cmp_f cmp);
-void            rb_tree_dealloc         (struct rb_tree *self, rb_tree_node_f node_cb);
-void           *rb_tree_find            (struct rb_tree *self, void *value);
-int             rb_tree_insert          (struct rb_tree *self, void *value);
-int             rb_tree_remove          (struct rb_tree *self, void *value);
-size_t          rb_tree_size            (struct rb_tree *self);
-
-int             rb_tree_insert_node     (struct rb_tree *self, struct rb_node *node);
-int             rb_tree_remove_with_cb  (struct rb_tree *self, void *value, rb_tree_node_f node_cb);
-
-int             rb_tree_test            (struct rb_tree *self, struct rb_node *root);
-
-struct rb_iter *rb_iter_alloc           ();
-struct rb_iter *rb_iter_init            (struct rb_iter *self);
-struct rb_iter *rb_iter_create          ();
-void            rb_iter_dealloc         (struct rb_iter *self);
-void           *rb_iter_first           (struct rb_iter *self, struct rb_tree *tree);
-void           *rb_iter_last            (struct rb_iter *self, struct rb_tree *tree);
-void           *rb_iter_next            (struct rb_iter *self);
-void           *rb_iter_prev            (struct rb_iter *self);
-
-#endif
-- 
2.39.3

