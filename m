Return-Path: <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>
X-Original-To: lists+linux-erofs@lfdr.de
Delivered-To: lists+linux-erofs@lfdr.de
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2404:9400:2:0:216:3eff:fee1:b9f1])
	by mail.lfdr.de (Postfix) with ESMTPS id C3D578502BB
	for <lists+linux-erofs@lfdr.de>; Sat, 10 Feb 2024 07:22:40 +0100 (CET)
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20201202 header.b=UOuAheiW;
	dkim-atps=neutral
Received: from boromir.ozlabs.org (localhost [IPv6:::1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4TX0y6511dz3c3y
	for <lists+linux-erofs@lfdr.de>; Sat, 10 Feb 2024 17:22:38 +1100 (AEDT)
X-Original-To: linux-erofs@lists.ozlabs.org
Delivered-To: linux-erofs@lists.ozlabs.org
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20201202 header.b=UOuAheiW;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=kernel.org (client-ip=139.178.84.217; helo=dfw.source.kernel.org; envelope-from=xiang@kernel.org; receiver=lists.ozlabs.org)
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4TX0y01KBvz2xKQ
	for <linux-erofs@lists.ozlabs.org>; Sat, 10 Feb 2024 17:22:32 +1100 (AEDT)
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
	by dfw.source.kernel.org (Postfix) with ESMTP id 3539E601D4;
	Sat, 10 Feb 2024 06:22:29 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 39CA9C433F1;
	Sat, 10 Feb 2024 06:22:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1707546148;
	bh=Bv/+fZ392MU/Fr1knLNd2s4A4x6GGtSLflJfmPoy534=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=UOuAheiWm9fGK0npyH5bFOrpxoHjveSziRf6qvr9IUrZ5oZHF/canxU/LVnSu6QPo
	 bR1hNN/UtIzDqVQNAzo8yIcRG8IeTZSFMwp+NN1TBqihSgWZmiBBGshOaUJssDoGJ3
	 HAjaY9ZNF+GF5P0WUHM0fzrgYzsBaCuVPcfcTOtGSgk1YsD5ntwJWV8wvfZwrF94/c
	 bjJypgF9Ws1M6nY9ixXv2K5GsM6NHR69Fmx+jaaBFTORy1PFfZvN/c6fitY8XsKb6A
	 nzu1yrGCI/a2iZCVcBqMJn62MQyQPVJWdzrapCbaEO+9bqvFvXEIlGj0BENl7eNWiM
	 H9FSL4LdlJhbw==
Date: Sat, 10 Feb 2024 14:22:23 +0800
From: Gao Xiang <xiang@kernel.org>
To: Tianyi Liu <i.pear@outlook.com>
Subject: Re: [PATCH] erofs-utils: lib: fix incorrect usages of
 `erofs_strerror`
Message-ID: <ZccWH2e+HcXzwrR1@debian>
Mail-Followup-To: Tianyi Liu <i.pear@outlook.com>,
	linux-erofs@lists.ozlabs.org
References: <SY6P282MB3193657433D35C3A7799CA5F9D442@SY6P282MB3193.AUSP282.PROD.OUTLOOK.COM>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <SY6P282MB3193657433D35C3A7799CA5F9D442@SY6P282MB3193.AUSP282.PROD.OUTLOOK.COM>
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


On Thu, Feb 08, 2024 at 09:59:09PM +0800, Tianyi Liu wrote:
> `erofs_strerror` accepts a negative argument,
> so `errno` should be negatived before passing to it.
> 
> Signed-off-by: Tianyi Liu <i.pear@outlook.com>

Thanks, applied!

Thanks,
Gao Xiang
