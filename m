Return-Path: <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>
X-Original-To: lists+linux-erofs@lfdr.de
Delivered-To: lists+linux-erofs@lfdr.de
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	by mail.lfdr.de (Postfix) with ESMTPS id 75B0264819F
	for <lists+linux-erofs@lfdr.de>; Fri,  9 Dec 2022 12:27:17 +0100 (CET)
Received: from boromir.ozlabs.org (localhost [IPv6:::1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4NT7z54DKtz3bfZ
	for <lists+linux-erofs@lfdr.de>; Fri,  9 Dec 2022 22:27:13 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org;
	dkim=fail reason="signature verification failed" (1024-bit key; unprotected) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=A7wHeBhY;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=A7wHeBhY;
	dkim-atps=neutral
X-Original-To: linux-erofs@lists.ozlabs.org
Delivered-To: linux-erofs@lists.ozlabs.org
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=redhat.com (client-ip=170.10.133.124; helo=us-smtp-delivery-124.mimecast.com; envelope-from=dhowells@redhat.com; receiver=<UNKNOWN>)
Authentication-Results: lists.ozlabs.org;
	dkim=pass (1024-bit key; unprotected) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=A7wHeBhY;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=A7wHeBhY;
	dkim-atps=neutral
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4NT7yv49S6z3bXW
	for <linux-erofs@lists.ozlabs.org>; Fri,  9 Dec 2022 22:27:01 +1100 (AEDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1670585217;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=Fk6lJ/K747gX2RARMStBT56RkzQK/6QuPSWKbrkfp3w=;
	b=A7wHeBhY5IjaA2ZTnrM+XeKEn4UzQNMOZW1TwDWTnffdAWyr3YN6VMm9oOlDAlq98JQaro
	eBSukDOAcAoAuwET/l9HuzTt5YxVBp5IMTDCkwEr0DaFgXqT/YFmiITojI17OBA4aDsH8r
	utmwoUSB4xUWC7pF13XFNzCdg2MQGQo=
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1670585217;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=Fk6lJ/K747gX2RARMStBT56RkzQK/6QuPSWKbrkfp3w=;
	b=A7wHeBhY5IjaA2ZTnrM+XeKEn4UzQNMOZW1TwDWTnffdAWyr3YN6VMm9oOlDAlq98JQaro
	eBSukDOAcAoAuwET/l9HuzTt5YxVBp5IMTDCkwEr0DaFgXqT/YFmiITojI17OBA4aDsH8r
	utmwoUSB4xUWC7pF13XFNzCdg2MQGQo=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-596-bZbAd-KNPDi39SLGApyWzA-1; Fri, 09 Dec 2022 06:26:55 -0500
X-MC-Unique: bZbAd-KNPDi39SLGApyWzA-1
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.rdu2.redhat.com [10.11.54.2])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 26A61185A794;
	Fri,  9 Dec 2022 11:26:55 +0000 (UTC)
Received: from warthog.procyon.org.uk (unknown [10.33.36.17])
	by smtp.corp.redhat.com (Postfix) with ESMTP id A5FA640C6EC2;
	Fri,  9 Dec 2022 11:26:53 +0000 (UTC)
Organization: Red Hat UK Ltd. Registered Address: Red Hat UK Ltd, Amberley
	Place, 107-111 Peascod Street, Windsor, Berkshire, SI4 1TE, United
	Kingdom.
	Registered in England and Wales under Company Registration No. 3798903
From: David Howells <dhowells@redhat.com>
In-Reply-To: <42b33792-50e9-77d7-4d3e-ac5ce1adeda6@huaweicloud.com>
References: <42b33792-50e9-77d7-4d3e-ac5ce1adeda6@huaweicloud.com> <20221128031929.3918348-1-houtao@huaweicloud.com>
To: Hou Tao <houtao@huaweicloud.com>
Subject: Re: [PATCH] fscache: Use wake_up_var() to wake up pending volume acquisition
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-ID: <2308528.1670585211.1@warthog.procyon.org.uk>
Date: Fri, 09 Dec 2022 11:26:51 +0000
Message-ID: <2308529.1670585211@warthog.procyon.org.uk>
X-Scanned-By: MIMEDefang 3.1 on 10.11.54.2
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
Cc: Jeff Layton <jlayton@kernel.org>, linux-kernel@vger.kernel.org, dhowells@redhat.com, linux-cachefs@redhat.com, "houtao1@huawei.com" <houtao1@huawei.com>, linux-erofs@lists.ozlabs.org
Errors-To: linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org
Sender: "Linux-erofs" <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>

Hou Tao <houtao@huaweicloud.com> wrote:

> >  			clear_bit(FSCACHE_VOLUME_ACQUIRE_PENDING, &cursor->flags);

Maybe this should be clear_bit_unlock() instead.

And I wonder if:

	set_bit(FSCACHE_VOLUME_ACQUIRE_PENDING, &candidate->flags);

in fscache_hash_volume() needs a barrier before it.

> > -			wake_up_bit(&cursor->flags, FSCACHE_VOLUME_ACQUIRE_PENDING);
> > +			/*
> > +			 * Paired with barrier in wait_var_event(). Check
> > +			 * waitqueue_active() and wake_up_var() for details.
> > +			 */
> > +			smp_mb__after_atomic();
> > +			wake_up_var(&cursor->flags);

That doesn't seem right.

wake_up_bit() is more selective, so should be preferred to wake_up_var().

David

