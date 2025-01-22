Return-Path: <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>
X-Original-To: lists+linux-erofs@lfdr.de
Delivered-To: lists+linux-erofs@lfdr.de
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2404:9400:2:0:216:3eff:fee1:b9f1])
	by mail.lfdr.de (Postfix) with ESMTPS id 169A0A191EF
	for <lists+linux-erofs@lfdr.de>; Wed, 22 Jan 2025 13:59:48 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=lists.ozlabs.org;
	s=201707; t=1737550785;
	bh=7op0893ajnBJ7/q77hQr7a6nEyYc+26OcR8rB/5KAIA=;
	h=Date:To:Subject:References:In-Reply-To:List-Id:List-Unsubscribe:
	 List-Archive:List-Post:List-Help:List-Subscribe:From:Reply-To:Cc:
	 From;
	b=LpCp9SGv6P0biwKBK9SJ/RSAwnnd/ix4ABm7eOXR5NppJvwEIs7epEtNHEhQkVboD
	 QJ8So775hoPKVFrFR79xyh4hdkpnMMAsCx4lGXedDyENoMtZHQhod5ii5DubROmwU8
	 mLMUPZf6TZ9/Pqdvhw8XiRFsxLydfzvEPxvDWdbiyUEE+dHX1R65/J2mCfvctmDB9w
	 lLC0R8CbF/rSHU3mi0kvZHqYZYdypikMmN79KmC5slRsgmr/83MvN56n1s3IqtImj/
	 iZ37zjuik1/CJZ9Y/s4udycu3sRUV1y6nPmwlk5UK6L8VfqIUmmABfU93nfxTH7NzQ
	 pzkrvGnrDWufQ==
