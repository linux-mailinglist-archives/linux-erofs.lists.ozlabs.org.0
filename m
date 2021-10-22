Return-Path: <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>
X-Original-To: lists+linux-erofs@lfdr.de
Delivered-To: lists+linux-erofs@lfdr.de
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	by mail.lfdr.de (Postfix) with ESMTPS id A8EB9437001
	for <lists+linux-erofs@lfdr.de>; Fri, 22 Oct 2021 04:31:40 +0200 (CEST)
Received: from boromir.ozlabs.org (localhost [IPv6:::1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4Hb7dk1z3Bz3c72
	for <lists+linux-erofs@lfdr.de>; Fri, 22 Oct 2021 13:31:38 +1100 (AEDT)
X-Original-To: linux-erofs@lists.ozlabs.org
Delivered-To: linux-erofs@lists.ozlabs.org
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized)
 smtp.mailfrom=linux.alibaba.com (client-ip=47.88.44.36;
 helo=out4436.biz.mail.alibaba.com; envelope-from=hsiangkao@linux.alibaba.com;
 receiver=<UNKNOWN>)
Received: from out4436.biz.mail.alibaba.com (out4436.biz.mail.alibaba.com
 [47.88.44.36])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 4Hb7dd4KJWz2xv0
 for <linux-erofs@lists.ozlabs.org>; Fri, 22 Oct 2021 13:31:31 +1100 (AEDT)
X-Alimail-AntiSpam: AC=PASS; BC=-1|-1; BR=01201311R101e4; CH=green; DM=||false|;
 DS=||; FP=0|-1|-1|-1|0|-1|-1|-1; HT=e01e04395; MF=hsiangkao@linux.alibaba.com;
 NM=1; PH=DS; RN=12; SR=0; TI=SMTPD_---0UtCTdiN_1634869863; 
Received: from B-P7TQMD6M-0146.local(mailfrom:hsiangkao@linux.alibaba.com
 fp:SMTPD_---0UtCTdiN_1634869863) by smtp.aliyun-inc.com(127.0.0.1);
 Fri, 22 Oct 2021 10:31:05 +0800
Date: Fri, 22 Oct 2021 10:31:03 +0800
From: Gao Xiang <hsiangkao@linux.alibaba.com>
To: Phillip Lougher <phillip@squashfs.org.uk>
Subject: Re: Readahead for compressed data
Message-ID: <YXIiZ4CAfSP6FucF@B-P7TQMD6M-0146.local>
Mail-Followup-To: Phillip Lougher <phillip@squashfs.org.uk>,
 Phillip Susi <phill@thesusis.net>,
 Matthew Wilcox <willy@infradead.org>, linux-fsdevel@vger.kernel.org,
 Jan Kara <jack@suse.cz>, linux-erofs@lists.ozlabs.org,
 linux-btrfs@vger.kernel.org, linux-ntfs-dev@lists.sourceforge.net,
 ntfs3@lists.linux.dev, linux-bcache@vger.kernel.org,
 David Howells <dhowells@redhat.com>,
 Hsin-Yi Wang <hsinyi@chromium.org>
References: <YXHK5HrQpJu9oy8w@casper.infradead.org>
 <87tuh9n9w2.fsf@vps.thesusis.net>
 <ea03d018-b9ef-9eed-c382-e1a3db7e4e5f@squashfs.org.uk>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <ea03d018-b9ef-9eed-c382-e1a3db7e4e5f@squashfs.org.uk>
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
 ntfs3@lists.linux.dev, linux-erofs@lists.ozlabs.org,
 linux-btrfs@vger.kernel.org
Errors-To: linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org
Sender: "Linux-erofs"
 <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>

On Fri, Oct 22, 2021 at 03:09:03AM +0100, Phillip Lougher wrote:
> On 22/10/2021 02:04, Phillip Susi wrote:
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
> > decompressing multiple times
> 
> There is a fairly obvious problem here.   A malicious attacker could
> "trick" the filesystem into endlessly decompressing the same blocks,
> which because the compressed data is cached, could cause it to use
> all CPU, and cause a DOS attack.  Caching the uncompressed data prevents
> these decompression attacks from occurring so easily.

Yes, that is another good point. But with artifact memory pressure,
there is no difference to cache compressed data or decompressed data,
otherwise these pages will be unreclaimable, reclaim any of cached
decompressed data will also need decompress the whole pcluster.

The same to zram or zswap or what else software compression solution,
what we can do is to limit the CPU utilization if any such requirement.
But that is quite hard for lz4 since in-memory lz4 decompression speed
is usually fast than the backend storage.

By the way, as far as I know there were some experimental hardware
accelerator integrated to storage devices. So they don't need to expand
decompress pages as well. And do inplace I/O only for such devices.

Thanks,
Gao Xiang

> 
> Phillip
> 
> 
