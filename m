Return-Path: <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>
X-Original-To: lists+linux-erofs@lfdr.de
Delivered-To: lists+linux-erofs@lfdr.de
Received: from lists.ozlabs.org (lists.ozlabs.org [203.11.71.2])
	by mail.lfdr.de (Postfix) with ESMTPS id 45657297C89
	for <lists+linux-erofs@lfdr.de>; Sat, 24 Oct 2020 15:11:15 +0200 (CEST)
Received: from bilbo.ozlabs.org (lists.ozlabs.org [IPv6:2401:3900:2:1::3])
	by lists.ozlabs.org (Postfix) with ESMTP id 4CJM1C2yMlzDqwH
	for <lists+linux-erofs@lfdr.de>; Sun, 25 Oct 2020 00:11:11 +1100 (AEDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=lists.ozlabs.org;
	s=201707; t=1603545071;
	bh=pvcm3ECf4oEshjmsmR5580v7T0ZZsQb4ApRLBItImgU=;
	h=To:Subject:Date:In-Reply-To:References:List-Id:List-Unsubscribe:
	 List-Archive:List-Post:List-Help:List-Subscribe:From:Reply-To:Cc:
	 From;
	b=ARUMyxw2YCHhpxmeux1dht6Pv/qcVYAXU7S8iIgellPHlYkblBBhR2xzjismsm//B
	 730zXv7pXGgYfjMiOzsbUXr4DwuByeGBll+80ACDrOIBusUMMCFbPHe8egiweYJ5l4
	 Y9BJ7Asq1iGR2Lp5gC5wrNsogfFMnoLBwckb3m9MovguIajKelWhsDcihQjjIk5wq7
	 K8ntAh0D7bom03vIp1Y8HuY0cnu4A0So6eiY9fNDkiqLSXkf57cycDdbHxUQEK3Vpo
	 GhZ+zU8L2GmeoXzsZeOdlwvC2V6nVZQgsyMVuvnBYYLAkCTAAYBAK4PcLBATEZRDJ5
	 NmjReuudNsgkw==
X-Original-To: linux-erofs@lists.ozlabs.org
Delivered-To: linux-erofs@lists.ozlabs.org
Authentication-Results: lists.ozlabs.org;
 spf=pass (sender SPF authorized) smtp.mailfrom=aol.com
 (client-ip=98.137.68.30; helo=sonic308-54.consmr.mail.gq1.yahoo.com;
 envelope-from=hsiangkao@aol.com; receiver=<UNKNOWN>)
Authentication-Results: lists.ozlabs.org;
 dmarc=pass (p=reject dis=none) header.from=aol.com
Authentication-Results: lists.ozlabs.org; dkim=pass (2048-bit key;
 unprotected) header.d=aol.com header.i=@aol.com header.a=rsa-sha256
 header.s=a2048 header.b=ik1D9Jcd; dkim-atps=neutral
Received: from sonic308-54.consmr.mail.gq1.yahoo.com
 (sonic308-54.consmr.mail.gq1.yahoo.com [98.137.68.30])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 4CJM0T2nh9zDqNd
 for <linux-erofs@lists.ozlabs.org>; Sun, 25 Oct 2020 00:10:32 +1100 (AEDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=aol.com; s=a2048;
 t=1603545029; bh=QBwim7Nr6GDzZV93PiRNpNsAzjM8k/Anl7xfEyADfIo=;
 h=From:To:Cc:Subject:Date:In-Reply-To:References:From:Subject;
 b=ik1D9JcdE5ShxtF5L3hfagPV3toLSUgAtQuBbutHIVYU+zxVDPYGGx5LwmOZiXYZJQyaa8nFM/DjaNDcDrj+puyql/Bt0BMhHICpGLkwUllzi7NjaAcE2IsGYsRz2RmFcoIyrTLgprhv9XtU6VHlDE8QHjQxe1lz8FJ+pvLCu1HVS8arQZPMiuWX/CCeYRXQFS9lpOcVjjGjCS1ncFzg8Onoef4s9t2NpJTViNbGADcrIe4MKzgVZdovmCcxv4dBRGE0ylFvv701cCOKQHvp3RUOKpZgM3Jsgmix9NiRCdCAXZ1Bl/10O6RtP2Ffv5msWYpEs0ypYU/yajFU22x7Rw==
X-SONIC-DKIM-SIGN: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yahoo.com; s=s2048;
 t=1603545029; bh=FsVxJlzy34fh/2UfuHzfTQbXeUWBhmjV9jdIyYPz9nV=;
 h=From:To:Subject:Date;
 b=LvJxrOM1Ku9siCzLBTyLyeO6z+0DMpunGGfvtLM29Zk3T/vcSnzn9NHFePljFAOLK88NBL2pxI8CWzctZlB9Ft6LiWlkYeLGlihvJFE7bKxSoIWKetT3Vpk3wozyu4O/6GfccMgqrBA2MuzueoLvRlmjEPPhjs8/cl0jXEbcg5AuqZgakgjRpR51VXfy2G47tbGVK42Cw5AsNoKutdMumGwyOZps2tFlnZtYXsGeYV+0i4He5TMvkAuJAmIDw4JI2//O9bXh7S6O+jJJXyr8F4ThL0DmluzeX0b5+Skczs5hcErz+U5FYIWUswBL+hYs/sxxDXY7ywKbjaZIVXeXEw==
X-YMail-OSG: N1EIMnUVM1m3V8T0sm19TtwdYdze6HkNsX43dq3JqWCm6AkhXyVwoYqnpx.hqwY
 sJLPiBFIs5Jo00Rl6InygeCS.zdat_xNlSRZqcrlPkycndMfvsRSTt.X5424lu2DxvJXak0uneOr
 J92KXak6fFxKK80uJ_aI50jTvv9p97P9uUT9m1Nox68i1wnC36u9cOjTjYmb7d50LEdzgiTlcnYs
 EaLFGGmKCvWstGpls0yO5pvykAoql.QKYVtNXAKlMSbyvmW13jgClXPiknf._UqKQccZu78_KQQV
 A6VIoRT83RVA3VwQ1H4AvznKjG6kHDranMJ6kOKGVXjf4HmWitQEmWnFvw7ALeFQ1GIS1rH4E1FW
 .0YbdpUwlsCqJ0k1RNbM7ovWvXwpJG78L7aIYCzA3C2dsWlvGzuH0uIITTTsp7kai.wU9RDFoDcY
 kgXE7G0bZ753obSoESGE.K_44B7Ui1tVSRHmZ2Bjrt5GGREppr4tVsuG7_trVQLcqybzEdZ8qbps
 2WEqjeOYYBQ1ImiGHZeL8GyLQa5h98XywKQ1aGrwXKM.G8aff.KTmT6JY2qgPJxm6KTCU7J9X_j1
 mPKzDsOkNb9bfICNTCoMcjJ3w.wTPDh7iOHGadM34fE0Qf3ZO167b51G8hH0GG3fxylOXrJr5FPp
 W6Qxq3MiQBG1wTopUi5tB51Fi_34zD7t5PfWvljT8EXEQqhCTlHYT..C3QURYL8gxl2dH1DG10P5
 inbEOV0qTDdM77MJ9WpVd9Xa25Dh9K6wwDd7gzPa_KkUSbNu2gAWGE3BujDfhaSvqjLDiviXEGxm
 _OS8UBb2XpyUPNY0VM6yHLXD6DU.OLjHt6MESEPzox6hoZ04S7YlHNMWCpPmyxUImYU3Aer0y9kz
 vhnmgQRhJeZzr0sDOT08q8qNXeC6fm6vxDXO08Yt9GknGWmXXV6Q1reoftVlp73Sayjqy6EM2qE0
 21dGRH57M1ZyOFlE.D2w053aNI53tZe7cWDu2fSriqown3lDYxELb3RopR4M3FM.34ZquZ7YlC2.
 jOXdN5ZW2wiXWOWMdoICmOHLjRKCXzY.FiA9UIJHvjz8wzdLeJDbv_lDh1MgDjhItSRIid3doQxP
 IBPEmog9BOE363TwCgcv.U4i_lLCn.nSHCuHsb3XYoSqvLeVwfDCgS0ZlmHb_tb7UdtcM_jurZZV
 LgVO3YRdpWii3NZTgBFeULjS3eMkPSeTwSB9u5ElCSxWRcwZ.gFuGVghYopo12xA5BeVTZnlRe0g
 5eCjXdfrj4Izyy326LVG_fMlDglGYmhKgJ85Qw9y2RKfegU3j7nnIEPzjxztP8ef5y5FMZJwoHAZ
 EO31op4oE3P2j8Bm2uj7PugmBYY.2VvApQEqPpjRk8n6S0fqlDkAL6PSqY25deGnYONS2SYVcwLU
 zOT4f4U9LAioW88hsW00_W7K7hCJI4bHhFOscIHutoGAlSssyko4k6EvQyylybvbMIM_6o5OaKh_
 ng4dtkUeH3zfLtXcAt0yhW4KymwMFL7PLzNbCwp3ecZtne0yOZTRSC8IA2nYIW99qmjGoxHa6tee
 eUfpvv7EFapIlEUGbBUD.6lanWlUjVRwsQDSxoz0TOLfYxmixNHLq4.74OwseOXLXwOtSWlYBv.e
 _riyRUzsGeqpFDuzXBLsb573rWfuqdP6XkcdCPQ5LE7YW3scSf92_3q4kG_Z6iJVI44wLiwM_Eqe
 A0qNLeXHjvAJ3a5qDkY2Gee7tSNmWhDJmwVk_dWm.tOCtHU6DfNOnJF2axjokzedFJ0H.WTXQ0d5
 ZGDMIE0A8jn7ZWynxUo9Vh2jN_3I4t0ld51j2ZbG4o.07336Ke7xMnqtytxYJxZNiIe34JDVlJUT
 k_65qZDmw1HqlLzJGwO6ne_zhIkOLpMB3C9Ism9Q6LU03vuPnrgHu8H9rOxDS7gzapFZIBMzUr1D
 P2vfzyLy_O4iEdQ8f.q5lx1eORSGu0hpCt5yNZzFg.3aZnagjwlncNAiXHyoQJFLCnu8Q4z6Ho0u
 GE7al9gySHjhZw2fKfXoCf82J4FHMt4m1uAzCjXsaLDx9wUwdD9oXFxD9jJ7B4j.B7xI9IGIqZIP
 Z3K489mwEUQdA5SHwkB89kxFJTvoFbUfOIkk9Wr52lC_Kzwn8jneTbTOfUJX.bl3648.LpVfuD9U
 OCUSteOqvjcPu0R5.jryo6vPtS2MNuSFTBQ6WYBoZTbdldoOnZJK036IjIPaXjIsK_5yWsHy0UMr
 7o.xrSNHM_rutM9Xs2gEc4YwmeMIzCQOV8KYihAvueA8uJ9HOY47tXbgst_D2ZXj5TcCsOjXHmS8
 Lwa.DSxTJcG4SdEN8XFc.HOPXu36Un3xXCPAj6IKrhnOeuiSth4DTTyJNPNFuFgSQWErknjNcAc.
 UTBcn9pWD_7tHZmh2BWpCrlZHt6CJAaxZ06cKd_omhs3O3ypLfqho0fz82cEdgh71lKOiD.bFl2V
 UE_ESmxC4j.wIn6zjDZsKfJAmfXk2HdFxdI737zmqBvUJuD0gFYuEs_.5hM8WxqwDTeKvB_8EUEF
 ZZfTrSTmFKeo5j.uaQZu6Qb4BQ_Q1WgdStYTsOW2qeuIBczWPZUm1bJxdCTSi2A0LqmhAN7bVMH4
 m6g2QiUE1ZWD4xhukbcKUh7fgP4zQFms33EaOcoQpmOJVzIrowyxXeE0EMGAkqtJmXk6vgLXafjS
 R.MjWVOvyN431HJ1rfv4FJOC0XcUnrquQlgOkfHAV4s7MsS_18CGkjKggXDaNl.elA4U9Y9ubxO.
 2XAHdbaIUUdtuQmrXtCB4HnWWgmvbSEOurKH9mE6N.8KbWjQ6dvHS0e3WmxDEfPlRObnaLYhkr2o
 3NUgXBXGd6WW9A_PUMsDcLd95ANR38i7Hic9J5yp2xqwPYkjJqGbWlxbPKPDHrOMasJ9hyfiLOpN
 GKT4_62e3JdOGEF82SR.XbzierXUtHCYJR4Ku6MrE2nvsOFktL1lW2YsFLzjdP.HLoZ0NlyrthzV
 etwCu18w6_dkkPqaNzkpV7BE-
Received: from sonic.gate.mail.ne1.yahoo.com by
 sonic308.consmr.mail.gq1.yahoo.com with HTTP; Sat, 24 Oct 2020 13:10:29 +0000
Received: by smtp419.mail.ir2.yahoo.com (VZM Hermes SMTP Server) with ESMTPA
 ID afd45167a3858f59b7d63d6cfac9db14; 
 Sat, 24 Oct 2020 13:10:22 +0000 (UTC)
To: linux-erofs@lists.ozlabs.org
Subject: [WIP] [PATCH v2 1/5] erofs-utils: introduce fuse implementation
Date: Sat, 24 Oct 2020 21:09:55 +0800
Message-Id: <20201024130959.23720-2-hsiangkao@aol.com>
X-Mailer: git-send-email 2.24.0
In-Reply-To: <20201024130959.23720-1-hsiangkao@aol.com>
References: <20201024130959.23720-1-hsiangkao@aol.com>
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
Cc: Zhang Shiming <zhangshiming@oppo.com>, Guo Weichao <guoweichao@oppo.com>
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
 fuse/dentry.c            | 129 ++++++++++++++++++++++
 fuse/dentry.h            |  42 ++++++++
 fuse/disk_io.c           |  72 +++++++++++++
 fuse/disk_io.h           |  21 ++++
 fuse/getattr.c           |  64 +++++++++++
 fuse/getattr.h           |  15 +++
 fuse/init.c              |  98 +++++++++++++++++
 fuse/init.h              |  22 ++++
 fuse/logging.c           |  81 ++++++++++++++
 fuse/logging.h           |  55 ++++++++++
 fuse/main.c              | 170 +++++++++++++++++++++++++++++
 fuse/namei.c             | 227 +++++++++++++++++++++++++++++++++++++++
 fuse/namei.h             |  22 ++++
 fuse/open.c              |  22 ++++
 fuse/open.h              |  15 +++
 fuse/read.c              | 113 +++++++++++++++++++
 fuse/read.h              |  16 +++
 fuse/readir.c            | 122 +++++++++++++++++++++
 fuse/readir.h            |  17 +++
 include/erofs/defs.h     |   3 +
 include/erofs/internal.h |  37 +++++++
 25 files changed, 1407 insertions(+), 3 deletions(-)
 create mode 100644 fuse/Makefile.am
 create mode 100644 fuse/dentry.c
 create mode 100644 fuse/dentry.h
 create mode 100644 fuse/disk_io.c
 create mode 100644 fuse/disk_io.h
 create mode 100644 fuse/getattr.c
 create mode 100644 fuse/getattr.h
 create mode 100644 fuse/init.c
 create mode 100644 fuse/init.h
 create mode 100644 fuse/logging.c
 create mode 100644 fuse/logging.h
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
index 000000000000..fffd67a53fe1
--- /dev/null
+++ b/fuse/Makefile.am
@@ -0,0 +1,14 @@
+# SPDX-License-Identifier: GPL-2.0+
+# Makefile.am
+
+AUTOMAKE_OPTIONS = foreign
+bin_PROGRAMS     = erofsfuse
+erofsfuse_SOURCES = main.c dentry.c getattr.c logging.c namei.c read.c disk_io.c init.c open.c readir.c
+erofsfuse_CFLAGS = -Wall -Werror -Wextra \
+                   -I$(top_srcdir)/include \
+                   $(shell pkg-config fuse --cflags) \
+                   -DFUSE_USE_VERSION=26 \
+                   -std=gnu99
+LDFLAGS += $(shell pkg-config fuse --libs)
+erofsfuse_LDADD = $(top_builddir)/lib/liberofs.la -ldl
+
diff --git a/fuse/dentry.c b/fuse/dentry.c
new file mode 100644
index 000000000000..1ae37e3abc86
--- /dev/null
+++ b/fuse/dentry.c
@@ -0,0 +1,129 @@
+// SPDX-License-Identifier: GPL-2.0+
+/*
+ * erofs-utils/fuse/dentry.c
+ *
+ * Created by Li Guifu <blucerlee@gmail.com>
+ */
+#include "dentry.h"
+#include "erofs/internal.h"
+#include "logging.h"
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
+	logi("Initializing root_entry dcache entry");
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
+	logd("Inserting %s,%d to dcache", name, namelen);
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
diff --git a/fuse/disk_io.c b/fuse/disk_io.c
new file mode 100644
index 000000000000..3fc087699dc9
--- /dev/null
+++ b/fuse/disk_io.c
@@ -0,0 +1,72 @@
+// SPDX-License-Identifier: GPL-2.0+
+/*
+ * erofs-utils/fuse/disk_io.c
+ *
+ * Created by Li Guifu <blucerlee@gmail.com>
+ */
+#define _XOPEN_SOURCE 500
+#include "disk_io.h"
+
+#include <sys/types.h>
+#include <unistd.h>
+#include <fcntl.h>
+#include <errno.h>
+#include <pthread.h>
+#include <errno.h>
+
+#include "logging.h"
+
+#ifdef __FreeBSD__
+#include <string.h>
+#endif
+
+static const char *erofs_devname;
+static int erofs_devfd = -1;
+static pthread_mutex_t read_lock = PTHREAD_MUTEX_INITIALIZER;
+
+int dev_open(const char *path)
+{
+	int fd = open(path, O_RDONLY);
+
+	if (fd < 0)
+		return -errno;
+
+	erofs_devfd = fd;
+	erofs_devname = path;
+
+	return 0;
+}
+
+static inline int pread_wrapper(int fd, void *buf, size_t count, off_t offset)
+{
+	return pread(fd, buf, count, offset);
+}
+
+int dev_read(void *buf, size_t count, off_t offset)
+{
+	ssize_t pread_ret;
+	int lerrno;
+
+	ASSERT(erofs_devfd >= 0);
+
+	pthread_mutex_lock(&read_lock);
+	pread_ret = pread_wrapper(erofs_devfd, buf, count, offset);
+	lerrno = errno;
+	logd("Disk Read: offset[0x%jx] count[%zd] pread_ret=%zd %s",
+	     offset, count, pread_ret, strerror(lerrno));
+	pthread_mutex_unlock(&read_lock);
+	if (count == 0)
+		logw("Read operation with 0 size");
+
+	ASSERT((size_t)pread_ret == count);
+
+	return pread_ret;
+}
+
+void dev_close(void)
+{
+	if (erofs_devfd >= 0) {
+		close(erofs_devfd);
+		erofs_devfd = -1;
+	}
+}
diff --git a/fuse/disk_io.h b/fuse/disk_io.h
new file mode 100644
index 000000000000..d2c3dd598bc0
--- /dev/null
+++ b/fuse/disk_io.h
@@ -0,0 +1,21 @@
+/* SPDX-License-Identifier: GPL-2.0+ */
+/*
+ * erofs-utils/fuse/disk_io.h
+ *
+ * Created by Li Guifu <blucerlee@gmail.com>
+ */
+#ifndef __DISK_IO_H
+#define __DISK_IO_H
+
+#include "erofs/defs.h"
+#include "erofs/internal.h"
+
+int dev_open(const char *path);
+void dev_close(void);
+int dev_read(void *buf, size_t count, off_t offset);
+
+static inline int dev_read_blk(void *buf, uint32_t nr)
+{
+	return dev_read(buf, EROFS_BLKSIZ, blknr_to_addr(nr));
+}
+#endif
diff --git a/fuse/getattr.c b/fuse/getattr.c
new file mode 100644
index 000000000000..2518adb8947f
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
+
+#include "logging.h"
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
+	logd("getattr(%s)", path);
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
index 000000000000..043629ff1088
--- /dev/null
+++ b/fuse/init.c
@@ -0,0 +1,98 @@
+// SPDX-License-Identifier: GPL-2.0+
+/*
+ * erofs-utils/fuse/init.c
+ *
+ * Created by Li Guifu <blucerlee@gmail.com>
+ */
+#include "init.h"
+#include <string.h>
+#include <asm-generic/errno-base.h>
+
+#include "namei.h"
+#include "disk_io.h"
+#include "logging.h"
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
+	ret = dev_read_blk(buf, 0);
+	if (ret != EROFS_BLKSIZ) {
+		logi("Failed to read super block ret=%d", ret);
+		return -EINVAL;
+	}
+
+	sb = (struct erofs_super_block *) (buf + BOOT_SECTOR_SIZE);
+	sbk->magic = le32_to_cpu(sb->magic);
+	if (sbk->magic != EROFS_SUPER_MAGIC_V1) {
+		logi("EROFS magic[0x%X] NOT matched to [0x%X] ",
+		     super.magic, EROFS_SUPER_MAGIC_V1);
+		return -EINVAL;
+	}
+
+	sbk->checksum = le32_to_cpu(sb->checksum);
+	sbk->feature_compat = le32_to_cpu(sb->feature_compat);
+	sbk->blkszbits = sb->blkszbits;
+	ASSERT(sbk->blkszbits != 32);
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
+	logp("%-15s:0x%X", STR(magic), SUPER_MEM(magic));
+	logp("%-15s:0x%X", STR(feature_compat), SUPER_MEM(feature_compat));
+	logp("%-15s:%u",   STR(blkszbits), SUPER_MEM(blkszbits));
+	logp("%-15s:%u",   STR(root_nid), SUPER_MEM(root_nid));
+	logp("%-15s:%ul",  STR(inos), SUPER_MEM(inos));
+	logp("%-15s:%d",   STR(meta_blkaddr), SUPER_MEM(meta_blkaddr));
+	logp("%-15s:%d",   STR(xattr_blkaddr), SUPER_MEM(xattr_blkaddr));
+
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
+	ASSERT(IS_SLOT_ALIGN(addr));
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
+	logi("Using FUSE protocol %d.%d", info->proto_major, info->proto_minor);
+
+	if (inode_init(erofs_get_root_nid()) != 0) {
+		loge("inode initialization failed")
+		ABORT();
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
diff --git a/fuse/logging.c b/fuse/logging.c
new file mode 100644
index 000000000000..192f546b94ec
--- /dev/null
+++ b/fuse/logging.c
@@ -0,0 +1,81 @@
+// SPDX-License-Identifier: GPL-2.0+
+/*
+ * erofs-utils/fuse/logging.c
+ *
+ * Created by Li Guifu <blucerlee@gmail.com>
+ */
+#include "logging.h"
+
+#include <stdio.h>
+#include <stdarg.h>
+#include <pthread.h>
+
+static int loglevel = DEFAULT_LOG_LEVEL;
+static FILE *logfile;
+static const char * const loglevel_str[] = {
+	[LOG_EMERG]     = "[emerg]",
+	[LOG_ALERT]     = "[alert]",
+	[LOG_DUMP]      = "[dump] ",
+	[LOG_ERR]       = "[err]  ",
+	[LOG_WARNING]   = "[warn] ",
+	[LOG_NOTICE]    = "[notic]",
+	[LOG_INFO]      = "[info] ",
+	[LOG_DEBUG]     = "[debug]",
+};
+
+void __LOG(int level, const char *func, int line, const char *format, ...)
+{
+	static pthread_mutex_t lock = PTHREAD_MUTEX_INITIALIZER;
+	va_list ap;
+	FILE *fp = logfile ? logfile : stdout;
+
+	if (!fp)
+		return;
+	if (level < 0 || level > loglevel)
+		return;
+
+	/* We have a lock here so different threads don interleave the log
+	 * output
+	 */
+	pthread_mutex_lock(&lock);
+	va_start(ap, format);
+	fprintf(fp, "%s", loglevel_str[level]);
+	if (func)
+		fprintf(fp, "%s", func);
+	if (line >= 0)
+		fprintf(fp, "(%d):", line);
+	vfprintf(fp, format, ap);
+	fprintf(fp, "\n");
+	va_end(ap);
+	fflush(fp);
+	pthread_mutex_unlock(&lock);
+}
+
+inline void logging_setlevel(int new_level)
+{
+	loglevel = new_level;
+}
+
+int logging_open(const char *path)
+{
+	if (path == NULL)
+		return 0;
+
+	logfile = fopen(path, "w");
+	if (logfile == NULL) {
+		perror("open");
+		return -1;
+	}
+
+	return 0;
+}
+
+void logging_close(void)
+{
+	if (logfile) {
+		fflush(logfile);
+		fclose(logfile);
+		logfile = NULL;
+	}
+}
+
diff --git a/fuse/logging.h b/fuse/logging.h
new file mode 100644
index 000000000000..3aa77ab08107
--- /dev/null
+++ b/fuse/logging.h
@@ -0,0 +1,55 @@
+/* SPDX-License-Identifier: GPL-2.0+ */
+/*
+ * erofs-utils/fuse/logging.h
+ *
+ * Created by Li Guifu <blucerlee@gmail.com>
+ */
+#ifndef __LOGGING_H
+#define __LOGGING_H
+
+#include <assert.h>
+#include <stdlib.h>
+
+#define LOG_EMERG   0
+#define LOG_ALERT   1
+#define LOG_DUMP    2
+#define LOG_ERR     3
+#define LOG_WARNING 4
+#define LOG_NOTICE  5
+#define LOG_INFO    6
+#define LOG_DEBUG   7
+
+#define logem(...)	__LOG(LOG_EMERG, __func__, __LINE__, ##__VA_ARGS__)
+#define loga(...)	__LOG(LOG_ALERT, __func__, __LINE__, ##__VA_ARGS__)
+#define loge(...)	__LOG(LOG_ERR,   __func__, __LINE__, ##__VA_ARGS__)
+#define logw(...)	__LOG(LOG_WARNING, __func__, __LINE__, ##__VA_ARGS__)
+#define logn(...)	__LOG(LOG_NOTICE,  __func__, __LINE__, ##__VA_ARGS__)
+#define logi(...)	__LOG(LOG_INFO,  __func__, __LINE__, ##__VA_ARGS__)
+#define logp(...)	__LOG(LOG_DUMP,  "", -1, ##__VA_ARGS__)
+#define logd(...)	__LOG(LOG_DEBUG, __func__, __LINE__, ##__VA_ARGS__)
+
+#define DEFAULT_LOG_FILE	"fuse.log"
+
+#ifdef _DEBUG
+#define DEFAULT_LOG_LEVEL LOG_DEBUG
+
+#define ASSERT(assertion) ({                            \
+	if (!(assertion)) {                             \
+		logw("ASSERT FAIL: " #assertion);       \
+		assert(assertion);                      \
+	}                                               \
+})
+#define ABORT(_X) abort(_X)
+#else
+#define DEFAULT_LOG_LEVEL LOG_ERR
+#define ASSERT(assertion)
+#define ABORT(_X)
+#endif
+
+void __LOG(int level, const char *func, int line, const char *format, ...);
+void logging_setlevel(int new_level);
+int logging_open(const char *path);
+void logging_close(void);
+
+#endif
+
diff --git a/fuse/main.c b/fuse/main.c
new file mode 100644
index 000000000000..edecbed9a65a
--- /dev/null
+++ b/fuse/main.c
@@ -0,0 +1,170 @@
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
+#include "logging.h"
+#include "init.h"
+#include "read.h"
+#include "getattr.h"
+#include "open.h"
+#include "readir.h"
+#include "disk_io.h"
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
+static struct options cfg;
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
+	fprintf(stderr, "\tdisk :%s\n", cfg.disk);
+	fprintf(stderr, "\tmount:%s\n", cfg.mount);
+	fprintf(stderr, "\tdebug_lvl:%u\n", cfg.debug_lvl);
+	fprintf(stderr, "\tlogfile  :%s\n", cfg.logfile);
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
+		if (!cfg.disk) {
+			cfg.disk = strdup(arg);
+			return 0;
+		} else if (!cfg.mount)
+			cfg.mount = strdup(arg);
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
+	logd("========================================");
+	logd("Segmentation Fault.  Starting backtrace:");
+	nptrs = backtrace(array, 10);
+	strings = backtrace_symbols(array, nptrs);
+	if (strings) {
+		for (i = 0; i < nptrs; i++)
+			logd("%s", strings[i]);
+		free(strings);
+	}
+	logd("========================================");
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
+	if (fuse_opt_parse(&args, &cfg, option_spec, optional_opt_func) < 0)
+		return 1;
+
+	dump_cfg();
+
+	if (logging_open(cfg.logfile) < 0) {
+		fprintf(stderr, "Failed to initialize logging\n");
+		goto exit;
+	}
+
+	logging_setlevel(cfg.debug_lvl);
+
+	if (dev_open(cfg.disk) < 0) {
+		fprintf(stderr, "Failed to open disk:%s\n", cfg.disk);
+		goto exit_log;
+	}
+
+	if (erofs_init_super()) {
+		fprintf(stderr, "Failed to read erofs super block\n");
+		goto exit_dev;
+	}
+
+	logi("fuse start");
+
+	ret = fuse_main(args.argc, args.argv, &erofs_ops, NULL);
+
+	logi("fuse done ret=%d", ret);
+
+exit_dev:
+	dev_close();
+exit_log:
+	logging_close();
+exit:
+	fuse_opt_free_args(&args);
+	return ret;
+}
+
diff --git a/fuse/namei.c b/fuse/namei.c
new file mode 100644
index 000000000000..4d162047db15
--- /dev/null
+++ b/fuse/namei.c
@@ -0,0 +1,227 @@
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
+#include "logging.h"
+#include "disk_io.h"
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
+	ret = dev_read(buf, size, addr);
+	if (ret != (int)size)
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
+			logi("list entry: %s nid=%u", debug, nid);
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
+		if (dev_read_blk(buf, blkno + nr_cnt) != EROFS_BLKSIZ)
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
+		ret = dev_read(buf, dir_off, dir_addr);
+		if (ret < 0 && (uint32_t)ret != dir_off)
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
+	logd("find path = %s nid=%u", _path, ret->nid);
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
index 000000000000..c219d3870000
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
+#include "logging.h"
+
+int erofs_open(const char *path, struct fuse_file_info *fi)
+{
+	logi("open path=%s", path);
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
index 000000000000..7e8f9516f853
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
+#include "logging.h"
+#include "namei.h"
+#include "disk_io.h"
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
+		ret = dev_read(buffer + rdsz, count, addr + rdsz);
+		if (ret < 0 || (size_t)ret != count)
+			return -EIO;
+		rdsz += count;
+	}
+
+	logi("nid:%u size=%zd offset=%llu realsize=%zd done",
+	     vnode->nid, size, (long long)offset, rdsz);
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
+		ret = dev_read(buffer + rdsz, count, addr + rdsz);
+		if (ret < 0 || (uint32_t)ret != count)
+			return -EIO;
+		rdsz += count;
+	}
+
+	if (!suminline)
+		goto finished;
+
+	addr = nid2addr(vnode->nid) + vnode->inode_isize + vnode->xattr_isize;
+	ret = dev_read(buffer + rdsz, suminline, addr);
+	if (ret < 0 || (size_t)ret != suminline)
+		return -EIO;
+	rdsz += suminline;
+
+finished:
+	logi("nid:%u size=%zd suminline=%u offset=%llu realsize=%zd done",
+	     vnode->nid, size, suminline, (long long)offset, rdsz);
+	return rdsz;
+
+}
+
+
+int erofs_read(const char *path, char *buffer, size_t size, off_t offset,
+	       struct fuse_file_info *fi)
+{
+	int ret;
+	erofs_nid_t nid;
+	struct erofs_vnode v;
+
+	UNUSED(fi);
+	logi("path:%s size=%zd offset=%llu", path, size, (long long)offset);
+
+	ret = walk_path(path, &nid);
+	if (ret)
+		return ret;
+
+	ret = erofs_iget_by_nid(nid, &v);
+	if (ret)
+		return ret;
+
+	logi("path:%s nid=%llu mode=%u", path, nid, v.datalayout);
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
index 000000000000..b00274dad9f4
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
+#include "disk_io.h"
+#include "logging.h"
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
+	logd("readdir:%s offset=%llu", path, (long long)offset);
+	UNUSED(fi);
+
+	ret = walk_path(path, &nid);
+	if (ret)
+		return ret;
+
+	logd("path=%s nid = %u", path, nid);
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
+	logd("dir_size=%u dir_nr = %u dir_off=%u", v.i_size, dir_nr, dir_off);
+
+	while (nr_cnt < dir_nr) {
+		memset(dirsbuf, 0, sizeof(dirsbuf));
+		ret = dev_read_blk(dirsbuf, v.raw_blkaddr + nr_cnt);
+		if (ret != EROFS_BLKSIZ)
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
+		ret = dev_read(dirsbuf, dir_off, addr);
+		if (ret < 0 || (uint32_t)ret != dir_off)
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
-- 
2.24.0

