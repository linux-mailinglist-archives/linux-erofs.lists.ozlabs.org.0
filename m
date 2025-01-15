Return-Path: <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>
X-Original-To: lists+linux-erofs@lfdr.de
Delivered-To: lists+linux-erofs@lfdr.de
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2404:9400:2:0:216:3eff:fee1:b9f1])
	by mail.lfdr.de (Postfix) with ESMTPS id E0885A120F8
	for <lists+linux-erofs@lfdr.de>; Wed, 15 Jan 2025 11:51:24 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=lists.ozlabs.org;
	s=201707; t=1736938282;
	bh=C1Mtm8As7SopICMwxAb+WQMSvAp9A7rYeDeKyxl8Wps=;
	h=To:Subject:Date:In-Reply-To:References:List-Id:List-Unsubscribe:
	 List-Archive:List-Post:List-Help:List-Subscribe:From:Reply-To:Cc:
	 From;
	b=Vx+vfBq3G4+JFRQQDJ7l6Tzv7Hs4CjlKlo88YsiJ0iye+yu6UhaEsisXfD1cOR7nX
	 5TCpnYXPQ/mwheJYwVGF8H2ggi/KQXMrcuovqcS+iKEw0T2KvtdkRC77WqATX4SAtP
	 rYybSUlZ14hzJ/kTB828wtT4D3oS2z8e+f1dOQ01IOex3mWE6rrEVtaBkFIrUkjjcS
	 hbYtBxR0eOfGMvuEoXoXejjiWyFI8ankoJ8Q2skxmk3UrRER9DN12fBKmxXIzYIcga
	 W91YdX0eXYVhATe12ER4ZWk29GxJkL7myDAIdwTsw+60Xzh0QWpeAybkV448gddMRZ
	 OvMDWfCb2bt5w==
