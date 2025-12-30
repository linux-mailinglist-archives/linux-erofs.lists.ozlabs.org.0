Return-Path: <linux-erofs+bounces-1650-lists+linux-erofs=lfdr.de@lists.ozlabs.org>
X-Original-To: lists+linux-erofs@lfdr.de
Delivered-To: lists+linux-erofs@lfdr.de
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	by mail.lfdr.de (Postfix) with ESMTPS id 8509DCE8977
	for <lists+linux-erofs@lfdr.de>; Tue, 30 Dec 2025 03:46:58 +0100 (CET)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4dgHYC6rvgz2yDk;
	Tue, 30 Dec 2025 13:46:55 +1100 (AEDT)
X-Original-To: linux-erofs@lists.ozlabs.org
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip=113.46.200.218
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1767062815;
	cv=none; b=m5T551yna8uGGYb/UXEzGfi84HIpaFL50EeCS785w1JOrz/K/6fVkzHkGnrTzgsVlN0a+/g/2zPfx0KnX7wZzahbPE2+RLDV6Ptwx9IBtmWzutKVovIs6Ez2H1j8dIleVPKsnSJQirtqKqEOJBGljrMKEz2HlBQDNh0/PjB3EAR2ZSRNg54uoffnHFOBjDiPE6oGcoZu+p5mhGxvo0p8Jikv9wbOoybt6ttvB1jS3zNJ1W5tAkEKEL4WVHvy1c8UVSshFjtE35AfXXp68IotUAXx2FxVh1DNaqV/VrG0L5VkOXysKbZCqujifmJuW6CNBtCFzyMJUusOZwGt16oAMg==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1767062815; c=relaxed/relaxed;
	bh=QnyklycO/B/8QU0ypBXf9S76mTpZkjpjnxNcfGHCo14=;
	h=Message-ID:Date:MIME-Version:Subject:To:References:From:
	 In-Reply-To:Content-Type; b=J/HnZjx6CYz4hfYGYaX+/FK2HCgzpd86q8fGdsfqbkLWiTPXFt7Yv2VvJp2GKjb4kd4UjjZIpIFkYSPaecnivKVH68VFeCVSlh4kneSFQoQDB3005POwQRZX9uBpUEoUWOO53IYmFKp2umPmyrdwu1b4SXXRtKJoK4IRlKITuzO8g8SCr4Zw9c0cJbgRvZVIWd39pQNYiNjsUua0WhOV6FHnF+AgKAiOoJBWDd0DemP5YF+ctupqNJZGByIC3Qze/VqXyqprIO9+tfFXqSWMdcLIjBfPBxhTYs1jofPrBG2f33oONqJZAP0l3+h8OHgELMcgk1Ix0HtFbL+aQPAJYQ==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; dkim=pass (1024-bit key; unprotected) header.d=huawei.com header.i=@huawei.com header.a=rsa-sha256 header.s=dkim header.b=iCaJL2yj; dkim-atps=neutral; spf=pass (client-ip=113.46.200.218; helo=canpmsgout03.his.huawei.com; envelope-from=lihongbo22@huawei.com; receiver=lists.ozlabs.org) smtp.mailfrom=huawei.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (1024-bit key; unprotected) header.d=huawei.com header.i=@huawei.com header.a=rsa-sha256 header.s=dkim header.b=iCaJL2yj;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=huawei.com (client-ip=113.46.200.218; helo=canpmsgout03.his.huawei.com; envelope-from=lihongbo22@huawei.com; receiver=lists.ozlabs.org)
Received: from canpmsgout03.his.huawei.com (canpmsgout03.his.huawei.com [113.46.200.218])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4dgHY86LpRz2yD4
	for <linux-erofs@lists.ozlabs.org>; Tue, 30 Dec 2025 13:46:52 +1100 (AEDT)
dkim-signature: v=1; a=rsa-sha256; d=huawei.com; s=dkim;
	c=relaxed/relaxed; q=dns/txt;
	h=From;
	bh=QnyklycO/B/8QU0ypBXf9S76mTpZkjpjnxNcfGHCo14=;
	b=iCaJL2yj+vXaBRS9WdO09qvDxglAbaLF7Yaxc82viv/eHmAotH5wf+ZEB6r9y6FsqpBX+tQln
	JGsCi5j4O4w1bl/adspY7EQcVVF+il/YsuR6YthtSgT5O77amfCydR9myLQLrc9IYw2bjsngVhV
	GxPg5SJys1+956KJC26MoVw=
Received: from mail.maildlp.com (unknown [172.19.162.140])
	by canpmsgout03.his.huawei.com (SkyGuard) with ESMTPS id 4dgHTR4BQczpSvm
	for <linux-erofs@lists.ozlabs.org>; Tue, 30 Dec 2025 10:43:39 +0800 (CST)
