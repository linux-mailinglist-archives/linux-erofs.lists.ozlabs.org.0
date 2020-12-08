Return-Path: <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>
X-Original-To: lists+linux-erofs@lfdr.de
Delivered-To: lists+linux-erofs@lfdr.de
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2401:3900:2:1::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 45AEB2D2BB1
	for <lists+linux-erofs@lfdr.de>; Tue,  8 Dec 2020 14:12:51 +0100 (CET)
Received: from bilbo.ozlabs.org (lists.ozlabs.org [IPv6:2401:3900:2:1::3])
	by lists.ozlabs.org (Postfix) with ESMTP id 4Cr0wH6LjXzDqJ1
	for <lists+linux-erofs@lfdr.de>; Wed,  9 Dec 2020 00:12:47 +1100 (AEDT)
X-Original-To: linux-erofs@lists.ozlabs.org
Delivered-To: linux-erofs@lists.ozlabs.org
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized)
 smtp.mailfrom=oppo.com (client-ip=40.107.130.85;
 helo=apc01-hk2-obe.outbound.protection.outlook.com;
 envelope-from=huangjianan@oppo.com; receiver=<UNKNOWN>)
Authentication-Results: lists.ozlabs.org;
 dmarc=pass (p=none dis=none) header.from=oppo.com
Authentication-Results: lists.ozlabs.org; dkim=pass (1024-bit key;
 unprotected) header.d=oppoglobal.onmicrosoft.com
 header.i=@oppoglobal.onmicrosoft.com header.a=rsa-sha256
 header.s=selector1-oppoglobal-onmicrosoft-com header.b=R+eyxSfH; 
 dkim-atps=neutral
