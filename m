Return-Path: <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>
X-Original-To: lists+linux-erofs@lfdr.de
Delivered-To: lists+linux-erofs@lfdr.de
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2404:9400:2:0:216:3eff:fee1:b9f1])
	by mail.lfdr.de (Postfix) with ESMTPS id 91B47832D13
	for <lists+linux-erofs@lfdr.de>; Fri, 19 Jan 2024 17:25:41 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=lists.ozlabs.org;
	s=201707; t=1705681535;
	bh=bGTH/+9Or2SMyMFJVScpVE3HhK9iwsjqDDAxM8th94c=;
	h=To:Subject:Date:List-Id:List-Unsubscribe:List-Archive:List-Post:
	 List-Help:List-Subscribe:From:Reply-To:Cc:From;
	b=Ug4ICPaoSQFUI7uNUZLYUayuXzGFXsPgJkr+WelUE+jByo1tcWVviT9nhmujWEf/n
	 CDZDrR47bnchmduhwf9Fv9YMC7YRHNVQ1ZZoebHxfU+h7lOebia6u/R5PaFOfT7KTg
	 GNSeZo499e8hR/rk/BwcTw6shaqOu2ykR/b1So4AI6DYYxTRwvqlt3pPJEOIiJ8JC/
	 mfgVjfp2nyFs5pBE4SDhkTXfqhK/m1MArewQXmWnL5TXKV4h+fk19K8YUI9NPYkdo5
	 zPRX6z64tHyd3NES20zPx2shRhepPYO6ZbekXYwc+MvNsN3Jzm3WR+7atfRruQpSSx
	 f3VVoVnvOTcow==
