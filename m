Return-Path: <linux-erofs+bounces-663-lists+linux-erofs=lfdr.de@lists.ozlabs.org>
X-Original-To: lists+linux-erofs@lfdr.de
Delivered-To: lists+linux-erofs@lfdr.de
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2404:9400:2:0:216:3eff:fee1:b9f1])
	by mail.lfdr.de (Postfix) with ESMTPS id C35FFB099EA
	for <lists+linux-erofs@lfdr.de>; Fri, 18 Jul 2025 04:46:12 +0200 (CEST)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4bjvLP5Cckz3blg;
	Fri, 18 Jul 2025 12:46:05 +1000 (AEST)
X-Original-To: linux-erofs@lists.ozlabs.org
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip=115.124.30.119
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1752806765;
	cv=none; b=h1JC6boKqzLwxZ1HSrecK1IxQtibe4YDHdQf4mp3ztitnlM32MsUfBRIeIJ5TYIIBsYGvfDm+C5rMhHeNes9eEFr1/hY7nwpqWUIWdQutEQkncx3+X0WKgrSO7VU1BYyBML1Ehf/OQ1bxLOi9EBER8yuIyukkKTr7CI8oYSyxM9a4SU/0xCzykf/BERgmulAjcSXJ5grjp18tmLShADFikQhpaZFR/lWw1QJwoLw72W/yD4y3MAC18OFc71G2jcju/p0PlpWXcNRMFuGOb7QhvVTdFKTtXNXRmBKLlPnJpGEBY5YZB9Q7YdDho9Os6uKDTvnpzxgF9H9ncg3SqUTnQ==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1752806765; c=relaxed/relaxed;
	bh=EVZgpGdH2j4OBof47AaTdebWfnsCMe/x2e5JdhT5ZMU=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=bvuSz68or3rq34sWXRsAZ6S188tt2aLF8wjL4krwaj3YUNvNtuJlYn7M41hRkDe7V9wA541csmH+mHhj4yJd5gX+3pSiINiEeMks2rC9511WydA5ivQtvQdtenXsctJRntn8ivXuo75cWjRP4ye3smbpZJJ6zUJQtI9gh/tatZKF2EPucBQa9umzFqury4L4HXCJ9V+npgQslTRbyq7PEaHS607JuAmzqNmN8yGGg5oevYbXDDeo46L/a7FCizEc8FCr8Pn0WLSGTH2Ic3BZJVDquks34iICfJrPVVZIKAoFy1Krj/bXV5hYHo9c+iSuI+BWo+0Ov2bc3k8q3UTwzA==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com; dkim=pass (1024-bit key; unprotected) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.a=rsa-sha256 header.s=default header.b=W86c6SFV; dkim-atps=neutral; spf=pass (client-ip=115.124.30.119; helo=out30-119.freemail.mail.aliyun.com; envelope-from=hsiangkao@linux.alibaba.com; receiver=lists.ozlabs.org) smtp.mailfrom=linux.alibaba.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (1024-bit key; unprotected) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.a=rsa-sha256 header.s=default header.b=W86c6SFV;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=linux.alibaba.com (client-ip=115.124.30.119; helo=out30-119.freemail.mail.aliyun.com; envelope-from=hsiangkao@linux.alibaba.com; receiver=lists.ozlabs.org)
Received: from out30-119.freemail.mail.aliyun.com (out30-119.freemail.mail.aliyun.com [115.124.30.119])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4bjvLK6ZrTz2yMt
	for <linux-erofs@lists.ozlabs.org>; Fri, 18 Jul 2025 12:46:00 +1000 (AEST)
DKIM-Signature:v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=linux.alibaba.com; s=default;
	t=1752806756; h=Message-ID:Date:MIME-Version:Subject:To:From:Content-Type;
	bh=EVZgpGdH2j4OBof47AaTdebWfnsCMe/x2e5JdhT5ZMU=;
	b=W86c6SFVM5XqryxllsO/Nb50ltqBgRs6bauSP6LDy5SawgzTiDxpTvwWzAkYPpYjM/3mGiuRQCVc+tBY2q1j3llLgULZTJbQxtPrCeGryhe9LdPd+I8TAzpRQpzCvcAtkHgJ9P46T06dQ2AMp1UcExzx3fGICul9LN3AxSyGqeQ=
Received: from 30.221.129.126(mailfrom:hsiangkao@linux.alibaba.com fp:SMTPD_---0WjAiLZk_1752806753 cluster:ay36)
          by smtp.aliyun-inc.com;
          Fri, 18 Jul 2025 10:45:54 +0800
Message-ID: <10bce97b-1a17-462f-aac3-af5b7847f670@linux.alibaba.com>
Date: Fri, 18 Jul 2025 10:45:53 +0800
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
Subject: Re: [PATCH v3] erofs: support to readahead dirent blocks in
 erofs_readdir()
To: Chao Yu <chao@kernel.org>, xiang@kernel.org
Cc: linux-erofs@lists.ozlabs.org, linux-kernel@vger.kernel.org,
 Yue Hu <zbestahu@gmail.com>, Jeffle Xu <jefflexu@linux.alibaba.com>,
 Sandeep Dhavale <dhavale@google.com>, Hongbo Li <lihongbo22@huawei.com>
References: <20250714093935.200749-1-chao@kernel.org>
 <631728e2-2808-47af-8db7-28cd8ae17622@linux.alibaba.com>
 <19ee5db7-814f-402b-9b06-586f7203977d@kernel.org>
