Return-Path: <linux-erofs+bounces-1384-lists+linux-erofs=lfdr.de@lists.ozlabs.org>
X-Original-To: lists+linux-erofs@lfdr.de
Delivered-To: lists+linux-erofs@lfdr.de
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2404:9400:2:0:216:3eff:fee1:b9f1])
	by mail.lfdr.de (Postfix) with ESMTPS id B390FC623EA
	for <lists+linux-erofs@lfdr.de>; Mon, 17 Nov 2025 04:30:27 +0100 (CET)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4d8tYF46Qnz2xQq;
	Mon, 17 Nov 2025 14:30:25 +1100 (AEDT)
X-Original-To: linux-erofs@lists.ozlabs.org
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip=115.124.30.131
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1763350225;
	cv=none; b=mKtC96ZP5mLcGwLDvCoXZy6odH3ullE3pjzsMH0B446WOXcgM73jFyQY3j3BJJTxJWKcC4MDNphwqJ0IAUq41enVyzlDjolpLsGX5pN4qTN8NQrIy8yq01JUbzUNoWCGsfHbivGTe6LoTlXxXlcHxR2NfXEfbdgLsZngir6orh9+1RB9NZXzCSlFjGiYV7HYyqduVScCA0LrSTe31+qIrUitp/GngHHtNrdzkVqTe+jyquAoJ0vNTKdnq+LLncN7zOJNg5jGkq1cxeFAwoQeDxD00DrotU2uWxtf9brze0ATiHX+ic+iGwMVPr036SYXQB4nDejVA+6A8MbCGo/B3A==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1763350225; c=relaxed/relaxed;
	bh=77VBZxawPoiblVroVwdi0fB2t1X1ZR/kaNSvk7n/vPE=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=hsrf3FXuqVCsRlIpKoUuapK7i33HEkqYVyz1OK7OmYO2MLriVG0q2yjBmOkGGKXfA7Zbcw1U8gHDf0FMwTi0VGVWfgKKritGfdrZTPah/7mLVEoFeUttn1xy/2bpMj+ZXJhhShFlhBmAuxJBnvheIe+NKOxWUk0LW8Spn9pK5O68QBMZIKgUp4lVmefQidpNy0VDuNKvPru1Ui5aXMVoPwDCWRUuDw5w5m6zh7Tx+7WUUvDyh8MF175tgj9OOGcB5pGy08Nfe9zHVbqM22hFkIrmF7/Z9wlYetx/U10CZx/MDXX4e0tHBHQfHmLVd7jI6ndVyXXQyFNG1Uk9pFDeGA==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com; dkim=pass (1024-bit key; unprotected) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.a=rsa-sha256 header.s=default header.b=g88jXh6T; dkim-atps=neutral; spf=pass (client-ip=115.124.30.131; helo=out30-131.freemail.mail.aliyun.com; envelope-from=hsiangkao@linux.alibaba.com; receiver=lists.ozlabs.org) smtp.mailfrom=linux.alibaba.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (1024-bit key; unprotected) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.a=rsa-sha256 header.s=default header.b=g88jXh6T;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=linux.alibaba.com (client-ip=115.124.30.131; helo=out30-131.freemail.mail.aliyun.com; envelope-from=hsiangkao@linux.alibaba.com; receiver=lists.ozlabs.org)
Received: from out30-131.freemail.mail.aliyun.com (out30-131.freemail.mail.aliyun.com [115.124.30.131])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4d8tYC3JSfz2xQD
	for <linux-erofs@lists.ozlabs.org>; Mon, 17 Nov 2025 14:30:20 +1100 (AEDT)
DKIM-Signature:v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=linux.alibaba.com; s=default;
	t=1763350216; h=Message-ID:Date:MIME-Version:Subject:To:From:Content-Type;
	bh=77VBZxawPoiblVroVwdi0fB2t1X1ZR/kaNSvk7n/vPE=;
	b=g88jXh6Tf/6/5yvD4XAuq5J0Lq/HTIfyYqUxE0wRvI7cIidDm+yrg6guR/UHyOh4h/wbAwiyHPx2S+fIZ0nSkIQbYyfee4mhDEcDY/KeHrJyWWkU1t5L6HOfQDLSyBnI6GrE2vHz2vHSYlEnfT+oDSEzqgZ2cM8codutXu6T30c=
