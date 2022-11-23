Return-Path: <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>
X-Original-To: lists+linux-erofs@lfdr.de
Delivered-To: lists+linux-erofs@lfdr.de
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	by mail.lfdr.de (Postfix) with ESMTPS id 90C7B636E29
	for <lists+linux-erofs@lfdr.de>; Thu, 24 Nov 2022 00:12:26 +0100 (CET)
Received: from boromir.ozlabs.org (localhost [IPv6:::1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4NHcN83Grqz3cL7
	for <lists+linux-erofs@lfdr.de>; Thu, 24 Nov 2022 10:12:24 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org;
	dkim=fail reason="signature verification failed" (1024-bit key; unprotected) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=fBx81h9N;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=fBx81h9N;
	dkim-atps=neutral
X-Original-To: linux-erofs@lists.ozlabs.org
Delivered-To: linux-erofs@lists.ozlabs.org
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=redhat.com (client-ip=170.10.133.124; helo=us-smtp-delivery-124.mimecast.com; envelope-from=dhowells@redhat.com; receiver=<UNKNOWN>)
Authentication-Results: lists.ozlabs.org;
	dkim=pass (1024-bit key; unprotected) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=fBx81h9N;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=fBx81h9N;
	dkim-atps=neutral
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4NHcN56VSkz2xHJ
	for <linux-erofs@lists.ozlabs.org>; Thu, 24 Nov 2022 10:12:21 +1100 (AEDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1669245138;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=TkxA1cIIATavm/iPtlXYSGrzNrGGRTB0SyxFP73JEEI=;
	b=fBx81h9NUmSiFlfJ4xC7wkhjch7KI62f6iP0u58f8d9Zz3nbXZTIkQAUkltgWwlWcEY7g0
	7o8e1n2EkHWz2LLxoBhZwds7gZ6AstRynwceGJDhfs/ZhPsEFVaBRjYPmGGt4DXjQGmBjH
	vyeN+sRmZ/KO7DTIbGnsFHFm31WB3o8=
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1669245138;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=TkxA1cIIATavm/iPtlXYSGrzNrGGRTB0SyxFP73JEEI=;
	b=fBx81h9NUmSiFlfJ4xC7wkhjch7KI62f6iP0u58f8d9Zz3nbXZTIkQAUkltgWwlWcEY7g0
	7o8e1n2EkHWz2LLxoBhZwds7gZ6AstRynwceGJDhfs/ZhPsEFVaBRjYPmGGt4DXjQGmBjH
	vyeN+sRmZ/KO7DTIbGnsFHFm31WB3o8=
Received: from mimecast-mx02.redhat.com (mx3-rdu2.redhat.com
 [66.187.233.73]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-608-WtuaIJijPBK1sk1Q4hzqrw-1; Wed, 23 Nov 2022 18:12:13 -0500
X-MC-Unique: WtuaIJijPBK1sk1Q4hzqrw-1
Received: from smtp.corp.redhat.com (int-mx07.intmail.prod.int.rdu2.redhat.com [10.11.54.7])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 9662F3C0D193;
	Wed, 23 Nov 2022 23:12:12 +0000 (UTC)
Received: from warthog.procyon.org.uk (unknown [10.33.36.14])
	by smtp.corp.redhat.com (Postfix) with ESMTP id 69F811402BDA;
	Wed, 23 Nov 2022 23:12:10 +0000 (UTC)
Organization: Red Hat UK Ltd. Registered Address: Red Hat UK Ltd, Amberley
	Place, 107-111 Peascod Street, Windsor, Berkshire, SI4 1TE, United
	Kingdom.
	Registered in England and Wales under Company Registration No. 3798903
From: David Howells <dhowells@redhat.com>
In-Reply-To: <CAHk-=wjq7gRdVUrwpQvEN1+um+hTkW8dZZATtfFS-fp9nNssRw@mail.gmail.com>
References: <CAHk-=wjq7gRdVUrwpQvEN1+um+hTkW8dZZATtfFS-fp9nNssRw@mail.gmail.com> <166924370539.1772793.13730698360771821317.stgit@warthog.procyon.org.uk>
To: Linus Torvalds <torvalds@linux-foundation.org>
Subject: Re: [PATCH v4 0/3] mm, netfs, fscache: Stop read optimisation when folio removed from pagecache
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-ID: <1774226.1669245127.1@warthog.procyon.org.uk>
Date: Wed, 23 Nov 2022 23:12:07 +0000
Message-ID: <1774227.1669245127@warthog.procyon.org.uk>
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
Cc: Shyam Prasad N <nspmangalore@gmail.com>, linux-cifs@vger.kernel.org, linux-nfs@vger.kernel.org, Rohith Surabattula <rohiths.msft@gmail.com>, linux-fsdevel@vger.kernel.org, Dave Wysochanski <dwysocha@redhat.com>, ceph-devel@vger.kernel.org, linux-kernel@vger.kernel.org, Matthew Wilcox <willy@infradead.org>, linux-afs@lists.infradead.org, dhowells@redhat.com, linux-mm@kvack.org, linux-cachefs@redhat.com, Steve French <sfrench@samba.org>, v9fs-developer@lists.sourceforge.net, Ilya Dryomov <idryomov@gmail.com>, linux-erofs@lists.ozlabs.org, Dominique Martinet <asmadeus@codewreck.org>, Jeff Layton <jlayton@kernel.org>
Errors-To: linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org
Sender: "Linux-erofs" <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>

Linus Torvalds <torvalds@linux-foundation.org> wrote:

> Well, the patches look superficially cleaner to me, at least. That
> "doesn't seem to be necessary" makes me a bit worried,

I meant that it doesn't cause a splat to appear in dmesg saying that an
unexpected flag was left set.

David

