Return-Path: <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>
X-Original-To: lists+linux-erofs@lfdr.de
Delivered-To: lists+linux-erofs@lfdr.de
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	by mail.lfdr.de (Postfix) with ESMTPS id 6E53A40228D
	for <lists+linux-erofs@lfdr.de>; Tue,  7 Sep 2021 05:54:27 +0200 (CEST)
Received: from boromir.ozlabs.org (localhost [IPv6:::1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4H3Wc12Cryz2yHJ
	for <lists+linux-erofs@lfdr.de>; Tue,  7 Sep 2021 13:54:25 +1000 (AEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=lists.ozlabs.org;
	s=201707; t=1630986865;
	bh=dsMQ0GIjZFsnQ+phqxLXaVb3PsofZ+l9Pm+U+muSTGk=;
	h=To:Subject:Date:In-Reply-To:References:List-Id:List-Unsubscribe:
	 List-Archive:List-Post:List-Help:List-Subscribe:From:Reply-To:Cc:
	 From;
	b=fl3ac8slTAzBoJQFsU5qukydwySdKzeaIfiwwvwp1W6fZu7x6gWxGH5qqgOkLQ07a
	 h2WKyZkSNzrSPWvK1ApIragXR7uYAlBiDybl+Tjd7R9fNknNu3Zt90/EFepPucoIFn
	 x8+lE2RQm/9IK+ldwBBHhJKIhE4xeLLzWT7KVnwDAF0xFY7ggHKVRfQkB+tCxBrQg9
	 K0KTrY2oOCriY994RgM9Rao82PUIzdLmwiegIy6lXet9fTABX74crSK3WJrrwObdAr
	 +FrC2Yn2JemiapqgU3MWVz9iN2gWqJce1gV/az/9SOQ4NtK/tpsveQ5GUMBgS+l4lB
	 4bhHTYvpndnLw==
X-Original-To: linux-erofs@lists.ozlabs.org
Delivered-To: linux-erofs@lists.ozlabs.org
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized)
 smtp.mailfrom=oppo.com (client-ip=40.107.130.89;
 helo=apc01-hk2-obe.outbound.protection.outlook.com;
 envelope-from=huangjianan@oppo.com; receiver=<UNKNOWN>)
Authentication-Results: lists.ozlabs.org; dkim=pass (1024-bit key;
 unprotected) header.d=oppo.com header.i=@oppo.com header.a=rsa-sha256
 header.s=selector1 header.b=h0v4pmre; 
 dkim-atps=neutral
Received: from APC01-HK2-obe.outbound.protection.outlook.com
 (mail-eopbgr1300089.outbound.protection.outlook.com [40.107.130.89])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 4H3Wbs1xxfz2xY2
 for <linux-erofs@lists.ozlabs.org>; Tue,  7 Sep 2021 13:54:15 +1000 (AEST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=a2ciBuTi3FGHoEUeZYt4USaahNTCpocVIL/Qkcl0PBu+oaZLmg/0YeIUOwfrsdyiUyU5vsRUTFdU8pFT2z5E1rEEEMr9PNKs4uPlE+1P953QfpAsWvJiYJZh8luJRn7uk+lDh5arZQrZ5voxt6gE09a2av1N4f6ouf2Zm3fWCOaVZBBqBAduldzY8CWyev7Ar7JsXXX9XkAI7fVYAkC4nM3RE+2uEHzM7d7aW2x7eWMGhNF7DtgcHC45RQ6dgAdFpztcQV8z0GL+FXJRtUWSd0+peBgx5wSYa80kaEhz4+ljO/aEvCkJOK+LUuS8Yfo268JuY7rmfCAt19U/4XDYRw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version; 
 bh=dsMQ0GIjZFsnQ+phqxLXaVb3PsofZ+l9Pm+U+muSTGk=;
 b=gtZ7+o9Du6+bgxy72qHl6Hxa7OPXxa/lzUs08n/yBXUF7cQhDlHINDCOQ3VYFfv3PcMumZa0KAlO00qJC+yJwjPqDh9MfnmDB1kZD8+qakPJ7GNbLgudndnDxP7w4MLnea6HRhG2ZenxgtjjkQQ1nsPNouXh1YcmrZBUH8/qc8apekEu+dyFswf+VpdJrzMfheoDfHSvWEEv6oB6cgaXvHh3s5u5+wpgf9Oq47zgBSq6Xb4i9SrvBFvnM6fYDYw9X66fX7WoSFpwD9kKEUguDlPEOTQRa9Hslbo09c2+n5wxqWsG3VoqSyLwwYoieOxZ6YVJNK9LBFSdwXn+0F6OtA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oppo.com; dmarc=pass action=none header.from=oppo.com;
 dkim=pass header.d=oppo.com; arc=none
Authentication-Results: lists.ozlabs.org; dkim=none (message not signed)
 header.d=none;lists.ozlabs.org; dmarc=none action=none header.from=oppo.com;
Received: from SG2PR02MB4108.apcprd02.prod.outlook.com (2603:1096:4:96::19) by
 SG2PR0201MB2206.apcprd02.prod.outlook.com (2603:1096:3:4::8) with
 Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.4478.21; Tue, 7 Sep 2021 03:53:55 +0000
Received: from SG2PR02MB4108.apcprd02.prod.outlook.com
 ([fe80::5919:768f:2950:9504]) by SG2PR02MB4108.apcprd02.prod.outlook.com
 ([fe80::5919:768f:2950:9504%4]) with mapi id 15.20.4478.025; Tue, 7 Sep 2021
 03:53:55 +0000
To: linux-erofs@lists.ozlabs.org
Subject: [PATCH V2] erofs-utils: fix random data for block-aligned
 uncompressed file
Date: Tue,  7 Sep 2021 11:53:45 +0800
Message-Id: <20210907035345.22735-1-huangjianan@oppo.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20210906081359.17440-2-huangjianan@oppo.com>
References: <20210906081359.17440-2-huangjianan@oppo.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: HKAPR03CA0035.apcprd03.prod.outlook.com
 (2603:1096:203:c9::22) To SG2PR02MB4108.apcprd02.prod.outlook.com
 (2603:1096:4:96::19)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from PC80253450.adc.com (58.255.79.105) by
 HKAPR03CA0035.apcprd03.prod.outlook.com (2603:1096:203:c9::22) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.4500.7 via Frontend Transport; Tue, 7 Sep 2021 03:53:53 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 5d30bcb2-2895-4148-90f4-08d971b31cc5
X-MS-TrafficTypeDiagnostic: SG2PR0201MB2206:
X-MS-Exchange-SharedMailbox-RoutingAgent-Processed: True
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <SG2PR0201MB2206963B342E7FB436ED35A4C3D39@SG2PR0201MB2206.apcprd02.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:2512;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: p8fvLdvB7ESlxiTnb4dLbki1temrx2pQdZRk7jEyiDbrURh6lUGCBH28MdFS9RQoNtZy5Gg2ZZd71gsV0eXhl+NZwzLHn1wOaoOXe65/Ym6jxkLUepbe6Q/2vjqy9ZYJCNnih/k+CngbBzoXICyxXW1/ytlSwqoWs/xbWxhW5PBBNJsIahcmWoJbZ0rRUvD9T+ykX6fi8LyldMJAQJ9BApe5NCEk8vTIerlXmX6PxWIlLaOCHkSVVscGzBLH+mWlFCP40RfpWs38WIjdbevqwmLrKC1m8TnLRl8xtbkXPMKSoW4aMX6OILT//IDR2uidrseLNqZZJBPfykOCy8Rqr+ymT7JmcMckwRc5/VMC3o2TjDsvE/kShqgce0KamRbpAG+6VLDL/7cV42htbb4OqAFt5ck+rZ7MEA3uj5VS9W6hMy0kj7j/eW8lsQG43m0iXb1Ck+yj6qO9TMOd96VtE8YUlKiUO+C9eIQeD5fI+P1uqhlIzrbGKXEHiCvpuC+M+u30ldMB0UtYcJi4lk5Jb0pZiE7xkedSiLm2y55MFkKC5Pv1s6/GbE5VJgKRrqy4YEdzwkf/Bp5QeAJ3MG4YfBkuEg58J/dhDo4H7DL7qeD9giVU9pp5NqmyleGv2SuQjIaxpxgVkKDkfEiX8PN3YoAy3Rq2bSCF/Cf8Q+RnMM3bOw8c4nEieVzNOPmezxmN/JhjS+6FLH931hwVg/tWZgiIv5wgMkUBCti+vsoElto=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:SG2PR02MB4108.apcprd02.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(4636009)(39860400002)(346002)(376002)(136003)(396003)(366004)(66946007)(8936002)(86362001)(2616005)(956004)(66476007)(66556008)(6506007)(8676002)(4326008)(83380400001)(2906002)(1076003)(478600001)(6486002)(52116002)(26005)(6666004)(5660300002)(36756003)(38350700002)(6512007)(38100700002)(6916009)(186003)(316002)(107886003)(11606007);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?ffDDLY24KT+TOe7/joVlIX8pzmj51VlBWjV1y3MtWl8Au8N9eDt2LKR7F7pU?=
 =?us-ascii?Q?8ahfrFYX1Kd3CL1S98eJrfBie+lmECZY17Yj9X5yneay1w09kegwBkyVH5RR?=
 =?us-ascii?Q?bjYgHDkeOMFSogRR1F3nvG6XZCouI6LkPI2ETEDvwAVRv7DA7M4ltRznFgKt?=
 =?us-ascii?Q?XyjmAnRLRTqnpwOHsqocrSKeNKCEqo/XCwROi148dTPTBmVgCGNrViRuRDRT?=
 =?us-ascii?Q?xoLC+Bg0tYVGWpfj4iABE+gum+jvdYvNOUKAcHLUpc//Uz0uNntOdWf5f889?=
 =?us-ascii?Q?E24RB9FSxW0HRMJiRFK0eqOTqWJOGSLAEMRhAlJ8QY8hYjeE01CZ+vMDKc49?=
 =?us-ascii?Q?RnaFcwVWm5UNdISVbf29Oz5auN4JVbod0w1Fi7pSgPuDsZuXyDuKIku2kURu?=
 =?us-ascii?Q?9S7L9FzsysdpScfvG5LYdCybCOk7WHuuGQYn53b6NIQmn3MhtG8MDoeHfWPt?=
 =?us-ascii?Q?u7Gp+JgoZdcTNuWSBCH6Zd7tuyuZ8FiKj7juXqRVbCpuElGVMEDMth9GsdHi?=
 =?us-ascii?Q?h8GnIKRnYS4uyJ6myBas4EWzZgQNNodEi2LhFkPagWJfRHP41e5za1HBkLIc?=
 =?us-ascii?Q?0JfaXc2LOqll91scgccz89A3hBB+GiOWGqXghEmKrvexQfTvBslRe4x+jUsB?=
 =?us-ascii?Q?38oEP0iwFAKzooeknDxMpUedO0+RKJ2+eN5JhJ19W4UCbSpw7YSEpqloj+2F?=
 =?us-ascii?Q?IMLFwBFNYGOAGXsheLcvloHNhYlEK/HHI8nKITpBx8QzVJf8OkELfe/rIY1K?=
 =?us-ascii?Q?hyt7y5DlBvgyDIq2TpxFGIxz8hIRY6SpLDqUR2Cp2GHC7jciwcCYoiebu/DX?=
 =?us-ascii?Q?fY/idwSIoL2fSDl2bZmM6fh/xlk6v9urcgbVFcTTNKfZKyCsrYAfjrQthj0q?=
 =?us-ascii?Q?fRdrp6K3zWtgXRC6Sbn+BDMzdulEufQx632HAC32lETgxdpqAjM6vfuh1GNd?=
 =?us-ascii?Q?u+aT6WEzyeyM69IaFJzelayLt2iv/iO+6rzIgctJeJeVnSHzg1wzM6Ge2umd?=
 =?us-ascii?Q?o69QCzcAbT6HW/vKdK9Yb6oaZMbfVhc9n37S9QUUk3khCiVJVKP3dPik4Kgw?=
 =?us-ascii?Q?RQ8j0HI0NWupJckx1ohuMfbf6Xod2gbmsWSCkT7NPzAlcsX3KhYry8K06F3v?=
 =?us-ascii?Q?y3IajuRKW3njUkK1Sn7+BLa3VdsEIcXL7uXAI0lsxYXHp5wOvTTYb4q3C+8V?=
 =?us-ascii?Q?bESUKfrf0KmEKJPZB+wgBIVqQ+OTdW3ntdx6vXODNMSu36eDE0H7lgbFo7uW?=
 =?us-ascii?Q?tlZHP6jx4lpv8ex37KSwPwxBPKYbV9hcAP0F0UDAN04L2+MGYvu5vutQkKjv?=
 =?us-ascii?Q?wB6Kh9AbRW7tmW0FlChThH6F?=
X-OriginatorOrg: oppo.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 5d30bcb2-2895-4148-90f4-08d971b31cc5
X-MS-Exchange-CrossTenant-AuthSource: SG2PR02MB4108.apcprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 07 Sep 2021 03:53:55.0427 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: f1905eb1-c353-41c5-9516-62b4a54b5ee6
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: XI06x5atuqO1INFCQZsr0zwIUcQ6GgMNZiUeKvCgmnXH9ngF9rtNYAlVTZ/FP2zSTYGZZMOO9LGhaXF+BJeRhw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SG2PR0201MB2206
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
datalayout is seted in erofs_prepare_inode_buffer.

This problem will cause inconsistent reproducible builds. Clear the
entire erofs_inode to zero to fix this.

Signed-off-by: Huang Jianan <huangjianan@oppo.com>
---
 lib/inode.c | 12 +-----------
 1 file changed, 1 insertion(+), 11 deletions(-)

diff --git a/lib/inode.c b/lib/inode.c
index 5bad75e..0cce07d 100644
--- a/lib/inode.c
+++ b/lib/inode.c
@@ -834,25 +834,15 @@ static struct erofs_inode *erofs_new_inode(void)
 	static unsigned int counter;
 	struct erofs_inode *inode;
 
-	inode = malloc(sizeof(struct erofs_inode));
+	inode = calloc(1, sizeof(struct erofs_inode));
 	if (!inode)
 		return ERR_PTR(-ENOMEM);
 
-	inode->i_parent = NULL;	/* also used to indicate a new inode */
-
 	inode->i_ino[0] = counter++;	/* inode serial number */
 	inode->i_count = 1;
 
 	init_list_head(&inode->i_subdirs);
 	init_list_head(&inode->i_xattrs);
-
-	inode->idata_size = 0;
-	inode->xattr_isize = 0;
-	inode->extent_isize = 0;
-
-	inode->bh = inode->bh_inline = inode->bh_data = NULL;
-	inode->idata = NULL;
-	inode->z_physical_clusterblks = 0;
 	return inode;
 }
 
-- 
2.25.1

