Return-Path: <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>
X-Original-To: lists+linux-erofs@lfdr.de
Delivered-To: lists+linux-erofs@lfdr.de
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	by mail.lfdr.de (Postfix) with ESMTPS id 8502C49B7B3
	for <lists+linux-erofs@lfdr.de>; Tue, 25 Jan 2022 16:35:06 +0100 (CET)
Received: from boromir.ozlabs.org (localhost [IPv6:::1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4JjrWr2jdBz30gg
	for <lists+linux-erofs@lfdr.de>; Wed, 26 Jan 2022 02:35:04 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org;
	dkim=fail reason="signature verification failed" (1024-bit key; unprotected) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=bU0opONu;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=bU0opONu;
	dkim-atps=neutral
X-Original-To: linux-erofs@lists.ozlabs.org
Delivered-To: linux-erofs@lists.ozlabs.org
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized)
 smtp.mailfrom=redhat.com (client-ip=170.10.133.124;
 helo=us-smtp-delivery-124.mimecast.com; envelope-from=dhowells@redhat.com;
 receiver=<UNKNOWN>)
Authentication-Results: lists.ozlabs.org; dkim=pass (1024-bit key;
 unprotected) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256
 header.s=mimecast20190719 header.b=bU0opONu; 
 dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com
 header.a=rsa-sha256 header.s=mimecast20190719 header.b=bU0opONu; 
 dkim-atps=neutral
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.133.124])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 4JjrWj3hjgz2yPY
 for <linux-erofs@lists.ozlabs.org>; Wed, 26 Jan 2022 02:34:54 +1100 (AEDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1643124890;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=QjyE7wz6cil8LO6HiDitf7P9QNfNrKVet24hXy+TY64=;
 b=bU0opONu1fC4pQIlPdoOhbB67R5AJFpCfEXqUe+RlhbLXTpm2iAK+jo+EA2Itym4qRLawY
 Uk4bik9CL39Mo66D0vc6pnMXDAxysOKAUxFSr2AG1hGhi96wbc3kyO2u7I/+fGoNcBYSzN
 3M+U5+pmXu9Kju5Svh0uem0p+83LqRk=
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1643124890;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=QjyE7wz6cil8LO6HiDitf7P9QNfNrKVet24hXy+TY64=;
 b=bU0opONu1fC4pQIlPdoOhbB67R5AJFpCfEXqUe+RlhbLXTpm2iAK+jo+EA2Itym4qRLawY
 Uk4bik9CL39Mo66D0vc6pnMXDAxysOKAUxFSr2AG1hGhi96wbc3kyO2u7I/+fGoNcBYSzN
 3M+U5+pmXu9Kju5Svh0uem0p+83LqRk=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-224-5MdDGyFQNUC_uojbNYtUKg-1; Tue, 25 Jan 2022 10:34:45 -0500
X-MC-Unique: 5MdDGyFQNUC_uojbNYtUKg-1
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.phx2.redhat.com
 [10.5.11.16])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 06D8C84B9A7;
 Tue, 25 Jan 2022 15:34:44 +0000 (UTC)
Received: from warthog.procyon.org.uk (unknown [10.33.36.5])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 210947DE2F;
 Tue, 25 Jan 2022 15:34:32 +0000 (UTC)
Organization: Red Hat UK Ltd. Registered Address: Red Hat UK Ltd, Amberley
 Place, 107-111 Peascod Street, Windsor, Berkshire, SI4 1TE, United
 Kingdom.
 Registered in England and Wales under Company Registration No. 3798903
From: David Howells <dhowells@redhat.com>
In-Reply-To: <20220118131216.85338-12-jefflexu@linux.alibaba.com>
References: <20220118131216.85338-12-jefflexu@linux.alibaba.com>
 <20220118131216.85338-1-jefflexu@linux.alibaba.com>
To: Jeffle Xu <jefflexu@linux.alibaba.com>
Subject: Re: [PATCH v2 11/20] erofs: add cookie context helper functions
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-ID: <2812798.1643124872.1@warthog.procyon.org.uk>
Date: Tue, 25 Jan 2022 15:34:32 +0000
Message-ID: <2812799.1643124872@warthog.procyon.org.uk>
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.16
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
Cc: linux-kernel@vger.kernel.org, dhowells@redhat.com,
 joseph.qi@linux.alibaba.com, linux-cachefs@redhat.com,
 linux-fsdevel@vger.kernel.org, gerry@linux.alibaba.com,
 linux-erofs@lists.ozlabs.org
Errors-To: linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org
Sender: "Linux-erofs"
 <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>

Jeffle Xu <jefflexu@linux.alibaba.com> wrote:

> +static int erofs_fscahce_init_ctx(struct erofs_fscache_context *ctx,

fscahce => fscache?

David

