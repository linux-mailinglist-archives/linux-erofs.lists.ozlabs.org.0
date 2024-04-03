Return-Path: <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>
X-Original-To: lists+linux-erofs@lfdr.de
Delivered-To: lists+linux-erofs@lfdr.de
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	by mail.lfdr.de (Postfix) with ESMTPS id E752C896BBF
	for <lists+linux-erofs@lfdr.de>; Wed,  3 Apr 2024 12:11:28 +0200 (CEST)
Authentication-Results: lists.ozlabs.org;
	dkim=fail reason="signature verification failed" (1024-bit key; unprotected) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=OLh44G5F;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=PRoW4T+b;
	dkim-atps=neutral
Received: from boromir.ozlabs.org (localhost [IPv6:::1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4V8gWf55WMz3vn5
	for <lists+linux-erofs@lfdr.de>; Wed,  3 Apr 2024 21:11:26 +1100 (AEDT)
X-Original-To: linux-erofs@lists.ozlabs.org
Delivered-To: linux-erofs@lists.ozlabs.org
Authentication-Results: lists.ozlabs.org;
	dkim=pass (1024-bit key; unprotected) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=OLh44G5F;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=PRoW4T+b;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=redhat.com (client-ip=170.10.129.124; helo=us-smtp-delivery-124.mimecast.com; envelope-from=dhowells@redhat.com; receiver=lists.ozlabs.org)
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4V8gWZ6Hpgz3vfs
	for <linux-erofs@lists.ozlabs.org>; Wed,  3 Apr 2024 21:11:21 +1100 (AEDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1712139077;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=q10XbPWbwPAYz3tVe+780L2sWGchjiaH8ntssWQEh20=;
	b=OLh44G5FerWj7Uqjqc+NH28vrsv3uheQ10/xIzc+48r+2YxeKSwAvrdY3J0SiKLLTGkoj6
	6e2xfHg2pb+K/vWBDWkb2iprz/5HhXMk25FB5j+3C8WT3MwEPRHiyAbver8CM0Og76iaIi
	5JNT8W0eb4dBWrmqNAvUulHBfpvfGms=
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1712139078;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=q10XbPWbwPAYz3tVe+780L2sWGchjiaH8ntssWQEh20=;
	b=PRoW4T+bI+hd+yrOvE8dyb6/BQQ/G7YKn6yHhb0YT0RWe43XKbH4c0yhCHVYruAhC+isES
	B2A1wQlmkFumaYX2WWzJ3BTHYrZ9qfI1f9gHzryST+uR8O2p77D/WQ875T/3ka26nGcqHM
	uFDHPnWBiT5p/twJVdTAjRm9bfI5MlQ=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-377-n6tZ6td_NZGxPdmOiGxErA-1; Wed, 03 Apr 2024 06:11:13 -0400
X-MC-Unique: n6tZ6td_NZGxPdmOiGxErA-1
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.rdu2.redhat.com [10.11.54.2])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mimecast-mx02.redhat.com (Postfix) with ESMTPS id AD06C185A784;
	Wed,  3 Apr 2024 10:11:11 +0000 (UTC)
Received: from warthog.procyon.org.uk (unknown [10.42.28.146])
	by smtp.corp.redhat.com (Postfix) with ESMTP id 51AC140C6CB3;
	Wed,  3 Apr 2024 10:11:08 +0000 (UTC)
Organization: Red Hat UK Ltd. Registered Address: Red Hat UK Ltd, Amberley
	Place, 107-111 Peascod Street, Windsor, Berkshire, SI4 1TE, United
	Kingdom.
	Registered in England and Wales under Company Registration No. 3798903
From: David Howells <dhowells@redhat.com>
In-Reply-To: <20240403085918.GA1178@lst.de>
References: <20240403085918.GA1178@lst.de> <20240328163424.2781320-1-dhowells@redhat.com> <20240328163424.2781320-16-dhowells@redhat.com>
To: Christoph Hellwig <hch@lst.de>
Subject: Re: [PATCH 15/26] mm: Export writeback_iter()
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-ID: <3235933.1712139047.1@warthog.procyon.org.uk>
Date: Wed, 03 Apr 2024 11:10:47 +0100
Message-ID: <3235934.1712139047@warthog.procyon.org.uk>
X-Scanned-By: MIMEDefang 3.4.1 on 10.11.54.2
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
Cc: Dominique Martinet <asmadeus@codewreck.org>, dhowells@redhat.com, linux-mm@kvack.org, Marc Dionne <marc.dionne@auristor.com>, linux-afs@lists.infradead.org, Paulo Alcantara <pc@manguebit.com>, linux-cifs@vger.kernel.org, Matthew Wilcox <willy@infradead.org>, Steve French <smfrench@gmail.com>, linux-cachefs@redhat.com, Gao Xiang <hsiangkao@linux.alibaba.com>, Ilya Dryomov <idryomov@gmail.com>, Shyam Prasad N <sprasad@microsoft.com>, Tom Talpey <tom@talpey.com>, ceph-devel@vger.kernel.org, Eric Van Hensbergen <ericvh@kernel.org>, Christian Brauner <christian@brauner.io>, linux-nfs@vger.kernel.org, netdev@vger.kernel.org, v9fs@lists.linux.dev, Jeff Layton <jlayton@kernel.org>, linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org, netfs@lists.linux.dev, linux-erofs@lists.ozlabs.org
Errors-To: linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org
Sender: "Linux-erofs" <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>

Christoph Hellwig <hch@lst.de> wrote:

> On Thu, Mar 28, 2024 at 04:34:07PM +0000, David Howells wrote:
> > Export writeback_iter() so that it can be used by netfslib as a module.
> 
> EXPORT_SYMBOL_GPL, please.

That depends.  You put a comment on write_cache_pages() saying that people
should use writeback_iter() instead.  w_c_p() is not marked GPL.  Is it your
intention to get rid of it?

David

