Return-Path: <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>
X-Original-To: lists+linux-erofs@lfdr.de
Delivered-To: lists+linux-erofs@lfdr.de
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2404:9400:2:0:216:3eff:fee1:b9f1])
	by mail.lfdr.de (Postfix) with ESMTPS id 87385894F01
	for <lists+linux-erofs@lfdr.de>; Tue,  2 Apr 2024 11:48:47 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=lists.ozlabs.org;
	s=201707; t=1712051325;
	bh=LbEMDaaaa2nZQCMTcx4TacjSrBpqTbiXEj+TtJsBax0=;
	h=To:Subject:Date:List-Id:List-Unsubscribe:List-Archive:List-Post:
	 List-Help:List-Subscribe:From:Reply-To:Cc:From;
	b=nmby8JMop5hZqx24eMZR9CWV2jiaxSUehgECT81BqB7EpBFV/9h5pwEFbqs3SW41+
	 4wUIN/Mbe6yKXMGSnSKgVFeadq7Yvkm0DA6EfTRmz7JDdRYfyzOTP6uwySMGj9K2dx
	 lY0lqOxqx7zV4Mai3+LwqquCMb8W9wsf9fkNVJYnVQz82ZtG2TZLbUn7vHEyvMTcDe
	 1e+6RHW48GXyfJigeDbT22uhL/pXYqMoUfS4L8XdwoF5tj+QtiEBEuBYQHfbmhTGi8
	 AN2JGy+WRmuVsWr/7CdbTvUb6tS+n21ewsA87SvbFRCeCHaKGSiRsUEW6cA32ST4pN
	 K288+a7OlosaA==
