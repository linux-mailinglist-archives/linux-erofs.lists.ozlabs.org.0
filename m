Return-Path: <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>
X-Original-To: lists+linux-erofs@lfdr.de
Delivered-To: lists+linux-erofs@lfdr.de
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	by mail.lfdr.de (Postfix) with ESMTPS id 5DB7D6D6521
	for <lists+linux-erofs@lfdr.de>; Tue,  4 Apr 2023 16:21:53 +0200 (CEST)
Received: from boromir.ozlabs.org (localhost [IPv6:::1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4PrVM22zj8z3cZp
	for <lists+linux-erofs@lfdr.de>; Wed,  5 Apr 2023 00:21:50 +1000 (AEST)
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=vivo.com header.i=@vivo.com header.a=rsa-sha256 header.s=selector2 header.b=dUyJVSsT;
	dkim-atps=neutral
X-Original-To: linux-erofs@lists.ozlabs.org
Delivered-To: linux-erofs@lists.ozlabs.org
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=vivo.com (client-ip=2a01:111:f400:feae::70d; helo=apc01-psa-obe.outbound.protection.outlook.com; envelope-from=frank.li@vivo.com; receiver=<UNKNOWN>)
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=vivo.com header.i=@vivo.com header.a=rsa-sha256 header.s=selector2 header.b=dUyJVSsT;
	dkim-atps=neutral
Received: from APC01-PSA-obe.outbound.protection.outlook.com (mail-psaapc01on2070d.outbound.protection.outlook.com [IPv6:2a01:111:f400:feae::70d])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4PrVLv4jvyz3cLF
	for <linux-erofs@lists.ozlabs.org>; Wed,  5 Apr 2023 00:21:40 +1000 (AEST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=E1/+KnR2QvyegDH0HqgyL+Cgxcu6L6aiEuBHXs5U93qukMIvfWFJoYRdSJQmhHtHM0PS4fldk4rP1+ghteuve4qWBsGDPP3Blv6QRz0bVo4/bfSxL/fkjci+/G1DzItrfopxBh2gt2uVoeSv7c3jlb7ZrJOHM/feOhcRRng1YS8rDplCdEgX0de6Z6dSF2fCJkvERmHgJHX0MWosVcG6fV6+NEwVct1yOe9ozqyaw0Hm5Umkrfl7Wo/8GwcxTkfZ10Htm38OaGcJqrLHoncFdGbzDuLeHszMnFJMSs7PkZwZoels14ZcMXsLnKLmjFCusH0YmFzc4gm+2pcPqrcqlA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=mxQVT2Lab/BDVcz6BJ5VFF55WIP2l+zcFbF6B3CEPAQ=;
 b=bOx6ZtTT+9UjDk8bP7AkwHHBjJFpmP+8/YL/kxj49qdo0H9JK8U12GM7YimHey6BlCNYZJU794C6UuO4+iT3q3c5Cgw+VIaEPhB7axpfIyQ5M3Z3y5MXj0bvk9NTTg/PjDO187IQqR6yXbvQpCbOyBr397i8loO7EPCIUGuL8RXKcoS5PN36SYWvDxl3H0SP8dMSha362sHXU2GoS/gJ1Nj5X6eIqAXrR2jfQ2/gNN5RwG2hBHYsWxlEikS88fTYI6AiUJWcN507QDrFhgdwM2Mdc2THHXhkn9z9+orR60vIDXIOT0LFf5aE7tr3CB0emtnRTs2a1qR8tViq4G1FQw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=vivo.com; dmarc=pass action=none header.from=vivo.com;
 dkim=pass header.d=vivo.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=vivo.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=mxQVT2Lab/BDVcz6BJ5VFF55WIP2l+zcFbF6B3CEPAQ=;
 b=dUyJVSsTMvdUfwkmGBjEeeeOHw8FKUWz/8xlinrHlto15XzsR41drvK9iPicUvJLH0P6KFKP46GdQbh1YsFsN+xFSOQVBcCRZoLtvsV027amfa36Vy9LZEP4XfQUsClHnkaHJkOterGdPHf0daDWcbsYoSYQgK2trUCT0dkSLtsPvl5MHmveLG+qVzMdd5rBxKHgjgVJ12Q1yMH4++PIfVhsFeEuxTuXaSigpGsRj7rvo+LqLazQOswwWb+JhYjo+kob5qsQOfVgl/f3aJpdBhsojzrNItzj9wF+eYxA63uRQ7d9Th1iEAaKG40gQZitIy/egEaK0J3sPGZYqUBYxw==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=vivo.com;
Received: from SEZPR06MB5269.apcprd06.prod.outlook.com (2603:1096:101:78::6)
 by KL1PR0601MB4641.apcprd06.prod.outlook.com (2603:1096:820:82::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6254.34; Tue, 4 Apr
 2023 14:21:19 +0000
Received: from SEZPR06MB5269.apcprd06.prod.outlook.com
 ([fe80::a3a1:af8e:be1e:437c]) by SEZPR06MB5269.apcprd06.prod.outlook.com
 ([fe80::a3a1:af8e:be1e:437c%6]) with mapi id 15.20.6254.028; Tue, 4 Apr 2023
 14:21:19 +0000
From: Yangtao Li <frank.li@vivo.com>
To: Gao Xiang <xiang@kernel.org>,
	Chao Yu <chao@kernel.org>,
	Yue Hu <huyue2@coolpad.com>,
	Jeffle Xu <jefflexu@linux.alibaba.com>
Subject: [PATCH 2/2] erofs: remove unnecessary kobject_del()
Date: Tue,  4 Apr 2023 22:21:02 +0800
Message-Id: <20230404142102.13226-2-frank.li@vivo.com>
X-Mailer: git-send-email 2.35.1
In-Reply-To: <20230404142102.13226-1-frank.li@vivo.com>
References: <20230404142102.13226-1-frank.li@vivo.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SI1PR02CA0019.apcprd02.prod.outlook.com
 (2603:1096:4:1f4::15) To SEZPR06MB5269.apcprd06.prod.outlook.com
 (2603:1096:101:78::6)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SEZPR06MB5269:EE_|KL1PR0601MB4641:EE_
X-MS-Office365-Filtering-Correlation-Id: 5c4d76f0-efda-438c-4da8-08db3517dba5
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 	hEigWHB7ymj9FXfc+/MkC+B1nERNC37zygfegOZvqVZcp4YNK6kfw1BCdDpcdAj3003gsoMqyXKfDKmI4Ko9MKhBF1GLDYeQfxMSD/RR1PmmplEAeIYdXQSrYSb5EdRXJVRqk13WO+MeyNCwz1Apot5TTAe4ziaWOY+Pul7U5JXSLDof6OtDhjx7azXnzdQ2H1DcW8QH3QxuHrPg7Sig9tgstNaQTV4YVhOGaSk1Ou2WY7onGNIQRcR6DUreGhRNS0aLRwlXpsLJRppvRlatI4uakggtbXp+rAQ720wADGBDXwbYimN+sitdIM9q6AcUrTx6efvi8v3ZntVTth+1FC33IJXaErSFjCQOy75Ib4lkkpMfWqy0jdcI8buSQYoxOUwa8190WjgmkOK6iPy6O4IKUFQsWQEMaCeUmwimzNueYEltnDpNrYXLUos2NYN1vMXOA3OeaXoLyMqZtYgccWms/pbRCop1VZebfbe+J4xK13Bi1nYU2ePKd+wq2R6dX5tLHYqNn6AlK1Px7lihkXCeAhVuN7FYhzha5kogZLZLSbPesRB6Dp4mK0Vdg0IhOS7jFawZuTF6bxHPLHPj218tspETFQMVZFWr8yVfvRyyW2owASA/6UFu7JCfelBF
X-Forefront-Antispam-Report: 	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SEZPR06MB5269.apcprd06.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(4636009)(376002)(396003)(346002)(136003)(39860400002)(366004)(451199021)(4326008)(6666004)(2616005)(6506007)(66476007)(66556008)(186003)(66946007)(26005)(6512007)(1076003)(8676002)(6486002)(41300700001)(2906002)(52116002)(83380400001)(4744005)(5660300002)(86362001)(316002)(8936002)(478600001)(36756003)(38100700002)(110136005)(38350700002);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 	=?us-ascii?Q?2h/u2U4diDAUWqIZvttvyUqyMY7ukGVMMnTtgBYaq6lbnUKERwFk6Rg4AC4F?=
 =?us-ascii?Q?XF9XVxGya7ITOIWPITnTOhbPjuQCDGbV9MVjQE9UJCtZFNcsl8aCSdPJUP3p?=
 =?us-ascii?Q?nFzFNm/vxCCLk8kHW8Tm9wzHqQM071jNumg5SdLgynlxcSlc9S9ymTaxUpts?=
 =?us-ascii?Q?ZACZjSO+h+F8/m3WbLzs7MrmTu7BjaumMvvgEBfO1uNbmztiSQJcFa6YwzWe?=
 =?us-ascii?Q?LSHXzSjZOMXjaP3g+wkjTIuyngcF5Ct9lCx/oVTnuKyvgS1jw7JQ+19kh/v9?=
 =?us-ascii?Q?ym84z2sLwL660f3DAdLnW4t7sE8obmRgLB0ENUWe1SzMnZk6GeS3d7IRvj2D?=
 =?us-ascii?Q?v7Ddzq+ZFb2C6FrnE4bGEo2vtUEgeiqtBmR9EYc+7Z3dYkTvCLDjxxqUPjXG?=
 =?us-ascii?Q?P9Xyvn3b9aum6Ie8hEor8S92Wnav9Twx2sn4KSv2ZQLQFiezoqnuvqnAVMke?=
 =?us-ascii?Q?V2S/wvQwzj+QkUbjD7zjp0MWOV4x99alumz+WLA1S9pqGt5Y/AQiakuJgNS7?=
 =?us-ascii?Q?hZc1oVE9V9YGqzzrR7oDsaN74zuJCMMXCizQA5L2wlllu2QngQCMsGlaCDI2?=
 =?us-ascii?Q?zcmzl+j8Kic+3A0UsBmEOukhpO3GjvvEONDnaUNmVFCzJw25r3Dw7uqehK1z?=
 =?us-ascii?Q?i3iTY7sTWosvsdvhl5gwOdDQ+fALGleozPa3qNLjmg1t5nTlXhJ3v6WjCWJS?=
 =?us-ascii?Q?mqx/13bUGjg+dv3m2jvtatkanlFyZWtlZKIbxnRVP79wn7jDyIlexgq5yPxr?=
 =?us-ascii?Q?mq1TFe1TylYmUKLZcVCgtxgTgqTM7cr4uR+YCB6PIydH430PGJGC7qKZAeTT?=
 =?us-ascii?Q?H81m2DgABaSqNDgdgA9efPaDfCwZyJv+oGUlbKTMXKa9c6u/0y5TOENQA3+a?=
 =?us-ascii?Q?hsdBBk1P/raT8HlT2V7i6wX4Jd6g8yy96OZx/180x4Gh78spFm+672hlQu4Q?=
 =?us-ascii?Q?Tp2IBdDlBN1B5mVkrtLKjEsccmWCcKa2MCZrZ6u+hk9eCOf2Mc1EPESOmuXz?=
 =?us-ascii?Q?ACocEnBtEt4DpdbSr/0ohoNJV2GusTvmiayE0NyFE1nMIbaf7ga7Jpfnzvyj?=
 =?us-ascii?Q?05f55RTyZDIQt+oRNkanUPpjxkKq2c3b0b+2h94xj6vZNUuJEgsiRMgs2YQT?=
 =?us-ascii?Q?zWmCV+dfaI9FR22MxNwrsOdG1nK7DeLWK0SciOfm86pxsAQUroxVcNCRsj0E?=
 =?us-ascii?Q?crs6Swvrze++Af58WC4n0fuJox7svRyuapGMa7igl8m61uax+pxznrrSBcR3?=
 =?us-ascii?Q?5oGW+2PJquEGkzIr4CF/3vyoTvGcyw1pv+keVvovdkG29OlZ6JiYsKG6v3I4?=
 =?us-ascii?Q?caRdMYS2IjNijImvKofVTIXaa+T9/cb/WEY/drCMqlU/PDzGdl7ZUlJCoo5N?=
 =?us-ascii?Q?aitDdEtbvPPG9M6BunctQqB5vTnvzkV1Ry2afXxCqrQxSgpoRpv54ffT+k/o?=
 =?us-ascii?Q?TqUYvq9nCI+SD0sTjlkkAuUVnD639kJTDOdk6yqW0li/eifmuOfg+nmrzatk?=
 =?us-ascii?Q?+KQrCYEztqWNBpkiLfAjbDHR1kMp4NjPIBaXG73bk6IszY+Iix8aRSWeopyM?=
 =?us-ascii?Q?ciEHjCsJYE0XeZEn6Wn43WGRuXhOc5q/LAObLKGj?=
X-OriginatorOrg: vivo.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 5c4d76f0-efda-438c-4da8-08db3517dba5
X-MS-Exchange-CrossTenant-AuthSource: SEZPR06MB5269.apcprd06.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 04 Apr 2023 14:21:19.1068
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 923e42dc-48d5-4cbe-b582-1a797a6412ed
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: d+2YK0yB8HhBCuF/nC+WbQlr1kTaI+eXBT3oRFW7VumNJ/Tft+2pc5Wbtv0W4jQuiEfize7Csce6VIni9t8yhw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: KL1PR0601MB4641
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
Cc: linux-erofs@lists.ozlabs.org, linux-kernel@vger.kernel.org, Yangtao Li <frank.li@vivo.com>
Errors-To: linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org
Sender: "Linux-erofs" <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>

kobject_put() actually covers kobject removal automatically, which is
single stage removal. So it is safe to kill kobject_del() directly.

Signed-off-by: Yangtao Li <frank.li@vivo.com>
---
 fs/erofs/sysfs.c | 7 ++-----
 1 file changed, 2 insertions(+), 5 deletions(-)

diff --git a/fs/erofs/sysfs.c b/fs/erofs/sysfs.c
index 435e515c0792..c3ba981b4472 100644
--- a/fs/erofs/sysfs.c
+++ b/fs/erofs/sysfs.c
@@ -240,11 +240,8 @@ void erofs_unregister_sysfs(struct super_block *sb)
 {
 	struct erofs_sb_info *sbi = EROFS_SB(sb);
 
-	if (sbi->s_kobj.state_in_sysfs) {
-		kobject_del(&sbi->s_kobj);
-		kobject_put(&sbi->s_kobj);
-		wait_for_completion(&sbi->s_kobj_unregister);
-	}
+	kobject_put(&sbi->s_kobj);
+	wait_for_completion(&sbi->s_kobj_unregister);
 }
 
 int __init erofs_init_sysfs(void)
-- 
2.35.1

