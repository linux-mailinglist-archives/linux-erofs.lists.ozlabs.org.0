Return-Path: <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>
X-Original-To: lists+linux-erofs@lfdr.de
Delivered-To: lists+linux-erofs@lfdr.de
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	by mail.lfdr.de (Postfix) with ESMTPS id 18D5763AA34
	for <lists+linux-erofs@lfdr.de>; Mon, 28 Nov 2022 14:57:14 +0100 (CET)
Received: from boromir.ozlabs.org (localhost [IPv6:::1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4NLRqC6wB3z2xl6
	for <lists+linux-erofs@lfdr.de>; Tue, 29 Nov 2022 00:57:11 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=bytedance-com.20210112.gappssmtp.com header.i=@bytedance-com.20210112.gappssmtp.com header.a=rsa-sha256 header.s=20210112 header.b=lZ2i6PZY;
	dkim-atps=neutral
X-Original-To: linux-erofs@lists.ozlabs.org
Delivered-To: linux-erofs@lists.ozlabs.org
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=bytedance.com (client-ip=2607:f8b0:4864:20::1032; helo=mail-pj1-x1032.google.com; envelope-from=zhujia.zj@bytedance.com; receiver=<UNKNOWN>)
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=bytedance-com.20210112.gappssmtp.com header.i=@bytedance-com.20210112.gappssmtp.com header.a=rsa-sha256 header.s=20210112 header.b=lZ2i6PZY;
	dkim-atps=neutral
Received: from mail-pj1-x1032.google.com (mail-pj1-x1032.google.com [IPv6:2607:f8b0:4864:20::1032])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4NLRpB1WFjz3cKG
	for <linux-erofs@lists.ozlabs.org>; Tue, 29 Nov 2022 00:56:18 +1100 (AEDT)
Received: by mail-pj1-x1032.google.com with SMTP id mv18so9569249pjb.0
        for <linux-erofs@lists.ozlabs.org>; Mon, 28 Nov 2022 05:56:18 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance-com.20210112.gappssmtp.com; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to:subject
         :user-agent:mime-version:date:message-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=EN7rQQJkZzGKEVRkng3QEGcqHp0wQ4sozNyGRC6tD9w=;
        b=lZ2i6PZY8eyhSsYyjh+6s0/zQ9/Vo5vtrWFoEW6ECVeZX4emyOz/m78YMnU67H6nky
         jvR9VAX6So1YT6twa/x4ODb9WhBUPTubbTAn3594Ee6GrTcrH2730TOLcqbvRkGBhXVN
         scbhIYD5DtEzyPF5/5zg1dU0vN4OYbImSS6Gc9yTO4e654DhB/3xywxoBsCRZuJVrbrS
         a0hZONlpgUDOxz3VGCVh7Er7e2AYLYdaKH/q4H5vs/q9zaWcecAnO9BbgVjFx5XDbm3+
         z3l9UEwylLYWMwrPsP26ctDFOc6GCvCxpGjLIU12Gclz9d8Ye6bKrQ0C9V9hLUO/dMeQ
         +VWQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to:subject
         :user-agent:mime-version:date:message-id:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=EN7rQQJkZzGKEVRkng3QEGcqHp0wQ4sozNyGRC6tD9w=;
        b=nhDiORFTpvZF/tY4qqAr5SOt7aSMTThhHT6qGWBZitBTDwtEDaxEtRC5Ff+J/7cJg5
         AgZpjexBW7kYebnG5yX4D5VdGRGjW9u7Q6hYPjByz5AmFGw5EE3XzEwiRg0JVg+4IxJH
         Qc7wy3vZW6ZRtPbGW0OYzDdX8tGXSRDJwpDh4qilXxpx6zBbaoJkL+FoVqEhCfUhSvHP
         NwIp3HBoHnPiIrtYkn3PU3wwgzFe61QKZqCG+ROiZRfCAwl4Dy14DBRj2i64nftqkD9O
         jxs3DDrP/jgvUm484SLQu2sJNds4ngzjnr+GOxrzOr1s8FCgISxWpTiWZQk2K5evqrne
         wvgg==
X-Gm-Message-State: ANoB5pl62qRLLUoBdHY03cB4RbBmjPSZ/vtUynjdG8PP4U5IjhU0Dd4k
	5X9+UEMVaIvtWArS+P6/CZtDB4QCRq/fSw==
X-Google-Smtp-Source: AA0mqf4sjfA9knsCcA5y2f2dZ75SzSmtPB28mKVwtEXzFIdeq4+vIwlvPJsPzGmlyJEbi5cz5RpW1g==
X-Received: by 2002:a17:90a:9904:b0:213:6442:232a with SMTP id b4-20020a17090a990400b002136442232amr61073250pjp.117.1669643774308;
        Mon, 28 Nov 2022 05:56:14 -0800 (PST)
Received: from [10.255.134.244] ([139.177.225.246])
        by smtp.gmail.com with ESMTPSA id b4-20020a170902d50400b001869ba04c83sm8873745plg.245.2022.11.28.05.56.12
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 28 Nov 2022 05:56:14 -0800 (PST)
Message-ID: <042ebc25-f9ab-b407-033b-86d6fe5fda98@bytedance.com>
Date: Mon, 28 Nov 2022 21:56:10 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:102.0)
 Gecko/20100101 Thunderbird/102.5.0
Subject: Re: [Phishing Risk] [External] [PATCH v2 2/2] erofs: enable large
 folios for fscache mode
To: Jingbo Xu <jefflexu@linux.alibaba.com>, xiang@kernel.org,
 chao@kernel.org, linux-erofs@lists.ozlabs.org
References: <20221128025011.36352-1-jefflexu@linux.alibaba.com>
 <20221128025011.36352-3-jefflexu@linux.alibaba.com>
From: Jia Zhu <zhujia.zj@bytedance.com>
In-Reply-To: <20221128025011.36352-3-jefflexu@linux.alibaba.com>
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
Cc: linux-kernel@vger.kernel.org
Errors-To: linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org
Sender: "Linux-erofs" <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>



在 2022/11/28 10:50, Jingbo Xu 写道:
> Enable large folios for fscache mode.  Enable this feature for
> non-compressed format for now, until the compression part supports large
> folios later.
> 
> One thing worth noting is that, the feature is not enabled for the meta
> data routine since meta inodes don't need large folios for now, nor do
> they support readahead yet.
> 
> Signed-off-by: Jingbo Xu <jefflexu@linux.alibaba.com>

Reviewed-by: Jia Zhu <zhujia.zj@bytedance.com>

Thanks.
> ---
>   fs/erofs/inode.c | 3 +--
>   1 file changed, 1 insertion(+), 2 deletions(-)
> 
> diff --git a/fs/erofs/inode.c b/fs/erofs/inode.c
> index e457b8a59ee7..85932086d23f 100644
> --- a/fs/erofs/inode.c
> +++ b/fs/erofs/inode.c
> @@ -295,8 +295,7 @@ static int erofs_fill_inode(struct inode *inode)
>   		goto out_unlock;
>   	}
>   	inode->i_mapping->a_ops = &erofs_raw_access_aops;
> -	if (!erofs_is_fscache_mode(inode->i_sb))
> -		mapping_set_large_folios(inode->i_mapping);
> +	mapping_set_large_folios(inode->i_mapping);
>   #ifdef CONFIG_EROFS_FS_ONDEMAND
>   	if (erofs_is_fscache_mode(inode->i_sb))
>   		inode->i_mapping->a_ops = &erofs_fscache_access_aops;
