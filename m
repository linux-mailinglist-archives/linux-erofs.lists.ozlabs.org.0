Return-Path: <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>
X-Original-To: lists+linux-erofs@lfdr.de
Delivered-To: lists+linux-erofs@lfdr.de
Received: from lists.ozlabs.org (lists.ozlabs.org [203.11.71.2])
	by mail.lfdr.de (Postfix) with ESMTPS id EEEF42C62DF
	for <lists+linux-erofs@lfdr.de>; Fri, 27 Nov 2020 11:15:54 +0100 (CET)
Received: from bilbo.ozlabs.org (lists.ozlabs.org [IPv6:2401:3900:2:1::3])
	by lists.ozlabs.org (Postfix) with ESMTP id 4Cj9WC4dG2zDrdN
	for <lists+linux-erofs@lfdr.de>; Fri, 27 Nov 2020 21:15:51 +1100 (AEDT)
X-Original-To: linux-erofs@lists.ozlabs.org
Delivered-To: linux-erofs@lists.ozlabs.org
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized)
 smtp.mailfrom=oppo.com (client-ip=40.107.132.70;
 helo=apc01-pu1-obe.outbound.protection.outlook.com;
 envelope-from=huangjianan@oppo.com; receiver=<UNKNOWN>)
Authentication-Results: lists.ozlabs.org;
 dmarc=pass (p=none dis=none) header.from=oppo.com
Authentication-Results: lists.ozlabs.org; dkim=pass (1024-bit key;
 unprotected) header.d=oppoglobal.onmicrosoft.com
 header.i=@oppoglobal.onmicrosoft.com header.a=rsa-sha256
 header.s=selector1-oppoglobal-onmicrosoft-com header.b=ZZ6Mlhxl; 
 dkim-atps=neutral
