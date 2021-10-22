Return-Path: <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>
X-Original-To: lists+linux-erofs@lfdr.de
Delivered-To: lists+linux-erofs@lfdr.de
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	by mail.lfdr.de (Postfix) with ESMTPS id 946B74373EE
	for <lists+linux-erofs@lfdr.de>; Fri, 22 Oct 2021 10:50:14 +0200 (CEST)
Received: from boromir.ozlabs.org (localhost [IPv6:::1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4HbJ2X0xLPz3c7w
	for <lists+linux-erofs@lfdr.de>; Fri, 22 Oct 2021 19:50:12 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org;
	dkim=fail reason="signature verification failed" (1024-bit key; unprotected) header.d=suse.cz header.i=@suse.cz header.a=rsa-sha256 header.s=susede2_rsa header.b=hUeet1mv;
	dkim=fail reason="signature verification failed" header.d=suse.cz header.i=@suse.cz header.a=ed25519-sha256 header.s=susede2_ed25519 header.b=93TfJ6Al;
	dkim-atps=neutral
X-Original-To: linux-erofs@lists.ozlabs.org
Delivered-To: linux-erofs@lists.ozlabs.org
Authentication-Results: lists.ozlabs.org;
 spf=pass (sender SPF authorized) smtp.mailfrom=suse.cz
 (client-ip=195.135.220.28; helo=smtp-out1.suse.de; envelope-from=jack@suse.cz;
 receiver=<UNKNOWN>)
Authentication-Results: lists.ozlabs.org; dkim=pass (1024-bit key;
 unprotected) header.d=suse.cz header.i=@suse.cz header.a=rsa-sha256
 header.s=susede2_rsa header.b=hUeet1mv; 
 dkim=pass header.d=suse.cz header.i=@suse.cz header.a=ed25519-sha256
 header.s=susede2_ed25519 header.b=93TfJ6Al; 
 dkim-atps=neutral
X-Greylist: delayed 507 seconds by postgrey-1.36 at boromir;
 Fri, 22 Oct 2021 19:50:04 AEDT
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.220.28])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 4HbJ2N32y3z3c6k
 for <linux-erofs@lists.ozlabs.org>; Fri, 22 Oct 2021 19:50:04 +1100 (AEDT)
Received: from relay2.suse.de (relay2.suse.de [149.44.160.134])
 by smtp-out1.suse.de (Postfix) with ESMTP id 2E471212C8;
 Fri, 22 Oct 2021 08:41:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1634892092; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=jUTA5Jw5vXR7hfBklBPTGzgJVoiY+oGxN0ZIH2ohiuU=;
 b=hUeet1mvoGA5h/fTMMNRWlNcPBNVd/vMlJXCdqzUYqCN21jWa8ML3xIM6eneby/KN3MBMv
 r+gStONFMg8gxkY48tjc6Z0Ol2/9ATChBGk3rx5XV2JzpG+CBKffrwj1CzkukmX+P54MoI
 tG9+6ycKKO6eEOPoQ97jRJBptPjACDA=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1634892092;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=jUTA5Jw5vXR7hfBklBPTGzgJVoiY+oGxN0ZIH2ohiuU=;
 b=93TfJ6AlqJHa9yXjCPyODn6CTm5FhUSb9kiJtGJhmueazloUFAr8rZS/ygrMCciVWT+AeN
 XIUcYzyPA9K4XXCg==
Received: from quack2.suse.cz (unknown [10.100.224.230])
 by relay2.suse.de (Postfix) with ESMTP id 0A738A3B81;
 Fri, 22 Oct 2021 08:41:32 +0000 (UTC)
Received: by quack2.suse.cz (Postfix, from userid 1000)
 id B2BB51E11B6; Fri, 22 Oct 2021 10:41:27 +0200 (CEST)
Date: Fri, 22 Oct 2021 10:41:27 +0200
From: Jan Kara <jack@suse.cz>
To: Phillip Susi <phill@thesusis.net>
Subject: Re: Readahead for compressed data
Message-ID: <20211022084127.GA1026@quack2.suse.cz>
References: <YXHK5HrQpJu9oy8w@casper.infradead.org>
 <87tuh9n9w2.fsf@vps.thesusis.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <87tuh9n9w2.fsf@vps.thesusis.net>
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
 Matthew Wilcox <willy@infradead.org>, David Howells <dhowells@redhat.com>,
 linux-bcache@vger.kernel.org, Hsin-Yi Wang <hsinyi@chromium.org>,
 linux-fsdevel@vger.kernel.org, Phillip Lougher <phillip@squashfs.org.uk>,
 ntfs3@lists.linux.dev, linux-erofs@lists.ozlabs.org,
 linux-btrfs@vger.kernel.org
Errors-To: linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org
Sender: "Linux-erofs"
 <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>

On Thu 21-10-21 21:04:45, Phillip Susi wrote:
> 
> Matthew Wilcox <willy@infradead.org> writes:
> 
> > As far as I can tell, the following filesystems support compressed data:
> >
> > bcachefs, btrfs, erofs, ntfs, squashfs, zisofs
> >
> > I'd like to make it easier and more efficient for filesystems to
> > implement compressed data.  There are a lot of approaches in use today,
> > but none of them seem quite right to me.  I'm going to lay out a few
> > design considerations next and then propose a solution.  Feel free to
> > tell me I've got the constraints wrong, or suggest alternative solutions.
> >
> > When we call ->readahead from the VFS, the VFS has decided which pages
> > are going to be the most useful to bring in, but it doesn't know how
> > pages are bundled together into blocks.  As I've learned from talking to
> > Gao Xiang, sometimes the filesystem doesn't know either, so this isn't
> > something we can teach the VFS.
> >
> > We (David) added readahead_expand() recently to let the filesystem
> > opportunistically add pages to the page cache "around" the area requested
> > by the VFS.  That reduces the number of times the filesystem has to
> > decompress the same block.  But it can fail (due to memory allocation
> > failures or pages already being present in the cache).  So filesystems
> > still have to implement some kind of fallback.
> 
> Wouldn't it be better to keep the *compressed* data in the cache and
> decompress it multiple times if needed rather than decompress it once
> and cache the decompressed data?  You would use more CPU time
> decompressing multiple times, but be able to cache more data and avoid
> more disk IO, which is generally far slower than the CPU can decompress
> the data.

Well, one of the problems with keeping compressed data is that for mmap(2)
you have to have pages decompressed so that CPU can access them. So keeping
compressed data in the page cache would add a bunch of complexity. That
being said keeping compressed data cached somewhere else than in the page
cache may certainly me worth it and then just filling page cache on demand
from this data...

								Honza
-- 
Jan Kara <jack@suse.com>
SUSE Labs, CR
