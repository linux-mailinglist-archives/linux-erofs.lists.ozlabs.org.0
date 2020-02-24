Return-Path: <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>
X-Original-To: lists+linux-erofs@lfdr.de
Delivered-To: lists+linux-erofs@lfdr.de
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2401:3900:2:1::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 1B19316B33C
	for <lists+linux-erofs@lfdr.de>; Mon, 24 Feb 2020 22:53:47 +0100 (CET)
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2401:3900:2:1::3])
	by lists.ozlabs.org (Postfix) with ESMTP id 48RG6G340yzDqT1
	for <lists+linux-erofs@lfdr.de>; Tue, 25 Feb 2020 08:53:42 +1100 (AEDT)
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
 header.a=rsa-sha256 header.s=bombadil.20170209 header.b=RwxpBsPs; 
 dkim-atps=neutral
Received: from bombadil.infradead.org (bombadil.infradead.org
 [IPv6:2607:7c80:54:e::133])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 48RG660RhgzDqSK
 for <linux-erofs@lists.ozlabs.org>; Tue, 25 Feb 2020 08:53:33 +1100 (AEDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=infradead.org; s=bombadil.20170209; h=In-Reply-To:Content-Type:MIME-Version
 :References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
 Content-Transfer-Encoding:Content-ID:Content-Description;
 bh=mw9BVCxn7pfkdLzlqdnU62sf9jMMFSFqSbqAU1P/njM=; b=RwxpBsPsAgcRXU3+CiEQvZpAse
 L2XfCTem5LohmiBMGiEV7Hm4Q3mq7vEyPk+b+gdQxjievErsV1U0sY4fKiS2rqk8DgPLM6tE/jyo7
 RUfRapcRZfourQ1+8voII3tkr9GhwLaPUKBKdb6fQeopIO4chmzl/v5t6FIfWR7wbQiRF1O6EBK0h
 WaTduDEs7a07V+6hmEAGyqVmyNUglmconIZmqhNx+20JaYUAmyxvUJX8V1fiSDOy0IFJWCuWrnlre
 puYN8dx/kZQdNIUe/ZOCrJV6SjguxVWedPzERekOT5SPrIVJ6wsJiCGW49A+qXEg0yXWQjvam0IVc
 Md0CFWPg==;
Received: from hch by bombadil.infradead.org with local (Exim 4.92.3 #3 (Red
 Hat Linux)) id 1j6LfI-0004DG-G7; Mon, 24 Feb 2020 21:53:24 +0000
Date: Mon, 24 Feb 2020 13:53:24 -0800
From: Christoph Hellwig <hch@infradead.org>
To: Matthew Wilcox <willy@infradead.org>
Subject: Re: [Cluster-devel] [PATCH v7 12/24] mm: Add
 page_cache_readahead_unbounded
Message-ID: <20200224215324.GA16051@infradead.org>
References: <20200219210103.32400-1-willy@infradead.org>
 <20200219210103.32400-13-willy@infradead.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200219210103.32400-13-willy@infradead.org>
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
 linux-f2fs-devel@lists.sourceforge.net, linux-xfs@vger.kernel.org,
 linux-mm@kvack.org, linux-btrfs@vger.kernel.org, linux-fsdevel@vger.kernel.org,
 linux-ext4@vger.kernel.org, linux-erofs@lists.ozlabs.org,
 ocfs2-devel@oss.oracle.com
Errors-To: linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org
Sender: "Linux-erofs"
 <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>

On Wed, Feb 19, 2020 at 01:00:51PM -0800, Matthew Wilcox wrote:
> From: "Matthew Wilcox (Oracle)" <willy@infradead.org>
> 
> ext4 and f2fs have duplicated the guts of the readahead code so
> they can read past i_size.  Instead, separate out the guts of the
> readahead code so they can call it directly.

I don't like this, but then I like the horrible open coded versions
even less..  Can you add a do not use for new code comment to the
function as well?

Otherwise looks good:

Reviewed-by: Christoph Hellwig <hch@lst.de>
