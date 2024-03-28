Return-Path: <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>
X-Original-To: lists+linux-erofs@lfdr.de
Delivered-To: lists+linux-erofs@lfdr.de
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2404:9400:2:0:216:3eff:fee1:b9f1])
	by mail.lfdr.de (Postfix) with ESMTPS id 2A87088F5A7
	for <lists+linux-erofs@lfdr.de>; Thu, 28 Mar 2024 03:59:57 +0100 (CET)
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20201202 header.b=U49nNjXS;
	dkim-atps=neutral
Received: from boromir.ozlabs.org (localhost [IPv6:::1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4V4pDV5GfJz3fQR
	for <lists+linux-erofs@lfdr.de>; Thu, 28 Mar 2024 13:59:54 +1100 (AEDT)
X-Original-To: linux-erofs@lists.ozlabs.org
Delivered-To: linux-erofs@lists.ozlabs.org
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20201202 header.b=U49nNjXS;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=kernel.org (client-ip=2604:1380:4641:c500::1; helo=dfw.source.kernel.org; envelope-from=xiang@kernel.org; receiver=lists.ozlabs.org)
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4V4pDN2sX8z2xSl
	for <linux-erofs@lists.ozlabs.org>; Thu, 28 Mar 2024 13:59:48 +1100 (AEDT)
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
	by dfw.source.kernel.org (Postfix) with ESMTP id 8256561210;
	Thu, 28 Mar 2024 02:59:44 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4822EC433F1;
	Thu, 28 Mar 2024 02:59:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1711594784;
	bh=VVeP8CTtDe8h8jUy8vlnsdIeVmc+EAfEED4o1DOv/O0=;
	h=Date:From:To:Subject:References:In-Reply-To:From;
	b=U49nNjXSPd08fEh9AsFsgFIJj2L0IJbrFeCFPSfKLki48JngA0t+vQA+3d8+QD8n9
	 7cXfgUOuZnjlJjaFrfe+oszypbyz3xLZHdQqKSIhkAFVjCeOVf2mznwg//Ja5DRm0I
	 Ca9IGXux5W1SSCgPs3G4uaOI13yBdxr+JAmJF6Xvl4LGK6Z3DQNNG6e64Aib4uiuT5
	 mLVAhVZTqCQTfg+/Mdz/OOV0rjhL2G7m9VRoIABzlhoiktXgBA47k67A74skUEgxz0
	 uSyQm0toAAQr6dymYDFKA/RSYUcs6tfqpYxNdXqCm6ThxbFECB6z+o3Eux69ESs4PH
	 fUpvAUWIjRMhQ==
Date: Thu, 28 Mar 2024 10:59:38 +0800
From: Gao Xiang <xiang@kernel.org>
To: Linus Torvalds <torvalds@linuxfoundation.org>,
	linux-erofs@lists.ozlabs.org, LKML <linux-kernel@vger.kernel.org>,
	Sandeep Dhavale <dhavale@google.com>, Chao Yu <chao@kernel.org>,
	Jingbo Xu <jefflexu@linux.alibaba.com>, Yue Hu <zbestahu@gmail.com>
Subject: Re: [GIT PULL] erofs fixes for 6.9-rc2
Message-ID: <ZgTdGoyTyCc+CrfL@debian>
Mail-Followup-To: Linus Torvalds <torvalds@linuxfoundation.org>,
	linux-erofs@lists.ozlabs.org, LKML <linux-kernel@vger.kernel.org>,
	Sandeep Dhavale <dhavale@google.com>, Chao Yu <chao@kernel.org>,
	Jingbo Xu <jefflexu@linux.alibaba.com>, Yue Hu <zbestahu@gmail.com>
References: <ZgTb62/wsjacMpC8@debian>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <ZgTb62/wsjacMpC8@debian>
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
Errors-To: linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org
Sender: "Linux-erofs" <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>

Hi Linus,

Sorry about missing a title due to my careless.  My apologizes...

On Thu, Mar 28, 2024 at 10:54:40AM +0800, Gao Xiang wrote:
> Could you consider this pull request for 6.9-rc2?
> 
> Just two minor informative patches.  One adds Sandeep Dhavale as a new
> reviewer who could help review some patches for EROFS filesystem
> project, and we believe the project itself will become more diverse and
> healthier as long as warm-hearted folks take a bit more time on this.
> 
> The other patch drops experimental warning for FSDAX since it's already
> used for memory sharing between hosts and guests.
> 
> All commits have been in -next and no potential merge conflict is
> observed.
> 
> Thanks,
> Gao Xiang
> 
> The following changes since commit 4cece764965020c22cff7665b18a012006359095:
> 
>   Linux 6.9-rc1 (2024-03-24 14:10:05 -0700)
> 
> are available in the Git repository at:
> 
>   git://git.kernel.org/pub/scm/linux/kernel/git/xiang/erofs.git tags/erofs-for-6.9-rc2-fixes
> 
> for you to fetch changes up to 7557d296ad439f66a87cd34917af2a4172517826:
> 
>   MAINTAINERS: erofs: add myself as reviewer (2024-03-25 10:57:28 +0800)
> 
> ----------------------------------------------------------------
> Changes since last update:
> 
>  - Add a new reviewer Sandeep Dhavale to build a healthier community;
> 
>  - Drop experimental warning for FSDAX.
> 
> ----------------------------------------------------------------
> Gao Xiang (1):
>       erofs: drop experimental warning for FSDAX
> 
> Sandeep Dhavale (1):
>       MAINTAINERS: erofs: add myself as reviewer
> 
>  MAINTAINERS      | 1 +
>  fs/erofs/super.c | 1 -
>  2 files changed, 1 insertion(+), 1 deletion(-)
