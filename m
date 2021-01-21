Return-Path: <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>
X-Original-To: lists+linux-erofs@lfdr.de
Delivered-To: lists+linux-erofs@lfdr.de
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2401:3900:2:1::3])
	by mail.lfdr.de (Postfix) with ESMTPS id CD9772FF09C
	for <lists+linux-erofs@lfdr.de>; Thu, 21 Jan 2021 17:40:13 +0100 (CET)
Received: from bilbo.ozlabs.org (lists.ozlabs.org [IPv6:2401:3900:2:1::3])
	by lists.ozlabs.org (Postfix) with ESMTP id 4DM7RG6w22zDrQH
	for <lists+linux-erofs@lfdr.de>; Fri, 22 Jan 2021 03:40:10 +1100 (AEDT)
X-Original-To: linux-erofs@lists.ozlabs.org
Delivered-To: linux-erofs@lists.ozlabs.org
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized)
 smtp.mailfrom=mail.scut.edu.cn (client-ip=202.38.213.20; helo=mail.scut.edu.cn;
 envelope-from=sehuww@mail.scut.edu.cn; receiver=<UNKNOWN>)
Received: from mail.scut.edu.cn (stumail1.scut.edu.cn [202.38.213.20])
 by lists.ozlabs.org (Postfix) with ESMTP id 4DM7Qw6TjwzDqV4
 for <linux-erofs@lists.ozlabs.org>; Fri, 22 Jan 2021 03:39:52 +1100 (AEDT)
Received: from DESKTOP-N4CECTO.huww98.cn (unknown [59.53.40.31])
 by front (Coremail) with SMTP id AWSowADn7eFDrglgpLbbAQ--.1175S6;
 Fri, 22 Jan 2021 00:39:34 +0800 (CST)
From: Hu Weiwen <sehuww@mail.scut.edu.cn>
To: linux-erofs@lists.ozlabs.org
Subject: [PATCH 2/7] erofs-utils: tests: fix on out-of-tree build
Date: Fri, 22 Jan 2021 00:37:10 +0800
Message-Id: <20210121163715.10660-3-sehuww@mail.scut.edu.cn>
X-Mailer: git-send-email 2.30.0
In-Reply-To: <20210121163715.10660-1-sehuww@mail.scut.edu.cn>
References: <20210121163715.10660-1-sehuww@mail.scut.edu.cn>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID: AWSowADn7eFDrglgpLbbAQ--.1175S6
X-Coremail-Antispam: 1UD129KBjvJXoWxZr4UZrW5WFW3CF47GFyxuFg_yoW7Jr17p3
 98Gw1I9r4xCFnF9r4Igr1DAFn7JryIqr1UA3ykXr10v3WDXFyUW34xKr17C3WagrWDWw4f
 Z3WIv34rGa18Gw7anT9S1TB71UUUUUUqnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
 9KBjDU0xBIdaVrnRJUUUBI14x267AKxVW8JVW5JwAFc2x0x2IEx4CE42xK8VAvwI8IcIk0
 rVWrJVCq3wAFIxvE14AKwVWUJVWUGwA2048vs2IY020E87I2jVAFwI0_Jryl82xGYIkIc2
 x26xkF7I0E14v26r1I6r4UM28lY4IEw2IIxxk0rwA2F7IY1VAKz4vEj48ve4kI8wA2z4x0
 Y4vE2Ix0cI8IcVAFwI0_JFI_Gr1l84ACjcxK6xIIjxv20xvEc7CjxVAFwI0_Gr0_Cr1l84
 ACjcxK6I8E87Iv67AKxVW8JVWxJwA2z4x0Y4vEx4A2jsIEc7CjxVAFwI0_Gr0_Gr1UM2AI
 xVAIcxkEcVAq07x20xvEncxIr21l5I8CrVACY4xI64kE6c02F40Ex7xfMcIj6xIIjxv20x
 vE14v26r1Y6r17McIj6I8E87Iv67AKxVWUJVW8JwAm72CE4IkC6x0Yz7v_Jr0_Gr1lF7xv
 r2IYc2Ij64vIr41lF7I21c0EjII2zVCS5cI20VAGYxC7MxkIecxEwVAFwVWUMxAIw28Icx
 kI7VAKI48JMxC20s026xCaFVCjc4AY6r1j6r4UMI8I3I0E5I8CrVAFwI0_Jr0_Jr4lx2Iq
 xVCjr7xvwVAFwI0_JrI_JrWlx4CE17CEb7AF67AKxVWUXVWUAwCIc40Y0x0EwIxGrwCI42
 IY6xIIjxv20xvE14v26r1j6r1xMIIF0xvE2Ix0cI8IcVCY1x0267AKxVW8JVWxJwCI42IY
 6xAIw20EY4v20xvaj40_Jr0_JF4lIxAIcVC2z280aVAFwI0_Jr0_Gr1lIxAIcVC2z280aV
 CY1x0267AKxVW8JVW8JrUvcSsGvfC2KfnxnUUI43ZEXa7VUU1v3UUUUUU==
X-CM-SenderInfo: qsqrljqqwxllyrt6zt1loo2ulxwovvfxof0/1tbiAQAHBlepTBDfZQAXsP
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

e.g.: mkdir debug && cd debug && ../configure && make check

Signed-off-by: Hu Weiwen <sehuww@mail.scut.edu.cn>
---
 .gitignore      | 1 +
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
 15 files changed, 15 insertions(+), 14 deletions(-)

diff --git a/.gitignore b/.gitignore
index 8bdd505..e4349dd 100644
--- a/.gitignore
+++ b/.gitignore
@@ -28,3 +28,4 @@ libtool
 stamp-h
 stamp-h1
 
