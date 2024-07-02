Return-Path: <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>
X-Original-To: lists+linux-erofs@lfdr.de
Delivered-To: lists+linux-erofs@lfdr.de
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	by mail.lfdr.de (Postfix) with ESMTPS id EAB13923D2F
	for <lists+linux-erofs@lfdr.de>; Tue,  2 Jul 2024 14:05:52 +0200 (CEST)
Authentication-Results: lists.ozlabs.org;
	dkim=pass (1024-bit key; unprotected) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.a=rsa-sha256 header.s=default header.b=ctNT+gZu;
	dkim-atps=neutral
Received: from boromir.ozlabs.org (localhost [IPv6:::1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4WD1p20Kcdz3fyQ
	for <lists+linux-erofs@lfdr.de>; Tue,  2 Jul 2024 22:05:46 +1000 (AEST)
X-Original-To: linux-erofs@lists.ozlabs.org
Delivered-To: linux-erofs@lists.ozlabs.org
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (1024-bit key; unprotected) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.a=rsa-sha256 header.s=default header.b=ctNT+gZu;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=linux.alibaba.com (client-ip=115.124.30.124; helo=out30-124.freemail.mail.aliyun.com; envelope-from=hongzhen@linux.alibaba.com; receiver=lists.ozlabs.org)
Received: from out30-124.freemail.mail.aliyun.com (out30-124.freemail.mail.aliyun.com [115.124.30.124])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4WD1ny4hHjz3fQm
	for <linux-erofs@lists.ozlabs.org>; Tue,  2 Jul 2024 22:05:41 +1000 (AEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=linux.alibaba.com; s=default;
	t=1719921938; h=Message-ID:Date:MIME-Version:Subject:To:From:Content-Type;
	bh=h0WVcZ9Sxj9iLxKSEjJWHsJzJfWyAN02ghyrJNfQKD4=;
	b=ctNT+gZuxvvP1w86DTmEkSPkwvWzKQuMazW1Rtk2D++0rgMOI4U1N2NNM2r1j9sCSy9Fwv+F22EJ3MkDyyEgEj1te5L8BJlG+05Vu1mSskAUao/6pgMfaka3U5BcH/8VvJs9GX7sp7uSz8hQWlzJMa00hOe1Vbca/brcQ7RFtVc=
X-Alimail-AntiSpam: AC=PASS;BC=-1|-1;BR=01201311R621e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=maildocker-contentspam033023225041;MF=hongzhen@linux.alibaba.com;NM=1;PH=DS;RN=2;SR=0;TI=SMTPD_---0W9ihiKj_1719921936;
Received: from 30.221.132.199(mailfrom:hongzhen@linux.alibaba.com fp:SMTPD_---0W9ihiKj_1719921936)
          by smtp.aliyun-inc.com;
          Tue, 02 Jul 2024 20:05:37 +0800
Message-ID: <54ea3e82-52af-49e5-bb64-aa9f584928ec@linux.alibaba.com>
Date: Tue, 2 Jul 2024 20:05:36 +0800
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] erofs-utils: lib: chagne function definition of
 erofs_blocklist_open()
To: Gao Xiang <hsiangkao@linux.alibaba.com>, linux-erofs@lists.ozlabs.org
References: <20240702115647.2457003-1-hongzhen@linux.alibaba.com>
 <6c329bf4-9544-4c81-9ac5-5d7afd7a451d@linux.alibaba.com>
From: Hongzhen Luo <hongzhen@linux.alibaba.com>
In-Reply-To: <6c329bf4-9544-4c81-9ac5-5d7afd7a451d@linux.alibaba.com>
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
Errors-To: linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org
Sender: "Linux-erofs" <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>


On 2024/7/2 20:02, Gao Xiang wrote:
>
>
> On 2024/7/2 19:56, Hongzhen Luo wrote:
>> Modified the definition of the function `erofs_blocklist_open` to accept
>> a file pointer rather than a string, for external use in liberofs.
>>
>> Signed-off-by: Hongzhen Luo <hongzhen@linux.alibaba.com>
>> ---
>>   include/erofs/block_list.h |  2 +-
>>   lib/block_list.c           |  9 ++++-----
>>   mkfs/main.c                | 21 ++++++++++++++-------
>>   3 files changed, 19 insertions(+), 13 deletions(-)
>>
>> diff --git a/include/erofs/block_list.h b/include/erofs/block_list.h
>> index 9f9975e..00da82c 100644
>> --- a/include/erofs/block_list.h
>> +++ b/include/erofs/block_list.h
>> @@ -13,7 +13,7 @@ extern "C"
>>     #include "internal.h"
>>   -int erofs_blocklist_open(char *filename, bool srcmap);
>> +int erofs_blocklist_open(FILE *fp, bool srcmap);
>>   void erofs_blocklist_close(void);
>
>
> In that case, should we don't `fclose(block_list_fp);`
> but return `FILE *` instead? As,
>
> FILE *erofs_blocklist_close(void);
>
> And makes the caller to close the FILE *.
>
> Thanks,
> Gao Xiang
Sure, I will send an updated version later.
