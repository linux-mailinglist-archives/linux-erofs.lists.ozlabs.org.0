Return-Path: <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>
X-Original-To: lists+linux-erofs@lfdr.de
Delivered-To: lists+linux-erofs@lfdr.de
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	by mail.lfdr.de (Postfix) with ESMTPS id 4B8479D16FB
	for <lists+linux-erofs@lfdr.de>; Mon, 18 Nov 2024 18:20:37 +0100 (CET)
Received: from boromir.ozlabs.org (localhost [IPv6:::1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4XsZC55xLwz3bcs
	for <lists+linux-erofs@lfdr.de>; Tue, 19 Nov 2024 04:20:33 +1100 (AEDT)
X-Original-To: linux-erofs@lists.ozlabs.org
Delivered-To: linux-erofs@lists.ozlabs.org
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip=170.10.133.124
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1731950431;
	cv=none; b=YCFMshFvVWKLrDV4vO8hhuKIPyPqDp30Vq+vX5FjW0EK02JIVz0hhzWPVsPmwaJOPBrJoXPtN1w0iOef0xvktZpn6k5Y1PLLO56k/e9ZQmLmzC+blqWPRA4wF1TTruajnov62WQqj8Bq73w95s2BD2QEHbKUTRv3O3V1fhO8NHCmlqSWXC0teY6Z1a5DcI2WSFa/QQ2j5EZm9PalsUhORVUz6IPTnmI0YaJq0UtPBuI3aJgiSeTP+vtk0aHqBNBalXlnMSBoQuvKcOoLXaDl1hUB8S6TqR7n8Gp2dv+D7Xg7ed5mjQH65rCDezN8Mecc+NKcVx9AtINb19IBwzw77g==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1731950431; c=relaxed/relaxed;
	bh=FHIXshzU7B/fw7mP4ANo81ZSu1pvlr9VA+iMyEA9kz8=;
	h=From:In-Reply-To:References:To:Cc:Subject:MIME-Version:
	 Content-Type:Date:Message-ID; b=irMlKEvtT62K0ffdPte4o5LLx1vvhoqcjw1BAalj/yU+G4QTpJL3ZA2C0FOqEegH4SwL+9N2eWCDPDl+GzOUU798S6UKgf+R88pohCKU9prNxXmGXRSxAuXGbz1mHsu61d/yN8rZqe/04giaqWSzgPr5SmPCmUU19W1WKamCCQcdAHjiH72yl8XvBKA/J7eWZMKLB6WKt77o/8anH6YgCOfydwrHQ9s1cfYb9+N/mQRLgiS6yndRYm4WL2y5Tf2ub6grWM7xUUxgxrfKukhp4U6ZfrhkJxVrZ3X4yU3RNke8qT7J6hHfRkBfXFLZnv6HBQRpWkc6X4rb4g+Mjlp3Zg==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=redhat.com; dkim=pass (1024-bit key; unprotected) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=PkvuyAmD; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=WExsLe8N; dkim-atps=neutral; spf=pass (client-ip=170.10.133.124; helo=us-smtp-delivery-124.mimecast.com; envelope-from=dhowells@redhat.com; receiver=lists.ozlabs.org) smtp.mailfrom=redhat.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (1024-bit key; unprotected) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=PkvuyAmD;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=WExsLe8N;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=redhat.com (client-ip=170.10.133.124; helo=us-smtp-delivery-124.mimecast.com; envelope-from=dhowells@redhat.com; receiver=lists.ozlabs.org)
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4XsZC24Cvpz2yWr
	for <linux-erofs@lists.ozlabs.org>; Tue, 19 Nov 2024 04:20:28 +1100 (AEDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1731950425;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=FHIXshzU7B/fw7mP4ANo81ZSu1pvlr9VA+iMyEA9kz8=;
	b=PkvuyAmDP/lS+z4Vli408Dy/08wbevlFxTRj0W/L3Flkt/ZglkUhypkcGn3hCjSDlYt9r4
	Yibm0/5ianRmwd75mKkpkwERyY+JJa8CsL/Ys4zIsszZuqQB/iXOn6ze3rMQJIf/zFWxdk
	sIeFmrrxD4WnemuuHRvRHzh7jxfqdpw=
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1731950426;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=FHIXshzU7B/fw7mP4ANo81ZSu1pvlr9VA+iMyEA9kz8=;
	b=WExsLe8NdmdwEV8UNbPW/jnEthNymL+W6S2Upcj/oz2ruBd+D6gMtm8EdFb1iRp4B3qdVK
	6H0gfIT9UZ3oxSUlK/fo2Rbw2Zjkvo9fQS1qmsU1PoAzqkXT/n5HOoHvYRRy6M9sdXVGsu
	GUqHSd2ZGQUw3Zoend87bMcyKbEVLSk=
Received: from mx-prod-mc-04.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-152-eXuZijuZMpiG0ZJ9iVPEIQ-1; Mon,
 18 Nov 2024 12:20:22 -0500
X-MC-Unique: eXuZijuZMpiG0ZJ9iVPEIQ-1
X-Mimecast-MFC-AGG-ID: eXuZijuZMpiG0ZJ9iVPEIQ
Received: from mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.12])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-04.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id A67371955D62;
	Mon, 18 Nov 2024 17:20:16 +0000 (UTC)
Received: from warthog.procyon.org.uk (unknown [10.42.28.207])
	by mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id 261D5195DF81;
	Mon, 18 Nov 2024 17:20:08 +0000 (UTC)
Organization: Red Hat UK Ltd. Registered Address: Red Hat UK Ltd, Amberley
	Place, 107-111 Peascod Street, Windsor, Berkshire, SI4 1TE, United
	Kingdom.
	Registered in England and Wales under Company Registration No. 3798903
From: David Howells <dhowells@redhat.com>
In-Reply-To: <20241114163931.GA1928968@thelio-3990X>
References: <20241114163931.GA1928968@thelio-3990X> <20241108173236.1382366-1-dhowells@redhat.com> <20241108173236.1382366-29-dhowells@redhat.com>
To: Nathan Chancellor <nathan@kernel.org>
Subject: Re: [PATCH v4 28/33] netfs: Change the read result collector to only use one work item
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-ID: <948807.1731950408.1@warthog.procyon.org.uk>
Content-Transfer-Encoding: quoted-printable
Date: Mon, 18 Nov 2024 17:20:08 +0000
Message-ID: <948808.1731950408@warthog.procyon.org.uk>
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.12
X-Spam-Status: No, score=-0.5 required=5.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
	RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_PASS
	autolearn=disabled version=4.0.0
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
Cc: Dominique Martinet <asmadeus@codewreck.org>, dhowells@redhat.com, linux-mm@kvack.org, Marc Dionne <marc.dionne@auristor.com>, linux-afs@lists.infradead.org, Paulo Alcantara <pc@manguebit.com>, linux-cifs@vger.kernel.org, Matthew Wilcox <willy@infradead.org>, Steve French <smfrench@gmail.com>, Gao Xiang <hsiangkao@linux.alibaba.com>, Ilya Dryomov <idryomov@gmail.com>, Shyam Prasad N <sprasad@microsoft.com>, linux-nfs@vger.kernel.org, Tom Talpey <tom@talpey.com>, ceph-devel@vger.kernel.org, Eric Van Hensbergen <ericvh@kernel.org>, Christian Brauner <brauner@kernel.org>, netdev@vger.kernel.org, v9fs@lists.linux.dev, Jeff Layton <jlayton@kernel.org>, linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org, netfs@lists.linux.dev, linux-erofs@lists.ozlabs.org
Errors-To: linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org
Sender: "Linux-erofs" <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>

Nathan Chancellor <nathan@kernel.org> wrote:

> This change as commit 1bd9011ee163 ("netfs: Change the read result
> collector to only use one work item") in next-20241114 causes a clang
> warning:
> =

>   fs/netfs/read_retry.c:235:20: error: variable 'subreq' is uninitialize=
d when used here [-Werror,-Wuninitialized]
>     235 |         if (list_is_last(&subreq->rreq_link, &stream->subreque=
sts))
>         |                           ^~~~~~
>   fs/netfs/read_retry.c:28:36: note: initialize the variable 'subreq' to=
 silence this warning
>      28 |         struct netfs_io_subrequest *subreq;
>         |                                           ^
>         |                                            =3D NULL
> =

> May be a shadowing issue, as adding KCFLAGS=3D-Wshadow shows:

Yep.  I'll remove both shadowing variables (there's also one at line 45 in=
 the
bit that deals with the non-renegotiation case) and use the outermost one.

Thanks,
David

