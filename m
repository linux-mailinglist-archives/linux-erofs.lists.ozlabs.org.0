Return-Path: <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>
X-Original-To: lists+linux-erofs@lfdr.de
Delivered-To: lists+linux-erofs@lfdr.de
Received: from lists.ozlabs.org (lists.ozlabs.org [203.11.71.2])
	by mail.lfdr.de (Postfix) with ESMTPS id C8C812D38E3
	for <lists+linux-erofs@lfdr.de>; Wed,  9 Dec 2020 03:40:04 +0100 (CET)
Received: from bilbo.ozlabs.org (lists.ozlabs.org [IPv6:2401:3900:2:1::3])
	by lists.ozlabs.org (Postfix) with ESMTP id 4CrLqk2PT2zDqkp
	for <lists+linux-erofs@lfdr.de>; Wed,  9 Dec 2020 13:40:02 +1100 (AEDT)
X-Original-To: linux-erofs@lists.ozlabs.org
Delivered-To: linux-erofs@lists.ozlabs.org
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized)
 smtp.mailfrom=oppo.com (client-ip=40.107.130.71;
 helo=apc01-hk2-obe.outbound.protection.outlook.com;
 envelope-from=huangjianan@oppo.com; receiver=<UNKNOWN>)
Authentication-Results: lists.ozlabs.org;
 dmarc=pass (p=none dis=none) header.from=oppo.com
Authentication-Results: lists.ozlabs.org; dkim=pass (1024-bit key;
 unprotected) header.d=oppoglobal.onmicrosoft.com
 header.i=@oppoglobal.onmicrosoft.com header.a=rsa-sha256
 header.s=selector1-oppoglobal-onmicrosoft-com header.b=r3HejG/B; 
 dkim-atps=neutral
