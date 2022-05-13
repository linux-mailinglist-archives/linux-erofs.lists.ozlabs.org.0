Return-Path: <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>
X-Original-To: lists+linux-erofs@lfdr.de
Delivered-To: lists+linux-erofs@lfdr.de
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2404:9400:2:0:216:3eff:fee1:b9f1])
	by mail.lfdr.de (Postfix) with ESMTPS id 21EE4525B37
	for <lists+linux-erofs@lfdr.de>; Fri, 13 May 2022 08:15:03 +0200 (CEST)
Received: from boromir.ozlabs.org (localhost [IPv6:::1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4Kzyzm4fDjz3byk
	for <lists+linux-erofs@lfdr.de>; Fri, 13 May 2022 16:15:00 +1000 (AEST)
Authentication-Results: lists.ozlabs.org;
	dkim=fail reason="signature verification failed" (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20210112 header.b=XMCp5eiD;
	dkim-atps=neutral
X-Original-To: linux-erofs@lists.ozlabs.org
Delivered-To: linux-erofs@lists.ozlabs.org
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized)
 smtp.mailfrom=gmail.com (client-ip=2607:f8b0:4864:20::62b;
 helo=mail-pl1-x62b.google.com; envelope-from=zbestahu@gmail.com;
 receiver=<UNKNOWN>)
Authentication-Results: lists.ozlabs.org; dkim=pass (2048-bit key;
 unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256
 header.s=20210112 header.b=XMCp5eiD; dkim-atps=neutral
Received: from mail-pl1-x62b.google.com (mail-pl1-x62b.google.com
 [IPv6:2607:f8b0:4864:20::62b])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 4Kzyzh4cDTz3bqL
 for <linux-erofs@lists.ozlabs.org>; Fri, 13 May 2022 16:14:55 +1000 (AEST)
Received: by mail-pl1-x62b.google.com with SMTP id x18so7022002plg.6
 for <linux-erofs@lists.ozlabs.org>; Thu, 12 May 2022 23:14:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20210112;
 h=date:from:to:cc:subject:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=09p7puOxbl364x9rMUnNG+V2yt+v411dIb0qKr8MrfI=;
 b=XMCp5eiDtw1mJXaYFYG+/zix8O+6KymmJULuyfdG8wYvDwPCn7st9fjSEoBaBl3qKg
 SzAtFTqmwAvdZx6+0+RLUxeL/rGVaIHXlLLCrG+5Hf0ppvs4XcqpRZ1F56cvpbtQG0j+
 uHk7XFltnPkUxClIgZLSNpCkyCH+fQiDYOaolzT89R9VwxiXTrid/5FnUDixkSgIgBOI
 FStfcsZkMEfbHdZYU4lyL64I08mmaeGtGLVuXgInkcrnXpMRm40GRXXSY59e9uLDXMsD
 Us/JkNOa9MSdPh1TH+7TxCTXauF1lYt1iSUP3epgO2Mw+5oT+paNntn94eAkoUk+qb0Z
 AnTA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=x-gm-message-state:date:from:to:cc:subject:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=09p7puOxbl364x9rMUnNG+V2yt+v411dIb0qKr8MrfI=;
 b=wsAol6qvhwENe7JcuzRXtC5iVFl81CCgni3J6gqEx8tBIFr6A/V6ouPKLu9AQQ+GOb
 6ZR6CzRShcAP4FqESslVqW3dsiGfJmYlTTxeDnccYUecd0uCR8q/jUQPcb7ae2js46pC
 rLbJ6DDdCXklhfnvP3J10HFCQN11iypXXvtrXZXPRS++eGVhb9OXybL+DAVeAFP0Ht/z
 86Z1BngEirUlaiPGhVAbtPDci7+qvk0k/QJsww8Zxl+HB8mu1hmJD99fL1Uh81yZUAuy
 K2Hc8K2x+uET2iUpasMCDWk2ueWmeqw7XKpQhUCHNi7IpjFMB0WSiSRtAeHZjfe9c+sj
 togA==
X-Gm-Message-State: AOAM531Q2+t2DoDDWoTzDa+dcOy7Ob5Fti6aWLGPj2uBtE4qfzChED4B
 fd3jUnNSzcYhmhz0al4kjLk=
X-Google-Smtp-Source: ABdhPJw8jWPAzXwgSTN9HipBgH/eqkNTXmGvE/cpxZfY6fx4m9/fL2hYV47k+w7y9Kw+aynwsZ5Zag==
X-Received: by 2002:a17:902:854c:b0:159:a70:deca with SMTP id
 d12-20020a170902854c00b001590a70decamr3439541plo.142.1652422492484; 
 Thu, 12 May 2022 23:14:52 -0700 (PDT)
Received: from localhost ([103.220.76.197]) by smtp.gmail.com with ESMTPSA id
 b7-20020a1709027e0700b0015e8d4eb1c7sm980557plm.17.2022.05.12.23.14.46
 (version=TLS1_2 cipher=ECDHE-ECDSA-CHACHA20-POLY1305 bits=256/256);
 Thu, 12 May 2022 23:14:52 -0700 (PDT)
Date: Fri, 13 May 2022 14:14:44 +0800
From: Yue Hu <zbestahu@gmail.com>
To: Gao Xiang <hsiangkao@linux.alibaba.com>
Subject: Re: [PATCH] erofs: fix buffer copy overflow of ztailpacking feature
Message-ID: <20220513141444.00001a6d.zbestahu@gmail.com>
In-Reply-To: <20220512115833.24175-1-hsiangkao@linux.alibaba.com>
References: <20220512115833.24175-1-hsiangkao@linux.alibaba.com>
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
Cc: LKML <linux-kernel@vger.kernel.org>, zhangwen@coolpad.com,
 Yue Hu <huyue2@yulong.com>, huyue2@coolpad.com, linux-erofs@lists.ozlabs.org
Errors-To: linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org
Sender: "Linux-erofs"
 <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>

On Thu, 12 May 2022 19:58:33 +0800
Gao Xiang <hsiangkao@linux.alibaba.com> wrote:

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

Yeah, since we have a 'pageofs_in' to the 'src' for ztailpacking.

Reviewed-by: Yue Hu <huyue2@coolpad.com>

> 
> Fixes: ab749badf9f4 ("erofs: support unaligned data decompression")
> Fixes: cecf864d3d76 ("erofs: support inline data decompression")
> Signed-off-by: Gao Xiang <hsiangkao@linux.alibaba.com>
> ---
>  fs/erofs/decompressor.c | 5 +++--
>  1 file changed, 3 insertions(+), 2 deletions(-)
> 
> diff --git a/fs/erofs/decompressor.c b/fs/erofs/decompressor.c
> index 0f445f7e1df8..6dca1900c733 100644
> --- a/fs/erofs/decompressor.c
> +++ b/fs/erofs/decompressor.c
> @@ -320,6 +320,7 @@ static int z_erofs_shifted_transform(struct z_erofs_decompress_req *rq,
>  		PAGE_ALIGN(rq->pageofs_out + rq->outputsize) >> PAGE_SHIFT;
>  	const unsigned int righthalf = min_t(unsigned int, rq->outputsize,
>  					     PAGE_SIZE - rq->pageofs_out);
> +	const unsigned int lefthalf = rq->outputsize - righthalf;
>  	unsigned char *src, *dst;
>  
>  	if (nrpages_out > 2) {
> @@ -342,10 +343,10 @@ static int z_erofs_shifted_transform(struct z_erofs_decompress_req *rq,
>  	if (nrpages_out == 2) {
>  		DBG_BUGON(!rq->out[1]);
>  		if (rq->out[1] == *rq->in) {
> -			memmove(src, src + righthalf, rq->pageofs_out);
> +			memmove(src, src + righthalf, lefthalf);
>  		} else {
>  			dst = kmap_atomic(rq->out[1]);
> -			memcpy(dst, src + righthalf, rq->pageofs_out);
> +			memcpy(dst, src + righthalf, lefthalf);
>  			kunmap_atomic(dst);
>  		}
>  	}

