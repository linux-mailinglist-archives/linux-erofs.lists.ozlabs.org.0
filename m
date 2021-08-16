Return-Path: <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>
X-Original-To: lists+linux-erofs@lfdr.de
Delivered-To: lists+linux-erofs@lfdr.de
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2404:9400:2:0:216:3eff:fee1:b9f1])
	by mail.lfdr.de (Postfix) with ESMTPS id 5BA753ED126
	for <lists+linux-erofs@lfdr.de>; Mon, 16 Aug 2021 11:41:40 +0200 (CEST)
Received: from boromir.ozlabs.org (localhost [IPv6:::1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4Gp8Lp16vFz30L2
	for <lists+linux-erofs@lfdr.de>; Mon, 16 Aug 2021 19:41:38 +1000 (AEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=lists.ozlabs.org;
	s=201707; t=1629106898;
	bh=VFtEPxpZP0a3Fvj6SBEUinfvLQDVnaTyYAHbwu6GsbE=;
	h=To:Subject:Date:List-Id:List-Unsubscribe:List-Archive:List-Post:
	 List-Help:List-Subscribe:From:Reply-To:Cc:From;
	b=M9QEyDsgB6tB5oYMPa6WSesG6TORvqrNj4dElD8FL8/W413BN+q2CQshHhi2lUTf6
	 3YiHZcgqSeIdGT6LHC4s4MswLTuFzw3xbAENFg4mVfqVB7TfgI7Evc3FOzWu+kuGHY
	 b0kB66jPRGyg1Yz8xmZRNlB9HXIUklJz2AXfiFpGaG86K37D+7yBsHrOmYrS6mvkNE
	 mUz9kyE+OlG25f7UzH2FKfulFt/LI9iNH9MnPPH77VsiDXk9pDAqJAPn6jP9WWmImb
	 QsXeK/nfrRLJsDqkW39hFzFIYUPBPMihQ33fhCqHde9WtKsUpjzhEENohNL6BL8/qD
	 Y7WzzrSzu6UYw==
X-Original-To: linux-erofs@lists.ozlabs.org
Delivered-To: linux-erofs@lists.ozlabs.org
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized)
 smtp.mailfrom=oppo.com (client-ip=40.107.131.48;
 helo=apc01-sg2-obe.outbound.protection.outlook.com;
 envelope-from=huangjianan@oppo.com; receiver=<UNKNOWN>)
Authentication-Results: lists.ozlabs.org; dkim=pass (1024-bit key;
 unprotected) header.d=oppo.com header.i=@oppo.com header.a=rsa-sha256
 header.s=selector1 header.b=cpW/8z0I; 
 dkim-atps=neutral
Received: from APC01-SG2-obe.outbound.protection.outlook.com
 (mail-eopbgr1310048.outbound.protection.outlook.com [40.107.131.48])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 4Gp8Ld0lXKz2yfZ
 for <linux-erofs@lists.ozlabs.org>; Mon, 16 Aug 2021 19:41:23 +1000 (AEST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=c6cCa77JX994Js45lmHNIAC5tZu0YCNLW7uAMk8DSVkurF6GxfOkeOmLvSZYnVrVd1RcsZ9n8B1Tc2zpcNOEpdHWlggrzaV/61hT9OCco0y6ZXh0decPHdINcApyNAKG3adnzt8BuRun3yUUu2+7rYv65whECJz3bwUNLZ8fGlUIqTeHbWW7wrNebRmlSY80ZgKbuZboT2xxirrdvAyc9szeJDsvyuNaNCn4VrnLwGiZImvXZzAr/iSLCaODClLEU4ZqZt3IrDsY73K2BrPg11Ou4qCzmIeP7ePWyUoIhp/9KuxTu23/9+pmc4HcZqSNPccDsMYjGD2lYTMzpRraGA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=VFtEPxpZP0a3Fvj6SBEUinfvLQDVnaTyYAHbwu6GsbE=;
 b=dO0aNnoGFROMZZ1UU5DxCDy8G7EihuVQ7ijqUGs6Pjgdc4S0htLLlGH9gb0/nzi4qMahfX39OPeb49yMAKp0MGfuGLUwnouGse0GAgV3Wcz1diFltkp7j3xXtcRuRPxFyE8nTaBGwwxWeVz9xvOTNQ1YS1t7Wz99JldkBSuPyxLlbNAjtvD05zB9RCqW4rQ0qD7gZuydxeRu9nf/MFsjllmlH7/e6nBKsV30KOR6yVxwr9+2ONHgo8v7us29o9OcNpG2ADzus+I2tQ8V1HHLQZX9qhJnGDfHxeVIsl3YPTkULXSEukL5kLyObBu1zT7F51RWlVnCezK9l2R90KsYaA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oppo.com; dmarc=pass action=none header.from=oppo.com;
 dkim=pass header.d=oppo.com; arc=none
Authentication-Results: lists.ozlabs.org; dkim=none (message not signed)
 header.d=none;lists.ozlabs.org; dmarc=none action=none header.from=oppo.com;
Received: from SG2PR02MB4108.apcprd02.prod.outlook.com (2603:1096:4:96::19) by
 SG2PR0201MB2206.apcprd02.prod.outlook.com (2603:1096:3:4::8) with
 Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.4415.17; Mon, 16 Aug 2021 09:40:59 +0000
Received: from SG2PR02MB4108.apcprd02.prod.outlook.com
 ([fe80::98eb:b373:a778:a6a5]) by SG2PR02MB4108.apcprd02.prod.outlook.com
 ([fe80::98eb:b373:a778:a6a5%7]) with mapi id 15.20.4415.023; Mon, 16 Aug 2021
 09:40:59 +0000
To: linux-erofs@lists.ozlabs.org
Subject: [PATCH] erofs-utils: support per-inode compress pcluster
Date: Mon, 16 Aug 2021 17:40:43 +0800
Message-Id: <20210816094043.43772-1-huangjianan@oppo.com>
X-Mailer: git-send-email 2.25.1
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: HK2PR02CA0133.apcprd02.prod.outlook.com
 (2603:1096:202:16::17) To SG2PR02MB4108.apcprd02.prod.outlook.com
 (2603:1096:4:96::19)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from localhost.localdomain (58.252.5.73) by
 HK2PR02CA0133.apcprd02.prod.outlook.com (2603:1096:202:16::17) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.4415.14 via Frontend Transport; Mon, 16 Aug 2021 09:40:57 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 8b2addff-625d-4920-2f65-08d96099f3b1
X-MS-TrafficTypeDiagnostic: SG2PR0201MB2206:
X-MS-Exchange-SharedMailbox-RoutingAgent-Processed: True
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <SG2PR0201MB220635437A2801149125D47CC3FD9@SG2PR0201MB2206.apcprd02.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:392;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: cVuuKpbW1uHUC6FPaKf55WZy1HVmtItkuIKpmX1cpJXSHYOEj/vAbVuQI4OGIs5HqoINchD+cBRD0Fuznd4W3w7YJ3/q0vkdAYyN/e2r7hKcJcq1iy6xhQjJrLdfctcE5qumDQhGheHxSOKxpaLAeuBxqgRtC62JP4BImx2zHB3Ct8/Os1coG7dkbrlRKpoaKObETfL1L1GdS2c6gDDa6QoVCpTOkcc7w5+oHfIDFLMWDPp+jeax3d06SncbGAmZMEaitSH8aq3iiVV8KBm9cKgJ8Qx9ysU6M2kUUSAROZD9mpbpAaDHAjNXClh/cHBcyE9Gj/FrGIQ7BNDnItqHOxpL1MS1Z/WnnQzdO49y6K+9jIhps8vEOaE3ZdvJIxCCv1jxk4Q09vIezM7wZlQW2iuKo7rUCtLy7kgQX4b78VpwDF4lum6e5xqgyxoaOxLWaCaZNoOxJbdDz7Sq5orx5RlavYPgU0nkDzN81Lq4Slikmq6E8agsBamk4gPmDUiSFzlkhNG/DTyR5/pXT792kK2h3JNRn9ysB0oZnAuhQbyKk0aZ9JeZteGuYv7yYnMIe7Ui4W/i8z0Ywl0QlD9+oOUI1TU8ZXpGtwwnp1sHQskLrRaZ7WFtW/XCRqrKIyAL3gbVu6O+2JKA/gqW6HflYahDt5pY5iLh2vJlC6bYZs7zjlFhDkfxaL2ykDfhn4zkvma+oxzywzIkdVk3sQw4WvzxpbyJ3TTSdoanVAuGxWA=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:SG2PR02MB4108.apcprd02.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(4636009)(366004)(39850400004)(136003)(346002)(376002)(396003)(107886003)(2906002)(5660300002)(38350700002)(66946007)(66476007)(66556008)(30864003)(6916009)(36756003)(4326008)(1076003)(38100700002)(83380400001)(8676002)(52116002)(86362001)(6506007)(186003)(956004)(2616005)(26005)(478600001)(6486002)(316002)(8936002)(6512007)(6666004)(11606007);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?lYydrIYV/GmGPX8e5sCJ6H7goq8E4hzHaaez5DpN+Gxiq0tFn7hMguFwzbYN?=
 =?us-ascii?Q?mK0j5c3nkQZdJEiq8ov5K9wWb6sHXrRFgZn8F9+mY7ryLljVHlpzcb2Jd66z?=
 =?us-ascii?Q?PeowOt5jBjePYPYXgl0l8c2VIlqJEV880JNILKdxKqHJMs4p5hpQVzYwAT5w?=
 =?us-ascii?Q?9ls0m664Gdkxhg3NUXnwpnun6cfwL6XcAYka6r3+0P6pprjnByL33iyj8gcP?=
 =?us-ascii?Q?mm4Z8WDLh5N4Y1u4ZzswtEWxuMLYyFgRMEHKfbbj9/QD0bz21IYkXE1QrBR9?=
 =?us-ascii?Q?1Cuk2vsEarzvPpHDK0BDgO8jZuZTwQbNY8h1HTwiRaODcMJMD2W1o0HXffQI?=
 =?us-ascii?Q?Af2Nnilw5+3PjzPAV3OirSTB3IDRDU6XqszXpu9K8ALcviRP8hNGPw2DQe50?=
 =?us-ascii?Q?EsOS1MGg2Kd2MGPxLdjzNghVDN9dl/DT07hSul6jvCL/bu3TEAMqUv2vonu5?=
 =?us-ascii?Q?q0SFcX/yVIDM/es4FjAenzh9m/7QHfnM+5i9HYWW/hTHc8Jdhye7X33EBZY0?=
 =?us-ascii?Q?utSZntPyHCgiMjurCdJfOW+cV59gF+dQXEWB91l5fkGip84WfL/q+M21q3jy?=
 =?us-ascii?Q?vpI+6C+9OK7jyR17pweIQ0oy/EEJHFCBQyaPLERdHlyLis4203Leo5YOEH7V?=
 =?us-ascii?Q?XFGIgc0E1oObaBb7OfVv9G0GFuIhx2nmhHXwVVcsqb5mQ3Auyph9nbUeC/YU?=
 =?us-ascii?Q?X1JeOBrAlDePaQdYka+Ed+4xV2x2Hkuf5lJClgx0h7S1L/JVSgWRYg7MKuLZ?=
 =?us-ascii?Q?IfYp8QUdUoGk5k/PHyxPMcaS/94ZMCmk0VZQefP2ZLpU+Z4J96K0b/WhzGqF?=
 =?us-ascii?Q?hWCHQTuKX3gznc/apjEcQrBsCVmHNLPk1S2nH2LRIPSq9xAkKVRbk9miyWKU?=
 =?us-ascii?Q?ibES6h6nhaf1KZaJnPmKUEjN3IOKM5ao7TTd5guvXxYgZekTvYKhhSBpBwYL?=
 =?us-ascii?Q?4LVeOrF3Qo+wVjaUiOCSNvjDIf/sDNUDksilRb82FhT9chT0ElJCW7nGKtZn?=
 =?us-ascii?Q?AN5WlkJpjxO1GIWzWtylgq97Fa5qwGaURcnZePyB4LVAgfbJRNUfn1LFMwTk?=
 =?us-ascii?Q?NmXTWNb2M8bYwDbU8v5Uq+zFClrrfgQtUDwt9Y/UYxTpfsxTgWUb53KM+ffJ?=
 =?us-ascii?Q?Ixh5DwJ//Dx+lbNAS742BDkl03hXsApBLxn6FGG+qoznnmBiFFSLlRezEkt1?=
 =?us-ascii?Q?xSMoKbmseTIwyq0RVCDfhzHoaoQs5j7fTt+u6k+CIU8X0ZlGLhIKS/QB/0FN?=
 =?us-ascii?Q?omfu5HySqgzQkMjGkxrjG5gS/y2P5YcG5aDQrSGVwvHLbv37/u6lOfEGjpsL?=
 =?us-ascii?Q?4h0QqflwlKZ/jmt+YfMfAs8c?=
X-OriginatorOrg: oppo.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 8b2addff-625d-4920-2f65-08d96099f3b1
X-MS-Exchange-CrossTenant-AuthSource: SG2PR02MB4108.apcprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 16 Aug 2021 09:40:58.9691 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: f1905eb1-c353-41c5-9516-62b4a54b5ee6
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 5yA6nwjDYIkuGn2ZqyqkRlU3Hjsnq3K/4jh/VkntQnnZ++yIw5N6er2Pd8o2HXiOhHKEY65SlI6VouXw+0HvEg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SG2PR0201MB2206
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
From: Huang Jianan via Linux-erofs <linux-erofs@lists.ozlabs.org>
Reply-To: Huang Jianan <huangjianan@oppo.com>
Cc: yh@oppo.com, kevin.liw@oppo.com, guoweichao@oppo.com, guanyuwei@oppo.com
Errors-To: linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org
Sender: "Linux-erofs"
 <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>

Add an option to configure per-inode compression strategy. Each line
of the file should be in the following form:

<Regular-expression> <pcluster-in-bytes>

When pcluster is 0, it means that the file shouldn't be compressed.

Signed-off-by: Huang Jianan <huangjianan@oppo.com>
---
 include/erofs/compress_rule.h |  25 ++++++++
 include/erofs/config.h        |   1 +
 include/erofs/internal.h      |   2 +
 lib/Makefile.am               |   5 +-
 lib/compress.c                |   4 ++
 lib/compress_rule.c           | 106 ++++++++++++++++++++++++++++++++++
 lib/inode.c                   |   7 +++
 man/mkfs.erofs.1              |   2 +
 mkfs/main.c                   |  31 +++++++---
 9 files changed, 172 insertions(+), 11 deletions(-)
 create mode 100644 include/erofs/compress_rule.h
 create mode 100644 lib/compress_rule.c

diff --git a/include/erofs/compress_rule.h b/include/erofs/compress_rule.h
new file mode 100644
index 0000000..2271ab6
--- /dev/null
+++ b/include/erofs/compress_rule.h
@@ -0,0 +1,25 @@
+/* SPDX-License-Identifier: GPL-2.0+ */
+/*
+ * erofs-utils/include/erofs/compress_rule.h
+ *
+ * Copyright (C), 2008-2021, OPPO Mobile Comm Corp., Ltd.
+ * Created by Huang Jianan <huangjianan@oppo.com>
+ */
+#ifndef __EROFS_COMPRESS_STRATEGY_H
+#define __EROFS_COMPRESS_STRATEGY_H
+
+#include "erofs/internal.h"
+#include <sys/types.h>
+#include <regex.h>
+
+struct erofs_compress_rule {
+	struct list_head list;
+
+	regex_t reg;
+	unsigned int c_pclusterblks;
+};
+
+unsigned int erofs_parse_pclusterblks(struct erofs_inode *inode);
+int erofs_load_compress_rule();
+#endif
+
diff --git a/include/erofs/config.h b/include/erofs/config.h
index 8124f3b..50812c9 100644
--- a/include/erofs/config.h
+++ b/include/erofs/config.h
@@ -62,6 +62,7 @@ struct erofs_configure {
 	u32 c_max_decompressed_extent_bytes;
 	u64 c_unix_timestamp;
 	u32 c_uid, c_gid;
+	char *compress_rule_file;
 #ifdef WITH_ANDROID
 	char *mount_point;
 	char *target_out_path;
diff --git a/include/erofs/internal.h b/include/erofs/internal.h
index 5583861..b9432f4 100644
--- a/include/erofs/internal.h
+++ b/include/erofs/internal.h
@@ -152,6 +152,8 @@ struct erofs_inode {
 	unsigned int xattr_isize;
 	unsigned int extent_isize;
 
+	unsigned int c_pclusterblks;
+
 	erofs_nid_t nid;
 	struct erofs_buffer_head *bh;
 	struct erofs_buffer_head *bh_inline, *bh_data;
diff --git a/lib/Makefile.am b/lib/Makefile.am
index b12e2c1..cab912d 100644
--- a/lib/Makefile.am
+++ b/lib/Makefile.am
@@ -17,11 +17,12 @@ noinst_HEADERS = $(top_srcdir)/include/erofs_fs.h \
       $(top_srcdir)/include/erofs/list.h \
       $(top_srcdir)/include/erofs/print.h \
       $(top_srcdir)/include/erofs/trace.h \
-      $(top_srcdir)/include/erofs/xattr.h
+      $(top_srcdir)/include/erofs/xattr.h \
+      $(top_srcdir)/include/erofs/compress_rule.h
 
 noinst_HEADERS += compressor.h
 liberofs_la_SOURCES = config.c io.c cache.c super.c inode.c xattr.c exclude.c \
-		      namei.c data.c compress.c compressor.c zmap.c decompress.c
+		      namei.c data.c compress.c compressor.c zmap.c decompress.c compress_rule.c
 liberofs_la_CFLAGS = -Wall -Werror -I$(top_srcdir)/include
 if ENABLE_LZ4
 liberofs_la_CFLAGS += ${LZ4_CFLAGS}
diff --git a/lib/compress.c b/lib/compress.c
index 40723a1..01f36d8 100644
--- a/lib/compress.c
+++ b/lib/compress.c
@@ -19,6 +19,7 @@
 #include "erofs/compress.h"
 #include "compressor.h"
 #include "erofs/block_list.h"
+#include "erofs/compress_rule.h"
 
 static struct erofs_compress compresshandle;
 static int compressionlevel;
@@ -158,6 +159,9 @@ static unsigned int z_erofs_get_max_pclusterblks(struct erofs_inode *inode)
 	if (cfg.c_random_pclusterblks)
 		return 1 + rand() % cfg.c_physical_clusterblks;
 #endif
+	if (cfg.compress_rule_file)
+		return erofs_parse_pclusterblks(inode);
+
 	return cfg.c_physical_clusterblks;
 }
 
diff --git a/lib/compress_rule.c b/lib/compress_rule.c
new file mode 100644
index 0000000..4ff6205
--- /dev/null
+++ b/lib/compress_rule.c
@@ -0,0 +1,106 @@
+// SPDX-License-Identifier: GPL-2.0+
+/*
+ * erofs-utils/lib/compress_rule.c
+ *
+ * Copyright (C), 2008-2021, OPPO Mobile Comm Corp., Ltd.
+ * Created by Huang Jianan <huangjianan@oppo.com>
+ */
+#include <string.h>
+#include <stdlib.h>
+#include "erofs/err.h"
+#include "erofs/list.h"
+#include "erofs/print.h"
+#include "erofs/compress_rule.h"
+
+static LIST_HEAD(compress_rule_head);
+
+static void dump_regerror(int errcode, const char *s, const regex_t *preg)
+{
+	char str[512];
+
+	regerror(errcode, preg, str, sizeof(str));
+	erofs_err("invalid regex %s (%s)\n", s, str);
+}
+
+static int erofs_insert_compress_rule(const char *s, unsigned int blks)
+{
+	struct erofs_compress_rule *r;
+	int ret = 0;
+
+	r = malloc(sizeof(struct erofs_compress_rule));
+	if (!r)
+		return -ENOMEM;
+
+	ret = regcomp(&r->reg, s, REG_EXTENDED|REG_NOSUB);
+	if (ret) {
+		dump_regerror(ret, s, &r->reg);
+		goto err;
+	}
+	r->c_pclusterblks = blks;
+
+	list_add_tail(&r->list, &compress_rule_head);
+	erofs_info("insert compress rule %s: %u", s, blks);
+	return ret;
+
+err:
+	free(r);
+	return ret;
+}
+
+unsigned int erofs_parse_pclusterblks(struct erofs_inode *inode)
+{
+	const char *s;
+	struct erofs_compress_rule *r;
+
+	if (inode->c_pclusterblks)
+		return inode->c_pclusterblks;
+
+	s = erofs_fspath(inode->i_srcpath);
+
+	list_for_each_entry(r, &compress_rule_head, list) {
+		int ret = regexec(&r->reg, s, (size_t)0, NULL, 0);
+
+		if (!ret) {
+			inode->c_pclusterblks = r->c_pclusterblks;
+			return r->c_pclusterblks;
+		}
+		if (ret > REG_NOMATCH)
+			dump_regerror(ret, s, &r->reg);
+	}
+
+	inode->c_pclusterblks = cfg.c_physical_clusterblks;
+	return cfg.c_physical_clusterblks;
+}
+
+int erofs_load_compress_rule()
+{
+	char buf[PATH_MAX + 100];
+	FILE* f;
+	int ret = 0;
+
+	if (!cfg.compress_rule_file)
+		return 0;
+
+	f = fopen(cfg.compress_rule_file, "r");
+	if (f == NULL)
+		return -errno;
+
+	while (fgets(buf, sizeof(buf), f)) {
+		char* line = buf;
+		char* s;
+		unsigned int blks;
+
+		s = strtok(line, " ");
+		blks = atoi(strtok(NULL, " "));
+		if (blks % EROFS_BLKSIZ) {
+			erofs_err("invalid physical clustersize %u", blks);
+			ret = -EINVAL;
+			goto out;
+		}
+		erofs_insert_compress_rule(s, blks / EROFS_BLKSIZ);
+	}
+
+out:
+	fclose(f);
+	return ret;
+}
diff --git a/lib/inode.c b/lib/inode.c
index 6871d2b..174fb8a 100644
--- a/lib/inode.c
+++ b/lib/inode.c
@@ -25,6 +25,7 @@
 #include "erofs/xattr.h"
 #include "erofs/exclude.h"
 #include "erofs/block_list.h"
+#include "erofs/compress_rule.h"
 
 #define S_SHIFT                 12
 static unsigned char erofs_ftype_by_mode[S_IFMT >> S_SHIFT] = {
@@ -329,6 +330,10 @@ static int erofs_write_file_from_buffer(struct erofs_inode *inode, char *buf)
 /* rules to decide whether a file could be compressed or not */
 static bool erofs_file_is_compressible(struct erofs_inode *inode)
 {
+	/* pclusterblks is 0 means this file shouldn't be compressed */
+	if (cfg.compress_rule_file)
+		return erofs_parse_pclusterblks(inode);
+
 	return true;
 }
 
@@ -854,6 +859,8 @@ static struct erofs_inode *erofs_new_inode(void)
 	inode->xattr_isize = 0;
 	inode->extent_isize = 0;
 
+	inode->c_pclusterblks = 0;
+
 	inode->bh = inode->bh_inline = inode->bh_data = NULL;
 	inode->idata = NULL;
 	return inode;
diff --git a/man/mkfs.erofs.1 b/man/mkfs.erofs.1
index d164fa5..42fb663 100644
--- a/man/mkfs.erofs.1
+++ b/man/mkfs.erofs.1
@@ -88,6 +88,8 @@ Display this help and exit.
 .TP
 .B \-\-max-extent-bytes #
 Specify maximum decompressed extent size # in bytes.
+.BI "\-\-compress-rule" file
+Specify a file to configure per-file compression strategy.
 .SH AUTHOR
 This version of \fBmkfs.erofs\fR is written by Li Guifu <blucerlee@gmail.com>,
 Miao Xie <miaoxie@huawei.com> and Gao Xiang <xiang@kernel.org> with
diff --git a/mkfs/main.c b/mkfs/main.c
index 10fe14d..467e875 100644
--- a/mkfs/main.c
+++ b/mkfs/main.c
@@ -23,6 +23,7 @@
 #include "erofs/xattr.h"
 #include "erofs/exclude.h"
 #include "erofs/block_list.h"
+#include "erofs/compress_rule.h"
 
 #ifdef HAVE_LIBUUID
 #include <uuid.h>
@@ -44,11 +45,12 @@ static struct option long_options[] = {
 	{"random-pclusterblks", no_argument, NULL, 8},
 #endif
 	{"max-extent-bytes", required_argument, NULL, 9},
+	{"compress-rule", required_argument, NULL, 10},
 #ifdef WITH_ANDROID
-	{"mount-point", required_argument, NULL, 10},
-	{"product-out", required_argument, NULL, 11},
-	{"fs-config-file", required_argument, NULL, 12},
-	{"block-list-file", required_argument, NULL, 13},
+	{"mount-point", required_argument, NULL, 20},
+	{"product-out", required_argument, NULL, 21},
+	{"fs-config-file", required_argument, NULL, 22},
+	{"block-list-file", required_argument, NULL, 23},
 #endif
 	{0, 0, 0, 0},
 };
@@ -89,6 +91,7 @@ static void usage(void)
 	      " --all-root            make all files owned by root\n"
 	      " --help                display this help and exit\n"
 	      " --max-extent-bytes=#  set maximum decompressed extent size # in bytes\n"
+	      " --compress-rule=X     specify a file to configure per-file compression strategy\n"
 #ifndef NDEBUG
 	      " --random-pclusterblks randomize pclusterblks for big pcluster (debugging only)\n"
 #endif
@@ -97,7 +100,7 @@ static void usage(void)
 	      " --mount-point=X       X=prefix of target fs path (default: /)\n"
 	      " --product-out=X       X=product_out directory\n"
 	      " --fs-config-file=X    X=fs_config file\n"
-	      " --block-list-file=X    X=block_list file\n"
+	      " --block-list-file=X   X=block_list file\n"
 #endif
 	      "\nAvailable compressors are: ", stderr);
 	print_available_compressors(stderr, ", ");
@@ -288,21 +291,24 @@ static int mkfs_parse_options_cfg(int argc, char *argv[])
 				return -EINVAL;
 			}
 			break;
-#ifdef WITH_ANDROID
 		case 10:
+			cfg.compress_rule_file = optarg;
+			break;
+#ifdef WITH_ANDROID
+		case 20:
 			cfg.mount_point = optarg;
 			/* all trailing '/' should be deleted */
 			opt = strlen(cfg.mount_point);
 			if (opt && optarg[opt - 1] == '/')
 				optarg[opt - 1] = '\0';
 			break;
-		case 11:
+		case 21:
 			cfg.target_out_path = optarg;
 			break;
-		case 12:
+		case 22:
 			cfg.fs_config_file = optarg;
 			break;
-		case 13:
+		case 23:
 			cfg.block_list_file = optarg;
 			break;
 #endif
@@ -587,6 +593,13 @@ int main(int argc, char **argv)
 		goto exit;
 	}
 
+	err = erofs_load_compress_rule();
+	if (err) {
+		erofs_err("Failed to load compress rule %s",
+			  cfg.compress_rule_file);
+		goto exit;
+	}
+
 #ifdef HAVE_LIBUUID
 	uuid_unparse_lower(sbi.uuid, uuid_str);
 #endif
-- 
2.25.1

