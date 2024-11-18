Return-Path: <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>
X-Original-To: lists+linux-erofs@lfdr.de
Delivered-To: lists+linux-erofs@lfdr.de
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	by mail.lfdr.de (Postfix) with ESMTPS id 2B02F9D1572
	for <lists+linux-erofs@lfdr.de>; Mon, 18 Nov 2024 17:35:56 +0100 (CET)
Received: from boromir.ozlabs.org (localhost [IPv6:::1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4XsYCT3Grtz3bcX
	for <lists+linux-erofs@lfdr.de>; Tue, 19 Nov 2024 03:35:49 +1100 (AEDT)
X-Original-To: linux-erofs@lists.ozlabs.org
Delivered-To: linux-erofs@lists.ozlabs.org
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip=170.10.129.124
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1731947747;
	cv=none; b=RZ57ikWSBe3kUtGTg/506hAtRNEK2cZOz/T/Y6WaY37UuQJsWu08fXktNQkPpjqvI88pcUss1PncW5yy+WP5eOr+bjnBgdDJa64PTvTmnVEWFYs0T2YsugHSzg63LkMRn/iftO9f0zFiwZCXP9tFlNjVnnAiIqgf/Z8Zugyzo83+jx2pfHUhPqMH30/dcaO75Bv8EW1ymHwyQjPsI73sYQy8vYW4vblE7nKTm8bP3cGfVNYvz3j0rpo/ItOAp2PBpK6mQ1+0ozdsJNoImP5u858DgM33oNNaK6I7iprumZra+6V+IPVqWNkZnzFKEmVVh6DUyIzSDTMvAQW1kJrZrQ==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1731947747; c=relaxed/relaxed;
	bh=F48vEQ6V/tDlXaOtinAU3DdgDvVmHs2S/fGlg/NOvdQ=;
	h=From:In-Reply-To:References:To:Cc:Subject:MIME-Version:
	 Content-Type:Date:Message-ID; b=V0wpM0wLDqZ/wxVe2RBLLHTd05BO0y91U3i7sT5US9S92Sd9yxyEmo2u8GfcF2mpiRwFHJ14aYhnfyETiY8EtoQfPKCD7Pj8gFYIshZvljHai1h4AB25cI5gN6QfiyEBitVp0Xz1hG7XbzXpsKMkGIjq1zRr7A3tONqvx3Z703YVdezJkPqv9+4l6hY5NzuTbnGn9x3yeXU+6PwYOTEm23oO8qhq+5dpyEk5M6nMp6IgMmjS7LY4HHgJPLRrg82Twuc7QrjprwKZM2ys7zc2oVqnyiAdLoznLqzqHo3+fC9DSTTV6BbZiATnPqEi0Um3318Q98mgmeUBGfbHItDn4w==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=redhat.com; dkim=pass (1024-bit key; unprotected) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=C+ZgNer4; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=C+ZgNer4; dkim-atps=neutral; spf=pass (client-ip=170.10.129.124; helo=us-smtp-delivery-124.mimecast.com; envelope-from=dhowells@redhat.com; receiver=lists.ozlabs.org) smtp.mailfrom=redhat.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (1024-bit key; unprotected) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=C+ZgNer4;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=C+ZgNer4;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=redhat.com (client-ip=170.10.129.124; helo=us-smtp-delivery-124.mimecast.com; envelope-from=dhowells@redhat.com; receiver=lists.ozlabs.org)
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4XsYCQ0cfNz2yWr
	for <linux-erofs@lists.ozlabs.org>; Tue, 19 Nov 2024 03:35:43 +1100 (AEDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1731947738;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=F48vEQ6V/tDlXaOtinAU3DdgDvVmHs2S/fGlg/NOvdQ=;
	b=C+ZgNer4hKOeHdJEBG/l6jXUewb3GN736uG8q4K4/NF8RzEYX/ixS5TCkMfD/cdt+Xct8Y
	MKVk2ifwKjV6qHboJL65bnLN0aow7LdWt8Hs/+sDR6naIxDDZlqlrLNacPsmA5TLIqJT62
	F0F0Cu3nbjXKcvtoR6R9kiGO9Jinitc=
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1731947738;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=F48vEQ6V/tDlXaOtinAU3DdgDvVmHs2S/fGlg/NOvdQ=;
	b=C+ZgNer4hKOeHdJEBG/l6jXUewb3GN736uG8q4K4/NF8RzEYX/ixS5TCkMfD/cdt+Xct8Y
	MKVk2ifwKjV6qHboJL65bnLN0aow7LdWt8Hs/+sDR6naIxDDZlqlrLNacPsmA5TLIqJT62
	F0F0Cu3nbjXKcvtoR6R9kiGO9Jinitc=
Received: from mx-prod-mc-02.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-351-HpCdFzANNgKaFZmQE0YgOw-1; Mon,
 18 Nov 2024 11:35:33 -0500
X-MC-Unique: HpCdFzANNgKaFZmQE0YgOw-1
X-Mimecast-MFC-AGG-ID: HpCdFzANNgKaFZmQE0YgOw
Received: from mx-prod-int-04.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-04.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.40])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-02.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id D5300197731B;
	Mon, 18 Nov 2024 16:35:28 +0000 (UTC)
Received: from warthog.procyon.org.uk (unknown [10.42.28.207])
	by mx-prod-int-04.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id 710421956054;
	Mon, 18 Nov 2024 16:35:20 +0000 (UTC)
Organization: Red Hat UK Ltd. Registered Address: Red Hat UK Ltd, Amberley
	Place, 107-111 Peascod Street, Windsor, Berkshire, SI4 1TE, United
	Kingdom.
	Registered in England and Wales under Company Registration No. 3798903
From: David Howells <dhowells@redhat.com>
In-Reply-To: <17eb79fc-ccd9-4c85-bd23-e08380825c41@ijzerbout.nl>
References: <17eb79fc-ccd9-4c85-bd23-e08380825c41@ijzerbout.nl> <20241108173236.1382366-1-dhowells@redhat.com> <20241108173236.1382366-24-dhowells@redhat.com>
To: Kees Bakker <kees@ijzerbout.nl>
Subject: Re: [PATCH v4 23/33] afs: Use netfslib for directories
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-ID: <941498.1731947719.1@warthog.procyon.org.uk>
Date: Mon, 18 Nov 2024 16:35:19 +0000
Message-ID: <941499.1731947719@warthog.procyon.org.uk>
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.40
X-Spam-Status: No, score=-0.5 required=5.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
	RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS autolearn=disabled
	version=4.0.0
X-Spam-Checker-Version: SpamAssassin 4.0.0 (2022-12-13) on lists.ozlabs.org
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
Cc: Dominique Martinet <asmadeus@codewreck.org>, dhowells@redhat.com, linux-mm@kvack.org, Marc Dionne <marc.dionne@auristor.com>, linux-afs@lists.infradead.org, Paulo Alcantara <pc@manguebit.com>, linux-cifs@vger.kernel.org, Matthew Wilcox <willy@infradead.org>, Steve French <smfrench@gmail.com>, Gao Xiang <hsiangkao@linux.alibaba.com>, Ilya Dryomov <idryomov@gmail.com>, Shyam Prasad N <sprasad@microsoft.com>, Tom Talpey <tom@talpey.com>, ceph-devel@vger.kernel.org, Eric Van Hensbergen <ericvh@kernel.org>, Christian Brauner <christian@brauner.io>, linux-nfs@vger.kernel.org, netdev@vger.kernel.org, v9fs@lists.linux.dev, Jeff Layton <jlayton@kernel.org>, linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org, netfs@lists.linux.dev, linux-erofs@lists.ozlabs.org
Errors-To: linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org
Sender: "Linux-erofs" <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>

Kees Bakker <kees@ijzerbout.nl> wrote:

> > +	iterate_folioq(&iter, iov_iter_count(&iter), dvnode, ctx,
> > +		       afs_dir_iterate_step);
> > +
> > +	if (ret == -ESTALE)
> This is dead code because `ret` is set to 0 and never changed.
> > +		afs_invalidate_dir(dvnode, afs_dir_invalid_iter_stale);

Yeah.  I posted a modification for this in response to someone else.  ESTALE
needs to be set if iterate_folioq() returns 0.

David

