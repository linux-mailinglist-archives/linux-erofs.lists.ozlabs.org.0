Return-Path: <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>
X-Original-To: lists+linux-erofs@lfdr.de
Delivered-To: lists+linux-erofs@lfdr.de
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2404:9400:2:0:216:3eff:fee1:b9f1])
	by mail.lfdr.de (Postfix) with ESMTPS id 1050086C606
	for <lists+linux-erofs@lfdr.de>; Thu, 29 Feb 2024 10:50:24 +0100 (CET)
Authentication-Results: lists.ozlabs.org;
	dkim=pass (1024-bit key; unprotected) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.a=rsa-sha256 header.s=default header.b=dNYbHGx+;
	dkim-atps=neutral
Received: from boromir.ozlabs.org (localhost [IPv6:::1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4Tlmg02P32z3dS8
	for <lists+linux-erofs@lfdr.de>; Thu, 29 Feb 2024 20:50:20 +1100 (AEDT)
X-Original-To: linux-erofs@lists.ozlabs.org
Delivered-To: linux-erofs@lists.ozlabs.org
Authentication-Results: lists.ozlabs.org;
	dkim=pass (1024-bit key; unprotected) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.a=rsa-sha256 header.s=default header.b=dNYbHGx+;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=linux.alibaba.com (client-ip=115.124.30.98; helo=out30-98.freemail.mail.aliyun.com; envelope-from=hsiangkao@linux.alibaba.com; receiver=lists.ozlabs.org)
Received: from out30-98.freemail.mail.aliyun.com (out30-98.freemail.mail.aliyun.com [115.124.30.98])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4Tlmfv2PvCz3bsT
	for <linux-erofs@lists.ozlabs.org>; Thu, 29 Feb 2024 20:50:13 +1100 (AEDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=linux.alibaba.com; s=default;
	t=1709200210; h=Message-ID:Date:MIME-Version:Subject:From:To:Content-Type;
	bh=mOVi3uXUYS2H652Jc2xA5FPqqE3q4IpiicJTt3OC8KA=;
	b=dNYbHGx+ZizB84sUefov3RItbrdsj/nS13eP/x0nQnGPHLKk0hO4JfybYXlr62hDojXTftv3tYAmO8BtvpCkqG3/AImVskX2sWzIDTOHN9bPNoSKy4laZtbpIGvTuP77t2UOoYk99efxRQnn0326Bq6nIxQBTN5Jrn3QM9I3vUM=
X-Alimail-AntiSpam: AC=PASS;BC=-1|-1;BR=01201311R131e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=ay29a033018046060;MF=hsiangkao@linux.alibaba.com;NM=1;PH=DS;RN=2;SR=0;TI=SMTPD_---0W1Sa5Jg_1709200207;
Received: from 30.97.48.246(mailfrom:hsiangkao@linux.alibaba.com fp:SMTPD_---0W1Sa5Jg_1709200207)
          by smtp.aliyun-inc.com;
          Thu, 29 Feb 2024 17:50:09 +0800
Message-ID: <c65e9a20-66eb-4cc5-9b1e-00c64e7bb20c@linux.alibaba.com>
Date: Thu, 29 Feb 2024 17:50:07 +0800
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v4 1/5] erofs-utils: introduce multi-threading framework
From: Gao Xiang <hsiangkao@linux.alibaba.com>
To: Yifan Zhao <zhaoyifan@sjtu.edu.cn>
References: <20240228161652.1010997-1-zhaoyifan@sjtu.edu.cn>
 <20240228161652.1010997-2-zhaoyifan@sjtu.edu.cn>
 <e7077c8d-bce6-422a-9c6e-e8f05a0aa457@linux.alibaba.com>
In-Reply-To: <e7077c8d-bce6-422a-9c6e-e8f05a0aa457@linux.alibaba.com>
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
Cc: linux-erofs@lists.ozlabs.org
Errors-To: linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org
Sender: "Linux-erofs" <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>



On 2024/2/29 17:43, Gao Xiang wrote:
> Hi Yifan,
> 
> On 2024/2/29 00:16, Yifan Zhao wrote:
>> Add a workqueue implementation for multi-threading support inspired by
>> xfsprogs.
>>
>> Signed-off-by: Yifan Zhao <zhaoyifan@sjtu.edu.cn>
>> Suggested-by: Gao Xiang <hsiangkao@linux.alibaba.com>
>> ---

..

>> index 54b9c9c..7307f7b 100644
>> --- a/lib/Makefile.am
>> +++ b/lib/Makefile.am
>> @@ -53,3 +53,7 @@ liberofs_la_SOURCES += kite_deflate.c compressor_deflate.c
>>   if ENABLE_LIBDEFLATE
>>   liberofs_la_SOURCES += compressor_libdeflate.c
>>   endif
>> +if ENABLE_EROFS_MT
>> +liberofs_la_CFLAGS += -lpthread

By the way, this line should be
liberofs_la_LDFLAGS = -lpthread

Otherwise, it can fail on the clang side.

Thanks,
Gao Xiang
