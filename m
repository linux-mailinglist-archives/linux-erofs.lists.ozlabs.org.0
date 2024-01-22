Return-Path: <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>
X-Original-To: lists+linux-erofs@lfdr.de
Delivered-To: lists+linux-erofs@lfdr.de
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	by mail.lfdr.de (Postfix) with ESMTPS id 773DD836D04
	for <lists+linux-erofs@lfdr.de>; Mon, 22 Jan 2024 18:22:53 +0100 (CET)
Authentication-Results: lists.ozlabs.org;
	dkim=fail reason="signature verification failed" (1024-bit key; unprotected) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=H5GVireh;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=H5GVireh;
	dkim-atps=neutral
Received: from boromir.ozlabs.org (localhost [IPv6:::1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4TJcVg2vl1z3c1J
	for <lists+linux-erofs@lfdr.de>; Tue, 23 Jan 2024 04:22:51 +1100 (AEDT)
X-Original-To: linux-erofs@lists.ozlabs.org
Delivered-To: linux-erofs@lists.ozlabs.org
Authentication-Results: lists.ozlabs.org;
	dkim=pass (1024-bit key; unprotected) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=H5GVireh;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=H5GVireh;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=redhat.com (client-ip=170.10.133.124; helo=us-smtp-delivery-124.mimecast.com; envelope-from=dhowells@redhat.com; receiver=lists.ozlabs.org)
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4TJcVY2ShJz3brc
	for <linux-erofs@lists.ozlabs.org>; Tue, 23 Jan 2024 04:22:44 +1100 (AEDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1705944161;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=dyL8HkrfuDx15VmmUYeIG1cK/wCgWeV9TZeHPttzNv8=;
	b=H5GVirehFLsGytGLj+29H3kb2H9ssTZye+3Hn6Zfl0fFST7uwEJH5yqWaxoXKgD6JJF5gt
	bLr5XcB7PJPOqf/zlNcXXWv9V9JZif4z09sCPkeYiqehnFi/hIneMbVKpSJnwFRV1J1gwI
	J+i05owX/pvt4QyGKCe5wkokXJo8fIw=
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1705944161;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=dyL8HkrfuDx15VmmUYeIG1cK/wCgWeV9TZeHPttzNv8=;
	b=H5GVirehFLsGytGLj+29H3kb2H9ssTZye+3Hn6Zfl0fFST7uwEJH5yqWaxoXKgD6JJF5gt
	bLr5XcB7PJPOqf/zlNcXXWv9V9JZif4z09sCPkeYiqehnFi/hIneMbVKpSJnwFRV1J1gwI
	J+i05owX/pvt4QyGKCe5wkokXJo8fIw=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-692-HhQdjMHnNSCeJf9HAxnqqg-1; Mon, 22 Jan 2024 12:22:35 -0500
X-MC-Unique: HhQdjMHnNSCeJf9HAxnqqg-1
Received: from smtp.corp.redhat.com (int-mx08.intmail.prod.int.rdu2.redhat.com [10.11.54.8])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mimecast-mx02.redhat.com (Postfix) with ESMTPS id A236285A597;
	Mon, 22 Jan 2024 17:22:34 +0000 (UTC)
Received: from warthog.procyon.org.uk (unknown [10.42.28.67])
	by smtp.corp.redhat.com (Postfix) with ESMTP id B2C10C0FDCA;
	Mon, 22 Jan 2024 17:22:32 +0000 (UTC)
Organization: Red Hat UK Ltd. Registered Address: Red Hat UK Ltd, Amberley
	Place, 107-111 Peascod Street, Windsor, Berkshire, SI4 1TE, United
	Kingdom.
	Registered in England and Wales under Company Registration No. 3798903
From: David Howells <dhowells@redhat.com>
In-Reply-To: <c9091df8de30a2c79364698b72e67834d0ac87c7.camel@kernel.org>
References: <c9091df8de30a2c79364698b72e67834d0ac87c7.camel@kernel.org> <20240122123845.3822570-1-dhowells@redhat.com> <20240122123845.3822570-2-dhowells@redhat.com>
To: Jeff Layton <jlayton@kernel.org>
Subject: Re: [PATCH 01/10] netfs: Don't use certain internal folio_*() functions
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-ID: <3931925.1705944151.1@warthog.procyon.org.uk>
Date: Mon, 22 Jan 2024 17:22:32 +0000
Message-ID: <3931926.1705944152@warthog.procyon.org.uk>
X-Scanned-By: MIMEDefang 3.4.1 on 10.11.54.8
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
Cc: linux-cifs@vger.kernel.org, linux-nfs@vger.kernel.org, v9fs@lists.linux.dev, linux-kernel@vger.kernel.org, Matthew Wilcox <willy@infradead.org>, dhowells@redhat.com, linux-mm@kvack.org, linux-cachefs@redhat.com, linux-fsdevel@vger.kernel.org, netfs@lists.linux.dev, ceph-devel@vger.kernel.org, linux-erofs@lists.ozlabs.org, linux-afs@lists.infradead.org, Christian Brauner <christian@brauner.io>
Errors-To: linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org
Sender: "Linux-erofs" <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>

Jeff Layton <jlayton@kernel.org> wrote:

> > Filesystems should not be using folio->index not folio_index(folio) and
> 
> I think you mean "should be" here.

Ach.  I forgot to update the patch descriptions!

David

