Return-Path: <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>
X-Original-To: lists+linux-erofs@lfdr.de
Delivered-To: lists+linux-erofs@lfdr.de
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2404:9400:2:0:216:3eff:fee1:b9f1])
	by mail.lfdr.de (Postfix) with ESMTPS id CD57A40838C
	for <lists+linux-erofs@lfdr.de>; Mon, 13 Sep 2021 06:28:09 +0200 (CEST)
Received: from boromir.ozlabs.org (localhost [IPv6:::1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4H7D474gXgz2yKW
	for <lists+linux-erofs@lfdr.de>; Mon, 13 Sep 2021 14:28:07 +1000 (AEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=lists.ozlabs.org;
	s=201707; t=1631507287;
	bh=fQPCe/CKoiXmlyRaqRAdCDBiK/pjFyp2T266LoGTNtg=;
	h=To:Subject:Date:List-Id:List-Unsubscribe:List-Archive:List-Post:
	 List-Help:List-Subscribe:From:Reply-To:Cc:From;
	b=Kcv4Osg3i0g5Hmdd4L1lo0VPgrqL68f2Y/oQCbp3TgvmBOLAzDt6xlIdgo6Ha+WWo
	 CdLteRx1sW1SjqA0OwXmbau6WEGDoC9kb2POr0IG08m0Y3ubxeGIS9zT3ELRl2vNlQ
	 HIJQNImdfvXXZ91kLoYRrGt6658ILfBLXdmon4BtmxNQUGTrGRgktybRSfjjF0WKma
	 cBFKHygfuELuSlFifX2WqtYk7+9gTvO/1DMrvNybNNmYv7C63kOvlcFH/lcC6y2nma
	 fTeUwTNUXBC8DOvoS8SX4wEEWLFeTt5HXHOkvT0lpbKww2UVaPEAv4Ri8MK12q7ulA
	 Sek3aP3MVWUVg==
X-Original-To: linux-erofs@lists.ozlabs.org
Delivered-To: linux-erofs@lists.ozlabs.org
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized)
 smtp.mailfrom=oppo.com (client-ip=40.107.131.74;
 helo=apc01-sg2-obe.outbound.protection.outlook.com;
 envelope-from=huangjianan@oppo.com; receiver=<UNKNOWN>)
Authentication-Results: lists.ozlabs.org; dkim=pass (1024-bit key;
 unprotected) header.d=oppo.com header.i=@oppo.com header.a=rsa-sha256
 header.s=selector1 header.b=EXTdTk9+; 
 dkim-atps=neutral
Received: from APC01-SG2-obe.outbound.protection.outlook.com
 (mail-eopbgr1310074.outbound.protection.outlook.com [40.107.131.74])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 4H7D3w6Rjkz2y0B
 for <linux-erofs@lists.ozlabs.org>; Mon, 13 Sep 2021 14:27:51 +1000 (AEST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=JSLtn6CBeBNxRgzMCb12RGg/5swxv5oPurl1bDPfr3QeAGtIVFV9c4zZuhQfX6hszJNlyaAdTC/rQT3IZLYgQhhPECwLkFmK1YVKJFUVefs7/cO+RE5JrqE0s22Z1VRCTyHX0mEeXLH7b7FJghz1vFV++1ULtluyp5HXZLpJqMfEThon4oAnzn8LfAYS/6oDwpCu3mlgS125Z4uE28j2HMpTXjflwCLXL706bL2jbEAtAQNn1yMce5WbIgqICLWWZN1pQVpZJV759c6H5/TiFKKHRfSQbmV8jblACNSeeQLK+GlmC/uZYu5gn9jgzcZ510a8Byl1fvJE47Ec7qnjbQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version; 
 bh=fQPCe/CKoiXmlyRaqRAdCDBiK/pjFyp2T266LoGTNtg=;
 b=hiPEWQGOwqvjAjHWYrV9D9sIB3ITj+QL2WTwkzqRO2OQA850wrSaebvOOAyznVPAAbdO59xdaM+QWF98v3ai54GKWEGex5+QRtZw5qTkV2Dxg8embBfCy7GipIJgS4r2rGWHiTQuHXm3cMc0k0s6kxq/qUo1c6nVDYQ0az4iCBuDoC+nOIy/qHGRICBQSYwG4BIna83+9yU9JxViw7hmWOomprFzisblgpogpkdxxrKpi1zYHft5UAeGl/jXnFcnoraAx+y87+mQTPWa1hw3cbHTklUbfxfRfF1PtcKo+b84lIJYfE6ixHM2ViMkzu4o0Cl9EqnTK1C14UxTuNI2pg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oppo.com; dmarc=pass action=none header.from=oppo.com;
 dkim=pass header.d=oppo.com; arc=none
Authentication-Results: lists.ozlabs.org; dkim=none (message not signed)
 header.d=none;lists.ozlabs.org; dmarc=none action=none header.from=oppo.com;
Received: from SG2PR02MB4108.apcprd02.prod.outlook.com (2603:1096:4:96::19) by
 SG2PR02MB3372.apcprd02.prod.outlook.com (2603:1096:4:48::14) with
 Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.4500.18; Mon, 13 Sep 2021 04:27:25 +0000
Received: from SG2PR02MB4108.apcprd02.prod.outlook.com
 ([fe80::5919:768f:2950:9504]) by SG2PR02MB4108.apcprd02.prod.outlook.com
 ([fe80::5919:768f:2950:9504%4]) with mapi id 15.20.4500.018; Mon, 13 Sep 2021
 04:27:25 +0000
To: linux-erofs@lists.ozlabs.org
Subject: [PATCH] erofs-utils: add support for the full decompressed length
Date: Mon, 13 Sep 2021 12:27:16 +0800
Message-Id: <20210913042716.17529-1-huangjianan@oppo.com>
X-Mailer: git-send-email 2.25.1
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: HK2PR02CA0192.apcprd02.prod.outlook.com
 (2603:1096:201:21::28) To SG2PR02MB4108.apcprd02.prod.outlook.com
 (2603:1096:4:96::19)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from PC80253450.adc.com (58.252.5.73) by
 HK2PR02CA0192.apcprd02.prod.outlook.com (2603:1096:201:21::28) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.4500.14 via Frontend Transport; Mon, 13 Sep 2021 04:27:23 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 334d20c5-75e6-408f-906a-08d9766ec92e
X-MS-TrafficTypeDiagnostic: SG2PR02MB3372:
X-MS-Exchange-SharedMailbox-RoutingAgent-Processed: True
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <SG2PR02MB337234F5313F70F704DAE8ACC3D99@SG2PR02MB3372.apcprd02.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:3276;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: VAjCCOhKXu1QDvh0Bb6mlyfWCj+v/fZVMbqJ+ISnKcqSjZAu+341U8MJzXoo6LEhDFw5DKSYScgZtebVwrZlp1utzfev2vLFYtKRFmVBiHNrWpQ9gAlXPDKtu0rlN9GKzrVFjWOhZHtekigaetKpMmd2wPUfY0qy/s7/RSzs90/o37kd//5e0fsgMuWQRjdgG1fdVD1vsOG0q7z3npuINllnXybRZ/8EuWSsAzLhadFIjMUoTo719Owyk+GYteXI1F7CaXCM5vJqg0sZxKN/kWiuvPeyDtFyG/k2Fp5R6Q8jH41q49WmvEetOkac0FqG6F7YcGj38bkSfmLef7c1cbHNBzFutkh71yetYRuIv+LYqDLqc1oVZLv0B4Lms6D8JMNKgpwOSF+uPMiy7asOkHKkjw3bu1MRLH9VneKpP7T5cR2e2rdNclmsUjexhlpT5sHuTyP08ePPs4fEFwIJ5IySnBYLLgMza8h3jsOOQYxz7ZRbFD2aAeEKQAcr/XA0xVy93VrpKGzjvKOB5nGHG3vM7jwm3lxyl0AyjFdybbw5uJbUXIVWWDcZuckv/OpJDq7ZytKv4LhaIZ5orvFEYX40KI6wiz2uDeXhIKfjlehKh/Tx1OH4xbuyckqaWxykCAtM7H+TqTgJBb4MxfPJvw8sua98+evSO83829CzZd5lpW70642FiS6yt/4v3NoBLodtI2SvWhRZanX16lZAtZ4qgu7I9fDhp96SGZKvpaQ=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:SG2PR02MB4108.apcprd02.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(4636009)(376002)(366004)(396003)(39860400002)(346002)(136003)(4326008)(6512007)(36756003)(6666004)(8676002)(66946007)(2616005)(956004)(38350700002)(86362001)(316002)(5660300002)(478600001)(83380400001)(26005)(107886003)(186003)(6916009)(38100700002)(8936002)(52116002)(6486002)(66556008)(66476007)(1076003)(2906002)(6506007)(11606007);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?dPR+sFlN/7yB6Vw1pnu60tariHS3Tvenpd/bCyGE89sAiTPes734shXJJ9nO?=
 =?us-ascii?Q?2NbG4wAFSRllqtkNR/ZwxNANSxJOlXN6YcEYNjLvtYfNymR62JoxxXlGeZJH?=
 =?us-ascii?Q?IgwgGosEUtXpLpi4bCOWXg/SiEERt5zIRG5JDfFg2QtW4gK/XLxb59RI4PJU?=
 =?us-ascii?Q?NCtzveSo0Cc3sDRe9WKhpq02BYHP9lF8r87jEKLOY+HheyWTmSskJo7AsZP/?=
 =?us-ascii?Q?D8Xi/U0F9rClqJVysru3vzDrgNZs9ehLNZJKQHEOhBsMLd0XlH1WPwE/0x+4?=
 =?us-ascii?Q?CFt0GtQ0/MIyaIlYWdsxwgIh6Zx8WO6GuBS2vO7Hs/Ai+nNaoDeoBWPGjySz?=
 =?us-ascii?Q?Q+U7rOrJBXjefGgBWtNHUbXoEzzP9ywNJZr753w+6zV3CDU1jGlPbHfmzJ2i?=
 =?us-ascii?Q?h5Awz7bNRmbom/rTlDnCDhqAjuxl1a37NnoGd9YRIhmVGQ8J3kCZ1OsSMh3F?=
 =?us-ascii?Q?yLY1GtImZjsafXRXZNs4iA7HKbabzswye2z4g/7j3Boe8O8gvdejsPo9/iA3?=
 =?us-ascii?Q?ZFKtlr5xG0fIw4+DG842Uz/rXKjhfExahsqI36qAov0yIhCpr56dyHctqeNy?=
 =?us-ascii?Q?rYgaE49ZpjH5ZPzilPFF0Ta4OMEE1I8HjTp2Ca2unj8sQ0V2No+qpXZKcO3R?=
 =?us-ascii?Q?6ms4D+YHzb1/+9qEXBiR/1+SSxD3uCYSfr7osQGmpqiOnfPI7wzxrzWJU/hk?=
 =?us-ascii?Q?9OGFqhLSjYjBQ/y9wo7RDbBYmllEs1wogIxStC3hBQrjAesGzQC4RnFZ7vlT?=
 =?us-ascii?Q?QEzsoW94oIYF99ehkqiF28JJPHHCq+PHSNLS1WrWlfTFO21l9KO9UJgHwHMd?=
 =?us-ascii?Q?ljyy8HwOWF2GreyiF5czLKk0euqVloNWbBRb4W9nNptvBTJ6FsFPDgLIj4K/?=
 =?us-ascii?Q?KPm9DC+lQhghGp6c8xfpZ45f+BK9na2jtjGlR1RTMcY9U02lqspRKXytTJk9?=
 =?us-ascii?Q?lYTkA4dlC9j2qZICvvnCt/V+2yekLN6qr3BebG+ydAUVGwH4RviLW9KvmY1D?=
 =?us-ascii?Q?cix4gIs2HKySg0f1qN+PQY+k6+VBq1ZLd3lkzWdylbCMH9cjSIfNZJAJlUAm?=
 =?us-ascii?Q?4XC+fuZ0BWanZWSH1jX0ieOsR3s0XikdkzTQMTizgHA1EAnMqACshMCZKZw/?=
 =?us-ascii?Q?HTXiXOql77RCO1vUafilv0wjh8ILfNb4GoTamKo6NSRSKViYPbllQwZ2Ngvu?=
 =?us-ascii?Q?bq5CHZvKH/+/D2zhCu4YlxNn1tJ6LvbKz8+OHngMB/4kd9Rq5233q5rFHJ/h?=
 =?us-ascii?Q?NXUB8gmpxo6NuIVCAlhrGM3HGZe0KL3G49UbyOxGRHLHGatCnm1VBB+wSBAw?=
 =?us-ascii?Q?Prakhw+cr6OPjCy8X8MxlBRH?=
X-OriginatorOrg: oppo.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 334d20c5-75e6-408f-906a-08d9766ec92e
X-MS-Exchange-CrossTenant-AuthSource: SG2PR02MB4108.apcprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 13 Sep 2021 04:27:24.7455 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: f1905eb1-c353-41c5-9516-62b4a54b5ee6
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: +FwYIQlsCFcT9/mzsjPsUGO7QOPfkai/VbnFhfa22Dw3c74Wa0CsVP3okt9KxmdjFLmIUCME6k5jQpMwMLg10A==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SG2PR02MB3372
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
Cc: yh@oppo.com, guoweichao@oppo.com, zhangshiming@oppo.com
Errors-To: linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org
Sender: "Linux-erofs"
 <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>

Previously, there is no need to get the full decompressed length since
EROFS supports partial decompression. However for some other cases
such as fiemap, the full decompressed length is necessary for iomap to
make it work properly.

This patch adds a way to get the full decompressed length. Note that
it takes more metadata overhead and it'd be avoided if possible in the
performance sensitive scenario.

Signed-off-by: Huang Jianan <huangjianan@oppo.com>
---
 include/erofs/internal.h | 10 +++-
 lib/data.c               |  2 +-
 lib/zmap.c               | 99 ++++++++++++++++++++++++++++++++++++----
 3 files changed, 99 insertions(+), 12 deletions(-)

diff --git a/include/erofs/internal.h b/include/erofs/internal.h
index f5eacea..72a7cb7 100644
--- a/include/erofs/internal.h
+++ b/include/erofs/internal.h
@@ -253,6 +253,14 @@ struct erofs_map_blocks {
 	erofs_blk_t index;
 };
 
+/* Flags used by erofs_map_blocks_flatmode() */
+#define EROFS_GET_BLOCKS_RAW    0x0001
+/*
+ * Used to get the exact decompressed length, e.g. fiemap (consider lookback
+ * approach instead if possible since it's more metadata lightweight.)
+ */
+#define EROFS_GET_BLOCKS_FIEMAP	0x0002
+
 /* super.c */
 int erofs_read_superblock(void);
 
@@ -265,7 +273,7 @@ int erofs_pread(struct erofs_inode *inode, char *buf,
 /* zmap.c */
 int z_erofs_fill_inode(struct erofs_inode *vi);
 int z_erofs_map_blocks_iter(struct erofs_inode *vi,
-			    struct erofs_map_blocks *map);
+			    struct erofs_map_blocks *map, int flags);
 
 #ifdef EUCLEAN
 #define EFSCORRUPTED	EUCLEAN		/* Filesystem is corrupted */
diff --git a/lib/data.c b/lib/data.c
index 1a1005a..38627d7 100644
--- a/lib/data.c
+++ b/lib/data.c
@@ -136,7 +136,7 @@ static int z_erofs_read_data(struct erofs_inode *inode, char *buffer,
 	while (end > offset) {
 		map.m_la = end - 1;
 
-		ret = z_erofs_map_blocks_iter(inode, &map);
+		ret = z_erofs_map_blocks_iter(inode, &map, 0);
 		if (ret)
 			break;
 
diff --git a/lib/zmap.c b/lib/zmap.c
index 458030b..f6a8ccf 100644
--- a/lib/zmap.c
+++ b/lib/zmap.c
@@ -159,9 +159,34 @@ static unsigned int decode_compactedbits(unsigned int lobits,
 	return lo;
 }
 
+static int get_compacted_la_distance(unsigned int lclusterbits,
+				     unsigned int encodebits,
+				     unsigned int vcnt, u8 *in, int i)
+{
+	const unsigned int lomask = (1 << lclusterbits) - 1;
+	unsigned int lo, d1 = 0;
+	u8 type;
+
+	DBG_BUGON(i >= vcnt);
+
+	do {
+		lo = decode_compactedbits(lclusterbits, lomask,
+					  in, encodebits * i, &type);
+
+		if (type != Z_EROFS_VLE_CLUSTER_TYPE_NONHEAD)
+			return d1;
+		++d1;
+	} while (++i < vcnt);
+
+	/* vcnt - 1 (Z_EROFS_VLE_CLUSTER_TYPE_NONHEAD) item */
+	if (!(lo & Z_EROFS_VLE_DI_D0_CBLKCNT))
+		d1 += lo - 1;
+	return d1;
+}
+
 static int unpack_compacted_index(struct z_erofs_maprecorder *m,
 				  unsigned int amortizedshift,
-				  unsigned int eofs)
+				  unsigned int eofs, bool lookahead)
 {
 	struct erofs_inode *const vi = m->inode;
 	const unsigned int lclusterbits = vi->z_logical_clusterbits;
@@ -190,6 +215,11 @@ static int unpack_compacted_index(struct z_erofs_maprecorder *m,
 	m->type = type;
 	if (type == Z_EROFS_VLE_CLUSTER_TYPE_NONHEAD) {
 		m->clusterofs = 1 << lclusterbits;
+
+		/* figure out lookahead_distance: delta[1] if needed */
+		if (lookahead)
+			m->delta[1] = get_compacted_la_distance(lclusterbits,
+						encodebits, vcnt, in, i);
 		if (lo & Z_EROFS_VLE_DI_D0_CBLKCNT) {
 			if (!big_pcluster) {
 				DBG_BUGON(1);
@@ -260,7 +290,7 @@ static int unpack_compacted_index(struct z_erofs_maprecorder *m,
 }
 
 static int compacted_load_cluster_from_disk(struct z_erofs_maprecorder *m,
-					    unsigned long lcn)
+					    unsigned long lcn, bool lookahead)
 {
 	struct erofs_inode *const vi = m->inode;
 	const unsigned int lclusterbits = vi->z_logical_clusterbits;
@@ -310,11 +340,12 @@ out:
 	err = z_erofs_reload_indexes(m, erofs_blknr(pos));
 	if (err)
 		return err;
-	return unpack_compacted_index(m, amortizedshift, erofs_blkoff(pos));
+	return unpack_compacted_index(m, amortizedshift, erofs_blkoff(pos),
+				      lookahead);
 }
 
 static int z_erofs_load_cluster_from_disk(struct z_erofs_maprecorder *m,
-					  unsigned int lcn)
+					  unsigned int lcn, bool lookahead)
 {
 	const unsigned int datamode = m->inode->datalayout;
 
@@ -322,7 +353,7 @@ static int z_erofs_load_cluster_from_disk(struct z_erofs_maprecorder *m,
 		return legacy_load_cluster_from_disk(m, lcn);
 
 	if (datamode == EROFS_INODE_FLAT_COMPRESSION)
-		return compacted_load_cluster_from_disk(m, lcn);
+		return compacted_load_cluster_from_disk(m, lcn, lookahead);
 
 	return -EINVAL;
 }
@@ -345,7 +376,7 @@ static int z_erofs_extent_lookback(struct z_erofs_maprecorder *m,
 
 	/* load extent head logical cluster if needed */
 	lcn -= lookback_distance;
-	err = z_erofs_load_cluster_from_disk(m, lcn);
+	err = z_erofs_load_cluster_from_disk(m, lcn, false);
 	if (err)
 		return err;
 
@@ -394,7 +425,7 @@ static int z_erofs_get_extent_compressedlen(struct z_erofs_maprecorder *m,
 	if (m->compressedlcs)
 		goto out;
 
-	err = z_erofs_load_cluster_from_disk(m, lcn);
+	err = z_erofs_load_cluster_from_disk(m, lcn, false);
 	if (err)
 		return err;
 
@@ -440,8 +471,50 @@ err_bonus_cblkcnt:
 	return -EFSCORRUPTED;
 }
 
+static int z_erofs_get_extent_decompressedlen(struct z_erofs_maprecorder *m)
+{
+	struct erofs_inode *const vi = m->inode;
+	struct erofs_map_blocks *map = m->map;
+	unsigned int lclusterbits = vi->z_logical_clusterbits;
+	u64 lcn = m->lcn, headlcn = map->m_la >> lclusterbits;
+	int err;
+
+	do {
+		/* handle the last EOF pcluster (no next HEAD lcluster) */
+		if ((lcn << lclusterbits) >= vi->i_size) {
+			map->m_llen = vi->i_size - map->m_la;
+			return 0;
+		}
+
+		err = z_erofs_load_cluster_from_disk(m, lcn, true);
+		if (err)
+			return err;
+
+		if (m->type == Z_EROFS_VLE_CLUSTER_TYPE_NONHEAD) {
+			DBG_BUGON(!m->delta[1] &&
+				  m->clusterofs != 1 << lclusterbits);
+		} else if (m->type == Z_EROFS_VLE_CLUSTER_TYPE_PLAIN ||
+			   m->type == Z_EROFS_VLE_CLUSTER_TYPE_HEAD) {
+			/* go on until the next HEAD lcluster */
+			if (lcn != headlcn)
+				break;
+			m->delta[1] = 1;
+		} else {
+			erofs_err("unknown type %u @ lcn %lu of nid %llu",
+				  m->type, lcn, (unsigned long long)vi->nid);
+			DBG_BUGON(1);
+			return -EOPNOTSUPP;
+		}
+		lcn += m->delta[1];
+	} while (m->delta[1]);
+
+	map->m_llen = (lcn << lclusterbits) + m->clusterofs - map->m_la;
+	return 0;
+}
+
 int z_erofs_map_blocks_iter(struct erofs_inode *vi,
-			    struct erofs_map_blocks *map)
+			    struct erofs_map_blocks *map,
+			    int flags)
 {
 	struct z_erofs_maprecorder m = {
 		.inode = vi,
@@ -470,7 +543,7 @@ int z_erofs_map_blocks_iter(struct erofs_inode *vi,
 	initial_lcn = ofs >> lclusterbits;
 	endoff = ofs & ((1 << lclusterbits) - 1);
 
-	err = z_erofs_load_cluster_from_disk(&m, initial_lcn);
+	err = z_erofs_load_cluster_from_disk(&m, initial_lcn, false);
 	if (err)
 		goto out;
 
@@ -512,11 +585,17 @@ int z_erofs_map_blocks_iter(struct erofs_inode *vi,
 
 	map->m_llen = end - map->m_la;
 	map->m_pa = blknr_to_addr(m.pblk);
+	map->m_flags |= EROFS_MAP_MAPPED;
 
 	err = z_erofs_get_extent_compressedlen(&m, initial_lcn);
 	if (err)
 		goto out;
-	map->m_flags |= EROFS_MAP_MAPPED;
+
+	if (flags & EROFS_GET_BLOCKS_FIEMAP) {
+		err = z_erofs_get_extent_decompressedlen(&m);
+		if (!err)
+			map->m_flags |= EROFS_MAP_FULL_MAPPED;
+	}
 
 out:
 	erofs_dbg("m_la %" PRIu64 " m_pa %" PRIu64 " m_llen %" PRIu64 " m_plen %" PRIu64 " m_flags 0%o",
-- 
2.25.1

