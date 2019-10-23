Return-Path: <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>
X-Original-To: lists+linux-erofs@lfdr.de
Delivered-To: lists+linux-erofs@lfdr.de
Received: from lists.ozlabs.org (lists.ozlabs.org [203.11.71.2])
	by mail.lfdr.de (Postfix) with ESMTPS id 479CFE1231
	for <lists+linux-erofs@lfdr.de>; Wed, 23 Oct 2019 08:35:18 +0200 (CEST)
Received: from bilbo.ozlabs.org (lists.ozlabs.org [IPv6:2401:3900:2:1::3])
	by lists.ozlabs.org (Postfix) with ESMTP id 46ygbl3Q0xzDqP9
	for <lists+linux-erofs@lfdr.de>; Wed, 23 Oct 2019 17:35:15 +1100 (AEDT)
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
 by lists.ozlabs.org (Postfix) with ESMTPS id 46ygbf5qXMzDqNT
 for <linux-erofs@lists.ozlabs.org>; Wed, 23 Oct 2019 17:35:10 +1100 (AEDT)
Received: from DGGEMS409-HUB.china.huawei.com (unknown [172.30.72.60])
 by Forcepoint Email with ESMTP id 70BA83A0A36F38F5F638;
 Wed, 23 Oct 2019 14:34:54 +0800 (CST)
Received: from architecture4.huawei.com (10.140.130.215) by smtp.huawei.com
 (10.3.19.209) with Microsoft SMTP Server (TLS) id 14.3.439.0; Wed, 23 Oct
 2019 14:34:46 +0800
From: Gao Xiang <gaoxiang25@huawei.com>
To: Li Guifu <bluce.liguifu@huawei.com>, <linux-erofs@lists.ozlabs.org>
Subject: [PATCH] erofs-utils: simplify prints in usage()
Date: Wed, 23 Oct 2019 14:37:18 +0800
Message-ID: <20191023063718.152278-1-gaoxiang25@huawei.com>
X-Mailer: git-send-email 2.17.1
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
Cc: Miao Xie <miaoxie@huawei.com>
Errors-To: linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org
Sender: "Linux-erofs"
 <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>

Use a single puts instead, trivial update.

Suggested-by: Li Guifu <bluce.liguifu@huawei.com>
Signed-off-by: Gao Xiang <gaoxiang25@huawei.com>
---
 mkfs/main.c | 18 +++++++++---------
 1 file changed, 9 insertions(+), 9 deletions(-)

diff --git a/mkfs/main.c b/mkfs/main.c
index 1161b3f0f7cc..ab57896e9ca8 100644
--- a/mkfs/main.c
+++ b/mkfs/main.c
@@ -44,15 +44,15 @@ static void print_available_compressors(FILE *f, const char *delim)
 
 static void usage(void)
 {
-	fprintf(stderr, "usage: [options] FILE DIRECTORY\n\n");
-	fprintf(stderr, "Generate erofs image from DIRECTORY to FILE, and [options] are:\n");
-	fprintf(stderr, " -zX[,Y]   X=compressor (Y=compression level, optional)\n");
-	fprintf(stderr, " -d#       set output message level to # (maximum 9)\n");
-	fprintf(stderr, " -x#       set xattr tolerance to # (< 0, disable xattrs; default 2)\n");
-	fprintf(stderr, " -EX[,...] X=extended options\n");
-	fprintf(stderr, " -T#       set a fixed UNIX timestamp # to all files\n");
-	fprintf(stderr, " --help    display this help and exit\n");
-	fprintf(stderr, "\nAvailable compressors are: ");
+	fputs("usage: [options] FILE DIRECTORY\n\n"
+	      "Generate erofs image from DIRECTORY to FILE, and [options] are:\n"
+	      " -zX[,Y]   X=compressor (Y=compression level, optional)\n"
+	      " -d#       set output message level to # (maximum 9)\n"
+	      " -x#       set xattr tolerance to # (< 0, disable xattrs; default 2)\n"
+	      " -EX[,...] X=extended options\n"
+	      " -T#       set a fixed UNIX timestamp # to all files\n"
+	      " --help    display this help and exit\n"
+	      "\nAvailable compressors are: ", stderr);
 	print_available_compressors(stderr, ", ");
 }
 
-- 
2.17.1

