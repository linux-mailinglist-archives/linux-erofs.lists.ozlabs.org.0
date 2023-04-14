Return-Path: <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>
X-Original-To: lists+linux-erofs@lfdr.de
Delivered-To: lists+linux-erofs@lfdr.de
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	by mail.lfdr.de (Postfix) with ESMTPS id 2E42C6E24CD
	for <lists+linux-erofs@lfdr.de>; Fri, 14 Apr 2023 15:53:41 +0200 (CEST)
Received: from boromir.ozlabs.org (localhost [IPv6:::1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4PydFv0c7bz3bnM
	for <lists+linux-erofs@lfdr.de>; Fri, 14 Apr 2023 23:53:39 +1000 (AEST)
Authentication-Results: lists.ozlabs.org;
	dkim=fail reason="signature verification failed" (1024-bit key; unprotected) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=ao/HRrMg;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=JoyZwtMT;
	dkim-atps=neutral
X-Original-To: linux-erofs@lists.ozlabs.org
Delivered-To: linux-erofs@lists.ozlabs.org
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=redhat.com (client-ip=170.10.133.124; helo=us-smtp-delivery-124.mimecast.com; envelope-from=dhowells@redhat.com; receiver=<UNKNOWN>)
Authentication-Results: lists.ozlabs.org;
	dkim=pass (1024-bit key; unprotected) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=ao/HRrMg;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=JoyZwtMT;
	dkim-atps=neutral
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4PydFq1Fqpz2yfq
	for <linux-erofs@lists.ozlabs.org>; Fri, 14 Apr 2023 23:53:34 +1000 (AEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1681480411;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=C/e8KjFHs61uEyXVXMB8pUc3YDR+G8woISfuf6Pj1AE=;
	b=ao/HRrMgS541L3N2O9yI0+PynVuZUNNnl4cIYS0KEYH6KqTXA6ByB+Eau7PiOJCwFwGNzH
	XPVtN0bo66zt8Ug4maMPqpTiDx6k4j/VuZjTAoB67cEIhVzthbpEXmq8SGkhgx4lTKh6Gt
	0AaWvPBGwfQeWQXCZSdVocSPl+N0oeo=
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1681480412;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=C/e8KjFHs61uEyXVXMB8pUc3YDR+G8woISfuf6Pj1AE=;
	b=JoyZwtMTA2mfYz5IRXcR4Go+Xr/pwI06pkVMRfDYdBBEs5yCoUzFL79Ydh9YezhPc3mzpK
	SwJOCFIf4xgc4+nHJmLaaHT4udBnYRukOCZ62UdWxsYFcuKeJ6yChKTtsk5RPSUHVUIKeo
	VLC3H54On32jHBW3UQv0SE2Wl7VKAdk=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-128-2o5ch5vzO-yipSJ1W4Ip1w-1; Fri, 14 Apr 2023 09:53:26 -0400
X-MC-Unique: 2o5ch5vzO-yipSJ1W4Ip1w-1
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.rdu2.redhat.com [10.11.54.4])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 8AEC018A63EB;
	Fri, 14 Apr 2023 13:53:25 +0000 (UTC)
Received: from warthog.procyon.org.uk (unknown [10.33.36.5])
	by smtp.corp.redhat.com (Postfix) with ESMTP id 8F6492027044;
	Fri, 14 Apr 2023 13:53:24 +0000 (UTC)
Organization: Red Hat UK Ltd. Registered Address: Red Hat UK Ltd, Amberley
	Place, 107-111 Peascod Street, Windsor, Berkshire, SI4 1TE, United
	Kingdom.
	Registered in England and Wales under Company Registration No. 3798903
From: David Howells <dhowells@redhat.com>
In-Reply-To: <20230329140155.53272-6-zhujia.zj@bytedance.com>
References: <20230329140155.53272-6-zhujia.zj@bytedance.com> <20230329140155.53272-1-zhujia.zj@bytedance.com>
To: Jia Zhu <zhujia.zj@bytedance.com>
Subject: Re: [PATCH V5 5/5] cachefiles: add restore command to recover inflight ondemand read requests
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-ID: <1250438.1681480404.1@warthog.procyon.org.uk>
Date: Fri, 14 Apr 2023 14:53:24 +0100
Message-ID: <1250439.1681480404@warthog.procyon.org.uk>
X-Scanned-By: MIMEDefang 3.1 on 10.11.54.4
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
Cc: linux-kernel@vger.kernel.org, dhowells@redhat.com, linux-cachefs@redhat.com, hsiangkao@linux.alibaba.com, linux-erofs@lists.ozlabs.org
Errors-To: linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org
Sender: "Linux-erofs" <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>

Jia Zhu <zhujia.zj@bytedance.com> wrote:

> +int cachefiles_ondemand_restore(struct cachefiles_cache *cache, char *args)
> +{
> +	struct cachefiles_req *req;
> +
> +	XA_STATE(xas, &cache->reqs, 0);
> +
> +	if (!test_bit(CACHEFILES_ONDEMAND_MODE, &cache->flags))
> +		return -EOPNOTSUPP;
> +
> +	/*
> +	 * Reset the requests to CACHEFILES_REQ_NEW state, so that the
> +	 * requests have been processed halfway before the crash of the
> +	 * user daemon could be reprocessed after the recovery.
> +	 */
> +	xas_lock(&xas);
> +	xas_for_each(&xas, req, ULONG_MAX)
> +		xas_set_mark(&xas, CACHEFILES_REQ_NEW);
> +	xas_unlock(&xas);
> +
> +	wake_up_all(&cache->daemon_pollwq);
> +	return 0;
> +}

Should there be a check to see if this is needed?

David

