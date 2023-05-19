Return-Path: <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>
X-Original-To: lists+linux-erofs@lfdr.de
Delivered-To: lists+linux-erofs@lfdr.de
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2404:9400:2:0:216:3eff:fee1:b9f1])
	by mail.lfdr.de (Postfix) with ESMTPS id DD7747091FE
	for <lists+linux-erofs@lfdr.de>; Fri, 19 May 2023 10:49:08 +0200 (CEST)
Received: from boromir.ozlabs.org (localhost [IPv6:::1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4QN0rL4rDnz3fBm
	for <lists+linux-erofs@lfdr.de>; Fri, 19 May 2023 18:49:06 +1000 (AEST)
Authentication-Results: lists.ozlabs.org;
	dkim=fail reason="signature verification failed" (1024-bit key; unprotected) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=GQOJc/91;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=L1COC9mD;
	dkim-atps=neutral
X-Original-To: linux-erofs@lists.ozlabs.org
Delivered-To: linux-erofs@lists.ozlabs.org
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=redhat.com (client-ip=170.10.133.124; helo=us-smtp-delivery-124.mimecast.com; envelope-from=dhowells@redhat.com; receiver=<UNKNOWN>)
Authentication-Results: lists.ozlabs.org;
	dkim=pass (1024-bit key; unprotected) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=GQOJc/91;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=L1COC9mD;
	dkim-atps=neutral
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4QN0rF1ckDz3f40
	for <linux-erofs@lists.ozlabs.org>; Fri, 19 May 2023 18:48:59 +1000 (AEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1684486135;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=NFfz1Qefawb0lyg57CVn7ptvHTdohZyit/vKaHZw8LE=;
	b=GQOJc/91WIiP2p5sn6uHG6wy0zEY35fAuX26arFBIe5Gn071/G/cbljjV4Xi4LmF9vuEva
	+zA5PX6S7Y3oyn2B6VqZ5Okk5rNRTTI6/mRire0aq9k1ugi1e3c4X5dOen7noTJFHOaEbV
	fo+/Di+5Dbvp2BxwZelRxK6isgN8Zqo=
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1684486136;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=NFfz1Qefawb0lyg57CVn7ptvHTdohZyit/vKaHZw8LE=;
	b=L1COC9mDC5DFcm0UpxucwzslltiIs8rvCD1RZzAm5CW3fDtkQIkQNHchElmXpk4d6F7ucB
	psVbA20hZ4NpYpvWvFgjsKwh60HCSOEYWJEOLyYri1e1wg+e1DMf76sQRYHojAgUokDIQ0
	b9ndlG9P4koftDxEurS0LNJn6Y4LNDI=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-176-PtzYX2HQN1GxCR941SWFpg-1; Fri, 19 May 2023 04:48:51 -0400
X-MC-Unique: PtzYX2HQN1GxCR941SWFpg-1
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.rdu2.redhat.com [10.11.54.4])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 485DC80120A;
	Fri, 19 May 2023 08:48:50 +0000 (UTC)
Received: from warthog.procyon.org.uk (unknown [10.42.28.221])
	by smtp.corp.redhat.com (Postfix) with ESMTP id 9E8842026D49;
	Fri, 19 May 2023 08:48:47 +0000 (UTC)
Organization: Red Hat UK Ltd. Registered Address: Red Hat UK Ltd, Amberley
	Place, 107-111 Peascod Street, Windsor, Berkshire, SI4 1TE, United
	Kingdom.
	Registered in England and Wales under Company Registration No. 3798903
From: David Howells <dhowells@redhat.com>
In-Reply-To: <ZGcu6GVxOgYfy8x9@infradead.org>
References: <ZGcu6GVxOgYfy8x9@infradead.org> <20230519074047.1739879-1-dhowells@redhat.com> <20230519074047.1739879-6-dhowells@redhat.com>
To: Christoph Hellwig <hch@infradead.org>
Subject: Re: [PATCH v20 05/32] splice: Make splice from a DAX file use direct_splice_read()
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-ID: <1742242.1684486127.1@warthog.procyon.org.uk>
Date: Fri, 19 May 2023 09:48:47 +0100
Message-ID: <1742243.1684486127@warthog.procyon.org.uk>
X-Scanned-By: MIMEDefang 3.1 on 10.11.54.4
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
Cc: Jens Axboe <axboe@kernel.dk>, linux-block@vger.kernel.org, Hillf Danton <hdanton@sina.com>, Jan Kara <jack@suse.cz>, linux-xfs@vger.kernel.org, David Hildenbrand <david@redhat.com>, linux-erofs@lists.ozlabs.org, Linus Torvalds <torvalds@linux-foundation.org>, Jeff Layton <jlayton@kernel.org>, Christian Brauner <brauner@kernel.org>, Matthew Wilcox <willy@infradead.org>, linux-kernel@vger.kernel.org, dhowells@redhat.com, linux-mm@kvack.org, Al Viro <viro@zeniv.linux.org.uk>, Jason Gunthorpe <jgg@nvidia.com>, linux-fsdevel@vger.kernel.org, linux-ext4@vger.kernel.org, Logan Gunthorpe <logang@deltatee.com>, Christoph Hellwig <hch@lst.de>
Errors-To: linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org
Sender: "Linux-erofs" <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>

Christoph Hellwig <hch@infradead.org> wrote:

> On Fri, May 19, 2023 at 08:40:20AM +0100, David Howells wrote:
> > +#ifdef CONFIG_FS_DAX
> > +	if (IS_DAX(in->f_mapping->host))
> 
> No need for the ifdef.  IS_DAX is compile-time false if CONFIG_FS_DAX
> is not set.

Ah - it's not that IS_DAX() is conditionalised, it's that S_DAX is.  There's a
bunch of places that use CONFIG_FS_DAX blocks, but I guess that's because they
include calls to functions that are conditionalised out.

I wonder if the dax_iomap_rw() declaration in the header can have a non-DAX
fallback that returns an error and then we can get rid of some of the other
conditionalisation.

David

