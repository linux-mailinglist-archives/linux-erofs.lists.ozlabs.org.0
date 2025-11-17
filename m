Return-Path: <linux-erofs+bounces-1387-lists+linux-erofs=lfdr.de@lists.ozlabs.org>
X-Original-To: lists+linux-erofs@lfdr.de
Delivered-To: lists+linux-erofs@lfdr.de
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	by mail.lfdr.de (Postfix) with ESMTPS id B8E66C62C62
	for <lists+linux-erofs@lfdr.de>; Mon, 17 Nov 2025 08:42:09 +0100 (CET)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4d907g4L7yz2ynC;
	Mon, 17 Nov 2025 18:42:07 +1100 (AEDT)
X-Original-To: linux-erofs@lists.ozlabs.org
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip=113.46.200.216
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1763365327;
	cv=none; b=V769YRujJqVVMn9iY26+ycHkhd3FWVjA3VXwjxMbGRpcWCOLFcMUM86BAte/sFj+QjMFkjSY7JFl6XLMiJZexdlOpEzZQODiedqfiFSYsuGFHveffWQm8Dsg8+hJ8gRHcHEiaoQ4nruBVwxA+SdQZYGNeQUWrQiCitAvCaKX8VeQ2svwdsNIIcIz9pN/Gc2jkL5gf4HHQ9KEqCz8n0Ie35G3NMuiVr2T7+7Dz5cobx4imMdX7iEMrmuv+eioOYU48q4kQ4YL51cCv7TB7GjLPSoqt7ErVQ2cE8vudrHE8tclf0xQaYrfS55uJSL7IuyP5HcC/GelPLoLv7EAIfvaGA==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1763365327; c=relaxed/relaxed;
	bh=gGtZe6aUNhI/+lLCQkV3ulj8qdpXHe/N2oVbKgeo9F4=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=OKZeWcHgIMaAzk5bmx2xn3/+ghKtQUrWcCN85BWnWrTLOcEyUvPkIdb1NagEA8eGur82xFQs3Vik+NWm85JIriVYmYjvZlEp8VWpFJQLDn9BNC0DV7K+2kU8AN95BCl5a5VLFUdkGslKL1gN3f/BNAKy4j0jh+rBZS5ZAPReja7Ts5rsqlEw/PK2mNW8obQL9xkDDWSTYsmK1kNYr1OESTgIfEa2eeBXCRsQAgB9+AMZUqO+PO9OX2ovbhmszRu9Ky6P4wRnq3LvdyxowgChmODiP+NpALU23RmSgPZqa0yr/6c8k0wLF7P1/jrkfhRPJBGKb/hlLlHLL9eWkAI7TA==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; dkim=pass (1024-bit key; unprotected) header.d=huawei.com header.i=@huawei.com header.a=rsa-sha256 header.s=dkim header.b=VR8ideB7; dkim-atps=neutral; spf=pass (client-ip=113.46.200.216; helo=canpmsgout01.his.huawei.com; envelope-from=lihongbo22@huawei.com; receiver=lists.ozlabs.org) smtp.mailfrom=huawei.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (1024-bit key; unprotected) header.d=huawei.com header.i=@huawei.com header.a=rsa-sha256 header.s=dkim header.b=VR8ideB7;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=huawei.com (client-ip=113.46.200.216; helo=canpmsgout01.his.huawei.com; envelope-from=lihongbo22@huawei.com; receiver=lists.ozlabs.org)
Received: from canpmsgout01.his.huawei.com (canpmsgout01.his.huawei.com [113.46.200.216])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4d907c59Zpz2xQr
	for <linux-erofs@lists.ozlabs.org>; Mon, 17 Nov 2025 18:42:02 +1100 (AEDT)
dkim-signature: v=1; a=rsa-sha256; d=huawei.com; s=dkim;
	c=relaxed/relaxed; q=dns/txt;
	h=From;
	bh=gGtZe6aUNhI/+lLCQkV3ulj8qdpXHe/N2oVbKgeo9F4=;
	b=VR8ideB7WJpp6R/VqhF/68ghpS4DJgDdVfQmUGL6gwVChmwlsrIYsyj+BEViYDYLcaXN33O3q
	xmTsrB8SA0aBmz9eA9n3lqLHkYW7bu2FyiYREFyor3D40AP+ireedZTFPgqx0zp8TYsE1GvF63x
	g3/0gT/ST1XpMNoKfo2L3Ts=
