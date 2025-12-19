Return-Path: <linux-erofs+bounces-1519-lists+linux-erofs=lfdr.de@lists.ozlabs.org>
X-Original-To: lists+linux-erofs@lfdr.de
Delivered-To: lists+linux-erofs@lfdr.de
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2404:9400:21b9:f100::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 29C46CCEC9A
	for <lists+linux-erofs@lfdr.de>; Fri, 19 Dec 2025 08:33:34 +0100 (CET)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4dXfQy1YY3z2yFW;
	Fri, 19 Dec 2025 18:33:30 +1100 (AEDT)
X-Original-To: linux-erofs@lists.ozlabs.org
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip=115.124.30.131
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1766129610;
	cv=none; b=c8i2gPq0g1/dwCnTJpsVChvTHUY8vSIuSUlupmcbQxfPpuRrEfiBKwN10ZXTDmDkFPdIyXkZ+hwFdgtzqmg8p3M3z5+/l7W1dnkxhcQBV7D9w/U4/yLia/jAMXLxlPAEwSe5y47POLzpr7c+cshedpz2+CRH9SMeSQbBzP6H5y/H3YYIaE7v7e0ze2bPY0FSWnFnBhK4OIMmBrCOURBwE43ak3hUm7O+8Z8hnX5GX2IIbAkcHKGAFnLNCNoah5CHVcV8zujLPbo42Hk73N+2sSWRCkKqLijOPw7L44C7Qhj/MHPODDH8Pt6MFvPsBHuzOJs76CgocNEvcEEN8P1Jcg==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1766129610; c=relaxed/relaxed;
	bh=w7YttiFvJJocA6qjJEuECPgS5jDT+Qm/G1px0Bn12Hs=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=e1Q97G1eMwh7TZLGLnshYLra/EnyAwwuyfYIJ0bsaRMgVkZpayA9yTcBBzjiin1XTy6RMifYzoghCY9TK6EQKo5xVbe1pt3J2yeojNJq3W1Pp+2m6wgcf5JBu9UmJsAkOy6FemQKv22HfLJKLMZgSTbC1F9gan/XNdXzwsUvAoLlY3gS/qeqDXR2/Ez2FNewbSwKq8kmVGs8kxROg2BNhQtcWqzpcD1VIOCPVob4MwI8e1+VnG1MsyYGBbZN8+5MmQxuxler/jnprRIKH3iFTN9gM6FlfrLa1G+WaqZp7sc5sHlwM9jrA0uOibVPVhWk7yoYCAmf7c6BoPmKPYHRCw==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com; dkim=pass (1024-bit key; unprotected) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.a=rsa-sha256 header.s=default header.b=jwr3jWBL; dkim-atps=neutral; spf=pass (client-ip=115.124.30.131; helo=out30-131.freemail.mail.aliyun.com; envelope-from=hsiangkao@linux.alibaba.com; receiver=lists.ozlabs.org) smtp.mailfrom=linux.alibaba.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (1024-bit key; unprotected) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.a=rsa-sha256 header.s=default header.b=jwr3jWBL;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=linux.alibaba.com (client-ip=115.124.30.131; helo=out30-131.freemail.mail.aliyun.com; envelope-from=hsiangkao@linux.alibaba.com; receiver=lists.ozlabs.org)
Received: from out30-131.freemail.mail.aliyun.com (out30-131.freemail.mail.aliyun.com [115.124.30.131])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4dXfQt74Ytz2xqG
	for <linux-erofs@lists.ozlabs.org>; Fri, 19 Dec 2025 18:33:24 +1100 (AEDT)
DKIM-Signature:v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=linux.alibaba.com; s=default;
	t=1766129600; h=Message-ID:Date:MIME-Version:Subject:To:From:Content-Type;
	bh=w7YttiFvJJocA6qjJEuECPgS5jDT+Qm/G1px0Bn12Hs=;
	b=jwr3jWBLVMMZatuyf9XWjbv2s+OLHZEeyRKfL5+phjUSRpGLu0dMr472QiEM3TaDrXVhoYTiAJHq7iVI2GJWHajtNLMmNqHZ87jBiqtnwdZoiFwDiyY03z6oXsrcF+1SOHO9p3ZbquEMrMsjRvDsc15KB078TYSykItNY+sznW4=
Received: from 30.221.131.220(mailfrom:hsiangkao@linux.alibaba.com fp:SMTPD_---0WvBrV2S_1766129598 cluster:ay36)
          by smtp.aliyun-inc.com;
          Fri, 19 Dec 2025 15:33:18 +0800
Message-ID: <6a9737d3-1ecd-4105-ad8d-8379cb35bfc7@linux.alibaba.com>
Date: Fri, 19 Dec 2025 15:33:17 +0800
X-Mailing-List: linux-erofs@lists.ozlabs.org
List-Id: <linux-erofs.lists.ozlabs.org>
List-Help: <mailto:linux-erofs+help@lists.ozlabs.org>
List-Owner: <mailto:linux-erofs+owner@lists.ozlabs.org>
List-Post: <mailto:linux-erofs@lists.ozlabs.org>
List-Subscribe: <mailto:linux-erofs+subscribe@lists.ozlabs.org>,
  <mailto:linux-erofs+subscribe-digest@lists.ozlabs.org>,
  <mailto:linux-erofs+subscribe-nomail@lists.ozlabs.org>
List-Unsubscribe: <mailto:linux-erofs+unsubscribe@lists.ozlabs.org>
Precedence: list
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] erofs: fix unexpected EIO under memory pressure
To: Junbeom Yeom <junbeom.yeom@samsung.com>, xiang@kernel.org, chao@kernel.org
Cc: linux-erofs@lists.ozlabs.org, linux-kernel@vger.kernel.org,
 stable@vger.kernel.org, Jaewook Kim <jw5454.kim@samsung.com>,
 Sungjong Seo <sj1557.seo@samsung.com>
