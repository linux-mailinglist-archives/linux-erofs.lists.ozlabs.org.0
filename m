Return-Path: <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>
X-Original-To: lists+linux-erofs@lfdr.de
Delivered-To: lists+linux-erofs@lfdr.de
Received: from lists.ozlabs.org (lists.ozlabs.org [203.11.71.2])
	by mail.lfdr.de (Postfix) with ESMTPS id 267D91634B6
	for <lists+linux-erofs@lfdr.de>; Tue, 18 Feb 2020 22:21:25 +0100 (CET)
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2401:3900:2:1::3])
	by lists.ozlabs.org (Postfix) with ESMTP id 48MYgj4jM8zDqFM
	for <lists+linux-erofs@lfdr.de>; Wed, 19 Feb 2020 08:21:21 +1100 (AEDT)
X-Original-To: linux-erofs@lists.ozlabs.org
Delivered-To: linux-erofs@lists.ozlabs.org
Authentication-Results: lists.ozlabs.org;
 spf=none (no SPF record) smtp.mailfrom=infradead.org
 (client-ip=2607:7c80:54:e::133; helo=bombadil.infradead.org;
 envelope-from=willy@infradead.org; receiver=<UNKNOWN>)
Authentication-Results: lists.ozlabs.org;
 dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: lists.ozlabs.org; dkim=pass (2048-bit key;
 unprotected) header.d=infradead.org header.i=@infradead.org
 header.a=rsa-sha256 header.s=bombadil.20170209 header.b=L9ufQZtG; 
 dkim-atps=neutral
Received: from bombadil.infradead.org (bombadil.infradead.org
 [IPv6:2607:7c80:54:e::133])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 48MYgf4PLbzDq6Q
 for <linux-erofs@lists.ozlabs.org>; Wed, 19 Feb 2020 08:21:18 +1100 (AEDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=infradead.org; s=bombadil.20170209; h=In-Reply-To:Content-Type:MIME-Version
 :References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
 Content-Transfer-Encoding:Content-ID:Content-Description;
 bh=0HtJTFPkdLwAcbGGhAHyzxa8a1mSgpc758IYlfDOg/k=; b=L9ufQZtGybPYd67zmz67Xgy4Tn
 mZsneK5DIi4+EdZSTDy3qMq6jC4G9yjF4A0m3HKQqgfmPcf89rxgAlz7TflzrDt+lPKQjG8DBB0Nc
 hFwG4XwkG9NeYBz6KYBZ58AKe0IfPIrYhHeqqinr+nlcKs9GdGtB8jhCcawcvPy3icitqNTTzH4jP
 ZCAGflog5kL6wL3IvL71BWNMv5PaAXyucj7tYF+EQU4HI4NEjXGWh1T+shXyemzhRpUXmIabqr29C
 5LaP21DN5DNYTONx+gIE3+S5Zr0Asg51I2iJBLolcYDkCch1kyQ608fu1c/WOZsk9fwFBAcPrEAy8
 FZTOuLoQ==;
Received: from willy by bombadil.infradead.org with local (Exim 4.92.3 #3 (Red
 Hat Linux)) id 1j4AIt-0003y5-Bi; Tue, 18 Feb 2020 21:21:15 +0000
Date: Tue, 18 Feb 2020 13:21:15 -0800
From: Matthew Wilcox <willy@infradead.org>
To: John Hubbard <jhubbard@nvidia.com>
Subject: Re: [PATCH v6 01/19] mm: Return void from various readahead functions
Message-ID: <20200218212115.GG24185@bombadil.infradead.org>
References: <20200217184613.19668-1-willy@infradead.org>
 <20200217184613.19668-2-willy@infradead.org>
 <29d2d7ca-7f2b-7eb4-78bc-f2af36c4c426@nvidia.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <29d2d7ca-7f2b-7eb4-78bc-f2af36c4c426@nvidia.com>
X-BeenThere: linux-erofs@lists.ozlabs.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: Development of Linux EROFS file system <linux-erofs.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linux-erofs>,
 <mailto:linux-erofs-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linux-erofs/>
List-Post: <mailto:linux-erofs@lists.ozlabs.org>
List-Help: <mailto:linux-erofs-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linux-erofs>,
 <mailto:linux-erofs-request@lists.ozlabs.org?subject=subscribe>
Cc: linux-xfs@vger.kernel.org, linux-kernel@vger.kernel.org,
 linux-f2fs-devel@lists.sourceforge.net, cluster-devel@redhat.com,
 linux-mm@kvack.org, ocfs2-devel@oss.oracle.com, linux-fsdevel@vger.kernel.org,
 linux-ext4@vger.kernel.org, linux-erofs@lists.ozlabs.org,
 linux-btrfs@vger.kernel.org
Errors-To: linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org
Sender: "Linux-erofs"
 <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>

On Tue, Feb 18, 2020 at 01:05:29PM -0800, John Hubbard wrote:
> This is an easy review and obviously correct, so:
> 
>     Reviewed-by: John Hubbard <jhubbard@nvidia.com>

Thanks

> Thoughts for the future of the API:
> 
> I will add that I could envision another patchset that went in the
> opposite direction, and attempted to preserve the information about
> how many pages were successfully read ahead. And that would be nice
> to have (at least IMHO), even all the way out to the syscall level,
> especially for the readahead syscall.

Right, and that was where I went initially.  It turns out to be a
non-trivial aount of work to do the book-keeping to find out how many
pages were _attempted_, and since we don't wait for the I/O to complete,
we don't know how many _succeeded_, and we also don't know how many
weren't attempted because they were already there, and how many weren't
attempted because somebody else has raced with us and is going to attempt
them themselves, and how many weren't attempted because we just ran out
of memory, and decided to give up.

Also, we don't know how many pages were successfully read, and then the
system decided to evict before the program found out how many were read,
let alone before it did any action based on that.

So, given all that complexity, and the fact that nobody actually does
anything with the limited and incorrect information we tried to provide
today, I think it's fair to say that anybody who wants to start to do
anything with that information can delve into all the complexity around
"what number should we return, and what does it really mean".  In the
meantime, let's just ditch the complexity and pretense that this number
means anything.
