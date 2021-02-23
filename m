Return-Path: <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>
X-Original-To: lists+linux-erofs@lfdr.de
Delivered-To: lists+linux-erofs@lfdr.de
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	by mail.lfdr.de (Postfix) with ESMTPS id A7FD1322668
	for <lists+linux-erofs@lfdr.de>; Tue, 23 Feb 2021 08:31:27 +0100 (CET)
Received: from boromir.ozlabs.org (localhost [IPv6:::1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4Dl9hs4lPtz3cGG
	for <lists+linux-erofs@lfdr.de>; Tue, 23 Feb 2021 18:31:25 +1100 (AEDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=lists.ozlabs.org;
	s=201707; t=1614065485;
	bh=QZ/RQtDeN2vYuBlggrzziJcGQc2TizLy7wv+ln6qtRM=;
	h=To:Subject:Date:List-Id:List-Unsubscribe:List-Archive:List-Post:
	 List-Help:List-Subscribe:From:Reply-To:Cc:From;
	b=mOaubZR/BlDyJWEXWiIeO8smtbMySbTxgmFqpt7RLBCS6UsAkhgenSMMwvWJxGRyr
	 orc6wKVCOwfoQkJMCv4vruMH6SHo/tjfjj/uqI9u2eh0aiY5uVusZEh46QmghmK001
	 vzDQLpx5w1bGt+nGNp2xZ4j14S3PhubDKVtJsEjlQwEF9qNyJhIa8ydAwHuAVV9HjM
	 g9vKELh3pup/bYtAGZvGf5WnGO/H/haiClJMqtHBcdrOeOf/lrCood6m7fbd8Dfg8J
	 XwE2rdmaopg3lZdqLS5RA+/SAQarQkEouRA1xEGxp8KpBxyS72vhgRR5xRTiXMUZNy
	 7Ghn8sprE2rdw==
X-Original-To: linux-erofs@lists.ozlabs.org
Delivered-To: linux-erofs@lists.ozlabs.org
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized)
 smtp.mailfrom=oppo.com (client-ip=40.107.132.85;
 helo=apc01-pu1-obe.outbound.protection.outlook.com;
 envelope-from=huangjianan@oppo.com; receiver=<UNKNOWN>)
Authentication-Results: lists.ozlabs.org; dkim=pass (1024-bit key;
 unprotected) header.d=oppo.com header.i=@oppo.com header.a=rsa-sha256
 header.s=selector1 header.b=LYZh+PSH; 
 dkim-atps=neutral
Received: from APC01-PU1-obe.outbound.protection.outlook.com
 (mail-eopbgr1320085.outbound.protection.outlook.com [40.107.132.85])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 4Dl9hn74pVz30RH
 for <linux-erofs@lists.ozlabs.org>; Tue, 23 Feb 2021 18:31:20 +1100 (AEDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Ode76+HwGXMC37Nhx/kqwJWTGBDIgdwzTA6canAcSMiwSdp5nSPEQPi9m+MhmFdWvlgiAF72UaMps7WgMDQutYE/Uk0EpPj5PVDIRokM8ZCPjmYcAXj+Ob2MB2DZ/+wP+IRNO5Gga6onH3KViLBcKNPBgI0vVozN8m/lJ6fg9+426WVa6+LGbTvAyNzP4hYpJQzBIr3X1G597vAwkuOyUye5F+J63mfofk9A+AQ1zyziCAgWFAe1HNWgbkwnjL9Q7FWydISb1srpP9P/fSlh0ju4thx4wK1TXzzqJXljQxYhQnRwVEa3XIQjWPBfG56OQtl3sC9Olj42FQez8Z9oZw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=QZ/RQtDeN2vYuBlggrzziJcGQc2TizLy7wv+ln6qtRM=;
 b=kCOR4qW9dP5TetD24ycrGOiIEXxhtmkwwvcmprXe6BtE4vwnXLlIsVgnCmo/VLUWKL/BSujT9QqwAUZqsRurlwl1/NKCPSexIAmUvraGrWhM8/Kz4pWhDfe1F44AJwLNYoS8qIrqjcYXvlO9Ev+7KtHw5+X7L4NB0VN9qQHDDd/alfS3OrdaDAc52tz30sgseJBcd9Ndx0z+FiYbPj56UNqqTY413HJ00llR6dWSnd03FUuVerY2Sa5Uh/NtQX9nHn5GrlckXj29cS5SxOY+6vXTLHo8LDgwfFyv9rfh46RAtGCExehE0/SAcsAogr2X/AIKZ1OTR+XTw46F1RJVqQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oppo.com; dmarc=pass action=none header.from=oppo.com;
 dkim=pass header.d=oppo.com; arc=none
Authentication-Results: lists.ozlabs.org; dkim=none (message not signed)
 header.d=none;lists.ozlabs.org; dmarc=none action=none header.from=oppo.com;
Received: from SG2PR02MB4108.apcprd02.prod.outlook.com (2603:1096:4:96::19) by
 SG2PR02MB3114.apcprd02.prod.outlook.com (2603:1096:4:62::22) with
 Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.3868.30; Tue, 23 Feb 2021 07:31:07 +0000
Received: from SG2PR02MB4108.apcprd02.prod.outlook.com
 ([fe80::1143:a7b7:6bd4:83b3]) by SG2PR02MB4108.apcprd02.prod.outlook.com
 ([fe80::1143:a7b7:6bd4:83b3%7]) with mapi id 15.20.3868.033; Tue, 23 Feb 2021
 07:31:07 +0000
To: linux-erofs@lists.ozlabs.org
Subject: [PATCH v3] erofs-utils: support adjust lz4 history window size
Date: Tue, 23 Feb 2021 15:30:54 +0800
Message-Id: <20210223073054.69177-1-huangjianan@oppo.com>
X-Mailer: git-send-email 2.25.1
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [58.252.5.72]
X-ClientProxiedBy: HKAPR04CA0008.apcprd04.prod.outlook.com
 (2603:1096:203:d0::18) To SG2PR02MB4108.apcprd02.prod.outlook.com
 (2603:1096:4:96::19)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from localhost.localdomain (58.252.5.72) by
 HKAPR04CA0008.apcprd04.prod.outlook.com (2603:1096:203:d0::18) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.3868.27 via Frontend Transport; Tue, 23 Feb 2021 07:31:06 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 474f9675-fe09-4de9-bfc3-08d8d7ccfbf0
X-MS-TrafficTypeDiagnostic: SG2PR02MB3114:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <SG2PR02MB3114F932F87381982B9A9FD2C3809@SG2PR02MB3114.apcprd02.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:6108;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: Z3xlniKiTCYtUVX9gspCxL11tTeD54jpISf0yW6fsWHafXk15AELGnj/xTJFecskCwmiOi2J+QNK9N0uG96pjitWVSZTSpLqcNtwi3cZ8fEhbQqyyu9zc9vPf5N5pvcDmoj7dpoz5opAwR/YbWNSyzE/516eRWAMKJSn34fg6/47zKJovfSmIsp1WYeuQu9on/SdtFZVv/Yub9VhE9zZmp4ofIi4K3zEMWZxzLmTjiQ/rmtxPnsdTm+l5qRVEJGTrtQjJl5rUdvquRqwJvpbX/HwdovXalad9rWhM0rwV5PSxT9EKQ76/tsLKNB5EXzFQLVX6Xk3RmJGg/nqEM8haSS3PmQH55XgYg3DeD2MVLL6sXxHPj0giQwfWAWiE+A7tRIK0W/BSn2in8DRqeOapcD7lBdoXicE2ISAsX7y9TAmc22TNwAc30ohm5mR6bnxIu3t5tQFExIbp68XBXXoVG969LOLZcQ93OoirTUZNU+6C5A1Y/IC2VVWS1xLRqmqTNZ2QpZ0LMK8cXMGE0f3C3CdnEkxUn5XR3RbzlKpkM7ZUkFiSF4SLmOTqF0OIAFRH+kgY5V06UqbR5H7OKcHeGCwtRwNOQsD62KTbfECpG8=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:SG2PR02MB4108.apcprd02.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(4636009)(376002)(136003)(396003)(39860400002)(366004)(346002)(66946007)(66556008)(5660300002)(36756003)(8676002)(4326008)(86362001)(186003)(16526019)(66476007)(6486002)(8936002)(52116002)(83380400001)(478600001)(6666004)(956004)(2616005)(107886003)(6506007)(316002)(26005)(1076003)(6916009)(2906002)(6512007)(69590400012)(11606007);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData: =?us-ascii?Q?A2YqVJfmH+zifVuRlxcpDDhG8GYQRyqv+h/9Sclet4ZJQypz6paqcq17AGAB?=
 =?us-ascii?Q?HpuphGu+CmLQpuzlFHwersLdS58L138ZXxIPdoyvQ7UuMWVZVi5vL33U80jC?=
 =?us-ascii?Q?r6lHa+wH4WOeuTtUnCufsUsFoY9KUJ9ILIEta/+0yJ2PQJiNnRTlS2bZYe7m?=
 =?us-ascii?Q?Ij6ZAFP/n62/neefG2N61XfW5rWtcredg+EjbTRIMC79mAAuvChkzW/a+38l?=
 =?us-ascii?Q?ASBx9F9m2ekNgXv7zFo+bzCs3YDL3VsxYB4kSchx2fHqkOcYaeW/FbAlfKIn?=
 =?us-ascii?Q?RPQeN1cFAhYS0MjCH93H3ib5eCT1B0j/tpQmfDqOLtLfVRyz3qlwkrrmbx3w?=
 =?us-ascii?Q?JoinN94AfGPPcvadKk/I5qssx87yv8InY9ppVEAoupMdzjZ22cs3yK9jbIIA?=
 =?us-ascii?Q?HAnpgKuHbsYsD+aJeKyqUhj9ua4I+hkp10BUx1WuTXhBChnjImZoY6dcRYcj?=
 =?us-ascii?Q?SqA89iNhouyfCpEAy8pQCtfVTjkKPAgwZt7odLsXpB7fPEitvX5t+Xr9BItB?=
 =?us-ascii?Q?oQrR2LoQ5rinPw5wJtf1HUjszzhtP8OE0x77LffGffsK8oRv8YyA2ZjX4U8s?=
 =?us-ascii?Q?m2v2TS2FP23YV3sNKeUwfT2TzCM6a8FoH21wvp8gEZU5S+37oBmXDU7FrkO8?=
 =?us-ascii?Q?kyBVK6csx/Aqqdxl9W6ABsJcLWHSj6Wko+zNkKk++0jDJIXygah4LRQmtgFa?=
 =?us-ascii?Q?iZUos/JNTq0YWteY0yjjQbcX7R0/DhUnKTDQBqwQwrFqijM9R1+fKOb+AkzO?=
 =?us-ascii?Q?DwU5Iw6D1LVVP4uN35BqATW4MogpzHSXJj4kDLHKVdLxaYRdUJLSnaWo4Z0R?=
 =?us-ascii?Q?vFoSSEXvEtbfxg6gE5fVjw5H0tAWlz0XOOE1Cdkhzvaxc/yWPKQ7aAZHeouh?=
 =?us-ascii?Q?973rSpCTAlUHOBI63UwIKdK9rBdPXJdqdAWettkuEyw3OhNCJh2UbnFv3gE8?=
 =?us-ascii?Q?Z+cmya7XDKBKP+joa0SGbOI8sVuEWLKnloHU+yLixZq6ANf7q5nHDjG3OeEx?=
 =?us-ascii?Q?9Dyh5Vd1/4R++Z3xE3/xaTIPuDxDPS2d157RoJ7GA2FXw3gKHRGXf8u8uaUQ?=
 =?us-ascii?Q?NCH0j/kwMxhFNpvTucvIk1NtZtVhdaxIM7ef9L/uucn3eB+fhEx+xaAjEZ1U?=
 =?us-ascii?Q?gPSVCBADbxRXKcyfmEjLb7mtFBMLtvmbF678Y5+tdjdaLqlLFyAZJ/HS1MJP?=
 =?us-ascii?Q?nDfk1pI0To234Ao/8HZ74nXITkFHxWHVPJrx/uk8TgZH4fCIyrVpkt3WxiTA?=
 =?us-ascii?Q?KnlsEu7hIG0LKPJtV1o71g2pIyfXaxfsEsgOmKKaeeIA+9mPLosCRYkPUIwp?=
 =?us-ascii?Q?rURB76AJwoIFSroTBdScL66E?=
X-OriginatorOrg: oppo.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 474f9675-fe09-4de9-bfc3-08d8d7ccfbf0
X-MS-Exchange-CrossTenant-AuthSource: SG2PR02MB4108.apcprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 23 Feb 2021 07:31:07.5013 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: f1905eb1-c353-41c5-9516-62b4a54b5ee6
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: S25Itw7LyxSASa8geCBV2j51QkuURDj17M2MVWYzihFsfu3gSPJrDB9axSCfKPpxCNAhFoQnEG9DpbaTNScmzA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SG2PR02MB3114
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

The maximum value of LZ4_DISTANCE_MAX defined by lz4 is 64k, and
we can only reduce this value. For the old kernel, it just can't
reduce the memory allocation during rolling decompression without
affecting the decompression result.

Signed-off-by: Huang Jianan <huangjianan@oppo.com>
Signed-off-by: Guo Weichao <guoweichao@oppo.com>
---

change since v2:
- drop useless comment

 include/erofs/internal.h | 2 ++
 include/erofs_fs.h       | 3 ++-
 lib/compressor_lz4.c     | 5 +++++
 lib/compressor_lz4hc.c   | 3 +++
 mkfs/main.c              | 1 +
 5 files changed, 13 insertions(+), 1 deletion(-)

diff --git a/include/erofs/internal.h b/include/erofs/internal.h
index ac5b270..cf02725 100644
--- a/include/erofs/internal.h
+++ b/include/erofs/internal.h
@@ -79,6 +79,8 @@ struct erofs_sb_info {
 	u64 inos;
 
 	u8 uuid[16];
+
+	u16 lz4_max_distance;
 };
 
 /* global sbi */
diff --git a/include/erofs_fs.h b/include/erofs_fs.h
index a69f179..ae2305c 100644
--- a/include/erofs_fs.h
+++ b/include/erofs_fs.h
@@ -41,7 +41,8 @@ struct erofs_super_block {
 	__u8 uuid[16];          /* 128-bit uuid for volume */
 	__u8 volume_name[16];   /* volume name */
 	__le32 feature_incompat;
-	__u8 reserved2[44];
+	__le16 lz4_max_distance;
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

