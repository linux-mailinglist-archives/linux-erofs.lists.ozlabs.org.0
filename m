Return-Path: <linux-erofs+bounces-1876-lists+linux-erofs=lfdr.de@lists.ozlabs.org>
X-Original-To: lists+linux-erofs@lfdr.de
Delivered-To: lists+linux-erofs@lfdr.de
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2404:9400:21b9:f100::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 8D040D2209E
	for <lists+linux-erofs@lfdr.de>; Thu, 15 Jan 2026 02:36:16 +0100 (CET)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4ds5DG16mFz2xqj;
	Thu, 15 Jan 2026 12:36:14 +1100 (AEDT)
X-Original-To: linux-erofs@lists.ozlabs.org
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip=113.46.200.219
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1768440974;
	cv=none; b=mfV6jW3skqDFf9mN8fS48N4bmKo4E3y8Px3sZU2ydtl2yv8AhKciVbGFd8hhoypi9R7J2W/o0RDbTlD+jVHZQpAJsWoCn2I5UtmxJgwidphmi/rg3Y38gBCIM5vu8/JrQ5+XUnSRfblSdKX2+zxiiivpAx50zfJNBEuYgPNcy4z/sUnGCDS+O+zgKoCnyFxrBrEvHSEqFGTUpvl6jU4bxlo2ThZAt2Jhy/7dJa5EXQueioDr+d2unIjQRBUJpmIxbH8H9h6N6KG9lP40OFvdlrqZsbnricArYO1Sn1Y2DGHFGgNczFCsVlOqGZqTXpBIUBVtyybS/qv3jtXyzF5mzg==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1768440974; c=relaxed/relaxed;
	bh=63L59MWlYvf8NPePrI0+yVoNuGGGBNGasjBzGUBsKy8=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=ezsZZssdJaebqfv9msryqhU7DsdmuXgsQmcjskaEkSDM2tJIIaF2hoDZX0I7EdEL4gDvkiPmP+bzAfnFAGFYxW4/9PJZZy6i+M5X9wNG/VwenVvP6J4WD8VdLjhZNdnJbFPLkdPC1/WiOvSFYQk8svEl1cYd2ocIuheAugDHy5uqtU6/kSJxoF8QHeKIkiYZMbXYKo58067py4VU9SkBM0E3JzyQv8WUZtNAnKCSNLaiBfRqLVyTwMji7wXHQVFkZa9Wol/caz2k78pppghYFXPmouKtfhE9cc+/l8eFqGBuJRAfl1PApcLbX9gakRCchbRdqqTSoeCCl0mIYK5Vgw==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; dkim=pass (1024-bit key; unprotected) header.d=huawei.com header.i=@huawei.com header.a=rsa-sha256 header.s=dkim header.b=5Aqrc6hM; dkim-atps=neutral; spf=pass (client-ip=113.46.200.219; helo=canpmsgout04.his.huawei.com; envelope-from=lihongbo22@huawei.com; receiver=lists.ozlabs.org) smtp.mailfrom=huawei.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (1024-bit key; unprotected) header.d=huawei.com header.i=@huawei.com header.a=rsa-sha256 header.s=dkim header.b=5Aqrc6hM;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=huawei.com (client-ip=113.46.200.219; helo=canpmsgout04.his.huawei.com; envelope-from=lihongbo22@huawei.com; receiver=lists.ozlabs.org)
Received: from canpmsgout04.his.huawei.com (canpmsgout04.his.huawei.com [113.46.200.219])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4ds5DC3c8Vz2xHW
	for <linux-erofs@lists.ozlabs.org>; Thu, 15 Jan 2026 12:36:10 +1100 (AEDT)
dkim-signature: v=1; a=rsa-sha256; d=huawei.com; s=dkim;
	c=relaxed/relaxed; q=dns/txt;
	h=From;
	bh=63L59MWlYvf8NPePrI0+yVoNuGGGBNGasjBzGUBsKy8=;
	b=5Aqrc6hMyfywSV+uvMIIpEAmEvd64pc8GcZzEaUVBFMh441qIl4iIPugyvygZGyfajbB1R1E1
	Z4xPvTKZL8RdtDb1Ouqagp8120iU3svliTy+wjVZkJB7V1dFHu04kvDM7UAPug5egobgG4pPlHC
	o8fYXWROchvABb1wfGodbAM=
Received: from mail.maildlp.com (unknown [172.19.163.0])
	by canpmsgout04.his.huawei.com (SkyGuard) with ESMTPS id 4ds58B1nPkz1prmM;
	Thu, 15 Jan 2026 09:32:42 +0800 (CST)
Received: from kwepemr500015.china.huawei.com (unknown [7.202.195.162])
	by mail.maildlp.com (Postfix) with ESMTPS id 2EE6140537;
	Thu, 15 Jan 2026 09:36:04 +0800 (CST)
Received: from [10.67.111.104] (10.67.111.104) by
 kwepemr500015.china.huawei.com (7.202.195.162) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.11; Thu, 15 Jan 2026 09:36:03 +0800
