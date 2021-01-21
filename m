Return-Path: <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>
X-Original-To: lists+linux-erofs@lfdr.de
Delivered-To: lists+linux-erofs@lfdr.de
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2401:3900:2:1::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 9E1732FF09E
	for <lists+linux-erofs@lfdr.de>; Thu, 21 Jan 2021 17:40:22 +0100 (CET)
Received: from bilbo.ozlabs.org (lists.ozlabs.org [IPv6:2401:3900:2:1::3])
	by lists.ozlabs.org (Postfix) with ESMTP id 4DM7RR5yZBzDrS6
	for <lists+linux-erofs@lfdr.de>; Fri, 22 Jan 2021 03:40:19 +1100 (AEDT)
X-Original-To: linux-erofs@lists.ozlabs.org
Delivered-To: linux-erofs@lists.ozlabs.org
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized)
 smtp.mailfrom=mail.scut.edu.cn (client-ip=202.38.213.20; helo=mail.scut.edu.cn;
 envelope-from=sehuww@mail.scut.edu.cn; receiver=<UNKNOWN>)
Received: from mail.scut.edu.cn (stumail1.scut.edu.cn [202.38.213.20])
 by lists.ozlabs.org (Postfix) with ESMTP id 4DM7Qx2kCVzDqVk
 for <linux-erofs@lists.ozlabs.org>; Fri, 22 Jan 2021 03:39:52 +1100 (AEDT)
Received: from DESKTOP-N4CECTO.huww98.cn (unknown [59.53.40.31])
 by front (Coremail) with SMTP id AWSowADn7eFDrglgpLbbAQ--.1175S8;
 Fri, 22 Jan 2021 00:39:34 +0800 (CST)
From: Hu Weiwen <sehuww@mail.scut.edu.cn>
To: linux-erofs@lists.ozlabs.org
Subject: [PATCH 4/7] erofs-utils: tests: fix distcheck
Date: Fri, 22 Jan 2021 00:37:12 +0800
Message-Id: <20210121163715.10660-5-sehuww@mail.scut.edu.cn>
X-Mailer: git-send-email 2.30.0
In-Reply-To: <20210121163715.10660-1-sehuww@mail.scut.edu.cn>
References: <20210121163715.10660-1-sehuww@mail.scut.edu.cn>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID: AWSowADn7eFDrglgpLbbAQ--.1175S8
X-Coremail-Antispam: 1UD129KBjvJXoW3Gw18ZrW5Gr18CrW5ArWkJFb_yoW3tF4Upw
 n0kF1Fgr1xGFykAw1I9rnrua1DtrWIyr1UAw1UAr10vF1jqryUWr4xKrZrAFy3GrWkWwsF
 va92vryrGrn5uaUanT9S1TB71UUUUUUqnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
 9KBjDU0xBIdaVrnRJUUUBq14x267AKxVW5JVWrJwAFc2x0x2IEx4CE42xK8VAvwI8IcIk0
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
 80aVCY1x0267AKxVW8JVW8JrUvcSsGvfC2KfnxnUUI43ZEXa7sREX_-tUUUUU==
X-CM-SenderInfo: qsqrljqqwxllyrt6zt1loo2ulxwovvfxof0/1tbiAQAHBlepTBDfZQAbsD
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

To get required files to final .tar.gz distribution:
* Any header files should goes into _SOURCES.
* check scripts should goes into dist_check_SCRIPTS.
* 001.out will trigger a GNU make implicit rule, rename it to 001-out

Signed-off-by: Hu Weiwen <sehuww@mail.scut.edu.cn>
---
 lib/Makefile.am                  | 19 ++++++++++++++++++-
 tests/Makefile.am                | 22 ++++++++++++++++++++++
 tests/common/rc                  |  2 +-
 tests/erofs/{001.out => 001-out} |  0
 tests/erofs/{002.out => 002-out} |  0
 tests/erofs/{003.out => 003-out} |  0
 tests/erofs/{004.out => 004-out} |  0
 tests/erofs/{005.out => 005-out} |  0
 tests/erofs/{006.out => 006-out} |  0
 tests/erofs/007                  |  2 +-
 tests/erofs/{007.out => 007-out} |  0
 tests/erofs/{008.out => 008-out} |  0
 tests/erofs/{009.out => 009-out} |  0
 tests/erofs/{010.out => 010-out} |  0
 tests/erofs/{011.out => 011-out} |  0
 tests/erofs/{012.out => 012-out} |  0
 tests/erofs/{013.out => 013-out} |  0
 tests/erofs/{014.out => 014-out} |  0
 tests/src/Makefile.am            |  6 +++---
 19 files changed, 45 insertions(+), 6 deletions(-)
 rename tests/erofs/{001.out => 001-out} (100%)
 rename tests/erofs/{002.out => 002-out} (100%)
 rename tests/erofs/{003.out => 003-out} (100%)
 rename tests/erofs/{004.out => 004-out} (100%)
 rename tests/erofs/{005.out => 005-out} (100%)
 rename tests/erofs/{006.out => 006-out} (100%)
 rename tests/erofs/{007.out => 007-out} (100%)
 rename tests/erofs/{008.out => 008-out} (100%)
 rename tests/erofs/{009.out => 009-out} (100%)
 rename tests/erofs/{010.out => 010-out} (100%)
 rename tests/erofs/{011.out => 011-out} (100%)
 rename tests/erofs/{012.out => 012-out} (100%)
 rename tests/erofs/{013.out => 013-out} (100%)
 rename tests/erofs/{014.out => 014-out} (100%)

