Return-Path: <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>
X-Original-To: lists+linux-erofs@lfdr.de
Delivered-To: lists+linux-erofs@lfdr.de
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	by mail.lfdr.de (Postfix) with ESMTPS id 91A7831E965
	for <lists+linux-erofs@lfdr.de>; Thu, 18 Feb 2021 13:00:36 +0100 (CET)
Received: from boromir.ozlabs.org (localhost [IPv6:::1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4DhCvk4r6Tz30MG
	for <lists+linux-erofs@lfdr.de>; Thu, 18 Feb 2021 23:00:34 +1100 (AEDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=lists.ozlabs.org;
	s=201707; t=1613649634;
	bh=1LbjuCBmMXbogQtEh1hFGFgEdEHzm025f9NFbknWDX8=;
	h=To:Subject:Date:List-Id:List-Unsubscribe:List-Archive:List-Post:
	 List-Help:List-Subscribe:From:Reply-To:Cc:From;
	b=eG4MSL02z+8tgM2xLP6R/zps2Dp5xZdhBtX0nad/cZer00IMQ6B+P/K5+nVmcx2Qy
	 KQk1m7seLCnLfumLgwVS193Dy75SUk96fMCXoGKIUgFuA8zsxyL2jHb7wa40Zqo3GC
	 QpkmKykl93OGh7L6e6yEv0TArpxtJZTXhWR7EeAgaDI2Npl3Gv4bEo0QOmmf69vpZp
	 5jOwAjfIUR4v9Xs1iqFhnawrjT2uSSZ8s957R/c7zPXuMIEUKfS+o3Yl4/bgwGLFrr
	 LfS+0YLxy3slWolSLPuQi4gYcd5W0CorNf3umw3SUjEu/P2YNcrl1Ur0Xq7bbYxLS3
	 UGPKEd6MOSg/A==
X-Original-To: linux-erofs@lists.ozlabs.org
Delivered-To: linux-erofs@lists.ozlabs.org
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized)
 smtp.mailfrom=oppo.com (client-ip=40.107.131.70;
 helo=apc01-sg2-obe.outbound.protection.outlook.com;
 envelope-from=huangjianan@oppo.com; receiver=<UNKNOWN>)
Authentication-Results: lists.ozlabs.org; dkim=pass (1024-bit key;
 unprotected) header.d=oppo.com header.i=@oppo.com header.a=rsa-sha256
 header.s=selector1 header.b=csMs5Gt5; 
 dkim-atps=neutral
Received: from APC01-SG2-obe.outbound.protection.outlook.com
 (mail-eopbgr1310070.outbound.protection.outlook.com [40.107.131.70])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 4DhCvf645lz30LZ
 for <linux-erofs@lists.ozlabs.org>; Thu, 18 Feb 2021 23:00:27 +1100 (AEDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Dk4Am+HvPXMKdY3GGzJIswAbiHEdYlc1U82rMuKSYdlMuKhnr4GnOWo1FHseFKEoI+AglE7cdIDuHS3gahWxwbcBAqkfGJ2dWRu8xXeElbw3ydSnTeEeBdGvz81igpN4OzLJw+b6Z2VHN9WOcGEO77JvPNxQFqyrhuAtDfzixWZ4ekhdUgUgn4w0maLGZ9CD0tzYUuKoWqB40ZWko7ySl4d6n/QgpvSscmUYwmmnHaFvQKpi8Z6JTw2RwbZL/7x9MUeaYsVwUgf8m6hB9TpFdwQQJbTZ23jESSrE/whU8nPSXr8Njl8ui59GCIr5bBhB+XSUkpYKxbmOHjPBjiavDQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=1LbjuCBmMXbogQtEh1hFGFgEdEHzm025f9NFbknWDX8=;
 b=lag+zhMIwHe2bSO3p8hSQ5dkCk8/VOpgRxHtP1W/Gn3qOtIJs86eSVaC8iqQKxwENpyBmkWAjNINJPhPTkzOsDE7+Crc0kuKV54MtLMoY51LDGptkNK6tveX89RAFphBO9R2NfQXVWbbOpj9QA15OMTGqX8Yd7758CXGpOqA6/JP8iyCCFkcTm18pdU9ZYaLcPBv90KDtcx4nlspbut/kJ/v6Kl7zQ2b/T8FasKCAbq/yjCNzKKLdywSGHgOyRoQZSV3no+vsYvzglpSEEtdA044D2up3D9J6zMccO7gG3bxhPtMQP/ZT5Vk931NC+ekMzAM0wK/ZxxEJqZwPr7epw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oppo.com; dmarc=pass action=none header.from=oppo.com;
 dkim=pass header.d=oppo.com; arc=none
Authentication-Results: lists.ozlabs.org; dkim=none (message not signed)
 header.d=none;lists.ozlabs.org; dmarc=none action=none header.from=oppo.com;
Received: from SG2PR02MB4108.apcprd02.prod.outlook.com (2603:1096:4:96::19) by
 SG2PR02MB4107.apcprd02.prod.outlook.com (2603:1096:4:a2::12) with
 Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.3846.38; Thu, 18 Feb 2021 12:00:22 +0000
Received: from SG2PR02MB4108.apcprd02.prod.outlook.com
 ([fe80::1143:a7b7:6bd4:83b3]) by SG2PR02MB4108.apcprd02.prod.outlook.com
 ([fe80::1143:a7b7:6bd4:83b3%7]) with mapi id 15.20.3868.028; Thu, 18 Feb 2021
 12:00:22 +0000
To: linux-erofs@lists.ozlabs.org
Subject: [PATCH] erofs-utils: support adjust lz4 history window size
Date: Thu, 18 Feb 2021 20:00:09 +0800
Message-Id: <20210218120009.17212-1-huangjianan@oppo.com>
X-Mailer: git-send-email 2.25.1
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [58.252.5.72]
X-ClientProxiedBy: HK0PR01CA0060.apcprd01.prod.exchangelabs.com
 (2603:1096:203:a6::24) To SG2PR02MB4108.apcprd02.prod.outlook.com
 (2603:1096:4:96::19)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from localhost.localdomain (58.252.5.72) by
 HK0PR01CA0060.apcprd01.prod.exchangelabs.com (2603:1096:203:a6::24) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3868.27 via Frontend
 Transport; Thu, 18 Feb 2021 12:00:21 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 65c3214a-9e92-47a0-2d8a-08d8d404c521
X-MS-TrafficTypeDiagnostic: SG2PR02MB4107:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <SG2PR02MB4107D6D035FDAF0DD23C180CC3859@SG2PR02MB4107.apcprd02.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:5236;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: C/lhrvOixhFcoWRWpDx2AhLrMSs6bXLQm3U3ysJu66rf6veGQyjGKSxYZiIgf2FFV3otw4gsWesvNmn2A2X4IM6Q9FFzc/BU51FlaObPY3rvPH0vf60hQgT2stcL109XNXqJ6mH/OIz3oBJSdLYldBQYZmvkNwDJ23he6AXkc6jn/C+ppY6DOXdemZhtqAL4tLS64ux4DRQtXACIxHcczWXZNBvyLMqkacb54129mCgHH91a/0EJQ7KJHhMb4rr77CL9i7EBITLPipDG1vvwnFppZtMs+2u+tLMympNH2npOSfTvKxssm641dsKITTcxmdXd7Pvd39Rf1NSkUa+3R4KWAPwChwAFSJKEX1Ppg+RQKL5Y8sQ3GHfix2jeqG5GfMAbCkCjHD3PMRb4sgnEAahU1ES+Iu2tbpakQS/SzTR+v/hn2X0c2bIuUrMQAgbLMS9VpaO2ENDBODPT586pOjpec475Bi4sJndeeg/sc1Y8dcwAgY8Cz4ikBzLs3pePzdWojyt2X/KV191G+tIupJGC4ZFDDR7Zqf2M2jcSKISbaKuxYXggHBFG8sFzVeSbZv73TTISfRUxO/hzn0je5iYGw3whcVd9HXn6l2NG2vA=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:SG2PR02MB4108.apcprd02.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(4636009)(376002)(136003)(396003)(39860400002)(366004)(346002)(478600001)(2906002)(36756003)(5660300002)(6506007)(316002)(8936002)(52116002)(6512007)(8676002)(26005)(1076003)(66476007)(66556008)(2616005)(956004)(4326008)(107886003)(69590400012)(6666004)(66946007)(83380400001)(186003)(6916009)(16526019)(86362001)(6486002)(11606007);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData: =?us-ascii?Q?V23Q93ZDzCkMIflm9ZqO/2wWdNcrxIbVsi+HqE/EK1Gh5Ty3CGapqQAgnQbw?=
 =?us-ascii?Q?78DIkSrnQ1vHSOTBTFRJ8R8gGmp1qZU7zv/5CpJo65VA4RiwCjyLuZFx1J9s?=
 =?us-ascii?Q?MKIR7gPlh811zrUS5qWeES5+x1Kuk0HztRQXHnb0PkkulfMFQhVlaKOHhDv5?=
 =?us-ascii?Q?FyYXFPphoqVDPFWZDEOskoyohdN6ihGjw+Whx2KJjyo1GBRorTSAbX/GYRec?=
 =?us-ascii?Q?Vjb5fb8bO7fZmFRFJjWyCUAvJLsmf2l4XC3yjCAWnaVUxJTIVBdTqNpm2dA4?=
 =?us-ascii?Q?i2CXv/Fh4rPP8rPMi0xr6vcoxV4JboF00YdPiewT0V0wdzPpwACGBkEjswG4?=
 =?us-ascii?Q?NiRUsNUcy8hSWD77NZZUz5nmtlwaORKCDaMVAO62AQrfZBgaOhq+bB4PGc2z?=
 =?us-ascii?Q?tyW8EOo8qiP8vElCHTEjXwUZwurvQJyUpaiVYfrJsDaVtHokkarDWEtNEGDh?=
 =?us-ascii?Q?dSkEuhsEiRSxk6nNVER5likr/Ayq35OoItpNT8zMY8aQ8hCIASAg9Wrn2IeZ?=
 =?us-ascii?Q?ZjzLpK/tmPPiYJgazFu/mCZmdh9/NXt1DUQLn2zAVmvdi2nqnKQPCLtEdGqB?=
 =?us-ascii?Q?Ks5cP43U4EG04ECfcjz1LoC4hLIUn3SsmkO+95cHGB9UyI2Af54fIv7THCKW?=
 =?us-ascii?Q?dWMBOt/VqmgB0kHHTvwDNNUy2QfauXDOTYorC0fr5asVvn9pOoaXcG6UKVzU?=
 =?us-ascii?Q?2CT51geyRl9cAEOmLPWfSWwF5Amx0y5gv1In5S8zsif9R4odrzD9W71mrWeT?=
 =?us-ascii?Q?ilQ8rXdJTEhG8ZGE06NFJv1soUjC0ljSeJlWYWlrrfUvEE3N9UG8JxBbtFve?=
 =?us-ascii?Q?sLPJvm8Bb3k29e69qt7UMd7+GDDlxmuwAsnQiO8f/DczVDFhv7m4IMyP5sss?=
 =?us-ascii?Q?olxhz/hQMdAPCCqDA1xzVjJozK93yZCK/YchXbOboNYVXGudXz+bLnaPfKTE?=
 =?us-ascii?Q?Gjq2t1fudH8izSWYp//raNHEjqlfpAPx2EtMCoOnmaD8YGtPm5sKyMPQnbjK?=
 =?us-ascii?Q?2V4AigqFRP1qeCDtL5tI0NgVD8xrRnK0ovGieYIswzfo942zrsNUeOzGjExd?=
 =?us-ascii?Q?1wOF+ei3Jy8y6gMZVEtjXWg4bXG9q9Azr4HzU6XtNBuv5PuGzyNRU1ismTWF?=
 =?us-ascii?Q?Q951CtNxscxS5ZI3I4PJ5udizpM7QBP3zFIKTIysH4N577zy0Z6BZqrkGd3M?=
 =?us-ascii?Q?eleOSrjbA+msgBe5KZQ/Yz3KsTKDCWVLcw2kUmqdq6hviH5o4BpZJu4VmpND?=
 =?us-ascii?Q?9sF2jyHd0VlocV02WWbo02QwCfk2FQ+7X8EKmPl81b3haTLjSsBuiM2cCj33?=
 =?us-ascii?Q?DvK/IfkeXF56CulQhN9/0kY0?=
X-OriginatorOrg: oppo.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 65c3214a-9e92-47a0-2d8a-08d8d404c521
X-MS-Exchange-CrossTenant-AuthSource: SG2PR02MB4108.apcprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 18 Feb 2021 12:00:22.6837 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: f1905eb1-c353-41c5-9516-62b4a54b5ee6
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: hy/VqdAc4UeJ3EbOqJbZMON3R4yYNqbCdNmot3Ea/TSOdRQEKPs/hnQfcnfrMiYORa8dQoI33nrUUKCKRvYovg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SG2PR02MB4107
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
 include/erofs/internal.h | 3 +++
 include/erofs_fs.h       | 3 ++-
 lib/compressor_lz4.c     | 5 +++++
 lib/compressor_lz4hc.c   | 3 +++
 mkfs/main.c              | 1 +
 5 files changed, 14 insertions(+), 1 deletion(-)

diff --git a/include/erofs/internal.h b/include/erofs/internal.h
index ac5b270..7a2489e 100644
--- a/include/erofs/internal.h
+++ b/include/erofs/internal.h
@@ -79,6 +79,9 @@ struct erofs_sb_info {
 	u64 inos;
 
 	u8 uuid[16];
+
+	/* compression algorithm specific parameters */
+	u16 compr_alg;
 };
 
 /* global sbi */
diff --git a/include/erofs_fs.h b/include/erofs_fs.h
index a69f179..8cb24da 100644
--- a/include/erofs_fs.h
+++ b/include/erofs_fs.h
@@ -41,7 +41,8 @@ struct erofs_super_block {
 	__u8 uuid[16];          /* 128-bit uuid for volume */
 	__u8 volume_name[16];   /* volume name */
 	__le32 feature_incompat;
-	__u8 reserved2[44];
+	__le16 compr_alg;	/* compression algorithm specific parameters */
+	__u8 reserved2[42];
 };
 
 /*
diff --git a/lib/compressor_lz4.c b/lib/compressor_lz4.c
index 8540a0d..db8d3d2 100644
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
+	sbi.compr_alg = LZ4_DISTANCE_MAX;
 	return 0;
 }
 
diff --git a/lib/compressor_lz4hc.c b/lib/compressor_lz4hc.c
index 6680563..38436f9 100644
--- a/lib/compressor_lz4hc.c
+++ b/lib/compressor_lz4hc.c
@@ -44,6 +44,9 @@ static int compressor_lz4hc_init(struct erofs_compress *c)
 	c->private_data = LZ4_createStreamHC();
 	if (!c->private_data)
 		return -ENOMEM;
+
+	sbi.compr_alg = LZ4_DISTANCE_MAX;
+
 	return 0;
 }
 
diff --git a/mkfs/main.c b/mkfs/main.c
index d9c4c7f..c2ed261 100644
--- a/mkfs/main.c
+++ b/mkfs/main.c
@@ -299,6 +299,7 @@ int erofs_mkfs_update_super_block(struct erofs_buffer_head *bh,
 		.feature_incompat = cpu_to_le32(sbi.feature_incompat),
 		.feature_compat = cpu_to_le32(sbi.feature_compat &
 					      ~EROFS_FEATURE_COMPAT_SB_CHKSUM),
+		.compr_alg = cpu_to_le16(sbi.compr_alg),
 	};
 	const unsigned int sb_blksize =
 		round_up(EROFS_SUPER_END, EROFS_BLKSIZ);
-- 
2.25.1

