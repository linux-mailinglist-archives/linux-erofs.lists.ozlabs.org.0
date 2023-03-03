Return-Path: <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>
X-Original-To: lists+linux-erofs@lfdr.de
Delivered-To: lists+linux-erofs@lfdr.de
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	by mail.lfdr.de (Postfix) with ESMTPS id 76F646A90F7
	for <lists+linux-erofs@lfdr.de>; Fri,  3 Mar 2023 07:25:36 +0100 (CET)
Received: from boromir.ozlabs.org (localhost [IPv6:::1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4PSdJF6QXqz3cdJ
	for <lists+linux-erofs@lfdr.de>; Fri,  3 Mar 2023 17:25:33 +1100 (AEDT)
X-Original-To: linux-erofs@lists.ozlabs.org
Delivered-To: linux-erofs@lists.ozlabs.org
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=linux.alibaba.com (client-ip=115.124.30.97; helo=out30-97.freemail.mail.aliyun.com; envelope-from=hsiangkao@linux.alibaba.com; receiver=<UNKNOWN>)
Received: from out30-97.freemail.mail.aliyun.com (out30-97.freemail.mail.aliyun.com [115.124.30.97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4PSdJ71D54z3cLf
	for <linux-erofs@lists.ozlabs.org>; Fri,  3 Mar 2023 17:25:25 +1100 (AEDT)
X-Alimail-AntiSpam: AC=PASS;BC=-1|-1;BR=01201311R121e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=ay29a033018045192;MF=hsiangkao@linux.alibaba.com;NM=1;PH=DS;RN=7;SR=0;TI=SMTPD_---0Vd-4.6P_1677824719;
Received: from 30.97.48.241(mailfrom:hsiangkao@linux.alibaba.com fp:SMTPD_---0Vd-4.6P_1677824719)
          by smtp.aliyun-inc.com;
          Fri, 03 Mar 2023 14:25:20 +0800
Message-ID: <65437f0e-dea9-115e-decd-b34cd8c79f81@linux.alibaba.com>
Date: Fri, 3 Mar 2023 14:25:19 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:102.0)
 Gecko/20100101 Thunderbird/102.6.1
Subject: Re: [PATCH] erofs: mark z_erofs_lzma_init/erofs_pcpubuf_init w/
 __init
To: Yue Hu <zbestahu@gmail.com>, Yangtao Li <frank.li@vivo.com>
References: <20230303031418.64553-1-frank.li@vivo.com>
 <20230303140405.000035a6.zbestahu@gmail.com>
From: Gao Xiang <hsiangkao@linux.alibaba.com>
In-Reply-To: <20230303140405.000035a6.zbestahu@gmail.com>
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



On 2023/3/3 14:04, Yue Hu wrote:
> On Fri,  3 Mar 2023 11:14:18 +0800
> Yangtao Li <frank.li@vivo.com> wrote:
> 
>> They are used during the erofs module init phase. Let's mark it as
>> __init like any other function.
>>
>> Signed-off-by: Yangtao Li <frank.li@vivo.com>
>> ---
>>   fs/erofs/decompressor_lzma.c | 2 +-
>>   fs/erofs/pcpubuf.c           | 2 +-
>>   2 files changed, 2 insertions(+), 2 deletions(-)
>>
>> diff --git a/fs/erofs/decompressor_lzma.c b/fs/erofs/decompressor_lzma.c
>> index 091fd5adf818..307b37f0b9f5 100644
>> --- a/fs/erofs/decompressor_lzma.c
>> +++ b/fs/erofs/decompressor_lzma.c
>> @@ -47,7 +47,7 @@ void z_erofs_lzma_exit(void)
>>   	}
>>   }
>>   
>> -int z_erofs_lzma_init(void)
>> +int __init z_erofs_lzma_init(void)
>>   {
>>   	unsigned int i;
>>   
>> diff --git a/fs/erofs/pcpubuf.c b/fs/erofs/pcpubuf.c
>> index a2efd833d1b6..c7a4b1d77069 100644
>> --- a/fs/erofs/pcpubuf.c
>> +++ b/fs/erofs/pcpubuf.c
>> @@ -114,7 +114,7 @@ int erofs_pcpubuf_growsize(unsigned int nrpages)
>>   	return ret;
>>   }
>>   
>> -void erofs_pcpubuf_init(void)
>> +void __init erofs_pcpubuf_init(void)
>>   {
>>   	int cpu;
>>   
> 
> Update them in internal.h as well?

Yeah, please help revise, thanks!

Thanks,
Gao Xiang

