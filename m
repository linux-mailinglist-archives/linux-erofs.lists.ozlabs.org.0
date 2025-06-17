Return-Path: <linux-erofs+bounces-444-lists+linux-erofs=lfdr.de@lists.ozlabs.org>
X-Original-To: lists+linux-erofs@lfdr.de
Delivered-To: lists+linux-erofs@lfdr.de
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2404:9400:2:0:216:3eff:fee1:b9f1])
	by mail.lfdr.de (Postfix) with ESMTPS id B1C13ADC891
	for <lists+linux-erofs@lfdr.de>; Tue, 17 Jun 2025 12:43:09 +0200 (CEST)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4bM3P71LfYz309v;
	Tue, 17 Jun 2025 20:43:07 +1000 (AEST)
X-Original-To: linux-erofs@lists.ozlabs.org
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip=45.249.212.189
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1750156987;
	cv=none; b=QBledCz2m7rKgWT16ou5VO32S9MN9ahfaGwJmtSYcYZvIYAj9XJkqyj+yIiOMCW5FfCy7Ag45ooqnrsMibeR5i/E1P5A0LjCY5wSfQ8kOu6wA9oJ51ZC+zwnEYceOQHVv6rngkX/UpkHVd6+PN6yY/4NJovm4u9PAGeO8uGG2jdbhdRUaAQIGN1rUxQSOwH7Hxs/6ikKpkjfKDSB2zQdvTwIjVVFVy0a/3calpAS4mq2gSB8Hwhdo5ZlkiYwhboXUmYRXEedAlLknugmWxzG0LH1sGvWrEyIBOEaXRCZKWE+ZrL21/I/WYJ0j+bylNAZj6CUjyYaVPyyB6dXcfNdPQ==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1750156987; c=relaxed/relaxed;
	bh=iQR9ekVezav/APzw6LDX1ME+B4sFESBAyRpijKRjCYc=;
	h=Message-ID:Date:MIME-Version:Subject:To:References:From:
	 In-Reply-To:Content-Type; b=Zob35hVdwbEV4EGyOmXIuuP3yt/150Lq4IkrK4YTOG+fHvLnB9gX+VE1B4mb5qgnrKPOZVA+auUbyzUaY5hf7wv0/Q0ku8C71bYlAlBAh57VbyNM3yGPe+z0ddz97IAQxNXrjSM4gt6tHctJDSAJdxJmvhFGsCWkhD2GO3kO0S/3iIsoYY4vDCUnu5tY3iqAlUf+CUH+yBrxPliJIeY8K/2Vczd7sPQH9m9MB5hQhwvhsHeDKg/ZsSwo2oPWlPaV3Wq1t6YnvbtRpaUbzg1IOfztZoj/TCY7BYeY+mUw6hCrdfiquMpc5I4p/uCNXU8xqzu1MXufGBykcR4PXceJQQ==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass (client-ip=45.249.212.189; helo=szxga03-in.huawei.com; envelope-from=lihongbo22@huawei.com; receiver=lists.ozlabs.org) smtp.mailfrom=huawei.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=huawei.com (client-ip=45.249.212.189; helo=szxga03-in.huawei.com; envelope-from=lihongbo22@huawei.com; receiver=lists.ozlabs.org)
Received: from szxga03-in.huawei.com (szxga03-in.huawei.com [45.249.212.189])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4bM3P60wDhz307V
	for <linux-erofs@lists.ozlabs.org>; Tue, 17 Jun 2025 20:43:04 +1000 (AEST)
Received: from mail.maildlp.com (unknown [172.19.163.174])
	by szxga03-in.huawei.com (SkyGuard) with ESMTP id 4bM3JT5dTqzdbg3
	for <linux-erofs@lists.ozlabs.org>; Tue, 17 Jun 2025 18:39:05 +0800 (CST)
Received: from kwepemo500009.china.huawei.com (unknown [7.202.194.199])
	by mail.maildlp.com (Postfix) with ESMTPS id 007DF14027D
	for <linux-erofs@lists.ozlabs.org>; Tue, 17 Jun 2025 18:43:00 +0800 (CST)
