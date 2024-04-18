Return-Path: <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>
X-Original-To: lists+linux-erofs@lfdr.de
Delivered-To: lists+linux-erofs@lfdr.de
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2404:9400:2:0:216:3eff:fee1:b9f1])
	by mail.lfdr.de (Postfix) with ESMTPS id C106B8A9237
	for <lists+linux-erofs@lfdr.de>; Thu, 18 Apr 2024 06:58:06 +0200 (CEST)
Authentication-Results: lists.ozlabs.org;
	dkim=fail reason="signature verification failed" (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20201202 header.b=dhFvz7Zf;
	dkim-atps=neutral
Received: from boromir.ozlabs.org (localhost [IPv6:::1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4VKls83vQdz3cQx
	for <lists+linux-erofs@lfdr.de>; Thu, 18 Apr 2024 14:58:04 +1000 (AEST)
X-Original-To: linux-erofs@lists.ozlabs.org
Delivered-To: linux-erofs@lists.ozlabs.org
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20201202 header.b=dhFvz7Zf;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=kernel.org (client-ip=139.178.84.217; helo=dfw.source.kernel.org; envelope-from=xiang@kernel.org; receiver=lists.ozlabs.org)
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits))
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4VKls60V5vz3btQ
	for <linux-erofs@lists.ozlabs.org>; Thu, 18 Apr 2024 14:58:01 +1000 (AEST)
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
	by dfw.source.kernel.org (Postfix) with ESMTP id B548B61628;
	Thu, 18 Apr 2024 04:57:59 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 534D6C113CC;
	Thu, 18 Apr 2024 04:57:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1713416279;
	bh=nF/kXjAhm9EJBwyglxRrcOQAW6Cb85maExUcvS8I7+M=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=dhFvz7ZfSiVlPGTSERX4IbT9VKSLi6SwE2/fxFC28oaM9fmBch/7kph8gFb0PQAzB
	 2oaeySDQ+sBh4Svm+kfw5wDklMKcnio/hBP1p3md2k+PEfb114Rp8lc+C+Izh7KP/C
	 hMzd12siNWaR3J/VkJVAPKzCza3K6kI7eUHz3GCELrwO3csBFyEyC+kZ4hGYSH23it
	 ggprfvZBGenjbz9mv3gGjp2DpfLnUVI4wRpMdR2DO1mBUHT3TX6DS8I/DI36m0B9iq
	 4OIiR5/wUhCfSO+f1UlbzHK0P7+76VCtoRWdeFUpOgbs73opCI6/MM7Sp7P5vGuj07
	 qjNZgvhZi5d2A==
Date: Thu, 18 Apr 2024 12:57:57 +0800
From: Gao Xiang <xiang@kernel.org>
To: Noboru Asai <asai@sijam.com>
Subject: Re: [PATCH] erofs-utils: mkfs: skip the redundant write for
 ztailpacking block
Message-ID: <ZiCoVYoxW7NFHeUr@debian>
Mail-Followup-To: Noboru Asai <asai@sijam.com>,
	Yifan Zhao <zhaoyifan@sjtu.edu.cn>,
	Gao Xiang <hsiangkao@linux.alibaba.com>,
	linux-erofs@lists.ozlabs.org
References: <20240417144251.1845355-1-zhaoyifan@sjtu.edu.cn>
 <CAFoAo-KboSBKuna87DWQMjphVPorgnYiMMEAf5PPwEhD4hZv=w@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <CAFoAo-KboSBKuna87DWQMjphVPorgnYiMMEAf5PPwEhD4hZv=w@mail.gmail.com>
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
Cc: Gao Xiang <hsiangkao@linux.alibaba.com>, Yifan Zhao <zhaoyifan@sjtu.edu.cn>, linux-erofs@lists.ozlabs.org
Errors-To: linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org
Sender: "Linux-erofs" <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>

Hi Noboru,

On Thu, Apr 18, 2024 at 10:09:22AM +0900, Noboru Asai wrote:
> In this patch, the value of blkaddr in z_erofs_lcluster_index
> corresponding to the ztailpacking block in the extent list
> is invalid value. It looks that the linux kernel doesn't refer to this
> value, but what value is correct?
> 0 or -1 (EROFS_NULL_ADDR) or don't care?

Thanks for pointing out!

On the kernel side, it doesn't care this value if it's really
_inlined_.

But on the mkfs side, since we have inline fallback so I don't
think an invalid blkaddr is correct.  The next blkaddr should
be filled for inline fallback instead.

Let me think more about it and update the patch.

Thanks,
Gao Xiang
