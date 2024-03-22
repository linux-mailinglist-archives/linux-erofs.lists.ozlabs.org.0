Return-Path: <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>
X-Original-To: lists+linux-erofs@lfdr.de
Delivered-To: lists+linux-erofs@lfdr.de
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	by mail.lfdr.de (Postfix) with ESMTPS id 53DCF886D2D
	for <lists+linux-erofs@lfdr.de>; Fri, 22 Mar 2024 14:34:24 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=lists.ozlabs.org;
	s=201707; t=1711114462;
	bh=TKQO6N+6PtfQR8NO/iDcDazPIG8El5Hcsxo7inzvYKk=;
	h=To:Subject:Date:List-Id:List-Unsubscribe:List-Archive:List-Post:
	 List-Help:List-Subscribe:From:Reply-To:Cc:From;
	b=PoWtmhn8dcycZ8WpBw4SquLsr3EdZdjTk/1ZnGIMeM22s1avg+ZoYXJ0nxchF4f18
	 Ut2ZvSPBYcBNRJXUyMjG1z36LmhxlFpxi3wl5OTu/6PcYjP+Y0U3LBTw4giJEVa1P3
	 e4B/vvPD3rhtJvg6ra1Mmcx4Tm+ISq5jYZgBxSYWf/XU7Q7AgffhwUM0Xv16nCK1bz
	 c3caT89Zyudc4kHGzyFyl4GANW9oxsaezEjifd53cIEY79F0UBLTXdNreBar4ujr0t
	 pT1HrBtYgF2LDxiBRGa+XZL0G7d1gFcalTKQszaTREsjZBTbfzgQAgeDoNzLmyP9Fa
	 xN1WxOueEgXlA==
