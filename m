Return-Path: <linux-erofs+bounces-1780-lists+linux-erofs=lfdr.de@lists.ozlabs.org>
X-Original-To: lists+linux-erofs@lfdr.de
Delivered-To: lists+linux-erofs@lfdr.de
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2404:9400:21b9:f100::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 585C7D0770F
	for <lists+linux-erofs@lfdr.de>; Fri, 09 Jan 2026 07:48:11 +0100 (CET)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4dnXQw6hCjz2xQ1;
	Fri, 09 Jan 2026 17:48:08 +1100 (AEDT)
X-Original-To: linux-erofs@lists.ozlabs.org
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip=113.46.200.217
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1767941288;
	cv=none; b=oKsRIRLmH4JFTaSrX8FI60pIB9En+lQ7sq/cZeiuHLwGbN2V6ScEFhLhiL5aN2+gQ/AfdPsANF0voprvG/+kQuCTIzqA6B02X3S7gdZPiDa6gIg3Qu3MZqsNYCgXmYzZ2At1J58ut+ukeW8UKwgpgiKnW2H23AG6pjWy4FKqbJpP1iM0cfgXP4BboOkyGGGCnB71tSgm/94sr9YU8UX7t9RsOKzxq6h7j/ALeJCJqiO8X+9nT2IcPZWBMQi8X+IcCcMtwUSkhpBUPX61JDf0/qR4KCWzFpkM4JluThTd4k+NPkifXTdDuVnTjKd1LQ0PLfqMW9ZykxzdU3ttBWao9w==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1767941288; c=relaxed/relaxed;
	bh=mOPwqnV5FlXCQydFh2PjnmkFhGz9MCnltBvnC1CKwVU=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=eABKY1jjE1yNTKN9F4v7JWvCGKDqMtWVA/S5WkPVATEv3Vy3BICp+KQrrg8RDvxIJyP8LkirGYm3mRX9vW22Eou8spraSWULM3bmeqMDMg+WN58J/1oTLvSJ6vA44hUPUWiQLo0rPHBYLiwsVzZWQSs7PanbEDcbHvUjWek4y3wj20cLHfR/cWjWt+6mCXZ0VGG0Tte2St1RXh3IwCzBXwOkJsCaixbktvcjGlfqmBFowNUMr96oh2P6w2tJKzFmtlooqxZ9jrWNvEpvWR+rkUWa707fETLYtBUTdQqIPLbcem2huWSISZYn8UmGz2yal3XbnsZlUZ8bEC/oFMBpjQ==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; dkim=pass (1024-bit key; unprotected) header.d=huawei.com header.i=@huawei.com header.a=rsa-sha256 header.s=dkim header.b=XsSqouvs; dkim-atps=neutral; spf=pass (client-ip=113.46.200.217; helo=canpmsgout02.his.huawei.com; envelope-from=lihongbo22@huawei.com; receiver=lists.ozlabs.org) smtp.mailfrom=huawei.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (1024-bit key; unprotected) header.d=huawei.com header.i=@huawei.com header.a=rsa-sha256 header.s=dkim header.b=XsSqouvs;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=huawei.com (client-ip=113.46.200.217; helo=canpmsgout02.his.huawei.com; envelope-from=lihongbo22@huawei.com; receiver=lists.ozlabs.org)
Received: from canpmsgout02.his.huawei.com (canpmsgout02.his.huawei.com [113.46.200.217])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4dnXQs4mNVz2xGF
	for <linux-erofs@lists.ozlabs.org>; Fri, 09 Jan 2026 17:48:03 +1100 (AEDT)
