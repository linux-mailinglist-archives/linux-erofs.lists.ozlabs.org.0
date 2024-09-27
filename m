Return-Path: <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>
X-Original-To: lists+linux-erofs@lfdr.de
Delivered-To: lists+linux-erofs@lfdr.de
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	by mail.lfdr.de (Postfix) with ESMTPS id BD259988BB6
	for <lists+linux-erofs@lfdr.de>; Fri, 27 Sep 2024 23:12:06 +0200 (CEST)
Received: from boromir.ozlabs.org (localhost [IPv6:::1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4XFjpD1kXpz3cR3
	for <lists+linux-erofs@lfdr.de>; Sat, 28 Sep 2024 07:12:04 +1000 (AEST)
X-Original-To: linux-erofs@lists.ozlabs.org
Delivered-To: linux-erofs@lists.ozlabs.org
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip=170.10.133.124
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1727471522;
	cv=none; b=A3zBwSNFzNk4wKLrImD5InmqcvZSzVrQ2D3U3I3RgNGQTx4zWPzh1bn4JdVZzEoRb2V4JOT7I4p/9ZC2UGC9hOBOZ8WvM/XG0Bgi/52ia3kAYTZrdJlZ0xn+NwGNF8e3k45sBQz+5ZHk55C5MxCVWLIPs+CQjBeJ85mhP7Sec1pzHSuQTHCkAOQWf5Yx2mPsL3h2G/95G15GSXkiwbbqNvFPgWJb9c7uQbNtvW7Ax7nKGknLF5KCo83jOpemQ92MHQZdD6jRxKovS8pN8U4BTpsEUPd4z4a+2rqvmDGu5I+nlu1ozRhtmqVYNk149Lc0aae4n8QeSob30rmCOX8ynw==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1727471522; c=relaxed/relaxed;
	bh=8uMxOBU2H6Hw+qD+HRMDEGiSShQKw6OKRseN26Hxg0M=;
	h=From:In-Reply-To:References:To:Cc:Subject:MIME-Version:
	 Content-Type:Date:Message-ID; b=fPwOr5iynA7tgcxOYl7R0wKVXwqc5qVDFBc+r6VzXTSghn4JWAATmjw6cfjkV37GAH/ffxoRBqbQkWemO1p0ZJsuCTnWpv/PKkMqrcoSuTxOdqNKpyfnBf+fGJk3kKmo3/7SEpOHuMzpLgLwQ75iHYyA1dQRpKnWhTERZwvIqQMpyIY1K/LCqJ0S0xzA0GXfkXQkhYS67bqmf6cuRdrkx7fYSJOEqdnw8JkKhXfISU8b4rF+jUBxABJq3vAUd0ihcFND5VGPIDCW08uF9gP/9KVzzDQlHtVSGdAIhLzhjE1v6kbFmt38Jg9zruqxv7Ej7cuwdzWzfQsYyFqU2Z9eoQ==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=redhat.com; dkim=pass (1024-bit key; unprotected) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=FsJTpKKn; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=JklNceAp; dkim-atps=neutral; spf=pass (client-ip=170.10.133.124; helo=us-smtp-delivery-124.mimecast.com; envelope-from=dhowells@redhat.com; receiver=lists.ozlabs.org) smtp.mailfrom=redhat.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (1024-bit key; unprotected) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=FsJTpKKn;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=JklNceAp;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=redhat.com (client-ip=170.10.133.124; helo=us-smtp-delivery-124.mimecast.com; envelope-from=dhowells@redhat.com; receiver=lists.ozlabs.org)
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4XFjpB1nc5z3cPK
	for <linux-erofs@lists.ozlabs.org>; Sat, 28 Sep 2024 07:12:00 +1000 (AEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1727471515;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=8uMxOBU2H6Hw+qD+HRMDEGiSShQKw6OKRseN26Hxg0M=;
	b=FsJTpKKnXbio8SND1s1thRm9O+Ioa7LV/ohIU03LvcLBVubCeLSwPhE1dyTSBb+jfNKVZ8
	GHwWXy1+trr933LG+RJ+dfxgJ0lRhulKrVE+XI8QT/vWODhKbkXZugqJuHOGNKH4WxTm6k
	Vb4OZ/lpvZXFEEmyBeDVsN41G9vDUWQ=
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1727471516;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=8uMxOBU2H6Hw+qD+HRMDEGiSShQKw6OKRseN26Hxg0M=;
	b=JklNceAptZdLm/pkNZ0OnqtiOMn1BSZBAx+bmRMO2e6+by4MA9pc62X7yb7CsPw7Ok4Ado
	fWchGSOlXvFJT0ZTfUYTvQBzMZNfjg+kvFKBsHxAXLOdBYpp171kbAv+DKQ7zMCjfyJjSU
	M05sTznKj8BMd/+v97Ixj5H5lGCJDUY=
Received: from mx-prod-mc-02.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-528-nkGTJbKIOsK6M6_0H6aoDw-1; Fri,
 27 Sep 2024 17:11:52 -0400
X-MC-Unique: nkGTJbKIOsK6M6_0H6aoDw-1
Received: from mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com (unknown [10.30.177.4])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-02.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 8F2381936B95;
	Fri, 27 Sep 2024 21:11:49 +0000 (UTC)
Received: from warthog.procyon.org.uk (unknown [10.42.28.145])
	by mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id BC3D43003DF2;
	Fri, 27 Sep 2024 21:11:43 +0000 (UTC)
Organization: Red Hat UK Ltd. Registered Address: Red Hat UK Ltd, Amberley
	Place, 107-111 Peascod Street, Windsor, Berkshire, SI4 1TE, United
	Kingdom.
	Registered in England and Wales under Company Registration No. 3798903
From: David Howells <dhowells@redhat.com>
In-Reply-To: <55cef4bef5a14a70b97e104c4ddd8ef64430f168.camel@gmail.com>
References: <55cef4bef5a14a70b97e104c4ddd8ef64430f168.camel@gmail.com> <20240923183432.1876750-1-chantr4@gmail.com> <20240814203850.2240469-20-dhowells@redhat.com> <2663729.1727470216@warthog.procyon.org.uk>
To: Eduard Zingerman <eddyz87@gmail.com>
Subject: Re: [PATCH v2 19/25] netfs: Speed up buffered reading
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-ID: <2668611.1727471502.1@warthog.procyon.org.uk>
Content-Transfer-Encoding: quoted-printable
Date: Fri, 27 Sep 2024 22:11:42 +0100
Message-ID: <2668612.1727471502@warthog.procyon.org.uk>
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.4
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
Cc: asmadeus@codewreck.org, dhowells@redhat.com, linux-mm@kvack.org, marc.dionne@auristor.com, linux-afs@lists.infradead.org, pc@manguebit.com, linux-cifs@vger.kernel.org, Manu Bretelle <chantr4@gmail.com>, willy@infradead.org, smfrench@gmail.com, hsiangkao@linux.alibaba.com, idryomov@gmail.com, sprasad@microsoft.com, tom@talpey.com, ceph-devel@vger.kernel.org, ericvh@kernel.org, christian@brauner.io, linux-nfs@vger.kernel.org, netdev@vger.kernel.org, v9fs@lists.linux.dev, jlayton@kernel.org, linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org, netfs@lists.linux.dev, linux-erofs@lists.ozlabs.org
Errors-To: linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org
Sender: "Linux-erofs" <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>

Eduard Zingerman <eddyz87@gmail.com> wrote:

> On Fri, 2024-09-27 at 21:50 +0100, David Howells wrote:
> > Is it possible for you to turn on some tracepoints and access the trac=
es?
> > Granted, you probably need to do the enablement during boot.
> =

> Yes, sure, tell me what you need.

If you look here:

	https://git.kernel.org/pub/scm/linux/kernel/git/dhowells/linux-fs.git/log=
/?h=3Dnetfs-fixes

you can see some patches I've added.  If you can try this branch or cherry
pick:

	netfs: Fix write oops in generic/346 (9p) and generic/074 (cifs)
	netfs: Advance iterator correctly rather than jumping it
	netfs: Use a folio_queue allocation and free functions
	netfs: Add a tracepoint to log the lifespan of folio_queue structs

And then turn on the following "netfs" tracepoints:

	read,sreq,rreq,failure,write,write_iter,folio,folioq,progress,donate

which can be done by:

	echo 1 >/sys/kernel/debug/tracing/events/netfs/netfs_read/enable
	echo 1 >/sys/kernel/debug/tracing/events/netfs/netfs_rreq/enable
	echo 1 >/sys/kernel/debug/tracing/events/netfs/netfs_sreq/enable
	echo 1 >/sys/kernel/debug/tracing/events/netfs/netfs_failure/enable
	echo 1 >/sys/kernel/debug/tracing/events/netfs/netfs_write/enable
	echo 1 >/sys/kernel/debug/tracing/events/netfs/netfs_write_iter/enable
	echo 1 >/sys/kernel/debug/tracing/events/netfs/netfs_folio/enable
	echo 1 >/sys/kernel/debug/tracing/events/netfs/netfs_folioq/enable
	echo 1 >/sys/kernel/debug/tracing/events/netfs/netfs_progress/enable
	echo 1 >/sys/kernel/debug/tracing/events/netfs/netfs_donate/enable

or through trace-cmd.

> Alternatively I can pack this thing in a dockerfile, so that you would
> be able to reproduce locally (but that would have to wait till my evenin=
g).

I don't have Docker set up, so I'm not sure how easy that would be for me =
to
use.

Thanks,
David

