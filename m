Return-Path: <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>
X-Original-To: lists+linux-erofs@lfdr.de
Delivered-To: lists+linux-erofs@lfdr.de
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2404:9400:2:0:216:3eff:fee1:b9f1])
	by mail.lfdr.de (Postfix) with ESMTPS id BFB3A6E1C9E
	for <lists+linux-erofs@lfdr.de>; Fri, 14 Apr 2023 08:28:31 +0200 (CEST)
Received: from boromir.ozlabs.org (localhost [IPv6:::1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4PyRNB2YrQz3f4w
	for <lists+linux-erofs@lfdr.de>; Fri, 14 Apr 2023 16:28:26 +1000 (AEST)
X-Original-To: linux-erofs@lists.ozlabs.org
Delivered-To: linux-erofs@lists.ozlabs.org
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=linux.alibaba.com (client-ip=115.124.30.110; helo=out30-110.freemail.mail.aliyun.com; envelope-from=hsiangkao@linux.alibaba.com; receiver=<UNKNOWN>)
Received: from out30-110.freemail.mail.aliyun.com (out30-110.freemail.mail.aliyun.com [115.124.30.110])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4PyRN23nY9z3c6v
	for <linux-erofs@lists.ozlabs.org>; Fri, 14 Apr 2023 16:28:17 +1000 (AEST)
X-Alimail-AntiSpam: AC=PASS;BC=-1|-1;BR=01201311R461e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=ay29a033018046049;MF=hsiangkao@linux.alibaba.com;NM=1;PH=DS;RN=6;SR=0;TI=SMTPD_---0Vg2TGjn_1681453692;
Received: from 30.97.49.1(mailfrom:hsiangkao@linux.alibaba.com fp:SMTPD_---0Vg2TGjn_1681453692)
          by smtp.aliyun-inc.com;
          Fri, 14 Apr 2023 14:28:13 +0800
Message-ID: <f2cbd4dc-5e24-9d09-4c8c-96d2dc4b2958@linux.alibaba.com>
Date: Fri, 14 Apr 2023 14:28:11 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:102.0)
 Gecko/20100101 Thunderbird/102.9.1
Subject: Re: [PATCH] erofs: fix potential overflow calculating xattr_isize
To: Jingbo Xu <jefflexu@linux.alibaba.com>, xiang@kernel.org,
 chao@kernel.org, huyue2@coolpad.com, linux-erofs@lists.ozlabs.org
References: <20230414061810.6479-1-jefflexu@linux.alibaba.com>
From: Gao Xiang <hsiangkao@linux.alibaba.com>
In-Reply-To: <20230414061810.6479-1-jefflexu@linux.alibaba.com>
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
Cc: linux-kernel@vger.kernel.org
Errors-To: linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org
Sender: "Linux-erofs" <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>



On 2023/4/14 14:18, Jingbo Xu wrote:
> Given on-disk i_xattr_icount is 16 bits and xattr_isize is calculated
> from i_xattr_icount multiplying 4, xattr_isize has a theoretical maximum
> of 256K (64K * 4).
> 
> Thus declare xattr_isize as unsigned int to avoid the potential overflow.
> 
> Fixes: bfb8674dc044 ("staging: erofs: add erofs in-memory stuffs")
> Signed-off-by: Jingbo Xu <jefflexu@linux.alibaba.com>

Thanks for catching this!
Reviewed-by: Gao Xiang <hsiangkao@linux.alibaba.com>

Thanks,
Gao Xiang

> ---
>   fs/erofs/internal.h | 2 +-
>   1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/fs/erofs/internal.h b/fs/erofs/internal.h
> index 8a563374b518..c86241a32ab3 100644
> --- a/fs/erofs/internal.h
> +++ b/fs/erofs/internal.h
> @@ -306,7 +306,7 @@ struct erofs_inode {
>   
>   	unsigned char datalayout;
>   	unsigned char inode_isize;
> -	unsigned short xattr_isize;
> +	unsigned int xattr_isize;
>   
>   	unsigned int xattr_shared_count;
>   	unsigned int *xattr_shared_xattrs;
