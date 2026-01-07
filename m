Return-Path: <linux-erofs+bounces-1695-lists+linux-erofs=lfdr.de@lists.ozlabs.org>
X-Original-To: lists+linux-erofs@lfdr.de
Delivered-To: lists+linux-erofs@lfdr.de
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2404:9400:21b9:f100::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E721ECFC414
	for <lists+linux-erofs@lfdr.de>; Wed, 07 Jan 2026 07:56:52 +0100 (CET)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4dmJjt3b5Hz2xbQ;
	Wed, 07 Jan 2026 17:56:50 +1100 (AEDT)
X-Original-To: linux-erofs@lists.ozlabs.org
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip=115.124.30.124
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1767769010;
	cv=none; b=oRn3fam4prQYuBPskkEvy43J/cPSmRnhjyETEa9KhHRWSQAyMe+Np4pOb6u278SGaEgt/7vHnMh1kD5zVA/Zfbl03CVBjeZ0Ui8EnnuI1WSCWn8ltMT2r9JsnDyqICBkz0hLwDEq5DN8Rfd5NZ+3P79QoEw3kKIFRHW5O7c2X7GXkfjuE6uHRlvupgmFy3G8HrJHS9mmeTFmDJ2COmbYE9pN/CZxZuk4dly9Fh9jfPZZtw7aGOljj7VT5eOplRyDZfvUL7mEjE1XE5s9YNKwZjE0wJdszlYe/0+aZovimmyOttGHiJd9pmNGqiqjjCtOG2x41zVbhQwUQW3wwWHvkA==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1767769010; c=relaxed/relaxed;
	bh=uxQJ/2PmUTK2PkMYEMI1zPFooDQNSjqfmXM9b4dv9MU=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=eFYPxo9xTBMHSqOGSOafiIpjIi3xOXUqYkSS9fd9N+T02yTdt5ypkuwpC1sPYAFm0vnyauun3lKYpgnT+r6AeNWq9Gg4O+BRedpNzcBQgLLLUbki7QPCM+nNiaAP5HnryD3S/BEW7HCk2K9Y3RKzdwhywBjtrLr3bCQfYYL37pxjaXll8HaQ3eujbXda3+gkRXvdOHJzDeWjgvUPxP0zqr4VYtOwUnkhdOuz9SkdzDhzhRbxbhQcTH63DPdl9vkynXF+zATr/bf4PK037/0W3W6fDTgsKqn7rBOsooHR6JxGUu1ngK03lmcZ7cdmzu8yMGRBg0Bf9YUd3JYwLmuO5A==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com; dkim=pass (1024-bit key; unprotected) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.a=rsa-sha256 header.s=default header.b=hyEG9ty8; dkim-atps=neutral; spf=pass (client-ip=115.124.30.124; helo=out30-124.freemail.mail.aliyun.com; envelope-from=hsiangkao@linux.alibaba.com; receiver=lists.ozlabs.org) smtp.mailfrom=linux.alibaba.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (1024-bit key; unprotected) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.a=rsa-sha256 header.s=default header.b=hyEG9ty8;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=linux.alibaba.com (client-ip=115.124.30.124; helo=out30-124.freemail.mail.aliyun.com; envelope-from=hsiangkao@linux.alibaba.com; receiver=lists.ozlabs.org)
Received: from out30-124.freemail.mail.aliyun.com (out30-124.freemail.mail.aliyun.com [115.124.30.124])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4dmJjq4hNtz2xHP
	for <linux-erofs@lists.ozlabs.org>; Wed, 07 Jan 2026 17:56:45 +1100 (AEDT)
DKIM-Signature:v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=linux.alibaba.com; s=default;
	t=1767768999; h=Message-ID:Date:MIME-Version:Subject:To:From:Content-Type;
	bh=uxQJ/2PmUTK2PkMYEMI1zPFooDQNSjqfmXM9b4dv9MU=;
	b=hyEG9ty8K7Y45Mlhta69Eb2yCGOFRzvIbfna3AXQo0XIBdhf0sD9ktiDDwDCAnGhMhB2JdDnRe7q5e1hy4CKqs68c2nLsua0gz/1NjEETw2lc5D6kjjUhtSRvi4dW+4We6dj9kY6k6uhw45VNr4PHkRoFS3N6zg5K/IJ7FaZBz8=
