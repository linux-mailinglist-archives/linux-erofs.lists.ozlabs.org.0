Return-Path: <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>
X-Original-To: lists+linux-erofs@lfdr.de
Delivered-To: lists+linux-erofs@lfdr.de
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	by mail.lfdr.de (Postfix) with ESMTPS id 757E5A1658B
	for <lists+linux-erofs@lfdr.de>; Mon, 20 Jan 2025 04:02:24 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=lists.ozlabs.org;
	s=201707; t=1737342140;
	bh=S2FQeknNbJMgT8HWdWHvTHJBt/mi1t8pi3Pr5IFkukw=;
	h=Date:Subject:To:References:In-Reply-To:List-Id:List-Unsubscribe:
	 List-Archive:List-Post:List-Help:List-Subscribe:From:Reply-To:Cc:
	 From;
	b=UwOlH/LOWYrigKYNs2Ymf6wlSltD+5qoAFtgyh2GF705dP2IbGkxS0B/2RYffqdE8
	 NAqD/gKpeEQtF0gYQni60NEI0YM9ZJdoAcRZyUrmBUty4yAjLjoWHhypApsrRNKyLt
	 0pR7zD8Q2+CtZe5XFOuhQ5ySwX3y25dF/FYox/nJAbBHfHdt7WXXC6SNkdZ6m+/Vy6
	 hmbU1uB7hWzodxLH19xAsj1PjXsicDbKy+HbL3R//m23GPSxSXM833Q3QrN7sbyVMp
	 tiitABtJsOM84CXCS80RSpdmon3xKrHvIrTgvhHQIaPTYZPenDpLZVfcl0QzfcX9wn
	 rnOoeplOELYgg==
