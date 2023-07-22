Return-Path: <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>
X-Original-To: lists+linux-erofs@lfdr.de
Delivered-To: lists+linux-erofs@lfdr.de
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2404:9400:2:0:216:3eff:fee1:b9f1])
	by mail.lfdr.de (Postfix) with ESMTPS id 4047775DAE1
	for <lists+linux-erofs@lfdr.de>; Sat, 22 Jul 2023 09:50:12 +0200 (CEST)
Authentication-Results: lists.ozlabs.org;
	dkim=fail reason="signature verification failed" (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20201202 header.b=dMh8PmEP;
	dkim-atps=neutral
Received: from boromir.ozlabs.org (localhost [IPv6:::1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4R7JVp19Pdz3bsX
	for <lists+linux-erofs@lfdr.de>; Sat, 22 Jul 2023 17:50:10 +1000 (AEST)
X-Original-To: linux-erofs@lists.ozlabs.org
Delivered-To: linux-erofs@lists.ozlabs.org
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20201202 header.b=dMh8PmEP;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=kernel.org (client-ip=139.178.84.217; helo=dfw.source.kernel.org; envelope-from=xiang@kernel.org; receiver=lists.ozlabs.org)
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits))
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4R7JVk0PjPz300C
	for <linux-erofs@lists.ozlabs.org>; Sat, 22 Jul 2023 17:50:05 +1000 (AEST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits))
	(No client certificate requested)
	by dfw.source.kernel.org (Postfix) with ESMTPS id C6CB06010F;
	Sat, 22 Jul 2023 07:49:58 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id AFB37C433C9;
	Sat, 22 Jul 2023 07:49:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1690012198;
	bh=pxo9ne0cNtDHMM1UOwHtEBdFtq+X0goOMzY8gPkIflE=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=dMh8PmEPUEXfskR1lEdVx9pNghaF46f4XLIIUssIRh0dHihBEGlXsuzwwWEmRkXNO
	 0L6Pe53LOeDckqsluvCZglXlLsHFgSVLtXzy+4wh4uqpredj2iNTNqTZt3TSJ8Ok0A
	 4ZQ6RD8bhJAmk3C0pFD5HIDDI+k8YW55HW6IMsXhapwSRSk2MxyJ+HeP4BQ9qG2VxR
	 C1HK5dZ4WFdr+6kjtxRtoEStCL4SN4H706HjgT4tzVHQ8h3puHexirRlzdc1zAXA36
	 XydTUunlQ625vDXGaz0WtU9zpbGntuHcFjNzPLBZUKKaPjylvKLlIzTXIGRTyt2JL5
	 AAswSb/ymVETQ==
Date: Sat, 22 Jul 2023 15:49:53 +0800
From: Gao Xiang <xiang@kernel.org>
To: Jingbo Xu <jefflexu@linux.alibaba.com>
Subject: Re: [PATCH v2] erofs-utils: lib: fix erofs_iterate_dir() recursion
Message-ID: <ZLuKIaKQZ2AYBL12@debian>
Mail-Followup-To: Jingbo Xu <jefflexu@linux.alibaba.com>,
	hsiangkao@linux.alibaba.com, chao@kernel.org, huyue2@coolpad.com,
	linux-erofs@lists.ozlabs.org
References: <20230722054009.124119-1-jefflexu@linux.alibaba.com>
 <ZLt1KZTLCKyujlmS@debian>
 <3de999b5-b8b8-6229-5041-99046e9a0e1a@linux.alibaba.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <3de999b5-b8b8-6229-5041-99046e9a0e1a@linux.alibaba.com>
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

On Sat, Jul 22, 2023 at 03:04:23PM +0800, Jingbo Xu wrote:
> 
> 
> On 7/22/23 2:20 PM, Gao Xiang wrote:
> > Hi Jingbo,
> > 
> > On Sat, Jul 22, 2023 at 01:40:09PM +0800, Jingbo Xu wrote:
> >> ctx->dir may have changed when ctx is reused along erofs_iterate_dir()
> >> recursion.
> >>
> >> Signed-off-by: Jingbo Xu <jefflexu@linux.alibaba.com>
> >> ---
> >> changes since last version:
> >> since traverse_dirents() can be called multiple times in one single
> >> erofs_iterate_dir() call, ctx->dir may have changed at the entry of
> >> traverse_dirents().  The previous v1 shall be deprecated.
> >>
> >> v1: https://lore.kernel.org/all/20230718052101.124039-3-jefflexu@linux.alibaba.com/
> > 
> > I plan to drop this commit directly.  `struct erofs_dir_context` is not
> > designed for reusing recursively. It's not the case just due to
> > `ctx->dir` but also internal states.
> > 
> > You need to build another ctx for recursion.
> 
> It seems that ctx is reused to avoid stack overflow.  So we have to
> allocate ctx on heap to avoid stack overflow?

It'd be better to use heap space for allocation in principle (even
avoid recursion), but I think it's just some userspace code and
stack space to enough in general.

Thanks,
Gao Xiang

> 
> -- 
> Thanks,
> Jingbo
