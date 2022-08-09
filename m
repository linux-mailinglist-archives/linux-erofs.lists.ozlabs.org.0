Return-Path: <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>
X-Original-To: lists+linux-erofs@lfdr.de
Delivered-To: lists+linux-erofs@lfdr.de
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2404:9400:2:0:216:3eff:fee1:b9f1])
	by mail.lfdr.de (Postfix) with ESMTPS id CFDAE58DE5D
	for <lists+linux-erofs@lfdr.de>; Tue,  9 Aug 2022 20:14:26 +0200 (CEST)
Received: from boromir.ozlabs.org (localhost [IPv6:::1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4M2LnD4t1zz306m
	for <lists+linux-erofs@lfdr.de>; Wed, 10 Aug 2022 04:14:24 +1000 (AEST)
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20201202 header.b=t7GJvmBD;
	dkim-atps=neutral
X-Original-To: linux-erofs@lists.ozlabs.org
Delivered-To: linux-erofs@lists.ozlabs.org
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=kernel.org (client-ip=139.178.84.217; helo=dfw.source.kernel.org; envelope-from=xiang@kernel.org; receiver=<UNKNOWN>)
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20201202 header.b=t7GJvmBD;
	dkim-atps=neutral
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4M2Ln6008Kz2xKh
	for <linux-erofs@lists.ozlabs.org>; Wed, 10 Aug 2022 04:14:17 +1000 (AEST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.source.kernel.org (Postfix) with ESMTPS id 1D43F61139;
	Tue,  9 Aug 2022 18:14:14 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0539FC433D6;
	Tue,  9 Aug 2022 18:14:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1660068853;
	bh=KwXhJdbDx5tMFFVQpOxN5q2eUYWE2D5mzNx6+CMbCWc=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=t7GJvmBD0AKjFMERLerSligtWDvpVlAUcZuH0GstCBo231C/wFHMcIxGGNbNdG14Y
	 OkA19wTuM4UHJrDz3TIPEVILatOwxkm1XScFGTmAVhVqRy7DE/cNfjKw4ssmuMYak4
	 SdMbZZ7drC5Ejo0EO/JuEt0iKACn0xADfmy/TYthqLpiepV07ACoEzqePIbwf4QA7P
	 OFTiB7ngO4v887jluR8F0LmtfUrR908XEhHFJna7qEWzasYLGNSL7lVYwHJ2DDRalp
	 FitZ/5MCFG4pFqvVEoSjNtmo8IdvtFPEZ1qLc4cHedZXnKn6EiXGwZ4zugGe1Fwel4
	 v/c6JCeMZ0xWw==
Date: Wed, 10 Aug 2022 02:14:09 +0800
From: Gao Xiang <xiang@kernel.org>
To: Naoto Yamaguchi <wata2ki@gmail.com>
Subject: Re: RFC: erofs-utils:mkfs: add unprivileged container use-case
 support
Message-ID: <YvKj8aZp/6bg/Nxv@debian>
Mail-Followup-To: Naoto Yamaguchi <wata2ki@gmail.com>,
	linux-erofs@lists.ozlabs.org
References: <CABBJnRbpAxGB644x=fBRK5GOrjxYawZE-zrhHnRHQbz5Lzp-CQ@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <CABBJnRbpAxGB644x=fBRK5GOrjxYawZE-zrhHnRHQbz5Lzp-CQ@mail.gmail.com>
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
Cc: linux-erofs@lists.ozlabs.org
Errors-To: linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org
Sender: "Linux-erofs" <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>

Hi Naoto,

On Wed, Aug 10, 2022 at 02:59:42AM +0900, Naoto Yamaguchi wrote:
> Hi all.
> 
> I investigate each read only filesystem for linux at linux container
> use-case.  The erofs is most interesting filesystem.

First of all, many thanks for your interest! Yes, now EROFS is actively
developing for container use cases as well, and we're happy to
accept/maintain any useful features about this area!

> A each files of guest root filesystem need to shift uid/gid in case of
> unprivileged container to use uid/gid namespace.  I work adding
> uid/gid offsetting support to erofs-utils mkfs tool now.
> Will be this patch accept in upstream community?

Could you give more details about this? EROFS already supports idmapped
mount for container use cases since 5.19, so I guess uid/gid offsets
can be set by this?

I'm still somewhat new to container world, it would be helpful to drop
more hints of this ;)

Thanks,
Gao Xiang

> 
> Thanks,
> Naoto Yamaguchi,
> a member of Automotive Grade Linux Instrument Cluster EG.
