Return-Path: <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>
X-Original-To: lists+linux-erofs@lfdr.de
Delivered-To: lists+linux-erofs@lfdr.de
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2404:9400:2:0:216:3eff:fee1:b9f1])
	by mail.lfdr.de (Postfix) with ESMTPS id 9AA1732E211
	for <lists+linux-erofs@lfdr.de>; Fri,  5 Mar 2021 07:23:13 +0100 (CET)
Received: from boromir.ozlabs.org (localhost [IPv6:::1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4DsHjW3mGRz30Mj
	for <lists+linux-erofs@lfdr.de>; Fri,  5 Mar 2021 17:23:11 +1100 (AEDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=lists.ozlabs.org;
	s=201707; t=1614925391;
	bh=U+f2k3/EQ/q2orOxvGxF26pJ1VTD80+XRYPXCcER6Qw=;
	h=To:Subject:Date:In-Reply-To:References:List-Id:List-Unsubscribe:
	 List-Archive:List-Post:List-Help:List-Subscribe:From:Reply-To:Cc:
	 From;
	b=icQrawWUD34YB7HRCCP/+X4aXlnc5dzyy1k2s3T0ogoRmJgyfPmbD9Dw60RBV3OAw
	 AdI2A4b7x+rnqM0sXm9yaE37DUfiYXzfKzIqGsSS+RO5M8EGCwZ0ZDWPdcvefkoACq
	 AfiZzZ9ZUwZFsEu9UoiHCf9mCYsZmC0RZ8p1u/QC29LaWxl0b7Qhy/ZxzK98siF7ID
	 oaGg5+VItySuI9yMDPe0jSUYswOQfm0MAYIpbWg7FjgkGsZqUvD9vj+BgmdgHhr6jM
	 GJNEP+ijwrGW1vBxdDdq5W59gU33StqCmuA2TvL7jhs1m6QKNryeJ6dv0qJqdJWvsz
	 UdicpSTPZt3bA==
X-Original-To: linux-erofs@lists.ozlabs.org
Delivered-To: linux-erofs@lists.ozlabs.org
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized)
 smtp.mailfrom=oppo.com (client-ip=40.107.131.50;
 helo=apc01-sg2-obe.outbound.protection.outlook.com;
 envelope-from=huangjianan@oppo.com; receiver=<UNKNOWN>)
Authentication-Results: lists.ozlabs.org; dkim=pass (1024-bit key;
 unprotected) header.d=oppo.com header.i=@oppo.com header.a=rsa-sha256
 header.s=selector1 header.b=nrwkPMmN; 
 dkim-atps=neutral
Received: from APC01-SG2-obe.outbound.protection.outlook.com
 (mail-eopbgr1310050.outbound.protection.outlook.com [40.107.131.50])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 4DsHjP1ygNz2xZT
 for <linux-erofs@lists.ozlabs.org>; Fri,  5 Mar 2021 17:23:04 +1100 (AEDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=N/61UvMnLCseR3abvQ+DoG2ysAClQiq2CaDzwajhWPTZ5QMfleigtk4mraSKHVOHriAWw7HNYq/qjWIkKyaNA0XuJ+ewTZWEakFU1mObm1DM9blQoygyQTi4vxF/vGzT2rx+ZTgnh/1TM/JR3GvHAMiHe/tJB1jY2EvZvqjYQXfCixrFgIVWcMmlX2/gJkYfmhsb9soKwxi72mgjc4K+4Km+BKx05hEBNDqbxtT26mbxRdfzRF97KJZRrijypGz70NweijTdjuMPhpn5c8Xm9XNFc5CmsezL6mMY3+6OgNmvjzs/f+v8Ms2BLIcxQ8sSvup3kQ/65PWZ+VrdaoDr0Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=U+f2k3/EQ/q2orOxvGxF26pJ1VTD80+XRYPXCcER6Qw=;
 b=UATsoDAus4Ga7EgGngxJumHUKQxpSnhq6d6CtuMNKu1ZK8jr1RDJ3jS05s8nTjtkw0LI8kTV+EvywKdJzPsdwuBI2g1lhER8Ono2iTcwSa9rJzxEsIOJZjmkrCNrILOkfGFtdNtS63bJm+Ho9j3kWI73UR5dk2ng54t1y5U6lHqNa3LI4f061+/bNMnJA9++iDf2dOql88YilEiaSaYyQ4eWRkcIUse2AeGhMGKmpN5vJZbH/qmDnrLLIfCRHD4v/GNHU7bBfUWGI8LnaLeDsdh1kMm3NUldSBH+L/10KiBA4M30/Eg4WftuqSikOM4VCd76Le4qdtPDCLjfun1/Sg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oppo.com; dmarc=pass action=none header.from=oppo.com;
 dkim=pass header.d=oppo.com; arc=none
Authentication-Results: lists.ozlabs.org; dkim=none (message not signed)
 header.d=none;lists.ozlabs.org; dmarc=none action=none header.from=oppo.com;
Received: from SG2PR02MB4108.apcprd02.prod.outlook.com (2603:1096:4:96::19) by
 SG2PR02MB4021.apcprd02.prod.outlook.com (2603:1096:4:80::15) with
 Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.3890.20; Fri, 5 Mar 2021 06:22:36 +0000
Received: from SG2PR02MB4108.apcprd02.prod.outlook.com
 ([fe80::1143:a7b7:6bd4:83b3]) by SG2PR02MB4108.apcprd02.prod.outlook.com
 ([fe80::1143:a7b7:6bd4:83b3%7]) with mapi id 15.20.3890.032; Fri, 5 Mar 2021
 06:22:36 +0000
To: linux-erofs@lists.ozlabs.org
Subject: [PATCH 2/2] erofs: decompress in endio if possible
Date: Fri,  5 Mar 2021 14:22:19 +0800
Message-Id: <20210305062219.557128-2-huangjianan@oppo.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20210305062219.557128-1-huangjianan@oppo.com>
References: <20210305062219.557128-1-huangjianan@oppo.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [58.255.79.104]
X-ClientProxiedBy: HKAPR04CA0018.apcprd04.prod.outlook.com
 (2603:1096:203:d0::28) To SG2PR02MB4108.apcprd02.prod.outlook.com
 (2603:1096:4:96::19)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from localhost.localdomain (58.255.79.104) by
 HKAPR04CA0018.apcprd04.prod.outlook.com (2603:1096:203:d0::28) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.3912.17 via Frontend Transport; Fri, 5 Mar 2021 06:22:34 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 0e2c40b6-cac8-4da8-1605-08d8df9f1126
X-MS-TrafficTypeDiagnostic: SG2PR02MB4021:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <SG2PR02MB4021F2F00424ED278E72C962C3969@SG2PR02MB4021.apcprd02.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:6430;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: sMjQ9EByYmcQ/8SNRUGmwMPHh8BMvA0oM0DbsgpzcPQNdCO4VZ6DyG67gf/hXjHaUSXQeQWpNWUCvUUdYtQHeNveSMjARBRXe/vuDHyAgRFNZQUizfAvkEqhKxZHPSX9UmozgbDpnGiukrmy4meJzlUpeCcD57YN9DDrT6LFNrMBmuRpTci0JiC5gmfXjlXHm3O77npCajk6az0QrS7u38iCGRGWOM1xfkRfMe7Q4eVykKF7FM+aKa8NTnCMR9RWx3wCZov/fCGgLpn9gQGMNauWyHHLWd8I33WBPaYkLPNSqlkZ+BCaH4qS4FTrWwQCJdOe6QTpZ0pZr/9s+lGay8RsJ4s0CdGQDgGnexQf1nEBVLH8pSaCrTVKGMfLv9y8Ld8yAwPQpjHw0qyereRjV+/ZFh2secsPTr+jV0/ZAf0vmq/hxbD0vFnT2HlmHCu+quvMjlB/8N+fd67k9WfKW2rKQ4EExjeeQllU/D38WSmtsPKKep5JNDrRpYAoeFiiVpmK1ugdENeittYSfY1wZAZBasxX4/q06Y6pHqymwhZH2oOVesAQzd07/t15LquQdTAOtk7OasMrZINKxIgEcCEJ7EdPSqVzkv6lvQ3UntA=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:SG2PR02MB4108.apcprd02.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(4636009)(376002)(366004)(346002)(39860400002)(396003)(136003)(26005)(6512007)(2906002)(86362001)(66476007)(1076003)(69590400012)(316002)(8676002)(2616005)(8936002)(6506007)(956004)(5660300002)(6666004)(186003)(16526019)(66946007)(36756003)(478600001)(6916009)(4326008)(6486002)(66556008)(83380400001)(52116002)(11606007);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData: =?us-ascii?Q?DftsfRBCf9yJIMLYGQhWRoCoI/ulFpnUtbSOLT6STkF4KotB57IrtDQMqtV5?=
 =?us-ascii?Q?6a7O6Iu9pW8Fi9+vmD9f1gvZnuhnPSjb5bUTZDXVUoJKjb5lQ17p9ot0feXP?=
 =?us-ascii?Q?ipInqRPociTrwMTQunTiD7UOIRpyFGUZ2H3W926+Yb7vGvFzw7UlJYpEBB3J?=
 =?us-ascii?Q?AI0PVqGKrMjkUeZoHxNeeqb+q55Gz0XLca/aQi+yni0NqZnXfEtXMQjW8a/g?=
 =?us-ascii?Q?2rjw/yp7S124SO5w9EF4ennzQUwSIBDEtRyR1MMm0Eg/4lr+gKWCTw/ldIQn?=
 =?us-ascii?Q?lbhCqZd4dGv9/n3nTOwYRuSPdFzcWfCTkUIpqpEj/OWYo8RcnJAIksbBRMiy?=
 =?us-ascii?Q?YXhdgpYUBC2TYTOQVNnJtVn8cU646zNzuSvHVZy8/XXynP88kGv2N0p8F82z?=
 =?us-ascii?Q?Bv0P9auFIam7HikGDs3Nfmwg1QbT8YahaPT9qOv3aPdmI8pW0+ZDQI+DaS9v?=
 =?us-ascii?Q?6ubRqJ5k47+QN8wqXkHcky107R2EL8WLGZ67LbOLY/I339oL1apYoUgYszhw?=
 =?us-ascii?Q?luVrEM33bitk0GiAkYWoR9HYVxjNW8UkPboybQAhc6K5maVeVXSju54NBpYI?=
 =?us-ascii?Q?nrTt9ifZNZldO7SxvBn4rlmPr0MGrMsH93AXdhMxB0SBKZ2FzkFfBZr+BSb+?=
 =?us-ascii?Q?SqPWnHRo47RsePGHYA8z3ijIi0ZYCgtAiaW72j1KBJXgGdw4Yfga3GAQTCEy?=
 =?us-ascii?Q?rAjSpxiLk141jfBcg4H2ODcvyyp+7k2ZSl7n9S8RYT9mrpNeyjBL7GaHJLv5?=
 =?us-ascii?Q?b6FPAgdi1vIYPCYboFQP8m7gYmmKdbgw/FBqgYgbST++7u1Tm2NtIu19mjQr?=
 =?us-ascii?Q?rGlMt4ZD71xzYARZuI0g7c+rDAByNsZVinhm12YUFqiDoOktipN7K8+FB8o4?=
 =?us-ascii?Q?ezPZPXqiUeVUD4Y09WYN8pOQ1LOYXEL2eM7f56bL9hkn6VfHIZLTty/brlPa?=
 =?us-ascii?Q?AwQdMW9NIKZoDPVpTAytSIEEspQPEg0CelYLaLafkmwxdRSjFmVPIkGyElBX?=
 =?us-ascii?Q?EimQUdiNfqZrphx1pmP4qIndG5Len/XQW6neuM4oEuaJC9+7AvIi933ikH3S?=
 =?us-ascii?Q?HkXGaNePJkFjbyhR67OcNN3p0SrKe9+t3NpUhdKEQilN7S2akvegmvjS0Tqg?=
 =?us-ascii?Q?0sJnKqlQ/3TcTJLqotD70D/EKaXBOTBhomqh8w0oMwTkX8/bIvW/ple9cnWv?=
 =?us-ascii?Q?V6xfxvdgvMs/LsTF9WvEdO0SbCoO4ShZ4Wisj6cYA42A1LJxnZo5vFciklbQ?=
 =?us-ascii?Q?2TVlygX1iGZznTInNnyJbgcdIPRAD0gFRkMxKoDaey9LWWjR87fUAQy79mIG?=
 =?us-ascii?Q?Kf5Z6XB1CkDQhTvMwe0Qbg1P?=
X-OriginatorOrg: oppo.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 0e2c40b6-cac8-4da8-1605-08d8df9f1126
X-MS-Exchange-CrossTenant-AuthSource: SG2PR02MB4108.apcprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 05 Mar 2021 06:22:35.9284 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: f1905eb1-c353-41c5-9516-62b4a54b5ee6
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: vgqp/UVQi78H03sbTxEJ7onKJSnjWtXLFDSOZSfTuPm5Itlbl185EY3szi4iBAbG4cpkuwhE1RDakRTHJJbrxg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SG2PR02MB4021
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

z_erofs_decompressqueue_endio may not be executed in the interrupt
context, for example, when dm-verity is turned on. In this scenario,
io should be decompressed directly to avoid additional scheduling
overhead. Also there is no need to wait for endio to execute
synchronous decompression.

Signed-off-by: Huang Jianan <huangjianan@oppo.com>
Signed-off-by: Guo Weichao <guoweichao@oppo.com>
---
 fs/erofs/internal.h |   3 ++
 fs/erofs/super.c    |   1 +
 fs/erofs/zdata.c    | 102 ++++++++++++++++++++++++--------------------
 3 files changed, 60 insertions(+), 46 deletions(-)

diff --git a/fs/erofs/internal.h b/fs/erofs/internal.h
index 77965490dced..a19bcbb681fc 100644
--- a/fs/erofs/internal.h
+++ b/fs/erofs/internal.h
@@ -71,6 +71,9 @@ struct erofs_sb_info {
 	/* pseudo inode to manage cached pages */
 	struct inode *managed_cache;
 
+	/* decide whether to decompress synchronously */
+	bool sync_decompress;
+
 	/* # of pages needed for EROFS lz4 rolling decompression */
 	u16 lz4_max_distance_pages;
 #endif	/* CONFIG_EROFS_FS_ZIP */
diff --git a/fs/erofs/super.c b/fs/erofs/super.c
index 37f1cc9d28cc..5b9a21d10a30 100644
--- a/fs/erofs/super.c
+++ b/fs/erofs/super.c
@@ -188,6 +188,7 @@ static int erofs_read_superblock(struct super_block *sb)
 		goto out;
 	}
 
+	sbi->sync_decompress = false;
 	/* parse on-disk compression configurations */
 	z_erofs_load_lz4_config(sbi, dsb);
 	ret = 0;
diff --git a/fs/erofs/zdata.c b/fs/erofs/zdata.c
index 6cb356c4217b..727dd01f55c1 100644
--- a/fs/erofs/zdata.c
+++ b/fs/erofs/zdata.c
@@ -706,56 +706,11 @@ static int z_erofs_do_read_page(struct z_erofs_decompress_frontend *fe,
 	goto out;
 }
 
-static void z_erofs_decompress_kickoff(struct z_erofs_decompressqueue *io,
-				       bool sync, int bios)
-{
-	/* wake up the caller thread for sync decompression */
-	if (sync) {
-		unsigned long flags;
-
-		spin_lock_irqsave(&io->u.wait.lock, flags);
-		if (!atomic_add_return(bios, &io->pending_bios))
-			wake_up_locked(&io->u.wait);
-		spin_unlock_irqrestore(&io->u.wait.lock, flags);
-		return;
-	}
-
-	if (!atomic_add_return(bios, &io->pending_bios))
-		queue_work(z_erofs_workqueue, &io->u.work);
-}
-
 static bool z_erofs_page_is_invalidated(struct page *page)
 {
 	return !page->mapping && !z_erofs_is_shortlived_page(page);
 }
 
-static void z_erofs_decompressqueue_endio(struct bio *bio)
-{
-	tagptr1_t t = tagptr_init(tagptr1_t, bio->bi_private);
-	struct z_erofs_decompressqueue *q = tagptr_unfold_ptr(t);
-	blk_status_t err = bio->bi_status;
-	struct bio_vec *bvec;
-	struct bvec_iter_all iter_all;
-
-	bio_for_each_segment_all(bvec, bio, iter_all) {
-		struct page *page = bvec->bv_page;
-
-		DBG_BUGON(PageUptodate(page));
-		DBG_BUGON(z_erofs_page_is_invalidated(page));
-
-		if (err)
-			SetPageError(page);
-
-		if (erofs_page_is_managed(EROFS_SB(q->sb), page)) {
-			if (!err)
-				SetPageUptodate(page);
-			unlock_page(page);
-		}
-	}
-	z_erofs_decompress_kickoff(q, tagptr_unfold_tags(t), -1);
-	bio_put(bio);
-}
-
 static int z_erofs_decompress_pcluster(struct super_block *sb,
 				       struct z_erofs_pcluster *pcl,
 				       struct list_head *pagepool)
@@ -991,6 +946,60 @@ static void z_erofs_decompressqueue_work(struct work_struct *work)
 	kvfree(bgq);
 }
 
+static void z_erofs_decompress_kickoff(struct z_erofs_decompressqueue *io,
+				       bool sync, int bios)
+{
+	struct erofs_sb_info *const sbi = EROFS_SB(io->sb);
+
+	/* wake up the caller thread for sync decompression */
+	if (sync) {
+		unsigned long flags;
+
+		spin_lock_irqsave(&io->u.wait.lock, flags);
+		if (!atomic_add_return(bios, &io->pending_bios))
+			wake_up_locked(&io->u.wait);
+		spin_unlock_irqrestore(&io->u.wait.lock, flags);
+		return;
+	}
+
+	if (!atomic_add_return(bios, &io->pending_bios)) {
+		if (in_atomic() || irqs_disabled()) {
+			queue_work(z_erofs_workqueue, &io->u.work);
+			if (unlikely(!sbi->sync_decompress))
+				sbi->sync_decompress = true;
+		}
+		else
+			z_erofs_decompressqueue_work(&io->u.work);
+	}
+}
+
+static void z_erofs_decompressqueue_endio(struct bio *bio)
+{
+	tagptr1_t t = tagptr_init(tagptr1_t, bio->bi_private);
+	struct z_erofs_decompressqueue *q = tagptr_unfold_ptr(t);
+	blk_status_t err = bio->bi_status;
+	struct bio_vec *bvec;
+	struct bvec_iter_all iter_all;
+
+	bio_for_each_segment_all(bvec, bio, iter_all) {
+		struct page *page = bvec->bv_page;
+
+		DBG_BUGON(PageUptodate(page));
+		DBG_BUGON(z_erofs_page_is_invalidated(page));
+
+		if (err)
+			SetPageError(page);
+
+		if (erofs_page_is_managed(EROFS_SB(q->sb), page)) {
+			if (!err)
+				SetPageUptodate(page);
+			unlock_page(page);
+		}
+	}
+	z_erofs_decompress_kickoff(q, tagptr_unfold_tags(t), -1);
+	bio_put(bio);
+}
+
 static struct page *pickup_page_for_submission(struct z_erofs_pcluster *pcl,
 					       unsigned int nr,
 					       struct list_head *pagepool,
@@ -1333,7 +1342,8 @@ static void z_erofs_readahead(struct readahead_control *rac)
 	struct erofs_sb_info *const sbi = EROFS_I_SB(inode);
 
 	unsigned int nr_pages = readahead_count(rac);
-	bool sync = (nr_pages <= sbi->ctx.max_sync_decompress_pages);
+	bool sync = (nr_pages <= sbi->ctx.max_sync_decompress_pages) &
+			sbi->sync_decompress;
 	struct z_erofs_decompress_frontend f = DECOMPRESS_FRONTEND_INIT(inode);
 	struct page *page, *head = NULL;
 	LIST_HEAD(pagepool);
-- 
2.25.1

