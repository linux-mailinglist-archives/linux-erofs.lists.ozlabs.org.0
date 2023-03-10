Return-Path: <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>
X-Original-To: lists+linux-erofs@lfdr.de
Delivered-To: lists+linux-erofs@lfdr.de
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	by mail.lfdr.de (Postfix) with ESMTPS id C67DF6B3A02
	for <lists+linux-erofs@lfdr.de>; Fri, 10 Mar 2023 10:16:25 +0100 (CET)
Received: from boromir.ozlabs.org (localhost [IPv6:::1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4PY0m75HRGz3f3m
	for <lists+linux-erofs@lfdr.de>; Fri, 10 Mar 2023 20:16:23 +1100 (AEDT)
X-Original-To: linux-erofs@lists.ozlabs.org
Delivered-To: linux-erofs@lists.ozlabs.org
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=linux.alibaba.com (client-ip=115.124.30.97; helo=out30-97.freemail.mail.aliyun.com; envelope-from=hsiangkao@linux.alibaba.com; receiver=<UNKNOWN>)
Received: from out30-97.freemail.mail.aliyun.com (out30-97.freemail.mail.aliyun.com [115.124.30.97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4PY0lw68DPz3cMy
	for <linux-erofs@lists.ozlabs.org>; Fri, 10 Mar 2023 20:16:11 +1100 (AEDT)
X-Alimail-AntiSpam: AC=PASS;BC=-1|-1;BR=01201311R191e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=ay29a033018045192;MF=hsiangkao@linux.alibaba.com;NM=1;PH=DS;RN=2;SR=0;TI=SMTPD_---0VdWq.Kh_1678439766;
Received: from e18g06460.et15sqa.tbsite.net(mailfrom:hsiangkao@linux.alibaba.com fp:SMTPD_---0VdWq.Kh_1678439766)
          by smtp.aliyun-inc.com;
          Fri, 10 Mar 2023 17:16:07 +0800
From: Gao Xiang <hsiangkao@linux.alibaba.com>
To: linux-erofs@lists.ozlabs.org
Subject: [PATCH 2/2] erofs-utils: refine README
Date: Fri, 10 Mar 2023 17:16:01 +0800
Message-Id: <20230310091601.97930-2-hsiangkao@linux.alibaba.com>
X-Mailer: git-send-email 2.24.4
In-Reply-To: <20230310091601.97930-1-hsiangkao@linux.alibaba.com>
References: <20230310091601.97930-1-hsiangkao@linux.alibaba.com>
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

Add some words about userspace fragment cache as a TODO.

Signed-off-by: Gao Xiang <hsiangkao@linux.alibaba.com>
---
 README | 14 +++++++++-----
 1 file changed, 9 insertions(+), 5 deletions(-)

diff --git a/README b/README
index 6474ed1..e224b23 100644
--- a/README
+++ b/README
@@ -183,7 +183,7 @@ Therefore, NEVER use it if performance is the top concern.
 How to mount an EROFS image with erofsfuse
 ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
 
-As the other FUSE implementations, it's quite simple to mount with
+As the other FUSE implementations, it's quite easy to mount by using
 erofsfuse, e.g.:
  $ erofsfuse foo.erofs.img foo/
 
@@ -202,15 +202,19 @@ dump.erofs and fsck.erofs
 
 dump.erofs and fsck.erofs are used to analyze, check, and extract
 EROFS filesystems. Note that extended attributes and ACLs are still
-unsupported when extracting images with fsck.erofs.  If you are
-interested, contribution is, as always, welcome.
+unsupported when extracting images with fsck.erofs.
+
+Note that fragment extraction with fsck.erofs could be slow now and
+it needs to be optimized later.  If you are interested, contribution
+is, as always, welcome.
 
 
 Contribution
 ------------
 
-erofs-utils is a part of EROFS filesystem project, feel free to send
-patches or feedback to:
+erofs-utils is a part of EROFS filesystem project, which is completely
+community-driven open source software.  If you have interest in EROFS,
+feel free to send feedback and/or patches to:
   linux-erofs mailing list   <linux-erofs@lists.ozlabs.org>
 
 
-- 
2.24.4

