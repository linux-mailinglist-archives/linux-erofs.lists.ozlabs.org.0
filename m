Return-Path: <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>
X-Original-To: lists+linux-erofs@lfdr.de
Delivered-To: lists+linux-erofs@lfdr.de
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2404:9400:2:0:216:3eff:fee1:b9f1])
	by mail.lfdr.de (Postfix) with ESMTPS id BA7C972B606
	for <lists+linux-erofs@lfdr.de>; Mon, 12 Jun 2023 05:21:14 +0200 (CEST)
Received: from boromir.ozlabs.org (localhost [IPv6:::1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4QfcQs5V7Gz30BZ
	for <lists+linux-erofs@lfdr.de>; Mon, 12 Jun 2023 13:21:09 +1000 (AEST)
X-Original-To: linux-erofs@lists.ozlabs.org
Delivered-To: linux-erofs@lists.ozlabs.org
Authentication-Results: lists.ozlabs.org; spf=none (no SPF record) smtp.mailfrom=huaweicloud.com (client-ip=14.137.139.23; helo=frasgout11.his.huawei.com; envelope-from=guoxuenan@huaweicloud.com; receiver=lists.ozlabs.org)
X-Greylist: delayed 972 seconds by postgrey-1.37 at boromir; Mon, 12 Jun 2023 13:21:06 AEST
Received: from frasgout11.his.huawei.com (unknown [14.137.139.23])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits))
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4QfcQp3Q6yz2ydP
	for <linux-erofs@lists.ozlabs.org>; Mon, 12 Jun 2023 13:21:03 +1000 (AEST)
Received: from mail02.huawei.com (unknown [172.18.147.228])
	by frasgout11.his.huawei.com (SkyGuard) with ESMTP id 4Qfbqp4sh3z9v7Hv
	for <linux-erofs@lists.ozlabs.org>; Mon, 12 Jun 2023 10:54:14 +0800 (CST)
Received: from [10.174.177.238] (unknown [10.174.177.238])
	by APP2 (Coremail) with SMTP id BqC_BwAnKlREi4ZkkrepCA--.4901S2;
	Mon, 12 Jun 2023 03:04:40 +0000 (GMT)
Message-ID: <7df930d7-07e3-e784-f262-33931d775b29@huaweicloud.com>
Date: Mon, 12 Jun 2023 11:04:34 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.5.0
Subject: Re: [PATCH 1/4] erofs-utils: lib: refactor erofs compressors init
To: Gao Xiang <hsiangkao@linux.alibaba.com>, Guo Xuenan
 <guoxuenan@huawei.com>, jefflexu@linux.alibaba.com,
 linux-erofs@lists.ozlabs.org
References: <20230609085041.14987-1-guoxuenan@huawei.com>
 <20230609085041.14987-2-guoxuenan@huawei.com>
 <2a8a3417-b72d-c8aa-ed3c-dad50d99be43@linux.alibaba.com>
Content-Language: en-US
From: Guo Xuenan <guoxuenan@huaweicloud.com>
In-Reply-To: <2a8a3417-b72d-c8aa-ed3c-dad50d99be43@linux.alibaba.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-CM-TRANSID: BqC_BwAnKlREi4ZkkrepCA--.4901S2
X-Coremail-Antispam: 1UD129KBjvJXoWxAw4kZFWrurWUArykAw13Jwb_yoW5Ary3pr
	1kGryrGry8Grn3Aw4fJr45KFy3Cr1xJ3WUXw1Iqa48t3Z8Ar92gF40qr9Ygr4UGrs3Ww4q
	yw4jvrsruw15tFJanT9S1TB71UUUUUUqnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDU0xBIdaVrnRJUUUyCb4IE77IF4wAFF20E14v26r1j6r4UM7CY07I20VC2zVCF04k2
	6cxKx2IYs7xG6rWj6s0DM7CIcVAFz4kK6r1j6r18M28lY4IEw2IIxxk0rwA2F7IY1VAKz4
	vEj48ve4kI8wA2z4x0Y4vE2Ix0cI8IcVAFwI0_Jr0_JF4l84ACjcxK6xIIjxv20xvEc7Cj
	xVAFwI0_Jr0_Gr1l84ACjcxK6I8E87Iv67AKxVWUJVW8JwA2z4x0Y4vEx4A2jsIEc7CjxV
	AFwI0_Jr0_Gr1le2I262IYc4CY6c8Ij28IcVAaY2xG8wAqx4xG64xvF2IEw4CE5I8CrVC2
	j2WlYx0E2Ix0cI8IcVAFwI0_Jr0_Jr4lYx0Ex4A2jsIE14v26r1j6r4UMcvjeVCFs4IE7x
	kEbVWUJVW8JwACjcxG0xvEwIxGrwCYjI0SjxkI62AI1cAE67vIY487MxAIw28IcxkI7VAK
	I48JMxC20s026xCaFVCjc4AY6r1j6r4UMI8I3I0E5I8CrVAFwI0_Jr0_Jr4lx2IqxVCjr7
	xvwVAFwI0_JrI_JrWlx4CE17CEb7AF67AKxVWUAVWUtwCIc40Y0x0EwIxGrwCI42IY6xII
	jxv20xvE14v26r1j6r1xMIIF0xvE2Ix0cI8IcVCY1x0267AKxVWUJVW8JwCI42IY6xAIw2
	0EY4v20xvaj40_WFyUJVCq3wCI42IY6I8E87Iv67AKxVWUJVW8JwCI42IY6I8E87Iv6xkF
	7I0E14v26r1j6r4UYxBIdaVFxhVjvjDU0xZFpf9x07UE-erUUUUU=
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

