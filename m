Return-Path: <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>
X-Original-To: lists+linux-erofs@lfdr.de
Delivered-To: lists+linux-erofs@lfdr.de
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	by mail.lfdr.de (Postfix) with ESMTPS id A7C92521600
	for <lists+linux-erofs@lfdr.de>; Tue, 10 May 2022 14:53:40 +0200 (CEST)
Received: from boromir.ozlabs.org (localhost [IPv6:::1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4KyHz64JwQz3bs4
	for <lists+linux-erofs@lfdr.de>; Tue, 10 May 2022 22:53:38 +1000 (AEST)
Authentication-Results: lists.ozlabs.org;
	dkim=fail reason="signature verification failed" (1024-bit key; unprotected) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=AptiJBMq;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=AptiJBMq;
	dkim-atps=neutral
X-Original-To: linux-erofs@lists.ozlabs.org
Delivered-To: linux-erofs@lists.ozlabs.org
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized)
 smtp.mailfrom=redhat.com (client-ip=170.10.133.124;
 helo=us-smtp-delivery-124.mimecast.com; envelope-from=dhowells@redhat.com;
 receiver=<UNKNOWN>)
Authentication-Results: lists.ozlabs.org; dkim=pass (1024-bit key;
 unprotected) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256
 header.s=mimecast20190719 header.b=AptiJBMq; 
 dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com
 header.a=rsa-sha256 header.s=mimecast20190719 header.b=AptiJBMq; 
 dkim-atps=neutral
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.133.124])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 4KyHz41Lhyz2xrf
 for <linux-erofs@lists.ozlabs.org>; Tue, 10 May 2022 22:53:35 +1000 (AEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1652187213;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=lbzQNHvRgmAKJHhChSsDKGEqh0+N/1gADq6UqyTU0po=;
 b=AptiJBMqS8GyUnFuzvJLQMDpo4tLoXB7QaNfg7Z4f7WY+Kz5hxdJzY/uqIbp3j73EW8yln
 YAyAhhgPALJ/cxU8aaywSt+c6PBu/Ji2dgUAnqRVg4OG0HIgxMZEomtPhtYKDn9h9WnkCd
 ePYW3bPdSFL11UyG7lyVXGmlP60ZalU=
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1652187213;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=lbzQNHvRgmAKJHhChSsDKGEqh0+N/1gADq6UqyTU0po=;
 b=AptiJBMqS8GyUnFuzvJLQMDpo4tLoXB7QaNfg7Z4f7WY+Kz5hxdJzY/uqIbp3j73EW8yln
 YAyAhhgPALJ/cxU8aaywSt+c6PBu/Ji2dgUAnqRVg4OG0HIgxMZEomtPhtYKDn9h9WnkCd
 ePYW3bPdSFL11UyG7lyVXGmlP60ZalU=
Received: from mimecast-mx02.redhat.com (mx3-rdu2.redhat.com
 [66.187.233.73]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-120-UjOvT2dzP5K19VuLQAl7qQ-1; Tue, 10 May 2022 08:53:29 -0400
X-MC-Unique: UjOvT2dzP5K19VuLQAl7qQ-1
Received: from smtp.corp.redhat.com (int-mx01.intmail.prod.int.rdu2.redhat.com
 [10.11.54.1])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 1E2431C08979;
 Tue, 10 May 2022 12:53:22 +0000 (UTC)
Received: from warthog.procyon.org.uk (unknown [10.33.37.67])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 73CDB40CFD74;
 Tue, 10 May 2022 12:53:19 +0000 (UTC)
Organization: Red Hat UK Ltd. Registered Address: Red Hat UK Ltd, Amberley
 Place, 107-111 Peascod Street, Windsor, Berkshire, SI4 1TE, United
 Kingdom.
 Registered in England and Wales under Company Registration No. 3798903
From: David Howells <dhowells@redhat.com>
In-Reply-To: <20220509074028.74954-4-jefflexu@linux.alibaba.com>
References: <20220509074028.74954-4-jefflexu@linux.alibaba.com>
 <20220509074028.74954-1-jefflexu@linux.alibaba.com>
To: Jeffle Xu <jefflexu@linux.alibaba.com>
Subject: Re: [PATCH v11 03/22] cachefiles: unbind cachefiles gracefully in
 on-demand mode
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-ID: <3509260.1652187198.1@warthog.procyon.org.uk>
Date: Tue, 10 May 2022 13:53:18 +0100
Message-ID: <3509261.1652187198@warthog.procyon.org.uk>
X-Scanned-By: MIMEDefang 2.84 on 10.11.54.1
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
Cc: tianzichen@kuaishou.com, linux-erofs@lists.ozlabs.org, willy@infradead.org,
 linux-kernel@vger.kernel.org, dhowells@redhat.com, joseph.qi@linux.alibaba.com,
 zhangjiachen.jaycee@bytedance.com, linux-cachefs@redhat.com,
 gregkh@linuxfoundation.org, linux-fsdevel@vger.kernel.org,
 luodaowen.backend@bytedance.com, gerry@linux.alibaba.com,
 torvalds@linux-foundation.org, yinxin.x@bytedance.com
Errors-To: linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org
Sender: "Linux-erofs"
 <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>

Jeffle Xu <jefflexu@linux.alibaba.com> wrote:

> Add a refcount to avoid the deadlock in on-demand read mode. The
> on-demand read mode will pin the corresponding cachefiles object for
> each anonymous fd. The cachefiles object is unpinned when the anonymous
> fd gets closed. When the user daemon exits and the fd of
> "/dev/cachefiles" device node gets closed, it will wait for all
> cahcefiles objects getting withdrawn. Then if there's any anonymous fd
> getting closed after the fd of the device node, the user daemon will
> hang forever, waiting for all objects getting withdrawn.
> 
> To fix this, add a refcount indicating if there's any object pinned by
> anonymous fds. The cachefiles cache gets unbound and withdrawn when the
> refcount is decreased to 0. It won't change the behaviour of the
> original mode, in which case the cachefiles cache gets unbound and
> withdrawn as long as the fd of the device node gets closed.
> 
> Signed-off-by: Jeffle Xu <jefflexu@linux.alibaba.com>

Acked-by: David Howells <dhowells@redhat.com>

