Return-Path: <linux-erofs+bounces-610-lists+linux-erofs=lfdr.de@lists.ozlabs.org>
X-Original-To: lists+linux-erofs@lfdr.de
Delivered-To: lists+linux-erofs@lfdr.de
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2404:9400:2:0:216:3eff:fee1:b9f1])
	by mail.lfdr.de (Postfix) with ESMTPS id 04AF7B03700
	for <lists+linux-erofs@lfdr.de>; Mon, 14 Jul 2025 08:25:00 +0200 (CEST)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4bgXNm17Xhz3bsP;
	Mon, 14 Jul 2025 16:24:56 +1000 (AEST)
X-Original-To: linux-erofs@lists.ozlabs.org
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip=115.124.30.119
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1752474296;
	cv=none; b=On5vzwbULVT22E7z8GKebpqzfCF4u2ZRQo3hb4O+zeyaGc3LQYTg6ugvyhtqfqahdukObBKZkRUH+qer7SmgpPEVVrQW6/96yIVeO1q/HdwICfjARlmPdyftmtTcZbHnG8YS++dIsM0VtQjDE8v6YDeoZMxDb95ukO7mgahdt0DeEpZCZl6FQ12XGYZzJPTDorfO/yjG5t7JdphXjUrPO5QjNbhUZPqDpxs23koV4ZtUT9MNsiEsuDoBF/U6mytrqutg8yzzng5BF+L6c1GuqVPSdzoXTEt70hlM60S5CIlh9yNtDY1GWfvfWQkuw7rTFdtRWnjmzGd7wEF3SX8dvA==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1752474296; c=relaxed/relaxed;
	bh=cR/14sKIFQHSCrOFkaxh5bW8lpjAs1gHEPsG9exlcqA=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=i6VY/zPHgXYS+vDtKUQ1xs1x3/32EuI9J6vX19lOxCYnDarXISSqBJH709hw6H0ob5bMIM2pjD7L5BOGELnAF52nufnKu1wnM0PbkxBsR8rSW7vZprZiHjUtcaRMFOLlaPLNLwLRb1FtiqRHWL9nk9dRjrGbUpJ/PiAAt6OsftFzR7T/i1hffuKyGMkop1MxVupc5eLmlVd3YYeduLlXilhwzdgDPaUPKLpHqSIrT1UKgauYe2lyyEYY+6iyB8MIxPkyz/oXWLx5I5o41ssun8ZQ0pKUx/67spnIXzL3k/Ky+v0Dl3whwglsqZQXLj/GOR6m83MDQxh9j35LWviGpA==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com; dkim=pass (1024-bit key; unprotected) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.a=rsa-sha256 header.s=default header.b=Ii49BNax; dkim-atps=neutral; spf=pass (client-ip=115.124.30.119; helo=out30-119.freemail.mail.aliyun.com; envelope-from=hsiangkao@linux.alibaba.com; receiver=lists.ozlabs.org) smtp.mailfrom=linux.alibaba.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (1024-bit key; unprotected) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.a=rsa-sha256 header.s=default header.b=Ii49BNax;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=linux.alibaba.com (client-ip=115.124.30.119; helo=out30-119.freemail.mail.aliyun.com; envelope-from=hsiangkao@linux.alibaba.com; receiver=lists.ozlabs.org)
Received: from out30-119.freemail.mail.aliyun.com (out30-119.freemail.mail.aliyun.com [115.124.30.119])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4bgXNk1B9Rz3bsM
	for <linux-erofs@lists.ozlabs.org>; Mon, 14 Jul 2025 16:24:52 +1000 (AEST)
DKIM-Signature:v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=linux.alibaba.com; s=default;
	t=1752474288; h=Message-ID:Date:MIME-Version:Subject:To:From:Content-Type;
	bh=cR/14sKIFQHSCrOFkaxh5bW8lpjAs1gHEPsG9exlcqA=;
	b=Ii49BNax/RtgI/2onte4l7X+DoOhmmLTkor33dHfKqw16DCAnRd1hjkfcmsuRqVu4OeCzLQPM+ykf002ShZ0yuOetTGON4zbhSTtKNrFgWs820VrCeusIlT7ncvxlUWDiWXuKrM5cenehLpFWI0onpoWW3UW2buXpH7gEbYV/XE=
