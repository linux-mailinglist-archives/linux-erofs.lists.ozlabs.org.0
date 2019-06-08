Return-Path: <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>
X-Original-To: lists+linux-erofs@lfdr.de
Delivered-To: lists+linux-erofs@lfdr.de
Received: from lists.ozlabs.org (lists.ozlabs.org [203.11.71.2])
	by mail.lfdr.de (Postfix) with ESMTPS id 81A7539FA0
	for <lists+linux-erofs@lfdr.de>; Sat,  8 Jun 2019 14:15:26 +0200 (CEST)
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2401:3900:2:1::3])
	by lists.ozlabs.org (Postfix) with ESMTP id 45LddR5FlZzDqRp
	for <lists+linux-erofs@lfdr.de>; Sat,  8 Jun 2019 22:15:23 +1000 (AEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=lists.ozlabs.org;
	s=201707; t=1559996123;
	bh=CY1FETP721CCUzaNVOseQQWpilAUH+fafBvv3Fo10As=;
	h=Subject:To:References:Date:In-Reply-To:List-Id:List-Unsubscribe:
	 List-Archive:List-Post:List-Help:List-Subscribe:From:Reply-To:Cc:
	 From;
	b=JuILH133UIgCCjpachQSg69FTfLtL5nF6V186m0HJmKqpTXzk7TNdLUWL5c8wyzWL
	 o4MHrUJOArmipMYmV+Zn7UbBICMhKIKSze873urcWZSYRK7vwgoFoGyrwuMUlJMWnY
	 l+fCZplO1emhDpype49y92/pTXJ3snP9r+pejK+G475hL59Fp77tDaRdnjzg1dvsm7
	 gsg86KFMXZxwB8kksaiCIBt7kwdWphae7djyRBHHM70ZjdJoZGKlCdJhDMimEh5fD0
	 qapHOJsehBCns8bq1Tp9vD2GGyHjja0jhf4TLMe4Bsn5ZzAn/sbBh98d+XQYlu+cwO
	 XHEvj7cQFGmog==
X-Original-To: linux-erofs@lists.ozlabs.org
Delivered-To: linux-erofs@lists.ozlabs.org
Authentication-Results: lists.ozlabs.org;
 spf=pass (mailfrom) smtp.mailfrom=aol.com
 (client-ip=98.137.69.82; helo=sonic314-19.consmr.mail.gq1.yahoo.com;
 envelope-from=hsiangkao@aol.com; receiver=<UNKNOWN>)
Authentication-Results: lists.ozlabs.org;
 dmarc=pass (p=reject dis=none) header.from=aol.com
Authentication-Results: lists.ozlabs.org; dkim=pass (2048-bit key;
 unprotected) header.d=aol.com header.i=@aol.com header.b="r9GHNBdf"; 
 dkim-atps=neutral
Received: from sonic314-19.consmr.mail.gq1.yahoo.com
 (sonic314-19.consmr.mail.gq1.yahoo.com [98.137.69.82])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 45LdR42PmzzDqFm
 for <linux-erofs@lists.ozlabs.org>; Sat,  8 Jun 2019 22:06:20 +1000 (AEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=aol.com; s=a2048;
 t=1559995574; bh=9E7MyQwq36DvghPQy6gbYSm5lbo+i9g9K12tGggIgLM=;
 h=Subject:To:References:Cc:From:Date:In-Reply-To:From:Subject;
 b=r9GHNBdfTrGLdNxj56yG+fGQud77WJx4xUHXbzfggSV9sJlANrSYsCvTs/W43HtH2U3g+8f3x7gVgJtWKBlPGw8qU8T1UH472yeVrC5//sr2y9t0f7h66BFAVXJXVwjSHAeeuTXnkAGCC2apX8Y8aZmuH4iBwwhfra9aFxMJfukDgL6vJWTtItwGSheBLV+g8aPgH527HONbu+AZD8ssjTYZntFkuRZvA7XTSlsC5srEvhThHuVgBYpjhCXCc6I00hguMBoIvRQvCOoKOR2WURnTvBorRSYmnqGvqJBforNoklFu9bV8hjxc2zA2A5NJSk2i9OuKo/tYyeI5u3byVw==
X-YMail-OSG: _4r6oOMVM1kH7YRduJ1JYn5fyb2KOPttvNkglhqqCq6jnBgKu8OubVI_xEvmyEo
 XawmcGsu7eaISjVB7govGwor3Lv3LjdyQzP1F2nVX_3BFjPWG4S9Rn4bUeo68fhf58GZhYKHMDwa
 vBu4.Gh4cYYJ4a.3km5VA_iC7izhpPeuzc5I7a_L.6ie_1i6TWY4qJM.GT4lniFw49cmwcL_uvra
 qEZhZN8WnlBESdUPDSd1aMc9JJCTyEJPROTq7VjMBkIYc075A8R8iBPfiWN1F7I6GMHMkIYyRIkU
 M7YwVuuPEi4ZY9wkeVlXB_qS3Pf.r9vnb9PGg9w8kX89L6E7gQgk6UiIGa4kdbxkdY7hAu7HmlVU
 uqMz.oeVKVkMr9v2xjFwBnUAn.sQsPC3LwpghbB4v87W_9T_U9pGFtpecbGGA04xYggw46yqeoom
 koMV.V70oC5pChfdevkqi6QucSKqbXIom84RRsNr5oob7uiWOYTlIcAMK3MO8bz_TT0b.WRI3aAv
 Nz4oud87s0Aw9GwilkltRCGoRkg2UstH8k_XS0BE8AkCSKoxnwwJ9bHObofuY4lzDAPYDUjltf1m
 p4G0V.m6SFvHn3RQhDifz2xNDnW_74fQyC4T1FT7rtb.SV5Pt9uDoAK84Ihs4h3CoQlzkr89OLNR
 HVc1pLxbHIKgFZKUU8YQHlCTpl9_iuLrZqxnJ3tNveN7f0rmI8HD8cjpkG._8YjhZuoYRraruJ4l
 d8vik1f8BN9csyA6mP7WBM6nCFFWcmM05PZxWDqKHRtec4I4tTaqTUc2PPT6g5E8OOaYC1wJjwMh
 pGXepoSCH_TYM2YJvfqjcSd5yi2m4ilkHraILk11887h4qETnNuFZ2XQZ.ECn39bjW.uG_9RrITU
 9gbxuwV6wuQbEw3lBjOlLZO7R70K_wBzFY_OWda0F0FCuTTRqvmG3ribTSSF9WGn182KfwNoy2xw
 UNSaLSTvhTcLoAlcQBW7.t.tFzWysiK8XGjc7CCbTos2gkCNH7srHDvQ9onVEbmcdK69Y0szV8aN
 .gOm7womykJxf31YPQAFlToQw6oUgKcfVU3uzPbtq9xLdChzG6Bwz41aNkRuPkP5VcH3hhiP9KQh
 8m_hF83O6PgwaATFlJbwyw5UwKoE6HcO2YeXxzeyZD1IhpIU2aMZvpvUljMpxLvKtT4cNJWiuV6M
 MfDElje1ByvLUIz_RdAg5bBG.4_HUNJux62uVfpgM2g--
Received: from sonic.gate.mail.ne1.yahoo.com by
 sonic314.consmr.mail.gq1.yahoo.com with HTTP; Sat, 8 Jun 2019 12:06:14 +0000
Received: from 125.120.226.196 (EHLO [192.168.0.101]) ([125.120.226.196])
 by smtp403.mail.gq1.yahoo.com (Oath Hermes SMTP Server) with ESMTPA ID
 3dfb8dff750982ce7b5096f4cd30efc9; 
 Sat, 08 Jun 2019 12:06:14 +0000 (UTC)
Subject: Re: [PATCH] staging: erofs: fix warning Comparison to bool
To: Hariprasad Kelam <hariprasad.kelam@gmail.com>
References: <20190608093937.GA10461@hari-Inspiron-1545>
Message-ID: <8aa1fe39-27f3-e74b-5985-c67e04be2f31@aol.com>
Date: Sat, 8 Jun 2019 20:06:08 +0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.7.0
MIME-Version: 1.0
In-Reply-To: <20190608093937.GA10461@hari-Inspiron-1545>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
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
Cc: devel@driverdev.osuosl.org, Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
 linux-kernel@vger.kernel.org, linux-erofs@lists.ozlabs.org
Errors-To: linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org
Sender: "Linux-erofs"
 <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>



On 2019/6/8 ??????5:39, Hariprasad Kelam wrote:
> fix below warnings reported by coccicheck
> 
> drivers/staging/erofs/unzip_vle.c:332:11-18: WARNING: Comparison to bool
> 
> Signed-off-by: Hariprasad Kelam <hariprasad.kelam@gmail.com>

Reviewed-by: Gao Xiang <gaoxiang25@huawei.com>

Thanks,
Gao Xiang

> ---
>  drivers/staging/erofs/unzip_vle.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/staging/erofs/unzip_vle.c b/drivers/staging/erofs/unzip_vle.c
> index 9ecaa87..f3d0d2c 100644
> --- a/drivers/staging/erofs/unzip_vle.c
> +++ b/drivers/staging/erofs/unzip_vle.c
> @@ -329,7 +329,7 @@ try_to_claim_workgroup(struct z_erofs_vle_workgroup *grp,
>  		       z_erofs_vle_owned_workgrp_t *owned_head,
>  		       bool *hosted)
>  {
> -	DBG_BUGON(*hosted == true);
> +	DBG_BUGON(*hosted);
>  
>  	/* let's claim these following types of workgroup */
>  retry:
> 
