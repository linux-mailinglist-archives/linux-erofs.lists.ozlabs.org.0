Return-Path: <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>
X-Original-To: lists+linux-erofs@lfdr.de
Delivered-To: lists+linux-erofs@lfdr.de
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2404:9400:2:0:216:3eff:fee1:b9f1])
	by mail.lfdr.de (Postfix) with ESMTPS id 0FCF332E379
	for <lists+linux-erofs@lfdr.de>; Fri,  5 Mar 2021 09:14:19 +0100 (CET)
Received: from boromir.ozlabs.org (localhost [IPv6:::1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4DsL9j04jXz30RD
	for <lists+linux-erofs@lfdr.de>; Fri,  5 Mar 2021 19:14:17 +1100 (AEDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=lists.ozlabs.org;
	s=201707; t=1614932057;
	bh=ozGZBkNqUyuHVsiwa3G1hdTlL3qmn3Yc+PxXCUqgbB8=;
	h=To:Subject:Date:List-Id:List-Unsubscribe:List-Archive:List-Post:
	 List-Help:List-Subscribe:From:Reply-To:Cc:From;
	b=oTTfRWUSx18iDUV7g7ia0kFoNcRW1XcYQBGoVx8qxrldeKQTFm15MHYL9bc4Bz6qe
	 KIQLjjC9ACeTc8k8n7D+0aKojf+w9v0ER5eq0N8iSIilPUCbmJxGUIShM1TnRRzd5e
	 TnfxPO6G6Ub6Z5yRPtI7lXXxSKexBImmwFLuH7AJGXD/tYDqxlBWcEeTg5nLgfsQeR
	 csvuq1K2gTvS0/ik7+mQxdph2yaAs9AfFroxmRPK1zMLMfv8VTHtHimz4AgEDtlIjI
	 uiZ+epS9Lvqzfi5SW7nMOEdGiSQIoCHaGiHpyHxF6x4IEhtes7TbXdBM61stni/8c3
	 VcPZCaNJDf+dg==
X-Original-To: linux-erofs@lists.ozlabs.org
Delivered-To: linux-erofs@lists.ozlabs.org
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized)
 smtp.mailfrom=oppo.com (client-ip=40.107.131.48;
 helo=apc01-sg2-obe.outbound.protection.outlook.com;
 envelope-from=huangjianan@oppo.com; receiver=<UNKNOWN>)
Authentication-Results: lists.ozlabs.org; dkim=pass (1024-bit key;
 unprotected) header.d=oppo.com header.i=@oppo.com header.a=rsa-sha256
 header.s=selector1 header.b=d42wbJ0u; 
 dkim-atps=neutral
Received: from APC01-SG2-obe.outbound.protection.outlook.com
 (mail-eopbgr1310048.outbound.protection.outlook.com [40.107.131.48])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 4DsL9g1MSkz30Ny
 for <linux-erofs@lists.ozlabs.org>; Fri,  5 Mar 2021 19:14:14 +1100 (AEDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=PrBJxJViV2jMjQJjvonwFIG8P6YF1w44LV1tiTFMxZqNavY1yrjGHdz1/MvZA7GemgGzjPyOFWhkLiOU1pOmiaI1koNJCUk998uPEtuK79ZVBIof6aqRTy3EVNCCgcl1XkfRlVBb7lV6/frFAmrh4Xqh+uZmxXaqLXrG4KtaLOwrdBtPHkcC0RRugzN5y+GGsGNbE4NMCyLN54AgzKGdGIhjaULcyVL0zcolUWFp2JqZFaC0f9FJzz/vR4KTLgIj66jJbjm0Gk+cRTwacwAfLGXkPxTHOFQE6OlBCgYAHNEExIceiUAk8ZEZAV5XHh9/CUNgUAC3HIOj4P6rWVBYgA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ozGZBkNqUyuHVsiwa3G1hdTlL3qmn3Yc+PxXCUqgbB8=;
 b=KcoNysjJMqyEm6QLqMMNY6pkEvrvf7ta5F8LEkaJB0+NHKwQ4QBNRZ0hHdP7DSy4wG5DzwEhxr/Io5dKwye7KwCJ4kuJ7lI+RcjsED7gFMfgO7JINXgA7yRo+mnHwK9VPnGlLhQYXRi+cnlSCSKbaj5qoJ+cPTkrlo1YAE6MB6OgqJ+uZ99VhgeRkQYHbHh77DMRZuYR3BMEyDQHqpcBnSnY5qie5xo6DkLC4rxxwMawkoj0E6ebT1K/OalEJ4/tf+PGNOXSZM26ZgE3K9HrXJDzAG6WD2PsMmVsdcPrWSnsL9OCIMnHAi+MovgRan3QOrrywT/F32mzcJ3pM4NVFg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oppo.com; dmarc=pass action=none header.from=oppo.com;
 dkim=pass header.d=oppo.com; arc=none
Authentication-Results: lists.ozlabs.org; dkim=none (message not signed)
 header.d=none;lists.ozlabs.org; dmarc=none action=none header.from=oppo.com;
Received: from SG2PR02MB4108.apcprd02.prod.outlook.com (2603:1096:4:96::19) by
 SG2PR02MB3847.apcprd02.prod.outlook.com (2603:1096:4:29::14) with
 Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.3890.25; Fri, 5 Mar 2021 08:13:58 +0000
Received: from SG2PR02MB4108.apcprd02.prod.outlook.com
 ([fe80::1143:a7b7:6bd4:83b3]) by SG2PR02MB4108.apcprd02.prod.outlook.com
 ([fe80::1143:a7b7:6bd4:83b3%7]) with mapi id 15.20.3890.032; Fri, 5 Mar 2021
 08:13:58 +0000
To: linux-erofs@lists.ozlabs.org
Subject: [PATCH v3 2/2] erofs: decompress in endio if possible
Date: Fri,  5 Mar 2021 16:13:42 +0800
Message-Id: <20210305081342.789943-1-huangjianan@oppo.com>
X-Mailer: git-send-email 2.25.1
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [58.252.5.72]
X-ClientProxiedBy: HK2PR02CA0135.apcprd02.prod.outlook.com
 (2603:1096:202:16::19) To SG2PR02MB4108.apcprd02.prod.outlook.com
 (2603:1096:4:96::19)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from localhost.localdomain (58.252.5.72) by
 HK2PR02CA0135.apcprd02.prod.outlook.com (2603:1096:202:16::19) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.3912.17 via Frontend Transport; Fri, 5 Mar 2021 08:13:57 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 03056b38-4d22-4d37-0a8d-08d8dfaea070
X-MS-TrafficTypeDiagnostic: SG2PR02MB3847:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <SG2PR02MB38471726ADCE0D0FD32F4D3AC3969@SG2PR02MB3847.apcprd02.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:3276;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: JumfiDstrGpSS90vCjLFYni4+E6zacq91BJmUMUuaZ6+jkmkruRv1/QvsO+9hZxp7bFDOe67CEBWj+LeEAIqAUjMZEq3oAlpLPMTtrYrFCDp9Arh+bE8NLethD2gHy4GnLnBiN2e6eMVQiKx1f6xQ6RqEqhm/SvZyA9NoCTt2ybEBwBifmqkvRdM1RR3ibsXC7rOgx1ABgz7MvSrayd8BJJMa8tBqXpmHRaopK4nkWyUp3lwX3xgnMZVAZuSKI8/1aR48L24ke76Ax9T4jODIpYP6RK0Fq+kzzH3daPNw72IEMmLNA/1x1+NKNuEkLA+krcSs+35nsRwjDARwjPWGZZYTUWlFR+cKmkECOuikyhZ7ntRR9tFT6IR/w//stAP/twUA5wmgUV8zA1BIVCvkfB0T/CYTYi9Ju6HtYt+33LxEoV5Za1dPUQQccRBER9T7iN8YOrcwMwxREyfmQxXvjxTkRms8/SuQvAInEBBhNhZWjLstp1SHBwaH+dMR7tvpHXNrGi4FM844QsWuJQkacZx3yLsbmcwPFwAq7AIzde7HqMnX8x3hdUMk920OXkphKZJ9zkd4IPZFMsg4vH+VmDnnqEVagEDxJ8pb0tmCYs=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:SG2PR02MB4108.apcprd02.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(4636009)(39860400002)(376002)(346002)(366004)(136003)(396003)(16526019)(2616005)(66476007)(8676002)(6666004)(66946007)(8936002)(36756003)(26005)(69590400012)(1076003)(66556008)(186003)(956004)(6512007)(5660300002)(4326008)(52116002)(6506007)(6486002)(83380400001)(6916009)(86362001)(316002)(2906002)(478600001)(11606007);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData: =?us-ascii?Q?+yj7hxw9lvdKtjwpjq4NoX15cUBEr+3XJM+Yb3bhvB5iT6Mf/+PtrYakDiGB?=
 =?us-ascii?Q?5HEt4XFJgAoIXKDouHvciyBPxGIjhqFcuzQLtZg5/1NsC3p6PzLsPDBLOaRe?=
 =?us-ascii?Q?yTFLGDK/5SxXMqcmS/2NlCSH5+WgObE/9dkfqLgsI8JsQZZYgTsjPuGW0XkQ?=
 =?us-ascii?Q?my9CCkpJECw24oKCsiNDbWgk/bzhvmSULLpmmoUBAP3EgTHq1SPAfN2e4Woc?=
 =?us-ascii?Q?+k7ygby3Eg4oSaStdsfosye+R3HepQahFE0iGTqvkStn3n5wCglc+WCfg19c?=
 =?us-ascii?Q?zrqbCNHSvmJn5ztDo6Jzln0EFJkNp58or5ExEd9ZLeFv5kZICQDzn5xG2Tqc?=
 =?us-ascii?Q?/PWMX2XA+RatUcPVbDcHeIy+Us5dyD8M92qW5017BvatzL1L810AmEoXh8Jn?=
 =?us-ascii?Q?NH/szmWAaYlc4gRdZ3nw4rMBrNdZ0CmDUOXRn/Xop88zHSWn1bZjcqgB1ZtR?=
 =?us-ascii?Q?nOom2uEn5ib+y08NNt8FmxWhKTyBfFcQNVFjHD+8DmunmDIrkpy/jdNUhvKN?=
 =?us-ascii?Q?PhnGDiJPTaOnn4Y9qZWrkH6bMd/M20jTDyT4QdKOrnT1qcvxwOPsWH+HvvVV?=
 =?us-ascii?Q?7b6yLKbyBjdd6DQM9w79oeoCkgKDo0ClzSjvagU34NtZ/uFnmr+i3XCNi6YO?=
 =?us-ascii?Q?SANrj1ScA29bxCLQ2/UO1keCqbyuYsAOLkOSqUI2yYi8ft5D97K3X/OyTY8c?=
 =?us-ascii?Q?k5Yf1d2/3zc8sPPCjB0NJO42sdIJgVFdxlhWB4E48sisdfC+1X4wqrIAPfIr?=
 =?us-ascii?Q?ItEUVtEcdP+q/g6yaevwxcCX9qS89LSVJQ2r3GzWFW7xkH472tf3bzFapISp?=
 =?us-ascii?Q?bqgr6tM0c1h8Oge4h+Etzk5aM1OdeCqsR4m/5MZhzZxIrVHn8d7okrwAGadc?=
 =?us-ascii?Q?LK6lhlKumZl9HmYR53UogMiRB3vmHpC3h7muMPE0BMpu6CoIL9zLR3swlIg+?=
 =?us-ascii?Q?0wlVAndXoiZ+3DrT0+PSSsiVot30T59kk/A+LTJMz6WXOPWHZpsEBBj2T63u?=
 =?us-ascii?Q?06Oy3whEkIlPmhnnN6sP16wWLNxA4P2BQxZeXv8HKmMK+z5kKpJQUxPs4KG+?=
 =?us-ascii?Q?T3V+CVCiqNwfRxd3OfzOHW2jp51F5dGvY2PdWUEnz9oFjKZSQXpys0wdpPh1?=
 =?us-ascii?Q?XMMifXNvhHsLk78gRHQsCCqhwzAJKasZbItEGAZDZ3JPwqGMqfihVaS7L0nt?=
 =?us-ascii?Q?g+IZYjXiyvFBZNjN2yxeRqe5Dbh5NqM91ZNhyPNTcsIrvChSjSt6zAxLR3f3?=
 =?us-ascii?Q?0GStr4vgxEC38hEe/eLJo+FjXkBdZlwQp1MtM5evBxMpTH38UZpfwzfF3s+r?=
 =?us-ascii?Q?epWROLiT8xtrE17AvTPe0/qc?=
X-OriginatorOrg: oppo.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 03056b38-4d22-4d37-0a8d-08d8dfaea070
X-MS-Exchange-CrossTenant-AuthSource: SG2PR02MB4108.apcprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 05 Mar 2021 08:13:58.4684 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: f1905eb1-c353-41c5-9516-62b4a54b5ee6
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: HotB7/LljyNJQD+l0GmHPRiPfIaBZOlAquk5sKndc7SVD/ohPmLS1r7WhEbHSMno/GDgdg58sKc2X6secE7/mQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SG2PR02MB3847
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
Cc: linux-kernel@vger.kernel.org, guoweichao@oppo.com, zhangshiming@oppo.com
Errors-To: linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org
Sender: "Linux-erofs"
 <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>

z_erofs_decompressqueue_endio may not be executed in the atomic
context, for example, when dm-verity is turned on. In this scenario,
data can be decompressed directly to get rid of additional kworker
scheduling overhead. Also, it makes no sense to apply synchronous
decompression for such case.

Signed-off-by: Huang Jianan <huangjianan@oppo.com>
Signed-off-by: Guo Weichao <guoweichao@oppo.com>
---
 fs/erofs/internal.h |  3 +++
 fs/erofs/super.c    |  4 ++++
 fs/erofs/zdata.c    | 14 +++++++++++---
 3 files changed, 18 insertions(+), 3 deletions(-)

diff --git a/fs/erofs/internal.h b/fs/erofs/internal.h
index 67a7ec945686..b817cb85d67b 100644
--- a/fs/erofs/internal.h
+++ b/fs/erofs/internal.h
@@ -70,6 +70,9 @@ struct erofs_sb_info {
 
 	/* pseudo inode to manage cached pages */
 	struct inode *managed_cache;
+
+	/* decide whether to decompress synchronously */
+	bool readahead_sync_decompress;
 #endif	/* CONFIG_EROFS_FS_ZIP */
 	u32 blocks;
 	u32 meta_blkaddr;
diff --git a/fs/erofs/super.c b/fs/erofs/super.c
index d5a6b9b888a5..77819efe9b15 100644
--- a/fs/erofs/super.c
+++ b/fs/erofs/super.c
@@ -175,6 +175,10 @@ static int erofs_read_superblock(struct super_block *sb)
 	sbi->root_nid = le16_to_cpu(dsb->root_nid);
 	sbi->inos = le64_to_cpu(dsb->inos);
 
+#ifdef CONFIG_EROFS_FS_ZIP
+	sbi->readahead_sync_decompress = false;
+#endif
+
 	sbi->build_time = le64_to_cpu(dsb->build_time);
 	sbi->build_time_nsec = le32_to_cpu(dsb->build_time_nsec);
 
diff --git a/fs/erofs/zdata.c b/fs/erofs/zdata.c
index 6cb356c4217b..ca90d0993599 100644
--- a/fs/erofs/zdata.c
+++ b/fs/erofs/zdata.c
@@ -706,6 +706,7 @@ static int z_erofs_do_read_page(struct z_erofs_decompress_frontend *fe,
 	goto out;
 }
 
+static void z_erofs_decompressqueue_work(struct work_struct *work);
 static void z_erofs_decompress_kickoff(struct z_erofs_decompressqueue *io,
 				       bool sync, int bios)
 {
@@ -720,8 +721,14 @@ static void z_erofs_decompress_kickoff(struct z_erofs_decompressqueue *io,
 		return;
 	}
 
-	if (!atomic_add_return(bios, &io->pending_bios))
-		queue_work(z_erofs_workqueue, &io->u.work);
+	if (!atomic_add_return(bios, &io->pending_bios)) {
+		if (in_atomic() || irqs_disabled()) {
+			queue_work(z_erofs_workqueue, &io->u.work);
+			sbi->readahead_sync_decompress = true;
+		} else {
+			z_erofs_decompressqueue_work(&io->u.work);
+		}
+	}
 }
 
 static bool z_erofs_page_is_invalidated(struct page *page)
@@ -1333,7 +1340,8 @@ static void z_erofs_readahead(struct readahead_control *rac)
 	struct erofs_sb_info *const sbi = EROFS_I_SB(inode);
 
 	unsigned int nr_pages = readahead_count(rac);
-	bool sync = (nr_pages <= sbi->ctx.max_sync_decompress_pages);
+	bool sync = (sbi->readahead_sync_decompress &&
+			nr_pages <= sbi->ctx.max_sync_decompress_pages);
 	struct z_erofs_decompress_frontend f = DECOMPRESS_FRONTEND_INIT(inode);
 	struct page *page, *head = NULL;
 	LIST_HEAD(pagepool);
-- 
2.25.1

