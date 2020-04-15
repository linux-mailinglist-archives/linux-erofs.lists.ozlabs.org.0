Return-Path: <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>
X-Original-To: lists+linux-erofs@lfdr.de
Delivered-To: lists+linux-erofs@lfdr.de
Received: from lists.ozlabs.org (lists.ozlabs.org [203.11.71.2])
	by mail.lfdr.de (Postfix) with ESMTPS id E446A1A9045
	for <lists+linux-erofs@lfdr.de>; Wed, 15 Apr 2020 03:17:17 +0200 (CEST)
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2401:3900:2:1::3])
	by lists.ozlabs.org (Postfix) with ESMTP id 4924G31KTwzDqx5
	for <lists+linux-erofs@lfdr.de>; Wed, 15 Apr 2020 11:17:15 +1000 (AEST)
X-Original-To: linux-erofs@lists.ozlabs.org
Delivered-To: linux-erofs@lists.ozlabs.org
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized)
 smtp.mailfrom=linux-foundation.org (client-ip=198.145.29.99;
 helo=mail.kernel.org; envelope-from=akpm@linux-foundation.org;
 receiver=<UNKNOWN>)
Authentication-Results: lists.ozlabs.org; dmarc=none (p=none dis=none)
 header.from=linux-foundation.org
Authentication-Results: lists.ozlabs.org; dkim=pass (1024-bit key;
 unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256
 header.s=default header.b=trHGKNCx; dkim-atps=neutral
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 4924Fx47NqzDqwr
 for <linux-erofs@lists.ozlabs.org>; Wed, 15 Apr 2020 11:17:09 +1000 (AEST)
Received: from localhost.localdomain (c-73-231-172-41.hsd1.ca.comcast.net
 [73.231.172.41])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by mail.kernel.org (Postfix) with ESMTPSA id 5CD58206D9;
 Wed, 15 Apr 2020 01:17:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=default; t=1586913426;
 bh=Z8t12Kri4dLkYoQfBj9LeTBHSVbJC29k8QLFe4WYAn0=;
 h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
 b=trHGKNCxzakSMiiFFW7h7ipr5l5ZPqXMRMACUtk4YKpwd8Pg1RJ2PiBsRP5nCE9+1
 fCvzyZDvGOZsZH+JWcOhF2bmZOk4UdQ9IgBloKo9E4jlYJXAc0OSn746DXLsWt7WBJ
 s1ct6x0rSpHRCfj/HRWtfY1TDdkeieGLLTsLzoWE=
Date: Tue, 14 Apr 2020 18:17:05 -0700
From: Andrew Morton <akpm@linux-foundation.org>
To: Matthew Wilcox <willy@infradead.org>
Subject: Re: [PATCH v11 05/25] mm: Add new readahead_control API
Message-Id: <20200414181705.bfc4c0087092051a9475141e@linux-foundation.org>
In-Reply-To: <20200414150233.24495-6-willy@infradead.org>
References: <20200414150233.24495-1-willy@infradead.org>
 <20200414150233.24495-6-willy@infradead.org>
X-Mailer: Sylpheed 3.5.1 (GTK+ 2.24.31; x86_64-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
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
Cc: linux-xfs@vger.kernel.org, William Kucharski <william.kucharski@oracle.com>,
 linux-kernel@vger.kernel.org, linux-f2fs-devel@lists.sourceforge.net,
 cluster-devel@redhat.com, linux-mm@kvack.org, ocfs2-devel@oss.oracle.com,
 linux-fsdevel@vger.kernel.org, linux-ext4@vger.kernel.org,
 linux-erofs@lists.ozlabs.org, Christoph Hellwig <hch@lst.de>,
 linux-btrfs@vger.kernel.org
Errors-To: linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org
Sender: "Linux-erofs"
 <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>

On Tue, 14 Apr 2020 08:02:13 -0700 Matthew Wilcox <willy@infradead.org> wrote:

> From: "Matthew Wilcox (Oracle)" <willy@infradead.org>
> 
> Filesystems which implement the upcoming ->readahead method will get
> their pages by calling readahead_page() or readahead_page_batch().
> These functions support large pages, even though none of the filesystems
> to be converted do yet.
> 
> +static inline struct page *readahead_page(struct readahead_control *rac)
> +static inline unsigned int __readahead_batch(struct readahead_control *rac,
> +		struct page **array, unsigned int array_sz)

These are large functions.  Was it correct to inline them?

The batching API only appears to be used by fuse?  If so, do we really
need it?  Does it provide some functional need, or is it a performance
thing?  If the latter, how significant is it?

The code adds quite a few (inlined!) VM_BUG_ONs.  Can we plan to remove
them at some stage?  Such as, before Linus shouts at us :)
