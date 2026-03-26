Return-Path: <linux-erofs+bounces-3041-lists+linux-erofs=lfdr.de@lists.ozlabs.org>
Delivered-To: lists+linux-erofs@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id mMJUCjkUxWnr6QQAu9opvQ
	(envelope-from <linux-erofs+bounces-3041-lists+linux-erofs=lfdr.de@lists.ozlabs.org>)
	for <lists+linux-erofs@lfdr.de>; Thu, 26 Mar 2026 12:10:49 +0100
X-Original-To: lists+linux-erofs@lfdr.de
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	by mail.lfdr.de (Postfix) with ESMTPS id 9F76E3341F4
	for <lists+linux-erofs@lfdr.de>; Thu, 26 Mar 2026 12:10:47 +0100 (CET)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4fhLfr6l66z2yd7;
	Thu, 26 Mar 2026 22:10:44 +1100 (AEDT)
X-Original-To: linux-erofs@lists.ozlabs.org
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip=170.10.133.124
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1774523444;
	cv=none; b=Vf7AsHO7XN0s9zujfh4ngXSwAewk3Cpe68NbYSAb7khq14pn4cDqDWKqr4xFAkKvVgWe9emGTbgkUEs0jQ1VQ68fgbKAv3qpiRtx8nn/SQigIM2jH0pE6JGD7Bi3Qvitgwa6VaKcQYn4iTwCvmPSMxq4Q9dwMybSD9ABc6KIv3SL6pk9RZPu48W4LTnj4TfCB6rYUuan8mmAs0SHdx4007WBJN3PHgia1ynHVZahZIFLgONmiMI3ZOTktlouEqomuQ1CZXRMZzQvfYEhIVvf2wc000zA3bDMAO6ivOg987Yirncl3QYukgUpJ0X7wqZTKs3Nga33pfqtpRNk2cKqug==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1774523444; c=relaxed/relaxed;
	bh=cXxdqkbQLA4ehuUOQdRt5Ygk7PCXPrYtxEdT8qB7Hzo=;
	h=From:In-Reply-To:References:To:Cc:Subject:MIME-Version:Date:
	 Message-ID:Content-Type; b=cimZIsUWOFTGjjilbFeuIM3QJ2OPLjFVTcZJ0aFLtaqV/x8+tppiqhTLSkycgSXe2SOW4Ua6pUh+7gQ/varrBKHTdga7k2Zt/2QK43eB0vsx8k6O45Kq5OQVvKqwbV4ucKE84AlsuAGKIQ+ba6Sc3zGfzc+X8lU6Ig/iSojKQ+e9MyQGxBUAvGOGtUBcdTGvHP2P6zyUSKH+Bt7qYZsqmghAHr3hyb1uAYcMf7uqcDK6sQO1wbYGINCkWa8CcqKIp3W50VL1QsDPHhVbHN/QlHQfPK7iSVzTbo/2F2+k2qEm2PT5j3lipPiwUyjHihqp5rlQ12au4k4+SH7X+yg9IA==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; dkim=pass (1024-bit key; unprotected) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=FTPWKaVx; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=FTPWKaVx; dkim-atps=neutral; spf=pass (client-ip=170.10.133.124; helo=us-smtp-delivery-124.mimecast.com; envelope-from=dhowells@redhat.com; receiver=lists.ozlabs.org) smtp.mailfrom=redhat.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (1024-bit key; unprotected) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=FTPWKaVx;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=FTPWKaVx;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=redhat.com (client-ip=170.10.133.124; helo=us-smtp-delivery-124.mimecast.com; envelope-from=dhowells@redhat.com; receiver=lists.ozlabs.org)
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4fhLfq5Lkmz2yVB
	for <linux-erofs@lists.ozlabs.org>; Thu, 26 Mar 2026 22:10:41 +1100 (AEDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1774523439;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=cXxdqkbQLA4ehuUOQdRt5Ygk7PCXPrYtxEdT8qB7Hzo=;
	b=FTPWKaVxQbu5WYXcc8Vvha3QKpPDeeTWBzdRYqM/kRoJmeVXGePkE/TKlN4c3bzvHAKasK
	y9fAvCby17C3dq4ocnaEpmbMALX1JY61F7TTNQDV8ArHO8DOEmvVG+3vomswOmg8DiPaxS
	+jCJaq1+Xk2oDXYrZOAMe6tl06omq78=
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1774523439;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=cXxdqkbQLA4ehuUOQdRt5Ygk7PCXPrYtxEdT8qB7Hzo=;
	b=FTPWKaVxQbu5WYXcc8Vvha3QKpPDeeTWBzdRYqM/kRoJmeVXGePkE/TKlN4c3bzvHAKasK
	y9fAvCby17C3dq4ocnaEpmbMALX1JY61F7TTNQDV8ArHO8DOEmvVG+3vomswOmg8DiPaxS
	+jCJaq1+Xk2oDXYrZOAMe6tl06omq78=
Received: from mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-530-bIDBd2wNPAC8eDxXKK0CqQ-1; Thu,
 26 Mar 2026 07:10:37 -0400
X-MC-Unique: bIDBd2wNPAC8eDxXKK0CqQ-1
X-Mimecast-MFC-AGG-ID: bIDBd2wNPAC8eDxXKK0CqQ_1774523434
Received: from mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.93])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 3DEE71955D5B;
	Thu, 26 Mar 2026 11:10:34 +0000 (UTC)
