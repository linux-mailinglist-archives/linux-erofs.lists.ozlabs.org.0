Return-Path: <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>
X-Original-To: lists+linux-erofs@lfdr.de
Delivered-To: lists+linux-erofs@lfdr.de
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	by mail.lfdr.de (Postfix) with ESMTPS id A790B32F828
	for <lists+linux-erofs@lfdr.de>; Sat,  6 Mar 2021 05:05:08 +0100 (CET)
Received: from boromir.ozlabs.org (localhost [IPv6:::1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4Dsrbk2QPVz3dC9
	for <lists+linux-erofs@lfdr.de>; Sat,  6 Mar 2021 15:05:06 +1100 (AEDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=lists.ozlabs.org;
	s=201707; t=1615003506;
	bh=5xCAjFV02GYYen6UTXN4SrBhgC7CieWo2gsnput/pug=;
	h=To:Subject:Date:In-Reply-To:References:List-Id:List-Unsubscribe:
	 List-Archive:List-Post:List-Help:List-Subscribe:From:Reply-To:Cc:
	 From;
	b=Px48PWuXlfEZDLQPgZt027G4nNmeu2ANJC2nuiZYeUywxqiPTHzMRODHm/h9ifDQz
	 VV8bAC1gD/pZI4pnfyl1i3RCIu9xKaAMJSqm/uG2Am8vQ8IKdVjl2Z+iBMTF6Qg+wk
	 HcAV8Bylmivd9aCtFo9VEYf4z8RGXWQp/ykQZEeyQILOLtRl/S/GkffxxtFLfpQ7mJ
	 Hv2uYU5DHnxcx/JvDu0tuS2r9zkzuRHTQENhRj/vpcvQPx7RhPxI+/gvhqMNsU1Dnx
	 HO6mFdgG8mNZN+1FeIIrxbRXuuDBeqG0N5NMaeFiqp3yOrSR0bBh/PN1cn68H+fXMJ
	 HTTaKzrWeBjEA==
X-Original-To: linux-erofs@lists.ozlabs.org
Delivered-To: linux-erofs@lists.ozlabs.org
Authentication-Results: lists.ozlabs.org;
 spf=pass (sender SPF authorized) smtp.mailfrom=aol.com
 (client-ip=98.137.64.204; helo=sonic303-23.consmr.mail.gq1.yahoo.com;
 envelope-from=hsiangkao@aol.com; receiver=<UNKNOWN>)
Authentication-Results: lists.ozlabs.org; dkim=pass (2048-bit key;
 unprotected) header.d=aol.com header.i=@aol.com header.a=rsa-sha256
 header.s=a2048 header.b=T5OBCQbN; dkim-atps=neutral
Received: from sonic303-23.consmr.mail.gq1.yahoo.com
 (sonic303-23.consmr.mail.gq1.yahoo.com [98.137.64.204])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 4Dsrbg6bXjz3ckR
 for <linux-erofs@lists.ozlabs.org>; Sat,  6 Mar 2021 15:05:00 +1100 (AEDT)
X-SONIC-DKIM-SIGN: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yahoo.com; s=s2048;
 t=1615003495; bh=ZSrR6YgRFqTlEYl1tOnFFtuXRFKzcCifZOKhjAKlxsn=;
 h=X-Sonic-MF:From:To:Subject:Date:From:Subject;
 b=OjZaefhqdaDzoQXOWS9fIcpmx+evN2lOdiusRxcNgrC5+Fd/1f6kc5NkeqB6xJd1eR5GxcbembOqN1za236RQXRzEQmpHkHhF2nqq7eP7IUiLMoQomqpbGwLZRQQy3W5L1TT4K6nYie3qpF0GgNLWgOvjEpvWpU1u+6RX+0iIyoe4Czq/8F5R5euC0Z6Twh+xgUnLzhBNVVjVigXC2W7mGkMOvwFc+71Grdu9UW7NRA9dGnHTnE0TcY4znhRPN2gEDhCM65Cjd25pmbRvPOUyJIFEt+w7EVkIexQCXPS4gQRXVu7ozFwyD4YidRENLMnEoemCKe1ibPuVYFZOIkA3Q==
X-YMail-OSG: kucRKUwVM1kmlbcKa7NY8l4UABXRQeefKMNhN8lZfYr2dd_.vp9Se78s6YE6VwW
 NFQGWAWoea1GUVgNU19y61W6JK_doAiWgp1GEf6CX59LCXWw7mlq_jwoUGvi608Zi2grl2clT3cs
 kPJF.5irczsNk31lCr918UYb24JDIut1InWQ.tF7sDr4EfP.Dg9nySUYZsMegQT.nGSY2.uusuIK
 C.ZtBklYJynZu5gB4OUpDkOmN_bDJW7Bst8NAm0pFmTnUhgitADjj6ieFeyJJ9wVk8oW1aIL_Q0q
 zejLzvPK5Iz_wbZu8V4XkN_wLuusVUsyZqSdX5Dhf9nOjjRpUkmHXA0Rx9uWaP4JG8W9XbpT66QC
 CzpTkVJHRTfn52HxxB0._Ao19M1YfLX_RrN96dOUT1GwVLzKdQ6TcKbxBnycA8DUVKpso2Nl_0vy
 nZ_OjVea16L10Mqz8fSed1JSXrTUITZf4nH5WTAvUamoaSdxEd4YMo90bqBQcojrIA99.kFXKlT6
 dJCsRe1RniFV0JTd7567ryEUYYmqf1YRbaJaB7e2TcA4WVAKorERNtDHgtGMUVoJUBZsQ6XjQoag
 00HqDHaSRYri3RLyBLMkQ._RV5kfsc8SHQ2TQUt1_BIk2kckYWVgPJovnkhWmog4cn0eSYSlGTpd
 unZwIkft93mm3w4T0J_aBWGm3tYXbTEt09sQ0Fxbi9lGC2TK3Kz1foTXYx3JuvyyYddhzpXIaJi7
 tVxYUno5laTGqND.JCRchxpr35pEJgEYSCHjlLJF2XXC1dMc7Yg4loF8u_ZI0PTc8JVSpHj_o8Z0
 uwUcDXyzJrFGT2YkaVlCG74fvCaXckUhxcipWAtSPD48B87UzRwYJfAXmt.k5Yx7yYG.cgbUvFs.
 N2P7_dGYubeBeRLuve_E76.bvr30btIDz99.iMxeubBQXb8kM.XNN8vofSXd_Ghm4kwKvKxewTbM
 oLtJhLPx297h6vl0_8ZgtRzUonJfyytksuJboBVR6HnV5wVcVeesL8B1btywoxiqtnojrIdRoW6S
 zqlhF846q_ITvFCJnXDFc3TYns6UCb.IEyNTbEuNIL17oycL2gSNUmZAmwO5E_yuhutF74tVb4u.
 Qt1gLnrKlIwdzey_1I2UgKeeG6tIhQLx_pITo4D.Jk1rCDaYJK83hQKx68xQjXE5EjZeVBYex.bO
 rssHevJis0_eUXArZnlq5_bN7pzC_NdQBuJTojLgVJdo5A4s3mPKeVKDtsJ87qdeFW2oA5WYMMxv
 JrBm2ASTfBFJ1BEj5b.AbXjUz301a8tz.KslHd.OeKauFdVZwE.WPOMctZYiQS.QS5QmcF4Fq7bF
 BbKZBWgpr4ZNC.6Vg71vV62Zo6vgb.E5nmq9Kwrlgztdgk6Pzt984ARnTB6TXpE.RmbdLBH0Zhu3
 t7.awqxlRjZA13zRe.nXyvajkHPn9IZRl.inOau49HVZAOJuQlx1Ggk1JcXR0lgFEwlfayxgLW3x
 61Yp1VqH8Itr93vGf_AHd3J625XUWcCBfbnA1uTmgbMn8LfASo4_NBVBx2EkPWDLZWZlGu1iCALr
 iVAPT9hKmjd3cA1cv.F8.HAr89P7H46uwHUoZe5aU7Z6IF9U8wNqLQwHYAdC_GPCNFQMAPa3Juww
 KrkZW.9Dur91mwFD6rvH3AMSUcK1vZzhtOAqZfs98Wkpgj2N4da7Et9IunHxZt8sIZ2HXv49yBEU
 O6w0jbzxzcBZpn0vBfzAsaFtM.5GMWU45CWhbR5mdRHzQpNYsR7ztPEhVUtRZmgtwzS3Cpux_GGm
 i0GP1uZ20PpLOmqEUScCuf33t_DmNJwAHPHvgBsQ2_HIdvPE_O82urPIglfab0GJ6Vk8rfUHGXC8
 GveyTPV.O.JtfICZ5ApO._yEPV5uILPwR4MZiSm3MFqnCz96_9jshBmwCcwcG5pK9541fYUVpURB
 flM..cQeJc05Ql5mpYKr12Q27HqoIwYI3oM7woBrfE0E6BlgIfAkIZMR9w.Erj.LpmsEGihpKUs5
 1jI_IGlFMorqf7jYTW.lQnjyrMkyQTw07u8zOr4BuOHeUrtk7N8ISUM4oWVTCevmIxOyc7fPFV7Y
 Iyx9pIk03Lzt9TcLlz9zs.V0TsPP8kahA.CZRz2UF3Kh9GZK3Gi0raLBCVuwOqY1_7q2Oj.aEaYS
 6zOBbgYNm.VSWI8LE7H7EhhZQuRtX8dhh7jEXpiZ75ibpoxB3z6cowCbXKQnAkZfJu0GkDzf7dgI
 nTzN2qWEXKjUUDMBxLSGbWYb1kQuQLCAuoNY8tGSFPkwH0NJSQxXSwsHxU4wVcvuNvlaEQkrB8x6
 b0ESvbXIvs0WVKmIheMczktXOkt2kBGNcMgIZvBz0IPsPU.ldGXKGFF8tKBoLcI.UeTg4cpC89SW
 RX3m4DLbapv_Q6HQzNtRPfqAaVN8_e_k5Z_xuz401yDQA7uGV1wvC.oJ.a1jWYv0w84PsCzfvpXU
 v98T6KW8FwzpuMbme2hfqzgqQLqkEYX51otzC9npvc1D4W3jdz0dvzqZqdf.dtjL9C9x0a5yjv5M
 2nAHD8wn5k1z7NBENTiuKjnJybWCFLas0F3vWlH9bpcvaq8UYseJy3ElzWo4pOSuwqJ.2Me6cYvJ
 dKfd3_LMmkwMVsT0muLVD2Ma4A.lqlmSZDI57TCx2qeInu08ECJE7
X-Sonic-MF: <hsiangkao@aol.com>
Received: from sonic.gate.mail.ne1.yahoo.com by
 sonic303.consmr.mail.gq1.yahoo.com with HTTP; Sat, 6 Mar 2021 04:04:55 +0000
Received: by kubenode526.mail-prod1.omega.gq1.yahoo.com (VZM Hermes SMTP
 Server) with ESMTPA ID 8c5221a1eae591564358a3225682cbee; 
 Sat, 06 Mar 2021 04:04:53 +0000 (UTC)
To: linux-erofs@lists.ozlabs.org, Chao Yu <yuchao0@huawei.com>,
 Chao Yu <chao@kernel.org>
Subject: [PATCH v2] erofs: fix bio->bi_max_vecs behavior change
Date: Sat,  6 Mar 2021 12:04:38 +0800
Message-Id: <20210306040438.8084-1-hsiangkao@aol.com>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20210306033109.28466-1-hsiangkao@aol.com>
References: <20210306033109.28466-1-hsiangkao@aol.com>
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
Cc: Martin DEVERA <devik@eaxlabs.cz>, linux-kernel@vger.kernel.org
Errors-To: linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org
Sender: "Linux-erofs"
 <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>

From: Gao Xiang <hsiangkao@redhat.com>

Martin reported an issue that directory read could be hung on the
latest -rc kernel with some certain image. The root cause is that
commit baa2c7c97153 ("block: set .bi_max_vecs as actual allocated
vector number") changes .bi_max_vecs behavior. bio->bi_max_vecs
is set as actual allocated vector number rather than the requested
number now.

Let's avoid using .bi_max_vecs completely instead.

Reported-by: Martin DEVERA <devik@eaxlabs.cz>
Signed-off-by: Gao Xiang <hsiangkao@redhat.com>
---
change since v1:
 - since bio->bi_max_vecs doesn't record extent blocks anymore,
   introduce a remaining extent block to avoid extent excess.

 fs/erofs/data.c | 28 +++++++++++-----------------
 1 file changed, 11 insertions(+), 17 deletions(-)

diff --git a/fs/erofs/data.c b/fs/erofs/data.c
index f88851c5c250..1249e74b3bf0 100644
--- a/fs/erofs/data.c
+++ b/fs/erofs/data.c
@@ -129,6 +129,7 @@ static inline struct bio *erofs_read_raw_page(struct bio *bio,
 					      struct page *page,
 					      erofs_off_t *last_block,
 					      unsigned int nblocks,
+					      unsigned int *eblks,
 					      bool ra)
 {
 	struct inode *const inode = mapping->host;
@@ -145,8 +146,7 @@ static inline struct bio *erofs_read_raw_page(struct bio *bio,
 
 	/* note that for readpage case, bio also equals to NULL */
 	if (bio &&
-	    /* not continuous */
-	    *last_block + 1 != current_block) {
+	    (*last_block + 1 != current_block || !*eblks)) {
 submit_bio_retry:
 		submit_bio(bio);
 		bio = NULL;
@@ -216,7 +216,8 @@ static inline struct bio *erofs_read_raw_page(struct bio *bio,
 		if (nblocks > DIV_ROUND_UP(map.m_plen, PAGE_SIZE))
 			nblocks = DIV_ROUND_UP(map.m_plen, PAGE_SIZE);
 
-		bio = bio_alloc(GFP_NOIO, bio_max_segs(nblocks));
+		*eblks = bio_max_segs(nblocks);
+		bio = bio_alloc(GFP_NOIO, *eblks);
 
 		bio->bi_end_io = erofs_readendio;
 		bio_set_dev(bio, sb->s_bdev);
@@ -229,16 +230,8 @@ static inline struct bio *erofs_read_raw_page(struct bio *bio,
 	/* out of the extent or bio is full */
 	if (err < PAGE_SIZE)
 		goto submit_bio_retry;
-
+	--*eblks;
 	*last_block = current_block;
-
-	/* shift in advance in case of it followed by too many gaps */
-	if (bio->bi_iter.bi_size >= bio->bi_max_vecs * PAGE_SIZE) {
-		/* err should reassign to 0 after submitting */
-		err = 0;
-		goto submit_bio_out;
-	}
-
 	return bio;
 
 err_out:
@@ -252,7 +245,6 @@ static inline struct bio *erofs_read_raw_page(struct bio *bio,
 
 	/* if updated manually, continuous pages has a gap */
 	if (bio)
-submit_bio_out:
 		submit_bio(bio);
 	return err ? ERR_PTR(err) : NULL;
 }
@@ -264,23 +256,26 @@ static inline struct bio *erofs_read_raw_page(struct bio *bio,
 static int erofs_raw_access_readpage(struct file *file, struct page *page)
 {
 	erofs_off_t last_block;
+	unsigned int eblks;
 	struct bio *bio;
 
 	trace_erofs_readpage(page, true);
 
 	bio = erofs_read_raw_page(NULL, page->mapping,
-				  page, &last_block, 1, false);
+				  page, &last_block, 1, &eblks, false);
 
 	if (IS_ERR(bio))
 		return PTR_ERR(bio);
 
-	DBG_BUGON(bio);	/* since we have only one bio -- must be NULL */
+	if (bio)
+		submit_bio(bio);
 	return 0;
 }
 
 static void erofs_raw_access_readahead(struct readahead_control *rac)
 {
 	erofs_off_t last_block;
+	unsigned int eblks;
 	struct bio *bio = NULL;
 	struct page *page;
 
@@ -291,7 +286,7 @@ static void erofs_raw_access_readahead(struct readahead_control *rac)
 		prefetchw(&page->flags);
 
 		bio = erofs_read_raw_page(bio, rac->mapping, page, &last_block,
-				readahead_count(rac), true);
+				readahead_count(rac), &eblks, true);
 
 		/* all the page errors are ignored when readahead */
 		if (IS_ERR(bio)) {
@@ -305,7 +300,6 @@ static void erofs_raw_access_readahead(struct readahead_control *rac)
 		put_page(page);
 	}
 
-	/* the rare case (end in gaps) */
 	if (bio)
 		submit_bio(bio);
 }
-- 
2.20.1

