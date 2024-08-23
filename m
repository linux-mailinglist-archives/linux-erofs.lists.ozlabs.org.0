Return-Path: <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>
X-Original-To: lists+linux-erofs@lfdr.de
Delivered-To: lists+linux-erofs@lfdr.de
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2404:9400:2:0:216:3eff:fee1:b9f1])
	by mail.lfdr.de (Postfix) with ESMTPS id 8CECB95D74E
	for <lists+linux-erofs@lfdr.de>; Fri, 23 Aug 2024 22:13:13 +0200 (CEST)
Received: from boromir.ozlabs.org (localhost [IPv6:::1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4WrB8R1g7bz304B
	for <lists+linux-erofs@lfdr.de>; Sat, 24 Aug 2024 06:13:11 +1000 (AEST)
X-Original-To: linux-erofs@lists.ozlabs.org
Delivered-To: linux-erofs@lists.ozlabs.org
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip="2001:8b0:10b:1236::1"
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1724443987;
	cv=none; b=BuqGTm8tzZHoIpekUuXfjWmP8jVmsoV6Z4e4folPSelXzalG8suil082zqqgyoKQpRv5uo9B3zuctzi65WTl23fMZGbzMFVng5I14rEL4NG+2cOxUr4NeBm516s4cs9fPynlFLjeVMfbzKN3xr2JFWwzQWHYGz+w6vTlFMxVqs8XeIp4zr46MxgmCYKz29MGTm7wD5cKdIM4EYaCHz7TY8vorfCh2+a7U1zrccaBqnLgieoog0zeFMnmnM08cphHB+1pWwGKEwcVKwmegpEGFAhljAaV6bh7o0EhQAqNJdRoeAlkzQ06AJ6Bs2NoPBW6+ruZJGI7pAEaQeZSkduZmQ==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1724443987; c=relaxed/relaxed;
	bh=JsVlpGeKYbg4pM/Q7waOkd0NZPoyLhoXi4BOdIXNLpY=;
	h=DKIM-Signature:Received:Date:From:To:Cc:Subject:Message-ID:
	 References:MIME-Version:Content-Type:Content-Disposition:
	 In-Reply-To; b=dsspQmnNStsIA1nbuZu3Qec2lTq7itaEVIj7aDCtXWX6lkJXWs99xjkpPAUStPHkqhxMruJ6LuP28uu+tCStUm0oZvWA6c+qaXO1Go6bGBbHmOhlU2f9SZx1vhwUThjRA0CuSI+MALkXKMMF8JVMGWOXQH73opw3SyhqFgbNqXWPR6Xn2OMv+Epy69N7NpksdS9GQSuo3riWOcoLGVSnRTm7uavNJlGswnxcoyyWsVbEDYVPUKATXf8cnuxew3n3wWYWyqXQneiudDR/Gy62bYnt43p1JHOvazDFQiQK/y1okLSUfRvSKXHOav3niSlFxM/a01EuJmP4MSV4e1+nxA==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=none (p=none dis=none) header.from=infradead.org; spf=none (client-ip=2001:8b0:10b:1236::1; helo=casper.infradead.org; envelope-from=willy@infradead.org; receiver=lists.ozlabs.org) smtp.mailfrom=infradead.org
Authentication-Results: lists.ozlabs.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: lists.ozlabs.org; spf=none (no SPF record) smtp.mailfrom=infradead.org (client-ip=2001:8b0:10b:1236::1; helo=casper.infradead.org; envelope-from=willy@infradead.org; receiver=lists.ozlabs.org)
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4WrB8G1LNPz2yl1
	for <linux-erofs@lists.ozlabs.org>; Sat, 24 Aug 2024 06:13:01 +1000 (AEST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=JsVlpGeKYbg4pM/Q7waOkd0NZPoyLhoXi4BOdIXNLpY=; b=c2cL3/nIR787l++dJM5LnaWXeW
	5dJMUyI901WBryZBvo6lRG2cxhxydHjFy3QTpizCQwEC/54YFz67jxnF/I5qszT9dqo0dsCCv4bhA
	dEMDmoaTGmh5pW4lvMOjCT91apPyQE4b24ZkMYKZ/FNipFwrhETEx8OgNkQFTi5jLsCgTVFQ3QDbd
	FM2OqcrPBsmNW/FsNsoGQn3qZNhtl0oRKzR3YOuY8XFJb2NKoje+ZfRlO+UrdlPKSiBRRywGoWFES
	NA0RleWtfD87vB2hp7AObXu6t74Rjpsc6agZ6/B/bIYAzbDXZ0pQnzK28mFgU+JbZqvvFGoQCjhP0
	r9Y6Rv8Q==;
Received: from willy by casper.infradead.org with local (Exim 4.97.1 #2 (Red Hat Linux))
	id 1shaeH-0000000C8f0-18u9;
	Fri, 23 Aug 2024 20:12:41 +0000
Date: Fri, 23 Aug 2024 21:12:41 +0100
From: Matthew Wilcox <willy@infradead.org>
To: David Howells <dhowells@redhat.com>
Subject: Re: [PATCH 1/9] mm: Fix missing folio invalidation calls during
 truncation
Message-ID: <ZsjtOVMD2dxRw68H@casper.infradead.org>
References: <20240823200819.532106-1-dhowells@redhat.com>
 <20240823200819.532106-2-dhowells@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240823200819.532106-2-dhowells@redhat.com>
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
Cc: Pankaj Raghav <p.raghav@samsung.com>, Paulo Alcantara <pc@manguebit.com>, linux-nfs@vger.kernel.org, linux-cifs@vger.kernel.org, v9fs@lists.linux.dev, Jeff Layton <jlayton@kernel.org>, linux-kernel@vger.kernel.org, Marc Dionne <marc.dionne@auristor.com>, Steve French <sfrench@samba.org>, linux-mm@kvack.org, linux-fsdevel@vger.kernel.org, netfs@lists.linux.dev, ceph-devel@vger.kernel.org, linux-erofs@lists.ozlabs.org, linux-afs@lists.infradead.org, Christian Brauner <christian@brauner.io>
Errors-To: linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org
Sender: "Linux-erofs" <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>

On Fri, Aug 23, 2024 at 09:08:09PM +0100, David Howells wrote:
> When AS_RELEASE_ALWAYS is set on a mapping, the ->release_folio() and
> ->invalidate_folio() calls should be invoked even if PG_private and
> PG_private_2 aren't set.  This is used by netfslib to keep track of the
> point above which reads can be skipped in favour of just zeroing pagecache
> locally.
> 
> There are a couple of places in truncation in which invalidation is only
> called when folio_has_private() is true.  Fix these to check
> folio_needs_release() instead.

Reviewed-by: Matthew Wilcox (Oracle) <willy@infradead.org>

I think we also want to change the folio_has_private() call in
mapping_evict_folio() to folio_test_private().  Same for the one
in migrate_vma_check_page().
