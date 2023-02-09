Return-Path: <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>
X-Original-To: lists+linux-erofs@lfdr.de
Delivered-To: lists+linux-erofs@lfdr.de
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	by mail.lfdr.de (Postfix) with ESMTPS id 9FEEC68FFFE
	for <lists+linux-erofs@lfdr.de>; Thu,  9 Feb 2023 06:45:22 +0100 (CET)
Received: from boromir.ozlabs.org (localhost [IPv6:::1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4PC5S04NyJz3ch4
	for <lists+linux-erofs@lfdr.de>; Thu,  9 Feb 2023 16:45:20 +1100 (AEDT)
X-Original-To: linux-erofs@lists.ozlabs.org
Delivered-To: linux-erofs@lists.ozlabs.org
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=linux.alibaba.com (client-ip=115.124.30.100; helo=out30-100.freemail.mail.aliyun.com; envelope-from=hsiangkao@linux.alibaba.com; receiver=<UNKNOWN>)
Received: from out30-100.freemail.mail.aliyun.com (out30-100.freemail.mail.aliyun.com [115.124.30.100])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4PC5Rw69Hwz3bVr
	for <linux-erofs@lists.ozlabs.org>; Thu,  9 Feb 2023 16:45:16 +1100 (AEDT)
X-Alimail-AntiSpam: AC=PASS;BC=-1|-1;BR=01201311R801e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=ay29a033018045176;MF=hsiangkao@linux.alibaba.com;NM=1;PH=DS;RN=7;SR=0;TI=SMTPD_---0VbEe-fC_1675921511;
Received: from 30.97.49.34(mailfrom:hsiangkao@linux.alibaba.com fp:SMTPD_---0VbEe-fC_1675921511)
          by smtp.aliyun-inc.com;
          Thu, 09 Feb 2023 13:45:13 +0800
Message-ID: <acaf469c-8170-42fa-a166-58dd9a9f7d89@linux.alibaba.com>
Date: Thu, 9 Feb 2023 13:45:11 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:102.0)
 Gecko/20100101 Thunderbird/102.6.1
Subject: Re: [PATCH] MAINTAINERS: erofs: Add
 Documentation/ABI/testing/sysfs-fs-erofs
To: Yangtao Li <frank.li@vivo.com>, xiang@kernel.org, chao@kernel.org,
 huyue2@coolpad.com, jefflexu@linux.alibaba.com
References: <20230209052013.34952-1-frank.li@vivo.com>
From: Gao Xiang <hsiangkao@linux.alibaba.com>
In-Reply-To: <20230209052013.34952-1-frank.li@vivo.com>
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
Cc: linux-erofs@lists.ozlabs.org, linux-kernel@vger.kernel.org
Errors-To: linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org
Sender: "Linux-erofs" <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>



On 2023/2/9 13:20, Yangtao Li wrote:
> Add this doc to the erofs maintainers entry.
> 
> Signed-off-by: Yangtao Li <frank.li@vivo.com>

Reviewed-by: Gao Xiang <hsiangkao@linux.alibaba.com>

Thanks,
Gao Xiang

> ---
>   MAINTAINERS | 1 +
>   1 file changed, 1 insertion(+)
> 
> diff --git a/MAINTAINERS b/MAINTAINERS
> index d0485b58b9d9..7d50e5df4508 100644
> --- a/MAINTAINERS
> +++ b/MAINTAINERS
> @@ -7745,6 +7745,7 @@ R:	Jeffle Xu <jefflexu@linux.alibaba.com>
>   L:	linux-erofs@lists.ozlabs.org
>   S:	Maintained
>   T:	git git://git.kernel.org/pub/scm/linux/kernel/git/xiang/erofs.git
> +F:	Documentation/ABI/testing/sysfs-fs-erofs
>   F:	Documentation/filesystems/erofs.rst
>   F:	fs/erofs/
>   F:	include/trace/events/erofs.h
