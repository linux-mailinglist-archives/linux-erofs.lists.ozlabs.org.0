Return-Path: <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>
X-Original-To: lists+linux-erofs@lfdr.de
Delivered-To: lists+linux-erofs@lfdr.de
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	by mail.lfdr.de (Postfix) with ESMTPS id 1AB404BB006
	for <lists+linux-erofs@lfdr.de>; Fri, 18 Feb 2022 04:12:44 +0100 (CET)
Received: from boromir.ozlabs.org (localhost [IPv6:::1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4K0Gw94MTNz3c7S
	for <lists+linux-erofs@lfdr.de>; Fri, 18 Feb 2022 14:12:41 +1100 (AEDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=lists.ozlabs.org;
	s=201707; t=1645153961;
	bh=zUa0OAwVpBcXGn38HGJES81JNPEMiCNcf4j26HqvPyM=;
	h=To:Subject:Date:In-Reply-To:References:List-Id:List-Unsubscribe:
	 List-Archive:List-Post:List-Help:List-Subscribe:From:Reply-To:Cc:
	 From;
	b=YwBA5IPu63NajqkluH/+C6K0KQ+OiJbBDFC7F6y8ZcM67ZTl8RO3KjUk2AI+bshQh
	 nQ1WbtyRf2qL7FRQwnw2xC2sN8jTagnOxZLrcfBOrLkQFxKn/vlJ8r/hxbGdNceCgc
	 fO/pymdiqHuy10HCyIyqDQWoJaE3YZhpniGVqfgOxtrQ2awABkCwfrcJqNfmtVqVIh
	 xPy81lYkPzDkrcVISwkFU2b48DymckSXisP8lPoje2BQH4AD2Y/pKAoet+VecLm8//
	 ncPhEBmL/RkSUtodrxIxbJKnBuMQdK8j+ql958W+daxkd5yYfhBJU9LB/KbErNc0X1
	 IzPElZkealF1Q==
X-Original-To: linux-erofs@lists.ozlabs.org
Delivered-To: linux-erofs@lists.ozlabs.org
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized)
 smtp.mailfrom=oppo.com (client-ip=2a01:111:f400:feae::62a;
 helo=apc01-psa-obe.outbound.protection.outlook.com;
 envelope-from=huangjianan@oppo.com; receiver=<UNKNOWN>)
Authentication-Results: lists.ozlabs.org; dkim=pass (1024-bit key;
 unprotected) header.d=oppo.com header.i=@oppo.com header.a=rsa-sha256
 header.s=selector1 header.b=TJ8lDyDB; 
 dkim-atps=neutral
Received: from APC01-PSA-obe.outbound.protection.outlook.com
 (mail-psaapc01on2062a.outbound.protection.outlook.com
 [IPv6:2a01:111:f400:feae::62a])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 4K0Gw65cnxz3bPW
 for <linux-erofs@lists.ozlabs.org>; Fri, 18 Feb 2022 14:12:38 +1100 (AEDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=EFavZLkmx0KCWtwXzyh/G8WSVVcEKCsi4blpjGJhrS3sHaep7axaYKuaUhEMOsJWioPlz+l98OQKuAi/NGTBKRyNP7i2HwbNCxHmkq323cDzfG0giCnGlGOk+lR1r9PBO2/6RqCgoiCApjI71k1bGPMevKknk3wECqVXwg3iJYQQEk8iSv5XhmWGPdwgjt+OTFhqpQ8hcDgK0YfDLxmx6DcFIJ/Ut8gkf5h9lUPbijkpjzxHCxUqpCfLGGDQprhcVnbI28SM+W2JkJTw0Al9Z7chyRXhvbs/WMC6ol9vqXyOKhm+gzG7Sgt1nMo1Wjj2l8/+9R3sp7Le2hlGurWgBg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=zUa0OAwVpBcXGn38HGJES81JNPEMiCNcf4j26HqvPyM=;
 b=Dujx9UGuwyNyZn1fhceEWAkJg7CqanAkuOsP1sS75NdMI1ElI9NrEerusvMl+IuQ/dOr0uKRaOnAV+6dehS33NwxJmOkKK547ec1g2kNlBQAPc74elYf8htGsGg7hWWQyoOJc61vVxy0YZlnl624l53J3RbZee/pGXfzcj8MkI/UwYd0iLYk4LyBLnw5nfX0RnoOWm+b9iaxHrjTu8y4k42saXgOTP7jRxSupvSce6lJGmCG8W9R+ukqrNbb90i9fWw9JHfUjJmNAYFF81jmt6pQ55e+XzEcmsC/fWvo/Vu4/sW6VVZLFswJGLzsFbdg1+UiLsXc5zyfw89ncLsKTg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oppo.com; dmarc=pass action=none header.from=oppo.com;
 dkim=pass header.d=oppo.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=oppo.com;
Received: from SG2PR02MB4108.apcprd02.prod.outlook.com (2603:1096:4:96::19) by
 PSAPR02MB4870.apcprd02.prod.outlook.com (2603:1096:301:90::9) with
 Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.4995.18; Fri, 18 Feb 2022 03:11:52 +0000
Received: from SG2PR02MB4108.apcprd02.prod.outlook.com
 ([fe80::6483:a437:bcd5:2e0]) by SG2PR02MB4108.apcprd02.prod.outlook.com
 ([fe80::6483:a437:bcd5:2e0%4]) with mapi id 15.20.4995.018; Fri, 18 Feb 2022
 03:11:52 +0000
To: linux-erofs@lists.ozlabs.org
Subject: [PATCH] erofs-utils: fix some style problems
Date: Fri, 18 Feb 2022 11:11:37 +0800
Message-Id: <20220218031137.18716-3-huangjianan@oppo.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20220218031137.18716-1-huangjianan@oppo.com>
References: <20220218031137.18716-1-huangjianan@oppo.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: HK2PR0401CA0002.apcprd04.prod.outlook.com
 (2603:1096:202:2::12) To SG2PR02MB4108.apcprd02.prod.outlook.com
 (2603:1096:4:96::19)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: a50d8c27-f94a-4970-0315-08d9f28c6910
X-MS-TrafficTypeDiagnostic: PSAPR02MB4870:EE_
X-Microsoft-Antispam-PRVS: <PSAPR02MB48705CC15287A66755C0D8C1C3379@PSAPR02MB4870.apcprd02.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:157;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: UiCuBcvxHRX4a6A6CD38mr9G/+hXbp1UeQqtUej7XhlFtkBuE8XSL7zaHjGYYVrtarfBCcvkLRWAEBOPZmrczCU5MT7JCe78r7JfbOUP2zPWqsJc3Lgrm4639aCKhpZ4yQly+wB7WPC9hKLGG89wWhjHv6t+QT79dOsT4tsLB1O96mZBbQSes30U0rFttxYaPfQ7OBLmBytMfvy6KUiiVa8qmg1OcSnNrIrHFV8IWAfFrLLcF/8WEwUSmR3678lOOd0HdnMcXjW1e1chyCuQxWGFWuZV07E7PMPH/p/GKFOW/lbm4CRN96o/g3mTpiH02lzO3Y+YCpCMKkznY0RxDCn98k3No31QKp94IKB2b1o/BA35RD3w8bYJQ5YLvRVNSQvIwt2bcGB/s0veLI5cmKMEdlkyRV/a+1IzujYgtTgWwk5llHasgS0KbTWGXFWYT2IZ4lYvb+MSIGgcylACN+R0L3xZjXL+melVEs9H6KzS+JkO+pbPkONP7qBxvmPxrfmQPfAowVLFaM+dzggVl6n3t/4I6E1MPkxiAAEHXJSIKIpM8oR6txOHLCmYcNwtlw3j9hGu6FMM1Wv4BbB5yZP0IGvLyEH8TAFEn0oXww4YLemAMeTyI6dcmorAtaiBTWYsnNe8VccKIfIozF5htK0vyS7CRTeoGrBDZbnXPAxMSbY580SWbKNIwQ0FsrCIHKq+wOkgf2lOoX4g67dBjg==
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:SG2PR02MB4108.apcprd02.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230001)(4636009)(366004)(83380400001)(8936002)(5660300002)(66476007)(52116002)(6506007)(6512007)(6916009)(30864003)(6666004)(508600001)(6486002)(4326008)(8676002)(2616005)(66946007)(107886003)(26005)(186003)(316002)(1076003)(66556008)(86362001)(36756003)(2906002)(38100700002)(38350700002);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?+xY1AL1nwoWJELI8x2AqJMcuvb8q/po2Pjyz3xHvMQ+hbWnOqQyRCTWANtgV?=
 =?us-ascii?Q?gjjXN1SllAwIC8vS+n5CaMHCbOX8qPEfaFQ1OH3rc7rpfy+eR2597mFcuaCz?=
 =?us-ascii?Q?Gbr0SNyk0dEqQfb/GSuAuAwsyZ5kkwWE5x+VuHo7M3Be/ArbVAQzw87O4x70?=
 =?us-ascii?Q?8bLiqKcBX1ulXPg5dd/mD8Kbr1funMt8O7WjOjxFWp2iyKvb01XGiMgz9fhj?=
 =?us-ascii?Q?81LCLaxuTOsUev/npPk2ucZid+Vdb1fkTo4f9CxLArux5VQiEfhq6kCGOXyw?=
 =?us-ascii?Q?k8Pd0Wnas+gkUvAbMfp8M8FQXbyxw57/+xYynMGCQZQUBFORRIQ2+vY5FhsH?=
 =?us-ascii?Q?J7/CyoNTXTLZFeXcJs77OyZ3+eA+hQnJbT4O3DHXuMjy7yxj3AajPN1RIxT+?=
 =?us-ascii?Q?nY1agUlQHCNznXzy3z5+S9OBbZVsFRfigA4SFTURCfVKUSaKmXk0HUwgwQJH?=
 =?us-ascii?Q?6lWHcJMB0KJNmnOkJR0jg0pv2Gr/H6ZsDZm8Rzv93TeAel4I+novs8+QQsrS?=
 =?us-ascii?Q?ZKXkoMyefG508qPdCdlEdveH9U+NY1eu65xieB6eCYQTWq1xQloewAKGSk99?=
 =?us-ascii?Q?UlD2cl5gsGrbEIF+Ez3TXdPx+Me25+aBYpi1UessEk0YFnYnCJZgp3AgK67q?=
 =?us-ascii?Q?OqDIiZOvSDWffCHjcg9h7e9Cu0fv0mPsm7+rfX+Ex1HGELH454ulyNiA4XHT?=
 =?us-ascii?Q?LVbgDPo/Z5gBkCx+leszrVSQH/xfGbM+Hv2CajPsWs5wbcxbUg9ZF5kSEyyy?=
 =?us-ascii?Q?5T1iPVkJFf63Y8h5UxvZDinpK2lSjEakYvm3dkUXo/DxmrrrzUyGnXqVBwPs?=
 =?us-ascii?Q?7q3Vva2byAqqg9tVGo0iAZTrvTmVMZYaJCFE0RipdCvU1Tg+WAE1UfQTZ4uG?=
 =?us-ascii?Q?wBESx9LE7fSbJmUAs+YIUeCJnLnY2xzA3BYS1c2nWUMR676uu7LeAsw9xh79?=
 =?us-ascii?Q?tEUU86JYYrQ6EnppaE4nfuJDuoCtsH5GDXdGMIkO4ufryqyGtsEVvqi1WVaJ?=
 =?us-ascii?Q?oi5XFs3KTDuhpvP0/9xZs+Jt2Tai/smi7/HFSVOcIUjqRXkcOtSNTMMAzRrp?=
 =?us-ascii?Q?RN4XKpZGaDXYG3LtG8Wf8tezUjnue5CnFmP/i9LYDtKxKMHrbHjXkZw+k8YH?=
 =?us-ascii?Q?oqkwNGowZzdutMlcOme5UGso5J9Y2zioMVbRd3LF3bWYQAYVdUkpI4KLfW2I?=
 =?us-ascii?Q?lCtybLT2qshHAeCc0gkfP7j3KhxhqN0f0eJzoz3K1evwaiNewxqiyNLSgRwu?=
 =?us-ascii?Q?DvdRnkS3/mMRseeM3UAnXyDOmaRu5FPDBJPgr4ma/8UyGj8EuNm+iaWyHUPr?=
 =?us-ascii?Q?9qR9PICKru5g19TYzqWvAcXVLOqKFhMv6B2r9wuJDzPArvGEhU3Eprj7Nq0Q?=
 =?us-ascii?Q?/qXFuie2T7/AIUGxXbCTTIjbulj7hcGJwJBlzaxcV1+xSuLuUyKi9cfH7g5E?=
 =?us-ascii?Q?R3v7QvkIPQ1Z0kHzpfCAMCTUJzBL7Oi+FM/nGPPno+OllK6QEa/mRHWobE7p?=
 =?us-ascii?Q?Tu2AT0uLqB8JBBFFTelNul4OV2ro5HeIvkp4eR7X/e20IcchfXroxXz+rId5?=
 =?us-ascii?Q?WyHAJfgt5+VsVf4sIZeNvF+jUjQHn5rKuirTkVay+6yfGLbOTvrWgwN6brDx?=
 =?us-ascii?Q?br8ybIWuoKg+c/suTsJo2tM=3D?=
X-OriginatorOrg: oppo.com
X-MS-Exchange-CrossTenant-Network-Message-Id: a50d8c27-f94a-4970-0315-08d9f28c6910
X-MS-Exchange-CrossTenant-AuthSource: SG2PR02MB4108.apcprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 18 Feb 2022 03:11:52.3667 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: f1905eb1-c353-41c5-9516-62b4a54b5ee6
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: NFfBylwo9AvDv0U3i/pTSXQnsYnCwq8mIpdC3UvLjp1om3t0HvXw93JQvNG5Q//SLKU00cClbGqZkKlNxq5Uxg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PSAPR02MB4870
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
Cc: zhangshiming@oppo.com
Errors-To: linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org
Sender: "Linux-erofs"
 <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>

Fix some minor issues, including:
  - Align with the left parenthesis;
  - Spelling mistakes;
  - Remove redundant spaces and parenthesis;
  - clean up file headers;
  - Match parameters with format parameters.

Signed-off-by: Huang Jianan <huangjianan@oppo.com>
---
 dump/main.c                | 53 +++++++++++++++++++-------------------
 fsck/main.c                |  4 +--
 fuse/main.c                |  1 -
 include/erofs/block_list.h |  4 +--
 include/erofs/defs.h       |  1 -
 include/erofs/dir.h        |  2 +-
 include/erofs/internal.h   |  2 +-
 include/erofs/list.h       |  1 -
 lib/blobchunk.c            |  2 +-
 lib/cache.c                |  1 -
 lib/compress.c             |  2 +-
 lib/compress_hints.c       |  2 +-
 lib/compressor_liblzma.c   |  5 ++--
 lib/data.c                 |  2 +-
 lib/dir.c                  |  2 +-
 lib/exclude.c              |  2 +-
 lib/inode.c                |  2 +-
 lib/io.c                   |  2 +-
 lib/liberofs_private.h     |  2 +-
 lib/namei.c                |  1 -
 lib/super.c                |  4 +--
 lib/xattr.c                |  4 +--
 mkfs/main.c                |  2 +-
 23 files changed, 48 insertions(+), 55 deletions(-)

diff --git a/dump/main.c b/dump/main.c
index e6198a0..3f8c2f2 100644
--- a/dump/main.c
+++ b/dump/main.c
@@ -179,7 +179,7 @@ static int erofsdump_parse_options_cfg(int argc, char **argv)
 }
 
 static int erofsdump_get_occupied_size(struct erofs_inode *inode,
-		erofs_off_t *size)
+				       erofs_off_t *size)
 {
 	*size = 0;
 	switch (inode->datalayout) {
@@ -218,7 +218,7 @@ static void inc_file_extension_count(const char *dname, unsigned int len)
 }
 
 static void update_file_size_statatics(erofs_off_t occupied_size,
-		erofs_off_t original_size)
+				       erofs_off_t original_size)
 {
 	int occupied_size_mark, original_size_mark;
 
@@ -300,7 +300,7 @@ static int erofsdump_readdir(struct erofs_dir_context *ctx)
 }
 
 static int erofsdump_map_blocks(struct erofs_inode *inode,
-		struct erofs_map_blocks *map, int flags)
+				struct erofs_map_blocks *map, int flags)
 {
 	if (erofs_inode_is_data_compressed(inode->datalayout))
 		return z_erofs_map_blocks_iter(inode, map, flags);
@@ -383,7 +383,7 @@ static void erofsdump_show_fileinfo(bool show_extent)
 		struct erofs_map_dev mdev;
 
 		err = erofsdump_map_blocks(&inode, &map,
-				EROFS_GET_BLOCKS_FIEMAP);
+					   EROFS_GET_BLOCKS_FIEMAP);
 		if (err) {
 			erofs_err("failed to get file blocks range");
 			return;
@@ -409,7 +409,8 @@ static void erofsdump_show_fileinfo(bool show_extent)
 }
 
 static void erofsdump_filesize_distribution(const char *title,
-		unsigned int *file_counts, unsigned int len)
+					    unsigned int *file_counts,
+					    unsigned int len)
 {
 	char col1[30];
 	unsigned int col2, i, lowerbound, upperbound;
@@ -419,8 +420,7 @@ static void erofsdump_filesize_distribution(const char *title,
 	lowerbound = 0;
 	upperbound = 1;
 	fprintf(stdout, "\n%s file size distribution:\n", title);
-	fprintf(stdout, header_format, ">=(KB) .. <(KB) ", "count",
-			"ratio", "distribution");
+	fprintf(stdout, header_format, ">=(KB) .. <(KB) ", "count", "ratio", "distribution");
 	for (i = 0; i < len; i++) {
 		memset(col1, 0, sizeof(col1));
 		memset(col4, 0, sizeof(col4));
@@ -452,8 +452,7 @@ static void erofsdump_filetype_distribution(char **file_types, unsigned int len)
 	char col4[401];
 
 	fprintf(stdout, "\nFile type distribution:\n");
-	fprintf(stdout, header_format, "type", "count", "ratio",
-			"distribution");
+	fprintf(stdout, header_format, "type", "count", "ratio", "distribution");
 	for (i = 0; i < len; i++) {
 		memset(col1, 0, sizeof(col1));
 		memset(col4, 0, sizeof(col4));
@@ -480,17 +479,17 @@ static void erofsdump_file_statistic(void)
 			file_category_types[i], stats.file_category_stat[i]);
 
 	stats.compress_rate = (double)(100 * stats.files_total_size) /
-		(double)(stats.files_total_origin_size);
+			      (double)(stats.files_total_origin_size);
 	fprintf(stdout, "Filesystem compressed files:            %lu\n",
-			stats.compressed_files);
+		stats.compressed_files);
 	fprintf(stdout, "Filesystem uncompressed files:          %lu\n",
-			stats.uncompressed_files);
+		stats.uncompressed_files);
 	fprintf(stdout, "Filesystem total original file size:    %lu Bytes\n",
-			stats.files_total_origin_size);
+		stats.files_total_origin_size);
 	fprintf(stdout, "Filesystem total file size:             %lu Bytes\n",
-			stats.files_total_size);
+		stats.files_total_size);
 	fprintf(stdout, "Filesystem compress rate:               %.2f%%\n",
-			stats.compress_rate);
+		stats.compress_rate);
 }
 
 static void erofsdump_print_statistic(void)
