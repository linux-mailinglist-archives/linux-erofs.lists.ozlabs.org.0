Return-Path: <linux-erofs+bounces-1797-lists+linux-erofs=lfdr.de@lists.ozlabs.org>
X-Original-To: lists+linux-erofs@lfdr.de
Delivered-To: lists+linux-erofs@lfdr.de
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2404:9400:21b9:f100::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 6DCB8D08A7B
	for <lists+linux-erofs@lfdr.de>; Fri, 09 Jan 2026 11:43:39 +0100 (CET)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4dndfd1QPvz2xc8;
	Fri, 09 Jan 2026 21:43:37 +1100 (AEDT)
X-Original-To: linux-erofs@lists.ozlabs.org
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip=113.46.200.226
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1767955417;
	cv=none; b=kEM9fNp8QSgy91LsA0fBONPJX5wUrIDeunnWCeHx/onArkISsMoWpc3kcWAF7qAUwjswpOFwBaLgzpdV3sKvE6UgILqpRXilkUlS8Ipx8cgHMvzpDPMG4eetoDnCqSMbEjjC0sbWgFyl3JpzXZFy4lD535UBjkn3eK/hL0MrBQ6tHoI7RQ0qMKR4T/8nPMYWrUl9D3Qn6smJWxoGDJYStNRKSm135TL2rWNfVUb4YwxgB1IjXxYCm1YcIZRtrNWpuPnsjWEPsW8Cu+23xhGRI1AHZfuH6Xrlqce4CXUqdXb8EPW9SXm8j0T7KZlaum7C4q7NtaKKOUAiJ9DkqjGmzw==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1767955417; c=relaxed/relaxed;
	bh=p5aqjO7a7k2miwno/kz2oh81dP/NQO1G4GJgPuXM/z0=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=l9iYgjxQN3gcVoAfO0fz9snrCvluOB/H3fcOV6VXbaZmDS3DA4Of3e7eH2B2Q7Z4hITVtdNW1JwpX0NdGJq+8QdFgQ+JATvKGzW8AJcf43VBcmmS+NcGYTCUQ15stXr8QvU+zECjNeW0Zcb6xajHcloixFy9nQLSuqWITYf8t0Asp/oGNGkm3gWTSHaZblGmbP9KpW94rGzesTGyvEzr5KYVzhYfWgkSIsVftvS/6xgPlu8f00Ks2245Fpx2vXRZWOiNFjV4OpAdJnOdt2UfvnF7FnPHgcsOc740/H1nF6Aj5LadATlq2tAfRRPF1CU+AUBRKaCpaaFTKCRWX9WSJg==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; dkim=pass (1024-bit key; unprotected) header.d=huawei.com header.i=@huawei.com header.a=rsa-sha256 header.s=dkim header.b=r6rPa8j4; dkim-atps=neutral; spf=pass (client-ip=113.46.200.226; helo=canpmsgout11.his.huawei.com; envelope-from=lihongbo22@huawei.com; receiver=lists.ozlabs.org) smtp.mailfrom=huawei.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (1024-bit key; unprotected) header.d=huawei.com header.i=@huawei.com header.a=rsa-sha256 header.s=dkim header.b=r6rPa8j4;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=huawei.com (client-ip=113.46.200.226; helo=canpmsgout11.his.huawei.com; envelope-from=lihongbo22@huawei.com; receiver=lists.ozlabs.org)
Received: from canpmsgout11.his.huawei.com (canpmsgout11.his.huawei.com [113.46.200.226])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4dndfb6lDYz2xSN
	for <linux-erofs@lists.ozlabs.org>; Fri, 09 Jan 2026 21:43:35 +1100 (AEDT)
dkim-signature: v=1; a=rsa-sha256; d=huawei.com; s=dkim;
	c=relaxed/relaxed; q=dns/txt;
	h=From;
	bh=p5aqjO7a7k2miwno/kz2oh81dP/NQO1G4GJgPuXM/z0=;
	b=r6rPa8j4jM3vmPUA8wYRN1IsN/Kb9U1Q/S9hSOS/P7qNZ8P97JhHGAz+pR2dQsFYNUN6Ak08q
	q/5Zzx/0HBh/8axK4NTC2jiDGhqUQxjz1F5i2rQ/Ljd9nfrOgM6igjG4HCVgnM/4Xja5IPxDyXT
	XSm4+CGuCUjtD1+yIvtOF7M=
