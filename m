Return-Path: <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>
X-Original-To: lists+linux-erofs@lfdr.de
Delivered-To: lists+linux-erofs@lfdr.de
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2404:9400:2:0:216:3eff:fee1:b9f1])
	by mail.lfdr.de (Postfix) with ESMTPS id 4A00850A1FA
	for <lists+linux-erofs@lfdr.de>; Thu, 21 Apr 2022 16:18:38 +0200 (CEST)
Received: from boromir.ozlabs.org (localhost [IPv6:::1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4Kkflw0rgBz3bWM
	for <lists+linux-erofs@lfdr.de>; Fri, 22 Apr 2022 00:18:36 +1000 (AEST)
Authentication-Results: lists.ozlabs.org;
	dkim=fail reason="signature verification failed" (1024-bit key; unprotected) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=SFlPI4zv;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=SFlPI4zv;
	dkim-atps=neutral
X-Original-To: linux-erofs@lists.ozlabs.org
Delivered-To: linux-erofs@lists.ozlabs.org
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized)
 smtp.mailfrom=redhat.com (client-ip=170.10.133.124;
 helo=us-smtp-delivery-124.mimecast.com; envelope-from=dhowells@redhat.com;
 receiver=<UNKNOWN>)
Authentication-Results: lists.ozlabs.org; dkim=pass (1024-bit key;
 unprotected) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256
 header.s=mimecast20190719 header.b=SFlPI4zv; 
 dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com
 header.a=rsa-sha256 header.s=mimecast20190719 header.b=SFlPI4zv; 
 dkim-atps=neutral
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.133.124])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 4Kkflr4Snrz2yZv
 for <linux-erofs@lists.ozlabs.org>; Fri, 22 Apr 2022 00:18:31 +1000 (AEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1650550709;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=coOw4RfXiLNZzQ3xqdVQ85pRpofvZXMbbKbFNiXv7eM=;
 b=SFlPI4zvHDrcC5sLsyZAf9cTwmc6Oj530wc6a8M0vcoziUp3r9V1cdPo/MKLo6sOo0+KqW
 LH92lWfnR1i/pRMVZcP+BfEsJSpXN5MAaixWfg6ieaMP5ISnbOtmmttRLqCf1W373k5dC1
 9VKMgmKSge9BlA/IQ6eUxoY5CSKcZ4w=
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1650550709;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=coOw4RfXiLNZzQ3xqdVQ85pRpofvZXMbbKbFNiXv7eM=;
 b=SFlPI4zvHDrcC5sLsyZAf9cTwmc6Oj530wc6a8M0vcoziUp3r9V1cdPo/MKLo6sOo0+KqW
 LH92lWfnR1i/pRMVZcP+BfEsJSpXN5MAaixWfg6ieaMP5ISnbOtmmttRLqCf1W373k5dC1
 9VKMgmKSge9BlA/IQ6eUxoY5CSKcZ4w=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-298-gRSGhd4YNJGFrIMlixXwVQ-1; Thu, 21 Apr 2022 10:18:23 -0400
X-MC-Unique: gRSGhd4YNJGFrIMlixXwVQ-1
Received: from smtp.corp.redhat.com (int-mx01.intmail.prod.int.rdu2.redhat.com
 [10.11.54.1])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 5BA6B18019EF;
 Thu, 21 Apr 2022 14:17:42 +0000 (UTC)
Received: from warthog.procyon.org.uk (unknown [10.33.36.13])
 by smtp.corp.redhat.com (Postfix) with ESMTP id DEAF240CFD22;
 Thu, 21 Apr 2022 14:17:39 +0000 (UTC)
Organization: Red Hat UK Ltd. Registered Address: Red Hat UK Ltd, Amberley
 Place, 107-111 Peascod Street, Windsor, Berkshire, SI4 1TE, United
 Kingdom.
 Registered in England and Wales under Company Registration No. 3798903
From: David Howells <dhowells@redhat.com>
In-Reply-To: <20220415123614.54024-7-jefflexu@linux.alibaba.com>
References: <20220415123614.54024-7-jefflexu@linux.alibaba.com>
 <20220415123614.54024-1-jefflexu@linux.alibaba.com>
To: Jeffle Xu <jefflexu@linux.alibaba.com>
Subject: Re: [PATCH v9 06/21] cachefiles: enable on-demand read mode
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-ID: <1445690.1650550659.1@warthog.procyon.org.uk>
Content-Transfer-Encoding: quoted-printable
Date: Thu, 21 Apr 2022 15:17:39 +0100
Message-ID: <1445691.1650550659@warthog.procyon.org.uk>
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

> +	if (IS_ENABLED(CONFIG_CACHEFILES_ONDEMAND) &&
> +	    !strcmp(args, "ondemand")) {
> +		set_bit(CACHEFILES_ONDEMAND_MODE, &cache->flags);
> +	} else if (*args) {
> +		pr_err("'bind' command doesn't take an argument\n");

The error message isn't true if CONFIG_CACHEFILES_ONDEMAND=3Dy.  It would =
be
better to say "Invalid argument to the 'bind' command".

> -retry:
>  	/* If the caller asked us to seek for data before doing the read, then
>  	 * we should do that now.  If we find a gap, we fill it with zeros.
>  	 */
> @@ -120,16 +119,6 @@ static int cachefiles_read(struct netfs_cache_resou=
rces *cres,
>  			if (read_hole =3D=3D NETFS_READ_HOLE_FAIL)
>  				goto presubmission_error;
>  =

> -			if (read_hole =3D=3D NETFS_READ_HOLE_ONDEMAND) {
> -				ret =3D cachefiles_ondemand_read(object, off, len);
> -				if (ret)
> -					goto presubmission_error;
> -
> -				/* fail the read if no progress achieved */
> -				read_hole =3D NETFS_READ_HOLE_FAIL;
> -				goto retry;
> -			}
> -

Unexplained deletion of newly added code.

David

