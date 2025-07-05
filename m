Return-Path: <linux-erofs+bounces-530-lists+linux-erofs=lfdr.de@lists.ozlabs.org>
X-Original-To: lists+linux-erofs@lfdr.de
Delivered-To: lists+linux-erofs@lfdr.de
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	by mail.lfdr.de (Postfix) with ESMTPS id 2CA0CAF9FC1
	for <lists+linux-erofs@lfdr.de>; Sat,  5 Jul 2025 12:58:40 +0200 (CEST)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4bZ6td6Rmvz2y06;
	Sat,  5 Jul 2025 20:58:33 +1000 (AEST)
X-Original-To: linux-erofs@lists.ozlabs.org
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip=115.124.30.113
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1751713113;
	cv=none; b=GEx/1vVMa9WNdhkatN1silQHTcI5eEnkffdQ8NwrmyGOvXOGg6/cnkUcJ+gcu4PGfJgelKi1+hvCJ8DN5GmBmHPAYFNTMWP71GPdQMDv5Y4zB/Fn4kXRZlYv/noGWPfCYEpiCx+6uB4c+yVRBifS4IBEauvVMvcGkRBiC3fS/ddIclti5MhTdXr87doEgrk1t9NafP5pnbsweEcjdg6e4ks1tGFD/93FwP2I1LzRLY7tKr5xIAnivmjERsvL9lQXdyeh9f7GgN22bXEpJB2QUKpbD29rweyLKhGm0o1WyvA/a9lLcn1wL9wd+2ACnL2cUnP77v+BgUgiHmF1eJiouQ==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1751713113; c=relaxed/relaxed;
	bh=n5yv4Pi3LzQoJRmC2kX6hYxA45z8PtK4E203qvvz/is=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=KmuDWz8NRTBSGh//sBc7odKF2EI4B5BkkLXEzFGX2BIbc9cdtR55WHFxCxaiVK+694Ff4GsgLGxLBJs7XAzc41Aw2sXJcr6y9+pzbE+L6ogyQZWVMsqBcGOVqsgAIUt2ZXt/xYWRZfifTxNWU1d0wDkRdjlHiWdbFuSsmv7Zfd7C9iB1HFSCCuu2OkvwnVyVsFMvMWfp52fWQ4wjDEa62XxAewM7cy9A10iJ/gHwjJgfcp4+GbjlOalysGSKoMLe1mjpt1tkK4RstKvzbx/UD6I/Yzf1ZxhpuKgWYkx2i2qtXvzW8vOe1Fut7PgPJQbNcfmWLHumFFwZuL9k/tfDRg==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com; dkim=pass (1024-bit key; unprotected) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.a=rsa-sha256 header.s=default header.b=S6m+0R2K; dkim-atps=neutral; spf=pass (client-ip=115.124.30.113; helo=out30-113.freemail.mail.aliyun.com; envelope-from=hsiangkao@linux.alibaba.com; receiver=lists.ozlabs.org) smtp.mailfrom=linux.alibaba.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (1024-bit key; unprotected) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.a=rsa-sha256 header.s=default header.b=S6m+0R2K;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=linux.alibaba.com (client-ip=115.124.30.113; helo=out30-113.freemail.mail.aliyun.com; envelope-from=hsiangkao@linux.alibaba.com; receiver=lists.ozlabs.org)
Received: from out30-113.freemail.mail.aliyun.com (out30-113.freemail.mail.aliyun.com [115.124.30.113])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4bZ6tb415lz2xlL
	for <linux-erofs@lists.ozlabs.org>; Sat,  5 Jul 2025 20:58:29 +1000 (AEST)
DKIM-Signature:v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=linux.alibaba.com; s=default;
	t=1751713105; h=Message-ID:Date:MIME-Version:Subject:To:From:Content-Type;
	bh=n5yv4Pi3LzQoJRmC2kX6hYxA45z8PtK4E203qvvz/is=;
	b=S6m+0R2KnaUzifrCLUZjz24N8ldvqSNUQsiT87fA40e5GPJC8Z0nnJRFnvhqR2EWZxWv5+MxdM8D4lexj8iq8XfnwG0Kypm2AbKGHy4kywGtCpYefU/oAdO1dMi/qIGNsAucGq/9a9q9omkr/butoxtunFNxoWrhUY/qBIX482s=
