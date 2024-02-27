Return-Path: <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>
X-Original-To: lists+linux-erofs@lfdr.de
Delivered-To: lists+linux-erofs@lfdr.de
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2404:9400:2:0:216:3eff:fee1:b9f1])
	by mail.lfdr.de (Postfix) with ESMTPS id 692C4868B46
	for <lists+linux-erofs@lfdr.de>; Tue, 27 Feb 2024 09:52:23 +0100 (CET)
Authentication-Results: lists.ozlabs.org;
	dkim=fail reason="signature verification failed" (1024-bit key; unprotected) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.a=rsa-sha256 header.s=korg header.b=Pou8i58M;
	dkim-atps=neutral
Received: from boromir.ozlabs.org (localhost [IPv6:::1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4TkWT11q90z3d3W
	for <lists+linux-erofs@lfdr.de>; Tue, 27 Feb 2024 19:52:21 +1100 (AEDT)
X-Original-To: linux-erofs@lists.ozlabs.org
Delivered-To: linux-erofs@lists.ozlabs.org
Authentication-Results: lists.ozlabs.org;
	dkim=pass (1024-bit key; unprotected) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.a=rsa-sha256 header.s=korg header.b=Pou8i58M;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=linuxfoundation.org (client-ip=2604:1380:40e1:4800::1; helo=sin.source.kernel.org; envelope-from=gregkh@linuxfoundation.org; receiver=lists.ozlabs.org)
Received: from sin.source.kernel.org (sin.source.kernel.org [IPv6:2604:1380:40e1:4800::1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4TkWSx190Qz30gM
	for <linux-erofs@lists.ozlabs.org>; Tue, 27 Feb 2024 19:52:16 +1100 (AEDT)
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
	by sin.source.kernel.org (Postfix) with ESMTP id 41DDCCE1B2D;
	Tue, 27 Feb 2024 08:52:14 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2E09BC433C7;
	Tue, 27 Feb 2024 08:52:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1709023933;
	bh=P/zwOOotQ6YR93fm0kSQdKSEqh6cRlBcvrRGWaXcZ5A=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=Pou8i58M+1Pw5lWxythU5IS7tbdLTLyoSKz8oG42AFP1QYeOV6YQkmtArpunzrAkp
	 qKrc+axaoi9YyleWCOAd11sc4jMxZhoWG5q0Z07f6slRroDla0keQODc3lTiJIXNTV
	 Y0jvmfvpFsQWbYB1L6j9Wz5BDLx/iDX4OgfB4Y+8=
Date: Tue, 27 Feb 2024 09:52:11 +0100
From: Greg KH <gregkh@linuxfoundation.org>
To: Yue Hu <zbestahu@gmail.com>
Subject: Re: [PATCH 6.1.y 1/2] erofs: simplify compression configuration
 parser
Message-ID: <2024022703-skied-tassel-cfc6@gregkh>
References: <5216b503054dbbb9fccf8faa280647c728e82726.1709000322.git.huyue2@coolpad.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <5216b503054dbbb9fccf8faa280647c728e82726.1709000322.git.huyue2@coolpad.com>
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
Cc: hsiangkao@linux.alibaba.com, Yue Hu <huyue2@coolpad.com>, linux-erofs@lists.ozlabs.org, stable@vger.kernel.org, zhangwen@coolpad.com
Errors-To: linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org
Sender: "Linux-erofs" <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>

On Tue, Feb 27, 2024 at 10:22:38AM +0800, Yue Hu wrote:
> From: Gao Xiang <hsiangkao@linux.alibaba.com>
> 
> [ Upstream commit efb4fb02cef3ab410b603c8f0e1c67f61d55f542 ]
> 
> Move erofs_load_compr_cfgs() into decompressor.c as well as introduce
> a callback instead of a hard-coded switch for each algorithm for
> simplicity.
> 
> Reviewed-by: Chao Yu <chao@kernel.org>
> Signed-off-by: Gao Xiang <hsiangkao@linux.alibaba.com>
> Link: https://lore.kernel.org/r/20231022130957.11398-1-xiang@kernel.org
> Stable-dep-of: 118a8cf504d7 ("erofs: fix inconsistent per-file compression format")
> Signed-off-by: Yue Hu <huyue2@coolpad.com>
> ---

Both queued up, thanks.

greg k-h