From: Gao Xiang <hsiangkao@linux.alibaba.com>
In-Reply-To: <19ee5db7-814f-402b-9b06-586f7203977d@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-15.7 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,DKIM_VALID_EF,ENV_AND_HDR_SPF_MATCH,RCVD_IN_DNSWL_NONE,
	SPF_HELO_NONE,SPF_PASS,UNPARSEABLE_RELAY,USER_IN_DEF_DKIM_WL,
	USER_IN_DEF_SPF_WL autolearn=disabled version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-25) on lists.ozlabs.org



On 2025/7/18 09:52, Chao Yu wrote:
> Hi Xiang,
> 
> On 2025/7/17 16:26, Gao Xiang wrote:
>> Hi Chao,
>>
>> On 2025/7/14 17:39, Chao Yu wrote:
>>> This patch supports to readahead more blocks in erofs_readdir(), it can
>>> enhance readdir performance in large direcotry.
>>>
>>> readdir test in a large directory which contains 12000 sub-files.
>>>
>>>         files_per_second
>>> Before:        926385.54
>>> After:        2380435.562
>>>
>>> Meanwhile, let's introduces a new sysfs entry to control readahead
>>> bytes to provide more flexible policy for readahead of readdir().
>>> - location: /sys/fs/erofs/<disk>/dir_ra_bytes
>>> - default value: 16384
>>> - disable readahead: set the value to 0
>>>
>>> Signed-off-by: Chao Yu <chao@kernel.org>
>>> ---
>>> v3:
>>> - add EROFS prefix for macro
>>> - update new sysfs interface to 1) use bytes instead of pages
>>> 2) remove upper boundary limitation
>>> - fix bug of pageidx calculation
>>>   Documentation/ABI/testing/sysfs-fs-erofs |  8 ++++++++
>>>   fs/erofs/dir.c                           | 13 +++++++++++++
>>>   fs/erofs/internal.h                      |  4 ++++
>>>   fs/erofs/super.c                         |  2 ++
>>>   fs/erofs/sysfs.c                         |  2 ++
>>>   5 files changed, 29 insertions(+)
>>>
>>> diff --git a/Documentation/ABI/testing/sysfs-fs-erofs b/Documentation/ ABI/testing/sysfs-fs-erofs
>>> index bf3b6299c15e..85fa56ca092c 100644
>>> --- a/Documentation/ABI/testing/sysfs-fs-erofs
>>> +++ b/Documentation/ABI/testing/sysfs-fs-erofs
>>> @@ -35,3 +35,11 @@ Description:    Used to set or show hardware accelerators in effect
>>>           and multiple accelerators are separated by '\n'.
>>>           Supported accelerator(s): qat_deflate.
>>>           Disable all accelerators with an empty string (echo > accel).
>>> +
>>> +What:        /sys/fs/erofs/<disk>/dir_ra_bytes
>>> +Date:        July 2025
>>> +Contact:    "Chao Yu" <chao@kernel.org>
>>> +Description:    Used to set or show readahead bytes during readdir(), by
>>> +        default the value is 16384.
>>> +
>>> +        - 0: disable readahead.
>>> diff --git a/fs/erofs/dir.c b/fs/erofs/dir.c
>>> index 3e4b38bec0aa..950d6b0046f4 100644
>>> --- a/fs/erofs/dir.c
>>> +++ b/fs/erofs/dir.c
>>> @@ -47,8 +47,10 @@ static int erofs_readdir(struct file *f, struct dir_context *ctx)
>>>       struct inode *dir = file_inode(f);
>>>       struct erofs_buf buf = __EROFS_BUF_INITIALIZER;
>>>       struct super_block *sb = dir->i_sb;
>>> +    struct file_ra_state *ra = &f->f_ra;
>>>       unsigned long bsz = sb->s_blocksize;
>>>       unsigned int ofs = erofs_blkoff(sb, ctx->pos);
>>> +    unsigned long nr_pages = DIV_ROUND_UP_POW2(dir->i_size, PAGE_SIZE);
>>
>>      pgoff_t ra_pages = PAGE_ALIGN(EROFS_SB(dir)->dir_ra_bytes);
> 
> Do you mean?
> 
> pgoff_t ra_pages = PAGE_ALIGN(EROFS_SB(dir)->dir_ra_bytes) >> PAGE_SHIFT?

That seems more complicated, sigh, I think the original
DIV_ROUND_UP_POW2() is better.

> 
>>
>>>       int err = 0;
>>>       bool initial = true;
>>> @@ -63,6 +65,17 @@ static int erofs_readdir(struct file *f, struct dir_context *ctx)
>>>               break;
>>>           }
>>> +        /* readahead blocks to enhance performance in large directory */
>>> +        if (EROFS_I_SB(dir)->dir_ra_bytes) {
>  > >          if (ra_pages) {
>>
>>> +            unsigned long idx = DIV_ROUND_UP(ctx->pos, PAGE_SIZE);
>>> +            pgoff_t ra_pages = DIV_ROUND_UP(
>>> +                EROFS_I_SB(dir)->dir_ra_bytes, PAGE_SIZE);
> 
> I put calculation here because if the value is zero, we don't need unnecessary calculation above, anyway, will update as you suggested, but let me know if you have any other concerns. :)

If only shift calculatiion is needed, I guess it
should not have much overhead, like:

		if (ra_pages) {
			pgoff_t idx = DIV_ROUND_UP_POW2(ctx->pos, PAGE_SIZE);
			pgoff_t pages = min(nr_pages - idx, ra_pages);

			...

Thanks,
Gao Xiang

