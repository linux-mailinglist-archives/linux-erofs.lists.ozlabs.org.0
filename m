Return-Path: <linux-erofs+bounces-3489-lists+linux-erofs=lfdr.de@lists.ozlabs.org>
Delivered-To: lists+linux-erofs@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id wBd7Jbk9GWpVtAgAu9opvQ
	(envelope-from <linux-erofs+bounces-3489-lists+linux-erofs=lfdr.de@lists.ozlabs.org>)
	for <lists+linux-erofs@lfdr.de>; Fri, 29 May 2026 09:18:17 +0200
X-Original-To: lists+linux-erofs@lfdr.de
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2404:9400:21b9:f100::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 7B6375FE68D
	for <lists+linux-erofs@lfdr.de>; Fri, 29 May 2026 09:18:15 +0200 (CEST)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4gRZT128B9z2xLs;
	Fri, 29 May 2026 17:18:13 +1000 (AEST)
X-Original-To: linux-erofs@lists.ozlabs.org
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip=113.46.200.221
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1780039093;
	cv=none; b=dsc7d6N5HS/kL0umPtFxxUgKSettDNGQ+wIRyr9iCU90oVXpepb2uTaa0wdOVFegHLQKzik4cVEN90GRZjjfT7+wW+8J4AsZ0wljw/y3BskVsLOKQEOBIP59F45zKP1pyPPx1VgGehPQDE9We7TcdCo4b4xaFqiV9UjtbH3YT0TEKTUasfBqNryWowo86AEO9ci7gBlNRXtEmkO/MsM3F8YW3sI+drkdXitIoaDhLWsvoOHJP3RAVKGcx2pU7TP0aTE7L45yq0DyXfeQ5fJ1brxAiViq/kh3y+oQlDwURIFznPdn77eF9SnPtqd4pwTh9x1J+yZWogCh1bNjLfo4Wg==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1780039093; c=relaxed/relaxed;
	bh=dRqHDQZ9TYwYFDhhiPpHt8LvhR14FSwbkdJNaAcdpDY=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=KdfPO6sesLr+2+lmMM5LMo7AkkOdBFQFNPN6o2BQjcDUVZy6AyQMZu+eKGs5w3UEwdRMT/64GkGiuFed8Khb6zeuTSmr5Hapcqn0Kl5sJ6imjBNrZDCLE6FEDMH/JMihWvDvFDLBA00zC4lz1SGBXcTmXqEhvMEWy+IqspBMeUfP2p/FHTXBSjogIRfAbdu6fC208MiNI/cPwi3H3FcQZNDZSYYLRcKO7Kkho7HyuvL00WmepJPvRXbxO41FukCvrwiKqMcxqrVj7wpluqF/nFOmmtI5LgVvJNonoLu+0FSsGS/3iZLWvVJe0zNiIXw+kBfij2ZyDTjX84J0WikF0Q==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; dkim=pass (1024-bit key; unprotected) header.d=huawei.com header.i=@huawei.com header.a=rsa-sha256 header.s=dkim header.b=ZmIbfZbV; dkim-atps=neutral; spf=pass (client-ip=113.46.200.221; helo=canpmsgout06.his.huawei.com; envelope-from=zhaoyifan28@huawei.com; receiver=lists.ozlabs.org) smtp.mailfrom=huawei.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (1024-bit key; unprotected) header.d=huawei.com header.i=@huawei.com header.a=rsa-sha256 header.s=dkim header.b=ZmIbfZbV;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=huawei.com (client-ip=113.46.200.221; helo=canpmsgout06.his.huawei.com; envelope-from=zhaoyifan28@huawei.com; receiver=lists.ozlabs.org)
Received: from canpmsgout06.his.huawei.com (canpmsgout06.his.huawei.com [113.46.200.221])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4gRZSy4vVgz2xC3
	for <linux-erofs@lists.ozlabs.org>; Fri, 29 May 2026 17:18:08 +1000 (AEST)
