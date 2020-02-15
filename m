Return-Path: <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>
X-Original-To: lists+linux-erofs@lfdr.de
Delivered-To: lists+linux-erofs@lfdr.de
Received: from lists.ozlabs.org (lists.ozlabs.org [203.11.71.2])
	by mail.lfdr.de (Postfix) with ESMTPS id 17F1F15FBE1
	for <lists+linux-erofs@lfdr.de>; Sat, 15 Feb 2020 02:15:25 +0100 (CET)
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2401:3900:2:1::3])
	by lists.ozlabs.org (Postfix) with ESMTP id 48KC3Z1SZPzDqnT
	for <lists+linux-erofs@lfdr.de>; Sat, 15 Feb 2020 12:15:22 +1100 (AEDT)
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
 header.a=rsa-sha256 header.s=bombadil.20170209 header.b=bYTz4ixA; 
 dkim-atps=neutral
Received: from bombadil.infradead.org (bombadil.infradead.org
 [IPv6:2607:7c80:54:e::133])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 48KC3N0fh0zDqmh
 for <linux-erofs@lists.ozlabs.org>; Sat, 15 Feb 2020 12:15:08 +1100 (AEDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=infradead.org; s=bombadil.20170209; h=In-Reply-To:Content-Type:MIME-Version
 :References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
 Content-Transfer-Encoding:Content-ID:Content-Description;
 bh=8vF3wmoykU6jc6+10TSp5NOFVxwRnMSI+FSzYO1WEQQ=; b=bYTz4ixAcXgUBn5lU/9H4Qkc8U
 psonlrVRSl1w2Efajn8sSvZ4fc66CBslbfJ8hYC7paJRLK+yJwFFKlpcmnCuSqQ3VgQIQc9bRKzS3
 RKpTi9vip5bJenIXktMAoR2hmT8VH80rF4tgY3sf4QnBz8MWKa+ALVxAEtDMgRdz1VPOIaUeTItOS
 2pxc8IX2HDPzzkM5B4sWPw6NpUySd6jYHfalkiD/26kIZxfM118k/TIVrruZyhX4bQ6tIJjKq3niB
 ldfXT72DOy+DLMs6ox4SNWF1RllK7qc+dkUXgtwEY31BR65L8+zEdJD+0mj8Hsxex+wOSOCKsfGso
 5F0cnt9Q==;
Received: from willy by bombadil.infradead.org with local (Exim 4.92.3 #3 (Red
 Hat Linux)) id 1j2m2z-0006lw-H3; Sat, 15 Feb 2020 01:15:05 +0000
Date: Fri, 14 Feb 2020 17:15:05 -0800
From: Matthew Wilcox <willy@infradead.org>
To: John Hubbard <jhubbard@nvidia.com>
Subject: Re: [PATCH v5 04/13] mm: Add readahead address space operation
Message-ID: <20200215011505.GD7778@bombadil.infradead.org>
References: <20200211010348.6872-1-willy@infradead.org>
 <20200211010348.6872-5-willy@infradead.org>
 <755399a8-8fdf-bfac-9f23-81579ff63ddf@nvidia.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <755399a8-8fdf-bfac-9f23-81579ff63ddf@nvidia.com>
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

On Thu, Feb 13, 2020 at 09:36:25PM -0800, John Hubbard wrote:
> > +static inline struct page *readahead_page(struct readahead_control *rac)
> > +{
> > +	struct page *page;
> > +
> > +	if (!rac->nr_pages)
> > +		return NULL;
> > +
> > +	page = xa_load(&rac->mapping->i_pages, rac->start);
> 
> 
> Is it worth asserting that the page was found:
> 
> 	VM_BUG_ON_PAGE(!page || xa_is_value(page), page);
> 
> ? Or is that overkill here?

It shouldn't be possible since they were just added in a locked state.
If it did happen, it'll be caught by the assert below -- dereferencing
a NULL pointer or a shadow entry is not going to go well.

> > +	VM_BUG_ON_PAGE(!PageLocked(page), page);
> > +	rac->batch_count = hpage_nr_pages(page);
> > +	rac->start += rac->batch_count;
> 
> The above was surprising, until I saw the other thread with Dave and you.
> I was reviewing this patchset in order to have a chance at understanding the 
> follow-on patchset ("Large pages in the page cache"), and it seems like that
> feature has a solid head start here. :)  

Right, I'll document that.
