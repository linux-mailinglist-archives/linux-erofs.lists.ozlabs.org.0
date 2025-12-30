Return-Path: <linux-erofs+bounces-1651-lists+linux-erofs=lfdr.de@lists.ozlabs.org>
X-Original-To: lists+linux-erofs@lfdr.de
Delivered-To: lists+linux-erofs@lfdr.de
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	by mail.lfdr.de (Postfix) with ESMTPS id A5B9BCE89A1
	for <lists+linux-erofs@lfdr.de>; Tue, 30 Dec 2025 03:56:12 +0100 (CET)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4dgHlt09Lkz2yDk;
	Tue, 30 Dec 2025 13:56:10 +1100 (AEDT)
X-Original-To: linux-erofs@lists.ozlabs.org
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip=113.46.200.221
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1767063369;
	cv=none; b=Boz/7oh4LwkrlNErppD7b98yYP4ZuF7a8kKZwjqg5KEA+sjnHdZG4Zy31xQ2RsbXpXtd96X2fXrKhKTg87z0nMIZIVg/tuGNGK4N62ru2KkZL8iLtplnVE+tFC1Qc3WccJMI5Wi5yDVGB4ASAhGrI9q1tSb/CxWA3sprZHryLJ1725nSBGXJO90jrytFjh/1wD5nO8CzPTY7shIHsIWGWTYquNXrFCbqj1QfJduB23jgb+/Z/6bS6suFa/z8Z727bc8WYa8kDuxBq87tEUYDdRfQ/kbD4PD5vNIaitx0RaezYFgVei0yxGrXZFABj2L9GO9lG/CCu1KTgFJW+7MX3Q==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1767063369; c=relaxed/relaxed;
	bh=074gn06uNtdmByYR2SmRHJXJeIRXTvyZchhu+C8etF0=;
	h=Message-ID:Date:MIME-Version:Subject:To:References:From:
	 In-Reply-To:Content-Type; b=n9bSPCVFPk0FR68Vp0IodgtwKD0z+8JDQMZ4jBaaq10J0mWyMcD+qVYN6YIIWqV+rvnqN3q69BmjWKczGzdtAkgahg77oe5whlFkNYV9zdWFhz1eQzYagF6o+PJ2Q6OdPcnZYIaBy32AgnBCgwc7PFJy+yIvZm5NTrJsCL5PKDVoX3yi3AHdq2fS3JdDdeh8ZaMa0UtMBCrD+J8ymfOJ+IYUWGzZ8piAIm18N6YaUXVobLidD33++ZEu5iqrcJLOAryOwJlLhh66U2yqtSfvAjzMjcjoVVl0d+IiN6uYaYyH+DH/9eaAqAbF/7rFg2ayUfiXz2OIrk0W7n2TRGmOpw==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; dkim=pass (1024-bit key; unprotected) header.d=huawei.com header.i=@huawei.com header.a=rsa-sha256 header.s=dkim header.b=jpqF/5mk; dkim-atps=neutral; spf=pass (client-ip=113.46.200.221; helo=canpmsgout06.his.huawei.com; envelope-from=lihongbo22@huawei.com; receiver=lists.ozlabs.org) smtp.mailfrom=huawei.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (1024-bit key; unprotected) header.d=huawei.com header.i=@huawei.com header.a=rsa-sha256 header.s=dkim header.b=jpqF/5mk;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=huawei.com (client-ip=113.46.200.221; helo=canpmsgout06.his.huawei.com; envelope-from=lihongbo22@huawei.com; receiver=lists.ozlabs.org)
Received: from canpmsgout06.his.huawei.com (canpmsgout06.his.huawei.com [113.46.200.221])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4dgHlr4vXcz2yD4
	for <linux-erofs@lists.ozlabs.org>; Tue, 30 Dec 2025 13:56:07 +1100 (AEDT)
dkim-signature: v=1; a=rsa-sha256; d=huawei.com; s=dkim;
	c=relaxed/relaxed; q=dns/txt;
	h=From;
	bh=074gn06uNtdmByYR2SmRHJXJeIRXTvyZchhu+C8etF0=;
	b=jpqF/5mkLcOanSJpxtzE6Y3G7Ojlu04oW94JhMsotclYNWcGJOAjdC7UcVTsCzLVx9f5F6cEg
	+N/Hl/OuDnTBH/LrJpgc8/XwpzwnjoS//I48I+caIE2KecLKIzykBnlojsP5ZgtMiBC09Mscxwa
	18ZIIuy5UVAVdoBHG1YwRc4=
Received: from mail.maildlp.com (unknown [172.19.162.144])
	by canpmsgout06.his.huawei.com (SkyGuard) with ESMTPS id 4dgHh26hK9zRhvJ
	for <linux-erofs@lists.ozlabs.org>; Tue, 30 Dec 2025 10:52:50 +0800 (CST)
Received: from kwepemr500015.china.huawei.com (unknown [7.202.195.162])
	by mail.maildlp.com (Postfix) with ESMTPS id A18F640605
	for <linux-erofs@lists.ozlabs.org>; Tue, 30 Dec 2025 10:56:01 +0800 (CST)
Received: from [10.67.111.104] (10.67.111.104) by
 kwepemr500015.china.huawei.com (7.202.195.162) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.11; Tue, 30 Dec 2025 10:56:01 +0800