Received: from kwepemr500015.china.huawei.com (unknown [7.202.195.162])
	by mail.maildlp.com (Postfix) with ESMTPS id 33B9F2016A
	for <linux-erofs@lists.ozlabs.org>; Tue, 30 Dec 2025 10:46:46 +0800 (CST)
Received: from [10.67.111.104] (10.67.111.104) by
 kwepemr500015.china.huawei.com (7.202.195.162) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.11; Tue, 30 Dec 2025 10:46:45 +0800
Message-ID: <3224fc3b-9fa0-4de5-8734-d34034116237@huawei.com>
Date: Tue, 30 Dec 2025 10:46:45 +0800
X-Mailing-List: linux-erofs@lists.ozlabs.org
List-Id: <linux-erofs.lists.ozlabs.org>
List-Help: <mailto:linux-erofs+help@lists.ozlabs.org>
List-Owner: <mailto:linux-erofs+owner@lists.ozlabs.org>
List-Post: <mailto:linux-erofs@lists.ozlabs.org>
List-Subscribe: <mailto:linux-erofs+subscribe@lists.ozlabs.org>,
  <mailto:linux-erofs+subscribe-digest@lists.ozlabs.org>,
  <mailto:linux-erofs+subscribe-nomail@lists.ozlabs.org>
List-Unsubscribe: <mailto:linux-erofs+unsubscribe@lists.ozlabs.org>
Precedence: list
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 3/4] erofs: unexport erofs_getxattr()
To: <linux-erofs@lists.ozlabs.org>
References: <20251229092949.2316075-1-hsiangkao@linux.alibaba.com>
 <20251229092949.2316075-3-hsiangkao@linux.alibaba.com>
Content-Language: en-US
From: Hongbo Li <lihongbo22@huawei.com>
In-Reply-To: <20251229092949.2316075-3-hsiangkao@linux.alibaba.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.67.111.104]
X-ClientProxiedBy: kwepems200001.china.huawei.com (7.221.188.67) To
 kwepemr500015.china.huawei.com (7.202.195.162)
X-Spam-Status: No, score=-0.2 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS autolearn=disabled
	version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-25) on lists.ozlabs.org



On 2025/12/29 17:29, Gao Xiang wrote:
> No external users other than those in xattr.c.
> 
> Signed-off-by: Gao Xiang <hsiangkao@linux.alibaba.com>

Reviewed-by: Hongbo Li <lihongbo22@huawei.com>

Thanks,
Hongbo

