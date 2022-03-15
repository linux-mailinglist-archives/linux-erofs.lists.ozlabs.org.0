Return-Path: <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>
X-Original-To: lists+linux-erofs@lfdr.de
Delivered-To: lists+linux-erofs@lfdr.de
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2404:9400:2:0:216:3eff:fee1:b9f1])
	by mail.lfdr.de (Postfix) with ESMTPS id 5151A4D9902
	for <lists+linux-erofs@lfdr.de>; Tue, 15 Mar 2022 11:43:12 +0100 (CET)
Received: from boromir.ozlabs.org (localhost [IPv6:::1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4KHqkQ15Y9z30Dp
	for <lists+linux-erofs@lfdr.de>; Tue, 15 Mar 2022 21:43:10 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20210112 header.b=GmrNy/EK;
	dkim-atps=neutral
X-Original-To: linux-erofs@lists.ozlabs.org
Delivered-To: linux-erofs@lists.ozlabs.org
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized)
 smtp.mailfrom=gmail.com (client-ip=2607:f8b0:4864:20::42d;
 helo=mail-pf1-x42d.google.com; envelope-from=jnhuang95@gmail.com;
 receiver=<UNKNOWN>)
Authentication-Results: lists.ozlabs.org; dkim=pass (2048-bit key;
 unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256
 header.s=20210112 header.b=GmrNy/EK; dkim-atps=neutral
Received: from mail-pf1-x42d.google.com (mail-pf1-x42d.google.com
 [IPv6:2607:f8b0:4864:20::42d])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 4KHqkM228hz2xt0
 for <linux-erofs@lists.ozlabs.org>; Tue, 15 Mar 2022 21:43:06 +1100 (AEDT)
Received: by mail-pf1-x42d.google.com with SMTP id l8so8482623pfu.1
 for <linux-erofs@lists.ozlabs.org>; Tue, 15 Mar 2022 03:43:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20210112;
 h=message-id:date:mime-version:user-agent:subject:to:cc:references
 :from:in-reply-to:content-transfer-encoding;
 bh=Q+oG0q/OqpLeOMe0H9+8fCVYgPq3RWnQ9esOTCEo9I4=;
 b=GmrNy/EK2El8Qw8A/91ozUTgFaBURa6uPzKvvy0YkvcyJS3P+iOJjGwbO4eG7Ctpri
 JWWHthx/4feeSYD+uhkMt+t13hDbnibm4lQo6cAYmEgOFi5B7Jsm04536KqB+JnBhimX
 S3ntghb/gA2uWNhPzbiuCl5wcK+SxR8ffu0egGVvPtdx6yUdq3UcxMwTy6U+j1j21K6f
 4XGvSC4iLgDV/cYn6W8yZKRh0aiZDJ0BrPLkDXtwkySV0B68UPhGGmRuXinE1UUiUj4k
 DbhIJHIovavmuCt0eSWgLp+tnqeJvuZ+OubQHOzWPM+gByqQfOM2JbfHUl+Wj6X05ZHn
 Uvvw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
 :to:cc:references:from:in-reply-to:content-transfer-encoding;
 bh=Q+oG0q/OqpLeOMe0H9+8fCVYgPq3RWnQ9esOTCEo9I4=;
 b=ShjpGJVCEiZ0TZIJ3Je7ke3zNbuSJNYOD3MeSCpPdkGhB/z25KG/YWOqIINgwIOJJV
 9WAegXdMhob4EHSv80OJAEMXVgCkcY5/Z5URDl5SWX7X+REHljxXc9ie402NZJtArdaE
 lzrOmEYrg95JKmvunVIJh9yT9GrlXLFWhGXPqL++E3Vt9TUG7UfzTcZQyH6Jzsi5IIt+
 ddFf5Cqp8K6VOjWL50Rcc5UQWBLQjkWVP/kR6hrpK+dORJIEY5LTFImj0D/TMsL9R33D
 7AVPcNYL1Y9B3l3EMyxi3pPDyRoqGwp2JTNYtKwgUsHTNOyzmdevBMcTUoih+XAHT2nD
 n4+w==
X-Gm-Message-State: AOAM530IICG1DXew5j6muoMAGfZAMcSQF3p96fSMrUBtqCoCXlZIkyF5
 Vp5wqBmCk3qsRH7XN8RItW0=
X-Google-Smtp-Source: ABdhPJy0ZY7pJoy5uStZDfEyHqVPsFxyURBpRlzb1QREakRD2kLUJZORdGMdmOXiYkJS5xKQh6yQTw==
X-Received: by 2002:a63:7158:0:b0:37d:f96f:3c78 with SMTP id
 b24-20020a637158000000b0037df96f3c78mr23048426pgn.378.1647340983404; 
 Tue, 15 Mar 2022 03:43:03 -0700 (PDT)
Received: from [127.0.0.1] ([103.97.175.139]) by smtp.gmail.com with ESMTPSA id
 j14-20020a056a00174e00b004f776098715sm19768027pfc.68.2022.03.15.03.43.01
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 15 Mar 2022 03:43:03 -0700 (PDT)
Message-ID: <bca8f865-bc3e-44d7-7298-c2c7e8973580@gmail.com>
Date: Tue, 15 Mar 2022 18:43:01 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Thunderbird/91.6.1
Subject: Re: [PATCH] fs: erofs: remember if kobject_init_and_add was done
To: Dongliang Mu <dzm91@hust.edu.cn>, Gao Xiang <xiang@kernel.org>,
 Chao Yu <chao@kernel.org>
References: <20220315075152.63789-1-dzm91@hust.edu.cn>
From: Huang Jianan <jnhuang95@gmail.com>
In-Reply-To: <20220315075152.63789-1-dzm91@hust.edu.cn>
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
Cc: syzkaller <syzkaller@googlegroups.com>, linux-erofs@lists.ozlabs.org,
 Dongliang Mu <mudongliangabcd@gmail.com>, linux-kernel@vger.kernel.org
Errors-To: linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org
Sender: "Linux-erofs"
 <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>

在 2022/3/15 15:51, Dongliang Mu 写道:
> From: Dongliang Mu <mudongliangabcd@gmail.com>
>
> Syzkaller hit 'WARNING: kobject bug in erofs_unregister_sysfs'. This bug
> is triggered by injecting fault in kobject_init_and_add of
> erofs_unregister_sysfs.
>
> Fix this by remembering if kobject_init_and_add is successful.
>
> Note that I've tested the patch and the crash does not occur any more.
>
> Reported-by: syzkaller <syzkaller@googlegroups.com>
> Signed-off-by: Dongliang Mu <mudongliangabcd@gmail.com>
> ---
>   fs/erofs/internal.h | 1 +
>   fs/erofs/sysfs.c    | 9 ++++++---
>   2 files changed, 7 insertions(+), 3 deletions(-)
>
> diff --git a/fs/erofs/internal.h b/fs/erofs/internal.h
> index 5aa2cf2c2f80..9e20665e3f68 100644
> --- a/fs/erofs/internal.h
> +++ b/fs/erofs/internal.h
> @@ -144,6 +144,7 @@ struct erofs_sb_info {
>   	u32 feature_incompat;
>   
>   	/* sysfs support */
> +	bool s_sysfs_inited;

Hi Dongliang,

How about using sbi->s_kobj.state_in_sysfs to avoid adding a extra 
member in sbi ?

Thanks,
Jianan

>   	struct kobject s_kobj;		/* /sys/fs/erofs/<devname> */
>   	struct completion s_kobj_unregister;
>   };
> diff --git a/fs/erofs/sysfs.c b/fs/erofs/sysfs.c
> index dac252bc9228..2b48a4df19b4 100644
> --- a/fs/erofs/sysfs.c
> +++ b/fs/erofs/sysfs.c
> @@ -209,6 +209,7 @@ int erofs_register_sysfs(struct super_block *sb)
>   				   "%s", sb->s_id);
>   	if (err)
>   		goto put_sb_kobj;
> +	sbi->s_sysfs_inited = true;
>   	return 0;
>   
>   put_sb_kobj:
> @@ -221,9 +222,11 @@ void erofs_unregister_sysfs(struct super_block *sb)
>   {
>   	struct erofs_sb_info *sbi = EROFS_SB(sb);
>   
> -	kobject_del(&sbi->s_kobj);
> -	kobject_put(&sbi->s_kobj);
> -	wait_for_completion(&sbi->s_kobj_unregister);
> +	if (sbi->s_sysfs_inited) {
> +		kobject_del(&sbi->s_kobj);
> +		kobject_put(&sbi->s_kobj);
> +		wait_for_completion(&sbi->s_kobj_unregister);
> +	}
>   }
>   
>   int __init erofs_init_sysfs(void)

