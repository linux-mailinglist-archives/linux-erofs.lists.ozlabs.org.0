Return-Path: <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>
X-Original-To: lists+linux-erofs@lfdr.de
Delivered-To: lists+linux-erofs@lfdr.de
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	by mail.lfdr.de (Postfix) with ESMTPS id D0C23827F80
	for <lists+linux-erofs@lfdr.de>; Tue,  9 Jan 2024 08:31:45 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=lists.ozlabs.org;
	s=201707; t=1704785503;
	bh=zOsEvDcjxYZRX28Gwk8/DU4zZQbgLbRLyQVlRH3oh3o=;
	h=To:Subject:Date:List-Id:List-Unsubscribe:List-Archive:List-Post:
	 List-Help:List-Subscribe:From:Reply-To:Cc:From;
	b=RncroblZmKW3ICswJ7/weiiXlP4BLyO7E1D87XA+Xp2JTwToQS+qoYD+h1FQt2AfI
	 lWpnMqZEl20sm2tGAiZ5qFbwroiiZzGoLLXLkLJge9CXF5fqbGV7FCvd2CPjZH+2T4
	 h2axJxBMMNzIGVQvklgsQlhfW9FpMsk1JYYPB8lOg2qbE6wBN37vIgPX90uF3rG4Fz
	 jyclMfN/OzQq6H/NFCL6NBoSN27I7yp8XJvBTgGVsbtvcjSwT4FyclsCxLYA6Mv5TJ
	 M/UbdvxZq4o8iYOX+Bb2286kSk1IVRmlEnvC1N0H5Kb6NkSmrTstsmxHIoj8ioUrrX
	 1Y6bgMG2dvS0A==
