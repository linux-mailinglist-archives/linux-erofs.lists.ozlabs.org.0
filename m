Return-Path: <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>
X-Original-To: lists+linux-erofs@lfdr.de
Delivered-To: lists+linux-erofs@lfdr.de
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2404:9400:2:0:216:3eff:fee1:b9f1])
	by mail.lfdr.de (Postfix) with ESMTPS id D101393489D
	for <lists+linux-erofs@lfdr.de>; Thu, 18 Jul 2024 09:11:26 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=lists.ozlabs.org;
	s=201707; t=1721286684;
	bh=B/t47Wu8HuAvbgF8FFBuJdsEatcLbGnYVxnn0L6uUdo=;
	h=Date:Subject:To:References:In-Reply-To:List-Id:List-Unsubscribe:
	 List-Archive:List-Post:List-Help:List-Subscribe:From:Reply-To:Cc:
	 From;
	b=A5nyq7xJTRw3YXoJ7+vm8pcc37kJ88VTFqarB2UP3TBGdWQOusIhUh7J8hMltSmUN
	 FADvm3/mkxV0/n/MYNPdFbbNbYtCzS+kjgEJIAzUlIiYr0PW53SEWqQ+K0XgzdE+6C
	 p93Sq4fuZK7YhJtI1Uo3NR1J9aCTAGW8so67sBuNyeZJL4cv7LLxfNOrB5vSwHkBHE
	 zMKWiAOh6leH5z01ooyb0zeBDYYtVE3AjA1PCwo9FLQJhQWwY7pOjBtKgvMb9YXQBk
	 OdgSjSzgGyfh8X01o+J4lu7/jQT02GkstyZ2AsnCL3r9YY+Dh2/0XaJDT9Swzwz4EF
	 xXzmM9EhkQgAA==