Received: from 30.221.131.165(mailfrom:hsiangkao@linux.alibaba.com fp:SMTPD_---0WiqCEEV_1752474284 cluster:ay36)
          by smtp.aliyun-inc.com;
          Mon, 14 Jul 2025 14:24:46 +0800
Message-ID: <c839cf3a-6aef-435e-b915-156ada202b31@linux.alibaba.com>
Date: Mon, 14 Jul 2025 14:24:44 +0800
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
Subject: Re: [PATCH v2 2/2] erofs: support to readahead dirent blocks in
 erofs_readdir()
To: Chao Yu <chao@kernel.org>, xiang@kernel.org
Cc: linux-erofs@lists.ozlabs.org, linux-kernel@vger.kernel.org,
 Yue Hu <zbestahu@gmail.com>, Jeffle Xu <jefflexu@linux.alibaba.com>,
 Sandeep Dhavale <dhavale@google.com>, Hongbo Li <lihongbo22@huawei.com>
References: <20250714033450.58298-1-chao@kernel.org>
 <dcb197e7-8dea-4bd2-9344-b753c10c534d@linux.alibaba.com>
 <6a501e5f-880e-4dc6-a984-b2406b54daa9@kernel.org>
From: Gao Xiang <hsiangkao@linux.alibaba.com>
In-Reply-To: <6a501e5f-880e-4dc6-a984-b2406b54daa9@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-15.7 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,DKIM_VALID_EF,ENV_AND_HDR_SPF_MATCH,RCVD_IN_DNSWL_NONE,
	SPF_HELO_NONE,SPF_PASS,UNPARSEABLE_RELAY,USER_IN_DEF_DKIM_WL,
	USER_IN_DEF_SPF_WL autolearn=disabled version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-25) on lists.ozlabs.org



On 2025/7/14 14:16, Chao Yu wrote:
> On 7/14/25 11:49, Gao Xiang wrote:
>> Hi Chao,
>>
>> On 2025/7/14 11:34, Chao Yu wrote:
>>> This patch supports to readahead more blocks in erofs_readdir(), it can
>>> enhance readdir performance in large direcotry.
>>>
>>> readdir test in a large directory which contains 12000 sub-files.
>>>
>>>          files_per_second
>>> Before:        926385.54
>>> After:        2380435.562
>>>
>>> Meanwhile, let's introduces a new sysfs entry to control page count
>>> of readahead to provide more flexible policy for readahead of readdir().
>>> - location: /sys/fs/erofs/<disk>/dir_ra_pages
>>> - default value: 4
>>> - range: [0, 128]
>>> - disable readahead: set the value to 0
>>>
>>> Signed-off-by: Chao Yu <chao@kernel.org>
>>> ---
>>> v2:
>>> - introduce sysfs node to control page count of readahead during
>>> readdir().
>>>    Documentation/ABI/testing/sysfs-fs-erofs | 7 +++++++
>>>    fs/erofs/dir.c                           | 9 +++++++++
>>>    fs/erofs/internal.h                      | 5 +++++
>>>    fs/erofs/super.c                         | 2 ++
>>>    fs/erofs/sysfs.c                         | 5 +++++
>>>    5 files changed, 28 insertions(+)
>>>
>>> diff --git a/Documentation/ABI/testing/sysfs-fs-erofs b/Documentation/ABI/testing/sysfs-fs-erofs
>>> index bf3b6299c15e..500c93484e4c 100644
>>> --- a/Documentation/ABI/testing/sysfs-fs-erofs
>>> +++ b/Documentation/ABI/testing/sysfs-fs-erofs
>>> @@ -35,3 +35,10 @@ Description:    Used to set or show hardware accelerators in effect
>>>            and multiple accelerators are separated by '\n'.
>>>            Supported accelerator(s): qat_deflate.
>>>            Disable all accelerators with an empty string (echo > accel).
>>> +
>>> +What:        /sys/fs/erofs/<disk>/dir_ra_pages
>>> +Date:        July 2025
>>> +Contact:    "Chao Yu" <chao@kernel.org>
>>> +Description:    Used to set or show page count of readahead during readdir(),
>>> +        the range of value is [0, 128], by default it is 4, set it to
>>> +        0 to disable readahead.
>>> diff --git a/fs/erofs/dir.c b/fs/erofs/dir.c
>>> index 3e4b38bec0aa..40f828d5b670 100644
>>> --- a/fs/erofs/dir.c
>>> +++ b/fs/erofs/dir.c
>>> @@ -47,8 +47,10 @@ static int erofs_readdir(struct file *f, struct dir_context *ctx)
>>>        struct inode *dir = file_inode(f);
>>>        struct erofs_buf buf = __EROFS_BUF_INITIALIZER;
>>>        struct super_block *sb = dir->i_sb;
>>> +    struct file_ra_state *ra = &f->f_ra;
>>>        unsigned long bsz = sb->s_blocksize;
>>>        unsigned int ofs = erofs_blkoff(sb, ctx->pos);
>>> +    unsigned long nr_pages = DIV_ROUND_UP_POW2(dir->i_size, PAGE_SIZE);
>>
>> why using DIV_ROUND_UP_POW2 rather than DIV_ROUND_UP here?
> 
> Seems DIV_ROUND_UP_POW2() doesn't use bit shift as expected, let
> me use DIV_ROUND_UP() instead.