Received: from mail.maildlp.com (unknown [172.19.163.200])
	by canpmsgout11.his.huawei.com (SkyGuard) with ESMTPS id 4dndZl3mnHzKm50;
	Fri,  9 Jan 2026 18:40:15 +0800 (CST)
Received: from kwepemr500015.china.huawei.com (unknown [7.202.195.162])
	by mail.maildlp.com (Postfix) with ESMTPS id CBEC440563;
	Fri,  9 Jan 2026 18:43:32 +0800 (CST)
Received: from [10.67.111.104] (10.67.111.104) by
 kwepemr500015.china.huawei.com (7.202.195.162) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.11; Fri, 9 Jan 2026 18:43:32 +0800
Message-ID: <659a02c2-cd90-40d4-82b6-f6010e8bcf98@huawei.com>
Date: Fri, 9 Jan 2026 18:43:31 +0800
X-Mailing-List: linux-erofs@lists.ozlabs.org
List-Id: <linux-erofs.lists.ozlabs.org>
List-Help: <mailto:linux-erofs+help@lists.ozlabs.org>
List-Owner: <mailto:linux-erofs+owner@lists.ozlabs.org>
List-Post: <mailto:linux-erofs@lists.ozlabs.org>
List-Subscribe: <mailto:linux-erofs+subscribe@lists.ozlabs.org>,
  <mailto:linux-erofs+subscribe-digest@lists.ozlabs.org>,
  <mailto:linux-erofs+subscribe-nomail@lists.ozlabs.org>
List-Unsubscribe: <mailto:linux-erofs+unsubscribe@lists.ozlabs.org>
Precedence: list
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v13 01/10] iomap: stash iomap read ctx in the private
 field of iomap_iter
Content-Language: en-US
To: Gao Xiang <hsiangkao@linux.alibaba.com>, Christoph Hellwig <hch@lst.de>,
	"Darrick J. Wong" <djwong@kernel.org>, Christian Brauner <brauner@kernel.org>
CC: <amir73il@gmail.com>, <linux-fsdevel@vger.kernel.org>,
	<linux-erofs@lists.ozlabs.org>, <linux-kernel@vger.kernel.org>, Chao Yu
	<chao@kernel.org>
References: <20260109030140.594936-1-lihongbo22@huawei.com>
 <20260109030140.594936-2-lihongbo22@huawei.com>
 <d1d84c90-9bca-4f14-a635-6199ce84df48@linux.alibaba.com>
From: Hongbo Li <lihongbo22@huawei.com>
In-Reply-To: <d1d84c90-9bca-4f14-a635-6199ce84df48@linux.alibaba.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 8bit
X-Originating-IP: [10.67.111.104]
X-ClientProxiedBy: kwepems500001.china.huawei.com (7.221.188.70) To
 kwepemr500015.china.huawei.com (7.202.195.162)
X-Spam-Status: No, score=-0.2 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS autolearn=disabled
	version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-25) on lists.ozlabs.org

Hi, all

On 2026/1/9 14:03, Gao Xiang wrote:
> Hi Christoph, Darrick, Christian,
> 
> On 2026/1/9 11:01, Hongbo Li wrote:
>> It's useful to get filesystem-specific information using the
>> existing private field in the @iomap_iter passed to iomap_{begin,end}
>> for advanced usage for iomap buffered reads, which is much like the
>> current iomap DIO.
>>
>> For example, EROFS needs it to:
>>
>>   - implement an efficient page cache sharing feature, since iomap
>>     needs to apply to anon inode page cache but we'd like to get the
>>     backing inode/fs instead, so filesystem-specific private data is
>>     needed to keep such information;
>>
>>   - pass in both struct page * and void * for inline data to avoid
>>     kmap_to_page() usage (which is bogus).
>>
>> Signed-off-by: Hongbo Li <lihongbo22@huawei.com>
>> Reviewed-by: Gao Xiang <hsiangkao@linux.alibaba.com>
> 
> Could you help review or ack this patch?
> 
> This feature is almost in shape for the upcoming cycle,
> I do hope this iomap patch could be reviewed, thanks!
> 

I have sent the latest version v14. Could you help review or ack based 
on the latest one?

Thanks,
Hongbo