Received: from boromir.ozlabs.org (localhost [IPv6:::1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4V1NbL0jvtz3vrw
	for <lists+linux-erofs@lfdr.de>; Sat, 23 Mar 2024 00:34:22 +1100 (AEDT)
X-Original-To: linux-erofs@lists.ozlabs.org
Delivered-To: linux-erofs@lists.ozlabs.org
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=vivo.com header.i=@vivo.com header.a=rsa-sha256 header.s=selector2 header.b=e/cyRBc1;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=vivo.com (client-ip=2a01:111:f400:feae::61c; helo=apc01-psa-obe.outbound.protection.outlook.com; envelope-from=guochunhai@vivo.com; receiver=lists.ozlabs.org)
Received: from APC01-PSA-obe.outbound.protection.outlook.com (mail-psaapc01on2061c.outbound.protection.outlook.com [IPv6:2a01:111:f400:feae::61c])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4V1NbC35DNz3dvs
	for <linux-erofs@lists.ozlabs.org>; Sat, 23 Mar 2024 00:34:13 +1100 (AEDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=bPFwtn3EnTTKJZJ+nQNbp7QaJu8U/WS3bsCqr4AVaQXD+arSeA28IsW/FULXnVQGpeVrMOpUPO/lcKJy7zDyU3d6msjTZ2RBHw37uL2OH4FdZyzYRQHeMIva6v+mP/3Ea4m7oEshAIrvCLvF/oJRnu2FHPqEsgHuB7OEMnAmQcRSPvH/nZQmFdP8gRPDUEgDui93fjW86SqahSysKy5SX+dw/FUta9B8nP8nnQxzDbI1j+o/UQrz+U5XAfH1aBknAQv3RFNNKoeX0FrNTz0egBl+wHIL/o0yaU0hyXgYStKSB+NenT+aT56L4F7ZqTQi51QB/G5I+49xRjIez7kF7Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=TKQO6N+6PtfQR8NO/iDcDazPIG8El5Hcsxo7inzvYKk=;
 b=kHpQPxtXPs+KhvdnfdiZ2/8a46XvxcPKrEU/RDUbqxDY22w2HhkebVUW19s0kQOvU6UGgOnb7wYzSsuJneGRG+9MKimTAVKBcWtOTYBrF+87dR2hAyw8utoMaR4M+Aon2Phkvwbv4j0g7c963UxI5agcnyjutZwIj5LlJtynZGBnSB9BqLJjcwHsfnE6qWHpJysjDy1py7tSVRZNSvq6y64uhjCpJc+6Wt/ZCVOgVi6/i/2mgY+u3MrqBgIiqgLNYWiIFbMRbIi3OWS0q0moFZxwSChb1xWsBnPUDicf9KaJIJcHMo3/V9BX2zFZPPQ0LgEgPttC1BsQgnHEUbzNLA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=vivo.com; dmarc=pass action=none header.from=vivo.com;
 dkim=pass header.d=vivo.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=vivo.com;
Received: from TYZPR06MB7096.apcprd06.prod.outlook.com (2603:1096:405:b5::13)
 by TYUPR06MB5876.apcprd06.prod.outlook.com (2603:1096:400:35e::5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7386.34; Fri, 22 Mar
 2024 13:33:55 +0000
Received: from TYZPR06MB7096.apcprd06.prod.outlook.com
 ([fe80::e7c6:80cf:ec4b:9e17]) by TYZPR06MB7096.apcprd06.prod.outlook.com
 ([fe80::e7c6:80cf:ec4b:9e17%4]) with mapi id 15.20.7386.025; Fri, 22 Mar 2024
 13:33:55 +0000
To: xiang@kernel.org
Subject: [PATCH v3] erofs: rename per CPU buffer to global buffer pool and make it configurable
Date: Fri, 22 Mar 2024 07:45:40 -0600
Message-Id: <20240322134540.1118625-1-guochunhai@vivo.com>
X-Mailer: git-send-email 2.25.1
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SI2PR04CA0011.apcprd04.prod.outlook.com
 (2603:1096:4:197::10) To TYZPR06MB7096.apcprd06.prod.outlook.com
 (2603:1096:405:b5::13)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: TYZPR06MB7096:EE_|TYUPR06MB5876:EE_
X-MS-Office365-Filtering-Correlation-Id: 149c85d7-584b-4055-92d0-08dc4a74b856
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 	ncSSsK5UrWohZ3cg9eYui89kHzdzif4Rs8k380XSK33PRE/+WMiTKhfEYHYdS3gmtn0Suow7GE8dhQ7R404t61/MBVj6fdQWLyPSwRD19UarhBGb0Xmdh6di55vMH9BCD+mGZ6vwLvDdp12HhxSXEb3isYnzDV1IzTwTNhGMsOKrLyzUKN2vP59SHj1z/YO7yudixJ9eH26UPu5PxxsljU/sthS/Z4bwREg3qv/a0L7OT+hnLdeG/2BRj6lvBoPaXPrUzrSXSeot++YFAKFRjCgg8emms0lUgenQc+7zYqbO302E+vDMmyrWsaEzcUQN+2a90rHnIequPavNIThh+4iqLzK9TBYVPeGF7HrBaNsfJ/yr9ua0IVZwDhDVWgQAUo2h7M/Tah7AkzCCBCpNAgiChSrLMvU0Cfju1HUwGAS5BBAKFouqdu+KPBvddbpv6vVXVGrz/dEocb+EDPcxSovDarCwYbVfEmSkAalhwX5lX4aiuoKX9CtQ3ecFAggviVa1kVm1zVdd5ZI2/nFmF21x+g+2LYTvwhYDI0wv5P3z+INqtUF9Yy4i8O1ChbHsuU+uzQpVpIOg32lxLm7aRj3ZbtA2E4uQJQgawQK33orfPbmhE+2OcMo+9v0d7JUzjr5eZ+2akiFu8dtPOBHokaZpNQfGubWUxqLHpKINSImM06FFQy+Cof+4q1QpXZVhmuF4juJ7qXgCOHrWIZIOqaxRoAmZvjADg0kvgBluc8Y=
X-Forefront-Antispam-Report: 	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:TYZPR06MB7096.apcprd06.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(1800799015)(376005)(52116005)(366007)(38350700005);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 	=?us-ascii?Q?v6V7CdtMA50Y2cg1IvfsDLWUXkMJuMFRg1f84nH5k7uJ5Qp0NZWXbZrV6sSC?=
 =?us-ascii?Q?J+sT6MKTbrFKwVuLiA4l/u3OFHerjpASA64Nx1bI5rahcCeDyhst+h8x5HO/?=
 =?us-ascii?Q?bDzk2NFrt3UEiY7z0Dc9XGsR/rjuzyXHglKtmhWgfi70f66+bevlkeG+jr8n?=
 =?us-ascii?Q?HgfRU/XHxyd5njtBORyyfPQaKUbkDQz9l7r5+vgj13ouQ2BqLxIaFwEb/xX6?=
 =?us-ascii?Q?nh4RaN94a+zTY6mhhB7AbVSqKXOdrOnOL3RC5fsDHIPgQleqy3TJWMoBIT5K?=
 =?us-ascii?Q?LmXUWNakgxhYziKrrf1BLf5s217AIxM6mi5OTcHWoq9DLjcHGV8Z7nX9UuNn?=
 =?us-ascii?Q?TAitOlm5bzYbm1Vu6qs81a3b6LVSIRrua78uviN0LQigVYY0pYtEgUnIu3YZ?=
 =?us-ascii?Q?J4l7N5BCB7OTLEMUS52rEVTap+SLa2ps8Zupq4ULyFKjyFyIuTdUWCu4/rVB?=
 =?us-ascii?Q?QXxmRwvsQqzTcHg/qo0R+R09tS09fIAaAz1ndLfFzt5dqjgXC3xHiV7UM8zC?=
 =?us-ascii?Q?9zPOyC+9ZgL8P1WLz/4fftz7k4z0scIJdSqODQ3i4CZtaclwjhXguSupXJ4R?=
 =?us-ascii?Q?CFNhzkFMWwSNSuR2Rmd1xP6c6NqahT6DpN6sGCbAXGNxGt/peefChieeNlte?=
 =?us-ascii?Q?q+5mToQWxzJPVW9C4VFjoJGSJwjbV1xaEo2l1cDTorHdiItnhqAK3TbiyoBd?=
 =?us-ascii?Q?aUmG1vq0hxEkbuzz2SPKg5Q/kXtjwXSMjLshGiOInf07zFYo+WmNTmY73w1w?=
 =?us-ascii?Q?sA9iGrCPCBwBJnQ4xiWujBl2g1GeTw+VFAk3t2UIi5L0+AEhCrOgFOuVBApa?=
 =?us-ascii?Q?rHv7JHSElMCyx+F5UJaiit++RWAyfunLZrzXjLQAXByvDgClSL6ZOxuwp/rW?=
 =?us-ascii?Q?K696O8/fY/YGPoDa42nML6ykX4l5mLnVKkfUKXzxOCrpmsd4s/V05E1oxruH?=
 =?us-ascii?Q?hl1sxg3Y5wZGJZ7HD65pEAEpCb1c6KWAKm3FHS5ecCLYF01dwGS3+/VKf+qh?=
 =?us-ascii?Q?AhvDJETZ8jMIq+wXEFv6v2kZkw8pRuCFaPjGXVVKgOOt4EcOzlggOv5PVaAo?=
 =?us-ascii?Q?+TcgnIyCkpD1M11WYrUuMEu0Iungep38pPMciqCok/TuMxmVlSiZODybiJ6n?=
 =?us-ascii?Q?Mc7Wzqgz4v0O9h5sPxfegGydT/JybSdJIqiLVHG1cbtM4bgYKORaz5nGH8/7?=
 =?us-ascii?Q?iqfutgP7vxjQWKW42lT4XzeRnIpf/olspVwpKmsDgQx/8q+/TGO9vMfhkVNk?=
 =?us-ascii?Q?kpGLNeFzUZ+pKxojmw47e2fOn23VhcCC8PpAH7u8GHSNR7WzrX6m76InfYcf?=
 =?us-ascii?Q?awbBHn/r1cE2UVltaXnZyqfwhaKR1U4gaMvx/DeitgxY5to1Xr1VaGD4luIO?=
 =?us-ascii?Q?G7/Zi/cffiw6skBt9lZnFhJFISF5EEJr6sDD/f4I2MGHNX2lE7ltPt/Wmh/3?=
 =?us-ascii?Q?y3qf5dq23yIY/ZhyssEZg2o8xo2EUg4+z3SruXEmca1HxlOzE/Me71TwIeYF?=
 =?us-ascii?Q?Lho1z7rTza5NkTgJgAWIBrdkOJAdny5gAZciTbaD4PfRQE2M9O/a+Q4kX+U6?=
 =?us-ascii?Q?Jr93CtGmYfuG53t3xPBlgS9gV7lFI4ej1HhPWgas?=
X-OriginatorOrg: vivo.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 149c85d7-584b-4055-92d0-08dc4a74b856
X-MS-Exchange-CrossTenant-AuthSource: TYZPR06MB7096.apcprd06.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 22 Mar 2024 13:33:55.0823
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 923e42dc-48d5-4cbe-b582-1a797a6412ed
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 6TAv5wOH/iDPFu2MdoCqglZvbz1L+/d6cDKjDLN4uMGgunPRfrOmNSORpJRlafjOlxdc7FLTUdIdjsaMWGXHZA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TYUPR06MB5876
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
compressed data if in-place decompression is unfulfilled.  While it is kind
of wasteful of memory for a device with hundreds of CPUs, and only a small
number of CPUs concurrently decompress most of the time.

This patch renames it as 'global buffer pool' and makes it configurable.
This allows two or more CPUs to share a common buffer to reduce memory
occupation.

Signed-off-by: Chunhai Guo <guochunhai@vivo.com>
Suggested-by: Gao Xiang <xiang@kernel.org>
---
 fs/erofs/Makefile       |   2 +-
 fs/erofs/decompressor.c |   6 +-
 fs/erofs/internal.h     |  14 ++--
 fs/erofs/pcpubuf.c      | 148 ----------------------------------------
 fs/erofs/super.c        |   9 ++-
 fs/erofs/utils.c        | 148 ++++++++++++++++++++++++++++++++++++++++
 6 files changed, 166 insertions(+), 161 deletions(-)
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
index d4cee95af14c..72a11c5eba8f 100644
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
index b0409badb017..574a7c5b3929 100644
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
+void *z_erofs_get_gbuf(unsigned int requiredpages);
+void z_erofs_put_gbuf(void *ptr);
+int z_erofs_gbuf_growsize(unsigned int nrpages);
+int __init z_erofs_gbuf_init(void);
+void z_erofs_gbuf_exit(void);
 int erofs_init_managed_cache(struct super_block *sb);
 int z_erofs_parse_cfgs(struct super_block *sb, struct erofs_super_block *dsb);
 #else
@@ -485,8 +485,8 @@ static inline int erofs_init_shrinker(void) { return 0; }
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
index 5f60f163bd56..5a045a61801f 100644
--- a/fs/erofs/super.c
+++ b/fs/erofs/super.c
@@ -902,7 +902,10 @@ static int __init erofs_module_init(void)
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
@@ -922,6 +925,8 @@ static int __init erofs_module_init(void)
 sysfs_err:
 	z_erofs_exit_zip_subsystem();
 zip_err:
+	z_erofs_gbuf_exit();
+gbuf_err:
 	z_erofs_deflate_exit();
 deflate_err:
 	z_erofs_lzma_exit();
@@ -945,7 +950,7 @@ static void __exit erofs_module_exit(void)
 	z_erofs_lzma_exit();
 	erofs_exit_shrinker();
 	kmem_cache_destroy(erofs_inode_cachep);
-	erofs_pcpubuf_exit();
+	z_erofs_gbuf_exit();
 }
 
 static int erofs_statfs(struct dentry *dentry, struct kstatfs *buf)
diff --git a/fs/erofs/utils.c b/fs/erofs/utils.c
index e146d09151af..3cf2155bd3bf 100644
--- a/fs/erofs/utils.c
+++ b/fs/erofs/utils.c
@@ -284,4 +284,152 @@ void erofs_exit_shrinker(void)
 {
 	shrinker_free(erofs_shrinker_info);
 }
+
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
 #endif	/* !CONFIG_EROFS_FS_ZIP */
-- 
2.25.1

