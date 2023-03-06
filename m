Return-Path: <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>
X-Original-To: lists+linux-erofs@lfdr.de
Delivered-To: lists+linux-erofs@lfdr.de
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2404:9400:2:0:216:3eff:fee1:b9f1])
	by mail.lfdr.de (Postfix) with ESMTPS id 7EC466AC3B8
	for <lists+linux-erofs@lfdr.de>; Mon,  6 Mar 2023 15:47:09 +0100 (CET)
Received: from boromir.ozlabs.org (localhost [IPv6:::1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4PVhHb2kSjz3cGH
	for <lists+linux-erofs@lfdr.de>; Tue,  7 Mar 2023 01:47:07 +1100 (AEDT)
X-Original-To: linux-erofs@lists.ozlabs.org
Delivered-To: linux-erofs@lists.ozlabs.org
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=linux.alibaba.com (client-ip=115.124.30.130; helo=out30-130.freemail.mail.aliyun.com; envelope-from=hsiangkao@linux.alibaba.com; receiver=<UNKNOWN>)
Received: from out30-130.freemail.mail.aliyun.com (out30-130.freemail.mail.aliyun.com [115.124.30.130])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4PVhHS2BVfz3cBm
	for <linux-erofs@lists.ozlabs.org>; Tue,  7 Mar 2023 01:46:58 +1100 (AEDT)
X-Alimail-AntiSpam: AC=PASS;BC=-1|-1;BR=01201311R151e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=ay29a033018045192;MF=hsiangkao@linux.alibaba.com;NM=1;PH=DS;RN=8;SR=0;TI=SMTPD_---0VdHzJsz_1678114011;
Received: from 30.0.178.195(mailfrom:hsiangkao@linux.alibaba.com fp:SMTPD_---0VdHzJsz_1678114011)
          by smtp.aliyun-inc.com;
          Mon, 06 Mar 2023 22:46:52 +0800
Message-ID: <e5733d0f-d5bb-deb5-20ff-649a9823ffa1@linux.alibaba.com>
Date: Mon, 6 Mar 2023 22:46:50 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:102.0)
 Gecko/20100101 Thunderbird/102.6.1
Subject: Re: [PATCH] erofs: use wrapper i_blocksize() in
 erofs_file_read_iter()
To: Yue Hu <zbestahu@gmail.com>, xiang@kernel.org, chao@kernel.org,
 jefflexu@linux.alibaba.com, linux-erofs@lists.ozlabs.org
References: <20230306075527.1338-1-zbestahu@gmail.com>
From: Gao Xiang <hsiangkao@linux.alibaba.com>
In-Reply-To: <20230306075527.1338-1-zbestahu@gmail.com>
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
Cc: huyue2@coolpad.com, linux-kernel@vger.kernel.org, zhangwen@coolpad.com
Errors-To: linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org
Sender: "Linux-erofs" <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>



On 2023/3/6 15:55, Yue Hu wrote:
> From: Yue Hu <huyue2@coolpad.com>
> 
> linux/fs.h has a wrapper for this operation.
> 
> Signed-off-by: Yue Hu <huyue2@coolpad.com>

Reviewed-by: Gao Xiang <hsiangkao@linux.alibaba.com>

Thanks,
Gao Xiang

> ---
>   fs/erofs/data.c | 2 +-
>   1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/fs/erofs/data.c b/fs/erofs/data.c
> index 5bd0c956a142..7e8baf56faa5 100644
> --- a/fs/erofs/data.c
> +++ b/fs/erofs/data.c
> @@ -380,7 +380,7 @@ static ssize_t erofs_file_read_iter(struct kiocb *iocb, struct iov_iter *to)
>   		if (bdev)
>   			blksize_mask = bdev_logical_block_size(bdev) - 1;
>   		else
> -			blksize_mask = (1 << inode->i_blkbits) - 1;
> +			blksize_mask = i_blocksize(inode) - 1;
>   
>   		if ((iocb->ki_pos | iov_iter_count(to) |
>   		     iov_iter_alignment(to)) & blksize_mask)
