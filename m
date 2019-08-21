Return-Path: <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>
X-Original-To: lists+linux-erofs@lfdr.de
Delivered-To: lists+linux-erofs@lfdr.de
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2401:3900:2:1::3])
	by mail.lfdr.de (Postfix) with ESMTPS id DCE5197E88
	for <lists+linux-erofs@lfdr.de>; Wed, 21 Aug 2019 17:21:10 +0200 (CEST)
Received: from bilbo.ozlabs.org (lists.ozlabs.org [IPv6:2401:3900:2:1::3])
	by lists.ozlabs.org (Postfix) with ESMTP id 46DBFb61pKzDqRF
	for <lists+linux-erofs@lfdr.de>; Thu, 22 Aug 2019 01:21:07 +1000 (AEST)
X-Original-To: linux-erofs@lists.ozlabs.org
Delivered-To: linux-erofs@lists.ozlabs.org
Authentication-Results: lists.ozlabs.org; spf=pass (helo)
 smtp.helo=out4-smtp.messagingengine.com (client-ip=66.111.4.28;
 helo=out4-smtp.messagingengine.com; envelope-from=me@tobin.cc;
 receiver=<UNKNOWN>)
Authentication-Results: lists.ozlabs.org;
 dmarc=none (p=none dis=none) header.from=tobin.cc
Authentication-Results: lists.ozlabs.org; dkim=pass (2048-bit key;
 unprotected) header.d=tobin.cc header.i=@tobin.cc header.b="nbdXa8G4"; 
 dkim=pass (2048-bit key;
 unprotected) header.d=messagingengine.com header.i=@messagingengine.com
 header.b="FIjJL6Gl"; dkim-atps=neutral
Received: from out4-smtp.messagingengine.com (out4-smtp.messagingengine.com
 [66.111.4.28])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 46DB5B0XpKzDqgk
 for <linux-erofs@lists.ozlabs.org>; Thu, 22 Aug 2019 01:13:41 +1000 (AEST)
Received: from compute5.internal (compute5.nyi.internal [10.202.2.45])
 by mailout.nyi.internal (Postfix) with ESMTP id B0EDB2104C;
 Wed, 21 Aug 2019 11:13:37 -0400 (EDT)
Received: from mailfrontend2 ([10.202.2.163])
 by compute5.internal (MEProxy); Wed, 21 Aug 2019 11:13:37 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=tobin.cc; h=date
 :from:to:cc:subject:message-id:references:mime-version
 :content-type:in-reply-to; s=fm3; bh=UXyep5gmvR7gzJOTpOWksLGbdCj
 w2vu09aQuJ/K1NOc=; b=nbdXa8G4twyAo8+ISYJ66Col/oqbNPt6AVX9SSYbLWi
 uAgVpzJjqkxbKQG67or8LQCT+IPbcLdn0o3xfgdFA9HPCTyZg3rugtLjV4L2ZaXg
 XqvcVOKqHJXR2qQlWcsKdBtQCWFUw/Q5lYfqyk4i4DE4ePTxDTK+QSof2+6+hyP7
 b/VyxgUN7aFVkUAaGgDOL1O4tPmaKyhUcdTOh4b+Bs2n5YmUTvIc0izCvPsmazeJ
 a3S8CIxpKnFQH8SA6HDd+gGal3X0dJuoZKtjO+HMOTMFcDxa6AOrjYIwq8hb0ZI9
 yqcLljMFXOFgyLw4fS1/LS5tBMycYqDOwjLzFmUdbbA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
 messagingengine.com; h=cc:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to:x-me-proxy
 :x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; bh=UXyep5
 gmvR7gzJOTpOWksLGbdCjw2vu09aQuJ/K1NOc=; b=FIjJL6Gl6VLEJEiAyJNGPb
 kW2mq+V+KmKF+EFY5EHxYvMsHlVsJvq53dWdCdvtfL2Eh4wjCV5So9sx/1BrGMap
 tISxO+6XcL+FN4JMLbxH1lCehzf9H8fGJvmNPVtdN61zNw3YRlHAKYwVKabo/rBR
 y1u1SaDZXs1F5iaikSwoF5fSUANzT/m7iuUzY3vtErbJPsM9CFjTRJ7MfY8+sKxH
 qLtMTT0JFg8Dva+7vbWdE9NBVyhHRqbqC+uMIK2lEwVRdnmp5bA/CJtrcC+dr6wX
 fzW1FWM26hkD384cKHf6aRilJ+BzF7UEjZMXuZGvGQZjkWvNVdgvutCFNnxY7psQ
 ==
