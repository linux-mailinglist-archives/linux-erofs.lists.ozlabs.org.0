Return-Path: <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>
X-Original-To: lists+linux-erofs@lfdr.de
Delivered-To: lists+linux-erofs@lfdr.de
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	by mail.lfdr.de (Postfix) with ESMTPS id 5EEEE91138D
	for <lists+linux-erofs@lfdr.de>; Thu, 20 Jun 2024 22:43:00 +0200 (CEST)
Authentication-Results: lists.ozlabs.org;
	dkim=fail reason="signature verification failed" (2048-bit key; secure) header.d=codewreck.org header.i=@codewreck.org header.a=rsa-sha256 header.s=2 header.b=h2seSato;
	dkim-atps=neutral
Received: from boromir.ozlabs.org (localhost [IPv6:::1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4W4srJ73VVz3cYB
	for <lists+linux-erofs@lfdr.de>; Fri, 21 Jun 2024 06:42:56 +1000 (AEST)
X-Original-To: linux-erofs@lists.ozlabs.org
Delivered-To: linux-erofs@lists.ozlabs.org
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=codewreck.org
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; secure) header.d=codewreck.org header.i=@codewreck.org header.a=rsa-sha256 header.s=2 header.b=h2seSato;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=codewreck.org (client-ip=2001:bc8:3310:100::1; helo=submarine.notk.org; envelope-from=asmadeus@codewreck.org; receiver=lists.ozlabs.org)
X-Greylist: delayed 441 seconds by postgrey-1.37 at boromir; Fri, 21 Jun 2024 06:42:50 AEST
Received: from submarine.notk.org (submarine.notk.org [IPv6:2001:bc8:3310:100::1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4W4srB6nQ1z3cVv
	for <linux-erofs@lists.ozlabs.org>; Fri, 21 Jun 2024 06:42:50 +1000 (AEST)
Received: from gaia.codewreck.org (localhost [127.0.0.1])
	by submarine.notk.org (Postfix) with ESMTPS id CB8F014C2DD;
	Thu, 20 Jun 2024 22:35:08 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=codewreck.org;
	s=2; t=1718915715;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=UaFyOqx3Wna3PHffZA3lbOwaWZobih6I6zyfeyta8vg=;
	b=h2seSatoOQGsC1oNd084UzbsoydUhd9vEuvTIVA67+KxCi+z8q0IS0pjF2KDpOyEXXn6xC
	V5F5tFKch54wcT/63BHhocLiZ4AACqT7Li3GdqjRb9Uoce/o9dTPxiHGE3wZwgzlrvpbcq
	r+1Z8DInjQu2mvVXoWl5Vtyzy4YtD5CUQZ+l8QQu5f6ZIOEm7+irf9TT9TglH+VFtK9Bf0
	bUxiZ+0w0EPSZyZ4qOyV46FOnADlcelQ9/eQBgzAH5dQg48/EYTHDT1P+dqnsewYmXODfm
	X8KMzeUD8xxj/M3UhmTOhPXsiVwITjND5inF4G6cZ4fpaCqg3uxxlbubVPnIGw==
Received: from localhost (gaia.codewreck.org [local])
	by gaia.codewreck.org (OpenSMTPD) with ESMTPA id 9c0e7542;
	Thu, 20 Jun 2024 20:35:04 +0000 (UTC)
Date: Fri, 21 Jun 2024 05:34:49 +0900
From: Dominique Martinet <asmadeus@codewreck.org>
To: David Howells <dhowells@redhat.com>
Subject: Re: [PATCH 06/17] 9p: Enable multipage folios
Message-ID: <ZnSSaeLo8dY7cu3W@codewreck.org>
References: <20240620173137.610345-1-dhowells@redhat.com>
 <20240620173137.610345-7-dhowells@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20240620173137.610345-7-dhowells@redhat.com>
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

David Howells wrote on Thu, Jun 20, 2024 at 06:31:24PM +0100:
> Enable support for multipage folios on the 9P filesystem.  This is all
> handled through netfslib and is already enabled on AFS and CIFS also.

Since this is fairly unrelated to the other patches let's take this
through the 9p tree as well - I'll run some quick tests to verify writes
go from 4k to something larger and it doesn't blow up immediately and
push it out for 6.11

-- 
Dominique Martinet | Asmadeus
