Return-Path: <linux-erofs+bounces-2071-lists+linux-erofs=lfdr.de@lists.ozlabs.org>
X-Original-To: lists+linux-erofs@lfdr.de
Delivered-To: lists+linux-erofs@lfdr.de
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2404:9400:21b9:f100::1])
	by mail.lfdr.de (Postfix) with ESMTPS id AD77BD3BFAC
	for <lists+linux-erofs@lfdr.de>; Tue, 20 Jan 2026 07:52:52 +0100 (CET)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4dwJ1G2jccz3bf2;
	Tue, 20 Jan 2026 17:52:50 +1100 (AEDT)
X-Original-To: linux-erofs@lists.ozlabs.org
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip=213.95.11.211
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1768891970;
	cv=none; b=bnivfV98h5nq8zOly98NhJweOQP0UGnnXt5SbbOaAOXHBudCINYg0hYby1lFGCnRRYAB73BWlX8qdTS/TOE+kT3qEEML6HHjczzk2aGYlzeKNZRYqmQ7z/XvlZ17R62K4Dr/VlisMloCXxv2fiNar1HnXrQYj3Iay3rvMGCRgqKvvyXLu/HB3IWk7VmXOCz/hJw1R50eGOg/3Q8JkhaFfiG8OZ0rfMfHY7jjvW30lSAR8m0IWOUl4R3r6Th8T42WmwRxucXvhBOqKzR7n6xaysM07BOYfQ9PcJXNkuN7pc5zYnry6HksQIB4Ea8pcQUPezUfG53oSOw+LNYq3oMFDA==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1768891970; c=relaxed/relaxed;
	bh=9IsSxyEa2+gdAUHqCHCBsOoKw+QR9tAgxdWv80Ai2go=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=iPugCavGI4P2EL7bL1jjFz1Gzz8toNfQZ/DighoUGSu4RXgOMFaMlrTMuUxtdgmxFiJMhJy4I2AuuuTu5RCQKRLR/J2GVaya5P/kmj6FUZfAgbhLCjyHlv8BqJcgEnio0CoHABNmbJGXcGFbOPqZaWHcJ7JjyL3bipUFQJKx9ksy30hFeKyYAKX/fhUSfFCBVma87gXFjfvKio6hod4eE94ltTH3tSsxyiZxlDiirhC6EfhyUic374ZvmArTj/yxGNVYtvo0ry6vJj9V8FsCg4iuBwxprOKCK6H6tI2+Pj91dGF6O/zjlakUgsZbYcaIqIb/tFvAiOx182VfHNyuNg==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=lst.de; spf=pass (client-ip=213.95.11.211; helo=verein.lst.de; envelope-from=hch@lst.de; receiver=lists.ozlabs.org) smtp.mailfrom=lst.de
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=lst.de
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=lst.de (client-ip=213.95.11.211; helo=verein.lst.de; envelope-from=hch@lst.de; receiver=lists.ozlabs.org)
Received: from verein.lst.de (verein.lst.de [213.95.11.211])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4dwJ1F1s38z3bcf
	for <linux-erofs@lists.ozlabs.org>; Tue, 20 Jan 2026 17:52:48 +1100 (AEDT)
Received: by verein.lst.de (Postfix, from userid 2407)
	id C97CF227AA8; Tue, 20 Jan 2026 07:52:42 +0100 (CET)
Date: Tue, 20 Jan 2026 07:52:42 +0100
From: Christoph Hellwig <hch@lst.de>
To: Gao Xiang <hsiangkao@linux.alibaba.com>
Cc: Christoph Hellwig <hch@lst.de>, Hongbo Li <lihongbo22@huawei.com>,
	chao@kernel.org, djwong@kernel.org, amir73il@gmail.com,
	linux-fsdevel@vger.kernel.org, linux-erofs@lists.ozlabs.org,
	linux-kernel@vger.kernel.org,
	Linus Torvalds <torvalds@linux-foundation.org>,
	Christian Brauner <brauner@kernel.org>,
	oliver.yang@linux.alibaba.com
Subject: Re: [PATCH v15 5/9] erofs: introduce the page cache share feature
Message-ID: <20260120065242.GA3436@lst.de>
References: <20260116095550.627082-6-lihongbo22@huawei.com> <20260116154623.GC21174@lst.de> <af1f3ff6-a163-4515-92bf-44c9cf6c92f3@linux.alibaba.com> <20260119072932.GB2562@lst.de> <8e30bc4b-c97f-4ab2-a7ce-27f399ae7462@linux.alibaba.com> <20260119083251.GA5257@lst.de> <b29b112e-5fe1-414b-9912-06dcd7d7d204@linux.alibaba.com> <20260119092220.GA9140@lst.de> <73f2c243-e029-4f95-aa8e-285c7affacac@linux.alibaba.com> <50db56b8-4cf9-4d62-b242-c982a260a330@linux.alibaba.com>
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
In-Reply-To: <50db56b8-4cf9-4d62-b242-c982a260a330@linux.alibaba.com>
User-Agent: Mutt/1.5.17 (2007-11-01)
X-Spam-Status: No, score=0.0 required=3.0 tests=SPF_HELO_NONE,SPF_PASS
	autolearn=disabled version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-25) on lists.ozlabs.org

On Tue, Jan 20, 2026 at 11:07:48AM +0800, Gao Xiang wrote:
>
> Hi Christoph,
>
> Sorry I didn't phrase things clearly earlier, but I'd still
> like to explain the whole idea, as this feature is clearly
> useful for containerization. I hope we can reach agreement
> on the page cache sharing feature: Christian agreed on this
> feature (and I hope still):
>
> https://lore.kernel.org/linux-fsdevel/20260112-begreifbar-hasten-da396ac2759b@brauner

He has to ultimatively decide.  I do have an uneasy feeling about this.
It's not super informed as I can keep up, and I'm not the one in charge,
but I hope it is helpful to share my perspective.

> First, let's separate this feature from mounting in user
> namespaces (i.e., unprivileged mounts), because this feature
> is designed specifically for privileged mounts.

Ok.

> The EROFS page cache sharing feature stems from a current
> limitation in the page cache: a file-based folio cannot be
> shared across different inode mappings (or the different
> page index within the same mapping; If this limitation
> were resolved, we could implement a finer-grained page
> cache sharing mechanism at the folio level). As you may
> know, this patchset dates back to 2023,

I didn't..

> and as of 2026; I
> still see no indication that the page cache infra will
> change.

It will be very hard to change unless we move to physical indexing of
the page cache, which has all kinds of downside.s

> So that let's face the reality: this feature introduces
> on-disk xattrs called "fingerprints." --- Since they're
> just xattrs, the EROFS on-disk format remains unchanged.

I think the concept of using a backing file of some sort for the shared
pagecache (which I have no problem with at all), vs the imprecise
selection through a free form fingerprint are quite different aspects,
that could be easily separated.  I.e. one could easily imagine using
the data path approach based purely on exact file system metadata.
But that would of course not work with multiple images, which I think
is a key feature here if I'm reading between the lines correctly.

>  - Let's not focusing entirely on the random human bugs,
>    because I think every practical subsystem should have bugs,
>    the whole threat model focuses on the system design, and
>    less code doesn't mean anything (buggy or even has system
>    design flaw)

Yes, threats through malicious actors are much more intereating
here.

>  - EROFS only accesses the (meta)data from the source blobs
>    specified at mount time, even with multi-device support:
>
>     mount -t erofs -odevice=[blob],device=[blob],... [source]

That is an important part that wasn't fully clear to me.


