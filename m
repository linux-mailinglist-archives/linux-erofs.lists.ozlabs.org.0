Return-Path: <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>
X-Original-To: lists+linux-erofs@lfdr.de
Delivered-To: lists+linux-erofs@lfdr.de
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2404:9400:2:0:216:3eff:fee1:b9f1])
	by mail.lfdr.de (Postfix) with ESMTPS id 4FC3D3D2892
	for <lists+linux-erofs@lfdr.de>; Thu, 22 Jul 2021 18:58:04 +0200 (CEST)
Received: from boromir.ozlabs.org (localhost [IPv6:::1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4GVzCt1FWDz3029
	for <lists+linux-erofs@lfdr.de>; Fri, 23 Jul 2021 02:58:02 +1000 (AEST)
Authentication-Results: lists.ozlabs.org;
	dkim=fail reason="signature verification failed" (2048-bit key; secure) header.d=infradead.org header.i=@infradead.org header.a=rsa-sha256 header.s=casper.20170209 header.b=F5eMUIgN;
	dkim-atps=neutral
X-Original-To: linux-erofs@lists.ozlabs.org
Delivered-To: linux-erofs@lists.ozlabs.org
Authentication-Results: lists.ozlabs.org;
 spf=none (no SPF record) smtp.mailfrom=infradead.org
 (client-ip=2001:8b0:10b:1236::1; helo=casper.infradead.org;
 envelope-from=willy@infradead.org; receiver=<UNKNOWN>)
Authentication-Results: lists.ozlabs.org; dkim=pass (2048-bit key;
 secure) header.d=infradead.org header.i=@infradead.org header.a=rsa-sha256
 header.s=casper.20170209 header.b=F5eMUIgN; 
 dkim-atps=neutral
Received: from casper.infradead.org (casper.infradead.org
 [IPv6:2001:8b0:10b:1236::1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 4GVzCk44Qgz2yNw
 for <linux-erofs@lists.ozlabs.org>; Fri, 23 Jul 2021 02:57:49 +1000 (AEST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
 References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
 Content-Transfer-Encoding:Content-ID:Content-Description;
 bh=fY1GU33NdlDCFwWGiRlEzVzzUv/E61mi0egIUEebmpo=; b=F5eMUIgNSgTJAoMmkWgV7WEaGk
 SyNUL6h+5z5WIgAKB5tCR1lkqGE3SxjCuK5WMPc8OMeVu+eRh6kAWuAa9nw9xl+4hE1AG6ioLCA3E
 nsKtOKkZ0LrfrTD3baDwTn9nGp0WrYzQ6fmaUjEBIX7+Y63IU2TbEdFB6iT6hXmBUq+1s0Fw9ig5B
 nGN36cEvC0sYRIGb9q0I80Y3l2Fx0ZCabOKq4WDAzLvquEO8JwXD4UmOQsp1f8aMGNWyeGtF/g+iD
 03p2q4UXX9Pr84W+9WN75zicYa5nvTQEPOxczUrjSBFOTt1MixsMTewOzxUvEDbPmCMIPW8zWvoqP
 DNYGIM0g==;
Received: from willy by casper.infradead.org with local (Exim 4.94.2 #2 (Red
 Hat Linux)) id 1m6c0Q-00AUeF-Ty; Thu, 22 Jul 2021 16:57:16 +0000
Date: Thu, 22 Jul 2021 17:57:06 +0100
From: Matthew Wilcox <willy@infradead.org>
To: Christoph Hellwig <hch@lst.de>
Subject: Re: [PATCH v6] iomap: support tail packing inline read
Message-ID: <YPmjYieZ57WVsQx9@casper.infradead.org>
References: <20210722031729.51628-1-hsiangkao@linux.alibaba.com>
 <20210722053947.GA28594@lst.de> <20210722165109.GD8639@magnolia>
 <20210722165342.GA11435@lst.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210722165342.GA11435@lst.de>
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
Cc: "Darrick J. Wong" <djwong@kernel.org>,
 Andreas Gruenbacher <andreas.gruenbacher@gmail.com>,
 LKML <linux-kernel@vger.kernel.org>, linux-fsdevel@vger.kernel.org,
 linux-erofs@lists.ozlabs.org
Errors-To: linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org
Sender: "Linux-erofs"
 <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>

On Thu, Jul 22, 2021 at 06:53:42PM +0200, Christoph Hellwig wrote:
> On Thu, Jul 22, 2021 at 09:51:09AM -0700, Darrick J. Wong wrote:
> > The commit message is a little misleading -- this adds support for
> > inline data pages at nonzero (but page-aligned) file offsets, not file
> > offsets into the page itself.  I suggest:
> 
> It actually adds both.  pos is the offset into the file.

If you want to add support for both, then you need to call
iomap_set_range_uptodate() instead of SetPageUptodate().  Otherwise,
you can set the page uptodate before submitting the bio for the first
half of the page.