Received: from boromir.ozlabs.org (localhost [IPv6:::1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4YY2qG0Jwyz3bdH
	for <lists+linux-erofs@lfdr.de>; Wed, 15 Jan 2025 21:51:22 +1100 (AEDT)
X-Original-To: linux-erofs@lists.ozlabs.org
Delivered-To: linux-erofs@lists.ozlabs.org
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip=139.178.84.217
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1736938280;
	cv=none; b=fPgDy9l6EXF1mBU8oRYBpVanH27ezcVGjf7LTN6A/UphoH34NWo4qJc+cEEsoKYbmB1HimRlpewQbjbdB8/hVBrcrcjYU7MRlDbPgBGAVePaS/o8S1jhH7PJQrMww4/ff/GtbfCRQKLvxUueR4HHp/tZ0tk9s7Vx9yIyElCnwhs0L3cg547xNhQKIHmNYDR3R9t/XH2EnGyZFzckY+tQyXoT7/FWy4zzJ6W5XW+6+BUvAru3wawFV3Ep0Dt4DfUcl1NV5+Yb0j5Abu/O/Kmk5hFYGdwO9a7l4kY2Ydx32SLk1GyiNNotmaLDXWMRcO/ENkC49/aWioC+khjd2rHtew==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1736938280; c=relaxed/relaxed;
	bh=C1Mtm8As7SopICMwxAb+WQMSvAp9A7rYeDeKyxl8Wps=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=DOF5Vyg+JDVZqo5OOYX/Pys4zsfN7zgZpxoapTaofmcS/ZUuQZ8vEnZfOh1raHreMZvRKB6r5XQ2rP1l+R/0zSZX4mbun1oFb/nlqlJ6DBQRYMu/dgpWzu5dpAqdlXSFDrRZBaFTgw+j+zSqS+8Ws/fu5kZm3zADbZoO4djdDBw13BkFpFDcO9lc56AuNIwA3nOzAgA2wfYoC4e3uIW3Znfc3XCLuSsT8wLBf5Cuwd+QjMonAi3qIoKSWK60g1X8i9RhD05OnO61N7LUbhaMiTXXGIoWEJBFhPgECBrahSJypQSl+4AXZytFzfZvG9PGoMnSSicIgXWt8t6frvcmIg==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=kernel.org; dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20201202 header.b=U+eVJA1X; dkim-atps=neutral; spf=pass (client-ip=139.178.84.217; helo=dfw.source.kernel.org; envelope-from=brauner@kernel.org; receiver=lists.ozlabs.org) smtp.mailfrom=kernel.org
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=kernel.org
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20201202 header.b=U+eVJA1X;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=kernel.org (client-ip=139.178.84.217; helo=dfw.source.kernel.org; envelope-from=brauner@kernel.org; receiver=lists.ozlabs.org)
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4YY2qB2VJ5z30N8
	for <linux-erofs@lists.ozlabs.org>; Wed, 15 Jan 2025 21:51:18 +1100 (AEDT)
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
	by dfw.source.kernel.org (Postfix) with ESMTP id E04B75C5507;
	Wed, 15 Jan 2025 10:50:34 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E4ACAC4CEDF;
	Wed, 15 Jan 2025 10:51:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1736938275;
	bh=tkNahj98YF5Ew9ZYvQEGcyHo5n4Mx4vVJRfvbbR6VAw=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=U+eVJA1Xn4mqvlKFvP3aAWpettlbCeZhVUJ+1W3ZBg1FQ6GZv8GlDyPR+CvimRp+k
	 kFnD0VnvN/EJDx+Kt5RMDFsaN6bcEbTG+GcXFjD2s4zrOw67SdJz3z0YgYfyEbnFgC
	 qoTraY202N3uCwZEc9/bnx6MOxRdOsiKx4c4QeubRZktd3tfEvu/KuTDuIe1pAJwSl
	 zuyCMTlepI8A1Spi6F2p+Df7dEPnd5AKWcjf1+is20UHiQyEhnwOezEuhQfuqQE5ux
	 nwyZMg/Gme+ODf/VOH3q68EfkpHxzxTwSrlROY6eWOzludGZrgrPJHDnsctWsiPVi3
	 i7A6EHHBe7i/w==
To: Christoph Hellwig <hch@lst.de>
Subject: Re: lockref cleanups
Date: Wed, 15 Jan 2025 11:50:52 +0100
Message-ID: <20250115-pelzmantel-backen-53605f1b81d7@brauner>
X-Mailer: git-send-email 2.45.2
In-Reply-To: <20250115094702.504610-1-hch@lst.de>
References: <20250115094702.504610-1-hch@lst.de>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
X-Developer-Signature: v=1; a=openpgp-sha256; l=2048; i=brauner@kernel.org; h=from:subject:message-id; bh=tkNahj98YF5Ew9ZYvQEGcyHo5n4Mx4vVJRfvbbR6VAw=; b=owGbwMvMwCU28Zj0gdSKO4sYT6slMaS3T5beILDixlmx47P6j027NGvJ/jyxN3vuTHbPt3quK JHQKm39qKOUhUGMi0FWTJHFod0kXG45T8Vmo0wNmDmsTCBDGLg4BWAi87kZ/pmfutv8qkHN2DUh 7aQx42Lbv1O+rryVyzWf/fEqVmkzfw+Gf8YzQs7/CjY/7Rb7YOFJF3W+F1GyUdPseh4ZfU91qZ0 5lxMA
X-Developer-Key: i=brauner@kernel.org; a=openpgp; fpr=4880B8C9BD0E5106FC070F4F7B3C391EFEA93624
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-5.5 required=5.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,SPF_HELO_NONE,
	SPF_PASS autolearn=disabled version=4.0.0
X-Spam-Checker-Version: SpamAssassin 4.0.0 (2022-12-13) on lists.ozlabs.org
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
Cc: Christian Brauner <brauner@kernel.org>, Andreas Gruenbacher <agruenba@redhat.com>, linux-kernel@vger.kernel.org, gfs2@lists.linux.dev, Al Viro <viro@zeniv.linux.org.uk>, linux-fsdevel@vger.kernel.org, linux-erofs@lists.ozlabs.org, Andrew Morton <akpm@linux-foundation.org>
Errors-To: linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org
Sender: "Linux-erofs" <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>

On Wed, 15 Jan 2025 10:46:36 +0100, Christoph Hellwig wrote:
> this series has a bunch of cosmetic cleanups for the lockref code I came up
> with when reading the code in preparation of adding a new user of it.
> 
> Diffstat:
>  fs/dcache.c             |    3 --
>  fs/erofs/zdata.c        |    3 --
>  fs/gfs2/quota.c         |    3 --
>  include/linux/lockref.h |   26 ++++++++++++++------
>  lib/lockref.c           |   60 ++++++++++++------------------------------------
>  5 files changed, 36 insertions(+), 59 deletions(-)
> 
> [...]

Looks good, thanks!

---

Applied to the vfs-6.14.misc branch of the vfs/vfs.git tree.
Patches in the vfs-6.14.misc branch should appear in linux-next soon.

Please report any outstanding bugs that were missed during review in a
new review to the original patch series allowing us to drop it.

It's encouraged to provide Acked-bys and Reviewed-bys even though the
patch has now been applied. If possible patch trailers will be updated.

Note that commit hashes shown below are subject to change due to rebase,
trailer updates or similar. If in doubt, please check the listed branch.

tree:   https://git.kernel.org/pub/scm/linux/kernel/git/vfs/vfs.git
branch: vfs-6.14.misc

[1/8] lockref: remove lockref_put_not_zero
      https://git.kernel.org/vfs/vfs/c/74b5da771c89
[2/8] lockref: improve the lockref_get_not_zero description
      https://git.kernel.org/vfs/vfs/c/8c7568356d74
[3/8] lockref: use bool for false/true returns
      https://git.kernel.org/vfs/vfs/c/57bd981b2db7
[4/8] lockref: drop superfluous externs
      https://git.kernel.org/vfs/vfs/c/80e2823cbe59
[5/8] lockref: add a lockref_init helper
      https://git.kernel.org/vfs/vfs/c/5f0c395edf59
[6/8] dcache: use lockref_init for d_lockref
      https://git.kernel.org/vfs/vfs/c/24706068b7b6
[7/8] erofs: use lockref_init for pcl->lockref
      https://git.kernel.org/vfs/vfs/c/160a93170d53
[8/8] gfs2: use lockref_init for qd_lockref
      https://git.kernel.org/vfs/vfs/c/0ef3858b15e3
