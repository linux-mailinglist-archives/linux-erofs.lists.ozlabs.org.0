Return-Path: <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>
X-Original-To: lists+linux-erofs@lfdr.de
Delivered-To: lists+linux-erofs@lfdr.de
Received: from lists.ozlabs.org (lists.ozlabs.org [203.11.71.2])
	by mail.lfdr.de (Postfix) with ESMTPS id 60031163BAF
	for <lists+linux-erofs@lfdr.de>; Wed, 19 Feb 2020 04:56:00 +0100 (CET)
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2401:3900:2:1::3])
	by lists.ozlabs.org (Postfix) with ESMTP id 48MkR16Sn7zDqhS
	for <lists+linux-erofs@lfdr.de>; Wed, 19 Feb 2020 14:55:57 +1100 (AEDT)
X-Original-To: linux-erofs@lists.ozlabs.org
Delivered-To: linux-erofs@lists.ozlabs.org
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized)
 smtp.mailfrom=kernel.org (client-ip=198.145.29.99; helo=mail.kernel.org;
 envelope-from=ebiggers@kernel.org; receiver=<UNKNOWN>)
Authentication-Results: lists.ozlabs.org;
 dmarc=pass (p=none dis=none) header.from=kernel.org
Authentication-Results: lists.ozlabs.org; dkim=pass (1024-bit key;
 unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256
 header.s=default header.b=cHpc7qeS; dkim-atps=neutral
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 48MkQy5pDxzDqfK
 for <linux-erofs@lists.ozlabs.org>; Wed, 19 Feb 2020 14:55:54 +1100 (AEDT)
Received: from sol.localdomain (c-107-3-166-239.hsd1.ca.comcast.net
 [107.3.166.239])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by mail.kernel.org (Postfix) with ESMTPSA id DCCEB206DB;
 Wed, 19 Feb 2020 03:55:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=default; t=1582084552;
 bh=ra63ctCM03qQ/yjMX6m08SRFO6UdUhDwmhqww51jeug=;
 h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
 b=cHpc7qeSZ/gAs6+Ko/Z9/c8wDmwW8WTd6Y9ysIVgBbEI5SGfvT8WdEDSgJvrnpRtd
 JfJgLR87X7pDZj1ZfCs4p5yM6PqBSZH+kh5NSfb+dGb2Fgl12LstCggu8oVIaphCC5
 XsxYNaY/zixWmZHQTqiVBZLArwLDm8F1awAYyw38=
Date: Tue, 18 Feb 2020 19:55:50 -0800
From: Eric Biggers <ebiggers@kernel.org>
To: Matthew Wilcox <willy@infradead.org>
Subject: Re: [PATCH v6 10/19] fs: Convert mpage_readpages to mpage_readahead
Message-ID: <20200219035550.GE1075@sol.localdomain>
References: <20200217184613.19668-1-willy@infradead.org>
 <20200217184613.19668-18-willy@infradead.org>
 <20200219032826.GB1075@sol.localdomain>
 <20200219034741.GK24185@bombadil.infradead.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200219034741.GK24185@bombadil.infradead.org>
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
Cc: cluster-devel@redhat.com, linux-ext4@vger.kernel.org,
 linux-kernel@vger.kernel.org, linux-f2fs-devel@lists.sourceforge.net,
 linux-xfs@vger.kernel.org, linux-mm@kvack.org, linux-btrfs@vger.kernel.org,
 linux-fsdevel@vger.kernel.org, Junxiao Bi <junxiao.bi@oracle.com>,
 linux-erofs@lists.ozlabs.org, ocfs2-devel@oss.oracle.com
Errors-To: linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org
Sender: "Linux-erofs"
 <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>

On Tue, Feb 18, 2020 at 07:47:41PM -0800, Matthew Wilcox wrote:
> On Tue, Feb 18, 2020 at 07:28:26PM -0800, Eric Biggers wrote:
> > On Mon, Feb 17, 2020 at 10:45:58AM -0800, Matthew Wilcox wrote:
> > > diff --git a/include/linux/mpage.h b/include/linux/mpage.h
> > > index 001f1fcf9836..f4f5e90a6844 100644
> > > --- a/include/linux/mpage.h
> > > +++ b/include/linux/mpage.h
> > > @@ -13,9 +13,9 @@
> > >  #ifdef CONFIG_BLOCK
> > >  
> > >  struct writeback_control;
> > > +struct readahead_control;
> > >  
> > > -int mpage_readpages(struct address_space *mapping, struct list_head *pages,
> > > -				unsigned nr_pages, get_block_t get_block);
> > > +void mpage_readahead(struct readahead_control *, get_block_t get_block);
> > >  int mpage_readpage(struct page *page, get_block_t get_block);
> > >  int mpage_writepages(struct address_space *mapping,
> > >  		struct writeback_control *wbc, get_block_t get_block);
> > 
> > Can you name the 'struct readahead_control *' parameter?
> 
> What good would that do?  I'm sick of seeing 'struct page *page'.
> Well, no shit it's a page.  Unless there's some actual information to
> convey, leave the argument unnamed.  It should be a crime to not name
> an unsigned long, but not naming the struct address_space pointer is
> entirely reasonable.

It's the coding style the community has agreed on, so the tools check for.

I don't care that much myself; it just appeared like this was a mistake rather
than intentional so I thought I'd point it out.

- Eric
