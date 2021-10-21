Return-Path: <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>
X-Original-To: lists+linux-erofs@lfdr.de
Delivered-To: lists+linux-erofs@lfdr.de
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	by mail.lfdr.de (Postfix) with ESMTPS id 1E9CF436BED
	for <lists+linux-erofs@lfdr.de>; Thu, 21 Oct 2021 22:19:43 +0200 (CEST)
Received: from boromir.ozlabs.org (localhost [IPv6:::1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4HZzNX1PC6z3c54
	for <lists+linux-erofs@lfdr.de>; Fri, 22 Oct 2021 07:19:40 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org;
	dkim=fail reason="signature verification failed" (2048-bit key; secure) header.d=infradead.org header.i=@infradead.org header.a=rsa-sha256 header.s=casper.20170209 header.b=imSnGuN5;
	dkim-atps=neutral
X-Original-To: linux-erofs@lists.ozlabs.org
Delivered-To: linux-erofs@lists.ozlabs.org
Authentication-Results: lists.ozlabs.org;
 spf=none (no SPF record) smtp.mailfrom=infradead.org
 (client-ip=2001:8b0:10b:1236::1; helo=casper.infradead.org;
 envelope-from=willy@infradead.org; receiver=<UNKNOWN>)
Authentication-Results: lists.ozlabs.org; dkim=pass (2048-bit key;
 secure) header.d=infradead.org header.i=@infradead.org header.a=rsa-sha256
 header.s=casper.20170209 header.b=imSnGuN5; 
 dkim-atps=neutral
Received: from casper.infradead.org (casper.infradead.org
 [IPv6:2001:8b0:10b:1236::1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 4HZzNJ29g1z2yNq
 for <linux-erofs@lists.ozlabs.org>; Fri, 22 Oct 2021 07:19:24 +1100 (AEDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=infradead.org; s=casper.20170209; h=Content-Type:MIME-Version:Message-ID:
 Subject:Cc:To:From:Date:Sender:Reply-To:Content-Transfer-Encoding:Content-ID:
 Content-Description:In-Reply-To:References;
 bh=y8JHDYkPJzIgkqIK04aJFKPmGCunlhTpxDzk6/5wJ6k=; b=imSnGuN5gACmlntKD2y7aDIcAu
 ew/YvoiSKRxLyXfYxlwO66ByAfMXP5I03MyNPErjXLufNiQWS2TWYfqHl6yNpVwiL4QbbK+GUJUsF
 q4BV+dXecs9YueWam7eUoXdjuNuoZ/jCa9k0JqlQsKBntxmFQEoxSaJX9d+862mkfJR4FFwkrW18+
 JtuN6VSCxEhva705ABKaJ5Hint+7qKU/AloddUcxKh8lxB7CciPkREirPiu91kHNeEtOxnEF7i/fx
 OLRULCIezXEw2SATL2d9qyvEKCpxd19nVczRYAdrbp/hWcMK+x4PRB7W+F+nuIBDKgo2LiEq0QM2q
 1RbJ+WSA==;
Received: from willy by casper.infradead.org with local (Exim 4.94.2 #2 (Red
 Hat Linux)) id 1mdeVQ-00DW0g-3x; Thu, 21 Oct 2021 20:17:57 +0000
Date: Thu, 21 Oct 2021 21:17:40 +0100
From: Matthew Wilcox <willy@infradead.org>
To: linux-fsdevel@vger.kernel.org, Jan Kara <jack@suse.cz>,
 Phillip Lougher <phillip@squashfs.org.uk>,
 linux-erofs@lists.ozlabs.org, linux-btrfs@vger.kernel.org,
 linux-ntfs-dev@lists.sourceforge.net, ntfs3@lists.linux.dev,
 linux-bcache@vger.kernel.org
Subject: Readahead for compressed data
Message-ID: <YXHK5HrQpJu9oy8w@casper.infradead.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
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
Cc: David Howells <dhowells@redhat.com>, Hsin-Yi Wang <hsinyi@chromium.org>
Errors-To: linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org
Sender: "Linux-erofs"
 <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>

As far as I can tell, the following filesystems support compressed data:

bcachefs, btrfs, erofs, ntfs, squashfs, zisofs

I'd like to make it easier and more efficient for filesystems to
implement compressed data.  There are a lot of approaches in use today,
but none of them seem quite right to me.  I'm going to lay out a few
design considerations next and then propose a solution.  Feel free to
tell me I've got the constraints wrong, or suggest alternative solutions.

When we call ->readahead from the VFS, the VFS has decided which pages
are going to be the most useful to bring in, but it doesn't know how
pages are bundled together into blocks.  As I've learned from talking to
Gao Xiang, sometimes the filesystem doesn't know either, so this isn't
something we can teach the VFS.

We (David) added readahead_expand() recently to let the filesystem
opportunistically add pages to the page cache "around" the area requested
by the VFS.  That reduces the number of times the filesystem has to
decompress the same block.  But it can fail (due to memory allocation
failures or pages already being present in the cache).  So filesystems
still have to implement some kind of fallback.

For many (all?) compression algorithms (all?) the data must be mapped at
all times.  Calling kmap() and kunmap() would be an intolerable overhead.
At the same time, we cannot write to a page in the page cache which is
marked Uptodate.  It might be mapped into userspace, or a read() be in
progress against it.  For writable filesystems, it might even be dirty!
As far as I know, no compression algorithm supports "holes", implying
that we must allocate memory which is then discarded.

To me, this calls for a vmap() based approach.  So I'm thinking
something like ...

void *readahead_get_block(struct readahead_control *ractl, loff_t start,
			size_t len);
void readahead_put_block(struct readahead_control *ractl, void *addr,
			bool success);

Once you've figured out which bytes this encrypted block expands to, you
call readahead_get_block(), specifying the offset in the file and length
and get back a pointer.  When you're done decompressing that block of
the file, you get rid of it again.

It's the job of readahead_get_block() to allocate additional pages
into the page cache or temporary pages.  readahead_put_block() will
mark page cache pages as Uptodate if 'success' is true, and unlock
them.  It'll free any temporary pages.

Thoughts?  Anyone want to be the guinea pig?  ;-)
