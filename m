Return-Path: <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>
X-Original-To: lists+linux-erofs@lfdr.de
Delivered-To: lists+linux-erofs@lfdr.de
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	by mail.lfdr.de (Postfix) with ESMTPS id 13825893B95
	for <lists+linux-erofs@lfdr.de>; Mon,  1 Apr 2024 15:45:56 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=lists.ozlabs.org;
	s=201707; t=1711979150;
	bh=AkSdKgS21kxbUCeFQnxLfdF+zWIHLKPSA4SRkOBVIW0=;
	h=To:Subject:Date:List-Id:List-Unsubscribe:List-Archive:List-Post:
	 List-Help:List-Subscribe:From:Reply-To:Cc:From;
	b=I+mR0+D6DdKROMf/fdpFBi/MLvSda6SDnogen0JtbKFgOigBslOgFta/NQf4YQ2sg
	 Vx3HG5L8/K0sExmjJ/Njx6WgNRjONVqGPxnuqDPt51gu3fxdU8hRUNbfX2Vvrk7GG2
	 b8x+dRQQd1uCrSzY6/nulGWZo2uK87BLOkrJlRhaeMJYWr5F22P8328b/eK28IWXlI
	 3VuCYR1hhFbz1xpmOoLlzN0nKx6fy6D79/LqWo4r+fA5gWXfDiZcEy2nYW9uMGBaHL
	 a8MctD7B1WjYpThCizZhP/NSeL4D/zWkHy/ipisOraKFm0oy8KPz7LCvRuxdqjAYjo
	 CjWaR0WeB4wCA==
