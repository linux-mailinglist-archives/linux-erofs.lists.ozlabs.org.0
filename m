Return-Path: <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>
X-Original-To: lists+linux-erofs@lfdr.de
Delivered-To: lists+linux-erofs@lfdr.de
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	by mail.lfdr.de (Postfix) with ESMTPS id DB92263661C
	for <lists+linux-erofs@lfdr.de>; Wed, 23 Nov 2022 17:45:08 +0100 (CET)
Received: from boromir.ozlabs.org (localhost [IPv6:::1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4NHRnF0Frbz3cNb
	for <lists+linux-erofs@lfdr.de>; Thu, 24 Nov 2022 03:45:05 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org;
	dkim=fail reason="signature verification failed" (1024-bit key; unprotected) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=aQvLVw2K;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=aQvLVw2K;
	dkim-atps=neutral
X-Original-To: linux-erofs@lists.ozlabs.org
Delivered-To: linux-erofs@lists.ozlabs.org
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=redhat.com (client-ip=170.10.129.124; helo=us-smtp-delivery-124.mimecast.com; envelope-from=dhowells@redhat.com; receiver=<UNKNOWN>)
Authentication-Results: lists.ozlabs.org;
	dkim=pass (1024-bit key; unprotected) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=aQvLVw2K;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=aQvLVw2K;
	dkim-atps=neutral
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4NHRn70HMbz2yYj
	for <linux-erofs@lists.ozlabs.org>; Thu, 24 Nov 2022 03:44:57 +1100 (AEDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1669221891;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=wmLo5b/TBcqyf/fyKj1XX69CJGukHZ7yEx4cmTraIL0=;
	b=aQvLVw2Kt8hwsbp8fyXepM2hGg8LB5GVeFMLsimM2hU6oGnTBV8KtcOdjvKXQsxPzZRfIP
	zeUgOVJLzL4vCeROdHeP2IdkNyGtVnSJYMl+RBkRsgcxlPUBmuYmaRegnZMqbWnh6yVuRU
	aDHzcvIdS3cu847K5asWa9BwJ6HM8mM=
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1669221891;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=wmLo5b/TBcqyf/fyKj1XX69CJGukHZ7yEx4cmTraIL0=;
	b=aQvLVw2Kt8hwsbp8fyXepM2hGg8LB5GVeFMLsimM2hU6oGnTBV8KtcOdjvKXQsxPzZRfIP
	zeUgOVJLzL4vCeROdHeP2IdkNyGtVnSJYMl+RBkRsgcxlPUBmuYmaRegnZMqbWnh6yVuRU
	aDHzcvIdS3cu847K5asWa9BwJ6HM8mM=
Received: from mimecast-mx02.redhat.com (mx3-rdu2.redhat.com
 [66.187.233.73]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-519-dIEnK4EDO6uePavw9I6IQg-1; Wed, 23 Nov 2022 11:44:47 -0500
X-MC-Unique: dIEnK4EDO6uePavw9I6IQg-1
Received: from smtp.corp.redhat.com (int-mx07.intmail.prod.int.rdu2.redhat.com [10.11.54.7])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 518EF1C2726A;
	Wed, 23 Nov 2022 16:44:47 +0000 (UTC)
Received: from warthog.procyon.org.uk (unknown [10.33.36.14])
	by smtp.corp.redhat.com (Postfix) with ESMTP id 3311A1415114;
	Wed, 23 Nov 2022 16:44:46 +0000 (UTC)
Organization: Red Hat UK Ltd. Registered Address: Red Hat UK Ltd, Amberley
	Place, 107-111 Peascod Street, Windsor, Berkshire, SI4 1TE, United
	Kingdom.
	Registered in England and Wales under Company Registration No. 3798903
From: David Howells <dhowells@redhat.com>
In-Reply-To: <20221117053017.21074-2-jefflexu@linux.alibaba.com>
References: <20221117053017.21074-2-jefflexu@linux.alibaba.com> <20221117053017.21074-1-jefflexu@linux.alibaba.com>
To: Jingbo Xu <jefflexu@linux.alibaba.com>
Subject: Re: [PATCH v4 1/2] fscache,cachefiles: add prepare_ondemand_read() callback
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-ID: <1609246.1669221883.1@warthog.procyon.org.uk>
Content-Transfer-Encoding: quoted-printable
Date: Wed, 23 Nov 2022 16:44:43 +0000
Message-ID: <1609247.1669221883@warthog.procyon.org.uk>
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
Cc: jlayton@kernel.org, linux-kernel@vger.kernel.org, dhowells@redhat.com, linux-cachefs@redhat.com, linux-fsdevel@vger.kernel.org, linux-erofs@lists.ozlabs.org
Errors-To: linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org
Sender: "Linux-erofs" <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>

Jingbo Xu <jefflexu@linux.alibaba.com> wrote:

> -/*
> - * Prepare a read operation, shortening it to a cached/uncached
> - * boundary as appropriate.
> - */
> -static enum netfs_io_source cachefiles_prepare_read(struct netfs_io_sub=
request *subreq,
> -						      loff_t i_size)
> +static inline enum netfs_io_source
> +cachefiles_do_prepare_read(struct netfs_cache_resources *cres,
> +			   loff_t start, size_t *_len, loff_t i_size,
> +			   unsigned long *_flags)

That's not exactly what I meant, but I guess it would work as the compiler
would probably inline it into both callers.

> -		      __entry->netfs_inode, __entry->cache_inode)
> +		      __entry->cache_inode)

Can you not lose the netfs_inode number from the tracepoint, please?  Feel
free to display 0 there for your purposes.

David

