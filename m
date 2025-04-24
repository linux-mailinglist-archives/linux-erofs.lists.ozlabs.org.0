Return-Path: <linux-erofs+bounces-231-lists+linux-erofs=lfdr.de@lists.ozlabs.org>
X-Original-To: lists+linux-erofs@lfdr.de
Delivered-To: lists+linux-erofs@lfdr.de
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2404:9400:2:0:216:3eff:fee1:b9f1])
	by mail.lfdr.de (Postfix) with ESMTPS id B2804A9AD92
	for <lists+linux-erofs@lfdr.de>; Thu, 24 Apr 2025 14:36:14 +0200 (CEST)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4ZjwSX3W53z3bnL;
	Thu, 24 Apr 2025 22:36:12 +1000 (AEST)
X-Original-To: linux-erofs@lists.ozlabs.org
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip=139.178.84.217
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1745498172;
	cv=none; b=ga8jVb3pfq9Vtd3lSyjOJ7xv9bL96Rc6S0YTjOyAVolLtIkTGEYrU3Kur2A1CM01SJ6OqWocKrDubZ9yLkmvSAjVVdX2R5au7qRK8IjSaOP8Dv0lLBF3nhtgO5E1eFX+gkUgZNmRgHxSJtrPQ29/ne9WsYaeb/RC2aEY6F5epQKcRFX5C4HC41lFtaFLow7P3XwUlGclp9A1F4waUzhbSAGtsK9msBm6AhZc5929VdlKwdQG+ZXnxoEMyP/acNUOkIRzGhs/gpwSBgoUt6mgrDTcIWKmfHfrQx/v0UdJthLM0FwW/UvguO1nAAsf1wlvk1p/EkLgHTP8a9dhSLBeqA==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1745498172; c=relaxed/relaxed;
	bh=TpccWIASOGr+zIVEKPV01QJ4yrwRzokx05WRReK/Vl8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ohAxR0CETsInhUVblKvXfNxFoOACt0NL8ErXIrEeoV4FedKxTz0mq5UZwBhGdwWoWzJRI+QfLxQt17BvBVgVOWFazCrm8Q+Q0ZsneGyfXAz3UoWqHLVmQobPjEQzziGKuL8JUb+ctNeY6xUuFGt9ylyMscZRB5r3kyyqZljOos4mzPiO8w9geePAfwsAXNIF2zjVirS2BXADdTFnT0ythIzhlV+qBpkKPeBzcDtai0G/um7X7SfHdW5tABzBleoSVVDNZ7hKOjQMwc2Tg6RGDoNfRvlU36Ig+UFzRvPjp3LPya6ow7eoFkeqpqvieCzXC2QwMLIus2kXj4xwZGpfHQ==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=kernel.org; dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20201202 header.b=WnIUHPM7; dkim-atps=neutral; spf=pass (client-ip=139.178.84.217; helo=dfw.source.kernel.org; envelope-from=xiang@kernel.org; receiver=lists.ozlabs.org) smtp.mailfrom=kernel.org
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=kernel.org
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20201202 header.b=WnIUHPM7;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=kernel.org (client-ip=139.178.84.217; helo=dfw.source.kernel.org; envelope-from=xiang@kernel.org; receiver=lists.ozlabs.org)
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4ZjwSR4S7dz2yk3
	for <linux-erofs@lists.ozlabs.org>; Thu, 24 Apr 2025 22:36:07 +1000 (AEST)
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
	by dfw.source.kernel.org (Postfix) with ESMTP id AC4045C6331;
	Thu, 24 Apr 2025 12:33:46 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2E6F4C4CEE3;
	Thu, 24 Apr 2025 12:36:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1745498163;
	bh=gyLKJpkdxFDFqRDP2lvYlS2eIaXf05tk+g+rAtKA0d0=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=WnIUHPM7VI8re50OA8Z/ApWLAC0O2DQikmJ19NUdNGQEjq95/VQPyTfIhVeZRCb5w
	 bpoKIgP5YBgk1QXyAr+Clmk4dFXvxdhVMpjYr3wsr1+JKZ2u/bhrzM3Rizh/GabeOW
	 hedqdmj87qCznU4Tr17xoYbGQPqUKdphyV4bu9gcyQdDh+Jb2OVstyYk2gB33h8V83
	 fcWL1KNLTHAx3yyAeJ+pRPb7NWx7BvIR5kK44qs4LRGP/TpYttiTyBL10yww3xiMjj
	 REnHhnriFl3mmOILl4yoj0QzPPb/jaV/dRluQGN1h1ydFYpxlGN0biwAVAH56+CtBp
	 NLf7rFbc48Fwg==
