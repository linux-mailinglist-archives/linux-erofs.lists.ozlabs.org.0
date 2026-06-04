Return-Path: <linux-erofs+bounces-3516-lists+linux-erofs=lfdr.de@lists.ozlabs.org>
Delivered-To: lists+linux-erofs@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id 4he7HU2LIWpJIgEAu9opvQ
	(envelope-from <linux-erofs+bounces-3516-lists+linux-erofs=lfdr.de@lists.ozlabs.org>)
	for <lists+linux-erofs@lfdr.de>; Thu, 04 Jun 2026 16:27:25 +0200
X-Original-To: lists+linux-erofs@lfdr.de
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	by mail.lfdr.de (Postfix) with ESMTPS id 80B8F640DCB
	for <lists+linux-erofs@lfdr.de>; Thu, 04 Jun 2026 16:27:24 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=redhat.com header.s=mimecast20190719 header.b=cO4FwevY;
	dkim=pass header.d=redhat.com header.s=mimecast20190719 header.b=cO4FwevY;
	spf=pass (mail.lfdr.de: domain of "linux-erofs+bounces-3516-lists+linux-erofs=lfdr.de@lists.ozlabs.org" designates 112.213.38.117 as permitted sender) smtp.mailfrom="linux-erofs+bounces-3516-lists+linux-erofs=lfdr.de@lists.ozlabs.org";
	dmarc=pass (policy=quarantine) header.from=redhat.com;
	arc=pass ("lists.ozlabs.org:s=201707:i=1")
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4gWRjQ252Rz2y1Y;
	Fri, 05 Jun 2026 00:27:22 +1000 (AEST)
X-Original-To: linux-erofs@lists.ozlabs.org
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1780583242;
	cv=none; b=gP2BuQHXz24+4G/OGH9byjYdncyj6lvc3bGVstfWURI8EPzKgYGXuydo7Z+YTdb1JtqlL/OJgdMEUkjXPnH8lnW787HotV5p/482HVyx+Iz2sjLc9ehcNpYoXXTcJ9wAL5QHvTjolaOwl6VFaccSdKjFpbp3IkFYzUIg2Bj0Xkb1IGNbPQGriInolQ6lyGkv4mGAzbXdvH7ZoEecGUgJn6VTmNZkpLXOeAIJauzIBTFeLQkHGEWYq+ALcxh6HoM3Pve5Ni/MJKxO60kS2HdhWSBScnLvxWIjOT3YP+HaYWUL7xZ9N7aQXZZR2yLGHm3lfjYN/7zfgQr/4garS618AQ==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1780583242; c=relaxed/relaxed;
	bh=+OfjBfn5py7b5HQjhhTkuXyu2HLnt9jaf0NDydzON4I=;
	h=From:In-Reply-To:References:To:Cc:Subject:MIME-Version:Date:
	 Message-ID:Content-Type; b=Pt8VQ/AphZbfe4UjbzkOAXnE8xW2Oz9DXy3Yi/mEy/ZjFNNxupL+Y1WRmkSb0t36BJVWmxCSsrlCXBQOr6D4Vscwnt3IaxJ84B8Np14wfUqkM+V1W70Z0eNvwahbKDaam1xYVOAkt1dYvy99QN/Zy8qyTObQgdUcOXkkUMzrTTlbq2adzBH4vKlYIeZkDyf92PL+2N3wPrr/nfdrM9ZHnrD6gz0sQD1DpYcdH+8pzRbmtFl+ip8HFmDu5X4KFDi6pF8f1O1WLR7vy+/sXMZJvNRqx1OkSvbMvNNzLSNuO7WfnRTiWiI/AWgYvFSUBw+rHJLWqpMQ/6ZnO3AraucA/Q==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; dkim=pass (1024-bit key; unprotected) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=cO4FwevY; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=cO4FwevY; dkim-atps=neutral; spf=pass (client-ip=170.10.129.124; helo=us-smtp-delivery-124.mimecast.com; envelope-from=dhowells@redhat.com; receiver=lists.ozlabs.org) smtp.mailfrom=redhat.com
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4gWRjP1wYCz2xfB
	for <linux-erofs@lists.ozlabs.org>; Fri, 05 Jun 2026 00:27:20 +1000 (AEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1780583237;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=+OfjBfn5py7b5HQjhhTkuXyu2HLnt9jaf0NDydzON4I=;
	b=cO4FwevYDyiA/0S+hqSaJr9kT3cJIRovkm+omJIZqwpQKKgMOv98faUeT37aO4iOMsqgtm
	NYGIFlZmG9GGoSt2k0gptWsHyKwEiSp9tMAKcJL4hoRw2YDdPV9XwYgqEDylZOvWEyRzzu
	mu/SEvE8NKyxXsING44DUUPkZJ0Nvm4=
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1780583237;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=+OfjBfn5py7b5HQjhhTkuXyu2HLnt9jaf0NDydzON4I=;
	b=cO4FwevYDyiA/0S+hqSaJr9kT3cJIRovkm+omJIZqwpQKKgMOv98faUeT37aO4iOMsqgtm
	NYGIFlZmG9GGoSt2k0gptWsHyKwEiSp9tMAKcJL4hoRw2YDdPV9XwYgqEDylZOvWEyRzzu
	mu/SEvE8NKyxXsING44DUUPkZJ0Nvm4=
Received: from mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-493-PwOfHFj9OsiIKGl_Ou9BIA-1; Thu,
 04 Jun 2026 10:27:11 -0400
X-MC-Unique: PwOfHFj9OsiIKGl_Ou9BIA-1
X-Mimecast-MFC-AGG-ID: PwOfHFj9OsiIKGl_Ou9BIA_1780583228
Received: from mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.12])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 5D7CE1956050;
	Thu,  4 Jun 2026 14:27:07 +0000 (UTC)
