Return-Path: <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>
X-Original-To: lists+linux-erofs@lfdr.de
Delivered-To: lists+linux-erofs@lfdr.de
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2401:3900:2:1::3])
	by mail.lfdr.de (Postfix) with ESMTPS id BA3A04E00A
	for <lists+linux-erofs@lfdr.de>; Fri, 21 Jun 2019 07:24:33 +0200 (CEST)
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2401:3900:2:1::3])
	by lists.ozlabs.org (Postfix) with ESMTP id 45VRvM1sRnzDqdD
	for <lists+linux-erofs@lfdr.de>; Fri, 21 Jun 2019 15:24:31 +1000 (AEST)
X-Original-To: linux-erofs@lists.ozlabs.org
Delivered-To: linux-erofs@lists.ozlabs.org
Authentication-Results: lists.ozlabs.org;
 spf=pass (mailfrom) smtp.mailfrom=huawei.com
 (client-ip=45.249.212.190; helo=huawei.com;
 envelope-from=gaoxiang25@huawei.com; receiver=<UNKNOWN>)
Authentication-Results: lists.ozlabs.org;
 dmarc=none (p=none dis=none) header.from=huawei.com
Received: from huawei.com (szxga04-in.huawei.com [45.249.212.190])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 45VRYT0BF9zDqBh
 for <linux-erofs@lists.ozlabs.org>; Fri, 21 Jun 2019 15:09:00 +1000 (AEST)
Received: from DGGEMS406-HUB.china.huawei.com (unknown [172.30.72.59])
 by Forcepoint Email with ESMTP id C00F3B77834E19A36577;
 Fri, 21 Jun 2019 13:08:54 +0800 (CST)
Received: from [10.151.23.176] (10.151.23.176) by smtp.huawei.com
 (10.3.19.206) with Microsoft SMTP Server (TLS) id 14.3.439.0; Fri, 21 Jun
 2019 13:08:46 +0800
Subject: Re: [PATCH] staging: erofs: remove needless dummy functions of
 erofs_{get,list}xattr
To: Yue Hu <zbestahu@gmail.com>, <yuchao0@huawei.com>,
 <gregkh@linuxfoundation.org>
References: <20190621040808.3708-1-zbestahu@gmail.com>
From: Gao Xiang <gaoxiang25@huawei.com>
Message-ID: <f6b2ced7-79ea-9cc6-5e88-43552b5947a9@huawei.com>
Date: Fri, 21 Jun 2019 13:08:39 +0800
User-Agent: Mozilla/5.0 (Windows NT 6.1; WOW64; rv:52.0) Gecko/20100101
 Thunderbird/52.3.0
MIME-Version: 1.0
In-Reply-To: <20190621040808.3708-1-zbestahu@gmail.com>
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.151.23.176]
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
Cc: huyue2@yulong.com, linux-erofs@lists.ozlabs.org
Errors-To: linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org
Sender: "Linux-erofs"
 <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>

Hi Yue,

On 2019/6/21 12:08, Yue Hu wrote:
> From: Yue Hu <huyue2@yulong.com>
> 
> The two dummy functions of erofs_getxattr()/erofs_listxattr() will never
> be used if disable CONFIG_EROFS_FS_XATTR.
> 
> Signed-off-by: Yue Hu <huyue2@yulong.com>
> ---
>  drivers/staging/erofs/xattr.h | 13 -------------
>  1 file changed, 13 deletions(-)
> 
> diff --git a/drivers/staging/erofs/xattr.h b/drivers/staging/erofs/xattr.h
> index 35ba5ac..2c1e46f 100644
> --- a/drivers/staging/erofs/xattr.h
> +++ b/drivers/staging/erofs/xattr.h
> @@ -72,19 +72,6 @@ static inline const struct xattr_handler *erofs_xattr_handler(unsigned index)
>  
>  int erofs_getxattr(struct inode *, int, const char *, void *, size_t);
>  ssize_t erofs_listxattr(struct dentry *, char *, size_t);
> -#else
> -static int __maybe_unused erofs_getxattr(struct inode *inode, int index,
> -	const char *name,
> -	void *buffer, size_t buffer_size)
> -{
> -	return -ENOTSUPP;
> -}
> -
> -static ssize_t __maybe_unused erofs_listxattr(struct dentry *dentry,
> -	char *buffer, size_t buffer_size)
> -{
> -	return -ENOTSUPP;
> -}
>  #endif

It's mainly used for erofs to directly call erofs_getxattr / erofs_listxattr (even 
xattr feature is off) to get a xattr in erofs itself, just follow what other
filesystems (e.g. f2fs) did, although these apis have not been used internally
yet but used as callbacks in inode_operations only.

I have no positive or negative tendency since the patch is minor and the only
benefit of this patch is that it removes some code which seems redundant currently.
However, if erofs_getxattr is needed later, it should be added back of course.
Therefore I think it could depend on Greg whether accept this patch or not.

Thanks,
Gao Xiang

>  
>  #ifdef CONFIG_EROFS_FS_POSIX_ACL
> 
