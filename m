Return-Path: <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>
X-Original-To: lists+linux-erofs@lfdr.de
Delivered-To: lists+linux-erofs@lfdr.de
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	by mail.lfdr.de (Postfix) with ESMTPS id 8630A894D95
	for <lists+linux-erofs@lfdr.de>; Tue,  2 Apr 2024 10:33:35 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=lists.ozlabs.org;
	s=201707; t=1712046813;
	bh=7FZYnp8WTc1TqwBJXJSvDlQAfBHhTWQ9B8xhvgqdMDQ=;
	h=To:Subject:Date:List-Id:List-Unsubscribe:List-Archive:List-Post:
	 List-Help:List-Subscribe:From:Reply-To:Cc:From;
	b=IHePMbHZESOEjTjQ3ApKiIQ5yqrwEsxP+vcrtFk7G69f8ZvTTupRrjOFfum4EFPBn
	 mtOUcLjZlcGgVFhKmcGlk3Dr8Y3bdhsCiZ/53HzXdqc2CS5miByBA+ylBSaAid0lNf
	 M1zoo1jLVnSub74PiVWRyoIe/tW8RJ+tv1XkE8ClmnbmgPsjmBSd5mwVyqNsKiZKSQ
	 zTomOgSm9rz5s5Mbz7SrQpWyj3UqLiN2woAm+f2QE3mlsL53S+MhbflGlkUArLeJZL
	 IWcTa3M1tef29pYAcSMWw9CMjxAZ35U/CFgkpqTiBvHCXW2/mjvA1E8csumCMw1Si+
	 1nIqSCLiQbWGg==
