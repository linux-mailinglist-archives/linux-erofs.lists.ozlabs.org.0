Return-Path: <linux-erofs+bounces-662-lists+linux-erofs=lfdr.de@lists.ozlabs.org>
X-Original-To: lists+linux-erofs@lfdr.de
Delivered-To: lists+linux-erofs@lfdr.de
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	by mail.lfdr.de (Postfix) with ESMTPS id F2BB6B0996A
	for <lists+linux-erofs@lfdr.de>; Fri, 18 Jul 2025 03:52:35 +0200 (CEST)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4bjt8d0CBPz30WF;
	Fri, 18 Jul 2025 11:52:33 +1000 (AEST)
X-Original-To: linux-erofs@lists.ozlabs.org
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip="2600:3c04:e001:324:0:1991:8:25"
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1752803552;
	cv=none; b=ax1JXiBFzq/MQbmZkaszwBtPCewHsIeN5aI+NMyVfUOacQ6lWcGdWFLck4ebQaZnH+STpnqGWRCoz5Op+bY8+Q+EuCGuprb9s/bQZk7Oovrx/BiFl0w6+OztoMR/Cn/+OZzWZp5c3UCnyULPxPe+/Knerxlctl4U/ssE1X/6ZGKEpPYIhk9s1kaREIN75j3zqmFEyZrK9h62kmfxh21SXL6jbQXnr6/qLDacRxpqGDWTDbAQAE2K5Td8P4sSHEg+3Bj+ivu1qg46BvGdMUuKSnpSgo8gFdRBHKSt9TvaTNnNRVCEUV6NyJ2raLj7IhWFA7Z+T4kfuI69rCJ75QYZLQ==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1752803552; c=relaxed/relaxed;
	bh=9EQmCb+oxqaZS29hveOS877Axn5DgPFsKikYf/vg2X0=;
	h=Message-ID:Date:MIME-Version:Cc:Subject:To:References:From:
	 In-Reply-To:Content-Type; b=fugwjaMnxEWVvVTG5BHDEPjgZhjxxaFWyiMxRHNnllvjX/kYs2/4F1iUru/lRjOqcGD7MjiZMxnef0TB+g9RizW+6WYua7KgCu6jn2UEWPJKxxZcFxdm2y7KU50NhmwqLdi+tEt3dXwijOPBm4X47wn2zI76cl8Iah3OjOcx3WHJ+kYJefTkAxOuGDhMZ29yuMqlS63I1U3F32UKOLOWGxXTHjoPCk/BLBFGqrk3k6IA1XrqV8FUem43Ap0odPYD+KITeG35hv8RYUWPvwWAJdJVazHRQJGGVBrnNq0E/1PKb/UBr/qGww/2+BXYt2RMisyJwaRnvn6Qk3KEDttnFA==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=kernel.org; dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20201202 header.b=A2/DsdGy; dkim-atps=neutral; spf=pass (client-ip=2600:3c04:e001:324:0:1991:8:25; helo=tor.source.kernel.org; envelope-from=chao@kernel.org; receiver=lists.ozlabs.org) smtp.mailfrom=kernel.org
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=kernel.org
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20201202 header.b=A2/DsdGy;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=kernel.org (client-ip=2600:3c04:e001:324:0:1991:8:25; helo=tor.source.kernel.org; envelope-from=chao@kernel.org; receiver=lists.ozlabs.org)
Received: from tor.source.kernel.org (tor.source.kernel.org [IPv6:2600:3c04:e001:324:0:1991:8:25])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4bjt8b6DyDz30RK
	for <linux-erofs@lists.ozlabs.org>; Fri, 18 Jul 2025 11:52:31 +1000 (AEST)
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
	by tor.source.kernel.org (Postfix) with ESMTP id 8C2BD613F8;
	Fri, 18 Jul 2025 01:52:28 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id F0CC7C4CEF0;
	Fri, 18 Jul 2025 01:52:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1752803548;
	bh=DZenHan6HEdNoDKIaO8bmG2IU9oiW+D1QihQoYGhJXg=;
	h=Date:Cc:Subject:To:References:From:In-Reply-To:From;
	b=A2/DsdGy+8I0YzRpiNgnIjuPrIBym2QcTh+RuEGoEgLHHPcPOkS24qqFV38HuikYx
	 EjSWY2er6PPZF/4uxznCqxgIe0QvKoaXtt6mMBGHlUZOluUe3p4PX7gI3hoKAWASfc
	 IAwhcijBQXe0siBt7s+OmhUqNNgjo2cbK5rCAGwaR0bOJzI68PdTjuFdTgxC3rsIp+
	 BZK/OSrFMKH2Y+pzsGN9w1V347fN1YMyYyR/PAF2x63JCvroyUEnf3mzjMQf2NLDoe
	 CV0aeIhBlopPAiBIAbHNLT6QuKJdY1Fu1LDzKzYo3szS9WrvdGQ1wS+AdKknkvjgf/
	 buEk//nXvkFdQ==
