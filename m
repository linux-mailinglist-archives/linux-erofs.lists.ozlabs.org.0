Return-Path: <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>
X-Original-To: lists+linux-erofs@lfdr.de
Delivered-To: lists+linux-erofs@lfdr.de
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2404:9400:2:0:216:3eff:fee1:b9f1])
	by mail.lfdr.de (Postfix) with ESMTPS id 230CD8375C2
	for <lists+linux-erofs@lfdr.de>; Mon, 22 Jan 2024 23:01:43 +0100 (CET)
Authentication-Results: lists.ozlabs.org;
	dkim=fail reason="signature verification failed" (1024-bit key; unprotected) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=CiYu4C/y;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=EBEW7/M+;
	dkim-atps=neutral
Received: from boromir.ozlabs.org (localhost [IPv6:::1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4TJkhN5t0Bz3bnL
	for <lists+linux-erofs@lfdr.de>; Tue, 23 Jan 2024 09:01:40 +1100 (AEDT)
X-Original-To: linux-erofs@lists.ozlabs.org
Delivered-To: linux-erofs@lists.ozlabs.org
Authentication-Results: lists.ozlabs.org;
	dkim=pass (1024-bit key; unprotected) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=CiYu4C/y;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=EBEW7/M+;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=redhat.com (client-ip=170.10.129.124; helo=us-smtp-delivery-124.mimecast.com; envelope-from=dhowells@redhat.com; receiver=lists.ozlabs.org)
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4TJkhG2ckyz3bfS
	for <linux-erofs@lists.ozlabs.org>; Tue, 23 Jan 2024 09:01:32 +1100 (AEDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1705960889;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=YgorZ9y1ABigf+8AfYUUWexSMaoGg5QlyfBL6eKu5CY=;
	b=CiYu4C/yKv3jA9YMLERjCsmqai3i625wHtaIuS0Y/yOeS48iGU3wWOz9XZqWaEYnWDmZqQ
	YGWemaMX0fvBFlbvylBUnq0QqoKS+3CvTXm3Y9MmIV2IRB9WPOu4+0GkSA6gpn7/RPpVke
	76l0uxBAur1U3nsnl91zkhB3Nqm9l5k=
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1705960890;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=YgorZ9y1ABigf+8AfYUUWexSMaoGg5QlyfBL6eKu5CY=;
	b=EBEW7/M+Pfow7m19Iy0Z74x+/3j92NkJgVJOUMMJr8ERwaVArtvH3ZQhiGB67GIe75jkyE
	OF8NSeC+yNtIZDdzy0wVOGZk894JpDR4w7DJt3oeoFv83Yrsp3p8riZQ7Pc+X2Rgp7t8UB
	s2N1HaFb+W+S5CLi/oUVY9A8obToKBc=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-653-FVBxaMfkOUaLwqIkj88Zsg-1; Mon, 22 Jan 2024 17:01:24 -0500
X-MC-Unique: FVBxaMfkOUaLwqIkj88Zsg-1
Received: from smtp.corp.redhat.com (int-mx09.intmail.prod.int.rdu2.redhat.com [10.11.54.9])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mimecast-mx02.redhat.com (Postfix) with ESMTPS id D9621845E60;
	Mon, 22 Jan 2024 22:01:22 +0000 (UTC)
Received: from warthog.procyon.org.uk (unknown [10.42.28.67])
	by smtp.corp.redhat.com (Postfix) with ESMTP id 77F78492BC6;
	Mon, 22 Jan 2024 22:01:20 +0000 (UTC)
Organization: Red Hat UK Ltd. Registered Address: Red Hat UK Ltd, Amberley
	Place, 107-111 Peascod Street, Windsor, Berkshire, SI4 1TE, United
	Kingdom.
	Registered in England and Wales under Company Registration No. 3798903
From: David Howells <dhowells@redhat.com>
In-Reply-To: <7790423f-665e-44cc-b4ae-d3f3d2996af5@linux.alibaba.com>
References: <7790423f-665e-44cc-b4ae-d3f3d2996af5@linux.alibaba.com> <20240122123845.3822570-1-dhowells@redhat.com> <20240122123845.3822570-7-dhowells@redhat.com>
To: Jingbo Xu <jefflexu@linux.alibaba.com>
Subject: Re: [PATCH 06/10] cachefiles, erofs: Fix NULL deref in when cachefiles is not doing ondemand-mode
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-ID: <3980815.1705960879.1@warthog.procyon.org.uk>
Date: Mon, 22 Jan 2024 22:01:19 +0000
Message-ID: <3980816.1705960879@warthog.procyon.org.uk>
X-Scanned-By: MIMEDefang 3.4.1 on 10.11.54.9
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
Cc: linux-cifs@vger.kernel.org, linux-nfs@vger.kernel.org, v9fs@lists.linux.dev, Jeff Layton <jlayton@kernel.org>, linux-kernel@vger.kernel.org, Matthew Wilcox <willy@infradead.org>, Marc Dionne <marc.dionne@auristor.com>, dhowells@redhat.com, linux-mm@kvack.org, Yue Hu <huyue2@coolpad.com>, linux-fsdevel@vger.kernel.org, netfs@lists.linux.dev, ceph-devel@vger.kernel.org, linux-erofs@lists.ozlabs.org, linux-afs@lists.infradead.org, Christian Brauner <christian@brauner.io>
Errors-To: linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org
Sender: "Linux-erofs" <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>

Jingbo Xu <jefflexu@linux.alibaba.com> wrote:

> > -	ret = cachefiles_ondemand_init_object(object);
> > -	if (ret < 0)
> > -		goto err_unuse;
> > +	if (object->ondemand) {
> > +		ret = cachefiles_ondemand_init_object(object);
> > +		if (ret < 0)
> > +			goto err_unuse;
> > +	}
> 
> I'm not sure if object->ondemand shall be checked by the caller or
> inside cachefiles_ondemand_init_object(), as
> cachefiles_ondemand_clean_object() is also called without checking
> object->ondemand. cachefiles_ondemand_clean_object() won't trigger the
> NULL oops as the called cachefiles_ondemand_send_req() will actually
> checks that.

Meh.  The above doesn't actually build if CONFIG_CACHEFILES_ONDEMAND=N.  I
think I have to push the check down into cachefiles_ondemand_init_object()
instead.

David

