Return-Path: <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>
X-Original-To: lists+linux-erofs@lfdr.de
Delivered-To: lists+linux-erofs@lfdr.de
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2404:9400:2:0:216:3eff:fee1:b9f1])
	by mail.lfdr.de (Postfix) with ESMTPS id 052F33D7B6F
	for <lists+linux-erofs@lfdr.de>; Tue, 27 Jul 2021 18:56:15 +0200 (CEST)
Received: from boromir.ozlabs.org (localhost [IPv6:::1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4GZ2xS5vgLz30BD
	for <lists+linux-erofs@lfdr.de>; Wed, 28 Jul 2021 02:56:12 +1000 (AEST)
Authentication-Results: lists.ozlabs.org;
	dkim=fail reason="signature verification failed" (1024-bit key; unprotected) header.d=suse.cz header.i=@suse.cz header.a=rsa-sha256 header.s=susede2_rsa header.b=l9VZZdmX;
	dkim=fail reason="signature verification failed" header.d=suse.cz header.i=@suse.cz header.a=ed25519-sha256 header.s=susede2_ed25519 header.b=tZv5ZZHU;
	dkim-atps=neutral
X-Original-To: linux-erofs@lists.ozlabs.org
Delivered-To: linux-erofs@lists.ozlabs.org
Authentication-Results: lists.ozlabs.org;
 spf=pass (sender SPF authorized) smtp.mailfrom=suse.cz
 (client-ip=195.135.220.28; helo=smtp-out1.suse.de;
 envelope-from=dsterba@suse.cz; receiver=<UNKNOWN>)
Authentication-Results: lists.ozlabs.org; dkim=pass (1024-bit key;
 unprotected) header.d=suse.cz header.i=@suse.cz header.a=rsa-sha256
 header.s=susede2_rsa header.b=l9VZZdmX; 
 dkim=pass header.d=suse.cz header.i=@suse.cz header.a=ed25519-sha256
 header.s=susede2_ed25519 header.b=tZv5ZZHU; 
 dkim-atps=neutral
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.220.28])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 4GZ2xL0ccWz2xZp
 for <linux-erofs@lists.ozlabs.org>; Wed, 28 Jul 2021 02:56:05 +1000 (AEST)
Received: from relay2.suse.de (relay2.suse.de [149.44.160.134])
 by smtp-out1.suse.de (Postfix) with ESMTP id 0F3F7221EC;
 Tue, 27 Jul 2021 16:56:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1627404962;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
 cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=I6xqCcuCxJ3dCYSStp64lbp+Ddy6J/xCqtuiJjo0KTU=;
 b=l9VZZdmXPaqiSYtXX46V49UfixDqIhSkECPLTwTkbtGHLK/AuoKm06q7J3PS373yKVmts2
 O1lrA2stloOZxxU5jN7bq00RpFLddcX2uIIN2fAnKqONgUg6hYoAmUfTEaUA9iBQ+j2HGk
 owdkUrtd1KN7PW2qSLuwBHp7oGC/vIE=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1627404962;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
 cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=I6xqCcuCxJ3dCYSStp64lbp+Ddy6J/xCqtuiJjo0KTU=;
 b=tZv5ZZHUElMD+oEJaRkN3pa6JgcLy1DGjYM+xi/S88Md/OALdTnSju1j/wKZw93J67fkLj
 H4rY+l0mcJfK1wBw==
Received: from ds.suse.cz (ds.suse.cz [10.100.12.205])
 by relay2.suse.de (Postfix) with ESMTP id 81D68A3B81;
 Tue, 27 Jul 2021 16:56:01 +0000 (UTC)
Received: by ds.suse.cz (Postfix, from userid 10065)
 id EBA30DA8D6; Tue, 27 Jul 2021 18:53:16 +0200 (CEST)
Date: Tue, 27 Jul 2021 18:53:16 +0200
From: David Sterba <dsterba@suse.cz>
To: Matthew Wilcox <willy@infradead.org>
Subject: Re: [PATCH v7] iomap: make inline data support more flexible
Message-ID: <20210727165315.GU5047@suse.cz>
Mail-Followup-To: dsterba@suse.cz, Matthew Wilcox <willy@infradead.org>,
 Christoph Hellwig <hch@lst.de>,
 Andreas Gruenbacher <agruenba@redhat.com>,
 Gao Xiang <hsiangkao@linux.alibaba.com>,
 "Darrick J . Wong" <djwong@kernel.org>,
 Huang Jianan <huangjianan@oppo.com>, linux-erofs@lists.ozlabs.org,
 linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
 Andreas Gruenbacher <andreas.gruenbacher@gmail.com>
References: <CAHpGcMKZP8b3TbRv3D-pcrE_iDU5TKUFHst9emuQmRPntFSArA@mail.gmail.com>
 <CAHpGcMJBhWcwteLDSBU3hgwq1tk_+LqogM1ZM=Fv8U0VtY5hMg@mail.gmail.com>
 <20210723174131.180813-1-hsiangkao@linux.alibaba.com>
 <20210725221639.426565-1-agruenba@redhat.com>
 <YP4zUvnBCAb86Mny@B-P7TQMD6M-0146.local>
 <20210726110611.459173-1-agruenba@redhat.com>
 <20210726121702.GA528@lst.de> <20210727082042.GI5047@twin.jikos.cz>
 <YQALsvt0UWGW+iMw@casper.infradead.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <YQALsvt0UWGW+iMw@casper.infradead.org>
User-Agent: Mutt/1.5.23.1-rc1 (2014-03-12)
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
Reply-To: dsterba@suse.cz
Cc: Andreas Gruenbacher <agruenba@redhat.com>,
 "Darrick J . Wong" <djwong@kernel.org>,
 Andreas Gruenbacher <andreas.gruenbacher@gmail.com>,
 linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org,
 linux-erofs@lists.ozlabs.org, Christoph Hellwig <hch@lst.de>
Errors-To: linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org
Sender: "Linux-erofs"
 <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>

On Tue, Jul 27, 2021 at 02:35:46PM +0100, Matthew Wilcox wrote:
> On Tue, Jul 27, 2021 at 10:20:42AM +0200, David Sterba wrote:
> > On Mon, Jul 26, 2021 at 02:17:02PM +0200, Christoph Hellwig wrote:
> > > > Subject: iomap: Support tail packing
> > > 
> > > I can't say I like this "tail packing" language here when we have the
> > > perfectly fine inline wording.  Same for various comments in the actual
> > > code.
> > 
> > Yes please, don't call it tail-packing when it's an inline extent, we'll
> > use that for btrfs eventually and conflating the two terms has been
> > cofusing users. Except reiserfs, no linux filesystem does tail-packing.
> 
> Hmm ... I see what reiserfs does as packing tails of multiple files into
> one block.  What gfs2 (and ext4) do is inline data.  Erofs packs the
> tail of a single file into the same block as the inode.  If I understand
> what btrfs does correctly, it stores data in the btree.  But (like
> gfs2/ext4), it's only for the entire-file-is-small case, not for
> its-just-ten-bytes-into-the-last-block case.
> 
> So what would you call what erofs is doing if not tail-packing?

That indeed sounds like tail-packing and I was not aware of that, the
docs I found were not clear what exactly was going on with the data
stored inline.

> Wikipedia calls it https://en.wikipedia.org/wiki/Block_suballocation
> which doesn't quite fit.  We need a phrase which means "this isn't
> just for small files but for small tails of large files".

So that's more generic than what we now have as inline files, so in the
interface everybody sets 0 as start of the range while erofs can also
set start of the last partial block.
