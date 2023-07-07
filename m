Return-Path: <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>
X-Original-To: lists+linux-erofs@lfdr.de
Delivered-To: lists+linux-erofs@lfdr.de
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	by mail.lfdr.de (Postfix) with ESMTPS id 736F474B676
	for <lists+linux-erofs@lfdr.de>; Fri,  7 Jul 2023 20:40:37 +0200 (CEST)
Authentication-Results: lists.ozlabs.org;
	dkim=fail reason="signature verification failed" (2048-bit key; secure) header.d=infradead.org header.i=@infradead.org header.a=rsa-sha256 header.s=casper.20170209 header.b=N9zitiD9;
	dkim-atps=neutral
Received: from boromir.ozlabs.org (localhost [IPv6:::1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4QyMfC2WvTz3c1K
	for <lists+linux-erofs@lfdr.de>; Sat,  8 Jul 2023 04:40:35 +1000 (AEST)
X-Original-To: linux-erofs@lists.ozlabs.org
Delivered-To: linux-erofs@lists.ozlabs.org
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; secure) header.d=infradead.org header.i=@infradead.org header.a=rsa-sha256 header.s=casper.20170209 header.b=N9zitiD9;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=none (no SPF record) smtp.mailfrom=infradead.org (client-ip=2001:8b0:10b:1236::1; helo=casper.infradead.org; envelope-from=willy@infradead.org; receiver=lists.ozlabs.org)
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4QyMf61wQBz2yyg
	for <linux-erofs@lists.ozlabs.org>; Sat,  8 Jul 2023 04:40:30 +1000 (AEST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=+PlsjkygUy/NaxzRVXPs1XdCvvqCmcP1CuzrF3FYi78=; b=N9zitiD9uhOT4xbkk5LyzIKHYX
	oMrbk08jA82Cz40fcP3zliWq/SUVTzVrGkNTbfI64T5Pq/aGZg83/qJ31NjmTNPAQbW9ihmPy+4Bz
	NDHN7KsjjXDoZXpNlaTDsw0Ng6OxNfS6riYufmFDduqttjy1zl4EUtSjenPwizBzCgiZ4scKn3AvY
	RDaCdpBbV5FKlXZRJICebIvzPv59Ij8Y3A1iB2yXsA/gwIxEiD136/HwOCEFl/Y0dlnzG4D6J47XA
	bVwW12r4UqbiAs7v/ppdzBM31FENe0bllXM8Oze0HAKyWzwax1MzW5QFef3oJozoBS6poHHz1PNcd
	f5aQg21g==;
Received: from willy by casper.infradead.org with local (Exim 4.94.2 #2 (Red Hat Linux))
	id 1qHqNQ-00CGGh-H0; Fri, 07 Jul 2023 18:40:20 +0000
Date: Fri, 7 Jul 2023 19:40:20 +0100
From: Matthew Wilcox <willy@infradead.org>
To: Hyeonggon Yoo <42.hyeyoo@gmail.com>
Subject: Re: [BUG mm-unstable] BUG: KASAN: use-after-free in
 shrink_folio_list+0x9f4/0x1ae0
Message-ID: <ZKhcFE1JpT6F2ez3@casper.infradead.org>
References: <20230628104852.3391651-1-dhowells@redhat.com>
 <20230628104852.3391651-3-dhowells@redhat.com>
 <ZKg/J3OG3kQ9ynSO@fedora>
 <CAB=+i9Qbi7+o90Cd_ecd1TeaAYnWPcO-gNp7kzc95Pxecy0XTw@mail.gmail.com>
 <CALF+zO=nGdoxcT-ya3aaUCBi-4iKPo3kZyzcWYCKMCf4n2wVbA@mail.gmail.com>
 <ZKhZHg6LSGnvryIe@fedora>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ZKhZHg6LSGnvryIe@fedora>
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
Cc: Dominique Martinet <asmadeus@codewreck.org>, David Howells <dhowells@redhat.com>, linux-mm@kvack.org, linux-afs@lists.infradead.org, Shyam Prasad N <nspmangalore@gmail.com>, linux-cifs@vger.kernel.org, Christoph Hellwig <hch@infradead.org>, Linus Torvalds <torvalds@linux-foundation.org>, linux-cachefs@redhat.com, v9fs-developer@lists.sourceforge.net, Ilya Dryomov <idryomov@gmail.com>, linux-ext4@vger.kernel.org, ceph-devel@vger.kernel.org, linux-nfs@vger.kernel.org, Rohith Surabattula <rohiths.msft@gmail.com>, Daire Byrne <daire.byrne@gmail.com>, David Wysochanski <dwysocha@redhat.com>, Jeff Layton <jlayton@kernel.org>, Steve French <sfrench@samba.org>, linux-fsdevel@vger.kernel.org, Andrew Morton <akpm@linux-foundation.org>, linux-erofs@lists.ozlabs.org
Errors-To: linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org
Sender: "Linux-erofs" <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>

On Sat, Jul 08, 2023 at 03:27:42AM +0900, Hyeonggon Yoo wrote:
> Hmm, was it UAF because it references wrong field ->mapping,
> instead of swapper address space?

Ooh, I know this one!

When a folio is in use as an anonymous page, ->mapping has the bottom
two bits set to 01b.  The rest of the pointer is actually a pointer
to an anon_vma.  It's entirely plausible that an anon page might have
had its anon_vma freed by the time the folio is on the inactive list,
and on its way to being recycled (eg it was unmapped).  I'm not
terribly familiar with the lifetime rules of the anon_vma, but I doubt
that a folio still being in RAM would pin it if it has been unmapped.
