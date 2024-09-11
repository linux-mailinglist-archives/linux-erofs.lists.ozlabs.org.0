Return-Path: <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>
X-Original-To: lists+linux-erofs@lfdr.de
Delivered-To: lists+linux-erofs@lfdr.de
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	by mail.lfdr.de (Postfix) with ESMTPS id D5C35974C86
	for <lists+linux-erofs@lfdr.de>; Wed, 11 Sep 2024 10:23:33 +0200 (CEST)
Received: from boromir.ozlabs.org (localhost [IPv6:::1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4X3YVp6j1sz2ym2
	for <lists+linux-erofs@lfdr.de>; Wed, 11 Sep 2024 18:23:30 +1000 (AEST)
X-Original-To: linux-erofs@lists.ozlabs.org
Delivered-To: linux-erofs@lists.ozlabs.org
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip=115.124.30.100
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1726043009;
	cv=none; b=hH8xGiQJWE0L1dN9C3Iw0XvKfxAfVjp5WD2e1kzeEPHrFtee6+K09WbbAlpq09Le174qIzwYxt11XwdVdvsGOzhyXx9s+LeiLuwaU1Uv9yCZt+h8I4/B8PxnM6NRum1RnBleROv4SOAGK2ji3Hf+8XJsv7L8LSvwAdzPpOtcb7rsNd9EenpBDRfRVk0+nBjSdAcxuIXtRW/Zhb8X/GK7cFhs7LRiG08Of9QT/7z1S8wtVwSoMHlmlA78Fw/ZiVk80J2TCfOC7kPjOx69MrnmcHjHGGG2bpAY8a8UAxo5+exCJp/B/AFiFG3mg4MG7tLVM5qCdzF30AfKb+bX/3A0pg==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1726043009; c=relaxed/relaxed;
	bh=wT5lUvLZ+B7ZvKaE/aPURx56dlowrgbrbWziGaIVztY=;
	h=Message-ID:Date:MIME-Version:Subject:To:References:From:
	 In-Reply-To:Content-Type; b=CaDHlypDMgneU1bwqgUxWSIuG4Vdepds5pIfv+VEF8lVknqEPb+wqD9r669RTCxD+qvhId2cZyUAwaPhoa9Nmpdg9OrJHurO8LZ4SUcAxNWuCXiW0G8+MeipZHc9wGIq/RC7S7IZ+kP/kLFfUtF31z/wqcDIO7OmbxhWgewovJZ/ksFauvowLUwyCSOFciITiRF5ULzLvGboojerSFnN3A2v+zxakg+j6HeYiI27bWBnyQ9Y11/CfGlBC6NSh7dLOMgIW6Qm+kMm6Xe8rNaaBG4T3qeUu2LWCC+BfMOfBUfxn4lpWzCzFWBbyKEoeDx+0kZlPQoNv4u0taCTWWH6YQ==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com; dkim=pass (1024-bit key; unprotected) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.a=rsa-sha256 header.s=default header.b=gV0a3gWJ; dkim-atps=neutral; spf=pass (client-ip=115.124.30.100; helo=out30-100.freemail.mail.aliyun.com; envelope-from=hongzhen@linux.alibaba.com; receiver=lists.ozlabs.org) smtp.mailfrom=linux.alibaba.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (1024-bit key; unprotected) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.a=rsa-sha256 header.s=default header.b=gV0a3gWJ;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=linux.alibaba.com (client-ip=115.124.30.100; helo=out30-100.freemail.mail.aliyun.com; envelope-from=hongzhen@linux.alibaba.com; receiver=lists.ozlabs.org)
Received: from out30-100.freemail.mail.aliyun.com (out30-100.freemail.mail.aliyun.com [115.124.30.100])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4X3YVm5r8Nz2xX4
	for <linux-erofs@lists.ozlabs.org>; Wed, 11 Sep 2024 18:23:28 +1000 (AEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=linux.alibaba.com; s=default;
	t=1726043005; h=Message-ID:Date:MIME-Version:Subject:To:From:Content-Type;
	bh=wT5lUvLZ+B7ZvKaE/aPURx56dlowrgbrbWziGaIVztY=;
	b=gV0a3gWJKLCTssn6aP9323jHD0tt1KXQ5S9/p9gBrmhS6pkJSEIR+Q42GLugyqe/gpfZ3i7m0B2rBrCdQOj/Wbi+vooT8cgABbZfP1AEwef+nGelE7Gp1DXtv/RP/1vPVwl6mXh6uC0Zsig8jJymaIPQndXwdPAnx5HuC5hLonA=
Received: from 30.221.132.109(mailfrom:hongzhen@linux.alibaba.com fp:SMTPD_---0WEn6zkH_1726043003)
          by smtp.aliyun-inc.com;
          Wed, 11 Sep 2024 16:23:24 +0800
Message-ID: <587a4ea9-45e3-404d-928d-80805260eb8b@linux.alibaba.com>
Date: Wed, 11 Sep 2024 16:23:21 +0800
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] erofs-utils: lib: fix the incorrect nblocks number under
 chunk mode
To: Gao Xiang <hsiangkao@linux.alibaba.com>, linux-erofs@lists.ozlabs.org
References: <20240911081020.2088531-1-hongzhen@linux.alibaba.com>
 <89b7325e-3344-42f8-bf0e-845640f4efda@linux.alibaba.com>
From: Hongzhen Luo <hongzhen@linux.alibaba.com>
In-Reply-To: <89b7325e-3344-42f8-bf0e-845640f4efda@linux.alibaba.com>
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


On 2024/9/11 16:20, Gao Xiang wrote:
>
>
> On 2024/9/11 16:10, Hongzhen Luo wrote:
>> Currently, in chunk mode, the number of blocks (nblocks) for the last
>> chunk written to the blocklist file is the size of the chunk, which may
>> not be consistent with the size of the original file in the last chunk.
>> This patch writes the actual number of blocks of the file in the last
>> chunk to the blocklist file.
>
> subject:
>
> erofs-utils: lib: fix incorrect nblocks in block list for chunked inodes
>
> Currently, the number of physical blocks (nblocks) for the last chunk
> written to the block list file is incorrectly recorded as the inode
> chunksize.
>
> This patch writes the actual number of physical blocks for the inode in
> the last chunk to the block list file.
>
>>
>> Signed-off-by: Hongzhen Luo <hongzhen@linux.alibaba.com>
>> ---
>>   lib/blobchunk.c | 9 +++++++--
>>   1 file changed, 7 insertions(+), 2 deletions(-)
>>
>> diff --git a/lib/blobchunk.c b/lib/blobchunk.c
>> index 33dadd5..40b731b 100644
>> --- a/lib/blobchunk.c
>> +++ b/lib/blobchunk.c
>> @@ -135,6 +135,7 @@ int erofs_blob_write_chunk_indexes(struct 
>> erofs_inode *inode,
>>   {
>>       struct erofs_inode_chunk_index idx = {0};
>>       erofs_blk_t extent_start = EROFS_NULL_ADDR;
>> +    erofs_blk_t front_blks = 0, tail_blks;
>
> Personally I think it can be improved as:
>
>     erofs_blk_t remaining_blks = BLK_ROUND_UP(inode->sbi, inode->i_size);
>
Sure, I will send the next patch soon.
>>       erofs_blk_t extent_end, chunkblks;
>>       erofs_off_t source_offset;
>>       unsigned int dst, src, unit;
>> @@ -165,6 +166,7 @@ int erofs_blob_write_chunk_indexes(struct 
>> erofs_inode *inode,
>>           if (extent_start == EROFS_NULL_ADDR ||
>>               idx.blkaddr != extent_end) {
>>               if (extent_start != EROFS_NULL_ADDR) {
>> +                front_blks += extent_end - extent_start;
>
>                 remaining_blks -= extent_end - extent_start;
>
>> tarerofs_blocklist_write(extent_start,
>>                           extent_end - extent_start,
>>                           source_offset);
>> @@ -187,9 +189,12 @@ int erofs_blob_write_chunk_indexes(struct 
>> erofs_inode *inode,
>>               memcpy(inode->chunkindexes + dst, &idx, sizeof(idx));
>>       }
>>       off = roundup(off, unit);
>
>     extent_end = min(extent_end, extent_start + remaining_blks);
>
> Thanks,
> Gao Xiang
>
Thanks,

Hongzhen

>> -    if (extent_start != EROFS_NULL_ADDR)
>> -        tarerofs_blocklist_write(extent_start, extent_end - 
>> extent_start,
>> +    if (extent_start != EROFS_NULL_ADDR) {
>> +        tail_blks = BLK_ROUND_UP(inode->sbi, inode->i_size)
>> +                - front_blks;
>> +        tarerofs_blocklist_write(extent_start, tail_blks,
>>                        source_offset);
>> +    }
>>       erofs_droid_blocklist_write_extent(inode, extent_start,
>>               extent_start == EROFS_NULL_ADDR ?
>>                       0 : extent_end - extent_start,
