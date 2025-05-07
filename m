Return-Path: <linux-erofs+bounces-287-lists+linux-erofs=lfdr.de@lists.ozlabs.org>
X-Original-To: lists+linux-erofs@lfdr.de
Delivered-To: lists+linux-erofs@lfdr.de
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2404:9400:2:0:216:3eff:fee1:b9f1])
	by mail.lfdr.de (Postfix) with ESMTPS id 59143AAD2F4
	for <lists+linux-erofs@lfdr.de>; Wed,  7 May 2025 03:53:55 +0200 (CEST)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4ZsdZy3c8sz2ySf;
	Wed,  7 May 2025 11:53:30 +1000 (AEST)
X-Original-To: linux-erofs@lists.ozlabs.org
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip=45.249.212.187
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1746582810;
	cv=none; b=m1qosYg3zNidwFSwdFlPvZHPyk0Hey4UDwaoAuysojxI9JipYdNLgEG3HlSi7EiX029+dWc18utAdms05Qz9X7SBZFYOh1JKb/SMiqY6w9rfCmZyBieHZu4HSavDS0epLi9E4YOdsUoyUaXhOEfIUicQW0DgIjGq0bb4kUy+kg+WRtR6L+RDILLs7P+NmdLsFn/y/lQWEWjDbzclPAc5dxyjtpdOo0r+VZxUNgq+lV2no0bngNCvjZI9LE3OWLpRJkagSiud+LfmkfsS2ArZgPEGnvrX8Vmeu/bMBWfAZrjlDPDAgErXIT/GGHuo2j0ibCTt3J21CLhpIpZfqhuPyg==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1746582810; c=relaxed/relaxed;
	bh=lkqVR8Crw9bFGx6zLCYGX+F33caKvKeq3TWzbUeSwik=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=VjICK6dBygHki3Qtcfa9OYL8tAsEsPTPumHpwYF98wYLa8QJ/1nzA5eZrie7GETvebBV3Qlj74D5dembubjZ7KdK+tRS9SCbBB9hXfJDV+iPa8Sza+sVOr6Vo8x3GjW/WzBgBtQPFzNuNM7kN7h/ofWHgW7Ra1AIVdOZ+DePRT6I0TtwR/EtmhRhCknX+9+uHXCUKqyNBbdU/0tB1jQWPd4uRGJN+tGnjAcKMYTICnpk4KLE4PqbcDB7roGIDCbnsrKOcR1jpK8jFRG8KKx4gvi55VmhxN96J5SLqHeZorJEMc0EE0S4W99F4X4RbFnRKmwI2uB1S9+Wd7DhXyUweA==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass (client-ip=45.249.212.187; helo=szxga01-in.huawei.com; envelope-from=lihongbo22@huawei.com; receiver=lists.ozlabs.org) smtp.mailfrom=huawei.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=huawei.com (client-ip=45.249.212.187; helo=szxga01-in.huawei.com; envelope-from=lihongbo22@huawei.com; receiver=lists.ozlabs.org)
Received: from szxga01-in.huawei.com (szxga01-in.huawei.com [45.249.212.187])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4ZsdZx2cMrz2yLJ
	for <linux-erofs@lists.ozlabs.org>; Wed,  7 May 2025 11:53:27 +1000 (AEST)
Received: from mail.maildlp.com (unknown [172.19.163.252])
	by szxga01-in.huawei.com (SkyGuard) with ESMTP id 4ZsdYM0z0xz13KbK;
	Wed,  7 May 2025 09:52:07 +0800 (CST)
Received: from kwepemo500009.china.huawei.com (unknown [7.202.194.199])
	by mail.maildlp.com (Postfix) with ESMTPS id D1DFD180B5A;
	Wed,  7 May 2025 09:53:23 +0800 (CST)
Received: from [10.67.111.104] (10.67.111.104) by
 kwepemo500009.china.huawei.com (7.202.194.199) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.11; Wed, 7 May 2025 09:53:23 +0800
Message-ID: <3e068311-9223-4c1b-9091-15eb2d867ede@huawei.com>
Date: Wed, 7 May 2025 09:53:22 +0800
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
Subject: Re: [PATCH v3] erofs: fix file handle encoding for 64-bit NIDs
Content-Language: en-US
To: Gao Xiang <hsiangkao@linux.alibaba.com>, <xiang@kernel.org>,
	<chao@kernel.org>, <zbestahu@gmail.com>, <jefflexu@linux.alibaba.com>
CC: <dhavale@google.com>, <linux-erofs@lists.ozlabs.org>,
	<linux-kernel@vger.kernel.org>
References: <20250429134257.690176-1-lihongbo22@huawei.com>
 <18d272ce-6a80-4fdc-b67b-ddc2ffa522d4@linux.alibaba.com>
From: Hongbo Li <lihongbo22@huawei.com>
In-Reply-To: <18d272ce-6a80-4fdc-b67b-ddc2ffa522d4@linux.alibaba.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 8bit
X-Originating-IP: [10.67.111.104]
X-ClientProxiedBy: dggems706-chm.china.huawei.com (10.3.19.183) To
 kwepemo500009.china.huawei.com (7.202.194.199)
X-Spam-Status: No, score=-2.3 required=3.0 tests=RCVD_IN_DNSWL_MED,
	SPF_HELO_NONE,SPF_PASS autolearn=disabled version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-25) on lists.ozlabs.org



On 2025/5/6 23:10, Gao Xiang wrote:
> Hi Hongbo,
> 
> On 2025/4/29 21:42, Hongbo Li wrote:
>> In erofs, the inode number has the location information of
>> files. The default encode_fh uses the ino32, this will lack
>> of some information when the file is too big. So we need
>> the internal helpers to encode filehandle.
> 
> EROFS uses NID to indicate the on-disk inode offset, which can
> exceed 32 bits. However, the default encode_fh uses the ino32,
> thus it doesn't work if the image is large than 128GiB.
> 
Thanks for helping me correct my description.

