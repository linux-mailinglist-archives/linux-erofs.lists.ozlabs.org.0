Return-Path: <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>
X-Original-To: lists+linux-erofs@lfdr.de
Delivered-To: lists+linux-erofs@lfdr.de
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2404:9400:2:0:216:3eff:fee1:b9f1])
	by mail.lfdr.de (Postfix) with ESMTPS id 58ABE8391F8
	for <lists+linux-erofs@lfdr.de>; Tue, 23 Jan 2024 16:03:43 +0100 (CET)
Authentication-Results: lists.ozlabs.org;
	dkim=fail reason="signature verification failed" (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20201202 header.b=NT+M63By;
	dkim-atps=neutral
Received: from boromir.ozlabs.org (localhost [IPv6:::1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4TK9Md137kz3by8
	for <lists+linux-erofs@lfdr.de>; Wed, 24 Jan 2024 02:03:41 +1100 (AEDT)
X-Original-To: linux-erofs@lists.ozlabs.org
Delivered-To: linux-erofs@lists.ozlabs.org
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20201202 header.b=NT+M63By;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=kernel.org (client-ip=145.40.73.55; helo=sin.source.kernel.org; envelope-from=brauner@kernel.org; receiver=lists.ozlabs.org)
Received: from sin.source.kernel.org (sin.source.kernel.org [145.40.73.55])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4TK9MX0y27z2xdp
	for <linux-erofs@lists.ozlabs.org>; Wed, 24 Jan 2024 02:03:36 +1100 (AEDT)
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
	by sin.source.kernel.org (Postfix) with ESMTP id A2349CE2B67;
	Tue, 23 Jan 2024 15:03:30 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6AA8EC433F1;
	Tue, 23 Jan 2024 15:03:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1706022207;
	bh=q1ehO0VlSRjlEkZix2Yv8UwXgVbsdNerufMonTt1Rvk=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=NT+M63By3JOLNSB6AfRX73VOAsajcGYOLYmUwI6BJW9eea/qDVp8ui4HATBCbLqta
	 aJQRALleSXScyEPXdbsBTanNjgZhs5cuisIvevP5qQSUpcJMMvxkf5B1QIdLZrx7sn
	 dhwfse1OScXIKVs1lftoY+0nBQuSgIuJX/0pusRP9AfbsTwOWd8h9S2PB0/FYX4yLu
	 qPqYiuCqQSUwKWgbhwu7L+RW3btUfwvRYmIwNtTw1dnRXIrCsaTFVOeCpzVxZE665K
	 xPr1coTGmxKiax9/xI02gl6qO/vbiH9Z8bjog6KaunCNC0RlXaVp87Q9mb8c3l0amc
	 5MpTdGsFq5EjQ==
Date: Tue, 23 Jan 2024 16:03:20 +0100
From: Christian Brauner <brauner@kernel.org>
To: David Howells <dhowells@redhat.com>
Subject: Re: [PATCH 00/10] netfs, afs, cifs, cachefiles, erofs: Miscellaneous
 fixes
Message-ID: <20240123-malheur-fahrrad-9d7c2ce2e757@brauner>
References: <20240122123845.3822570-1-dhowells@redhat.com>
 <20240122-bezwingen-kanister-b56f5bc1bc84@brauner>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20240122-bezwingen-kanister-b56f5bc1bc84@brauner>
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

On Mon, Jan 22, 2024 at 04:18:08PM +0100, Christian Brauner wrote:
> On Mon, Jan 22, 2024 at 12:38:33PM +0000, David Howells wrote:
> > Hi Christian,
> > 
> > Here are some miscellaneous fixes for netfslib and a number of filesystems:
> > 
> >  (1) Replace folio_index() with folio->index in netfs, afs and cifs.
> > 
> >  (2) Fix an oops in fscache_put_cache().
> > 
> >  (3) Fix error handling in netfs_perform_write().
> > 
> >  (4) Fix an oops in cachefiles when not using erofs ondemand mode.
> > 
> >  (5) In afs, hide silly-rename files from getdents() to avoid problems with
> >      tar and suchlike.
> > 
> >  (6) In afs, fix error handling in lookup with a bulk status fetch.
> > 
> >  (7) In afs, afs_dynroot_d_revalidate() is redundant, so remove it.
> > 
> >  (8) In afs, fix the RCU unlocking in afs_proc_addr_prefs_show().
> > 
> > The patches can also be found here:
> > 
> > 	https://git.kernel.org/pub/scm/linux/kernel/git/dhowells/linux-fs.git/log/?h=netfs-fixes
> 
> Thank you! I can pull this in right and will send a pr together with the
> other changes around Wednesday/Thursday for -rc2. So reviews before that
> would be nice.

Pulled and pushed:

tree:   https://git.kernel.org/pub/scm/linux/kernel/git/vfs/vfs.git
branch: vfs.netfs

Timeline still the same.