Received: from [10.67.111.104] (10.67.111.104) by
 kwepemo500009.china.huawei.com (7.202.194.199) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.11; Tue, 17 Jun 2025 18:42:59 +0800
Message-ID: <af4500b5-b573-4b4e-8970-b28cd2580e0b@huawei.com>
Date: Tue, 17 Jun 2025 18:42:58 +0800
X-Mailing-List: linux-erofs@lists.ozlabs.org
List-Id: <linux-erofs.lists.ozlabs.org>
List-Help: <mailto:linux-erofs+help@lists.ozlabs.org>
List-Owner: <mailto:linux-erofs+owner@lists.ozlabs.org>
List-Post: <mailto:linux-erofs@lists.ozlabs.org>
List-Subscribe: <mailto:linux-erofs+subscribe@lists.ozlabs.org>,
  <mailto:linux-erofs+subscribe-digest@lists.ozlabs.org>,
  <mailto:linux-erofs+subscribe-nomail@lists.ozlabs.org>
List-Unsubscribe: <mailto:linux-erofs+unsubscribe@lists.ozlabs.org>
Precedence: list
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] erofs: remove unused trace event erofs_destroy_inode
To: <linux-erofs@lists.ozlabs.org>
References: <20250617054056.3232365-1-hsiangkao@linux.alibaba.com>
Content-Language: en-US
From: Hongbo Li <lihongbo22@huawei.com>
In-Reply-To: <20250617054056.3232365-1-hsiangkao@linux.alibaba.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.67.111.104]
X-ClientProxiedBy: kwepems100001.china.huawei.com (7.221.188.238) To
 kwepemo500009.china.huawei.com (7.202.194.199)
X-Spam-Status: No, score=-2.3 required=3.0 tests=RCVD_IN_DNSWL_MED,
	SPF_HELO_NONE,SPF_PASS autolearn=disabled version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-25) on lists.ozlabs.org



On 2025/6/17 13:40, Gao Xiang wrote:
> The trace event `erofs_destroy_inode` was added but remains unused. This
> unused event contributes approximately 5KB to the kernel module size.
> 
> Reported-by: Steven Rostedt <rostedt@goodmis.org>
> Closes: https://lore.kernel.org/r/20250612224906.15000244@batman.local.home
> Fixes: 13f06f48f7bf ("staging: erofs: support tracepoint")
> Cc: stable@vger.kernel.org
> Signed-off-by: Gao Xiang <hsiangkao@linux.alibaba.com>
> ---
>   include/trace/events/erofs.h | 18 ------------------
>   1 file changed, 18 deletions(-)
> 

Reviewed-by: Hongbo Li <lihongbo22@huawei.com>

Thanks,
Hongbo

> diff --git a/include/trace/events/erofs.h b/include/trace/events/erofs.h
> index a5f4b9234f46..dad7360f42f9 100644
> --- a/include/trace/events/erofs.h
> +++ b/include/trace/events/erofs.h
> @@ -211,24 +211,6 @@ TRACE_EVENT(erofs_map_blocks_exit,
>   		  show_mflags(__entry->mflags), __entry->ret)
>   );
>   
> -TRACE_EVENT(erofs_destroy_inode,
> -	TP_PROTO(struct inode *inode),
> -
> -	TP_ARGS(inode),
> -
> -	TP_STRUCT__entry(
> -		__field(	dev_t,		dev		)
> -		__field(	erofs_nid_t,	nid		)
> -	),
> -
> -	TP_fast_assign(
> -		__entry->dev	= inode->i_sb->s_dev;
> -		__entry->nid	= EROFS_I(inode)->nid;
> -	),
> -
> -	TP_printk("dev = (%d,%d), nid = %llu", show_dev_nid(__entry))
> -);
> -
>   #endif /* _TRACE_EROFS_H */
>   
>    /* This part must be outside protection */

