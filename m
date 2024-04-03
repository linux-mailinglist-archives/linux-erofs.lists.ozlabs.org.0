Return-Path: <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>
X-Original-To: lists+linux-erofs@lfdr.de
Delivered-To: lists+linux-erofs@lfdr.de
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2404:9400:2:0:216:3eff:fee1:b9f1])
	by mail.lfdr.de (Postfix) with ESMTPS id 0F5AE8964D5
	for <lists+linux-erofs@lfdr.de>; Wed,  3 Apr 2024 08:48:08 +0200 (CEST)
Authentication-Results: lists.ozlabs.org;
	dkim=pass (1024-bit key; unprotected) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.a=rsa-sha256 header.s=default header.b=oRJlfdtj;
	dkim-atps=neutral
Received: from boromir.ozlabs.org (localhost [IPv6:::1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4V8b115st9z3cWN
	for <lists+linux-erofs@lfdr.de>; Wed,  3 Apr 2024 17:48:05 +1100 (AEDT)
X-Original-To: linux-erofs@lists.ozlabs.org
Delivered-To: linux-erofs@lists.ozlabs.org
Authentication-Results: lists.ozlabs.org;
	dkim=pass (1024-bit key; unprotected) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.a=rsa-sha256 header.s=default header.b=oRJlfdtj;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=linux.alibaba.com (client-ip=115.124.30.101; helo=out30-101.freemail.mail.aliyun.com; envelope-from=hsiangkao@linux.alibaba.com; receiver=lists.ozlabs.org)
Received: from out30-101.freemail.mail.aliyun.com (out30-101.freemail.mail.aliyun.com [115.124.30.101])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4V8b0w0Yv6z3bpd
	for <linux-erofs@lists.ozlabs.org>; Wed,  3 Apr 2024 17:47:57 +1100 (AEDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=linux.alibaba.com; s=default;
	t=1712126873; h=Message-ID:Date:MIME-Version:Subject:To:From:Content-Type;
	bh=yDQzr6CWneSlfcl4tifGt5ymREEjFy8Ne9UNi7sxko4=;
	b=oRJlfdtjm6lbnHkBh1BUvuMaiWIBjb+gK5Ci+Tiyu6hms+TyB/138KpATJKA8GSBSsSitde+W0d8u6kyhKafz5ZtMUKoF6Su8niY8TUb5qOHkTwrr+s9VVJdWvbbX4erZeuXzcYqhW5rh+uaM1Hsri0VnyYjtT8IYwy66Hy6++0=
X-Alimail-AntiSpam: AC=PASS;BC=-1|-1;BR=01201311R161e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=ay29a033018046059;MF=hsiangkao@linux.alibaba.com;NM=1;PH=DS;RN=4;SR=0;TI=SMTPD_---0W3qmUT1_1712126871;
Received: from 30.97.48.165(mailfrom:hsiangkao@linux.alibaba.com fp:SMTPD_---0W3qmUT1_1712126871)
          by smtp.aliyun-inc.com;
          Wed, 03 Apr 2024 14:47:52 +0800
Message-ID: <db0f374f-6fc8-406e-ade8-19500b06ae66@linux.alibaba.com>
Date: Wed, 3 Apr 2024 14:47:50 +0800
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v1 1/1] erofs-utils: lib: Fix calculation of minextblks
 when working with sparse files
To: Sandeep Dhavale <dhavale@google.com>, linux-erofs@lists.ozlabs.org
References: <20240403062357.1705807-1-dhavale@google.com>
 <20240403062357.1705807-2-dhavale@google.com>
From: Gao Xiang <hsiangkao@linux.alibaba.com>
In-Reply-To: <20240403062357.1705807-2-dhavale@google.com>
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

On 2024/4/3 14:23, Sandeep Dhavale wrote:
> When we work with sparse files (files with holes), we need to consider
> when the contiguous data block starts after each hole to correctly calculate
> minextblks so we can merge consecutive chunks later.
> Now that we need to recalculate minextblks multiple places, put the logic
> in helper function for avoiding repetition and easier reading.
> 
> Fixes: 7b46f7a0160a (erofs-utils: lib: merge consecutive chunks if possible)
> Signed-off-by: Sandeep Dhavale <dhavale@google.com>

Thanks for catching this!

> ---
>   lib/blobchunk.c | 28 ++++++++++++++++++++++------
>   1 file changed, 22 insertions(+), 6 deletions(-)
> 
> diff --git a/lib/blobchunk.c b/lib/blobchunk.c
> index ee12194..41bee19 100644
> --- a/lib/blobchunk.c
> +++ b/lib/blobchunk.c
> @@ -223,6 +223,16 @@ out:
>   	return 0;
>   }
>   
> +static erofs_blk_t erofs_minblks_from_interval(struct erofs_sb_info *sbi,
> +			erofs_off_t start, erofs_off_t end, erofs_blk_t cur_min)
> +{
> +	erofs_blk_t lb;
> +	lb = lowbit((end - start) >> sbi->blkszbits);
> +	if (lb && lb < cur_min)
> +		return lb;
> +	return cur_min;
> +}

Just a minor thought, maybe

static erofs_blk_t erofs_update_minextblks(struct erofs_sb_info *sbi,
			erofs_off_t start, erofs_off_t end, erofs_blk_t *minextblks)
{
	erofs_blk_t lb;

	lb = lowbit((end - start) >> sbi->blkszbits);
	if (lb && lb < *minextblks)
		*minextblks = lb;
}

could be better (or just my own perference) since no input + output on a same
variable, otherwise it looks good to me.

If you agree on this minor nit, I could revise it directly or you could send
another version.  Both are fine with me :)

