Return-Path: <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>
X-Original-To: lists+linux-erofs@lfdr.de
Delivered-To: lists+linux-erofs@lfdr.de
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2404:9400:2:0:216:3eff:fee1:b9f1])
	by mail.lfdr.de (Postfix) with ESMTPS id AE33F63ED45
	for <lists+linux-erofs@lfdr.de>; Thu,  1 Dec 2022 11:09:36 +0100 (CET)
Received: from boromir.ozlabs.org (localhost [IPv6:::1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4NNBdB04G2z3bXK
	for <lists+linux-erofs@lfdr.de>; Thu,  1 Dec 2022 21:09:34 +1100 (AEDT)
X-Original-To: linux-erofs@lists.ozlabs.org
Delivered-To: linux-erofs@lists.ozlabs.org
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=linux.alibaba.com (client-ip=115.124.30.42; helo=out30-42.freemail.mail.aliyun.com; envelope-from=jefflexu@linux.alibaba.com; receiver=<UNKNOWN>)
Received: from out30-42.freemail.mail.aliyun.com (out30-42.freemail.mail.aliyun.com [115.124.30.42])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4NNBd63Pzzz30QS
	for <linux-erofs@lists.ozlabs.org>; Thu,  1 Dec 2022 21:09:29 +1100 (AEDT)
X-Alimail-AntiSpam: AC=PASS;BC=-1|-1;BR=01201311R161e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=ay29a033018045170;MF=jefflexu@linux.alibaba.com;NM=1;PH=DS;RN=4;SR=0;TI=SMTPD_---0VW8IkAi_1669889363;
Received: from 30.221.129.69(mailfrom:jefflexu@linux.alibaba.com fp:SMTPD_---0VW8IkAi_1669889363)
          by smtp.aliyun-inc.com;
          Thu, 01 Dec 2022 18:09:24 +0800
Message-ID: <016136f8-7402-3f57-0e16-1a3f3ec055ec@linux.alibaba.com>
Date: Thu, 1 Dec 2022 18:09:23 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:102.0)
 Gecko/20100101 Thunderbird/102.4.0
Subject: Re: [PATCH v2] erofs: use kmap_local_page() only for erofs_bread()
Content-Language: en-US
To: Gao Xiang <hsiangkao@linux.alibaba.com>, linux-erofs@lists.ozlabs.org,
 Chao Yu <chao@kernel.org>
References: <20221018105313.4940-1-hsiangkao@linux.alibaba.com>
From: Jingbo Xu <jefflexu@linux.alibaba.com>
In-Reply-To: <20221018105313.4940-1-hsiangkao@linux.alibaba.com>
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



On 10/18/22 6:53 PM, Gao Xiang wrote:
> Convert all mapped erofs_bread() users to use kmap_local_page()
> instead of kmap() or kmap_atomic().

Reviewed-and-tested-by: Jingbo Xu <jefflexu@linux.alibaba.com>

> 
> Signed-off-by: Gao Xiang <hsiangkao@linux.alibaba.com>
> ---
>  fs/erofs/data.c     | 8 ++------
>  fs/erofs/internal.h | 3 +--
>  fs/erofs/xattr.c    | 8 ++++----
>  fs/erofs/zmap.c     | 4 ++--
>  4 files changed, 9 insertions(+), 14 deletions(-)
> 
> diff --git a/fs/erofs/data.c b/fs/erofs/data.c
> index fe8ac0e163f7..fe1ae80284bf 100644
> --- a/fs/erofs/data.c
> +++ b/fs/erofs/data.c
> @@ -13,9 +13,7 @@
>  void erofs_unmap_metabuf(struct erofs_buf *buf)
>  {
>  	if (buf->kmap_type == EROFS_KMAP)
> -		kunmap(buf->page);
> -	else if (buf->kmap_type == EROFS_KMAP_ATOMIC)
> -		kunmap_atomic(buf->base);
> +		kunmap_local(buf->base);
>  	buf->base = NULL;
>  	buf->kmap_type = EROFS_NO_KMAP;
>  }
> @@ -54,9 +52,7 @@ void *erofs_bread(struct erofs_buf *buf, struct inode *inode,
>  	}
>  	if (buf->kmap_type == EROFS_NO_KMAP) {
>  		if (type == EROFS_KMAP)
> -			buf->base = kmap(page);
> -		else if (type == EROFS_KMAP_ATOMIC)
> -			buf->base = kmap_atomic(page);
> +			buf->base = kmap_local_page(page);
>  		buf->kmap_type = type;
>  	} else if (buf->kmap_type != type) {
>  		DBG_BUGON(1);
> diff --git a/fs/erofs/internal.h b/fs/erofs/internal.h
> index 1701df48c446..67dc8e177211 100644
> --- a/fs/erofs/internal.h
> +++ b/fs/erofs/internal.h
> @@ -253,8 +253,7 @@ static inline int erofs_wait_on_workgroup_freezed(struct erofs_workgroup *grp)
>  
>  enum erofs_kmap_type {
>  	EROFS_NO_KMAP,		/* don't map the buffer */
> -	EROFS_KMAP,		/* use kmap() to map the buffer */
> -	EROFS_KMAP_ATOMIC,	/* use kmap_atomic() to map the buffer */
> +	EROFS_KMAP,		/* use kmap_local_page() to map the buffer */
>  };
>  
>  struct erofs_buf {
> diff --git a/fs/erofs/xattr.c b/fs/erofs/xattr.c
> index 8106bcb5a38d..a62fb8a3318a 100644
> --- a/fs/erofs/xattr.c
> +++ b/fs/erofs/xattr.c
> @@ -148,7 +148,7 @@ static inline int xattr_iter_fixup(struct xattr_iter *it)
>  
>  	it->blkaddr += erofs_blknr(it->ofs);
>  	it->kaddr = erofs_read_metabuf(&it->buf, it->sb, it->blkaddr,
> -				       EROFS_KMAP_ATOMIC);
> +				       EROFS_KMAP);
>  	if (IS_ERR(it->kaddr))
>  		return PTR_ERR(it->kaddr);
>  	it->ofs = erofs_blkoff(it->ofs);
> @@ -174,7 +174,7 @@ static int inline_xattr_iter_begin(struct xattr_iter *it,
>  	it->ofs = erofs_blkoff(iloc(sbi, vi->nid) + inline_xattr_ofs);
>  
>  	it->kaddr = erofs_read_metabuf(&it->buf, inode->i_sb, it->blkaddr,
> -				       EROFS_KMAP_ATOMIC);
> +				       EROFS_KMAP);
>  	if (IS_ERR(it->kaddr))
>  		return PTR_ERR(it->kaddr);
>  	return vi->xattr_isize - xattr_header_sz;
> @@ -368,7 +368,7 @@ static int shared_getxattr(struct inode *inode, struct getxattr_iter *it)
>  
>  		it->it.ofs = xattrblock_offset(sbi, vi->xattr_shared_xattrs[i]);
>  		it->it.kaddr = erofs_read_metabuf(&it->it.buf, sb, blkaddr,
> -						  EROFS_KMAP_ATOMIC);
> +						  EROFS_KMAP);
>  		if (IS_ERR(it->it.kaddr))
>  			return PTR_ERR(it->it.kaddr);
>  		it->it.blkaddr = blkaddr;
> @@ -580,7 +580,7 @@ static int shared_listxattr(struct listxattr_iter *it)
>  
>  		it->it.ofs = xattrblock_offset(sbi, vi->xattr_shared_xattrs[i]);
>  		it->it.kaddr = erofs_read_metabuf(&it->it.buf, sb, blkaddr,
> -						  EROFS_KMAP_ATOMIC);
> +						  EROFS_KMAP);
>  		if (IS_ERR(it->it.kaddr))
>  			return PTR_ERR(it->it.kaddr);
>  		it->it.blkaddr = blkaddr;
> diff --git a/fs/erofs/zmap.c b/fs/erofs/zmap.c
> index 0bb66927e3d0..749a5ac943f4 100644
> --- a/fs/erofs/zmap.c
> +++ b/fs/erofs/zmap.c
> @@ -178,7 +178,7 @@ static int legacy_load_cluster_from_disk(struct z_erofs_maprecorder *m,
>  	unsigned int advise, type;
>  
>  	m->kaddr = erofs_read_metabuf(&m->map->buf, inode->i_sb,
> -				      erofs_blknr(pos), EROFS_KMAP_ATOMIC);
> +				      erofs_blknr(pos), EROFS_KMAP);
>  	if (IS_ERR(m->kaddr))
>  		return PTR_ERR(m->kaddr);
>  
> @@ -416,7 +416,7 @@ static int compacted_load_cluster_from_disk(struct z_erofs_maprecorder *m,
>  out:
>  	pos += lcn * (1 << amortizedshift);
>  	m->kaddr = erofs_read_metabuf(&m->map->buf, inode->i_sb,
> -				      erofs_blknr(pos), EROFS_KMAP_ATOMIC);
> +				      erofs_blknr(pos), EROFS_KMAP);
>  	if (IS_ERR(m->kaddr))
>  		return PTR_ERR(m->kaddr);
>  	return unpack_compacted_index(m, amortizedshift, pos, lookahead);

-- 
Thanks,
Jingbo