Here, an image larger than 128GiB won't trigger NID reversal. It 
requires a 128GiB file inside, and the NID of the second file may exceed 
U32 during formatting. So here can we change it to "However, the default 
encode_fh uses the ino32, thus it may not work if there exist a file 
which is large than 128GiB." ?

Thanks,
Hongbo

> Let's introduce our own helpers to encode file handles.
> 
>>
>> It is easy to reproduce test:
> 
> It's easy to reproduce:
> 
>>    1. prepare an erofs image with nid bigger than UINT_MAX
> 
>       1. Prepare an EROFS image with NIDs larger than U32_MAX
> 
>>    2. mount -t erofs foo.img /mnt/erofs
>>    3. set exportfs with configuration: /mnt/erofs *(rw,sync,
>>       no_root_squash)
>>    4. mount -t nfs $IP:/mnt/erofs /mnt/nfs
>>    5. md5sum /mnt/nfs/foo # foo is the file which nid bigger
>>       than UINT_MAX.
>> For overlayfs case, the under filesystem's file handle is
>> encoded in ovl_fb.fid, it is same as NFS's case.
>>
>> Fixes: 3e917cc305c6 ("erofs: make filesystem exportable")
>> Signed-off-by: Hongbo Li <lihongbo22@huawei.com>
>> ---
>> v2: 
>> https://lore.kernel.org/all/20250429074109.689075-1-lihongbo22@huawei.com/
>>    - Assign parent nid with correct value.
>>
>> v1: 
>> https://lore.kernel.org/all/20250429011139.686847-1-lihongbo22@huawei.com/
>>     - Encode generation into file handle and minor clean code.
>>     - Update the commiti's title.
>> ---
>>   fs/erofs/super.c | 54 +++++++++++++++++++++++++++++++++++++++++-------
>>   1 file changed, 46 insertions(+), 8 deletions(-)
>>
>> diff --git a/fs/erofs/super.c b/fs/erofs/super.c
>> index cadec6b1b554..28b3701165cc 100644
>> --- a/fs/erofs/super.c
>> +++ b/fs/erofs/super.c
>> @@ -511,24 +511,62 @@ static int erofs_fc_parse_param(struct 
>> fs_context *fc,
>>       return 0;
>>   }
>> -static struct inode *erofs_nfs_get_inode(struct super_block *sb,
>> -                     u64 ino, u32 generation)
>> +static int erofs_encode_fh(struct inode *inode, u32 *fh, int *max_len,
>> +               struct inode *parent)
>>   {
>> -    return erofs_iget(sb, ino);
>> +    int len = parent ? 6 : 3;
>> +    erofs_nid_t nid;
> 
> Just `erofs_nid_t nid = EROFS_I(inode)->nid;`?
> 
> I think the compiler will optimize out `if (*max_len < len)`.
> 
>> +    u32 generation;
> 
> It seems it's unnecessary to introduce `generation` variable here?
> 
>> +
>> +    if (*max_len < len) {
>> +        *max_len = len;
>> +        return FILEID_INVALID;
>> +    }
>> +
>> +    nid = EROFS_I(inode)->nid;
>> +    generation = inode->i_generation;
> 
> So drop these two lines.
> 
>> +    fh[0] = (u32)(nid >> 32);
>> +    fh[1] = (u32)(nid & 0xffffffff);
>> +    fh[2] = generation;
>> +
>> +    if (parent) {
>> +        nid = EROFS_I(parent)->nid;
>> +        generation = parent->i_generation;
>> +
>> +        fh[3] = (u32)(nid >> 32);
>> +        fh[4] = (u32)(nid & 0xffffffff);
>> +        fh[5] = generation;
> 
>          fh[5] = parent->i_generation;
> 
>> +    }
>> +
>> +    *max_len = len;
>> +    return parent ? FILEID_INO64_GEN_PARENT : FILEID_INO64_GEN;
>>   }
>>   static struct dentry *erofs_fh_to_dentry(struct super_block *sb,
>>           struct fid *fid, int fh_len, int fh_type)
>>   {
>> -    return generic_fh_to_dentry(sb, fid, fh_len, fh_type,
>> -                    erofs_nfs_get_inode);
>> +    erofs_nid_t nid;
>> +
>> +    if ((fh_type != FILEID_INO64_GEN &&
>> +         fh_type != FILEID_INO64_GEN_PARENT) || fh_len < 3)
>> +        return NULL;
>> +
>> +    nid = (u64) fid->raw[0] << 32;
>> +    nid |= (u64) fid->raw[1];
> 
> Unnecessary nid variable.
> 
>> +    return d_obtain_alias(erofs_iget(sb, nid));
> 
>      return d_obtain_alias(erofs_iget(sb,
>              ((u64)fid->raw[0] << 32) | fid->raw[1]));
> 
>>   }
>>   static struct dentry *erofs_fh_to_parent(struct super_block *sb,
>>           struct fid *fid, int fh_len, int fh_type)
>>   {
>> -    return generic_fh_to_parent(sb, fid, fh_len, fh_type,
>> -                    erofs_nfs_get_inode);
>> +    erofs_nid_t nid;
>> +
>> +    if (fh_type != FILEID_INO64_GEN_PARENT || fh_len < 6)
>> +        return NULL;
>> +
>> +    nid = (u64) fid->raw[3] << 32;
>> +    nid |= (u64) fid->raw[4];
> 
> Same here.
> 
> Thanks,
> Gao Xiang

