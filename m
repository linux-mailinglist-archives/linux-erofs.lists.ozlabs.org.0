Return-Path: <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>
X-Original-To: lists+linux-erofs@lfdr.de
Delivered-To: lists+linux-erofs@lfdr.de
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2404:9400:2:0:216:3eff:fee1:b9f1])
	by mail.lfdr.de (Postfix) with ESMTPS id B26415215EA
	for <lists+linux-erofs@lfdr.de>; Tue, 10 May 2022 14:50:43 +0200 (CEST)
Received: from boromir.ozlabs.org (localhost [IPv6:::1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4KyHvj3ntpz3brp
	for <lists+linux-erofs@lfdr.de>; Tue, 10 May 2022 22:50:41 +1000 (AEST)
Authentication-Results: lists.ozlabs.org;
	dkim=fail reason="signature verification failed" (1024-bit key; unprotected) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=a2CysE55;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=a2CysE55;
	dkim-atps=neutral
X-Original-To: linux-erofs@lists.ozlabs.org
Delivered-To: linux-erofs@lists.ozlabs.org
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized)
 smtp.mailfrom=redhat.com (client-ip=170.10.133.124;
 helo=us-smtp-delivery-124.mimecast.com; envelope-from=dhowells@redhat.com;
 receiver=<UNKNOWN>)
Authentication-Results: lists.ozlabs.org; dkim=pass (1024-bit key;
 unprotected) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256
 header.s=mimecast20190719 header.b=a2CysE55; 
 dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com
 header.a=rsa-sha256 header.s=mimecast20190719 header.b=a2CysE55; 
 dkim-atps=neutral
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.133.124])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 4KyHvd64Hrz3bY3
 for <linux-erofs@lists.ozlabs.org>; Tue, 10 May 2022 22:50:35 +1000 (AEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1652187031;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=Xkxzad1cbht/jlusqrH8a1D+QFGOt7FrMJEjOw9H5po=;
 b=a2CysE55dKRB1VEipg8LRsdhJAJJT9Qd9YbOi++FXktXruVcl/1qWoXQCCLml5teDP9A5F
 XepOC62CVtUaiLSESFuDE63m1NL48xuL8H5t63n6ZdGVZw3p0ic5O1oiE9nEl9hIGhFJOB
 e4FKXiqndgVQgwovlYe+kEZ6HQXeYuo=
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1652187031;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=Xkxzad1cbht/jlusqrH8a1D+QFGOt7FrMJEjOw9H5po=;
 b=a2CysE55dKRB1VEipg8LRsdhJAJJT9Qd9YbOi++FXktXruVcl/1qWoXQCCLml5teDP9A5F
 XepOC62CVtUaiLSESFuDE63m1NL48xuL8H5t63n6ZdGVZw3p0ic5O1oiE9nEl9hIGhFJOB
 e4FKXiqndgVQgwovlYe+kEZ6HQXeYuo=
Received: from mimecast-mx02.redhat.com (mx3-rdu2.redhat.com
 [66.187.233.73]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-210-Isfs8HFjNPW5aaZjgDRhpA-1; Tue, 10 May 2022 08:50:20 -0400
X-MC-Unique: Isfs8HFjNPW5aaZjgDRhpA-1
Received: from smtp.corp.redhat.com (int-mx07.intmail.prod.int.rdu2.redhat.com
 [10.11.54.7])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 1F3C71C06910;
 Tue, 10 May 2022 12:50:19 +0000 (UTC)
Received: from warthog.procyon.org.uk (unknown [10.33.37.67])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 483D714C1D4D;
 Tue, 10 May 2022 12:50:16 +0000 (UTC)
Organization: Red Hat UK Ltd. Registered Address: Red Hat UK Ltd, Amberley
 Place, 107-111 Peascod Street, Windsor, Berkshire, SI4 1TE, United
 Kingdom.
 Registered in England and Wales under Company Registration No. 3798903
From: David Howells <dhowells@redhat.com>
In-Reply-To: <20220509074028.74954-3-jefflexu@linux.alibaba.com>
References: <20220509074028.74954-3-jefflexu@linux.alibaba.com>
 <20220509074028.74954-1-jefflexu@linux.alibaba.com>
To: Jeffle Xu <jefflexu@linux.alibaba.com>
Subject: Re: [PATCH v11 02/22] cachefiles: notify the user daemon when looking
 up cookie
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-ID: <3509080.1652187015.1@warthog.procyon.org.uk>
Date: Tue, 10 May 2022 13:50:15 +0100
Message-ID: <3509081.1652187015@warthog.procyon.org.uk>
X-Scanned-By: MIMEDefang 2.85 on 10.11.54.7
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

> Fscache/CacheFiles used to serve as a local cache for a remote
> networking fs. A new on-demand read mode will be introduced for
> CacheFiles, which can boost the scenario where on-demand read semantics
> are needed, e.g. container image distribution.
> 
> The essential difference between these two modes is seen when a cache
> miss occurs: In the original mode, the netfs will fetch the data from
> the remote server and then write it to the cache file; in on-demand
> read mode, fetching the data and writing it into the cache is delegated
> to a user daemon.
> 
> As the first step, notify the user daemon when looking up cookie. In
> this case, an anonymous fd is sent to the user daemon, through which the
> user daemon can write the fetched data to the cache file. Since the user
> daemon may move the anonymous fd around, e.g. through dup(), an object
> ID uniquely identifying the cache file is also attached.
> 
> Also add one advisory flag (FSCACHE_ADV_WANT_CACHE_SIZE) suggesting that
> the cache file size shall be retrieved at runtime. This helps the
> scenario where one cache file contains multiple netfs files, e.g. for
> the purpose of deduplication. In this case, netfs itself has no idea the
> size of the cache file, whilst the user daemon should give the hint on
> it.
> 
> Signed-off-by: Jeffle Xu <jefflexu@linux.alibaba.com>

Acked-by: David Howells <dhowells@redhat.com>

