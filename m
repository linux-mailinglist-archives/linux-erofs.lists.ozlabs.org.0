Return-Path: <linux-erofs+bounces-1996-lists+linux-erofs=lfdr.de@lists.ozlabs.org>
X-Original-To: lists+linux-erofs@lfdr.de
Delivered-To: lists+linux-erofs@lfdr.de
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	by mail.lfdr.de (Postfix) with ESMTPS id 19F5ED3A3C4
	for <lists+linux-erofs@lfdr.de>; Mon, 19 Jan 2026 10:53:47 +0100 (CET)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4dvm4S3NZXz2xSZ;
	Mon, 19 Jan 2026 20:53:44 +1100 (AEDT)
X-Original-To: linux-erofs@lists.ozlabs.org
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip=115.124.30.124
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1768816424;
	cv=none; b=Y2mNRh4FQqTLitxfpN/iKzktB4ao8qdcw7QImnlQngGcSKbq3fjY8l+br1Rx8Tf3M7crTwK2jE3P/MKqsPRAKkWdkZ9nqv/xAP5uieJxeJ86fqNYkMk8SlQrclFuxWve2MkLPldXuZ5d7va6orfc+FFI2wjL+WdN4TPZiiOAbDWrir2eqeaJtrdnWzCPqNMzdR6ODWesLVOyXXeUZHNNcGxa8A0vuySh4wKjbKH7ZetAFGNNuA+YBgmVDZtYGPiZZmC/VXcwIF+mU9GpDAwS5qrJkIe3ydyPCLQd9EmOiUcZyNiIfehTaJNiHp+ce/GE+oVAPoUyXAHm37ig6Vdcmg==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1768816424; c=relaxed/relaxed;
	bh=hPPrNXHoXR8mRzEfeDQGV5JB64ifiuGfpPhzFKE3cxU=;
	h=Message-ID:Date:MIME-Version:Subject:From:To:Cc:References:
	 In-Reply-To:Content-Type; b=dWzjLMYWXthT0QKS5y9stLda62cf7DbLBynCo9zWTgFArR9ntdazryT+KWWn++ngLldeHdMUDhrKQaqzAsf2HET6wTPLpQBrEDwzweLHNOLD1ajQ4inbUy2YlrSgrm7or+znKdvE7ILDhIYLih6w5PsO60L7OILiGmJqyLGSXJg41nCmGYj+R5VsMobGfIR2SBScQ7emqTKy1HOuLBDPZsxKFkKLk6ML+LgEoEsPqMeu4ajQxl4iT+/Msej2NODi3Z2w0+TX11n/a5HkLWnrYXINJQIi2FfosFxhPTMuIRoJYbJcDEwwZKS49NvvheLwYgpyDB0lshKPGKtQPGLDaQ==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com; dkim=pass (1024-bit key; unprotected) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.a=rsa-sha256 header.s=default header.b=IjDMC6FN; dkim-atps=neutral; spf=pass (client-ip=115.124.30.124; helo=out30-124.freemail.mail.aliyun.com; envelope-from=hsiangkao@linux.alibaba.com; receiver=lists.ozlabs.org) smtp.mailfrom=linux.alibaba.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (1024-bit key; unprotected) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.a=rsa-sha256 header.s=default header.b=IjDMC6FN;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=linux.alibaba.com (client-ip=115.124.30.124; helo=out30-124.freemail.mail.aliyun.com; envelope-from=hsiangkao@linux.alibaba.com; receiver=lists.ozlabs.org)
Received: from out30-124.freemail.mail.aliyun.com (out30-124.freemail.mail.aliyun.com [115.124.30.124])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4dvm4P4nCnz2xHW
	for <linux-erofs@lists.ozlabs.org>; Mon, 19 Jan 2026 20:53:39 +1100 (AEDT)
DKIM-Signature:v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=linux.alibaba.com; s=default;
	t=1768816415; h=Message-ID:Date:MIME-Version:Subject:From:To:Content-Type;
	bh=hPPrNXHoXR8mRzEfeDQGV5JB64ifiuGfpPhzFKE3cxU=;
	b=IjDMC6FNiRsRoK/AfbNzWZxGT8qeVbHvJTjRR+ug0tMiV+O2m9/U6s5atRx8xWd7ZLeNYGZGRfyYe3DtjdEDMCeruKTygh16qKMn4XRsKREMaU/hVFlzA3CUbO40n0wp8FasBhmvtHroQnBK3DKQdR2phlp69XwV4WxJy9GCUHE=
