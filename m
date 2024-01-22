Return-Path: <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>
X-Original-To: lists+linux-erofs@lfdr.de
Delivered-To: lists+linux-erofs@lfdr.de
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2404:9400:2:0:216:3eff:fee1:b9f1])
	by mail.lfdr.de (Postfix) with ESMTPS id C22718367AE
	for <lists+linux-erofs@lfdr.de>; Mon, 22 Jan 2024 16:18:19 +0100 (CET)
Authentication-Results: lists.ozlabs.org;
	dkim=fail reason="signature verification failed" (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20201202 header.b=eF9eAoxR;
	dkim-atps=neutral
Received: from boromir.ozlabs.org (localhost [IPv6:::1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4TJYkx2q60z3bt5
	for <lists+linux-erofs@lfdr.de>; Tue, 23 Jan 2024 02:18:17 +1100 (AEDT)
X-Original-To: linux-erofs@lists.ozlabs.org
Delivered-To: linux-erofs@lists.ozlabs.org
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20201202 header.b=eF9eAoxR;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=kernel.org (client-ip=2604:1380:40e1:4800::1; helo=sin.source.kernel.org; envelope-from=brauner@kernel.org; receiver=lists.ozlabs.org)
Received: from sin.source.kernel.org (sin.source.kernel.org [IPv6:2604:1380:40e1:4800::1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4TJYkq4Q2bz3bmN
	for <linux-erofs@lists.ozlabs.org>; Tue, 23 Jan 2024 02:18:11 +1100 (AEDT)
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
	by sin.source.kernel.org (Postfix) with ESMTP id 69FB7CE2B3F;
	Mon, 22 Jan 2024 15:18:08 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 816C1C4166A;
	Mon, 22 Jan 2024 15:18:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1705936687;
	bh=UQJgDJ1jQGsA5dFTTO+ji4AWSQKmt22PQx0vxvlz2bA=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=eF9eAoxRJf/brDqvElgArHmgdPeNAo8ieOCn2xi4ufFMxorFWtZ69VUCmexzh/sTP
	 +BUe+qq0YinH8u65eRct5dmhzAWFFKqlNJaJq3gORFxSLqWHaK8bmTm7uGQKDIW2iI
	 BieFkdBIEZ3SEyP0Q+8D/ZiNvX3lytbJYySqYooKSLLOUvw4G1RmIOTPeoEcZGNtiJ
	 A97D5pgdGQt06pSe+FpwzwaOzXbKSAnn7bA+4Rf6cYXtmesshM9PUMKkTZOUiNwyI8
	 ApQJ9IXiznE6UZvl7XLRgjAysbckvDqpYHK+EfVEDTPw5+WgadpXzK1+9wg+AQRyM9
	 wZsFayL+0k0lw==
Date: Mon, 22 Jan 2024 16:18:00 +0100
From: Christian Brauner <brauner@kernel.org>
To: David Howells <dhowells@redhat.com>
Subject: Re: [PATCH 00/10] netfs, afs, cifs, cachefiles, erofs: Miscellaneous
 fixes
Message-ID: <20240122-bezwingen-kanister-b56f5bc1bc84@brauner>
References: <20240122123845.3822570-1-dhowells@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20240122123845.3822570-1-dhowells@redhat.com>
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
Cc: linux-cifs@vger.kernel.org, linux-nfs@vger.kernel.org, v9fs@lists.linux.dev, Jeff Layton <jlayton@kernel.org>, linux-kernel@vger.kernel.org, Matthew Wilcox <willy@infradead.org>, linux-mm@kvack.org, linux-fsdevel@vger.kernel.org, netfs@lists.linux.dev, ceph-devel@vger.kernel.org, linux-erofs@lists.ozlabs.org, linux-afs@lists.infradead.org, Christian Brauner <christian@brauner.io>
Errors-To: linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org
Sender: "Linux-erofs" <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>

On Mon, Jan 22, 2024 at 12:38:33PM +0000, David Howells wrote:
> Hi Christian,
> 
> Here are some miscellaneous fixes for netfslib and a number of filesystems:
> 
>  (1) Replace folio_index() with folio->index in netfs, afs and cifs.
> 
>  (2) Fix an oops in fscache_put_cache().
> 
>  (3) Fix error handling in netfs_perform_write().
> 
>  (4) Fix an oops in cachefiles when not using erofs ondemand mode.
> 
>  (5) In afs, hide silly-rename files from getdents() to avoid problems with
>      tar and suchlike.
> 
>  (6) In afs, fix error handling in lookup with a bulk status fetch.
> 
>  (7) In afs, afs_dynroot_d_revalidate() is redundant, so remove it.
> 
>  (8) In afs, fix the RCU unlocking in afs_proc_addr_prefs_show().
> 
> The patches can also be found here:
> 
> 	https://git.kernel.org/pub/scm/linux/kernel/git/dhowells/linux-fs.git/log/?h=netfs-fixes

Thank you! I can pull this in right and will send a pr together with the
other changes around Wednesday/Thursday for -rc2. So reviews before that
would be nice.
