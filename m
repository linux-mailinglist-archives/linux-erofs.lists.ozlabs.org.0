Return-Path: <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>
X-Original-To: lists+linux-erofs@lfdr.de
Delivered-To: lists+linux-erofs@lfdr.de
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	by mail.lfdr.de (Postfix) with ESMTPS id 9196A470412
	for <lists+linux-erofs@lfdr.de>; Fri, 10 Dec 2021 16:42:14 +0100 (CET)
Received: from boromir.ozlabs.org (localhost [IPv6:::1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4J9ZsJ3jhjz3c6y
	for <lists+linux-erofs@lfdr.de>; Sat, 11 Dec 2021 02:42:12 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org;
	dkim=fail reason="signature verification failed" (1024-bit key; unprotected) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=KCtoYOU0;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=KCtoYOU0;
	dkim-atps=neutral
X-Original-To: linux-erofs@lists.ozlabs.org
Delivered-To: linux-erofs@lists.ozlabs.org
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized)
 smtp.mailfrom=redhat.com (client-ip=170.10.133.124;
 helo=us-smtp-delivery-124.mimecast.com; envelope-from=dhowells@redhat.com;
 receiver=<UNKNOWN>)
Authentication-Results: lists.ozlabs.org; dkim=pass (1024-bit key;
 unprotected) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256
 header.s=mimecast20190719 header.b=KCtoYOU0; 
 dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com
 header.a=rsa-sha256 header.s=mimecast20190719 header.b=KCtoYOU0; 
 dkim-atps=neutral
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.133.124])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 4J9ZsD2trhz3bfl
 for <linux-erofs@lists.ozlabs.org>; Sat, 11 Dec 2021 02:42:07 +1100 (AEDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1639150924;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=vXcsyPR601Yj3OPOwr7kbflW1Oar2nIVgWDWOuLn61o=;
 b=KCtoYOU0PSm1tEkJPaxFesP76/W6g/I8SCq0XVd0SdVYwOeuNa5hpCjpVXRMQ08ltxjtwF
 0ZnpGEXAqSDwr8Tc7GNV9PalBeZdyInwpsErARryY1ivD7ah2HfN1zmAbLm2rI+9l3bpkY
 UdaK2/w0GFt5YbzJifErXDYJqvIJ3Qs=
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1639150924;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=vXcsyPR601Yj3OPOwr7kbflW1Oar2nIVgWDWOuLn61o=;
 b=KCtoYOU0PSm1tEkJPaxFesP76/W6g/I8SCq0XVd0SdVYwOeuNa5hpCjpVXRMQ08ltxjtwF
 0ZnpGEXAqSDwr8Tc7GNV9PalBeZdyInwpsErARryY1ivD7ah2HfN1zmAbLm2rI+9l3bpkY
 UdaK2/w0GFt5YbzJifErXDYJqvIJ3Qs=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-40-n9EIVVDQMLmhaVgyRWP9oQ-1; Fri, 10 Dec 2021 10:42:01 -0500
X-MC-Unique: n9EIVVDQMLmhaVgyRWP9oQ-1
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.phx2.redhat.com
 [10.5.11.13])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 3761E86A07B;
 Fri, 10 Dec 2021 15:41:59 +0000 (UTC)
Received: from warthog.procyon.org.uk (unknown [10.33.36.122])
 by smtp.corp.redhat.com (Postfix) with ESMTP id C5ED91B42C;
 Fri, 10 Dec 2021 15:41:49 +0000 (UTC)
Organization: Red Hat UK Ltd. Registered Address: Red Hat UK Ltd, Amberley
 Place, 107-111 Peascod Street, Windsor, Berkshire, SI4 1TE, United
 Kingdom.
 Registered in England and Wales under Company Registration No. 3798903
From: David Howells <dhowells@redhat.com>
In-Reply-To: <20211210073619.21667-10-jefflexu@linux.alibaba.com>
References: <20211210073619.21667-10-jefflexu@linux.alibaba.com>
 <20211210073619.21667-1-jefflexu@linux.alibaba.com>
To: Jeffle Xu <jefflexu@linux.alibaba.com>
Subject: Re: [RFC 09/19] netfs: refactor netfs_rreq_unlock()
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-ID: <292571.1639150908.1@warthog.procyon.org.uk>
Date: Fri, 10 Dec 2021 15:41:48 +0000
Message-ID: <292572.1639150908@warthog.procyon.org.uk>
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.13
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
Cc: tao.peng@linux.alibaba.com, linux-kernel@vger.kernel.org,
 dhowells@redhat.com, joseph.qi@linux.alibaba.com, linux-cachefs@redhat.com,
 bo.liu@linux.alibaba.com, linux-fsdevel@vger.kernel.org,
 gerry@linux.alibaba.com, linux-erofs@lists.ozlabs.org, eguan@linux.alibaba.com
Errors-To: linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org
Sender: "Linux-erofs"
 <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>

Jeffle Xu <jefflexu@linux.alibaba.com> wrote:

> In demand-read case, the input folio of netfs API is may not the page

"is may not the page"?  I think you're missing a verb (and you have too many
auxiliary verbs;-)

David

