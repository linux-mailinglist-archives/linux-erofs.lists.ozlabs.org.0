Return-Path: <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>
X-Original-To: lists+linux-erofs@lfdr.de
Delivered-To: lists+linux-erofs@lfdr.de
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2404:9400:2:0:216:3eff:fee1:b9f1])
	by mail.lfdr.de (Postfix) with ESMTPS id 05CC7790614
	for <lists+linux-erofs@lfdr.de>; Sat,  2 Sep 2023 10:20:12 +0200 (CEST)
Authentication-Results: lists.ozlabs.org;
	dkim=fail reason="signature verification failed" (1024-bit key; unprotected) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.a=rsa-sha256 header.s=korg header.b=rkWAQIBx;
	dkim-atps=neutral
Received: from boromir.ozlabs.org (localhost [IPv6:::1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4Rd79z6jTWz3bVS
	for <lists+linux-erofs@lfdr.de>; Sat,  2 Sep 2023 18:20:07 +1000 (AEST)
X-Original-To: linux-erofs@lists.ozlabs.org
Delivered-To: linux-erofs@lists.ozlabs.org
Authentication-Results: lists.ozlabs.org;
	dkim=pass (1024-bit key; unprotected) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.a=rsa-sha256 header.s=korg header.b=rkWAQIBx;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=linuxfoundation.org (client-ip=2604:1380:4641:c500::1; helo=dfw.source.kernel.org; envelope-from=gregkh@linuxfoundation.org; receiver=lists.ozlabs.org)
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4Rd79r6wyZz2ygT
	for <linux-erofs@lists.ozlabs.org>; Sat,  2 Sep 2023 18:20:00 +1000 (AEST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits))
	(No client certificate requested)
	by dfw.source.kernel.org (Postfix) with ESMTPS id B55A760281;
	Sat,  2 Sep 2023 08:19:58 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C3E0DC433C7;
	Sat,  2 Sep 2023 08:19:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1693642798;
	bh=H0jZqmHxH11HljCzA78hnoFPkjwFhKanZixbXINjobs=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=rkWAQIBxh+9EERTp4a5XHaPfTjO6yHFovioiIz4JRZdC5nZbd4AZAWgpnVrOxiPje
	 HJZHuq6I0x2SAN5cRKt6SNZfiV5RipnFdhuauEJKpsMjn9Hrg17mz4lSMhc/wtryfK
	 JIrAhbfd7ZCu3Z2GB283X6ctWfFO5ugSAY5dqWX8=
Date: Sat, 2 Sep 2023 10:19:55 +0200
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: Gao Xiang <hsiangkao@linux.alibaba.com>
Subject: Re: [PATCH 6.5.y] erofs: ensure that the post-EOF tails are all
 zeroed
Message-ID: <2023090247-consonant-hangnail-ef8c@gregkh>
References: <20230831112959.99884-1-hsiangkao@linux.alibaba.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230831112959.99884-1-hsiangkao@linux.alibaba.com>
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
Cc: linux-erofs@lists.ozlabs.org, stable@vger.kernel.org, keltargw <keltar.gw@gmail.com>
Errors-To: linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org
Sender: "Linux-erofs" <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>

On Thu, Aug 31, 2023 at 07:29:53PM +0800, Gao Xiang wrote:
> commit e4c1cf523d820730a86cae2c6d55924833b6f7ac upstream.
> 
> This was accidentally fixed up in commit e4c1cf523d82 but we can't
> take the full change due to other dependancy issues, so here is just
> the actual bugfix that is needed.
> 
> [Background]
> 
> keltargw reported an issue [1] that with mmaped I/Os, sometimes the
> tail of the last page (after file ends) is not filled with zeroes.
> 
> The root cause is that such tail page could be wrongly selected for
> inplace I/Os so the zeroed part will then be filled with compressed
> data instead of zeroes.
> 
> A simple fix is to avoid doing inplace I/Os for such tail parts,
> actually that was already fixed upstream in commit e4c1cf523d82
> ("erofs: tidy up z_erofs_do_read_page()") by accident.
> 
> [1] https://lore.kernel.org/r/3ad8b469-25db-a297-21f9-75db2d6ad224@linux.alibaba.com
> 
> Reported-by: keltargw <keltar.gw@gmail.com>
> Fixes: 3883a79abd02 ("staging: erofs: introduce VLE decompression support")
> Signed-off-by: Gao Xiang <hsiangkao@linux.alibaba.com>
> ---
>  fs/erofs/zdata.c | 2 ++
>  1 file changed, 2 insertions(+)

All now queued up, thanks.

greg k-h
