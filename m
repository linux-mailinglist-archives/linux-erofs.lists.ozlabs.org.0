Return-Path: <linux-erofs+bounces-625-lists+linux-erofs=lfdr.de@lists.ozlabs.org>
X-Original-To: lists+linux-erofs@lfdr.de
Delivered-To: lists+linux-erofs@lfdr.de
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2404:9400:2:0:216:3eff:fee1:b9f1])
	by mail.lfdr.de (Postfix) with ESMTPS id 19AA2B067DC
	for <lists+linux-erofs@lfdr.de>; Tue, 15 Jul 2025 22:41:16 +0200 (CEST)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4bhWLK5BVpz2xd3;
	Wed, 16 Jul 2025 06:41:13 +1000 (AEST)
X-Original-To: linux-erofs@lists.ozlabs.org
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip="2001:8b0:10b:1236::1"
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1752612073;
	cv=none; b=KilNHDxRUd0hFxJQjFhtzJIPxwrRnxwi6ikWY6ragVG/9ggYc4HCqtwN8M4zr5tCTWZWRKEK+Tq9z6M9VLrfXm+9uOpItLVcL62RCveMFq9Pa5/3molIC/KJUUlALQWoNCm5ZRlq+qUgR6CsfQ8MjepzHkhH6k4++olojwAE/uSISrt06vr5Ir8+IuJbeM74a/To9fcLdu8BQkfsqCsuN3c103uJNKYeZPUIpffvCRjLOA7xYTsAOV5eU45jvdPZom6kqCZEuV9B5txmxFKPIAUOZ2+Gg6f9co7SBuugyz7Gz0Lqg9VLTFgrAaNyCnd8MvE0refyoooqg/EarL6Thw==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1752612073; c=relaxed/relaxed;
	bh=SYy7+JhvSNYS+NgaNxt53BfDsD6DTcsBMQgVgtXAnMw=;
	h=Date:From:To:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition; b=h/D0WYQ8QzDA2qAWobmgM+uKAYwTt2ibkTmlPfijAafRenE3JUlrY4HqmPm+Lnsh1HTxhdliA7RINkPhq0EOk03TL07nfad9otY9A4dnFmJcBMQcle6rvK6aJMb7b+FuMoGlAVd6fYAdHYmPJtk0bFtP9BJaWapREj+wZ93554MaGij+6CGom7QUUkfQCpF96Ic24qJHuT9Yee9MF2mlY0UJfLDrcGnSpoXx0C1v4kHobxnPuxbV3dYF8XsExcnDb4iSTC8Sl5mqCOFuHqiQrjDwhQSTSBEPyt/6FBPhe/m+B8F60zc/YJgdZ6CnpxxKVyaG8LY58bdcqcbkYRs+KA==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=none (p=none dis=none) header.from=infradead.org; spf=none (client-ip=2001:8b0:10b:1236::1; helo=casper.infradead.org; envelope-from=willy@infradead.org; receiver=lists.ozlabs.org) smtp.mailfrom=infradead.org
