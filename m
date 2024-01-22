Return-Path: <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>
X-Original-To: lists+linux-erofs@lfdr.de
Delivered-To: lists+linux-erofs@lfdr.de
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2404:9400:2:0:216:3eff:fee1:b9f1])
	by mail.lfdr.de (Postfix) with ESMTPS id 94C49836289
	for <lists+linux-erofs@lfdr.de>; Mon, 22 Jan 2024 12:50:32 +0100 (CET)
Authentication-Results: lists.ozlabs.org;
	dkim=fail reason="signature verification failed" (1024-bit key; unprotected) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=T6ZSrYT0;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=T6ZSrYT0;
	dkim-atps=neutral
Received: from boromir.ozlabs.org (localhost [IPv6:::1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4TJT7B10Kgz3bsQ
	for <lists+linux-erofs@lfdr.de>; Mon, 22 Jan 2024 22:50:30 +1100 (AEDT)
X-Original-To: linux-erofs@lists.ozlabs.org
Delivered-To: linux-erofs@lists.ozlabs.org
Authentication-Results: lists.ozlabs.org;
	dkim=pass (1024-bit key; unprotected) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=T6ZSrYT0;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=T6ZSrYT0;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=redhat.com (client-ip=170.10.133.124; helo=us-smtp-delivery-124.mimecast.com; envelope-from=dhowells@redhat.com; receiver=lists.ozlabs.org)
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4TJT714CgWz3bbt
	for <linux-erofs@lists.ozlabs.org>; Mon, 22 Jan 2024 22:50:20 +1100 (AEDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1705924216;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding;
	bh=qWBG3EUB+eR+nnWK36e3AyikYbZKtHzO5qoTjiHlzFA=;
	b=T6ZSrYT0MbLDGTZZu1mAPUXX/zVeK40825ATOBLFZW1GgNW7GjsrBZHxvco6SLv0DgGm7U
	SivndpYE44PT4lP+b3wXxerpJlDcwYyDe8yuG0uG5lG1PxQy30GMa+3MVwXF10ewcBLnha
	sBabuVhzfyQClIvCXX1cRZB/ilsv2Dc=
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1705924216;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding;
	bh=qWBG3EUB+eR+nnWK36e3AyikYbZKtHzO5qoTjiHlzFA=;
	b=T6ZSrYT0MbLDGTZZu1mAPUXX/zVeK40825ATOBLFZW1GgNW7GjsrBZHxvco6SLv0DgGm7U
	SivndpYE44PT4lP+b3wXxerpJlDcwYyDe8yuG0uG5lG1PxQy30GMa+3MVwXF10ewcBLnha
	sBabuVhzfyQClIvCXX1cRZB/ilsv2Dc=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-572-dkNhJT87Mlyeyizr-tyMEA-1; Mon, 22 Jan 2024 06:50:12 -0500
X-MC-Unique: dkNhJT87Mlyeyizr-tyMEA-1
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.rdu2.redhat.com [10.11.54.3])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 0238684852A;
	Mon, 22 Jan 2024 11:50:12 +0000 (UTC)
Received: from warthog.procyon.org.com (unknown [10.42.28.67])
	by smtp.corp.redhat.com (Postfix) with ESMTP id E527B111E40C;
	Mon, 22 Jan 2024 11:50:09 +0000 (UTC)
From: David Howells <dhowells@redhat.com>
To: netfs@lists.linux.dev
Subject: [PATCH 0/2] netfs, cachefiles: Update MAINTAINERS records
Date: Mon, 22 Jan 2024 11:49:59 +0000
Message-ID: <20240122115007.3820330-1-dhowells@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.11.54.3
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
Cc: linux-cifs@vger.kernel.org, linux-nfs@vger.kernel.org, v9fs@lists.linux.dev, Jeff Layton <jlayton@kernel.org>, linux-kernel@vger.kernel.org, Matthew Wilcox <willy@infradead.org>, David Howells <dhowells@redhat.com>, linux-mm@kvack.org, linux-cachefs@redhat.com, linux-fsdevel@vger.kernel.org, ceph-devel@vger.kernel.org, linux-erofs@lists.ozlabs.org, linux-afs@lists.infradead.org, Christian Brauner <christian@brauner.io>
Errors-To: linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org
Sender: "Linux-erofs" <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>

Update the MAINTAINERS records for netfs and cachefiles to reflect a change of
mailing list for both as Red Hat no longer archives the mailing list in a
publicly accessible place.

Also add Jeff Layton as a reviewer.

The patches are here:

	https://git.kernel.org/pub/scm/linux/kernel/git/dhowells/linux-fs.git/

tagged as netfs-lib-20240122.

Thanks,
David

David Howells (2):
  netfs, cachefiles: Change mailing list
  netfs: Add Jeff Layton as reviewer

 MAINTAINERS | 5 +++--
 1 file changed, 3 insertions(+), 2 deletions(-)

