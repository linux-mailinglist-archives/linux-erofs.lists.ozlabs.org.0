Return-Path: <linux-erofs+bounces-3165-lists+linux-erofs=lfdr.de@lists.ozlabs.org>
Delivered-To: lists+linux-erofs@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id XKSFNRkIzmkvkgYAu9opvQ
	(envelope-from <linux-erofs+bounces-3165-lists+linux-erofs=lfdr.de@lists.ozlabs.org>)
	for <lists+linux-erofs@lfdr.de>; Thu, 02 Apr 2026 08:09:29 +0200
X-Original-To: lists+linux-erofs@lfdr.de
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	by mail.lfdr.de (Postfix) with ESMTPS id D738938448E
	for <lists+linux-erofs@lfdr.de>; Thu, 02 Apr 2026 08:09:27 +0200 (CEST)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4fmWdv57s4z2yYK;
	Thu, 02 Apr 2026 17:09:23 +1100 (AEDT)
X-Original-To: linux-erofs@lists.ozlabs.org
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip=115.124.30.110
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1775110163;
	cv=none; b=BT8dfS5NZXGEBUHqQLx0Z48wkzAe+9Jmz7KeYL1ENi3UhdmwKFkWhlx/G0e+4sCrKaK9dcjW4YsFgQJJ4TqnsT73jc//dugVUPURmVD+qtA/wUcZbuibhwieFKiKfe1Gp/oaN5ELgWCaYthjPJZvCbKjzv7wtbqCnABuFQQ8cEWPJEkQyeUDHfkRYRbf0PJF1A0Ro0p5HuMzCW9bxMJ1oW2I0k6QwcXYfzILpTaHqkVaa3FvgrXUza5ZYG+atinZXH2Lg+1RXaPSAFSup8FqUzKiFaxAiI21ICuLXU7X0LMM80HxxAIBy+cpCqsxGdpEgiGqjHCuWEunEeHRMSNZKQ==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1775110163; c=relaxed/relaxed;
	bh=OB9hPEvZWiSLqRc+9wGROFcdITQlPMXzRQ+zgsx9aCQ=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=ja19qn6HAUJX0k1VlXjY+KOxRtXJ+NL4adMpRL0qI3eZ5B4pb5Jar+GJ6v+iquEYUEYMolO1Z49Pazw4BmbhZN+2eSi/dExxmTftXAAqCIj9rrqB1IY7utxp1WcT3v8GrR9N2VoBSpRbzZib667RC3utw821wZS5B3rWEFtPwPUZxFB9jVe151HQk6gRFGslAj9m9v9Ko6k04wxC6NWG9UgEUHf37+N2EKiidg4ooHvH9GOHW6KNnXMr8cmD8T0bkOBEtOL9Sm+OvQkWhOycFOea2muIDsY+ibJK0MklJ91JDkElbkiSyvulpMWvq7NeW7Q4ZqgXwKzFCdAmdeLW+A==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com; dkim=pass (1024-bit key; unprotected) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.a=rsa-sha256 header.s=default header.b=tPDMPgQN; dkim-atps=neutral; spf=pass (client-ip=115.124.30.110; helo=out30-110.freemail.mail.aliyun.com; envelope-from=hsiangkao@linux.alibaba.com; receiver=lists.ozlabs.org) smtp.mailfrom=linux.alibaba.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (1024-bit key; unprotected) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.a=rsa-sha256 header.s=default header.b=tPDMPgQN;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=linux.alibaba.com (client-ip=115.124.30.110; helo=out30-110.freemail.mail.aliyun.com; envelope-from=hsiangkao@linux.alibaba.com; receiver=lists.ozlabs.org)
Received: from out30-110.freemail.mail.aliyun.com (out30-110.freemail.mail.aliyun.com [115.124.30.110])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4fmWdq1lX8z2xm5
	for <linux-erofs@lists.ozlabs.org>; Thu, 02 Apr 2026 17:09:17 +1100 (AEDT)
DKIM-Signature:v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=linux.alibaba.com; s=default;
	t=1775110154; h=From:To:Subject:Date:Message-ID:MIME-Version;
	bh=OB9hPEvZWiSLqRc+9wGROFcdITQlPMXzRQ+zgsx9aCQ=;
	b=tPDMPgQNnH+ghaHP9Apc06QQAQ6mvap6K5eQ3NmaBig2U20ptzgV/eSQUvx74bw8GEWpYG+cDOQ8fmzwK1tVQcHgJjGmeVWttG6X4cspRfNIspA612IqEwjCZKEMCF3Fnpnq65FZDgmjdz4U2xFrpDHV6EiuBYLlCkQEdGMdSQk=