dkim-signature: v=1; a=rsa-sha256; d=huawei.com; s=dkim;
	c=relaxed/relaxed; q=dns/txt;
	h=From;
	bh=mOPwqnV5FlXCQydFh2PjnmkFhGz9MCnltBvnC1CKwVU=;
	b=XsSqouvsJmqBHHG2Jw/5QJMwqEMStH2JGYsF+JHSMvEMFe6+Jmvf2JOHACkF/E521RMDx1zBj
	Yo92csrFF0AOgJkS7pLqAfZ5lZQzeHheVXl9TFwxRcw09ziHa1QZWC19dcx/XFdTcGrjCFOCjYo
	mD5dOyACH6WlbLcj00lVqA4=
Received: from mail.maildlp.com (unknown [172.19.163.0])
	by canpmsgout02.his.huawei.com (SkyGuard) with ESMTPS id 4dnXLY3Lj9zcZyH;
	Fri,  9 Jan 2026 14:44:21 +0800 (CST)
Received: from kwepemr500015.china.huawei.com (unknown [7.202.195.162])
	by mail.maildlp.com (Postfix) with ESMTPS id B52D54056E;
	Fri,  9 Jan 2026 14:47:56 +0800 (CST)
Received: from [10.67.111.104] (10.67.111.104) by
 kwepemr500015.china.huawei.com (7.202.195.162) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.11; Fri, 9 Jan 2026 14:47:56 +0800
Message-ID: <336e9041-7381-4073-b533-bfcb32d6485e@huawei.com>
Date: Fri, 9 Jan 2026 14:47:55 +0800
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
Subject: Re: [PATCH v13 07/10] erofs: introduce the page cache share feature
To: Gao Xiang <hsiangkao@linux.alibaba.com>
CC: <djwong@kernel.org>, <amir73il@gmail.com>, <hch@lst.de>,
	<linux-fsdevel@vger.kernel.org>, <linux-erofs@lists.ozlabs.org>,
	<linux-kernel@vger.kernel.org>, <brauner@kernel.org>, <chao@kernel.org>
References: <20260109030140.594936-1-lihongbo22@huawei.com>
 <20260109030140.594936-8-lihongbo22@huawei.com>
 <8ed8ef13-e818-42e3-bece-2af1af238b62@linux.alibaba.com>
Content-Language: en-US
From: Hongbo Li <lihongbo22@huawei.com>
In-Reply-To: <8ed8ef13-e818-42e3-bece-2af1af238b62@linux.alibaba.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 8bit
X-Originating-IP: [10.67.111.104]
X-ClientProxiedBy: kwepems500002.china.huawei.com (7.221.188.17) To
 kwepemr500015.china.huawei.com (7.202.195.162)
X-Spam-Status: No, score=-0.2 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS autolearn=disabled
	version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-25) on lists.ozlabs.org

Hi, Xiang

