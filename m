Return-Path: <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>
X-Original-To: lists+linux-erofs@lfdr.de
Delivered-To: lists+linux-erofs@lfdr.de
Received: from lists.ozlabs.org (lists.ozlabs.org [203.11.71.2])
	by mail.lfdr.de (Postfix) with ESMTPS id 1D3042FF098
	for <lists+linux-erofs@lfdr.de>; Thu, 21 Jan 2021 17:40:05 +0100 (CET)
Received: from bilbo.ozlabs.org (lists.ozlabs.org [IPv6:2401:3900:2:1::3])
	by lists.ozlabs.org (Postfix) with ESMTP id 4DM7R62s10zDrQH
	for <lists+linux-erofs@lfdr.de>; Fri, 22 Jan 2021 03:40:02 +1100 (AEDT)
X-Original-To: linux-erofs@lists.ozlabs.org
Delivered-To: linux-erofs@lists.ozlabs.org
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized)
 smtp.mailfrom=mail.scut.edu.cn (client-ip=202.38.213.20; helo=mail.scut.edu.cn;
 envelope-from=sehuww@mail.scut.edu.cn; receiver=<UNKNOWN>)
Received: from mail.scut.edu.cn (stumail1.scut.edu.cn [202.38.213.20])
 by lists.ozlabs.org (Postfix) with ESMTP id 4DM7Qx1FvVzDqVT
 for <linux-erofs@lists.ozlabs.org>; Fri, 22 Jan 2021 03:39:52 +1100 (AEDT)
Received: from DESKTOP-N4CECTO.huww98.cn (unknown [59.53.40.31])
 by front (Coremail) with SMTP id AWSowADn7eFDrglgpLbbAQ--.1175S9;
 Fri, 22 Jan 2021 00:39:35 +0800 (CST)
From: Hu Weiwen <sehuww@mail.scut.edu.cn>
To: linux-erofs@lists.ozlabs.org
Subject: [PATCH 5/7] erofs-utils: tests: check battach on full buffer block
Date: Fri, 22 Jan 2021 00:37:13 +0800
Message-Id: <20210121163715.10660-6-sehuww@mail.scut.edu.cn>
X-Mailer: git-send-email 2.30.0
In-Reply-To: <20210121163715.10660-1-sehuww@mail.scut.edu.cn>
References: <20210121163715.10660-1-sehuww@mail.scut.edu.cn>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID: AWSowADn7eFDrglgpLbbAQ--.1175S9
X-Coremail-Antispam: 1UD129KBjvJXoW7uF13KFW7Wr1kXr4DGFyrXrb_yoW5JF43pw
 4DKF1Fvr1xJFnFvw4Sgr17ZF1rKwnYyr4UAw4xW348ZFyqkF1UJ3ykKr4UJr9rGr42gr48
 Z3Z2qFyrGr18t3JanT9S1TB71UUUUUUqnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
 9KBjDU0xBIdaVrnRJUUUBq14x267AKxVWrJVCq3wAFc2x0x2IEx4CE42xK8VAvwI8IcIk0
 rVWrJVCq3wAFIxvE14AKwVWUJVWUGwA2048vs2IY020E87I2jVAFwI0_JF0E3s1l82xGYI
 kIc2x26xkF7I0E14v26r4j6ryUM28lY4IEw2IIxxk0rwA2F7IY1VAKz4vEj48ve4kI8wA2
 z4x0Y4vE2Ix0cI8IcVAFwI0_JFI_Gr1l84ACjcxK6xIIjxv20xvEc7CjxVAFwI0_Gr0_Cr
 1l84ACjcxK6I8E87Iv67AKxVW8JVWxJwA2z4x0Y4vEx4A2jsIEc7CjxVAFwI0_Gr0_Gr1U
 M2AIxVAIcxkEcVAq07x20xvEncxIr21l5I8CrVACY4xI64kE6c02F40Ex7xfMcIj6xIIjx
 v20xvE14v26r1Y6r17McIj6I8E87Iv67AKxVWUJVW8JwAm72CE4IkC6x0Yz7v_Jr0_Gr1l
 F7xvr2IYc2Ij64vIr41lF7I21c0EjII2zVCS5cI20VAGYxC7MxkIecxEwVAFwVWUMxAIw2
 8IcxkI7VAKI48JMxC20s026xCaFVCjc4AY6r1j6r4UMI8I3I0E5I8CrVAFwI0_Jr0_Jr4l
 x2IqxVCjr7xvwVAFwI0_JrI_JrWlx4CE17CEb7AF67AKxVWUXVWUAwCIc40Y0x0EwIxGrw
 CI42IY6xIIjxv20xvE14v26r1I6r4UMIIF0xvE2Ix0cI8IcVCY1x0267AKxVW8JVWxJwCI
 42IY6xAIw20EY4v20xvaj40_Jr0_JF4lIxAIcVC2z280aVAFwI0_Jr0_Gr1lIxAIcVC2z2
 80aVCY1x0267AKxVW8JVW8JrUvcSsGvfC2KfnxnUUI43ZEXa7sREiL03UUUUU==
