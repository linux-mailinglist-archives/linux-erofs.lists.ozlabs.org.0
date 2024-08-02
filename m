Return-Path: <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>
X-Original-To: lists+linux-erofs@lfdr.de
Delivered-To: lists+linux-erofs@lfdr.de
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2404:9400:2:0:216:3eff:fee1:b9f1])
	by mail.lfdr.de (Postfix) with ESMTPS id 9269B945731
	for <lists+linux-erofs@lfdr.de>; Fri,  2 Aug 2024 06:50:30 +0200 (CEST)
Authentication-Results: lists.ozlabs.org;
	dkim=pass (1024-bit key; unprotected) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.a=rsa-sha256 header.s=default header.b=F7AGh6v2;
	dkim-atps=neutral
Received: from boromir.ozlabs.org (localhost [IPv6:::1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4WZtgS3Jxlz3dL2
	for <lists+linux-erofs@lfdr.de>; Fri,  2 Aug 2024 14:50:28 +1000 (AEST)
X-Original-To: linux-erofs@lists.ozlabs.org
Delivered-To: linux-erofs@lists.ozlabs.org
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (1024-bit key; unprotected) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.a=rsa-sha256 header.s=default header.b=F7AGh6v2;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=linux.alibaba.com (client-ip=115.124.30.98; helo=out30-98.freemail.mail.aliyun.com; envelope-from=hongzhen@linux.alibaba.com; receiver=lists.ozlabs.org)
Received: from out30-98.freemail.mail.aliyun.com (out30-98.freemail.mail.aliyun.com [115.124.30.98])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4WZtgN23jMz3c4l
	for <linux-erofs@lists.ozlabs.org>; Fri,  2 Aug 2024 14:50:23 +1000 (AEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=linux.alibaba.com; s=default;
	t=1722574220; h=Message-ID:Date:MIME-Version:Subject:To:From:Content-Type;
	bh=iT1Gb1/fXutb0eoDqTIXuXWrHKlOxX3peoQ1F2Cfe9c=;
	b=F7AGh6v2Gf2YI9Mb8pK2zJYWGugeQ4hJKLt/KGI+5bQx/JraHgZCKUsJVIdFt4SskDkElwbl53wZIBuuHUBOBzDearPhAWGxnHqZdCf9+8DNlTdaNNb+WPM+l1uo9a6C73ne2ughrJzUQ9Dd+PpKhi8cRd/OLp13AMIPiOzPxGg=
X-Alimail-AntiSpam: AC=PASS;BC=-1|-1;BR=01201311R121e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=maildocker-contentspam033037067111;MF=hongzhen@linux.alibaba.com;NM=1;PH=DS;RN=3;SR=0;TI=SMTPD_---0WBw4fd3_1722574218;
Received: from 30.221.128.228(mailfrom:hongzhen@linux.alibaba.com fp:SMTPD_---0WBw4fd3_1722574218)
          by smtp.aliyun-inc.com;
          Fri, 02 Aug 2024 12:50:19 +0800
Message-ID: <a40fb02b-02ac-4d66-8550-0750ba10346d@linux.alibaba.com>
Date: Fri, 2 Aug 2024 12:50:18 +0800
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH RFC v2 2/2] erofs: apply the page cache share feature
To: Hongbo Li <lihongbo22@huawei.com>, linux-erofs@lists.ozlabs.org
References: <20240731080704.678259-1-hongzhen@linux.alibaba.com>
 <20240731080704.678259-3-hongzhen@linux.alibaba.com>
 <5796c9ad-04ba-4226-ad28-75b265a4157b@huawei.com>
From: Hongzhen Luo <hongzhen@linux.alibaba.com>
In-Reply-To: <5796c9ad-04ba-4226-ad28-75b265a4157b@huawei.com>
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
Cc: linux-kernel@vger.kernel.org
Errors-To: linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org
Sender: "Linux-erofs" <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>


On 2024/8/1 20:43, Hongbo Li wrote:
>
>
> On 2024/7/31 16:07, Hongzhen Luo wrote:
>> This modifies relevant functions to apply the page cache
>> share feature.
>>
>> Signed-off-by: Hongzhen Luo <hongzhen@linux.alibaba.com>
>> ---
>> v2: Make adjustments based on the latest implementation.
>> v1: 
>> https://lore.kernel.org/all/20240722065355.1396365-5-hongzhen@linux.alibaba.com/
>> ---
>>   fs/erofs/inode.c | 23 +++++++++++++++++++++++
>>   fs/erofs/super.c | 23 +++++++++++++++++++++++
>>   2 files changed, 46 insertions(+)
>>
>> diff --git a/fs/erofs/inode.c b/fs/erofs/inode.c
>> index 5f6439a63af7..9f1e7332cff9 100644
>> --- a/fs/erofs/inode.c
>> +++ b/fs/erofs/inode.c
>> @@ -5,6 +5,7 @@
>>    * Copyright (C) 2021, Alibaba Cloud
>>    */
>>   #include "xattr.h"
>> +#include "pagecache_share.h"
>>     #include <trace/events/erofs.h>
>>   @@ -229,10 +230,22 @@ static int erofs_fill_inode(struct inode *inode)
>>       switch (inode->i_mode & S_IFMT) {
>>       case S_IFREG:
>>           inode->i_op = &erofs_generic_iops;
>> +#ifdef CONFIG_EROFS_FS_PAGE_CACHE_SHARE
>> +        erofs_pcs_fill_inode(inode);
>> +#endif
>>           if (erofs_inode_is_data_compressed(vi->datalayout))
>>               inode->i_fop = &generic_ro_fops;
>> +#ifdef CONFIG_EROFS_FS_PAGE_CACHE_SHARE
>> +        else {
> If the compress data is not support, the erofs_pcs_fill_inode should 
> fill the fingerprint in this branch only.
Sure, thanks.
>> +            if (vi->fprt_len > 0)
>> +                inode->i_fop = &erofs_pcs_file_fops;
>> +            else
>> +                inode->i_fop = &erofs_file_fops;
>> +        }
>> +#else
>>           else
>>               inode->i_fop = &erofs_file_fops;
>> +#endif
>>           break;
>>       case S_IFDIR:
>>           inode->i_op = &erofs_dir_iops;
>> @@ -325,6 +338,16 @@ struct inode *erofs_iget(struct super_block *sb, 
>> erofs_nid_t nid)
>>               return ERR_PTR(err);
>>           }
>>           unlock_new_inode(inode);
>> +#ifdef CONFIG_EROFS_FS_PAGE_CACHE_SHARE
>> +        if ((inode->i_mode & S_IFMT) == S_IFREG &&may be S_ISREG 
>> macro is better.
>
>> +            EROFS_I(inode)->fprt_len > 0) {
> Perhaps this logic need to be enclosed within unlock_new_inode.
Sure, thanks.
>> +            err = erofs_pcs_add(inode);
>> +            if (err) {
>> +                iget_failed(inode);
>> +                return ERR_PTR(err);
>> +            }
>> +        }
>> +#endif
>>       }
>>       return inode;
>>   }
>> diff --git a/fs/erofs/super.c b/fs/erofs/super.c
>> index 35268263aaed..a42e65ef7fc7 100644
>> --- a/fs/erofs/super.c
>> +++ b/fs/erofs/super.c
>> @@ -11,6 +11,7 @@
>>   #include <linux/fs_parser.h>
>>   #include <linux/exportfs.h>
>>   #include "xattr.h"
>> +#include "pagecache_share.h"
>>     #define CREATE_TRACE_POINTS
>>   #include <trace/events/erofs.h>
>> @@ -95,6 +96,10 @@ static struct inode *erofs_alloc_inode(struct 
>> super_block *sb)
>>         /* zero out everything except vfs_inode */
>>       memset(vi, 0, offsetof(struct erofs_inode, vfs_inode));
>> +#ifdef CONFIG_EROFS_FS_PAGE_CACHE_SHARE
>> +    INIT_LIST_HEAD(&vi->pcs_list);
>> +    init_rwsem(&vi->pcs_rwsem);
>> +#endif
>>       return &vi->vfs_inode;
>>   }
>>   @@ -108,6 +113,21 @@ static void erofs_free_inode(struct inode *inode)
>>       kmem_cache_free(erofs_inode_cachep, vi);
>>   }
>>   +#ifdef CONFIG_EROFS_FS_PAGE_CACHE_SHARE
>> +static void erofs_destroy_inode(struct inode *inode)
>> +{
>> +    struct erofs_inode *vi = EROFS_I(inode);
>> +
>> +    if ((inode->i_mode & S_IFMT) == S_IFREG &&
> using S_ISREG macro is better.

Thanks.

---

Hongzhen Luo

>> +        EROFS_I(inode)->fprt_len > 0) {
>> +        if (erofs_pcs_remove(inode))
>> +            erofs_err(inode->i_sb, "pcs: fail to remove inode.");
>> +        kfree(vi->fprt);
>> +        vi->fprt = NULL;
>> +    }
>> +}
>> +#endif
>> +
>>   static bool check_layout_compatibility(struct super_block *sb,
>>                          struct erofs_super_block *dsb)
>>   {
>> @@ -937,6 +957,9 @@ static int erofs_show_options(struct seq_file 
>> *seq, struct dentry *root)
>>   const struct super_operations erofs_sops = {
>>       .put_super = erofs_put_super,
>>       .alloc_inode = erofs_alloc_inode,
>> +#ifdef CONFIG_EROFS_FS_PAGE_CACHE_SHARE
>> +    .destroy_inode = erofs_destroy_inode,
>> +#endif
>>       .free_inode = erofs_free_inode,
>>       .statfs = erofs_statfs,
>>       .show_options = erofs_show_options,
