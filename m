Return-Path: <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>
X-Original-To: lists+linux-erofs@lfdr.de
Delivered-To: lists+linux-erofs@lfdr.de
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2404:9400:2:0:216:3eff:fee1:b9f1])
	by mail.lfdr.de (Postfix) with ESMTPS id B6CFA98572E
	for <lists+linux-erofs@lfdr.de>; Wed, 25 Sep 2024 12:31:30 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=lists.ozlabs.org;
	s=201707; t=1727260288;
	bh=cTW+pF/WV93ivfzeK06XW/Qx7uLYqRa9AejrWV4IA9Y=;
	h=Date:To:Subject:References:In-Reply-To:List-Id:List-Unsubscribe:
	 List-Archive:List-Post:List-Help:List-Subscribe:From:Reply-To:Cc:
	 From;
	b=O5OC8EexKSvV6QtIloU7XObl3jnGLyOxdDFHQu8L5vbblFnb0KJodVR0b/2/V/qiN
	 X5lkkl3tkX78sZXciOWIT9/7Ek4CdoK82KwBEV0JNupRGDOUHVIJl3y7QP8+i9IxJk
	 fG9YrUdqkiVmGXfwJehQBp572l928sEG1VDv/NeWf/0eS/alGpkn16102TXJ0gIvlC
	 I/AyOosZFLdwJyISJebGNpSiwRcEO8fnCqMYaBI7Z76UCVZD718iz35cnjbCccXc8N
	 yx8AMvWtQPLjpv0Sf2SL69wVXe22lHyyOA13HqqbQGE0HCleCqK5u4TQqc3+IyJpIb
	 oyWIkRB/UCm/Q==
