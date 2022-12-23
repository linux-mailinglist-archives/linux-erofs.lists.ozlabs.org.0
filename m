Return-Path: <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>
X-Original-To: lists+linux-erofs@lfdr.de
Delivered-To: lists+linux-erofs@lfdr.de
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2404:9400:2:0:216:3eff:fee1:b9f1])
	by mail.lfdr.de (Postfix) with ESMTPS id CF377655216
	for <lists+linux-erofs@lfdr.de>; Fri, 23 Dec 2022 16:32:12 +0100 (CET)
Received: from boromir.ozlabs.org (localhost [IPv6:::1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4NdrlG4QpMz3bZn
	for <lists+linux-erofs@lfdr.de>; Sat, 24 Dec 2022 02:32:10 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org;
	dkim=fail reason="signature verification failed" (2048-bit key; secure) header.d=infradead.org header.i=@infradead.org header.a=rsa-sha256 header.s=bombadil.20210309 header.b=RkLgtlP2;
	dkim-atps=neutral
X-Original-To: linux-erofs@lists.ozlabs.org
Delivered-To: linux-erofs@lists.ozlabs.org
Authentication-Results: lists.ozlabs.org; spf=none (no SPF record) smtp.mailfrom=bombadil.srs.infradead.org (client-ip=2607:7c80:54:3::133; helo=bombadil.infradead.org; envelope-from=batv+a36cbb7ae26730e9169d+7061+infradead.org+hch@bombadil.srs.infradead.org; receiver=<UNKNOWN>)
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; secure) header.d=infradead.org header.i=@infradead.org header.a=rsa-sha256 header.s=bombadil.20210309 header.b=RkLgtlP2;
	dkim-atps=neutral
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:3::133])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4Ndrl54f4wz3bVZ
	for <linux-erofs@lists.ozlabs.org>; Sat, 24 Dec 2022 02:31:57 +1100 (AEDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=bombadil.20210309; h=In-Reply-To:Content-Type:MIME-Version
	:References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=YI+GETaE07zfIF6gTr93yZkoaqmkXGRyTSkPLa22IzA=; b=RkLgtlP2zs+0grtCP2XKKuFJes
	6FHjSru80hSAyAYCWjR4giWwoV3DaU3XpMF7/3HZDUa+E/kozrd+x6VmAXg4TRMKJHW9b8wzSyfeD
	VokI0tlui9x8PQhh88Z82EqORo/ZAaFcoi8Gbx6S9ZrNjmqThuHWTTIRq3+YEjgq3IX5yINDVvjt+
	e0+/qxQDLcU/llLFjIUrhW0P/9m/nHcrhbkOptvrE3r4S9ZgmuFyMLR/rPv50gmRKgcXjautu9IC5
	U8MyiLTneJokeOtEKvUEFCZUMIUmLTbzJVU1SPbmDcoK0FIf2BAPGpTW1uoenfctyu+YHc+9jx57b
	guycEkxA==;
Received: from hch by bombadil.infradead.org with local (Exim 4.94.2 #2 (Red Hat Linux))
	id 1p8k0x-009SnO-0o; Fri, 23 Dec 2022 15:31:15 +0000
Date: Fri, 23 Dec 2022 07:31:14 -0800
From: Christoph Hellwig <hch@infradead.org>
To: David Howells <dhowells@redhat.com>
Subject: Re: [PATCH v5 3/3] mm: Make filemap_release_folio() better inform
 shrink_folio_list()
Message-ID: <Y6XJwvjKyTgRIiI3@infradead.org>
References: <167172131368.2334525.8569808925687731937.stgit@warthog.procyon.org.uk>
 <167172134962.2334525.570622889806603086.stgit@warthog.procyon.org.uk>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <167172134962.2334525.570622889806603086.stgit@warthog.procyon.org.uk>
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html
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
Cc: Shyam Prasad N <nspmangalore@gmail.com>, linux-cifs@vger.kernel.org, linux-nfs@vger.kernel.org, Rohith Surabattula <rohiths.msft@gmail.com>, Jeff Layton <jlayton@kernel.org>, Dave Wysochanski <dwysocha@redhat.com>, ceph-devel@vger.kernel.org, linux-kernel@vger.kernel.org, Matthew Wilcox <willy@infradead.org>, linux-afs@lists.infradead.org, Steve French <sfrench@samba.org>, linux-mm@kvack.org, linux-erofs@lists.ozlabs.org, linux-cachefs@redhat.com, linux-ext4@lists.ozlabs.org, linux-fsdevel@vger.kernel.org, v9fs-developer@lists.sourceforge.net, Ilya Dryomov <idryomov@gmail.com>, Linus Torvalds <torvalds@linux-foundation.org>, Dominique Martinet <asmadeus@codewreck.org>
Errors-To: linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org
Sender: "Linux-erofs" <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>

On Thu, Dec 22, 2022 at 03:02:29PM +0000, David Howells wrote:
> Make filemap_release_folio() return one of three values:
> 
>  (0) FILEMAP_CANT_RELEASE_FOLIO
> 
>      Couldn't release the folio's private data, so the folio can't itself
>      be released.
> 
>  (1) FILEMAP_RELEASED_FOLIO
> 
>      The private data on the folio was released and the folio can be
>      released.
> 
>  (2) FILEMAP_FOLIO_HAD_NO_PRIVATE

These names read really odd, due to the different placementments
of FOLIO, the present vs past tense and the fact that 2 also released
the folio, and the reliance of callers that one value of an enum
must be 0, while no unprecedented, is a bit ugly.

But do we even need them?  What abut just open coding
filemap_release_folio (which is a mostly trivial function) in
shrink_folio_list, which is the only place that cares?

	if (folio_has_private(folio) && folio_needs_release(folio)) {
		if (folio_test_writeback(folio))
			goto activate_locked;

		if (mapping && mapping->a_ops->release_folio) {
			if (!mapping->a_ops->release_folio(folio, gfp))
				goto activate_locked;
		} else {
			if (!try_to_free_buffers(folio))
				goto activate_locked;
		}

		if (!mapping && folio_ref_count(folio) == 1) {
			...

alternatively just keep using filemap_release_folio and just add the
folio_needs_release in the first branch.  That duplicates the test,
but makes the change a one-liner.