Message-ID: <19ee5db7-814f-402b-9b06-586f7203977d@kernel.org>
Date: Fri, 18 Jul 2025 09:52:21 +0800
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
Subject: Re: [PATCH v3] erofs: support to readahead dirent blocks in
 erofs_readdir()
To: Gao Xiang <hsiangkao@linux.alibaba.com>, xiang@kernel.org
References: <20250714093935.200749-1-chao@kernel.org>
 <631728e2-2808-47af-8db7-28cd8ae17622@linux.alibaba.com>
Content-Language: en-US
From: Chao Yu <chao@kernel.org>
In-Reply-To: <631728e2-2808-47af-8db7-28cd8ae17622@linux.alibaba.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-3.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS
	autolearn=disabled version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-25) on lists.ozlabs.org

Hi Xiang,

On 2025/7/17 16:26, Gao Xiang wrote:
> Hi Chao,
> 
> On 2025/7/14 17:39, Chao Yu wrote:
>> This patch supports to readahead more blocks in erofs_readdir(), it can
>> enhance readdir performance in large direcotry.
>>
>> readdir test in a large directory which contains 12000 sub-files.
>>
>>         files_per_second
>> Before:        926385.54
>> After:        2380435.562
>>
>> Meanwhile, let's introduces a new sysfs entry to control readahead
>> bytes to provide more flexible policy for readahead of readdir().
>> - location: /sys/fs/erofs/<disk>/dir_ra_bytes
>> - default value: 16384
>> - disable readahead: set the value to 0
>>
>> Signed-off-by: Chao Yu <chao@kernel.org>
>> ---
>> v3:
>> - add EROFS prefix for macro
>> - update new sysfs interface to 1) use bytes instead of pages
>> 2) remove upper boundary limitation
>> - fix bug of pageidx calculation
>>   Documentation/ABI/testing/sysfs-fs-erofs |  8 ++++++++
>>   fs/erofs/dir.c                           | 13 +++++++++++++
>>   fs/erofs/internal.h                      |  4 ++++
>>   fs/erofs/super.c                         |  2 ++
>>   fs/erofs/sysfs.c                         |  2 ++
>>   5 files changed, 29 insertions(+)
>>
>> diff --git a/Documentation/ABI/testing/sysfs-fs-erofs b/Documentation/ 
>> ABI/testing/sysfs-fs-erofs
>> index bf3b6299c15e..85fa56ca092c 100644
>> --- a/Documentation/ABI/testing/sysfs-fs-erofs
>> +++ b/Documentation/ABI/testing/sysfs-fs-erofs
>> @@ -35,3 +35,11 @@ Description:    Used to set or show hardware 
>> accelerators in effect
>>           and multiple accelerators are separated by '\n'.
>>           Supported accelerator(s): qat_deflate.
>>           Disable all accelerators with an empty string (echo > accel).
>> +
>> +What:        /sys/fs/erofs/<disk>/dir_ra_bytes
>> +Date:        July 2025
>> +Contact:    "Chao Yu" <chao@kernel.org>
>> +Description:    Used to set or show readahead bytes during readdir(), by
>> +        default the value is 16384.
>> +
>> +        - 0: disable readahead.
>> diff --git a/fs/erofs/dir.c b/fs/erofs/dir.c
>> index 3e4b38bec0aa..950d6b0046f4 100644
>> --- a/fs/erofs/dir.c
>> +++ b/fs/erofs/dir.c
>> @@ -47,8 +47,10 @@ static int erofs_readdir(struct file *f, struct 
>> dir_context *ctx)
>>       struct inode *dir = file_inode(f);
>>       struct erofs_buf buf = __EROFS_BUF_INITIALIZER;
>>       struct super_block *sb = dir->i_sb;
>> +    struct file_ra_state *ra = &f->f_ra;
>>       unsigned long bsz = sb->s_blocksize;
>>       unsigned int ofs = erofs_blkoff(sb, ctx->pos);
>> +    unsigned long nr_pages = DIV_ROUND_UP_POW2(dir->i_size, PAGE_SIZE);
> 
>      pgoff_t ra_pages = PAGE_ALIGN(EROFS_SB(dir)->dir_ra_bytes);

