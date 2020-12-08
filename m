Return-Path: <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>
X-Original-To: lists+linux-erofs@lfdr.de
Delivered-To: lists+linux-erofs@lfdr.de
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2401:3900:2:1::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 7E2BE2D268A
	for <lists+linux-erofs@lfdr.de>; Tue,  8 Dec 2020 09:48:36 +0100 (CET)
Received: from bilbo.ozlabs.org (lists.ozlabs.org [IPv6:2401:3900:2:1::3])
	by lists.ozlabs.org (Postfix) with ESMTP id 4Cqv3P4DwtzDqWT
	for <lists+linux-erofs@lfdr.de>; Tue,  8 Dec 2020 19:48:33 +1100 (AEDT)
X-Original-To: linux-erofs@lists.ozlabs.org
Delivered-To: linux-erofs@lists.ozlabs.org
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized)
 smtp.mailfrom=oppo.com (client-ip=40.107.131.75;
 helo=apc01-sg2-obe.outbound.protection.outlook.com;
 envelope-from=huangjianan@oppo.com; receiver=<UNKNOWN>)
Authentication-Results: lists.ozlabs.org;
 dmarc=pass (p=none dis=none) header.from=oppo.com
Authentication-Results: lists.ozlabs.org; dkim=pass (1024-bit key;
 unprotected) header.d=oppoglobal.onmicrosoft.com
 header.i=@oppoglobal.onmicrosoft.com header.a=rsa-sha256
 header.s=selector1-oppoglobal-onmicrosoft-com header.b=AJmjQ/w/; 
 dkim-atps=neutral
