Return-Path: <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>
X-Original-To: lists+linux-erofs@lfdr.de
Delivered-To: lists+linux-erofs@lfdr.de
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2404:9400:2:0:216:3eff:fee1:b9f1])
	by mail.lfdr.de (Postfix) with ESMTPS id DD478730DAB
	for <lists+linux-erofs@lfdr.de>; Thu, 15 Jun 2023 05:46:33 +0200 (CEST)
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=vivo.com header.i=@vivo.com header.a=rsa-sha256 header.s=selector2 header.b=DqIhhAOl;
	dkim-atps=neutral
Received: from boromir.ozlabs.org (localhost [IPv6:::1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4QhSrj1PnMz30dp
	for <lists+linux-erofs@lfdr.de>; Thu, 15 Jun 2023 13:46:29 +1000 (AEST)
X-Original-To: linux-erofs@lists.ozlabs.org
Delivered-To: linux-erofs@lists.ozlabs.org
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=vivo.com header.i=@vivo.com header.a=rsa-sha256 header.s=selector2 header.b=DqIhhAOl;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=vivo.com (client-ip=2a01:111:f400:feab::70d; helo=apc01-sg2-obe.outbound.protection.outlook.com; envelope-from=frank.li@vivo.com; receiver=lists.ozlabs.org)
Received: from APC01-SG2-obe.outbound.protection.outlook.com (mail-sgaapc01on2070d.outbound.protection.outlook.com [IPv6:2a01:111:f400:feab::70d])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4QhSrY3vStz304M
	for <linux-erofs@lists.ozlabs.org>; Thu, 15 Jun 2023 13:46:19 +1000 (AEST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=W0OOn8CF7bulV+NvkaT+8kD8G5o7hS9KUPV31ws+vB3X7OzuPw3BmvH9uAjVwDSyl9ZgACbwA2hlgRgFOpvYlfvb5j4HrbsJ6nhDca9ttlZ/tUT0rVSAFsipeP/p+bBGAFFiHpC3O+6FqH0tX6IkIlK303PPA2wsvFn9cYMvHfMlxG8lDYJcWENUu5KKOJxcIS6eysXPhd56bVnbmf7wXODsltPGPOCjmySmSCuVkXQPEldmJ3gJ4XJxYUMy0P/UfiS83gJdjshIoAEm/S92q3LOonrc9uAXL5lsm8scREUcBdoEe6GPhwQWdu+KV1JZSkm0b5XHnkzGYBbN5cXtYw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=/nLzuJjX7sBndncqWaTh2UYef7txZXPPz4N9YbqHyaU=;
 b=QO9pd5JPR4uKEhxH0gmzX02ENP3+sj9pPWqw5qzoa5gH75T3Y0t9vtZbNneD08OMerKhCa8K1BdGDeIVmKNqJhRVAZhZJOI211dT5C3HcDsHDHTKfMo0lY4+Td22RDHliMqohWKcmTWVI+Il1LC4x+2eiXb2S+e3V/xrqOM28/Bq55eIpG4STTQOdQeoziOjiEI3pcISjPuvGuDVQjtXFlTfvvIuBAzAyT5OXBPdhX7cpltBarxdcLsxV9PYMKFCaqcWb9Is1lTCnGCFpLCSaQUlK3Wyg/XTgSwFPki56rJ5sPSdeeoFHUM6De0u2ZvwjZ2NX41Plhes/6KvIvIt2g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=vivo.com; dmarc=pass action=none header.from=vivo.com;
 dkim=pass header.d=vivo.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=vivo.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=/nLzuJjX7sBndncqWaTh2UYef7txZXPPz4N9YbqHyaU=;
 b=DqIhhAOl/W5JCwO5DG/BW3MBf3xR7rhMLbMTIuX/pQuesD7busL6d4AFqXvhfTpPBaLhhrnta/Y+3hG3DGRnb8Hw4ldIY0ZTeHE3qDEJ/du/EQwMqGToJXhG7CQZKXikx7JswAX7lZ3nwZ2PzNpg3Lt8ugC5+z+TxjqNpcS3wUQ8N/nJ/eMXv88pVR19DK8mKlebX5e9DJVJHx0qgTilf4UzlV8WLy8cvCkWdb+d/WXw/hut+DPi6rENQ/HEqhdgKxLNIJeI4SMS/OmWqWS2mJe0NMuztm70Q/amucvJFQ4JNf1u5MjQ7esY+sCAmw4KN0NC4+T3FLg2UVNfi6ae9w==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=vivo.com;
Received: from SEZPR06MB5269.apcprd06.prod.outlook.com (2603:1096:101:78::6)
 by PSAPR06MB4534.apcprd06.prod.outlook.com (2603:1096:301:7a::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6477.37; Thu, 15 Jun
 2023 03:45:57 +0000
Received: from SEZPR06MB5269.apcprd06.prod.outlook.com
 ([fe80::fa0e:6c06:7474:285c]) by SEZPR06MB5269.apcprd06.prod.outlook.com
 ([fe80::fa0e:6c06:7474:285c%4]) with mapi id 15.20.6500.025; Thu, 15 Jun 2023
 03:45:57 +0000
From: Yangtao Li <frank.li@vivo.com>
To: Gao Xiang <xiang@kernel.org>,
	Chao Yu <chao@kernel.org>,
	Yue Hu <huyue2@coolpad.com>,
	Jeffle Xu <jefflexu@linux.alibaba.com>
Subject: [PATCH] erofs: remove unnecessary goto
Date: Thu, 15 Jun 2023 11:45:38 +0800
Message-Id: <20230615034539.14286-1-frank.li@vivo.com>
X-Mailer: git-send-email 2.39.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SGXP274CA0009.SGPP274.PROD.OUTLOOK.COM (2603:1096:4:b8::21)
 To SEZPR06MB5269.apcprd06.prod.outlook.com (2603:1096:101:78::6)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SEZPR06MB5269:EE_|PSAPR06MB4534:EE_
X-MS-Office365-Filtering-Correlation-Id: a58ca942-8b5b-4361-a940-08db6d53068f
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 	L45+LmTF/vvhqYxlZY5FNHzZ48D2xCpuxLfHLkkU5SLcI1DNn9HZbVSeODxN3jRndUyUb+leZ6aSZfTbVUnyyZjFoifZPXMNQYN5hfAnMnun5cqi8zwocsMlPkmCqNDYub7E5Fy/3RDjIjgfOtFkoaeTstsSW/NNM2bvpC4wq8idwZLjZ4gx0urmjI3ZDNy8Gaj5sDJ0moDmnUQlqm6HWr8MgkabBhky2cIwFebqQBAZnPuRQZRWdRWd5mdb9h9t9NajcWbv+nXslDJ6rwqiaCvlSSqAku2X8d94Wwe6IK8PywP705JSOV+kHpERmelILpKQG9447NHUr7EJHzAvO6PnX5U1S8zrjwmANg478nY2XgdE49l6RCwukdx/53oxXNcpPMng8DLJQnAGB4IXBtc2KMQMrb7Y+hHAG19jAhEHLBNEAKHnIz4ND089Mt25X25Frwos1lYpDjUrvISVezEFK8elI0kAi9LuWEc9u1Ov0JbkeUtZgHyCazWDwODYkD/z1RKfbvVUFHNmf5F8s2FrCDAfJvVtL0vhZyfMnsgjCF/IhaybQkz4HZJb10KAdACgvWzyQD678+LG6ITDB5KO6THyDs/Lj6mg0IV6j+AyE2jpdXGzXFew32ZxupjY
X-Forefront-Antispam-Report: 	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SEZPR06MB5269.apcprd06.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(4636009)(376002)(39860400002)(346002)(366004)(396003)(136003)(451199021)(38350700002)(38100700002)(478600001)(6666004)(110136005)(52116002)(6486002)(316002)(41300700001)(5660300002)(8936002)(8676002)(66476007)(66946007)(2906002)(66556008)(4326008)(4744005)(83380400001)(6512007)(26005)(186003)(1076003)(6506007)(2616005)(36756003)(86362001);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 	=?us-ascii?Q?Ztc4Aa6zc19EWDYsvz3aT5rURQg1yLIQBb+DzQRiSTKdyp/zbQXwQ3dkLqct?=
 =?us-ascii?Q?YRRXZ4R6iBb8arhpBHNzLf5ZvnS5ZyCDjuh2ZhHs0LyrBUkpo/oghFukS+1L?=
 =?us-ascii?Q?5YniC4bYB5YXWadZxPY6beGiQbbolECXfa7FvkP172xiH/+FEUCtWcaky/4e?=
 =?us-ascii?Q?7t6005hc6Xem46txsrKMxJ+a5b7f8Y+oQCy9adu9rCl/ojulslJSmve0R9Cw?=
 =?us-ascii?Q?SNZiurbmNSBE566cVO2IJZq07XRPC9x/Bn5DKFN0U5m0kI3fn2uXchRacG+v?=
 =?us-ascii?Q?9yHU9Fmk2IZStbjXM59SSseuhTgxDaaOQ0+IJ8HRiOJFHr9IjuvM7Kcy+lTb?=
 =?us-ascii?Q?gx+gvfUiqj4MaNZnmae4qJns7IXWUgHurFhRTNNEIPUOJ0hbK9WcxKFEVig+?=
 =?us-ascii?Q?9Z3HbGS/Cjf0E0V0PEQHJNeTQMHOvoITHw43yh2bCqYQVLWbOWCF2kWcbjVD?=
 =?us-ascii?Q?FcPtxHT5+uQixleifJd6gVgo8sIEEFpjRX2mNgG8Y6tnHE0LdhinmlD+8BXH?=
 =?us-ascii?Q?VR9yBQCODN4OBZ/9qnCuMz7dSdhCKXYhBHR9/vqsd/Fe9iVxaI2PT5wjB7PT?=
 =?us-ascii?Q?dhr+pc+fIJ0DLgi7n+Kr0YWMgdKsSjtdWwmDLTlyQhyD0+8QUkPZHkgSJKXP?=
 =?us-ascii?Q?7pY4ckoUlaxdT0ZUNAfSr71nZq19Okt7p8DAfSXFWQHspCNCleoNdBaVmXA1?=
 =?us-ascii?Q?ZBDlLy3Z1hsv5R4KDSu9u08whXtI/0m0++F9JY8Icd8UeXYEwcF/nJ1oCQ7L?=
 =?us-ascii?Q?x/6Ar1AIXd7KTVibaWuVCtDA1/K+PjkSuY12KUQa/uzsxBrq0IBuOT/zv0DU?=
 =?us-ascii?Q?1VoxIzrCTIvQEW5MczqE1fl3jsTAVTDqKjnvkOxh674F0bCJcakeZtf8VELn?=
 =?us-ascii?Q?H4XbZd8JW1YARhckhOmFt/vixG4w7uxvUJLfA44z9cfUV9rxV61I89Hz5l26?=
 =?us-ascii?Q?drbwjIJNveIwn77ovVpe1cZOYdLBZVu8TSI/4JI9ucLsb/JpiO35y+HDvIhm?=
 =?us-ascii?Q?pCnXZphfpnxFteQKVvuM6q0oR479n+cKpGlP2ITCUvB4i8L539r/lWmiw6et?=
 =?us-ascii?Q?Ll777RBs+UQGVakryaxtRjmHiUD3YNpdqxRQZ3f5n3kH0fPOf1XehZ70N02H?=
 =?us-ascii?Q?1hDw8mLbqhykyL0PgKZPnTk1HrMKQXWvWvtz7I5npC5VUIXIEE0ShOI1pq6p?=
 =?us-ascii?Q?dNsMl9+7Obn+lWbZgcvdKK2wIRMyHIGAs4eecphwp7s9MDKMNsZS4A1KM1Rn?=
 =?us-ascii?Q?jNaQ3fFc0IcNnYyLS/CvO8kOi4+SAs6k7Hbcp53ZFamYb2WlCAY1pfxCqoqa?=
 =?us-ascii?Q?LTI2niQPIxPnGcH26qRsasSWcy7l/+kdOxToJeE8/OLk3hJk8DJe/wLBs2Bq?=
 =?us-ascii?Q?k9k52E3QQFgWlyc0ZBInFVlRTqBJwGkJFb1bxhFJCW61uAYYMzKFgE358wY7?=
 =?us-ascii?Q?yaqHS2sdDTLdMEN8hboRaVvJG3rlIKLqYpwzGAkxBVRCGRGxrFc4nqSE8f+R?=
 =?us-ascii?Q?qlgpCec8sl9vOuq+roM1bQfqoBubU3p+ddCBm6wpC4A3iZZzhirrzqQAdrwZ?=
 =?us-ascii?Q?M49uFf1P2YU97GD5OMpDgA+CI01DPEBcGPrNcR9L?=
X-OriginatorOrg: vivo.com
X-MS-Exchange-CrossTenant-Network-Message-Id: a58ca942-8b5b-4361-a940-08db6d53068f
X-MS-Exchange-CrossTenant-AuthSource: SEZPR06MB5269.apcprd06.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 15 Jun 2023 03:45:56.5936
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 923e42dc-48d5-4cbe-b582-1a797a6412ed
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: bVFiI0/BgfPd5cJpjb3lAI477aMhmLdk2HZ/bjuzHAMrUDzKkeyrHTnlsKWDmYdGDKmVqo0aXu+1lyreHyLQyQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PSAPR06MB4534
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

It's redundant, let's remove it.

Signed-off-by: Yangtao Li <frank.li@vivo.com>
---
 fs/erofs/super.c | 7 ++-----
 1 file changed, 2 insertions(+), 5 deletions(-)

diff --git a/fs/erofs/super.c b/fs/erofs/super.c
index 811ab66d805e..f48ce692094d 100644
--- a/fs/erofs/super.c
+++ b/fs/erofs/super.c
@@ -1016,10 +1016,8 @@ static int __init erofs_module_init(void)
 					       sizeof(struct erofs_inode), 0,
 					       SLAB_RECLAIM_ACCOUNT,
 					       erofs_inode_init_once);
-	if (!erofs_inode_cachep) {
-		err = -ENOMEM;
-		goto icache_err;
-	}
+	if (!erofs_inode_cachep)
+		return -ENOMEM;
 
 	err = erofs_init_shrinker();
 	if (err)
@@ -1054,7 +1052,6 @@ static int __init erofs_module_init(void)
 	erofs_exit_shrinker();
 shrinker_err:
 	kmem_cache_destroy(erofs_inode_cachep);
-icache_err:
 	return err;
 }
 
-- 
2.39.0

