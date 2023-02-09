Return-Path: <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>
X-Original-To: lists+linux-erofs@lfdr.de
Delivered-To: lists+linux-erofs@lfdr.de
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2404:9400:2:0:216:3eff:fee1:b9f1])
	by mail.lfdr.de (Postfix) with ESMTPS id 61B5368FDDF
	for <lists+linux-erofs@lfdr.de>; Thu,  9 Feb 2023 04:22:52 +0100 (CET)
Received: from boromir.ozlabs.org (localhost [IPv6:::1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4PC2HY6hXKz3cgs
	for <lists+linux-erofs@lfdr.de>; Thu,  9 Feb 2023 14:22:49 +1100 (AEDT)
X-Original-To: linux-erofs@lists.ozlabs.org
Delivered-To: linux-erofs@lists.ozlabs.org
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=linux.alibaba.com (client-ip=115.124.30.98; helo=out30-98.freemail.mail.aliyun.com; envelope-from=hsiangkao@linux.alibaba.com; receiver=<UNKNOWN>)
Received: from out30-98.freemail.mail.aliyun.com (out30-98.freemail.mail.aliyun.com [115.124.30.98])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4PC2HT2yK3z3bT7
	for <linux-erofs@lists.ozlabs.org>; Thu,  9 Feb 2023 14:22:44 +1100 (AEDT)
X-Alimail-AntiSpam: AC=PASS;BC=-1|-1;BR=01201311R131e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=ay29a033018046050;MF=hsiangkao@linux.alibaba.com;NM=1;PH=DS;RN=7;SR=0;TI=SMTPD_---0VbE36X2_1675912957;
Received: from 30.97.49.34(mailfrom:hsiangkao@linux.alibaba.com fp:SMTPD_---0VbE36X2_1675912957)
          by smtp.aliyun-inc.com;
          Thu, 09 Feb 2023 11:22:40 +0800
Message-ID: <f01cda32-8540-b213-c221-2670f0669c5d@linux.alibaba.com>
Date: Thu, 9 Feb 2023 11:22:37 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:102.0)
 Gecko/20100101 Thunderbird/102.6.1
Subject: Re: [PATCH] erofs: make kobj_type structures constant
To: =?UTF-8?Q?Thomas_Wei=c3=9fschuh?= <linux@weissschuh.net>,
 Gao Xiang <xiang@kernel.org>, Chao Yu <chao@kernel.org>,
 Yue Hu <huyue2@coolpad.com>, Jeffle Xu <jefflexu@linux.alibaba.com>
References: <20230209-kobj_type-erofs-v1-1-078c945e2c4b@weissschuh.net>
From: Gao Xiang <hsiangkao@linux.alibaba.com>
In-Reply-To: <20230209-kobj_type-erofs-v1-1-078c945e2c4b@weissschuh.net>
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
Cc: linux-erofs@lists.ozlabs.org, linux-kernel@vger.kernel.org
Errors-To: linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org
Sender: "Linux-erofs" <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>



On 2023/2/9 11:21, Thomas Weißschuh wrote:
> Since commit ee6d3dd4ed48 ("driver core: make kobj_type constant.")
> the driver core allows the usage of const struct kobj_type.
> 
> Take advantage of this to constify the structure definitions to prevent
> modification at runtime.
> 
> Signed-off-by: Thomas Weißschuh <linux@weissschuh.net>

Acked-by: Gao Xiang <hsiangkao@linux.alibaba.com>

Thanks,
Gao Xiang

> ---
>   fs/erofs/sysfs.c | 6 +++---
>   1 file changed, 3 insertions(+), 3 deletions(-)
> 
> diff --git a/fs/erofs/sysfs.c b/fs/erofs/sysfs.c
> index fd476961f742..435e515c0792 100644
> --- a/fs/erofs/sysfs.c
> +++ b/fs/erofs/sysfs.c
> @@ -179,13 +179,13 @@ static const struct sysfs_ops erofs_attr_ops = {
>   	.store	= erofs_attr_store,
>   };
>   
> -static struct kobj_type erofs_sb_ktype = {
> +static const struct kobj_type erofs_sb_ktype = {
>   	.default_groups = erofs_groups,
>   	.sysfs_ops	= &erofs_attr_ops,
>   	.release	= erofs_sb_release,
>   };
>   
> -static struct kobj_type erofs_ktype = {
> +static const struct kobj_type erofs_ktype = {
>   	.sysfs_ops	= &erofs_attr_ops,
>   };
>   
> @@ -193,7 +193,7 @@ static struct kset erofs_root = {
>   	.kobj	= {.ktype = &erofs_ktype},
>   };
>   
> -static struct kobj_type erofs_feat_ktype = {
> +static const struct kobj_type erofs_feat_ktype = {
>   	.default_groups = erofs_feat_groups,
>   	.sysfs_ops	= &erofs_attr_ops,
>   };
> 
> ---
> base-commit: 0983f6bf2bfc0789b51ddf7315f644ff4da50acb
> change-id: 20230209-kobj_type-erofs-0f0f4c901045
> 
> Best regards,