Received: from boromir.ozlabs.org (localhost [IPv6:::1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4Ybw9m1pWsz3013
	for <lists+linux-erofs@lfdr.de>; Mon, 20 Jan 2025 14:02:20 +1100 (AEDT)
X-Original-To: linux-erofs@lists.ozlabs.org
Delivered-To: linux-erofs@lists.ozlabs.org
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip=45.249.212.188
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1737342138;
	cv=none; b=U9ASPCZi/2ULiZYEDog9fQl/gxAjrU3yZsVbHhBhpmzr/dsQ+Ek9qDRXqxtI5RdH3+4ivrmMQehK8VlPP+GDjIgIajzNod/fUHjERzUNvALZqBEKTByiD6iJVUdyr8rmoPwNKQYy4eE9t1r+fAYUhq86IXy7BgblZnYIUSjIVtIY1C9ccFUzZTdyFRv+Erp1kdVNGBeQolhh0+Kfa7XICeg6/oDxdnjs4XLNZ2wqeW9vFxjP+I+HZNNj3PWbVd1556hv+EPvslblOWvKfPIAT41db52x/g6iN9+y5JBfbgTrkfrDFq5nN5hWqVosX2/866d27XZQZVz1qu/w4nRSsQ==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1737342138; c=relaxed/relaxed;
	bh=S2FQeknNbJMgT8HWdWHvTHJBt/mi1t8pi3Pr5IFkukw=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=VxK9k9IeFvf9SOxA2q3t9Jp9mh04hZnbhZXGM1M3xUNZgjA0TuaTHw/AGTgXnUjZUZCdBWEZXZJ60dpzynfCHup2ZcTMQSBgJx/23pj8zwqkMUbpM5td82DVltcL0CQST12WxePieAl5MF+5nWj2nPuoB93SYqhllg5vKjCCHD3/9NBXjb73el/sTEFPQGNLjQQ3jmTKgxo+mGRuw9pZWPPilmPdvYXqldhDg4sZxVK6EaEK4p3i9MDrfqZh7l46EAUkR18MrxBMhi8iNnttR4UjW/cSq2QYKXfk2C/gk1Mj2HbDNN7Z5ca16P1Dck8WteljBMkgz4U8+yAhGUXfJA==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass (client-ip=45.249.212.188; helo=szxga02-in.huawei.com; envelope-from=lihongbo22@huawei.com; receiver=lists.ozlabs.org) smtp.mailfrom=huawei.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=huawei.com (client-ip=45.249.212.188; helo=szxga02-in.huawei.com; envelope-from=lihongbo22@huawei.com; receiver=lists.ozlabs.org)
Received: from szxga02-in.huawei.com (szxga02-in.huawei.com [45.249.212.188])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4Ybw9j0rmBz2yFB
	for <linux-erofs@lists.ozlabs.org>; Mon, 20 Jan 2025 14:02:15 +1100 (AEDT)
Received: from mail.maildlp.com (unknown [172.19.88.105])
	by szxga02-in.huawei.com (SkyGuard) with ESMTP id 4Ybw5s6tQQzgbyh;
	Mon, 20 Jan 2025 10:58:57 +0800 (CST)
Received: from kwepemo500009.china.huawei.com (unknown [7.202.194.199])
	by mail.maildlp.com (Postfix) with ESMTPS id 4B7361401F1;
	Mon, 20 Jan 2025 11:02:08 +0800 (CST)
Received: from [10.67.111.104] (10.67.111.104) by
 kwepemo500009.china.huawei.com (7.202.194.199) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.11; Mon, 20 Jan 2025 11:02:07 +0800
Message-ID: <fbd5850c-e431-4914-81eb-ec3ff42419a4@huawei.com>
Date: Mon, 20 Jan 2025 11:02:07 +0800
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH RFC] erofs: file-backed mount supports direct io
To: Gao Xiang <hsiangkao@linux.alibaba.com>, <xiang@kernel.org>,
	<chao@kernel.org>
References: <20250115070936.119975-1-lihongbo22@huawei.com>
 <635ede9a-b5eb-4630-88ba-2826022d5585@linux.alibaba.com>
Content-Language: en-US
In-Reply-To: <635ede9a-b5eb-4630-88ba-2826022d5585@linux.alibaba.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 8bit
X-Originating-IP: [10.67.111.104]
X-ClientProxiedBy: dggems706-chm.china.huawei.com (10.3.19.183) To
 kwepemo500009.china.huawei.com (7.202.194.199)
X-Spam-Status: No, score=-2.3 required=5.0 tests=RCVD_IN_DNSWL_MED,
	SPF_HELO_NONE,SPF_PASS autolearn=disabled version=4.0.0
X-Spam-Checker-Version: SpamAssassin 4.0.0 (2022-12-13) on lists.ozlabs.org
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
From: Hongbo Li via Linux-erofs <linux-erofs@lists.ozlabs.org>
Reply-To: Hongbo Li <lihongbo22@huawei.com>
Cc: linux-erofs@lists.ozlabs.org
Errors-To: linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org
Sender: "Linux-erofs" <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>



On 2025/1/20 9:58, Gao Xiang wrote:
> Hi Hongbo,
> 
> On 2025/1/15 15:09, Hongbo Li wrote:
>> erofs has add file-backed mount support. In this scenario, only buffer
>> io is allowed. So we enhance the io mode by implementing the direct
>> io. Also, this can make the iov_iter (user buffer) interact with the
>> backed file's page cache directly.
>>
>> Signed-off-by: Hongbo Li <lihongbo22@huawei.com>
>> ---
>>   fs/erofs/data.c   |  11 +++--
>>   fs/erofs/fileio.c | 122 ++++++++++++++++++++++++++++++++++++++++++++++
>>   2 files changed, 130 insertions(+), 3 deletions(-)
>>
>> diff --git a/fs/erofs/data.c b/fs/erofs/data.c
>> index 0cd6b5c4df98..b5baff61be16 100644
>> --- a/fs/erofs/data.c
>> +++ b/fs/erofs/data.c
>> @@ -395,9 +395,14 @@ static ssize_t erofs_file_read_iter(struct kiocb 
>> *iocb, struct iov_iter *to)
>>       if (IS_DAX(inode))
>>           return dax_iomap_rw(iocb, to, &erofs_iomap_ops);
>>   #endif
>> -    if ((iocb->ki_flags & IOCB_DIRECT) && inode->i_sb->s_bdev)
>> -        return iomap_dio_rw(iocb, to, &erofs_iomap_ops,
>> -                    NULL, 0, NULL, 0);
>> +    if (iocb->ki_flags & IOCB_DIRECT) {
>> +        if (inode->i_sb->s_bdev)
>> +            return iomap_dio_rw(iocb, to, &erofs_iomap_ops,
>> +                        NULL, 0, NULL, 0);
>> +        if (erofs_is_fileio_mode(EROFS_SB(inode->i_sb)))
>> +            return generic_file_read_iter(iocb, to);
>> +    }
>> +
>>       return filemap_read(iocb, to, 0);
>>   }
>> diff --git a/fs/erofs/fileio.c b/fs/erofs/fileio.c
>> index 33f8539dda4a..76ed16a8ee75 100644
>> --- a/fs/erofs/fileio.c
>> +++ b/fs/erofs/fileio.c
>> @@ -10,12 +10,17 @@ struct erofs_fileio_rq {
>>       struct bio bio;
>>       struct kiocb iocb;
>>       struct super_block *sb;
>> +    ssize_t ret;
>> +    void *private;
>>   };
>>   struct erofs_fileio {
>> +    struct file *file;
>>       struct erofs_map_blocks map;
>>       struct erofs_map_dev dev;
>>       struct erofs_fileio_rq *rq;
>> +    size_t total;
>> +    size_t done;
>>   };
>>   static void erofs_fileio_ki_complete(struct kiocb *iocb, long ret)
>> @@ -24,6 +29,7 @@ static void erofs_fileio_ki_complete(struct kiocb 
>> *iocb, long ret)
>>               container_of(iocb, struct erofs_fileio_rq, iocb);
>>       struct folio_iter fi;
>> +    rq->ret = ret;
>>       if (ret > 0) {
>>           if (ret != rq->bio.bi_iter.bi_size) {
>>               bio_advance(&rq->bio, ret);
>> @@ -43,6 +49,17 @@ static void erofs_fileio_ki_complete(struct kiocb 
>> *iocb, long ret)
>>       kfree(rq);
>>   }
>> +static void erofs_fileio_end_io(struct bio *bio)
>> +{
>> +    struct erofs_fileio_rq *rq =
>> +            container_of(bio, struct erofs_fileio_rq, bio);
>> +    struct erofs_fileio *io = rq->private;
>> +
>> +    if (rq->ret > 0) {
>> +        io->done += rq->ret;
>> +    }
>> +}
>> +
>>   static void erofs_fileio_rq_submit(struct erofs_fileio_rq *rq)
>>   {
>>       struct iov_iter iter;
>> @@ -189,7 +206,112 @@ static void erofs_fileio_readahead(struct 
>> readahead_control *rac)
>>       erofs_fileio_rq_submit(io.rq);
>>   }
>> +static int erofs_fileio_scan_iter(struct erofs_fileio *io, struct 
>> kiocb *iocb,
>> +                  struct iov_iter *iter)
> 
> I wonder if it's possible to just extract a folio from
> `struct iov_iter` and reuse erofs_fileio_scan_folio() logic.
Thanks for reviewing. Ok, I'll think about reusing the 
erofs_fileio_scan_folio logic in later version.

Additionally, for the file-backed mount case, can we consider removing 
the erofs's page cache and just using the backend file's page cache? If 
in this way, it will use buffer io for reading the backend's mounted 
files in default, and it also can decrease the memory overhead.

This is just my initial idea, for uncompressed mode, this should make 
sense. But for compressed layout, it needs to be verified.

Thanks,
Hongbo

> 
> It simplifies the codebase a lot, and I think the performance
> is almost the same.
> 
> Otherwise currently it looks good to me.
> 
> Thanks,
> Gao Xiang
