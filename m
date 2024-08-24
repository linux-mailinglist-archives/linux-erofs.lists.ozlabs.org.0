Return-Path: <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>
X-Original-To: lists+linux-erofs@lfdr.de
Delivered-To: lists+linux-erofs@lfdr.de
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2404:9400:2:0:216:3eff:fee1:b9f1])
	by mail.lfdr.de (Postfix) with ESMTPS id 3737395DE4F
	for <lists+linux-erofs@lfdr.de>; Sat, 24 Aug 2024 16:13:26 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=lists.ozlabs.org;
	s=201707; t=1724508802;
	bh=tJyskQjErYCwy0sqfUFqWgmexg832O6B4bOQB9K1w20=;
	h=To:Subject:Date:In-Reply-To:References:List-Id:List-Unsubscribe:
	 List-Archive:List-Post:List-Help:List-Subscribe:From:Reply-To:Cc:
	 From;
	b=j/+ATjWTOTZEhhxUqxNyRFI73WP9SwpXEil4Oswi1eVvhwhLShEgfNci6ajIR5lfS
	 XS1ILUVmw1t3TF/Lvf4HfAqg+A3jxvQaGKVYHOZaIdubWuor2oyEDSCbht9ctrmqzz
	 2Q07JMxkaa3EuSPmsq8acvvrOOIubMciQxJ7VI/JGA3DgnsG8al46fS6yIRZItF1xd
	 2Dpyjg980wGlG2SHhmWSuHel3kwCTiekOtJmVOEIygt6hWBMBTAcnNNV6O/rX7+5iH
	 4fzJM8LBr+xPc3rrgo9yRy2cKayxICf3YZE4yaK9gyVPEwlpvtyFpvJiP2IEOeZxFd
	 h5ZMh3RDXvAAA==
