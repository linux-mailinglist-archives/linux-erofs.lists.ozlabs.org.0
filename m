Return-Path: <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>
X-Original-To: lists+linux-erofs@lfdr.de
Delivered-To: lists+linux-erofs@lfdr.de
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	by mail.lfdr.de (Postfix) with ESMTPS id 8AAB24E27AA
	for <lists+linux-erofs@lfdr.de>; Mon, 21 Mar 2022 14:35:15 +0100 (CET)
Received: from boromir.ozlabs.org (localhost [IPv6:::1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4KMbG92YBXz30Kj
	for <lists+linux-erofs@lfdr.de>; Tue, 22 Mar 2022 00:35:13 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org;
	dkim=fail reason="signature verification failed" (1024-bit key; unprotected) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=BHV2csE3;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=BHV2csE3;
	dkim-atps=neutral
X-Original-To: linux-erofs@lists.ozlabs.org
Delivered-To: linux-erofs@lists.ozlabs.org
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized)
 smtp.mailfrom=redhat.com (client-ip=170.10.133.124;
 helo=us-smtp-delivery-124.mimecast.com; envelope-from=dhowells@redhat.com;
 receiver=<UNKNOWN>)
Authentication-Results: lists.ozlabs.org; dkim=pass (1024-bit key;
 unprotected) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256
 header.s=mimecast20190719 header.b=BHV2csE3; 
 dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com
 header.a=rsa-sha256 header.s=mimecast20190719 header.b=BHV2csE3; 
 dkim-atps=neutral
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.133.124])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 4KMbG219W3z2yy3
 for <linux-erofs@lists.ozlabs.org>; Tue, 22 Mar 2022 00:35:03 +1100 (AEDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1647869698;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=2ru2iq/ox5s0Rm8wfLoTnDRL9rVImEm3d4wp9HAg3/0=;
 b=BHV2csE3vDsxllnArDZGU3CneRBHlR4u3MLDVBCuFVA7Tlq81yXAZK0E9gBMwzLqgxfPMq
 zdXj21daL790nFIUA9p0WndxbjwQgJqBq+rfiu2SWUrJzs/1O2TJQGigp2Jj+3rUahVXtc
 U0oOfV1Ppo7ysuvYIqZvGiBy3KBc4Yk=
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1647869698;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=2ru2iq/ox5s0Rm8wfLoTnDRL9rVImEm3d4wp9HAg3/0=;
 b=BHV2csE3vDsxllnArDZGU3CneRBHlR4u3MLDVBCuFVA7Tlq81yXAZK0E9gBMwzLqgxfPMq
 zdXj21daL790nFIUA9p0WndxbjwQgJqBq+rfiu2SWUrJzs/1O2TJQGigp2Jj+3rUahVXtc
 U0oOfV1Ppo7ysuvYIqZvGiBy3KBc4Yk=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-634-P_Li5wrOPx-px3Lu6HvcqA-1; Mon, 21 Mar 2022 09:34:54 -0400
X-MC-Unique: P_Li5wrOPx-px3Lu6HvcqA-1
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.rdu2.redhat.com
 [10.11.54.3])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 2DD291044562;
 Mon, 21 Mar 2022 13:34:53 +0000 (UTC)
Received: from warthog.procyon.org.uk (unknown [10.33.36.19])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 2B1821121318;
 Mon, 21 Mar 2022 13:34:45 +0000 (UTC)
Organization: Red Hat UK Ltd. Registered Address: Red Hat UK Ltd, Amberley
 Place, 107-111 Peascod Street, Windsor, Berkshire, SI4 1TE, United
 Kingdom.
 Registered in England and Wales under Company Registration No. 3798903
From: David Howells <dhowells@redhat.com>
In-Reply-To: <20220316131723.111553-4-jefflexu@linux.alibaba.com>
References: <20220316131723.111553-4-jefflexu@linux.alibaba.com>
 <20220316131723.111553-1-jefflexu@linux.alibaba.com>
To: Jeffle Xu <jefflexu@linux.alibaba.com>
Subject: Re: [PATCH v5 03/22] cachefiles: introduce on-demand read mode
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-ID: <1027871.1647869684.1@warthog.procyon.org.uk>
Content-Transfer-Encoding: quoted-printable
Date: Mon, 21 Mar 2022 13:34:44 +0000
Message-ID: <1027872.1647869684@warthog.procyon.org.uk>
X-Scanned-By: MIMEDefang 2.78 on 10.11.54.3
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

> Fscache/cachefiles used to serve as a local cache for remote fs. This
> patch, along with the following patches, introduces a new on-demand read
> mode for cachefiles, which can boost the scenario where on-demand read
> semantics is needed, e.g. container image distribution.
> =

> The essential difference between the original mode and on-demand read
> mode is that, in the original mode, when cache miss, netfs itself will
> fetch data from remote, and then write the fetched data into cache file.
> While in on-demand read mode, a user daemon is responsible for fetching
> data and then writing to the cache file.
> =

> This patch only adds the command to enable on-demand read mode. An optio=
nal
> parameter to "bind" command is added. On-demand mode will be turned on w=
hen
> this optional argument matches "ondemand" exactly, i.e.  "bind
> ondemand". Otherwise cachefiles will keep working in the original mode.

You're not really adding a command, per se.  Also, I would recommend
starting the paragraph with a verb.  How about:

	Make it possible to enable on-demand read mode by adding an
	optional parameter to the "bind" command.  On-demand mode will be
	turned on when this parameter is "ondemand", i.e. "bind ondemand".
	Otherwise cachefiles will work in the original mode.

Also, I'd add a note something like the following:

	This is implemented as a variation on the bind command so that it
	can't be turned on accidentally in /etc/cachefilesd.conf when
	cachefilesd isn't expecting it.	=


> The following patches will implement the data plane of on-demand read
> mode.

I would remove this line.  If ondemand mode is not fully implemented in
cachefiles at this point, I would be tempted to move this to the end of th=
e
cachefiles subset of the patchset.  That said, I'm not sure it can be made
to do anything much before that point.

> +#ifdef CONFIG_CACHEFILES_ONDEMAND
> +static inline void cachefiles_ondemand_open(struct cachefiles_cache *ca=
che)
> +{
> +	xa_init_flags(&cache->reqs, XA_FLAGS_ALLOC);
> +	rwlock_init(&cache->reqs_lock);
> +}

Just merge that into the caller.

> +static inline void cachefiles_ondemand_release(struct cachefiles_cache =
*cache)
> +{
> +	xa_destroy(&cache->reqs);
> +}

Ditto.

> +static inline
> +bool cachefiles_ondemand_daemon_bind(struct cachefiles_cache *cache, ch=
ar *args)
> +{
> +	if (!strcmp(args, "ondemand")) {
> +		set_bit(CACHEFILES_ONDEMAND_MODE, &cache->flags);
> +		return true;
> +	}
> +
> +	return false;
> +}
> ...
> +	if (!cachefiles_ondemand_daemon_bind(cache, args) && *args) {
> +		pr_err("'bind' command doesn't take an argument\n");
> +		return -EINVAL;
> +	}
> +

I would merge these together, I think, and say something like "Ondemand
mode not enabled in kernel" if CONFIG_CACHEFILES_ONDEMAND=3Dn.

David

