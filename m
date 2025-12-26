Return-Path: <linux-erofs+bounces-1615-lists+linux-erofs=lfdr.de@lists.ozlabs.org>
X-Original-To: lists+linux-erofs@lfdr.de
Delivered-To: lists+linux-erofs@lfdr.de
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2404:9400:21b9:f100::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 402F2CDE77F
	for <lists+linux-erofs@lfdr.de>; Fri, 26 Dec 2025 09:02:01 +0100 (CET)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4dcykZ5ZX0z2xg9;
	Fri, 26 Dec 2025 19:01:58 +1100 (AEDT)
X-Original-To: linux-erofs@lists.ozlabs.org
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip=115.124.30.124
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1766736118;
	cv=none; b=EhnX9Wu4wo6xKQtiUJtiQVJCoCTgvrdB12o5pVwzwQBoioFQFx/OgeM67I5EZ/ipqYexI8h2e57LJhmtV1Go15Rx0epe25Ua8Fm5DH5IdlK0bFk2OknNBLe0ghfGXL5lwys+htb/KIL6dHtKY19n5s4qxks4i1LzQ8ST78TYgjKTq+p1oe0hUkYQCxjezyFJWfDOdE1D0rLq6lyqkxyDwIvRhnGqzwOY86eiGyAXTGVCTt0cpVuVFLTjgLIfsyZFEUH9c8+cFI1OHwggWPGk7NyN9+7lVrjII9Fvle6yijbMTGLIYg8JervYDezHG0EyK5jiPf6L/n21zc179bUEOA==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1766736118; c=relaxed/relaxed;
	bh=YB8vyvpdw5o6U4d1Soww7V1x/n2tFHBHKGDDKzsuu+Y=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=I64VVylfu9k8lOAzV0qwA+WyUhgzFBtqq+L545LKOB+SWsrAQC6ZH6ZhvvjYjOGyqqFvPFBvjy0YE9wi49qMf7J+G/FLijJ1WLG66bD1dmyEWIbXYONCcoLtZfPgCRXgueXrvypONftJhRY0+D4c2KO03QLt76SNfvhGzg7+756CA1sIaxwRfFfsz+nieT7ChJswWi2m15e/dAKXhInbQeglJvx7ilixku3DZtj7PYses8YQWxU0yIlW8QorYRqQqxbSEAMF6FmYFmet8+HpD9vNHpJl7FBjdQtbCKYl8c5Nyt0AZ4Vf1LAEYX7jao4joMY2eD6Kj6vdQncezSaZeA==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com; dkim=pass (1024-bit key; unprotected) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.a=rsa-sha256 header.s=default header.b=vPqibSmU; dkim-atps=neutral; spf=pass (client-ip=115.124.30.124; helo=out30-124.freemail.mail.aliyun.com; envelope-from=hsiangkao@linux.alibaba.com; receiver=lists.ozlabs.org) smtp.mailfrom=linux.alibaba.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (1024-bit key; unprotected) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.a=rsa-sha256 header.s=default header.b=vPqibSmU;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=linux.alibaba.com (client-ip=115.124.30.124; helo=out30-124.freemail.mail.aliyun.com; envelope-from=hsiangkao@linux.alibaba.com; receiver=lists.ozlabs.org)
Received: from out30-124.freemail.mail.aliyun.com (out30-124.freemail.mail.aliyun.com [115.124.30.124])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4dcykX0fPbz2x99
	for <linux-erofs@lists.ozlabs.org>; Fri, 26 Dec 2025 19:01:53 +1100 (AEDT)
DKIM-Signature:v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=linux.alibaba.com; s=default;
	t=1766736108; h=Message-ID:Date:MIME-Version:Subject:To:From:Content-Type;
	bh=YB8vyvpdw5o6U4d1Soww7V1x/n2tFHBHKGDDKzsuu+Y=;
	b=vPqibSmU18Vk7teoE9HmqKJ+a/IogWi0KIYtelBoE6IeOiZEISnHEk0124a0DHDBOcyx9PlqGHY2v1qrdGg+XUV4JhKM/hd3MVVXVKTEE+LvTzfWdDuka8/+/Ou69Mh61zPt8+syo8Otjp/RXd8aBAH+uPHBJ+ek42ofJb+OZUw=
Received: from 30.221.133.83(mailfrom:hsiangkao@linux.alibaba.com fp:SMTPD_---0Wvgx0Cu_1766736107 cluster:ay36)
          by smtp.aliyun-inc.com;
          Fri, 26 Dec 2025 16:01:47 +0800
Message-ID: <12ecb72b-dc7d-4969-9a5c-8be2d533b1bd@linux.alibaba.com>
Date: Fri, 26 Dec 2025 16:01:47 +0800
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
Subject: Re: [PATCH 5/5] erofs-utils: mount: stop checking
 `/sys/block/nbdX/pid`
To: "zhaoyifan (H)" <zhaoyifan28@huawei.com>, linux-erofs@lists.ozlabs.org
Cc: jingrui@huawei.com, wayne.ma@huawei.com
References: <20251223100452.229684-1-zhaoyifan28@huawei.com>
 <20251223100452.229684-4-zhaoyifan28@huawei.com>
 <ba3929d3-b8f3-4027-bfa1-5ade5ec348f2@linux.alibaba.com>
 <7c5a6710-5ebf-42f8-b35f-b5f2ae120a2d@huawei.com>
From: Gao Xiang <hsiangkao@linux.alibaba.com>
In-Reply-To: <7c5a6710-5ebf-42f8-b35f-b5f2ae120a2d@huawei.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-15.7 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,DKIM_VALID_EF,ENV_AND_HDR_SPF_MATCH,RCVD_IN_DNSWL_NONE,
	SPF_HELO_NONE,SPF_PASS,UNPARSEABLE_RELAY,USER_IN_DEF_DKIM_WL,
	USER_IN_DEF_SPF_WL autolearn=disabled version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-25) on lists.ozlabs.org



On 2025/12/26 15:54, zhaoyifan (H) wrote:
> 
> On 2025/12/26 14:51, Gao Xiang wrote:
>> Hi Yifan,
>>
>> On 2025/12/23 18:04, Yifan Zhao wrote:
>>> The `current erofsmount_nbd()` implementation verifies that the value in
>>> `/sys/block/nbdX/pid`` matches the PID of the process executing
>>> `erofsmount_nbd_loopfn()`, using this as an indicator that the NBD
>>> device is ready. This check is incorrect, as the PID recorded in the
>>> aforementioned sysfs file may belong to a kernel thread rather than a
>>> userspace process (see [1]).
>>
>> Do you have a way to reproduce that?
> 
> This issue is consistently reproducible in my WSL2 environment (kernel version 6.6.87.2-microsoft-standard-WSL2),

I guess you could use bpftrace or similiar to confirm the kthread
stack if possible?


> 
> but works correctly in other environments (e.g., openEuler 24.03 SP2). The finer-grained difference
> 
> between these 2 environments remains unclear.
Thanks,
Gao Xiang

