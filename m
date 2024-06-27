Return-Path: <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>
X-Original-To: lists+linux-erofs@lfdr.de
Delivered-To: lists+linux-erofs@lfdr.de
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	by mail.lfdr.de (Postfix) with ESMTPS id 0351091A4D9
	for <lists+linux-erofs@lfdr.de>; Thu, 27 Jun 2024 13:16:35 +0200 (CEST)
Authentication-Results: lists.ozlabs.org;
	dkim=fail reason="signature verification failed" (1024-bit key; unprotected) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.a=rsa-sha256 header.s=korg header.b=LdcxQjCF;
	dkim-atps=neutral
Received: from boromir.ozlabs.org (localhost [IPv6:::1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4W8wxW3f3Tz3cbg
	for <lists+linux-erofs@lfdr.de>; Thu, 27 Jun 2024 21:16:31 +1000 (AEST)
X-Original-To: linux-erofs@lists.ozlabs.org
Delivered-To: linux-erofs@lists.ozlabs.org
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: lists.ozlabs.org;
	dkim=pass (1024-bit key; unprotected) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.a=rsa-sha256 header.s=korg header.b=LdcxQjCF;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=linuxfoundation.org (client-ip=139.178.84.217; helo=dfw.source.kernel.org; envelope-from=gregkh@linuxfoundation.org; receiver=lists.ozlabs.org)
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits))
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4W8wxR4By1z3cXM
	for <linux-erofs@lists.ozlabs.org>; Thu, 27 Jun 2024 21:16:26 +1000 (AEST)
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
	by dfw.source.kernel.org (Postfix) with ESMTP id 0E7C061E15;
	Thu, 27 Jun 2024 11:16:26 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C9F3AC2BBFC;
	Thu, 27 Jun 2024 11:16:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1719486985;
	bh=b+2zkZJMxLRsas1y0NBoWApaQFzJoAR5052Papo6VFI=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=LdcxQjCFqUxip9EmdhgguuxuW2gVXHkZxJD3apSIT62Bu28+bzhMOqNAWgNtA69ap
	 g7g/j8NDbf0oLQ69TBf3axrPMs6ARKT6PvxS243Hkmf1KK+f5U4dQ6u5RBf2swUZX5
	 CHIt6BbZ2m/JuWL7IJ27uyHekd1HCvlELIw1gP88=
Date: Thu, 27 Jun 2024 13:16:20 +0200
From: Greg KH <gregkh@linuxfoundation.org>
To: Gao Xiang <hsiangkao@linux.alibaba.com>
Subject: Re: [PATCH v6.6] erofs: fix NULL dereference of dif->bdev_handle in
 fscache mode
Message-ID: <2024062733-cradle-imprecise-002f@gregkh>
References: <20240627091345.3569167-1-lihongbo22@huawei.com>
 <c1426293-7a86-49fd-a807-d577438a7828@huawei.com>
 <9e81761d-e769-4b14-b72c-77b74e707364@linux.alibaba.com>
 <2a427366-0f63-4024-a3b3-759a4f902061@linux.alibaba.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <2a427366-0f63-4024-a3b3-759a4f902061@linux.alibaba.com>
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
Cc: brauner@kernel.org, jack@suse.cz, huyue2@coolpad.com, linux-erofs@lists.ozlabs.org
Errors-To: linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org
Sender: "Linux-erofs" <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>

On Thu, Jun 27, 2024 at 05:50:26PM +0800, Gao Xiang wrote:
> 
> 
> On 2024/6/27 17:35, Gao Xiang wrote:
> > 
> > 
> > On 2024/6/27 17:11, Hongbo Li wrote:
> 
> ..
> 
> > > 
> > > The reason is the same with 8bd90b6ae7856("erofs: fix NULL dereference of dif->bdev_handle in fscache mode") in mainline. So we should backport this
> > > patch into stable linux-6.6.y to avoid this bug.
> > 
> > Yes, commit 8bd90b6ae785 should be backported to
> > Linux 6.6.y LTS immediately.
> 
> BTW, It seems that
> 
> commit "erofs: Convert to use bdev_open_by_path()" was
> backported as a dependency since v6.6.23 even I
> explicitly commented that this patch is unnecessary
> and I tend to manually backport instead as below:
> 
> https://lore.kernel.org/r/ZgDHG8Ucl3EkY4ZS@debian
> 
> 
> However, my comment was eventually ignored and
> some other related fix like
> "erofs: fix NULL dereference of dif->bdev_handle in fscache mode"
> 
> wasn't backported along with
> "erofs: Convert to use bdev_open_by_path()"

Sorry, I missed that somehow, my fault.

> So the affected 6.6 LTS versions seem to be
> v6.6.23 ~ v6.6.35 (current)

So what specifically should we do here?

thanks,

greg k-h
