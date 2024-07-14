Return-Path: <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>
X-Original-To: lists+linux-erofs@lfdr.de
Delivered-To: lists+linux-erofs@lfdr.de
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	by mail.lfdr.de (Postfix) with ESMTPS id 8CEBD93087C
	for <lists+linux-erofs@lfdr.de>; Sun, 14 Jul 2024 06:41:48 +0200 (CEST)
Authentication-Results: lists.ozlabs.org;
	dkim=pass (1024-bit key; unprotected) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.a=rsa-sha256 header.s=default header.b=XxngedHl;
	dkim-atps=neutral
Received: from boromir.ozlabs.org (localhost [IPv6:::1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4WMCN70lrJz3cZB
	for <lists+linux-erofs@lfdr.de>; Sun, 14 Jul 2024 14:41:43 +1000 (AEST)
X-Original-To: linux-erofs@lists.ozlabs.org
Delivered-To: linux-erofs@lists.ozlabs.org
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (1024-bit key; unprotected) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.a=rsa-sha256 header.s=default header.b=XxngedHl;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=linux.alibaba.com (client-ip=115.124.30.113; helo=out30-113.freemail.mail.aliyun.com; envelope-from=hsiangkao@linux.alibaba.com; receiver=lists.ozlabs.org)
Received: from out30-113.freemail.mail.aliyun.com (out30-113.freemail.mail.aliyun.com [115.124.30.113])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4WMCMy5mfXz30W1
	for <linux-erofs@lists.ozlabs.org>; Sun, 14 Jul 2024 14:41:32 +1000 (AEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=linux.alibaba.com; s=default;
	t=1720932088; h=From:To:Subject:Date:Message-ID:MIME-Version;
	bh=Zp7/T0ZXBbqq+hD6q2MvdEbVJCaW3go/lY553ikDxfU=;
	b=XxngedHl/1VRQ0UQvdRWp09v7BH+MQTDDdI4JS2X8jadhvKw8X9sk2GtqrC+pfQku9oGY43CE3fb9XDrv4yXjki6DMcb/Tmir315XmMC/0NJaaCK1gFFeCDNVgEO0HQ8o3dU+hLSiopqgb9nnN8s/CgT4eWV9XNmd1q70iDXYZk=
X-Alimail-AntiSpam: AC=PASS;BC=-1|-1;BR=01201311R111e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=maildocker-contentspam033037067112;MF=hsiangkao@linux.alibaba.com;NM=1;PH=DS;RN=2;SR=0;TI=SMTPD_---0WASVGAd_1720932080;
Received: from x31i01179.sqa.na131.tbsite.net(mailfrom:hsiangkao@linux.alibaba.com fp:SMTPD_---0WASVGAd_1720932080)
          by smtp.aliyun-inc.com;
          Sun, 14 Jul 2024 12:41:25 +0800
From: Gao Xiang <hsiangkao@linux.alibaba.com>
To: linux-erofs@lists.ozlabs.org
Subject: [PATCH] erofs-utils: lib: tar: fix garbage ns timestamps
Date: Sun, 14 Jul 2024 12:41:19 +0800
Message-ID: <20240714044119.1119717-1-hsiangkao@linux.alibaba.com>
X-Mailer: git-send-email 2.43.5
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

Some "#if" directives were used incorrectly.

Fixes: 95d315fd7958 ("erofs-utils: introduce tarerofs")
Signed-off-by: Gao Xiang <hsiangkao@linux.alibaba.com>
---
 include/erofs/defs.h |  3 +++
 lib/tar.c            | 11 +++++------
 2 files changed, 8 insertions(+), 6 deletions(-)

diff --git a/include/erofs/defs.h b/include/erofs/defs.h
index 310a6ab..e462338 100644
--- a/include/erofs/defs.h
+++ b/include/erofs/defs.h
@@ -332,15 +332,18 @@ unsigned long __roundup_pow_of_two(unsigned long n)
 #define ST_ATIM_NSEC(stbuf) ((stbuf)->st_atim.tv_nsec)
 #define ST_CTIM_NSEC(stbuf) ((stbuf)->st_ctim.tv_nsec)
 #define ST_MTIM_NSEC(stbuf) ((stbuf)->st_mtim.tv_nsec)
+#define ST_MTIM_NSEC_SET(stbuf, val) (stbuf)->st_mtim.tv_nsec = (val)
 #elif defined(HAVE_STRUCT_STAT_ST_ATIMENSEC)
 /* macOS */
 #define ST_ATIM_NSEC(stbuf) ((stbuf)->st_atimensec)
 #define ST_CTIM_NSEC(stbuf) ((stbuf)->st_ctimensec)
 #define ST_MTIM_NSEC(stbuf) ((stbuf)->st_mtimensec)
+#define ST_MTIM_NSEC_SET(stbuf, val) (stbuf)->st_mtimensec = (val)
 #else
 #define ST_ATIM_NSEC(stbuf) 0
 #define ST_CTIM_NSEC(stbuf) 0
 #define ST_MTIM_NSEC(stbuf) 0
+#define ST_MTIM_NSEC_SET(stbuf, val) do { } while (0)
 #endif
 
 #define __erofs_likely(x)      __builtin_expect(!!(x), 1)
diff --git a/lib/tar.c b/lib/tar.c
index cefda37..a9b425e 100644
--- a/lib/tar.c
+++ b/lib/tar.c
@@ -490,9 +490,9 @@ int tarerofs_parse_pax_header(struct erofs_iostream *ios,
 						ret = -EIO;
 						goto out;
 					}
-#if ST_MTIM_NSEC
-					ST_MTIM_NSEC(&eh->st) = n;
-#endif
+					ST_MTIM_NSEC_SET(&eh->st, n);
+				} else {
+					ST_MTIM_NSEC_SET(&eh->st, 0);
 				}
 				eh->use_mtime = true;
 			} else if (!strncmp(kv, "size=",
@@ -733,13 +733,12 @@ restart:
 
 	if (eh.use_mtime) {
 		st.st_mtime = eh.st.st_mtime;
-#if ST_MTIM_NSEC
-		ST_MTIM_NSEC(&st) = ST_MTIM_NSEC(&eh.st);
-#endif
+		ST_MTIM_NSEC_SET(&st, ST_MTIM_NSEC(&eh.st));
 	} else {
 		st.st_mtime = tarerofs_parsenum(th->mtime, sizeof(th->mtime));
 		if (errno)
 			goto invalid_tar;
+		ST_MTIM_NSEC_SET(&st, 0);
 	}
 
 	if (th->typeflag <= '7' && !eh.path) {
-- 
2.43.5

