Return-Path: <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>
X-Original-To: lists+linux-erofs@lfdr.de
Delivered-To: lists+linux-erofs@lfdr.de
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2404:9400:2:0:216:3eff:fee1:b9f1])
	by mail.lfdr.de (Postfix) with ESMTPS id BBB1C96802C
	for <lists+linux-erofs@lfdr.de>; Mon,  2 Sep 2024 09:12:01 +0200 (CEST)
Received: from boromir.ozlabs.org (localhost [IPv6:::1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4Wy0LR5YLBz2yDp
	for <lists+linux-erofs@lfdr.de>; Mon,  2 Sep 2024 17:11:59 +1000 (AEST)
X-Original-To: linux-erofs@lists.ozlabs.org
Delivered-To: linux-erofs@lists.ozlabs.org
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip=115.124.30.118
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1725261117;
	cv=none; b=Av4T49EzdNJpWAcvKRavAnh6G/kAg0iKdTEbgf8y5+XIO4Nw8PbvaT9w+yjE6kjoBqUffeHk0QucJVqoHb9tTajORMbY6SKGqzjSliwfAd0dtlMCa+KbwOtQ3EZKx9zSRtChV+cqGDlX5U+sGlUEJ0lDg8WLnuSuloNfnCY4EfjuvTvMJDQ6gQA4GYNXqWdwhG/dWfXjqZRyF9GuzMwW8j2K+CcoDJl6Eom2Cv3ZLIYPLjCXuQan2uaEDjFXUj3Lu7d4hvih8+Wqy/zX/Q4L2KYXb/cMXV8Y2lw798kD13AFOyRcmQrJ4HzCsP0ZppSpH0JnczMB976h+O3CdTG/Ww==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1725261117; c=relaxed/relaxed;
	bh=8CiRHCW9jgKllSt8b4QOJ9tEtCjDj7gOyPLUTr+89X8=;
	h=DKIM-Signature:Received:Message-ID:Date:MIME-Version:User-Agent:
	 Subject:To:Cc:References:From:In-Reply-To:Content-Type:
	 Content-Transfer-Encoding; b=APrMkW1pWQ9YUr+fDyibm/lpDDDYRUnRPxYELnpgtLs40A9UoueaeEk3a8i/KNHv4o4SHPgT8v+/8LMS6wGEiUZGpCMtp+zIvMyNGud+mcrqCNjdStkLKZQZLxL/MmatcHI4OKkcCxVG9Ut1z6A+TIbZakJ1yfto4tcx0+Wre62RPU3cwVm3i7V3TQanXF7xEzvDQ/KRbou3uUCUE0fA2SyvRGRpwRBT0JdhcVQLFCuEg5adGLHo5tHj6uQLDU2Si0gHykoWxkJctNlw6F9Jv1whYlwIypCdrmfn/0tY1Zm/hfLfQLRgjHhKie2GITxyjurgU7zEzU87RbIEoDxN7Q==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com; dkim=pass (1024-bit key; unprotected) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.a=rsa-sha256 header.s=default header.b=e9C/cZDq; dkim-atps=neutral; spf=pass (client-ip=115.124.30.118; helo=out30-118.freemail.mail.aliyun.com; envelope-from=hsiangkao@linux.alibaba.com; receiver=lists.ozlabs.org) smtp.mailfrom=linux.alibaba.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (1024-bit key; unprotected) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.a=rsa-sha256 header.s=default header.b=e9C/cZDq;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=linux.alibaba.com (client-ip=115.124.30.118; helo=out30-118.freemail.mail.aliyun.com; envelope-from=hsiangkao@linux.alibaba.com; receiver=lists.ozlabs.org)
Received: from out30-118.freemail.mail.aliyun.com (out30-118.freemail.mail.aliyun.com [115.124.30.118])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4Wy0LM3T3Xz2xX3
	for <linux-erofs@lists.ozlabs.org>; Mon,  2 Sep 2024 17:11:53 +1000 (AEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=linux.alibaba.com; s=default;
	t=1725261109; h=Message-ID:Date:MIME-Version:Subject:To:From:Content-Type;
	bh=8CiRHCW9jgKllSt8b4QOJ9tEtCjDj7gOyPLUTr+89X8=;
	b=e9C/cZDqTPXMHhi9yiWp8+hupNM2++J51mPqVzfmVNJDRkdEx9N3dVT/rKPc6bbbwU129Mfiux3zBBskcXg7pwMD5o6H3tsXtpY6IcWPqmxC+5DtO9gIX6DBwInR1zuAWEcmLI5Hsdey42KI0XIDJeGtC1G+UDA5rNRjH3P5v7k=
Received: from 30.244.151.91(mailfrom:hsiangkao@linux.alibaba.com fp:SMTPD_---0WE4c6OU_1725261106)
          by smtp.aliyun-inc.com;
          Mon, 02 Sep 2024 15:11:47 +0800
Message-ID: <bfcd83f8-87ef-4282-b9e9-700c45fc3302@linux.alibaba.com>
Date: Mon, 2 Sep 2024 15:11:45 +0800
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH V2 1/2] erofs: use kmemdup_nul in erofs_fill_symlink
To: Yiyang Wu <toolmanp@tlmp.cc>
References: <20240902070047.384952-1-toolmanp@tlmp.cc>
 <20240902070047.384952-2-toolmanp@tlmp.cc>
From: Gao Xiang <hsiangkao@linux.alibaba.com>
In-Reply-To: <20240902070047.384952-2-toolmanp@tlmp.cc>
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
Cc: linux-erofs@lists.ozlabs.org, linux-kernel@vger.kernel.org, Al Viro <viro@zeniv.linux.org.uk>
Errors-To: linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org
Sender: "Linux-erofs" <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>



On 2024/9/2 15:00, Yiyang Wu via Linux-erofs wrote:
> Remove open coding in erofs_fill_symlink.
> 
> Suggested-by: Al Viro <viro@zeniv.linux.org.uk>
> Link: https://lore.kernel.org/all/20240425222847.GN2118490@ZenIV
> Signed-off-by: Yiyang Wu <toolmanp@tlmp.cc>
> ---
>   fs/erofs/inode.c | 12 +++++-------
>   1 file changed, 5 insertions(+), 7 deletions(-)
> 
> diff --git a/fs/erofs/inode.c b/fs/erofs/inode.c
> index 419432be3223..d051afe39670 100644
> --- a/fs/erofs/inode.c
> +++ b/fs/erofs/inode.c
> @@ -188,22 +188,20 @@ static int erofs_fill_symlink(struct inode *inode, void *kaddr,
>   		return 0;
>   	}
>   
> -	lnk = kmalloc(inode->i_size + 1, GFP_KERNEL);
> -	if (!lnk)
> -		return -ENOMEM;
> -
>   	m_pofs += vi->xattr_isize;
>   	/* inline symlink data shouldn't cross block boundary */
>   	if (m_pofs + inode->i_size > bsz) {
> -		kfree(lnk);
>   		erofs_err(inode->i_sb,
>   			  "inline data cross block boundary @ nid %llu",
>   			  vi->nid);
>   		DBG_BUGON(1);
>   		return -EFSCORRUPTED;
>   	}
> -	memcpy(lnk, kaddr + m_pofs, inode->i_size);
> -	lnk[inode->i_size] = '\0';
> +
> +	lnk = kmemdup_nul(kaddr + m_pofs, inode->i_size, GFP_KERNEL);
> +

Unnecessary new line.

Also I wonder if it's possible to just
	inode->i_link = kmemdup_nul(kaddr + m_pofs, inode->i_size, GFP_KERNEL);
	if (!inode->i_link)
		return -ENOMEM;

here, and get rid of variable lnk.

Otherwise it looks good to me.

Thanks,
Gao Xiang

> +	if (!lnk)
> +		return -ENOMEM;
>   
>   	inode->i_link = lnk;
>   	inode->i_op = &erofs_fast_symlink_iops;