Received: from boromir.ozlabs.org (localhost [IPv6:::1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4Wrf6p3jtCz2yGX
	for <lists+linux-erofs@lfdr.de>; Sun, 25 Aug 2024 00:13:22 +1000 (AEST)
X-Original-To: linux-erofs@lists.ozlabs.org
Delivered-To: linux-erofs@lists.ozlabs.org
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip="2604:1380:4641:c500::1"
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1724508800;
	cv=none; b=R882zfFtPvjcJVIIygJllywn0ZpdXOqu1Svzw6w1/RiRHPI8GMXtWdvBh3dKLm4UXzz+ucZInEN+6Nn0GLH1l5dc5AWnMTfH93AzoPNBgo13GQ0jVZ8fFmHhMsAAYojCkmIABcsSe+29UP4tkJsta8VOz66YS6l1Kyl9qCWa7WN4loqu2aotVJBLgT/1JqCDgFBwWS1RP1U2COx0lUz8xDj1pDrRu89ebgNJK+yCJDDZUChhSdwzrMfCN44U6jtEINjmdMSNuJqU3+anEEOo7q3yGBplbJE6LMcB5kAVs1NNlZWfVx0hh+Cj/cfVKaCzjTstEFw7EVPerZl5Ejhi3g==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1724508800; c=relaxed/relaxed;
	bh=tJyskQjErYCwy0sqfUFqWgmexg832O6B4bOQB9K1w20=;
	h=Received:Received:DKIM-Signature:From:To:Cc:Subject:Date:
	 Message-ID:X-Mailer:In-Reply-To:References:MIME-Version:
	 Content-Type:X-Developer-Signature:X-Developer-Key:
	 Content-Transfer-Encoding; b=NbQCWYndo69qMdoathuDeC2LS5mSXSfXWwNljWbeXhzu/vpClW66mbS9aMq1vYLVw1lE8yNdMeN+Vg/lotxZ8XNLS80gBVnqaYLxMfWfevGk2qwFWWLsaxuo1cXj7YaCkWF0WKW9kiRmp9NVMXf00hYkW23usobjyuUnaJglGHMSBs1qIgAMrkAC+ANb8UCo2ZZjWT8E/EG4UGwzOrnelDWwpJ9L7g3HHHGmrHb5Xz+hgG4dB3cn4FwPKdH6czjkFtQ+Z5Jj5FlFd1w9+JyBDNelBrTZHrcINsxdruaq3x1yOHaGf4yw0HZMK/JWLN8U+ut5dowoVZa6Qrsr+9gNtw==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=kernel.org; dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20201202 header.b=TSGnLKAX; dkim-atps=neutral; spf=pass (client-ip=2604:1380:4641:c500::1; helo=dfw.source.kernel.org; envelope-from=brauner@kernel.org; receiver=lists.ozlabs.org) smtp.mailfrom=kernel.org
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=kernel.org
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20201202 header.b=TSGnLKAX;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=kernel.org (client-ip=2604:1380:4641:c500::1; helo=dfw.source.kernel.org; envelope-from=brauner@kernel.org; receiver=lists.ozlabs.org)
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4Wrf6l4t08z2xxy
	for <linux-erofs@lists.ozlabs.org>; Sun, 25 Aug 2024 00:13:19 +1000 (AEST)
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
	by dfw.source.kernel.org (Postfix) with ESMTP id 5D3CF601CD;
	Sat, 24 Aug 2024 14:13:12 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 29A59C32781;
	Sat, 24 Aug 2024 14:13:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1724508792;
	bh=1RROgoMoiIURZrgBI0u+sQOi22mVdm5uhe2i5PEaJ7Q=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=TSGnLKAXbEucvWAQfLpYFzmykp5QeFdt9IGLO+QBd3M9TQsdDcpmVFe8sIb1ZSi0l
	 +xUKZvMbaYbGjtogaGv09XTXzAuo3HtUW2ICNSKj9fMMR27DBbK2E1mYlZ8J2gyerm
	 /1PL8xB02z5ButNd1qgVUbpCElWMbZ1P1wArc2W84/S5cKlHRjHUEhfBiwOjHiEORA
	 DrUX7VJMPECqiLrCo6LNitskmpC6nLf+zytSgeFiVmlaE/DoS2qzaGEi+wgkLOLxVK
	 IaO8KNkckCOjIhYKAqG+j4ZySWSAQ7nLPL5KSegXJ7SMcBj+z2/inWTDbW9aFUtA0+
	 eYCtNddeZ/ciw==
To: David Howells <dhowells@redhat.com>,
	Steve French <sfrench@samba.org>
Subject: Re: (subset) [PATCH 0/9] netfs, cifs: Combined repost of fixes for truncation, DIO read and read-retry
Date: Sat, 24 Aug 2024 16:09:51 +0200
Message-ID: <20240824-ohrwurm-kernaufgabe-6253ce9cb620@brauner>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240823200819.532106-1-dhowells@redhat.com>
References: <20240823200819.532106-1-dhowells@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
X-Developer-Signature: v=1; a=openpgp-sha256; l=1823; i=brauner@kernel.org; h=from:subject:message-id; bh=1RROgoMoiIURZrgBI0u+sQOi22mVdm5uhe2i5PEaJ7Q=; b=owGbwMvMwCU28Zj0gdSKO4sYT6slMaSdfJVffXKaT/8Pjqu3GVvfLH2vu2VCaW5K1dO7uq5zj 7TqHFq0s6OUhUGMi0FWTJHFod0kXG45T8Vmo0wNmDmsTCBDGLg4BWAiD5IZGRo7T3+Ld/D4IPp9 k8KLx7tbnO8x+ez5wfR20v6496lRfS4M/11XbSi+/6B3pnG0bXW1kq909nHuDUFrV6Rdv7zltM8 eB24A
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
Cc: Pankaj Raghav <p.raghav@samsung.com>, Paulo Alcantara <pc@manguebit.com>, Christian Brauner <brauner@kernel.org>, linux-cifs@vger.kernel.org, v9fs@lists.linux.dev, Jeff Layton <jlayton@kernel.org>, linux-nfs@vger.kernel.org, Matthew Wilcox <willy@infradead.org>, linux-kernel@vger.kernel.org, linux-mm@kvack.org, linux-fsdevel@vger.kernel.org, netfs@lists.linux.dev, ceph-devel@vger.kernel.org, linux-erofs@lists.ozlabs.org, linux-afs@lists.infradead.org
Errors-To: linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org
Sender: "Linux-erofs" <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>

On Fri, 23 Aug 2024 21:08:08 +0100, David Howells wrote:
> Firstly, there are some fixes for truncation, netfslib and afs that I
> discovered whilst trying Pankaj Raghav's minimum folio order patchset:
> 
>  (1) Fix truncate to make it honour AS_RELEASE_ALWAYS in a couple of places
>      that got missed.
> 
>  (2) Fix duplicated editing of a partially invalidated folio in afs's
>      post-setattr edit phase.
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

[1/9] mm: Fix missing folio invalidation calls during truncation
      https://git.kernel.org/vfs/vfs/c/0aa2e1b2fb7a
[2/9] afs: Fix post-setattr file edit to do truncation correctly
      https://git.kernel.org/vfs/vfs/c/a74ee0e878e2
[3/9] netfs: Fix netfs_release_folio() to say no if folio dirty
      https://git.kernel.org/vfs/vfs/c/7dfc8f0c6144
[4/9] netfs: Fix trimming of streaming-write folios in netfs_inval_folio()
      https://git.kernel.org/vfs/vfs/c/cce6bfa6ca0e
[5/9] netfs: Fix missing iterator reset on retry of short read
      https://git.kernel.org/vfs/vfs/c/950b03d0f664
[10/10] netfs: Fix interaction of streaming writes with zero-point tracker
        https://git.kernel.org/vfs/vfs/c/e00e99ba6c6b
