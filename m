Return-Path: <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>
X-Original-To: lists+linux-erofs@lfdr.de
Delivered-To: lists+linux-erofs@lfdr.de
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2404:9400:2:0:216:3eff:fee1:b9f1])
	by mail.lfdr.de (Postfix) with ESMTPS id D37B053DACE
	for <lists+linux-erofs@lfdr.de>; Sun,  5 Jun 2022 10:15:16 +0200 (CEST)
Received: from boromir.ozlabs.org (localhost [IPv6:::1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4LG8Yp0fwXz3bkx
	for <lists+linux-erofs@lfdr.de>; Sun,  5 Jun 2022 18:15:10 +1000 (AEST)
Authentication-Results: lists.ozlabs.org;
	dkim=fail reason="signature verification failed" (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20201202 header.b=XyP7lEsB;
	dkim-atps=neutral
X-Original-To: linux-erofs@lists.ozlabs.org
Delivered-To: linux-erofs@lists.ozlabs.org
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=kernel.org (client-ip=139.178.84.217; helo=dfw.source.kernel.org; envelope-from=xiang@kernel.org; receiver=<UNKNOWN>)
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20201202 header.b=XyP7lEsB;
	dkim-atps=neutral
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4LG8Yf3dfRz305C
	for <linux-erofs@lists.ozlabs.org>; Sun,  5 Jun 2022 18:15:02 +1000 (AEST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.source.kernel.org (Postfix) with ESMTPS id 89D8E60E8B;
	Sun,  5 Jun 2022 08:14:58 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3DE3CC385A5;
	Sun,  5 Jun 2022 08:14:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1654416897;
	bh=MVT+s05L0sIcigbzPpxbYbcLSi9Rg2+EkvlahjbY9Ys=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=XyP7lEsB+ml1VJ6Gr22ZBFqZTKjU9+0jat0laXUBKh/ZeoEC+9AbCD4mxN+W3Y+Yn
	 QzmJdLdS2oIShWeNJf4yobF5gqq3hK18NJg3i3gnrCVRq6k3HKYv9QGQynnzi3g6mU
	 IptZnYczrEjpbn1Oyrp6xXxE/Ev1KsELjyif2x5/wWv++EKKlYBokiwu/swURxUWq/
	 N5SbFxINcaNekQXOujAofNTrnyhlPVT3D2ac+YZgNiXxbvEVjtnbuu4r9SmPuaEVBU
	 AnoY0eutuA2w9uDZ4lCfqhIItErIs58RWi213v96Dfkl93Yznh0OOUY+L+vU5r4WOP
	 5TXpoLi4S8YDQ==
Date: Sun, 5 Jun 2022 16:14:52 +0800
From: Gao Xiang <xiang@kernel.org>
To: Yue Hu <huyue2@coolpad.com>
Subject: Re: [PATCH] MAINTAINERS: erofs: add myself as reviewer
Message-ID: <Ypxl/MsOGQ6W4Rlf@debian>
Mail-Followup-To: Yue Hu <huyue2@coolpad.com>, xiang@kernel.org,
	chao@kernel.org, linux-erofs@lists.ozlabs.org,
	linux-kernel@vger.kernel.org, zhangwen@coolpad.com,
	shaojunjun@coolpad.com, Jeffle Xu <jefflexu@linux.alibaba.com>
References: <20220605070133.4280-1-huyue2@coolpad.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20220605070133.4280-1-huyue2@coolpad.com>
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
Cc: linux-kernel@vger.kernel.org, zhangwen@coolpad.com, linux-erofs@lists.ozlabs.org, shaojunjun@coolpad.com
Errors-To: linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org
Sender: "Linux-erofs" <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>

Hi Yue,

On Sun, Jun 05, 2022 at 03:02:04PM +0800, Yue Hu wrote:
> I have been doing some erofs patches. Now I have the time and would like
> to help with the reviews.
> 
> Signed-off-by: Yue Hu <huyue2@coolpad.com>

Thanks for working on EROFS these months! Hopefully EROFS could have
a healthier development then...

Acked-by: Gao Xiang <xiang@kernel.org>


+ Jeffle Xu

(BTW, I'd like to request Jeffle as a EROFS reviewer too due to
 the fscache feature. Not sure if he's interested in it...)

Thanks,
Gao Xiang

> ---
>  MAINTAINERS | 1 +
>  1 file changed, 1 insertion(+)
> 
> diff --git a/MAINTAINERS b/MAINTAINERS
> index d2691d8a219f..2d0e28d7773b 100644
> --- a/MAINTAINERS
> +++ b/MAINTAINERS
> @@ -7308,6 +7308,7 @@ F:	include/video/s1d13xxxfb.h
>  EROFS FILE SYSTEM
>  M:	Gao Xiang <xiang@kernel.org>
>  M:	Chao Yu <chao@kernel.org>
> +R:	Yue Hu <huyue2@coolpad.com>
>  L:	linux-erofs@lists.ozlabs.org
>  S:	Maintained
>  T:	git git://git.kernel.org/pub/scm/linux/kernel/git/xiang/erofs.git
> -- 
> 2.17.1