@@ -513,11 +512,11 @@ static void erofsdump_print_statistic(void)
 	}
 	erofsdump_file_statistic();
 	erofsdump_filesize_distribution("Original",
-			stats.file_original_size,
-			ARRAY_SIZE(stats.file_original_size));
+					stats.file_original_size,
+					ARRAY_SIZE(stats.file_original_size));
 	erofsdump_filesize_distribution("On-disk",
-			stats.file_comp_size,
-			ARRAY_SIZE(stats.file_comp_size));
+					stats.file_comp_size,
+					ARRAY_SIZE(stats.file_comp_size));
 	erofsdump_filetype_distribution(file_types, OTHERFILETYPE);
 }
 
@@ -528,19 +527,19 @@ static void erofsdump_show_superblock(void)
 	int i = 0;
 
 	fprintf(stdout, "Filesystem magic number:                      0x%04X\n",
-			EROFS_SUPER_MAGIC_V1);
+		EROFS_SUPER_MAGIC_V1);
 	fprintf(stdout, "Filesystem blocks:                            %llu\n",
-			sbi.total_blocks | 0ULL);
+		sbi.total_blocks | 0ULL);
 	fprintf(stdout, "Filesystem inode metadata start block:        %u\n",
-			sbi.meta_blkaddr);
+		sbi.meta_blkaddr);
 	fprintf(stdout, "Filesystem shared xattr metadata start block: %u\n",
-			sbi.xattr_blkaddr);
+		sbi.xattr_blkaddr);
 	fprintf(stdout, "Filesystem root nid:                          %llu\n",
-			sbi.root_nid | 0ULL);
+		sbi.root_nid | 0ULL);
 	fprintf(stdout, "Filesystem inode count:                       %llu\n",
-			sbi.inos | 0ULL);
+		sbi.inos | 0ULL);
 	fprintf(stdout, "Filesystem created:                           %s",
-			ctime(&time));
+		ctime(&time));
 	fprintf(stdout, "Filesystem features:                          ");
 	for (; i < ARRAY_SIZE(feature_lists); i++) {
 		u32 feat = le32_to_cpu(feature_lists[i].compat ?
@@ -553,7 +552,7 @@ static void erofsdump_show_superblock(void)
 	uuid_unparse_lower(sbi.uuid, uuid_str);
 #endif
 	fprintf(stdout, "\nFilesystem UUID:                              %s\n",
-			uuid_str);
+		uuid_str);
 }
 
 int main(int argc, char **argv)
