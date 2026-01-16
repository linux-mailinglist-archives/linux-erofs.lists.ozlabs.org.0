Return-Path: <linux-erofs+bounces-1964-lists+linux-erofs=lfdr.de@lists.ozlabs.org>
X-Original-To: lists+linux-erofs@lfdr.de
Delivered-To: lists+linux-erofs@lfdr.de
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2404:9400:21b9:f100::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D35EFD334C8
	for <lists+linux-erofs@lfdr.de>; Fri, 16 Jan 2026 16:47:07 +0100 (CET)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4dt43Y4S39z309H;
	Sat, 17 Jan 2026 02:47:05 +1100 (AEDT)
X-Original-To: linux-erofs@lists.ozlabs.org
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip=213.95.11.211
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1768578425;
	cv=none; b=ExKi/NlULm3QXmF2kIjE9c9zimu4PWQPtp99bJDg74lSG8LytTWvYBTnhIFZV7ST1EgSkRplDcj6PZVAkr3+MPQo7g8lIg7oM99ohsGrDfy0BOixz2TiaIzIUJ27qsXpW4yQs4Gd/krcWfrmto+Ah6j+0OfmBXbLCldQ8wtzfgpxp4NnIp42LneJ9MPRy5y6886MehPp8nzZ+jj7EgMIiA8gHYzSjmxxdbZ8jLwvO0w+hf69UKf+V2AqksHweSo/wHVC0+tZQwVagCZ1wxOxIxc3sceLwMsWeYnP98f9ZC9JJphxb75dZ5mMtdYnsPdFdNAewJxNWhKZMUnQ+x4quw==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1768578425; c=relaxed/relaxed;
	bh=pQGBkeV4VK/iWbgiLSNGQhHAQ0vfVDsAsAyuJT8T0OY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=C/DlB4muozRkoFlK9hf8dXci9TmkNJpct4r1ewVYZVLeXaFsRrkTVEpCCYC/ftVd8ux/tIPIczSd+pFc1DKsILtEosTSXZbE41okO7eb9sHg+qppEkL6eE4ePmkC4CYulyVB8TCyydeMxRbk2rLMrxYAgLIgX7LQlYEIRR7O9JJIwceUS6eUi4SF+AzNm6yi2rb3V/AumkxkHhIHm8zQ8Xx7lh6r3hyfbkOOixuxqmpQ2q9M3Rx9xw8VrNmftaLOw36W/x+1Cdw3IS5nlOlGrk+Zc5NXy7Bi4TwL6/WGT7MaXvihfv1AZhSLYk9ge1PUw5vsG7g5FRkkIYwxuphbtw==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=lst.de; spf=pass (client-ip=213.95.11.211; helo=verein.lst.de; envelope-from=hch@lst.de; receiver=lists.ozlabs.org) smtp.mailfrom=lst.de
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=lst.de
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=lst.de (client-ip=213.95.11.211; helo=verein.lst.de; envelope-from=hch@lst.de; receiver=lists.ozlabs.org)
Received: from verein.lst.de (verein.lst.de [213.95.11.211])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4dt43Y0VZSz2xnj
	for <linux-erofs@lists.ozlabs.org>; Sat, 17 Jan 2026 02:47:05 +1100 (AEDT)
Received: by verein.lst.de (Postfix, from userid 2407)
	id 48E97227AB2; Fri, 16 Jan 2026 16:36:57 +0100 (CET)
Date: Fri, 16 Jan 2026 16:36:56 +0100
From: Christoph Hellwig <hch@lst.de>
To: Hongbo Li <lihongbo22@huawei.com>
Cc: hsiangkao@linux.alibaba.com, chao@kernel.org, brauner@kernel.org,
	djwong@kernel.org, amir73il@gmail.com, hch@lst.de,
	linux-fsdevel@vger.kernel.org, linux-erofs@lists.ozlabs.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH v15 0/9] erofs: Introduce page cache sharing feature
Message-ID: <20260116153656.GA21174@lst.de>
References: <20260116095550.627082-1-lihongbo22@huawei.com>
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
In-Reply-To: <20260116095550.627082-1-lihongbo22@huawei.com>
User-Agent: Mutt/1.5.17 (2007-11-01)
X-Spam-Status: No, score=0.0 required=3.0 tests=SPF_HELO_NONE,SPF_PASS
	autolearn=disabled version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-25) on lists.ozlabs.org

Sorry, just getting to this from my overful inbox by now.

On Fri, Jan 16, 2026 at 09:55:41AM +0000, Hongbo Li wrote:
> 2.1. file open & close
> ----------------------
> When the file is opened, the ->private_data field of file A or file B is
> set to point to an internal deduplicated file. When the actual read
> occurs, the page cache of this deduplicated file will be accessed.

So the first opener wins and others point to it?  That would lead to
some really annoying life time rules.  Or you allocate a hidden backing
file and have everyone point to it (the backing_file related subject
kinda hints at that), which would be much more sensible, but then the
above descriptions would not be correct.

> 
> When the file is opened, if the corresponding erofs inode is newly
> created, then perform the following actions:
> 1. add the erofs inode to the backing list of the deduplicated inode;
> 2. increase the reference count of the deduplicated inode.

This on the other hand suggests the fist opener is used approach again?

> Assuming the deduplication inode's page cache is PGCache_dedup, there

What is PGCache_dedup?

> Iomap and the layers below will involve disk I/O operations. As
> described in 2.1, the deduplicated inode itself is not bound to a
> specific device. The deduplicated inode will select an erofs inode from
> the backing list (by default, the first one) to complete the
> corresponding iomap operation.

What happens for mmap I/O where folio->mapping is kinda important?

Also do you have a git tree for the whole feature?

