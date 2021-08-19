Return-Path: <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>
X-Original-To: lists+linux-erofs@lfdr.de
Delivered-To: lists+linux-erofs@lfdr.de
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	by mail.lfdr.de (Postfix) with ESMTPS id F27393F1037
	for <lists+linux-erofs@lfdr.de>; Thu, 19 Aug 2021 04:10:26 +0200 (CEST)
Received: from boromir.ozlabs.org (localhost [IPv6:::1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4GqpBm2bP4z3bWL
	for <lists+linux-erofs@lfdr.de>; Thu, 19 Aug 2021 12:10:24 +1000 (AEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=lists.ozlabs.org;
	s=201707; t=1629339024;
	bh=Sv0hYmTPSh2/6K4lI9kXduhuAAeQOjAx2+oy+16nJLI=;
	h=To:Subject:Date:In-Reply-To:References:List-Id:List-Unsubscribe:
	 List-Archive:List-Post:List-Help:List-Subscribe:From:Reply-To:Cc:
	 From;
	b=ol6Mtdh+fVK/+Xyjo39mnKkjDIP5QaI+6QF7iQYvEKMcMuQVaYULhLCohMIpGl0p3
	 hVDXM6/z3paQ3cPmjy9Yt1lMSJkunyT+y+eR9YO2+3sLdL21PjxTBX9Ur9dCrSFsOD
	 EnHLuQHMs3DTuXnznMCkNSIfvishPWP0zVM2t+vwwHzh/MGyuU6b3JBtpfKzRE0sCO
	 xmUeLe2mKAMS1x15qrKWUadqAtgeDAp8Bv2FOhMnsV9vaL0lF8dN5S6DNwcaqhC4J9
	 EZsGpmZWwk/5w77A/XRVUVVYBcrsIb5U9bxnz1xDNxexMEAHcIAJK3DgFphPVzRurG
	 ecd3t+Imir0pA==
X-Original-To: linux-erofs@lists.ozlabs.org
Delivered-To: linux-erofs@lists.ozlabs.org
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized)
 smtp.mailfrom=oppo.com (client-ip=40.107.130.72;
 helo=apc01-hk2-obe.outbound.protection.outlook.com;
 envelope-from=huangjianan@oppo.com; receiver=<UNKNOWN>)
Authentication-Results: lists.ozlabs.org; dkim=pass (1024-bit key;
 unprotected) header.d=oppo.com header.i=@oppo.com header.a=rsa-sha256
 header.s=selector1 header.b=t7v/wfGh; 
 dkim-atps=neutral
Received: from APC01-HK2-obe.outbound.protection.outlook.com
 (mail-eopbgr1300072.outbound.protection.outlook.com [40.107.130.72])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 4GqpBf1BDyz2y0D
 for <linux-erofs@lists.ozlabs.org>; Thu, 19 Aug 2021 12:10:17 +1000 (AEST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=iN2qyN17Iwxy9PZQqXQrQ+WwxrynVEHlfzIX8PfvUlZXRnEBoMmdvTi3rxVPt+4IlltuWbombWEt32iDMYXypefvhbDhIKbe6/nhPtAdu7NlJGG3uV1RfXM4EuM5Ycc0yT9s0MY02PWmWVJI0bavTlQBHXgTQ/D4y3+A2Uap9HnELhR0OGl5SYDbnIwja5xMH107H1u3GE7SYSz5AZnfzo4+PYIVKMGuauHFNhuuUyviV5wAZAC7pA/4Cnl2Z2M0hWQ1Vl1xZEyUmlgpVJNmtLVZ3uZRSjgkKIKOufFpxmuo9GegvC6pf6aewY8lNVa8RkZwgHI8u1zkLoXaWPRXGQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Sv0hYmTPSh2/6K4lI9kXduhuAAeQOjAx2+oy+16nJLI=;
 b=ncmrZtWOBYxzYvVonGv1BoFHagQm0xA5xSqGHNmqPn/kLIthNoCZOwe4+sdbhqnzmLpUmHqqc9pcjHPTSoj4Z1I4E7A6vGZqiLEK3wOlQVt3cKkToXQ5MsQ4TsjHYdh4ZcdwNI9OXa1pGd+iDoAZ8acgpHgb7A0CrcobOZi95aAhm8OiK4xXb9/jAaQGS5lr0IW+MTUr1kvOSCwTuJH5BsusQgCLtr8gjEus3j0wMhcZkXsMXyxwAkO4WXzKmurujTSKv2KuYnRIhjxqsAkjFXU8C4n5CVBE52naCU/668OdJuYJUJMZNijsL4tIC8XOx2UFYFfrqlEvtXZcgsCLRg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oppo.com; dmarc=pass action=none header.from=oppo.com;
 dkim=pass header.d=oppo.com; arc=none
Authentication-Results: lists.ozlabs.org; dkim=none (message not signed)
 header.d=none;lists.ozlabs.org; dmarc=none action=none header.from=oppo.com;
Received: from SG2PR02MB4108.apcprd02.prod.outlook.com (2603:1096:4:96::19) by
 SG2PR0201MB2205.apcprd02.prod.outlook.com (2603:1096:3:c::9) with
 Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.4415.17; Thu, 19 Aug 2021 02:09:59 +0000
Received: from SG2PR02MB4108.apcprd02.prod.outlook.com
 ([fe80::98eb:b373:a778:a6a5]) by SG2PR02MB4108.apcprd02.prod.outlook.com
 ([fe80::98eb:b373:a778:a6a5%7]) with mapi id 15.20.4415.024; Thu, 19 Aug 2021
 02:09:59 +0000
To: linux-erofs@lists.ozlabs.org
Subject: [PATCH v2] erofs-utils: add mkfs.erofs and erofsfuse to .gitignore
Date: Thu, 19 Aug 2021 10:09:46 +0800
Message-Id: <20210819020946.22759-1-huangjianan@oppo.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <7e71b92c-9abd-582d-e934-268e69c1801f@oppo.com>
References: <7e71b92c-9abd-582d-e934-268e69c1801f@oppo.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: HKAPR04CA0018.apcprd04.prod.outlook.com
 (2603:1096:203:d0::28) To SG2PR02MB4108.apcprd02.prod.outlook.com
 (2603:1096:4:96::19)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from PC80253450.adc.com (58.252.5.73) by
 HKAPR04CA0018.apcprd04.prod.outlook.com (2603:1096:203:d0::28) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.4436.19 via Frontend Transport; Thu, 19 Aug 2021 02:09:58 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: abe89d70-e607-40dd-8fe6-08d962b6721b
X-MS-TrafficTypeDiagnostic: SG2PR0201MB2205:
X-MS-Exchange-SharedMailbox-RoutingAgent-Processed: True
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <SG2PR0201MB220566821758FF17FEF4A05DC3C09@SG2PR0201MB2205.apcprd02.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:1051;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: SwpHSKeghQdIrdxVZTK/Yg0Dfd2qQXBS0PDVPKRnPVYbb0rFil2bCOBUBLaZX00+MmCTTFZoXoLyF/LnpqAfDlKtLc3rOVJxRnvdDGbwBT4aHECP/4+AXIiOgnhAwCKq0PQzUVnnD5uHydh01k1mz8RhC+6tAbplfNR8+nBEy5YOVrDWw0rRJ0BYnUqQeetPUTp4g+AChZo/hNAo/p4DVDKoGG+iEaUvySpUouzlicbkhcJGt9y8QwpcWxPTGTsZ1hS9QgImwtMgGATJmnV0xotyi4i0mIgcdQuRqGKcERiua83jFnaW88A+qPz8tg7mrddg+3naex8YUjEDKdmXoZAGt/AaYZo7yscTJRhTd3zBaM4jAQ4MyTcj+tEtq6ITfLqWuW2eFXpwZR43abmHG0AfS22oV9wTCsV23b5pTbBKHsmsuLLTg0VAkR0oTpDLmhXdLvoLAbvQVHPVTS8dXgJHJ9arTc+kscONSwRUk28534P91avvQnTF1XzO9WIPWJPlRi0gGlnsqxwQ15yy1/77Xh2rIekcB2Q0dwr4X3Ag5I4Gliwf34mxZfYuCAOm181M5migeYq141Xwqvo9AsUaclib6Noplczzq56JDdwkr3YI9ziAAHbc73VqcxjsCLspTBv/QhnBcdhAUK4TLnpM2+F0joaITT7zYHNuUqzosK5ES0qXtxUUC1vIHFxFrUKowrBaDgsE7LUxbdC8oreFEvfJuTuUaKJ9XJX+3yVqBQgh/Jmo18wpES0B2TUv
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:SG2PR02MB4108.apcprd02.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(4636009)(366004)(83380400001)(66556008)(66476007)(6486002)(86362001)(8936002)(107886003)(4326008)(6916009)(52116002)(186003)(26005)(8676002)(66946007)(6506007)(36756003)(1076003)(6512007)(2906002)(38350700002)(6666004)(316002)(5660300002)(38100700002)(508600001)(558084003)(2616005)(956004)(11606007)(142923001);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?2iSBrTYHrDCzSwo07NmcR9a5jb3f6ffZ1EF+Mu47ZO6sSW6XI7pqFSu1+EA3?=
 =?us-ascii?Q?gqczwVfDAspiowLgj7GJL4aQZL72omepxGS4BHFKkMYCD4hxSWLjFsv2xfNH?=
 =?us-ascii?Q?5gaN+QLhdgHh5R2G0bDskT0r2eez+rDK4vDsaIn7CJLAvszz5PT1RZU0GDJo?=
 =?us-ascii?Q?h3I6FLSxoyGvYHiGYwldTrE1YqRW+dE4vxvL/M0aVvNHCzOi9udM6WI5vWzK?=
 =?us-ascii?Q?jsatxwfNY+z8KEIvvLmM+wFUfS57Jg1VAV2uoPv+TbBvWj7pAOETTI2WI7S8?=
 =?us-ascii?Q?pb+CMFv0zuUIa5lVpV5I/SMURIk5VCZl1fZgcwXq7HJaBUt3ia1EOH4UgCfJ?=
 =?us-ascii?Q?nBqWq3t3l2l/+5q+Uq4wdEJ0dmDRFHbqFCievXIfCqHCuBzry6BR6N7lpKS1?=
 =?us-ascii?Q?x1eNw7sD06D1E37DxuzqF0YpirMhjYtuBsFeC/ixYVebNjipN39kKYZNGTlQ?=
 =?us-ascii?Q?ddvC8nrRh2/N7MR5IlncCcKzaACIO8pGUe4iAwhbFfQdCz+Wm+2K953VUBNJ?=
 =?us-ascii?Q?DWjqSsV5wDpLY5lfhCb3km6+T87bxqdm81StMwrT/DbJ52gs2hpUzWVVKMqU?=
 =?us-ascii?Q?eXp13VDT9yhr6r97Gy2df/HK9BNYrFrOnOyFNISyBSmlwWpWeqdcUc4BVvFV?=
 =?us-ascii?Q?vmR/WFaYGFDxSSVQj2jVvJv1BaKD2tkmWWDm6LYBnImaRoCmOw3rv9qxk3cp?=
 =?us-ascii?Q?mYuVa8BjAEAYm3xtqJ0pEAZcKrKQC6NxQUgnXSzbiPIOwjHWTzfiLm+LgYxW?=
 =?us-ascii?Q?Y6gIeLcX7xGXpXXE9DoR2q9fEjHx/2FlJk74nadmgwYLejFD2OSAOoItkVvr?=
 =?us-ascii?Q?2okc62cf1LFvaX1IlCw585IePlzSBIfZJs0AZBv+5aOire286u2IVtYXoLX/?=
 =?us-ascii?Q?LXVLf7Bw9P4QM66dFTkexLEdjhLBhdb+gdI58gR2gzX5ymHo/91Esg5TnBSV?=
 =?us-ascii?Q?bnE0yPR7+3+DtujkAGKA/NtppRk26hB2SUIV1KoiD+m/9mYDsQ6AYqS9byQt?=
 =?us-ascii?Q?jvWrqhfTIhQSUdPWDgQvxY/4XSHnLYibMeFjdGHts8xnrM9mIUoB6g21s8rS?=
 =?us-ascii?Q?IbTGG1A0r5Dw31QjYldFSP/w7oGJCBz9RfSneJt9r1BANNG9putO1bttBQW3?=
 =?us-ascii?Q?qrkEadQ0DlaeBB/tdtgjHCpcd9oZ3Ug1VqDqxid24j0ug6UYYvR1wQ8LU75n?=
 =?us-ascii?Q?OluFdz0sZUm+SvW92A2NeC7H3o6cBdiZTaZvmxdWnYv1er3okGchBP/Vqo9L?=
 =?us-ascii?Q?/S8KXkzJdXg3b8JRrQoBX0qNX6ReLdb4gidDItIO1vF1A7ZfPQBecsbUH+9o?=
 =?us-ascii?Q?VKf0XlMXcHM/gvgG207mlj/d?=
X-OriginatorOrg: oppo.com
X-MS-Exchange-CrossTenant-Network-Message-Id: abe89d70-e607-40dd-8fe6-08d962b6721b
X-MS-Exchange-CrossTenant-AuthSource: SG2PR02MB4108.apcprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 19 Aug 2021 02:09:59.0163 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: f1905eb1-c353-41c5-9516-62b4a54b5ee6
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 6EeAMNMPF1MsNykdkG4twmFgL+4BTDWV27hKH81IILEE7i4kYlkHwr7BBn8ydUSuBly01z4WDaVbSieH1tDBbQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SG2PR0201MB2205
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
Cc: kevin.liw@oppo.com, yh@oppo.com, guanyuwei@oppo.com, xiang@kernel.org,
 guoweichao@oppo.com
Errors-To: linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org
Sender: "Linux-erofs"
 <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>

---
 .gitignore | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/.gitignore b/.gitignore
index 8bdd505..7bc3f58 100644
--- a/.gitignore
+++ b/.gitignore
@@ -27,4 +27,5 @@ configure.scan
 libtool
 stamp-h
 stamp-h1
-
+/mkfs/mkfs.erofs
+/fuse/erofsfuse
-- 
2.25.1

