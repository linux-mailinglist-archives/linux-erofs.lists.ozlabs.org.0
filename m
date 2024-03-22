Return-Path: <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>
X-Original-To: lists+linux-erofs@lfdr.de
Delivered-To: lists+linux-erofs@lfdr.de
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2404:9400:2:0:216:3eff:fee1:b9f1])
	by mail.lfdr.de (Postfix) with ESMTPS id 82EE9886B5C
	for <lists+linux-erofs@lfdr.de>; Fri, 22 Mar 2024 12:36:25 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=lists.ozlabs.org;
	s=201707; t=1711107383;
	bh=0mc350fUeVA+j/6Xk2QhfX5aR1age8YA2WRWDnfHKCk=;
	h=To:Subject:Date:List-Id:List-Unsubscribe:List-Archive:List-Post:
	 List-Help:List-Subscribe:From:Reply-To:Cc:From;
	b=m0rxbD19MnMMES10950CsV0NNcXCwVGhZyhFqOHyY8cZ+wTmIdPIg1GIiHhLE7SmI
	 9jeGAFznEleb1UEbAQ07z1MK/ie/0PN2GblrzE11TaM3uN2bTWWpOpO2BP39DmuFIR
	 UnVttC0r+c+76tMUtXBYGQGfq6tQlGCu8munDrRFk1PPgn40rHqF3GarEL36pcQ+q6
	 A/eKtzAch2JBsEaQnuAtlhB/QHGSUN/+1WPc5oZcLqQQsr2Db4KFDVSfQj1Wnb+Ud5
	 j2uOOMei1RpXENVKBzm/H6niElXZSY5Ub2LAs30z3+db+24Di351aYRAgGpk4K43t2
	 UpD51fvFqG9/A==
