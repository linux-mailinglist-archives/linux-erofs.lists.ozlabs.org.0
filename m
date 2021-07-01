Return-Path: <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>
X-Original-To: lists+linux-erofs@lfdr.de
Delivered-To: lists+linux-erofs@lfdr.de
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	by mail.lfdr.de (Postfix) with ESMTPS id 8F53C3B8C6D
	for <lists+linux-erofs@lfdr.de>; Thu,  1 Jul 2021 04:50:25 +0200 (CEST)
Received: from boromir.ozlabs.org (localhost [IPv6:::1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4GFjPW3vPJz2ymN
	for <lists+linux-erofs@lfdr.de>; Thu,  1 Jul 2021 12:50:23 +1000 (AEST)
X-Original-To: linux-erofs@lists.ozlabs.org
Delivered-To: linux-erofs@lists.ozlabs.org
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized)
 smtp.mailfrom=huawei.com (client-ip=45.249.212.187; helo=szxga01-in.huawei.com;
 envelope-from=cy.fan@huawei.com; receiver=<UNKNOWN>)
Received: from szxga01-in.huawei.com (szxga01-in.huawei.com [45.249.212.187])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256
 bits)) (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 4GFjPP5fsnz2yMV
 for <linux-erofs@lists.ozlabs.org>; Thu,  1 Jul 2021 12:50:17 +1000 (AEST)
Received: from dggemv703-chm.china.huawei.com (unknown [172.30.72.56])
 by szxga01-in.huawei.com (SkyGuard) with ESMTP id 4GFhv848PXzXn5p;
 Thu,  1 Jul 2021 10:27:32 +0800 (CST)
Received: from dggpemm500021.china.huawei.com (7.185.36.109) by
 dggemv703-chm.china.huawei.com (10.3.19.46) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2176.2; Thu, 1 Jul 2021 10:32:53 +0800
Received: from [10.174.177.223] (10.174.177.223) by
 dggpemm500021.china.huawei.com (7.185.36.109) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256) id
 15.1.2176.2; Thu, 1 Jul 2021 10:32:52 +0800
Subject: Re: [PATCH] lz4: fixs use-after-free Read in
 LZ4_decompress_safe_partial
To: Gao Xiang <hsiangkao@linux.alibaba.com>
References: <20210630032358.949122-1-cy.fan@huawei.com>
 <YNxYqXhw5g7Nl3JP@B-P7TQMD6M-0146.local>
From: Chengyang Fan <cy.fan@huawei.com>
Message-ID: <f9d65118-13e1-8b08-c34c-690dca7b6bab@huawei.com>
Date: Thu, 1 Jul 2021 10:32:51 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:78.0) Gecko/20100101
 Thunderbird/78.6.1
MIME-Version: 1.0
In-Reply-To: <YNxYqXhw5g7Nl3JP@B-P7TQMD6M-0146.local>
Content-Type: text/plain; charset="utf-8"; format=flowed
Content-Transfer-Encoding: 7bit
Content-Language: en-US
X-Originating-IP: [10.174.177.223]
X-ClientProxiedBy: dggeme715-chm.china.huawei.com (10.1.199.111) To
 dggpemm500021.china.huawei.com (7.185.36.109)
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
Cc: sfr@canb.auug.org.au, linux-kernel@vger.kernel.org, terrelln@fb.com,
 Yann Collet <yann.collet.73@gmail.com>, akpm@linux-foundation.org,
 linux-erofs@lists.ozlabs.org, thisisrast7@gmail.com
Errors-To: linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org
Sender: "Linux-erofs"
 <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>


