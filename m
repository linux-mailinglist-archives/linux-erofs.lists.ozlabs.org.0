Return-Path: <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>
X-Original-To: lists+linux-erofs@lfdr.de
Delivered-To: lists+linux-erofs@lfdr.de
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	by mail.lfdr.de (Postfix) with ESMTPS id 380A13F705D
	for <lists+linux-erofs@lfdr.de>; Wed, 25 Aug 2021 09:26:18 +0200 (CEST)
Received: from boromir.ozlabs.org (localhost [IPv6:::1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4GvcwS1YkKz2yKF
	for <lists+linux-erofs@lfdr.de>; Wed, 25 Aug 2021 17:26:16 +1000 (AEST)
X-Original-To: linux-erofs@lists.ozlabs.org
Delivered-To: linux-erofs@lists.ozlabs.org
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized)
 smtp.mailfrom=linux.alibaba.com (client-ip=115.124.30.130;
 helo=out30-130.freemail.mail.aliyun.com;
 envelope-from=hsiangkao@linux.alibaba.com; receiver=<UNKNOWN>)
Received: from out30-130.freemail.mail.aliyun.com
 (out30-130.freemail.mail.aliyun.com [115.124.30.130])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 4GvcwG2FYYz2yHq
 for <linux-erofs@lists.ozlabs.org>; Wed, 25 Aug 2021 17:26:03 +1000 (AEST)
X-Alimail-AntiSpam: AC=PASS; BC=-1|-1; BR=01201311R471e4; CH=green; DM=||false|;
 DS=||; FP=0|-1|-1|-1|0|-1|-1|-1; HT=alimailimapcm10staff010182156082;
 MF=hsiangkao@linux.alibaba.com; NM=1; PH=DS; RN=6; SR=0;
 TI=SMTPD_---0Ull5o8F_1629876352; 
Received: from B-P7TQMD6M-0146.local(mailfrom:hsiangkao@linux.alibaba.com
 fp:SMTPD_---0Ull5o8F_1629876352) by smtp.aliyun-inc.com(127.0.0.1);
 Wed, 25 Aug 2021 15:25:54 +0800
Date: Wed, 25 Aug 2021 15:25:52 +0800
From: Gao Xiang <hsiangkao@linux.alibaba.com>
To: Huang Jianan <huangjianan@oppo.com>
Subject: Re: [PATCH] AOSP: erofs-utils: increase val for WITH_ANDROID option
Message-ID: <YSXwgCND2Zf0sfl2@B-P7TQMD6M-0146.local>
References: <20210825033416.19868-1-huangjianan@oppo.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20210825033416.19868-1-huangjianan@oppo.com>
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
Cc: yh@oppo.com, kevin.liw@oppo.com, guoweichao@oppo.com,
 linux-erofs@lists.ozlabs.org, guanyuwei@oppo.com
Errors-To: linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org
Sender: "Linux-erofs"
 <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>

Hi Jianan,

On Wed, Aug 25, 2021 at 11:34:16AM +0800, Huang Jianan via Linux-erofs wrote:

Subject: AOSP: erofs-utils: increase val for AOSP-specific long options

> Signed-off-by: Huang Jianan <huangjianan@oppo.com>
> ---
>  mkfs/main.c | 16 ++++++++--------
>  1 file changed, 8 insertions(+), 8 deletions(-)
> 
> diff --git a/mkfs/main.c b/mkfs/main.c
> index 10fe14d..9369b72 100644
> --- a/mkfs/main.c
> +++ b/mkfs/main.c
> @@ -45,10 +45,10 @@ static struct option long_options[] = {
>  #endif
>  	{"max-extent-bytes", required_argument, NULL, 9},
>  #ifdef WITH_ANDROID
> -	{"mount-point", required_argument, NULL, 10},
> -	{"product-out", required_argument, NULL, 11},
> -	{"fs-config-file", required_argument, NULL, 12},
> -	{"block-list-file", required_argument, NULL, 13},
> +	{"mount-point", required_argument, NULL, 256},
> +	{"product-out", required_argument, NULL, 257},
> +	{"fs-config-file", required_argument, NULL, 258},
> +	{"block-list-file", required_argument, NULL, 259},
>  #endif
>  	{0, 0, 0, 0},
>  };
> @@ -289,20 +289,20 @@ static int mkfs_parse_options_cfg(int argc, char *argv[])
>  			}
>  			break;
>  #ifdef WITH_ANDROID
> -		case 10:
> +		case 256:

How about using larger numbers such as 512 for AOSP-specific options?
I'm afraid in the future we might bump up generic options to >= 256
like this as well.

Otherwise looks good to me.

Thanks,
Gao Xiang
