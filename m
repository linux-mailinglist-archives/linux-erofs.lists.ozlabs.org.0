Return-Path: <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>
X-Original-To: lists+linux-erofs@lfdr.de
Delivered-To: lists+linux-erofs@lfdr.de
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2404:9400:2:0:216:3eff:fee1:b9f1])
	by mail.lfdr.de (Postfix) with ESMTPS id 5036250A1E4
	for <lists+linux-erofs@lfdr.de>; Thu, 21 Apr 2022 16:14:28 +0200 (CEST)
Received: from boromir.ozlabs.org (localhost [IPv6:::1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4Kkfg617Khz3bWM
	for <lists+linux-erofs@lfdr.de>; Fri, 22 Apr 2022 00:14:26 +1000 (AEST)
Authentication-Results: lists.ozlabs.org;
	dkim=fail reason="signature verification failed" (1024-bit key; unprotected) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=aAELANe9;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=aAELANe9;
	dkim-atps=neutral
X-Original-To: linux-erofs@lists.ozlabs.org
Delivered-To: linux-erofs@lists.ozlabs.org
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized)
 smtp.mailfrom=redhat.com (client-ip=170.10.133.124;
 helo=us-smtp-delivery-124.mimecast.com; envelope-from=dhowells@redhat.com;
 receiver=<UNKNOWN>)
Authentication-Results: lists.ozlabs.org; dkim=pass (1024-bit key;
 unprotected) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256
 header.s=mimecast20190719 header.b=aAELANe9; 
 dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com
 header.a=rsa-sha256 header.s=mimecast20190719 header.b=aAELANe9; 
 dkim-atps=neutral
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.133.124])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 4Kkfg24Rh4z2yZv
 for <linux-erofs@lists.ozlabs.org>; Fri, 22 Apr 2022 00:14:22 +1000 (AEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1650550459;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=/86MtLD8Rqj34BloE8PHRzGAy2yRZrOELTQSyGdBTJM=;
 b=aAELANe9okNVOPzGfX/rItD2cYeZpUCckLsDFs3p6mKak+xBtGbmpDhJMfUI3pgwgyQ+iO
 inpNlXBYe7IQJlru3il+/jsMNIySg9TEZ7nkMSv3ulv+Thk5oMS3vXg+TSoh4cUS42+KQJ
 KIDZO5/Oq+AatBDGoA5/iS2tztt9tw0=
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1650550459;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=/86MtLD8Rqj34BloE8PHRzGAy2yRZrOELTQSyGdBTJM=;
 b=aAELANe9okNVOPzGfX/rItD2cYeZpUCckLsDFs3p6mKak+xBtGbmpDhJMfUI3pgwgyQ+iO
 inpNlXBYe7IQJlru3il+/jsMNIySg9TEZ7nkMSv3ulv+Thk5oMS3vXg+TSoh4cUS42+KQJ
 KIDZO5/Oq+AatBDGoA5/iS2tztt9tw0=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-624-PbUe-qYrPDC0JBoh3a2rrw-1; Thu, 21 Apr 2022 10:14:14 -0400
X-MC-Unique: PbUe-qYrPDC0JBoh3a2rrw-1
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.rdu2.redhat.com
 [10.11.54.5])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 00BCE86B8A3;
 Thu, 21 Apr 2022 14:14:13 +0000 (UTC)
Received: from warthog.procyon.org.uk (unknown [10.33.36.13])
 by smtp.corp.redhat.com (Postfix) with ESMTP id E7FBA53CE;
 Thu, 21 Apr 2022 14:14:06 +0000 (UTC)
Organization: Red Hat UK Ltd. Registered Address: Red Hat UK Ltd, Amberley
 Place, 107-111 Peascod Street, Windsor, Berkshire, SI4 1TE, United
 Kingdom.
 Registered in England and Wales under Company Registration No. 3798903
From: David Howells <dhowells@redhat.com>
In-Reply-To: <20220415123614.54024-6-jefflexu@linux.alibaba.com>
References: <20220415123614.54024-6-jefflexu@linux.alibaba.com>
 <20220415123614.54024-1-jefflexu@linux.alibaba.com>
To: Jeffle Xu <jefflexu@linux.alibaba.com>
Subject: Re: [PATCH v9 05/21] cachefiles: implement on-demand read
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-ID: <1445519.1650550446.1@warthog.procyon.org.uk>
Date: Thu, 21 Apr 2022 15:14:06 +0100
Message-ID: <1445520.1650550446@warthog.procyon.org.uk>
X-Scanned-By: MIMEDefang 2.79 on 10.11.54.5
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
 joseph.qi@linux.alibaba.com, zhangjiachen.jaycee@bytedance.com,
 linux-cachefs@redhat.com, gregkh@linuxfoundation.org,
 linux-fsdevel@vger.kernel.org, luodaowen.backend@bytedance.com,
 gerry@linux.alibaba.com, torvalds@linux-foundation.org
Errors-To: linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org
Sender: "Linux-erofs"
 <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>

Jeffle Xu <jefflexu@linux.alibaba.com> wrote:

> A new NETFS_SREQ_ONDEMAND flag is introduced to indicate that on-demand
> read should be done when a cache miss encountered.

That may conflict with changes I'm making - but it's just a matter of flag
renumbering.

> +#define CACHEFILES_IOC_CREAD	_IOW(0x98, 1, int)

I wonder if CACHEFILES_IOC_READ_COMPLETE would be a better name, but apart
from that:

Acked-by: David Howells <dhowells@redhat.com>

