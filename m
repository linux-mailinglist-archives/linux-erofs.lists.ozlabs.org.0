Return-Path: <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>
X-Original-To: lists+linux-erofs@lfdr.de
Delivered-To: lists+linux-erofs@lfdr.de
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	by mail.lfdr.de (Postfix) with ESMTPS id B3A0E68FDF6
	for <lists+linux-erofs@lfdr.de>; Thu,  9 Feb 2023 04:30:34 +0100 (CET)
Received: from boromir.ozlabs.org (localhost [IPv6:::1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4PC2SP2WL5z3ch4
	for <lists+linux-erofs@lfdr.de>; Thu,  9 Feb 2023 14:30:29 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org;
	dkim=fail reason="signature verification failed" (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20210112 header.b=d1s3KZm3;
	dkim-atps=neutral
X-Original-To: linux-erofs@lists.ozlabs.org
Delivered-To: linux-erofs@lists.ozlabs.org
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=gmail.com (client-ip=2607:f8b0:4864:20::1036; helo=mail-pj1-x1036.google.com; envelope-from=zbestahu@gmail.com; receiver=<UNKNOWN>)
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20210112 header.b=d1s3KZm3;
	dkim-atps=neutral
Received: from mail-pj1-x1036.google.com (mail-pj1-x1036.google.com [IPv6:2607:f8b0:4864:20::1036])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4PC2SD5YfSz3bT7
	for <linux-erofs@lists.ozlabs.org>; Thu,  9 Feb 2023 14:30:19 +1100 (AEDT)
Received: by mail-pj1-x1036.google.com with SMTP id v18-20020a17090ae99200b00230f079dcd9so4876208pjy.1
        for <linux-erofs@lists.ozlabs.org>; Wed, 08 Feb 2023 19:30:19 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:subject:cc:to:from:date:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ynm5YDNy6wcGn0EJjvlzzZ1xEB+UsfPBkImjjL8XoAs=;
        b=d1s3KZm3RPrzckGBfTN1l7phbnT0auQM1xfqJC5KIlfApVpjCB+EboJqnHefcD0VKG
         3F4bfkWVtLv5M2TSZ7W2JM7lmrt9HQ4UH1DleNm+Aj8iEdeZfgkYrK5ZchZYR121qFOq
         MTkSKvpi1J7E/zghgJGfBKy7Jt213M3Y8Rgs9BNyhiV8Tyv1Eiuh51Qa6O5NisBWXbub
         jMWC0SYrJGcaIl5iOk7ZB6zI9bae43UaEHcGDDSan4jPzExaOCmzXL4GKcrTw9UDGZcJ
         u3TUgL+mpiAv0FtrkV0JjKqXQ/4lGQxQf6yxttTGKUcgbXIPWkCiJDaqbXQPB9dzHX7Y
         7dww==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:subject:cc:to:from:date:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=ynm5YDNy6wcGn0EJjvlzzZ1xEB+UsfPBkImjjL8XoAs=;
        b=zVBAizbTU3pLVKoEiRYVbQHqTOJTa9wguZpPmDhuoNb3dtezvVLtMOjLLhP3gSySSO
         PNFLpOUKDwg2TU0dwcHqKM7EwJw8uGsz8srF1YR4A4cxdi+l62UtQLDpudipZD+8RCfN
         T7pHpa3g7l/p0K3B7AO7RLqOKyiL1QP0CHJ0Sz0+wlWU7RHoq2gjGh5u30rZqIFq98vb
         SLIGQMeA0+wBYN0d/ZiSa5KASBJbVU+/mV7yRsOzg2cgi0m0yp64a82kAykAXCk6u9/h
         c12yHIeBNMFFnSG5gFZPYH3GTi9edjzwWc0dRjFHfXvpyVnvPwqjFHfLkPOqNJeB4gjM
         zx/w==
X-Gm-Message-State: AO0yUKXy5BTq/zqv8TWVJ6mww9get964dZxhZlPCaprt5GpSN8RM90f/
	ov4OS77bb0k86lz3vClEHML1oguEojc=
X-Google-Smtp-Source: AK7set8y75DwEB+NEpOeE3Qt/AFjnbz2f2clpWbT3NxooXsaJY83We2CjNffGMf4S2TErpYSZxFbBg==
X-Received: by 2002:a17:903:32c9:b0:196:82d2:93a with SMTP id i9-20020a17090332c900b0019682d2093amr12749822plr.11.1675913416946;
        Wed, 08 Feb 2023 19:30:16 -0800 (PST)
Received: from localhost ([156.236.96.165])
        by smtp.gmail.com with ESMTPSA id jl24-20020a170903135800b0019608291564sm221877plb.134.2023.02.08.19.30.15
        (version=TLS1_2 cipher=ECDHE-ECDSA-CHACHA20-POLY1305 bits=256/256);
        Wed, 08 Feb 2023 19:30:16 -0800 (PST)
Date: Thu, 9 Feb 2023 11:36:00 +0800
From: Yue Hu <zbestahu@gmail.com>
To: Jingbo Xu <jefflexu@linux.alibaba.com>
Subject: Re: [PATCH v3 1/2] erofs: update print symbols for various flags in
 trace
Message-ID: <20230209113600.000051c1.zbestahu@gmail.com>
In-Reply-To: <20230209024825.17335-1-jefflexu@linux.alibaba.com>
References: <20230209024825.17335-1-jefflexu@linux.alibaba.com>
X-Mailer: Claws Mail 3.17.3 (GTK+ 2.24.32; i686-w64-mingw32)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
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
Cc: linux-kernel@vger.kernel.org, zhangwen@coolpad.com, huyue2@coolpad.com, linux-erofs@lists.ozlabs.org
Errors-To: linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org
Sender: "Linux-erofs" <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>

On Thu,  9 Feb 2023 10:48:24 +0800
Jingbo Xu <jefflexu@linux.alibaba.com> wrote:

> As new flags introduced, the corresponding print symbols for trace are
> not added accordingly.  Add these missing print symbols for these flags.
> 
> Signed-off-by: Jingbo Xu <jefflexu@linux.alibaba.com>

Reviewed-by: Yue Hu <huyue2@coolpad.com>

> ---
> v3: print symbols for EROFS_GET_BLOCKS_RAW is deleted in patch 2
> ---
>  include/trace/events/erofs.h | 14 ++++++++++----
>  1 file changed, 10 insertions(+), 4 deletions(-)
> 
> diff --git a/include/trace/events/erofs.h b/include/trace/events/erofs.h
> index e095d36db939..f0e43e40a4a1 100644
> --- a/include/trace/events/erofs.h
> +++ b/include/trace/events/erofs.h
> @@ -19,12 +19,18 @@ struct erofs_map_blocks;
>  		{ 1,		"DIR" })
>  
>  #define show_map_flags(flags) __print_flags(flags, "|",	\
> -	{ EROFS_GET_BLOCKS_RAW,	"RAW" })
> +	{ EROFS_GET_BLOCKS_RAW,		"RAW" },	\
> +	{ EROFS_GET_BLOCKS_FIEMAP,	"FIEMAP" },	\
> +	{ EROFS_GET_BLOCKS_READMORE,	"READMORE" },	\
> +	{ EROFS_GET_BLOCKS_FINDTAIL,	"FINDTAIL" })
>  
>  #define show_mflags(flags) __print_flags(flags, "",	\
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
>  TRACE_EVENT(erofs_lookup,
>  

