Return-Path: <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>
X-Original-To: lists+linux-erofs@lfdr.de
Delivered-To: lists+linux-erofs@lfdr.de
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2404:9400:2:0:216:3eff:fee1:b9f1])
	by mail.lfdr.de (Postfix) with ESMTPS id 81CB9435D5A
	for <lists+linux-erofs@lfdr.de>; Thu, 21 Oct 2021 10:52:01 +0200 (CEST)
Received: from boromir.ozlabs.org (localhost [IPv6:::1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4HZh730LLMz303H
	for <lists+linux-erofs@lfdr.de>; Thu, 21 Oct 2021 19:51:59 +1100 (AEDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=lists.ozlabs.org;
	s=201707; t=1634806319;
	bh=kn1rgwlCNbU5ujHDkBLiWdq+3S3xElpCHTiHWGkPWGo=;
	h=To:Subject:Date:In-Reply-To:References:List-Id:List-Unsubscribe:
	 List-Archive:List-Post:List-Help:List-Subscribe:From:Reply-To:Cc:
	 From;
	b=Y0um51we7nzXFNcXwRw73OLQPE1iUI4GHXKEhpB3pVt9FgkRW7FzIP2Wwm8bskZPR
	 Nzc9pSoFoEXWu2O9UwrY7Z8JJ2AkQvGq+cnywE4PX46v9M/+aB2aC0MD7QzBDD4TFH
	 g7vpARnbh1wZV4xXc4x9uZbwCgrrAgns+dgMSvuX4cxT/y28/ktBdHHLS2f9Jz7+t+
	 CF9SM1HQD05wgXrrvKWyqauFao6x217enqtMquOBA0xCSyeNdu3huBLwPVsaea8VNJ
	 p8/S+X5IafiMWZXZ1tSZh5Y9BEbVFUGSGHVa9anBL/TEtPWbjbg7XonF2j7hA2PZTr
	 +AN4gMAkniZAA==
X-Original-To: linux-erofs@lists.ozlabs.org
Delivered-To: linux-erofs@lists.ozlabs.org
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized)
 smtp.mailfrom=oppo.com (client-ip=40.107.130.53;
 helo=apc01-hk2-obe.outbound.protection.outlook.com;
 envelope-from=huangjianan@oppo.com; receiver=<UNKNOWN>)
Authentication-Results: lists.ozlabs.org; dkim=pass (1024-bit key;
 unprotected) header.d=oppo.com header.i=@oppo.com header.a=rsa-sha256
 header.s=selector1 header.b=VParwXd+; 
 dkim-atps=neutral
Received: from APC01-HK2-obe.outbound.protection.outlook.com
 (mail-eopbgr1300053.outbound.protection.outlook.com [40.107.130.53])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 4HZh6t2Vw3z2yn1
 for <linux-erofs@lists.ozlabs.org>; Thu, 21 Oct 2021 19:51:48 +1100 (AEDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=H8VVGA7Yyj6lYZ2zBZJXRKXEB85cLhf+EfxAay8IgWewrbIWxYHlOAkgn3uhXXnNcnipwyML8nbUU6LxTaaFMk5Tpnuqilf4a5MvGbvWPx+rAoVgHfl9PZNH0/BKN7wv+ggFwb1KP6iD0v7I5hlWrL1Ry+ioUH1cpjZWGxhS0HWorJ2BeKZaR2f4634q0lx2hcYDxFtcDSNGJzIgXRf0hC2KkGBiIBIjLug/vPQkshVlVzR4jTVx+Ez6fUb8RH7GSgg46ReoVqMS79fDTkRkXXYKMDxC0Kbw7i1A1PBaTm9dslGrX/V88NeDZofgMoeRsB1mGj6z6E77Cux7//OGkw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=kn1rgwlCNbU5ujHDkBLiWdq+3S3xElpCHTiHWGkPWGo=;
 b=PyU5t0pONuT536Zmr6gz2INJpak9E+f3FwwgxSw7XJuglp3HD3612wifeVpUF1EOEqMhNEMVf2M2nBVZX5nZl4R/T9yr03mx+/8mmfPi7uVA1vOA+ql3vcBLvgC5OplC9gNLRzArEnyKC3zTuob80r4rG2UZJoAvwP0QWX2YPD7Eh9egVjUnVt8Y9c2Bqu+i9YqR01wCFlINacQ8vPJLVRYlAoZcJFJSu/egqGNP11ktdaKC/W+lUv0CAASB5NO1U0P0kBSI5vbWjse8sLHMGvWHvpJb5wSuFNQCzy6JzdlvjccKd7np+EL2op+uF8Ho6z3ye/pfQjzb+gs5Cisx4Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oppo.com; dmarc=pass action=none header.from=oppo.com;
 dkim=pass header.d=oppo.com; arc=none
Authentication-Results: lists.ozlabs.org; dkim=none (message not signed)
 header.d=none;lists.ozlabs.org; dmarc=none action=none header.from=oppo.com;
Received: from SG2PR02MB4108.apcprd02.prod.outlook.com (2603:1096:4:96::19) by
 SG2PR02MB3942.apcprd02.prod.outlook.com (2603:1096:4:89::12) with
 Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.4608.17; Thu, 21 Oct 2021 08:51:27 +0000
Received: from SG2PR02MB4108.apcprd02.prod.outlook.com
 ([fe80::8062:2651:e9c8:ddc6]) by SG2PR02MB4108.apcprd02.prod.outlook.com
 ([fe80::8062:2651:e9c8:ddc6%6]) with mapi id 15.20.4608.019; Thu, 21 Oct 2021
 08:51:26 +0000
To: linux-erofs@lists.ozlabs.org
Subject: [PATCH v2] erofs-utils: add dump.erofs to .gitignore
Date: Thu, 21 Oct 2021 16:51:19 +0800
Message-Id: <20211021085119.2143-1-huangjianan@oppo.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <YXElDpc9tv8SsR9g@B-P7TQMD6M-0146.local>
References: <YXElDpc9tv8SsR9g@B-P7TQMD6M-0146.local>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: HK0PR03CA0114.apcprd03.prod.outlook.com
 (2603:1096:203:b0::30) To SG2PR02MB4108.apcprd02.prod.outlook.com
 (2603:1096:4:96::19)
MIME-Version: 1.0
Received: from PC80253450.adc.com (58.255.79.105) by
 HK0PR03CA0114.apcprd03.prod.outlook.com (2603:1096:203:b0::30) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.4628.18 via Frontend Transport; Thu, 21 Oct 2021 08:51:25 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 9ac9aee6-268e-4aa0-7f92-08d9946ff763
X-MS-TrafficTypeDiagnostic: SG2PR02MB3942:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <SG2PR02MB3942AF3490BD0A9323E52BCCC3BF9@SG2PR02MB3942.apcprd02.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:541;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: AIlpjJuXsXKku8ZFGgW/wwqTCO3/m1KimsczwhwlXYf1tTBx7+60lc38ldicT1HEUUb1Mhzj2agqAAD8dTXEahmUWDL7r6qioUGolwE1DQyFTs16Xq7+jxlWpattdzCbSg5upWK63QYQfv1ycKQCK+H5M/m7AEGVJYLq3FjV8LD8rYYaGtr3JYuMd2rlNvf4nsNQ3NHSarsPCsssXetQgwu6m2j1hh1Xn6zq/Clu3Wytan1to8miNrWNOjx+lbqVez+9DG+Xb1OmfGeNG1TyIv3GRngjyTSpJ162J3J8xzqQ+mCMKlQRw9C0ViCJeaS8yXQWbc35zTJ6XLaan6swtWuJRWowNzyynUAT+egTtPuQ4Q2cP2s89Ww/BHbrzNNmwuFTSaSj4eN+noy/L4/DGxG4/OIyLJBUqYh/frdmywmNWFOT88WNgDN/CdYeso9Kh4o2mGfKJlI0stnoWdFY1YS5QwA4WLOzWudwur893faPTH3BbcKWxsGbm5pHeOvWN129CiUoUJLjfqsdIRaAtdvrtI7Bspnf0qvkJ3d9maEQqg7hEQGnw+jVRFEmx0uvsDV4/KdjAop97PSriawem0g1PUJxIkHqoNrRXKQKtYNSOhQju5RRYbhDUijWTppA0bGUxE9clTge/6rZnDmf2+aZ4G8KlrLYFFgnend7oYvvTa3LBvMVHRLMor5KXB37bvPzjdrqxaFelMY15WPiLJBDyJxljZ7wfGUs62H2SfNK+xSIOXd5eNqEnJCie1xR
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:SG2PR02MB4108.apcprd02.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(4636009)(366004)(4744005)(6506007)(8936002)(6486002)(316002)(1076003)(52116002)(8676002)(5660300002)(508600001)(186003)(66556008)(66476007)(956004)(4326008)(86362001)(38350700002)(26005)(6916009)(2616005)(6512007)(38100700002)(107886003)(6666004)(36756003)(2906002)(66946007)(11606007)(142923001);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?DL8o/uOzXQkQP/0zX9L+GDbKMfRfDkyY97t5eceDMr/TqCnTDWy4sNpRU9vs?=
 =?us-ascii?Q?LtN8E4KXm0eV/xQ1RTaIb06RP1IakQz6+vXtWq8X2wPRyrFZ0XqsCFt8m39Q?=
 =?us-ascii?Q?a7MICLhbaJGgWr2dcVlGi2l1PftR0OZJIBMmE20FM+BoWvRLRezdyZ1DecQ/?=
 =?us-ascii?Q?uipJj6UVAAbPgHnEVJSV/z+nWkzcX7R9INWeP//7AsgMWyiOK+sQ3mhudm1d?=
 =?us-ascii?Q?lHlS52GfbZFUpvIQB5r3UdgCvTf1UJqM4n6+mEG7CElKJlvhRZ3wHkrIAB+L?=
 =?us-ascii?Q?/8OkZurm4BlyjwlndC+S3VNgUOyK0WvV32oKY9U8DtkHSDjBe1yKQc5bUHAS?=
 =?us-ascii?Q?UOzJJS6wMY3YzDuhTVOOXXw8umuKNP1pV+aF24v2qBWITJCHWn24BYFFmK14?=
 =?us-ascii?Q?stXYDUmztMjCHcwSc2OzLm0hjmzt1AJpss0agYrd+bAo+nQic5gbTB2OYqcb?=
 =?us-ascii?Q?HNB0mXbNMeVJAJ6AZGA8WuIlYPJ7K6eQdr3lIrEdJAuig8e7uwxCESyAWHiZ?=
 =?us-ascii?Q?CWZmaL2GzBTdWqdNZipFiMKuLq/BWW/SpxcfuywNom/P1TUAn5IjET+ycOv8?=
 =?us-ascii?Q?SPovB8jlJOwuAtuXpbenxmkVqU92RdUiRKCpAsoFsfwIAwkJDCjFnHBbEBUZ?=
 =?us-ascii?Q?oVE3d0rcl0v5P/NwHZXgXZSIdFfRS4gelw733rexxkg16kD/TDQUOrfO44aW?=
 =?us-ascii?Q?SeyE3NNuE0WJ0jAWUVWt7gSBws1xf6fLR5xMfsq/HpeWVHA5U4bVGocYlbu3?=
 =?us-ascii?Q?8U9uyja2hjsOTnJyXuKbJcycXhuILaG1GsY9weUm35+D98qZ1i4Ph+/N01DX?=
 =?us-ascii?Q?duJDYRNUERnVWPWV7p//yWRrVUvlzy+L2baR6au6223R31WoxWFmSfzrNc+N?=
 =?us-ascii?Q?Pxf+5Oi7nJDEdDLdf2MHPXeY7Jwn2GNzAxKu4OXxrqMypvQUliGqowlDZfer?=
 =?us-ascii?Q?LoVNVm2veVrxyzcKWH9pYjoE3cN3aQZpGPD05YuuLbdxAMpxVAcxDOM1D0Mz?=
 =?us-ascii?Q?Xzc/vd0a6FdsQ+A6wJjcUcTawWcVW4EORrLUYrlTpEQczdvcqS+5z9CxDDsN?=
 =?us-ascii?Q?Fit4PoGGGQ5RhiAfkXCmbjtpqEeNra6Cl5GxfjPIDoQeXzFKPlk+m6logfye?=
 =?us-ascii?Q?czzQJcyW4NBSACDU/WhkkVep7pWeRSAh3FxXpGqh3XflUWQH6dcjeKJjXka/?=
 =?us-ascii?Q?8RtBl5Rltn5kh7nKUu3baPJ8p2lzQFq0XKU8rO+c/b1ZJBpKzlQwTb46AOo/?=
 =?us-ascii?Q?5b7Nek3mr9kDTYa50Ud95iCL7lxvCxuY/2SISyFa69o7+rMTpe1rO1yDVbWc?=
 =?us-ascii?Q?B3yZHz9jyA3a4E1hl632l/in?=
X-OriginatorOrg: oppo.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 9ac9aee6-268e-4aa0-7f92-08d9946ff763
X-MS-Exchange-CrossTenant-AuthSource: SG2PR02MB4108.apcprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 21 Oct 2021 08:51:26.6157 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: f1905eb1-c353-41c5-9516-62b4a54b5ee6
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: huangjianan@oppo.com
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SG2PR02MB3942
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
Cc: yh@oppo.com, guoweichao@oppo.com, zhangshiming@oppo.com, guanyuwei@oppo.com
Errors-To: linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org
Sender: "Linux-erofs"
 <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>

The compiled product should be added to gitignore.

Signed-off-by: Huang Jianan <huangjianan@oppo.com>
---
 .gitignore | 1 +
 1 file changed, 1 insertion(+)

diff --git a/.gitignore b/.gitignore
index 7bc3f58..27403d4 100644
--- a/.gitignore
+++ b/.gitignore
@@ -29,3 +29,4 @@ stamp-h
 stamp-h1
 /mkfs/mkfs.erofs
 /fuse/erofsfuse
+/dump/dump.erofs
-- 
2.25.1

