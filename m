Return-Path: <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>
X-Original-To: lists+linux-erofs@lfdr.de
Delivered-To: lists+linux-erofs@lfdr.de
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	by mail.lfdr.de (Postfix) with ESMTPS id 4094E8369BD
	for <lists+linux-erofs@lfdr.de>; Mon, 22 Jan 2024 17:10:23 +0100 (CET)
Authentication-Results: lists.ozlabs.org;
	dkim=fail reason="signature verification failed" (2048-bit key; secure) header.d=infradead.org header.i=@infradead.org header.a=rsa-sha256 header.s=casper.20170209 header.b=bAHg37/D;
	dkim-atps=neutral
Received: from boromir.ozlabs.org (localhost [IPv6:::1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4TJZv1169gz3btn
	for <lists+linux-erofs@lfdr.de>; Tue, 23 Jan 2024 03:10:21 +1100 (AEDT)
X-Original-To: linux-erofs@lists.ozlabs.org
Delivered-To: linux-erofs@lists.ozlabs.org
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; secure) header.d=infradead.org header.i=@infradead.org header.a=rsa-sha256 header.s=casper.20170209 header.b=bAHg37/D;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=none (no SPF record) smtp.mailfrom=infradead.org (client-ip=2001:8b0:10b:1236::1; helo=casper.infradead.org; envelope-from=willy@infradead.org; receiver=lists.ozlabs.org)
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4TJZtv2rCQz2yst
	for <linux-erofs@lists.ozlabs.org>; Tue, 23 Jan 2024 03:10:15 +1100 (AEDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=NGNHyrHMg5T+Qh7WpIiamACVfA9Z4Rcr6JKQhuA9VEY=; b=bAHg37/DgOA2D7Nup2N9IoSCUf
	RYBdsFsEU0xkski0IK2yvU1A2OMrf/qhwna0hlIEwWl69adYPIHIu53ORHNeF2VBh5Hg6YqXlDLij
	QgT/abpxa9Ic03QJaHTpi1JbsPKKSfAD09GSoo5WzRD6w09XhsCKb33KdFEtAaiQroP+/MBSczuBJ
	PUqlXM14wca8GyUxdWtL6h281dGgW485gjFNKwYDyeOQmtaqKuC5cFXaOk2jp+fQu2XsCOZRo+WJs
	UhFEoChHuXUqVFkeJ67BcBHkeCQZslkJMYJKeIyQiOigfY3G+09Cq0PK3aHfIXU01a0Vs85+b2vdc
	ADEmH24g==;
Received: from willy by casper.infradead.org with local (Exim 4.97.1 #2 (Red Hat Linux))
	id 1rRws8-00000000Mhy-0VRc;
	Mon, 22 Jan 2024 16:10:04 +0000
Date: Mon, 22 Jan 2024 16:10:04 +0000
From: Matthew Wilcox <willy@infradead.org>
To: Jeff Layton <jlayton@kernel.org>
Subject: Re: [PATCH 01/10] netfs: Don't use certain internal folio_*()
 functions
Message-ID: <Za6TXMHlu1eATvLg@casper.infradead.org>
References: <20240122123845.3822570-1-dhowells@redhat.com>
 <20240122123845.3822570-2-dhowells@redhat.com>
 <c9091df8de30a2c79364698b72e67834d0ac87c7.camel@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <c9091df8de30a2c79364698b72e67834d0ac87c7.camel@kernel.org>
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
Cc: linux-cifs@vger.kernel.org, linux-nfs@vger.kernel.org, v9fs@lists.linux.dev, linux-kernel@vger.kernel.org, David Howells <dhowells@redhat.com>, linux-mm@kvack.org, linux-cachefs@redhat.com, linux-fsdevel@vger.kernel.org, netfs@lists.linux.dev, ceph-devel@vger.kernel.org, linux-erofs@lists.ozlabs.org, linux-afs@lists.infradead.org, Christian Brauner <christian@brauner.io>
Errors-To: linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org
Sender: "Linux-erofs" <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>

On Mon, Jan 22, 2024 at 10:38:58AM -0500, Jeff Layton wrote:
> On Mon, 2024-01-22 at 12:38 +0000, David Howells wrote:
> > Filesystems should not be using folio->index not folio_index(folio) and
> 
> I think you mean "should be" here.

Also these are not internal functions!  They're just functions that
filesystems shouldn't be using because filesystems are only exposed to
their own folios.  The erofs patch used the word "unnecessary", which I
like better (2b872b0f466d).