Message-ID: <2c6148b0-568c-4cc0-9b4d-d753c0fe92cf@huawei.com>
Date: Tue, 30 Dec 2025 10:56:00 +0800
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
Subject: Re: [PATCH 4/4] erofs: unexport erofs_xattr_prefix()
Content-Language: en-US
To: <linux-erofs@lists.ozlabs.org>
References: <20251229092949.2316075-1-hsiangkao@linux.alibaba.com>
 <20251229092949.2316075-4-hsiangkao@linux.alibaba.com>
From: Hongbo Li <lihongbo22@huawei.com>
In-Reply-To: <20251229092949.2316075-4-hsiangkao@linux.alibaba.com>
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
> It can be simply in xattr.c due to no external users.
> 

Reviewed-by: Hongbo Li <lihongbo22@huawei.com>

Thanks,
Hongbo

> Signed-off-by: Gao Xiang <hsiangkao@linux.alibaba.com>
> ---
>   fs/erofs/xattr.c | 27 +++++++++++++++++++++++++++
>   fs/erofs/xattr.h | 30 ------------------------------
>   2 files changed, 27 insertions(+), 30 deletions(-)
> 
> diff --git a/fs/erofs/xattr.c b/fs/erofs/xattr.c
> index 972941ecb71c..d25c1cc1940c 100644
> --- a/fs/erofs/xattr.c
> +++ b/fs/erofs/xattr.c
> @@ -25,6 +25,8 @@ struct erofs_xattr_iter {
>   	struct dentry *dentry;
>   };
>   
> +static const char *erofs_xattr_prefix(unsigned int idx, struct dentry *dentry);
> +
>   static int erofs_init_inode_xattrs(struct inode *inode)
>   {
>   	struct erofs_inode *const vi = EROFS_I(inode);
> @@ -462,6 +464,31 @@ const struct xattr_handler * const erofs_xattr_handlers[] = {
>   	NULL,
>   };
>   
> +static const char *erofs_xattr_prefix(unsigned int idx, struct dentry *dentry)
> +{
> +	const struct xattr_handler *handler = NULL;
> +
> +	static const struct xattr_handler * const xattr_handler_map[] = {
> +		[EROFS_XATTR_INDEX_USER] = &erofs_xattr_user_handler,
> +#ifdef CONFIG_EROFS_FS_POSIX_ACL
> +		[EROFS_XATTR_INDEX_POSIX_ACL_ACCESS] = &nop_posix_acl_access,
> +		[EROFS_XATTR_INDEX_POSIX_ACL_DEFAULT] = &nop_posix_acl_default,
> +#endif
> +		[EROFS_XATTR_INDEX_TRUSTED] = &erofs_xattr_trusted_handler,
> +#ifdef CONFIG_EROFS_FS_SECURITY
> +		[EROFS_XATTR_INDEX_SECURITY] = &erofs_xattr_security_handler,
> +#endif
> +	};
> +
> +	if (idx && idx < ARRAY_SIZE(xattr_handler_map))
> +		handler = xattr_handler_map[idx];
> +
> +	if (!xattr_handler_can_list(handler, dentry))
> +		return NULL;
> +
> +	return xattr_prefix(handler);
> +}
> +
>   void erofs_xattr_prefixes_cleanup(struct super_block *sb)
>   {
>   	struct erofs_sb_info *sbi = EROFS_SB(sb);
> diff --git a/fs/erofs/xattr.h b/fs/erofs/xattr.h
> index ee1d8c310d97..36f2667afc2d 100644
> --- a/fs/erofs/xattr.h
> +++ b/fs/erofs/xattr.h
> @@ -11,36 +11,6 @@
>   #include <linux/xattr.h>
>   
>   #ifdef CONFIG_EROFS_FS_XATTR
> -extern const struct xattr_handler erofs_xattr_user_handler;
> -extern const struct xattr_handler erofs_xattr_trusted_handler;
> -extern const struct xattr_handler erofs_xattr_security_handler;
> -
> -static inline const char *erofs_xattr_prefix(unsigned int idx,
> -					     struct dentry *dentry)
> -{
> -	const struct xattr_handler *handler = NULL;
> -
> -	static const struct xattr_handler * const xattr_handler_map[] = {
> -		[EROFS_XATTR_INDEX_USER] = &erofs_xattr_user_handler,
> -#ifdef CONFIG_EROFS_FS_POSIX_ACL
> -		[EROFS_XATTR_INDEX_POSIX_ACL_ACCESS] = &nop_posix_acl_access,
> -		[EROFS_XATTR_INDEX_POSIX_ACL_DEFAULT] = &nop_posix_acl_default,
> -#endif
> -		[EROFS_XATTR_INDEX_TRUSTED] = &erofs_xattr_trusted_handler,
> -#ifdef CONFIG_EROFS_FS_SECURITY
> -		[EROFS_XATTR_INDEX_SECURITY] = &erofs_xattr_security_handler,
> -#endif
> -	};
> -
> -	if (idx && idx < ARRAY_SIZE(xattr_handler_map))
> -		handler = xattr_handler_map[idx];
> -
> -	if (!xattr_handler_can_list(handler, dentry))
> -		return NULL;
> -
> -	return xattr_prefix(handler);
> -}
> -
>   extern const struct xattr_handler * const erofs_xattr_handlers[];
>   
>   int erofs_xattr_prefixes_init(struct super_block *sb);

