Return-Path: <linux-erofs+bounces-3454-lists+linux-erofs=lfdr.de@lists.ozlabs.org>
Delivered-To: lists+linux-erofs@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id cIgBFeUlDGoIXQUAu9opvQ
	(envelope-from <linux-erofs+bounces-3454-lists+linux-erofs=lfdr.de@lists.ozlabs.org>)
	for <lists+linux-erofs@lfdr.de>; Tue, 19 May 2026 10:57:09 +0200
X-Original-To: lists+linux-erofs@lfdr.de
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2404:9400:21b9:f100::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E2EFB57AA4B
	for <lists+linux-erofs@lfdr.de>; Tue, 19 May 2026 10:57:07 +0200 (CEST)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4gKT7g5yVYz2xwH;
	Tue, 19 May 2026 18:57:03 +1000 (AEST)
X-Original-To: linux-erofs@lists.ozlabs.org
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip=170.10.129.124
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1779181023;
	cv=none; b=no1yBDbLGcKsQqgF8YQyt0AkJOI297Fwss/HQd+yTshTt4LUyeffJtleN8LqS0L1020mNjf98cQEjsS5Xk2N/AEhpYhKgywZ/ebzcs4T0xhOZIDvBmRQNV+r8dGmbpMdOqsb9+5mEW5CiSRm/9vwiz9G1mNK0TiXXSoUjaas/Geafg2e8I06M+rP0y82mFUBSXP3agLlAgtX3hMt+G17mzmt6g3KGhnK90SBDp89PRGffD70ldsazgxNYC0eOPxYV4wSfJkWeABoxBc3TyGtTzpKgYFDUs6sIo5bWNiuFsCTKunfO0sdIW0liHbiitvT33rqROvrt94a8Xt/zJdP7w==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1779181023; c=relaxed/relaxed;
	bh=6LiaT+p5JzjhgPYdEvk6JkqtTVDPOsp8ZYFdDo/6RaY=;
	h=From:In-Reply-To:References:To:Cc:Subject:MIME-Version:Date:
	 Message-ID:Content-Type; b=VJjLj1uGHJNaf40fE+Vro87W7M9q81kwwaOpJp/DSugRkplRiI2fqiSIutbBCUPClRgKkQiaXGHei0fR/b+y7l80goXRpVxRrpElrNGHCVgyxFvF1jz+E8/F6Jzl6KUHGmJ/6Dw0e0HeNzQPBBzUvPUojTLoLM8USMbHae/W8nkVm4tBF04baENLDzkbZ2JcQtEqdS2sELZi3IBQgBXaUuLMlK1lhNFYbuGYW8Ttl4JslkOGMrmE3ZUzjaH1ON0jbTduGoyIg6FTJKIZGmmyzkIvwZke1xhYPM9P0vKhPRHw3oLEu7bZ63mysS5YZiKvijeQrx8LgqbDW2hjhUOMgA==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; dkim=pass (1024-bit key; unprotected) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=MQNcpOI5; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=NZQ9bjFm; dkim-atps=neutral; spf=pass (client-ip=170.10.129.124; helo=us-smtp-delivery-124.mimecast.com; envelope-from=dhowells@redhat.com; receiver=lists.ozlabs.org) smtp.mailfrom=redhat.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (1024-bit key; unprotected) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=MQNcpOI5;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=NZQ9bjFm;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=redhat.com (client-ip=170.10.129.124; helo=us-smtp-delivery-124.mimecast.com; envelope-from=dhowells@redhat.com; receiver=lists.ozlabs.org)
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4gKT7f2Yfmz2xqv
	for <linux-erofs@lists.ozlabs.org>; Tue, 19 May 2026 18:56:59 +1000 (AEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1779181016;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=6LiaT+p5JzjhgPYdEvk6JkqtTVDPOsp8ZYFdDo/6RaY=;
	b=MQNcpOI5TXt6e9VrOCLDKOSpzgeIsb9Yj9yNWUykIIcYQwMngJ/DddSZATjUPuqx8Zy2CQ
	aMwkhGTU2nIRgdMPLlaQ//19PQeJr4jrV596PLT/CjjmZjaKlnTyXCQi/qE1gEwJAPmYVo
	3+DgAVsFTbvGycqO4HLqILHV0B3N9xc=
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1779181017;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=6LiaT+p5JzjhgPYdEvk6JkqtTVDPOsp8ZYFdDo/6RaY=;
	b=NZQ9bjFmEypPpNWCx1Voh2lBNEyau9EiEyXfTwQO7One7YByqOY4Kcg9xnYu9lxhpBNSpP
	Q0SY8vH2lfa4rln4CXaFSwJjbW1HsiS8rzgKeX36xnuY8nJODFKIEtoSqmOQWnM+asQHf9
	QBPQkFNxKOUgoierLZBjeVpipocg1WM=
Received: from mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-455-kyoVeZ09Ov2A6xqp-vQlCw-1; Tue,
 19 May 2026 04:56:50 -0400
X-MC-Unique: kyoVeZ09Ov2A6xqp-vQlCw-1
X-Mimecast-MFC-AGG-ID: kyoVeZ09Ov2A6xqp-vQlCw_1779181008
Received: from mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.111])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 5786B1956052;
	Tue, 19 May 2026 08:56:46 +0000 (UTC)
