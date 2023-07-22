Return-Path: <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>
X-Original-To: lists+linux-erofs@lfdr.de
Delivered-To: lists+linux-erofs@lfdr.de
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2404:9400:2:0:216:3eff:fee1:b9f1])
	by mail.lfdr.de (Postfix) with ESMTPS id 1C7BF75DACB
	for <lists+linux-erofs@lfdr.de>; Sat, 22 Jul 2023 09:47:12 +0200 (CEST)
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20201202 header.b=e1YWZfJy;
	dkim-atps=neutral
Received: from boromir.ozlabs.org (localhost [IPv6:::1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4R7JRK6JzJz3bsX
	for <lists+linux-erofs@lfdr.de>; Sat, 22 Jul 2023 17:47:09 +1000 (AEST)
X-Original-To: linux-erofs@lists.ozlabs.org
Delivered-To: linux-erofs@lists.ozlabs.org
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20201202 header.b=e1YWZfJy;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=kernel.org (client-ip=139.178.84.217; helo=dfw.source.kernel.org; envelope-from=xiang@kernel.org; receiver=lists.ozlabs.org)
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits))
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4R7JRF0RD2z2yyT
	for <linux-erofs@lists.ozlabs.org>; Sat, 22 Jul 2023 17:47:04 +1000 (AEST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits))
	(No client certificate requested)
	by dfw.source.kernel.org (Postfix) with ESMTPS id E641B60BBF;
	Sat, 22 Jul 2023 07:47:02 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6765CC433C7;
	Sat, 22 Jul 2023 07:47:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1690012022;
	bh=cRWTHRZaqaPfdxrqhA4g57bPZB4lpgvXeXn+zZsP3lI=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=e1YWZfJyXRJb8wo6lED71EU2da5lJfws/jfuFW2IAK9pcwZiZWeS3iig5+A/mPrct
	 WTHNTjk8T80bQEwy8zbnHuQtIlTOQmSOhSjxD8WDPh4YqyWsdD/KEpRRXweXB2nU3f
	 LWElw1oThT9VT3jS360gyuC4nzSErJqDrtuufcUmpjW8kroiom8giYADvKm19l6uWK
	 MlnyE+2cb2c3caxp9HKzHh4bKee7omkdMO+W+Uz3NJ8WbPMYsBYFv7Auuc0B51Zm2J
	 D8laAlOjTzrFY/kzUKgarCN5ucsw3Y6utsol99gUj/hlf+H2lcKWsLbLnKQv3VTprL
	 FgtNQDeiDRMBw==
Date: Sat, 22 Jul 2023 15:46:56 +0800
From: Gao Xiang <xiang@kernel.org>
To: Jingbo Xu <jefflexu@linux.alibaba.com>
Subject: Re: [PATCH v5 2/2] erofs: boost negative xattr lookup with bloom
 filter
Message-ID: <ZLuJcKH3ymLEVQec@debian>
Mail-Followup-To: Jingbo Xu <jefflexu@linux.alibaba.com>,
	linux-erofs@lists.ozlabs.org, linux-kernel@vger.kernel.org
References: <20230721104923.20236-1-jefflexu@linux.alibaba.com>
 <20230721104923.20236-3-jefflexu@linux.alibaba.com>
 <ZLt/oJWa4MoE4F25@debian>
 <bf48239c-6850-d33d-e7f6-1a4a15400ae9@linux.alibaba.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <bf48239c-6850-d33d-e7f6-1a4a15400ae9@linux.alibaba.com>
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
Cc: linux-erofs@lists.ozlabs.org, linux-kernel@vger.kernel.org
Errors-To: linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org
Sender: "Linux-erofs" <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>

On Sat, Jul 22, 2023 at 03:33:11PM +0800, Jingbo Xu wrote:

...

> >> +	uint32_t hashbit;
> > 
> > Why using `uint32_t` here rather than `unsigned int`? We don't use
> > `uint32_t` in the kernel codebase.
> > 
> 
> xxh32() returns uint32_t.

we never use (u)intxx_t in the native kernel code.

Thanks,
Gao Xiang
