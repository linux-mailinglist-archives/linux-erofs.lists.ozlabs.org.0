Return-Path: <linux-erofs+bounces-1694-lists+linux-erofs=lfdr.de@lists.ozlabs.org>
X-Original-To: lists+linux-erofs@lfdr.de
Delivered-To: lists+linux-erofs@lfdr.de
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2404:9400:21b9:f100::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B03D3CFC3D8
	for <lists+linux-erofs@lfdr.de>; Wed, 07 Jan 2026 07:50:52 +0100 (CET)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4dmJZw67Tbz2yFq;
	Wed, 07 Jan 2026 17:50:48 +1100 (AEDT)
X-Original-To: linux-erofs@lists.ozlabs.org
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip=113.46.200.227
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1767768648;
	cv=none; b=G7SkyIUaOvW0wrQ7Yf9dKanY/yddNcEvJ6DtnMXaAQnJtFf8f/AMwkH8a1Qqrwxdk+GaSPHG8PpV3/vjGo/Vpu1L+ECUoR3IeM3mQQ5TiDc4fHTiPXT2h+xABHT694r7FtFxD5PICmCmohTm9WItX7JHL8bG5heWjSEW7o+AfdnrdzKNUH6j+iO05JSlT2T1mtbvrwhkQJ2y5ixt4G3gN6cORWmZe7BxKGKgkb9XlurFK1c0T/bPxyhN8akaUo93MXZivmqz7vLYc0q+jKaAyLQt5iHI1flQxqDwl87sXGLDuxuBnVqey/7UIBvB2Rj1IIHaNZZCNVnY7n2twnmuig==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1767768648; c=relaxed/relaxed;
	bh=zcA78h/25ZcOE+V2h5pq/ndroGIocBHBYMTcRCRbx5Q=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=nLGx06tN29BZCacjg0KrkgBELAbqFAFBu3LmGL1qAW+QNJ60Y478x2fqJcRzugHOwDr6ORXogd+BRSx0jicDFpmRJBJ7VXHgYXzgOYENOeTdExBlBkRbEPnp6P8hRoi9ZJ/GDUpty0TlS7m3szi99/0zFYe8oyCIz0FLXkLBHXJSlkvqb7lvjLg+iERvTLkf1xH84usFPdmSnstXt84LyLDOiIMpdMjVL/6YvslTd+hBbaD5v/HHcRI8cqAhQBf0KHROS31Cefg6utE8PWkN7MZas4ImvRGTcSJ1N5lQUct4hbA0vY4RFNGhlPUcwB1/SehYWDje53ShY8vysrpgAg==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; dkim=pass (1024-bit key; unprotected) header.d=huawei.com header.i=@huawei.com header.a=rsa-sha256 header.s=dkim header.b=ZsRk2j1D; dkim-atps=neutral; spf=pass (client-ip=113.46.200.227; helo=canpmsgout12.his.huawei.com; envelope-from=lihongbo22@huawei.com; receiver=lists.ozlabs.org) smtp.mailfrom=huawei.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (1024-bit key; unprotected) header.d=huawei.com header.i=@huawei.com header.a=rsa-sha256 header.s=dkim header.b=ZsRk2j1D;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=huawei.com (client-ip=113.46.200.227; helo=canpmsgout12.his.huawei.com; envelope-from=lihongbo22@huawei.com; receiver=lists.ozlabs.org)
Received: from canpmsgout12.his.huawei.com (canpmsgout12.his.huawei.com [113.46.200.227])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4dmJZv5jS5z2yFh
	for <linux-erofs@lists.ozlabs.org>; Wed, 07 Jan 2026 17:50:47 +1100 (AEDT)
dkim-signature: v=1; a=rsa-sha256; d=huawei.com; s=dkim;
	c=relaxed/relaxed; q=dns/txt;
	h=From;
	bh=zcA78h/25ZcOE+V2h5pq/ndroGIocBHBYMTcRCRbx5Q=;
	b=ZsRk2j1DfZzYuOUGL3eiFpxqKeKbwNFYdcEoE7y/u+lCDVk0kPJ+6rK1KDG7tf9NWOneR3fVN
	+Caa0PoKqh/0MJqeEO0hawqo4aeRNp+3WLkHniQat1xtRxI36EcD4FQTknFru9NvKKFQL8F6uud
	vMy7FAqu1+QhM7zDBvfowVg=
