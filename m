Return-Path: <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>
X-Original-To: lists+linux-erofs@lfdr.de
Delivered-To: lists+linux-erofs@lfdr.de
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2404:9400:2:0:216:3eff:fee1:b9f1])
	by mail.lfdr.de (Postfix) with ESMTPS id 6BFDF97AD7B
	for <lists+linux-erofs@lfdr.de>; Tue, 17 Sep 2024 11:03:40 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=lists.ozlabs.org;
	s=201707; t=1726563817;
	bh=aNbw7wKOD7gY/9cGnSV2ctOor5UTDwXGnfGNgb9DhdM=;
	h=To:Subject:Date:In-Reply-To:References:List-Id:List-Unsubscribe:
	 List-Archive:List-Post:List-Help:List-Subscribe:From:Reply-To:Cc:
	 From;
	b=lk6bLjxGGiTHpwVp2mS96FgWwK+pdImIzHc8p0TpSgvxiDOwEtCd4smmy4nzgz/Dm
	 oAA7QyFVGu34FfJihljeoFNO8Pnesm+/VN0UHIgSJc4Zp95i6g9T+fI+AsL7M/bnyQ
	 /slSt9RAZT7MHzxwtSfeZ8ilN6WXtha2jyOoGrSIUMDznP2nXh36nX0nYXYh1wTAIT
	 dXavkVv5MC7YQ6BH+fHbll09B/Ns0Rb48fuJ3+zf+3vDNdo3GX+RVPvqeOF3ZTquoS
	 UHkr0BDFs7w2Axy7g/4sxGWI+wRb8mcXa+MRTs37a1Lj1YPMu3x7yYh+6VoQS84dGx
	 M2NbGrz1+rSBQ==
