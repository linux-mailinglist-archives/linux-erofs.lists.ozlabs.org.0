Return-Path: <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>
X-Original-To: lists+linux-erofs@lfdr.de
Delivered-To: lists+linux-erofs@lfdr.de
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2404:9400:2:0:216:3eff:fee1:b9f1])
	by mail.lfdr.de (Postfix) with ESMTPS id A46F581F83E
	for <lists+linux-erofs@lfdr.de>; Thu, 28 Dec 2023 13:51:28 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=lists.ozlabs.org;
	s=201707; t=1703767886;
	bh=GoG0Qz8+oCDX0I8ub4hwaRDbLGluH9429zg6WWYL0Zs=;
	h=To:Subject:Date:List-Id:List-Unsubscribe:List-Archive:List-Post:
	 List-Help:List-Subscribe:From:Reply-To:Cc:From;
	b=B4COXwk6Bou62xqUBQ1VegY1yGfHEsN1YEOND19cDRda0Gy4807JmPebbzkfjxvu2
	 bPW6u9s9W51vPlcjSxR9lOVcLiJvZ37o1/6U+q3zSusAsVrEqsEOeHUoFOVZQ4gKbi
	 spKvsD+jx4uB5z3ReORXyjGGv1pO7oJBY2CcfJyrO9DVsK1J6B9PWmUIBp0dQtXwQT
	 FUpSLHH0+xo2S0cF04+Q5MDeAQwv8M+iFSK+XcyHpbChMwG+p+U379DnlVpII2l8yf
	 1gnkeSzcjFi9FKvBFe8VoHfxLmuOk6bNvX+ZLi2OpVBUcfcIMzpfdpygcxYG5Ppy9U
	 minQXA+dHpJOg==
