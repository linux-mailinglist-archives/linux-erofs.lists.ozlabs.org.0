Return-Path: <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>
X-Original-To: lists+linux-erofs@lfdr.de
Delivered-To: lists+linux-erofs@lfdr.de
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2404:9400:2:0:216:3eff:fee1:b9f1])
	by mail.lfdr.de (Postfix) with ESMTPS id 65B8775BDC6
	for <lists+linux-erofs@lfdr.de>; Fri, 21 Jul 2023 07:29:43 +0200 (CEST)
Authentication-Results: lists.ozlabs.org;
	dkim=fail reason="signature verification failed" (1024-bit key; unprotected) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.a=rsa-sha256 header.s=korg header.b=uOsGheJ3;
	dkim-atps=neutral
Received: from boromir.ozlabs.org (localhost [IPv6:::1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4R6dR92C3Dz3bcP
	for <lists+linux-erofs@lfdr.de>; Fri, 21 Jul 2023 15:29:41 +1000 (AEST)
X-Original-To: linux-erofs@lists.ozlabs.org
Delivered-To: linux-erofs@lists.ozlabs.org
Authentication-Results: lists.ozlabs.org;
	dkim=pass (1024-bit key; unprotected) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.a=rsa-sha256 header.s=korg header.b=uOsGheJ3;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=linuxfoundation.org (client-ip=2604:1380:4641:c500::1; helo=dfw.source.kernel.org; envelope-from=gregkh@linuxfoundation.org; receiver=lists.ozlabs.org)
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4R6dR51D1yz2ypx
	for <linux-erofs@lists.ozlabs.org>; Fri, 21 Jul 2023 15:29:36 +1000 (AEST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits))
	(No client certificate requested)
	by dfw.source.kernel.org (Postfix) with ESMTPS id C4FB36106D;
	Fri, 21 Jul 2023 05:29:31 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id ADE5DC433C7;
	Fri, 21 Jul 2023 05:29:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1689917371;
	bh=tuJeRgv7TQnIDYC22XsvhrtB1NsxJJcI8Voy1qzUk7Y=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=uOsGheJ3Zu5txt/o9FqthtwaVa//QAdmpBWH99K8J/rlRkxCXgXR9vbbX+SSJkeb2
	 DfWLEWotewqRjH0z9modii95ubeRa6fiESnhnhT6UG3rhSsr4/8MpyELzj/BT7C7Vx
	 RCXSOtphjJ3tc9mPrj7fEPLUFM837igcfOX9BZ2g=
Date: Fri, 21 Jul 2023 07:29:26 +0200
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: Gao Xiang <hsiangkao@linux.alibaba.com>
Subject: Re: [PATCH stable 5.15.y] erofs: fix compact 4B support for 16k
 block size
Message-ID: <2023072115-problem-cleaver-9f4b@gregkh>
References: <20230721022221.23060-1-hsiangkao@linux.alibaba.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230721022221.23060-1-hsiangkao@linux.alibaba.com>
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
Cc: linux-erofs@lists.ozlabs.org, stable@vger.kernel.org
Errors-To: linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org
Sender: "Linux-erofs" <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>

On Fri, Jul 21, 2023 at 10:22:21AM +0800, Gao Xiang wrote:
> commit 001b8ccd0650727e54ec16ef72bf1b8eeab7168e upstream.
> 
> In compact 4B, two adjacent lclusters are packed together as a unit to
> form on-disk indexes for effective random access, as below:
> 
> (amortized = 4, vcnt = 2)
>        _____________________________________________
>       |___@_____ encoded bits __________|_ blkaddr _|
>       0        .                                    amortized * vcnt = 8
>       .             .
>       .                  .              amortized * vcnt - 4 = 4
>       .                        .
>       .____________________________.
>       |_type (2 bits)_|_clusterofs_|
> 
> Therefore, encoded bits for each pack are 32 bits (4 bytes). IOWs,
> since each lcluster can get 16 bits for its type and clusterofs, the
> maximum supported lclustersize for compact 4B format is 16k (14 bits).
> 
> Fix this to enable compact 4B format for 16k lclusters (blocks), which
> is tested on an arm64 server with 16k page size.
> 
> Fixes: 152a333a5895 ("staging: erofs: add compacted compression indexes support")
> Link: https://lore.kernel.org/r/20230601112341.56960-1-hsiangkao@linux.alibaba.com
> Signed-off-by: Gao Xiang <hsiangkao@linux.alibaba.com>
> ---
> resolve a trivial conflict.

All now queued up.

thanks,

greg k-h
