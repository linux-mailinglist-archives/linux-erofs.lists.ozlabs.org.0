Return-Path: <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>
X-Original-To: lists+linux-erofs@lfdr.de
Delivered-To: lists+linux-erofs@lfdr.de
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2404:9400:2:0:216:3eff:fee1:b9f1])
	by mail.lfdr.de (Postfix) with ESMTPS id 62B6995910D
	for <lists+linux-erofs@lfdr.de>; Wed, 21 Aug 2024 01:21:33 +0200 (CEST)
Received: from boromir.ozlabs.org (localhost [IPv6:::1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4WpQT500RYz2yGm
	for <lists+linux-erofs@lfdr.de>; Wed, 21 Aug 2024 09:21:29 +1000 (AEST)
X-Original-To: linux-erofs@lists.ozlabs.org
Delivered-To: linux-erofs@lists.ozlabs.org
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip=170.10.129.124
Authentication-Results: lists.ozlabs.org;
	dkim=pass (1024-bit key; unprotected) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=V4KPVdg4;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=V4KPVdg4;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=redhat.com (client-ip=170.10.129.124; helo=us-smtp-delivery-124.mimecast.com; envelope-from=dhowells@redhat.com; receiver=lists.ozlabs.org)
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4WpQT16pj0z2y89
	for <linux-erofs@lists.ozlabs.org>; Wed, 21 Aug 2024 09:21:24 +1000 (AEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1724196080;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding;
	bh=fCjK9t7HkWPXdjZnzcV3YJhj3lK29P+RVZIMnJ9iM+Q=;
	b=V4KPVdg400KgZ49bZRQ3gGLVjr1rtyweqobR7cPPwoSu8M0SdOPgcgKU+kAjwNO2gAsziv
	ghXPUFy3Ni2NSlEqw/lDigfwj2s5bgYCbHVzjJMtk8ORr9WSJlSd5bPhBfpoBU42POv+05
	/9MyEplP1VAD2xlcgeDkeH9aVQPUAUA=
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1724196080;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding;
	bh=fCjK9t7HkWPXdjZnzcV3YJhj3lK29P+RVZIMnJ9iM+Q=;
	b=V4KPVdg400KgZ49bZRQ3gGLVjr1rtyweqobR7cPPwoSu8M0SdOPgcgKU+kAjwNO2gAsziv
	ghXPUFy3Ni2NSlEqw/lDigfwj2s5bgYCbHVzjJMtk8ORr9WSJlSd5bPhBfpoBU42POv+05
	/9MyEplP1VAD2xlcgeDkeH9aVQPUAUA=
Received: from mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-617-IHAldsebOD2s3EiBWC1CDA-1; Tue,
 20 Aug 2024 19:21:16 -0400
X-MC-Unique: IHAldsebOD2s3EiBWC1CDA-1
Received: from mx-prod-int-02.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-02.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.15])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 259D41955F40;
	Tue, 20 Aug 2024 23:21:13 +0000 (UTC)
Received: from warthog.procyon.org.uk.com (unknown [10.42.28.30])
	by mx-prod-int-02.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id C53DE19560AA;
	Tue, 20 Aug 2024 23:21:07 +0000 (UTC)
From: David Howells <dhowells@redhat.com>
To: Christian Brauner <christian@brauner.io>
Subject: [PATCH 0/4] mm, netfs, afs: Truncation fixes
Date: Wed, 21 Aug 2024 00:20:54 +0100
Message-ID: <20240820232105.3792638-1-dhowells@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
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
Cc: Pankaj Raghav <p.raghav@samsung.com>, linux-cifs@vger.kernel.org, linux-nfs@vger.kernel.org, v9fs@lists.linux.dev, Jeff Layton <jlayton@kernel.org>, linux-kernel@vger.kernel.org, Matthew Wilcox <willy@infradead.org>, David Howells <dhowells@redhat.com>, linux-mm@kvack.org, linux-fsdevel@vger.kernel.org, netfs@lists.linux.dev, ceph-devel@vger.kernel.org, linux-erofs@lists.ozlabs.org, linux-afs@lists.infradead.org
Errors-To: linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org
Sender: "Linux-erofs" <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>

Hi Christian,

Here are some fixes for truncation, netfslib and afs that I discovered whilst
trying Pankaj Raghav's minimum folio order patchset:

 (1) Fix truncate to make it honour AS_RELEASE_ALWAYS in a couple of places
     that got missed.

 (2) Fix duplicated editing of a partially invalidated folio in afs's
     post-setattr edit phase.

 (3) Fix netfs_release_folio() to indicate that the folio is busy if the
     folio is dirty (as does iomap).

 (4) Fix the trimming of a folio that contain streaming-write data when
     truncation occurs into or past that folio

The patches can also be found here:

	https://git.kernel.org/pub/scm/linux/kernel/git/dhowells/linux-fs.git/log/?h=netfs-fixes

Thanks,
David

David Howells (4):
  mm: Fix missing folio invalidation calls during truncation
  afs: Fix post-setattr file edit to do truncation correctly
  netfs: Fix netfs_release_folio() to say no if folio dirty
  netfs: Fix trimming of streaming-write folios in netfs_inval_folio()

 fs/afs/inode.c  | 11 +++++++---
 fs/netfs/misc.c | 53 +++++++++++++++++++++++++++++++++++--------------
 mm/truncate.c   |  4 ++--
 3 files changed, 48 insertions(+), 20 deletions(-)

