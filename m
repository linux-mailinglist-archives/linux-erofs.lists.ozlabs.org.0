Return-Path: <linux-erofs+bounces-609-lists+linux-erofs=lfdr.de@lists.ozlabs.org>
X-Original-To: lists+linux-erofs@lfdr.de
Delivered-To: lists+linux-erofs@lfdr.de
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2404:9400:2:0:216:3eff:fee1:b9f1])
	by mail.lfdr.de (Postfix) with ESMTPS id 68821B036BC
	for <lists+linux-erofs@lfdr.de>; Mon, 14 Jul 2025 08:16:55 +0200 (CEST)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4bgXCS5G92z3bsL;
	Mon, 14 Jul 2025 16:16:52 +1000 (AEST)
X-Original-To: linux-erofs@lists.ozlabs.org
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip="2604:1380:4641:c500::1"
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1752473812;
	cv=none; b=fEonDPwCqXao5mIudJL/2Lq6TwcdnBTE/0aCzml9U3DglLOdmBvw8+bsM9Fs/fh3OR1AHdHBy9XzTSwFLSWZM5eNu5e0RUQI+gqiSFuvt3sKa61QatJURLvqejWn6XfZbsqQwCuqd6ak3bnrc/DB+5HLwreoMjBQDQdL5R29XtFnY7KyZn/ghPiAGdn7H/WUUocdG1Lq6VDed7fyGk3ixBZAmVM0NNev8WU6HbOLcnAcsD4XR1yP9xhUUqLmEWVOPGYHQQ5RGa7eGZAbfSgcdo+iHuQXi9r87v5pnObuvhzLiR1w1HcO+mr42ao4PZ1ys5ZrzFtGVEavfMlH9yTTDg==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1752473812; c=relaxed/relaxed;
	bh=vN8ChjTx2EAEgCwFcs4Oeer5vFyn980f0aP/75ezgrE=;
	h=Message-ID:Date:MIME-Version:Cc:Subject:To:References:From:
	 In-Reply-To:Content-Type; b=QAbo1cxsfuD5qUIExyd2JihSZZLMSFHN3rUL1/Sd5aCuBg9Pqz1wUIR5GD9MMgHm37Un8uumm/YBlc5vYgdrS6FFjJaZ3Qo0g52WwLPM8P+p9BfyjNwG09lcTeW9dXuY83eIFOtnsxcuCbUeMd4hLDYtNVwH8qJ142LiSQqtZwqUskZBzGckrNO9AYwD+ks1FMPc7silOB2KT8PBWctxUETxzvmtWcySVuqU2NHlkYIUOMxHbEJBZCkxSxnG2ViQaWwIwCYsi2TgKmbANmavV3R9Hn5GoroGj5mkBvpCXuMYfM9bT30TkDf9gGRZ0W4Se7HVsC/AziMqy8EQ8EF4Dw==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=kernel.org; dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20201202 header.b=uc00x9l0; dkim-atps=neutral; spf=pass (client-ip=2604:1380:4641:c500::1; helo=dfw.source.kernel.org; envelope-from=chao@kernel.org; receiver=lists.ozlabs.org) smtp.mailfrom=kernel.org
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=kernel.org
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20201202 header.b=uc00x9l0;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=kernel.org (client-ip=2604:1380:4641:c500::1; helo=dfw.source.kernel.org; envelope-from=chao@kernel.org; receiver=lists.ozlabs.org)
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4bgXCS032Nz3bpL
	for <linux-erofs@lists.ozlabs.org>; Mon, 14 Jul 2025 16:16:51 +1000 (AEST)
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
	by dfw.source.kernel.org (Postfix) with ESMTP id 0A1955C57E2;
	Mon, 14 Jul 2025 06:16:50 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1DB17C4CEED;
	Mon, 14 Jul 2025 06:16:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1752473809;
	bh=O1ETop01ZN4d5gek3Oou4+1OB0vTZhVUxDynTVNMEKc=;
	h=Date:Cc:Subject:To:References:From:In-Reply-To:From;
	b=uc00x9l0EljpdB8lJRkz50kRPsfI6l3awnDj16Ws14K8mHJUP+CXInlCLXS84KFLm
	 LnzLTv18Z+VxbTU0CWE5mr7fYJKEiPAbNWrdM82rKuXz4VgkuiY79Q1JJ68jlzAYXf
	 I5sBzZbHCQjK6godwwG41FYg9e2yZWhzhyql14OCAGuUq2iQRW62dbcSCpmvWtk9EI
	 4a+GG/Qq09baxDLaBgua4gDW5IYlYSO5NbHv/en3lehokiew/1EMW5rKh6etKS9f3x
	 3MQgTS/KgxV3YfXYmTNrMEmuxDkLbD9/wW/EuvO5l5zWYIFuA3JXrmRztPA7XxUNlE
	 sHNLUlkAsxu4A==
