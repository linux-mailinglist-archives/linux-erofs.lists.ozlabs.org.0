Return-Path: <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>
X-Original-To: lists+linux-erofs@lfdr.de
Delivered-To: lists+linux-erofs@lfdr.de
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	by mail.lfdr.de (Postfix) with ESMTPS id 6668C974C6B
	for <lists+linux-erofs@lfdr.de>; Wed, 11 Sep 2024 10:20:45 +0200 (CEST)
Received: from boromir.ozlabs.org (localhost [IPv6:::1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4X3YRb2y4xz2ym2
	for <lists+linux-erofs@lfdr.de>; Wed, 11 Sep 2024 18:20:43 +1000 (AEST)
X-Original-To: linux-erofs@lists.ozlabs.org
Delivered-To: linux-erofs@lists.ozlabs.org
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip=115.124.30.130
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1726042839;
	cv=none; b=BdKZtlI5NpvIqT5FTpLzXrKiwJW2Wfha7rQjZWDkzRPVpGY4PszYte6+HZpqlMjbWToD/pjjUgIJYHfgsgkEjpMh6DfLCrwAu5RWbDFhx3cFKRFwEs/LEnVPcSXH/t8euly2aLoJph6I+1pQi1pSYoSsDqHlyXhKSgBQ1zl1Cj7h6E43f1MgUj1R0w6hyEjUPbOCyJSBvF4qEmKbiKf5II01m6PP4YEifOtiEaWMV29iYs5+hVnaNb+46F37GI4F79XKDXK8+lbMczGyRY9Lu7xY/a5N3U1iSezDQeldyjPiOfiweaSN1+xA1UI5tz3wx6wxOL52rOMlppfWbaMcSA==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1726042839; c=relaxed/relaxed;
	bh=x3fR03PePcFCfbboLycf9V7wBs0ih3fws7jOmpdlhPU=;
	h=Message-ID:Date:MIME-Version:Subject:To:References:From:
	 In-Reply-To:Content-Type; b=hgSw62Q5SVDhZkehM3+02fHvWzSE1AXq4cTo8+PqAAvFhQVNI1/4x8mqmfKG5SwM/EpvMSxbmC/3zjtt4qtZLwYXsVhp9pMm0EbL7rKmJ9lXyVlCLdfaNurGeelS+XzbZdpDOCO5KVG8UsE2aiwS5RYMVJw4ukbmj13C0tonnz36yN/y1sjRzge1mpJ2FDHIPKwxBTnD3KT1cG1TO5UdpZxM0WAYdjfTOhZxnHnVJCjM5uOLzglBa70vKXQqRwGfsnmDsMJ771olfdja4kuAR+gVFXAaEaVS9lYcTGK0AHqvx4KeKANFRjW0WiLzXl2hysevVAH6J04qZVszixeW2w==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com; dkim=pass (1024-bit key; unprotected) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.a=rsa-sha256 header.s=default header.b=dPag2WQ7; dkim-atps=neutral; spf=pass (client-ip=115.124.30.130; helo=out30-130.freemail.mail.aliyun.com; envelope-from=hsiangkao@linux.alibaba.com; receiver=lists.ozlabs.org) smtp.mailfrom=linux.alibaba.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (1024-bit key; unprotected) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.a=rsa-sha256 header.s=default header.b=dPag2WQ7;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=linux.alibaba.com (client-ip=115.124.30.130; helo=out30-130.freemail.mail.aliyun.com; envelope-from=hsiangkao@linux.alibaba.com; receiver=lists.ozlabs.org)
Received: from out30-130.freemail.mail.aliyun.com (out30-130.freemail.mail.aliyun.com [115.124.30.130])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4X3YRV2MLgz2xHW
	for <linux-erofs@lists.ozlabs.org>; Wed, 11 Sep 2024 18:20:36 +1000 (AEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=linux.alibaba.com; s=default;
	t=1726042832; h=Message-ID:Date:MIME-Version:Subject:To:From:Content-Type;
	bh=x3fR03PePcFCfbboLycf9V7wBs0ih3fws7jOmpdlhPU=;
	b=dPag2WQ7zv+TspEbJWQqyI89Pf594pBTxz7y/VOd3Pyvhm1bn2luhlzEjU273yU0PlfWRZlKgzp3/ktMv2xR3bUUx7Y+SYG9RuUHi7lSAi88lZC+T9RnQHooKw29+bs9NQlEPUp4eGvGP6G3tyoNa5rdnS4P1jRpQwkiV5Kf3Yo=
Received: from 30.221.130.129(mailfrom:hsiangkao@linux.alibaba.com fp:SMTPD_---0WEn9ZF8_1726042830)
          by smtp.aliyun-inc.com;
          Wed, 11 Sep 2024 16:20:31 +0800
Message-ID: <89b7325e-3344-42f8-bf0e-845640f4efda@linux.alibaba.com>
Date: Wed, 11 Sep 2024 16:20:30 +0800
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] erofs-utils: lib: fix the incorrect nblocks number under
 chunk mode
To: Hongzhen Luo <hongzhen@linux.alibaba.com>, linux-erofs@lists.ozlabs.org
References: <20240911081020.2088531-1-hongzhen@linux.alibaba.com>
From: Gao Xiang <hsiangkao@linux.alibaba.com>
In-Reply-To: <20240911081020.2088531-1-hongzhen@linux.alibaba.com>
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



On 2024/9/11 16:10, Hongzhen Luo wrote:
> Currently, in chunk mode, the number of blocks (nblocks) for the last
> chunk written to the blocklist file is the size of the chunk, which may
> not be consistent with the size of the original file in the last chunk.
> This patch writes the actual number of blocks of the file in the last
> chunk to the blocklist file.

subject:

erofs-utils: lib: fix incorrect nblocks in block list for chunked inodes

Currently, the number of physical blocks (nblocks) for the last chunk
written to the block list file is incorrectly recorded as the inode
chunksize.

This patch writes the actual number of physical blocks for the inode in
the last chunk to the block list file.

> 
> Signed-off-by: Hongzhen Luo <hongzhen@linux.alibaba.com>
> ---
>   lib/blobchunk.c | 9 +++++++--
>   1 file changed, 7 insertions(+), 2 deletions(-)
> 
> diff --git a/lib/blobchunk.c b/lib/blobchunk.c
> index 33dadd5..40b731b 100644
> --- a/lib/blobchunk.c
> +++ b/lib/blobchunk.c
> @@ -135,6 +135,7 @@ int erofs_blob_write_chunk_indexes(struct erofs_inode *inode,
>   {
>   	struct erofs_inode_chunk_index idx = {0};
>   	erofs_blk_t extent_start = EROFS_NULL_ADDR;
> +	erofs_blk_t front_blks = 0, tail_blks;

Personally I think it can be improved as:

	erofs_blk_t remaining_blks = BLK_ROUND_UP(inode->sbi, inode->i_size);

>   	erofs_blk_t extent_end, chunkblks;
>   	erofs_off_t source_offset;
>   	unsigned int dst, src, unit;
> @@ -165,6 +166,7 @@ int erofs_blob_write_chunk_indexes(struct erofs_inode *inode,
>   		if (extent_start == EROFS_NULL_ADDR ||
>   		    idx.blkaddr != extent_end) {
>   			if (extent_start != EROFS_NULL_ADDR) {
> +				front_blks += extent_end - extent_start;

				remaining_blks -= extent_end - extent_start;

>   				tarerofs_blocklist_write(extent_start,
>   						extent_end - extent_start,
>   						source_offset);
> @@ -187,9 +189,12 @@ int erofs_blob_write_chunk_indexes(struct erofs_inode *inode,
>   			memcpy(inode->chunkindexes + dst, &idx, sizeof(idx));
>   	}
>   	off = roundup(off, unit);

	extent_end = min(extent_end, extent_start + remaining_blks);

Thanks,
Gao Xiang

> -	if (extent_start != EROFS_NULL_ADDR)
> -		tarerofs_blocklist_write(extent_start, extent_end - extent_start,
> +	if (extent_start != EROFS_NULL_ADDR) {
> +		tail_blks = BLK_ROUND_UP(inode->sbi, inode->i_size)
> +			    - front_blks;
> +		tarerofs_blocklist_write(extent_start, tail_blks,
>   					 source_offset);
> +	}
>   	erofs_droid_blocklist_write_extent(inode, extent_start,
>   			extent_start == EROFS_NULL_ADDR ?
>   					0 : extent_end - extent_start,