Received: from mail.maildlp.com (unknown [172.19.163.200])
	by canpmsgout12.his.huawei.com (SkyGuard) with ESMTPS id 4dmJWH2s4jznTY4;
	Wed,  7 Jan 2026 14:47:39 +0800 (CST)
Received: from kwepemr500015.china.huawei.com (unknown [7.202.195.162])
	by mail.maildlp.com (Postfix) with ESMTPS id B7C434055B;
	Wed,  7 Jan 2026 14:50:43 +0800 (CST)
Received: from [10.67.111.104] (10.67.111.104) by
 kwepemr500015.china.huawei.com (7.202.195.162) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.11; Wed, 7 Jan 2026 14:50:43 +0800
Message-ID: <06419d60-1fe9-4fcc-9d14-2751e12b6f7a@huawei.com>
Date: Wed, 7 Jan 2026 14:50:42 +0800
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
Subject: Re: [PATCH v12 08/10] erofs: support unencoded inodes for page cache
 share
Content-Language: en-US
To: Gao Xiang <hsiangkao@linux.alibaba.com>
CC: <djwong@kernel.org>, <amir73il@gmail.com>, <hch@lst.de>,
	<linux-fsdevel@vger.kernel.org>, <linux-erofs@lists.ozlabs.org>,
	<linux-kernel@vger.kernel.org>, Chao Yu <chao@kernel.org>, Christian Brauner
	<brauner@kernel.org>
References: <20251231090118.541061-1-lihongbo22@huawei.com>
 <20251231090118.541061-9-lihongbo22@huawei.com>
 <d31cd92b-56ba-4798-bc88-5bf4999a2437@linux.alibaba.com>
From: Hongbo Li <lihongbo22@huawei.com>
In-Reply-To: <d31cd92b-56ba-4798-bc88-5bf4999a2437@linux.alibaba.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 8bit
X-Originating-IP: [10.67.111.104]
X-ClientProxiedBy: kwepems500002.china.huawei.com (7.221.188.17) To
 kwepemr500015.china.huawei.com (7.202.195.162)
X-Spam-Status: No, score=-0.2 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS autolearn=disabled
	version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-25) on lists.ozlabs.org