Thanks,
Gao Xiang

> +
>   int erofs_blob_write_chunked_file(struct erofs_inode *inode, int fd,
>   				  erofs_off_t startoff)
>   {
> @@ -231,8 +241,8 @@ int erofs_blob_write_chunked_file(struct erofs_inode *inode, int fd,
>   	unsigned int count, unit;
>   	struct erofs_blobchunk *chunk, *lastch;
>   	struct erofs_inode_chunk_index *idx;
> -	erofs_off_t pos, len, chunksize;
> -	erofs_blk_t lb, minextblks;
> +	erofs_off_t pos, len, chunksize, interval_start;
> +	erofs_blk_t minextblks;
>   	u8 *chunkdata;
>   	int ret;
>   
> @@ -267,9 +277,10 @@ int erofs_blob_write_chunked_file(struct erofs_inode *inode, int fd,
>   		goto err;
>   	}
>   	idx = inode->chunkindexes;
> -
>   	lastch = NULL;
>   	minextblks = BLK_ROUND_UP(sbi, inode->i_size);
> +	interval_start = 0;
> +
>   	for (pos = 0; pos < inode->i_size; pos += len) {
>   #ifdef SEEK_DATA
>   		off_t offset = lseek(fd, pos + startoff, SEEK_DATA);
> @@ -294,12 +305,15 @@ int erofs_blob_write_chunked_file(struct erofs_inode *inode, int fd,
>   
>   		if (offset > pos) {
>   			len = 0;
> +			minextblks = erofs_minblks_from_interval(sbi,
> +					   interval_start, pos, minextblks);
>   			do {
>   				*(void **)idx++ = &erofs_holechunk;
>   				pos += chunksize;
>   			} while (pos < offset);
>   			DBG_BUGON(pos != offset);
>   			lastch = NULL;
> +			interval_start = pos;
>   			continue;
>   		}
>   #endif
> @@ -320,13 +334,15 @@ int erofs_blob_write_chunked_file(struct erofs_inode *inode, int fd,
>   		if (lastch && (lastch->device_id != chunk->device_id ||
>   		    erofs_pos(sbi, lastch->blkaddr) + lastch->chunksize !=
>   		    erofs_pos(sbi, chunk->blkaddr))) {
> -			lb = lowbit(pos >> sbi->blkszbits);
> -			if (lb && lb < minextblks)
> -				minextblks = lb;
> +			minextblks = erofs_minblks_from_interval(sbi,
> +					    interval_start, pos, minextblks);
> +			interval_start = pos;
>   		}
>   		*(void **)idx++ = chunk;
>   		lastch = chunk;
>   	}
> +	minextblks = erofs_minblks_from_interval(sbi, interval_start, pos,
> +					minextblks);
>   	inode->datalayout = EROFS_INODE_CHUNK_BASED;
>   	free(chunkdata);
>   	return erofs_blob_mergechunks(inode, chunkbits,
