Return-Path: <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>
X-Original-To: lists+linux-erofs@lfdr.de
Delivered-To: lists+linux-erofs@lfdr.de
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2404:9400:2:0:216:3eff:fee1:b9f1])
	by mail.lfdr.de (Postfix) with ESMTPS id 40C007609E9
	for <lists+linux-erofs@lfdr.de>; Tue, 25 Jul 2023 08:00:26 +0200 (CEST)
Received: from boromir.ozlabs.org (localhost [IPv6:::1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4R95wm1Fvyz3bX5
	for <lists+linux-erofs@lfdr.de>; Tue, 25 Jul 2023 16:00:24 +1000 (AEST)
X-Original-To: linux-erofs@lists.ozlabs.org
Delivered-To: linux-erofs@lists.ozlabs.org
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=linux.alibaba.com (client-ip=115.124.30.124; helo=out30-124.freemail.mail.aliyun.com; envelope-from=jefflexu@linux.alibaba.com; receiver=lists.ozlabs.org)
Received: from out30-124.freemail.mail.aliyun.com (out30-124.freemail.mail.aliyun.com [115.124.30.124])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4R95wg5ZZwz30fn
	for <linux-erofs@lists.ozlabs.org>; Tue, 25 Jul 2023 16:00:18 +1000 (AEST)
X-Alimail-AntiSpam: AC=PASS;BC=-1|-1;BR=01201311R101e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=ay29a033018046049;MF=jefflexu@linux.alibaba.com;NM=1;PH=DS;RN=4;SR=0;TI=SMTPD_---0VoBevWA_1690264812;
Received: from localhost(mailfrom:jefflexu@linux.alibaba.com fp:SMTPD_---0VoBevWA_1690264812)
          by smtp.aliyun-inc.com;
          Tue, 25 Jul 2023 14:00:13 +0800
From: Jingbo Xu <jefflexu@linux.alibaba.com>
To: hsiangkao@linux.alibaba.com,
	chao@kernel.org,
	huyue2@coolpad.com,
	linux-erofs@lists.ozlabs.org
Subject: [PATCH 1/3] erofs-utils: tests: convert test cases to bash
Date: Tue, 25 Jul 2023 14:00:10 +0800
Message-Id: <20230725060012.123661-1-jefflexu@linux.alibaba.com>
X-Mailer: git-send-email 2.19.1.6.gb485710b
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
Errors-To: linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org
Sender: "Linux-erofs" <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>

Convert to bash script so that some featues e.g. array and string
substitution could be used.

Signed-off-by: Jingbo Xu <jefflexu@linux.alibaba.com>
---
 tests/common/rc | 2 +-
 tests/erofs/001 | 2 +-
 tests/erofs/002 | 2 +-
 tests/erofs/003 | 2 +-
 tests/erofs/004 | 2 +-
 tests/erofs/005 | 2 +-
 tests/erofs/006 | 2 +-
 tests/erofs/007 | 2 +-
 tests/erofs/008 | 2 +-
 tests/erofs/009 | 2 +-
 tests/erofs/010 | 2 +-
 tests/erofs/011 | 2 +-
 tests/erofs/012 | 2 +-
 tests/erofs/013 | 2 +-
 tests/erofs/014 | 2 +-
 tests/erofs/015 | 2 +-
 tests/erofs/017 | 2 +-
 tests/erofs/018 | 2 +-
 tests/erofs/019 | 2 +-
 tests/erofs/020 | 2 +-
 tests/erofs/021 | 2 +-
 tests/erofs/022 | 2 +-
 22 files changed, 22 insertions(+), 22 deletions(-)

diff --git a/tests/common/rc b/tests/common/rc
index f234fdc..f54b5c1 100644
--- a/tests/common/rc
+++ b/tests/common/rc
@@ -1,4 +1,4 @@
-#!/bin/sh
+#!/bin/bash
 # SPDX-License-Identifier: GPL-2.0+
 
 tmp=/tmp/$$
diff --git a/tests/erofs/001 b/tests/erofs/001
index 0f8a6d8..8f587fb 100755
--- a/tests/erofs/001
+++ b/tests/erofs/001
@@ -1,4 +1,4 @@
-#!/bin/sh
+#!/bin/bash
 # SPDX-License-Identifier: GPL-2.0+
 #
 # test if unknown algorithm is specificed
diff --git a/tests/erofs/002 b/tests/erofs/002
index b59c846..0f38bf4 100755
--- a/tests/erofs/002
+++ b/tests/erofs/002
@@ -1,4 +1,4 @@
-#!/bin/sh
+#!/bin/bash
 # SPDX-License-Identifier: GPL-2.0+
 #
 # test short symlink (fast symlink)
diff --git a/tests/erofs/003 b/tests/erofs/003
index 6ec242d..9c60453 100755
--- a/tests/erofs/003
+++ b/tests/erofs/003
@@ -1,4 +1,4 @@
-#!/bin/sh
+#!/bin/bash
 # SPDX-License-Identifier: GPL-2.0+
 #
 # test long symlink (non-fast symlink)
diff --git a/tests/erofs/004 b/tests/erofs/004
index 25e22e6..de96d32 100755
--- a/tests/erofs/004
+++ b/tests/erofs/004
@@ -1,4 +1,4 @@
-#!/bin/sh
+#!/bin/bash
 # SPDX-License-Identifier: GPL-2.0+
 #
 # test character/block device
diff --git a/tests/erofs/005 b/tests/erofs/005
index a003e57..cd7b58b 100755
--- a/tests/erofs/005
+++ b/tests/erofs/005
@@ -1,4 +1,4 @@
-#!/bin/sh
+#!/bin/bash
 # SPDX-License-Identifier: GPL-2.0+
 #
 # test pipe files
diff --git a/tests/erofs/006 b/tests/erofs/006
index 2ebd1ae..18458b0 100755
--- a/tests/erofs/006
+++ b/tests/erofs/006
@@ -1,4 +1,4 @@
-#!/bin/sh
+#!/bin/bash
 # SPDX-License-Identifier: GPL-2.0+
 #
 # verify the uncompressed image
diff --git a/tests/erofs/007 b/tests/erofs/007
index 616e093..711759f 100755
--- a/tests/erofs/007
+++ b/tests/erofs/007
@@ -1,4 +1,4 @@
-#!/bin/sh
+#!/bin/bash
 # SPDX-License-Identifier: GPL-2.0+
 seq=`basename $0`
 seqres=$RESULT_DIR/$(echo $0 | awk '{print $((NF-1))"/"$NF}' FS="/")
diff --git a/tests/erofs/008 b/tests/erofs/008
index aa8ba1d..69b8cde 100755
--- a/tests/erofs/008
+++ b/tests/erofs/008
@@ -1,4 +1,4 @@
-#!/bin/sh
+#!/bin/bash
 # SPDX-License-Identifier: GPL-2.0+
 #
 # verify lz4 compressed image
diff --git a/tests/erofs/009 b/tests/erofs/009
index 2ce0e0a..68f801f 100755
--- a/tests/erofs/009
+++ b/tests/erofs/009
@@ -1,4 +1,4 @@
-#!/bin/sh
+#!/bin/bash
 # SPDX-License-Identifier: GPL-2.0+
 #
 # verify lz4hc compressed image
diff --git a/tests/erofs/010 b/tests/erofs/010
index a4f4180..befdac2 100755
--- a/tests/erofs/010
+++ b/tests/erofs/010
@@ -1,4 +1,4 @@
-#!/bin/sh
+#!/bin/bash
 # SPDX-License-Identifier: GPL-2.0+
 #
 # (legacy image) verify lz4 compressed image
diff --git a/tests/erofs/011 b/tests/erofs/011
index 945998b..aa8971f 100755
--- a/tests/erofs/011
+++ b/tests/erofs/011
@@ -1,4 +1,4 @@
-#!/bin/sh
+#!/bin/bash
 # SPDX-License-Identifier: GPL-2.0+
 #
 # (legacy image) verify lz4hc compressed image
diff --git a/tests/erofs/012 b/tests/erofs/012
index fbc0dac..5e4729c 100755
--- a/tests/erofs/012
+++ b/tests/erofs/012
@@ -1,4 +1,4 @@
-#!/bin/sh
+#!/bin/bash
 # SPDX-License-Identifier: GPL-2.0+
 #
 # check the hard-link functionality
diff --git a/tests/erofs/013 b/tests/erofs/013
index 9e674b9..4d52422 100755
--- a/tests/erofs/013
+++ b/tests/erofs/013
@@ -1,4 +1,4 @@
-#!/bin/sh
+#!/bin/bash
 # SPDX-License-Identifier: GPL-2.0+
 #
 # check if hardlinked directories are allowed
diff --git a/tests/erofs/014 b/tests/erofs/014
index 4b8c02f..0fcefb1 100755
--- a/tests/erofs/014
+++ b/tests/erofs/014
@@ -1,4 +1,4 @@
-#!/bin/sh
+#!/bin/bash
 # SPDX-License-Identifier: GPL-2.0+
 #
 # check if cross-device submounts are handled properly
diff --git a/tests/erofs/015 b/tests/erofs/015
index 71c39b7..e008e98 100755
--- a/tests/erofs/015
+++ b/tests/erofs/015
@@ -1,4 +1,4 @@
-#!/bin/sh
+#!/bin/bash
 # SPDX-License-Identifier: GPL-2.0+
 #
 # regression test for battach on full buffer block
diff --git a/tests/erofs/017 b/tests/erofs/017
index 0ba391f..65a897a 100755
--- a/tests/erofs/017
+++ b/tests/erofs/017
@@ -1,4 +1,4 @@
-#!/bin/sh
+#!/bin/bash
 # SPDX-License-Identifier: GPL-2.0+
 #
 # check the compress-hints functionality
diff --git a/tests/erofs/018 b/tests/erofs/018
index 3e4963a..92483d8 100755
--- a/tests/erofs/018
+++ b/tests/erofs/018
@@ -1,4 +1,4 @@
-#!/bin/sh
+#!/bin/bash
 # SPDX-License-Identifier: GPL-2.0+
 #
 # verify lzma compressed image
diff --git a/tests/erofs/019 b/tests/erofs/019
index 0b89b77..f58eec4 100755
--- a/tests/erofs/019
+++ b/tests/erofs/019
@@ -1,4 +1,4 @@
-#!/bin/sh
+#!/bin/bash
 # SPDX-License-Identifier: GPL-2.0+
 #
 # 019 - check extended attribute functionality
diff --git a/tests/erofs/020 b/tests/erofs/020
index 5f98be2..265bde4 100755
--- a/tests/erofs/020
+++ b/tests/erofs/020
@@ -1,4 +1,4 @@
-#!/bin/sh
+#!/bin/bash
 # SPDX-License-Identifier: GPL-2.0+
 #
 # 020 - check extended attributes in different layouts
diff --git a/tests/erofs/021 b/tests/erofs/021
index d36aa56..231066a 100755
--- a/tests/erofs/021
+++ b/tests/erofs/021
@@ -1,4 +1,4 @@
-#!/bin/sh
+#!/bin/bash
 # SPDX-License-Identifier: GPL-2.0+
 #
 # 021 - check extended attributes crossing block boundary
diff --git a/tests/erofs/022 b/tests/erofs/022
index a773205..7a837cb 100755
--- a/tests/erofs/022
+++ b/tests/erofs/022
@@ -1,4 +1,4 @@
-#!/bin/sh
+#!/bin/bash
 # SPDX-License-Identifier: GPL-2.0+
 #
 # 022 - check long extended attribute name prefixes
-- 
2.19.1.6.gb485710b

