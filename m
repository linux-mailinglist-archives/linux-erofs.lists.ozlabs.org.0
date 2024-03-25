Return-Path: <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>
X-Original-To: lists+linux-erofs@lfdr.de
Delivered-To: lists+linux-erofs@lfdr.de
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2404:9400:2:0:216:3eff:fee1:b9f1])
	by mail.lfdr.de (Postfix) with ESMTPS id D64E58886E6
	for <lists+linux-erofs@lfdr.de>; Mon, 25 Mar 2024 02:46:05 +0100 (CET)
Authentication-Results: lists.ozlabs.org;
	dkim=pass (1024-bit key; unprotected) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.a=rsa-sha256 header.s=default header.b=J7uVwsYg;
	dkim-atps=neutral
Received: from boromir.ozlabs.org (localhost [IPv6:::1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4V2wkg4Qmmz3cgJ
	for <lists+linux-erofs@lfdr.de>; Mon, 25 Mar 2024 12:46:03 +1100 (AEDT)
X-Original-To: linux-erofs@lists.ozlabs.org
Delivered-To: linux-erofs@lists.ozlabs.org
Authentication-Results: lists.ozlabs.org;
	dkim=pass (1024-bit key; unprotected) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.a=rsa-sha256 header.s=default header.b=J7uVwsYg;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=linux.alibaba.com (client-ip=115.124.30.111; helo=out30-111.freemail.mail.aliyun.com; envelope-from=jefflexu@linux.alibaba.com; receiver=lists.ozlabs.org)
Received: from out30-111.freemail.mail.aliyun.com (out30-111.freemail.mail.aliyun.com [115.124.30.111])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4V2wkX5mvzz30fh
	for <linux-erofs@lists.ozlabs.org>; Mon, 25 Mar 2024 12:45:54 +1100 (AEDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=linux.alibaba.com; s=default;
	t=1711331150; h=Message-ID:Date:MIME-Version:Subject:To:From:Content-Type;
	bh=leOOK6HGPDBEJ+kEPCPdIg2ftxOl2mg8R0qVMdcL5+c=;
	b=J7uVwsYgfU3m1DD9LI5NLkm5VdVpJa6FZTvh94JWA1rrXdHR4DckdUHKOoFm+zYNXX7696jEZpcWadZtlyWAu2z0Rxb8MyU5+202QyHlPrbo8qadpmTlt0xwIw5VKkcJl8s95KWUsMeTH5EzDmjIe4dbLO1tvZISBsr1Z/Y2+Wg=
X-Alimail-AntiSpam: AC=PASS;BC=-1|-1;BR=01201311R791e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=ay29a033018045168;MF=jefflexu@linux.alibaba.com;NM=1;PH=DS;RN=3;SR=0;TI=SMTPD_---0W381Eop_1711331148;
Received: from 30.221.146.131(mailfrom:jefflexu@linux.alibaba.com fp:SMTPD_---0W381Eop_1711331148)
          by smtp.aliyun-inc.com;
          Mon, 25 Mar 2024 09:45:49 +0800
Message-ID: <ba57f22b-1237-4882-9972-6011c0fb924e@linux.alibaba.com>
Date: Mon, 25 Mar 2024 09:45:47 +0800
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] erofs: drop experimental warning for FSDAX
Content-Language: en-US
To: Gao Xiang <hsiangkao@linux.alibaba.com>, linux-erofs@lists.ozlabs.org
References: <20240325005116.106351-1-hsiangkao@linux.alibaba.com>
From: Jingbo Xu <jefflexu@linux.alibaba.com>
In-Reply-To: <20240325005116.106351-1-hsiangkao@linux.alibaba.com>
Content-Type: text/plain; charset=UTF-8
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
Cc: LKML <linux-kernel@vger.kernel.org>
Errors-To: linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org
Sender: "Linux-erofs" <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>



On 3/25/24 8:51 AM, Gao Xiang wrote:
> As EXT4/XFS filesystems, FSDAX functionality is considered to be stable.
> Let's drop this warning.
> 
> Signed-off-by: Gao Xiang <hsiangkao@linux.alibaba.com>
> ---
>  fs/erofs/super.c | 1 -
>  1 file changed, 1 deletion(-)
> 
> diff --git a/fs/erofs/super.c b/fs/erofs/super.c
> index 6fbb1fba2d31..fc60a5a7794f 100644
> --- a/fs/erofs/super.c
> +++ b/fs/erofs/super.c
> @@ -430,7 +430,6 @@ static bool erofs_fc_set_dax_mode(struct fs_context *fc, unsigned int mode)
>  
>  	switch (mode) {
>  	case EROFS_MOUNT_DAX_ALWAYS:
> -		warnfc(fc, "DAX enabled. Warning: EXPERIMENTAL, use at your own risk");
>  		set_opt(&ctx->opt, DAX_ALWAYS);
>  		clear_opt(&ctx->opt, DAX_NEVER);
>  		return true;

Reviewed-by: Jingbo Xu <jefflexu@linux.alibaba.com>

-- 
Thanks,
Jingbo