X-Alimail-AntiSpam:AC=PASS;BC=-1|-1;BR=01201311R121e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=maildocker-contentspam033045133197;MF=hsiangkao@linux.alibaba.com;NM=1;PH=DS;RN=2;SR=0;TI=SMTPD_---0X0G4zsA_1775110152;
Received: from x31i01179.sqa.na131.tbsite.net(mailfrom:hsiangkao@linux.alibaba.com fp:SMTPD_---0X0G4zsA_1775110152 cluster:ay36)
          by smtp.aliyun-inc.com;
          Thu, 02 Apr 2026 14:09:12 +0800
From: Gao Xiang <hsiangkao@linux.alibaba.com>
To: linux-erofs@lists.ozlabs.org
Cc: Gao Xiang <hsiangkao@linux.alibaba.com>
Subject: [PATCH 2/2] erofs-utils: switch other source files into MIT license
Date: Thu,  2 Apr 2026 14:09:06 +0800
Message-ID: <20260402060907.2268323-2-hsiangkao@linux.alibaba.com>
X-Mailer: git-send-email 2.43.5
In-Reply-To: <20260402060907.2268323-1-hsiangkao@linux.alibaba.com>
References: <20260402060907.2268323-1-hsiangkao@linux.alibaba.com>
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
X-Spam-Status: No, score=-15.7 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,DKIM_VALID_EF,ENV_AND_HDR_SPF_MATCH,RCVD_IN_DNSWL_NONE,
	SPF_HELO_NONE,SPF_PASS,UNPARSEABLE_RELAY,USER_IN_DEF_DKIM_WL,
	USER_IN_DEF_SPF_WL autolearn=disabled version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-25) on lists.ozlabs.org
