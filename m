Return-Path: <linux-erofs+bounces-3289-lists+linux-erofs=lfdr.de@lists.ozlabs.org>
Delivered-To: lists+linux-erofs@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id mEj3Dqv03WmMlQkAu9opvQ
	(envelope-from <linux-erofs+bounces-3289-lists+linux-erofs=lfdr.de@lists.ozlabs.org>)
	for <lists+linux-erofs@lfdr.de>; Tue, 14 Apr 2026 10:02:51 +0200
X-Original-To: lists+linux-erofs@lfdr.de
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	by mail.lfdr.de (Postfix) with ESMTPS id 1B1BA3F6DDE
	for <lists+linux-erofs@lfdr.de>; Tue, 14 Apr 2026 10:02:35 +0200 (CEST)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4fvxZx0H2cz2yFl;
	Tue, 14 Apr 2026 18:02:33 +1000 (AEST)
X-Original-To: linux-erofs@lists.ozlabs.org
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip=170.10.133.124
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1776153752;
	cv=none; b=Nb/8kSVZr0WDnnQloQ1OjO2K6tzuR2BgoqPBzf6atHsFVxXCphLtFYcDgjiUFozPv9aFOu4p0EkoGDTrbevmsWXcvwjOD7SFa8iVZDxhfdNCdFf+zEhR+mbyC71Zw4xg+lEzChvP9NbdYy5r1E9vZuQm8o74z3iMY32ZO6H7YlHZW8OIkGKDteC7EUhKIcOirhfKBGmy1NjO9qMG8jPSs96AeaLcFAX2z4ZQmgMle6RMUYwBx9NjFtlVoezRZoUnMgj+CzAxGK3RvNIeMVRtNLK54MzCZdVrRlVSwl35a+9q0obw1s67TRth5z8mj1mu/Ff9cMUJCaTUJw22/X6Q3g==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1776153752; c=relaxed/relaxed;
	bh=JJFZCN3rB5RE2spFMluEVpX8vCNqZ50mkbSkFhz2niU=;
	h=From:In-Reply-To:References:To:Cc:Subject:MIME-Version:Date:
	 Message-ID:Content-Type; b=i1NVKAdkUhHmEpmRQ/t85wIapH48e4R1hSs00F636e6G18/aKhyA8AbFwZNWOKLdJupv+KJzoTSFQk3bpAsZEWN3c3V/pkHCHkOTDNjm1Meb1kdIwpmOWMpNw1kP/MxGFKEpEFOzTrMEvigifwrvRYmXElvylgZ1KHF0JPq1w8yu9M0RWtxsFys5GfY16sl1uHMUNuQWAUNcSzfsp6ssedXXJz4rCIPIr8OC92QBnfQyDjM78WESHCHi3yuxtGZAoOdZWMwvg4/9ZuEDZltfmp53tmI+4gvVIHUeeIK/c9L+jU4CEOGdYW8LSUo+KuKNjZtXkRXSX1RSnLQjFrGCmQ==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; dkim=pass (1024-bit key; unprotected) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=RGxZjl2z; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=feNrTJkR; dkim-atps=neutral; spf=pass (client-ip=170.10.133.124; helo=us-smtp-delivery-124.mimecast.com; envelope-from=dhowells@redhat.com; receiver=lists.ozlabs.org) smtp.mailfrom=redhat.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (1024-bit key; unprotected) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=RGxZjl2z;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=feNrTJkR;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=redhat.com (client-ip=170.10.133.124; helo=us-smtp-delivery-124.mimecast.com; envelope-from=dhowells@redhat.com; receiver=lists.ozlabs.org)
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4fvxZq2Bw5z2xnj
	for <linux-erofs@lists.ozlabs.org>; Tue, 14 Apr 2026 18:02:25 +1000 (AEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1776153740;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=JJFZCN3rB5RE2spFMluEVpX8vCNqZ50mkbSkFhz2niU=;
	b=RGxZjl2z6/cfQWb/f1fhIvHSQ5QozDL3lWjRDjqJyYEpvlgzziZ+kyCNpmifTw8510d3aU
	gotHfV7QGVvZTib9GhWN5I/XsBjIGs6aVSKc6Hon5F1HifVa4S458LU4ni2tV1GZ8Xh0+M
	xfg0oO2PpyKN67SrYPyLCQNcHdTzjg8=
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1776153741;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=JJFZCN3rB5RE2spFMluEVpX8vCNqZ50mkbSkFhz2niU=;
	b=feNrTJkR4WiFL5NXDk6u3zqL4e+UjNweWA9DB6zTAH0i5ZITz4mfBwnEM0viAcZagZxfao
	T3gsHGJpLTkjGS/ZfJNEHp9UOZZsObRcHtAsUR660HXEQ6q9i6j/k2HE41vZna5JVo0QmL
	fEsdGdQLzsXL56XvvKOwaFpanEY9ohE=
Received: from mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-644-e-mrVy0ROXuXltmJMHSNPA-1; Tue,
 14 Apr 2026 04:02:16 -0400
X-MC-Unique: e-mrVy0ROXuXltmJMHSNPA-1
X-Mimecast-MFC-AGG-ID: e-mrVy0ROXuXltmJMHSNPA_1776153733
Received: from mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.111])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 22DE118011FF;
	Tue, 14 Apr 2026 08:02:11 +0000 (UTC)
Received: from warthog.procyon.org.uk (unknown [10.44.34.160])
	by mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id 227F518002A6;
	Tue, 14 Apr 2026 08:02:01 +0000 (UTC)
