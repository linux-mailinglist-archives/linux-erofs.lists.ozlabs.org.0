Return-Path: <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>
X-Original-To: lists+linux-erofs@lfdr.de
Delivered-To: lists+linux-erofs@lfdr.de
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	by mail.lfdr.de (Postfix) with ESMTPS id 6634F967EE7
	for <lists+linux-erofs@lfdr.de>; Mon,  2 Sep 2024 07:47:00 +0200 (CEST)
Received: from boromir.ozlabs.org (localhost [IPv6:::1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4WxySL316pz2yNt
	for <lists+linux-erofs@lfdr.de>; Mon,  2 Sep 2024 15:46:58 +1000 (AEST)
X-Original-To: linux-erofs@lists.ozlabs.org
Delivered-To: linux-erofs@lists.ozlabs.org
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip=115.124.30.110
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1725256015;
	cv=none; b=ewTA1M1bCjttkn7kNYZNFruff8unsDIEb+hyPOLuDva3zm1eFX2WjeQQ0mFEjN3uWxRMJhmV18XT3NzQhz/dUciLdeKKbZgfU5Ilf2GouUHNtmTiDpErt7Yn5nQt809DGw61fbuhle7GXeI3LMUtGdSf5gtmcXzEHxJj/4QrzQFKvu9YqvgB42Pw0zahgWQxIs3DlTdRZCtZT0sN48GtyrYbsb6XbULzjTE1nJR8tlVCY9hVkrkAZsw86mB8nAhwzgELFRlhTmqUj/Oeb+HT8r15pt3FWNuX4itUwnBHg6nHLYqnpRL8IqtKh9Viukp6WOoZqZuKPinW+mQE/HlTsg==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1725256015; c=relaxed/relaxed;
	bh=NblvGvNh6LkL28tvRGtZSNFwsxdRlPOOpqI4KQBIhP0=;
	h=DKIM-Signature:Received:Message-ID:Date:MIME-Version:User-Agent:
	 Subject:To:Cc:References:From:In-Reply-To:Content-Type:
	 Content-Transfer-Encoding; b=GSkumGrofEgYSJEO2qYBMWi++A09VZuCPOCv6EiQlpvI3GSwqfCm2FG84Dxo3RyPQbCqOSJDSS8yPaxsRX2OLQuUjA89xJ7sc813KxO348d/KHycL9DcVyCYSlYvyIjiI0J+KgP1xYj7fVqEj9gXMLYvLZjkFxmd25Mrog2XxQfIO0HzdIsvR8X2/DEfs00Pwj2pMSbvwYg26P9ik74i49BOMfywvAr1K13O4S6P0/8PyBQiMrxesYkPjGGKsfSXFj81k+KW+dpTqUVAyg72iEfC41C80M1PP3z0xasoEsdytjg2fJj40EhOHW2Ey0/wtE9a9dIVpKVTk9HQuVIL0Q==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com; dkim=pass (1024-bit key; unprotected) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.a=rsa-sha256 header.s=default header.b=TOdD0uKf; dkim-atps=neutral; spf=pass (client-ip=115.124.30.110; helo=out30-110.freemail.mail.aliyun.com; envelope-from=hsiangkao@linux.alibaba.com; receiver=lists.ozlabs.org) smtp.mailfrom=linux.alibaba.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (1024-bit key; unprotected) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.a=rsa-sha256 header.s=default header.b=TOdD0uKf;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=linux.alibaba.com (client-ip=115.124.30.110; helo=out30-110.freemail.mail.aliyun.com; envelope-from=hsiangkao@linux.alibaba.com; receiver=lists.ozlabs.org)
Received: from out30-110.freemail.mail.aliyun.com (out30-110.freemail.mail.aliyun.com [115.124.30.110])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4WxySG35cYz2y66
	for <linux-erofs@lists.ozlabs.org>; Mon,  2 Sep 2024 15:46:52 +1000 (AEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=linux.alibaba.com; s=default;
	t=1725256006; h=Message-ID:Date:MIME-Version:Subject:To:From:Content-Type;
	bh=NblvGvNh6LkL28tvRGtZSNFwsxdRlPOOpqI4KQBIhP0=;
	b=TOdD0uKfMLr5zqgrJ/WfSpa8BVL7VdmXCVhIkd6IwjOGpwrGbobNhWa6lD50xmBzMdyaun1gVa2O2HAKQCbjREdKPCLPckBCjhvv49R86/mYi8xX4Vm31OafCSYk+pcS105GTsFjh1z5nO0U9/9ZopdqBLyte+bhoGhXAbLNo5c=
Received: from 30.244.151.91(mailfrom:hsiangkao@linux.alibaba.com fp:SMTPD_---0WE3ke0e_1725256004)
          by smtp.aliyun-inc.com;
          Mon, 02 Sep 2024 13:46:45 +0800
Message-ID: <843a19f2-254c-4025-8df3-fb25f0862b18@linux.alibaba.com>
Date: Mon, 2 Sep 2024 13:46:44 +0800
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 2/2] erofs: use kmemdup_nul in erofs_fill_symlink
To: Yiyang Wu <toolmanp@tlmp.cc>
References: <20240902045100.285477-1-toolmanp@tlmp.cc>
 <20240902045100.285477-3-toolmanp@tlmp.cc>
From: Gao Xiang <hsiangkao@linux.alibaba.com>
In-Reply-To: <20240902045100.285477-3-toolmanp@tlmp.cc>
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
Cc: linux-erofs@lists.ozlabs.org, Al Viro <viro@zeniv.linux.org.uk>
Errors-To: linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org
Sender: "Linux-erofs" <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>

Hi Yiyang,

On 2024/9/2 12:51, Yiyang Wu wrote:
> Remove open coding in erofs_fill_symlink.
> 
> Suggested-by: Al Viro <viro@zeniv.linux.org.uk>
> Link: https://lore.kernel.org/all/20240425222847.GN2118490@ZenIV
> Signed-off-by: Yiyang Wu <toolmanp@tlmp.cc>

Could we lift this patch as [PATCH 1/2]?

> ---
>   fs/erofs/inode.c | 11 ++++-------
>   1 file changed, 4 insertions(+), 7 deletions(-)
> 
> diff --git a/fs/erofs/inode.c b/fs/erofs/inode.c
> index 90f1235dc404..f435752143cb 100644
> --- a/fs/erofs/inode.c
> +++ b/fs/erofs/inode.c
> @@ -21,23 +21,20 @@ static int erofs_fill_symlink(struct inode *inode, void *kaddr,
>   		return 0;
>   	}
>   
> -	lnk = kmalloc(inode->i_size + 1, GFP_KERNEL);
> -	if (!lnk)
> -		return -ENOMEM;
> -
>   	m_pofs += vi->xattr_isize;
> +
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
>   
> +	lnk = kmemdup_nul(kaddr+m_pofs, inode->i_size, GFP_KERNEL);

	lnk = kmemdup_nul(kaddr + m_pofs, inode->i_size, GFP_KERNEL);

Missing blank here.

Thanks,
Gao Xiang
