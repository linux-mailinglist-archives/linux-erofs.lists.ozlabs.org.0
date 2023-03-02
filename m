Return-Path: <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>
X-Original-To: lists+linux-erofs@lfdr.de
Delivered-To: lists+linux-erofs@lfdr.de
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2404:9400:2:0:216:3eff:fee1:b9f1])
	by mail.lfdr.de (Postfix) with ESMTPS id D14556A8372
	for <lists+linux-erofs@lfdr.de>; Thu,  2 Mar 2023 14:24:00 +0100 (CET)
Received: from boromir.ozlabs.org (localhost [IPv6:::1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4PSBdV4tM0z3cNb
	for <lists+linux-erofs@lfdr.de>; Fri,  3 Mar 2023 00:23:58 +1100 (AEDT)
X-Original-To: linux-erofs@lists.ozlabs.org
Delivered-To: linux-erofs@lists.ozlabs.org
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=linux.alibaba.com (client-ip=115.124.30.110; helo=out30-110.freemail.mail.aliyun.com; envelope-from=hsiangkao@linux.alibaba.com; receiver=<UNKNOWN>)
Received: from out30-110.freemail.mail.aliyun.com (out30-110.freemail.mail.aliyun.com [115.124.30.110])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4PSBdP5xXnz3bZl
	for <linux-erofs@lists.ozlabs.org>; Fri,  3 Mar 2023 00:23:52 +1100 (AEDT)
X-Alimail-AntiSpam: AC=PASS;BC=-1|-1;BR=01201311R311e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=ay29a033018046059;MF=hsiangkao@linux.alibaba.com;NM=1;PH=DS;RN=6;SR=0;TI=SMTPD_---0VcxXSuE_1677763426;
Received: from 30.97.48.239(mailfrom:hsiangkao@linux.alibaba.com fp:SMTPD_---0VcxXSuE_1677763426)
          by smtp.aliyun-inc.com;
          Thu, 02 Mar 2023 21:23:47 +0800
Message-ID: <d729647f-df1c-07c5-3e55-b4424e4ebe5d@linux.alibaba.com>
Date: Thu, 2 Mar 2023 21:23:46 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:102.0)
 Gecko/20100101 Thunderbird/102.6.1
Subject: Re: [PATCH v3 2/2] erofs: set block size to the on-disk block size
To: Jingbo Xu <jefflexu@linux.alibaba.com>, xiang@kernel.org,
 chao@kernel.org, huyue2@coolpad.com, linux-erofs@lists.ozlabs.org
References: <20230220025046.103777-1-jefflexu@linux.alibaba.com>
 <20230220025046.103777-2-jefflexu@linux.alibaba.com>
From: Gao Xiang <hsiangkao@linux.alibaba.com>
In-Reply-To: <20230220025046.103777-2-jefflexu@linux.alibaba.com>
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
Cc: linux-kernel@vger.kernel.org
Errors-To: linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org
Sender: "Linux-erofs" <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>

Hi Jingbo,

On 2023/2/20 10:50, Jingbo Xu wrote:
> Set the block size to that specified in on-disk superblock.
> 
> Also remove the hard constraint of PAGE_SIZE block size for the
> uncompressed device backend.  This constraint is temporarily remained
> for compressed device and fscache backend, as there is more work needed
> to handle the condition where the block size is not equal to PAGE_SIZE.
> 
> It is worth noting that the on-disk block size is read prior to
> erofs_superblock_csum_verify(), as the read block size is needed in the
> latter.
> 
> Signed-off-by: Jingbo Xu <jefflexu@linux.alibaba.com>
> ---
>   fs/erofs/erofs_fs.h |  2 +-
>   fs/erofs/inode.c    |  3 ++-
>   fs/erofs/internal.h |  8 --------
>   fs/erofs/super.c    | 42 +++++++++++++++++++++++++++---------------
>   4 files changed, 30 insertions(+), 25 deletions(-)
> 
> diff --git a/fs/erofs/erofs_fs.h b/fs/erofs/erofs_fs.h
> index dbcd24371002..5c7647d68c07 100644
> --- a/fs/erofs/erofs_fs.h
> +++ b/fs/erofs/erofs_fs.h
> @@ -53,7 +53,7 @@ struct erofs_super_block {
>   	__le32 magic;           /* file system magic number */
>   	__le32 checksum;        /* crc32c(super_block) */
>   	__le32 feature_compat;
> -	__u8 blkszbits;         /* support block_size == PAGE_SIZE only */
> +	__u8 blkszbits;         /* filesystem block size */
>   	__u8 sb_extslots;	/* superblock size = 128 + sb_extslots * 16 */
>   
>   	__le16 root_nid;	/* nid of root directory */

Due to we already support < page_size blocks, laterly, we'd consider
refer to tar data blobs (which is 512-byte aligned) for OCI
containers.

So we will have another use case is to use 512-byte block size, but
in that case, dir block size is too small.

So I'd like to add a reserved bit
	__u8 dirblkbits;

for this.

> diff --git a/fs/erofs/inode.c b/fs/erofs/inode.c
> index de26dac4e07e..0e6ff8a98c68 100644
> --- a/fs/erofs/inode.c
> +++ b/fs/erofs/inode.c
> @@ -291,7 +291,8 @@ static int erofs_fill_inode(struct inode *inode)
>   	}
>   
>   	if (erofs_inode_is_data_compressed(vi->datalayout)) {
> -		if (!erofs_is_fscache_mode(inode->i_sb))
> +		if (!erofs_is_fscache_mode(inode->i_sb) &&
> +		    inode->i_sb->s_blocksize_bits == PAGE_SHIFT)
>   			err = z_erofs_fill_inode(inode);
>   		else
>   			err = -EOPNOTSUPP;
> diff --git a/fs/erofs/internal.h b/fs/erofs/internal.h
> index d8019d835405..612543915e9e 100644
> --- a/fs/erofs/internal.h
> +++ b/fs/erofs/internal.h
> @@ -240,14 +240,6 @@ static inline int erofs_wait_on_workgroup_freezed(struct erofs_workgroup *grp)
>   					VAL != EROFS_LOCKED_MAGIC);
>   }
>   
> -/* we strictly follow PAGE_SIZE and no buffer head yet */
> -#define LOG_BLOCK_SIZE		PAGE_SHIFT
> -#define EROFS_BLKSIZ		(1 << LOG_BLOCK_SIZE)
> -
> -#if (EROFS_BLKSIZ % 4096 || !EROFS_BLKSIZ)
> -#error erofs cannot be used in this platform
> -#endif
> -
>   enum erofs_kmap_type {
>   	EROFS_NO_KMAP,		/* don't map the buffer */
>   	EROFS_KMAP,		/* use kmap_local_page() to map the buffer */
> diff --git a/fs/erofs/super.c b/fs/erofs/super.c
> index c97615c96ef8..89011a4ed274 100644
> --- a/fs/erofs/super.c
> +++ b/fs/erofs/super.c
> @@ -349,6 +349,14 @@ static int erofs_read_superblock(struct super_block *sb)
>   		goto out;
>   	}
>   
> +	blkszbits = dsb->blkszbits;
> +	sbi->blkszbits = dsb->blkszbits;
> +	if (blkszbits < 9 || blkszbits > PAGE_SHIFT) {
> +		erofs_err(sb, "blkszbits %u isn't supported on this platform",
> +			  blkszbits);
> +		goto out;
> +	}

Also,
	if (blkszbits != PAGE_SHIFT && dsb->dirblkbits) {
		erofs_err("dirblkbits %u isn't supported", dsb->dirblkbits);
		goto out;
	}

Thanks,
Gao Xiang
