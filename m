Return-Path: <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>
X-Original-To: lists+linux-erofs@lfdr.de
Delivered-To: lists+linux-erofs@lfdr.de
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	by mail.lfdr.de (Postfix) with ESMTPS id 255E675DA4A
	for <lists+linux-erofs@lfdr.de>; Sat, 22 Jul 2023 08:20:48 +0200 (CEST)
Authentication-Results: lists.ozlabs.org;
	dkim=fail reason="signature verification failed" (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20201202 header.b=jyuDFx58;
	dkim-atps=neutral
Received: from boromir.ozlabs.org (localhost [IPv6:::1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4R7GWb6RTwz3bsX
	for <lists+linux-erofs@lfdr.de>; Sat, 22 Jul 2023 16:20:43 +1000 (AEST)
X-Original-To: linux-erofs@lists.ozlabs.org
Delivered-To: linux-erofs@lists.ozlabs.org
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20201202 header.b=jyuDFx58;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=kernel.org (client-ip=2604:1380:4641:c500::1; helo=dfw.source.kernel.org; envelope-from=xiang@kernel.org; receiver=lists.ozlabs.org)
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4R7GWS1v5tz2ytP
	for <linux-erofs@lists.ozlabs.org>; Sat, 22 Jul 2023 16:20:36 +1000 (AEST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits))
	(No client certificate requested)
	by dfw.source.kernel.org (Postfix) with ESMTPS id A7969601C3;
	Sat, 22 Jul 2023 06:20:32 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5176EC433C7;
	Sat, 22 Jul 2023 06:20:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1690006832;
	bh=8Z8mVo+e2xDshPkjG2A2uUaVuj2UMVR6YZ5iW24vqrQ=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=jyuDFx58YLbKB/ARt+o5tOKIT0NQz9e7kM9wc1tmiqCBh0CQH9FmNZlAuO2TUAS7n
	 raWKutdWk86DghuQyRvDtYSWnRiA0JCEF//LAdS5DhRLmI0j0VdXsdz4LHcKeXtDVY
	 zVlqBLGgdYcbdo5VsRhKshvJaIKRpk8FGTGMXec44Ft8dOdiH805M8m0sQYW3kV7zX
	 EYzOUq0mK+1IfseCC1bfdfTMitsGdPj0+pCNasWh7aN3PaIdM+QkIww7q6kCkGmCur
	 JiV7qBah3c0771Z0D7M4nvocJh2d7wpJOndQYKeTDaKUpPl5AFTkris/vJmRSJc0K9
	 gKKpIwszwBeWw==
Date: Sat, 22 Jul 2023 14:20:25 +0800
From: Gao Xiang <xiang@kernel.org>
To: Jingbo Xu <jefflexu@linux.alibaba.com>
Subject: Re: [PATCH v2] erofs-utils: lib: fix erofs_iterate_dir() recursion
Message-ID: <ZLt1KZTLCKyujlmS@debian>
Mail-Followup-To: Jingbo Xu <jefflexu@linux.alibaba.com>,
	hsiangkao@linux.alibaba.com, chao@kernel.org, huyue2@coolpad.com,
	linux-erofs@lists.ozlabs.org
References: <20230722054009.124119-1-jefflexu@linux.alibaba.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20230722054009.124119-1-jefflexu@linux.alibaba.com>
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
Cc: hsiangkao@linux.alibaba.com, linux-erofs@lists.ozlabs.org, huyue2@coolpad.com
Errors-To: linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org
Sender: "Linux-erofs" <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>

Hi Jingbo,

On Sat, Jul 22, 2023 at 01:40:09PM +0800, Jingbo Xu wrote:
> ctx->dir may have changed when ctx is reused along erofs_iterate_dir()
> recursion.
> 
> Signed-off-by: Jingbo Xu <jefflexu@linux.alibaba.com>
> ---
> changes since last version:
> since traverse_dirents() can be called multiple times in one single
> erofs_iterate_dir() call, ctx->dir may have changed at the entry of
> traverse_dirents().  The previous v1 shall be deprecated.
> 
> v1: https://lore.kernel.org/all/20230718052101.124039-3-jefflexu@linux.alibaba.com/

I plan to drop this commit directly.  `struct erofs_dir_context` is not
designed for reusing recursively. It's not the case just due to
`ctx->dir` but also internal states.

You need to build another ctx for recursion.

Thanks,
Gao Xiang
