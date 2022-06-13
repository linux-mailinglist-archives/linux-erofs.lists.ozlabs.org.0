Return-Path: <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>
X-Original-To: lists+linux-erofs@lfdr.de
Delivered-To: lists+linux-erofs@lfdr.de
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	by mail.lfdr.de (Postfix) with ESMTPS id CB4BA548311
	for <lists+linux-erofs@lfdr.de>; Mon, 13 Jun 2022 11:19:39 +0200 (CEST)
Received: from boromir.ozlabs.org (localhost [IPv6:::1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4LM5cT5Wdrz3brp
	for <lists+linux-erofs@lfdr.de>; Mon, 13 Jun 2022 19:19:37 +1000 (AEST)
Authentication-Results: lists.ozlabs.org;
	dkim=fail reason="signature verification failed" (1024-bit key; unprotected) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=hGkPUOzC;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=hGkPUOzC;
	dkim-atps=neutral
X-Original-To: linux-erofs@lists.ozlabs.org
Delivered-To: linux-erofs@lists.ozlabs.org
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=redhat.com (client-ip=170.10.129.124; helo=us-smtp-delivery-124.mimecast.com; envelope-from=dhowells@redhat.com; receiver=<UNKNOWN>)
Authentication-Results: lists.ozlabs.org;
	dkim=pass (1024-bit key; unprotected) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=hGkPUOzC;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=hGkPUOzC;
	dkim-atps=neutral
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4LM5cP6gBCz2xn8
	for <linux-erofs@lists.ozlabs.org>; Mon, 13 Jun 2022 19:19:32 +1000 (AEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1655111968;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=w+/GwuuQGFS111woXNsLKjQljVwtMltJeO1V2zF9Vjo=;
	b=hGkPUOzCZMlvJ4sqDuUJIlTyxGwAbARH9361qG7qHdS8SfcqsfOWccDehqOYw68bVClzFN
	OorKoMiIuS94w2Mv4YCdnLyHYHRg6WzxL971A1c/c/MRlPPJymTmkVJJN9a/LCSRG01nV1
	WbUZWtwPTC7LUZdtJrGWV6mTsaw9hwM=
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1655111968;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=w+/GwuuQGFS111woXNsLKjQljVwtMltJeO1V2zF9Vjo=;
	b=hGkPUOzCZMlvJ4sqDuUJIlTyxGwAbARH9361qG7qHdS8SfcqsfOWccDehqOYw68bVClzFN
	OorKoMiIuS94w2Mv4YCdnLyHYHRg6WzxL971A1c/c/MRlPPJymTmkVJJN9a/LCSRG01nV1
	WbUZWtwPTC7LUZdtJrGWV6mTsaw9hwM=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-619-t37ddbngOHOr1NtMTjiYhg-1; Mon, 13 Jun 2022 05:19:21 -0400
X-MC-Unique: t37ddbngOHOr1NtMTjiYhg-1
Received: from smtp.corp.redhat.com (int-mx09.intmail.prod.int.rdu2.redhat.com [10.11.54.9])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 2B90A101E9BE;
	Mon, 13 Jun 2022 09:19:21 +0000 (UTC)
Received: from warthog.procyon.org.uk (unknown [10.33.36.62])
	by smtp.corp.redhat.com (Postfix) with ESMTP id 201EC492CA2;
	Mon, 13 Jun 2022 09:19:19 +0000 (UTC)
Organization: Red Hat UK Ltd. Registered Address: Red Hat UK Ltd, Amberley
	Place, 107-111 Peascod Street, Windsor, Berkshire, SI4 1TE, United
	Kingdom.
	Registered in England and Wales under Company Registration No. 3798903
From: David Howells <dhowells@redhat.com>
In-Reply-To: <YqSQ++8UnEW0AJ2y@zeniv-ca.linux.org.uk>
References: <YqSQ++8UnEW0AJ2y@zeniv-ca.linux.org.uk> <YqRyL2sIqQNDfky2@debian> <YqSGv6uaZzLxKfmG@zeniv-ca.linux.org.uk> <YqSMmC/UuQpXdxtR@zeniv-ca.linux.org.uk>
To: Al Viro <viro@zeniv.linux.org.uk>
Subject: Re: mainline build failure due to 6c77676645ad ("iov_iter: Fix iter_xarray_get_pages{,_alloc}()")
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-ID: <1075695.1655111958.1@warthog.procyon.org.uk>
Date: Mon, 13 Jun 2022 10:19:18 +0100
Message-ID: <1075696.1655111958@warthog.procyon.org.uk>
X-Scanned-By: MIMEDefang 2.85 on 10.11.54.9
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
Cc: Linus Torvalds <torvalds@linux-foundation.org>, Dominique Martinet <asmadeus@codewreck.org>, linux-kernel@vger.kernel.org, Sudip Mukherjee <sudipm.mukherjee@gmail.com>, dhowells@redhat.com, linux-cachefs@redhat.com, linux-fsdevel@vger.kernel.org, v9fs-developer@lists.sourceforge.net, linux-erofs@lists.ozlabs.org, linux-afs@lists.infradead.org, devel@lists.orangefs.org, Mike Marshall <hubcap@omnibond.com>
Errors-To: linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org
Sender: "Linux-erofs" <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>

Al Viro <viro@zeniv.linux.org.uk> wrote:

> The reason we can't overflow on multiplication there, BTW, is that we have
> nr <= count, and count has come from weirdly open-coded
> 	DIV_ROUND_UP(size + offset, PAGE_SIZE)
> IMO we'd better make it explicit, so how about the following:
> 
> Signed-off-by: Al Viro <viro@zeniv.linux.org.uk>

It seems reasonable.

Reviewed-by: David Howells <dhowells@redhat.com>