On 2026/1/9 13:50, Gao Xiang wrote:
> 
> 
> On 2026/1/9 11:01, Hongbo Li wrote:
>> From: Hongzhen Luo <hongzhen@linux.alibaba.com>
>>
>> Currently, reading files with different paths (or names) but the same
>> content will consume multiple copies of the page cache, even if the
>> content of these page caches is the same. For example, reading
>> identical files (e.g., *.so files) from two different minor versions of
>> container images will cost multiple copies of the same page cache,
>> since different containers have different mount points. Therefore,
>> sharing the page cache for files with the same content can save memory.
>>
>> This introduces the page cache share feature in erofs. It allocate a
>> deduplicated inode and use its page cache as shared. Reads for files
>> with identical content will ultimately be routed to the page cache of
>> the deduplicated inode. In this way, a single page cache satisfies
>> multiple read requests for different files with the same contents.
>>
>> We introduce inode_share mount option to enable the page sharing mode
>> during mounting.
>>
>> Signed-off-by: Hongzhen Luo <hongzhen@linux.alibaba.com>
>> Signed-off-by: Hongbo Li <lihongbo22@huawei.com>
>> ---
>>   Documentation/filesystems/erofs.rst |   5 +
>>   fs/erofs/Makefile                   |   1 +
>>   fs/erofs/internal.h                 |  31 ++++++
>>   fs/erofs/ishare.c                   | 161 ++++++++++++++++++++++++++++
>>   fs/erofs/super.c                    |  53 ++++++++-
>>   fs/erofs/xattr.c                    |  33 ++++++
>>   fs/erofs/xattr.h                    |   3 +
>>   7 files changed, 285 insertions(+), 2 deletions(-)
>>   create mode 100644 fs/erofs/ishare.c
>>
>> diff --git a/Documentation/filesystems/erofs.rst 
>> b/Documentation/filesystems/erofs.rst
>> index 08194f194b94..27d3caa3c73c 100644
>> --- a/Documentation/filesystems/erofs.rst
>> +++ b/Documentation/filesystems/erofs.rst
>> @@ -128,7 +128,12 @@ device=%s              Specify a path to an extra 
>> device to be used together.
>>   fsid=%s                Specify a filesystem image ID for Fscache 
>> back-end.
>>   domain_id=%s           Specify a domain ID in fscache mode so that 
>> different images
>>                          with the same blobs under a given domain ID 
>> can share storage.
>> +                       Also used for inode page sharing mode which 
>> defines a sharing
>> +                       domain.
>>   fsoffset=%llu          Specify block-aligned filesystem offset for 
>> the primary device.
>> +inode_share            Enable inode page sharing for this 
>> filesystem.  Inodes with
>> +                       identical content within the same domain ID 
>> can share the
>> +                       page cache.
>>   ===================    
>> =========================================================
>>   Sysfs Entries
>> diff --git a/fs/erofs/Makefile b/fs/erofs/Makefile
>> index 549abc424763..a80e1762b607 100644
>> --- a/fs/erofs/Makefile
>> +++ b/fs/erofs/Makefile
>> @@ -10,3 +10,4 @@ erofs-$(CONFIG_EROFS_FS_ZIP_ZSTD) += 
>> decompressor_zstd.o
>>   erofs-$(CONFIG_EROFS_FS_ZIP_ACCEL) += decompressor_crypto.o
>>   erofs-$(CONFIG_EROFS_FS_BACKED_BY_FILE) += fileio.o
>>   erofs-$(CONFIG_EROFS_FS_ONDEMAND) += fscache.o
>> +erofs-$(CONFIG_EROFS_FS_PAGE_CACHE_SHARE) += ishare.o
>> diff --git a/fs/erofs/internal.h b/fs/erofs/internal.h
>> index ec79e8b44d3b..6ef1cdd9d651 100644
>> --- a/fs/erofs/internal.h
>> +++ b/fs/erofs/internal.h
>> @@ -179,6 +179,7 @@ struct erofs_sb_info {
>>   #define EROFS_MOUNT_DAX_ALWAYS        0x00000040
>>   #define EROFS_MOUNT_DAX_NEVER        0x00000080
>>   #define EROFS_MOUNT_DIRECT_IO        0x00000100
>> +#define EROFS_MOUNT_INODE_SHARE        0x00000200
>>   #define clear_opt(opt, option)    ((opt)->mount_opt &= 
>> ~EROFS_MOUNT_##option)
>>   #define set_opt(opt, option)    ((opt)->mount_opt |= 
>> EROFS_MOUNT_##option)
>> @@ -269,6 +270,11 @@ static inline u64 erofs_nid_to_ino64(struct 
>> erofs_sb_info *sbi, erofs_nid_t nid)
>>   /* default readahead size of directories */
>>   #define EROFS_DIR_RA_BYTES    16384
>> +struct erofs_inode_fingerprint {
>> +    u8 *opaque;
>> +    int size;
>> +};
>> +
>>   struct erofs_inode {
>>       erofs_nid_t nid;
>> @@ -304,6 +310,18 @@ struct erofs_inode {
>>           };
>>   #endif    /* CONFIG_EROFS_FS_ZIP */
>>       };
>> +#ifdef CONFIG_EROFS_FS_PAGE_CACHE_SHARE
>> +    struct list_head ishare_list;
>> +    union {
>> +        /* for each anon shared inode */
>> +        struct {
>> +            struct erofs_inode_fingerprint fingerprint;
>> +            spinlock_t ishare_lock;
>> +        };
>> +        /* for each real inode */
>> +        struct inode *sharedinode;
>> +    };
>> +#endif
>>       /* the corresponding vfs inode */
>>       struct inode vfs_inode;
>>   };
>> @@ -410,6 +428,7 @@ extern const struct inode_operations erofs_dir_iops;
>>   extern const struct file_operations erofs_file_fops;
>>   extern const struct file_operations erofs_dir_fops;
>> +extern const struct file_operations erofs_ishare_fops;
>>   extern const struct iomap_ops z_erofs_iomap_report_ops;
>> @@ -541,6 +560,18 @@ static inline struct bio 
>> *erofs_fscache_bio_alloc(struct erofs_map_dev *mdev) {
>>   static inline void erofs_fscache_submit_bio(struct bio *bio) {}
>>   #endif
>> +#ifdef CONFIG_EROFS_FS_PAGE_CACHE_SHARE
>> +int __init erofs_init_ishare(void);
>> +void erofs_exit_ishare(void);
>> +bool erofs_ishare_fill_inode(struct inode *inode);
>> +void erofs_ishare_free_inode(struct inode *inode);
>> +#else
>> +static inline int erofs_init_ishare(void) { return 0; }
>> +static inline void erofs_exit_ishare(void) {}
>> +static inline bool erofs_ishare_fill_inode(struct inode *inode) { 
>> return false; }
>> +static inline void erofs_ishare_free_inode(struct inode *inode) {}
>> +#endif // CONFIG_EROFS_FS_PAGE_CACHE_SHARE
>> +
>>   long erofs_ioctl(struct file *filp, unsigned int cmd, unsigned long 
>> arg);
>>   long erofs_compat_ioctl(struct file *filp, unsigned int cmd,
>>               unsigned long arg);
>> diff --git a/fs/erofs/ishare.c b/fs/erofs/ishare.c
>> new file mode 100644
>> index 000000000000..56a955aaeb18
>> --- /dev/null
>> +++ b/fs/erofs/ishare.c
>> @@ -0,0 +1,161 @@
>> +// SPDX-License-Identifier: GPL-2.0-or-later
>> +/*
>> + * Copyright (C) 2024, Alibaba Cloud
>> + */
>> +#include <linux/xxhash.h>
>> +#include <linux/mount.h>
>> +#include "internal.h"
>> +#include "xattr.h"
>> +
>> +#include "../internal.h"
>> +
>> +static struct vfsmount *erofs_ishare_mnt;
>> +
>> +static int erofs_ishare_iget5_eq(struct inode *inode, void *data)
>> +{
>> +    struct erofs_inode_fingerprint *fp1 = &EROFS_I(inode)->fingerprint;
>> +    struct erofs_inode_fingerprint *fp2 = data;
>> +
>> +    return fp1->size == fp2->size &&
>> +        !memcmp(fp1->opaque, fp2->opaque, fp2->size);
>> +}
>> +
>> +static int erofs_ishare_iget5_set(struct inode *inode, void *data)
>> +{
>> +    struct erofs_inode *vi = EROFS_I(inode);
>> +
>> +    vi->fingerprint = *(struct erofs_inode_fingerprint *)data;
>> +    INIT_LIST_HEAD(&vi->ishare_list);
>> +    spin_lock_init(&vi->ishare_lock);
>> +    return 0;
>> +}
>> +
>> +bool erofs_ishare_fill_inode(struct inode *inode)
>> +{
>> +    struct erofs_sb_info *sbi = EROFS_SB(inode->i_sb);
>> +    struct erofs_inode *vi = EROFS_I(inode);
>> +    struct erofs_inode_fingerprint fp;
>> +    struct inode *sharedinode;
>> +    unsigned long hash;
>> +
>> +    if (erofs_xattr_fill_inode_fingerprint(&fp, inode, sbi->domain_id))
>> +        return false;
>> +    hash = xxh32(fp.opaque, fp.size, 0);
>> +    sharedinode = iget5_locked(erofs_ishare_mnt->mnt_sb, hash,
>> +                   erofs_ishare_iget5_eq, erofs_ishare_iget5_set,
>> +                   &fp);
>> +    if (!sharedinode) {
>> +        kfree(fp.opaque);
>> +        return false;
>> +    }
>> +
>> +    vi->sharedinode = sharedinode;
>> +    if (inode_state_read_once(sharedinode) & I_NEW) {
>> +        if (erofs_inode_is_data_compressed(vi->datalayout))
>> +            sharedinode->i_mapping->a_ops = &z_erofs_aops;
>> +        else
>> +            sharedinode->i_mapping->a_ops = &erofs_aops;
>> +        sharedinode->i_mode = vi->vfs_inode.i_mode;
>> +        sharedinode->i_size = vi->vfs_inode.i_size;
>> +        unlock_new_inode(sharedinode);
>> +    } else {
>> +        kfree(fp.opaque);
>> +    }
>> +    INIT_LIST_HEAD(&vi->ishare_list);
>> +    spin_lock(&EROFS_I(sharedinode)->ishare_lock);
>> +    list_add(&vi->ishare_list, &EROFS_I(sharedinode)->ishare_list);
>> +    spin_unlock(&EROFS_I(sharedinode)->ishare_lock);
>> +    return true;
>> +}
>> +
>> +void erofs_ishare_free_inode(struct inode *inode)
>> +{
>> +    struct erofs_inode *vi = EROFS_I(inode);
>> +    struct inode *sharedinode = vi->sharedinode;
>> +
>> +    if (!sharedinode)
>> +        return;
>> +    spin_lock(&EROFS_I(sharedinode)->ishare_lock);
>> +    list_del(&vi->ishare_list);
>> +    spin_unlock(&EROFS_I(sharedinode)->ishare_lock);
>> +    iput(sharedinode);
>> +    vi->sharedinode = NULL;
>> +}
>> +
>> +static int erofs_ishare_file_open(struct inode *inode, struct file 
>> *file)
>> +{
>> +    struct inode *sharedinode;
> 
> just
>      struct inode *sharedinode = EROFS_I(inode)->sharedinode;
> 
> here for simplicity.
> 
> `if (file->f_flags & O_DIRECT)` is an error case, so I don't bother
> with the check.
> 

Ok, I will adjust here in next version.

>> +    struct file *realfile;
>> +
>> +    if (file->f_flags & O_DIRECT)
>> +        return -EINVAL;
>> +    sharedinode = EROFS_I(inode)->sharedinode;
>> +    realfile = alloc_empty_backing_file(O_RDONLY|O_NOATIME, 
>> current_cred());
>> +    if (IS_ERR(realfile))
>> +        return PTR_ERR(realfile);
>> +    ihold(sharedinode);
>> +    realfile->f_op = &erofs_file_fops;
>> +    realfile->f_inode = sharedinode;
>> +    realfile->f_mapping = sharedinode->i_mapping;
>> +    path_get(&file->f_path);
>> +    backing_file_set_user_path(realfile, &file->f_path);
>> +
>> +    file_ra_state_init(&realfile->f_ra, file->f_mapping);
>> +    realfile->private_data = EROFS_I(inode);
>> +    file->private_data = realfile;
>> +    return 0;
>> +}
>> +
>> +static int erofs_ishare_file_release(struct inode *inode, struct file 
>> *file)
>> +{
>> +    struct file *realfile = file->private_data;
>> +
>> +    iput(realfile->f_inode);
>> +    fput(realfile);
>> +    file->private_data = NULL;
>> +    return 0;
>> +}
>> +
>> +static ssize_t erofs_ishare_file_read_iter(struct kiocb *iocb,
>> +                       struct iov_iter *to)
>> +{
>> +    struct file *realfile = iocb->ki_filp->private_data;
>> +    struct kiocb dedup_iocb;
>> +    ssize_t nread;
>> +
>> +    if (!iov_iter_count(to))
>> +        return 0;
>> +    kiocb_clone(&dedup_iocb, iocb, realfile);
>> +    nread = filemap_read(&dedup_iocb, to, 0);
>> +    iocb->ki_pos = dedup_iocb.ki_pos;
>> +    return nread;
>> +}
>> +
>> +static int erofs_ishare_mmap(struct file *file, struct vm_area_struct 
>> *vma)
>> +{
>> +    struct file *realfile = file->private_data;
>> +
>> +    vma_set_file(vma, realfile);
>> +    return generic_file_readonly_mmap(file, vma);
>> +}
>> +
>> +const struct file_operations erofs_ishare_fops = {
>> +    .open        = erofs_ishare_file_open,
>> +    .llseek        = generic_file_llseek,
>> +    .read_iter    = erofs_ishare_file_read_iter,
>> +    .mmap        = erofs_ishare_mmap,
>> +    .release    = erofs_ishare_file_release,
>> +    .get_unmapped_area = thp_get_unmapped_area,
>> +    .splice_read    = filemap_splice_read,
>> +};
>> +
>> +int __init erofs_init_ishare(void)
>> +{
>> +    erofs_ishare_mnt = kern_mount(&erofs_anon_fs_type);
>> +    return PTR_ERR_OR_ZERO(erofs_ishare_mnt);
>> +}
>> +
>> +void erofs_exit_ishare(void)
>> +{
>> +    kern_unmount(erofs_ishare_mnt);
>> +}
>> diff --git a/fs/erofs/super.c b/fs/erofs/super.c
>> index 960da62636ad..a851b47ee579 100644
>> --- a/fs/erofs/super.c
>> +++ b/fs/erofs/super.c
>> @@ -396,6 +396,7 @@ static void erofs_default_options(struct 
>> erofs_sb_info *sbi)
>>   enum {
>>       Opt_user_xattr, Opt_acl, Opt_cache_strategy, Opt_dax, Opt_dax_enum,
>>       Opt_device, Opt_fsid, Opt_domain_id, Opt_directio, Opt_fsoffset,
>> +    Opt_inode_share,
>>   };
>>   static const struct constant_table erofs_param_cache_strategy[] = {
>> @@ -423,6 +424,7 @@ static const struct fs_parameter_spec 
>> erofs_fs_parameters[] = {
>>       fsparam_string("domain_id",    Opt_domain_id),
>>       fsparam_flag_no("directio",    Opt_directio),
>>       fsparam_u64("fsoffset",        Opt_fsoffset),
>> +    fsparam_flag("inode_share",    Opt_inode_share),
>>       {}
>>   };
>> @@ -551,6 +553,13 @@ static int erofs_fc_parse_param(struct fs_context 
>> *fc,
>>       case Opt_fsoffset:
>>           sbi->dif0.fsoff = result.uint_64;
>>           break;
>> +    case Opt_inode_share:
>> +#if defined(CONFIG_EROFS_FS_PAGE_CACHE_SHARE)
>> +        set_opt(&sbi->opt, INODE_SHARE);
>> +#else
>> +        errorfc(fc, "%s option not supported", 
>> erofs_fs_parameters[opt].name);
>> +#endif
>> +        break;
>>       }
>>       return 0;
>>   }
>> @@ -649,6 +658,11 @@ static int erofs_fc_fill_super(struct super_block 
>> *sb, struct fs_context *fc)
>>       sb->s_maxbytes = MAX_LFS_FILESIZE;
>>       sb->s_op = &erofs_sops;
>> +    if (test_opt(&sbi->opt, DAX_ALWAYS) && test_opt(&sbi->opt, 
>> INODE_SHARE)) {
>> +        errorfc(fc, "FSDAX is not allowed when inode_ishare is on");
>> +        return -EINVAL;
>> +    }
>> +
>>       sbi->blkszbits = PAGE_SHIFT;
>>       if (!sb->s_bdev) {
>>           /*
>> @@ -719,6 +733,10 @@ static int erofs_fc_fill_super(struct super_block 
>> *sb, struct fs_context *fc)
>>           erofs_info(sb, "unsupported blocksize for DAX");
>>           clear_opt(&sbi->opt, DAX_ALWAYS);
>>       }
>> +    if (test_opt(&sbi->opt, INODE_SHARE) && 
>> !erofs_sb_has_ishare_xattrs(sbi)) {
>> +        erofs_info(sb, "inode ishare is unavailable");
> 
>      erofs_info(sb, "on-disk ishare xattrs not found. Turning off 
> inode_share.");
> 

thanks, will update.

> 
>> +        clear_opt(&sbi->opt, INODE_SHARE);
>> +    }
>>       sb->s_time_gran = 1;
>>       sb->s_xattr = erofs_xattr_handlers;
>> @@ -948,10 +966,31 @@ static struct file_system_type erofs_fs_type = {
>>   };
>>   MODULE_ALIAS_FS("erofs");
>> -#if defined(CONFIG_EROFS_FS_ONDEMAND)
>> +#if defined(CONFIG_EROFS_FS_ONDEMAND) || 
>> defined(CONFIG_EROFS_FS_PAGE_CACHE_SHARE)
>> +static void erofs_free_anon_inode(struct inode *inode)
>> +{
>> +    struct erofs_inode *vi = EROFS_I(inode);
>> +
>> +#ifdef CONFIG_EROFS_FS_PAGE_CACHE_SHARE
>> +    kfree(vi->fingerprint.opaque);
>> +#endif
> 
> Drop `#ifdef CONFIG_EROFS_FS_PAGE_CACHE_SHARE` here for simplicity.
> 

The vi->fingerprint is only visiable when 
CONFIG_EROFS_FS_PAGE_CACHE_SHARE is on, so we should keep this.

Thanks,
Hongbo

>> +    kmem_cache_free(erofs_inode_cachep, vi);
>> +}
>> +
>> +static const struct super_operations erofs_anon_sops = {
>> +    .alloc_inode = erofs_alloc_inode,
>> +    .free_inode = erofs_free_anon_inode,
>> +};
>> +
>>   static int erofs_anon_init_fs_context(struct fs_context *fc)
>>   {
>> -    return init_pseudo(fc, EROFS_SUPER_MAGIC) ? 0 : -ENOMEM;
>> +    struct pseudo_fs_context *ctx;
>> +
>> +    ctx = init_pseudo(fc, EROFS_SUPER_MAGIC);
>> +    if (ctx)
>> +        ctx->ops = &erofs_anon_sops;
>> +
>> +    return ctx ? 0 : -ENOMEM;
> 
>      ctx = init_pseudo(fc, EROFS_SUPER_MAGIC);
>      if (!ctx)
>          return -ENOMEM;
>      ctx->ops = &erofs_anon_sops;
>      return 0;
> 

ok, will update.

>>   }
>>   struct file_system_type erofs_anon_fs_type = {
>> @@ -986,6 +1025,10 @@ static int __init erofs_module_init(void)
>>       if (err)
>>           goto sysfs_err;
>> +    err = erofs_init_ishare();
>> +    if (err)
>> +        goto ishare_err;
>> +
>>       err = register_filesystem(&erofs_fs_type);
>>       if (err)
>>           goto fs_err;
>> @@ -993,6 +1036,8 @@ static int __init erofs_module_init(void)
>>       return 0;
>>   fs_err:
>> +    erofs_exit_ishare();
>> +ishare_err:
>>       erofs_exit_sysfs();
>>   sysfs_err:
>>       z_erofs_exit_subsystem();
>> @@ -1010,6 +1055,7 @@ static void __exit erofs_module_exit(void)
>>       /* Ensure all RCU free inodes / pclusters are safe to be 
>> destroyed. */
>>       rcu_barrier();
>> +    erofs_exit_ishare();
>>       erofs_exit_sysfs();
>>       z_erofs_exit_subsystem();
>>       erofs_exit_shrinker();
>> @@ -1062,6 +1108,8 @@ static int erofs_show_options(struct seq_file 
>> *seq, struct dentry *root)
>>           seq_printf(seq, ",domain_id=%s", sbi->domain_id);
>>       if (sbi->dif0.fsoff)
>>           seq_printf(seq, ",fsoffset=%llu", sbi->dif0.fsoff);
>> +    if (test_opt(opt, INODE_SHARE))
>> +        seq_puts(seq, ",inode_share");
>>       return 0;
>>   }
>> @@ -1072,6 +1120,7 @@ static void erofs_evict_inode(struct inode *inode)
>>           dax_break_layout_final(inode);
>>   #endif
>> +    erofs_ishare_free_inode(inode);
>>       truncate_inode_pages_final(&inode->i_data);
>>       clear_inode(inode);
>>   }
>> diff --git a/fs/erofs/xattr.c b/fs/erofs/xattr.c
>> index ae61f20cb861..290acbf89fa6 100644
>> --- a/fs/erofs/xattr.c
>> +++ b/fs/erofs/xattr.c
>> @@ -577,3 +577,36 @@ struct posix_acl *erofs_get_acl(struct inode 
>> *inode, int type, bool rcu)
>>       return acl;
>>   }
>>   #endif
>> +
>> +#ifdef CONFIG_EROFS_FS_PAGE_CACHE_SHARE
>> +int erofs_xattr_fill_inode_fingerprint(struct erofs_inode_fingerprint 
>> *fp,
>> +                       struct inode *inode, const char *domain_id)
>> +{
>> +    struct erofs_sb_info *sbi = EROFS_SB(inode->i_sb);
>> +    struct erofs_xattr_prefix_item *prefix;
>> +    const char *infix;
>> +    int valuelen, base_index, domainlen;
>> +
>> +    if (!test_opt(&sbi->opt, INODE_SHARE))
>> +        return -EOPNOTSUPP;
>> +    prefix = sbi->xattr_prefixes + sbi->ishare_xattr_prefix_id;
>> +    infix = prefix->prefix->infix;
>> +    base_index = prefix->prefix->base_index;
>> +    valuelen = erofs_getxattr(inode, base_index, infix, NULL, 0);
>> +    if (valuelen <= 0 || valuelen > (1 << sbi->blkszbits))
>> +        return -EFSCORRUPTED;
> 
>      fp->size = valuelen + (domain_id ? strlen(domain_id) : 0);
>      fp->opaque = kmalloc(fp->size, GFP_KERNEL);
>      ...
> 
> 
>> +    memcpy(fp->opaque + valuelen, domain_id, domainlen);
>> +    fp->size = valuelen + domainlen;
> 
> Then kill this line.
> 

thanks, will update.

> Thanks,
> Gao Xiang
> 
>> +    return 0;
>> +}
>> +#endif
>> diff --git a/fs/erofs/xattr.h b/fs/erofs/xattr.h
>> index 6317caa8413e..bf75a580b8f1 100644
>> --- a/fs/erofs/xattr.h
>> +++ b/fs/erofs/xattr.h
>> @@ -67,4 +67,7 @@ struct posix_acl *erofs_get_acl(struct inode *inode, 
>> int type, bool rcu);
>>   #define erofs_get_acl    (NULL)
>>   #endif
>> +int erofs_xattr_fill_inode_fingerprint(struct erofs_inode_fingerprint 
>> *fp,
>> +                       struct inode *inode, const char *domain_id);
>> +
>>   #endif
> 

