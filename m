Return-Path: <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>
X-Original-To: lists+linux-erofs@lfdr.de
Delivered-To: lists+linux-erofs@lfdr.de
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	by mail.lfdr.de (Postfix) with ESMTPS id 35BFE974CDF
	for <lists+linux-erofs@lfdr.de>; Wed, 11 Sep 2024 10:42:09 +0200 (CEST)
Received: from boromir.ozlabs.org (localhost [IPv6:::1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4X3YwG6CvLz2yn9
	for <lists+linux-erofs@lfdr.de>; Wed, 11 Sep 2024 18:42:06 +1000 (AEST)
X-Original-To: linux-erofs@lists.ozlabs.org
Delivered-To: linux-erofs@lists.ozlabs.org
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip=115.124.30.98
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1726044125;
	cv=none; b=Z8UdJEbLwgyDB5/Q5KMXciNQLgHy1aeG1NXZHrnewyx7nyJ8zzBaXrcW+DrmBbGg7yJYUjC3LzlthGueShDXbNf0Mr42v1WpaQTb/KDTSflvSBYK94kKohrC5nCZ8LpICdU5pQ4e93oQ96O8s4d7dtjOhg8YqRVs/16+MJfZILXJjzJg23ScOYR4TCPY9aYzRyKIZ+4sDOWgt1feyPo9mPSu+cgmG1uVYqosNtcCY9w7oHIqcigOyDkyGcWgxSsIW+6HdMFF+e9WeXMhoR3caSyO21Ft6dKl0b0D5Dok3Tgq2GdYfpesfEBkMYBhij/91NF+C8+rZ5Qda3nDKHqVxA==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1726044125; c=relaxed/relaxed;
	bh=C/cU7yrKj+xVwphjUGp6XR/sQ38wJAYXL3+lCFeTnXI=;
	h=Message-ID:Date:MIME-Version:Subject:To:References:From:
	 In-Reply-To:Content-Type; b=TEvpmROOoGbcmPRVH4qTmKbSqS7gkql/S9XWaNPD3BBT0yGqhc27TvxuYuelsUtwL0ZGUyXTT1DIsLANQutzyfOh3VIcEF3KklhKJIwsmR11ze1chGQcRhzNwZ+cv3ZXSa40E7MB3KGc79w64lHKXxr7q3jCMg5xRZyE+WdaOIbv3g/F10fscFS4l1VJNpBC5VecswaNoW5y+G2XwKccInMm80QAlDgpWX+5/FPwan2wBTUyk6B9xDthuBNOA7cd6nf1Wo3A8l8bAj+yAfX+jKO27jVrlRl1v7cXK2Cw0mzGYSfwz4bLLNeEpzND3Jmi8ZIYuNLXoyOI0qY4FUzc0w==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com; dkim=pass (1024-bit key; unprotected) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.a=rsa-sha256 header.s=default header.b=Pz72vGt+; dkim-atps=neutral; spf=pass (client-ip=115.124.30.98; helo=out30-98.freemail.mail.aliyun.com; envelope-from=hsiangkao@linux.alibaba.com; receiver=lists.ozlabs.org) smtp.mailfrom=linux.alibaba.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (1024-bit key; unprotected) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.a=rsa-sha256 header.s=default header.b=Pz72vGt+;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=linux.alibaba.com (client-ip=115.124.30.98; helo=out30-98.freemail.mail.aliyun.com; envelope-from=hsiangkao@linux.alibaba.com; receiver=lists.ozlabs.org)
Received: from out30-98.freemail.mail.aliyun.com (out30-98.freemail.mail.aliyun.com [115.124.30.98])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4X3YwC5fqQz2xdV
	for <linux-erofs@lists.ozlabs.org>; Wed, 11 Sep 2024 18:42:02 +1000 (AEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=linux.alibaba.com; s=default;
	t=1726044118; h=Message-ID:Date:MIME-Version:Subject:To:From:Content-Type;
	bh=C/cU7yrKj+xVwphjUGp6XR/sQ38wJAYXL3+lCFeTnXI=;
	b=Pz72vGt+5LBE5p1FO9LphOXWkH5W8gMqpjuDi9tNxCDXAUaoqqEmGkxOcmBQEehcYdO1R+3223N0huRbYNGBeOAjkWhD/9nVbQ1rxnA3PDcFVKcKnzq1s6Si4vgTlH6vW9lCfHrLXtRSUn/+gOXeWLdPLBV01DyhsVn8/LxwsFM=
Received: from 30.221.130.129(mailfrom:hsiangkao@linux.alibaba.com fp:SMTPD_---0WEnANc9_1726044116)
          by smtp.aliyun-inc.com;
          Wed, 11 Sep 2024 16:41:57 +0800
Message-ID: <3c8790b6-9b48-40a6-8e4f-fc5a27aa8370@linux.alibaba.com>
Date: Wed, 11 Sep 2024 16:41:56 +0800
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2] erofs-utils: lib: fix incorrect nblocks in block list
 for chunked inodes
To: Hongzhen Luo <hongzhen@linux.alibaba.com>, linux-erofs@lists.ozlabs.org
References: <20240911083539.2111707-1-hongzhen@linux.alibaba.com>
From: Gao Xiang <hsiangkao@linux.alibaba.com>
In-Reply-To: <20240911083539.2111707-1-hongzhen@linux.alibaba.com>
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
Errors-To: linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org
Sender: "Linux-erofs" <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>



On 2024/9/11 16:35, Hongzhen Luo wrote:
> Currently, the number of physical blocks (nblocks) for the last chunk
> written to the block list file is incorrectly recorded as the inode
> chunksize.
> 
> This patch writes the actual number of physical blocks for the inode in
> the last chunk to the block list file.
> 
> Signed-off-by: Hongzhen Luo <hongzhen@linux.alibaba.com>

I guess it fixes

Fixes: 7b46f7a0160a ("erofs-utils: lib: merge consecutive chunks if possible")
Fixes: b6749839e710 ("erofs-utils: generate preallocated extents for tarerofs")

?


> ---
>   lib/blobchunk.c | 6 +++++-
>   1 file changed, 5 insertions(+), 1 deletion(-)
> 
> diff --git a/lib/blobchunk.c b/lib/blobchunk.c
> index 33dadd5..a0f3d0e 100644
> --- a/lib/blobchunk.c
> +++ b/lib/blobchunk.c
> @@ -133,6 +133,7 @@ static int erofs_blob_hashmap_cmp(const void *a, const void *b,
>   int erofs_blob_write_chunk_indexes(struct erofs_inode *inode,
>   				   erofs_off_t off)
>   {
> +	erofs_blk_t remaining_blks = BLK_ROUND_UP(inode->sbi, inode->i_size);
>   	struct erofs_inode_chunk_index idx = {0};>   	erofs_blk_t extent_start = EROFS_NULL_ADDR;
>   	erofs_blk_t extent_end, chunkblks;
> @@ -165,6 +166,7 @@ int erofs_blob_write_chunk_indexes(struct erofs_inode *inode,
>   		if (extent_start == EROFS_NULL_ADDR ||
>   		    idx.blkaddr != extent_end) {
>   			if (extent_start != EROFS_NULL_ADDR) {
> +				remaining_blks -= extent_end - extent_start;
>   				tarerofs_blocklist_write(extent_start,
>   						extent_end - extent_start,
>   						source_offset);
> @@ -187,9 +189,11 @@ int erofs_blob_write_chunk_indexes(struct erofs_inode *inode,
>   			memcpy(inode->chunkindexes + dst, &idx, sizeof(idx));
>   	}
>   	off = roundup(off, unit);
> -	if (extent_start != EROFS_NULL_ADDR)
> +	if (extent_start != EROFS_NULL_ADDR) {

You should move extent_end out of this block since
erofs_droid_blocklist_write_extent() is impacted too.

Thanks,
Gao Xiang
