Return-Path: <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>
X-Original-To: lists+linux-erofs@lfdr.de
Delivered-To: lists+linux-erofs@lfdr.de
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2404:9400:2:0:216:3eff:fee1:b9f1])
	by mail.lfdr.de (Postfix) with ESMTPS id 3F11F8B00B3
	for <lists+linux-erofs@lfdr.de>; Wed, 24 Apr 2024 06:54:50 +0200 (CEST)
Authentication-Results: lists.ozlabs.org;
	dkim=pass (1024-bit key; unprotected) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.a=rsa-sha256 header.s=default header.b=WaNCnT70;
	dkim-atps=neutral
Received: from boromir.ozlabs.org (localhost [IPv6:::1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4VPRVb4dgbz3cDw
	for <lists+linux-erofs@lfdr.de>; Wed, 24 Apr 2024 14:54:47 +1000 (AEST)
X-Original-To: linux-erofs@lists.ozlabs.org
Delivered-To: linux-erofs@lists.ozlabs.org
Authentication-Results: lists.ozlabs.org;
	dkim=pass (1024-bit key; unprotected) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.a=rsa-sha256 header.s=default header.b=WaNCnT70;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=linux.alibaba.com (client-ip=115.124.30.130; helo=out30-130.freemail.mail.aliyun.com; envelope-from=hsiangkao@linux.alibaba.com; receiver=lists.ozlabs.org)
Received: from out30-130.freemail.mail.aliyun.com (out30-130.freemail.mail.aliyun.com [115.124.30.130])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4VPRVS0cSyz2xHK
	for <linux-erofs@lists.ozlabs.org>; Wed, 24 Apr 2024 14:54:37 +1000 (AEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=linux.alibaba.com; s=default;
	t=1713934473; h=Message-ID:Date:MIME-Version:Subject:To:From:Content-Type;
	bh=hUgOy25xhxVqqugydOHtlqfebkFjvhdWqRKGYtYkWW8=;
	b=WaNCnT70/zGM2Guu1RQeFPonwAwrGlq4fHWJGohVv6cVWMFWU7MfBemFjVl68Be1dirScLm09Fdr+X8JLjCaX0IdF9xyQl2zjNj+0SNIGD22tzKaqCThlPepjIHOH3LEOblDApE3QHe0p7sBPJXElLhhyOaaAmojUoqcXfYRCRA=
X-Alimail-AntiSpam: AC=PASS;BC=-1|-1;BR=01201311R681e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=maildocker-contentspam033037067110;MF=hsiangkao@linux.alibaba.com;NM=1;PH=DS;RN=2;SR=0;TI=SMTPD_---0W5B1l96_1713934469;
Received: from 30.97.48.214(mailfrom:hsiangkao@linux.alibaba.com fp:SMTPD_---0W5B1l96_1713934469)
          by smtp.aliyun-inc.com;
          Wed, 24 Apr 2024 12:54:30 +0800
Message-ID: <39f07091-6919-4fa6-86b8-cb04f3135fe6@linux.alibaba.com>
Date: Wed, 24 Apr 2024 12:54:29 +0800
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] erofs-utils: add missing block counting
To: Noboru Asai <asai@sijam.com>
References: <20240424043413.90179-1-asai@sijam.com>
From: Gao Xiang <hsiangkao@linux.alibaba.com>
In-Reply-To: <20240424043413.90179-1-asai@sijam.com>
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
Cc: linux-erofs@lists.ozlabs.org
Errors-To: linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org
Sender: "Linux-erofs" <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>

Hi Noboru,

On 2024/4/24 12:34, Noboru Asai wrote:
> Add missing block counting when the data to be inlined is not inlined.
> 
> Signed-off-by: Noboru Asai <asai@sijam.com>


Thanks for catching this! Could we fixup this at
erofs_prepare_tail_block()?

since currently it the place to allocate a tail block for this.

Thanks,
Gao Xiang

> ---
>   lib/inode.c | 1 +
>   1 file changed, 1 insertion(+)
> 
> diff --git a/lib/inode.c b/lib/inode.c
> index cf22bbe..727dcee 100644
> --- a/lib/inode.c
> +++ b/lib/inode.c
> @@ -840,6 +840,7 @@ static int erofs_write_tail_end(struct erofs_inode *inode)
>   		inode->idata_size = 0;
>   		free(inode->idata);
>   		inode->idata = NULL;
> +		inode->u.i_blocks += 1;
>   
>   		erofs_droid_blocklist_write_tail_end(inode, erofs_blknr(sbi, pos));
>   	}
