Return-Path: <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>
X-Original-To: lists+linux-erofs@lfdr.de
Delivered-To: lists+linux-erofs@lfdr.de
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2404:9400:2:0:216:3eff:fee1:b9f1])
	by mail.lfdr.de (Postfix) with ESMTPS id AFCCF66600A
	for <lists+linux-erofs@lfdr.de>; Wed, 11 Jan 2023 17:10:03 +0100 (CET)
Received: from boromir.ozlabs.org (localhost [IPv6:::1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4NsXh93TPDz3c8M
	for <lists+linux-erofs@lfdr.de>; Thu, 12 Jan 2023 03:10:01 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org;
	dkim=fail reason="signature verification failed" (1024-bit key; unprotected) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=Wn/UbK8g;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=bvvBc0gJ;
	dkim-atps=neutral
X-Original-To: linux-erofs@lists.ozlabs.org
Delivered-To: linux-erofs@lists.ozlabs.org
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=redhat.com (client-ip=170.10.133.124; helo=us-smtp-delivery-124.mimecast.com; envelope-from=dhowells@redhat.com; receiver=<UNKNOWN>)
Authentication-Results: lists.ozlabs.org;
	dkim=pass (1024-bit key; unprotected) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=Wn/UbK8g;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=bvvBc0gJ;
	dkim-atps=neutral
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4NsXh60hrSz2ynD
	for <linux-erofs@lists.ozlabs.org>; Thu, 12 Jan 2023 03:09:57 +1100 (AEDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1673453392;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=ED6zPjm7mtrHMK8B7KMZYr4k0FzaJh6lrc0c3Lwxsxo=;
	b=Wn/UbK8giO1JbFdUJ+QRT/74+2tRnT4bldh+ouwcyADwouX9wR69N36bQOPtMqBpLeyPpA
	WI/e/qoPLE1GCGPSyhSieGGJZR+r+RRmD4o5BlNIZtEr3Dgi7zWye5Heyq9p/+LETmAJVA
	J5Q5+04byDOfUAeWa763V4sFPDwVbR4=
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1673453393;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=ED6zPjm7mtrHMK8B7KMZYr4k0FzaJh6lrc0c3Lwxsxo=;
	b=bvvBc0gJE9Q+vucsoFi5GqADLFYvZ4dMrtqMAg6eOjIp78Q27DaeyZi+mjBNA3zQjL+Srr
	+HGEwXEE6DJSwAHJvB5RVPLC9Lj1xky7qCkGh9pXQFHplt3qTs4fZC0dKKVodxM7OEiv2a
	u7BZn9qWmEjJOKkRnIIuW8Vk6Hh3V5I=
Received: from mimecast-mx02.redhat.com (mx3-rdu2.redhat.com
 [66.187.233.73]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-380-5CDp3c7XNkOWDTcWvnPtIg-1; Wed, 11 Jan 2023 11:09:48 -0500
X-MC-Unique: 5CDp3c7XNkOWDTcWvnPtIg-1
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.rdu2.redhat.com [10.11.54.2])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 7332C381494F;
	Wed, 11 Jan 2023 16:09:48 +0000 (UTC)
Received: from warthog.procyon.org.uk (unknown [10.33.36.87])
	by smtp.corp.redhat.com (Postfix) with ESMTP id 7E2F040C115E;
	Wed, 11 Jan 2023 16:09:47 +0000 (UTC)
Organization: Red Hat UK Ltd. Registered Address: Red Hat UK Ltd, Amberley
	Place, 107-111 Peascod Street, Windsor, Berkshire, SI4 1TE, United
	Kingdom.
	Registered in England and Wales under Company Registration No. 3798903
From: David Howells <dhowells@redhat.com>
In-Reply-To: <20221226103309.953112-3-houtao@huaweicloud.com>
References: <20221226103309.953112-3-houtao@huaweicloud.com> <20221226103309.953112-1-houtao@huaweicloud.com>
To: Hou Tao <houtao@huaweicloud.com>
Subject: Re: [PATCH v2 2/2] fscache: Add the missing smp_mb__after_atomic() before wake_up_bit()
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-ID: <2431993.1673453386.1@warthog.procyon.org.uk>
Date: Wed, 11 Jan 2023 16:09:46 +0000
Message-ID: <2431994.1673453386@warthog.procyon.org.uk>
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
Cc: Jeff Layton <jlayton@kernel.org>, linux-kernel@vger.kernel.org, dhowells@redhat.com, linux-cachefs@redhat.com, houtao1@huawei.com, linux-erofs@lists.ozlabs.org
Errors-To: linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org
Sender: "Linux-erofs" <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>

Hou Tao <houtao@huaweicloud.com> wrote:

> fscache_create_volume_work() uses wake_up_bit() to wake up the processes
> which are waiting for the completion of volume creation. According to
> comments in wake_up_bit() and waitqueue_active(), an extra smp_mb() is
> needed to guarantee the memory order between FSCACHE_VOLUME_CREATING
> flag and waitqueue_active() before invoking wake_up_bit().

What two values are you ordering?

If we're using this to create a critical section, then yes, we would need a
barrier to order the changes inside the critical section before changing the
memory location that forms the lock - but this is not a critical section.

David