X-CM-SenderInfo: qsqrljqqwxllyrt6zt1loo2ulxwovvfxof0/1tbiAQAHBlepTBDfZQAdsF
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

regression test for
https://lore.kernel.org/linux-erofs/20210118123945.23676-1-sehuww@mail.scut.edu.cn/

Signed-off-by: Hu Weiwen <sehuww@mail.scut.edu.cn>
---
 tests/Makefile.am   |  4 ++++
 tests/erofs/015     | 55 +++++++++++++++++++++++++++++++++++++++++++++
 tests/erofs/015-out |  2 ++
 3 files changed, 61 insertions(+)
 create mode 100755 tests/erofs/015
 create mode 100644 tests/erofs/015-out

diff --git a/tests/Makefile.am b/tests/Makefile.am
index 3702f91..03f3ab3 100644
--- a/tests/Makefile.am
+++ b/tests/Makefile.am
@@ -82,6 +82,10 @@ TESTS_OUT += erofs/013-out
 TESTS += erofs/014
 TESTS_OUT += erofs/014-out
 
+# 015 - battach on full buffer block
+TESTS += erofs/015
+TESTS_OUT += erofs/015-out
+
 dist_check_SCRIPTS = common/rc $(TESTS)
 dist_check_DATA = $(TESTS_OUT)
 
diff --git a/tests/erofs/015 b/tests/erofs/015
new file mode 100755
index 0000000..f445ba1
--- /dev/null
+++ b/tests/erofs/015
@@ -0,0 +1,55 @@
+#!/bin/sh
+# SPDX-License-Identifier: GPL-2.0+
+seq=`basename $0`
+seqres=$RESULT_DIR/$seq
+
+# get standard environment, filters and checks
+. "${srcdir}/common/rc"
+
+cleanup()
+{
+	cd /
+	rm -rf $tmp.*
+}
+
+# remove previous $seqres.full before test
+rm -f $seqres.full
+
+# real QA test starts here
+echo "QA output created by $seq"
+
+if [ -z $SCRATCH_DEV ]; then
+	SCRATCH_DEV=$tmp/erofs_$seq.img
+	rm -f SCRATCH_DEV
+fi
+
+localdir="$tmp/$seq"
+rm -rf $localdir
+mkdir -p $localdir
+
+# collect files pending for verification
+head -c 4032 /dev/urandom > $localdir/1
+head -c 4095 /dev/urandom > $localdir/2
+head -c 12345 /dev/urandom > $localdir/3  # arbitrary size
+
+_scratch_mkfs -Eforce-inode-compact $localdir || _fail "failed to mkfs"
+
+# verify the uncompressed image
+_require_erofs
+
+_scratch_mount 2>>$seqres.full
+
+FSSUM_OPTS="-MAC"
+[ $FSTYP = "erofsfuse" ] && FSSUM_OPTS="${FSSUM_OPTS}T"
+
+sum1=`$FSSUM_PROG $FSSUM_OPTS $localdir`
+echo "$localdir checksum is $sum1" >>$seqres.full
+sum2=`$FSSUM_PROG $FSSUM_OPTS $SCRATCH_MNT`
+echo "$SCRATCH_MNT checksum is $sum2" >>$seqres.full
+
+[ "x$sum1" = "x$sum2" ] || _fail "-->checkMD5 FAILED"
+_scratch_unmount
+
+echo Silence is golden
+status=0
+exit 0
diff --git a/tests/erofs/015-out b/tests/erofs/015-out
new file mode 100644
index 0000000..fee0fcf
--- /dev/null
+++ b/tests/erofs/015-out
@@ -0,0 +1,2 @@
+QA output created by 015
+Silence is golden
-- 
2.30.0

