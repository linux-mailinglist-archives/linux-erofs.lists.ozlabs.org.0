Return-Path: <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>
X-Original-To: lists+linux-erofs@lfdr.de
Delivered-To: lists+linux-erofs@lfdr.de
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2401:3900:2:1::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 02ED32A2EB6
	for <lists+linux-erofs@lfdr.de>; Mon,  2 Nov 2020 16:56:53 +0100 (CET)
Received: from bilbo.ozlabs.org (lists.ozlabs.org [IPv6:2401:3900:2:1::3])
	by lists.ozlabs.org (Postfix) with ESMTP id 4CPyGB0LZXzDqSh
	for <lists+linux-erofs@lfdr.de>; Tue,  3 Nov 2020 02:56:50 +1100 (AEDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=lists.ozlabs.org;
	s=201707; t=1604332610;
	bh=xxHW9Otz+MNlmbrUpUdbMjbRsUVuBn2fX7vlWh75JDc=;
	h=To:Subject:Date:In-Reply-To:References:List-Id:List-Unsubscribe:
	 List-Archive:List-Post:List-Help:List-Subscribe:From:Reply-To:Cc:
	 From;
	b=Fmuf++blGlW4yh6OUPjuaanSJLPoX/sza9mSY7qOTdU8YerrNnclTDLjpywMCLgvY
	 64b/zUCcqxNQ7enRHsLI6PNUQPJz1JnrQSZnRB/ANxwyWymRnxfQvWueMku5mXTws8
	 ED1Ir5VUI7JdY7gwNtdJaQarwGKlHTfiRnuL4zS20ENx9cPIJuuAkEoDVfZihoVKbs
	 /Q6LO6AQEcZYLWVgRJ2Ub9tzPaU1BAjWDpgCjJIcYqqtYl29ilK7J06Cm1CEAapXJs
	 tqWcLl17fwRh7/Vl3Xktoeqtt+xktYQvRM1qse+KX/rTV8qsGrFrkU9SGumWatQDK0
	 PLUda5iEutegA==
X-Original-To: linux-erofs@lists.ozlabs.org
Delivered-To: linux-erofs@lists.ozlabs.org
Authentication-Results: lists.ozlabs.org;
 spf=pass (sender SPF authorized) smtp.mailfrom=aol.com
 (client-ip=98.137.65.82; helo=sonic313-19.consmr.mail.gq1.yahoo.com;
 envelope-from=hsiangkao@aol.com; receiver=<UNKNOWN>)
Authentication-Results: lists.ozlabs.org;
 dmarc=pass (p=reject dis=none) header.from=aol.com
Authentication-Results: lists.ozlabs.org; dkim=pass (2048-bit key;
 unprotected) header.d=aol.com header.i=@aol.com header.a=rsa-sha256
 header.s=a2048 header.b=iMGUwLeo; dkim-atps=neutral
Received: from sonic313-19.consmr.mail.gq1.yahoo.com
 (sonic313-19.consmr.mail.gq1.yahoo.com [98.137.65.82])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 4CPyFw0ZsqzDqNH
 for <linux-erofs@lists.ozlabs.org>; Tue,  3 Nov 2020 02:56:35 +1100 (AEDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=aol.com; s=a2048;
 t=1604332592; bh=yv8YlIBYGBE0B0MtgRBskGCeqOwlCOOgop3GSC+xqng=;
 h=From:To:Cc:Subject:Date:In-Reply-To:References:From:Subject;
 b=iMGUwLeo5RV9/T7mmohEjJOgEzBn35GcLNLU7oX17c2FUabLs7xEkQCVUcSgvYPrsyL9IevseQlCfJfv1ZQ/NrW/UMAJCm4V04AI10EsNIc0+yZs5BEa8V8FoNJxWvzNdMxnGaa3H6Jmau4tFjds9beN9w3px/ONId/DnbvNMzUelhouacdSE5SGPRgdE0FmY6lZ5cWwHjtmmZZUPH7WjcpzkBIUyujts69Tso0vrDe6SI2YKY745Gf77s/5kK0h06/Fdn25e7LqyJ2EiPN5GkkphR3OsBF57D4ttCUWC3N9Pb5J5ep4kzsHRF6qQx2DIB6iKk55y1vXP6Yon09YkA==
X-SONIC-DKIM-SIGN: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yahoo.com; s=s2048;
 t=1604332592; bh=2C1J7edhXZ4lhLA+IyvLiPP8rlI/c/LhlQCWM+K58KC=;
 h=From:To:Subject:Date;
 b=rR3NmNAEt7Cp9TrG1HceQ1/nOmrqhNWJSIr7L6MypXwCgXXykHR/LvC6z+oZRpjITR9cds4R5ox0g9Q7MwoxZvPIg0mSs1szI0iJ6UVDKMrvbnxGxm7jheDUhGZLis0zxFRGwihmmmHYXXMW17y7yBJpVvd5Gf3Va6bO1/lmwFevoeyVUXH4e5bbVUrCwLIVGorvVhVWLYqH+6mJDKB51zfwDtEMro/6RH4DXmEpsMqh34joSpqIA7vcrl0jDAEgqmy+guJY6bC1m11kILtfLE1iExXECNGXKmdlNeDNWkQhLexcGnwymYnAmsC8D8CkSVD991/DwJtz+0nCrNi2xw==
X-YMail-OSG: N3gzuHIVM1myKLcQb7VIR6WxBTLTw6ZAvcR3dun.Ph6xrWDz.XkLdbie59haARf
 uavmlyotQDW_kQnZBVVV922eIvGOA0R2VqQd0WN1_t7G2nFOXnZZAd8g4r1d_wNNC5_sjYigmpYO
 koOkHqzBX_QNGhiRDLVHXevuztjrmcrL6rWtJ1SxTfKPmQ8unP2uGv1DZj69M6IxqWf0yb3ML9Ww
 3iyy3AXLYLeEfYYuGFJK8H7BCbxUE8tw6aT4c2zzGPNMhL6Gkfx02FDyRqyYEO9WdbZPe167hqV6
 6sW7a2t970sUS1yLqrYJ1hkzRPQ8Fi7DHFuUdDE4bHQcShlhDH8DgIaHLpYkFxGd6l7lKccZSdJN
 quCsnaJvHDOuqSRrqKutxJ_Nbzy8jGwZxiHl_KFN7Hbca5tdseGWgdFIqmxuqHJy40d3mj0xBFH1
 7R9pIFe3vNUzZGvC2dZ3vULWAXQsZ4tAPtjLuqHAn0n7NRYz.6sCp1bj9TCb2PDFYHapK54TW5NV
 zPkOsv7BnAZVV7knwvFbiO0StolXEROK.KfWF20XL6Yv9PJR2T8RxJgkmfdDV08_azLse6BtGlgl
 iPJZfyOhF3uA6JFbS.Vsqc0o4.v2IizT2AnUZgOjhZ6kJgV28xOG9ldw5X81oIBK.3MUBNASecPP
 F301f1858uQpf5zl.pSAYiYeFByFt.5z67LJKbP8GV5Wpor69sbPkppscWtZRgJj6N6uPzAJjTv7
 5NFLDJt5qNjmiHHtYL_RRYzD_NBB43BSD4kTOCmVQmJoqYCw9o_M3vKZhq9CASmXyejPcPAXuhCz
 qdAzPUo0w4Rw35IA98.QEkwHbnn1CMYmlNyKjMbqwnCbrv5tuJRzbxyQEDuRSYMcLIiAXrqHSqz1
 iepK0X5NgSyi3zgsQOb.qoX0h8n.sCKiO848B_OFg4aTTIl_BKPBVoA2EbE.ue7ZFgpfhpmlkOwR
 Vt2PzSxDuX4IHkVc1VjByepaWlMMapfvdzDg2a5byjSiY9Vwaw43usKvMM8DRcOBbzHICGHYP12W
 v4IEYOBZscvUX74ZytVFO8sLLRFl7B40OgtLMU_g36kGYZjnI1rlXqd.AlKmdN_hxwBrVlGuCAv9
 I03tCIdKt6nI19OyNDpSM2aN1Nlf6BIPNRTxBkbHLjyi9_4Gcj0O5cqR46I83nHxFuPHUUvxlu8A
 brI9nwzYmjtSNvBeXjgFFE_TiU2yn1CBjtFICDVuK4KZIvF5ZrDXmfxBbo8gbUzEDlBW8dZqrE9M
 O702F_ABsF7BCzoN2J9aDptErXpcvhIAlL3p2sS3yRf8fn4CbxJI_vliNf.3KbuM0GEqnwLisXpa
 Bw_gzHBEmIKenVwfy2l2Nv6B63I_AO7IcjUxPc.5mDczlwkB7HkdYfL6uYxrLjdA.cxnFCFMVm5I
 hnfuATzUlbJBdIfqQB7Y4ouVQky19ZEjQFX95GSTz0l7F.cmYE78X2vZkoLnSF5Cfq2FnXKPq1ep
 Muk1yXSrpl9I2OpFgrgreLShpCmc_0p3lM4a8Xquuzxy4Pq7jZg4ZPAO9p0ABJycM9XHAzMG_7u.
 60V4K8JjKmiSOve2l7BwmaH93eWGe25KGGzn2QvhaM8AFeg7sGWs.LlMPyWhUBdJRaI0vkJGLfKE
 0R1YYTvXk.ZRJJAPKO7s8zKSY4iiwEMjo1pGPL17If88Wnlje9WQMdoMLn2SAzu.IrcFvvtAgiVe
 tMgLnaSwJT2l315OrIgaBpnfS6TbHU0YJIekc0dW0FBSZYf4ZFvl4r3giVdAH4NUkIlPZT3HMKMv
 a122.nzE76q2yNtZ2OHZvz.S1CsMg_ILfPY9PC2Eti0gRpgT143JjA9TiWFEWSEuDxwMwHgfxXcl
 R5u4t3Rx0l43wb40d9fQ6hIwr8Jegz5qntim2BLJGridRiI3UHZd_z90ql9qZZBl6x3O4W7vTCLD
 Woec.QSWHB0rG5dQb4VpJiGjuEeW.b_3Lebrl0u3XgMfzW5ADba8WuxkFg37Yz9fLYUqBXSgdudY
 BZsMRic.nWEJFpZnO0QIYef9xj2yf2dT5XpTRbaL2zCXvdMIO6BO74nLpNx8E_3ljg0fQKKtN2Nk
 OymSlQm5meOWSWzuy6jCVbf7SqmkZtsesxbNV5J2ijsaGwThraX2kb2wl1SDdkjJbfCJ_LpDAqom
 46wtcBgyVkJ4XV7pqkaPwh4wwB2nWfnyE7BWtl6fpBN5hdQ2irOIWaSSFfXMdwHrYR9cATvwrmPI
 rDKe9uey8zo1nhb2g96JFe0OE2j.N54tTIxg3ARp.MDXuq76yKu.fHrO0rgJnkB67S.DujBSiV9a
 B3OlG2eXDR0roqEOojvIG2fE0DwThmG5jqBj1_U1sSDKC3ERSUzKBIJys4Dw2HUG4C45lQuDhrJz
 f80RwVJMoWPbkc9GGTp4EY293QVGUnLJ8HcZ6UUDmNyzBd8UYTTeRL_2953b6lBnSY6ezehZE3y8
 R44yWmeNM4n8CIqPi8HULiY0mil0qVFAPNfwmn5nGrAF9VOUCdAb9ONUkXbYRFKgLFkG9O0vfRob
 B1GvJHIfeLWEjegdVqfe7TO87y7JfwHyWVN7L9DV5TfmlBagiEu4Agd_qbSGN_AFQhBp8Nt.3v5h
 pqvcLPGlTH3pzY_fQBLRJF_XGa26KFJ2cjhyU13gOOd81vvFs4o1AwVbjInkMm0lrMj6zqAP0dEB
 8Odw3QG4VK1VRb4kPeTmvgQ4W.yrNxgwKOVfLMc2wckp7b2QuS3mgRt.9lAyXdnK9NU7MMHV9pco
 Al3it0haPmtRvjx5u4FYnqU.KJXANFNcPNB37GrkOpg3YuPTFietTvqne8SRlMRiuBOJqbFGPQI7
 0g.5N3gslThaTjoXturo2uu3LIq94GoGGiwL2HjbzRpwVlEEBmsAPn7YuPz27FM.cSQ--
Received: from sonic.gate.mail.ne1.yahoo.com by
 sonic313.consmr.mail.gq1.yahoo.com with HTTP; Mon, 2 Nov 2020 15:56:32 +0000
Received: by smtp404.mail.ir2.yahoo.com (VZM Hermes SMTP Server) with ESMTPA
 ID 0de93bd81f6e7581799539af1246db07; 
 Mon, 02 Nov 2020 15:56:24 +0000 (UTC)
To: linux-erofs@lists.ozlabs.org
Subject: [WIP] [PATCH v3 01/12] erofs-utils: introduce fuse implementation
Date: Mon,  2 Nov 2020 23:55:47 +0800
Message-Id: <20201102155558.1995-2-hsiangkao@aol.com>
X-Mailer: git-send-email 2.24.0
In-Reply-To: <20201102155558.1995-1-hsiangkao@aol.com>
References: <20201102155558.1995-1-hsiangkao@aol.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
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
From: Gao Xiang via Linux-erofs <linux-erofs@lists.ozlabs.org>
Reply-To: Gao Xiang <hsiangkao@aol.com>
Cc: Guo Weichao <guoweichao@oppo.com>
Errors-To: linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org
Sender: "Linux-erofs"
 <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>

From: Li Guifu <blucerlee@gmail.com>

Let's add erofsfuse approach, and benefits are:

 - images can be supported on various platforms;
 - new unpack tool can be developed based on this;
 - new on-disk features can be iterated, verified effectively.

This commit only aims at reading a regular file.
Other file (e.g. compressed file) support is out of scope for now.

Signed-off-by: Li Guifu <blucerlee@gmail.com>
Signed-off-by: Huang Jianan <huangjianan@oppo.com>
Signed-off-by: Guo Weichao <guoweichao@oppo.com>
Signed-off-by: Gao Xiang <hsiangkao@aol.com>
---
 Makefile.am              |   2 +-
 README                   |  28 ++++-
 configure.ac             |   3 +-
 fuse/Makefile.am         |  14 +++
 fuse/dentry.c            | 130 ++++++++++++++++++++++
 fuse/dentry.h            |  42 ++++++++
 fuse/getattr.c           |  64 +++++++++++
 fuse/getattr.h           |  15 +++
 fuse/init.c              |  97 +++++++++++++++++
 fuse/init.h              |  22 ++++
 fuse/main.c              | 166 ++++++++++++++++++++++++++++
 fuse/namei.c             | 228 +++++++++++++++++++++++++++++++++++++++
 fuse/namei.h             |  22 ++++
 fuse/open.c              |  22 ++++
 fuse/open.h              |  15 +++
 fuse/read.c              | 113 +++++++++++++++++++
 fuse/read.h              |  16 +++
 fuse/readir.c            | 122 +++++++++++++++++++++
 fuse/readir.h            |  17 +++
 include/erofs/defs.h     |   3 +
 include/erofs/internal.h |  37 +++++++
 include/erofs/io.h       |   1 +
 lib/io.c                 |  16 +++
 23 files changed, 1192 insertions(+), 3 deletions(-)
 create mode 100644 fuse/Makefile.am
 create mode 100644 fuse/dentry.c
 create mode 100644 fuse/dentry.h
 create mode 100644 fuse/getattr.c
 create mode 100644 fuse/getattr.h
 create mode 100644 fuse/init.c
 create mode 100644 fuse/init.h
 create mode 100644 fuse/main.c
 create mode 100644 fuse/namei.c
 create mode 100644 fuse/namei.h
 create mode 100644 fuse/open.c
 create mode 100644 fuse/open.h
 create mode 100644 fuse/read.c
 create mode 100644 fuse/read.h
 create mode 100644 fuse/readir.c
 create mode 100644 fuse/readir.h

diff --git a/Makefile.am b/Makefile.am
index 1d20577068c5..24f4a7b3d5ad 100644
--- a/Makefile.am
+++ b/Makefile.am
@@ -3,4 +3,4 @@
 
 ACLOCAL_AMFLAGS = -I m4
 
-SUBDIRS = man lib mkfs
+SUBDIRS = man lib mkfs fuse
diff --git a/README b/README
index 5addd6b80e04..870858c48b7d 100644
--- a/README
+++ b/README
@@ -2,7 +2,8 @@ erofs-utils
 ===========
 
 erofs-utils includes user-space tools for erofs filesystem images.
-Currently only mkfs.erofs is available.
+One is mkfs.erofs to create a image, the other is erofsfuse which
+is used to mount a image on a directory
 
 mkfs.erofs
 ----------
@@ -95,6 +96,31 @@ It may still be useful since new erofs-utils has not been widely used in
 commercial products. However, if that happens, please report bug to us
 as well.
 
+erofs-utils: erofsfuse
+----------------------
+erofsfuse mount a erofs filesystem image created by mkfs.erofs to a directory, and then
+It can be listed, read files and so on.
+
+Dependencies
+~~~~~~~~~~~~
+FUSE library version: 2.9.7
+fusermount version: 2.9.7
+using FUSE kernel interface version 7.19
+
+How to installed fuse
+~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
+sudo apt-get update
+sudo apt-get install -y fuse libfuse-dev
+
+How to build erofsfuse
+~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
+
+	$ ./autogen.sh
+	$ ./configure
+	$ make
+
+erofsfuse binary will be generated under fuse folder.
+
 Contribution
 ------------
 
diff --git a/configure.ac b/configure.ac
index 0f40a840cf4f..4194a77f1e36 100644
--- a/configure.ac
+++ b/configure.ac
@@ -245,6 +245,7 @@ fi
 AC_CONFIG_FILES([Makefile
 		 man/Makefile
 		 lib/Makefile
-		 mkfs/Makefile])
+		 mkfs/Makefile
+		 fuse/Makefile])
 AC_OUTPUT
 
