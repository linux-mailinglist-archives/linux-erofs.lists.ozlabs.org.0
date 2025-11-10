Return-Path: <linux-erofs+bounces-1360-lists+linux-erofs=lfdr.de@lists.ozlabs.org>
X-Original-To: lists+linux-erofs@lfdr.de
Delivered-To: lists+linux-erofs@lfdr.de
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2404:9400:2:0:216:3eff:fee1:b9f1])
	by mail.lfdr.de (Postfix) with ESMTPS id 074E9C45435
	for <lists+linux-erofs@lfdr.de>; Mon, 10 Nov 2025 08:55:07 +0100 (CET)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4d4hlr5Jqsz2xqM;
	Mon, 10 Nov 2025 18:55:04 +1100 (AEDT)
X-Original-To: linux-erofs@lists.ozlabs.org
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip=115.124.30.131
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1762761304;
	cv=none; b=R8J0bsxIB8bNYt9gwSITELoytTU7a9TKDVp2NdhfLrhRhtiSSOD56h9rUvflzS/6wzEP79DxBfRVTLgjL0tNrMf4iDLPGMu3VLTTyIcGgwUAC9XaAFxmy6vYxjmSIpLgjSq6weLTk0Ge9RTkIw+J8mJlcdMeQ+nWJoWPBUtdgZpkUX+i0WX//fkNrhzRKH23IE1fi6vFdRqtbXtm3sOvwOEG7B0C7o2BqueNL5skxIrEfA1+PQqkm7LgO8GvbZCMQ4vnVyGyLLkGLKGfUCgacCSGnm2lJuXAWq0PbiNuH7b6Yura56r9VeoUhgqMHklqPrBRogZvnQv1Ny/c/NLc8w==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1762761304; c=relaxed/relaxed;
	bh=dFM/54hxaCRY3ZnvzdZBMCtN3nXXUz9KkiOhUWdu39Q=;
	h=Message-ID:Date:MIME-Version:Subject:To:References:From:Cc:
	 In-Reply-To:Content-Type; b=HcLpY5YuTSWBBsdYIv9ExQ3YB4MoLoH2js+lUQs2dUVM1mkphLnB9fopw2Uu3l8QPtXK7BlSfKX5/tU4D9CXnmiJHvnuDu+hTgpxnMY4eloojEEHvPv6S8jhXKYqXrJtiuOmDTbrM30AlqweWjlaex2f/u52UFxY8EAkNo9glQb3mFIrKOodjH+25/cf72sS+YSA6tj8OIbE+Tt5EAPEhusJxPDsoiCrbl5CjGt24TATRyUhiI3kZdnnJxivFN4Xw89D6MqGodhpdeOUYwdwgjMnEP+QmGg3Oq0YFKVbHy3ohQreNP89i4sR2zKsRXaHhuBgzPewnqFKIuT2BfUUTw==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com; dkim=pass (1024-bit key; unprotected) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.a=rsa-sha256 header.s=default header.b=F+X7PKoe; dkim-atps=neutral; spf=pass (client-ip=115.124.30.131; helo=out30-131.freemail.mail.aliyun.com; envelope-from=hsiangkao@linux.alibaba.com; receiver=lists.ozlabs.org) smtp.mailfrom=linux.alibaba.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (1024-bit key; unprotected) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.a=rsa-sha256 header.s=default header.b=F+X7PKoe;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=linux.alibaba.com (client-ip=115.124.30.131; helo=out30-131.freemail.mail.aliyun.com; envelope-from=hsiangkao@linux.alibaba.com; receiver=lists.ozlabs.org)
Received: from out30-131.freemail.mail.aliyun.com (out30-131.freemail.mail.aliyun.com [115.124.30.131])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4d4hlp4648z2xqL
	for <linux-erofs@lists.ozlabs.org>; Mon, 10 Nov 2025 18:55:01 +1100 (AEDT)
DKIM-Signature:v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=linux.alibaba.com; s=default;
	t=1762761296; h=Message-ID:Date:MIME-Version:Subject:To:From:Content-Type;
	bh=dFM/54hxaCRY3ZnvzdZBMCtN3nXXUz9KkiOhUWdu39Q=;
	b=F+X7PKoeX1rxEMyludk2wiq7heU/WjtvDjxcnYEZvhJHdAQgwfHlTlOU2G5OyxOc6vMC6/INutFY3FEUCEFF9OEaDEHcNHaOyVejsttX4y8xaWb3evNr6e57TaPbS+8vNB3O3HV5mjeCm/sxH9WmwbTOMhxmcyCdFA6Hzw9RHro=
Received: from 30.221.130.10(mailfrom:hsiangkao@linux.alibaba.com fp:SMTPD_---0Ws0OpN2_1762761294 cluster:ay36)
          by smtp.aliyun-inc.com;
          Mon, 10 Nov 2025 15:54:54 +0800
