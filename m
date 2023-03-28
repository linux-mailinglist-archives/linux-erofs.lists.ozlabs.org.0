Return-Path: <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>
X-Original-To: lists+linux-erofs@lfdr.de
Delivered-To: lists+linux-erofs@lfdr.de
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	by mail.lfdr.de (Postfix) with ESMTPS id 1EA5F6CC1EE
	for <lists+linux-erofs@lfdr.de>; Tue, 28 Mar 2023 16:19:28 +0200 (CEST)
Received: from boromir.ozlabs.org (localhost [IPv6:::1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4PmBdV05cmz3cj1
	for <lists+linux-erofs@lfdr.de>; Wed, 29 Mar 2023 01:19:26 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org;
	dkim=fail reason="signature verification failed" (1024-bit key; unprotected) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=chfRJlWf;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=chfRJlWf;
	dkim-atps=neutral
X-Original-To: linux-erofs@lists.ozlabs.org
Delivered-To: linux-erofs@lists.ozlabs.org
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=redhat.com (client-ip=170.10.129.124; helo=us-smtp-delivery-124.mimecast.com; envelope-from=dhowells@redhat.com; receiver=<UNKNOWN>)
Authentication-Results: lists.ozlabs.org;
	dkim=pass (1024-bit key; unprotected) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=chfRJlWf;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=chfRJlWf;
	dkim-atps=neutral
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4PmBdQ6RSLz3cBj
	for <linux-erofs@lists.ozlabs.org>; Wed, 29 Mar 2023 01:19:22 +1100 (AEDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1680013160;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=f/m5SehYf6RbF0mCNKIuKWpkgQ5bnk3BT8O942PeKag=;
	b=chfRJlWfHMdarwszvcGNJHyzNowQVKtNsO+pr9sBEdbz5lcnYI/4gnIYA5GttIX70QFgdH
	2pV9AWfRin11gCYksUKjy3rdZvkdgZVwVAynaKXihml7/qSkoP7uPEFR9AQrCIYscC9CWs
	dwm06Ah/pwh0ZqOOWVHVjhuUlPYcQWk=
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1680013160;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=f/m5SehYf6RbF0mCNKIuKWpkgQ5bnk3BT8O942PeKag=;
	b=chfRJlWfHMdarwszvcGNJHyzNowQVKtNsO+pr9sBEdbz5lcnYI/4gnIYA5GttIX70QFgdH
	2pV9AWfRin11gCYksUKjy3rdZvkdgZVwVAynaKXihml7/qSkoP7uPEFR9AQrCIYscC9CWs
	dwm06Ah/pwh0ZqOOWVHVjhuUlPYcQWk=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-159-_y0_tW6pN42bkhsN1F0pfg-1; Tue, 28 Mar 2023 10:19:16 -0400
X-MC-Unique: _y0_tW6pN42bkhsN1F0pfg-1
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.rdu2.redhat.com [10.11.54.3])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mimecast-mx02.redhat.com (Postfix) with ESMTPS id A076E848B68;
	Tue, 28 Mar 2023 14:19:07 +0000 (UTC)
Received: from warthog.procyon.org.uk (unknown [10.33.36.18])
	by smtp.corp.redhat.com (Postfix) with ESMTP id 9DD891121330;
	Tue, 28 Mar 2023 14:19:06 +0000 (UTC)
Organization: Red Hat UK Ltd. Registered Address: Red Hat UK Ltd, Amberley
	Place, 107-111 Peascod Street, Windsor, Berkshire, SI4 1TE, United
	Kingdom.
	Registered in England and Wales under Company Registration No. 3798903
From: David Howells <dhowells@redhat.com>
In-Reply-To: <20230111052515.53941-5-zhujia.zj@bytedance.com>
References: <20230111052515.53941-5-zhujia.zj@bytedance.com> <20230111052515.53941-1-zhujia.zj@bytedance.com>
To: Jia Zhu <zhujia.zj@bytedance.com>
Subject: Re: [PATCH V4 4/5] cachefiles: narrow the scope of triggering EPOLLIN events in ondemand mode
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-ID: <133077.1680013145.1@warthog.procyon.org.uk>
Date: Tue, 28 Mar 2023 15:19:05 +0100
Message-ID: <133078.1680013145@warthog.procyon.org.uk>
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
Cc: linux-kernel@vger.kernel.org, dhowells@redhat.com, linux-cachefs@redhat.com, linux-fsdevel@vger.kernel.org, linux-erofs@lists.ozlabs.org
Errors-To: linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org
Sender: "Linux-erofs" <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>

Jia Zhu <zhujia.zj@bytedance.com> wrote:

> +		if (!xa_empty(xa)) {
> +			xa_lock(xa);
> +			xa_for_each_marked(xa, index, req, CACHEFILES_REQ_NEW) {
> +				if (!cachefiles_ondemand_is_reopening_read(req)) {
> +					mask |= EPOLLIN;
> +					break;
> +				}
> +			}
> +			xa_unlock(xa);
> +		}

I wonder if there's a more efficient way to do this.  I guess it depends on
how many reqs you expect to get in a queue.  It might be worth taking the
rcu_read_lock before calling xa_lock() and holding it over the whole loop.

David

