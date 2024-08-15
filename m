Return-Path: <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>
X-Original-To: lists+linux-erofs@lfdr.de
Delivered-To: lists+linux-erofs@lfdr.de
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	by mail.lfdr.de (Postfix) with ESMTPS id 12735952EC4
	for <lists+linux-erofs@lfdr.de>; Thu, 15 Aug 2024 15:08:07 +0200 (CEST)
Authentication-Results: lists.ozlabs.org;
	dkim=fail reason="signature verification failed" (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20201202 header.b=CWysPbmr;
	dkim-atps=neutral
Received: from boromir.ozlabs.org (localhost [IPv6:::1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4Wl55Y6XSbz2yhg
	for <lists+linux-erofs@lfdr.de>; Thu, 15 Aug 2024 23:08:01 +1000 (AEST)
X-Original-To: linux-erofs@lists.ozlabs.org
Delivered-To: linux-erofs@lists.ozlabs.org
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=kernel.org
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20201202 header.b=CWysPbmr;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=kernel.org (client-ip=2604:1380:40e1:4800::1; helo=sin.source.kernel.org; envelope-from=brauner@kernel.org; receiver=lists.ozlabs.org)
Received: from sin.source.kernel.org (sin.source.kernel.org [IPv6:2604:1380:40e1:4800::1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4Wl55V3gZTz2yZ7
	for <linux-erofs@lists.ozlabs.org>; Thu, 15 Aug 2024 23:07:58 +1000 (AEST)
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
	by sin.source.kernel.org (Postfix) with ESMTP id 02BEDCE1C5A;
	Thu, 15 Aug 2024 13:07:55 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BC276C4AF12;
	Thu, 15 Aug 2024 13:07:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1723727274;
	bh=jMFzZlcFi1TkZ5Y4pxf1tYJzK0rbZrrELQbpOJ8RF3U=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=CWysPbmrhoJPoY6REaRiKM1koRkT1R+xchonrJPpv1x9I+tee+tSfKXPRigLEF1Pp
	 H0I6xL+kL3jAdP83wrbd95nqrX4gOFtGasClay/ikEcqMAsrRbgUgm8uymaNB2JJyC
	 s9fAuxND+GVsI3CvvG4maGRFXUv1mrH/QMsPdEHwjeAnn4LLJl1uL87/6fKQvF81e/
	 gN47e2z5uZcj4pF1aOpUhKbSFnw/JNFL2aRtTdKMtegAQCGM+3alB+E0XbvxVZ0GZx
	 vSI/1pnVv1gMF6wJ8a7T6crM136WP7rIW/dyqW6P8SmyiDRFQoN0YMbOf3Fz7aHcH8
	 iawKWeu/fPcSQ==
From: Christian Brauner <brauner@kernel.org>
To: David Howells <dhowells@redhat.com>
Subject: Re: [PATCH v2 00/25] netfs: Read/write improvements
Date: Thu, 15 Aug 2024 15:07:42 +0200
Message-ID: <20240815-umzog-irgendein-80514d89315a@brauner>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240814203850.2240469-1-dhowells@redhat.com>
References: <20240814203850.2240469-1-dhowells@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
X-Developer-Signature: v=1; a=openpgp-sha256; l=3763; i=brauner@kernel.org; h=from:subject:message-id; bh=jMFzZlcFi1TkZ5Y4pxf1tYJzK0rbZrrELQbpOJ8RF3U=; b=owGbwMvMwCU28Zj0gdSKO4sYT6slMaTt/TvfdD5fB2vZ4St+TJxt5mWrLDw33/gjvqHIU/p1x 4z/b++v6yhlYRDjYpAVU2RxaDcJl1vOU7HZKFMDZg4rE8gQBi5OAZjI3TKGf7rW+puKJr8xC2Fc +4dN6MQSIQHtD5UCjw3EjTPKG9RWaTEyrOUUX7jY9aVQn42A5tbDjh4fbp/6mSTXO6u8fQdHhII sPwA=
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
Cc: Dominique Martinet <asmadeus@codewreck.org>, linux-mm@kvack.org, Marc Dionne <marc.dionne@auristor.com>, linux-afs@lists.infradead.org, Paulo Alcantara <pc@manguebit.com>, linux-cifs@vger.kernel.org, Matthew Wilcox <willy@infradead.org>, Steve French <smfrench@gmail.com>, Shyam Prasad N <sprasad@microsoft.com>, linux-nfs@vger.kernel.org, Tom Talpey <tom@talpey.com>, ceph-devel@vger.kernel.org, Eric Van Hensbergen <ericvh@kernel.org>, Ilya Dryomov <idryomov@gmail.com>, Christian Brauner <brauner@kernel.org>, netdev@vger.kernel.org, v9fs@lists.linux.dev, Jeff Layton <jlayton@kernel.org>, linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org, netfs@lists.linux.dev, linux-erofs@lists.ozlabs.org
Errors-To: linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org
Sender: "Linux-erofs" <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>

On Wed, 14 Aug 2024 21:38:20 +0100, David Howells wrote:
> This set of patches includes a couple of fixes:
> 
>  (1) Revert the removal of waits on PG_private_2 from netfs_release_page()
>      and netfs_invalidate_page().
> 
>  (2) Make cachefiles take the sb_writers lock around set/removexattr.
> 
> [...]

Applied to the vfs.netfs branch of the vfs/vfs.git tree.
Patches in the vfs.netfs branch should appear in linux-next soon.

Please report any outstanding bugs that were missed during review in a
new review to the original patch series allowing us to drop it.

It's encouraged to provide Acked-bys and Reviewed-bys even though the
patch has now been applied. If possible patch trailers will be updated.

Note that commit hashes shown below are subject to change due to rebase,
trailer updates or similar. If in doubt, please check the listed branch.

tree:   https://git.kernel.org/pub/scm/linux/kernel/git/vfs/vfs.git
branch: vfs.netfs

[01/25] cachefiles: Fix non-taking of sb_writers around set/removexattr
        https://git.kernel.org/vfs/vfs/c/4ca422fc1c25
[02/25] netfs: Adjust labels in /proc/fs/netfs/stats
        https://git.kernel.org/vfs/vfs/c/2d8e8e0dcfa8
[03/25] netfs: Record contention stats for writeback lock
        https://git.kernel.org/vfs/vfs/c/b946f63b34fa
[04/25] netfs: Reduce number of conditional branches in netfs_perform_write()
        https://git.kernel.org/vfs/vfs/c/922d33ef048c
[05/25] netfs, cifs: Move CIFS_INO_MODIFIED_ATTR to netfs_inode
        https://git.kernel.org/vfs/vfs/c/4c1daf044aed
[06/25] netfs: Move max_len/max_nr_segs from netfs_io_subrequest to netfs_io_stream
        https://git.kernel.org/vfs/vfs/c/a479f52b4401
[07/25] netfs: Reserve netfs_sreq_source 0 as unset/unknown
        https://git.kernel.org/vfs/vfs/c/e1de76429131
[08/25] netfs: Remove NETFS_COPY_TO_CACHE
        https://git.kernel.org/vfs/vfs/c/2a4e83a305ef
[09/25] netfs: Set the request work function upon allocation
        https://git.kernel.org/vfs/vfs/c/52c62b5f6dc0
[10/25] netfs: Use bh-disabling spinlocks for rreq->lock
        https://git.kernel.org/vfs/vfs/c/45268b70a77d
[11/25] mm: Define struct folio_queue and ITER_FOLIOQ to handle a sequence of folios
        https://git.kernel.org/vfs/vfs/c/3e73d92929db
[12/25] iov_iter: Provide copy_folio_from_iter()
        https://git.kernel.org/vfs/vfs/c/7a51f5cf0851
[13/25] cifs: Provide the capability to extract from ITER_FOLIOQ to RDMA SGEs
        https://git.kernel.org/vfs/vfs/c/97b15fbddd0c
[14/25] netfs: Use new folio_queue data type and iterator instead of xarray iter
        https://git.kernel.org/vfs/vfs/c/b33aa21f3b7f
[15/25] netfs: Provide an iterator-reset function
        https://git.kernel.org/vfs/vfs/c/7306dffdd871
[16/25] netfs: Simplify the writeback code
        https://git.kernel.org/vfs/vfs/c/5fb0299ed8df
[17/25] afs: Make read subreqs async
        https://git.kernel.org/vfs/vfs/c/05fd361eb083
[18/25] netfs: Speed up buffered reading
        https://git.kernel.org/vfs/vfs/c/6437a28f5de1
[19/25] netfs: Remove fs/netfs/io.c
        https://git.kernel.org/vfs/vfs/c/85112b95630c
[20/25] cachefiles, netfs: Fix write to partial block at EOF
        https://git.kernel.org/vfs/vfs/c/3b5a6483e8d2
[21/25] netfs: Cancel dirty folios that have no storage destination
        https://git.kernel.org/vfs/vfs/c/3cca08a1c4c5
[22/25] cifs: Use iterate_and_advance*() routines directly for hashing
        https://git.kernel.org/vfs/vfs/c/c86e6c334311
[23/25] cifs: Switch crypto buffer to use a folio_queue rather than an xarray
        https://git.kernel.org/vfs/vfs/c/04c9967360ea
[24/25] cifs: Don't support ITER_XARRAY
        https://git.kernel.org/vfs/vfs/c/7d0f7f2d1e8b
