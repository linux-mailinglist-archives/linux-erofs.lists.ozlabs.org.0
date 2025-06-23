Return-Path: <linux-erofs+bounces-485-lists+linux-erofs=lfdr.de@lists.ozlabs.org>
X-Original-To: lists+linux-erofs@lfdr.de
Delivered-To: lists+linux-erofs@lfdr.de
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	by mail.lfdr.de (Postfix) with ESMTPS id 72D67AE3B33
	for <lists+linux-erofs@lfdr.de>; Mon, 23 Jun 2025 11:53:24 +0200 (CEST)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4bQk0y1YzSz2xHW;
	Mon, 23 Jun 2025 19:53:22 +1000 (AEST)
X-Original-To: linux-erofs@lists.ozlabs.org
Authentication-Results: lists.ozlabs.org; arc=pass smtp.remote-ip="2a01:111:f403:2407::61c" arc.chain=microsoft.com
ARC-Seal: i=2; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1750672402;
	cv=pass; b=WRkVwoAl+k77hvuQ0CEXX3YH72vCYM4jWAuraISe2cr4kUsq+eEEb0VZIsQuiuikHttm6ncPu2cgk5pOR8q5WC6ar0IjiBLdLUdjRTAZ37Kl4iVr9wf4ezOQ8a30X1wb6kCCWL+fRtLowo/twgh3ouE3yF+OT3wD/NYs0b27gfMmIwOt1SAeHRVjR99hMv+e6wfZMrejCYLcsF7KnK76FRi3MiIHaVoKt2vZt6Gy3zrON4FzZUD1vw5HEpWjskYrNKChchvVJLrXE8B3Xb1ZijDGQAqKVUk2qwrXB0WmOuOTos4/yzmp3vV59I11SWfa7Y2psGyScWS0ojGoH5OgNA==
ARC-Message-Signature: i=2; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1750672402; c=relaxed/relaxed;
	bh=cANi4d8otGA2QoVHiP3RKSYcGq7o07Z4eDJYTR8a3L4=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=l5FRBlKhMYXHLJpXzoNpsn3eo2vyYugg06zWCen0cQoJa1q1vF1uaWBUxTcg0nr3hSUb4eqnaqceVpLy13Sp8/hMeXkY4KR1hr3ei/IQ9XdjKtXt1zzH93iVPalH4VEsOgTNxSmfoqqX6QZsPLErbEFwCCit0Vvd53zBc8bEKqPJeHfF2EpAF5ApnV4u210lvODaj2G65I3Egu67lCa32sKtca/EvI3MTErN1Fsx+44sbziNdDPQfsR19hk8sPsg1YUGsRfCxVrWv0IRdmGuXykknDwE4saDWbrNg+Shn+/CP7ch/FLMVQhsY67/DGxAzDzIRKO+DAguVqsXWbuEVA==