Received: from APC01-SG2-obe.outbound.protection.outlook.com
 (mail-eopbgr1310075.outbound.protection.outlook.com [40.107.131.75])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 4Cqv3G5lCtzDqBK
 for <linux-erofs@lists.ozlabs.org>; Tue,  8 Dec 2020 19:48:25 +1100 (AEDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=NeofkVAaPwwLRl0/zcqc/ptUEprFzP/epsHGudAHYkwRjEQkYH04QNdQh6LBKekXgMs6mnU3mldvcdmEKT/yy087gPX17T4vuOct57kOSwUegtZKnJqDRUZjAH+7HlanBrdwyVOoayR0fOVaaX3rQ0GKebYEogcHch0ZmfsjNUb+zCwgShr6ceF1NCST9lD33hRyIXrVmMWkT+kOqDN+R++vwLIh26V6cdimO8fq/4xjUfjvJu5w6SuZN5Sx3RSaMqJjuQ5q5DgAWh4rnwxDAOm7+qNLD2NaKJj0V8loEKHnwZf1Uc6gxaWSeSk5CrcO02n/2yNQsRA+npiSvG4a3Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=PSDIaCRWrr7+9O1amqJe/tKvjfAUmManVpRfJ/4fvgY=;
 b=H7UGf9wTWsjbU/S1etGKHOfWjXCeo/S3CkvKe89iv5/VWi1NXMZm58MnhRiFnfeF7rLeoWWB6WFvBBdZG1/Jo4jG36RtegcX8wAIVR6Z0J2g+lDxJPA1E+ojoIDLY7F4RRtt6sl5UogULIZqaemulwf5lTw5QhmKXPEmLuHI13BLr+qUBG3H5c55/7auBq/9lYctuXtQKDtAPAuAMbZMm7Qs8AyF7f7YwDO7A20ZiD3/Km2BSQHIc/KSiD8F9w732ztPSzdbQOoY8QeKSTk3+Jz2iz1TeIUx+twSHcOvTrSVUA/Ja5cFD1RhQcl1FND3yuKUO9cWEQQl881u9JBanA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oppo.com; dmarc=pass action=none header.from=oppo.com;
 dkim=pass header.d=oppo.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oppoglobal.onmicrosoft.com; s=selector1-oppoglobal-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=PSDIaCRWrr7+9O1amqJe/tKvjfAUmManVpRfJ/4fvgY=;
 b=AJmjQ/w/zWML0B9nGTURvjcgwVJMdze4wVU+Gf9fpq1JL0Csl/dMh0C/6ZO90rH1FQNsiZ9Izv8vZlF4HOXmtd/Ho4O1VJiRQcjn685Q7EiwOdnBqVBJovsWpx92YbEzn78BKkmMlE3ZOHqeQax/1Tq/cePbQkHwRas40lUcAlE=
Authentication-Results: lists.ozlabs.org; dkim=none (message not signed)
 header.d=none;lists.ozlabs.org; dmarc=none action=none header.from=oppo.com;
Received: from SG2PR02MB4108.apcprd02.prod.outlook.com (2603:1096:4:96::19) by
 SG2PR02MB2988.apcprd02.prod.outlook.com (2603:1096:4:5f::16) with
 Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.3632.21; Tue, 8 Dec 2020 08:48:20 +0000
Received: from SG2PR02MB4108.apcprd02.prod.outlook.com
 ([fe80::dcd:13c1:2191:feb7]) by SG2PR02MB4108.apcprd02.prod.outlook.com
 ([fe80::dcd:13c1:2191:feb7%7]) with mapi id 15.20.3632.021; Tue, 8 Dec 2020
 08:48:19 +0000
From: Huang Jianan <huangjianan@oppo.com>
To: linux-erofs@lists.ozlabs.org
Subject: [PATCH] erofs: fix wrong address in erofs_get_block
Date: Tue,  8 Dec 2020 16:47:50 +0800
Message-Id: <20201208084750.5469-1-huangjianan@oppo.com>
X-Mailer: git-send-email 2.25.1
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [58.252.5.72]
X-ClientProxiedBy: HK2PR06CA0016.apcprd06.prod.outlook.com
 (2603:1096:202:2e::28) To SG2PR02MB4108.apcprd02.prod.outlook.com
 (2603:1096:4:96::19)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from localhost.localdomain (58.252.5.72) by
 HK2PR06CA0016.apcprd06.prod.outlook.com (2603:1096:202:2e::28) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.3632.17 via Frontend Transport; Tue, 8 Dec 2020 08:48:18 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 96bc9664-2c39-41e4-48b5-08d89b5602d4
X-MS-TrafficTypeDiagnostic: SG2PR02MB2988:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <SG2PR02MB2988E0245B95C212DEC91068C3CD0@SG2PR02MB2988.apcprd02.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:580;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: BRFFujqqSCrjXQVvcOC7sqj9XRQUxXhr44J5h2odvCLE/gwETe5VSiVL1CSEiBhVUIqsbOd/6Tmfn1AlBWp5ASs5xVD06Gf/YZIB7FR7iigQuDXfphPrMuDb+COqC1wDZ0CAqM3EoLpCg2Qy3FIaTaJtz6pnaSUbOjwPpKP3HIHhB/lG+3gX+gEqR6MXQuIr1PPw+q38TC60R5CT+IiDIyMfHOYYURKK9bLgK6jDSS0ZElvueZY2xL/awhWH9zWfOxsO4InxmMSv/L9b+gCFbM596P/7inwlZpuSTfgP9DsxWfKHhVBLSXNTFRRM0AjT2Eznovw7xLcpqhSMY2bECWCd2ofNXwsiK9pGfugV5hFVvHFMBBhNFKahdA0/gKzfi91WmFul1I/9bbAB8ccbonaAJvzbmtzji5hVZPUWQcQ=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:SG2PR02MB4108.apcprd02.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(4636009)(366004)(376002)(39860400002)(346002)(396003)(136003)(36756003)(956004)(5660300002)(4326008)(478600001)(83380400001)(107886003)(8676002)(1076003)(69590400008)(2906002)(6506007)(316002)(66476007)(6512007)(66556008)(6486002)(6916009)(16526019)(26005)(2616005)(8936002)(86362001)(66946007)(6666004)(186003)(52116002)(11606006);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData: =?us-ascii?Q?U17aWF56goNtGBlEjIU1iyDcUz8CW+Q2e/3aaBFU01guQHnfztTrm3pOVbeq?=
 =?us-ascii?Q?ya72xh0UYmVjqk8ye2mE7kK/JOlKX5nzRHH+7838h1ki993DZb0u6+AS3CV+?=
 =?us-ascii?Q?OeQBfuQZ26DhxWVxmwiFGd8YQZyw4Tdkac6n/DhKOmVZbePBM9rKFec0lCyP?=
 =?us-ascii?Q?98Do46TwodlRezfTYcftJ19bjc3V/rmk+xLnsTsv7HoeQR5w6WNo8w1EFAHz?=
 =?us-ascii?Q?kkn9c7vMTvfH0qFknra1D47TmbZz5/qfeHsRXu+Ub65x7TQou+473cxjh8JU?=
 =?us-ascii?Q?uYVvNecA/lJuFe3y1I8pd30koWd/60/YoewKYACVlU+PmDBM8ljSENgkKIsH?=
 =?us-ascii?Q?KqrD1+bcltF5o34jjoaAohTM2Y1RqH/QQtSAEXOj1GuDveNzzHDoZeYEIIZw?=
 =?us-ascii?Q?qt5NHXhEeiN0XSJRre7rKN/sQiN6HxD62lmUayU7WLyeJv5EiGkEda52adZj?=
 =?us-ascii?Q?L+qbcg70kDf+6KEFMVwHSsdFlYoZzPNLOmFJcsNWAc5RUExfPv+iX0WJxw49?=
 =?us-ascii?Q?y84B0qzE/jLdTH2Fql7vJK9L6TmnyaDwwfQ7cZwSXPulBVRmTYHhKnE7C+d4?=
 =?us-ascii?Q?LPyQVo5DDkLz89IbYBQACdjbF3lnM9mUNyA8YlgW05wYd/dj51eNu45ExP0v?=
 =?us-ascii?Q?DVE+M1dbmP13IOWs1PAnVGeE5j8sKwI7FVt1t76FnFHdkHmdKfk5IeL8SsOW?=
 =?us-ascii?Q?HUBA0FnH4IE0Jab0e137FCgugxeglKx0v4baafLT1IXyQb76iw56GsKKaOKP?=
 =?us-ascii?Q?ixkk4Ug/2Ya9nPObT1adPml3sh3LjVC3TbKO+Tsnh6bpP429FI2YdRqt27Z4?=
 =?us-ascii?Q?5Kx6QIUdF4x/N1Cdkx9+Yd8aofIZ/jKhGhxfKm9FkBZqgbMiWA/TiDeBM21o?=
 =?us-ascii?Q?zYKL4dETrYWHZUxUO5rIiBYCiVYNQ0VfzfV6Sv9CRXjaLAi2UXDes8kpQxhF?=
 =?us-ascii?Q?sxC+XY/AulxxnlN4exdCrL5Fk9loVfUf7wE6ntIzwx4=3D?=
X-OriginatorOrg: oppo.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 96bc9664-2c39-41e4-48b5-08d89b5602d4
X-MS-Exchange-CrossTenant-AuthSource: SG2PR02MB4108.apcprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 08 Dec 2020 08:48:19.2423 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: f1905eb1-c353-41c5-9516-62b4a54b5ee6
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: VF1F3O+XQrft1YyRmOXos6R19ApaZV3XSEFss2Qn5VpcrFISEtMv4D9o+dvVRkA/1F6MFaLVYrUmVE4Jc0xTmw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SG2PR02MB2988
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
Cc: guoweichao@oppo.com, zhangshiming@oppo.com
Errors-To: linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org
Sender: "Linux-erofs"
 <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>

iblock indicates the number of i_blkbits-sized blocks rather than
sectors, fix it.

If the data has a disk mapping, map_bh should be used to read the
correct data from the device.

Fixes: 9da681e017a3 ("staging: erofs: support bmap")
Signed-off-by: Huang Jianan <huangjianan@oppo.com>
Signed-off-by: Guo Weichao <guoweichao@oppo.com>
---
 fs/erofs/data.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/fs/erofs/data.c b/fs/erofs/data.c
index 347be146884c..1415fee10180 100644
--- a/fs/erofs/data.c
+++ b/fs/erofs/data.c
@@ -316,7 +316,7 @@ static int erofs_get_block(struct inode *inode, sector_t iblock,
 			   struct buffer_head *bh, int create)
 {
 	struct erofs_map_blocks map = {
-		.m_la = iblock << 9,
+		.m_la = iblock << blknr_to_addr(iblock),
 	};
 	int err;
 
@@ -325,7 +325,7 @@ static int erofs_get_block(struct inode *inode, sector_t iblock,
 		return err;
 
 	if (map.m_flags & EROFS_MAP_MAPPED)
-		bh->b_blocknr = erofs_blknr(map.m_pa);
+		map_bh(bh, inode->i_sb, erofs_blknr(map.m_pa));
 
 	return err;
 }
-- 
2.25.1

