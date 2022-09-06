Return-Path: <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>
X-Original-To: lists+linux-erofs@lfdr.de
Delivered-To: lists+linux-erofs@lfdr.de
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	by mail.lfdr.de (Postfix) with ESMTPS id E367A5AE6D3
	for <lists+linux-erofs@lfdr.de>; Tue,  6 Sep 2022 13:46:28 +0200 (CEST)
Received: from boromir.ozlabs.org (localhost [IPv6:::1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4MMNrf67wDz30NS
	for <lists+linux-erofs@lfdr.de>; Tue,  6 Sep 2022 21:46:26 +1000 (AEST)
X-Original-To: linux-erofs@lists.ozlabs.org
Delivered-To: linux-erofs@lists.ozlabs.org
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=linux.alibaba.com (client-ip=115.124.30.42; helo=out30-42.freemail.mail.aliyun.com; envelope-from=ziyangzhang@linux.alibaba.com; receiver=<UNKNOWN>)
Received: from out30-42.freemail.mail.aliyun.com (out30-42.freemail.mail.aliyun.com [115.124.30.42])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4MMNrb2NKlz2yT0
	for <linux-erofs@lists.ozlabs.org>; Tue,  6 Sep 2022 21:46:23 +1000 (AEST)
X-Alimail-AntiSpam: AC=PASS;BC=-1|-1;BR=01201311R111e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=ay29a033018046056;MF=ziyangzhang@linux.alibaba.com;NM=1;PH=DS;RN=2;SR=0;TI=SMTPD_---0VOrDaM-_1662464471;
Received: from localhost.localdomain(mailfrom:ZiyangZhang@linux.alibaba.com fp:SMTPD_---0VOrDaM-_1662464471)
          by smtp.aliyun-inc.com;
          Tue, 06 Sep 2022 19:41:16 +0800
From: ZiyangZhang <ZiyangZhang@linux.alibaba.com>
To: linux-erofs@lists.ozlabs.org
Subject: [PATCH 2/4] erofs-utils: lib: add rb-tree implementation
Date: Tue,  6 Sep 2022 19:40:55 +0800
Message-Id: <20220906114057.151445-2-ZiyangZhang@linux.alibaba.com>
X-Mailer: git-send-email 2.27.0
In-Reply-To: <20220906114057.151445-1-ZiyangZhang@linux.alibaba.com>
References: <20220906114057.151445-1-ZiyangZhang@linux.alibaba.com>
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
Cc: Ziyang Zhang <ZiyangZhang@linux.alibaba.com>
Errors-To: linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org
Sender: "Linux-erofs" <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>

From: Ziyang Zhang <ZiyangZhang@linux.alibaba.com>

Introduce a simple rb-tree implementation in order to store the
hash map for deduplication.

Signed-off-by: Ziyang Zhang <ZiyangZhang@linux.alibaba.com>
---
 lib/Makefile.am |   2 +-
 lib/rb_tree.c   | 512 ++++++++++++++++++++++++++++++++++++++++++++++++
 lib/rb_tree.h   | 104 ++++++++++
 3 files changed, 617 insertions(+), 1 deletion(-)
 create mode 100644 lib/rb_tree.c
 create mode 100644 lib/rb_tree.h

diff --git a/lib/Makefile.am b/lib/Makefile.am
index 3fad357..b92adee 100644
--- a/lib/Makefile.am
+++ b/lib/Makefile.am
@@ -27,7 +27,7 @@ noinst_HEADERS = $(top_srcdir)/include/erofs_fs.h \
 noinst_HEADERS += compressor.h
 liberofs_la_SOURCES = config.c io.c cache.c super.c inode.c xattr.c exclude.c \
 		      namei.c data.c compress.c compressor.c zmap.c decompress.c \
-		      compress_hints.c hashmap.c sha256.c blobchunk.c dir.c
+		      compress_hints.c hashmap.c sha256.c blobchunk.c dir.c rb_tree.c
 liberofs_la_CFLAGS = -Wall -I$(top_srcdir)/include
 if ENABLE_LZ4
 liberofs_la_CFLAGS += ${LZ4_CFLAGS}
diff --git a/lib/rb_tree.c b/lib/rb_tree.c
new file mode 100644
index 0000000..28800a9
--- /dev/null
+++ b/lib/rb_tree.c
@@ -0,0 +1,512 @@
+// SPDX-License-Identifier: Unlicense
+//
+// Based on Julienne Walker's <http://eternallyconfuzzled.com/> rb_tree
+// implementation.
+//
+// Modified by Mirek Rusin <http://github.com/mirek/rb_tree>.
+//
+// This is free and unencumbered software released into the public domain.
+//
+// Anyone is free to copy, modify, publish, use, compile, sell, or
+// distribute this software, either in source code form or as a compiled
+// binary, for any purpose, commercial or non-commercial, and by any
+// means.
+//
+// In jurisdictions that recognize copyright laws, the author or authors
+// of this software dedicate any and all copyright interest in the
+// software to the public domain. We make this dedication for the benefit
+// of the public at large and to the detriment of our heirs and
+// successors. We intend this dedication to be an overt act of
+// relinquishment in perpetuity of all present and future rights to this
+// software under copyright law.
+//
+// THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND,
+// EXPRESS OR IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF
+// MERCHANTABILITY, FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT.
+// IN NO EVENT SHALL THE AUTHORS BE LIABLE FOR ANY CLAIM, DAMAGES OR
+// OTHER LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE,
+// ARISING FROM, OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR
+// OTHER DEALINGS IN THE SOFTWARE.
+//
+// For more information, please refer to <http://unlicense.org/>
+//
+
+#include "rb_tree.h"
+
+// rb_node
+
+struct rb_node *
+rb_node_alloc () {
+    return malloc(sizeof(struct rb_node));
+}
+
+struct rb_node *
+rb_node_init (struct rb_node *self, void *value) {
+    if (self) {
+        self->red = 1;
+        self->link[0] = self->link[1] = NULL;
+        self->value = value;
+    }
+    return self;
+}
+
+struct rb_node *
+rb_node_create (void *value) {
+    return rb_node_init(rb_node_alloc(), value);
+}
+
+void
+rb_node_dealloc (struct rb_node *self) {
+    if (self) {
+        free(self);
+    }
+}
+
+static int
+rb_node_is_red (const struct rb_node *self) {
+    return self ? self->red : 0;
+}
+
+static struct rb_node *
+rb_node_rotate (struct rb_node *self, int dir) {
+    struct rb_node *result = NULL;
+    if (self) {
+        result = self->link[!dir];
+        self->link[!dir] = result->link[dir];
+        result->link[dir] = self;
+        self->red = 1;
+        result->red = 0;
+    }
+    return result;
+}
+
+static struct rb_node *
+rb_node_rotate2 (struct rb_node *self, int dir) {
+    struct rb_node *result = NULL;
+    if (self) {
+        self->link[!dir] = rb_node_rotate(self->link[!dir], !dir);
+        result = rb_node_rotate(self, dir);
+    }
+    return result;
+}
+
+// rb_tree - default callbacks
+
+int
+rb_tree_node_cmp_ptr_cb (struct rb_tree *self, struct rb_node *a, struct rb_node *b) {
+    return (a->value > b->value) - (a->value < b->value);
+}
+
+void
+rb_tree_node_dealloc_cb (struct rb_tree *self, struct rb_node *node) {
+    if (self) {
+        if (node) {
+            rb_node_dealloc(node);
+        }
+    }
+}
+
+// rb_tree
+
+struct rb_tree *
+rb_tree_alloc () {
+    return malloc(sizeof(struct rb_tree));
+}
+
+struct rb_tree *
+rb_tree_init (struct rb_tree *self, rb_tree_node_cmp_f node_cmp_cb) {
+    if (self) {
+        self->root = NULL;
+        self->size = 0;
+        self->cmp = node_cmp_cb ? node_cmp_cb : rb_tree_node_cmp_ptr_cb;
+    }
+    return self;
+}
+
+struct rb_tree *
+rb_tree_create (rb_tree_node_cmp_f node_cb) {
+    return rb_tree_init(rb_tree_alloc(), node_cb);
+}
+
+void
+rb_tree_dealloc (struct rb_tree *self, rb_tree_node_f node_cb) {
+    if (self) {
+        if (node_cb) {
+            struct rb_node *node = self->root;
+            struct rb_node *save = NULL;
+
+            // Rotate away the left links so that
+            // we can treat this like the destruction
+            // of a linked list
+            while (node) {
+                if (node->link[0] == NULL) {
+
+                    // No left links, just kill the node and move on
+                    save = node->link[1];
+                    node_cb(self, node);
+                    node = NULL;
+                } else {
+
+                    // Rotate away the left link and check again
+                    save = node->link[0];
+                    node->link[0] = save->link[1];
+                    save->link[1] = node;
+                }
+                node = save;
+            }
+        }
+        free(self);
+    }
+}
+
+int
+rb_tree_test (struct rb_tree *self, struct rb_node *root) {
+    int lh, rh;
+
+    if ( root == NULL )
+        return 1;
+    else {
+        struct rb_node *ln = root->link[0];
+        struct rb_node *rn = root->link[1];
+
+        /* Consecutive red links */
+        if (rb_node_is_red(root)) {
+            if (rb_node_is_red(ln) || rb_node_is_red(rn)) {
+                printf("Red violation");
+                return 0;
+            }
+        }
+
+        lh = rb_tree_test(self, ln);
+        rh = rb_tree_test(self, rn);
+
+        /* Invalid binary search tree */
+        if ( ( ln != NULL && self->cmp(self, ln, root) >= 0 )
+            || ( rn != NULL && self->cmp(self, rn, root) <= 0))
+        {
+            puts ( "Binary tree violation" );
+            return 0;
+        }
+
+        /* Black height mismatch */
+        if ( lh != 0 && rh != 0 && lh != rh ) {
+            puts ( "Black violation" );
+            return 0;
+        }
+
+        /* Only count black links */
+        if ( lh != 0 && rh != 0 )
+            return rb_node_is_red ( root ) ? lh : lh + 1;
+        else
+            return 0;
+    }
+}
+
+void *
+rb_tree_find(struct rb_tree *self, void *value) {
+    void *result = NULL;
+    if (self) {
+        struct rb_node node = { .value = value };
+        struct rb_node *it = self->root;
+        int cmp = 0;
+        while (it) {
+            if ((cmp = self->cmp(self, it, &node))) {
+
+                // If the tree supports duplicates, they should be
+                // chained to the right subtree for this to work
+                it = it->link[cmp < 0];
+            } else {
+                break;
+            }
+        }
+        result = it ? it->value : NULL;
+    }
+    return result;
+}
+
+// Creates (malloc'ates)
+int
+rb_tree_insert (struct rb_tree *self, void *value) {
+    return rb_tree_insert_node(self, rb_node_create(value));
+}
+
+// Returns 1 on success, 0 otherwise.
+int
+rb_tree_insert_node (struct rb_tree *self, struct rb_node *node) {
+    if (self && node) {
+        if (self->root == NULL) {
+            self->root = node;
+        } else {
+            struct rb_node head = { 0 }; // False tree root
+            struct rb_node *g, *t;       // Grandparent & parent
+            struct rb_node *p, *q;       // Iterator & parent
+            int dir = 0, last = 0;
+
+            // Set up our helpers
+            t = &head;
+            g = p = NULL;
+            q = t->link[1] = self->root;
+
+            // Search down the tree for a place to insert
+            while (1) {
+                if (q == NULL) {
+
+                    // Insert node at the first null link.
+                    p->link[dir] = q = node;
+                } else if (rb_node_is_red(q->link[0]) && rb_node_is_red(q->link[1])) {
+
+                    // Simple red violation: color flip
+                    q->red = 1;
+                    q->link[0]->red = 0;
+                    q->link[1]->red = 0;
+                }
+
+                if (rb_node_is_red(q) && rb_node_is_red(p)) {
+
+                    // Hard red violation: rotations necessary
+                    int dir2 = t->link[1] == g;
+                    if (q == p->link[last]) {
+                        t->link[dir2] = rb_node_rotate(g, !last);
+                    } else {
+                        t->link[dir2] = rb_node_rotate2(g, !last);
+                    }
+                }
+
+                // Stop working if we inserted a node. This
+                // check also disallows duplicates in the tree
+                if (self->cmp(self, q, node) == 0) {
+                    break;
+                }
+
+                last = dir;
+                dir = self->cmp(self, q, node) < 0;
+
+                // Move the helpers down
+                if (g != NULL) {
+                    t = g;
+                }
+
+                g = p, p = q;
+                q = q->link[dir];
+            }
+
+            // Update the root (it may be different)
+            self->root = head.link[1];
+        }
+
+        // Make the root black for simplified logic
+        self->root->red = 0;
+        ++self->size;
+        return 1;
+    }
+    return 0;
+}
+
+// Returns 1 if the value was removed, 0 otherwise. Optional node callback
+// can be provided to dealloc node and/or user data. Use rb_tree_node_dealloc
+// default callback to deallocate node created by rb_tree_insert(...).
+int
+rb_tree_remove_with_cb (struct rb_tree *self, void *value, rb_tree_node_f node_cb) {
+    if (self->root != NULL) {
+        struct rb_node head = {0}; // False tree root
+        struct rb_node node = { .value = value }; // Value wrapper node
+        struct rb_node *q, *p, *g; // Helpers
+        struct rb_node *f = NULL;  // Found item
+        int dir = 1;
+
+        // Set up our helpers
+        q = &head;
+        g = p = NULL;
+        q->link[1] = self->root;
+
+        // Search and push a red node down
+        // to fix red violations as we go
+        while (q->link[dir] != NULL) {
+            int last = dir;
+
+            // Move the helpers down
+            g = p, p = q;
+            q = q->link[dir];
+            dir = self->cmp(self, q, &node) < 0;
+
+            // Save the node with matching value and keep
+            // going; we'll do removal tasks at the end
+            if (self->cmp(self, q, &node) == 0) {
+                f = q;
+            }
+
+            // Push the red node down with rotations and color flips
+            if (!rb_node_is_red(q) && !rb_node_is_red(q->link[dir])) {
+                if (rb_node_is_red(q->link[!dir])) {
+                    p = p->link[last] = rb_node_rotate(q, dir);
+                } else if (!rb_node_is_red(q->link[!dir])) {
+                    struct rb_node *s = p->link[!last];
+                    if (s) {
+                        if (!rb_node_is_red(s->link[!last]) && !rb_node_is_red(s->link[last])) {
+
+                            // Color flip
+                            p->red = 0;
+                            s->red = 1;
+                            q->red = 1;
+                        } else {
+                            int dir2 = g->link[1] == p;
+                            if (rb_node_is_red(s->link[last])) {
+                                g->link[dir2] = rb_node_rotate2(p, last);
+                            } else if (rb_node_is_red(s->link[!last])) {
+                                g->link[dir2] = rb_node_rotate(p, last);
+                            }
+
+                            // Ensure correct coloring
+                            q->red = g->link[dir2]->red = 1;
+                            g->link[dir2]->link[0]->red = 0;
+                            g->link[dir2]->link[1]->red = 0;
+                        }
+                    }
+                }
+            }
+        }
+
+        // Replace and remove the saved node
+        if (f) {
+            void *tmp = f->value;
+            f->value = q->value;
+            q->value = tmp;
+
+            p->link[p->link[1] == q] = q->link[q->link[0] == NULL];
+
+            if (node_cb) {
+                node_cb(self, q);
+            }
+            q = NULL;
+        }
+
+        // Update the root (it may be different)
+        self->root = head.link[1];
+
+        // Make the root black for simplified logic
+        if (self->root != NULL) {
+            self->root->red = 0;
+        }
+
+        --self->size;
+    }
+    return 1;
+}
+
+int
+rb_tree_remove (struct rb_tree *self, void *value) {
+    int result = 0;
+    if (self) {
+        result = rb_tree_remove_with_cb(self, value, rb_tree_node_dealloc_cb);
+    }
+    return result;
+}
+
+size_t
+rb_tree_size (struct rb_tree *self) {
+    size_t result = 0;
+    if (self) {
+        result = self->size;
+    }
+    return result;
+}
+
+// rb_iter
+
+struct rb_iter *
+rb_iter_alloc () {
+    return malloc(sizeof(struct rb_iter));
+}
+
+struct rb_iter *
+rb_iter_init (struct rb_iter *self) {
+    if (self) {
+        self->tree = NULL;
+        self->node = NULL;
+        self->top = 0;
+    }
+    return self;
+}
+
+struct rb_iter *
+rb_iter_create () {
+    return rb_iter_init(rb_iter_alloc());
+}
+
+void
+rb_iter_dealloc (struct rb_iter *self) {
+    if (self) {
+        free(self);
+    }
+}
+
+// Internal function, init traversal object, dir determines whether
+// to begin traversal at the smallest or largest valued node.
+static void *
+rb_iter_start (struct rb_iter *self, struct rb_tree *tree, int dir) {
+    void *result = NULL;
+    if (self) {
+        self->tree = tree;
+        self->node = tree->root;
+        self->top = 0;
+
+        // Save the path for later selfersal
+        if (self->node != NULL) {
+            while (self->node->link[dir] != NULL) {
+                self->path[self->top++] = self->node;
+                self->node = self->node->link[dir];
+            }
+        }
+
+        result = self->node == NULL ? NULL : self->node->value;
+    }
+    return result;
+}
+
+// Traverse a red black tree in the user-specified direction (0 asc, 1 desc)
+static void *
+rb_iter_move (struct rb_iter *self, int dir) {
+    if (self->node->link[dir] != NULL) {
+
+        // Continue down this branch
+        self->path[self->top++] = self->node;
+        self->node = self->node->link[dir];
+        while ( self->node->link[!dir] != NULL ) {
+            self->path[self->top++] = self->node;
+            self->node = self->node->link[!dir];
+        }
+    } else {
+
+        // Move to the next branch
+        struct rb_node *last = NULL;
+        do {
+            if (self->top == 0) {
+                self->node = NULL;
+                break;
+            }
+            last = self->node;
+            self->node = self->path[--self->top];
+        } while (last == self->node->link[dir]);
+    }
+    return self->node == NULL ? NULL : self->node->value;
+}
+
+void *
+rb_iter_first (struct rb_iter *self, struct rb_tree *tree) {
+    return rb_iter_start(self, tree, 0);
+}
+
+void *
+rb_iter_last (struct rb_iter *self, struct rb_tree *tree) {
+    return rb_iter_start(self, tree, 1);
+}
+
+void *
+rb_iter_next (struct rb_iter *self) {
+    return rb_iter_move(self, 1);
+}
+
+void *
+rb_iter_prev (struct rb_iter *self) {
+    return rb_iter_move(self, 0);
+}
diff --git a/lib/rb_tree.h b/lib/rb_tree.h
new file mode 100644
index 0000000..5b35c74
--- /dev/null
+++ b/lib/rb_tree.h
@@ -0,0 +1,104 @@
+/* SPDX-License-Identifier: Unlicense */
+//
+// Based on Julienne Walker's <http://eternallyconfuzzled.com/> rb_tree
+// implementation.
+//
+// Modified by Mirek Rusin <http://github.com/mirek/rb_tree>.
+//
+// This is free and unencumbered software released into the public domain.
+//
+// Anyone is free to copy, modify, publish, use, compile, sell, or
+// distribute this software, either in source code form or as a compiled
+// binary, for any purpose, commercial or non-commercial, and by any
+// means.
+//
+// In jurisdictions that recognize copyright laws, the author or authors
+// of this software dedicate any and all copyright interest in the
+// software to the public domain. We make this dedication for the benefit
+// of the public at large and to the detriment of our heirs and
+// successors. We intend this dedication to be an overt act of
+// relinquishment in perpetuity of all present and future rights to this
+// software under copyright law.
+//
+// THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND,
+// EXPRESS OR IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF
+// MERCHANTABILITY, FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT.
+// IN NO EVENT SHALL THE AUTHORS BE LIABLE FOR ANY CLAIM, DAMAGES OR
+// OTHER LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE,
+// ARISING FROM, OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR
+// OTHER DEALINGS IN THE SOFTWARE.
+//
+// For more information, please refer to <http://unlicense.org/>
+//
+
+#ifndef __RB_TREE_H__
+#define __RB_TREE_H__ 1
+
+#include <stdio.h>
+#include <stdint.h>
+#include <stddef.h>
+#include <stdlib.h>
+
+#ifndef RB_ITER_MAX_HEIGHT
+#define RB_ITER_MAX_HEIGHT 64 // Tallest allowable tree to iterate
+#endif
+
+struct rb_node;
+struct rb_tree;
+
+typedef int  (*rb_tree_node_cmp_f) (struct rb_tree *self, struct rb_node *a, struct rb_node *b);
+typedef void (*rb_tree_node_f)     (struct rb_tree *self, struct rb_node *node);
+
+struct rb_node {
+    int             red;     // Color red (1), black (0)
+    struct rb_node *link[2]; // Link left [0] and right [1]
+    void           *value;   // User provided, used indirectly via rb_tree_node_cmp_f.
+};
+
+struct rb_tree {
+    struct rb_node    *root;
+    rb_tree_node_cmp_f cmp;
+    size_t             size;
+    void              *info; // User provided, not used by rb_tree.
+};
+
+struct rb_iter {
+    struct rb_tree *tree;
+    struct rb_node *node;                     // Current node
+    struct rb_node *path[RB_ITER_MAX_HEIGHT]; // Traversal path
+    size_t          top;                      // Top of stack
+    void           *info;                     // User provided, not used by rb_iter.
+};
+
+int             rb_tree_node_cmp_ptr_cb (struct rb_tree *self, struct rb_node *a, struct rb_node *b);
+void            rb_tree_node_dealloc_cb (struct rb_tree *self, struct rb_node *node);
+
+struct rb_node *rb_node_alloc           ();
+struct rb_node *rb_node_create          (void *value);
+struct rb_node *rb_node_init            (struct rb_node *self, void *value);
+void            rb_node_dealloc         (struct rb_node *self);
+
+struct rb_tree *rb_tree_alloc           ();
+struct rb_tree *rb_tree_create          (rb_tree_node_cmp_f cmp);
+struct rb_tree *rb_tree_init            (struct rb_tree *self, rb_tree_node_cmp_f cmp);
+void            rb_tree_dealloc         (struct rb_tree *self, rb_tree_node_f node_cb);
+void           *rb_tree_find            (struct rb_tree *self, void *value);
+int             rb_tree_insert          (struct rb_tree *self, void *value);
+int             rb_tree_remove          (struct rb_tree *self, void *value);
+size_t          rb_tree_size            (struct rb_tree *self);
+
+int             rb_tree_insert_node     (struct rb_tree *self, struct rb_node *node);
+int             rb_tree_remove_with_cb  (struct rb_tree *self, void *value, rb_tree_node_f node_cb);
+
+int             rb_tree_test            (struct rb_tree *self, struct rb_node *root);
+
+struct rb_iter *rb_iter_alloc           ();
+struct rb_iter *rb_iter_init            ();
+struct rb_iter *rb_iter_create          ();
+void            rb_iter_dealloc         (struct rb_iter *self);
+void           *rb_iter_first           (struct rb_iter *self, struct rb_tree *tree);
+void           *rb_iter_last            (struct rb_iter *self, struct rb_tree *tree);
+void           *rb_iter_next            (struct rb_iter *self);
+void           *rb_iter_prev            (struct rb_iter *self);
+
+#endif
-- 
2.27.0

