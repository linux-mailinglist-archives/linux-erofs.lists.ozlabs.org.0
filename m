Return-Path: <linux-erofs+bounces-1871-lists+linux-erofs=lfdr.de@lists.ozlabs.org>
X-Original-To: lists+linux-erofs@lfdr.de
Delivered-To: lists+linux-erofs@lfdr.de
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2404:9400:21b9:f100::1])
	by mail.lfdr.de (Postfix) with ESMTPS id BD496D1FC60
	for <lists+linux-erofs@lfdr.de>; Wed, 14 Jan 2026 16:33:49 +0100 (CET)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4drqs72JQyz2xT6;
	Thu, 15 Jan 2026 02:33:47 +1100 (AEDT)
X-Original-To: linux-erofs@lists.ozlabs.org
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip="2600:3c04:e001:324:0:1991:8:25"
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1768404827;
	cv=none; b=KT2A7QSHy756X8LlXICjk7yObSvPw6qSuzOvuCbbvipy4zvcGE3p9OR8dIwiaJKxUTy+Bs6lPoRAA0rJLzOYp/8Gzp6/KNGgsM01Om+2QG43uZbD6XKYBn30IlByfCy+xqpZXsFSuRoFs6qMZ3n0bJbT+nlRVMRH1osW30iZoDYtV5Ry3JBSQAnHXTrU+BtihgwoF+R8grYmlJ1RJPoRIiHW7og/Lnyouh0nNcYez9bt1XbgMPH+fAT4S+9Ny646ECriKrEr0ycOh71wy0J8qPdGkSN23Tx718DZ4wcC+eZJVu/toas4qWMUqg00/YhjsdePY9FRPbbIIKGsT/kCIA==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1768404827; c=relaxed/relaxed;
	bh=aE9lodvLCPlAeOGfhXZJ4tH4TS9h+gE2iAhCLk9QB/o=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=Eg8j6gWSxM3D8iUQViak04LtiqEdQ+4yacd6JAPCEea353f0zal/ktXBm0gxwI/ALhU239qqrIutE4didVH21DGyfCmW4xjjSR1THIQiFSSPi4d9VyoLF7/lDOId2xCoz9g5hRtb39FQxEfbLuJBtoxthYSjKj/iJszKAA3etC3OyNjb+UFc+l0MSCTuM9m2wJ6BnAZnYFF+b5Gzp9I0Ume2d/y0M/hBFzhVYV2dEhPAdLn6NrD75cg7WzzDdL18Na9sNSniKYzq9Wg5hE0aentyfTBtQjnU61bu2ydnvjhzntYk4xqDkcm1gF4b1P8807EZ3dkt14U22LBY7NhQDw==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=kernel.org; dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20201202 header.b=sdUp5Hdq; dkim-atps=neutral; spf=pass (client-ip=2600:3c04:e001:324:0:1991:8:25; helo=tor.source.kernel.org; envelope-from=brauner@kernel.org; receiver=lists.ozlabs.org) smtp.mailfrom=kernel.org
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=kernel.org
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20201202 header.b=sdUp5Hdq;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=kernel.org (client-ip=2600:3c04:e001:324:0:1991:8:25; helo=tor.source.kernel.org; envelope-from=brauner@kernel.org; receiver=lists.ozlabs.org)
X-Greylist: delayed 441 seconds by postgrey-1.37 at boromir; Thu, 15 Jan 2026 02:33:46 AEDT
Received: from tor.source.kernel.org (tor.source.kernel.org [IPv6:2600:3c04:e001:324:0:1991:8:25])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4drqs64lYWz2xNg
	for <linux-erofs@lists.ozlabs.org>; Thu, 15 Jan 2026 02:33:46 +1100 (AEDT)
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
	by tor.source.kernel.org (Postfix) with ESMTP id 640D16001A;
	Wed, 14 Jan 2026 15:33:44 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D4DADC4CEF7;
	Wed, 14 Jan 2026 15:33:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1768404824;
	bh=eKXn8huwgC3ZEDImWl+HYtwWWnTF2SqBo1ZJ072ZqKE=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=sdUp5Hdqng72DgawpASzAQd1tQWNDB00unhfFCktVQAtRnLTVA6k4zY4ckwXGF0mO
	 IIfqIuPqVJ52KKXk+GnyBaae1MFSd6blVN8jDW15BukAc7hmSYwdYz9z8xPp5Q53Ld
	 VrrFo1Fg4WEMr6amjuhJiGeXJZIFbs4lB9CZLFTPy+XyixLJpvnYh8iBBzIg+Zo1Wq
	 t9tITlmpFoU8Tg6XKw5eRnpgni3mhVq8UxZFMiTr/pqCm8VjNcYG7o6IpGAoY9K3to
	 bwBjODpefZFmJZhdqdW1mpBXTP9ISTaXg1fue4SHO8V9Qe5xC/ArD6tjVeXJOdNRhG
	 iLBtccF7U9WRA==
