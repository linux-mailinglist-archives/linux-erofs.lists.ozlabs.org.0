Return-Path: <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>
X-Original-To: lists+linux-erofs@lfdr.de
Delivered-To: lists+linux-erofs@lfdr.de
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	by mail.lfdr.de (Postfix) with ESMTPS id 26AC644A507
	for <lists+linux-erofs@lfdr.de>; Tue,  9 Nov 2021 03:55:39 +0100 (CET)
Received: from boromir.ozlabs.org (localhost [IPv6:::1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4HpCK50TSKz2ynp
	for <lists+linux-erofs@lfdr.de>; Tue,  9 Nov 2021 13:55:37 +1100 (AEDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=lists.ozlabs.org;
	s=201707; t=1636426537;
	bh=VvLokOUf35eCgKTRGFw1MK+UKYgI2JDRCOQeHH+KKQ4=;
	h=To:Subject:Date:In-Reply-To:References:List-Id:List-Unsubscribe:
	 List-Archive:List-Post:List-Help:List-Subscribe:From:Reply-To:Cc:
	 From;
	b=SglcaAgvLibi/vmf0xrSnlpzUuP3AybB9BEIOEcltFOpaRjsoSRat3LqEtbOS5YwV
	 3V3i+qtYl2WqC1/IiAvTjXxubPfeDKdUO3Atz5h6z8ZZTPenXAn6eTPSBq5lLowjve
	 sefGgY3CdzBJJXluX7zKxmEPVRQTlfh3n2Bdw9Gpxa3ukoYqjHwLtXqPthmdFhYDK8
	 M5fou1rc7MU9HarKobyIQ3bAtCsekcplJXz/deyJ0orsL2DM/DIfqHyZf1nVb8vL++
	 mz+AvWvGScoNJ+pJuuVacMOYVUR/8D4kP445Uhu5y4TB7HIp+vp/kJVQcXxyx+IQ4q
	 yG9jAUDGvt4xg==
X-Original-To: linux-erofs@lists.ozlabs.org
Delivered-To: linux-erofs@lists.ozlabs.org
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized)
 smtp.mailfrom=oppo.com (client-ip=40.107.132.41;
 helo=apc01-pu1-obe.outbound.protection.outlook.com;
 envelope-from=huangjianan@oppo.com; receiver=<UNKNOWN>)
Authentication-Results: lists.ozlabs.org; dkim=pass (1024-bit key;
 unprotected) header.d=oppo.com header.i=@oppo.com header.a=rsa-sha256
 header.s=selector1 header.b=bt22hiGa; 
 dkim-atps=neutral
Received: from APC01-PU1-obe.outbound.protection.outlook.com
 (mail-eopbgr1320041.outbound.protection.outlook.com [40.107.132.41])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 4HpCJv66f5z2xXW
 for <linux-erofs@lists.ozlabs.org>; Tue,  9 Nov 2021 13:55:27 +1100 (AEDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=MjRucwjkwyra3K4VQGGpEGg0XydrtEBjS7+TSe46p5uUMEejBKUTgSCPb9/oudfSNrmbtw3lI15Z4BWZP6V8YiUQE9jp7imqTzIoCa2msh48FQta4bHxHJ/uMy2yTdz4Vg0UWjIkoHb72Gk2mEMLkjmCJ2fSruVMYU2IqWvuviX7pZgPj15/guUgFq/py1DU88OLkZPDKYb4nNXfnGi/DLwmp4YXHAPHTlz5WIcFbEbPErdA0YqyDTEmf5UEbbeTFi40EiKzAsVGKBLySutBTrjgpAZeqa9XthMVJU5zdrix++6RDNnJvD30kVKG/UIVpCVN2nab/qlWX56Q2B0iDA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=VvLokOUf35eCgKTRGFw1MK+UKYgI2JDRCOQeHH+KKQ4=;
 b=mkPPDP4m3Pwvxde85moB4f1bO6hETzkIf1ZWK3VF4X/LUESc2sczNxIx5JZtS5mv6PG5iRtop3u/DcjjaHgX3lo7NYrCUqjPhVevX+kL1sCWH6NvkX3xfgwtTaMNxeFRq0HcbkWHG3ZWG8X7wmkzNexxvDwFSAXi4uJLdS2K9+lbjYpX0WAAbMAIBYN1R9OWAjxTgKDJecUFfzZwfdQQvuFkmYEPRJo9M7acRDAoazEy8qL1YBW9JhQM35FULIVDy6/TBBktFffES/B9fmeTbVcgE7ZqMBVCU+BJeeyHCFvJKutqJrvsLjHbQpyfyZQaoF4w2CwoHYaZTjDsXjmvGQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oppo.com; dmarc=pass action=none header.from=oppo.com;
 dkim=pass header.d=oppo.com; arc=none
Authentication-Results: lists.ozlabs.org; dkim=none (message not signed)
 header.d=none;lists.ozlabs.org; dmarc=none action=none header.from=oppo.com;
Received: from SG2PR02MB4108.apcprd02.prod.outlook.com (2603:1096:4:96::19) by
 SG2PR02MB2699.apcprd02.prod.outlook.com (2603:1096:4:58::14) with
 Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.4669.15; Tue, 9 Nov 2021 02:55:02 +0000
Received: from SG2PR02MB4108.apcprd02.prod.outlook.com
 ([fe80::7e:59ef:bec3:9988]) by SG2PR02MB4108.apcprd02.prod.outlook.com
 ([fe80::7e:59ef:bec3:9988%7]) with mapi id 15.20.4669.016; Tue, 9 Nov 2021
 02:55:02 +0000
To: linux-erofs@lists.ozlabs.org
Subject: [PATCH 2/2] erofs: add sysfs node to control sync decompression
 strategy
Date: Tue,  9 Nov 2021 10:54:45 +0800
Message-Id: <20211109025445.12427-2-huangjianan@oppo.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20211109025445.12427-1-huangjianan@oppo.com>
References: <20211109025445.12427-1-huangjianan@oppo.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: HK0PR03CA0109.apcprd03.prod.outlook.com
 (2603:1096:203:b0::25) To SG2PR02MB4108.apcprd02.prod.outlook.com
 (2603:1096:4:96::19)
MIME-Version: 1.0
Received: from PC80253450.adc.com (58.252.5.73) by
 HK0PR03CA0109.apcprd03.prod.outlook.com (2603:1096:203:b0::25) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.4669.10 via Frontend Transport; Tue, 9 Nov 2021 02:55:01 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: a4daefe5-1fe0-4ce2-06bb-08d9a32c537a
X-MS-TrafficTypeDiagnostic: SG2PR02MB2699:
X-Microsoft-Antispam-PRVS: <SG2PR02MB26991DD3C0931BC8136D0269C3929@SG2PR02MB2699.apcprd02.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:4303;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: II1WgWJboD8qT7Xc8Gl8N90UBCvxVjuQF+mdVjQ/gA9VSh7xpoOlU+6Dw14Cu6SEgxLMZECgjrIzikmXPZlu55nJ2WA2eLMKiuwnN4qGMex7bCtNisaaqViyL2IRoJFrIjhkBd0WU3h6cZ+CWuTGsQVbKQzSrJ9bT7FCqEqOtGJULTAQCD3HukDlEEAOe3YJ/6WhnBwkouaEf3q/xoFVP5hId2nB8h9cqFW4zGjDhgvV4PvKIz8WTo/Kz7lSuKAJ1kTRRMDyQJIshn3VG6sajqaR9hwjlfmJSxXLLP0DfR3Wxyq1M236fvHR3u6gzKuu/Y5+gHxBVh14bhHKeLS2VmVsdWGNnJ3Rx3Td4fl32RTqBtoucfV8QsjNXt0+nCDFtBaLyUPrt3A4EE52Hc+w/WzkMw8BwmiapyVjiUxqHRbyOaLSwvxMmcc9hNHF9uSO0flok8RVqCw3ZQW+vmziODMQor6RdVjzRi0vLuxfCzmeF+J8qW4kJtwrP45DsALlz8nBgF3zPM5ThWqLUSYa/SDRd/LlIwPcdkQtVzNkiCR/yWygtLLFlwH90r7JitRAftgQNGyaI3BAfvTj0AdLlarVL8l/kn3eROxZrPTxV2V/RUtSj7AHyBOQg+gOMN3M4LBBrXe8/lujnOKYLdDo3IXF6GVTJvLTiFfOS5HsuwgNy5fEoDjZzi9LWG/kEPT0wRw7qAmfLuu8tyWzAI28tpdWsOco362H53TP32bjSrY=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:SG2PR02MB4108.apcprd02.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(4636009)(366004)(508600001)(38100700002)(36756003)(6916009)(52116002)(66556008)(38350700002)(6506007)(6486002)(316002)(83380400001)(6512007)(4326008)(2906002)(86362001)(26005)(186003)(2616005)(1076003)(8936002)(5660300002)(956004)(66476007)(6666004)(66946007)(8676002)(11606007);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?2bwV9y1UsqybOPMsoErokG3wE9Zhly5Ba1mAirz6XyftAbLJnPfr/HECoci0?=
 =?us-ascii?Q?D5hVMxQaKwKiG85UzLYy3SnbQQSV3OQe0RdBnfpTVKuU2vzT+lBWj2NupuVC?=
 =?us-ascii?Q?pTt6tYfapGp3i4Ycz/GxA5cMm3fF9EwRooLv41d7cf7nKmtCiI4p/q6DdoSC?=
 =?us-ascii?Q?PoZQm6AIYqAShy0B8VhSLNZ73vZfnOoubD4azUpaZKRhPNokBICfx1YTlg0R?=
 =?us-ascii?Q?rXHR2lLPtAe9KUpECu0mKV+/Spb57YLGmdzH1PjlRvEQm8RaD0xeewI7G4MB?=
 =?us-ascii?Q?QIaQ5lXKswXlTthyOYukAgCyYR8AnenDB2dU08/eQ2K9HnO2VXLX5mXgi+YE?=
 =?us-ascii?Q?dyNB+1jrIEeMdePv6J1JBI9imAzVCe3L5TDjsfLmcZ8PJl8BdD0/S6YH6ccL?=
 =?us-ascii?Q?hlMBfrisqwaRrlL48YSEZg+0ov6XCrtB7jlYTdg82z9y8Fe8RQ29JJ9FegVD?=
 =?us-ascii?Q?XdujMK75IQMCD3ItSUdEpV7+MFyXpf112kHio9ZT2w4u12HTx85nMQf/qxa6?=
 =?us-ascii?Q?OGR5PzUIBRM85nBj/lCqvumJuAToSVDa8r21GUsQRHoyhRZOBD035UZSS15C?=
 =?us-ascii?Q?5Hi6bO38L7a941ZYEJyvOnFkM+eFxM5w2MLaDDRo/mZl+b5r+eo2KmwGOEPD?=
 =?us-ascii?Q?k6b6S28eenqpqP+4ozzbzfiOkpbqeZf52CAAvXe7NKsXBidrSn09MxeSK1uZ?=
 =?us-ascii?Q?fbVWVQA7qvA0HRFe8qDaShZw8JEstTHnbX4de2V3mUXREn/kLJlAoqWlO+41?=
 =?us-ascii?Q?iLROGrlR2Ot5Cgcl6Zsx7vT50EVFsj5gXKLZEJp5Hfo+y6Xaqwuok5siQIHf?=
 =?us-ascii?Q?xVDGnLteh97le7iCWYb1ppBXA1KEYCYVJN36RWsz2hFnp50+y6ed5JdsrAMi?=
 =?us-ascii?Q?EBohmqhg4m5HvioibrhhveWywsSDVvib850ViFevG7eb9DGtLhx+t00B0OWe?=
 =?us-ascii?Q?CHaK962CzYN1E1OTlHLH6DAOAJkixPSXwKey0zFE+bkZVbs092eUvuA5p+Ya?=
 =?us-ascii?Q?Vxh9kOf81c5HaGK2T0j2aLaU8/Uh4s8ghMQxcxrkYbn5SEKL2ZCEHlHecZhK?=
 =?us-ascii?Q?rMTmpXjbSsb8csL0DT4O7cqEuvI7tpiMPi+2UA5bicUd1AP9qG02jXU997YE?=
 =?us-ascii?Q?IoplsrQlCEwyVwkp7GpVVIOKdXMDoyq4ogexO6dRmzSoOf6OSzrXHsCmLIkZ?=
 =?us-ascii?Q?Rz/9zigKvslENq0XujZ9HF2cl7d7N0ro91lOsrkU7CuWGFp9LGpj0Bg5HhVx?=
 =?us-ascii?Q?UDK8Zhle3/AOG65KrGdm6WwT+B59FNASY5/xzN+nu9E4kIAMZH4vHp+fJdnn?=
 =?us-ascii?Q?6bmfKJwh7g4cNvVW83QxSka52cnzgdc8JWGyFiXZVDSRv6q0F+bE8MiWU7Jy?=
 =?us-ascii?Q?V3KBQT3G7wRTpGsGJ/Ma1edR8Oz8ebgfzKK3I9zUxHedCCMxx2lX+X0IzFYR?=
 =?us-ascii?Q?j2QxJdOaXorGGOs4jG5vp0K7kXuNptYCqCbZXRIGo11fxWp6/JigSTgIWeHr?=
 =?us-ascii?Q?VETGRPkpeVRJ5M4wzhFnpEznG5xpBgtFxFIA8dWHiQ3cpt5uHOiMN/nO/gX0?=
 =?us-ascii?Q?6Br2nYn/VpjYo7bPGhV6Z08vvdieSk5m42Px2CExVBF2shChVrTtjdxvxDUi?=
 =?us-ascii?Q?u76qJf/PH/hlberVqZuN3hQ=3D?=
X-OriginatorOrg: oppo.com
X-MS-Exchange-CrossTenant-Network-Message-Id: a4daefe5-1fe0-4ce2-06bb-08d9a32c537a
X-MS-Exchange-CrossTenant-AuthSource: SG2PR02MB4108.apcprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 Nov 2021 02:55:02.5489 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: f1905eb1-c353-41c5-9516-62b4a54b5ee6
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: H6xK90Ev5x5x+6ltvMRsYVYKPBy6A9WDZkeCTPBPosV9nfLtj3avNJ+b5Ln5lUQJf7yFpcP8MZW/exuUq9dIpQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SG2PR02MB2699
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
Cc: zhangshiming@oppo.com, linux-kernel@vger.kernel.org, yh@oppo.com,
 guanyuwei@oppo.com, guoweichao@oppo.com
Errors-To: linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org
Sender: "Linux-erofs"
 <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>

Although readpage is a synchronous path, there will be no additional
kworker scheduling overhead in non-atomic contexts. So we can add a
sysfs node to allow disable sync decompression.

Signed-off-by: Huang Jianan <huangjianan@oppo.com>
---
 fs/erofs/internal.h | 2 +-
 fs/erofs/super.c    | 2 +-
 fs/erofs/sysfs.c    | 6 ++++++
 fs/erofs/zdata.c    | 9 ++++-----
 4 files changed, 12 insertions(+), 7 deletions(-)

diff --git a/fs/erofs/internal.h b/fs/erofs/internal.h
index d0cd712dc222..1ab96878009d 100644
--- a/fs/erofs/internal.h
+++ b/fs/erofs/internal.h
@@ -60,7 +60,7 @@ struct erofs_mount_opts {
 #ifdef CONFIG_EROFS_FS_ZIP
 	/* current strategy of how to use managed cache */
 	unsigned char cache_strategy;
-	/* strategy of sync decompression (false - auto, true - force on) */
+	/* strategy of sync decompression (false - disable, true - force on) */
 	bool readahead_sync_decompress;
 
 	/* threshold for decompression synchronously */
diff --git a/fs/erofs/super.c b/fs/erofs/super.c
index abc1da5d1719..26585d865503 100644
--- a/fs/erofs/super.c
+++ b/fs/erofs/super.c
@@ -423,7 +423,7 @@ static void erofs_default_options(struct erofs_fs_context *ctx)
 #ifdef CONFIG_EROFS_FS_ZIP
 	ctx->opt.cache_strategy = EROFS_ZIP_CACHE_READAROUND;
 	ctx->opt.max_sync_decompress_pages = 3;
-	ctx->opt.readahead_sync_decompress = false;
+	ctx->opt.readahead_sync_decompress = true;
 #endif
 #ifdef CONFIG_EROFS_FS_XATTR
 	set_opt(&ctx->opt, XATTR_USER);
diff --git a/fs/erofs/sysfs.c b/fs/erofs/sysfs.c
index c7685f1a8f34..fe67ed490735 100644
--- a/fs/erofs/sysfs.c
+++ b/fs/erofs/sysfs.c
@@ -16,6 +16,7 @@ enum {
 
 enum {
 	struct_erofs_sb_info,
+	struct_erofs_mount_opts,
 };
 
 struct erofs_attr {
@@ -55,7 +56,10 @@ static struct erofs_attr erofs_attr_##_name = {			\
 
 #define ATTR_LIST(name) (&erofs_attr_##name.attr)
 
+EROFS_RW_ATTR_BOOL(readahead_sync_decompress, erofs_mount_opts);
+
 static struct attribute *erofs_attrs[] = {
+	ATTR_LIST(readahead_sync_decompress),
 	NULL,
 };
 ATTRIBUTE_GROUPS(erofs);
@@ -82,6 +86,8 @@ static unsigned char *__struct_ptr(struct erofs_sb_info *sbi,
 {
 	if (struct_type == struct_erofs_sb_info)
 		return (unsigned char *)sbi + offset;
+	if (struct_type == struct_erofs_mount_opts)
+		return (unsigned char *)&sbi->opt + offset;
 	return NULL;
 }
 
diff --git a/fs/erofs/zdata.c b/fs/erofs/zdata.c
index bcb1b91b234f..ad11333b367a 100644
--- a/fs/erofs/zdata.c
+++ b/fs/erofs/zdata.c
@@ -776,8 +776,6 @@ static void z_erofs_decompressqueue_work(struct work_struct *work);
 static void z_erofs_decompress_kickoff(struct z_erofs_decompressqueue *io,
 				       bool sync, int bios)
 {
-	struct erofs_sb_info *const sbi = EROFS_SB(io->sb);
-
 	/* wake up the caller thread for sync decompression */
 	if (sync) {
 		unsigned long flags;
@@ -791,10 +789,9 @@ static void z_erofs_decompress_kickoff(struct z_erofs_decompressqueue *io,
 
 	if (atomic_add_return(bios, &io->pending_bios))
 		return;
-	/* Use workqueue and sync decompression for atomic contexts only */
+	/* Use workqueue decompression for atomic contexts only */
 	if (in_atomic() || irqs_disabled()) {
 		queue_work(z_erofs_workqueue, &io->u.work);
-		sbi->opt.readahead_sync_decompress = true;
 		return;
 	}
 	z_erofs_decompressqueue_work(&io->u.work);
@@ -1454,6 +1451,7 @@ static void z_erofs_pcluster_readmore(struct z_erofs_decompress_frontend *f,
 static int z_erofs_readpage(struct file *file, struct page *page)
 {
 	struct inode *const inode = page->mapping->host;
+	struct erofs_sb_info *const sbi = EROFS_I_SB(inode);
 	struct z_erofs_decompress_frontend f = DECOMPRESS_FRONTEND_INIT(inode);
 	struct page *pagepool = NULL;
 	int err;
@@ -1469,7 +1467,8 @@ static int z_erofs_readpage(struct file *file, struct page *page)
 	(void)z_erofs_collector_end(&f.clt);
 
 	/* if some compressed cluster ready, need submit them anyway */
-	z_erofs_runqueue(inode->i_sb, &f, &pagepool, true);
+	z_erofs_runqueue(inode->i_sb, &f, &pagepool,
+			 sbi->opt.readahead_sync_decompress);
 
 	if (err)
 		erofs_err(inode->i_sb, "failed to read, err [%d]", err);
-- 
2.25.1

