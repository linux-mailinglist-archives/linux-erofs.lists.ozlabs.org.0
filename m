Return-Path: <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>
X-Original-To: lists+linux-erofs@lfdr.de
Delivered-To: lists+linux-erofs@lfdr.de
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2401:3900:2:1::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 69BC42D418C
	for <lists+linux-erofs@lfdr.de>; Wed,  9 Dec 2020 12:59:32 +0100 (CET)
Received: from bilbo.ozlabs.org (lists.ozlabs.org [IPv6:2401:3900:2:1::3])
	by lists.ozlabs.org (Postfix) with ESMTP id 4CrbFF0mHCzDqq5
	for <lists+linux-erofs@lfdr.de>; Wed,  9 Dec 2020 22:59:29 +1100 (AEDT)
X-Original-To: linux-erofs@lists.ozlabs.org
Delivered-To: linux-erofs@lists.ozlabs.org
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized)
 smtp.mailfrom=oppo.com (client-ip=40.107.131.84;
 helo=apc01-sg2-obe.outbound.protection.outlook.com;
 envelope-from=huangjianan@oppo.com; receiver=<UNKNOWN>)
Authentication-Results: lists.ozlabs.org;
 dmarc=pass (p=none dis=none) header.from=oppo.com
Authentication-Results: lists.ozlabs.org; dkim=pass (1024-bit key;
 unprotected) header.d=oppoglobal.onmicrosoft.com
 header.i=@oppoglobal.onmicrosoft.com header.a=rsa-sha256
 header.s=selector1-oppoglobal-onmicrosoft-com header.b=X7OvGF6S; 
 dkim-atps=neutral
