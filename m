Return-Path: <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>
X-Original-To: lists+linux-erofs@lfdr.de
Delivered-To: lists+linux-erofs@lfdr.de
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2404:9400:2:0:216:3eff:fee1:b9f1])
	by mail.lfdr.de (Postfix) with ESMTPS id 5AAED8A0941
	for <lists+linux-erofs@lfdr.de>; Thu, 11 Apr 2024 09:10:14 +0200 (CEST)
Authentication-Results: lists.ozlabs.org;
	dkim=fail reason="signature verification failed" (1024-bit key; unprotected) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=FHDwA4vY;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=FHDwA4vY;
	dkim-atps=neutral
Received: from boromir.ozlabs.org (localhost [IPv6:::1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4VFW6r0Z4mz3vX6
	for <lists+linux-erofs@lfdr.de>; Thu, 11 Apr 2024 17:10:12 +1000 (AEST)
X-Original-To: linux-erofs@lists.ozlabs.org
Delivered-To: linux-erofs@lists.ozlabs.org
Authentication-Results: lists.ozlabs.org;
	dkim=pass (1024-bit key; unprotected) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=FHDwA4vY;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=FHDwA4vY;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=redhat.com (client-ip=170.10.129.124; helo=us-smtp-delivery-124.mimecast.com; envelope-from=dhowells@redhat.com; receiver=lists.ozlabs.org)
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4VFW6j0rK8z3cPm
	for <linux-erofs@lists.ozlabs.org>; Thu, 11 Apr 2024 17:10:04 +1000 (AEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1712819401;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=5NgjUa+lwKskPLBb4G2miG3MSH6bZPhgAN2v8MXqMrQ=;
	b=FHDwA4vYBXO6tUFoTzeFPJebu7+0jDtrOOYkcmfbKT8bG54CcjFbmtCrfzy1LONMJedRjq
	bIe7AXelR4OcVLG028GrOulUq2jmDF4jMCwhXwc8uweWEtKeacA9/aPWmohnyD2jdNqk1J
	3c/TaGNQBh5+2H0vWZ0/1RZCwsx5kNE=
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1712819401;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=5NgjUa+lwKskPLBb4G2miG3MSH6bZPhgAN2v8MXqMrQ=;
	b=FHDwA4vYBXO6tUFoTzeFPJebu7+0jDtrOOYkcmfbKT8bG54CcjFbmtCrfzy1LONMJedRjq
	bIe7AXelR4OcVLG028GrOulUq2jmDF4jMCwhXwc8uweWEtKeacA9/aPWmohnyD2jdNqk1J
	3c/TaGNQBh5+2H0vWZ0/1RZCwsx5kNE=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-19-Lr1cEV93NVGDpSocSvNLIw-1; Thu, 11 Apr 2024 03:09:56 -0400
X-MC-Unique: Lr1cEV93NVGDpSocSvNLIw-1
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.rdu2.redhat.com [10.11.54.6])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mimecast-mx02.redhat.com (Postfix) with ESMTPS id CA3F310499A0;
	Thu, 11 Apr 2024 07:09:54 +0000 (UTC)
Received: from warthog.procyon.org.uk (unknown [10.42.28.146])
	by smtp.corp.redhat.com (Postfix) with ESMTP id 3F2182166B34;
	Thu, 11 Apr 2024 07:09:51 +0000 (UTC)
Organization: Red Hat UK Ltd. Registered Address: Red Hat UK Ltd, Amberley
	Place, 107-111 Peascod Street, Windsor, Berkshire, SI4 1TE, United
	Kingdom.
	Registered in England and Wales under Company Registration No. 3798903
From: David Howells <dhowells@redhat.com>
In-Reply-To: <20240410173815.GA514426@kernel.org>
References: <20240410173815.GA514426@kernel.org> <20240401135351.GD26556@kernel.org> <20240328163424.2781320-1-dhowells@redhat.com> <20240328163424.2781320-27-dhowells@redhat.com> <3002686.1712046757@warthog.procyon.org.uk>
To: Simon Horman <horms@kernel.org>
Subject: Re: [PATCH 26/26] netfs, afs: Use writeback retry to deal with alternate keys
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-ID: <1780363.1712819386.1@warthog.procyon.org.uk>
Content-Transfer-Encoding: quoted-printable
Date: Thu, 11 Apr 2024 08:09:46 +0100
Message-ID: <1780364.1712819386@warthog.procyon.org.uk>
X-Scanned-By: MIMEDefang 3.4.1 on 10.11.54.6
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
Cc: Dominique Martinet <asmadeus@codewreck.org>, dhowells@redhat.com, linux-mm@kvack.org, Marc Dionne <marc.dionne@auristor.com>, linux-afs@lists.infradead.org, Paulo Alcantara <pc@manguebit.com>, linux-cifs@vger.kernel.org, Matthew Wilcox <willy@infradead.org>, Steve French <smfrench@gmail.com>, linux-cachefs@redhat.com, Gao Xiang <hsiangkao@linux.alibaba.com>, Ilya Dryomov <idryomov@gmail.com>, Shyam Prasad N <sprasad@microsoft.com>, Tom Talpey <tom@talpey.com>, ceph-devel@vger.kernel.org, Eric Van Hensbergen <ericvh@kernel.org>, Christian Brauner <christian@brauner.io>, linux-nfs@vger.kernel.org, netdev@vger.kernel.org, v9fs@lists.linux.dev, Jeff Layton <jlayton@kernel.org>, linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org, netfs@lists.linux.dev, linux-erofs@lists.ozlabs.org
Errors-To: linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org
Sender: "Linux-erofs" <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>

Simon Horman <horms@kernel.org> wrote:

> On Tue, Apr 02, 2024 at 09:32:37AM +0100, David Howells wrote:
> > Simon Horman <horms@kernel.org> wrote:
> > =

> > > > +	op->store.size		=3D len,
> > > =

> > > nit: this is probably more intuitively written using len;
> > =

> > I'm not sure it makes a difference, but switching 'size' to 'len' in k=
afs is a
> > separate thing that doesn't need to be part of this patchset.
> =

> Sorry, I meant, using ';' rather than ',' at the end of the line.

Ah, yes.  That makes a lot more sense!

David