> ---
>   fs/erofs/xattr.c | 108 +++++++++++++++++++++++------------------------
>   fs/erofs/xattr.h |   7 ---
>   2 files changed, 54 insertions(+), 61 deletions(-)
> 
> diff --git a/fs/erofs/xattr.c b/fs/erofs/xattr.c
> index 396536d9a862..972941ecb71c 100644
> --- a/fs/erofs/xattr.c
> +++ b/fs/erofs/xattr.c
> @@ -125,58 +125,6 @@ static int erofs_init_inode_xattrs(struct inode *inode)
>   	return ret;
>   }
>   
> -static bool erofs_xattr_user_list(struct dentry *dentry)
> -{
> -	return test_opt(&EROFS_SB(dentry->d_sb)->opt, XATTR_USER);
> -}
> -
> -static bool erofs_xattr_trusted_list(struct dentry *dentry)
> -{
> -	return capable(CAP_SYS_ADMIN);
> -}
> -
> -static int erofs_xattr_generic_get(const struct xattr_handler *handler,
> -				   struct dentry *unused, struct inode *inode,
> -				   const char *name, void *buffer, size_t size)
> -{
> -	if (handler->flags == EROFS_XATTR_INDEX_USER &&
> -	    !test_opt(&EROFS_I_SB(inode)->opt, XATTR_USER))
> -		return -EOPNOTSUPP;
> -
> -	return erofs_getxattr(inode, handler->flags, name, buffer, size);
> -}
> -
> -const struct xattr_handler erofs_xattr_user_handler = {
> -	.prefix	= XATTR_USER_PREFIX,
> -	.flags	= EROFS_XATTR_INDEX_USER,
> -	.list	= erofs_xattr_user_list,
> -	.get	= erofs_xattr_generic_get,
> -};
> -
> -const struct xattr_handler erofs_xattr_trusted_handler = {
> -	.prefix	= XATTR_TRUSTED_PREFIX,
> -	.flags	= EROFS_XATTR_INDEX_TRUSTED,
> -	.list	= erofs_xattr_trusted_list,
> -	.get	= erofs_xattr_generic_get,
> -};
> -
> -#ifdef CONFIG_EROFS_FS_SECURITY
> -const struct xattr_handler __maybe_unused erofs_xattr_security_handler = {
> -	.prefix	= XATTR_SECURITY_PREFIX,
> -	.flags	= EROFS_XATTR_INDEX_SECURITY,
> -	.get	= erofs_xattr_generic_get,
> -};
> -#endif
> -
> -const struct xattr_handler * const erofs_xattr_handlers[] = {
> -	&erofs_xattr_user_handler,
> -	&erofs_xattr_trusted_handler,
> -#ifdef CONFIG_EROFS_FS_SECURITY
> -	&erofs_xattr_security_handler,
> -#endif
> -	NULL,
> -};
> -
>   static int erofs_xattr_copy_to_buffer(struct erofs_xattr_iter *it,
>   				      unsigned int len)
>   {
> @@ -391,8 +339,8 @@ static int erofs_xattr_iter_shared(struct erofs_xattr_iter *it,
>   	return i ? ret : -ENODATA;
>   }
>   
> -int erofs_getxattr(struct inode *inode, int index, const char *name,
> -		   void *buffer, size_t buffer_size)
> +static int erofs_getxattr(struct inode *inode, int index, const char *name,
> +			  void *buffer, size_t buffer_size)
>   {
>   	int ret;
>   	unsigned int hashbit;
> @@ -462,6 +410,58 @@ ssize_t erofs_listxattr(struct dentry *dentry, char *buffer, size_t buffer_size)
>   	return ret ? ret : it.buffer_ofs;
>   }
>   
> +static bool erofs_xattr_user_list(struct dentry *dentry)
> +{
> +	return test_opt(&EROFS_SB(dentry->d_sb)->opt, XATTR_USER);
> +}
> +
> +static bool erofs_xattr_trusted_list(struct dentry *dentry)
> +{
> +	return capable(CAP_SYS_ADMIN);
> +}
> +
> +static int erofs_xattr_generic_get(const struct xattr_handler *handler,
> +				   struct dentry *unused, struct inode *inode,
> +				   const char *name, void *buffer, size_t size)
> +{
> +	if (handler->flags == EROFS_XATTR_INDEX_USER &&
> +	    !test_opt(&EROFS_I_SB(inode)->opt, XATTR_USER))
> +		return -EOPNOTSUPP;
> +
> +	return erofs_getxattr(inode, handler->flags, name, buffer, size);
> +}
> +
> +const struct xattr_handler erofs_xattr_user_handler = {
> +	.prefix	= XATTR_USER_PREFIX,
> +	.flags	= EROFS_XATTR_INDEX_USER,
> +	.list	= erofs_xattr_user_list,
> +	.get	= erofs_xattr_generic_get,
> +};
> +
> +const struct xattr_handler erofs_xattr_trusted_handler = {
> +	.prefix	= XATTR_TRUSTED_PREFIX,
> +	.flags	= EROFS_XATTR_INDEX_TRUSTED,
> +	.list	= erofs_xattr_trusted_list,
> +	.get	= erofs_xattr_generic_get,
> +};
> +
> +#ifdef CONFIG_EROFS_FS_SECURITY
> +const struct xattr_handler __maybe_unused erofs_xattr_security_handler = {
> +	.prefix	= XATTR_SECURITY_PREFIX,
> +	.flags	= EROFS_XATTR_INDEX_SECURITY,
> +	.get	= erofs_xattr_generic_get,
> +};
> +#endif
> +
> +const struct xattr_handler * const erofs_xattr_handlers[] = {
> +	&erofs_xattr_user_handler,
> +	&erofs_xattr_trusted_handler,
> +#ifdef CONFIG_EROFS_FS_SECURITY
> +	&erofs_xattr_security_handler,
> +#endif
> +	NULL,
> +};
> +
>   void erofs_xattr_prefixes_cleanup(struct super_block *sb)
>   {
>   	struct erofs_sb_info *sbi = EROFS_SB(sb);
> diff --git a/fs/erofs/xattr.h b/fs/erofs/xattr.h
> index 6317caa8413e..ee1d8c310d97 100644
> --- a/fs/erofs/xattr.h
> +++ b/fs/erofs/xattr.h
> @@ -45,17 +45,10 @@ extern const struct xattr_handler * const erofs_xattr_handlers[];
>   
>   int erofs_xattr_prefixes_init(struct super_block *sb);
>   void erofs_xattr_prefixes_cleanup(struct super_block *sb);
> -int erofs_getxattr(struct inode *, int, const char *, void *, size_t);
>   ssize_t erofs_listxattr(struct dentry *, char *, size_t);
>   #else
>   static inline int erofs_xattr_prefixes_init(struct super_block *sb) { return 0; }
>   static inline void erofs_xattr_prefixes_cleanup(struct super_block *sb) {}
> -static inline int erofs_getxattr(struct inode *inode, int index,
> -				 const char *name, void *buffer,
> -				 size_t buffer_size)
> -{
> -	return -EOPNOTSUPP;
> -}
>   
>   #define erofs_listxattr (NULL)
>   #define erofs_xattr_handlers (NULL)