Message-ID: <5512892b-2e76-47d6-9b79-597b96809520@linux.alibaba.com>
Date: Mon, 10 Nov 2025 15:54:53 +0800
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
Subject: Re: fscache vs fanotify behavior difference
To: David Reiss <dnr@dnr.im>, linux-erofs@lists.ozlabs.org
References: <7d348e6e-d151-4a0f-af86-5ebac804e57d@betaapp.fastmail.com>
From: Gao Xiang <hsiangkao@linux.alibaba.com>
Cc: Christian Brauner <brauner@kernel.org>,
 "zhiche.yy@alibaba-inc.com" <zhiche.yy@alibaba-inc.com>, derek@mcg.dev
In-Reply-To: <7d348e6e-d151-4a0f-af86-5ebac804e57d@betaapp.fastmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-15.7 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,DKIM_VALID_EF,ENV_AND_HDR_SPF_MATCH,RCVD_IN_DNSWL_NONE,
	SPF_HELO_NONE,SPF_PASS,UNPARSEABLE_RELAY,USER_IN_DEF_DKIM_WL,
	USER_IN_DEF_SPF_WL autolearn=disabled version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-25) on lists.ozlabs.org

Hi David,

On 2025/11/10 14:59, David Reiss wrote:
> Hi,
> 
> I've been using erofs with the (deprecated) fscache integration in a project. I recently tried to switch it to use the new fanotify pre-content mechanism, but I'm running into differences in behavior.

In brief, we currently have very limited development resources.
I had intended to demo fanotify hooks in erofs-utils, but there
are always higher-priority tasks on my side (e.g. containerd
improvements, native microVM support, etc.)
  > 
> Here's the basic architecture: It's very similar to a container image distribution use case, with chunk-based deduplication across images. I have erofs images which contain metadata and small inline data. Larger data uses chunk format inodes, and points to chunks in a different "device". The chunked data device is shared by all images.
> 
> With fscache, I use one fsid per image, and one fsid for all of the chunked data. In the read hook for the images, I write the whole erofs image. In the read hook for the data, I fetch just the requested chunk (plus some readahead) and write that to fscache. Once the data is present on disk, fscache just uses it and never sends another read hook.

Yes, fscache seems more efficient in this regard, but we've mainly
encountered three issues with this approach:

  - Since fscache is not part of the EROFS filesystem, and the
    fscache/cachefiles maintainers pay little attention to "EROFS
    over fscache,” new features or optimizations are often not
    accepted in a timely manner (lagging).  In addition, fscache is
    now tied to netfs (as per the fscache maintainer's plan), which
    makes EROFS further fscache integration more awkward.

  - fscache relies on a fixed tree hierarchy, which makes userspace
    programs inflexible.

  - The fscache maintainer intends to remove sparse detection and
     introduce another mechanism (possibly incompatible), which
     would make this feature even more inflexible.

> 
> With fanotify+pre-content, I'm noticing that my pre-content hook is called any time data is not in the page cache, even if the offset being read is already mapped on disk. This kind of defeats the purpose of on-demand fetching if it has to go to userspace for most reads. The goal would be to keep the read path in the kernel and only go to userspace to fetch data that isn't present on disk.
I think your understanding is correct - if you hook an underlay EROFS
file and use file-backed mounts to mount the file.

   - If the page cache is invalid, it will trigger the underlay fsnotify
   hook anyway, which is different from the previous fscache approach.

   - The reason is that the kernel can't tell whether the exact part of
   the underlay file is valid, so it simply upcalls into userspace
   unconditionally. I wonder if it’s possible to introduce some BPF
   hooks to conditionally notify userspace, but I’ve never found time to
   look into that.

In any case, unless we introduce a new in-house kernel caching mechanism
dedicated for EROFS (of course which could be controversial), those
generic "pre-content fanotify hooks" would really help clean up the
EROFS overall codebase.   But again, I've never evaluated those new
hooks, so fscache interfaces have not been removed yet.

That's the current status.  Also, some off topic: the current mature
approach is to use virtual block devices (such as NBD or UBLK) if
they meet your requirements too.  I know it's not perfect, but at
least it’s an alternative for now.

> 
> Could you advise on how to achieve this goal with the new fanotify mechanism?
> 
> If you're interested you can find all the code here: https://github.com/dnr/styx/

Although I'm very interested in this, my own time is fragmented,
so many TODOs on my own side and I have to resolve our own
erofs-unrelated internal storage/filesystem issues.  I do hope I
could form an official "fanotify support" at least in erofs-utils
later but it needs more my extra personal time.

Thanks,
Gao Xiang

> 
> Thanks,
> David

