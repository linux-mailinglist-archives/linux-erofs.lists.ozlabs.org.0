Return-Path: <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>
X-Original-To: lists+linux-erofs@lfdr.de
Delivered-To: lists+linux-erofs@lfdr.de
Received: from lists.ozlabs.org (lists.ozlabs.org [203.11.71.2])
	by mail.lfdr.de (Postfix) with ESMTPS id 0BD0022688
	for <lists+linux-erofs@lfdr.de>; Sun, 19 May 2019 11:51:07 +0200 (CEST)
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2401:3900:2:1::3])
	by lists.ozlabs.org (Postfix) with ESMTP id 456HN83sndzDqK1
	for <lists+linux-erofs@lfdr.de>; Sun, 19 May 2019 19:51:04 +1000 (AEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=lists.ozlabs.org;
	s=201707; t=1558259464;
	bh=zocjdtBupDMyz4zE+i+1sBYloZ/9AapDSs6pQxb2osA=;
	h=Subject:To:References:Date:In-Reply-To:List-Id:List-Unsubscribe:
	 List-Archive:List-Post:List-Help:List-Subscribe:From:Reply-To:Cc:
	 From;
	b=h97dfek3ySp/hG90u9rRJWr1e1GC+MUwt4szlqdcQ7e8Lij/sCY5pW5XGI3/G7yQn
	 qxxiSUHFNMhyplQrIirxFTRVspmdUePdTvVgpUbIBJzwBrLFVyq07t0oHWyMYTINRd
	 1cV4r3cXmtgwZFJIUPG1jfItDU9PQTnr+wJ+r6MTDtFZF5RPwEF/GbaGBqqkY3Ep44
	 mM1aHcGY2ANv9JH8ippKSrIqKVlCNeG1opO6au3+yx4TtYEmjdL6AGUx3d1z8ncSPL
	 Mq8Ni5J9/nN08DJbGtHjUrSXSR20pNm3KqmpcGvcF5IORH+f988rxXnqWaPjznWnpk
	 OYBjJJQloX4GQ==
X-Original-To: linux-erofs@lists.ozlabs.org
Delivered-To: linux-erofs@lists.ozlabs.org
Authentication-Results: lists.ozlabs.org;
 spf=pass (mailfrom) smtp.mailfrom=aol.com
 (client-ip=98.137.65.204; helo=sonic311-23.consmr.mail.gq1.yahoo.com;
 envelope-from=hsiangkao@aol.com; receiver=<UNKNOWN>)
Authentication-Results: lists.ozlabs.org;
 dmarc=pass (p=reject dis=none) header.from=aol.com
Authentication-Results: lists.ozlabs.org; dkim=pass (2048-bit key;
 unprotected) header.d=aol.com header.i=@aol.com header.b="KegmFs1c"; 
 dkim-atps=neutral
Received: from sonic311-23.consmr.mail.gq1.yahoo.com
 (sonic311-23.consmr.mail.gq1.yahoo.com [98.137.65.204])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 456HN14WS7zDqHP
 for <linux-erofs@lists.ozlabs.org>; Sun, 19 May 2019 19:50:56 +1000 (AEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=aol.com; s=a2048;
 t=1558259449; bh=uOB1p/mp8q6x2hlmQ4GnENeFke59y23UCzRnpXW2yKA=;
 h=Subject:To:References:Cc:From:Date:In-Reply-To:From:Subject;
 b=KegmFs1c3EXfPugzTcdCmS2T4W30ic5SO9squz3FfnuKml4bz2V9v1vp5dOBjDz/K5cEwLntCnzjyf+hcAn/XAxSwfxDZ37+dFQKNnyyoH7nyQcH5oes3woZcer/94EVjrUv6jhksqJZ3YAtA+pwfrSEzVFm7ekRm0/92lbTmzsOZzgTjDK9uSw++MEuwiiHAoM8J1nrlY8HcEEpjz8Jbvz+s7sedud7ull+DYgFUQUs0Dy91PlsvHDn1FjUeVYLXjcPauoTygnwMmLy4GtT/NOEiFW+MrPeqVDYF1PJg75qHkS+IopIm79CLytCboq6kbO2YIdO4uSBce7MnxFe2g==
X-YMail-OSG: NL2pl8sVM1n9O.PngIHGRrO0E08jMfeawv4qhea1D5ZhZ4_g0WRNIpl25H3ngzF
 _X5tOjifiO5tIZ1.Z0z7WfLNotmEKuNk7QFUzKxuZ7m9r94jAcLouzYgCEtqwaqkpPPIji5yHKwm
 5tjRY3b8urWoJa4bmg8rivIXhsicQ0cLjBaGvn5i.3B_BlywTiytmw1M4h_2S_Jn8XB.fyqEnCbR
 tdLw2O.nJWIbx.nysdvdhElR79K5TC5DC95syrYTEFkcijWWjNOFkK9HMxJ0PQGT0tDZkngwNjFs
 RHtmQU_QQWwZCXLYkc7DJPeqyfZCRc.G8ZKB4Wm8Zt.aHxeregCkm3YM_JVl9rfQsjfAIFp1m2zV
 5tPTrWLjXm6rTzz0pVWbUDaXOc2msQFAglBiyOltyu.pc091RQtTQueATmX6AGfLb8Wy04CKCiQE
 5vmELBFTjN9bIc3RafOKIyXg9TMT4SxxdupYykrCb74e39.Dfmo7Vymzv2E4hnupJsNwphRIOqcU
 ev_66FxNEd5RApTKeaBi1ZwEnXQL_6fWpFx5jAr80K2sULwGaD5aCiaPLpZhgfE3Yq1Idz5_oj2h
 U5xi.DBfnAX.MMN3S5VWXvdomAJLQS83gRqwAVpHBFzs8Fk.nRi8ET7dhKZTwLfM2xi8kgIHeh1b
 W27Te0__8CdMQykZtzXx0YqIbz6EndqIl9aXKFztBshNmHt4yAIIAbIQ0faDvl4bsoGEBG4QK7fc
 XFgbYw.DGf_bo7VLu7ufb8UV4Ic6eW7SNgjpfDV9b6gZ8qaCCRO4obnMAnnirZRjRBMTDduFROJO
 qBeG89_7MopaWnV5PkZ3AGmEo4KuiFJUabKBCCCf_xLW.ZwL4nysOnh_2JKj7Ok5LCPmy0kyVUa1
 yFD6V9g55UXkcqmUMBhNN9d4GggYi0wxrQqLnATSNV_aFVuMRV8G_vyXKDLSvEMjp4OjNDgMCMQE
 QzRO2hMU0EQ1tKIh3LcwtsZtNQr0SG62WLTkJ8QyDI4SPOMsTmU0SuUejXHoSB1tXnAn0dw.LvKt
 9C4H.J7Skv4fuHGXHsmthgodNcHnNibyJQsNGlAIxZwS3GJ4Jf3P9WLa2FXu2.SpiIcXDFpWXma9
 aXQNz2QpcEedzDHp28XKdCjjn0suz8Mi7NAVm1jGlw6H.3wjNg0ZdQPzxbapggsW5d2.cfU92QQZ
 Lr1Q8h7.xlrV36UPaXsWW6YN3cKD9ovMeQqI8LXIosY_MDVgspkA-
Received: from sonic.gate.mail.ne1.yahoo.com by
 sonic311.consmr.mail.gq1.yahoo.com with HTTP; Sun, 19 May 2019 09:50:49 +0000
Received: from 183.156.112.94 (EHLO [192.168.199.101]) ([183.156.112.94])
 by smtp404.mail.gq1.yahoo.com (Oath Hermes SMTP Server) with ESMTPA ID
 e3bef9504fad3174dbb676844f94f803; 
 Sun, 19 May 2019 09:50:48 +0000 (UTC)
Subject: Re: [Patch v2] staging: erofs: fix Warning Use BUG_ON instead of if
 condition followed by BUG
To: Hariprasad Kelam <hariprasad.kelam@gmail.com>
References: <20190519093440.GA16838@hari-Inspiron-1545>
Message-ID: <b32e6bca-60ec-2004-f1d6-16d2b8a478ae@aol.com>
Date: Sun, 19 May 2019 17:50:40 +0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.6.1
MIME-Version: 1.0
In-Reply-To: <20190519093440.GA16838@hari-Inspiron-1545>
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



On 2019/5/19 下午5:34, Hariprasad Kelam wrote:
> fix below warning reported by  coccicheck
> 
> drivers/staging/erofs/unzip_pagevec.h:74:2-5: WARNING: Use BUG_ON
> instead of if condition followed by BUG.
> 
> Signed-off-by: Hariprasad Kelam <hariprasad.kelam@gmail.com>
> -----
> Changes in v2:
>   - replace BUG_ON with  DBG_BUGON
> -----
> ---
>  drivers/staging/erofs/unzip_pagevec.h | 3 +--
>  1 file changed, 1 insertion(+), 2 deletions(-)
> 
> diff --git a/drivers/staging/erofs/unzip_pagevec.h b/drivers/staging/erofs/unzip_pagevec.h
> index f37d8fd..7938ee3 100644
> --- a/drivers/staging/erofs/unzip_pagevec.h
> +++ b/drivers/staging/erofs/unzip_pagevec.h
> @@ -70,8 +70,7 @@ z_erofs_pagevec_ctor_next_page(struct z_erofs_pagevec_ctor *ctor,
>  			return tagptr_unfold_ptr(t);
>  	}
>  

I'd like to delete this line

> -	if (unlikely(nr >= ctor->nr))
> -		BUG();
> +	DBG_BUGON(nr >= ctor->nr);
>  

and this line.. I have already sent a new patch based on your v1 patch,
could you please check it out if it is acceptable for you? :)

Thanks,
Gao Xiang

>  	return NULL;
>  }
> 
