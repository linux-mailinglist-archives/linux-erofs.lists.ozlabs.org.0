Return-Path: <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>
X-Original-To: lists+linux-erofs@lfdr.de
Delivered-To: lists+linux-erofs@lfdr.de
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	by mail.lfdr.de (Postfix) with ESMTPS id 4AD0D3EF941
	for <lists+linux-erofs@lfdr.de>; Wed, 18 Aug 2021 06:28:13 +0200 (CEST)
Received: from boromir.ozlabs.org (localhost [IPv6:::1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4GqFJ91wxtz30J0
	for <lists+linux-erofs@lfdr.de>; Wed, 18 Aug 2021 14:28:09 +1000 (AEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=lists.ozlabs.org;
	s=201707; t=1629260889;
	bh=8fMG+9jZMxniml1iciQjVQ7x4+Mv9XQ+2vM34B1FLUY=;
	h=To:Subject:Date:In-Reply-To:References:List-Id:List-Unsubscribe:
	 List-Archive:List-Post:List-Help:List-Subscribe:From:Reply-To:Cc:
	 From;
	b=V0BHmNBm6v+rYcEjBCDF4q4JbBWbdYNTd2pHoUub2BFlxjkE71pjPGpRb32fHOKGQ
	 ZOnzTibIddjQlqD4X0XoTin36g/V9LydGXn1/FCoA7xJbMpTog77MRNj4Xhme3t0Xf
	 x1gNX1yN/CCKZEqXA3lplpuzMTwXDoe9DFv97KW+vBm+yPzUGBT7jFAZ3qhMo7pj3p
	 0Gdzm1MAmporrFb05TPLSzPMVzKNqgxctfNXGGOPxhTe8ZbQjkDWRgUAGXF0tbXQfV
	 ctMRCQG7CrORE9gYCH0+Am/td3uKimidh2x3Xl22Gjcq12UJ3B+o/z/SgkO4NurXkQ
	 dMoM84lsWi14A==
X-Original-To: linux-erofs@lists.ozlabs.org
Delivered-To: linux-erofs@lists.ozlabs.org
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized)
 smtp.mailfrom=oppo.com (client-ip=40.107.130.89;
 helo=apc01-hk2-obe.outbound.protection.outlook.com;
 envelope-from=huangjianan@oppo.com; receiver=<UNKNOWN>)
Authentication-Results: lists.ozlabs.org; dkim=pass (1024-bit key;
 unprotected) header.d=oppo.com header.i=@oppo.com header.a=rsa-sha256
 header.s=selector1 header.b=cqU8ZVgO; 
 dkim-atps=neutral
Received: from APC01-HK2-obe.outbound.protection.outlook.com
 (mail-eopbgr1300089.outbound.protection.outlook.com [40.107.130.89])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 4GqFJ03rpqz30BD
 for <linux-erofs@lists.ozlabs.org>; Wed, 18 Aug 2021 14:27:56 +1000 (AEST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=RTh4exGFTDstR4jeGwYepOKN4ozSCuJaUEBtW4R1euIy41grTVMU99LfPhAlRf/2te506ye/1vIbelVGoEO6SNamNTm7fiS2jx/+rYw6u2yUg5EE48AgcpBtQsJzSQ0kRS81e5Mw4gLF/+5NSsYA4jTweP51s9j08cMDhLus9StukA+EO/wRGnKoQH60k6Crr7TeD+Ege5ZHdfiTGml45pLpCO6yhI0IonpsXBmJZO+ZMgyVQ9VS+ZSK5Tm1FF31IiFsyoDzZ+eeOjaZyhcPF2Cuo5xCQKZMmuhbmhWrauZKls/6un/2Ajaq5jNB/1Mh7edUcejyOQHsVH3dPuDJGg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=8fMG+9jZMxniml1iciQjVQ7x4+Mv9XQ+2vM34B1FLUY=;
 b=d8BoZA7Vrrd0PJF55l3+J+gSuSi1noeGNr6Gg8yvMWIVrlz0fjeW+EZDberIJ1LKUAB96qobojSRjmauU30IAT0WDPn7ewWNC7NfW0V1UbxLJ19/0AJJl58B6ceiMrDsPCZk4gtFqqc1/yXEzS+TOuYuG+Rk1cyJB7uneT/GGJHJHHfMRnTj8/FM31s91kxKIUp5RWQv0+7ZF8sISm7Fs6EHgmDiERzotR+TchQgYm0xcLBTHE8LTpleShhGiD+ngiMClkud0EmeD4iK9NvnB5sH8y24wNVKl65axz1UCqPqV5MaYZuoZGLIhFGxXEdTOTB5YCDhQFpdeNmMUE0zug==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oppo.com; dmarc=pass action=none header.from=oppo.com;
 dkim=pass header.d=oppo.com; arc=none
Authentication-Results: lists.ozlabs.org; dkim=none (message not signed)
 header.d=none;lists.ozlabs.org; dmarc=none action=none header.from=oppo.com;
Received: from SG2PR02MB4108.apcprd02.prod.outlook.com (2603:1096:4:96::19) by
 SG2PR0201MB2095.apcprd02.prod.outlook.com (2603:1096:3:4::14) with
 Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.4415.15; Wed, 18 Aug 2021 04:27:33 +0000
Received: from SG2PR02MB4108.apcprd02.prod.outlook.com
 ([fe80::98eb:b373:a778:a6a5]) by SG2PR02MB4108.apcprd02.prod.outlook.com
 ([fe80::98eb:b373:a778:a6a5%7]) with mapi id 15.20.4415.024; Wed, 18 Aug 2021
 04:27:33 +0000
To: linux-erofs@lists.ozlabs.org
Subject: [PATCH v2] erofs-utils: support per-inode compress pcluster
Date: Wed, 18 Aug 2021 12:27:15 +0800
Message-Id: <20210818042715.24416-1-huangjianan@oppo.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20210816094043.43772-1-huangjianan@oppo.com>
References: <20210816094043.43772-1-huangjianan@oppo.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: HK2P15301CA0007.APCP153.PROD.OUTLOOK.COM
 (2603:1096:202:1::17) To SG2PR02MB4108.apcprd02.prod.outlook.com
 (2603:1096:4:96::19)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from PC80253450.adc.com (58.255.79.105) by
 HK2P15301CA0007.APCP153.PROD.OUTLOOK.COM (2603:1096:202:1::17) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.4457.1 via Frontend Transport; Wed, 18 Aug 2021 04:27:32 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 09ea8ecd-687a-4d6e-ddfc-08d962007f8b
X-MS-TrafficTypeDiagnostic: SG2PR0201MB2095:
X-MS-Exchange-SharedMailbox-RoutingAgent-Processed: True
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <SG2PR0201MB209559CC66EF5AD00F597D91C3FF9@SG2PR0201MB2095.apcprd02.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:392;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: CNderDy09oJbeep21tpqOpeP5S/8IuRA3j2wjLuyogaBLQ2JrMblxCJoxGo05t+4NgskO6+uif1unygyObo9Sz7G00uIIKbTqr2ZneeWLayBEXgFDwmry5W79PRFkaDn2lpNW9Ow9J0t1bVLjGr1zlUUUcGZSjazYbh1vpseHMFubpQvlCBohBOjwaCsLqH9T4Zl19jm68/NJzwKIhlHY/skPysFHph/4NQ9423IhaiypFq+Xs9Z7kwP/2qKuH8aZDpzOwPpZXq7i2XR9o8xUpPB4V/Jr3XjPGRYNu10HFU37hYjH5n/kfeZb3aEGUGoQ/PYCeWRNiRT9IcIbYYwSrRC292EZZLMv4sIdIogV4GBTzas+MLjjj1N1byCU8Dw5JBHmYRNPKvTvOFDGIq/zK7bWOEy8agGtE1Ey4AVK5EdM7w6pTYWYb5W03/+TgY/PpEUAUPFh1AS0JGRZuyRZeQ4Q3nfmB7YRBjdU85Tf0TkV0CogExABv7ypevUX5f9l3P0Z1vuzlwNzGmDgiTCHpPbEOqb70Dz2HITQbKAfyn2NF/29PcUYdUWjhy2ykYT7ryl4WBkv23sgjRyo8HIJlaNzFWBNFsICEtRB6cTIt6FZy4g2tDJAWceIAAC9f25Lzg0at1OJKQDB9Ue5KL3/dNh+BLxIKgALX9OSCW4XukNaIp2wvEdz5WxLeQnYn6gvd2buD00Xc0a2KfoesML6lUx9OjkZ9nXjqSoC0eL2QzHN8cEU+g1lzLK5onSBEM/
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:SG2PR02MB4108.apcprd02.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(4636009)(39860400002)(346002)(136003)(396003)(376002)(366004)(52116002)(36756003)(1076003)(26005)(478600001)(66946007)(30864003)(86362001)(956004)(8936002)(2616005)(186003)(8676002)(6506007)(83380400001)(66556008)(107886003)(4326008)(2906002)(66476007)(6916009)(316002)(6666004)(6512007)(38350700002)(38100700002)(5660300002)(6486002)(11606007)(21314003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?BYT2u/F5BeylU4VSoIKtEhNHsZGzzkass0rGiATxxYfXXFr9mDInHp7fetI3?=
 =?us-ascii?Q?9ZIRmr3wP8zZ9oLTJty4Y5c1ZliNW25QyMRqSYvHlbkcfoGvh/OaW2oiHgRw?=
 =?us-ascii?Q?PxFzRgJD6eROqm0qVZzeskc7/KXnfE5D7Fxq2cnroYWIcn57MIcQ/khub1Z9?=
 =?us-ascii?Q?8adkvewkAXppaUf1hYtkpm7zB+I835EfJuu+6h3JWxarrU27/tsviAm7aGPQ?=
 =?us-ascii?Q?c+mGcR1LezldADIxi9Mp9F53Ry15iKilwXCelVIBBJqbpKIQjWM4drSInENi?=
 =?us-ascii?Q?KWaBjkSW17zwGiZngpJrPoaTtjmOHc/9flf1Hgy1ZIc5AyKNNwKDIflxLf4Q?=
 =?us-ascii?Q?y0tUytbHxTxfkaQNB3C6LZEh9bV/4HYQHDdrbu4pCLs+bAB5Oxw8iwGp58bE?=
 =?us-ascii?Q?xCQMGSHJNL3rxFUA+vP2PillidbYE1NbPvior7Bs69DcHMJCs2vtiZypN8/X?=
 =?us-ascii?Q?u4QNohqWTUYguPdtXifapUioEicT+AqlbA9Ws+ywOjhZbuqMfbU6wjBCDVRU?=
 =?us-ascii?Q?KnW0pTwQ1ez6BasnPF7nGhjbDKfEgZsm40LNzk+5Dj7R2KPQ7LwvIHgaOmsU?=
 =?us-ascii?Q?VxQg6hlQ/fsGge5+8ScdNNw/wpWQ6qGtFZusRqcNnoO7VquOP3YhIhMnYRDV?=
 =?us-ascii?Q?88wjm3AFDwK91Ld03s2Wzw8t2CEl7qXZTfh68kohRdFIUnL4IRjM3euPg5bw?=
 =?us-ascii?Q?eo8lKlUld44rtn4f4lWaelYMKaFux5/WUoroGm6kQC2E9lRAKTHhBvjWVmGF?=
 =?us-ascii?Q?rccJc0eT8Mlcm2lxHHJAznwNIj1nYfiOZt+ewP0coX1ULKxR649djTM3GeFB?=
 =?us-ascii?Q?L7eT3vaJTzVS+3BgWtNqhMiAqqf6G9a5LO0lXE5KUXneDY7AlMu/iUbuCcKu?=
 =?us-ascii?Q?3f8t9+p0fK0c+gUOY7tPfiL4JNJQuFmgKmIeqD866aL/dhLWsby1ZyldI0Xg?=
 =?us-ascii?Q?QyPBxyeapAKYU37K0sw8oBOEnnZ7UHKPgns1hziQUiFCJxg65Yrm9d2gPDY1?=
 =?us-ascii?Q?DqBifnpA64NItNxRA/dK94ys7YWv+HXxBYAvPvnWT55CYv9Psq0IAHWKACaK?=
 =?us-ascii?Q?sRoIICRC9EhjNPy9IZqZPWJqpoczNorCYP1A/ytMyk6718ZKYvHmRU6Q1eh2?=
 =?us-ascii?Q?EU6nD22JYvRjptbMowfgT4QT6SBpWMGNmyElGy8T737kQa9xf9ZigzBGsaF0?=
 =?us-ascii?Q?pUYIEwfsG776Zq6Loma+oRg7CysBzi2C4mZdnZykkJELpMfA60xzZpY6RGWf?=
 =?us-ascii?Q?0rkJ2EITHuBJxMVDY5VUlEp+IiHr12sV3cscucSupXoKs5CQd8lTw62xK6fZ?=
 =?us-ascii?Q?G4+WfL6swAdV0M4KKSEO5rrU?=
X-OriginatorOrg: oppo.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 09ea8ecd-687a-4d6e-ddfc-08d962007f8b
X-MS-Exchange-CrossTenant-AuthSource: SG2PR02MB4108.apcprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 18 Aug 2021 04:27:33.3897 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: f1905eb1-c353-41c5-9516-62b4a54b5ee6
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 567GRqheVWJkPUwkQ8w5K3tqI7NkI2xi0NGLWfSwKz47YtNXfBDlsAS94QHWxJPZwpFOftSDTVawGCv97StZCg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SG2PR0201MB2095
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
changes since v1:
 - rename c_pclusterblks to c_physical_clusterblks and place it in union
 - change cfg.c_physical_clusterblks > 1 to erofs_sb_has_big_pcluster()
   since it's per-inode compression strategy

 include/erofs/compress_rule.h |  25 ++++++++
 include/erofs/config.h        |   1 +
 include/erofs/internal.h      |   1 +
 lib/Makefile.am               |   5 +-
 lib/compress.c                |  10 ++--
 lib/compress_rule.c           | 106 ++++++++++++++++++++++++++++++++++
 lib/compressor.h              |   1 -
 lib/inode.c                   |   6 ++
 man/mkfs.erofs.1              |   2 +
 mkfs/main.c                   |  31 +++++++---
 10 files changed, 172 insertions(+), 16 deletions(-)
 create mode 100644 include/erofs/compress_rule.h
 create mode 100644 lib/compress_rule.c

diff --git a/include/erofs/compress_rule.h b/include/erofs/compress_rule.h
new file mode 100644
index 0000000..8ad578b
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
+	unsigned int c_physical_clusterblks;
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
index a8ebbc1..ea4a756 100644
--- a/lib/compress.c
+++ b/lib/compress.c
@@ -19,6 +19,7 @@
 #include "erofs/compress.h"
 #include "compressor.h"
 #include "erofs/block_list.h"
+#include "erofs/compress_rule.h"
 
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
+	if (cfg.compress_rule_file)
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
diff --git a/lib/compress_rule.c b/lib/compress_rule.c
new file mode 100644
index 0000000..497d662
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
+	r->c_physical_clusterblks = blks;
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
+	if (inode->c_physical_clusterblks)
+		return inode->c_physical_clusterblks;
+
+	s = erofs_fspath(inode->i_srcpath);
+
+	list_for_each_entry(r, &compress_rule_head, list) {
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
diff --git a/lib/compressor.h b/lib/compressor.h
index b2471c4..4b7b8c8 100644
--- a/lib/compressor.h
+++ b/lib/compressor.h
@@ -53,4 +53,3 @@ int erofs_compressor_init(struct erofs_compress *c, char *alg_name);
 int erofs_compressor_exit(struct erofs_compress *c);
 
 #endif
-
diff --git a/lib/inode.c b/lib/inode.c
index 6871d2b..ab23ee5 100644
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
 
@@ -856,6 +861,7 @@ static struct erofs_inode *erofs_new_inode(void)
 
 	inode->bh = inode->bh_inline = inode->bh_data = NULL;
 	inode->idata = NULL;
+	inode->c_physical_clusterblks = 0;
 	return inode;
 }
 
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

