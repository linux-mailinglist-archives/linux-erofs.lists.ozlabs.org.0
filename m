Return-Path: <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>
X-Original-To: lists+linux-erofs@lfdr.de
Delivered-To: lists+linux-erofs@lfdr.de
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2404:9400:2:0:216:3eff:fee1:b9f1])
	by mail.lfdr.de (Postfix) with ESMTPS id CEB184FBD7F
	for <lists+linux-erofs@lfdr.de>; Mon, 11 Apr 2022 15:42:50 +0200 (CEST)
Received: from boromir.ozlabs.org (localhost [IPv6:::1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4KcVRD4sQxz2ynj
	for <lists+linux-erofs@lfdr.de>; Mon, 11 Apr 2022 23:42:48 +1000 (AEST)
Authentication-Results: lists.ozlabs.org;
	dkim=fail reason="signature verification failed" (1024-bit key; unprotected) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=hO6FCDJj;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=hO6FCDJj;
	dkim-atps=neutral
X-Original-To: linux-erofs@lists.ozlabs.org
Delivered-To: linux-erofs@lists.ozlabs.org
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized)
 smtp.mailfrom=redhat.com (client-ip=170.10.133.124;
 helo=us-smtp-delivery-124.mimecast.com; envelope-from=dhowells@redhat.com;
 receiver=<UNKNOWN>)
Authentication-Results: lists.ozlabs.org; dkim=pass (1024-bit key;
 unprotected) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256
 header.s=mimecast20190719 header.b=hO6FCDJj; 
 dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com
 header.a=rsa-sha256 header.s=mimecast20190719 header.b=hO6FCDJj; 
 dkim-atps=neutral
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.133.124])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 4KcVR94R79z2yLJ
 for <linux-erofs@lists.ozlabs.org>; Mon, 11 Apr 2022 23:42:45 +1000 (AEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1649684563;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=SeAW1i7bP5vwPIJRU4t8M7oOEg6okFb42IgET/Pn4rE=;
 b=hO6FCDJjZl8ZJ/bjj9J0c6ROlrD9YudLtBNMNTyIDmbZRS1KO7EaeyJhPCY5qLvH+PQY4S
 8EwvuBEWmyDEsvYPsd1GsXHfjWJRcIg2BsixezbnhCFRd4uuxXlu+BQKxGD84Ze/yy2wKo
 WYoz+gsfXofZ17ctJFMlgwWgH5tjqAs=
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1649684563;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=SeAW1i7bP5vwPIJRU4t8M7oOEg6okFb42IgET/Pn4rE=;
 b=hO6FCDJjZl8ZJ/bjj9J0c6ROlrD9YudLtBNMNTyIDmbZRS1KO7EaeyJhPCY5qLvH+PQY4S
 8EwvuBEWmyDEsvYPsd1GsXHfjWJRcIg2BsixezbnhCFRd4uuxXlu+BQKxGD84Ze/yy2wKo
 WYoz+gsfXofZ17ctJFMlgwWgH5tjqAs=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-576-1qS3aKYwOQyo5eXJq_KINw-1; Mon, 11 Apr 2022 09:42:38 -0400
X-MC-Unique: 1qS3aKYwOQyo5eXJq_KINw-1
Received: from smtp.corp.redhat.com (int-mx09.intmail.prod.int.rdu2.redhat.com
 [10.11.54.9])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 16249811E78;
 Mon, 11 Apr 2022 13:42:37 +0000 (UTC)
Received: from warthog.procyon.org.uk (unknown [10.33.37.45])
 by smtp.corp.redhat.com (Postfix) with ESMTP id C3071492D42;
 Mon, 11 Apr 2022 13:42:34 +0000 (UTC)
Organization: Red Hat UK Ltd. Registered Address: Red Hat UK Ltd, Amberley
 Place, 107-111 Peascod Street, Windsor, Berkshire, SI4 1TE, United
 Kingdom.
 Registered in England and Wales under Company Registration No. 3798903
From: David Howells <dhowells@redhat.com>
In-Reply-To: <542f749c-b0f1-1de6-cb41-26e296afb2df@linux.alibaba.com>
References: <542f749c-b0f1-1de6-cb41-26e296afb2df@linux.alibaba.com>
 <20220406075612.60298-5-jefflexu@linux.alibaba.com>
 <20220406075612.60298-1-jefflexu@linux.alibaba.com>
 <1091405.1649680508@warthog.procyon.org.uk>
To: JeffleXu <jefflexu@linux.alibaba.com>
Subject: Re: [PATCH v8 04/20] cachefiles: notify user daemon when withdrawing
 cookie
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-ID: <1094492.1649684554.1@warthog.procyon.org.uk>
Date: Mon, 11 Apr 2022 14:42:34 +0100
Message-ID: <1094493.1649684554@warthog.procyon.org.uk>
X-Scanned-By: MIMEDefang 2.85 on 10.11.54.9
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
Cc: tianzichen@kuaishou.com, linux-erofs@lists.ozlabs.org, fannaihao@baidu.com,
 willy@infradead.org, linux-kernel@vger.kernel.org, dhowells@redhat.com,
 joseph.qi@linux.alibaba.com, linux-cachefs@redhat.com,
 gregkh@linuxfoundation.org, linux-fsdevel@vger.kernel.org,
 luodaowen.backend@bytedance.com, gerry@linux.alibaba.com,
 torvalds@linux-foundation.org
Errors-To: linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org
Sender: "Linux-erofs"
 <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>

JeffleXu <jefflexu@linux.alibaba.com> wrote:

> > 
> >> +	if (fd == 0)
> >> +		return -ENOENT;
> > 
> > 0 is a valid fd.
> 
> Yeah, but IMHO fd 0 is always for stdin? I think the allocated anon_fd
> won't install at fd 0. Please correct me if I'm wrong.

If someone has closed 0, then you'll get 0 next, I'm pretty sure.  Try it and
see.

> In fact I wanna use "fd == 0" as the initial state as struct
> cachefiles_object is allocated with kmem_cache_zalloc().

I would suggest presetting it to something like -2 to avoid confusion.

David

