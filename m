Return-Path: <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>
X-Original-To: lists+linux-erofs@lfdr.de
Delivered-To: lists+linux-erofs@lfdr.de
Received: from lists.ozlabs.org (lists.ozlabs.org [203.11.71.2])
	by mail.lfdr.de (Postfix) with ESMTPS id C82775DB5F
	for <lists+linux-erofs@lfdr.de>; Wed,  3 Jul 2019 04:10:25 +0200 (CEST)
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2401:3900:2:1::3])
	by lists.ozlabs.org (Postfix) with ESMTP id 45dl1p0nlTzDqV4
	for <lists+linux-erofs@lfdr.de>; Wed,  3 Jul 2019 12:10:22 +1000 (AEST)
X-Original-To: linux-erofs@lists.ozlabs.org
Delivered-To: linux-erofs@lists.ozlabs.org
Authentication-Results: lists.ozlabs.org;
 spf=pass (mailfrom) smtp.mailfrom=huawei.com
 (client-ip=45.249.212.32; helo=huawei.com; envelope-from=gaoxiang25@huawei.com;
 receiver=<UNKNOWN>)
Authentication-Results: lists.ozlabs.org;
 dmarc=none (p=none dis=none) header.from=huawei.com
Received: from huawei.com (szxga06-in.huawei.com [45.249.212.32])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 45dl1j0KX4zDqSB
 for <linux-erofs@lists.ozlabs.org>; Wed,  3 Jul 2019 12:10:16 +1000 (AEST)
Received: from DGGEMS409-HUB.china.huawei.com (unknown [172.30.72.59])
 by Forcepoint Email with ESMTP id 33F16D5716B7DF6B3E17;
 Wed,  3 Jul 2019 10:10:12 +0800 (CST)
Received: from [10.151.23.176] (10.151.23.176) by smtp.huawei.com
 (10.3.19.209) with Microsoft SMTP Server (TLS) id 14.3.439.0; Wed, 3 Jul 2019
 10:10:04 +0800
Subject: Re: [PATCH] staging: erofs: fix LZ4 limited bounced page mis-reuse
To: Chao Yu <yuchao0@huawei.com>, Gao Xiang <hsiangkao@aol.com>, "Greg
 Kroah-Hartman" <gregkh@linuxfoundation.org>
References: <20190630185846.16624-1-hsiangkao@aol.com>
 <dbd9e23d-3e76-8281-81f3-48680b4d0b9d@huawei.com>
From: Gao Xiang <gaoxiang25@huawei.com>
Message-ID: <e57f757f-2a61-3c5d-bf06-264cd1d00fef@huawei.com>
Date: Wed, 3 Jul 2019 10:09:22 +0800
User-Agent: Mozilla/5.0 (Windows NT 6.1; WOW64; rv:52.0) Gecko/20100101
 Thunderbird/52.3.0
MIME-Version: 1.0
In-Reply-To: <dbd9e23d-3e76-8281-81f3-48680b4d0b9d@huawei.com>
Content-Type: text/plain; charset="windows-1252"
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.151.23.176]
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
Cc: devel@driverdev.osuosl.org, linux-erofs@lists.ozlabs.org,
 LKML <linux-kernel@vger.kernel.org>, Du Wei <weidu.du@huawei.com>,
 Miao Xie <miaoxie@huawei.com>
Errors-To: linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org
Sender: "Linux-erofs"
 <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>