Received: from boromir.ozlabs.org (localhost [IPv6:::1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4V833x2Xk3z3dRs
	for <lists+linux-erofs@lfdr.de>; Tue,  2 Apr 2024 20:48:45 +1100 (AEDT)
X-Original-To: linux-erofs@lists.ozlabs.org
Delivered-To: linux-erofs@lists.ozlabs.org
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=vivo.com header.i=@vivo.com header.a=rsa-sha256 header.s=selector2 header.b=SVC0Q6td;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=vivo.com (client-ip=2a01:111:f403:2011::701; helo=apc01-tyz-obe.outbound.protection.outlook.com; envelope-from=guochunhai@vivo.com; receiver=lists.ozlabs.org)
Received: from APC01-TYZ-obe.outbound.protection.outlook.com (mail-tyzapc01on20701.outbound.protection.outlook.com [IPv6:2a01:111:f403:2011::701])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4V833q5rkWz2xWJ
	for <linux-erofs@lists.ozlabs.org>; Tue,  2 Apr 2024 20:48:37 +1100 (AEDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=godg+bGp2A2MZytfWlj3tW9yCPyPoTElhceR5kC6pR854D+H7Vi9cMgi5EUSLfdsuXPbMAUO0JwJBdqc+y1PkIyg/Gx/Eu4RAxvIkagTF/Us2BflIP2WI0NwZRHlPypbO7GlPw8Kb+o+yIdTO+ntSdLTcS9ue6Tkn0EwuDuES0AICHaQen73JLZG+4BFQYBeI3rWVnCNtoXr1s2wq8LVZ8jM3SqQ/RO59PvKozzgEDWhNdgz3E1LS91dElfpaT4oV+jZ6JZSQCr6dVVp+rRWKDsC3dIEkJjRAxbkC1ecE8SOep3a8wnAoGWwTFWRdXgxfoHxBNNJMgAKDaJVU2X+OA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=LbEMDaaaa2nZQCMTcx4TacjSrBpqTbiXEj+TtJsBax0=;
 b=NUGKyLct0f55MY7o2NCxUYJjZRKCUtnCbEOHjatfB+FVm6oEZLsjrTMnnvAzr0dLOScp/nQA0HHfSf5EgSqekn5SoScbtNzZf1AJA+BPvABZPXwPSvHlMjnW+3pFfpjyYq6wH6x1RPhJ7bW+mk+tI34MUJL/uzNZ4+N2bSvbTjn08xv48g9j+1X2s6Vt9cmiMbsxD6o5d4wbig1UDoKvFqjCsjZx7uRD+YQum3IpcOcsgCLG00uAQTWtIJf6M7lu8mCedyHpe6t57QUelTvneN4pFMhYCazGU65R3dYRa6I0cOLxf2VoFuVlFOs+hfFf/z0DA9jfUnURuNnVJ4Nc6A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=vivo.com; dmarc=pass action=none header.from=vivo.com;
 dkim=pass header.d=vivo.com; arc=none
Received: from TYZPR06MB7096.apcprd06.prod.outlook.com (2603:1096:405:b5::13)
 by KL1PR0601MB5512.apcprd06.prod.outlook.com (2603:1096:820:bc::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7409.46; Tue, 2 Apr
 2024 09:48:14 +0000
Received: from TYZPR06MB7096.apcprd06.prod.outlook.com
 ([fe80::9eb4:3582:34e4:a83d]) by TYZPR06MB7096.apcprd06.prod.outlook.com
 ([fe80::9eb4:3582:34e4:a83d%6]) with mapi id 15.20.7409.042; Tue, 2 Apr 2024
 09:48:14 +0000
To: xiang@kernel.org
Subject: [PATCH v2] erofs: rename per-CPU buffers to global buffer pool and make it configurable
Date: Tue,  2 Apr 2024 04:00:36 -0600
Message-Id: <20240402100036.2673604-1-guochunhai@vivo.com>
X-Mailer: git-send-email 2.25.1
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SI2PR01CA0030.apcprd01.prod.exchangelabs.com
 (2603:1096:4:192::15) To TYZPR06MB7096.apcprd06.prod.outlook.com
 (2603:1096:405:b5::13)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: TYZPR06MB7096:EE_|KL1PR0601MB5512:EE_
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 	kFxfJUZmBh8XKgpQl/XKvxaS7X6juI6MiOLjds2Zly6GteUBObMFAHaJN2Odh99Tp2x/+Xvtq4841kzS/ndh6HX9Q70++Oo/Y69cVcB/uctxeML55tjFUDruqSTbuYvlX6s/qHYJamNLwMpFhVmjlbTFY/YX9JbRNjjccJ4GAzuRQEYz5mo9LHi9wy3xYXF61s2NLJiniuykOoB34+HRzAueLgGjTRuBgRGXcFfuv7lUKFaA0nn6lwzLw0gLP1o7U0Y6qetbR9Hkp1daOVC9+BvHxrFFLaEh9ZW85xsiIXwkBdyOIS5wJLYness+d1OQM5GPaJ2soG11+EhaRC5CoVqVkscOc7Z9DYGhOFyWmnS9vPeb5QyEjLLJXTVVtyYcuaYB3Id0MtFq8j0lxylLx2fPl012MimcZYmBIeXWjFMOz6vy5a3znhXFC/bx3FP0sBYqhCd7PGpGTpBLHLiRC6VUa7yymspE4gWBdp/Z8WWUNfsJUUEr2lKNtUXRAT36mkEvBTbMsVfkev8VgJb9CuSiio6Csj4VxifmI1cboe0qOwRp3RW+C7hbncwOYEc/HBgxHlRILD7tqhdVT8SiZsSZmyWfkaTSJbseSMMPvQQBL0PGq7oYCbQLD73UsvgcQZ7bA+1pT0atjEAaS0C0O92kMDaC11IdTcNHvSkPe8Ck4e8updEP3+YEzByLp5sJgV/iHsiSNpKXM23nCkOszg==
X-Forefront-Antispam-Report: 	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:TYZPR06MB7096.apcprd06.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(366007)(1800799015)(52116005)(376005)(38350700005);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 	=?us-ascii?Q?fCDf82j37bdOxLE4p2vO98lK1BrkvyS7t6ERXz4ges7gK3cTBVdvUtZjGJCO?=
 =?us-ascii?Q?8duU/f4I+icARcy9Yg5pz/1wjcyi4sNj5P6hDKw2GW50bJCc6Qpebd2KYo5o?=
 =?us-ascii?Q?nCrTqit95sqje30vfrzQRWC96Duijz3SEZf99V7H8aTZPzws57gn/klnCWX2?=
 =?us-ascii?Q?SsPmac9c3aswSdgNsVrDuRhBBki4mQT/8e49j5NyMRY2YAmmuCIZSQp2U9VP?=
 =?us-ascii?Q?3JCn+gKz4owo97p0UZy5GSFjq4FxZglYIVCl8N9IZICEzibCDFN6K/wTU/1M?=
 =?us-ascii?Q?ACYTAYBAAAmwG3Ms91J5MotK38aJqwgncBeAc/ckLohom1Ar38WU85AObdOy?=
 =?us-ascii?Q?/9MWPQa2yJly+h2BH/nqM17rlms6oAMcqf+J38lcrOOGE4nclG9u64W/Nqyr?=
 =?us-ascii?Q?D45r3yzWfN+mXE6VX0ui2NBrRAHmwfVNwCTpC59YyMArMnq3X9zU8b0ghx0y?=
 =?us-ascii?Q?a1Dn+PgvuHiUodBmJqTCdwcw++QI2CCubZkGHXav2X1iFqsDTVIdi+niPZPG?=
 =?us-ascii?Q?6vbDpOIn7o9mbNlYyIKii6077oyb8D7SqKaSB1d27hTMDQl6ZQueEnmfVsrd?=
 =?us-ascii?Q?JTCbPtomc7zqlJklg1hU2Xra4GoF8xZ7yJS7Lb6MI9bE6d6hBc9ygc9iAwUf?=
 =?us-ascii?Q?TQbL9FK0RczpUKGf2VhzD9nSAcIJ+rbxfv3sbEg8DXe1qFXDx/v5piMJnaXN?=
 =?us-ascii?Q?lT53qbNMtZcr7EFpWkiXqFB2RBBMyGLNYVWUbSL0lBKQco1+e/nCzOtiMCTN?=
 =?us-ascii?Q?wQflfxOs59/AeJsTOk1Me8sepPSB1bIEllrB4yeQkd7BJfSLDzyKLi58rmXk?=
 =?us-ascii?Q?sZoi6JJbGMJHNampf2TT/FWIj4sLR31F00X9hUDyjw3tedOpLT+eyYUMX625?=
 =?us-ascii?Q?c63BgCC1HmD8S/qBskD+aoth2gHZMmBPJn9Xkg/IbSKwfdAaFOvUumlqlXZM?=
 =?us-ascii?Q?DMVNL/E4miX+v4NGYVL1uB0HXJ57mbt+RWEvay9GGkUOdVP1v3QxfTN/+Ll6?=
 =?us-ascii?Q?bWkmu0LsgZ+XwyOBnvfRMwig+eM9iBVFgrIgnb12j3hzF0cOnyzCYawfj4so?=
 =?us-ascii?Q?TmCSjPaM8p9nXSVE1YeNZNJF/GZsqCcdMizMtbgN4tO8BcJJelxGfurXrHPp?=
 =?us-ascii?Q?/THim9WObR68HBZpztsQKxzecGEEAfqKaYRaUS75jWZ+qBrWmyXJdHXYzMbg?=
 =?us-ascii?Q?NjAhnRkw7e1Er6oi1KhkmyAohBNs4fCmBDl00OXOSGo7RUlmqtuFPKzTuqX4?=
 =?us-ascii?Q?M/+B5ymZpiJRdBTv95DQx6axDQzhksjxM2DAYZcyq6wUyq8JZ4eByE2yop5v?=
 =?us-ascii?Q?QAXgEvyhYvOohvBNS5pZjbO5yi9jY+yCbfJXPaBX3gJbllCD88sTe4ND2roM?=
 =?us-ascii?Q?OuTY6/XY60fnIg6rH1Vn9U69HjrNkoaTjtHJ2dMY+YD1hBo/s9hv1D7XzW17?=
 =?us-ascii?Q?wnP1De9DbFhIWAJkG1+edY3WU7NDVf037A3LHHIWX2Bq/MyRMi0WVSW5xGM/?=
 =?us-ascii?Q?Ivt28Q00wPFVY3qvMrbZC7EDimZq2B8QhHcwBQ6xmtjBmL8ZFlfaaPvuXafJ?=
 =?us-ascii?Q?3iEUeefOvCgF5q1Dtx1tgjb9+fQNBcdPxEvJl0kw?=
X-OriginatorOrg: vivo.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 65e2b6c2-8466-43c9-f848-08dc52fa0431
X-MS-Exchange-CrossTenant-AuthSource: TYZPR06MB7096.apcprd06.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 02 Apr 2024 09:48:14.7456
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 923e42dc-48d5-4cbe-b582-1a797a6412ed
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: +a6dyPspTuxOsjnribgjRa7EJ9i6580gtAnXUSB2bFYWhouzawRhYiKEin5f+eIx8Wb6eiHUjUzCAUM8465qdA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: KL1PR0601MB5512
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
V1 -> V2: Fix compiling error when CONFIG_EROFS_FS_ZIP is disabled.
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
index 39c67119f43b..2ebbf3333800 100644
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
+static inline int z_erofs_gbuf_init(void) { return 0; }
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

