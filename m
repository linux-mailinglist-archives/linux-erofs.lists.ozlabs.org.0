Return-Path: <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>
X-Original-To: lists+linux-erofs@lfdr.de
Delivered-To: lists+linux-erofs@lfdr.de
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2401:3900:2:1::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 28C292BD78
	for <lists+linux-erofs@lfdr.de>; Tue, 28 May 2019 05:02:36 +0200 (CEST)
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2401:3900:2:1::3])
	by lists.ozlabs.org (Postfix) with ESMTP id 45Cdtd30xkzDqDq
	for <lists+linux-erofs@lfdr.de>; Tue, 28 May 2019 13:02:33 +1000 (AEST)
X-Original-To: linux-erofs@lists.ozlabs.org
Delivered-To: linux-erofs@lists.ozlabs.org
Authentication-Results: lists.ozlabs.org;
 spf=pass (mailfrom) smtp.mailfrom=huawei.com
 (client-ip=45.249.212.32; helo=huawei.com; envelope-from=yuchao0@huawei.com;
 receiver=<UNKNOWN>)
Authentication-Results: lists.ozlabs.org;
 dmarc=none (p=none dis=none) header.from=huawei.com
Received: from huawei.com (szxga06-in.huawei.com [45.249.212.32])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 45CdtW1y1rzDqBm
 for <linux-erofs@lists.ozlabs.org>; Tue, 28 May 2019 13:02:25 +1000 (AEST)
Received: from DGGEMS405-HUB.china.huawei.com (unknown [172.30.72.60])
 by Forcepoint Email with ESMTP id 2B808A1D392843CCC95B;
 Tue, 28 May 2019 11:02:21 +0800 (CST)
Received: from [10.134.22.195] (10.134.22.195) by smtp.huawei.com
 (10.3.19.205) with Microsoft SMTP Server (TLS) id 14.3.439.0; Tue, 28 May
 2019 11:02:11 +0800
Subject: Re: [PATCH v2 2/2] staging: erofs: fix i_blocks calculation
To: Gao Xiang <gaoxiang25@huawei.com>, Greg Kroah-Hartman
 <gregkh@linuxfoundation.org>, <devel@driverdev.osuosl.org>
References: <20190528023147.94117-2-gaoxiang25@huawei.com>
 <20190528023602.178923-1-gaoxiang25@huawei.com>
From: Chao Yu <yuchao0@huawei.com>
Message-ID: <fe0ff7bb-b576-f949-d57a-2892d116b22f@huawei.com>
Date: Tue, 28 May 2019 11:02:12 +0800
User-Agent: Mozilla/5.0 (Windows NT 6.1; WOW64; rv:52.0) Gecko/20100101
 Thunderbird/52.9.1
MIME-Version: 1.0
In-Reply-To: <20190528023602.178923-1-gaoxiang25@huawei.com>
Content-Type: text/plain; charset="windows-1252"
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.134.22.195]
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
Cc: linux-erofs@lists.ozlabs.org, LKML <linux-kernel@vger.kernel.org>,
 weidu.du@huawei.com, Miao Xie <miaoxie@huawei.com>
Errors-To: linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org
Sender: "Linux-erofs"
 <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>

On 2019/5/28 10:36, Gao Xiang wrote:
> For compressed files, i_blocks should not be calculated
> by using i_size. i_u.compressed_blocks is used instead.
> 
> In addition, i_blocks was miscalculated for non-compressed
> files previously, fix it as well.
> 
> Signed-off-by: Gao Xiang <gaoxiang25@huawei.com>
> ---
> change log v2:
>  - fix description in commit message
>  - fix to 'inode->i_blocks = nblks << LOG_SECTORS_PER_BLOCK'
> 
> Thanks,
> Gao Xiang
> 
>  drivers/staging/erofs/inode.c | 14 ++++++++++++--
>  1 file changed, 12 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/staging/erofs/inode.c b/drivers/staging/erofs/inode.c
> index 8da144943ed6..6e67e018784e 100644
> --- a/drivers/staging/erofs/inode.c
> +++ b/drivers/staging/erofs/inode.c
> @@ -20,6 +20,7 @@ static int read_inode(struct inode *inode, void *data)
>  	struct erofs_vnode *vi = EROFS_V(inode);
>  	struct erofs_inode_v1 *v1 = data;
>  	const unsigned int advise = le16_to_cpu(v1->i_advise);
> +	erofs_blk_t nblks = 0;
>  
>  	vi->data_mapping_mode = __inode_data_mapping(advise);
>  
> @@ -60,6 +61,10 @@ static int read_inode(struct inode *inode, void *data)
>  			le32_to_cpu(v2->i_ctime_nsec);
>  
>  		inode->i_size = le64_to_cpu(v2->i_size);
> +
> +		/* total blocks for compressed files */
> +		if (vi->data_mapping_mode == EROFS_INODE_LAYOUT_COMPRESSION)
> +			nblks = v2->i_u.compressed_blocks;

Xiang,

It needs to use le32_to_cpu(). ;)

>  	} else if (__inode_version(advise) == EROFS_INODE_LAYOUT_V1) {
>  		struct erofs_sb_info *sbi = EROFS_SB(inode->i_sb);
>  
> @@ -90,6 +95,8 @@ static int read_inode(struct inode *inode, void *data)
>  			sbi->build_time_nsec;
>  
>  		inode->i_size = le32_to_cpu(v1->i_size);
> +		if (vi->data_mapping_mode == EROFS_INODE_LAYOUT_COMPRESSION)
> +			nblks = v1->i_u.compressed_blocks;

Ditto.

Thanks,

>  	} else {
>  		errln("unsupported on-disk inode version %u of nid %llu",
>  		      __inode_version(advise), vi->nid);
> @@ -97,8 +104,11 @@ static int read_inode(struct inode *inode, void *data)
>  		return -EIO;
>  	}
>  
> -	/* measure inode.i_blocks as the generic filesystem */
> -	inode->i_blocks = ((inode->i_size - 1) >> 9) + 1;
> +	if (!nblks)
> +		/* measure inode.i_blocks as generic filesystems */
> +		inode->i_blocks = roundup(inode->i_size, EROFS_BLKSIZ) >> 9;
> +	else
> +		inode->i_blocks = nblks << LOG_SECTORS_PER_BLOCK;
>  	return 0;
>  }
>  
> 
