Return-Path: <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>
X-Original-To: lists+linux-erofs@lfdr.de
Delivered-To: lists+linux-erofs@lfdr.de
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2404:9400:2:0:216:3eff:fee1:b9f1])
	by mail.lfdr.de (Postfix) with ESMTPS id 4F9156CC18D
	for <lists+linux-erofs@lfdr.de>; Tue, 28 Mar 2023 15:58:47 +0200 (CEST)
Received: from boromir.ozlabs.org (localhost [IPv6:::1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4PmB9Z3nDVz3cj1
	for <lists+linux-erofs@lfdr.de>; Wed, 29 Mar 2023 00:58:42 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org;
	dkim=fail reason="signature verification failed" (1024-bit key; unprotected) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=a0ekzXtR;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=LXXmd1rx;
	dkim-atps=neutral
X-Original-To: linux-erofs@lists.ozlabs.org
Delivered-To: linux-erofs@lists.ozlabs.org
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=redhat.com (client-ip=170.10.129.124; helo=us-smtp-delivery-124.mimecast.com; envelope-from=dhowells@redhat.com; receiver=<UNKNOWN>)
Authentication-Results: lists.ozlabs.org;
	dkim=pass (1024-bit key; unprotected) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=a0ekzXtR;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=LXXmd1rx;
	dkim-atps=neutral
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4PmB9W3CSwz3cJK
	for <linux-erofs@lists.ozlabs.org>; Wed, 29 Mar 2023 00:58:38 +1100 (AEDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1680011915;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=r/qQMzMODq2NJQFTscBdpgqP90R/mKK82eNeMCBGbBc=;
	b=a0ekzXtR2QKeUE4qxps1+bMnMBpKMGR/W5d3Hs2FfuES86F1vRf5JAn7noWUC1TzBdBbGX
	Ec6jG2MP+QeqFMMF4gCQGiuzsAd6j0RtPQoq/ygadKwAidPmcx7Xi1bj+g0Ld0bmhcFbKd
	A62L4YAzTDg8F6Ebe7GYIyCc0h8Oxp4=
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1680011916;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=r/qQMzMODq2NJQFTscBdpgqP90R/mKK82eNeMCBGbBc=;
	b=LXXmd1rxa9jBhQCOl8oGZkaQJP+7MqdgOKMFuPlgKPt+kdkf2gNe8N46BbNP3q8QYeNJqc
	uDhApHcvI+e0AcTN3wL1m1wK59+Fm85dZMbX+i8UKHnMYB+mNWvBoB7z77KglZIA0XdKw0
	RPKAFWbTp8E8TkYllwZTxm4pX+R/EmU=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-411-88GSLgrJOO-ZtuAQA0V4cw-1; Tue, 28 Mar 2023 09:58:30 -0400
X-MC-Unique: 88GSLgrJOO-ZtuAQA0V4cw-1
Received: from smtp.corp.redhat.com (int-mx09.intmail.prod.int.rdu2.redhat.com [10.11.54.9])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 91F44185A78F;
	Tue, 28 Mar 2023 13:58:29 +0000 (UTC)
Received: from warthog.procyon.org.uk (unknown [10.33.36.18])
	by smtp.corp.redhat.com (Postfix) with ESMTP id B9AC3492C14;
	Tue, 28 Mar 2023 13:58:28 +0000 (UTC)
Organization: Red Hat UK Ltd. Registered Address: Red Hat UK Ltd, Amberley
	Place, 107-111 Peascod Street, Windsor, Berkshire, SI4 1TE, United
	Kingdom.
	Registered in England and Wales under Company Registration No. 3798903
From: David Howells <dhowells@redhat.com>
In-Reply-To: <20230111052515.53941-3-zhujia.zj@bytedance.com>
References: <20230111052515.53941-3-zhujia.zj@bytedance.com> <20230111052515.53941-1-zhujia.zj@bytedance.com>
To: Jia Zhu <zhujia.zj@bytedance.com>
Subject: Re: [PATCH V4 2/5] cachefiles: extract ondemand info field from cachefiles_object
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-ID: <132136.1680011908.1@warthog.procyon.org.uk>
Date: Tue, 28 Mar 2023 14:58:28 +0100
Message-ID: <132137.1680011908@warthog.procyon.org.uk>
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

> @@ -65,10 +71,7 @@ struct cachefiles_object {
>  	enum cachefiles_content		content_info:8;	/* Info about content presence */
>  	unsigned long			flags;
>  #define CACHEFILES_OBJECT_USING_TMPFILE	0		/* Have an unlinked tmpfile */
> -#ifdef CONFIG_CACHEFILES_ONDEMAND
> -	int				ondemand_id;
> -	enum cachefiles_object_state	state;
> -#endif
> +	struct cachefiles_ondemand_info	*private;

Why is this no longer inside "#ifdef CONFIG_CACHEFILES_ONDEMAND"?

Also, please don't call it "private", but rather something like "ondemand" or
"ondemand_info".

David