Received: from boromir.ozlabs.org (localhost [IPv6:::1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4V81P9314Lz3dRY
	for <lists+linux-erofs@lfdr.de>; Tue,  2 Apr 2024 19:33:33 +1100 (AEDT)
X-Original-To: linux-erofs@lists.ozlabs.org
Delivered-To: linux-erofs@lists.ozlabs.org
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=vivo.com header.i=@vivo.com header.a=rsa-sha256 header.s=selector2 header.b=OFGsa+8t;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=vivo.com (client-ip=2a01:111:f400:feae::709; helo=apc01-psa-obe.outbound.protection.outlook.com; envelope-from=guochunhai@vivo.com; receiver=lists.ozlabs.org)
Received: from APC01-PSA-obe.outbound.protection.outlook.com (mail-psaapc01on20709.outbound.protection.outlook.com [IPv6:2a01:111:f400:feae::709])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4V81P32sbrz2yhZ
	for <linux-erofs@lists.ozlabs.org>; Tue,  2 Apr 2024 19:33:27 +1100 (AEDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=VbgkNFDDT5KQhZsfAT/YzE20H36k+MhlJXLYTOcfKGKaCBaEj8JblZau3h7H5WSPkY2SY1qVw2aWEVHwK5pAsSmLYnALJDr3QgW1VicWegBWMDu/OiQ/Tkzd825ETupZW1pDxUdpK7G4nUm/DqrVp3Q7WkP2VcPYKV+aAfM7fdxsGr4gWj0GWbRLLD0409YqDF1tEKDhd3qw6c9FEnhRJH0iU5zA5lLDlKgalKLUyicINECNQOCMtm7PpL4ecE4b0eD5f9X+57EJDu1H2a66C79XCTKbJ+u7Oo2zNiw+Vx2M7nNuAU/KNj/nsyYnoAdbj8iq6Zvz60z5RBm//5dd+g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=7FZYnp8WTc1TqwBJXJSvDlQAfBHhTWQ9B8xhvgqdMDQ=;
 b=GTxHm0QmF+5AgWzWyX0mkfE39dyhHYbQ66Dk5r0SGoMiBvWVUVWwhkf53gJ2ve/KKBUfid5+Doz5WgyFKz2jX/Dv5pSRSA1CKleTUbhnrvr/2zdCCOZaSA77oHqDTS33qT0kuenEBbD/4u29zsgNey5FaCtPoNjSZ0eNCaycDaZou4+VhW1jTgj/R6U5Ifx4L5Yw68HPOpqk1FUe9Z0MjU1wIcfLGAb8kCQsnagOBWZnsJITepyEU5q6A/sfActlwL0M0ZB98nGmbEjuSQjVDdaNaRLu6wmwV8UDKYFp8w0f6elyWMsh7twbG95CBzu9FjeZKeYvl+m/g5k0r31azA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=vivo.com; dmarc=pass action=none header.from=vivo.com;
 dkim=pass header.d=vivo.com; arc=none
Received: from TYZPR06MB7096.apcprd06.prod.outlook.com (2603:1096:405:b5::13)
 by KL1PR06MB7051.apcprd06.prod.outlook.com (2603:1096:820:11c::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7409.46; Tue, 2 Apr
 2024 08:33:08 +0000
Received: from TYZPR06MB7096.apcprd06.prod.outlook.com
 ([fe80::9eb4:3582:34e4:a83d]) by TYZPR06MB7096.apcprd06.prod.outlook.com
 ([fe80::9eb4:3582:34e4:a83d%6]) with mapi id 15.20.7409.042; Tue, 2 Apr 2024
 08:33:08 +0000
To: xiang@kernel.org
Subject: [PATCH] erofs: add a reserved buffer pool for lz4 decompression
Date: Tue,  2 Apr 2024 02:45:25 -0600
Message-Id: <20240402084525.2624202-1-guochunhai@vivo.com>
X-Mailer: git-send-email 2.25.1
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SI2PR04CA0015.apcprd04.prod.outlook.com
 (2603:1096:4:197::21) To TYZPR06MB7096.apcprd06.prod.outlook.com
 (2603:1096:405:b5::13)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: TYZPR06MB7096:EE_|KL1PR06MB7051:EE_
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 	IdyomrJ6ZDy2h9mEtOuiGVOiNvcDe17BKdbBU3CivkUQUivShlexpw8rcKW/4v84TRaPE/UUvQ1mhsHw69YAFD8J+bJBfGHtHwQi3gpGzy5y1p5zft5DEV1E2QN1TLNS9jPgwv6XqVkfq/OG2GZMSf19u9wGc/SkHqrVLmsakGMokRxaIyiZq3zETVNXpFQwjguDeI6uMUAA4SuUIQXh6iTvlBH/YF0JW2/oBSr6tYmMoaPj1YnqhyGqXx8O+A99VcIIegoYzt0KUx2sYlY/2lOOuDTwrqmSHLm9sD3o62iXVb7vIWFhI/D5Rfql4Fnd+fnqBjtMBLOhEdsYHTdgBkhTMtS94fnAllvutMIIT7YIeQ8tOClbGO3AwIZePStBB8Z9+4nUQijFOYHoC8F7gZS5QiPghUzarF4ozlY7nhfOG+dRcoLXwgZJuA0bDzV+mg14LIomBPk8RWSj/w3H0snlw3ybLZCZndBvnaAk9WDMvZi/SNg9oURaaFNH+Y7tq1SRVAU7r9slZeMWDcYCF4UBF0zqGaNgbRZe4SrbNfHIMkP/vfOCEEBFjnaP9uTNazkkMaa6VfCxJEIN7vbTJwm6drU6RKCLgT+qp/OJHaZC96d2JAu5oqBdwDPRqEkaUUaQEs92pOL1kv+R0gDI4/8v9/BnAEbaF5t9W74sTsXv6ChIyReeRGl9DOqC4IS3vUaEUZoLK33fwV0szF5sj0FO1H67KNa2tPqRhlO4DCQ=
X-Forefront-Antispam-Report: 	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:TYZPR06MB7096.apcprd06.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(1800799015)(52116005)(376005)(366007)(38350700005);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 	=?us-ascii?Q?BAd2srQSZbmx9lkFMRMakToTUdeVceIsP3yKOSrPtCGoHimpgiKt1Mhyni2v?=
 =?us-ascii?Q?2m0NysyYrNxI2GzOAlggMsqPbCnS8IHjHHK+oHVBXije8qR7srwOZ78HZcq/?=
 =?us-ascii?Q?6lCRR/LOWMyn9E6BsNcavJLhOba/5S4pNzpQZV+hVCkwuleYD+pvxph3L+4x?=
 =?us-ascii?Q?LHoCXWYFtryvUEFGTo7LuGw0/ogW8ed2xfaKCxUWFRzUR4jN0oJF2csKCpFw?=
 =?us-ascii?Q?d6H2ms8RYMGsmlmquYbnvEwMsxW8Z+Fr4oeSdHvdYY//ajY7gwKNzrB01zVh?=
 =?us-ascii?Q?kGkaPshX0L2K23VxB+bk+O4CXcP1lYYDxxtlLDAEWYJeIQxv1HDjE73wsw8v?=
 =?us-ascii?Q?/6CUt8mDAWMY+i/5wq8pSZGpxGiDkWpICPWrB3vC52u9VbPe3ZdYfmQWxRDV?=
 =?us-ascii?Q?znNRzCwP7J+RChbgk332Z+qYXNcgIMd0O5IXhev/OwX6/G7o9oWeKiR7oI0o?=
 =?us-ascii?Q?dBTEGLAOT93a689uN3ZsJk09gTnOWy0CabzQBV+MlfSLYFFOQg0EK2Kd/hMv?=
 =?us-ascii?Q?g1HFY/3fhumqw3gccZcz+MG9r63S8b/pjHvQSx2lInYmTwwArUSn2TZbjReE?=
 =?us-ascii?Q?wHWjJ2vqX3eGTMJ8E+jpRF7dWt+MpOSg3Xrx4PqyEPs/b2ODjvqqZbgT8WZm?=
 =?us-ascii?Q?1/pDmwj9FHaDYYy+Sfsw/9vKMyWFXWl/Fbl8X0qMRlp7UtTQdkSqIFgiM3f2?=
 =?us-ascii?Q?GXayeglfS6Cpu9/jwFQp+q2fyQSp8NqjwzJ2n+qXX48Lu6dMeIB4whf5VxOZ?=
 =?us-ascii?Q?jvdpUYuQOdEHdw/o9eqTSUD9mIO7AMCreCozP/DvdQpnZ0BtjHTUOiT4dVnD?=
 =?us-ascii?Q?IwJKaYnozyQERk89c4WuVdaAFxDgTgl2ke0yANm9wi70TsGLeGu+uJzaXQEz?=
 =?us-ascii?Q?ODJ4E4NPbdQWpviF2SpAbo5rdtP6xYWPEKrFKGtz1gW+09xKKtsXUjK/afl4?=
 =?us-ascii?Q?TUhmtBK+9xJX34OKdMeaKblJSFjZjpGtthr42kf9xK83vLsINEdjBabyUEkn?=
 =?us-ascii?Q?oZKyk8DmE0XYo/8lIpZ7jOLQglOLH3J3/rlu60CYaImq4T4T3zVM10MTK4wS?=
 =?us-ascii?Q?X9tV1VoFvttKiFQhAyKVh77PNet9t7osafC2gC0ITmZPZM7RGas8l2y3c+uy?=
 =?us-ascii?Q?G+LI5ZInkMhQ+vlUpA2aSXIw4LgxmuVQjdsSUNvZ4wGsRvVnDr0zNGRJNwt2?=
 =?us-ascii?Q?kCXN8MON3fafRZZdjbLeTLkui+Ii1YmLaDBzZpCO4VOgXNlCY5q3+YC+hPUu?=
 =?us-ascii?Q?AZUMNBv9PvAJTXmHmGyNHi+Yi5pTH5RbgDICDMhn+qu1QQyPINjj/Q5Flo2r?=
 =?us-ascii?Q?v9MA81vhd0Uz1XpwdQ+jQpDHz5KvABG6uaLaI2A0R0pxWoc/LpyC72nzpy1W?=
 =?us-ascii?Q?Izl/0GnUKHgoWdtrCkeXzsncKHLBMXj0euOU/aU6mizuno7Xt06D5CrfFAdb?=
 =?us-ascii?Q?yStaqRcu4SD1phVHZ7cLfL+by7t6p6rK4z3T6Xlzcz12Noie/pwVkcCNA1Mr?=
 =?us-ascii?Q?cArNhwT2XFVBv4YzSa2LTEnhWVazxJ3dX54y3boIh7jWUz+Tl+eGtpz6gZX4?=
 =?us-ascii?Q?jDWIbJtP/EOQagSvuZScPOB202eXd1SctaMAZVP1?=
X-OriginatorOrg: vivo.com
X-MS-Exchange-CrossTenant-Network-Message-Id: b0545a7a-04c2-4b20-2570-08dc52ef8650
X-MS-Exchange-CrossTenant-AuthSource: TYZPR06MB7096.apcprd06.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 02 Apr 2024 08:33:08.5289
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 923e42dc-48d5-4cbe-b582-1a797a6412ed
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: x6T95wUPARcTaRB/pZn5jbB2WqwNwCenCaMAZFY5cGJ0YTMLHl7gVUkXmUYl+GdVzUZBRd2W5wWxQWFYudI0rw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: KL1PR06MB7051
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
Cc: huyue2@coolpad.com, Chunhai Guo <guochunhai@vivo.com>, linux-erofs@lists.ozlabs.org
Errors-To: linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org
Sender: "Linux-erofs" <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>

This adds a special global buffer pool (in the end) for reserved pages.

Using a reserved pool for LZ4 decompression significantly reduces the
time spent on extra temporary page allocation for the extreme cases in
low memory scenarios.

The table below shows the reduction in time spent on page allocation for
LZ4 decompression when using a reserved pool. The results were obtained
from multi-app launch benchmarks on ARM64 Android devices running the
5.15 kernel with an 8-core CPU and 8GB of memory. In the benchmark, we
launched 16 frequently-used apps, and the camera app was the last one in
each round. The data in the table is the average time of camera app for
each round.

After using the reserved pool, there was an average improvement of 150ms
in the overall launch time of our camera app, which was obtained from
the systrace log.

+--------------+---------------+--------------+---------+
|              | w/o page pool | w/ page pool |  diff   |
+--------------+---------------+--------------+---------+
| Average (ms) |     3434      |      21      | -99.38% |
+--------------+---------------+--------------+---------+

Based on the benchmark logs, 64 pages are sufficient for 95% of
scenarios. This value can be adjusted from the module parameter.
The default value is 0.

This pool is currently only used for the LZ4 decompressor, but it can be
applied to more decompressors if needed.

Signed-off-by: Chunhai Guo <guochunhai@vivo.com>
---
 fs/erofs/decompressor.c |  2 +-
 fs/erofs/internal.h     |  6 ++++-
 fs/erofs/zutil.c        | 59 ++++++++++++++++++++++++++++++-----------
 3 files changed, 50 insertions(+), 17 deletions(-)

diff --git a/fs/erofs/decompressor.c b/fs/erofs/decompressor.c
index e1239d886984..d2fe8130819e 100644
--- a/fs/erofs/decompressor.c
+++ b/fs/erofs/decompressor.c
@@ -111,7 +111,7 @@ static int z_erofs_lz4_prepare_dstpages(struct z_erofs_lz4_decompress_ctx *ctx,
 			victim = availables[--top];
 			get_page(victim);
 		} else {
-			victim = erofs_allocpage(pagepool, rq->gfp);
+			victim = __erofs_allocpage(pagepool, rq->gfp, true);
 			if (!victim)
 				return -ENOMEM;
 			set_page_private(victim, Z_EROFS_SHORTLIVED_PAGE);
diff --git a/fs/erofs/internal.h b/fs/erofs/internal.h
index 1caa5d702835..664f6f7c971f 100644
--- a/fs/erofs/internal.h
+++ b/fs/erofs/internal.h
@@ -445,7 +445,11 @@ void erofs_unregister_sysfs(struct super_block *sb);
 int __init erofs_init_sysfs(void);
 void erofs_exit_sysfs(void);
 
-struct page *erofs_allocpage(struct page **pagepool, gfp_t gfp);
+struct page *__erofs_allocpage(struct page **pagepool, gfp_t gfp, bool tryrsv);
+static inline struct page *erofs_allocpage(struct page **pagepool, gfp_t gfp)
+{
+	return __erofs_allocpage(pagepool, gfp, false);
+}
 static inline void erofs_pagepool_add(struct page **pagepool, struct page *page)
 {
 	set_page_private(page, (unsigned long)*pagepool);
diff --git a/fs/erofs/zutil.c b/fs/erofs/zutil.c
index 14440c0bf64e..b45ca0b8b547 100644
--- a/fs/erofs/zutil.c
+++ b/fs/erofs/zutil.c
@@ -12,10 +12,12 @@ struct z_erofs_gbuf {
 	unsigned int nrpages;
 };
 
-static struct z_erofs_gbuf *z_erofs_gbufpool;
-static unsigned int z_erofs_gbuf_count, z_erofs_gbuf_nrpages;
+static struct z_erofs_gbuf *z_erofs_gbufpool, *z_erofs_rsvbuf;
+static unsigned int z_erofs_gbuf_count, z_erofs_gbuf_nrpages,
+		z_erofs_rsv_nrpages;
 
 module_param_named(global_buffers, z_erofs_gbuf_count, uint, 0444);
+module_param_named(reserved_pages, z_erofs_rsv_nrpages, uint, 0444);
 
 static atomic_long_t erofs_global_shrink_cnt;	/* for all mounted instances */
 /* protected by 'erofs_sb_list_lock' */
@@ -117,19 +119,28 @@ int z_erofs_gbuf_growsize(unsigned int nrpages)
 
 int __init z_erofs_gbuf_init(void)
 {
-	unsigned int i = num_possible_cpus();
+	unsigned int i, total = num_possible_cpus();
 
-	if (!z_erofs_gbuf_count)
-		z_erofs_gbuf_count = i;
-	else
-		z_erofs_gbuf_count = min(z_erofs_gbuf_count, i);
+	if (z_erofs_gbuf_count)
+		total = min(z_erofs_gbuf_count, total);
+	z_erofs_gbuf_count = total;
 
-	z_erofs_gbufpool = kcalloc(z_erofs_gbuf_count,
-			sizeof(*z_erofs_gbufpool), GFP_KERNEL);
+	/* The last (special) global buffer is the reserved buffer */
+	total += !!z_erofs_rsv_nrpages;
+
+	z_erofs_gbufpool = kcalloc(total, sizeof(*z_erofs_gbufpool),
+				   GFP_KERNEL);
 	if (!z_erofs_gbufpool)
 		return -ENOMEM;
 
-	for (i = 0; i < z_erofs_gbuf_count; ++i)
+	if (z_erofs_rsv_nrpages) {
+		z_erofs_rsvbuf = &z_erofs_gbufpool[total - 1];
+		z_erofs_rsvbuf->pages = kcalloc(z_erofs_rsv_nrpages,
+				sizeof(*z_erofs_rsvbuf->pages), GFP_KERNEL);
+		if (!z_erofs_rsvbuf->pages)
+			z_erofs_rsvbuf = NULL;
+	}
+	for (i = 0; i < total; ++i)
 		spin_lock_init(&z_erofs_gbufpool[i].lock);
 	return 0;
 }
@@ -138,7 +149,7 @@ void z_erofs_gbuf_exit(void)
 {
 	int i;
 
-	for (i = 0; i < z_erofs_gbuf_count; ++i) {
+	for (i = 0; i < z_erofs_gbuf_count + (!!z_erofs_rsvbuf); ++i) {
 		struct z_erofs_gbuf *gbuf = &z_erofs_gbufpool[i];
 
 		if (gbuf->ptr) {
@@ -158,16 +169,22 @@ void z_erofs_gbuf_exit(void)
 	kfree(z_erofs_gbufpool);
 }
 
-struct page *erofs_allocpage(struct page **pagepool, gfp_t gfp)
+struct page *__erofs_allocpage(struct page **pagepool, gfp_t gfp, bool tryrsv)
 {
 	struct page *page = *pagepool;
 
 	if (page) {
-		DBG_BUGON(page_ref_count(page) != 1);
 		*pagepool = (struct page *)page_private(page);
-		return page;
+	} else if (tryrsv && z_erofs_rsvbuf && z_erofs_rsvbuf->nrpages) {
+		spin_lock(&z_erofs_rsvbuf->lock);
+		if (z_erofs_rsvbuf->nrpages)
+			page = z_erofs_rsvbuf->pages[--z_erofs_rsvbuf->nrpages];
+		spin_unlock(&z_erofs_rsvbuf->lock);
 	}
-	return alloc_page(gfp);
+	if (!page)
+		page = alloc_page(gfp);
+	DBG_BUGON(page && page_ref_count(page) != 1);
+	return page;
 }
 
 void erofs_release_pages(struct page **pagepool)
@@ -176,6 +193,18 @@ void erofs_release_pages(struct page **pagepool)
 		struct page *page = *pagepool;
 
 		*pagepool = (struct page *)page_private(page);
+		/* try to fill reserved global pool first */
+		if (z_erofs_rsvbuf && z_erofs_rsvbuf->nrpages <
+				z_erofs_rsv_nrpages) {
+			spin_lock(&z_erofs_rsvbuf->lock);
+			if (z_erofs_rsvbuf->nrpages < z_erofs_rsv_nrpages) {
+				z_erofs_rsvbuf->pages[z_erofs_rsvbuf->nrpages++]
+						= page;
+				spin_unlock(&z_erofs_rsvbuf->lock);
+				continue;
+			}
+			spin_unlock(&z_erofs_rsvbuf->lock);
+		}
 		put_page(page);
 	}
 }
-- 
2.25.1

