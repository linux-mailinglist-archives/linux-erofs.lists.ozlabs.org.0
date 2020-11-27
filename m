Return-Path: <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>
X-Original-To: lists+linux-erofs@lfdr.de
Delivered-To: lists+linux-erofs@lfdr.de
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2401:3900:2:1::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 975832C638F
	for <lists+linux-erofs@lfdr.de>; Fri, 27 Nov 2020 12:07:00 +0100 (CET)
Received: from bilbo.ozlabs.org (lists.ozlabs.org [IPv6:2401:3900:2:1::3])
	by lists.ozlabs.org (Postfix) with ESMTP id 4CjBf81V0BzDrdn
	for <lists+linux-erofs@lfdr.de>; Fri, 27 Nov 2020 22:06:56 +1100 (AEDT)
X-Original-To: linux-erofs@lists.ozlabs.org
Delivered-To: linux-erofs@lists.ozlabs.org
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized)
 smtp.mailfrom=oppo.com (client-ip=40.107.132.80;
 helo=apc01-pu1-obe.outbound.protection.outlook.com;
 envelope-from=huangjianan@oppo.com; receiver=<UNKNOWN>)
Authentication-Results: lists.ozlabs.org;
 dmarc=pass (p=none dis=none) header.from=oppo.com
Authentication-Results: lists.ozlabs.org; dkim=pass (1024-bit key;
 unprotected) header.d=oppoglobal.onmicrosoft.com
 header.i=@oppoglobal.onmicrosoft.com header.a=rsa-sha256
 header.s=selector1-oppoglobal-onmicrosoft-com header.b=S61hBIlp; 
 dkim-atps=neutral
