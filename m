Return-Path: <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>
X-Original-To: lists+linux-erofs@lfdr.de
Delivered-To: lists+linux-erofs@lfdr.de
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2404:9400:2:0:216:3eff:fee1:b9f1])
	by mail.lfdr.de (Postfix) with ESMTPS id 845C6888457
	for <lists+linux-erofs@lfdr.de>; Mon, 25 Mar 2024 01:37:00 +0100 (CET)
Authentication-Results: lists.ozlabs.org;
	dkim=fail reason="signature verification failed" (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20201202 header.b=T6iTqyP3;
	dkim-atps=neutral
Received: from boromir.ozlabs.org (localhost [IPv6:::1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4V2vBt6YGNz3cZ8
	for <lists+linux-erofs@lfdr.de>; Mon, 25 Mar 2024 11:36:54 +1100 (AEDT)
X-Original-To: linux-erofs@lists.ozlabs.org
Delivered-To: linux-erofs@lists.ozlabs.org
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20201202 header.b=T6iTqyP3;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=kernel.org (client-ip=139.178.84.217; helo=dfw.source.kernel.org; envelope-from=xiang@kernel.org; receiver=lists.ozlabs.org)
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4V2vBq4KQ9z30fp
	for <linux-erofs@lists.ozlabs.org>; Mon, 25 Mar 2024 11:36:51 +1100 (AEDT)
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
	by dfw.source.kernel.org (Postfix) with ESMTP id 937EC60C67;
	Mon, 25 Mar 2024 00:36:48 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B0046C433F1;
	Mon, 25 Mar 2024 00:36:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1711327008;
	bh=ADKAmQUOaYHldXWJswv5b4u4EPWPvg9ByIPOXE0+E3k=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=T6iTqyP39S1pX5fGsw1LZXl6ncapNQezHvfHTeLJKS30LaTeYj6Z8MK+IwejcJ7Qv
	 Ig5G2+lUW6oHG/tlb+3GHga0k7qqwiEZS7p3mYTMTOZFF8+jXGwV9Yr4tl8iEF2R85
	 11p0kcn/DQBATlZz4j0vY/TZ/ySkPRAPhA2iW38wOz+7P2MMTQRYlyDuUOEY9aLRDp
	 avlSB1StyP2g6OEXIze3qGnkGppCcdd5j51SfERaJHPNaOMp2lA8SIMfQXljP2ppSU
	 IoZ19Endl2ecX4Z648yNiXD1LLz3cHDU1D81+9y31t/FS+C3EmHNicM53f0DoUQi4x
	 vI0t1EGf3fusw==
Date: Mon, 25 Mar 2024 08:36:43 +0800
From: Gao Xiang <xiang@kernel.org>
To: Sasha Levin <sashal@kernel.org>
Subject: Re: [PATCH 6.6 329/638] erofs: Convert to use bdev_open_by_path()
Message-ID: <ZgDHG8Ucl3EkY4ZS@debian>
Mail-Followup-To: Sasha Levin <sashal@kernel.org>,
	linux-kernel@vger.kernel.org, stable@vger.kernel.org,
	Jan Kara <jack@suse.cz>, Gao Xiang <xiang@kernel.org>,
	Chao Yu <chao@kernel.org>, linux-erofs@lists.ozlabs.org,
	Christoph Hellwig <hch@lst.de>,
	Gao Xiang <hsiangkao@linux.alibaba.com>,
	Christian Brauner <brauner@kernel.org>
References: <20240324230116.1348576-1-sashal@kernel.org>
 <20240324230116.1348576-330-sashal@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20240324230116.1348576-330-sashal@kernel.org>
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
Cc: Christian Brauner <brauner@kernel.org>, Jan Kara <jack@suse.cz>, linux-kernel@vger.kernel.org, stable@vger.kernel.org, Gao Xiang <hsiangkao@linux.alibaba.com>, linux-erofs@lists.ozlabs.org, Christoph Hellwig <hch@lst.de>
Errors-To: linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org
Sender: "Linux-erofs" <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>

Hi,

On Sun, Mar 24, 2024 at 06:56:06PM -0400, Sasha Levin wrote:
> From: Jan Kara <jack@suse.cz>
> 
> [ Upstream commit 49845720080dff0afd5813eaebf0758b01b6312c ]
> 
> Convert erofs to use bdev_open_by_path() and pass the handle around.
> 
> CC: Gao Xiang <xiang@kernel.org>
> CC: Chao Yu <chao@kernel.org>
> CC: linux-erofs@lists.ozlabs.org
> Acked-by: Christoph Hellwig <hch@lst.de>
> Acked-by: Gao Xiang <hsiangkao@linux.alibaba.com>
> Reviewed-by: Christian Brauner <brauner@kernel.org>
> Signed-off-by: Jan Kara <jack@suse.cz>
> Link: https://lore.kernel.org/r/20230927093442.25915-21-jack@suse.cz
> Signed-off-by: Christian Brauner <brauner@kernel.org>
> Stable-dep-of: 0f28be64d132 ("erofs: fix lockdep false positives on initializing erofs_pseudo_mnt")
> Signed-off-by: Sasha Levin <sashal@kernel.org>

I don't think it's necessary to be backported to v6.6 as well as
the previous one "block: Provide bdev_open_* functions".

The patch
"erofs: fix lockdep false positives on initializing erofs_pseudo_mnt"
should be manually backported instead.

Thanks,
Gao Xiang