Received: from boromir.ozlabs.org (localhost [IPv6:::1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4WPkW05d6Dz3ccX
	for <lists+linux-erofs@lfdr.de>; Thu, 18 Jul 2024 17:11:24 +1000 (AEST)
X-Original-To: linux-erofs@lists.ozlabs.org
Delivered-To: linux-erofs@lists.ozlabs.org
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=huawei.com (client-ip=45.249.212.35; helo=szxga07-in.huawei.com; envelope-from=lihongbo22@huawei.com; receiver=lists.ozlabs.org)
Received: from szxga07-in.huawei.com (szxga07-in.huawei.com [45.249.212.35])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4WPkVv1srlz2yvk
	for <linux-erofs@lists.ozlabs.org>; Thu, 18 Jul 2024 17:11:14 +1000 (AEST)
Received: from mail.maildlp.com (unknown [172.19.163.44])
	by szxga07-in.huawei.com (SkyGuard) with ESMTP id 4WPkPd5mT2z1X4kY;
	Thu, 18 Jul 2024 15:06:45 +0800 (CST)
Received: from dggpeml500022.china.huawei.com (unknown [7.185.36.66])
	by mail.maildlp.com (Postfix) with ESMTPS id 8AD21140136;
	Thu, 18 Jul 2024 15:11:05 +0800 (CST)
Received: from [10.67.111.104] (10.67.111.104) by
 dggpeml500022.china.huawei.com (7.185.36.66) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.39; Thu, 18 Jul 2024 15:11:05 +0800
Message-ID: <ccd28477-6a95-4d8c-9960-2288e0aca311@huawei.com>
Date: Thu, 18 Jul 2024 15:11:04 +0800
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] erofs: support direct IO for ondemand mode
Content-Language: en-US
To: Gao Xiang <hsiangkao@linux.alibaba.com>, <jefflexu@linux.alibaba.com>,
	David Howells <dhowells@redhat.com>
References: <20240718010545.2869515-1-lihongbo22@huawei.com>
 <54cf962f-dcdb-465a-ad83-f292f9b84b02@linux.alibaba.com>
In-Reply-To: <54cf962f-dcdb-465a-ad83-f292f9b84b02@linux.alibaba.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 8bit
X-Originating-IP: [10.67.111.104]
X-ClientProxiedBy: dggems704-chm.china.huawei.com (10.3.19.181) To
 dggpeml500022.china.huawei.com (7.185.36.66)
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
Cc: Yue Hu <huyue2@coolpad.com>, netfs@lists.linux.dev, linux-erofs@lists.ozlabs.org
Errors-To: linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org
Sender: "Linux-erofs" <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>



On 2024/7/18 10:40, Gao Xiang wrote:
> Hi Hongbo,
> 
> I'd like to request Jingbo's review too.
> 
> On 2024/7/18 09:05, Hongbo Li wrote:
>> erofs over fscache cannot handle the direct read io. When the file
>> is opened with O_DIRECT flag, -EINVAL will reback. We support the
>> DIO in erofs over fscache by bypassing the erofs page cache and
>> reading target data into ubuf from fscache's file directly.
> 
> Could you give more hints in the commit message on the target user
> of fscache DIO?
> 
To be honest, I haven't come across such containers using direct I/O 
yet. I've just run fio and some other tests for the direct mode in 
containers, and they failed during open. If a traditional container 
start using direct I/O when it's then migrated to the erofs over fscache 
solution (ie. Nydus), it won't run properly. This is because the current 
on-demand mode of erofs does not support direct I/O. Currently, I 
thought there are two approaches to solve this: 1. direct I/O can 
fallback to buffered I/O (simpler but seems non-reasonable); 2. 
implement the direct I/O process like this way.

Thanks,
Hongbo

> For Android use cases, direct I/O support is mainly used for loop
> device direct mode.
> 
>>
>> The alignment for buffer memory, offset and size now is restricted
>> by erofs, since `i_blocksize` is enough for the under filesystems.
>>
>> Signed-off-by: Hongbo Li <lihongbo22@huawei.com>
>> ---
>>   fs/erofs/data.c    |  3 ++
>>   fs/erofs/fscache.c | 95 +++++++++++++++++++++++++++++++++++++++++++---
>>   2 files changed, 93 insertions(+), 5 deletions(-)
>>
>> diff --git a/fs/erofs/data.c b/fs/erofs/data.c
>> index 8be60797ea2f..dbfafe358de4 100644
>> --- a/fs/erofs/data.c
>> +++ b/fs/erofs/data.c
>> @@ -391,6 +391,9 @@ static ssize_t erofs_file_read_iter(struct kiocb 
>> *iocb, struct iov_iter *to)
>>                iov_iter_alignment(to)) & blksize_mask)
>>               return -EINVAL;
>> +        if (erofs_is_fscache_mode(inode->i_sb))
>> +            return generic_file_read_iter(iocb, to);
>> +
>>           return iomap_dio_rw(iocb, to, &erofs_iomap_ops,
>>                       NULL, 0, NULL, 0);
>>       }
>> diff --git a/fs/erofs/fscache.c b/fs/erofs/fscache.c
>> index fda16eedafb5..f5a09b168539 100644
>> --- a/fs/erofs/fscache.c
>> +++ b/fs/erofs/fscache.c
>> @@ -35,6 +35,8 @@ struct erofs_fscache_io {
>>   struct erofs_fscache_rq {
>>       struct address_space    *mapping;    /* The mapping being 
>> accessed */
>> +    struct iov_iter        *iter;        /* dst buf for direct io */
>> +    struct completion    done;        /* for synced direct io */
>>       loff_t            start;        /* Start position */
>>       size_t            len;        /* Length of the request */
>>       size_t            submitted;    /* Length of submitted */
>> @@ -76,7 +78,11 @@ static void erofs_fscache_req_put(struct 
>> erofs_fscache_rq *req)
>>   {
>>       if (!refcount_dec_and_test(&req->ref))
>>           return;
>> -    erofs_fscache_req_complete(req);
>> +
>> +    if (req->iter)
>> +        complete(&req->done);
>> +    else
>> +        erofs_fscache_req_complete(req);
>>       kfree(req);
>>   }
>> @@ -88,6 +94,7 @@ static struct erofs_fscache_rq 
>> *erofs_fscache_req_alloc(struct address_space *ma
>>       if (!req)
>>           return NULL;
>>       req->mapping = mapping;
>> +    req->iter = NULL;
>>       req->start = start;
>>       req->len = len;
>>       refcount_set(&req->ref, 1);
>> @@ -253,6 +260,55 @@ static int erofs_fscache_meta_read_folio(struct 
>> file *data, struct folio *folio)
>>       return ret;
>>   }
>> +static int erofs_fscache_data_dio_read(struct erofs_fscache_rq *req)
>> +{
>> +    struct address_space *mapping = req->mapping;
>> +    struct inode *inode = mapping->host;
>> +    struct super_block *sb = inode->i_sb;
>> +    struct iov_iter *iter = req->iter;
>> +    struct erofs_fscache_io *io;
>> +    struct erofs_map_blocks map;
>> +    struct erofs_map_dev mdev;
>> +    loff_t pos = req->start + req->submitted;
>> +    size_t count;
>> +    int ret;
>> +
>> +    map.m_la = pos;
>> +    ret = erofs_map_blocks(inode, &map);
>> +    if (ret)
>> +        return ret;
>> +
>> +    count = req->len - req->submitted;
>> +    if (!(map.m_flags & EROFS_MAP_MAPPED)) {
>> +        iov_iter_zero(count, iter);
>> +        req->submitted += count;
>> +        return 0;
>> +    }
>> +
>> +    count = min_t(size_t, map.m_llen - (pos - map.m_la), count);
>> +    DBG_BUGON(!count || count % PAGE_SIZE);
>> +
>> +    mdev = (struct erofs_map_dev) {
>> +        .m_deviceid = map.m_deviceid,
>> +        .m_pa = map.m_pa,
>> +    };
>> +    ret = erofs_map_dev(sb, &mdev);
>> +    if (ret)
>> +        return ret;
>> +
>> +    io = erofs_fscache_req_io_alloc(req);
>> +    if (!io)
>> +        return -ENOMEM;
>> +
>> +    iov_iter_ubuf(&io->iter, ITER_DEST, iter->ubuf + 
>> iter->iov_offset, count);
>> +    ret = erofs_fscache_read_io_async(mdev.m_fscache->cookie, 
>> mdev.m_pa + (pos - map.m_la), io);
>> +    iov_iter_advance(iter, io->iter.iov_offset);
>> +    erofs_fscache_req_io_put(io);
>> +
>> +    req->submitted += count;
>> +    return ret;
>> +}
>> +
>>   static int erofs_fscache_data_read_slice(struct erofs_fscache_rq *req)
>>   {
>>       struct address_space *mapping = req->mapping;
>> @@ -324,12 +380,13 @@ static int erofs_fscache_data_read_slice(struct 
>> erofs_fscache_rq *req)
>>       return ret;
>>   }
>> -static int erofs_fscache_data_read(struct erofs_fscache_rq *req)
>> +static int erofs_fscache_data_read(struct erofs_fscache_rq *req, bool 
>> direct)
>>   {
>>       int ret;
>>       do {
>> -        ret = erofs_fscache_data_read_slice(req);
>> +        ret = (direct) ? erofs_fscache_data_dio_read(req)
>> +                : erofs_fscache_data_read_slice(req);
>>           if (ret)
>>               req->error = ret;
>>       } while (!ret && req->submitted < req->len);
>> @@ -348,7 +405,7 @@ static int erofs_fscache_read_folio(struct file 
>> *file, struct folio *folio)
>>           return -ENOMEM;
>>       }
>> -    ret = erofs_fscache_data_read(req);
>> +    ret = erofs_fscache_data_read(req, false);
>>       erofs_fscache_req_put(req);
>>       return ret;
>>   }
>> @@ -369,8 +426,35 @@ static void erofs_fscache_readahead(struct 
>> readahead_control *rac)
>>       while (readahead_folio(rac))
>>           ;
>> -    erofs_fscache_data_read(req);
>> +    erofs_fscache_data_read(req, false);
>> +    erofs_fscache_req_put(req);
>> +}
>> +
>> +static ssize_t erofs_fscache_directIO(struct kiocb *iocb, struct 
>> iov_iter *iter)
> 
> How about get rid of upper case names, e.g.
> using erofs_fscache_direct_io instead?
> 
ok, I'll refine the name in later submission.
> Thanks,
> Gao Xiang
> 
>> +{
>> +    struct file *file = iocb->ki_filp;
>> +    size_t count = iov_iter_count(iter);
>> +    struct erofs_fscache_rq *req;
>> +    struct completion *ctr;
>> +    ssize_t rsize;
>> +    int ret;
>> +
>> +    if (unlikely(iov_iter_rw(iter) == WRITE))
>> +        return -EROFS;
>> +
>> +    req = erofs_fscache_req_alloc(file->f_mapping, iocb->ki_pos, count);
>> +    if (!req)
>> +        return -ENOMEM;
>> +
>> +    req->iter = iter;
>> +    init_completion(&req->done);
>> +    ctr = &req->done;
>> +    ret = erofs_fscache_data_read(req, true);
>> +    rsize = (ret == 0) ? (ssize_t)req->submitted : ret;
>>       erofs_fscache_req_put(req);
>> +    wait_for_completion(ctr);
>> +
>> +    return rsize;
>>   }
>>   static const struct address_space_operations erofs_fscache_meta_aops 
>> = {
>> @@ -380,6 +464,7 @@ static const struct address_space_operations 
>> erofs_fscache_meta_aops = {
>>   const struct address_space_operations erofs_fscache_access_aops = {
>>       .read_folio = erofs_fscache_read_folio,
>>       .readahead = erofs_fscache_readahead,
>> +    .direct_IO = erofs_fscache_directIO,
>>   };
>>   static void erofs_fscache_domain_put(struct erofs_domain *domain)
