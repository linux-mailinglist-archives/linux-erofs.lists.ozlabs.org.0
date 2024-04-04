Return-Path: <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>
X-Original-To: lists+linux-erofs@lfdr.de
Delivered-To: lists+linux-erofs@lfdr.de
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2404:9400:2:0:216:3eff:fee1:b9f1])
	by mail.lfdr.de (Postfix) with ESMTPS id 5E7FB89896A
	for <lists+linux-erofs@lfdr.de>; Thu,  4 Apr 2024 16:00:52 +0200 (CEST)
Authentication-Results: lists.ozlabs.org;
	dkim=pass (1024-bit key; unprotected) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.a=rsa-sha256 header.s=default header.b=daRCtUb1;
	dkim-atps=neutral
Received: from boromir.ozlabs.org (localhost [IPv6:::1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4V9NYs6yzfz3vXp
	for <lists+linux-erofs@lfdr.de>; Fri,  5 Apr 2024 01:00:49 +1100 (AEDT)
X-Original-To: linux-erofs@lists.ozlabs.org
Delivered-To: linux-erofs@lists.ozlabs.org
Authentication-Results: lists.ozlabs.org;
	dkim=pass (1024-bit key; unprotected) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.a=rsa-sha256 header.s=default header.b=daRCtUb1;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=linux.alibaba.com (client-ip=115.124.30.110; helo=out30-110.freemail.mail.aliyun.com; envelope-from=hsiangkao@linux.alibaba.com; receiver=lists.ozlabs.org)
Received: from out30-110.freemail.mail.aliyun.com (out30-110.freemail.mail.aliyun.com [115.124.30.110])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4V9NYh2vJmz3dWW
	for <linux-erofs@lists.ozlabs.org>; Fri,  5 Apr 2024 01:00:37 +1100 (AEDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=linux.alibaba.com; s=default;
	t=1712239232; h=Message-ID:Date:MIME-Version:Subject:To:From:Content-Type;
	bh=8tby+38EJlgagD1ezl+p8fsLZql+gDhccW4B2GqF8RU=;
	b=daRCtUb1VHWzgtOkEOUouHc6maHuUMaZyVoxV6ddtUSqZ29xNBYJY6fkt1k9mUEmXHuvX/rxgRRYgDpWcbtIs8OCcm4t9LNdAgcuLvJDKU/8U92dYazcxtmPtDbAbcQwWFbUt9IuaS5/ELtCRATJBFbheG534a9O1ORv4VEySkk=
X-Alimail-AntiSpam: AC=PASS;BC=-1|-1;BR=01201311R151e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=ay29a033018045192;MF=hsiangkao@linux.alibaba.com;NM=1;PH=DS;RN=4;SR=0;TI=SMTPD_---0W3ufR9O_1712239229;
Received: from 192.168.2.4(mailfrom:hsiangkao@linux.alibaba.com fp:SMTPD_---0W3ufR9O_1712239229)
          by smtp.aliyun-inc.com;
          Thu, 04 Apr 2024 22:00:30 +0800
Message-ID: <7681743f-ea33-49d4-9769-53895e5355dc@linux.alibaba.com>
Date: Thu, 4 Apr 2024 22:00:27 +0800
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 1/1] erofs-utils: lib: treat data blocks filled with 0s as
 a hole
To: Sandeep Dhavale <dhavale@google.com>, linux-erofs@lists.ozlabs.org
References: <20240403235724.1919539-1-dhavale@google.com>
 <20240403235724.1919539-2-dhavale@google.com>
From: Gao Xiang <hsiangkao@linux.alibaba.com>
In-Reply-To: <20240403235724.1919539-2-dhavale@google.com>
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
Cc: kernel-team@android.com
Errors-To: linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org
Sender: "Linux-erofs" <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>

Hi Sandeep,

On 2024/4/4 07:57, Sandeep Dhavale wrote:
> Add optimization to treat data blocks filled with 0s as a hole.
> Even though diskspace savings are comparable to chunk based or dedupe,
> having no block assigned saves us redundant disk IOs during read.
> 
> This patch detects if the block is filled with zeros and marks
> chunk as erofs_holechunk so there is no physical block assigned.
> 
> Signed-off-by: Sandeep Dhavale <dhavale@google.com>
> ---
>   lib/blobchunk.c | 25 ++++++++++++++++++++++++-
>   1 file changed, 24 insertions(+), 1 deletion(-)
> 
> diff --git a/lib/blobchunk.c b/lib/blobchunk.c
> index 641e3d4..8535058 100644
> --- a/lib/blobchunk.c
> +++ b/lib/blobchunk.c
> @@ -232,6 +232,21 @@ static void erofs_update_minextblks(struct erofs_sb_info *sbi,
>   		*minextblks = lb;
>   }
>   
> +static bool erofs_is_buf_zeros(void *buf, unsigned long len)
> +{
> +	int i, words;
> +	const unsigned long *words_buf = buf;
> +	words = len / sizeof(unsigned long);
> +
> +	DBG_BUGON(len % sizeof(unsigned long));
> +
> +	for (i = 0; i < words; i++) {
> +		if (words_buf[i])
> +			return false;
> +	}
> +	return true;
> +}
> +
>   int erofs_blob_write_chunked_file(struct erofs_inode *inode, int fd,
>   				  erofs_off_t startoff)
>   {
> @@ -323,7 +338,15 @@ int erofs_blob_write_chunked_file(struct erofs_inode *inode, int fd,
>   			ret = -EIO;
>   			goto err;
>   		}
> -
> +		if (len == chunksize && erofs_is_buf_zeros(chunkdata, len)) {
> +			/* if data is all zeros, treat this block as hole */
> +			*(void **)idx++ = &erofs_holechunk;
> +			erofs_update_minextblks(sbi, interval_start, pos,
> +						&minextblks);
> +			interval_start = pos + len;
> +			lastch = NULL;
> +			continue;
> +		}
>   		chunk = erofs_blob_getchunk(sbi, chunkdata, len);

Yes, it's a valid opt.  Yet, I guess we could calculate the unique hash value
of all zeroes (with chunksize) in advance (e.g. when initialization).

And compare the buf hash and the all-zeroed hash in erofs_blob_getchunk(), if
they are the same, let's just compare all data then (or not compare since
it's little chance to have such collision. In that case, erofs_blob_getchunk
returns erofs_holechunk.

Does it sound a good idea to you?

Thanks,
Gao Xiang

>   		if (IS_ERR(chunk)) {
>   			ret = PTR_ERR(chunk);
