Return-Path: <linux-erofs+bounces-508-lists+linux-erofs=lfdr.de@lists.ozlabs.org>
X-Original-To: lists+linux-erofs@lfdr.de
Delivered-To: lists+linux-erofs@lfdr.de
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	by mail.lfdr.de (Postfix) with ESMTPS id 1F3A3AF74B9
	for <lists+linux-erofs@lfdr.de>; Thu,  3 Jul 2025 14:53:50 +0200 (CEST)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4bXxXW2YY0z2yPd;
	Thu,  3 Jul 2025 22:53:47 +1000 (AEST)
X-Original-To: linux-erofs@lists.ozlabs.org
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip=115.124.30.132
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1751547227;
	cv=none; b=JLTyMZdENx90Jm0gL+xvuyOWVhvwoCgbc6WNcVyjj02fK/fMDKaUk2+64Cxrt5lk33nThhHTmbgahDkyLterr1qIiccjiAYEtHodRlO34CtC9SK4g84D42NJKlcqYkjNYdFqqWITjS8pXKuqWQmXIOWZat0t3OxgDqx9zrGoF2EV8IH4YSf2gWyPFTRmahLqM0Z1/pGOz6g9Qu2hzUOlPGkhS+umE9nTUj3xR5stChbLlfY8sFBz5oel/8tCF/daC4ffQU5Im7jy5NOF7sqUFQVW5VLNB1KAefRFgtpdGQ5p9nm+aDsUlyEQAmrs0NwehtKi4xdJCpEUhu2HZ8kEBw==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1751547227; c=relaxed/relaxed;
	bh=4d05izOVGUojTwd8J0IJV0pyo4GlwHkcAhUbyVTl9ro=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=JTPgrS9IAnNHm3EVSjZFmrzFltprDdsuvIypiRdwP8MggaPfqtvBo2q34Y7Rg80loS9nQAbVwifmuDrWKp2+NucthbxwypUzn2DMvejUeRnAzMMz70Qr5xM98PL/rUaUNFXpRA44aM+5zlQznfdaKZSezA7S2qWcOfSWFlqdikt4KnWAlov03B2FVg5GE8an9yAE8sceB0YV9RepwD/hu2QFBZGVNtoP2VYIW1UW9rvO+qJeQ6wV4LCQ7fWpkwiI1hF/nDyGqKCfzrRB6LAhr/l4BId+SLj+JgLSKvFAq5AMvtyH/mhCycK5/LF13RNOR6gfgAIYce9GQkWBegCmxA==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com; dkim=pass (1024-bit key; unprotected) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.a=rsa-sha256 header.s=default header.b=QqKwC7m8; dkim-atps=neutral; spf=pass (client-ip=115.124.30.132; helo=out30-132.freemail.mail.aliyun.com; envelope-from=hsiangkao@linux.alibaba.com; receiver=lists.ozlabs.org) smtp.mailfrom=linux.alibaba.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (1024-bit key; unprotected) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.a=rsa-sha256 header.s=default header.b=QqKwC7m8;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=linux.alibaba.com (client-ip=115.124.30.132; helo=out30-132.freemail.mail.aliyun.com; envelope-from=hsiangkao@linux.alibaba.com; receiver=lists.ozlabs.org)
Received: from out30-132.freemail.mail.aliyun.com (out30-132.freemail.mail.aliyun.com [115.124.30.132])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4bXxXT2Fsqz2xgQ
	for <linux-erofs@lists.ozlabs.org>; Thu,  3 Jul 2025 22:53:43 +1000 (AEST)
DKIM-Signature:v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=linux.alibaba.com; s=default;
	t=1751547220; h=Message-ID:Date:MIME-Version:Subject:To:From:Content-Type;
	bh=4d05izOVGUojTwd8J0IJV0pyo4GlwHkcAhUbyVTl9ro=;
	b=QqKwC7m8jPXDqAbXuU82wTxGCvLMEahH0M5JSyeGr46SH1SqRpGo8GWQovbYun4MJM1fbD+Ky3An6tyL1aKy6XRKHIWi/yDH56HHaNWPcvmbZ2R7+lklvZq+yowxUpFfDJxyNLGtizVo9CWdnSgUw3oyC34MMxUAPp4CSkBlTPw=
Received: from 30.170.233.0(mailfrom:hsiangkao@linux.alibaba.com fp:SMTPD_---0WgzRMKG_1751547214 cluster:ay36)
          by smtp.aliyun-inc.com;
          Thu, 03 Jul 2025 20:53:35 +0800
Message-ID: <43071ec1-e431-419d-b6c1-a41474f7b8bf@linux.alibaba.com>
Date: Thu, 3 Jul 2025 20:53:34 +0800
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
Subject: Re: [PATCH RFC 0/4] erofs: allow page cache sharing
To: Christian Brauner <brauner@kernel.org>
Cc: Daan De Meyer <daan.j.demeyer@gmail.com>,
 Lennart Poettering <lennart@poettering.net>, Mike Yuan <me@yhndnzj.com>,
 =?UTF-8?Q?Zbigniew_J=C4=99drzejewski-Szmek?= <zbyszek@in.waw.pl>,
 lihongbo22@huawei.com, linux-erofs@lists.ozlabs.org,
 Gao Xiang <xiang@kernel.org>, Jan Kara <jack@suse.cz>,
 Amir Goldstein <amir73il@gmail.com>, Jeff Layton <jlayton@kernel.org>,
 Hongzhen Luo <hongzhen@linux.alibaba.com>,
 Matthew Wilcox <willy@infradead.org>
References: <20250703-work-erofs-pcs-v1-0-0ce1f6be28ee@kernel.org>
From: Gao Xiang <hsiangkao@linux.alibaba.com>
In-Reply-To: <20250703-work-erofs-pcs-v1-0-0ce1f6be28ee@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-15.7 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,DKIM_VALID_EF,ENV_AND_HDR_SPF_MATCH,RCVD_IN_DNSWL_NONE,
	SPF_HELO_NONE,SPF_PASS,UNPARSEABLE_RELAY,USER_IN_DEF_DKIM_WL,
	USER_IN_DEF_SPF_WL autolearn=disabled version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-25) on lists.ozlabs.org


On 2025/7/3 20:23, Christian Brauner wrote:
> Hey!
> 
> This series is originally from Hongzhen. I'm picking it back up because
> support for page cache sharing is pretty important for container and
> service workloads that want to make use of erofs images. The main
> obstacle currently is the inability to share page cache contents between
> different erofs superblocks.

Hi Christian,

Many thanks for your effort.  I do hope this feature can be
landed upstream too since as you said it's important to
container workloads.

Hongzhen had a job change recently, so he may not follow this.
It's on my own TODO list too, but it would be awesome if you
could take this!

Anyway, we could consider resending this to -fsdevel for more
discussion (I think you forgot about it ;-)).  But personally
I think using anon inode mapping (vma->vm_file = anon_file)
for mmap is fine to userspace, it just needs more work to
handle edge cases like data source redirection if one sb is
gone.

Thanks,
Gao Xiang

> 
> I think the mechanism that Hongzhen came up with is decent and will
> remove one final obstacle.
> 
> However, I have not worked in this area in meaningful ways before so to
> an experienced page cache person this might all look like a little kid
> doodling on a piece of paper.
> 
> One obvious question mark I have is around mmap. The current
> implementation mimicks what overlayfs is doing and I'm not sure that
> it's correct or even necessary to mimick overlayfs behavior here at all.
> 
> Anyway, I would really appreciate the help!

