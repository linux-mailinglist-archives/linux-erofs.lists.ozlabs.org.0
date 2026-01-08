Return-Path: <linux-erofs+bounces-1721-lists+linux-erofs=lfdr.de@lists.ozlabs.org>
X-Original-To: lists+linux-erofs@lfdr.de
Delivered-To: lists+linux-erofs@lfdr.de
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	by mail.lfdr.de (Postfix) with ESMTPS id E1A65D02A4A
	for <lists+linux-erofs@lfdr.de>; Thu, 08 Jan 2026 13:32:41 +0100 (CET)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4dn46v27PRz2yGl;
	Thu, 08 Jan 2026 23:32:39 +1100 (AEDT)
X-Original-To: linux-erofs@lists.ozlabs.org
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip=115.124.30.132
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1767875559;
	cv=none; b=H6TWgGqalxVz26SiP5zNyGkihydBgBbtqxPb5HK2b8HmOgM4c4GBRYCkH93emowp082TdQU9AP1UuHCsWEIBmkK+cPt4lWuNOoOIhM+mzNJbqy6/hdZj6PVGDBkN4Q5Q+LB3tcv9vz1EUx7+mEApcyT8kDkeEf0Gn1EfzA8j1Egw5WTPaX9MJcDr2eN9Cdg9N8qSU1OtSTHMGoBaW4dQwTHc/VWj3BFhNWA4U2p+J3K4p+r7X9swNWzjZO8bbCyath1eTiC3bL6Tfa6xioetzyyu7w8impQ9AQ5bVIofGUClWtQshAwJL/W1GUUabTOMlHP7Cx3mrnLiIuhFpUWg8A==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1767875559; c=relaxed/relaxed;
	bh=Ua0tqkWtKiJMCR8s1xdOhAoiWaQM65A/foc/hvxNaH8=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=PJBrSGqCciz5Jh9X5/iS9jlWgEwhKLvs0dbI9gRlSQ/f7Wd3cR9Y0HNpJcYu6veievt1dMl7AvUr7buBA7UA1BT0jlLOThpIlKhk1miwqpyf0PrfuWy0PhAUrO6HV1kBBOeKcST/cr+n4WMj26IL7vzrn4/N/HwaLl7d0ByTUmeLh2wRiCJze2YUH0DAxB+A7SOzypmMN9Gp9IEA6jpQcQY+SWsO3ikZYnkasyI7Pi97OtnpaTn6q4BuUCW9uuzvKOapuyPGu9RHvQIDvpubeaPOJlx3xa0axzRiSfe9zskRI6bRCUu4RNzXPHyYAE02RM49joFBqWQPRLPcELOiUw==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com; dkim=pass (1024-bit key; unprotected) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.a=rsa-sha256 header.s=default header.b=IfQdZHwA; dkim-atps=neutral; spf=pass (client-ip=115.124.30.132; helo=out30-132.freemail.mail.aliyun.com; envelope-from=hsiangkao@linux.alibaba.com; receiver=lists.ozlabs.org) smtp.mailfrom=linux.alibaba.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (1024-bit key; unprotected) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.a=rsa-sha256 header.s=default header.b=IfQdZHwA;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=linux.alibaba.com (client-ip=115.124.30.132; helo=out30-132.freemail.mail.aliyun.com; envelope-from=hsiangkao@linux.alibaba.com; receiver=lists.ozlabs.org)
Received: from out30-132.freemail.mail.aliyun.com (out30-132.freemail.mail.aliyun.com [115.124.30.132])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4dn46r68Fdz2yGL
	for <linux-erofs@lists.ozlabs.org>; Thu, 08 Jan 2026 23:32:35 +1100 (AEDT)
DKIM-Signature:v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=linux.alibaba.com; s=default;
	t=1767875549; h=Message-ID:Date:MIME-Version:Subject:To:From:Content-Type;
	bh=Ua0tqkWtKiJMCR8s1xdOhAoiWaQM65A/foc/hvxNaH8=;
	b=IfQdZHwA7JAgvEYPRBFFINLh1u/SG899fqWqhxxdQZKgyXTF3ATIyDMlxrttSMVqGIj07Xq7fFWkQs9WBxCxsUvW3Fn4rJEGM1xNXiAw2b7ayBEgOZwC4YGymN73F+ubtC2D9NH7z/l1rNMXKEft6KAEIH947MuErckWNglVPn0=
