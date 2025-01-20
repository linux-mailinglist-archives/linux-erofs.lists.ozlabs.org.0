Return-Path: <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>
X-Original-To: lists+linux-erofs@lfdr.de
Delivered-To: lists+linux-erofs@lfdr.de
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2404:9400:2:0:216:3eff:fee1:b9f1])
	by mail.lfdr.de (Postfix) with ESMTPS id 0F8ABA16F2F
	for <lists+linux-erofs@lfdr.de>; Mon, 20 Jan 2025 16:25:33 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=lists.ozlabs.org;
	s=201707; t=1737386730;
	bh=hOAnx+XbcvM1DTLdFlA42xF04YYHw+vpXpaPl7eB6Q8=;
	h=Date:To:Subject:References:In-Reply-To:List-Id:List-Unsubscribe:
	 List-Archive:List-Post:List-Help:List-Subscribe:From:Reply-To:Cc:
	 From;
	b=G85vXlmvqr7ZFvRVezYUEuEQ5vj3KUAKBywBdT7FwLF4Z0s/HGfLWohUba7LYX3Y9
	 K9QPSR/Y0TLVNOUu8YaPWaU2btrsXA/01BzX28QlNKXZidaNHURCUZtUk2TP0LGIbW
	 zTRBCFnOE83gzonjDNdmzl+NLwtktj1Bx/x9i/fUeVHMIvlfsAVynEsuT4ahrvBfVV
	 aP8WLBx3sk0XLt6rTjnx1urb/hSaAfufTFNBND5JIiKXXkqD6VCSrLNB7T2roR7NzQ
	 JvVX6j/p3PIURHN0AenI3FAX1b4zTCXWWUq/OlbZBWXYYBcOsQceR+vTuVySwQReTy
	 /SE8xtBnUOF+w==
