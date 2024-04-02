Return-Path: <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>
X-Original-To: lists+linux-erofs@lfdr.de
Delivered-To: lists+linux-erofs@lfdr.de
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	by mail.lfdr.de (Postfix) with ESMTPS id 70E4E895428
	for <lists+linux-erofs@lfdr.de>; Tue,  2 Apr 2024 15:03:46 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=lists.ozlabs.org;
	s=201707; t=1712063022;
	bh=mSBC84fZmKQki1ipoPE18Uqqq+9oohsyRU4TykigCGA=;
	h=To:Subject:Date:List-Id:List-Unsubscribe:List-Archive:List-Post:
	 List-Help:List-Subscribe:From:Reply-To:Cc:From;
	b=SeJ9h4D9y3zQM5SCPwt1v6JYyrGwnbpY8Kprnx5oqpzmFag/FHyd4lVD7qg0ja5Cl
	 V5WMPFhpVHyTeumPIi6Ojw/3A5khHHpXAH1a1MPouROxIJNQFNUeLDiGTXk9KdpiYQ
	 3rvuPa7fRGog3ERGlbK5rgw4Ma5TNMl7dfdKI7fM2zmXSbyLIUJuyQaQOsSqcRws4u
	 Bq3uRSWIL+Ic7IEorMHhTrJyK7qFJGb5V4QgWPaWcQKd9q8v/ZgQUWftUeIqlCVioF
	 dPP/r0mPZtC5MIgCB955akUbs33NcwrtQygA91SoJ31GkHFOnBX9XRKTBG2pPjINxU
	 0g8Psv4AfrllA==