diff --git a/fuse/Makefile.am b/fuse/Makefile.am
new file mode 100644
index 000000000000..4921a4363cbb
--- /dev/null
+++ b/fuse/Makefile.am
@@ -0,0 +1,14 @@
+# SPDX-License-Identifier: GPL-2.0+
+# Makefile.am
+
+AUTOMAKE_OPTIONS = foreign
+bin_PROGRAMS     = erofsfuse
+erofsfuse_SOURCES = main.c dentry.c getattr.c namei.c read.c init.c open.c readir.c
+erofsfuse_CFLAGS = -Wall -Werror \
+                   -I$(top_srcdir)/include \
+                   $(shell pkg-config fuse --cflags) \
+                   -DFUSE_USE_VERSION=26 \
+                   -std=gnu99
+LDFLAGS += $(shell pkg-config fuse --libs)
+erofsfuse_LDADD = $(top_builddir)/lib/liberofs.la -ldl
+
diff --git a/fuse/dentry.c b/fuse/dentry.c
new file mode 100644
index 000000000000..0f722294d530
--- /dev/null
+++ b/fuse/dentry.c
@@ -0,0 +1,130 @@
+// SPDX-License-Identifier: GPL-2.0+
+/*
+ * erofs-utils/fuse/dentry.c
+ *
+ * Created by Li Guifu <blucerlee@gmail.com>
+ */
+#include <stdlib.h>
+#include "dentry.h"
+#include "erofs/internal.h"
+#include "erofs/print.h"
+
+#define DCACHE_ENTRY_CALLOC()   calloc(1, sizeof(struct dcache_entry))
+#define DCACHE_ENTRY_LIFE       8
+
+struct dcache_entry root_entry;
+
+int dcache_init_root(uint32_t nid)
+{
+	if (root_entry.nid)
+		return -1;
+
+	/* Root entry doesn't need most of the fields. Namely, it only uses the
+	 * nid field and the subdirs pointer.
+	 */
+	erofs_info("Initializing root_entry dcache entry");
+	root_entry.nid = nid;
+	root_entry.subdirs = NULL;
+	root_entry.siblings = NULL;
+
+	return 0;
+}
+
+/* Inserts a node as a subdirs of a given parent. The parent is updated to
+ * point the newly inserted subdirs as the first subdirs. We return the new
+ * entry so that further entries can be inserted.
+ *
+ *      [0]                  [0]
+ *       /        ==>          \
+ *      /         ==>           \
+ * .->[1]->[2]-.       .->[1]->[3]->[2]-.
+ * `-----------麓       `----------------麓
+ */
+struct dcache_entry *dcache_insert(struct dcache_entry *parent,
+				   const char *name, int namelen, uint32_t nid)
+{
+	struct dcache_entry *new_entry;
+
+	erofs_dbg("Inserting %s,%d to dcache", name, namelen);
+
+	/* TODO: Deal with names that exceed the allocated size */
+	if (namelen + 1 > DCACHE_ENTRY_NAME_LEN)
+		return NULL;
+
+	if (parent == NULL)
+		parent = &root_entry;
+
+	new_entry = DCACHE_ENTRY_CALLOC();
+	if (!new_entry)
+		return NULL;
+
+	strncpy(new_entry->name, name, namelen);
+	new_entry->name[namelen] = 0;
+	new_entry->nid = nid;
+
+	if (!parent->subdirs) {
+		new_entry->siblings = new_entry;
+		parent->subdirs = new_entry;
+	} else {
+		new_entry->siblings = parent->subdirs->siblings;
+		parent->subdirs->siblings = new_entry;
+		parent->subdirs = new_entry;
+	}
+
+	return new_entry;
+}
+
+/* Lookup a cache entry for a given file name.  Return value is a struct pointer
+ * that can be used to both obtain the nid number and insert further child
+ * entries.
+ * TODO: Prune entries by using the LRU counter
+ */
+struct dcache_entry *dcache_lookup(struct dcache_entry *parent,
+				   const char *name, int namelen)
+{
+	struct dcache_entry *iter;
+
+	if (parent == NULL)
+		parent = &root_entry;
+
+	if (!parent->subdirs)
+		return NULL;
+
+	/* Iterate the list of siblings to see if there is any match */
+	iter = parent->subdirs;
+
+	do {
+		if (strncmp(iter->name, name, namelen) == 0 &&
+		    iter->name[namelen] == 0) {
+			parent->subdirs = iter;
+
+			return iter;
+		}
+
+		iter = iter->siblings;
+	} while (iter != parent->subdirs);
+
+	return NULL;
+}
+
+struct dcache_entry *dcache_try_insert(struct dcache_entry *parent,
+				   const char *name, int namelen, uint32_t nid)
+{
+	struct dcache_entry *d = dcache_lookup(parent, name, namelen);
+
+	if (d)
+		return d;
+
+	return dcache_insert(parent, name, namelen, nid);
+
+}
+erofs_nid_t dcache_get_nid(struct dcache_entry *entry)
+{
+	return entry ? entry->nid : root_entry.nid;
+}
+
+struct dcache_entry *dcache_root(void)
+{
+	return &root_entry;
+}
+
diff --git a/fuse/dentry.h b/fuse/dentry.h
new file mode 100644
index 000000000000..cb4d87972b2d
--- /dev/null
+++ b/fuse/dentry.h
@@ -0,0 +1,42 @@
+/* SPDX-License-Identifier: GPL-2.0+ */
+/*
+ * erofs-utils/fuse/dentry.h
+ *
+ * Created by Li Guifu <blucerlee@gmail.com>
+ */
+#ifndef _EROFS_DENTRY_H
+#define _EROFS_DENTRY_H
+
+#include <stdint.h>
+#include "erofs/internal.h"
+
+#ifdef __64BITS
+#define DCACHE_ENTRY_NAME_LEN       40
+#else
+#define DCACHE_ENTRY_NAME_LEN       48
+#endif
+
+/* This struct declares a node of a k-tree.  Every node has a pointer to one of
+ * the subdirs and a pointer (in a circular list fashion) to its siblings.
+ */
+
+struct dcache_entry {
+	struct dcache_entry *subdirs;
+	struct dcache_entry *siblings;
+	uint32_t nid;
+	uint16_t lru_count;
+	uint8_t user_count;
+	char name[DCACHE_ENTRY_NAME_LEN];
+};
+
+struct dcache_entry *dcache_insert(struct dcache_entry *parent,
+				   const char *name, int namelen, uint32_t n);
+struct dcache_entry *dcache_lookup(struct dcache_entry *parent,
+				   const char *name, int namelen);
+struct dcache_entry *dcache_try_insert(struct dcache_entry *parent,
+				       const char *name, int namelen,
+				       uint32_t nid);
+
+erofs_nid_t dcache_get_nid(struct dcache_entry *entry);
+int dcache_init_root(uint32_t n);
+#endif
diff --git a/fuse/getattr.c b/fuse/getattr.c
new file mode 100644
index 000000000000..8426145a9231
--- /dev/null
+++ b/fuse/getattr.c
@@ -0,0 +1,64 @@
+// SPDX-License-Identifier: GPL-2.0+
+/*
+ * erofs-utils/fuse/getattr.c
+ *
+ * Created by Li Guifu <blucerlee@gmail.com>
+ */
+#include "getattr.h"
+
+#include <sys/types.h>
+#include <sys/stat.h>
+#include <unistd.h>
+#include <errno.h>
+
+#include "erofs/defs.h"
+#include "erofs/internal.h"
+#include "erofs_fs.h"
+#include "erofs/print.h"
+
+#include "namei.h"
+
+extern struct erofs_super_block super;
+
+/* GNU's definitions of the attributes
+ * (http://www.gnu.org/software/libc/manual/html_node/Attribute-Meanings.html):
+ * st_uid: The user ID of the file鈥檚 owner.
+ * st_gid: The group ID of the file.
+ * st_atime: This is the last access time for the file.
+ * st_mtime: This is the time of the last modification to the contents of the
+ *           file.
+ * st_mode: Specifies the mode of the file. This includes file type information
+ *          (see Testing File Type) and the file permission bits (see Permission
+ *          Bits).
+ * st_nlink: The number of hard links to the file.This count keeps track of how
+ *           many directories have entries for this file. If the count is ever
+ *           decremented to zero, then the file itself is discarded as soon as
+ *           no process still holds it open. Symbolic links are not counted in
+ *           the total.
+ * st_size: This specifies the size of a regular file in bytes. For files that
+ *         are really devices this field isn鈥檛 usually meaningful.For symbolic
+ *         links this specifies the length of the file name the link refers to.
+ */
+int erofs_getattr(const char *path, struct stat *stbuf)
+{
+	struct erofs_vnode v;
+	int ret;
+
+	erofs_dbg("getattr(%s)", path);
+	memset(&v, 0, sizeof(v));
+	ret = erofs_iget_by_path(path, &v);
+	if (ret)
+		return -ENOENT;
+
+	stbuf->st_mode  = le16_to_cpu(v.i_mode);
+	stbuf->st_nlink = le16_to_cpu(v.i_nlink);
+	stbuf->st_size  = le32_to_cpu(v.i_size);
+	stbuf->st_blocks = stbuf->st_size / EROFS_BLKSIZ;
+	stbuf->st_uid = le16_to_cpu(v.i_uid);
+	stbuf->st_gid = le16_to_cpu(v.i_gid);
+	stbuf->st_atime = super.build_time;
+	stbuf->st_mtime = super.build_time;
+	stbuf->st_ctime = super.build_time;
+
+	return 0;
+}
diff --git a/fuse/getattr.h b/fuse/getattr.h
new file mode 100644
index 000000000000..735529a91d5b
--- /dev/null
+++ b/fuse/getattr.h
@@ -0,0 +1,15 @@
+/* SPDX-License-Identifier: GPL-2.0+ */
+/*
+ * erofs-utils/fuse/getattr.h
+ *
+ * Created by Li Guifu <blucerlee@gmail.com>
+ */
+#ifndef __EROFS_GETATTR_H
+#define __EROFS_GETATTR_H
+
+#include <fuse.h>
+#include <fuse_opt.h>
+
+int erofs_getattr(const char *path, struct stat *st);
+
+#endif
diff --git a/fuse/init.c b/fuse/init.c
new file mode 100644
index 000000000000..802771fc69a4
--- /dev/null
+++ b/fuse/init.c
@@ -0,0 +1,97 @@
+// SPDX-License-Identifier: GPL-2.0+
+/*
+ * erofs-utils/fuse/init.c
+ *
+ * Created by Li Guifu <blucerlee@gmail.com>
+ */
+#include "init.h"
+#include <string.h>
+#include <stdlib.h>
+#include <asm-generic/errno-base.h>
+
+#include "namei.h"
+#include "erofs/io.h"
+#include "erofs/print.h"
+
+#define STR(_X) (#_X)
+#define SUPER_MEM(_X) (super._X)
+
+
+struct erofs_super_block super;
+static struct erofs_super_block *sbk = &super;
+
+int erofs_init_super(void)
+{
+	int ret;
+	char buf[EROFS_BLKSIZ];
+	struct erofs_super_block *sb;
+
+	memset(buf, 0, sizeof(buf));
+	ret = blk_read(buf, 0, 1);
+	if (ret < 0) {
+		erofs_err("Failed to read super block ret=%d", ret);
+		return -EINVAL;
+	}
+
+	sb = (struct erofs_super_block *) (buf + BOOT_SECTOR_SIZE);
+	sbk->magic = le32_to_cpu(sb->magic);
+	if (sbk->magic != EROFS_SUPER_MAGIC_V1) {
+		erofs_err("EROFS magic[0x%X] NOT matched to [0x%X] ",
+			  super.magic, EROFS_SUPER_MAGIC_V1);
+		return -EINVAL;
+	}
+
+	sbk->checksum = le32_to_cpu(sb->checksum);
+	sbk->feature_compat = le32_to_cpu(sb->feature_compat);
+	sbk->blkszbits = sb->blkszbits;
+
+	sbk->inos = le64_to_cpu(sb->inos);
+	sbk->build_time = le64_to_cpu(sb->build_time);
+	sbk->build_time_nsec = le32_to_cpu(sb->build_time_nsec);
+	sbk->blocks = le32_to_cpu(sb->blocks);
+	sbk->meta_blkaddr = le32_to_cpu(sb->meta_blkaddr);
+	sbk->xattr_blkaddr = le32_to_cpu(sb->xattr_blkaddr);
+	memcpy(sbk->uuid, sb->uuid, 16);
+	memcpy(sbk->volume_name, sb->volume_name, 16);
+	sbk->root_nid = le16_to_cpu(sb->root_nid);
+
+	erofs_dump("%-15s:0x%X\n", STR(magic), SUPER_MEM(magic));
+	erofs_dump("%-15s:0x%X\n", STR(feature_compat), SUPER_MEM(feature_compat));
+	erofs_dump("%-15s:%u\n",   STR(blkszbits), SUPER_MEM(blkszbits));
+	erofs_dump("%-15s:%u\n",   STR(root_nid), SUPER_MEM(root_nid));
+	erofs_dump("%-15s:%llu\n",  STR(inos), (unsigned long long)SUPER_MEM(inos));
+	erofs_dump("%-15s:%d\n",   STR(meta_blkaddr), SUPER_MEM(meta_blkaddr));
+	erofs_dump("%-15s:%d\n",   STR(xattr_blkaddr), SUPER_MEM(xattr_blkaddr));
+	return 0;
+}
+
+erofs_nid_t erofs_get_root_nid(void)
+{
+	return sbk->root_nid;
+}
+
+erofs_nid_t addr2nid(erofs_off_t addr)
+{
+	erofs_nid_t offset = (erofs_nid_t)sbk->meta_blkaddr * EROFS_BLKSIZ;
+
+	DBG_BUGON(!IS_SLOT_ALIGN(addr));
+	return (addr - offset) >> EROFS_ISLOTBITS;
+}
+
+erofs_off_t nid2addr(erofs_nid_t nid)
+{
+	erofs_off_t offset = (erofs_off_t)sbk->meta_blkaddr * EROFS_BLKSIZ;
+
+	return (nid <<  EROFS_ISLOTBITS) + offset;
+}
+
+void *erofs_init(struct fuse_conn_info *info)
+{
+	erofs_info("Using FUSE protocol %d.%d", info->proto_major, info->proto_minor);
+
+	if (inode_init(erofs_get_root_nid()) != 0) {
+		erofs_err("inode initialization failed");
+		abort();
+	}
+	return NULL;
+}
diff --git a/fuse/init.h b/fuse/init.h
new file mode 100644
index 000000000000..34085f2b548d
--- /dev/null
+++ b/fuse/init.h
@@ -0,0 +1,22 @@
+/* SPDX-License-Identifier: GPL-2.0+ */
+/*
+ * erofs-utils/fuse/init.h
+ *
+ * Created by Li Guifu <blucerlee@gmail.com>
+ */
+#ifndef __EROFS_INIT_H
+#define __EROFS_INIT_H
+
+#include <fuse.h>
+#include <fuse_opt.h>
+#include "erofs/internal.h"
+
+#define BOOT_SECTOR_SIZE	0x400
+
+int erofs_init_super(void);
+erofs_nid_t erofs_get_root_nid(void);
+erofs_off_t nid2addr(erofs_nid_t nid);
+erofs_nid_t addr2nid(erofs_off_t addr);
+void *erofs_init(struct fuse_conn_info *info);
+
+#endif
diff --git a/fuse/main.c b/fuse/main.c
new file mode 100644
index 000000000000..6fb3f3e42df3
--- /dev/null
+++ b/fuse/main.c
@@ -0,0 +1,166 @@
+// SPDX-License-Identifier: GPL-2.0+
+/*
+ * erofs-utils/fuse/main.c
+ *
+ * Created by Li Guifu <blucerlee@gmail.com>
+ */
+#include <stdio.h>
+#include <stdlib.h>
+#include <string.h>
+#include <execinfo.h>
+#include <signal.h>
+#include <stddef.h>
+
+#include "erofs/print.h"
+#include "init.h"
+#include "read.h"
+#include "getattr.h"
+#include "open.h"
+#include "readir.h"
+#include "erofs/io.h"
+
+/* XXX: after liberofs is linked in, it should be removed */
+struct erofs_configure cfg;
+
+enum {
+	EROFS_OPT_HELP,
+	EROFS_OPT_VER,
+};
+
+struct options {
+	const char *disk;
+	const char *mount;
+	const char *logfile;
+	unsigned int debug_lvl;
+};
+static struct options fusecfg;
+
+#define OPTION(t, p)    { t, offsetof(struct options, p), 1 }
+
+static const struct fuse_opt option_spec[] = {
+	OPTION("--log=%s", logfile),
+	OPTION("--dbg=%u", debug_lvl),
+	FUSE_OPT_KEY("-h", EROFS_OPT_HELP),
+	FUSE_OPT_KEY("-v", EROFS_OPT_VER),
+	FUSE_OPT_END
+};
+
+static void usage(void)
+{
+	fprintf(stderr, "\terofsfuse [options] <image> <mountpoint>\n");
+	fprintf(stderr, "\t    --log=<file>    output log file\n");
+	fprintf(stderr, "\t    --dbg=<level>   log debug level 0 ~ 7\n");
+	fprintf(stderr, "\t    -h   show help\n");
+	fprintf(stderr, "\t    -v   show version\n");
+	exit(1);
+}
+
+static void dump_cfg(void)
+{
+	fprintf(stderr, "\tdisk :%s\n", fusecfg.disk);
+	fprintf(stderr, "\tmount:%s\n", fusecfg.mount);
+	fprintf(stderr, "\tdebug_lvl:%u\n", fusecfg.debug_lvl);
+	fprintf(stderr, "\tlogfile  :%s\n", fusecfg.logfile);
+}
+
+static int optional_opt_func(void *data, const char *arg, int key,
+			     struct fuse_args *outargs)
+{
+	UNUSED(data);
+	UNUSED(outargs);
+
+	switch (key) {
+	case FUSE_OPT_KEY_OPT:
+		return 1;
+
+	case FUSE_OPT_KEY_NONOPT:
+		if (!fusecfg.disk) {
+			fusecfg.disk = strdup(arg);
+			return 0;
+		} else if (!fusecfg.mount)
+			fusecfg.mount = strdup(arg);
+
+		return 1;
+	case EROFS_OPT_HELP:
+		usage();
+		break;
+
+	case EROFS_OPT_VER:
+		fprintf(stderr, "EROFS FUSE VERSION v 1.0.0\n");
+		exit(0);
+	}
+
+	return 1;
+}
+
+static void signal_handle_sigsegv(int signal)
+{
+	void *array[10];
+	size_t nptrs;
+	char **strings;
+	size_t i;
+
+	UNUSED(signal);
+	erofs_dbg("========================================");
+	erofs_dbg("Segmentation Fault.  Starting backtrace:");
+	nptrs = backtrace(array, 10);
+	strings = backtrace_symbols(array, nptrs);
+	if (strings) {
+		for (i = 0; i < nptrs; i++)
+			erofs_dbg("%s", strings[i]);
+		free(strings);
+	}
+	erofs_dbg("========================================");
+
+	abort();
+}
+
+static struct fuse_operations erofs_ops = {
+	.getattr = erofs_getattr,
+	.readdir = erofs_readdir,
+	.open = erofs_open,
+	.read = erofs_read,
+	.init = erofs_init,
+};
+
+int main(int argc, char *argv[])
+{
+	int ret = EXIT_FAILURE;
+	struct fuse_args args = FUSE_ARGS_INIT(argc, argv);
+
+	if (signal(SIGSEGV, signal_handle_sigsegv) == SIG_ERR) {
+		fprintf(stderr, "Failed to initialize signals\n");
+		return EXIT_FAILURE;
+	}
+
+	/* Parse options */
+	if (fuse_opt_parse(&args, &fusecfg, option_spec, optional_opt_func) < 0)
+		return 1;
+
+	dump_cfg();
+
+	cfg.c_dbg_lvl = fusecfg.debug_lvl;
+
+	if (dev_open_ro(fusecfg.disk) < 0) {
+		fprintf(stderr, "Failed to open disk:%s\n", fusecfg.disk);
+		goto exit;
+	}
+
+	if (erofs_init_super()) {
+		fprintf(stderr, "Failed to read erofs super block\n");
+		goto exit_dev;
+	}
+
+	erofs_info("fuse start");
+
+	ret = fuse_main(args.argc, args.argv, &erofs_ops, NULL);
+
+	erofs_info("fuse done ret=%d", ret);
+
+exit_dev:
+	dev_close();
+exit:
+	fuse_opt_free_args(&args);
+	return ret;
+}
+
diff --git a/fuse/namei.c b/fuse/namei.c
new file mode 100644
index 000000000000..1564d5853fe6
--- /dev/null
+++ b/fuse/namei.c
@@ -0,0 +1,228 @@
+// SPDX-License-Identifier: GPL-2.0+
+/*
+ * erofs-utils/fuse/namei.c
+ *
+ * Created by Li Guifu <blucerlee@gmail.com>
+ */
+#include "namei.h"
+#include <linux/kdev_t.h>
+#include <sys/types.h>
+#include <unistd.h>
+#include <stdio.h>
+#include <errno.h>
+#include <sys/stat.h>
+
+#include "erofs/defs.h"
+#include "erofs/print.h"
+#include "erofs/io.h"
+#include "dentry.h"
+#include "init.h"
+
+#define IS_PATH_SEPARATOR(__c)      ((__c) == '/')
+#define MINORBITS	20
+#define MINORMASK	((1U << MINORBITS) - 1)
+#define DT_UNKNOWN	0
+
+static const char *skip_trailing_backslash(const char *path)
+{
+	while (IS_PATH_SEPARATOR(*path))
+		path++;
+	return path;
+}
+
+static uint8_t get_path_token_len(const char *path)
+{
+	uint8_t len = 0;
+
+	while (path[len] != '/' && path[len])
+		len++;
+	return len;
+}
+
+int erofs_iget_by_nid(erofs_nid_t nid, struct erofs_vnode *vi)
+{
+	int ret;
+	char buf[EROFS_BLKSIZ];
+	struct erofs_inode_compact *v1;
+	const erofs_off_t addr = nid2addr(nid);
+	const size_t size = EROFS_BLKSIZ - erofs_blkoff(addr);
+
+	ret = dev_read(buf, addr, size);
+	if (ret < 0)
+		return -EIO;
+
+	v1 = (struct erofs_inode_compact *)buf;
+	vi->datalayout = __inode_data_mapping(le16_to_cpu(v1->i_format));
+	vi->inode_isize = sizeof(struct erofs_inode_compact);
+	vi->xattr_isize = erofs_xattr_ibody_size(v1->i_xattr_icount);
+	vi->i_size = le32_to_cpu(v1->i_size);
+	vi->i_mode = le16_to_cpu(v1->i_mode);
+	vi->i_uid = le16_to_cpu(v1->i_uid);
+	vi->i_gid = le16_to_cpu(v1->i_gid);
+	vi->i_nlink = le16_to_cpu(v1->i_nlink);
+	vi->nid = nid;
+
+	switch (vi->i_mode & S_IFMT) {
+	case S_IFBLK:
+	case S_IFCHR:
+		/* fixme: add special devices support
+		 * vi->i_rdev = new_decode_dev(le32_to_cpu(v1->i_u.rdev));
+		 */
+		break;
+	case S_IFIFO:
+	case S_IFSOCK:
+		/*fixme: vi->i_rdev = 0; */
+		break;
+	case S_IFREG:
+	case S_IFLNK:
+	case S_IFDIR:
+		vi->raw_blkaddr = le32_to_cpu(v1->i_u.raw_blkaddr);
+		break;
+	default:
+		return -EIO;
+	}
+
+	return 0;
+}
+
+/* dirent + name string */
+struct dcache_entry *list_name(const char *buf, struct dcache_entry *parent,
+				const char *name, unsigned int len,
+				uint32_t dirend)
+{
+	struct dcache_entry *entry = NULL;
+	struct erofs_dirent *ds, *de;
+
+	ds = (struct erofs_dirent *)buf;
+	de = (struct erofs_dirent *)(buf + le16_to_cpu(ds->nameoff));
+
+	while (ds < de) {
+		erofs_nid_t nid = le64_to_cpu(ds->nid);
+		uint16_t nameoff = le16_to_cpu(ds->nameoff);
+		char *d_name = (char *)(buf + nameoff);
+		uint16_t name_len = (ds + 1 >= de) ?
+			(uint16_t)strnlen(d_name, dirend - nameoff) :
+			le16_to_cpu(ds[1].nameoff) - nameoff;
+
+		#if defined(EROFS_DEBUG_ENTRY)
+		{
+			char debug[EROFS_BLKSIZ];
+
+			memcpy(debug, d_name, name_len);
+			debug[name_len] = '\0';
+			erofs_info("list entry: %s nid=%u", debug, nid);
+		}
+		#endif
+
+		entry = dcache_try_insert(parent, d_name, name_len, nid);
+		if (len == name_len && !memcmp(name, d_name, name_len))
+			return entry;
+
+		entry = NULL;
+		++ds;
+	}
+
+	return entry;
+}
+
+struct dcache_entry *disk_lookup(struct dcache_entry *parent, const char *name,
+		unsigned int name_len)
+{
+	int ret;
+	char buf[EROFS_BLKSIZ];
+	struct dcache_entry *entry = NULL;
+	struct erofs_vnode v;
+	uint32_t nr_cnt, dir_nr, dirsize, blkno;
+
+	ret = erofs_iget_by_nid(parent->nid, &v);
+	if (ret)
+		return NULL;
+
+	/* to check whether dirent is in the inline dirs */
+	blkno = v.raw_blkaddr;
+	dirsize = v.i_size;
+	dir_nr = erofs_blknr(dirsize);
+
+	nr_cnt = 0;
+	while (nr_cnt < dir_nr) {
+		ret = blk_read(buf, blkno + nr_cnt, 1);
+		if (ret < 0)
+			return NULL;
+
+		entry = list_name(buf, parent, name, name_len, EROFS_BLKSIZ);
+		if (entry)
+			goto next;
+
+		++nr_cnt;
+	}
+
+	if (v.datalayout == EROFS_INODE_FLAT_INLINE) {
+		uint32_t dir_off = erofs_blkoff(dirsize);
+		off_t dir_addr = nid2addr(dcache_get_nid(parent)) +
+			v.inode_isize + v.xattr_isize;
+
+		memset(buf, 0, sizeof(buf));
+		ret = dev_read(buf, dir_addr, dir_off);
+		if (ret < 0)
+			return NULL;
+
+		entry = list_name(buf, parent, name, name_len, dir_off);
+	}
+next:
+	return entry;
+}
+
+extern struct dcache_entry root_entry;
+int walk_path(const char *_path, erofs_nid_t *out_nid)
+{
+	struct dcache_entry *next, *ret;
+	const char *path = _path;
+
+	ret = next = &root_entry;
+	for (;;) {
+		uint8_t path_len;
+
+		path = skip_trailing_backslash(path);
+		path_len = get_path_token_len(path);
+		ret = next;
+		if (path_len == 0)
+			break;
+
+		next = dcache_lookup(ret, path, path_len);
+		if (!next) {
+			next = disk_lookup(ret, path, path_len);
+			if (!next)
+				return -ENOENT;
+		}
+
+		path += path_len;
+	}
+
+	if (!ret)
+		return -ENOENT;
+	erofs_dbg("find path = %s nid=%u", _path, ret->nid);
+
+	*out_nid = ret->nid;
+	return 0;
+
+}
+
+int erofs_iget_by_path(const char *path, struct erofs_vnode *v)
+{
+	int ret;
+	erofs_nid_t nid;
+
+	ret = walk_path(path, &nid);
+	if (ret)
+		return ret;
+
+	return erofs_iget_by_nid(nid, v);
+}
+
+int inode_init(erofs_nid_t root)
+{
+	dcache_init_root(root);
+
+	return 0;
+}
+
diff --git a/fuse/namei.h b/fuse/namei.h
new file mode 100644
index 000000000000..1803a673daaf
--- /dev/null
+++ b/fuse/namei.h
@@ -0,0 +1,22 @@
+/* SPDX-License-Identifier: GPL-2.0+ */
+/*
+ * erofs-utils/fuse/inode.h
+ *
+ * Created by Li Guifu <blucerlee@gmail.com>
+ */
+#ifndef __INODE_H
+#define __INODE_H
+
+#include "erofs/internal.h"
+#include "erofs_fs.h"
+
+int inode_init(erofs_nid_t root);
+struct dcache_entry *get_cached_dentry(struct dcache_entry **parent,
+				       const char **path);
+int erofs_iget_by_path(const char *path, struct erofs_vnode *v);
+int erofs_iget_by_nid(erofs_nid_t nid, struct erofs_vnode *v);
+struct dcache_entry *disk_lookup(struct dcache_entry *parent, const char *name,
+		unsigned int name_len);
+int walk_path(const char *path, erofs_nid_t *out_nid);
+
+#endif
diff --git a/fuse/open.c b/fuse/open.c
new file mode 100644
index 000000000000..beb9a8615512
--- /dev/null
+++ b/fuse/open.c
@@ -0,0 +1,22 @@
+// SPDX-License-Identifier: GPL-2.0+
+/*
+ * erofs-utils/fuse/open.c
+ *
+ * Created by Li Guifu <blucerlee@gmail.com>
+ */
+#include "open.h"
+#include <asm-generic/errno-base.h>
+#include <fuse.h>
+#include <fuse_opt.h>
+#include "erofs/print.h"
+
+int erofs_open(const char *path, struct fuse_file_info *fi)
+{
+	erofs_info("open path=%s", path);
+
+	if ((fi->flags & O_ACCMODE) != O_RDONLY)
+		return -EACCES;
+
+	return 0;
+}
+
diff --git a/fuse/open.h b/fuse/open.h
new file mode 100644
index 000000000000..dfc8b3cdd515
--- /dev/null
+++ b/fuse/open.h
@@ -0,0 +1,15 @@
+/* SPDX-License-Identifier: GPL-2.0+ */
+/*
+ * erofs-utils/fuse/open.h
+ *
+ * Created by Li Guifu <blucerlee@gmail.com>
+ */
+#ifndef __EROFS_OPEN_H
+#define __EROFS_OPEN_H
+
+#include <fuse.h>
+#include <fuse_opt.h>
+
+int erofs_open(const char *path, struct fuse_file_info *fi);
+
+#endif
diff --git a/fuse/read.c b/fuse/read.c
new file mode 100644
index 000000000000..58b23783d083
--- /dev/null
+++ b/fuse/read.c
@@ -0,0 +1,113 @@
+// SPDX-License-Identifier: GPL-2.0+
+/*
+ * erofs-utils/fuse/read.c
+ *
+ * Created by Li Guifu <blucerlee@gmail.com>
+ */
+#include "read.h"
+#include <errno.h>
+#include <linux/fs.h>
+#include <sys/stat.h>
+#include <string.h>
+
+#include "erofs/defs.h"
+#include "erofs/internal.h"
+#include "erofs/print.h"
+#include "namei.h"
+#include "erofs/io.h"
+#include "init.h"
+
+size_t erofs_read_data(struct erofs_vnode *vnode, char *buffer,
+		       size_t size, off_t offset)
+{
+	int ret;
+	size_t sum, rdsz = 0;
+	uint32_t addr = blknr_to_addr(vnode->raw_blkaddr) + offset;
+
+	sum = (offset + size) > vnode->i_size ?
+		(size_t)(vnode->i_size - offset) : size;
+	while (rdsz < sum) {
+		size_t count = min(EROFS_BLKSIZ, (uint32_t)(sum - rdsz));
+
+		ret = dev_read(buffer + rdsz, addr + rdsz, count);
+		if (ret < 0)
+			return -EIO;
+		rdsz += count;
+	}
+
+	erofs_info("nid:%llu size=%zd offset=%llu realsize=%zd done",
+	     (unsigned long long)vnode->nid, size, (long long)offset, rdsz);
+	return rdsz;
+
+}
+
+size_t erofs_read_data_inline(struct erofs_vnode *vnode, char *buffer,
+			      size_t size, off_t offset)
+{
+	int ret;
+	size_t sum, suminline, rdsz = 0;
+	uint32_t addr = blknr_to_addr(vnode->raw_blkaddr) + offset;
+	uint32_t szblk = vnode->i_size - erofs_blkoff(vnode->i_size);
+
+	sum = (offset + size) > szblk ? (size_t)(szblk - offset) : size;
+	suminline = size - sum;
+
+	while (rdsz < sum) {
+		size_t count = min(EROFS_BLKSIZ, (uint32_t)(sum - rdsz));
+
+		ret = dev_read(buffer + rdsz, addr + rdsz, count);
+		if (ret < 0)
+			return -EIO;
+		rdsz += count;
+	}
+
+	if (!suminline)
+		goto finished;
+
+	addr = nid2addr(vnode->nid) + vnode->inode_isize + vnode->xattr_isize;
+	ret = dev_read(buffer + rdsz, addr, suminline);
+	if (ret < 0)
+		return -EIO;
+	rdsz += suminline;
+
+finished:
+	erofs_info("nid:%llu size=%zd suminline=%u offset=%llu realsize=%zd done",
+	     (unsigned long long)vnode->nid, size, (unsigned)suminline, (long long)offset, rdsz);
+	return rdsz;
+
+}
+
+int erofs_read(const char *path, char *buffer, size_t size, off_t offset,
+	       struct fuse_file_info *fi)
+{
+	int ret;
+	erofs_nid_t nid;
+	struct erofs_vnode v;
+
+	UNUSED(fi);
+	erofs_info("path:%s size=%zd offset=%llu", path, size, (long long)offset);
+
+	ret = walk_path(path, &nid);
+	if (ret)
+		return ret;
+
+	ret = erofs_iget_by_nid(nid, &v);
+	if (ret)
+		return ret;
+
+	erofs_info("path:%s nid=%llu mode=%u", path, (unsigned long long)nid, v.datalayout);
+	switch (v.datalayout) {
+	case EROFS_INODE_FLAT_PLAIN:
+		return erofs_read_data(&v, buffer, size, offset);
+
+	case EROFS_INODE_FLAT_INLINE:
+		return erofs_read_data_inline(&v, buffer, size, offset);
+
+	case EROFS_INODE_FLAT_COMPRESSION_LEGACY:
+	case EROFS_INODE_FLAT_COMPRESSION:
+		/* Fixme: */
+	default:
+		return -EINVAL;
+	}
+}
+
diff --git a/fuse/read.h b/fuse/read.h
new file mode 100644
index 000000000000..3f4af1495510
--- /dev/null
+++ b/fuse/read.h
@@ -0,0 +1,16 @@
+/* SPDX-License-Identifier: GPL-2.0+ */
+/*
+ * erofs-utils/fuse/read.h
+ *
+ * Created by Li Guifu <blucerlee@gmail.com>
+ */
+#ifndef __EROFS_READ_H
+#define __EROFS_READ_H
+
+#include <fuse.h>
+#include <fuse_opt.h>
+
+int erofs_read(const char *path, char *buffer, size_t size, off_t offset,
+	    struct fuse_file_info *fi);
+
+#endif
diff --git a/fuse/readir.c b/fuse/readir.c
new file mode 100644
index 000000000000..8111047803df
--- /dev/null
+++ b/fuse/readir.c
@@ -0,0 +1,122 @@
+// SPDX-License-Identifier: GPL-2.0+
+/*
+ * erofs-utils/fuse/readir.c
+ *
+ * Created by Li Guifu <blucerlee@gmail.com>
+ */
+#include "readir.h"
+#include <errno.h>
+#include <linux/fs.h>
+#include <sys/stat.h>
+
+#include "erofs/defs.h"
+#include "erofs/internal.h"
+#include "erofs_fs.h"
+#include "namei.h"
+#include "erofs/io.h"
+#include "erofs/print.h"
+#include "init.h"
+
+erofs_nid_t split_entry(char *entry, off_t ofs, char *end, char *name,
+			uint32_t dirend)
+{
+	struct erofs_dirent *de = (struct erofs_dirent *)(entry + ofs);
+	uint16_t nameoff = le16_to_cpu(de->nameoff);
+	const char *de_name = entry + nameoff;
+	uint32_t de_namelen;
+
+	if ((void *)(de + 1) >= (void *)end)
+		de_namelen = strnlen(de_name, dirend - nameoff);
+	else
+		de_namelen = le16_to_cpu(de[1].nameoff) - nameoff;
+
+	memcpy(name, de_name, de_namelen);
+	name[de_namelen] = '\0';
+	return le64_to_cpu(de->nid);
+}
+
+int fill_dir(char *entrybuf, fuse_fill_dir_t filler, void *buf,
+	     uint32_t dirend)
+{
+	uint32_t ofs;
+	uint16_t nameoff;
+	char *end;
+	char name[EROFS_BLKSIZ];
+
+	nameoff = le16_to_cpu(((struct erofs_dirent *)entrybuf)->nameoff);
+	end = entrybuf + nameoff;
+	ofs = 0;
+	while (ofs < nameoff) {
+		(void)split_entry(entrybuf, ofs, end, name, dirend);
+		filler(buf, name, NULL, 0);
+		ofs += sizeof(struct erofs_dirent);
+	}
+
+	return 0;
+}
+
+/** Function to add an entry in a readdir() operation
+ *
+ * @param buf the buffer passed to the readdir() operation
+ * @param name the file name of the directory entry
+ * @param stat file attributes, can be NULL
+ * @param off offset of the next entry or zero
+ * @return 1 if buffer is full, zero otherwise
+ */
+int erofs_readdir(const char *path, void *buf, fuse_fill_dir_t filler,
+		  off_t offset, struct fuse_file_info *fi)
+{
+	int ret;
+	erofs_nid_t nid;
+	struct erofs_vnode v;
+	char dirsbuf[EROFS_BLKSIZ];
+	uint32_t dir_nr, dir_off, nr_cnt;
+
+	erofs_dbg("readdir:%s offset=%llu", path, (long long)offset);
+	UNUSED(fi);
+
+	ret = walk_path(path, &nid);
+	if (ret)
+		return ret;
+
+	erofs_dbg("path=%s nid = %llu", path, (unsigned long long)nid);
+	ret = erofs_iget_by_nid(nid, &v);
+	if (ret)
+		return ret;
+
+	if (!S_ISDIR(v.i_mode))
+		return -ENOTDIR;
+
+	if (!v.i_size)
+		return 0;
+
+	dir_nr = erofs_blknr(v.i_size);
+	dir_off = erofs_blkoff(v.i_size);
+	nr_cnt = 0;
+
+	erofs_dbg("dir_size=%u dir_nr = %u dir_off=%u", v.i_size, dir_nr, dir_off);
+
+	while (nr_cnt < dir_nr) {
+		memset(dirsbuf, 0, sizeof(dirsbuf));
+		ret = blk_read(dirsbuf, v.raw_blkaddr + nr_cnt, 1);
+		if (ret < 0)
+			return -EIO;
+		fill_dir(dirsbuf, filler, buf, EROFS_BLKSIZ);
+		++nr_cnt;
+	}
+
+	if (v.datalayout == EROFS_INODE_FLAT_INLINE) {
+		off_t addr;
+
+		addr = nid2addr(nid) + v.inode_isize + v.xattr_isize;
+
+		memset(dirsbuf, 0, sizeof(dirsbuf));
+		ret = dev_read(dirsbuf, addr, dir_off);
+		if (ret < 0)
+			return -EIO;
+		fill_dir(dirsbuf, filler, buf, dir_off);
+	}
+
+	return 0;
+}
+
diff --git a/fuse/readir.h b/fuse/readir.h
new file mode 100644
index 000000000000..ee2ab8bdd0f0
--- /dev/null
+++ b/fuse/readir.h
@@ -0,0 +1,17 @@
+/* SPDX-License-Identifier: GPL-2.0+ */
+/*
+ * erofs-utils/fuse/readir.h
+ *
+ * Created by Li Guifu <blucerlee@gmail.com>
+ */
+#ifndef __EROFS_READDIR_H
+#define __EROFS_READDIR_H
+
+#include <fuse.h>
+#include <fuse_opt.h>
+
+int erofs_readdir(const char *path, void *buffer, fuse_fill_dir_t filler,
+	       off_t offset, struct fuse_file_info *fi);
+
+
+#endif
diff --git a/include/erofs/defs.h b/include/erofs/defs.h
index 8dee661ab9f0..e97de36aa04b 100644
--- a/include/erofs/defs.h
+++ b/include/erofs/defs.h
@@ -24,6 +24,9 @@
 #ifdef HAVE_LINUX_TYPES_H
 #include <linux/types.h>
 #endif