Hi Xiang,

On 2023/6/9 17:38, Gao Xiang wrote:
>
>
> On 2023/6/9 16:50, Guo Xuenan via Linux-erofs wrote:
>> refactor compressor code using constructor.
>>
>> Signed-off-by: Guo Xuenan <guoxuenan@huawei.com>
>> ---
>>   lib/compressor.c         | 49 ++++++++++++++++++++++++++++++++++++++++
>>   lib/compressor.h         | 15 ++++++++++++
>>   lib/compressor_liblzma.c |  5 ++++
>>   lib/compressor_lz4.c     |  5 ++++
>>   lib/compressor_lz4hc.c   |  5 ++++
>>   5 files changed, 79 insertions(+)
>>
>> diff --git a/lib/compressor.c b/lib/compressor.c
>> index 52eb761..0fa7105 100644
>> --- a/lib/compressor.c
>> +++ b/lib/compressor.c
>> @@ -22,6 +22,40 @@ static const struct erofs_compressor 
>> *compressors[] = {
>>   #endif
>>   };
>>   +/* compressing configuration specified by users */
>> +static struct erofs_supported_algothrim {
>> +    int algtype;
>> +    const char *name;
>> +} erofs_supported_algothrims[] = {
>> +    { Z_EROFS_COMPRESSION_LZ4, "lz4"},
>> +    { Z_EROFS_COMPRESSION_LZ4, "lz4hc"},
>> +    { Z_EROFS_COMPRESSION_LZMA, "lzma"},
>> +};
>> +
>> +static struct erofs_compressors_cfg erofs_ccfg;
>> +
>> +int erofs_compressor_num(void)
>> +{
>> +    return erofs_ccfg.erofs_ccfg_num;
>
>
>
>> +}
>> +
>> +void erofs_compressor_register(const char *name, const struct 
>> erofs_compressor *alg)
>> +{
>> +    int i;
>> +
>> +    for (i = 0; i < erofs_compressor_num(); i++) {
>> +        if (!strcmp(erofs_ccfg.compressors[i].name, name)) {
>> +            erofs_ccfg.compressors[i].handle.alg = alg;
>
> should we return error?  and also, why we need dynamicly
> register algorithms? liberofs expects to have given
> algorithms all the time...
>
>> +            return;
>> +        }
>> +    }
>> +
>> +    erofs_ccfg.compressors[i].name = name;
>> +    erofs_ccfg.compressors[i].handle.alg = alg;
>> +    erofs_ccfg.compressors[i].algorithmtype = 
>> erofs_supported_algothrims[i].algtype;
>> +    erofs_ccfg.erofs_ccfg_num = ++i;
>> +}
>> +
>>   int erofs_compress_destsize(const struct erofs_compress *c,
>>                   const void *src, unsigned int *srcsize,
>>                   void *dst, unsigned int dstsize, bool inblocks)
>> @@ -106,3 +140,18 @@ int erofs_compressor_exit(struct erofs_compress *c)
>>           return c->alg->exit(c);
>>       return 0;
>>   }
>> +
>> +void __attribute__((constructor(101))) __erofs_compressor_init(void)
>
>
> Honestly I don't like __attribute__((constructor)) and
> __attribute__((destructor)) which could causes unexpected behaviors and
> not good at compatiability.
>
OK,  will dorp them next version.
> Thanks,
> Gao Xiang

-- 
Best regards
Guo Xuenan

