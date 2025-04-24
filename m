Return-Path: <linux-erofs+bounces-228-lists+linux-erofs=lfdr.de@lists.ozlabs.org>
X-Original-To: lists+linux-erofs@lfdr.de
Delivered-To: lists+linux-erofs@lfdr.de
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	by mail.lfdr.de (Postfix) with ESMTPS id DE8D5A9A56C
	for <lists+linux-erofs@lfdr.de>; Thu, 24 Apr 2025 10:12:09 +0200 (CEST)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4Zjpbp4sWQz3bnm;
	Thu, 24 Apr 2025 18:12:06 +1000 (AEST)
X-Original-To: linux-erofs@lists.ozlabs.org
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip=45.249.212.255
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1745482326;
	cv=none; b=bjL5DfsWEU9sKQZcuHqiPgLCn7hr39WzzxtvoMk+Q08tIT0LsxYtLI/uevHBHNFOXfDKgJIAUIT++8FuQRssZTPCb6nP2G5vcu2nOl3EFbUpTSNpUJga3jcYxV43t7jF95rHQtIp1DdseQDZWed4bwEF/FuO1ipwRgfF61ayRhGfLcTytoO9KkBMGCKZZY/yu0iCAxfuUZ04jEUM8QhpBTH8XJiC/d9WMLzUPl6kcOVLqwwK8iotl1LcAHWSntyOkBs3eD1gZyqiTzU1fpu11ZTU6QOwJ4MUyvMdgSl30+piU1RjR8gqPjmlmLkfp+YTDAP84Rflfx0KbO8LYw2yeQ==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1745482326; c=relaxed/relaxed;
	bh=hBTqcjAVtwy+teOG072x4FMsEuklr/DJlFHn1O3fdKM=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=EYRMai4QvevAh70k0Kp3pcENZsVHeq8yDi5AHo1LXUUIqSs2RnJ8hw85tB1bK1flLarYc3lFzWvhzib1Nd0C0z5y61zk1DHX0DzPG4KQzuh/RcB7UXGhhhLJTeZFGi7MoTwJC5mi1Xqd5lMpEYwDoT8Ki2qgx8Npg7RTq+8uRI1+TKPQsKnITMoGqLQBsZRCC8/RGvY15+Hogh/JolLKcGPQsO+5lSpFZl2rJWaiyZDQl5FrnX7KTxpO3d/faAliAfgkcgwO2jHH1+QHpnYkoqcUIS/0yN+ntzaIb7g8E763lXIMLO9190mrJAZpaUvMuqfcl06XkxuqnLcxsgXuXw==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass (client-ip=45.249.212.255; helo=szxga08-in.huawei.com; envelope-from=lihongbo22@huawei.com; receiver=lists.ozlabs.org) smtp.mailfrom=huawei.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=huawei.com (client-ip=45.249.212.255; helo=szxga08-in.huawei.com; envelope-from=lihongbo22@huawei.com; receiver=lists.ozlabs.org)
Received: from szxga08-in.huawei.com (szxga08-in.huawei.com [45.249.212.255])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4Zjpbn2Bscz3bnL
	for <linux-erofs@lists.ozlabs.org>; Thu, 24 Apr 2025 18:12:03 +1000 (AEST)
Received: from mail.maildlp.com (unknown [172.19.163.252])
	by szxga08-in.huawei.com (SkyGuard) with ESMTP id 4ZjpZT62l4z1d0mt;
	Thu, 24 Apr 2025 16:10:57 +0800 (CST)
Received: from kwepemo500009.china.huawei.com (unknown [7.202.194.199])
	by mail.maildlp.com (Postfix) with ESMTPS id E1927180B51;
	Thu, 24 Apr 2025 16:11:57 +0800 (CST)
Received: from [10.67.111.104] (10.67.111.104) by
 kwepemo500009.china.huawei.com (7.202.194.199) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.11; Thu, 24 Apr 2025 16:11:57 +0800
Message-ID: <b6d8f4eb-e1ab-4a83-b552-0b58ec120299@huawei.com>
Date: Thu, 24 Apr 2025 16:11:56 +0800
X-Mailing-List: linux-erofs@lists.ozlabs.org
List-Id: <linux-erofs.lists.ozlabs.org>
List-Help: <mailto:linux-erofs+help@lists.ozlabs.org>
List-Owner: <mailto:linux-erofs+owner@lists.ozlabs.org>
List-Post: <mailto:linux-erofs@lists.ozlabs.org>
List-Subscribe: <mailto:linux-erofs+subscribe@lists.ozlabs.org>,
  <mailto:linux-erofs+subscribe-digest@lists.ozlabs.org>,
  <mailto:linux-erofs+subscribe-nomail@lists.ozlabs.org>
