Return-Path: <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>
X-Original-To: lists+linux-erofs@lfdr.de
Delivered-To: lists+linux-erofs@lfdr.de
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	by mail.lfdr.de (Postfix) with ESMTPS id E60878950B3
	for <lists+linux-erofs@lfdr.de>; Tue,  2 Apr 2024 12:49:10 +0200 (CEST)
Authentication-Results: lists.ozlabs.org;
	dkim=fail reason="signature verification failed" (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20201202 header.b=s3pKIoou;
	dkim-atps=neutral
Received: from boromir.ozlabs.org (localhost [IPv6:::1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4V84Pb1Z0Nz3dRs
	for <lists+linux-erofs@lfdr.de>; Tue,  2 Apr 2024 21:49:07 +1100 (AEDT)
X-Original-To: linux-erofs@lists.ozlabs.org
Delivered-To: linux-erofs@lists.ozlabs.org
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20201202 header.b=s3pKIoou;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=kernel.org (client-ip=2604:1380:4641:c500::1; helo=dfw.source.kernel.org; envelope-from=brauner@kernel.org; receiver=lists.ozlabs.org)
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4V84PT662cz3d2K
	for <linux-erofs@lists.ozlabs.org>; Tue,  2 Apr 2024 21:49:01 +1100 (AEDT)
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
	by dfw.source.kernel.org (Postfix) with ESMTP id B399460C8A;
	Tue,  2 Apr 2024 10:48:57 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4B1F0C433C7;
	Tue,  2 Apr 2024 10:48:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1712054937;
	bh=0o849oaUCS/1to/11XOBsrrHkZ6HnWiwjHhXX1XawsY=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=s3pKIoouIXwXD4lmoPfSlZSDJZnmmtOa1RUJNiFaCXHRyfUJWBCybV99rJXm7gV8y
	 T7Fjk4lyWWWjVz2Gcq+2fNAoTMJnNX/2F2ImxDn9loGZaAaUiIrrOGUofL9i7svfdk
	 XAdlme0aallBdCc4GUuODtk5GZtLEzaPI3vng58HDE2HBNIlc4c6Bq3f6hazpMeaEx
	 Xgj2CoKMoSLbndyirg0YejiKL0ZEAGFUReEzmqbp1wYq+3/s1f3ZCIqrcblHvsWe1U
	 u/Fu8N++N778FF1N0TJzW8msw8oIsVzOMv/4cCc32kKXWGv+qqR4NqN76QQvHhbwO4
	 xB4Ir5cVjt1jw==
From: Christian Brauner <brauner@kernel.org>
To: David Howells <dhowells@redhat.com>
Subject: Re: [PATCH 00/26] netfs, afs, 9p, cifs: Rework netfs to use ->writepages() to copy to cache
Date: Tue,  2 Apr 2024 12:48:39 +0200
Message-ID: <20240402-angezapft-geltung-eedf20c747b6@brauner>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240328163424.2781320-1-dhowells@redhat.com>
References: <20240328163424.2781320-1-dhowells@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
X-Developer-Signature: v=1; a=openpgp-sha256; l=1071; i=brauner@kernel.org; h=from:subject:message-id; bh=0o849oaUCS/1to/11XOBsrrHkZ6HnWiwjHhXX1XawsY=; b=owGbwMvMwCU28Zj0gdSKO4sYT6slMaRxP+pcP3O9duihh7ft/O8vis97k3zynpVeQfGsW8E7b q56dXSyVUcpC4MYF4OsmCKLQ7tJuNxynorNRpkaMHNYmUCGMHBxCsBEuNwYGTasXTr9sKjU3hPX Ei5oGyxbtVov5EPVyh7dA8dse88LRt5l+M2u8X9Xtd2ZVVnejNGvL9xPN9z30XT+j+sXvgWrTvz jocYCAA==
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
Cc: Dominique Martinet <asmadeus@codewreck.org>, linux-mm@kvack.org, Marc Dionne <marc.dionne@auristor.com>, linux-afs@lists.infradead.org, Paulo Alcantara <pc@manguebit.com>, linux-cifs@vger.kernel.org, Matthew Wilcox <willy@infradead.org>, Steve French <smfrench@gmail.com>, linux-cachefs@redhat.com, Ilya Dryomov <idryomov@gmail.com>, Shyam Prasad N <sprasad@microsoft.com>, linux-nfs@vger.kernel.org, Tom Talpey <tom@talpey.com>, ceph-devel@vger.kernel.org, Eric Van Hensbergen <ericvh@kernel.org>, Christian Brauner <brauner@kernel.org>, netdev@vger.kernel.org, v9fs@lists.linux.dev, Jeff Layton <jlayton@kernel.org>, linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org, netfs@lists.linux.dev, linux-erofs@lists.ozlabs.org
Errors-To: linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org
Sender: "Linux-erofs" <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>

On Thu, 28 Mar 2024 16:33:52 +0000, David Howells wrote:
> The primary purpose of these patches is to rework the netfslib writeback
> implementation such that pages read from the cache are written to the cache
> through ->writepages(), thereby allowing the fscache page flag to be
> retired.
> 
> The reworking also:
> 
> [...]

Pulled from netfs-writeback which contains the minor fixes pointed out.

---

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