Received: from 30.251.32.236(mailfrom:hsiangkao@linux.alibaba.com fp:SMTPD_---0WwcgEVB_1767875547 cluster:ay36)
          by smtp.aliyun-inc.com;
          Thu, 08 Jan 2026 20:32:28 +0800
Message-ID: <21190994-916e-4f6e-8a57-8f90e27e3227@linux.alibaba.com>
Date: Thu, 8 Jan 2026 20:32:27 +0800
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
Subject: Re: [PATCH v12 07/10] erofs: introduce the page cache share feature
To: Hongbo Li <lihongbo22@huawei.com>
Cc: djwong@kernel.org, amir73il@gmail.com, hch@lst.de,
 linux-fsdevel@vger.kernel.org, linux-erofs@lists.ozlabs.org,
 linux-kernel@vger.kernel.org, Chao Yu <chao@kernel.org>, brauner@kernel.org
References: <20251231090118.541061-1-lihongbo22@huawei.com>
 <20251231090118.541061-8-lihongbo22@huawei.com>
 <99a517aa-744b-487b-bce8-294b69a0cd50@linux.alibaba.com>
 <bb8e14f4-dbab-4974-a180-b436a00625d1@huawei.com>
From: Gao Xiang <hsiangkao@linux.alibaba.com>
In-Reply-To: <bb8e14f4-dbab-4974-a180-b436a00625d1@huawei.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-15.7 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,DKIM_VALID_EF,ENV_AND_HDR_SPF_MATCH,RCVD_IN_DNSWL_NONE,
	SPF_HELO_NONE,SPF_PASS,UNPARSEABLE_RELAY,USER_IN_DEF_DKIM_WL,
	USER_IN_DEF_SPF_WL autolearn=disabled version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-25) on lists.ozlabs.org



On 2026/1/8 20:20, Hongbo Li wrote:
> Hi, Xiang
> 
> On 2026/1/7 14:08, Gao Xiang wrote:
>>
>>
>> On 2025/12/31 17:01, Hongbo Li wrote:
> 
> ...
> 
>>> +
>>> +static int erofs_ishare_file_release(struct inode *inode, struct file *file)
>>> +{
>>> +    struct file *realfile = file->private_data;
>>> +
>>> +    iput(realfile->f_inode);
>>> +    fput(realfile);
>>> +    file->private_data = NULL;
>>> +    return 0;
>>> +}
>>> +
>>> +static ssize_t erofs_ishare_file_read_iter(struct kiocb *iocb,
>>> +                       struct iov_iter *to)
>>> +{
>>> +    struct file *realfile = iocb->ki_filp->private_data;
>>> +    struct kiocb dedup_iocb;
>>> +    ssize_t nread;
>>> +
>>> +    if (!iov_iter_count(to))
>>> +        return 0;
>>> +
>>> +    /* fallback to the original file in DIRECT mode */
>>> +    if (iocb->ki_flags & IOCB_DIRECT)
>>> +        realfile = iocb->ki_filp;
>>> +
>>> +    kiocb_clone(&dedup_iocb, iocb, realfile);
>>> +    nread = filemap_read(&dedup_iocb, to, 0);
>>> +    iocb->ki_pos = dedup_iocb.ki_pos;
>>
>> I think it will not work for the AIO cases.
>>
>> In order to make it simplified, how about just
>> allowing sync and non-direct I/O first, and
>> defering DIO/AIO support later?
>>
> 
> Ok, but what about doing the fallback logic:
> 
> 1. For direct io: fallback to the original file.
> 2. For AIO: initialize the sync io by init_sync_kiocb (May be we can just replace kiocb_clone with init_sync_kiocb).

No, I'd like to disallow these two types of I/Os
first and consider adding it later for simplicity.

> 
> Thanks,
> Hongbo
> 
>>> +    file_accessed(iocb->ki_filp);
>>
>> I don't think it's useful in practice.
>>
> 
> Just keep in consistent with filemap_read?

Just remove it since EROFS is an immutable fs so
there is nonsense to update atime.

Thanks,
Gao Xiang

