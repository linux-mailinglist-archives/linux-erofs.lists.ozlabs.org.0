Return-Path: <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>
X-Original-To: lists+linux-erofs@lfdr.de
Delivered-To: lists+linux-erofs@lfdr.de
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2404:9400:2:0:216:3eff:fee1:b9f1])
	by mail.lfdr.de (Postfix) with ESMTPS id 25D3460F8A7
	for <lists+linux-erofs@lfdr.de>; Thu, 27 Oct 2022 15:11:39 +0200 (CEST)
Received: from boromir.ozlabs.org (localhost [IPv6:::1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4MymKN6hf7z3c6D
	for <lists+linux-erofs@lfdr.de>; Fri, 28 Oct 2022 00:11:36 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org;
	dkim=fail reason="signature verification failed" (1024-bit key; unprotected) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=ZSXBTSW5;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=ZSXBTSW5;
	dkim-atps=neutral
X-Original-To: linux-erofs@lists.ozlabs.org
Delivered-To: linux-erofs@lists.ozlabs.org
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=redhat.com (client-ip=170.10.129.124; helo=us-smtp-delivery-124.mimecast.com; envelope-from=dhowells@redhat.com; receiver=<UNKNOWN>)
Authentication-Results: lists.ozlabs.org;
	dkim=pass (1024-bit key; unprotected) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=ZSXBTSW5;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=ZSXBTSW5;
	dkim-atps=neutral
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4MymKL0qMvz2xgG
	for <linux-erofs@lists.ozlabs.org>; Fri, 28 Oct 2022 00:11:33 +1100 (AEDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1666876291;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=08qQCOq6HXtPu07yJoUG1gykaILDIdfjGgF17Vne+y0=;
	b=ZSXBTSW5Ps2alxXwI9WYzPsg89Mg6UooXJIkTv2NLQCa+zJgawt5oiMLosZlg0+c1YKHMo
	AhiYgRS2FcjoajDw+EvrKRfSJvH24QYatpH5OdnKUVcOz9KmxGhLGEJe5bTYd6ku3+NpJ0
	U9pYqJVXxnTeEmF1l30J47HBsRwjvck=
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1666876291;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=08qQCOq6HXtPu07yJoUG1gykaILDIdfjGgF17Vne+y0=;
	b=ZSXBTSW5Ps2alxXwI9WYzPsg89Mg6UooXJIkTv2NLQCa+zJgawt5oiMLosZlg0+c1YKHMo
	AhiYgRS2FcjoajDw+EvrKRfSJvH24QYatpH5OdnKUVcOz9KmxGhLGEJe5bTYd6ku3+NpJ0
	U9pYqJVXxnTeEmF1l30J47HBsRwjvck=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-649-YAG-GrF1PNKY9HcojBWvQA-1; Thu, 27 Oct 2022 09:11:26 -0400
X-MC-Unique: YAG-GrF1PNKY9HcojBWvQA-1
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.rdu2.redhat.com [10.11.54.3])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 8D41E811E75;
	Thu, 27 Oct 2022 13:11:25 +0000 (UTC)
Received: from warthog.procyon.org.uk (unknown [10.33.36.73])
	by smtp.corp.redhat.com (Postfix) with ESMTP id 66BC01121333;
	Thu, 27 Oct 2022 13:11:24 +0000 (UTC)
Organization: Red Hat UK Ltd. Registered Address: Red Hat UK Ltd, Amberley
	Place, 107-111 Peascod Street, Windsor, Berkshire, SI4 1TE, United
	Kingdom.
	Registered in England and Wales under Company Registration No. 3798903
From: David Howells <dhowells@redhat.com>
In-Reply-To: <20221027083547.46933-8-jefflexu@linux.alibaba.com>
References: <20221027083547.46933-8-jefflexu@linux.alibaba.com> <20221027083547.46933-1-jefflexu@linux.alibaba.com>
To: Jingbo Xu <jefflexu@linux.alibaba.com>
Subject: Re: [PATCH 7/9] fscache,netfs: define flags for prepare_read()
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-ID: <3306594.1666876283.1@warthog.procyon.org.uk>
Date: Thu, 27 Oct 2022 14:11:23 +0100
Message-ID: <3306595.1666876283@warthog.procyon.org.uk>
X-Scanned-By: MIMEDefang 3.1 on 10.11.54.3
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
Cc: linux-cifs@vger.kernel.org, linux-nfs@vger.kernel.org, jlayton@kernel.org, linux-kernel@vger.kernel.org, dhowells@redhat.com, linux-cachefs@redhat.com, linux-fsdevel@vger.kernel.org, linux-erofs@lists.ozlabs.org, linux-afs@lists.infradead.org
Errors-To: linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org
Sender: "Linux-erofs" <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>

Jingbo Xu <jefflexu@linux.alibaba.com> wrote:

> +		if (test_bit(FSCACHE_REQ_COPY_TO_CACHE, &flags))
> +			__set_bit(NETFS_SREQ_COPY_TO_CACHE, &subreq->flags);

Please don't do that in netfslib.  Netfslib shouldn't know about fscache's
inner workings.

David

