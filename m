Return-Path: <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>
X-Original-To: lists+linux-erofs@lfdr.de
Delivered-To: lists+linux-erofs@lfdr.de
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2404:9400:2:0:216:3eff:fee1:b9f1])
	by mail.lfdr.de (Postfix) with ESMTPS id 6EF037A7124
	for <lists+linux-erofs@lfdr.de>; Wed, 20 Sep 2023 05:52:11 +0200 (CEST)
Received: from boromir.ozlabs.org (localhost [IPv6:::1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4Rr4NT27QMz3c1P
	for <lists+linux-erofs@lfdr.de>; Wed, 20 Sep 2023 13:52:09 +1000 (AEST)
X-Original-To: linux-erofs@lists.ozlabs.org
Delivered-To: linux-erofs@lists.ozlabs.org
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=linux.alibaba.com (client-ip=115.124.30.132; helo=out30-132.freemail.mail.aliyun.com; envelope-from=hsiangkao@linux.alibaba.com; receiver=lists.ozlabs.org)
Received: from out30-132.freemail.mail.aliyun.com (out30-132.freemail.mail.aliyun.com [115.124.30.132])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4Rr4NL1Tm9z3bVS
	for <linux-erofs@lists.ozlabs.org>; Wed, 20 Sep 2023 13:52:00 +1000 (AEST)
X-Alimail-AntiSpam: AC=PASS;BC=-1|-1;BR=01201311R211e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=ay29a033018045176;MF=hsiangkao@linux.alibaba.com;NM=1;PH=DS;RN=2;SR=0;TI=SMTPD_---0VsTcj69_1695181903;
Received: from e69b19392.et15sqa.tbsite.net(mailfrom:hsiangkao@linux.alibaba.com fp:SMTPD_---0VsTcj69_1695181903)
          by smtp.aliyun-inc.com;
          Wed, 20 Sep 2023 11:51:56 +0800
From: Gao Xiang <hsiangkao@linux.alibaba.com>
To: linux-erofs@lists.ozlabs.org
Subject: [PATCH] erofs-utils: mkfs: support exporting GNU tar archive labels
Date: Wed, 20 Sep 2023 11:51:41 +0800
Message-Id: <20230920035141.533474-1-hsiangkao@linux.alibaba.com>
X-Mailer: git-send-email 2.39.3
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
Cc: Gao Xiang <hsiangkao@linux.alibaba.com>
Errors-To: linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org
Sender: "Linux-erofs" <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>

GNU tar volume labels (by using `-V`) will be applied to EROFS.

Signed-off-by: Gao Xiang <hsiangkao@linux.alibaba.com>
---
 lib/tar.c | 24 ++++++++++++++++++------
 1 file changed, 18 insertions(+), 6 deletions(-)

diff --git a/lib/tar.c b/lib/tar.c
index 8e71f11..1cd820f 100644
--- a/lib/tar.c
+++ b/lib/tar.c
@@ -17,6 +17,9 @@
 #include "erofs/blobchunk.h"
 #include "erofs/rebuild.h"
 
+/* This file is a tape/volume header.  Ignore it on extraction.  */
+#define GNUTYPE_VOLHDR 'V'
+
 struct tar_header {
 	char name[100];		/*   0-99 */
 	char mode[8];		/* 100-107 */
@@ -632,12 +635,6 @@ restart:
 		goto restart;
 	}
 
-	if (memcmp(th->magic, "ustar", 5)) {
-		erofs_err("invalid tar magic @ %llu", tar_offset);
-		ret = -EIO;
-		goto out;
-	}
-
 	/* chksum field itself treated as ' ' */
 	csum = tarerofs_otoi(th->chksum, sizeof(th->chksum));
 	if (errno) {
@@ -663,6 +660,21 @@ restart:
 		goto out;
 	}
 
+	if (th->typeflag == GNUTYPE_VOLHDR) {
+		if (th->size[0])
+			erofs_warn("GNUTYPE_VOLHDR with non-zeroed size @ %llu",
+				   tar_offset);
+		/* anyway, strncpy could cause some GCC warning here */
+		memcpy(sbi->volume_name, th->name, sizeof(sbi->volume_name));
+		goto restart;
+	}
+
+	if (memcmp(th->magic, "ustar", 5)) {
+		erofs_err("invalid tar magic @ %llu", tar_offset);
+		ret = -EIO;
+		goto out;
+	}
+
 	st.st_mode = tarerofs_otoi(th->mode, sizeof(th->mode));
 	if (errno)
 		goto invalid_tar;
-- 
2.39.3

