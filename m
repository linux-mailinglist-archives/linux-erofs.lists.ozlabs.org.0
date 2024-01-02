Return-Path: <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>
X-Original-To: lists+linux-erofs@lfdr.de
Delivered-To: lists+linux-erofs@lfdr.de
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2404:9400:2:0:216:3eff:fee1:b9f1])
	by mail.lfdr.de (Postfix) with ESMTPS id 0C695821E19
	for <lists+linux-erofs@lfdr.de>; Tue,  2 Jan 2024 15:52:23 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=lists.ozlabs.org;
	s=201707; t=1704207140;
	bh=+U9o+9gU4YQpeFON8sUCVnd4uyAztJ7gOaKbzVycvyM=;
	h=To:Subject:Date:List-Id:List-Unsubscribe:List-Archive:List-Post:
	 List-Help:List-Subscribe:From:Reply-To:Cc:From;
	b=f882Tc4j+s5FuJqoIO5hGl0HqbzugG29XDzIH7z576aLCyuvosQbQVsUTmyV7tTpD
	 dK1x1XTBtRChKaVK9q7165Z3ihx1iTSKzmZx9QBh6qC2HSmgg72XoECDWXOh9uYyOi
	 I/f9dlu2IGO1woDVSEpbhblF30RpIfQvkO4SvaZtFbWGFEBJluWl/jhgJ2YWIrZBRD
	 NgZTUET/yW4GiN1vZHVj/Eup0aeH1CfU2L77wzu6cpfqrzEL9ev79trQuknCNbSyuI
	 2WqkJnAxVf14VL4/mg6lArYDL0caIawmZ4s7QIryXuny4KMzvewPFptMm7uKbeVspW
	 xwFEIxEd4+Pug==