Do you mean?

pgoff_t ra_pages = PAGE_ALIGN(EROFS_SB(dir)->dir_ra_bytes) >> PAGE_SHIFT?

> 
>>       int err = 0;
>>       bool initial = true;
>> @@ -63,6 +65,17 @@ static int erofs_readdir(struct file *f, struct 
>> dir_context *ctx)
>>               break;
>>           }
>> +        /* readahead blocks to enhance performance in large directory */
>> +        if (EROFS_I_SB(dir)->dir_ra_bytes) {
 > >          if (ra_pages) {
> 
>> +            unsigned long idx = DIV_ROUND_UP(ctx->pos, PAGE_SIZE);
>> +            pgoff_t ra_pages = DIV_ROUND_UP(
>> +                EROFS_I_SB(dir)->dir_ra_bytes, PAGE_SIZE);

I put calculation here because if the value is zero, we don't need 
unnecessary calculation above, anyway, will update as you suggested, but 
let me know if you have any other concerns. :)

> 
>              pgoff_t idx = PAGE_ALIGN(ctx->pos);

Ditto,

Thanks,

>              pgoff_t pages = min(nr_pages - idx, ra_pages);
> 
>> +
>> +            if (nr_pages - idx > 1 && !ra_has_index(ra, idx))
> 
>              if (pages > 1 && !ra_has_index(ra, idx))
>                  page_cache_sync_readahead(dir->i_mapping, ra,
>                                f, idx, pages)?
> 
> 
>> +                page_cache_sync_readahead(dir->i_mapping, ra,
>> +                    f, idx, min(nr_pages - idx, ra_pages));
>> +        }
>> +
>>           de = erofs_bread(&buf, dbstart, true);
>>           if (IS_ERR(de)) {
>>               erofs_err(sb, "failed to readdir of logical block %llu 
>> of nid %llu",
>> diff --git a/fs/erofs/internal.h b/fs/erofs/internal.h
>> index 0d19bde8c094..4399b9332307 100644
>> --- a/fs/erofs/internal.h
>> +++ b/fs/erofs/internal.h
>> @@ -157,6 +157,7 @@ struct erofs_sb_info {
>>       /* sysfs support */
>>       struct kobject s_kobj;        /* /sys/fs/erofs/<devname> */
>>       struct completion s_kobj_unregister;
>> +    erofs_off_t dir_ra_bytes;
>>       /* fscache support */
>>       struct fscache_volume *volume;
>> @@ -238,6 +239,9 @@ EROFS_FEATURE_FUNCS(xattr_filter, compat, 
>> COMPAT_XATTR_FILTER)
>>   #define EROFS_I_BL_XATTR_BIT    (BITS_PER_LONG - 1)
>>   #define EROFS_I_BL_Z_BIT    (BITS_PER_LONG - 2)
>> +/* default readahead size of directory */
> 
> /* default readahead size of directories */
> 
> Otherwise it looks good to me.
> 
> Thanks,
> Gao Xiang
> 
>> +#define EROFS_DIR_RA_BYTES    16384


