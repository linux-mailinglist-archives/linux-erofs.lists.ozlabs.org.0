Return-Path: <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>
X-Original-To: lists+linux-erofs@lfdr.de
Delivered-To: lists+linux-erofs@lfdr.de
Received: from lists.ozlabs.org (lists.ozlabs.org [203.11.71.2])
	by mail.lfdr.de (Postfix) with ESMTPS id 37ACAD6C41
	for <lists+linux-erofs@lfdr.de>; Tue, 15 Oct 2019 01:55:38 +0200 (CEST)
Received: from bilbo.ozlabs.org (lists.ozlabs.org [IPv6:2401:3900:2:1::3])
	by lists.ozlabs.org (Postfix) with ESMTP id 46sb6H46NFzDqvy
	for <lists+linux-erofs@lfdr.de>; Tue, 15 Oct 2019 10:55:35 +1100 (AEDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=lists.ozlabs.org;
	s=201707; t=1571097335;
	bh=4komK6VdWfvrNI+YSGxbS0RxExNgPQPk32Nj35WihXo=;
	h=Date:To:Subject:References:In-Reply-To:List-Id:List-Unsubscribe:
	 List-Archive:List-Post:List-Help:List-Subscribe:From:Reply-To:Cc:
	 From;
	b=DCJ5FbhC+EvSGHORYF3tj4/rUSee778wgoVPu5rrIaYNc7kY9rVvSJPnX6N9jNTEG
	 h3nq+xh8KajNMZH54185NOuQdjrlPGabFJtv/t2GMV3cSNp+7Td14HZzC5Xud/UbWH
	 UOjC3mkO+bQOy8RpXpPesBqt2K+vDzPp/EAIWyXWVEUPUDM/RDcX1smgbKhLwMSp7J
	 7G/gFm9j2YNDscnEytTkYRXmzx6U2DpGY9hb4QaNAAKdlg/sGoZigo8t571akKPGqz
	 T8xFYBh7NGGiHUrjReORKhoOnKl29Nb4OJ8fXh1cwKO3zj8IvT/OkC4+GBELtq5kN1
	 53+bApOfpGiTQ==
X-Original-To: linux-erofs@lists.ozlabs.org
Delivered-To: linux-erofs@lists.ozlabs.org
Authentication-Results: lists.ozlabs.org;
 spf=pass (mailfrom) smtp.mailfrom=aol.com
 (client-ip=77.238.177.146; helo=sonic314-20.consmr.mail.ir2.yahoo.com;
 envelope-from=hsiangkao@aol.com; receiver=<UNKNOWN>)
Authentication-Results: lists.ozlabs.org;
 dmarc=pass (p=reject dis=none) header.from=aol.com
Authentication-Results: lists.ozlabs.org; dkim=pass (2048-bit key;
 unprotected) header.d=aol.com header.i=@aol.com header.b="ZqEMhcd5"; 
 dkim-atps=neutral
Received: from sonic314-20.consmr.mail.ir2.yahoo.com
 (sonic314-20.consmr.mail.ir2.yahoo.com [77.238.177.146])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 46sb6867pJzDqs1
 for <linux-erofs@lists.ozlabs.org>; Tue, 15 Oct 2019 10:55:27 +1100 (AEDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=aol.com; s=a2048;
 t=1571097322; bh=azuaA80PhuKloFu3jRftQYia6uYg6wxKi5PFdEjprsM=;
 h=Date:From:To:Cc:Subject:References:In-Reply-To:From:Subject;
 b=ZqEMhcd5QMYzo3YRusA/rnHGqiCGUQ9zYrvklbzAT8xcXmhtQiEMweRmmN/UA/Kon+jJkArYu7xB6s/hCqMRWakSnNFD8XbnTcEolg8YXtn+nexStXwshxdPqc4mPxVAV0/r8dbal/3hIAgbddFtiTyGV7KYnMeqbBID9fbsIPy4SXwvhbIncyt2XVHQ52nm7gxla2bubE9yQH2y4gOpycv1KJdiAL5lPYW0yZEfr8fO6VSddLwvo/9jHQcVCIEaF+GD/6adGN178bAv6k+ZvFPLJ84RTX2yHHyKfzniY7sKMPhdfJ/wjHYBzKEryqABLk7QlKzbRKObtyaD1QD39g==
X-YMail-OSG: .fNDzg0VM1lRF9LA4Y44KVP.S159QwmTdSjsClOCfxpFPX0U2gBPLF7nLzLweLI
 IQ31r0vJo1vVYsJUdYYFxT9RguvHAh6f0VkxiqjIvzSt.PONAlboVIsdLmum_t2nbQApJoZUrVNC
 Em5xU6XvRrnGjBKzyXRWW4Y70W_UPpozuIkjlnJ.9aRFPx9xcpXJJ_hC5d6haj2eir.KOrOP0Nfk
 FopC5IAoksQdjq9D6WK0fzYdwUGBFr07FPGpmizBdopu1zY9o1xzTfqMoB4Ae9QBEtHV_2pEw08Y
 y5In.2wIZ0k1kvC_A5sJJi4xQixYb2Oi0M_2pSRJF7VnbihvY9JVPWlcaxz.oK3wLl6gldXGBQm7
 2aYCZIWJPFboCtyJQygz3yrCtn5zIwNL88nnEQS4CuyKxZB3pAJ2Qmy0i0JcWbARtHwltUC6ppnC
 tqHkMS_mZJL2lnarpLiM23vHFHoJvTPU574WGsMaHJmBR2L1ZK9qbJaisNQWh2xdKGnGO3LgVuPa
 LF4ieh61hxcqgl0jAAy6MEkwtrNaq8gB3.JVEh.B3STZips1TUp6153JLpzD4TD6R2u.7ZeoLiTM
 wd_NME5oKL6dmK6TECTItxBeUqgcBIXAxUE4JkyIFZqailcEYCm4MXxbvlN.pKq8Uy56QM795QMj
 59U0ra4rpkAuLYWki3Ocoy109GqOFk3QOsdWuy.J2UvjCZQx_ggJtEqQoTi2qY_an6p_xurPZkP_
 6lV.DI1Eqm9vKl8_a_o0L.rDjNMTG4UEo0.KhlsJlkKhXMBff1fbhIcI7xndEumzOAoQEFIwtoYh
 VR.t.zXdautwHNRyfp7gcIOKfub8EsxW5sdRNIuMut3ONPGpYjqqtqIfXbdSQijX_kk9sUHlahJr
 8nDpW1zz3QThuTvbj4HJK.lGX47jc9UfTmpm.3nxJDI0aXReo4PIP7EDvaMloXL_N19nS0NRcDVa
 fmBl2pVDgUC7s9TajZ_CFGSV_6YBZyUxPkx7GXX8XQMoy7GwgsNKA6_cadOGMnuu.i1eAnJgG1O_
 LEKnCoeCC4wSDTdEm2ain6h5C94iQmO8xEiGNWO4L5wjBY0qgHMoWd5aucF2FBsDqcZDODhlFvFj
 Q8VM4a_LLxKW5MUpMOecpL3JMjF9kp970JYJBCpi5S3CK3BtYsBOkFqLEXnFZAQhkytnyTesHSLv
 2ogcfZZXcNX7aQUP_CQPs7nDGyWWuktGnXZnr7JUXjKGv1pctk4yP2xYuI0_e2I8Pb05UhrxSteh
 5ucRzj.KlzdugSHg_O0WYMNlf_9Wp0FEL8EIQiUmF1HGWviwjW3h0vk51s9Je4c_.jrLwQUe9QRc
 x4B2Nrpjmbb9xESsn
Received: from sonic.gate.mail.ne1.yahoo.com by
 sonic314.consmr.mail.ir2.yahoo.com with HTTP; Mon, 14 Oct 2019 23:55:22 +0000
Received: by smtp431.mail.ir2.yahoo.com (Oath Hermes SMTP Server) with ESMTPA
 ID 77275f98cf0365d9a2a90c12805c7456; 
 Mon, 14 Oct 2019 23:55:19 +0000 (UTC)
Date: Tue, 15 Oct 2019 07:55:13 +0800
To: Li Guifu <bluce.liguifu@huawei.com>, linux-erofs@lists.ozlabs.org
Subject: Re: [PATCH] erofs-utils: use cmpsgn(x, y) for standardized large
 value comparsion
Message-ID: <20191014235505.GB31674@hsiangkao-HP-ZHAN-66-Pro-G1>
References: <20191014113048.32067-1-hsiangkao@aol.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20191014113048.32067-1-hsiangkao@aol.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
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
Cc: Miao Xie <miaoxie@huawei.com>
Errors-To: linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org
Sender: "Linux-erofs"
 <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>

On Mon, Oct 14, 2019 at 07:30:48PM +0800, Gao Xiang wrote:
> Previously, roundup(bb->buffers.off % EROFS_BLKSIZ, alignsize)
> + incr + extrasize is a unsigned 64bit value and sgn(x) didn't
> work properly. Fix it.

Update commit message:

erofs-utils: use cmpsgn(x, y) for standardized large value comparsion
    
Previously, roundup(bb->buffers.off % EROFS_BLKSIZ, alignsize)
+ incr + extrasize is an unsigned 64bit value and sgn(x) didn't
work properly. Fix it.
    
Fixes: b0ca535297b6 ("erofs-utils: support 64-bit internal buffer cache")

Guifu, do you have time reviewing and testing those patches?
I'd like to release erofs-utils 1.0 for upstreaming AOSP these days...

Thanks,
Gao Xiang

> 
> Signed-off-by: Gao Xiang <hsiangkao@aol.com>
> ---
>  include/erofs/defs.h | 5 +++--
>  lib/cache.c          | 6 +++---
>  2 files changed, 6 insertions(+), 5 deletions(-)
> 
> diff --git a/include/erofs/defs.h b/include/erofs/defs.h
> index 15db4e3..db51350 100644
> --- a/include/erofs/defs.h
> +++ b/include/erofs/defs.h
> @@ -136,9 +136,10 @@ typedef int64_t         s64;
>  	type __max2 = (y);			\
>  	__max1 > __max2 ? __max1: __max2; })
>  
> -#define sgn(x) ({		\
> +#define cmpsgn(x, y) ({		\
>  	typeof(x) _x = (x);	\
> -(_x > 0) - (_x < 0); })
> +	typeof(y) _y = (y);	\
> +(_x > _y) - (_x < _y); })
>  
>  #define ARRAY_SIZE(arr)	(sizeof(arr) / sizeof((arr)[0]))
>  
> diff --git a/lib/cache.c b/lib/cache.c
> index 41d2d5d..e61b201 100644
> --- a/lib/cache.c
> +++ b/lib/cache.c
> @@ -80,9 +80,9 @@ static int __erofs_battach(struct erofs_buffer_block *bb,
>  			   bool dryrun)
>  {
>  	const erofs_off_t alignedoffset = roundup(bb->buffers.off, alignsize);
> -	const int oob = sgn(roundup(bb->buffers.off % EROFS_BLKSIZ,
> -				    alignsize) + incr + extrasize -
> -			    EROFS_BLKSIZ);
> +	const int oob = cmpsgn(roundup(bb->buffers.off % EROFS_BLKSIZ,
> +				       alignsize) + incr + extrasize,
> +			       EROFS_BLKSIZ);
>  	bool tailupdate = false;
>  	erofs_blk_t blkaddr;
>  
> -- 
> 2.17.1
> 
