Return-Path: <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>
X-Original-To: lists+linux-erofs@lfdr.de
Delivered-To: lists+linux-erofs@lfdr.de
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	by mail.lfdr.de (Postfix) with ESMTPS id 6322F85EFBF
	for <lists+linux-erofs@lfdr.de>; Thu, 22 Feb 2024 04:19:56 +0100 (CET)
Authentication-Results: lists.ozlabs.org;
	dkim=pass (1024-bit key; unprotected) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.a=rsa-sha256 header.s=default header.b=w7PD8r1N;
	dkim-atps=neutral
Received: from boromir.ozlabs.org (localhost [IPv6:::1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4TgJKk205Dz3cZL
	for <lists+linux-erofs@lfdr.de>; Thu, 22 Feb 2024 14:19:54 +1100 (AEDT)
X-Original-To: linux-erofs@lists.ozlabs.org
Delivered-To: linux-erofs@lists.ozlabs.org
Authentication-Results: lists.ozlabs.org;
	dkim=pass (1024-bit key; unprotected) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.a=rsa-sha256 header.s=default header.b=w7PD8r1N;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=linux.alibaba.com (client-ip=115.124.30.130; helo=out30-130.freemail.mail.aliyun.com; envelope-from=jefflexu@linux.alibaba.com; receiver=lists.ozlabs.org)
Received: from out30-130.freemail.mail.aliyun.com (out30-130.freemail.mail.aliyun.com [115.124.30.130])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4TgJKc2B8nz3bNs
	for <linux-erofs@lists.ozlabs.org>; Thu, 22 Feb 2024 14:19:45 +1100 (AEDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=linux.alibaba.com; s=default;
	t=1708571981; h=Message-ID:Date:MIME-Version:Subject:To:From:Content-Type;
	bh=V9/JqdFP6+H5ZwF5GLxGFsL2hRG+X43V/o/Ie5ISJlI=;
	b=w7PD8r1NPQ2OClkdgI7DKPnp8Of/q/UEv9hYF3u3DZjeKfgslGyn+f5a1phMX83XibkpD2+8jOU4Doox+YtB3uIt1ct38PlNHQlASziveVFTUucvoEx/9l6kfum10V3+jJMX0cD2/2TX6n4Mnr0RR8WgK25UlIF0hU9Y6RQLgy0=
X-Alimail-AntiSpam: AC=PASS;BC=-1|-1;BR=01201311R191e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=ay29a033018045192;MF=jefflexu@linux.alibaba.com;NM=1;PH=DS;RN=9;SR=0;TI=SMTPD_---0W1.d02z_1708571979;
Received: from 30.221.147.146(mailfrom:jefflexu@linux.alibaba.com fp:SMTPD_---0W1.d02z_1708571979)
          by smtp.aliyun-inc.com;
          Thu, 22 Feb 2024 11:19:40 +0800
Message-ID: <27a77b2a-ad9c-4247-9ddb-61fdf5bb3891@linux.alibaba.com>
Date: Thu, 22 Feb 2024 11:19:38 +0800
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2] erofs: fix refcount on the metabuf used for inode
 lookup
Content-Language: en-US
To: Sandeep Dhavale <dhavale@google.com>, Gao Xiang <xiang@kernel.org>,
 Chao Yu <chao@kernel.org>, Yue Hu <huyue2@coolpad.com>
References: <20240221210348.3667795-1-dhavale@google.com>
From: Jingbo Xu <jefflexu@linux.alibaba.com>
In-Reply-To: <20240221210348.3667795-1-dhavale@google.com>
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
Cc: quic_wenjieli@quicinc.com, linux-erofs@lists.ozlabs.org, kernel-team@android.com, linux-kernel@vger.kernel.org, stable@vger.kernel.org
Errors-To: linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org
Sender: "Linux-erofs" <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>



On 2/22/24 5:03 AM, Sandeep Dhavale wrote:
> In erofs_find_target_block() when erofs_dirnamecmp() returns 0,
> we do not assign the target metabuf. This causes the caller
> erofs_namei()'s erofs_put_metabuf() at the end to be not effective
> leaving the refcount on the page.
> As the page from metabuf (buf->page) is never put, such page cannot be
> migrated or reclaimed. Fix it now by putting the metabuf from
> previous loop and assigning the current metabuf to target before
> returning so caller erofs_namei() can do the final put as it was
> intended.
> 
> Fixes: 500edd095648 ("erofs: use meta buffers for inode lookup")
> Cc: stable@vger.kernel.org
> Signed-off-by: Sandeep Dhavale <dhavale@google.com>


LGTM.

Reviewed-by: Jingbo Xu <jefflexu@linux.alibaba.com>


> ---
> Changes since v1
> - Rearrange the cases as suggested by Gao so there is less duplication
>     of the code and it is more readable
> 
>  fs/erofs/namei.c | 28 ++++++++++++++--------------
>  1 file changed, 14 insertions(+), 14 deletions(-)
> 
> diff --git a/fs/erofs/namei.c b/fs/erofs/namei.c
> index d4f631d39f0f..f0110a78acb2 100644
> --- a/fs/erofs/namei.c
> +++ b/fs/erofs/namei.c
> @@ -130,24 +130,24 @@ static void *erofs_find_target_block(struct erofs_buf *target,
>  			/* string comparison without already matched prefix */
>  			diff = erofs_dirnamecmp(name, &dname, &matched);
>  
> -			if (!diff) {
> -				*_ndirents = 0;
> -				goto out;
> -			} else if (diff > 0) {
> -				head = mid + 1;
> -				startprfx = matched;
> -
> -				if (!IS_ERR(candidate))
> -					erofs_put_metabuf(target);
> -				*target = buf;
> -				candidate = de;
> -				*_ndirents = ndirents;
> -			} else {
> +			if (diff < 0) {
>  				erofs_put_metabuf(&buf);
> -
>  				back = mid - 1;
>  				endprfx = matched;
> +				continue;
> +			}
> +
> +			if (!IS_ERR(candidate))
> +				erofs_put_metabuf(target);
> +			*target = buf;
> +			if (!diff) {
> +				*_ndirents = 0;
> +				return de;
>  			}
> +			head = mid + 1;
> +			startprfx = matched;
> +			candidate = de;
> +			*_ndirents = ndirents;
>  			continue;
>  		}
>  out:		/* free if the candidate is valid */

-- 
Thanks,
Jingbo
