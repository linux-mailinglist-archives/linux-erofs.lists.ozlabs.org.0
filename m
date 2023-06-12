Return-Path: <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>
X-Original-To: lists+linux-erofs@lfdr.de
Delivered-To: lists+linux-erofs@lfdr.de
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	by mail.lfdr.de (Postfix) with ESMTPS id 62EB772B592
	for <lists+linux-erofs@lfdr.de>; Mon, 12 Jun 2023 05:02:02 +0200 (CEST)
Received: from boromir.ozlabs.org (localhost [IPv6:::1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4Qfc0l251kz30BZ
	for <lists+linux-erofs@lfdr.de>; Mon, 12 Jun 2023 13:01:59 +1000 (AEST)
X-Original-To: linux-erofs@lists.ozlabs.org
Delivered-To: linux-erofs@lists.ozlabs.org
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=linux.alibaba.com (client-ip=115.124.30.124; helo=out30-124.freemail.mail.aliyun.com; envelope-from=hsiangkao@linux.alibaba.com; receiver=lists.ozlabs.org)
Received: from out30-124.freemail.mail.aliyun.com (out30-124.freemail.mail.aliyun.com [115.124.30.124])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4Qfc0c42ggz2ydP
	for <linux-erofs@lists.ozlabs.org>; Mon, 12 Jun 2023 13:01:50 +1000 (AEST)
X-Alimail-AntiSpam: AC=PASS;BC=-1|-1;BR=01201311R321e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=ay29a033018046056;MF=hsiangkao@linux.alibaba.com;NM=1;PH=DS;RN=5;SR=0;TI=SMTPD_---0VkqZAnr_1686538903;
Received: from 30.97.48.163(mailfrom:hsiangkao@linux.alibaba.com fp:SMTPD_---0VkqZAnr_1686538903)
          by smtp.aliyun-inc.com;
          Mon, 12 Jun 2023 11:01:44 +0800
Message-ID: <f95ac1ef-3f35-7f20-7d79-af82a8dd3ce2@linux.alibaba.com>
Date: Mon, 12 Jun 2023 11:01:39 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:102.0)
 Gecko/20100101 Thunderbird/102.10.0
Subject: Re: [PATCH v6 4/5] erofs: unify inline/share xattr iterators for
 listxattr/getxattr
To: Jingbo Xu <jefflexu@linux.alibaba.com>, chao@kernel.org,
 huyue2@coolpad.com, linux-erofs@lists.ozlabs.org
References: <20230608113020.66626-1-jefflexu@linux.alibaba.com>
 <20230608113020.66626-5-jefflexu@linux.alibaba.com>
From: Gao Xiang <hsiangkao@linux.alibaba.com>
In-Reply-To: <20230608113020.66626-5-jefflexu@linux.alibaba.com>
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



On 2023/6/8 19:30, Jingbo Xu wrote:
> Make inline_getxattr() and inline_listxattr() unified as
> iter_inline_xattr(), shared_getxattr() and shared_listxattr() unified as

erofs_xattr_iter_inline() as well as shared_getxattr() and
shared_listxattr() unified as erofs_xattr_iter_shared() ?

> iter_shared_xattr().
> 
> After the unification, both iter_inline_xattr() and iter_shared_xattr()
> return 0 on success, and negative error on failure.

After these changes, both erofs_xattr_iter_{inline,shared} return 0 on
success, and negative values on failure.

> 
> One thing worth noting is that, the logic of returning it->buffer_ofs
> when there's no shared xattrs in shared_listxattr() is moved to
> erofs_listxattr() to make the unification possible.  The only difference
> is that, semantically the old behavior will return ENOATTR rather than
> it->buffer_ofs if ENOATTR encountered when listxattr is parsing upon a
> specific shared xattr, while now the new behavior will return
> it->buffer_ofs in this case.  This is not an issue, as listxattr upon a
> specific xattr won't return ENOATTR.
> 
> Signed-off-by: Jingbo Xu <jefflexu@linux.alibaba.com>

Otherwise it looks good to me.

Thanks,
Gao Xiang

> ---
>   fs/erofs/xattr.c | 188 ++++++++++++++++++-----------------------------
>   1 file changed, 73 insertions(+), 115 deletions(-)
> 
> diff --git a/fs/erofs/xattr.c b/fs/erofs/xattr.c
> index 4ae9b7cdd3ac..15a1a4042205 100644
> --- a/fs/erofs/xattr.c
> +++ b/fs/erofs/xattr.c
> @@ -139,27 +139,6 @@ struct xattr_iter_handlers {
>   		      unsigned int len);
>   };
>   
> -static int inline_xattr_iter_begin(struct erofs_xattr_iter *it,
> -				   struct inode *inode)
> -{
> -	struct erofs_inode *const vi = EROFS_I(inode);
> -	unsigned int xattr_header_sz;
> -
> -	xattr_header_sz = sizeof(struct erofs_xattr_ibody_header) +
> -			  sizeof(u32) * vi->xattr_shared_count;
> -	if (xattr_header_sz >= vi->xattr_isize) {
> -		DBG_BUGON(xattr_header_sz > vi->xattr_isize);
> -		return -ENOATTR;
> -	}
> -
> -	it->pos = erofs_iloc(inode) + vi->inode_isize + xattr_header_sz;
> -	it->kaddr = erofs_bread(&it->buf, erofs_blknr(it->sb, it->pos),
> -				EROFS_KMAP);
> -	if (IS_ERR(it->kaddr))
> -		return PTR_ERR(it->kaddr);
> -	return vi->xattr_isize - xattr_header_sz;
> -}
> -
>   /*
>    * Regardless of success or failure, `xattr_foreach' will end up with
>    * `pos' pointing to the next xattr item rather than an arbitrary position.
> @@ -333,47 +312,6 @@ static const struct xattr_iter_handlers find_xattr_handlers = {
>   	.value = xattr_copyvalue
>   };
>   
> -static int inline_getxattr(struct inode *inode, struct erofs_xattr_iter *it)
> -{
> -	int ret;
> -	unsigned int remaining;
> -
> -	ret = inline_xattr_iter_begin(it, inode);
> -	if (ret < 0)
> -		return ret;
> -
> -	remaining = ret;
> -	while (remaining) {
> -		ret = xattr_foreach(it, &find_xattr_handlers, &remaining);
> -		if (ret != -ENOATTR)
> -			break;
> -	}
> -	return ret ? ret : it->buffer_ofs;
> -}
> -
> -static int shared_getxattr(struct inode *inode, struct erofs_xattr_iter *it)
> -{
> -	struct erofs_inode *const vi = EROFS_I(inode);
> -	struct super_block *const sb = it->sb;
> -	unsigned int i, xsid;
> -	int ret = -ENOATTR;
> -
> -	for (i = 0; i < vi->xattr_shared_count; ++i) {
> -		xsid = vi->xattr_shared_xattrs[i];
> -		it->pos = erofs_pos(sb, EROFS_SB(sb)->xattr_blkaddr) +
> -				    xsid * sizeof(__u32);
> -		it->kaddr = erofs_bread(&it->buf, erofs_blknr(sb, it->pos),
> -					EROFS_KMAP);
> -		if (IS_ERR(it->kaddr))
> -			return PTR_ERR(it->kaddr);
> -
> -		ret = xattr_foreach(it, &find_xattr_handlers, NULL);
> -		if (ret != -ENOATTR)
> -			break;
> -	}
> -	return ret ? ret : it->buffer_ofs;
> -}
> -
>   static bool erofs_xattr_user_list(struct dentry *dentry)
>   {
>   	return test_opt(&EROFS_SB(dentry->d_sb)->opt, XATTR_USER);
> @@ -384,39 +322,6 @@ static bool erofs_xattr_trusted_list(struct dentry *dentry)
>   	return capable(CAP_SYS_ADMIN);
>   }
>   
> -int erofs_getxattr(struct inode *inode, int index,
> -		   const char *name,
> -		   void *buffer, size_t buffer_size)
> -{
> -	int ret;
> -	struct erofs_xattr_iter it;
> -
> -	if (!name)
> -		return -EINVAL;
> -
> -	ret = erofs_init_inode_xattrs(inode);
> -	if (ret)
> -		return ret;
> -
> -	it.index = index;
> -	it.name = (struct qstr)QSTR_INIT(name, strlen(name));
> -	if (it.name.len > EROFS_NAME_LEN)
> -		return -ERANGE;
> -
> -	it.sb = inode->i_sb;
> -	it.buf = __EROFS_BUF_INITIALIZER;
> -	erofs_init_metabuf(&it.buf, it.sb);
> -	it.buffer = buffer;
> -	it.buffer_size = buffer_size;
> -	it.buffer_ofs = 0;
> -
> -	ret = inline_getxattr(inode, &it);
> -	if (ret == -ENOATTR)
> -		ret = shared_getxattr(inode, &it);
> -	erofs_put_metabuf(&it.buf);
> -	return ret;
> -}
> -
>   static int erofs_xattr_generic_get(const struct xattr_handler *handler,
>   				   struct dentry *unused, struct inode *inode,
>   				   const char *name, void *buffer, size_t size)
> @@ -521,31 +426,48 @@ static const struct xattr_iter_handlers list_xattr_handlers = {
>   	.value = NULL
>   };
>   
> -static int inline_listxattr(struct erofs_xattr_iter *it)
> +static int erofs_iter_inline_xattr(struct erofs_xattr_iter *it,
> +				   struct inode *inode, bool getxattr)
>   {
> +	struct erofs_inode *const vi = EROFS_I(inode);
> +	const struct xattr_iter_handlers *op;
> +	unsigned int xattr_header_sz, remaining;
>   	int ret;
> -	unsigned int remaining;
>   
> -	ret = inline_xattr_iter_begin(it, d_inode(it->dentry));
> -	if (ret < 0)
> -		return ret;
> +	xattr_header_sz = sizeof(struct erofs_xattr_ibody_header) +
> +			  sizeof(u32) * vi->xattr_shared_count;
> +	if (xattr_header_sz >= vi->xattr_isize) {
> +		DBG_BUGON(xattr_header_sz > vi->xattr_isize);
> +		return -ENOATTR;
> +	}
> +
> +	it->pos = erofs_iloc(inode) + vi->inode_isize + xattr_header_sz;
> +	it->kaddr = erofs_bread(&it->buf, erofs_blknr(it->sb, it->pos),
> +				EROFS_KMAP);
> +	if (IS_ERR(it->kaddr))
> +		return PTR_ERR(it->kaddr);
> +
> +	remaining = vi->xattr_isize - xattr_header_sz;
> +	op = getxattr ? &find_xattr_handlers : &list_xattr_handlers;
>   
> -	remaining = ret;
>   	while (remaining) {
> -		ret = xattr_foreach(it, &list_xattr_handlers, &remaining);
> -		if (ret)
> +		ret = xattr_foreach(it, op, &remaining);
> +		if ((getxattr && ret != -ENOATTR) || (!getxattr && ret))
>   			break;
>   	}
> -	return ret ? ret : it->buffer_ofs;
> +	return ret;
>   }
>   
> -static int shared_listxattr(struct erofs_xattr_iter *it)
> +static int erofs_iter_shared_xattr(struct erofs_xattr_iter *it,
> +				   struct inode *inode, bool getxattr)
>   {
> -	struct inode *const inode = d_inode(it->dentry);
>   	struct erofs_inode *const vi = EROFS_I(inode);
>   	struct super_block *const sb = it->sb;
> +	const struct xattr_iter_handlers *op;
>   	unsigned int i, xsid;
> -	int ret = 0;
> +	int ret = -ENOATTR;
> +
> +	op = getxattr ? &find_xattr_handlers : &list_xattr_handlers;
>   
>   	for (i = 0; i < vi->xattr_shared_count; ++i) {
>   		xsid = vi->xattr_shared_xattrs[i];
> @@ -556,11 +478,44 @@ static int shared_listxattr(struct erofs_xattr_iter *it)
>   		if (IS_ERR(it->kaddr))
>   			return PTR_ERR(it->kaddr);
>   
> -		ret = xattr_foreach(it, &list_xattr_handlers, NULL);
> -		if (ret)
> +		ret = xattr_foreach(it, op, NULL);
> +		if ((getxattr && ret != -ENOATTR) || (!getxattr && ret))
>   			break;
>   	}
> -	return ret ? ret : it->buffer_ofs;
> +	return ret;
> +}
> +
> +int erofs_getxattr(struct inode *inode, int index,
> +		   const char *name,
> +		   void *buffer, size_t buffer_size)
> +{
> +	int ret;
> +	struct erofs_xattr_iter it;
> +
> +	if (!name)
> +		return -EINVAL;
> +
> +	ret = erofs_init_inode_xattrs(inode);
> +	if (ret)
> +		return ret;
> +
> +	it.index = index;
> +	it.name = (struct qstr)QSTR_INIT(name, strlen(name));
> +	if (it.name.len > EROFS_NAME_LEN)
> +		return -ERANGE;
> +
> +	it.sb = inode->i_sb;
> +	it.buf = __EROFS_BUF_INITIALIZER;
> +	erofs_init_metabuf(&it.buf, it.sb);
> +	it.buffer = buffer;
> +	it.buffer_size = buffer_size;
> +	it.buffer_ofs = 0;
> +
> +	ret = erofs_iter_inline_xattr(&it, inode, true);
> +	if (ret == -ENOATTR)
> +		ret = erofs_iter_shared_xattr(&it, inode, true);
> +	erofs_put_metabuf(&it.buf);
> +	return ret ? ret : it.buffer_ofs;
>   }
>   
>   ssize_t erofs_listxattr(struct dentry *dentry,
> @@ -568,8 +523,9 @@ ssize_t erofs_listxattr(struct dentry *dentry,
>   {
>   	int ret;
>   	struct erofs_xattr_iter it;
> +	struct inode *inode = d_inode(dentry);
>   
> -	ret = erofs_init_inode_xattrs(d_inode(dentry));
> +	ret = erofs_init_inode_xattrs(inode);
>   	if (ret == -ENOATTR)
>   		return 0;
>   	if (ret)
> @@ -583,11 +539,13 @@ ssize_t erofs_listxattr(struct dentry *dentry,
>   	it.buffer_size = buffer_size;
>   	it.buffer_ofs = 0;
>   
> -	ret = inline_listxattr(&it);
> -	if (ret >= 0 || ret == -ENOATTR)
> -		ret = shared_listxattr(&it);
> +	ret = erofs_iter_inline_xattr(&it, inode, false);
> +	if (!ret || ret == -ENOATTR)
> +		ret = erofs_iter_shared_xattr(&it, inode, false);
> +	if (ret == -ENOATTR)
> +		ret = 0;
>   	erofs_put_metabuf(&it.buf);
> -	return ret;
> +	return ret ? ret : it.buffer_ofs;
>   }
>   
>   void erofs_xattr_prefixes_cleanup(struct super_block *sb)