Received: from boromir.ozlabs.org (localhost [IPv6:::1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4V7XMy4h48z3d44
	for <lists+linux-erofs@lfdr.de>; Tue,  2 Apr 2024 00:45:50 +1100 (AEDT)
X-Original-To: linux-erofs@lists.ozlabs.org
Delivered-To: linux-erofs@lists.ozlabs.org
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=vivo.com header.i=@vivo.com header.a=rsa-sha256 header.s=selector2 header.b=pBcv58pL;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=vivo.com (client-ip=2a01:111:f403:2011::701; helo=apc01-tyz-obe.outbound.protection.outlook.com; envelope-from=guochunhai@vivo.com; receiver=lists.ozlabs.org)
Received: from APC01-TYZ-obe.outbound.protection.outlook.com (mail-tyzapc01on20701.outbound.protection.outlook.com [IPv6:2a01:111:f403:2011::701])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4V7XMv6Cvqz3bmN
	for <linux-erofs@lists.ozlabs.org>; Tue,  2 Apr 2024 00:45:46 +1100 (AEDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Y9GiuToEiATxKOne4OQIoAjoKM7m0ja6y7gFgPDO8ukkbBNydP8pbJn45n0EYIKnnv8IckzwIs2AUu1aa3FGK/svfTMpfeNWnp+N2NYWbGxZkyodpUglPxaHmoJ9AGLD4X4ysHpceE2MfOqehncQ2I4fHSDIAmMDGPg1EsNpijbw6hKYwIRe6OxNu2jdUjLG7OOpAhZGqX9yZl+72C+vQm7X4wJgKLzw7B4igZAzZn/HT2ciAHlhUkVOB79zdMOjXOPHTYzKmPBnJMA1t6VFIl1X1P1ihzSYcy9n5ZkdeSv/Wqy4Nus+jhu/c4lERsInkhKpGc09/St+4nby2pQx0g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=AkSdKgS21kxbUCeFQnxLfdF+zWIHLKPSA4SRkOBVIW0=;
 b=PKufciYo5Rw06x93IEZJ2DK8QcBAn/nOOPrKx5QvNtaiPhYqQLIShyEuUPM4GDZleFEX/1alyFaJ9d9OzbTM9a9QVC8iRaAwSPUa3alHOBVmO+CGmLYjEZ5vv7NK1Lhw6wLoC9mxGh7ZgDFy0lRyznsBoREz/MDWs2blAYUuS0H55h/5EGVbBUTl/f6lnMDhTlDwzBkErzVMtgQ+g7kdZ1LptX2FYlaolONMwQLeRFI56cdn03BZ8E+WweYSBCIZOhEI3Vq39KeRFZ+3vxtbnu4n6bcN/FxzWLLpLDWwwRs4H8yh/ZeMFynXQIBRZbRTao3pOiot1TQCi6kPY0RAoQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=vivo.com; dmarc=pass action=none header.from=vivo.com;
 dkim=pass header.d=vivo.com; arc=none
Received: from TYZPR06MB7096.apcprd06.prod.outlook.com (2603:1096:405:b5::13)
 by SI2PR06MB5090.apcprd06.prod.outlook.com (2603:1096:4:1a9::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7409.45; Mon, 1 Apr
 2024 13:45:29 +0000
Received: from TYZPR06MB7096.apcprd06.prod.outlook.com
 ([fe80::9eb4:3582:34e4:a83d]) by TYZPR06MB7096.apcprd06.prod.outlook.com
 ([fe80::9eb4:3582:34e4:a83d%6]) with mapi id 15.20.7409.042; Mon, 1 Apr 2024
 13:45:29 +0000
To: xiang@kernel.org
Subject: [PATCH 2/2] erofs: rename per CPU buffer to global buffer pool and make it configurable
Date: Mon,  1 Apr 2024 07:56:45 -0600
Message-Id: <20240401135645.2550203-1-guochunhai@vivo.com>
X-Mailer: git-send-email 2.25.1
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: TYWP286CA0018.JPNP286.PROD.OUTLOOK.COM
 (2603:1096:400:178::8) To TYZPR06MB7096.apcprd06.prod.outlook.com
 (2603:1096:405:b5::13)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: TYZPR06MB7096:EE_|SI2PR06MB5090:EE_
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 	r8L+sy8zp/pQvgK+gwHjU0ppFN192OvxWCucdLjKM59PFHpH39N54H3s/l6v68Bwy8HLRTCrqBTGWWZrqJluTDKbC8wtXgucKv2oBMNdHoBzhED+OZsUpgsvgb/poeBH0iBEywlVZR/jWKqifJcUdowmo7lGiZkdkyFm7wBnBU9+j4WMbGfasz/maKqQ/iq9cUOmIXJwaEm1pGkp64YxrZNqu/HL/8gxHoDd/G5JTnM7RJa6NewSMVAIBpptHq40jxy5gt3y++CQMakwZ7c6uzLOoWMI9MKpvbACmbBHwI1iuH1My15AJkR8KzNEVMYqLWmoLBZH7X5m25tE3vIPj/sMSZZdGRoyfTFTYojRsXem6yTTH6iNCWhB9MvxlkabVoxBLqcnprs+u6vwu2b+Pzsjq1oIam64EnmQ4cGs36O27Zgx8ezatWNAypcGbEhg5w8cjkGiS3JPc8Dc0UVq639GEu/s9gKycAL5DhE6KX8hPUsuNDuD/XKGtJ+KAFHSscpEkTF6JkuzF5m8rHflIpPh70NImCGXOw+hn5oUOcU71FsPsAZqtJaGSl9x5k1NUSEzh7m7F9EvqFa9nHPEMTDJq61N35fUAhf1c1yXEPv+dVv+txtXcGLcG34tGsmhAEAaqRVwX04jgauVDLLqC5WMQLwvPXkLOlWY9x9a5QULexAHqG2rDCOo2OSRPIsquwVZ+LrxnhwpjreMrAE3HA==
X-Forefront-Antispam-Report: 	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:TYZPR06MB7096.apcprd06.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(52116005)(376005)(1800799015)(366007)(38350700005);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 	=?us-ascii?Q?51O7RV5N74d8Rl9V8tMXMCYsuzmsmW6bm8yRgyT4aB5+rdttJlVPWw2X4vvG?=
 =?us-ascii?Q?unGLITVEMHCQk1HZceYVIyd4HR0qhsVk6MlUs7PZ7apwgT+vtvbarz3uNwAb?=
 =?us-ascii?Q?oHW6xnP/8w5tREDNS4QOjszGFRV3cxufjdfeZWh1VKT2zhMUiPcErRdMxGL0?=
 =?us-ascii?Q?88KVYxUD/cyH3bHlc+gZtAjQfClkPGk0ldXwB7U81otA0/PX+DL2cpmaCSj5?=
 =?us-ascii?Q?N+MuQJt6kWC2N5qVTLv4W4aKuVwDgVlJ8K4siZJuxon1v86Fk7XEXkUX5/c7?=
 =?us-ascii?Q?pRXfMefNbUKd4D2HoqJ7Jebm5k/NRdKRbwccsllOnoOrEl1K8FEXcPGWpNrg?=
 =?us-ascii?Q?V5/W4KcP+eOAaS2gOUbLC4rmtxcRIomGTK7S+suX73dcpCUH5hsVjzP8xB+H?=
 =?us-ascii?Q?zMY98MeRSOOXq/kcHqGoUVsYG5KLluZDKkqaVWanuw+aXy+R1AOnUGsaG5Gm?=
 =?us-ascii?Q?LTaFwTiQqe+E2R3xe1l76mgRTIu9Bs5IDSs1GWRwq2qwvFYyE1FcPgmPqTTH?=
 =?us-ascii?Q?FQ6O7usNs7Ld/3Bj3lKgSwAL+A1KRBU8kQ9VQi9TWl82cHjwYNcumNB234PW?=
 =?us-ascii?Q?fyCjDJPp36JYaNQKXEF5+Mat/eAes/TWYzNoL36b8TAsuyibDsmfenF1fCGa?=
 =?us-ascii?Q?jB441X/9M2Xja/vWD10hySB7zSzgixeUVyr21e9nYoTeUOKG6IV9CtEtLrxe?=
 =?us-ascii?Q?3Z0NnZjWDCfCR/NqDyOSxo+bB82QS5c9FOSv4NqtFVrVGarsyTwMSVXGdiLL?=
 =?us-ascii?Q?tVVgWQFogUOfoz46zg0t3i9N1+pxLUafAlkqAMfrJP3twGSjG8zZWRVTp6Nv?=
 =?us-ascii?Q?/QtdeEq0zxIif8FQ+FzpygYJeyptLrxXTff0p90qFeyrL3rjGAtQizWQjsEA?=
 =?us-ascii?Q?ykpm1yk2AmiLGHIipsHiuUorOL/KCPnXo+RAx2tdT/fjJ3+NQKQ7J1x6R15l?=
 =?us-ascii?Q?YYUjnKWa37qkL8j1jaUL6mEKhx73CoYSo4AzcP5lfldpjYhcYDCyHwFx5Cxo?=
 =?us-ascii?Q?CXz+vl5cfxvgl9KInA2MZ02qLh9ObOtoXhje77RZwhnXJhhVs6G9RXJ3vlMy?=
 =?us-ascii?Q?9r+VcF7KCEQwmVX1MwHJINfgttdJD4NB5g/fvi+dz8+OWj4KDA518WjX1dTp?=
 =?us-ascii?Q?MTNdk8K90IZVcRVVORsqfX8RoZoTIsfQhzTVmSrmqNWk25XjqvC2RtUOnWCI?=
 =?us-ascii?Q?gzX61S64U7wVpbzOZU5eoBUxwHoB4/QscOv71jdgaN63G+kJ9s6tjgdpjHhq?=
 =?us-ascii?Q?QxA65HBD2/Ywgf/Z48Ym/qlJBlFndKhuriCPNaz41SNjDCOCM0EFC9IbByQ5?=
 =?us-ascii?Q?cIUNOFUbg0Uo3U4LCTYB6mCHJ65diuTKv8pW34D1x/PZKFwP736Otmu9+Icz?=
 =?us-ascii?Q?Vew7JPXiVXhV2/qfsEJwU79YBM44A9ZvuasvWxBPbUlwtF5g/8HEOdKdQtyK?=
 =?us-ascii?Q?Oqd/gEPBcZRp0kcljHbIJPaIRDBO5ow4F4eVT26b1xo4Ws3OPMAQfEG2sPOu?=
 =?us-ascii?Q?EfWCZ4lsv9HSwuyof6foKmkUa/6sOTv5cB0NlxIIeGhQDb4/ZaXbvqJ1gxeG?=
 =?us-ascii?Q?VikSNyx5m0MIA3uXjtpiAsxfETjO9RXe79Sehgw0?=
X-OriginatorOrg: vivo.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 75133076-2233-41a6-66ec-08dc5251fe20
X-MS-Exchange-CrossTenant-AuthSource: TYZPR06MB7096.apcprd06.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 01 Apr 2024 13:45:29.1190
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 923e42dc-48d5-4cbe-b582-1a797a6412ed
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: QvbP0Nas9EgbXMuLAejNBw0Vj0Pel0SC34c9Xoq73pwnHiQLpnwKtw955j1+Cx26/wwLOUTyb+7OjGr9FYTj/Q==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SI2PR06MB5090
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
Cc: huyue2@coolpad.com, Gao Xiang <hsiangkao@linux.alibaba.com>, Chunhai Guo <guochunhai@vivo.com>, linux-erofs@lists.ozlabs.org
Errors-To: linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org
Sender: "Linux-erofs" <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>

It will cost more time if compressed buffers are allocated on demand for
low-latency algorithms (like lz4) so EROFS uses per-CPU buffers to keep
compressed data if in-place decompression is unfulfilled.  While it is kind
of wasteful of memory for a device with hundreds of CPUs, and only a small
number of CPUs concurrently decompress most of the time.

This patch renames it as 'global buffer pool' and makes it configurable.
This allows two or more CPUs to share a common buffer to reduce memory
occupation.

Suggested-by: Gao Xiang <xiang@kernel.org>
Reviewed-by: Gao Xiang <hsiangkao@linux.alibaba.com>
Signed-off-by: Chunhai Guo <guochunhai@vivo.com>
---
 fs/erofs/Makefile       |   2 +-
 fs/erofs/decompressor.c |   6 +-
 fs/erofs/internal.h     |  14 ++--
 fs/erofs/pcpubuf.c      | 148 ----------------------------------------
 fs/erofs/super.c        |   9 ++-
 fs/erofs/zutil.c        | 148 ++++++++++++++++++++++++++++++++++++++++
 6 files changed, 166 insertions(+), 161 deletions(-)
 delete mode 100644 fs/erofs/pcpubuf.c

diff --git a/fs/erofs/Makefile b/fs/erofs/Makefile
index 845eafdcee4a..20d1ec422443 100644
--- a/fs/erofs/Makefile
+++ b/fs/erofs/Makefile
@@ -3,7 +3,7 @@
 obj-$(CONFIG_EROFS_FS) += erofs.o
 erofs-objs := super.o inode.o data.o namei.o dir.o sysfs.o
 erofs-$(CONFIG_EROFS_FS_XATTR) += xattr.o
-erofs-$(CONFIG_EROFS_FS_ZIP) += decompressor.o zmap.o zdata.o pcpubuf.o zutil.o
+erofs-$(CONFIG_EROFS_FS_ZIP) += decompressor.o zmap.o zdata.o zutil.o
 erofs-$(CONFIG_EROFS_FS_ZIP_LZMA) += decompressor_lzma.o
 erofs-$(CONFIG_EROFS_FS_ZIP_DEFLATE) += decompressor_deflate.o
 erofs-$(CONFIG_EROFS_FS_ONDEMAND) += fscache.o
diff --git a/fs/erofs/decompressor.c b/fs/erofs/decompressor.c
index 2ec9b2bb628d..e1239d886984 100644
--- a/fs/erofs/decompressor.c
+++ b/fs/erofs/decompressor.c
@@ -54,7 +54,7 @@ static int z_erofs_load_lz4_config(struct super_block *sb,
 	sbi->lz4.max_distance_pages = distance ?
 					DIV_ROUND_UP(distance, PAGE_SIZE) + 1 :
 					LZ4_MAX_DISTANCE_PAGES;
-	return erofs_pcpubuf_growsize(sbi->lz4.max_pclusterblks);
+	return z_erofs_gbuf_growsize(sbi->lz4.max_pclusterblks);
 }
 
 /*
@@ -159,7 +159,7 @@ static void *z_erofs_lz4_handle_overlap(struct z_erofs_lz4_decompress_ctx *ctx,
 docopy:
 	/* Or copy compressed data which can be overlapped to per-CPU buffer */
 	in = rq->in;
-	src = erofs_get_pcpubuf(ctx->inpages);
+	src = z_erofs_get_gbuf(ctx->inpages);
 	if (!src) {
 		DBG_BUGON(1);
 		kunmap_local(inpage);
@@ -260,7 +260,7 @@ static int z_erofs_lz4_decompress_mem(struct z_erofs_lz4_decompress_ctx *ctx,
 	} else if (maptype == 1) {
 		vm_unmap_ram(src, ctx->inpages);
 	} else if (maptype == 2) {
-		erofs_put_pcpubuf(src);
+		z_erofs_put_gbuf(src);
 	} else if (maptype != 3) {
 		DBG_BUGON(1);
 		return -EFAULT;
diff --git a/fs/erofs/internal.h b/fs/erofs/internal.h
index 39c67119f43b..1caa5d702835 100644
--- a/fs/erofs/internal.h
+++ b/fs/erofs/internal.h
@@ -470,11 +470,11 @@ int erofs_try_to_free_all_cached_folios(struct erofs_sb_info *sbi,
 					struct erofs_workgroup *egrp);
 int z_erofs_map_blocks_iter(struct inode *inode, struct erofs_map_blocks *map,
 			    int flags);
-void *erofs_get_pcpubuf(unsigned int requiredpages);
-void erofs_put_pcpubuf(void *ptr);
-int erofs_pcpubuf_growsize(unsigned int nrpages);
-void __init erofs_pcpubuf_init(void);
-void erofs_pcpubuf_exit(void);
+void *z_erofs_get_gbuf(unsigned int requiredpages);
+void z_erofs_put_gbuf(void *ptr);
+int z_erofs_gbuf_growsize(unsigned int nrpages);
+int __init z_erofs_gbuf_init(void);
+void z_erofs_gbuf_exit(void);
 int erofs_init_managed_cache(struct super_block *sb);
 int z_erofs_parse_cfgs(struct super_block *sb, struct erofs_super_block *dsb);
 #else
@@ -484,8 +484,8 @@ static inline int erofs_init_shrinker(void) { return 0; }
 static inline void erofs_exit_shrinker(void) {}
 static inline int z_erofs_init_zip_subsystem(void) { return 0; }
 static inline void z_erofs_exit_zip_subsystem(void) {}
-static inline void erofs_pcpubuf_init(void) {}
-static inline void erofs_pcpubuf_exit(void) {}
+static inline void z_erofs_gbuf_init(void) {}
+static inline void z_erofs_gbuf_exit(void) {}
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
index c0eb139adb07..7d8718420136 100644
--- a/fs/erofs/super.c
+++ b/fs/erofs/super.c
@@ -873,7 +873,10 @@ static int __init erofs_module_init(void)
 	if (err)
 		goto deflate_err;
 
-	erofs_pcpubuf_init();
+	err = z_erofs_gbuf_init();
+	if (err)
+		goto gbuf_err;
+
 	err = z_erofs_init_zip_subsystem();
 	if (err)
 		goto zip_err;
@@ -893,6 +896,8 @@ static int __init erofs_module_init(void)
 sysfs_err:
 	z_erofs_exit_zip_subsystem();
 zip_err:
+	z_erofs_gbuf_exit();
+gbuf_err:
 	z_erofs_deflate_exit();
 deflate_err:
 	z_erofs_lzma_exit();
@@ -916,7 +921,7 @@ static void __exit erofs_module_exit(void)
 	z_erofs_lzma_exit();
 	erofs_exit_shrinker();
 	kmem_cache_destroy(erofs_inode_cachep);
-	erofs_pcpubuf_exit();
+	z_erofs_gbuf_exit();
 }
 
 static int erofs_statfs(struct dentry *dentry, struct kstatfs *buf)
diff --git a/fs/erofs/zutil.c b/fs/erofs/zutil.c
index 8cd30ac2091f..e13806681763 100644
--- a/fs/erofs/zutil.c
+++ b/fs/erofs/zutil.c
@@ -5,6 +5,18 @@
  */
 #include "internal.h"
 
+struct z_erofs_gbuf {
+	spinlock_t lock;
+	void *ptr;
+	struct page **pages;
+	unsigned int nrpages;
+};
+
+static struct z_erofs_gbuf *z_erofs_gbufpool;
+static unsigned int z_erofs_gbuf_count, z_erofs_gbuf_nrpages;
+
+module_param_named(global_buffers, z_erofs_gbuf_count, uint, 0444);
+
 static atomic_long_t erofs_global_shrink_cnt;	/* for all mounted instances */
 /* protected by 'erofs_sb_list_lock' */
 static unsigned int shrinker_run_no;
@@ -14,6 +26,142 @@ static DEFINE_SPINLOCK(erofs_sb_list_lock);
 static LIST_HEAD(erofs_sb_list);
 static struct shrinker *erofs_shrinker_info;
 
+static unsigned int z_erofs_gbuf_id(void)
+{
+	return smp_processor_id() % z_erofs_gbuf_count;
+}
+
+void *z_erofs_get_gbuf(unsigned int requiredpages)
+	__acquires(gbuf->lock)
+{
+	struct z_erofs_gbuf *gbuf;
+
+	gbuf = &z_erofs_gbufpool[z_erofs_gbuf_id()];
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
+void z_erofs_put_gbuf(void *ptr) __releases(gbuf->lock)
+{
+	struct z_erofs_gbuf *gbuf;
+
+	gbuf = &z_erofs_gbufpool[z_erofs_gbuf_id()];
+	DBG_BUGON(gbuf->ptr != ptr);
+	spin_unlock(&gbuf->lock);
+}
+
+int z_erofs_gbuf_growsize(unsigned int nrpages)
+{
+	static DEFINE_MUTEX(gbuf_resize_mutex);
+	struct page *pagepool = NULL;
+	int delta, ret, i, j;
+
+	mutex_lock(&gbuf_resize_mutex);
+	delta = nrpages - z_erofs_gbuf_nrpages;
+	ret = 0;
+	/* avoid shrinking gbufs, since no idea how many fses rely on */
+	if (delta <= 0)
+		goto out;
+
+	for (i = 0; i < z_erofs_gbuf_count; ++i) {
+		struct z_erofs_gbuf *gbuf = &z_erofs_gbufpool[i];
+		struct page **pages, **tmp_pages;
+		void *ptr, *old_ptr = NULL;
+
+		ret = -ENOMEM;
+		tmp_pages = kcalloc(nrpages, sizeof(*tmp_pages), GFP_KERNEL);
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
+	z_erofs_gbuf_nrpages = nrpages;
+	erofs_release_pages(&pagepool);
+out:
+	mutex_unlock(&gbuf_resize_mutex);
+	return ret;
+}
+
+int __init z_erofs_gbuf_init(void)
+{
+	unsigned int i = num_possible_cpus();
+
+	if (!z_erofs_gbuf_count)
+		z_erofs_gbuf_count = i;
+	else
+		z_erofs_gbuf_count = min(z_erofs_gbuf_count, i);
+
+	z_erofs_gbufpool = kcalloc(z_erofs_gbuf_count,
+			sizeof(*z_erofs_gbufpool), GFP_KERNEL);
+	if (!z_erofs_gbufpool)
+		return -ENOMEM;
+
+	for (i = 0; i < z_erofs_gbuf_count; ++i)
+		spin_lock_init(&z_erofs_gbufpool[i].lock);
+	return 0;
+}
+
+void z_erofs_gbuf_exit(void)
+{
+	int i;
+
+	for (i = 0; i < z_erofs_gbuf_count; ++i) {
+		struct z_erofs_gbuf *gbuf = &z_erofs_gbufpool[i];
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
+	kfree(z_erofs_gbufpool);
+}
+
 struct page *erofs_allocpage(struct page **pagepool, gfp_t gfp)
 {
 	struct page *page = *pagepool;
-- 
2.25.1

