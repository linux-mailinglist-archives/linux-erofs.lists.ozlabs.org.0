Return-Path: <linux-erofs+bounces-584-lists+linux-erofs=lfdr.de@lists.ozlabs.org>
X-Original-To: lists+linux-erofs@lfdr.de
Delivered-To: lists+linux-erofs@lfdr.de
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	by mail.lfdr.de (Postfix) with ESMTPS id AD1C7B0031B
	for <lists+linux-erofs@lfdr.de>; Thu, 10 Jul 2025 15:15:25 +0200 (CEST)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4bdFhC19BNz30VZ;
	Thu, 10 Jul 2025 23:15:23 +1000 (AEST)
X-Original-To: linux-erofs@lists.ozlabs.org
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip="2604:1380:45d1:ec00::3"
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1752153323;
	cv=none; b=NC55S/m3HgVQJsgQb1rWBBOx07cu6hbFb1fVnwziprz98ZgI9A6qbRFgS9aiVQv3UA9OudcKa2aE/cqQ9PnVGuf+IYZvFcgNopXnGIjTx+RXiP1/BKqtt/Bjlj518PZcEjQkznvpc7aeTwhzPRVfCatDpd92EtTA/VDJMJEAC2/qh8uQ2xU5hovD8LoL2AL7/PpWno5mE9lwnK4ZKocKdAi2yyTjz1Lszus4E4gjHFF/QQtgkwumyJ1xmJ9IvnzSL2QlSRGUj9YIzpdGvk/ILFUU0gd7DmQ20gg+yQSMHXikjFRtr3IZLRiPGNLpma+K9HH9t79hdds1EMfBrRdGaQ==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1752153323; c=relaxed/relaxed;
	bh=sSyi4tgw13RXLbwwC93PVPO55Ml+XG8ByKMxJQQ2U+I=;
	h=Message-ID:Date:MIME-Version:Cc:Subject:To:References:From:
	 In-Reply-To:Content-Type; b=TQSWDoJZkkKz2YLdwXwQlA9YhLN3Rm+vCZgm/A8vf1JpLEMyqvi7vhrD9Rl1aS2C/R+CgBm57FoYOglLIYpqH3mcbcuaxCoLXfknHmSqpr9g6lh+A/yDEJSZCvSjy13g/G6Fdw4k//SHukl6Q6fgV4hkT2M7ZzLlQPJP7zLHnNYDZQ0cxRgvzRiDEBgNlyJ8pMO0av79Eery0rstGJFRPzobLXQd4+SUW5b1TJCKId181cla8ZI6M7ZpNYGbOkCupzrygSK4w10qH42Fdk0dYUajTf7jTV7GYNaQ4KjQeacFjqqeGx4NBX2Mx67hnhAj5r1ZoEAOHu9PR7a7T4Zafw==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=kernel.org; dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20201202 header.b=HeKZX4sK; dkim-atps=neutral; spf=pass (client-ip=2604:1380:45d1:ec00::3; helo=nyc.source.kernel.org; envelope-from=chao@kernel.org; receiver=lists.ozlabs.org) smtp.mailfrom=kernel.org
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=kernel.org
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20201202 header.b=HeKZX4sK;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=kernel.org (client-ip=2604:1380:45d1:ec00::3; helo=nyc.source.kernel.org; envelope-from=chao@kernel.org; receiver=lists.ozlabs.org)
Received: from nyc.source.kernel.org (nyc.source.kernel.org [IPv6:2604:1380:45d1:ec00::3])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4bdFh96Ds6z2yGM
	for <linux-erofs@lists.ozlabs.org>; Thu, 10 Jul 2025 23:15:21 +1000 (AEST)
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
	by nyc.source.kernel.org (Postfix) with ESMTP id 1FDCFA548D6;
	Thu, 10 Jul 2025 13:15:18 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 256FAC4CEE3;
	Thu, 10 Jul 2025 13:15:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1752153317;
	bh=pvunt5eG5jjQjrQBbk3om39+1F4Hjs2yoeH3t0iPqo4=;
	h=Date:Cc:Subject:To:References:From:In-Reply-To:From;
	b=HeKZX4sK3OuQnuSdf3xL0o30Oa3B5fsldNuYpBE/8IbNGfgcfBDtLVPNItPY8Lzj+
	 bPMv4O+GGDFLHrLdQbzi59IHRT30uXh0T2499MEljGPtYMnEdfsDtsojRTSNVWv5tl
	 DUIRkL3K2dfb/wU+nYcq5wbbkYQ5p8YlWYxrvO5BBjf17yM9onBlSNAmuu734fZDfS
	 f3ftR2pHzEd8oN1/mcuV7D1ySQGCxT8sDIQbvDEfb0WqpJo0QrITKpTQAg/fQM962i
	 upemzxKkx/sKYNPJ01/QO39piSxYOJCCGQ1tGwX5umlkYnuChVVTkvKU+/PJTpG8og
	 h+wMe9tXVePvg==