Received: from warthog.procyon.org.uk (unknown [10.44.33.121])
	by mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id 5E68F18001FE;
	Thu, 26 Mar 2026 11:10:27 +0000 (UTC)
Organization: Red Hat UK Ltd. Registered Address: Red Hat UK Ltd, Amberley
	Place, 107-111 Peascod Street, Windsor, Berkshire, SI4 1TE, United
	Kingdom.
	Registered in England and Wales under Company Registration No. 3798903
From: David Howells <dhowells@redhat.com>
In-Reply-To: <CA+yaA_=gpTnueByzFNYrqNL_qSC2rE4iGDjLHtJap-=_rhE3HQ@mail.gmail.com>
References: <CA+yaA_=gpTnueByzFNYrqNL_qSC2rE4iGDjLHtJap-=_rhE3HQ@mail.gmail.com> <20260326104544.509518-1-dhowells@redhat.com> <20260326104544.509518-8-dhowells@redhat.com>
To: Aditya <dev@adityakammati.me>
Cc: dhowells@redhat.com, Christian Brauner <christian@brauner.io>,
    Matthew Wilcox <willy@infradead.org>,
    Christoph Hellwig <hch@infradead.org>,
    Paulo Alcantara <pc@manguebit.com>, Jens Axboe <axboe@kernel.dk>,
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
    NeilBrown <neil@brown.name>, Paulo Alcantara <pc@manguebit.org>
Subject: Re: [PATCH 07/26] cachefiles: Fix excess dput() after end_removing()
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
Date: Thu, 26 Mar 2026 11:10:25 +0000
Message-ID: <510331.1774523425@warthog.procyon.org.uk>
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.93
X-Mimecast-MFC-PROC-ID: 59uQBjPyslwrxlhqwX38yfWpv_CGULtIXFWlOzjMWL4_1774523434
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset="us-ascii"
Content-ID: <510330.1774523425.1@warthog.procyon.org.uk>
X-Spam-Status: No, score=-0.2 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
	RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS autolearn=disabled
	version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-25) on lists.ozlabs.org
X-Spamd-Result: default: False [-2.20 / 15.00];
	ARC_ALLOW(-1.00)[lists.ozlabs.org:s=201707:i=1];
	DMARC_POLICY_ALLOW(-0.50)[redhat.com,quarantine];
	R_DKIM_ALLOW(-0.20)[redhat.com:s=mimecast20190719];
	R_SPF_ALLOW(-0.20)[+ip4:112.213.38.117];
	MAILLIST(-0.19)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-3041-lists,linux-erofs=lfdr.de];
	FREEMAIL_CC(0.00)[redhat.com,brauner.io,infradead.org,manguebit.com,kernel.dk,kernel.org,samba.org,chenxiaosong.com,auristor.com,codewreck.org,gmail.com,lists.linux.dev,lists.infradead.org,vger.kernel.org,lists.ozlabs.org,brown.name,manguebit.org];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORGED_SENDER(0.00)[dhowells@redhat.com,linux-erofs@lists.ozlabs.org];
	RCPT_COUNT_TWELVE(0.00)[26];
	FORGED_RECIPIENTS(0.00)[m:dev@adityakammati.me,m:dhowells@redhat.com,m:christian@brauner.io,m:willy@infradead.org,m:hch@infradead.org,m:pc@manguebit.com,m:axboe@kernel.dk,m:leon@kernel.org,m:sfrench@samba.org,m:chenxiaosong@chenxiaosong.com,m:marc.dionne@auristor.com,m:ericvh@kernel.org,m:asmadeus@codewreck.org,m:idryomov@gmail.com,m:trondmy@kernel.org,m:netfs@lists.linux.dev,m:linux-afs@lists.infradead.org,m:linux-cifs@vger.kernel.org,m:linux-nfs@vger.kernel.org,m:ceph-devel@vger.kernel.org,m:v9fs@lists.linux.dev,m:linux-erofs@lists.ozlabs.org,m:linux-fsdevel@vger.kernel.org,m:linux-kernel@vger.kernel.org,m:neil@brown.name,m:pc@manguebit.org,s:lists@lfdr.de];
	MIME_TRACE(0.00)[0:+];
	HAS_ORG_HEADER(0.00)[];
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
	NEURAL_HAM(-0.00)[-1.000];
	ASN(0.00)[asn:133159, ipnet:112.213.32.0/21, country:AU];
	TAGGED_RCPT(0.00)[linux-erofs];
	DBL_BLOCKED_OPENRESOLVER(0.00)[adityakammati.me:email]
X-Rspamd-Queue-Id: 9F76E3341F4
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

Aditya <dev@adityakammati.me> wrote:

> Why are this bulk fixes

I'm not sure what you're asking.  Are you wanting to know why the series
begins with a collection of fix patches?  If so, it's because the main patches
(08-26) are dependent on them being applied first.

David


