Return-Path: <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>
X-Original-To: lists+linux-erofs@lfdr.de
Delivered-To: lists+linux-erofs@lfdr.de
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2404:9400:2:0:216:3eff:fee1:b9f1])
	by mail.lfdr.de (Postfix) with ESMTPS id 00BF64017B1
	for <lists+linux-erofs@lfdr.de>; Mon,  6 Sep 2021 10:15:26 +0200 (CEST)
Received: from boromir.ozlabs.org (localhost [IPv6:::1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4H31Rb3RQNz2yJj
	for <lists+linux-erofs@lfdr.de>; Mon,  6 Sep 2021 18:15:23 +1000 (AEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=lists.ozlabs.org;
	s=201707; t=1630916123;
	bh=Xsd2U62na5o0Kckm146Pen2s1gjJ6HRb7Lnc3PqZkNY=;
	h=To:Subject:Date:In-Reply-To:References:List-Id:List-Unsubscribe:
	 List-Archive:List-Post:List-Help:List-Subscribe:From:Reply-To:Cc:
	 From;
	b=e67TU6FZWddEQ5qVZfqJlFRl4OmOEHYIrDyMg2hQmUYOXPuGXmLOgDFoZGYUhiEv8
	 6kculVk9Ull2UEFszHjKlQGrAcdgvb4d0LGAOZVPFGJfY3+F1M6ilfWTCwjQHYX3bM
	 nqzFrP/wpmjjTP6Yl2N5WZuWXCI3br6BXnOwSCqlTX2UwW8jFQWFXhCd+duvo56tGS
	 A7BJK3+Dp3zyjgJPG2YIL4+ch3GBtLc82/aegUojdcDPL+vFdTrBB4tdl6humwv3cA
	 idqmbh3E5auLStujx2kKitUWchYk46ZWmjs2Yo+vKummLy0L0BGyQOjqHMrFtpeuG2
	 LAJOuDpYdUXbg==
X-Original-To: linux-erofs@lists.ozlabs.org
Delivered-To: linux-erofs@lists.ozlabs.org
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized)
 smtp.mailfrom=oppo.com (client-ip=40.107.131.49;
 helo=apc01-sg2-obe.outbound.protection.outlook.com;
 envelope-from=huangjianan@oppo.com; receiver=<UNKNOWN>)
Authentication-Results: lists.ozlabs.org; dkim=pass (1024-bit key;
 unprotected) header.d=oppo.com header.i=@oppo.com header.a=rsa-sha256
 header.s=selector1 header.b=gj4EKzxm; 
 dkim-atps=neutral
Received: from APC01-SG2-obe.outbound.protection.outlook.com
 (mail-eopbgr1310049.outbound.protection.outlook.com [40.107.131.49])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 4H31RN73J6z2xtd
 for <linux-erofs@lists.ozlabs.org>; Mon,  6 Sep 2021 18:15:12 +1000 (AEST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=LyGQKKaStV3zMYuDRrr4ERaRWK+eGPTpG4a+4l6CI1HGn3ffKq+/kdMzgdAqKe0m0+tA2LJLnllbkNHxxzezdmHwRVugJZpOMMe6FFbst8LOQV2+L8rT3CxAGyImfJgv+1OZuUrj2pKT84mwdVz58XT91MmVWJ+j3OS0XxzoJT0oGgtpkg9NIo8gT/3VW794HXYnkg7W81YoJ0FboHGrr3GPL+IMeKubM8tVYTc5tK7/16PhFtrxh9PAj91tn96QoTUAga8qOiE0pDmLijVGlgkUCjosRYOsB1wRqyax0WMmvuyDxzTJcMkVcoQeenrgSEFMD/vRnHhncznFbG0kfA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version; 
 bh=Xsd2U62na5o0Kckm146Pen2s1gjJ6HRb7Lnc3PqZkNY=;
 b=VNkNvrTS8RSvE1dkN35xF9580l1WRWSkmAgbIjerc0mnyECY1FKf5VLQu1XbdsGZ7cjKgen0RYRm1k0vlqAEoUu/ekjgDV2iG81s13BwInlP3osFLmivs5aaYI4kb66Z6AFiKwgtzSuJfmoifNHeav05NfJhD0RzeNvYdCvcHjAL1gjeGhcKk+fCHUfEmpqy4s/yTJGjRYtLALtiMHCVDhY8iTflcVdslyd2MyACPgp6C5CKmPVYiUCHJX94Ik8Fb9dGXXu6WUc9gm3xVU2VUdDnLh0ArjXoIWSHFoWz2jeM9HiK5LciH1kS9O/2AQpoPEMZRVoWxx18mp9614o/3A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oppo.com; dmarc=pass action=none header.from=oppo.com;
 dkim=pass header.d=oppo.com; arc=none
Authentication-Results: lists.ozlabs.org; dkim=none (message not signed)
 header.d=none;lists.ozlabs.org; dmarc=none action=none header.from=oppo.com;
Received: from SG2PR02MB4108.apcprd02.prod.outlook.com (2603:1096:4:96::19) by
 SG2PR02MB2858.apcprd02.prod.outlook.com (2603:1096:4:5d::10) with
 Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.4478.22; Mon, 6 Sep 2021 08:14:46 +0000
Received: from SG2PR02MB4108.apcprd02.prod.outlook.com
 ([fe80::5919:768f:2950:9504]) by SG2PR02MB4108.apcprd02.prod.outlook.com
 ([fe80::5919:768f:2950:9504%4]) with mapi id 15.20.4478.025; Mon, 6 Sep 2021
 08:14:45 +0000
To: linux-erofs@lists.ozlabs.org
Subject: [PATCH] uerofs-utils: fix random data for block-aligned uncompressed
 file
Date: Mon,  6 Sep 2021 16:13:59 +0800
Message-Id: <20210906081359.17440-2-huangjianan@oppo.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20210906081359.17440-1-huangjianan@oppo.com>
References: <20210906081359.17440-1-huangjianan@oppo.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: HKAPR04CA0012.apcprd04.prod.outlook.com
 (2603:1096:203:d0::22) To SG2PR02MB4108.apcprd02.prod.outlook.com
 (2603:1096:4:96::19)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from PC80253450.adc.com (58.252.5.73) by
 HKAPR04CA0012.apcprd04.prod.outlook.com (2603:1096:203:d0::22) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.4478.19 via Frontend Transport; Mon, 6 Sep 2021 08:14:44 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 92afbfe9-7bed-4337-a259-08d9710e62d7
X-MS-TrafficTypeDiagnostic: SG2PR02MB2858:
X-MS-Exchange-SharedMailbox-RoutingAgent-Processed: True
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <SG2PR02MB285839838FF14775C1A03BCFC3D29@SG2PR02MB2858.apcprd02.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:4502;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: DI69nrbM1xV6yilIukjjpfPoHe13wJob6x6GBTCG+urqGZjMWg3JJ0XaMGutVLu2h3EAUL7g9QO/+MYqse1KAo304HZ0jbUT6+oMGrk+n6tdzC7h0Oj5iHOSimBooFosef5uDqs0bg2XTCTfTJ4mhKfa0LvNf631eT6lyr6hWG4/pB48nc4uiy2yIncpuAB5StTlFcAF4TbidA3S17XZEYjssPanGqZMgb5TOMC63CM/0Hl20gunxvcDIMGTFbQtlBYrALz9R36DsJmaSHpCeBcsI9r98kvi202KQsSVOZOpkvkqdrFdvLEqjNVwpu77//NWjKbF3vUzuIL4hmgrVFZiPJwISHQpzSEHCe1zR6+X9VAnzugZDIKVsg7Okd0EFiaBviKjOea8zU8DAzkJ29HG+/wu6CfJfEMDmzykqNbZkPC+bCgF1nhtjZTxuj+WUUU88TT1EDYxxt2resKGFTm9bU7wzhpRwiz2IwoU6kdhZ5H77gahKldaomtp7QD8+CvkczDBpS+4E4akVwuik5l8Yh8BCAaa2aQl6GMDyPStuTyxBXJi/lAjv11vRgyKI2IF1yXyVEbI69pzda2/YwHrW8IDpAuVKqaAkBw2tiVQNlFrc3dqvwAuDov5a+QLWJMxZe5kbseHauDSAXvTttxPJSs316JE1ZqBTtKQUI46BEFVQDhZQ7gUiwLLe1IpHgz/HvQJYXOsX7cKzM+BQo4849R4Wzq4yq/mawBJoCQ=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:SG2PR02MB4108.apcprd02.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(4636009)(346002)(366004)(376002)(136003)(396003)(39860400002)(86362001)(26005)(107886003)(8936002)(8676002)(6666004)(6486002)(1076003)(36756003)(316002)(4744005)(4326008)(478600001)(186003)(5660300002)(38100700002)(38350700002)(6512007)(6506007)(66946007)(2616005)(956004)(52116002)(6916009)(66476007)(66556008)(83380400001)(2906002)(11606007);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?TkFmj3HDerjxelu+uKslCLvm+wMpHNT3KYgFsPu+JO5rGGCckmSj1zNOBRRI?=
 =?us-ascii?Q?0KqEZdVLuJ7ZkR9zkZsfSLGyqi21h83TTFF7S8SIoDVI5UB9F1HHi4XslpoN?=
 =?us-ascii?Q?i9wqSw0W4szOZD+cpo7lCZul+F9fkQnUO/JaeFWGkMRaQhlE0x//X0fn7bir?=
 =?us-ascii?Q?SmhN4PzlraF9Fk6YwH86ZBAdo9GBREQNwDEwmVFKnawaKFJBWZJNvKcBrQp1?=
 =?us-ascii?Q?2HKHI3EBMZ2dszxIfETWEHW3oFfsRsQ2F8o/6yNrFIV7H6hwX0KdEEDZtD+b?=
 =?us-ascii?Q?Uvoz4Rl27W1KtMBFUpuPQAuOZTTmM5jlOJ3fzCQXgFSOd4xtNfI6sLZDhsy3?=
 =?us-ascii?Q?+6HBHulO0iv/gMZgr8kZ1BcVUCHr0F1rDb+iLmv22MZR6yrws1aqPexcjPn4?=
 =?us-ascii?Q?dUpoLs9ZlSvLVwAyo/F5yidtIjt4DSZXUukhlsENxqIE3v1JLWCMglvFxmfi?=
 =?us-ascii?Q?UoyOiL2UYlvGb+ZXQUUFgZUERM4TaXQKUgrWz4BqvtMK7zOARjOAE4Y3O2ec?=
 =?us-ascii?Q?o4y+Icwab3STHTBQKDL5GqYbojiUIDdNkkseNmqnmMiR5wXChCChiz6gSXil?=
 =?us-ascii?Q?TDfKzT0GrEEHhK9c3GqCeA3cFiCaKE3Zl5YAednziZaAic7+F0JigS3yQ6Nf?=
 =?us-ascii?Q?KdVA5gRWKTJQQ77DzvB4FGA+//w+jhvI8/0zhf8nhL+pTpxGUe274+WRrR/G?=
 =?us-ascii?Q?taffuvZwSVWZyNOU87vuO3HkyoC9Lc4i+421XA8vkzLrJDdr+cyl2BCHlKKf?=
 =?us-ascii?Q?sGImrFz2fXERSBKyK+kJHeXZ5X8jwfJuPkOUVjmrPI6h3qSI0f1AgrEqD5yM?=
 =?us-ascii?Q?88zQPCrJ+986VLi6WsdmapILUiDIZgFVsMc5TDlvcu5nCyutvuKcaWEY27Ce?=
 =?us-ascii?Q?KCMpPBZnN3huBIH+RjrReXajafM2ONzU/3aFZs8Pie0+j8nJJ+TJX/0g4yc1?=
 =?us-ascii?Q?u4x+r2AyvtmUOuyJXUwAlSthGSw0shzFCBkhCYpA9+6NIMlV0pAJXEkwty0o?=
 =?us-ascii?Q?4vT5UfvlH/mZwvoJmORNvJ9imZK0Jewe2Lyv6N5n5jjFqi+yEnTVK9JREVV6?=
 =?us-ascii?Q?g0afpW3R3V9/ezuk9pNqVdnEeBbRqBS9vK5qHDp5Kebc5bLi8jpcbes/RLhh?=
 =?us-ascii?Q?EQaDYD2X8qqDOHv+GFBcJlw2mTNpBD3qInzrZFDqbhyxM/Z05pAClZvsr0C7?=
 =?us-ascii?Q?Qwbd2nvgeLa8mub9r44iF+xglPGP0JyCTiAK4Xa522cfmfnNbKULi3pUsk1g?=
 =?us-ascii?Q?0uBYoS6ArJmApxGBdOpHq9rEmYtfO53kSfyu/RYs/myzrt24KNqYz31M0syB?=
 =?us-ascii?Q?Jb2iGMzAn691lsyeEbg8IETr?=
X-OriginatorOrg: oppo.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 92afbfe9-7bed-4337-a259-08d9710e62d7
X-MS-Exchange-CrossTenant-AuthSource: SG2PR02MB4108.apcprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 06 Sep 2021 08:14:45.4693 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: f1905eb1-c353-41c5-9516-62b4a54b5ee6
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 7/+FDhouc8FscKARh1M9p3mizHaR7KmU/oRME0HeuiByUYT9vaPWVqrVHX7KF8kDpKDcuIyQmx6zHMIwTSTRQg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SG2PR02MB2858
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
Cc: yh@oppo.com, kevin.liw@oppo.com, guoweichao@oppo.com, guanyuwei@oppo.com
Errors-To: linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org
Sender: "Linux-erofs"
 <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>

If the file size is block-aligned for uncompressed files, i_u is
meaningless for erofs_inode on disk, but it's not cleared when
datalayout is seted in erofs_prepare_inode_buffer. Clear the entire
erofs_inode to zero to fix this.

Signed-off-by: Huang Jianan <huangjianan@oppo.com>
---
 lib/inode.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/lib/inode.c b/lib/inode.c
index 0ad703d..1397cc5 100644
--- a/lib/inode.c
+++ b/lib/inode.c
@@ -834,7 +834,7 @@ static struct erofs_inode *erofs_new_inode(void)
 	static unsigned int counter;
 	struct erofs_inode *inode;
 
-	inode = malloc(sizeof(struct erofs_inode));
+	inode = calloc(1, sizeof(struct erofs_inode));
 	if (!inode)
 		return ERR_PTR(-ENOMEM);
 
-- 
2.25.1

