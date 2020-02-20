Return-Path: <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>
X-Original-To: lists+linux-erofs@lfdr.de
Delivered-To: lists+linux-erofs@lfdr.de
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2401:3900:2:1::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 8559816625E
	for <lists+linux-erofs@lfdr.de>; Thu, 20 Feb 2020 17:24:16 +0100 (CET)
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2401:3900:2:1::3])
	by lists.ozlabs.org (Postfix) with ESMTP id 48Nfzx33mtzDqLp
	for <lists+linux-erofs@lfdr.de>; Fri, 21 Feb 2020 03:24:13 +1100 (AEDT)
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
 header.a=rsa-sha256 header.s=bombadil.20170209 header.b=lxTIdidZ; 
 dkim-atps=neutral
Received: from bombadil.infradead.org (bombadil.infradead.org
 [IPv6:2607:7c80:54:e::133])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 48Nfzq14PXzDqGc
 for <linux-erofs@lists.ozlabs.org>; Fri, 21 Feb 2020 03:24:06 +1100 (AEDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=infradead.org; s=bombadil.20170209; h=In-Reply-To:Content-Type:MIME-Version
 :References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
 Content-Transfer-Encoding:Content-ID:Content-Description;
 bh=/X+cuahXNVjwX8kIjzPU/QZUMEm+qIm+lNxfvhlX3EA=; b=lxTIdidZw2P2UO9t/Oji3FNceT
 +CjnxJZogq66GLHl3rhRoufVhXPoH7CxN5rw1pgrMvr7szk03lJeq2TvDL3R2ys6m86hnGj7sXBXg
 AQaHFo4WLWH90RnuR6backVMmU/lhsJTXMH7V42hfdxcXElLYWAoi8WkszieVn0N2xZmXUiT1EECe
 GJX8uJUjnaFLb7zI2vKxvhhrKwSedVafnnaMtZd9zrJbg6npgPtnxSYDtx+h9J81ITalXizKXonPp
 SQVVA+pyipbUonuljCpyE7+n90vEPRYltjJb/REqxUNVBonREpCV+ttQEEWV7EF1CEorahGhIHM1b
 9p1J3F8g==;
Received: from willy by bombadil.infradead.org with local (Exim 4.92.3 #3 (Red
 Hat Linux)) id 1j4ocO-0001zg-A1; Thu, 20 Feb 2020 16:24:04 +0000
Date: Thu, 20 Feb 2020 08:24:04 -0800
From: Matthew Wilcox <willy@infradead.org>
To: Christoph Hellwig <hch@infradead.org>
Subject: Re: [PATCH v7 21/24] iomap: Restructure iomap_readpages_actor
Message-ID: <20200220162404.GY24185@bombadil.infradead.org>
References: <20200219210103.32400-1-willy@infradead.org>
 <20200219210103.32400-22-willy@infradead.org>
 <20200220154741.GB19577@infradead.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200220154741.GB19577@infradead.org>
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

On Thu, Feb 20, 2020 at 07:47:41AM -0800, Christoph Hellwig wrote:
> On Wed, Feb 19, 2020 at 01:01:00PM -0800, Matthew Wilcox wrote:
> > From: "Matthew Wilcox (Oracle)" <willy@infradead.org>
> > 
> > By putting the 'have we reached the end of the page' condition at the end
> > of the loop instead of the beginning, we can remove the 'submit the last
> > page' code from iomap_readpages().  Also check that iomap_readpage_actor()
> > didn't return 0, which would lead to an endless loop.
> 
> I'm obviously biassed a I wrote the original code, but I find the new
> very much harder to understand (not that the previous one was easy, this
> is tricky code..).

Agreed, I found the original code hard to understand.  I think this is
easier because now cur_page doesn't leak outside this loop, so it has
an obvious lifecycle.

I'm kind of optimistic for Dave Howells' iov_iter addition of an
ITER_MAPPING.  That might simplify all of this code.
