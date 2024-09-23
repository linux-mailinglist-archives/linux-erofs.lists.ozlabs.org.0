Return-Path: <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>
X-Original-To: lists+linux-erofs@lfdr.de
Delivered-To: lists+linux-erofs@lfdr.de
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	by mail.lfdr.de (Postfix) with ESMTPS id 2870897ED9B
	for <lists+linux-erofs@lfdr.de>; Mon, 23 Sep 2024 17:08:27 +0200 (CEST)
Received: from boromir.ozlabs.org (localhost [IPv6:::1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4XC5wR5Nr7z2yVX
	for <lists+linux-erofs@lfdr.de>; Tue, 24 Sep 2024 01:08:23 +1000 (AEST)
X-Original-To: linux-erofs@lists.ozlabs.org
Delivered-To: linux-erofs@lists.ozlabs.org
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip=170.10.129.124
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1727104099;
	cv=none; b=A70rexsAFhRTmtgEKwacia3QPp6Ee6pygAhpvHp1vqcMO72A3V7ZKDoy01AK89AMK+5mQJIJAOM9ZSbVfSgWrxpffJsuUi/+IzdyZM9pJyzCSPaNCKQ+UoMgrwskTB9PFQk4QZEWniAhM2Pz067x+tdfotRWwR72KPguVJ4K7ivF5UFyGhOyhcKMs9ArigEGNFSyLrAY/fLkUbtxJ/9MbOsspKdhsxNC8PjD30evBzRd+C7gAGjHfvfEtdoFXhkTyBTYbLMKNlIS1cOD5MVw00Ctxj98/66J8W2m60TYGqIYs1liwmCZJGXkSgciekFR6RUGHM/8vLFlHgwtBmNi9Q==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1727104099; c=relaxed/relaxed;
	bh=deDp5fXNcCneGmSM6E3aF14XvR7SODlrONWVXGCHh5M=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=DfzMy68oyFIj73Sos+N5V+MzY+NaV4RjbOtEH1eVPlOY16wBJBg7ITJyHJX8ByHcxdSYwzLFckux8qE4I6GlB0XgI7QlzLm++5NUUj1Z/F2qhZ5QMCevy6KjCCqnQM1tbMG7c/XVpp+DYxR/3jPbGQq2Y0jP+97qw9e4O8CRl1G6sVLtFb3l4ZBK7vLc75wWFVOYMucqj78nnUcjm2WDJ5BvxqAQTadc3rVmQzIBiAaomhqsqxIWmH7qjs+9u8gMJlXgemaJxXUmKU2e/2/D4guW1+cDu7IUXE2Y40yjTZQRiT3bvrxo4eGjFBWiGd3QAI5iYSQYJcv9NiHTn1Pbhg==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=redhat.com; dkim=pass (1024-bit key; unprotected) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=XLdmUzcC; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=XLdmUzcC; dkim-atps=neutral; spf=pass (client-ip=170.10.129.124; helo=us-smtp-delivery-124.mimecast.com; envelope-from=dhowells@redhat.com; receiver=lists.ozlabs.org) smtp.mailfrom=redhat.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (1024-bit key; unprotected) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=XLdmUzcC;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=XLdmUzcC;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=redhat.com (client-ip=170.10.129.124; helo=us-smtp-delivery-124.mimecast.com; envelope-from=dhowells@redhat.com; receiver=lists.ozlabs.org)
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4XC5wM23Qhz2xb9
	for <linux-erofs@lists.ozlabs.org>; Tue, 24 Sep 2024 01:08:16 +1000 (AEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1727104091;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding;
	bh=deDp5fXNcCneGmSM6E3aF14XvR7SODlrONWVXGCHh5M=;
	b=XLdmUzcC3462VkU0zwaLGlbbpetIa/L5uAJwmJt34kuMcoRlGTOc4qjZ7elO37szG7uX5I
	FPl34g/960GxFsOjRs2TayINhJGXEkcpFNZV2EtAgT5g+eu1CGMpsSLLEw7fc1P9yZdrta
	4ePXYynRODB85N+6YmO7y39tNI8x+PA=
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1727104091;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding;
	bh=deDp5fXNcCneGmSM6E3aF14XvR7SODlrONWVXGCHh5M=;
	b=XLdmUzcC3462VkU0zwaLGlbbpetIa/L5uAJwmJt34kuMcoRlGTOc4qjZ7elO37szG7uX5I
	FPl34g/960GxFsOjRs2TayINhJGXEkcpFNZV2EtAgT5g+eu1CGMpsSLLEw7fc1P9yZdrta
	4ePXYynRODB85N+6YmO7y39tNI8x+PA=
Received: from mx-prod-mc-02.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-581-4y-C8U9DPSq2ZrlXAofqpQ-1; Mon,
 23 Sep 2024 11:08:09 -0400
X-MC-Unique: 4y-C8U9DPSq2ZrlXAofqpQ-1
Received: from mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com (unknown [10.30.177.17])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-02.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 29E0C18EB2E2;
	Mon, 23 Sep 2024 15:08:06 +0000 (UTC)
Received: from warthog.procyon.org.com (unknown [10.42.28.145])
	by mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id 1ACE8194328E;
	Mon, 23 Sep 2024 15:07:59 +0000 (UTC)
From: David Howells <dhowells@redhat.com>
To: Christian Brauner <christian@brauner.io>,
	Steve French <sfrench@samba.org>,
	Marc Dionne <marc.dionne@auristor.com>
Subject: [PATCH 0/8] netfs, afs, cifs: Miscellaneous fixes/changes
Date: Mon, 23 Sep 2024 16:07:44 +0100
Message-ID: <20240923150756.902363-1-dhowells@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.17
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
Cc: Paulo Alcantara <pc@manguebit.com>, linux-cifs@vger.kernel.org, linux-nfs@vger.kernel.org, v9fs@lists.linux.dev, Jeff Layton <jlayton@kernel.org>, linux-kernel@vger.kernel.org, Matthew Wilcox <willy@infradead.org>, David Howells <dhowells@redhat.com>, linux-mm@kvack.org, linux-fsdevel@vger.kernel.org, netfs@lists.linux.dev, ceph-devel@vger.kernel.org, linux-erofs@lists.ozlabs.org, linux-afs@lists.infradead.org
Errors-To: linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org
Sender: "Linux-erofs" <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>

Hi Christian, Steve, Marc,

Here are some miscellaneous fixes and changes for netfslib and the afs and
cifs filesystems, some of which are already in the vfs or cifs trees, but I
thought I'd repost them all for completeness, starting with netfs:

 (1) Fix the update of mtime and ctime for mmapped files.

 (2) Drop the was_async argument from netfs_read_subreq_terminated().

then afs:

 (3) Wire up afs_retry_request() so that writeback rotates through the
     available keys.

 (4) Remove some unused defs.

 (5) Fix a potential infinite loop in the server rotation code.

 (6) Fix an oops that can occur when a server responds, but we decide the
     operation failed (e.g. an abort).

and then cifs:

 (7) Fix reversion of the I/O iterator causing cryptographically signed
     transport reception to fail.

 (8) Alter the write tracepoints to display netfs request info.

The patches can also be found here:

	https://git.kernel.org/pub/scm/linux/kernel/git/dhowells/linux-fs.git/log/?h=netfs-fixes

Thanks,
David

David Howells (6):
  netfs: Fix mtime/ctime update for mmapped writes
  netfs: Drop the was_async arg from netfs_read_subreq_terminated()
  afs: Fix missing wire-up of afs_retry_request()
  afs: Fix the setting of the server responding flag
  cifs: Fix reversion of the iter in cifs_readv_receive().
  cifs: Make the write_{enter,done,err} tracepoints display netfs info

Marc Dionne (1):
  afs: Fix possible infinite loop with unresponsive servers

Thorsten Blum (1):
  afs: Remove unused struct and function prototype

 fs/9p/vfs_addr.c          |  3 +-
 fs/afs/afs_vl.h           |  9 ----
 fs/afs/file.c             | 16 ++++---
 fs/afs/fs_operation.c     |  2 +-
 fs/afs/fs_probe.c         |  4 +-
 fs/afs/fsclient.c         |  2 +-
 fs/afs/rotate.c           | 11 +++--
 fs/afs/yfsclient.c        |  2 +-
 fs/ceph/addr.c            | 13 ++++--
 fs/netfs/buffered_read.c  | 16 +++----
 fs/netfs/buffered_write.c |  1 +
 fs/netfs/direct_read.c    |  2 +-
 fs/netfs/internal.h       |  2 +-
 fs/netfs/objects.c        | 17 ++++++-
 fs/netfs/read_collect.c   | 95 ++++++++++++++++-----------------------
 fs/netfs/read_retry.c     |  2 +-
 fs/nfs/fscache.c          |  6 ++-
 fs/nfs/fscache.h          |  3 +-
 fs/smb/client/cifssmb.c   | 10 +----
 fs/smb/client/connect.c   |  6 +--
 fs/smb/client/file.c      |  3 +-
 fs/smb/client/smb2ops.c   |  9 ++--
 fs/smb/client/smb2pdu.c   | 32 ++++++-------
 fs/smb/client/trace.h     |  6 +--
 fs/smb/client/transport.c |  3 --
 include/linux/netfs.h     |  7 ++-
 26 files changed, 139 insertions(+), 143 deletions(-)