Received: from boromir.ozlabs.org (localhost [IPv6:::1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4T17g21SrNz3bdG
	for <lists+linux-erofs@lfdr.de>; Thu, 28 Dec 2023 23:51:26 +1100 (AEDT)
X-Original-To: linux-erofs@lists.ozlabs.org
Delivered-To: linux-erofs@lists.ozlabs.org
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=vivo.com header.i=@vivo.com header.a=rsa-sha256 header.s=selector2 header.b=WPa1PqAq;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=vivo.com (client-ip=2a01:111:f400:feae::72a; helo=apc01-psa-obe.outbound.protection.outlook.com; envelope-from=guochunhai@vivo.com; receiver=lists.ozlabs.org)
Received: from APC01-PSA-obe.outbound.protection.outlook.com (mail-psaapc01on2072a.outbound.protection.outlook.com [IPv6:2a01:111:f400:feae::72a])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4T17fw6W9Xz2ykn
	for <linux-erofs@lists.ozlabs.org>; Thu, 28 Dec 2023 23:51:18 +1100 (AEDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=YVSl4nheAObbOFyQomf5Hg7VA3TyvbWq31c7RZhY5uhgC00qi+lm/e08+ywD6KJ6uMbnBlDj/SOb2THRbXhYhPaRUDqPR9dU6pZji/F9BaOtvzG0RDkniiI41HjYtc42HgK3zb3FES817iVNL3X8i2cp3GBY41EPNgDqF8FkSdGGZIMqIensDrMHG/++la6ghAE0+yNR0FQ1XSI6l1xhsUptRmJ+WByQn6B0nEXiqw85SJOqFZUJ7pXcRcd/WL21OImrPJk2I8kXNyp0dgWN7bW4fZlN5JzcCg16+oBeqDvmP6JX4E0IRXPsoZnvF8B4xTzj3FuSUOdPB8bdyoTqoA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=GoG0Qz8+oCDX0I8ub4hwaRDbLGluH9429zg6WWYL0Zs=;
 b=L5B/+SgzcC5rCEgMEMfDqT6bVTI+4m9m0ooPxlqahI7QSEBCfCVDtcHb3rWQSlJiCrt+XWcUubI8aH/p8UB2ZTxfnunaLBw8ESJlNFuo7SZ+PlyTAY7yId9F8CZOTlKTDR1QuomWyCb+TyePZ6yxR0kvQHnGU/KAv3MO6MmEjHPWOZqqlpangmvju7Bytlw3XANic4ZeNO07w2X6XVHWCpgC9gffsgy8CjAlFSxthtEQWcH9bZZF7CZWYO2FQVQF6nt2EyQ8oToe5RsUaJMwh5WwkLpydvAkYrrDAMIY3o0Y50r/lPsEmGwJnCBae5yDdK+guth74OGy6Thj4GkGQA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=vivo.com; dmarc=pass action=none header.from=vivo.com;
 dkim=pass header.d=vivo.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=vivo.com;
Received: from TY2PR06MB3342.apcprd06.prod.outlook.com (2603:1096:404:fb::23)
 by SEYPR06MB5111.apcprd06.prod.outlook.com (2603:1096:101:57::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7135.20; Thu, 28 Dec
 2023 12:50:54 +0000
Received: from TY2PR06MB3342.apcprd06.prod.outlook.com
 ([fe80::6d6f:ced1:956e:35ac]) by TY2PR06MB3342.apcprd06.prod.outlook.com
 ([fe80::6d6f:ced1:956e:35ac%3]) with mapi id 15.20.7113.027; Thu, 28 Dec 2023
 12:50:54 +0000
To: xiang@kernel.org,
	chao@kernel.org,
	huyue2@coolpad.com,
	jefflexu@linux.alibaba.com
Subject: [PATCH] erofs: add a global page pool for lz4 decompression
Date: Thu, 28 Dec 2023 06:00:53 -0700
Message-Id: <20231228130053.1911057-1-guochunhai@vivo.com>
X-Mailer: git-send-email 2.25.1
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SI2PR01CA0020.apcprd01.prod.exchangelabs.com
 (2603:1096:4:192::6) To TY2PR06MB3342.apcprd06.prod.outlook.com
 (2603:1096:404:fb::23)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: TY2PR06MB3342:EE_|SEYPR06MB5111:EE_
X-MS-Office365-Filtering-Correlation-Id: 3bb7836b-92c4-492a-f510-08dc07a3a125
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 	hxsCVDhzeEiJJuEEM069jn/PKnECvLmJXvzwvJ07hYWUVRsqXtZD6Mujqr1n6nqrrM8GFwTzVI7XEA/ao5C6idYeUKO4pcEuFCabAzlAUPkarjpyI2FtB1YQofSjisHPpwwp98urTC5ylEAo+q3u9kPMqX4vBrZhdZEyHTx3cCNfFL8mcK/Cl2CZ1WON8HeCnrgDNx6AvgoT84SE9+/ds5fK+aYc+8qNjdyYYGaj/qgnJdVR96iykL7ZI2ds0N7Xksy+u+Ih3WsnRvPknFUuMGb4ji9X0qrAJda5FSpXu66+xb9nYc86RenAHNvVbgVLTfuiuNNDGGZZQEi1wtvkF03xo+60rcaUjMjW0nS5H/RoEAXhiwS2SwwXK0Pb2NaNGB6yTt82py0B3H3WwSuNOk8lpGT75KWxz37jKFRPnuZieu9bWuE23NbrKSHouY3Z2ojyAUHAWkPVdVDUsWW0a4FyjnVmoygWQ2DmmWsw4suTdaS7l0ayNqtcobYjMOdbyPWLH0Uw5UQ/zdwaWNzQhDp+zmMXBxH5dKtrAjepxLEIl8+QqCCTRJtO9LY/UCyDLhJmKTEAj7D7zjPy4kG3TRVfCa3OSUvzweiEh3ar3AA=
X-Forefront-Antispam-Report: 	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:TY2PR06MB3342.apcprd06.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(346002)(39860400002)(396003)(366004)(136003)(376002)(230922051799003)(186009)(64100799003)(451199024)(1800799012)(36756003)(52116002)(6506007)(6512007)(66556008)(66946007)(66476007)(6486002)(86362001)(38350700005)(966005)(38100700002)(1076003)(83380400001)(26005)(2616005)(107886003)(41300700001)(2906002)(5660300002)(4326008)(478600001)(316002)(8936002)(8676002);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 	=?us-ascii?Q?DGYIW49aLvRQSFrWGvTw3qysfwjMXFCvw/kiE/G47+ZiYiO2xpNbIrn3R8sq?=
 =?us-ascii?Q?WV0np2mXBBpBznOCw1+gUlXsiFSbYIHxWzz5KF/1hushE5RZjBDPwzkm9VqK?=
 =?us-ascii?Q?jytxeIKUJVYx/oHtWQTsmC5yDFlfUEWKIU2ufIirA7LeTKjTnKljdzpxYl/s?=
 =?us-ascii?Q?G+aO2Lt4jOvIP+SIsPosI+AYEqrODDeanZMaONu7g4gpD1ZgKARDY+UG10m1?=
 =?us-ascii?Q?2zORKm6X+SVhtPr5a/7RkndPZgqBJ4OxymxjSGG3AWEFjCa4BemRXOJCb43y?=
 =?us-ascii?Q?FVYJ5TIvVFicVcNI5jvKFI2IVuW7yiZkzypC6WcZjRPRn7Ao0IA4M8FfoOum?=
 =?us-ascii?Q?0ZR57I9eGVCv+ABNNJ0XfgpuzKB50J7/w/bP7nqCuCdE7+h2taWm7hZ2Nhnj?=
 =?us-ascii?Q?Derk12KeVqP1BaGl/qgIxEPLv/8AAtN2MRDiLGkEXhHUNR3qZX1Qpa2l1+z4?=
 =?us-ascii?Q?B1hQrjFDXsUx0Yf0E1dNIBsDpZsAtfJSFZPZFzEb/dVOyz73y7n2NTFmKqPG?=
 =?us-ascii?Q?DvsHFC7A48T2rulYxcuhYOANvH+33HEHmn1A3omGYRpQ56EZAux6z8CI/Zok?=
 =?us-ascii?Q?T8ECOX+0S20qzGI2SaSNN93FODQwXgy3NR1+I8BhJ2wyOQsRxupP697dcQMf?=
 =?us-ascii?Q?7xO5Eswi2+wwxS37HKiF5kktbQCZLmR++hsOp7TcfPCOcspRl3CbUXm0cyRE?=
 =?us-ascii?Q?kRqt6AYm4wgbt+b7NjFYRjE9gStrgQsWUxpD52BGdHXlyKu3Nk5aDAOF394j?=
 =?us-ascii?Q?RN9dbT+94egm+J54YpsXC6izwCFRVLvpkb/Pvw+JaxYIJZihMsK04JBKmKsU?=
 =?us-ascii?Q?xEZOGc34AVIuO/yoP3xtxgTU/0He/TJEX+xXggkVTxDs3eRADpRnJ3NZ7pin?=
 =?us-ascii?Q?aCeIWic6VbA9jnvQgXbQbyiuaoLJfK9aQOLxp9tyemrcoPtiDLN7aBkKhGB3?=
 =?us-ascii?Q?LDM/DlmMlnlXn96pbGelQyWbDhRWTfFoDLTrj/Ku9qeLuAUSlZPl/ByAvF2d?=
 =?us-ascii?Q?N0DkVnZbHikkfrD6McnSHb2U2r2lzfTXCNOVWjZtatb9fbr7whiQtFFv4DQP?=
 =?us-ascii?Q?sg8+YBUPRNtSlwjnvPFLa75QQDjWXbClnormH+8tByRdK7rc3bYC+W7fA8KY?=
 =?us-ascii?Q?j2Wt3R3mdPtGs8j2NC/e5uqvpRv8bSImk8beSfqnKmzUd80wA2jZ117X0ppO?=
 =?us-ascii?Q?oG0nNQWSAGbIXIIg773lPH8/qP/npiC/a36IH0LQYf079ml+xy8ZJU5EqRi0?=
 =?us-ascii?Q?SLuNN+dnFVmsRxvi/3Z6wFLD5kPcS/XNoOn0u+tEcQTlYPKXHDnRmV0yEc9S?=
 =?us-ascii?Q?3mf6QrePzDsYNyjxU06gLiNvr4M/6sPR/4VOW+7IJotLA55aMZtLN/XQ33i8?=
 =?us-ascii?Q?ate1963URlKBmECgyYaGVSFGPI/8CI7UXyGfT8kkr2KD/+N3g+TH72N1YgtY?=
 =?us-ascii?Q?SNNYbi/JIgiXQS91yvBbCwMcUZbTV2g5cWakAhAsykSZxpDXHJnNLm1OwAp6?=
 =?us-ascii?Q?GMftW0anb8sDtsVZAA0lLaY81Ik4VvGvgFv812Z5W4+9mG4hf6OoToEAH+Uy?=
 =?us-ascii?Q?OZuOYWrE7q4S6GKoluhP3Hp9UqpEnNxZJP7IA1O7?=
X-OriginatorOrg: vivo.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 3bb7836b-92c4-492a-f510-08dc07a3a125
X-MS-Exchange-CrossTenant-AuthSource: TY2PR06MB3342.apcprd06.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 28 Dec 2023 12:50:54.5850
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 923e42dc-48d5-4cbe-b582-1a797a6412ed
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: GTn29bu8uZMVpOFsy9plCmEp8G+wqBRgEZNzxpVhhNtnb4YobLt1JNeHudl0WIa/IL4HER7comjaCcl8WMFC8w==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SEYPR06MB5111
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
Cc: Chunhai Guo <guochunhai@vivo.com>, linux-erofs@lists.ozlabs.org
Errors-To: linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org
Sender: "Linux-erofs" <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>

Using a global page pool for LZ4 decompression significantly reduces the
time spent on page allocation in low memory scenarios.

The table below shows the reduction in time spent on page allocation for
LZ4 decompression when using a global page pool.
The results were obtained from multi-app launch benchmarks on ARM64
Android devices running the 5.15 kernel.
+--------------+---------------+--------------+---------+
|              | w/o page pool | w/ page pool |  diff   |
+--------------+---------------+--------------+---------+
| Average (ms) |     3434      |      21      | -99.38% |
+--------------+---------------+--------------+---------+

Based on the benchmark logs, it appears that 256 pages are sufficient
for most cases, but this can be adjusted as needed. Additionally,
turning on CONFIG_EROFS_FS_DEBUG will simplify the tuning process.

This patch currently only supports the LZ4 decompressor, other
decompressors will be supported in the next step.

Signed-off-by: Chunhai Guo <guochunhai@vivo.com>
---
 fs/erofs/compress.h     |   1 +
 fs/erofs/decompressor.c |  42 ++++++++++++--
 fs/erofs/internal.h     |   5 ++
 fs/erofs/super.c        |   1 +
 fs/erofs/utils.c        | 121 ++++++++++++++++++++++++++++++++++++++++
 5 files changed, 165 insertions(+), 5 deletions(-)

diff --git a/fs/erofs/compress.h b/fs/erofs/compress.h
index 279933e007d2..67202b97d47b 100644
--- a/fs/erofs/compress.h
+++ b/fs/erofs/compress.h
@@ -31,6 +31,7 @@ struct z_erofs_decompressor {
 /* some special page->private (unsigned long, see below) */
 #define Z_EROFS_SHORTLIVED_PAGE		(-1UL << 2)
 #define Z_EROFS_PREALLOCATED_PAGE	(-2UL << 2)
+#define Z_EROFS_POOL_PAGE		(-3UL << 2)
 
 /*
  * For all pages in a pcluster, page->private should be one of
diff --git a/fs/erofs/decompressor.c b/fs/erofs/decompressor.c
index d08a6ee23ac5..41b34f01416f 100644
--- a/fs/erofs/decompressor.c
+++ b/fs/erofs/decompressor.c
@@ -54,6 +54,7 @@ static int z_erofs_load_lz4_config(struct super_block *sb,
 	sbi->lz4.max_distance_pages = distance ?
 					DIV_ROUND_UP(distance, PAGE_SIZE) + 1 :
 					LZ4_MAX_DISTANCE_PAGES;
+	erofs_global_page_pool_init();
 	return erofs_pcpubuf_growsize(sbi->lz4.max_pclusterblks);
 }
 
@@ -111,15 +112,42 @@ static int z_erofs_lz4_prepare_dstpages(struct z_erofs_lz4_decompress_ctx *ctx,
 			victim = availables[--top];
 			get_page(victim);
 		} else {
-			victim = erofs_allocpage(pagepool,
+			victim = erofs_allocpage_for_decmpr(pagepool,
 						 GFP_KERNEL | __GFP_NOFAIL);
-			set_page_private(victim, Z_EROFS_SHORTLIVED_PAGE);
 		}
 		rq->out[i] = victim;
 	}
 	return kaddr ? 1 : 0;
 }
 
+static void z_erofs_lz4_post_destpages(struct z_erofs_lz4_decompress_ctx *ctx)
+{
+	struct z_erofs_decompress_req *rq = ctx->rq;
+	unsigned int i, j, nrpage;
+	struct page *page_dedup[LZ4_MAX_DISTANCE_PAGES] = { NULL };
+
+	for (i = 0, nrpage = 0; i < ctx->outpages; ++i) {
+		struct page *const page = rq->out[i];
+
+		if (page && page_private(page) == Z_EROFS_POOL_PAGE) {
+			for (j = 0; j < nrpage; ++j) {
+				if (page_dedup[j] == page)
+					break;
+			}
+			if (j == nrpage) {
+				WARN_ON_ONCE(nrpage >= LZ4_MAX_DISTANCE_PAGES);
+				page_dedup[nrpage] = page;
+				nrpage++;
+			} else
+				put_page(page);
+			rq->out[i] = NULL;
+		}
+	}
+
+	for (i = 0; i < nrpage; ++i)
+		erofs_put_page_for_decmpr(page_dedup[i]);
+}
+
 static void *z_erofs_lz4_handle_overlap(struct z_erofs_lz4_decompress_ctx *ctx,
 			void *inpage, void *out, unsigned int *inputmargin,
 			int *maptype, bool may_inplace)
@@ -297,14 +325,16 @@ static int z_erofs_lz4_decompress(struct z_erofs_decompress_req *rq,
 	/* general decoding path which can be used for all cases */
 	ret = z_erofs_lz4_prepare_dstpages(&ctx, pagepool);
 	if (ret < 0) {
-		return ret;
+		goto out;
 	} else if (ret > 0) {
 		dst = page_address(*rq->out);
 		dst_maptype = 1;
 	} else {
 		dst = erofs_vm_map_ram(rq->out, ctx.outpages);
-		if (!dst)
-			return -ENOMEM;
+		if (!dst) {
+			ret = -ENOMEM;
+			goto out;
+		}
 		dst_maptype = 2;
 	}
 
@@ -314,6 +344,8 @@ static int z_erofs_lz4_decompress(struct z_erofs_decompress_req *rq,
 		kunmap_local(dst);
 	else if (dst_maptype == 2)
 		vm_unmap_ram(dst, ctx.outpages);
+out:
+	z_erofs_lz4_post_destpages(&ctx);
 	return ret;
 }
 
diff --git a/fs/erofs/internal.h b/fs/erofs/internal.h
index b0409badb017..d8e5ac30bf62 100644
--- a/fs/erofs/internal.h
+++ b/fs/erofs/internal.h
@@ -534,4 +534,9 @@ static inline void erofs_fscache_unregister_cookie(struct erofs_fscache *fscache
 
 #define EFSCORRUPTED    EUCLEAN         /* Filesystem is corrupted */
 
+int erofs_global_page_pool_init(void);
+void erofs_global_page_pool_exit(void);
+struct page *erofs_allocpage_for_decmpr(struct page **pagepool, gfp_t gfp);
+void erofs_put_page_for_decmpr(struct page *page);
+
 #endif	/* __EROFS_INTERNAL_H */
diff --git a/fs/erofs/super.c b/fs/erofs/super.c
index 3789d6224513..8e50f8dbd8fe 100644
--- a/fs/erofs/super.c
+++ b/fs/erofs/super.c
@@ -940,6 +940,7 @@ static void __exit erofs_module_exit(void)
 	erofs_exit_shrinker();
 	kmem_cache_destroy(erofs_inode_cachep);
 	erofs_pcpubuf_exit();
+	erofs_global_page_pool_exit();
 }
 
 static int erofs_statfs(struct dentry *dentry, struct kstatfs *buf)
diff --git a/fs/erofs/utils.c b/fs/erofs/utils.c
index 5dea308764b4..1bdebe6e682d 100644
--- a/fs/erofs/utils.c
+++ b/fs/erofs/utils.c
@@ -4,6 +4,7 @@
  *             https://www.huawei.com/
  */
 #include "internal.h"
+#include "compress.h"
 
 struct page *erofs_allocpage(struct page **pagepool, gfp_t gfp)
 {
@@ -284,4 +285,124 @@ void erofs_exit_shrinker(void)
 {
 	shrinker_free(erofs_shrinker_info);
 }
+
+struct erofs_page_pool {
+	struct page *pagepool;
+	spinlock_t lock;
+	int nrpages_max;
+#ifdef CONFIG_EROFS_FS_DEBUG
+	int nrpages_cur;
+	int nrpages_min;
+#endif
+};
+
+static struct erofs_page_pool global_page_pool;
+
+struct page *erofs_allocpage_for_decmpr(struct page **pagepool, gfp_t gfp)
+{
+	struct page *page = *pagepool;
+
+	if (page) {
+		DBG_BUGON(page_ref_count(page) != 1);
+		*pagepool = (struct page *)page_private(page);
+		set_page_private(page, Z_EROFS_SHORTLIVED_PAGE);
+	} else {
+		spin_lock(&global_page_pool.lock);
+		page = global_page_pool.pagepool;
+		if (page) {
+			global_page_pool.pagepool =
+				(struct page *)page_private(page);
+			DBG_BUGON(page_ref_count(page) != 1);
+			set_page_private(page, Z_EROFS_POOL_PAGE);
+#ifdef CONFIG_EROFS_FS_DEBUG
+			global_page_pool.nrpages_cur--;
+			if (global_page_pool.nrpages_min
+					> global_page_pool.nrpages_cur) {
+				global_page_pool.nrpages_min
+					= global_page_pool.nrpages_cur;
+				pr_info("erofs global_page_pool nrpages_min %u\n",
+						global_page_pool.nrpages_min);
+			}
+#endif
+			spin_unlock(&global_page_pool.lock);
+		} else {
+			spin_unlock(&global_page_pool.lock);
+			page = alloc_page(gfp);
+			set_page_private(page, Z_EROFS_SHORTLIVED_PAGE);
+		}
+	}
+
+	return page;
+}
+
+/*
+ * This function only releases pages allocated from global page pool.
+ */
+void erofs_put_page_for_decmpr(struct page *page)
+{
+	if (!page)
+		return;
+
+	if (page_private(page) == Z_EROFS_POOL_PAGE) {
+		DBG_BUGON(page_ref_count(page) != 1);
+		spin_lock(&global_page_pool.lock);
+		set_page_private(page,
+				(unsigned long)global_page_pool.pagepool);
+		global_page_pool.pagepool = page;
+#ifdef CONFIG_EROFS_FS_DEBUG
+		global_page_pool.nrpages_cur++;
+#endif
+		spin_unlock(&global_page_pool.lock);
+	}
+}
+
+#define	PAGE_POOL_INIT_PAGES	128
+int erofs_global_page_pool_init(void)
+{
+	int i;
+	struct page *page;
+
+	if (global_page_pool.nrpages_max)
+		return 0;
+
+	spin_lock_init(&global_page_pool.lock);
+	global_page_pool.pagepool = NULL;
+	global_page_pool.nrpages_max = PAGE_POOL_INIT_PAGES;
+#ifdef CONFIG_EROFS_FS_DEBUG
+	global_page_pool.nrpages_min = INT_MAX;
+	global_page_pool.nrpages_cur = 0;
+#endif
+	for (i = 0; i < global_page_pool.nrpages_max; i++) {
+		page = alloc_page(GFP_KERNEL);
+		if (!page) {
+			pr_err("failed to alloc page for erofs page pool\n");
+			return 0;
+		}
+		set_page_private(page,
+				(unsigned long)global_page_pool.pagepool);
+		global_page_pool.pagepool = page;
+#ifdef CONFIG_EROFS_FS_DEBUG
+		global_page_pool.nrpages_cur++;
+#endif
+	}
+
+	return 0;
+}
+
+void erofs_global_page_pool_exit(void)
+{
+	struct page *pagepool = global_page_pool.pagepool;
+
+	while (pagepool) {
+		struct page *page = pagepool;
+
+		pagepool = (struct page *)page_private(page);
+		put_page(page);
+#ifdef CONFIG_EROFS_FS_DEBUG
+		global_page_pool.nrpages_cur--;
+#endif
+	}
+	global_page_pool.nrpages_max = 0;
+}
+
 #endif	/* !CONFIG_EROFS_FS_ZIP */
-- 
2.25.1

