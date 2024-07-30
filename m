Return-Path: <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>
X-Original-To: lists+linux-erofs@lfdr.de
Delivered-To: lists+linux-erofs@lfdr.de
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2404:9400:2:0:216:3eff:fee1:b9f1])
	by mail.lfdr.de (Postfix) with ESMTPS id 64641940F9D
	for <lists+linux-erofs@lfdr.de>; Tue, 30 Jul 2024 12:40:00 +0200 (CEST)
Authentication-Results: lists.ozlabs.org;
	dkim=fail reason="signature verification failed" (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20201202 header.b=N9qFpIo0;
	dkim-atps=neutral
Received: from boromir.ozlabs.org (localhost [IPv6:::1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4WYBZ62QYVz3cT8
	for <lists+linux-erofs@lfdr.de>; Tue, 30 Jul 2024 20:39:58 +1000 (AEST)
X-Original-To: linux-erofs@lists.ozlabs.org
Delivered-To: linux-erofs@lists.ozlabs.org
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=kernel.org
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20201202 header.b=N9qFpIo0;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=kernel.org (client-ip=2604:1380:40e1:4800::1; helo=sin.source.kernel.org; envelope-from=brauner@kernel.org; receiver=lists.ozlabs.org)
Received: from sin.source.kernel.org (sin.source.kernel.org [IPv6:2604:1380:40e1:4800::1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4WYBW21XL3z3cZ5
	for <linux-erofs@lists.ozlabs.org>; Tue, 30 Jul 2024 20:37:18 +1000 (AEST)
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
	by sin.source.kernel.org (Postfix) with ESMTP id 52E51CE0F20;
	Tue, 30 Jul 2024 10:37:13 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6FF37C4AF09;
	Tue, 30 Jul 2024 10:37:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1722335832;
	bh=M4eg2RA2dVioVZclF6JHvBR8dH2//m8JYd+0R0imYZA=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=N9qFpIo0XG2+as2sCBNP421gFXLGXitO22buNn5D+6stzkGoS9HaPxRMQqxX3xjf9
	 5e0x5+W/0YeRenNHJORfGa8KySj2GvC6/qYC74VKf3edqHJZtBdtU5wUEgxTiZIys7
	 dtAHSf71IblUjBJwJH68PfzO3Oy280ihPuDRIAMonzaoO+YKFYnoMFsAqUi1uDtKS/
	 ThKrqUheO+S2RtVhc0ZR4X0gXngw7CFN4oA0Dkj1d8hCBRHiH9HWcB81smZLZRrvxd
	 nLBYxt6mb/TF5Zv0aaFYjMjJ9kKYa+4zqrmAkyowfILhIoIbYwVRdRFZFEBp1JM1j5
	 LqOnkS4Ymt4sw==
From: Christian Brauner <brauner@kernel.org>
To: David Howells <dhowells@redhat.com>
Subject: Re: (subset) [PATCH 00/24] netfs: Read/write improvements
Date: Tue, 30 Jul 2024 12:36:50 +0200
Message-ID: <20240730-kaschieren-glitten-89d803c5d4ae@brauner>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240729162002.3436763-1-dhowells@redhat.com>
References: <20240729162002.3436763-1-dhowells@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
X-Developer-Signature: v=1; a=openpgp-sha256; l=961; i=brauner@kernel.org; h=from:subject:message-id; bh=M4eg2RA2dVioVZclF6JHvBR8dH2//m8JYd+0R0imYZA=; b=owGbwMvMwCU28Zj0gdSKO4sYT6slMaStOOQfILK00PPW9Etftt1+ufrx1Tc7OsPuXM7c9UVy9 72fTsfXtXaUsjCIcTHIiimyOLSbhMst56nYbJSpATOHlQlkCAMXpwBM5PF/RobHbwN1fQ3vrlPe zSXvY39gUXmtoiHrhCNck4/oH0uNlIph+MO777/y1U2XvSv+ZVQlPeSt+/k3J6znVvq6zOVlMw5 vUuYBAA==
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

On Mon, 29 Jul 2024 17:19:29 +0100, David Howells wrote:
> This set of patches includes one fscache fix and one cachefiles fix
> 
>  (1) Fix a cookie access race in fscache.
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

[01/24] fs/netfs/fscache_cookie: add missing "n_accesses" check
        https://git.kernel.org/vfs/vfs/c/965a561e4026
