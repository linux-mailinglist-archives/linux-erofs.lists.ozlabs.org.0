Return-Path: <linux-erofs+bounces-1993-lists+linux-erofs=lfdr.de@lists.ozlabs.org>
X-Original-To: lists+linux-erofs@lfdr.de
Delivered-To: lists+linux-erofs@lfdr.de
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	by mail.lfdr.de (Postfix) with ESMTPS id 092F3D3A2C4
	for <lists+linux-erofs@lfdr.de>; Mon, 19 Jan 2026 10:22:30 +0100 (CET)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4dvlNM2kTpz2xSZ;
	Mon, 19 Jan 2026 20:22:27 +1100 (AEDT)
X-Original-To: linux-erofs@lists.ozlabs.org
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip=213.95.11.211
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1768814547;
	cv=none; b=kf6qHeNsWxBAQADSmR8Ce9fg6OMBe8GEWvL09+uWnO9bbAbYDuTtXkjOKcu1WoG02AcGBxjzh90KWuR4mhvI3oxsJ0MPTCg3rvSR1k3o8uktf7X+8VhRqC8YaZjHoQRsBlOvtfJGu2p6UGbb73C2NjD0jRJXwOgtXTWdWbbuO+Jifd+D8rpauXgMNlEcBmX81T+ekGoqoR94FBViAOsamTE62Vj2Gpsf39J8o/GpFE2iAWfquCSSGxTv1GWzBHnnSC2gduY2ENn0rOmYXw7/TBUGcNWv8/OpmE8vr6XKtONe0Uj/BO+Ld6DDhiLWjBsN+7HbSYHtQSx80Dzuu0fxRg==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1768814547; c=relaxed/relaxed;
	bh=Xr9radxtzPlVDdu1xSA19Z49xAQFVDIkAhppP7zK4Vs=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=DFibNGcr/ZKIr/yidXH3HAoBooIIFosEg8s1pXuSrc2qAv5Jg7vL91R+iE9x1sqFfr3QymEayvTJrYqeHLeDEwx0sPMbRQNr0WqqW8pW2tfM3hUUiA03hK4N9vRKxzsvzLCskZkRMQcNpr8FJohrgaP1yTsKDBi9uSLA2dirh89gD3yK2vr9bSTueo3L1Z6PBUsccoxS/y2A6dZt6pUGkmlrsedRMRQFb3Jz0sc9/HF63gAq9kCCL/XPXCfiTO7Hbz9APwVzJTbAhFC++V5rgMz8l4UfVR8wJ/g0KklkvzGF8wVSQALjTwiJNDkrcPbOsge06eLUsm2FVDrdqyJqpA==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=lst.de; spf=pass (client-ip=213.95.11.211; helo=verein.lst.de; envelope-from=hch@lst.de; receiver=lists.ozlabs.org) smtp.mailfrom=lst.de
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=lst.de
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=lst.de (client-ip=213.95.11.211; helo=verein.lst.de; envelope-from=hch@lst.de; receiver=lists.ozlabs.org)
Received: from verein.lst.de (verein.lst.de [213.95.11.211])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4dvlNL3Kmqz2xHW
	for <linux-erofs@lists.ozlabs.org>; Mon, 19 Jan 2026 20:22:25 +1100 (AEDT)
Received: by verein.lst.de (Postfix, from userid 2407)
	id D93E8227A88; Mon, 19 Jan 2026 10:22:20 +0100 (CET)
Date: Mon, 19 Jan 2026 10:22:20 +0100
From: Christoph Hellwig <hch@lst.de>
To: Gao Xiang <hsiangkao@linux.alibaba.com>
Cc: Christoph Hellwig <hch@lst.de>, Hongbo Li <lihongbo22@huawei.com>,
	chao@kernel.org, brauner@kernel.org, djwong@kernel.org,
	amir73il@gmail.com, linux-fsdevel@vger.kernel.org,
	linux-erofs@lists.ozlabs.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v15 5/9] erofs: introduce the page cache share feature
Message-ID: <20260119092220.GA9140@lst.de>
References: <20260116095550.627082-1-lihongbo22@huawei.com> <20260116095550.627082-6-lihongbo22@huawei.com> <20260116154623.GC21174@lst.de> <af1f3ff6-a163-4515-92bf-44c9cf6c92f3@linux.alibaba.com> <20260119072932.GB2562@lst.de> <8e30bc4b-c97f-4ab2-a7ce-27f399ae7462@linux.alibaba.com> <20260119083251.GA5257@lst.de> <b29b112e-5fe1-414b-9912-06dcd7d7d204@linux.alibaba.com>
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
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <b29b112e-5fe1-414b-9912-06dcd7d7d204@linux.alibaba.com>
User-Agent: Mutt/1.5.17 (2007-11-01)
X-Spam-Status: No, score=0.0 required=3.0 tests=SPF_HELO_NONE,SPF_PASS
	autolearn=disabled version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-25) on lists.ozlabs.org

On Mon, Jan 19, 2026 at 04:52:54PM +0800, Gao Xiang wrote:
>> To me this sounds pretty scary, as we have code in the kernel's trust
>> domain that heavily depends on arbitrary userspace policy decisions.
>
> For example, overlayfs metacopy can also points to
> arbitary files, what's the difference between them?
> https://docs.kernel.org/filesystems/overlayfs.html#metadata-only-copy-up
>
> By using metacopy, overlayfs can access arbitary files
> as long as the metacopy has the pointer, so it should
> be a priviledged stuff, which is similar to this feature.

Sounds scary too.  But overlayfs' job is to combine underlying files, so
it is expected.  I think it's the mix of erofs being a disk based file
system, and reaching out beyond the device(s) assigned to the file system
instance that makes me feel rather uneasy.

>>
>> Similarly the sharing of blocks between different file system
>> instances opens a lot of questions about trust boundaries and life
>> time rules.  I don't really have good answers, but writing up the
>
> Could you give more details about the these? Since you
> raised the questions but I have no idea what the threats
> really come from.

Right now by default we don't allow any unprivileged mounts.  Now
if people thing that say erofs is safe enough and opt into that,
it needs to be clear what the boundaries of that are.  For a file
system limited to a single block device that boundaries are
pretty clear.  For file systems reaching out to the entire system
(or some kind of domain), the scope is much wider.

> As for the lifetime: The blob itself are immutable files,
> what the lifetime rules means?

What happens if the blob gets removed, intentionally or accidentally?

> And how do you define trust boundaries?  You mean users
> have no right to access the data?
>
> I think it's similar: for blockdevice-based filesystems,
> you mount the filesystem with a given source, and it
> should have permission to the mounter.

Yes.

> For multiple-blob EROFS filesystems, you mount the
> filesystem with multiple data sources, and the blockdevices
> and/or backed files should have permission to the
> mounters too.

And what prevents other from modifying them, or sneaking
unexpected data including unexpected comparison blobs in?


