Return-Path: <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>
X-Original-To: lists+linux-erofs@lfdr.de
Delivered-To: lists+linux-erofs@lfdr.de
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2404:9400:2:0:216:3eff:fee1:b9f1])
	by mail.lfdr.de (Postfix) with ESMTPS id A2443717203
	for <lists+linux-erofs@lfdr.de>; Wed, 31 May 2023 01:52:03 +0200 (CEST)
Received: from boromir.ozlabs.org (localhost [IPv6:::1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4QW8M52dJxz3cNF
	for <lists+linux-erofs@lfdr.de>; Wed, 31 May 2023 09:52:01 +1000 (AEST)
X-Original-To: linux-erofs@lists.ozlabs.org
Delivered-To: linux-erofs@lists.ozlabs.org
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=linux.alibaba.com (client-ip=115.124.30.100; helo=out30-100.freemail.mail.aliyun.com; envelope-from=hsiangkao@linux.alibaba.com; receiver=<UNKNOWN>)
Received: from out30-100.freemail.mail.aliyun.com (out30-100.freemail.mail.aliyun.com [115.124.30.100])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4QW8M157wRz3bh8
	for <linux-erofs@lists.ozlabs.org>; Wed, 31 May 2023 09:51:57 +1000 (AEST)
X-Alimail-AntiSpam: AC=PASS;BC=-1|-1;BR=01201311R591e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=ay29a033018046056;MF=hsiangkao@linux.alibaba.com;NM=1;PH=DS;RN=5;SR=0;TI=SMTPD_---0Vjv8JtE_1685490710;
Received: from 192.168.138.53(mailfrom:hsiangkao@linux.alibaba.com fp:SMTPD_---0Vjv8JtE_1685490710)
          by smtp.aliyun-inc.com;
          Wed, 31 May 2023 07:51:51 +0800
Message-ID: <1793dc31-d1b1-e2d4-f465-e6688e78ab0b@linux.alibaba.com>
Date: Wed, 31 May 2023 07:51:50 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:102.0)
 Gecko/20100101 Thunderbird/102.10.0
Subject: Re: [PATCH v1 2/2] Allow developer to manually set a max block size
To: Kelvin Zhang <zhangkelvin@google.com>,
 linux-erofs mailing list <linux-erofs@lists.ozlabs.org>,
 Miao Xie <miaoxie@huawei.com>, Fang Wei <fangwei1@huawei.com>
References: <20230530202413.2734743-1-zhangkelvin@google.com>
 <20230530202413.2734743-2-zhangkelvin@google.com>
From: Gao Xiang <hsiangkao@linux.alibaba.com>
In-Reply-To: <20230530202413.2734743-2-zhangkelvin@google.com>
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



On 2023/5/31 04:24, Kelvin Zhang wrote:
> Signed-off-by: Kelvin Zhang <zhangkelvin@google.com>
> ---
>   include/erofs/internal.h | 2 ++
>   1 file changed, 2 insertions(+)
> 
> diff --git a/include/erofs/internal.h b/include/erofs/internal.h
> index b3d04be..6eba35d 100644
> --- a/include/erofs/internal.h
> +++ b/include/erofs/internal.h
> @@ -35,7 +35,9 @@ typedef unsigned short umode_t;
>   #define PAGE_SIZE		(1U << PAGE_SHIFT)
>   #endif
>   
> +#ifndef EROFS_MAX_BLOCK_SIZE
>   #define EROFS_MAX_BLOCK_SIZE	PAGE_SIZE
> +#endif

I have to make a configure.ac for this stuff...

Thanks,
Gao Xiang

>   
>   #define EROFS_ISLOTBITS		5
>   #define EROFS_SLOTSIZE		(1U << EROFS_ISLOTBITS)