dkim-signature: v=1; a=rsa-sha256; d=huawei.com; s=dkim;
	c=relaxed/relaxed; q=dns/txt;
	h=From;
	bh=dRqHDQZ9TYwYFDhhiPpHt8LvhR14FSwbkdJNaAcdpDY=;
	b=ZmIbfZbVI3Z6WQ6Mf6/PhIIZ+RhrKQKpFzTsCHp5bM2WoMOTNrUU5hBvSA1QLdrxWBP9DPxeo
	Opk9SANZBFX8z9Cb14Pz3WjKymX7tuzspmGXzUyLuF7QU+yzCqZuiP8fuhhZsE4icNqaWicYq5J
	ekP6EjB8Uo9HOQ2svSfQLdo=
Received: from mail.maildlp.com (unknown [172.19.162.140])
	by canpmsgout06.his.huawei.com (SkyGuard) with ESMTPS id 4gRZHt0QzzzRhQV
	for <linux-erofs@lists.ozlabs.org>; Fri, 29 May 2026 15:10:18 +0800 (CST)
Received: from kwepemr100010.china.huawei.com (unknown [7.202.195.125])
	by mail.maildlp.com (Postfix) with ESMTPS id 83253201E9
	for <linux-erofs@lists.ozlabs.org>; Fri, 29 May 2026 15:18:04 +0800 (CST)
Received: from huawei.com (10.50.159.234) by kwepemr100010.china.huawei.com
 (7.202.195.125) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.36; Fri, 29 May
 2026 15:18:04 +0800
From: Yifan Zhao <zhaoyifan28@huawei.com>
To: <linux-erofs@lists.ozlabs.org>
CC: <guoxuenan@huawei.com>, <zhukeqian1@huawei.com>, <zhaoyifan28@huawei.com>
Subject: [PATCH] erofs-utils: build: link tools with liberofs dependencies
Date: Fri, 29 May 2026 15:17:02 +0800
Message-ID: <20260529071702.981596-1-zhaoyifan28@huawei.com>
X-Mailer: git-send-email 2.47.3
X-Mailing-List: linux-erofs@lists.ozlabs.org
List-Id: <linux-erofs.lists.ozlabs.org>
List-Help: <mailto:linux-erofs+help@lists.ozlabs.org>
List-Owner: <mailto:linux-erofs+owner@lists.ozlabs.org>
List-Post: <mailto:linux-erofs@lists.ozlabs.org>
List-Subscribe: <mailto:linux-erofs+subscribe@lists.ozlabs.org>,
  <mailto:linux-erofs+subscribe-digest@lists.ozlabs.org>,
  <mailto:linux-erofs+subscribe-nomail@lists.ozlabs.org>
List-Unsubscribe: <mailto:linux-erofs+unsubscribe@lists.ozlabs.org>
Precedence: list
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.50.159.234]
X-ClientProxiedBy: kwepems100001.china.huawei.com (7.221.188.238) To
 kwepemr100010.china.huawei.com (7.202.195.125)
X-Spam-Status: No, score=-0.2 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS autolearn=disabled
	version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-25) on lists.ozlabs.org
