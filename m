Return-Path: <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>
X-Original-To: lists+linux-erofs@lfdr.de
Delivered-To: lists+linux-erofs@lfdr.de
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2404:9400:2:0:216:3eff:fee1:b9f1])
	by mail.lfdr.de (Postfix) with ESMTPS id 1293091A7C4
	for <lists+linux-erofs@lfdr.de>; Thu, 27 Jun 2024 15:22:39 +0200 (CEST)
Authentication-Results: lists.ozlabs.org;
	dkim=fail reason="signature verification failed" (1024-bit key; unprotected) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.a=rsa-sha256 header.s=korg header.b=h8YO5KuK;
	dkim-atps=neutral
Received: from boromir.ozlabs.org (localhost [IPv6:::1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4W8zkz4FCHz3cWR
	for <lists+linux-erofs@lfdr.de>; Thu, 27 Jun 2024 23:22:35 +1000 (AEST)
X-Original-To: linux-erofs@lists.ozlabs.org
Delivered-To: linux-erofs@lists.ozlabs.org
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: lists.ozlabs.org;
	dkim=pass (1024-bit key; unprotected) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.a=rsa-sha256 header.s=korg header.b=h8YO5KuK;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=linuxfoundation.org (client-ip=139.178.84.217; helo=dfw.source.kernel.org; envelope-from=gregkh@linuxfoundation.org; receiver=lists.ozlabs.org)
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4W8zkv32vXz3cQL
	for <linux-erofs@lists.ozlabs.org>; Thu, 27 Jun 2024 23:22:31 +1000 (AEST)
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
	by dfw.source.kernel.org (Postfix) with ESMTP id 1007461E3B;
	Thu, 27 Jun 2024 13:22:30 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 668ECC2BBFC;
	Thu, 27 Jun 2024 13:22:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1719494549;
	bh=cTMdxmivcCeR2e9B0Wl3+VQBVRXtRCNrMLz+1spZZ4w=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=h8YO5KuKuveMlXPrvAk3iiOxlj9YvaFrFqJ3kKIQNdmrf7tw2oGtWu7UBQ1RJiorD
	 ORRbW3lY8WgVeJf5oEmBbVPNraRaPvCfBokFBMU41SHjWrG+vXoPjDp7bpBan/w8av
	 ZUHLP4c5Ry7aCQFnLTppJc0j+55mirYV2GhxDwmU=
Date: Thu, 27 Jun 2024 15:22:23 +0200
From: Greg KH <gregkh@linuxfoundation.org>
To: Gao Xiang <hsiangkao@linux.alibaba.com>
Subject: Re: [PATCH v6.6] erofs: fix NULL dereference of dif->bdev_handle in
 fscache mode
Message-ID: <2024062757-throwaway-frugality-0637@gregkh>
References: <20240627091345.3569167-1-lihongbo22@huawei.com>
 <c1426293-7a86-49fd-a807-d577438a7828@huawei.com>
 <9e81761d-e769-4b14-b72c-77b74e707364@linux.alibaba.com>
 <2a427366-0f63-4024-a3b3-759a4f902061@linux.alibaba.com>
 <2024062733-cradle-imprecise-002f@gregkh>
 <2abcf8cf-5cfc-4932-a544-ee0788bb2ed3@linux.alibaba.com>
 <32dce802-692f-4050-b153-d5c4541fd835@linux.alibaba.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <32dce802-692f-4050-b153-d5c4541fd835@linux.alibaba.com>
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

On Thu, Jun 27, 2024 at 08:51:37PM +0800, Gao Xiang wrote:
> 
> 
> On 2024/6/27 20:36, Gao Xiang wrote:
> > Hi Greg,
> > 
> > On 2024/6/27 19:16, Greg KH wrote:
> 
> ...
> 
> > > 
> > > So what specifically should we do here?
> > 
> > Thanks for the reply..  Honestly I'd like to revert
> > 
> > block: Provide bdev_open_* functions
> > erofs: Convert to use bdev_open_by_path()
> > erofs: fix handling kern_mount() failure
> > 
> > Not quite sure if they can be cleanly reverted, but
> > since the upstream doen't have 'bdev_handle' anymore,
> > I will resend a proper backport for
> > "erofs: fix handling kern_mount() failure".
> 
> Sigh, I just tried and it seems it causes more
> conflicts due to my revert.  It seems another churn..
> 
> Anyway, on 6.6 LTS only the erofs one uses the
> obsolete `struct bdev_handle`, but I think at least
> it doesn't cause some serious issue.
> 
> Hi Greg,
> 
> Could you just pick up Hongbo's backport to resolve
> the NULL dereference issue?

Sure, is that the one earlier in this thread?

And if so, what is the git commit id of it in Linus's tree?

thanks,

greg k-h