Received: from mail.maildlp.com (unknown [172.19.163.252])
	by canpmsgout01.his.huawei.com (SkyGuard) with ESMTPS id 4d905j6WTkz1T4Fq;
	Mon, 17 Nov 2025 15:40:25 +0800 (CST)
Received: from kwepemr500015.china.huawei.com (unknown [7.202.195.162])
	by mail.maildlp.com (Postfix) with ESMTPS id 11352180B6B;
	Mon, 17 Nov 2025 15:41:56 +0800 (CST)
Received: from [10.67.111.104] (10.67.111.104) by
 kwepemr500015.china.huawei.com (7.202.195.162) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.11; Mon, 17 Nov 2025 15:41:55 +0800
Message-ID: <df86044f-b192-492a-99f2-bad019570f9d@huawei.com>
Date: Mon, 17 Nov 2025 15:41:54 +0800
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
Subject: Re: [PATCH v8 4/9] erofs: support user-defined fingerprint name
Content-Language: en-US
To: Gao Xiang <hsiangkao@linux.alibaba.com>, <chao@kernel.org>,
	<brauner@kernel.org>, <djwong@kernel.org>, <amir73il@gmail.com>,
	<joannelkoong@gmail.com>
CC: <linux-fsdevel@vger.kernel.org>, <linux-erofs@lists.ozlabs.org>,
	<linux-kernel@vger.kernel.org>
References: <20251114095516.207555-1-lihongbo22@huawei.com>
 <20251114095516.207555-5-lihongbo22@huawei.com>
 <a3b0bac9-d08f-44dc-8adb-7cc85cae7b13@linux.alibaba.com>
From: Hongbo Li <lihongbo22@huawei.com>
In-Reply-To: <a3b0bac9-d08f-44dc-8adb-7cc85cae7b13@linux.alibaba.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 8bit
X-Originating-IP: [10.67.111.104]
X-ClientProxiedBy: kwepems100002.china.huawei.com (7.221.188.206) To
 kwepemr500015.china.huawei.com (7.202.195.162)
X-Spam-Status: No, score=-0.2 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS autolearn=disabled
	version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-25) on lists.ozlabs.org

Hi Xiang,

