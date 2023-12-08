Return-Path: <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>
X-Original-To: lists+linux-erofs@lfdr.de
Delivered-To: lists+linux-erofs@lfdr.de
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2404:9400:2:0:216:3eff:fee1:b9f1])
	by mail.lfdr.de (Postfix) with ESMTPS id E94AC809BA4
	for <lists+linux-erofs@lfdr.de>; Fri,  8 Dec 2023 06:20:51 +0100 (CET)
Authentication-Results: lists.ozlabs.org;
	dkim=fail reason="signature verification failed" (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20230601 header.b=SBuE+/YH;
	dkim-atps=neutral
Received: from boromir.ozlabs.org (localhost [IPv6:::1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4SmfcK2rCtz3cWH
	for <lists+linux-erofs@lfdr.de>; Fri,  8 Dec 2023 16:20:49 +1100 (AEDT)
X-Original-To: linux-erofs@lists.ozlabs.org
Delivered-To: linux-erofs@lists.ozlabs.org
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20230601 header.b=SBuE+/YH;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=gmail.com (client-ip=2607:f8b0:4864:20::533; helo=mail-pg1-x533.google.com; envelope-from=zbestahu@gmail.com; receiver=lists.ozlabs.org)
Received: from mail-pg1-x533.google.com (mail-pg1-x533.google.com [IPv6:2607:f8b0:4864:20::533])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4SmfcB2q6sz2ysD
	for <linux-erofs@lists.ozlabs.org>; Fri,  8 Dec 2023 16:20:40 +1100 (AEDT)
Received: by mail-pg1-x533.google.com with SMTP id 41be03b00d2f7-5c66988c2eeso1291057a12.1
        for <linux-erofs@lists.ozlabs.org>; Thu, 07 Dec 2023 21:20:40 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1702012838; x=1702617638; darn=lists.ozlabs.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:subject:cc:to:from:date:from:to:cc:subject:date
         :message-id:reply-to;
        bh=S24zBF1HQHu7//kRNbFyR3A5MBKuHArHwgre5oFaz98=;
        b=SBuE+/YHHUTuB5YtccVYRRlIfwrxte3XFye8zoUZCanlzzwsrmiHITVTDFyqnlRSB+
         y0+csC1mwNUh6UBNzjZ5axG1KW5eHT0BLtY8xSd5Ysa1T9BzNOSfuBWQJlF3Kf6pqsPh
         bSQXhmyhup8aXohEF5RBUyxVJTRv6skTipeUodTmkQ9IY9PDeBI9QskRDJsLDT5UHWGg
         SOkq52pjf1V0EBau/2KLxoAiHGsAnvUNTKOCibfibep7eHkSfe8Eyy+8/yw/INMCV8z1
         fSzRxOu1k1hdXX7CpNix3yhthqaTEmYNham6FnTdb6QNwZS9KpwrSkzXCYrNRxWgCUz4
         UeCQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1702012838; x=1702617638;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:subject:cc:to:from:date:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=S24zBF1HQHu7//kRNbFyR3A5MBKuHArHwgre5oFaz98=;
        b=jdmCuAR6iMSMeujRiFj0qiYFLO3nA26focKO0mcOyMAXCgfJc5Ym0dX3LSSPcHKmw+
         ZyREz0Z+IAFcO3vubkalpUR9G8zScTlzhDg8j4GHTyTef6K8bxTxoh2iFbQvZwKSJ7/a
         Vj2BWcC0GIZsHaWBKJyPaMPdI7vG0q/IewuBeypMy4VqFP62Xa9FMttQjikCZHalJ2h1
         HAcdw80VSgUpo0AzwI8V6H+iBPjmzrmwgvLQ+nZ6MoDzkJNOMIbPE15Mfw/d5sBd/dlv
         7pdgBmJSA4GW7UQI34E6WI4WQRfT6ekU3o8bI8BMQOT2iqU+halChhpW30+Ey0xbDz/H
         KfRg==
X-Gm-Message-State: AOJu0Yy7iWvjDkQze7NqKwpa8Huo1ByfR35syiAu/+Zih6YaD3pM2XGj
	VNs7V92QbKZqfhkx9ThZ/pE=
X-Google-Smtp-Source: AGHT+IHFO7hxMW2q/zSGD4arP5k4TvrfV3bNdTgNoe2EcLYs3AnIy+d+fhMRX2btc5d5yXSj6ITIqQ==
X-Received: by 2002:a05:6a20:a4a4:b0:190:2036:fc4f with SMTP id y36-20020a056a20a4a400b001902036fc4fmr375050pzk.33.1702012837705;
        Thu, 07 Dec 2023 21:20:37 -0800 (PST)
Received: from localhost ([156.236.96.164])
        by smtp.gmail.com with ESMTPSA id a7-20020a056a000c8700b006ce9da2e389sm715808pfv.13.2023.12.07.21.20.36
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 07 Dec 2023 21:20:37 -0800 (PST)
Date: Fri, 8 Dec 2023 13:20:31 +0800
From: Yue Hu <zbestahu@gmail.com>
To: Gao Xiang <hsiangkao@linux.alibaba.com>
Subject: Re: [PATCH 4/5] erofs: refine z_erofs_transform_plain() for
 sub-page block support
Message-ID: <20231208132031.00003b8d.zbestahu@gmail.com>
In-Reply-To: <20231206091057.87027-5-hsiangkao@linux.alibaba.com>
References: <20231206091057.87027-1-hsiangkao@linux.alibaba.com>
	<20231206091057.87027-5-hsiangkao@linux.alibaba.com>
X-Mailer: Claws Mail 4.1.1 (GTK 3.24.34; x86_64-w64-mingw32)
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
Cc: huyue2@coolpad.com, linux-erofs@lists.ozlabs.org, LKML <linux-kernel@vger.kernel.org>, zhangwen@coolpad.com
Errors-To: linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org
Sender: "Linux-erofs" <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>

On Wed,  6 Dec 2023 17:10:56 +0800
Gao Xiang <hsiangkao@linux.alibaba.com> wrote:

> Sub-page block support is still unusable even with previous commits if
> interlaced PLAIN pclusters exist.  Such pclusters can be found if the
> fragment feature is enabled.
> 
> This commit tries to handle "the head part" of interlaced PLAIN
> pclusters first: it was once explained in commit fdffc091e6f9 ("erofs:
> support interlaced uncompressed data for compressed files").
> 
> It uses a unique way for both shifted and interlaced PLAIN pclusters.
> As an added bonus, PLAIN pclusters larger than the block size is also
> supported now for the upcoming large lclusters.
> 
> Signed-off-by: Gao Xiang <hsiangkao@linux.alibaba.com>
> ---
>  fs/erofs/decompressor.c | 81 ++++++++++++++++++++++++-----------------
>  1 file changed, 48 insertions(+), 33 deletions(-)
> 
> diff --git a/fs/erofs/decompressor.c b/fs/erofs/decompressor.c
> index 021be5feb1bc..5ec11f5024b7 100644
> --- a/fs/erofs/decompressor.c
> +++ b/fs/erofs/decompressor.c
> @@ -319,43 +319,58 @@ static int z_erofs_lz4_decompress(struct z_erofs_decompress_req *rq,
>  static int z_erofs_transform_plain(struct z_erofs_decompress_req *rq,
>  				   struct page **pagepool)
>  {
> -	const unsigned int inpages = PAGE_ALIGN(rq->inputsize) >> PAGE_SHIFT;
> -	const unsigned int outpages =
> +	const unsigned int nrpages_in =
> +		PAGE_ALIGN(rq->pageofs_in + rq->inputsize) >> PAGE_SHIFT;
> +	const unsigned int nrpages_out =
>  		PAGE_ALIGN(rq->pageofs_out + rq->outputsize) >> PAGE_SHIFT;
> -	const unsigned int righthalf = min_t(unsigned int, rq->outputsize,
> -					     PAGE_SIZE - rq->pageofs_out);
> -	const unsigned int lefthalf = rq->outputsize - righthalf;
> -	const unsigned int interlaced_offset =
> -		rq->alg == Z_EROFS_COMPRESSION_SHIFTED ? 0 : rq->pageofs_out;
> -	u8 *src;
> -
> -	if (outpages > 2 && rq->alg == Z_EROFS_COMPRESSION_SHIFTED) {
> -		DBG_BUGON(1);
> -		return -EFSCORRUPTED;
> -	}
> -
> -	if (rq->out[0] == *rq->in) {
> -		DBG_BUGON(rq->pageofs_out);
> -		return 0;
> +	const unsigned int bs = rq->sb->s_blocksize;
> +	unsigned int cur = 0, ni = 0, no, pi, po, insz, cnt;
> +	u8 *kin;
> +
> +	DBG_BUGON(rq->outputsize > rq->inputsize);
> +	if (rq->alg == Z_EROFS_COMPRESSION_INTERLACED) {
> +		cur = bs - (rq->pageofs_out & (bs - 1));
> +		pi = (rq->pageofs_in + rq->inputsize - cur) & ~PAGE_MASK;
> +		cur = min(cur, rq->outputsize);
> +		if (cur && rq->out[0]) {
> +			kin = kmap_local_page(rq->in[nrpages_in - 1]);
> +			if (rq->out[0] == rq->in[nrpages_in - 1]) {
> +				memmove(kin + rq->pageofs_out, kin + pi, cur);
> +				flush_dcache_page(rq->out[0]);
> +			} else {
> +				memcpy_to_page(rq->out[0], rq->pageofs_out,
> +					       kin + pi, cur);
> +			}
> +			kunmap_local(kin);
> +		}
> +		rq->outputsize -= cur;
>  	}
>  
> -	src = kmap_local_page(rq->in[inpages - 1]) + rq->pageofs_in;
> -	if (rq->out[0])
> -		memcpy_to_page(rq->out[0], rq->pageofs_out,
> -			       src + interlaced_offset, righthalf);
> -
> -	if (outpages > inpages) {
> -		DBG_BUGON(!rq->out[outpages - 1]);
> -		if (rq->out[outpages - 1] != rq->in[inpages - 1]) {
> -			memcpy_to_page(rq->out[outpages - 1], 0, src +
> -					(interlaced_offset ? 0 : righthalf),
> -				       lefthalf);
> -		} else if (!interlaced_offset) {
> -			memmove(src, src + righthalf, lefthalf);
> -			flush_dcache_page(rq->in[inpages - 1]);
> -		}
> +	for (; rq->outputsize; rq->pageofs_in = 0, cur += PAGE_SIZE, ni++) {
> +		insz = min(PAGE_SIZE - rq->pageofs_in, rq->outputsize);

min_t(unsigned int, ,)?

../include/linux/minmax.h:21:28: error: comparison of distinct pointer types lacks a cast [-Werror]
  (!!(sizeof((typeof(x) *)1 == (typeof(y) *)1)))


> +		rq->outputsize -= insz;
> +		if (!rq->in[ni])
> +			continue;
> +		kin = kmap_local_page(rq->in[ni]);
> +		pi = 0;
> +		do {
> +			no = (rq->pageofs_out + cur + pi) >> PAGE_SHIFT;
> +			po = (rq->pageofs_out + cur + pi) & ~PAGE_MASK;
> +			DBG_BUGON(no >= nrpages_out);
> +			cnt = min(insz - pi, PAGE_SIZE - po);

ditto

> +			if (rq->out[no] == rq->in[ni]) {
> +				memmove(kin + po,
> +					kin + rq->pageofs_in + pi, cnt);
> +				flush_dcache_page(rq->out[no]);
> +			} else if (rq->out[no]) {
> +				memcpy_to_page(rq->out[no], po,
> +					       kin + rq->pageofs_in + pi, cnt);
> +			}
> +			pi += cnt;
> +		} while (pi < insz);
> +		kunmap_local(kin);
>  	}
> -	kunmap_local(src);
> +	DBG_BUGON(ni > nrpages_in);
>  	return 0;
>  }
>  