X-ME-Sender: <xms:oF9dXUSkEp3wmoKgiGcC_-NCiEf8Yaz7E7Hs1XSR8vpvF-Ea-4pdaA>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeduvddrudegfedgkeekucetufdoteggodetrfdotf
 fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
 uceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmne
 gfrhhlucfvnfffucdludehmdenucfjughrpeffhffvuffkfhggtggujgfofgesthdtredt
 ofervdenucfhrhhomhepfdfvohgsihhnucevrdcujfgrrhguihhnghdfuceomhgvsehtoh
 gsihhnrdgttgeqnecuffhomhgrihhnpehkvghrnhgvlhdrohhrghenucfkphepjedtrddu
 ieeirdektddrudelgeenucfrrghrrghmpehmrghilhhfrhhomhepmhgvsehtohgsihhnrd
 gttgenucevlhhushhtvghrufhiiigvpedt
X-ME-Proxy: <xmx:oF9dXWXqaRTicXEg7Rivmu0jRibBbbqqORI_nNRcWfozKf6GdFT9RQ>
 <xmx:oF9dXdt7svvQyWlYmVn7uDEWhm9PafN5fBawrZOYea3lrhP-eqHAKg>
 <xmx:oF9dXUuunXXGCREuLqDauNdQ8nT2rlMtk2sJKEpeXIMId0yn5pOhHQ>
 <xmx:oV9dXb8Y1JlYJaa2pMr28JqRZtlvXVatDBAwfCMod5lqhbSm41GA5w>
Received: from localhost (wsip-70-166-80-194.sd.sd.cox.net [70.166.80.194])
 by mail.messagingengine.com (Postfix) with ESMTPA id 81450D6005A;
 Wed, 21 Aug 2019 11:13:36 -0400 (EDT)
Date: Wed, 21 Aug 2019 08:13:35 -0700
From: "Tobin C. Harding" <me@tobin.cc>
To: Gao Xiang <gaoxiang25@huawei.com>
Subject: Re: [PATCH 2/2] staging/erofs: Balanced braces around a few
 conditional statements.
Message-ID: <20190821151241.GF12461@ares>
References: <1566346700-28536-1-git-send-email-caitlynannefinn@gmail.com>
 <1566346700-28536-3-git-send-email-caitlynannefinn@gmail.com>
 <7aaca457a3d3feb951082d0659eec568a908971f.camel@perches.com>
 <20190821023122.GA159802@architecture4>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190821023122.GA159802@architecture4>
X-Mailer: Mutt 1.9.4 (2018-02-28)
User-Agent: Mutt/1.9.4 (2018-02-28)
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
Cc: devel@driverdev.osuosl.org, Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
 linux-kernel@vger.kernel.org, Joe Perches <joe@perches.com>,
 linux-erofs@lists.ozlabs.org, Caitlyn <caitlynannefinn@gmail.com>
Errors-To: linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org
Sender: "Linux-erofs"
 <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>

On Wed, Aug 21, 2019 at 10:31:22AM +0800, Gao Xiang wrote:
> On Tue, Aug 20, 2019 at 07:26:46PM -0700, Joe Perches wrote:
> > On Tue, 2019-08-20 at 20:18 -0400, Caitlyn wrote:
> > > Balanced braces to fix some checkpath warnings in inode.c and
> > > unzip_vle.c
> > []
> > > diff --git a/drivers/staging/erofs/unzip_vle.c b/drivers/staging/erofs/unzip_vle.c
> > []
> > > @@ -915,21 +915,21 @@ static int z_erofs_vle_unzip(struct super_block *sb,
> > >  	mutex_lock(&work->lock);
> > >  	nr_pages = work->nr_pages;
> > >  
> > > -	if (likely(nr_pages <= Z_EROFS_VLE_VMAP_ONSTACK_PAGES))
> > > +	if (likely(nr_pages <= Z_EROFS_VLE_VMAP_ONSTACK_PAGES)) {
> > >  		pages = pages_onstack;
> > > -	else if (nr_pages <= Z_EROFS_VLE_VMAP_GLOBAL_PAGES &&
> > > -		 mutex_trylock(&z_pagemap_global_lock))
> > > +	} else if (nr_pages <= Z_EROFS_VLE_VMAP_GLOBAL_PAGES &&
> > > +		 mutex_trylock(&z_pagemap_global_lock)) {
> > 
> > Extra space after tab
> 
> There is actually balanced braces in linux-next.
> https://git.kernel.org/pub/scm/linux/kernel/git/next/linux-next.git/tree/drivers/staging/erofs/zdata.c#n762

Which tree did these changes go in through please Gao?  I believe
Caitlyn was working off of the staging-next branch of Greg's staging
tree.

thanks,
Tobin.