On 2025/11/17 10:54, Gao Xiang wrote:
> 
> 
> On 2025/11/14 17:55, Hongbo Li wrote:
>> From: Hongzhen Luo <hongzhen@linux.alibaba.com>
>>
>> When creating the EROFS image, users can specify the fingerprint name.
>> This is to prepare for the upcoming inode page cache share.
>>
>> Signed-off-by: Hongzhen Luo <hongzhen@linux.alibaba.com>
>> Signed-off-by: Hongbo Li <lihongbo22@huawei.com>
>> ---
>>   fs/erofs/Kconfig    |  9 +++++++++
>>   fs/erofs/erofs_fs.h |  6 ++++--
>>   fs/erofs/internal.h |  6 ++++++
>>   fs/erofs/super.c    |  5 ++++-
>>   fs/erofs/xattr.c    | 26 ++++++++++++++++++++++++++
>>   fs/erofs/xattr.h    |  6 ++++++
>>   6 files changed, 55 insertions(+), 3 deletions(-)
>>
>> diff --git a/fs/erofs/Kconfig b/fs/erofs/Kconfig
>> index d81f3318417d..1b5c0cd99203 100644
>> --- a/fs/erofs/Kconfig
>> +++ b/fs/erofs/Kconfig
>> @@ -194,3 +194,12 @@ config EROFS_FS_PCPU_KTHREAD_HIPRI
>>         at higher priority.
>>         If unsure, say N.
>> +
>> +config EROFS_FS_INODE_SHARE
>> +    bool "EROFS inode page cache share support (experimental)"
>> +    depends on EROFS_FS && EROFS_FS_XATTR && !EROFS_FS_ONDEMAND
>> +    help
>> +      This permits EROFS to share page cache for files with same
>> +      fingerprints.
> 
> I tend to use "EROFS_FS_PAGE_CACHE_SHARE" since it's closer to
> user impact definition (inode sharing is ambiguious), but we
> could leave "ishare.c" since it's closer to the implementation
> details.
> 
> And how about:
> 
> config EROFS_FS_PAGE_CACHE_SHARE
>      bool "EROFS page cache share support (experimental)"
>      depends on EROFS_FS && EROFS_FS_XATTR && !EROFS_FS_ONDEMAND
>      help
>        This enables page cache sharing among inodes with identical
>        content fingerprints on the same device.
> 
>        If unsure, say N.
> 
>> +
>> +      If unsure, say N.
>> \ No newline at end of file
> 
> "\ No newline at end of file" should be fixed.
> 
>> diff --git a/fs/erofs/erofs_fs.h b/fs/erofs/erofs_fs.h
>> index 3d5738f80072..104518cd161d 100644
>> --- a/fs/erofs/erofs_fs.h
>> +++ b/fs/erofs/erofs_fs.h
>> @@ -35,8 +35,9 @@
>>   #define EROFS_FEATURE_INCOMPAT_XATTR_PREFIXES    0x00000040
>>   #define EROFS_FEATURE_INCOMPAT_48BIT        0x00000080
>>   #define EROFS_FEATURE_INCOMPAT_METABOX        0x00000100
>> +#define EROFS_FEATURE_INCOMPAT_ISHARE_KEY    0x00000200
> 
> I do think it should be a compatible feature since images can be
> mounted in the old kernels without any issue, and it should be
> renamed as
> 
> EROFS_FEATURE_COMPAT_ISHARE_XATTRS
> 
>>   #define EROFS_ALL_FEATURE_INCOMPAT        \
>> -    ((EROFS_FEATURE_INCOMPAT_METABOX << 1) - 1)
>> +    ((EROFS_FEATURE_INCOMPAT_ISHARE_KEY << 1) - 1)
>>   #define EROFS_SB_EXTSLOT_SIZE    16
>> @@ -83,7 +84,8 @@ struct erofs_super_block {
>>       __le32 xattr_prefix_start;    /* start of long xattr prefixes */
>>       __le64 packed_nid;    /* nid of the special packed inode */
>>       __u8 xattr_filter_reserved; /* reserved for xattr name filter */
>> -    __u8 reserved[3];
>> +    __u8 ishare_key_start;    /* start of ishare key */
> 
> ishare_xattr_prefix_id; ?
> 
>> +    __u8 reserved[2];
>>       __le32 build_time;    /* seconds added to epoch for mkfs time */
>>       __le64 rootnid_8b;    /* (48BIT on) nid of root directory */
>>       __le64 reserved2;
>> diff --git a/fs/erofs/internal.h b/fs/erofs/internal.h
>> index e80b35db18e4..3ebbb7c5d085 100644
>> --- a/fs/erofs/internal.h
>> +++ b/fs/erofs/internal.h
>> @@ -167,6 +167,11 @@ struct erofs_sb_info {
>>       struct erofs_domain *domain;
>>       char *fsid;
>>       char *domain_id;
>> +
>> +    /* inode page cache share support */
>> +    u8 ishare_key_start;
> 
>      u8 ishare_xattr_pfx;
> 
>> +    u8 ishare_key_idx;
> 
> why need this, considering we could just use
> 
> sbi->xattr_prefixes[sbi->ishare_xattr_pfx]
> 
> to get this.
> 
>> +    char *ishare_key;
>>   };
>>   #define EROFS_SB(sb) ((struct erofs_sb_info *)(sb)->s_fs_info)
>> @@ -236,6 +241,7 @@ EROFS_FEATURE_FUNCS(dedupe, incompat, 
>> INCOMPAT_DEDUPE)
>>   EROFS_FEATURE_FUNCS(xattr_prefixes, incompat, INCOMPAT_XATTR_PREFIXES)
>>   EROFS_FEATURE_FUNCS(48bit, incompat, INCOMPAT_48BIT)
>>   EROFS_FEATURE_FUNCS(metabox, incompat, INCOMPAT_METABOX)
>> +EROFS_FEATURE_FUNCS(ishare_key, incompat, INCOMPAT_ISHARE_KEY)
>>   EROFS_FEATURE_FUNCS(sb_chksum, compat, COMPAT_SB_CHKSUM)
>>   EROFS_FEATURE_FUNCS(xattr_filter, compat, COMPAT_XATTR_FILTER)
>>   EROFS_FEATURE_FUNCS(shared_ea_in_metabox, compat, 
>> COMPAT_SHARED_EA_IN_METABOX)
>> diff --git a/fs/erofs/super.c b/fs/erofs/super.c
>> index 0d88c04684b9..3561473cb789 100644
>> --- a/fs/erofs/super.c
>> +++ b/fs/erofs/super.c
>> @@ -339,7 +339,7 @@ static int erofs_read_superblock(struct 
>> super_block *sb)
>>               return -EFSCORRUPTED;    /* self-loop detection */
>>       }
>>       sbi->inos = le64_to_cpu(dsb->inos);
>> -
>> +    sbi->ishare_key_start = dsb->ishare_key_start;
>>       sbi->epoch = (s64)le64_to_cpu(dsb->epoch);
>>       sbi->fixed_nsec = le32_to_cpu(dsb->fixed_nsec);
>>       super_set_uuid(sb, (void *)dsb->uuid, sizeof(dsb->uuid));
>> @@ -738,6 +738,9 @@ static int erofs_fc_fill_super(struct super_block 
>> *sb, struct fs_context *fc)
>>       if (err)
>>           return err;
>> +    err = erofs_xattr_set_ishare_key(sb);
> 
> I don't think it's necessary to duplicate the copy, just use
> "sbi->xattr_prefixes[sbi->ishare_xattr_pfx]" directly.
> 