Received: from APC01-PU1-obe.outbound.protection.outlook.com
 (mail-eopbgr1320070.outbound.protection.outlook.com [40.107.132.70])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 4Cj9W426dszDrcH
 for <linux-erofs@lists.ozlabs.org>; Fri, 27 Nov 2020 21:15:42 +1100 (AEDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Zn1mldbjlZL0KF7PKIawuYnlNAaghoQDrADXsi45ZKflajVdAjXWsN/o8cxBYzRWOtwk/X7BwJuItvyy7otvlr98GF5JjhOa7QT22okW1GyBPwpSxN1Ruv3pyOEjqLIHb6vJWEH0HogszRrvMmvq4m29V4PX4CBk86z6MBlNAdaTPm7TXXjgjZvszsCyQ8d9mln6f9cr4LuQnE4EdepKNWW3QzVvKzQ2sKB0hRKz+7d8kiY341G/R3rfcoEDfpJ6l6rzJC2tGZ5A1JNdcEthPM1j+AOM8pOKxVHi/gvk/HqLzJrN3SGKNXe9eOTxpUr/uEC5WdtsRyqdDk7X0UuCCw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=/9dN+l8JCQjK6Y8lDH9yuyJwL2meceJln3HlASXHdKI=;
 b=duRgajkkJlR8jxQPI22HiRENx3y/ha/d9nF0k7s/Kikb6ebllnK8dxWpla1jgLcdMLkRqa/rKPDl0drx8xaARZP1b/sUn33eRNLgx06kcvUqeqKwepsl9c1PI5cHSgTf77IwOWqfQSJKqGNXYceiGTpcPwKFlOyt5hUfWPH4A915HAIdkrSs3mR/jL5n9DXhVT52ZOa+BxPxJ9ksQje5UXjdXi04TKxp4gZzj4RvMOVIULAhE1LB4gXMgtzdHbDNZiyvo3/dQjIqUXetpl0mXGdTiQL6YGdpmiYAN7tiq85XGuwrV8/7R90XH+TGkXhXoHCc6MsBSmShbJu4ujzclg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oppo.com; dmarc=pass action=none header.from=oppo.com;
 dkim=pass header.d=oppo.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oppoglobal.onmicrosoft.com; s=selector1-oppoglobal-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=/9dN+l8JCQjK6Y8lDH9yuyJwL2meceJln3HlASXHdKI=;
 b=ZZ6MlhxlNVeelBth/oQmzPCDTUZU+4pqCKysNECXsLYOc832reVVWsjpwc6wfS4/NlT9Uj8XO0ejkrg9+sMIho/QrkjRyNsvGfzL4rY0+c6XoMD02mVvUxxH7f1lXf/0hxpp0aG2J9AtNgYGyZjE/JFzfmidcMUsCSniJ5fsq3o=
Authentication-Results: lists.ozlabs.org; dkim=none (message not signed)
 header.d=none;lists.ozlabs.org; dmarc=none action=none header.from=oppo.com;
Received: from SG2PR02MB4108.apcprd02.prod.outlook.com (2603:1096:4:96::19) by
 SG2PR02MB3369.apcprd02.prod.outlook.com (2603:1096:4:43::9) with
 Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.3589.25; Fri, 27 Nov 2020 10:15:33 +0000
Received: from SG2PR02MB4108.apcprd02.prod.outlook.com
 ([fe80::34fa:80a2:c5d5:8efd]) by SG2PR02MB4108.apcprd02.prod.outlook.com
 ([fe80::34fa:80a2:c5d5:8efd%6]) with mapi id 15.20.3589.025; Fri, 27 Nov 2020
 10:15:32 +0000
From: Huang Jianan <huangjianan@oppo.com>
To: linux-erofs@lists.ozlabs.org
Subject: [PATCH] erofs-utils: fix use after free in closedir
Date: Fri, 27 Nov 2020 18:15:11 +0800
Message-Id: <20201127101511.33373-1-huangjianan@oppo.com>
X-Mailer: git-send-email 2.25.1
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [58.252.5.72]
X-ClientProxiedBy: HK2PR06CA0023.apcprd06.prod.outlook.com
 (2603:1096:202:2e::35) To SG2PR02MB4108.apcprd02.prod.outlook.com
 (2603:1096:4:96::19)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from localhost.localdomain (58.252.5.72) by
 HK2PR06CA0023.apcprd06.prod.outlook.com (2603:1096:202:2e::35) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.3611.20 via Frontend Transport; Fri, 27 Nov 2020 10:15:31 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 87558805-81b0-4d73-0374-08d892bd5f9c
X-MS-TrafficTypeDiagnostic: SG2PR02MB3369:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <SG2PR02MB3369F3EE0FCB43280C081C20C3F80@SG2PR02MB3369.apcprd02.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:525;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: CDzbpiaWch/4+JGdmuIgMPI4mnSwEMXCMWzqoFhALzQqRuMY0Q+rDv8bV71mtEwh3PeHgkdxehBIhjz2W+Ruvge3jXM8NxKRbfIVXx7JIDSxJ/x5DOUcgJagNSG04p+C+HWgDyhYwM9z6n045hKzEmT5E2uJkpVCr+rGsOhDIiR3ISwBPVs28ZEZFvw7z48S2vMeQJJkkAWzMsyizEHYuqdMc19pELR6q2IMGQsm45Wn3m71MS93PvPpJ/Uxukn/KX/oFQ7yMuXZBE4OqfPAJR0vnoMU4jy4dIY4vgkQwXBdaB9qLg4Udp4ZL4Tdg5YACO4S7WJD7RvnY9F8HcIlwLUGXKqNeLorE4ptRZ1pDK86y2i/HmLmF5E/G9iXq2U4ePY3P+rRez+ae16SWZp1jtvdU1yJVefFic7DNwvcDPo=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:SG2PR02MB4108.apcprd02.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(4636009)(346002)(396003)(376002)(366004)(136003)(39860400002)(6666004)(52116002)(107886003)(2906002)(26005)(16526019)(86362001)(36756003)(6486002)(4744005)(66946007)(6916009)(5660300002)(186003)(316002)(478600001)(8676002)(69590400008)(66476007)(66556008)(6512007)(83380400001)(4326008)(1076003)(6506007)(8936002)(2616005)(956004)(11606006);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData: =?us-ascii?Q?YXI7UB66ckYePywcmTFZm3UrNM+xc5CM4sDWMtbT8r3LEoqc9LZ0pk9E88uK?=
 =?us-ascii?Q?uNO01fVd/VeedOJreoO7HLDtkOc/6ThvvEaioJCXF9lr2Nf6sCGqh1ze1anq?=
 =?us-ascii?Q?SdnTgBVkLBo0C5Mqw8E1dPBTPjhh5gOp7FrKxzWqCJTnIuF/imINb6r6dl2U?=
 =?us-ascii?Q?8HX89dUrcHCPVgoNu4YDfSON4QleEYxl7FdXbidkK29KUgTfbvHa/yAcIKQB?=
 =?us-ascii?Q?x0xlXernWG1cTgQ78mh+fR0cbe8egEOlQtMfgSRpxcXAYnbeDD8QXf5in6Hj?=
 =?us-ascii?Q?iBcNdtdg5TcjMACT05FUB/yHDz7kMiJeZRlz3+VhaEbsQVs2rScxZeVy14Mn?=
 =?us-ascii?Q?Z6+zqD3cIGfYaFHwIbkD4qQJCGguSZ+Msq/OB6UjW/sDBub0D2QpYML5tjs+?=
 =?us-ascii?Q?UlZBP5rSu8XlCzSP7KfOutp8xGtPVg1CU0ailQ7XTIkyhHuueWCv/IvMlF3l?=
 =?us-ascii?Q?xGuw5FtJEjJvQVPJpzbtrGfeeq3CnTK5Z/evJ8RJWl4bL4J9DRot7zwUngJ9?=
 =?us-ascii?Q?/vpH4vDP+S7F9nZpp3+Vfszb8vnFAdSsmGsFVnh0+SsPYn+NMduT2PHocy9I?=
 =?us-ascii?Q?dnd2bWGdoLlXFAGbWr6+ihroQUjhCu6+6T1yeFklFaNIe9SGSEFawvnDpIE/?=
 =?us-ascii?Q?455HUNaz7bGEfuZbpA9BfpXF0yLufUsTfN9LqiEbnNtbwoZmb43SqmiVo83I?=
 =?us-ascii?Q?NzTE4OtQ+DNPA2nkATY1wlA4VHeKRCKXtYIH8UbgtXG0ktec+fW1zjrF51xg?=
 =?us-ascii?Q?aovlqFuQKD/t9yDrLuR2tvvh0Z7Kf7MxFjxGatTl+4bDxK7OsBEz2COQta9D?=
 =?us-ascii?Q?kEL02YaKth74odthoq56zAL45TMjOaquSS9pKHVCJijSU51t505XQ+6KWkoQ?=
 =?us-ascii?Q?vqzdWdzNSf9FniqSCM+onMbArrYeVXA8Vw/F1i8zc7+A49p84V35kcfmtBug?=
 =?us-ascii?Q?40FnjetOjTSLQRirEiwuW3j6G9c3bzuNaPopD1IJu/0=3D?=
X-OriginatorOrg: oppo.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 87558805-81b0-4d73-0374-08d892bd5f9c
X-MS-Exchange-CrossTenant-AuthSource: SG2PR02MB4108.apcprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 27 Nov 2020 10:15:32.8266 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: f1905eb1-c353-41c5-9516-62b4a54b5ee6
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: erFvUcVZIJJ32yJrIYPm32KieQVSLbBO0qPg+m3Mn5foaauSIjRGZ9YuUj8pUCzzoMrrB7Zbv6r1k1fbeHWU5A==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SG2PR02MB3369
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
Cc: liufeibao@oppo.com, guoweichao@oppo.com, zhangshiming@oppo.com
Errors-To: linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org
Sender: "Linux-erofs"
 <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>

No need to closedir _dir again since it has been released.

Signed-off-by: Huang Jianan <huangjianan@oppo.com>
Signed-off-by: Guo Weichao <guoweichao@oppo.com>
---
 lib/inode.c | 5 +++--
 1 file changed, 3 insertions(+), 2 deletions(-)

diff --git a/lib/inode.c b/lib/inode.c
index eb2e0f2..2397bc7 100644
--- a/lib/inode.c
+++ b/lib/inode.c
@@ -958,11 +958,11 @@ struct erofs_inode *erofs_mkfs_build_tree(struct erofs_inode *dir)
 
 	ret = erofs_prepare_dir_file(dir);
 	if (ret)
-		goto err_closedir;
+		goto err;
 
 	ret = erofs_prepare_inode_buffer(dir);
 	if (ret)
-		goto err_closedir;
+		goto err;
 
 	if (IS_ROOT(dir))
 		erofs_fixup_meta_blkaddr(dir);
@@ -1003,6 +1003,7 @@ fail:
 
 err_closedir:
 	closedir(_dir);
+err:
 	return ERR_PTR(ret);
 }
 
-- 
2.25.1

