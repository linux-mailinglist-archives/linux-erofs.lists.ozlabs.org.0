Return-Path: <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>
X-Original-To: lists+linux-erofs@lfdr.de
Delivered-To: lists+linux-erofs@lfdr.de
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	by mail.lfdr.de (Postfix) with ESMTPS id 7598D8365B9
	for <lists+linux-erofs@lfdr.de>; Mon, 22 Jan 2024 15:44:11 +0100 (CET)
Authentication-Results: lists.ozlabs.org;
	dkim=fail reason="signature verification failed" (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20201202 header.b=rbCYmBLt;
	dkim-atps=neutral
Received: from boromir.ozlabs.org (localhost [IPv6:::1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4TJXzY2WmZz3bt5
	for <lists+linux-erofs@lfdr.de>; Tue, 23 Jan 2024 01:44:09 +1100 (AEDT)
X-Original-To: linux-erofs@lists.ozlabs.org
Delivered-To: linux-erofs@lists.ozlabs.org
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20201202 header.b=rbCYmBLt;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=kernel.org (client-ip=2604:1380:4641:c500::1; helo=dfw.source.kernel.org; envelope-from=brauner@kernel.org; receiver=lists.ozlabs.org)
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4TJXzP03HRz3bbt
	for <linux-erofs@lists.ozlabs.org>; Tue, 23 Jan 2024 01:44:00 +1100 (AEDT)
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
	by dfw.source.kernel.org (Postfix) with ESMTP id 84874611C5;
	Mon, 22 Jan 2024 14:43:58 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A6DB0C433C7;
	Mon, 22 Jan 2024 14:43:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1705934638;
	bh=okSe00Plf0urDpy7xMnzOmvyVyrPmVJSvxNEVIQ9gyo=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=rbCYmBLtGU7jcVEHLqY8mJViCCeFdbnSkSezt6XhBxQd/01t73Mz7+YDNj/JVZ90U
	 h8yfCER0idrxElrXoY754rURY4Cwj8gCFWocsxQRhd4JnNzkPGjN5UhivZz3fLCfpJ
	 J25Y7IgJI7fZ23D71v7P0htUUIrDZcEXSp7ujveSupdBO3l73RWrifGBJJX/wVtetI
	 4c5cdYWRJI5qMfMHrFBX7hbxtTaEpEZS30sFegdRHddze+871iZ4hcQ0DNVJM2LP3X
	 HbsCVa26Db2yy48nWIhZHASl8uU/Y3niK/h5wZR+n2iUqW9KKDbxuGMH1r+1Bmzg/9
	 dZ5ltFqAFHpyQ==
From: Christian Brauner <brauner@kernel.org>
To: netfs@lists.linux.dev,
	David Howells <dhowells@redhat.com>
Subject: Re: [PATCH 0/2] netfs, cachefiles: Update MAINTAINERS records
Date: Mon, 22 Jan 2024 15:43:17 +0100
Message-ID: <20240122-benennen-lastzug-8560ff9a85aa@brauner>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240122115007.3820330-1-dhowells@redhat.com>
References: <20240122115007.3820330-1-dhowells@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
X-Developer-Signature: v=1; a=openpgp-sha256; l=1180; i=brauner@kernel.org; h=from:subject:message-id; bh=5wiNsvaXup0M7lS0bpBvZ1QaDid4vN5t5fSW7E6j0v4=; b=owGbwMvMwCU28Zj0gdSKO4sYT6slMaSuqxd8sTntwGK1+pv1Wqdvf1h0sHr63/XfiqbHZSbUn Z7nFxbk0VHKwiDGxSArpsji0G4SLrecp2KzUaYGzBxWJpAhDFycAjCRVA1Ghm6bneUf3F9MUHl+ VXbbTrG/+TlnZa7w9O47pZzuLXU3dTXD/4Dva27OE3jinqMqVpaoZeks2rBD87Cfq0CYx7lNwat X8wIA
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
Cc: linux-cifs@vger.kernel.org, Christian Brauner <brauner@kernel.org>, v9fs@lists.linux.dev, Jeff Layton <jlayton@kernel.org>, linux-nfs@vger.kernel.org, Matthew Wilcox <willy@infradead.org>, linux-kernel@vger.kernel.org, linux-mm@kvack.org, linux-cachefs@redhat.com, linux-fsdevel@vger.kernel.org, ceph-devel@vger.kernel.org, linux-erofs@lists.ozlabs.org, linux-afs@lists.infradead.org
Errors-To: linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org
Sender: "Linux-erofs" <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>

On Mon, 22 Jan 2024 11:49:59 +0000, David Howells wrote:
> Update the MAINTAINERS records for netfs and cachefiles to reflect a change of
> mailing list for both as Red Hat no longer archives the mailing list in a
> publicly accessible place.
> 
> Also add Jeff Layton as a reviewer.

Yay!

> 
> The patches are here:
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

[1/2] netfs, cachefiles: Change mailing list
      https://git.kernel.org/vfs/vfs/c/3c18703079b6
[2/2] netfs: Add Jeff Layton as reviewer
      https://git.kernel.org/vfs/vfs/c/d59da02d1ab6
