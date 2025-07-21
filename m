Return-Path: <linux-erofs+bounces-685-lists+linux-erofs=lfdr.de@lists.ozlabs.org>
X-Original-To: lists+linux-erofs@lfdr.de
Delivered-To: lists+linux-erofs@lfdr.de
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	by mail.lfdr.de (Postfix) with ESMTPS id 862F8B0BB4B
	for <lists+linux-erofs@lfdr.de>; Mon, 21 Jul 2025 05:16:33 +0200 (CEST)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4bllt04FNBz2yRD;
	Mon, 21 Jul 2025 13:16:24 +1000 (AEST)
X-Original-To: linux-erofs@lists.ozlabs.org
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip="2604:1380:45d1:ec00::3"
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1753067784;
	cv=none; b=OSWM14ZLcGA2PDcN/jnZp3NmZhO4d9PbdLUa7rQnTZUGv3RhsvYO7+35UZXijWGZHE/spYMVojpuBVwaWlwS53uQmUametAmuX5qu1bBh7tT6aZIlNgYTA6B/Stkha97aQAX3gw/oY8dgGCm9L/v1SO7YedIsq5K6mBb+6EN7gmObwxcrww61XSsTgnyjETZSVFd7erqGvh9tSB27gTQ+cEW2L7RZEKv1kdXCMIPZGxiJ+rUu7Y2atc0dZTwYP2AnBjB6oGzbY6fyQKj1r+r0AnOHmXkSMk5ct47GGZ2nZ9Hc7iA24aM9Ri5VMjCy0qLlld9S0401eaVtguuoXEOQA==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1753067784; c=relaxed/relaxed;
	bh=UZNobycrt1GsYLZvNyC5pbNZtPHtfZQOh4kQPqr8i2Y=;
	h=Message-ID:Date:MIME-Version:Cc:Subject:To:References:From:
	 In-Reply-To:Content-Type; b=kQFw7VoZ36BxuXFAyuiu7RDN1Pdq5c7Jg4LLyLQT31I2lDFtWGLnxtfqKJibEGcd/l3/9XaV4CUh2nTKbB69oOXvFfSLLvcw1oQs406v8jFuAc2jXmG/NMUjFWeuIv+A1Gr26KZQbV77hWV6zgGoFrsmIJ2yalBMx5l0c9mIbtpbof9MRMgbOmko+gLP5h25Oq0REzIJ8hTguNexWkQ7DOgqsMQXbkrnw2QCwxdJ8bKJ+Z1wxI2n/Uqo14oZirWQJUUUpUnclRDZD7tQek3NFfp53OGxPmLKh5Wf/2p0Y/f6qnkB4NOd/GLmxzckc0oqHjWTuuInA7neQ2S9Es9yjw==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=kernel.org; dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20201202 header.b=oCgoyB/a; dkim-atps=neutral; spf=pass (client-ip=2604:1380:45d1:ec00::3; helo=nyc.source.kernel.org; envelope-from=chao@kernel.org; receiver=lists.ozlabs.org) smtp.mailfrom=kernel.org
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=kernel.org
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20201202 header.b=oCgoyB/a;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=kernel.org (client-ip=2604:1380:45d1:ec00::3; helo=nyc.source.kernel.org; envelope-from=chao@kernel.org; receiver=lists.ozlabs.org)
Received: from nyc.source.kernel.org (nyc.source.kernel.org [IPv6:2604:1380:45d1:ec00::3])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4bllsz4yHdz2yFQ
	for <linux-erofs@lists.ozlabs.org>; Mon, 21 Jul 2025 13:16:23 +1000 (AEST)
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
	by nyc.source.kernel.org (Postfix) with ESMTP id 32A88A52746;
	Mon, 21 Jul 2025 03:16:21 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B29F4C4CEE7;
	Mon, 21 Jul 2025 03:16:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1753067780;
	bh=Nw5seF9MEuTiXjenbHZetewAcRt6dVK+T1m7D8mi55o=;
	h=Date:Cc:Subject:To:References:From:In-Reply-To:From;
	b=oCgoyB/aaQ8DLJ+mYs4v/2103iPAE62a9RHCFTaZNsGmEYABYmPkhyorCrp0XnIfz
	 v2vl9VU+vljvsmIHtblflE1CdZuqOIaxTij2NZbFjzxXfM2Ycqszuma7HyOuqlsrDz
	 0SjUAWhAgQBL1osZ59uRBSEbeo4HzLm4IjUHwIN8LyomgAabgN6Jk0H+RMeJB2Nihm
	 r9k10CVM05fBFn4XQOnNtNGXscg7BfW/iOrA36h/ll9hmSkqqIBSDLqILTv3Zc+mLZ
	 msp58fUzfO9SEGFC+L/hLxfqQb6uK6kZWcFLaoUqxBMipLijA9Qt64OS75n7wAWZ1+
	 5rUhLWuniej/g==
