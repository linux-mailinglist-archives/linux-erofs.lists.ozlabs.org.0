Return-Path: <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>
X-Original-To: lists+linux-erofs@lfdr.de
Delivered-To: lists+linux-erofs@lfdr.de
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2401:3900:2:1::3])
	by mail.lfdr.de (Postfix) with ESMTPS id B97E0E1598
	for <lists+linux-erofs@lfdr.de>; Wed, 23 Oct 2019 11:18:16 +0200 (CEST)
Received: from bilbo.ozlabs.org (lists.ozlabs.org [IPv6:2401:3900:2:1::3])
	by lists.ozlabs.org (Postfix) with ESMTP id 46ylCn2RyxzDqNW
	for <lists+linux-erofs@lfdr.de>; Wed, 23 Oct 2019 20:18:13 +1100 (AEDT)
X-Original-To: linux-erofs@lists.ozlabs.org
Delivered-To: linux-erofs@lists.ozlabs.org
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized)
 smtp.mailfrom=huawei.com (client-ip=45.249.212.190; helo=huawei.com;
 envelope-from=gaoxiang25@huawei.com; receiver=<UNKNOWN>)
Authentication-Results: lists.ozlabs.org;
 dmarc=none (p=none dis=none) header.from=huawei.com
Received: from huawei.com (szxga04-in.huawei.com [45.249.212.190])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 46ylCg50tRzDqLx
 for <linux-erofs@lists.ozlabs.org>; Wed, 23 Oct 2019 20:18:03 +1100 (AEDT)
Received: from DGGEMS412-HUB.china.huawei.com (unknown [172.30.72.59])
 by Forcepoint Email with ESMTP id 8A8578B8953B1BAC344A;
 Wed, 23 Oct 2019 17:17:53 +0800 (CST)
Received: from architecture4.huawei.com (10.140.130.215) by smtp.huawei.com
 (10.3.19.212) with Microsoft SMTP Server (TLS) id 14.3.439.0; Wed, 23 Oct
 2019 17:17:43 +0800
From: Gao Xiang <gaoxiang25@huawei.com>
To: Li Guifu <bluce.liguifu@huawei.com>, <linux-erofs@lists.ozlabs.org>
Subject: [PATCH] erofs-utils: document more known matters to README
Date: Wed, 23 Oct 2019 17:20:31 +0800
Message-ID: <20191023092031.211186-1-gaoxiang25@huawei.com>
X-Mailer: git-send-email 2.17.1
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
Cc: Yann Collet <yann.collet.73@gmail.com>
Errors-To: linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org
Sender: "Linux-erofs"
 <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>

We are about to release erofs-utils 1.0, add more words
to README on known fixed issues about lz4 upstream library.

Cc: Li Guifu <bluce.liguifu@huawei.com>
Cc: Chao Yu <yuchao0@huawei.com>
Cc: Yann Collet <yann.collet.73@gmail.com>
Signed-off-by: Gao Xiang <gaoxiang25@huawei.com>
---
 README | 41 ++++++++++++++++++++++++++++++++++++++---
 1 file changed, 38 insertions(+), 3 deletions(-)

diff --git a/README b/README
index 9e65ad015a0b..60b8eed6c1d3 100644
--- a/README
+++ b/README
@@ -32,7 +32,9 @@ To build you can run the following commands in order:
 	$ ./configure
 	$ make
 
-mkfs.erofs binary will be generated under mkfs folder.
+mkfs.erofs binary will be generated under mkfs folder. There are still
+some issues which affect the stability of LZ4_compress_destSize()
+* they have impacts on lz4 only rather than lz4HC * [3].
 
 How to build for lz4-1.8.0~1.8.3
 ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
@@ -45,8 +47,8 @@ On Fedora, static lz4 can be installed using:
 
 	yum install lz4-static.x86_64
 
-However, it's not recommended to use those versions since there was a bug
-in these compressors, see [2] as well.
+However, it's not recommended to use those versions since there were bugs
+in these compressors, see [2] [3] as well.
 
 How to generate erofs images
 ~~~~~~~~~~~~~~~~~~~~~~~~~~~~
@@ -68,6 +70,14 @@ add "-E legacy-compress" to the command line, e.g.
 
  $ mkfs.erofs -E legacy-compress -zlz4hc foo.erofs.img foo/
 
+
+Known issues
+~~~~~~~~~~~~
+
+1. LZ4HC cannot compress long zeroed buffer properly with
+   LZ4_compress_HC_destSize()
+   https://github.com/lz4/lz4/issues/784
+
 Obsoleted erofs.mkfs
 ~~~~~~~~~~~~~~~~~~~~
 
@@ -109,3 +119,28 @@ Comments
     For more details, please refer to
     https://github.com/lz4/lz4/commit/660d21272e4c8a0f49db5fc1e6853f08713dff82
 
+[3] There are many crash fixes merged to lz4 1.9.2 for LZ4_compress_destSize(),
+    and I once ran into some crashs due to those issues.
+    * Again lz4HC is not effected for this section. *
+
+    [LZ4_compress_destSize] Allow 2 more bytes of match length
+    https://github.com/lz4/lz4/commit/690009e2c2f9e5dcb0d40e7c0c40610ce6006eda
+
+    [LZ4_compress_destSize] Fix rare data corruption bug
+    https://github.com/lz4/lz4/commit/6bc6f836a18d1f8fd05c8fc2b42f1d800bc25de1
+
+    [LZ4_compress_destSize] Fix overflow condition
+    https://github.com/lz4/lz4/commit/13a2d9e34ffc4170720ce417c73e396d0ac1471a
+
+    [LZ4_compress_destSize] Fix off-by-one error in fix
+    https://github.com/lz4/lz4/commit/7c32101c655d93b61fc212dcd512b87119dd7333
+
+    [LZ4_compress_destSize] Fix off-by-one error
+    https://github.com/lz4/lz4/commit/d7cad81093cd805110291f84d64d385557d0ffba
+
+    since upstream lz4 doesn't have stable branch for old versions, it's
+    preferred to use latest upstream lz4 library (although some regressions
+    could happen since new features are also introduced to latest upstream
+    version as well) or backport all stable bugfixes to old stable versions,
+    e.g. our unoffical lz4 fork: https://github.com/erofs/lz4
+
-- 
2.17.1

