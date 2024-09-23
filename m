Return-Path: <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>
X-Original-To: lists+linux-erofs@lfdr.de
Delivered-To: lists+linux-erofs@lfdr.de
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2404:9400:2:0:216:3eff:fee1:b9f1])
	by mail.lfdr.de (Postfix) with ESMTPS id 3C9BB983A28
	for <lists+linux-erofs@lfdr.de>; Tue, 24 Sep 2024 01:12:20 +0200 (CEST)
Received: from boromir.ozlabs.org (localhost [IPv6:::1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4XCHpq0Nw6z2yVj
	for <lists+linux-erofs@lfdr.de>; Tue, 24 Sep 2024 08:34:11 +1000 (AEST)
X-Original-To: linux-erofs@lists.ozlabs.org
Delivered-To: linux-erofs@lists.ozlabs.org
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip=170.10.133.124
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1727130848;
	cv=none; b=bu+VrHHEYrmTNEWWrUu/4IG5+t82+7M4p4nYU2LqIL0Jnw31L/OendZu8w4fByTLCkI48Lf4FfKsvPKGH74u0kmTmfN3IkBbFqHgHVWhQWY2F8PpMugz7LyAF5no93T5I2mPYuus+WKa2pDcOwWk9K5LiRmysaoG+NqfSZT2VRaaooJkfMM8AKNSUCunI7r9mfHP1qh3eslFwjVXIVsD+cn5hBBf50SCrfiddIj654zOvsoE9LoD5VSJ8XzHOcV5RixrKARnK7dwd0VYKI2EoqbR/qblykkt9vjIBWuTTPJT0FWfHu8nIx8wYUZSefIdg309OJuqje0idbqjUePmOA==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1727130848; c=relaxed/relaxed;
	bh=jTkM6enpKsq/HPP1aWcd0UHOFBRJuXPpDuW+0fAnEgU=;
	h=From:In-Reply-To:References:To:Cc:Subject:MIME-Version:
	 Content-Type:Date:Message-ID; b=HBXXnMPNyR03CtLuD2b8Lkmk1ntZ+sKzLkuE6Qm/Id8hWAAg52uy4ugmw/MdWniB4FZl0QQ7jCCul6TszFCrw0Tb7/+PgOWF+4KdC1+6Qz5r7w17+sbMC3wg7ajh111EolMePl2F3p3HslRLjhm6mW+FV7KF3u5jk9IlLita9XADZZPHFuBICqZ5jmvros85Wt66JRwQS4hAv1IoZ/xiAXMTcIzE3lJWXyeT+eTmPxNEb3ViBZRCm4QLXXPvNRDV+zWo9aMrXZXmbL7h1b9Zv7omeWXklQ2GmsmcJBce5L5B85vfbBcvDZ0PBI010tzLDajAEiNLHhPb19TLeoitvw==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=redhat.com; dkim=pass (1024-bit key; unprotected) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=Z5CvFWss; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=Z5CvFWss; dkim-atps=neutral; spf=pass (client-ip=170.10.133.124; helo=us-smtp-delivery-124.mimecast.com; envelope-from=dhowells@redhat.com; receiver=lists.ozlabs.org) smtp.mailfrom=redhat.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (1024-bit key; unprotected) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=Z5CvFWss;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=Z5CvFWss;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=redhat.com (client-ip=170.10.133.124; helo=us-smtp-delivery-124.mimecast.com; envelope-from=dhowells@redhat.com; receiver=lists.ozlabs.org)
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4XCHpm0txqz2xfR
	for <linux-erofs@lists.ozlabs.org>; Tue, 24 Sep 2024 08:34:06 +1000 (AEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1727130843;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=jTkM6enpKsq/HPP1aWcd0UHOFBRJuXPpDuW+0fAnEgU=;
	b=Z5CvFWss9j6B05z0BEsqp4E1psxeghmWtxMEwvG1fyWj+B41JYv5Q8/x5PqWVdd60qIcm/
	KgPDB1Ov2oB4dxLwVvjIUU6aXCX/TioCTk2y6tCaqwqCcKwmBLcD8R71qeOV/sHPIfKVwo
	P6mPCdapZbgUSWzYOydgjwmoZEzvdrc=
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1727130843;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=jTkM6enpKsq/HPP1aWcd0UHOFBRJuXPpDuW+0fAnEgU=;
	b=Z5CvFWss9j6B05z0BEsqp4E1psxeghmWtxMEwvG1fyWj+B41JYv5Q8/x5PqWVdd60qIcm/
	KgPDB1Ov2oB4dxLwVvjIUU6aXCX/TioCTk2y6tCaqwqCcKwmBLcD8R71qeOV/sHPIfKVwo
	P6mPCdapZbgUSWzYOydgjwmoZEzvdrc=
Received: from mx-prod-mc-02.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-178-vMyy1_3ZP0WVkfaK3Q6znA-1; Mon,
 23 Sep 2024 18:34:01 -0400
X-MC-Unique: vMyy1_3ZP0WVkfaK3Q6znA-1
Received: from mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com (unknown [10.30.177.12])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-02.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 2BEF4190C4DA;
	Mon, 23 Sep 2024 22:33:58 +0000 (UTC)
Received: from warthog.procyon.org.uk (unknown [10.42.28.145])
	by mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id 8F15319560AA;
	Mon, 23 Sep 2024 22:33:51 +0000 (UTC)
Organization: Red Hat UK Ltd. Registered Address: Red Hat UK Ltd, Amberley
	Place, 107-111 Peascod Street, Windsor, Berkshire, SI4 1TE, United
	Kingdom.
	Registered in England and Wales under Company Registration No. 3798903
From: David Howells <dhowells@redhat.com>
In-Reply-To: <0f6afef57196cb308aa90be5b06a64793aa24682.camel@gmail.com>
References: <0f6afef57196cb308aa90be5b06a64793aa24682.camel@gmail.com> <20240814203850.2240469-20-dhowells@redhat.com> <20240923183432.1876750-1-chantr4@gmail.com> <670794146059f85a30efd7cf9d6650375d987077.camel@gmail.com>
To: Eduard Zingerman <eddyz87@gmail.com>
Subject: Re: [PATCH v2 19/25] netfs: Speed up buffered reading
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-ID: <961633.1727130830.1@warthog.procyon.org.uk>
Date: Mon, 23 Sep 2024 23:33:50 +0100
Message-ID: <961634.1727130830@warthog.procyon.org.uk>
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.12
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
Cc: asmadeus@codewreck.org, dhowells@redhat.com, linux-mm@kvack.org, marc.dionne@auristor.com, linux-afs@lists.infradead.org, pc@manguebit.com, linux-cifs@vger.kernel.org, Manu Bretelle <chantr4@gmail.com>, willy@infradead.org, smfrench@gmail.com, hsiangkao@linux.alibaba.com, idryomov@gmail.com, sprasad@microsoft.com, tom@talpey.com, ceph-devel@vger.kernel.org, ericvh@kernel.org, christian@brauner.io, linux-nfs@vger.kernel.org, netdev@vger.kernel.org, v9fs@lists.linux.dev, jlayton@kernel.org, linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org, netfs@lists.linux.dev, linux-erofs@lists.ozlabs.org
Errors-To: linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org
Sender: "Linux-erofs" <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>

Eduard Zingerman <eddyz87@gmail.com> wrote:

> - null-ptr-deref is triggered by access to page->pcp_list.next
>   when list_del() is called from page_alloc.c:__rmqueue_pcplist(),

Can you tell me what the upstream commit ID of your kernel is?  (before any
patches are stacked on it)

If you can modify your kernel, can you find the following in fs/netfs/:

buffered_read.c:127:			new = kmalloc(sizeof(*new), GFP_NOFS);
buffered_read.c:353:	folioq = kmalloc(sizeof(*folioq), GFP_KERNEL);
buffered_read.c:458:	folioq = kmalloc(sizeof(*folioq), GFP_KERNEL);
misc.c:25:		tail = kmalloc(sizeof(*tail), GFP_NOFS);

and change the kmalloc to kzalloc?

David