ARC-Authentication-Results: i=2; lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.a=rsa-sha256 header.s=selector1 header.b=ZnOa5aRJ; dkim-atps=neutral; spf=pass (client-ip=2a01:111:f403:2407::61c; helo=nam02-bn1-obe.outbound.protection.outlook.com; envelope-from=shivankg@amd.com; receiver=lists.ozlabs.org) smtp.mailfrom=amd.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.a=rsa-sha256 header.s=selector1 header.b=ZnOa5aRJ;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=amd.com (client-ip=2a01:111:f403:2407::61c; helo=nam02-bn1-obe.outbound.protection.outlook.com; envelope-from=shivankg@amd.com; receiver=lists.ozlabs.org)
Received: from NAM02-BN1-obe.outbound.protection.outlook.com (mail-bn1nam02on2061c.outbound.protection.outlook.com [IPv6:2a01:111:f403:2407::61c])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4bQk0x0926z2xHT
	for <linux-erofs@lists.ozlabs.org>; Mon, 23 Jun 2025 19:53:20 +1000 (AEST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=TjWxbOpmk3Qb6NfX3/l9ttTC52JybFe7v4xjSYxMTmOkbwFACuYCG4qqPFppeGTTIV0WhnznwR+n6L0IZHyqEzz/W2wHwP/7WA55sJgJKKvr6TOZlCaMF0bPsDVfmjh38mbYITkGgI7An718ZSMgS12PUFKNH7dTgmVdHwWoCbQNo7p0i/aQhoAPnKegT85MPKr9x9+y7zEXfBW1awwPOzivAFEcr5TdCXj3OxKZUEcPp/EdeIR2jRS5uRuYMCGFqyleVNuGqPvjHSTfhjf/GxScQCII8JO9nt9cnfjwtfwwJHl2omutky6UQWCs/RF2c8rt8hDFgG9DZ53wsRmFBw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=cANi4d8otGA2QoVHiP3RKSYcGq7o07Z4eDJYTR8a3L4=;
 b=O9WUYhIQjNb4Au8xpERHEqhp6xBx1a291wEPCjQrsxo6s2Z/SRzjxEbPUkKJIF9LAABMo3OcQk6UvBl5qhZZ6jbD61vUHbijcyF2+YuLrsDl3T8DhPAVyUiB2xxSanZax2nfgjvoD9dbG4meu9fwblUFCnQTQVVE5YXmz86I+000E/Ukv0PfZpvbXXutpFERJvnboP6O/yTmgQXK0bP/+h6+IgPCIgsx3c6N7rJuiM72BpaeKdxFTN+YmAl73DvNj2njDZFrXB9blDt/treUK+OwCmx6nywLh0vpG9Zl40dLaKI6ZZc3xGP4EXSQb8AfRpDGqZgwrxxNetGEa/bjFw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=linux.dev smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=cANi4d8otGA2QoVHiP3RKSYcGq7o07Z4eDJYTR8a3L4=;
 b=ZnOa5aRJ4gYYmNM5MJkU3tgjLg1pnJKcT2Ujvlf+jeoFjcSm7CTBuF2g32mHB39js/kegb3ksAYG66jWTFjBg1Ittl5wNtbW143tnIMTT41nL62mL7XeGA9aQSkpnWCQjYRR7aPtCXgv5PKU9e7TKvze4Sm3zw6M4s8jf4LvnC0=
Received: from DM6PR06CA0094.namprd06.prod.outlook.com (2603:10b6:5:336::27)
 by CH3PR12MB9729.namprd12.prod.outlook.com (2603:10b6:610:253::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8857.21; Mon, 23 Jun
 2025 09:52:59 +0000
Received: from DS1PEPF00017093.namprd03.prod.outlook.com
 (2603:10b6:5:336:cafe::40) by DM6PR06CA0094.outlook.office365.com
 (2603:10b6:5:336::27) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8857.30 via Frontend Transport; Mon,
 23 Jun 2025 09:52:59 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 DS1PEPF00017093.mail.protection.outlook.com (10.167.17.136) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.8880.14 via Frontend Transport; Mon, 23 Jun 2025 09:52:58 +0000
Received: from kaveri.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Mon, 23 Jun
 2025 04:52:51 -0500
From: Shivank Garg <shivankg@amd.com>
To: <kent.overstreet@linux.dev>, <clm@fb.com>, <josef@toxicpanda.com>,
	<dsterba@suse.com>, <xiang@kernel.org>, <chao@kernel.org>,
	<jaegeuk@kernel.org>, <willy@infradead.org>, <akpm@linux-foundation.org>,
	<david@redhat.com>, <vbabka@suse.cz>
CC: <zbestahu@gmail.com>, <jefflexu@linux.alibaba.com>, <dhavale@google.com>,
	<lihongbo22@huawei.com>, <pankaj.gupta@amd.com>,
	<linux-bcachefs@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
	<linux-btrfs@vger.kernel.org>, <linux-erofs@lists.ozlabs.org>,
	<linux-f2fs-devel@lists.sourceforge.net>, <linux-fsdevel@vger.kernel.org>,
	<linux-mm@kvack.org>, <kvm@vger.kernel.org>, <linux-coco@lists.linux.dev>,
	Shivank Garg <shivankg@amd.com>
Subject: [PATCH V2 2/2] mm/filemap: Extend __filemap_get_folio() to support NUMA memory policies
Date: Mon, 23 Jun 2025 09:39:43 +0000
Message-ID: <20250623093939.1323623-6-shivankg@amd.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250623093939.1323623-4-shivankg@amd.com>
References: <20250623093939.1323623-4-shivankg@amd.com>
X-Mailing-List: linux-erofs@lists.ozlabs.org
List-Id: <linux-erofs.lists.ozlabs.org>
List-Help: <mailto:linux-erofs+help@lists.ozlabs.org>
List-Owner: <mailto:linux-erofs+owner@lists.ozlabs.org>
List-Post: <mailto:linux-erofs@lists.ozlabs.org>
List-Subscribe: <mailto:linux-erofs+subscribe@lists.ozlabs.org>,
  <mailto:linux-erofs+subscribe-digest@lists.ozlabs.org>,
  <mailto:linux-erofs+subscribe-nomail@lists.ozlabs.org>
List-Unsubscribe: <mailto:linux-erofs+unsubscribe@lists.ozlabs.org>
Precedence: list
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB04.amd.com (10.181.40.145) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS1PEPF00017093:EE_|CH3PR12MB9729:EE_
X-MS-Office365-Filtering-Correlation-Id: e41f6f37-eadd-4cf8-4f16-08ddb23bbc56
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|82310400026|36860700013|376014|7416014|1800799024|13003099007|921020;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?9X2eb1n+Trxc/DStueVMd8NGuzinR4+cqkSqSqn1maEneJ3YLzMlbff7t6HF?=
 =?us-ascii?Q?jFpibs4jHVqjIPx1v3HoPAjSEnLlHDZor9WEbAIKsnsthHUFho7CtTs1z9I3?=
 =?us-ascii?Q?e+g1qGGsj8ItRVLkNl+fevUU26XgfUY311TzV18W6KW7Xmj9kMrxuOE8lD/I?=
 =?us-ascii?Q?Mf/JUn4xHE0VpDT+j0b+vBg3BfG3Xc4ElFPACoctlhIdNRxWHEpZIbZvaAcy?=
 =?us-ascii?Q?/gxsCiS0O4CB6QobaY4hHvxtZY2onAepym24vyf3UCZKteUq2NFzEq2kSS8+?=
 =?us-ascii?Q?9jKCcuTodnQQs8+IHJojU7CRUjSD7hbkOwwJPkMR/qs5NA5/32Do1atL6slQ?=
 =?us-ascii?Q?E8AmJTII1zC9in1MeF7p5zY0RgeYp0tsefWtb4lvhvNQDSjvrhB+p0958YQ9?=
 =?us-ascii?Q?R2VVn+XNLInmaVGuPdeA73qQEvQes6K2ELUAWE9AcgBQlGxWHKXcB1c+qmvA?=
 =?us-ascii?Q?3m5v14DhIEC3P20b1kVGAVB9wYwp7QyZuogAaTXUQJf9Tdhxi9Ym8ruUPoDt?=
 =?us-ascii?Q?IdCiGROzQiI3ytmcRSNeo1ti4VkSKJm8uyWxtvpMp9HCYLMRc/Qpfej4RCtb?=
 =?us-ascii?Q?SUfZTsc2zzG7DJmYit5J9ImAcEz1OBBvDR5F6TkYCazbZLj4id1xfgkKjE6n?=
 =?us-ascii?Q?asw2Toq85D6K876cfxMWFPjMDrVhfnEPn8Yl4eUQ52m+/OLumswrsoolrGtu?=
 =?us-ascii?Q?78EjRZZ/4l17YlQYoo2KZZulGwJXn0q+UaxLRGsLl599ys3l5WKujtN1XUQ1?=
 =?us-ascii?Q?TYLttKTiowLHRh6F+J4MuRBQ02FPASXzP3iEjQ84VAqVKD93bNNxcFSvpkhp?=
 =?us-ascii?Q?SxdOCDX1kOsp7Gs+n+T0SB9zc4RtTpWqHru7Pa0xMUpZgdJoo+K9ldcavwzj?=
 =?us-ascii?Q?51H7ACqghb3XYlB5+vZmww+l6DJJ0DPNJHsQSsSMy6hzYGErc4dXvpnxtokA?=
 =?us-ascii?Q?iYYk/Sv22f215oyUM5RecNhqiIcXVblTf4jhfnazP7UmcI6Z7O0kpoHc3D3i?=
 =?us-ascii?Q?sFSTH2TeTzGyMc7AE+FexGQ53f5CbYSDLq2yAbniNwztTjC7zVkTfXcLxMNF?=
 =?us-ascii?Q?5HmLjZfubqY6gPS03uAo7djZQRscTaMtxjuggECLh1wHc+FsP2Iwmb57n+E+?=
 =?us-ascii?Q?2pKAlhNG35Usk1MU4zshrCFBW8L84V30oqCjQeDz5a8UirYVgWRc6oQi7M77?=
 =?us-ascii?Q?vJJsnq3QPGSiP4doEM7UNohutzGm4XAyDEQU2konTyyJbyi1LRVRHyZcr6b4?=
 =?us-ascii?Q?Lqysfdx42ZvOXdBskkkjyANkmbCmUd2H6vcRaXG0WT4FF4ExtXfs68Ym3A7N?=
 =?us-ascii?Q?kK28O0SFqwoqDYIpQ8qDu7Je6rnbra8lpvRkkFcXST/CKJLOEb3MOTv3RVmZ?=
 =?us-ascii?Q?P93OqBp5SiSeAOaWDa6nhs36L+CwM0x9CASVzGhsJSegq1h09lsBH378bPED?=
 =?us-ascii?Q?PrJVk+xF3Oo7foAYQFdOWK9hKz0wWDHq9bnnOLUlHBauumxqW2Dg/C79ofnH?=
 =?us-ascii?Q?ZaRWTx6LviiXElL7fVH4h8U4sHmcfXcLnm0GtZdmUX6UolGHVoycgmkmIw?=
 =?us-ascii?Q?=3D=3D?=
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(82310400026)(36860700013)(376014)(7416014)(1800799024)(13003099007)(921020);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 23 Jun 2025 09:52:58.8300
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: e41f6f37-eadd-4cf8-4f16-08ddb23bbc56
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	DS1PEPF00017093.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH3PR12MB9729
X-Spam-Status: No, score=-3.1 required=3.0 tests=ARC_SIGNED,ARC_VALID,
	DKIMWL_WL_HIGH,DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
	SPF_HELO_PASS,SPF_PASS autolearn=disabled version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-25) on lists.ozlabs.org

From: "Matthew Wilcox (Oracle)" <willy@infradead.org>

Extend __filemap_get_folio() to support NUMA memory policies by
renaming the implementation to __filemap_get_folio_mpol() and adding
a mempolicy parameter. The original function becomes a static inline
wrapper that passes NULL for the mempolicy.

This infrastructure will enable future support for NUMA-aware page cache
allocations in guest_memfd memory backend KVM guests.

Reviewed-by: Pankaj Gupta <pankaj.gupta@amd.com>
Reviewed-by: Vlastimil Babka <vbabka@suse.cz>
Signed-off-by: Matthew Wilcox (Oracle) <willy@infradead.org>
Signed-off-by: Shivank Garg <shivankg@amd.com>
---
Changes in V2:
- fix checkpatch warnings.
- touch up commit description and fix code alignments to make it
  more readable.
V1:
https://lore.kernel.org/all/20250620143502.3055777-2-willy@infradead.org

 include/linux/pagemap.h | 10 ++++++++--
 mm/filemap.c            | 11 ++++++-----
 2 files changed, 14 insertions(+), 7 deletions(-)

diff --git a/include/linux/pagemap.h b/include/linux/pagemap.h
index 78ea357d2077..981ff97b4445 100644
--- a/include/linux/pagemap.h
+++ b/include/linux/pagemap.h
@@ -747,11 +747,17 @@ static inline fgf_t fgf_set_order(size_t size)
 }
 
 void *filemap_get_entry(struct address_space *mapping, pgoff_t index);
