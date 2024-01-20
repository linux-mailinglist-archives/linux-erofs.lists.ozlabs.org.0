Return-Path: <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>
X-Original-To: lists+linux-erofs@lfdr.de
Delivered-To: lists+linux-erofs@lfdr.de
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	by mail.lfdr.de (Postfix) with ESMTPS id 8DE38833515
	for <lists+linux-erofs@lfdr.de>; Sat, 20 Jan 2024 15:45:42 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=lists.ozlabs.org;
	s=201707; t=1705761940;
	bh=7tSIAb0yBiCqkQ79rrgwNOWaLILklASzjFZq1oKt4V0=;
	h=To:Subject:Date:List-Id:List-Unsubscribe:List-Archive:List-Post:
	 List-Help:List-Subscribe:From:Reply-To:Cc:From;
	b=maH1mOi4Y3+ZxRDZuFaFwrXf/0eOgh9Z1bViHO7VhJfhwheEzB7LSbYRr8cdEprc7
	 ANBM3wLP5c8R+56lsNBhmMxwJKU6Dz3m1z4mGktJdtKU8hRkeR4LYAm2JWagEh8472
	 IfTAqQ6VepmT3Dfgpkh9Ddk0PmJJ1CgixdJPMSIean0MpH29bXvMIQRaSOrSgnWbh+
	 bjApXpA6dtDup+v1L2sLlANg5N7ohl9YP4hdBTayXanl2I1bQshZQDVw0M/Az8uak3
	 +1stJMWH6n0LK/zfeSWoFasdU1tZDbDntk/9dRlGzPQEggEvXYWy7QykQbwOwyTv88
	 FIsoHkR58b/AQ==
