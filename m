Return-Path: <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>
X-Original-To: lists+linux-erofs@lfdr.de
Delivered-To: lists+linux-erofs@lfdr.de
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2404:9400:2:0:216:3eff:fee1:b9f1])
	by mail.lfdr.de (Postfix) with ESMTPS id DFF9B987FFF
	for <lists+linux-erofs@lfdr.de>; Fri, 27 Sep 2024 10:07:32 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=lists.ozlabs.org;
	s=201707; t=1727424450;
	bh=vLnfEjKtNIU7zYkrmvOXNlWFEsTNr+a9qZ928W2WsJM=;
	h=To:Subject:Date:In-Reply-To:References:List-Id:List-Unsubscribe:
	 List-Archive:List-Post:List-Help:List-Subscribe:From:Reply-To:Cc:
	 From;
	b=VQZYQvDV9/TfdR2LcT8i5ibn4Ez9cHyWmBWJOBNV0OLL2sWcotSNObZ1s+z0p6WPn
	 NOdQ4FM5fhEOr+rVFl8jn/yc1Di0b6p1yJXiFsqD1VZGxMc7WLzQYC5lLOrTKsCR8w
	 3P4PTRrot5Cn5+utlbApwoGXqpBVwyGBEx2vgmn2FNFsrTbokdTh0KQFDzZxHUiTQF
	 fFkjTw6mqKsDicufTD/1Jrd+Wkb7RA1ayYNkshTRkUt8uUhULxVAGCocYxYRH8cJF5
	 IBf0NLByySQezlja7j0p6mZ7c2r6v4STB9Vtgn0J6WU79VLx0m7kjYLtwVsiyCqm00
	 2cdVgUB+lcDqA==
