Return-Path: <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>
X-Original-To: lists+linux-erofs@lfdr.de
Delivered-To: lists+linux-erofs@lfdr.de
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	by mail.lfdr.de (Postfix) with ESMTPS id CEC3462BFC8
	for <lists+linux-erofs@lfdr.de>; Wed, 16 Nov 2022 14:42:09 +0100 (CET)
Received: from boromir.ozlabs.org (localhost [IPv6:::1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4NC43M5J4hz3cKG
	for <lists+linux-erofs@lfdr.de>; Thu, 17 Nov 2022 00:42:07 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org;
	dkim=fail reason="signature verification failed" (1024-bit key; unprotected) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=CGWZq7lE;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=eNopsp8a;
	dkim-atps=neutral
X-Original-To: linux-erofs@lists.ozlabs.org
Delivered-To: linux-erofs@lists.ozlabs.org
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=redhat.com (client-ip=170.10.129.124; helo=us-smtp-delivery-124.mimecast.com; envelope-from=dhowells@redhat.com; receiver=<UNKNOWN>)
Authentication-Results: lists.ozlabs.org;
	dkim=pass (1024-bit key; unprotected) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=CGWZq7lE;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=eNopsp8a;
	dkim-atps=neutral
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4NC43B0Cd6z3cFZ
	for <linux-erofs@lists.ozlabs.org>; Thu, 17 Nov 2022 00:41:56 +1100 (AEDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1668606113;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=Hthprm1ypSC4H9RqIYyAtXvnaUxVWoTWmoLjvcjOG60=;
	b=CGWZq7lEj1Ygr7kTa4/yIczxGXBa5kiigPxUBk/WB9syRbal4KqMwN4JWxjrdCiXinYYyB
	4lx1LY3mcuTilEtrqqEnNHWgkDmXFkzmZG62zC5U6aY8Jh847s/eaasxouVzLRlp/YKmX4
	INMNOLzkKViEa8vS3v2o4CRLeg8tKZo=
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1668606114;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=Hthprm1ypSC4H9RqIYyAtXvnaUxVWoTWmoLjvcjOG60=;
	b=eNopsp8agHSnrmDmUQCQ9xl4/zeeWwfqjKIoQhPtjvteterJvB4lonSKw10Zj7rLMe/NBP
	fKWp/LBxOSKYOxLziuEgorBth/A7MZ+Hg3gzyJizrvwgWkTUO5krWw4OnN+92hjvV/aMvI
	JnZRxNkLijwMIjwTGGQ7y15k70lfGTg=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-529-OEYROdlKO_qh-fNyr-TMBw-1; Wed, 16 Nov 2022 08:41:46 -0500
X-MC-Unique: OEYROdlKO_qh-fNyr-TMBw-1
Received: from smtp.corp.redhat.com (int-mx07.intmail.prod.int.rdu2.redhat.com [10.11.54.7])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mimecast-mx02.redhat.com (Postfix) with ESMTPS id B0D6A101CC6D;
	Wed, 16 Nov 2022 13:41:45 +0000 (UTC)
Received: from warthog.procyon.org.uk (unknown [10.33.36.24])
	by smtp.corp.redhat.com (Postfix) with ESMTP id 723EE140EBF3;
	Wed, 16 Nov 2022 13:41:44 +0000 (UTC)
Organization: Red Hat UK Ltd. Registered Address: Red Hat UK Ltd, Amberley
	Place, 107-111 Peascod Street, Windsor, Berkshire, SI4 1TE, United
	Kingdom.
	Registered in England and Wales under Company Registration No. 3798903
From: David Howells <dhowells@redhat.com>
In-Reply-To: <2b595b62f6ecd28298a860fcdc5b4941dcafd9eb.camel@kernel.org>
References: <2b595b62f6ecd28298a860fcdc5b4941dcafd9eb.camel@kernel.org> <20221116104502.107431-1-jefflexu@linux.alibaba.com> <20221116104502.107431-2-jefflexu@linux.alibaba.com>
To: Jeff Layton <jlayton@kernel.org>
Subject: Re: [PATCH v3 1/2] fscache,cachefiles: add prepare_ondemand_read() callback
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-ID: <2968418.1668606101.1@warthog.procyon.org.uk>
Content-Transfer-Encoding: quoted-printable
Date: Wed, 16 Nov 2022 13:41:41 +0000
Message-ID: <2968419.1668606101@warthog.procyon.org.uk>
X-Scanned-By: MIMEDefang 3.1 on 10.11.54.7
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
Cc: linux-kernel@vger.kernel.org, dhowells@redhat.com, linux-fsdevel@vger.kernel.org, linux-cachefs@redhat.com, linux-erofs@lists.ozlabs.org
Errors-To: linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org
Sender: "Linux-erofs" <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>

Jeff Layton <jlayton@kernel.org> wrote:

> > +static enum netfs_io_source cachefiles_do_prepare_read(struct netfs_c=
ache_resources *cres,
> > +					loff_t *_start, size_t *_len,
> > +					unsigned long *_flags, loff_t i_size)
>
> _start is never changed, so it should be passed by value instead of by
> pointer.

Hmmm.  The intention was that the start pointer should be able to be moved
backwards by the cache - but that's not necessary in ->prepare_read() and
->expand_readahead() is provided for that now.  So yes, the start pointer
shouldn't get changed at this point.

> I'd also reverse the position of the arguments for _flags and i_size.
> Otherwise, the CPU/compiler have to shuffle things around more in
> cachefiles_prepare_ondemand_read before they call this.

Better to pass the flags in and then ignore them.  That way it can tail ca=
ll,
or just call cachefiles_do_prepare_read() directly from erofs.  If you're
going to have a wrapper, then you might be just as well create a
netfs_io_subrequest struct on the stack.

David