diff --git a/lib/Makefile.am b/lib/Makefile.am
index f21dc35..72c32da 100644
--- a/lib/Makefile.am
+++ b/lib/Makefile.am
@@ -3,7 +3,24 @@
 
 noinst_LTLIBRARIES = liberofs.la
 liberofs_la_SOURCES = config.c io.c cache.c super.c inode.c xattr.c exclude.c \
-		      namei.c data.c compress.c compressor.c zmap.c decompress.c
+		      namei.c data.c compress.c compressor.c zmap.c decompress.c \
+		      compressor.h \
+		      $(top_srcdir)/include/erofs_fs.h \
+		      $(top_srcdir)/include/erofs/cache.h \
+		      $(top_srcdir)/include/erofs/compress.h \
+		      $(top_srcdir)/include/erofs/config.h \
+		      $(top_srcdir)/include/erofs/decompress.h \
+		      $(top_srcdir)/include/erofs/defs.h \
+		      $(top_srcdir)/include/erofs/err.h \
+		      $(top_srcdir)/include/erofs/exclude.h \
+		      $(top_srcdir)/include/erofs/hashtable.h \
+		      $(top_srcdir)/include/erofs/inode.h \
+		      $(top_srcdir)/include/erofs/internal.h \
+		      $(top_srcdir)/include/erofs/io.h \
+		      $(top_srcdir)/include/erofs/list.h \
+		      $(top_srcdir)/include/erofs/print.h \
+		      $(top_srcdir)/include/erofs/trace.h \
+		      $(top_srcdir)/include/erofs/xattr.h
 liberofs_la_CFLAGS = -Wall -Werror -I$(top_srcdir)/include
 if ENABLE_LZ4
 liberofs_la_CFLAGS += ${LZ4_CFLAGS}
diff --git a/tests/Makefile.am b/tests/Makefile.am
index efc38fd..3702f91 100644
--- a/tests/Makefile.am
+++ b/tests/Makefile.am
@@ -5,6 +5,7 @@ AUTOMAKE_OPTIONS = serial-tests
 SUBDIRS = src
 
 TESTS =
+TESTS_OUT =
 
 TESTS_ENVIRONMENT = \
 	if [ -z $$SCRATCH_MNT ]; then \
@@ -27,43 +28,64 @@ endif
 
 # 001 - test if unknown algorithm is specificed
 TESTS += erofs/001
+TESTS_OUT += erofs/001-out
 
 # 002 - mkfs & test short symlink (fast symlink)
 TESTS += erofs/002
+TESTS_OUT += erofs/002-out
 
 # 003 - mkfs & test long symlink (non-fast symlink)
 TESTS += erofs/003
+TESTS_OUT += erofs/003-out
 
 # 004 - mkfs & test character/block device
 TESTS += erofs/004
+TESTS_OUT += erofs/004-out
 
 # 005 - mkfs & test pipe
 TESTS += erofs/005
+TESTS_OUT += erofs/005-out
 
 # 006 - verify the uncompressed image
 TESTS += erofs/006
+TESTS_OUT += erofs/006-out
 
 # 007 - check for bad lz4 versions
 TESTS += erofs/007
+TESTS_OUT += erofs/007-out
 
 # 008 - verify lz4 compressed image
 TESTS += erofs/008
+TESTS_OUT += erofs/008-out
 
 # 009 - verify lz4hc compressed image
 TESTS += erofs/009
+TESTS_OUT += erofs/009-out
 
 # 010 - (legacy image) verify lz4 compressed image
 TESTS += erofs/010
+TESTS_OUT += erofs/010-out
 
 # 011 - (legacy image) verify lz4hc compressed image
 TESTS += erofs/011
+TESTS_OUT += erofs/011-out
 
 # 012 - check the hard-link functionality
 TESTS += erofs/012
+TESTS_OUT += erofs/012-out
 
 # 013 - check if hardlinked directories are allowed
 TESTS += erofs/013
