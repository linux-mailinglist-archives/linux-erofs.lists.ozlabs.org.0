Return-Path: <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>
X-Original-To: lists+linux-erofs@lfdr.de
Delivered-To: lists+linux-erofs@lfdr.de
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2404:9400:2:0:216:3eff:fee1:b9f1])
	by mail.lfdr.de (Postfix) with ESMTPS id 7858F58DEA9
	for <lists+linux-erofs@lfdr.de>; Tue,  9 Aug 2022 20:21:35 +0200 (CEST)
Received: from boromir.ozlabs.org (localhost [IPv6:::1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4M2LxT2BtNz306m
	for <lists+linux-erofs@lfdr.de>; Wed, 10 Aug 2022 04:21:33 +1000 (AEST)
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20201202 header.b=SB+iROhU;
	dkim-atps=neutral
X-Original-To: linux-erofs@lists.ozlabs.org
Delivered-To: linux-erofs@lists.ozlabs.org
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=kernel.org (client-ip=145.40.68.75; helo=ams.source.kernel.org; envelope-from=xiang@kernel.org; receiver=<UNKNOWN>)
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20201202 header.b=SB+iROhU;
	dkim-atps=neutral
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4M2LxQ3kpgz2xKh
	for <linux-erofs@lists.ozlabs.org>; Wed, 10 Aug 2022 04:21:30 +1000 (AEST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.source.kernel.org (Postfix) with ESMTPS id 0A799B818A5;
	Tue,  9 Aug 2022 18:21:26 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 02873C433D7;
	Tue,  9 Aug 2022 18:21:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1660069284;
	bh=SB6XkLDysY4dVuzlqY/wOcyuiBTtmmJRu9LdUDL+gQU=;
	h=Date:From:To:Subject:References:In-Reply-To:From;
	b=SB+iROhUWZIvpKsKtzMcJ9aK+EbsPfZJWp7zf+RA2ph5gmKdlEogNd/IQJadvvBNB
	 uXnYi2k10tqcSIK4CweY7FtkIIvDFhfsU1T5JUAv13Ml0Tn/FJYiXnNLmgWCfZCMmY
	 fKIcahYqBioP8IOUUkYOX2WM/FfRDpOxErP/+ZcwvRxYZ6+jIYWTkRfBmVpFUCGwC9
	 ljxdFmxPmAohMUSxh7tsgeSthiVg9fwqA9L/s1FfES6K04NbPUJEG31JBbvxsnqB+t
	 6HXfrv+Kz0FcrpyK4qeE8j1i0jVSIRyiTkVIOjCTXEuMuxC0pTUzVFBSL8dSSijlwu
	 Hkk2hVDQiYnTw==
Date: Wed, 10 Aug 2022 02:21:20 +0800
From: Gao Xiang <xiang@kernel.org>
To: Naoto Yamaguchi <wata2ki@gmail.com>, linux-erofs@lists.ozlabs.org
Subject: Re: RFC: erofs-utils:mkfs: add unprivileged container use-case
 support
Message-ID: <YvKloGeAl8R32vEx@debian>
Mail-Followup-To: Naoto Yamaguchi <wata2ki@gmail.com>,
	linux-erofs@lists.ozlabs.org
References: <CABBJnRbpAxGB644x=fBRK5GOrjxYawZE-zrhHnRHQbz5Lzp-CQ@mail.gmail.com>
 <YvKj8aZp/6bg/Nxv@debian>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <YvKj8aZp/6bg/Nxv@debian>
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

On Wed, Aug 10, 2022 at 02:14:09AM +0800, Gao Xiang wrote:
> Hi Naoto,
> 
> On Wed, Aug 10, 2022 at 02:59:42AM +0900, Naoto Yamaguchi wrote:
> > Hi all.
> > 
> > I investigate each read only filesystem for linux at linux container
> > use-case.  The erofs is most interesting filesystem.
> 
> First of all, many thanks for your interest! Yes, now EROFS is actively
> developing for container use cases as well, and we're happy to
> accept/maintain any useful features about this area!
> 
> > A each files of guest root filesystem need to shift uid/gid in case of
> > unprivileged container to use uid/gid namespace.  I work adding
> > uid/gid offsetting support to erofs-utils mkfs tool now.
> > Will be this patch accept in upstream community?
> 
> Could you give more details about this? EROFS already supports idmapped
> mount for container use cases since 5.19, so I guess uid/gid offsets
> can be set by this?

Oh, I guess I've got this.  Yeah, I'm fine to introduce something like
uid or gid offsets as two long options if needed. ;)

Thanks,
Gao Xiang

> 
> I'm still somewhat new to container world, it would be helpful to drop
> more hints of this ;)
> 
> Thanks,
> Gao Xiang
> 
> > 
> > Thanks,
> > Naoto Yamaguchi,
> > a member of Automotive Grade Linux Instrument Cluster EG.