Thanks for review, but here we should pass the char * to erofs_getxattr 
to obtain the xattr length and value. And xattr_prefixes packed all 
entries together so we cannot tranform 
sbi->xattr_prefixes[sbi->ishare_xattr_pfx] into char * directly.

Thanks,
Hongbo

> Thanks,
> Gao Xiang
> 
>> +    if (err)
>> +        return err;
>>       erofs_set_sysfs_name(sb);
>>       err = erofs_register_sysfs(sb);
>>       if (err)
>> diff --git a/fs/erofs/xattr.c b/fs/erofs/xattr.c
>> index 396536d9a862..3c99091f39a5 100644
>> --- a/fs/erofs/xattr.c
>> +++ b/fs/erofs/xattr.c
>> @@ -564,3 +564,29 @@ struct posix_acl *erofs_get_acl(struct inode 
>> *inode, int type, bool rcu)
>>       return acl;
>>   }
>>   #endif
>> +
>> +#ifdef CONFIG_EROFS_FS_INODE_SHARE
>> +int erofs_xattr_set_ishare_key(struct super_block *sb)
>> +{
>> +    struct erofs_sb_info *sbi = EROFS_SB(sb);
>> +    struct erofs_xattr_prefix_item *pf;
>> +    char *ishare_key;
>> +
>> +    if (!sbi->xattr_prefixes ||
>> +        !(sbi->ishare_key_start & EROFS_XATTR_LONG_PREFIX))
>> +        return 0;
>> +
>> +    pf = sbi->xattr_prefixes +
>> +        (sbi->ishare_key_start & EROFS_XATTR_LONG_PREFIX_MASK);
>> +    if (!pf || pf >= sbi->xattr_prefixes + sbi->xattr_prefix_count)
>> +        return 0;
>> +    ishare_key = kmalloc(pf->infix_len + 1, GFP_KERNEL);
>> +    if (!ishare_key)
>> +        return -ENOMEM;
>> +    memcpy(ishare_key, pf->prefix->infix, pf->infix_len);
>> +    ishare_key[pf->infix_len] = '\0';
>> +    sbi->ishare_key = ishare_key;
>> +    sbi->ishare_key_idx = pf->prefix->base_index;
>> +    return 0;
>> +}
>> +#endif
>> diff --git a/fs/erofs/xattr.h b/fs/erofs/xattr.h
>> index 6317caa8413e..21684359662c 100644
>> --- a/fs/erofs/xattr.h
>> +++ b/fs/erofs/xattr.h
>> @@ -67,4 +67,10 @@ struct posix_acl *erofs_get_acl(struct inode 
>> *inode, int type, bool rcu);
>>   #define erofs_get_acl    (NULL)
>>   #endif
>> +#ifdef CONFIG_EROFS_FS_INODE_SHARE
>> +int erofs_xattr_set_ishare_key(struct super_block *sb);
>> +#else
>> +static inline int erofs_xattr_set_ishare_key(struct super_block *sb) 
>> { return 0; }
>> +#endif
>> +
>>   #endif
> 

