Return-Path: <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>
X-Original-To: lists+linux-erofs@lfdr.de
Delivered-To: lists+linux-erofs@lfdr.de
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2404:9400:2:0:216:3eff:fee1:b9f1])
	by mail.lfdr.de (Postfix) with ESMTPS id 29777899A78
	for <lists+linux-erofs@lfdr.de>; Fri,  5 Apr 2024 12:15:56 +0200 (CEST)
Authentication-Results: lists.ozlabs.org;
	dkim=fail reason="signature verification failed" (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20201202 header.b=caMJ71mm;
	dkim-atps=neutral
Received: from boromir.ozlabs.org (localhost [IPv6:::1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4V9vWs6bl2z3vdc
	for <lists+linux-erofs@lfdr.de>; Fri,  5 Apr 2024 21:15:53 +1100 (AEDT)
X-Original-To: linux-erofs@lists.ozlabs.org
Delivered-To: linux-erofs@lists.ozlabs.org
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20201202 header.b=caMJ71mm;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=kernel.org (client-ip=2604:1380:4641:c500::1; helo=dfw.source.kernel.org; envelope-from=brauner@kernel.org; receiver=lists.ozlabs.org)
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4V9vWm21bZz3vcS
	for <linux-erofs@lists.ozlabs.org>; Fri,  5 Apr 2024 21:15:48 +1100 (AEDT)
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
	by dfw.source.kernel.org (Postfix) with ESMTP id B88CD618BF;
	Fri,  5 Apr 2024 10:15:44 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8F21BC433F1;
	Fri,  5 Apr 2024 10:15:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1712312144;
	bh=yIHeOwT1Z+4CwFKwe4RcKGCjnk0s2xBp+R1BOpUfFsg=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=caMJ71mmy73c69ZyZyNX4wS/2d8Gtly6EtzykUIE0yXHbrAMwv7eMWt2apQEno6io
	 8Ny3HtFvTnC9Gaz97HDodO14jUPgFC3leggZFXx05N0QdQvMLPMYwokSZFQfHYbZxp
	 O/nEAmSn8QWyea3nkipZVjXjYGJ9KgFkOeQnWOkMeRzcnwCDzqKGT2YLEgcy1zW6DW
	 epW118aIRpl+hKttSW1y64jhg1CcH5IhVBH6IsGyDznq/8k7bxLKOAjx7fl1UZW+BT
	 erfELlSyjrxr9gChb3R7X47yIZZ6/lr6monLIC+TD0k2YntQu2xsEIQ2MH1kiRPpGw
	 NigJI7ozoCNng==
Date: Fri, 5 Apr 2024 12:15:34 +0200
From: Christian Brauner <brauner@kernel.org>
To: David Howells <dhowells@redhat.com>
Subject: Re: [PATCH 15/26] mm: Export writeback_iter()
Message-ID: <20240405-kanarienvogel-besuchen-63c433180767@brauner>
References: <20240403124124.GA19085@lst.de>
 <20240403101422.GA7285@lst.de>
 <20240403085918.GA1178@lst.de>
 <20240328163424.2781320-1-dhowells@redhat.com>
 <20240328163424.2781320-16-dhowells@redhat.com>
 <3235934.1712139047@warthog.procyon.org.uk>
 <3300438.1712141700@warthog.procyon.org.uk>
 <3326107.1712149095@warthog.procyon.org.uk>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <3326107.1712149095@warthog.procyon.org.uk>
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
Cc: Dominique Martinet <asmadeus@codewreck.org>, linux-mm@kvack.org, Marc Dionne <marc.dionne@auristor.com>, linux-afs@lists.infradead.org, Paulo Alcantara <pc@manguebit.com>, linux-cifs@vger.kernel.org, Matthew Wilcox <willy@infradead.org>, Christoph Hellwig <hch@lst.de>, Steve French <smfrench@gmail.com>, linux-cachefs@redhat.com, Gao Xiang <hsiangkao@linux.alibaba.com>, Ilya Dryomov <idryomov@gmail.com>, Shyam Prasad N <sprasad@microsoft.com>, Tom Talpey <tom@talpey.com>, ceph-devel@vger.kernel.org, Eric Van Hensbergen <ericvh@kernel.org>, Christian Brauner <christian@brauner.io>, linux-nfs@vger.kernel.org, netdev@vger.kernel.org, v9fs@lists.linux.dev, Jeff Layton <jlayton@kernel.org>, linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org, netfs@lists.linux.dev, linux-erofs@lists.ozlabs.org
Errors-To: linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org
Sender: "Linux-erofs" <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>

On Wed, Apr 03, 2024 at 01:58:15PM +0100, David Howells wrote:
> Christoph Hellwig <hch@lst.de> wrote:
> 
> > > So why are we bothering with EXPORT_SYMBOL at all?  Why don't you just
> > > send a patch replace all of them with EXPORT_SYMBOL_GPL()?
> > 
> > No my business.
> 
> Clearly it is as you're gradually replacing APIs with stuff that is GPL'd.
> 
> > But if you want to side track this let me just put this in here:
> > 
> > NAK to the non-GPL EXPORT of writeback_iter().
> 
> Very well, I'll switch that export to GPL.  Christian, if you can amend that
> patch in your tree?

Sorted yesterday night!
