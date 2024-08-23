Return-Path: <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>
X-Original-To: lists+linux-erofs@lfdr.de
Delivered-To: lists+linux-erofs@lfdr.de
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	by mail.lfdr.de (Postfix) with ESMTPS id 4EDB195D2A3
	for <lists+linux-erofs@lfdr.de>; Fri, 23 Aug 2024 18:12:34 +0200 (CEST)
Received: from boromir.ozlabs.org (localhost [IPv6:::1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4Wr4pm0CHkz301x
	for <lists+linux-erofs@lfdr.de>; Sat, 24 Aug 2024 02:12:32 +1000 (AEST)
X-Original-To: linux-erofs@lists.ozlabs.org
Delivered-To: linux-erofs@lists.ozlabs.org
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip=170.10.129.124
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1724429550;
	cv=none; b=jMBpkPuJKQN+E6YiRTpn0HWvIOEtFr6wyyhAmnCusW2WFWa0LkKJt8KEQ+gx6jrmkcKg93a3iUinIdd1nY0U1PFDB4GoogtIGMPg9bbotXc4YnxSUEJFDdo7nDEhYpPJzFp6FRh8A2hByDro7m3XhCMu7+1wwGwUU+47Dz/PXFQHlcwXhWKCTqGcXtBH2gXF6AJZxraJ8rJta0fNDL04M+Ocg9WNlU/JiPJuk5P+kfLy0dtIxNhS++xwFADiCgQPFmw2A+LIjXj95p0O+JrQURrNBsK4aO122rI+EDPlvbqhE54lWN4IK8aQcSPbvB0VO9myXGUAZSF7InxyTt67oQ==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1724429550; c=relaxed/relaxed;
	bh=HWel4fAjhn1F/3o1FewTt4dI8XNtgDdoQ8ZZC3V8mew=;
	h=DKIM-Signature:DKIM-Signature:Received:X-MC-Unique:Received:
	 Received:From:To:Cc:Subject:Date:Message-ID:MIME-Version:
	 Content-Transfer-Encoding:X-Scanned-By; b=jIcIlGYunmZryPsgIdBDTkoqM45X1Birx6hyN0XZX4KsiEeaSsaseVm3lBhw0WuL2eYCVBnC8564ek0UYLA77Y9CdHkgAxe/6rOO305e/N5HsSQ3yBxXXse+S18BybN9wqg8t0M0dAmfz1uVNl83805ubkzdtZ3t2C/QNt4Zi4PYbuDNCUSewqYVhd3swoEnhZkOCwZB0vvbUwf2ZJ//F3oQTA+lwL1zTU0T3eYoMuHS6PqyHWAXdHiWFP1GFELFameEvBBZQRF++UDnYciAavNOxeWR/15AWPlksrarisprzjKPi6nvZLNja0YcQoVuV4yB5ae+RRT7tggQDJ+Ymg==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=redhat.com; dkim=pass (1024-bit key; unprotected) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=AVwJu+SL; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=AVwJu+SL; dkim-atps=neutral; spf=pass (client-ip=170.10.129.124; helo=us-smtp-delivery-124.mimecast.com; envelope-from=dhowells@redhat.com; receiver=lists.ozlabs.org) smtp.mailfrom=redhat.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (1024-bit key; unprotected) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=AVwJu+SL;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=AVwJu+SL;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=redhat.com (client-ip=170.10.129.124; helo=us-smtp-delivery-124.mimecast.com; envelope-from=dhowells@redhat.com; receiver=lists.ozlabs.org)
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4Wr4pj3c5qz2yJ9
	for <linux-erofs@lists.ozlabs.org>; Sat, 24 Aug 2024 02:12:26 +1000 (AEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1724429542;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding;
	bh=HWel4fAjhn1F/3o1FewTt4dI8XNtgDdoQ8ZZC3V8mew=;
	b=AVwJu+SL4XqgrOYdQ/5E0vIrGo17+bxTVgCaAgvcl8fP3+PHKzZidQtEY4cm9WNQZVXewl
	VmyVW4IUw+rmaojMFn4+sEd9UEozSsZ8DpLrExjUhSaIgMsWCuUeZdwEdse0u9xedWXvY3
	rV9f46OyjGxFe7O/3d6AW+UTsA1HdxM=
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1724429542;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding;
	bh=HWel4fAjhn1F/3o1FewTt4dI8XNtgDdoQ8ZZC3V8mew=;
	b=AVwJu+SL4XqgrOYdQ/5E0vIrGo17+bxTVgCaAgvcl8fP3+PHKzZidQtEY4cm9WNQZVXewl
	VmyVW4IUw+rmaojMFn4+sEd9UEozSsZ8DpLrExjUhSaIgMsWCuUeZdwEdse0u9xedWXvY3
	rV9f46OyjGxFe7O/3d6AW+UTsA1HdxM=
Received: from mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-173-pE1nOUCvOMGmvIxiOZwJjA-1; Fri,
 23 Aug 2024 12:12:19 -0400
X-MC-Unique: pE1nOUCvOMGmvIxiOZwJjA-1
Received: from mx-prod-int-04.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-04.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.40])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 6137B1954B06;
	Fri, 23 Aug 2024 16:12:16 +0000 (UTC)
Received: from warthog.procyon.org.uk.com (unknown [10.42.28.30])
	by mx-prod-int-04.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id 047D71955F41;
	Fri, 23 Aug 2024 16:12:11 +0000 (UTC)
From: David Howells <dhowells@redhat.com>
To: Christian Brauner <christian@brauner.io>
Subject: [PATCH 0/5] netfs, cifs: Further fixes
Date: Fri, 23 Aug 2024 17:12:01 +0100
Message-ID: <20240823161209.434705-1-dhowells@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.40
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

Hi Christian, Steve,

Here are some more fixes to cifs and one to netfs:

 (1) Fix cifs FALLOC_FL_PUNCH_HOLE support as best I can.  If it's going to
     punch a hole in dirty data in the pagecacne, invalidating that data
     may result in the EOF not being moved correctly.  The set-zero and the
     eof-move RPC ops really need compounding to avoid third-party
     interference.

 (2) Adjust three debugging output statements.  Not strictly a fix, so
     could be dropped.  Including the subreq ID in some extra debug lines
     helps a bit, though.

 (3) Fix netfslib's short read retry to reset the buffer iterator otherwise
     the wrong part of the buffer may get written on.

 (4) Further fix the early EOF detection in cifs read.

 (5) Further fixes for cifs credit handling.

The patches can also be found here:

	https://git.kernel.org/pub/scm/linux/kernel/git/dhowells/linux-fs.git/log/?h=netfs-fixes

Thanks,
David

David Howells (5):
  cifs: Fix FALLOC_FL_PUNCH_HOLE support
  netfs, cifs: Improve some debugging bits
  netfs: Fix missing iterator reset on retry of short read
  cifs: Fix short read handling
  cifs: Fix credit handling

 fs/netfs/io.c           |  3 ++-
 fs/smb/client/file.c    |  9 +++++++++
 fs/smb/client/smb2ops.c | 34 ++++++++++++++++++++++++++++++----
 fs/smb/client/smb2pdu.c | 12 ++----------
 fs/smb/client/trace.h   |  1 +
 5 files changed, 44 insertions(+), 15 deletions(-)