Received: from boromir.ozlabs.org (localhost [IPv6:::1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4V87Nt5V0xz3dS4
	for <lists+linux-erofs@lfdr.de>; Wed,  3 Apr 2024 00:03:42 +1100 (AEDT)
X-Original-To: linux-erofs@lists.ozlabs.org
Delivered-To: linux-erofs@lists.ozlabs.org
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=vivo.com header.i=@vivo.com header.a=rsa-sha256 header.s=selector2 header.b=fZlMKlrN;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=vivo.com (client-ip=2a01:111:f400:feab::710; helo=apc01-sg2-obe.outbound.protection.outlook.com; envelope-from=guochunhai@vivo.com; receiver=lists.ozlabs.org)
Received: from APC01-SG2-obe.outbound.protection.outlook.com (mail-sgaapc01on20710.outbound.protection.outlook.com [IPv6:2a01:111:f400:feab::710])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4V87Nm03Hjz2xTP
	for <linux-erofs@lists.ozlabs.org>; Wed,  3 Apr 2024 00:03:34 +1100 (AEDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=W1z922NcMH6proZhniy+cMccbEZZs86lPqGLJFiTF4kTPPY/c8VTWRcwg/IU9VLDFxt2Lh1ABqgQprZyy5p/LfNqbkwtKeNlYdNsCrIGHCOk8QdTX1/xg1aO90GtsCqg9AAzSpV6EGTOVxSZ6hkNwUQIjEJ9KA7Xou5k4LWw3Zq7DzLXzedIg88JURKHuFrXZWcjBH1gAyQO9FkLh9mOSdy/dCWsjE31J4uUranYBTE1I3Bs4YQ9KPqhadGNoz/Ov8OVL4qanf039vtz7XXihar11tLOtoCTBuIfzllbe8bClAqqMKTV0WqQ+el6icJQoqmi5ObNaD9FauJuQiMONQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=mSBC84fZmKQki1ipoPE18Uqqq+9oohsyRU4TykigCGA=;
 b=OXDjFnW94WO6EEQvBtnB3cUM+VcLTgCSKb1wVGrrwYSfyiYTRslm1vOFgb1BSLJ3JJ3lKB36kaHfkLI1gTFiGs56ANreTcSBA6HD6nQv4P+WK+TpP69f4mp/T/7yua23+yop+VlbESSPX6IFbuoQMnmJVu0jfk14Rd8KOY2c67urIp+Xn0xeYxbkOAZPoznxke64bN6rfcFN3kEWijG0wZfc7E/7jieTXz3P4t0N33Nao37yGUKuAvkUJNHQzdNSzQe+kJsvqjOmJKVsR8HUerkccUBmJ8QrG6jy1k5t4SDWi9OnYJTeqc3uZl6+IUnnsO3k/ktS9cLDfT0MkxOtXA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=vivo.com; dmarc=pass action=none header.from=vivo.com;
 dkim=pass header.d=vivo.com; arc=none
Received: from TYZPR06MB7096.apcprd06.prod.outlook.com (2603:1096:405:b5::13)
 by SG2PR06MB5310.apcprd06.prod.outlook.com (2603:1096:4:1b8::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7409.46; Tue, 2 Apr
 2024 13:03:12 +0000
Received: from TYZPR06MB7096.apcprd06.prod.outlook.com
 ([fe80::9eb4:3582:34e4:a83d]) by TYZPR06MB7096.apcprd06.prod.outlook.com
 ([fe80::9eb4:3582:34e4:a83d%6]) with mapi id 15.20.7409.042; Tue, 2 Apr 2024
 13:03:12 +0000
To: xiang@kernel.org
Subject: [PATCH v2] erofs: add a reserved buffer pool for lz4 decompression
Date: Tue,  2 Apr 2024 07:15:23 -0600
Message-Id: <20240402131523.2703948-1-guochunhai@vivo.com>
X-Mailer: git-send-email 2.25.1
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SI2PR04CA0005.apcprd04.prod.outlook.com
 (2603:1096:4:197::16) To TYZPR06MB7096.apcprd06.prod.outlook.com
 (2603:1096:405:b5::13)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: TYZPR06MB7096:EE_|SG2PR06MB5310:EE_
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 	dc+lYTItahUJptA/HUuEMCa8oO3Hly/NHUoScwt67WLnqjgSaIK7QE0wtwnUSiGbwcT7Rj8VTvi6vXFMfbybQOKOgbtm3wim+mTHXr9X4gFCKsF0Ftf8YjEerbnt9nZHih0dEi21QVx14Ftlo3sYWKCwPfuESVxxwia9vjQG0ykpKDCMYj8cX7pnNUaKwZcinsXW/aqoZethXEiLfMGR67BIosdub7qX8kDGZRrLUIO9U+XL5ks2CBIaxUefMEiG97LnTIZZD7H+dJtov498TeuMcV48Z2Fxm1Puc5Dk/Q6BFBOGC2FlbuphQSpdNIIFHZJ0vdxWLBdM8nYkYsZMWCew34TWn7XjYLQbq/FIu2kMcDJa9Fif9aJlJLiSuyk5WuSiewfsXVElprMwx6nHFyDlVhKLiMHg3eCaRakuYkvKruNk8wfoKxfjV0Kr5V05RBXS3RC7ffKXOO1DQO16ovGX8eD6izCD8aMidWn28QJ7+6MpNqfOGhHGkAQT1KEcw0kzqVyGWrvOUzCqURc5S7xhjQRztajbLonVp4TY87akH8UcckiEGlZwUWZb9fkDtN13x4ox1MKz8ukMC03EJqhUvrIrauiSpBdZNJvA1TfGlmQaegPxL0SrJyHh07F6Yteg0vsZ0veGnHARVSLg0ys/sq3Vc1nZUP5Cvo2nZeUaLQCh/Wju2h2Rugc33DWB2LWz0jBOcdMmfo2Ehb5FUzyX+1pFvhbnASmu3h5yRAY=
X-Forefront-Antispam-Report: 	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:TYZPR06MB7096.apcprd06.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(1800799015)(376005)(52116005)(366007)(38350700005);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 	=?us-ascii?Q?5caSGtWLmK2mn/jhaRZKUbXKkDyUHXHS/L9CR2GIuctskX4l42eYdyF8a9YB?=
 =?us-ascii?Q?ngU3Q6onSVYgXtvmI1sOogKFJzj9B+AHjcOOumLkoblBb+WKaEaReZq2eeNe?=
 =?us-ascii?Q?+TOK61ohlkx5tGg5BBf0MZ4wsvMl+Mec+KaqXd/AY4qZ2SOp0Pf6vBFpqTiB?=
 =?us-ascii?Q?rnABtgZLyiVKTxFPcDcd0w1RwAbZR8kYrjeYr5h+1kEj2Mfy2/nltbQh8I3w?=
 =?us-ascii?Q?X2VYqnaAt/FcctYoJaPjZEUzx3bInjXNlrKX336tRCY3lrIZ2sVimzlatxwg?=
 =?us-ascii?Q?gkvTtJQFTEIws+b8qalWhcX9UAyw0thiHzq4zdaaycNxA74TU7yaBQoDcR6e?=
 =?us-ascii?Q?KL6Z+VKHZU0IEfLniUa2x0oj5dFfyMMFLC+/uNAk9dosCcHY5BFxnGgaGIVp?=
 =?us-ascii?Q?H4R8CoMo5XFX/QVcCV8Y8J7zxl+cn60cN/+53lhFjFXllUL9bMVcAi2rfhp/?=
 =?us-ascii?Q?a+AYbfSxOodhkbZCQQ0UiNrwNZPPKlFMrOAgvd3YgmjAGuQ/2kXRuq/GmJ7/?=
 =?us-ascii?Q?/mjhL+D7iRPnasxcG/tzxlxvg6GMgxDqUVk+19CmhmLPL5Tf7d7ectmILgb1?=
 =?us-ascii?Q?ARAZrHnERE38rCGRrFJsNXWu3dsY1O1d/om+lUugxkloWXZpAS3ijjuxGo88?=
 =?us-ascii?Q?U7QHqbLffHtvQyLCyT3DoHWK2BsRkbdh5YHbllka07SliYkzIn8MbbLpOHxx?=
 =?us-ascii?Q?eGPr7intMIUST8uOTjlEYMDpWEG7Rz5Kizm2SoJc+8TFN0BqnG6JRSvLwiSL?=
 =?us-ascii?Q?XUj4YAJsmtIfVlKIsJYz9L6Ti2N6DRD/Fstg7vdGYEROCWNVsz4RE/m7lJfk?=
 =?us-ascii?Q?+RFmynFYip5Wi7AI5B8eocQzl3GVa3A//vmd7aBJAen5/hJDF3hfUZ6m56tG?=
 =?us-ascii?Q?+J3GEzbDy4UtZxjxD93csjLJpNM7OTEmLgR/syjMMdFXRe24PB3nzUmGWH6E?=
 =?us-ascii?Q?y4iVwxoYsDgc2/3uw14tEOsyrPEHx/liVGaaBfMWQa83Eeh6rgXEHZ4SoUhB?=
 =?us-ascii?Q?TwrPa3fdV57KjCfsJHWUpfFi6oiE6qXZc3+Vl1oKHTFoETpDM9MtFfJO53FS?=
 =?us-ascii?Q?XweOBn1frHB6veoPf6SecgG++ySZ6DM4v5UVnaoWu8crGCfJ7VrTyJ3kulgw?=
 =?us-ascii?Q?hwGGkAjeQ80uwjjFcXjEWyCVWVyTdwPjm4pMHGM7IimY+LEWDAb/YCTvAvbV?=
 =?us-ascii?Q?k8E+ldJmXPF2EHHj8wz6kF7Otr78EYXbUD3AD445iB6soQUkGG8osZ/5jduz?=
 =?us-ascii?Q?mtpGsTkCvOAL7eH6c2JOLFLTs0YeJwlE5/Nd0R3RDkcfBSdA50pFfQA9SSAV?=
 =?us-ascii?Q?d6cgjC+ucgvs2WfmST1BWdbiy5Ynb4OP9g6ZNpPx3EeC/wNB4Cs8PlOgwp/v?=
 =?us-ascii?Q?6zoySpSHRrws2qCAyVl5ukvDBp9XOksn5S3dSnVYcqVIikk1YbPbEPN4afQ5?=
 =?us-ascii?Q?vc6ByVYTz9mQ2XFVRLOk1AnN6Gv2XN+UPIKwaKpkkTw01tUHHLCYaCJbPRx0?=
 =?us-ascii?Q?J8HcsPtwpe9NMcuFeQAUHKpc9PXNAqm57YzxQIa4dbwan6CQJUNjBc64cnz7?=
 =?us-ascii?Q?91YEe51NA7MZgDub46lgN+EvF2GtLj5tTEuHVNsC?=
X-OriginatorOrg: vivo.com
X-MS-Exchange-CrossTenant-Network-Message-Id: e9245c97-866d-47c3-ef87-08dc53154070
X-MS-Exchange-CrossTenant-AuthSource: TYZPR06MB7096.apcprd06.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 02 Apr 2024 13:03:12.2040
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 923e42dc-48d5-4cbe-b582-1a797a6412ed
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: R24y/BmILqfN+cKsrP4m2Dn46CphHF3WO84xLOz0e+eeVZRmTMwq7VxnTNBf4NvwimLAgSfy6QvnW4LK7w0CUQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SG2PR06MB5310
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
v1->v2 : When memory allocation for z_erofs_rsvbuf->pages fails in
	z_erofs_gbuf_init(), reset z_erofs_rsv_nrpages to 0.
---
 fs/erofs/decompressor.c |  2 +-
 fs/erofs/internal.h     |  6 +++-
 fs/erofs/zutil.c        | 61 +++++++++++++++++++++++++++++++----------
 3 files changed, 52 insertions(+), 17 deletions(-)

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
index 2ebbf3333800..116c1d5d1932 100644
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
index 9687cad8be96..b9b99158bb4e 100644
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
@@ -116,19 +118,30 @@ int z_erofs_gbuf_growsize(unsigned int nrpages)
 
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
+		if (!z_erofs_rsvbuf->pages) {
+			z_erofs_rsvbuf = NULL;
+			z_erofs_rsv_nrpages = 0;
+		}
+	}
+	for (i = 0; i < total; ++i)
 		spin_lock_init(&z_erofs_gbufpool[i].lock);
 	return 0;
 }
@@ -137,7 +150,7 @@ void z_erofs_gbuf_exit(void)
 {
 	int i;
 
-	for (i = 0; i < z_erofs_gbuf_count; ++i) {
+	for (i = 0; i < z_erofs_gbuf_count + (!!z_erofs_rsvbuf); ++i) {
 		struct z_erofs_gbuf *gbuf = &z_erofs_gbufpool[i];
 
 		if (gbuf->ptr) {
@@ -157,16 +170,22 @@ void z_erofs_gbuf_exit(void)
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
@@ -175,6 +194,18 @@ void erofs_release_pages(struct page **pagepool)
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

