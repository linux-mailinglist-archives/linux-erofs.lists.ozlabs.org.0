Return-Path: <linux-erofs+bounces-604-lists+linux-erofs=lfdr.de@lists.ozlabs.org>
X-Original-To: lists+linux-erofs@lfdr.de
Delivered-To: lists+linux-erofs@lfdr.de
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	by mail.lfdr.de (Postfix) with ESMTPS id 5424FB03398
	for <lists+linux-erofs@lfdr.de>; Mon, 14 Jul 2025 02:18:49 +0200 (CEST)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4bgNGF1qQkz3bkT;
	Mon, 14 Jul 2025 10:18:45 +1000 (AEST)
X-Original-To: linux-erofs@lists.ozlabs.org
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip="2600:3c04:e001:324:0:1991:8:25"
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1752452325;
	cv=none; b=U6001YJSCA8qjDUxz1YVXmG3t/lgs0KQkwKdMOu0Q/csPVVVLr4Qu1TAvte0XL+wfa1qsooFxKLGiD5kazk7Hz1oAcSfbJEOkHgo0e1yreRYxc+lGDB0BaMki1uKWgue1aucCmlHKoEhfNCMtHuVbQ//d4Ag6q7wCGwxbR6HER4hBBCKBH14nyydWL/flGr6u0qphn94cr9eNEY34mrV52nq34iaPBxNmEv88ZbhjyvROUngFb4GF4qMZCy6fxscEIUzNP+xpLvHMhf6mH1AZWfU4c1dIdmdJd/4pFttx/pbKOzJ97ZEla5ixMOMGAmSJZORrBiE8ZqwX1PFdaf5Fg==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1752452325; c=relaxed/relaxed;
	bh=vuM/Ap9VLHxy8/hPxIe78tNirZAXEaKXlJE7VQb9PS4=;
	h=Date:From:To:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ZOYhA/D2ju0XEyQj4M1g+3vdV6WLagM9yHuCUQmue9yTTqZk+v2pjyLov6N6Bb2dtiZlyyEjgnnYg7Oy+EByiFb3vhLlZn9mH4phTQsk6jWa9zvgNnMlHgqP0GzvrJGmCL5qCXe2yeerRQ688E/sVDDOclWulrzehrGUTUEWY7nlfEQKC5sZqerB/R8sDrYJ0vy0PyxhEtkbZPsA3eEZ66d+DjMQ+drUivWFxkg9he9Wthyl5Yoh+E1XW6bNp8877FGnukz55Ir5E4KfL2RgZJXC06L9c7EHNvd7C1JOjqVTMfAKRAHPAZxXJ8JKLGSct42yDqtjGl2ZBnQTZPlHLQ==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=kernel.org; dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20201202 header.b=o+WC4i/6; dkim-atps=neutral; spf=pass (client-ip=2600:3c04:e001:324:0:1991:8:25; helo=tor.source.kernel.org; envelope-from=xiang@kernel.org; receiver=lists.ozlabs.org) smtp.mailfrom=kernel.org
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=kernel.org
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20201202 header.b=o+WC4i/6;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=kernel.org (client-ip=2600:3c04:e001:324:0:1991:8:25; helo=tor.source.kernel.org; envelope-from=xiang@kernel.org; receiver=lists.ozlabs.org)
Received: from tor.source.kernel.org (tor.source.kernel.org [IPv6:2600:3c04:e001:324:0:1991:8:25])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4bgNGD3FR2z3bkP
	for <linux-erofs@lists.ozlabs.org>; Mon, 14 Jul 2025 10:18:44 +1000 (AEST)
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
	by tor.source.kernel.org (Postfix) with ESMTP id B98066111C;
	Mon, 14 Jul 2025 00:18:41 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DE742C4CEE3;
	Mon, 14 Jul 2025 00:18:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1752452321;
	bh=h2+0V98exKY62H08z3DXcxGkO4V9451i1CArP1KTEdE=;
	h=Date:From:To:Subject:References:In-Reply-To:From;
	b=o+WC4i/6GMEr1AqZur0GGZ1O0lYo7A1AoqXlOYiDe8fCgWd0EEJ6E1WhZy3qmV/A7
	 M4AHtRIB1O14HrroGX1LvBUFirNCH+l82Ww/Ojvpi7h8PVc22zxfMFrxNDy/X8X0hF
	 DPEtZ5XuX/J6DcZOSt+6CPhi9CDJw0lzHvGZh2pd+Cazg7GICUYmirE/RV5CQIFS9z
	 x4hdQV0efdAEhxOETBj5+jeUV3PSBT+8TsmBpFUGx53aVTkaEhLlmPm489a0grNSCI
	 kx5NFbd7ngV0HlOsWN/uio9XquOLj+cHI7Govt2FRGAOKA8rTNVbJexUHB1xhTAqiI
	 MKoMe0V3pDfCA==