Received: from boromir.ozlabs.org (localhost [IPv6:::1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4XFNNy6q27z30Ns
	for <lists+linux-erofs@lfdr.de>; Fri, 27 Sep 2024 18:07:30 +1000 (AEST)
X-Original-To: linux-erofs@lists.ozlabs.org
Delivered-To: linux-erofs@lists.ozlabs.org
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip=147.75.193.91
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1727424448;
	cv=none; b=moPUV9xrPUv5toz2v51oN2pxGf36tfNhgU9zMb+ZcvmosX46DF96XEC1a4PIoFgKakzvOiLi9UffqbAdapVorIgL8XBpvkNdP7sXoJpIjTuETdAFpOxMA5hUeIYUkBwtuC1BPEINKtkzeHOBHR4yVW68Yq3shMXf5mXHlhDO1aebJnMhfkd60YKsjaFm03u49Ke5aNGQaKR8Vzcn9PMDU6vPyOZrvSpRDRT7FIcoe9x9GSOEEtWgj3Vexc5jsvGgMySiX7e+lZsFN7YttABGAIfGTxC3qok2j3qCrHEglN7ojDIYloSAA2e8GochQ+D+zpj/tAy81RuGZtvdA+QMIA==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1727424448; c=relaxed/relaxed;
	bh=vLnfEjKtNIU7zYkrmvOXNlWFEsTNr+a9qZ928W2WsJM=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=gyEdx2zq2x/habCK4VUoUcTZN6U8ec1X2K+XvU7KDVGqf5de5dCiE7UpBAJzg/yv//3tJSX7RZ376dxJ7QHqMkRxO8jE/MYxTw4Z6JpLqULGwhKwBh4OWn2bIvnzfZ6OwPNeDyc7qjQdvFdj3A+TKeKldeCggC1+cfoToE5BJqrTHjBcsXd4+s/XGtDlPrwCCPayVoeiXSG8mYabP5H8OY3zt/GICShTKQQxRHUN4z6MpNQaWhjqU1YDeCS9KxJYxh0vMjInbOy7Y1X7d2ErAps0GzHAtrnTOqCkHnzt6qWZFf+t94bw1rAPsy1lmyJ6M20gd9Jb/ExUXcv33Z9P9w==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=kernel.org; dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20201202 header.b=B6oFnRXx; dkim-atps=neutral; spf=pass (client-ip=147.75.193.91; helo=nyc.source.kernel.org; envelope-from=brauner@kernel.org; receiver=lists.ozlabs.org) smtp.mailfrom=kernel.org
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=kernel.org
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20201202 header.b=B6oFnRXx;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=kernel.org (client-ip=147.75.193.91; helo=nyc.source.kernel.org; envelope-from=brauner@kernel.org; receiver=lists.ozlabs.org)
Received: from nyc.source.kernel.org (nyc.source.kernel.org [147.75.193.91])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4XFNNw49bWz2yYJ
	for <linux-erofs@lists.ozlabs.org>; Fri, 27 Sep 2024 18:07:28 +1000 (AEST)
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
	by nyc.source.kernel.org (Postfix) with ESMTP id B20AAA45316;
	Fri, 27 Sep 2024 08:07:16 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D9461C4CEC4;
	Fri, 27 Sep 2024 08:07:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1727424444;
	bh=w/r4IrDMdsbnNrUJdiGTxDc3Vc0EH27o2LrhEKew1Ys=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=B6oFnRXxQkgl22gfgRImZiiCHxUgyVhhbFzoqKCjHidXalW6C1b0p5OEC7RzXwDuD
	 QbGKtx++eoj6dk31xc3dHn0ZayosgCj7HmDRdGpvqXrIP3dJNIypsrPtOtJXxd7+Hi
	 Kl5qVXPOp2lT66ee6SrJEaIFddPSnZi+bDKdC/iDjyGfIE201CPHRqBzmh1X6WoAYm
	 N3VrUm0NWY2K0RUe0gDori9yX2Qz4COEzDUKJT+ZX4Zcn6+hh10OnntWjipQlwNU98
	 MbvA9XHSrLr8Bp9gcPbQUOp5MC6LSLH785IcxOyAV6Zsg5EVLLiDd55dUY7jG6EaBk
	 FptumCalarihQ==
To: David Howells <dhowells@redhat.com>
Subject: Re: (subset) [PATCH 4/8] afs: Remove unused struct and function prototype
Date: Fri, 27 Sep 2024 10:07:10 +0200
Message-ID: <20240927-beide-aktienhandel-de829a6cac5e@brauner>
X-Mailer: git-send-email 2.45.2
In-Reply-To: <20240923150756.902363-5-dhowells@redhat.com>
References: <20240923150756.902363-1-dhowells@redhat.com> <20240923150756.902363-5-dhowells@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
X-Developer-Signature: v=1; a=openpgp-sha256; l=970; i=brauner@kernel.org; h=from:subject:message-id; bh=w/r4IrDMdsbnNrUJdiGTxDc3Vc0EH27o2LrhEKew1Ys=; b=owGbwMvMwCU28Zj0gdSKO4sYT6slMaR9S9/Cmv1nio7inM2hPx4Gqx7MOXeN7/ecBw9sbsrrW Rh1//P93FHKwiDGxSArpsji0G4SLrecp2KzUaYGzBxWJpAhDFycAjCRU+WMDBv2R79Oloz9sKxY ZOUMHwnHSWzSqcn6ly5MaO8/mmIukczwV8rkYKuOZ5HcqZ9O/I0fzzdkhnybeC6Tk2WCjH1JeNd TJgA=
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
Cc: Paulo Alcantara <pc@manguebit.com>, linux-cifs@vger.kernel.org, Christian Brauner <brauner@kernel.org>, v9fs@lists.linux.dev, Jeff Layton <jlayton@kernel.org>, linux-nfs@vger.kernel.org, Matthew Wilcox <willy@infradead.org>, linux-kernel@vger.kernel.org, Steve French <sfrench@samba.org>, linux-mm@kvack.org, Thorsten Blum <thorsten.blum@toblux.com>, linux-fsdevel@vger.kernel.org, netfs@lists.linux.dev, ceph-devel@vger.kernel.org, linux-erofs@lists.ozlabs.org, linux-afs@lists.infradead.org, Marc Dionne <marc.dionne@auristor.com>
Errors-To: linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org
Sender: "Linux-erofs" <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>

On Mon, 23 Sep 2024 16:07:48 +0100, David Howells wrote:
> The struct afs_address_list and the function prototype
> afs_put_address_list() are not used anymore and can be removed. Remove
> them.
> 
> 

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

[4/8] afs: Remove unused struct and function prototype
      https://git.kernel.org/vfs/vfs/c/45635ccabac2
