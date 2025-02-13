Return-Path: <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>
X-Original-To: lists+linux-erofs@lfdr.de
Delivered-To: lists+linux-erofs@lfdr.de
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2404:9400:2:0:216:3eff:fee1:b9f1])
	by mail.lfdr.de (Postfix) with ESMTPS id 3F791A3442C
	for <lists+linux-erofs@lfdr.de>; Thu, 13 Feb 2025 16:01:54 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=lists.ozlabs.org;
	s=201707; t=1739458911;
	bh=W3xinSb8p83qb4kKC0YsIVnfqWprAquWHq119rVNMLw=;
	h=To:Subject:Date:In-Reply-To:References:List-Id:List-Unsubscribe:
	 List-Archive:List-Post:List-Help:List-Subscribe:From:Reply-To:Cc:
	 From;
	b=GA3WF9ASgsjbCGN5sosfOouelKAvL+PW/CInux6LiKzy0L15qj0G5/LIbEl9xTPhi
	 r7KfXmF6N6zQ2y+zAeH70R+IO1JeaFSyt/fdULrnvr4KPjd/S0WBPs0rxslVdMBwaU
	 4qgaM7pTyEnYRZemY0B4VNQQcuXY1exweZ7Gel7AuIlqmwsMxgK03k4b5J8lwDDEKQ
	 7YGFgMm4Y2m7nXKcRTB39KP1TVxiNrbYNTP7tnkPiiKiFBQcFopx9/PSQpaETuueuk
	 B8OSDGEAejuVDRtTgWItEUI55GOj3JvQ9gQ6+zGwe0v6IjzSUb+jGxlNIsKObrFfLR
	 qyfDDdlfnvDjA==