-struct folio *__filemap_get_folio(struct address_space *mapping, pgoff_t index,
-		fgf_t fgp_flags, gfp_t gfp);
+struct folio *__filemap_get_folio_mpol(struct address_space *mapping,
+		pgoff_t index, fgf_t fgf_flags, gfp_t gfp, struct mempolicy *policy);
 struct page *pagecache_get_page(struct address_space *mapping, pgoff_t index,
 		fgf_t fgp_flags, gfp_t gfp);
 
+static inline struct folio *__filemap_get_folio(struct address_space *mapping,
+		pgoff_t index, fgf_t fgf_flags, gfp_t gfp)
+{
+	return __filemap_get_folio_mpol(mapping, index, fgf_flags, gfp, NULL);
+}
+
 /**
  * filemap_get_folio - Find and get a folio.
  * @mapping: The address_space to search.
diff --git a/mm/filemap.c b/mm/filemap.c
index a30cd4dd085a..ec7de38c17c1 100644
--- a/mm/filemap.c
+++ b/mm/filemap.c
@@ -1896,11 +1896,12 @@ void *filemap_get_entry(struct address_space *mapping, pgoff_t index)
 }
 
 /**
- * __filemap_get_folio - Find and get a reference to a folio.
+ * __filemap_get_folio_mpol - Find and get a reference to a folio.
  * @mapping: The address_space to search.
  * @index: The page index.
  * @fgp_flags: %FGP flags modify how the folio is returned.
  * @gfp: Memory allocation flags to use if %FGP_CREAT is specified.
+ * @policy: NUMA memory allocation policy to follow.
  *
  * Looks up the page cache entry at @mapping & @index.
  *
@@ -1911,8 +1912,8 @@ void *filemap_get_entry(struct address_space *mapping, pgoff_t index)
  *
  * Return: The found folio or an ERR_PTR() otherwise.
  */