Received: from 30.170.233.0(mailfrom:hsiangkao@linux.alibaba.com fp:SMTPD_---0WhXVDjj_1751713102 cluster:ay36)
          by smtp.aliyun-inc.com;
          Sat, 05 Jul 2025 18:58:23 +0800
Message-ID: <33817204-2455-4b8b-940e-072fad58191d@linux.alibaba.com>
Date: Sat, 5 Jul 2025 18:58:21 +0800
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
Subject: Re: [PATCH RFC 2/4] erofs: introduce page cache share feature
To: Amir Goldstein <amir73il@gmail.com>
Cc: Christian Brauner <brauner@kernel.org>,
 Hongzhen Luo <hongzhen@linux.alibaba.com>,
 Daan De Meyer <daan.j.demeyer@gmail.com>,
 Lennart Poettering <lennart@poettering.net>, Mike Yuan <me@yhndnzj.com>,
 =?UTF-8?Q?Zbigniew_J=C4=99drzejewski-Szmek?= <zbyszek@in.waw.pl>,
 lihongbo22@huawei.com, linux-erofs@lists.ozlabs.org,
 Gao Xiang <xiang@kernel.org>, Jan Kara <jack@suse.cz>,
 Jeff Layton <jlayton@kernel.org>, Matthew Wilcox <willy@infradead.org>
References: <20250703-work-erofs-pcs-v1-0-0ce1f6be28ee@kernel.org>
 <20250703-work-erofs-pcs-v1-2-0ce1f6be28ee@kernel.org>
 <12e59170-7435-4fae-a485-9cb105c378d1@linux.alibaba.com>
 <CAOQ4uxhhDS2XAKNnENEWfDrbp6+SX7Q_BY9OLo4QA4Jf0fHuvw@mail.gmail.com>
From: Gao Xiang <hsiangkao@linux.alibaba.com>
In-Reply-To: <CAOQ4uxhhDS2XAKNnENEWfDrbp6+SX7Q_BY9OLo4QA4Jf0fHuvw@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-15.7 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,DKIM_VALID_EF,ENV_AND_HDR_SPF_MATCH,RCVD_IN_DNSWL_NONE,
	SPF_HELO_NONE,SPF_PASS,UNPARSEABLE_RELAY,USER_IN_DEF_DKIM_WL,
	USER_IN_DEF_SPF_WL autolearn=disabled version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-25) on lists.ozlabs.org

Hi Amir,

On 2025/7/5 16:25, Amir Goldstein wrote:

...

> 
> 2. When is it ok to use the backing_file helpers?
> 
> The current patch allocates a struct file with
> alloc_file_pseudo() and not a struct backing_file,
> so using the backing_file helpers is going to be awkward and
> misleading and I think in this case it will we wize to refrain
> from using a local var name backing_file.
> 
> The thing that you need to ask yourself is do you want
> backing_file_set_user_path() for the erofs shared inode.

Yes, agreed, that should be improved as you said.

> 
> That means, what do you want users to see when they
> look at /proc/self/map_files symlinks.
> 
> With the current patch set I believe they will see a symlink to
> something like "[erofs_pcs_f]" for any mapped file
> which is somewhat odd.

Agreed.

> 
> I think it would have been nice if users saw something like
> "[erofs_pcs_md5digest:XXXXXXX]"

But if we use `overlay.metacopy` for example, it's not
a string anymore. IOWs, I'd like to support binary
footprint too.

And I tend to avoid md5 calcuation or something in
the kernel.  The kernel just uses footprint xattrs
instead.

> IMO, making the page cache dedupe visible in map_files is
> a very nice feature.
> > Overlayfs took the approach that users are expecting to see
> the actual path of the (non-anonymous) file that they mapped
> when looking at map_files symlinks.
> If you do not display the path to erofs mount in map_files,
> then lsof will not be able to blame a process with mapped files
> as the reason for keeping erofs mount busy.

I think users should see `the actual path` rather than
"[erofs_pcs_xxxxx]" too, but I don't have any chance to
check this part yet.

If it's possible for overlayfs, I guess it's possible for
erofs page cache sharing, maybe?

Thanks,
Gao Xiang

> 
> Thanks,
> Amir.


