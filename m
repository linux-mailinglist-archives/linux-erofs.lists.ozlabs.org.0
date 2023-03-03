Return-Path: <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>
X-Original-To: lists+linux-erofs@lfdr.de
Delivered-To: lists+linux-erofs@lfdr.de
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2404:9400:2:0:216:3eff:fee1:b9f1])
	by mail.lfdr.de (Postfix) with ESMTPS id 661086A9123
	for <lists+linux-erofs@lfdr.de>; Fri,  3 Mar 2023 07:38:21 +0100 (CET)
Received: from boromir.ozlabs.org (localhost [IPv6:::1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4PSdZz1YT0z3cdb
	for <lists+linux-erofs@lfdr.de>; Fri,  3 Mar 2023 17:38:19 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=vivo.com header.i=@vivo.com header.a=rsa-sha256 header.s=selector2 header.b=YI3cLtZD;
	dkim-atps=neutral
X-Original-To: linux-erofs@lists.ozlabs.org
Delivered-To: linux-erofs@lists.ozlabs.org
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=vivo.com (client-ip=2a01:111:f400:feab::72e; helo=apc01-sg2-obe.outbound.protection.outlook.com; envelope-from=frank.li@vivo.com; receiver=<UNKNOWN>)
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=vivo.com header.i=@vivo.com header.a=rsa-sha256 header.s=selector2 header.b=YI3cLtZD;
	dkim-atps=neutral
Received: from APC01-SG2-obe.outbound.protection.outlook.com (mail-sgaapc01on2072e.outbound.protection.outlook.com [IPv6:2a01:111:f400:feab::72e])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4PSdZq6c81z3cJK
	for <linux-erofs@lists.ozlabs.org>; Fri,  3 Mar 2023 17:38:09 +1100 (AEDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=lMsp6fXJxlFpQa5M3veK4DvWWKMHDy6K8TmwnL2UX521AUgQgC7qT3D+Km+4fxEzr5XlTwszWFA/ghpkKTUIiX9jpOlK8kuiKtlyuVfwBURH2SH6ERWFhJ5vEqafBuZdaqmJEN1xLTkXk46huXKUw/U8ruYRKlOwwuQvPI/zdRxWKdCnZt8lXdKjW/qtrBLkFFuRqIiqqk5U2AZgYQ/AGiBmkdLCmwMqPEr1fxwjXxCndT7VF9leax1S0korDmMq4w5HRmGvVJbBiV7TbsXI5oWkgnG+vJ47Hl8rCQ6ma6EMwEE64RmL9SNr6WsTVup862wBvHESCFyA+/NEYme3aA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=5HAhkd5J674s6rs/5sdKbDbjP9OJy5jmFp368D+W0so=;
 b=HKyYI9mAydHFv2Hr3uWdQMWXYsJqYAcp3p6wrd3I1zg3uw155DQyaTUcGBgYErl9NxPWviFaML8Xec6+M+9os9aR/xIX0bQgTvzqvgfi9ValcSQ2OoPERH2E52mZl4GHn3auytTaTmYpUNwYVObRB6IE2YVhr/YmrTgH21elDEU6BucbtEWJfbxje0zzuAacG4S0C8pvzHE6nD/iNHIo1eR3GmbGXrB6eTahkDeIyE9CsbvL34VUfP5UG20ntLppku80y9MgXVWLR4erYXLOTRfynq2b+h8uMoqYkQZYZvzV25Fd4fw/NvUNItgwDYkGibxzz5VrVvL9RdLYBOwGhA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=vivo.com; dmarc=pass action=none header.from=vivo.com;
 dkim=pass header.d=vivo.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=vivo.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=5HAhkd5J674s6rs/5sdKbDbjP9OJy5jmFp368D+W0so=;
 b=YI3cLtZDLMTh9B2rdEnTHWBYFwCMbR0JUbTeT4e6BAaRVBhtiPG5tbNvONht/xW17r4/SP/jNp0MyMsWD3LiN18ZrbeMHa4RlCLpHDt1vuaxSoMZle11ht9wyHfSb89Wgv403cQQjlzdwpYUvsyXdOBEt3lUYYv9lWX9TsXe0DEogWj/y92vv4N75wEfXCinl64xdsbOrZsw8KQJ/G0MzLSPvja7GCPXHdXNOHx8CdbKfgmR9oIyicxCeoxpco2oMotYtygNaL1ErF8bCJ/T66suBYkMLLhhZ27zVhKfX4PF3ENVWRVfkehTGzUORJa/T0S45a4a2Q4+SaBfnGR8gQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=vivo.com;
Received: from SEZPR06MB5269.apcprd06.prod.outlook.com (2603:1096:101:78::6)
 by SG2PR06MB5287.apcprd06.prod.outlook.com (2603:1096:4:1df::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6156.10; Fri, 3 Mar
 2023 06:37:44 +0000
Received: from SEZPR06MB5269.apcprd06.prod.outlook.com
 ([fe80::daf6:5ebb:a93f:1869]) by SEZPR06MB5269.apcprd06.prod.outlook.com
 ([fe80::daf6:5ebb:a93f:1869%9]) with mapi id 15.20.6156.016; Fri, 3 Mar 2023
 06:37:44 +0000
From: Yangtao Li <frank.li@vivo.com>
To: xiang@kernel.org,
	chao@kernel.org,
	huyue2@coolpad.com,
	jefflexu@linux.alibaba.com
Subject: [PATCH v2] erofs: mark z_erofs_lzma_init/erofs_pcpubuf_init w/ __init
Date: Fri,  3 Mar 2023 14:37:31 +0800
Message-Id: <20230303063731.66760-1-frank.li@vivo.com>
X-Mailer: git-send-email 2.35.1
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SG2PR02CA0040.apcprd02.prod.outlook.com
 (2603:1096:3:18::28) To SEZPR06MB5269.apcprd06.prod.outlook.com
 (2603:1096:101:78::6)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SEZPR06MB5269:EE_|SG2PR06MB5287:EE_
X-MS-Office365-Filtering-Correlation-Id: 532c0b9b-539f-4f65-0c52-08db1bb1cb6c
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 	ArKsENewWFhQ6hTif0+HDmkukTkw71P6J6axbSE/iEzuUC/A4L8dy97IfP3v4lat/tHCaP68j9o54qPRkZAVa5BtmJ540NOKYim4UsmWGqPP6D/h657GEmTcVTopAzxG7bkCyZAGL/j9OD4A3eghgjszYKhD9QJi5HBNv6Wihuc2sOqZVBsc327/j9/L2EpteGmY988LAxAsJ7Hcx7WHDm/Ac4iffcHNRpFWJY+3lsDH41MbgTRh0+Fa6skec7PbOoDVKcSJ8RuZGGeBhLVtRUoTCqKFzZy3ryGBTUDQdkaD4CwjgbI5AsoWli7sINGWTT3C+BFWcYYYPbPibw4HnTqILLnDiFtAdnbuF4cOGkrn10trRfnN9dYzVg+KfqbbckIh/xSHKZQH2kMYEibFSh23WyCMNR7vVImx4MJspLCg7UBrKTpvLuW9sBf5FhAlQyMAtTGm8YaR247txlT9Ts48TUN0Crn8EepYg/Hbr6N1IT+/AW917lsz5mz1TkhFHqgVnkDtlKEhAooZRoLB2nxxNVocM+Mj5mk7fGZ/Rv6NzuGaFBGeSMmkc6jQiz17HwDrovFk1RXhW+QlxCkWWmISH2BkJdXz7NTnIb4uXMKtINAIrm0IYVBOEIdNCNzgC6AqKHJFPn0qwVY8Yyx3FLx9NbjjsGAJs1uMv0KIRmWoLk6PcbnsMM2p+ITzGJLO3oTi7tzCazVD9kH5d2P//g==
X-Forefront-Antispam-Report: 	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SEZPR06MB5269.apcprd06.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230025)(4636009)(346002)(396003)(39860400002)(376002)(366004)(136003)(451199018)(5660300002)(316002)(8936002)(8676002)(41300700001)(4326008)(66556008)(83380400001)(66476007)(66946007)(2906002)(6486002)(6512007)(52116002)(36756003)(38350700002)(478600001)(38100700002)(6666004)(2616005)(186003)(1076003)(6506007)(86362001)(107886003)(26005);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 	=?us-ascii?Q?PvVloSonKDqdzYO+neYwgczSaKP0U+iMtMF7xqBgGsR9jMWTiDQTSeDzqKji?=
 =?us-ascii?Q?kVHJCSbn7/xyv4aqkOP288i5qoKlZyJPLIDQ6seMi+U1o0LDuVA2uoQDfYTA?=
 =?us-ascii?Q?xHvdCPd6eokFqoMWz/LMoy4/qKt6BhF8M6+JyXZ6/9KLtLQnFI20XPeVNjbd?=
 =?us-ascii?Q?/nWuxrMRq3rggbEUIcvngWzYmwBOICUJogEBG8+U2lzvdNPvCTaTgmfAWQmf?=
 =?us-ascii?Q?SEy/JfTXAoy7MESgyWTKAOhoPGuPdDpjXHFdt4weMKyNOaNhNiYyNd23IhrM?=
 =?us-ascii?Q?ADKSgxNB6XmVu8G3JLXsvBm/7umeoG1cCoTIGtnes7DIt7omjoKdffcjXndx?=
 =?us-ascii?Q?580FDtmhuRuxD+DlGImZsDbfwkZztnKik9r12cY56P57n/Sw75bzHbyJ14Da?=
 =?us-ascii?Q?Gkif/W8gC71RCONDdivtZ5b43cQDFcmlcgMuDzTzrrtTrHmb4/MRmGU2gnP3?=
 =?us-ascii?Q?mcUAluM3Gm4nJSyT8e7UUTEI/uRrIMtsMj3ZGJnR1oNVRlLaCOTRc9YY/3M1?=
 =?us-ascii?Q?Jr9TPR1fmZm2J1hcpvhi/Ch+AXwXhsfQDYO6qXwT5j20/5tGnTe8p81tS3sP?=
 =?us-ascii?Q?um2UAq2RE4wvjQcpzIxXJYEgu/nxiIhiJZe15B04/E+XIP37G5qnskoWsBsT?=
 =?us-ascii?Q?obak9FA6ZPJRD03bpfUN9vCILyGdaQMJWyKfH0U5PzwiVyvLfzGchrhkpO3I?=
 =?us-ascii?Q?/zng0GOzyBAOb0Gc+zHaoYGUQiie2VpcmqNLUMKPAsrlRYZQLIwQa+m1IaqC?=
 =?us-ascii?Q?/FNfLc8Q7cLg6HTUE2ShuSm1p2abY5rLGibT/34L8aQ6kA/lg3jaSiVbOi/Y?=
 =?us-ascii?Q?zOoZvYuUtihMkJBU3oZaDDrH8xjkSy7W+dIZqCbfidg7e81k30uDMrza5nl6?=
 =?us-ascii?Q?KM0lDt+syISyhNleVSoDZluP/bYPXXqukq+1QDrSshPd2zc5379NdKFwwZmy?=
 =?us-ascii?Q?8YIhQZqrTx9/rVQLS0g1fRdU9QkHlt9uP4r7XaKUFTVNGIaDI/N4GmfooFPv?=
 =?us-ascii?Q?HX3FcpEzU4iFmLeyz6oLVPQO2bocTkj6cm3I6lLdV0EkNMBvL2e2VPgG1s9p?=
 =?us-ascii?Q?n9Nv1MrYCNqUjfeSrkilG2bQMU5kLtVVVT9xAmG7jJxwl8sy2Y8/UNSDFGJP?=
 =?us-ascii?Q?eM/r8/VDvqwTdVNnusd/VvSQBAWmtdQXJFOgaMyTXf2pyCf0HZpgShbUsx67?=
 =?us-ascii?Q?UB5p5BWfyR2KkJdRRC7iY7o25DGpg3zwyGLxVuq1kWJGJAVrh4Gx2UsC2Dy1?=
 =?us-ascii?Q?TPAxdngGDXBNIzv9JsVFpBxDyHKDerr2CKdWD9vYd7nafH/xfW+EHpWybZ3r?=
 =?us-ascii?Q?rBy+BoSyPu5zdGN0Vul5nnD9soIPjHuSXyQB8UFqdgYjOAy/8wJuENASWN49?=
 =?us-ascii?Q?5+M4Vz5V47bkx/CCgOx7CjqvlJL9Fqw5ZNiissNEujg0tyYuSmG/ketvKBwS?=
 =?us-ascii?Q?jHOvQN81HgKrnKAZzWhxNulbG9EFb2Q7q+IU//XP+GRW3CHPkXtnJgRYV2Jv?=
 =?us-ascii?Q?av8+J9JDJNQ3aRys0WwldXbNJAlPy7U8+JULp9cekGE9Bvo392MWZesM9YUO?=
 =?us-ascii?Q?v10F/j7siwDLmq0siwV1SlIeOeBdTfOc/09aWuGt?=
X-OriginatorOrg: vivo.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 532c0b9b-539f-4f65-0c52-08db1bb1cb6c
X-MS-Exchange-CrossTenant-AuthSource: SEZPR06MB5269.apcprd06.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 03 Mar 2023 06:37:44.0636
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 923e42dc-48d5-4cbe-b582-1a797a6412ed
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: zuFX7oht3ROc+yssyfhGcsVZpxYDh7mMKem3uPcGN8UiB7gMBK08tmilu2uYx5dkQbzXqzFUkUa/4xQmOf1Paw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SG2PR06MB5287
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

They are used during the erofs module init phase. Let's mark it as
__init like any other function.

Signed-off-by: Yangtao Li <frank.li@vivo.com>
---
v2:
-change in internal.h
 fs/erofs/decompressor_lzma.c | 2 +-
 fs/erofs/internal.h          | 4 ++--
 fs/erofs/pcpubuf.c           | 2 +-
 3 files changed, 4 insertions(+), 4 deletions(-)

diff --git a/fs/erofs/decompressor_lzma.c b/fs/erofs/decompressor_lzma.c
index 091fd5adf818..307b37f0b9f5 100644
--- a/fs/erofs/decompressor_lzma.c
+++ b/fs/erofs/decompressor_lzma.c
@@ -47,7 +47,7 @@ void z_erofs_lzma_exit(void)
 	}
 }
 
-int z_erofs_lzma_init(void)
+int __init z_erofs_lzma_init(void)
 {
 	unsigned int i;
 
diff --git a/fs/erofs/internal.h b/fs/erofs/internal.h
index 3f3561d37d1b..1db018f8c2e8 100644
--- a/fs/erofs/internal.h
+++ b/fs/erofs/internal.h
@@ -486,7 +486,7 @@ static inline void *erofs_vm_map_ram(struct page **pages, unsigned int count)
 void *erofs_get_pcpubuf(unsigned int requiredpages);
 void erofs_put_pcpubuf(void *ptr);
 int erofs_pcpubuf_growsize(unsigned int nrpages);
-void erofs_pcpubuf_init(void);
+void __init erofs_pcpubuf_init(void);
 void erofs_pcpubuf_exit(void);
 
 int erofs_register_sysfs(struct super_block *sb);
@@ -545,7 +545,7 @@ static inline int z_erofs_fill_inode(struct inode *inode) { return -EOPNOTSUPP;
 #endif	/* !CONFIG_EROFS_FS_ZIP */
 
 #ifdef CONFIG_EROFS_FS_ZIP_LZMA
-int z_erofs_lzma_init(void);
+int __init z_erofs_lzma_init(void);
 void z_erofs_lzma_exit(void);
 int z_erofs_load_lzma_config(struct super_block *sb,
 			     struct erofs_super_block *dsb,
diff --git a/fs/erofs/pcpubuf.c b/fs/erofs/pcpubuf.c
index a2efd833d1b6..c7a4b1d77069 100644
--- a/fs/erofs/pcpubuf.c
+++ b/fs/erofs/pcpubuf.c
@@ -114,7 +114,7 @@ int erofs_pcpubuf_growsize(unsigned int nrpages)
 	return ret;
 }
 
-void erofs_pcpubuf_init(void)
+void __init erofs_pcpubuf_init(void)
 {
 	int cpu;
 
-- 
2.25.1

