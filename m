Return-Path: <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>
X-Original-To: lists+linux-erofs@lfdr.de
Delivered-To: lists+linux-erofs@lfdr.de
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2404:9400:2:0:216:3eff:fee1:b9f1])
	by mail.lfdr.de (Postfix) with ESMTPS id 891C2709169
	for <lists+linux-erofs@lfdr.de>; Fri, 19 May 2023 10:10:49 +0200 (CEST)
Received: from boromir.ozlabs.org (localhost [IPv6:::1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4QN0072YVkz3fBk
	for <lists+linux-erofs@lfdr.de>; Fri, 19 May 2023 18:10:47 +1000 (AEST)
Authentication-Results: lists.ozlabs.org;
	dkim=fail reason="signature verification failed" (2048-bit key; secure) header.d=infradead.org header.i=@infradead.org header.a=rsa-sha256 header.s=bombadil.20210309 header.b=EILKCF4/;
	dkim-atps=neutral
X-Original-To: linux-erofs@lists.ozlabs.org
Delivered-To: linux-erofs@lists.ozlabs.org
Authentication-Results: lists.ozlabs.org; spf=none (no SPF record) smtp.mailfrom=bombadil.srs.infradead.org (client-ip=2607:7c80:54:3::133; helo=bombadil.infradead.org; envelope-from=batv+aecf67361b95543ec79f+7208+infradead.org+hch@bombadil.srs.infradead.org; receiver=<UNKNOWN>)
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:3::133])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4QMzzw16tHz3f7W
	for <linux-erofs@lists.ozlabs.org>; Fri, 19 May 2023 18:10:32 +1000 (AEST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=bombadil.20210309; h=In-Reply-To:Content-Type:MIME-Version
	:References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=+KcNj38ck2QF6TY7QpJyCILaVWe/y++Y4IGZh5WM6/M=; b=EILKCF4/UqHDv9mi6SKDXcFyKo
	cdPd47QMCzDlG6o53QlCOZOe346y4W9Qkf482gpqYE3gnzht4wtpO8bPsKhN88Z1V7bA3Db8afI+a
	AXjbJoheJOfgmY3ClNKdB5NG+SAihzQ8ygcip1mTQa3a/yMSlFdtlOaI+inmDt9/rX3/Iq+SUWh43
	5b8SVHjGlgO1c8NDzCG7QO5EWTniG17r2GqzTzSNFMw9WRcUSC2GDnliQsbXHRSbqOefid93BsSYs
	nNdZ7yByE7x/DcRlMKe5+ZP/35erKJjLRwgXmEqguAL2yYFof6koWpAEd8a4I+5kO2VK19jNow573
	Gz8nMSDg==;
Received: from hch by bombadil.infradead.org with local (Exim 4.96 #2 (Red Hat Linux))
	id 1pzvBo-00FTbc-0R;
	Fri, 19 May 2023 08:10:16 +0000
Date: Fri, 19 May 2023 01:10:16 -0700
From: Christoph Hellwig <hch@infradead.org>
To: David Howells <dhowells@redhat.com>
Subject: Re: [PATCH v20 05/32] splice: Make splice from a DAX file use
 direct_splice_read()
Message-ID: <ZGcu6GVxOgYfy8x9@infradead.org>
References: <20230519074047.1739879-1-dhowells@redhat.com>
 <20230519074047.1739879-6-dhowells@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230519074047.1739879-6-dhowells@redhat.com>
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html
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
Cc: Jens Axboe <axboe@kernel.dk>, linux-block@vger.kernel.org, Hillf Danton <hdanton@sina.com>, Jan Kara <jack@suse.cz>, linux-xfs@vger.kernel.org, David Hildenbrand <david@redhat.com>, linux-erofs@lists.ozlabs.org, Linus Torvalds <torvalds@linux-foundation.org>, Jeff Layton <jlayton@kernel.org>, Christian Brauner <brauner@kernel.org>, Matthew Wilcox <willy@infradead.org>, linux-kernel@vger.kernel.org, Christoph Hellwig <hch@infradead.org>, linux-mm@kvack.org, Al Viro <viro@zeniv.linux.org.uk>, Jason Gunthorpe <jgg@nvidia.com>, linux-fsdevel@vger.kernel.org, linux-ext4@vger.kernel.org, Logan Gunthorpe <logang@deltatee.com>, Christoph Hellwig <hch@lst.de>
Errors-To: linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org
Sender: "Linux-erofs" <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>

On Fri, May 19, 2023 at 08:40:20AM +0100, David Howells wrote:
> +#ifdef CONFIG_FS_DAX
> +	if (IS_DAX(in->f_mapping->host))

No need for the ifdef.  IS_DAX is compile-time false if CONFIG_FS_DAX
is not set.

A comment on why we're doing this in the code would probably be useful
as well.