List-Unsubscribe: <mailto:linux-erofs+unsubscribe@lists.ozlabs.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: Maybe update the minextblks in wrong way?
To: Sandeep Dhavale <dhavale@google.com>
CC: Gao Xiang <hsiangkao@linux.alibaba.com>, LKML
	<linux-kernel@vger.kernel.org>, linux-erofs mailing list
	<linux-erofs@lists.ozlabs.org>
References: <50dc6bdc-ee62-41f1-b8e5-be64defb07c6@huawei.com>
 <CAB=BE-R4uPFeBSt6Z4Khv6_OjAu9=WoJR-VGG8eG0spAaovE1w@mail.gmail.com>
Content-Language: en-US
From: Hongbo Li <lihongbo22@huawei.com>
In-Reply-To: <CAB=BE-R4uPFeBSt6Z4Khv6_OjAu9=WoJR-VGG8eG0spAaovE1w@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 8bit
X-Originating-IP: [10.67.111.104]
X-ClientProxiedBy: dggems704-chm.china.huawei.com (10.3.19.181) To
 kwepemo500009.china.huawei.com (7.202.194.199)
X-Spam-Status: No, score=-2.3 required=3.0 tests=RCVD_IN_DNSWL_MED,
	SPF_HELO_NONE,SPF_PASS autolearn=disabled version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-25) on lists.ozlabs.org



On 2025/4/24 14:51, Sandeep Dhavale wrote:
> On Wed, Apr 23, 2025 at 6:50 PM Hongbo Li <lihongbo22@huawei.com> wrote:
>>
>> Hi Sandeep,
>>     The consecutive chunks will be merged if possible, but after commit
>> 545988a65131 ("erofs-utils: lib: Fix calculation of minextblks when
>> working with sparse files"), the @minextblks will be updated into a
>> smaller value even the chunks are consecutive by blobchunks.c:379. I
>> think maybe the last operation that updates @minextblks is unnecessary,
>> since this value would have already been adjusted earlier when handling
>> discontinuous chunks. Likes:
>>
>> ```
>> --- a/lib/blobchunk.c
>> +++ b/lib/blobchunk.c
>> @@ -376,7 +376,6 @@ int erofs_blob_write_chunked_file(struct erofs_inode
>> *inode, int fd,
>>                   *(void **)idx++ = chunk;
>>                   lastch = chunk;
>>           }
>> -       erofs_update_minextblks(sbi, interval_start, pos, &minextblks);
>>           inode->datalayout = EROFS_INODE_CHUNK_BASED;
>>           free(chunkdata);
>>           return erofs_blob_mergechunks(inode, chunkbits,
>>
>> ```
>> This way can reduces the chunk index array's size. And what about your
>> opinion?
>>
>> Thanks,
>> Hongbo
> 
> Hi Hongbo,
> I think the last call is necessary to handle the tail end which is not
> handled in the for loop. But I understand that if the file is
> contiguous then the last call can reduce minextblks.

Ok, also should update is_contiguous in another place when we found the 
dedup chunk for non-sparse file?

By the way, why we should use the value of lowbit instead of the (end - 
start) >> sbi->blkszbits to update minextblks? The lowbit will get the 
smaller value.

Thanks,
Hongbo
> 
> Does the below patch address your concern to conditionally call the
> last erofs_update_minextblks()?
> 
> Thanks,
> Sandeep.
> 
> diff --git a/lib/blobchunk.c b/lib/blobchunk.c
> index de9150f..47fe923 100644
> --- a/lib/blobchunk.c
> +++ b/lib/blobchunk.c
> @@ -303,6 +303,7 @@ int erofs_blob_write_chunked_file(struct
> erofs_inode *inode, int fd,
>          lastch = NULL;
>          minextblks = BLK_ROUND_UP(sbi, inode->i_size);
>          interval_start = 0;
> +       bool is_contiguous = true;
> 
>          for (pos = 0; pos < inode->i_size; pos += len) {
>   #ifdef SEEK_DATA
> @@ -332,6 +333,7 @@ int erofs_blob_write_chunked_file(struct
> erofs_inode *inode, int fd,
>                                  erofs_update_minextblks(sbi, interval_start,
>                                                          pos, &minextblks);
>                                  interval_start = pos;
> +                               is_contiguous = false;
>                          }
>                          do {
>                                  *(void **)idx++ = &erofs_holechunk;
> @@ -365,7 +367,8 @@ int erofs_blob_write_chunked_file(struct
> erofs_inode *inode, int fd,
>                  *(void **)idx++ = chunk;
>                  lastch = chunk;
>          }
> -       erofs_update_minextblks(sbi, interval_start, pos, &minextblks);
> +       if (!is_contiguous)
> +               erofs_update_minextblks(sbi, interval_start, pos, &minextblks);
>          inode->datalayout = EROFS_INODE_CHUNK_BASED;
>          free(chunkdata);
>          return erofs_blob_mergechunks(inode, chunkbits,
> 