Received: from boromir.ozlabs.org (localhost [IPv6:::1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4X7G6K5WGnz2yLB
	for <lists+linux-erofs@lfdr.de>; Tue, 17 Sep 2024 19:03:37 +1000 (AEST)
X-Original-To: linux-erofs@lists.ozlabs.org
Delivered-To: linux-erofs@lists.ozlabs.org
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip="2604:1380:4641:c500::1"
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1726563816;
	cv=none; b=K6ZqD8Ijw5RtCL5Pvc82m39wK1I+3T10Ifax7MTpDbRPLjUhtNhipcC9ec0X8orL0KMkJc+3/UdqLhJ2kUj1+dIertCDF3DXGZqumvXkbOUtjOYxjCgYcDpDfrwdoGsuU4JTayA2qxqZQgXkVKRPP7P2HSh+jdV44/jjxwSCAvgMjdNFEph7I5jPsfGQ5n5IXlvVaVRsJZYIcr2z/7jDM09X8nMBtwyUnlVLkjXouNdlrl3BzNn0aaTt059DY0gozQBunyTakNJPAJBN7xGhUSvmpYOjFoMqxv9XYtK4OzI9OfqXAfsC9QSs/E3lrzoJSaO31SeAkNtObrWOLs0/xQ==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1726563816; c=relaxed/relaxed;
	bh=aNbw7wKOD7gY/9cGnSV2ctOor5UTDwXGnfGNgb9DhdM=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=Drcq7BSWjyFJlL9Vqox1RjQyJc8GKnGRpz4/eVWYmLjVMgcQWJ+4s1lQW8xc9SrI7ebvVtxTnWzQiNgaFO1964zkzHwan/FM99WBwm08YIiU0vSFM3q8NTbZ+0nhn/kfdl1hli8XlsnqtWiQcYUEBMapvIj1MGfkQWMrkfzyCPeF6iPuhOXR8PbSa0axEl6H0dNg2G8CVyFlHRwYHJLg2ziRWg8B9qnCF8GhTJZ7k+xyrB2EiT/joPaUXoGdQ1yYHns/mdCmBLdWR+OfbdgwHhhNkSOa39zAXc+pmspvsDivfVwEQXMapP9QrsMBEhPSyF9Jdi96Cgldqj+PZVBR2g==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=kernel.org; dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20201202 header.b=OQ/yANKh; dkim-atps=neutral; spf=pass (client-ip=2604:1380:4641:c500::1; helo=dfw.source.kernel.org; envelope-from=brauner@kernel.org; receiver=lists.ozlabs.org) smtp.mailfrom=kernel.org
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=kernel.org
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20201202 header.b=OQ/yANKh;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=kernel.org (client-ip=2604:1380:4641:c500::1; helo=dfw.source.kernel.org; envelope-from=brauner@kernel.org; receiver=lists.ozlabs.org)
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4X7G6J0VS5z2x98
	for <linux-erofs@lists.ozlabs.org>; Tue, 17 Sep 2024 19:03:36 +1000 (AEST)
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
	by dfw.source.kernel.org (Postfix) with ESMTP id 5C4175C59BE;
	Tue, 17 Sep 2024 09:03:28 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E5A3BC4CEC5;
	Tue, 17 Sep 2024 09:03:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1726563811;
	bh=EltNu/Vvs2dUaVxhrsZoanhKyc7N5StGFgimWX0o+4Q=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=OQ/yANKhnddSqulNweiFVaryGn6CGgbcQ6UcZlMfKrPknKnYcKUP9MFP+cqeUMVcM
	 oBmLAOppc1865gs6utmZ5AEq7RN6oZbGfidJEP8dJoGboU1DUv2Cgp2AWpHzVWdIt5
	 YITHBvii9sspSNKH5/jSDrOAleRV5c8zkumZzM0kHLUNprvTYNlwbIn33+kJMGnM7Z
	 Le8qw7A6CUYhw9Pb5MiDuPI4ryqwsrb/APjIlHO+/aMrPSvQMhedmfXrJWZQrlO2gL
	 tBDJetlSQGD/w3nZ0YL6zUBaKeqoJPr60aUUlsQ6f8FiMApwzTYXkxoHsMzuIfDSNQ
	 bsBMFhvlMSVbQ==
To: netfs@lists.linux.dev,
	libaokun@huaweicloud.com
Subject: Re: [PATCH v2] cachefiles: fix dentry leak in cachefiles_open_file()
Date: Tue, 17 Sep 2024 11:03:19 +0200
Message-ID: <20240917-ursachen-umsatz-3746ab6636a8@brauner>
X-Mailer: git-send-email 2.45.2
In-Reply-To: <20240829083409.3788142-1-libaokun@huaweicloud.com>
References: <20240829083409.3788142-1-libaokun@huaweicloud.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
X-Developer-Signature: v=1; a=openpgp-sha256; l=1589; i=brauner@kernel.org; h=from:subject:message-id; bh=EltNu/Vvs2dUaVxhrsZoanhKyc7N5StGFgimWX0o+4Q=; b=owGbwMvMwCU28Zj0gdSKO4sYT6slMaS9dL1tmNoz0SxnS82BXuV4j459Ti7XWO+85k8TYXBKY F4689PsjlIWBjEuBlkxRRaHdpNwueU8FZuNMjVg5rAygQxh4OIUgInY5TMyNB861azxZYP1hOsl z4IfLt/p+ve2+xzG9etuSj2M/fB9XwYjw5Wir3wewlPMdCb38aTXM+T8Ufjj+frIrrOKU6OeX76 VzQ4A
X-Developer-Key: i=brauner@kernel.org; a=openpgp; fpr=4880B8C9BD0E5106FC070F4F7B3C391EFEA93624
Content-Transfer-Encoding: 8bit
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
From: Christian Brauner via Linux-erofs <linux-erofs@lists.ozlabs.org>
Reply-To: Christian Brauner <brauner@kernel.org>
Cc: Christian Brauner <brauner@kernel.org>, yangerkun@huawei.com, jlayton@kernel.org, linux-kernel@vger.kernel.org, dhowells@redhat.com, linux-fsdevel@vger.kernel.org, yukuai3@huawei.com, linux-erofs@lists.ozlabs.org, stable@kernel.org
Errors-To: linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org
Sender: "Linux-erofs" <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>

On Thu, 29 Aug 2024 16:34:09 +0800, libaokun@huaweicloud.com wrote:
> A dentry leak may be caused when a lookup cookie and a cull are concurrent:
> 
>             P1             |             P2
> -----------------------------------------------------------
> cachefiles_lookup_cookie
>   cachefiles_look_up_object
>     lookup_one_positive_unlocked
>      // get dentry
>                             cachefiles_cull
>                               inode->i_flags |= S_KERNEL_FILE;
>     cachefiles_open_file
>       cachefiles_mark_inode_in_use
>         __cachefiles_mark_inode_in_use
>           can_use = false
>           if (!(inode->i_flags & S_KERNEL_FILE))
>             can_use = true
> 	  return false
>         return false
>         // Returns an error but doesn't put dentry
> 
> [...]

Applied to the vfs.fixes branch of the vfs/vfs.git tree.
Patches in the vfs.fixes branch should appear in linux-next soon.

Please report any outstanding bugs that were missed during review in a
new review to the original patch series allowing us to drop it.

It's encouraged to provide Acked-bys and Reviewed-bys even though the
patch has now been applied. If possible patch trailers will be updated.

Note that commit hashes shown below are subject to change due to rebase,
trailer updates or similar. If in doubt, please check the listed branch.

tree:   https://git.kernel.org/pub/scm/linux/kernel/git/vfs/vfs.git
branch: vfs.fixes

[1/1] cachefiles: fix dentry leak in cachefiles_open_file()
      https://git.kernel.org/vfs/vfs/c/31075a6ed624
