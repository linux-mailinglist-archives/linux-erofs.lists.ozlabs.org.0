Return-Path: <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>
X-Original-To: lists+linux-erofs@lfdr.de
Delivered-To: lists+linux-erofs@lfdr.de
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2404:9400:2:0:216:3eff:fee1:b9f1])
	by mail.lfdr.de (Postfix) with ESMTPS id 2AB416E24BB
	for <lists+linux-erofs@lfdr.de>; Fri, 14 Apr 2023 15:52:03 +0200 (CEST)
Received: from boromir.ozlabs.org (localhost [IPv6:::1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4PydD10ShXz3fld
	for <lists+linux-erofs@lfdr.de>; Fri, 14 Apr 2023 23:52:01 +1000 (AEST)
Authentication-Results: lists.ozlabs.org;
	dkim=fail reason="signature verification failed" (1024-bit key; unprotected) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=Ea6hOwhC;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=Ea6hOwhC;
	dkim-atps=neutral
X-Original-To: linux-erofs@lists.ozlabs.org
Delivered-To: linux-erofs@lists.ozlabs.org
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=redhat.com (client-ip=170.10.129.124; helo=us-smtp-delivery-124.mimecast.com; envelope-from=dhowells@redhat.com; receiver=<UNKNOWN>)
Authentication-Results: lists.ozlabs.org;
	dkim=pass (1024-bit key; unprotected) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=Ea6hOwhC;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=Ea6hOwhC;
	dkim-atps=neutral
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4PydCc5srPz3gFf
	for <linux-erofs@lists.ozlabs.org>; Fri, 14 Apr 2023 23:51:40 +1000 (AEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1681480297;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=hwFOnM3nMI93el8j5Fm/36C16c2wvk4iAVnNGABHAIk=;
	b=Ea6hOwhCcjOC6HIdiwMeVz0bhGhmvNp6Yr8maP7VHPI9cc+gVl52pDbC+5i96yl1Y80WmA
	tWJ7FFrW3R0tJSxTpZfSdgMQCxiuSHjphpUgoRHshiyrw4ToM6uSSsuAbcBjLc7DyL8k3R
	r1Wzm6itKPb8SBxXz1YbH9gQkp92IdY=
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1681480297;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=hwFOnM3nMI93el8j5Fm/36C16c2wvk4iAVnNGABHAIk=;
	b=Ea6hOwhCcjOC6HIdiwMeVz0bhGhmvNp6Yr8maP7VHPI9cc+gVl52pDbC+5i96yl1Y80WmA
	tWJ7FFrW3R0tJSxTpZfSdgMQCxiuSHjphpUgoRHshiyrw4ToM6uSSsuAbcBjLc7DyL8k3R
	r1Wzm6itKPb8SBxXz1YbH9gQkp92IdY=
Received: from mimecast-mx02.redhat.com (mx3-rdu2.redhat.com
 [66.187.233.73]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-593-_ewnsBbJPLymurl5keXJNQ-1; Fri, 14 Apr 2023 09:51:34 -0400
X-MC-Unique: _ewnsBbJPLymurl5keXJNQ-1
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.rdu2.redhat.com [10.11.54.2])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 84BEF3C10C70;
	Fri, 14 Apr 2023 13:51:33 +0000 (UTC)
Received: from warthog.procyon.org.uk (unknown [10.33.36.5])
	by smtp.corp.redhat.com (Postfix) with ESMTP id 96D5140C6E70;
	Fri, 14 Apr 2023 13:51:32 +0000 (UTC)
Organization: Red Hat UK Ltd. Registered Address: Red Hat UK Ltd, Amberley
	Place, 107-111 Peascod Street, Windsor, Berkshire, SI4 1TE, United
	Kingdom.
	Registered in England and Wales under Company Registration No. 3798903
From: David Howells <dhowells@redhat.com>
In-Reply-To: <20230329140155.53272-3-zhujia.zj@bytedance.com>
References: <20230329140155.53272-3-zhujia.zj@bytedance.com> <20230329140155.53272-1-zhujia.zj@bytedance.com>
To: Jia Zhu <zhujia.zj@bytedance.com>
Subject: Re: [PATCH V5 2/5] cachefiles: extract ondemand info field from cachefiles_object
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-ID: <1250338.1681480291.1@warthog.procyon.org.uk>
Content-Transfer-Encoding: quoted-printable
Date: Fri, 14 Apr 2023 14:51:31 +0100
Message-ID: <1250339.1681480291@warthog.procyon.org.uk>
X-Scanned-By: MIMEDefang 3.1 on 10.11.54.2
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

>  #define CACHEFILES_OBJECT_STATE_FUNCS(_state, _STATE)	\
>  static inline bool								\
>  cachefiles_ondemand_object_is_##_state(const struct cachefiles_object *=
object) \
>  {												\
> -	return object->state =3D=3D CACHEFILES_ONDEMAND_OBJSTATE_##_STATE; \
> +	return object->ondemand->state =3D=3D CACHEFILES_ONDEMAND_OBJSTATE_##_=
STATE; \
>  }												\
>  												\
>  static inline void								\
>  cachefiles_ondemand_set_object_##_state(struct cachefiles_object *objec=
t) \
>  {												\
> -	object->state =3D CACHEFILES_ONDEMAND_OBJSTATE_##_STATE; \
> +	object->ondemand->state =3D CACHEFILES_ONDEMAND_OBJSTATE_##_STATE; \
>  }

I wonder if those need barriers - smp_load_acquire() and smp_store_release=
().

David

