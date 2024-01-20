Return-Path: <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>
X-Original-To: lists+linux-erofs@lfdr.de
Delivered-To: lists+linux-erofs@lfdr.de
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	by mail.lfdr.de (Postfix) with ESMTPS id BFE0E833541
	for <lists+linux-erofs@lfdr.de>; Sat, 20 Jan 2024 16:26:26 +0100 (CET)
Received: from boromir.ozlabs.org (localhost [IPv6:::1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4THL1B1h1Zz3bwJ
	for <lists+linux-erofs@lfdr.de>; Sun, 21 Jan 2024 02:26:22 +1100 (AEDT)
X-Original-To: linux-erofs@lists.ozlabs.org
Delivered-To: linux-erofs@lists.ozlabs.org
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=sjtu.edu.cn (client-ip=202.120.2.232; helo=smtp232.sjtu.edu.cn; envelope-from=zhaoyifan@sjtu.edu.cn; receiver=lists.ozlabs.org)
Received: from smtp232.sjtu.edu.cn (smtp232.sjtu.edu.cn [202.120.2.232])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4THL142y0Wz3bwJ
	for <linux-erofs@lists.ozlabs.org>; Sun, 21 Jan 2024 02:26:12 +1100 (AEDT)
Received: from proxy188.sjtu.edu.cn (smtp188.sjtu.edu.cn [202.120.2.188])
	by smtp232.sjtu.edu.cn (Postfix) with ESMTPS id 99ECE1008CBC3
	for <linux-erofs@lists.ozlabs.org>; Sat, 20 Jan 2024 23:26:02 +0800 (CST)
Received: from zhaoyf.ipads-lab.se.sjtu.edu.cn (unknown [202.120.40.82])
	by proxy188.sjtu.edu.cn (Postfix) with ESMTPSA id 132F337C997;
	Sat, 20 Jan 2024 23:26:00 +0800 (CST)
From: Yifan Zhao <zhaoyifan@sjtu.edu.cn>
To: linux-erofs@lists.ozlabs.org
Subject: [PATCH] erofs-utils: introduce GitHub Actions CI
Date: Sat, 20 Jan 2024 23:25:57 +0800
Message-ID: <20240120152557.178210-1-zhaoyifan@sjtu.edu.cn>
X-Mailer: git-send-email 2.43.0
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
Cc: Yifan Zhao <zhaoyifan@sjtu.edu.cn>
Errors-To: linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org
Sender: "Linux-erofs" <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>

This commit introduces a new CI workflow configuration designed to
automate the testing process for erofs-utils. This CI is based on the
free GitHub Actions for we have a fork in GitHub. The CI will be
triggered on every push to the {main,dev,experimental} branch.

Currently, we have only a simple test for ensuring the correctness of
mkfs.erofs, which covers a small subset of its extended options
including dedupe, fragments, ztailpacking and {lz4,lz4hc,deflate}
compression algorithms. It creates a EROFS image using Linux v6.7 source
code as the workload, then extracts it using fsck.erofs and compares the
sha256sum of the extracted files with the original ones.

Signed-off-by: Yifan Zhao <zhaoyifan@sjtu.edu.cn>
---
Hi forks,

I believe it's time to introduce a CI for erofs-utils, which could help
us to ensure the correctness of the code and avoid regressions.

Currently this simple CI covers only a limited subset of mkfs.erofs as
the commit message says, but more tests could be added in the future,
including:
    - LZMA compression (which is not supported for static-linking issue)
    - potential compression/dedupe rate regression ([1] is such a case)
    - CI for fsck, dump and erofsfuse

An CI demo is available at [2]. In fact, problems (maybe) have been
found in [3] with deflate compression algorithm with the help of this CI.
I will take a look at this later.

[1] https://lore.kernel.org/linux-erofs/20240115150550.1961455-1-hsiangkao@linux.alibaba.com/T/#u
[2] https://github.com/SToPire/erofs-utils-citest/actions/runs/7595077242
[3] https://github.com/SToPire/erofs-utils-citest/actions/runs/7595102798

 .github/workflow/ci.yml | 92 +++++++++++++++++++++++++++++++++++++++++
 1 file changed, 92 insertions(+)
 create mode 100644 .github/workflow/ci.yml

diff --git a/.github/workflow/ci.yml b/.github/workflow/ci.yml
new file mode 100644
index 0000000..784166f
--- /dev/null
+++ b/.github/workflow/ci.yml
@@ -0,0 +1,92 @@
+name: erofs-utils CI
+
+on:
+  push:
+    branches:
+      - master
+      - dev
+      - experimental
+  workflow_dispatch:
+
+jobs:
+  build:
+    runs-on: ubuntu-latest
+
+    steps:
+      - name: checkout erofs-utils
+        uses: actions/checkout@v4
+        with:
+          path: 'erofs-utils'
+
+      - name: autogen erofs-utils
+        working-directory: ./erofs-utils/
+        run: ./autogen.sh
+
+      - name: configure erofs-utils
+        working-directory: ./erofs-utils/
+        run: ./configure --enable-debug
+          --prefix=${{ github.workspace }}/erofs-utils-install/
+
+      - name: make and install erofs-utils
+        working-directory: ./erofs-utils/
+        run: |
+          make
+          make install
+
+      - name: tar erofs-utils binaries
+        run: tar -cvf erofs-utils-binaries.tar -C ${{ github.workspace }}/erofs-utils-install/bin .
+
+      - name: upload erofs-utils binaries
+        uses: actions/upload-artifact@v4
+        with:
+          name: erofs-utils-binaries
+          path: erofs-utils-binaries.tar
+          overwrite: true
+
+  mkfs-correctness:
+    needs: build
+    strategy:
+      fail-fast: false
+      matrix:
+        algorithm: ['', '-zlz4', '-zlz4hc', '-zdeflate']
+        dedupe: ['', '-Ededupe']
+        fragments: ['', '-Efragments', '-Eall-fragments']
+        ztailpacking: ['', '-Eztailpacking']
+
+    runs-on: ubuntu-latest
+
+    steps:
+      - name: cache Linux-src
+        id: cache-linux-src
+        uses: actions/cache@v4
+        with:
+          path: 'Linux-src'
+          key: Linux-src-v6.7
+
+      - name: checkout Linux-src if not cached
+        if: steps.cache-linux-src.outputs.cache-hit != 'true'
+        uses: actions/checkout@v4
+        with:
+          repository: 'torvalds/linux'
+          ref: 'v6.7'
+          path: 'Linux-src'
+
+      - name: download erofs-utils binaries
+        uses: actions/download-artifact@v4
+        with:
+          name: erofs-utils-binaries
+
+      - name: untar erofs-utils binaries
+        run:
+          tar -xvf erofs-utils-binaries.tar
+
+      - name: test mkfs.erofs
+        run: |
+          ./mkfs.erofs --quiet ${{ matrix.algorithm }} ${{ matrix.dedupe }} ${{ matrix.fragments }} ${{ matrix.ztailpacking }} erofs-test.img Linux-src/
+          ./fsck.erofs --extract=extract-dir/ erofs-test.img
+
+          HASH1=$(find extract-dir -type f -exec sha256sum {} + | sed 's/extract-dir//g' | sort -k2 | sha256sum -)
+          HASH2=$(find Linux-src -type f -exec sha256sum {} + | sed 's/Linux-src//g' | sort -k2 | sha256sum -)
+          if [ "$HASH1" = "$HASH2" ]; then
+            echo "PASS!"
+          fi
\ No newline at end of file
-- 
2.43.0