Received: from APC01-HK2-obe.outbound.protection.outlook.com
 (mail-eopbgr1300071.outbound.protection.outlook.com [40.107.130.71])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 4CrLqc32VfzDqBg
 for <linux-erofs@lists.ozlabs.org>; Wed,  9 Dec 2020 13:39:55 +1100 (AEDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=lZKhLrxO/IFVolIJ8sZlBToxGNvOd2Hol6yJaUrRhb861yqJJ1SWbosyano1tW/4wxmaBvr6zgSFxOjUgXwXRfS2zl40Sl1jnaHF1XkflrtBCTfLmgD5BoLxNvAJqUdh3s9Ad3PYaJCasjYYCL1sLXc9SbZGTqlfzznZmtSjN7MDi2UwBU7qR+69m4yGB8Ghk4XpOEgOm8vsktd+f9Pu7hM72KoMWdyn3qmyn4TBzJULk8bco+l1+ZsTJJKG9iF2DryOcdfHgSdsoCl1EA3Gbxp9lzqPjtOuMAvbgxdflom37irOpR1ovJtXmI99e1fwdpgb0sGnKA/F2HeCOReeJg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=AMxXvGBy2MWXqsETDuiVKEL/Re0aGOm0lekuBhQnTEo=;
 b=Qq0Kr5fQMUdGhovJSg9L261k2sHTLyn/q5L7yPpiuVcsaIgumbDmMN5UFIwdOuvBP1PUR5qTegtp6wurwXXjiKH7V7t0HDW30oPgyRJCOdtKDBc372PT0WP1SkFW4JgrspgVLsP/dsRWJHZqLgxB+wRsUkMtsYd+iFMA+nt0BR6O3B55GSu1O/e0Ut5icEpOyCSTzE8T4gHl45U0gY9fW6XQ9O9UneYchC/0mSqiqG3dSC6qlmCwCtXORhp9wRpr0L8jpWxRUr/phTrbfxcC03ymPPuxtI9aRxnVX5qbfobueZfYCjR9YSE6UBoj9q2MGzDXdqKTRLlSQOJxTLZmHA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oppo.com; dmarc=pass action=none header.from=oppo.com;
 dkim=pass header.d=oppo.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oppoglobal.onmicrosoft.com; s=selector1-oppoglobal-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=AMxXvGBy2MWXqsETDuiVKEL/Re0aGOm0lekuBhQnTEo=;
 b=r3HejG/BqV6ywKMLAt9zIWtCUoCVIBPTkjIpAs61FkFPbNO4YTPk/7C3NDMtWWzF0jkysnf/qB5hS89P83mr2PuUcykb9Zp8FHotb0nmUXkl7/QVzaVDpqJ0Shl31pxgprAw3PNQT7seoxw0l5yOK8vqROiHU8umbz3piEo8M6k=
Authentication-Results: lists.ozlabs.org; dkim=none (message not signed)
 header.d=none;lists.ozlabs.org; dmarc=none action=none header.from=oppo.com;
Received: from SG2PR02MB4108.apcprd02.prod.outlook.com (2603:1096:4:96::19) by
 SG2PR02MB2461.apcprd02.prod.outlook.com (2603:1096:3:1d::17) with
 Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.3654.12; Wed, 9 Dec 2020 02:39:42 +0000
Received: from SG2PR02MB4108.apcprd02.prod.outlook.com
 ([fe80::dcd:13c1:2191:feb7]) by SG2PR02MB4108.apcprd02.prod.outlook.com
 ([fe80::dcd:13c1:2191:feb7%7]) with mapi id 15.20.3654.012; Wed, 9 Dec 2020
 02:39:42 +0000
From: Huang Jianan <huangjianan@oppo.com>
To: linux-erofs@lists.ozlabs.org
Subject: [PATCH v4] erofs: avoid using generic_block_bmap
Date: Wed,  9 Dec 2020 10:39:30 +0800
Message-Id: <20201209023930.15554-1-huangjianan@oppo.com>
X-Mailer: git-send-email 2.25.1
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [58.252.5.72]
X-ClientProxiedBy: HK2PR04CA0088.apcprd04.prod.outlook.com
 (2603:1096:202:15::32) To SG2PR02MB4108.apcprd02.prod.outlook.com
 (2603:1096:4:96::19)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from localhost.localdomain (58.252.5.72) by
 HK2PR04CA0088.apcprd04.prod.outlook.com (2603:1096:202:15::32) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.3654.12 via Frontend Transport; Wed, 9 Dec 2020 02:39:41 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 7ee02ae2-80fb-4aa6-9e8a-08d89bebaeb3
X-MS-TrafficTypeDiagnostic: SG2PR02MB2461:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <SG2PR02MB24618AD06128FC0F50BF98C4C3CC0@SG2PR02MB2461.apcprd02.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:525;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: haN0CUqS0dZNJ46+tAr+aA5y4WB/YUne4cGMrg7R0wGMWjBVRwBTRqLDiq5sbv/YdDzZjpZX5oY77+kACxnaZjgteTKXRK4r8FTVEuhcDlZPDnYiOPdRgPrhU9S6L/9Lqs/BHYXqOVi0l6Uf372OUKpI68KWlB/yEnqSJAYMYDu04JQqzxr51KFwZKRA4J2Aw5A6hrKpzhEd3+IokeG9lTdsqOQASyCFJa44o2N+sXVUz606WNGRP2roOH55crXp/tCykYwe10m8/aDq1FKxudRvczs8VKEIo4oCslVmB2nq8sggBul/YudXLQfoaQBqOhu2ESJH9sPY1lI7eGbdKE5CyxC84EBHibF4Bi8K0USUh0IGn1c+5YwNulzZVf7lluGLB7oAkzTucoe3y63tdvy32zfpayNcy7JZiXV3WKgPt8+y+p2ha1TgycT/qMxtNBGadiJWs03QGa7xC225vQ==
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:SG2PR02MB4108.apcprd02.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(4636009)(136003)(376002)(366004)(346002)(34490700003)(508600001)(86362001)(36756003)(5660300002)(956004)(8676002)(8936002)(2616005)(1076003)(69590400008)(6666004)(16526019)(6506007)(52116002)(2906002)(83380400001)(6916009)(6486002)(66946007)(66556008)(66476007)(6512007)(4326008)(186003)(26005)(11606006)(41533002);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData: =?us-ascii?Q?F+TcP43WRdo7TYsMALSg34AijSzvZI26eCJV67wjZzMomwpbqt0w7WM53G/6?=
 =?us-ascii?Q?m3pr8z167t1ymZT3ypmf8obJT8B1hPAtV8upob/q5n50ov41lWvu/fvOSBgk?=
 =?us-ascii?Q?24FP2oqp6NW1wueZPG92aMRskzAtV034OvOKi2wxOujOw8oi0cR53MX4CtqI?=
 =?us-ascii?Q?Qi9OO1g5zxxvHssStOxzM4xEyIt4cRhu5s6Vf/+VS2vMuNc86yJ95MrTxINI?=
 =?us-ascii?Q?9UZ5i1hopcBRP3bAkhAwHCs+n5ALwbLu6LyAXmAlc9CHUxpWs89ucfsh7sGj?=
 =?us-ascii?Q?Mr2HBs/7r3OlS4f9S0gFjgy6w7j7DXLHXh+2ecUUQvM/rW+jVgiaE3ygEP/c?=
 =?us-ascii?Q?Dmo/vIjjcMu0XzYZ6OoEDZCZvb6NgR6Qk0QKobEuelLdIXPjiUUEOqzvEIgf?=
 =?us-ascii?Q?l0OYRQrQaO3HFsmhjUjuhBLKwQJ31qzDjZftw72Lc6qzvP5iBJVEoqwZAsRI?=
 =?us-ascii?Q?lbr/8gZBC0yf9caRTHc7rktP5yYsceuD72fJAEDBxzTiocKr0x10WsYqYluy?=
 =?us-ascii?Q?bjWoKMR7V4k+Z/65YDY5IZqmVKh/24pf78qF0whuqc6pL9AqUUFRaaczOh42?=
 =?us-ascii?Q?qECCr+QyiBPB4JUXeAK6Ihsqm71+yGJnRkoj/VGSkYKKcb8gclVeKRoFJPVf?=
 =?us-ascii?Q?94kPmzc/UNTgBUeUgqcBJwVt8mNpaOHv6Vr+zSKwEvRJoQEIGECCNnHvlNJC?=
 =?us-ascii?Q?QaCBBJu7cH0d4F+2+DXkPSDYl0VlRfc4qHTWx3tvfVCyB79xTd3OWH2PAtU4?=
 =?us-ascii?Q?rzCWnZJua2LkiTHw7A0Tax66IOTrJ+gmFxDBvglThX2Ibbq1eoYWZxYDjpqn?=
 =?us-ascii?Q?h5FYIP7Ye3MdpBX13edpMbxdZpnwRifd2IQj15wDLd1jCGbMc7sw8Gcyux06?=
 =?us-ascii?Q?Kevt41aKU94C5Q85uHfTwq3kDExGBdBUzHbXLpSOEBZkSyx4qY+QRHFFj9Iz?=
 =?us-ascii?Q?KD0o7fUvqRhW0OIGl2kvtj7ldpf0B6P3EC7Jn/CodBQ=3D?=
X-OriginatorOrg: oppo.com
X-MS-Exchange-CrossTenant-AuthSource: SG2PR02MB4108.apcprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 Dec 2020 02:39:42.2162 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: f1905eb1-c353-41c5-9516-62b4a54b5ee6
X-MS-Exchange-CrossTenant-Network-Message-Id: 7ee02ae2-80fb-4aa6-9e8a-08d89bebaeb3
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: QLK65YAX5i8bP3wTHDkHtkayf2VUJjPuLZdgq9FLoTID45wLjOHcRKmxeKXVz5nHo3xjMcep7nCpKx0qbrb/bw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SG2PR02MB2461
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
Cc: linux-kernel@vger.kernel.org, guoweichao@oppo.com, zhangshiming@oppo.com
Errors-To: linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org
Sender: "Linux-erofs"
 <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>

iblock indicates the number of i_blkbits-sized blocks rather than
sectors.

In addition, considering buffer_head limits mapped size to 32-bits,
should avoid using generic_block_bmap.

Fixes: 9da681e017a3 ("staging: erofs: support bmap")
Signed-off-by: Huang Jianan <huangjianan@oppo.com>
Signed-off-by: Guo Weichao <guoweichao@oppo.com>
---
 fs/erofs/data.c | 30 ++++++++++--------------------
 1 file changed, 10 insertions(+), 20 deletions(-)

diff --git a/fs/erofs/data.c b/fs/erofs/data.c
index 347be146884c..d6ea0a216b57 100644
--- a/fs/erofs/data.c
+++ b/fs/erofs/data.c
@@ -312,36 +312,26 @@ static void erofs_raw_access_readahead(struct readahead_control *rac)
 		submit_bio(bio);
 }
 
