Return-Path: <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>
X-Original-To: lists+linux-erofs@lfdr.de
Delivered-To: lists+linux-erofs@lfdr.de
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	by mail.lfdr.de (Postfix) with ESMTPS id 7A2DD68FE26
	for <lists+linux-erofs@lfdr.de>; Thu,  9 Feb 2023 04:56:05 +0100 (CET)
Received: from boromir.ozlabs.org (localhost [IPv6:::1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4PC31v2xQMz3ch4
	for <lists+linux-erofs@lfdr.de>; Thu,  9 Feb 2023 14:56:03 +1100 (AEDT)
X-Original-To: linux-erofs@lists.ozlabs.org
Delivered-To: linux-erofs@lists.ozlabs.org
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=linux.alibaba.com (client-ip=115.124.30.111; helo=out30-111.freemail.mail.aliyun.com; envelope-from=jefflexu@linux.alibaba.com; receiver=<UNKNOWN>)
Received: from out30-111.freemail.mail.aliyun.com (out30-111.freemail.mail.aliyun.com [115.124.30.111])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4PC31p5x99z3c4B
	for <linux-erofs@lists.ozlabs.org>; Thu,  9 Feb 2023 14:55:57 +1100 (AEDT)
X-Alimail-AntiSpam: AC=PASS;BC=-1|-1;BR=01201311R971e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=ay29a033018045192;MF=jefflexu@linux.alibaba.com;NM=1;PH=DS;RN=6;SR=0;TI=SMTPD_---0VbEPl.i_1675914953;
Received: from 30.221.133.91(mailfrom:jefflexu@linux.alibaba.com fp:SMTPD_---0VbEPl.i_1675914953)
          by smtp.aliyun-inc.com;
          Thu, 09 Feb 2023 11:55:54 +0800
Message-ID: <33043e28-f0ad-852b-f338-c1ac1174a809@linux.alibaba.com>
Date: Thu, 9 Feb 2023 11:55:53 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:102.0)
 Gecko/20100101 Thunderbird/102.6.1
Subject: Re: [PATCH] erofs: make kobj_type structures constant
Content-Language: en-US
To: =?UTF-8?Q?Thomas_Wei=c3=9fschuh?= <linux@weissschuh.net>,
 Gao Xiang <xiang@kernel.org>, Chao Yu <chao@kernel.org>,
 Yue Hu <huyue2@coolpad.com>
References: <20230209-kobj_type-erofs-v1-1-078c945e2c4b@weissschuh.net>
From: Jingbo Xu <jefflexu@linux.alibaba.com>
In-Reply-To: <20230209-kobj_type-erofs-v1-1-078c945e2c4b@weissschuh.net>
Content-Type: text/plain; charset=UTF-8
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



On 2/9/23 11:21 AM, Thomas Weißschuh wrote:
> Since commit ee6d3dd4ed48 ("driver core: make kobj_type constant.")
> the driver core allows the usage of const struct kobj_type.
> 
> Take advantage of this to constify the structure definitions to prevent
> modification at runtime.
> 
> Signed-off-by: Thomas Weißschuh <linux@weissschuh.net>

Reviewed-by: Jingbo Xu <jefflexu@linux.alibaba.com>


> ---
>  fs/erofs/sysfs.c | 6 +++---
>  1 file changed, 3 insertions(+), 3 deletions(-)
> 
> diff --git a/fs/erofs/sysfs.c b/fs/erofs/sysfs.c
> index fd476961f742..435e515c0792 100644
> --- a/fs/erofs/sysfs.c
> +++ b/fs/erofs/sysfs.c
> @@ -179,13 +179,13 @@ static const struct sysfs_ops erofs_attr_ops = {
>  	.store	= erofs_attr_store,
>  };
>  
> -static struct kobj_type erofs_sb_ktype = {
> +static const struct kobj_type erofs_sb_ktype = {
>  	.default_groups = erofs_groups,
>  	.sysfs_ops	= &erofs_attr_ops,
>  	.release	= erofs_sb_release,
>  };
>  
> -static struct kobj_type erofs_ktype = {
> +static const struct kobj_type erofs_ktype = {
>  	.sysfs_ops	= &erofs_attr_ops,
>  };
>  
> @@ -193,7 +193,7 @@ static struct kset erofs_root = {
>  	.kobj	= {.ktype = &erofs_ktype},
>  };
>  
> -static struct kobj_type erofs_feat_ktype = {
> +static const struct kobj_type erofs_feat_ktype = {
>  	.default_groups = erofs_feat_groups,
>  	.sysfs_ops	= &erofs_attr_ops,
>  };
> 
> ---
> base-commit: 0983f6bf2bfc0789b51ddf7315f644ff4da50acb
> change-id: 20230209-kobj_type-erofs-0f0f4c901045
> 
> Best regards,

-- 
Thanks,
Jingbo