Received: from warthog.procyon.org.uk (unknown [10.44.48.33])
	by mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id 3932B1800352;
	Tue, 19 May 2026 08:56:36 +0000 (UTC)
Organization: Red Hat UK Ltd. Registered Address: Red Hat UK Ltd, Amberley
	Place, 107-111 Peascod Street, Windsor, Berkshire, SI4 1TE, United
	Kingdom.
	Registered in England and Wales under Company Registration No. 3798903
From: David Howells <dhowells@redhat.com>
In-Reply-To: <20260519091545.171c4b85@pumpkin>
References: <20260519091545.171c4b85@pumpkin> <20260518222959.488126-1-dhowells@redhat.com>
To: David Laight <david.laight.linux@gmail.com>
Cc: dhowells@redhat.com, Christian Brauner <christian@brauner.io>,
    Matthew Wilcox <willy@infradead.org>,
    Christoph Hellwig <hch@infradead.org>,
    Paulo Alcantara <pc@manguebit.org>, Jens Axboe <axboe@kernel.dk>,
    Leon Romanovsky <leon@kernel.org>, Steve French <sfrench@samba.org>,
    ChenXiaoSong <chenxiaosong@chenxiaosong.com>,
    Marc Dionne <marc.dionne@auristor.com>,
    Eric Van Hensbergen <ericvh@kernel.org>,
    Dominique Martinet <asmadeus@codewreck.org>,
    Ilya Dryomov <idryomov@gmail.com>,
    Trond Myklebust <trondmy@kernel.org>, netfs@lists.linux.dev,
    linux-afs@lists.infradead.org, linux-cifs@vger.kernel.org,
    linux-nfs@vger.kernel.org, ceph-devel@vger.kernel.org,
    v9fs@lists.linux.dev, linux-erofs@lists.ozlabs.org,
    linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 00/21] netfs: Keep track of folios in a segmented bio_vec[] chain
X-Mailing-List: linux-erofs@lists.ozlabs.org
List-Id: <linux-erofs.lists.ozlabs.org>
List-Help: <mailto:linux-erofs+help@lists.ozlabs.org>
List-Owner: <mailto:linux-erofs+owner@lists.ozlabs.org>
List-Post: <mailto:linux-erofs@lists.ozlabs.org>
List-Subscribe: <mailto:linux-erofs+subscribe@lists.ozlabs.org>,
  <mailto:linux-erofs+subscribe-digest@lists.ozlabs.org>,
  <mailto:linux-erofs+subscribe-nomail@lists.ozlabs.org>
List-Unsubscribe: <mailto:linux-erofs+unsubscribe@lists.ozlabs.org>
Precedence: list
MIME-Version: 1.0
Date: Tue, 19 May 2026 09:56:35 +0100
Message-ID: <586308.1779180995@warthog.procyon.org.uk>
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.111
X-Mimecast-MFC-PROC-ID: hvoXvbpFY4DeJX2ubvfkuvZJ-w0jhCTZ90OvaNt0uhk_1779181008
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset="us-ascii"
Content-ID: <586307.1779180995.1@warthog.procyon.org.uk>
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=2.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
	RCVD_IN_MSPIKE_H4,RCVD_IN_MSPIKE_WL,RCVD_IN_SBL_CSS,SPF_HELO_PASS,
	SPF_PASS autolearn=disabled version=4.0.1
