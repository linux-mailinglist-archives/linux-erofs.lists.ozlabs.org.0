Return-Path: <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>
X-Original-To: lists+linux-erofs@lfdr.de
Delivered-To: lists+linux-erofs@lfdr.de
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	by mail.lfdr.de (Postfix) with ESMTPS id D785E52A5B1
	for <lists+linux-erofs@lfdr.de>; Tue, 17 May 2022 17:10:33 +0200 (CEST)
Received: from boromir.ozlabs.org (localhost [IPv6:::1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4L2fgq5tyGz3bwH
	for <lists+linux-erofs@lfdr.de>; Wed, 18 May 2022 01:10:31 +1000 (AEST)
Authentication-Results: lists.ozlabs.org;
	dkim=fail reason="signature verification failed" (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20201202 header.b=C9ZGpKil;
	dkim-atps=neutral
X-Original-To: linux-erofs@lists.ozlabs.org
Delivered-To: linux-erofs@lists.ozlabs.org
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized)
 smtp.mailfrom=kernel.org (client-ip=2604:1380:4601:e00::1;
 helo=ams.source.kernel.org; envelope-from=chao@kernel.org; receiver=<UNKNOWN>)
Authentication-Results: lists.ozlabs.org; dkim=pass (2048-bit key;
 unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256
 header.s=k20201202 header.b=C9ZGpKil; 
 dkim-atps=neutral
Received: from ams.source.kernel.org (ams.source.kernel.org
 [IPv6:2604:1380:4601:e00::1])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 4L2fgm2zxLz3bYy
 for <linux-erofs@lists.ozlabs.org>; Wed, 18 May 2022 01:10:28 +1000 (AEST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by ams.source.kernel.org (Postfix) with ESMTPS id B2C99B815BB;
 Tue, 17 May 2022 15:10:22 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C7F4FC385B8;
 Tue, 17 May 2022 15:10:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=k20201202; t=1652800221;
 bh=W9gM3dHcyJ8mhIJXhDEEP1pKOSlJKU41dtmN3UaOQak=;
 h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
 b=C9ZGpKilUesMylP87pJHxYicHAxEFPXgWqXPO6h4OnayDwwGmIRwsJ3u84uq3XhN5
 3FkmIldSAeWKo2A4shnLK8svZMRQ21SBclYYqmd0wxkCqOtcYCQukoWMy5k9pSoZDZ
 +EvDqCpPnUDH9SFZuF0hUm/QBnXMQx9oxhS7OvyZacwGpQMP0HLvRKEpas4agJdQwf
 1UA6F/n9Z42a1XscJ9eSwbJDji70EpGjBlio7hekZI7caDb7UL0j50coaP0hPH/F+n
 1HhouCrf+Yxn72N5QN328WSvF0cpDR/2f44THsYXve85qHPwUB8NoEurzTPo6UYiRc
 VPUECNQycqQuQ==
Message-ID: <412276c5-ca5e-a644-e0e0-d52bad3c5ba8@kernel.org>
Date: Tue, 17 May 2022 23:10:15 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Thunderbird/91.9.0
Subject: Re: [PATCH] erofs: fix buffer copy overflow of ztailpacking feature
Content-Language: en-US
To: Gao Xiang <hsiangkao@linux.alibaba.com>, linux-erofs@lists.ozlabs.org
References: <20220512115833.24175-1-hsiangkao@linux.alibaba.com>
From: Chao Yu <chao@kernel.org>
In-Reply-To: <20220512115833.24175-1-hsiangkao@linux.alibaba.com>
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

On 2022/5/12 19:58, Gao Xiang wrote:
> I got some KASAN report as below:
> 
> [   46.959738] ==================================================================
> [   46.960430] BUG: KASAN: use-after-free in z_erofs_shifted_transform+0x2bd/0x370
> [   46.960430] Read of size 4074 at addr ffff8880300c2f8e by task fssum/188
> ...
> [   46.960430] Call Trace:
> [   46.960430]  <TASK>
> [   46.960430]  dump_stack_lvl+0x41/0x5e
> [   46.960430]  print_report.cold+0xb2/0x6b7
> [   46.960430]  ? z_erofs_shifted_transform+0x2bd/0x370
> [   46.960430]  kasan_report+0x8a/0x140
> [   46.960430]  ? z_erofs_shifted_transform+0x2bd/0x370
> [   46.960430]  kasan_check_range+0x14d/0x1d0
> [   46.960430]  memcpy+0x20/0x60
> [   46.960430]  z_erofs_shifted_transform+0x2bd/0x370
> [   46.960430]  z_erofs_decompress_pcluster+0xaae/0x1080
> 
> The root cause is that the tail pcluster won't be a complete filesystem
> block anymore. So if ztailpacking is used, the second part of an
> uncompresed tail pcluster may not be ``rq->pageofs_out``.

uncompressed

> 
> Fixes: ab749badf9f4 ("erofs: support unaligned data decompression")
> Fixes: cecf864d3d76 ("erofs: support inline data decompression")
> Signed-off-by: Gao Xiang <hsiangkao@linux.alibaba.com>

Reviewed-by: Chao Yu <chao@kernel.org>

Thanks,

> ---
>   fs/erofs/decompressor.c | 5 +++--
>   1 file changed, 3 insertions(+), 2 deletions(-)
> 
> diff --git a/fs/erofs/decompressor.c b/fs/erofs/decompressor.c
> index 0f445f7e1df8..6dca1900c733 100644
> --- a/fs/erofs/decompressor.c
> +++ b/fs/erofs/decompressor.c
> @@ -320,6 +320,7 @@ static int z_erofs_shifted_transform(struct z_erofs_decompress_req *rq,
>   		PAGE_ALIGN(rq->pageofs_out + rq->outputsize) >> PAGE_SHIFT;
>   	const unsigned int righthalf = min_t(unsigned int, rq->outputsize,
>   					     PAGE_SIZE - rq->pageofs_out);
> +	const unsigned int lefthalf = rq->outputsize - righthalf;
>   	unsigned char *src, *dst;
>   
>   	if (nrpages_out > 2) {
> @@ -342,10 +343,10 @@ static int z_erofs_shifted_transform(struct z_erofs_decompress_req *rq,
>   	if (nrpages_out == 2) {
>   		DBG_BUGON(!rq->out[1]);
>   		if (rq->out[1] == *rq->in) {
> -			memmove(src, src + righthalf, rq->pageofs_out);
> +			memmove(src, src + righthalf, lefthalf);
>   		} else {
>   			dst = kmap_atomic(rq->out[1]);
> -			memcpy(dst, src + righthalf, rq->pageofs_out);
> +			memcpy(dst, src + righthalf, lefthalf);
>   			kunmap_atomic(dst);
>   		}
>   	}