+#ifndef UNUSED
+#define UNUSED(_X)    ((void) _X)
+#endif
 
 /*
  * container_of - cast a member of a structure out to the containing structure
diff --git a/include/erofs/internal.h b/include/erofs/internal.h
index cabb2faa0072..1e3c23ae88b6 100644
--- a/include/erofs/internal.h
+++ b/include/erofs/internal.h
@@ -55,6 +55,8 @@ typedef u32 erofs_blk_t;
 #define blknr_to_addr(nr)       ((erofs_off_t)(nr) * EROFS_BLKSIZ)
 
 #define BLK_ROUND_UP(addr)	DIV_ROUND_UP(addr, EROFS_BLKSIZ)
+#define IS_SLOT_ALIGN(__ADDR)   (((__ADDR) % (EROFS_SLOTSIZE)) ? 0 : 1)
+#define IS_BLK_ALIGN(__ADDR)    (((__ADDR) % (EROFS_BLKSIZ)) ? 0 : 1)
 
 struct erofs_buffer_head;
 
@@ -132,11 +134,46 @@ struct erofs_inode {
 #endif
 };
 
+struct erofs_vnode {
+	uint8_t datalayout;
+
+	uint32_t i_size;
+	/* inline size in bytes */
+	uint16_t inode_isize;
+	uint16_t xattr_isize;
+
+	uint16_t xattr_shared_count;
+	char *xattr_shared_xattrs;
+
+	erofs_blk_t raw_blkaddr;
+	erofs_nid_t nid;
+	uint32_t i_ino;
+
+	uint16_t i_mode;
+	uint16_t i_uid;
+	uint16_t i_gid;
+	uint16_t i_nlink;
+
+	/* if file is inline read inline data witch inode */
+	char *idata;
+};
+
 static inline bool is_inode_layout_compression(struct erofs_inode *inode)
 {
 	return erofs_inode_is_data_compressed(inode->datalayout);
 }
 
