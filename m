Return-Path: <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>
X-Original-To: lists+linux-erofs@lfdr.de
Delivered-To: lists+linux-erofs@lfdr.de
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2401:3900:2:1::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 557A0DFC76
	for <lists+linux-erofs@lfdr.de>; Tue, 22 Oct 2019 06:07:42 +0200 (CEST)
Received: from bilbo.ozlabs.org (lists.ozlabs.org [IPv6:2401:3900:2:1::3])
	by lists.ozlabs.org (Postfix) with ESMTP id 46y0Mt6SYMzDqKq
	for <lists+linux-erofs@lfdr.de>; Tue, 22 Oct 2019 15:07:38 +1100 (AEDT)
X-Original-To: linux-erofs@lists.ozlabs.org
Delivered-To: linux-erofs@lists.ozlabs.org
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized)
 smtp.mailfrom=huawei.com (client-ip=45.249.212.191; helo=huawei.com;
 envelope-from=gaoxiang25@huawei.com; receiver=<UNKNOWN>)
Authentication-Results: lists.ozlabs.org;
 dmarc=none (p=none dis=none) header.from=huawei.com
Received: from huawei.com (szxga05-in.huawei.com [45.249.212.191])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 46y0Mn2ktYzDqKX
 for <linux-erofs@lists.ozlabs.org>; Tue, 22 Oct 2019 15:07:31 +1100 (AEDT)
Received: from DGGEMS404-HUB.china.huawei.com (unknown [172.30.72.60])
 by Forcepoint Email with ESMTP id 4D01D858A2FBC0249FB3
 for <linux-erofs@lists.ozlabs.org>; Tue, 22 Oct 2019 12:07:26 +0800 (CST)
Received: from architecture4.huawei.com (10.140.130.215) by smtp.huawei.com
 (10.3.19.204) with Microsoft SMTP Server (TLS) id 14.3.439.0; Tue, 22 Oct
 2019 12:07:16 +0800
From: Gao Xiang <gaoxiang25@huawei.com>
To: Li Guifu <bluce.liguifu@huawei.com>
Subject: [PATCH v2] erofs-utils: introduce long parameter option
Date: Tue, 22 Oct 2019 12:10:09 +0800
Message-ID: <20191022041009.55166-1-gaoxiang25@huawei.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20191022025053.GA180717@architecture4>
References: <20191022025053.GA180717@architecture4>
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.140.130.215]
X-CFilter-Loop: Reflected
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
Cc: linux-erofs@lists.ozlabs.org
Errors-To: linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org
Sender: "Linux-erofs"
 <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>

From: Li Guifu <blucerlee@gmail.com>

Only long option "--help" is valid now.

Signed-off-by: Li Guifu <blucerlee@gmail.com>
Signed-off-by: Gao Xiang <gaoxiang25@huawei.com>
---
changes since v1:
 - update based on
   https://lore.kernel.org/r/20191022025053.GA180717@architecture4/

 mkfs/main.c | 14 +++++++++++++-
 1 file changed, 13 insertions(+), 1 deletion(-)

diff --git a/mkfs/main.c b/mkfs/main.c
index 71c81f59e5b6..d3ebc8f55bda 100644
--- a/mkfs/main.c
+++ b/mkfs/main.c
@@ -13,6 +13,7 @@
 #include <limits.h>
 #include <libgen.h>
 #include <sys/stat.h>
+#include <getopt.h>
 #include "erofs/config.h"
 #include "erofs/print.h"
 #include "erofs/cache.h"
@@ -23,6 +24,11 @@
 
 #define EROFS_SUPER_END (EROFS_SUPER_OFFSET + sizeof(struct erofs_super_block))
 
+static struct option long_options[] = {
+	{"help", no_argument, 0, 1},
+	{0, 0, 0, 0},
+};
+
 static void usage(void)
 {
 	fprintf(stderr, "usage: [options] FILE DIRECTORY\n\n");
@@ -32,6 +38,7 @@ static void usage(void)
 	fprintf(stderr, " -x#       set xattr tolerance to # (< 0, disable xattrs; default 2)\n");
 	fprintf(stderr, " -EX[,...] X=extended options\n");
 	fprintf(stderr, " -T#       set a fixed UNIX timestamp # to all files\n");
+	fprintf(stderr, " --help    display this help and exit\n");
 }
 
 static int parse_extended_opts(const char *opts)
@@ -96,7 +103,8 @@ static int mkfs_parse_options_cfg(int argc, char *argv[])
 	char *endptr;
 	int opt, i;
 
-	while ((opt = getopt(argc, argv, "d:x:z:E:T:")) != -1) {
+	while((opt = getopt_long(argc, argv, "d:x:z:E:T:",
+				 long_options, NULL)) != -1) {
 		switch (opt) {
 		case 'z':
 			if (!optarg) {
@@ -146,6 +154,10 @@ static int mkfs_parse_options_cfg(int argc, char *argv[])
 			}
 			break;
 
+		case 1:
+			usage();
+			exit(0);
+
 		default: /* '?' */
 			return -EINVAL;
 		}
-- 
2.17.1