Received: from 30.221.132.240(mailfrom:hsiangkao@linux.alibaba.com fp:SMTPD_---0WwXwQlH_1767768997 cluster:ay36)
          by smtp.aliyun-inc.com;
          Wed, 07 Jan 2026 14:56:37 +0800
Message-ID: <df2889c0-6027-4f42-a013-b01357fd0005@linux.alibaba.com>
Date: Wed, 7 Jan 2026 14:56:35 +0800
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
Subject: Re: [PATCH v12 07/10] erofs: introduce the page cache share feature
To: Hongbo Li <lihongbo22@huawei.com>
Cc: djwong@kernel.org, amir73il@gmail.com, hch@lst.de,
 linux-fsdevel@vger.kernel.org, linux-erofs@lists.ozlabs.org,
 linux-kernel@vger.kernel.org, Chao Yu <chao@kernel.org>, brauner@kernel.org
References: <20251231090118.541061-1-lihongbo22@huawei.com>
 <20251231090118.541061-8-lihongbo22@huawei.com>
 <99a517aa-744b-487b-bce8-294b69a0cd50@linux.alibaba.com>
 <b690d435-7e9c-4424-a681-d3f798176202@huawei.com>
From: Gao Xiang <hsiangkao@linux.alibaba.com>
In-Reply-To: <b690d435-7e9c-4424-a681-d3f798176202@huawei.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-15.7 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,DKIM_VALID_EF,ENV_AND_HDR_SPF_MATCH,RCVD_IN_DNSWL_NONE,
	SPF_HELO_NONE,SPF_PASS,UNPARSEABLE_RELAY,USER_IN_DEF_DKIM_WL,
	USER_IN_DEF_SPF_WL autolearn=disabled version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-25) on lists.ozlabs.org



