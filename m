Return-Path: <linux-erofs+bounces-1984-lists+linux-erofs=lfdr.de@lists.ozlabs.org>
X-Original-To: lists+linux-erofs@lfdr.de
Delivered-To: lists+linux-erofs@lfdr.de
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2404:9400:21b9:f100::1])
	by mail.lfdr.de (Postfix) with ESMTPS id DC498D39FC7
	for <lists+linux-erofs@lfdr.de>; Mon, 19 Jan 2026 08:29:39 +0100 (CET)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4dvht94wdcz30Lv;
	Mon, 19 Jan 2026 18:29:37 +1100 (AEDT)
X-Original-To: linux-erofs@lists.ozlabs.org
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip=213.95.11.211
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1768807777;
	cv=none; b=AlgFULQ2/NYIhKmiAVH5jQYX2Blu9tFlamTIJfk5uHsvqk4J6HhfbiovkfAFn4Jed/6pnP4d4c63Ytp0f7QWdn0ZLqtYAMA8t7zQrK/y0VHR5OgjblRv4cRs4sLmh23K2yusLBYbPYdc2AKeRuOj1V1++eCtXvxQ1UE9K7XofssYw09hEaVOLCNgAIVaOxce2kgQB6DHZqrKqIeUVBQ9lm3g7dJxb/UWl7mFHJ111E47F/2qaid3f1VMQdD4i0vvopUHA5Oy2nVjldEdwzQ1fAK+UQb0z28+W2eBctbQCWw8KOMAEXoJwLFSxibm6kAcU6yrGxZ5MZ0jzxMXEFclgA==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1768807777; c=relaxed/relaxed;
	bh=2FGX/OJAkbJZI4YlcTamL6DRWETejSz2T2tBJ7oGa2A=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=bQvlXLAT4Deo8YTDtRkTtRekxLYn2NWGYogEOr0PPNBsqH3o4SWI2UyiDyvTDrC+9OYIVxoOLpqUR1k4oPa3ctDCS3qgGemIWimRmXCFaQ/6i4mrW2my4gFi31TOSjcnf9kYQRNanJZ59QQEVSSZWCFFxEOJAgzkmNCuRymt5pUM9blTfMLJxUOYmhMOZDlCKb7g2N/YwIWhIrbp2cASGWmD9xC3yX9bG8rWRpd8jei9Ba6yo5iHoTr3+heuw060l0YWXq9r5CzjvytZaBdcmVLyXGRTs0BetJho4NaALn1nna9jg0VUwR5PStiMEaIvRwl9JLT3rrrRNbL+SfZXEw==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=lst.de; spf=pass (client-ip=213.95.11.211; helo=verein.lst.de; envelope-from=hch@lst.de; receiver=lists.ozlabs.org) smtp.mailfrom=lst.de
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=lst.de
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=lst.de (client-ip=213.95.11.211; helo=verein.lst.de; envelope-from=hch@lst.de; receiver=lists.ozlabs.org)
Received: from verein.lst.de (verein.lst.de [213.95.11.211])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4dvht90GjYz2yDk
	for <linux-erofs@lists.ozlabs.org>; Mon, 19 Jan 2026 18:29:37 +1100 (AEDT)
Received: by verein.lst.de (Postfix, from userid 2407)
	id 66950227A88; Mon, 19 Jan 2026 08:29:32 +0100 (CET)
Date: Mon, 19 Jan 2026 08:29:32 +0100
From: Christoph Hellwig <hch@lst.de>
To: Gao Xiang <hsiangkao@linux.alibaba.com>
Cc: Christoph Hellwig <hch@lst.de>, Hongbo Li <lihongbo22@huawei.com>,
	chao@kernel.org, brauner@kernel.org, djwong@kernel.org,
	amir73il@gmail.com, linux-fsdevel@vger.kernel.org,
	linux-erofs@lists.ozlabs.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v15 5/9] erofs: introduce the page cache share feature
Message-ID: <20260119072932.GB2562@lst.de>
References: <20260116095550.627082-1-lihongbo22@huawei.com> <20260116095550.627082-6-lihongbo22@huawei.com> <20260116154623.GC21174@lst.de> <af1f3ff6-a163-4515-92bf-44c9cf6c92f3@linux.alibaba.com>
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
In-Reply-To: <af1f3ff6-a163-4515-92bf-44c9cf6c92f3@linux.alibaba.com>
User-Agent: Mutt/1.5.17 (2007-11-01)
X-Spam-Status: No, score=0.0 required=3.0 tests=SPF_HELO_NONE,SPF_PASS
	autolearn=disabled version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-25) on lists.ozlabs.org

On Sat, Jan 17, 2026 at 12:21:16AM +0800, Gao Xiang wrote:
> Hi Christoph,
>
> On 2026/1/16 23:46, Christoph Hellwig wrote:
>> I don't really understand the fingerprint idea.  Files with the
>> same content will point to the same physical disk blocks, so that
>> should be a much better indicator than a finger print?  Also how does
>
> Page cache sharing should apply to different EROFS
> filesystem images on the same machine too, so the
> physical disk block number idea cannot be applied
> to this.

Oh.  That's kinda unexpected and adds another twist to the whole scheme.
So in that case the on-disk data actually is duplicated in each image
and then de-duplicated in memory only?  Ewwww...


