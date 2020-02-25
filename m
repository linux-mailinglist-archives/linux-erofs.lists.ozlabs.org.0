Return-Path: <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>
X-Original-To: lists+linux-erofs@lfdr.de
Delivered-To: lists+linux-erofs@lfdr.de
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2401:3900:2:1::3])
	by mail.lfdr.de (Postfix) with ESMTPS id A006916B760
	for <lists+linux-erofs@lfdr.de>; Tue, 25 Feb 2020 02:50:04 +0100 (CET)
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2401:3900:2:1::3])
	by lists.ozlabs.org (Postfix) with ESMTP id 48RMLx2c5ZzDqQ8
	for <lists+linux-erofs@lfdr.de>; Tue, 25 Feb 2020 12:50:01 +1100 (AEDT)
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
 header.a=rsa-sha256 header.s=bombadil.20170209 header.b=nq6XE/tS; 
 dkim-atps=neutral
Received: from bombadil.infradead.org (bombadil.infradead.org
 [IPv6:2607:7c80:54:e::133])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 48RMLn0dzlzDqQ8
 for <linux-erofs@lists.ozlabs.org>; Tue, 25 Feb 2020 12:49:51 +1100 (AEDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=infradead.org; s=bombadil.20170209; h=In-Reply-To:Content-Type:MIME-Version
 :References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
 Content-Transfer-Encoding:Content-ID:Content-Description;
 bh=yPstBDWt6d6bgib6lzSxq/HWT4OJnZOw1KjPemQQZhk=; b=nq6XE/tSepneJylkylrJT/pjX0
 Spd9n665DMmObVCAJQLiBcVE27W55R0GvvnwfhobI0nmTEDz86mNpQ7jYVEvZB4cBHnXuxzpqbtB2
 dztcP9+wnlj1Npzqvcvw4SBbhcPINCOrW5w/GB5Voz46hys+/yy1cVSQJnvnClSLqQV0BlbT/xSnd
 Nll+nW4Z23UwGg0w+NmFJ+j5Vj9uN8TwBH0aWud5eMbaqI91DlTxC7X8GQe99Ryifnf+8ekuv6cG5
 v3Zi+BLESY98iLiL33OQI7hDesuLmsELZwns1M2tRR8quGkyU/jgISoLGdMjNj/zL8NWKAboOxtDf
 qQluRdMA==;
Received: from willy by bombadil.infradead.org with local (Exim 4.92.3 #3 (Red
 Hat Linux)) id 1j6PM5-0005vC-A1; Tue, 25 Feb 2020 01:49:49 +0000
Date: Mon, 24 Feb 2020 17:49:49 -0800
From: Matthew Wilcox <willy@infradead.org>
To: Christoph Hellwig <hch@infradead.org>
Subject: Re: [PATCH v7 21/24] iomap: Restructure iomap_readpages_actor
Message-ID: <20200225014949.GS24185@bombadil.infradead.org>
References: <20200219210103.32400-1-willy@infradead.org>
 <20200219210103.32400-22-willy@infradead.org>
 <20200220154741.GB19577@infradead.org>
 <20200220162404.GY24185@bombadil.infradead.org>
 <20200224221749.GA22231@infradead.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200224221749.GA22231@infradead.org>
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

On Mon, Feb 24, 2020 at 02:17:49PM -0800, Christoph Hellwig wrote:
> On Thu, Feb 20, 2020 at 08:24:04AM -0800, Matthew Wilcox wrote:
> > On Thu, Feb 20, 2020 at 07:47:41AM -0800, Christoph Hellwig wrote:
> > > On Wed, Feb 19, 2020 at 01:01:00PM -0800, Matthew Wilcox wrote:
> > > > From: "Matthew Wilcox (Oracle)" <willy@infradead.org>
> > > > 
> > > > By putting the 'have we reached the end of the page' condition at the end
> > > > of the loop instead of the beginning, we can remove the 'submit the last
> > > > page' code from iomap_readpages().  Also check that iomap_readpage_actor()
> > > > didn't return 0, which would lead to an endless loop.
> > > 
> > > I'm obviously biassed a I wrote the original code, but I find the new
> > > very much harder to understand (not that the previous one was easy, this
> > > is tricky code..).
> > 
> > Agreed, I found the original code hard to understand.  I think this is
> > easier because now cur_page doesn't leak outside this loop, so it has
> > an obvious lifecycle.
> 
> I really don't like this patch, and would prefer if the series goes
> ahead without it, as the current sctructure works just fine even
> with the readahead changes.

Dave Chinner specifically asked me to do it this way, so please fight
amongst yourselves.
