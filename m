Return-Path: <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>
X-Original-To: lists+linux-erofs@lfdr.de
Delivered-To: lists+linux-erofs@lfdr.de
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	by mail.lfdr.de (Postfix) with ESMTPS id 03B0868FDB6
	for <lists+linux-erofs@lfdr.de>; Thu,  9 Feb 2023 04:07:15 +0100 (CET)
Received: from boromir.ozlabs.org (localhost [IPv6:::1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4PC1xX6b0Lz3cgx
	for <lists+linux-erofs@lfdr.de>; Thu,  9 Feb 2023 14:07:12 +1100 (AEDT)
X-Original-To: linux-erofs@lists.ozlabs.org
Delivered-To: linux-erofs@lists.ozlabs.org
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=linux.alibaba.com (client-ip=115.124.30.101; helo=out30-101.freemail.mail.aliyun.com; envelope-from=hsiangkao@linux.alibaba.com; receiver=<UNKNOWN>)
Received: from out30-101.freemail.mail.aliyun.com (out30-101.freemail.mail.aliyun.com [115.124.30.101])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4PC1xP3kRVz3bVr
	for <linux-erofs@lists.ozlabs.org>; Thu,  9 Feb 2023 14:07:04 +1100 (AEDT)
X-Alimail-AntiSpam: AC=PASS;BC=-1|-1;BR=01201311R211e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=ay29a033018045192;MF=hsiangkao@linux.alibaba.com;NM=1;PH=DS;RN=6;SR=0;TI=SMTPD_---0VbE3kxj_1675912018;
Received: from 30.97.49.34(mailfrom:hsiangkao@linux.alibaba.com fp:SMTPD_---0VbE3kxj_1675912018)
          by smtp.aliyun-inc.com;
          Thu, 09 Feb 2023 11:06:59 +0800
Message-ID: <0808568f-785c-6f64-9629-8c02a96752c7@linux.alibaba.com>
Date: Thu, 9 Feb 2023 11:06:57 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:102.0)
 Gecko/20100101 Thunderbird/102.6.1
Subject: Re: [PATCH v3 1/2] erofs: update print symbols for various flags in
 trace
To: Jingbo Xu <jefflexu@linux.alibaba.com>, xiang@kernel.org,
 chao@kernel.org, linux-erofs@lists.ozlabs.org, huyue2@coolpad.com
References: <20230209024825.17335-1-jefflexu@linux.alibaba.com>
From: Gao Xiang <hsiangkao@linux.alibaba.com>
In-Reply-To: <20230209024825.17335-1-jefflexu@linux.alibaba.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
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
Cc: linux-kernel@vger.kernel.org
Errors-To: linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org
Sender: "Linux-erofs" <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>



On 2023/2/9 10:48, Jingbo Xu wrote:
> As new flags introduced, the corresponding print symbols for trace are
> not added accordingly.  Add these missing print symbols for these flags.
> 
> Signed-off-by: Jingbo Xu <jefflexu@linux.alibaba.com>

Reviewed-by: Gao Xiang <hsiangkao@linux.alibaba.com>

Thanks,
Gao Xiang

> ---
> v3: print symbols for EROFS_GET_BLOCKS_RAW is deleted in patch 2
> ---
>   include/trace/events/erofs.h | 14 ++++++++++----
>   1 file changed, 10 insertions(+), 4 deletions(-)
> 
> diff --git a/include/trace/events/erofs.h b/include/trace/events/erofs.h
> index e095d36db939..f0e43e40a4a1 100644
> --- a/include/trace/events/erofs.h
> +++ b/include/trace/events/erofs.h
> @@ -19,12 +19,18 @@ struct erofs_map_blocks;
>   		{ 1,		"DIR" })
>   
>   #define show_map_flags(flags) __print_flags(flags, "|",	\
> -	{ EROFS_GET_BLOCKS_RAW,	"RAW" })
> +	{ EROFS_GET_BLOCKS_RAW,		"RAW" },	\
> +	{ EROFS_GET_BLOCKS_FIEMAP,	"FIEMAP" },	\
> +	{ EROFS_GET_BLOCKS_READMORE,	"READMORE" },	\
> +	{ EROFS_GET_BLOCKS_FINDTAIL,	"FINDTAIL" })
>   
>   #define show_mflags(flags) __print_flags(flags, "",	\
> -	{ EROFS_MAP_MAPPED,	"M" },			\
> -	{ EROFS_MAP_META,	"I" },			\
> -	{ EROFS_MAP_ENCODED,	"E" })
> +	{ EROFS_MAP_MAPPED,		"M" },		\
> +	{ EROFS_MAP_META,		"I" },		\
> +	{ EROFS_MAP_ENCODED,		"E" },		\
> +	{ EROFS_MAP_FULL_MAPPED,	"F" },		\
> +	{ EROFS_MAP_FRAGMENT,		"R" },		\
> +	{ EROFS_MAP_PARTIAL_REF,	"P" })
>   
>   TRACE_EVENT(erofs_lookup,
>   
