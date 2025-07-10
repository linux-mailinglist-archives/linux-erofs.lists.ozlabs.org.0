Return-Path: <linux-erofs+bounces-582-lists+linux-erofs=lfdr.de@lists.ozlabs.org>
X-Original-To: lists+linux-erofs@lfdr.de
Delivered-To: lists+linux-erofs@lfdr.de
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	by mail.lfdr.de (Postfix) with ESMTPS id 61D0AAFFBA0
	for <lists+linux-erofs@lfdr.de>; Thu, 10 Jul 2025 10:04:11 +0200 (CEST)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4bd6n512xJz30VZ;
	Thu, 10 Jul 2025 18:04:09 +1000 (AEST)
X-Original-To: linux-erofs@lists.ozlabs.org
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip=115.124.30.111
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1752134649;
	cv=none; b=W9DLjr5SnZJN5BEqZjNj30u5XxaXBY9RC2EogWTzhSTvQxkwyRFhd13rYHCwLGs6lFXIvoDjAj4iu80R5Ro7lxeHIDTG8lCTw6hN2T3/GSsCuG+4p+xPUwBiE4y0QvUDtz+y3V1vBSrnkaP9oarqHEJkLmJrGiR/qp0Vk90NZkExTp1Sm2OG8s1LnT4QwN0rtVFHZdvO9m9MAv7qnFFHd2Qgkefsu11BZT/0pzhvuu+d9llf3vOryaxo+s31TfNJ+FEnfUGTXytOQ/J8eV0UloFrduOhf73nN6vjuskp5rzM+bDAfgXO2qQQldSF1ZPCYHVKak71i7pmH2PT/J16lQ==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1752134649; c=relaxed/relaxed;
	bh=w4lLUVSdrHauf9evUjus6KQO1VLwt7Ma9ZazUSCtCmA=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=Z6ipWP/icO6TZnn1LgxPjGDmNUImqloNHgwG8UOZU4NULzVzkS18cXUn1cFudATLISxJ+SiyaWD+ulNbyUWGfbgyLYfHjCPdbf1mllBCpLJfuT1SDiNVL0ZA3pmHdjazrSQfMlya42coQWGoieLmHAAMLi57koRFbRfOviN+5KfhxbDjNV4yvNaSSyCDfDK3o/PFSf0XIb9Pg0pbLL31HThd7d3kF/JoXUSNdm/3dedzXDTyeb+lqsQHm0xHUXMYksO8qTZjoM7bSLGn9d4JKjcFPI2ZBpPoCvo989adv3w2kQ11o7IgLVF7LoY2KI7cmJCBA/f8ufgZdn/51MfMwQ==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com; dkim=pass (1024-bit key; unprotected) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.a=rsa-sha256 header.s=default header.b=vBWPQgaF; dkim-atps=neutral; spf=pass (client-ip=115.124.30.111; helo=out30-111.freemail.mail.aliyun.com; envelope-from=hsiangkao@linux.alibaba.com; receiver=lists.ozlabs.org) smtp.mailfrom=linux.alibaba.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (1024-bit key; unprotected) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.a=rsa-sha256 header.s=default header.b=vBWPQgaF;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=linux.alibaba.com (client-ip=115.124.30.111; helo=out30-111.freemail.mail.aliyun.com; envelope-from=hsiangkao@linux.alibaba.com; receiver=lists.ozlabs.org)
Received: from out30-111.freemail.mail.aliyun.com (out30-111.freemail.mail.aliyun.com [115.124.30.111])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4bd6n3147vz2yMt
	for <linux-erofs@lists.ozlabs.org>; Thu, 10 Jul 2025 18:04:05 +1000 (AEST)
DKIM-Signature:v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=linux.alibaba.com; s=default;
	t=1752134642; h=Message-ID:Date:MIME-Version:Subject:To:From:Content-Type;
	bh=w4lLUVSdrHauf9evUjus6KQO1VLwt7Ma9ZazUSCtCmA=;
	b=vBWPQgaF2men60J0Lt9OH18FniO6f8C5Hk30lFeVBJ1Y+mVgZFRDtQsuqCV1xwVoXHAmqb6xQTMbrwkihcsmidwWYunGveTlgL5DIQXMgN0zgVHBS41wAuMJHVYcB8f7CwHk/S/AECwxbQjjntTeKLGv9H5xi/v4p4GGEdalaVI=
Received: from 30.221.128.137(mailfrom:hsiangkao@linux.alibaba.com fp:SMTPD_---0Wic9qR9_1752134641 cluster:ay36)
          by smtp.aliyun-inc.com;
          Thu, 10 Jul 2025 16:04:01 +0800
