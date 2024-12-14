Return-Path: <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>
X-Original-To: lists+linux-erofs@lfdr.de
Delivered-To: lists+linux-erofs@lfdr.de
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	by mail.lfdr.de (Postfix) with ESMTPS id AC9499F1F13
	for <lists+linux-erofs@lfdr.de>; Sat, 14 Dec 2024 14:45:08 +0100 (CET)
Received: from boromir.ozlabs.org (localhost [IPv6:::1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4Y9SBT1DK2z3bPR
	for <lists+linux-erofs@lfdr.de>; Sun, 15 Dec 2024 00:45:05 +1100 (AEDT)
X-Original-To: linux-erofs@lists.ozlabs.org
Delivered-To: linux-erofs@lists.ozlabs.org
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip=170.10.133.124
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1734183903;
	cv=none; b=NCLQUEyBhxfSRjK9VCi4YhtdMTqj9lc1Qf+Oyky/KqnYQYpgumBBZ5TpiAb+RbQCBjY/VXAQH619D4rldwkGzmfjIB2zcEChlfN5/JOO+b6LCEygci2RGnwoDllhSPAASd21XLj5P8uQN7jmKw2kNp73SGkJ+knTbAcoWWufR7L7y0pDr493LpgRAIljZDJgd8SdAymUjtafrTsI0dnFGf+O4JNmhPQjpHEGCyeJmERzC/Ysz053V07h4xqDyuB6Pm8BMp6NWxhiUizp3JF8yqP3mCWqLZ+6dE1P9hXQtiLhftsGW7DPenp5FK0aJt3hq7Wm6pEhGuoc25Ngn9di+A==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1734183903; c=relaxed/relaxed;
	bh=um83NFh7ZIRRd8ai46akYsrKyJ5hcwaKtVTR9gj1RFE=;
	h=From:In-Reply-To:References:To:Cc:Subject:MIME-Version:
	 Content-Type:Date:Message-ID; b=flZyWrKkNFU48qKr5hJ4pcQvMFqV5fFuZ3xf+RYqGaI/q6BrOoKV/NJE3EODIXbg+bIeF52ruO+QUexP9owhqhDuIniOQDu3q09iSHYHNw8rIyRRoQ1NjrvRwxsU31WD3f8IxgJwdZt5vxFwox2zpPcFVPWp5maD8DL0f7lEyhakbG4q4gw8IE3HyYDcszvfU88n9CnIaRN5WQkw6C+ul3joy8AHMaGqyHEWVG0vX0JaTAg/oZ2vP/+rpBoJAVJ2yqfhXx5theYLqBu1K3D7l1Wr0OHNOgGE9mpEa5FQ+Y15KPV6Zs0BK+C0bcdd10fWP6D08QZB9k7fuT36UJUHag==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=redhat.com; dkim=pass (1024-bit key; unprotected) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=Jb3sjXPQ; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=XfQ67DS9; dkim-atps=neutral; spf=pass (client-ip=170.10.133.124; helo=us-smtp-delivery-124.mimecast.com; envelope-from=dhowells@redhat.com; receiver=lists.ozlabs.org) smtp.mailfrom=redhat.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (1024-bit key; unprotected) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=Jb3sjXPQ;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=XfQ67DS9;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=redhat.com (client-ip=170.10.133.124; helo=us-smtp-delivery-124.mimecast.com; envelope-from=dhowells@redhat.com; receiver=lists.ozlabs.org)
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4Y9SBP64Vvz2yJ5
	for <linux-erofs@lists.ozlabs.org>; Sun, 15 Dec 2024 00:44:59 +1100 (AEDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1734183895;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=um83NFh7ZIRRd8ai46akYsrKyJ5hcwaKtVTR9gj1RFE=;
	b=Jb3sjXPQtHJuX/7nXJYOsTNk//t5xj2hfrYO6OGnyI1QDrXObAxHr2PB1JbZHBMHDCIRrp
	Dn82JlsgkPxiLXVh3L/DUZ6Q+OAKc4fE28H3Jkz29q/RzWfQu1HmOLS563IKwE82ocb4zJ
	xw6ldI1E4q2SeoqxZxkvs2sT6M8DefE=
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1734183896;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=um83NFh7ZIRRd8ai46akYsrKyJ5hcwaKtVTR9gj1RFE=;
	b=XfQ67DS9YqeOaSg3t6A5hgTexqGSpkhnzVCtovpTIdQEh/4WXDPwvFO80vfHMSmL7z/QX7
	N0O4L0m0dl6PsElnJOngIaD86GWzq1rPuxN38cfaAKjqOV0TR6vR9CQtzyZsSXhq05943X
	l04AP9kB8j4u57iMxV+qXlew6QQTJhI=
Received: from mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-638-ql_YDdrZOJec0ZI5AmZePg-1; Sat,
 14 Dec 2024 08:44:52 -0500
X-MC-Unique: ql_YDdrZOJec0ZI5AmZePg-1
X-Mimecast-MFC-AGG-ID: ql_YDdrZOJec0ZI5AmZePg
Received: from mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.12])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id A2AD4195608C;
	Sat, 14 Dec 2024 13:44:48 +0000 (UTC)
Received: from warthog.procyon.org.uk (unknown [10.42.28.48])
	by mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id EDE4A195394B;
	Sat, 14 Dec 2024 13:44:42 +0000 (UTC)
Organization: Red Hat UK Ltd. Registered Address: Red Hat UK Ltd, Amberley
	Place, 107-111 Peascod Street, Windsor, Berkshire, SI4 1TE, United
	Kingdom.
	Registered in England and Wales under Company Registration No. 3798903
From: David Howells <dhowells@redhat.com>
In-Reply-To: <27fff669-bec4-4255-ba2f-4b154b474d97@gmail.com>
References: <27fff669-bec4-4255-ba2f-4b154b474d97@gmail.com> <20241213135013.2964079-1-dhowells@redhat.com> <20241213135013.2964079-8-dhowells@redhat.com>
To: Akira Yokosawa <akiyks@gmail.com>,
    "Paul E. McKenney" <paulmck@kernel.org>
Subject: Re: [PATCH 07/10] netfs: Fix missing barriers by using clear_and_wake_up_bit()
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-ID: <3332015.1734183881.1@warthog.procyon.org.uk>
Content-Transfer-Encoding: quoted-printable
Date: Sat, 14 Dec 2024 13:44:41 +0000
Message-ID: <3332016.1734183881@warthog.procyon.org.uk>
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.12
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
Cc: linux-cifs@vger.kernel.org, Max Kellermann <max.kellermann@ionos.com>, v9fs@lists.linux.dev, Jeff Layton <jlayton@kernel.org>, linux-nfs@vger.kernel.org, Matthew Wilcox <willy@infradead.org>, linux-kernel@vger.kernel.org, dhowells@redhat.com, linux-mm@kvack.org, ceph-devel@vger.kernel.org, Zilin Guan <zilin@seu.edu.cn>, Christian Brauner <christian@brauner.io>, linux-fsdevel@vger.kernel.org, netfs@lists.linux.dev, Ilya Dryomov <idryomov@gmail.com>, Xiubo Li <xiubli@redhat.com>, linux-erofs@lists.ozlabs.org, linux-afs@lists.infradead.org, Trond Myklebust <trondmy@kernel.org>
Errors-To: linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org
Sender: "Linux-erofs" <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>

[Adding Paul McKenney as he's the expert.]

Akira Yokosawa <akiyks@gmail.com> wrote:

> David Howells wrote:
> > Use clear_and_wake_up_bit() rather than something like:
> > =

> > 	clear_bit_unlock(NETFS_RREQ_IN_PROGRESS, &rreq->flags);
> > 	wake_up_bit(&rreq->flags, NETFS_RREQ_IN_PROGRESS);
> > =

> > as there needs to be a barrier inserted between which is present in
> > clear_and_wake_up_bit().
> =

> If I am reading the kernel-doc comment of clear_bit_unlock() [1, 2]:
> =

>     This operation is atomic and provides release barrier semantics.
> =

> correctly, there already seems to be a barrier which should be
> good enough.
> =

> [1]: https://www.kernel.org/doc/html/latest/core-api/kernel-api.html#c.c=
lear_bit_unlock
> [2]: include/asm-generic/bitops/instrumented-lock.h
> =

> > =

> > Fixes: 288ace2f57c9 ("netfs: New writeback implementation")
> > Fixes: ee4cdf7ba857 ("netfs: Speed up buffered reading")
> =

> So I'm not sure this fixes anything.
> =

> What am I missing?

We may need two barriers.  You have three things to synchronise:

 (1) The stuff you did before unlocking.

 (2) The lock bit.

 (3) The task state.

clear_bit_unlock() interposes a release barrier between (1) and (2).

Neither clear_bit_unlock() nor wake_up_bit(), however, necessarily interpo=
se a
barrier between (2) and (3).  I'm not sure it entirely matters, but it see=
ms
that since we have a function that combines the two, we should probably us=
e
it - though, granted, it might not actually be a fix.

David

