Return-Path: <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>
X-Original-To: lists+linux-erofs@lfdr.de
Delivered-To: lists+linux-erofs@lfdr.de
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2404:9400:2:0:216:3eff:fee1:b9f1])
	by mail.lfdr.de (Postfix) with ESMTPS id 5607B8FCCF0
	for <lists+linux-erofs@lfdr.de>; Wed,  5 Jun 2024 14:32:57 +0200 (CEST)
Authentication-Results: lists.ozlabs.org;
	dkim=pass (1024-bit key; unprotected) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.a=rsa-sha256 header.s=default header.b=NrL7jYZC;
	dkim-atps=neutral
Received: from boromir.ozlabs.org (localhost [IPv6:::1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4VvRgp3DD0z3c2K
	for <lists+linux-erofs@lfdr.de>; Wed,  5 Jun 2024 22:32:54 +1000 (AEST)
X-Original-To: linux-erofs@lists.ozlabs.org
Delivered-To: linux-erofs@lists.ozlabs.org
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (1024-bit key; unprotected) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.a=rsa-sha256 header.s=default header.b=NrL7jYZC;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=linux.alibaba.com (client-ip=115.124.30.124; helo=out30-124.freemail.mail.aliyun.com; envelope-from=hsiangkao@linux.alibaba.com; receiver=lists.ozlabs.org)
Received: from out30-124.freemail.mail.aliyun.com (out30-124.freemail.mail.aliyun.com [115.124.30.124])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4VvRgg4734z30Vg
	for <linux-erofs@lists.ozlabs.org>; Wed,  5 Jun 2024 22:32:44 +1000 (AEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=linux.alibaba.com; s=default;
	t=1717590761; h=From:To:Subject:Date:Message-Id:MIME-Version;
	bh=apZomJ5MEvdPEryUk1Hpv5A8gN9to4PC5p4OMFDUWTE=;
	b=NrL7jYZCFBwxaeKrvdf7KQeuQmOLimHZBU8MxfyfnK5q1XltmiRytZaq+2tvPFJ5smmO6VW8bXpgeDV3/5X608CDP4Kq5njLMJjbXNLilBWnGai1SocCX9gKdOdacrDwVwExBiKYeOXE6eQN9JrVD659la/QPHVJ3hM6HzIdc54=
X-Alimail-AntiSpam: AC=PASS;BC=-1|-1;BR=01201311R171e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=maildocker-contentspam033037067111;MF=hsiangkao@linux.alibaba.com;NM=1;PH=DS;RN=3;SR=0;TI=SMTPD_---0W7v72lM_1717590754;
Received: from x31i01179.sqa.na131.tbsite.net(mailfrom:hsiangkao@linux.alibaba.com fp:SMTPD_---0W7v72lM_1717590754)
          by smtp.aliyun-inc.com;
          Wed, 05 Jun 2024 20:32:39 +0800
From: Gao Xiang <hsiangkao@linux.alibaba.com>
To: linux-erofs@lists.ozlabs.org
Subject: [PATCH v2 2/2] erofs-utils: support Intel Query Processing Library
Date: Wed,  5 Jun 2024 20:32:33 +0800
Message-Id: <20240605123233.3833332-1-hsiangkao@linux.alibaba.com>
X-Mailer: git-send-email 2.39.3
In-Reply-To: <20240605121448.3816160-2-hsiangkao@linux.alibaba.com>
References: <20240605121448.3816160-2-hsiangkao@linux.alibaba.com>
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
Cc: Gao Xiang <hsiangkao@linux.alibaba.com>, "Feghali, Wajdi K" <wajdi.k.feghali@intel.com>
Errors-To: linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org
Sender: "Linux-erofs" <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>

This adds the preliminary Intel QPL [1] support to enable built-in
In-Memory Analytics Accelerator [2] started from Sapphire Rapids.

It just leverages the synchronous APIs for the sake of simplicity
for now, thus performance for small compressed clusters can still
be improved in the future if needed anyway.

[ QPL 1.5.0+ is strictly needed for pkg-config detection and
  it can be explicitly enabled by `--with-qpl`. ]

Here are some performance numbers for reference:

Processors: Intel(R) Xeon(R) Platinum 8475B (192 cores)
Memory:     512 GiB

Single-threaded decompression:
 _____________________________________________________________
|                 |  cluster size  |  image size  |  time (s)  |
| LZ4             |     65536      |  391581696   |   0.364    |
| LZ4             |    1048576     |  373309440   |   0.376    |
| Intel QPL (IAA) |    1048576     |  374816768   |   0.386    |
| Intel QPL (IAA) |     65536      |  376057856   |   0.396    |
| Intel QPL (IAA) |      4096      |  399650816   |   0.675    |
| libdeflate (4k) |    1048576     |  374816768   |   1.862    |
| libdeflate (4k) |     65536      |  376057856   |   1.859    |
| libdeflate (4k) |      4096      |  399749120   |   2.203    |
| libdeflate      |    1048576     |  323457024   |   1.318    |
| libdeflate      |     65536      |  328712192   |   1.358    |
| libdeflate      |      4096      |  389943296   |   2.103    |
| Zstd            |      N/A       |  312548986   |   1.047    |
| Zstd (fast)     |      N/A       |  453096980   |   0.740    |
|_________________|________________|______________|____________|

LZ4 1.9.4: [ mkfs.erofs -zlz4hc,12 -C65536 ]
           [ mkfs.erofs -zlz4hc,12 -C1048576 ]
    time fsck/fsck.erofs --extract

QPL 1.5.0 (IAA) / libdeflate 1.20 (4k):
           [ mkfs.erofs -zdeflate,level=9,dictsize=4096 -C1048576 ]
           [ mkfs.erofs -zdeflate,level=9,dictsize=4096 -C65536 ]
           [ mkfs.erofs -zdeflate,level=9,dictsize=4096 -C4096 ]
    time fsck/fsck.erofs --extract

libdeflate 1.20:
           [ mkfs.erofs -zdeflate,level=9 -C1048576 ]
           [ mkfs.erofs -zdeflate,level=9 -C65536 ]
           [ mkfs.erofs -zdeflate,level=9 -C4096 ]
    time fsck/fsck.erofs --extract

Zstd 1.5.6: [ zstd -k ] [ zstd -k --fast ]
    time zstd -d -k -f -c --no-progress > /dev/null

[1] https://github.com/intel/qpl
[2] https://www.intel.com/content/www/us/en/products/docs/accelerator-engines/in-memory-analytics-accelerator.html
Cc: "Feghali, Wajdi K" <wajdi.k.feghali@intel.com>
Signed-off-by: Gao Xiang <hsiangkao@linux.alibaba.com>
---
changes since v1:
 - Fix a wrong image size number in commit message;
 - Minor configure.ac fix.

 configure.ac             |  37 +++++++++
 dump/Makefile.am         |   2 +-
 fsck/Makefile.am         |   4 +-
 fuse/Makefile.am         |   3 +-
 include/erofs/internal.h |   1 +
 lib/decompress.c         | 167 ++++++++++++++++++++++++++++++++++++++-
 mkfs/Makefile.am         |   2 +-
 7 files changed, 210 insertions(+), 6 deletions(-)

diff --git a/configure.ac b/configure.ac
index 1989bca..cfbde43 100644
--- a/configure.ac
+++ b/configure.ac
@@ -143,6 +143,11 @@ AC_ARG_WITH(libzstd,
    [AS_HELP_STRING([--with-libzstd],
       [Enable and build with of libzstd support @<:@default=auto@:>@])])
 
+AC_ARG_WITH(qpl,
+   [AS_HELP_STRING([--with-qpl],
+      [Enable and build with Intel QPL support @<:@default=disabled@:>@])], [],
+      [with_qpl="no"])
+
 AC_ARG_ENABLE(fuse,
    [AS_HELP_STRING([--enable-fuse], [enable erofsfuse @<:@default=no@:>@])],
    [enable_fuse="$enableval"], [enable_fuse="no"])
@@ -504,6 +509,31 @@ AS_IF([test "x$with_libzstd" != "xno"], [
   ])
 ])
 
+# Configure Intel QPL
+have_qpl="no"
+AS_IF([test "x$with_qpl" != "xno"], [
+  PKG_CHECK_MODULES([libqpl], [qpl >= 1.5.0], [
+    # Paranoia: don't trust the result reported by pkgconfig before trying out
+    saved_LIBS="$LIBS"
+    saved_CPPFLAGS=${CPPFLAGS}
+    CPPFLAGS="${libqpl_CFLAGS} ${CPPFLAGS}"
+    LIBS="${libqpl_LIBS} $LIBS"
+    AC_CHECK_HEADERS([qpl/qpl.h],[
+      AC_CHECK_LIB(qpl, qpl_execute_job, [], [
+        AC_MSG_ERROR([libqpl doesn't work properly])])
+      AC_CHECK_DECL(qpl_execute_job, [have_qpl="yes"],
+        [AC_MSG_ERROR([libqpl doesn't work properly])], [[
+#include <qpl/qpl.h>
+      ]])
+    ])
+    LIBS="${saved_LIBS}"
+    CPPFLAGS="${saved_CPPFLAGS}"], [
+    AS_IF([test "x$with_qpl" = "xyes"], [
+      AC_MSG_ERROR([Cannot find proper libqpl])
+    ])
+  ])
+])
+
 # Enable 64-bit off_t
 CFLAGS+=" -D_LARGEFILE_SOURCE -D_FILE_OFFSET_BITS=64"
 
@@ -525,6 +555,7 @@ AM_CONDITIONAL([ENABLE_FUSE], [test "x${have_fuse}" = "xyes"])
 AM_CONDITIONAL([ENABLE_LIBLZMA], [test "x${have_liblzma}" = "xyes"])
 AM_CONDITIONAL([ENABLE_LIBDEFLATE], [test "x${have_libdeflate}" = "xyes"])
 AM_CONDITIONAL([ENABLE_LIBZSTD], [test "x${have_libzstd}" = "xyes"])
+AM_CONDITIONAL([ENABLE_QPL], [test "x${have_qpl}" = "xyes"])
 
 if test "x$have_uuid" = "xyes"; then
   AC_DEFINE([HAVE_LIBUUID], 1, [Define to 1 if libuuid is found])
@@ -574,6 +605,12 @@ if test "x$have_libzstd" = "xyes"; then
   AC_DEFINE([HAVE_LIBZSTD], 1, [Define to 1 if libzstd is found])
 fi
 
+if test "x$have_qpl" = "xyes"; then
+  AC_DEFINE([HAVE_QPL], 1, [Define to 1 if qpl is found])
+  AC_SUBST([libqpl_LIBS])
+  AC_SUBST([libqpl_CFLAGS])
+fi
+
 # Dump maximum block size
 AS_IF([test "x$erofs_cv_max_block_size" = "x"],
       [$erofs_cv_max_block_size = 4096], [])
diff --git a/dump/Makefile.am b/dump/Makefile.am
index 09c483e..2a4f67a 100644
--- a/dump/Makefile.am
+++ b/dump/Makefile.am
@@ -8,4 +8,4 @@ dump_erofs_SOURCES = main.c
 dump_erofs_CFLAGS = -Wall -I$(top_srcdir)/include
 dump_erofs_LDADD = $(top_builddir)/lib/liberofs.la ${libselinux_LIBS} \
 	${liblz4_LIBS} ${liblzma_LIBS} ${zlib_LIBS} ${libdeflate_LIBS} \
-	${libzstd_LIBS}
+	${libzstd_LIBS} ${libqpl_LIBS}
diff --git a/fsck/Makefile.am b/fsck/Makefile.am
index 70eacc0..5bdee4d 100644
--- a/fsck/Makefile.am
+++ b/fsck/Makefile.am
@@ -8,7 +8,7 @@ fsck_erofs_SOURCES = main.c
 fsck_erofs_CFLAGS = -Wall -I$(top_srcdir)/include
 fsck_erofs_LDADD = $(top_builddir)/lib/liberofs.la ${libselinux_LIBS} \
 	${liblz4_LIBS} ${liblzma_LIBS} ${zlib_LIBS} ${libdeflate_LIBS} \
-	${libzstd_LIBS}
+	${libzstd_LIBS} ${libqpl_LIBS}
 
 if ENABLE_FUZZING
 noinst_PROGRAMS   = fuzz_erofsfsck
@@ -17,5 +17,5 @@ fuzz_erofsfsck_CFLAGS = -Wall -I$(top_srcdir)/include -DFUZZING
 fuzz_erofsfsck_LDFLAGS = -fsanitize=address,fuzzer
 fuzz_erofsfsck_LDADD = $(top_builddir)/lib/liberofs.la ${libselinux_LIBS} \
 	${liblz4_LIBS} ${liblzma_LIBS} ${zlib_LIBS} ${libdeflate_LIBS} \
-	${libzstd_LIBS}
+	${libzstd_LIBS} ${libqpl_LIBS}
 endif
diff --git a/fuse/Makefile.am b/fuse/Makefile.am
index 7eae5f6..2fd9b6d 100644
--- a/fuse/Makefile.am
+++ b/fuse/Makefile.am
@@ -7,4 +7,5 @@ erofsfuse_SOURCES = main.c
 erofsfuse_CFLAGS = -Wall -I$(top_srcdir)/include
 erofsfuse_CFLAGS += ${libfuse2_CFLAGS} ${libfuse3_CFLAGS} ${libselinux_CFLAGS}
 erofsfuse_LDADD = $(top_builddir)/lib/liberofs.la ${libfuse2_LIBS} ${libfuse3_LIBS} ${liblz4_LIBS} \
-	${libselinux_LIBS} ${liblzma_LIBS} ${zlib_LIBS} ${libdeflate_LIBS} ${libzstd_LIBS}
+	${libselinux_LIBS} ${liblzma_LIBS} ${zlib_LIBS} ${libdeflate_LIBS} ${libzstd_LIBS} \
+	${libqpl_LIBS}
diff --git a/include/erofs/internal.h b/include/erofs/internal.h
index d52bcc6..2067cb9 100644
--- a/include/erofs/internal.h
+++ b/include/erofs/internal.h
@@ -131,6 +131,7 @@ struct erofs_sb_info {
 	pthread_t dfops_worker;
 	struct erofs_mkfs_dfops *mkfs_dfops;
 #endif
+	bool useqpl;
 };
 
 /* make sure that any user of the erofs headers has atleast 64bit off_t type */
diff --git a/lib/decompress.c b/lib/decompress.c
index 2842f51..1e22f9f 100644
--- a/lib/decompress.c
+++ b/lib/decompress.c
@@ -77,6 +77,163 @@ out:
 }
 #endif
 
+#ifdef HAVE_QPL
+#include <qpl/qpl.h>
+
+struct z_erofs_qpl_job {
+	struct z_erofs_qpl_job *next;
+	u8 job[];
+};
+static struct z_erofs_qpl_job *z_erofs_qpl_jobs;
+static unsigned int z_erofs_qpl_reclaim_quot;
+#ifdef HAVE_PTHREAD_H
+static pthread_mutex_t z_erofs_qpl_mutex;
+#endif
+
+int z_erofs_load_deflate_config(struct erofs_sb_info *sbi,
+				struct erofs_super_block *dsb, void *data, int size)
+{
+	struct z_erofs_deflate_cfgs *dfl = data;
+	static erofs_atomic_bool_t inited;
+
+	if (!dfl || size < sizeof(struct z_erofs_deflate_cfgs)) {
+		erofs_err("invalid deflate cfgs, size=%u", size);
+		return -EINVAL;
+	}
+
+	/*
+	 * In Intel QPL, decompression is supported for DEFLATE streams where
+	 * the size of the history buffer is no more than 4 KiB, otherwise
+	 * QPL_STS_BAD_DIST_ERR code is returned.
+	 */
+	sbi->useqpl = (dfl->windowbits <= 12);
+	if (sbi->useqpl) {
+		if (!erofs_atomic_test_and_set(&inited))
+			z_erofs_qpl_reclaim_quot = erofs_get_available_processors();
+		erofs_info("Intel QPL will be used for DEFLATE decompression");
+	}
+	return 0;
+}
+
+static qpl_job *z_erofs_qpl_get_job(void)
+{
+	qpl_path_t execution_path = qpl_path_auto;
+	struct z_erofs_qpl_job *job;
+	int32_t jobsize = 0;
+	qpl_status status;
+
+#ifdef HAVE_PTHREAD_H
+	pthread_mutex_lock(&z_erofs_qpl_mutex);
+#endif
+	job = z_erofs_qpl_jobs;
+	if (job)
+		z_erofs_qpl_jobs = job->next;
+#ifdef HAVE_PTHREAD_H
+	pthread_mutex_unlock(&z_erofs_qpl_mutex);
+#endif
+
+	if (!job) {
+		status = qpl_get_job_size(execution_path, &jobsize);
+		if (status != QPL_STS_OK) {
+			erofs_err("failed to get job size: %d", status);
+			return ERR_PTR(-EOPNOTSUPP);
+		}
+
+		job = malloc(jobsize + sizeof(struct z_erofs_qpl_job));
+		if (!job)
+			return ERR_PTR(-ENOMEM);
+
+		status = qpl_init_job(execution_path, (qpl_job *)job->job);
+		if (status != QPL_STS_OK) {
+			erofs_err("failed to initialize job: %d", status);
+			return ERR_PTR(-EOPNOTSUPP);
+		}
+		erofs_atomic_dec_return(&z_erofs_qpl_reclaim_quot);
+	}
+	return (qpl_job *)job->job;
+}
+
+static bool z_erofs_qpl_put_job(qpl_job *qjob)
+{
+	struct z_erofs_qpl_job *job =
+		container_of((void *)qjob, struct z_erofs_qpl_job, job);
+
+	if (erofs_atomic_inc_return(&z_erofs_qpl_reclaim_quot) <= 0) {
+		qpl_status status = qpl_fini_job(qjob);
+
+		free(job);
+		if (status != QPL_STS_OK)
+			erofs_err("failed to finalize job: %d", status);
+		return status == QPL_STS_OK;
+	}
+#ifdef HAVE_PTHREAD_H
+	pthread_mutex_lock(&z_erofs_qpl_mutex);
+#endif
+	job->next = z_erofs_qpl_jobs;
+	z_erofs_qpl_jobs = job;
+#ifdef HAVE_PTHREAD_H
+	pthread_mutex_unlock(&z_erofs_qpl_mutex);
+#endif
+	return true;
+}
+
+static int z_erofs_decompress_qpl(struct z_erofs_decompress_req *rq)
+{
+	u8 *dest = (u8 *)rq->out;
+	u8 *src = (u8 *)rq->in;
+	u8 *buff = NULL;
+	unsigned int inputmargin;
+	qpl_status status;
+	qpl_job *job;
+	int ret;
+
+	job = z_erofs_qpl_get_job();
+	if (IS_ERR(job))
+		return PTR_ERR(job);
+
+	inputmargin = z_erofs_fixup_insize(src, rq->inputsize);
+	if (inputmargin >= rq->inputsize)
+		return -EFSCORRUPTED;
+
+	if (rq->decodedskip) {
+		buff = malloc(rq->decodedlength);
+		if (!buff)
+			return -ENOMEM;
+		dest = buff;
+	}
+
+	job->op            = qpl_op_decompress;
+	job->next_in_ptr   = src + inputmargin;
+	job->next_out_ptr  = dest;
+	job->available_in  = rq->inputsize - inputmargin;
+	job->available_out = rq->decodedlength;
+	job->flags         = QPL_FLAG_FIRST | QPL_FLAG_LAST;
+	status = qpl_execute_job(job);
+	if (status != QPL_STS_OK) {
+		erofs_err("failed to decompress: %d", status);
+		ret = -EIO;
+		goto out_inflate_end;
+	}
+
+	if (rq->decodedskip)
+		memcpy(rq->out, dest + rq->decodedskip,
+		       rq->decodedlength - rq->decodedskip);
+	ret = 0;
+out_inflate_end:
+	if (!z_erofs_qpl_put_job(job))
+		ret = -EFAULT;
+	if (buff)
+		free(buff);
+	return ret;
+}
+#else
+int z_erofs_load_deflate_config(struct erofs_sb_info *sbi,
+				struct erofs_super_block *dsb, void *data, int size)
+{
+	return 0;
+}
+#endif
+
 #ifdef HAVE_LIBDEFLATE
 /* if libdeflate is available, use libdeflate instead. */
 #include <libdeflate.h>
@@ -372,6 +529,11 @@ int z_erofs_decompress(struct z_erofs_decompress_req *rq)
 	if (rq->alg == Z_EROFS_COMPRESSION_LZMA)
 		return z_erofs_decompress_lzma(rq);
 #endif
+#ifdef HAVE_QPL
+	if (rq->alg == Z_EROFS_COMPRESSION_DEFLATE && rq->sbi->useqpl)
+		if (!z_erofs_decompress_qpl(rq))
+			return 0;
+#endif
 #if defined(HAVE_ZLIB) || defined(HAVE_LIBDEFLATE)
 	if (rq->alg == Z_EROFS_COMPRESSION_DEFLATE)
 		return z_erofs_decompress_deflate(rq);
@@ -416,7 +578,10 @@ int z_erofs_parse_cfgs(struct erofs_sb_info *sbi, struct erofs_super_block *dsb)
 			break;
 		}
 
-		ret = 0;
+		if (alg == Z_EROFS_COMPRESSION_DEFLATE)
+			ret = z_erofs_load_deflate_config(sbi, dsb, data, size);
+		else
+			ret = 0;
 		free(data);
 		if (ret)
 			break;
diff --git a/mkfs/Makefile.am b/mkfs/Makefile.am
index af97e39..6354712 100644
--- a/mkfs/Makefile.am
+++ b/mkfs/Makefile.am
@@ -7,4 +7,4 @@ mkfs_erofs_SOURCES = main.c
 mkfs_erofs_CFLAGS = -Wall -I$(top_srcdir)/include
 mkfs_erofs_LDADD = $(top_builddir)/lib/liberofs.la ${libselinux_LIBS} \
 	${libuuid_LIBS} ${liblz4_LIBS} ${liblzma_LIBS} ${zlib_LIBS} \
-	${libdeflate_LIBS} ${libzstd_LIBS}
+	${libdeflate_LIBS} ${libzstd_LIBS} ${libqpl_LIBS}
-- 
2.39.3

