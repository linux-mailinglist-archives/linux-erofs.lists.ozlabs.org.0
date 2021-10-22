Return-Path: <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>
X-Original-To: lists+linux-erofs@lfdr.de
Delivered-To: lists+linux-erofs@lfdr.de
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	by mail.lfdr.de (Postfix) with ESMTPS id 041E0436EC9
	for <lists+linux-erofs@lfdr.de>; Fri, 22 Oct 2021 02:23:49 +0200 (CEST)
Received: from boromir.ozlabs.org (localhost [IPv6:::1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4Hb4pB2sR9z3c5m
	for <lists+linux-erofs@lfdr.de>; Fri, 22 Oct 2021 11:23:46 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org;
	dkim=fail reason="signature verification failed" (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20201202 header.b=jKvliVvn;
	dkim-atps=neutral
X-Original-To: linux-erofs@lists.ozlabs.org
Delivered-To: linux-erofs@lists.ozlabs.org
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized)
 smtp.mailfrom=kernel.org (client-ip=198.145.29.99; helo=mail.kernel.org;
 envelope-from=xiang@kernel.org; receiver=<UNKNOWN>)
Authentication-Results: lists.ozlabs.org; dkim=pass (2048-bit key;
 unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256
 header.s=k20201202 header.b=jKvliVvn; 
 dkim-atps=neutral
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 4Hb4p66k7tz2yYl
 for <linux-erofs@lists.ozlabs.org>; Fri, 22 Oct 2021 11:23:42 +1100 (AEDT)
Received: by mail.kernel.org (Postfix) with ESMTPSA id DD50E60EBB;
 Fri, 22 Oct 2021 00:22:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=k20201202; t=1634862220;
 bh=OSajkPGWXV3rm9LiIZWq+VM94+j5+N3IhWdn05dUZZM=;
 h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
 b=jKvliVvnMbqrUrSce1ypIw/s3fWULNKwDK6NLsRszlOmtuzS1avPw5uNyjGqIg09v
 jphb1wQbvWSeq7BRWmHCof3Xqr1k5YkXGzcseIKWql9eZ/fh+Zgf525iVlWnX0UDib
 s1A0Yq2bIWuWC+CY+d30L74kyPqQDqEXJYjKpifRLKDG+NwXmBOUIZP+Ac2wU+u0Uw
 F284NyI3+HOlZpjPz+YJHcUvoGO6tg1y9Fg6ixyLxGrW6lvB6LGRBM8DOfntytk9Kl
 Km3KVvqGjBYha4rkQ+YOtJmMSE+cUs0Xi0VIru0sTS1IF2s4a+JTDPCDdE0cpNlxIb
 HdZ210xX8zUAQ==
Date: Fri, 22 Oct 2021 08:22:14 +0800
From: Gao Xiang <xiang@kernel.org>
To: Matthew Wilcox <willy@infradead.org>
Subject: Re: Readahead for compressed data
Message-ID: <20211022002135.GA19226@hsiangkao-HP-ZHAN-66-Pro-G1>
Mail-Followup-To: Matthew Wilcox <willy@infradead.org>,
 linux-fsdevel@vger.kernel.org, Jan Kara <jack@suse.cz>,
 Phillip Lougher <phillip@squashfs.org.uk>,
 linux-erofs@lists.ozlabs.org, linux-btrfs@vger.kernel.org,
 linux-ntfs-dev@lists.sourceforge.net, ntfs3@lists.linux.dev,
 linux-bcache@vger.kernel.org, David Howells <dhowells@redhat.com>,
 Hsin-Yi Wang <hsinyi@chromium.org>
References: <YXHK5HrQpJu9oy8w@casper.infradead.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <YXHK5HrQpJu9oy8w@casper.infradead.org>
User-Agent: Mutt/1.10.1 (2018-07-13)
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
Cc: Jan Kara <jack@suse.cz>, linux-ntfs-dev@lists.sourceforge.net,
 David Howells <dhowells@redhat.com>, linux-bcache@vger.kernel.org,
 Hsin-Yi Wang <hsinyi@chromium.org>, linux-fsdevel@vger.kernel.org,
 Phillip Lougher <phillip@squashfs.org.uk>, ntfs3@lists.linux.dev,
 linux-erofs@lists.ozlabs.org, linux-btrfs@vger.kernel.org
Errors-To: linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org
Sender: "Linux-erofs"
 <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>

On Thu, Oct 21, 2021 at 09:17:40PM +0100, Matthew Wilcox wrote:
> As far as I can tell, the following filesystems support compressed data:
> 
> bcachefs, btrfs, erofs, ntfs, squashfs, zisofs
> 
> I'd like to make it easier and more efficient for filesystems to
> implement compressed data.  There are a lot of approaches in use today,
> but none of them seem quite right to me.  I'm going to lay out a few
> design considerations next and then propose a solution.  Feel free to
> tell me I've got the constraints wrong, or suggest alternative solutions.
> 
> When we call ->readahead from the VFS, the VFS has decided which pages
> are going to be the most useful to bring in, but it doesn't know how
> pages are bundled together into blocks.  As I've learned from talking to
> Gao Xiang, sometimes the filesystem doesn't know either, so this isn't
> something we can teach the VFS.
> 
> We (David) added readahead_expand() recently to let the filesystem
> opportunistically add pages to the page cache "around" the area requested
> by the VFS.  That reduces the number of times the filesystem has to
> decompress the same block.  But it can fail (due to memory allocation
> failures or pages already being present in the cache).  So filesystems
> still have to implement some kind of fallback.
> 
> For many (all?) compression algorithms (all?) the data must be mapped at
> all times.  Calling kmap() and kunmap() would be an intolerable overhead.
> At the same time, we cannot write to a page in the page cache which is
> marked Uptodate.  It might be mapped into userspace, or a read() be in
> progress against it.  For writable filesystems, it might even be dirty!
> As far as I know, no compression algorithm supports "holes", implying
> that we must allocate memory which is then discarded.
> 
> To me, this calls for a vmap() based approach.  So I'm thinking
> something like ...
> 
> void *readahead_get_block(struct readahead_control *ractl, loff_t start,
> 			size_t len);
> void readahead_put_block(struct readahead_control *ractl, void *addr,
> 			bool success);
> 
> Once you've figured out which bytes this encrypted block expands to, you
> call readahead_get_block(), specifying the offset in the file and length
> and get back a pointer.  When you're done decompressing that block of
> the file, you get rid of it again.
> 
> It's the job of readahead_get_block() to allocate additional pages
> into the page cache or temporary pages.  readahead_put_block() will
> mark page cache pages as Uptodate if 'success' is true, and unlock
> them.  It'll free any temporary pages.
> 
> Thoughts?  Anyone want to be the guinea pig?  ;-)

Copied from IRC for reference as well..

As for vmap() strategy, No need to allocate some temporary pages in advance
before compressed I/O is done and async work is triggered, since I/Os /
works could cause noticable latencies. Logically, only inplace or cached
I/O strategy should be decided before I/O and compressed pages need to be
prepared. The benefits of fixed-sized output compression aside from the
relative higher compression ratios is that each compressed pcluster can
be completely decompressed independently, you can select inplace or cache
I/O for each pclusters. And when you decide inplace I/O for some pcluster,
no extra incompressible data is readed from disk or cached uselessly.

As I said, even overall read request (with many pclusters) is 1MiB or
2MiB or some else, also only need allocate 16 pages (64KiB) at most for lz4
for each read request (used for lz4 sliding window), no need such many
extra temporary pages.

Allocating too many pages in advance before I/O IMO is just increasing the
overall memory overhead. Low-ended devices cannot handle I/O quickly but
has limited memory. Temporary pages are only needed before decompression,
not exactly before I/O.

Thanks,
Gao Xiang
