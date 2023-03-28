Return-Path: <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>
X-Original-To: lists+linux-erofs@lfdr.de
Delivered-To: lists+linux-erofs@lfdr.de
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	by mail.lfdr.de (Postfix) with ESMTPS id C0CF56CC16B
	for <lists+linux-erofs@lfdr.de>; Tue, 28 Mar 2023 15:52:31 +0200 (CEST)
Received: from boromir.ozlabs.org (localhost [IPv6:::1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4PmB2P4v7Kz3cj1
	for <lists+linux-erofs@lfdr.de>; Wed, 29 Mar 2023 00:52:29 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org;
	dkim=fail reason="signature verification failed" (1024-bit key; unprotected) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=Qmwpldc5;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=MXgbMaFS;
	dkim-atps=neutral
X-Original-To: linux-erofs@lists.ozlabs.org
Delivered-To: linux-erofs@lists.ozlabs.org
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=redhat.com (client-ip=170.10.129.124; helo=us-smtp-delivery-124.mimecast.com; envelope-from=dhowells@redhat.com; receiver=<UNKNOWN>)
Authentication-Results: lists.ozlabs.org;
	dkim=pass (1024-bit key; unprotected) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=Qmwpldc5;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=MXgbMaFS;
	dkim-atps=neutral
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4PmB2K4kN2z3cgx
	for <linux-erofs@lists.ozlabs.org>; Wed, 29 Mar 2023 00:52:23 +1100 (AEDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1680011537;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=0Bjk4mx3lBKFeadPQXueJB7h/c8lDuCBaVc1H5uzUP4=;
	b=Qmwpldc5BctCzG4vqNEeknc9px02/nZO9pamd4tajaeokuCO1+S14DLl4PJdnzBZ33p5z2
	4Uf3AJkUUvzC77ejTSxRUZVwQfRP72IeH7zDXhKRnSkG7BlVagXMkEfpIMOnzK2JGm9eVL
	I5ZttBplkt4CS02xBY+N+eDZi+Kgm4s=
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1680011538;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=0Bjk4mx3lBKFeadPQXueJB7h/c8lDuCBaVc1H5uzUP4=;
	b=MXgbMaFSCt4DGJ0Nkz/rO7SedHZ+SSDj4nMh3vaHK+rCmqccDaYh81zxHZyxbw1uwyZrCh
	YmlEapPBqwfz2bghVyyKg8t3jsvjiE0tlb/uhhxmTM7ksX5I96cgD/BTF6OhGQKEEAzngA
	B0cbvYR0c22CO6sPsnjLloIlv9qEI00=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-587-gnJ2ogLqNoKHz6FfAC4XsA-1; Tue, 28 Mar 2023 09:52:14 -0400
X-MC-Unique: gnJ2ogLqNoKHz6FfAC4XsA-1
Received: from smtp.corp.redhat.com (int-mx07.intmail.prod.int.rdu2.redhat.com [10.11.54.7])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 7A9C1855315;
	Tue, 28 Mar 2023 13:52:13 +0000 (UTC)
Received: from warthog.procyon.org.uk (unknown [10.33.36.18])
	by smtp.corp.redhat.com (Postfix) with ESMTP id 3E09614171BB;
	Tue, 28 Mar 2023 13:52:12 +0000 (UTC)
Organization: Red Hat UK Ltd. Registered Address: Red Hat UK Ltd, Amberley
	Place, 107-111 Peascod Street, Windsor, Berkshire, SI4 1TE, United
	Kingdom.
	Registered in England and Wales under Company Registration No. 3798903
From: David Howells <dhowells@redhat.com>
In-Reply-To: <20230111052515.53941-2-zhujia.zj@bytedance.com>
References: <20230111052515.53941-2-zhujia.zj@bytedance.com> <20230111052515.53941-1-zhujia.zj@bytedance.com>
To: Jia Zhu <zhujia.zj@bytedance.com>
Subject: Re: [PATCH V4 1/5] cachefiles: introduce object ondemand state
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-ID: <131868.1680011531.1@warthog.procyon.org.uk>
Content-Transfer-Encoding: quoted-printable
Date: Tue, 28 Mar 2023 14:52:11 +0100
Message-ID: <131869.1680011531@warthog.procyon.org.uk>
X-Scanned-By: MIMEDefang 3.1 on 10.11.54.7
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

> +enum cachefiles_object_state {
> +	CACHEFILES_ONDEMAND_OBJSTATE_close, /* Anonymous fd closed by daemon o=
r initial state */
> +	CACHEFILES_ONDEMAND_OBJSTATE_open, /* Anonymous fd associated with obj=
ect is available */

That looks weird.  Maybe make them all-lowercase?

> @@ -296,6 +302,21 @@ extern void cachefiles_ondemand_clean_object(struct=
 cachefiles_object *object);
>  extern int cachefiles_ondemand_read(struct cachefiles_object *object,
>  				    loff_t pos, size_t len);
>  =

> +#define CACHEFILES_OBJECT_STATE_FUNCS(_state)	\
> +static inline bool								\
> +cachefiles_ondemand_object_is_##_state(const struct cachefiles_object *=
object) \
> +{												\
> +	return object->state =3D=3D CACHEFILES_ONDEMAND_OBJSTATE_##_state; \
> +}												\
> +												\
> +static inline void								\
> +cachefiles_ondemand_set_object_##_state(struct cachefiles_object *objec=
t) \
> +{												\
> +	object->state =3D CACHEFILES_ONDEMAND_OBJSTATE_##_state; \
> +}
> +
> +CACHEFILES_OBJECT_STATE_FUNCS(open);
> +CACHEFILES_OBJECT_STATE_FUNCS(close);

Or just get rid of the macroisation?  If there are only two states, it doe=
sn't
save you that much and it means that "make TAGS" won't generate refs for t=
hose
functions and grep won't find them.

David

