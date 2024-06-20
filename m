Return-Path: <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>
X-Original-To: lists+linux-erofs@lfdr.de
Delivered-To: lists+linux-erofs@lfdr.de
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	by mail.lfdr.de (Postfix) with ESMTPS id 54AD09113AC
	for <lists+linux-erofs@lfdr.de>; Thu, 20 Jun 2024 22:50:25 +0200 (CEST)
Authentication-Results: lists.ozlabs.org;
	dkim=fail reason="signature verification failed" (2048-bit key; secure) header.d=codewreck.org header.i=@codewreck.org header.a=rsa-sha256 header.s=2 header.b=ALJdfkXV;
	dkim-atps=neutral
Received: from boromir.ozlabs.org (localhost [IPv6:::1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4W4t0s1FjNz3cY8
	for <lists+linux-erofs@lfdr.de>; Fri, 21 Jun 2024 06:50:21 +1000 (AEST)
X-Original-To: linux-erofs@lists.ozlabs.org
Delivered-To: linux-erofs@lists.ozlabs.org
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=codewreck.org
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; secure) header.d=codewreck.org header.i=@codewreck.org header.a=rsa-sha256 header.s=2 header.b=ALJdfkXV;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=codewreck.org (client-ip=62.210.214.84; helo=submarine.notk.org; envelope-from=asmadeus@codewreck.org; receiver=lists.ozlabs.org)
X-Greylist: delayed 883 seconds by postgrey-1.37 at boromir; Fri, 21 Jun 2024 06:50:16 AEST
Received: from submarine.notk.org (62-210-214-84.rev.poneytelecom.eu [62.210.214.84])
	by lists.ozlabs.org (Postfix) with ESMTP id 4W4t0m63Tqz30VT
	for <linux-erofs@lists.ozlabs.org>; Fri, 21 Jun 2024 06:50:16 +1000 (AEST)
Received: from gaia.codewreck.org (localhost [127.0.0.1])
	by submarine.notk.org (Postfix) with ESMTPS id 8A5F214C2DD;
	Thu, 20 Jun 2024 22:50:08 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=codewreck.org;
	s=2; t=1718916615;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=VLVCmMswFYW/yptkreRA4q0clrbQSOEC9H3udI4LuGU=;
	b=ALJdfkXV4jYbTnxVURz9T/eVwi75e+Jpzd/NnEdNtowVW0EPginJ+UR6WjORHnH38deSjd
	uJwnIU9Cj7KamD9RuKu8/mGuiDvl4zepXXeiSbVTriN0efe9Ugz46seuDEdUL9p7r7KRLr
	P7bpbNTjSYBxjIuPaVX1MWKzMKecMwktnyLawuNoID0Mbc/ddEMnIWkpd3XG+6pyYH418a
	3W/N9t5Qfs/oTZaI9U3i3KvnPFWdkdWReTPrI5Iv2PcSTYiBLmAJf7px1y70cBjtciXJPK
	i5woghwPVaymjTFrWRyF7a/0NAHSSLe6Bk1rVFeZVi+wKnfbRR0RGgGH6UokHw==
Received: from localhost (gaia.codewreck.org [local])
	by gaia.codewreck.org (OpenSMTPD) with ESMTPA id 39921304;
	Thu, 20 Jun 2024 20:50:04 +0000 (UTC)
Date: Fri, 21 Jun 2024 05:49:49 +0900
From: Dominique Martinet <asmadeus@codewreck.org>
To: David Howells <dhowells@redhat.com>
Subject: Re: [PATCH 06/17] 9p: Enable multipage folios
Message-ID: <ZnSV7TmLpmucb8el@codewreck.org>
References: <20240620173137.610345-1-dhowells@redhat.com>
 <20240620173137.610345-7-dhowells@redhat.com>
 <ZnSSaeLo8dY7cu3W@codewreck.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <ZnSSaeLo8dY7cu3W@codewreck.org>
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
Cc: Latchesar Ionkov <lucho@ionkov.net>, Christian Schoenebeck <linux_oss@crudebyte.com>, linux-mm@kvack.org, Marc Dionne <marc.dionne@auristor.com>, linux-afs@lists.infradead.org, Paulo Alcantara <pc@manguebit.com>, linux-cifs@vger.kernel.org, Matthew Wilcox <willy@infradead.org>, Steve French <smfrench@gmail.com>, Gao Xiang <hsiangkao@linux.alibaba.com>, Ilya Dryomov <idryomov@gmail.com>, Shyam Prasad N <sprasad@microsoft.com>, Tom Talpey <tom@talpey.com>, ceph-devel@vger.kernel.org, Eric Van Hensbergen <ericvh@kernel.org>, Christian Brauner <christian@brauner.io>, linux-nfs@vger.kernel.org, netdev@vger.kernel.org, v9fs@lists.linux.dev, Jeff Layton <jlayton@kernel.org>, linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org, netfs@lists.linux.dev, linux-erofs@lists.ozlabs.org
Errors-To: linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org
Sender: "Linux-erofs" <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>

Dominique Martinet wrote on Fri, Jun 21, 2024 at 05:34:49AM +0900:
> David Howells wrote on Thu, Jun 20, 2024 at 06:31:24PM +0100:
> > Enable support for multipage folios on the 9P filesystem.  This is all
> > handled through netfslib and is already enabled on AFS and CIFS also.
> 
> Since this is fairly unrelated to the other patches let's take this
> through the 9p tree as well - I'll run some quick tests to verify writes
> go from 4k to something larger

(huh, my memory is rotten, we were already aggregating writes at some
point without this. Oh, well, at least it doesn't seem to blow up)

> and it doesn't blow up immediately and push it out for 6.11

Queued for -next.

-- 
Dominique Martinet | Asmadeus