diff --git a/fsck/main.c b/fsck/main.c
index 56595e3..8fd23eb 100644
--- a/fsck/main.c
+++ b/fsck/main.c
@@ -396,10 +396,10 @@ static int erofs_verify_inode_data(struct erofs_inode *inode, int outfd)
 		map.m_la = pos;
 		if (compressed)
 			ret = z_erofs_map_blocks_iter(inode, &map,
-					EROFS_GET_BLOCKS_FIEMAP);
+						      EROFS_GET_BLOCKS_FIEMAP);
 		else
 			ret = erofs_map_blocks(inode, &map,
-					EROFS_GET_BLOCKS_FIEMAP);
+					       EROFS_GET_BLOCKS_FIEMAP);
 		if (ret)
 			goto out;
 
diff --git a/fuse/main.c b/fuse/main.c
index b869a00..90ed611 100644
--- a/fuse/main.c
+++ b/fuse/main.c
@@ -61,7 +61,6 @@ int erofsfuse_readdir(const char *path, void *buf, fuse_fill_dir_t filler,
 #else
 	return erofs_iterate_dir(&ctx.ctx, true);
 #endif
-
 }
 
 static void *erofsfuse_init(struct fuse_conn_info *info)
diff --git a/include/erofs/block_list.h b/include/erofs/block_list.h
index 78fab44..9f195c8 100644
--- a/include/erofs/block_list.h
+++ b/include/erofs/block_list.h
@@ -25,10 +25,10 @@ void erofs_droid_blocklist_write_extent(struct erofs_inode *inode,
 					bool first_extent, bool last_extent);
 #else
 static inline void erofs_droid_blocklist_write(struct erofs_inode *inode,
-				 erofs_blk_t blk_start, erofs_blk_t nblocks) {}
+					       erofs_blk_t blk_start, erofs_blk_t nblocks) {}
 static inline void
 erofs_droid_blocklist_write_tail_end(struct erofs_inode *inode,
-					  erofs_blk_t blkaddr) {}
+				     erofs_blk_t blkaddr) {}
 static inline void
 erofs_droid_blocklist_write_extent(struct erofs_inode *inode,
 				   erofs_blk_t blk_start, erofs_blk_t nblocks,
diff --git a/include/erofs/defs.h b/include/erofs/defs.h
index e745bc0..e5aa23c 100644
--- a/include/erofs/defs.h
+++ b/include/erofs/defs.h
@@ -61,7 +61,6 @@ typedef int16_t         s16;
 typedef int32_t         s32;
 typedef int64_t         s64;
 
-
 #if __BYTE_ORDER == __LITTLE_ENDIAN
 /*
  * The host byte order is the same as network byte order,
diff --git a/include/erofs/dir.h b/include/erofs/dir.h
index 1627d3d..74bffb5 100644
--- a/include/erofs/dir.h
+++ b/include/erofs/dir.h
@@ -42,7 +42,7 @@ struct erofs_dir_context {
 	/*
 	 * During execution of |erofs_iterate_dir|, the function needs to
 	 * read the values inside |erofs_inode* dir|. So it is important
-	 * that the callback function does not modify stuct pointed by
+	 * that the callback function does not modify struct pointed by
 	 * |dir|. It is OK to repoint |dir| to other objects.
 	 * Unfortunately, it's not possible to enforce this restriction
 	 * with const keyword, as |erofs_iterate_dir| needs to modify
diff --git a/include/erofs/internal.h b/include/erofs/internal.h
index d4efc18..4b22895 100644
--- a/include/erofs/internal.h
+++ b/include/erofs/internal.h
@@ -328,7 +328,7 @@ int erofs_read_inode_from_disk(struct erofs_inode *vi);
 int erofs_pread(struct erofs_inode *inode, char *buf,
 		erofs_off_t count, erofs_off_t offset);
 int erofs_map_blocks(struct erofs_inode *inode,
-		struct erofs_map_blocks *map, int flags);
+		     struct erofs_map_blocks *map, int flags);
 int erofs_map_dev(struct erofs_sb_info *sbi, struct erofs_map_dev *map);
 
 static inline int erofs_get_occupied_size(const struct erofs_inode *inode,
diff --git a/include/erofs/list.h b/include/erofs/list.h
index 2a0e961..3f5da1a 100644
--- a/include/erofs/list.h
+++ b/include/erofs/list.h
@@ -110,7 +110,6 @@ static inline int list_empty(struct list_head *head)
 	     &pos->member != (head);                                           \
 	     pos = n, n = list_next_entry(n, member))
 
-
 #ifdef __cplusplus
 }
 #endif
diff --git a/lib/blobchunk.c b/lib/blobchunk.c
index a145be9..4a440d6 100644
--- a/lib/blobchunk.c
+++ b/lib/blobchunk.c
@@ -29,7 +29,7 @@ static bool multidev;
 static struct erofs_buffer_head *bh_devt;
 
 static struct erofs_blobchunk *erofs_blob_getchunk(int fd,
-		unsigned int chunksize)
+						   unsigned int chunksize)
 {
 	static u8 zeroed[EROFS_BLKSIZ];
 	u8 *chunkdata, sha256[32];
diff --git a/lib/cache.c b/lib/cache.c
index f820c0b..c735363 100644
--- a/lib/cache.c
+++ b/lib/cache.c
@@ -331,7 +331,6 @@ struct erofs_buffer_head *erofs_battach(struct erofs_buffer_head *bh,
 		return ERR_PTR(ret);
 	}
 	return nbh;
-
 }
 
 static erofs_blk_t __erofs_mapbh(struct erofs_buffer_block *bb)
diff --git a/lib/compress.c b/lib/compress.c
index e050df0..df6411c 100644
--- a/lib/compress.c
+++ b/lib/compress.c
@@ -114,7 +114,7 @@ static void vle_write_indexes(struct z_erofs_vle_compress_ctx *ctx,
 			 */
 			if (d0 >= Z_EROFS_VLE_DI_D0_CBLKCNT)
 				di.di_u.delta[0] = cpu_to_le16(
-						Z_EROFS_VLE_DI_D0_CBLKCNT - 1);
+						   Z_EROFS_VLE_DI_D0_CBLKCNT - 1);
 			else
 				di.di_u.delta[0] = cpu_to_le16(d0);
 			di.di_u.delta[1] = cpu_to_le16(d1);
