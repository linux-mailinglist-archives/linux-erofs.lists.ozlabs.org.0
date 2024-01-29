Return-Path: <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>
X-Original-To: lists+linux-erofs@lfdr.de
Delivered-To: lists+linux-erofs@lfdr.de
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	by mail.lfdr.de (Postfix) with ESMTPS id 8344384077D
	for <lists+linux-erofs@lfdr.de>; Mon, 29 Jan 2024 14:54:10 +0100 (CET)
Authentication-Results: lists.ozlabs.org;
	dkim=fail reason="signature verification failed" (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20201202 header.b=Dyd1SJm/;
	dkim-atps=neutral
Received: from boromir.ozlabs.org (localhost [IPv6:::1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4TNqXc33hrz3bTn
	for <lists+linux-erofs@lfdr.de>; Tue, 30 Jan 2024 00:54:08 +1100 (AEDT)
X-Original-To: linux-erofs@lists.ozlabs.org
Delivered-To: linux-erofs@lists.ozlabs.org
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20201202 header.b=Dyd1SJm/;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=kernel.org (client-ip=2604:1380:4641:c500::1; helo=dfw.source.kernel.org; envelope-from=brauner@kernel.org; receiver=lists.ozlabs.org)
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4TNqXY2zQbz30gJ
	for <linux-erofs@lists.ozlabs.org>; Tue, 30 Jan 2024 00:54:05 +1100 (AEDT)
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
	by dfw.source.kernel.org (Postfix) with ESMTP id E14E5621E0;
	Mon, 29 Jan 2024 13:54:02 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B9078C433C7;
	Mon, 29 Jan 2024 13:53:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1706536442;
	bh=oxnQVHjK16c3SXNOAjdh150De7InleBILFnsJkuVb2I=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=Dyd1SJm/k5kdkc6EEeyiavgicku+98LjoK4Bq483kWInYTN9cx40JwhTkLVAgaYP2
	 it+C/nBcfpr3NRzOTgOWBWkIM13Yek41pmj5bH773MkKRsrN/NwOSOyi9J/t8yYO25
	 i/SQ1Yi7STfs8DutbEAX5joK9MGXOj1Jr122hEa1ZA8Ud6h2f0jOeRoW//73dkNuVi
	 H2EZQZf5OPmvyzK9fwrBZkIgOF05TdjGf10I2yJ/yq6VBycQJ3qF48QJRUePqyToC9
	 PCGX6rur5i6MdaWmVjP2Q1uysyuDBBo8TA4ydzdvlzUi/7jAXsG/LejmP7K1YLj8/q
	 u7jG606WZF6jA==
From: Christian Brauner <brauner@kernel.org>
To: David Howells <dhowells@redhat.com>
Subject: Re: [PATCH 0/2] netfs: Miscellaneous fixes
Date: Mon, 29 Jan 2024 14:53:39 +0100
Message-ID: <20240129-kleeblatt-rosig-a28c8042fb2a@brauner>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240129094924.1221977-1-dhowells@redhat.com>
References: <20240129094924.1221977-1-dhowells@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
X-Developer-Signature: v=1; a=openpgp-sha256; l=1172; i=brauner@kernel.org; h=from:subject:message-id; bh=oxnQVHjK16c3SXNOAjdh150De7InleBILFnsJkuVb2I=; b=owGbwMvMwCU28Zj0gdSKO4sYT6slMaRuX/vRz8V965um1m91CsbZ9wV2fJ18fZNu8T3XE+d8D xR7/fw5v6OUhUGMi0FWTJHFod0kXG45T8Vmo0wNmDmsTCBDGLg4BWAiKosY/pd1JPw3fzjxoP/G tS3fF8337FxYV/7w+G4zxcllZzuPveNl+MM788oSjU/qfNop+4+JHuhOX9S+rLtf7cDSszOc1zR +PMkMAA==
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
Cc: linux-cifs@vger.kernel.org, Christian Brauner <brauner@kernel.org>, v9fs@lists.linux.dev, Dominique Martinet <asmadeus@codewreck.org>, Jeff Layton <jlayton@kernel.org>, linux-nfs@vger.kernel.org, Matthew Wilcox <willy@infradead.org>, linux-kernel@vger.kernel.org, linux-mm@kvack.org, linux-fsdevel@vger.kernel.org, netfs@lists.linux.dev, ceph-devel@vger.kernel.org, Eric Van Hensbergen <ericvh@kernel.org>, linux-erofs@lists.ozlabs.org, linux-afs@lists.infradead.org
Errors-To: linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org
Sender: "Linux-erofs" <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>

On Mon, 29 Jan 2024 09:49:17 +0000, David Howells wrote:
> Here are a couple of fixes for netfslib:
> 
>  (1) Fix an i_dio_count leak on a DIO read starting beyond EOF.
> 
>  (2) Fix a missing zero-length check in an unbuffered write causing 9p to
>      indicate EIO.
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

[1/2] netfs: Fix i_dio_count leak on DIO read past i_size
      https://git.kernel.org/vfs/vfs/c/a4bb694db189
[2/2] netfs: Fix missing zero-length check in unbuffered write
      https://git.kernel.org/vfs/vfs/c/2d6e065e2431