On 2026/1/7 14:48, Hongbo Li wrote:
> Hi, Xiang
> 
> On 2026/1/7 14:08, Gao Xiang wrote:
>>
>>
>> On 2025/12/31 17:01, Hongbo Li wrote:
>>> From: Hongzhen Luo <hongzhen@linux.alibaba.com>
>>>
>>> Currently, reading files with different paths (or names) but the same
>>> content will consume multiple copies of the page cache, even if the
>>> content of these page caches is the same. For example, reading
>>> identical files (e.g., *.so files) from two different minor versions of
>>> container images will cost multiple copies of the same page cache,
>>> since different containers have different mount points. Therefore,
>>> sharing the page cache for files with the same content can save memory.
>>>
>>> This introduces the page cache share feature in erofs. It allocate a
>>> deduplicated inode and use its page cache as shared. Reads for files
>>> with identical content will ultimately be routed to the page cache of
>>> the deduplicated inode. In this way, a single page cache satisfies
>>> multiple read requests for different files with the same contents.
>>>
>>> We introduce inode_share mount option to enable the page sharing mode
>>> during mounting.
>>>
>>> Signed-off-by: Hongzhen Luo <hongzhen@linux.alibaba.com>
>>> Signed-off-by: Hongbo Li <lihongbo22@huawei.com>
>>> ---
>>>   Documentation/filesystems/erofs.rst |   5 +
>>>   fs/erofs/Makefile                   |   1 +
>>>   fs/erofs/internal.h                 |  31 +++++
>>>   fs/erofs/ishare.c                   | 170 ++++++++++++++++++++++++++++
>>>   fs/erofs/super.c                    |  55 ++++++++-
>>>   fs/erofs/xattr.c                    |  34 ++++++
>>>   fs/erofs/xattr.h                    |   3 +
>>>   7 files changed, 297 insertions(+), 2 deletions(-)
>>>   create mode 100644 fs/erofs/ishare.c
>>>
>>> diff --git a/Documentation/filesystems/erofs.rst b/Documentation/filesystems/erofs.rst
>>> index 08194f194b94..27d3caa3c73c 100644
>>> --- a/Documentation/filesystems/erofs.rst
>>> +++ b/Documentation/filesystems/erofs.rst
>>> @@ -128,7 +128,12 @@ device=%s              Specify a path to an extra device to be used together.
>>>   fsid=%s                Specify a filesystem image ID for Fscache back-end.
>>>   domain_id=%s           Specify a domain ID in fscache mode so that different images
>>>                          with the same blobs under a given domain ID can share storage.
>>> +                       Also used for inode page sharing mode which defines a sharing
>>> +                       domain.
>>>   fsoffset=%llu          Specify block-aligned filesystem offset for the primary device.
>>> +inode_share            Enable inode page sharing for this filesystem.  Inodes with
>>> +                       identical content within the same domain ID can share the
>>> +                       page cache.
>>>   =================== =========================================================
>>>   Sysfs Entries
>>> diff --git a/fs/erofs/Makefile b/fs/erofs/Makefile
>>> index 549abc424763..a80e1762b607 100644
>>> --- a/fs/erofs/Makefile
>>> +++ b/fs/erofs/Makefile
>>> @@ -10,3 +10,4 @@ erofs-$(CONFIG_EROFS_FS_ZIP_ZSTD) += decompressor_zstd.o
>>>   erofs-$(CONFIG_EROFS_FS_ZIP_ACCEL) += decompressor_crypto.o
>>>   erofs-$(CONFIG_EROFS_FS_BACKED_BY_FILE) += fileio.o
>>>   erofs-$(CONFIG_EROFS_FS_ONDEMAND) += fscache.o
>>> +erofs-$(CONFIG_EROFS_FS_PAGE_CACHE_SHARE) += ishare.o
>>> diff --git a/fs/erofs/internal.h b/fs/erofs/internal.h
>>> index ec79e8b44d3b..6ef1cdd9d651 100644
>>> --- a/fs/erofs/internal.h
>>> +++ b/fs/erofs/internal.h
>>> @@ -179,6 +179,7 @@ struct erofs_sb_info {
>>>   #define EROFS_MOUNT_DAX_ALWAYS        0x00000040
>>>   #define EROFS_MOUNT_DAX_NEVER        0x00000080
>>>   #define EROFS_MOUNT_DIRECT_IO        0x00000100
>>> +#define EROFS_MOUNT_INODE_SHARE        0x00000200
>>>   #define clear_opt(opt, option)    ((opt)->mount_opt &= ~EROFS_MOUNT_##option)
>>>   #define set_opt(opt, option)    ((opt)->mount_opt |= EROFS_MOUNT_##option)
>>> @@ -269,6 +270,11 @@ static inline u64 erofs_nid_to_ino64(struct erofs_sb_info *sbi, erofs_nid_t nid)
>>>   /* default readahead size of directories */
>>>   #define EROFS_DIR_RA_BYTES    16384
>>> +struct erofs_inode_fingerprint {
>>> +    u8 *opaque;
>>> +    int size;
>>> +};
>>> +
>>>   struct erofs_inode {
>>>       erofs_nid_t nid;
>>> @@ -304,6 +310,18 @@ struct erofs_inode {
>>>           };
>>>   #endif    /* CONFIG_EROFS_FS_ZIP */
>>>       };
>>> +#ifdef CONFIG_EROFS_FS_PAGE_CACHE_SHARE
>>> +    struct list_head ishare_list;
>>> +    union {
>>> +        /* for each anon shared inode */
>>> +        struct {
>>> +            struct erofs_inode_fingerprint fingerprint;
>>> +            spinlock_t ishare_lock;
>>> +        };
>>> +        /* for each real inode */
>>> +        struct inode *sharedinode;
>>> +    };
>>> +#endif
>>>       /* the corresponding vfs inode */
>>>       struct inode vfs_inode;
>>>   };
>>> @@ -410,6 +428,7 @@ extern const struct inode_operations erofs_dir_iops;
>>>   extern const struct file_operations erofs_file_fops;
>>>   extern const struct file_operations erofs_dir_fops;
>>> +extern const struct file_operations erofs_ishare_fops;
>>>   extern const struct iomap_ops z_erofs_iomap_report_ops;
>>> @@ -541,6 +560,18 @@ static inline struct bio *erofs_fscache_bio_alloc(struct erofs_map_dev *mdev) {
>>>   static inline void erofs_fscache_submit_bio(struct bio *bio) {}
>>>   #endif
>>> +#ifdef CONFIG_EROFS_FS_PAGE_CACHE_SHARE
>>> +int __init erofs_init_ishare(void);
>>> +void erofs_exit_ishare(void);
>>> +bool erofs_ishare_fill_inode(struct inode *inode);
>>> +void erofs_ishare_free_inode(struct inode *inode);
>>> +#else
>>> +static inline int erofs_init_ishare(void) { return 0; }
>>> +static inline void erofs_exit_ishare(void) {}
>>> +static inline bool erofs_ishare_fill_inode(struct inode *inode) { return false; }
>>> +static inline void erofs_ishare_free_inode(struct inode *inode) {}
>>> +#endif // CONFIG_EROFS_FS_PAGE_CACHE_SHARE
>>> +
>>>   long erofs_ioctl(struct file *filp, unsigned int cmd, unsigned long arg);
>>>   long erofs_compat_ioctl(struct file *filp, unsigned int cmd,
>>>               unsigned long arg);
>>> diff --git a/fs/erofs/ishare.c b/fs/erofs/ishare.c
>>> new file mode 100644
>>> index 000000000000..e93d379d4a3a
>>> --- /dev/null
>>> +++ b/fs/erofs/ishare.c
>>> @@ -0,0 +1,170 @@
>>> +// SPDX-License-Identifier: GPL-2.0-or-later
>>> +/*
>>> + * Copyright (C) 2024, Alibaba Cloud
>>> + */
>>> +#include <linux/xxhash.h>
>>> +#include <linux/mount.h>
>>> +#include "internal.h"
>>> +#include "xattr.h"
>>> +
>>> +#include "../internal.h"
>>> +
>>> +static struct vfsmount *erofs_ishare_mnt;
>>> +
>>> +static int erofs_ishare_iget5_eq(struct inode *inode, void *data)
>>> +{
>>> +    struct erofs_inode_fingerprint *fp1 = &EROFS_I(inode)->fingerprint;
>>> +    struct erofs_inode_fingerprint *fp2 = data;
>>> +
>>> +    return fp1->size == fp2->size &&
>>> +        !memcmp(fp1->opaque, fp2->opaque, fp2->size);
>>> +}
>>> +
>>> +static int erofs_ishare_iget5_set(struct inode *inode, void *data)
>>> +{
>>> +    struct erofs_inode *vi = EROFS_I(inode);
>>> +
>>> +    vi->fingerprint = *(struct erofs_inode_fingerprint *)data;
>>> +    INIT_LIST_HEAD(&vi->ishare_list);
>>> +    spin_lock_init(&vi->ishare_lock);
>>> +    return 0;
>>> +}
>>> +
>>> +bool erofs_ishare_fill_inode(struct inode *inode)
>>> +{
>>> +    struct erofs_sb_info *sbi = EROFS_SB(inode->i_sb);
>>> +    struct erofs_inode *vi = EROFS_I(inode);
>>> +    struct erofs_inode_fingerprint fp;
>>> +    struct inode *sharedinode;
>>> +    unsigned long hash;
>>> +
>>> +    if (!test_opt(&sbi->opt, INODE_SHARE))
>>> +        return false;
>>> +    (void)erofs_xattr_fill_ishare_fp(&fp, inode, sbi->domain_id);
>>> +    if (!fp.size)
>>> +        return false;
>>
>> Why not just:
>>
>>      if (erofs_xattr_fill_ishare_fp(&fp, inode, sbi->domain_id))
>>          return false;
>>
> 
> When erofs_sb_has_ishare_xattrs returns false, erofs_xattr_fill_ishare_fp also considers success.

Then why !test_opt(&sbi->opt, INODE_SHARE) didn't return?

Thanks,
Gao Xiang

