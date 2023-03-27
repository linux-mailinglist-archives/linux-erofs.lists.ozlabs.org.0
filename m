Return-Path: <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>
X-Original-To: lists+linux-erofs@lfdr.de
Delivered-To: lists+linux-erofs@lfdr.de
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2404:9400:2:0:216:3eff:fee1:b9f1])
	by mail.lfdr.de (Postfix) with ESMTPS id D29D06C99C7
	for <lists+linux-erofs@lfdr.de>; Mon, 27 Mar 2023 04:58:01 +0200 (CEST)
Received: from boromir.ozlabs.org (localhost [IPv6:::1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4PlHYg4vB0z3cFw
	for <lists+linux-erofs@lfdr.de>; Mon, 27 Mar 2023 13:57:59 +1100 (AEDT)
X-Original-To: linux-erofs@lists.ozlabs.org
Delivered-To: linux-erofs@lists.ozlabs.org
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=linux.alibaba.com (client-ip=115.124.30.97; helo=out30-97.freemail.mail.aliyun.com; envelope-from=hsiangkao@linux.alibaba.com; receiver=<UNKNOWN>)
Received: from out30-97.freemail.mail.aliyun.com (out30-97.freemail.mail.aliyun.com [115.124.30.97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4PlHYX2gWtz3cCc
	for <linux-erofs@lists.ozlabs.org>; Mon, 27 Mar 2023 13:57:51 +1100 (AEDT)
X-Alimail-AntiSpam: AC=PASS;BC=-1|-1;BR=01201311R181e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=ay29a033018046049;MF=hsiangkao@linux.alibaba.com;NM=1;PH=DS;RN=2;SR=0;TI=SMTPD_---0VeeswsJ_1679885859;
Received: from e18g06460.et15sqa.tbsite.net(mailfrom:hsiangkao@linux.alibaba.com fp:SMTPD_---0VeeswsJ_1679885859)
          by smtp.aliyun-inc.com;
          Mon, 27 Mar 2023 10:57:46 +0800
From: Gao Xiang <hsiangkao@linux.alibaba.com>
To: linux-erofs@lists.ozlabs.org
Subject: [PATCH] erofs-utils: lib: justify post-EOD read behavior
Date: Mon, 27 Mar 2023 10:57:37 +0800
Message-Id: <20230327025737.62488-1-hsiangkao@linux.alibaba.com>
X-Mailer: git-send-email 2.24.4
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

In the past, errors will be returned when reading post-EOD data.
Let's align this with the generic EOD behavior (zero-filling) instead.

Signed-off-by: Gao Xiang <hsiangkao@linux.alibaba.com>
---
 lib/io.c | 14 +++++++-------
 1 file changed, 7 insertions(+), 7 deletions(-)

diff --git a/lib/io.c b/lib/io.c
index b318d91..2daa3d3 100644
--- a/lib/io.c
+++ b/lib/io.c
@@ -284,18 +284,18 @@ int dev_read(int device_id, void *buf, u64 offset, size_t len)
 #else
 		read_count = pread(fd, buf, len, (off_t)offset);
 #endif
-		if (read_count == -1 || read_count == 0) {
-			if (errno) {
+		if (read_count < 1) {
+			if (!read_count) {
+				erofs_err("Reach EOF of device - %s:[%" PRIu64 ", %zd].",
+					  erofs_devname, offset, len);
+				memset(buf, 0, len);
+				read_count = len;
+			} else if (errno != EINTR) {
 				erofs_err("Failed to read data from device - %s:[%" PRIu64 ", %zd].",
 					  erofs_devname, offset, len);
 				return -errno;
-			} else {
-				erofs_err("Reach EOF of device - %s:[%" PRIu64 ", %zd].",
-					  erofs_devname, offset, len);
-				return -EINVAL;
 			}
 		}
-
 		offset += read_count;
 		len -= read_count;
 		buf += read_count;
-- 
2.24.4

