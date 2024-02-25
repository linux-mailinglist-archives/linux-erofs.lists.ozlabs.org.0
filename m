Return-Path: <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>
X-Original-To: lists+linux-erofs@lfdr.de
Delivered-To: lists+linux-erofs@lfdr.de
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	by mail.lfdr.de (Postfix) with ESMTPS id CB1A18629FD
	for <lists+linux-erofs@lfdr.de>; Sun, 25 Feb 2024 11:46:10 +0100 (CET)
Authentication-Results: lists.ozlabs.org;
	dkim=fail reason="signature verification failed" (1024-bit key; unprotected) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.a=rsa-sha256 header.s=korg header.b=bElAIKkS;
	dkim-atps=neutral
Received: from boromir.ozlabs.org (localhost [IPv6:::1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4TjL572MdTz3cDt
	for <lists+linux-erofs@lfdr.de>; Sun, 25 Feb 2024 21:46:03 +1100 (AEDT)
X-Original-To: linux-erofs@lists.ozlabs.org
Delivered-To: linux-erofs@lists.ozlabs.org
Authentication-Results: lists.ozlabs.org;
	dkim=pass (1024-bit key; unprotected) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.a=rsa-sha256 header.s=korg header.b=bElAIKkS;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=linuxfoundation.org (client-ip=2604:1380:4641:c500::1; helo=dfw.source.kernel.org; envelope-from=gregkh@linuxfoundation.org; receiver=lists.ozlabs.org)
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4TjL4y4t2Jz3bnB
	for <linux-erofs@lists.ozlabs.org>; Sun, 25 Feb 2024 21:45:53 +1100 (AEDT)
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
	by dfw.source.kernel.org (Postfix) with ESMTP id 62ADD60BD4;
	Sun, 25 Feb 2024 10:45:49 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B0C45C433C7;
	Sun, 25 Feb 2024 10:45:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1708857949;
	bh=xaEEwq+zhwXXlXUsjzZ1qKHdigMxUKVoFzGsp+eDLQo=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=bElAIKkS0nZ5nI2Igh69rC7Xfk/xt7Sv1fU0GpVr6WHie65ArcfLGblmx6+f/eKmd
	 1pSeTX+oGvXb8s3DWKZG03NiGEHdFFSX/1jgRFPa/78p05yW8jC5DAwAZD1GaVUSXk
	 Y92kQYZ+TjMbOJNcWv1CPzKKjKWU02x1ncaGURW4=
Date: Sun, 25 Feb 2024 11:45:43 +0100
From: Greg KH <gregkh@linuxfoundation.org>
To: Gao Xiang <hsiangkao@linux.alibaba.com>
Subject: Re: [PATCH 5.10.y] erofs: fix lz4 inplace decompression
Message-ID: <2024022527-voicing-overbite-04be@gregkh>
References: <2024012650-altitude-gush-572f@gregkh>
 <20240224063248.2157885-1-hsiangkao@linux.alibaba.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240224063248.2157885-1-hsiangkao@linux.alibaba.com>
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
Cc: Juhyung Park <qkrwngud825@gmail.com>, Yifan Zhao <zhaoyifan@sjtu.edu.cn>, linux-erofs@lists.ozlabs.org, stable@vger.kernel.org
Errors-To: linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org
Sender: "Linux-erofs" <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>

On Sat, Feb 24, 2024 at 02:32:48PM +0800, Gao Xiang wrote:
> commit 3c12466b6b7bf1e56f9b32c366a3d83d87afb4de upstream.
> 
> Currently EROFS can map another compressed buffer for inplace
> decompression, that was used to handle the cases that some pages of
> compressed data are actually not in-place I/O.
> 
> However, like most simple LZ77 algorithms, LZ4 expects the compressed
> data is arranged at the end of the decompressed buffer and it
> explicitly uses memmove() to handle overlapping:
>   __________________________________________________________
>  |_ direction of decompression --> ____ |_ compressed data _|
> 
> Although EROFS arranges compressed data like this, it typically maps two
> individual virtual buffers so the relative order is uncertain.
> Previously, it was hardly observed since LZ4 only uses memmove() for
> short overlapped literals and x86/arm64 memmove implementations seem to
> completely cover it up and they don't have this issue.  Juhyung reported
> that EROFS data corruption can be found on a new Intel x86 processor.
> After some analysis, it seems that recent x86 processors with the new
> FSRM feature expose this issue with "rep movsb".
> 
> Let's strictly use the decompressed buffer for lz4 inplace
> decompression for now.  Later, as an useful improvement, we could try
> to tie up these two buffers together in the correct order.
> 
> Reported-and-tested-by: Juhyung Park <qkrwngud825@gmail.com>
> Closes: https://lore.kernel.org/r/CAD14+f2AVKf8Fa2OO1aAUdDNTDsVzzR6ctU_oJSmTyd6zSYR2Q@mail.gmail.com
> Fixes: 0ffd71bcc3a0 ("staging: erofs: introduce LZ4 decompression inplace")
> Fixes: 598162d05080 ("erofs: support decompress big pcluster for lz4 backend")
> Cc: stable <stable@vger.kernel.org> # 5.4+
> Tested-by: Yifan Zhao <zhaoyifan@sjtu.edu.cn>
> Signed-off-by: Gao Xiang <hsiangkao@linux.alibaba.com>
> Link: https://lore.kernel.org/r/20231206045534.3920847-1-hsiangkao@linux.alibaba.com
> ---
> Adapt 5.10.y codebase due to non-trivial conflicts out of
> recent new features & cleanups.

Both now queued up, thanks.

greg k-h
