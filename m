Return-Path: <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>
X-Original-To: lists+linux-erofs@lfdr.de
Delivered-To: lists+linux-erofs@lfdr.de
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2404:9400:2:0:216:3eff:fee1:b9f1])
	by mail.lfdr.de (Postfix) with ESMTPS id 1918A73CF3F
	for <lists+linux-erofs@lfdr.de>; Sun, 25 Jun 2023 10:18:06 +0200 (CEST)
Received: from boromir.ozlabs.org (localhost [IPv6:::1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4QpkPR6yFJz30Pp
	for <lists+linux-erofs@lfdr.de>; Sun, 25 Jun 2023 18:18:03 +1000 (AEST)
X-Original-To: linux-erofs@lists.ozlabs.org
Delivered-To: linux-erofs@lists.ozlabs.org
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=sjtu.edu.cn (client-ip=202.120.2.232; helo=smtp232.sjtu.edu.cn; envelope-from=zhaoyifan@sjtu.edu.cn; receiver=lists.ozlabs.org)
X-Greylist: delayed 553 seconds by postgrey-1.37 at boromir; Sun, 25 Jun 2023 18:17:57 AEST
Received: from smtp232.sjtu.edu.cn (smtp232.sjtu.edu.cn [202.120.2.232])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits))
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4QpkPK4ffsz2y3H
	for <linux-erofs@lists.ozlabs.org>; Sun, 25 Jun 2023 18:17:55 +1000 (AEST)
Received: from proxy188.sjtu.edu.cn (smtp188.sjtu.edu.cn [202.120.2.188])
	by smtp232.sjtu.edu.cn (Postfix) with ESMTPS id 2F8FA100B6586;
	Sun, 25 Jun 2023 16:08:33 +0800 (CST)
Received: from zhaoyf.ipads-lab.se.sjtu.edu.cn (unknown [202.120.40.82])
	by proxy188.sjtu.edu.cn (Postfix) with ESMTPSA id D757137C928;
	Sun, 25 Jun 2023 16:08:30 +0800 (CST)
From: Yifan Zhao <zhaoyifan@sjtu.edu.cn>
To: linux-erofs@lists.ozlabs.org,
	hsiangkao@linux.alibaba.com
Subject: [PATCH] erofs-utils: lib: fallback for copy_file_range
Date: Sun, 25 Jun 2023 16:08:19 +0800
Message-ID: <20230625080819.44502-1-zhaoyifan@sjtu.edu.cn>
X-Mailer: git-send-email 2.41.0
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
Cc: Yifan Zhao <zhaoyifan@sjtu.edu.cn>
Errors-To: linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org
Sender: "Linux-erofs" <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>

If tmpfs is used for /tmp and blob device is not specified, we need to
copy data between two different file systems during mkfs, which is not
supported by the copy_file_range() syscall. In this case, let's give it
a second chance by fallback to __erofs_copy_file_range().

Signed-off-by: Yifan Zhao <zhaoyifan@sjtu.edu.cn>
---
 lib/io.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/lib/io.c b/lib/io.c
index 9d718ab..1d266a5 100644
--- a/lib/io.c
+++ b/lib/io.c
@@ -387,7 +387,7 @@ ssize_t erofs_copy_file_range(int fd_in, erofs_off_t *off_in,
 			      length, 0);
 	if (ret >= 0)
 		goto out;
-	if (errno != ENOSYS) {
+	if (errno != ENOSYS && errno != EXDEV) {
 		ret = -errno;
 out:
 		*off_in = off64_in;
-- 
2.41.0

