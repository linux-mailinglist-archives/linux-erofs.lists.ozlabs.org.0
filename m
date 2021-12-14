Return-Path: <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>
X-Original-To: lists+linux-erofs@lfdr.de
Delivered-To: lists+linux-erofs@lfdr.de
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	by mail.lfdr.de (Postfix) with ESMTPS id 16902473FEB
	for <lists+linux-erofs@lfdr.de>; Tue, 14 Dec 2021 10:53:04 +0100 (CET)
Received: from boromir.ozlabs.org (localhost [IPv6:::1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4JCtwY6hsVz304V
	for <lists+linux-erofs@lfdr.de>; Tue, 14 Dec 2021 20:53:01 +1100 (AEDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=lists.ozlabs.org;
	s=201707; t=1639475581;
	bh=XykxOFVfO5rIgd3DOU8XiL3jaPdj/zLILyr92nM8oBc=;
	h=To:Subject:Date:In-Reply-To:References:List-Id:List-Unsubscribe:
	 List-Archive:List-Post:List-Help:List-Subscribe:From:Reply-To:Cc:
	 From;
	b=Gl0hdiNGJRMNxDM9Mzs97inHicBDic3lfhsb40XcyTdlMZsbBslI15GFuw2l37giv
	 cH7lqOoa0kIMWsRwOEYViaawn/PtMoOxvJtkW4QC6DBlnypcgURVTupI+krTcQhCI+
	 n7S0cQ71NJgAh6YzamxE6Px+y1AMgv2uP9Itgm2JiW1kvqV1ONsEo3R8fHum8rUUmg
	 W3EeSq5gJMz9iNqs6p0mR+dsjTdG+bBkYHMev4qeXuwr6bJ5GkuLwJhh3wk97cpsDG
	 3jlbUdHZPW8pD8p/njnCbH7NILkkjzZs/yUZaONANdEHC+PmwhNluEyYhBAlIRrSx+
	 iGSqq9D7vf1xQ==
X-Original-To: linux-erofs@lists.ozlabs.org
Delivered-To: linux-erofs@lists.ozlabs.org
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized)
 smtp.mailfrom=oppo.com (client-ip=40.107.255.55;
 helo=apc01-psa-obe.outbound.protection.outlook.com;
 envelope-from=huangjianan@oppo.com; receiver=<UNKNOWN>)
Authentication-Results: lists.ozlabs.org; dkim=pass (1024-bit key;
 unprotected) header.d=oppo.com header.i=@oppo.com header.a=rsa-sha256
 header.s=selector1 header.b=kiPGb+io; 
 dkim-atps=neutral
Received: from APC01-PSA-obe.outbound.protection.outlook.com
 (mail-psaapc01on2055.outbound.protection.outlook.com [40.107.255.55])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 4JCtwP6xWLz2yY0
 for <linux-erofs@lists.ozlabs.org>; Tue, 14 Dec 2021 20:52:51 +1100 (AEDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=c3hFpnrhpR7c6+4F+KD/zqnx5GhQOXliCfGSNSgyMViSwGi0+z5Im0DeMW4elcqniKT8SkckVUymiHyppASo/LLHZBLcALcWi5fu6LAefGVX+SoQo6OfTtws8QYxTwQbGR8ghDpvecBKvWNaLKLZd9QXEKFPNbLzh4BNJKof816Mez7SlKJ4rOVnRZqEEuTxTfLMpi/k8niY+BwrJdZth3RQrrjGJIiRbQuIUHubRGSJZ41nQhqU1VOptHgLReOt7kpAMEUKRENYOnvBb5UnkBQXAFk4ew8nFuD4LehC6rS04fg+wPb+t4Q5z98ahCp+lmAk70ny2y26tYFndKm1Ww==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=XykxOFVfO5rIgd3DOU8XiL3jaPdj/zLILyr92nM8oBc=;
 b=e3Dh+5KXegucwekwpdbRP6OpktHTenCazuMgiJsSPrTUmGu7Tx0/aoQ2xvyRk9d/GNKBZAggJH53yWs6b/SXRN2qh75jCsGdGZMDGCoiIvkfA/8Fh5ct/ZiI+JYWHjiweTiTstZmpEmIDCCjUdGo3cJC80E/rSE7QyEHJjlqM6BLgSn57xzTSADbtqFgXZLKBkTE1nM4/pSwidKkD3sXIs76a+QKigismNPFIvsLlYsH9KNbkTH+ysopPchH4SlXdzc2g1bzw5cpyRJ+qVWkDKevYPiB/wXHs0nBzo9llxhuHs2gfQD367qEaMNX1g74+y1nXYV8s22LZ5WcHx3X9g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oppo.com; dmarc=pass action=none header.from=oppo.com;
 dkim=pass header.d=oppo.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=oppo.com;
Received: from SG2PR02MB4108.apcprd02.prod.outlook.com (2603:1096:4:96::19) by
 SG2PR02MB3371.apcprd02.prod.outlook.com (2603:1096:4:47::16) with
 Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.4755.21; Tue, 14 Dec 2021 09:52:28 +0000
Received: from SG2PR02MB4108.apcprd02.prod.outlook.com
 ([fe80::3032:4149:e5d7:982a]) by SG2PR02MB4108.apcprd02.prod.outlook.com
 ([fe80::3032:4149:e5d7:982a%3]) with mapi id 15.20.4778.018; Tue, 14 Dec 2021
 09:52:28 +0000
To: linux-erofs@lists.ozlabs.org,
	hsiangkao@linux.alibaba.com
Subject: [PATCH v2 1/2] erofs-utils: sort shared xattr
Date: Tue, 14 Dec 2021 17:52:01 +0800
Message-Id: <20211214095202.11717-1-huangjianan@oppo.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <YXE30+2qU75+0szk@B-P7TQMD6M-0146.local>
References: <YXE30+2qU75+0szk@B-P7TQMD6M-0146.local>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: HK2PR02CA0172.apcprd02.prod.outlook.com
 (2603:1096:201:1f::32) To SG2PR02MB4108.apcprd02.prod.outlook.com
 (2603:1096:4:96::19)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 775019ba-75a0-4429-effc-08d9bee77024
X-MS-TrafficTypeDiagnostic: SG2PR02MB3371:EE_
X-Microsoft-Antispam-PRVS: <SG2PR02MB3371442DB5A5C52D0BD5ECF6C3759@SG2PR02MB3371.apcprd02.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:2000;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 5Ida/WKwWOfM8fyJLufRDL/son0+zmq23seknEqKo28uBK34KiNv2FUI42rO+J4DcTs5hhSXnflPvFuM5KvygpiPRMWpMl/YID8CS4k2HsV5sNuVFnJl+MQGXWTHbtgrIDaaoLk1w0BIWwcglDWMKI0aPR8Rv8Zx5QOQW1450H36JukW3/rxCkGGZbULDHH29lcqYFhuAzdnoXBFejqRd6w3O8MHxrlXBMvZJIXLooGy4t70C/wMHRTCKqt9hFff+eT15LMqNQGuzTZBC9a0ZDPdAefCdXH2oVzB3FKN++j2xO4oAcJU+11Lum+dy3DIRhy4t8GQ1MHvEPPZph0PaDu0cBNjynzt7gD8+n+ZNbI9VhiBImpq9bB72pv1iEHDQi8FvGMaP4EjtiS/B9a3o+mR9rjM5hhtwq9JvdGypcwm6f+T96hboeiqo7H/olEj19ZHnvPTNz5fUFMUhIC60Pgf+0HvHuWLOgq/MDyDqd0ZjnbgRMIlq9oazlz/V4CrA2XWy4yATgJLd+i/HKMppMFc3Bt1WWpP2pYulxIyzZrxlZc1qvia2Sqq9Q0yHU7U4k0PSoO5xnNptpXBmJxk8zCdqJjSgG2V3XPteMZ9uyFRqNgTbxbNjNpCERCx9uHR2mi1dZ8W+BAt6M3pD2eBF0nc1wYx95CqFsGZ7O/Nujh9hcxQU0EqVODvSN9YdlNTHUcktYZGTJq+UGHlcKdfAaU0Vp1XGThle7dRbHPykoU=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:SG2PR02MB4108.apcprd02.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(4636009)(366004)(26005)(186003)(2906002)(4326008)(316002)(6506007)(38350700002)(8936002)(83380400001)(38100700002)(66946007)(1076003)(52116002)(66476007)(36756003)(86362001)(2616005)(6666004)(5660300002)(6512007)(8676002)(107886003)(66556008)(508600001)(6486002)(11606007);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?cCRt71NkZR7tFrTJwlUrMKHxhTKHV69Vxdd5s5hRwZvkjpv1t/txCiFXk3m/?=
 =?us-ascii?Q?FeeYnheMBqQbB9IODT03WQeEOa6/EyCNQk/6VNXMHnakZJ4xVelLcgkZve7Z?=
 =?us-ascii?Q?chyVa+ziev2IJqE6Z9XhNmDkN+/bkrW/T4km6+UyAWH+tELSY+2KT+hnja8z?=
 =?us-ascii?Q?56rATrWYWZZS5rys+rcfzTFMiu0H8MTvyBNFbkk1b7m7z6o4ZLfg1jCEAsMV?=
 =?us-ascii?Q?Gs9fjKr55YlZf3bKVaHNZDNo3pXveTlVvT2PgG5W2v5vO9gMXDv1gruC0/AY?=
 =?us-ascii?Q?Nx98sgxIYe6e8R68I8kFv7f7xiF+3z6rNN9fAF9a1HfFUsvcJFgEOplpuYlT?=
 =?us-ascii?Q?uPuerlCaYwf2Z3u0iPTKQX2xzUaolUdlNhMy68dBD2pkuLs8EqTzrKnscS8p?=
 =?us-ascii?Q?w8CRztFXyyElyKm2opjzxux2apvwVArzxl3VctcSprSKnu8IhSaCxUGb8Wxt?=
 =?us-ascii?Q?Zv+CxheSSAR+1Tu2caS6b89Ef1CGmeCDF6+PFtUuIr4VZSCcP0t4rZbt2Mjc?=
 =?us-ascii?Q?f5v4g8EpX5PR85glBhr+HaEweyw3cFeAoiIDxp60+t2GYd6F5ylQ442RhdtL?=
 =?us-ascii?Q?Q9AjwPgwz5BFbQ2JplSgqI/l1zBXw9jTU5+O1vRXKHaETnfXbGRLv+R64fcH?=
 =?us-ascii?Q?eyNxarhP3pC99lJSio0rJ5oLFnbZY6COwt0LKZH8fyiCOH9Hd5IY/cCtv4Il?=
 =?us-ascii?Q?llsPPDNAsCUuXnxL5i4IQHx14uEjySXr8bHJVPCDTsumvFrlnipd/7Tw63n3?=
 =?us-ascii?Q?PBsc8EpH8qUA1TrkBFMxnfPHciq/f+sB64NciXwu8rEb/t+Udxqq1MYorS4t?=
 =?us-ascii?Q?ljch7SYAZedGmYGQawhaw+q1v6q0cVjw4KFb6HTov/Xze4+amHjV/hTwGv6H?=
 =?us-ascii?Q?Liu8zxb2S5NHd+W+Bhp+MduxCtpMZhxng08Agyx7KDmY7SstE/kRsgJKGOt0?=
 =?us-ascii?Q?mIBF4uVQ3x0/0v5GGDqInc2pk6V0Zn4JB/Wl0rwJgPCm8bnP8RUbhCxnuH6w?=
 =?us-ascii?Q?Zv77DvWdBBbJlL7B+ad5oKxnEYCmoeYj1yl84tOAxQxc/1ChKBoZboN5BVlz?=
 =?us-ascii?Q?/pD7UtQ/0WHKtee7/ffteIeB0B6+VPeYLGsQA9pUrGJtjuKGXS6ZoindGR36?=
 =?us-ascii?Q?P9SL+qZpId6fnPfbVqw8RNrcaSe/Nz/h/mfai/L30plrBaxehUHneiVhGMnG?=
 =?us-ascii?Q?I5NrnYnyHlvuj6A3p4UC9Tx0v4hYdiDAJ4TTifyrHEODSfJqdf1YZ5M3KWtv?=
 =?us-ascii?Q?sZGSM2nXAefetK4Mrm9Ig7J9DbjrtULpA3H8th49CZrI4LIrWTq00GHkYiYT?=
 =?us-ascii?Q?BSvDy6HmC1X8kiyyNLIG6mUu6xtq4YHiT8b1ZPbGMQ51DY50M+unhwBDxxOY?=
 =?us-ascii?Q?SllXgRNNM0rjZBx0eF6CljPotdAu78QtosUspvzbVm06BMZ1gDFlbAM9lRJJ?=
 =?us-ascii?Q?FjMHlF9QFnMN715vrf4edGBhzbqspbiIBdEtYnB2VzMEk0WQQjBSt6nn11df?=
 =?us-ascii?Q?Vo0HhKRRT531K+eI5G79vduD6PSk4G0KlbUFlNQyLyWBpA9JmNN9b2DoiYoF?=
 =?us-ascii?Q?4L96gTXT5G/xX8f469zbDSGM1g2WVSoaklX3c8ZpSWlOLLsVJebN9f/2ZWRd?=
 =?us-ascii?Q?3DBrWiYHmcSUs44h6hwlJgY=3D?=
X-OriginatorOrg: oppo.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 775019ba-75a0-4429-effc-08d9bee77024
X-MS-Exchange-CrossTenant-AuthSource: SG2PR02MB4108.apcprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 14 Dec 2021 09:52:28.2202 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: f1905eb1-c353-41c5-9516-62b4a54b5ee6
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Uhd8H9M7W9zCw0y3S3xqNk1UmIvHqs/GVuz8ZYKF0ch7Bze1pbU6eTKTT6ZYYAANyPXIKthBKcZhBzANNMm+NQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SG2PR02MB3371
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
Cc: yh@oppo.com, guoweichao@oppo.com, zhangshiming@oppo.com, guanyuwei@oppo.com
Errors-To: linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org
Sender: "Linux-erofs"
 <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>

Sort shared xattr before writing to disk to ensure the consistency
of reproducible builds.

Signed-off-by: Huang Jianan <huangjianan@oppo.com>
---
since v1:
- use strncmp instead of strcmp.

 lib/xattr.c | 36 ++++++++++++++++++++++++++++++++++--
 1 file changed, 34 insertions(+), 2 deletions(-)

diff --git a/lib/xattr.c b/lib/xattr.c
index 196133a..fd998cd 100644
--- a/lib/xattr.c
+++ b/lib/xattr.c
@@ -562,13 +562,31 @@ static struct erofs_bhops erofs_write_shared_xattrs_bhops = {
 	.flush = erofs_bh_flush_write_shared_xattrs,
 };
 
+static int comp_xattr_item(const void *a, const void *b)
+{
+	const struct xattr_item *ia, *ib;
+	unsigned int la, lb;
+	int ret;
+
+	ia = (*((const struct inode_xattr_node **)a))->item;
+	ib = (*((const struct inode_xattr_node **)b))->item;
+	la = ia->len[0] + ia->len[1];
+	lb = ib->len[0] + ib->len[1];
+
+	ret = strncmp(ia->kvbuf, ib->kvbuf, min(la, lb));
+	if (ret != 0)
+		return ret;
+
+	return la > lb;
+}
+
 int erofs_build_shared_xattrs_from_path(const char *path)
 {
 	int ret;
 	struct erofs_buffer_head *bh;
-	struct inode_xattr_node *node, *n;
+	struct inode_xattr_node *node, *n, **sorted_n;
 	char *buf;
-	unsigned int p;
+	unsigned int p, i;
 	erofs_off_t off;
 
 	/* check if xattr or shared xattr is disabled */
@@ -606,6 +624,20 @@ int erofs_build_shared_xattrs_from_path(const char *path)
 	off %= EROFS_BLKSIZ;
 	p = 0;
 
+	sorted_n = malloc(shared_xattrs_count * sizeof(n));
+	if (!sorted_n)
+		return -ENOMEM;
+	i = 0;
+	list_for_each_entry_safe(node, n, &shared_xattrs_list, list) {
+		list_del(&node->list);
+		sorted_n[i++] = node;
+	}
+	DBG_BUGON(i != shared_xattrs_count);
+	qsort(sorted_n, shared_xattrs_count, sizeof(n), comp_xattr_item);
+	for (i = 0; i < shared_xattrs_count; i++)
+		list_add_tail(&sorted_n[i]->list, &shared_xattrs_list);
+	free(sorted_n);
+
 	list_for_each_entry_safe(node, n, &shared_xattrs_list, list) {
 		struct xattr_item *const item = node->item;
 		const struct erofs_xattr_entry entry = {
-- 
2.25.1

