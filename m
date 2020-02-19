Return-Path: <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>
X-Original-To: lists+linux-erofs@lfdr.de
Delivered-To: lists+linux-erofs@lfdr.de
Received: from lists.ozlabs.org (lists.ozlabs.org [203.11.71.2])
	by mail.lfdr.de (Postfix) with ESMTPS id 5B667163CB7
	for <lists+linux-erofs@lfdr.de>; Wed, 19 Feb 2020 06:35:57 +0100 (CET)
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2401:3900:2:1::3])
	by lists.ozlabs.org (Postfix) with ESMTP id 48MmfL4bhLzDqfK
	for <lists+linux-erofs@lfdr.de>; Wed, 19 Feb 2020 16:35:54 +1100 (AEDT)
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
 header.a=rsa-sha256 header.s=bombadil.20170209 header.b=DuVHuymB; 
 dkim-atps=neutral
Received: from bombadil.infradead.org (bombadil.infradead.org
 [IPv6:2607:7c80:54:e::133])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 48MmfF4zQwzDqWr
 for <linux-erofs@lists.ozlabs.org>; Wed, 19 Feb 2020 16:35:49 +1100 (AEDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=infradead.org; s=bombadil.20170209; h=In-Reply-To:Content-Type:MIME-Version
 :References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
 Content-Transfer-Encoding:Content-ID:Content-Description;
 bh=i5jjRMxpChRQy+2J/xRxaZpOqmFrFWQR+xd6cg6u2PI=; b=DuVHuymBPWn5wDST1aeEelhfNM
 /bXL88FT9MFQnHGtbK4rSNZ+luoUIXATKSnNmq0w0g+oFVWjyKpy66W6FFgRGnswoBOWQpscJbJQP
 4VedcAPQbAlzmDR4kFU3J0Di3kgpR1We770va4VzU0v+3uU5Psu/vRRzwnfoiQqbwdrygPBoB0Acc
 Kj/viayLIFCgDZTYuGeW41k0nXnLmWVc48ZXm+FRjozkqV+sHubRee661ywX49PCOT/E1uqhfX2Ny
 D9csTE5YF0U7xa7/EP5Jtkli2RRKOHF+UMVo8N/d71C108g1DAP7O0iiHuaezDNJcoHL5lnGSyTJU
 QRfWManA==;
Received: from willy by bombadil.infradead.org with local (Exim 4.92.3 #3 (Red
 Hat Linux)) id 1j4I1Q-0004Jt-TF; Wed, 19 Feb 2020 05:35:44 +0000
Date: Tue, 18 Feb 2020 21:35:44 -0800
From: Matthew Wilcox <willy@infradead.org>
To: John Hubbard <jhubbard@nvidia.com>
Subject: Re: [PATCH v6 17/19] iomap: Restructure iomap_readpages_actor
Message-ID: <20200219053544.GN24185@bombadil.infradead.org>
References: <20200217184613.19668-1-willy@infradead.org>
 <20200217184613.19668-31-willy@infradead.org>
 <d4803ef9-7a2f-965f-8f0f-c5e15396d892@nvidia.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <d4803ef9-7a2f-965f-8f0f-c5e15396d892@nvidia.com>
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

On Tue, Feb 18, 2020 at 07:17:18PM -0800, John Hubbard wrote:
> > -	for (done = 0; done < length; done += ret) {
> 
> nit: this "for" loop was perfect just the way it was. :) I'd vote here for reverting
> the change to a "while" loop. Because with this change, now the code has to 
> separately initialize "done", separately increment "done", and the beauty of a
> for loop is that the loop init and control is all clearly in one place. For things
> that follow that model (as in this case!), that's a Good Thing.
> 
> And I don't see any technical reason (even in the following patch) that requires 
> this change.

It's doing the increment in the wrong place.  We want the increment done in
the middle of the loop, before we check whether we've got to the end of
the page.  Not at the end of the loop.

> > +	BUG_ON(ctx.cur_page);
> 
> Is a full BUG_ON() definitely called for here? Seems like a WARN might suffice...

Dave made a similar comment; I'll pick this up there.
