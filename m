Return-Path: <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>
X-Original-To: lists+linux-erofs@lfdr.de
Delivered-To: lists+linux-erofs@lfdr.de
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	by mail.lfdr.de (Postfix) with ESMTPS id 3228D50A172
	for <lists+linux-erofs@lfdr.de>; Thu, 21 Apr 2022 16:02:41 +0200 (CEST)
Received: from boromir.ozlabs.org (localhost [IPv6:::1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4KkfPW0Z4Sz3bWR
	for <lists+linux-erofs@lfdr.de>; Fri, 22 Apr 2022 00:02:39 +1000 (AEST)
Authentication-Results: lists.ozlabs.org;
	dkim=fail reason="signature verification failed" (1024-bit key; unprotected) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=E2zS7H+J;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=E2zS7H+J;
	dkim-atps=neutral
X-Original-To: linux-erofs@lists.ozlabs.org
Delivered-To: linux-erofs@lists.ozlabs.org
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized)
 smtp.mailfrom=redhat.com (client-ip=170.10.133.124;
 helo=us-smtp-delivery-124.mimecast.com; envelope-from=dhowells@redhat.com;
 receiver=<UNKNOWN>)
Authentication-Results: lists.ozlabs.org; dkim=pass (1024-bit key;
 unprotected) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256
 header.s=mimecast20190719 header.b=E2zS7H+J; 
 dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com
 header.a=rsa-sha256 header.s=mimecast20190719 header.b=E2zS7H+J; 
 dkim-atps=neutral
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.133.124])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 4KkfPN70Ppz2ync
 for <linux-erofs@lists.ozlabs.org>; Fri, 22 Apr 2022 00:02:32 +1000 (AEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1650549747;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=aPltoNX3v1MHdmgBq0oIkCAldNZyXJBcZt6C3pWO+9Q=;
 b=E2zS7H+JhsKybFp0mgAr521a4w9VtJrpr3CXTfcNtU5s2WtPMuXcsywna/W69lglv7ieDi
 nFPaaRIktzALXfpEFTSBwHFllOSN1u73x1qZkHl91nKhJEf75qw9fodVhpwZ0L0sKp6dEK
 jLVOF7NoFcTzmLSdjYCwLG7MVYVHBPo=
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1650549747;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=aPltoNX3v1MHdmgBq0oIkCAldNZyXJBcZt6C3pWO+9Q=;
 b=E2zS7H+JhsKybFp0mgAr521a4w9VtJrpr3CXTfcNtU5s2WtPMuXcsywna/W69lglv7ieDi
 nFPaaRIktzALXfpEFTSBwHFllOSN1u73x1qZkHl91nKhJEf75qw9fodVhpwZ0L0sKp6dEK
 jLVOF7NoFcTzmLSdjYCwLG7MVYVHBPo=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-318-VGILzSB1Pqmxx7WgsHszIg-1; Thu, 21 Apr 2022 10:02:24 -0400
X-MC-Unique: VGILzSB1Pqmxx7WgsHszIg-1
Received: from smtp.corp.redhat.com (int-mx01.intmail.prod.int.rdu2.redhat.com
 [10.11.54.1])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 0503F811E76;
 Thu, 21 Apr 2022 14:02:22 +0000 (UTC)
Received: from warthog.procyon.org.uk (unknown [10.33.36.13])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 8B44340CFD22;
 Thu, 21 Apr 2022 14:02:19 +0000 (UTC)
Organization: Red Hat UK Ltd. Registered Address: Red Hat UK Ltd, Amberley
 Place, 107-111 Peascod Street, Windsor, Berkshire, SI4 1TE, United
 Kingdom.
 Registered in England and Wales under Company Registration No. 3798903
From: David Howells <dhowells@redhat.com>
In-Reply-To: <20220415123614.54024-4-jefflexu@linux.alibaba.com>
References: <20220415123614.54024-4-jefflexu@linux.alibaba.com>
 <20220415123614.54024-1-jefflexu@linux.alibaba.com>
To: Jeffle Xu <jefflexu@linux.alibaba.com>
Subject: Re: [PATCH v9 03/21] cachefiles: unbind cachefiles gracefully in
 on-demand mode
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-ID: <1444915.1650549738.1@warthog.procyon.org.uk>
Date: Thu, 21 Apr 2022 15:02:18 +0100
Message-ID: <1444916.1650549738@warthog.procyon.org.uk>
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

> +	struct kref			unbind_pincount;/* refcount to do daemon unbind */

Please use refcount_t or atomic_t, especially as this isn't the refcount for
the structure.

> -	cachefiles_daemon_unbind(cache);
> -
>  	/* clean up the control file interface */
>  	cache->cachefilesd = NULL;
>  	file->private_data = NULL;
>  	cachefiles_open = 0;

Please call cachefiles_daemon_unbind() before the cleanup.

David

