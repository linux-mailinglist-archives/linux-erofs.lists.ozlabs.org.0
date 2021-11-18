Return-Path: <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>
X-Original-To: lists+linux-erofs@lfdr.de
Delivered-To: lists+linux-erofs@lfdr.de
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2404:9400:2:0:216:3eff:fee1:b9f1])
	by mail.lfdr.de (Postfix) with ESMTPS id 4E724455D30
	for <lists+linux-erofs@lfdr.de>; Thu, 18 Nov 2021 14:59:28 +0100 (CET)
Received: from boromir.ozlabs.org (localhost [IPv6:::1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4Hw1ct0YnBz2ywT
	for <lists+linux-erofs@lfdr.de>; Fri, 19 Nov 2021 00:59:26 +1100 (AEDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=lists.ozlabs.org;
	s=201707; t=1637243966;
	bh=KCZLz2gQqF9x533F6S0zZL21QbFj9qpvu5xZoKI9sBM=;
	h=To:Subject:Date:List-Id:List-Unsubscribe:List-Archive:List-Post:
	 List-Help:List-Subscribe:From:Reply-To:Cc:From;
	b=Fie01QgY6fQJaY53dHbEf8+ytaJe3aiPY5aa3a4UYUzvZilt87jefCZ/TtNpcpmBv
	 J+Gr1J1vksOe8G3y1BQEH43Q9y0biu91ucVp5qgM/38Dmv/qUaBYAVFDmAjg5xoi15
	 VbjvjCPzRlVDwCVxA1IAXpnFZRhFjZ6qZYGYbPCGiRgjdk5yFaPTGMK7OmqWssw69r
	 Wbidzd9R8uTUlXcBRWhM7mbfHIKG7dTunhC0LfG7c/7vkWADJhRYM0ZafZ8qg7JuWx
	 SzH05ZzbjrKgo216uw5wwLI3FpqTpkaYv2GDdWCigXvTOJGzdlZh4eSsahjCYFnXYv
	 srX8hFSlonLcQ==
X-Original-To: linux-erofs@lists.ozlabs.org
Delivered-To: linux-erofs@lists.ozlabs.org
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized)
 smtp.mailfrom=oppo.com (client-ip=2a01:111:f400:feab::61f;
 helo=apc01-sg2-obe.outbound.protection.outlook.com;
 envelope-from=huangjianan@oppo.com; receiver=<UNKNOWN>)
Authentication-Results: lists.ozlabs.org; dkim=pass (1024-bit key;
 unprotected) header.d=oppo.com header.i=@oppo.com header.a=rsa-sha256
 header.s=selector1 header.b=dxrvO6tY; 
 dkim-atps=neutral
Received: from APC01-SG2-obe.outbound.protection.outlook.com
 (mail-sgaapc01on2061f.outbound.protection.outlook.com
 [IPv6:2a01:111:f400:feab::61f])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 4Hw1ch0HQ6z2yZx
 for <linux-erofs@lists.ozlabs.org>; Fri, 19 Nov 2021 00:59:13 +1100 (AEDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=iDvTgevJRyj3SOSZCTic/7ezfAaTuvWVU0kgz/fITeHcF9DZ7x/4MXBIpVz6bstB/U5IAiu4omPZ853ZaqMsCmGkbhsu9iIHH+vDAT4ARSI8WtJvSz7Wa+sZM6krbahZJkWcY+Gvjs/Tiag2vILJ3xlPhqM35k9BW8gF18F0aaIT9O7gJajEjA1wrbVAC4fkr63wqIYF4imFC6Y/OLgGFEZR7ZckzY8z0ZJ7xCVMwXoQOUCX02KDps/IPvynS7YRO5J3yUmZC0F9f/zvD82AaYOJeRgA4B3igFjmpqfIrS5uDQHBz8J5e9jqbZ4kFuyrxV5qJtkNgCbVW6cX2b71YQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=KCZLz2gQqF9x533F6S0zZL21QbFj9qpvu5xZoKI9sBM=;
 b=FlQb1XXtvG7HWnY6IpUWXmYkY3nTC7FVIjsYA/XYf5hNeugFVEa1N5harvJeLG5hIXuoUFGTj0pFlH/NuDsAADBG5I6GM+yLMxBqlXm63KDeNQ/sAxa0UeDFmRSyhLiXLkfCEYadDcGdAjlyIA14zWq87xid41Cbl2lHCZ1JKXW4ueC/U2PvcqMBV+NfOVVfWljpexwL6hTEeNziqwlDvQ6auq2wb+YPjSV7gdKcOkyRnbatPjDrZ84SJ4C1NWA9KnhsCs1knnj2Xqej5zNjae4vW3hTmjf7IcRwtrYvjgPwn7Euza7B8ihMLnH275WdW7Hc+CD0bzB2Nkh5qJKQUw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oppo.com; dmarc=pass action=none header.from=oppo.com;
 dkim=pass header.d=oppo.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=oppo.com;
Received: from SG2PR02MB4108.apcprd02.prod.outlook.com (2603:1096:4:96::19) by
 SG2PR02MB3749.apcprd02.prod.outlook.com (2603:1096:4:3b::16) with
 Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.4690.26; Thu, 18 Nov 2021 13:58:51 +0000
Received: from SG2PR02MB4108.apcprd02.prod.outlook.com
 ([fe80::f022:6b45:828:4ebf]) by SG2PR02MB4108.apcprd02.prod.outlook.com
 ([fe80::f022:6b45:828:4ebf%6]) with mapi id 15.20.4690.027; Thu, 18 Nov 2021
 13:58:51 +0000
To: linux-erofs@lists.ozlabs.org,
	xiang@kernel.org
Subject: [PATCH] erofs: fix deadlock when shrink erofs slab
Date: Thu, 18 Nov 2021 21:58:44 +0800
Message-Id: <20211118135844.3559-1-huangjianan@oppo.com>
X-Mailer: git-send-email 2.25.1
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: HK0PR01CA0062.apcprd01.prod.exchangelabs.com
 (2603:1096:203:a6::26) To SG2PR02MB4108.apcprd02.prod.outlook.com
 (2603:1096:4:96::19)
MIME-Version: 1.0
Received: from PC80253450.adc.com (58.255.79.105) by
 HK0PR01CA0062.apcprd01.prod.exchangelabs.com (2603:1096:203:a6::26) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4713.19 via Frontend
 Transport; Thu, 18 Nov 2021 13:58:49 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 4e2b913b-e890-4aa5-1e4d-08d9aa9b8cce
X-MS-TrafficTypeDiagnostic: SG2PR02MB3749:
X-Microsoft-Antispam-PRVS: <SG2PR02MB3749553CC403084AA697E0ACC39B9@SG2PR02MB3749.apcprd02.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:7691;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 3gIUn0pmrso5jYsf3xCHy1KvgTtK2k3XJTRworbtg3YaQK5pMJRKmx1TqABNlU4uTIL4E80A1DyGemoTwKjtNL4+jaHEeSm7Lq03gocP3gdr/dY0R5zb7dN7W8Pg88fBfPhmzpx8xymtSCa2OmXYNzXDLmqZFT9Vm/8XcvFC6dC55NLqjxmYMSrvMej+ZlvjLXncdX+IKcL1bDIpq49aFT0m0SCNamdJrOCLg+hJMuLOGtm+IFsCaSJGQpqLJ6rRYoSITNsvcNFHwtFbSR7EJhJeBKDT79igv8Kfa+q06onGNLvRDneP4lXyG8IH2FE983u6onVmZBkCKJ8DOJNzXcADfRAEMITP8LDdainMJzZkqbt54VOXkIfJKH4kzd+qxcbiVkEM55g8I37blrEyhLE451EOFM2Bbi1aLZht3By3ShwxgdjW5Pm/NSqKRiBd4MdbFwRqGaqjhNJlLDL62G8C0SD8bkft9n5k7mYZ7cPMcek48lKcIv3/vrLkSXbK6UUwwq112Y0EP8n22iRnAtkCO9q4iOUDMlfqNCUroUouD3t4TtBaRmcnKCyR7RrHGeOGyn/uIpQn1HUSgG6npBVsx12QNl4rNnKrhi0bEse04EE29flWjpbQ/RSLLSQ/uoReqxINY/0KtBahExK//lPUu9jOhPsR7uqCd1LZgMMjcvhLP3ySkSPKjz1IAkDBTFlQITz585XY3hTlKxjDooE+wMEc3/iRytaCOA7hFEA=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:SG2PR02MB4108.apcprd02.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(4636009)(366004)(86362001)(5660300002)(8676002)(186003)(508600001)(26005)(6486002)(2906002)(6512007)(956004)(1076003)(6666004)(2616005)(66476007)(107886003)(4326008)(38350700002)(36756003)(66946007)(66556008)(38100700002)(316002)(83380400001)(6506007)(8936002)(52116002)(11606007);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?KIpDfr7G1TnYEAmP4Vzw1a6EcLNJZzJV0u0T0MaNrV9T6OYj8xIUc3J78T4H?=
 =?us-ascii?Q?lHsXroNq+m72TeuwBewfcQKETXzOj8NR8zEU9KpTJc09PH0a6fS5mixdzPkq?=
 =?us-ascii?Q?8v6BrjOivscGTrDYGUMHMnBBzjrBEjN8bWZOHgG/petDgIR/rE9f8xkhQo5D?=
 =?us-ascii?Q?kGeG+ka/75PU1NlmCPCFIAnpal1sQLHH7iqMne8fkyU+urZocExhpGPigVBV?=
 =?us-ascii?Q?yStmXD3dVcugAKERGMHmgHPKOJBqcDRFsYPj3MN0FrILa+A0xp3HZ5PNzoAR?=
 =?us-ascii?Q?64ZqtYjFHYgLRSl+LfNT+Sat9LFhv+rpk8jDXRg12kNDnveQgtc8BrTSPL//?=
 =?us-ascii?Q?102hT6TYG1vpiOrXLLLnJk7xHd/x0e2qrH2E197nSKRhzI8MsMYRKcU4xXZN?=
 =?us-ascii?Q?VUvqrU20KYClkV+alSqX8C0QN1QNf+X3kLNx2CMO3c19A/hKvHJM6kVtFvU0?=
 =?us-ascii?Q?JHvt1yOD05EmlCpwUIzUXP05NXqxIQrafcnOtiJIFtN4AgFhVKaFqkPxipUW?=
 =?us-ascii?Q?snN9XvBMbRxlI1AXh9EaqKmxieWYuHr19tHzJNkxhLvCD44t1QdatShE/FEf?=
 =?us-ascii?Q?WzaCPTNINl8bQtOH/BlVcVlmu814DGiVx8+BUJI9Q6T/pZjFDMupE127PRMM?=
 =?us-ascii?Q?AF/XsvAwiW0s8LiG0vNTuDc4lOJsNUai7p3EdYA4+WrpRhfP1aCUsPiHkPKM?=
 =?us-ascii?Q?2bH7JnLIwl+Uy7YiLuD5l2XOsIJ00ZXg4j/Qxv4eAYESs3CuEn0WAeFXqoJJ?=
 =?us-ascii?Q?0OOfuNGIzWgBEWqijZPDBnx5MIsj2/pScDmI4pf5Ydc75S87/rKRDa3FtTd6?=
 =?us-ascii?Q?534rPz0CEWCzm21c5aXAhghs/7hFPbA/E5ksVHuc+cYGFs8uYB3lZ559MKRT?=
 =?us-ascii?Q?UMv5+OfKcrcjQ+3f1TC0NyWCR94EPV/mm69B1Ol8TVgvoNedr3y5Qw8LWm9+?=
 =?us-ascii?Q?9nDxJ2uIf18M/H8ceQK1wHqgOkIpuBp8e+oYciWzfunezvLo6vgocoBijZmN?=
 =?us-ascii?Q?dX41ueurEe2TNntZrTkjvNIiGFLGwQEy7/3xganxdMnFSIxIeqLzyRaIhZKi?=
 =?us-ascii?Q?tW4GMj6Aawq18kIzDL2YurD6LdckZnZQMKwvtBJFyWY48xaNrqk4UwV22hIj?=
 =?us-ascii?Q?wdOTQTaVzdCdjqY7KPBK+/BKsnj4ruaVfAoGVzHTjzsax0J4o3ImpPSRmnkR?=
 =?us-ascii?Q?0eSBPQ291E8QNvqR4s5ceu/Z96cnl3fsDJWobKF4HL1EIRmX++XmF0pA9pkf?=
 =?us-ascii?Q?Kkomlu+5HVfjrzDKePFqoqLUr25nygL5SeKeMgzyq22oFtdZhddqH5mXKn66?=
 =?us-ascii?Q?rr7zDmYYfpX44tvvdLwRQfJ4dx5yp/ti6oLLzjTEd6SBT3y0L9yHNFUchLcJ?=
 =?us-ascii?Q?xnDMqiAv0C6Ssdlnf3JFp5ime9mfDMD8RllAOytM46uUQu4+irKVMzXc9P3q?=
 =?us-ascii?Q?25bWTM/nYpCwzcSFbXMmZxQrzI+hTQFXE6wJo+IqjONxD5oHfgfydJ1srq1x?=
 =?us-ascii?Q?2I1FHrcVGq/PVWjs1brTrScJmN5idACCWVBIJvitzApl1NVlERHgLBSsqLHr?=
 =?us-ascii?Q?+7UZjP0wQnxNbBoBev1GJu4lx/HeIF6S4PM1UlNyElyl6A1WI0+7qu9PjgTn?=
 =?us-ascii?Q?DNAooPvC476QnxWbD0viucc=3D?=
X-OriginatorOrg: oppo.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 4e2b913b-e890-4aa5-1e4d-08d9aa9b8cce
X-MS-Exchange-CrossTenant-AuthSource: SG2PR02MB4108.apcprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 18 Nov 2021 13:58:51.3614 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: f1905eb1-c353-41c5-9516-62b4a54b5ee6
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Uv3HIDB2rZDKmvU57EoCMcE+fO4a9X5Vv2f1uFRyzKuOnAUZNGnUpPOERqlz7nH18M8pGUUnnCMzkw61zDnf9A==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SG2PR02MB3749
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
Cc: yh@oppo.com, guoweichao@oppo.com, zhangshiming@oppo.com, guanyuwei@oppo.com
Errors-To: linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org
Sender: "Linux-erofs"
 <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>

We observed the following deadlock in the stress test under low
memory scenario:

Thread A                               Thread B
- erofs_shrink_scan
 - erofs_try_to_release_workgroup
  - erofs_workgroup_try_to_freeze -- A
                                       - z_erofs_do_read_page
                                        - z_erofs_collection_begin
                                         - z_erofs_register_collection
                                          - erofs_insert_workgroup
                                           - xa_lock(&sbi->managed_pslots) -- B
                                           - erofs_workgroup_get
                                            - erofs_wait_on_workgroup_freezed -- A
  - xa_erase
   - xa_lock(&sbi->managed_pslots) -- B

To fix this, it need to hold the xa lock before freeze the workgroup
beacuse we will operate xarry. So let's hold the lock before access
each workgroup, just like when we using the radix tree before.

Fixes: 64094a04414f ("erofs: convert workstn to XArray")
Signed-off-by: Huang Jianan <huangjianan@oppo.com>
---
 fs/erofs/utils.c | 9 +++++++--
 1 file changed, 7 insertions(+), 2 deletions(-)

diff --git a/fs/erofs/utils.c b/fs/erofs/utils.c
index 84da2c280012..84a59f075dd1 100644
--- a/fs/erofs/utils.c
+++ b/fs/erofs/utils.c
@@ -150,7 +150,7 @@ static bool erofs_try_to_release_workgroup(struct erofs_sb_info *sbi,
 	 * however in order to avoid some race conditions, add a
 	 * DBG_BUGON to observe this in advance.
 	 */
-	DBG_BUGON(xa_erase(&sbi->managed_pslots, grp->index) != grp);
+	DBG_BUGON(__xa_erase(&sbi->managed_pslots, grp->index) != grp);
 
 	/* last refcount should be connected with its managed pslot.  */
 	erofs_workgroup_unfreeze(grp, 0);
@@ -165,15 +165,20 @@ static unsigned long erofs_shrink_workstation(struct erofs_sb_info *sbi,
 	unsigned int freed = 0;
 	unsigned long index;
 
+	xa_lock(&sbi->managed_pslots);
 	xa_for_each(&sbi->managed_pslots, index, grp) {
 		/* try to shrink each valid workgroup */
 		if (!erofs_try_to_release_workgroup(sbi, grp))
 			continue;
+		xa_unlock(&sbi->managed_pslots);
 
 		++freed;
 		if (!--nr_shrink)
-			break;
+			return freed;
+		xa_lock(&sbi->managed_pslots);
 	}
+	xa_unlock(&sbi->managed_pslots);
+
 	return freed;
 }
 
-- 
2.25.1