Date: Mon, 14 Jul 2025 08:18:34 +0800
From: Gao Xiang <xiang@kernel.org>
To: Mingye Wang <arthur200126@gmail.com>, hsiangkao@linux.alibaba.com,
	linux-erofs@lists.ozlabs.org, derez@redhat.com
Subject: Re: [feature request] extract a single file from EROFS filesystem
Message-ID: <aHRM2g7y/zNlQDsp@debian>
Mail-Followup-To: Mingye Wang <arthur200126@gmail.com>,
	hsiangkao@linux.alibaba.com, linux-erofs@lists.ozlabs.org,
	derez@redhat.com
References: <CAD66C+YsAUG2Qtt9i5vbn5qPRfE0OHtAwyTUiZJaYrzrkTfYDg@mail.gmail.com>
 <aHRJBVY1r0epiRpy@debian>
X-Mailing-List: linux-erofs@lists.ozlabs.org
List-Id: <linux-erofs.lists.ozlabs.org>
List-Help: <mailto:linux-erofs+help@lists.ozlabs.org>
List-Owner: <mailto:linux-erofs+owner@lists.ozlabs.org>
List-Post: <mailto:linux-erofs@lists.ozlabs.org>
List-Subscribe: <mailto:linux-erofs+subscribe@lists.ozlabs.org>,
  <mailto:linux-erofs+subscribe-digest@lists.ozlabs.org>,
  <mailto:linux-erofs+subscribe-nomail@lists.ozlabs.org>
List-Unsubscribe: <mailto:linux-erofs+unsubscribe@lists.ozlabs.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <aHRJBVY1r0epiRpy@debian>
X-Spam-Status: No, score=-3.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS
	autolearn=disabled version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-25) on lists.ozlabs.org

On Mon, Jul 14, 2025 at 08:02:13AM +0800, Gao Xiang wrote:
> Hi Mingye,
> 
> On Mon, Jul 14, 2025 at 12:55:06AM +0800, Mingye Wang wrote:
> > Hi all,
> > 
> > >Gao Xiang Thu, 09 Jan 2025 01:36:16 -0800
> > >On 2025/1/9 02:14, Daniel Erez wrote:
> > >>Would it be applicable to introduce an option for extracting a specific file
> > >>from the image?
> > >>I.e. something similar to the '-extract-file' option available in unsquashfs tool [2].
> > >I will add this later.
> > 
> > I am seeing a need for a similar feature in making dracut's lsinitrd
> > work... a little better. I should add two cents of my own.
> 
> dump.erofs already supports `--cat` command to dump a single file.
> 
> > 
> > * In "unsquashfs" there's not only '-extract-file' for passing in a
> > list of files, but also a possibility for a list of paths to be
> > specified directly as arguments. This would appear outlandish on an
> > fsck utility.
> 
> Can those be replaced as dump.erofs --cat?
> 
> > * When extracting single files it might be desirable to *not* verify
> > and pretend-extract the other files.
> 
> `fsck.erofs` can be used to dump a subtree in the future (exclude file
> pattern can be applied), fsck/dump/mkfs tools are more common for
> generic filesystems.
> 
> Mimick Squashfs-specific is not EROFS will do since I do see `un`-prefix
> is common and lack of (even defacto) standardization.

In other words, if you care more about a subtree or a whole filesystem
dump, all (sub-)tree metadata/data should be checked first, and that is
what `fsck.erofs` does and the dumped files are only side products for
data verification (because fsck needs to check compressed data is valid
too.)

If you only care about some individual inodes, that is what `dump.erofs`
works, including `--cat` shows inode content, `--ls` shows directory
content, `-e` shows extent map, etc.

Thanks,
Gao Xiang

> 
> Thanks,
> Gao Xiang
> 

