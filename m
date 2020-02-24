Return-Path: <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>
X-Original-To: lists+linux-erofs@lfdr.de
Delivered-To: lists+linux-erofs@lfdr.de
Received: from lists.ozlabs.org (lists.ozlabs.org [203.11.71.2])
	by mail.lfdr.de (Postfix) with ESMTPS id 8744E16B3AA
	for <lists+linux-erofs@lfdr.de>; Mon, 24 Feb 2020 23:18:07 +0100 (CET)
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2401:3900:2:1::3])
	by lists.ozlabs.org (Postfix) with ESMTP id 48RGfP0XBmzDqQq
	for <lists+linux-erofs@lfdr.de>; Tue, 25 Feb 2020 09:18:05 +1100 (AEDT)
X-Original-To: linux-erofs@lists.ozlabs.org
Delivered-To: linux-erofs@lists.ozlabs.org
Authentication-Results: lists.ozlabs.org; spf=none (no SPF record)
 smtp.mailfrom=bombadil.srs.infradead.org (client-ip=2607:7c80:54:e::133;
 helo=bombadil.infradead.org;
 envelope-from=batv+fd4c774fa746ae91f5d1+6028+infradead.org+hch@bombadil.srs.infradead.org;
 receiver=<UNKNOWN>)
Authentication-Results: lists.ozlabs.org;
 dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: lists.ozlabs.org; dkim=pass (2048-bit key;
 unprotected) header.d=infradead.org header.i=@infradead.org
 header.a=rsa-sha256 header.s=bombadil.20170209 header.b=pB+5oZWV; 
 dkim-atps=neutral
Received: from bombadil.infradead.org (bombadil.infradead.org
 [IPv6:2607:7c80:54:e::133])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 48RGf76rctzDqP1
 for <linux-erofs@lists.ozlabs.org>; Tue, 25 Feb 2020 09:17:51 +1100 (AEDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=infradead.org; s=bombadil.20170209; h=In-Reply-To:Content-Type:MIME-Version
 :References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
 Content-Transfer-Encoding:Content-ID:Content-Description;
 bh=SD1yx0YoAU9Bzlni+o86AkG96/rc/8SSS4sRPjtuIYU=; b=pB+5oZWVTu+RlW3J/EESOvRbJB
 BhenyWBT/6m8GOFdFElQJCxMbpx1xaeKthjka5pjD6jbGH4Yb4isWW678N/C1jEWJrUjOlo+gO3Wr
 Fc+GPx4uW5jDWOEduKUpXye86IX3XAlQeX17eAH1O9MrALkq72vBwumB3SryCX1PQ21Cu5rjB+LH+
 LFNujmpdrRUyH0LpGKYHkHsi54xutUiobEdAg4riDPA5mRYuMsyFoBP03wVQn0kFpk94BKaabAiRg
 qtA4ThIZJjuV+zv0m358v08Y+jltVma43bg6qDq7T97btYMe7X25tdyvSveobCz77SFx4CC7cEIkX
 lGoig/Dw==;
Received: from hch by bombadil.infradead.org with local (Exim 4.92.3 #3 (Red
 Hat Linux)) id 1j6M2v-00087x-1f; Mon, 24 Feb 2020 22:17:49 +0000
Date: Mon, 24 Feb 2020 14:17:49 -0800
From: Christoph Hellwig <hch@infradead.org>
To: Matthew Wilcox <willy@infradead.org>
Subject: Re: [PATCH v7 21/24] iomap: Restructure iomap_readpages_actor
Message-ID: <20200224221749.GA22231@infradead.org>
References: <20200219210103.32400-1-willy@infradead.org>
 <20200219210103.32400-22-willy@infradead.org>
 <20200220154741.GB19577@infradead.org>
 <20200220162404.GY24185@bombadil.infradead.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200220162404.GY24185@bombadil.infradead.org>
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by
 bombadil.infradead.org. See http://www.infradead.org/rpr.html
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
Cc: cluster-devel@redhat.com, linux-kernel@vger.kernel.org,
 linux-f2fs-devel@lists.sourceforge.net, Christoph Hellwig <hch@infradead.org>,
 linux-mm@kvack.org, ocfs2-devel@oss.oracle.com, linux-fsdevel@vger.kernel.org,
 linux-ext4@vger.kernel.org, linux-erofs@lists.ozlabs.org,
 linux-xfs@vger.kernel.org, linux-btrfs@vger.kernel.org
Errors-To: linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org
Sender: "Linux-erofs"
 <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>

On Thu, Feb 20, 2020 at 08:24:04AM -0800, Matthew Wilcox wrote:
> On Thu, Feb 20, 2020 at 07:47:41AM -0800, Christoph Hellwig wrote:
> > On Wed, Feb 19, 2020 at 01:01:00PM -0800, Matthew Wilcox wrote:
> > > From: "Matthew Wilcox (Oracle)" <willy@infradead.org>
> > > 
> > > By putting the 'have we reached the end of the page' condition at the end
> > > of the loop instead of the beginning, we can remove the 'submit the last
> > > page' code from iomap_readpages().  Also check that iomap_readpage_actor()
> > > didn't return 0, which would lead to an endless loop.
> > 
> > I'm obviously biassed a I wrote the original code, but I find the new
> > very much harder to understand (not that the previous one was easy, this
> > is tricky code..).
> 
> Agreed, I found the original code hard to understand.  I think this is
> easier because now cur_page doesn't leak outside this loop, so it has
> an obvious lifecycle.

I really don't like this patch, and would prefer if the series goes
ahead without it, as the current sctructure works just fine even
with the readahead changes.