Received: from APC01-PU1-obe.outbound.protection.outlook.com
 (mail-eopbgr1320080.outbound.protection.outlook.com [40.107.132.80])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 4CjBdz03ygzDrdJ
 for <linux-erofs@lists.ozlabs.org>; Fri, 27 Nov 2020 22:06:45 +1100 (AEDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=QJWILWBHJU1EGcFZW8TwqOYxiLJB/c3yf0w/mthQUOv6Fz7AKiuk0LS1UMW8a598pxcId49BzvKw0aTAOHvWw62qme9b9oRVVK928S7fv0kHSu/o5K0CpJ5HSMzogR0u8ma0F8o825evd9kSJBEsPsUoqzUKBg34KSizQ787WLYtFxQhez/pWueKKai2ZgGsCyAVevwRFNqQMDrq3cAaIazoE2NpcDJ+cpilsTVNb9FEGBuIpgNNQkFOZetVWh5ZvSpAHXH6m550MbvlDJRN7pnDFUR+0yyMoQYbSdABMnlRaZHVD/D0ofh5+NZ/sqRhUReD52pMMsBV+r9h/C93zQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=8JkRg2H/qNPBD7TqkZupMAZTfd8Rx+OsX0XOCl/hiVs=;
 b=A3gbszeh4VYFlLiYGJo8KQDNvPo3E9rwbOw1I4L3mmKNpuIrETyGaMogJMyXTnv5Qt4sbNn5yZnwWJI6FJ8CyYjF6BDQi5rMb0UUTRIewRPKTsjPIM3AtHyyR0KO0hKiFtYn/uSDpLwD0a0/3EPNrgRyZ/VUMWjPjw76zUDlB04eezaONlOllAOVm6ORKZxpyPzrXbh29kBZPDN04oy3hfE5g6sNtmzlM3OWOjFVTPwF80meL039RgBNbWjzu5euotmZFBJjtKFZklE+4B8FvZP5adP0uQnyVl4BGvGZ5exXWSyA6eeVsHSYuQYHc7huJMXlGpnxfIss6nxEIrSNrw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oppo.com; dmarc=pass action=none header.from=oppo.com;
 dkim=pass header.d=oppo.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oppoglobal.onmicrosoft.com; s=selector1-oppoglobal-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=8JkRg2H/qNPBD7TqkZupMAZTfd8Rx+OsX0XOCl/hiVs=;
 b=S61hBIlpgxW+0fPxXOKvsjiOyidGN4nl052Gc91p6cq1WkrOkGa0LhGg/iqlPNk/FsKowEjHGjA224lVgsnQCmM/CELo1xCdAkux6yv0YYXh+ixPixTRlNkRoDtc29fivjYEP34CHqq2JM+vI6G9YmOPsiEf+g7oEnqBkzZ0hqk=
Authentication-Results: lists.ozlabs.org; dkim=none (message not signed)
 header.d=none;lists.ozlabs.org; dmarc=none action=none header.from=oppo.com;
Received: from SG2PR02MB4108.apcprd02.prod.outlook.com (2603:1096:4:96::19) by
 SG2PR0201MB2093.apcprd02.prod.outlook.com (2603:1096:3:b::9) with
 Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.3611.21; Fri, 27 Nov 2020 11:06:35 +0000
Received: from SG2PR02MB4108.apcprd02.prod.outlook.com
 ([fe80::34fa:80a2:c5d5:8efd]) by SG2PR02MB4108.apcprd02.prod.outlook.com
 ([fe80::34fa:80a2:c5d5:8efd%6]) with mapi id 15.20.3589.025; Fri, 27 Nov 2020
 11:06:35 +0000
From: Huang Jianan <huangjianan@oppo.com>
To: linux-erofs@lists.ozlabs.org
Subject: [PATCH v2 1/1] erofs-utils: fix use after free in closedir
Date: Fri, 27 Nov 2020 19:06:16 +0800
Message-Id: <20201127110616.34232-1-huangjianan@oppo.com>
X-Mailer: git-send-email 2.25.1
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [58.252.5.72]
X-ClientProxiedBy: HK2PR06CA0005.apcprd06.prod.outlook.com
 (2603:1096:202:2e::17) To SG2PR02MB4108.apcprd02.prod.outlook.com
 (2603:1096:4:96::19)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from localhost.localdomain (58.252.5.72) by
 HK2PR06CA0005.apcprd06.prod.outlook.com (2603:1096:202:2e::17) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.3611.20 via Frontend Transport; Fri, 27 Nov 2020 11:06:34 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 18128a14-92ea-493d-8024-08d892c48147
X-MS-TrafficTypeDiagnostic: SG2PR0201MB2093:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <SG2PR0201MB2093366E7441F88C97BB05E5C3F80@SG2PR0201MB2093.apcprd02.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:363;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: onTfQNOQvHPhXwHVFztO3Unqjls01N7hnuSPqnsvDbYju/D6LMojpPYOeKtqlVoo/8ATrcOWIouYkisToVtLby86VesekRmR2IMZqj2ULWMTMNwdW1BGTTKljnHbekVNSaPsT3sZgJlxl5kgLFdF/4LKBXjZcIb+GIu127muB//X2Gv/wGnJLKG8PM7T5CVy+fWB7XCLVq8zkwLF5T1IjpUa274E6ZB7/I2zTpWVl6Di12CrM00lUkY4AiHb1i2aDVBuIc68qu8ssJUmjgygryA5OIvaERiYUHDTmNXqcy4Oi95shGXWN/UwDx98tvx+pW1EBmD6b0NAKf/TN2+UjnbQkn1/pxzw+Ff+nrH7F9Evh2T3+VYFW2VpZPFKXm4XVwMxwSuROAin+CrP0jEFZ5tvwsMnmXcSjjJxraPzuok=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:SG2PR02MB4108.apcprd02.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(4636009)(376002)(39860400002)(366004)(136003)(346002)(396003)(66556008)(66476007)(6666004)(66946007)(316002)(6486002)(16526019)(186003)(69590400008)(36756003)(26005)(478600001)(6512007)(2616005)(86362001)(52116002)(8936002)(4744005)(2906002)(956004)(83380400001)(107886003)(6916009)(1076003)(4326008)(6506007)(5660300002)(8676002)(11606006);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData: =?us-ascii?Q?DMQLSFGa0OeLZEHJJL/9ZggLK3/ck9UdnnQhRHMQHTOMtJdBxBFRbLXjePth?=
 =?us-ascii?Q?GOPaM3ODwV57RH4K3B1VBrbzU/6xO++uylXLf5alt82AcGYNahLdnaDbYYt8?=
 =?us-ascii?Q?vqxYN73VTiuhYuenzYd0A6wVAk37hge4RS07Glb0xvMTbk6NbCjPg2R9yMGt?=
 =?us-ascii?Q?GDOHMAyWxWCGXY5Jc5TJFQ6DJWmJn80InDDeWA4C+IWXMN0ktC/S88BwynKx?=
 =?us-ascii?Q?dPPpQcDMfwDxAU3whg3QHoC/ps4B09bZyAOa0TadTvClNyxcYA/kEMNqtnKa?=
 =?us-ascii?Q?+Phea3gPRmho+k63ScPn9pALnj+5uBbfFxBtnBaz1KIwGCqXLugLG0sOh439?=
 =?us-ascii?Q?n4EHNB/aXtk1rkJuLNH08IZnhHEPIYpAdz5f+ViPENOTZySuuQp1+vX5bJpl?=
 =?us-ascii?Q?0uRSSsSsF2fEhxvZ2IRhSItCkctYHqiVn1JvB6Q9rSYneiHD7VSarOsWhvsG?=
 =?us-ascii?Q?51vlyoyCFB3AsHbGj2yvvYM93q3yIb4kAK4dBJHUonXyKR88ietejKy3XIa3?=
 =?us-ascii?Q?lKSIxBrus/cq0ODgUtzo7t/9W7ZDRZ46yj9scMlMxo9w0l2cZ6eqtBS/mPhp?=
 =?us-ascii?Q?FcBCVUjpeSYztBQNAALeraUPi+LzRxEgIvVfM3VfLc2CyYt7MZlYj/8PUYNp?=
 =?us-ascii?Q?OzAlICGNbIZ4EFXpYf9D456QlmRH1Z0EU31o6RExDqNf3+Rhs7Tg4wnH08cI?=
 =?us-ascii?Q?t5LbeAoQeeVu2HGCbNcWnK1k46mVv8Ki1Pg3ygBhP+SdP3nUrVM8L3nmlZAj?=
 =?us-ascii?Q?3hYrVRDZkQaSLtt8y8EXSNGDv9QD2wa00VntfoVFDS8Ze59z4eVaRjLT41H9?=
 =?us-ascii?Q?w7UaJy5RnFMBr8aW74NbjkBKYBk7hAJR8506hjSy1nf7x7qaObdEU2WZYZj6?=
 =?us-ascii?Q?cQWEIe4RW5wG/Fdwjbfzpny+8j8y+p2XUkibybruuXHLwuJfoWj3wNNbVmqC?=
 =?us-ascii?Q?DMdsXWn1UH4EUO8vdsXgSJtdSMewD4z53oLoraINjoA=3D?=
X-OriginatorOrg: oppo.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 18128a14-92ea-493d-8024-08d892c48147
X-MS-Exchange-CrossTenant-AuthSource: SG2PR02MB4108.apcprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 27 Nov 2020 11:06:35.6595 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: f1905eb1-c353-41c5-9516-62b4a54b5ee6
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: RZB/8hrCKqIYU3aU02ddZyEb69agmhL3PWy/8RN/A2HMy4DP0o6Sc1ok1nilPJKQ7+XLPxuE44OMBUh8TCW9yQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SG2PR0201MB2093
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
Cc: liufeibao@oppo.com, guoweichao@oppo.com, zhangshiming@oppo.com
Errors-To: linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org
Sender: "Linux-erofs"
 <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>

No need to closedir _dir again since it has been released.

Signed-off-by: Huang Jianan <huangjianan@oppo.com>
Signed-off-by: Guo Weichao <guoweichao@oppo.com>
---
 lib/inode.c | 7 ++++---
 1 file changed, 4 insertions(+), 3 deletions(-)

diff --git a/lib/inode.c b/lib/inode.c
index eb2e0f2..388d21d 100644
--- a/lib/inode.c
+++ b/lib/inode.c
@@ -958,11 +958,11 @@ struct erofs_inode *erofs_mkfs_build_tree(struct erofs_inode *dir)
 
 	ret = erofs_prepare_dir_file(dir);
 	if (ret)
-		goto err_closedir;
+		goto err;
 
 	ret = erofs_prepare_inode_buffer(dir);
 	if (ret)
-		goto err_closedir;
+		goto err;
 
 	if (IS_ROOT(dir))
 		erofs_fixup_meta_blkaddr(dir);
@@ -988,7 +988,7 @@ struct erofs_inode *erofs_mkfs_build_tree(struct erofs_inode *dir)
 fail:
 			d->inode = NULL;
 			d->type = EROFS_FT_UNKNOWN;
-			goto err_closedir;
+			goto err;
 		}
 
 		d->type = erofs_type_by_mode[d->inode->i_mode >> S_SHIFT];
@@ -1003,6 +1003,7 @@ fail:
 
 err_closedir:
 	closedir(_dir);
+err:
 	return ERR_PTR(ret);
 }
 
-- 
2.25.1

