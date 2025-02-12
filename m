Return-Path: <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>
X-Original-To: lists+linux-erofs@lfdr.de
Delivered-To: lists+linux-erofs@lfdr.de
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2404:9400:2:0:216:3eff:fee1:b9f1])
	by mail.lfdr.de (Postfix) with ESMTPS id 1EFA2A3326C
	for <lists+linux-erofs@lfdr.de>; Wed, 12 Feb 2025 23:24:38 +0100 (CET)
Received: from boromir.ozlabs.org (localhost [IPv6:::1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4YtXt76Mpyz30VF
	for <lists+linux-erofs@lfdr.de>; Thu, 13 Feb 2025 09:24:31 +1100 (AEDT)
X-Original-To: linux-erofs@lists.ozlabs.org
Delivered-To: linux-erofs@lists.ozlabs.org
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip=170.10.129.124
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1739399070;
	cv=none; b=Ns+JA0ZnDmRQ1yq8zUHfVvgL9gFXPQXyqvSS70ovcDeTJvAR+2wO/N0wdoxAQdSWf/A2nxbLLjyyZRXA2oslzfICHqD7dj/vFz4O0MuQryJrZs+OTjRuSGC46/EPg8YN6HUAVpseLNN2n0U/K4PwC7pbr5D5l2c/88xsaD9sC0U+3d8XtOuQrAzbAx+NbBbaS91xOJdP6K1KSzsxjBVxYzfkxLOMr2/AyvwhNTuUNECudLEBJptErztFy/iWqlq9TVwpz+7BnEoU5oLGxfg4bjney1Eym6hJ+zrOmlIvLnr6btelgU/5l5se9e11gxmGetScmUd/hMam+A5uYEFFvA==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1739399070; c=relaxed/relaxed;
	bh=j/hFCuHm3dQy3yCXNlW7/z5EXWgYM+xOP2nJGIBn15Q=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=STIfiCrVVHDiH5UoTTQ+k1XnnXL6XT3mc+f8124UrhRwxJKgycV92WhHDBfbWs6sPA27NZWUnrO2/nQMnciV4Y43a5EboKd+QkrMKWNCrOu8axb8hYQUswwXdYCXwKceWT3DFxwqjZGQLTcfesZCi9Iz/wxHVccWQ3U66aodDdjKSgTpqRLpzeLYMxKbXvBvPRy5SEwAfmBrsnl67ZZb0zr2ddpfGalpyPQLlcrVRsJH/bvnFMJLAH61y6SXP1PK44iwAmtMTjA+kYCcdMiwN4blS8ttBcFdIxv9heIDEbBCZRTxAhd/KecL0JLHgzzeox6PSxOQ6IhU5BSIChrhKg==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=redhat.com; dkim=pass (1024-bit key; unprotected) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=Bbffjb2n; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=h4597n6l; dkim-atps=neutral; spf=pass (client-ip=170.10.129.124; helo=us-smtp-delivery-124.mimecast.com; envelope-from=dhowells@redhat.com; receiver=lists.ozlabs.org) smtp.mailfrom=redhat.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (1024-bit key; unprotected) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=Bbffjb2n;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=h4597n6l;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=redhat.com (client-ip=170.10.129.124; helo=us-smtp-delivery-124.mimecast.com; envelope-from=dhowells@redhat.com; receiver=lists.ozlabs.org)
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4YtXt55xF6z307V
	for <linux-erofs@lists.ozlabs.org>; Thu, 13 Feb 2025 09:24:25 +1100 (AEDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1739399061;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding;
	bh=j/hFCuHm3dQy3yCXNlW7/z5EXWgYM+xOP2nJGIBn15Q=;
	b=Bbffjb2n20i4wPWH+dKTMaVn1FDC9OT2iRVuwDF+EMneJbYRg0l3R/G/qO8PULdBJM1dnt
	qQebRsM5Nn8v4j2el7msZfiHKmwPbCEOn9+ZxIX99vk1eLASMZOruesMh5lzFvHVvmyjvI
	HOQ9B8E/UUlosxW9zhFHKIrhvgwHLI0=
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1739399062;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding;
	bh=j/hFCuHm3dQy3yCXNlW7/z5EXWgYM+xOP2nJGIBn15Q=;
	b=h4597n6lWAf1hI/jAlwiMjUarMkKpgU7ktyedBYJZeVPitNtt7W5D1aKxeJV1eCAnfJjAr
	ahpNE/ggtVhnVXC76oIaFNz1civmAREBOcZC4wiSQ9VyXW0lV5XVCvTHcigJkLudbk1AHC
	VB13yK+F5Bpb66jtSytxODvoBzcmK6Y=
Received: from mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-605-iPLvlH5hPsCaSV9rKTnwgQ-1; Wed,
 12 Feb 2025 17:24:18 -0500
X-MC-Unique: iPLvlH5hPsCaSV9rKTnwgQ-1
X-Mimecast-MFC-AGG-ID: iPLvlH5hPsCaSV9rKTnwgQ
Received: from mx-prod-int-04.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-04.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.40])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 25E25180087B;
	Wed, 12 Feb 2025 22:24:13 +0000 (UTC)
Received: from warthog.procyon.org.com (unknown [10.42.28.92])
	by mx-prod-int-04.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id CBFAE19560A3;
	Wed, 12 Feb 2025 22:24:05 +0000 (UTC)
From: David Howells <dhowells@redhat.com>
To: Christian Brauner <christian@brauner.io>
Subject: [PATCH 0/3] netfs: Miscellaneous fixes
Date: Wed, 12 Feb 2025 22:23:58 +0000
Message-ID: <20250212222402.3618494-1-dhowells@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.40
X-Spam-Status: No, score=-0.2 required=5.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
	RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_PASS
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
Cc: Paulo Alcantara <pc@manguebit.com>, Steve French <sfrench@samba.org>, Max Kellermann <max.kellermann@ionos.com>, linux-cifs@vger.kernel.org, linux-fsdevel@vger.kernel.org, Dominique Martinet <asmadeus@codewreck.org>, Jeff Layton <jlayton@kernel.org>, linux-nfs@vger.kernel.org, v9fs@lists.linux.dev, linux-kernel@vger.kernel.org, David Howells <dhowells@redhat.com>, Ihor Solodrai <ihor.solodrai@linux.dev>, Tom Talpey <tom@talpey.com>, linux-mm@kvack.org, Marc Dionne <marc.dionne@auristor.com>, netfs@lists.linux.dev, ceph-devel@vger.kernel.org, Eric Van Hensbergen <ericvh@kernel.org>, linux-erofs@lists.ozlabs.org, linux-afs@lists.infradead.org
Errors-To: linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org
Sender: "Linux-erofs" <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>

Hi Christian,

Here are some miscellaneous fixes and changes for netfslib, if you could
pull them:

 (1) Fix a number of read-retry hangs, including:

     (a) Incorrect getting/putting of references on subreqs as we retry
     	 them.

     (b) Failure to track whether a last old subrequest in a retried set is
     	 superfluous.

     (c) Inconsistency in the usage of wait queues used for subrequests
     	 (ie. using clear_and_wake_up_bit() whilst waiting on a private
     	 waitqueue).

     	 (Note that waitqueue consistency also needs looking at for
     	 netfs_io_request structs.)

 (2) Add stats counters for retries and publish in /proc/fs/netfs/stats.
     This is not a fix per se, but is useful in debugging and shouldn't
     otherwise change the operation of the code.

 (3) Fix the ordering of queuing subrequests with respect to setting the
     request flag that says we've now queued them all.

The patches can also be found here:

	https://git.kernel.org/pub/scm/linux/kernel/git/dhowells/linux-fs.git/log/?h=netfs-fixes

Thanks,
David

David Howells (3):
  netfs: Fix a number of read-retry hangs
  netfs: Add retry stat counters
  netfs: Fix setting NETFS_RREQ_ALL_QUEUED to be after all subreqs
    queued

 fs/netfs/buffered_read.c     | 19 +++++++++++-----
 fs/netfs/internal.h          |  4 ++++
 fs/netfs/read_collect.c      |  6 +++--
 fs/netfs/read_retry.c        | 43 +++++++++++++++++++++++++++---------
 fs/netfs/stats.c             |  9 ++++++++
 fs/netfs/write_issue.c       |  1 +
 fs/netfs/write_retry.c       |  2 ++
 include/linux/netfs.h        |  2 +-
 include/trace/events/netfs.h |  4 +++-
 9 files changed, 70 insertions(+), 20 deletions(-)