Date: Thu, 24 Apr 2025 20:35:57 +0800
From: Gao Xiang <xiang@kernel.org>
To: Hongbo Li <lihongbo22@huawei.com>
Cc: xiang@kernel.org, chao@kernel.org, huyue2@coolpad.com,
	jefflexu@linux.alibaba.com, dhavale@google.com,
	linux-erofs@lists.ozlabs.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] MAINTAINERS: erofs: add myself as reviewer
Message-ID: <aAowLQIqX8qq68SV@debian>
Mail-Followup-To: Hongbo Li <lihongbo22@huawei.com>, xiang@kernel.org,
	chao@kernel.org, huyue2@coolpad.com, jefflexu@linux.alibaba.com,
	dhavale@google.com, linux-erofs@lists.ozlabs.org,
	linux-kernel@vger.kernel.org
References: <20250424030653.3308358-1-lihongbo22@huawei.com>
X-Mailing-List: linux-erofs@lists.ozlabs.org
List-Id: <linux-erofs.lists.ozlabs.org>
List-Help: <mailto:linux-erofs+help@lists.ozlabs.org>
List-Owner: <mailto:linux-erofs+owner@lists.ozlabs.org>
List-Post: <mailto:linux-erofs@lists.ozlabs.org>
List-Subscribe: <mailto:linux-erofs+subscribe@lists.ozlabs.org>,
  <mailto:linux-erofs+subscribe-digest@lists.ozlabs.org>,
  <mailto:linux-erofs+subscribe-nomail@lists.ozlabs.org>
List-Unsubscribe: <mailto:linux-erofs+unsubscribe@lists.ozlabs.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20250424030653.3308358-1-lihongbo22@huawei.com>
X-Spam-Status: No, score=-5.2 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,SPF_HELO_NONE,SPF_PASS
	autolearn=disabled version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-25) on lists.ozlabs.org

On Thu, Apr 24, 2025 at 11:06:53AM +0800, Hongbo Li wrote:
> I have a solid background in file systems and since much of my
> recent work has focused on EROFS, I am familiar with it. Now I
> have the time and am willing to help review EROFS patches.
> 
> I hope my participation can be helpful to the EROFS patch review
> process.
> 
> Signed-off-by: Hongbo Li <lihongbo22@huawei.com>

Sounds good to me.  Thanks for your interest for
reviewing EROFS patches:

Acked-by: Gao Xiang <xiang@kernel.org>

Thanks,
Gao Xiang

> ---
>  MAINTAINERS | 1 +
>  1 file changed, 1 insertion(+)
> 
> diff --git a/MAINTAINERS b/MAINTAINERS
> index fa1e04e87d1d..f286c96ea7db 100644
> --- a/MAINTAINERS
> +++ b/MAINTAINERS
> @@ -8719,6 +8719,7 @@ M:	Chao Yu <chao@kernel.org>
>  R:	Yue Hu <zbestahu@gmail.com>
>  R:	Jeffle Xu <jefflexu@linux.alibaba.com>
>  R:	Sandeep Dhavale <dhavale@google.com>
> +R:	Hongbo Li <lihongbo22@huawei.com>
>  L:	linux-erofs@lists.ozlabs.org
>  S:	Maintained
>  W:	https://erofs.docs.kernel.org
> -- 
> 2.34.1
> 
> 

