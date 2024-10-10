Return-Path: <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>
X-Original-To: lists+linux-erofs@lfdr.de
Delivered-To: lists+linux-erofs@lfdr.de
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	by mail.lfdr.de (Postfix) with ESMTPS id 128679984A7
	for <lists+linux-erofs@lfdr.de>; Thu, 10 Oct 2024 13:17:09 +0200 (CEST)
Received: from boromir.ozlabs.org (localhost [IPv6:::1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4XPRzj2lJGz3bjg
	for <lists+linux-erofs@lfdr.de>; Thu, 10 Oct 2024 22:17:05 +1100 (AEDT)
X-Original-To: linux-erofs@lists.ozlabs.org
Delivered-To: linux-erofs@lists.ozlabs.org
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip=170.10.129.124
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1728559024;
	cv=none; b=TA3ytzpXwETQaiglW9rg07m046Cl9zw+3MfOkDRHF0liQFw/6+/r1pJxHjzKJlVXouiM08cq/B2u/ukwt81ovErZfPGgIbZ7fuQ1ZReoBfWoaHLf+qT3jKdbpLVjX0oySJqvrPZT1QkY45bMuCIoyh+q2kqUqCbwA6oKp+n12j85x3nyg05G/dJBT6nIKqzlXHdb+UXMEoKv+1BhBvne/a09y8W9H/XOpNU5yevVe86IpaykWxR+KZANq6AC3U0lfCvCi4U0jf2s1I/zockPRrX659AUdEkHthOUJxTrJxVMyS7922D4fxIn1xDq2iYLSmyoi6f7ezJ+PH3s7oDu8Q==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1728559024; c=relaxed/relaxed;
	bh=+5tSqNiLfQZoZqE5JUG8Byob3AcTf76CH9na62lK+mk=;
	h=From:In-Reply-To:References:To:Cc:Subject:MIME-Version:
	 Content-Type:Date:Message-ID; b=gLTmFmaQtCkIXGbRusGKtVozjwT40BtwYmCwxtxeIdMA5j3xHhQ9yzQ+jo+ifHvwucE+KxmYiSexP6cuGYwyj15LsY1gtmpvfA4ViTrS/pIyYYPGTNbslPS6ihL/dnyVZE03VDITfefbBnTR6EI8yJyB5RaL0nqXdWmHHxFVWvvxJ1+wXsclIhGo30co52h9Q0VImpdYk6RHdxwmi0Ij3J8pdg1CWlG0X5zu4PLvTIHCCDohE1zIQH3SOiN+5bbOWYhdMwy2q5Lz+tHVPWIbwPnlEmz20OxFtdgKpFzwc4FS7VU9ZOD4hc5DCbZaAFLQk90UDtumJTSUtj4H3IJZmQ==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=redhat.com; dkim=pass (1024-bit key; unprotected) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=AH0UWkmn; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=AH0UWkmn; dkim-atps=neutral; spf=pass (client-ip=170.10.129.124; helo=us-smtp-delivery-124.mimecast.com; envelope-from=dhowells@redhat.com; receiver=lists.ozlabs.org) smtp.mailfrom=redhat.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (1024-bit key; unprotected) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=AH0UWkmn;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=AH0UWkmn;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=redhat.com (client-ip=170.10.129.124; helo=us-smtp-delivery-124.mimecast.com; envelope-from=dhowells@redhat.com; receiver=lists.ozlabs.org)
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4XPRzg3S2rz3bdV
	for <linux-erofs@lists.ozlabs.org>; Thu, 10 Oct 2024 22:17:02 +1100 (AEDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1728559019;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=+5tSqNiLfQZoZqE5JUG8Byob3AcTf76CH9na62lK+mk=;
	b=AH0UWkmnInE6gi60SeKDJ8AFZol++OGVcgfyl9p79ZlJVN1M6sWv53aDYaEdOmNiQ79/4t
	oN7gyT57Cyo7VTClBHegTXUVBC6aquudEVC9rBOcwBjxbzxnX27BEArC8FwZrZLOcuchFi
	lq0z2va1rZFFdhERlLRSE1AbjhRGXWU=
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1728559019;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=+5tSqNiLfQZoZqE5JUG8Byob3AcTf76CH9na62lK+mk=;
	b=AH0UWkmnInE6gi60SeKDJ8AFZol++OGVcgfyl9p79ZlJVN1M6sWv53aDYaEdOmNiQ79/4t
	oN7gyT57Cyo7VTClBHegTXUVBC6aquudEVC9rBOcwBjxbzxnX27BEArC8FwZrZLOcuchFi
	lq0z2va1rZFFdhERlLRSE1AbjhRGXWU=
Received: from mx-prod-mc-02.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-621-N_qhrj8XOVeNEqrYwZJs2A-1; Thu,
 10 Oct 2024 07:16:52 -0400
X-MC-Unique: N_qhrj8XOVeNEqrYwZJs2A-1
Received: from mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.4])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-02.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 1221D1955EE6;
	Thu, 10 Oct 2024 11:16:49 +0000 (UTC)
Received: from warthog.procyon.org.uk (unknown [10.42.28.4])
	by mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id 37228300018D;
	Thu, 10 Oct 2024 11:16:44 +0000 (UTC)
Organization: Red Hat UK Ltd. Registered Address: Red Hat UK Ltd, Amberley
	Place, 107-111 Peascod Street, Windsor, Berkshire, SI4 1TE, United
	Kingdom.
	Registered in England and Wales under Company Registration No. 3798903
From: David Howells <dhowells@redhat.com>
In-Reply-To: <20240821024301.1058918-5-wozizhi@huawei.com>
References: <20240821024301.1058918-5-wozizhi@huawei.com> <20240821024301.1058918-1-wozizhi@huawei.com>
To: Zizhi Wo <wozizhi@huawei.com>
Subject: Re: [PATCH 4/8] cachefiles: Clear invalid cache data in advance
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-ID: <303669.1728559002.1@warthog.procyon.org.uk>
Date: Thu, 10 Oct 2024 12:16:42 +0100
Message-ID: <303670.1728559002@warthog.procyon.org.uk>
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.4
X-Spam-Status: No, score=-0.3 required=5.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
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
Cc: yangerkun@huawei.com, jlayton@kernel.org, linux-kernel@vger.kernel.org, dhowells@redhat.com, linux-fsdevel@vger.kernel.org, hsiangkao@linux.alibaba.com, netfs@lists.linux.dev, linux-erofs@lists.ozlabs.org, yukuai3@huawei.com
Errors-To: linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org
Sender: "Linux-erofs" <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>

Zizhi Wo <wozizhi@huawei.com> wrote:

> In the current on-demand loading scenario, when umount is called, the
> cachefiles_commit_tmpfile() is invoked. When checking the inode
> corresponding to object->file is inconsistent with the dentry,
> cachefiles_unlink() is called to perform cleanup to prevent invalid data
> from occupying space.
> 
> The above operation does not apply to the first mount, because the cache
> dentry generated by the first mount must be negative. Moreover, there is no
> need to clear it during the first umount because this part of the data may
> be reusable in the future. But the problem is that, the clean operation can
> currently only be called through cachefiles_withdraw_cookie(), in other
> words the redundant data does not cleaned until the second umount. This
> means that during the second mount, the old cache data generated from the
> first mount still occupies space. So if the user does not manually clean up
> the previous cache before the next mount, it may return insufficient space
> during the second mount phase.
> 
> This patch adds an additional cleanup process in the cachefiles_open_file()
> function. When the auxdata check fails, the remaining old cache data is no
> longer needed, the file and dentry corresponding to the object are also
> put. As there is no need to clear it until umount, we can directly clear it
> during the mount process.
> 
> Signed-off-by: Zizhi Wo <wozizhi@huawei.com>

Okay, I think this is reasonable as it's done from a worker thread.  I wonder
if instead, though, cachefiles_create_file() should be called and then linked
over the top:

	https://lore.kernel.org/all/cover.1580251857.git.osandov@fb.com/

though AT_LINK_REPLACE seemed to get stuck.

Note that we can't just truncate the file to nothing instead because I/O might
be in progress on it.

David

