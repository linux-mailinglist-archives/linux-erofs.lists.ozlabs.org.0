Return-Path: <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>
X-Original-To: lists+linux-erofs@lfdr.de
Delivered-To: lists+linux-erofs@lfdr.de
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	by mail.lfdr.de (Postfix) with ESMTPS id D59789F0E67
	for <lists+linux-erofs@lfdr.de>; Fri, 13 Dec 2024 15:04:45 +0100 (CET)
Received: from boromir.ozlabs.org (localhost [IPv6:::1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4Y8rgb3MPzz3bW5
	for <lists+linux-erofs@lfdr.de>; Sat, 14 Dec 2024 01:04:43 +1100 (AEDT)
X-Original-To: linux-erofs@lists.ozlabs.org
Delivered-To: linux-erofs@lists.ozlabs.org
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip=170.10.133.124
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1734098681;
	cv=none; b=a/2t2IwhEDub7xr5R4/Cti/FwMLgfRxRdc459ZlsETortVUiy/oLyJzDhVMMkr21ixyMU99qt4p3eHL/Vmw5uMdDyfKRvLtXtOkkBw5kLaN8H58r2xpRPp3TMVYs5vNkBHPPCDkMOhSIqYCdxCURn/jR3vsf4XczeWps+Z3/zuZ/x6FilUY0BJWtYLWYSItXQJTcp9riak/zN5ac6g7fHQ448/WYimGMU9dJOM9+8KQlUoa+QNCxRkwnA3UO3Wsx9aUct8SftYo3AyJ9tZWzkDUxa5PuoI7LxaYlKRqUpUwFDbbvSh9vEzQHRd7BQcc1Y4e78JKx9o+K1odovU2dxA==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1734098681; c=relaxed/relaxed;
	bh=BMjJh3rNwqJWG/q45S190yCaLe7IaLUoUOyUtTRrI4M=;
	h=From:In-Reply-To:References:To:Cc:Subject:MIME-Version:
	 Content-Type:Date:Message-ID; b=dSmJ+hkH3lcza8cgqX7FqGeYoWiIFPGkjv+DXmWxdd6CrCFC+RoVAaAwcM3GcvXUU9aeikJV/EtzZplchfq9MEhPT82Hpk+cUIV2x6vA+XyU57JXwZjv9eEOcYIrgBAV1ocYr6epA82qFUgAz5swAgD3IsX3AbWEiD2+2sT3zPkLS8nElOvkK5e9sLXmnRg5SakohJOgDBqnR4OWJD2z8Mixyil6v7br/DXOf/bVBSGRb6c+QU+CbRXpDXi2DhXKbX5SqcRMYMNkZs+WcsTfwbxEaSPp5gRhUzvNPA7Yj4nIrrmGbB7axOB3iF6BB1uG3X7IMszbZU92EPY1NbQ/2g==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=redhat.com; dkim=pass (1024-bit key; unprotected) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=fbW1lkm9; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=fbW1lkm9; dkim-atps=neutral; spf=pass (client-ip=170.10.133.124; helo=us-smtp-delivery-124.mimecast.com; envelope-from=dhowells@redhat.com; receiver=lists.ozlabs.org) smtp.mailfrom=redhat.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (1024-bit key; unprotected) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=fbW1lkm9;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=fbW1lkm9;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=redhat.com (client-ip=170.10.133.124; helo=us-smtp-delivery-124.mimecast.com; envelope-from=dhowells@redhat.com; receiver=lists.ozlabs.org)
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4Y8rgX5Xjjz3bTH
	for <linux-erofs@lists.ozlabs.org>; Sat, 14 Dec 2024 01:04:39 +1100 (AEDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1734098676;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=BMjJh3rNwqJWG/q45S190yCaLe7IaLUoUOyUtTRrI4M=;
	b=fbW1lkm9MwHLhbM6SF61UyyGxvPMRKwkKHnwWZUZ/abJhwWA9Gg3UEMt8/AXNo7rEejY58
	ouWse9VNbN0WmKOjtyHnEtsyTvE6lVqSv58yTZlkO9wO/gg4kVDXE9NFAnlPhy9BoYBrtQ
	HIlWNC+N+y2H6Qqw9f1r/x2mV/yK5Js=
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1734098676;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=BMjJh3rNwqJWG/q45S190yCaLe7IaLUoUOyUtTRrI4M=;
	b=fbW1lkm9MwHLhbM6SF61UyyGxvPMRKwkKHnwWZUZ/abJhwWA9Gg3UEMt8/AXNo7rEejY58
	ouWse9VNbN0WmKOjtyHnEtsyTvE6lVqSv58yTZlkO9wO/gg4kVDXE9NFAnlPhy9BoYBrtQ
	HIlWNC+N+y2H6Qqw9f1r/x2mV/yK5Js=
Received: from mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-528-A8uEA95lOSGhAgZJarh21Q-1; Fri,
 13 Dec 2024 09:04:32 -0500
X-MC-Unique: A8uEA95lOSGhAgZJarh21Q-1
X-Mimecast-MFC-AGG-ID: A8uEA95lOSGhAgZJarh21Q
Received: from mx-prod-int-04.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-04.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.40])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id BCB9F1955E9A;
	Fri, 13 Dec 2024 14:04:29 +0000 (UTC)
Received: from warthog.procyon.org.uk (unknown [10.42.28.48])
	by mx-prod-int-04.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id 9948F195605A;
	Fri, 13 Dec 2024 14:04:25 +0000 (UTC)
Organization: Red Hat UK Ltd. Registered Address: Red Hat UK Ltd, Amberley
	Place, 107-111 Peascod Street, Windsor, Berkshire, SI4 1TE, United
	Kingdom.
	Registered in England and Wales under Company Registration No. 3798903
From: David Howells <dhowells@redhat.com>
In-Reply-To: <20241213135013.2964079-1-dhowells@redhat.com>
References: <20241213135013.2964079-1-dhowells@redhat.com>
To: Christian Brauner <christian@brauner.io>,
    Ilya Dryomov <idryomov@gmail.com>
Subject: ceph xfstests failures [was Re: [PATCH 00/10] netfs, ceph, nfs, cachefiles: Miscellaneous fixes/changes]
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-ID: <2964552.1734098664.1@warthog.procyon.org.uk>
Content-Transfer-Encoding: quoted-printable
Date: Fri, 13 Dec 2024 14:04:24 +0000
Message-ID: <2964553.1734098664@warthog.procyon.org.uk>
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.40
X-Spam-Status: No, score=-0.5 required=5.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
	RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS autolearn=disabled
	version=4.0.0
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
Cc: linux-cifs@vger.kernel.org, Max Kellermann <max.kellermann@ionos.com>, v9fs@lists.linux.dev, Jeff Layton <jlayton@kernel.org>, linux-nfs@vger.kernel.org, Matthew Wilcox <willy@infradead.org>, linux-kernel@vger.kernel.org, dhowells@redhat.com, linux-mm@kvack.org, linux-fsdevel@vger.kernel.org, netfs@lists.linux.dev, ceph-devel@vger.kernel.org, Xiubo Li <xiubli@redhat.com>, linux-erofs@lists.ozlabs.org, linux-afs@lists.infradead.org, Trond Myklebust <trondmy@kernel.org>
Errors-To: linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org
Sender: "Linux-erofs" <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>

David Howells <dhowells@redhat.com> wrote:

> With these patches, I can run xfstest -g quick to completion on ceph wit=
h a
> local cache.

I should qualify that.  The thing completes and doesn't hang, but I get 6
failures:

    Failures: generic/604 generic/633 generic/645 generic/696 generic/697 =
generic/732

Though these don't appear to be anything to do with netfslib (see attached=
).
There are two cases where the mount is busy and the rest seems to be due t=
o
id-mapped mounts and/or user namespaces.

