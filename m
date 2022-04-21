Return-Path: <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>
X-Original-To: lists+linux-erofs@lfdr.de
Delivered-To: lists+linux-erofs@lfdr.de
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2404:9400:2:0:216:3eff:fee1:b9f1])
	by mail.lfdr.de (Postfix) with ESMTPS id 3517C50A799
	for <lists+linux-erofs@lfdr.de>; Thu, 21 Apr 2022 19:58:15 +0200 (CEST)
Received: from boromir.ozlabs.org (localhost [IPv6:::1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4KkldK0Ppwz3bXG
	for <lists+linux-erofs@lfdr.de>; Fri, 22 Apr 2022 03:58:13 +1000 (AEST)
Authentication-Results: lists.ozlabs.org;
	dkim=fail reason="signature verification failed" (1024-bit key; unprotected) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=XlSLIHAz;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=XlSLIHAz;
	dkim-atps=neutral
X-Original-To: linux-erofs@lists.ozlabs.org
Delivered-To: linux-erofs@lists.ozlabs.org
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized)
 smtp.mailfrom=redhat.com (client-ip=170.10.129.124;
 helo=us-smtp-delivery-124.mimecast.com; envelope-from=dhowells@redhat.com;
 receiver=<UNKNOWN>)
Authentication-Results: lists.ozlabs.org; dkim=pass (1024-bit key;
 unprotected) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256
 header.s=mimecast20190719 header.b=XlSLIHAz; 
 dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com
 header.a=rsa-sha256 header.s=mimecast20190719 header.b=XlSLIHAz; 
 dkim-atps=neutral
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.129.124])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 4KkldB0My9z2yPj
 for <linux-erofs@lists.ozlabs.org>; Fri, 22 Apr 2022 03:58:03 +1000 (AEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1650563878;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=a4va1/Lq36cMvwBfvf9W3jL50NhUZUHTTW2j9bp+3cE=;
 b=XlSLIHAzURxgKyO5KX18W9FOi2A1//CBRdJ6r0zcLE2yAuC50XFwH5KPIaQW3eQoTCTkPO
 qvTUNB5vxdw83egOezo4Uo1Sb+nX7MfD3up2oLLXw+PxfVyAh1MnWsYon2OdQG9bpG/2ZH
 fv8xd69iIkMilNVEvsP8fHFUWU6qraQ=
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1650563878;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=a4va1/Lq36cMvwBfvf9W3jL50NhUZUHTTW2j9bp+3cE=;
 b=XlSLIHAzURxgKyO5KX18W9FOi2A1//CBRdJ6r0zcLE2yAuC50XFwH5KPIaQW3eQoTCTkPO
 qvTUNB5vxdw83egOezo4Uo1Sb+nX7MfD3up2oLLXw+PxfVyAh1MnWsYon2OdQG9bpG/2ZH
 fv8xd69iIkMilNVEvsP8fHFUWU6qraQ=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-1-ryYKA82UMta93HSRiWfXaQ-1; Thu, 21 Apr 2022 13:57:51 -0400
X-MC-Unique: ryYKA82UMta93HSRiWfXaQ-1
Received: from smtp.corp.redhat.com (int-mx01.intmail.prod.int.rdu2.redhat.com
 [10.11.54.1])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 1198F1014A64;
 Thu, 21 Apr 2022 17:57:51 +0000 (UTC)
Received: from warthog.procyon.org.uk (unknown [10.33.36.13])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 9088240CFD22;
 Thu, 21 Apr 2022 17:57:43 +0000 (UTC)
Organization: Red Hat UK Ltd. Registered Address: Red Hat UK Ltd, Amberley
 Place, 107-111 Peascod Street, Windsor, Berkshire, SI4 1TE, United
 Kingdom.
 Registered in England and Wales under Company Registration No. 3798903
From: David Howells <dhowells@redhat.com>
In-Reply-To: <2067a5c7-4e24-f449-4676-811d12e9ab72@linux.alibaba.com>
References: <2067a5c7-4e24-f449-4676-811d12e9ab72@linux.alibaba.com>
 <20220415123614.54024-3-jefflexu@linux.alibaba.com>
 <20220415123614.54024-1-jefflexu@linux.alibaba.com>
 <1447543.1650552898@warthog.procyon.org.uk>
To: JeffleXu <jefflexu@linux.alibaba.com>
Subject: Re: EMFILE/ENFILE mitigation needed in erofs?
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-ID: <1484180.1650563860.1@warthog.procyon.org.uk>
Date: Thu, 21 Apr 2022 18:57:40 +0100
Message-ID: <1484181.1650563860@warthog.procyon.org.uk>
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

JeffleXu <jefflexu@linux.alibaba.com> wrote:

> 2. Our user daemon will configure rlimit-nofile to a reasonably large
> (e.g. 1 million) value, so that it won't fail when trying to allocate fds.

There's a system-wide limit also; simply increasing the rlimit won't override
that.

David

