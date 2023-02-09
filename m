Return-Path: <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>
X-Original-To: lists+linux-erofs@lfdr.de
Delivered-To: lists+linux-erofs@lfdr.de
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	by mail.lfdr.de (Postfix) with ESMTPS id 8218268FFD9
	for <lists+linux-erofs@lfdr.de>; Thu,  9 Feb 2023 06:21:01 +0100 (CET)
Received: from boromir.ozlabs.org (localhost [IPv6:::1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4PC4vv2vZ9z3c4B
	for <lists+linux-erofs@lfdr.de>; Thu,  9 Feb 2023 16:20:59 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=vivo.com header.i=@vivo.com header.a=rsa-sha256 header.s=selector2 header.b=L+RjT8kK;
	dkim-atps=neutral
X-Original-To: linux-erofs@lists.ozlabs.org
Delivered-To: linux-erofs@lists.ozlabs.org
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=vivo.com (client-ip=2a01:111:f400:feae::703; helo=apc01-psa-obe.outbound.protection.outlook.com; envelope-from=frank.li@vivo.com; receiver=<UNKNOWN>)
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=vivo.com header.i=@vivo.com header.a=rsa-sha256 header.s=selector2 header.b=L+RjT8kK;
	dkim-atps=neutral
Received: from APC01-PSA-obe.outbound.protection.outlook.com (mail-psaapc01on20703.outbound.protection.outlook.com [IPv6:2a01:111:f400:feae::703])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4PC4vm3Vj0z3c4B
	for <linux-erofs@lists.ozlabs.org>; Thu,  9 Feb 2023 16:20:50 +1100 (AEDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=BAfit2X2LR135TX2vKQKGxc+0tdCbzeUWBro1e0RnDnzQm1xtFgfSCTu1RO+rnyuoei8mMXzN2hUS6Df540bwz92qjDI5eGyKFOWqMdp9HjBM6dK56TG2GxJZu4+WEjn/6Tzuk1nLgpTV+dKOhxe0kxhfdXLKst2YMfEZ5LVxqchVm5jjCiCzOHfdAuAfAeSdHzBVuzo1D8bXZ1YKkfqKYukKzOxbQHdWSIRZLuwcnkuewLCU4jdgDOjSa2e7P5aGwVEsuZXl31tHmJOsSQfbtedrnGezecyOSHEaSoF1J8p0OvMSmGwNAqPLZOBukGOOnyOwwqB2Q0FyLgD6zmIfA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=3JGl8KFZctzLkJX0zA/UUfpUfaxkrMddEbbmxDYVQLQ=;
 b=LsfayCrOb1uYoo4dC8jGpaxZbMERUqUx/Qqg8TQVudonwg0h5nxcyXBfW3sR5khmRAViKhscVejBpgLSIzHbUz8sVLSQaRZGaJp1L6Idts4xFFLbvyRfUZ7QeJyzNV6HL6+7aTUiWV1XDhObwWDf7ztVhiSf0YN8ZyJ8gFbxjlb7W5ptyhkcrSUZNSZ2lZt+z9PzCQBscU8hVnl6DfY6VvVcpqO195DBKUuRXD0oAyZNbqLDOQN0fi9kqi/3zNXflishRP7xi/S9DhxS6pRkLnGkAJCHv/wB4381WFK0uDlbpsCCQUXM5n7GC2Qz/OJen/nhMeXvpjxVK8aCBq7DRQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=vivo.com; dmarc=pass action=none header.from=vivo.com;
 dkim=pass header.d=vivo.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=vivo.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=3JGl8KFZctzLkJX0zA/UUfpUfaxkrMddEbbmxDYVQLQ=;
 b=L+RjT8kK8yIyP+InjVBnygFbtlRvcOqNo7sNNoq8TVaiyRMvbdtra0ryMF2YvP95FOKMUgDQcXUDFe2RDrIODspLdUWDFUWKph8o6yGSh7lmF/WeNEgOnrd4jm065ZcXAWPAF2UPuOCPWyqVoFPmr64jVlwOPcxj4VzjHA9J3o3C/Gy6D2y5cmpnnBhqE412sYtuYHBuBs3aEijxBrnjlf0mzc4E4RISGeokpFxAyUDODWS0jl9oy9qehQsKedKPwREV2Skg8xL1t1inLK0+cuo5Q+bCz3DPwPxADka+zcUZa2exaXPmSsGANSq/FezoRaujoRDTCyDFJPrSXlOTrg==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=vivo.com;
Received: from SEZPR06MB5269.apcprd06.prod.outlook.com (2603:1096:101:78::6)
 by SI2PR06MB4251.apcprd06.prod.outlook.com (2603:1096:4:154::5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6086.17; Thu, 9 Feb
 2023 05:20:24 +0000
Received: from SEZPR06MB5269.apcprd06.prod.outlook.com
 ([fe80::3e52:d08c:ecf4:d572]) by SEZPR06MB5269.apcprd06.prod.outlook.com
 ([fe80::3e52:d08c:ecf4:d572%5]) with mapi id 15.20.6086.011; Thu, 9 Feb 2023
 05:20:24 +0000
From: Yangtao Li <frank.li@vivo.com>
To: xiang@kernel.org,
	chao@kernel.org,
	huyue2@coolpad.com,
	jefflexu@linux.alibaba.com
Subject: [PATCH] MAINTAINERS: erofs: Add Documentation/ABI/testing/sysfs-fs-erofs
Date: Thu,  9 Feb 2023 13:20:13 +0800
Message-Id: <20230209052013.34952-1-frank.li@vivo.com>
X-Mailer: git-send-email 2.35.1
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SI2PR01CA0045.apcprd01.prod.exchangelabs.com
 (2603:1096:4:193::19) To SEZPR06MB5269.apcprd06.prod.outlook.com
 (2603:1096:101:78::6)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SEZPR06MB5269:EE_|SI2PR06MB4251:EE_
X-MS-Office365-Filtering-Correlation-Id: f81aa1c4-3bc7-41ad-8c91-08db0a5d586c
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 	cx6ZvByu0PJqPugASqJ4tB+ObeNH+sj3dZGsCWoVUcBmTu2xkl5bE9KSbnTWQVAUqMMaWmgstx6ZTOwiHtS9G9gjyiiOns+ewOC5q3sDfSpR2iOYsxgVkOfnQq+uFYH+ZCjYWiXIC7YzJif89Wx9KDkV5Xn4LQfK+WNMfsMgzt2m+KO2eWc7b7fFULJ6TxQlL5LIQ8XH7V7r28Q5vYm8UYG5DOS6llEp52Z2mA8aQWk1Gl/b3/49BONT3KreCaaR7RjBqb4EVhQQJ8rM03JuD3shlOvjwi5Furh66cnMtS6GuDkdw0p3qr3a9LGz6gF54z1qYELWXt/EG+AUu3Ghk5/U7uLcdIGTnzUh7dGXpFj47Vn2qs9fQNE3eI+39Q7C/qg3sj6UpHPbI01P78UwnzgV8c3Qzckd2htR3Wtn2hMbtCKKn7sAvDivwWVny63ZcrWkBJduCQZhEYUuDfGNPRwRg6CU52xCj75koa/lXM/maEfI3OuzM+Y96EKD4ny0iTdl3KuOnk1hr/Lu8BNzJr2HsmNlvC/cg29Wta5xiRDd0XN/vSUXM11kCJG7NbWrJ6rWDPCzhYreyLJ32euPqrWoDWxqYpWPgaoU3MdYqO1tfLH88mXItiouyL+BEGd7wL+BLVZch32G1k8UBZRHgSSIc48Dx7koXqruUtvRvxK476Kl8UTIIhrCWMqfvV7TVoxT28TvCiiBrps0fAYTQg==
X-Forefront-Antispam-Report: 	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SEZPR06MB5269.apcprd06.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230025)(4636009)(396003)(136003)(366004)(39860400002)(376002)(346002)(451199018)(6512007)(186003)(8936002)(4744005)(5660300002)(2906002)(36756003)(4326008)(38350700002)(8676002)(38100700002)(66946007)(66476007)(66556008)(26005)(1076003)(2616005)(41300700001)(6506007)(86362001)(6666004)(316002)(52116002)(478600001)(6486002)(107886003);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 	=?us-ascii?Q?swaMveYbUy3tf72FDQg48QjkrY/Fqnukdy4yCQbx+8QOXtdlCAQauFvpO232?=
 =?us-ascii?Q?uY7r/9+w7bSXhnEZ69FXiDRmjszYsbaJwx9Oma7A0BE0+T9mtk8W9eRaUZJf?=
 =?us-ascii?Q?0wOgqlU6uu9X8Bd+bftgCchSt2cC0nk5bdWEeer2WhDav03CyymRjzPlcDQP?=
 =?us-ascii?Q?dl5C8qQwDX0ez1w+kccwHLB/rTaJsbQH38GV5hP7drtvsZolzu1zuASasrRh?=
 =?us-ascii?Q?PRHpLmXdNkOpW5HR/o5bC1C5jdxmMoo/72Svqv2B2m0KiDyOZEQcn5HsVY4y?=
 =?us-ascii?Q?SeNr+57kv29o0ld9kRKtIBLTp2xjLtGs44cRxzOsFlfVAzJMbHV3/IxjIPAY?=
 =?us-ascii?Q?d8Ygu+uPNvmrVeCAiWLAdC7mKu/JSEt1mqaK8rD2a9Qdbtmiy8qpHb/DQmbE?=
 =?us-ascii?Q?cUr2cYerkZklrY9S0qBCD/wTOIj+LmdsC/W5MmL0tlqZJkb6Szq2ZHKbQlfX?=
 =?us-ascii?Q?+bDmzhG17J1Pd0QcXg5PTMv9yGsBIettQqXGPw9mLu+00OLEZkvKwTJFAXjh?=
 =?us-ascii?Q?W8yxTfQapHeVVq64rf8cg+RIoAiHq4esbaf+xXje+NbdghGLsCHpzMxMY3bi?=
 =?us-ascii?Q?0UHWpX+Q0B/gIy3HfbqBdziJKjAuIIGN3C9Mg0+pB87osGNQmqIZYD/qXVdx?=
 =?us-ascii?Q?Np7uy/9p0AKdqPW5yfPrZDiiiVHd9NprSv0F2cJ7q+UNa5U68vHZv8RyBQjJ?=
 =?us-ascii?Q?BhLWJov3c0V2j68aAxb/cQXInrsqXCQfqecKxee+EhbrwHNYnZp0Umc5zWpm?=
 =?us-ascii?Q?il8y5+5+gsbu/LV0pj+/2+S159UYR19iCP42ZXyzyW0gHxXsuWEphHbfyphh?=
 =?us-ascii?Q?1P+b2dn4cdrI+hGsj8X+7At1XkPhT+gdvfqk2OHbEmDi6uFnu/KLRvQXc7x/?=
 =?us-ascii?Q?JU0s91bnAQlDdPCBEGKD+voTgu76KRfikml/Zi+9Wk+qd4MUqI8JDvlC4CKi?=
 =?us-ascii?Q?FMtHE+AWSZzioxuB2kcEJonp++N6sRXpkrbtm5zhlzUHv8a7qP0+WbnD5qMy?=
 =?us-ascii?Q?43I4f01rZJOtGeiaGE0RpJI4tXTWQco/kMgfKiPGNTv7XPh7uUiwk4F7LiP9?=
 =?us-ascii?Q?B8cIaD4VbS9Sa5RF5w5qyzgfPVI+99W50a+Ow3iY9uX8uGC/rQ3XomP8g+AR?=
 =?us-ascii?Q?B56r11UcAm0IgnLiPJNKC2B/PNWcBaZVFYABAM+kyKpu7POljhUf5Wbj4Fn9?=
 =?us-ascii?Q?5XQLgn34CVZWOOtkWenGpfu1NaJk+PBzpTjfPXQl0cNg/hT6gqbtSy46lLF5?=
 =?us-ascii?Q?Xm1zGfahocl6eG5a8lfUwlzIM7K1iniJw8u/fBFTwLLym+LbPxT9btky9v8a?=
 =?us-ascii?Q?BLfkeX+LJIPT9+txnOGNuafkvd5SXJ5VdDWn7hRbUKGMeXgi9aMWLmkBbVd7?=
 =?us-ascii?Q?207IM6VKsJ5PcY4IjOooUdI+xP/wk9rr6tneGYrUS+b4oqfNSFvrWDA/2C3h?=
 =?us-ascii?Q?rJ/6wBsrzf+/28hsiPUDv7vHCpbRV73Lylvc11kRQUvzTKNvCGNXGOWefNhu?=
 =?us-ascii?Q?+bjidp/jp/kohDfw+yDBvOkznUooa84Qgkueik2EKwuJubRUdlTt0A5v7hob?=
 =?us-ascii?Q?KqXUxJkSTu0BKTN9K3j89CLsAugnnSOPWIMnax8b?=
X-OriginatorOrg: vivo.com
X-MS-Exchange-CrossTenant-Network-Message-Id: f81aa1c4-3bc7-41ad-8c91-08db0a5d586c
X-MS-Exchange-CrossTenant-AuthSource: SEZPR06MB5269.apcprd06.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 Feb 2023 05:20:23.7145
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 923e42dc-48d5-4cbe-b582-1a797a6412ed
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: PFNb9n2JUY7LlRoLfQUzKU/LFWxILRnYS35R2kkBRd5M5MoKmIKL1RED4rYsqnvgoIrsPy3tX3/9Gpx1mTGB1A==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SI2PR06MB4251
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
Cc: linux-erofs@lists.ozlabs.org, linux-kernel@vger.kernel.org, Yangtao Li <frank.li@vivo.com>
Errors-To: linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org
Sender: "Linux-erofs" <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>

Add this doc to the erofs maintainers entry.

Signed-off-by: Yangtao Li <frank.li@vivo.com>
---
 MAINTAINERS | 1 +
 1 file changed, 1 insertion(+)

diff --git a/MAINTAINERS b/MAINTAINERS
index d0485b58b9d9..7d50e5df4508 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -7745,6 +7745,7 @@ R:	Jeffle Xu <jefflexu@linux.alibaba.com>
 L:	linux-erofs@lists.ozlabs.org
 S:	Maintained
 T:	git git://git.kernel.org/pub/scm/linux/kernel/git/xiang/erofs.git
+F:	Documentation/ABI/testing/sysfs-fs-erofs
 F:	Documentation/filesystems/erofs.rst
 F:	fs/erofs/
 F:	include/trace/events/erofs.h
-- 
2.25.1