Message-ID: <e2aeb886-cb45-4f75-aaf9-7f0855b3a87a@kernel.org>
Date: Mon, 21 Jul 2025 11:16:16 +0800
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
Subject: Re: [PATCH v4] erofs: support to readahead dirent blocks in
 erofs_readdir()
To: Gao Xiang <hsiangkao@linux.alibaba.com>, xiang@kernel.org
References: <20250721021352.2495371-1-chao@kernel.org>
 <085b2e3f-223f-4867-9fac-99cf7cb2fa21@linux.alibaba.com>
Content-Language: en-US
From: Chao Yu <chao@kernel.org>
In-Reply-To: <085b2e3f-223f-4867-9fac-99cf7cb2fa21@linux.alibaba.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-3.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS
	autolearn=disabled version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-25) on lists.ozlabs.org

On 7/21/25 10:24, Gao Xiang wrote:
> 
> 
> On 2025/7/21 10:13, Chao Yu wrote:
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
>> v4:
>> - clean up codes and comments
>>   Documentation/ABI/testing/sysfs-fs-erofs |  8 ++++++++
>>   fs/erofs/dir.c                           | 14 ++++++++++++++
>>   fs/erofs/internal.h                      |  4 ++++
>>   fs/erofs/super.c                         |  2 ++
>>   fs/erofs/sysfs.c                         |  2 ++
>>   5 files changed, 30 insertions(+)
>>
>> diff --git a/Documentation/ABI/testing/sysfs-fs-erofs b/Documentation/ABI/testing/sysfs-fs-erofs
>> index bf3b6299c15e..85fa56ca092c 100644
>> --- a/Documentation/ABI/testing/sysfs-fs-erofs
>> +++ b/Documentation/ABI/testing/sysfs-fs-erofs
>> @@ -35,3 +35,11 @@ Description:    Used to set or show hardware accelerators in effect
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
>> index 3e4b38bec0aa..99745c272b60 100644
>> --- a/fs/erofs/dir.c
>> +++ b/fs/erofs/dir.c
>> @@ -47,8 +47,12 @@ static int erofs_readdir(struct file *f, struct dir_context *ctx)
>>       struct inode *dir = file_inode(f);
>>       struct erofs_buf buf = __EROFS_BUF_INITIALIZER;
>>       struct super_block *sb = dir->i_sb;
>> +    struct file_ra_state *ra = &f->f_ra;
>>       unsigned long bsz = sb->s_blocksize;
>>       unsigned int ofs = erofs_blkoff(sb, ctx->pos);
>> +    pgoff_t ra_pages = DIV_ROUND_UP_POW2(
>> +            EROFS_I_SB(dir)->dir_ra_bytes, PAGE_SIZE);
>> +    pgoff_t nr_pages = DIV_ROUND_UP_POW2(dir->i_size, PAGE_SIZE);
>>       int err = 0;
>>       bool initial = true;
>>   @@ -63,6 +67,16 @@ static int erofs_readdir(struct file *f, struct dir_context *ctx)
>>               break;
>>           }
>>   +        /* readahead blocks to enhance performance in large directory */
>> +        if (ra_pages) {
>> +            pgoff_t idx = DIV_ROUND_UP(ctx->pos, PAGE_SIZE);
> 
> Can we use DIV_ROUND_UP_POW2 here too? If it's okay,
> I will update the patch manually when applied.

Xiang,

Yeah, looks fine to me.

Please go ahead to update it while applying, thanks for your help. :)

Thanks,

> 
> Otherwise it looks good to me,
> Reviewed-by: Gao Xiang <hsiangkao@linux.alibaba.com>
> 
> Thanks,
> Gao Xiang