On 2019/7/3 9:50, Chao Yu wrote:
> On 2019/7/1 2:58, Gao Xiang wrote:
>> From: Gao Xiang <gaoxiang25@huawei.com>
>>
>> Like all lz77-based algrithms, lz4 has a dynamically populated
>> ("sliding window") dictionary and the maximum lookback distance
>> is 65535. Therefore the number of bounced pages could be limited
>> by erofs based on this property.
>>
>> However, just now we observed some lz4 sequences in the extreme
>> case cannot be decompressed correctly after this feature is enabled,
>> the root causes after analysis are clear as follows:
>> 1) max bounced pages should be 17 rather than 16 pages;
>> 2) considering the following case, the broken implementation
>>    could reuse unsafely in advance (in other words, reuse it
>>    less than a safe distance),
>>    0 1 2 ... 16 17 18 ... 33 34
>>    b             p  b         b
>>    note that the bounce page that we are concerned was allocated
>>    at 0, and it reused at 18 since page 17 exists, but it mis-reused
>>    at 34 in advance again, which causes decompress failure.
>>
>> This patch resolves the issue by introducing a bitmap to mark
>> whether the page in the same position of last round is a bounced
>> page or not, and a micro stack data structure to store all
>> available bounced pages.
>>
>> Fixes: 7fc45dbc938a ("staging: erofs: introduce generic decompression backend")
>> Signed-off-by: Gao Xiang <gaoxiang25@huawei.com>
>> ---
>>  drivers/staging/erofs/decompressor.c | 50 ++++++++++++++++------------
>>  1 file changed, 28 insertions(+), 22 deletions(-)
>>
>> diff --git a/drivers/staging/erofs/decompressor.c b/drivers/staging/erofs/decompressor.c
>> index 80f1f39719ba..1fb0abb98dff 100644
>> --- a/drivers/staging/erofs/decompressor.c
>> +++ b/drivers/staging/erofs/decompressor.c
>> @@ -13,7 +13,7 @@
>>  #define LZ4_DISTANCE_MAX 65535	/* set to maximum value by default */
>>  #endif
>>  
>> -#define LZ4_MAX_DISTANCE_PAGES	DIV_ROUND_UP(LZ4_DISTANCE_MAX, PAGE_SIZE)
>> +#define LZ4_MAX_DISTANCE_PAGES	(DIV_ROUND_UP(LZ4_DISTANCE_MAX, PAGE_SIZE) + 1)
>>  #ifndef LZ4_DECOMPRESS_INPLACE_MARGIN
>>  #define LZ4_DECOMPRESS_INPLACE_MARGIN(srcsize)  (((srcsize) >> 8) + 32)
>>  #endif
>> @@ -35,19 +35,28 @@ static int lz4_prepare_destpages(struct z_erofs_decompress_req *rq,
>>  	const unsigned int nr =
>>  		PAGE_ALIGN(rq->pageofs_out + rq->outputsize) >> PAGE_SHIFT;
>>  	struct page *availables[LZ4_MAX_DISTANCE_PAGES] = { NULL };
>> -	unsigned long unused[DIV_ROUND_UP(LZ4_MAX_DISTANCE_PAGES,
>> -					  BITS_PER_LONG)] = { 0 };
>> +	unsigned long bounced[DIV_ROUND_UP(LZ4_MAX_DISTANCE_PAGES,
>> +					   BITS_PER_LONG)] = { 0 };
>>  	void *kaddr = NULL;
>> -	unsigned int i, j, k;
>> +	unsigned int i, j, top;
>>  
>> -	for (i = 0; i < nr; ++i) {
>> +	top = 0;
>> +	for (i = j = 0; i < nr; ++i, ++j) {
>>  		struct page *const page = rq->out[i];
>> +		struct page *victim;
>>  
>> -		j = i & (LZ4_MAX_DISTANCE_PAGES - 1);
>> -		if (availables[j])
>> -			__set_bit(j, unused);
>> +		if (j >= LZ4_MAX_DISTANCE_PAGES)
>> +			j = 0;
>> +
>> +		/* 'valid' bounced can only be tested after a complete round */
>> +		if (test_bit(j, bounced)) {
>> +			DBG_BUGON(i < LZ4_MAX_DISTANCE_PAGES);
>> +			DBG_BUGON(top >= LZ4_MAX_DISTANCE_PAGES);
>> +			availables[top++] = rq->out[i - LZ4_MAX_DISTANCE_PAGES];
> 
> Maybe we can change 'i - LZ4_MAX_DISTANCE_PAGES' to 'j' directly for better
> readability.

OK, I think they are equivalent as well, will change for readability, retest and resend.
Thanks for your suggestion :)

Thanks,
Gao Xiang

> 
> Otherwise, it looks good to me.
> 
> Reviewed-by: Chao Yu <yuchao0@huawei.com>
> 
> Thanks,
> 
>> +		}
>>  
>>  		if (page) {
>> +			__clear_bit(j, bounced);
>>  			if (kaddr) {
>>  				if (kaddr + PAGE_SIZE == page_address(page))
>>  					kaddr += PAGE_SIZE;
>> @@ -59,27 +68,24 @@ static int lz4_prepare_destpages(struct z_erofs_decompress_req *rq,
>>  			continue;
>>  		}
>>  		kaddr = NULL;
>> +		__set_bit(j, bounced);
>>  
>> -		k = find_first_bit(unused, LZ4_MAX_DISTANCE_PAGES);
>> -		if (k < LZ4_MAX_DISTANCE_PAGES) {
>> -			j = k;
>> -			get_page(availables[j]);
>> +		if (top) {
>> +			victim = availables[--top];
>> +			get_page(victim);
>>  		} else {
>> -			DBG_BUGON(availables[j]);
>> -
>>  			if (!list_empty(pagepool)) {
>> -				availables[j] = lru_to_page(pagepool);
>> -				list_del(&availables[j]->lru);
>> -				DBG_BUGON(page_ref_count(availables[j]) != 1);
>> +				victim = lru_to_page(pagepool);
>> +				list_del(&victim->lru);
>> +				DBG_BUGON(page_ref_count(victim) != 1);
>>  			} else {
>> -				availables[j] = alloc_pages(GFP_KERNEL, 0);
>> -				if (!availables[j])
>> +				victim = alloc_pages(GFP_KERNEL, 0);
>> +				if (!victim)
>>  					return -ENOMEM;
>>  			}
>> -			availables[j]->mapping = Z_EROFS_MAPPING_STAGING;
>> +			victim->mapping = Z_EROFS_MAPPING_STAGING;
>>  		}
>> -		rq->out[i] = availables[j];
>> -		__clear_bit(j, unused);
>> +		rq->out[i] = victim;
>>  	}
>>  	return kaddr ? 1 : 0;
>>  }
>>