Message-ID: <4152e93b-3f7d-4861-aad9-b7dc1ef71470@huawei.com>
Date: Thu, 15 Jan 2026 09:36:02 +0800
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
Subject: Re: [PATCH v14 08/10] erofs: support unencoded inodes for page cache
 share
Content-Language: en-US
To: Gao Xiang <hsiangkao@linux.alibaba.com>
CC: <djwong@kernel.org>, <amir73il@gmail.com>, <hch@lst.de>,
	<linux-fsdevel@vger.kernel.org>, <linux-erofs@lists.ozlabs.org>,
	<linux-kernel@vger.kernel.org>, Chao Yu <chao@kernel.org>, Christian Brauner
	<brauner@kernel.org>
References: <20260109102856.598531-1-lihongbo22@huawei.com>
 <20260109102856.598531-9-lihongbo22@huawei.com>
 <2d33cc2f-8188-4e62-b0be-bf985237bf24@linux.alibaba.com>
From: Hongbo Li <lihongbo22@huawei.com>
In-Reply-To: <2d33cc2f-8188-4e62-b0be-bf985237bf24@linux.alibaba.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 8bit
X-Originating-IP: [10.67.111.104]
X-ClientProxiedBy: kwepems500002.china.huawei.com (7.221.188.17) To
 kwepemr500015.china.huawei.com (7.202.195.162)
X-Spam-Status: No, score=-0.2 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS autolearn=disabled
	version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-25) on lists.ozlabs.org

Hi,Xiang

On 2026/1/14 22:51, Gao Xiang wrote:
> 
> 
> On 2026/1/9 18:28, Hongbo Li wrote:
>> This patch adds inode page cache sharing functionality for unencoded
>> files.
>>
>> I conducted experiments in the container environment. Below is the

...
>>               iomap->inline_data = ptr;
>> @@ -383,11 +385,16 @@ static int erofs_read_folio(struct file *file, 
>> struct folio *folio)
>>           .ops        = &iomap_bio_read_ops,
>>           .cur_folio    = folio,
>>       };
>> -    struct erofs_iomap_iter_ctx iter_ctx = {};
>> +    bool need_iput;
>> +    struct erofs_iomap_iter_ctx iter_ctx = {
>> +        .realinode = erofs_real_inode(folio_inode(folio), &need_iput),
>> +    };
>> -    trace_erofs_read_folio(folio, true);
>> +    trace_erofs_read_folio(iter_ctx.realinode, folio, true);
>>       iomap_read_folio(&erofs_iomap_ops, &read_ctx, &iter_ctx);
>> +    if (need_iput)
>> +        iput(iter_ctx.realinode);
>>       return 0;
>>   }
>> @@ -397,12 +404,17 @@ static void erofs_readahead(struct 
>> readahead_control *rac)
>>           .ops        = &iomap_bio_read_ops,
>>           .rac        = rac,
>>       };
>> -    struct erofs_iomap_iter_ctx iter_ctx = {};
>> +    bool need_iput;
>> +    struct erofs_iomap_iter_ctx iter_ctx = {
>> +        .realinode = erofs_real_inode(rac->mapping->host, &need_iput),
>> +    };
>> -    trace_erofs_readahead(rac->mapping->host, readahead_index(rac),
>> +    trace_erofs_readahead(iter_ctx.realinode, readahead_index(rac),
>>                       readahead_count(rac), true);
> 
> Is it possible to add a commit to update the tracepoints
> to add the new realinode first?

Yeah, so should we put the update on trace_erofs_read_folio and 
trace_erofs_readahead in a single patch after "[PATCH v14 03/10] fs: 
Export alloc_empty_backing_file"?

  Since the first two patches in this series has merged in vfs tree 
(thanks Christian), should we reorder the left patches?

Thanks,
Hongbo


> 
> Also please fix the indentation in that commit together.
> 
>>       iomap_readahead(&erofs_iomap_ops, &read_ctx, &iter_ctx);
>> +    if (need_iput)
>> +        iput(iter_ctx.realinode);
>>   }
>>   static sector_t erofs_bmap(struct address_space *mapping, sector_t 
>> block)
>> @@ -423,7 +435,9 @@ static ssize_t erofs_file_read_iter(struct kiocb 

...
>>   }
>>   const struct address_space_operations erofs_fileio_aops = {
>> diff --git a/fs/erofs/inode.c b/fs/erofs/inode.c
>> index bce98c845a18..52179b706b5b 100644
>> --- a/fs/erofs/inode.c
>> +++ b/fs/erofs/inode.c
>> @@ -215,6 +215,8 @@ static int erofs_fill_inode(struct inode *inode)
>>       case S_IFREG:
>>           inode->i_op = &erofs_generic_iops;
>>           inode->i_fop = &erofs_file_fops;
>> +        if (erofs_ishare_fill_inode(inode))
>> +            inode->i_fop = &erofs_ishare_fops;
> 
>          inode->i_fop = erofs_ishare_fill_inode(inode) ?
>              &erofs_ishare_fops : &erofs_file_fops;

Ok, will update.

> 
> Otherwise it looks good to me.
> 
> Thanks,
> Gao Xiang

