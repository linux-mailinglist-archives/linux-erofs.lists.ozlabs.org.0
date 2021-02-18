Return-Path: <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>
X-Original-To: lists+linux-erofs@lfdr.de
Delivered-To: lists+linux-erofs@lfdr.de
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	by mail.lfdr.de (Postfix) with ESMTPS id 16FE831E966
	for <lists+linux-erofs@lfdr.de>; Thu, 18 Feb 2021 13:01:10 +0100 (CET)
Received: from boromir.ozlabs.org (localhost [IPv6:::1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4DhCwN10Z7z30MG
	for <lists+linux-erofs@lfdr.de>; Thu, 18 Feb 2021 23:01:08 +1100 (AEDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=lists.ozlabs.org;
	s=201707; t=1613649668;
	bh=HM6lAwx8GqbmThr10URRqPNuTJ2iOhWgKDlb5h3mEi8=;
	h=To:Subject:Date:List-Id:List-Unsubscribe:List-Archive:List-Post:
	 List-Help:List-Subscribe:From:Reply-To:Cc:From;
	b=GckT81xqVqUwEekXpjtXDXTuLgPwXChNVyb83poaZISPAOwPwGl2n7w7Q5SHOHWD5
	 bJXLutoAHGzTeRVp1taaKCQTyCQ/oLaHEhpY5KNk/hvDcn4MnKJAxerQtb+Z16cQZF
	 m9Bpi39IsUTgSfK6N3/Ds1u7+J5+xOfN5byCsF41zYUN3bcvYDWefTyQJxw/nfpj51
	 16qGmnABRiGSLGr7mjyHzRsOSr5pjqaluqf4+60sA4DAr3E4+OkaAftfOrViNaLcZ9
	 /km+SpA8i3NXaUYCY3n6AfcLL+U2abenXW1ZaXqhoqnu//zpofTTOX8+S5aVmArLyV
	 IXe5Pf2tbi8RQ==
X-Original-To: linux-erofs@lists.ozlabs.org
Delivered-To: linux-erofs@lists.ozlabs.org
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized)
 smtp.mailfrom=oppo.com (client-ip=40.107.131.51;
 helo=apc01-sg2-obe.outbound.protection.outlook.com;
 envelope-from=huangjianan@oppo.com; receiver=<UNKNOWN>)
Authentication-Results: lists.ozlabs.org; dkim=pass (1024-bit key;
 unprotected) header.d=oppo.com header.i=@oppo.com header.a=rsa-sha256
 header.s=selector1 header.b=looesBaK; 
 dkim-atps=neutral
Received: from APC01-SG2-obe.outbound.protection.outlook.com
 (mail-eopbgr1310051.outbound.protection.outlook.com [40.107.131.51])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 4DhCwK4jvtz30Gw
 for <linux-erofs@lists.ozlabs.org>; Thu, 18 Feb 2021 23:01:05 +1100 (AEDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=gL7g0Zu0NlHHpJScqWFWsMI91DaHsBFZfXJl1uIZOqvthtHf71vH0tGtIAsQC2aPkqGPHo9N4S2FgsFB5cpjteri+/WSdtpxC7BHQP6KoTbqkTXcJBaC8gDdc4mjfBdwUwlg4ZLoppNcDWufGFjzGFOAk0SJjrYbL+9BEHV3Ml83eF8kxgk4/Pkdyj70Ie8XsrG3E2TWlY9iFOyNQCD7XPrkTXeaYTrOGiXSIrDJTra5JlgQAKe0NVlSriLcO3vVlZqGdgX3z6C0vLga1OMPqpk8tEqwZQCatlRTgsqT2xgigJ8WR9lDdyzYUmTLV2IhzLY6ESZ8G4k6nzq4O51osA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=HM6lAwx8GqbmThr10URRqPNuTJ2iOhWgKDlb5h3mEi8=;
 b=eLl609FdJMRPYvkMmqwzhmg67QvGAu0Yy3hYIQ5GaCS9wKuZjmP2Z86LNZt0WeyaXmzl6pOERDJbeKiQtM5b4YmhgULyjKypCQM6V+ZGA7a6qFT/W43/H5Agdd1foAcAh+Wid/ion5wudOvScb2HQUN2ptDDT0mDZsLZmIBvh2FeNJA8wFFiUV8xL71yagHe7Fv7VBsR+jv6EyHF/bT2T8L4JCsvnR/yDDOV9hmxFgzCDLtvVyGKG1gwYrYd7ue+RLSzerg14O2AZgPs3mgvkVC8lj6Zcfcvhb3ir7rAFTKwiDGB0muJmwYlqz43aTiH0y4rN3Xnh/4s0VNRjTuu+A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oppo.com; dmarc=pass action=none header.from=oppo.com;
 dkim=pass header.d=oppo.com; arc=none
Authentication-Results: lists.ozlabs.org; dkim=none (message not signed)
 header.d=none;lists.ozlabs.org; dmarc=none action=none header.from=oppo.com;
Received: from SG2PR02MB4108.apcprd02.prod.outlook.com (2603:1096:4:96::19) by
 SG2PR02MB4107.apcprd02.prod.outlook.com (2603:1096:4:a2::12) with
 Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.3846.38; Thu, 18 Feb 2021 12:01:01 +0000
Received: from SG2PR02MB4108.apcprd02.prod.outlook.com
 ([fe80::1143:a7b7:6bd4:83b3]) by SG2PR02MB4108.apcprd02.prod.outlook.com
 ([fe80::1143:a7b7:6bd4:83b3%7]) with mapi id 15.20.3868.028; Thu, 18 Feb 2021
 12:01:01 +0000
To: linux-erofs@lists.ozlabs.org
Subject: [PATCH] erofs: support adjust lz4 history window size
Date: Thu, 18 Feb 2021 20:00:49 +0800
Message-Id: <20210218120049.17265-1-huangjianan@oppo.com>
X-Mailer: git-send-email 2.25.1
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [58.255.79.104]
X-ClientProxiedBy: HK2P15301CA0018.APCP153.PROD.OUTLOOK.COM
 (2603:1096:202:1::28) To SG2PR02MB4108.apcprd02.prod.outlook.com
 (2603:1096:4:96::19)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from localhost.localdomain (58.255.79.104) by
 HK2P15301CA0018.APCP153.PROD.OUTLOOK.COM (2603:1096:202:1::28) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.3890.2 via Frontend Transport; Thu, 18 Feb 2021 12:01:00 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 66e6d0bd-3721-4294-db7c-08d8d404dbf9
X-MS-TrafficTypeDiagnostic: SG2PR02MB4107:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <SG2PR02MB41074A6481CA1DF7BED49FD2C3859@SG2PR02MB4107.apcprd02.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:4125;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: pXKgKTLqlfoDJCUCnnFquw5LWlCdvITHVveQg3j7HYEPCThmoMHw2LlcssZ5ANbbtRXhk32Wsjka5sT5lg/ZlexrkbUQk3VL9SulL2OtnXf8W+Kxkb319eX87h0IZQduN+8eYluz7yhISKK1pGzOQkQgbkY1UPefSc97NZhZwdyk7feRdcyTtCVZ6uUx7bu5qqhkRhxXasrHpOxtOioy9jALy2i2OOigDsuAuBQNJYW8yQoQlcl4i1hi7wnyqoPvgS6jiSTzMT2cYBuplYlSCf+whxGb75I5x2gdOinT7PpwnocULFPIMb+JzC2ospyTeCakq0iD1jBqhNLAui3qovxgIY0wv8ym7y4uzZTLFLyrveqDCOqdcwxZ7qe0mshF+3W2JBww6T10/Fqy0AM1Rge8imNFD2V9lhLBgSQNTvyL2aMQ7SHUjX/mvMVlWSMagcfiPk/p5GldlbSh9xvZLxTxCjsU9URE0wUWeaR9RuKU6BMr6OFvBxdXLIsClug3Rvfa90bToMgAxt9cMI2kaYgf/g1vyF9/8zIJ2cA/biDIteJPy40o+RE8Pz6wTDnMef6dYzh2qG6xHangZhOvmsC3mGXiisqbJVQY/AIQVRk=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:SG2PR02MB4108.apcprd02.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(4636009)(376002)(136003)(396003)(39860400002)(366004)(346002)(478600001)(2906002)(36756003)(5660300002)(6506007)(316002)(8936002)(52116002)(6512007)(8676002)(26005)(1076003)(66476007)(66556008)(2616005)(956004)(4326008)(69590400012)(6666004)(66946007)(83380400001)(186003)(6916009)(16526019)(86362001)(6486002)(11606007);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData: =?us-ascii?Q?9gTg6ov5+VxuuvrEMGwyCm/GFZ9FsPPK8d0qkZuPXuCcr5lfaXLR6vL5hhcW?=
 =?us-ascii?Q?AAw0IGSrtEsGVwviwwh8TvVSwsIUAW6ASvdX7I0Oue24+feeP8umwMq20yCK?=
 =?us-ascii?Q?+ia+BukIOodAfQKO4xPJ4lxyLjQUlauNdTXpTE2h0QOf347C7K1zV4bEFzeh?=
 =?us-ascii?Q?gvfLlZhee15/awCMylWaXvT7rswBA+XAg74TA5Egd1JVmZcL78ZKsLaeXSrP?=
 =?us-ascii?Q?kqDUOk/5de9olcypjpbNAdoPOaiaP45ukS9KrVR2NaAjThUOQ6gWpBDFgDYS?=
 =?us-ascii?Q?XkRHyvIGuPtUc8BYkqThh9AYIUzOq7iOE9G5ROR/yyirkWF2PHyzpQghF5ZW?=
 =?us-ascii?Q?4pwI6mC73DDuHUQN4mtT6sc4d530fg0wn96WN0hMPKhl5HCgFw04ETd8UGZK?=
 =?us-ascii?Q?Ru/moysYyxTSFL9yT0vqlQFsi3zJHPcmxVIz1yZeIfi93MtV4tuWgh+ExRr2?=
 =?us-ascii?Q?VJL+wbVg+K/JThUJDDjLtJ2jNRnLnsDBsH39fgI8CeT+V8QFegEtLWOrRORO?=
 =?us-ascii?Q?g6IuOF5hvhkayzMNmcGQpGWKB+ShyLdlgv2hU3COfD3LBjjNdRT7cVmNxV+K?=
 =?us-ascii?Q?krNY1QUCdk2bFbv9z27FHBpyF+XXHwm+yeiwmO0KDH5RxFU0b4bpQLzD+UZZ?=
 =?us-ascii?Q?bwvCKBgmYoV2eB431UtmXWoeF6TvLC79oW32incx1nUQ1TO+Lz/5J184XTLy?=
 =?us-ascii?Q?o31JObOVWcq0LaBFwX/SyPOirj3k/LmRaCd9Hf6O3N57CVliUXaFMYJaR1tu?=
 =?us-ascii?Q?J/p2SmtcDHxBvT5bD9TkR4PnPu3Q0qhp6QIxmlqlQGcVtjZu1LNzF4wBx+9h?=
 =?us-ascii?Q?lqFUmrU3jmM2pQwtHRKk4Z1HQ+ZRseig2AJ3cokqr2hI2lNFOvaUtFg8NoGf?=
 =?us-ascii?Q?bLSWClGXV7z/C/uenKxTeemq8tueByFjb6rvSVRuqKL9KVsxxgldJ73OD2BL?=
 =?us-ascii?Q?WpzDcbTAfl/yTzkYpiIojR/CYve25MommaFV+BGvXAaUCZU8p0EycELABLcy?=
 =?us-ascii?Q?OSH2I/MzAKtYd8AgMmbDX/EsqB/D2PdpXDck8dc5gBvMf6UuQFchBx3rihvA?=
 =?us-ascii?Q?lVCZi1O5Mv/qePepCJVFUxqrbEAxETxV3I8WnDetbjDkVCdVd3+TSu7gS227?=
 =?us-ascii?Q?6FgYFSy15YOVwJVYJon/hAbvl1IVYnY/Zuj2WRHVhfKSvJ82N3L7h+nQJjmn?=
 =?us-ascii?Q?abnnyyz37Ghvfm7ikwPejuCrIF00aE/CTJaIcGQNP5hmLqDa5QjX5GENwwM7?=
 =?us-ascii?Q?08PZjASlYWCk3ryY0BCTYwmvL1kkmt0Droa9bJQAD9nqyeKyyBz3oGB41auk?=
 =?us-ascii?Q?pF6QJlE8M1OWbA7nDeO+pn0w?=
X-OriginatorOrg: oppo.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 66e6d0bd-3721-4294-db7c-08d8d404dbf9
X-MS-Exchange-CrossTenant-AuthSource: SG2PR02MB4108.apcprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 18 Feb 2021 12:01:01.0096 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: f1905eb1-c353-41c5-9516-62b4a54b5ee6
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 2C4Olps59vLSTPmZ8NVdCCRnNeoO4XaQF32wfhvbsJ27ck8lz1+b/0Lu+rTRSsJ0hyaHV7VX42K5E+fJEmKwCg==
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
Cc: linux-kernel@vger.kernel.org, guoweichao@oppo.com, zhangshiming@oppo.com
Errors-To: linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org
Sender: "Linux-erofs"
 <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>

From: huangjianan <huangjianan@oppo.com>

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
 fs/erofs/decompressor.c | 13 +++++++++----
 fs/erofs/erofs_fs.h     |  3 ++-
 fs/erofs/internal.h     |  3 +++
 fs/erofs/super.c        |  3 +++
 4 files changed, 17 insertions(+), 5 deletions(-)

diff --git a/fs/erofs/decompressor.c b/fs/erofs/decompressor.c
index 1cb1ffd10569..94ae56b3ff71 100644
--- a/fs/erofs/decompressor.c
+++ b/fs/erofs/decompressor.c
@@ -36,22 +36,27 @@ static int z_erofs_lz4_prepare_destpages(struct z_erofs_decompress_req *rq,
 	struct page *availables[LZ4_MAX_DISTANCE_PAGES] = { NULL };
 	unsigned long bounced[DIV_ROUND_UP(LZ4_MAX_DISTANCE_PAGES,
 					   BITS_PER_LONG)] = { 0 };
+	unsigned int lz4_distance_pages = LZ4_MAX_DISTANCE_PAGES;
 	void *kaddr = NULL;
 	unsigned int i, j, top;
 
+	if (EROFS_SB(rq->sb)->compr_alg)
+		lz4_distance_pages = DIV_ROUND_UP(EROFS_SB(rq->sb)->compr_alg,
+						  PAGE_SIZE) + 1;
+
 	top = 0;
 	for (i = j = 0; i < nr; ++i, ++j) {
 		struct page *const page = rq->out[i];
 		struct page *victim;
 
-		if (j >= LZ4_MAX_DISTANCE_PAGES)
+		if (j >= lz4_distance_pages)
 			j = 0;
 
 		/* 'valid' bounced can only be tested after a complete round */
 		if (test_bit(j, bounced)) {
-			DBG_BUGON(i < LZ4_MAX_DISTANCE_PAGES);
-			DBG_BUGON(top >= LZ4_MAX_DISTANCE_PAGES);
-			availables[top++] = rq->out[i - LZ4_MAX_DISTANCE_PAGES];
+			DBG_BUGON(i < lz4_distance_pages);
+			DBG_BUGON(top >= lz4_distance_pages);
+			availables[top++] = rq->out[i - lz4_distance_pages];
 		}
 
 		if (page) {
diff --git a/fs/erofs/erofs_fs.h b/fs/erofs/erofs_fs.h
index 9ad1615f4474..bffc02991f5a 100644
--- a/fs/erofs/erofs_fs.h
+++ b/fs/erofs/erofs_fs.h
@@ -39,7 +39,8 @@ struct erofs_super_block {
 	__u8 uuid[16];          /* 128-bit uuid for volume */
 	__u8 volume_name[16];   /* volume name */
 	__le32 feature_incompat;
-	__u8 reserved2[44];
+	__le16 compr_alg;	/* compression algorithm specific parameters */
+	__u8 reserved2[42];
 };
 
 /*
diff --git a/fs/erofs/internal.h b/fs/erofs/internal.h
index 67a7ec945686..f1c99dc2659f 100644
--- a/fs/erofs/internal.h
+++ b/fs/erofs/internal.h
@@ -70,6 +70,9 @@ struct erofs_sb_info {
 
 	/* pseudo inode to manage cached pages */
 	struct inode *managed_cache;
+
+	/* compression algorithm specific parameters */
+	u16 compr_alg;
 #endif	/* CONFIG_EROFS_FS_ZIP */
 	u32 blocks;
 	u32 meta_blkaddr;
diff --git a/fs/erofs/super.c b/fs/erofs/super.c
index d5a6b9b888a5..198435e3eb2d 100644
--- a/fs/erofs/super.c
+++ b/fs/erofs/super.c
@@ -174,6 +174,9 @@ static int erofs_read_superblock(struct super_block *sb)
 	sbi->islotbits = ilog2(sizeof(struct erofs_inode_compact));
 	sbi->root_nid = le16_to_cpu(dsb->root_nid);
 	sbi->inos = le64_to_cpu(dsb->inos);
+#ifdef CONFIG_EROFS_FS_ZIP
+	sbi->compr_alg = le16_to_cpu(dsb->compr_alg);
+#endif
 
 	sbi->build_time = le64_to_cpu(dsb->build_time);
 	sbi->build_time_nsec = le32_to_cpu(dsb->build_time_nsec);
-- 
2.25.1

