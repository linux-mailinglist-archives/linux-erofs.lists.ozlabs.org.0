Return-Path: <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>
X-Original-To: lists+linux-erofs@lfdr.de
Delivered-To: lists+linux-erofs@lfdr.de
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2404:9400:2:0:216:3eff:fee1:b9f1])
	by mail.lfdr.de (Postfix) with ESMTPS id 16232465BA7
	for <lists+linux-erofs@lfdr.de>; Thu,  2 Dec 2021 02:30:29 +0100 (CET)
Received: from boromir.ozlabs.org (localhost [IPv6:::1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4J4JL93hm1z305j
	for <lists+linux-erofs@lfdr.de>; Thu,  2 Dec 2021 12:30:25 +1100 (AEDT)
X-Original-To: linux-erofs@lists.ozlabs.org
Delivered-To: linux-erofs@lists.ozlabs.org
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized)
 smtp.mailfrom=linux.alibaba.com (client-ip=115.124.30.57;
 helo=out30-57.freemail.mail.aliyun.com;
 envelope-from=hsiangkao@linux.alibaba.com; receiver=<UNKNOWN>)
Received: from out30-57.freemail.mail.aliyun.com
 (out30-57.freemail.mail.aliyun.com [115.124.30.57])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 4J4JL61wcKz2yfn
 for <linux-erofs@lists.ozlabs.org>; Thu,  2 Dec 2021 12:30:19 +1100 (AEDT)
X-Alimail-AntiSpam: AC=PASS; BC=-1|-1; BR=01201311R271e4; CH=green; DM=||false|;
 DS=||; FP=0|-1|-1|-1|0|-1|-1|-1; HT=e01e04357; MF=hsiangkao@linux.alibaba.com;
 NM=1; PH=DS; RN=5; SR=0; TI=SMTPD_---0Uz7BgFA_1638408597; 
Received: from B-P7TQMD6M-0146.local(mailfrom:hsiangkao@linux.alibaba.com
 fp:SMTPD_---0Uz7BgFA_1638408597) by smtp.aliyun-inc.com(127.0.0.1);
 Thu, 02 Dec 2021 09:29:59 +0800
Date: Thu, 2 Dec 2021 09:29:57 +0800
From: Gao Xiang <hsiangkao@linux.alibaba.com>
To: Kelvin Zhang <zhangkelvin@google.com>
Subject: Re: [PATCH v1] Add an option to only dump/fsck an inode by path
Message-ID: <YaghlcBXDdaF0Y8x@B-P7TQMD6M-0146.local>
References: <20211201214802.1545918-1-zhangkelvin@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20211201214802.1545918-1-zhangkelvin@google.com>
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
Cc: Miao Xie <miaoxie@huawei.com>,
 linux-erofs mailing list <linux-erofs@lists.ozlabs.org>
Errors-To: linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org
Sender: "Linux-erofs"
 <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>

Hi,

On Wed, Dec 01, 2021 at 01:48:02PM -0800, Kelvin Zhang wrote:

...

I will check this main patchset later..
Working on another stuff now.

> diff --git a/mkfs/main.c b/mkfs/main.c
> index 58a6441..d6bc7dd 100644
> --- a/mkfs/main.c
> +++ b/mkfs/main.c
> @@ -24,6 +24,13 @@
>  #include "erofs/compress_hints.h"
>  #include "erofs/blobchunk.h"
>  
> +#ifdef WITH_ANDROID
> +#include <selinux/android.h>
> +#include <private/android_filesystem_config.h>
> +#include <private/canned_fs_config.h>
> +#include <private/fs_config.h>
> +#endif

I planned to add
#include "../lib/liberofs_private.h" instead in the previous patch.

Please help check if any other regression out of Android build...

Thanks,
Gao Xiang
