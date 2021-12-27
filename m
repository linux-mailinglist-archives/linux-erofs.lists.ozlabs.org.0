Return-Path: <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>
X-Original-To: lists+linux-erofs@lfdr.de
Delivered-To: lists+linux-erofs@lfdr.de
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2404:9400:2:0:216:3eff:fee1:b9f1])
	by mail.lfdr.de (Postfix) with ESMTPS id E2F4747F9B9
	for <lists+linux-erofs@lfdr.de>; Mon, 27 Dec 2021 03:09:18 +0100 (CET)
Received: from boromir.ozlabs.org (localhost [IPv6:::1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4JMh1S5B37z2ynD
	for <lists+linux-erofs@lfdr.de>; Mon, 27 Dec 2021 13:09:16 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org;
	dkim=fail reason="signature verification failed" (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20201202 header.b=arPWzowR;
	dkim-atps=neutral
X-Original-To: linux-erofs@lists.ozlabs.org
Delivered-To: linux-erofs@lists.ozlabs.org
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized)
 smtp.mailfrom=kernel.org (client-ip=2604:1380:40e1:4800::1;
 helo=sin.source.kernel.org; envelope-from=chao@kernel.org; receiver=<UNKNOWN>)
Authentication-Results: lists.ozlabs.org; dkim=pass (2048-bit key;
 unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256
 header.s=k20201202 header.b=arPWzowR; 
 dkim-atps=neutral
Received: from sin.source.kernel.org (sin.source.kernel.org
 [IPv6:2604:1380:40e1:4800::1])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 4JMh1N4K06z2yLX
 for <linux-erofs@lists.ozlabs.org>; Mon, 27 Dec 2021 13:09:12 +1100 (AEDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by sin.source.kernel.org (Postfix) with ESMTPS id CA143CE0E2B;
 Mon, 27 Dec 2021 02:09:08 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2B79CC36AE8;
 Mon, 27 Dec 2021 02:09:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=k20201202; t=1640570947;
 bh=SGQJZNEvEetOE2tY3kO+E4p0kZRezP16jB+ueVUG3T4=;
 h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
 b=arPWzowRJ5DzpDd3zNPHOE+VVCKpAsG4RO9/yo9D1a9i0+bYRtX5v5AvgNhotV/iS
 1dXKd6eSoJhkk0c4Sy2/Gd8V/Sn6lxzP0rq9mCOw3IZxCrXZ3iFcsmi0UTpEebL5Iv
 ReUR9XvnmlobF7SO54+gWlxY99eV33RRUCeF6jg7NqD44lY5oBThLa2CbaeOD5TgQx
 /yDZultndaa/Fea6sBhvuxnBuWUUWwdHBwNfF6CuJao2gMw7Cij8ygnBcTVDkUm5Da
 KlMEhuOX1qNKslZ/haCENK0XU+Uc0xQIAtu2dr4BjNUcB92YtQSwVnqa3F+GEXhL2b
 tQxAUfN4g42Lw==
Message-ID: <c3fd4833-2483-f77e-fb79-42871e2d4219@kernel.org>
Date: Mon, 27 Dec 2021 10:08:54 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Thunderbird/91.4.0
Subject: Re: [PATCH v3 1/5] erofs: tidy up z_erofs_lz4_decompress
Content-Language: en-US
To: Gao Xiang <hsiangkao@linux.alibaba.com>, linux-erofs@lists.ozlabs.org
References: <20211225070626.74080-1-hsiangkao@linux.alibaba.com>
 <20211225070626.74080-2-hsiangkao@linux.alibaba.com>
From: Chao Yu <chao@kernel.org>
In-Reply-To: <20211225070626.74080-2-hsiangkao@linux.alibaba.com>
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
Cc: Yue Hu <huyue2@yulong.com>, LKML <linux-kernel@vger.kernel.org>
Errors-To: linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org
Sender: "Linux-erofs"
 <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>

On 2021/12/25 15:06, Gao Xiang wrote:
> To prepare for the upcoming ztailpacking feature and further
> cleanups, introduce a unique z_erofs_lz4_decompress_ctx to keep
> the context, including inpages, outpages and oend, which are
> frequently used by the lz4 decompressor.
> 
> No logic changes.
> 
> Signed-off-by: Gao Xiang <hsiangkao@linux.alibaba.com>
> ---
>   fs/erofs/decompressor.c | 80 +++++++++++++++++++++--------------------
>   1 file changed, 41 insertions(+), 39 deletions(-)
> 
> diff --git a/fs/erofs/decompressor.c b/fs/erofs/decompressor.c
> index c373a199c407..d1282a8b709e 100644
> --- a/fs/erofs/decompressor.c
> +++ b/fs/erofs/decompressor.c
> @@ -16,6 +16,11 @@
>   #define LZ4_DECOMPRESS_INPLACE_MARGIN(srcsize)  (((srcsize) >> 8) + 32)
>   #endif
>   
> +struct z_erofs_lz4_decompress_ctx {
> +	struct z_erofs_decompress_req *rq;
> +	unsigned int inpages, outpages, oend;
> +};
> +

Could you please comment a bit about fields of structure 
z_erofs_lz4_decompress_ctx?

Otherwise, the patch looks good to me.

Reviewed-by: Chao Yu <chao@kernel.org>

Thanks,
