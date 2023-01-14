Return-Path: <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>
X-Original-To: lists+linux-erofs@lfdr.de
Delivered-To: lists+linux-erofs@lfdr.de
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	by mail.lfdr.de (Postfix) with ESMTPS id A09D666AA0F
	for <lists+linux-erofs@lfdr.de>; Sat, 14 Jan 2023 09:21:27 +0100 (CET)
Received: from boromir.ozlabs.org (localhost [IPv6:::1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4NvB8423wgz3fBl
	for <lists+linux-erofs@lfdr.de>; Sat, 14 Jan 2023 19:21:24 +1100 (AEDT)
X-Original-To: linux-erofs@lists.ozlabs.org
Delivered-To: linux-erofs@lists.ozlabs.org
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=linux.alibaba.com (client-ip=115.124.30.124; helo=out30-124.freemail.mail.aliyun.com; envelope-from=jefflexu@linux.alibaba.com; receiver=<UNKNOWN>)
Received: from out30-124.freemail.mail.aliyun.com (out30-124.freemail.mail.aliyun.com [115.124.30.124])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4NvB7w3hTTz3c8q
	for <linux-erofs@lists.ozlabs.org>; Sat, 14 Jan 2023 19:21:14 +1100 (AEDT)
X-Alimail-AntiSpam: AC=PASS;BC=-1|-1;BR=01201311R101e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=ay29a033018045168;MF=jefflexu@linux.alibaba.com;NM=1;PH=DS;RN=5;SR=0;TI=SMTPD_---0VZX-xcu_1673684468;
Received: from 192.168.31.66(mailfrom:jefflexu@linux.alibaba.com fp:SMTPD_---0VZX-xcu_1673684468)
          by smtp.aliyun-inc.com;
          Sat, 14 Jan 2023 16:21:09 +0800
Message-ID: <57611d57-121c-9fe4-777f-d20c96374e75@linux.alibaba.com>
Date: Sat, 14 Jan 2023 16:21:08 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:102.0)
 Gecko/20100101 Thunderbird/102.6.1
Subject: Re: [PATCH 1/2] erofs: clean up erofs_iget()
To: Gao Xiang <hsiangkao@linux.alibaba.com>, linux-erofs@lists.ozlabs.org,
 Chao Yu <chao@kernel.org>, Yue Hu <huyue2@coolpad.com>
References: <20230113065226.68801-1-hsiangkao@linux.alibaba.com>
Content-Language: en-US
From: Jingbo Xu <jefflexu@linux.alibaba.com>
In-Reply-To: <20230113065226.68801-1-hsiangkao@linux.alibaba.com>
Content-Type: text/plain; charset=UTF-8
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
Cc: LKML <linux-kernel@vger.kernel.org>
Errors-To: linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org
Sender: "Linux-erofs" <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>



On 1/13/23 2:52 PM, Gao Xiang wrote:
> Move inode hash function into inode.c and simplify erofs_iget().
> 
> Signed-off-by: Gao Xiang <hsiangkao@linux.alibaba.com>

Since the v2 triggers the compiling error, this v1 is also acceptable
for me.

Reviewed-by: Jingbo Xu <jefflexu@linux.alibaba.com>

> ---
>  fs/erofs/inode.c    | 40 +++++++++++++++++++++-------------------
>  fs/erofs/internal.h |  9 ---------
>  2 files changed, 21 insertions(+), 28 deletions(-)
> 
> diff --git a/fs/erofs/inode.c b/fs/erofs/inode.c
> index d3b8736fa124..57328691582e 100644
> --- a/fs/erofs/inode.c
> +++ b/fs/erofs/inode.c
> @@ -308,47 +308,49 @@ static int erofs_fill_inode(struct inode *inode)
>  }
>  
>  /*
> - * erofs nid is 64bits, but i_ino is 'unsigned long', therefore
> - * we should do more for 32-bit platform to find the right inode.
> + * ino_t is 32-bits on 32-bit arch. We have to squash the 64-bit value down
> + * so that it will fit.
>   */
> -static int erofs_ilookup_test_actor(struct inode *inode, void *opaque)
> +static ino_t erofs_squash_ino(erofs_nid_t nid)
>  {
> -	const erofs_nid_t nid = *(erofs_nid_t *)opaque;
> +	ino_t ino = (ino_t)nid;
> +
> +	if (sizeof(ino_t) < sizeof(erofs_nid_t))
> +		ino ^= nid >> (sizeof(erofs_nid_t) - sizeof(ino_t)) * 8;
> +	return ino;
> +}
>  
> -	return EROFS_I(inode)->nid == nid;
> +static int erofs_iget5_eq(struct inode *inode, void *opaque)
> +{
> +	return EROFS_I(inode)->nid == *(erofs_nid_t *)opaque;
>  }
>  
> -static int erofs_iget_set_actor(struct inode *inode, void *opaque)
> +static int erofs_iget5_set(struct inode *inode, void *opaque)
>  {
>  	const erofs_nid_t nid = *(erofs_nid_t *)opaque;
>  
> -	inode->i_ino = erofs_inode_hash(nid);
> +	inode->i_ino = erofs_squash_ino(nid);
> +	EROFS_I(inode)->nid = nid;
>  	return 0;
>  }
>  
>  struct inode *erofs_iget(struct super_block *sb, erofs_nid_t nid)
>  {
> -	const unsigned long hashval = erofs_inode_hash(nid);
>  	struct inode *inode;
>  
> -	inode = iget5_locked(sb, hashval, erofs_ilookup_test_actor,
> -		erofs_iget_set_actor, &nid);
> +	inode = iget5_locked(sb, erofs_squash_ino(nid), erofs_iget5_eq,
> +			     erofs_iget5_set, &nid);
>  	if (!inode)
>  		return ERR_PTR(-ENOMEM);
>  
>  	if (inode->i_state & I_NEW) {
> -		int err;
> -		struct erofs_inode *vi = EROFS_I(inode);
> -
> -		vi->nid = nid;
> +		int err = erofs_fill_inode(inode);
>  
> -		err = erofs_fill_inode(inode);
> -		if (!err) {
> -			unlock_new_inode(inode);
> -		} else {
> +		if (err) {
>  			iget_failed(inode);
> -			inode = ERR_PTR(err);
> +			return ERR_PTR(err);
>  		}
> +		unlock_new_inode(inode);
>  	}
>  	return inode;
>  }
> diff --git a/fs/erofs/internal.h b/fs/erofs/internal.h
> index bb8501c0ff5b..168c21f16383 100644
> --- a/fs/erofs/internal.h
> +++ b/fs/erofs/internal.h
> @@ -480,15 +480,6 @@ int erofs_map_blocks(struct inode *inode,
>  		     struct erofs_map_blocks *map, int flags);
>  
>  /* inode.c */
> -static inline unsigned long erofs_inode_hash(erofs_nid_t nid)
> -{
> -#if BITS_PER_LONG == 32
> -	return (nid >> 32) ^ (nid & 0xffffffff);
> -#else
> -	return nid;
> -#endif
> -}
> -
>  extern const struct inode_operations erofs_generic_iops;
>  extern const struct inode_operations erofs_symlink_iops;
>  extern const struct inode_operations erofs_fast_symlink_iops;

-- 
Thanks,
Jingbo