Received: from 30.221.131.30(mailfrom:hsiangkao@linux.alibaba.com fp:SMTPD_---0WsTuAU5_1763350214 cluster:ay36)
          by smtp.aliyun-inc.com;
          Mon, 17 Nov 2025 11:30:14 +0800
Message-ID: <4a6164d9-7959-4ce8-97b4-5a5154a3f037@linux.alibaba.com>
Date: Mon, 17 Nov 2025 11:30:13 +0800
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
Subject: Re: [PATCH v8 6/9] erofs: introduce the page cache share feature
To: Hongbo Li <lihongbo22@huawei.com>, chao@kernel.org, brauner@kernel.org,
 djwong@kernel.org, amir73il@gmail.com, joannelkoong@gmail.com
Cc: linux-fsdevel@vger.kernel.org, linux-erofs@lists.ozlabs.org,
 linux-kernel@vger.kernel.org
References: <20251114095516.207555-1-lihongbo22@huawei.com>
 <20251114095516.207555-7-lihongbo22@huawei.com>
 <ac1b5431-e71f-430d-8309-8d007dc449b9@linux.alibaba.com>
 <cb040afb-a025-4dbb-9866-4772b24a3b8e@huawei.com>
From: Gao Xiang <hsiangkao@linux.alibaba.com>
In-Reply-To: <cb040afb-a025-4dbb-9866-4772b24a3b8e@huawei.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-15.7 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,DKIM_VALID_EF,ENV_AND_HDR_SPF_MATCH,RCVD_IN_DNSWL_NONE,
	SPF_HELO_NONE,SPF_PASS,UNPARSEABLE_RELAY,USER_IN_DEF_DKIM_WL,
	USER_IN_DEF_SPF_WL autolearn=disabled version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-25) on lists.ozlabs.org



On 2025/11/17 11:14, Hongbo Li wrote:
> Hi Xiang
> 
> On 2025/11/17 11:06, Gao Xiang wrote:
>>
>>
>> On 2025/11/14 17:55, Hongbo Li wrote:
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
>>> Signed-off-by: Hongzhen Luo <hongzhen@linux.alibaba.com>
>>> Signed-off-by: Hongbo Li <lihongbo22@huawei.com>
>>> ---
>>
>> ...
>>
>>
>>> +
>>> +static int erofs_ishare_file_open(struct inode *inode, struct file *file)
>>> +{
>>> +    struct file *realfile;
>>> +    struct inode *dedup;
>>> +
>>> +    dedup = EROFS_I(inode)->ishare;
>>> +    if (!dedup)
>>> +        return -EINVAL;
>>> +
>>> +    realfile = alloc_file_pseudo(dedup, erofs_ishare_mnt, "erofs_ishare_file",
>>> +                     O_RDONLY, &erofs_file_fops);
>>> +    if (IS_ERR(realfile))
>>> +        return PTR_ERR(realfile);
>>> +
>>> +    file_ra_state_init(&realfile->f_ra, file->f_mapping);
>>> +    realfile->private_data = EROFS_I(inode);
>>> +    file->private_data = realfile;
>>> +    return 0;
>>
> 
> My apologies, I got it wrong. The latest code wasn't synced. The most current version should be this one.
> 
> static int erofs_ishare_file_open(struct inode *inode, struct file *file)
> {
>      struct file *realfile;
>      struct inode *dedup;
>      char *buf, *filepath;
> 
>      dedup = EROFS_I(inode)->ishare;
>      if (!dedup)
>          return -EINVAL;
> 
>      buf = kmalloc(PATH_MAX, GFP_KERNEL);
>      if (!buf)
>          return -ENOMEM;
>      filepath = file_path(file, buf, PATH_MAX);
>      if (IS_ERR(filepath)) {
>          kfree(buf);
>          return -PTR_ERR(filepath);
>      }
>      realfile = alloc_file_pseudo(dedup, erofs_ishare_mnt, filepath + 1,
>                       O_RDONLY, &erofs_file_fops);
>      kfree(buf);
>      if (IS_ERR(realfile))
>          return PTR_ERR(realfile);
> 
>      file_ra_state_init(&realfile->f_ra, file->f_mapping);
>      ihold(dedup);
>      realfile->private_data = EROFS_I(inode);
>      file->private_data = realfile;
>      return 0;
> }
> 
> I changed the "erofs_ishare_file" with filepath + 1 to display the realpath of the original file.

Although it could work for file_user_path() [but it's unclean on my side],
but file_user_inode() still doesn't work.

You should adapt backing_file infrastructure instead.

Thanks,
Gao Xiang