Organization: Red Hat UK Ltd. Registered Address: Red Hat UK Ltd, Amberley
	Place, 107-111 Peascod Street, Windsor, Berkshire, SI4 1TE, United
	Kingdom.
	Registered in England and Wales under Company Registration No. 3798903
From: David Howells <dhowells@redhat.com>
In-Reply-To: <9639cd12-5e9d-4eb4-9d9c-f5047ccad7b7@samba.org>
References: <9639cd12-5e9d-4eb4-9d9c-f5047ccad7b7@samba.org> <52ad0aa6-d8dd-4ba1-adf2-f79128df9d90@samba.org> <20260326104544.509518-1-dhowells@redhat.com> <1180465.1774867781@warthog.procyon.org.uk>
To: Stefan Metzmacher <metze@samba.org>
Cc: dhowells@redhat.com, Christian Brauner <christian@brauner.io>,
    Matthew Wilcox <willy@infradead.org>,
    Christoph Hellwig <hch@infradead.org>,
    Steve French <smfrench@gmail.com>,
    Namjae Jeon <linkinjeon@kernel.org>,
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
    linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 00/26] netfs: Keep track of folios in a segmented bio_vec[] chain
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
Date: Tue, 14 Apr 2026 09:02:00 +0100
Message-ID: <3755493.1776153720@warthog.procyon.org.uk>
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.111
X-Mimecast-MFC-PROC-ID: 7szJWsTYFbwIht1GObsiqPVTDCnok5IGfpJ-Gh_OcDo_1776153733
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset="us-ascii"
Content-ID: <3755492.1776153720.1@warthog.procyon.org.uk>
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-0.2 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
	RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS autolearn=disabled
	version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-25) on lists.ozlabs.org
X-Spamd-Result: default: False [-2.20 / 15.00];
	ARC_ALLOW(-1.00)[lists.ozlabs.org:s=201707:i=1];
	DMARC_POLICY_ALLOW(-0.50)[redhat.com,quarantine];
	R_DKIM_ALLOW(-0.20)[redhat.com:s=mimecast20190719];
	R_SPF_ALLOW(-0.20)[+ip4:112.213.38.117:c];
	MAILLIST(-0.19)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FORGED_RECIPIENTS(0.00)[m:metze@samba.org,m:dhowells@redhat.com,m:christian@brauner.io,m:willy@infradead.org,m:hch@infradead.org,m:smfrench@gmail.com,m:linkinjeon@kernel.org,m:pc@manguebit.com,m:axboe@kernel.dk,m:leon@kernel.org,m:sfrench@samba.org,m:chenxiaosong@chenxiaosong.com,m:marc.dionne@auristor.com,m:ericvh@kernel.org,m:asmadeus@codewreck.org,m:idryomov@gmail.com,m:trondmy@kernel.org,m:netfs@lists.linux.dev,m:linux-afs@lists.infradead.org,m:linux-cifs@vger.kernel.org,m:linux-nfs@vger.kernel.org,m:ceph-devel@vger.kernel.org,m:v9fs@lists.linux.dev,m:linux-erofs@lists.ozlabs.org,m:linux-fsdevel@vger.kernel.org,m:linux-kernel@vger.kernel.org,s:lists@lfdr.de];
	DKIM_TRACE(0.00)[redhat.com:+];
	MIME_TRACE(0.00)[0:+];
	RCPT_COUNT_TWELVE(0.00)[26];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FREEMAIL_CC(0.00)[redhat.com,brauner.io,infradead.org,gmail.com,kernel.org,manguebit.com,kernel.dk,samba.org,chenxiaosong.com,auristor.com,codewreck.org,lists.linux.dev,lists.infradead.org,vger.kernel.org,lists.ozlabs.org];
	TAGGED_FROM(0.00)[bounces-3289-lists,linux-erofs=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	HAS_ORG_HEADER(0.00)[];
	FORGED_SENDER(0.00)[dhowells@redhat.com,linux-erofs@lists.ozlabs.org];
	RSPAMD_EMAILBL_FAIL(0.00)[metze.samba.org:query timed out];
	FORWARDED(0.00)[linux-erofs@lists.ozlabs.org];
	MISSING_XM_UA(0.00)[];
	SEM_URIBL_UNKNOWN_FAIL(0.00)[samba.org:query timed out];
	TO_DN_SOME(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[dhowells@redhat.com,linux-erofs@lists.ozlabs.org];
	SEM_URIBL_FRESH15_UNKNOWN_FAIL(0.00)[samba.org:query timed out];
	MAILSPIKE_FAIL(0.00)[112.213.38.117:query timed out];
	FROM_HAS_DN(0.00)[];
	RBL_SEM_FAIL(0.00)[112.213.38.117:query timed out];
	ASN(0.00)[asn:133159, ipnet:112.213.32.0/21, country:AU];
	RCVD_COUNT_FIVE(0.00)[5];
	NEURAL_HAM(-0.00)[-1.000];
	FORGED_SENDER_MAILLIST(0.00)[];
	PREVIOUSLY_DELIVERED(0.00)[linux-erofs@lists.ozlabs.org];
	TAGGED_RCPT(0.00)[linux-erofs];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[samba.org:email]
X-Rspamd-Queue-Id: 1B1BA3F6DDE
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

Stefan Metzmacher <metze@samba.org> wrote:

> Any idea on how to resolve the actual conflict?

I didn't manage to beat the bugs out in time (turned out several were
preexisting).

However, if you look here:

https://git.kernel.org/pub/scm/linux/kernel/git/dhowells/linux-fs.git/log/?=
h=3Dcifs-next

I've stacked my patchset on top of yours and modified smbdirect_connection.=
c
appropriately.

David


