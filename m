Return-Path: <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>
X-Original-To: lists+linux-erofs@lfdr.de
Delivered-To: lists+linux-erofs@lfdr.de
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2404:9400:2:0:216:3eff:fee1:b9f1])
	by mail.lfdr.de (Postfix) with ESMTPS id 2C0F43793B8
	for <lists+linux-erofs@lfdr.de>; Mon, 10 May 2021 18:25:21 +0200 (CEST)
Received: from boromir.ozlabs.org (localhost [IPv6:::1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4Ff5xq0ydbz2yxW
	for <lists+linux-erofs@lfdr.de>; Tue, 11 May 2021 02:25:19 +1000 (AEST)
Authentication-Results: lists.ozlabs.org;
	dkim=fail reason="signature verification failed" (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20201202 header.b=XxtM58M+;
	dkim-atps=neutral
X-Original-To: linux-erofs@lists.ozlabs.org
Delivered-To: linux-erofs@lists.ozlabs.org
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized)
 smtp.mailfrom=kernel.org (client-ip=198.145.29.99; helo=mail.kernel.org;
 envelope-from=xiang@kernel.org; receiver=<UNKNOWN>)
Authentication-Results: lists.ozlabs.org; dkim=pass (2048-bit key;
 unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256
 header.s=k20201202 header.b=XxtM58M+; 
 dkim-atps=neutral
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 4Ff5xj6tmLz2xMd
 for <linux-erofs@lists.ozlabs.org>; Tue, 11 May 2021 02:25:13 +1000 (AEST)
Received: by mail.kernel.org (Postfix) with ESMTPSA id 7FD346112F;
 Mon, 10 May 2021 16:25:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=k20201202; t=1620663910;
 bh=V3huKmh6GgUUU+2+jLRu6TLFbHdQL3XqX+IYvRfuV3w=;
 h=From:To:Cc:Subject:Date:From;
 b=XxtM58M+ahbXBAdvDO1n1Bz+76WXV9JvkjWjHbf8DluZH4FgM0c+bqcxBS9YCqVj3
 vA/nCt84fapgGMhUh76QKs18ELcr/G08WB0OwTMqFxavZoJnqMxRsG6+5RKN+ic9Ut
 QFoo95rAlj+WYrpL/z2IkqRqHm4bjQyU0mVN8F0L6dFFfovXuR30PQjtVDMCV4JjLk
 s1UPuuZvCtxX8EiKK4wmDnX9L/1MUU9MORcuvCCN7X5S4PlY00KDCjDVM8F8ts038M
 CLAIqcRQSauAeFJuYNT0JB6KPv5dchS4uDxEst6tTQnuHIKm2NanPL+jijjgDozATE
 ftzx7oP8zdJlA==
From: Gao Xiang <xiang@kernel.org>
To: linux-erofs@lists.ozlabs.org,
	Chao Yu <yuchao0@huawei.com>
Subject: [PATCH 1/2] erofs: fix broken illustration in documentation
Date: Tue, 11 May 2021 00:25:05 +0800
Message-Id: <20210510162506.28637-1-xiang@kernel.org>
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
Cc: Mauro Carvalho Chehab <mchehab+huawei@kernel.org>,
 LKML <linux-kernel@vger.kernel.org>
Errors-To: linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org
Sender: "Linux-erofs"
 <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>

From: Gao Xiang <hsiangkao@redhat.com>

Illustration was broken after ReST conversion by accident.
(checked by 'make SPHINXDIRS="filesystems" htmldocs')

Fixes: e66d8631ddb3 ("docs: filesystems: convert erofs.txt to ReST")
Cc: Mauro Carvalho Chehab <mchehab+huawei@kernel.org>
Signed-off-by: Gao Xiang <hsiangkao@redhat.com>
---
 Documentation/filesystems/erofs.rst | 119 ++++++++++++++--------------
 1 file changed, 59 insertions(+), 60 deletions(-)

diff --git a/Documentation/filesystems/erofs.rst b/Documentation/filesystems/erofs.rst
index bf145171c2bf..869b183ff215 100644
--- a/Documentation/filesystems/erofs.rst
+++ b/Documentation/filesystems/erofs.rst
@@ -113,31 +113,31 @@ may not. All metadatas can be now observed in two different spaces (views):
 
     ::
 
-				    |-> aligned with 8B
-					    |-> followed closely
-	+ meta_blkaddr blocks                                      |-> another slot
-	_____________________________________________________________________
-	|  ...   | inode |  xattrs  | extents  | data inline | ... | inode ...
-	|________|_______|(optional)|(optional)|__(optional)_|_____|__________
-		|-> aligned with the inode slot size
-		    .                   .
-		    .                         .
-		.                              .
-		.                                    .
-	    .                                         .
-	    .                                              .
-	.____________________________________________________|-> aligned with 4B
-	| xattr_ibody_header | shared xattrs | inline xattrs |
-	|____________________|_______________|_______________|
-	|->    12 bytes    <-|->x * 4 bytes<-|               .
-			    .                .                 .
-			.                      .                   .
-		.                           .                     .
-	    ._______________________________.______________________.
-	    | id | id | id | id |  ... | id | ent | ... | ent| ... |
-	    |____|____|____|____|______|____|_____|_____|____|_____|
-					    |-> aligned with 4B
-							|-> aligned with 4B
+                                 |-> aligned with 8B
+                                            |-> followed closely
+     + meta_blkaddr blocks                                      |-> another slot
+       _____________________________________________________________________
+     |  ...   | inode |  xattrs  | extents  | data inline | ... | inode ...
+     |________|_______|(optional)|(optional)|__(optional)_|_____|__________
+              |-> aligned with the inode slot size
+                   .                   .
+                 .                         .
+               .                              .
+             .                                    .
+           .                                         .
+         .                                              .
+       .____________________________________________________|-> aligned with 4B
+       | xattr_ibody_header | shared xattrs | inline xattrs |
+       |____________________|_______________|_______________|
+       |->    12 bytes    <-|->x * 4 bytes<-|               .
+                           .                .                 .
+                     .                      .                   .
+                .                           .                     .
+            ._______________________________.______________________.
+            | id | id | id | id |  ... | id | ent | ... | ent| ... |
+            |____|____|____|____|______|____|_____|_____|____|_____|
+                                            |-> aligned with 4B
+                                                        |-> aligned with 4B
 
     Inode could be 32 or 64 bytes, which can be distinguished from a common
     field which all inode versions have -- i_format::
@@ -175,13 +175,13 @@ may not. All metadatas can be now observed in two different spaces (views):
     Each share xattr can also be directly found by the following formula:
          xattr offset = xattr_blkaddr * block_size + 4 * xattr_id
 
-    ::
+::
 
-			    |-> aligned by  4 bytes
-	+ xattr_blkaddr blocks                     |-> aligned with 4 bytes
-	_________________________________________________________________________
-	|  ...   | xattr_entry |  xattr data | ... |  xattr_entry | xattr data  ...
-	|________|_____________|_____________|_____|______________|_______________
+                           |-> aligned by  4 bytes
+    + xattr_blkaddr blocks                     |-> aligned with 4 bytes
+     _________________________________________________________________________
+    |  ...   | xattr_entry |  xattr data | ... |  xattr_entry | xattr data  ...
+    |________|_____________|_____________|_____|______________|_______________
 
 Directories
 -----------
@@ -193,19 +193,18 @@ algorithm (could refer to the related source code).
 
 ::
 
-		    ___________________________
-		    /                           |
-		/              ______________|________________
-		/              /              | nameoff1       | nameoffN-1
-    ____________.______________._______________v________________v__________
-    | dirent | dirent | ... | dirent | filename | filename | ... | filename |
-    |___.0___|____1___|_____|___N-1__|____0_____|____1_____|_____|___N-1____|
-	\                           ^
-	\                          |                           * could have
-	\                         |                             trailing '\0'
-	    \________________________| nameoff0
-
-				Directory block
+                  ___________________________
+                 /                           |
+                /              ______________|________________
+               /              /              | nameoff1       | nameoffN-1
+  ____________.______________._______________v________________v__________
+ | dirent | dirent | ... | dirent | filename | filename | ... | filename |
+ |___.0___|____1___|_____|___N-1__|____0_____|____1_____|_____|___N-1____|
+      \                           ^
+       \                          |                           * could have
+        \                         |                             trailing '\0'
+         \________________________| nameoff0
+                             Directory block
 
 Note that apart from the offset of the first filename, nameoff0 also indicates
 the total number of directory entries in this block since it is no need to
@@ -216,22 +215,22 @@ Compression
 Currently, EROFS supports 4KB fixed-sized output transparent file compression,
 as illustrated below::
 
-	    |---- Variant-Length Extent ----|-------- VLE --------|----- VLE -----
-	    clusterofs                      clusterofs            clusterofs
-	    |                               |                     |   logical data
-    _________v_______________________________v_____________________v_______________
-    ... |    .        |             |        .    |             |  .          | ...
-    ____|____.________|_____________|________.____|_____________|__.__________|____
-	|-> cluster <-|-> cluster <-|-> cluster <-|-> cluster <-|-> cluster <-|
-	    size          size          size          size          size
-	    .                             .                .                   .
-	    .                       .               .                  .
-		.                  .              .                .
-	_______._____________._____________._____________._____________________
-	    ... |             |             |             | ... physical data
-	_______|_____________|_____________|_____________|_____________________
-		|-> cluster <-|-> cluster <-|-> cluster <-|
-		    size          size          size
+          |<-    variable-sized extent    ->|<-       VLE         ->|
+        clusterofs                        clusterofs              clusterofs
+          |                                 |                       |
+ _________v_________________________________v_______________________v________
+ ... |    .         |              |        .     |              |  .   ...
+ ____|____._________|______________|________.___ _|______________|__.________
+     |-> lcluster <-|-> lcluster <-|-> lcluster <-|-> lcluster <-|
+          size           size           size           size   .             .
+           .                            .                .              .
+            .                       .               .               .
+             .                   .              .               .
+       _______.______________.______________.______________._________________
+          ... |              |              |              | ...
+       _______|______________|______________|______________|_________________
+              |-> pcluster <-|-> pcluster <-|-> pcluster <-|
+                    size           size           size
 
 Currently each on-disk physical cluster can contain 4KB (un)compressed data
 at most. For each logical cluster, there is a corresponding on-disk index to
-- 
2.20.1

