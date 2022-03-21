Return-Path: <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>
X-Original-To: lists+linux-erofs@lfdr.de
Delivered-To: lists+linux-erofs@lfdr.de
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	by mail.lfdr.de (Postfix) with ESMTPS id CE4B24E2930
	for <lists+linux-erofs@lfdr.de>; Mon, 21 Mar 2022 15:02:02 +0100 (CET)
Received: from boromir.ozlabs.org (localhost [IPv6:::1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4KMbs45KzWz30Lq
	for <lists+linux-erofs@lfdr.de>; Tue, 22 Mar 2022 01:02:00 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org;
	dkim=fail reason="signature verification failed" (1024-bit key; unprotected) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=Qk/4atVD;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=Qk/4atVD;
	dkim-atps=neutral
X-Original-To: linux-erofs@lists.ozlabs.org
Delivered-To: linux-erofs@lists.ozlabs.org
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized)
 smtp.mailfrom=redhat.com (client-ip=170.10.133.124;
 helo=us-smtp-delivery-124.mimecast.com; envelope-from=dhowells@redhat.com;
 receiver=<UNKNOWN>)
Authentication-Results: lists.ozlabs.org; dkim=pass (1024-bit key;
 unprotected) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256
 header.s=mimecast20190719 header.b=Qk/4atVD; 
 dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com
 header.a=rsa-sha256 header.s=mimecast20190719 header.b=Qk/4atVD; 
 dkim-atps=neutral
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.133.124])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 4KMbry05b6z2yxV
 for <linux-erofs@lists.ozlabs.org>; Tue, 22 Mar 2022 01:01:53 +1100 (AEDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1647871310;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=e08TBu9LXeju0JfJXQDlbeITBDevreGVnW43wNE54QU=;
 b=Qk/4atVDg4J1uBDvKutmPvI2EqOc+0XD9Oj/3PfzAr55qleYvcHRwAEuc1IFwoRYHcnNr9
 YKETGUkLeS+doj3C8sI82lp2smb2UfSim2MZODdDV7gqm2m1WK1xEjBgEKes2V0m1ZtDWW
 nMqnbPD4ZZ8RJw5ZIxEYumUkJIN/efU=
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1647871310;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=e08TBu9LXeju0JfJXQDlbeITBDevreGVnW43wNE54QU=;
 b=Qk/4atVDg4J1uBDvKutmPvI2EqOc+0XD9Oj/3PfzAr55qleYvcHRwAEuc1IFwoRYHcnNr9
 YKETGUkLeS+doj3C8sI82lp2smb2UfSim2MZODdDV7gqm2m1WK1xEjBgEKes2V0m1ZtDWW
 nMqnbPD4ZZ8RJw5ZIxEYumUkJIN/efU=
Received: from mimecast-mx02.redhat.com (mx3-rdu2.redhat.com
 [66.187.233.73]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-470-H3oEy_SQPG2zWEEw1fs1Sw-1; Mon, 21 Mar 2022 10:01:46 -0400
X-MC-Unique: H3oEy_SQPG2zWEEw1fs1Sw-1
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.rdu2.redhat.com
 [10.11.54.6])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 6CCF028035F1;
 Mon, 21 Mar 2022 14:01:45 +0000 (UTC)
Received: from warthog.procyon.org.uk (unknown [10.33.36.19])
 by smtp.corp.redhat.com (Postfix) with ESMTP id E5DB92166B2D;
 Mon, 21 Mar 2022 14:01:34 +0000 (UTC)
Organization: Red Hat UK Ltd. Registered Address: Red Hat UK Ltd, Amberley
 Place, 107-111 Peascod Street, Windsor, Berkshire, SI4 1TE, United
 Kingdom.
 Registered in England and Wales under Company Registration No. 3798903
From: David Howells <dhowells@redhat.com>
In-Reply-To: <20220316131723.111553-5-jefflexu@linux.alibaba.com>
References: <20220316131723.111553-5-jefflexu@linux.alibaba.com>
 <20220316131723.111553-1-jefflexu@linux.alibaba.com>
To: Jeffle Xu <jefflexu@linux.alibaba.com>
Subject: Re: [PATCH v5 04/22] cachefiles: notify user daemon with anon_fd when
 looking up cookie
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-ID: <1029247.1647871294.1@warthog.procyon.org.uk>
Content-Transfer-Encoding: quoted-printable
Date: Mon, 21 Mar 2022 14:01:34 +0000
Message-ID: <1029248.1647871294@warthog.procyon.org.uk>
X-Scanned-By: MIMEDefang 2.78 on 10.11.54.6
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
Cc: linux-erofs@lists.ozlabs.org, willy@infradead.org,
 linux-kernel@vger.kernel.org, dhowells@redhat.com, joseph.qi@linux.alibaba.com,
 linux-cachefs@redhat.com, gregkh@linuxfoundation.org,
 linux-fsdevel@vger.kernel.org, luodaowen.backend@bytedance.com,
 gerry@linux.alibaba.com, torvalds@linux-foundation.org
Errors-To: linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org
Sender: "Linux-erofs"
 <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>

Jeffle Xu <jefflexu@linux.alibaba.com> wrote:

> +	read_lock(&cache->reqs_lock);
> +
> +	/* recheck dead state under lock */
> +	if (test_bit(CACHEFILES_DEAD, &cache->flags)) {
> +		read_unlock(&cache->reqs_lock);
> +		ret =3D -EIO;
> +		goto out;
> +	}
> +
> +	xa_lock(xa);
> +	ret =3D __xa_alloc(xa, &id, req, xa_limit_32b, GFP_KERNEL);

You're holding a spinlock.  You can't use GFP_KERNEL.

> +static int cachefiles_ondemand_cinit(struct cachefiles_cache *cache, ch=
ar *args)
> +{
> ...
> +	tmp =3D kstrdup(args, GFP_KERNEL);

No need to copy the string.  The caller already did that and added a NUL f=
or
good measure.

I would probably move most of the functions added in this patch to
fs/cachefiles/ondemand.c.

David