-static int erofs_get_block(struct inode *inode, sector_t iblock,
-			   struct buffer_head *bh, int create)
-{
-	struct erofs_map_blocks map = {
-		.m_la = iblock << 9,
-	};
-	int err;
-
-	err = erofs_map_blocks(inode, &map, EROFS_GET_BLOCKS_RAW);
-	if (err)
-		return err;
-
-	if (map.m_flags & EROFS_MAP_MAPPED)
-		bh->b_blocknr = erofs_blknr(map.m_pa);
-
-	return err;
-}
-
 static sector_t erofs_bmap(struct address_space *mapping, sector_t block)
 {
 	struct inode *inode = mapping->host;
+	struct erofs_map_blocks map = {
+		.m_la = blknr_to_addr(block),
+	};
+	sector_t blknr = 0;
 
 	if (EROFS_I(inode)->datalayout == EROFS_INODE_FLAT_INLINE) {
 		erofs_blk_t blks = i_size_read(inode) >> LOG_BLOCK_SIZE;
 
 		if (block >> LOG_SECTORS_PER_BLOCK >= blks)
-			return 0;
+			goto out;
 	}
 
-	return generic_block_bmap(mapping, block, erofs_get_block);
+	if (!erofs_map_blocks(inode, &map, EROFS_GET_BLOCKS_RAW))
+		blknr = erofs_blknr(map.m_pa);
+
+out:
+	return blknr;
 }
 
 /* for uncompressed (aligned) files and raw access for other files */
-- 
2.25.1

