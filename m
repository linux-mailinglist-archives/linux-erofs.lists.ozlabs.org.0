Return-Path: <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>
X-Original-To: lists+linux-erofs@lfdr.de
Delivered-To: lists+linux-erofs@lfdr.de
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2404:9400:2:0:216:3eff:fee1:b9f1])
	by mail.lfdr.de (Postfix) with ESMTPS id 878373224ED
	for <lists+linux-erofs@lfdr.de>; Tue, 23 Feb 2021 05:37:27 +0100 (CET)
Received: from boromir.ozlabs.org (localhost [IPv6:::1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4Dl5r52Flbz3cGW
	for <lists+linux-erofs@lfdr.de>; Tue, 23 Feb 2021 15:37:25 +1100 (AEDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=lists.ozlabs.org;
	s=201707; t=1614055045;
	bh=j5JTdod+6FuP8o1EXRuoASLPm+MfdsWe93G+uhP28k4=;
	h=To:Subject:Date:List-Id:List-Unsubscribe:List-Archive:List-Post:
	 List-Help:List-Subscribe:From:Reply-To:Cc:From;
	b=ESEj4u0lYE5PYwdw60QiWxl0gnlbkhOT+DuMOqFeY2THjxkEp5iSFn0y42QVqXGTY
	 pJTqwmjGAMtSbUxXv4f7RtGYjsh1ZUSHKMnGW/Dn2NDplfOLUlPYvzz1excfDxGbBN
	 SRNWifJyNV9G52IWLZDeLdm7KnBh+ZftZ2/pOq7em6mgqtBAtvsHQkyU7zmSek0Fyw
	 pHvcOby6vcQJRTUxC9y3YLQICvVMUp7j8UfSQZ+3/uuyFxWZc7NJPgcCcd8XXKo78B
	 NHnFyrQHXtkYBzwe9jh7cEsCVrM6HD8Xyph8CfsdZ6XgPd08r5SK7xg2LpRmvrHC6c
	 UC1LUIVM/H6Cg==
X-Original-To: linux-erofs@lists.ozlabs.org
Delivered-To: linux-erofs@lists.ozlabs.org
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized)
 smtp.mailfrom=oppo.com (client-ip=40.107.132.54;
 helo=apc01-pu1-obe.outbound.protection.outlook.com;
 envelope-from=huangjianan@oppo.com; receiver=<UNKNOWN>)
Authentication-Results: lists.ozlabs.org; dkim=pass (1024-bit key;
 unprotected) header.d=oppo.com header.i=@oppo.com header.a=rsa-sha256
 header.s=selector1 header.b=punzlMIB; 
 dkim-atps=neutral
Received: from APC01-PU1-obe.outbound.protection.outlook.com
 (mail-eopbgr1320054.outbound.protection.outlook.com [40.107.132.54])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 4Dl5r31XQvz30Kv
 for <linux-erofs@lists.ozlabs.org>; Tue, 23 Feb 2021 15:37:22 +1100 (AEDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=ZPWXlz6qHZqSTy5ptuguFCtQetjT6tU2/jVGB2m0XxaRc0qYrwZ6A60GLwzNwFfVzHWKdn0PA8s55VPbLLTWFWEs1zvOI3LVjtdUKX30cohV+Ztk8Z6bHgeLdOFBNdLG3pcyLOUWgxD+PKaVh+WvWbf3lT8BqQxnkbur6bKZH/z8THCnEAgYheu1+2TaZhvyoVuOEh2GWSbHRw9MCYkpvXeZSghJFtZq7eMNNCCArfX9l+mkqNlMABzZqkG4FHPjHx6fCUDBb3FqUrogU8cOYAu41nRZWUYt+7n1YHaXGp26RlHH1Z+BOE3EmgDLzXkwefXNxZPvvMlOyGbl55mxfA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=j5JTdod+6FuP8o1EXRuoASLPm+MfdsWe93G+uhP28k4=;
 b=bpoTsoag6H++Toe4Vi5+L+VgaLjB0KNhO9FgSeuou3e4URpESUPoZQ/Ym5iTD2EYlF24fYpoxe733WLcnXzuzpswink5zvBnkSMEikT7sUDqk6d4touW4B0qc+qeWpIA8gLvuwim0JaXnOlfPJdTWB8TTaDv4G34x6HCGbMLhbuHO8ZyKhJOgQp4PYMqJNqCVDNsnmaEMlMo7Oy8mb7eX3dJMnJXtMRBVjN/Zio/3F76wt2+vYnjD3J9fMn6N9ETgdN89laEzIOq6ppslCs3F+RKNC6KxqGLYx4LpP+V5JN7mapP3BM7FiiRxHqSAq/wb+LUaQauWqaGXOnuDj8/hw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oppo.com; dmarc=pass action=none header.from=oppo.com;
 dkim=pass header.d=oppo.com; arc=none
Authentication-Results: lists.ozlabs.org; dkim=none (message not signed)
 header.d=none;lists.ozlabs.org; dmarc=none action=none header.from=oppo.com;
Received: from SG2PR02MB4108.apcprd02.prod.outlook.com (2603:1096:4:96::19) by
 SG2PR02MB2559.apcprd02.prod.outlook.com (2603:1096:3:27::11) with
 Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.3868.27; Tue, 23 Feb 2021 04:37:13 +0000
Received: from SG2PR02MB4108.apcprd02.prod.outlook.com
 ([fe80::1143:a7b7:6bd4:83b3]) by SG2PR02MB4108.apcprd02.prod.outlook.com
 ([fe80::1143:a7b7:6bd4:83b3%7]) with mapi id 15.20.3868.033; Tue, 23 Feb 2021
 04:37:13 +0000
To: linux-erofs@lists.ozlabs.org
Subject: [PATCH v2] erofs-utils: support adjust lz4 history window size
Date: Tue, 23 Feb 2021 12:37:02 +0800
Message-Id: <20210223043702.36861-1-huangjianan@oppo.com>
X-Mailer: git-send-email 2.25.1
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [58.252.5.72]
X-ClientProxiedBy: HK2PR03CA0044.apcprd03.prod.outlook.com
 (2603:1096:202:17::14) To SG2PR02MB4108.apcprd02.prod.outlook.com
 (2603:1096:4:96::19)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from localhost.localdomain (58.252.5.72) by
 HK2PR03CA0044.apcprd03.prod.outlook.com (2603:1096:202:17::14) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.3890.8 via Frontend Transport; Tue, 23 Feb 2021 04:37:12 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: f64a44fb-ac40-481f-06d7-08d8d7b4b0f7
X-MS-TrafficTypeDiagnostic: SG2PR02MB2559:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <SG2PR02MB2559FF83B667AB25298CD094C3809@SG2PR02MB2559.apcprd02.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:5236;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: y6xt9tPV6IxneAb8QQZKau2moKlB/WkcvcnY3sEPXOVreGuB5j4z8bHTgUCUexh7U4gJMkb4ox193Sfml2Kls9PyltnNLBUgn8/ntAdicUhUv64Pz2dM0dnaY+tGRS4lL2+4Cu7rEOElpAxFwM3+cMmwC0tQLNOLdYE76i6k/H3kAqqZwHsH/ndYT8iOMtmP53xgondbQ59tT8OBMN2XiyrmQlws/DwfaIjDmB1q40OSMRYVgox4hIu7565ZV0P/WY0M2Yl79RWQ6XMw9DAfrwO3Ed98Je8Jr17kfpatAT+gP03hIRUt7Utvt3MjBiV34Q6T8pknKwiMlGCcMqMWNz+SU0bqz0TtbBvGqshDhUTrPng7JUwG3troIIA4cbf994pyiNmIIwyFpkhjE/DaZjNBQ1XMo6VhI1pwW5qcHIyIzfVWgKVSPusizaXtrQBG50nch7KaY2eb+VKm0GDppINJ/YqEltelG69rSPFDq5djc76xzOG8DCb8aHZLVfc+0ABQmTykeksIvK1S1BGFEm69hpwswXGoDYEj0PcHjdjRFFNBuF73243kfqcfUyf9sLrHr4W+1Qk5FdF4qrq/KZ+caJdef0vq1hxyTAIgn+M=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:SG2PR02MB4108.apcprd02.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(4636009)(366004)(39860400002)(346002)(376002)(396003)(136003)(5660300002)(2906002)(6486002)(4326008)(8676002)(52116002)(6916009)(6506007)(478600001)(66556008)(66946007)(66476007)(83380400001)(69590400012)(86362001)(107886003)(26005)(956004)(36756003)(1076003)(6666004)(2616005)(8936002)(16526019)(186003)(6512007)(316002)(11606007);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData: =?us-ascii?Q?zolbDA9fCqtN4M+e9h9/yUkrxmwY7p3k6xYsEWyK8YbxhPg5diwJXtLbBN3g?=
 =?us-ascii?Q?9vg9Ok5h19jE9MRy+X6orjJpV12kDB0xpfgfXnXGJIAOp4CEC7F98zLwyB7j?=
 =?us-ascii?Q?bXaKyfYWhVQ6HfM/7oIRtb8xXJ6ARTrruorYTYqyXW1HL+FJeETahXzo0MUv?=
 =?us-ascii?Q?ZYiSlf1XVRRxPsQ+Z4kSHZpQ0XUTtlcLuTSHsMSy7YYxAdb0iCLkQzkQH4sG?=
 =?us-ascii?Q?lUZBSY01PhnJC88zI+bIpVejIp4jH6PDiP6WlrfArUfoSObjJDxrYezbqmOl?=
 =?us-ascii?Q?U3s33FPcVI9C/Y3AA/9Yle3GnfikmiTqiDmid5tUf+CchpikNuz11tpajqC/?=
 =?us-ascii?Q?+P4mFPZQ7nFBKomz3ptfv3HEFFXIzIipVe1hQExnXTWVfbwuAU7eY9EGIagz?=
 =?us-ascii?Q?Vh071/X/4S4C0iaWlpkMsIum/93IUvzMv0DGOTzNbCgcUk/ZO/Fh69LCJdvY?=
 =?us-ascii?Q?QNCrd6tmYSvpQKDDqYZYfM0GrPAL+C/YSXDnI+oeEJdGSIspgHXygFRSVfg7?=
 =?us-ascii?Q?Ozkonrsb3BRO+k46nDDX3bA4Hflq6TdujwlYd05DtHhhjpXwDCbZqw+AFOVo?=
 =?us-ascii?Q?Al2Maan3xXlQv81LTSfwOXgHUEGisfILFxQwmb8wHkvo1Skm8AVKynzhXKXM?=
 =?us-ascii?Q?Kqpba8FX+7V7scc+1RcSysi72tTDjLngN+PlQ4IuIx0hZ3pBr2a7RbQMbpTY?=
 =?us-ascii?Q?ZWN6n0ZxXWCQEq6boDGiWtcZlwK66iLyGVJ2bQBu34taC4qMX3BTav3ETvWt?=
 =?us-ascii?Q?GCbLsH1GNhLROvZBO4XjXN+cbd2XmNgOh3arRtmOalHNq5DqGcAul3aOzrX9?=
 =?us-ascii?Q?9e3+5XIakK1rsJTtkBAvTpbAOc3vZEkkYwcvg9US451qemKBf8DKwYNHLrnm?=
 =?us-ascii?Q?V4R5qmYC6sy3vXX/BepsrlSdFhafsfppqjLtphOlHFxkKTeo9g//fFqxlh/E?=
 =?us-ascii?Q?RVjKVrWfYARMCRAearsiCFdXbXiTbh2FMlqbWfytOKYM7gEhBNb/38Yz0UDp?=
 =?us-ascii?Q?ml7sOMAEqbK/bLOWwvy1jB7HJAsSoXVrx/YOiqVYc1zXfKzpSBlBGIS8AmiO?=
 =?us-ascii?Q?Wc7dCLSvWqr0bqDyjk3pVbRkdp4wM2/r3cLZqjIBKX0XmyI70DkLgZdz6GK5?=
 =?us-ascii?Q?/JKsrqjxe2F4PqPR/tc/pLFov+DHnjttCQwr6xDHBSdg0GVPkmkrsM0xhcgY?=
 =?us-ascii?Q?5Mwx6Ho2NUl7UgDjOrVl0fZmZI9DuHxckM2E02hGL9pMxbYuFbrQ8+FdCzCT?=
 =?us-ascii?Q?Z/8U5jR5TxWUpKcMP5gOLaZnMXF16aMwHaHQzUaN+WT1P+uK6Yc03yL0HEJo?=
 =?us-ascii?Q?2mTnbHng0IW0T2hR2+Oz7HQ8?=
X-OriginatorOrg: oppo.com
X-MS-Exchange-CrossTenant-Network-Message-Id: f64a44fb-ac40-481f-06d7-08d8d7b4b0f7
X-MS-Exchange-CrossTenant-AuthSource: SG2PR02MB4108.apcprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 23 Feb 2021 04:37:13.8078 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: f1905eb1-c353-41c5-9516-62b4a54b5ee6
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: rY92CpMbLfzok2tQvOmN8FTQl+jWLK968VkvRwmhDr9frbbybWkCcHt2JNVbVJ1RujJox6vQN0mBqL3s2GPxXw==
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
From: Huang Jianan via Linux-erofs <linux-erofs@lists.ozlabs.org>
Reply-To: Huang Jianan <huangjianan@oppo.com>
Cc: guoweichao@oppo.com, zhangshiming@oppo.com
Errors-To: linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org
Sender: "Linux-erofs"
 <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>

lz4 uses LZ4_DISTANCE_MAX to record history preservation. When
using rolling decompression, a block with a higher compression
ratio will cause a larger memory allocation (up to 64k). It may
cause a large resource burden in extreme cases on devices with
small memory and a large number of concurrent IOs. So appropriately
reducing this value can improve performance.

Decreasing this value will reduce the compression ratio (except
when input_size <LZ4_DISTANCE_MAX). But considering that erofs
currently only supports 4k output, reducing this value will not
significantly reduce the compression benefits.

Signed-off-by: Huang Jianan <huangjianan@oppo.com>
Signed-off-by: Guo Weichao <guoweichao@oppo.com>
---

changes since previous version
- change compr_alg to lz4_max_distance

 include/erofs/internal.h | 3 +++
 include/erofs_fs.h       | 3 ++-
 lib/compressor_lz4.c     | 5 +++++
 lib/compressor_lz4hc.c   | 3 +++
 mkfs/main.c              | 1 +
 5 files changed, 14 insertions(+), 1 deletion(-)

diff --git a/include/erofs/internal.h b/include/erofs/internal.h
index ac5b270..9066910 100644
--- a/include/erofs/internal.h
+++ b/include/erofs/internal.h
@@ -79,6 +79,9 @@ struct erofs_sb_info {
 	u64 inos;
 
 	u8 uuid[16];
+
+	/* lz4 max distance */
+	u16 lz4_max_distance;
 };
 
 /* global sbi */
diff --git a/include/erofs_fs.h b/include/erofs_fs.h
index a69f179..f38cba2 100644
--- a/include/erofs_fs.h
+++ b/include/erofs_fs.h
@@ -41,7 +41,8 @@ struct erofs_super_block {
 	__u8 uuid[16];          /* 128-bit uuid for volume */
 	__u8 volume_name[16];   /* volume name */
 	__le32 feature_incompat;
-	__u8 reserved2[44];
+	__le16 lz4_max_distance;	/* lz4 max distance */
+	__u8 reserved2[42];
 };
 
 /*
diff --git a/lib/compressor_lz4.c b/lib/compressor_lz4.c
index 8540a0d..292d0f2 100644
--- a/lib/compressor_lz4.c
+++ b/lib/compressor_lz4.c
@@ -10,6 +10,10 @@
 #include "erofs/internal.h"
 #include "compressor.h"
 
+#ifndef LZ4_DISTANCE_MAX	/* history window size */
+#define LZ4_DISTANCE_MAX 65535	/* set to maximum value by default */
+#endif
+
 static int lz4_compress_destsize(struct erofs_compress *c,
 				 int compression_level,
 				 void *src, unsigned int *srcsize,
@@ -32,6 +36,7 @@ static int compressor_lz4_exit(struct erofs_compress *c)
 static int compressor_lz4_init(struct erofs_compress *c)
 {
 	c->alg = &erofs_compressor_lz4;
+	sbi.lz4_max_distance = LZ4_DISTANCE_MAX;
 	return 0;
 }
 
diff --git a/lib/compressor_lz4hc.c b/lib/compressor_lz4hc.c
index 6680563..00fa2c2 100644
--- a/lib/compressor_lz4hc.c
+++ b/lib/compressor_lz4hc.c
@@ -44,6 +44,9 @@ static int compressor_lz4hc_init(struct erofs_compress *c)
 	c->private_data = LZ4_createStreamHC();
 	if (!c->private_data)
 		return -ENOMEM;
+
+	sbi.lz4_max_distance = LZ4_DISTANCE_MAX;
+
 	return 0;
 }
 
diff --git a/mkfs/main.c b/mkfs/main.c
index d9c4c7f..4c9743d 100644
--- a/mkfs/main.c
+++ b/mkfs/main.c
@@ -299,6 +299,7 @@ int erofs_mkfs_update_super_block(struct erofs_buffer_head *bh,
 		.feature_incompat = cpu_to_le32(sbi.feature_incompat),
 		.feature_compat = cpu_to_le32(sbi.feature_compat &
 					      ~EROFS_FEATURE_COMPAT_SB_CHKSUM),
+		.lz4_max_distance = cpu_to_le16(sbi.lz4_max_distance),
 	};
 	const unsigned int sb_blksize =
 		round_up(EROFS_SUPER_END, EROFS_BLKSIZ);
-- 
2.25.1

