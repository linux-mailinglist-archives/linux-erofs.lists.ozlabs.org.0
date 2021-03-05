Return-Path: <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>
X-Original-To: lists+linux-erofs@lfdr.de
Delivered-To: lists+linux-erofs@lfdr.de
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2404:9400:2:0:216:3eff:fee1:b9f1])
	by mail.lfdr.de (Postfix) with ESMTPS id E1D9132E5A0
	for <lists+linux-erofs@lfdr.de>; Fri,  5 Mar 2021 11:03:56 +0100 (CET)
Received: from boromir.ozlabs.org (localhost [IPv6:::1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4DsNcB696gz3dCC
	for <lists+linux-erofs@lfdr.de>; Fri,  5 Mar 2021 21:03:54 +1100 (AEDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=lists.ozlabs.org;
	s=201707; t=1614938634;
	bh=xu2G9oEQnuVSblE7G1nmtK5TyDa/Uz+e4XlecxXyVTM=;
	h=To:Subject:Date:In-Reply-To:References:List-Id:List-Unsubscribe:
	 List-Archive:List-Post:List-Help:List-Subscribe:From:Reply-To:Cc:
	 From;
	b=gBff9BOrCGLPXExrJPp1ZOUqB9pHbA9RklYzym3jh8VUQUWJxceTD9ejpVQF7+Jxp
	 IQFp+ZSjb0Orq11QPbfV9LQkisuAtXerSktqHgxsj1tx+ggQZWzH9puJ3iw4n1/4aH
	 tqmt2w88WDTSZPBAMRtByg077WgYg+8zgM4mPKfzgj9pvgOUqYdA0WeHGSFnjRIaWW
	 Nisik6ArkGskwnQpLY7G3OAWAqHOo9IZVM6BXDFdeC4mkreu+iDTzIHmOyWHLkzwDp
	 rBn3IYbl+Dho+oW26o8b3wqF9NuEbE4oRIwmsX2CAp/ZIwxcbY84QE5rVn0FZPTFRY
	 BzejtJ/9GQR0w==
X-Original-To: linux-erofs@lists.ozlabs.org
Delivered-To: linux-erofs@lists.ozlabs.org
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized)
 smtp.mailfrom=oppo.com (client-ip=40.107.132.79;
 helo=apc01-pu1-obe.outbound.protection.outlook.com;
 envelope-from=huangjianan@oppo.com; receiver=<UNKNOWN>)
Authentication-Results: lists.ozlabs.org; dkim=pass (1024-bit key;
 unprotected) header.d=oppo.com header.i=@oppo.com header.a=rsa-sha256
 header.s=selector1 header.b=hGTT91mP; 
 dkim-atps=neutral
Received: from APC01-PU1-obe.outbound.protection.outlook.com
 (mail-eopbgr1320079.outbound.protection.outlook.com [40.107.132.79])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 4DsNc50dbgz30M6
 for <linux-erofs@lists.ozlabs.org>; Fri,  5 Mar 2021 21:03:49 +1100 (AEDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=b/kk2vnTV0mSqCfzkbIg4/r517ANvfRQ4GW+hYAZagG0xeXNrZkIoEBL/8ySvwlFnLgHyZ85dAvYnN9nCJRiI3h5P6mQw0tKbmhvBboCryMk0yx4nqkBnFlhCoXwfHcYuw832CFdq9ccZDqXSl2pGmx/nZaAqevuo27OBiU6cVXia3D3hYQALzyrEAdGVN8nBtwvXJ5ClxLK8FcLgRZSqDQbb7bZtgcVsLE1AL4zk5JEq7ZyuRBauUfL/gM1yHoo3z1/c9X7pGYJGQ4VMsVCnuelKPonSD+otJvBiYz5CK2HhlkgWicKS7Gonw0Nsq/JWfYBPrPoUjAzM41b2xi6ag==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=xu2G9oEQnuVSblE7G1nmtK5TyDa/Uz+e4XlecxXyVTM=;
 b=Y9YhXcVAGC3qI1b1Fxe5+sOSNKNjoec5Xw4jm7HUwFTPSSgzqgShVPAFZIQ4ec1Acrrvk3msnALcoYMIxO8BIBuDV9Ym7Y4f698RzbgllhxurBEp51QDKUWz4G7NBlPbsrvAw+A2UqEVNrEuGWJv5zN6Q7HHgDdzrN7YggFL4y5WRiToSJDkKahivCGLo0yspP8ynQuL9lQFENezAhMjHp1qM+Gf9pCJOX4XemftS8bcC1K+WMFoa9IUt9dzQsdCto4r+/EcVNF35hLynNYNCdOA+eRb8DyLjK2E9UcDIRVVaejIlXOQs66LZ+tPmlEoAgb/Z7jdNN3g92o+1Cm8JA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oppo.com; dmarc=pass action=none header.from=oppo.com;
 dkim=pass header.d=oppo.com; arc=none
Authentication-Results: oppo.com; dkim=none (message not signed)
 header.d=none;oppo.com; dmarc=none action=none header.from=oppo.com;
Received: from SG2PR02MB4108.apcprd02.prod.outlook.com (2603:1096:4:96::19) by
 SG2PR02MB2560.apcprd02.prod.outlook.com (2603:1096:3:23::11) with
 Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.3890.19; Fri, 5 Mar 2021 10:03:42 +0000
Received: from SG2PR02MB4108.apcprd02.prod.outlook.com
 ([fe80::1143:a7b7:6bd4:83b3]) by SG2PR02MB4108.apcprd02.prod.outlook.com
 ([fe80::1143:a7b7:6bd4:83b3%7]) with mapi id 15.20.3890.032; Fri, 5 Mar 2021
 10:03:41 +0000
To: huangjianan@oppo.com
Subject: [PATCH v5 2/2] erofs: decompress in endio if possible
Date: Fri,  5 Mar 2021 17:58:40 +0800
Message-Id: <20210305095840.31025-2-huangjianan@oppo.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20210305095840.31025-1-huangjianan@oppo.com>
References: <20210305062219.557128-1-huangjianan@oppo.com>
 <20210305095840.31025-1-huangjianan@oppo.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [58.252.5.72]
X-ClientProxiedBy: HK2PR0401CA0019.apcprd04.prod.outlook.com
 (2603:1096:202:2::29) To SG2PR02MB4108.apcprd02.prod.outlook.com
 (2603:1096:4:96::19)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from localhost.localdomain (58.252.5.72) by
 HK2PR0401CA0019.apcprd04.prod.outlook.com (2603:1096:202:2::29) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3912.17 via Frontend
 Transport; Fri, 5 Mar 2021 10:03:40 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: f8c5435c-61cf-4562-bce2-08d8dfbdf47f
X-MS-TrafficTypeDiagnostic: SG2PR02MB2560:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <SG2PR02MB25608539DC7411E658C33E12C3969@SG2PR02MB2560.apcprd02.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:3826;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: Cw/eDfhjVkEYeJ9pQEZwpn/6oj9ZHqsNzMqXTMARw50Zc77/Kuuq8rXbSfE3MOdTcOhG4go6L5HYnV1n45Mlsem6GvwsNnZUfpUNjcez2MYZPGnn0ZpHBl5NzgGkQ0XYNTaqdIfV4Hns1h3JGLq2zd3bNITO8Eb4boI383H7rI6jrmj5CCOG78OX1SbHHyOYeWCP7W3i0aZr6guWJRrKx/7GVs5ssys9Blc9xGesjlESyEOUvGFleXQKAdoRffg5tmTuhFcl/s2BSU0t5tMGYIacvGaCDjebRfeIKZ1KXYOu7fHZiPjHSJEW+Dqo4SSdRUVpp1wWWWZQxInxGp9xSrnN34G5X+kYb+5x9aJFeshkALdXBEM1SyJbZCRjlnwq1QMNq4sXRx7ZxvcT5pkELNZnP+7YiAwlI9L6OVNtFbbkh6/jsj8v5osS3K3xDgRymVNAwXCAYqxYPpSdnrF8R73RTSNtjZw+LaZhrj68OWMX7JjPdAfUopHkNtmlYtvcyn5+r7T/wkA+h6YtoIjYYeOIwzrG6gl7FoRAiDq6b4Kmz0dt/Jn/OnDWKVGvqg40Ca0tBaAdNoIj8AvPb/RHJeEcgL/SRpdlDW+LJoUQ3rY=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:SG2PR02MB4108.apcprd02.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(4636009)(376002)(366004)(396003)(136003)(39860400002)(346002)(37006003)(2616005)(36756003)(956004)(83380400001)(107886003)(5660300002)(66476007)(8936002)(8676002)(66556008)(16526019)(66946007)(186003)(4326008)(86362001)(2906002)(26005)(34206002)(6486002)(52116002)(6512007)(316002)(1076003)(478600001)(6506007)(69590400012)(11606007);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData: =?us-ascii?Q?XSij946jLWqupmfiYCitd31SdamqCX0/cBdxGL6OX/laasnAIfxSTYcgM4lJ?=
 =?us-ascii?Q?uTippnTiTr8JfuhrASEJ6hynaA3yXnrU3YreoTU3/ivLunXdi+7h4aRfwqy8?=
 =?us-ascii?Q?dBnVPKJriw2YozgnnHLR9E2zs46/E5Glt6GD+z+oomsjUdSa8yWki6Ct40yJ?=
 =?us-ascii?Q?U5roN0XJpWvWWcW7gV2ADu+asaItWRkVh5874zFM/KP0JylCIVy1zgOgf6AU?=
 =?us-ascii?Q?1wjZqKQYGLs2Ssm6rX7+hy/huAodwSTCweuum7298UbiSI6F6GfG60dc/sC8?=
 =?us-ascii?Q?BNV+2W1lAcsU14OD12PbJ2e7WSeUED4AFEORKY4f+ZVTW8F4kwcByDuHttn3?=
 =?us-ascii?Q?a4xja0l4dXW0uLSP+uYj2hcjrv+QnEU0f/PKiy+xxJIF5p40TgZbMLazTORi?=
 =?us-ascii?Q?zknHeRu3S/wEzATyvWMojf5jm/cKHUwfV+DC0O/u7Nx8bYhV4bkKWXPLQOt2?=
 =?us-ascii?Q?tkj7UIldv7HXa89NYdGcnYmrbd+tf+Cz8Q0oARrcePxMB+6iqWzGgyEn3kTH?=
 =?us-ascii?Q?U1lPVRR3hdu0dh+eBXTDoQ8+26qqa6YsirQSZC3ToyhAPomfEqiDycaaxZ08?=
 =?us-ascii?Q?uO2yVggWG7ncEa05iwI/QuNBFdHgZ6Bl44wuRCTOjZUciqS0G98XwUVioOF6?=
 =?us-ascii?Q?mmZvFreATpGzdIcafzWBo5qIB2QyWpm0TW+NwtB2lJGEFaNewozS+xVaPHcw?=
 =?us-ascii?Q?k9/W6LBcWxVas1Oj0OjvvVZ0gatz9Y8JgsRlQQeICWRtS8rjU3WrVemN61XQ?=
 =?us-ascii?Q?hlaC1DZK9ikjvzXnPWe+L9vTUZzNbux3WFDvSmqj0uiWuvvSMgjbm/vvypNG?=
 =?us-ascii?Q?ub6dDp1wqBMnaNlqmN/KiCNtTTGGrYxU6IAQOYuWIQvYQxLBe8C6TMQd5bsF?=
 =?us-ascii?Q?B5ue4PXP7xMTNrGp2rLdoEvOxRFjz/3WoAkxUNCCjhXmELYOPV0Sj+ML/Z1i?=
 =?us-ascii?Q?DCKQ06lJNI7+7Fr9f7hFB4aqCknQY0HWu+L74X5aN7yMtFFh5xvqhyM3DgiM?=
 =?us-ascii?Q?su9mV3Vs58ifIzOMbnQP+ysJNij3ktDj/Z/K6WXEG3y9Bb2Kq+nvfH6+LA+l?=
 =?us-ascii?Q?RiK1jI5cR0MlZN+OE2NgdazzeNo0KHacqwcJ7NJYtinujCKXgp+/l3NYZWRd?=
 =?us-ascii?Q?iNQ7HBTfcjYq5HzXxe4lFLOrF+WSaI0dOKktOkDr0Eesl4gjJgnuCdu6uoqH?=
 =?us-ascii?Q?WURRKSKwMFWmKzr0TLqRavWUO/Y9uGhFTGOJLkjPIahsqqKtWq7NZUj23zS7?=
 =?us-ascii?Q?Ll0ecIwbiiYUSlHtbwVuvcFz9nRwHimCL5axOpiRKkYM/obYG/cxIH5t8e/1?=
 =?us-ascii?Q?AveukmP8ZDgEqI1XFcuzIGUb?=
X-OriginatorOrg: oppo.com
X-MS-Exchange-CrossTenant-Network-Message-Id: f8c5435c-61cf-4562-bce2-08d8dfbdf47f
X-MS-Exchange-CrossTenant-AuthSource: SG2PR02MB4108.apcprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 05 Mar 2021 10:03:41.8079 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: f1905eb1-c353-41c5-9516-62b4a54b5ee6
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: fS+DmA7w+NPEcqOs7G4oqxRc6uivx4CcZaZJ8KXqzu/IYVPvmoWk7zmGgS5MKkYlOdt0OxzAqn6JNkqiVqDppA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SG2PR02MB2560
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
Cc: zhangshiming@oppo.com, guoweichao@oppo.com, linux-erofs@lists.ozlabs.org,
 linux-kernel@vger.kernel.org
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
 fs/erofs/internal.h |  2 ++
 fs/erofs/super.c    |  1 +
 fs/erofs/zdata.c    | 16 +++++++++++++---
 3 files changed, 16 insertions(+), 3 deletions(-)

diff --git a/fs/erofs/internal.h b/fs/erofs/internal.h
index 67a7ec945686..e325da7be237 100644
--- a/fs/erofs/internal.h
+++ b/fs/erofs/internal.h
@@ -53,6 +53,8 @@ struct erofs_fs_context {
 
 	/* threshold for decompression synchronously */
 	unsigned int max_sync_decompress_pages;
+	/* decide whether to decompress synchronously */
+	bool readahead_sync_decompress;
 #endif
 	unsigned int mount_opt;
 };
diff --git a/fs/erofs/super.c b/fs/erofs/super.c
index d5a6b9b888a5..0445d09b6331 100644
--- a/fs/erofs/super.c
+++ b/fs/erofs/super.c
@@ -200,6 +200,7 @@ static void erofs_default_options(struct erofs_fs_context *ctx)
 #ifdef CONFIG_EROFS_FS_ZIP
 	ctx->cache_strategy = EROFS_ZIP_CACHE_READAROUND;
 	ctx->max_sync_decompress_pages = 3;
+	ctx->readahead_sync_decompress = false;
 #endif
 #ifdef CONFIG_EROFS_FS_XATTR
 	set_opt(ctx, XATTR_USER);
diff --git a/fs/erofs/zdata.c b/fs/erofs/zdata.c
index 6cb356c4217b..b22cea78a9fd 100644
--- a/fs/erofs/zdata.c
+++ b/fs/erofs/zdata.c
@@ -706,9 +706,12 @@ static int z_erofs_do_read_page(struct z_erofs_decompress_frontend *fe,
 	goto out;
 }
 
+static void z_erofs_decompressqueue_work(struct work_struct *work);
 static void z_erofs_decompress_kickoff(struct z_erofs_decompressqueue *io,
 				       bool sync, int bios)
 {
+	struct erofs_sb_info *const sbi = EROFS_SB(io->sb);
+
 	/* wake up the caller thread for sync decompression */
 	if (sync) {
 		unsigned long flags;
@@ -720,8 +723,14 @@ static void z_erofs_decompress_kickoff(struct z_erofs_decompressqueue *io,
 		return;
 	}
 
-	if (!atomic_add_return(bios, &io->pending_bios))
-		queue_work(z_erofs_workqueue, &io->u.work);
+	if (!atomic_add_return(bios, &io->pending_bios)) {
+		if (in_atomic() || irqs_disabled()) {
+			queue_work(z_erofs_workqueue, &io->u.work);
+			sbi->ctx.readahead_sync_decompress = true;
+		} else {
+			z_erofs_decompressqueue_work(&io->u.work);
+		}
+	}
 }
 
 static bool z_erofs_page_is_invalidated(struct page *page)
@@ -1333,7 +1342,8 @@ static void z_erofs_readahead(struct readahead_control *rac)
 	struct erofs_sb_info *const sbi = EROFS_I_SB(inode);
 
 	unsigned int nr_pages = readahead_count(rac);
-	bool sync = (nr_pages <= sbi->ctx.max_sync_decompress_pages);
+	bool sync = (sbi->ctx.readahead_sync_decompress &&
+			nr_pages <= sbi->ctx.max_sync_decompress_pages);
 	struct z_erofs_decompress_frontend f = DECOMPRESS_FRONTEND_INIT(inode);
 	struct page *page, *head = NULL;
 	LIST_HEAD(pagepool);
-- 
2.25.1