Message-ID: <2d772d8b-1314-4af6-b17a-b5f09acbf25b@kernel.org>
Date: Thu, 10 Jul 2025 21:15:10 +0800
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
Subject: Re: [PATCH 2/2] erofs: support to readahead dirent blocks in
 erofs_readdir()
To: Gao Xiang <hsiangkao@linux.alibaba.com>, xiang@kernel.org
References: <20250710073619.4083422-1-chao@kernel.org>
 <20250710073619.4083422-2-chao@kernel.org>
 <8cbaa76b-f6de-4242-bd6c-629980311f4a@linux.alibaba.com>
 <2a2e0147-355b-4863-bcd7-6a227766f7b2@kernel.org>
 <c0e0b8ed-13b6-41a4-b978-ff4b8f5b2634@linux.alibaba.com>
Content-Language: en-US
From: Chao Yu <chao@kernel.org>
In-Reply-To: <c0e0b8ed-13b6-41a4-b978-ff4b8f5b2634@linux.alibaba.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-3.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS
	autolearn=disabled version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-25) on lists.ozlabs.org

On 7/10/25 16:04, Gao Xiang wrote:
> 
> 
> On 2025/7/10 15:59, Chao Yu wrote:
>> On 7/10/25 15:46, Gao Xiang wrote:
>>> Hi Chao,
>>>
>>> On 2025/7/10 15:36, Chao Yu wrote:
>>>> This patch supports to readahead more blocks in erofs_readdir(),
>>>> it can enhance performance in large direcotry.
>>>>
>>>> readdir test in a large directory which contains 12000 sub-files.
>>>>
>>>>          files_per_second
>>>> Before:        926385.54
>>>> After:        2380435.562
>>>>
>>>> Signed-off-by: Chao Yu <chao@kernel.org>
>>>> ---
>>>>    fs/erofs/dir.c      | 8 ++++++++
>>>>    fs/erofs/internal.h | 3 +++
>>>>    2 files changed, 11 insertions(+)
>>>>
>>>> diff --git a/fs/erofs/dir.c b/fs/erofs/dir.c
>>>> index cff61c5a172b..04113851fc0f 100644
>>>> --- a/fs/erofs/dir.c
>>>> +++ b/fs/erofs/dir.c
>>>> @@ -47,8 +47,10 @@ static int erofs_readdir(struct file *f, struct dir_context *ctx)
>>>>        struct inode *dir = file_inode(f);
>>>>        struct erofs_buf buf = __EROFS_BUF_INITIALIZER;
>>>>        struct super_block *sb = dir->i_sb;
>>>> +    struct file_ra_state *ra = &f->f_ra;
>>>>        unsigned long bsz = sb->s_blocksize;
>>>>        unsigned int ofs = erofs_blkoff(sb, ctx->pos);
>>>> +    unsigned long nr_pages = DIV_ROUND_UP_POW2(dir->i_size, PAGE_SIZE);
>>>>        int err = 0;
>>>>        bool initial = true;
>>>>    @@ -65,6 +67,12 @@ static int erofs_readdir(struct file *f, struct dir_context *ctx)
>>>>            }
>>>>            cond_resched();
>>>>    +        /* readahead blocks to enhance performance in large directory */
>>>> +        if (nr_pages - dbstart > 1 && !ra_has_index(ra, dbstart))
>>>> +            page_cache_sync_readahead(dir->i_mapping, ra, f,
>>>> +                dbstart, min(nr_pages - dbstart,
>>>> +                (pgoff_t)MAX_DIR_RA_PAGES));
>>>> +
>>>>            de = erofs_bread(&buf, dbstart, true);
>>>>            if (IS_ERR(de)) {
>>>>                erofs_err(sb, "failed to readdir of logical block %llu of nid %llu",
>>>> diff --git a/fs/erofs/internal.h b/fs/erofs/internal.h
>>>> index a32c03a80c70..ef9d1ee8c688 100644
>>>> --- a/fs/erofs/internal.h
>>>> +++ b/fs/erofs/internal.h
>>>> @@ -238,6 +238,9 @@ EROFS_FEATURE_FUNCS(xattr_filter, compat, COMPAT_XATTR_FILTER)
>>>>    #define EROFS_I_BL_XATTR_BIT    (BITS_PER_LONG - 1)
>>>>    #define EROFS_I_BL_Z_BIT    (BITS_PER_LONG - 2)
>>>>    +/* maximum readahead pages of directory */
>>>> +#define MAX_DIR_RA_PAGES    4
>>>
>>> Could we set it as a per-sb sysfs configuration for users to config?
>>
>> Xiang,
>>
>> Oh, that will be better, how about introducing new sysfs in separated patch?
> 
> Hi Chao,
> 
> Thanks for your interest but in that case it could cause some bisect
> issue anyway, could we just use one patch to add this optimization
> for slow devices?

Xiang,

Yeah, one patch includes all these looks fine to me, anyway, let me update v2.

Thanks,

> 
> Thanks,
> Gao Xiang
> 
>>
>> Thanks,
>>
>>>
>>> Thanks,
>>> Gao Xiang
>>
> 