The xfstest local.config file looks something like:

    export FSTYP=3Dceph
    export TEST_DEV=3D<ipaddr>:/test
    export TEST_DIR=3D/xfstest.test
    TEST_FS_MOUNT_OPTS=3D'-o name=3Dadmin,mds_namespace=3Dtest,fs=3Dtest,f=
sc'
    export SCRATCH_DEV=3D<ipaddr>:/scratch
    export SCRATCH_MNT=3D/xfstest.scratch
    export MOUNT_OPTIONS=3D'-o name=3Dadmin,mds_namespace=3Dscratch,fs=3Ds=
cratch,fsc=3Dscratch'

David
---
# ./check -E .exclude generic/604 generic/633 generic/645 generic/696 gene=
ric/697 generic/732
FSTYP         -- ceph
PLATFORM      -- Linux/x86_64 andromeda 6.13.0-rc2-build3+ #5311 SMP Fri D=
ec 13 09:03:34 GMT 2024
MKFS_OPTIONS  -- <ipaddr>:/scratch
MOUNT_OPTIONS -- -o name=3Dadmin,mds_namespace=3Dscratch,fs=3Dscratch,fsc=3D=
scratch -o context=3Dsystem_u:object_r:root_t:s0 <ipaddr>:/scratch /xfstes=
t.scratch