Received: from boromir.ozlabs.org (localhost [IPv6:::1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4TGlMz4jNWz3c1g
	for <lists+linux-erofs@lfdr.de>; Sat, 20 Jan 2024 03:25:35 +1100 (AEDT)
X-Original-To: linux-erofs@lists.ozlabs.org
Delivered-To: linux-erofs@lists.ozlabs.org
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=vivo.com header.i=@vivo.com header.a=rsa-sha256 header.s=selector2 header.b=NiF8xuST;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=vivo.com (client-ip=2a01:111:f400:feae::72e; helo=apc01-psa-obe.outbound.protection.outlook.com; envelope-from=guochunhai@vivo.com; receiver=lists.ozlabs.org)
Received: from APC01-PSA-obe.outbound.protection.outlook.com (mail-psaapc01on2072e.outbound.protection.outlook.com [IPv6:2a01:111:f400:feae::72e])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4TGlMq52vGz3bw2
	for <linux-erofs@lists.ozlabs.org>; Sat, 20 Jan 2024 03:25:26 +1100 (AEDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=BSUXnxpu3pQIP6e9i014yXS9rRHvgGDsVJ1AkIsG16Dm+y2b9Q0OcU0CXtP5t7jrs05cTuFtpduR62esoqfUHqi+fnLR7KVbn+B6TGkTE6swLuIawrFX+TBIznPrUj78MUJ94iahCBHYOJg7oqIpa9xd3epORp9Vv6C3PCM1yGjQsbuu+becyG3I3X6Da/tGhqXDLk1ZZZ29GXogm6ZAx1pJeOLDZD2R1nAbMCSGyxhUJHI19p80+iOdi09YcXYgb81Z7ouy2LElcvfqd+0HzXkGwoX7T0V2AbKM/AdR00GfBbBLN5wGoOA2MIJKbCe7ywLxplBl+iuh3RF4t8lgYA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=bGTH/+9Or2SMyMFJVScpVE3HhK9iwsjqDDAxM8th94c=;
 b=LM7DGZYdMAUl6gJOZ9gba2SHpDVDNV6/OYpjYXqH7d3Tcx4GNf5Dg7JiQ+S4WYbLNgjUFGJ+z1OxUeC3Ch4gOTAz4x20nlhf4/cJMFHt8Oak4WTOYpSxbIwxm2KgXoUl2ThQXLxHBDrIl7ZGZY1uPmKB3jqGOJt+x8Znzn2nuY4vbd+WTm3hy9tGb2C+xaNRv9LR7AqmFqmFrEXntUqd/uWDxORpZeuQk8/KgAUQJiUl3COCKQQT4miNoYY9agNA7ZvjK4MV726PM2fq5rpdMYia5rAuXgXOphGZedLXR8gyW1w3dAY5V+xy4tDP3c1N1TwFykfobR+U1PD8PQgoTg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=vivo.com; dmarc=pass action=none header.from=vivo.com;
 dkim=pass header.d=vivo.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=vivo.com;
Received: from TY2PR06MB3342.apcprd06.prod.outlook.com (2603:1096:404:fb::23)
 by SI2PR06MB5388.apcprd06.prod.outlook.com (2603:1096:4:1ef::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7202.23; Fri, 19 Jan
 2024 16:25:03 +0000
Received: from TY2PR06MB3342.apcprd06.prod.outlook.com
 ([fe80::b403:721d:ec13:d457]) by TY2PR06MB3342.apcprd06.prod.outlook.com
 ([fe80::b403:721d:ec13:d457%5]) with mapi id 15.20.7202.024; Fri, 19 Jan 2024
 16:25:02 +0000
To: xiang@kernel.org
Subject: [PATCH] erofs: alloc readahead page with __GFP_NOFAIL flag during decompression
Date: Fri, 19 Jan 2024 09:35:37 -0700
Message-Id: <20240119163537.1776667-1-guochunhai@vivo.com>
X-Mailer: git-send-email 2.25.1
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SG2P153CA0004.APCP153.PROD.OUTLOOK.COM (2603:1096::14) To
 TY2PR06MB3342.apcprd06.prod.outlook.com (2603:1096:404:fb::23)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: TY2PR06MB3342:EE_|SI2PR06MB5388:EE_
X-MS-Office365-Filtering-Correlation-Id: 521ed941-e1c4-4fe1-1dad-08dc190b305b
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 	yPPeP8ccjrLUNonI4X7jO0kWItSjH66bdgJfGvl/q4R9ePTZ6iZv8zVEO13oTjrloocBC5pNJltszYPqlCWIKVQJw6gAP7klcANNS/qKVv7QSNtD40l/5xkrOWd+2I9Y9h8bSvM/ccttcXyj0RVeWgdAuJBjCk3SCsPts4vuD3nAXcaKYQSEF4G9rn0CDGhI2G0i9dKC9Z8WVyOp3gLP0XFrkb49rN0BtZRMACddXJo2mzextmbR5AHO3kZ6D/xjDXOljoWP65db4YGh0NRjrT4V5H85PLU2XXW51qT2f8hhcK3D9T07vjdaH9aSMneNBYyAq4yiI0MOgX35Kd2pjWDBTsDaof+qBM6cHaxT1BFQPlEmNCaKFzqxIq7IDxm7TUqMNS1O4JOv2DHzUlBooNlcpuwqNC3cnuKyA960Vwm0PlHL91A5rMDEsZDrLodQOxVjdnqRQ3ZT7dACIYwvjaUCHyTaph6YPESgGIWZ++87dKmZlw22xksTr61QY9OTBYJKin3fuYPlSvOq4DIN2OrCdRtQ5UqvkeHdrp+MEFWxBA2vt+44CmhEWhZVJqfTaoRYW9h9y2yu7TIyC3rsi5O2jYVRzoMLWIfYLJ1temS8givn4PpJ6ss82Z3xeMYa
X-Forefront-Antispam-Report: 	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:TY2PR06MB3342.apcprd06.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(366004)(376002)(396003)(346002)(136003)(39860400002)(230922051799003)(1800799012)(64100799003)(186009)(451199024)(6512007)(38350700005)(26005)(6666004)(52116002)(107886003)(5660300002)(2906002)(478600001)(1076003)(8936002)(6916009)(66556008)(6486002)(2616005)(66476007)(6506007)(316002)(66946007)(83380400001)(38100700002)(8676002)(86362001)(41300700001)(4326008)(36756003);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 	=?us-ascii?Q?RpPAoRvsXO6FKyf4Yxo68rAWemPkBWzySLBsCBQTbuy7sF+WHa0l05/qdzGn?=
 =?us-ascii?Q?uKMCPzAipFHeXVqFd3dVdyEzX8FFB11da5hXu5GPkq6MjANeuqfwd9Yk8R4v?=
 =?us-ascii?Q?M6cnlb1QhSwJjhSmOyhXgYw/w657mS3ipsPqVhuxYVZhIYw4ftrht5oYfqd3?=
 =?us-ascii?Q?U+buPgUgzOFwdbiwFR/+alpjytClXxQX1k+UE1Qrlct52r4w2YHz6ZtGClD0?=
 =?us-ascii?Q?quaYKkc1wOx43NBqI384tJrHKZ+bPArqa2hjBGQDbfR/LjeuAywis4gCaYNi?=
 =?us-ascii?Q?nFpWITlCoYTUWkdJsPijfKVv9IO4jlAZTnMkhg/r7U5WjhAWCDmYDmdYkXaY?=
 =?us-ascii?Q?lsR8pUJu6wpIj35MWIKn/QQzl1f8Rta0A9uhopHdoDtJ9E1U0c8CAryvS6V0?=
 =?us-ascii?Q?Cqs/wVuMYITiFemZKTjCw8kixV9CJdpj3EKad9OeuBqM3L6LX7i1l0fIwrRX?=
 =?us-ascii?Q?ZMKM5oPsKu2HhRZbodqPe7DZJq0FA8v4KeWG6AH61kd8w3+gsOippuzhXG7O?=
 =?us-ascii?Q?QKGYmrFISbWENpGSUoWybI3oRWoiRSwHGmfZklUZF+yst3I2q9rTrlAG61lY?=
 =?us-ascii?Q?jzVuWOucs9xREsBUdrLbPkQekWkZvEXRd67gaEZdcKNg3RZ4KIlepEozAHZ1?=
 =?us-ascii?Q?zF6bslZtj2lQf2/KUOi+uSMIU0L8swDmBqauUQuZ9juEI/LKwnJzKUZbxcKl?=
 =?us-ascii?Q?2bqnzYu0obg5Vj7mUOAE0HWp4cTwVilBYcGwPNjvbO9BwcmZhuLT/KyOilFg?=
 =?us-ascii?Q?mMRUo3ldvEVB3JgoYTuD6LC+r4JazMP2NXwjpXSb3JGq7Cj2igq2jZw6Fk7Q?=
 =?us-ascii?Q?CQL4xaRODXZmHeIFnO2fy4QrxAjjJTZ6kxmLCRU1pqIhqwScU2DRguXEJ4Fc?=
 =?us-ascii?Q?5CDsHCYXtId4+QG7UTDk5Djht/OQ7bZUTOM1Wz4jTJUAyIUU3UqF8NddAa6s?=
 =?us-ascii?Q?UJKALvw8q1WJpnyeMME6p6mdjpC3TQdHUa1ynpb2YZLVa8/1MjggAM8t1gpL?=
 =?us-ascii?Q?KO1I/wXYGEV9yAAX76cHECB/DRDG9HDy/qehWAMSKc2FyKFRKk1TvXDvPOkO?=
 =?us-ascii?Q?7GnAeDHsPTO+YgBUpOS0CO8WTLmkZKg3QPvlOaHRSBtoaMBPFhrsDaOne0qP?=
 =?us-ascii?Q?g6IjAPbADCf7+aLYNmo+kLqTZkwsmuLk1bmtNo3PeEFOmx+EwajOWMDoTVDR?=
 =?us-ascii?Q?PEl70qhOTgBOQ/4BmV+7RWQOJBx9fphSI92X0EoxDswI6je3JtlDnxYu7IIa?=
 =?us-ascii?Q?UYCsZBsiJnllcouIF4TMDb6PmTU1Rfw+0o6zZBth47706krk7CxYS+bm9FLT?=
 =?us-ascii?Q?EJDyjqZvnLz/2g+6X/wYaUkdRAMlKBdwTG70L8gFAf1ks2nZTBaUAU/pFyqf?=
 =?us-ascii?Q?UnsJB6Mi76A6Xu3w4Bj7UUOEl2oJLwOrUwCkCptkZ2rew2iVCPLAC2agPflj?=
 =?us-ascii?Q?n/0ypiAgNW1UkxwKA/H4OYTE16LM+JiTBNzecYFKKeWB+RN8vqS9TrMDR5Rx?=
 =?us-ascii?Q?/9XZ41NkKR6HKsortJAFBUsyeln3NATNomYIb3knuKPX7jBqdpitduqJi7hj?=
 =?us-ascii?Q?7XBx2L0B8P6UNN6UIqP2kGn9/ts89boW4Y1bF2RZ?=
X-OriginatorOrg: vivo.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 521ed941-e1c4-4fe1-1dad-08dc190b305b
X-MS-Exchange-CrossTenant-AuthSource: TY2PR06MB3342.apcprd06.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 19 Jan 2024 16:25:02.8247
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 923e42dc-48d5-4cbe-b582-1a797a6412ed
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 1Isy2h6yQFY8Sztdg1RyTY+SfmXOayaHxUUF9bxtTBQf1APVZo1eOkuw0YrDG0xauiy/KWK59ie22x7imkyalg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SI2PR06MB5388
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
From: Chunhai Guo via Linux-erofs <linux-erofs@lists.ozlabs.org>
Reply-To: Chunhai Guo <guochunhai@vivo.com>
Cc: Chunhai Guo <guochunhai@vivo.com>, linux-erofs@lists.ozlabs.org, huyue2@coolpad.com
Errors-To: linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org
Sender: "Linux-erofs" <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>

During decompression, it is better to allocate readahead pages with the
GFP_NOWAIT flag, which can help reduce the time spent on page allocation in
low memory scenarios.

From the result of multi-app launch benchmarks on ARM64 Android devices
running the 5.15 kernel with an 8-core CPU and 8GB of memory, there was an
average reduction of 21% in page allocation time.

Also, I need to revert commit ef4b4b46c6aa ("erofs: remove the member
readahead from struct z_erofs_decompress_frontend") to use the readahead
member in struct z_erofs_decompress_frontend.

Signed-off-by: Chunhai Guo <guochunhai@vivo.com>
---
 fs/erofs/compress.h             |  1 +
 fs/erofs/decompressor.c         |  5 +++--
 fs/erofs/decompressor_deflate.c | 15 ++++++++++++---
 fs/erofs/decompressor_lzma.c    | 16 +++++++++++++---
 fs/erofs/zdata.c                | 32 +++++++++++++++++++++++++-------
 5 files changed, 54 insertions(+), 15 deletions(-)

diff --git a/fs/erofs/compress.h b/fs/erofs/compress.h
index 279933e007d2..95157354ad71 100644
--- a/fs/erofs/compress.h
+++ b/fs/erofs/compress.h
@@ -18,6 +18,7 @@ struct z_erofs_decompress_req {
 	/* indicate the algorithm will be used for decompression */
 	unsigned int alg;
 	bool inplace_io, partial_decoding, fillgaps;
+	gfp_t gfp;
 };
 
 struct z_erofs_decompressor {
diff --git a/fs/erofs/decompressor.c b/fs/erofs/decompressor.c
index 1d65b9f60a39..ef2b08ec9830 100644
--- a/fs/erofs/decompressor.c
+++ b/fs/erofs/decompressor.c
@@ -111,8 +111,9 @@ static int z_erofs_lz4_prepare_dstpages(struct z_erofs_lz4_decompress_ctx *ctx,
 			victim = availables[--top];
 			get_page(victim);
 		} else {
-			victim = erofs_allocpage(pagepool,
-						 GFP_KERNEL | __GFP_NOFAIL);
+			victim = erofs_allocpage(pagepool, rq->gfp);
+			if (!victim)
+				return -ENOMEM;
 			set_page_private(victim, Z_EROFS_SHORTLIVED_PAGE);
 		}
 		rq->out[i] = victim;
diff --git a/fs/erofs/decompressor_deflate.c b/fs/erofs/decompressor_deflate.c
index 4a64a9c91dd3..93138ae17250 100644
--- a/fs/erofs/decompressor_deflate.c
+++ b/fs/erofs/decompressor_deflate.c
@@ -159,7 +159,11 @@ int z_erofs_deflate_decompress(struct z_erofs_decompress_req *rq,
 			outsz -= strm->z.avail_out;
 			if (!rq->out[no]) {
 				rq->out[no] = erofs_allocpage(pagepool,
-						GFP_KERNEL | __GFP_NOFAIL);
+						rq->gfp);
+				if (!rq->out[no]) {
+					err = -ENOMEM;
+					break;
+				}
 				set_page_private(rq->out[no],
 						 Z_EROFS_SHORTLIVED_PAGE);
 			}
@@ -211,12 +215,17 @@ int z_erofs_deflate_decompress(struct z_erofs_decompress_req *rq,
 
 			DBG_BUGON(erofs_page_is_managed(EROFS_SB(sb),
 							rq->in[j]));
-			tmppage = erofs_allocpage(pagepool,
-						  GFP_KERNEL | __GFP_NOFAIL);
+			tmppage = erofs_allocpage(pagepool, rq->gfp);
+			if (!tmppage) {
+				err = -ENOMEM;
+				break;
+			}
 			set_page_private(tmppage, Z_EROFS_SHORTLIVED_PAGE);
 			copy_highpage(tmppage, rq->in[j]);
 			rq->in[j] = tmppage;
 		}
+		if (err)
+			break;
 
 		zerr = zlib_inflate(&strm->z, Z_SYNC_FLUSH);
 		if (zerr != Z_OK || !(outsz + strm->z.avail_out)) {
diff --git a/fs/erofs/decompressor_lzma.c b/fs/erofs/decompressor_lzma.c
index 2dd14f99c1dc..a854f60033df 100644
--- a/fs/erofs/decompressor_lzma.c
+++ b/fs/erofs/decompressor_lzma.c
@@ -216,7 +216,11 @@ int z_erofs_lzma_decompress(struct z_erofs_decompress_req *rq,
 			outlen -= strm->buf.out_size;
 			if (!rq->out[no] && rq->fillgaps) {	/* deduped */
 				rq->out[no] = erofs_allocpage(pagepool,
-						GFP_KERNEL | __GFP_NOFAIL);
+						rq->gfp);
+				if (!rq->out[no]) {
+					err = -ENOMEM;
+					break;
+				}
 				set_page_private(rq->out[no],
 						 Z_EROFS_SHORTLIVED_PAGE);
 			}
@@ -258,12 +262,18 @@ int z_erofs_lzma_decompress(struct z_erofs_decompress_req *rq,
 
 			DBG_BUGON(erofs_page_is_managed(EROFS_SB(rq->sb),
 							rq->in[j]));
-			tmppage = erofs_allocpage(pagepool,
-						  GFP_KERNEL | __GFP_NOFAIL);
+			tmppage = erofs_allocpage(pagepool, rq->gfp);
+			if (!tmppage) {
+				err = -ENOMEM;
+				break;
+			}
 			set_page_private(tmppage, Z_EROFS_SHORTLIVED_PAGE);
 			copy_highpage(tmppage, rq->in[j]);
 			rq->in[j] = tmppage;
 		}
+		if (err)
+			break;
+
 		xz_err = xz_dec_microlzma_run(strm->state, &strm->buf);
 		DBG_BUGON(strm->buf.out_pos > strm->buf.out_size);
 		DBG_BUGON(strm->buf.in_pos > strm->buf.in_size);
diff --git a/fs/erofs/zdata.c b/fs/erofs/zdata.c
index 692c0c39be63..4ab4b16b435a 100644
--- a/fs/erofs/zdata.c
+++ b/fs/erofs/zdata.c
@@ -82,6 +82,9 @@ struct z_erofs_pcluster {
 	/* L: indicate several pageofs_outs or not */
 	bool multibases;
 
+	/* L: whether read with readahead flag or not  */
+	bool readahead;
+
 	/* A: compressed bvecs (can be cached or inplaced pages) */
 	struct z_erofs_bvec compressed_bvecs[];
 };
@@ -525,6 +528,8 @@ struct z_erofs_decompress_frontend {
 
 	/* a pointer used to pick up inplace I/O pages */
 	unsigned int icur;
+
+	bool readahead;
 };
 
 #define DECOMPRESS_FRONTEND_INIT(__i) { \
@@ -797,6 +802,7 @@ static int z_erofs_register_pcluster(struct z_erofs_decompress_frontend *fe)
 	pcl->algorithmformat = map->m_algorithmformat;
 	pcl->length = 0;
 	pcl->partial = true;
+	pcl->readahead = true;          /* readahead is true by default */
 
 	/* new pclusters should be claimed as type 1, primary and followed */
 	pcl->next = fe->owned_head;
@@ -872,6 +878,9 @@ static int z_erofs_pcluster_begin(struct z_erofs_decompress_frontend *fe)
 		return ret;
 	}
 
+	if (!fe->readahead)
+		fe->pcl->readahead = false;
+
 	z_erofs_bvec_iter_begin(&fe->biter, &fe->pcl->bvset,
 				Z_EROFS_INLINE_BVECS, fe->pcl->vcnt);
 	if (!z_erofs_is_inline_pcluster(fe->pcl)) {
@@ -1267,7 +1276,13 @@ static int z_erofs_decompress_pcluster(struct z_erofs_decompress_backend *be,
 	err2 = z_erofs_parse_in_bvecs(be, &overlapped);
 	if (err2)
 		err = err2;
-	if (!err)
+	if (!err) {
+		gfp_t gfp;
+
+		if (pcl->readahead)
+			gfp = GFP_NOWAIT | __GFP_NOWARN;
+		else
+			gfp = GFP_KERNEL | __GFP_NOFAIL;
 		err = decomp->decompress(&(struct z_erofs_decompress_req) {
 					.sb = be->sb,
 					.in = be->compressed_pages,
@@ -1280,7 +1295,9 @@ static int z_erofs_decompress_pcluster(struct z_erofs_decompress_backend *be,
 					.inplace_io = overlapped,
 					.partial_decoding = pcl->partial,
 					.fillgaps = pcl->multibases,
+					.gfp = gfp,
 				 }, be->pagepool);
+	}
 
 	/* must handle all compressed pages before actual file pages */
 	if (z_erofs_is_inline_pcluster(pcl)) {
@@ -1599,7 +1616,7 @@ static void z_erofs_submissionqueue_endio(struct bio *bio)
 
 static void z_erofs_submit_queue(struct z_erofs_decompress_frontend *f,
 				 struct z_erofs_decompressqueue *fgq,
-				 bool *force_fg, bool readahead)
+				 bool *force_fg)
 {
 	struct super_block *sb = f->inode->i_sb;
 	struct address_space *mc = MNGD_MAPPING(EROFS_SB(sb));
@@ -1677,7 +1694,7 @@ static void z_erofs_submit_queue(struct z_erofs_decompress_frontend *f,
 				bio->bi_end_io = z_erofs_submissionqueue_endio;
 				bio->bi_iter.bi_sector = cur >> 9;
 				bio->bi_private = q[JQ_SUBMIT];
-				if (readahead)
+				if (f->readahead)
 					bio->bi_opf |= REQ_RAHEAD;
 				++nr_bios;
 				last_bdev = mdev.m_bdev;
@@ -1717,13 +1734,13 @@ static void z_erofs_submit_queue(struct z_erofs_decompress_frontend *f,
 }
 
 static void z_erofs_runqueue(struct z_erofs_decompress_frontend *f,
-			     bool force_fg, bool ra)
+			     bool force_fg)
 {
 	struct z_erofs_decompressqueue io[NR_JOBQUEUES];
 
 	if (f->owned_head == Z_EROFS_PCLUSTER_TAIL)
 		return;
-	z_erofs_submit_queue(f, io, &force_fg, ra);
+	z_erofs_submit_queue(f, io, &force_fg);
 
 	/* handle bypass queue (no i/o pclusters) immediately */
 	z_erofs_decompress_queue(&io[JQ_BYPASS], &f->pagepool);
@@ -1811,7 +1828,7 @@ static int z_erofs_read_folio(struct file *file, struct folio *folio)
 	z_erofs_pcluster_end(&f);
 
 	/* if some compressed cluster ready, need submit them anyway */
-	z_erofs_runqueue(&f, z_erofs_is_sync_decompress(sbi, 0), false);
+	z_erofs_runqueue(&f, z_erofs_is_sync_decompress(sbi, 0));
 
 	if (err && err != -EINTR)
 		erofs_err(inode->i_sb, "read error %d @ %lu of nid %llu",
@@ -1831,6 +1848,7 @@ static void z_erofs_readahead(struct readahead_control *rac)
 	unsigned int nr_folios;
 	int err;
 
+	f.readahead = true;
 	f.headoffset = readahead_pos(rac);
 
 	z_erofs_pcluster_readmore(&f, rac, true);
@@ -1855,7 +1873,7 @@ static void z_erofs_readahead(struct readahead_control *rac)
 	z_erofs_pcluster_readmore(&f, rac, false);
 	z_erofs_pcluster_end(&f);
 
-	z_erofs_runqueue(&f, z_erofs_is_sync_decompress(sbi, nr_folios), true);
+	z_erofs_runqueue(&f, z_erofs_is_sync_decompress(sbi, nr_folios));
 	erofs_put_metabuf(&f.map.buf);
 	erofs_release_pages(&f.pagepool);
 }
-- 
2.25.1

