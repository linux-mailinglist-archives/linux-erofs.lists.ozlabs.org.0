Return-Path: <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>
X-Original-To: lists+linux-erofs@lfdr.de
Delivered-To: lists+linux-erofs@lfdr.de
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2401:3900:2:1::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 518B7170587
	for <lists+linux-erofs@lfdr.de>; Wed, 26 Feb 2020 18:07:37 +0100 (CET)
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2401:3900:2:1::3])
	by lists.ozlabs.org (Postfix) with ESMTP id 48SMgB4j2hzDqfL
	for <lists+linux-erofs@lfdr.de>; Thu, 27 Feb 2020 04:07:34 +1100 (AEDT)
X-Original-To: linux-erofs@lists.ozlabs.org
Delivered-To: linux-erofs@lists.ozlabs.org
Authentication-Results: lists.ozlabs.org; spf=none (no SPF record)
 smtp.mailfrom=bombadil.srs.infradead.org (client-ip=2607:7c80:54:e::133;
 helo=bombadil.infradead.org;
 envelope-from=batv+7931773228f1d9803703+6030+infradead.org+hch@bombadil.srs.infradead.org;
 receiver=<UNKNOWN>)
Authentication-Results: lists.ozlabs.org;
 dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: lists.ozlabs.org; dkim=pass (2048-bit key;
 unprotected) header.d=infradead.org header.i=@infradead.org
 header.a=rsa-sha256 header.s=bombadil.20170209 header.b=EiR9E4pR; 
 dkim-atps=neutral
Received: from bombadil.infradead.org (bombadil.infradead.org
 [IPv6:2607:7c80:54:e::133])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 48SMg70J9ZzDqTW
 for <linux-erofs@lists.ozlabs.org>; Thu, 27 Feb 2020 04:07:30 +1100 (AEDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=infradead.org; s=bombadil.20170209; h=In-Reply-To:Content-Type:MIME-Version
 :References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
 Content-Transfer-Encoding:Content-ID:Content-Description;
 bh=ZJi9hC4ehvqCcf6BlT7xvIkRN9seHzpJl6dLbb5ZRoM=; b=EiR9E4pRiVBrxOAfbZhMffZ3+i
 Ol5Ip+ZZrYlhL+mB+pu99N95gdjW/F3y2Z7IeerpE6EtJ/VNYQv1iUIDYr8VvaaTT4WkF8sR/2nun
 0ZPWOfMsbneBeAeCiTcC3tCwOzHeSTU7/DdSdBD9VKqHiUOBtS2uIfDf1EEdnlG9b7LBySCXHHftT
 +j5GVuJjDmc8eW8b59vJiYX/4jB/OVr6jjD2TFu5q9GUn+qXyZ5V1hyexGPIjhtsfiJbZ5SD+mfwO
 mRMegtoRIZ6mD01bXz8gces8xrJ2v4xWcOwg0hb2antvlx/u9r+GdNEECP/xbVSRsWYq6k0zUWzqu
 GwB/MpMA==;
Received: from hch by bombadil.infradead.org with local (Exim 4.92.3 #3 (Red
 Hat Linux)) id 1j709g-0008JU-1v; Wed, 26 Feb 2020 17:07:28 +0000
Date: Wed, 26 Feb 2020 09:07:28 -0800
From: Christoph Hellwig <hch@infradead.org>
To: "Darrick J. Wong" <darrick.wong@oracle.com>
Subject: Re: [PATCH v8 25/25] iomap: Convert from readpages to readahead
Message-ID: <20200226170728.GD22837@infradead.org>
References: <20200225214838.30017-1-willy@infradead.org>
 <20200225214838.30017-26-willy@infradead.org>
 <20200226170425.GD8045@magnolia>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200226170425.GD8045@magnolia>
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
Cc: linux-xfs@vger.kernel.org, linux-kernel@vger.kernel.org,
 Matthew Wilcox <willy@infradead.org>, linux-f2fs-devel@lists.sourceforge.net,
 cluster-devel@redhat.com, linux-mm@kvack.org, ocfs2-devel@oss.oracle.com,
 linux-fsdevel@vger.kernel.org, linux-ext4@vger.kernel.org,
 linux-erofs@lists.ozlabs.org, linux-btrfs@vger.kernel.org
Errors-To: linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org
Sender: "Linux-erofs"
 <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>

On Wed, Feb 26, 2020 at 09:04:25AM -0800, Darrick J. Wong wrote:
> > @@ -456,15 +435,8 @@ iomap_readpages(struct address_space *mapping, struct list_head *pages,
> >  			unlock_page(ctx.cur_page);
> >  		put_page(ctx.cur_page);
> >  	}
> > -
> > -	/*
> > -	 * Check that we didn't lose a page due to the arcance calling
> > -	 * conventions..
> > -	 */
> > -	WARN_ON_ONCE(!ret && !list_empty(ctx.pages));
> > -	return ret;
> 
> After all the discussion about "if we still have ctx.cur_page we should
> just stop" in v7, I'm surprised that this patch now doesn't say much of
> anything, not even a WARN_ON()?

The code quoted above puts the cur_page reference.  By dropping the
odd refactoring patch there is no need to check for cur_page being
left as a special condition as that still is the normal loop exit
state and properly handled, just as in the original iomap code.