Message-ID: <6a501e5f-880e-4dc6-a984-b2406b54daa9@kernel.org>
Date: Mon, 14 Jul 2025 14:16:44 +0800
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
Cc: chao@kernel.org, linux-erofs@lists.ozlabs.org,
 linux-kernel@vger.kernel.org, Yue Hu <zbestahu@gmail.com>,
 Jeffle Xu <jefflexu@linux.alibaba.com>, Sandeep Dhavale
 <dhavale@google.com>, Hongbo Li <lihongbo22@huawei.com>
Subject: Re: [PATCH v2 2/2] erofs: support to readahead dirent blocks in
 erofs_readdir()
To: Gao Xiang <hsiangkao@linux.alibaba.com>, xiang@kernel.org
References: <20250714033450.58298-1-chao@kernel.org>
 <dcb197e7-8dea-4bd2-9344-b753c10c534d@linux.alibaba.com>
Content-Language: en-US
From: Chao Yu <chao@kernel.org>
In-Reply-To: <dcb197e7-8dea-4bd2-9344-b753c10c534d@linux.alibaba.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-3.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS
	autolearn=disabled version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-25) on lists.ozlabs.org

On 7/14/25 11:49, Gao Xiang wrote:
> Hi Chao,
> 
> On 2025/7/14 11:34, Chao Yu wrote:
>> This patch supports to readahead more blocks in erofs_readdir(), it can
>> enhance readdir performance in large direcotry.
>>
>> readdir test in a large directory which contains 12000 sub-files.
>>
>>         files_per_second
>> Before:        926385.54
>> After:        2380435.562
>>
>> Meanwhile, let's introduces a new sysfs entry to control page count
>> of readahead to provide more flexible policy for readahead of readdir().
>> - location: /sys/fs/erofs/<disk>/dir_ra_pages
>> - default value: 4
>> - range: [0, 128]
>> - disable readahead: set the value to 0
>>
>> Signed-off-by: Chao Yu <chao@kernel.org>
>> ---
>> v2:
>> - introduce sysfs node to control page count of readahead during
>> readdir().
>>   Documentation/ABI/testing/sysfs-fs-erofs | 7 +++++++
>>   fs/erofs/dir.c                           | 9 +++++++++
>>   fs/erofs/internal.h                      | 5 +++++
>>   fs/erofs/super.c                         | 2 ++
>>   fs/erofs/sysfs.c                         | 5 +++++
>>   5 files changed, 28 insertions(+)
>>
>> diff --git a/Documentation/ABI/testing/sysfs-fs-erofs b/Documentation/ABI/testing/sysfs-fs-erofs
>> index bf3b6299c15e..500c93484e4c 100644
>> --- a/Documentation/ABI/testing/sysfs-fs-erofs
>> +++ b/Documentation/ABI/testing/sysfs-fs-erofs
>> @@ -35,3 +35,10 @@ Description:    Used to set or show hardware accelerators in effect
>>           and multiple accelerators are separated by '\n'.
>>           Supported accelerator(s): qat_deflate.
>>           Disable all accelerators with an empty string (echo > accel).
>> +
>> +What:        /sys/fs/erofs/<disk>/dir_ra_pages
>> +Date:        July 2025
>> +Contact:    "Chao Yu" <chao@kernel.org>
>> +Description:    Used to set or show page count of readahead during readdir(),
>> +        the range of value is [0, 128], by default it is 4, set it to
>> +        0 to disable readahead.
>> diff --git a/fs/erofs/dir.c b/fs/erofs/dir.c
>> index 3e4b38bec0aa..40f828d5b670 100644
>> --- a/fs/erofs/dir.c
>> +++ b/fs/erofs/dir.c
>> @@ -47,8 +47,10 @@ static int erofs_readdir(struct file *f, struct dir_context *ctx)
>>       struct inode *dir = file_inode(f);
>>       struct erofs_buf buf = __EROFS_BUF_INITIALIZER;
>>       struct super_block *sb = dir->i_sb;
>> +    struct file_ra_state *ra = &f->f_ra;
>>       unsigned long bsz = sb->s_blocksize;
>>       unsigned int ofs = erofs_blkoff(sb, ctx->pos);
>> +    unsigned long nr_pages = DIV_ROUND_UP_POW2(dir->i_size, PAGE_SIZE);
> 
> why using DIV_ROUND_UP_POW2 rather than DIV_ROUND_UP here?

