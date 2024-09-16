Return-Path: <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>
X-Original-To: lists+linux-erofs@lfdr.de
Delivered-To: lists+linux-erofs@lfdr.de
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	by mail.lfdr.de (Postfix) with ESMTPS id 9776697A2B4
	for <lists+linux-erofs@lfdr.de>; Mon, 16 Sep 2024 15:05:36 +0200 (CEST)
Received: from boromir.ozlabs.org (localhost [IPv6:::1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4X6lWx4Z3Gz2yYn
	for <lists+linux-erofs@lfdr.de>; Mon, 16 Sep 2024 23:05:33 +1000 (AEST)
X-Original-To: linux-erofs@lists.ozlabs.org
Delivered-To: linux-erofs@lists.ozlabs.org
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip=170.10.133.124
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1726491930;
	cv=none; b=LmS4D2ByH6y1VD26MPqgMOeqhGa2/KUKge8Sd424EiPGqZJHcFh6ep7sgM2OZqwDG31xvMsmsfDEgVGM/+5dembgUY5XkSaTHy0/vQVZfxs++TubGdlAlyfwxi2I6+uevOALJeK8dn/s/o8hj7C5xz9YTbpulEKnbbdYGg2DUr8nmhyTGTa9gjTawCyyQ344yBpu6TkpGewFjnChJjCw7f5girzt8SXvxNlTEkfYXYP8bjBfd1OzbnEMegNGKCQuh/P418d3LwxPmneUFaTyyzmrJq1DEk3B+ZWWiD87wzJKKTW7vKAjXQE2cq25aeDdW9YWJ92Lsb1AU5S3PdkIGg==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1726491930; c=relaxed/relaxed;
	bh=3Fz2Otqr1x0kPcbKDKf2bmB2iDmlHXr2EPIDX2kJglM=;
	h=From:In-Reply-To:References:To:Cc:Subject:MIME-Version:
	 Content-Type:Date:Message-ID; b=fNntdhKGwY66hr4a8+cpkSSJeeNm43kgIBNsufWcaLWwzGAcaeGyOY21nvRv4il/nzbkeavxNVr/G0nYr5CidWRZCrT0NdvVAMlSF9DA2bq561y20PWZiKVkBPSpuCl0Dvl7m+F/B/7RxSyQSpTsPKNCXt/g/jKjqNNu4HPyyKjcObCSL2yj1QBKzuPQV1XbWfMsgLfmVXJc/2aAgjb824PNMH29ae2vUCZL47p3iWsambiif69NHVMiZxIHX1jZb8JRvjPfP4S0OmXXEJrD+nSBuenTHKVW2zlQhfS5GNVA/8BxZTlRWNg0boPPq+s/AE0YcoK9jeyiomYq6kYZWw==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=redhat.com; dkim=pass (1024-bit key; unprotected) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=HG2NmMAI; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=HG2NmMAI; dkim-atps=neutral; spf=pass (client-ip=170.10.133.124; helo=us-smtp-delivery-124.mimecast.com; envelope-from=dhowells@redhat.com; receiver=lists.ozlabs.org) smtp.mailfrom=redhat.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (1024-bit key; unprotected) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=HG2NmMAI;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=HG2NmMAI;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=redhat.com (client-ip=170.10.133.124; helo=us-smtp-delivery-124.mimecast.com; envelope-from=dhowells@redhat.com; receiver=lists.ozlabs.org)
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4X6lWt0fzjz2yNs
	for <linux-erofs@lists.ozlabs.org>; Mon, 16 Sep 2024 23:05:27 +1000 (AEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1726491923;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=3Fz2Otqr1x0kPcbKDKf2bmB2iDmlHXr2EPIDX2kJglM=;
	b=HG2NmMAIubUvBcYtNeMZlvJy4Q4mXugiz3zvtjappTPwCQTXymK0Drr1zyWZcmMtlcJIBg
	TWwjYlXnjM0nwzspYgakcG0YJncm5ccmmSUdhYOQnbr+ks4BEs7qT91fJ/iEjNR60mztuF
	jxh3n+w1frmfKVChx+3CHJ2MBDjidqM=
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1726491923;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=3Fz2Otqr1x0kPcbKDKf2bmB2iDmlHXr2EPIDX2kJglM=;
	b=HG2NmMAIubUvBcYtNeMZlvJy4Q4mXugiz3zvtjappTPwCQTXymK0Drr1zyWZcmMtlcJIBg
	TWwjYlXnjM0nwzspYgakcG0YJncm5ccmmSUdhYOQnbr+ks4BEs7qT91fJ/iEjNR60mztuF
	jxh3n+w1frmfKVChx+3CHJ2MBDjidqM=
Received: from mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-670-U_07DsiXMa2szt0yLJCLvg-1; Mon,
 16 Sep 2024 09:05:19 -0400
X-MC-Unique: U_07DsiXMa2szt0yLJCLvg-1
Received: from mx-prod-int-02.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-02.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.15])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 748921955DC8;
	Mon, 16 Sep 2024 13:05:16 +0000 (UTC)
Received: from warthog.procyon.org.uk (unknown [10.42.28.14])
	by mx-prod-int-02.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id 9AC4D1956088;
	Mon, 16 Sep 2024 13:05:10 +0000 (UTC)
Organization: Red Hat UK Ltd. Registered Address: Red Hat UK Ltd, Amberley
	Place, 107-111 Peascod Street, Windsor, Berkshire, SI4 1TE, United
	Kingdom.
	Registered in England and Wales under Company Registration No. 3798903
From: David Howells <dhowells@redhat.com>
In-Reply-To: <20240829083409.3788142-1-libaokun@huaweicloud.com>
References: <20240829083409.3788142-1-libaokun@huaweicloud.com>
To: libaokun@huaweicloud.com
Subject: Re: [PATCH v2] cachefiles: fix dentry leak in cachefiles_open_file()
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-ID: <1899864.1726491909.1@warthog.procyon.org.uk>
Content-Transfer-Encoding: quoted-printable
Date: Mon, 16 Sep 2024 14:05:09 +0100
Message-ID: <1899865.1726491909@warthog.procyon.org.uk>
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
Cc: brauner@kernel.org, yangerkun@huawei.com, jlayton@kernel.org, linux-kernel@vger.kernel.org, stable@kernel.org, dhowells@redhat.com, hsiangkao@linux.alibaba.com, linux-fsdevel@vger.kernel.org, netfs@lists.linux.dev, linux-erofs@lists.ozlabs.org, yukuai3@huawei.com
Errors-To: linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org
Sender: "Linux-erofs" <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>

libaokun@huaweicloud.com wrote:

> From: Baokun Li <libaokun1@huawei.com>
> =

> A dentry leak may be caused when a lookup cookie and a cull are concurre=
nt:
> =

>             P1             |             P2
> -----------------------------------------------------------
> cachefiles_lookup_cookie
>   cachefiles_look_up_object
>     lookup_one_positive_unlocked
>      // get dentry
>                             cachefiles_cull
>                               inode->i_flags |=3D S_KERNEL_FILE;
>     cachefiles_open_file
>       cachefiles_mark_inode_in_use
>         __cachefiles_mark_inode_in_use
>           can_use =3D false
>           if (!(inode->i_flags & S_KERNEL_FILE))
>             can_use =3D true
> 	  return false
>         return false
>         // Returns an error but doesn't put dentry
> =

> After that the following WARNING will be triggered when the backend fold=
er
> is umounted:
> =

> =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
> BUG: Dentry 000000008ad87947{i=3D7a,n=3DDx_1_1.img}  still in use (1) [u=
nmount of ext4 sda]
> WARNING: CPU: 4 PID: 359261 at fs/dcache.c:1767 umount_check+0x5d/0x70
> CPU: 4 PID: 359261 Comm: umount Not tainted 6.6.0-dirty #25
> RIP: 0010:umount_check+0x5d/0x70
> Call Trace:
>  <TASK>
>  d_walk+0xda/0x2b0
>  do_one_tree+0x20/0x40
>  shrink_dcache_for_umount+0x2c/0x90
>  generic_shutdown_super+0x20/0x160
>  kill_block_super+0x1a/0x40
>  ext4_kill_sb+0x22/0x40
>  deactivate_locked_super+0x35/0x80
>  cleanup_mnt+0x104/0x160
> =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
> =

> Whether cachefiles_open_file() returns true or false, the reference coun=
t
> obtained by lookup_positive_unlocked() in cachefiles_look_up_object()
> should be released.
> =

> Therefore release that reference count in cachefiles_look_up_object() to
> fix the above issue and simplify the code.
> =

> Fixes: 1f08c925e7a3 ("cachefiles: Implement backing file wrangling")
> Cc: stable@kernel.org
> Signed-off-by: Baokun Li <libaokun1@huawei.com>

Acked-by: David Howells <dhowells@redhat.com>