+TESTS_OUT += erofs/013-out
 
 # 014 - check if cross-device submounts are handled properly
 TESTS += erofs/014
+TESTS_OUT += erofs/014-out
 
+dist_check_SCRIPTS = common/rc $(TESTS)
+dist_check_DATA = $(TESTS_OUT)
+
+clean-local: clean-local-check
+.PHONY: clean-local-check
+clean-local-check:
+	-rm -rf results
diff --git a/tests/common/rc b/tests/common/rc
index a6b6014..edce3ff 100644
--- a/tests/common/rc
+++ b/tests/common/rc
@@ -199,7 +199,7 @@ _check_results()
 	[ -z $srcdir ] && return 0
 	[ -f $seqres.notrun ] && return 0
 
-	if ! diff `dirname $0`/$seq.out $tmp.out >/dev/null 2>&1 ; then
+	if ! diff `dirname $0`/$seq-out $tmp.out >/dev/null 2>&1 ; then
 		mv $tmp.out $seqres.out.bad
 		return 1
 	fi
diff --git a/tests/erofs/001.out b/tests/erofs/001-out
similarity index 100%
rename from tests/erofs/001.out
rename to tests/erofs/001-out
diff --git a/tests/erofs/002.out b/tests/erofs/002-out
similarity index 100%
rename from tests/erofs/002.out
rename to tests/erofs/002-out
diff --git a/tests/erofs/003.out b/tests/erofs/003-out
similarity index 100%
rename from tests/erofs/003.out
rename to tests/erofs/003-out
diff --git a/tests/erofs/004.out b/tests/erofs/004-out
similarity index 100%
rename from tests/erofs/004.out
rename to tests/erofs/004-out
diff --git a/tests/erofs/005.out b/tests/erofs/005-out
similarity index 100%
rename from tests/erofs/005.out
rename to tests/erofs/005-out
diff --git a/tests/erofs/006.out b/tests/erofs/006-out
similarity index 100%
rename from tests/erofs/006.out
rename to tests/erofs/006-out
diff --git a/tests/erofs/007 b/tests/erofs/007
index 80628cb..1e9a780 100755
--- a/tests/erofs/007
+++ b/tests/erofs/007
@@ -21,7 +21,7 @@ echo "QA output created by $seq"
 [ -z "$lz4_on" ] && \
 	_notrun "lz4 compression is disabled, skipped."
 
-$here/src/badlz4 >> $seqres.full 2>&1 || _fail "--> lz4 test FAILED"
+./src/badlz4 >> $seqres.full 2>&1 || _fail "--> lz4 test FAILED"
 
 echo Silence is golden
 status=0
diff --git a/tests/erofs/007.out b/tests/erofs/007-out
similarity index 100%
rename from tests/erofs/007.out
rename to tests/erofs/007-out
diff --git a/tests/erofs/008.out b/tests/erofs/008-out
similarity index 100%
rename from tests/erofs/008.out
rename to tests/erofs/008-out
diff --git a/tests/erofs/009.out b/tests/erofs/009-out
similarity index 100%
rename from tests/erofs/009.out
rename to tests/erofs/009-out
diff --git a/tests/erofs/010.out b/tests/erofs/010-out
similarity index 100%
rename from tests/erofs/010.out
rename to tests/erofs/010-out
diff --git a/tests/erofs/011.out b/tests/erofs/011-out
similarity index 100%
rename from tests/erofs/011.out
rename to tests/erofs/011-out
diff --git a/tests/erofs/012.out b/tests/erofs/012-out
similarity index 100%
rename from tests/erofs/012.out
rename to tests/erofs/012-out
diff --git a/tests/erofs/013.out b/tests/erofs/013-out
similarity index 100%
rename from tests/erofs/013.out
rename to tests/erofs/013-out
diff --git a/tests/erofs/014.out b/tests/erofs/014-out
similarity index 100%
rename from tests/erofs/014.out
rename to tests/erofs/014-out
diff --git a/tests/src/Makefile.am b/tests/src/Makefile.am
index ad272d6..537d6b7 100644
--- a/tests/src/Makefile.am
+++ b/tests/src/Makefile.am
@@ -2,12 +2,12 @@
 # Makefile.am
 
 AUTOMAKE_OPTIONS	= foreign
-noinst_PROGRAMS		= fssum
+check_PROGRAMS		= fssum
 
-fssum_SOURCES = md5.c fssum.c
+fssum_SOURCES = md5.c md5.h fssum.c
 
 if ENABLE_LZ4
-noinst_PROGRAMS += badlz4
+check_PROGRAMS += badlz4
 badlz4_SOURCES = badlz4.c
 badlz4_LDADD = ${liblz4_LIBS}
 endif
-- 
2.30.0