Received: from warthog.procyon.org.uk (unknown [10.44.50.14])
	by mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id 22BEF1955BC0;
	Thu,  4 Jun 2026 14:26:59 +0000 (UTC)
Organization: Red Hat UK Ltd. Registered Address: Red Hat UK Ltd, Amberley
	Place, 107-111 Peascod Street, Windsor, Berkshire, SI4 1TE, United
	Kingdom.
	Registered in England and Wales under Company Registration No. 3798903
From: David Howells <dhowells@redhat.com>
In-Reply-To: <ahPon44OlN0SqzU6@infradead.org>
References: <ahPon44OlN0SqzU6@infradead.org> <20260518222959.488126-1-dhowells@redhat.com> <20260518222959.488126-7-dhowells@redhat.com>
To: Christoph Hellwig <hch@infradead.org>
Cc: dhowells@redhat.com, Christian Brauner <christian@brauner.io>,
    Matthew Wilcox <willy@infradead.org>,
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
    linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
    linux-block@vger.kernel.org
Subject: Re: [PATCH v2 06/21] iov_iter: Make iov_iter_get_pages*() wrap iov_iter_extract_pages()
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
Date: Thu, 04 Jun 2026 15:26:58 +0100
Message-ID: <127172.1780583218@warthog.procyon.org.uk>
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.12
X-Mimecast-MFC-PROC-ID: ajk8T1UE6PKPj6kXX37pgtf7T_GLSb-GeXhYd-l28BI_1780583228
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset="us-ascii"
Content-ID: <127171.1780583218.1@warthog.procyon.org.uk>
X-Spam-Status: No, score=2.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
	RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,RCVD_IN_SBL_CSS,SPF_HELO_PASS,
	SPF_PASS autolearn=disabled version=4.0.1
X-Spam-Level: **
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-25) on lists.ozlabs.org
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-2.20 / 15.00];
	ARC_ALLOW(-1.00)[lists.ozlabs.org:s=201707:i=1];
	DMARC_POLICY_ALLOW(-0.50)[redhat.com,quarantine];
	R_SPF_ALLOW(-0.20)[+ip4:112.213.38.117:c];
	R_DKIM_ALLOW(-0.20)[redhat.com:s=mimecast20190719];
	MAILLIST(-0.19)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-3516-lists,linux-erofs=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FREEMAIL_CC(0.00)[redhat.com,brauner.io,infradead.org,manguebit.org,kernel.dk,kernel.org,samba.org,chenxiaosong.com,auristor.com,codewreck.org,gmail.com,lists.linux.dev,lists.infradead.org,vger.kernel.org,lists.ozlabs.org];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORGED_RECIPIENTS(0.00)[m:hch@infradead.org,m:dhowells@redhat.com,m:christian@brauner.io,m:willy@infradead.org,m:pc@manguebit.org,m:axboe@kernel.dk,m:leon@kernel.org,m:sfrench@samba.org,m:chenxiaosong@chenxiaosong.com,m:marc.dionne@auristor.com,m:ericvh@kernel.org,m:asmadeus@codewreck.org,m:idryomov@gmail.com,m:trondmy@kernel.org,m:netfs@lists.linux.dev,m:linux-afs@lists.infradead.org,m:linux-cifs@vger.kernel.org,m:linux-nfs@vger.kernel.org,m:ceph-devel@vger.kernel.org,m:v9fs@lists.linux.dev,m:linux-erofs@lists.ozlabs.org,m:linux-fsdevel@vger.kernel.org,m:linux-kernel@vger.kernel.org,m:linux-block@vger.kernel.org,s:lists@lfdr.de];
	HAS_ORG_HEADER(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[24];
	FORGED_SENDER(0.00)[dhowells@redhat.com,linux-erofs@lists.ozlabs.org];
	MIME_TRACE(0.00)[0:+];
	FORWARDED(0.00)[linux-erofs@lists.ozlabs.org];
	DKIM_TRACE(0.00)[redhat.com:+];
	MISSING_XM_UA(0.00)[];
	TO_DN_SOME(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	FROM_NEQ_ENVFROM(0.00)[dhowells@redhat.com,linux-erofs@lists.ozlabs.org];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PREVIOUSLY_DELIVERED(0.00)[linux-erofs@lists.ozlabs.org];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	ALIAS_RESOLVED(0.00)[];
	ASN(0.00)[asn:133159, ipnet:112.213.32.0/21, country:AU];
	TAGGED_RCPT(0.00)[linux-erofs];
	DBL_BLOCKED_OPENRESOLVER(0.00)[warthog.procyon.org.uk:mid,lists.ozlabs.org:helo,lists.ozlabs.org:rdns,lists.ozlabs.org:from_smtp]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 80B8F640DCB

Christoph Hellwig <hch@infradead.org> wrote:

> On Mon, May 18, 2026 at 11:29:38PM +0100, David Howells wrote:
> > Make iov_iter_get_pages*() wrap iov_iter_extract_pages() for kernel
> > iterator types (e.g. ITER_BVEC, ITER_FOLIOQ, ITER_XARRAY).  The pages
> > obtained have their refcounts incremented afterwards if they're not slab
> > pages.  ITER_KVEC is left returning -EFAULT.
> 
> Just kill off iov_iter_get_pages*, please.  Or at least stop using it
> where these types matter.

Much as I would like to, this isn't the place to do it.  It will require an
overhaul of the network socket buffering.

David