X-Spamd-Result: default: False [-7.70 / 15.00];
	WHITELIST_DMARC(-7.00)[alibaba.com:D:+];
	MID_CONTAINS_FROM(1.00)[];
	ARC_ALLOW(-1.00)[lists.ozlabs.org:s=201707:i=1];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[linux.alibaba.com,none];
	R_SPF_ALLOW(-0.20)[+ip4:112.213.38.117];
	R_DKIM_ALLOW(-0.20)[linux.alibaba.com:s=default];
	MAILLIST(-0.19)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-3165-lists,linux-erofs=lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	RCPT_COUNT_TWO(0.00)[2];
	MIME_TRACE(0.00)[0:+];
	RCVD_COUNT_THREE(0.00)[3];
	ASN(0.00)[asn:133159, ipnet:112.213.32.0/21, country:AU];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[hsiangkao@linux.alibaba.com,linux-erofs@lists.ozlabs.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[linux.alibaba.com:+];
	PREVIOUSLY_DELIVERED(0.00)[linux-erofs@lists.ozlabs.org];
	TAGGED_RCPT(0.00)[linux-erofs];
	NEURAL_HAM(-0.00)[-1.000];
	TO_DN_SOME(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[huawei.com:url,autogen.sh:url,makefile.am:url,sjtu.edu.cn:email,linux.alibaba.com:dkim,linux.alibaba.com:mid,lists.ozlabs.org:helo,lists.ozlabs.org:rdns]
X-Rspamd-Queue-Id: D738938448E
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

Let's switch other source files to MIT license since we're absolutely
NOT working on secret rocket science, so licenses should not be
a bottleneck to innovation in the Cloud Native and AI era.

Signed-off-by: Gao Xiang <hsiangkao@linux.alibaba.com>
---
 COPYING                    | 14 +++++++-------
 Makefile.am                |  2 +-
 autogen.sh                 |  2 +-
 contrib/Makefile.am        |  2 +-
 contrib/stress.c           |  2 +-
 dump/Makefile.am           |  2 +-
 dump/main.c                |  2 +-
 fsck/Makefile.am           |  2 +-
 fsck/main.c                |  2 +-
 fuse/Makefile.am           |  2 +-
 fuse/macosx.h              |  2 +-
 fuse/main.c                |  2 +-
 man/Makefile.am            |  2 +-
 mkfs/Makefile.am           |  2 +-
 mkfs/main.c                |  2 +-
 mount/Makefile.am          |  2 +-
 mount/main.c               |  2 +-
 scripts/get-version-number |  2 +-
 18 files changed, 24 insertions(+), 24 deletions(-)

diff --git a/COPYING b/COPYING
index e781cc21ff15..81aee791f173 100644
--- a/COPYING
+++ b/COPYING
@@ -3,13 +3,13 @@ erofs-utils uses two different license patterns:
  - most liberofs files in `lib` and `include` directories
    use GPL-2.0+ OR MIT dual license;
 
- - all other files use GPL-2.0+ license, unless
-   explicitly stated otherwise.
+ - all other files use MIT license, unless explicitly stated
+   otherwise.
 
 Relevant licenses can be found in the LICENSES directory.
 
-This model is selected to emphasize that
-files in `lib` and `include` directories are designed to be included in
-3rd-party applications, while all other files are intended to be used
-"as is", as part of their intended scenarios, with no intention to
-support 3rd-party integration use cases.
+This model is selected to emphasize that erofs-utils can be integrated
+into various ecosystems as much as possible.
+
+However, liberofs should be GPL-2.0+ OR MIT dual license since some
+parts can be shared with the Linux kernel.
diff --git a/Makefile.am b/Makefile.am
index 7cb93a697627..e79222e965a9 100644
--- a/Makefile.am
+++ b/Makefile.am
@@ -1,4 +1,4 @@
-# SPDX-License-Identifier: GPL-2.0+
+# SPDX-License-Identifier: MIT
 
 ACLOCAL_AMFLAGS = -I m4
 
diff --git a/autogen.sh b/autogen.sh
index fd81db4d6fb3..89c510c35cab 100755
--- a/autogen.sh
+++ b/autogen.sh
@@ -1,5 +1,5 @@
 #!/bin/sh
-# SPDX-License-Identifier: GPL-2.0+
+# SPDX-License-Identifier: MIT
 
 aclocal && \
 autoheader && \
diff --git a/contrib/Makefile.am b/contrib/Makefile.am
index 4eb7abed8856..5bedb9441b2e 100644
--- a/contrib/Makefile.am
+++ b/contrib/Makefile.am
@@ -1,4 +1,4 @@
-# SPDX-License-Identifier: GPL-2.0+
+# SPDX-License-Identifier: MIT
 # Makefile.am
 
 AUTOMAKE_OPTIONS	= foreign
diff --git a/contrib/stress.c b/contrib/stress.c
index 0ef8c67c126b..65773bce9e27 100644
--- a/contrib/stress.c
+++ b/contrib/stress.c
@@ -1,4 +1,4 @@
-// SPDX-License-Identifier: GPL-2.0+
+// SPDX-License-Identifier: MIT
 /*
  * stress test for EROFS filesystem
  *
diff --git a/dump/Makefile.am b/dump/Makefile.am
index c2e0c745a640..2611fd28c762 100644
--- a/dump/Makefile.am
+++ b/dump/Makefile.am
@@ -1,4 +1,4 @@
-# SPDX-License-Identifier: GPL-2.0+
+# SPDX-License-Identifier: MIT
 # Makefile.am
 
 AUTOMAKE_OPTIONS = foreign
diff --git a/dump/main.c b/dump/main.c
index 78c50d511587..6c7258a5db40 100644
--- a/dump/main.c
+++ b/dump/main.c
@@ -1,4 +1,4 @@
-// SPDX-License-Identifier: GPL-2.0+
+// SPDX-License-Identifier: MIT
 /*
  * Copyright (C) 2021-2022 HUAWEI, Inc.
  *             http://www.huawei.com/
diff --git a/fsck/Makefile.am b/fsck/Makefile.am
index 488b401c8995..8eebadd7d1e5 100644
--- a/fsck/Makefile.am
+++ b/fsck/Makefile.am
@@ -1,4 +1,4 @@
-# SPDX-License-Identifier: GPL-2.0+
+# SPDX-License-Identifier: MIT
 # Makefile.am
 
 AUTOMAKE_OPTIONS = foreign
diff --git a/fsck/main.c b/fsck/main.c
index 16a354f460a8..21ada195edab 100644
--- a/fsck/main.c
+++ b/fsck/main.c
@@ -1,4 +1,4 @@
-// SPDX-License-Identifier: GPL-2.0+
+// SPDX-License-Identifier: MIT
 /*
  * Copyright 2021 Google LLC
  * Author: Daeho Jeong <daehojeong@google.com>
diff --git a/fuse/Makefile.am b/fuse/Makefile.am
index 1e8f518bad1d..9fe560849336 100644
--- a/fuse/Makefile.am
+++ b/fuse/Makefile.am
@@ -1,4 +1,4 @@
-# SPDX-License-Identifier: GPL-2.0+
+# SPDX-License-Identifier: MIT
 
 AUTOMAKE_OPTIONS = foreign
 noinst_HEADERS = $(top_srcdir)/fuse/macosx.h
diff --git a/fuse/macosx.h b/fuse/macosx.h
index 81ac47f551d6..4bb4bb75d5a2 100644
--- a/fuse/macosx.h
+++ b/fuse/macosx.h
@@ -1,4 +1,4 @@
-/* SPDX-License-Identifier: GPL-2.0+ */
+/* SPDX-License-Identifier: MIT */
 #ifdef __APPLE__
 #undef LIST_HEAD
 #endif
diff --git a/fuse/main.c b/fuse/main.c
index b6347828eacf..40f8684abe43 100644
--- a/fuse/main.c
+++ b/fuse/main.c
@@ -1,4 +1,4 @@
-// SPDX-License-Identifier: GPL-2.0+
+// SPDX-License-Identifier: MIT
 /*
  * Created by Li Guifu <blucerlee@gmail.com>
  * Lowlevel added by Li Yiyan <lyy0627@sjtu.edu.cn>
diff --git a/man/Makefile.am b/man/Makefile.am
index b9b598954725..88bf3a16d995 100644
--- a/man/Makefile.am
+++ b/man/Makefile.am
@@ -1,4 +1,4 @@
-# SPDX-License-Identifier: GPL-2.0+
+# SPDX-License-Identifier: MIT
 
 dist_man_MANS = mkfs.erofs.1 dump.erofs.1 fsck.erofs.1
 
diff --git a/mkfs/Makefile.am b/mkfs/Makefile.am
index aaefc11dadc3..386455aced67 100644
--- a/mkfs/Makefile.am
+++ b/mkfs/Makefile.am
@@ -1,4 +1,4 @@
-# SPDX-License-Identifier: GPL-2.0+
+# SPDX-License-Identifier: MIT
 
 AUTOMAKE_OPTIONS = foreign
 bin_PROGRAMS     = mkfs.erofs
diff --git a/mkfs/main.c b/mkfs/main.c
index eb13abaec92b..5006f76fa73b 100644
--- a/mkfs/main.c
+++ b/mkfs/main.c
@@ -1,4 +1,4 @@
-// SPDX-License-Identifier: GPL-2.0+
+// SPDX-License-Identifier: MIT
 /*
  * Copyright (C) 2018-2019 HUAWEI, Inc.
  *             http://www.huawei.com/
diff --git a/mount/Makefile.am b/mount/Makefile.am
index 7f6efd8b7cf5..637029d4475a 100644
--- a/mount/Makefile.am
+++ b/mount/Makefile.am
@@ -1,4 +1,4 @@
-# SPDX-License-Identifier: GPL-2.0+
+# SPDX-License-Identifier: MIT
 # Makefile.am
 
 AUTOMAKE_OPTIONS = foreign
diff --git a/mount/main.c b/mount/main.c
index b6a2deca4d85..e09e58533ecc 100644
--- a/mount/main.c
+++ b/mount/main.c
@@ -1,4 +1,4 @@
-// SPDX-License-Identifier: GPL-2.0+
+// SPDX-License-Identifier: MIT
 #define _GNU_SOURCE
 #include <dirent.h>
 #include <fcntl.h>
diff --git a/scripts/get-version-number b/scripts/get-version-number
index d216b7a424e0..484baebf53c6 100755
--- a/scripts/get-version-number
+++ b/scripts/get-version-number
@@ -1,5 +1,5 @@
 #!/bin/sh
-# SPDX-License-Identifier: GPL-2.0
+# SPDX-License-Identifier: MIT
 
 scm_version()
 {
-- 
2.43.5


