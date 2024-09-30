Return-Path: <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>
X-Original-To: lists+linux-erofs@lfdr.de
Delivered-To: lists+linux-erofs@lfdr.de
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	by mail.lfdr.de (Postfix) with ESMTPS id 8CE2D98AC1F
	for <lists+linux-erofs@lfdr.de>; Mon, 30 Sep 2024 20:35:29 +0200 (CEST)
Received: from boromir.ozlabs.org (localhost [IPv6:::1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4XHVB62tpPz304s
	for <lists+linux-erofs@lfdr.de>; Tue,  1 Oct 2024 04:35:26 +1000 (AEST)
X-Original-To: linux-erofs@lists.ozlabs.org
Delivered-To: linux-erofs@lists.ozlabs.org
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip=170.10.129.124
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1727721324;
	cv=none; b=kWUO8zFpz7PiOcnTsef0I8L+BbCjG/lyJ9zg0WzOc0zHKHAP5SMFdIa6FpaMui4pFJQsVRChTkxSLFFXCNcWYC4qcx6pXug52CkzH9HJX+NSLo9TLaR+4CyIHKYPFms3UuaHwSAgOVWmpm56DOh2GVrCfWQ2AAcRXe0isEzNd3D06uTvz/JhTPW29u6FN5Z44a9e7XHiRx5GmHbVtQsIlnzfVI0DvqKq7CH1tmPblnWk+VGaId+URKcEriTvjtZ2Nl52LA6PBxP2uaBv9AaogUh1qfsLljnai/7kFJXHXLyDZHrsEmialtpPYKqxRJHSIVZwZ0x89f80CPGRMrPLRg==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1727721324; c=relaxed/relaxed;
	bh=7X8o4DowsqGONQ/4kasxk3OiTMOAJHVfF5+gN/kqpqg=;
	h=From:In-Reply-To:References:To:Cc:Subject:MIME-Version:
	 Content-Type:Date:Message-ID; b=RGi5tAW50j+jaJEW63n3Cqz/RfuZEMY/R+DqKFy75B2pl/1W4olhyYV6e/gx9C3vjrzaG+RVoaAbSTmjJMWHVhm1bU9sJoADlLM/O7qC9m9Ebz2aSbXVL9M7Hxi0UwOu4tDitKq+AN2c7dKRsgACM1X2OWEQvfAba5UuyJSthsQZM1JnnmErFZCXGZfZqE43a1a0tGOfPTWWJQZbjX9cjaw0BW+HUjnN+NHq/uJ+TD6jQr6cTMtXAcs1Zv7Zio96bevkJiv3K1bzP5hJmJfvSBvIuUV32vBut3JEyFdjtHKKLVY/x+QyOCfgS9O0jV1mHArd38Kwa2SjcBtY+2CYmw==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=redhat.com; dkim=pass (1024-bit key; unprotected) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=WkQOw5kt; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=WkQOw5kt; dkim-atps=neutral; spf=pass (client-ip=170.10.129.124; helo=us-smtp-delivery-124.mimecast.com; envelope-from=dhowells@redhat.com; receiver=lists.ozlabs.org) smtp.mailfrom=redhat.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (1024-bit key; unprotected) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=WkQOw5kt;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=WkQOw5kt;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=redhat.com (client-ip=170.10.129.124; helo=us-smtp-delivery-124.mimecast.com; envelope-from=dhowells@redhat.com; receiver=lists.ozlabs.org)
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4XHVB36fYJz2yNG
	for <linux-erofs@lists.ozlabs.org>; Tue,  1 Oct 2024 04:35:21 +1000 (AEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1727721318;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=7X8o4DowsqGONQ/4kasxk3OiTMOAJHVfF5+gN/kqpqg=;
	b=WkQOw5kt70R/WrIEdj2b5mUT+hMkUkKd1zw3+SQlm684xmNjgEdlKh6YEnR1NcV+AAGQ5a
	XxgkF0eCyqq9ff6s50XZKg9WFgamqjdUntt18PbzCzGFSJZ2Eztsi1vobHDwXhOfsPZObu
	JqdLvxAGYhKaNQteBTmxuJ5T7UQoPBw=
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1727721318;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=7X8o4DowsqGONQ/4kasxk3OiTMOAJHVfF5+gN/kqpqg=;
	b=WkQOw5kt70R/WrIEdj2b5mUT+hMkUkKd1zw3+SQlm684xmNjgEdlKh6YEnR1NcV+AAGQ5a
	XxgkF0eCyqq9ff6s50XZKg9WFgamqjdUntt18PbzCzGFSJZ2Eztsi1vobHDwXhOfsPZObu
	JqdLvxAGYhKaNQteBTmxuJ5T7UQoPBw=
Received: from mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-453--d_Kp97WPyK6rMA1zpyZig-1; Mon,
 30 Sep 2024 14:35:14 -0400
X-MC-Unique: -d_Kp97WPyK6rMA1zpyZig-1
Received: from mx-prod-int-02.mail-002.prod.us-west-2.aws.redhat.com (unknown [10.30.177.15])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 59638196A10F;
	Mon, 30 Sep 2024 18:35:11 +0000 (UTC)
Received: from warthog.procyon.org.uk (unknown [10.42.28.145])
	by mx-prod-int-02.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id 10E771944CF6;
	Mon, 30 Sep 2024 18:35:02 +0000 (UTC)
Organization: Red Hat UK Ltd. Registered Address: Red Hat UK Ltd, Amberley
	Place, 107-111 Peascod Street, Windsor, Berkshire, SI4 1TE, United
	Kingdom.
	Registered in England and Wales under Company Registration No. 3798903
From: David Howells <dhowells@redhat.com>
In-Reply-To: <423fbd9101dab18ba772f24db4ab2fecf5de2261.camel@gmail.com>
References: <423fbd9101dab18ba772f24db4ab2fecf5de2261.camel@gmail.com> <2968940.1727700270@warthog.procyon.org.uk> <20240925103118.GE967758@unreal> <20240923183432.1876750-1-chantr4@gmail.com> <20240814203850.2240469-20-dhowells@redhat.com> <1279816.1727220013@warthog.procyon.org.uk> <4b5621958a758da830c1cf09c6f6893aed371f9d.camel@gmail.com> <2969660.1727700717@warthog.procyon.org.uk>
To: Eduard Zingerman <eddyz87@gmail.com>
Subject: Re: [PATCH v2 19/25] netfs: Speed up buffered reading
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-ID: <3007427.1727721302.1@warthog.procyon.org.uk>
Date: Mon, 30 Sep 2024 19:35:02 +0100
Message-ID: <3007428.1727721302@warthog.procyon.org.uk>
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.15
X-Spam-Status: No, score=-0.3 required=5.0 tests=ARC_SIGNED,ARC_VALID,
	DKIMWL_WL_HIGH,DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
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
Cc: asmadeus@codewreck.org, dhowells@redhat.com, linux-mm@kvack.org, marc.dionne@auristor.com, linux-afs@lists.infradead.org, pc@manguebit.com, linux-cifs@vger.kernel.org, Leon Romanovsky <leon@kernel.org>, Manu Bretelle <chantr4@gmail.com>, willy@infradead.org, smfrench@gmail.com, hsiangkao@linux.alibaba.com, idryomov@gmail.com, sprasad@microsoft.com, linux-nfs@vger.kernel.org, tom@talpey.com, ceph-devel@vger.kernel.org, ericvh@kernel.org, christian@brauner.io, Christian Brauner <brauner@kernel.org>, netdev@vger.kernel.org, v9fs@lists.linux.dev, jlayton@kernel.org, linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org, netfs@lists.linux.dev, linux-erofs@lists.ozlabs.org
Errors-To: linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org
Sender: "Linux-erofs" <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>

Eduard Zingerman <eddyz87@gmail.com> wrote:

> Are there any hacks possible to printout tracelog before complete boot
> somehow?

You could try setting CONFIG_NETFS_DEBUG=y.  That'll print some stuff to
dmesg.

David

