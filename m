Return-Path: <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>
X-Original-To: lists+linux-erofs@lfdr.de
Delivered-To: lists+linux-erofs@lfdr.de
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	by mail.lfdr.de (Postfix) with ESMTPS id 4B7A06DE9DB
	for <lists+linux-erofs@lfdr.de>; Wed, 12 Apr 2023 05:18:45 +0200 (CEST)
Received: from boromir.ozlabs.org (localhost [IPv6:::1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4Px7GC1Lnfz3ccg
	for <lists+linux-erofs@lfdr.de>; Wed, 12 Apr 2023 13:18:43 +1000 (AEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=lists.ozlabs.org;
	s=201707; t=1681269523;
	bh=QTzf86zAv2fU3C/eN/0tX6Qjb72nN2ZOHZq+wIvYYEk=;
	h=Date:To:Subject:References:In-Reply-To:List-Id:List-Unsubscribe:
	 List-Archive:List-Post:List-Help:List-Subscribe:From:Reply-To:Cc:
	 From;
	b=GQLtELjslDjiyhRrvGD9qQQQ/fET5SRRyOAOUN46jfGBPEvtLpZgr7PZpOELp8aGH
	 R315fBkQgAQzUKF+m9IHsafgocTuUKikyxaRL6WZCVeOwQbm2HHI5PkZQDsV3r+4+T
	 kl6js3lUORrSkgMFgejtn/ggLgRlLob38BT+2aMZamXm99WKuTnlQgQlmxjdRq1V29
	 MlC2MIcI3QAhB4goaTGnScV69rrX0Nklm/nTznMuaf7cN11ljUFNAOLaRSH9rq6L1p
	 rl2pbOsXeyKpZGCTiTE/l59QUJeoMQo5iB/NFNcc3azOJ+BZSSgtsOBPvoRVHXJNjU
	 wlgjQHaCRC6og==
X-Original-To: linux-erofs@lists.ozlabs.org
Delivered-To: linux-erofs@lists.ozlabs.org
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=fromorbit.com (client-ip=2607:f8b0:4864:20::62a; helo=mail-pl1-x62a.google.com; envelope-from=david@fromorbit.com; receiver=<UNKNOWN>)
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=fromorbit-com.20210112.gappssmtp.com header.i=@fromorbit-com.20210112.gappssmtp.com header.a=rsa-sha256 header.s=20210112 header.b=RIm6qfQD;
	dkim-atps=neutral
Received: from mail-pl1-x62a.google.com (mail-pl1-x62a.google.com [IPv6:2607:f8b0:4864:20::62a])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4Px7G45f61z3bgv
	for <linux-erofs@lists.ozlabs.org>; Wed, 12 Apr 2023 13:18:34 +1000 (AEST)
Received: by mail-pl1-x62a.google.com with SMTP id ke16so9939746plb.6
        for <linux-erofs@lists.ozlabs.org>; Tue, 11 Apr 2023 20:18:34 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1681269510;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=QTzf86zAv2fU3C/eN/0tX6Qjb72nN2ZOHZq+wIvYYEk=;
        b=Bgg2dJgsFWLSqWBvjwQGdwt0EFpp1OaGQLuwTzjIydyCtQ2tofFv2Kw1PzqZLZJx8A
         8eRGYncQwSKAnoXH4GberCsVrs/H0TeRbMBpMcC8yhfLOG2b+IpA9o67DBfCga2zmLpG
         mk4PNsiefNwX+T45brNeeO77ElOIs4/ac26cckfGbRjgc5MGQxX0lUBqeGOd5d/D0Wl6
         HyLPy7leN4PShrWM0GtS7Qf3lh/2ICV7OPMemfqgHESzNiiX2Mdwl70fnGU2pAqPY+G3
         TX+I/ECH9bppP69Vv2EW7Ss9G7BT7pVO2UQvgL32LO217Hxq5EInQ4eCrZMhjTlHCDof
         Pldg==
X-Gm-Message-State: AAQBX9eRoBf32pPOm12Sa01qpJVDOep9HGoYegZaxOBQGW3wAxQD6nk1
	Yt7JRBTU5gh1aPPdw0CjzQ9rZw==
X-Google-Smtp-Source: AKy350bEvRaL0tcbYZNXJN9S8MKTlfNUtm72wryf0f0tx94/6m3Gotj2MFJG8+gujGf5Bd9bxftN0Q==
X-Received: by 2002:a17:90a:45:b0:23f:a4da:1203 with SMTP id 5-20020a17090a004500b0023fa4da1203mr6850168pjb.19.1681269510087;
        Tue, 11 Apr 2023 20:18:30 -0700 (PDT)
Received: from dread.disaster.area (pa49-180-41-174.pa.nsw.optusnet.com.au. [49.180.41.174])
        by smtp.gmail.com with ESMTPSA id z8-20020a1709028f8800b0019f9fd5c24asm7362321plo.207.2023.04.11.20.18.29
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 11 Apr 2023 20:18:29 -0700 (PDT)
Received: from dave by dread.disaster.area with local (Exim 4.92.3)
	(envelope-from <david@fromorbit.com>)
	id 1pmR06-002L8o-E9; Wed, 12 Apr 2023 13:18:26 +1000
Date: Wed, 12 Apr 2023 13:18:26 +1000
To: Eric Biggers <ebiggers@kernel.org>
Subject: Re: [PATCH v2 00/23] fs-verity support for XFS
Message-ID: <20230412031826.GI3223426@dread.disaster.area>
References: <20230404145319.2057051-1-aalbersh@redhat.com>
 <ZDTt8jSdG72/UnXi@infradead.org>
 <20230412023319.GA5105@sol.localdomain>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230412023319.GA5105@sol.localdomain>
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
From: Dave Chinner via Linux-erofs <linux-erofs@lists.ozlabs.org>
Reply-To: Dave Chinner <david@fromorbit.com>
Cc: fsverity@lists.linux.dev, linux-xfs@vger.kernel.org, linux-ext4@vger.kernel.org, agruenba@redhat.com, djwong@kernel.org, Andrey Albershteyn <aalbersh@redhat.com>, linux-f2fs-devel@lists.sourceforge.net, Christoph Hellwig <hch@infradead.org>, cluster-devel@redhat.com, dchinner@redhat.com, rpeterso@redhat.com, jth@kernel.org, linux-erofs@lists.ozlabs.org, damien.lemoal@opensource.wdc.com, linux-btrfs@vger.kernel.org
Errors-To: linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org
Sender: "Linux-erofs" <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>

On Tue, Apr 11, 2023 at 07:33:19PM -0700, Eric Biggers wrote:
> On Mon, Apr 10, 2023 at 10:19:46PM -0700, Christoph Hellwig wrote:
> > Dave is going to hate me for this, but..
> > 
> > I've been looking over some of the interfaces here, and I'm starting
> > to very seriously questioning the design decisions of storing the
> > fsverity hashes in xattrs.
> > 
> > Yes, storing them beyond i_size in the file is a bit of a hack, but
> > it allows to reuse a lot of the existing infrastructure, and much
> > of fsverity is based around it.  So storing them in an xattrs causes
> > a lot of churn in the interface.  And the XFS side with special
> > casing xattr indices also seems not exactly nice.
> 
> It seems it's really just the Merkle tree caching interface that is causing
> problems, as it's currently too closely tied to the page cache?  That is just an
> implementation detail that could be reworked along the lines of what is being
> discussed.
> 
> But anyway, it is up to the XFS folks.  Keep in mind there is also the option of
> doing what btrfs is doing, where it stores the Merkle tree separately from the
> file data stream, but caches it past i_size in the page cache at runtime.

Right. It's not entirely simple to store metadata on disk beyond EOF
in XFS because of all the assumptions throughout the IO path and
allocator interfaces that it can allocate space beyond EOF at will
and something else will clean it up later if it is not needed. This
impacts on truncate, delayed allocation, writeback, IO completion,
EOF block removal on file close, background garbage collection,
ENOSPC/EDQUOT driven space freeing, etc.  Some of these things cross
over into iomap infrastructure, too.

AFAIC, it's far more intricate, complex and risky to try to store
merkle tree data beyond EOF than it is to put it in an xattr
namespace because IO path EOF handling bugs result in user data
corruption. This happens over and over again, no matter how careful
we are about these aspects of user data handling.

OTOH, putting the merkle tree data in a different namespace avoids
these issues completely. Yes, we now have to solve an API mismatch,
but we aren't risking the addition of IO path data corruption bugs
to every non-fsverity filesystem in production...

Hence I think copying the btrfs approach (i.e. only caching the
merkle tree data in the page cache beyond EOF) would be as far as I
think we'd want to go. Realistically, there would be little
practical difference between btrfs storing the merkle tree blocks in
a separate internal btree and XFS storing them in an internal
private xattr btree namespace.

I would, however, prefer not to have to do this at all if we could
simply map the blocks directly out of the xattr buffers as we
already do internally for all the XFS code...

> I guess there is also the issue of encryption, which hasn't come up yet since
> we're talking about fsverity support only.  The Merkle tree (including the
> fsverity_descriptor) is supposed to be encrypted, just like the file contents
> are.  Having it be stored after the file contents accomplishes that easily...
> Of course, it doesn't have to be that way; a separate key could be derived, or
> the Merkle tree blocks could be encrypted with the file contents key using
> indices past i_size, without them physically being stored in the data stream.

I'm expecting that fscrypt for XFS will include encryption of the
xattr names and values (just like we will need to do for directory
names) except for the xattrs that hold the encryption keys
themselves. That means the merkle tree blocks should get encrypted
without any extra work needing to be done anywhere.  This will
simply require the fscrypt keys to be held in a private internal
xattr namespace that isn't encrypted, but that's realtively trivial
to do...

Cheers,

Dave.

-- 
Dave Chinner
david@fromorbit.com