Received: from boromir.ozlabs.org (localhost [IPv6:::1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4XDCh06CyHz2yTs
	for <lists+linux-erofs@lfdr.de>; Wed, 25 Sep 2024 20:31:28 +1000 (AEST)
X-Original-To: linux-erofs@lists.ozlabs.org
Delivered-To: linux-erofs@lists.ozlabs.org
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip=147.75.193.91
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1727260286;
	cv=none; b=JTRtXcYsIyoVNse2rVm1Vbg/mJ4wjR4bPJ9q4pxIr1n5OLi70+asPmGpOSJ0s9aVog2TcfNULy4Asla6N27PQU/qDfKL2bIMcRVze0HL+bpqNRsUY9y6tmvtfGPP4uS4ucRGyJRrNepLX93Sw0QTuV5kPhaKdXEc1Z8eds6r43I50yTThAw6rRYQFsrrq0Hpusv3n77bSpPQdcsC2A45O0K2UsQ+iFDMTZ+8RfcOn7T6VDu9YGn/2TiivCUAtESQa25zaxLkXO0u9S1yQynLIj9ff5dF6CtB135AlR4PMz2lIFcXvCfTx2ZLI5UZh1KA8e+SInmeiFFT+vW4ZHtKpg==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1727260286; c=relaxed/relaxed;
	bh=cTW+pF/WV93ivfzeK06XW/Qx7uLYqRa9AejrWV4IA9Y=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=C1qsl4Rig0ia4YFxwO7UbTsfDtKe1m1uTjfuPyQ6FLiZaT82tCe0TPtn7TAcJVzDP2nrnf/VTBLiDg/Rj6EipN2I1STn51k11QZImUJLnnt9LNODoKUeTcmq/m1adPchL3usIWSjgZxQNayHqMa7Z26kDZEi3qRInaTV8msnk6l+Ngv/dnp5moKXrGfSxuyPzkwEDZT0HhWoLIyWbN0+c2PrJJyKmPrUqjY+ClmzMPSjXgd1WXM+CjF4WdLZyUhrhbdEWGoqTgX2RdP1lW8DSAIxDxjIAsGOrisw0RqclrwWJT7Go74hnlzjGOXrW5w+ObDoQT6LHWyWtDKviyq8Rw==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=kernel.org; dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20201202 header.b=U7cRb2uC; dkim-atps=neutral; spf=pass (client-ip=147.75.193.91; helo=nyc.source.kernel.org; envelope-from=leon@kernel.org; receiver=lists.ozlabs.org) smtp.mailfrom=kernel.org
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=kernel.org
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20201202 header.b=U7cRb2uC;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=kernel.org (client-ip=147.75.193.91; helo=nyc.source.kernel.org; envelope-from=leon@kernel.org; receiver=lists.ozlabs.org)
Received: from nyc.source.kernel.org (nyc.source.kernel.org [147.75.193.91])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4XDCgy1hvFz2y8V
	for <linux-erofs@lists.ozlabs.org>; Wed, 25 Sep 2024 20:31:26 +1000 (AEST)
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
	by nyc.source.kernel.org (Postfix) with ESMTP id 134B7A43EA6;
	Wed, 25 Sep 2024 10:31:15 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0D09AC4CEC3;
	Wed, 25 Sep 2024 10:31:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1727260282;
	bh=azYpPCRc7Fpbb2pqhBjEq/yVygWme8hOTL1tIFJNaK0=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=U7cRb2uCSSGYlrTYOMEkLkLJVOvOsQCMhJxNZE4VBoyjE7Gq9o6SrUMyXirimlK0E
	 McSps++Q2aGwn4KdkOIuSMCsy3CbLPaeiyfRhm/l01iDsfhIhlIPhnbfFUZFeYGsKJ
	 aKZKMFqtRCSipuRw/1WbpImuw9tKxoyA/LAiu+FUsU6K+65c0JDfa5Bwd2UnBcyd5j
	 3QnFPplvGm09sqRiYq5x5mC5kji/QEtY0ec6n7UoL2uLBp6C8Iy2TEB0wSIVUkMeVP
	 uy1dTuxxY8VG6XbzT6GVhe1lO/x4nUkht3sJu2EhRJWrPe4wYn0i5oqac34vFn3Rad
	 ktd405WzhKKSA==
Date: Wed, 25 Sep 2024 13:31:18 +0300
To: Eduard Zingerman <eddyz87@gmail.com>,
	David Howells <dhowells@redhat.com>,
	Christian Brauner <brauner@kernel.org>
Subject: Re: [PATCH v2 19/25] netfs: Speed up buffered reading
Message-ID: <20240925103118.GE967758@unreal>
References: <20240923183432.1876750-1-chantr4@gmail.com>
 <20240814203850.2240469-20-dhowells@redhat.com>
 <1279816.1727220013@warthog.procyon.org.uk>
 <4b5621958a758da830c1cf09c6f6893aed371f9d.camel@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <4b5621958a758da830c1cf09c6f6893aed371f9d.camel@gmail.com>
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
From: Leon Romanovsky via Linux-erofs <linux-erofs@lists.ozlabs.org>
Reply-To: Leon Romanovsky <leon@kernel.org>
Cc: asmadeus@codewreck.org, linux-mm@kvack.org, marc.dionne@auristor.com, linux-afs@lists.infradead.org, pc@manguebit.com, linux-cifs@vger.kernel.org, Manu Bretelle <chantr4@gmail.com>, willy@infradead.org, smfrench@gmail.com, hsiangkao@linux.alibaba.com, idryomov@gmail.com, sprasad@microsoft.com, tom@talpey.com, ceph-devel@vger.kernel.org, ericvh@kernel.org, christian@brauner.io, linux-nfs@vger.kernel.org, netdev@vger.kernel.org, v9fs@lists.linux.dev, jlayton@kernel.org, linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org, netfs@lists.linux.dev, linux-erofs@lists.ozlabs.org
Errors-To: linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org
Sender: "Linux-erofs" <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>

On Tue, Sep 24, 2024 at 05:01:13PM -0700, Eduard Zingerman wrote:
> On Wed, 2024-09-25 at 00:20 +0100, David Howells wrote:
> > Could you try the attached?  It may help, though this fixes a bug in the
> > write-side, not the read-side.
> >
> 
> Hi David,
> 
> I tried this patch on top of bpf-next but behaviour seems unchanged,
> dmesg is at [1].
> 
> [1] https://gist.github.com/eddyz87/ce45f90453980af6a5fadeb652e109f3


BTW, I'm hitting the same issue over Linus's tree now, but unfortunately
there is no WA in my case as I don't have "cache=mmap" in rootflags.
https://lore.kernel.org/all/20240924094809.GA1182241@unreal/#t

It came to Linus with Christian Brauner's pull request.
https://lore.kernel.org/all/20240913-vfs-netfs-39ef6f974061@brauner/

Thanks

> 
> Thanks,
> Eduard
> 
> [...]
> 
> 
