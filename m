Return-Path: <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>
X-Original-To: lists+linux-erofs@lfdr.de
Delivered-To: lists+linux-erofs@lfdr.de
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2404:9400:2:0:216:3eff:fee1:b9f1])
	by mail.lfdr.de (Postfix) with ESMTPS id 3074895D306
	for <lists+linux-erofs@lfdr.de>; Fri, 23 Aug 2024 18:19:26 +0200 (CEST)
Received: from boromir.ozlabs.org (localhost [IPv6:::1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4Wr4yg6Ph9z301T
	for <lists+linux-erofs@lfdr.de>; Sat, 24 Aug 2024 02:19:23 +1000 (AEST)
X-Original-To: linux-erofs@lists.ozlabs.org
Delivered-To: linux-erofs@lists.ozlabs.org
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip=170.10.133.124
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1724429962;
	cv=none; b=KDsHM65T+6qm9Bm6SFZ5Je9fpyw3JjrZL3nxetxqw7iGpONc15TzPyHREg3lFyLLdKrQLWqKhdHTUXbUN3JdrnLvzjOIKhCSO0RlVNAHfyRb68aFXcz8PlDK/awqFvCO2SMS7WdbZ9Caz7zJ4bfvN4Olh+AX5ouuUVjeBZXKZ698lA2d5gTStzUHNrjk6vDhB9RQws887HC89+XBCfmtCXJ9VcKkQGgjE3jC+m/VKyeAB8V1qfQP1XQfAio5G21j0j7czCa4Cx8/CL3JQuqZhhuK0s/HxBuvY0QSgXrZfA8uzf+08YriHF6hEl3qQaVXBb1JZhUih2oPNntl6XwNjg==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1724429962; c=relaxed/relaxed;
	bh=a7OM/W0EJtp2+JAIBDghW4ypLqo6G3RHtMu+hNZuDVs=;
	h=DKIM-Signature:DKIM-Signature:Received:X-MC-Unique:Received:
	 Received:Organization:From:In-Reply-To:References:To:Cc:Subject:
	 MIME-Version:Content-Type:Content-ID:Date:Message-ID:X-Scanned-By;
	b=EcLBg+KqUx9p7Fv/IidoX6bfp2gVuEJoBXs2bXGU0UiFNd0Nb71qIl1/ENVwOkjyoQGdccsHE0bK+xgtIN/mElJ7Yv7ykxd8VVNuOf7qBTVjl/P0htJTFYegaryZU+OS0Xq3iSOV+TXlJy1tklp+1a1gmH6uYpJml32Z7rKwjmH7ZcI02z7OiK5XeeBfXSaNSrqM4daJZ/3L2FKFdy7LXDFRwwP7aMJCfzi45zpWZ/cndW0BoNr6SyndsiS8NCiZ4IqWrEpin0Re48Nyws7qlF8YBq8SBN7UQHGVQIUSQd/p0Ee4KSE33oT+2G99CVeM7O6NHmLhZA+i4yzcqm88kw==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=redhat.com; dkim=pass (1024-bit key; unprotected) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=Uzlt0cQY; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=BGtjnNUw; dkim-atps=neutral; spf=pass (client-ip=170.10.133.124; helo=us-smtp-delivery-124.mimecast.com; envelope-from=dhowells@redhat.com; receiver=lists.ozlabs.org) smtp.mailfrom=redhat.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (1024-bit key; unprotected) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=Uzlt0cQY;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=BGtjnNUw;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=redhat.com (client-ip=170.10.133.124; helo=us-smtp-delivery-124.mimecast.com; envelope-from=dhowells@redhat.com; receiver=lists.ozlabs.org)
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4Wr4yf0rTdz2xb3
	for <linux-erofs@lists.ozlabs.org>; Sat, 24 Aug 2024 02:19:21 +1000 (AEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1724429957;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=a7OM/W0EJtp2+JAIBDghW4ypLqo6G3RHtMu+hNZuDVs=;
	b=Uzlt0cQYkCNTP5BFHfUINnqdFDidliOcRTfLKHO1KuqapfFv17uktJTyQJ9uFYa3AmOu0A
	R8awRazH0RYzaFaXApuK3YFsYp3ACwdFhsvLNtRkysfmg++xrE+I5Om6DP+T0IVuwg/fSD
	OXaUq/1+c5yQnbELMGl8EvmfvG2JjNo=
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1724429958;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=a7OM/W0EJtp2+JAIBDghW4ypLqo6G3RHtMu+hNZuDVs=;
	b=BGtjnNUw+jx4nRjYJk1C5rCLv9B7Jkxr9HBHDk9hHFq2jWtIVBmUExaIU7M8Z3ruki5xXi
	1PV40WxMB/aqvUBfsnUM5BRvZRDuofiSS/D19rwhKGx2wBmRY5c/ggVTCi7V20MmJVpBBO
	FNWlOsUKQbkQadWVie6zLMQA4p0YoPM=
Received: from mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-562-iuW8mKDwMJKn3vMTBBxWRA-1; Fri,
 23 Aug 2024 12:19:14 -0400
X-MC-Unique: iuW8mKDwMJKn3vMTBBxWRA-1
Received: from mx-prod-int-02.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-02.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.15])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id DDF911955BED;
	Fri, 23 Aug 2024 16:19:11 +0000 (UTC)
Received: from warthog.procyon.org.uk (unknown [10.42.28.30])
	by mx-prod-int-02.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id 6ACE019560AA;
	Fri, 23 Aug 2024 16:19:07 +0000 (UTC)
Organization: Red Hat UK Ltd. Registered Address: Red Hat UK Ltd, Amberley
	Place, 107-111 Peascod Street, Windsor, Berkshire, SI4 1TE, United
	Kingdom.
	Registered in England and Wales under Company Registration No. 3798903
From: David Howells <dhowells@redhat.com>
In-Reply-To: <20240823161209.434705-1-dhowells@redhat.com>
References: <20240823161209.434705-1-dhowells@redhat.com>
To: Steve French <sfrench@samba.org>, Jeremy Allison <jra@samba.org>,
    samba-technical@lists.samba.org
Subject: Samba llseek bug
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-ID: <434991.1724429946.1@warthog.procyon.org.uk>
Date: Fri, 23 Aug 2024 17:19:06 +0100
Message-ID: <434992.1724429946@warthog.procyon.org.uk>
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.15
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
Cc: Paulo Alcantara <pc@manguebit.com>, linux-cifs@vger.kernel.org, linux-nfs@vger.kernel.org, v9fs@lists.linux.dev, Jeff Layton <jlayton@kernel.org>, linux-kernel@vger.kernel.org, Matthew Wilcox <willy@infradead.org>, dhowells@redhat.com, linux-mm@kvack.org, linux-fsdevel@vger.kernel.org, netfs@lists.linux.dev, ceph-devel@vger.kernel.org, linux-erofs@lists.ozlabs.org, linux-afs@lists.infradead.org, Christian Brauner <christian@brauner.io>
Errors-To: linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org
Sender: "Linux-erofs" <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>

Note that whilst testing my cifs fixes with the generic/075 and generic/112
xfstests, the tests occasionally hit a bug in Samba whereby llseek() fails
because there are too many extents in the server file for the server to
report.  I've noted this before:

	https://lore.kernel.org/linux-cifs/349671.1716335639@warthog.procyon.org.uk/

is there a fix for this I can try?

David

