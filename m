Return-Path: <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>
X-Original-To: lists+linux-erofs@lfdr.de
Delivered-To: lists+linux-erofs@lfdr.de
Received: from lists.ozlabs.org (lists.ozlabs.org [203.11.71.2])
	by mail.lfdr.de (Postfix) with ESMTPS id 3DAE456510
	for <lists+linux-erofs@lfdr.de>; Wed, 26 Jun 2019 11:03:54 +0200 (CEST)
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2401:3900:2:1::3])
	by lists.ozlabs.org (Postfix) with ESMTP id 45YcX65wpmzDqXT
	for <lists+linux-erofs@lfdr.de>; Wed, 26 Jun 2019 19:03:50 +1000 (AEST)
X-Original-To: linux-erofs@lists.ozlabs.org
Delivered-To: linux-erofs@lists.ozlabs.org
Authentication-Results: lists.ozlabs.org;
 spf=pass (mailfrom) smtp.mailfrom=huawei.com
 (client-ip=45.249.212.35; helo=huawei.com; envelope-from=gaoxiang25@huawei.com;
 receiver=<UNKNOWN>)
Authentication-Results: lists.ozlabs.org;
 dmarc=none (p=none dis=none) header.from=huawei.com
Received: from huawei.com (szxga07-in.huawei.com [45.249.212.35])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 45YcWx61QgzDqX8
 for <linux-erofs@lists.ozlabs.org>; Wed, 26 Jun 2019 19:03:41 +1000 (AEST)
Received: from DGGEMS412-HUB.china.huawei.com (unknown [172.30.72.60])
 by Forcepoint Email with ESMTP id 51FC098D895276A11E5E;
 Wed, 26 Jun 2019 17:03:36 +0800 (CST)
Received: from [10.151.23.176] (10.151.23.176) by smtp.huawei.com
 (10.3.19.212) with Microsoft SMTP Server (TLS) id 14.3.439.0; Wed, 26 Jun
 2019 17:02:57 +0800
Subject: Re: [PATCH RESEND] staging: erofs: return the error value if
 fill_inline_data() fails
To: Yue Hu <zbestahu@gmail.com>, <yuchao0@huawei.com>,
 <gregkh@linuxfoundation.org>
References: <20190626033038.9456-1-zbestahu@gmail.com>
From: Gao Xiang <gaoxiang25@huawei.com>
Message-ID: <a503962c-0d06-d186-3230-b208410939b0@huawei.com>
Date: Wed, 26 Jun 2019 17:02:48 +0800
User-Agent: Mozilla/5.0 (Windows NT 6.1; WOW64; rv:52.0) Gecko/20100101
 Thunderbird/52.3.0
MIME-Version: 1.0
In-Reply-To: <20190626033038.9456-1-zbestahu@gmail.com>
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
Cc: devel@driverdev.osuosl.org, Miao Xie <miaoxie@huawei.com>,
 huyue2@yulong.com, linux-erofs@lists.ozlabs.org, linux-kernel@vger.kernel.org
Errors-To: linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org
Sender: "Linux-erofs"
 <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>

Hi Yue,

On 2019/6/26 11:30, Yue Hu wrote:
> From: Yue Hu <huyue2@yulong.com>
> 
> We should consider the error returned by fill_inline_data() when filling
> last page in fill_inode(). If not getting inode will be successful even
> though last page is bad. That is illogical. Also change -EAGAIN to 0 in
> fill_inline_data() to stand for successful filling.
> 
> Signed-off-by: Yue Hu <huyue2@yulong.com>

ditto, add the tags from other guyes.

Thanks,
Gao Xiang

> ---
>  drivers/staging/erofs/inode.c | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/staging/erofs/inode.c b/drivers/staging/erofs/inode.c
> index d6e1e16..1433f25 100644
> --- a/drivers/staging/erofs/inode.c
> +++ b/drivers/staging/erofs/inode.c
> @@ -156,7 +156,7 @@ static int fill_inline_data(struct inode *inode, void *data,
>  		inode->i_link = lnk;
>  		set_inode_fast_symlink(inode);
>  	}
> -	return -EAGAIN;
> +	return 0;
>  }
>  
>  static int fill_inode(struct inode *inode, int isdir)
> @@ -223,7 +223,7 @@ static int fill_inode(struct inode *inode, int isdir)
>  		inode->i_mapping->a_ops = &erofs_raw_access_aops;
>  
>  		/* fill last page if inline data is available */
> -		fill_inline_data(inode, data, ofs);
> +		err = fill_inline_data(inode, data, ofs);
>  	}
>  
>  out_unlock:
> 
