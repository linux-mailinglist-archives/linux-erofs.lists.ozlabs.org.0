Return-Path: <linux-erofs+bounces-603-lists+linux-erofs=lfdr.de@lists.ozlabs.org>
X-Original-To: lists+linux-erofs@lfdr.de
Delivered-To: lists+linux-erofs@lfdr.de
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	by mail.lfdr.de (Postfix) with ESMTPS id C31A7B0338A
	for <lists+linux-erofs@lfdr.de>; Mon, 14 Jul 2025 02:02:25 +0200 (CEST)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4bgMvL33b2z3bh6;
	Mon, 14 Jul 2025 10:02:22 +1000 (AEST)
X-Original-To: linux-erofs@lists.ozlabs.org
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip=172.105.4.254
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1752451342;
	cv=none; b=Q84vK87ZYgQFWkM19iKyANactdCI7jlkoT/0RSyU1qaZO+ww8h0dxvMzBXYvJXv2es0mIHzqt3jYFvFMmzt6P4coJ2JDDpIeY57KwSOhJsnV+JBwVRCUs77z2919TFZba3qd7kau2yMtwoVt/N/alfGMQXh+4FkQXR9bWBoFwOU8bPRDZknXJctk7homfGfXCn0wbiHU9+vOckBM3d4sUkodHh2nns4pBBHfLR8f4UKg2L9I9drtQX8iB+cE0a/2GfP2WZDR+OHtpMCmcf3mvAYspVRVOh4nyNphrFTPWEfZ0OvbF8fl7le2MkiFj0RU4/VOKcsCtRfVlRR+ozTNEQ==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1752451342; c=relaxed/relaxed;
	bh=UqYMPBt11GmFgH3VJiBy1Uzc03wz22u99xVh6u+NJfc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=b3ouQviThGsD4Fjp1lO2Q6cTwjOQeGKn8lUZQwC2oB/6vD8H6rCLPt1xv04bVBlY6DRFXsQmJ73Je0JbzcRuELYyKmXX5ro6DDJVe4NBP1gV4noIDRbJXTDPYkbXaw+kKalcqwYP3K7pB6VStVe/ydKB0rq0KaLMuXg65fREGzyyzgdhhRUQx9z6fJSS52gURzdClk89eWXyCCKMRXOHXTqOAxTMUpCVm7hgYVc2U50de2OqqSRO/jkLT0Hy8iWIJz7a1JFKflTMcJgibr4FTFVILdCmlE1/taYNLlewQVNAe1PRRVs19v9OeGK/JX+2z92RRKru7E0DuwyywwQ37w==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=kernel.org; dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20201202 header.b=JsXnzGFh; dkim-atps=neutral; spf=pass (client-ip=172.105.4.254; helo=tor.source.kernel.org; envelope-from=xiang@kernel.org; receiver=lists.ozlabs.org) smtp.mailfrom=kernel.org
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=kernel.org
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20201202 header.b=JsXnzGFh;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=kernel.org (client-ip=172.105.4.254; helo=tor.source.kernel.org; envelope-from=xiang@kernel.org; receiver=lists.ozlabs.org)
Received: from tor.source.kernel.org (tor.source.kernel.org [172.105.4.254])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4bgMvK4GvJz30Lt
	for <linux-erofs@lists.ozlabs.org>; Mon, 14 Jul 2025 10:02:21 +1000 (AEST)
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
	by tor.source.kernel.org (Postfix) with ESMTP id 457C961130;
	Mon, 14 Jul 2025 00:02:19 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0D57CC4CEE3;
	Mon, 14 Jul 2025 00:02:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1752451338;
	bh=Fqq+fKzWejvAKCF58NUZl2Ez+dooav2W/TYgdeVhSJI=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=JsXnzGFhNEAuw5IZutA6XxGzeApGqyaT+liKGkwlTQBQH9yXhFtqxyklblNw2DFWN
	 36qZ+Yfh4cIxPDObnOVwvHMPfI+OjwRcWHg1pXo1ugHWTCdiJ9cfaghrlaIvG5LLdq
	 SnXSL6kZHke2COVHeHYJCQ10o95dYBzT7h1w76wfJbrcaVDVK0NGfnYLSI9346J05r
	 226a3Ok9qPNh0+Y2ymXEZolbbFCs/4vLLl0R0bkGuBvGKV5i/QtTFWtESWAex6byxA
	 h1nPb4qlo6/tkDtzazDdLwSdvhv+RbnVKTxdikm/KMlHSro3I3VGdCX1MHh7EL18aX
	 CUWX7CWp4H0Ag==
Date: Mon, 14 Jul 2025 08:02:13 +0800
From: Gao Xiang <xiang@kernel.org>
To: Mingye Wang <arthur200126@gmail.com>
Cc: hsiangkao@linux.alibaba.com, linux-erofs@lists.ozlabs.org,
	derez@redhat.com
Subject: Re: [feature request] extract a single file from EROFS filesystem
Message-ID: <aHRJBVY1r0epiRpy@debian>
Mail-Followup-To: Mingye Wang <arthur200126@gmail.com>,
	hsiangkao@linux.alibaba.com, linux-erofs@lists.ozlabs.org,
	derez@redhat.com
References: <CAD66C+YsAUG2Qtt9i5vbn5qPRfE0OHtAwyTUiZJaYrzrkTfYDg@mail.gmail.com>
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
In-Reply-To: <CAD66C+YsAUG2Qtt9i5vbn5qPRfE0OHtAwyTUiZJaYrzrkTfYDg@mail.gmail.com>
X-Spam-Status: No, score=-3.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS
	autolearn=disabled version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-25) on lists.ozlabs.org

Hi Mingye,

On Mon, Jul 14, 2025 at 12:55:06AM +0800, Mingye Wang wrote:
> Hi all,
> 
> >Gao Xiang Thu, 09 Jan 2025 01:36:16 -0800
> >On 2025/1/9 02:14, Daniel Erez wrote:
> >>Would it be applicable to introduce an option for extracting a specific file
> >>from the image?
> >>I.e. something similar to the '-extract-file' option available in unsquashfs tool [2].
> >I will add this later.
> 
> I am seeing a need for a similar feature in making dracut's lsinitrd
> work... a little better. I should add two cents of my own.

dump.erofs already supports `--cat` command to dump a single file.

> 
> * In "unsquashfs" there's not only '-extract-file' for passing in a
> list of files, but also a possibility for a list of paths to be
> specified directly as arguments. This would appear outlandish on an
> fsck utility.

Can those be replaced as dump.erofs --cat?

> * When extracting single files it might be desirable to *not* verify
> and pretend-extract the other files.

`fsck.erofs` can be used to dump a subtree in the future (exclude file
pattern can be applied), fsck/dump/mkfs tools are more common for
generic filesystems.

Mimick Squashfs-specific is not EROFS will do since I do see `un`-prefix
is common and lack of (even defacto) standardization.

Thanks,
Gao Xiang

