Return-Path: <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>
X-Original-To: lists+linux-erofs@lfdr.de
Delivered-To: lists+linux-erofs@lfdr.de
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2404:9400:2:0:216:3eff:fee1:b9f1])
	by mail.lfdr.de (Postfix) with ESMTPS id 0ED23886578
	for <lists+linux-erofs@lfdr.de>; Fri, 22 Mar 2024 04:36:27 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=lists.ozlabs.org;
	s=201707; t=1711078581;
	bh=NPfKusCzqdvM1Ie2Guk5LO4KqVdg0WLdCVdG44OLsPM=;
	h=To:Subject:Date:List-Id:List-Unsubscribe:List-Archive:List-Post:
	 List-Help:List-Subscribe:From:Reply-To:Cc:From;
	b=AThaiIOkAG2vq+xuZlGNN8kvHVvqt8MaIyJtBJt51jouAGLHxg9lA4tiPa2TBzjcM
	 XVoKke7fhlKzNErcJnN2EZOnySkiZ7iMDQ+HlSrLsYkmX6GzIDPQpGmvWb1u55bQO+
	 P57obcxmKGMgqPLXc6vFjURF2lYq8w2p+YHFJGlxCIR95HFYI01MQ/giSuS5EXR/Ri
	 AlcQodLH1EOzBvxkARBNBhshJnfuEHhwYt4HyHJbL1pzyPY5wlzZd2M7NBZ/X8g5Fp
	 7Fkv+AHfcJeNEiDnVk/kWuk3g6GEGVXpd3PsOlsthO/oqRlsEB9nvdFSo0pShf4Pyr
	 MYN+MRHXc6Gvw==