Received: from boromir.ozlabs.org (localhost [IPv6:::1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4V1KzC23Rdz3vZ8
	for <lists+linux-erofs@lfdr.de>; Fri, 22 Mar 2024 22:36:23 +1100 (AEDT)
X-Original-To: linux-erofs@lists.ozlabs.org
Delivered-To: linux-erofs@lists.ozlabs.org
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=vivo.com header.i=@vivo.com header.a=rsa-sha256 header.s=selector2 header.b=CWZS3vHn;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=vivo.com (client-ip=2a01:111:f400:feae::622; helo=apc01-psa-obe.outbound.protection.outlook.com; envelope-from=guochunhai@vivo.com; receiver=lists.ozlabs.org)
Received: from APC01-PSA-obe.outbound.protection.outlook.com (mail-psaapc01on20622.outbound.protection.outlook.com [IPv6:2a01:111:f400:feae::622])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4V1Kz72FRtz3vYW
	for <linux-erofs@lists.ozlabs.org>; Fri, 22 Mar 2024 22:36:17 +1100 (AEDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=B6MvYTPu5+IeRQJ9CvwuuU96QOp3MwWpkBKhE2/a5aeYib0S3ILSVTYqNapH/cXZp9gLKE0zIzE2poAycgt/4u6p0wpOsms8MClOCEhly8gBDSoKzieJIfJMgpahVDL4BGqQKRmlefl2hmkZTqObysKZwC7qyOmO+Y/tbD8EQnCElAGzdoVJ4g46mz4C2eskNOMW6QdHUCiDEyG49qatAYKAu6HHFWg0NoZ79yf/GerQMr7LvVo6ty7nEe+8RT82qIbG9o9S7vcpMBaSCYRZaUBIGsTsyRbZdwwju9sOAvUYvsQw3dds51VYjOtry39gshgCFVCnD1oQji9Gw9TgPg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=0mc350fUeVA+j/6Xk2QhfX5aR1age8YA2WRWDnfHKCk=;
 b=J2y8exBHtfqE9eeoEkHTnxWqd1bGlCaraxxFRPD7ezRbmxEAhGvsVDGIX2fl8pVev6p+Kjo3SwEHXRLXYKmRDRSxcEXUiQXhd2S3T8yyLTeUiivuaorA0ZK85ZcYsJKO4mNnnh/kDlKd1zKp57JOoFcG1TPnWlc8tmrOcAh5ZWpdLS/5McOY+emlaQ5nLdngyos5qVKB8FV/j4LAAs62t1aTuO/X6CWQUVuo4DKXN4lgWhhlJKerFOSD3zxPnfaEb4OSZNiEU7RH3buhuaJwCK/pL8tR5c2240Ea3mRtfE94eirulId09jNvFSDpTjRqk/NAeNi6ddp4EgBgGoSvWQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=vivo.com; dmarc=pass action=none header.from=vivo.com;
 dkim=pass header.d=vivo.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=vivo.com;
Received: from TYZPR06MB7096.apcprd06.prod.outlook.com (2603:1096:405:b5::13)
 by SEZPR06MB5810.apcprd06.prod.outlook.com (2603:1096:101:ab::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7409.24; Fri, 22 Mar
 2024 11:35:57 +0000
Received: from TYZPR06MB7096.apcprd06.prod.outlook.com
 ([fe80::e7c6:80cf:ec4b:9e17]) by TYZPR06MB7096.apcprd06.prod.outlook.com
 ([fe80::e7c6:80cf:ec4b:9e17%4]) with mapi id 15.20.7386.025; Fri, 22 Mar 2024
 11:35:57 +0000
To: xiang@kernel.org
Subject: [PATCH v2] erofs: rename per CPU buffer to global buffer pool and make it configurable
Date: Fri, 22 Mar 2024 05:48:02 -0600
Message-Id: <20240322114802.1096545-1-guochunhai@vivo.com>
X-Mailer: git-send-email 2.25.1
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SG2PR03CA0108.apcprd03.prod.outlook.com
 (2603:1096:4:7c::36) To TYZPR06MB7096.apcprd06.prod.outlook.com
 (2603:1096:405:b5::13)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: TYZPR06MB7096:EE_|SEZPR06MB5810:EE_
X-MS-Office365-Filtering-Correlation-Id: 259e8fcf-5b1c-4491-8ecd-08dc4a643dd6
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 	A7hM6TcNg4xUMefWTpJQxCQAJjbRn0+y8SrmZiQcVbbbE6KOPo40BUPcbhNr6cOQyC47dj2dxVWvQFxR947QigCDJS22qEB7aNkvxmcue1TLzKuxTGnqYxFjtqMmVfXKinRU3iBgfABcSULBA6jFSMS+72oPMWuzkaEg4u4COMTmZCUD4y5PgLxf+ssVKoYtrpOSlCFVsz85/r3z9TVUTkcTFIfXrrytUIfRsIxK6qHVqzwiRrwIsItcKd0Elg6UP/TRSCVrXapJ/q5B4riDKzD5esPSVeI138xZ7bRXk+z0N2D8lj1OPgjlOID5HyGxuQVfrnSSLVBgFKtXOEe+P9OYC2scjodeWqIyrQoyCGgNG1t/w+GPpu9AldwPgxCSTnQRe2uCJFfvxAI/szFG4Aj2LeZZ+Zk++IjJXtzdB+TMNKjxBnVayNKAYXymyAy9p8yO7LgeKtIAqCC75rLDhYmUKbazIFcs9SEBWQUBmZ6Do//5q/SbamtwpzukCSinvO0rejP/uj8srjmXr4V+ghn0DFLcc0+riAGZl460AjZNnA0Z3n1aUSIU4fmqk2QrHXQT6XOr+2jupa5Yln8kBg8chCPQONfQ1dFY9aSKWMw6F6Yh7Vou2vbGmFYxufUkZcBE3bmdRYfF8X0TbJ3dPWSh3Zpwl1B9H1o5thfiLw0lNucmKu/k7EVsuBRut1ta3BjqS+8xu36kBKF0Oyr3TPArp7f/v0aO81IJrPec7yw=
X-Forefront-Antispam-Report: 	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:TYZPR06MB7096.apcprd06.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(52116005)(376005)(366007)(1800799015)(38350700005);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 	=?us-ascii?Q?YaOmwJAA+DTNANLC/flz5e/9KVwHheH7xdxnFujRI8ixAdfgo0Kku94fea9o?=
 =?us-ascii?Q?IqIKzIrME3kT3yM4NIlKzk0OXumsZELE5uLdN0JmfNkAjaIcpEVe0ox2sAAE?=
 =?us-ascii?Q?Dmq2BV4C6gWxwU5w5pw3J4OSA7srMZ/tK/4qCwEgOvRzMcXz3FKyZXwSUYtw?=
 =?us-ascii?Q?6yl0pKNxcyC6O70yFtFMXuRax7S8wncVC4d6/vpenGp4LX7wYJsSjwT2HPRt?=
 =?us-ascii?Q?t9NZPsepi+jWXFXjlMksCqOqOB0LftixUjG6rbQojyrrALc852qALbd9cy1b?=
 =?us-ascii?Q?Ce0Ov2CRqjGBai9M6+S9js890mnz0lsm/K075myyD9Yqlu9MOzzsyM+KZLfH?=
 =?us-ascii?Q?ECoy8CrSbMFNRnedugDHOTAw0OiQitu9N9aqsFiA/PhWW/yNlLMLUI2tPA6h?=
 =?us-ascii?Q?65HEIIh2xpKPxoWA/Jwgp9yC4n0V1lKNQ3SSBHNjoTtm/GY04DAwT3mlUfjZ?=
 =?us-ascii?Q?/fD2kc1aRW144ySUa7KPOHR2BeItYLqDioFMrc/itsUpyrA61YyxAH0wiN2e?=
 =?us-ascii?Q?YS5hewFR7miz6KhUNPHUmIHlS0lgAhrdfEIRlMzpDTpAv8TZEYJsKuJs6uFH?=
 =?us-ascii?Q?Fft2h/4WpY63EeyPKZ9w9PFU2MS9ycCVr50mn2bEbiyPelhihgPf9g9nvWmK?=
 =?us-ascii?Q?VkEU1OcOrqr0yuha5kG+3eFkrr2CrcaU+cEulydSH4MbgJPKprnymc84lIIY?=
 =?us-ascii?Q?tTlaAVxQaGI9hp1aLBuTTS33E/jTkYZNApn8Sn+M5IlaqOb2hn0FkuVU3I/W?=
 =?us-ascii?Q?F+v4hTVN33VKywg9BbdebESt6gmtJeCOFnSQ1672qaIMrfgMZqVN/6WVNZWC?=
 =?us-ascii?Q?GRSK6UpohmIhySZT6m98sK4+EiUXVtwAlrWL4UoO7mPj/9Q4mqscfJyTxRzk?=
 =?us-ascii?Q?kLsj4SlAqqW9R8NLcK8Jit6nnyGw9mDBXPAGZs1knCqwMqNzR8RpypuPBChQ?=
 =?us-ascii?Q?2QVm7klZ0eyid8698oXrxf4zR0YrySrGha+WRjH4ZzVxhiKe6L6zLT3xjoU0?=
 =?us-ascii?Q?+kaAmZyt2ygxT8nWFShJPnJ52lO2bXxqHbs9BqxSO/xz6ZQQE8qbYbyzmuQx?=
 =?us-ascii?Q?NcNquz/EQy1EQC770Sq1cVwbelSqGvQdyDWJUuQHj0SPsZdFqQjl5n5+JDyD?=
 =?us-ascii?Q?qRwCOUMaxQHsiP4y/wwHiTZTd1tjNA9TsKeJ1oQlAzMNrDeDC7aku2ZdeqIZ?=
 =?us-ascii?Q?4e8jNw/j5SQsJhVnmJBHTwTiROnLvmSgqn1l7/gsffyzmOo27k9ujliwfT4N?=
 =?us-ascii?Q?u+J1+msmIBRIzZigO/ag+b9qWmusxk4oyGvEMuCaY5hVWuzckuFMWvigf7Dl?=
 =?us-ascii?Q?Zqu8m1FjegmrRqXA68ZvJZiYvIbm0PvAm52yWRebtA8ENBrX96/HHoPDeF4W?=
 =?us-ascii?Q?sFvZUe5Lrv2EkBCY+hU+pp78KsXHKCMWaukcp8d/OVbWm19dBdWBlr5tHR0H?=
 =?us-ascii?Q?5e6oD7j3WcW6tc/kxF8GuDiYJgxUKPjCAEjvnni/QIM+4xUlm2v6Y0r4H23e?=
 =?us-ascii?Q?7GQJBfQ8YprKFLj9jlixcDfqQgl+zJWVaIwFcFQbcY05o9Z2owQtm65wc1PG?=
 =?us-ascii?Q?OYjQHjnO4UWK92snjm+sx/UGEQpQt5pF7pU7oGlX?=
X-OriginatorOrg: vivo.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 259e8fcf-5b1c-4491-8ecd-08dc4a643dd6
X-MS-Exchange-CrossTenant-AuthSource: TYZPR06MB7096.apcprd06.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 22 Mar 2024 11:35:57.6360
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 923e42dc-48d5-4cbe-b582-1a797a6412ed
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: EUbS5iOae8ErnvJcY3HT/OIjfs+wzxfA05MhR3UxdLC8Ac8zb/j1AIw+WHWf/0m4W/ZwP8KDWMMkXGz1xWcpKw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SEZPR06MB5810
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
index e146d09151af..7b552bb8c36e 100644
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
+struct z_erofs_gbuf *z_erofs_gbufpool;
+unsigned int z_erofs_gbuf_count, z_erofs_gbuf_nrpages;
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

