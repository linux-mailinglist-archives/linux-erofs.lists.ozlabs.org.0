Return-Path: <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>
X-Original-To: lists+linux-erofs@lfdr.de
Delivered-To: lists+linux-erofs@lfdr.de
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	by mail.lfdr.de (Postfix) with ESMTPS id 46C50436F82
	for <lists+linux-erofs@lfdr.de>; Fri, 22 Oct 2021 03:39:32 +0200 (CEST)
Received: from boromir.ozlabs.org (localhost [IPv6:::1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4Hb6TY2MmQz3bvH
	for <lists+linux-erofs@lfdr.de>; Fri, 22 Oct 2021 12:39:29 +1100 (AEDT)
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
 by lists.ozlabs.org (Postfix) with ESMTPS id 4Hb6TT2FZMz2yV5
 for <linux-erofs@lists.ozlabs.org>; Fri, 22 Oct 2021 12:39:24 +1100 (AEDT)
X-Alimail-AntiSpam: AC=PASS; BC=-1|-1; BR=01201311R521e4; CH=green; DM=||false|;
 DS=||; FP=0|-1|-1|-1|0|-1|-1|-1; HT=e01e04400; MF=hsiangkao@linux.alibaba.com;
 NM=1; PH=DS; RN=12; SR=0; TI=SMTPD_---0UtCQSwj_1634866757; 
Received: from B-P7TQMD6M-0146.local(mailfrom:hsiangkao@linux.alibaba.com
 fp:SMTPD_---0UtCQSwj_1634866757) by smtp.aliyun-inc.com(127.0.0.1);
 Fri, 22 Oct 2021 09:39:19 +0800
Date: Fri, 22 Oct 2021 09:39:17 +0800
From: Gao Xiang <hsiangkao@linux.alibaba.com>
To: Phillip Susi <phill@thesusis.net>, Matthew Wilcox <willy@infradead.org>,
 Jan Kara <jack@suse.cz>, linux-ntfs-dev@lists.sourceforge.net,
 David Howells <dhowells@redhat.com>, linux-bcache@vger.kernel.org,
 Hsin-Yi Wang <hsinyi@chromium.org>, linux-fsdevel@vger.kernel.org,
 Phillip Lougher <phillip@squashfs.org.uk>, ntfs3@lists.linux.dev,
 linux-erofs@lists.ozlabs.org, linux-btrfs@vger.kernel.org
Subject: Re: Readahead for compressed data
Message-ID: <YXIWRRqOqF5HXDGu@B-P7TQMD6M-0146.local>
Mail-Followup-To: Phillip Susi <phill@thesusis.net>,
 Matthew Wilcox <willy@infradead.org>, Jan Kara <jack@suse.cz>,
 linux-ntfs-dev@lists.sourceforge.net,
 David Howells <dhowells@redhat.com>, linux-bcache@vger.kernel.org,
 Hsin-Yi Wang <hsinyi@chromium.org>, linux-fsdevel@vger.kernel.org,
 Phillip Lougher <phillip@squashfs.org.uk>, ntfs3@lists.linux.dev,
 linux-erofs@lists.ozlabs.org, linux-btrfs@vger.kernel.org
References: <YXHK5HrQpJu9oy8w@casper.infradead.org>
 <87tuh9n9w2.fsf@vps.thesusis.net>
 <YXITrrwgFiTWXJB+@B-P7TQMD6M-0146.local>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <YXITrrwgFiTWXJB+@B-P7TQMD6M-0146.local>
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
Errors-To: linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org
Sender: "Linux-erofs"
 <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>

On Fri, Oct 22, 2021 at 09:28:14AM +0800, Gao Xiang wrote:
> On Thu, Oct 21, 2021 at 09:04:45PM -0400, Phillip Susi wrote:
> > 
> > Matthew Wilcox <willy@infradead.org> writes:
> > 
> > > As far as I can tell, the following filesystems support compressed data:
> > >
> > > bcachefs, btrfs, erofs, ntfs, squashfs, zisofs
> > >
> > > I'd like to make it easier and more efficient for filesystems to
> > > implement compressed data.  There are a lot of approaches in use today,
> > > but none of them seem quite right to me.  I'm going to lay out a few
> > > design considerations next and then propose a solution.  Feel free to
> > > tell me I've got the constraints wrong, or suggest alternative solutions.
> > >
> > > When we call ->readahead from the VFS, the VFS has decided which pages
> > > are going to be the most useful to bring in, but it doesn't know how
> > > pages are bundled together into blocks.  As I've learned from talking to
> > > Gao Xiang, sometimes the filesystem doesn't know either, so this isn't
> > > something we can teach the VFS.
> > >
> > > We (David) added readahead_expand() recently to let the filesystem
> > > opportunistically add pages to the page cache "around" the area requested
> > > by the VFS.  That reduces the number of times the filesystem has to
> > > decompress the same block.  But it can fail (due to memory allocation
> > > failures or pages already being present in the cache).  So filesystems
> > > still have to implement some kind of fallback.
> > 
> > Wouldn't it be better to keep the *compressed* data in the cache and
> > decompress it multiple times if needed rather than decompress it once
> > and cache the decompressed data?  You would use more CPU time
> > decompressing multiple times, but be able to cache more data and avoid
> > more disk IO, which is generally far slower than the CPU can decompress
> > the data.
> 
> Yes, that was also my another point yesterday talked on #xfs IRC. For
> high-decompresion speed algorithms like lz4, yes, thinking about the
> benefits of zcache or zram solutions, caching compressed data for
> incomplete read requests is more effective than caching uncompressed
> data (so we don't need zcache for EROFS at all). But if such data will
> be used completely immediately, EROFS will only do inplace I/O only
> (since cached compressed data can only increase memory overhead).
> Also, considering some algorithms is slow, inplace I/O is more useful
> for them. Anyway, it depends on the detail strategy of different
> algorithms and can be fined later.
> 

But I don't think endless compressed data caching is generally useful
especially for devices that need extra memory as much possible (For
example, we need to keep apps alive as many as possible in Android
without jagging, otherwise it would be bad for user experience). So
limited prefetching/caching only increasing memory reclaim overhead
and page cache thrashing without benefits since compressed data cannot
be used immediately without decompression.

Thanks,
Gao Xiang

> Thanks,
> Gao Xiang
> 
> > 
> > 
