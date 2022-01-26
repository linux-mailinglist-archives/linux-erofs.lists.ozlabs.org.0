Return-Path: <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>
X-Original-To: lists+linux-erofs@lfdr.de
Delivered-To: lists+linux-erofs@lfdr.de
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2404:9400:2:0:216:3eff:fee1:b9f1])
	by mail.lfdr.de (Postfix) with ESMTPS id 19C6149C58A
	for <lists+linux-erofs@lfdr.de>; Wed, 26 Jan 2022 09:52:03 +0100 (CET)
Received: from boromir.ozlabs.org (localhost [IPv6:::1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4JkHXJ6wsSz30Mn
	for <lists+linux-erofs@lfdr.de>; Wed, 26 Jan 2022 19:52:00 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org;
	dkim=fail reason="signature verification failed" (1024-bit key; unprotected) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=iNv6FgCr;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=a4hID7ue;
	dkim-atps=neutral
X-Original-To: linux-erofs@lists.ozlabs.org
Delivered-To: linux-erofs@lists.ozlabs.org
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized)
 smtp.mailfrom=redhat.com (client-ip=170.10.133.124;
 helo=us-smtp-delivery-124.mimecast.com; envelope-from=dhowells@redhat.com;
 receiver=<UNKNOWN>)
Authentication-Results: lists.ozlabs.org; dkim=pass (1024-bit key;
 unprotected) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256
 header.s=mimecast20190719 header.b=iNv6FgCr; 
 dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com
 header.a=rsa-sha256 header.s=mimecast20190719 header.b=a4hID7ue; 
 dkim-atps=neutral
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.133.124])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 4JkHXD0BXrz2yPv
 for <linux-erofs@lists.ozlabs.org>; Wed, 26 Jan 2022 19:51:53 +1100 (AEDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1643187110;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=pfOp64U0iYvSw+YJXe3pmYBUfoothO/ocAN1AyLo5xI=;
 b=iNv6FgCr2RzZBFMt/oAuSjVBhgEodPib8UPS9zGaQ5SmlRv3z9QkdJ+ws9yzMXNH2qu5AP
 URGfYotPfCrbjzGnp8zqKLct8awiYAnrbkNziZurjvSrp/FqAg6CprZLCRighrApH/SByz
 33NQmGjwGlkACGNDVmMc2xoh5kGB0qY=
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1643187111;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=pfOp64U0iYvSw+YJXe3pmYBUfoothO/ocAN1AyLo5xI=;
 b=a4hID7ueWTNyqXOzcdOhwqwwnpbK/iEWA7/uoxHigHKLurFk4x51wLQ9V23oUTHoCFFwNm
 gy3YZD7UTgh1QBKzeLx8V7yDdRPCA5FnDmhx1wq29x6tAQf3+8TGhGGU22HOTqNq7t7Ku5
 MQ4nVD4RDZrV/9QfXi4aVNUHOcZmdzo=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-528-8QxKUfNEP4SBWpgli8BY4w-1; Wed, 26 Jan 2022 03:51:44 -0500
X-MC-Unique: 8QxKUfNEP4SBWpgli8BY4w-1
Received: from smtp.corp.redhat.com (int-mx01.intmail.prod.int.phx2.redhat.com
 [10.5.11.11])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 2D402100C609;
 Wed, 26 Jan 2022 08:51:43 +0000 (UTC)
Received: from warthog.procyon.org.uk (unknown [10.33.36.26])
 by smtp.corp.redhat.com (Postfix) with ESMTP id BAD2B56F6A;
 Wed, 26 Jan 2022 08:51:36 +0000 (UTC)
Organization: Red Hat UK Ltd. Registered Address: Red Hat UK Ltd, Amberley
 Place, 107-111 Peascod Street, Windsor, Berkshire, SI4 1TE, United
 Kingdom.
 Registered in England and Wales under Company Registration No. 3798903
From: David Howells <dhowells@redhat.com>
In-Reply-To: <8f88459a-97e0-8b8d-3ec9-260d482a0d38@linux.alibaba.com>
References: <8f88459a-97e0-8b8d-3ec9-260d482a0d38@linux.alibaba.com>
 <20220118131216.85338-1-jefflexu@linux.alibaba.com>
 <2815558.1643127330@warthog.procyon.org.uk>
To: JeffleXu <jefflexu@linux.alibaba.com>
Subject: Re: [PATCH v2 00/20] fscache,
 erofs: fscache-based demand-read semantics
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-ID: <100894.1643187095.1@warthog.procyon.org.uk>
Date: Wed, 26 Jan 2022 08:51:35 +0000
Message-ID: <100895.1643187095@warthog.procyon.org.uk>
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.11
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
Cc: linux-kernel@vger.kernel.org, dhowells@redhat.com,
 joseph.qi@linux.alibaba.com, linux-cachefs@redhat.com,
 linux-fsdevel@vger.kernel.org, gerry@linux.alibaba.com,
 linux-erofs@lists.ozlabs.org
Errors-To: linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org
Sender: "Linux-erofs"
 <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>

JeffleXu <jefflexu@linux.alibaba.com> wrote:

> "/path/to/file+offset"
> 		^
> 
> Besides, what does the 'offset' mean?

Assuming you're storing multiple erofs files within the same backend file, you
need to tell the the cache backend how to find the data.  Assuming the erofs
data is arranged such that each erofs file is a single contiguous region, then
you need a pathname and a file offset to find one of them.

David