References: <CGME20251219071140epcas1p35856372483a973806c5445fa3d2d260b@epcas1p3.samsung.com>
 <20251219071034.2399153-1-junbeom.yeom@samsung.com>
From: Gao Xiang <hsiangkao@linux.alibaba.com>
In-Reply-To: <20251219071034.2399153-1-junbeom.yeom@samsung.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-15.7 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,DKIM_VALID_EF,ENV_AND_HDR_SPF_MATCH,RCVD_IN_DNSWL_NONE,
	SPF_HELO_NONE,SPF_PASS,UNPARSEABLE_RELAY,USER_IN_DEF_DKIM_WL,
	USER_IN_DEF_SPF_WL autolearn=disabled version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-25) on lists.ozlabs.org

Hi Junbeom,

On 2025/12/19 15:10, Junbeom Yeom wrote:
> erofs readahead could fail with ENOMEM under the memory pressure because
> it tries to alloc_page with GFP_NOWAIT | GFP_NORETRY, while GFP_KERNEL
> for a regular read. And if readahead fails (with non-uptodate folios),
> the original request will then fall back to synchronous read, and
> `.read_folio()` should return appropriate errnos.
> 
> However, in scenarios where readahead and read operations compete,
> read operation could return an unintended EIO because of an incorrect
> error propagation.
> 
> To resolve this, this patch modifies the behavior so that, when the
> PCL is for read(which means pcl.besteffort is true), it attempts actual
> decompression instead of propagating the privios error except initial EIO.
> 
> - Page size: 4K
> - The original size of FileA: 16K
> - Compress-ratio per PCL: 50% (Uncompressed 8K -> Compressed 4K)
> [page0, page1] [page2, page3]
> [PCL0]---------[PCL1]
> 
> - functions declaration:
>    . pread(fd, buf, count, offset)
>    . readahead(fd, offset, count)
> - Thread A tries to read the last 4K
> - Thread B tries to do readahead 8K from 4K
> - RA, besteffort == false
> - R, besteffort == true
> 
>          <process A>                   <process B>
> 
> pread(FileA, buf, 4K, 12K)
>    do readahead(page3) // failed with ENOMEM
>    wait_lock(page3)
>      if (!uptodate(page3))
>        goto do_read
>                                 readahead(FileA, 4K, 8K)
>                                 // Here create PCL-chain like below:
>                                 // [null, page1] [page2, null]
>                                 //   [PCL0:RA]-----[PCL1:RA]
> ...
>    do read(page3)        // found [PCL1:RA] and add page3 into it,
>                          // and then, change PCL1 from RA to R
> ...
>                                 // Now, PCL-chain is as below:
>                                 // [null, page1] [page2, page3]
>                                 //   [PCL0:RA]-----[PCL1:R]
> 
>                                   // try to decompress PCL-chain...
>                                   z_erofs_decompress_queue
>                                     err = 0;
> 
>                                     // failed with ENOMEM, so page 1
>                                     // only for RA will not be uptodated.
>                                     // it's okay.
>                                     err = decompress([PCL0:RA], err)
> 
>                                     // However, ENOMEM propagated to next
>                                     // PCL, even though PCL is not only
>                                     // for RA but also for R. As a result,
>                                     // it just failed with ENOMEM without
>                                     // trying any decompression, so page2
>                                     // and page3 will not be uptodated.
>                  ** BUG HERE ** --> err = decompress([PCL1:R], err)
> 
>                                     return err as ENOMEM
> ...
>      wait_lock(page3)
>        if (!uptodate(page3))
>          return EIO      <-- Return an unexpected EIO!
> ...

Many thanks for the report!
It's indeed a new issue to me.

> 
> Fixes: 2349d2fa02db ("erofs: sunset unneeded NOFAILs")
> Cc: stable@vger.kernel.org
> Reviewed-by: Jaewook Kim <jw5454.kim@samsung.com>
> Reviewed-by: Sungjong Seo <sj1557.seo@samsung.com>
> Signed-off-by: Junbeom Yeom <junbeom.yeom@samsung.com>
> ---
>   fs/erofs/zdata.c | 6 +++++-
>   1 file changed, 5 insertions(+), 1 deletion(-)
> 
> diff --git a/fs/erofs/zdata.c b/fs/erofs/zdata.c
> index 27b1f44d10ce..86bf6e087d34 100644
> --- a/fs/erofs/zdata.c
> +++ b/fs/erofs/zdata.c
> @@ -1414,11 +1414,15 @@ static int z_erofs_decompress_queue(const struct z_erofs_decompressqueue *io,
>   	};
>   	struct z_erofs_pcluster *next;
>   	int err = io->eio ? -EIO : 0;
> +	int io_err = err;
>   
>   	for (; be.pcl != Z_EROFS_PCLUSTER_TAIL; be.pcl = next) {
> +		int propagate_err;
> +
>   		DBG_BUGON(!be.pcl);
>   		next = READ_ONCE(be.pcl->next);
> -		err = z_erofs_decompress_pcluster(&be, err) ?: err;
> +		propagate_err = READ_ONCE(be.pcl->besteffort) ? io_err : err;
> +		err = z_erofs_decompress_pcluster(&be, propagate_err) ?: err;

I wonder if it's just possible to decompress each pcluster
according to io status only (but don't bother with previous
pcluster status), like:

		err = z_erofs_decompress_pcluster(&be, io->eio) ?: err;

and change the second argument of
z_erofs_decompress_pcluster() to bool.

So that we could leverage the successful i/o as much as
possible.

Thanks,
Gao Xiang

>   	}
>   	return err;
>   }


