Return-Path: <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>
X-Original-To: lists+linux-erofs@lfdr.de
Delivered-To: lists+linux-erofs@lfdr.de
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2401:3900:2:1::3])
	by mail.lfdr.de (Postfix) with ESMTPS id ABFE0927BF
	for <lists+linux-erofs@lfdr.de>; Mon, 19 Aug 2019 16:58:02 +0200 (CEST)
Received: from bilbo.ozlabs.org (lists.ozlabs.org [IPv6:2401:3900:2:1::3])
	by lists.ozlabs.org (Postfix) with ESMTP id 46Bxqp0WvDzDqd3
	for <lists+linux-erofs@lfdr.de>; Tue, 20 Aug 2019 00:57:58 +1000 (AEST)
X-Original-To: linux-erofs@lists.ozlabs.org
Delivered-To: linux-erofs@lists.ozlabs.org
Authentication-Results: lists.ozlabs.org;
 spf=pass (mailfrom) smtp.mailfrom=kernel.org
 (client-ip=198.145.29.99; helo=mail.kernel.org; envelope-from=chao@kernel.org;
 receiver=<UNKNOWN>)
Authentication-Results: lists.ozlabs.org;
 dmarc=pass (p=none dis=none) header.from=kernel.org
Authentication-Results: lists.ozlabs.org; dkim=pass (1024-bit key;
 unprotected) header.d=kernel.org header.i=@kernel.org header.b="PTKQOnEO"; 
 dkim-atps=neutral
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 46Bxqf0NCZzDqcH
 for <linux-erofs@lists.ozlabs.org>; Tue, 20 Aug 2019 00:57:49 +1000 (AEST)
Received: from [192.168.0.101] (unknown [180.111.132.43])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by mail.kernel.org (Postfix) with ESMTPSA id 435172082A;
 Mon, 19 Aug 2019 14:57:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=default; t=1566226667;
 bh=iRcx/O1rt67I+bSqDqzSPYqUMMvn9C25iDR30t7jQdk=;
 h=Subject:To:Cc:References:From:Date:In-Reply-To:From;
 b=PTKQOnEO344zI2hda1QYiTrhurpmTkc+j7HQEkCB7cel1Ed+7sbtRI6wLlV2SdIcj
 DmyH5g3WB7ab7jLg0Mg/yfnldrIcKSk6xzEplSDfCWMmmyW4l3OnWRZndCXyn2k7su
 7Uwqj2wfqwti8gePVk9dVTzUTCDl8kJwCF85YU/o=
Subject: Re: [PATCH 5/6] staging: erofs: detect potential multiref due to
 corrupted images
To: Gao Xiang <gaoxiang25@huawei.com>, Chao Yu <yuchao0@huawei.com>,
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>, devel@driverdev.osuosl.org,
 linux-fsdevel@vger.kernel.org
References: <20190819080218.GA42231@138>
 <20190819103426.87579-1-gaoxiang25@huawei.com>
 <20190819103426.87579-6-gaoxiang25@huawei.com>
From: Chao Yu <chao@kernel.org>
Message-ID: <f302710e-0c7f-8695-d692-be0c01c431ea@kernel.org>
Date: Mon, 19 Aug 2019 22:57:42 +0800
User-Agent: Mozilla/5.0 (Windows NT 6.1; WOW64; rv:52.0) Gecko/20100101
 Thunderbird/52.9.1
MIME-Version: 1.0
In-Reply-To: <20190819103426.87579-6-gaoxiang25@huawei.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
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
Cc: linux-erofs@lists.ozlabs.org, LKML <linux-kernel@vger.kernel.org>,
 stable@vger.kernel.org, weidu.du@huawei.com, Miao Xie <miaoxie@huawei.com>
Errors-To: linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org
Sender: "Linux-erofs"
 <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>

On 2019-8-19 18:34, Gao Xiang wrote:
> As reported by erofs-utils fuzzer, currently, multiref
> (ondisk deduplication) hasn't been supported for now,
> we should forbid it properly.
> 
> Fixes: 3883a79abd02 ("staging: erofs: introduce VLE decompression support")
> Cc: <stable@vger.kernel.org> # 4.19+
> Signed-off-by: Gao Xiang <gaoxiang25@huawei.com>
> ---
>  drivers/staging/erofs/zdata.c | 16 ++++++++++++++--
>  1 file changed, 14 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/staging/erofs/zdata.c b/drivers/staging/erofs/zdata.c
> index aae2f2b8353f..5b6fef5181af 100644
> --- a/drivers/staging/erofs/zdata.c
> +++ b/drivers/staging/erofs/zdata.c
> @@ -816,8 +816,16 @@ static int z_erofs_decompress_pcluster(struct super_block *sb,
>  			pagenr = z_erofs_onlinepage_index(page);
>  
>  		DBG_BUGON(pagenr >= nr_pages);
> -		DBG_BUGON(pages[pagenr]);
>  
> +		/*
> +		 * currently EROFS doesn't support multiref(dedup),
> +		 * so here erroring out one multiref page.
> +		 */
> +		if (unlikely(pages[pagenr])) {
> +			DBG_BUGON(1);
> +			SetPageError(pages[pagenr]);
> +			z_erofs_onlinepage_endio(pages[pagenr]);

Should set err meanwhile?

> +		}
>  		pages[pagenr] = page;
>  	}
>  	z_erofs_pagevec_ctor_exit(&ctor, true);
> @@ -849,7 +857,11 @@ static int z_erofs_decompress_pcluster(struct super_block *sb,
>  			pagenr = z_erofs_onlinepage_index(page);
>  
>  			DBG_BUGON(pagenr >= nr_pages);
> -			DBG_BUGON(pages[pagenr]);
> +			if (unlikely(pages[pagenr])) {
> +				DBG_BUGON(1);
> +				SetPageError(pages[pagenr]);
> +				z_erofs_onlinepage_endio(pages[pagenr]);
> +			}
>  			pages[pagenr] = page;
>  
>  			overlapped = true;
> 