+#define __inode_advise(x, bit, bits) \
+		(((x) >> (bit)) & ((1 << (bits)) - 1))
+
+#define __inode_version(advise)	\
+		__inode_advise(advise, EROFS_I_VERSION_BIT,	\
+			EROFS_I_VERSION_BITS)
+
+#define __inode_data_mapping(advise)	\
+	__inode_advise(advise, EROFS_I_DATALAYOUT_BIT,\
+		EROFS_I_DATALAYOUT_BITS)
+
 #define IS_ROOT(x)	((x) == (x)->i_parent)
 
 struct erofs_dentry {
diff --git a/include/erofs/io.h b/include/erofs/io.h
index a23de64541c6..557424578ece 100644
--- a/include/erofs/io.h
+++ b/include/erofs/io.h
@@ -17,6 +17,7 @@
 #endif
 
 int dev_open(const char *devname);
+int dev_open_ro(const char *dev);
 void dev_close(void);
 int dev_write(const void *buf, u64 offset, size_t len);
 int dev_read(void *buf, u64 offset, size_t len);
diff --git a/lib/io.c b/lib/io.c
index 4f5d9a6edaa4..d835f34da50f 100644
--- a/lib/io.c
+++ b/lib/io.c
@@ -108,6 +108,22 @@ int dev_open(const char *dev)
 	return 0;
 }
 
+/* XXX: temporary soluation. Disk I/O implementation needs to be refactored. */
+int dev_open_ro(const char *dev)
+{
+	int fd = open(dev, O_RDONLY | O_BINARY);
+
+	if (fd < 0) {
+		erofs_err("failed to open(%s).", dev);
+		return -errno;
+	}
+
+	erofs_devfd = fd;
+	erofs_devname = dev;
+	erofs_devsz = INT64_MAX;
+	return 0;
+}
+
 u64 dev_length(void)
 {
 	return erofs_devsz;
-- 
2.24.0

