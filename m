Return-Path: <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>
X-Original-To: lists+linux-erofs@lfdr.de
Delivered-To: lists+linux-erofs@lfdr.de
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	by mail.lfdr.de (Postfix) with ESMTPS id 20FEE96335F
	for <lists+linux-erofs@lfdr.de>; Wed, 28 Aug 2024 23:03:20 +0200 (CEST)
Received: from boromir.ozlabs.org (localhost [IPv6:::1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4WvH1x56fRz2yq4
	for <lists+linux-erofs@lfdr.de>; Thu, 29 Aug 2024 07:03:17 +1000 (AEST)
X-Original-To: linux-erofs@lists.ozlabs.org
Delivered-To: linux-erofs@lists.ozlabs.org
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip=170.10.133.124
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1724878995;
	cv=none; b=Xy8WKIHCXZhW2OIKXHzE2+ZujqFFmYPnI+YRTRDkwbuzh8tNuMGxEr9qBtHMKdejlbYj6JkD05arl/y7vHuotM+qwSzZ27YVyzDyhBHUH03/ML1RBAYgX1+zI/UnnM9bcS2LAMnuhAK9uOMfoxikm/FUq1batV7XPv0+KxGqXy9GSbYaAQzNvKTeShAWxVGU9L/hac414vCV64LbhEFd9DDjZesg7WF0fF0jhldAhAsooCbDB6D5686V2bTO/z2bj0qwdS+nl35cudNKpBhkwE5TJ7u/VAd9XMNP/lNC5rCjkywlH7dv88nLdaQVdP7sBjGBOfCRn9hGGZCCw3wnEQ==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1724878995; c=relaxed/relaxed;
	bh=XFobmMcyik8XghRtkh2gK9+MeaxVAEEC6pZ/c4IMu/w=;
	h=DKIM-Signature:DKIM-Signature:Received:X-MC-Unique:Received:
	 Received:From:To:Cc:Subject:Date:Message-ID:MIME-Version:
	 Content-Transfer-Encoding:X-Scanned-By; b=FLKTqxPcCdyo41IAwzDl5k4UF2WY1PdXAF+QMqNw0ohdFwtXXiFs09ZOgUu+xO6kFj5+eK/NM/xNsjwlFqLfUwJLVfBlX68txkn8HWxPrVclQMufxqRItnbVZ3wnGJgLzhQsmjOceFZBp4bk9YScEnPqmu02bz3tZRvV6VjrBvimCj4I9DCH56dgKJjnvVGy2lZDiumh+4TwNjRdMEGP+w/ALfKdOuyY2qQUFByjihCKQ5SR7EG7gGqMQGaDxhrA6sOKKDUQSiUJx1N1L3dtVCwBz5GEBYzsDeHagkxbhPe8Jyp3iMah1JblpO7L9x3S+M5nC3lmllxfzfEk/uo2ew==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=redhat.com; dkim=pass (1024-bit key; unprotected) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=LSXZoM0S; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=LSXZoM0S; dkim-atps=neutral; spf=pass (client-ip=170.10.133.124; helo=us-smtp-delivery-124.mimecast.com; envelope-from=dhowells@redhat.com; receiver=lists.ozlabs.org) smtp.mailfrom=redhat.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (1024-bit key; unprotected) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=LSXZoM0S;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=LSXZoM0S;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=redhat.com (client-ip=170.10.133.124; helo=us-smtp-delivery-124.mimecast.com; envelope-from=dhowells@redhat.com; receiver=lists.ozlabs.org)
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4WvH1v38dyz2yZZ
	for <linux-erofs@lists.ozlabs.org>; Thu, 29 Aug 2024 07:03:12 +1000 (AEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1724878990;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding;
	bh=XFobmMcyik8XghRtkh2gK9+MeaxVAEEC6pZ/c4IMu/w=;
	b=LSXZoM0SX6eXOllGTC4TmahYadUN7gfuTrOqcyKrmgzxeTsdfMpm6iK6hgvocCK7L3+YBH
	6vANVJVVv7c4+zhgbpuINeT9GImBvN3QNQo0FkEHZQrWNetjhPLAxeEetdfSEwvtXE3+e/
	C/1P4EgFkgr5nQrHXLymTST2QrAviKo=
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1724878990;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding;
	bh=XFobmMcyik8XghRtkh2gK9+MeaxVAEEC6pZ/c4IMu/w=;
	b=LSXZoM0SX6eXOllGTC4TmahYadUN7gfuTrOqcyKrmgzxeTsdfMpm6iK6hgvocCK7L3+YBH
	6vANVJVVv7c4+zhgbpuINeT9GImBvN3QNQo0FkEHZQrWNetjhPLAxeEetdfSEwvtXE3+e/
	C/1P4EgFkgr5nQrHXLymTST2QrAviKo=
Received: from mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-668-pWU2m7E2O3W_VVpN-j_iRQ-1; Wed,
 28 Aug 2024 17:03:04 -0400
X-MC-Unique: pWU2m7E2O3W_VVpN-j_iRQ-1
Received: from mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.12])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 413511955D47;
	Wed, 28 Aug 2024 21:03:00 +0000 (UTC)
Received: from warthog.procyon.org.com (unknown [10.42.28.30])
	by mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id 8C48D1955BED;
	Wed, 28 Aug 2024 21:02:53 +0000 (UTC)
From: David Howells <dhowells@redhat.com>
To: Christian Brauner <christian@brauner.io>,
	Steve French <sfrench@samba.org>
Subject: [PATCH 0/6] mm, netfs, cifs: Miscellaneous fixes
Date: Wed, 28 Aug 2024 22:02:41 +0100
Message-ID: <20240828210249.1078637-1-dhowells@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.12
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
Cc: Paulo Alcantara <pc@manguebit.com>, Tom Talpey <tom@talpey.com>, linux-nfs@vger.kernel.org, v9fs@lists.linux.dev, linux-cifs@vger.kernel.org, Dominique Martinet <asmadeus@codewreck.org>, Jeff Layton <jlayton@kernel.org>, linux-kernel@vger.kernel.org, Matthew Wilcox <willy@infradead.org>, David Howells <dhowells@redhat.com>, linux-mm@kvack.org, linux-fsdevel@vger.kernel.org, netfs@lists.linux.dev, ceph-devel@vger.kernel.org, linux-erofs@lists.ozlabs.org, linux-afs@lists.infradead.org
Errors-To: linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org
Sender: "Linux-erofs" <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>

Hi Christian, Steve,

Firstly, here are some fixes to DIO read handling and the retrying of
reads, particularly in relation to cifs:

 (1) Fix the missing credit renegotiation in cifs on the retrying of reads.
     The credits we had ended with the original read (or the last retry)
     and to perform a new read we need more credits otherwise the server
     can reject our read with EINVAL.

 (2) Fix the handling of short DIO reads to avoid ENODATA when the read
     retry tries to access a portion of the file after the EOF.

Secondly, some patches fixing cifs copy and zero offload:

 (3) Fix cifs_file_copychunk_range() to not try to partially invalidate
     folios that are only partly covered by the range, but rather flush
     them back and invalidate them.

 (4) Fix filemap_invalidate_inode() to use the correct invalidation
     function so that it doesn't leave partially invalidated folios hanging
     around (which may hide part of the result of an offloaded copy).

 (5) Fix smb3_zero_data() to correctly handle zeroing of data that's
     buffered locally but not yet written back and with the EOF position on
     the server short of the local EOF position.

     Note that this will also affect afs and 9p, particularly with regard
     to direct I/O writes.

And finally, here's an adjustment to debugging statements:

 (6) Adjust three debugging output statements.  Not strictly a fix, so
     could be dropped.  Including the subreq ID in some extra debug lines
     helps a bit, though.

The patches can also be found here:

	https://git.kernel.org/pub/scm/linux/kernel/git/dhowells/linux-fs.git/log/?h=netfs-fixes

Thanks,
David

David Howells (6):
  cifs: Fix lack of credit renegotiation on read retry
  netfs, cifs: Fix handling of short DIO read
  cifs: Fix copy offload to flush destination region
  mm: Fix filemap_invalidate_inode() to use
    invalidate_inode_pages2_range()
  cifs: Fix FALLOC_FL_ZERO_RANGE to preflush buffered part of target
    region
  netfs, cifs: Improve some debugging bits

 fs/netfs/io.c            | 21 +++++++++++++-------
 fs/smb/client/cifsfs.c   | 21 ++++----------------
 fs/smb/client/cifsglob.h |  1 +
 fs/smb/client/file.c     | 37 ++++++++++++++++++++++++++++++++----
 fs/smb/client/smb2ops.c  | 26 +++++++++++++++++++------
 fs/smb/client/smb2pdu.c  | 41 +++++++++++++++++++++++++---------------
 fs/smb/client/trace.h    |  1 +
 include/linux/netfs.h    |  1 +
 mm/filemap.c             |  2 +-
 9 files changed, 101 insertions(+), 50 deletions(-)

