Return-Path: <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>
X-Original-To: lists+linux-erofs@lfdr.de
Delivered-To: lists+linux-erofs@lfdr.de
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2404:9400:2:0:216:3eff:fee1:b9f1])
	by mail.lfdr.de (Postfix) with ESMTPS id 5D514666003
	for <lists+linux-erofs@lfdr.de>; Wed, 11 Jan 2023 17:06:31 +0100 (CET)
Received: from boromir.ozlabs.org (localhost [IPv6:::1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4NsXc45hd3z3c8M
	for <lists+linux-erofs@lfdr.de>; Thu, 12 Jan 2023 03:06:28 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org;
	dkim=fail reason="signature verification failed" (1024-bit key; unprotected) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=irmKfOND;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=irmKfOND;
	dkim-atps=neutral
X-Original-To: linux-erofs@lists.ozlabs.org
Delivered-To: linux-erofs@lists.ozlabs.org
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=redhat.com (client-ip=170.10.129.124; helo=us-smtp-delivery-124.mimecast.com; envelope-from=dhowells@redhat.com; receiver=<UNKNOWN>)
Authentication-Results: lists.ozlabs.org;
	dkim=pass (1024-bit key; unprotected) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=irmKfOND;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=irmKfOND;
	dkim-atps=neutral
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4NsXc05zZrz2xCj
	for <linux-erofs@lists.ozlabs.org>; Thu, 12 Jan 2023 03:06:23 +1100 (AEDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1673453179;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=z1BOT8mAy+WkQiTgOjzQ2w9X/QEdQS1JO0z90YIXXdk=;
	b=irmKfONDYufAt65MX/bK6SO9PcPQouBs6TOgwAK5/1ccpfi6L/tWUKG8ontn6KbFiQApk2
	W+a/zSchro1OJKgBBcaPoDwiPKFCUAvnvlSwsKirOxuQaTdwx4YRo4eIYwRqTam9jiN/Bc
	oxunSZyiY1GURxYt1aBYHMG352xOLiU=
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1673453179;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=z1BOT8mAy+WkQiTgOjzQ2w9X/QEdQS1JO0z90YIXXdk=;
	b=irmKfONDYufAt65MX/bK6SO9PcPQouBs6TOgwAK5/1ccpfi6L/tWUKG8ontn6KbFiQApk2
	W+a/zSchro1OJKgBBcaPoDwiPKFCUAvnvlSwsKirOxuQaTdwx4YRo4eIYwRqTam9jiN/Bc
	oxunSZyiY1GURxYt1aBYHMG352xOLiU=
Received: from mimecast-mx02.redhat.com (mx3-rdu2.redhat.com
 [66.187.233.73]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-259-3UZB8fl6PHyrfmyEvQ-2PA-1; Wed, 11 Jan 2023 11:06:14 -0500
X-MC-Unique: 3UZB8fl6PHyrfmyEvQ-2PA-1
Received: from smtp.corp.redhat.com (int-mx08.intmail.prod.int.rdu2.redhat.com [10.11.54.8])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mimecast-mx02.redhat.com (Postfix) with ESMTPS id CD98F1C29D43;
	Wed, 11 Jan 2023 16:06:13 +0000 (UTC)
Received: from warthog.procyon.org.uk (unknown [10.33.36.87])
	by smtp.corp.redhat.com (Postfix) with ESMTP id 5A4AEC15BA0;
	Wed, 11 Jan 2023 16:06:11 +0000 (UTC)
Organization: Red Hat UK Ltd. Registered Address: Red Hat UK Ltd, Amberley
	Place, 107-111 Peascod Street, Windsor, Berkshire, SI4 1TE, United
	Kingdom.
	Registered in England and Wales under Company Registration No. 3798903
From: David Howells <dhowells@redhat.com>
In-Reply-To: <20221226103309.953112-2-houtao@huaweicloud.com>
References: <20221226103309.953112-2-houtao@huaweicloud.com> <20221226103309.953112-1-houtao@huaweicloud.com>
To: Hou Tao <houtao@huaweicloud.com>
Subject: Re: [PATCH v2 1/2] fscache: Use wait_on_bit() to wait for the freeing of relinquished volume
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-ID: <2431837.1673453170.1@warthog.procyon.org.uk>
Date: Wed, 11 Jan 2023 16:06:10 +0000
Message-ID: <2431838.1673453170@warthog.procyon.org.uk>
X-Scanned-By: MIMEDefang 3.1 on 10.11.54.8
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
Cc: Jeff Layton <jlayton@kernel.org>, linux-kernel@vger.kernel.org, dhowells@redhat.com, linux-cachefs@redhat.com, houtao1@huawei.com, linux-erofs@lists.ozlabs.org
Errors-To: linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org
Sender: "Linux-erofs" <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>

Hou Tao <houtao@huaweicloud.com> wrote:

>  			clear_bit(FSCACHE_VOLUME_ACQUIRE_PENDING, &cursor->flags);
> +			/*
> +			 * Paired with barrier in wait_on_bit(). Check
> +			 * wake_up_bit() and waitqueue_active() for details.
> +			 */
> +			smp_mb__after_atomic();
>  			wake_up_bit(&cursor->flags, FSCACHE_VOLUME_ACQUIRE_PENDING);

What two values are you applying a partial ordering to?

David