diff --git a/lib/compress_hints.c b/lib/compress_hints.c
index 25adf35..c3f3d48 100644
--- a/lib/compress_hints.c
+++ b/lib/compress_hints.c
@@ -29,7 +29,7 @@ static int erofs_insert_compress_hints(const char *s, unsigned int blks)
 	if (!r)
 		return -ENOMEM;
 
-	ret = regcomp(&r->reg, s, REG_EXTENDED|REG_NOSUB);
+	ret = regcomp(&r->reg, s, REG_EXTENDED | REG_NOSUB);
 	if (ret) {
 		dump_regerror(ret, s, &r->reg);
 		goto err_out;
diff --git a/lib/compressor_liblzma.c b/lib/compressor_liblzma.c
index acf442f..e0b5b44 100644
--- a/lib/compressor_liblzma.c
+++ b/lib/compressor_liblzma.c
@@ -1,7 +1,5 @@
 // SPDX-License-Identifier: GPL-2.0+ OR Apache-2.0
 /*
- * erofs-utils/lib/compressor_liblzma.c
- *
  * Copyright (C) 2021 Gao Xiang <xiang@kernel.org>
  */
 #include <stdlib.h>
@@ -24,8 +22,9 @@ static int erofs_liblzma_compress_destsize(const struct erofs_compress *c,
 {
 	struct erofs_liblzma_context *ctx = c->private_data;
 	lzma_stream *strm = &ctx->strm;
+	lzma_ret ret;
 
-	lzma_ret ret = lzma_microlzma_encoder(strm, &ctx->opt);
+	ret = lzma_microlzma_encoder(strm, &ctx->opt);
 	if (ret != LZMA_OK)
 		return -EFAULT;
 
diff --git a/lib/data.c b/lib/data.c
index e57707e..b338846 100644
--- a/lib/data.c
+++ b/lib/data.c
@@ -62,7 +62,7 @@ err_out:
 }
 
 int erofs_map_blocks(struct erofs_inode *inode,
-		struct erofs_map_blocks *map, int flags)
+		     struct erofs_map_blocks *map, int flags)
 {
 	struct erofs_inode *vi = inode;
 	struct erofs_inode_chunk_index *idx;
diff --git a/lib/dir.c b/lib/dir.c
index 8955931..7fefa6a 100644
--- a/lib/dir.c
+++ b/lib/dir.c
@@ -42,7 +42,7 @@ static int traverse_dirents(struct erofs_dir_context *ctx,
 		}
 
 		if (nameoff + de_namelen > maxsize ||
-				de_namelen > EROFS_NAME_LEN) {
+			de_namelen > EROFS_NAME_LEN) {
 			errmsg = "bogus dirent namelen";
 			break;
 		}
diff --git a/lib/exclude.c b/lib/exclude.c
index e3c4ed5..808d0c8 100644
--- a/lib/exclude.c
+++ b/lib/exclude.c
@@ -42,7 +42,7 @@ static struct erofs_exclude_rule *erofs_insert_exclude(const char *s,
 	}
 
 	if (is_regex) {
-		ret = regcomp(&r->reg, s, REG_EXTENDED|REG_NOSUB);
+		ret = regcomp(&r->reg, s, REG_EXTENDED | REG_NOSUB);
 		if (ret) {
 			dump_regerror(ret, s, &r->reg);
 			goto err_rule;
diff --git a/lib/inode.c b/lib/inode.c
index e680b23..5db4691 100644
--- a/lib/inode.c
+++ b/lib/inode.c
@@ -1108,7 +1108,7 @@ fail:
 		d->type = ftype;
 
 		erofs_d_invalidate(d);
-		erofs_info("add file %s/%s (nid %llu, type %d)",
+		erofs_info("add file %s/%s (nid %llu, type %u)",
 			   dir->i_srcpath, d->name, (unsigned long long)d->nid,
 			   d->type);
 	}
diff --git a/lib/io.c b/lib/io.c
index 5bc3432..9c663c5 100644
--- a/lib/io.c
+++ b/lib/io.c
@@ -370,7 +370,7 @@ ssize_t erofs_copy_file_range(int fd_in, erofs_off_t *off_in,
 	ssize_t ret;
 
 	ret = copy_file_range(fd_in, &off64_in, fd_out, &off64_out,
-                              length, 0);
+			      length, 0);
 	if (ret >= 0)
 		goto out;
 	if (errno != ENOSYS) {
diff --git a/lib/liberofs_private.h b/lib/liberofs_private.h
index 0eeca3c..36f8ad4 100644
--- a/lib/liberofs_private.h
+++ b/lib/liberofs_private.h
@@ -19,7 +19,7 @@ static inline void *memrchr(const void *s, int c, size_t n)
 
 	for (p += n; n > 0; n--)
 		if (*--p == c)
-			return (void*)p;
+			return (void *)p;
 	return NULL;
 }
 #endif
diff --git a/lib/namei.c b/lib/namei.c
index 97f0f80..6163238 100644
--- a/lib/namei.c
+++ b/lib/namei.c
@@ -144,7 +144,6 @@ bogusimode:
 	return -EFSCORRUPTED;
 }
 
-
 struct erofs_dirent *find_target_dirent(erofs_nid_t pnid,
 					void *dentry_blk,
 					const char *name, unsigned int len,
diff --git a/lib/super.c b/lib/super.c
index 69522bd..f486eb7 100644
--- a/lib/super.c
+++ b/lib/super.c
@@ -15,7 +15,7 @@ static bool check_layout_compatibility(struct erofs_sb_info *sbi,
 	sbi->feature_incompat = feature;
 
 	/* check if current kernel meets all mandatory requirements */
-	if (feature & (~EROFS_ALL_FEATURE_INCOMPAT)) {
+	if (feature & ~EROFS_ALL_FEATURE_INCOMPAT) {
 		erofs_err("unidentified incompatible feature %x, please upgrade kernel version",
 			  feature & ~EROFS_ALL_FEATURE_INCOMPAT);
 		return false;
@@ -87,7 +87,7 @@ int erofs_read_superblock(void)
 	blkszbits = dsb->blkszbits;
 	/* 9(512 bytes) + LOG_SECTORS_PER_BLOCK == LOG_BLOCK_SIZE */
 	if (blkszbits != LOG_BLOCK_SIZE) {
-		erofs_err("blksize %u isn't supported on this platform",
+		erofs_err("blksize %d isn't supported on this platform",
 			  1 << blkszbits);
 		return ret;
 	}
diff --git a/lib/xattr.c b/lib/xattr.c
index 71ffe3e..49970e4 100644
--- a/lib/xattr.c
+++ b/lib/xattr.c
@@ -405,9 +405,9 @@ static int erofs_droid_xattr_set_caps(struct erofs_inode *inode)
 
 	memcpy(kvbuf, "capability", len[0]);
 	caps.magic_etc = VFS_CAP_REVISION_2 | VFS_CAP_FLAGS_EFFECTIVE;
-	caps.data[0].permitted = (u32) capabilities;
+	caps.data[0].permitted = (u32)capabilities;
 	caps.data[0].inheritable = 0;
-	caps.data[1].permitted = (u32) (capabilities >> 32);
+	caps.data[1].permitted = (u32)(capabilities >> 32);
 	caps.data[1].inheritable = 0;
 	memcpy(kvbuf + len[0], &caps, len[1]);
 
diff --git a/mkfs/main.c b/mkfs/main.c
index 282126a..0724212 100644
--- a/mkfs/main.c
+++ b/mkfs/main.c
@@ -204,7 +204,7 @@ static int mkfs_parse_options_cfg(int argc, char *argv[])
 	bool quiet = false;
 
 	while ((opt = getopt_long(argc, argv, "C:E:T:U:d:x:z:",
-				 long_options, NULL)) != -1) {
+				  long_options, NULL)) != -1) {
 		switch (opt) {
 		case 'z':
 			if (!optarg) {
-- 
2.25.1