Received: from APC01-HK2-obe.outbound.protection.outlook.com
 (mail-eopbgr1300085.outbound.protection.outlook.com [40.107.130.85])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 4Cr0tr4yTDzDq96
 for <linux-erofs@lists.ozlabs.org>; Wed,  9 Dec 2020 00:11:32 +1100 (AEDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Oa2fKd9XFnPoHzQQ5G5Q6YpBrVQExNj+Mh6qO54TX4VGoWxdsqLvObz9IsoCckOztQtm65XQdqKYCMLjKXMBQvZdj1H6N+pxapueMCzCqcQWOMJDJ6bdx8Unq4Xvps1EXibaiOp8+25mfwpE6msZsWJTKW2Q9E5oc/0ZslTCg68rfUbd6Og8SLrW9LNHs86cdbb/Uiw89XP2LfKUtnI69DSvQGLbbZrTS1Xs6OHAzaaDpONAd+KSBWPQdaD47B293EqEqlP0iFaPcaaAcCuwckFitr8CGIP/2k0iV2HEw4lGxd/rr3vt40+8Smf2Nf+NAeNLMpHljDRu7kAXFIDECQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=T84rqwwoXaSCjvBtKUyzcf+bMHFTDRXpjSg9iuI3Vn8=;
 b=EjuQEgzFjWBYF5UPA6kWigg2p63mdC7V8jjHklqF5Bu5hlSIRkyrYqmRC2hhWlYHMKyLaBxlb1826T1N2hFCjsPlu0nzrDXg0vjghb9xqbnDGwi5RBGstq16CcQO+idaoyMNRq9LbPVpkL1lpaJUCaZDBYL+kf1EgsALUVqgt6+tYlMQj7mHxGcepoWwEaU8eAH75Yvv7/8Bg9AMuCPRXD6+izYzkevvKXpI1rOrFwIFgvBlTy/5wb/vWpnm/V13ck3BDwVSo+WFiKXhEY5ThUvt2AgtSFk1sFPk1K1BVvTi4P2LKRtHnt9pV11wtm59DSqKP1+ngNpAHGJ7TzE+Bg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oppo.com; dmarc=pass action=none header.from=oppo.com;
 dkim=pass header.d=oppo.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oppoglobal.onmicrosoft.com; s=selector1-oppoglobal-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=T84rqwwoXaSCjvBtKUyzcf+bMHFTDRXpjSg9iuI3Vn8=;
 b=R+eyxSfHK41IlGjlmZ0GmYMZ3o5JImmcvUz2+sr2VJctWx+k+YE31ok6cZax1GnMxlGgJefCChmANzsDRSCoKHl1FvVcpa2dm3E+kudn8AcBfJV5e8F94bZr9crMMEikIr5vyhkeoidE16yW+j6D9uZyDcWhujDPw8KCS/hBCHI=
Authentication-Results: lists.ozlabs.org; dkim=none (message not signed)
 header.d=none;lists.ozlabs.org; dmarc=none action=none header.from=oppo.com;
Received: from SG2PR02MB4108.apcprd02.prod.outlook.com (2603:1096:4:96::19) by
 SG2PR02MB2559.apcprd02.prod.outlook.com (2603:1096:3:27::11) with
 Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.3632.19; Tue, 8 Dec 2020 13:11:21 +0000
Received: from SG2PR02MB4108.apcprd02.prod.outlook.com
 ([fe80::dcd:13c1:2191:feb7]) by SG2PR02MB4108.apcprd02.prod.outlook.com
 ([fe80::dcd:13c1:2191:feb7%7]) with mapi id 15.20.3632.021; Tue, 8 Dec 2020
 13:11:21 +0000
From: Huang Jianan <huangjianan@oppo.com>
To: linux-erofs@lists.ozlabs.org
Subject: [PATCH v3] erofs: avoiding using generic_block_bmap
Date: Tue,  8 Dec 2020 21:11:08 +0800
Message-Id: <20201208131108.7607-1-huangjianan@oppo.com>
X-Mailer: git-send-email 2.25.1
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [58.252.5.72]
X-ClientProxiedBy: HKAPR03CA0025.apcprd03.prod.outlook.com
 (2603:1096:203:c9::12) To SG2PR02MB4108.apcprd02.prod.outlook.com
 (2603:1096:4:96::19)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from localhost.localdomain (58.252.5.72) by
 HKAPR03CA0025.apcprd03.prod.outlook.com (2603:1096:203:c9::12) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.3654.7 via Frontend Transport; Tue, 8 Dec 2020 13:11:20 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 575dacd1-8846-477f-0713-08d89b7ac1a5
X-MS-TrafficTypeDiagnostic: SG2PR02MB2559:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <SG2PR02MB2559CBE36D3B22D04AD78AC4C3CD0@SG2PR02MB2559.apcprd02.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:525;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: Si0JVNV3DVO2u3bVyi8HBuoVQYOZWO4YGdGGB9Vrm1eSUzcpw7a0sBFLseoXeoUSEvgQZpssSgCOp+U0/gT9s30XKTQRng+ENq+GqrPTXyU23Xi/0a0zInlBcuCwcKH9Qmdn4f29srHCqQ9XK9oDfYum5/D+F1+Mm6ZKHlbqTP52N7KQNTdVlp8/CkbRz3Tv6xTwe21GurniDCzDSnCJHJ0joUr+Qcvosu1TFdiS6am4VMn82EykL4f92pGxaM6n8GagTxSKJ3eMab2/+dk+yOY9/r9MGHAS3cZCoxPMNQCz5twBQ1ocrrz+4R9tOMK8wWalsZ2+ziWvrNXAlbH9aZmNk6CgVSoXi4/mRsl6MeeyQ6yGFtGXHWZIaQKToaTwG/J4fBIqZ+41ayeMR8QRl/eh3lGmis7PP5ni7Bl6X0e9dKpd9QsqHndrc2sjUdrVt5NynwqdBYuarPGCiZUpSQ==
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:SG2PR02MB4108.apcprd02.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(4636009)(376002)(136003)(366004)(346002)(4326008)(8676002)(2906002)(16526019)(186003)(6486002)(6916009)(6666004)(83380400001)(52116002)(8936002)(69590400008)(86362001)(66946007)(6512007)(34490700003)(5660300002)(36756003)(66556008)(1076003)(26005)(508600001)(956004)(2616005)(66476007)(6506007)(41533002)(11606006);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData: =?us-ascii?Q?NayTG/iDJTk1mvAGGGv+zc4fPpLc17BW12+LC3LVDJprAN2Grk8BdDk9hwpO?=
 =?us-ascii?Q?KXfnp9nytBFHGQtYeiWSCyx7HDkub3UfZm2vWtTaEWq7hQ4Y/T+Ir6Fu2E3r?=
 =?us-ascii?Q?MT6Avw+A9GZIiKLDTjpTokq122LTpXXlPYUdQPFAby2Omtr+k7tKx4n8vH2z?=
 =?us-ascii?Q?fEBtVwvUcsXo8/lsCob66nq5F9Rc3zRPWU+6/reyr72Kb93VuvKqMzaEx7lf?=
 =?us-ascii?Q?M5sp6du8irQ8qD51wy6lAGqGmnQeWCy1V0NKwx1wyCk09lP8IGJ1yKGeSF8t?=
 =?us-ascii?Q?wmL4pDpJEb1MSerfZmQnmZzsOO5DAs8CMiVytGr3aKOHQdZ+3TjdnS462qrU?=
 =?us-ascii?Q?T4EOYi68E3XtkaYoWB0znNi6AOOwM2fcQgBMSxPbET6sf9e8jL7Ka+RnFuI4?=
 =?us-ascii?Q?bc4iDZB/HZ15QFnQtgIswvnj7eX/3jvA8DOpKvYQkwbNSlbl1esEaBKESMBx?=
 =?us-ascii?Q?6BAbC189WJKdE1RthDJV2v5D8YV1VDAIAbd8WD91Sin0uV1xmWArBYgCqrbH?=
 =?us-ascii?Q?t3pZyQAM24J7IFvu3XMiowjxN3EOgJrUEGffzn7b2Q/1pIqCXn55jkw0W93s?=
 =?us-ascii?Q?pWjbRzu1EBky8/CCMVvlc6ClAPf5V6bbH2lj4I2Fyc9yWooQeqffuO0PGUFc?=
 =?us-ascii?Q?O7BJwKOkUP2rCq8wd6vDCVzMeGk7y4/t3jeE/8F6GqNcEG08hJw9WqwgzYp4?=
 =?us-ascii?Q?yBMqNGGNJJIhXt5LS72eo9WYFeV5+9w65wRyTuyEYz/SlgFolkUIcWVXvqUv?=
 =?us-ascii?Q?GoY9jiYxSGNcEjg0QQAe0EiXYSnu8Fx64q/ZGqVG4R7xZRf0FoHXwH6Pq4fr?=
 =?us-ascii?Q?tsqFlBKu8U9cO6mXf/+Du5ce4jV50MK5JD7XKrS0mNjt+j+Gek6Yn8Lqr2JP?=
 =?us-ascii?Q?ZMS4Vdf+G0hoWjuidG09GpmMm7wb5k3sdsBA/QMkmrM9L2NNUXh6E2aMSmq1?=
 =?us-ascii?Q?N6w5FGztoxeBPPR4xSGkARaY3+y8HVRcAkMzdcpeAZo=3D?=
X-OriginatorOrg: oppo.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 575dacd1-8846-477f-0713-08d89b7ac1a5
X-MS-Exchange-CrossTenant-AuthSource: SG2PR02MB4108.apcprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 08 Dec 2020 13:11:21.2517 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: f1905eb1-c353-41c5-9516-62b4a54b5ee6
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: nKkouskF8/mUBffIsh/BK4BWPHuhD22RCR9G0YZAw9bAil5xtVsp93CrtWpoPm+tU5ugGkz142gnsHF11zXR+w==
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
 fs/erofs/data.c | 30 ++++++++++--------------------
 1 file changed, 10 insertions(+), 20 deletions(-)

diff --git a/fs/erofs/data.c b/fs/erofs/data.c
index 347be146884c..399ffd857c50 100644
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
+		.m_la = blknr_to_addr(iblock),
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

