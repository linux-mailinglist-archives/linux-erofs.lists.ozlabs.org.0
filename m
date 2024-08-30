Return-Path: <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>
X-Original-To: lists+linux-erofs@lfdr.de
Delivered-To: lists+linux-erofs@lfdr.de
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	by mail.lfdr.de (Postfix) with ESMTPS id A41F99662CC
	for <lists+linux-erofs@lfdr.de>; Fri, 30 Aug 2024 15:21:02 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=lists.ozlabs.org;
	s=201707; t=1725024060;
	bh=1fa8JFgeAi/ZlMTSUfcr9ne/8HXdsxXnAZE+mZp+p6U=;
	h=To:Subject:Date:In-Reply-To:References:List-Id:List-Unsubscribe:
	 List-Archive:List-Post:List-Help:List-Subscribe:From:Reply-To:Cc:
	 From;
	b=faRrhdBk3brYk7oBVYQbxpSh+MTshlxt1liwPejS14rQUEmlNGp+jaOq6mawoAzUH
	 aY4WOKcQhm8mcmOkRcgkX5CVdAtS6Karpq/onjqNCdCxMYJmLcg2hQnMLiBfuL9ksW
	 iNnOiVhjyTxyNdb6hmcXrLFoHnB0a31jeuiCYZUZLXF87PohSyeK8gWswwAdkqe+QW
	 mxKk/uU1jzZHGUQAcY5IEE+ZXGgyWlXX0ysbng5g4idL9nJicVoX1p75hpnNqfzJ7w
	 a2oWMSrWCd57GqZfdhP4J/y87i3w5cfm/07braJiB4py/YH55ZYUgFoMHXrITabt9A
	 0vrI9CqMF4UBg==
Received: from boromir.ozlabs.org (localhost [IPv6:::1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4WwJgc27Hfz30HH
	for <lists+linux-erofs@lfdr.de>; Fri, 30 Aug 2024 23:21:00 +1000 (AEST)
X-Original-To: linux-erofs@lists.ozlabs.org
Delivered-To: linux-erofs@lists.ozlabs.org
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip="2604:1380:4601:e00::1"
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1725024056;
	cv=none; b=GqVPdYuc8j6UCad2aLeeJZJeyUq0+p6k+V1PVTO3xI2Wjh8PhcANyrHVoSRxpQDqKLeOBybwlYRKw8enLCE11U02KuhQWIO5YPeCiTdA/v0AEdmN586uOoNVlNBGivzqtL9bbtJyvnP7EUwOCUdUF7EjcoHpH5gBltgZDC1JySq7hrcIibcP9WWdyrcsNnv5bFWJWAu00VgRk2W72UntZdW1q3wVQ6sRtBDoMdCApO2wKQay9TKrsbiUuuUscK66MYg/p4K0JrPMoMcQQ31GJb11CXC5SUSqxTgpUAxV4Zvlfi+fH93YSyGObvatb/NiErrli0JF7Ut09vLdjKV2NA==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1725024056; c=relaxed/relaxed;
	bh=1fa8JFgeAi/ZlMTSUfcr9ne/8HXdsxXnAZE+mZp+p6U=;
	h=X-Greylist:Received:Received:DKIM-Signature:From:To:Cc:Subject:
	 Date:Message-ID:X-Mailer:In-Reply-To:References:MIME-Version:
	 Content-Type:X-Developer-Signature:X-Developer-Key:
	 Content-Transfer-Encoding; b=MCp0+1MtusppxPfCkk7irZj168RTASjRiJCi7ObJoxZzRGZ9R7CrffEtQg2ld7j9tv++nDTVtQD2b8OtmLNgzClzWEYT1Dt35FMhckwQk6u0R7HHKXJgahygdfp3Hc07uccu8u4DaRhIcUF8fjLR19NWJpmZsvgGWozOfbKvc3GXGun0/DIRxifwNYFXGP2AiJmvBodZ/uJ0AN5g+tUlC+1Ugq0D95u//PjHhmT2yb2VAALWPUvdqwe0Lz4Ks7pKVkMvamBxhhrdELIZKB+FWabNTH66IIzyfVcEl+Q5XpN4vwbkgeK9cQfBgthfEiwArKu4O3QbPpWpXe4+AVHwZg==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=kernel.org; dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20201202 header.b=Ty5bAm6t; dkim-atps=neutral; spf=pass (client-ip=2604:1380:4601:e00::1; helo=ams.source.kernel.org; envelope-from=brauner@kernel.org; receiver=lists.ozlabs.org) smtp.mailfrom=kernel.org
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=kernel.org
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20201202 header.b=Ty5bAm6t;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=kernel.org (client-ip=2604:1380:4601:e00::1; helo=ams.source.kernel.org; envelope-from=brauner@kernel.org; receiver=lists.ozlabs.org)
X-Greylist: delayed 505 seconds by postgrey-1.37 at boromir; Fri, 30 Aug 2024 23:20:56 AEST
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits))
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4WwJgX2Hrnz2yp9
	for <linux-erofs@lists.ozlabs.org>; Fri, 30 Aug 2024 23:20:56 +1000 (AEST)
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
	by ams.source.kernel.org (Postfix) with ESMTP id 4C366AE3A20;
	Fri, 30 Aug 2024 13:12:18 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1D2B4C4CEC2;
	Fri, 30 Aug 2024 13:12:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1725023543;
	bh=WndIbO8xrC2aIrGdqBcilJuDXzO/BXzIA8VlzOJWcDo=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=Ty5bAm6tFv6bg4YA3HAyot4VdLW2RJKGdG1xvdXVogremu8LD3BqEh4VHwGPQbh1p
	 g5wB6d5xMedceeupVFRBiOJF2X1RQbXR7I/eTH3weokE6ad0t6Ezo6vHjcDKPVbTlB
	 Z3S4gJVFjrB6hycktKp1ueGv6wungGZ3cKnt0wXInlgTLGxuCAHj3w8ZYHqjF+GFUB
	 QTyvsjOBPVrVpsZuumcYH8TAjCVp5l1eYu4rXoVRWjPjq8sCLqJLVtHIh6i3fVU/nI
	 SVYRAvH1Ts46AhfsHIwkNzc0SvAJDkfT/NWnyDPoWUXLCHntm7LX/eW8iyDDIh7MGs
	 GI0a1819kd2HQ==
