Return-Path: <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>
X-Original-To: lists+linux-erofs@lfdr.de
Delivered-To: lists+linux-erofs@lfdr.de
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	by mail.lfdr.de (Postfix) with ESMTPS id 99EDA728E90
	for <lists+linux-erofs@lfdr.de>; Fri,  9 Jun 2023 05:31:39 +0200 (CEST)
Received: from boromir.ozlabs.org (localhost [IPv6:::1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4QcmpJ5Nd9z3f07
	for <lists+linux-erofs@lfdr.de>; Fri,  9 Jun 2023 13:31:36 +1000 (AEST)
X-Original-To: linux-erofs@lists.ozlabs.org
Delivered-To: linux-erofs@lists.ozlabs.org
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=linux.alibaba.com (client-ip=115.124.30.101; helo=out30-101.freemail.mail.aliyun.com; envelope-from=hsiangkao@linux.alibaba.com; receiver=<UNKNOWN>)
Received: from out30-101.freemail.mail.aliyun.com (out30-101.freemail.mail.aliyun.com [115.124.30.101])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4Qcmp85y85z3cR7
	for <linux-erofs@lists.ozlabs.org>; Fri,  9 Jun 2023 13:31:27 +1000 (AEST)
X-Alimail-AntiSpam: AC=PASS;BC=-1|-1;BR=01201311R181e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=ay29a033018046051;MF=hsiangkao@linux.alibaba.com;NM=1;PH=DS;RN=5;SR=0;TI=SMTPD_---0VkgUALR_1686281479;
Received: from 30.97.48.228(mailfrom:hsiangkao@linux.alibaba.com fp:SMTPD_---0VkgUALR_1686281479)
          by smtp.aliyun-inc.com;
          Fri, 09 Jun 2023 11:31:20 +0800
Message-ID: <7b0ac912-6606-0a76-608d-59f8e2b113ea@linux.alibaba.com>
Date: Fri, 9 Jun 2023 11:31:19 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:102.0)
 Gecko/20100101 Thunderbird/102.10.0
Subject: Re: [PATCH v6 1/5] erofs: use absolute position in xattr iterator
To: Jingbo Xu <jefflexu@linux.alibaba.com>, chao@kernel.org,
 huyue2@coolpad.com, linux-erofs@lists.ozlabs.org
References: <20230608113020.66626-1-jefflexu@linux.alibaba.com>
 <20230608113020.66626-2-jefflexu@linux.alibaba.com>
From: Gao Xiang <hsiangkao@linux.alibaba.com>
In-Reply-To: <20230608113020.66626-2-jefflexu@linux.alibaba.com>
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



On 2023/6/8 19:30, Jingbo Xu wrote:
> Replace blkaddr/ofs with pos in 'struct erofs_xattr_iter'.
> 
> After erofs_bread() is introduced to replace raw page cache APIs for
> metadata I/Os handling, xattr_iter_fixup() is no longer needed anymore.
> 
> In addition, it is also unnecessary to check if the iterated position is
> span over the block boundary as absolute offset is used instead of
> blkaddr + offset pairs.
> 
> Signed-off-by: Jingbo Xu <jefflexu@linux.alibaba.com>

...

>   
> @@ -399,9 +365,10 @@ static int shared_getxattr(struct inode *inode, struct getxattr_iter *it)
>   
>   	for (i = 0; i < vi->xattr_shared_count; ++i) {
>   		xsid = vi->xattr_shared_xattrs[i];
> -		it->it.blkaddr = erofs_xattr_blkaddr(sb, xsid);
> -		it->it.ofs = erofs_xattr_blkoff(sb, xsid);
> -		it->it.kaddr = erofs_bread(&it->it.buf, it->it.blkaddr, EROFS_KMAP);
> +		it->it.pos = erofs_pos(sb, EROFS_SB(sb)->xattr_blkaddr) +
> +				       xsid * sizeof(__u32);

					^ sizeof(__le32); ?

> +		it->it.kaddr = erofs_bread(&it->it.buf,
> +				erofs_blknr(sb, it->it.pos), EROFS_KMAP);
>   		if (IS_ERR(it->it.kaddr))
>   			return PTR_ERR(it->it.kaddr);
>   
> @@ -604,9 +571,10 @@ static int shared_listxattr(struct listxattr_iter *it)
>   
>   	for (i = 0; i < vi->xattr_shared_count; ++i) {
>   		xsid = vi->xattr_shared_xattrs[i];
> -		it->it.blkaddr = erofs_xattr_blkaddr(sb, xsid);
> -		it->it.ofs = erofs_xattr_blkoff(sb, xsid);
> -		it->it.kaddr = erofs_bread(&it->it.buf, it->it.blkaddr, EROFS_KMAP);
> +		it->it.pos = erofs_pos(sb, EROFS_SB(sb)->xattr_blkaddr) +
> +				       xsid * sizeof(__u32);

					^ sizeof(__le32); ?


Otherwise it looks good to me.

Thanks,
Gao Xiang
