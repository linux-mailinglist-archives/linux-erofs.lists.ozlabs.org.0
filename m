Return-Path: <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>
X-Original-To: lists+linux-erofs@lfdr.de
Delivered-To: lists+linux-erofs@lfdr.de
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2404:9400:2:0:216:3eff:fee1:b9f1])
	by mail.lfdr.de (Postfix) with ESMTPS id 0D512919D32
	for <lists+linux-erofs@lfdr.de>; Thu, 27 Jun 2024 04:17:48 +0200 (CEST)
Authentication-Results: lists.ozlabs.org;
	dkim=pass (1024-bit key; unprotected) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.a=rsa-sha256 header.s=default header.b=BxiQK3aj;
	dkim-atps=neutral
Received: from boromir.ozlabs.org (localhost [IPv6:::1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4W8hzr3f7xz3fvk
	for <lists+linux-erofs@lfdr.de>; Thu, 27 Jun 2024 12:17:44 +1000 (AEST)
X-Original-To: linux-erofs@lists.ozlabs.org
Delivered-To: linux-erofs@lists.ozlabs.org
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (1024-bit key; unprotected) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.a=rsa-sha256 header.s=default header.b=BxiQK3aj;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=linux.alibaba.com (client-ip=115.124.30.101; helo=out30-101.freemail.mail.aliyun.com; envelope-from=hsiangkao@linux.alibaba.com; receiver=lists.ozlabs.org)
Received: from out30-101.freemail.mail.aliyun.com (out30-101.freemail.mail.aliyun.com [115.124.30.101])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4W8hzl4BTtz3ftk
	for <linux-erofs@lists.ozlabs.org>; Thu, 27 Jun 2024 12:17:37 +1000 (AEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=linux.alibaba.com; s=default;
	t=1719454655; h=Message-ID:Date:MIME-Version:Subject:To:From:Content-Type;
	bh=l9V7HxwlZVA7S0IGv/mkdf8ACKj26uQTlUZ36taAkOk=;
	b=BxiQK3aj9w+x46VRhiNEc5jGDlI6SeEDrWaXX9HzzFkHx5engHcWZL51sovo+deOl08JMyTxogS5t1PiC8RdI/SUtUTmH0VDi3rrokowcifVRq5ck9K5jla3ISEpjUM0jA6+mFh6ZMxGi9gFUubMK5sUw2g1cFQ1BR/7EMZqnbU=
X-Alimail-AntiSpam: AC=PASS;BC=-1|-1;BR=01201311R821e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=maildocker-contentspam033045046011;MF=hsiangkao@linux.alibaba.com;NM=1;PH=DS;RN=2;SR=0;TI=SMTPD_---0W9L3qfp_1719454653;
Received: from 30.97.48.200(mailfrom:hsiangkao@linux.alibaba.com fp:SMTPD_---0W9L3qfp_1719454653)
          by smtp.aliyun-inc.com;
          Thu, 27 Jun 2024 10:17:34 +0800
Message-ID: <28ac90ef-b966-43bb-834d-789ced6ab1f0@linux.alibaba.com>
Date: Thu, 27 Jun 2024 10:17:33 +0800
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] erofs-utils: lib: add erofs_get_configure
To: Hongzhen Luo <hongzhen@linux.alibaba.com>, linux-erofs@lists.ozlabs.org
References: <20240627021005.3896379-1-hongzhen@linux.alibaba.com>
From: Gao Xiang <hsiangkao@linux.alibaba.com>
In-Reply-To: <20240627021005.3896379-1-hongzhen@linux.alibaba.com>
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
Errors-To: linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org
Sender: "Linux-erofs" <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>



On 2024/6/27 10:10, Hongzhen Luo wrote:
> This introduces the `erofs_get_configure` function to obtain the
> global configuration `cfg`. This allows external entities to get
> and change the `cfg` value through this function, thereby controlling
> the filesystem creation process.

This introduces erofs_get_configure() to get the global
configuration `cfg`.  This allows external entities to change
the global configuration through this helper, thereby controlling
the EROFS mkfs process.

> 
> This is a temporary solution for liberofs to configure the
> filesystem creation, and it will be deprecated in the future.

It is just a temporary helper for liberofs and it will be
deprecated in the future.

> 
> Signed-off-by: Hongzhen Luo <hongzhen@linux.alibaba.com>
> ---
>   include/erofs/config.h | 1 +
>   lib/config.c           | 6 ++++++
>   2 files changed, 7 insertions(+)
> 
> diff --git a/include/erofs/config.h b/include/erofs/config.h
> index 3ce8c59..aa6870d 100644
> --- a/include/erofs/config.h
> +++ b/include/erofs/config.h
> @@ -99,6 +99,7 @@ extern struct erofs_configure cfg;
>   void erofs_init_configure(void);
>   void erofs_show_config(void);
>   void erofs_exit_configure(void);

/* a temporary helper for updating global configuration */

> +struct erofs_configure *erofs_get_configure();
>  >   void erofs_set_fs_root(const char *rootdir);
>   const char *erofs_fspath(const char *fullpath);
> diff --git a/lib/config.c b/lib/config.c
> index 26f1c35..3f93cdb 100644
> --- a/lib/config.c
> +++ b/lib/config.c
> @@ -66,6 +66,12 @@ void erofs_exit_configure(void)
>   		free(cfg.c_compr_opts[i].alg);
>   }
>   
> +/* a temporary solution for liberofs to make configuration */

Drop this one.

Thanks,
Gao Xiang

> +struct erofs_configure *erofs_get_configure()
> +{
> +	return &cfg;
> +}
> +
>   static unsigned int fullpath_prefix;	/* root directory prefix length */
>   
>   void erofs_set_fs_root(const char *rootdir)
