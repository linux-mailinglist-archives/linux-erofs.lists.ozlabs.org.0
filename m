Return-Path: <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>
X-Original-To: lists+linux-erofs@lfdr.de
Delivered-To: lists+linux-erofs@lfdr.de
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	by mail.lfdr.de (Postfix) with ESMTPS id E2674717734
	for <lists+linux-erofs@lfdr.de>; Wed, 31 May 2023 08:53:22 +0200 (CEST)
Received: from boromir.ozlabs.org (localhost [IPv6:::1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4QWKjB1qxxz3f4W
	for <lists+linux-erofs@lfdr.de>; Wed, 31 May 2023 16:53:18 +1000 (AEST)
X-Original-To: linux-erofs@lists.ozlabs.org
Delivered-To: linux-erofs@lists.ozlabs.org
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=linux.alibaba.com (client-ip=115.124.30.100; helo=out30-100.freemail.mail.aliyun.com; envelope-from=hsiangkao@linux.alibaba.com; receiver=<UNKNOWN>)
Received: from out30-100.freemail.mail.aliyun.com (out30-100.freemail.mail.aliyun.com [115.124.30.100])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4QWKj64ccLz3bcF
	for <linux-erofs@lists.ozlabs.org>; Wed, 31 May 2023 16:53:13 +1000 (AEST)
X-Alimail-AntiSpam: AC=PASS;BC=-1|-1;BR=01201311R761e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=ay29a033018045168;MF=hsiangkao@linux.alibaba.com;NM=1;PH=DS;RN=6;SR=0;TI=SMTPD_---0VjwVV5u_1685515985;
Received: from 30.221.133.46(mailfrom:hsiangkao@linux.alibaba.com fp:SMTPD_---0VjwVV5u_1685515985)
          by smtp.aliyun-inc.com;
          Wed, 31 May 2023 14:53:06 +0800
Message-ID: <577b11e6-75f5-c07d-76c3-bb2f166a601b@linux.alibaba.com>
Date: Wed, 31 May 2023 14:53:04 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:102.0)
 Gecko/20100101 Thunderbird/102.10.0
Subject: Re: [PATCH v4 2/5] erofs: unify xattr_iter structures
To: Jingbo Xu <jefflexu@linux.alibaba.com>, xiang@kernel.org,
 chao@kernel.org, huyue2@coolpad.com, linux-erofs@lists.ozlabs.org
References: <20230531031330.3504-1-jefflexu@linux.alibaba.com>
 <20230531031330.3504-3-jefflexu@linux.alibaba.com>
From: Gao Xiang <hsiangkao@linux.alibaba.com>
In-Reply-To: <20230531031330.3504-3-jefflexu@linux.alibaba.com>
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
> Unify xattr_iter/listxattr_iter/getxattr_iter structures into
> erofs_xattr_iter structure.
> 
> This is in preparation for the following further cleanup.
> 
> Signed-off-by: Jingbo Xu <jefflexu@linux.alibaba.com>
> ---
>   fs/erofs/xattr.c | 155 ++++++++++++++++++++---------------------------
>   1 file changed, 65 insertions(+), 90 deletions(-)
> 
> diff --git a/fs/erofs/xattr.c b/fs/erofs/xattr.c
> index df6c4e6f1f4e..dffca38a46fd 100644
> --- a/fs/erofs/xattr.c
> +++ b/fs/erofs/xattr.c
> @@ -20,16 +20,25 @@ static inline unsigned int erofs_xattr_blkoff(struct super_block *sb,
>   	return erofs_blkoff(sb, xattr_id * sizeof(__u32));
>   }
>   
> -struct xattr_iter {
> +struct erofs_xattr_iter {
>   	struct super_block *sb;
>   	struct erofs_buf buf;
>   	void *kaddr;
> -
>   	erofs_blk_t blkaddr;
>   	unsigned int ofs;
> +
> +	char *buffer;
> +	int buffer_size, buffer_ofs;
> +
> +	/* getxattr */
> +	int index, infix_len;
> +	struct qstr name;
> +
> +	/* listxattr */
> +	struct dentry *dentry;
>   };
>   
> -static inline int erofs_xattr_iter_fixup(struct xattr_iter *it, bool nospan)
> +static inline int erofs_xattr_iter_fixup(struct erofs_xattr_iter *it, bool nospan)
>   {
>   	if (it->ofs < it->sb->s_blocksize)
>   		return 0;
> @@ -50,7 +59,7 @@ static inline int erofs_xattr_iter_fixup(struct xattr_iter *it, bool nospan)
>   static int erofs_init_inode_xattrs(struct inode *inode)
>   {
>   	struct erofs_inode *const vi = EROFS_I(inode);
> -	struct xattr_iter it;
> +	struct erofs_xattr_iter it;
>   	unsigned int i;
>   	struct erofs_xattr_ibody_header *ih;
>   	struct super_block *sb = inode->i_sb;
> @@ -153,15 +162,15 @@ static int erofs_init_inode_xattrs(struct inode *inode)
>    *                            and need to be handled
>    */
>   struct xattr_iter_handlers {
> -	int (*entry)(struct xattr_iter *_it, struct erofs_xattr_entry *entry);
> -	int (*name)(struct xattr_iter *_it, unsigned int processed, char *buf,
> +	int (*entry)(struct erofs_xattr_iter *it, struct erofs_xattr_entry *entry);
> +	int (*name)(struct erofs_xattr_iter *it, unsigned int processed, char *buf,
>   		    unsigned int len);
> -	int (*alloc_buffer)(struct xattr_iter *_it, unsigned int value_sz);
> -	void (*value)(struct xattr_iter *_it, unsigned int processed, char *buf,
> +	int (*alloc_buffer)(struct erofs_xattr_iter *it, unsigned int value_sz);
> +	void (*value)(struct erofs_xattr_iter *it, unsigned int processed, char *buf,
>   		      unsigned int len);
>   };
>   
> -static int inline_xattr_iter_begin(struct xattr_iter *it,
> +static int inline_xattr_iter_begin(struct erofs_xattr_iter *it,
>   				   struct inode *inode)
>   {
>   	struct erofs_inode *const vi = EROFS_I(inode);
> @@ -189,7 +198,7 @@ static int inline_xattr_iter_begin(struct xattr_iter *it,
>    * Regardless of success or failure, `xattr_foreach' will end up with
>    * `ofs' pointing to the next xattr item rather than an arbitrary position.
>    */
> -static int xattr_foreach(struct xattr_iter *it,
> +static int xattr_foreach(struct erofs_xattr_iter *it,
>   			 const struct xattr_iter_handlers *op,
>   			 unsigned int *tlimit)
>   {
> @@ -280,18 +289,10 @@ static int xattr_foreach(struct xattr_iter *it,
>   	return err < 0 ? err : 0;
>   }
>   
> -struct getxattr_iter {
> -	struct xattr_iter it;
> -
> -	char *buffer;
> -	int buffer_size, index, infix_len;
> -	struct qstr name;
> -};
> -
> -static int erofs_xattr_long_entrymatch(struct getxattr_iter *it,
> +static int erofs_xattr_long_entrymatch(struct erofs_xattr_iter *it,
>   				       struct erofs_xattr_entry *entry)
>   {
> -	struct erofs_sb_info *sbi = EROFS_SB(it->it.sb);
> +	struct erofs_sb_info *sbi = EROFS_SB(it->sb);
>   	struct erofs_xattr_prefix_item *pf = sbi->xattr_prefixes +
>   		(entry->e_name_index & EROFS_XATTR_LONG_PREFIX_MASK);
>   
> @@ -309,11 +310,9 @@ static int erofs_xattr_long_entrymatch(struct getxattr_iter *it,
>   	return 0;
>   }
>   
> -static int xattr_entrymatch(struct xattr_iter *_it,
> +static int xattr_entrymatch(struct erofs_xattr_iter *it,
>   			    struct erofs_xattr_entry *entry)
>   {
> -	struct getxattr_iter *it = container_of(_it, struct getxattr_iter, it);
> -
>   	/* should also match the infix for long name prefixes */
>   	if (entry->e_name_index & EROFS_XATTR_LONG_PREFIX)
>   		return erofs_xattr_long_entrymatch(it, entry);
> @@ -325,32 +324,27 @@ static int xattr_entrymatch(struct xattr_iter *_it,
>   	return 0;
>   }
>   
> -static int xattr_namematch(struct xattr_iter *_it,
> +static int xattr_namematch(struct erofs_xattr_iter *it,
>   			   unsigned int processed, char *buf, unsigned int len)
>   {
> -	struct getxattr_iter *it = container_of(_it, struct getxattr_iter, it);
> -
>   	if (memcmp(buf, it->name.name + it->infix_len + processed, len))
>   		return -ENOATTR;
>   	return 0;
>   }
>   
> -static int xattr_checkbuffer(struct xattr_iter *_it,
> +static int xattr_checkbuffer(struct erofs_xattr_iter *it,
>   			     unsigned int value_sz)
>   {
> -	struct getxattr_iter *it = container_of(_it, struct getxattr_iter, it);
>   	int err = it->buffer_size < value_sz ? -ERANGE : 0;
>   
>   	it->buffer_size = value_sz;
>   	return !it->buffer ? 1 : err;
>   }
>   
> -static void xattr_copyvalue(struct xattr_iter *_it,
> +static void xattr_copyvalue(struct erofs_xattr_iter *it,
>   			    unsigned int processed,
>   			    char *buf, unsigned int len)
>   {
> -	struct getxattr_iter *it = container_of(_it, struct getxattr_iter, it);
> -
>   	memcpy(it->buffer + processed, buf, len);
>   }
>   
> @@ -361,41 +355,40 @@ static const struct xattr_iter_handlers find_xattr_handlers = {
>   	.value = xattr_copyvalue
>   };
>   
> -static int inline_getxattr(struct inode *inode, struct getxattr_iter *it)
> +static int inline_getxattr(struct inode *inode, struct erofs_xattr_iter *it)
>   {
>   	int ret;
>   	unsigned int remaining;
>   
> -	ret = inline_xattr_iter_begin(&it->it, inode);
> +	ret = inline_xattr_iter_begin(it, inode);
>   	if (ret < 0)
>   		return ret;
>   
>   	remaining = ret;
>   	while (remaining) {
> -		ret = xattr_foreach(&it->it, &find_xattr_handlers, &remaining);
> +		ret = xattr_foreach(it, &find_xattr_handlers, &remaining);
>   		if (ret != -ENOATTR)
>   			break;
>   	}
>   	return ret ? ret : it->buffer_size;
>   }
>   
> -static int shared_getxattr(struct inode *inode, struct getxattr_iter *it)
> +static int shared_getxattr(struct inode *inode, struct erofs_xattr_iter *it)
>   {
>   	struct erofs_inode *const vi = EROFS_I(inode);
> -	struct super_block *const sb = it->it.sb;
> +	struct super_block *const sb = it->sb;
>   	unsigned int i, xsid;
>   	int ret = -ENOATTR;
>   
>   	for (i = 0; i < vi->xattr_shared_count; ++i) {
>   		xsid = vi->xattr_shared_xattrs[i];
> -		it->it.blkaddr = erofs_xattr_blkaddr(sb, xsid);
> -		it->it.ofs = erofs_xattr_blkoff(sb, xsid);
> -		it->it.kaddr = erofs_read_metabuf(&it->it.buf, sb,
> -						  it->it.blkaddr, EROFS_KMAP);
> -		if (IS_ERR(it->it.kaddr))
> -			return PTR_ERR(it->it.kaddr);
> -
> -		ret = xattr_foreach(&it->it, &find_xattr_handlers, NULL);
> +		it->blkaddr = erofs_xattr_blkaddr(sb, xsid);
> +		it->ofs = erofs_xattr_blkoff(sb, xsid);
> +		it->kaddr = erofs_read_metabuf(&it->buf, sb, it->blkaddr, EROFS_KMAP);

could we use erofs_bread() here?

> +		if (IS_ERR(it->kaddr))
> +			return PTR_ERR(it->kaddr);
> +
> +		ret = xattr_foreach(it, &find_xattr_handlers, NULL);
>   		if (ret != -ENOATTR)
>   			break;
>   	}
> @@ -417,7 +410,7 @@ int erofs_getxattr(struct inode *inode, int index,
>   		   void *buffer, size_t buffer_size)
>   {
>   	int ret;
> -	struct getxattr_iter it;
> +	struct erofs_xattr_iter it;
>   
>   	if (!name)
>   		return -EINVAL;
> @@ -427,22 +420,21 @@ int erofs_getxattr(struct inode *inode, int index,
>   		return ret;
>   
>   	it.index = index;
> -	it.name.len = strlen(name);
> +	it.name = (struct qstr)QSTR_INIT(name, strlen(name));
>   	if (it.name.len > EROFS_NAME_LEN)
>   		return -ERANGE;
>   
> -	it.it.sb = inode->i_sb;
> -	it.it.buf = __EROFS_BUF_INITIALIZER;
> -	erofs_init_metabuf(&it.it.buf, it.it.sb);
> -	it.name.name = name;
> -
> +	it.sb = inode->i_sb;
> +	it.buf = __EROFS_BUF_INITIALIZER;
> +	erofs_init_metabuf(&it.buf, it.sb);
>   	it.buffer = buffer;
>   	it.buffer_size = buffer_size;
> +	it.buffer_ofs = 0;
>   
>   	ret = inline_getxattr(inode, &it);
>   	if (ret == -ENOATTR)
>   		ret = shared_getxattr(inode, &it);
> -	erofs_put_metabuf(&it.it.buf);
> +	erofs_put_metabuf(&it.buf);
>   	return ret;
>   }
>   
> @@ -488,25 +480,15 @@ const struct xattr_handler *erofs_xattr_handlers[] = {
>   	NULL,
>   };
>   
> -struct listxattr_iter {
> -	struct xattr_iter it;
> -
> -	struct dentry *dentry;
> -	char *buffer;
> -	int buffer_size, buffer_ofs;
> -};
> -
> -static int xattr_entrylist(struct xattr_iter *_it,
> +static int xattr_entrylist(struct erofs_xattr_iter *it,
>   			   struct erofs_xattr_entry *entry)
>   {
> -	struct listxattr_iter *it =
> -		container_of(_it, struct listxattr_iter, it);
>   	unsigned int base_index = entry->e_name_index;
>   	unsigned int prefix_len, infix_len = 0;
>   	const char *prefix, *infix = NULL;
>   
>   	if (entry->e_name_index & EROFS_XATTR_LONG_PREFIX) {
> -		struct erofs_sb_info *sbi = EROFS_SB(_it->sb);
> +		struct erofs_sb_info *sbi = EROFS_SB(it->sb);
>   		struct erofs_xattr_prefix_item *pf = sbi->xattr_prefixes +
>   			(entry->e_name_index & EROFS_XATTR_LONG_PREFIX_MASK);
>   
> @@ -538,23 +520,17 @@ static int xattr_entrylist(struct xattr_iter *_it,
>   	return 0;
>   }
>   
> -static int xattr_namelist(struct xattr_iter *_it,
> +static int xattr_namelist(struct erofs_xattr_iter *it,
>   			  unsigned int processed, char *buf, unsigned int len)
>   {
> -	struct listxattr_iter *it =
> -		container_of(_it, struct listxattr_iter, it);
> -
>   	memcpy(it->buffer + it->buffer_ofs, buf, len);
>   	it->buffer_ofs += len;
>   	return 0;
>   }
>   
> -static int xattr_skipvalue(struct xattr_iter *_it,
> +static int xattr_skipvalue(struct erofs_xattr_iter *it,
>   			   unsigned int value_sz)
>   {
> -	struct listxattr_iter *it =
> -		container_of(_it, struct listxattr_iter, it);
> -
>   	it->buffer[it->buffer_ofs++] = '\0';
>   	return 1;
>   }
> @@ -566,42 +542,41 @@ static const struct xattr_iter_handlers list_xattr_handlers = {
>   	.value = NULL
>   };
>   
> -static int inline_listxattr(struct listxattr_iter *it)
> +static int inline_listxattr(struct erofs_xattr_iter *it)
>   {
>   	int ret;
>   	unsigned int remaining;
>   
> -	ret = inline_xattr_iter_begin(&it->it, d_inode(it->dentry));
> +	ret = inline_xattr_iter_begin(it, d_inode(it->dentry));
>   	if (ret < 0)
>   		return ret;
>   
>   	remaining = ret;
>   	while (remaining) {
> -		ret = xattr_foreach(&it->it, &list_xattr_handlers, &remaining);
> +		ret = xattr_foreach(it, &list_xattr_handlers, &remaining);
>   		if (ret)
>   			break;
>   	}
>   	return ret ? ret : it->buffer_ofs;
>   }
>   
> -static int shared_listxattr(struct listxattr_iter *it)
> +static int shared_listxattr(struct erofs_xattr_iter *it)
>   {
>   	struct inode *const inode = d_inode(it->dentry);
>   	struct erofs_inode *const vi = EROFS_I(inode);
> -	struct super_block *const sb = it->it.sb;
> +	struct super_block *const sb = it->sb;
>   	unsigned int i, xsid;
>   	int ret = 0;
>   
>   	for (i = 0; i < vi->xattr_shared_count; ++i) {
>   		xsid = vi->xattr_shared_xattrs[i];
> -		it->it.blkaddr = erofs_xattr_blkaddr(sb, xsid);
> -		it->it.ofs = erofs_xattr_blkoff(sb, xsid);
> -		it->it.kaddr = erofs_read_metabuf(&it->it.buf, sb,
> -						  it->it.blkaddr, EROFS_KMAP);
> -		if (IS_ERR(it->it.kaddr))
> -			return PTR_ERR(it->it.kaddr);
> -
> -		ret = xattr_foreach(&it->it, &list_xattr_handlers, NULL);
> +		it->blkaddr = erofs_xattr_blkaddr(sb, xsid);
> +		it->ofs = erofs_xattr_blkoff(sb, xsid);
> +		it->kaddr = erofs_read_metabuf(&it->buf, sb, it->blkaddr, EROFS_KMAP);

Same here.

Thanks,
Gao Xiang