X-Spamd-Result: default: False [-0.70 / 15.00];
	ARC_ALLOW(-1.00)[lists.ozlabs.org:s=201707:i=1];
	MID_CONTAINS_FROM(1.00)[];
	DMARC_POLICY_ALLOW(-0.50)[huawei.com,quarantine];
	R_MISSING_CHARSET(0.50)[];
	R_DKIM_ALLOW(-0.20)[huawei.com:s=dkim];
	R_SPF_ALLOW(-0.20)[+ip6:2404:9400:21b9:f100::1:c];
	MAILLIST(-0.19)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-3489-lists,linux-erofs=lfdr.de];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	TO_DN_NONE(0.00)[];
	SUSPICIOUS_AUTH_ORIGIN(0.00)[];
	FROM_HAS_DN(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[zhaoyifan28@huawei.com,linux-erofs@lists.ozlabs.org];
	RCPT_COUNT_THREE(0.00)[4];
	RCVD_COUNT_FIVE(0.00)[5];
	HAS_XOIP(0.00)[];
	PREVIOUSLY_DELIVERED(0.00)[linux-erofs@lists.ozlabs.org];
	DKIM_TRACE(0.00)[huawei.com:+];
	NEURAL_HAM(-0.00)[-1.000];
	MIME_TRACE(0.00)[0:+];
	TAGGED_RCPT(0.00)[linux-erofs];
	ASN(0.00)[asn:133159, ipnet:2404:9400:2000::/36, country:AU];
	DBL_BLOCKED_OPENRESOLVER(0.00)[lists.ozlabs.org:rdns,lists.ozlabs.org:helo,huawei.com:email,huawei.com:mid,huawei.com:dkim,liberofsfuse.la:url]
X-Rspamd-Queue-Id: 7B6375FE68D
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

liberofs.la is a noinst libtool archive, so relying on its
dependency_libs to carry external libraries is not enough for
static-only dependencies.

For example, when liblzma is installed as a static libtool archive,
libtool consumes -llzma while creating liberofs.la but does not record it
in dependency_libs.  The final tools then link only with liberofs.la and
fail with undefined lzma_* references.

Collect liberofs external libraries in LIBEROFS_LIBS and use it for both
liberofs.la and the final tools, so final executable links see the
pkg-config supplied liblzma flags directly.

Reported-by: Guo Xuenan <guoxuenan@huawei.com>
Fixes: 6c2a000782b2 ("erofs-utils: lib: add test for s3erofs_prepare_url()")
Assisted-by: Codex:GPT-5.5
Signed-off-by: Yifan Zhao <zhaoyifan28@huawei.com>
---
To reproduce link error:

    ./autogen.sh
    PKG_CONFIG_PATH=/path/to/xz-static/lib/pkgconfig ./configure
    make -j

Then {mkfs,dump,fsck}.erofs reports missing lzma_* symbol as `-llzma`
missing in ld flags.

 configure.ac      | 17 +++++++++++++++++
 dump/Makefile.am  |  2 +-
 fsck/Makefile.am  |  4 ++--
 fuse/Makefile.am  |  5 +++--
 lib/Makefile.am   | 14 +++-----------
 mkfs/Makefile.am  |  2 +-
 mount/Makefile.am |  2 +-
 7 files changed, 28 insertions(+), 18 deletions(-)

diff --git a/configure.ac b/configure.ac
index f68bb74..17b4856 100644
--- a/configure.ac
+++ b/configure.ac
@@ -790,6 +790,23 @@ AM_CONDITIONAL([ENABLE_STATIC_FUSE], [test "x${enable_static_fuse}" = "xyes"])
 AM_CONDITIONAL([ENABLE_OCI], [test "x${have_oci}" = "xyes"])
 AM_CONDITIONAL([ENABLE_FANOTIFY], [test "x${have_fanotify}" = "xyes"])
 
+LIBEROFS_LIBS="${libselinux_LIBS} ${libuuid_LIBS} ${liblz4_LIBS} \
+${liblzma_LIBS} ${zlib_LIBS} ${libdeflate_LIBS} ${libzstd_LIBS} \
+${libqpl_LIBS} ${libcurl_LIBS} ${openssl_LIBS} ${json_c_LIBS}"
+AS_IF([test "x${have_xxhash}" = "xyes"], [
+  LIBEROFS_LIBS="${LIBEROFS_LIBS} ${libxxhash_LIBS}"
+])
+AS_IF([test "x${have_s3}" = "xyes"], [
+  LIBEROFS_LIBS="${LIBEROFS_LIBS} ${libxml2_LIBS}"
+])
+AS_IF([test "x${enable_multithreading}" != "xno"], [
+  LIBEROFS_LIBS="${LIBEROFS_LIBS} -lpthread"
+])
+AS_IF([test "x${build_linux}" = "xyes"], [
+  LIBEROFS_LIBS="${LIBEROFS_LIBS} ${libnl3_LIBS}"
+])
+AC_SUBST([LIBEROFS_LIBS])
+
 if test "x$have_uuid" = "xyes"; then
   AC_DEFINE([HAVE_LIBUUID], 1, [Define to 1 if libuuid is found])
 fi
diff --git a/dump/Makefile.am b/dump/Makefile.am
index 2611fd2..5d908b4 100644
--- a/dump/Makefile.am
+++ b/dump/Makefile.am
@@ -6,4 +6,4 @@ bin_PROGRAMS     = dump.erofs
 AM_CPPFLAGS = ${libuuid_CFLAGS}
 dump_erofs_SOURCES = main.c
 dump_erofs_CFLAGS = -Wall -I$(top_srcdir)/include
-dump_erofs_LDADD = $(top_builddir)/lib/liberofs.la
+dump_erofs_LDADD = $(top_builddir)/lib/liberofs.la $(LIBEROFS_LIBS)
diff --git a/fsck/Makefile.am b/fsck/Makefile.am
index 8eebadd..461eb88 100644
--- a/fsck/Makefile.am
+++ b/fsck/Makefile.am
@@ -6,12 +6,12 @@ bin_PROGRAMS     = fsck.erofs
 AM_CPPFLAGS = ${libuuid_CFLAGS}
 fsck_erofs_SOURCES = main.c
 fsck_erofs_CFLAGS = -Wall -I$(top_srcdir)/include
-fsck_erofs_LDADD = $(top_builddir)/lib/liberofs.la
+fsck_erofs_LDADD = $(top_builddir)/lib/liberofs.la $(LIBEROFS_LIBS)
 
 if ENABLE_FUZZING
 noinst_PROGRAMS   = fuzz_erofsfsck
 fuzz_erofsfsck_SOURCES = main.c
 fuzz_erofsfsck_CFLAGS = -Wall -I$(top_srcdir)/include -DFUZZING
 fuzz_erofsfsck_LDFLAGS = -fsanitize=address,fuzzer
-fuzz_erofsfsck_LDADD = $(top_builddir)/lib/liberofs.la
+fuzz_erofsfsck_LDADD = $(top_builddir)/lib/liberofs.la $(LIBEROFS_LIBS)
 endif
diff --git a/fuse/Makefile.am b/fuse/Makefile.am
index 9fe5608..b72e065 100644
--- a/fuse/Makefile.am
+++ b/fuse/Makefile.am
@@ -6,12 +6,13 @@ bin_PROGRAMS     = erofsfuse
 erofsfuse_SOURCES = main.c
 erofsfuse_CFLAGS = -Wall -I$(top_srcdir)/include
 erofsfuse_CFLAGS += ${libfuse2_CFLAGS} ${libfuse3_CFLAGS} ${libselinux_CFLAGS}
-erofsfuse_LDADD = $(top_builddir)/lib/liberofs.la ${libfuse2_LIBS} ${libfuse3_LIBS}
+erofsfuse_LDADD = $(top_builddir)/lib/liberofs.la $(LIBEROFS_LIBS) \
+	${libfuse2_LIBS} ${libfuse3_LIBS}
 
 if ENABLE_STATIC_FUSE
 lib_LTLIBRARIES = liberofsfuse.la
 liberofsfuse_la_SOURCES = main.c
 liberofsfuse_la_CFLAGS  = -Wall -I$(top_srcdir)/include
 liberofsfuse_la_CFLAGS += -Dmain=erofsfuse_main ${libfuse2_CFLAGS} ${libfuse3_CFLAGS} ${libselinux_CFLAGS}
-liberofsfuse_la_LIBADD  = $(top_builddir)/lib/liberofs.la
+liberofsfuse_la_LIBADD  = $(top_builddir)/lib/liberofs.la $(LIBEROFS_LIBS)
 endif
diff --git a/lib/Makefile.am b/lib/Makefile.am
index 27bf710..25ad79d 100644
--- a/lib/Makefile.am
+++ b/lib/Makefile.am
@@ -48,9 +48,7 @@ liberofs_la_SOURCES = config.c io.c cache.c super.c inode.c xattr.c exclude.c \
 		      vmdk.c metabox.c global.c importer.c base64.c
 
 liberofs_la_CFLAGS = -Wall ${libuuid_CFLAGS} -I$(top_srcdir)/include
-liberofs_la_LDFLAGS = ${libselinux_LIBS} ${libuuid_LIBS} ${liblz4_LIBS} \
-	${liblzma_LIBS} ${zlib_LIBS} ${libdeflate_LIBS} ${libzstd_LIBS} \
-	${libqpl_LIBS}
+liberofs_la_LIBADD = $(LIBEROFS_LIBS)
 if ENABLE_LZ4
 liberofs_la_CFLAGS += ${liblz4_CFLAGS}
 liberofs_la_SOURCES += compressor_lz4.c
@@ -74,23 +72,18 @@ liberofs_la_SOURCES += compressor_libzstd.c
 endif
 if ENABLE_XXHASH
 liberofs_la_CFLAGS += ${libxxhash_CFLAGS}
-liberofs_la_LDFLAGS += ${libxxhash_LIBS}
 else
 liberofs_la_SOURCES += xxhash.c
 endif
 liberofs_la_CFLAGS += ${libcurl_CFLAGS} ${openssl_CFLAGS} ${libxml2_CFLAGS}
-liberofs_la_LDFLAGS += ${libcurl_LIBS} ${openssl_LIBS}
 if ENABLE_S3
 liberofs_la_SOURCES += remotes/s3.c
-liberofs_la_LDFLAGS += ${libxml2_LIBS}
 endif
 if ENABLE_EROFS_MT
-liberofs_la_LDFLAGS += -lpthread
 liberofs_la_SOURCES += workqueue.c
 endif
 if OS_LINUX
 liberofs_la_CFLAGS += ${libnl3_CFLAGS}
-liberofs_la_LDFLAGS += ${libnl3_LIBS}
 liberofs_la_SOURCES += backends/nbd.c
 if ENABLE_FANOTIFY
 liberofs_la_SOURCES += backends/fanotify.c
@@ -98,19 +91,18 @@ endif
 endif
 liberofs_la_SOURCES += remotes/oci.c remotes/docker_config.c
 liberofs_la_CFLAGS += ${json_c_CFLAGS}
-liberofs_la_LDFLAGS += ${json_c_LIBS}
 liberofs_la_SOURCES += gzran.c
 
 if ENABLE_S3
 noinst_PROGRAMS = s3erofs_test
 s3erofs_test_SOURCES = remotes/s3.c
 s3erofs_test_CFLAGS = -Wall -I$(top_srcdir)/include ${libxml2_CFLAGS} ${openssl_CFLAGS} -DTEST
-s3erofs_test_LDADD = liberofs.la
+s3erofs_test_LDADD = liberofs.la $(LIBEROFS_LIBS)
 endif
 
 if ENABLE_OCI
 noinst_PROGRAMS = ocierofs_test
 ocierofs_test_SOURCES = remotes/oci.c
 ocierofs_test_CFLAGS = -Wall -I$(top_srcdir)/include ${json_c_CFLAGS} -DTEST
-ocierofs_test_LDADD = liberofs.la
+ocierofs_test_LDADD = liberofs.la $(LIBEROFS_LIBS)
 endif
diff --git a/mkfs/Makefile.am b/mkfs/Makefile.am
index 386455a..f511a09 100644
--- a/mkfs/Makefile.am
+++ b/mkfs/Makefile.am
@@ -5,4 +5,4 @@ bin_PROGRAMS     = mkfs.erofs
 AM_CPPFLAGS = ${libselinux_CFLAGS}
 mkfs_erofs_SOURCES = main.c
 mkfs_erofs_CFLAGS = -Wall -I$(top_srcdir)/include
-mkfs_erofs_LDADD = $(top_builddir)/lib/liberofs.la
+mkfs_erofs_LDADD = $(top_builddir)/lib/liberofs.la $(LIBEROFS_LIBS)
diff --git a/mount/Makefile.am b/mount/Makefile.am
index 637029d..189dbaf 100644
--- a/mount/Makefile.am
+++ b/mount/Makefile.am
@@ -7,5 +7,5 @@ sbin_PROGRAMS    = mount.erofs
 AM_CPPFLAGS = ${libuuid_CFLAGS}
 mount_erofs_SOURCES = main.c
 mount_erofs_CFLAGS = -Wall -I$(top_srcdir)/include
-mount_erofs_LDADD = $(top_builddir)/lib/liberofs.la
+mount_erofs_LDADD = $(top_builddir)/lib/liberofs.la $(LIBEROFS_LIBS)
 endif
-- 
2.47.3