From: Christian Brauner <brauner@kernel.org>
To: Hongbo Li <lihongbo22@huawei.com>
Cc: Christian Brauner <brauner@kernel.org>,
	djwong@kernel.org,
	amir73il@gmail.com,
	hch@lst.de,
	linux-fsdevel@vger.kernel.org,
	linux-erofs@lists.ozlabs.org,
	linux-kernel@vger.kernel.org,
	chao@kernel.org,
	Gao Xiang <xiang@kernel.org>
Subject: Re: (subset) [PATCH v14 00/10] erofs: Introduce page cache sharing feature
Date: Wed, 14 Jan 2026 16:33:33 +0100
Message-ID: <20260114-neufahrzeuge-urfassung-103f4ab953be@brauner>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20260109102856.598531-1-lihongbo22@huawei.com>
References: <20260109102856.598531-1-lihongbo22@huawei.com>
X-Mailing-List: linux-erofs@lists.ozlabs.org
List-Id: <linux-erofs.lists.ozlabs.org>
List-Help: <mailto:linux-erofs+help@lists.ozlabs.org>
List-Owner: <mailto:linux-erofs+owner@lists.ozlabs.org>
List-Post: <mailto:linux-erofs@lists.ozlabs.org>
List-Subscribe: <mailto:linux-erofs+subscribe@lists.ozlabs.org>,
  <mailto:linux-erofs+subscribe-digest@lists.ozlabs.org>,
  <mailto:linux-erofs+subscribe-nomail@lists.ozlabs.org>
List-Unsubscribe: <mailto:linux-erofs+unsubscribe@lists.ozlabs.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
X-Developer-Signature: v=1; a=openpgp-sha256; l=1386; i=brauner@kernel.org; h=from:subject:message-id; bh=eKXn8huwgC3ZEDImWl+HYtwWWnTF2SqBo1ZJ072ZqKE=; b=owGbwMvMwCU28Zj0gdSKO4sYT6slMWSmbw8Ssa3TnqZh/WXGzxvfuGcsWfhY0vNAy5MDeXzHL Vxts/OKO0pZGMS4GGTFFFkc2k3C5ZbzVGw2ytSAmcPKBDKEgYtTACZy8xnDX0HVye+mi16T6n7w TP/Ctp6Nlet05xrkHhF5dENy46W01mJGhoUblmjcNL7989Dum3ECEvLT0/z3VmtkzQlx8Pu9Iv/ NFDYA
X-Developer-Key: i=brauner@kernel.org; a=openpgp; fpr=4880B8C9BD0E5106FC070F4F7B3C391EFEA93624
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-0.2 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS
	autolearn=disabled version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-25) on lists.ozlabs.org

On Fri, 09 Jan 2026 10:28:46 +0000, Hongbo Li wrote:
> Enabling page cahe sharing in container scenarios has become increasingly
> crucial, as it can significantly reduce memory usage. In previous efforts,
> Hongzhen has done substantial work to push this feature into the EROFS
> mainline. Due to other commitments, he hasn't been able to continue his
> work recently, and I'm very pleased to build upon his work and continue
> to refine this implementation.
> 
> [...]

Applied to the vfs-7.0.iomap branch of the vfs/vfs.git tree.
Patches in the vfs-7.0.iomap branch should appear in linux-next soon.

Please report any outstanding bugs that were missed during review in a
new review to the original patch series allowing us to drop it.

It's encouraged to provide Acked-bys and Reviewed-bys even though the
patch has now been applied. If possible patch trailers will be updated.

Note that commit hashes shown below are subject to change due to rebase,
trailer updates or similar. If in doubt, please check the listed branch.

tree:   https://git.kernel.org/pub/scm/linux/kernel/git/vfs/vfs.git
branch: vfs-7.0.iomap

[01/10] iomap: stash iomap read ctx in the private field of iomap_iter
        https://git.kernel.org/vfs/vfs/c/8806f279244b
[02/10] erofs: hold read context in iomap_iter if needed
        https://git.kernel.org/vfs/vfs/c/8d407bb32186