Received: from boromir.ozlabs.org (localhost [IPv6:::1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4YdPL92tm9z3041
	for <lists+linux-erofs@lfdr.de>; Wed, 22 Jan 2025 23:59:45 +1100 (AEDT)
X-Original-To: linux-erofs@lists.ozlabs.org
Delivered-To: linux-erofs@lists.ozlabs.org
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip="2604:1380:4641:c500::1"
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1737550783;
	cv=none; b=RWAQQkhq9DZz6LsbcMWis6/tbmMDdv6hF1kuAz3wDKdlPYBNd7o/J5FBW2pZiUbdh061y1e3WYoEFPiFrVCJleUABGd1mXQ8ZuTgMLMHeYeb80qInh/4F4VY9+BWkdk7Gx/QfYJwwcGAErmQ+fCeKZ+jqNPWilr81H/vC9wUL3z1g1bM+kyVKovscPYmf0QC/NXCXvTQ5I4eMEzqfJ+bd7KHJtD2G9qs/4PS0oSQ5KzTt/TX8lBw2d3hwad4R50V8fUNnbLtUVRIJp/jGETr94s0Ttz9DFdLJ45o9OdIanVZeMHHQZf6mUjptbbzGiL57+ncvJcYBbbqelMHjkcv8A==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1737550783; c=relaxed/relaxed;
	bh=7op0893ajnBJ7/q77hQr7a6nEyYc+26OcR8rB/5KAIA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Dhhs8YopUCMauVnydb08i7EcCzo7dyxJhcoLbaJs6fRZIcxnxg0ZhnmTIG0zZt8Ty/SXDENcyJ8m+uOoIi2pPW7qFSu8JnOvWvGRAjzDk1An+8zYD55tAIPZuAQAymIGyHM7CK2jOpRB9CJxFu5WYoOHMF799qttCA320KkmsYaEkOPCHBkh0xGZfZq9gafInDrXB8WuF5TRBPcdV9a9m8RM+ooKqsGVISL9fShjSfA732QW/ZyaZikpOEDBPJHDC59WmNsBKs6GDOdxtR/Vp7PofluSgLIhYXEMQf6Nv8CYSPbdmsAxEMIW6MMsuZNiD84ItPlWYzLOFhtZZhjY1Q==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=kernel.org; dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20201202 header.b=eUCNwC3o; dkim-atps=neutral; spf=pass (client-ip=2604:1380:4641:c500::1; helo=dfw.source.kernel.org; envelope-from=brauner@kernel.org; receiver=lists.ozlabs.org) smtp.mailfrom=kernel.org
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=kernel.org
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20201202 header.b=eUCNwC3o;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=kernel.org (client-ip=2604:1380:4641:c500::1; helo=dfw.source.kernel.org; envelope-from=brauner@kernel.org; receiver=lists.ozlabs.org)
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4YdPL66Dy7z2yvs
	for <linux-erofs@lists.ozlabs.org>; Wed, 22 Jan 2025 23:59:42 +1100 (AEDT)
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
	by dfw.source.kernel.org (Postfix) with ESMTP id 5B77D5C5E51;
	Wed, 22 Jan 2025 12:59:00 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BBF56C4CED6;
	Wed, 22 Jan 2025 12:59:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1737550780;
	bh=1O7EjoRi0846T1wB/xCHnXnCV0yisP9eHE9Wd/n21TY=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=eUCNwC3od4iDd3W1bJWmIdrRBnggFd1cAG0nRXhKvP88WXWPW54fSQjpH82E08Ltj
	 Ukb0gr5Y6gkYkqzCRXZB86NkRuDqsgjX/Yr5eqC09T87m1N7yNl05mEIqmAQ4OhSlJ
	 8cck40kthlsp8r5MDUibtrlwOh0fJ1q9SMUZZSfdY8zMMnqE2AXwTmCvhN8buQhCrD
	 8VdkBN+Dj0xUlna+oNwACJ7nBnWA8/kr7WKCXYPEXVMziL+QWrJREHHH5CJa/YOz18
	 96O3EpUC/57gfoOKg72l7P6FRxCfJs3+mLL/w94w/g+fcG6Ms/86DbnioCShDMP++b
	 Dh+pNuKqwCpLw==
Date: Wed, 22 Jan 2025 13:59:34 +0100
To: Andreas Gruenbacher <agruenba@redhat.com>
Subject: Re: [PATCH 8/8] gfs2: use lockref_init for qd_lockref
Message-ID: <20250122-juckreiz-weiden-ee15107fd277@brauner>
References: <20250116043226.GA23137@lst.de>
 <20250115094702.504610-1-hch@lst.de>
 <20250115094702.504610-9-hch@lst.de>
 <CAHc6FU58eBO0i8er5+gK--eAMVHULCzHPnJ9H5oN12fr=AAnbg@mail.gmail.com>
 <20250117160352.1881139-1-agruenba@redhat.com>
 <20250120-tragbar-ertrinken-24f2bbc2beb4@brauner>
 <CAHc6FU6EpaAyzFPdJUa97ZZP76PHxJb-vP8+tzcZFRYT5bZeGQ@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAHc6FU6EpaAyzFPdJUa97ZZP76PHxJb-vP8+tzcZFRYT5bZeGQ@mail.gmail.com>
X-Spam-Status: No, score=-0.5 required=5.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS
	autolearn=disabled version=4.0.0
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

On Mon, Jan 20, 2025 at 04:44:59PM +0100, Andreas Gruenbacher wrote:
> On Mon, Jan 20, 2025 at 4:25 PM Christian Brauner <brauner@kernel.org> wrote:
> > On Fri, Jan 17, 2025 at 05:03:51PM +0100, Andreas Gruenbacher wrote:
> > > On Thu, 16 Jan 2025 05:32:26 +0100, Christoph Hellwig <hch@lst.de> wrote:
> > > > Well, if you can fix it to start with 1 we could start out with 1
> > > > as the default.  FYI, I also didn't touch the other gfs2 lockref
> > > > because it initialize the lock in the slab init_once callback and
> > > > the count on every initialization.
> > >
> > > Sure, can you add the below patch before the lockref_init conversion?
> > >
> > > Thanks,
> > > Andreas
> > >
> > > --
> > >
> > > gfs2: Prepare for converting to lockref_init
> > >
> > > First, move initializing the glock lockref spin lock from
> > > gfs2_init_glock_once() to gfs2_glock_get().
> > >
> > > Second, in qd_alloc(), initialize the lockref count to 1 to cover the
> > > common case.  Compensate for that in gfs2_quota_init() by adjusting the
> > > count back down to 0; this case occurs only when mounting the filesystem
> > > rw.
> > >
> > > Signed-off-by: Andreas Gruenbacher <agruenba@redhat.com>
> > > ---
> >
> > Can you send this as a proper separae patch, please?
> 
> Do you want this particular version which applies before Christoph's
> patches or something that applies on top of Christoph's patches?

On top, if you don't mind. Thank you!