On 2021/6/30 19:42, Gao Xiang wrote:
> (also +cc Yann as well as Nick..)
>
> Hi Chengyang,
>
> If I understand correctly, is this a manually produced fuzzed
> EROFS compressed data? If it's just a normal image, could you
> also share the original image?
Yeah, this is the generated fuzzed data, not the normal image.
> On Wed, Jun 30, 2021 at 11:23:58AM +0800, Chengyang Fan wrote:
>> ==================================================================
>> BUG: KASAN: use-after-free in get_unaligned_le16 include/linux/unaligned/access_ok.h:10 [inline]
>> BUG: KASAN: use-after-free in LZ4_readLE16 lib/lz4/lz4defs.h:132 [inline]
>> BUG: KASAN: use-after-free in LZ4_decompress_generic lib/lz4/lz4_decompress.c:281 [inline]
>> BUG: KASAN: use-after-free in LZ4_decompress_safe_partial+0xf50/0x1480 lib/lz4/lz4_decompress.c:465
>> Read of size 2 at addr ffff888017851000 by task kworker/u12:0/2056
>>
>> CPU: 0 PID: 2056 Comm: kworker/u12:0 Not tainted 5.10.40 #2
>> Hardware name: QEMU Standard PC (i440FX + PIIX, 1996), BIOS Ubuntu-1.8.2-1ubuntu1 04/01/2014
>> Workqueue: erofs_unzipd z_erofs_decompressqueue_work
>> Call Trace:
>>   __dump_stack lib/dump_stack.c:77 [inline]
>>   dump_stack+0x137/0x1be lib/dump_stack.c:118
>>   print_address_description+0x6c/0x640 mm/kasan/report.c:385
>>   __kasan_report mm/kasan/report.c:545 [inline]
>>   kasan_report+0x13d/0x1e0 mm/kasan/report.c:562
>>   get_unaligned_le16 include/linux/unaligned/access_ok.h:10 [inline]
>>   LZ4_readLE16 lib/lz4/lz4defs.h:132 [inline]
>>   LZ4_decompress_generic lib/lz4/lz4_decompress.c:281 [inline]
>>   LZ4_decompress_safe_partial+0xf50/0x1480 lib/lz4/lz4_decompress.c:465
>>   z_erofs_lz4_decompress+0x839/0xc90 fs/erofs/decompressor.c:162
>>   z_erofs_decompress_generic fs/erofs/decompressor.c:291 [inline]
>>   z_erofs_decompress+0x57e/0xe10 fs/erofs/decompressor.c:344
>>   z_erofs_decompress_pcluster+0x13d1/0x2310 fs/erofs/zdata.c:880
>>   z_erofs_decompress_queue fs/erofs/zdata.c:958 [inline]
>>   z_erofs_decompressqueue_work+0xde/0x140 fs/erofs/zdata.c:969
>>   process_one_work+0x780/0xfc0 kernel/workqueue.c:2269
>>   worker_thread+0xaa4/0x1460 kernel/workqueue.c:2415
>>   kthread+0x39a/0x3c0 kernel/kthread.c:292
>>   ret_from_fork+0x1f/0x30 arch/x86/entry/entry_64.S:296
>>
>> The buggy address belongs to the page:
>> page:00000000a79b76f1 refcount:0 mapcount:0 mapping:0000000000000000 index:0x0 pfn:0x17851
>> flags: 0xfff00000000000()
>> raw: 00fff00000000000 ffffea000081b9c8 ffffea00006ac6c8 0000000000000000
>> raw: 0000000000000000 0000000000000000 00000000ffffffff 0000000000000000
>> page dumped because: kasan: bad access detected
>>
>> Memory state around the buggy address:
>>   ffff888017850f00: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
>>   ffff888017850f80: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
>>> ffff888017851000: ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff
>>                     ^
>>   ffff888017851080: ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff
>>   ffff888017851100: ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff
>> ==================================================================
>> erofs: (device loop0): z_erofs_lz4_decompress: failed to decompress -4099 in[4096, 0] out[9000]
>>
>> Off-by-one error causes the above issue. In LZ4_decompress_generic(),
>> `iend = src + srcSize`. It means the valid address range should be
>> [src, iend - 1]. Therefore, when checking whether the reading is
>> out-of-bounds, it should be  `>= iend` rather than `> iend`.
>>
>> Reported-by: Hulk Robot <hulkci@huawei.com>
>> Signed-off-by: Chengyang Fan <cy.fan@huawei.com>
>> ---
>>   lib/lz4/lz4_decompress.c | 2 +-
>>   1 file changed, 1 insertion(+), 1 deletion(-)
>>
>> diff --git a/lib/lz4/lz4_decompress.c b/lib/lz4/lz4_decompress.c
>> index 926f4823d5ea..ec51837cd31f 100644
>> --- a/lib/lz4/lz4_decompress.c
>> +++ b/lib/lz4/lz4_decompress.c
>> @@ -234,7 +234,7 @@ static FORCE_INLINE int LZ4_decompress_generic(
>>   					length = oend - op;
>>   				}
>>   				if ((endOnInput)
>> -					&& (ip + length > iend)) {
>> +					&& (ip + length >= iend)) {
> I'm not sure it should be fixed as this.
>
> The current lz4 decompression code was from lz4 1.8.3, and I saw
> several following up fixes for incomplete input partial decoding
> in recent LZ4 upstream, you could check them out together. However,
> EROFS should never pass incomplete lz4 compressed data to the LZ4
> side unless it's somewhat a corrupted image on purpose.
> https://github.com/lz4/lz4/blame/dev/lib/lz4.c
>
> Thanks,
> Gao Xiang

This is the fault injection, not an error caused by normal EROFS.

Thanks for you advice, I will recheck the bugfixes of LZ4 upstream.


Thanks,

Chengyang Fan

>>   					/*
>>   					 * Error :
>>   					 * read attempt beyond
>> -- 
>> 2.18.0.huawei.25
> .