Received: from APC01-SG2-obe.outbound.protection.outlook.com
 (mail-eopbgr1310084.outbound.protection.outlook.com [40.107.131.84])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 4CrbCm6XH5zDqZC
 for <linux-erofs@lists.ozlabs.org>; Wed,  9 Dec 2020 22:58:11 +1100 (AEDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=IYkZQiGsgMETgh0SwK3q0JEJV/6TffvrvT2J/zwAx3fCl77YY1QsVH3yqgwDzJ8aEYlRe4T1M9x5X2QobGu2Qidt4ZanD9jr/L37gM7Tc26CLVBamEXWXAHQCJZ2Psn/6KH/fHv5vIWUwUxVMf+UJ19INOMPQwmctC2XApU5/wWNPi4mzQsXL/nwmnHCW1+y1pi4/KCnb+I6o838tCN/mQLUunVkJiTLJvxaai2j6vGHI70FOcJ2IGGbLSEPXMZjl6ALm5uO0MUQYZoDNOfD6VmUjjo38P7FOSgqgMPNor2R8GnZmh/PBwyX1glpeZWRCTPRn08RL1JranlZK71nEA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Ke/7zqoWtPar/bnT5PwSZO//Zr9ZzmItjeD/Z4qwMIQ=;
 b=CZCfEXCCLR11pEmZufMjBH8vtX8wzByNV1Yv27VfjZ/nrqR+kuTBZha8FWxSVlCnPoE0mDiYl+RtaM/kM8VHR6WdFegVpWXGmERfW2K5gVe1gEf1gE7yDbJ+W08ZdZF1Pq7aJ0CpVyn1SQSX3jYwBNcs3GSS0Pi5aGtcmhh9a8yVBqmwtWvJ+ycEgIkoO5kUq2SEcLyooL+zbxebzDms39n52aUmoF7rEaiUYvtKA9IszJKWULN++HaY1M60dlsR2lsHX//a/xDmOde3mhS4Le8JvCTNuvkxpep0BzFuUzdequ0b52a1nGFrgo71YPQjbX4lyL95f/Ck2yQlXUgzLw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oppo.com; dmarc=pass action=none header.from=oppo.com;
 dkim=pass header.d=oppo.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oppoglobal.onmicrosoft.com; s=selector1-oppoglobal-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Ke/7zqoWtPar/bnT5PwSZO//Zr9ZzmItjeD/Z4qwMIQ=;
 b=X7OvGF6SXx3qh/Fl00mxd2zvCRq8IjCKbibJwoZkP/vurz71L24TlyNvmC7i3YI3W9qXek15TfxCiPfY/6mb4ArWSXqta+9smGxZb/g6n8zm1vgxmIRMfwObqayT8rkGJWzVGct4NsC2SQ8AZJLj6vIvtUcdHruWnk7I/slIZX0=
Authentication-Results: lists.ozlabs.org; dkim=none (message not signed)
 header.d=none;lists.ozlabs.org; dmarc=none action=none header.from=oppo.com;
Received: from SG2PR02MB4108.apcprd02.prod.outlook.com (2603:1096:4:96::19) by
 SG2PR02MB2559.apcprd02.prod.outlook.com (2603:1096:3:27::11) with
 Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.3632.19; Wed, 9 Dec 2020 11:58:04 +0000
Received: from SG2PR02MB4108.apcprd02.prod.outlook.com
 ([fe80::dcd:13c1:2191:feb7]) by SG2PR02MB4108.apcprd02.prod.outlook.com
 ([fe80::dcd:13c1:2191:feb7%7]) with mapi id 15.20.3654.012; Wed, 9 Dec 2020
 11:58:04 +0000
From: Huang Jianan <huangjianan@oppo.com>
To: linux-erofs@lists.ozlabs.org
Subject: [PATCH v5] erofs: avoid using generic_block_bmap
Date: Wed,  9 Dec 2020 19:57:40 +0800
Message-Id: <20201209115740.18802-1-huangjianan@oppo.com>
X-Mailer: git-send-email 2.25.1
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [58.255.79.104]
X-ClientProxiedBy: HKAPR03CA0017.apcprd03.prod.outlook.com
 (2603:1096:203:c8::22) To SG2PR02MB4108.apcprd02.prod.outlook.com
 (2603:1096:4:96::19)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from localhost.localdomain (58.255.79.104) by
 HKAPR03CA0017.apcprd03.prod.outlook.com (2603:1096:203:c8::22) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.3654.8 via Frontend Transport; Wed, 9 Dec 2020 11:58:03 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: db711528-6fe6-4e83-6f73-08d89c39af75
X-MS-TrafficTypeDiagnostic: SG2PR02MB2559:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <SG2PR02MB2559F9E30B888B23890DFAEAC3CC0@SG2PR02MB2559.apcprd02.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:525;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 2HwKS+MEZ94i0vPwcwZnJayUt6nROuj1ZpQAJK7eSLRxUsqytffXVOPlnIDih2Csp1p4bJJ3WmBgM+sHgkwjuwsQkS8OgKsmZ81NUdz2KJM8d5A3fMs7TkL1th6InsjPc2zoKxFftxsO0ukTy0m+PPrG+Z7HFXlhjogoXPBopoz9aObLiYH+gtkjLmE2tT+2OiqmDDHB/mOT9F/BZdLS5V7vey/EEbLvr05tOuU+o2Gw0e1UYf5M8Iyezx7HeJwYxHsElcvsPl/czilQjgkanQB/tv5Jl5RS8AgqiMvBENxrdTO8y6zhmRI699pbrp3IEXZo32MV3JMjXm/OVxwSjYth6iJEhiAUkI+zWJmof7S/ogE5KxxWd+bsYtrFPzaHEKayQ8cV0kUlVmktuuae9xuKhyNTCnii8KDAyKoQbGvIvQ1sKpCgVqSxAXEBI8im2Awb6EL46L7heL3zHuORdg==
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:SG2PR02MB4108.apcprd02.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(4636009)(366004)(376002)(346002)(136003)(34490700003)(5660300002)(6666004)(83380400001)(6506007)(956004)(86362001)(6512007)(1076003)(26005)(186003)(36756003)(16526019)(508600001)(69590400008)(6916009)(8936002)(66556008)(4326008)(6486002)(2906002)(66946007)(52116002)(2616005)(66476007)(8676002)(41533002)(11606006);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData: =?us-ascii?Q?NCdQ2pmYLE1Fkn+s2tUDay9eDzaZKvv/gooToXVBoAzd248hBYax04siopoc?=
 =?us-ascii?Q?0b/04vtphPTUx/IHjUNzBlrkQerBxdLmx4r5honjw2/mE3LXRe1oGafzb8V+?=
 =?us-ascii?Q?WVvxC/utd68y+G29NEueVXgF4emA8+WIscjEIxj1eJg91P0ylbq5SdhNxfnb?=
 =?us-ascii?Q?TC3iSLEjeuXq4I7aRMR6wsXRjCqoIU/g30AG2O/mWHxArjFli+tBTmk0V2jM?=
 =?us-ascii?Q?poMmCYmB7b8EIKlfxIqb5t8D89/CXuNMGE9+f3W037zaZ8dueXKwjvk0SuUu?=
 =?us-ascii?Q?sBrzqpUhMguWes6jfy4bgoBuzM4trvRbsWhX+an2EgAwBTH9QVRjJNK9Umx7?=
 =?us-ascii?Q?6aV8LmrwLLHqOcAlZt54toCHCZKAA3Aj0k18mzcHtogZDniSx9E3mqT795Jk?=
 =?us-ascii?Q?AoGY6b25rMKXldVmiNUtSUzXUf6NjSG+TI2xLSX7R4y0eL3qtqn0pvEiwENJ?=
 =?us-ascii?Q?DK6oZC6HIlvTilSmGE+G3C6elMGIkgUBeWbzFVtTCLOnQKcyMWxhFlfMyODM?=
 =?us-ascii?Q?ziGbYcdhHJEHFO6FVxUmH+qv3tY/72cWrpR8yBqsFRlu0B/wl7E6BpQ4eQff?=
 =?us-ascii?Q?Sl1QChSJ4vUt9qgCCt+pKbvfASCZJD5pMuXm8FfxIs8/jE55e3u7AJFaFSG3?=
 =?us-ascii?Q?xNYWx66/vlUR2sA8JGuDfUNFryvcekAQoYI8/3fatIkMyE1p9AQYdBoKuA9z?=
 =?us-ascii?Q?J0+FSqA3ulNDgTaZjU+o6tIet211OuGvgX5+CPiemZzaFlphIVml4KRQnunm?=
 =?us-ascii?Q?tv+tzU+8j4p7fF7uWlO/6Q6eTV5zhGrKhGjKZDCmVukDz0rcXa8Bq7wEq+Aj?=
 =?us-ascii?Q?Jt9uffCms/ZHA6j9k7KltVSypgY07ZD0sTS6I4qU9RIOH2JKKgp7pTSzJOjI?=
 =?us-ascii?Q?eQ6PMk5VNkjp6JXi7udKu56jVDzEkUiXUmS7Jbljd3zDqAY0WVB78voRULVt?=
 =?us-ascii?Q?FjtF+UY/UxspUO6HP2/Bfdz75DIC3gOVSW3gXkV0MorfiPlyooLf9YxjQywX?=
 =?us-ascii?Q?lVPu?=
X-OriginatorOrg: oppo.com
X-MS-Exchange-CrossTenant-AuthSource: SG2PR02MB4108.apcprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 Dec 2020 11:58:04.2923 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: f1905eb1-c353-41c5-9516-62b4a54b5ee6
X-MS-Exchange-CrossTenant-Network-Message-Id: db711528-6fe6-4e83-6f73-08d89c39af75
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: LeTszkJlMiT3zDi5URFHdw3GjYvsKBe2O7GrZ4bUdlWBBEmssjrcjvKDV4J3cRzayPXVD4KndkGlAy6AvSv/RQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SG2PR02MB2559
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
 fs/erofs/data.c | 26 +++++++-------------------
 1 file changed, 7 insertions(+), 19 deletions(-)

diff --git a/fs/erofs/data.c b/fs/erofs/data.c
index 347be146884c..ea4f693bee22 100644
--- a/fs/erofs/data.c
+++ b/fs/erofs/data.c
@@ -312,27 +312,12 @@ static void erofs_raw_access_readahead(struct readahead_control *rac)
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
 
 	if (EROFS_I(inode)->datalayout == EROFS_INODE_FLAT_INLINE) {
 		erofs_blk_t blks = i_size_read(inode) >> LOG_BLOCK_SIZE;
@@ -341,7 +326,10 @@ static sector_t erofs_bmap(struct address_space *mapping, sector_t block)
 			return 0;
 	}
 
-	return generic_block_bmap(mapping, block, erofs_get_block);
+	if (!erofs_map_blocks(inode, &map, EROFS_GET_BLOCKS_RAW))
+		return erofs_blknr(map.m_pa);
+
+	return 0;
 }
 
 /* for uncompressed (aligned) files and raw access for other files */
-- 
2.25.1

