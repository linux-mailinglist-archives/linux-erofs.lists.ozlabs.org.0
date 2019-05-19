Return-Path: <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>
X-Original-To: lists+linux-erofs@lfdr.de
Delivered-To: lists+linux-erofs@lfdr.de
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2401:3900:2:1::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 60DFB2264F
	for <lists+linux-erofs@lfdr.de>; Sun, 19 May 2019 10:25:11 +0200 (CEST)
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2401:3900:2:1::3])
	by lists.ozlabs.org (Postfix) with ESMTP id 456FSy0xpbzDqKL
	for <lists+linux-erofs@lfdr.de>; Sun, 19 May 2019 18:25:06 +1000 (AEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=lists.ozlabs.org;
	s=201707; t=1558254306;
	bh=KYySRfs954HniU4cFqYXfgJSZ5o1rV0+lRp5Oj8pk44=;
	h=Subject:To:References:Date:In-Reply-To:List-Id:List-Unsubscribe:
	 List-Archive:List-Post:List-Help:List-Subscribe:From:Reply-To:
	 From;
	b=ey1N4hvc+/y62Sv5H9vZN6GBBz3wfETvnyNbbjdGTRxZOnH80oOqE637tzGe6N8c0
	 TASPkWKw5iv9QTe0urrjjvZx/TefONBe690EJgOpAe353zl+XuULZd4GrJ/cc+T2X0
	 KE6MNQjhX7LI+4nVICRqL3YSr+1+Fr7vTDE88G9esQ2oFTGXGwiMl7sCxbSxtIZzmL
	 +IdqwNU8UiCKXabr8efP7ShXHmkqv8LHnbf2KLZJlMUkbVAEXX1C+XlGGJpkpUY4Tu
	 jJZ8KvoHnNM4HTUw5Gq2G3q9M9MNY0DokP8DpVK3oCcuAhzpgEraDpqPZfyz8qBa8G
	 GuWnUcGp+rxdw==
X-Original-To: linux-erofs@lists.ozlabs.org
Delivered-To: linux-erofs@lists.ozlabs.org
Authentication-Results: lists.ozlabs.org;
 spf=pass (mailfrom) smtp.mailfrom=aol.com
 (client-ip=98.137.69.204; helo=sonic312-23.consmr.mail.gq1.yahoo.com;
 envelope-from=hsiangkao@aol.com; receiver=<UNKNOWN>)
Authentication-Results: lists.ozlabs.org;
 dmarc=pass (p=reject dis=none) header.from=aol.com
Authentication-Results: lists.ozlabs.org; dkim=pass (2048-bit key;
 unprotected) header.d=aol.com header.i=@aol.com header.b="bUwzM7xS"; 
 dkim-atps=neutral
Received: from sonic312-23.consmr.mail.gq1.yahoo.com
 (sonic312-23.consmr.mail.gq1.yahoo.com [98.137.69.204])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 456FSh3XNhzDqJk
 for <linux-erofs@lists.ozlabs.org>; Sun, 19 May 2019 18:24:46 +1000 (AEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=aol.com; s=a2048;
 t=1558254281; bh=2t+uC35MY0XiV3xbgrZAwf0z8Lq9vJrob/+EToB1094=;
 h=Subject:To:References:From:Date:In-Reply-To:From:Subject;
 b=bUwzM7xSeJaEDfpW8nry3howpOUc6ljD8hKbuhUJlDXR4k/HUTVcIUCr3dDqw358AkoDuIOMpTDjLS0gC1HsosWuEQ1WNvc+A8VsjMe56IvxWJnb0TTeHiQQOZJsO2rc9BIz6OLbvemnVvw6NMQxL+2cuYDgj063BbFz3B/X2i19tLjVqJJk58lU1wZgeroWkVFodWZPYIagi6pL8wRLPVX0lroZvjtLbCwsA7No8gnMEKtqrtDiykGG2Gg/+rlGKurB5t5/5ypWN32N+YCjAFIE+wnj60SaCbzmaG+aS8Vc19T4Ebm7SndUWDw8XwI65ksuVPYwJIBAzqb2M9ydUQ==
X-YMail-OSG: joWqGkEVM1ndzME2ddhS5Schq4Bwkix4UKz8pgMAK5DLZelDAekD2XkHfaMfw8Q
 OzYSCuG5npoEadGCIg_r2cj2RiprVbvhkxXVvXxrc72logd1h.KXG34zsgQT8h2CffT6gA0sh_iX
 P_pvaPLSLDcJoVJDLlxr_GLlGDLdC10AQA33z46grLn5DwDZYAwzx3NcKVAq0EgH_kWyyuhrVFa4
 UF_ESD27.aP9rkBCiiShk_1BBqQFvdYYnONu5vK0s6vyp2wHbFGtfchsNmjj358xyiTL4.4LRw2t
 05PYO5dI9Hmul6h3ebAFBbsOgHDBzOAXEF9nnnAbOJfUsQ1oITy5wadKD.0_prlViuNWV3CKdAZk
 I8OhtOcDxG717Xf7vLheL9WnMkKtRN4mGy3xGmzoHbGEFM77hgOzN0AlDMYOfALIqMo_nxtDfMLx
 nZhBf9Nd36UZVoSsv3zGiXEvUC_LpCawwmHEdqTk1uA5Cavil.Jc8WX987ZcPhdNGDgNIZ4Qhr_T
 BBlArM7RljhXiy2UShY4hoBMDOUXk3z_p6pcUYFTit5ZQjKcRUOfgqXMTa5iHySZydeGa40uPBjD
 jw4j6xIZ2VOh3hHjnlrapnu_oB5fqzhTM7_v3g051v5lLAxh9mQXeFqF3fT0XlBNxjKrEN901iIq
 UZS0s23xmFnNdtfLaYfX8h_ZkVmYwz22igV663l30XJCghM4dlTJ0qWxaxxTArxHCCTwoXpRrN6L
 CjbjocAwWCw9KSJCtyexVudpSouOJ0Q2jKTjbCAH_jXm1A_MFvmUVahYVOb_fFuACgQ8YwSMJyAS
 HLoKvR54u4eoFDD_T5yHBt15hYmWgkwLDPyKbRgT0o_Db44LlY.mEmBPiXpFxW4ZJtBjOQm3Mofk
 MvJEXqgXbhLu3qTO2i6l2WBOC0e7eRAfgF4vbg49vf7jbyQpTNdcnysbZLvATSOBFhK6Q84Xxrb3
 1zimZEafJJf8H7ityhFpZh8mDGR7AbfBvitOiOXWPjs5TSqRhyAHmXfEbz67JLOSqPPw_eoiJdxO
 E3krx1yl3Yhb3GfbBfsA3BeYtZ0Hy7zZp1tL9T_jHvO91ACD4b5pcu5NkykFGnpLPerxvaYoCYjW
 VjvoeGj1yY9LmTMFstumMTAy.RlvYSI__PLbjwX.hTY4PvamPVe2mdP6EJoI40RD6fcugwGqsxtU
 Yqxve11j0kdXE1DL3rli.agOnYZIDydfcz0npEE_AGQU-
Received: from sonic.gate.mail.ne1.yahoo.com by
 sonic312.consmr.mail.gq1.yahoo.com with HTTP; Sun, 19 May 2019 08:24:41 +0000
Received: from 183.156.112.94 (EHLO [192.168.199.101]) ([183.156.112.94])
 by smtp426.mail.gq1.yahoo.com (Oath Hermes SMTP Server) with ESMTPA ID
 54983f021bf3a240fddb8083defab91e; 
 Sun, 19 May 2019 08:24:40 +0000 (UTC)
Subject: Re: [PATCH] staging: erofs: fix Warning Use BUG_ON instead of if
 condition followed by BUG
To: Hariprasad Kelam <hariprasad.kelam@gmail.com>,
 Gao Xiang <gaoxiang25@huawei.com>, Chao Yu <yuchao0@huawei.com>,
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
 linux-erofs@lists.ozlabs.org, devel@driverdev.osuosl.org,
 linux-kernel@vger.kernel.org
References: <20190518173331.GA1069@hari-Inspiron-1545>
Message-ID: <7b074b9d-04f9-781b-4ea3-1a1017eceb38@aol.com>
Date: Sun, 19 May 2019 16:24:25 +0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.6.1
MIME-Version: 1.0
In-Reply-To: <20190518173331.GA1069@hari-Inspiron-1545>
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
Errors-To: linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org
Sender: "Linux-erofs"
 <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>

Hi Hariprasad,

On 2019/5/19 上午1:33, Hariprasad Kelam wrote:
> fix below warning reported by  coccicheck
> 
> drivers/staging/erofs/unzip_pagevec.h:74:2-5: WARNING: Use BUG_ON
> instead of if condition followed by BUG.
> 
> Signed-off-by: Hariprasad Kelam <hariprasad.kelam@gmail.com>
> ---
>  drivers/staging/erofs/unzip_pagevec.h | 3 +--
>  1 file changed, 1 insertion(+), 2 deletions(-)
> 
> diff --git a/drivers/staging/erofs/unzip_pagevec.h b/drivers/staging/erofs/unzip_pagevec.h
> index f37d8fd..0f61c54 100644
> --- a/drivers/staging/erofs/unzip_pagevec.h
> +++ b/drivers/staging/erofs/unzip_pagevec.h
> @@ -70,8 +70,7 @@ z_erofs_pagevec_ctor_next_page(struct z_erofs_pagevec_ctor *ctor,
>  			return tagptr_unfold_ptr(t);
>  	}
>  
> -	if (unlikely(nr >= ctor->nr))
> -		BUG();
> +	BUG_ON(nr >= ctor->nr);

Thanks for your report. I suggest to use DBG_BUGON for this case, let me
send another version for this case.

Thanks,
Gao Xiang

>  
>  	return NULL;
>  }
> 
