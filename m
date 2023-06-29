Return-Path: <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>
X-Original-To: lists+linux-erofs@lfdr.de
Delivered-To: lists+linux-erofs@lfdr.de
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2404:9400:2:0:216:3eff:fee1:b9f1])
	by mail.lfdr.de (Postfix) with ESMTPS id 786F8741F4C
	for <lists+linux-erofs@lfdr.de>; Thu, 29 Jun 2023 06:34:50 +0200 (CEST)
Authentication-Results: lists.ozlabs.org;
	dkim=fail reason="signature verification failed" (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20201202 header.b=NSomkv90;
	dkim-atps=neutral
Received: from boromir.ozlabs.org (localhost [IPv6:::1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4Qs5G02fwxz30fZ
	for <lists+linux-erofs@lfdr.de>; Thu, 29 Jun 2023 14:34:48 +1000 (AEST)
X-Original-To: linux-erofs@lists.ozlabs.org
Delivered-To: linux-erofs@lists.ozlabs.org
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20201202 header.b=NSomkv90;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=kernel.org (client-ip=139.178.84.217; helo=dfw.source.kernel.org; envelope-from=djwong@kernel.org; receiver=lists.ozlabs.org)
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4Qs5Fr5svDz30Db
	for <linux-erofs@lists.ozlabs.org>; Thu, 29 Jun 2023 14:34:40 +1000 (AEST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits))
	(No client certificate requested)
	by dfw.source.kernel.org (Postfix) with ESMTPS id 0275F6140D;
	Thu, 29 Jun 2023 04:34:38 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5CBC7C433C8;
	Thu, 29 Jun 2023 04:34:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1688013277;
	bh=Nk3JAf0hVqcZqbMDWTF4i9Dk+WqJ/ybiHoB+uAe89rk=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=NSomkv906q4jECtjq1brh87cRhtHkqxP5i6pwFvkKCLBbiWUxqFaDPIvgJ8PmxN1w
	 wlI85kHcYh0TLDEICgZ05l8dm9UoPMTFQc0poef9Aud0Cr7iv7n2p6CN9Ztt99EoIT
	 47htg7un2F0soh4QTcQ2+QxJVh3VBXPY8xqNIryd8Vq1Z7dpVTWXQWRy3E7bO/lpgF
	 1AtzuXTW+ufPAf1NDaKfFjzQK27icHDPKkmHaYbj46Oa71dozc0oJABfHIOWdi2GAl
	 G3ONkilxieEwNquKpkjL4sLUDwYm9emVWBM4RoFve1MjjSa0/Abh22r5by+S7fFj1y
	 W0a4sNY0uJRCw==
Date: Wed, 28 Jun 2023 21:34:36 -0700
From: "Darrick J. Wong" <djwong@kernel.org>
To: Yangtao Li <frank.li@vivo.com>
Subject: Re: [PATCH 1/7] block: add queue_logical_block_mask() and
 bdev_logical_block_mask()
Message-ID: <20230629043436.GL11467@frogsfrogsfrogs>
References: <20230628093500.68779-1-frank.li@vivo.com>
 <ZJxj6odz49iB5Mmm@casper.infradead.org>
 <ee27ca83-a144-7468-4515-efa93f01aa43@vivo.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ee27ca83-a144-7468-4515-efa93f01aa43@vivo.com>
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
Cc: axboe@kernel.dk, linux-block@vger.kernel.org, brauner@kernel.org, linux-raid@vger.kernel.org, linux-kernel@vger.kernel.org, Matthew Wilcox <willy@infradead.org>, hch@infradead.org, song@kernel.org, huyue2@coolpad.com, viro@zeniv.linux.org.uk, linux-fsdevel@vger.kernel.org, linux-erofs@lists.ozlabs.org, linux-xfs@vger.kernel.org
Errors-To: linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org
Sender: "Linux-erofs" <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>

On Thu, Jun 29, 2023 at 11:44:35AM +0800, Yangtao Li wrote:
> On 2023/6/29 0:46, Matthew Wilcox wrote:
> 
> > On Wed, Jun 28, 2023 at 05:34:54PM +0800, Yangtao Li wrote:
> > > Introduce queue_logical_block_mask() and bdev_logical_block_mask()
> > > to simplify code, which replace (queue_logical_block_size(q) - 1)
> > > and (bdev_logical_block_size(bdev) - 1).
> > The thing is that I know what queue_logical_block_size - 1 does.
> > That's the low bits.  _Which_ bits are queue_logical_block_mask?
> > The high bits or the low bits?  And before you say "It's obviously",
> > we have both ways round in the kernel today.
> 
> 
> I guess for this you mentioned, can we name it bdev_logical_block_lmask and
> queue_logical_block_lmask?

{bdev,queue}_offset_in_lba() ?

--D

> 
> Thx,
> 
> > 
> > I am not in favour of this change.  I might be in favour of bool
> > queue_logical_block_aligned(q, x), but even then it doesn't seem worth
> > the bits.
