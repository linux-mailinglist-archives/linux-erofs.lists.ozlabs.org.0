Return-Path: <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>
X-Original-To: lists+linux-erofs@lfdr.de
Delivered-To: lists+linux-erofs@lfdr.de
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2404:9400:2:0:216:3eff:fee1:b9f1])
	by mail.lfdr.de (Postfix) with ESMTPS id A4EEB68E8D9
	for <lists+linux-erofs@lfdr.de>; Wed,  8 Feb 2023 08:21:34 +0100 (CET)
Received: from boromir.ozlabs.org (localhost [IPv6:::1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4PBWdS32y6z3cdp
	for <lists+linux-erofs@lfdr.de>; Wed,  8 Feb 2023 18:21:32 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=bytedance-com.20210112.gappssmtp.com header.i=@bytedance-com.20210112.gappssmtp.com header.a=rsa-sha256 header.s=20210112 header.b=7Coj5NK2;
	dkim-atps=neutral
X-Original-To: linux-erofs@lists.ozlabs.org
Delivered-To: linux-erofs@lists.ozlabs.org
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=bytedance.com (client-ip=2607:f8b0:4864:20::629; helo=mail-pl1-x629.google.com; envelope-from=zhujia.zj@bytedance.com; receiver=<UNKNOWN>)
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=bytedance-com.20210112.gappssmtp.com header.i=@bytedance-com.20210112.gappssmtp.com header.a=rsa-sha256 header.s=20210112 header.b=7Coj5NK2;
	dkim-atps=neutral
Received: from mail-pl1-x629.google.com (mail-pl1-x629.google.com [IPv6:2607:f8b0:4864:20::629])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4PBWdM15W7z3bTK
	for <linux-erofs@lists.ozlabs.org>; Wed,  8 Feb 2023 18:21:26 +1100 (AEDT)
Received: by mail-pl1-x629.google.com with SMTP id k13so18360131plg.0
        for <linux-erofs@lists.ozlabs.org>; Tue, 07 Feb 2023 23:21:26 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance-com.20210112.gappssmtp.com; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to:subject
         :user-agent:mime-version:date:message-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=QnQlhoNYMIV2+tPGF0jfk+u/gLKVHE9+bmnI1kjJ9n8=;
        b=7Coj5NK2+px3MdXfVaXjjriO6mBmLQj4BgF15WCpKicFq3eLsaL2MKmI36JutdzESZ
         7gnG0bzZPj5M3xwBq1uDlsPRIGllENqNT/mI8ol8aVHYNfaKg3H9v1doGu0r8H+UO0Vh
         lFS23Py4+jCFC80nahEE4pap+BbKOplsVj88gZLUP6AKdU0tr+ihCANq+nFWCYjaacFt
         4LtRVwKNNBNTIsGSZj9krVFu713EDbZCbpAxJGQuK71SzzTT8VVhs76ybrVyq+atxWeO
         Mcyvb+0UKSmHC/KZzgVg6VwsEXhYHxdA0bBlfiVmyoZR33yCKLgy6mzpVWclOL5DD87c
         xCMA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to:subject
         :user-agent:mime-version:date:message-id:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=QnQlhoNYMIV2+tPGF0jfk+u/gLKVHE9+bmnI1kjJ9n8=;
        b=jfnM3I7XUPlpSOliEILkUvApGBT/aWEaMC65+ccYCHNvWzLaISo51iNe7OVd5ahYn9
         NboPIZOyvuk3VshDb2GqhzTl4QHQfFtImx5RbPmwBbRiT/LOgThxIz86NYGnGVBYNo22
         rlewFIClO+JDu658E2BO6XXWvACvhlKo/2muZpIRKKm11DeZ+C9A1EM7TihlGyFQUDvh
         uARpgm63DoW2I4oJDEnHnxOip78G1HdLAgwj38iEHQ6OQnjGSevqXi8iyVg4B66sv0TK
         fmxt2l03hrthKkYXh2iddon1WaU2ebKLsYc9t7v0SHauYtV1dM/vCKb7c4q0FzPeoT/Y
         WVYQ==
X-Gm-Message-State: AO0yUKVs87UB9F1xrSUc6B5JWdz1sdvY9mRRPYvY7m/b8/ulphW/SW6g
	16Wh7+VJ1AUrvvIqnseo2Ec3Kg==
X-Google-Smtp-Source: AK7set9wzjN75WoOlnhsYSX3I0lzKSyFktywX6IgtJNMFLJ7itZa+IX/jGYO653vXPTegzI8p8GaKQ==
X-Received: by 2002:a17:902:e751:b0:198:e8f3:6a48 with SMTP id p17-20020a170902e75100b00198e8f36a48mr7733926plf.9.1675840884028;
        Tue, 07 Feb 2023 23:21:24 -0800 (PST)
Received: from [10.3.144.50] ([61.213.176.11])
        by smtp.gmail.com with ESMTPSA id v13-20020a17090331cd00b00198f1de408csm8057070ple.268.2023.02.07.23.21.21
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 07 Feb 2023 23:21:23 -0800 (PST)
Message-ID: <c733fc59-ed5e-276d-35c0-1a45257654f0@bytedance.com>
Date: Wed, 8 Feb 2023 15:21:18 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:102.0)
 Gecko/20100101 Thunderbird/102.6.1
Subject: Re: [External] [PATCH 1/4] erofs: remove unused device mapping in
 meta routine
To: Jingbo Xu <jefflexu@linux.alibaba.com>, xiang@kernel.org,
 chao@kernel.org, linux-erofs@lists.ozlabs.org
References: <cover.1675840368.git.jefflexu@linux.alibaba.com>
 <404848a1e43ff2d585c91e222beae4de8b9fb5f3.1675840368.git.jefflexu@linux.alibaba.com>
From: Jia Zhu <zhujia.zj@bytedance.com>
In-Reply-To: <404848a1e43ff2d585c91e222beae4de8b9fb5f3.1675840368.git.jefflexu@linux.alibaba.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
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
Cc: huyue2@coolpad.com, linux-kernel@vger.kernel.org
Errors-To: linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org
Sender: "Linux-erofs" <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>



在 2023/2/8 15:16, Jingbo Xu 写道:
> Currently metadata is always on bootstrap, and thus device mapping is
> not needed so far.  Remove the redundant device mapping in the meta
> routine.
> 
> Signed-off-by: Jingbo Xu <jefflexu@linux.alibaba.com>

Reviewed-by: Jia Zhu <zhujia.zj@bytedance.com>

> ---
>   fs/erofs/fscache.c | 17 ++++-------------
>   1 file changed, 4 insertions(+), 13 deletions(-)
> 
> diff --git a/fs/erofs/fscache.c b/fs/erofs/fscache.c
> index 014e20962376..03de4dc99302 100644
> --- a/fs/erofs/fscache.c
> +++ b/fs/erofs/fscache.c
> @@ -164,18 +164,8 @@ static int erofs_fscache_read_folios_async(struct fscache_cookie *cookie,
>   static int erofs_fscache_meta_read_folio(struct file *data, struct folio *folio)
>   {
>   	int ret;
> -	struct super_block *sb = folio_mapping(folio)->host->i_sb;
> +	struct erofs_fscache *ctx = folio_mapping(folio)->host->i_private;
>   	struct erofs_fscache_request *req;
> -	struct erofs_map_dev mdev = {
> -		.m_deviceid = 0,
> -		.m_pa = folio_pos(folio),
> -	};
> -
> -	ret = erofs_map_dev(sb, &mdev);
> -	if (ret) {
> -		folio_unlock(folio);
> -		return ret;
> -	}
>   
>   	req = erofs_fscache_req_alloc(folio_mapping(folio),
>   				folio_pos(folio), folio_size(folio));
> @@ -184,8 +174,8 @@ static int erofs_fscache_meta_read_folio(struct file *data, struct folio *folio)
>   		return PTR_ERR(req);
>   	}
>   
> -	ret = erofs_fscache_read_folios_async(mdev.m_fscache->cookie,
> -				req, mdev.m_pa, folio_size(folio));
> +	ret = erofs_fscache_read_folios_async(ctx->cookie, req,
> +				folio_pos(folio), folio_size(folio));
>   	if (ret)
>   		req->error = ret;
>   
> @@ -469,6 +459,7 @@ struct erofs_fscache *erofs_fscache_acquire_cookie(struct super_block *sb,
>   		inode->i_size = OFFSET_MAX;
>   		inode->i_mapping->a_ops = &erofs_fscache_meta_aops;
>   		mapping_set_gfp_mask(inode->i_mapping, GFP_NOFS);
> +		inode->i_private = ctx;
>   
>   		ctx->inode = inode;
>   	}