Received: from boromir.ozlabs.org (localhost [IPv6:::1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4T4G6D5B9Pz3bnk
	for <lists+linux-erofs@lfdr.de>; Wed,  3 Jan 2024 01:52:20 +1100 (AEDT)
X-Original-To: linux-erofs@lists.ozlabs.org
Delivered-To: linux-erofs@lists.ozlabs.org
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=vivo.com header.i=@vivo.com header.a=rsa-sha256 header.s=selector2 header.b=mc4VMsd8;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=vivo.com (client-ip=2a01:111:f403:2011::700; helo=apc01-tyz-obe.outbound.protection.outlook.com; envelope-from=guochunhai@vivo.com; receiver=lists.ozlabs.org)
Received: from APC01-TYZ-obe.outbound.protection.outlook.com (mail-tyzapc01on20700.outbound.protection.outlook.com [IPv6:2a01:111:f403:2011::700])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4T4G684TXcz2xYY
	for <linux-erofs@lists.ozlabs.org>; Wed,  3 Jan 2024 01:52:15 +1100 (AEDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=MDj/4eh5PxP4SgsQWgg4KvIwuYo6ZbKyc980GE0Uku/82kkypo1Km3m1Chx0kf1vpEFmuFDjc4Zpaw/JtfyqTqGgZ7E/sC+5449YPXnxOHhdQhlARx2yfkjI0bXJIDmdd9S6+O+jjS9IN3SETVaesVfFyRnMpfyhJuviFm4BdJCuMFIxsTRUFOB/gkDAfbqx0ULDLhz2Ey+HxFEbo/T+hq/4QvN2Yy4IfGVyaOejvKQtt6Su/8IdNtMyDmfJX4ffOz4Ayt7uuH8RQ/mUaAy3YyP9Q70zFzVuVv8mOkmZDc02pzfB2TwbqLyk2Z0J6cT8mOj0w2Fd7X0bvkPOIXj9/g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=+U9o+9gU4YQpeFON8sUCVnd4uyAztJ7gOaKbzVycvyM=;
 b=oZFE4KOMUqCHjZn5ABiuroN4nrhqbSedq5pd6n26GrSzEIrXGIYThk55wpWDHH5PYFxZ8idQyDSNptzpUczKZ6ROe3YIsFIuG/VlirXAR3Wv7aqXAGHsACLtkK5hxdA90Smc5OuzCYktv7L6HOzFSxYJ6p+O1pq9DxoVezDKkft9fxkKvSN2CBDaHsNaQme1BZ7pZRK7fZyhU3SeTGsdIh92PTGnaHkszfTKh5k3fSKml6mJd2nLt1c/UNZPKoCWSNzSjiiREBHDn/JOQ3w/O6eqAN7JOC0diLh8u9M2jEGP8IesNZ4IFJq/JW1+DbPgwmgvgCWseGwBFekKrx+XFQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=vivo.com; dmarc=pass action=none header.from=vivo.com;
 dkim=pass header.d=vivo.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=vivo.com;
Received: from TY2PR06MB3342.apcprd06.prod.outlook.com (2603:1096:404:fb::23)
 by TYZPR06MB7281.apcprd06.prod.outlook.com (2603:1096:405:a8::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7159.13; Tue, 2 Jan
 2024 14:51:56 +0000
Received: from TY2PR06MB3342.apcprd06.prod.outlook.com
 ([fe80::b403:721d:ec13:d457]) by TY2PR06MB3342.apcprd06.prod.outlook.com
 ([fe80::b403:721d:ec13:d457%5]) with mapi id 15.20.7135.023; Tue, 2 Jan 2024
 14:51:55 +0000
To: xiang@kernel.org
Subject: [PATCH v2] erofs: make erofs_err() and erofs_info() support NULL sb parameter
Date: Tue,  2 Jan 2024 08:01:58 -0700
Message-Id: <20240102150158.2886981-1-guochunhai@vivo.com>
X-Mailer: git-send-email 2.25.1
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SI2P153CA0019.APCP153.PROD.OUTLOOK.COM
 (2603:1096:4:190::10) To TY2PR06MB3342.apcprd06.prod.outlook.com
 (2603:1096:404:fb::23)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: TY2PR06MB3342:EE_|TYZPR06MB7281:EE_
X-MS-Office365-Filtering-Correlation-Id: ba20318b-699f-43ea-7304-08dc0ba25d3a
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 	r26W7Iv6a4Sn9w7zRNtsaUZ1KGLNo6Ifsmu8EXYm6m1VkW34lGTn37KXDg3H7h+iC4helBbRAN9kVMuO7ot+EPlUITmMmCo0sO/69D9drykIZ6xmc4dmSrWZt08VGyhU0h8aGt+9VOo8o6/+Cx+VpC/oGU6iz8x6gq93G8np7RhOv95sxAP7AK5Uum8LGRmGj4tsaSqsAZcI6lZhCHMcSUk1QPe5R+WI+Rxuj3cGZHHKQ0c9x4B0+8bDq2wmyviFuv3FvlVj/t3XKS3j21tAAvHqvbU866gGFyBgfkQFJJFxsgu0aRmQjc3lVpJeGuaEbpuvUzKiB1HFI/uO9rkyTLEJKQl/xpXOC9cLZVgqX+LpfTh6kC/m34Wd/BZ9fB6DSea2b4TU5z8wZTUxxz6RpvWEraqDPgdhTnyItT0XfH7VAciXw5KQgx1uE+vTkWARrMWoFEqBV7FRcNNcSgX4W/wsmTcxNJuel9oWHUnwdN3XWoAqELf1wofcnVs0kiv2ZuzitkY6Uwgyw7f7rP+1vPLxuwSIdY6hdGJTdxmzXICjnBSO+lxolb356CQvT7Y/iU33e1DF+tqrborpqVcj/pf8bVwDsA0+yCjTzrcwqLxomGA3hFdSmAw6/ba5Hfrr
X-Forefront-Antispam-Report: 	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:TY2PR06MB3342.apcprd06.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(376002)(366004)(346002)(136003)(39850400004)(396003)(230922051799003)(186009)(451199024)(1800799012)(64100799003)(36756003)(52116002)(6512007)(6506007)(6916009)(66946007)(66556008)(66476007)(6486002)(38350700005)(86362001)(38100700002)(26005)(107886003)(2616005)(83380400001)(1076003)(41300700001)(5660300002)(2906002)(4744005)(4326008)(478600001)(316002)(8676002)(8936002);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 	=?us-ascii?Q?rn6gEj1uqFiNLb3Beg5zCvvtw5cgHPxgxMNWjCqy2Ocga3nqrBKtEWhLa2CH?=
 =?us-ascii?Q?Zs2jsvnW0JsZG4FZbKI2OJU0/5B6rt8/P48EwstYP0YXDVFsqgr+4e6KRpnG?=
 =?us-ascii?Q?WwTKM+fy1Gkauf0Pv1PZ5SL/p/uZwU0d9GM5r41RO3wQOibckmIEcTDjRKDV?=
 =?us-ascii?Q?wly36NEAsDLZNutFasooprhvJvE3WFn6W9KcNBDupxUpnC2flDMDwkxlbcpz?=
 =?us-ascii?Q?IvWYiyjC71NLdEH5UTs64w/F8IsAQbtaKS65VpSwfCdH1Wqpf9VOv3xgYqnD?=
 =?us-ascii?Q?Ilse9u5rcsfhiCbuwl32RTzyxwaye8FLi0n/kJZgwW//Fp2Tejk2gavA5pVg?=
 =?us-ascii?Q?8L4Za83fcYNd/cpptGrcXH0tj7zAzfndHvY2/Tcsl81ZFesKUiaFibbD3EBF?=
 =?us-ascii?Q?MfsykggnBjeot0IrpHrpGRyX38b4v0WOzjYCGJgPP+xr3X9CRCFMTmYdL4Qf?=
 =?us-ascii?Q?tYeJP0rMm9JIT21CX/rgzN6km3WOxiFfCneb9G+hLAx7KqXYADJBQ+EbpiR/?=
 =?us-ascii?Q?N4GyLSdwesWWyf7Np9WZ446HjorNaOCJyvISkd94tH6RJiwcHBa5JjWAXbAo?=
 =?us-ascii?Q?/yJwx9lMuruuib0/+yIlBduvB0RsSOBByZNYgT7Qdud/JSTtPYGk2eOkhF3L?=
 =?us-ascii?Q?A+B9muPUzRuIVc6UtKR/+w4JDGODu9+9g0PS+WbQN5zOOp9B/NFLO3DM42g9?=
 =?us-ascii?Q?Lbmzm5mNNHKo0RT6MKFjjCwz+/LTvvks9PRweKbbcJQ3nsy+XhKceHjAADjC?=
 =?us-ascii?Q?55cu5/P4mtDyH5sc9zlGar0wWBB2CMChz0l0XhYKASZm11yvlKNqoyaxIhHx?=
 =?us-ascii?Q?03Kw2JkQ0/jHRx1Sf5+LNlDAOSd0GWeBIHU2RT4zQlk3uLUzo1D5wzgB/SbA?=
 =?us-ascii?Q?Ve9a5aPUBCukgIYJNxuhjPtH2LeYdvzohn7rTLmrlY9H03cn3uQqsKh9sxlX?=
 =?us-ascii?Q?1tCVI2MFfNbkfsbvLPGzPG+Jrd8fxh/9te7xhhimQV7+X1yz21TpzBhlEP2F?=
 =?us-ascii?Q?LRAga+lYfQmoz3lSVA1S+otZX/1CiVrW9573aIWCo7bNUBy1Xy3xJB2SyUhX?=
 =?us-ascii?Q?BxMtV62LrQErNSi4qcN0LpkBXHi8Qzgn/zEkne70FzlyUy+BqmvkBOF5hse4?=
 =?us-ascii?Q?KNIDQuFKzj9sCsxgm753E5DoLg2wwe8nfszngcclJ8ZHSbV+JP+n9AFOgviv?=
 =?us-ascii?Q?Yiz3RlrlSzz6Xgi56AJ+5RJ68FcIEn9DA7mDyov8QLA7KnhjuF9UT2nJ4ty6?=
 =?us-ascii?Q?z91FZKWHxAWQ0IR5QDw7yoGSPI6Dr1xvRXqNABspm0Cly1I33A4oGCt7ynDw?=
 =?us-ascii?Q?KUAeh1zlWCPZGeiIjOmfeTE8Ovpvmnr4Z1Pj2aUFx/ZhtnqEa2tHe4EvtszA?=
 =?us-ascii?Q?cA3wy78VTOU2sRIVVDSNIGOUz5V0e4T1DjFvzHa2UI5HZFoeC5ZWj9HWRLz1?=
 =?us-ascii?Q?D4AhnuDzJRBr2OJJUiZ2nIATIVIXyJJGIiVliag6CwptoRsUrnfXPf4JPny6?=
 =?us-ascii?Q?na/v0K+SL8dhUcYw2KR+biLntXkByD8Q6G2r2a5obcdrtk8SCOd3mCnfjxjg?=
 =?us-ascii?Q?J2k2d74QXzDbNfBxT60WXqHzsrL6NyOAKn7FK+w5?=
X-OriginatorOrg: vivo.com
X-MS-Exchange-CrossTenant-Network-Message-Id: ba20318b-699f-43ea-7304-08dc0ba25d3a
X-MS-Exchange-CrossTenant-AuthSource: TY2PR06MB3342.apcprd06.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 02 Jan 2024 14:51:55.9085
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 923e42dc-48d5-4cbe-b582-1a797a6412ed
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: OK88sMG+kl0Eodp37CRNwBPVwfOObYNQbMZKl2B34JcqBZ7pSLQDYbdR3kMmnv7fv/qsZGETV8U5S0r+YILXYw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TYZPR06MB7281
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

Make erofs_err() and erofs_info() support NULL sb parameter for more
general usage.

Suggested-by: Gao Xiang <xiang@kernel.org>
Signed-off-by: Chunhai Guo <guochunhai@vivo.com>
---
 fs/erofs/super.c | 10 ++++++++--
 1 file changed, 8 insertions(+), 2 deletions(-)

diff --git a/fs/erofs/super.c b/fs/erofs/super.c
index 3789d6224513..5f60f163bd56 100644
--- a/fs/erofs/super.c
+++ b/fs/erofs/super.c
@@ -27,7 +27,10 @@ void _erofs_err(struct super_block *sb, const char *func, const char *fmt, ...)
 	vaf.fmt = fmt;
 	vaf.va = &args;
 
-	pr_err("(device %s): %s: %pV", sb->s_id, func, &vaf);
+	if (sb)
+		pr_err("(device %s): %s: %pV", sb->s_id, func, &vaf);
+	else
+		pr_err("%s: %pV", func, &vaf);
 	va_end(args);
 }
 
@@ -41,7 +44,10 @@ void _erofs_info(struct super_block *sb, const char *func, const char *fmt, ...)
 	vaf.fmt = fmt;
 	vaf.va = &args;
 
-	pr_info("(device %s): %pV", sb->s_id, &vaf);
+	if (sb)
+		pr_info("(device %s): %pV", sb->s_id, &vaf);
+	else
+		pr_info("%pV", &vaf);
 	va_end(args);
 }
 
-- 
2.25.1

