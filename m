Return-Path: <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>
X-Original-To: lists+linux-erofs@lfdr.de
Delivered-To: lists+linux-erofs@lfdr.de
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2404:9400:2:0:216:3eff:fee1:b9f1])
	by mail.lfdr.de (Postfix) with ESMTPS id F399193ADD6
	for <lists+linux-erofs@lfdr.de>; Wed, 24 Jul 2024 10:15:53 +0200 (CEST)
Authentication-Results: lists.ozlabs.org;
	dkim=fail reason="signature verification failed" (1024-bit key; unprotected) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=gxuubEhw;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=gxuubEhw;
	dkim-atps=neutral
Received: from boromir.ozlabs.org (localhost [IPv6:::1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4WTRfb6CXkz3cnZ
	for <lists+linux-erofs@lfdr.de>; Wed, 24 Jul 2024 18:15:51 +1000 (AEST)
X-Original-To: linux-erofs@lists.ozlabs.org
Delivered-To: linux-erofs@lists.ozlabs.org
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (1024-bit key; unprotected) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=gxuubEhw;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=gxuubEhw;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=redhat.com (client-ip=170.10.129.124; helo=us-smtp-delivery-124.mimecast.com; envelope-from=dhowells@redhat.com; receiver=lists.ozlabs.org)
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4WTRfW6Xqyz3cRR
	for <linux-erofs@lists.ozlabs.org>; Wed, 24 Jul 2024 18:15:45 +1000 (AEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1721808943;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=jyvRNlCo7H0nMKeExwfupCt0YeZsChO27NKXONbPwMM=;
	b=gxuubEhwAXW/cmu0ILzF+ZfzocwBgLxdvCOeUd8uNCZnrPKwDg1cvLLBDOe9ap28D1/g9S
	8VARJ4ZbxDM1XeErCyNwJGN6X0TTTAyC2+gF6sgnnrouGpqdhQRyFFU3pmXoXpqmJcx2aQ
	FyjqH876quhns9xnl34DFGr0MrwCudI=
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1721808943;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=jyvRNlCo7H0nMKeExwfupCt0YeZsChO27NKXONbPwMM=;
	b=gxuubEhwAXW/cmu0ILzF+ZfzocwBgLxdvCOeUd8uNCZnrPKwDg1cvLLBDOe9ap28D1/g9S
	8VARJ4ZbxDM1XeErCyNwJGN6X0TTTAyC2+gF6sgnnrouGpqdhQRyFFU3pmXoXpqmJcx2aQ
	FyjqH876quhns9xnl34DFGr0MrwCudI=
Received: from mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-299-93UXihc1OoisumPKDlRIJw-1; Wed,
 24 Jul 2024 04:11:23 -0400
X-MC-Unique: 93UXihc1OoisumPKDlRIJw-1
Received: from mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.4])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 0A00C19560A1;
	Wed, 24 Jul 2024 08:11:21 +0000 (UTC)
Received: from warthog.procyon.org.uk (unknown [10.42.28.216])
	by mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id 92B4B3000197;
	Wed, 24 Jul 2024 08:11:17 +0000 (UTC)
Organization: Red Hat UK Ltd. Registered Address: Red Hat UK Ltd, Amberley
	Place, 107-111 Peascod Street, Windsor, Berkshire, SI4 1TE, United
	Kingdom.
	Registered in England and Wales under Company Registration No. 3798903
From: David Howells <dhowells@redhat.com>
In-Reply-To: <20240723125710.mtnfaycuvdi4dpdy@quack3>
References: <20240723125710.mtnfaycuvdi4dpdy@quack3> <2136178.1721725194@warthog.procyon.org.uk>
To: Jan Kara <jack@suse.cz>
Subject: Re: [PATCH] vfs: Fix potential circular locking through setxattr() and removexattr()
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-ID: <2237317.1721808676.1@warthog.procyon.org.uk>
Date: Wed, 24 Jul 2024 09:11:16 +0100
Message-ID: <2237318.1721808676@warthog.procyon.org.uk>
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.4
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
Cc: Christian Brauner <brauner@kernel.org>, Jeff Layton <jlayton@kernel.org>, linux-kernel@vger.kernel.org, Matthew Wilcox <willy@infradead.org>, dhowells@redhat.com, Alexander Viro <viro@zeniv.linux.org.uk>, linux-fsdevel@vger.kernel.org, netfs@lists.linux.dev, linux-erofs@lists.ozlabs.org
Errors-To: linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org
Sender: "Linux-erofs" <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>

Jan Kara <jack@suse.cz> wrote:

> > +	error = strncpy_from_user(kname, name, sizeof(kname));
> > +	if (error == 0 || error == sizeof(kname))
> > +		error = -ERANGE;
> > +	if (error < 0)
> > +		return error;
> 
> Missing fdput() here.

Thanks.  I think Christian is altering the patch to use auto-destruction
constructs (CLASS()).

David

