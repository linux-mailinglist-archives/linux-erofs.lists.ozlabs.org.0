Return-Path: <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>
X-Original-To: lists+linux-erofs@lfdr.de
Delivered-To: lists+linux-erofs@lfdr.de
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	by mail.lfdr.de (Postfix) with ESMTPS id 7130D6B2465
	for <lists+linux-erofs@lfdr.de>; Thu,  9 Mar 2023 13:42:04 +0100 (CET)
Received: from boromir.ozlabs.org (localhost [IPv6:::1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4PXTMt2Pmqz3cMy
	for <lists+linux-erofs@lfdr.de>; Thu,  9 Mar 2023 23:42:02 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=vivo.com header.i=@vivo.com header.a=rsa-sha256 header.s=selector2 header.b=hbuJDvum;
	dkim-atps=neutral
X-Original-To: linux-erofs@lists.ozlabs.org
Delivered-To: linux-erofs@lists.ozlabs.org
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=vivo.com (client-ip=2a01:111:f400:feab::71c; helo=apc01-sg2-obe.outbound.protection.outlook.com; envelope-from=frank.li@vivo.com; receiver=<UNKNOWN>)
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=vivo.com header.i=@vivo.com header.a=rsa-sha256 header.s=selector2 header.b=hbuJDvum;
	dkim-atps=neutral
Received: from APC01-SG2-obe.outbound.protection.outlook.com (mail-sgaapc01on2071c.outbound.protection.outlook.com [IPv6:2a01:111:f400:feab::71c])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4PXTMh40R8z3cLr
	for <linux-erofs@lists.ozlabs.org>; Thu,  9 Mar 2023 23:41:52 +1100 (AEDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=OFyQMCpvCjwpcH7Xhmc/CCrU/Wp/qpLeZb/GB/mLlrNkemJkxfQsdH0XoWkHxwNNw2bwE15f1It99Eebow29i6hXrb+CG/0qRg+wkeg5w6M6+OcRIFywkCY/8FZzK5mS1o2HawkQljlvYXujKe3LFGk/8mYXfqQyFJwH7pRbF7KM2RIPpvXTiphT2WEeex8jJaDPldz8BiyQ0oHDIwxFXSXIuaap3jpsW75VWNNUxJhVn2ep1Go1Jh7uNIqUsEL8B+M13zsQaoD3ijIDiUm46cPtYHKqUYt4F4OLo2eAQFzqAatn4ycLUpdkFwAlS2Emwtu5lojASGfA/OUVUniP5Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=meK3eJWZv3zCgZpfoN2XpmXl+kR+wlAHWD36VfQ5CfE=;
 b=bOzbuU/h6YA5gFpxMp7vdOR7JC2M+lw9SSX0w9HQvXeiI5J2eT/MieLYXRLOuN+7q217IDSL5tdx5zgB7jRoN27fh1JRNNQXL8JRbRLpQmWVqrP4+OrK1CaUL2KsTut9AgubJEBYN9gU/k/diSjJ/uXQ7FSxVrsrME9LllvoUntzOwCdcMbnN1SH+T1I6/hj3g0FMtV4Mbe0lRfYWFX9IShKk1HinTvKAsdqNvtRVJl/0nJK+9LuMhwZkqRpFBL8nt/11Ndij4sq3suXEqMFtNq5VzdU0MpEUVjM6bYgjzxKTlMx8MsbGEAiPIDNp12IfYwr32R0o3RvXQTsmmCQyg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=vivo.com; dmarc=pass action=none header.from=vivo.com;
 dkim=pass header.d=vivo.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=vivo.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=meK3eJWZv3zCgZpfoN2XpmXl+kR+wlAHWD36VfQ5CfE=;
 b=hbuJDvumQukOVUFj7PR3cO6foLEEqTlEy4wFo+7H1+GCF5Bj7qbBhr7EgXFkh52+Nlf37UdMaOlgZGocoFYWxVQaWhup4o118UdPmL4ejfsFbak2ZJ2zRwQjNT+C5Yxn7H+abYsYAPHCZNTkg5M0Fr6FD7az9+u0Z1XuSvEps8vj1v8CEgKhwqQFzD2AkUwwlrKOx9d0Euih/8gYh6sacTikQGMZy+4FLXLiwJvqTf8SMX31oH/QS3ZONhuyydBrHmbR0KsUR914QHygTS59KjnEnfZ6FZj9HXMgR6Kav1U9KiUInuJbEDloeP8Jv++cf28PjPK2OnDW+HT/bkLLMA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=vivo.com;
Received: from SEZPR06MB5269.apcprd06.prod.outlook.com (2603:1096:101:78::6)
 by KL1PR06MB6259.apcprd06.prod.outlook.com (2603:1096:820:d9::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6178.18; Thu, 9 Mar
 2023 12:41:37 +0000
Received: from SEZPR06MB5269.apcprd06.prod.outlook.com
 ([fe80::daf6:5ebb:a93f:1869]) by SEZPR06MB5269.apcprd06.prod.outlook.com
 ([fe80::daf6:5ebb:a93f:1869%9]) with mapi id 15.20.6178.019; Thu, 9 Mar 2023
 12:41:37 +0000
From: Yangtao Li <frank.li@vivo.com>
To: xiang@kernel.org,
	chao@kernel.org,
	huyue2@coolpad.com,
	jefflexu@linux.alibaba.com,
	tytso@mit.edu,
	adilger.kernel@dilger.ca,
	rpeterso@redhat.com,
	agruenba@redhat.com,
	mark@fasheh.com,
	jlbec@evilplan.org,
	joseph.qi@linux.alibaba.com,
	viro@zeniv.linux.org.uk,
	brauner@kernel.org
Subject: [PATCH v2 4/5] ext4: convert to use i_blockmask()
Date: Thu,  9 Mar 2023 20:40:34 +0800
Message-Id: <20230309124035.15820-4-frank.li@vivo.com>
X-Mailer: git-send-email 2.35.1
In-Reply-To: <20230309124035.15820-1-frank.li@vivo.com>
References: <20230309124035.15820-1-frank.li@vivo.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SI2PR01CA0006.apcprd01.prod.exchangelabs.com
 (2603:1096:4:191::14) To SEZPR06MB5269.apcprd06.prod.outlook.com
 (2603:1096:101:78::6)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SEZPR06MB5269:EE_|KL1PR06MB6259:EE_
X-MS-Office365-Filtering-Correlation-Id: f57bed93-7152-467c-dc4b-08db209b9fbc
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 	E28tnN0AujbpmRZCk6r838sx8XzdR4QOnZsbXrmykSp75UD0A/y6Xm5/d1Ij6fV5gqqK1fM5Ekm8uo4q9tyermXalqW8exywaZz9u84vs7iCAzxGkSyj9PtnlY2cUDRFyFf0hIUI72uhsAM4dZU0+svfl0xLcAyEkWF8WRH7n8igQD6+1HQELI7qKJSK6YnXKhLvlMEofu8hvRAQ4hy04oKbyrz/13Vymu57P9Ug7wZCdkaBWJTgAIZ8HNtDWFyFEDQiAtTJH2icaH57ug9SjLUALU0QoHPT835TGfBqFLVTZGynRgLgA69eSIwby3BRHljMFP4Mbq8GDQ0Ofa40kx88YKyDRS9ZUeiPwCrLkqia07KxJvBBGcmJ/xpZj7kbBaDoOv4FCJ+N+GyG0VUp1Y1AHT7NgWzwAP95LfiV/ye9dZwA/tdM1UDPmm3BiXR073VQpy1vQcn3us6VcFIZm5r1SiK461i1Aj3lShlFlcg1UqxSC2NPd23+FhS8g1R6k5KMyt2v7Cr0voq2BMgFjZBhr+fI0WbotS1JzEmM6urQMgV25THqSRF5u+XkSKvzW7Rsv9WPTFqmBpBeBcAwM1IKmUaz07UWa9ODGif03lnzt1Fw9P8yNM3q5UEKAo401R1egvamSqc3mdR/OpbuhZaCkTsJwcAmEhG2/an81pmQ0VfvGBudEB1htMym3VEJr/3vlvsE4eeAWGD4C3cntAXt96KoIZucnq7+mXXEa7M=
X-Forefront-Antispam-Report: 	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SEZPR06MB5269.apcprd06.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230025)(4636009)(346002)(136003)(39860400002)(376002)(396003)(366004)(451199018)(36756003)(186003)(38350700002)(38100700002)(86362001)(1076003)(6512007)(6506007)(26005)(83380400001)(6666004)(921005)(2616005)(316002)(5660300002)(52116002)(7416002)(478600001)(6486002)(107886003)(4326008)(41300700001)(2906002)(8936002)(66946007)(4744005)(66556008)(8676002)(66476007);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 	=?us-ascii?Q?ZgLxxfX4t1McWSOmo8olL9zhL7a+yo63tKZgLEGPM+bFjj1dBBDPgqMRTNYr?=
 =?us-ascii?Q?BdNh+bcEBs60dG1kBA1T8LqDM2DBpmriz8QVdQ8I5YRldTo/o0LA4YmRFQIE?=
 =?us-ascii?Q?wCXmlTxZ9T1VixePb+TUTweGwczPXYu6Nclr35lrviR4qPBrR5+9jqNCK3i4?=
 =?us-ascii?Q?dJ65DOgTl5UpWXZnOKz2IAUOFJ+zFjsIujWf0QJkwI6PrC6AlYUbwISfAwHC?=
 =?us-ascii?Q?qv1Kug2wkxDx+gQbGlmTaNXf13ctN1hy9cVeWJCmfibRdWOXtd7hlqmRvxqb?=
 =?us-ascii?Q?GCf8Rg1aOtowXDdD6hXEyBd4UtAF4EnC5Wc5uBeJkUckL7B4wmqlrdxpTtHu?=
 =?us-ascii?Q?wXhbnLUXEF+VZ0wxfL34qbS1hglNwPC3BCoUfCV8lS3hTMQV2keqty2HWZF6?=
 =?us-ascii?Q?uKKTJ4lqYMfWycqedrniZA8JcqMAWz0WTOl6/SAPlpk+zUqVfSjyCf2MSax2?=
 =?us-ascii?Q?GRHX+GHdeh+FShO6d/BOdSyp/+IRpMACzUHjwaof9itmgu+f2mSOWkRqmocJ?=
 =?us-ascii?Q?tjxDGwZCmJIa9aqU+Z6lKd2xF91EMuSorqtUNRedXaF/LK7ALBGPWtAi3BLP?=
 =?us-ascii?Q?h+lkurzDb0WUQDgRqnysv5d/COtRXH05I3mM66bozQLd1mXkXoFYC7U5AIMj?=
 =?us-ascii?Q?exs/wgEBcf6dJI6PZ1WoDqR+0sWa5ywRiqnsW3gpKNARmaRrm4406eKYqBRX?=
 =?us-ascii?Q?S77jqkPxhCbv7hA5j6Pql8fD9kK24AgBpkLqKcaHPK5UxSrXhEg6P5qQLwWv?=
 =?us-ascii?Q?YjgcYGzuAKbTl3BiBVMZQf8zOdMcpaccIlxzTDZoXw9P38m0p9X1Z9oukxmW?=
 =?us-ascii?Q?9M2l8RkIJWhi513JMNzHLQJHYNPohSqZ5jRc2xXGKranwyox7Lzuo1yip4NX?=
 =?us-ascii?Q?ZwPVxEQTJMxTDETm3Cbl3jubdEuUPrqUtqayzUrbPf2x9Mjh2elkySCbw1W+?=
 =?us-ascii?Q?6SDF8HHE4DDj5rolI3PVZSZWRidhigHkDXhSfPAaLY6kxnNv4H61bNASph4i?=
 =?us-ascii?Q?DMVn2VzhIkWX5UmYrh2KZ5UdKic1EHB5I4Wpnc24yahLnC9lcwqii790St9v?=
 =?us-ascii?Q?dihSvgB7cq8I3T636aCs4nLu5qveMGVPoiffRqhCeb2slcz9rrxMZCJfmLr8?=
 =?us-ascii?Q?SoFdCPQlH4Gpc7hjQzxqsMtPRpY/unsSgY05CLAaSbwoUql6sY2qi7xerVnz?=
 =?us-ascii?Q?J+CVfv0nLJGPOvNcGLYaDlcK2+rgzc+TAY2Uc0nIiDyTSwVUwRF7DxB4sLmg?=
 =?us-ascii?Q?GDDZuM+U8VZDMhE7+B+0Pz/lKF3vb/10W9h+7lh78fxVUZsKr35Hro9vcoC7?=
 =?us-ascii?Q?oFLLXiuIUKdLS9kPIsgCsQbjGDvksOX439gN7RNXRsoalHG4mo90TeSjY0ip?=
 =?us-ascii?Q?NOslqK3EeE1XK4NeHXtMcBUV+Yn30bgkYAUbmh0BRAyQ5V+Wcu01YEa4e+mz?=
 =?us-ascii?Q?/xC7dvzkBbTYyMGnVzWcYSHuHEsyfTERq8r1jky+K/eokdE3nU9CZvzqa/AK?=
 =?us-ascii?Q?YigYmMsAhbEipJNkqVjr6NCFBV0YIiIey43i4gSFjSAfuv+c+73bFArtWwhQ?=
 =?us-ascii?Q?LIYXU3Gvwf5DzvbRR13H1DRwVgktRb/byIy68c6l?=
X-OriginatorOrg: vivo.com
X-MS-Exchange-CrossTenant-Network-Message-Id: f57bed93-7152-467c-dc4b-08db209b9fbc
X-MS-Exchange-CrossTenant-AuthSource: SEZPR06MB5269.apcprd06.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 Mar 2023 12:41:37.6749
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 923e42dc-48d5-4cbe-b582-1a797a6412ed
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: +dlKu3pch/ixyeDj8WZgn90xdOKVnn/PxaOGafWNX4R/lfto4+glIrZ4a8O+iuorfDlSeTgLt506p+3lDGMYdA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: KL1PR06MB6259
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
Cc: Yangtao Li <frank.li@vivo.com>, linux-kernel@vger.kernel.org, cluster-devel@redhat.com, linux-fsdevel@vger.kernel.org, linux-ext4@vger.kernel.org, linux-erofs@lists.ozlabs.org, ocfs2-devel@oss.oracle.com
Errors-To: linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org
Sender: "Linux-erofs" <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>

Use i_blockmask() to simplify code.

Signed-off-by: Yangtao Li <frank.li@vivo.com>
---
v2:
-convert to i_blockmask()
 fs/ext4/inode.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/fs/ext4/inode.c b/fs/ext4/inode.c
index d251d705c276..eec36520e5e9 100644
--- a/fs/ext4/inode.c
+++ b/fs/ext4/inode.c
@@ -2218,7 +2218,7 @@ static int mpage_process_page_bufs(struct mpage_da_data *mpd,
 {
 	struct inode *inode = mpd->inode;
 	int err;
-	ext4_lblk_t blocks = (i_size_read(inode) + i_blocksize(inode) - 1)
+	ext4_lblk_t blocks = (i_size_read(inode) + i_blockmask(inode))
 							>> inode->i_blkbits;
 
 	if (ext4_verity_in_progress(inode))
-- 
2.25.1

