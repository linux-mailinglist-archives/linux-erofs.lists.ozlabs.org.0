Return-Path: <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>
X-Original-To: lists+linux-erofs@lfdr.de
Delivered-To: lists+linux-erofs@lfdr.de
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2404:9400:2:0:216:3eff:fee1:b9f1])
	by mail.lfdr.de (Postfix) with ESMTPS id C288B94572B
	for <lists+linux-erofs@lfdr.de>; Fri,  2 Aug 2024 06:47:46 +0200 (CEST)
Authentication-Results: lists.ozlabs.org;
	dkim=pass (1024-bit key; unprotected) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.a=rsa-sha256 header.s=default header.b=lrasW2dH;
	dkim-atps=neutral
Received: from boromir.ozlabs.org (localhost [IPv6:::1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4WZtcJ4ywgz3dL2
	for <lists+linux-erofs@lfdr.de>; Fri,  2 Aug 2024 14:47:44 +1000 (AEST)
X-Original-To: linux-erofs@lists.ozlabs.org
Delivered-To: linux-erofs@lists.ozlabs.org
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (1024-bit key; unprotected) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.a=rsa-sha256 header.s=default header.b=lrasW2dH;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=linux.alibaba.com (client-ip=115.124.30.110; helo=out30-110.freemail.mail.aliyun.com; envelope-from=hongzhen@linux.alibaba.com; receiver=lists.ozlabs.org)
Received: from out30-110.freemail.mail.aliyun.com (out30-110.freemail.mail.aliyun.com [115.124.30.110])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4WZtcC4XJJz30Wm
	for <linux-erofs@lists.ozlabs.org>; Fri,  2 Aug 2024 14:47:37 +1000 (AEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=linux.alibaba.com; s=default;
	t=1722574053; h=Message-ID:Date:MIME-Version:From:Subject:To:Content-Type;
	bh=Qi0abDuTpo3Z3z0qtgYfmSthuuUJFPRe99K6TENb7xE=;
	b=lrasW2dHkRRGTsxPG9dZGAgNVwp0OYuAQTVL23mvMJKzJVWvH0WVjL1MpaaCHt9nt8lD3vOXcsUgtPWkJ7dWZJ3/8s2nY4QGDlQijrF8LR2qF7GPgg8yQJa69+YNlJgy4o7fkB1I1yA13KU3YxYm20x6st1ezA+GquBjPk2+KYQ=
X-Alimail-AntiSpam: AC=PASS;BC=-1|-1;BR=01201311R551e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=maildocker-contentspam033045046011;MF=hongzhen@linux.alibaba.com;NM=1;PH=DS;RN=3;SR=0;TI=SMTPD_---0WBw4e9k_1722574051;
Received: from 30.221.128.228(mailfrom:hongzhen@linux.alibaba.com fp:SMTPD_---0WBw4e9k_1722574051)
          by smtp.aliyun-inc.com;
          Fri, 02 Aug 2024 12:47:31 +0800
Message-ID: <3f75be05-fb56-4d18-874b-7017b170a4cf@linux.alibaba.com>
Date: Fri, 2 Aug 2024 12:47:29 +0800
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
From: Hongzhen Luo <hongzhen@linux.alibaba.com>
Subject: Re: [PATCH RFC v2 1/2] erofs: introduce page cache share feature
To: Hongbo Li <lihongbo22@huawei.com>, linux-erofs@lists.ozlabs.org
References: <20240731080704.678259-1-hongzhen@linux.alibaba.com>
 <20240731080704.678259-2-hongzhen@linux.alibaba.com>
 <d783ea02-5834-40e5-87e7-5aaf8da63150@huawei.com>
In-Reply-To: <d783ea02-5834-40e5-87e7-5aaf8da63150@huawei.com>
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


On 2024/8/1 20:56, Hongbo Li wrote:
>
>
> On 2024/7/31 16:07, Hongzhen Luo wrote:
>> Currently, reading files with different paths (or names) but the same
>> content will consume multiple copies of the page cache, even if the
>> content of these page caches is the same. For example, reading identical
>> files (e.g., *.so files) from two different minor versions of container
>> images will cost multiple copies of the same page cache, since different
>> containers have different mount points. Therefore, sharing the page 
>> cache
>> for files with the same content can save memory.
>>
>> This introduces the page cache share feature in erofs. During the mkfs
>> phase, file content is hashed and the hash value is stored in the
>> `trusted.erofs.fingerprint` extended attribute. Inodes of files with the
>> same `trusted.erofs.fingerprint` are mapped to a list. One of these 
>> inodes
>> that in the list (the first inode in this implementation) is used to 
>> store
>> the actual content. In this way, a single copy of the selected inode's
>> page cache can serve read requests from several files mapped to it.
>>
>> Below is the memory usage for reading all files in two different minor
>> versions of container images:
>>
>> +-------------------+------------------+-------------+---------------+
>> |       Image       | Page Cache Share | Memory (MB) | Memory     |
>> |                   |                  |             | Reduction (%) |
>> +-------------------+------------------+-------------+---------------+
>> |                   |        No        |     241     | -       |
>> |       redis +------------------+-------------+---------------+
>> |   7.2.4 & 7.2.5   |        Yes       |     163     | 33%      |
>> +-------------------+------------------+-------------+---------------+
>> |                   |        No        |     872     | -       |
>> |      postgres +------------------+-------------+---------------+
>> |    16.1 & 16.2    |        Yes       |     630     | 28%      |
>> +-------------------+------------------+-------------+---------------+
>> |                   |        No        |     2771    | -       |
>> |     tensorflow +------------------+-------------+---------------+
>> |  1.11.0 & 2.11.1  |        Yes       |     2340    | 16%      |
>> +-------------------+------------------+-------------+---------------+
>> |                   |        No        |     926     | -       |
>> |       mysql +------------------+-------------+---------------+
>> |  8.0.11 & 8.0.12  |        Yes       |     735     | 21%      |
>> +-------------------+------------------+-------------+---------------+
>> |                   |        No        |     390     | -       |
>> |       nginx +------------------+-------------+---------------+
>> |   7.2.4 & 7.2.5   |        Yes       |     219     | 44%      |
>> +-------------------+------------------+-------------+---------------+
>> |       tomcat      |        No        |     924     | -       |
>> | 10.1.25 & 10.1.26 +------------------+-------------+---------------+
>> |                   |        Yes       |     474     | 49%      |
>> +-------------------+------------------+-------------+---------------+
>>
>> Additionally, the table below shows the runtime memory usage of the
>> container:
>>
>> +-------------------+------------------+-------------+---------------+
>> |       Image       | Page Cache Share | Memory (MB) | Memory     |
>> |                   |                  |             | Reduction (%) |
>> +-------------------+------------------+-------------+---------------+
>> |                   |        No        |      35     | -       |
>> |       redis +------------------+-------------+---------------+
>> |   7.2.4 & 7.2.5   |        Yes       |      28     | 20%      |
>> +-------------------+------------------+-------------+---------------+
>> |                   |        No        |     149     | -       |
>> |      postgres +------------------+-------------+---------------+
>> |    16.1 & 16.2    |        Yes       |      95     | 37%      |
>> +-------------------+------------------+-------------+---------------+
>> |                   |        No        |     1028    | -       |
>> |     tensorflow +------------------+-------------+---------------+
>> |  1.11.0 & 2.11.1  |        Yes       |     941     | 9%      |
>> +-------------------+------------------+-------------+---------------+
>> |                   |        No        |     155     | -       |
>> |       mysql +------------------+-------------+---------------+
>> |  8.0.11 & 8.0.12  |        Yes       |     139     | 11%      |
>> +-------------------+------------------+-------------+---------------+
>> |                   |        No        |      25     | -       |
>> |       nginx +------------------+-------------+---------------+
>> |   7.2.4 & 7.2.5   |        Yes       |      20     | 23%      |
>> +-------------------+------------------+-------------+---------------+
>> |       tomcat      |        No        |     186     | -       |
>> | 10.1.25 & 10.1.26 +------------------+-------------+---------------+
>> |                   |        Yes       |      98     | 48%      |
>> +-------------------+------------------+-------------+---------------+
>>
>> Signed-off-by: Hongzhen Luo <hongzhen@linux.alibaba.com>
>> ---
>> v2: Refactored the implementation.
>> v1: 
>> https://lore.kernel.org/all/20240722065355.1396365-4-hongzhen@linux.alibaba.com/
>> ---
>>   fs/erofs/Kconfig           |  10 ++
>>   fs/erofs/Makefile          |   1 +
>>   fs/erofs/internal.h        |   8 ++
>>   fs/erofs/pagecache_share.c | 189 +++++++++++++++++++++++++++++++++++++
>>   fs/erofs/pagecache_share.h |  15 +++
>>   5 files changed, 223 insertions(+)
>>   create mode 100644 fs/erofs/pagecache_share.c
>>   create mode 100644 fs/erofs/pagecache_share.h
>>
>> diff --git a/fs/erofs/Kconfig b/fs/erofs/Kconfig
>> index 7dcdce660cac..756a74de623c 100644
>> --- a/fs/erofs/Kconfig
>> +++ b/fs/erofs/Kconfig
>> @@ -158,3 +158,13 @@ config EROFS_FS_PCPU_KTHREAD_HIPRI
>>         at higher priority.
>>           If unsure, say N.
>> +
>> +config EROFS_FS_PAGE_CACHE_SHARE
>> +       bool "EROFS page cache share support"
>> +       depends on EROFS_FS
>> +       default n
>> +    help
>> +      This permits EROFS to share page cache for files with same
>> +      fingerprints.
>> +
>> +      If unsure, say N.
>> diff --git a/fs/erofs/Makefile b/fs/erofs/Makefile
>> index 097d672e6b14..f14a2ac0e561 100644
>> --- a/fs/erofs/Makefile
>> +++ b/fs/erofs/Makefile
>> @@ -8,3 +8,4 @@ erofs-$(CONFIG_EROFS_FS_ZIP_LZMA) += decompressor_lzma.o
>>   erofs-$(CONFIG_EROFS_FS_ZIP_DEFLATE) += decompressor_deflate.o
>>   erofs-$(CONFIG_EROFS_FS_ZIP_ZSTD) += decompressor_zstd.o
>>   erofs-$(CONFIG_EROFS_FS_ONDEMAND) += fscache.o
>> +erofs-$(CONFIG_EROFS_FS_PAGE_CACHE_SHARE) += pagecache_share.o
>> diff --git a/fs/erofs/internal.h b/fs/erofs/internal.h
>> index 736607675396..e3c17b28d1c5 100644
>> --- a/fs/erofs/internal.h
>> +++ b/fs/erofs/internal.h
>> @@ -288,6 +288,13 @@ struct erofs_inode {
>>           };
>>   #endif    /* CONFIG_EROFS_FS_ZIP */
>>       };
>> +#ifdef CONFIG_EROFS_FS_PAGE_CACHE_SHARE
>> +    struct list_head pcs_list;
>> +    struct rw_semaphore pcs_rwsem;
>> +    char *fprt;
>> +    int fprt_len;
>> +    unsigned long fprt_hash;
>> +#endif
>>       /* the corresponding vfs inode */
>>       struct inode vfs_inode;
>>   };
>> @@ -383,6 +390,7 @@ extern const struct inode_operations 
>> erofs_fast_symlink_iops;
>>   extern const struct inode_operations erofs_dir_iops;
>>     extern const struct file_operations erofs_file_fops;
>> +extern const struct file_operations erofs_pcs_file_fops;
>>   extern const struct file_operations erofs_dir_fops;
>>     extern const struct iomap_ops z_erofs_iomap_report_ops;
>> diff --git a/fs/erofs/pagecache_share.c b/fs/erofs/pagecache_share.c
>> new file mode 100644
>> index 000000000000..985dd2a38b5e
>> --- /dev/null
>> +++ b/fs/erofs/pagecache_share.c
>> @@ -0,0 +1,189 @@
>> +// SPDX-License-Identifier: GPL-2.0-or-later
>> +/*
>> + * Copyright (C) 2024, Alibaba Cloud
>> + */
>> +#include <linux/xarray.h>
>> +#include <linux/mutex.h>
>> +#include <linux/xxhash.h>
>> +#include "internal.h"
>> +#include "xattr.h"
>> +#include "pagecache_share.h"
>> +
>> +struct erofs_pcs_lhead {
>> +    struct mutex lmutex;
>> +    struct list_head list;
>> +};
>> +
>> +#define PCS_FPRT_IDX    4
>> +#define PCS_FPRT_NAME    "erofs.fingerprint"
> This macro should be "trusted.erofs.fingerprint"

Since we obtain the extended attribute value through erofs_getxattr() 
instead of vfs_getxattr(),

we only need to specify the index (PCS_FPRT_IDX) of the prefix and the 
name “erofs.fingerprint”.

>> +#define PCS_FPRT_MAXLEN 1024
>> +
>> +DEFINE_XARRAY(pcs_xarray);
>> +
>> +void erofs_pcs_fill_inode(struct inode *inode)
>> +{
>> +    struct erofs_inode *vi = EROFS_I(inode);
>> +    char fprt[PCS_FPRT_MAXLEN];
>> +
>> +    vi->fprt_len = erofs_getxattr(inode, PCS_FPRT_IDX, 
>> PCS_FPRT_NAME, fprt,
>> +                      PCS_FPRT_MAXLEN);
>> +    if (vi->fprt_len > 0 && vi->fprt_len <= PCS_FPRT_MAXLEN) {
>> +        vi->fprt = kmalloc(vi->fprt_len, GFP_KERNEL);
>> +        if (IS_ERR(vi->fprt)) {
>> +            vi->fprt_len = -1;
>> +            return;
>> +        }
>> +        memcpy(vi->fprt, fprt, vi->fprt_len);
> This could use strscpy or other string copy function to avoid random 
> garbage beyond a string's null terminator.
During the mkfs phase, file content is hashed (for example, by SHA256 ) 
and the hash value is stored in the

`trusted.erofs.fingerprint` extended attribute. The value of 
trusted.erofs.fingerprint may contain one or more bytes

with the value \0. When using strscpy to copy it, the content may be 
truncated, thus preventing the complete setting

of the `trusted.erofs.fingerprint` attribute value. This is not as expected.

>> +        vi->fprt_hash = xxh32(vi->fprt, vi->fprt_len, 0);
>> +    }
>> +}
>> +
>> +int erofs_pcs_add(struct inode *inode)
>> +{
>> +    struct erofs_inode *vi = EROFS_I(inode);
>> +    struct erofs_pcs_lhead *lst;
>> +
>> +    xa_lock(&pcs_xarray);
>> +    lst = xa_load(&pcs_xarray, vi->fprt_hash);
>> +    if (!lst) {
>> +        lst = kmalloc(sizeof(struct erofs_pcs_lhead), GFP_KERNEL);
>> +        if (!lst) {
>> +            xa_unlock(&pcs_xarray);
>> +            return -ENOMEM;
>> +        }
>> +        mutex_init(&lst->lmutex);
>> +        INIT_LIST_HEAD(&lst->list);
>> +        /* we have already held the xa_lock here */
>> +        __xa_store(&pcs_xarray, vi->fprt_hash, lst, GFP_KERNEL);
> Here, fprt_hash is calculated with xxh32, if hash conflict happend, 
> the fprt_hash will be same, and the value in xarray also will be 
> replaced. How can we avoid this case?

Each element in the xarray is a  list, with hash conflicting inodes 
being added to this list. When we need to fetch an inode for reading,

we select an inode with the same ->fprt from this list for reading. See 
erofs_pcs_get4read(). This is similar to iget5_locked().

>> +    }
>> +    xa_unlock(&pcs_xarray);
>> +
>> +    mutex_lock(&lst->lmutex);
>> +    list_add_tail(&vi->pcs_list, &lst->list);
>> +    mutex_unlock(&lst->lmutex);
>> +    return 0;
>> +}
>> +
>> +int erofs_pcs_remove(struct inode *inode)
>> +{
>> +    struct erofs_inode *vi = EROFS_I(inode);
>> +    struct erofs_pcs_lhead *lst = xa_load(&pcs_xarray, vi->fprt_hash);
> This operation should hold the xarray lock.

This might not be necessary. Because only the code in erofs_pcs_add():

     if (!lst) {
         lst = kmalloc(sizeof(struct erofs_pcs_lhead), GFP_KERNEL);
         if (!lst) {
             xa_unlock(&pcs_xarray);
             return -ENOMEM;
         }
         mutex_init(&lst->lmutex);
         INIT_LIST_HEAD(&lst->list);
         /* we have already held the xa_lock here */
         __xa_store(&pcs_xarray, vi->fprt_hash, lst, GFP_KERNEL);
     }

confilicts with the code in erofs_pcs_remove():

     if (list_empty(&lst->list)) {
         __xa_erase(&pcs_xarray, vi->fprt_hash);
         kfree(lst);
     }

And at this point, the list in xarray is not empty unless there is a 
problem with the code logic

(that is, erofs_pcs_add() and erofs_pcs_remove() not apear in pairs). So 
we can get the target

list just by `xa_load(&pcs_xarray, vi->fprt_hash)`.

>> +
>> +    if (!lst || list_empty(&lst->list))
>> +        return -EINVAL;
> This part should not happen, right? Unless there is a problem with the 
> code logic, and the remove operation seems unnecessary to return a value.
Thank you for the reminder. Yes, this part should not happen, because 
the list is not empty at this moment. I will clean it up in the next 
version.
>> +
>> +    mutex_lock(&lst->lmutex);
>> +    down_write(&vi->pcs_rwsem);
>> +    list_del(&vi->pcs_list);
>> +    up_write(&vi->pcs_rwsem);
>> +    mutex_unlock(&lst->lmutex);
>> +
>> +    xa_lock(&pcs_xarray);
>> +    if (list_empty(&lst->list)) {
>> +        __xa_erase(&pcs_xarray, vi->fprt_hash);
>> +        kfree(lst);
>> +    }
>> +    xa_unlock(&pcs_xarray);
>> +    return 0;
>> +}
>> +
>> +static struct inode *erofs_pcs_get4read(struct inode *inode)
>> +{
>> +    struct erofs_inode *vi = EROFS_I(inode), *pcs_inode = NULL, *p, 
>> *tmp;
> This should be locked xarray here? Otherwise, how can we prevent 
> another thread deleting from the pcs_xarray?

The element (a list) in pcs_xarray will be deleted when the list is 
empty. And the code in erofs_pcs_remove() will delete it:

     if (list_empty(&lst->list)) {
         __xa_erase(&pcs_xarray, vi->fprt_hash);
         kfree(lst);
     }

At this point, the list will not be empty. So we can use 
`xa_load(&pcs_xarray, vi->fprt_hash)`. Note that another thread will not

delete the pcs_xarray element because the list is not empty if the 
`erofs_pcs_add()` and `erofs_pcs_remove()` appear in pairs.

>> +    struct erofs_pcs_lhead *lst = xa_load(&pcs_xarray, vi->fprt_hash);
>> +
>> +    if (!lst || list_empty(&lst->list))
>> +        return ERR_PTR(-EINVAL);
>> +
>> +    mutex_lock(&lst->lmutex);
>> +    list_for_each_entry_safe(p, tmp, &lst->list, pcs_list) {
>> +        if (vi->fprt_len == p->fprt_len &&
>> +            !memcmp(vi->fprt, p->fprt, p->fprt_len)) {
> use string compare helper?
For the same reasons mentioned above.
>> +            pcs_inode = p;
>> +            break;
>> +        }
>> +    }
>> +    if (pcs_inode)
>> +        down_read(&pcs_inode->pcs_rwsem);
>> +    mutex_unlock(&lst->lmutex);
>> +
>> +    return pcs_inode ? &pcs_inode->vfs_inode : ERR_PTR(-EINVAL);
>> +}
>> +
>> +static int erofs_pcs_file_open(struct inode *inode, struct file *file)
>> +{
>> +    struct inode *pcs_inode;
>> +    struct file *ano_file;
>> +
>> +    pcs_inode = erofs_pcs_get4read(inode);
>> +    if (IS_ERR(pcs_inode))
>> +        return PTR_ERR(pcs_inode);
>> +
>> +    ano_file = alloc_file_pseudo(pcs_inode, file->f_path.mnt, 
>> "[erofs_pcs_f]",
>> +                     O_RDONLY, &erofs_file_fops);
>> +    file_ra_state_init(&ano_file->f_ra, file->f_mapping);
>> +    ihold(pcs_inode);
>> +    file->private_data = (void *)ano_file;
>> +    return 0;
>> +}
>> +
>> +static int erofs_pcs_file_release(struct inode *inode, struct file 
>> *file)
>> +{
>> +    struct inode *pcs_inode;
>> +
>> +    if (!file->private_data)
>> +        return -EINVAL;
>> +    pcs_inode = ((struct file *)file->private_data)->f_inode;
>> +    up_read(&EROFS_I(pcs_inode)->pcs_rwsem);
>> +    fput((struct file *)file->private_data);
>> +    file->private_data = NULL;
>> +    return 0;
>> +}
>> +
>> +static ssize_t erofs_pcs_file_read_iter(struct kiocb *iocb,
>> +                    struct iov_iter *to)
>> +{
>> +    struct file *file, *ano_file;
>> +    struct kiocb ano_iocb;
>> +    ssize_t res;
>> +
>> +    memcpy(&ano_iocb, iocb, sizeof(struct kiocb));
>> +    file = iocb->ki_filp;
>> +    ano_file = file->private_data;
>> +    if (!ano_file)
>> +        return -EINVAL;
>> +    ano_iocb.ki_filp = ano_file;
>> +    res = filemap_read(&ano_iocb, to, 0);
>> +    memcpy(iocb, &ano_iocb, sizeof(struct kiocb));
>> +    iocb->ki_filp = file;
>> +    file_accessed(file);
>> +    return res;
>> +}
>> +
>> +static vm_fault_t erofs_pcs_fault(struct vm_fault *vmf)
>> +{
>> +    return filemap_fault(vmf);
>> +}
> This helper is unnecessary. We could just assign the default fault 
> helper.
Sure, thanks.
>> +
>> +static const struct vm_operations_struct erofs_pcs_file_vm_ops = {
>> +    .fault = erofs_pcs_fault,
> If .map_pages not assigned, the fault around should not arouse.

I'm not quite sure about this part; I need to read the relevant code. 
However, the phenomenon I observed is that erofs_pcs_fault() was executed.

Thank you very much for the effort you put into carefully reviewing my code.

---

Hongzhen Luo

>> +};
>> +
>> +static int erofs_pcs_mmap(struct file *file, struct vm_area_struct 
>> *vma)
>> +{
>> +    struct file *ano_file = file->private_data;
>> +
>> +    vma_set_file(vma, ano_file);
>> +    vma->vm_ops = &erofs_pcs_file_vm_ops;
>> +    return 0;
>> +}
>> +
>> +const struct file_operations erofs_pcs_file_fops = {
>> +    .open        = erofs_pcs_file_open,
>> +    .llseek        = generic_file_llseek,
>> +    .read_iter    = erofs_pcs_file_read_iter,
>> +    .mmap        = erofs_pcs_mmap,
>> +    .release    = erofs_pcs_file_release,
>> +    .get_unmapped_area = thp_get_unmapped_area,
>> +    .splice_read    = filemap_splice_read,
>> +};
>> diff --git a/fs/erofs/pagecache_share.h b/fs/erofs/pagecache_share.h
>> new file mode 100644
>> index 000000000000..fb75ae3abd8a
>> --- /dev/null
>> +++ b/fs/erofs/pagecache_share.h
>> @@ -0,0 +1,15 @@
>> +/* SPDX-License-Identifier: GPL-2.0-or-later */
>> +/*
>> + * Copyright (C) 2024, Alibaba Cloud
>> + */
>> +#ifndef __EROFS_PAGECACHE_SHARE_H
>> +#define __EROFS_PAGECACHE_SHARE_H
>> +
>> +#include <linux/mutex.h>
>> +#include "internal.h"
>> +
>> +void erofs_pcs_fill_inode(struct inode *inode);
>> +int erofs_pcs_add(struct inode *inode);
>> +int erofs_pcs_remove(struct inode *inode);
>> +
>> +#endif
