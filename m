Return-Path: <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>
X-Original-To: lists+linux-erofs@lfdr.de
Delivered-To: lists+linux-erofs@lfdr.de
Received: from lists.ozlabs.org (lists.ozlabs.org [203.11.71.2])
	by mail.lfdr.de (Postfix) with ESMTPS id 3573B290892
	for <lists+linux-erofs@lfdr.de>; Fri, 16 Oct 2020 17:36:37 +0200 (CEST)
Received: from bilbo.ozlabs.org (lists.ozlabs.org [IPv6:2401:3900:2:1::3])
	by lists.ozlabs.org (Postfix) with ESMTP id 4CCVcf5WbtzDqfk
	for <lists+linux-erofs@lfdr.de>; Sat, 17 Oct 2020 02:36:34 +1100 (AEDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=lists.ozlabs.org;
	s=201707; t=1602862594;
	bh=4CzmJbzQR8sjvX0RgcwX3oEZRhEVwt3kdGWrFPMBSgk=;
	h=Date:To:Subject:References:In-Reply-To:List-Id:List-Unsubscribe:
	 List-Archive:List-Post:List-Help:List-Subscribe:From:Reply-To:Cc:
	 From;
	b=GCl8DqQD5jAHYaOL1oD0Rx2R0WV7XWu49QWvXJrlJTaC9GDq5tor43vnnnmdE5tbR
	 3DB8UPihy9KzwhXtoqIa5DjQbj+lUaL+CP+AbKv3VCe9Tn1eRlCDmBe55iQRj/qg/G
	 6Sz5q69iR66jYP9UXnLmm4ofTmXt8dUXLvEs9qG/8Kx8Rq4joZ0GAjD/AwGDBjpTDa
	 Dexf/Bjo2evJAf8VItzP2e0EfJ2n4Ts/Xodj6x9mBENZBCZ5fc6V48Qk9At3NP9e3L
	 0W4G5VT6rhQ8nK1K57wVWOVXlUy0E+8hf7N96T9Y5XiDtGDx9vciOKUE0Q+Ap48tCc
	 pCI2VSJu3XyTw==
X-Original-To: linux-erofs@lists.ozlabs.org
Delivered-To: linux-erofs@lists.ozlabs.org
Authentication-Results: lists.ozlabs.org;
 spf=pass (sender SPF authorized) smtp.mailfrom=aol.com
 (client-ip=98.137.68.31; helo=sonic308-55.consmr.mail.gq1.yahoo.com;
 envelope-from=hsiangkao@aol.com; receiver=<UNKNOWN>)
Authentication-Results: lists.ozlabs.org;
 dmarc=pass (p=reject dis=none) header.from=aol.com
Authentication-Results: lists.ozlabs.org; dkim=pass (2048-bit key;
 unprotected) header.d=aol.com header.i=@aol.com header.a=rsa-sha256
 header.s=a2048 header.b=U0/4LDyh; dkim-atps=neutral
Received: from sonic308-55.consmr.mail.gq1.yahoo.com
 (sonic308-55.consmr.mail.gq1.yahoo.com [98.137.68.31])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 4CCVcW06J8zDqXd
 for <linux-erofs@lists.ozlabs.org>; Sat, 17 Oct 2020 02:36:23 +1100 (AEDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=aol.com; s=a2048;
 t=1602862577; bh=ZiJKNwL2TlpPzvJAZErQ9+nOPQOGzuObcF98mD7YBfs=;
 h=Date:From:To:Cc:Subject:References:In-Reply-To:From:Subject;
 b=U0/4LDyhKIhTYs3ML4OH8A9vUZUpyCe+LNdZl3PUMBuwHfiMhxYv9uDF4JuuCsBpm44auej6l7mxfIl1H2JWldQjCQPJOYAlDSMrfEQm3cIgxNlucTtwXsqrEYU6cMcyPwvEbi7liYoeGx37vNJxG2WnCGFI2/wWpIgV11GxayGF074vWpBWx6qIvGDkxurW6Fsgl6lsB8RJI6b9/dDFzMuzToDOaHn3MAkgx8R6JDj0xpymSmV65TtB9Pi8BZVnAgTWLbN6jLdULPPNwEr5vvW4QceXVw8VCC8XxGIsvm3zmQfde+KkRvoAuj0J2wsQ6ALcAG0VO4eiAtbdydJWww==
X-YMail-OSG: NX3AsmYVM1lsWZQhXw.rBqGPQhm_1HqugyujZzGBn7Nig1aqMJK3c6fNEmlbBIP
 bU_0cVTKJfDwERMgiQj.2.ccQMWhH11PaBU_aBbM_kHbYSVeEkjSFE3ZcO8cdWK54TgNcbrajNXZ
 CeyUdeOqv8UbkwUAvOzifvluuY7vGpCQPZ97k5py5MJDALGfVHYlAANKOCaX3SrCAcdWM.gU1EuY
 0aHf_4C7pAW13hyrznxq8RyKaJCKOr9aWb2MXft7GRbUDyxSMfcxy0tIHZkg.18AosrHQYW8rYAe
 usbD0C7UGj2gdA_6msHdIoBwWS3xoFqgrJ4QI7Pa.ysnHcCp.t1HfAE.ouoEwFEQB2JrzZv90hMm
 GZfM9u5b9VCQl.a42aw95RJJxkiZky9e7vuKDOmb4.YBd2yFt1uJNbLJBGefi21FXdRh92BaV1px
 A.9FjJi8o44J4hU5cFhXvduTbaGlJBhsG7Xz21sN9IhFFqn4.hdX.Qtj_VqdiITUO2WFWq4fZ.21
 esCy4JcKPhjGySluYjOZh2wFaBJJn3iRUbzEz_csgX0J4wGhtEHz._9lLR0biEsuMjyAF3Nv2nx0
 kBPmR.MG2mohA8fs425NX4HWRSBxyagkFopbHQuFBASlYFvEBaatzvs9tbtxKGrdr3kZrJTuiZfL
 7JvCTmY2ty.sDudqZeHrfgMm9MqnmARlaZOWaFnv.xFIh2Uk7QvU7C_UapyDFcU4nIfvsTud5o0a
 BGpdXKdsAf9BtMknTuv3pSAA9251OvOZCdszSjdB5abUnogg6oZWG40DoQvQHUwO3x6rLewvi4OG
 jfutLpRpOVitBUsK4uD_MuUj.bbm_XYNzz9M0..sa2d4Nh55xxFoVozm9MqrU_FkaBWT0PGzwYRA
 ZBzYnjbkPRxOThMjqgMyCQ23MNrz6gn6HOhz_QTsOFeD962juzZLKJtOPG2vBSFhFsOtotX_RHrx
 RpkeyTclr6VvhaG.ZaMV7NS8c7_TzM2gZydW8zMEKV1y5c69GF7FQVbzzkGpO6Qn77BEO76lJiu.
 TnCr1e6A7u_wgvPJfYfkBjpdAtjdIqPVR9p0BIsCDEG_SobS9oXaOPRyj60Hv.jFzL6K1wHSz2Pr
 rgP3zwrJ4lCM4pqDNBbtGnmo_CrLOaxzk0n2DsFNl75Vm3pVhsBqBH6eh0XXWRgsUwuZNlrupfAQ
 3Ot2rfzt1Ts.lurI_AMGvirOOWKdzfxeHkqXQIJ3nu0Hu9wRDk.wH5Rw781e8FCpv.qciOgIxBlu
 hN567Hqco9lbr.T3CTPygDOsYKnlee30RloBvtvNe25obgg6Ngqnjs6r1pkduX0IWkf3AjM8qNPD
 FfNrNjPmiClQDr7yMQsx5KpqtLgiJt5cnz33PagKSxD7iyCYN9wJ2_Y4T8F4eTIRDfutF6S3FdnK
 ZxuqDwi.o7UozDrLqorEIvKtvovOF4nxDhoc8.FnGXgxmWBz_hhMeTiJLkkXO7ijeCIpG_CI5j3.
 ZWnznyynJ2q12pZejLA5bzCjnb4djV1487OIgBX3.bSQEp92bymnIUA--
Received: from sonic.gate.mail.ne1.yahoo.com by
 sonic308.consmr.mail.gq1.yahoo.com with HTTP; Fri, 16 Oct 2020 15:36:17 +0000
Received: by smtp416.mail.ir2.yahoo.com (VZM Hermes SMTP Server) with ESMTPA
 ID 03ad07880c256e8a54dd762dd6640661; 
 Fri, 16 Oct 2020 15:36:14 +0000 (UTC)
Date: Fri, 16 Oct 2020 23:36:03 +0800
To: Huang Jianan <jnhuang95@gmail.com>
Subject: Re: [PATCH 3/5] erofs-utils: fix the wrong address of inline dir
 content.
Message-ID: <20201016153559.GA32727@hsiangkao-HP-ZHAN-66-Pro-G1>
References: <20201015133959.61007-1-huangjianan@oppo.com>
 <20201015133959.61007-3-huangjianan@oppo.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20201015133959.61007-3-huangjianan@oppo.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
X-Mailer: WebService/1.1.16868
 mail.backend.jedi.jws.acl:role.jedi.acl.token.atz.jws.hermes.aol
 Apache-HttpAsyncClient/4.1.4 (Java/11.0.7)
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
Cc: guoweichao@oppo.com, linux-erofs@lists.ozlabs.org, zhangshiming@oppo.com
Errors-To: linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org
Sender: "Linux-erofs"
 <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>

On Thu, Oct 15, 2020 at 09:39:57PM +0800, Huang Jianan wrote:
> Signed-off-by: Huang Jianan <huangjianan@oppo.com>
> Signed-off-by: Guo Weichao <guoweichao@oppo.com>
> ---
>  fuse/namei.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/fuse/namei.c b/fuse/namei.c
> index 21e6ba0..3503a8d 100644
> --- a/fuse/namei.c
> +++ b/fuse/namei.c
> @@ -158,7 +158,7 @@ struct dcache_entry *disk_lookup(struct dcache_entry *parent, const char *name,
>  	if (v.datalayout == EROFS_INODE_FLAT_INLINE) {
>  		uint32_t dir_off = erofs_blkoff(dirsize);
>  		off_t dir_addr = nid2addr(dcache_get_nid(parent))
> -			+ sizeof(struct erofs_inode_compact);
> +			+ sizeof(struct erofs_inode_compact) + v.xattr_isize;

hmm... just considering this line, I think it should be

+               off_t dir_addr = nid2addr(dcache_get_nid(parent)) +
+                       v.inode_isize + v.xattr_isize;

btw, I've fixed it, will send out the next integrated WIP
erofsfuse patchset.

Thanks,
Gao Xiang

>  
>  		memset(buf, 0, sizeof(buf));
>  		ret = dev_read(buf, dir_off, dir_addr);
> -- 
> 2.25.1
> 
