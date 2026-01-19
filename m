Return-Path: <linux-erofs+bounces-1992-lists+linux-erofs=lfdr.de@lists.ozlabs.org>
X-Original-To: lists+linux-erofs@lfdr.de
Delivered-To: lists+linux-erofs@lfdr.de
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2404:9400:21b9:f100::1])
	by mail.lfdr.de (Postfix) with ESMTPS id DD9E1D3A21C
	for <lists+linux-erofs@lfdr.de>; Mon, 19 Jan 2026 09:53:09 +0100 (CET)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4dvkkW3KgMz2xSZ;
	Mon, 19 Jan 2026 19:53:07 +1100 (AEDT)
X-Original-To: linux-erofs@lists.ozlabs.org
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip=115.124.30.132
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1768812787;
	cv=none; b=W46LRwDOHgCSmy1KR6WMK6wlvWGlL5WePp8EDZp2X9wflknyVDTbslFO8cs+DdVoK7zi1uqG0gEdQs70irh4zI1p3yjWY6uUa9iuZxi5UfgnVbyc0WzzhDnOUCjYAOkE9TWy/TwlROTsaN/CqFeIk+wh+7IRheh2hbW5f0pcR4TMoWyvw8IMXPkyfaOPOd+EsHwdm33l7zY+S1Novw17kmzGztRHQoFHABEjejmR1JohgdgnoBdh4IB2/GkdUL3cqCfHTiGEu4rST1k8n2RquM0gLfW7ANf1+vQS1iOkAifshhGwiUq/eqlomEKjIO2s4gTdNMXKLPFQaKiE7WZ2CA==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1768812787; c=relaxed/relaxed;
	bh=pKXxPr9jjXttpRGeXJnXU+dWjjc24WVGOWOJDuRlICA=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=BU5+TtgHyJ9YYBdg6RRvnEQm/xBd8cgE5Lm7s07bVul6K8szEbfWntKYycupHV2HtQ6CO+dpcieKbPiTI8TPkmIdFAED+/3kvs3F4XXfzoiBlbPd5cOzByTiMEEqe+WdJ5/eTe6j6SG/h/BQe7zC2ygmEzSBWfwmVFBNKp8heVYqNzRkEZ2gBL6qp3YKO1wxvyqEescSxwb+T/5Rj+0wW9D2YUpc1hu4wNMaGU+PnE6eRWwyaIhhRPodFQivXD2b9sbVzEt8JVJPI17JX5AjBsnB9UqIXRXe9/GJJZ3bdpBPRlpkFmBYrdk2N/MJEpn249UiKsZJH5XZBasn/yOyOg==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com; dkim=pass (1024-bit key; unprotected) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.a=rsa-sha256 header.s=default header.b=yM4zV3ji; dkim-atps=neutral; spf=pass (client-ip=115.124.30.132; helo=out30-132.freemail.mail.aliyun.com; envelope-from=hsiangkao@linux.alibaba.com; receiver=lists.ozlabs.org) smtp.mailfrom=linux.alibaba.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (1024-bit key; unprotected) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.a=rsa-sha256 header.s=default header.b=yM4zV3ji;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=linux.alibaba.com (client-ip=115.124.30.132; helo=out30-132.freemail.mail.aliyun.com; envelope-from=hsiangkao@linux.alibaba.com; receiver=lists.ozlabs.org)
Received: from out30-132.freemail.mail.aliyun.com (out30-132.freemail.mail.aliyun.com [115.124.30.132])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4dvkkS0Mtdz2xHW
	for <linux-erofs@lists.ozlabs.org>; Mon, 19 Jan 2026 19:53:01 +1100 (AEDT)
