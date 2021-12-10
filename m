Return-Path: <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>
X-Original-To: lists+linux-erofs@lfdr.de
Delivered-To: lists+linux-erofs@lfdr.de
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2404:9400:2:0:216:3eff:fee1:b9f1])
	by mail.lfdr.de (Postfix) with ESMTPS id 1ACCD46FF54
	for <lists+linux-erofs@lfdr.de>; Fri, 10 Dec 2021 12:05:20 +0100 (CET)
Received: from boromir.ozlabs.org (localhost [IPv6:::1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4J9Sjn68nJz3c56
	for <lists+linux-erofs@lfdr.de>; Fri, 10 Dec 2021 22:05:17 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org;
	dkim=fail reason="signature verification failed" (1024-bit key; unprotected) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=OLXt6cEU;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=OLXt6cEU;
	dkim-atps=neutral
X-Original-To: linux-erofs@lists.ozlabs.org
Delivered-To: linux-erofs@lists.ozlabs.org
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized)
 smtp.mailfrom=redhat.com (client-ip=170.10.133.124;
 helo=us-smtp-delivery-124.mimecast.com; envelope-from=dhowells@redhat.com;
 receiver=<UNKNOWN>)
Authentication-Results: lists.ozlabs.org; dkim=pass (1024-bit key;
 unprotected) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256
 header.s=mimecast20190719 header.b=OLXt6cEU; 
 dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com
 header.a=rsa-sha256 header.s=mimecast20190719 header.b=OLXt6cEU; 
 dkim-atps=neutral
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.133.124])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 4J9Sjf4k5Rz3bVC
 for <linux-erofs@lists.ozlabs.org>; Fri, 10 Dec 2021 22:05:07 +1100 (AEDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1639134304;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=3tIObzwONcMa5RCd0Hkumd34/K1eKJP2JRRip7obC0A=;
 b=OLXt6cEUk4dlI1Ozc1g1WaY+wki2TDPyUQCeLFo2DAg5bd7+dWGB9hDYFGvwliKywXvuzH
 lQf1Jq045mKyUqHZxc75kIzS4Dh4TE19B/+6pa9iOR4JkwaXGCTFhEIROWSvmMN+V4UXR8
 PL9mfCE6vjfDaO3+EhTD9l+Xa3gUsvM=
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1639134304;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=3tIObzwONcMa5RCd0Hkumd34/K1eKJP2JRRip7obC0A=;
 b=OLXt6cEUk4dlI1Ozc1g1WaY+wki2TDPyUQCeLFo2DAg5bd7+dWGB9hDYFGvwliKywXvuzH
 lQf1Jq045mKyUqHZxc75kIzS4Dh4TE19B/+6pa9iOR4JkwaXGCTFhEIROWSvmMN+V4UXR8
 PL9mfCE6vjfDaO3+EhTD9l+Xa3gUsvM=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-384-npGU6MadO1yZ0BthSq5lCw-1; Fri, 10 Dec 2021 06:04:58 -0500
X-MC-Unique: npGU6MadO1yZ0BthSq5lCw-1
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.phx2.redhat.com
 [10.5.11.14])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 25790100E32C;
 Fri, 10 Dec 2021 11:04:57 +0000 (UTC)
Received: from warthog.procyon.org.uk (unknown [10.33.36.122])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 887B85D9D5;
 Fri, 10 Dec 2021 11:04:54 +0000 (UTC)
Organization: Red Hat UK Ltd. Registered Address: Red Hat UK Ltd, Amberley
 Place, 107-111 Peascod Street, Windsor, Berkshire, SI4 1TE, United
 Kingdom.
 Registered in England and Wales under Company Registration No. 3798903
From: David Howells <dhowells@redhat.com>
In-Reply-To: <20211210073619.21667-3-jefflexu@linux.alibaba.com>
References: <20211210073619.21667-3-jefflexu@linux.alibaba.com>
 <20211210073619.21667-1-jefflexu@linux.alibaba.com>
To: Jeffle Xu <jefflexu@linux.alibaba.com>
Subject: Re: [RFC 02/19] cachefiles: implement key scheme for demand-read mode
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-ID: <269787.1639134293.1@warthog.procyon.org.uk>
Date: Fri, 10 Dec 2021 11:04:53 +0000
Message-ID: <269788.1639134293@warthog.procyon.org.uk>
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.14
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

> Thus simplify the logic of placing backing files, in which backing files
> are under "cache/<volume>/" directory directly.

You then have a scalability issue on the directory inode lock - and there may
also be limits on the capacity of a directory.  The hash function is meant to
work the same, no matter the cpu arch, so you should be able to copy that to
userspace and derive the hash yourself.

> Also skip coherency checking currently to ease the development and debug.

Better if you can do that in erofs rather than cachefiles.  Just set your
coherency data to all zeros or something.

David

