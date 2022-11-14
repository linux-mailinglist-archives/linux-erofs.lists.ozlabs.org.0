Return-Path: <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>
X-Original-To: lists+linux-erofs@lfdr.de
Delivered-To: lists+linux-erofs@lfdr.de
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	by mail.lfdr.de (Postfix) with ESMTPS id A757E6275E9
	for <lists+linux-erofs@lfdr.de>; Mon, 14 Nov 2022 07:28:11 +0100 (CET)
Received: from boromir.ozlabs.org (localhost [IPv6:::1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4N9fWX6QmDz3cJ2
	for <lists+linux-erofs@lfdr.de>; Mon, 14 Nov 2022 17:28:08 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=bytedance-com.20210112.gappssmtp.com header.i=@bytedance-com.20210112.gappssmtp.com header.a=rsa-sha256 header.s=20210112 header.b=jKL0WGoX;
	dkim-atps=neutral
X-Original-To: linux-erofs@lists.ozlabs.org
Delivered-To: linux-erofs@lists.ozlabs.org
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=bytedance.com (client-ip=2607:f8b0:4864:20::634; helo=mail-pl1-x634.google.com; envelope-from=zhujia.zj@bytedance.com; receiver=<UNKNOWN>)
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=bytedance-com.20210112.gappssmtp.com header.i=@bytedance-com.20210112.gappssmtp.com header.a=rsa-sha256 header.s=20210112 header.b=jKL0WGoX;
	dkim-atps=neutral
Received: from mail-pl1-x634.google.com (mail-pl1-x634.google.com [IPv6:2607:f8b0:4864:20::634])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4N9fWN5YtQz2xrL
	for <linux-erofs@lists.ozlabs.org>; Mon, 14 Nov 2022 17:27:58 +1100 (AEDT)
Received: by mail-pl1-x634.google.com with SMTP id w23so2760428ply.12
        for <linux-erofs@lists.ozlabs.org>; Sun, 13 Nov 2022 22:27:58 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance-com.20210112.gappssmtp.com; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to:subject
         :user-agent:mime-version:date:message-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=edVKh9Op+O4fbx8c27lNfz7OBMxqDGoh5epwUTDxhyg=;
        b=jKL0WGoXUwEiirLo+Dnof9voFYs23D+s69KhG5nPSzZOYKLhVOwH4J4sbxckodK/yf
         E1DUeGKuuoUbbGbaB4BbMtpUNiEzpHE1zxmF44kdJvI8OHoGq6irVju0QpFAIKd7B4Ig
         8HIBCbN5+DxSLG+bHad9ED/ixor09mniNTjSgTvNapGsrMx6+O9X7aOK2NU8E/Da5P+f
         IQZvCYH7z1znuE4N/9y6RdHBnbeXLLdlNYJxxU8gCtYesYfUXonGAgasbb8oNINc9pn9
         xqpPrUAEITwblifMJwOQCigc6cg88UT/kkL91SxCQ5afDrUjZG3SSIqMYgqNgQfBhCHX
         p6PQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to:subject
         :user-agent:mime-version:date:message-id:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=edVKh9Op+O4fbx8c27lNfz7OBMxqDGoh5epwUTDxhyg=;
        b=BaJGiQMyFTTMng3V+4Ula2gwyW3dVQPpzD9g9seWRWKaNdOIGhz8ZxQQw9UzMAYUwP
         SkH3rjlSnmweFXoY1dIhdgQ3Cjg85d2wx8YCQ7AEhlCU+5dWD6O2YMcDA5gfox7plhzM
         8jIVHLpRHh+7UPrtngZ/wKI0tBOCDVMAK2EVvFhlk9tCfAfofnaQlIvRkABGm4pTOWEN
         qVLIiM/XtXAvBx55a0KOodxQ+9I5IlsXg/ofLCnxf6zDBuiZTp6CVo5fKZKIXifg3yTb
         xK6c8yrbOQuwKOgyxekjo6KGdei8mgcEZIvKJDyb8bgv/TBzc/Ocg8Jmwg3i5MATkMy3
         v8gw==
X-Gm-Message-State: ANoB5pks1ijL3uzsU58oDI49OiN0H1uMoi08X7pMyObVjHmJF70MuS5u
	vn2Au59u7mNWEhR1tXncgyvhxQ==
X-Google-Smtp-Source: AA0mqf5768TcOEMO7+Om05LJlg6f4J3HdY9G9/SPzBsI0FrUJ+HWeZl2jdWwlgsaS3L8UZVuQ5ozNA==
X-Received: by 2002:a17:902:f78f:b0:188:a793:4127 with SMTP id q15-20020a170902f78f00b00188a7934127mr12503360pln.135.1668407275773;
        Sun, 13 Nov 2022 22:27:55 -0800 (PST)
Received: from [10.3.156.122] ([63.216.146.190])
        by smtp.gmail.com with ESMTPSA id 23-20020a621617000000b0056b6a22d6c9sm5781388pfw.212.2022.11.13.22.27.52
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 13 Nov 2022 22:27:55 -0800 (PST)
Message-ID: <1bcb11ad-e2e0-6c0d-659e-1b20b6b99fb1@bytedance.com>
Date: Mon, 14 Nov 2022 14:27:50 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:102.0)
 Gecko/20100101 Thunderbird/102.4.1
Subject: Re: [Phishing Risk] [External] [PATCH] erofs: fix missing xas_retry()
 in fscache mode
To: Jingbo Xu <jefflexu@linux.alibaba.com>, xiang@kernel.org,
 chao@kernel.org, yinxin.x@bytedance.com, linux-erofs@lists.ozlabs.org
References: <20221111090813.72068-1-jefflexu@linux.alibaba.com>
From: Jia Zhu <zhujia.zj@bytedance.com>
In-Reply-To: <20221111090813.72068-1-jefflexu@linux.alibaba.com>
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
Cc: dhowells@redhat.com, linux-kernel@vger.kernel.org
Errors-To: linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org
Sender: "Linux-erofs" <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>

在 2022/11/11 17:08, Jingbo Xu 写道:
> The xarray iteration only holds RCU and thus may encounter
> XA_RETRY_ENTRY if there's process modifying the xarray concurrently.
> This will cause oops when referring to the invalid entry.
> 
> Fix this by adding the missing xas_retry(), which will make the
> iteration wind back to the root node if XA_RETRY_ENTRY is encountered.
> 
> Fixes: d435d53228dd ("erofs: change to use asynchronous io for fscache readpage/readahead")
> Signed-off-by: Jingbo Xu <jefflexu@linux.alibaba.com>
Reviewed-by: Jia Zhu <zhujia.zj@bytedance.com>
> ---
>   fs/erofs/fscache.c | 10 +++++++---
>   1 file changed, 7 insertions(+), 3 deletions(-)
> 
> diff --git a/fs/erofs/fscache.c b/fs/erofs/fscache.c
> index fe05bc51f9f2..458c1c70ef30 100644
> --- a/fs/erofs/fscache.c
> +++ b/fs/erofs/fscache.c
> @@ -75,11 +75,15 @@ static void erofs_fscache_rreq_unlock_folios(struct netfs_io_request *rreq)
>   
>   	rcu_read_lock();
>   	xas_for_each(&xas, folio, last_page) {
> -		unsigned int pgpos =
> -			(folio_index(folio) - start_page) * PAGE_SIZE;
> -		unsigned int pgend = pgpos + folio_size(folio);
> +		unsigned int pgpos, pgend;
>   		bool pg_failed = false;
>   
> +		if (xas_retry(&xas, folio))
> +			continue;
> +
> +		pgpos = (folio_index(folio) - start_page) * PAGE_SIZE;
> +		pgend = pgpos + folio_size(folio);
> +
>   		for (;;) {
>   			if (!subreq) {
>   				pg_failed = true;
