Return-Path: <linux-erofs+bounces-76-lists+linux-erofs=lfdr.de@lists.ozlabs.org>
X-Original-To: lists+linux-erofs@lfdr.de
Delivered-To: lists+linux-erofs@lfdr.de
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2404:9400:2:0:216:3eff:fee1:b9f1])
	by mail.lfdr.de (Postfix) with ESMTPS id 07009A636C0
	for <lists+linux-erofs@lfdr.de>; Sun, 16 Mar 2025 18:20:00 +0100 (CET)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4ZG4bx3c5xz2yRm;
	Mon, 17 Mar 2025 04:19:57 +1100 (AEDT)
X-Original-To: linux-erofs@lists.ozlabs.org
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip=115.124.30.111
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1742145597;
	cv=none; b=ZHU9gzIHEghik6wWhxlGblXs+K1C9C5l9RrDzQQwc5dARI2Ce3klwkoz7cgKJrAv/+F0xZztFU9D2TgXE4bPBshf3xix4RtmDK3NSKwnAN4/IIS4eHUY1kMXIYOx/IdBB9V4XrI9zTJsn3qxTv6uPT0dlF4+ZMKGRgqZ9iYgnMew3lEl4oFrRtalclqYbZ+pLvl1fhczCehRpKVtldlFlpzlxcG8caR+D6D2BfFNF5pop1MU1s4zmudslKCy6Sj8EaKVCixY2cs50pv9knnF0i/xYjcVn7VwJYJQIvNdvJmSThmww2JI/LkWTHfiU7Hl61ur2hr8iejvvjvqbvXX4Q==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1742145597; c=relaxed/relaxed;
	bh=fzOy707LWkwGKF9chjVOZk3NWtrTE4bTaEOfE4ij2iQ=;
	h=Message-ID:Date:MIME-Version:Subject:From:To:Cc:References:
	 In-Reply-To:Content-Type; b=NQ6tWdI81+5IqZpTT4A6PMya4s3n12uR/U0NSCyVbDmoaOxCwKk7xT++Me+0SBKly3WS+GgltqXZ4qzjNJjgaCZP8d8R0KxKNp+f9wvM7irSYSBx8f2lmA8Nmgz+YI9UteVaofji1Q2pp83vdrV8xWKCrIJklj1KNHtyDEaxJw4FfNGla6cCAQ6ngyUw/K5kk86TkcRCvAV+NA5xeKaipmka25tTT9VSfTjF+rTl0mrM2rXLs9PBcUqcudtV/9Hr8LKNgbF48r9mKizFz9U3k0sUPRCyUoD0TqljotSPDgxoW5yErlzdv5u9+k1Fqc05Nc4q4hxKxBEbnsxJFrNl9g==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com; dkim=pass (1024-bit key; unprotected) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.a=rsa-sha256 header.s=default header.b=XQajXYNl; dkim-atps=neutral; spf=pass (client-ip=115.124.30.111; helo=out30-111.freemail.mail.aliyun.com; envelope-from=hsiangkao@linux.alibaba.com; receiver=lists.ozlabs.org) smtp.mailfrom=linux.alibaba.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (1024-bit key; unprotected) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.a=rsa-sha256 header.s=default header.b=XQajXYNl;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=linux.alibaba.com (client-ip=115.124.30.111; helo=out30-111.freemail.mail.aliyun.com; envelope-from=hsiangkao@linux.alibaba.com; receiver=lists.ozlabs.org)
Received: from out30-111.freemail.mail.aliyun.com (out30-111.freemail.mail.aliyun.com [115.124.30.111])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4ZG4bw2g1Zz2xlK
	for <linux-erofs@lists.ozlabs.org>; Mon, 17 Mar 2025 04:19:55 +1100 (AEDT)
DKIM-Signature:v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=linux.alibaba.com; s=default;
	t=1742145592; h=Message-ID:Date:MIME-Version:Subject:From:To:Content-Type;
	bh=fzOy707LWkwGKF9chjVOZk3NWtrTE4bTaEOfE4ij2iQ=;
	b=XQajXYNleMKe6epvwiPQMOaoopdS/cdmvAxRj2WuVsbZPXiOceB/HYq7kRJ+SbED6rni9nE1wTqMje6ZWJQAMMCzyqF43TWXdC5NWMrokDnRN2/HX+N8re90lIezExCH5LQrGSzdXf09d/T6faLh6/FnX/im1jNPTfR4b7OOWA0=
