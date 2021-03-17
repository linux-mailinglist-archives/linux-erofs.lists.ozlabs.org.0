Return-Path: <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>
X-Original-To: lists+linux-erofs@lfdr.de
Delivered-To: lists+linux-erofs@lfdr.de
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	by mail.lfdr.de (Postfix) with ESMTPS id 892B433E7E8
	for <lists+linux-erofs@lfdr.de>; Wed, 17 Mar 2021 04:55:21 +0100 (CET)
Received: from boromir.ozlabs.org (localhost [IPv6:::1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4F0bsM3hkLz30NV
	for <lists+linux-erofs@lfdr.de>; Wed, 17 Mar 2021 14:55:19 +1100 (AEDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=lists.ozlabs.org;
	s=201707; t=1615953319;
	bh=vgR/SNgoCVI4uiSk0fG2H7beQ2gDIzpatprs0478WG8=;
	h=To:Subject:Date:In-Reply-To:References:List-Id:List-Unsubscribe:
	 List-Archive:List-Post:List-Help:List-Subscribe:From:Reply-To:Cc:
	 From;
	b=Wq+ZM6o7uFeHEop6lWQdtwvt+VDk0iR9MgZFVgty998rSXFKKFiCTSOXfT4B7h4UP
	 Y7DuTpvNChA/ldroFXOWEV2SZS03eLTLhDqQaSIdAab6ZIT9TWXPECOiykOIoZffZb
	 mlHQnu8LZHmjfObwt3n3q3Vly8PpXs2rrtIu3/Iz+eCTHbVyUviv43OzWSQV3ATF9w
	 OZ8iDgkX3uwVISvyvD9T5biE0YKaDk2DOueI69y2lPUB61ylWdLs6P9kc0ZMOIyuKG
	 qV8bvgUhbe4sAdjCxqaDk787tUtmJ9gvrlxkRbwdS4nQupeU653sHRJL3wL9RszfRQ
	 IgQyBBQceuqIQ==
X-Original-To: linux-erofs@lists.ozlabs.org
Delivered-To: linux-erofs@lists.ozlabs.org
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized)
 smtp.mailfrom=oppo.com (client-ip=40.107.131.54;
 helo=apc01-sg2-obe.outbound.protection.outlook.com;
 envelope-from=huangjianan@oppo.com; receiver=<UNKNOWN>)
Authentication-Results: lists.ozlabs.org; dkim=pass (1024-bit key;
 unprotected) header.d=oppo.com header.i=@oppo.com header.a=rsa-sha256
 header.s=selector1 header.b=IrTeQ8gK; 
 dkim-atps=neutral
Received: from APC01-SG2-obe.outbound.protection.outlook.com
 (mail-eopbgr1310054.outbound.protection.outlook.com [40.107.131.54])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 4F0bsG2Ph1z2xZv
 for <linux-erofs@lists.ozlabs.org>; Wed, 17 Mar 2021 14:55:14 +1100 (AEDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=mjyJV4nAs4Y4MUBUfcjC2vpvSyq75J0hAz+1sI0vXP2PqicRJ1zADlOa7WR7/pw7SxN8meZusqhzWIx7xD/342hJvd4aCrHakLxZ0W3o1DCAbxNibYTKF33J1M00wnhtzFI2G+fa0zZllxkqw4JF0MT0a02HE/1Bg8n0NrN7Sf9sy1pWAgEBhG/oWDxrci6e4aqMYtbpcOcA1luDs/vesoHupaEoOOdGYyspY4oHbEnYXyMq4fPixYsfhjy9QgnnQ5TnKGS3e6WVa1hIlc5h3D/4UJEQTGE+6/EPH4EXGOQs2aHYOrTU8MnysHK1yqgKSIQkkb2H3wzrpyJ5eLRWfQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=vgR/SNgoCVI4uiSk0fG2H7beQ2gDIzpatprs0478WG8=;
 b=TVOCOr4pWp3yv0nsBbbrSLXGfBn/67zltaNtVy8Nyv38T/GlfLqRfIw8hObgL6cwp/E5TlyynsnzAYBrnOwqkFctK234fq6L6NzghoOQNjHKclTlw9bGrWaLI/EwnI5XVY61wbPg66WEJtatpC5dgtUX2Y4oJKU07UNjDUo9eOlOa/z0e9au6HasIVildNrjZfM16us1/ut+GUiN8TIr1uW1aRXk4sjVf5wULZ1CMBLh/36+2h+e/mVktMDnjrJVz78HQL2U0qOqTOylvjQ8xHd8JkI7ymCaHkVpgWKwR23bNTCXQb/EJCLcltrpxI0l4WrNYZrqODzCKK/JYELdAA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oppo.com; dmarc=pass action=none header.from=oppo.com;
 dkim=pass header.d=oppo.com; arc=none
Authentication-Results: lists.ozlabs.org; dkim=none (message not signed)
 header.d=none;lists.ozlabs.org; dmarc=none action=none header.from=oppo.com;
Received: from SG2PR02MB4108.apcprd02.prod.outlook.com (2603:1096:4:96::19) by
 SG2PR02MB2986.apcprd02.prod.outlook.com (2603:1096:4:5e::14) with
 Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.3933.31; Wed, 17 Mar 2021 03:55:07 +0000
Received: from SG2PR02MB4108.apcprd02.prod.outlook.com
 ([fe80::1143:a7b7:6bd4:83b3]) by SG2PR02MB4108.apcprd02.prod.outlook.com
 ([fe80::1143:a7b7:6bd4:83b3%7]) with mapi id 15.20.3933.032; Wed, 17 Mar 2021
 03:55:07 +0000
To: linux-erofs@lists.ozlabs.org
Subject: [PATCH 2/2] erofs: use sync decompression for atomic contexts only
Date: Wed, 17 Mar 2021 11:54:48 +0800
Message-Id: <20210317035448.13921-3-huangjianan@oppo.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20210317035448.13921-1-huangjianan@oppo.com>
References: <20210317035448.13921-1-huangjianan@oppo.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [58.255.79.104]
X-ClientProxiedBy: HK2PR02CA0132.apcprd02.prod.outlook.com
 (2603:1096:202:16::16) To SG2PR02MB4108.apcprd02.prod.outlook.com
 (2603:1096:4:96::19)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from localhost.localdomain (58.255.79.104) by
 HK2PR02CA0132.apcprd02.prod.outlook.com (2603:1096:202:16::16) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.3955.18 via Frontend Transport; Wed, 17 Mar 2021 03:55:06 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 95ab3bf6-3a24-4ac4-a9cd-08d8e8f87409
X-MS-TrafficTypeDiagnostic: SG2PR02MB2986:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <SG2PR02MB2986278C651C6A86A40E5AADC36A9@SG2PR02MB2986.apcprd02.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:6108;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: Gelq+seq1b7jvG2bKXKvR2NbaVHB5sqq4tG5a5D5q6V6n6uNV2CHE+4wdiSeQj13oZhg/zWhlhvpnXnBJp5zebAkVEWGd4tRbQbbtfsb+NfBeKUomJeBsBpk+cE0gxGidRRxXS0Xf/y3fyanqq/bK5Mp26VTt00d1wE9aLjMiI0xz3DrkvyRwsi1ZRBMIZsq2ubJsF8+7JOpi+AZYGyEOv7xXOES7JVkCVRT1mL3r4pWJfl9eCxGVGndlHpZFe52568by2mRewTX/wysV2XtEXkPMYIDUBmG4fz3VzxC+fOuxzAH2gawSLsbF5Rz9BG2kLw+zl4OQkctjW0Fu4eTCFViscsbdMn9UDupl3snEJ1HTJSo7V9hdiMcaAM438aIUaP/5PpwENtWmvAOvVx/XqDOjXnl1MTDId8rtei5zg0CthYa3EbFrX3AKEJm62l4gGcm07D5y7iFUymXRI8rc3l58VN6egu5+stazETDVj4V3bpSZtriKthPMmDXHIHe78qAS63ql16kIXetAfkfCMJ0MsVEJcQkpDV8arS0jVj0PcBTRZjTW/8TjkPPaE5OnHwATl8kw4cFiFguYT1uMI/07ZKwiOsX0vN6AfpspyPgGmnFr+uDf+jC0dVUjEUPsF3sIgeoFmOk/jW95i8Z3g==
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:SG2PR02MB4108.apcprd02.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(4636009)(376002)(136003)(39860400002)(346002)(366004)(396003)(478600001)(6506007)(186003)(6512007)(2906002)(6666004)(26005)(956004)(6486002)(83380400001)(8936002)(4326008)(16526019)(1076003)(316002)(66946007)(66476007)(6916009)(69590400012)(36756003)(66556008)(86362001)(5660300002)(8676002)(52116002)(2616005)(11606007);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData: =?us-ascii?Q?4WB27bMa2YGjsfzElBvaQ/FXgGDlb9Q1d1VmHpIPH+ZL+unokpC54i9KxRuC?=
 =?us-ascii?Q?k69wxP4UT+oHxR4J4DqnJXFCwWJh5Xji/M4PuvveO/2W8di1Eq7asvGg5ak5?=
 =?us-ascii?Q?GKjvfsyyEWq+Hfq+c2odZnRI24lWaTfrKFC9csz30kagTgD6pzpwKRpk0tdM?=
 =?us-ascii?Q?AI/GgS5rhrOGcDRd2vRQ27R5fvS+4PkoKzmYA/SY7vEAeb8HRKgtmm/qrQu+?=
 =?us-ascii?Q?jOJKOOURZ601uBky0c9UEj/wUr4zrNzkqlp0NF4dva/sd+ZnVk17yqnQas5E?=
 =?us-ascii?Q?OVbfhkCOuEC9GV6pynIMTq5CDv7RjGElZpeDk17Q6s0DjoHqJ6Bq6CmigzVs?=
 =?us-ascii?Q?FcltHK2H5D4Ew3FWlsU8HdYbhiU6pYlHBoTnRQqteUrshLu9C8wHoAlTz2Tf?=
 =?us-ascii?Q?XdbsB7XaKjJ0apgCp0TcqsPljYeMDvpN4KDFJMViWK4zqRgmdnJOlnl0jVpp?=
 =?us-ascii?Q?M1AhK+236Lcox9n1U2VMKjiwalaPAQhNT2PuLrIOU0dQo7fu15asbHyXfBik?=
 =?us-ascii?Q?5VGCeInJouVQF1bOSdQ8KWRS1OUiOwXzaFXA3kQhAnAiaV0QxncwuilU5CT/?=
 =?us-ascii?Q?xu7O0029xVjYoH5hDNlU9Jlnv7EQGxRVi3Ve2ETvsOUNvIxYyH4UhDU4ma+z?=
 =?us-ascii?Q?CymATSCu42VkpNigaRyjnv2F59tcXax1iGDKz9X3+sezF2HkiCUIVFQJjOqu?=
 =?us-ascii?Q?KBGdn9KgJfAcTpQeG7vidpwIlTeIPD5/0o7z3WHkvYEUm5j6KSTgyaEZUGed?=
 =?us-ascii?Q?5RXME2kZt01cRp6SxpYjPq3bWpRpfoaYmcjiZVI3JlVuzLwU3BbAIV+44KNC?=
 =?us-ascii?Q?UCbrI9jGRxK6oYoDT4a9D+lS2xANkhbk9JE0AMyALiOtkAhyzNv1zxHY1soD?=
 =?us-ascii?Q?InOe0nmmMcfTaLoHAhYpXesem2UnXRH5k5nwRbhUFhNmxlwd0yZmaJG/g+Lg?=
 =?us-ascii?Q?HkUlqo7IZeooGuv7zaSSUnHtagt0DTiWa7BP6hJhQ9Vcptb+ofYPLhCKPkcD?=
 =?us-ascii?Q?HuUJmkhyNcE5HK5TIzPhONl7gBwHa7hsOcTVnucb+C0QoVm01yCsVEURY3Vl?=
 =?us-ascii?Q?IvLGPsreWfjpRKxR0QB66gb6DQ9Nmlzw6FxBT0gFj3udNGVDXrFD6uHcuQjC?=
 =?us-ascii?Q?s15EA8p4FjSUQ1jkVgGp3Q+AixVKLsmbaEXywZc7adhoNBotSlEb7udIrAvo?=
 =?us-ascii?Q?cYhP6pzXXLbVdxC5/nSIbC3lLXNzFuXd37uQH+z7PhO9cV0sL2iuoO0QPi4N?=
 =?us-ascii?Q?uLABMnEMXdx9O3GzcoJWgjcGDKlMHrAMSo5PI6JGuMZnoKqlBsNEe0bBu0OA?=
 =?us-ascii?Q?lgpzYhz6U2hx6Qb2IgyOOmvP?=
X-OriginatorOrg: oppo.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 95ab3bf6-3a24-4ac4-a9cd-08d8e8f87409
X-MS-Exchange-CrossTenant-AuthSource: SG2PR02MB4108.apcprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 Mar 2021 03:55:07.0788 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: f1905eb1-c353-41c5-9516-62b4a54b5ee6
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: FyVegYaCrLC1GxRKKsIAwoGnFEukOgS+gr7MadTWEcrp2aJ08/QZBdIFaH/Jps68FcNLbjNr0X1nHz5venmprg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SG2PR02MB2986
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

Sync decompression was introduced to get rid of additional kworker
scheduling overhead. But there is no such overhead in non-atomic
contexts. Therefore, it should be better to turn off sync decompression
to avoid the current thread waiting in z_erofs_runqueue.

Signed-off-by: Huang Jianan <huangjianan@oppo.com>
Signed-off-by: Guo Weichao <guoweichao@oppo.com>
Reviewed-by: Gao Xiang <hsiangkao@redhat.com>
---
 fs/erofs/internal.h | 2 ++
 fs/erofs/super.c    | 1 +
 fs/erofs/zdata.c    | 8 ++++++--
 3 files changed, 9 insertions(+), 2 deletions(-)

diff --git a/fs/erofs/internal.h b/fs/erofs/internal.h
index 67a7ec945686..fbc4040715be 100644
--- a/fs/erofs/internal.h
+++ b/fs/erofs/internal.h
@@ -50,6 +50,8 @@ struct erofs_fs_context {
 #ifdef CONFIG_EROFS_FS_ZIP
 	/* current strategy of how to use managed cache */
 	unsigned char cache_strategy;
+	/* strategy of sync decompression (false - auto, true - force on) */
+	bool readahead_sync_decompress;
 
 	/* threshold for decompression synchronously */
 	unsigned int max_sync_decompress_pages;
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
index cf2d28582c14..25a0c4890d0a 100644
--- a/fs/erofs/zdata.c
+++ b/fs/erofs/zdata.c
@@ -710,6 +710,8 @@ static void z_erofs_decompressqueue_work(struct work_struct *work);
 static void z_erofs_decompress_kickoff(struct z_erofs_decompressqueue *io,
 				       bool sync, int bios)
 {
+	struct erofs_sb_info *const sbi = EROFS_SB(io->sb);
+
 	/* wake up the caller thread for sync decompression */
 	if (sync) {
 		unsigned long flags;
@@ -723,9 +725,10 @@ static void z_erofs_decompress_kickoff(struct z_erofs_decompressqueue *io,
 
 	if (atomic_add_return(bios, &io->pending_bios))
 		return;
-	/* Use workqueue decompression for atomic contexts only */
+	/* Use workqueue and sync decompression for atomic contexts only */
 	if (in_atomic() || irqs_disabled()) {
 		queue_work(z_erofs_workqueue, &io->u.work);
+		sbi->ctx.readahead_sync_decompress = true;
 		return;
 	}
 	z_erofs_decompressqueue_work(&io->u.work);
@@ -1340,7 +1343,8 @@ static void z_erofs_readahead(struct readahead_control *rac)
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