Received: from boromir.ozlabs.org (localhost [IPv6:::1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4T8N0b2jGpz3bPM
	for <lists+linux-erofs@lfdr.de>; Tue,  9 Jan 2024 18:31:43 +1100 (AEDT)
X-Original-To: linux-erofs@lists.ozlabs.org
Delivered-To: linux-erofs@lists.ozlabs.org
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=vivo.com header.i=@vivo.com header.a=rsa-sha256 header.s=selector2 header.b=DBAOVxbT;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=vivo.com (client-ip=2a01:111:f400:feab::703; helo=apc01-sg2-obe.outbound.protection.outlook.com; envelope-from=guochunhai@vivo.com; receiver=lists.ozlabs.org)
Received: from APC01-SG2-obe.outbound.protection.outlook.com (mail-sgaapc01on20703.outbound.protection.outlook.com [IPv6:2a01:111:f400:feab::703])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4T8N0R0LBDz30YR
	for <linux-erofs@lists.ozlabs.org>; Tue,  9 Jan 2024 18:31:33 +1100 (AEDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=ofc2F9wy67lW6JxctlQMOVIwNn3+nUq55ZsytNpfkYk8Je/ocNClilbcqliTNjrtrHmLBep27cK+i2yfjpjnu9x4974AVsj4bYdgxvJ9ZYnLw7W7DVf3dISl7e2PF1KYx8rVQ7opfeSIDsE+pBZIIXFeD9KR85tg47Qdy6mBBFZwTfhvfo9iPfObwk7UgW2T7U+Bj0RxZKAYXGCt5P/ySM1bnD7N6GAmy1Ts4qT2/sd6pIKpyRb280I5hPjAsJ0o6c2Qg8GB9j/J4Md7/PzgFEu1ZcRfdxpGyly8QtrC0M+aLfIZL+SYZTq4UEQlIbwpjpmSXxo2xjkul6xa9+9ENw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=zOsEvDcjxYZRX28Gwk8/DU4zZQbgLbRLyQVlRH3oh3o=;
 b=VpQCPok8rQ39ZHJ1OyeLLB05t1HmJdIQLPOQsY8KGXiEJbuQZCf41ktVoz+oNVQMPnoJdNuFBZodJdHlGiorhN15aA+21JWNGXFVPuoXT8wmtiJuUO13pY6NvbohW9CyZB4Zui3IzZxLkGGoIEESKbtuuZzNUydn+HA8NC/Qm7vVpcUpsAQR9blYIa693UOp5bg6uZQccm83mK/2uoBfQgwj1YoQnSLu2+1MU8SpuXNCnLAro2GvoivJehuuyIExuq+3eMJD/BE/CS17HUyA9dpo9MXDYWMufYlLTbSfH4+wbNGqzxJx1Loy7PLaECEfCWGZQkLc2H5qXfpckBJJvA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=vivo.com; dmarc=pass action=none header.from=vivo.com;
 dkim=pass header.d=vivo.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=vivo.com;
Received: from TY2PR06MB3342.apcprd06.prod.outlook.com (2603:1096:404:fb::23)
 by TYSPR06MB6923.apcprd06.prod.outlook.com (2603:1096:405:35::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7159.23; Tue, 9 Jan
 2024 07:31:16 +0000
Received: from TY2PR06MB3342.apcprd06.prod.outlook.com
 ([fe80::b403:721d:ec13:d457]) by TY2PR06MB3342.apcprd06.prod.outlook.com
 ([fe80::b403:721d:ec13:d457%5]) with mapi id 15.20.7159.020; Tue, 9 Jan 2024
 07:31:16 +0000
To: xiang@kernel.org
Subject: [PATCH v2] erofs: add a global page pool for lz4 decompression
Date: Tue,  9 Jan 2024 00:41:43 -0700
Message-Id: <20240109074143.4138783-1-guochunhai@vivo.com>
X-Mailer: git-send-email 2.25.1
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SI2PR01CA0008.apcprd01.prod.exchangelabs.com
 (2603:1096:4:191::10) To TY2PR06MB3342.apcprd06.prod.outlook.com
 (2603:1096:404:fb::23)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: TY2PR06MB3342:EE_|TYSPR06MB6923:EE_
X-MS-Office365-Filtering-Correlation-Id: 83ce36f0-1ef7-46b5-07a1-08dc10e4f6d3
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 	vfE87JiY5CWsLNtp+x9YA5TnBs0waiQEjrutpwZBvxxnUsyprO3ISGDreWcLfXDB62OCAYLeIv4UfAfRkGBwOBOFmDpTm6DofVQ9byHHoxUiz0SeF+lC96sWXi1inRvwkPT85YwY+wT3GTEnJyKVEj0wROb1K/i0NzvfqcsH+07tffQ/AOr2twzOD2+pjJwauB+3xAhUs2gFhrZtbisZb5XD3xr5Rs+qVP+rllTXQEYUAl0B8nEWSYcixkXN+G4DS0Tkg2euUOgcKpXAa3d+avMrYBH+TlRovzNk/5l+URxusR4gMpHXO8RHzOHdaF18Cnx78m+m3wz6OSq6qTW4/9MKKhwGfEl0Z8GgmXln8/tMHBeTqAf50duh7cfTGAJGqkEuFbp+FelXw0pZ1R2XuWPnuD/K/QpPk2hLq2eVW2Qgs6vTZ4m4BKbTI7vXm+OfzpU+eodOoIqOgGBvIW5J69gVQR68K5d/NYBJJitDQ1qWUgEgT7pB+4JGewVWWWMhKc3rNf0XFDHgC29QJkOaC++OD3BFYTFbsiRqsHjoHLabBmsuvk63miHqeRE9Gi+i0rwQ7x5nsXDYffutAjndH+GD3sloYN1/U7FnpUiV5tkrUBvNhhGGYPNd6GYxwub+
X-Forefront-Antispam-Report: 	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:TY2PR06MB3342.apcprd06.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(376002)(366004)(396003)(136003)(39860400002)(346002)(230922051799003)(186009)(64100799003)(1800799012)(451199024)(83380400001)(478600001)(6486002)(8936002)(8676002)(4326008)(66476007)(66556008)(66946007)(316002)(6916009)(86362001)(36756003)(107886003)(2616005)(1076003)(26005)(38100700002)(6666004)(6512007)(6506007)(52116002)(2906002)(38350700005)(5660300002)(41300700001);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 	=?us-ascii?Q?IJIUpzw1DFeQKmTqp7EBD5uR+kYY+rQ0P6d/NjQABTNxeSsyhM3D7qVR5PV9?=
 =?us-ascii?Q?BpvjUncWfUYNVfRV90Bj4ceNycFwHho7yl4yCRGNi5toipQnzSeJgXAcXtbX?=
 =?us-ascii?Q?/8x9WXFauDVp72K4uyI3jRQ3x8C5GQPu+XT0YCUhLMmPqYuxj3ZxxYYLzMCd?=
 =?us-ascii?Q?r4zGLpOR8JBZzif95y5HidUtthrX5dbc56xc60N3hzLeX0scwOMAs87lSeKB?=
 =?us-ascii?Q?uYDWJhZ4hZbopnlrmWy70L2rjM5Zs9hL9rrOroBZgZX9RXVQKHJ2LjvvbO1d?=
 =?us-ascii?Q?kwmmGvNwvO6kXz6Hm4r4WwkjG5ZSe02HgWxfZTlWrkE406KSZ25UjRIh0PNX?=
 =?us-ascii?Q?hfLiw0iQIvbMWR6xWXlVQJnFifeolSjKxplCNBkGzI9NA19bzZeg5CvtqwWE?=
 =?us-ascii?Q?Wtb3rkHqVk3pLAZ9HwYj0MmzdB2Z2dki0x55hjSj7RW+mzGZ4H9aS2ygPfM1?=
 =?us-ascii?Q?DDJI2cd3qcPTvp5sH4QOMttLbNPBI/7O+8CqWp02NmKth+2PVgDFE08cjMMa?=
 =?us-ascii?Q?iU621vg9+2SnKovcMePV8vDUtTvmxqreBHxY2OJ2lmLDFQCwKFZtNNhNxNog?=
 =?us-ascii?Q?yNvUrEmCsLFf5I8za17xhDe24BmNBPWjaU+tzSc/gtC+pUuBDP/CfzJXZ8BI?=
 =?us-ascii?Q?ASIIzNmTv4xC4XswEWfMkFQ+BntYj9Tqoprp3CnkVtTvDOhW2R5bS5aMzRRf?=
 =?us-ascii?Q?JWIWAgjYycrdr4pLueqM9ZE75ZZX1JHu3Ms4BkNb9Rj9PSVNQbTWovsDeInr?=
 =?us-ascii?Q?hLYmyEgevIyOsaddpbBreA59NkJJAuLQ9VVJdEUOcpPaukiXDW981fm8SrBd?=
 =?us-ascii?Q?hn4dwV4s7zQQodVTLUPpH6q8G3wKDUTP4JAMjkO2CagADg3PiVHv2OI8+Mrx?=
 =?us-ascii?Q?pcc1E2zbYkf57ZDBw+qXzLjX9Oa5HgnBNHHXvs49PDgetemCU6Y7t831B/LB?=
 =?us-ascii?Q?YH8+D1TsbZZ8xf/plPAG2OcQ9N0TYl4iwLQ4MSxVtVIMV/d6be/w/KVjjxBp?=
 =?us-ascii?Q?+exGvL8F0190kV8NoR7FfDkAn3TOl6dnkNdeH7f72wOcE94//W91Su69AzPx?=
 =?us-ascii?Q?MZrUa0a8sRzdCMcy1TyxunOA0CqiiaXk9facPNwK5MPXam61x0cHrBNSGU9S?=
 =?us-ascii?Q?Z49d50PJU7mVF+Eivj4rG1UH8cU3/fIfoUUwWJ6qblU0Jn6fD3x20xz85v6j?=
 =?us-ascii?Q?YXUU5NXWxTuZNLvnq92Tgh2mbdcCjTPUlycREV7ixo9GJLdPtn0tv8FEb4Dw?=
 =?us-ascii?Q?ySmspZb6yXPxR6X2wVF4AwinhV8GByLZ2FKwCQV7dLor0vMWkuYKUhah4w3a?=
 =?us-ascii?Q?mcsuczfxAu5rRPjA/e0huJ8N6rGMrvzw1cLT+R+Ld7pcByokvfGm6BpvQwZn?=
 =?us-ascii?Q?QCOQqMLV+kj7MbZ1yY+Ox4GVGQYtNMhrrR1TJPWmxNxRqghioGzk0dT1QuyT?=
 =?us-ascii?Q?/nBhymu9GGn6BDGl8Pxu2y4RhyIm9kAOfqbBuQd91YQc5HU8z3jnTvUoLhs5?=
 =?us-ascii?Q?YX1QON1FJ7ZTaE57SPVGS04kGFuApinp8PDSlSbToLcVMMuRhudWWRZga4hK?=
 =?us-ascii?Q?ANStOx7kdWkA9410eM5sOkdlWDyfuJ/JV2yY+2AC?=
X-OriginatorOrg: vivo.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 83ce36f0-1ef7-46b5-07a1-08dc10e4f6d3
X-MS-Exchange-CrossTenant-AuthSource: TY2PR06MB3342.apcprd06.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 Jan 2024 07:31:16.0763
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 923e42dc-48d5-4cbe-b582-1a797a6412ed
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: eyJ1mT1et/eYt5FzPB0daeTeTifJq7gLRgO/G8vTwoVmqLBRvHiOAalIWitEn/n1amYz/+qN06CENPnl9tZE8Q==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TYSPR06MB6923
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

Using a global page pool for LZ4 decompression significantly reduces the
time spent on page allocation in low memory scenarios.

The table below shows the reduction in time spent on page allocation for
LZ4 decompression when using a global page pool.  The results were
obtained from multi-app launch benchmarks on ARM64 Android devices
running the 5.15 kernel with an 8-core CPU and 8GB of memory.  In the
benchmark, we launched 16 frequently-used apps, and the camera app was
the last one in each round. The data in the table is the average time of
camera app for each round.
After using the page pool, there was an average improvement of 150ms in
the launch time of the camera app, which was obtained from systrace log.
+--------------+---------------+--------------+---------+
|              | w/o page pool | w/ page pool |  diff   |
+--------------+---------------+--------------+---------+
| Average (ms) |     3434      |      21      | -99.38% |
+--------------+---------------+--------------+---------+

Based on the benchmark logs, 64 pages are sufficient for 95% of
scenarios. This value can be adjusted from the module parameter. The
default value is 0.

This patch currently only supports the LZ4 decompressor, other
decompressors will be supported in the next step.

Signed-off-by: Chunhai Guo <guochunhai@vivo.com>
---
V1 -> V2: reuse shortlived interfaces for the global pool and support
	configuration based on module parameters
---
 fs/erofs/decompressor.c |  5 ++-
 fs/erofs/internal.h     | 15 +++++++-
 fs/erofs/super.c        |  1 +
 fs/erofs/utils.c        | 82 +++++++++++++++++++++++++++++++++++++++--
 4 files changed, 97 insertions(+), 6 deletions(-)

diff --git a/fs/erofs/decompressor.c b/fs/erofs/decompressor.c
index d08a6ee23ac5..49aa40e5c260 100644
--- a/fs/erofs/decompressor.c
+++ b/fs/erofs/decompressor.c
@@ -54,6 +54,7 @@ static int z_erofs_load_lz4_config(struct super_block *sb,
 	sbi->lz4.max_distance_pages = distance ?
 					DIV_ROUND_UP(distance, PAGE_SIZE) + 1 :
 					LZ4_MAX_DISTANCE_PAGES;
+	erofs_global_page_pool_init();
 	return erofs_pcpubuf_growsize(sbi->lz4.max_pclusterblks);
 }
 
@@ -111,8 +112,8 @@ static int z_erofs_lz4_prepare_dstpages(struct z_erofs_lz4_decompress_ctx *ctx,
 			victim = availables[--top];
 			get_page(victim);
 		} else {
-			victim = erofs_allocpage(pagepool,
-						 GFP_KERNEL | __GFP_NOFAIL);
+			victim = erofs_allocpage_global(pagepool,
+					GFP_KERNEL | __GFP_NOFAIL);
 			set_page_private(victim, Z_EROFS_SHORTLIVED_PAGE);
 		}
 		rq->out[i] = victim;
diff --git a/fs/erofs/internal.h b/fs/erofs/internal.h
index b0409badb017..d078ccae4f11 100644
--- a/fs/erofs/internal.h
+++ b/fs/erofs/internal.h
@@ -445,8 +445,21 @@ int erofs_register_sysfs(struct super_block *sb);
 void erofs_unregister_sysfs(struct super_block *sb);
 int __init erofs_init_sysfs(void);
 void erofs_exit_sysfs(void);
+int erofs_global_page_pool_init(void);
+void erofs_global_page_pool_exit(void);
+struct page *__erofs_allocpage(struct page **pagepool, gfp_t gfp,
+		bool global_allowed);
+static inline struct page *erofs_allocpage(struct page **pagepool, gfp_t gfp)
+{
+	return __erofs_allocpage(pagepool, gfp, false);
+}
+
+static inline struct page *erofs_allocpage_global(struct page **pagepool,
+		gfp_t gfp)
+{
+	return __erofs_allocpage(pagepool, gfp, true);
+}
 
-struct page *erofs_allocpage(struct page **pagepool, gfp_t gfp);
 static inline void erofs_pagepool_add(struct page **pagepool, struct page *page)
 {
 	set_page_private(page, (unsigned long)*pagepool);
diff --git a/fs/erofs/super.c b/fs/erofs/super.c
index 5f60f163bd56..56ddacb1bd6e 100644
--- a/fs/erofs/super.c
+++ b/fs/erofs/super.c
@@ -946,6 +946,7 @@ static void __exit erofs_module_exit(void)
 	erofs_exit_shrinker();
 	kmem_cache_destroy(erofs_inode_cachep);
 	erofs_pcpubuf_exit();
+	erofs_global_page_pool_exit();
 }
 
 static int erofs_statfs(struct dentry *dentry, struct kstatfs *buf)
diff --git a/fs/erofs/utils.c b/fs/erofs/utils.c
index 5dea308764b4..1b0cec47c00c 100644
--- a/fs/erofs/utils.c
+++ b/fs/erofs/utils.c
@@ -5,7 +5,19 @@
  */
 #include "internal.h"
 
-struct page *erofs_allocpage(struct page **pagepool, gfp_t gfp)
+struct z_erofs_global_pool {
+	struct page *pagepool;
+	spinlock_t lock;
+	unsigned int total, unused;
+	bool inited;
+};
+
+static struct z_erofs_global_pool z_erofs_global_pool;
+
+module_param_named(global_pool_size, z_erofs_global_pool.total, uint, 0444);
+
+struct page *__erofs_allocpage(struct page **pagepool, gfp_t gfp,
+		bool from_global)
 {
 	struct page *page = *pagepool;
 
@@ -13,7 +25,19 @@ struct page *erofs_allocpage(struct page **pagepool, gfp_t gfp)
 		DBG_BUGON(page_ref_count(page) != 1);
 		*pagepool = (struct page *)page_private(page);
 	} else {
-		page = alloc_page(gfp);
+		if (from_global) {
+			spin_lock(&z_erofs_global_pool.lock);
+			page = z_erofs_global_pool.pagepool;
+			if (page) {
+				z_erofs_global_pool.pagepool =
+					(struct page *)page_private(page);
+				DBG_BUGON(page_ref_count(page) != 1);
+				z_erofs_global_pool.unused--;
+			}
+			spin_unlock(&z_erofs_global_pool.lock);
+		}
+		if (!page)
+			page = alloc_page(gfp);
 	}
 	return page;
 }
@@ -24,7 +48,20 @@ void erofs_release_pages(struct page **pagepool)
 		struct page *page = *pagepool;
 
 		*pagepool = (struct page *)page_private(page);
-		put_page(page);
+		if (z_erofs_global_pool.total) {
+			spin_lock(&z_erofs_global_pool.lock);
+			if (z_erofs_global_pool.unused
+					< z_erofs_global_pool.total) {
+				erofs_pagepool_add(&z_erofs_global_pool.pagepool,
+						page);
+				z_erofs_global_pool.unused++;
+			} else {
+				put_page(page);
+			}
+			spin_unlock(&z_erofs_global_pool.lock);
+		} else {
+			put_page(page);
+		}
 	}
 }
 
@@ -284,4 +321,43 @@ void erofs_exit_shrinker(void)
 {
 	shrinker_free(erofs_shrinker_info);
 }
+
+int erofs_global_page_pool_init(void)
+{
+	int i;
+	struct page *page;
+
+	if (z_erofs_global_pool.inited)
+		return 0;
+
+	spin_lock_init(&z_erofs_global_pool.lock);
+	z_erofs_global_pool.unused = 0;
+	z_erofs_global_pool.pagepool = NULL;
+	for (i = 0; i < z_erofs_global_pool.total; i++) {
+		page = alloc_page(GFP_KERNEL);
+		if (!page) {
+			erofs_err(NULL, "failed to alloc page for erofs page pool\n");
+			return 0;
+		}
+		erofs_pagepool_add(&z_erofs_global_pool.pagepool, page);
+		z_erofs_global_pool.unused++;
+	}
+	z_erofs_global_pool.inited = true;
+	return 0;
+}
+
+void erofs_global_page_pool_exit(void)
+{
+	struct page *pagepool = z_erofs_global_pool.pagepool;
+
+	while (pagepool) {
+		struct page *page = pagepool;
+
+		pagepool = (struct page *)page_private(page);
+		put_page(page);
+		z_erofs_global_pool.unused--;
+	}
+	z_erofs_global_pool.total = 0;
+}
+
 #endif	/* !CONFIG_EROFS_FS_ZIP */
-- 
2.25.1

