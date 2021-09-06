Return-Path: <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>
X-Original-To: lists+linux-erofs@lfdr.de
Delivered-To: lists+linux-erofs@lfdr.de
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2404:9400:2:0:216:3eff:fee1:b9f1])
	by mail.lfdr.de (Postfix) with ESMTPS id 02B5E4017B2
	for <lists+linux-erofs@lfdr.de>; Mon,  6 Sep 2021 10:15:26 +0200 (CEST)
Received: from boromir.ozlabs.org (localhost [IPv6:::1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4H31RX6yQRz2yJS
	for <lists+linux-erofs@lfdr.de>; Mon,  6 Sep 2021 18:15:20 +1000 (AEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=lists.ozlabs.org;
	s=201707; t=1630916120;
	bh=CMcyvhp5O53Vsx0IGYAv4K33PGVSERxLX/CAQWYiReQ=;
	h=To:Subject:Date:List-Id:List-Unsubscribe:List-Archive:List-Post:
	 List-Help:List-Subscribe:From:Reply-To:Cc:From;
	b=dy/Jddkf+gC+GVM7MGSGIUvQRvKKWirLjEcbI60MAvaZBrpkIl5sq6gvy+ed2LnlO
	 EM/GjmCg6TcVpcGD/kpZLNnAO2uTkUJBLwYq9CUYidkH4ESGQpbVbPyDuFe1j+gloK
	 dGpfaRyRhp4o104op+lxkbvjC42wdKsx9yzPgjyoE/Akusv6ZjW9ve1vOS5/agcYoh
	 TZNWpj54oNylGx3bBDrsiw6kHdzHmdoDzsxx/Jsl2ge4zmZYzNbhwMHFO0mlsn+DMS
	 8DjO2p7ojDIu9/Hk+JUXoMzUR5vDouEf47HljXj/7N6xvTuAE6YYmrAbj+V3tA1e35
	 fC0B/86wuIiIg==
X-Original-To: linux-erofs@lists.ozlabs.org
Delivered-To: linux-erofs@lists.ozlabs.org
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized)
 smtp.mailfrom=oppo.com (client-ip=40.107.131.49;
 helo=apc01-sg2-obe.outbound.protection.outlook.com;
 envelope-from=huangjianan@oppo.com; receiver=<UNKNOWN>)
Authentication-Results: lists.ozlabs.org; dkim=pass (1024-bit key;
 unprotected) header.d=oppo.com header.i=@oppo.com header.a=rsa-sha256
 header.s=selector1 header.b=AHryMtl9; 
 dkim-atps=neutral
Received: from APC01-SG2-obe.outbound.protection.outlook.com
 (mail-eopbgr1310049.outbound.protection.outlook.com [40.107.131.49])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 4H31RM0DgJz2xrr
 for <linux-erofs@lists.ozlabs.org>; Mon,  6 Sep 2021 18:15:06 +1000 (AEST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=OUecMZdLHa+KqH8MYYOnZtS67V6Cs8RgZxdltRydlRzFsEPvTGTVt3DhtRfDwANd0EFxlt3pgXLOWRbz9oIhZZRSXZXrcduR3+TlwwqlxuEzmF+jewMe1t6Xltk/TA6HrssIoeiBT/bfFcxHgOT43h34LDRX3wyYIH6ggLj2sc+SA2vjCyAI5hFCdEYHZwo0NqK51cvii4XoFmY3wicTjqTmOEFYC9pbVnu9EiHsoooMX9W8M1zCj7Y1h1KwdgVeMoKaXpBU+WzYzCQI79WPFsA9JW56PJV34zwR1fEwXsxtLgPKdBgHRjCkngV5x2FvneOzTbCqXqkF13IG+JoTmg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version; 
 bh=CMcyvhp5O53Vsx0IGYAv4K33PGVSERxLX/CAQWYiReQ=;
 b=WHMTMJlBpqgGWKewcUpB+nodiKIR/cJh7q2m8Lx8RBN/1TZkTMLJyuLQmiGtD/CGQtwnLj+zyjVbFWy/l6mNzDSczTC2w4+0fvlbK6UDReF+8/MNmJ4R4x7bIg4KJVxKlrQANmX1uL9k5tH6PqNEjURKA5E/RAqlTp0n/jukD6jT6BeUHRBmZqAeV5gKkpvZgmPluFte09A05hz1vgQ99Vpw7RApJ932Lv7Sz5mBpttStkb0mhJkML6PwBZxO6uGRkbEgeyI4xhSXKHb9ar1zIp9jP3kPUvcDmheqNTrhLuKKEq9fzjYEd4oUbqRDwMx8P4XL+sgsURRtg6vDWF7hw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oppo.com; dmarc=pass action=none header.from=oppo.com;
 dkim=pass header.d=oppo.com; arc=none
Authentication-Results: lists.ozlabs.org; dkim=none (message not signed)
 header.d=none;lists.ozlabs.org; dmarc=none action=none header.from=oppo.com;
Received: from SG2PR02MB4108.apcprd02.prod.outlook.com (2603:1096:4:96::19) by
 SG2PR02MB2858.apcprd02.prod.outlook.com (2603:1096:4:5d::10) with
 Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.4478.22; Mon, 6 Sep 2021 08:14:44 +0000
Received: from SG2PR02MB4108.apcprd02.prod.outlook.com
 ([fe80::5919:768f:2950:9504]) by SG2PR02MB4108.apcprd02.prod.outlook.com
 ([fe80::5919:768f:2950:9504%4]) with mapi id 15.20.4478.025; Mon, 6 Sep 2021
 08:14:44 +0000
To: linux-erofs@lists.ozlabs.org
Subject: [PATCH] erofs-utils: remove unnecessary "\n"
Date: Mon,  6 Sep 2021 16:13:58 +0800
Message-Id: <20210906081359.17440-1-huangjianan@oppo.com>
X-Mailer: git-send-email 2.25.1
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
 15.20.4478.19 via Frontend Transport; Mon, 6 Sep 2021 08:14:43 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: e3f3b60c-8fa9-477e-a2eb-08d9710e6217
X-MS-TrafficTypeDiagnostic: SG2PR02MB2858:
X-MS-Exchange-SharedMailbox-RoutingAgent-Processed: True
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <SG2PR02MB2858A2FC32FCCF82A671A07CC3D29@SG2PR02MB2858.apcprd02.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:78;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: Hu7gfyswehZT3TrOrpSUiQI121cIXQmtpXe8oa3sZx26TLgLg25iCMG9mw8fPXw59WoH3ehyAaDs/1AeOiAjNRr0j4Z6dZ/XFbmGg/nc/WyKQToOgsy2IqIkCo4TSbj3YFe9hK1EHxOg3on7TlL48PCUhkfYiM0rhfB+61Tm9AvqqvDxA63iwa3fDxqzzuwfFLuFUerfSYphZ3Fl0lQf5r1aabN0UiS6g3Ak16z/NjhHrTKotyP/H3WTEOQm/1fv/q7rN42Jp7XIv83dLlo6S/UnP1eFdO2333OLryjpoYqGevQm1gFYFkr3F6ofUi6hTnXTM/x619ZOSuMuoqiVuMtE0Jsbla5A+fYWOo/r5ICSvvH4eRKV8Q2zsioMTcezFzNoouU7pfizcSaKMQFB2FSnPVs156A5JGeSDu1wvOsyBP9/GHBZoGaRC3Xa4K+tKI6gtIVDgmYsulCn6CHu+KOZJUizQlgcffQNeRQzbzCaVSLje4axfP9fJLA3P70V52POMqvu6ymRRCK0hF2kp9TaKZEbbX6/Fi2OLrfs+tlQ0X0Be2P2ptkyd82FG3AwFjj5f+sTKTkQ7Ncr1uyqZM3UoxqCa2vbpMpPmyvkl9lKLw1so8FGP7nT2y1G7DH/QeWJ4RYcr70pFFmHgV9t907D76WU1IqyuwvHoKso2WH8YbblYDnsiYPlOCB0A3Qask3JvPS+1SamhM4s4K810VyVxkv+q3AR37ZgcImzTgk=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:SG2PR02MB4108.apcprd02.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(4636009)(346002)(366004)(376002)(136003)(396003)(39860400002)(86362001)(26005)(107886003)(8936002)(8676002)(6666004)(6486002)(1076003)(36756003)(316002)(4744005)(4326008)(478600001)(186003)(5660300002)(38100700002)(38350700002)(6512007)(6506007)(66946007)(2616005)(956004)(52116002)(6916009)(66476007)(66556008)(83380400001)(2906002)(11606007);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?m/Tocvhv4Eh5pLvaw6Y9FLE/gpcfW/6ZJqaE0GaG5x514XA+YmOxsHiw7mEB?=
 =?us-ascii?Q?SU2RyJGg85Ljr3UgmBt8iNlwmYW2zLWhPqSNX1PpcWaEpBux0N24fdB1cCsR?=
 =?us-ascii?Q?JfjsJPW/t9E6khKRLD6/HziD5maNb+kcUirRVxgVeRxls3uJ9gdjFTRlp7t0?=
 =?us-ascii?Q?lxmxNdjvh9zJZbmFrgT/gxKwqcxmfiJOqX+3zoMgSuG9esqqbY+m+kAGa4jg?=
 =?us-ascii?Q?NiKppoc5mC4ci/M5I7YPQyYcrN5yRlso7dPMneytypPJGyrgBWc6fi1ibweG?=
 =?us-ascii?Q?nBWLGzNaB1AyyKQq6ZztTKhv7uFQPgwfjBlVsJE+I3vdP1WtX9QD7wn5v1gi?=
 =?us-ascii?Q?64c37cudixTulfMMsvaw5dpHJBYZ9am7LjQ0nP/cMIx0aEszGi9tl4AXcj5X?=
 =?us-ascii?Q?ejIQrE+9JMAyl4nKEKT/LR7Lf8TiACIPBWqM+0tRW0vo4lKeDyxUA2l2N9md?=
 =?us-ascii?Q?KCNxbXdYJBP0nBWdh6sVzkkGsDsz39UoAtgW/Ru1fWmlTeV2KBT8l6nu/qSE?=
 =?us-ascii?Q?H7YqfFgH7q4JTfuhiO459q9E7RBkwIAS3K69MeBIFy55ctTIso9FAeio43OQ?=
 =?us-ascii?Q?xzfUqSzkRgWL7n9GGfQSFi5MS93BIdYAX/LhOE9KW/lnk9EBymryJPeVBvqV?=
 =?us-ascii?Q?bM8gsItb9m7YlNeeQq3ZqAGr7yKf/Jj7+xSUjQjH0X7xiswPtYgTN6r+tHuE?=
 =?us-ascii?Q?R4eGITcdXaz6WgW/tBFnkFNyxYHV2Sbu2emGBN5cZ/khGpdZ03BI4ulLfVFl?=
 =?us-ascii?Q?5EywfebgUxL/xQt3cuVLs818u9NYJpEwHRr2d7L0iHoW6NSGyIRivzUMxR1V?=
 =?us-ascii?Q?XY3obOqXMxKMCTZXx8h1obTeCLNcXSspKZJFPp1WBd7dIzJGYVsM7kWnLRR1?=
 =?us-ascii?Q?Vp+sCs9fNfZRDfxq3DkIg4xgLOnenL7Vyh2AXRGkIvEe7KzTEUR0VkdKkB5C?=
 =?us-ascii?Q?VVpT2dR6C5oSLaIUW7wumFjB6cD2EPeanJJap5yCQYQtpEekLl+y/Y/8iARA?=
 =?us-ascii?Q?+vBJjeXtN8Xn58xXMZ24LjLrjfqtAs5ZpMrvyNYJWg2tggyHmlVQh3SOpnFt?=
 =?us-ascii?Q?wS9IlckFRcDUm8kBqJy1YDb/VjkyvA/XlRzDhcdKA9XGvKuElsbisYc7oWjI?=
 =?us-ascii?Q?xQ7q3nMba2MLmgcpbHplS8/orwXuzAj53Q2c/wbf375hjIPjUghRng3dT5Ew?=
 =?us-ascii?Q?34eFDxRxPeACza7ELA1Vg2Jl2GGZODbhxepDzObg8IbjqpF1u46dGI562co8?=
 =?us-ascii?Q?mwOWCn+UN8n9FMQC598I7sejQrFZGRL64ROJpT8CHnhk2WrFUcn72jWnqkPT?=
 =?us-ascii?Q?OShhrubNAYmLJ+w9yiS3okxx?=
X-OriginatorOrg: oppo.com
X-MS-Exchange-CrossTenant-Network-Message-Id: e3f3b60c-8fa9-477e-a2eb-08d9710e6217
X-MS-Exchange-CrossTenant-AuthSource: SG2PR02MB4108.apcprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 06 Sep 2021 08:14:44.3240 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: f1905eb1-c353-41c5-9516-62b4a54b5ee6
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: zUfbOk/di/uh/67LBqWHblHFK6kRY+RjWOTOxXFO8zG+uaAnjgN8bxnBzDNJVehBwtDfKDHf0CA6tAPZyhzGjA==
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

Signed-off-by: Huang Jianan <huangjianan@oppo.com>
---
 lib/inode.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/lib/inode.c b/lib/inode.c
index 5bad75e..0ad703d 100644
--- a/lib/inode.c
+++ b/lib/inode.c
@@ -744,7 +744,7 @@ int erofs_droid_inode_fsconfig(struct erofs_inode *inode,
 			  cfg.target_out_path,
 			  &uid, &gid, &mode, &inode->capabilities);
 
-	erofs_dbg("/%s -> mode = 0x%x, uid = 0x%x, gid = 0x%x, capabilities = 0x%" PRIx64 "\n",
+	erofs_dbg("/%s -> mode = 0x%x, uid = 0x%x, gid = 0x%x, capabilities = 0x%" PRIx64,
 		  fspath, mode, uid, gid, inode->capabilities);
 
 	if (decorated)
-- 
2.25.1

