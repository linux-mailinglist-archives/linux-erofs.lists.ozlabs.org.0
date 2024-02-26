Return-Path: <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>
X-Original-To: lists+linux-erofs@lfdr.de
Delivered-To: lists+linux-erofs@lfdr.de
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	by mail.lfdr.de (Postfix) with ESMTPS id B2484866D93
	for <lists+linux-erofs@lfdr.de>; Mon, 26 Feb 2024 10:05:59 +0100 (CET)
Authentication-Results: lists.ozlabs.org;
	dkim=fail reason="signature verification failed" (1024-bit key; unprotected) header.d=linux.dev header.i=@linux.dev header.a=rsa-sha256 header.s=key1 header.b=eG3iAHed;
	dkim-atps=neutral
Received: from boromir.ozlabs.org (localhost [IPv6:::1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4Tjvq93Psyz3cWB
	for <lists+linux-erofs@lfdr.de>; Mon, 26 Feb 2024 20:05:57 +1100 (AEDT)
X-Original-To: linux-erofs@lists.ozlabs.org
Delivered-To: linux-erofs@lists.ozlabs.org
Authentication-Results: lists.ozlabs.org;
	dkim=pass (1024-bit key; unprotected) header.d=linux.dev header.i=@linux.dev header.a=rsa-sha256 header.s=key1 header.b=eG3iAHed;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=linux.dev (client-ip=91.218.175.171; helo=out-171.mta0.migadu.com; envelope-from=chengming.zhou@linux.dev; receiver=lists.ozlabs.org)
X-Greylist: delayed 460 seconds by postgrey-1.37 at boromir; Mon, 26 Feb 2024 20:05:49 AEDT
Received: from out-171.mta0.migadu.com (out-171.mta0.migadu.com [91.218.175.171])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4Tjvq141Wbz2xPd
	for <linux-erofs@lists.ozlabs.org>; Mon, 26 Feb 2024 20:05:49 +1100 (AEDT)
Message-ID: <f4b7e424-8f43-4940-89f0-cdfffbf6bb4c@linux.dev>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1708937854;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=OGvTh26T848JMN3BBqWYMoEdVO583KgJ9tSKxunJFKY=;
	b=eG3iAHedFz6CjYOcYV8vFg6YjWsHc5MirCyzm+JyrQ2Mni1FAtyC1+uK1men9uHOqAPs7/
	OisnnlkKQgBVV1caAbHf6o+d9AQgI2Y3HELcZJvvFuBU0Kl0//ioa+RKNO0cPyvnRkwVcp
	d1Zs90/JLO1DM4gSrwwzZ2MGcBMvWvg=
Date: Mon, 26 Feb 2024 16:57:31 +0800
MIME-Version: 1.0
Subject: Re: [PATCH] erofs: remove SLAB_MEM_SPREAD flag usage
Content-Language: en-US
To: xiang@kernel.org, chao@kernel.org, huyue2@coolpad.com,
 jefflexu@linux.alibaba.com
References: <20240224134749.829361-1-chengming.zhou@linux.dev>
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Chengming Zhou <chengming.zhou@linux.dev>
In-Reply-To: <20240224134749.829361-1-chengming.zhou@linux.dev>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Migadu-Flow: FLOW_OUT
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
Cc: Xiongwei.Song@windriver.com, linux-erofs@lists.ozlabs.org, linux-kernel@vger.kernel.org, vbabka@suse.cz
Errors-To: linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org
Sender: "Linux-erofs" <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>

On 2024/2/24 21:47, chengming.zhou@linux.dev wrote:
> From: Chengming Zhou <zhouchengming@bytedance.com>
> 
> The SLAB_MEM_SPREAD flag is already a no-op as of 6.8-rc1, remove
> its usage so we can delete it from slab. No functional change.

Update changelog to make it clearer:

The SLAB_MEM_SPREAD flag used to be implemented in SLAB, which was
removed as of v6.8-rc1, so it became a dead flag since the commit
16a1d968358a ("mm/slab: remove mm/slab.c and slab_def.h"). And the
series[1] went on to mark it obsolete explicitly to avoid confusion
for users. Here we can just remove all its users, which has no any
functional change.

[1] https://lore.kernel.org/all/20240223-slab-cleanup-flags-v2-1-02f1753e8303@suse.cz/

Thanks!

> 
> Signed-off-by: Chengming Zhou <zhouchengming@bytedance.com>
> ---
>  fs/erofs/super.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/fs/erofs/super.c b/fs/erofs/super.c
> index 9b4b66dcdd4f..8b6bf9ae1a59 100644
> --- a/fs/erofs/super.c
> +++ b/fs/erofs/super.c
> @@ -885,7 +885,7 @@ static int __init erofs_module_init(void)
>  
>  	erofs_inode_cachep = kmem_cache_create("erofs_inode",
>  			sizeof(struct erofs_inode), 0,
> -			SLAB_RECLAIM_ACCOUNT | SLAB_MEM_SPREAD | SLAB_ACCOUNT,
> +			SLAB_RECLAIM_ACCOUNT | SLAB_ACCOUNT,
>  			erofs_inode_init_once);
>  	if (!erofs_inode_cachep)
>  		return -ENOMEM;
