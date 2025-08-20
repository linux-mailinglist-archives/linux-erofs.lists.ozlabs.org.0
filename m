Return-Path: <linux-erofs+bounces-845-lists+linux-erofs=lfdr.de@lists.ozlabs.org>
X-Original-To: lists+linux-erofs@lfdr.de
Delivered-To: lists+linux-erofs@lfdr.de
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	by mail.lfdr.de (Postfix) with ESMTPS id 82871B2D525
	for <lists+linux-erofs@lfdr.de>; Wed, 20 Aug 2025 09:45:02 +0200 (CEST)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4c6JQ31qLKz2yGM;
	Wed, 20 Aug 2025 17:44:59 +1000 (AEST)
X-Original-To: linux-erofs@lists.ozlabs.org
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip=115.124.30.98
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1755675899;
	cv=none; b=losqq/4kew+NXmx1lEzxF1XriEHGtX4uzDF54Q4yxJMNYi3axrj/Dz5+i4uNGRk+1zs9BcEkCv8LkJFDAUKpi48G/Au6uIjLgr3s17J+xsiTOGM+sx7Qdf8AMxxpDr9KG1GiaaX79z/1eH5Z9tOYuriVOsyE0CUQLDKgL/Kr0WnV1Pb7GizBWYfYGxbcvaj1RN3nq3SEBVdxS7YO/o5RhlpWLU++4w7PMdq0HFfs8OWGNoSbkrpvrvCoQRkeMV5wyr0y597zKR7oG7SFDt0Mme6Fx75AIIE9/tzjqZ2WTwlY3xiuwDjMcu2ST1+3oqUYI/XV+9CWe6Ero5oulhE8oQ==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1755675899; c=relaxed/relaxed;
	bh=djv3Z5hyqz21TUn88tBqJYtvPOZX3tsNyjJXXzttt1s=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=LNwH8CSFlxrbiJmu0rkPyswCGqwrEIVg4YYwcl0S1D5WPLC11j9YC4J0fxsaxZuwwY/em1W4fkE39pMqjap4FbQYl3jz5aI0h2qbmL1P0gG69w9d5geYU5SjscpOScDJ935Y7ppHAUerBQVWpc4udb4Bu4x8ZuCUw6faCMPIRGeJZrwbXBEGCpzyzeejql4Q/csMCiKqbJ5BiDJcx8rsWIRFIW2K67izIvCCCVQ/m6Zi8HIBAqr1h2DKXIinggEa4PrLNz32pBCa8FLx+WYe/G0YxtFa4Qo2SUYH5Kg8oQrnr9Lis9swjkUqz52siQty0fl3n577JIABQcSEUbZh3A==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com; dkim=pass (1024-bit key; unprotected) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.a=rsa-sha256 header.s=default header.b=Psfj+KCo; dkim-atps=neutral; spf=pass (client-ip=115.124.30.98; helo=out30-98.freemail.mail.aliyun.com; envelope-from=hsiangkao@linux.alibaba.com; receiver=lists.ozlabs.org) smtp.mailfrom=linux.alibaba.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (1024-bit key; unprotected) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.a=rsa-sha256 header.s=default header.b=Psfj+KCo;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=linux.alibaba.com (client-ip=115.124.30.98; helo=out30-98.freemail.mail.aliyun.com; envelope-from=hsiangkao@linux.alibaba.com; receiver=lists.ozlabs.org)
Received: from out30-98.freemail.mail.aliyun.com (out30-98.freemail.mail.aliyun.com [115.124.30.98])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4c6JQ12B9cz2xcC
	for <linux-erofs@lists.ozlabs.org>; Wed, 20 Aug 2025 17:44:56 +1000 (AEST)
DKIM-Signature:v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=linux.alibaba.com; s=default;
	t=1755675891; h=Message-ID:Date:MIME-Version:Subject:To:From:Content-Type;
	bh=djv3Z5hyqz21TUn88tBqJYtvPOZX3tsNyjJXXzttt1s=;
	b=Psfj+KCo8yOf+IstJmUHL6SGJTJLImLqBx5aRI3tTJhx07Giy3sSGEVjhwXGHRegIDHBPKC20lj6d2gF+SM3Uyyi9VRIXImP6K8pJWciRGNYl3cVZcD8V/+PaXhhw4jUAUX0zI2s/ecT2a7d7oCyWy52NYLNuVcUMBTPoSkroUY=
