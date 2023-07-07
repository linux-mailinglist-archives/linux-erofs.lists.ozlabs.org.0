Return-Path: <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>
X-Original-To: lists+linux-erofs@lfdr.de
Delivered-To: lists+linux-erofs@lfdr.de
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	by mail.lfdr.de (Postfix) with ESMTPS id D6E9B74B65C
	for <lists+linux-erofs@lfdr.de>; Fri,  7 Jul 2023 20:33:51 +0200 (CEST)
Authentication-Results: lists.ozlabs.org;
	dkim=fail reason="signature verification failed" (2048-bit key; secure) header.d=infradead.org header.i=@infradead.org header.a=rsa-sha256 header.s=casper.20170209 header.b=hSZgYMr3;
	dkim-atps=neutral
Received: from boromir.ozlabs.org (localhost [IPv6:::1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4QyMVN3Mygz3c1n
	for <lists+linux-erofs@lfdr.de>; Sat,  8 Jul 2023 04:33:48 +1000 (AEST)
X-Original-To: linux-erofs@lists.ozlabs.org
Delivered-To: linux-erofs@lists.ozlabs.org
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; secure) header.d=infradead.org header.i=@infradead.org header.a=rsa-sha256 header.s=casper.20170209 header.b=hSZgYMr3;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=none (no SPF record) smtp.mailfrom=infradead.org (client-ip=2001:8b0:10b:1236::1; helo=casper.infradead.org; envelope-from=willy@infradead.org; receiver=lists.ozlabs.org)
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4QyMVB64Jmz3bwR
	for <linux-erofs@lists.ozlabs.org>; Sat,  8 Jul 2023 04:33:36 +1000 (AEST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=EnPO7iYPqwnxTqwStZEfw5T07yWJQFIQid3g9b9XqJw=; b=hSZgYMr3UKHKYIY/VL4ipIs0vS
	61IBklPoCl4A108p1gsJG4vlTkCOJoen6cWDC43+6NTkr8YGNcmQcJs1O3p4OQtb1NXVR4LAls2Ng
	/p4TPNlO1XctYmGGMC+rkDVIiNqlriS/EFc8QPJBD4SL1Z2nsXdTYGKpye4UmT0WkXCONgtsxFIeV
	ZzegUWujwBx4r5ew4D2ZYlNPZ/o9jjAmGtG3ZcwrWDutua9YtWwESK4CTJ8bWQsA8XK+GJhZTgRVa
	CxK9+UPVL47g+ChIlgIr9kUvKuQXq0PFhjJDDTHlObVTxnMgijgaiIZJ6uLFDdPe7Ztq+0PZAnrFh
	+1A2zrEQ==;
Received: from willy by casper.infradead.org with local (Exim 4.94.2 #2 (Red Hat Linux))
	id 1qHqGZ-00CFvk-6N; Fri, 07 Jul 2023 18:33:15 +0000
Date: Fri, 7 Jul 2023 19:33:15 +0100
From: Matthew Wilcox <willy@infradead.org>
To: David Wysochanski <dwysocha@redhat.com>
Subject: Re: [BUG mm-unstable] BUG: KASAN: use-after-free in
 shrink_folio_list+0x9f4/0x1ae0
Message-ID: <ZKhaa7xn9aaZYicR@casper.infradead.org>
References: <20230628104852.3391651-1-dhowells@redhat.com>
 <20230628104852.3391651-3-dhowells@redhat.com>
 <ZKg/J3OG3kQ9ynSO@fedora>
 <CAB=+i9Qbi7+o90Cd_ecd1TeaAYnWPcO-gNp7kzc95Pxecy0XTw@mail.gmail.com>
 <CALF+zO=nGdoxcT-ya3aaUCBi-4iKPo3kZyzcWYCKMCf4n2wVbA@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CALF+zO=nGdoxcT-ya3aaUCBi-4iKPo3kZyzcWYCKMCf4n2wVbA@mail.gmail.com>
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
Cc: Dominique Martinet <asmadeus@codewreck.org>, David Howells <dhowells@redhat.com>, linux-mm@kvack.org, Hyeonggon Yoo <42.hyeyoo@gmail.com>, linux-afs@lists.infradead.org, Shyam Prasad N <nspmangalore@gmail.com>, linux-cifs@vger.kernel.org, Christoph Hellwig <hch@infradead.org>, Linus Torvalds <torvalds@linux-foundation.org>, linux-cachefs@redhat.com, v9fs-developer@lists.sourceforge.net, Ilya Dryomov <idryomov@gmail.com>, linux-ext4@vger.kernel.org, ceph-devel@vger.kernel.org, linux-nfs@vger.kernel.org, Rohith Surabattula <rohiths.msft@gmail.com>, Daire Byrne <daire.byrne@gmail.com>, Jeff Layton <jlayton@kernel.org>, Steve French <sfrench@samba.org>, linux-fsdevel@vger.kernel.org, Andrew Morton <akpm@linux-foundation.org>, linux-erofs@lists.ozlabs.org
Errors-To: linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org
Sender: "Linux-erofs" <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>

On Fri, Jul 07, 2023 at 02:12:06PM -0400, David Wysochanski wrote:
> I think myself / Daire Byrne may have already tracked this down and I
> found a 1-liner that fixed a similar crash in his environment.
> 
> Can you try this patch on top and let me know if it still crashes?
> https://github.com/DaveWysochanskiRH/kernel/commit/902c990e311120179fa5de99d68364b2947b79ec

Said one-liner:
-	struct address_space *mapping = folio->mapping;
+	struct address_space *mapping = folio_mapping(folio);

This will definitely fix the problem.  shrink_folio_list() sees
anonymous folios as well as file folios.

I wonder if we want to go a step further and introduce ...

+static inline bool __folio_needs_release(struct address_space *mapping,
+               struct folio *folio)
+{
+       return folio_has_private(folio) ||
+               (mapping && mapping_release_always(mapping));
+}
+
 /*
  * Return true if a folio needs ->release_folio() calling upon it.
  */
 static inline bool folio_needs_release(struct folio *folio)
 {
-       struct address_space *mapping = folio->mapping;
-
-       return folio_has_private(folio) ||
-               (mapping && mapping_release_always(mapping));
+       return __folio_needs_release(folio_mapping(folio), folio);
 }

since two of the three callers already have done the necessary dance to
get the mapping (and they're the two which happen regularly; the third
is an unusual situation).

