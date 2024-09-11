Return-Path: <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>
X-Original-To: lists+linux-erofs@lfdr.de
Delivered-To: lists+linux-erofs@lfdr.de
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	by mail.lfdr.de (Postfix) with ESMTPS id D1CFE974CFF
	for <lists+linux-erofs@lfdr.de>; Wed, 11 Sep 2024 10:46:20 +0200 (CEST)
Received: from boromir.ozlabs.org (localhost [IPv6:::1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4X3Z163T77z2yn9
	for <lists+linux-erofs@lfdr.de>; Wed, 11 Sep 2024 18:46:18 +1000 (AEST)
X-Original-To: linux-erofs@lists.ozlabs.org
Delivered-To: linux-erofs@lists.ozlabs.org
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip=115.124.30.111
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1726044376;
	cv=none; b=FznV4vUiVxbYrh+T1etkvBBTvul6EduHKTApCsnIN7U3XOcaE+f1lSefrkn1LEasiuWw05OZBRZgC5gQ5ZXe0ErADJLBsR40r7+Z1j1gKFfdMtLfIV/mZZieCL+b05uZHmagyr32ZyYfIgynY9l/dWDKPAz5idLYOY0RRVAAVEhFphBkRhhXqJFLuSfdHL1PWzhuBrKeaxClsGJnhdhmgtLyDsHW49PAbFuCyHSIWU4leN4v8f5SSC8MapmcOLrys2fQn1knhIffPlQwFYDcL8JvW0RTw8cCnHaZRvvzAkFsH718ed/sZzwRvXBPTg9ilYK9Dwmzpyi0d1z/06fkqg==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1726044376; c=relaxed/relaxed;
	bh=P3h5y16GLizTe6PvTzrr9uA/tXisqXQbr9c5OSCNmLE=;
	h=Message-ID:Date:MIME-Version:Subject:To:References:From:
	 In-Reply-To:Content-Type; b=mlY1YTERwf1h4ZwxsvC0ZpR8bHra7DVbqVfAnr0MHPgz1It4ksXySYW1fxBXgeqiM3wI9DZJVSsCSCIqXtduP4kexHTlcNITXN6kA23+Z8VN9Nf12NDeMbiDVQxm4tqmm0fPvBRLgHRBixWhwRwH/ZZS5OtD/D4NP0ydKVRqpdHVuOcwikFK2I0vDiJhuPmZZesh/Opzq1nqx10KZHkQ7vTzYU0JI/VS0qQdrrWRiq+7FSh91yA1G6r/ml+B7xLcwJNWx6ONnH+d3IPUz4wphKhHM6khbqWpmwjGWaVNMr/+0cX3PWCmbjDk3J6AygVOOU5UEzp61QtDCMamyPcIfg==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com; dkim=pass (1024-bit key; unprotected) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.a=rsa-sha256 header.s=default header.b=VV5LqyLb; dkim-atps=neutral; spf=pass (client-ip=115.124.30.111; helo=out30-111.freemail.mail.aliyun.com; envelope-from=hongzhen@linux.alibaba.com; receiver=lists.ozlabs.org) smtp.mailfrom=linux.alibaba.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (1024-bit key; unprotected) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.a=rsa-sha256 header.s=default header.b=VV5LqyLb;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=linux.alibaba.com (client-ip=115.124.30.111; helo=out30-111.freemail.mail.aliyun.com; envelope-from=hongzhen@linux.alibaba.com; receiver=lists.ozlabs.org)
Received: from out30-111.freemail.mail.aliyun.com (out30-111.freemail.mail.aliyun.com [115.124.30.111])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4X3Z142xRwz2xfC
	for <linux-erofs@lists.ozlabs.org>; Wed, 11 Sep 2024 18:46:15 +1000 (AEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=linux.alibaba.com; s=default;
	t=1726044372; h=Message-ID:Date:MIME-Version:Subject:To:From:Content-Type;
	bh=P3h5y16GLizTe6PvTzrr9uA/tXisqXQbr9c5OSCNmLE=;
	b=VV5LqyLbrGXgPkXEn9sgWtigcPASf34z2HHK5yW1QmRK5ULtIhnhxgD9IffVQslezSPWb/9XkP0BHYw467b7kEUiw2uLDoySgwXVVKMaOirXBFkHD334Rgmgzpp4pl+z25mVBSvi/c2Tpel4cKoGvJLDhD7JhozTW0Tbrl6R+zQ=
Received: from 30.221.132.109(mailfrom:hongzhen@linux.alibaba.com fp:SMTPD_---0WEn9hLL_1726044370)
          by smtp.aliyun-inc.com;
          Wed, 11 Sep 2024 16:46:11 +0800
Message-ID: <1509881c-e439-4d96-8e7f-6e2df867d7dc@linux.alibaba.com>
Date: Wed, 11 Sep 2024 16:46:09 +0800
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2] erofs-utils: lib: fix incorrect nblocks in block list
 for chunked inodes
To: Gao Xiang <hsiangkao@linux.alibaba.com>, linux-erofs@lists.ozlabs.org
References: <20240911083539.2111707-1-hongzhen@linux.alibaba.com>
 <3c8790b6-9b48-40a6-8e4f-fc5a27aa8370@linux.alibaba.com>
From: Hongzhen Luo <hongzhen@linux.alibaba.com>
In-Reply-To: <3c8790b6-9b48-40a6-8e4f-fc5a27aa8370@linux.alibaba.com>
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


On 2024/9/11 16:41, Gao Xiang wrote:
>
>
> On 2024/9/11 16:35, Hongzhen Luo wrote:
>> Currently, the number of physical blocks (nblocks) for the last chunk
>> written to the block list file is incorrectly recorded as the inode
>> chunksize.
>>
>> This patch writes the actual number of physical blocks for the inode in
>> the last chunk to the block list file.
>>
>> Signed-off-by: Hongzhen Luo <hongzhen@linux.alibaba.com>
>
> I guess it fixes
>
> Fixes: 7b46f7a0160a ("erofs-utils: lib: merge consecutive chunks if 
> possible")
> Fixes: b6749839e710 ("erofs-utils: generate preallocated extents for 
> tarerofs")
>
> ?
>
Yes.
>
>> ---
>>   lib/blobchunk.c | 6 +++++-
>>   1 file changed, 5 insertions(+), 1 deletion(-)
>>
>> diff --git a/lib/blobchunk.c b/lib/blobchunk.c
>> index 33dadd5..a0f3d0e 100644
>> --- a/lib/blobchunk.c
>> +++ b/lib/blobchunk.c
>> @@ -133,6 +133,7 @@ static int erofs_blob_hashmap_cmp(const void *a, 
>> const void *b,
>>   int erofs_blob_write_chunk_indexes(struct erofs_inode *inode,
>>                      erofs_off_t off)
>>   {
>> +    erofs_blk_t remaining_blks = BLK_ROUND_UP(inode->sbi, 
>> inode->i_size);
>>       struct erofs_inode_chunk_index idx = {0};> erofs_blk_t 
>> extent_start = EROFS_NULL_ADDR;
>>       erofs_blk_t extent_end, chunkblks;
>> @@ -165,6 +166,7 @@ int erofs_blob_write_chunk_indexes(struct 
>> erofs_inode *inode,
>>           if (extent_start == EROFS_NULL_ADDR ||
>>               idx.blkaddr != extent_end) {
>>               if (extent_start != EROFS_NULL_ADDR) {
>> +                remaining_blks -= extent_end - extent_start;
>>                   tarerofs_blocklist_write(extent_start,
>>                           extent_end - extent_start,
>>                           source_offset);
>> @@ -187,9 +189,11 @@ int erofs_blob_write_chunk_indexes(struct 
>> erofs_inode *inode,
>>               memcpy(inode->chunkindexes + dst, &idx, sizeof(idx));
>>       }
>>       off = roundup(off, unit);
>> -    if (extent_start != EROFS_NULL_ADDR)
>> +    if (extent_start != EROFS_NULL_ADDR) {
>
> You should move extent_end out of this block since
> erofs_droid_blocklist_write_extent() is impacted too.

Sure, i will fix this in the next patch.

Thanks,

Hongzhen

>
> Thanks,
> Gao Xiang
