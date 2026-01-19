Return-Path: <linux-erofs+bounces-1995-lists+linux-erofs=lfdr.de@lists.ozlabs.org>
X-Original-To: lists+linux-erofs@lfdr.de
Delivered-To: lists+linux-erofs@lfdr.de
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2404:9400:21b9:f100::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 70A1BD3A33B
	for <lists+linux-erofs@lfdr.de>; Mon, 19 Jan 2026 10:38:48 +0100 (CET)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4dvllB0DNVz2xSZ;
	Mon, 19 Jan 2026 20:38:46 +1100 (AEDT)
X-Original-To: linux-erofs@lists.ozlabs.org
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip=115.124.30.113
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1768815525;
	cv=none; b=jwCFRj0ynH4EpslGx2Nb2sjwpDuu0ccn+hDb0gCRgQMuA8A3a6ywQG868IQ/CuqbRFFcr7LdGvkoaWz3IgsTj5cIh96jh/P9Zn7Rz+L2XDLdP8krtQUvm3NJMpf8PqQMaD0xOx5WH2tPUWgXn3aE/m+AqFCZ+IJ+TLAsp1QJiHtDwzCzj/O5DeKADOGWU1LtJbD4OeTaAjmXaD06p6D84rEyshlQLa78pOPuOmUkuCIR0auizsNQ7gOpnvrkoLD+xIRcZS8zoIjwMI7zpSROp/mXtw7UJ/0THEQFem+3BrNIjqLTWZJTBpKVqkS6Jv33So525rlGbxUQOZIo8yAvHA==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1768815525; c=relaxed/relaxed;
	bh=3oEwfAWlUHgA2grw4AAbMIJcUBA/9GSVEAaHUgNuOoo=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=k4pWiElxxQ9gaWkZbhnMgXN+FqQDmoKn4NeeB2Ecu/WxtcHVv5QzlK1dkzRMTHM4CKLIj3hgz0Y8zxKw48JY5y1JMdQL2RfQHpPJh0u6/7bRfxaw2RZ/tf4vh5dn44JKcvelZKhx4+wDUci9iFfovwKp/cxN8pdfBIfgZ27O+KNOjse800NJENgydmCP3t0TLCyUrPeG3toKbt5HrOGSa1YXRoaZrQAGvcQjn14hZ74GICr/EhNCgXQkdyZRFGceW5l4WR3QD8DKe+KeclRc/WrHl2CNRuJsKZkOtBpkWpi0G7YvuWkxvROP/QffLCgq0Vvj3HAwBc9hmPufcZPQSA==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com; dkim=pass (1024-bit key; unprotected) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.a=rsa-sha256 header.s=default header.b=SYZYz8yk; dkim-atps=neutral; spf=pass (client-ip=115.124.30.113; helo=out30-113.freemail.mail.aliyun.com; envelope-from=hsiangkao@linux.alibaba.com; receiver=lists.ozlabs.org) smtp.mailfrom=linux.alibaba.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (1024-bit key; unprotected) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.a=rsa-sha256 header.s=default header.b=SYZYz8yk;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=linux.alibaba.com (client-ip=115.124.30.113; helo=out30-113.freemail.mail.aliyun.com; envelope-from=hsiangkao@linux.alibaba.com; receiver=lists.ozlabs.org)
Received: from out30-113.freemail.mail.aliyun.com (out30-113.freemail.mail.aliyun.com [115.124.30.113])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4dvll73YJhz2xHW
	for <linux-erofs@lists.ozlabs.org>; Mon, 19 Jan 2026 20:38:41 +1100 (AEDT)
DKIM-Signature:v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=linux.alibaba.com; s=default;
	t=1768815515; h=Message-ID:Date:MIME-Version:Subject:To:From:Content-Type;
	bh=3oEwfAWlUHgA2grw4AAbMIJcUBA/9GSVEAaHUgNuOoo=;
	b=SYZYz8ykChzr21WI/IVCpD6ybwYPNHJ8eMZ7zpLXVZp/NwsYsrBIWFh5ArMmHl7p5J04azheO0sTL2pN3xSsPTTpZaKpKa5L6SKH8ig8SP1okB4anF7j3Z8Z4Z+GupnVBz893RTmPYqILOzAbB4DRE9eD1hkZbHshbtCCrF5G/k=