Received: from boromir.ozlabs.org (localhost [IPv6:::1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4THK6D3W1Wz3c5j
	for <lists+linux-erofs@lfdr.de>; Sun, 21 Jan 2024 01:45:40 +1100 (AEDT)
X-Original-To: linux-erofs@lists.ozlabs.org
Delivered-To: linux-erofs@lists.ozlabs.org
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=vivo.com header.i=@vivo.com header.a=rsa-sha256 header.s=selector2 header.b=Ff6akq3X;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=vivo.com (client-ip=2a01:111:f400:feab::70e; helo=apc01-sg2-obe.outbound.protection.outlook.com; envelope-from=guochunhai@vivo.com; receiver=lists.ozlabs.org)
Received: from APC01-SG2-obe.outbound.protection.outlook.com (mail-sgaapc01on2070e.outbound.protection.outlook.com [IPv6:2a01:111:f400:feab::70e])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4THK660NmVz3bqx
	for <linux-erofs@lists.ozlabs.org>; Sun, 21 Jan 2024 01:45:32 +1100 (AEDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Y47VYsQZ718XC22juadxzcxPNgASLFiKT0UYL1xfGQ5J4AKHcj/chErVHgW76eQkjgG4NuYzehA9f0Um2vOPxeqV7uqrZWvD7Pf7LhJj9qeJlb3bBc0T01NgZqSRABHcdFkf63IaNUxGlp6qHIhV39KsiMOvNUSXPmt1JOkQEj20jUE4ReyiXKNjzAZNyun3a00iDyULB3uFeBIyg8KPFi9ckuMqFQBhDwP6r3YmNMu8Nuy9sp4zqfTaGA5VwrobPxNrbJ4pBUAF+JGxAIXmpYOIyjTjkhoaK7zuIxe6Jc9lkLvLK7W/xVNNhOtuzT0w6YX3CHZCYuHvJrmnI1lB6Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=7tSIAb0yBiCqkQ79rrgwNOWaLILklASzjFZq1oKt4V0=;
 b=e4TYsY2aXfgOmUbGtJucX4AVlgGY9DO5SO8w5/L/LMU+/1SGB+N2imlSjPOEt8Tv7nZ3JAhnVvq/vYAX1+dtEYdmGpNtmrLWrXk1RDqlI43v6G8eWsEXOEq42V1xj5N64sF5ffX2HIX7gIHS+UdNs8CszacsymP2hSK9EGsCjwFDXTAwvaMf/G6J02YiK7XDFrZMe/JcBfm0FR+ibaUA9qzJ0iiSj/Fhu3uR/0Ft0jlodZ4lOWyoCDrHLwgX9l8emo5wDnOIfsBiYz/BM1+DwbR+TspJTT4OCT1dMy/65VflpEqkmEc6BrU3NoMEwzaz00ameqqqBdGRQNnFDBCC+Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=vivo.com; dmarc=pass action=none header.from=vivo.com;
 dkim=pass header.d=vivo.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=vivo.com;
Received: from TY2PR06MB3342.apcprd06.prod.outlook.com (2603:1096:404:fb::23)
 by SG2PR06MB5059.apcprd06.prod.outlook.com (2603:1096:4:1c7::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7202.27; Sat, 20 Jan
 2024 14:45:08 +0000
Received: from TY2PR06MB3342.apcprd06.prod.outlook.com
 ([fe80::b403:721d:ec13:d457]) by TY2PR06MB3342.apcprd06.prod.outlook.com
 ([fe80::b403:721d:ec13:d457%5]) with mapi id 15.20.7202.027; Sat, 20 Jan 2024
 14:45:07 +0000
To: xiang@kernel.org
Subject: [PATCH v2] erofs: relaxed temporary buffers allocation on readahead
Date: Sat, 20 Jan 2024 07:55:51 -0700
Message-Id: <20240120145551.1941483-1-guochunhai@vivo.com>
X-Mailer: git-send-email 2.25.1
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SI1PR02CA0018.apcprd02.prod.outlook.com
 (2603:1096:4:1f4::7) To TY2PR06MB3342.apcprd06.prod.outlook.com
 (2603:1096:404:fb::23)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: TY2PR06MB3342:EE_|SG2PR06MB5059:EE_
X-MS-Office365-Filtering-Correlation-Id: 5b5c8910-b04f-4607-0f38-08dc19c6657f
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 	P4kganPSJ+Bf7hVEKFhF75x3d/H7U0pcjKMODXrdx2+SlJiQiMRgNUfCTNEihuwVkEnFJqVRxS3Glj+A+M9xcsk3nCCasnvTS9/XWzAs8NCZALXc8WwiJy0TIjsSR0di9lXhZmPgjESu7F3UdJZ7WRCTqybSm8Zruke9l8a41EpO9PkWZKRJ8HG3PQo3gOFco99Kq5Mq0386wPvthho6u64B/YPdia53f2BeTzsNa95GtOMqxvxnZAYdzPauGHpVunjLMVqherSlvQzPJl7p9AkgtAM4x3GLXgN0NNWMZre4A2ERdMAcVLNHsh79NY6Rx+ZQCqNcK23LmI4iZhq2K8xr026Gr37tWL7NBJs1U7RZ+v8BFLLFaIutXkBzWeF6p2aG8+VJDU7ZXQkZC+PtmhjYYI9b4TSNUjmAWzliqefFFd1VIfFenvcP1KBk33+C04EIPqzGv2GgLB1b9I6roVGx6IHUZMK+RZ6o12QlkzTBDjSKEv1i3xMc87akEcGkY7TqF7uMrdH/x6bhpGjNCQi66RKW9QfXpL7YllrfbIK/s1KpVxKHeYNTEoFVPjAIZSHCSLCkRUlYnhxusTtqRG3WokxqRPgKifYuHPMhaUsFzTQSiIgIEySgURo2p0R9
X-Forefront-Antispam-Report: 	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:TY2PR06MB3342.apcprd06.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(376002)(366004)(39860400002)(346002)(136003)(396003)(230922051799003)(1800799012)(186009)(451199024)(64100799003)(2616005)(6506007)(1076003)(26005)(6512007)(107886003)(6666004)(52116002)(5660300002)(8676002)(83380400001)(4326008)(8936002)(41300700001)(966005)(6486002)(478600001)(45080400002)(66946007)(66476007)(66556008)(6916009)(316002)(2906002)(86362001)(36756003)(38100700002)(38350700005)(309714004);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 	=?us-ascii?Q?XtxPk+PlJeO5LArf0dc2p8ULGjMXAkFM/OdxGg6plug26rtl9UJoEOXPeZKr?=
 =?us-ascii?Q?1OoLssYQD+RpsBewHmu0HoiBw8CM5Xs8aYtVUSavr/3M7D3EHAZQhxl6m14T?=
 =?us-ascii?Q?3afGqWB5MhGjEaw4/aEdswPUMTA8XjVmqvEQydJwT0q9CJeZ2sIZtEiBizIf?=
 =?us-ascii?Q?FSQ1KHmSHk5FUz9eddGGbwCdfh2WvvlvgTmZvOKJ2vz6neJOZaf29Qy5AGOB?=
 =?us-ascii?Q?cc+bSjKyiLXc79xL3qkAnSNkT438IWNPhZ6oUI1pTBIQIzvwmXTaXAzbrAm4?=
 =?us-ascii?Q?nA+FokzL3Jvgy0H7rCYE6C/R6IiJGPw+WcY/zswSpi2Oav/SXFcEiqmPX+P4?=
 =?us-ascii?Q?Omnwx7zq06nmuRhAaHdjHbdU3xJ+Fd2ikF7CadSjugbcMzAZuTKnHVzxy+X4?=
 =?us-ascii?Q?QavecQPDmZ8W6qRbkXoKDntRKCq063uwujYiWx8D1LEGWFSRded6z63RFSgD?=
 =?us-ascii?Q?dibnxhkv34AiVWzu9kpaQfIRWOAgMCv52XGMGfgx1+e8JfnzDetXvjY9ZPWO?=
 =?us-ascii?Q?S1KewqkLGBHtwHbERLgjwSutq4JBzObldXXlq3TTVARao+bL3ISde6YG2DSN?=
 =?us-ascii?Q?oKXIFctsbsPAo02DX98eGSbIJK0+ckT3kgWqgyJtS2YPs1HV/gttqltZLVUN?=
 =?us-ascii?Q?M/WLb/a8RwBToGokeo1tZkr3uPJDSze190hHUk8SClqEn96gkKH9spk24H77?=
 =?us-ascii?Q?roZ5Re4nlxK7MU5+AhG3QztSdq6QsnkEDoAFv6SC9lQLAySHKP5P+bCXt4Ig?=
 =?us-ascii?Q?+ORr/caSdxF55afQxgO7v6bQUMxkYg6f5RYBwUiiBy/fK1M8IzAMSj4IOnza?=
 =?us-ascii?Q?8WBPjDSQHCjORLmAjgyZnvceBxQeWN78npsRZwLM7SWPB5I5at+rk6MGhsOl?=
 =?us-ascii?Q?P7gTlxaD3g7EO1xWX8UZdNXByk/cuiYHhS0Jqx+9ubwBM6UuGN5BKWvERVI0?=
 =?us-ascii?Q?av+kClw0iana1j/7ig/S1Vi1mejWMEHPM0KemFDy37WeYc4I/5yzVR0hAqkc?=
 =?us-ascii?Q?9Pg1K0nMTnAyrp4a6qpsBVOy0p/MUsWbxa9zYM6qrWhvsjRq0kQGcOAiuXy1?=
 =?us-ascii?Q?XuuoUfeJaZ7iYhVVccOvqsM9pc0EoPlv7GEA7pX0c3mrwgxS9MyUtzUbXp9+?=
 =?us-ascii?Q?U3DXDuncxmK3lsY3XQJabf1F4Kd9722PisRrf28uw2gcjRVq9x+rIeM3kw8H?=
 =?us-ascii?Q?gAWg1TDWCO3fB09QXktCro5OzifRQu4DLsT5au038zE3E2aUfyCYQc8TfioF?=
 =?us-ascii?Q?qOAdoUR0Dfgm47PspVsDZX4+9zfIGMxByPu0xIt87FICFd3NSlcxC0Lgv8/m?=
 =?us-ascii?Q?OLnOU1h3FoohrVUadkWsh+KM8GNm9r71sPRy2QK86bfI9BiJo+eg+Qs/VmsE?=
 =?us-ascii?Q?JvD5BKAl7iKU0TgRTavo9TcDpB9Bl3ttC+z6wgTdZolTPa7BFGf0fNT2nGD7?=
 =?us-ascii?Q?vKdJhJu8y5udB7SfZdbfANR6f38jWIWUoPlI8Cd0D5fQmjhnbmz1KIyvm4b7?=
 =?us-ascii?Q?mgRPCwDISOPyQrYQ9VoArjKpINxI9uDWbuSsf17gRUO0Ol3RdBmw8i/iZUH1?=
 =?us-ascii?Q?UbmakrNiJ1BbMMxbYxNLb8RcsBwP0W51kQijrSx2?=
X-OriginatorOrg: vivo.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 5b5c8910-b04f-4607-0f38-08dc19c6657f
X-MS-Exchange-CrossTenant-AuthSource: TY2PR06MB3342.apcprd06.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 20 Jan 2024 14:45:07.8486
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 923e42dc-48d5-4cbe-b582-1a797a6412ed
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: U4jH9B2/rFYl11eev7xFlftFmOpz9OrtDbHMRijCkxTjuiR3bwUunZVnG3zVZp+HC/Qjn3+vDi4t4EHylb4MqQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SG2PR06MB5059
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

Even with inplace decompression, sometimes extra temporary buffers are
still needed for decompression.  In low-memory scenarios, it would be
better to try to allocate with GFP_NOWAIT on readahead first. That can
help reduce the time spent on page allocation under memory pressure.

There is an average reduction of 21% in page allocation time under
multi-app launch benchmark workload [1] on ARM64 Android devices running
the 5.15 kernel with an 8-core CPU and 8GB of memory.

[1] https://lore.kernel.org/r/20240109074143.4138783-1-guochunhai@vivo.com

Suggested-by: Gao Xiang <xiang@kernel.org>
Signed-off-by: Chunhai Guo <guochunhai@vivo.com>
---
 fs/erofs/compress.h             |  5 ++---
 fs/erofs/decompressor.c         |  5 +++--
 fs/erofs/decompressor_deflate.c | 19 +++++++++++++------
 fs/erofs/decompressor_lzma.c    | 17 ++++++++++++-----
 fs/erofs/zdata.c                | 16 ++++++++++++----
 5 files changed, 42 insertions(+), 20 deletions(-)

diff --git a/fs/erofs/compress.h b/fs/erofs/compress.h
index 279933e007d2..7cc5841577b2 100644
--- a/fs/erofs/compress.h
+++ b/fs/erofs/compress.h
@@ -11,13 +11,12 @@
 struct z_erofs_decompress_req {
 	struct super_block *sb;
 	struct page **in, **out;
-
 	unsigned short pageofs_in, pageofs_out;
 	unsigned int inputsize, outputsize;
 
-	/* indicate the algorithm will be used for decompression */
-	unsigned int alg;
+	unsigned int alg;       /* the algorithm for decompression */
 	bool inplace_io, partial_decoding, fillgaps;
+	gfp_t gfp;      /* allocation flags for extra temporary buffers */
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
index 4a64a9c91dd3..b98872058abe 100644
--- a/fs/erofs/decompressor_deflate.c
+++ b/fs/erofs/decompressor_deflate.c
@@ -95,7 +95,7 @@ int z_erofs_load_deflate_config(struct super_block *sb,
 }
 
 int z_erofs_deflate_decompress(struct z_erofs_decompress_req *rq,
-			       struct page **pagepool)
+			       struct page **pgpl)
 {
 	const unsigned int nrpages_out =
 		PAGE_ALIGN(rq->pageofs_out + rq->outputsize) >> PAGE_SHIFT;
@@ -158,8 +158,12 @@ int z_erofs_deflate_decompress(struct z_erofs_decompress_req *rq,
 			strm->z.avail_out = min_t(u32, outsz, PAGE_SIZE - pofs);
 			outsz -= strm->z.avail_out;
 			if (!rq->out[no]) {
-				rq->out[no] = erofs_allocpage(pagepool,
-						GFP_KERNEL | __GFP_NOFAIL);
+				rq->out[no] = erofs_allocpage(pgpl, rq->gfp);
+				if (!rq->out[no]) {
+					kout = NULL;
+					err = -ENOMEM;
+					break;
+				}
 				set_page_private(rq->out[no],
 						 Z_EROFS_SHORTLIVED_PAGE);
 			}
@@ -211,8 +215,11 @@ int z_erofs_deflate_decompress(struct z_erofs_decompress_req *rq,
 
 			DBG_BUGON(erofs_page_is_managed(EROFS_SB(sb),
 							rq->in[j]));
-			tmppage = erofs_allocpage(pagepool,
-						  GFP_KERNEL | __GFP_NOFAIL);
+			tmppage = erofs_allocpage(pgpl, rq->gfp);
+			if (!tmppage) {
+				err = -ENOMEM;
+				goto failed;
+			}
 			set_page_private(tmppage, Z_EROFS_SHORTLIVED_PAGE);
 			copy_highpage(tmppage, rq->in[j]);
 			rq->in[j] = tmppage;
@@ -230,7 +237,7 @@ int z_erofs_deflate_decompress(struct z_erofs_decompress_req *rq,
 			break;
 		}
 	}
-
+failed:
 	if (zlib_inflateEnd(&strm->z) != Z_OK && !err)
 		err = -EIO;
 	if (kout)
diff --git a/fs/erofs/decompressor_lzma.c b/fs/erofs/decompressor_lzma.c
index 2dd14f99c1dc..6ca357d83cfa 100644
--- a/fs/erofs/decompressor_lzma.c
+++ b/fs/erofs/decompressor_lzma.c
@@ -148,7 +148,7 @@ int z_erofs_load_lzma_config(struct super_block *sb,
 }
 
 int z_erofs_lzma_decompress(struct z_erofs_decompress_req *rq,
-			    struct page **pagepool)
+			    struct page **pgpl)
 {
 	const unsigned int nrpages_out =
 		PAGE_ALIGN(rq->pageofs_out + rq->outputsize) >> PAGE_SHIFT;
@@ -215,8 +215,11 @@ int z_erofs_lzma_decompress(struct z_erofs_decompress_req *rq,
 						   PAGE_SIZE - pageofs);
 			outlen -= strm->buf.out_size;
 			if (!rq->out[no] && rq->fillgaps) {	/* deduped */
-				rq->out[no] = erofs_allocpage(pagepool,
-						GFP_KERNEL | __GFP_NOFAIL);
+				rq->out[no] = erofs_allocpage(pgpl, rq->gfp);
+				if (!rq->out[no]) {
+					err = -ENOMEM;
+					break;
+				}
 				set_page_private(rq->out[no],
 						 Z_EROFS_SHORTLIVED_PAGE);
 			}
@@ -258,8 +261,11 @@ int z_erofs_lzma_decompress(struct z_erofs_decompress_req *rq,
 
 			DBG_BUGON(erofs_page_is_managed(EROFS_SB(rq->sb),
 							rq->in[j]));
-			tmppage = erofs_allocpage(pagepool,
-						  GFP_KERNEL | __GFP_NOFAIL);
+			tmppage = erofs_allocpage(pgpl, rq->gfp);
+			if (!tmppage) {
+				err = -ENOMEM;
+				goto failed;
+			}
 			set_page_private(tmppage, Z_EROFS_SHORTLIVED_PAGE);
 			copy_highpage(tmppage, rq->in[j]);
 			rq->in[j] = tmppage;
@@ -277,6 +283,7 @@ int z_erofs_lzma_decompress(struct z_erofs_decompress_req *rq,
 			break;
 		}
 	}
+failed:
 	if (no < nrpages_out && strm->buf.out)
 		kunmap(rq->out[no]);
 	if (ni < nrpages_in)
diff --git a/fs/erofs/zdata.c b/fs/erofs/zdata.c
index 692c0c39be63..a293de2a60ed 100644
--- a/fs/erofs/zdata.c
+++ b/fs/erofs/zdata.c
@@ -82,6 +82,9 @@ struct z_erofs_pcluster {
 	/* L: indicate several pageofs_outs or not */
 	bool multibases;
 
+	/* L: whether extra buffer allocations are best-effort */
+	bool besteffort;
+
 	/* A: compressed bvecs (can be cached or inplaced pages) */
 	struct z_erofs_bvec compressed_bvecs[];
 };
@@ -964,7 +967,7 @@ static int z_erofs_read_fragment(struct super_block *sb, struct page *page,
 }
 
 static int z_erofs_do_read_page(struct z_erofs_decompress_frontend *fe,
-				struct page *page)
+				struct page *page, bool ra)
 {
 	struct inode *const inode = fe->inode;
 	struct erofs_map_blocks *const map = &fe->map;
@@ -1014,6 +1017,7 @@ static int z_erofs_do_read_page(struct z_erofs_decompress_frontend *fe,
 		err = z_erofs_pcluster_begin(fe);
 		if (err)
 			goto out;
+		fe->pcl->besteffort |= !ra;
 	}
 
 	/*
@@ -1280,7 +1284,11 @@ static int z_erofs_decompress_pcluster(struct z_erofs_decompress_backend *be,
 					.inplace_io = overlapped,
 					.partial_decoding = pcl->partial,
 					.fillgaps = pcl->multibases,
+					.gfp = pcl->besteffort ?
+						GFP_KERNEL | __GFP_NOFAIL :
+						GFP_NOWAIT | __GFP_NORETRY
 				 }, be->pagepool);
+	pcl->besteffort = false;
 
 	/* must handle all compressed pages before actual file pages */
 	if (z_erofs_is_inline_pcluster(pcl)) {
@@ -1785,7 +1793,7 @@ static void z_erofs_pcluster_readmore(struct z_erofs_decompress_frontend *f,
 			if (PageUptodate(page))
 				unlock_page(page);
 			else
-				(void)z_erofs_do_read_page(f, page);
+				(void)z_erofs_do_read_page(f, page, !!rac);
 			put_page(page);
 		}
 
@@ -1806,7 +1814,7 @@ static int z_erofs_read_folio(struct file *file, struct folio *folio)
 	f.headoffset = (erofs_off_t)folio->index << PAGE_SHIFT;
 
 	z_erofs_pcluster_readmore(&f, NULL, true);
-	err = z_erofs_do_read_page(&f, &folio->page);
+	err = z_erofs_do_read_page(&f, &folio->page, false);
 	z_erofs_pcluster_readmore(&f, NULL, false);
 	z_erofs_pcluster_end(&f);
 
@@ -1847,7 +1855,7 @@ static void z_erofs_readahead(struct readahead_control *rac)
 		folio = head;
 		head = folio_get_private(folio);
 
-		err = z_erofs_do_read_page(&f, &folio->page);
+		err = z_erofs_do_read_page(&f, &folio->page, true);
 		if (err && err != -EINTR)
 			erofs_err(inode->i_sb, "readahead error at folio %lu @ nid %llu",
 				  folio->index, EROFS_I(inode)->nid);
-- 
2.25.1