Authentication-Results: lists.ozlabs.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: lists.ozlabs.org; spf=none (no SPF record) smtp.mailfrom=infradead.org (client-ip=2001:8b0:10b:1236::1; helo=casper.infradead.org; envelope-from=willy@infradead.org; receiver=lists.ozlabs.org)
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4bhWL61vlNz2xQ6
	for <linux-erofs@lists.ozlabs.org>; Wed, 16 Jul 2025 06:41:01 +1000 (AEST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=casper.20170209; h=Content-Type:MIME-Version:Message-ID:
	Subject:To:From:Date:Sender:Reply-To:Cc:Content-Transfer-Encoding:Content-ID:
	Content-Description:In-Reply-To:References;
	bh=SYy7+JhvSNYS+NgaNxt53BfDsD6DTcsBMQgVgtXAnMw=; b=rkI+4BNOMXmHOlYzssTyZGMoyL
	aI4+mtJLryNxKiCc4W+ld08C0+bphxREcY/dxe5wfC8vq1Jm/gkORw00fkrVN1wN9ZebXvUZdsASi
	zm/TWcijb+f/QGxCr7JAj8hN/eD1ZF8y8US+BmVKcsXKcioWHpvbobjpz6cJAgAK7CUS1qNhk4uFL
	tjWrM8+Ywd756Z75jpjjjhA98m3aZFKJrVLHToG44C24SvMEzbGkUiMb11sHEeqIF4vneMyjl5vwU
	TzrTkImLRsy3P+dQk+EBbDZjxoBwbifTvRQpCJk58iDMe6EFuJx0uQ/0H2pK8Hk2W4Z21ZbGxiHf4
	6wuu3xaA==;
Received: from willy by casper.infradead.org with local (Exim 4.98.2 #2 (Red Hat Linux))
	id 1ubmSA-0000000DkmQ-22ck;
	Tue, 15 Jul 2025 20:40:42 +0000
Date: Tue, 15 Jul 2025 21:40:42 +0100
From: Matthew Wilcox <willy@infradead.org>
To: Chris Mason <clm@fb.com>, Josef Bacik <josef@toxicpanda.com>,
	David Sterba <dsterba@suse.com>, linux-btrfs@vger.kernel.org,
	Nicolas Pitre <nico@fluxnic.net>, Gao Xiang <xiang@kernel.org>,
	Chao Yu <chao@kernel.org>, linux-erofs@lists.ozlabs.org,
	Jaegeuk Kim <jaegeuk@kernel.org>,
	linux-f2fs-devel@lists.sourceforge.net, Jan Kara <jack@suse.cz>,
	linux-fsdevel@vger.kernel.org,
	David Woodhouse <dwmw2@infradead.org>,
	Richard Weinberger <richard@nod.at>, linux-mtd@lists.infradead.org,
	David Howells <dhowells@redhat.com>, netfs@lists.linux.dev,
	Paulo Alcantara <pc@manguebit.org>,
	Konstantin Komarov <almaz.alexandrovich@paragon-software.com>,
	ntfs3@lists.linux.dev, Steve French <sfrench@samba.org>,
	linux-cifs@vger.kernel.org,
	Phillip Lougher <phillip@squashfs.org.uk>
Subject: Compressed files & the page cache
Message-ID: <aHa8ylTh0DGEQklt@casper.infradead.org>
X-Mailing-List: linux-erofs@lists.ozlabs.org
List-Id: <linux-erofs.lists.ozlabs.org>
List-Help: <mailto:linux-erofs+help@lists.ozlabs.org>
List-Owner: <mailto:linux-erofs+owner@lists.ozlabs.org>
List-Post: <mailto:linux-erofs@lists.ozlabs.org>
List-Subscribe: <mailto:linux-erofs+subscribe@lists.ozlabs.org>,
  <mailto:linux-erofs+subscribe-digest@lists.ozlabs.org>,
  <mailto:linux-erofs+subscribe-nomail@lists.ozlabs.org>
List-Unsubscribe: <mailto:linux-erofs+unsubscribe@lists.ozlabs.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-Spam-Status: No, score=-2.5 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,SPF_NONE
	autolearn=disabled version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-25) on lists.ozlabs.org

I've started looking at how the page cache can help filesystems handle
compressed data better.  Feedback would be appreciated!  I'll probably
say a few things which are obvious to anyone who knows how compressed
files work, but I'm trying to be explicit about my assumptions.

First, I believe that all filesystems work by compressing fixed-size
plaintext into variable-sized compressed blocks.  This would be a good
point to stop reading and tell me about counterexamples.

From what I've been reading in all your filesystems is that you want to
allocate extra pages in the page cache in order to store the excess data
retrieved along with the page that you're actually trying to read.  That's
because compressing in larger chunks leads to better compression.

There's some discrepancy between filesystems whether you need scratch
space for decompression.  Some filesystems read the compressed data into
the pagecache and decompress in-place, while other filesystems read the
compressed data into scratch pages and decompress into the page cache.

There also seems to be some discrepancy between filesystems whether the
decompression involves vmap() of all the memory allocated or whether the
decompression routines can handle doing kmap_local() on individual pages.

So, my proposal is that filesystems tell the page cache that their minimum
folio size is the compression block size.  That seems to be around 64k,
so not an unreasonable minimum allocation size.  That removes all the
extra code in filesystems to allocate extra memory in the page cache.
It means we don't attempt to track dirtiness at a sub-folio granularity
(there's no point, we have to write back the entire compressed bock
at once).  We also get a single virtually contiguous block ... if you're
willing to ditch HIGHMEM support.  Or there's a proposal to introduce a
vmap_file() which would give us a virtually contiguous chunk of memory
(and could be trivially turned into a noop for the case of trying to
vmap a single large folio).


