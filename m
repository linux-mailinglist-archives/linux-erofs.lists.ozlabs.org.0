Return-Path: <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>
X-Original-To: lists+linux-erofs@lfdr.de
Delivered-To: lists+linux-erofs@lfdr.de
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	by mail.lfdr.de (Postfix) with ESMTPS id 6F5BE60F888
	for <lists+linux-erofs@lfdr.de>; Thu, 27 Oct 2022 15:09:34 +0200 (CEST)
Received: from boromir.ozlabs.org (localhost [IPv6:::1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4MymH01QGhz3c6D
	for <lists+linux-erofs@lfdr.de>; Fri, 28 Oct 2022 00:09:32 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org;
	dkim=fail reason="signature verification failed" (1024-bit key; unprotected) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=Nby+Xn8V;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=Nby+Xn8V;
	dkim-atps=neutral
X-Original-To: linux-erofs@lists.ozlabs.org
Delivered-To: linux-erofs@lists.ozlabs.org
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=redhat.com (client-ip=170.10.129.124; helo=us-smtp-delivery-124.mimecast.com; envelope-from=dhowells@redhat.com; receiver=<UNKNOWN>)
Authentication-Results: lists.ozlabs.org;
	dkim=pass (1024-bit key; unprotected) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=Nby+Xn8V;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=Nby+Xn8V;
	dkim-atps=neutral
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4MymGw5LJlz2xgG
	for <linux-erofs@lists.ozlabs.org>; Fri, 28 Oct 2022 00:09:28 +1100 (AEDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1666876166;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=zAaHAd6Stt887euCzmeFj9gNHsGngNEgRN3GcxeQNb8=;
	b=Nby+Xn8VQ42pCc0K14qFfs9YIOam5t3uOVjxL6Dr2L/sZDsCBNofNFDgfIwIoAZX2mYt4i
	EHZN5C773zqVwIsk6nSvi60BcdPYWrMd6DIcI9TksyxQeyoKA/JPC0OkHNGG4POZgysR9w
	2TOd9K1TJrKOf+NTDIkh1SoGSOZoTI8=
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1666876166;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=zAaHAd6Stt887euCzmeFj9gNHsGngNEgRN3GcxeQNb8=;
	b=Nby+Xn8VQ42pCc0K14qFfs9YIOam5t3uOVjxL6Dr2L/sZDsCBNofNFDgfIwIoAZX2mYt4i
	EHZN5C773zqVwIsk6nSvi60BcdPYWrMd6DIcI9TksyxQeyoKA/JPC0OkHNGG4POZgysR9w
	2TOd9K1TJrKOf+NTDIkh1SoGSOZoTI8=
Received: from mimecast-mx02.redhat.com (mx3-rdu2.redhat.com
 [66.187.233.73]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-159-YWNKULRXP3KrVVVoXhw6_Q-1; Thu, 27 Oct 2022 09:09:23 -0400
X-MC-Unique: YWNKULRXP3KrVVVoXhw6_Q-1
Received: from smtp.corp.redhat.com (int-mx10.intmail.prod.int.rdu2.redhat.com [10.11.54.10])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 4DDBA296A60E;
	Thu, 27 Oct 2022 13:09:23 +0000 (UTC)
Received: from warthog.procyon.org.uk (unknown [10.33.36.73])
	by smtp.corp.redhat.com (Postfix) with ESMTP id 296CA492B07;
	Thu, 27 Oct 2022 13:09:22 +0000 (UTC)
Organization: Red Hat UK Ltd. Registered Address: Red Hat UK Ltd, Amberley
	Place, 107-111 Peascod Street, Windsor, Berkshire, SI4 1TE, United
	Kingdom.
	Registered in England and Wales under Company Registration No. 3798903
From: David Howells <dhowells@redhat.com>
In-Reply-To: <20221027083547.46933-5-jefflexu@linux.alibaba.com>
References: <20221027083547.46933-5-jefflexu@linux.alibaba.com> <20221027083547.46933-1-jefflexu@linux.alibaba.com>
To: Jingbo Xu <jefflexu@linux.alibaba.com>
Subject: Re: [PATCH 4/9] fscache,netfs: rename netfs_read_from_hole as fscache_read_from_hole
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-ID: <3306472.1666876161.1@warthog.procyon.org.uk>
Date: Thu, 27 Oct 2022 14:09:21 +0100
Message-ID: <3306473.1666876161@warthog.procyon.org.uk>
X-Scanned-By: MIMEDefang 3.1 on 10.11.54.10
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

> Rename netfs_read_from_hole as fscache_read_from_hole to make raw
> fscache APIs more neutral independent on libnetfs.

Please don't.  This is a netfslib feature that's used by fscache.

David