Received: from boromir.ozlabs.org (localhost [IPv6:::1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4V17KK3Cpqz3dV6
	for <lists+linux-erofs@lfdr.de>; Fri, 22 Mar 2024 14:36:21 +1100 (AEDT)
X-Original-To: linux-erofs@lists.ozlabs.org
Delivered-To: linux-erofs@lists.ozlabs.org
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=vivo.com header.i=@vivo.com header.a=rsa-sha256 header.s=selector2 header.b=hcOKwejX;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=vivo.com (client-ip=2a01:111:f403:2011::601; helo=apc01-tyz-obe.outbound.protection.outlook.com; envelope-from=guochunhai@vivo.com; receiver=lists.ozlabs.org)
Received: from APC01-TYZ-obe.outbound.protection.outlook.com (mail-tyzapc01on20601.outbound.protection.outlook.com [IPv6:2a01:111:f403:2011::601])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4V17K90zLqz3dLQ
	for <linux-erofs@lists.ozlabs.org>; Fri, 22 Mar 2024 14:36:10 +1100 (AEDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=GfcDkexj77eD9cIlD73ifaavEu1U+Qjjti8XrBDIzpBc8ihCSdeHfmUi0GarASwjTJfTxaBVtL5LMINkS3NHoqRF8mwIc27lswJezodfc/E8yyDamiYSfcSL0ui3bpahnxx1+UmQ0q8xWiYOsmBXP4zNx5gXxU3o8caR2BZQ+B+e5PLDw5Y3FP31X90XF8pmFyBcIkcN6ASXq+y2m2UpDVsVwi0Ovmw3MHlIBQTi6c9wHA1uHpkZsBkZ4hAwUZ5LVhEaNtEMZ2yqKkUlv5FWFCMPbNLr6d0XLOr+1JYSoXKB9XwCOOJIHm+4rO0LRNBQtevfq5wghi+VNR/dMBIEhw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=NPfKusCzqdvM1Ie2Guk5LO4KqVdg0WLdCVdG44OLsPM=;
 b=YNxAbW91IHUi5XIW3uja7bkxFJUdJ+uWUMUla3UO93naU6+1FFyZTZ54kpeOs2XCMAFespr7fJNCACiKv0HilmYWrCAzcZqeRUZwWrrCwI9Cu8x4phLw/YWWCzsUkugwIsD8xpi2neezA8DcjXkJV8Mqxk2kTDkZtOqPXW6t6qylBpqXVhVW79z6VM7IfoCconUo9exWyZy/Mqvb+GwJ5iI8o6zFVrdfqakV8484zHkwAupJziiXrhfUOR74fv626ACxC38omtz6gxoOLh43quINdksLIrC/yn/0qrivUf52dTps0iPAAfWNS5OpKwVvSa2aIv/TqPbgPN2Fw60oEg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=vivo.com; dmarc=pass action=none header.from=vivo.com;
 dkim=pass header.d=vivo.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=vivo.com;
Received: from TYZPR06MB7096.apcprd06.prod.outlook.com (2603:1096:405:b5::13)
 by TYZPR06MB7253.apcprd06.prod.outlook.com (2603:1096:405:ad::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7386.30; Fri, 22 Mar
 2024 03:35:48 +0000
Received: from TYZPR06MB7096.apcprd06.prod.outlook.com
 ([fe80::e7c6:80cf:ec4b:9e17]) by TYZPR06MB7096.apcprd06.prod.outlook.com
 ([fe80::e7c6:80cf:ec4b:9e17%4]) with mapi id 15.20.7386.025; Fri, 22 Mar 2024
 03:35:48 +0000
To: xiang@kernel.org
Subject: [PATCH] erofs: rename per-CPU buffers to global buffer pool and make it configurable
Date: Thu, 21 Mar 2024 21:47:40 -0600
Message-Id: <20240322034740.958750-1-guochunhai@vivo.com>
X-Mailer: git-send-email 2.25.1
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SG2PR02CA0029.apcprd02.prod.outlook.com
 (2603:1096:3:18::17) To TYZPR06MB7096.apcprd06.prod.outlook.com
 (2603:1096:405:b5::13)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: TYZPR06MB7096:EE_|TYZPR06MB7253:EE_
X-MS-Office365-Filtering-Correlation-Id: 4413d31d-f4a7-4070-a996-08dc4a212a52
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 	RAVAQZ+mRR5rzqhxWjmEvZZURGfyH9kRkvVcBMbE6vHtasJBDil2Fq18DmMthHbQIqnAFJZ6938AFUCnyt4LGyflC0gg4qlTMZwCd0dY3YN+rI0oQhZZIedT5Db92nh1ClEhmxJkDJJ6Bglt18+eAhw13bWUFPVBLxZ4eXZGJjPFscQ2mC9vARD9j8PRfFiyB0MZ4CJHIKfRt2BOB7rGn6RrDB40KDqssoikFg5ZBKP3gU4VdVQY5hcVprO6hlQ5lJ2Vd8f+sgEiTOgLwKmVUA5quavjqFf/Ha4QXTR6W/xWvztHCPPrM8x99VJdtUvLRqgdQZut0Q3b9STkzh+h291BeD4lyhZUv0mrLfQQHV5mGcsrUEW4HH+b1n89Jt4gvmBY0KftD1xh+sJIBYtQkd4RfMaIdStXjEy2QSRMBd9XtjDnPEB/JchOWKMB1j5sTotoP95uaEQBR2OMg6NGoM/B2LlGOhO577ZGLpoDvmRkT+Fo52z+QsQfWCpY69GxaO0Ycrw/9cNhu2eBSdKdAyAbLvM/ZeqM+oqqrRY8qfWrr2B1QY8dSHzoKhpyTGC8HLqWeN/J96W2TzccQiRcGvU+6AvPFkAcp/tli8Q6DFBs6hDArL53yIzMynlck6AQH9YMlVAQub/CUMb8zm62nWC/tO7f9umrHVi2i5xtKfIfhsFd2gFD6vwiVrTysNGmo+2AHvJ92r0BfxQvEWpfWA==
X-Forefront-Antispam-Report: 	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:TYZPR06MB7096.apcprd06.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(376005)(1800799015)(52116005)(366007)(38350700005);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 	=?us-ascii?Q?ECQWby3sh39L4N2QiOtVXl91bldX2cGzz6AylDLHggRTn/qxHjHnCMQB+/ZW?=
 =?us-ascii?Q?U6eP+u8xOjt55Vt0oqv2LipKdySJzKoT/HZhjjACFkIi0yN2wB8F1dYH8n9N?=
 =?us-ascii?Q?zWxVZIGSb0jYKRZl9zO0jTt0roAeu+bb2Asez7HR7ZT8sHBddJFNNGREV+ox?=
 =?us-ascii?Q?hJX2i0jF5XJpC5za0cpdzeBggylloe0StDVBZKRbGPESxXUx/aQ+3mCigO5n?=
 =?us-ascii?Q?DyMJ7fThayMtK2SPx6xjcVG6WJI9Z2AhztB3zGlKu+3Gu458LNh/4JM6PHGJ?=
 =?us-ascii?Q?GtvCApidC4nZvoRIwaTDJB9KKrtje1lkloF/+qAis5CPh3NGOrKD7LdOdx8d?=
 =?us-ascii?Q?ixkohpuLjM/6BrNFdr82Q1YVDlG6FEN2VAbz7ieiW8kYENkoR+6Fj8SwMWHH?=
 =?us-ascii?Q?9QT3rcKj+igyRZs+TA8XouhkgaTGQePp7JTCfVDHGVw/UiWo041fyAqf/yAL?=
 =?us-ascii?Q?EsOdvnT/uULOXh7hu0MKwxee85aSFXe+G9bR7NQ1GgA53wYy3uoRkT7jlMue?=
 =?us-ascii?Q?WJW6umvoOz6x6O4M2BM29/EKnpV8bg0mGxDUgVhZISMWVmusr0x+q12dFBpz?=
 =?us-ascii?Q?Nq8y/P5Ljf7izh2Gp6pH24YS3fUzhB96KrIoVHlwaNQ1QxryZxaqI99ykhCa?=
 =?us-ascii?Q?lH1ccgpx3yCvkwDNmEzsr4KU3Z7fvmsKTX+Q2HDpSU56ZSYrdcrRI+c9fBr3?=
 =?us-ascii?Q?qiHDTocrCqcXgnLHqMbLbDDwxduOJL00YBWCb71F7pptTbVIKn3xzsOhAW8Z?=
 =?us-ascii?Q?EqFrL1Gk0t/AhqtkS6AedO2g0F0tv+F3RN+xg5LCuS9ejXfX0Oe24G1kUOOW?=
 =?us-ascii?Q?tOJvPvOCjoYIKaAnTpAQkqOBqkznJv2ch973/7hE03PizuBhYrmLU26zdcEX?=
 =?us-ascii?Q?lAUUlsOggob9uLQPdcheXNKjbAAR5ovVJadFE1SKHFL1rksF1zd9bX6svTv0?=
 =?us-ascii?Q?1mQJarNi6uGe32HheFxpnrSfrsIYDC3CD8XcsPuWeBpwujRmsxgRjY8ZU+ec?=
 =?us-ascii?Q?HQd4NzdlMrQwW1//6sPgA/RTVDYOb6z3mPegFkfHJJXmQC4EgnHXdTvezYEV?=
 =?us-ascii?Q?6dEZdE5LPN8wWzkMUWB9InaZPys4onXbF2sCS2eZ+h/bEBv3d3llxBvz/xT6?=
 =?us-ascii?Q?2RNEI9IPo1L2C+o7rmYiGSTGWv5/X5SbYvGJsVOzhShef9w1aNk9K3OmNfAK?=
 =?us-ascii?Q?B3otyxV9DXjF4BxblSN8G7N4YkVaa1gPmsm0fN0KW8Tr/bkNkCMYKxLJ+u2Z?=
 =?us-ascii?Q?ZtE0Oguo5PooyghixzK8mQxm7irk6R9AJik/1WCYuVugt2wcLjc9tDpfySTt?=
 =?us-ascii?Q?Dsb4IqkRn33sHigFuy6G4ybbvJ70RA69WNRGXzVVXEFljwESRVh1CtfaoxXq?=
 =?us-ascii?Q?HdqjJGKV+1ZlcA7PKLWWN6s1OL/DxMzymUhid7AK93g+SyVd0CtL1fjTjnIn?=
 =?us-ascii?Q?BHaMTNAZSY3WFOe9rwCTZEJP4t7owFQ4gbcxMScJ41St+AT52AJvX3RlRwnZ?=
 =?us-ascii?Q?NiYt2AjWLOJ4lTC14zFp3hJJMl+MnrV9OjnTdHWsdXP1cfGMGoPyYQ9t21LL?=
 =?us-ascii?Q?Y4Bl8JEg2Zs50iNZ+MTOlSU5kKsAww/A1ETCUN1d?=
X-OriginatorOrg: vivo.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 4413d31d-f4a7-4070-a996-08dc4a212a52
X-MS-Exchange-CrossTenant-AuthSource: TYZPR06MB7096.apcprd06.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 22 Mar 2024 03:35:48.5445
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 923e42dc-48d5-4cbe-b582-1a797a6412ed
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: gr8CJN/nnG02ghfq4EPTqF+wu+xStmodMUH3e1wiEJIgY30fOkTkEzp0XVYP4XC4B/W6/JaOGsSqxNS6cezfpw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TYZPR06MB7253
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
From: Chunhai Guo via Linux-erofs <linux-erofs@lists.ozlabs.org>
Reply-To: Chunhai Guo <guochunhai@vivo.com>
Cc: Chunhai Guo <guochunhai@vivo.com>, linux-erofs@lists.ozlabs.org, huyue2@coolpad.com
Errors-To: linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org
Sender: "Linux-erofs" <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>

It will cost more time if compressed buffers are allocated on demand for
low-latency algorithms (like lz4) so EROFS uses per-CPU buffers to keep
compressed data if in-place decompression is unfulfilled.  While it is
kind of wasteful of memory for a device with hundreds of CPUs, and only
a small number of CPUs are concurrently decompressing most of the time.

This patch renames it as 'global buffer pool' and makes it configurable.
This allows two or more CPUs to share a common buffer to reduce memory
occupation.

Signed-off-by: Chunhai Guo <guochunhai@vivo.com>
Suggested-by: Gao Xiang <xiang@kernel.org>
---
 fs/erofs/Makefile       |   2 +-
 fs/erofs/decompressor.c |   6 +-
 fs/erofs/internal.h     |  14 ++--
 fs/erofs/pcpubuf.c      | 148 --------------------------------------
 fs/erofs/super.c        |   4 +-
 fs/erofs/utils.c        | 155 ++++++++++++++++++++++++++++++++++++++++
 6 files changed, 168 insertions(+), 161 deletions(-)
 delete mode 100644 fs/erofs/pcpubuf.c

diff --git a/fs/erofs/Makefile b/fs/erofs/Makefile
index 994d0b9deddf..6cf1504c63e6 100644
--- a/fs/erofs/Makefile
+++ b/fs/erofs/Makefile
@@ -3,7 +3,7 @@
 obj-$(CONFIG_EROFS_FS) += erofs.o
 erofs-objs := super.o inode.o data.o namei.o dir.o utils.o sysfs.o
 erofs-$(CONFIG_EROFS_FS_XATTR) += xattr.o
-erofs-$(CONFIG_EROFS_FS_ZIP) += decompressor.o zmap.o zdata.o pcpubuf.o
+erofs-$(CONFIG_EROFS_FS_ZIP) += decompressor.o zmap.o zdata.o
 erofs-$(CONFIG_EROFS_FS_ZIP_LZMA) += decompressor_lzma.o
 erofs-$(CONFIG_EROFS_FS_ZIP_DEFLATE) += decompressor_deflate.o
 erofs-$(CONFIG_EROFS_FS_ONDEMAND) += fscache.o
diff --git a/fs/erofs/decompressor.c b/fs/erofs/decompressor.c
index d4cee95af14c..99a344684132 100644
--- a/fs/erofs/decompressor.c
+++ b/fs/erofs/decompressor.c
@@ -54,7 +54,7 @@ static int z_erofs_load_lz4_config(struct super_block *sb,
 	sbi->lz4.max_distance_pages = distance ?
 					DIV_ROUND_UP(distance, PAGE_SIZE) + 1 :
 					LZ4_MAX_DISTANCE_PAGES;
-	return erofs_pcpubuf_growsize(sbi->lz4.max_pclusterblks);
+	return erofs_gbuf_growsize(sbi->lz4.max_pclusterblks);
 }
 
 /*
@@ -159,7 +159,7 @@ static void *z_erofs_lz4_handle_overlap(struct z_erofs_lz4_decompress_ctx *ctx,
 docopy:
 	/* Or copy compressed data which can be overlapped to per-CPU buffer */
 	in = rq->in;
-	src = erofs_get_pcpubuf(ctx->inpages);
+	src = erofs_get_gbuf(ctx->inpages);
 	if (!src) {
 		DBG_BUGON(1);
 		kunmap_local(inpage);
@@ -260,7 +260,7 @@ static int z_erofs_lz4_decompress_mem(struct z_erofs_lz4_decompress_ctx *ctx,
 	} else if (maptype == 1) {
 		vm_unmap_ram(src, ctx->inpages);
 	} else if (maptype == 2) {
-		erofs_put_pcpubuf(src);
+		erofs_put_gbuf(src);
 	} else if (maptype != 3) {
 		DBG_BUGON(1);
 		return -EFAULT;
diff --git a/fs/erofs/internal.h b/fs/erofs/internal.h
index b0409badb017..320d3d0d3526 100644
--- a/fs/erofs/internal.h
+++ b/fs/erofs/internal.h
@@ -471,11 +471,11 @@ int erofs_try_to_free_all_cached_pages(struct erofs_sb_info *sbi,
 				       struct erofs_workgroup *egrp);
 int z_erofs_map_blocks_iter(struct inode *inode, struct erofs_map_blocks *map,
 			    int flags);
-void *erofs_get_pcpubuf(unsigned int requiredpages);
-void erofs_put_pcpubuf(void *ptr);
-int erofs_pcpubuf_growsize(unsigned int nrpages);
-void __init erofs_pcpubuf_init(void);
-void erofs_pcpubuf_exit(void);
+void *erofs_get_gbuf(unsigned int requiredpages);
+void erofs_put_gbuf(void *ptr);
+int erofs_gbuf_growsize(unsigned int nrpages);
+void __init erofs_gbuf_init(void);
+void erofs_gbuf_exit(void);
 int erofs_init_managed_cache(struct super_block *sb);
 int z_erofs_parse_cfgs(struct super_block *sb, struct erofs_super_block *dsb);
 #else
@@ -485,8 +485,8 @@ static inline int erofs_init_shrinker(void) { return 0; }
 static inline void erofs_exit_shrinker(void) {}
 static inline int z_erofs_init_zip_subsystem(void) { return 0; }
 static inline void z_erofs_exit_zip_subsystem(void) {}
-static inline void erofs_pcpubuf_init(void) {}
-static inline void erofs_pcpubuf_exit(void) {}
+static inline void erofs_gbuf_init(void) {}
+static inline void erofs_gbuf_exit(void) {}
 static inline int erofs_init_managed_cache(struct super_block *sb) { return 0; }
 #endif	/* !CONFIG_EROFS_FS_ZIP */
 
diff --git a/fs/erofs/pcpubuf.c b/fs/erofs/pcpubuf.c
deleted file mode 100644
index c7a4b1d77069..000000000000
--- a/fs/erofs/pcpubuf.c
+++ /dev/null
@@ -1,148 +0,0 @@
-// SPDX-License-Identifier: GPL-2.0-only
-/*
- * Copyright (C) Gao Xiang <xiang@kernel.org>
- *
- * For low-latency decompression algorithms (e.g. lz4), reserve consecutive
- * per-CPU virtual memory (in pages) in advance to store such inplace I/O
- * data if inplace decompression is failed (due to unmet inplace margin for
- * example).
- */
-#include "internal.h"
-
-struct erofs_pcpubuf {
-	raw_spinlock_t lock;
-	void *ptr;
-	struct page **pages;
-	unsigned int nrpages;
-};
-
-static DEFINE_PER_CPU(struct erofs_pcpubuf, erofs_pcb);
-
-void *erofs_get_pcpubuf(unsigned int requiredpages)
-	__acquires(pcb->lock)
-{
-	struct erofs_pcpubuf *pcb = &get_cpu_var(erofs_pcb);
-
-	raw_spin_lock(&pcb->lock);
-	/* check if the per-CPU buffer is too small */
-	if (requiredpages > pcb->nrpages) {
-		raw_spin_unlock(&pcb->lock);
-		put_cpu_var(erofs_pcb);
-		/* (for sparse checker) pretend pcb->lock is still taken */
-		__acquire(pcb->lock);
-		return NULL;
-	}
-	return pcb->ptr;
-}
-
-void erofs_put_pcpubuf(void *ptr) __releases(pcb->lock)
-{
-	struct erofs_pcpubuf *pcb = &per_cpu(erofs_pcb, smp_processor_id());
-
-	DBG_BUGON(pcb->ptr != ptr);
-	raw_spin_unlock(&pcb->lock);
-	put_cpu_var(erofs_pcb);
-}
-
-/* the next step: support per-CPU page buffers hotplug */
-int erofs_pcpubuf_growsize(unsigned int nrpages)
-{
-	static DEFINE_MUTEX(pcb_resize_mutex);
-	static unsigned int pcb_nrpages;
-	struct page *pagepool = NULL;
-	int delta, cpu, ret, i;
-
-	mutex_lock(&pcb_resize_mutex);
-	delta = nrpages - pcb_nrpages;
-	ret = 0;
-	/* avoid shrinking pcpubuf, since no idea how many fses rely on */
-	if (delta <= 0)
-		goto out;
-
-	for_each_possible_cpu(cpu) {
-		struct erofs_pcpubuf *pcb = &per_cpu(erofs_pcb, cpu);
-		struct page **pages, **oldpages;
-		void *ptr, *old_ptr;
-
-		pages = kmalloc_array(nrpages, sizeof(*pages), GFP_KERNEL);
-		if (!pages) {
-			ret = -ENOMEM;
-			break;
-		}
-
-		for (i = 0; i < nrpages; ++i) {
-			pages[i] = erofs_allocpage(&pagepool, GFP_KERNEL);
-			if (!pages[i]) {
-				ret = -ENOMEM;
-				oldpages = pages;
-				goto free_pagearray;
-			}
-		}
-		ptr = vmap(pages, nrpages, VM_MAP, PAGE_KERNEL);
-		if (!ptr) {
-			ret = -ENOMEM;
-			oldpages = pages;
-			goto free_pagearray;
-		}
-		raw_spin_lock(&pcb->lock);
-		old_ptr = pcb->ptr;
-		pcb->ptr = ptr;
-		oldpages = pcb->pages;
-		pcb->pages = pages;
-		i = pcb->nrpages;
-		pcb->nrpages = nrpages;
-		raw_spin_unlock(&pcb->lock);
-
-		if (!oldpages) {
-			DBG_BUGON(old_ptr);
-			continue;
-		}
-
-		if (old_ptr)
-			vunmap(old_ptr);
-free_pagearray:
-		while (i)
-			erofs_pagepool_add(&pagepool, oldpages[--i]);
-		kfree(oldpages);
-		if (ret)
-			break;
-	}
-	pcb_nrpages = nrpages;
-	erofs_release_pages(&pagepool);
-out:
-	mutex_unlock(&pcb_resize_mutex);
-	return ret;
-}
-
-void __init erofs_pcpubuf_init(void)
-{
-	int cpu;
-
-	for_each_possible_cpu(cpu) {
-		struct erofs_pcpubuf *pcb = &per_cpu(erofs_pcb, cpu);
-
-		raw_spin_lock_init(&pcb->lock);
-	}
-}
-
-void erofs_pcpubuf_exit(void)
-{
-	int cpu, i;
-
-	for_each_possible_cpu(cpu) {
-		struct erofs_pcpubuf *pcb = &per_cpu(erofs_pcb, cpu);
-
-		if (pcb->ptr) {
-			vunmap(pcb->ptr);
-			pcb->ptr = NULL;
-		}
-		if (!pcb->pages)
-			continue;
-
-		for (i = 0; i < pcb->nrpages; ++i)
-			if (pcb->pages[i])
-				put_page(pcb->pages[i]);
-		kfree(pcb->pages);
-		pcb->pages = NULL;
-	}
-}
diff --git a/fs/erofs/super.c b/fs/erofs/super.c
index 5f60f163bd56..5161923c33fc 100644
--- a/fs/erofs/super.c
+++ b/fs/erofs/super.c
@@ -902,7 +902,7 @@ static int __init erofs_module_init(void)
 	if (err)
 		goto deflate_err;
 
-	erofs_pcpubuf_init();
+	erofs_gbuf_init();
 	err = z_erofs_init_zip_subsystem();
 	if (err)
 		goto zip_err;
@@ -945,7 +945,7 @@ static void __exit erofs_module_exit(void)
 	z_erofs_lzma_exit();
 	erofs_exit_shrinker();
 	kmem_cache_destroy(erofs_inode_cachep);
-	erofs_pcpubuf_exit();
+	erofs_gbuf_exit();
 }
 
 static int erofs_statfs(struct dentry *dentry, struct kstatfs *buf)
diff --git a/fs/erofs/utils.c b/fs/erofs/utils.c
index e146d09151af..7bdff1c7ce19 100644
--- a/fs/erofs/utils.c
+++ b/fs/erofs/utils.c
@@ -284,4 +284,159 @@ void erofs_exit_shrinker(void)
 {
 	shrinker_free(erofs_shrinker_info);
 }
+
+struct erofs_gbuf {
+	spinlock_t lock;
+	void *ptr;
+	struct page **pages;
+	unsigned int nrpages, ref;
+	struct list_head list;
+};
+
+struct erofs_gbufpool {
+	struct erofs_gbuf *gbuf_array;
+	unsigned int gbuf_num, gbuf_nrpages;
+};
+
+struct erofs_gbufpool z_erofs_gbufpool;
+
+module_param_named(pcluster_buf_num, z_erofs_gbufpool.gbuf_num, uint, 0444);
+
+static inline unsigned int erofs_cur_gbuf(void)
+{
+	return smp_processor_id() % z_erofs_gbufpool.gbuf_num;
+}
+
+void *erofs_get_gbuf(unsigned int requiredpages)
+	__acquires(gbuf->lock)
+{
+	struct erofs_gbuf *gbuf;
+
+	gbuf = &z_erofs_gbufpool.gbuf_array[erofs_cur_gbuf()];
+	spin_lock(&gbuf->lock);
+	/* check if the buffer is too small */
+	if (requiredpages > gbuf->nrpages) {
+		spin_unlock(&gbuf->lock);
+		/* (for sparse checker) pretend gbuf->lock is still taken */
+		__acquire(gbuf->lock);
+		return NULL;
+	}
+	return gbuf->ptr;
+}
+
+void erofs_put_gbuf(void *ptr) __releases(gbuf->lock)
+{
+	struct erofs_gbuf *gbuf;
+
+	gbuf = &z_erofs_gbufpool.gbuf_array[erofs_cur_gbuf()];
+	DBG_BUGON(gbuf->ptr != ptr);
+	spin_unlock(&gbuf->lock);
+}
+
+int erofs_gbuf_growsize(unsigned int nrpages)
+{
+	static DEFINE_MUTEX(gbuf_resize_mutex);
+	struct page *pagepool = NULL;
+	int delta, ret, i, j;
+
+	if (!z_erofs_gbufpool.gbuf_array)
+		return -ENOMEM;
+
+	mutex_lock(&gbuf_resize_mutex);
+	delta = nrpages - z_erofs_gbufpool.gbuf_nrpages;
+	ret = 0;
+	/* avoid shrinking pcl_buf, since no idea how many fses rely on */
+	if (delta <= 0)
+		goto out;
+
+	for (i = 0; i < z_erofs_gbufpool.gbuf_num; ++i) {
+		struct erofs_gbuf *gbuf = &z_erofs_gbufpool.gbuf_array[i];
+		struct page **pages, **tmp_pages;
+		void *ptr, *old_ptr = NULL;
+
+		ret = -ENOMEM;
+		tmp_pages = kmalloc_array(nrpages, sizeof(*tmp_pages),
+				GFP_KERNEL);
+		if (!tmp_pages)
+			break;
+		for (j = 0; j < nrpages; ++j) {
+			tmp_pages[j] = erofs_allocpage(&pagepool, GFP_KERNEL);
+			if (!tmp_pages[j])
+				goto free_pagearray;
+		}
+		ptr = vmap(tmp_pages, nrpages, VM_MAP, PAGE_KERNEL);
+		if (!ptr)
+			goto free_pagearray;
+
+		pages = tmp_pages;
+		spin_lock(&gbuf->lock);
+		old_ptr = gbuf->ptr;
+		gbuf->ptr = ptr;
+		tmp_pages = gbuf->pages;
+		gbuf->pages = pages;
+		j = gbuf->nrpages;
+		gbuf->nrpages = nrpages;
+		spin_unlock(&gbuf->lock);
+		ret = 0;
+		if (!tmp_pages) {
+			DBG_BUGON(old_ptr);
+			continue;
+		}
+
+		if (old_ptr)
+			vunmap(old_ptr);
+free_pagearray:
+		while (j)
+			erofs_pagepool_add(&pagepool, tmp_pages[--j]);
+		kfree(tmp_pages);
+		if (ret)
+			break;
+	}
+	z_erofs_gbufpool.gbuf_nrpages = nrpages;
+	erofs_release_pages(&pagepool);
+out:
+	mutex_unlock(&gbuf_resize_mutex);
+	return ret;
+}
+
+void __init erofs_gbuf_init(void)
+{
+	if (!z_erofs_gbufpool.gbuf_num)
+		z_erofs_gbufpool.gbuf_num = num_possible_cpus();
+	else if (z_erofs_gbufpool.gbuf_num > num_possible_cpus())
+		z_erofs_gbufpool.gbuf_num = num_possible_cpus();
+
+	z_erofs_gbufpool.gbuf_array = kmalloc_array(z_erofs_gbufpool.gbuf_num,
+			sizeof(*z_erofs_gbufpool.gbuf_array),
+			GFP_KERNEL | __GFP_ZERO);
+	if (!z_erofs_gbufpool.gbuf_array) {
+		erofs_err(NULL, "failed to alloc page for erofs gbuf_array\n");
+		return;
+	}
+
+	for (int i = 0; i < z_erofs_gbufpool.gbuf_num; ++i)
+		spin_lock_init(&z_erofs_gbufpool.gbuf_array[i].lock);
+}
+
+void __exit erofs_gbuf_exit(void)
+{
+	for (int i = 0; i < z_erofs_gbufpool.gbuf_num; ++i) {
+		struct erofs_gbuf *gbuf = &z_erofs_gbufpool.gbuf_array[i];
+
+		if (gbuf->ptr) {
+			vunmap(gbuf->ptr);
+			gbuf->ptr = NULL;
+		}
+
+		if (!gbuf->pages)
+			continue;
+
+		for (i = 0; i < gbuf->nrpages; ++i)
+			if (gbuf->pages[i])
+				put_page(gbuf->pages[i]);
+		kfree(gbuf->pages);
+		gbuf->pages = NULL;
+	}
+	kfree(z_erofs_gbufpool.gbuf_array);
+}
 #endif	/* !CONFIG_EROFS_FS_ZIP */
-- 
2.25.1