-struct folio *__filemap_get_folio(struct address_space *mapping, pgoff_t index,
-		fgf_t fgp_flags, gfp_t gfp)
+struct folio *__filemap_get_folio_mpol(struct address_space *mapping,
+		pgoff_t index, fgf_t fgp_flags, gfp_t gfp, struct mempolicy *policy)
 {
 	struct folio *folio;
 
@@ -1982,7 +1983,7 @@ struct folio *__filemap_get_folio(struct address_space *mapping, pgoff_t index,
 			err = -ENOMEM;
 			if (order > min_order)
 				alloc_gfp |= __GFP_NORETRY | __GFP_NOWARN;
-			folio = filemap_alloc_folio(alloc_gfp, order, NULL);
+			folio = filemap_alloc_folio(alloc_gfp, order, policy);
 			if (!folio)
 				continue;
 
@@ -2029,7 +2030,7 @@ struct folio *__filemap_get_folio(struct address_space *mapping, pgoff_t index,
 		folio_clear_dropbehind(folio);
 	return folio;
 }
-EXPORT_SYMBOL(__filemap_get_folio);
+EXPORT_SYMBOL(__filemap_get_folio_mpol);
 
 static inline struct folio *find_get_entry(struct xa_state *xas, pgoff_t max,
 		xa_mark_t mark)
-- 
2.43.0


