Return-Path: <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>
X-Original-To: lists+linux-erofs@lfdr.de
Delivered-To: lists+linux-erofs@lfdr.de
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2404:9400:2:0:216:3eff:fee1:b9f1])
	by mail.lfdr.de (Postfix) with ESMTPS id 55EFE6CC1C4
	for <lists+linux-erofs@lfdr.de>; Tue, 28 Mar 2023 16:12:44 +0200 (CEST)
Received: from boromir.ozlabs.org (localhost [IPv6:::1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4PmBTk0vW8z3cj1
	for <lists+linux-erofs@lfdr.de>; Wed, 29 Mar 2023 01:12:42 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org;
	dkim=fail reason="signature verification failed" (1024-bit key; unprotected) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=F0JPUNpB;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=F0JPUNpB;
	dkim-atps=neutral
X-Original-To: linux-erofs@lists.ozlabs.org
Delivered-To: linux-erofs@lists.ozlabs.org
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=redhat.com (client-ip=170.10.129.124; helo=us-smtp-delivery-124.mimecast.com; envelope-from=dhowells@redhat.com; receiver=<UNKNOWN>)
Authentication-Results: lists.ozlabs.org;
	dkim=pass (1024-bit key; unprotected) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=F0JPUNpB;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=F0JPUNpB;
	dkim-atps=neutral
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4PmBTb2mY0z3cLT
	for <linux-erofs@lists.ozlabs.org>; Wed, 29 Mar 2023 01:12:34 +1100 (AEDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1680012751;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=jFnQl8ATxoafGr28+mJKj23xjOS1vRu21jhKl7IouiY=;
	b=F0JPUNpBrkVFD/YdmFLTn6pSOHwy/lnmmVsvm+Tp1fz5OFfjU4eeDsJtj2bD6OThB7ziDI
	I/lM/XSbvqtSdzLCaarb6V8j9eXC4lwGgDKJNa0ZOojYedD8T53mJECuROlpiC67JoiDug
	G2OAvziAQ+49Xvj5HuLwjaEgl7H+UTw=
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1680012751;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=jFnQl8ATxoafGr28+mJKj23xjOS1vRu21jhKl7IouiY=;
	b=F0JPUNpBrkVFD/YdmFLTn6pSOHwy/lnmmVsvm+Tp1fz5OFfjU4eeDsJtj2bD6OThB7ziDI
	I/lM/XSbvqtSdzLCaarb6V8j9eXC4lwGgDKJNa0ZOojYedD8T53mJECuROlpiC67JoiDug
	G2OAvziAQ+49Xvj5HuLwjaEgl7H+UTw=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-189-ycdylGt2MaKNYmlGjU3KkA-1; Tue, 28 Mar 2023 10:12:27 -0400
X-MC-Unique: ycdylGt2MaKNYmlGjU3KkA-1
Received: from smtp.corp.redhat.com (int-mx09.intmail.prod.int.rdu2.redhat.com [10.11.54.9])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mimecast-mx02.redhat.com (Postfix) with ESMTPS id AD323100DEAE;
	Tue, 28 Mar 2023 14:12:26 +0000 (UTC)
Received: from warthog.procyon.org.uk (unknown [10.33.36.18])
	by smtp.corp.redhat.com (Postfix) with ESMTP id 88E5C492C13;
	Tue, 28 Mar 2023 14:12:25 +0000 (UTC)
Organization: Red Hat UK Ltd. Registered Address: Red Hat UK Ltd, Amberley
	Place, 107-111 Peascod Street, Windsor, Berkshire, SI4 1TE, United
	Kingdom.
	Registered in England and Wales under Company Registration No. 3798903
From: David Howells <dhowells@redhat.com>
In-Reply-To: <20230111052515.53941-4-zhujia.zj@bytedance.com>
References: <20230111052515.53941-4-zhujia.zj@bytedance.com> <20230111052515.53941-1-zhujia.zj@bytedance.com>
To: Jia Zhu <zhujia.zj@bytedance.com>
Subject: Re: [PATCH V4 3/5] cachefiles: resend an open request if the read request's object is closed
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-ID: <132776.1680012744.1@warthog.procyon.org.uk>
Date: Tue, 28 Mar 2023 15:12:24 +0100
Message-ID: <132777.1680012744@warthog.procyon.org.uk>
X-Scanned-By: MIMEDefang 3.1 on 10.11.54.9
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
Cc: linux-kernel@vger.kernel.org, dhowells@redhat.com, linux-cachefs@redhat.com, linux-fsdevel@vger.kernel.org, linux-erofs@lists.ozlabs.org
Errors-To: linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org
Sender: "Linux-erofs" <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>

Jia Zhu <zhujia.zj@bytedance.com> wrote:

> +	struct cachefiles_object *object =
> +		((struct cachefiles_ondemand_info *)work)->object;

container_of().

> +			continue;
> +		} else if (cachefiles_ondemand_object_is_reopening(object)) {

The "else" is unnecessary.

> +static void ondemand_object_worker(struct work_struct *work)
> +{
> +	struct cachefiles_object *object =
> +		((struct cachefiles_ondemand_info *)work)->object;
> +
> +	cachefiles_ondemand_init_object(object);
> +}

I can't help but feel there's some missing exclusion/locking.  This feels like
it really ought to be driven from the fscache object state machine.