Message-ID: <c0e0b8ed-13b6-41a4-b978-ff4b8f5b2634@linux.alibaba.com>
Date: Thu, 10 Jul 2025 16:04:00 +0800
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
Subject: Re: [PATCH 2/2] erofs: support to readahead dirent blocks in
 erofs_readdir()
To: Chao Yu <chao@kernel.org>, xiang@kernel.org
Cc: linux-erofs@lists.ozlabs.org, linux-kernel@vger.kernel.org,
 Yue Hu <zbestahu@gmail.com>, Jeffle Xu <jefflexu@linux.alibaba.com>,
 Sandeep Dhavale <dhavale@google.com>, Hongbo Li <lihongbo22@huawei.com>
References: <20250710073619.4083422-1-chao@kernel.org>
 <20250710073619.4083422-2-chao@kernel.org>
 <8cbaa76b-f6de-4242-bd6c-629980311f4a@linux.alibaba.com>
 <2a2e0147-355b-4863-bcd7-6a227766f7b2@kernel.org>
From: Gao Xiang <hsiangkao@linux.alibaba.com>
In-Reply-To: <2a2e0147-355b-4863-bcd7-6a227766f7b2@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-15.7 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,DKIM_VALID_EF,ENV_AND_HDR_SPF_MATCH,RCVD_IN_DNSWL_NONE,
	SPF_HELO_NONE,SPF_PASS,UNPARSEABLE_RELAY,USER_IN_DEF_DKIM_WL,
	USER_IN_DEF_SPF_WL autolearn=disabled version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-25) on lists.ozlabs.org



On 2025/7/10 15:59, Chao Yu wrote:
> On 7/10/25 15:46, Gao Xiang wrote:
>> Hi Chao,
>>
>> On 2025/7/10 15:36, Chao Yu wrote:
>>> This patch supports to readahead more blocks in erofs_readdir(),
>>> it can enhance performance in large direcotry.
>>>
>>> readdir test in a large directory which contains 12000 sub-files.
>>>
>>>          files_per_second
>>> Before:        926385.54
>>> After:        2380435.562
>>>
>>> Signed-off-by: Chao Yu <chao@kernel.org>
>>> ---
>>>    fs/erofs/dir.c      | 8 ++++++++
>>>    fs/erofs/internal.h | 3 +++
>>>    2 files changed, 11 insertions(+)
>>>
>>> diff --git a/fs/erofs/dir.c b/fs/erofs/dir.c
>>> index cff61c5a172b..04113851fc0f 100644
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
>>>        int err = 0;
>>>        bool initial = true;
>>>    @@ -65,6 +67,12 @@ static int erofs_readdir(struct file *f, struct dir_context *ctx)
>>>            }
>>>            cond_resched();
>>>    +        /* readahead blocks to enhance performance in large directory */
>>> +        if (nr_pages - dbstart > 1 && !ra_has_index(ra, dbstart))
>>> +            page_cache_sync_readahead(dir->i_mapping, ra, f,
>>> +                dbstart, min(nr_pages - dbstart,
>>> +                (pgoff_t)MAX_DIR_RA_PAGES));
>>> +
>>>            de = erofs_bread(&buf, dbstart, true);
>>>            if (IS_ERR(de)) {
>>>                erofs_err(sb, "failed to readdir of logical block %llu of nid %llu",
>>> diff --git a/fs/erofs/internal.h b/fs/erofs/internal.h
>>> index a32c03a80c70..ef9d1ee8c688 100644
>>> --- a/fs/erofs/internal.h
>>> +++ b/fs/erofs/internal.h
>>> @@ -238,6 +238,9 @@ EROFS_FEATURE_FUNCS(xattr_filter, compat, COMPAT_XATTR_FILTER)
>>>    #define EROFS_I_BL_XATTR_BIT    (BITS_PER_LONG - 1)
>>>    #define EROFS_I_BL_Z_BIT    (BITS_PER_LONG - 2)
>>>    +/* maximum readahead pages of directory */
>>> +#define MAX_DIR_RA_PAGES    4
>>
>> Could we set it as a per-sb sysfs configuration for users to config?
> 
> Xiang,
> 
> Oh, that will be better, how about introducing new sysfs in separated patch?

Hi Chao,

Thanks for your interest but in that case it could cause some bisect
issue anyway, could we just use one patch to add this optimization
for slow devices?

Thanks,
Gao Xiang

> 
> Thanks,
> 
>>
>> Thanks,
>> Gao Xiang
> 


