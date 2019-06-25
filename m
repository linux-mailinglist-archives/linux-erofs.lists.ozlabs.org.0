Return-Path: <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>
X-Original-To: lists+linux-erofs@lfdr.de
Delivered-To: lists+linux-erofs@lfdr.de
Received: from lists.ozlabs.org (lists.ozlabs.org [203.11.71.2])
	by mail.lfdr.de (Postfix) with ESMTPS id 9A2BF527CD
	for <lists+linux-erofs@lfdr.de>; Tue, 25 Jun 2019 11:20:09 +0200 (CEST)
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2401:3900:2:1::3])
	by lists.ozlabs.org (Postfix) with ESMTP id 45Y0xL5qTNzDqNp
	for <lists+linux-erofs@lfdr.de>; Tue, 25 Jun 2019 19:20:06 +1000 (AEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=lists.ozlabs.org;
	s=201707; t=1561454406;
	bh=liLloH4NuJPawIKr9AyWE+fHEX1j1m0uFlTAGyIlFd0=;
	h=Subject:To:References:Date:In-Reply-To:List-Id:List-Unsubscribe:
	 List-Archive:List-Post:List-Help:List-Subscribe:From:Reply-To:Cc:
	 From;
	b=TkfvSwwtrLv1NARsJjMsM9BvcKhXK5Dd1cpYzu/QwbBXcXxe+KqBwvW26NkYnlI9U
	 qzoIy2d0f7jybYJ+IcyVRPSEznE6XJqKILnM4INMYO97FTmANiqEK3fHtXrh91CNKF
	 IVBSQHsmAtaaOe+/cFailIWT37KSWGZEDkxAcbRPPO5nlBPQyFljOS+veSapa/am8z
	 ygknF2+EzxKyYz+B+266XN8Q1+/rn/zcBK6pa9Fw9DmdJCK28mQ9HczIEs+mmdvtAH
	 baasotomnT/VMPNfEztCLueouXhA1sRCNukvPNk0XA/sQZvKSNY/9JvsEaMNgCBVMa
	 aLdPhPbkc2FcQ==
X-Original-To: linux-erofs@lists.ozlabs.org
Delivered-To: linux-erofs@lists.ozlabs.org
Authentication-Results: lists.ozlabs.org;
 spf=pass (mailfrom) smtp.mailfrom=aol.com
 (client-ip=98.137.69.84; helo=sonic314-21.consmr.mail.gq1.yahoo.com;
 envelope-from=hsiangkao@aol.com; receiver=<UNKNOWN>)
Authentication-Results: lists.ozlabs.org;
 dmarc=pass (p=reject dis=none) header.from=aol.com
Authentication-Results: lists.ozlabs.org; dkim=pass (2048-bit key;
 unprotected) header.d=aol.com header.i=@aol.com header.b="AjRf/lcg"; 
 dkim-atps=neutral
Received: from sonic314-21.consmr.mail.gq1.yahoo.com
 (sonic314-21.consmr.mail.gq1.yahoo.com [98.137.69.84])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 45Y0x93hP2zDq6N
 for <linux-erofs@lists.ozlabs.org>; Tue, 25 Jun 2019 19:19:54 +1000 (AEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=aol.com; s=a2048;
 t=1561454389; bh=W0POAUa9JRX5+gTnB1DmXjhA+3TmRREYcWNzsCm5fBM=;
 h=Subject:To:Cc:References:From:Date:In-Reply-To:From:Subject;
 b=AjRf/lcgAhhKB79On9yVaNxDes1erOqzz8Kbk8uk3VKRObA8+jUodEj9XVti2aCeyuLHlNE2iY4lr5pnL1RaM8kB7WqMfyY7Mp1YVYTerM1KDZiBft8S3Mcw5rTAH6NHnq+y6EZVAB/df3TVtYYzJKBX65N8Y6f6Ep+kd9TywGf15dK3AWRRR25eiB2WdCcEKR3ohvqRnb41x7LPIRQEAtmHlpyFGmZAIikaLtzr+FKIsb5SuvxQmjSXcSVVTRFjLpeOFYUP72aN1eippgpa/1kbvGcUFy+3nvH1IrOS+HR29RGiSgRerfqv4xQg71VqBEsEWqRqLRZalQA9JP2NQg==
X-YMail-OSG: yyn8A_4VM1ndp3ABa1h6bD4rFgrjE2qKhbxd4a.QeCIRnlqB.hG3dW6Yk9f10nH
 9qd1g8dzTuXa4F3q.XDym.4.5IYcI75m5lEXpqgPhQCjsqjCfb1WDIHsoF6PiFoHvf6fgiXc_0xn
 hZQ25vBpKssIwzB3A2n3Rm3ZfBNRPKej4ALBNzZa9SQoINM7vgk22HuNqK9bhVyPskGScliftmJf
 Z1b0C7OR1YcVvugZLKdmv6YkP7tcaUOfxPegxgD2zu2qLDvmhIpsoIp37tMWncA8uiLIGLOjBIOn
 6eTmbDtr5ofue0qeMvZ2cA56NQwkQPRFMQJpmfgsXYB8MBkYs57dg2FY9EQCLHurUxvZOnu1ZIwd
 kWiv1g2jS0XPMyKsYMx0pEYteQc7xpvswL3KKKl4Ami3Bt67bE_q7TDYaslrumQQNrF9Ud_O1HKU
 7GdifHdk6PUO9CwhBgA7trUb5.0C1PHC1NC1dsoRB9uWr.52bdJiCiQLE9Q9J_4YO7jXUkNYs0h4
 xZhVYmKjsCTPTz4YD5K5jcmomelD5E0Tl1srCbuMCp7LzdGKlq2TTDZudwFEBsdIc3U7F7csMGEP
 mw.o.gEnpATvuBXimT9a.YdEhn8OAStoRPntAWjeYiRCPt2iGxaAXNbuiTQTWOHq5K8HWS69HDc1
 wPd0zMHeTdCDKecaQbYGtIiWfyw_uWBVFGvwi3vRMRnkNNNODAo8JOMZkVTs9_9mB0.pWfXAI4kO
 RDB2AjF75T1hk7Juj2QsocDl7JVCItcUWBzVZ8zZSyaH94xYCEPq933R629na516OqNZCtD3UWeT
 SV4Opb_TuOoq_iuszJ7Kxj6tqNrC9grxmstQatZoDiyWSPoIRJcQhtmraXDkwNWwWCSQQLn0S8s6
 MliLQKqU_lvczXPW1lo2krR9pmajWhZagEBrL2sCF0cK2Yx7PDOwMTI4r16RQ154s8yVkTXN0vAB
 sbss6WhvM9YFjZh8YS3q7ebtmMAcCPoz6aNd9WbhFK.bMho_rqaRYgMift.zbNV.d8jsKwRlafXH
 cwt2sGGdI0Ku634T6TrQXGT39ocyZDNB4Gi9WDbkPKnHTB4ac_9NKK77guFjH8BkzUddGqJ9BXEB
 su_ztbHchWEk3R8h1thokm7M3rhnCmRRsQepDby30ugFYX6ASPbQWC6HajVAxfOnIQ5O8FbLZ9Mr
 oFS4yLQjofVvBExvb4NfQnvc4GQSKWcQSfpzn1Y0CCSatIwwpSvjOiIy6n8Ym
Received: from sonic.gate.mail.ne1.yahoo.com by
 sonic314.consmr.mail.gq1.yahoo.com with HTTP; Tue, 25 Jun 2019 09:19:49 +0000
Received: from 116.226.249.212 (EHLO [10.17.157.5]) ([116.226.249.212])
 by smtp423.mail.gq1.yahoo.com (Oath Hermes SMTP Server) with ESMTPA ID
 cfaebf859018f9af388c6019241f45f0; 
 Tue, 25 Jun 2019 09:19:44 +0000 (UTC)
Subject: Re: [PATCH] staging: erofs: return the error value if
 fill_inline_data() fails
To: Yue Hu <zbestahu@gmail.com>, gaoxiang25@huawei.com, yuchao0@huawei.com,
 gregkh@linuxfoundation.org
References: <20190625075943.2420-1-zbestahu@gmail.com>
Message-ID: <b724c331-5338-d827-6618-1bded956c41d@aol.com>
Date: Tue, 25 Jun 2019 17:19:36 +0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.7.1
MIME-Version: 1.0
In-Reply-To: <20190625075943.2420-1-zbestahu@gmail.com>
Content-Type: text/plain; charset=gbk
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
Cc: huyue2@yulong.com, linux-erofs@lists.ozlabs.org
Errors-To: linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org
Sender: "Linux-erofs"
 <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>



On 2019/6/25 ????3:59, Yue Hu Wrote:
> From: Yue Hu <huyue2@yulong.com>
> 
> We should consider the error returned by fill_inline_data() when filling
> last page in fill_inode(). If not getting inode will be successful even
> though last page is bad. That is illogical. Also change -EAGAIN to 0 in
> fill_inline_data() to stand for successful filling.
> 
> Signed-off-by: Yue Hu <huyue2@yulong.com>

looks good to me, yet I think you need to Cc staging mailing list at
least if you want to upstream quickly (including your older patches...)


Reviewed-by: Gao Xiang <gaoxiang25@huawei.com>


(Don't forget to add 'PATCH RESEND' tag at the subject line if you
resend these patches.)

Thanks,
Gao Xiang


> ---
>  drivers/staging/erofs/inode.c | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/staging/erofs/inode.c b/drivers/staging/erofs/inode.c
> index d6e1e16..1433f25 100644
> --- a/drivers/staging/erofs/inode.c
> +++ b/drivers/staging/erofs/inode.c
> @@ -156,7 +156,7 @@ static int fill_inline_data(struct inode *inode, void *data,
>  		inode->i_link = lnk;
>  		set_inode_fast_symlink(inode);
>  	}
> -	return -EAGAIN;
> +	return 0;
>  }
>  
>  static int fill_inode(struct inode *inode, int isdir)
> @@ -223,7 +223,7 @@ static int fill_inode(struct inode *inode, int isdir)
>  		inode->i_mapping->a_ops = &erofs_raw_access_aops;
>  
>  		/* fill last page if inline data is available */
> -		fill_inline_data(inode, data, ofs);
> +		err = fill_inline_data(inode, data, ofs);
>  	}
>  
>  out_unlock:
> 
