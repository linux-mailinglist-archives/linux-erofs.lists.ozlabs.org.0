Return-Path: <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>
X-Original-To: lists+linux-erofs@lfdr.de
Delivered-To: lists+linux-erofs@lfdr.de
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2404:9400:2:0:216:3eff:fee1:b9f1])
	by mail.lfdr.de (Postfix) with ESMTPS id 35B55465C21
	for <lists+linux-erofs@lfdr.de>; Thu,  2 Dec 2021 03:26:03 +0100 (CET)
Received: from boromir.ozlabs.org (localhost [IPv6:::1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4J4KZK0FLkz2ync
	for <lists+linux-erofs@lfdr.de>; Thu,  2 Dec 2021 13:26:01 +1100 (AEDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=lists.ozlabs.org;
	s=201707; t=1638411961;
	bh=F19JPCBc2fWbqN6qB86HZkFWHUERgdr2q+PeoeojUXY=;
	h=To:Subject:Date:In-Reply-To:References:List-Id:List-Unsubscribe:
	 List-Archive:List-Post:List-Help:List-Subscribe:From:Reply-To:
	 From;
	b=Yb+gFwZ55ZZjQTu3OSykkOw6hlqk0Bct+SzjNFu72o2J9z0G1P3TniP1djMNthmFl
	 wo3Ta45fDmeCpYR1ojSaRNEbtdk/pYCFbs52PQDTpRwZp0yw8Kr1CxRNvti6ugGLso
	 vKDFIm+iv6rBuACWglOZcEZrSy+34xDAe7M/K8nPKX8yKpR3sG3QeL24kAT17ZdnHd
	 gwdEhMBe0AgZg/yaE1QECYvtE1ieZah85A2cdSS7KZaB97gJRJxe7d2KOcpvrMAeDx
	 zzBce7oPTL1Kn5NnnUpc8eS0Pav8mslvdoiuLVUqZUQOfCCPDNr7w3AkHsBI8Y2U7D
	 0IV2jogJHeObA==
X-Original-To: linux-erofs@lists.ozlabs.org
Delivered-To: linux-erofs@lists.ozlabs.org
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized)
 smtp.mailfrom=oppo.com (client-ip=40.107.255.42;
 helo=apc01-psa-obe.outbound.protection.outlook.com;
 envelope-from=huangjianan@oppo.com; receiver=<UNKNOWN>)
Authentication-Results: lists.ozlabs.org; dkim=pass (1024-bit key;
 unprotected) header.d=oppo.com header.i=@oppo.com header.a=rsa-sha256
 header.s=selector1 header.b=dk0iVgVQ; 
 dkim-atps=neutral
Received: from APC01-PSA-obe.outbound.protection.outlook.com
 (mail-psaapc01on2042.outbound.protection.outlook.com [40.107.255.42])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 4J4KZB1GKgz2yP0
 for <linux-erofs@lists.ozlabs.org>; Thu,  2 Dec 2021 13:25:52 +1100 (AEDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=OE69g2EBCw1ts15Lz1lBBJG9pGTgQwt7kbaZt/B9RGm8fCVWvzDegMX1elOTfRWS9aSusU1NJ1Pn2n/0UPso1kjcNsxrptNavPSUxLxwY+1Eh/cOelvl+XM6r6ZVMxFayuC/2E0eUjr0bqetuQHPDRgk69XcDVsfZkqSzNgT4ra1UB1esMmcMuHIj/Rv7WhzBuyR0FUbP9DqERZycDH5Q2yQ3H4Tt3xmTgmxQoi5IPhQhOk5+XGOj2ytnpcPEdDkbKO2O2C530tl65k6T/h8F4RHkKN1zNMX/i1UwLy3EkpRRUmLzgIRRYfCt2QkK5lZ+43oEAVcRPKnV2gb+HZnNw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=F19JPCBc2fWbqN6qB86HZkFWHUERgdr2q+PeoeojUXY=;
 b=J/Xz9f1vIJ7eoQSInOk54CVYejCb1MTUURdFXp2H+QgBRzGeU6Bp1credhBcR/uiXzh6sleZt6jEBVW2rB9NtiQmW48jG8/+kBpXQKcJ43Hsdp4Sa1pMp5UNm54T9PcGLVbkhTHlRwgEmd9A9/3Mt5ZRwqIhoLHlgz3LW/UjKSJPdO3mvSINsrhtA5Nm2vja7CdRYfF3hSfQXtMZtu6HiJ7r/3KueF2m2q766mVzNjQG3sYxW2Af3hRkVwMHQb7Cd5QwKCkjKlPUor3Z+rNCcNtoVh0vQXa9MrHvAVP8y5XDhB+T4lwQOX1Ye7TmCWH9ZCaRZCs0Whv1iNv3NaKc4w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oppo.com; dmarc=pass action=none header.from=oppo.com;
 dkim=pass header.d=oppo.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=oppo.com;
Received: from SG2PR02MB4108.apcprd02.prod.outlook.com (2603:1096:4:96::19) by
 SG2PR02MB4282.apcprd02.prod.outlook.com (2603:1096:0:11::9) with
 Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.4734.23; Thu, 2 Dec 2021 02:25:32 +0000
Received: from SG2PR02MB4108.apcprd02.prod.outlook.com
 ([fe80::12a:f861:9ae2:b8f0]) by SG2PR02MB4108.apcprd02.prod.outlook.com
 ([fe80::12a:f861:9ae2:b8f0%5]) with mapi id 15.20.4734.024; Thu, 2 Dec 2021
 02:25:32 +0000
To: linux-erofs@lists.ozlabs.org,
	hsiangkao@linux.alibaba.com
Subject: [PATCH v2] erofs-utils: add Apache 2.0 license
Date: Thu,  2 Dec 2021 10:25:21 +0800
Message-Id: <20211202022521.4291-1-huangjianan@oppo.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <Yaeq51nipFpzhD7r@B-P7TQMD6M-0146.local>
References: <Yaeq51nipFpzhD7r@B-P7TQMD6M-0146.local>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SG2PR01CA0104.apcprd01.prod.exchangelabs.com
 (2603:1096:3:15::30) To SG2PR02MB4108.apcprd02.prod.outlook.com
 (2603:1096:4:96::19)
MIME-Version: 1.0
Received: from PC80253450.adc.com (58.252.5.73) by
 SG2PR01CA0104.apcprd01.prod.exchangelabs.com (2603:1096:3:15::30) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4734.24 via Frontend
 Transport; Thu, 2 Dec 2021 02:25:31 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 293793eb-c9e3-40a9-5aa2-08d9b53b039b
X-MS-TrafficTypeDiagnostic: SG2PR02MB4282:
X-Microsoft-Antispam-PRVS: <SG2PR02MB4282E6FD766CBF9800A60FDBC3699@SG2PR02MB4282.apcprd02.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:142;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: ilp6Aw3td6NPbrDjyK3NWH/OoAqIFbnftYlWFn45FxztIZCOZrqubWR/MaXS4HgBAtMrRG0HlxggvSYtzafbTcoGTDCRdAZEFZpaCFxxfwLdvK1JKuHlj+hXP3XklgGB+ALpT2yhcOeeKxhPkHp86/G+jrlJ3Ja4g/Qny8/gz+FRBAz5v6qNWSwfkHiG7FAVZoGdZp3xeo/+IxeEZqxqEkbMXT2N3puCil2vXdZhA/DriFd6cGI1lRsgjL/OTSNRB3pexHQfypCXJ3GQ1iWfFJDS8EYHVIPWzVi72to/Pw92hmA819uaxK42au6fLm6z78XMQ8+L62CAfwgC85PNF1yyqbouB9tH7isG1BMXpFmiUq4+BNM/j4L9DOHLbi0VWPfPxa+ZI/s7abdB4xtbgzV2C86pw4Gnb8v54D/rsleKmilBfohD3FJ9nfPJI6+dsSXYEO1oPxPMM36Z/3w0aA026w/9OXDaKE8HPE7Ayemm2GOXfx1zl9q1D+VJK4LEhCEd/xzEMhH8ARujU2X+Rf+QIqlWv0v1ktmvooDFbOg9Q8jIQ3AvcUBz13HLdTb4KNuNrJJla8vvTgAtd/FCBlywTBoIM/DpPbq7n2mz0m+7e3scD2zsuvWYMFJWL+MhPwbc/OahdkTxA4qRJx9pGPUeiY11wv5XSxDBknG2R7MN2p7OcfAyE8WcplA7G6qPkGCzB2JA0xszR6rgJDB/WVUbbYYiArtIG3N5/AUOFCbyeWWZRYkv2rZTfjAoW01UsbEn3UWSAm2gQnzNiIYsyMqCp6DTd4V7owpg8MjSea2h8Gg2mo9xeoMvFhqkADnb
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:SG2PR02MB4108.apcprd02.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(4636009)(366004)(83380400001)(1076003)(8676002)(316002)(2616005)(66476007)(186003)(8936002)(956004)(4326008)(36756003)(26005)(6506007)(107886003)(38350700002)(508600001)(5660300002)(86362001)(52116002)(966005)(30864003)(66556008)(6666004)(6512007)(66946007)(38100700002)(6486002)(2906002)(11606007);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?0OP9SAiQWLIXpcAhPJ+i/H4DvM/mIZo1+G5yXxg5wgO+c9kYXpKxNHN7+Rrz?=
 =?us-ascii?Q?rsvj1ua3jSpedLVI45Yr9Ohsh0CwA6RJUtd7RmwHw6rfaEbMY8d6NkPSREKO?=
 =?us-ascii?Q?MEyVAlBSNDRUCtYsHRloRZxCRAxNe5lfRGIUy2GMXZuPs/tPc5GkUfw48lzb?=
 =?us-ascii?Q?Mf7VljKndqdCN4XkZK6/ZED1wfN1kW06Tf41pIkM1EyyqGjCD21Fgpf+SJ9U?=
 =?us-ascii?Q?Q6cG6uj3jIzorNg8Z5v6OLRY6CGZEmviwTivdS5wx20Yswe3W5tMLhgahu84?=
 =?us-ascii?Q?F4e8zr5IvuYYdZ521FggUsuapIC2G0yuGPCUc5QsfH22liv64oa8erpYkE/3?=
 =?us-ascii?Q?2XLa1LqYfxpBDhcthN4h7QBHCY3xEt9bVk/qlHzLDTvLwDZQveKpljgUBh7T?=
 =?us-ascii?Q?3LTZlxrP0jUW2NWzTG9pNsBpU+RtSABtTuu6y0GKxtBqQkk+ahnmXqsMPhfT?=
 =?us-ascii?Q?CONvdyqDmsKgIAdrJONGzo846f/wAofW0dRwfo/uLBCllmRcgAh3DbK06a8T?=
 =?us-ascii?Q?gLVvW8+bK+f25pQ93NWLglZ4pIAOm2+RKr2Lul743KkYVqV6VH5aHCL5B7bH?=
 =?us-ascii?Q?NgBqwjfbQYYWClksfGLU+hlDckvxA8oHVwr7n/5jQI6yrqiSXa0FkjpLtO9n?=
 =?us-ascii?Q?Psq7BWCaXktEKeh6NeyU4rey3Fp4Q0QDiTzvMMqiFAwclniavp8hgyWf0m04?=
 =?us-ascii?Q?CFg3dQMvb90MYWRAANiJaSIEC0w7cWqW+N8OxjWaU/BMvdq74fmKaX/Z04+B?=
 =?us-ascii?Q?B/MtK7snKav22A4BeFTo9YqSc3vOVuC5IikEGppAzib+59jWQV85bUwCJ3I4?=
 =?us-ascii?Q?VqgbcrD8KMpjDHd6tfRqut/hiYnzgf+cC4dZGpo0rd5SAFTC3juQuOnU8NHv?=
 =?us-ascii?Q?3RkTv35aNiB1gfC2GReMz+BaUW2muQPwcI4OWSLIfWIRpogdf1ApZKL9dhMj?=
 =?us-ascii?Q?CR/mQtP418k9VWlLt4pZjvIPcOY1myLrVU4kARlbSnqZGOEywYHaPAHPcuKd?=
 =?us-ascii?Q?pXJOYno5W3FpKcY1PhuZ3/hkRFIJUI7fGzsfCnQ7zEv3pc2wD/iL8IoRA+FQ?=
 =?us-ascii?Q?cn8et+RKmawCjWMrNIhMyR7uEQlnD50r7P1wet5qkc3U1VS3jiEJXI4RkwjR?=
 =?us-ascii?Q?q6prSTUODtRWPgh0cXK9TqQJB36rin9wE6Ht06cNfSYfOhGxfw+xilyK6ZxV?=
 =?us-ascii?Q?AHiZr7bEGMTlkVTEJuS8/GKVODhKv2L8GArXskJjnh7eT/lDzulxXcX2KR1y?=
 =?us-ascii?Q?mEaE05HqbdCrhT9SiaeU0tguzwuJqypftNnyZHl6Gfktlp0b+oMfMWj6c+IV?=
 =?us-ascii?Q?gZkihFlYWm1/bGKl5B+VZJTUQiYTfQIgs+S7mY1AerEGyb3kFGaXUPfmhSAc?=
 =?us-ascii?Q?3oy2drxq4ZsmMsBS1LcUoRfsCiqpBG+dJeFm2ERyrH+oSJI+zvpSZG+bpVvP?=
 =?us-ascii?Q?sIvbOWMIRC/86P37KfesQi3PY8KGoEgEPFT9whAIZL/612Z1JRCJQJ0ENnhZ?=
 =?us-ascii?Q?GG6bC6tn3sQvO9SHdAzP+7Vg6rCtNXJVMBaEQI2wEnjkqHXMbaJmBWcY4EzZ?=
 =?us-ascii?Q?NQ+iQy6Qiio4+B7ISye7F7IT2mB9ERFcuASYAdcq0CLbs2IauIK169XThr8C?=
 =?us-ascii?Q?XCglCqbyrIYaGEavTockKAE=3D?=
X-OriginatorOrg: oppo.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 293793eb-c9e3-40a9-5aa2-08d9b53b039b
X-MS-Exchange-CrossTenant-AuthSource: SG2PR02MB4108.apcprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 02 Dec 2021 02:25:32.0924 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: f1905eb1-c353-41c5-9516-62b4a54b5ee6
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: o+HeTTzwi0Jl6prMSLcwPHphMMBdSTx3FJ09G5dXRldpyRgtXuG7iBu72b1BYTZWbbDAb9bCmn5s4si6p0tzbA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SG2PR02MB4282
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
Errors-To: linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org
Sender: "Linux-erofs"
 <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>

Let's release liberofs under GPL-2.0+ OR Apache-2.0 license for
better integration.

Signed-off-by: Huang Jianan <huangjianan@oppo.com>
---
 include/erofs/blobchunk.h      | 2 +-
 include/erofs/block_list.h     | 2 +-
 include/erofs/cache.h          | 2 +-
 include/erofs/compress.h       | 2 +-
 include/erofs/compress_hints.h | 2 +-
 include/erofs/config.h         | 2 +-
 include/erofs/decompress.h     | 2 +-
 include/erofs/defs.h           | 2 +-
 include/erofs/err.h            | 2 +-
 include/erofs/exclude.h        | 2 +-
 include/erofs/inode.h          | 2 +-
 include/erofs/internal.h       | 2 +-
 include/erofs/io.h             | 2 +-
 include/erofs/list.h           | 2 +-
 include/erofs/print.h          | 2 +-
 include/erofs/trace.h          | 2 +-
 include/erofs/xattr.h          | 2 +-
 lib/Makefile.am                | 2 +-
 lib/blobchunk.c                | 2 +-
 lib/block_list.c               | 2 +-
 lib/cache.c                    | 2 +-
 lib/compress.c                 | 2 +-
 lib/compress_hints.c           | 2 +-
 lib/compressor.c               | 2 +-
 lib/compressor.h               | 2 +-
 lib/compressor_liblzma.c       | 2 +-
 lib/compressor_lz4.c           | 2 +-
 lib/compressor_lz4hc.c         | 2 +-
 lib/config.c                   | 2 +-
 lib/data.c                     | 2 +-
 lib/decompress.c               | 2 +-
 lib/exclude.c                  | 2 +-
 lib/inode.c                    | 2 +-
 lib/io.c                       | 2 +-
 lib/namei.c                    | 2 +-
 lib/super.c                    | 2 +-
 lib/xattr.c                    | 2 +-
 lib/zmap.c                     | 2 +-
 38 files changed, 38 insertions(+), 38 deletions(-)

diff --git a/include/erofs/blobchunk.h b/include/erofs/blobchunk.h
index 4e1ae79..49cb7bf 100644
--- a/include/erofs/blobchunk.h
+++ b/include/erofs/blobchunk.h
@@ -1,4 +1,4 @@
-// SPDX-License-Identifier: GPL-2.0+
+/* SPDX-License-Identifier: GPL-2.0+ OR Apache-2.0 */
 /*
  * erofs-utils/lib/blobchunk.h
  *
diff --git a/include/erofs/block_list.h b/include/erofs/block_list.h
index ca8053e..78fab44 100644
--- a/include/erofs/block_list.h
+++ b/include/erofs/block_list.h
@@ -1,4 +1,4 @@
-/* SPDX-License-Identifier: GPL-2.0+ */
+/* SPDX-License-Identifier: GPL-2.0+ OR Apache-2.0 */
 /*
  * Copyright (C), 2021, Coolpad Group Limited.
  * Created by Yue Hu <huyue2@yulong.com>
diff --git a/include/erofs/cache.h b/include/erofs/cache.h
index 7957ee5..de12399 100644
--- a/include/erofs/cache.h
+++ b/include/erofs/cache.h
@@ -1,4 +1,4 @@
-/* SPDX-License-Identifier: GPL-2.0+ */
+/* SPDX-License-Identifier: GPL-2.0+ OR Apache-2.0 */
 /*
  * Copyright (C) 2018 HUAWEI, Inc.
  *             http://www.huawei.com/
diff --git a/include/erofs/compress.h b/include/erofs/compress.h
index fdbf5ff..21eac57 100644
--- a/include/erofs/compress.h
+++ b/include/erofs/compress.h
@@ -1,4 +1,4 @@
-/* SPDX-License-Identifier: GPL-2.0+ */
+/* SPDX-License-Identifier: GPL-2.0+ OR Apache-2.0 */
 /*
  * Copyright (C) 2019 HUAWEI, Inc.
  *             http://www.huawei.com/
diff --git a/include/erofs/compress_hints.h b/include/erofs/compress_hints.h
index 43f80e1..659c5b6 100644
--- a/include/erofs/compress_hints.h
+++ b/include/erofs/compress_hints.h
@@ -1,4 +1,4 @@
-/* SPDX-License-Identifier: GPL-2.0+ */
+/* SPDX-License-Identifier: GPL-2.0+ OR Apache-2.0 */
 /*
  * Copyright (C), 2008-2021, OPPO Mobile Comm Corp., Ltd.
  * Created by Huang Jianan <huangjianan@oppo.com>
diff --git a/include/erofs/config.h b/include/erofs/config.h
index cb064b6..e41c079 100644
--- a/include/erofs/config.h
+++ b/include/erofs/config.h
@@ -1,4 +1,4 @@
-/* SPDX-License-Identifier: GPL-2.0+ */
+/* SPDX-License-Identifier: GPL-2.0+ OR Apache-2.0 */
 /*
  * Copyright (C) 2018-2019 HUAWEI, Inc.
  *             http://www.huawei.com/
diff --git a/include/erofs/decompress.h b/include/erofs/decompress.h
index e649c80..82bf7b8 100644
--- a/include/erofs/decompress.h
+++ b/include/erofs/decompress.h
@@ -1,4 +1,4 @@
-/* SPDX-License-Identifier: GPL-2.0+ */
+/* SPDX-License-Identifier: GPL-2.0+ OR Apache-2.0 */
 /*
  * Copyright (C), 2008-2020, OPPO Mobile Comm Corp., Ltd.
  * Created by Huang Jianan <huangjianan@oppo.com>
diff --git a/include/erofs/defs.h b/include/erofs/defs.h
index 4db237f..e745bc0 100644
--- a/include/erofs/defs.h
+++ b/include/erofs/defs.h
@@ -1,4 +1,4 @@
-/* SPDX-License-Identifier: GPL-2.0+ */
+/* SPDX-License-Identifier: GPL-2.0+ OR Apache-2.0 */
 /*
  * Copyright (C) 2018 HUAWEI, Inc.
  *             http://www.huawei.com/
diff --git a/include/erofs/err.h b/include/erofs/err.h
index 18f152a..08b0bdb 100644
--- a/include/erofs/err.h
+++ b/include/erofs/err.h
@@ -1,4 +1,4 @@
-/* SPDX-License-Identifier: GPL-2.0+ */
+/* SPDX-License-Identifier: GPL-2.0+ OR Apache-2.0 */
 /*
  * Copyright (C) 2018 HUAWEI, Inc.
  *             http://www.huawei.com/
diff --git a/include/erofs/exclude.h b/include/erofs/exclude.h
index 599f018..3f17032 100644
--- a/include/erofs/exclude.h
+++ b/include/erofs/exclude.h
@@ -1,4 +1,4 @@
-/* SPDX-License-Identifier: GPL-2.0+ */
+/* SPDX-License-Identifier: GPL-2.0+ OR Apache-2.0 */
 /*
  * Created by Li Guifu <bluce.lee@aliyun.com>
  */
diff --git a/include/erofs/inode.h b/include/erofs/inode.h
index e23d65f..79b39b0 100644
--- a/include/erofs/inode.h
+++ b/include/erofs/inode.h
@@ -1,4 +1,4 @@
-/* SPDX-License-Identifier: GPL-2.0+ */
+/* SPDX-License-Identifier: GPL-2.0+ OR Apache-2.0 */
 /*
  * Copyright (C) 2018-2019 HUAWEI, Inc.
  *             http://www.huawei.com/
diff --git a/include/erofs/internal.h b/include/erofs/internal.h
index a68de32..e6beb8c 100644
--- a/include/erofs/internal.h
+++ b/include/erofs/internal.h
@@ -1,4 +1,4 @@
-/* SPDX-License-Identifier: GPL-2.0+ */
+/* SPDX-License-Identifier: GPL-2.0+ OR Apache-2.0 */
 /*
  * Copyright (C) 2019 HUAWEI, Inc.
  *             http://www.huawei.com/
diff --git a/include/erofs/io.h b/include/erofs/io.h
index 6f51e06..0f58c70 100644
--- a/include/erofs/io.h
+++ b/include/erofs/io.h
@@ -1,4 +1,4 @@
-/* SPDX-License-Identifier: GPL-2.0+ */
+/* SPDX-License-Identifier: GPL-2.0+ OR Apache-2.0 */
 /*
  * Copyright (C) 2018-2019 HUAWEI, Inc.
  *             http://www.huawei.com/
diff --git a/include/erofs/list.h b/include/erofs/list.h
index fd5358d..2a0e961 100644
--- a/include/erofs/list.h
+++ b/include/erofs/list.h
@@ -1,4 +1,4 @@
-/* SPDX-License-Identifier: GPL-2.0+ */
+/* SPDX-License-Identifier: GPL-2.0+ OR Apache-2.0 */
 /*
  * Copyright (C) 2018 HUAWEI, Inc.
  *             http://www.huawei.com/
diff --git a/include/erofs/print.h b/include/erofs/print.h
index 2213d1d..f188a6b 100644
--- a/include/erofs/print.h
+++ b/include/erofs/print.h
@@ -1,4 +1,4 @@
-/* SPDX-License-Identifier: GPL-2.0+ */
+/* SPDX-License-Identifier: GPL-2.0+ OR Apache-2.0 */
 /*
  * Copyright (C) 2018-2019 HUAWEI, Inc.
  *             http://www.huawei.com/
diff --git a/include/erofs/trace.h b/include/erofs/trace.h
index 893e16c..398e331 100644
--- a/include/erofs/trace.h
+++ b/include/erofs/trace.h
@@ -1,4 +1,4 @@
-/* SPDX-License-Identifier: GPL-2.0+ */
+/* SPDX-License-Identifier: GPL-2.0+ OR Apache-2.0 */
 /*
  * Copyright (C) 2020 Gao Xiang <hsiangkao@aol.com>
  */
diff --git a/include/erofs/xattr.h b/include/erofs/xattr.h
index 8e68812..226e984 100644
--- a/include/erofs/xattr.h
+++ b/include/erofs/xattr.h
@@ -1,4 +1,4 @@
-/* SPDX-License-Identifier: GPL-2.0+ */
+/* SPDX-License-Identifier: GPL-2.0+ OR Apache-2.0 */
 /*
  * Originally contributed by an anonymous person,
  * heavily changed by Li Guifu <blucerlee@gmail.com>
diff --git a/lib/Makefile.am b/lib/Makefile.am
index 67ba798..c745e49 100644
--- a/lib/Makefile.am
+++ b/lib/Makefile.am
@@ -1,4 +1,4 @@
-# SPDX-License-Identifier: GPL-2.0+
+# SPDX-License-Identifier: GPL-2.0+ OR Apache-2.0
 
 noinst_LTLIBRARIES = liberofs.la
 noinst_HEADERS = $(top_srcdir)/include/erofs_fs.h \
diff --git a/lib/blobchunk.c b/lib/blobchunk.c
index b605b0b..5e9a88a 100644
--- a/lib/blobchunk.c
+++ b/lib/blobchunk.c
@@ -1,4 +1,4 @@
-// SPDX-License-Identifier: GPL-2.0+
+// SPDX-License-Identifier: GPL-2.0+ OR Apache-2.0
 /*
  * erofs-utils/lib/blobchunk.c
  *
diff --git a/lib/block_list.c b/lib/block_list.c
index 87609a9..896fb01 100644
--- a/lib/block_list.c
+++ b/lib/block_list.c
@@ -1,4 +1,4 @@
-// SPDX-License-Identifier: GPL-2.0+
+// SPDX-License-Identifier: GPL-2.0+ OR Apache-2.0
 /*
  * Copyright (C), 2021, Coolpad Group Limited.
  * Created by Yue Hu <huyue2@yulong.com>
diff --git a/lib/cache.c b/lib/cache.c
index 83d591f..f820c0b 100644
--- a/lib/cache.c
+++ b/lib/cache.c
@@ -1,4 +1,4 @@
-// SPDX-License-Identifier: GPL-2.0+
+// SPDX-License-Identifier: GPL-2.0+ OR Apache-2.0
 /*
  * Copyright (C) 2018-2019 HUAWEI, Inc.
  *             http://www.huawei.com/
diff --git a/lib/compress.c b/lib/compress.c
index 98be7a2..6f16e0c 100644
--- a/lib/compress.c
+++ b/lib/compress.c
@@ -1,4 +1,4 @@
-// SPDX-License-Identifier: GPL-2.0+
+// SPDX-License-Identifier: GPL-2.0+ OR Apache-2.0
 /*
  * Copyright (C) 2018-2019 HUAWEI, Inc.
  *             http://www.huawei.com/
diff --git a/lib/compress_hints.c b/lib/compress_hints.c
index 81a8ac9..25adf35 100644
--- a/lib/compress_hints.c
+++ b/lib/compress_hints.c
@@ -1,4 +1,4 @@
-// SPDX-License-Identifier: GPL-2.0+
+// SPDX-License-Identifier: GPL-2.0+ OR Apache-2.0
 /*
  * Copyright (C), 2008-2021, OPPO Mobile Comm Corp., Ltd.
  * Created by Huang Jianan <huangjianan@oppo.com>
diff --git a/lib/compressor.c b/lib/compressor.c
index 6362825..a4d696e 100644
--- a/lib/compressor.c
+++ b/lib/compressor.c
@@ -1,4 +1,4 @@
-// SPDX-License-Identifier: GPL-2.0+
+// SPDX-License-Identifier: GPL-2.0+ OR Apache-2.0
 /*
  * Copyright (C) 2018-2019 HUAWEI, Inc.
  *             http://www.huawei.com/
diff --git a/lib/compressor.h b/lib/compressor.h
index 1ea2724..fd28dfe 100644
--- a/lib/compressor.h
+++ b/lib/compressor.h
@@ -1,4 +1,4 @@
-/* SPDX-License-Identifier: GPL-2.0+ */
+/* SPDX-License-Identifier: GPL-2.0+ OR Apache-2.0 */
 /*
  * Copyright (C) 2018-2019 HUAWEI, Inc.
  *             http://www.huawei.com/
diff --git a/lib/compressor_liblzma.c b/lib/compressor_liblzma.c
index 578ba06..42f3ac6 100644
--- a/lib/compressor_liblzma.c
+++ b/lib/compressor_liblzma.c
@@ -1,4 +1,4 @@
-// SPDX-License-Identifier: GPL-2.0+
+// SPDX-License-Identifier: GPL-2.0+ OR Apache-2.0
 /*
  * erofs-utils/lib/compressor_liblzma.c
  *
diff --git a/lib/compressor_lz4.c b/lib/compressor_lz4.c
index fc8c23c..0936d03 100644
--- a/lib/compressor_lz4.c
+++ b/lib/compressor_lz4.c
@@ -1,4 +1,4 @@
-// SPDX-License-Identifier: GPL-2.0+
+// SPDX-License-Identifier: GPL-2.0+ OR Apache-2.0
 /*
  * Copyright (C) 2018-2019 HUAWEI, Inc.
  *             http://www.huawei.com/
diff --git a/lib/compressor_lz4hc.c b/lib/compressor_lz4hc.c
index 3f68b00..8f2d25c 100644
--- a/lib/compressor_lz4hc.c
+++ b/lib/compressor_lz4hc.c
@@ -1,4 +1,4 @@
-// SPDX-License-Identifier: GPL-2.0+
+// SPDX-License-Identifier: GPL-2.0+ OR Apache-2.0
 /*
  * Copyright (C) 2018-2019 HUAWEI, Inc.
  *             http://www.huawei.com/
diff --git a/lib/config.c b/lib/config.c
index f1c8edf..d3298da 100644
--- a/lib/config.c
+++ b/lib/config.c
@@ -1,4 +1,4 @@
-// SPDX-License-Identifier: GPL-2.0+
+// SPDX-License-Identifier: GPL-2.0+ OR Apache-2.0
 /*
  * Copyright (C) 2018-2019 HUAWEI, Inc.
  *             http://www.huawei.com/
diff --git a/lib/data.c b/lib/data.c
index 27710f9..e57707e 100644
--- a/lib/data.c
+++ b/lib/data.c
@@ -1,4 +1,4 @@
-// SPDX-License-Identifier: GPL-2.0+
+// SPDX-License-Identifier: GPL-2.0+ OR Apache-2.0
 /*
  * Copyright (C) 2020 Gao Xiang <hsiangkao@aol.com>
  * Compression support by Huang Jianan <huangjianan@oppo.com>
diff --git a/lib/decompress.c b/lib/decompress.c
index f313e41..359dae7 100644
--- a/lib/decompress.c
+++ b/lib/decompress.c
@@ -1,4 +1,4 @@
-// SPDX-License-Identifier: GPL-2.0+
+// SPDX-License-Identifier: GPL-2.0+ OR Apache-2.0
 /*
  * Copyright (C), 2008-2020, OPPO Mobile Comm Corp., Ltd.
  * Created by Huang Jianan <huangjianan@oppo.com>
diff --git a/lib/exclude.c b/lib/exclude.c
index 2f980a3..e3c4ed5 100644
--- a/lib/exclude.c
+++ b/lib/exclude.c
@@ -1,4 +1,4 @@
-// SPDX-License-Identifier: GPL-2.0+
+// SPDX-License-Identifier: GPL-2.0+ OR Apache-2.0
 /*
  * Created by Li Guifu <bluce.lee@aliyun.com>
  */
diff --git a/lib/inode.c b/lib/inode.c
index 461c797..b6d3092 100644
--- a/lib/inode.c
+++ b/lib/inode.c
@@ -1,4 +1,4 @@
-// SPDX-License-Identifier: GPL-2.0+
+// SPDX-License-Identifier: GPL-2.0+ OR Apache-2.0
 /*
  * Copyright (C) 2018-2019 HUAWEI, Inc.
  *             http://www.huawei.com/
diff --git a/lib/io.c b/lib/io.c
index a0d366a..5bc3432 100644
--- a/lib/io.c
+++ b/lib/io.c
@@ -1,4 +1,4 @@
-// SPDX-License-Identifier: GPL-2.0+
+// SPDX-License-Identifier: GPL-2.0+ OR Apache-2.0
 /*
  * Copyright (C) 2018 HUAWEI, Inc.
  *             http://www.huawei.com/
diff --git a/lib/namei.c b/lib/namei.c
index 7377e74..4124170 100644
--- a/lib/namei.c
+++ b/lib/namei.c
@@ -1,4 +1,4 @@
-// SPDX-License-Identifier: GPL-2.0+
+// SPDX-License-Identifier: GPL-2.0+ OR Apache-2.0
 /*
  * Created by Li Guifu <blucerlee@gmail.com>
  */
diff --git a/lib/super.c b/lib/super.c
index 3ccc551..69522bd 100644
--- a/lib/super.c
+++ b/lib/super.c
@@ -1,4 +1,4 @@
-// SPDX-License-Identifier: GPL-2.0+
+// SPDX-License-Identifier: GPL-2.0+ OR Apache-2.0
 /*
  * Created by Li Guifu <blucerlee@gmail.com>
  */
diff --git a/lib/xattr.c b/lib/xattr.c
index 00fb963..02f93f2 100644
--- a/lib/xattr.c
+++ b/lib/xattr.c
@@ -1,4 +1,4 @@
-// SPDX-License-Identifier: GPL-2.0+
+// SPDX-License-Identifier: GPL-2.0+ OR Apache-2.0
 /*
  * Originally contributed by an anonymous person,
  * heavily changed by Li Guifu <blucerlee@gmail.com>
diff --git a/lib/zmap.c b/lib/zmap.c
index 3715c47..09d5d35 100644
--- a/lib/zmap.c
+++ b/lib/zmap.c
@@ -1,4 +1,4 @@
-// SPDX-License-Identifier: GPL-2.0+
+// SPDX-License-Identifier: GPL-2.0+ OR Apache-2.0
 /*
  * (a large amount of code was adapted from Linux kernel. )
  *
-- 
2.25.1

