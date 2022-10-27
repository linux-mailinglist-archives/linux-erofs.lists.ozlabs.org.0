Return-Path: <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>
X-Original-To: lists+linux-erofs@lfdr.de
Delivered-To: lists+linux-erofs@lfdr.de
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2404:9400:2:0:216:3eff:fee1:b9f1])
	by mail.lfdr.de (Postfix) with ESMTPS id AB6BE60F874
	for <lists+linux-erofs@lfdr.de>; Thu, 27 Oct 2022 15:07:08 +0200 (CEST)
Received: from boromir.ozlabs.org (localhost [IPv6:::1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4MymDB3R0Mz3c6D
	for <lists+linux-erofs@lfdr.de>; Fri, 28 Oct 2022 00:07:06 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org;
	dkim=fail reason="signature verification failed" (1024-bit key; unprotected) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=HrWoQsXQ;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=HrWoQsXQ;
	dkim-atps=neutral
X-Original-To: linux-erofs@lists.ozlabs.org
Delivered-To: linux-erofs@lists.ozlabs.org
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=redhat.com (client-ip=170.10.129.124; helo=us-smtp-delivery-124.mimecast.com; envelope-from=dhowells@redhat.com; receiver=<UNKNOWN>)
Authentication-Results: lists.ozlabs.org;
	dkim=pass (1024-bit key; unprotected) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=HrWoQsXQ;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=HrWoQsXQ;
	dkim-atps=neutral
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4MymD74fSlz2xgG
	for <linux-erofs@lists.ozlabs.org>; Fri, 28 Oct 2022 00:07:03 +1100 (AEDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1666876021;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=r3PAZn2NaEJsvwfB9KLdVp+yPOXbOOSHha7JwrW03m0=;
	b=HrWoQsXQ1al9Hegf0n62LWdfXZRHHXHTt34PRQpCkafJZzkA1Bvcy/Pq3NTy5C8PfPXraP
	BfVjrYGN719OuCNijLE7ips3C2zFa41pTBAk3B2nMy+twdOyJjhq7cF/vHkdbvrcTxlCJD
	zA7ftc+d2sPBzWTxUyKarQMT6j1jzwY=
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1666876021;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=r3PAZn2NaEJsvwfB9KLdVp+yPOXbOOSHha7JwrW03m0=;
	b=HrWoQsXQ1al9Hegf0n62LWdfXZRHHXHTt34PRQpCkafJZzkA1Bvcy/Pq3NTy5C8PfPXraP
	BfVjrYGN719OuCNijLE7ips3C2zFa41pTBAk3B2nMy+twdOyJjhq7cF/vHkdbvrcTxlCJD
	zA7ftc+d2sPBzWTxUyKarQMT6j1jzwY=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-427-68ld9T-nO0iJwLwj8CVLGg-1; Thu, 27 Oct 2022 09:06:56 -0400
X-MC-Unique: 68ld9T-nO0iJwLwj8CVLGg-1
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.rdu2.redhat.com [10.11.54.3])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 083C6811E67;
	Thu, 27 Oct 2022 13:06:56 +0000 (UTC)
Received: from warthog.procyon.org.uk (unknown [10.33.36.73])
	by smtp.corp.redhat.com (Postfix) with ESMTP id CD7081121325;
	Thu, 27 Oct 2022 13:06:54 +0000 (UTC)
Organization: Red Hat UK Ltd. Registered Address: Red Hat UK Ltd, Amberley
	Place, 107-111 Peascod Street, Windsor, Berkshire, SI4 1TE, United
	Kingdom.
	Registered in England and Wales under Company Registration No. 3798903
From: David Howells <dhowells@redhat.com>
In-Reply-To: <20221027083547.46933-4-jefflexu@linux.alibaba.com>
References: <20221027083547.46933-4-jefflexu@linux.alibaba.com> <20221027083547.46933-1-jefflexu@linux.alibaba.com>
To: Jingbo Xu <jefflexu@linux.alibaba.com>
Subject: Re: [PATCH 3/9] fscache,netfs: rename netfs_io_terminated_t as fscache_io_terminated_t
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-ID: <3306326.1666876014.1@warthog.procyon.org.uk>
Date: Thu, 27 Oct 2022 14:06:54 +0100
Message-ID: <3306327.1666876014@warthog.procyon.org.uk>
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
Cc: linux-cifs@vger.kernel.org, linux-nfs@vger.kernel.org, jlayton@kernel.org, linux-kernel@vger.kernel.org, dhowells@redhat.com, linux-cachefs@redhat.com, linux-fsdevel@vger.kernel.org, linux-erofs@lists.ozlabs.org, linux-afs@lists.infradead.org
Errors-To: linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org
Sender: "Linux-erofs" <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>

Jingbo Xu <jefflexu@linux.alibaba.com> wrote:

> Rename netfs_io_terminated_t as fscache_io_terminated_t to make raw
> fscache APIs more neutral independent on libnetfs.

Please don't.  This is a netfslib feature that happens to be used by fscache.

David

