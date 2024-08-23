Return-Path: <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>
X-Original-To: lists+linux-erofs@lfdr.de
Delivered-To: lists+linux-erofs@lfdr.de
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2404:9400:2:0:216:3eff:fee1:b9f1])
	by mail.lfdr.de (Postfix) with ESMTPS id D78E695D707
	for <lists+linux-erofs@lfdr.de>; Fri, 23 Aug 2024 22:08:44 +0200 (CEST)
Received: from boromir.ozlabs.org (localhost [IPv6:::1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4WrB3G3y6Vz303d
	for <lists+linux-erofs@lfdr.de>; Sat, 24 Aug 2024 06:08:42 +1000 (AEST)
X-Original-To: linux-erofs@lists.ozlabs.org
Delivered-To: linux-erofs@lists.ozlabs.org
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip=170.10.129.124
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1724443721;
	cv=none; b=KJFJRlwWDirnxc2SI4/6rHN7YXnYyYKzLx35PK5oxH+FWWPj8t89c032zotfcut3ENow+MSSzvnwGRPmhLersbwu/J+M+BW8adXU4RoVgT2N9fcXNIcsctOe+aIbRKvDaZvubQSpcaICr3kufifT0c3gnUhdGbg8Z+plgsGsL2x/iHT1MQT15vs5FQ/+L9j5phiZ2ERktu4qkQT27stc3A15DefqOSSg8LgQ+0MAxN5m2aeTG7yNnAQmVHfmB9Y+rBW8wWGrBpuAcpq1GJQ6dW5EsJpLylwjlCkSATLBD4ndGmMfXmo11QdGhK2d6jdc6XkjisZ+i0ACk+UuvCGPsQ==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1724443721; c=relaxed/relaxed;
	bh=r0bfxiJNi0CTPgRC64Jy/pg3ljG8HQEqXgSdWA11B9w=;
	h=DKIM-Signature:DKIM-Signature:Received:X-MC-Unique:Received:
	 Received:From:To:Cc:Subject:Date:Message-ID:MIME-Version:
	 Content-Transfer-Encoding:X-Scanned-By; b=E85ix7TRe5UphjKo+WBJtBOOotU2NoP7yyUwO1ZS18KrjwlA7FBJ02YJXpRdWq1SVELmpIPVAWPZPImk7+Pa9Cw+1eAoCfML+XvPoPYQUA35NGwfTgiix4HK4/TUOUvxH1xV13H6xR3OhbGplOk4EdrFnu/bjbRhdt6lzqUhHtgqmgTXxkgurx5EZUdwsaatIXilct6q8Abd/ojjs3fgXlDG+UHrhGkvRRgCV5rwbAmxifz2c+hczI/vH4z9ljoiNIsB6TaqvphW03+F0kzoiW/dZdQw+dsiXmWMZcZhhkLY+ompHOY3DRUS+SO7qU2vYxb7D8SUaJfMJ/+cUbQLuQ==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=redhat.com; dkim=pass (1024-bit key; unprotected) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=FxvM3ol2; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=FxvM3ol2; dkim-atps=neutral; spf=pass (client-ip=170.10.129.124; helo=us-smtp-delivery-124.mimecast.com; envelope-from=dhowells@redhat.com; receiver=lists.ozlabs.org) smtp.mailfrom=redhat.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (1024-bit key; unprotected) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=FxvM3ol2;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=FxvM3ol2;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=redhat.com (client-ip=170.10.129.124; helo=us-smtp-delivery-124.mimecast.com; envelope-from=dhowells@redhat.com; receiver=lists.ozlabs.org)
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4WrB3D4Lzjz2xZj
	for <linux-erofs@lists.ozlabs.org>; Sat, 24 Aug 2024 06:08:38 +1000 (AEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1724443715;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding;
	bh=r0bfxiJNi0CTPgRC64Jy/pg3ljG8HQEqXgSdWA11B9w=;
	b=FxvM3ol2LOdXPJZSWUa7joyAQ04j56CjRB+ftbPQk+715qh33yl2p/rITcfdXf3mj5q5eQ
	b+K4Vq92WKQ9l1ihxZCCv9HNOlZ2/+gpxg1v7gMSrfCl9MN27v+OFT9JwxqTnOIezN1Wv9
	QjCc0F0qInteqDai4k3kIoRIMgSLX5A=
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1724443715;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding;
	bh=r0bfxiJNi0CTPgRC64Jy/pg3ljG8HQEqXgSdWA11B9w=;
	b=FxvM3ol2LOdXPJZSWUa7joyAQ04j56CjRB+ftbPQk+715qh33yl2p/rITcfdXf3mj5q5eQ
	b+K4Vq92WKQ9l1ihxZCCv9HNOlZ2/+gpxg1v7gMSrfCl9MN27v+OFT9JwxqTnOIezN1Wv9
	QjCc0F0qInteqDai4k3kIoRIMgSLX5A=
Received: from mx-prod-mc-02.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-523-lMoEhpcjPI23TPDJT40xdQ-1; Fri,
 23 Aug 2024 16:08:31 -0400
X-MC-Unique: lMoEhpcjPI23TPDJT40xdQ-1
Received: from mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.4])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-02.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 1CAA01955D52;
	Fri, 23 Aug 2024 20:08:28 +0000 (UTC)
Received: from warthog.procyon.org.uk.com (unknown [10.42.28.30])
	by mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id 7838E3001FE5;
	Fri, 23 Aug 2024 20:08:22 +0000 (UTC)
From: David Howells <dhowells@redhat.com>
To: Christian Brauner <christian@brauner.io>,
	Steve French <sfrench@samba.org>
Subject: [PATCH 0/9] netfs, cifs: Combined repost of fixes for truncation, DIO read and read-retry
Date: Fri, 23 Aug 2024 21:08:08 +0100
Message-ID: <20240823200819.532106-1-dhowells@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.4
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
Cc: Pankaj Raghav <p.raghav@samsung.com>, Paulo Alcantara <pc@manguebit.com>, linux-nfs@vger.kernel.org, linux-cifs@vger.kernel.org, v9fs@lists.linux.dev, Jeff Layton <jlayton@kernel.org>, linux-kernel@vger.kernel.org, Matthew Wilcox <willy@infradead.org>, David Howells <dhowells@redhat.com>, linux-mm@kvack.org, linux-fsdevel@vger.kernel.org, netfs@lists.linux.dev, ceph-devel@vger.kernel.org, linux-erofs@lists.ozlabs.org, linux-afs@lists.infradead.org
Errors-To: linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org
Sender: "Linux-erofs" <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>

Hi Christian, Steve,

Firstly, there are some fixes for truncation, netfslib and afs that I
discovered whilst trying Pankaj Raghav's minimum folio order patchset:

 (1) Fix truncate to make it honour AS_RELEASE_ALWAYS in a couple of places
     that got missed.

 (2) Fix duplicated editing of a partially invalidated folio in afs's
     post-setattr edit phase.

 (3) Fix netfs_release_folio() to indicate that the folio is busy if the
     folio is dirty (as does iomap).

 (4) Fix the trimming of a folio that contain streaming-write data when
     truncation occurs into or past that folio

Here's a patch to netfs for short reads:

 (5) Fix netfslib's short read retry to reset the buffer iterator otherwise
     the wrong part of the buffer may get written on.

Here are a couple of fixes to DIO read handling and the retrying of reads,
particularly in relation to cifs.  They have both had some fixes to the
fixes rolled in:

 (6) Fix the missing credit renegotiation in cifs on the retrying of reads.
     The credits we had ended with the original read (or the last retry)
     and to perform a new read we need more credits otherwise the server
     can reject our read with EINVAL.

 (7) Fix the handling of short DIO reads to avoid ENODATA when the read
     retry tries to access a portion of the file after the EOF.

Here's a fix for hole punching in cifs:

 (8) Fix cifs FALLOC_FL_PUNCH_HOLE support as best I can.  If it's going to
     punch a hole in dirty data in the pagecacne, invalidating that data
     may result in the EOF not being moved correctly.  The set-zero and the
     eof-move RPC ops really need compounding to avoid third-party
     interference.

And finally, here's an adjustment to debugging statements:

 (9) Adjust three debugging output statements.  Not strictly a fix, so
     could be dropped.  Including the subreq ID in some extra debug lines
     helps a bit, though.

The patches can also be found here:

	https://git.kernel.org/pub/scm/linux/kernel/git/dhowells/linux-fs.git/log/?h=netfs-fixes

They're on top of part of Christian's vfs.fixes tree, including the partial
reversion of the commit to replace PG_fscache.

Thanks,
David

David Howells (9):
  mm: Fix missing folio invalidation calls during truncation
  afs: Fix post-setattr file edit to do truncation correctly
  netfs: Fix netfs_release_folio() to say no if folio dirty
  netfs: Fix trimming of streaming-write folios in netfs_inval_folio()
  netfs: Fix missing iterator reset on retry of short read
  cifs: Fix lack of credit renegotiation on read retry
  netfs, cifs: Fix handling of short DIO read
  cifs: Fix FALLOC_FL_PUNCH_HOLE support
  netfs, cifs: Improve some debugging bits

 fs/afs/inode.c           | 11 ++++++---
 fs/netfs/io.c            | 22 +++++++++++------
 fs/netfs/misc.c          | 53 ++++++++++++++++++++++++++++------------
 fs/smb/client/cifsglob.h |  1 +
 fs/smb/client/file.c     | 37 +++++++++++++++++++++++++---
 fs/smb/client/smb2ops.c  | 32 +++++++++++++++++++++---
 fs/smb/client/smb2pdu.c  | 41 +++++++++++++++++++------------
 fs/smb/client/trace.h    |  1 +
 include/linux/netfs.h    |  1 +
 mm/truncate.c            |  4 +--
 10 files changed, 153 insertions(+), 50 deletions(-)

