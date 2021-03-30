Return-Path: <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>
X-Original-To: lists+linux-erofs@lfdr.de
Delivered-To: lists+linux-erofs@lfdr.de
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2404:9400:2:0:216:3eff:fee1:b9f1])
	by mail.lfdr.de (Postfix) with ESMTPS id 08ED034DD17
	for <lists+linux-erofs@lfdr.de>; Tue, 30 Mar 2021 02:39:48 +0200 (CEST)
Received: from boromir.ozlabs.org (localhost [IPv6:::1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4F8Vvk02hvz3024
	for <lists+linux-erofs@lfdr.de>; Tue, 30 Mar 2021 11:39:46 +1100 (AEDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=lists.ozlabs.org;
	s=201707; t=1617064786;
	bh=7O82z2Yrn9pkY5gYx3Bg3gJVpx8vTkD15U9Bm37pth8=;
	h=To:Subject:Date:In-Reply-To:References:List-Id:List-Unsubscribe:
	 List-Archive:List-Post:List-Help:List-Subscribe:From:Reply-To:Cc:
	 From;
	b=iUSTB0Wurv6s00YCvs/biHVfSVm57XphmbgnFT8w/6zTy0PLm08svHgWjZW4ov/UM
	 lWNLHBPbI9XWKAKuNntcq2tZ5kFajB3ijfnO063tQvmuFqMekzAJyE8Qxw77M1nRgA
	 6Pxmn/0k9AapQewn2oeuu0uS8MLVMxgj+2XB7CViiugPy9LQ9dzV37uvUvyPkjarAK
	 TxI4cCcTtP4/oKy6BkD6t6bzqEkvjp0b9ixUovc4a68mliTJ+dEGmpyA4vy62m0alf
	 j6wZFswzjlUCGqPCgj7KR4M0hkd/jDEKYac4hCToU+DlO2cDzF3JQ1VJ5ITIPAwoaH
	 hVdjbYKHqHfwA==
X-Original-To: linux-erofs@lists.ozlabs.org
Delivered-To: linux-erofs@lists.ozlabs.org
Authentication-Results: lists.ozlabs.org;
 spf=pass (sender SPF authorized) smtp.mailfrom=aol.com
 (client-ip=98.137.65.31; helo=sonic315-55.consmr.mail.gq1.yahoo.com;
 envelope-from=hsiangkao@aol.com; receiver=<UNKNOWN>)
Authentication-Results: lists.ozlabs.org; dkim=pass (2048-bit key;
 unprotected) header.d=aol.com header.i=@aol.com header.a=rsa-sha256
 header.s=a2048 header.b=MCApu114; dkim-atps=neutral
Received: from sonic315-55.consmr.mail.gq1.yahoo.com
 (sonic315-55.consmr.mail.gq1.yahoo.com [98.137.65.31])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 4F8Vvg4pfJz2yqD
 for <linux-erofs@lists.ozlabs.org>; Tue, 30 Mar 2021 11:39:43 +1100 (AEDT)
X-SONIC-DKIM-SIGN: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yahoo.com; s=s2048;
 t=1617064781; bh=YCInyKsJEnkCx0HWUdBdS+9khnY43qCW4wq7wgOOTYz=;
 h=X-Sonic-MF:From:To:Subject:Date:From:Subject;
 b=djzyd+u+WbTjv093OnVpQV54QMyQ0y9LaNQyQ/n2oFWlG06Kw/9VIo39RzjaE9AHE+SNb6aIeKqbRVuz76ybWsLdHhd9pU2OwEu8NoaHkz/j9MXTwU6JDQIXnCWBsNnS0mXdtnFKpXffJ2VEAM3D8tNncYmXbMkuAxva6kg5uVI0fAikbUmdJQl5KqMKwBCrqufgao7nefMI7ZWH37Fdfel9OZTZikwoRpRI+Dhb68mgQaeKE0HjJisgSUnh2QDTA8apNrCOZAJiL1r3cq9dbYJAVQoCFbSk2mA3bO0vCYwtWqwJCbMrjmj96M7F0MKBm7fLNrOcwyEj7uAehn/Pkg==
X-YMail-OSG: AvwLRuwVM1mr3GenEJ3SdvcGwEb3Lbvi.SUEU7EIkxq2RqDzk2dKgvG_W1nVHKF
 sSjuYmk68D7w_XRhmOHNFUU0mJo.flVG7080Ijfbz4f3jY5TeiGiNABkw9Vdm3cE9BlhPm8EZCi0
 jU6fzusNeUG8lp6b0WQdUgaFKeN2InfFk6k88yVPiYChl0yu3NzqRyoiu8HkoXnKW1ipaoU2nO_N
 V2PfGYN5MWM3tiskcCreR1RNiy7A_5wtm4VjM0Pwc0Bd9Clc30hvu0dEs91_5wJlOLeONgCIjsh0
 QpkfTyl.RZrzjyqKwTLNo39hT9ZXd41EvEdV2HTklnB9tw1lzWXm5cbwHYcjDprUFL4W3OwCEwkP
 fNUrdSlTacjdU_THKKWNSYNwLLVlc37z0F4mbp9ERdHp5IXj1Z98tdrXRoVNaZmQcKT9HX5OWQVM
 W2LNGaJ4osTrPa2JceO7FgdEMO9aOa5.9uhihffEeew0ZlVWb4t7_INgD7pogNSeOfebUeZ0JLIA
 obNMQDpP77ZLxs5uEi7pNNL2wNWDQWMMgkCJJ8uNv.XDKvRP9FHdq_7e4GJL.7oqAWPi8ahFfaya
 guTVOaK9gd4h5UD29EcVUBrm7gRzaQEO2uQ53_5ITqL8SeXBIdSQsCGMlHb763tbxaOsOP4vvtr4
 srtm8oa8Ypz_tfiWMdL6w.7nNoM0RVwn7q6rsv47u8yVkjOFXPA6AYySN.etWjPOjkYuMHQxY8BJ
 dbeGH7GDdPLnej4XRK__g3UdfUHo8CmWqBwo4HZhXDH0dGol8BZiEZpwxF8QvaB8a.FawiTLPwgc
 cFm1apiX71BA91PGufdKTg07hOcvUBHMQaM0ddRdkMkItnCs84__TmD2AznGbE.VlXP17sO9EjAE
 1bptTtk_qPrT.7i4gGEu.FdNQIu8MJQ05p.r88WwtFJskhMJTSyvgXJNeMtWSpgIGembk7Ke2QY7
 .mnSNjbveX9HQrtSXAk2JHmbnvOr_KyjrfvUEc777dBuigiJFCRmw4fwv7czU_7mzWNal4oh6yjH
 TTKQlyJ6Ax4OgbNYv0pRQACozpZgVJr70DrhKEjHd8wwCsaaIUhkFvIMsHC5DncBtGSoqWvoYrcV
 FbHs8Eyg6.Bg8pvufphFvuHBJMEzPJgbRPeOv64lTkBxNxh59omwJCRqNV.eEBuzNWDQN5pgckXM
 W7knOqa8WrLLe5jTN9kYzxQD1vYWhSE29C52mqvSAYSUKXTOrLttWPAyOXuAqG.5VIqLuAfOROGx
 mimSk.NG3zZh3r.QTflmaY3xZ40Wm9QjnesU11S0xawOZmhtQ3wsMFPxUcJzAr2KJHKcoAVxhHmW
 jkt_rTGjKzVEakPRptwomRECw0T81fi07hO6VoI2VEIfdL6VbpLB5zZy.OZx3adYx7vJwRl4q4WY
 FdyvS4UrSjMSHhD3l7mBQD3uPem.TDm8luwMEkM9lrR6loMG5zxr3J9q1R3SM9byw0sUTkFJfPjf
 EE8PYEy6ft6INCBgwpJFGQMlaoh7ofdz1f1GHmlbrDNtYLmCnu4_RgZZe9RTRSriUSEo7efgAbwi
 GVg0dJmNHRtaaAY7Fd9FRHf0rLNl26TFn80SjqduCGZ8tDtd5Ht1yd_UwF6b00_JHOkAI1sXDQUQ
 Y36LxrEZWIbomZV0ZT9mosBAm0OWKwwBtiCvUMpelebUq3NK5m2lTbYMb3.8_YVqmKtsPFJp0tH_
 hF4bYASgWQ9BkOxyjtVPmGlrRCBZAqpVXa4oNK9r8YGpdf2HlUm39HTXgd3E39MNFwvUx9LuUr2x
 RDIDGDEeEdgs.lE_GsIHaB0GBU6B3jA9j8oWLkD1CWnuXVZGffPU.oZj8sKJUoEgVCgaY3Oz6H1w
 uQqmTtuwcwCZYlZNBf92jYtxNYxEswi7ko2O_b1L.0yBs85HoUWy7q3S8uH7cURy_.ZQM6WCEJbi
 4zjGBHI_0U5zafkVbRTBEkQGqP34tMqDMP2QIuqYF76QPzXPpjI00lyHh7HtZREdNAA5dsQaPTtf
 HeqiSoaAsI2uPQxsjEt2BQnd1v9KfNTeqRU.BWGnOObMu.ikDad54xua1rp5WHE.sxY3URI9g0_F
 GgA0kF0Ev7toSBEgIsEosfVY3nKUA9u5yL5Y6DG1TEgs2UOXVwGH2dDMERsvNE_u7qJ9sVzX7DVL
 iP9Bsc.TVimgymIXpTvYvIozFC1JzgkyfE_.AOu2ZglRJ_gOTgMooygD3Ki83ntWbNW6q4XOT.Tc
 j.Fvw4akpebAI01K9yuxT2bWlaCME98oQ66Mb7YhpDeP.kCblsJNrgMZ1WKFFz1uUzoxVa6cilBu
 A8Zr5_vpiHwK7dn5tw8qTJ9z3pHzbgFy48WiTU5M8h0_zZBgLxuBvm4jA4XpT9bEcofsTOXWe4dl
 52MSTlRzYX.3kGWIQuOVtcd_H25qe8D9AjL69i9fcWm70XHD48aRGjn4khLtvL5HpUC43SJmrzkX
 xEH0Z74gRzZHUHoF7LzhagNNhkbqZdAAnPvsQZ3YsXW_AIDK1vsmRzSD70OkYZ.M29S2IGFnzmfK
 Tc2nAdq2X20slPOfeRrF2Hj3mnB1OtOxsnb3uJeLRjuECyVkF7JPdDJJTbYXmFkSeOc6GXp6VOrZ
 Kzq7mn8Eowk7O7yCxFAx62kcX_OET3UnWVRnBw7UZ53_VT2vJBXyPSOHfn9u.D4ogAkefwrIpmo4
 d03J4HIaxeYWCX.v0pyqYGZv.6yV.IYHIrx_puOQA6EKMTqc_LoGMSNu.MJztWaxqy61Uy8ZB6zY
 W3ih_2aZssdSqeq5bQNg7naTyuz6KGnJPgya1zo637GRZzYGwZAMP3P5MC0l6wmit4nNDpQUALMG
 BmerIrFuTN70HmJpfp9PNPm7m4tctU6qYzXopxunTZdwqhgLyA1W0mW.Nv2fCMEtgW8xftSS5dlT
 88kqREPgUeRlS_YwOnbPdhT.X83sRBR7MQ4yJ81C4FmPgA2.NcHCEwaEXm.zyml4Xx1SAiTyGKtz
 R4teqJL1zrzBDjCFN38SCpVVzVpgcEqiTiBa7RquEnSa0OyWyx2cvD4NaxHkNdlN2dRwvusm1ryg
 yagohFgg7Jd_sZTKwzWcsQPqbpUyRmDxMcGw_ccU6omTMr9BEx2XSahZL46jkW7kdWaP3uKu8OEH
 dm4WL0x20fecbBUSZMZdyzuVjGYGnwBJB_TuIBMuDB4.5x04vDnvjTqhLhSFM7OUgalSpxf7YjRt
 sipjyag--
X-Sonic-MF: <hsiangkao@aol.com>
Received: from sonic.gate.mail.ne1.yahoo.com by
 sonic315.consmr.mail.gq1.yahoo.com with HTTP; Tue, 30 Mar 2021 00:39:41 +0000
Received: by kubenode579.mail-prod1.omega.gq1.yahoo.com (VZM Hermes SMTP
 Server) with ESMTPA ID 27cc0a93ae52fff3a17931d8aba7bccb; 
 Tue, 30 Mar 2021 00:39:38 +0000 (UTC)
To: linux-erofs@lists.ozlabs.org, Chao Yu <yuchao0@huawei.com>,
 Chao Yu <chao@kernel.org>
Subject: [PATCH 04/10] erofs: fix up inplace I/O pointer for big pcluster
Date: Tue, 30 Mar 2021 08:39:02 +0800
Message-Id: <20210330003908.22842-5-hsiangkao@aol.com>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20210330003908.22842-1-hsiangkao@aol.com>
References: <20210330003908.22842-1-hsiangkao@aol.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
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
From: Gao Xiang via Linux-erofs <linux-erofs@lists.ozlabs.org>
Reply-To: Gao Xiang <hsiangkao@aol.com>
Cc: nl6720 <nl6720@gmail.com>, Lasse Collin <lasse.collin@tukaani.org>,
 LKML <linux-kernel@vger.kernel.org>, Guo Weichao <guoweichao@oppo.com>,
 Miao Xie <miaoxie@huawei.com>
Errors-To: linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org
Sender: "Linux-erofs"
 <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>

From: Gao Xiang <hsiangkao@redhat.com>

When picking up inplace I/O pages, it should be traversed in reverse
order in aligned with the traversal order of file-backed online pages.
Also, index should be updated together when preloading compressed pages.

Previously, only page-sized pclustersize was supported so no problem
at all. Also rename `compressedpages' to `icpage_ptr' to reflect its
functionality.

Signed-off-by: Gao Xiang <hsiangkao@redhat.com>
---
 fs/erofs/zdata.c | 28 ++++++++++++++--------------
 1 file changed, 14 insertions(+), 14 deletions(-)

diff --git a/fs/erofs/zdata.c b/fs/erofs/zdata.c
index 7f572086b4e3..03f106ead8d2 100644
--- a/fs/erofs/zdata.c
+++ b/fs/erofs/zdata.c
@@ -204,7 +204,8 @@ struct z_erofs_collector {
 
 	struct z_erofs_pcluster *pcl, *tailpcl;
 	struct z_erofs_collection *cl;
-	struct page **compressedpages;
+	/* a pointer used to pick up inplace I/O pages */
+	struct page **icpage_ptr;
 	z_erofs_next_pcluster_t owned_head;
 
 	enum z_erofs_collectmode mode;
@@ -238,17 +239,19 @@ static void preload_compressed_pages(struct z_erofs_collector *clt,
 				     enum z_erofs_cache_alloctype type,
 				     struct list_head *pagepool)
 {
-	const struct z_erofs_pcluster *pcl = clt->pcl;
-	struct page **pages = clt->compressedpages;
-	pgoff_t index = pcl->obj.index + (pages - pcl->compressed_pages);
+	struct z_erofs_pcluster *pcl = clt->pcl;
 	bool standalone = true;
 	gfp_t gfp = (mapping_gfp_mask(mc) & ~__GFP_DIRECT_RECLAIM) |
 			__GFP_NOMEMALLOC | __GFP_NORETRY | __GFP_NOWARN;
+	struct page **pages;
+	pgoff_t index;
 
 	if (clt->mode < COLLECT_PRIMARY_FOLLOWED)
 		return;
 
-	for (; pages < pcl->compressed_pages + pcl->pclusterpages; ++pages) {
+	pages = pcl->compressed_pages;
+	index = pcl->obj.index;
+	for (; index < pcl->obj.index + pcl->pclusterpages; ++index, ++pages) {
 		struct page *page;
 		compressed_page_t t;
 		struct page *newpage = NULL;
@@ -360,16 +363,14 @@ int erofs_try_to_free_cached_page(struct address_space *mapping,
 }
 
 /* page_type must be Z_EROFS_PAGE_TYPE_EXCLUSIVE */
-static inline bool z_erofs_try_inplace_io(struct z_erofs_collector *clt,
-					  struct page *page)
+static bool z_erofs_try_inplace_io(struct z_erofs_collector *clt,
+				   struct page *page)
 {
 	struct z_erofs_pcluster *const pcl = clt->pcl;
 
-	while (clt->compressedpages <
-	       pcl->compressed_pages + pcl->pclusterpages) {
-		if (!cmpxchg(clt->compressedpages++, NULL, page))
+	while (clt->icpage_ptr > pcl->compressed_pages)
+		if (!cmpxchg(--clt->icpage_ptr, NULL, page))
 			return true;
-	}
 	return false;
 }
 
@@ -576,9 +577,8 @@ static int z_erofs_collector_begin(struct z_erofs_collector *clt,
 	z_erofs_pagevec_ctor_init(&clt->vector, Z_EROFS_NR_INLINE_PAGEVECS,
 				  clt->cl->pagevec, clt->cl->vcnt);
 
-	clt->compressedpages = clt->pcl->compressed_pages;
-	if (clt->mode <= COLLECT_PRIMARY) /* cannot do in-place I/O */
-		clt->compressedpages += clt->pcl->pclusterpages;
+	/* since file-backed online pages are traversed in reverse order */
+	clt->icpage_ptr = clt->pcl->compressed_pages + clt->pcl->pclusterpages;
 	return 0;
 }
 
-- 
2.20.1

