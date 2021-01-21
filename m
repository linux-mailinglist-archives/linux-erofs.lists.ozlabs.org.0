Return-Path: <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>
X-Original-To: lists+linux-erofs@lfdr.de
Delivered-To: lists+linux-erofs@lfdr.de
Received: from lists.ozlabs.org (lists.ozlabs.org [203.11.71.2])
	by mail.lfdr.de (Postfix) with ESMTPS id B07132FF0B4
	for <lists+linux-erofs@lfdr.de>; Thu, 21 Jan 2021 17:43:01 +0100 (CET)
Received: from bilbo.ozlabs.org (lists.ozlabs.org [IPv6:2401:3900:2:1::3])
	by lists.ozlabs.org (Postfix) with ESMTP id 4DM7VV3tQ2zDrQX
	for <lists+linux-erofs@lfdr.de>; Fri, 22 Jan 2021 03:42:58 +1100 (AEDT)
X-Original-To: linux-erofs@lists.ozlabs.org
Delivered-To: linux-erofs@lists.ozlabs.org
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized)
 smtp.mailfrom=mail.scut.edu.cn (client-ip=202.38.213.20; helo=mail.scut.edu.cn;
 envelope-from=sehuww@mail.scut.edu.cn; receiver=<UNKNOWN>)
Received: from mail.scut.edu.cn (stumail1.scut.edu.cn [202.38.213.20])
 by lists.ozlabs.org (Postfix) with ESMTP id 4DM7VG6pfPzDqV4
 for <linux-erofs@lists.ozlabs.org>; Fri, 22 Jan 2021 03:42:42 +1100 (AEDT)
Received: from DESKTOP-N4CECTO.huww98.cn (unknown [59.53.40.31])
 by front (Coremail) with SMTP id AWSowAC3WADtrglgk7nbAQ--.12161S4;
 Fri, 22 Jan 2021 00:42:22 +0800 (CST)
From: Hu Weiwen <sehuww@mail.scut.edu.cn>
To: linux-erofs@lists.ozlabs.org
Subject: [PATCH 7/7] erofs-utils: tests: enable GitHub Actions
Date: Fri, 22 Jan 2021 00:42:28 +0800
Message-Id: <20210121164228.11939-1-sehuww@mail.scut.edu.cn>
X-Mailer: git-send-email 2.30.0
In-Reply-To: <20210121163715.10660-1-sehuww@mail.scut.edu.cn>
References: <20210121163715.10660-1-sehuww@mail.scut.edu.cn>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID: AWSowAC3WADtrglgk7nbAQ--.12161S4
X-Coremail-Antispam: 1UD129KBjvJXoW7Kw4fXr4xKr1UGw4ruF1Utrb_yoW8AF1rp3
 s5G34YyF47Kr9Iy3WSgFWrW3W5Jrs7CryUC3WxXw47A34DXan0kr1YgFyrAF4xJrn3ZrWf
 ZFW0vrnFgr4fXF7anT9S1TB71UUUUUUqnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
 9KBjDU0xBIdaVrnRJUUUka14x267AKxVWUJVW8JwAFc2x0x2IEx4CE42xK8VAvwI8IcIk0
 rVWrJVCq3wAFIxvE14AKwVWUJVWUGwA2ocxC64kIII0Yj41l84x0c7CEw4AK67xGY2AK02
 1l84ACjcxK6xIIjxv20xvE14v26r4j6ryUM28EF7xvwVC0I7IYx2IY6xkF7I0E14v26r4j
 6F4UM28EF7xvwVC2z280aVAFwI0_Gr0_Cr1l84ACjcxK6I8E87Iv6xkF7I0E14v26r4j6r
 4UJwAS0I0E0xvYzxvE52x082IY62kv0487Mc02F40EFcxC0VAKzVAqx4xG6I80ewAv7VC0
 I7IYx2IY67AKxVWUXVWUAwAv7VC2z280aVAFwI0_Jr0_Gr1lOx8S6xCaFVCjc4AY6r1j6r
 4UM4x0Y48IcxkI7VAKI48JM4x0x7Aq67IIx4CEVc8vx2IErcIFxwCY02Avz4vE14v_JwCF
 04k20xvY0x0EwIxGrwCFx2IqxVCFs4IE7xkEbVWUJVW8JwC20s026c02F40E14v26r1j6r
 18MI8I3I0E7480Y4vE14v26r106r1rMI8E67AF67kF1VAFwI0_Jrv_JF1lIxkGc2Ij64vI
 r41lIxAIcVC0I7IYx2IY67AKxVWUCVW8JwCI42IY6xIIjxv20xvEc7CjxVAFwI0_Gr0_Cr
 1lIxAIcVCF04k26cxKx2IYs7xG6r4j6FyUMIIF0xvEx4A2jsIE14v26r4j6F4UMIIF0xvE
 x4A2jsIEc7CjxVAFwI0_Gr0_Gr1UYxBIdaVFxhVjvjDU0xZFpf9x0JUjYLkUUUUU=
X-CM-SenderInfo: qsqrljqqwxllyrt6zt1loo2ulxwovvfxof0/1tbiAQAHBlepTBDfZQAhs5
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
Sender: "Linux-erofs"
 <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>

Use GitHub Actions to run tests automatically.

for two configuration: no lz4, with lz4 v1.8.3

run tests: make check; FSTYPE=fuse make check; sudo make check; make distcheck

Signed-off-by: Hu Weiwen <sehuww@mail.scut.edu.cn>
---
 .github/workflows/c.yml | 49 +++++++++++++++++++++++++++++++++++++++++
 .gitignore              |  1 +
 2 files changed, 50 insertions(+)
 create mode 100644 .github/workflows/c.yml

diff --git a/.github/workflows/c.yml b/.github/workflows/c.yml
new file mode 100644
index 0000000..1d55feb
--- /dev/null
+++ b/.github/workflows/c.yml
@@ -0,0 +1,49 @@
+name: C CI
+
+on:
+  push:
+  pull_request:
+    branches: [ dev ]
+
+jobs:
+  build:
+
+    runs-on: ubuntu-20.04
+    strategy:
+      matrix:
+        lz4: [no, v1.9.3]
+
+    steps:
+    - name: check kernel version
+      run: uname -a
+    - uses: actions/checkout@v2
+    - name: install dependencies
+      run: sudo apt-get install uuid-dev libfuse-dev
+    - name: install lz4
+      if: ${{ matrix.lz4 != 'no' }}
+      run: |
+        cd
+        git clone --depth=1 --branch=${{ matrix.lz4 }} https://github.com/lz4/lz4.git
+        cd lz4
+        make
+        sudo make install
+        sudo ldconfig
+    - name: autogen
+      run: ./autogen.sh
+    - name: configure
+      run: ./configure --enable-fuse
+    - name: make
+      run: make
+    - name: make check
+      run: make check
+    - name: make check (fuse)
+      run: FSTYP=erofsfuse make check
+    - name: make check (root)
+      run: sudo make check
+    - uses: actions/upload-artifact@v2
+      if: ${{ !cancelled() }}
+      with:
+        name: test-results-lz4-${{ matrix.lz4 }}
+        path: tests/results
+    - name: make distcheck
+      run: make distcheck
diff --git a/.gitignore b/.gitignore
index e4349dd..0feae62 100644
--- a/.gitignore
+++ b/.gitignore
@@ -11,6 +11,7 @@
 *.so
 *.so.dbg
 *.tar.*
+!.github
 
 #
 # Generated files
-- 
2.30.0