X-Spam-Level: **
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-25) on lists.ozlabs.org
X-Spamd-Result: default: False [-0.70 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[lists.ozlabs.org:s=201707:i=1];
	DMARC_POLICY_ALLOW(-0.50)[redhat.com,quarantine];
	R_DKIM_ALLOW(-0.20)[redhat.com:s=mimecast20190719];
	R_SPF_ALLOW(-0.20)[+ip6:2404:9400:21b9:f100::1];
	MAILLIST(-0.19)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-3454-lists,linux-erofs=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	FREEMAIL_TO(0.00)[gmail.com];
	FORGED_SENDER(0.00)[dhowells@redhat.com,linux-erofs@lists.ozlabs.org];
	RCPT_COUNT_TWELVE(0.00)[24];
	FORGED_RECIPIENTS(0.00)[m:david.laight.linux@gmail.com,m:dhowells@redhat.com,m:christian@brauner.io,m:willy@infradead.org,m:hch@infradead.org,m:pc@manguebit.org,m:axboe@kernel.dk,m:leon@kernel.org,m:sfrench@samba.org,m:chenxiaosong@chenxiaosong.com,m:marc.dionne@auristor.com,m:ericvh@kernel.org,m:asmadeus@codewreck.org,m:idryomov@gmail.com,m:trondmy@kernel.org,m:netfs@lists.linux.dev,m:linux-afs@lists.infradead.org,m:linux-cifs@vger.kernel.org,m:linux-nfs@vger.kernel.org,m:ceph-devel@vger.kernel.org,m:v9fs@lists.linux.dev,m:linux-erofs@lists.ozlabs.org,m:linux-fsdevel@vger.kernel.org,m:linux-kernel@vger.kernel.org,m:davidlaightlinux@gmail.com,s:lists@lfdr.de];
	MIME_TRACE(0.00)[0:+];
	HAS_ORG_HEADER(0.00)[];
	FORWARDED(0.00)[linux-erofs@lists.ozlabs.org];
	FREEMAIL_CC(0.00)[redhat.com,brauner.io,infradead.org,manguebit.org,kernel.dk,kernel.org,samba.org,chenxiaosong.com,auristor.com,codewreck.org,gmail.com,lists.linux.dev,lists.infradead.org,vger.kernel.org,lists.ozlabs.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	FROM_NEQ_ENVFROM(0.00)[dhowells@redhat.com,linux-erofs@lists.ozlabs.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[redhat.com:+];
	PREVIOUSLY_DELIVERED(0.00)[linux-erofs@lists.ozlabs.org];
	TAGGED_RCPT(0.00)[linux-erofs];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	MISSING_XM_UA(0.00)[];
	ASN(0.00)[asn:133159, ipnet:2404:9400:2000::/36, country:AU];
	DBL_BLOCKED_OPENRESOLVER(0.00)[warthog.procyon.org.uk:mid]
X-Rspamd-Queue-Id: E2EFB57AA4B
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

David Laight <david.laight.linux@gmail.com> wrote:

> > =09struct bvecq {
> > =09=09struct bvecq=09=09*next;
> > =09=09struct bvecq=09=09*prev;
> > =09=09unsigned long long=09fpos;
> > =09=09refcount_t=09=09ref;
> > =09=09u32=09=09=09priv;
> > =09=09u16=09=09=09nr_segs;
> > =09=09u16=09=09=09max_segs;
> > =09=09enum bvecq_mem=09=09mem_type:2;
> > =09=09bool=09=09=09inline_bv:1;
> > =09=09bool=09=09=09discontig:1;
>=20
> There doesn't seem to be any point using bitfields.
> There is a massive hole here anyway.

Depends on how you define "massive".  On a 64-bit machine, the whole thing
fits into 48 bytes - 6 words (or 3 bio_vec slots).  next, prev, fpos, bv an=
d
ref+priv take up 5 of those words; nr_segs and max_segs take up half of the
6th, leaving a 4 byte hole.

You're right, though, I could make them all non-bitfields as the enum is
marked mode(byte).

> >  (1) next, prev - Link segments together in a list.  I want this to be
> >      NULL-terminated linear rather than circular to make it possible to
> >      arbitrarily glue bits on the front.
>=20
> Do you ever need to follow the list backwards?

iov_iter_revert() exists, unfortunately, but yes, I would like to avoid hav=
ing
a prev pointer.

I have a couple of ideas on how to get rid of that - or at least store the
start in struct iov_iter and always work forwards - but I haven't got round=
 to
trying that yet.

> >  (2) fpos, discontig - Note the current file position of the first byte=
 of
> >      the segment; all the bio_vecs in ->bv[] must be contiguous in the =
file
> >      space.  The fpos can be used to find the folio by file position ra=
ther
> >      then from the info in the bio_vec.
>=20
> Should fpos be off_t (or u64) rather than 'long long' (they are all the
> same underlying type).

It's not 'long long' and off_t is actually 'long' in asm-generic.  Actually=
, I
should probably switch to using uoff_t.  Note that this file position shoul=
d
never be seen as negative; I think loff_t should only really be used in
llseek.

> >      If there's a discontiguity, this should break over into a new bvec=
q
> >      segment with the discontig flag set (though this is redundant if y=
ou
> >      keep track of the file position).  Note that the beginning and end
> >      file positions in a segment need not be aligned to any filesystem
> >      block size.
>=20
> At this point you lose me :-)

Apologies, but I'm trying to define how a bvecq chain works.  I need to cod=
ify
it more coherently.

So there's a number of reasons I want to be able to maintain the file posit=
ion
information in the chain:

 (1) I can treat buffered writeback and DIO write more similarly if there's=
 no
     requirement to access the folios in the list to get file position
     information.

 (2) When cleaning up lists of folios in buffered writeback, the file posit=
ion
     is needed to access the i_pages xarray in order to clean up the marks =
on
     it.  This means I don't need to go from my list to access each folio, =
but
     can look them up through the xarray instead.

 (3) Some network filesystems, e.g. ceph, allow discontiguous (sparse) writ=
es
     to be made to the server in a single RPC operation.  This gives a mean=
s
     to convey that information to them, but then allows the data to be
     conveyed in a single blob to the socket (the mapping between blob offs=
ets
     and file regions is tabulated separately within the RPC call).

Note that some of this also applies to reads too.

The last bit about filesystem block size alignment is because network
filesystems don't typically require any block alignment, doing RMW locally =
on
the server.  I should really have separated that from the discontiguity bit=
.

David


