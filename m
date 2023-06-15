Return-Path: <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>
X-Original-To: lists+linux-erofs@lfdr.de
Delivered-To: lists+linux-erofs@lfdr.de
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2404:9400:2:0:216:3eff:fee1:b9f1])
	by mail.lfdr.de (Postfix) with ESMTPS id 800707316DA
	for <lists+linux-erofs@lfdr.de>; Thu, 15 Jun 2023 13:37:47 +0200 (CEST)
Received: from boromir.ozlabs.org (localhost [IPv6:::1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4QhgJS5xSRz3bTb
	for <lists+linux-erofs@lfdr.de>; Thu, 15 Jun 2023 21:37:44 +1000 (AEST)
X-Original-To: linux-erofs@lists.ozlabs.org
Delivered-To: linux-erofs@lists.ozlabs.org
Authentication-Results: lists.ozlabs.org; spf=none (no SPF record) smtp.mailfrom=huaweicloud.com (client-ip=14.137.139.23; helo=frasgout11.his.huawei.com; envelope-from=guoxuenan@huaweicloud.com; receiver=lists.ozlabs.org)
Received: from frasgout11.his.huawei.com (unknown [14.137.139.23])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4QhgJN4qJwz30Ns
	for <linux-erofs@lists.ozlabs.org>; Thu, 15 Jun 2023 21:37:38 +1000 (AEST)
Received: from mail02.huawei.com (unknown [172.18.147.229])
	by frasgout11.his.huawei.com (SkyGuard) with ESMTP id 4Qhg416vBgz9v7g4
	for <linux-erofs@lists.ozlabs.org>; Thu, 15 Jun 2023 19:26:57 +0800 (CST)
Received: from [10.174.177.238] (unknown [10.174.177.238])
	by APP1 (Coremail) with SMTP id 76C_BwAnmz7z94pkndnlCA--.8667S2;
	Thu, 15 Jun 2023 11:37:27 +0000 (GMT)
Message-ID: <7a120496-8e00-1ae1-3268-e5b8d2643919@huaweicloud.com>
Date: Thu, 15 Jun 2023 19:37:21 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.5.0
Subject: Re: [PATCH v2 1/4] erofs-utils: lib: refactor erofs compressors init
To: Gao Xiang <hsiangkao@linux.alibaba.com>, jefflexu@linux.alibaba.com,
 linux-erofs@lists.ozlabs.org
References: <20230615101727.946446-1-guoxuenan@huawei.com>
 <20230615101727.946446-2-guoxuenan@huawei.com>
 <e03b6dd2-91dd-b457-a95b-b7bb22905e46@linux.alibaba.com>
Content-Language: en-US
From: Guo Xuenan <guoxuenan@huaweicloud.com>
In-Reply-To: <e03b6dd2-91dd-b457-a95b-b7bb22905e46@linux.alibaba.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-CM-TRANSID: 76C_BwAnmz7z94pkndnlCA--.8667S2
X-Coremail-Antispam: 1UD129KBjvJXoWxAw4DJFyUWFy7Gw1kCF17KFg_yoWrZw1kpr
	1kGrWrGry8Wrn3Aw4fJr45KFy3tr1xJ3WUXw1Iqas3J3Z8Ar92gF10qr9Y9rWUGrs3Xrs2
	yw4jvrsruw13trJanT9S1TB71UUUUUUqnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDU0xBIdaVrnRJUUUyEb4IE77IF4wAFF20E14v26r1j6r4UM7CY07I20VC2zVCF04k2
	6cxKx2IYs7xG6rWj6s0DM7CIcVAFz4kK6r1j6r18M28lY4IEw2IIxxk0rwA2F7IY1VAKz4
	vEj48ve4kI8wA2z4x0Y4vE2Ix0cI8IcVAFwI0_Jr0_JF4l84ACjcxK6xIIjxv20xvEc7Cj
	xVAFwI0_Jr0_Gr1l84ACjcxK6I8E87Iv67AKxVWUJVW8JwA2z4x0Y4vEx4A2jsIEc7CjxV
	AFwI0_Gr0_Gr1UM2AIxVAIcxkEcVAq07x20xvEncxIr21l5I8CrVACY4xI64kE6c02F40E
	x7xfMcIj6xIIjxv20xvE14v26r1j6r18McIj6I8E87Iv67AKxVWUJVW8JwAm72CE4IkC6x
	0Yz7v_Jr0_Gr1lF7xvr2IY64vIr41lc7I2V7IY0VAS07AlzVAYIcxG8wCF04k20xvY0x0E
	wIxGrwCFx2IqxVCFs4IE7xkEbVWUJVW8JwC20s026c02F40E14v26r1j6r18MI8I3I0E74
	80Y4vE14v26r106r1rMI8E67AF67kF1VAFwI0_JF0_Jw1lIxkGc2Ij64vIr41lIxAIcVC0
	I7IYx2IY67AKxVWUJVWUCwCI42IY6xIIjxv20xvEc7CjxVAFwI0_Jr0_Gr1lIxAIcVCF04
	k26cxKx2IYs7xG6rW3Jr0E3s1lIxAIcVC2z280aVAFwI0_Jr0_Gr1lIxAIcVC2z280aVCY
	1x0267AKxVW8JVW8JrUvcSsGvfC2KfnxnUUI43ZEXa7IU1CPfJUUUUU==
X-CM-SenderInfo: xjxr53hhqd0q5kxd4v5lfo033gof0z/
X-CFilter-Loop: Reflected
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
Cc: jack.qiu@huawei.com
Errors-To: linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org
Sender: "Linux-erofs" <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>


On 2023/6/15 18:44, Gao Xiang wrote:
>
>
> On 2023/6/15 18:17, Guo Xuenan via Linux-erofs wrote:
>> using struct erofs_compressors_cfg for erofs compressor
>> global configuration.
>>
>> Signed-off-by: Guo Xuenan <guoxuenan@huawei.com>
>> ---
>>   lib/compressor.c | 68 ++++++++++++++++++++++++++++++++++++++++++++++++
>>   lib/compressor.h | 14 ++++++++++
>>   2 files changed, 82 insertions(+)
>>
>> diff --git a/lib/compressor.c b/lib/compressor.c
>> index 52eb761..88a2fb0 100644
>> --- a/lib/compressor.c
>> +++ b/lib/compressor.c
>> @@ -22,6 +22,74 @@ static const struct erofs_compressor 
>> *compressors[] = {
>>   #endif
>>   };
>>   +/* for compressors type configuration */
>
> This comment might be unnecessary.
>
OKay
>> +static struct erofs_supported_algothrim {
>
>                 ^ algorithm
>
>
>
>
>> +    int algtype;
>> +    const char *name;
>> +} erofs_supported_algothrims[] = {
>> +    { Z_EROFS_COMPRESSION_LZ4, "lz4"},
>> +    { Z_EROFS_COMPRESSION_LZ4, "lz4hc"},
>> +    { Z_EROFS_COMPRESSION_LZMA, "lzma"},
>> +};
>> +
>> +/* global compressors configuration */
>
>
> Let's avoid this comment as well.
>
>
>> +static struct erofs_compressors_cfg erofs_ccfg;
>> +
>> +static void erofs_init_compressor(struct compressor *compressor,
>> +    const struct erofs_compressor *alg)
>> +{
>> +
>> +    compressor->handle.alg = alg;
>> +
>> +    /* should be written in "minimum compression ratio * 100" */
>> +    compressor->handle.compress_threshold = 100;
>> +
>> +    /* optimize for 4k size page */
>> +    compressor->handle.destsize_alignsize = erofs_blksiz();
>> +    compressor->handle.destsize_redzone_begin = erofs_blksiz() - 16;
>> +    compressor->handle.destsize_redzone_end = 
>> EROFS_CONFIG_COMPR_DEF_BOUNDARY;
>> +
>> +    if (alg && alg->init)
>> +        alg->init(&compressor->handle);
>> +}
>> +
>> +static void erofs_compressor_register(const char *name, const struct 
>> erofs_compressor *alg)
>> +{
>> +    int i;
>> +
>> +    for (i = 0; i < erofs_ccfg.erofs_ccfg_num; i++) {
>> +        if (!strcmp(erofs_ccfg.compressors[i].name, name)) {
>> + erofs_init_compressor(&erofs_ccfg.compressors[i], alg);
>> +            return;
>> +        }
>> +    }
>> +
>> +    erofs_ccfg.compressors[i].name = name;
>> +    erofs_ccfg.compressors[i].algorithmtype = 
>> erofs_supported_algothrims[i].algtype;
>> +    erofs_init_compressor(&erofs_ccfg.compressors[i], alg);
>> +    erofs_ccfg.erofs_ccfg_num = ++i;
>> +}
>> +
>> +void erofs_register_compressors(void)
>> +{
>> +    int i;
>> +
>> +    erofs_ccfg.erofs_ccfg_num = 0;
>> +    for (i = 0; i < ARRAY_SIZE(erofs_supported_algothrims); i++) {
>> + erofs_compressor_register(erofs_supported_algothrims[i].name, NULL);
>> +    }
>> +
>> +#if LZ4_ENABLED
>> +    erofs_compressor_register("lz4", &erofs_compressor_lz4);
>> +#if LZ4HC_ENABLED
>> +    erofs_compressor_register("lz4hc", &erofs_compressor_lz4hc);
>> +#endif
>> +#endif
>> +#if HAVE_LIBLZMA
>> +    erofs_compressor_register("lzma", &erofs_compressor_lzma);
>> +#endif
>> +}
>> +
>>   int erofs_compress_destsize(const struct erofs_compress *c,
>>                   const void *src, unsigned int *srcsize,
>>                   void *dst, unsigned int dstsize, bool inblocks)
>> diff --git a/lib/compressor.h b/lib/compressor.h
>> index cf063f1..1e760b6 100644
>> --- a/lib/compressor.h
>> +++ b/lib/compressor.h
>> @@ -8,6 +8,7 @@
>>   #define __EROFS_LIB_COMPRESSOR_H
>>     #include "erofs/defs.h"
>> +#include "erofs/config.h"
>>     struct erofs_compress;
>>   @@ -40,6 +41,18 @@ struct erofs_compress {
>>       void *private_data;
>>   };
>>   +struct compressor {
>> +    const char *name;
>> +    struct erofs_compress handle;
>> +    unsigned int algorithmtype;
>> +    bool enable;
>
> could we just use a struct erofs_supported_algothrim * to replace
> name and algorithmtype?
>
Yes, of course, your suggestion is better!
> Also, please use `struct erofs_compressor` here.
struct erofs_compressor has been used  lib/compressor.h:15
> Thanks,
> Gao Xiang
>
-- 
Best regards
Guo Xuenan