> Thanks,
> Gao Xiang
> 
>> ---
>>   fs/fuse/file.c         | 4 ++--
>>   fs/iomap/buffered-io.c | 6 ++++--
>>   include/linux/iomap.h  | 8 ++++----
>>   3 files changed, 10 insertions(+), 8 deletions(-)
>>
>> diff --git a/fs/fuse/file.c b/fs/fuse/file.c
>> index 01bc894e9c2b..f5d8887c1922 100644
>> --- a/fs/fuse/file.c
>> +++ b/fs/fuse/file.c
>> @@ -979,7 +979,7 @@ static int fuse_read_folio(struct file *file, 
>> struct folio *folio)
>>           return -EIO;
>>       }
>> -    iomap_read_folio(&fuse_iomap_ops, &ctx);
>> +    iomap_read_folio(&fuse_iomap_ops, &ctx, NULL);
>>       fuse_invalidate_atime(inode);
>>       return 0;
>>   }
>> @@ -1081,7 +1081,7 @@ static void fuse_readahead(struct 
>> readahead_control *rac)
>>       if (fuse_is_bad(inode))
>>           return;
>> -    iomap_readahead(&fuse_iomap_ops, &ctx);
>> +    iomap_readahead(&fuse_iomap_ops, &ctx, NULL);
>>   }
>>   static ssize_t fuse_cache_read_iter(struct kiocb *iocb, struct 
>> iov_iter *to)
>> diff --git a/fs/iomap/buffered-io.c b/fs/iomap/buffered-io.c
>> index e5c1ca440d93..5f7dcbabbda3 100644
>> --- a/fs/iomap/buffered-io.c
>> +++ b/fs/iomap/buffered-io.c
>> @@ -555,13 +555,14 @@ static int iomap_read_folio_iter(struct 
>> iomap_iter *iter,
>>   }
>>   void iomap_read_folio(const struct iomap_ops *ops,
>> -        struct iomap_read_folio_ctx *ctx)
>> +        struct iomap_read_folio_ctx *ctx, void *private)
>>   {
>>       struct folio *folio = ctx->cur_folio;
>>       struct iomap_iter iter = {
>>           .inode        = folio->mapping->host,
>>           .pos        = folio_pos(folio),
>>           .len        = folio_size(folio),
>> +        .private    = private,
>>       };
>>       size_t bytes_submitted = 0;
>>       int ret;
>> @@ -620,13 +621,14 @@ static int iomap_readahead_iter(struct 
>> iomap_iter *iter,
>>    * the filesystem to be reentered.
>>    */
>>   void iomap_readahead(const struct iomap_ops *ops,
>> -        struct iomap_read_folio_ctx *ctx)
>> +        struct iomap_read_folio_ctx *ctx, void *private)
>>   {
>>       struct readahead_control *rac = ctx->rac;
>>       struct iomap_iter iter = {
>>           .inode    = rac->mapping->host,
>>           .pos    = readahead_pos(rac),
>>           .len    = readahead_length(rac),
>> +        .private = private,
>>       };
>>       size_t cur_bytes_submitted;
>> diff --git a/include/linux/iomap.h b/include/linux/iomap.h
>> index 520e967cb501..441d614e9fdf 100644
>> --- a/include/linux/iomap.h
>> +++ b/include/linux/iomap.h
>> @@ -341,9 +341,9 @@ ssize_t iomap_file_buffered_write(struct kiocb 
>> *iocb, struct iov_iter *from,
>>           const struct iomap_ops *ops,
>>           const struct iomap_write_ops *write_ops, void *private);
>>   void iomap_read_folio(const struct iomap_ops *ops,
>> -        struct iomap_read_folio_ctx *ctx);
>> +        struct iomap_read_folio_ctx *ctx, void *private);
>>   void iomap_readahead(const struct iomap_ops *ops,
>> -        struct iomap_read_folio_ctx *ctx);
>> +        struct iomap_read_folio_ctx *ctx, void *private);
>>   bool iomap_is_partially_uptodate(struct folio *, size_t from, size_t 
>> count);
>>   struct folio *iomap_get_folio(struct iomap_iter *iter, loff_t pos, 
>> size_t len);
>>   bool iomap_release_folio(struct folio *folio, gfp_t gfp_flags);
>> @@ -595,7 +595,7 @@ static inline void iomap_bio_read_folio(struct 
>> folio *folio,
>>           .cur_folio    = folio,
>>       };
>> -    iomap_read_folio(ops, &ctx);
>> +    iomap_read_folio(ops, &ctx, NULL);
>>   }
>>   static inline void iomap_bio_readahead(struct readahead_control *rac,
>> @@ -606,7 +606,7 @@ static inline void iomap_bio_readahead(struct 
>> readahead_control *rac,
>>           .rac        = rac,
>>       };
>> -    iomap_readahead(ops, &ctx);
>> +    iomap_readahead(ops, &ctx, NULL);
>>   }
>>   #endif /* CONFIG_BLOCK */
> 

