Return-Path: <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>
X-Original-To: lists+linux-erofs@lfdr.de
Delivered-To: lists+linux-erofs@lfdr.de
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2401:3900:2:1::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 4F1AD59231
	for <lists+linux-erofs@lfdr.de>; Fri, 28 Jun 2019 05:50:56 +0200 (CEST)
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2401:3900:2:1::3])
	by lists.ozlabs.org (Postfix) with ESMTP id 45ZjV55WPJzDqRm
	for <lists+linux-erofs@lfdr.de>; Fri, 28 Jun 2019 13:50:53 +1000 (AEST)
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
 by lists.ozlabs.org (Postfix) with ESMTPS id 45ZjTz4DW7zDqML
 for <linux-erofs@lists.ozlabs.org>; Fri, 28 Jun 2019 13:50:45 +1000 (AEST)
Received: from DGGEMS406-HUB.china.huawei.com (unknown [172.30.72.60])
 by Forcepoint Email with ESMTP id 7CB03DD74085E2E76CE9;
 Fri, 28 Jun 2019 11:50:40 +0800 (CST)
Received: from [10.151.23.176] (10.151.23.176) by smtp.huawei.com
 (10.3.19.206) with Microsoft SMTP Server (TLS) id 14.3.439.0; Fri, 28 Jun
 2019 11:50:30 +0800
Subject: Re: [PATCH] staging: erofs: don't check special inode layout
To: Yue Hu <zbestahu@gmail.com>, <yuchao0@huawei.com>,
 <gregkh@linuxfoundation.org>
References: <20190628034234.8832-1-zbestahu@gmail.com>
From: Gao Xiang <gaoxiang25@huawei.com>
Message-ID: <276837dc-b18a-6f20-fc33-d988dff5ae9f@huawei.com>
Date: Fri, 28 Jun 2019 11:50:21 +0800
User-Agent: Mozilla/5.0 (Windows NT 6.1; WOW64; rv:52.0) Gecko/20100101
 Thunderbird/52.3.0
MIME-Version: 1.0
In-Reply-To: <20190628034234.8832-1-zbestahu@gmail.com>
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

On 2019/6/28 11:42, Yue Hu wrote:
> From: Yue Hu <huyue2@yulong.com>
> 
> Currently, we will check if inode layout is compression or inline if
> the inode is special in fill_inode(). Also set ->i_mapping->a_ops for
> it. That is pointless since the both modes won't be set for special
> inode when creating EROFS filesystem image. So, let's avoid it.
> 
> Signed-off-by: Yue Hu <huyue2@yulong.com>

Have you test this patch with some actual image with legacy mkfs since
new mkfs framework have not supported special inode...

I think that is fine in priciple, however, in case to introduce some potential
issues, I will test this patch later. I will give a Reviewed-by tag after I tested
this patch.

Thanks,
Gao Xiang

> ---
>  drivers/staging/erofs/inode.c | 1 +
>  1 file changed, 1 insertion(+)
> 
> diff --git a/drivers/staging/erofs/inode.c b/drivers/staging/erofs/inode.c
> index 1433f25..2fe0f6d 100644
> --- a/drivers/staging/erofs/inode.c
> +++ b/drivers/staging/erofs/inode.c
> @@ -205,6 +205,7 @@ static int fill_inode(struct inode *inode, int isdir)
>  			S_ISFIFO(inode->i_mode) || S_ISSOCK(inode->i_mode)) {
>  			inode->i_op = &erofs_generic_iops;
>  			init_special_inode(inode, inode->i_mode, inode->i_rdev);
> +			goto out_unlock;
>  		} else {
>  			err = -EIO;
>  			goto out_unlock;
> 