Oh, I think it's fine to use DIV_ROUND_UP_POW2 here.

> 
>>
>>>        int err = 0;
>>>        bool initial = true;
>>>    @@ -63,6 +65,13 @@ static int erofs_readdir(struct file *f, struct dir_context *ctx)
>>>                break;
>>>            }
>>>    +        /* readahead blocks to enhance performance in large directory */
>>> +        if (EROFS_I_SB(dir)->dir_ra_pages && nr_pages - dbstart > 1 &&
>>
>> dbstart is a byte-oriented value, so I'm not sure if it
>> works as you expect..
> 
> Oh, I checked patch in 6.6, found that I missed to handle it correctly
> when porting code to upstream, let me fix this.
> 
>>
>>> +            !ra_has_index(ra, dbstart))
>>> +            page_cache_sync_readahead(dir->i_mapping, ra, f,
>>> +                dbstart, min(nr_pages - dbstart,
>>
>> same here.
>>
>>> +                (pgoff_t)EROFS_I_SB(dir)->dir_ra_pages));
>>> +
>>>            de = erofs_bread(&buf, dbstart, true);
>>>            if (IS_ERR(de)) {
>>>                erofs_err(sb, "failed to readdir of logical block %llu of nid %llu",
>>> diff --git a/fs/erofs/internal.h b/fs/erofs/internal.h
>>> index 0d19bde8c094..f0e5b4273aa8 100644
>>> --- a/fs/erofs/internal.h
>>> +++ b/fs/erofs/internal.h
>>> @@ -157,6 +157,7 @@ struct erofs_sb_info {
>>>        /* sysfs support */
>>>        struct kobject s_kobj;        /* /sys/fs/erofs/<devname> */
>>>        struct completion s_kobj_unregister;
>>> +    unsigned int dir_ra_pages;
>>>          /* fscache support */
>>>        struct fscache_volume *volume;
>>> @@ -238,6 +239,10 @@ EROFS_FEATURE_FUNCS(xattr_filter, compat, COMPAT_XATTR_FILTER)
>>>    #define EROFS_I_BL_XATTR_BIT    (BITS_PER_LONG - 1)
>>>    #define EROFS_I_BL_Z_BIT    (BITS_PER_LONG - 2)
>>>    +/* default/maximum readahead pages of directory */
>>> +#define DEFAULT_DIR_RA_PAGES    4
>>> +#define MAX_DIR_RA_PAGES    128
>>
>> better to add EROFS_ prefix for them.
>>
>> Also could we setup those blocks or bytes instead
>> of pages?
>>
>> If users would like to setup values, they may don't
>> care more the page size since they only care about
>> images.
> 
> Let's use bytes, and then roundup to blksize?

Agreed.

> 
>>
>> Also why do we limit maximum number even if users
>> would like to readahead more? (such as fadvise
>> allows -1 too)
> 
> No test, but I suspect there is border effect even we set it to
> i_size.
> 
> Anyway, let me remove the upper boundary limitation, unless there
> is further requirement of limitation.

Ok.

Thanks,
Gao Xiang

> 
> Thanks,
> 
>>
>> Thanks,
>> Gao Xiang
>>
> 