Received: from 30.134.66.95(mailfrom:hsiangkao@linux.alibaba.com fp:SMTPD_---0WRVXgmw_1742145589 cluster:ay36)
          by smtp.aliyun-inc.com;
          Mon, 17 Mar 2025 01:19:50 +0800
Message-ID: <793c8af4-d651-48ff-830d-6a8cfd18d697@linux.alibaba.com>
Date: Mon, 17 Mar 2025 01:19:49 +0800
X-Mailing-List: linux-erofs@lists.ozlabs.org
List-Id: <linux-erofs.lists.ozlabs.org>
List-Help: <mailto:linux-erofs+help@lists.ozlabs.org>
List-Owner: <mailto:linux-erofs+owner@lists.ozlabs.org>
List-Post: <mailto:linux-erofs@lists.ozlabs.org>
List-Subscribe: <mailto:linux-erofs+subscribe@lists.ozlabs.org>,
  <mailto:linux-erofs+subscribe-digest@lists.ozlabs.org>,
  <mailto:linux-erofs+subscribe-nomail@lists.ozlabs.org>
List-Unsubscribe: <mailto:linux-erofs+unsubscribe@lists.ozlabs.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v5] erofs: use Z_EROFS_LCLUSTER_TYPE_MAX to simplify
 switches
From: Gao Xiang <hsiangkao@linux.alibaba.com>
To: Chao Yu <chao@kernel.org>
Cc: linux-kernel@vger.kernel.org, Hongzhen Luo <hongzhen@linux.alibaba.com>,
 linux-erofs mailing list <linux-erofs@lists.ozlabs.org>
References: <20250210032923.3382136-1-hongzhen@linux.alibaba.com>
 <511c5fd9-307e-4c56-9d20-796dd06f775c@kernel.org>
 <489be3d1-a755-4756-ba82-a8f5a0dc9156@linux.alibaba.com>
In-Reply-To: <489be3d1-a755-4756-ba82-a8f5a0dc9156@linux.alibaba.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-15.7 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,DKIM_VALID_EF,ENV_AND_HDR_SPF_MATCH,RCVD_IN_DNSWL_NONE,
	SPF_HELO_NONE,SPF_PASS,UNPARSEABLE_RELAY,USER_IN_DEF_DKIM_WL,
	USER_IN_DEF_SPF_WL autolearn=disabled version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-25) on lists.ozlabs.org



On 2025/3/17 01:17, Gao Xiang wrote:
> Hi Chao,
> 
> On 2025/3/16 10:36, Chao Yu wrote:
>> On 2025/2/10 11:29, Hongzhen Luo wrote:
>>> There's no need to enumerate each type.  No logic changes.
>>>
>>> Signed-off-by: Hongzhen Luo <hongzhen@linux.alibaba.com>
>>
>> Looks good to me, feel free to add:
>>
>> Reviewed-by: Chao Yu <chao@kernel.org>
>>
>> And one minor comment below.
>>
>>> diff --git a/fs/erofs/zmap.c b/fs/erofs/zmap.c
>>> index 689437e99a5a..d278ebd60281 100644
>>> --- a/fs/erofs/zmap.c
>>> +++ b/fs/erofs/zmap.c
>>> @@ -265,26 +265,22 @@ static int z_erofs_extent_lookback(struct z_erofs_maprecorder *m,
>>>           if (err)
>>>               return err;
>>> -        switch (m->type) {
>>> -        case Z_EROFS_LCLUSTER_TYPE_NONHEAD:
>>> +        if (m->type >= Z_EROFS_LCLUSTER_TYPE_MAX) {
>>> +            erofs_err(sb, "unknown type %u @ lcn %lu of nid %llu",
>>> +                  m->type, lcn, vi->nid);
>>> +            DBG_BUGON(1);
>>> +            return -EOPNOTSUPP;

`m->type >= Z_EROFS_LCLUSTER_TYPE_MAX` is checked here BTW,
I think the patch is good.

Thanks,
Gao Xiang

