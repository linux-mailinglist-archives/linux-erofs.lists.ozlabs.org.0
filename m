Return-Path: <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>
X-Original-To: lists+linux-erofs@lfdr.de
Delivered-To: lists+linux-erofs@lfdr.de
Received: from lists.ozlabs.org (lists.ozlabs.org [203.11.71.2])
	by mail.lfdr.de (Postfix) with ESMTPS id 80FB612E60E
	for <lists+linux-erofs@lfdr.de>; Thu,  2 Jan 2020 13:26:26 +0100 (CET)
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2401:3900:2:1::3])
	by lists.ozlabs.org (Postfix) with ESMTP id 47pS2740SFzDqBL
	for <lists+linux-erofs@lfdr.de>; Thu,  2 Jan 2020 23:26:23 +1100 (AEDT)
X-Original-To: linux-erofs@lists.ozlabs.org
Delivered-To: linux-erofs@lists.ozlabs.org
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized)
 smtp.mailfrom=huawei.com (client-ip=45.249.212.255; helo=huawei.com;
 envelope-from=gaoxiang25@huawei.com; receiver=<UNKNOWN>)
Authentication-Results: lists.ozlabs.org;
 dmarc=none (p=none dis=none) header.from=huawei.com
Received: from huawei.com (szxga08-in.huawei.com [45.249.212.255])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 47pS1x4vxLzDq9y
 for <linux-erofs@lists.ozlabs.org>; Thu,  2 Jan 2020 23:26:08 +1100 (AEDT)
Received: from DGGEMM401-HUB.china.huawei.com (unknown [172.30.72.53])
 by Forcepoint Email with ESMTP id 60F1E8F4D27687D7720E;
 Thu,  2 Jan 2020 20:25:57 +0800 (CST)
Received: from dggeme762-chm.china.huawei.com (10.3.19.108) by
 DGGEMM401-HUB.china.huawei.com (10.3.20.209) with Microsoft SMTP Server (TLS)
 id 14.3.439.0; Thu, 2 Jan 2020 20:25:56 +0800
Received: from architecture4 (10.160.196.180) by
 dggeme762-chm.china.huawei.com (10.3.19.108) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id
 15.1.1713.5; Thu, 2 Jan 2020 20:25:56 +0800
Date: Thu, 2 Jan 2020 20:25:30 +0800
From: Gao Xiang <gaoxiang25@huawei.com>
To: Vladimir Zapolskiy <vladimir@tuxera.com>
Subject: Re: [PATCH] erofs: correct indentation of an assigned structure
 inside a function
Message-ID: <20200102122530.GA39947@architecture4>
References: <20200102120232.15074-1-vladimir@tuxera.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20200102120232.15074-1-vladimir@tuxera.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
X-Originating-IP: [10.160.196.180]
X-ClientProxiedBy: dggeme720-chm.china.huawei.com (10.1.199.116) To
 dggeme762-chm.china.huawei.com (10.3.19.108)
X-CFilter-Loop: Reflected
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
Cc: linux-erofs@lists.ozlabs.org, linux-fsdevel@vger.kernel.org,
 Gao Xiang <xiang@kernel.org>, Miao Xie <miaoxie@huawei.com>, Anton
 Altaparmakov <anton@tuxera.com>
Errors-To: linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org
Sender: "Linux-erofs"
 <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>

On Thu, Jan 02, 2020 at 02:02:32PM +0200, Vladimir Zapolskiy wrote:
> Trivial change, the expected indentation ruled by the coding style
> hasn't been met.
> 
> Signed-off-by: Vladimir Zapolskiy <vladimir@tuxera.com>
> ---
>  fs/erofs/xattr.h | 17 +++++++++--------
>  1 file changed, 9 insertions(+), 8 deletions(-)
> 
> diff --git a/fs/erofs/xattr.h b/fs/erofs/xattr.h
> index 3585b84d2f20..50966f1c676e 100644
> --- a/fs/erofs/xattr.h
> +++ b/fs/erofs/xattr.h
> @@ -46,18 +46,19 @@ extern const struct xattr_handler erofs_xattr_security_handler;
>  
>  static inline const struct xattr_handler *erofs_xattr_handler(unsigned int idx)
>  {
> -static const struct xattr_handler *xattr_handler_map[] = {
> -	[EROFS_XATTR_INDEX_USER] = &erofs_xattr_user_handler,
> +	static const struct xattr_handler *xattr_handler_map[] = {
> +		[EROFS_XATTR_INDEX_USER] = &erofs_xattr_user_handler,
>  #ifdef CONFIG_EROFS_FS_POSIX_ACL
> -	[EROFS_XATTR_INDEX_POSIX_ACL_ACCESS] = &posix_acl_access_xattr_handler,
> -	[EROFS_XATTR_INDEX_POSIX_ACL_DEFAULT] =
> -		&posix_acl_default_xattr_handler,
> +		[EROFS_XATTR_INDEX_POSIX_ACL_ACCESS] =
> +			&posix_acl_access_xattr_handler,
> +		[EROFS_XATTR_INDEX_POSIX_ACL_DEFAULT] =
> +			&posix_acl_default_xattr_handler,
>  #endif
> -	[EROFS_XATTR_INDEX_TRUSTED] = &erofs_xattr_trusted_handler,
> +		[EROFS_XATTR_INDEX_TRUSTED] = &erofs_xattr_trusted_handler,
>  #ifdef CONFIG_EROFS_FS_SECURITY
> -	[EROFS_XATTR_INDEX_SECURITY] = &erofs_xattr_security_handler,
> +		[EROFS_XATTR_INDEX_SECURITY] = &erofs_xattr_security_handler,
>  #endif
> -};
> +	};
>  
>  	return idx && idx < ARRAY_SIZE(xattr_handler_map) ?
>  		xattr_handler_map[idx] : NULL;
> -- 
> 2.20.1
>

Thanks, will apply for linux-next.

Thanks,
Gao Xiang

