Return-Path: <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>
X-Original-To: lists+linux-erofs@lfdr.de
Delivered-To: lists+linux-erofs@lfdr.de
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	by mail.lfdr.de (Postfix) with ESMTPS id 5A8C150940B
	for <lists+linux-erofs@lfdr.de>; Thu, 21 Apr 2022 02:03:39 +0200 (CEST)
Received: from boromir.ozlabs.org (localhost [IPv6:::1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4KkHnP1wk0z2ypZ
	for <lists+linux-erofs@lfdr.de>; Thu, 21 Apr 2022 10:03:37 +1000 (AEST)
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20201202 header.b=bBEQ7XEA;
	dkim-atps=neutral
X-Original-To: linux-erofs@lists.ozlabs.org
Delivered-To: linux-erofs@lists.ozlabs.org
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized)
 smtp.mailfrom=kernel.org (client-ip=145.40.73.55; helo=sin.source.kernel.org;
 envelope-from=xiang@kernel.org; receiver=<UNKNOWN>)
Authentication-Results: lists.ozlabs.org; dkim=pass (2048-bit key;
 unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256
 header.s=k20201202 header.b=bBEQ7XEA; 
 dkim-atps=neutral
Received: from sin.source.kernel.org (sin.source.kernel.org [145.40.73.55])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 4KkHnH2Sqsz2xVY
 for <linux-erofs@lists.ozlabs.org>; Thu, 21 Apr 2022 10:03:31 +1000 (AEST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by sin.source.kernel.org (Postfix) with ESMTPS id 9EA0FCE2044;
 Thu, 21 Apr 2022 00:03:28 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 33DFBC385A0;
 Thu, 21 Apr 2022 00:03:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=k20201202; t=1650499406;
 bh=Pi/emhYlnteMahS/XeUwteuvb+/SuwiDhqjaH4fusyw=;
 h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
 b=bBEQ7XEApWhCvOQDpEcEYEa3RJp7v1nDlZfQZ3Zv6mEEVAizZRHvpEIXm46FxdMgK
 2r0SyKisNi01TY58WLxuc0EjqvuTnZn78F9pCIxrsGRtsWFUYYDT1NX73WisaP+gSX
 myvXGCJL6fpHYbCAFq/xkPlRTmCny18QdlLWA7k/NoOAcgYWvSfD+rC6NImGpI649n
 MXg3xih6LAzJoFek+ixdLItOgrY43J5C2Qofv4nRXJwDKHDtTpd+p+zogCf7NC7Tr4
 Dj11xHQ58XTFR6HhjPxQSBNl3o5u5Jo63B7lzZ1XKqJHUB2ULocB3h5JbA84eEol21
 YcrqZHs0Zyc4g==
Date: Thu, 21 Apr 2022 08:03:22 +0800
From: Gao Xiang <xiang@kernel.org>
To: Fabrice Fontaine <fontaine.fabrice@gmail.com>
Subject: Re: [PATCH] Add --disable-werror
Message-ID: <YmCfSvAac8KCgl50@debian>
Mail-Followup-To: Fabrice Fontaine <fontaine.fabrice@gmail.com>,
 linux-erofs@lists.ozlabs.org
References: <20220420221018.1396105-1-fontaine.fabrice@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20220420221018.1396105-1-fontaine.fabrice@gmail.com>
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
Sender: "Linux-erofs"
 <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>

On Thu, Apr 21, 2022 at 12:10:18AM +0200, Fabrice Fontaine wrote:
> Add an option to disable -Werror to fix the following build failure with
> gcc 4.8 raised since version 1.4 and
> https://git.kernel.org/pub/scm/linux/kernel/git/xiang/erofs-utils.git/commit/?id=cf8be8a4352a5df3b3acf545af289cb47faa6de0:
> 
> In file included from /home/buildroot/autobuild/instance-0/output-1/host/arm-buildroot-linux-gnueabi/sysroot/usr/include/string.h:636:0,
>                  from ../include/erofs/internal.h:242,
>                  from ../include/erofs/inode.h:11,
>                  from main.c:12:
> In function 'memset',
>     inlined from 'erofsdump_filetype_distribution.constprop.2' at main.c:583:9:
> /home/buildroot/autobuild/instance-0/output-1/host/arm-buildroot-linux-gnueabi/sysroot/usr/include/bits/string3.h:81:30: error: call to '__warn_memset_zero_len' declared with attribute warning: memset used with constant zero length parameter; this could be due to transposed parameters [-Werror]
>        __warn_memset_zero_len ();
>                               ^
> 
> Fixes:
>  - http://autobuild.buildroot.org/results/4c776ec935bbb016231b6701471887a7c9ea79e9
> 
> Signed-off-by: Fabrice Fontaine <fontaine.fabrice@gmail.com>

Thanks, applied with some minor commit message changes. And also
disable -Werror by default, since it's somewhat annoying on
(almost) every release due to various configuration combinations
which I couldn't cover all.

Thanks,
Gao Xiang