Received: from 30.221.131.184(mailfrom:hsiangkao@linux.alibaba.com fp:SMTPD_---0WxL7KIk_1768815513 cluster:ay36)
          by smtp.aliyun-inc.com;
          Mon, 19 Jan 2026 17:38:34 +0800
Message-ID: <73f2c243-e029-4f95-aa8e-285c7affacac@linux.alibaba.com>
Date: Mon, 19 Jan 2026 17:38:33 +0800
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
 <b29b112e-5fe1-414b-9912-06dcd7d7d204@linux.alibaba.com>
 <20260119092220.GA9140@lst.de>
From: Gao Xiang <hsiangkao@linux.alibaba.com>
In-Reply-To: <20260119092220.GA9140@lst.de>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-15.7 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,DKIM_VALID_EF,ENV_AND_HDR_SPF_MATCH,RCVD_IN_DNSWL_NONE,
	SPF_HELO_NONE,SPF_PASS,UNPARSEABLE_RELAY,USER_IN_DEF_DKIM_WL,
	USER_IN_DEF_SPF_WL autolearn=disabled version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-25) on lists.ozlabs.org



On 2026/1/19 17:22, Christoph Hellwig wrote:
> On Mon, Jan 19, 2026 at 04:52:54PM +0800, Gao Xiang wrote:
>>> To me this sounds pretty scary, as we have code in the kernel's trust
>>> domain that heavily depends on arbitrary userspace policy decisions.
>>
>> For example, overlayfs metacopy can also points to
>> arbitary files, what's the difference between them?
>> https://docs.kernel.org/filesystems/overlayfs.html#metadata-only-copy-up
>>
>> By using metacopy, overlayfs can access arbitary files
>> as long as the metacopy has the pointer, so it should
>> be a priviledged stuff, which is similar to this feature.
> 
> Sounds scary too.  But overlayfs' job is to combine underlying files, so
> it is expected.  I think it's the mix of erofs being a disk based file

But you still could point to an arbitary page cache
if metacopy is used.

> system, and reaching out beyond the device(s) assigned to the file system
> instance that makes me feel rather uneasy.

You mean the page cache can be shared from other
filesystems even not backed by these devices/files?

I admitted yes, there could be different: but that
is why new mount options "inode_share" and the
"domain_id" mount option are used.

I think they should be regarded as a single super
filesystem if "domain_id" is the same: From the
security perspective much like subvolumes of
a single super filesystem.

And mounting a new filesystem within a "domain_id"
can be regard as importing data into the super
"domain_id" filesystem, and I think only trusted
data within the single domain can be mounted/shared.

> 
>>>
>>> Similarly the sharing of blocks between different file system
>>> instances opens a lot of questions about trust boundaries and life
>>> time rules.  I don't really have good answers, but writing up the
>>
>> Could you give more details about the these? Since you
>> raised the questions but I have no idea what the threats
>> really come from.
> 
> Right now by default we don't allow any unprivileged mounts.  Now
> if people thing that say erofs is safe enough and opt into that,
> it needs to be clear what the boundaries of that are.  For a file
> system limited to a single block device that boundaries are
> pretty clear.  For file systems reaching out to the entire system
> (or some kind of domain), the scope is much wider.

Why multiple device differ for an immutable fses, any
filesystem instance cannot change the primary or
external device/blobs. All data are immutable.

> 
>> As for the lifetime: The blob itself are immutable files,
>> what the lifetime rules means?
> 
> What happens if the blob gets removed, intentionally or accidentally?

The extra device/blob reference is held during
the whole mount lifetime, much like the primary
(block) device.

And EROFS is an immutable filesystem, so that
inner blocks within the blob won't be go away
by some fs instance too.

> 
>> And how do you define trust boundaries?  You mean users
>> have no right to access the data?
>>
>> I think it's similar: for blockdevice-based filesystems,
>> you mount the filesystem with a given source, and it
>> should have permission to the mounter.
> 
> Yes.
> 
>> For multiple-blob EROFS filesystems, you mount the
>> filesystem with multiple data sources, and the blockdevices
>> and/or backed files should have permission to the
>> mounters too.
> 
> And what prevents other from modifying them, or sneaking
> unexpected data including unexpected comparison blobs in?

I don't think it's difference from filesystems with single
device.

First, EROFS instances never modify any underlay
device/blobs:

If you say some other program modify the device data, yes,
it can be changed externally, but I think it's just like
trusted FUSE deamons, untrusted FUSE daemon can return
arbitary (meta)data at random times too.

Thanks,
Gao Xiang