+*/tests/results/
diff --git a/tests/erofs/001 b/tests/erofs/001
index e4adfd4..2107e81 100755
--- a/tests/erofs/001
+++ b/tests/erofs/001
@@ -4,7 +4,7 @@ seq=`basename $0`
 seqres=$RESULT_DIR/$seq
 
 # get standard environment, filters and checks
-. common/rc
+. "${srcdir}/common/rc"
 
 cleanup()
 {
diff --git a/tests/erofs/002 b/tests/erofs/002
index 4f0d13a..88a5cbf 100755
--- a/tests/erofs/002
+++ b/tests/erofs/002
@@ -4,7 +4,7 @@ seq=`basename $0`
 seqres=$RESULT_DIR/$seq
 
 # get standard environment, filters and checks
-. common/rc
+. "${srcdir}/common/rc"
 
 cleanup()
 {
diff --git a/tests/erofs/003 b/tests/erofs/003
index b283801..43c1e07 100755
--- a/tests/erofs/003
+++ b/tests/erofs/003
@@ -4,7 +4,7 @@ seq=`basename $0`
 seqres=$RESULT_DIR/$seq
 
 # get standard environment, filters and checks
-. common/rc
+. "${srcdir}/common/rc"
 
 cleanup()
 {
diff --git a/tests/erofs/004 b/tests/erofs/004
index 6827f70..4a8284b 100755
--- a/tests/erofs/004
+++ b/tests/erofs/004
@@ -4,7 +4,7 @@ seq=`basename $0`
 seqres=$RESULT_DIR/$seq
 
 # get standard environment, filters and checks
-. common/rc
+. "${srcdir}/common/rc"
 
 cleanup()
 {
diff --git a/tests/erofs/005 b/tests/erofs/005
index 64c6d40..dd0487b 100755
--- a/tests/erofs/005
+++ b/tests/erofs/005
@@ -4,7 +4,7 @@ seq=`basename $0`
 seqres=$RESULT_DIR/$seq
 
 # get standard environment, filters and checks
-. common/rc
+. "${srcdir}/common/rc"
 
 cleanup()
 {
diff --git a/tests/erofs/006 b/tests/erofs/006
index 6a0222f..ebe1f8b 100755
--- a/tests/erofs/006
+++ b/tests/erofs/006
@@ -4,7 +4,7 @@ seq=`basename $0`
 seqres=$RESULT_DIR/$seq
 
 # get standard environment, filters and checks
-. common/rc
+. "${srcdir}/common/rc"
 
 cleanup()
 {
diff --git a/tests/erofs/007 b/tests/erofs/007
index 7f69617..80628cb 100755
--- a/tests/erofs/007
+++ b/tests/erofs/007
@@ -4,7 +4,7 @@ seq=`basename $0`
 seqres=$RESULT_DIR/$seq
 
 # get standard environment, filters and checks
-. common/rc
+. "${srcdir}/common/rc"
 
 cleanup()
 {
diff --git a/tests/erofs/008 b/tests/erofs/008
index 48b91b6..80a6d2e 100755
--- a/tests/erofs/008
+++ b/tests/erofs/008
@@ -4,7 +4,7 @@ seq=`basename $0`
 seqres=$RESULT_DIR/$seq
 
 # get standard environment, filters and checks
-. common/rc
+. "${srcdir}/common/rc"
 
 cleanup()
 {
diff --git a/tests/erofs/009 b/tests/erofs/009
index b95787e..14e6639 100755
--- a/tests/erofs/009
+++ b/tests/erofs/009
@@ -4,7 +4,7 @@ seq=`basename $0`
 seqres=$RESULT_DIR/$seq
 
 # get standard environment, filters and checks
-. common/rc
+. "${srcdir}/common/rc"
 
 cleanup()
 {
diff --git a/tests/erofs/010 b/tests/erofs/010
index 5b87e5b..c31e387 100755
--- a/tests/erofs/010
+++ b/tests/erofs/010
@@ -4,7 +4,7 @@ seq=`basename $0`
 seqres=$RESULT_DIR/$seq
 
 # get standard environment, filters and checks
-. common/rc
+. "${srcdir}/common/rc"
 
 cleanup()
 {
diff --git a/tests/erofs/011 b/tests/erofs/011
index 16d485c..3922ae6 100755
--- a/tests/erofs/011
+++ b/tests/erofs/011
@@ -4,7 +4,7 @@ seq=`basename $0`
 seqres=$RESULT_DIR/$seq
 
 # get standard environment, filters and checks
-. common/rc
+. "${srcdir}/common/rc"
 
 cleanup()
 {
diff --git a/tests/erofs/012 b/tests/erofs/012
index ab5d345..46dcc3a 100755
--- a/tests/erofs/012
+++ b/tests/erofs/012
@@ -4,7 +4,7 @@ seq=`basename $0`
 seqres=$RESULT_DIR/$seq
 
 # get standard environment, filters and checks
-. common/rc
+. "${srcdir}/common/rc"
 
 cleanup()
 {
diff --git a/tests/erofs/013 b/tests/erofs/013
index 1bc3448..0beac2e 100755
--- a/tests/erofs/013
+++ b/tests/erofs/013
@@ -4,7 +4,7 @@ seq=`basename $0`
 seqres=$RESULT_DIR/$seq
 
 # get standard environment, filters and checks
-. common/rc
+. "${srcdir}/common/rc"
 
 cleanup()
 {
diff --git a/tests/erofs/014 b/tests/erofs/014
index aa6b604..b94b48f 100755
--- a/tests/erofs/014
+++ b/tests/erofs/014
@@ -4,7 +4,7 @@ seq=`basename $0`
 seqres=$RESULT_DIR/$seq
 
 # get standard environment, filters and checks
-. common/rc
+. "${srcdir}/common/rc"
 
 cleanup()
 {
-- 
2.30.0