Received: from boromir.ozlabs.org (localhost [IPv6:::1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4YcDgG1mzGz30Gq
	for <lists+linux-erofs@lfdr.de>; Tue, 21 Jan 2025 02:25:30 +1100 (AEDT)
X-Original-To: linux-erofs@lists.ozlabs.org
Delivered-To: linux-erofs@lists.ozlabs.org
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip="2604:1380:4641:c500::1"
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1737386728;
	cv=none; b=bp79RiPnWJDjcqWg3NyvUOOabIn1y/5ztQmJKrr1jR+CwWcuogiLqBEn2mTePAm9DwSGBBRnCOMG6+SUReITS59lI6gI/0TNiDalD4fDRWJ+6uAM/QGWO0uNntcgpHHnamsAW01lG36cEuBBmM2To58Jp2Z4qNdpmf83oXu7FdgaHsqNAziAn+H8BQOjE/i4whMZSEpDkNSqTN7O4/lR+V/2AgqEON3q/U0zuECPkc659BLOu9AdkS1yAu2wkzcNhqsaCMzyclzmqVEYeTyGyrQixvu97CE8y1mpuqNjX0JCRZAKFKQ4U49b85ptnl6hKpq8PcYrHwfGqZNF1MgqnQ==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1737386728; c=relaxed/relaxed;
	bh=hOAnx+XbcvM1DTLdFlA42xF04YYHw+vpXpaPl7eB6Q8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=BpGES5swHCnnIgGBuLL0WKoEDSP9WcBSFmuP6kyF+nq9B+vSrPl7RkM6nYJsTB+XLxqUgF+YndTU527jm1xO04vy8l1Jzy9vx164XiqbH6abFaOZ0/1WegcXMTezGDFw+EkxVqzXaUYvqGCr0VHb2YTuZQV2k43o5ihs9kysGOVv+/XqqX2qNXxzV8aRk4YHrlkaGI1SfkdEyzWfb6J6HIJSfyDDrQ5Z5GgJ4cj+UfVXVgmH7TmZyzQk+ayNSmxwAIPUJ7ZLZYky3Lankc+0ONXMVdBWwT+0c9ppz/zPN4LCiI66PQ+RWN88QM/z7wyl0TUWdx2ayD0yMsLq6rxFag==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=kernel.org; dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20201202 header.b=tnGgsoYB; dkim-atps=neutral; spf=pass (client-ip=2604:1380:4641:c500::1; helo=dfw.source.kernel.org; envelope-from=brauner@kernel.org; receiver=lists.ozlabs.org) smtp.mailfrom=kernel.org
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=kernel.org
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20201202 header.b=tnGgsoYB;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=kernel.org (client-ip=2604:1380:4641:c500::1; helo=dfw.source.kernel.org; envelope-from=brauner@kernel.org; receiver=lists.ozlabs.org)
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4YcDgC6LzDz2yDp
	for <linux-erofs@lists.ozlabs.org>; Tue, 21 Jan 2025 02:25:27 +1100 (AEDT)
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
	by dfw.source.kernel.org (Postfix) with ESMTP id 560085C5C73;
	Mon, 20 Jan 2025 15:24:44 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E7843C4CEDD;
	Mon, 20 Jan 2025 15:25:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1737386724;
	bh=9biNTgBg3G+aozZcqbUVwRcx7rft0IZ1NOZPSRjhCPE=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=tnGgsoYBwimf7CoDV73yDeUTUNyIpqHmdM5jvwm+zs5+ahiOrwipR1b+2LdJQ/qSP
	 Dfu1U5d7+OfPfsMWTm+r13eLA6B6fAaGNrvk0kNZZQJWVnqmAeD6PnF7Zk959aNGle
	 duf8TIXZvQQbWEbbuFW4i/3IrB0VcFlBHIWzUqIzB8m2mexTDczdMvtcYotX5DmOYh
	 VNLDZEC0OlbU5xyFkZP4OUy+N0K2mFGriMa8lw8sdxf053EkCvQhRwNLqJ6Ko/ZM1Z
	 YQGHQB+hdPJLB2RPimg0aAyc/pOjLNrvhiAPAgy2rEjAPI1DYW3tnXQ+H5TAsyrD8P
	 hTXOZpCKOs73Q==
Date: Mon, 20 Jan 2025 16:25:19 +0100
To: Andreas Gruenbacher <agruenba@redhat.com>
Subject: Re: [PATCH 8/8] gfs2: use lockref_init for qd_lockref
Message-ID: <20250120-tragbar-ertrinken-24f2bbc2beb4@brauner>
References: <20250116043226.GA23137@lst.de>
 <CAHc6FU58eBO0i8er5+gK--eAMVHULCzHPnJ9H5oN12fr=AAnbg@mail.gmail.com>
 <20250115094702.504610-1-hch@lst.de>
 <20250115094702.504610-9-hch@lst.de>
 <CAHc6FU58eBO0i8er5+gK--eAMVHULCzHPnJ9H5oN12fr=AAnbg@mail.gmail.com>
 <20250117160352.1881139-1-agruenba@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20250117160352.1881139-1-agruenba@redhat.com>
X-Spam-Status: No, score=-2.8 required=5.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
	SPF_PASS autolearn=disabled version=4.0.0
X-Spam-Checker-Version: SpamAssassin 4.0.0 (2022-12-13) on lists.ozlabs.org
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
From: Christian Brauner via Linux-erofs <linux-erofs@lists.ozlabs.org>
Reply-To: Christian Brauner <brauner@kernel.org>
Cc: linux-kernel@vger.kernel.org, Christoph Hellwig <hch@lst.de>, gfs2@lists.linux.dev, Al Viro <viro@zeniv.linux.org.uk>, linux-fsdevel@vger.kernel.org, Andrew Morton <akpm@linux-foundation.org>, linux-erofs@lists.ozlabs.org
Errors-To: linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org
Sender: "Linux-erofs" <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>

On Fri, Jan 17, 2025 at 05:03:51PM +0100, Andreas Gruenbacher wrote:
> On Thu, 16 Jan 2025 05:32:26 +0100, Christoph Hellwig <hch@lst.de> wrote:
> > Well, if you can fix it to start with 1 we could start out with 1
> > as the default.  FYI, I also didn't touch the other gfs2 lockref
> > because it initialize the lock in the slab init_once callback and
> > the count on every initialization.
> 
> Sure, can you add the below patch before the lockref_init conversion?
> 
> Thanks,
> Andreas
> 
> --
> 
> gfs2: Prepare for converting to lockref_init
> 
> First, move initializing the glock lockref spin lock from
> gfs2_init_glock_once() to gfs2_glock_get().
> 
> Second, in qd_alloc(), initialize the lockref count to 1 to cover the
> common case.  Compensate for that in gfs2_quota_init() by adjusting the
> count back down to 0; this case occurs only when mounting the filesystem
> rw.
> 
> Signed-off-by: Andreas Gruenbacher <agruenba@redhat.com>
> ---

Can you send this as a proper separae patch, please?
