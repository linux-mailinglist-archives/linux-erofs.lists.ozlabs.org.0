Return-Path: <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>
X-Original-To: lists+linux-erofs@lfdr.de
Delivered-To: lists+linux-erofs@lfdr.de
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2404:9400:2:0:216:3eff:fee1:b9f1])
	by mail.lfdr.de (Postfix) with ESMTPS id 3C1C58A780D
	for <lists+linux-erofs@lfdr.de>; Wed, 17 Apr 2024 00:48:24 +0200 (CEST)
Authentication-Results: lists.ozlabs.org;
	dkim=fail reason="signature verification failed" (1024-bit key; unprotected) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=DJR/ZtKC;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=fj0SwQpC;
	dkim-atps=neutral
Received: from boromir.ozlabs.org (localhost [IPv6:::1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4VJzj15D3kz3vXJ
	for <lists+linux-erofs@lfdr.de>; Wed, 17 Apr 2024 08:48:21 +1000 (AEST)
X-Original-To: linux-erofs@lists.ozlabs.org
Delivered-To: linux-erofs@lists.ozlabs.org
Authentication-Results: lists.ozlabs.org;
	dkim=pass (1024-bit key; unprotected) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=DJR/ZtKC;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=fj0SwQpC;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=redhat.com (client-ip=170.10.129.124; helo=us-smtp-delivery-124.mimecast.com; envelope-from=dhowells@redhat.com; receiver=lists.ozlabs.org)
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4VJzhx5lVVz3c9N
	for <linux-erofs@lists.ozlabs.org>; Wed, 17 Apr 2024 08:48:16 +1000 (AEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1713307693;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=dQOrgp2MD172t9l6XQGW4lrZCkMqV6c2thjTwzveTuc=;
	b=DJR/ZtKCXcdVSkucSqR7mNgg6MFuwZwkpXH96glqohqdfX6b0UjUt5JVpAKoniu/HYWNQT
	KzOdCNNDCmK4DRpy9mC/cwB3tpd3XrXw1jPWpXI3HZrPasNdg8Sm+MZz+sPZYA0mqdoy2B
	SrARJWx1OQsRAjVv474jll9jJ6n7fQc=
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1713307694;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=dQOrgp2MD172t9l6XQGW4lrZCkMqV6c2thjTwzveTuc=;
	b=fj0SwQpCAoPOX017fO/S3m+ssINvsqQyrpd05+IBfhGgEsv40odH+qoY8HVyYTtxpIhMsv
	73y3j5aEBGj+vWSloZlBjkYxz7zDpMtQ7gQcEf9YRxEsyPiyPA0p62ZhwgzyewSmL/DKly
	VdG61rFM3q7mKKu7S/h2oiUsigpGD3U=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-587-dt0tRQhmPu-rFZtjV6hU-A-1; Tue, 16 Apr 2024 18:48:08 -0400
X-MC-Unique: dt0tRQhmPu-rFZtjV6hU-A-1
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.rdu2.redhat.com [10.11.54.5])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mimecast-mx02.redhat.com (Postfix) with ESMTPS id C46DD80A1B9;
	Tue, 16 Apr 2024 22:48:06 +0000 (UTC)
Received: from warthog.procyon.org.uk (unknown [10.42.28.10])
	by smtp.corp.redhat.com (Postfix) with ESMTP id DCEA51BDAA;
	Tue, 16 Apr 2024 22:48:02 +0000 (UTC)
Organization: Red Hat UK Ltd. Registered Address: Red Hat UK Ltd, Amberley
	Place, 107-111 Peascod Street, Windsor, Berkshire, SI4 1TE, United
	Kingdom.
	Registered in England and Wales under Company Registration No. 3798903
From: David Howells <dhowells@redhat.com>
In-Reply-To: <b6b6f41b9de1fc4128c3b3fe5aefc82d07a2347b.camel@kernel.org>
References: <b6b6f41b9de1fc4128c3b3fe5aefc82d07a2347b.camel@kernel.org> <20240328163424.2781320-1-dhowells@redhat.com> <20240328163424.2781320-4-dhowells@redhat.com>
To: Jeff Layton <jlayton@kernel.org>, Steve French <smfrench@gmail.com>
Subject: Re: [PATCH 03/26] netfs: Update i_blocks when write committed to pagecache
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-ID: <2755235.1713307678.1@warthog.procyon.org.uk>
Content-Transfer-Encoding: quoted-printable
Date: Tue, 16 Apr 2024 23:47:58 +0100
Message-ID: <2755236.1713307678@warthog.procyon.org.uk>
X-Scanned-By: MIMEDefang 3.4.1 on 10.11.54.5
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
Cc: Dominique Martinet <asmadeus@codewreck.org>, dhowells@redhat.com, linux-mm@kvack.org, Marc Dionne <marc.dionne@auristor.com>, linux-afs@lists.infradead.org, Paulo Alcantara <pc@manguebit.com>, linux-cifs@vger.kernel.org, Matthew Wilcox <willy@infradead.org>, linux-cachefs@redhat.com, Gao Xiang <hsiangkao@linux.alibaba.com>, Ilya Dryomov <idryomov@gmail.com>, Shyam Prasad N <nspmangalore@gmail.com>, Shyam Prasad N <sprasad@microsoft.com>, Tom Talpey <tom@talpey.com>, ceph-devel@vger.kernel.org, Eric Van Hensbergen <ericvh@kernel.org>, Christian Brauner <christian@brauner.io>, linux-nfs@vger.kernel.org, Rohith Surabattula <rohiths.msft@gmail.com>, netdev@vger.kernel.org, v9fs@lists.linux.dev, linux-kernel@vger.kernel.org, Steve French <sfrench@samba.org>, linux-fsdevel@vger.kernel.org, netfs@lists.linux.dev, linux-erofs@lists.ozlabs.org
Errors-To: linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org
Sender: "Linux-erofs" <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>

Jeff Layton <jlayton@kernel.org> wrote:

> > Update i_blocks when i_size is updated when we finish making a write t=
o the
> > pagecache to reflect the amount of space we think will be consumed.
> > =

> =

> Umm ok, but why? I get that the i_size and i_blocks would be out of sync
> until we get back new attrs from the server, but is that a problem? I'm
> mainly curious as to what's paying attention to the i_blocks during this
> window.

This is taking over from a cifs patch that does the same thing - but in co=
de
that is removed by my cifs-netfs branch, so I should probably let Steve sp=
eak
to that, though I think the problem with cifs is that these fields aren't
properly updated until the closure occurs and the server is consulted.

    commit dbfdff402d89854126658376cbcb08363194d3cd
    Author: Steve French <stfrench@microsoft.com>
    Date:   Thu Feb 22 00:26:52 2024 -0600

    smb3: update allocation size more accurately on write completion

    Changes to allocation size are approximated for extending writes of ca=
ched
    files until the server returns the actual value (on SMB3 close or quer=
y info
    for example), but it was setting the estimated value for number of blo=
cks
    to larger than the file size even if the file is likely sparse which
    breaks various xfstests (e.g. generic/129, 130, 221, 228).
    =

    When i_size and i_blocks are updated in write completion do not increa=
se
    allocation size more than what was written (rounded up to 512 bytes).

David