DKIM-Signature:v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=linux.alibaba.com; s=default;
	t=1768812776; h=Message-ID:Date:MIME-Version:Subject:To:From:Content-Type;
	bh=pKXxPr9jjXttpRGeXJnXU+dWjjc24WVGOWOJDuRlICA=;
	b=yM4zV3jiegfWvB3JLiptfjciekuqf55C8syMimQ5bXCF2x9Ni5s4uAIWpsFXj80qYtDNBSUEYWwwaE61hYObtCMlXUplzoQThgUrNrYPW94sJFlImsE4OiIq8h67LqswZq5pQBdL34Ihg/C+NvSRaQNcZX15jMfFDaun/8T49Hs=
Received: from 30.221.131.184(mailfrom:hsiangkao@linux.alibaba.com fp:SMTPD_---0WxKR-IT_1768812774 cluster:ay36)
          by smtp.aliyun-inc.com;
          Mon, 19 Jan 2026 16:52:55 +0800
Message-ID: <b29b112e-5fe1-414b-9912-06dcd7d7d204@linux.alibaba.com>
Date: Mon, 19 Jan 2026 16:52:54 +0800
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
Subject: Re: [PATCH v15 5/9] erofs: introduce the page cache share feature
To: Christoph Hellwig <hch@lst.de>
Cc: Hongbo Li <lihongbo22@huawei.com>, chao@kernel.org, brauner@kernel.org,
 djwong@kernel.org, amir73il@gmail.com, linux-fsdevel@vger.kernel.org,
 linux-erofs@lists.ozlabs.org, linux-kernel@vger.kernel.org
References: <20260116095550.627082-1-lihongbo22@huawei.com>
 <20260116095550.627082-6-lihongbo22@huawei.com>
 <20260116154623.GC21174@lst.de>
 <af1f3ff6-a163-4515-92bf-44c9cf6c92f3@linux.alibaba.com>
 <20260119072932.GB2562@lst.de>
 <8e30bc4b-c97f-4ab2-a7ce-27f399ae7462@linux.alibaba.com>
 <20260119083251.GA5257@lst.de>
From: Gao Xiang <hsiangkao@linux.alibaba.com>
In-Reply-To: <20260119083251.GA5257@lst.de>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-15.7 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,DKIM_VALID_EF,ENV_AND_HDR_SPF_MATCH,RCVD_IN_DNSWL_NONE,
	SPF_HELO_NONE,SPF_PASS,UNPARSEABLE_RELAY,USER_IN_DEF_DKIM_WL,
	USER_IN_DEF_SPF_WL autolearn=disabled version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-25) on lists.ozlabs.org



On 2026/1/19 16:32, Christoph Hellwig wrote:
> On Mon, Jan 19, 2026 at 03:53:21PM +0800, Gao Xiang wrote:
>> I just tried to say EROFS doesn't limit what's
>> the real meaning of `fingerprint` (they can be serialized
>> integer numbers for example defined by a specific image
>> publisher, or a specific secure hash.  Currently,
>> "mkfs.erofs" will generate sha256 for each files), but
>> left them to the image builders:
> 
> To me this sounds pretty scary, as we have code in the kernel's trust
> domain that heavily depends on arbitrary userspace policy decisions.

For example, overlayfs metacopy can also points to
arbitary files, what's the difference between them?
https://docs.kernel.org/filesystems/overlayfs.html#metadata-only-copy-up

By using metacopy, overlayfs can access arbitary files
as long as the metacopy has the pointer, so it should
be a priviledged stuff, which is similar to this feature.

> 
> Similarly the sharing of blocks between different file system
> instances opens a lot of questions about trust boundaries and life
> time rules.  I don't really have good answers, but writing up the

Could you give more details about the these? Since you
raised the questions but I have no idea what the threats
really come from.

As for the lifetime: The blob itself are immutable files,
what the lifetime rules means?

And how do you define trust boundaries?  You mean users
have no right to access the data?

I think it's similar: for blockdevice-based filesystems,
you mount the filesystem with a given source, and it
should have permission to the mounter.

For multiple-blob EROFS filesystems, you mount the
filesystem with multiple data sources, and the blockdevices
and/or backed files should have permission to the
mounters too.

I don't quite get the point.

Thanks,
Gao Xiang

> lifetime and threat models would really help.


