Return-Path: <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>
X-Original-To: lists+linux-erofs@lfdr.de
Delivered-To: lists+linux-erofs@lfdr.de
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2404:9400:2:0:216:3eff:fee1:b9f1])
	by mail.lfdr.de (Postfix) with ESMTPS id 70CC0894DD9
	for <lists+linux-erofs@lfdr.de>; Tue,  2 Apr 2024 10:46:37 +0200 (CEST)
Authentication-Results: lists.ozlabs.org;
	dkim=fail reason="signature verification failed" (1024-bit key; unprotected) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=VqwFRc44;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=VqwFRc44;
	dkim-atps=neutral
Received: from boromir.ozlabs.org (localhost [IPv6:::1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4V81hC2Dsgz3dRm
	for <lists+linux-erofs@lfdr.de>; Tue,  2 Apr 2024 19:46:35 +1100 (AEDT)
X-Original-To: linux-erofs@lists.ozlabs.org
Delivered-To: linux-erofs@lists.ozlabs.org
Authentication-Results: lists.ozlabs.org;
	dkim=pass (1024-bit key; unprotected) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=VqwFRc44;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=VqwFRc44;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=redhat.com (client-ip=170.10.133.124; helo=us-smtp-delivery-124.mimecast.com; envelope-from=dhowells@redhat.com; receiver=lists.ozlabs.org)
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4V81h461J6z2x9T
	for <linux-erofs@lists.ozlabs.org>; Tue,  2 Apr 2024 19:46:28 +1100 (AEDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1712047585;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=/8zVm5/YGf5Pgwy9JsdjJMXQWirBEfx89VnmYMfPJM4=;
	b=VqwFRc44WhxljDGVUN5D/ODIaNb783psNmQ8L/wKELF0mo7Gh9/GikBwqlMCyJBVpkUta2
	bP1QeNRBudjvmaCXe/XMCIDK5uHrvdupdqN9fSFvfp+piz9JFKDdPSNn+qRegrdOZmgMyv
	dsgWuH56BUev6r/Gu3RRBMd7DXSxb8A=
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1712047585;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=/8zVm5/YGf5Pgwy9JsdjJMXQWirBEfx89VnmYMfPJM4=;
	b=VqwFRc44WhxljDGVUN5D/ODIaNb783psNmQ8L/wKELF0mo7Gh9/GikBwqlMCyJBVpkUta2
	bP1QeNRBudjvmaCXe/XMCIDK5uHrvdupdqN9fSFvfp+piz9JFKDdPSNn+qRegrdOZmgMyv
	dsgWuH56BUev6r/Gu3RRBMd7DXSxb8A=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-158-jPb3_1pmPI27HEkPRk0xlA-1; Tue, 02 Apr 2024 04:46:21 -0400
X-MC-Unique: jPb3_1pmPI27HEkPRk0xlA-1
Received: from smtp.corp.redhat.com (int-mx07.intmail.prod.int.rdu2.redhat.com [10.11.54.7])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 7A144185A784;
	Tue,  2 Apr 2024 08:46:20 +0000 (UTC)
Received: from warthog.procyon.org.uk (unknown [10.42.28.146])
	by smtp.corp.redhat.com (Postfix) with ESMTP id 5D5BC1C060A4;
	Tue,  2 Apr 2024 08:46:16 +0000 (UTC)
Organization: Red Hat UK Ltd. Registered Address: Red Hat UK Ltd, Amberley
	Place, 107-111 Peascod Street, Windsor, Berkshire, SI4 1TE, United
	Kingdom.
	Registered in England and Wales under Company Registration No. 3798903
From: David Howells <dhowells@redhat.com>
In-Reply-To: <20240328163424.2781320-20-dhowells@redhat.com>
References: <20240328163424.2781320-20-dhowells@redhat.com> <20240328163424.2781320-1-dhowells@redhat.com>
To: Dan Carpenter <dan.carpenter@linaro.org>,
    Naveen Mamindlapalli <naveenm@marvell.com>,
    Vadim Fedorenko <vadim.fedorenko@linux.dev>
Subject: Re: [PATCH 19/26] netfs: New writeback implementation
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-ID: <3047563.1712047571.1@warthog.procyon.org.uk>
Content-Transfer-Encoding: quoted-printable
Date: Tue, 02 Apr 2024 09:46:11 +0100
Message-ID: <3047564.1712047571@warthog.procyon.org.uk>
X-Scanned-By: MIMEDefang 3.4.1 on 10.11.54.7
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
Cc: Latchesar Ionkov <lucho@ionkov.net>, Dominique Martinet <asmadeus@codewreck.org>, Christian Schoenebeck <linux_oss@crudebyte.com>, dhowells@redhat.com, linux-mm@kvack.org, Marc Dionne <marc.dionne@auristor.com>, linux-afs@lists.infradead.org, Paulo Alcantara <pc@manguebit.com>, linux-cifs@vger.kernel.org, Matthew Wilcox <willy@infradead.org>, Steve French <smfrench@gmail.com>, linux-cachefs@redhat.com, Gao Xiang <hsiangkao@linux.alibaba.com>, Ilya Dryomov <idryomov@gmail.com>, Shyam Prasad N <sprasad@microsoft.com>, Tom Talpey <tom@talpey.com>, ceph-devel@vger.kernel.org, Eric Van Hensbergen <ericvh@kernel.org>, Christian Brauner <christian@brauner.io>, linux-nfs@vger.kernel.org, netdev@vger.kernel.org, v9fs@lists.linux.dev, Jeff Layton <jlayton@kernel.org>, linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org, netfs@lists.linux.dev, linux-erofs@lists.ozlabs.org
Errors-To: linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org
Sender: "Linux-erofs" <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>

David Howells <dhowells@redhat.com> wrote:

> +struct netfs_io_request *new_netfs_begin_writethrough(struct kiocb *ioc=
b, size_t len)
> +{
> +	struct netfs_io_request *wreq =3D NULL;
> +	struct netfs_inode *ictx =3D netfs_inode(file_inode(iocb->ki_filp));
> +
> +	mutex_lock(&ictx->wb_lock);
> +
> +	wreq =3D netfs_create_write_req(iocb->ki_filp->f_mapping, iocb->ki_fil=
p,
> +				      iocb->ki_pos, NETFS_WRITETHROUGH);
> +	if (IS_ERR(wreq))
> +		mutex_unlock(&ictx->wb_lock);

This needs a "return wreq;" adding and appropriate braces.  Thanks to thos=
e
who pointed it out.

David

