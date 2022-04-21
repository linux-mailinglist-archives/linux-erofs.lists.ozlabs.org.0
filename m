Return-Path: <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>
X-Original-To: lists+linux-erofs@lfdr.de
Delivered-To: lists+linux-erofs@lfdr.de
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2404:9400:2:0:216:3eff:fee1:b9f1])
	by mail.lfdr.de (Postfix) with ESMTPS id 2565850A0C3
	for <lists+linux-erofs@lfdr.de>; Thu, 21 Apr 2022 15:25:07 +0200 (CEST)
Received: from boromir.ozlabs.org (localhost [IPv6:::1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4KkdZ86wf9z3bVd
	for <lists+linux-erofs@lfdr.de>; Thu, 21 Apr 2022 23:25:04 +1000 (AEST)
Authentication-Results: lists.ozlabs.org;
	dkim=fail reason="signature verification failed" (1024-bit key; unprotected) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=RTDDnpOZ;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=ZkfxcvEO;
	dkim-atps=neutral
X-Original-To: linux-erofs@lists.ozlabs.org
Delivered-To: linux-erofs@lists.ozlabs.org
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized)
 smtp.mailfrom=redhat.com (client-ip=170.10.129.124;
 helo=us-smtp-delivery-124.mimecast.com; envelope-from=dhowells@redhat.com;
 receiver=<UNKNOWN>)
Authentication-Results: lists.ozlabs.org; dkim=pass (1024-bit key;
 unprotected) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256
 header.s=mimecast20190719 header.b=RTDDnpOZ; 
 dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com
 header.a=rsa-sha256 header.s=mimecast20190719 header.b=ZkfxcvEO; 
 dkim-atps=neutral
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.129.124])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 4KkdZ02MXyz2xrc
 for <linux-erofs@lists.ozlabs.org>; Thu, 21 Apr 2022 23:24:54 +1000 (AEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1650547490;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=y22ZubXxLrbUim9/2nYp/1QkaF1qr8akqy+ZFhTpdnw=;
 b=RTDDnpOZZmdxvuKfAYejWYjqKN8TzGgyeRXV4jRIIRqD8gh4sJ7G0G02/Ek7usyiX587SL
 j4XUBxdMbGH3hlyTCledC1KfXYVnqgPf7P8sd0jkQX9riXTQBMoCUJqHQ5u97/VjEGQuBQ
 2P7acrdJyMSmr0f0eQWfFevfmoauCMk=
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1650547491;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=y22ZubXxLrbUim9/2nYp/1QkaF1qr8akqy+ZFhTpdnw=;
 b=ZkfxcvEOHh88JeE6EzPgHcH65K+v4lDXdtRFleU1SDx8ZJfj83SndVIJZuZ1W1j+fnk5cq
 b/9WqYSJgRYfRRafeQp/2zUdB4dTom4+b+xiMAX7gPYAveSvuerCKTaUzYCRuAsgYTBSlX
 aT/M87y+S/sLikzHN4t2ibQOFC62A5w=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-367-8hwKYX1aP-e_r0Kn_RdK6A-1; Thu, 21 Apr 2022 09:24:47 -0400
X-MC-Unique: 8hwKYX1aP-e_r0Kn_RdK6A-1
Received: from smtp.corp.redhat.com (int-mx08.intmail.prod.int.rdu2.redhat.com
 [10.11.54.8])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 68A6A802803;
 Thu, 21 Apr 2022 13:24:46 +0000 (UTC)
Received: from warthog.procyon.org.uk (unknown [10.33.36.13])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 77EA9C53B80;
 Thu, 21 Apr 2022 13:24:43 +0000 (UTC)
Organization: Red Hat UK Ltd. Registered Address: Red Hat UK Ltd, Amberley
 Place, 107-111 Peascod Street, Windsor, Berkshire, SI4 1TE, United
 Kingdom.
 Registered in England and Wales under Company Registration No. 3798903
From: David Howells <dhowells@redhat.com>
In-Reply-To: <20220415123614.54024-2-jefflexu@linux.alibaba.com>
References: <20220415123614.54024-2-jefflexu@linux.alibaba.com>
 <20220415123614.54024-1-jefflexu@linux.alibaba.com>
To: Jeffle Xu <jefflexu@linux.alibaba.com>
Subject: Re: [PATCH v9 01/21] cachefiles: extract write routine
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-ID: <1393748.1650547482.1@warthog.procyon.org.uk>
Date: Thu, 21 Apr 2022 14:24:42 +0100
Message-ID: <1393749.1650547482@warthog.procyon.org.uk>
X-Scanned-By: MIMEDefang 2.85 on 10.11.54.8
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

> Extract the generic routine of writing data to cache files, and make it
> generally available.
> 
> This will be used by the following patch implementing on-demand read
> mode. Since it's called inside cachefiles module in this case, make the
> interface generic and unrelated to netfs_cache_resources.
> 
> It is worth noting that, ki->inval_counter is not initialized after
> this cleanup. It shall not make any visible difference, since
> inval_counter is no longer used in the write completion routine, i.e.
> cachefiles_write_complete().
> 
> Signed-off-by: Jeffle Xu <jefflexu@linux.alibaba.com>

Acked-by: David Howells <dhowells@redhat.com>

