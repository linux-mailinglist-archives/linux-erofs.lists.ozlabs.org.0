Return-Path: <linux-erofs+bounces-1873-lists+linux-erofs=lfdr.de@lists.ozlabs.org>
X-Original-To: lists+linux-erofs@lfdr.de
Delivered-To: lists+linux-erofs@lfdr.de
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2404:9400:21b9:f100::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 2715FD1FCAB
	for <lists+linux-erofs@lfdr.de>; Wed, 14 Jan 2026 16:35:45 +0100 (CET)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4drqvL6V7Xz2xT6;
	Thu, 15 Jan 2026 02:35:42 +1100 (AEDT)
X-Original-To: linux-erofs@lists.ozlabs.org
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip=172.234.252.31
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1768404942;
	cv=none; b=W5fNCUp5Ntsy5trz9oIAomqIMi3LO7CSiVz/VJRo37zi11pFzNmdQyKJMqwkGBYSiglcUu3Q9XwD38eGH8P1tmpckR7Lj8kTAwlfWTvEDGWoOf/O0fVkr7+YQJYc0Y47xIZyyMIHnqIzcTWxez/db0ymQxQkyzbl4SA5Qy7HnbAXDaIPOf/TDzrv5ykLr8zt+lnuKC/jEXJelKzEX2KMWioUmvpGFhvyD8vZIlJC7kcaDvR6sVddAVS18lw1PSkKZ3iUBwRy+AUHwyNjgsbwAiDDoi98cpWwlQQdR96oeCgmXBaMias/9GxX1OWqUpnkQbvNvvWRL1D2ZCypwCJW1Q==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1768404942; c=relaxed/relaxed;
	bh=aE9lodvLCPlAeOGfhXZJ4tH4TS9h+gE2iAhCLk9QB/o=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=ORXZfCCTfL/JobTuEr3eGBR4mLSm2jlaxWlb553w3Itpr3o+Ig7bCW+BL1cmuP6hpE7gnNzZucImeSiGYi8gnrShPfwqF8YtVDleRbdv87aqeoxsyEdz8Btzl2HGntGRe/bDTdDBb76OBUy/qgu73OMOZlu0CB2r0nsw3Re0Y6z2toYGglhnCJwCphMer9HJWIJnyqA5OhDMo8KuYycCRU6Kk67wzrBB0J2381d2KGytrciTq8YQPRR65A7xWWDCV2X/Uxu/9p7/OeUQ/wLlEuJfWODXK4aSTBk9CeklSN/+scPO2hhtlIh0rR1OKkBuErMUA3HV0e4BnepXfm8Xog==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=kernel.org; dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20201202 header.b=CfB+WzQl; dkim-atps=neutral; spf=pass (client-ip=172.234.252.31; helo=sea.source.kernel.org; envelope-from=brauner@kernel.org; receiver=lists.ozlabs.org) smtp.mailfrom=kernel.org
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=kernel.org
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20201202 header.b=CfB+WzQl;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=kernel.org (client-ip=172.234.252.31; helo=sea.source.kernel.org; envelope-from=brauner@kernel.org; receiver=lists.ozlabs.org)
Received: from sea.source.kernel.org (sea.source.kernel.org [172.234.252.31])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4drqvL2Cq0z2xNg
	for <linux-erofs@lists.ozlabs.org>; Thu, 15 Jan 2026 02:35:42 +1100 (AEDT)
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
	by sea.source.kernel.org (Postfix) with ESMTP id 9DBBF42AB2;
	Wed, 14 Jan 2026 15:35:40 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 31AECC4CEF7;
	Wed, 14 Jan 2026 15:35:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1768404940;
	bh=eKXn8huwgC3ZEDImWl+HYtwWWnTF2SqBo1ZJ072ZqKE=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=CfB+WzQlxfM1YRtgmk7/o/Q6os+viuowRQlTste7/tCCa3GR+lWoDezERZ+WI7zez
	 GWPP7xW90MipQ6se7+e0hAm/E+QLp50/B9KboptAIx42aUN3Jf8sbSYa163EpLcVEJ
	 WVYZgfdTuNJGhuxXrTWPMoBP2QzeiAnhiOZItqr3SGQXRRu+OG+U1wL3TPGvgLXBce
	 HiJePu2AJhYeZPdGgRsHMU84wGHgx2doZgcUfVgRYRo30YziFZTkVVYUnX3/8T7gmZ
	 XTUKwaidc10bxdf3Gp/pgp/5LU/cxGiweVKvAOzEDDyhIBq8gXrXKcGhhuhK5Y4YcX
	 VVxwvhgDpBYGw==
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
Date: Wed, 14 Jan 2026 16:35:27 +0100
Message-ID: <20260114-wirkung-planwagen-2f45216c3645@brauner>
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
X-Developer-Signature: v=1; a=openpgp-sha256; l=1386; i=brauner@kernel.org; h=from:subject:message-id; bh=eKXn8huwgC3ZEDImWl+HYtwWWnTF2SqBo1ZJ072ZqKE=; b=owGbwMvMwCU28Zj0gdSKO4sYT6slMWSmbz/OG3Dk8Y7pHUqOT94o1G3c9Jtzp3yfSvtUkfjT0 fJJ/6/s6ShlYRDjYpAVU2RxaDcJl1vOU7HZKFMDZg4rE8gQBi5OAZhIuh0jw8ILSxV9b9ebvOz/ fOK3fUFEb5uTbILO8cTZ2l7H55xxXcDI8OfmG8NUL0PPnbEK0SnrTuzkffHica3NQ9uVmptMJml 94QQA
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

