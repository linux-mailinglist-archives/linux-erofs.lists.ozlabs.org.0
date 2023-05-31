Return-Path: <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>
X-Original-To: lists+linux-erofs@lfdr.de
Delivered-To: lists+linux-erofs@lfdr.de
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2404:9400:2:0:216:3eff:fee1:b9f1])
	by mail.lfdr.de (Postfix) with ESMTPS id 4C1C771758D
	for <lists+linux-erofs@lfdr.de>; Wed, 31 May 2023 06:28:05 +0200 (CEST)
Received: from boromir.ozlabs.org (localhost [IPv6:::1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4QWGTZ63hlz3f4W
	for <lists+linux-erofs@lfdr.de>; Wed, 31 May 2023 14:28:02 +1000 (AEST)
X-Original-To: linux-erofs@lists.ozlabs.org
Delivered-To: linux-erofs@lists.ozlabs.org
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=linux.alibaba.com (client-ip=115.124.30.132; helo=out30-132.freemail.mail.aliyun.com; envelope-from=hsiangkao@linux.alibaba.com; receiver=<UNKNOWN>)
Received: from out30-132.freemail.mail.aliyun.com (out30-132.freemail.mail.aliyun.com [115.124.30.132])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4QWGTS5LLTz2xl6
	for <linux-erofs@lists.ozlabs.org>; Wed, 31 May 2023 14:27:54 +1000 (AEST)
X-Alimail-AntiSpam: AC=PASS;BC=-1|-1;BR=01201311R411e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=ay29a033018046050;MF=hsiangkao@linux.alibaba.com;NM=1;PH=DS;RN=6;SR=0;TI=SMTPD_---0Vjw5-Y4_1685507266;
Received: from 30.221.133.46(mailfrom:hsiangkao@linux.alibaba.com fp:SMTPD_---0Vjw5-Y4_1685507266)
          by smtp.aliyun-inc.com;
          Wed, 31 May 2023 12:27:47 +0800
Message-ID: <fba76567-0069-8181-0493-fc39b30ba4bc@linux.alibaba.com>
Date: Wed, 31 May 2023 12:27:45 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:102.0)
 Gecko/20100101 Thunderbird/102.10.0
Subject: Re: [PATCH v4 1/5] erofs: enhance erofs_xattr_iter_fixup() helper
To: Jingbo Xu <jefflexu@linux.alibaba.com>, xiang@kernel.org,
 chao@kernel.org, huyue2@coolpad.com, linux-erofs@lists.ozlabs.org
References: <20230531031330.3504-1-jefflexu@linux.alibaba.com>
 <20230531031330.3504-2-jefflexu@linux.alibaba.com>
From: Gao Xiang <hsiangkao@linux.alibaba.com>
In-Reply-To: <20230531031330.3504-2-jefflexu@linux.alibaba.com>
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



On 2023/5/31 11:13, Jingbo Xu wrote:
> Enhance erofs_xattr_iter_fixup() helper so that it could be reused in
> the situation where it.ofs could not span the block boundary.
> 
> Besides call erofs_init_metabuf() and erofs_bread() separately to avoid
> the repetition of assigning buf->inode when iterating xattrs.
> 
> Signed-off-by: Jingbo Xu <jefflexu@linux.alibaba.com>

Reviewed-by: Gao Xiang <hsiangkao@linux.alibaba.com>

Thanks,
Gao Xiang

> ---
>   fs/erofs/xattr.c | 82 +++++++++++++++++++++---------------------------
>   1 file changed, 35 insertions(+), 47 deletions(-)
> 
> diff --git a/fs/erofs/xattr.c b/fs/erofs/xattr.c
> index bbfe7ce170d2..df6c4e6f1f4e 100644
> --- a/fs/erofs/xattr.c
> +++ b/fs/erofs/xattr.c
> @@ -29,6 +29,24 @@ struct xattr_iter {
>   	unsigned int ofs;
>   };
>   
> +static inline int erofs_xattr_iter_fixup(struct xattr_iter *it, bool nospan)
> +{
> +	if (it->ofs < it->sb->s_blocksize)
> +		return 0;
> +
> +	if (nospan && it->ofs != it->sb->s_blocksize) {
> +		DBG_BUGON(1);
> +		return -EFSCORRUPTED;
> +	}
> +
> +	it->blkaddr += erofs_blknr(it->sb, it->ofs);
> +	it->kaddr = erofs_bread(&it->buf, it->blkaddr, EROFS_KMAP);
> +	if (IS_ERR(it->kaddr))
> +		return PTR_ERR(it->kaddr);
> +	it->ofs = erofs_blkoff(it->sb, it->ofs);
> +	return 0;
> +}
> +
>   static int erofs_init_inode_xattrs(struct inode *inode)
>   {
>   	struct erofs_inode *const vi = EROFS_I(inode);
> @@ -80,6 +98,7 @@ static int erofs_init_inode_xattrs(struct inode *inode)
>   		goto out_unlock;
>   	}
>   
> +	it.sb = sb;
>   	it.buf = __EROFS_BUF_INITIALIZER;
>   	it.blkaddr = erofs_blknr(sb, erofs_iloc(inode) + vi->inode_isize);
>   	it.ofs = erofs_blkoff(sb, erofs_iloc(inode) + vi->inode_isize);
> @@ -105,19 +124,11 @@ static int erofs_init_inode_xattrs(struct inode *inode)
>   	it.ofs += sizeof(struct erofs_xattr_ibody_header);
>   
>   	for (i = 0; i < vi->xattr_shared_count; ++i) {
> -		if (it.ofs >= sb->s_blocksize) {
> -			/* cannot be unaligned */
> -			DBG_BUGON(it.ofs != sb->s_blocksize);
> -
> -			it.kaddr = erofs_read_metabuf(&it.buf, sb, ++it.blkaddr,
> -						      EROFS_KMAP);
> -			if (IS_ERR(it.kaddr)) {
> -				kfree(vi->xattr_shared_xattrs);
> -				vi->xattr_shared_xattrs = NULL;
> -				ret = PTR_ERR(it.kaddr);
> -				goto out_unlock;
> -			}
> -			it.ofs = 0;
> +		ret = erofs_xattr_iter_fixup(&it, true);
> +		if (ret) {
> +			kfree(vi->xattr_shared_xattrs);
> +			vi->xattr_shared_xattrs = NULL;
> +			goto out_unlock;
>   		}
>   		vi->xattr_shared_xattrs[i] =
>   			le32_to_cpu(*(__le32 *)(it.kaddr + it.ofs));
> @@ -150,20 +161,6 @@ struct xattr_iter_handlers {
>   		      unsigned int len);
>   };
>   
> -static inline int xattr_iter_fixup(struct xattr_iter *it)
> -{
> -	if (it->ofs < it->sb->s_blocksize)
> -		return 0;
> -
> -	it->blkaddr += erofs_blknr(it->sb, it->ofs);
> -	it->kaddr = erofs_read_metabuf(&it->buf, it->sb, it->blkaddr,
> -				       EROFS_KMAP);
> -	if (IS_ERR(it->kaddr))
> -		return PTR_ERR(it->kaddr);
> -	it->ofs = erofs_blkoff(it->sb, it->ofs);
> -	return 0;
> -}
> -
>   static int inline_xattr_iter_begin(struct xattr_iter *it,
>   				   struct inode *inode)
>   {
> @@ -201,7 +198,7 @@ static int xattr_foreach(struct xattr_iter *it,
>   	int err;
>   
>   	/* 0. fixup blkaddr, ofs, ipage */
> -	err = xattr_iter_fixup(it);
> +	err = erofs_xattr_iter_fixup(it, false);
>   	if (err)
>   		return err;
>   
> @@ -236,14 +233,9 @@ static int xattr_foreach(struct xattr_iter *it,
>   	processed = 0;
>   
>   	while (processed < entry.e_name_len) {
> -		if (it->ofs >= it->sb->s_blocksize) {
> -			DBG_BUGON(it->ofs > it->sb->s_blocksize);
> -
> -			err = xattr_iter_fixup(it);
> -			if (err)
> -				goto out;
> -			it->ofs = 0;
> -		}
> +		err = erofs_xattr_iter_fixup(it, true);
> +		if (err)
> +			goto out;
>   
>   		slice = min_t(unsigned int, it->sb->s_blocksize - it->ofs,
>   			      entry.e_name_len - processed);
> @@ -271,14 +263,9 @@ static int xattr_foreach(struct xattr_iter *it,
>   	}
>   
>   	while (processed < value_sz) {
> -		if (it->ofs >= it->sb->s_blocksize) {
> -			DBG_BUGON(it->ofs > it->sb->s_blocksize);
> -
> -			err = xattr_iter_fixup(it);
> -			if (err)
> -				goto out;
> -			it->ofs = 0;
> -		}
> +		err = erofs_xattr_iter_fixup(it, true);
> +		if (err)
> +			goto out;
>   
>   		slice = min_t(unsigned int, it->sb->s_blocksize - it->ofs,
>   			      value_sz - processed);
> @@ -444,13 +431,14 @@ int erofs_getxattr(struct inode *inode, int index,
>   	if (it.name.len > EROFS_NAME_LEN)
>   		return -ERANGE;
>   
> +	it.it.sb = inode->i_sb;
>   	it.it.buf = __EROFS_BUF_INITIALIZER;
> +	erofs_init_metabuf(&it.it.buf, it.it.sb);
>   	it.name.name = name;
>   
>   	it.buffer = buffer;
>   	it.buffer_size = buffer_size;
>   
> -	it.it.sb = inode->i_sb;
>   	ret = inline_getxattr(inode, &it);
>   	if (ret == -ENOATTR)
>   		ret = shared_getxattr(inode, &it);
> @@ -632,14 +620,14 @@ ssize_t erofs_listxattr(struct dentry *dentry,
>   	if (ret)
>   		return ret;
>   
> +	it.it.sb = dentry->d_sb;
>   	it.it.buf = __EROFS_BUF_INITIALIZER;
> +	erofs_init_metabuf(&it.it.buf, it.it.sb);
>   	it.dentry = dentry;
>   	it.buffer = buffer;
>   	it.buffer_size = buffer_size;
>   	it.buffer_ofs = 0;
>   
> -	it.it.sb = dentry->d_sb;
> -
>   	ret = inline_listxattr(&it);
>   	if (ret >= 0 || ret == -ENOATTR)
>   		ret = shared_listxattr(&it);