Received: from 30.221.131.184(mailfrom:hsiangkao@linux.alibaba.com fp:SMTPD_---0WxLJyuZ_1768816384 cluster:ay36)
          by smtp.aliyun-inc.com;
          Mon, 19 Jan 2026 17:53:33 +0800
Message-ID: <033806bc-c91a-4ff4-8df3-f414bd0bf264@linux.alibaba.com>
Date: Mon, 19 Jan 2026 17:53:33 +0800
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
From: Gao Xiang <hsiangkao@linux.alibaba.com>
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
 <b29b112e-5fe1-414b-9912-06dcd7d7d204@linux.alibaba.com>
 <20260119092220.GA9140@lst.de>
 <73f2c243-e029-4f95-aa8e-285c7affacac@linux.alibaba.com>
In-Reply-To: <73f2c243-e029-4f95-aa8e-285c7affacac@linux.alibaba.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-15.7 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,DKIM_VALID_EF,ENV_AND_HDR_SPF_MATCH,RCVD_IN_DNSWL_NONE,
	SPF_HELO_NONE,SPF_PASS,UNPARSEABLE_RELAY,USER_IN_DEF_DKIM_WL,
	USER_IN_DEF_SPF_WL autolearn=disabled version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-25) on lists.ozlabs.org



On 2026/1/19 17:38, Gao Xiang wrote:
> 
> 
> On 2026/1/19 17:22, Christoph Hellwig wrote:
>> On Mon, Jan 19, 2026 at 04:52:54PM +0800, Gao Xiang wrote:
>>>> To me this sounds pretty scary, as we have code in the kernel's trust
>>>> domain that heavily depends on arbitrary userspace policy decisions.
>>>
>>> For example, overlayfs metacopy can also points to
>>> arbitary files, what's the difference between them?
>>> https://docs.kernel.org/filesystems/overlayfs.html#metadata-only-copy-up
>>>
>>> By using metacopy, overlayfs can access arbitary files
>>> as long as the metacopy has the pointer, so it should
>>> be a priviledged stuff, which is similar to this feature.
>>
>> Sounds scary too.  But overlayfs' job is to combine underlying files, so
>> it is expected.  I think it's the mix of erofs being a disk based file
> 
> But you still could point to an arbitary page cache
> if metacopy is used.
> 
>> system, and reaching out beyond the device(s) assigned to the file system
>> instance that makes me feel rather uneasy.
> 
> You mean the page cache can be shared from other
> filesystems even not backed by these devices/files?
> 
> I admitted yes, there could be different: but that
> is why new mount options "inode_share" and the
> "domain_id" mount option are used.
> 
> I think they should be regarded as a single super
> filesystem if "domain_id" is the same: From the
> security perspective much like subvolumes of
> a single super filesystem.
> 
> And mounting a new filesystem within a "domain_id"
> can be regard as importing data into the super
> "domain_id" filesystem, and I think only trusted
> data within the single domain can be mounted/shared.
> 
>>
>>>>
>>>> Similarly the sharing of blocks between different file system
>>>> instances opens a lot of questions about trust boundaries and life
>>>> time rules.  I don't really have good answers, but writing up the
>>>
>>> Could you give more details about the these? Since you
>>> raised the questions but I have no idea what the threats
>>> really come from.
>>
>> Right now by default we don't allow any unprivileged mounts.  Now
>> if people thing that say erofs is safe enough and opt into that,
>> it needs to be clear what the boundaries of that are.  For a file
>> system limited to a single block device that boundaries are
>> pretty clear.  For file systems reaching out to the entire system
>> (or some kind of domain), the scope is much wider.

btw, I think it's indeed to be helpful to get the boundaries (even
from on-disk formats and runtime features).

But I have to clarify that a single EROFS filesystem instance won'
have access to random block device or files.

The backing device or files are specified by users explicitly when
mounting, like:

  mount -odevice=blob1,device=blob2,...,device=blobn-1 blob0 mnt

And these devices / files will be opened when mounting at once,
no more than that.

May I ask the difference between one device/file and a group of
given devices/files? Especially for immutable usage.

Thanks,
Gao Xiang

