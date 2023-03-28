Return-Path: <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>
X-Original-To: lists+linux-erofs@lfdr.de
Delivered-To: lists+linux-erofs@lfdr.de
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	by mail.lfdr.de (Postfix) with ESMTPS id 514B86CB949
	for <lists+linux-erofs@lfdr.de>; Tue, 28 Mar 2023 10:23:55 +0200 (CEST)
Received: from boromir.ozlabs.org (localhost [IPv6:::1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4Pm2l43vTsz3f3n
	for <lists+linux-erofs@lfdr.de>; Tue, 28 Mar 2023 19:23:44 +1100 (AEDT)
X-Original-To: linux-erofs@lists.ozlabs.org
Delivered-To: linux-erofs@lists.ozlabs.org
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=linux.alibaba.com (client-ip=115.124.30.132; helo=out30-132.freemail.mail.aliyun.com; envelope-from=hsiangkao@linux.alibaba.com; receiver=<UNKNOWN>)
Received: from out30-132.freemail.mail.aliyun.com (out30-132.freemail.mail.aliyun.com [115.124.30.132])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4Pm2kx5Nnxz3cfh
	for <linux-erofs@lists.ozlabs.org>; Tue, 28 Mar 2023 19:23:36 +1100 (AEDT)
X-Alimail-AntiSpam: AC=PASS;BC=-1|-1;BR=01201311R211e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=ay29a033018045192;MF=hsiangkao@linux.alibaba.com;NM=1;PH=DS;RN=6;SR=0;TI=SMTPD_---0VesLht8_1679991810;
Received: from 30.221.134.40(mailfrom:hsiangkao@linux.alibaba.com fp:SMTPD_---0VesLht8_1679991810)
          by smtp.aliyun-inc.com;
          Tue, 28 Mar 2023 16:23:31 +0800
Message-ID: <75330f12-1652-a4b2-8c15-c059f73fd669@linux.alibaba.com>
Date: Tue, 28 Mar 2023 16:23:29 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:102.0)
 Gecko/20100101 Thunderbird/102.9.0
Subject: Re: [PATCH 1/8] erofs: move several xattr helpers into xattr.c
To: Jingbo Xu <jefflexu@linux.alibaba.com>, xiang@kernel.org,
 chao@kernel.org, huyue2@coolpad.com, linux-erofs@lists.ozlabs.org
References: <20230323000949.57608-1-jefflexu@linux.alibaba.com>
 <20230323000949.57608-2-jefflexu@linux.alibaba.com>
From: Gao Xiang <hsiangkao@linux.alibaba.com>
In-Reply-To: <20230323000949.57608-2-jefflexu@linux.alibaba.com>
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



On 2023/3/23 08:09, Jingbo Xu wrote:
> There are several xattr helpers not used outside xattr.c, thus move them
> into xattr.c as a cleanup.
> 
> inlinexattr_header_size() has only one caller, and thus make it inlined
> into the caller directly.
> 
> Signed-off-by: Jingbo Xu <jefflexu@linux.alibaba.com>
> ---
>   fs/erofs/xattr.c | 73 +++++++++++++++++++++++++++++++++---------------
>   fs/erofs/xattr.h | 56 -------------------------------------
>   2 files changed, 51 insertions(+), 78 deletions(-)
> 
> diff --git a/fs/erofs/xattr.c b/fs/erofs/xattr.c
> index 459caa3cd65d..760ec864a39c 100644
> --- a/fs/erofs/xattr.c
> +++ b/fs/erofs/xattr.c
> @@ -7,6 +7,19 @@
>   #include <linux/security.h>
>   #include "xattr.h"
>   
> +static inline erofs_blk_t erofs_xattr_blkaddr(struct super_block *sb,
> +					      unsigned int xattr_id)
> +{
> +	return EROFS_SB(sb)->xattr_blkaddr +
> +	       erofs_blknr(sb, xattr_id * sizeof(__u32));
> +}
> +
> +static inline unsigned int erofs_xattr_blkoff(struct super_block *sb,
> +					      unsigned int xattr_id)
> +{
> +	return erofs_blkoff(sb, xattr_id * sizeof(__u32));
> +}
> +
>   struct xattr_iter {
>   	struct super_block *sb;
>   	struct erofs_buf buf;
> @@ -157,7 +170,8 @@ static int inline_xattr_iter_begin(struct xattr_iter *it,
>   	struct erofs_inode *const vi = EROFS_I(inode);
>   	unsigned int xattr_header_sz, inline_xattr_ofs;
>   
> -	xattr_header_sz = inlinexattr_header_size(inode);
> +	xattr_header_sz = sizeof(struct erofs_xattr_ibody_header) +
> +			  sizeof(u32) * vi->xattr_shared_count;
>   	if (xattr_header_sz >= vi->xattr_isize) {
>   		DBG_BUGON(xattr_header_sz > vi->xattr_isize);
>   		return -ENOATTR;
> @@ -351,20 +365,18 @@ static int inline_getxattr(struct inode *inode, struct getxattr_iter *it)
>   static int shared_getxattr(struct inode *inode, struct getxattr_iter *it)
>   {
>   	struct erofs_inode *const vi = EROFS_I(inode);
> -	struct super_block *const sb = inode->i_sb;
> -	unsigned int i;
> +	struct super_block *const sb = it->it.sb;
> +	unsigned int i, xsid;
>   	int ret = -ENOATTR;
>   
>   	for (i = 0; i < vi->xattr_shared_count; ++i) {
> -		erofs_blk_t blkaddr =
> -			xattrblock_addr(sb, vi->xattr_shared_xattrs[i]);
> -
> -		it->it.ofs = xattrblock_offset(sb, vi->xattr_shared_xattrs[i]);
> -		it->it.kaddr = erofs_read_metabuf(&it->it.buf, sb, blkaddr,
> -						  EROFS_KMAP);
> +		xsid = vi->xattr_shared_xattrs[i];
> +		it->it.blkaddr = erofs_xattr_blkaddr(sb, xsid);
> +		it->it.ofs = erofs_xattr_blkoff(sb, xsid);
> +		it->it.kaddr = erofs_read_metabuf(&it->it.buf, sb,
> +						  it->it.blkaddr, EROFS_KMAP);
>   		if (IS_ERR(it->it.kaddr))
>   			return PTR_ERR(it->it.kaddr);
> -		it->it.blkaddr = blkaddr;
>   
>   		ret = xattr_foreach(&it->it, &find_xattr_handlers, NULL);
>   		if (ret != -ENOATTR)
> @@ -383,9 +395,8 @@ static bool erofs_xattr_trusted_list(struct dentry *dentry)
>   	return capable(CAP_SYS_ADMIN);
>   }
>   
> -int erofs_getxattr(struct inode *inode, int index,
> -		   const char *name,
> -		   void *buffer, size_t buffer_size)
> +static int erofs_getxattr(struct inode *inode, int index, const char *name,
> +			  void *buffer, size_t buffer_size)
>   {
>   	int ret;
>   	struct getxattr_iter it;
> @@ -473,6 +484,26 @@ const struct xattr_handler *erofs_xattr_handlers[] = {
>   	NULL,
>   };
>   
> +static inline const struct xattr_handler *erofs_xattr_handler(unsigned int idx)
> +{
> +	static const struct xattr_handler *xattr_handler_map[] = {
> +		[EROFS_XATTR_INDEX_USER] = &erofs_xattr_user_handler,
> +#ifdef CONFIG_EROFS_FS_POSIX_ACL
> +		[EROFS_XATTR_INDEX_POSIX_ACL_ACCESS] =
> +			&posix_acl_access_xattr_handler,
> +		[EROFS_XATTR_INDEX_POSIX_ACL_DEFAULT] =
> +			&posix_acl_default_xattr_handler,
> +#endif
> +		[EROFS_XATTR_INDEX_TRUSTED] = &erofs_xattr_trusted_handler,
> +#ifdef CONFIG_EROFS_FS_SECURITY
> +		[EROFS_XATTR_INDEX_SECURITY] = &erofs_xattr_security_handler,
> +#endif
> +	};
> +
> +	return idx && idx < ARRAY_SIZE(xattr_handler_map) ?
> +		xattr_handler_map[idx] : NULL;
> +}
> +
>   struct listxattr_iter {
>   	struct xattr_iter it;
>   
> @@ -562,20 +593,18 @@ static int shared_listxattr(struct listxattr_iter *it)
>   {
>   	struct inode *const inode = d_inode(it->dentry);
>   	struct erofs_inode *const vi = EROFS_I(inode);
> -	struct super_block *const sb = inode->i_sb;
> -	unsigned int i;
> +	struct super_block *const sb = it->it.sb;
> +	unsigned int i, xsid;
>   	int ret = 0;
>   
>   	for (i = 0; i < vi->xattr_shared_count; ++i) {
> -		erofs_blk_t blkaddr =
> -			xattrblock_addr(sb, vi->xattr_shared_xattrs[i]);
> -
> -		it->it.ofs = xattrblock_offset(sb, vi->xattr_shared_xattrs[i]);
> -		it->it.kaddr = erofs_read_metabuf(&it->it.buf, sb, blkaddr,
> -						  EROFS_KMAP);
> +		xsid = vi->xattr_shared_xattrs[i];
> +		it->it.blkaddr = erofs_xattr_blkaddr(sb, xsid);
> +		it->it.ofs = erofs_xattr_blkoff(sb, xsid);
> +		it->it.kaddr = erofs_read_metabuf(&it->it.buf, sb,
> +						  it->it.blkaddr, EROFS_KMAP);
>   		if (IS_ERR(it->it.kaddr))
>   			return PTR_ERR(it->it.kaddr);
> -		it->it.blkaddr = blkaddr;
>   
>   		ret = xattr_foreach(&it->it, &list_xattr_handlers, NULL);
>   		if (ret)
> diff --git a/fs/erofs/xattr.h b/fs/erofs/xattr.h
> index f7a21aaa9755..cc9ef97dbf8e 100644
> --- a/fs/erofs/xattr.h
> +++ b/fs/erofs/xattr.h
> @@ -13,66 +13,10 @@
>   /* Attribute not found */
>   #define ENOATTR         ENODATA
>   
> -static inline unsigned int inlinexattr_header_size(struct inode *inode)
> -{
> -	return sizeof(struct erofs_xattr_ibody_header) +
> -		sizeof(u32) * EROFS_I(inode)->xattr_shared_count;
> -}
> -
> -static inline erofs_blk_t xattrblock_addr(struct super_block *sb,
> -					  unsigned int xattr_id)
> -{
>   #ifdef CONFIG_EROFS_FS_XATTR
> -	return EROFS_SB(sb)->xattr_blkaddr +
> -		xattr_id * sizeof(__u32) / sb->s_blocksize;
> -#else
> -	return 0;
> -#endif
> -}
> -
> -static inline unsigned int xattrblock_offset(struct super_block *sb,
> -					     unsigned int xattr_id)
> -{
> -	return (xattr_id * sizeof(__u32)) % sb->s_blocksize;
> -}
> -
> -#ifdef CONFIG_EROFS_FS_XATTR
> -extern const struct xattr_handler erofs_xattr_user_handler;
> -extern const struct xattr_handler erofs_xattr_trusted_handler;
> -extern const struct xattr_handler erofs_xattr_security_handler;
> -
> -static inline const struct xattr_handler *erofs_xattr_handler(unsigned int idx)
> -{
> -	static const struct xattr_handler *xattr_handler_map[] = {
> -		[EROFS_XATTR_INDEX_USER] = &erofs_xattr_user_handler,
> -#ifdef CONFIG_EROFS_FS_POSIX_ACL
> -		[EROFS_XATTR_INDEX_POSIX_ACL_ACCESS] =
> -			&posix_acl_access_xattr_handler,
> -		[EROFS_XATTR_INDEX_POSIX_ACL_DEFAULT] =
> -			&posix_acl_default_xattr_handler,
> -#endif
> -		[EROFS_XATTR_INDEX_TRUSTED] = &erofs_xattr_trusted_handler,
> -#ifdef CONFIG_EROFS_FS_SECURITY
> -		[EROFS_XATTR_INDEX_SECURITY] = &erofs_xattr_security_handler,
> -#endif
> -	};
> -
> -	return idx && idx < ARRAY_SIZE(xattr_handler_map) ?
> -		xattr_handler_map[idx] : NULL;
> -}

Could we drop this? since Christian Brauner also touchs this stuff for
the next cycle, see:
https://lore.kernel.org/r/20230125-fs-acl-remove-generic-xattr-handlers-v3-7-f760cc58967d@kernel.org/

I'd like to wait it for the following cycle after the next cycle to
avoid such cross-tree conflicts since it's just a cleanup.

> -
>   extern const struct xattr_handler *erofs_xattr_handlers[];
> -
> -int erofs_getxattr(struct inode *, int, const char *, void *, size_t);

Could we leave it for now?  I'm not sure laterly if erofs will
read xattrs itself.

Otherwise it looks good to me.

Thanks,
Gao Xiang

>   ssize_t erofs_listxattr(struct dentry *, char *, size_t);
>   #else
> -static inline int erofs_getxattr(struct inode *inode, int index,
> -				 const char *name, void *buffer,
> -				 size_t buffer_size)
> -{
> -	return -EOPNOTSUPP;
> -}
> -
>   #define erofs_listxattr (NULL)
>   #define erofs_xattr_handlers (NULL)
>   #endif	/* !CONFIG_EROFS_FS_XATTR */
