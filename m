Return-Path: <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>
X-Original-To: lists+linux-erofs@lfdr.de
Delivered-To: lists+linux-erofs@lfdr.de
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2404:9400:2:0:216:3eff:fee1:b9f1])
	by mail.lfdr.de (Postfix) with ESMTPS id 33375A01DFA
	for <lists+linux-erofs@lfdr.de>; Mon,  6 Jan 2025 04:04:13 +0100 (CET)
Received: from boromir.ozlabs.org (localhost [IPv6:::1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4YRJtJ6CvSz30TS
	for <lists+linux-erofs@lfdr.de>; Mon,  6 Jan 2025 14:04:08 +1100 (AEDT)
X-Original-To: linux-erofs@lists.ozlabs.org
Delivered-To: linux-erofs@lists.ozlabs.org
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip=115.124.30.133
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1736132647;
	cv=none; b=XLZpIzF3Ub3fl7vfKcY7N5zxyxI5G3QD8bHEiKXnLTJlqZXe76ghPy3s/qh5jODFEmfm67aBLi6vYHCMoq746v6W+5GiQbco9PqYOIqRIClZYBjdiqvaN+Vr0RNUEej0+0OCfqY9V7QcQiJ/TnwHEX3TPhNxbYYKuWBGOyybXjlKvpIC6xzqtGxGmTjNflHe8pvbQk5F48jmbWuYPGtzaw0NWR69fAbajApmwSXcKxVJStCiPRkC39f4hZHQVvIeoQhQL9vHF+yflcb1uam+eiwP5pQ+/Gvg2vK/vkHV88Y+XRZScMXqLqwrQ6u1yFgLf3LN+du/qwYHngrmHx5TdQ==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1736132647; c=relaxed/relaxed;
	bh=z0Zi3qWxO9zc/rGaZbLwgsgrRUiS5hv1pKIWmjNHuIQ=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=O/GMaQSEkDuwh0V0rCh8q7jy45nKYECmLh23OEuyOk64CDk+rHGHOMzI+sQ6XagM8oEkB8xkjwJP3QrIaK9VyQimaQrl57Rmfxj0m1OXFUQWEXCEiFx4xzREG4f+3QLHVKBIOK8z+qbXQ0aePAiw8kLuvCXSeskaAUzZQsL0GvHRrbsB4VYQFU4CwgfjrcmxReu4SCzYTBgQyxlN/rX2YXqem5V545QJlG0WomPYrYClFB4/sfM/e42NdpiKhhwfbTnYbBWpu8+WdIB4KNpD79d3fyhCWnbLQ1/Xn5iBxyf3bOLSi5DULOKRCMaR7fBNCyrEeVLAO647ZVR3wRwpSw==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com; dkim=pass (1024-bit key; unprotected) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.a=rsa-sha256 header.s=default header.b=yetgS7gg; dkim-atps=neutral; spf=pass (client-ip=115.124.30.133; helo=out30-133.freemail.mail.aliyun.com; envelope-from=hongzhen@linux.alibaba.com; receiver=lists.ozlabs.org) smtp.mailfrom=linux.alibaba.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (1024-bit key; unprotected) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.a=rsa-sha256 header.s=default header.b=yetgS7gg;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=linux.alibaba.com (client-ip=115.124.30.133; helo=out30-133.freemail.mail.aliyun.com; envelope-from=hongzhen@linux.alibaba.com; receiver=lists.ozlabs.org)
Received: from out30-133.freemail.mail.aliyun.com (out30-133.freemail.mail.aliyun.com [115.124.30.133])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4YRJtF14fbz2xps
	for <linux-erofs@lists.ozlabs.org>; Mon,  6 Jan 2025 14:04:02 +1100 (AEDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=linux.alibaba.com; s=default;
	t=1736132637; h=Message-ID:Date:MIME-Version:Subject:To:From:Content-Type;
	bh=z0Zi3qWxO9zc/rGaZbLwgsgrRUiS5hv1pKIWmjNHuIQ=;
	b=yetgS7ggDkQf0iOL7XeZNot+uGOHpplO/EKUUsCfhv90EF082QjrtEP4RmB5oNJNOlAIAUj9zaoTzmk99YjwZCwSF5mT41JMJWI6C2sCEA1qD5GVouHTl7UZMWuBD3JSJ8vsDxwBodlewCkuw370hdZ0rKcUhYKrdzZTMSRNFmo=
Received: from 30.15.201.70(mailfrom:hongzhen@linux.alibaba.com fp:SMTPD_---0WN-3pPS_1736132625 cluster:ay36)
          by smtp.aliyun-inc.com;
          Mon, 06 Jan 2025 11:03:55 +0800
Message-ID: <7801bdfb-3052-44f0-bbd0-c4352ccb1de9@linux.alibaba.com>
Date: Mon, 6 Jan 2025 11:03:45 +0800
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [RFC PATCH v5 2/4] erofs: introduce the page cache share feature
To: Gao Xiang <hsiangkao@linux.alibaba.com>, linux-erofs@lists.ozlabs.org
References: <20250105151208.3797385-1-hongzhen@linux.alibaba.com>
 <20250105151208.3797385-3-hongzhen@linux.alibaba.com>
 <b825b7dc-d4b0-46bb-a427-68eeeb3e0204@linux.alibaba.com>
From: Hongzhen Luo <hongzhen@linux.alibaba.com>
In-Reply-To: <b825b7dc-d4b0-46bb-a427-68eeeb3e0204@linux.alibaba.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-15.7 required=5.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,DKIM_VALID_EF,ENV_AND_HDR_SPF_MATCH,RCVD_IN_DNSWL_NONE,
	SPF_HELO_NONE,SPF_PASS,UNPARSEABLE_RELAY,USER_IN_DEF_DKIM_WL,
	USER_IN_DEF_SPF_WL autolearn=disabled version=4.0.0
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
Cc: linux-kernel@vger.kernel.org
Errors-To: linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org
Sender: "Linux-erofs" <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>


On 2025/1/6 10:27, Gao Xiang wrote:
>
>
> On 2025/1/5 23:12, Hongzhen Luo wrote:
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
>> phase, the file content is hashed and the hash value is stored in the
>> `trusted.erofs.fingerprint` extended attribute. Inodes of files with the
>> same `trusted.erofs.fingerprint` are mapped to the same anonymous inode
>> (indicated by the `ano_inode` field). When a read request occurs, the
>> anonymous inode serves as a "container" whose page cache is shared. The
>> actual operations involving the iomap are carried out by the original
>> inode which is mapped to the anonymous inode.
>>
>> Signed-off-by: Hongzhen Luo <hongzhen@linux.alibaba.com>
>> ---
>>   fs/erofs/Kconfig           |  10 ++
>>   fs/erofs/Makefile          |   1 +
>>   fs/erofs/internal.h        |   4 +
>>   fs/erofs/pagecache_share.c | 228 +++++++++++++++++++++++++++++++++++++
>>   fs/erofs/pagecache_share.h |  26 +++++
>>   fs/erofs/super.c           |  24 +++-
>>   6 files changed, 292 insertions(+), 1 deletion(-)
>>   create mode 100644 fs/erofs/pagecache_share.c
>>   create mode 100644 fs/erofs/pagecache_share.h
>>
>> diff --git a/fs/erofs/Kconfig b/fs/erofs/Kconfig
>> index 6ea60661fa55..3aa5f946b5f1 100644
>> --- a/fs/erofs/Kconfig
>> +++ b/fs/erofs/Kconfig
>> @@ -178,3 +178,13 @@ config EROFS_FS_PCPU_KTHREAD_HIPRI
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
>> index 4331d53c7109..d035c9063ef8 100644
>> --- a/fs/erofs/Makefile
>> +++ b/fs/erofs/Makefile
>> @@ -9,3 +9,4 @@ erofs-$(CONFIG_EROFS_FS_ZIP_DEFLATE) += 
>> decompressor_deflate.o
>>   erofs-$(CONFIG_EROFS_FS_ZIP_ZSTD) += decompressor_zstd.o
>>   erofs-$(CONFIG_EROFS_FS_BACKED_BY_FILE) += fileio.o
>>   erofs-$(CONFIG_EROFS_FS_ONDEMAND) += fscache.o
>> +erofs-$(CONFIG_EROFS_FS_PAGE_CACHE_SHARE) += pagecache_share.o
>> \ No newline at end of file
>> diff --git a/fs/erofs/internal.h b/fs/erofs/internal.h
>> index 47004eb89838..6c87621d86ba 100644
>> --- a/fs/erofs/internal.h
>> +++ b/fs/erofs/internal.h
>> @@ -280,6 +280,9 @@ struct erofs_inode {
>>           };
>>   #endif    /* CONFIG_EROFS_FS_ZIP */
>>       };
>> +#ifdef CONFIG_EROFS_FS_PAGE_CACHE_SHARE
>> +    struct inode *ano_inode;
>
> ano_inode has no extra meaning, we'd better to think out a meaningful 
> name.
>
>> +#endif
>>       /* the corresponding vfs inode */
>>       struct inode vfs_inode;
>>   };
>> @@ -376,6 +379,7 @@ extern const struct inode_operations erofs_dir_iops;
>>     extern const struct file_operations erofs_file_fops;
>>   extern const struct file_operations erofs_dir_fops;
>> +extern const struct file_operations erofs_pcshr_fops;
>>     extern const struct iomap_ops z_erofs_iomap_report_ops;
>>   diff --git a/fs/erofs/pagecache_share.c b/fs/erofs/pagecache_share.c
>> new file mode 100644
>> index 000000000000..703fd17c002c
>> --- /dev/null
>> +++ b/fs/erofs/pagecache_share.c
>> @@ -0,0 +1,228 @@
>> +// SPDX-License-Identifier: GPL-2.0-or-later
>> +/*
>> + * Copyright (C) 2024, Alibaba Cloud
>> + */
>> +#include <linux/xxhash.h>
>> +#include <linux/refcount.h>
>> +#include <linux/mount.h>
>> +#include <linux/mutex.h>
>> +#include "pagecache_share.h"
>> +#include "internal.h"
>> +#include "xattr.h"
>> +
>> +#define PCSHR_FPRT_IDX    4
>> +#define PCSHR_FPRT_NAME    "erofs.fingerprint"
>> +#define PCSHR_FPRT_MAXLEN (sizeof(size_t) + 1024)
>> +
>> +struct erofs_pcshr_counter {
>> +    struct mutex mutex;
>> +    struct kref ref;
>> +    struct vfsmount *mnt;
>> +};
>> +
>> +struct erofs_pcshr_private {
>> +    char fprt[PCSHR_FPRT_MAXLEN];
>> +};
>> +
>> +static struct erofs_pcshr_counter mnt_counter = {
>> +    .mutex = __MUTEX_INITIALIZER(mnt_counter.mutex),
>> +    .mnt = NULL,
>> +};
>> +
>> +static void erofs_pcshr_counter_release(struct kref *ref)
>> +{
>> +    struct erofs_pcshr_counter *counter = container_of(ref,
>> +            struct erofs_pcshr_counter, ref);
>> +
>> +    DBG_BUGON(!counter->mnt);
>> +    kern_unmount(counter->mnt);
>> +    counter->mnt = NULL;
>> +}
>> +
>> +int erofs_pcshr_init_mnt(void)
>> +{
>> +    int ret;
>> +    struct vfsmount *tmp;
>> +
>> +    mutex_lock(&mnt_counter.mutex);
>> +    if (!mnt_counter.mnt) {
>> +        tmp = kern_mount(&erofs_anon_fs_type);
>> +        if (IS_ERR(tmp)) {
>> +            ret = PTR_ERR(tmp);
>> +            goto out;
>> +        }
>> +        mnt_counter.mnt = tmp;
>> +        kref_init(&mnt_counter.ref);
>> +    } else
>> +        kref_get(&mnt_counter.ref);
>> +    ret = 0;
>> +out:
>> +    mutex_unlock(&mnt_counter.mutex);
>> +    return ret;
>> +}
>> +
>> +void erofs_pcshr_free_mnt(void)
>> +{
>> +    mutex_lock(&mnt_counter.mutex);
>> +    kref_put(&mnt_counter.ref, erofs_pcshr_counter_release);
>> +    mutex_unlock(&mnt_counter.mutex);
>> +}
>> +
>> +static int erofs_fprt_eq(struct inode *inode, void *data)
>> +{
>> +    struct erofs_pcshr_private *ano_private = inode->i_private;
>> +
>> +    return ano_private && memcmp(ano_private->fprt, data,
>> +            sizeof(size_t) + *(size_t *)data) == 0 ? 1 : 0;
>> +}
>> +
>> +static int erofs_fprt_set(struct inode *inode, void *data)
>> +{
>> +    struct erofs_pcshr_private *ano_private;
>> +
>> +    ano_private = kmalloc(sizeof(struct erofs_pcshr_private), 
>> GFP_KERNEL);
>> +    if (!ano_private)
>> +        return -ENOMEM;
>> +    memcpy(ano_private, data, sizeof(size_t) + *(size_t *)data);
>> +    inode->i_private = ano_private;
>> +    return 0;
>> +}
>> +
>> +int erofs_pcshr_fill_inode(struct inode *inode)
>> +{
>> +    struct erofs_inode *vi = EROFS_I(inode);
>> +    /* | fingerprint length | fingerprint content | */
>> +    char fprt[PCSHR_FPRT_MAXLEN];
>
> we shouldn't allocate too large space on stack.
>
>> +    struct inode *ano_inode;
>> +    unsigned long fprt_hash;
>> +    size_t fprt_len;
>> +    int ret = -1;
>> +
>> +    vi->ano_inode = NULL;
>> +    memset(fprt, 0, sizeof(fprt));
>> +    fprt_len = erofs_getxattr(inode, PCSHR_FPRT_IDX, PCSHR_FPRT_NAME,
>> +            fprt + sizeof(size_t), PCSHR_FPRT_MAXLEN);
>
> Now, I think it'd be better that users could have a way to configure
> the xattr key name.  Since in that way, we could reuse fsverity-like
> root hash digest likewise.
>
>> +    if (fprt_len > 0 && fprt_len <= PCSHR_FPRT_MAXLEN) {
>> +        *(size_t *)fprt = fprt_len;
>> +        fprt_hash = xxh32(fprt + sizeof(size_t), fprt_len, 0);
>> +        ano_inode = iget5_locked(mnt_counter.mnt->mnt_sb, fprt_hash,
>> +                     erofs_fprt_eq, erofs_fprt_set, fprt);
>> +        DBG_BUGON(!ano_inode);
>
> Why iget5_locked() won't return NULL?
>
>> +        vi->ano_inode = ano_inode;
>> +        if (ano_inode->i_state & I_NEW) {
>> +            if (erofs_inode_is_data_compressed(vi->datalayout))
>> +                ano_inode->i_mapping->a_ops = &z_erofs_aops;
>> +            else
>> +                ano_inode->i_mapping->a_ops = &erofs_aops;
>> +            ano_inode->i_size = inode->i_size;
>> +            unlock_new_inode(ano_inode);
>> +        }
>> +        ret = 0;
>> +    }
>> +    return ret;
>> +}
>> +
>> +void erofs_pcshr_free_inode(struct inode *inode)
>> +{redundant
>> +    struct erofs_inode *vi = EROFS_I(inode);
>> +
>> +    if (S_ISREG(inode->i_mode) &&  vi->ano_inode) {
>
> redundant space.
>
>> +        iput(vi->ano_inode);
>> +        vi->ano_inode = NULL;
>> +    }
>> +}
>> +
>> +static struct file *erofs_pcshr_alloc_file(struct file *file,
>> +                       struct inode *ano_inode)
>> +{
>> +    struct file *ano_file;
>> +
>> +    ano_file = alloc_file_pseudo(ano_inode, mnt_counter.mnt,
>> +            "[erofs_pcssh_f]", O_RDONLY, &erofs_file_fops);
>> +    if (IS_ERR(ano_file))
>> +        return ano_file;
>> +
>> +    file_ra_state_init(&ano_file->f_ra, file->f_mapping);
>> +    ano_file->private_data = EROFS_I(file_inode(file));
>> +    return ano_file;
>> +}
>> +
>> +static int erofs_pcshr_file_open(struct inode *inode, struct file 
>> *file)
>> +{
>> +    struct file *ano_file;
>> +    struct inode *ano_inode;
>> +    struct erofs_inode *vi = EROFS_I(inode);
>> +
>> +    ano_inode = vi->ano_inode;
>> +    if (!ano_inode)
>> +        return -EINVAL;
>> +
>> +    ano_file = erofs_pcshr_alloc_file(file, ano_inode);
>> +    if (IS_ERR(ano_file))
>> +        return PTR_ERR(ano_file);
>> +
>> +    ihold(ano_inode);
>> +    file->private_data = (void *)ano_file;
>> +    return 0;
>> +}
>> +
>> +static int erofs_pcshr_file_release(struct inode *inode, struct file 
>> *file)
>> +{
>> +    if (!file->private_data)
>> +        return -EINVAL;
>> +
>> +    fput((struct file *)file->private_data);
>> +    file->private_data = NULL;
>> +    return 0;
>> +}
>> +
>> +static ssize_t erofs_pcshr_file_read_iter(struct kiocb *iocb,
>> +                    struct iov_iter *to)
>> +{
>> +    struct inode __maybe_unused *inode = file_inode(iocb->ki_filp);
>> +    struct file *file, *ano_file;
>> +    struct kiocb ano_iocb;
>> +    ssize_t res;
>> +
>> +    if (!iov_iter_count(to))
>> +        return 0;
>> +#ifdef CONFIG_FS_DAX
>> +    if (IS_DAX(inode))
>> +        return erofs_file_fops.read_iter(iocb, to);
>> +#endif
>> +    if (iocb->ki_flags & IOCB_DIRECT)
>> +        return erofs_file_fops.read_iter(iocb, to);
>> +
>> +    memcpy(&ano_iocb, iocb, sizeof(struct kiocb));
>> +    file = iocb->ki_filp;
>> +    ano_file = file->private_data;
>> +    if (!ano_file)
>> +        return -EINVAL;
>> +    ano_iocb.ki_filp = ano_file;
>> +    res = filemap_read(&ano_iocb, to, 0);
>
> why we need to use this? what is "erofs_pcshr_file_read_iter" used for?
>

We need this because at this point, we need to switch to anonymous files 
so that `filemap_read` uses

the page cache of the anonymous inode. Files with the same fingerprint 
can share the same page cache

of the anonymous inode in this way.


Thanks,

Hongzhen Luo

> Thanks,
> Gao Xiang
