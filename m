Return-Path: <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>
X-Original-To: lists+linux-erofs@lfdr.de
Delivered-To: lists+linux-erofs@lfdr.de
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2401:3900:2:1::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 19BA42D2810
	for <lists+linux-erofs@lfdr.de>; Tue,  8 Dec 2020 10:48:33 +0100 (CET)
Received: from bilbo.ozlabs.org (lists.ozlabs.org [IPv6:2401:3900:2:1::3])
	by lists.ozlabs.org (Postfix) with ESMTP id 4CqwNZ2lHnzDqXY
	for <lists+linux-erofs@lfdr.de>; Tue,  8 Dec 2020 20:48:30 +1100 (AEDT)
X-Original-To: linux-erofs@lists.ozlabs.org
Delivered-To: linux-erofs@lists.ozlabs.org
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized)
 smtp.mailfrom=huawei.com (client-ip=45.249.212.191; helo=szxga05-in.huawei.com;
 envelope-from=yuchao0@huawei.com; receiver=<UNKNOWN>)
Authentication-Results: lists.ozlabs.org;
 dmarc=none (p=none dis=none) header.from=huawei.com
Received: from szxga05-in.huawei.com (szxga05-in.huawei.com [45.249.212.191])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256
 bits)) (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 4CqwNQ6LPzzDqW2
 for <linux-erofs@lists.ozlabs.org>; Tue,  8 Dec 2020 20:48:21 +1100 (AEDT)
Received: from DGGEMS402-HUB.china.huawei.com (unknown [172.30.72.60])
 by szxga05-in.huawei.com (SkyGuard) with ESMTP id 4CqwMg24z0zhnyn;
 Tue,  8 Dec 2020 17:47:43 +0800 (CST)
Received: from [10.136.114.67] (10.136.114.67) by smtp.huawei.com
 (10.3.19.202) with Microsoft SMTP Server (TLS) id 14.3.487.0; Tue, 8 Dec 2020
 17:48:11 +0800
Subject: Re: [PATCH v2] erofs: fix wrong address in erofs_get_block
To: Huang Jianan <huangjianan@oppo.com>, <linux-erofs@lists.ozlabs.org>
References: <20201208093133.5865-1-huangjianan@oppo.com>
From: Chao Yu <yuchao0@huawei.com>
Message-ID: <9fb238a9-ad1e-cf7b-7b42-291e5f0e8929@huawei.com>
Date: Tue, 8 Dec 2020 17:48:10 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:52.0) Gecko/20100101
 Thunderbird/52.9.1
MIME-Version: 1.0
In-Reply-To: <20201208093133.5865-1-huangjianan@oppo.com>
Content-Type: text/plain; charset="windows-1252"; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.136.114.67]
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
Cc: guoweichao@oppo.com, zhangshiming@oppo.com
Errors-To: linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org
Sender: "Linux-erofs"
 <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>

On 2020/12/8 17:31, Huang Jianan wrote:
> iblock indicates the number of i_blkbits-sized blocks rather than
> sectors, fix it.
> 
> If the data has a disk mapping, map_bh should be used to read the
> correct data from the device.

Thanks for the fix, I was misled by sector_t type...

What about avoiding using generic_block_bmap() which uses buffer_head
structure, it limits mapped size to 32-bits:

https://git.kernel.org/pub/scm/linux/kernel/git/jaegeuk/f2fs.git/commit/?h=dev-test&id=b876f4c94c3d1688edea021d45a528571499e0b9

Thanks,

> 
> Fixes: 9da681e017a3 ("staging: erofs: support bmap")
> Signed-off-by: Huang Jianan <huangjianan@oppo.com>
> Signed-off-by: Guo Weichao <guoweichao@oppo.com>
> ---
>   fs/erofs/data.c | 4 ++--
>   1 file changed, 2 insertions(+), 2 deletions(-)
> 
> diff --git a/fs/erofs/data.c b/fs/erofs/data.c
> index 347be146884c..aad3fb68d6c8 100644
> --- a/fs/erofs/data.c
> +++ b/fs/erofs/data.c
> @@ -316,7 +316,7 @@ static int erofs_get_block(struct inode *inode, sector_t iblock,
>   			   struct buffer_head *bh, int create)
>   {
>   	struct erofs_map_blocks map = {
> -		.m_la = iblock << 9,
> +		.m_la = blknr_to_addr(iblock),
>   	};
>   	int err;
>   
> @@ -325,7 +325,7 @@ static int erofs_get_block(struct inode *inode, sector_t iblock,
>   		return err;
>   
>   	if (map.m_flags & EROFS_MAP_MAPPED)
> -		bh->b_blocknr = erofs_blknr(map.m_pa);
> +		map_bh(bh, inode->i_sb, erofs_blknr(map.m_pa));
>   
>   	return err;
>   }
> 