Seems DIV_ROUND_UP_POW2() doesn't use bit shift as expected, let
me use DIV_ROUND_UP() instead.

> 
>>       int err = 0;
>>       bool initial = true;
>>   @@ -63,6 +65,13 @@ static int erofs_readdir(struct file *f, struct dir_context *ctx)
>>               break;
>>           }
>>   +        /* readahead blocks to enhance performance in large directory */
>> +        if (EROFS_I_SB(dir)->dir_ra_pages && nr_pages - dbstart > 1 &&
> 
> dbstart is a byte-oriented value, so I'm not sure if it
> works as you expect..

Oh, I checked patch in 6.6, found that I missed to handle it correctly
when porting code to upstream, let me fix this.

> 
>> +            !ra_has_index(ra, dbstart))
>> +            page_cache_sync_readahead(dir->i_mapping, ra, f,
>> +                dbstart, min(nr_pages - dbstart,
> 
> same here.
> 
>> +                (pgoff_t)EROFS_I_SB(dir)->dir_ra_pages));
>> +
>>           de = erofs_bread(&buf, dbstart, true);
>>           if (IS_ERR(de)) {
>>               erofs_err(sb, "failed to readdir of logical block %llu of nid %llu",
>> diff --git a/fs/erofs/internal.h b/fs/erofs/internal.h
>> index 0d19bde8c094..f0e5b4273aa8 100644
>> --- a/fs/erofs/internal.h
>> +++ b/fs/erofs/internal.h
>> @@ -157,6 +157,7 @@ struct erofs_sb_info {
>>       /* sysfs support */
>>       struct kobject s_kobj;        /* /sys/fs/erofs/<devname> */
>>       struct completion s_kobj_unregister;
>> +    unsigned int dir_ra_pages;
>>         /* fscache support */
>>       struct fscache_volume *volume;
>> @@ -238,6 +239,10 @@ EROFS_FEATURE_FUNCS(xattr_filter, compat, COMPAT_XATTR_FILTER)
>>   #define EROFS_I_BL_XATTR_BIT    (BITS_PER_LONG - 1)
>>   #define EROFS_I_BL_Z_BIT    (BITS_PER_LONG - 2)
>>   +/* default/maximum readahead pages of directory */
>> +#define DEFAULT_DIR_RA_PAGES    4
>> +#define MAX_DIR_RA_PAGES    128
> 
> better to add EROFS_ prefix for them.
> 
> Also could we setup those blocks or bytes instead
> of pages?
> 
> If users would like to setup values, they may don't
> care more the page size since they only care about
> images.

Let's use bytes, and then roundup to blksize?

> 
> Also why do we limit maximum number even if users
> would like to readahead more? (such as fadvise
> allows -1 too)

No test, but I suspect there is border effect even we set it to
i_size.

Anyway, let me remove the upper boundary limitation, unless there
is further requirement of limitation.

Thanks,

> 
> Thanks,
> Gao Xiang
> 


