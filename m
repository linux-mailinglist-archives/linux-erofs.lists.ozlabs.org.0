Return-Path: <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>
X-Original-To: lists+linux-erofs@lfdr.de
Delivered-To: lists+linux-erofs@lfdr.de
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2404:9400:2:0:216:3eff:fee1:b9f1])
	by mail.lfdr.de (Postfix) with ESMTPS id 7532C3F6DB7
	for <lists+linux-erofs@lfdr.de>; Wed, 25 Aug 2021 05:36:34 +0200 (CEST)
Received: from boromir.ozlabs.org (localhost [IPv6:::1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4GvWqF0tpYz2yK3
	for <lists+linux-erofs@lfdr.de>; Wed, 25 Aug 2021 13:36:25 +1000 (AEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=lists.ozlabs.org;
	s=201707; t=1629862585;
	bh=elIvqDTwHVMqehqq7b/GjctFtalhK9Nus06ChhDCGLQ=;
	h=To:Subject:Date:In-Reply-To:References:List-Id:List-Unsubscribe:
	 List-Archive:List-Post:List-Help:List-Subscribe:From:Reply-To:Cc:
	 From;
	b=gM1tjkdrSO0R0lx2XrwnZott8Utr4NK15fSPwrX1e8gWZ1W+zfBtmqlun7KTPgfcM
	 Bt7ercGHBtyeoGacQ5RgLrCeOW5MvnPUyxdFTIXL2G7/Jra1aX2lkVXmj4J2fW0laq
	 dzBB09blH8Of0DxbFA1jjcoeEphC90X7hhqKuYBTBRjPCiKtS0XJzodbHn1uegUn45
	 Hr+YyMALQZ/saS0ja1jAqRb679dhEakbcdoppTu+6ITucASdZJCwdkHxqkMAQ5URs1
	 cT/f8Z+QJzNXSoRcmDWiqFsoHNkOyye7rRat06pUX95OVSe1seTZygTSzzMsA03lZf
	 vf81QEvPuy7zQ==
X-Original-To: linux-erofs@lists.ozlabs.org
Delivered-To: linux-erofs@lists.ozlabs.org
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized)
 smtp.mailfrom=oppo.com (client-ip=40.107.131.79;
 helo=apc01-sg2-obe.outbound.protection.outlook.com;
 envelope-from=huangjianan@oppo.com; receiver=<UNKNOWN>)
Authentication-Results: lists.ozlabs.org; dkim=pass (1024-bit key;
 unprotected) header.d=oppo.com header.i=@oppo.com header.a=rsa-sha256
 header.s=selector1 header.b=O+xqKOh7; 
 dkim-atps=neutral
Received: from APC01-SG2-obe.outbound.protection.outlook.com
 (mail-eopbgr1310079.outbound.protection.outlook.com [40.107.131.79])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 4GvWq815sjz2xr3
 for <linux-erofs@lists.ozlabs.org>; Wed, 25 Aug 2021 13:36:18 +1000 (AEST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=S587zQ5osKUM90xd2dTSB4tI9hEclitFPzicrYL+8R62Z7nErRautS86n8yyj9l52KsWZTdMOg6qkhtgA/biq1ewFlKX5X+g89XSpdMTP4GPQkQIhHhXP6qEr32XxFzICZCs3tPmL+NY4l2a1y9C75vHsGWVSxcix4janfCj8xqRuP9N5SKkFDxbJN7BWtUPwETFEd7rhcuNdnOTAlraTi2Rb6oVDggD0qSy5nYMKiHEZBVuMTrkViWCmACjz8Trw4x+4ozklNMQ1tIgD9ZVyBwUAAqW47WvDVAL9xI2l/nXYjzOnHPtenpL6aet1BkPa2SgI7UWFZSnS1lqcG/N9Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=elIvqDTwHVMqehqq7b/GjctFtalhK9Nus06ChhDCGLQ=;
 b=Kgw0KoiqtaXsBDYeXSrqPDOeRF/r1fK2ThKGeKs3sPkk9/ltRusPaeimHIAcZWvMqs6DWA2iV6H2mR27wn//gfcQ1qoDNJaL/mPCRIasLFnaz9q7o9hzD84+7f92gtBoaUqbHJf/R2tOzb19Jhz13T1Pbv3ymhn9aRzDLAx+3BwDCZYCYTdjmHt5W5iXObm8yeh0ifWdaClkJk0n/CFl+7PBM8T7HT6Qb7z5JuXRPHW52fX8KUAnVk3tJismpiSqOYFJUjSwPFMOAXho38QlsSRfUUzrOYUC5DAavquW+dbOcHFeto5cL2upQQHzYrfa2zzsx+NNXJ0FzZGFS1DjJA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oppo.com; dmarc=pass action=none header.from=oppo.com;
 dkim=pass header.d=oppo.com; arc=none
Authentication-Results: lists.ozlabs.org; dkim=none (message not signed)
 header.d=none;lists.ozlabs.org; dmarc=none action=none header.from=oppo.com;
Received: from SG2PR02MB4108.apcprd02.prod.outlook.com (2603:1096:4:96::19) by
 SG2PR02MB2858.apcprd02.prod.outlook.com (2603:1096:4:5d::10) with
 Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.4436.23; Wed, 25 Aug 2021 03:35:32 +0000
Received: from SG2PR02MB4108.apcprd02.prod.outlook.com
 ([fe80::98eb:b373:a778:a6a5]) by SG2PR02MB4108.apcprd02.prod.outlook.com
 ([fe80::98eb:b373:a778:a6a5%7]) with mapi id 15.20.4436.024; Wed, 25 Aug 2021
 03:35:32 +0000
To: linux-erofs@lists.ozlabs.org
Subject: [PATCH v3] erofs-utils: support per-inode compress pcluster
Date: Wed, 25 Aug 2021 11:35:23 +0800
Message-Id: <20210825033523.20058-1-huangjianan@oppo.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20210818042715.24416-1-huangjianan@oppo.com>
References: <20210818042715.24416-1-huangjianan@oppo.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: HKAPR03CA0027.apcprd03.prod.outlook.com
 (2603:1096:203:c9::14) To SG2PR02MB4108.apcprd02.prod.outlook.com
 (2603:1096:4:96::19)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from PC80253450.adc.com (58.252.5.73) by
 HKAPR03CA0027.apcprd03.prod.outlook.com (2603:1096:203:c9::14) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.4457.6 via Frontend Transport; Wed, 25 Aug 2021 03:35:30 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 5b64ef2f-1a6f-4cb6-1bd3-08d967796418
X-MS-TrafficTypeDiagnostic: SG2PR02MB2858:
X-MS-Exchange-SharedMailbox-RoutingAgent-Processed: True
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <SG2PR02MB2858FCD42B5E820A302FE09EC3C69@SG2PR02MB2858.apcprd02.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:392;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: T2T8SlrjLpPoK1WO+Q4BbgkgN+ZmAGkFv+OUWlLtQFdAIyhLZuxLsaYxOIqZPxB8TXsTH3scTli/4VRt5xy/bYe6ugomUYVGz1Mj4b0ziqqdeBnz2VZLkZSrjELKCpktzaARmCAvTvaHdr6jrChTXg5mpx4nppKzmGFww1Xe5cWY3MrG4CSU0E/C5xeNbGLk1nBI9IBLPShu8AhM4CuT1qQCVU7F7eYAesHmPBmBlT0BR5EddLch6XR5Q2gUOawMWIPQyqR82sdcjPFe11SF9jeGs1ZmAJTgipi4fbWlCQWA/DaNLCzt7Syu7STGY2i0+2sXy3YY75pRkgYbSZC41XCH0r5MY/r7s7yrThI8D+7CV7z44NCAPJgKmijfURBsIiBMR2psX/ukifeyBKwA+3mbARWsoagmUS9meYMoYZnwAkDCKL1ScZYVu6Li+zuaFdumDpyDTG2y32ACWLV620Nl9Bvpl4UclTDtmKg2C/mZKXvLLS8LBgw42baEreUIWpYGUX0UNZXyt2JT3YjwtgEYNAz+NYotG+Pq+cWZTZXtZ/8pnPZMZ8xnK19nG3alEzaMnJY9oyKQWTcrQLpODi9VkfbHz9uKmsRqFg8KAeccj53sMyZG956pXPkEvABBzqneHD3AB+7ShbIQzoV3FXqthUuA6HHN8DqVQsqTZHEwrO6EMbvMKK1Gfa83RnGOBuG8wlN1Xhj92BG5NFHdSe0t1StW0hRXcJxu3HhXmuasEZNsViXI+CjFiNqizhY6
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:SG2PR02MB4108.apcprd02.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(4636009)(396003)(39860400002)(376002)(136003)(366004)(346002)(6486002)(86362001)(66946007)(6512007)(36756003)(52116002)(316002)(478600001)(66556008)(66476007)(83380400001)(107886003)(2616005)(956004)(5660300002)(6506007)(186003)(2906002)(30864003)(8936002)(6666004)(1076003)(4326008)(38350700002)(38100700002)(26005)(8676002)(6916009)(11606007)(21314003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?hofxZwZIdtGDZeqzPqe3z5GXrL6qDnVc+fiW9/q4cGFzSpa1aRy/QENoV21i?=
 =?us-ascii?Q?NANHiZdwP7z/zFYg/TgUvMieiozeFsnsd05rC1HIjvsCBbmwqpev45U/IDsV?=
 =?us-ascii?Q?T2XJgVZ72RafP2eTTixJmNp48nyJjh0s3+/jlH8MuPeTUwTHR2jPR0xC4IZN?=
 =?us-ascii?Q?V1B5Aqm36cUX+1MR6hn2G87v09HRDBznuIeGzCYcZQ3FaYFy2BjNcIIDEzVn?=
 =?us-ascii?Q?8kFOE7vmGKswePu5qPrxITbMDraSWumz3pFn9rO7j/BG66dyp3TFWYSh9+9S?=
 =?us-ascii?Q?CGt8SuJihRDll/SwTa+zrHVIPfj3kGk5DKTv7ZJaVXLwTChTWhPuaxiK27Nm?=
 =?us-ascii?Q?wEchQenOTqgGhP5X9EaIfB3UaBZHgKD82Cz6+Sxu23Ur2WTfOnwcW/67/iQK?=
 =?us-ascii?Q?zvvni1hUGzYAzpJuKp8zmHlk6KYET8a7lLkUnuXObb4386VCtnzzdBQ/Ml3S?=
 =?us-ascii?Q?rDY6hUf30OLbD3VhOZ18KUgRd1JwnO/+SN2mvyPS9igZuqZaxVf4Vz3ZWTAm?=
 =?us-ascii?Q?tiZkbMbzY8cU0zjqrkLZcr0hoVKaZJWa9pWPotrQfHkf0JUcdh3+lauil+xD?=
 =?us-ascii?Q?p8C2MsYS0pdmN7mS5MwGkdTMwOSomxzl7IhVzGXeh6iZwN1M4zmKKTS5CpZf?=
 =?us-ascii?Q?hVIVtVEFYbeKej/JgULaWkA4HW3d6isE+tXRujmrIcfkOC0kRXCe2slXo+tc?=
 =?us-ascii?Q?bXFxXi14xwzpDw1RNIvcmjdSKm40/So3thoNnn9Z0YeUTzBofkmaTbXuBwiN?=
 =?us-ascii?Q?QevvVjDIfYOInWVfWLIb2Eot9lWv/xhYJQk01miug7GfyG+lFce0KYr51nYa?=
 =?us-ascii?Q?l0MlrZ0ISYrqQ/Gv53MS3viPVYpYkL7F+NFn0TfVeAaKGvS5tkzW+fBf7ZPE?=
 =?us-ascii?Q?NbkK3L0SD3l6OizXlRbX22m6tvaOIuEQe4GypKowryb1HWq/A3a7ErHS9JFJ?=
 =?us-ascii?Q?4ACGbbbw2SjzPgmPsZG8IWvjdmuA7E5Pnm6Shx36WCgQdbH8yBjuGdgLab8R?=
 =?us-ascii?Q?FGo4gAXa8xi3QtKP74izGsno1TiXgzeKWFmYdDNsZiBeS6+QX+etBmVyDmXv?=
 =?us-ascii?Q?yJDsWJuocsQUQvlMg1RkbcOo3UCoqK5NLEOi7eUpw/fZVO01b+N63Y/MR5NF?=
 =?us-ascii?Q?fL8NHd6jbuvyhl97HIlhlhiVVuQyUOXA7PHRSnc+3TKpLBUGNrNutpMygV38?=
 =?us-ascii?Q?eiTv8HLDW7GhDh9ClBl9SZpXJsrWddN2oKSeWiT0ZG/IKuYrZ2qTHal23zNn?=
 =?us-ascii?Q?F+zcsJp49Ed/rYxecEeD0b/VhwLa2UVygwf+UBbBY66iIt8IGGStNRYkfyja?=
 =?us-ascii?Q?KyTHnK8ZLiv56WdPW32G9AUt?=
X-OriginatorOrg: oppo.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 5b64ef2f-1a6f-4cb6-1bd3-08d967796418
X-MS-Exchange-CrossTenant-AuthSource: SG2PR02MB4108.apcprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 25 Aug 2021 03:35:32.4417 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: f1905eb1-c353-41c5-9516-62b4a54b5ee6
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: hn2GvWD5jaHeeZx1KB8BlS1fs1LHGtow9qxCOtVC1tPICJEJXaUifFOmk8RI6LdpaO1y5kQoEihpUemlxkH4aw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SG2PR02MB2858
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
changes since v2:
 - change compress_rule to compress_hints for better understanding. (Gao Xiang)
 - use default "-C" value when input physical clustersize is invalid. (Gao Xiang)
 - change the val of WITH_ANDROID option to a separated patch. (Gao Xiang)

changes since v1:
 - rename c_pclusterblks to c_physical_clusterblks and place it in union.
 - change cfg.c_physical_clusterblks > 1 to erofs_sb_has_big_pcluster() since
   it's per-inode compression strategy.

 include/erofs/compress_hints.h |  25 ++++++++
 include/erofs/config.h         |   1 +
 include/erofs/internal.h       |   1 +
 lib/Makefile.am                |   5 +-
 lib/compress.c                 |  10 ++--
 lib/compress_hints.c           | 105 +++++++++++++++++++++++++++++++++
 lib/inode.c                    |   6 ++
 man/mkfs.erofs.1               |   2 +
 mkfs/main.c                    |  15 ++++-
 9 files changed, 163 insertions(+), 7 deletions(-)
 create mode 100644 include/erofs/compress_hints.h
 create mode 100644 lib/compress_hints.c

diff --git a/include/erofs/compress_hints.h b/include/erofs/compress_hints.h
new file mode 100644
index 0000000..2937b39
--- /dev/null
+++ b/include/erofs/compress_hints.h
@@ -0,0 +1,25 @@
+/* SPDX-License-Identifier: GPL-2.0+ */
+/*
+ * erofs-utils/include/erofs/compress_hints.h
+ *
+ * Copyright (C), 2008-2021, OPPO Mobile Comm Corp., Ltd.
+ * Created by Huang Jianan <huangjianan@oppo.com>
+ */
+#ifndef __EROFS_COMPRESS_HINTS_H
+#define __EROFS_COMPRESS_HINTS_H
+
+#include "erofs/internal.h"
+#include <sys/types.h>
+#include <regex.h>
+
+struct erofs_compress_hints {
+	struct list_head list;
+
+	regex_t reg;
+	unsigned int c_physical_clusterblks;
+};
+
+unsigned int erofs_parse_pclusterblks(struct erofs_inode *inode);
+int erofs_load_compress_hints();
+#endif
+
diff --git a/include/erofs/config.h b/include/erofs/config.h
index 8124f3b..399da41 100644
--- a/include/erofs/config.h
+++ b/include/erofs/config.h
@@ -62,6 +62,7 @@ struct erofs_configure {
 	u32 c_max_decompressed_extent_bytes;
 	u64 c_unix_timestamp;
 	u32 c_uid, c_gid;
+	char *compress_hints_file;
 #ifdef WITH_ANDROID
 	char *mount_point;
 	char *target_out_path;
diff --git a/include/erofs/internal.h b/include/erofs/internal.h
index 5583861..4da30b3 100644
--- a/include/erofs/internal.h
+++ b/include/erofs/internal.h
@@ -164,6 +164,7 @@ struct erofs_inode {
 			uint16_t z_advise;
 			uint8_t  z_algorithmtype[2];
 			uint8_t  z_logical_clusterbits;
+			uint8_t  c_physical_clusterblks;
 		};
 	};
 #ifdef WITH_ANDROID
diff --git a/lib/Makefile.am b/lib/Makefile.am
index b12e2c1..e1b677b 100644
--- a/lib/Makefile.am
+++ b/lib/Makefile.am
@@ -17,11 +17,12 @@ noinst_HEADERS = $(top_srcdir)/include/erofs_fs.h \
       $(top_srcdir)/include/erofs/list.h \
       $(top_srcdir)/include/erofs/print.h \
       $(top_srcdir)/include/erofs/trace.h \
-      $(top_srcdir)/include/erofs/xattr.h
+      $(top_srcdir)/include/erofs/xattr.h \
+      $(top_srcdir)/include/erofs/compress_hints.h
 
 noinst_HEADERS += compressor.h
 liberofs_la_SOURCES = config.c io.c cache.c super.c inode.c xattr.c exclude.c \
-		      namei.c data.c compress.c compressor.c zmap.c decompress.c
+		      namei.c data.c compress.c compressor.c zmap.c decompress.c compress_hints.c
 liberofs_la_CFLAGS = -Wall -Werror -I$(top_srcdir)/include
 if ENABLE_LZ4
 liberofs_la_CFLAGS += ${LZ4_CFLAGS}
diff --git a/lib/compress.c b/lib/compress.c
index a8ebbc1..2d93a10 100644
--- a/lib/compress.c
+++ b/lib/compress.c
@@ -19,6 +19,7 @@
 #include "erofs/compress.h"
 #include "compressor.h"
 #include "erofs/block_list.h"
+#include "erofs/compress_hints.h"
 
 static struct erofs_compress compresshandle;
 static int compressionlevel;
@@ -91,8 +92,7 @@ static void vle_write_indexes(struct z_erofs_vle_compress_ctx *ctx,
 	}
 
 	do {
-		/* XXX: big pcluster feature should be per-inode */
-		if (d0 == 1 && cfg.c_physical_clusterblks > 1) {
+		if (d0 == 1 && erofs_sb_has_big_pcluster()) {
 			type = Z_EROFS_VLE_CLUSTER_TYPE_NONHEAD;
 			di.di_u.delta[0] = cpu_to_le16(ctx->compressedblks |
 					Z_EROFS_VLE_DI_D0_CBLKCNT);
@@ -151,13 +151,15 @@ static int write_uncompressed_extent(struct z_erofs_vle_compress_ctx *ctx,
 	return count;
 }
 
-/* TODO: apply per-(sub)file strategies here */
 static unsigned int z_erofs_get_max_pclusterblks(struct erofs_inode *inode)
 {
 #ifndef NDEBUG
 	if (cfg.c_random_pclusterblks)
 		return 1 + rand() % cfg.c_physical_clusterblks;
 #endif
+	if (cfg.compress_hints_file)
+		return erofs_parse_pclusterblks(inode);
+
 	return cfg.c_physical_clusterblks;
 }
 
@@ -496,7 +498,7 @@ int erofs_write_compressed_file(struct erofs_inode *inode)
 		inode->datalayout = EROFS_INODE_FLAT_COMPRESSION_LEGACY;
 	}
 
-	if (cfg.c_physical_clusterblks > 1) {
+	if (erofs_sb_has_big_pcluster()) {
 		inode->z_advise |= Z_EROFS_ADVISE_BIG_PCLUSTER_1;
 		if (inode->datalayout == EROFS_INODE_FLAT_COMPRESSION)
 			inode->z_advise |= Z_EROFS_ADVISE_BIG_PCLUSTER_2;
diff --git a/lib/compress_hints.c b/lib/compress_hints.c
new file mode 100644
index 0000000..bc29ebd
--- /dev/null
+++ b/lib/compress_hints.c
@@ -0,0 +1,105 @@
+// SPDX-License-Identifier: GPL-2.0+
+/*
+ * erofs-utils/lib/compress_hints.c
+ *
+ * Copyright (C), 2008-2021, OPPO Mobile Comm Corp., Ltd.
+ * Created by Huang Jianan <huangjianan@oppo.com>
+ */
+#include <string.h>
+#include <stdlib.h>
+#include "erofs/err.h"
+#include "erofs/list.h"
+#include "erofs/print.h"
+#include "erofs/compress_hints.h"
+
+static LIST_HEAD(compress_hints_head);
+
+static void dump_regerror(int errcode, const char *s, const regex_t *preg)
+{
+	char str[512];
+
+	regerror(errcode, preg, str, sizeof(str));
+	erofs_err("invalid regex %s (%s)\n", s, str);
+}
+
+static int erofs_insert_compress_hints(const char *s, unsigned int blks)
+{
+	struct erofs_compress_hints *r;
+	int ret = 0;
+
+	r = malloc(sizeof(struct erofs_compress_hints));
+	if (!r)
+		return -ENOMEM;
+
+	ret = regcomp(&r->reg, s, REG_EXTENDED|REG_NOSUB);
+	if (ret) {
+		dump_regerror(ret, s, &r->reg);
+		goto err;
+	}
+	r->c_physical_clusterblks = blks;
+
+	list_add_tail(&r->list, &compress_hints_head);
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
+	struct erofs_compress_hints *r;
+
+	if (inode->c_physical_clusterblks)
+		return inode->c_physical_clusterblks;
+
+	s = erofs_fspath(inode->i_srcpath);
+
+	list_for_each_entry(r, &compress_hints_head, list) {
+		int ret = regexec(&r->reg, s, (size_t)0, NULL, 0);
+
+		if (!ret) {
+			inode->c_physical_clusterblks = r->c_physical_clusterblks;
+			return r->c_physical_clusterblks;
+		}
+		if (ret > REG_NOMATCH)
+			dump_regerror(ret, s, &r->reg);
+	}
+
+	inode->c_physical_clusterblks = cfg.c_physical_clusterblks;
+	return cfg.c_physical_clusterblks;
+}
+
+int erofs_load_compress_hints()
+{
+	char buf[PATH_MAX + 100];
+	FILE* f;
+
+	if (!cfg.compress_hints_file)
+		return 0;
+
+	f = fopen(cfg.compress_hints_file, "r");
+	if (f == NULL)
+		return -errno;
+
+	while (fgets(buf, sizeof(buf), f)) {
+		char* line = buf;
+		char* s;
+		unsigned int pclustersize;
+
+		s = strtok(line, " ");
+		pclustersize = atoi(strtok(NULL, " "));
+		if (pclustersize % EROFS_BLKSIZ) {
+			erofs_warn("invalid physical clustersize %u, "
+				   "use default c_physical_clusterblks %u",
+				   pclustersize, cfg.c_physical_clusterblks);
+			continue;
+		}
+		erofs_insert_compress_hints(s, pclustersize / EROFS_BLKSIZ);
+	}
+
+	fclose(f);
+	return 0;
+}
diff --git a/lib/inode.c b/lib/inode.c
index 6871d2b..f2ac30a 100644
--- a/lib/inode.c
+++ b/lib/inode.c
@@ -25,6 +25,7 @@
 #include "erofs/xattr.h"
 #include "erofs/exclude.h"
 #include "erofs/block_list.h"
+#include "erofs/compress_hints.h"
 
 #define S_SHIFT                 12
 static unsigned char erofs_ftype_by_mode[S_IFMT >> S_SHIFT] = {
@@ -329,6 +330,10 @@ static int erofs_write_file_from_buffer(struct erofs_inode *inode, char *buf)
 /* rules to decide whether a file could be compressed or not */
 static bool erofs_file_is_compressible(struct erofs_inode *inode)
 {
+	/* pclusterblks is 0 means this file shouldn't be compressed */
+	if (cfg.compress_hints_file)
+		return erofs_parse_pclusterblks(inode);
+
 	return true;
 }
 
@@ -856,6 +861,7 @@ static struct erofs_inode *erofs_new_inode(void)
 
 	inode->bh = inode->bh_inline = inode->bh_data = NULL;
 	inode->idata = NULL;
+	inode->c_physical_clusterblks = 0;
 	return inode;
 }
 
diff --git a/man/mkfs.erofs.1 b/man/mkfs.erofs.1
index d164fa5..7f36146 100644
--- a/man/mkfs.erofs.1
+++ b/man/mkfs.erofs.1
@@ -88,6 +88,8 @@ Display this help and exit.
 .TP
 .B \-\-max-extent-bytes #
 Specify maximum decompressed extent size # in bytes.
+.BI "\-\-compress-hints" file
+Specify a file to configure per-file compression strategy.
 .SH AUTHOR
 This version of \fBmkfs.erofs\fR is written by Li Guifu <blucerlee@gmail.com>,
 Miao Xie <miaoxie@huawei.com> and Gao Xiang <xiang@kernel.org> with
diff --git a/mkfs/main.c b/mkfs/main.c
index 9369b72..dbe49ec 100644
--- a/mkfs/main.c
+++ b/mkfs/main.c
@@ -23,6 +23,7 @@
 #include "erofs/xattr.h"
 #include "erofs/exclude.h"
 #include "erofs/block_list.h"
+#include "erofs/compress_hints.h"
 
 #ifdef HAVE_LIBUUID
 #include <uuid.h>
@@ -44,6 +45,7 @@ static struct option long_options[] = {
 	{"random-pclusterblks", no_argument, NULL, 8},
 #endif
 	{"max-extent-bytes", required_argument, NULL, 9},
+	{"compress-hints", required_argument, NULL, 10},
 #ifdef WITH_ANDROID
 	{"mount-point", required_argument, NULL, 256},
 	{"product-out", required_argument, NULL, 257},
@@ -89,6 +91,7 @@ static void usage(void)
 	      " --all-root            make all files owned by root\n"
 	      " --help                display this help and exit\n"
 	      " --max-extent-bytes=#  set maximum decompressed extent size # in bytes\n"
+	      " --compress-hints=X    specify a file to configure per-file compression strategy\n"
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
@@ -288,6 +291,9 @@ static int mkfs_parse_options_cfg(int argc, char *argv[])
 				return -EINVAL;
 			}
 			break;
+		case 10:
+			cfg.compress_hints_file = optarg;
+			break;
 #ifdef WITH_ANDROID
 		case 256:
 			cfg.mount_point = optarg;
@@ -587,6 +593,13 @@ int main(int argc, char **argv)
 		goto exit;
 	}
 
+	err = erofs_load_compress_hints();
+	if (err) {
+		erofs_err("Failed to load compress hints %s",
+			  cfg.compress_hints_file);
+		goto exit;
+	}
+
 #ifdef HAVE_LIBUUID
 	uuid_unparse_lower(sbi.uuid, uuid_str);
 #endif
-- 
2.25.1