Received: from boromir.ozlabs.org (localhost [IPv6:::1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4Ytz0v1Y0mz30WB
	for <lists+linux-erofs@lfdr.de>; Fri, 14 Feb 2025 02:01:51 +1100 (AEDT)
X-Original-To: linux-erofs@lists.ozlabs.org
Delivered-To: linux-erofs@lists.ozlabs.org
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip=139.178.84.217
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1739458908;
	cv=none; b=QHppzIxOFZLWKQmDwDfG8ABrg+QnQxYYj9iEm84gmCJwZMz4dlYNKgqFiqJpDxrDe1CHgM3nNkEPoL19lgnCofSJszSpTh+Oh7lX0QVpgbJ94DbtlzibYJwwLXU8YJkU3p5CCBOMwSP/6SLkTUywXDLbRys//B0rhiErl3gdzV3ofS6gT4JmXIyJajfHj1iHVJ9wKFEcCQc9t6klAWVJbD5frQagih+DhTgSiawWb+k6zKNrOC+OrdLgc1PTmKsmv0dRLaUzk5iWTVGJweWoltvvytbWwezAud/0SM82mEgyzuGK6gD5Z5kt88sWiOX+9u5RwENuZdh906/JPEvwcA==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1739458908; c=relaxed/relaxed;
	bh=W3xinSb8p83qb4kKC0YsIVnfqWprAquWHq119rVNMLw=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=hLXYs2y+jQkHN6Ry1KfevYkz39U+L4riZk+av9ZglVBdGFjYsLW3/qKRm74dAmP98yfpNtNkMD71+Hy6BfFRYIehWSoEBhydmrK8AUqRkjWbI53ijtJs8MUSjRku43pc+l4bWUAVUh726RJ8MOHhHvXkj2HWNYYVmGejjZORHPAsC6Uv0yRWYb4ZBoJTP+thjDIeseWY2DeJzuRu1l1m1SgHn9xC54dKlqW9RWJr86r/MV18hFQVLvqkwPKuWoPPMP3QPHyqsD/G5qRdJWltmThx6TWCCVt3ATliJVGjPKnVxvhw6n4YhgsXvikQn9CCBX20Ot++8lBlutLNUHMWIQ==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=kernel.org; dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20201202 header.b=a05nNJBU; dkim-atps=neutral; spf=pass (client-ip=139.178.84.217; helo=dfw.source.kernel.org; envelope-from=brauner@kernel.org; receiver=lists.ozlabs.org) smtp.mailfrom=kernel.org
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=kernel.org
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20201202 header.b=a05nNJBU;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=kernel.org (client-ip=139.178.84.217; helo=dfw.source.kernel.org; envelope-from=brauner@kernel.org; receiver=lists.ozlabs.org)
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4Ytz0q6y4bz2yvk
	for <linux-erofs@lists.ozlabs.org>; Fri, 14 Feb 2025 02:01:47 +1100 (AEDT)
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
	by dfw.source.kernel.org (Postfix) with ESMTP id CE9C15C575E;
	Thu, 13 Feb 2025 15:01:05 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4582FC4CED1;
	Thu, 13 Feb 2025 15:01:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1739458905;
	bh=M392JolpqBN59UU7gj1lCbZNzReqJFGeXEqLCAtPZIo=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=a05nNJBUGp8ldp6m7CxxQpionQHaidKP1wtCgpsDBiaAlk+TJxXuOBid1JHLpxhYe
	 RRYvXjSgJTb6djMCF88SXDmbPfTU0RCq+MnBP1LFA1VUpRPXpjZ+Tsd1Uj4GPOGDW5
	 xtZETGfyQamJSU/DaXSN7wG1yuq0y70qozSS5ztzjnvGF0RNaFQc+F50d9FkkZ3u22
	 GlXPPbGgDI6NkXrMxE7EfE8Gkq5jopatEuyWY70TopeDiNOx6MUkF17E9PZvSjUnaR
	 yASl9kNkKq706ougqtL3coEehtbb9A3sEraayr/vC1irSrBQB9IyKkJu8PdoHDmbFP
	 DKMMA1AQurMGQ==
To: David Howells <dhowells@redhat.com>
Subject: Re: [PATCH 0/3] netfs: Miscellaneous fixes
Date: Thu, 13 Feb 2025 16:01:24 +0100
Message-ID: <20250213-kosenamen-bestochen-0d997261875e@brauner>
X-Mailer: git-send-email 2.47.2
In-Reply-To: <20250212222402.3618494-1-dhowells@redhat.com>
References: <20250212222402.3618494-1-dhowells@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
X-Developer-Signature: v=1; a=openpgp-sha256; l=1290; i=brauner@kernel.org; h=from:subject:message-id; bh=M392JolpqBN59UU7gj1lCbZNzReqJFGeXEqLCAtPZIo=; b=owGbwMvMwCU28Zj0gdSKO4sYT6slMaSv4wx4qRqnFzRflWne51XHu+cbHcxM/LR4XWtwoIP68 pjO1Di5jlIWBjEuBlkxRRaHdpNwueU8FZuNMjVg5rAygQxh4OIUgIncUGH4Hzljn3D5UVnhu+8v H3HpkQj4c+vpHef+E9JuPMKmR1fNfsfwP+BBsxSb6ufgd6c/ROlzPtv598zXZ99Sq1J6GpewNHO oMAAA
X-Developer-Key: i=brauner@kernel.org; a=openpgp; fpr=4880B8C9BD0E5106FC070F4F7B3C391EFEA93624
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-5.2 required=5.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
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
Cc: Paulo Alcantara <pc@manguebit.com>, Tom Talpey <tom@talpey.com>, Christian Brauner <brauner@kernel.org>, linux-cifs@vger.kernel.org, linux-fsdevel@vger.kernel.org, Dominique Martinet <asmadeus@codewreck.org>, Jeff Layton <jlayton@kernel.org>, Max Kellermann <max.kellermann@ionos.com>, v9fs@lists.linux.dev, linux-kernel@vger.kernel.org, Steve French <sfrench@samba.org>, Ihor Solodrai <ihor.solodrai@linux.dev>, linux-mm@kvack.org, linux-nfs@vger.kernel.org, Marc Dionne <marc.dionne@auristor.com>, netfs@lists.linux.dev, ceph-devel@vger.kernel.org, Eric Van Hensbergen <ericvh@kernel.org>, linux-erofs@lists.ozlabs.org, linux-afs@lists.infradead.org
Errors-To: linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org
Sender: "Linux-erofs" <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>

On Wed, 12 Feb 2025 22:23:58 +0000, David Howells wrote:
> Here are some miscellaneous fixes and changes for netfslib, if you could
> pull them:
> 
>  (1) Fix a number of read-retry hangs, including:
> 
>      (a) Incorrect getting/putting of references on subreqs as we retry
>      	 them.
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

[1/3] netfs: Fix a number of read-retry hangs
      https://git.kernel.org/vfs/vfs/c/1d0013962d22
[2/3] netfs: Add retry stat counters
      https://git.kernel.org/vfs/vfs/c/d01c495f432c
[3/3] netfs: Fix setting NETFS_RREQ_ALL_QUEUED to be after all subreqs queued
      https://git.kernel.org/vfs/vfs/c/5de0219a9bb9
