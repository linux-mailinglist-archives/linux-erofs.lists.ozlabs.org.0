Return-Path: <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>
X-Original-To: lists+linux-erofs@lfdr.de
Delivered-To: lists+linux-erofs@lfdr.de
Received: from lists.ozlabs.org (lists.ozlabs.org [203.11.71.2])
	by mail.lfdr.de (Postfix) with ESMTPS id 2AB0556731
	for <lists+linux-erofs@lfdr.de>; Wed, 26 Jun 2019 12:52:35 +0200 (CEST)
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2401:3900:2:1::3])
	by lists.ozlabs.org (Postfix) with ESMTP id 45YfxX21Z4zDqWh
	for <lists+linux-erofs@lfdr.de>; Wed, 26 Jun 2019 20:52:32 +1000 (AEST)
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
 by lists.ozlabs.org (Postfix) with ESMTPS id 45YfxQ0g5dzDqWs
 for <linux-erofs@lists.ozlabs.org>; Wed, 26 Jun 2019 20:52:24 +1000 (AEST)
Received: from DGGEMS406-HUB.china.huawei.com (unknown [172.30.72.60])
 by Forcepoint Email with ESMTP id 6E58F3CB74AA66A3D694;
 Wed, 26 Jun 2019 18:52:18 +0800 (CST)
Received: from [10.151.23.176] (10.151.23.176) by smtp.huawei.com
 (10.3.19.206) with Microsoft SMTP Server (TLS) id 14.3.439.0; Wed, 26 Jun
 2019 18:52:08 +0800
Subject: Re: [PATCH RESEND] staging: erofs: remove unsupported ->datamode
 check in fill_inline_data()
To: Yue Hu <zbestahu@gmail.com>, <yuchao0@huawei.com>,
 <gregkh@linuxfoundation.org>
References: <20190626103936.9064-1-zbestahu@gmail.com>
From: Gao Xiang <gaoxiang25@huawei.com>
Message-ID: <9c9c656e-2f29-d086-362e-76bf1760191a@huawei.com>
Date: Wed, 26 Jun 2019 18:51:55 +0800
User-Agent: Mozilla/5.0 (Windows NT 6.1; WOW64; rv:52.0) Gecko/20100101
 Thunderbird/52.3.0
MIME-Version: 1.0
In-Reply-To: <20190626103936.9064-1-zbestahu@gmail.com>
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

On 2019/6/26 18:39, Yue Hu wrote:
> From: Yue Hu <huyue2@yulong.com>
> 
> Already check if ->datamode is supported in read_inode(), no need to check
> again in the next fill_inline_data() only called by fill_inode().
> 
> Signed-off-by: Yue Hu <huyue2@yulong.com>
> Reviewed-by: Gao Xiang <gaoxiang25@huawei.com>
> Reviewed-by: Chao Yu <yuchao0@huawei.com>

Bump the patch version in the title as Greg said...
Otherwise, it is hard to differ which patch is the latest patch...

Thanks,
Gao Xiang

> ---
>  drivers/staging/erofs/inode.c | 2 --
>  1 file changed, 2 deletions(-)
> 
> diff --git a/drivers/staging/erofs/inode.c b/drivers/staging/erofs/inode.c
> index e51348f..d6e1e16 100644
> --- a/drivers/staging/erofs/inode.c
> +++ b/drivers/staging/erofs/inode.c
> @@ -129,8 +129,6 @@ static int fill_inline_data(struct inode *inode, void *data,
>  	struct erofs_sb_info *sbi = EROFS_I_SB(inode);
>  	const int mode = vi->datamode;
>  
> -	DBG_BUGON(mode >= EROFS_INODE_LAYOUT_MAX);
> -
>  	/* should be inode inline C */
>  	if (mode != EROFS_INODE_LAYOUT_INLINE)
>  		return 0;
> 
