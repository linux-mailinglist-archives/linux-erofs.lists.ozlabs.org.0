Return-Path: <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>
X-Original-To: lists+linux-erofs@lfdr.de
Delivered-To: lists+linux-erofs@lfdr.de
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2404:9400:2:0:216:3eff:fee1:b9f1])
	by mail.lfdr.de (Postfix) with ESMTPS id D52214544DE
	for <lists+linux-erofs@lfdr.de>; Wed, 17 Nov 2021 11:22:02 +0100 (CET)
Received: from boromir.ozlabs.org (localhost [IPv6:::1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4HvJrS55XSz2yQw
	for <lists+linux-erofs@lfdr.de>; Wed, 17 Nov 2021 21:22:00 +1100 (AEDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=lists.ozlabs.org;
	s=201707; t=1637144520;
	bh=pSIgr6PSmp2ORXIPvxl7BnC6cAx7ppHNhiGaISz/+GQ=;
	h=To:Subject:Date:List-Id:List-Unsubscribe:List-Archive:List-Post:
	 List-Help:List-Subscribe:From:Reply-To:Cc:From;
	b=WDOtnCJjSfgLZJHXXS6kG7ybYq3aY2TvQ1AuxuNp6y8cz73+ABML2jXSBqP6n9MeS
	 sAynZ8E30tABz0zJ3uoI5SKPEg+q5qSHgeKRpHhfDIXMyzZHsR5lSb+TnHpOv4qJID
	 X50y3Nn2CoPZllv9sfgYgqZR9jdEhTpZKyVr2wEU+ydpoh4pmJEm2N3sneodk7JTpv
	 YQEo0K16sv5TGi2xjU8RWcEtyOydki7toaZNfq1AU2+7FGAveDOY/piKp3eAf+qI65
	 yIKsvMIbDaIUhqLh6S2rWqwpQev/v6XTNASX/OFwnwzlq8tWd+KN6xkb3xI3iVKcI2
	 N/uYmnGeqWSvw==
X-Original-To: linux-erofs@lists.ozlabs.org
Delivered-To: linux-erofs@lists.ozlabs.org
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized)
 smtp.mailfrom=oppo.com (client-ip=40.107.255.58;
 helo=apc01-psa-obe.outbound.protection.outlook.com;
 envelope-from=huangjianan@oppo.com; receiver=<UNKNOWN>)
Authentication-Results: lists.ozlabs.org; dkim=pass (1024-bit key;
 unprotected) header.d=oppo.com header.i=@oppo.com header.a=rsa-sha256
 header.s=selector1 header.b=TUck/Qw5; 
 dkim-atps=neutral
Received: from APC01-PSA-obe.outbound.protection.outlook.com
 (mail-psaapc01on2058.outbound.protection.outlook.com [40.107.255.58])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 4HvJrG3SNCz2yJ5
 for <linux-erofs@lists.ozlabs.org>; Wed, 17 Nov 2021 21:21:50 +1100 (AEDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Sg0vDwffYKnflvPJzniSQsK4PcJUn1ingeszbilwhoXQ6VVjtkq/yPD7DovQA6xoAJWHoxX1nHwCAliec+Gd+GgkbEyjqlGgiNeoYAkiB7QBw5fjNqRCl7iEZKMGBIlxEMPY/Hpro3uV3OayDjM7/z0kai+Q5Vu9OIfkqSh9UNOAgAIYolWQl+5l74J/G2uRnyRGwScJ2co3Yi4e0i3P5uPhug5BDzebZDUOIVANH1uEmHk3oadNs1r2bWHo/+iC0542Kxh8bWy/QsJ/tQ8W0Jf5gCYklyDl580UeutxiNNlxxotnKLgnl12dWbsUa/LjAod2E+dT/NALApG5dzpLg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=pSIgr6PSmp2ORXIPvxl7BnC6cAx7ppHNhiGaISz/+GQ=;
 b=CrDwRjwgnvekzPOJUXzc5+b39S2x5qTxPtgS4SDUCMnH7XBgpIhDjKNLlzURYhin1qu6hjRkCHGTFgRZREDsarYfdtAqjuefbeycW59fu++YKunZRpGZu0bY33oN31qe0/m0jZzQGyJ64Q1BF0Up42ntyylofe2Jt8cJANKWQzzz39u5IONNlKb6TcE1VkwRqyaWBuB1uja/D8/DNrEKjW4it0dg6S/9pijmTgwULbaEOFQ3+CS3H1qkgkhw8x5pmr2rBMmkKQ3RYjxYyO3HusEkmCuc4kniF8MxTC6hoMnN6ggjY0WX+BSkiWecQWqnN/kl1cjvGaiSR2CUgITsqQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oppo.com; dmarc=pass action=none header.from=oppo.com;
 dkim=pass header.d=oppo.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=oppo.com;
Received: from SG2PR02MB4108.apcprd02.prod.outlook.com (2603:1096:4:96::19) by
 SG2PR02MB3481.apcprd02.prod.outlook.com (2603:1096:4:42::19) with
 Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.4690.26; Wed, 17 Nov 2021 10:21:26 +0000
Received: from SG2PR02MB4108.apcprd02.prod.outlook.com
 ([fe80::f022:6b45:828:4ebf]) by SG2PR02MB4108.apcprd02.prod.outlook.com
 ([fe80::f022:6b45:828:4ebf%6]) with mapi id 15.20.4690.027; Wed, 17 Nov 2021
 10:21:26 +0000
To: linux-erofs@lists.ozlabs.org,
	xiang@kernel.org
Subject: [PATCH] erofs-utils: check the return value of erofs_d_alloc
Date: Wed, 17 Nov 2021 18:21:19 +0800
Message-Id: <20211117102120.30203-1-huangjianan@oppo.com>
X-Mailer: git-send-email 2.25.1
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: HK2PR02CA0134.apcprd02.prod.outlook.com
 (2603:1096:202:16::18) To SG2PR02MB4108.apcprd02.prod.outlook.com
 (2603:1096:4:96::19)
MIME-Version: 1.0
Received: from PC80253450.adc.com (58.252.5.73) by
 HK2PR02CA0134.apcprd02.prod.outlook.com (2603:1096:202:16::18) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.4690.25 via Frontend Transport; Wed, 17 Nov 2021 10:21:24 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 4b0bea95-3596-4471-017b-08d9a9b402ab
X-MS-TrafficTypeDiagnostic: SG2PR02MB3481:
X-Microsoft-Antispam-PRVS: <SG2PR02MB3481E5377F271CB6FEE78EAAC39A9@SG2PR02MB3481.apcprd02.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:644;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 9f8XFnoyMpOP6AN1bQWYVYxvmGWvcC/Kk/mRC4U1kEmvXDyVVYx9ggBJKVIyr0X/8X15WssGwECDuP4mtkGPlydpi3jWtw3pF8tC5G6prDOqlthuSOchNgOuqmyZIDz3hPRXt/Ja7JkIcgkN9lfaVQa9ffFBixRJpTPl6tRCGVxdehauyDUkuuc6W36ICagm+e9lCmBA7I35ZMz9+4v3ntSrHuOaLbdOqXP1nkVcOmRg9lpmMTvy0npWRCJJIYIYTkYTlSIYLb5jMAAWnZSZmlHzyefvB+Lz94fOpPcixyH4UnUKNuFy7orys4kltniqeQcIrh5KG7tEfCWerxWIf31RMxxQ/x8RSzMteASkrUR1FUob83F/uiNvfYknwSFiBsuQdYrUqgbvWU0fEUfstNs4vO3mcce8jxdaNTKENRh9EnHkOWRken17gze3ZD6S9wNAehwds4jeIxZA2YErpRyQw2ulCldhah/0iDFSFIgh73+loNCYVSt6bkn1LXAtI66uy5CEVjfoodwtgPV2BmFX6J6sNw5+pJc5EesV66uRr5oRR/Yq5gPT+T2ZKuTYUfxzc8v3FbkSsbv6AT2DQLMw5N57tYJn57a2Ub9cxuFwuK6G7Pke3WQ2r9a7rygDAuoGYz/Bs/YlofulZHDg/l5RbYfWsPcoZYp/MspbmyzHCw53hRL+nyFNifb8twfrXE5AAmFbOxvolLaFmoynukYuPtXXPURRnGr358T5oRE=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:SG2PR02MB4108.apcprd02.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(4636009)(366004)(6512007)(6666004)(6506007)(4326008)(2616005)(6486002)(66476007)(8936002)(4744005)(956004)(26005)(8676002)(66946007)(2906002)(316002)(38100700002)(5660300002)(38350700002)(36756003)(107886003)(86362001)(508600001)(186003)(1076003)(66556008)(52116002)(11606007);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?jpodUxrV2zCu41gF18cahokxoh2aF0nhIshrkPqE0xY8oN/HQYwBopCngnj9?=
 =?us-ascii?Q?tfM+x1C0tLMwPw4qkIIsbkw7iBOcMpDXqPhRpntv7NkmXKRvUWYC4D8Oi5zu?=
 =?us-ascii?Q?Qe7SBCq1wNgFT+fH4CIIyN8ybnU6yDgfJqP2bQLe36kR6sAGU3nd3/0C7RwH?=
 =?us-ascii?Q?hGXW9LQ4qOIUNPceXtPy3rSFl9d8exZDh8pZCq/iaxzp0QYF1t4DEKUf5dUL?=
 =?us-ascii?Q?Jpc+JlrCDFZFz4f1ReMBX2urCVGvGWDCDr1/ZHXqyYdOcuxLMXZVzZcXy9Ii?=
 =?us-ascii?Q?OUEXieT5/43n3txqCzZ2jvYWBNdH/juUC4PIfMYqBHThH1GDoATGHEdbR0Ur?=
 =?us-ascii?Q?Pw/mRBCU3mA5X/WbSpkL5F+WPjRkfNppgYX4SR8tjmN1+WmMQq9DILKav8VR?=
 =?us-ascii?Q?4xMtdDav7afn0y+m9J78zIChDxbzinpka1QjdwhkqACUovbzibxPLs0K1f5u?=
 =?us-ascii?Q?Y97b3RyNXTeWI6x0W+NX8HXH4E+Dza4lWG7jmqykNw3v53bFOacE4sfH5Xxv?=
 =?us-ascii?Q?2Tw3J+PgyDvXQmxgi3IeOY+bYvhLcGcqLw7cS5ZIzeoZ7kjpcH4PjhL04Idk?=
 =?us-ascii?Q?ydZATlgzLLBs5szAeGAqbvF+OTir9wpsmCLLdQGOb2s7dta7SWeDH7LTh4YX?=
 =?us-ascii?Q?xhyJLkODim5nBHjO2gnvdmlgjPXGrfSiR9ZD6s09uaeURIs88vm4+E4deTke?=
 =?us-ascii?Q?23pjN7BCD7MRagtwvwhSakCdmgmiWVZoQH0bG0crEhPRYY/0uHGEw22yECc9?=
 =?us-ascii?Q?MBQ0Jj9kAXZj5Lv3xF+8xzrmcmAtbdride9o2q9a5OXWSVmj+CxDmtz4PfpU?=
 =?us-ascii?Q?CkIsfEDYBHjn/KgSI0cpFGik6Boy8c5HPejRqMQFxR9WvXgKV78S39S0GIKM?=
 =?us-ascii?Q?k4rKwCeaIu1DxGP+wqMTivrCgtuDJrP0wG4g4rxh0G7BIl22j+2jZnZVvwVS?=
 =?us-ascii?Q?M+lhOSc5m/LgVDGns4+fudoDrCwMgcXUErNDig+UR2tJ0M7dKflGHW6ycLTN?=
 =?us-ascii?Q?NiTwq5waaOnJ1F4XB1uBhq8Uc/6Y+kAwjbA50ILHvtwWZhNuIvdpI3DAbyW5?=
 =?us-ascii?Q?6d++lmpXIVdFIS25mQCtIOLg4WWzClOyS0QFBcv1XNM0zdgRuzosZOTzy2KS?=
 =?us-ascii?Q?f57u5IkiHM3DKO4g0e5RCnj9Lw2aSSJkkSVSxFkKds4P5bSS8kOFjVpiJCEa?=
 =?us-ascii?Q?bUcwSU8y8VtR+9jIW7fWuDBc9AHFBjNFem9nmq36hmmrWdpBfcV7PLMuLTQ0?=
 =?us-ascii?Q?+0IHgJHIbdXIxmSowi1Wkx3LaGB72NxBZbQ7y9zKQNXEt+QYkwlaqtZfUrFl?=
 =?us-ascii?Q?FIArRMLgSfLMquS+PxYVzkYHBzlkNXL1aktAH2UG0e+xp8L/6KqsrxI2PB5S?=
 =?us-ascii?Q?tcu+hETzzFk5W8vHWs/9jbe2GAm92H7s+oBdFPjJDlN1AP92Y1BdFyXdbYe8?=
 =?us-ascii?Q?UVOzNs/87AnXh+JeP07NyyEf58MKRu2utNV2zPSLPqJPt+CNksl7Xkuwr1zF?=
 =?us-ascii?Q?vm3mnHTX7qClgeyxT22Oaj7K0zsr47rl4dnVgZjDlVCg/2bvfKGZHNT8o6GQ?=
 =?us-ascii?Q?QyxLHUhS7gYujxd8XgRtr6witKzMdKuj1Gj4E0jQn0GsRXMiOHk4N966gzqT?=
 =?us-ascii?Q?gbvT+d1I463dIUFYFEYIBlQ=3D?=
X-OriginatorOrg: oppo.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 4b0bea95-3596-4471-017b-08d9a9b402ab
X-MS-Exchange-CrossTenant-AuthSource: SG2PR02MB4108.apcprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 Nov 2021 10:21:25.8192 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: f1905eb1-c353-41c5-9516-62b4a54b5ee6
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Yn+vqaRfhSuyZ2PX9IQpxo6+wpDHr24yqHP+ed2vboPgUFpypiT44n6DEcm0GgKmyVNssPwQSHhNQguAOTnpVg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SG2PR02MB3481
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

Need to check whether the allocation of erofs_dentry is successful.

Signed-off-by: Huang Jianan <huangjianan@oppo.com>
---
 lib/inode.c | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/lib/inode.c b/lib/inode.c
index 5cbfc78..2fa74e2 100644
--- a/lib/inode.c
+++ b/lib/inode.c
@@ -162,11 +162,15 @@ int erofs_prepare_dir_file(struct erofs_inode *dir, unsigned int nr_subdirs)
 
 	/* dot is pointed to the current dir inode */
 	d = erofs_d_alloc(dir, ".");
+	if (IS_ERR(d))
+		return PTR_ERR(d);
 	d->inode = erofs_igrab(dir);
 	d->type = EROFS_FT_DIR;
 
 	/* dotdot is pointed to the parent dir */
 	d = erofs_d_alloc(dir, "..");
+	if (IS_ERR(d))
+		return PTR_ERR(d);
 	d->inode = erofs_igrab(dir->i_parent);
 	d->type = EROFS_FT_DIR;
 
-- 
2.25.1

