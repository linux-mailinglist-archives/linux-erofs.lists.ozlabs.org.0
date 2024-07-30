Return-Path: <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>
X-Original-To: lists+linux-erofs@lfdr.de
Delivered-To: lists+linux-erofs@lfdr.de
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2404:9400:2:0:216:3eff:fee1:b9f1])
	by mail.lfdr.de (Postfix) with ESMTPS id 65745940FA1
	for <lists+linux-erofs@lfdr.de>; Tue, 30 Jul 2024 12:40:52 +0200 (CEST)
Authentication-Results: lists.ozlabs.org;
	dkim=fail reason="signature verification failed" (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20201202 header.b=E0E8omvs;
	dkim-atps=neutral
Received: from boromir.ozlabs.org (localhost [IPv6:::1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4WYBb62NT7z3cVW
	for <lists+linux-erofs@lfdr.de>; Tue, 30 Jul 2024 20:40:50 +1000 (AEST)
X-Original-To: linux-erofs@lists.ozlabs.org
Delivered-To: linux-erofs@lists.ozlabs.org
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=kernel.org
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20201202 header.b=E0E8omvs;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=kernel.org (client-ip=145.40.73.55; helo=sin.source.kernel.org; envelope-from=brauner@kernel.org; receiver=lists.ozlabs.org)
Received: from sin.source.kernel.org (sin.source.kernel.org [145.40.73.55])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4WYBb26hcKz2xQH
	for <linux-erofs@lists.ozlabs.org>; Tue, 30 Jul 2024 20:40:46 +1000 (AEST)
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
	by sin.source.kernel.org (Postfix) with ESMTP id A7F16CE0F1F;
	Tue, 30 Jul 2024 10:40:44 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B0972C32782;
	Tue, 30 Jul 2024 10:40:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1722336044;
	bh=GtlHiCXe3SP9GrzrDbzPMyQy1TggjvVpoEIpM1wJkFw=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=E0E8omvsDHYTL2czP0n0De4+h7DkgjBCVfSGLzuFxGLkYAK/0Pznw8IvCL7RKzyEb
	 aFCoes9IhXWAdQpPfBeK7RBQPilx2izghkYwF5Gef08hGlU9A5YxKlgo9EVm89XjLx
	 rkwrXNu3Hdyg1IdhFhUKcx27zTZ731W2iVm3FgpFbMZfO2YDAfW6LgS9R1XFtXXKjH
	 3cA7Vcrrzvz6DIRMkwolQ3gUwEIKxik1Z8Se4GDpuOgVFNTs3sMIdxNYARys4Sf7KY
	 z7IiZ3E5odkdcqOpYKleNWUyYI4MEA5DsnexQs9hFJAZZdLqjJJ39hb0z3TyoVPeUy
	 /jRxBRJrxNvuw==
From: Christian Brauner <brauner@kernel.org>
To: David Howells <dhowells@redhat.com>
Subject: Re: (subset) [PATCH 00/24] netfs: Read/write improvements
Date: Tue, 30 Jul 2024 12:38:10 +0200
Message-ID: <20240730-humpelt-satzreif-0ef607a63e62@brauner>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240729162002.3436763-1-dhowells@redhat.com>
References: <20240729162002.3436763-1-dhowells@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
X-Developer-Signature: v=1; a=openpgp-sha256; l=1049; i=brauner@kernel.org; h=from:subject:message-id; bh=GtlHiCXe3SP9GrzrDbzPMyQy1TggjvVpoEIpM1wJkFw=; b=owGbwMvMwCU28Zj0gdSKO4sYT6slMaStOCxvEn2hwPPa8wTxI72C4lJ3v3Rea/ReGNcXGxw0T yefRaW6o5SFQYyLQVZMkcWh3SRcbjlPxWajTA2YOaxMIEMYuDgFYCJX5jD8rzu7t0Pz2KVvdqtv 87yVfHz0kKpZ/6QfIZ67Tgnvl4+4MIeR4X367lM/n+s+OMG0cIHnl8WHrnnU3G7J3q6ks8NQdPp ZZXYA
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
> 
>  (2) Fix the setxattr/removexattr syscalls to pull their arguments into
>      kernel space before taking the sb_writers lock to avoid a deadlock
>      against mm->mmap_lock.
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

[03/24] - [24/24]
