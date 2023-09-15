Return-Path: <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>
X-Original-To: lists+linux-erofs@lfdr.de
Delivered-To: lists+linux-erofs@lfdr.de
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	by mail.lfdr.de (Postfix) with ESMTPS id 18F637A1999
	for <lists+linux-erofs@lfdr.de>; Fri, 15 Sep 2023 10:55:36 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=lists.ozlabs.org;
	s=201707; t=1694768134;
	bh=C3A2Q+7uqNfRFwjiJsn4cXX6VIZZN+ey242i/wnxUIM=;
	h=Date:Subject:To:References:In-Reply-To:List-Id:List-Unsubscribe:
	 List-Archive:List-Post:List-Help:List-Subscribe:From:Reply-To:Cc:
	 From;
	b=UEHk8h+Cb6thLSW2dt0Xmjbr1XtLpLVe9xU3c8oRJlU+wI5NBGNOUL8rGGBuwaBRp
	 tPoiT+yn5l4uUGL9d6J44IeJEGuFzmc/SFbOPXHEeEWEMYbrxRvTH7nujJxe1g0RbG
	 7y3ICwbz9M4XR04Y3XjipVHSbY6LBdRC4ejffVZdFIOgnoiv2d5JjrSh2CNw2PW8j2
	 ovL+3q+rbA3sxHKltCjBEJ/KxiEwX+/ghKUvcAmby9Kdfbdz3Mg4KoaxqMzi3uLEF5
	 aSGwNG3CcP4IddUJs0bDuTwl8Og98CEnKTot+mG0j4oQFh6QSebY4BWn1Yd0VvlUXj
	 wWOOq2v2rKBzA==
Received: from boromir.ozlabs.org (localhost [IPv6:::1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4Rn7Ls70NLz3cGk
	for <lists+linux-erofs@lfdr.de>; Fri, 15 Sep 2023 18:55:33 +1000 (AEST)
X-Original-To: linux-erofs@lists.ozlabs.org
Delivered-To: linux-erofs@lists.ozlabs.org
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=bytedance.com header.i=@bytedance.com header.a=rsa-sha256 header.s=google header.b=RnvITPy9;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=bytedance.com (client-ip=2607:f8b0:4864:20::42e; helo=mail-pf1-x42e.google.com; envelope-from=zhujia.zj@bytedance.com; receiver=lists.ozlabs.org)
Received: from mail-pf1-x42e.google.com (mail-pf1-x42e.google.com [IPv6:2607:f8b0:4864:20::42e])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4Rn7Lm3Xrfz3c27
	for <linux-erofs@lists.ozlabs.org>; Fri, 15 Sep 2023 18:55:26 +1000 (AEST)
Received: by mail-pf1-x42e.google.com with SMTP id d2e1a72fcca58-68fb46f38f9so1811168b3a.1
        for <linux-erofs@lists.ozlabs.org>; Fri, 15 Sep 2023 01:55:26 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1694768122; x=1695372922;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to:subject
         :user-agent:mime-version:date:message-id:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=C3A2Q+7uqNfRFwjiJsn4cXX6VIZZN+ey242i/wnxUIM=;
        b=R/86O4TwfCcBbyo93KcAv/FMuL9mxyBDVAKHcWozjnicsRQeBICN4VKM5sri9ziTB3
         tJjoJ1wDrYsGvDGAZpAhPRslHlUIR2pXkc4OOh+p//XLl0lwvE6x4tWAhd4MMAdDiFaI
         h53LrkXzu+GOw353lKxX+Fchn9X34L51mzJgKyvedxQJPwVqE+jq9zDuXIloM2Jo4n8s
         3Us9OxVZ438lzbSMssBujWkEcqaKRCROUY3xqTMu+Ez4d+h3En2ZTV1O2BlfX0gFv33S
         DsTGvzKKr6mtogrbx8qbR7HxA+r7abqMLfCBEcU/fEgx6c3odSowPXNuPNXEpjOO4joe
         aicg==
X-Gm-Message-State: AOJu0YzWYjwNfWT/Rsl9ccxOAoXeQg6AZy9z5/kvzfB6cWU0XGbBV8cq
	n75XaeXoDwPq8XIc0Q8pbag1GH45z2k/l1DgZfA=
X-Google-Smtp-Source: AGHT+IHdwJDgJaHBC4fHlkgBshKlaeCkGnD9A9DZKRM7u6gFBjp7btOxwhf66+WH+Vqyn6cfDILPEg==
X-Received: by 2002:a05:6a21:3e0b:b0:156:e1ce:d4a1 with SMTP id bk11-20020a056a213e0b00b00156e1ced4a1mr1137534pzc.9.1694768122609;
        Fri, 15 Sep 2023 01:55:22 -0700 (PDT)
Received: from [10.3.153.195] ([61.213.176.12])
        by smtp.gmail.com with ESMTPSA id jj5-20020a170903048500b001bc6e6069a6sm2958485plb.122.2023.09.15.01.55.20
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 15 Sep 2023 01:55:22 -0700 (PDT)
Message-ID: <79a570f9-b556-8083-c247-e543732316d1@bytedance.com>
Date: Fri, 15 Sep 2023 16:55:18 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:102.0)
 Gecko/20100101 Thunderbird/102.15.0
Subject: Re: [External] [RESEND PATCH] erofs: relax the constraint of
 non-empty device tag in flatdev mode
To: Jingbo Xu <jefflexu@linux.alibaba.com>, xiang@kernel.org,
 chao@kernel.org, linux-erofs@lists.ozlabs.org
References: <20230915082728.56588-1-jefflexu@linux.alibaba.com>
In-Reply-To: <20230915082728.56588-1-jefflexu@linux.alibaba.com>
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
From: Jia Zhu via Linux-erofs <linux-erofs@lists.ozlabs.org>
Reply-To: Jia Zhu <zhujia.zj@bytedance.com>
Cc: huyue2@coolpad.com
Errors-To: linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org
Sender: "Linux-erofs" <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>



在 2023/9/15 16:27, Jingbo Xu 写道:
> The device tag is not required in flatdev mode, and thus relax this
> constraint in flatdev mode.
> 
> Signed-off-by: Jingbo Xu <jefflexu@linux.alibaba.com>

LGTM
Reviewed-by: Jia Zhu <zhujia.zj@bytedance.com>

> ---
> Sorry I forget to cc linux-erofs@lists.ozlabs.org in the former patch.
> ---
>   fs/erofs/super.c | 2 +-
>   1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/fs/erofs/super.c b/fs/erofs/super.c
> index 44a24d573f1f..3700af9ee173 100644
> --- a/fs/erofs/super.c
> +++ b/fs/erofs/super.c
> @@ -235,7 +235,7 @@ static int erofs_init_device(struct erofs_buf *buf, struct super_block *sb,
>   		return PTR_ERR(ptr);
>   	dis = ptr + erofs_blkoff(sb, *pos);
>   
> -	if (!dif->path) {
> +	if (!sbi->devs->flatdev && !dif->path) {
>   		if (!dis->tag[0]) {
>   			erofs_err(sb, "empty device tag @ pos %llu", *pos);
>   			return -EINVAL;
