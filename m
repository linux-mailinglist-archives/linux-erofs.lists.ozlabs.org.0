Return-Path: <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>
X-Original-To: lists+linux-erofs@lfdr.de
Delivered-To: lists+linux-erofs@lfdr.de
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2404:9400:2:0:216:3eff:fee1:b9f1])
	by mail.lfdr.de (Postfix) with ESMTPS id D9EF84374E8
	for <lists+linux-erofs@lfdr.de>; Fri, 22 Oct 2021 11:40:18 +0200 (CEST)
Received: from boromir.ozlabs.org (localhost [IPv6:::1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4HbK8J3GV2z3cSJ
	for <lists+linux-erofs@lfdr.de>; Fri, 22 Oct 2021 20:40:16 +1100 (AEDT)
X-Original-To: linux-erofs@lists.ozlabs.org
Delivered-To: linux-erofs@lists.ozlabs.org
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized)
 smtp.mailfrom=linux.alibaba.com (client-ip=115.124.30.43;
 helo=out30-43.freemail.mail.aliyun.com;
 envelope-from=hsiangkao@linux.alibaba.com; receiver=<UNKNOWN>)
Received: from out30-43.freemail.mail.aliyun.com
 (out30-43.freemail.mail.aliyun.com [115.124.30.43])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 4HbK7n47QTz30GN
 for <linux-erofs@lists.ozlabs.org>; Fri, 22 Oct 2021 20:39:47 +1100 (AEDT)
X-Alimail-AntiSpam: AC=PASS; BC=-1|-1; BR=01201311R851e4; CH=green; DM=||false|;
 DS=||; FP=0|-1|-1|-1|0|-1|-1|-1; HT=e01e04400; MF=hsiangkao@linux.alibaba.com;
 NM=1; PH=DS; RN=13; SR=0; TI=SMTPD_---0UtFDUY5_1634895569; 
Received: from B-P7TQMD6M-0146.local(mailfrom:hsiangkao@linux.alibaba.com
 fp:SMTPD_---0UtFDUY5_1634895569) by smtp.aliyun-inc.com(127.0.0.1);
 Fri, 22 Oct 2021 17:39:31 +0800
Date: Fri, 22 Oct 2021 17:39:29 +0800
From: Gao Xiang <hsiangkao@linux.alibaba.com>
To: Qu Wenruo <quwenruo.btrfs@gmx.com>
Subject: Re: Readahead for compressed data
Message-ID: <YXKG0V99Ph9KhDyg@B-P7TQMD6M-0146.local>
Mail-Followup-To: Qu Wenruo <quwenruo.btrfs@gmx.com>,
 Jan Kara <jack@suse.cz>, Phillip Susi <phill@thesusis.net>,
 linux-ntfs-dev@lists.sourceforge.net,
 Matthew Wilcox <willy@infradead.org>,
 David Howells <dhowells@redhat.com>, linux-bcache@vger.kernel.org,
 Hsin-Yi Wang <hsinyi@chromium.org>, linux-fsdevel@vger.kernel.org,
 Phillip Lougher <phillip@squashfs.org.uk>, ntfs3@lists.linux.dev,
 linux-erofs@lists.ozlabs.org, linux-btrfs@vger.kernel.org
References: <YXHK5HrQpJu9oy8w@casper.infradead.org>
 <87tuh9n9w2.fsf@vps.thesusis.net>
 <20211022084127.GA1026@quack2.suse.cz>
 <YXKARs0QpAZWl6Hi@B-P7TQMD6M-0146.local>
 <62f5f68d-7e3f-9238-5417-c64d8dcf2214@gmx.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <62f5f68d-7e3f-9238-5417-c64d8dcf2214@gmx.com>
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
 Matthew Wilcox <willy@infradead.org>, David Howells <dhowells@redhat.com>,
 linux-bcache@vger.kernel.org, Phillip Susi <phill@thesusis.net>,
 Hsin-Yi Wang <hsinyi@chromium.org>, linux-fsdevel@vger.kernel.org,
 Phillip Lougher <phillip@squashfs.org.uk>, ntfs3@lists.linux.dev,
 linux-erofs@lists.ozlabs.org, linux-btrfs@vger.kernel.org
Errors-To: linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org
Sender: "Linux-erofs"
 <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>

Hi Qu,

On Fri, Oct 22, 2021 at 05:22:28PM +0800, Qu Wenruo wrote:
> 
> 
> On 2021/10/22 17:11, Gao Xiang wrote:
> > On Fri, Oct 22, 2021 at 10:41:27AM +0200, Jan Kara wrote:
> > > On Thu 21-10-21 21:04:45, Phillip Susi wrote:
> > > > 
> > > > Matthew Wilcox <willy@infradead.org> writes:
> > > > 
> > > > > As far as I can tell, the following filesystems support compressed data:
> > > > > 
> > > > > bcachefs, btrfs, erofs, ntfs, squashfs, zisofs
> > > > > 
> > > > > I'd like to make it easier and more efficient for filesystems to
> > > > > implement compressed data.  There are a lot of approaches in use today,
> > > > > but none of them seem quite right to me.  I'm going to lay out a few
> > > > > design considerations next and then propose a solution.  Feel free to
> > > > > tell me I've got the constraints wrong, or suggest alternative solutions.
> > > > > 
> > > > > When we call ->readahead from the VFS, the VFS has decided which pages
> > > > > are going to be the most useful to bring in, but it doesn't know how
> > > > > pages are bundled together into blocks.  As I've learned from talking to
> > > > > Gao Xiang, sometimes the filesystem doesn't know either, so this isn't
> > > > > something we can teach the VFS.
> > > > > 
> > > > > We (David) added readahead_expand() recently to let the filesystem
> > > > > opportunistically add pages to the page cache "around" the area requested
> > > > > by the VFS.  That reduces the number of times the filesystem has to
> > > > > decompress the same block.  But it can fail (due to memory allocation
> > > > > failures or pages already being present in the cache).  So filesystems
> > > > > still have to implement some kind of fallback.
> > > > 
> > > > Wouldn't it be better to keep the *compressed* data in the cache and
> > > > decompress it multiple times if needed rather than decompress it once
> > > > and cache the decompressed data?  You would use more CPU time
> > > > decompressing multiple times, but be able to cache more data and avoid
> > > > more disk IO, which is generally far slower than the CPU can decompress
> > > > the data.
> > > 
> > > Well, one of the problems with keeping compressed data is that for mmap(2)
> > > you have to have pages decompressed so that CPU can access them. So keeping
> > > compressed data in the page cache would add a bunch of complexity. That
> > > being said keeping compressed data cached somewhere else than in the page
> > > cache may certainly me worth it and then just filling page cache on demand
> > > from this data...
> > 
> > It can be cached with a special internal inode, so no need to take
> > care of the memory reclaim or migration by yourself.
> 
> There is another problem for btrfs (and maybe other fses).
> 
> Btrfs can refer to part of the uncompressed data extent.
> 
> Thus we could have the following cases:
> 
> 	0	4K	8K	12K
> 	|	|	|	|
> 		    |	    \- 4K of an 128K compressed extent,
> 		    |		compressed size is 16K
> 		    \- 4K of an 64K compressed extent,
> 			compressed size is 8K

Thanks for this, but the diagram is broken on my side.
Could you help fix this?

> 
> In above case, we really only need 8K for page cache, but if we're
> caching the compressed extent, it will take extra 24K.

Apart from that, with my wild guess, could we cache whatever the
real I/O is rather than the whole compressed extent unconditionally?
If the whole compressed extent is needed then, we could check if
it's all available in cache, or read the rest instead?

Also, I think no need to cache uncompressed COW data...

Thanks,
Gao Xiang

> 
> It's definitely not really worthy for this particular corner case.
> 
> But it would be pretty common for btrfs, as CoW on compressed data can
> easily lead to above cases.
> 
> Thanks,
> Qu
> 
> > 
> > Otherwise, these all need to be take care of. For fixed-sized input
> > compression, since they are reclaimed in page unit, so it won't be
> > quite friendly since such data is all coupling. But for fixed-sized
> > output compression, it's quite natural.
> > 
> > Thanks,
> > Gao Xiang
> > 
> > > 
> > > 								Honza
> > > --
> > > Jan Kara <jack@suse.com>
> > > SUSE Labs, CR