Received: from 30.221.129.108(mailfrom:hsiangkao@linux.alibaba.com fp:SMTPD_---0WmB4QCo_1755675889 cluster:ay36)
          by smtp.aliyun-inc.com;
          Wed, 20 Aug 2025 15:44:50 +0800
Message-ID: <39f81655-8bef-428c-843b-b57c9e50c90d@linux.alibaba.com>
Date: Wed, 20 Aug 2025 15:44:47 +0800
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
Subject: Re: [PATCH v1] erofs-utils: mkfs: Implement 'dsunit' alignment on
 blobdev
To: Friendy Su <friendy.su@sony.com>, linux-erofs@lists.ozlabs.org
Cc: Yuezhang Mo <Yuezhang.Mo@sony.com>, Daniel Palmer <daniel.palmer@sony.com>
References: <20250820072352.4151620-1-friendy.su@sony.com>
From: Gao Xiang <hsiangkao@linux.alibaba.com>
In-Reply-To: <20250820072352.4151620-1-friendy.su@sony.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-15.7 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,DKIM_VALID_EF,ENV_AND_HDR_SPF_MATCH,RCVD_IN_DNSWL_NONE,
	SPF_HELO_NONE,SPF_PASS,UNPARSEABLE_RELAY,USER_IN_DEF_DKIM_WL,
	USER_IN_DEF_SPF_WL autolearn=disabled version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-25) on lists.ozlabs.org

Hi Friendly,

On 2025/8/20 15:23, Friendy Su wrote:
> Set proper 'dsunit' to let file body align on huge page on blobdev,
> 
> where 'dsunit' * 'blocksize' = huge page size (2M).
> 
> When do mmap() a file mounted with dax=always, aligning on huge page
> makes kernel map huge page(2M) per page fault exception, compared with
> mapping normal page(4K) per page fault.
> 
> This greatly improves mmap() performance by reducing times of page
> fault being triggered.
> 
> Signed-off-by: Friendy Su <friendy.su@sony.com>
> Reviewed-by: Yuezhang Mo <Yuezhang.Mo@sony.com>
> Reviewed-by: Daniel Palmer <daniel.palmer@sony.com>

Sigh, thanks for the patch! Actually the blob chunk implementation
(this file) is now an implementation debt since:

  1) In principle, chunks (and deduplicated pclusters) should
     across blobs (considering the main device is also a blob);

  2) Each blob should have its own space allocation context
     which is independent to the in-memory chunk records...

My mid-term plan tends to use the current metabox way
(i.e. use buffer management for all extra blobs too..)

> ---
>   lib/blobchunk.c | 15 +++++++++++++++
>   1 file changed, 15 insertions(+)
> 
> diff --git a/lib/blobchunk.c b/lib/blobchunk.c
> index bbc69cf..e47afb5 100644
> --- a/lib/blobchunk.c
> +++ b/lib/blobchunk.c
> @@ -309,6 +309,21 @@ int erofs_blob_write_chunked_file(struct erofs_inode *inode, int fd,
>   	minextblks = BLK_ROUND_UP(sbi, inode->i_size);
>   	interval_start = 0;
>   
> +	/* Align file on 'dsunit' */
> +	if (sbi->bmgr->dsunit > 1) {
> +		off_t off = lseek(blobfile, 0, SEEK_CUR);
> +
> +		erofs_dbg("Try to round up 0x%llx to align on %d blocks (dsunit)",
> +				off, sbi->bmgr->dsunit);
> +		off = roundup(off, sbi->bmgr->dsunit * erofs_blksiz(sbi));
> +		if (lseek(blobfile, off, SEEK_SET) != off) {
> +			ret = -errno;
> +			erofs_err("lseek to blobdev 0x%llx error", off);
> +			goto err;
> +		}
> +		erofs_dbg("Aligned on 0x%llx", off);
> +	}

But since you have use case on the current chunk
approach, so...

As for this patch, what if the inode itself is
chunk-deduplicated, could we apply this if the inode
only has one new chunk instead at least for now?

Thanks,
Gao Xiang