On 2026/1/7 14:12, Gao Xiang wrote:
> 
> 
> On 2025/12/31 17:01, Hongbo Li wrote:
>> This patch adds inode page cache sharing functionality for unencoded
>> files.
>>
>> I conducted experiments in the container environment. Below is the
>> memory usage for reading all files in two different minor versions
>> of container images:
>>
>> +-------------------+------------------+-------------+---------------+
>> |       Image       | Page Cache Share | Memory (MB) |    Memory     |
>> |                   |                  |             | Reduction (%) |
>> +-------------------+------------------+-------------+---------------+
>> |                   |        No        |     241     |       -       |
>> |       redis       +------------------+-------------+---------------+
>> |   7.2.4 & 7.2.5   |        Yes       |     163     |      33%      |
>> +-------------------+------------------+-------------+---------------+
>> |                   |        No        |     872     |       -       |
>> |      postgres     +------------------+-------------+---------------+
>> |    16.1 & 16.2    |        Yes       |     630     |      28%      |
>> +-------------------+------------------+-------------+---------------+
>> |                   |        No        |     2771    |       -       |
>> |     tensorflow    +------------------+-------------+---------------+
>> |  2.11.0 & 2.11.1  |        Yes       |     2340    |      16%      |
>> +-------------------+------------------+-------------+---------------+
>> |                   |        No        |     926     |       -       |
>> |       mysql       +------------------+-------------+---------------+
>> |  8.0.11 & 8.0.12  |        Yes       |     735     |      21%      |
>> +-------------------+------------------+-------------+---------------+
>> |                   |        No        |     390     |       -       |
>> |       nginx       +------------------+-------------+---------------+
>> |   7.2.4 & 7.2.5   |        Yes       |     219     |      44%      |
>> +-------------------+------------------+-------------+---------------+
>> |       tomcat      |        No        |     924     |       -       |
>> | 10.1.25 & 10.1.26 +------------------+-------------+---------------+
>> |                   |        Yes       |     474     |      49%      |
>> +-------------------+------------------+-------------+---------------+
>>
>> Additionally, the table below shows the runtime memory usage of the
>> container:
>>
>> +-------------------+------------------+-------------+---------------+
>> |       Image       | Page Cache Share | Memory (MB) |    Memory     |
>> |                   |                  |             | Reduction (%) |
>> +-------------------+------------------+-------------+---------------+
>> |                   |        No        |      35     |       -       |
>> |       redis       +------------------+-------------+---------------+
>> |   7.2.4 & 7.2.5   |        Yes       |      28     |      20%      |
>> +-------------------+------------------+-------------+---------------+
>> |                   |        No        |     149     |       -       |
>> |      postgres     +------------------+-------------+---------------+
>> |    16.1 & 16.2    |        Yes       |      95     |      37%      |
>> +-------------------+------------------+-------------+---------------+
>> |                   |        No        |     1028    |       -       |
>> |     tensorflow    +------------------+-------------+---------------+
>> |  2.11.0 & 2.11.1  |        Yes       |     930     |      10%      |
>> +-------------------+------------------+-------------+---------------+
>> |                   |        No        |     155     |       -       |
>> |       mysql       +------------------+-------------+---------------+
>> |  8.0.11 & 8.0.12  |        Yes       |     132     |      15%      |
>> +-------------------+------------------+-------------+---------------+
>> |                   |        No        |      25     |       -       |
>> |       nginx       +------------------+-------------+---------------+
>> |   7.2.4 & 7.2.5   |        Yes       |      20     |      20%      |
>> +-------------------+------------------+-------------+---------------+
>> |       tomcat      |        No        |     186     |       -       |
>> | 10.1.25 & 10.1.26 +------------------+-------------+---------------+
>> |                   |        Yes       |      98     |      48%      |
>> +-------------------+------------------+-------------+---------------+
>>
>> Co-developed-by: Hongzhen Luo <hongzhen@linux.alibaba.com>
>> Signed-off-by: Hongzhen Luo <hongzhen@linux.alibaba.com>
>> Signed-off-by: Hongbo Li <lihongbo22@huawei.com>
>> ---
>>   fs/erofs/data.c     | 30 +++++++++++++++++++++++-------
>>   fs/erofs/inode.c    |  4 ++++
>>   fs/erofs/internal.h |  6 ++++++
>>   fs/erofs/ishare.c   | 32 ++++++++++++++++++++++++++++++++
>>   4 files changed, 65 insertions(+), 7 deletions(-)
>>
>> diff --git a/fs/erofs/data.c b/fs/erofs/data.c
>> index 71e23d91123d..5fc8e3ce0d9e 100644
>> --- a/fs/erofs/data.c
>> +++ b/fs/erofs/data.c
>> @@ -269,6 +269,7 @@ void erofs_onlinefolio_end(struct folio *folio, 
>> int err, bool dirty)
>>   struct erofs_iomap_iter_ctx {
>>       struct page *page;
>>       void *base;
>> +    struct inode *realinode;
>>   };
>>   static int erofs_iomap_begin(struct inode *inode, loff_t offset, 
>> loff_t length,
>> @@ -276,14 +277,15 @@ static int erofs_iomap_begin(struct inode 
>> *inode, loff_t offset, loff_t length,
>>   {
>>       struct iomap_iter *iter = container_of(iomap, struct iomap_iter, 
>> iomap);
>>       struct erofs_iomap_iter_ctx *ctx = iter->private;
>> -    struct super_block *sb = inode->i_sb;
>> +    struct inode *realinode = ctx ? ctx->realinode : inode;
>> +    struct super_block *sb = realinode->i_sb;
>>       struct erofs_map_blocks map;
>>       struct erofs_map_dev mdev;
>>       int ret;
>>       map.m_la = offset;
>>       map.m_llen = length;
>> -    ret = erofs_map_blocks(inode, &map);
>> +    ret = erofs_map_blocks(realinode, &map);
>>       if (ret < 0)
>>           return ret;
>> @@ -296,7 +298,7 @@ static int erofs_iomap_begin(struct inode *inode, 
>> loff_t offset, loff_t length,
>>           return 0;
>>       }
>> -    if (!(map.m_flags & EROFS_MAP_META) || 
>> !erofs_inode_in_metabox(inode)) {
>> +    if (!(map.m_flags & EROFS_MAP_META) || 
>> !erofs_inode_in_metabox(realinode)) {
>>           mdev = (struct erofs_map_dev) {
>>               .m_deviceid = map.m_deviceid,
>>               .m_pa = map.m_pa,
>> @@ -322,7 +324,7 @@ static int erofs_iomap_begin(struct inode *inode, 
>> loff_t offset, loff_t length,
>>               void *ptr;
>>               ptr = erofs_read_metabuf(&buf, sb, map.m_pa,
>> -                         erofs_inode_in_metabox(inode));
>> +                         erofs_inode_in_metabox(realinode));
>>               if (IS_ERR(ptr))
>>                   return PTR_ERR(ptr);
>>               iomap->inline_data = ptr;
>> @@ -379,30 +381,42 @@ int erofs_fiemap(struct inode *inode, struct 
>> fiemap_extent_info *fieinfo,
>>    */
>>   static int erofs_read_folio(struct file *file, struct folio *folio)
>>   {
>> +    struct inode *inode = folio_inode(folio);
>>       struct iomap_read_folio_ctx read_ctx = {
>>           .ops        = &iomap_bio_read_ops,
>>           .cur_folio    = folio,
>>       };
>> -    struct erofs_iomap_iter_ctx iter_ctx = {};
>> +    bool need_iput;
>> +    struct erofs_iomap_iter_ctx iter_ctx = {
>> +        .realinode    = erofs_real_inode(inode, &need_iput),
>> +    };
>>       trace_erofs_read_folio(folio, true);
>>       iomap_read_folio(&erofs_iomap_ops, &read_ctx, &iter_ctx);
>> +    if (need_iput)
>> +        iput(iter_ctx.realinode);
>>       return 0;
>>   }
>>   static void erofs_readahead(struct readahead_control *rac)
>>   {
>> +    struct inode *inode = rac->mapping->host;
>>       struct iomap_read_folio_ctx read_ctx = {
>>           .ops        = &iomap_bio_read_ops,
>>           .rac        = rac,
>>       };
>> -    struct erofs_iomap_iter_ctx iter_ctx = {};
>> +    bool need_iput;
>> +    struct erofs_iomap_iter_ctx iter_ctx = {
>> +        .realinode    = erofs_real_inode(inode, &need_iput),
>> +    };
>>       trace_erofs_readahead(rac->mapping->host, readahead_index(rac),
>>                       readahead_count(rac), true);
>>       iomap_readahead(&erofs_iomap_ops, &read_ctx, &iter_ctx);
>> +    if (need_iput)
>> +        iput(iter_ctx.realinode);
>>   }
>>   static sector_t erofs_bmap(struct address_space *mapping, sector_t 
>> block)
>> @@ -423,7 +437,9 @@ static ssize_t erofs_file_read_iter(struct kiocb 
>> *iocb, struct iov_iter *to)
>>           return dax_iomap_rw(iocb, to, &erofs_iomap_ops);
>>   #endif
>>       if ((iocb->ki_flags & IOCB_DIRECT) && inode->i_sb->s_bdev) {
>> -        struct erofs_iomap_iter_ctx iter_ctx = {};
>> +        struct erofs_iomap_iter_ctx iter_ctx = {
>> +            .realinode = inode,
>> +        };
>>           return iomap_dio_rw(iocb, to, &erofs_iomap_ops,
>>                       NULL, 0, &iter_ctx, 0);
>> diff --git a/fs/erofs/inode.c b/fs/erofs/inode.c
>> index bce98c845a18..8116738fe432 100644
>> --- a/fs/erofs/inode.c
>> +++ b/fs/erofs/inode.c
>> @@ -215,6 +215,10 @@ static int erofs_fill_inode(struct inode *inode)
>>       case S_IFREG:
>>           inode->i_op = &erofs_generic_iops;
>>           inode->i_fop = &erofs_file_fops;
>> +#ifdef CONFIG_EROFS_FS_PAGE_CACHE_SHARE
> 
> Is that unnecessary?
> 

Yeah, I will remove it in next version.

Thanks,
Hongbo

> It seems erofs_ishare_fill_inode() will return false if
> CONFIG_EROFS_FS_PAGE_CACHE_SHARE is undefined.
> 
> Otherwise it looks good to me,
> Reviewed-by: Gao Xiang <hsiangkao@linux.alibaba.com>
> 
> Thanks,
> Gao Xiang