To: David Howells <dhowells@redhat.com>
Subject: Re: (subset) [PATCH 4/6] mm: Fix filemap_invalidate_inode() to use invalidate_inode_pages2_range()
Date: Fri, 30 Aug 2024 15:12:02 +0200
Message-ID: <20240830-anteil-haarfarbe-d11935ac1017@brauner>
X-Mailer: git-send-email 2.45.2
In-Reply-To: <20240828210249.1078637-5-dhowells@redhat.com>
References: <20240828210249.1078637-1-dhowells@redhat.com> <20240828210249.1078637-5-dhowells@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
X-Developer-Signature: v=1; a=openpgp-sha256; l=1253; i=brauner@kernel.org; h=from:subject:message-id; bh=WndIbO8xrC2aIrGdqBcilJuDXzO/BXzIA8VlzOJWcDo=; b=owGbwMvMwCU28Zj0gdSKO4sYT6slMaRdPKr76Dezq5ehzM4jKYrG1ftWrXx6vvm+7LaNC7uZV E+srfHd1FHKwiDGxSArpsji0G4SLrecp2KzUaYGzBxWJpAhDFycAjCRR5oM/1T7Tb2YfR5sYXnu FDtjHaviHxfHAmW1+apKn47PLwxJcWBkWDj/YHmXY6+ZxwZFZ420TYu1Jiiw5DG/WmQs9an18sQ 6HgA=
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
Cc: Dominique Martinet <asmadeus@codewreck.org>, linux-mm@kvack.org, Christoph Hellwig <hch@lst.de>, Paulo Alcantara <pc@manguebit.com>, linux-cifs@vger.kernel.org, Miklos Szeredi <miklos@szeredi.hu>, Matthew Wilcox <willy@infradead.org>, linux-afs@lists.infradead.org, devel@lists.orangefs.org, linux-nfs@vger.kernel.org, Tom Talpey <tom@talpey.com>, Alexander Viro <viro@zeniv.linux.org.uk>, ceph-devel@vger.kernel.org, Trond Myklebust <trond.myklebust@hammerspace.com>, Christian Brauner <brauner@kernel.org>, v9fs@lists.linux.dev, Jeff Layton <jlayton@kernel.org>, linux-kernel@vger.kernel.org, Steve French <sfrench@samba.org>, linux-fsdevel@vger.kernel.org, netfs@lists.linux.dev, Andrew Morton <akpm@linux-foundation.org>, linux-erofs@lists.ozlabs.org
Errors-To: linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org
Sender: "Linux-erofs" <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>

On Wed, 28 Aug 2024 22:02:45 +0100, David Howells wrote:
> Fix filemap_invalidate_inode() to use invalidate_inode_pages2_range()
> rather than truncate_inode_pages_range().  The latter clears the
> invalidated bit of a partial pages rather than discarding it entirely.
> This causes copy_file_range() to fail on cifs because the partial pages at
> either end of the destination range aren't evicted and reread, but rather
> just partly cleared.
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

[4/6] mm: Fix filemap_invalidate_inode() to use invalidate_inode_pages2_range()
      https://git.kernel.org/vfs/vfs/c/c26096ee0278