generic/604 2s ... [failed, exit status 1]- output mismatch (see /root/xfs=
tests-dev/results//generic/604.out.bad)
    --- tests/generic/604.out   2024-09-12 12:36:14.187441830 +0100
    +++ /root/xfstests-dev/results//generic/604.out.bad 2024-12-13 13:18:5=
1.910900871 +0000
    @@ -1,2 +1,4 @@
     QA output created by 604
    -Silence is golden
    +mount error 16 =3D Device or resource busy
    +mount -o name=3Dadmin,mds_namespace=3Dscratch,fs=3Dscratch,fsc=3Dscra=
tch -o context=3Dsystem_u:object_r:root_t:s0 <ipaddr>:/scratch /xfstest.sc=
ratch failed
    +(see /root/xfstests-dev/results//generic/604.full for details)
    ...
    (Run 'diff -u /root/xfstests-dev/tests/generic/604.out /root/xfstests-=
dev/results//generic/604.out.bad'  to see the entire diff)
generic/633       [failed, exit status 1]- output mismatch (see /root/xfst=
ests-dev/results//generic/633.out.bad)
    --- tests/generic/633.out   2024-09-12 12:36:14.187441830 +0100
    +++ /root/xfstests-dev/results//generic/633.out.bad 2024-12-13 13:18:5=
5.958979531 +0000
    @@ -1,2 +1,4 @@
     QA output created by 633
     Silence is golden
    +idmapped-mounts.c: 307: tcore_create_in_userns - Input/output error -=
 failure: open file
    +vfstest.c: 2418: run_test - Success - failure: create operations in u=
ser namespace
    ...
    (Run 'diff -u /root/xfstests-dev/tests/generic/633.out /root/xfstests-=
dev/results//generic/633.out.bad'  to see the entire diff)
generic/645       [failed, exit status 1]- output mismatch (see /root/xfst=
ests-dev/results//generic/645.out.bad)
    --- tests/generic/645.out   2024-09-12 12:36:14.191441810 +0100
    +++ /root/xfstests-dev/results//generic/645.out.bad 2024-12-13 13:19:2=
5.526908024 +0000
    @@ -1,2 +1,4 @@
     QA output created by 645
     Silence is golden
    +idmapped-mounts.c: 6671: nested_userns - Invalid argument - failure: =
sys_mount_setattr
    +vfstest.c: 2418: run_test - Invalid argument - failure: test that nes=
ted user namespaces behave correctly when attached to idmapped mounts
    ...
    (Run 'diff -u /root/xfstests-dev/tests/generic/645.out /root/xfstests-=
dev/results//generic/645.out.bad'  to see the entire diff)
generic/696       - output mismatch (see /root/xfstests-dev/results//gener=
ic/696.out.bad)
    --- tests/generic/696.out   2024-09-12 12:36:14.195441791 +0100
    +++ /root/xfstests-dev/results//generic/696.out.bad 2024-12-13 13:19:3=
0.254804087 +0000
    @@ -1,2 +1,6 @@
     QA output created by 696
    +idmapped-mounts.c: 7763: setgid_create_umask_idmapped - Input/output =
error - failure: create
    +vfstest.c: 2418: run_test - Success - failure: create operations by u=
sing umask in directories with setgid bit set on idmapped mount
    +idmapped-mounts.c: 7763: setgid_create_umask_idmapped - Input/output =
error - failure: create
    +vfstest.c: 2418: run_test - Success - failure: create operations by u=
sing umask in directories with setgid bit set on idmapped mount
     Silence is golden
    ...
    (Run 'diff -u /root/xfstests-dev/tests/generic/696.out /root/xfstests-=
dev/results//generic/696.out.bad'  to see the entire diff)

HINT: You _MAY_ be missing kernel fix:
      ac6800e279a2 fs: Add missing umask strip in vfs_tmpfile 1639a49ccdce=
 fs: move S_ISGID stripping into the vfs_*() helpers

generic/697       - output mismatch (see /root/xfstests-dev/results//gener=
ic/697.out.bad)
    --- tests/generic/697.out   2024-09-12 12:36:14.195441791 +0100
    +++ /root/xfstests-dev/results//generic/697.out.bad 2024-12-13 13:19:3=
1.749225548 +0000
    @@ -1,2 +1,4 @@
     QA output created by 697
    +idmapped-mounts.c: 8218: setgid_create_acl_idmapped - Input/output er=
ror - failure: create
    +vfstest.c: 2418: run_test - Success - failure: create operations by u=
sing acl in directories with setgid bit set on idmapped mount
     Silence is golden
    ...
    (Run 'diff -u /root/xfstests-dev/tests/generic/697.out /root/xfstests-=
dev/results//generic/697.out.bad'  to see the entire diff)

HINT: You _MAY_ be missing kernel fix:
      1639a49ccdce fs: move S_ISGID stripping into the vfs_*() helpers

generic/732 1s ... [failed, exit status 1]- output mismatch (see /root/xfs=
tests-dev/results//generic/732.out.bad)
    --- tests/generic/732.out   2024-09-12 12:36:14.195441791 +0100
    +++ /root/xfstests-dev/results//generic/732.out.bad 2024-12-13 13:19:3=
4.482858235 +0000
    @@ -1,2 +1,5 @@
     QA output created by 732
     Silence is golden
    +mount error 16 =3D Device or resource busy
    +mount -o name=3Dadmin,mds_namespace=3Dscratch,fs=3Dscratch,fsc=3Dscra=
tch -o context=3Dsystem_u:object_r:root_t:s0 <ipaddr>:/scratch /xfstest.te=
st/mountpoint2-732 failed
    +(see /root/xfstests-dev/results//generic/732.full for details)
    ...
    (Run 'diff -u /root/xfstests-dev/tests/generic/732.out /root/xfstests-=
dev/results//generic/732.out.bad'  to see the entire diff)
Ran: generic/604 generic/633 generic/645 generic/696 generic/697 generic/7=
32
Failures: generic/604 generic/633 generic/645 generic/696 generic/697 gene=
ric/732
Failed 6 of 6 tests

