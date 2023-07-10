Return-Path: <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>
X-Original-To: lists+linux-erofs@lfdr.de
Delivered-To: lists+linux-erofs@lfdr.de
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2404:9400:2:0:216:3eff:fee1:b9f1])
	by mail.lfdr.de (Postfix) with ESMTPS id 9E68074CB30
	for <lists+linux-erofs@lfdr.de>; Mon, 10 Jul 2023 06:26:23 +0200 (CEST)
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=vivo.com header.i=@vivo.com header.a=rsa-sha256 header.s=selector2 header.b=BbNVcOeY;
	dkim-atps=neutral
Received: from boromir.ozlabs.org (localhost [IPv6:::1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4QzrY93r7Pz3bX2
	for <lists+linux-erofs@lfdr.de>; Mon, 10 Jul 2023 14:26:21 +1000 (AEST)
X-Original-To: linux-erofs@lists.ozlabs.org
Delivered-To: linux-erofs@lists.ozlabs.org
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=vivo.com header.i=@vivo.com header.a=rsa-sha256 header.s=selector2 header.b=BbNVcOeY;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=vivo.com (client-ip=2a01:111:f400:feab::719; helo=apc01-sg2-obe.outbound.protection.outlook.com; envelope-from=guochunhai@vivo.com; receiver=lists.ozlabs.org)
Received: from APC01-SG2-obe.outbound.protection.outlook.com (mail-sgaapc01on20719.outbound.protection.outlook.com [IPv6:2a01:111:f400:feab::719])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4QzrY40bWVz301R
	for <linux-erofs@lists.ozlabs.org>; Mon, 10 Jul 2023 14:26:14 +1000 (AEST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=gREy369J+X8lWvyW5CFcVrqvf6IVLy7b57kxyobVg7QGvp7BRfxQBXHk/tve02eHy3Czr+LdBRP/IbDUbj4IBPJ6gB/CKreedbFttCYdk4vyyS1plw3mSG7/h01k7yOQ1/b6PDIsnHC/En54nE9/zq+gnbFiOCVzJbFj9E+b8btZ7w1KrxvOUEUcaMQgQK+K3GyN9XZK/TeV0jh58w+gKxEvpJhF/Tosveh1wYGOIZ6mhgG9REOz464u2EvGWO+s1Td6zhfPscTMIPTdhDEQ7cl/7Pas2xUzFZyfn1QgdSKtPUk09rgb4eITvJSxGGVCwJL3a+wbE1Oq6uEzgb8cBA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=but9xGWUClSCNyz/budytUTSCviuryC7CaZzX6GmDN4=;
 b=DbT0+JFhrCiuAbAqK0lyCBQ9ae79kvWl//0+//kSfrWOwh3yRykLnbkJlH8zYyHEIQEASYm4NWT26pwcEdYbF6GMZQjD10SZ7nY+cIi+hZrN+DiaaoDZeEhFWrLuGIh12FqEjkhH5HzPQnvFlW/OjZhf+v2xHo45dCifsHaa6A/oYnttIfxKVE/xUfvKKjDUxyiRYQCoTR39/wd0daWn2LRgnSLN9AyGbEWsTQzCECx9q1PAjG7Ym0mCbhpOyFu3yis2ueIsrALy7zVKK/Ft6AU2YM6xJsgnDIstI0SOkQgAtFOcHTcmmzgOLB62QV8BkEjriyeubfRP5qoJ0f9AsQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=vivo.com; dmarc=pass action=none header.from=vivo.com;
 dkim=pass header.d=vivo.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=vivo.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=but9xGWUClSCNyz/budytUTSCviuryC7CaZzX6GmDN4=;
 b=BbNVcOeYp4NCwPeKXa9lLvEOc5fRwEk1sEMB8MO2SpigBggyPTL08SjNJxdlNKmX9lc5pp8UvoipULnjKj1lZOhd6F7iIYwaAGdGAc9SiTVnBLgIMSUaMn/+VL+rA6hZc1gM7aelVqnuDx9G2d+2x1GejSoy5gwHrDmQIXIWspHUmGK/Fxpjf2PbgW3MeobwE3dkpbizwZklhX/IZrgduU1OCJ0CJu6wgqRkoNxBRcNBfBC0Gj1s8KWUEjqMUVm5ltDAjAMoREny/VKSGRWDUpXfq1BTU8PDejOpjdA3+0vHIUbElcVogn6kAIF++abvI/wFnTuvoMToiYzf7fXpog==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=vivo.com;
Received: from SG2PR06MB3338.apcprd06.prod.outlook.com (2603:1096:4:97::23) by
 TYZPR06MB4109.apcprd06.prod.outlook.com (2603:1096:400:2a::6) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.6565.26; Mon, 10 Jul 2023 04:25:50 +0000
Received: from SG2PR06MB3338.apcprd06.prod.outlook.com
 ([fe80::a05b:2f8b:fba5:50fb]) by SG2PR06MB3338.apcprd06.prod.outlook.com
 ([fe80::a05b:2f8b:fba5:50fb%7]) with mapi id 15.20.6565.028; Mon, 10 Jul 2023
 04:25:50 +0000
From: Chunhai Guo <guochunhai@vivo.com>
To: xiang@kernel.org,
	chao@kernel.org
Subject: [PATCH] erofs: avoid unnecessary loops in z_erofs_pcluster_readmore() when read page beyond EOF
Date: Mon, 10 Jul 2023 12:25:31 +0800
Message-Id: <20230710042531.28761-1-guochunhai@vivo.com>
X-Mailer: git-send-email 2.39.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SI2PR01CA0023.apcprd01.prod.exchangelabs.com
 (2603:1096:4:192::17) To SG2PR06MB3338.apcprd06.prod.outlook.com
 (2603:1096:4:97::23)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SG2PR06MB3338:EE_|TYZPR06MB4109:EE_
X-MS-Office365-Filtering-Correlation-Id: 724ee590-16f6-44cf-9848-08db80fdbdf4
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 	6sLh54XM3cTBcQQwqV3YZNT6HMj849pQm05xl2dMXiCHTiiCSMky5JrJoxSEQGS+Ot/KlSCyzivKmQzwQ5oJVfIR3gKvPG4zdDLOMTtvGp4RCaCmLU4tfi56gdBVBGdnpdeQGNgwBQi/7bIPvz4xT38AhOtvADHjupRL9P/W4YYO6zjFVtJtG5DJ1fMN7ZSpsJjz0Yj39cZ7Y84241amhesUitbDZ57PskaOMuE4hj8sTWBaFEgr+RJcf8gkNdx8sYFy03jM6kmTjynUXL+DjCgGc/05MInp4UNtUiwzId4fRnWjt80iLPplfebEWLY3ctwytNUoRRrrCPyb2wXTbGjiGseCXPCZyVTS60L9sLuDsdZ6eZ2sVeT4N2azgW4GFYSv5Aa2B5M9jZMAong1V+R92MKMW0MIBlzl6vrAq79KzZHUPnp0raB8g4s3S7HWpmvD9yzB8lxyURi0M0NJBIgDnaV597nO2kg8pQk1RXy7mDC5iDM29V315GwQXn91o/CiA/c7Cax32Vn9ghtEU4MDQRaI0u+cESFoYsEYR2gzIdBCnI3W32xMj+Zo7wAqV15A8/znPlKNJF4VHMU9nqlcti2l35pdZ/l84+DS9J8=
X-Forefront-Antispam-Report: 	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SG2PR06MB3338.apcprd06.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(4636009)(39850400004)(136003)(376002)(396003)(366004)(346002)(451199021)(6666004)(4326008)(66556008)(66946007)(66476007)(38100700002)(2616005)(38350700002)(86362001)(186003)(26005)(107886003)(6506007)(1076003)(83380400001)(52116002)(36756003)(478600001)(4744005)(41300700001)(5660300002)(8936002)(8676002)(6512007)(6486002)(316002)(2906002);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 	=?us-ascii?Q?DlGh5m+wm4exOdPjIa11oK4Jo+rx2W1/DF4tSwAbAflcPpDSmGz5deiUL1ek?=
 =?us-ascii?Q?Q9xCoKNu6haQtCHkvGWh+olxSO1DaabTmRiPG96o2ExVGWBnQ3BOVj/08SPJ?=
 =?us-ascii?Q?Fq+KV6SbnAgLP1gi3phrqxS2T8v7HyGRM7ZCBDxMoC06z0Z259Hsi2Mznrc5?=
 =?us-ascii?Q?Xee5TB07j5Uw4SYRBS2XSNbiCmAHM6qdMU1s7XrKuW24W4bMFyOQhQc6xkyj?=
 =?us-ascii?Q?Xg3IPeBwc+IjGG5ZHb/YTND7/X8dDcfh4kN5YS99ZtH1rQ0Sdgh3fCbA3gvd?=
 =?us-ascii?Q?OJuNFJqw2vOY4sg6VB5mxMmmbU4R8fPs4BFzjyf3E1EOgvYLZR60uZKmuC5d?=
 =?us-ascii?Q?MeYBZwVvl6YdFb67GvaO+1iTADgqeO4eXXWUPwBaKaAwQjIrml2cRw1TmFPo?=
 =?us-ascii?Q?At5JuQH8V704iqKPTTvN3UVJRer2NGd7xDMfpZLHK2MBvMhnnTucpTMyyo2a?=
 =?us-ascii?Q?buVyXYv7NFdfKVFSw9GR9b243K3SIGLGEUU/vh/6Gxuk+d3KrX7JJCAlGvqs?=
 =?us-ascii?Q?1GdBnhcQ3Z1nj+37kIRpcPoIg/yxEm3k2cp1fPzTG58g+HltTQfhgRmXSyOl?=
 =?us-ascii?Q?HD5VfwzMqRc3aJIyjoWZkHJVn+oz9Pbl+G/YD5brNhNTCKxjOiIm1z2993p+?=
 =?us-ascii?Q?4v6VAJUMBYikV2bz7k3eA2rr+G4lRpd9en/noLnUXaCjYuaTioMvjaiDgeCJ?=
 =?us-ascii?Q?/OACE1KUUakc5dftgT4S/Sk2iTrQron/WVyMRXHd/N9K9FfLmw5D4QqqvhXq?=
 =?us-ascii?Q?M1rnqIgi7m/+0XaIoW2DiLyNACNFJjcUYYFYoGv10Vse+JgssgZ6tIJTCREP?=
 =?us-ascii?Q?QYIyMe8b/7vU0WQzOM1G+EDwmKhUUBey+eQAWZaY0Z4Nyho2dCocAq6CKboR?=
 =?us-ascii?Q?BlWfA0lP8q6+dub/qgFeJYqoNAq4cgFAi5HIQKuq4Llmfqyu4CycbCW830wi?=
 =?us-ascii?Q?aktFyf1PjgG7BRCkLUvKqanCLxc6hLXCQ2NjyTSgKneaYZpwCCdQ1mUZkxQT?=
 =?us-ascii?Q?ngVl3UiMUv3T79nwC9xmxz1/FlQhC/ZqO8wTwL1i0o+Ygct6B72nFFCVSKId?=
 =?us-ascii?Q?9lacMdgZvDqBTne1FsmXxOxj/El0S1/WSqtzWjVYbsxyiUBUagvLPd/V8JGB?=
 =?us-ascii?Q?N+remP51qUtV/zGa6HCiMJiDwjyVa5gVfW1uKKiL6Wy8PIZHwUNfVXxY7RM4?=
 =?us-ascii?Q?phOcGiR8VM7KwrVsUJBsC+CNeA4+fno2ppWIn8/KAg0zq6YUXVR9AsZZH6Tm?=
 =?us-ascii?Q?j1ZlAH7xk1KJ/sCm0vIZRErd7y7/H9FBtSnXDkC0tFURLU2JjcJ4b/bNLi/I?=
 =?us-ascii?Q?pyDLNCrj0mVX/t/kme1JJN5qb3li78F35U6mwEc192YGAZ7K15anSup6c3VB?=
 =?us-ascii?Q?EoZ9Rpx20CCkI7tLpuueunX+hUcblrik8cDiZPeqzxY6GeNhWqQ21IzWRzsR?=
 =?us-ascii?Q?EjuGrDJe4VZaat5Kw++05IWVkdWFQzSvoE/gHfD6MKVKWkn+xnJfD7fnjQCJ?=
 =?us-ascii?Q?71KWO7P1huJoSZaFmz8VXHSQyaJyJVpynzmnPDB8y0Q6mdnUzwzNcvOARBJA?=
 =?us-ascii?Q?eVKuxn+m1IyO95WV+552gBk99saJjA/F+XjydgdM?=
X-OriginatorOrg: vivo.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 724ee590-16f6-44cf-9848-08db80fdbdf4
X-MS-Exchange-CrossTenant-AuthSource: SG2PR06MB3338.apcprd06.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 Jul 2023 04:25:50.6277
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 923e42dc-48d5-4cbe-b582-1a797a6412ed
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: H0VWPcOmRPTpL5O1IRR2Q7MQSutGtvr4Nn3n05Reg5h16mRVycnXjMEMKaLLcN4xpWzUdo5xc9kLmLr52rQCWg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TYZPR06MB4109
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
Cc: Chunhai Guo <guochunhai@vivo.com>, huyue2@coolpad.com, linux-erofs@lists.ozlabs.org, linux-kernel@vger.kernel.org
Errors-To: linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org
Sender: "Linux-erofs" <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>

z_erofs_pcluster_readmore() may take a long time to loop when the page
offset is large enough, which is unnecessary should be prevented.
For example, when the following case is encountered, it will loop 4691368
times, taking about 27 seconds.
    - offset = 19217289215
    - inode_size = 1442672

Signed-off-by: Chunhai Guo <guochunhai@vivo.com>
---
 fs/erofs/zdata.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/fs/erofs/zdata.c b/fs/erofs/zdata.c
index 5f1890e309c6..d9a0763f4595 100644
--- a/fs/erofs/zdata.c
+++ b/fs/erofs/zdata.c
@@ -1841,7 +1841,7 @@ static void z_erofs_pcluster_readmore(struct z_erofs_decompress_frontend *f,
 	}
 
 	cur = map->m_la + map->m_llen - 1;
-	while (cur >= end) {
+	while ((cur >= end) && (cur < i_size_read(inode))) {
 		pgoff_t index = cur >> PAGE_SHIFT;
 		struct page *page;
 
-- 
2.25.1

