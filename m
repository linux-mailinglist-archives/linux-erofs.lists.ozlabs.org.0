Return-Path: <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>
X-Original-To: lists+linux-erofs@lfdr.de
Delivered-To: lists+linux-erofs@lfdr.de
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	by mail.lfdr.de (Postfix) with ESMTPS id 49E598A390A
	for <lists+linux-erofs@lfdr.de>; Sat, 13 Apr 2024 02:07:25 +0200 (CEST)
Authentication-Results: lists.ozlabs.org;
	dkim=pass (1024-bit key; unprotected) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.a=rsa-sha256 header.s=default header.b=FPTrRkpo;
	dkim-atps=neutral
Received: from boromir.ozlabs.org (localhost [IPv6:::1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4VGYf22GPrz3dVq
	for <lists+linux-erofs@lfdr.de>; Sat, 13 Apr 2024 10:07:22 +1000 (AEST)
X-Original-To: linux-erofs@lists.ozlabs.org
Delivered-To: linux-erofs@lists.ozlabs.org
Authentication-Results: lists.ozlabs.org;
	dkim=pass (1024-bit key; unprotected) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.a=rsa-sha256 header.s=default header.b=FPTrRkpo;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=linux.alibaba.com (client-ip=115.124.30.124; helo=out30-124.freemail.mail.aliyun.com; envelope-from=hsiangkao@linux.alibaba.com; receiver=lists.ozlabs.org)
Received: from out30-124.freemail.mail.aliyun.com (out30-124.freemail.mail.aliyun.com [115.124.30.124])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4VGYdt3Jqjz3cGK
	for <linux-erofs@lists.ozlabs.org>; Sat, 13 Apr 2024 10:07:12 +1000 (AEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=linux.alibaba.com; s=default;
	t=1712966827; h=Message-ID:Date:MIME-Version:Subject:To:From:Content-Type;
	bh=pUEQxCXjsGtX9OSkyEOEehJyz44qW8S9v9fHxWxErx0=;
	b=FPTrRkpocmsS3GxEmZ+uw1LFQzGEFVc3tQVZZEzWYqXBTkO25SesmcxI8sui0RMQboySrI5jL67EIdFy9dRFQvGT9lyoDfeRXulTm4TMM1g/PtcX5FHQwR8ClxhOoYUUs7M3WD6CRkneuwGj0avxrZJnA2Bj0IFZ3u5EDDP0Cic=
X-Alimail-AntiSpam: AC=PASS;BC=-1|-1;BR=01201311R131e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=ay29a033018046059;MF=hsiangkao@linux.alibaba.com;NM=1;PH=DS;RN=4;SR=0;TI=SMTPD_---0W4PFAtN_1712966824;
Received: from 30.25.221.111(mailfrom:hsiangkao@linux.alibaba.com fp:SMTPD_---0W4PFAtN_1712966824)
          by smtp.aliyun-inc.com;
          Sat, 13 Apr 2024 08:07:05 +0800
Message-ID: <4a37b61c-ee55-4663-8b99-220c3931a524@linux.alibaba.com>
Date: Sat, 13 Apr 2024 08:07:03 +0800
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2] erofs-utils: lib: treat data blocks filled with 0s as
 a hole
To: Sandeep Dhavale <dhavale@google.com>, linux-erofs@lists.ozlabs.org
References: <20240409221430.3897453-1-dhavale@google.com>
From: Gao Xiang <hsiangkao@linux.alibaba.com>
In-Reply-To: <20240409221430.3897453-1-dhavale@google.com>
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

On 2024/4/10 06:14, Sandeep Dhavale wrote:
> Add optimization to treat data blocks filled with 0s as a hole.
> Even though diskspace savings are comparable to chunk based or dedupe,
> having no block assigned saves us redundant disk IOs during read.
> 
> To detect blocks filled with zeros during chunking, we insert block
> filled with zeros (zerochunk) in the hashmap. If we detect a possible
> dedupe, we map it to the hole so there is no physical block assigned.
> 
> Signed-off-by: Sandeep Dhavale <dhavale@google.com>
> ---
> Changes since v1:
> 	- Instead of checking every block for 0s word by word,
> 	  add a zerochunk in blobs during init. So we effectively
> 	  detect the zero blocks by comparing the hash.
>   include/erofs/blobchunk.h |  2 +-
>   lib/blobchunk.c           | 41 ++++++++++++++++++++++++++++++++++++---
>   mkfs/main.c               |  2 +-
>   3 files changed, 40 insertions(+), 5 deletions(-)
> 
> diff --git a/include/erofs/blobchunk.h b/include/erofs/blobchunk.h
> index a674640..ebe2efe 100644
> --- a/include/erofs/blobchunk.h
> +++ b/include/erofs/blobchunk.h
> @@ -23,7 +23,7 @@ int erofs_write_zero_inode(struct erofs_inode *inode);
>   int tarerofs_write_chunkes(struct erofs_inode *inode, erofs_off_t data_offset);
>   int erofs_mkfs_dump_blobs(struct erofs_sb_info *sbi);
>   void erofs_blob_exit(void);
> -int erofs_blob_init(const char *blobfile_path);
> +int erofs_blob_init(const char *blobfile_path, erofs_off_t chunksize);
>   int erofs_mkfs_init_devices(struct erofs_sb_info *sbi, unsigned int devices);
>   
>   #ifdef __cplusplus
> diff --git a/lib/blobchunk.c b/lib/blobchunk.c
> index 641e3d4..87c153f 100644
> --- a/lib/blobchunk.c
> +++ b/lib/blobchunk.c
> @@ -323,13 +323,21 @@ int erofs_blob_write_chunked_file(struct erofs_inode *inode, int fd,
>   			ret = -EIO;
>   			goto err;
>   		}
> -
>   		chunk = erofs_blob_getchunk(sbi, chunkdata, len);
>   		if (IS_ERR(chunk)) {
>   			ret = PTR_ERR(chunk);
>   			goto err;
>   		}


Sorry for late reply since I'm working on multi-threaded mkfs.

Can erofs_blob_getchunk directly return &erofs_holechunk? I mean,

static struct erofs_blobchunk *erofs_blob_getchunk(struct erofs_sb_info *sbi,
						u8 *buf, erofs_off_t chunksize)
{
...
	chunk = hashmap_get_from_hash(&blob_hashmap, hash, sha256);
	if (chunk) {
		DBG_BUGON(chunksize != chunk->chunksize);

		if (chunk->blkaddr == erofs_holechunk.blkaddr)
			chunk = &erofs_holechunk;

		sbi->saved_by_deduplication += chunksize;
		erofs_dbg("Found duplicated chunk at %u", chunk->blkaddr);
		return chunk;
	}
...
}

>   
> +		if (chunk->blkaddr == erofs_holechunk.blkaddr) {
> +			*(void **)idx++ = &erofs_holechunk;
> +			erofs_update_minextblks(sbi, interval_start, pos,
> +						&minextblks);
> +			interval_start = pos + len;


I guess several zerochunks can also be merged?  is this line
an expected behavior?

> +			lastch = NULL;
> +			continue;
> +		}
> +
>   		if (lastch && (lastch->device_id != chunk->device_id ||
>   		    erofs_pos(sbi, lastch->blkaddr) + lastch->chunksize !=
>   		    erofs_pos(sbi, chunk->blkaddr))) {

I guess we could form a helper like
static bool erofs_blob_can_merge(struct erofs_sb_info *sbi,
			    struct erofs_blobchunk *lastch,
			    struct erofs_blobchunk *chunk)
{
	if (lastch == &erofs_holechunk && chunk == &erofs_holechunk)
		return true;
	if (lastch->device_id == chunk->device_id &&
	    erofs_pos(sbi, lastch->blkaddr) + lastch->chunksize ==
	    erofs_pos(sbi, chunk->blkaddr))
		return true;
	return false;
}

		if (lastch && erofs_blob_can_merge(sbi, lastch, chunk)) {
			...
		}



> @@ -540,7 +548,34 @@ void erofs_blob_exit(void)
>   	}
>   }
>   
> -int erofs_blob_init(const char *blobfile_path)
> +static int erofs_insert_zerochunk(erofs_off_t chunksize)
> +{
> +	u8 *zeros;
> +	struct erofs_blobchunk *chunk;
> +	u8 sha256[32];
> +	unsigned int hash;
> +
> +	zeros = calloc(1, chunksize);
> +	if (!zeros)
> +		return -ENOMEM;
> +
> +	erofs_sha256(zeros, chunksize, sha256);
> +	hash = memhash(sha256, sizeof(sha256));


`zeros` needs to be freed here I guess:
	free(zeros);

Thanks,
Gao Xiang

> +	chunk = malloc(sizeof(struct erofs_blobchunk));
> +	if (!chunk)
> +		return -ENOMEM;> +
> +	chunk->chunksize = chunksize;
> +	/* treat chunk filled with zeros as hole */
> +	chunk->blkaddr = erofs_holechunk.blkaddr;
> +	memcpy(chunk->sha256, sha256, sizeof(sha256));
> +
> +	hashmap_entry_init(&chunk->ent, hash);
> +	hashmap_add(&blob_hashmap, chunk);
> +	return 0;
> +}
> +
