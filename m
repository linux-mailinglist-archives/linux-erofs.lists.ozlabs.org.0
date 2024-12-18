Return-Path: <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>
X-Original-To: lists+linux-erofs@lfdr.de
Delivered-To: lists+linux-erofs@lfdr.de
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	by mail.lfdr.de (Postfix) with ESMTPS id 5D2549F6994
	for <lists+linux-erofs@lfdr.de>; Wed, 18 Dec 2024 16:10:43 +0100 (CET)
Received: from boromir.ozlabs.org (localhost [IPv6:::1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4YCxvP2qpqz30V3
	for <lists+linux-erofs@lfdr.de>; Thu, 19 Dec 2024 02:10:41 +1100 (AEDT)
X-Original-To: linux-erofs@lists.ozlabs.org
Delivered-To: linux-erofs@lists.ozlabs.org
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip=170.10.133.124
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1734534639;
	cv=none; b=eKgFr6wkF5tC86wXgweSJGooB1TlEB5DL2qUI40nijyNf9DU6zFQzTId26htOP8RN3Fbnn1ZTU2q/OKDjGA1mhe8WUCDKwZ9dUcSR6nrXpsb5FLzyl9kPeHMWJQ0zJQiN54e5SK4b21gvB7FoPh9Q3WwdDJkcf6ajgcTFGuFxDnenqZvOp8txN5zbZ6sNdoYL3XU7M7WGb4gV2/PyLBPsOUd8jk4cTF+Wn73ZT0bTALhbgGUP+nv0kjxniHVg80PV5g6qmSvESK+OaaOhKFHu5FUQSpaJV/LUROekUuQDlG+19nNU1hn8BkQt1k2MQuH6AQwb8qTS72OZFcjozltaQ==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1734534639; c=relaxed/relaxed;
	bh=Rq13+spy+qCFhDJsgxiTRuvUnBVAzO08weFgvcvuB7I=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=fBzTCk0Oj8r10dQBOA6OsvWCMo4Xa5U9rhnna3cnJBCe45CcrF/qrr1iEYLIH5xs/Ocz8efAZO2/yxl9jbAGOjjTLFDdQD/Bs5uIRLxYmVWqV/1ZjDepA4cqMPyVUvi6r4NOzx5Ze1bw40GdswdebvsvjySeW4Rtr8MmhS8Ww977JJVDEHMb7Q5Xg0bCwL0phtaDjLuSDP1wXVQnx8ugmtFSFCL0clO+EQWlAf988gKt/qpTgGc53M1QSZfRNi2EU+Lwx+7lhIe0RUM41etzyHAtamYRKFwYRHaTYxfWN5DZxINrxEdky90kIMIBBLGUab/lJbFBB12L9yHihMJniA==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=redhat.com; dkim=pass (1024-bit key; unprotected) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=BE4ptJh7; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=VGT0xaeO; dkim-atps=neutral; spf=pass (client-ip=170.10.133.124; helo=us-smtp-delivery-124.mimecast.com; envelope-from=amarkuze@redhat.com; receiver=lists.ozlabs.org) smtp.mailfrom=redhat.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (1024-bit key; unprotected) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=BE4ptJh7;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=VGT0xaeO;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=redhat.com (client-ip=170.10.133.124; helo=us-smtp-delivery-124.mimecast.com; envelope-from=amarkuze@redhat.com; receiver=lists.ozlabs.org)
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4YCxvL0YNFz30Vq
	for <linux-erofs@lists.ozlabs.org>; Thu, 19 Dec 2024 02:10:36 +1100 (AEDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1734534633;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=Rq13+spy+qCFhDJsgxiTRuvUnBVAzO08weFgvcvuB7I=;
	b=BE4ptJh705VWIue7Qx3TzVicfciWanbjWf01nq8M7a7Ya0vLEY2tPVW4DObb62dJLNS2Hi
	AAexwJmKtiDQzESxJLlk6bYyYWSuViAiuig9YIafMm4EZGejoMyVJvZBSoRQKj8919Durn
	gBJXKMtHxHrFTeHirJJXfD+H1dqL9QU=
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1734534634;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=Rq13+spy+qCFhDJsgxiTRuvUnBVAzO08weFgvcvuB7I=;
	b=VGT0xaeOSNImnNs3JXhZvPpcUh4sNvAy/PJFcqH0NXx5FViFM73C/iaaG5SpYOe30DciER
	fRekArsGqhxQeCCH6JOrio6SKX6BHPQo1HHpO5xkuZxRBuYkLxl4qygp9h08fjXlJsayQV
	MXB4YSXCV9rBFHoxge9zBLuKxF2jRvU=
Received: from mail-ed1-f72.google.com (mail-ed1-f72.google.com
 [209.85.208.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-118-NDmMNhAKNaeTXbKsiNWRbA-1; Wed, 18 Dec 2024 10:10:31 -0500
X-MC-Unique: NDmMNhAKNaeTXbKsiNWRbA-1
X-Mimecast-MFC-AGG-ID: NDmMNhAKNaeTXbKsiNWRbA
Received: by mail-ed1-f72.google.com with SMTP id 4fb4d7f45d1cf-5d3cdb9d4b1so940616a12.1
        for <linux-erofs@lists.ozlabs.org>; Wed, 18 Dec 2024 07:10:31 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1734534630; x=1735139430;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Rq13+spy+qCFhDJsgxiTRuvUnBVAzO08weFgvcvuB7I=;
        b=OvBm+9K2+UJ3ubkx8DmqMWhRozFWXEXZs3qhHDUbC+BJhYC+zgGgrkc+mvb4JBe6M0
         4fBzGDtmjPls8rjc0qn9pQZLKyEQXZL+NzCGxX3cbgbFRjefyqTDMKMBsq6b6hUSd91T
         X6xDFfKPciD22G2gMsyA6xm5nHx1JmR0X5BMyFkLDxSQMwE6sQTTf4bFUFtgpDHUzyoO
         NnNUIHB/YOsrSkta5hivH7+GW/6WUMPLjdXf73dNkUVJvJ1ws5+EGBv0DjnvhTNNKCoH
         Y7Edj8hmexaKV1PERVg9fB/ojv1U/9zce1WCnnoFjN553ohOcqX9cN00MyO6qwlzws82
         RJVw==
X-Forwarded-Encrypted: i=1; AJvYcCWnioDBIcdxFqp02WOeKwP7Fpe3t172x62u/VsZRo+2vbtESf59P2/+NBOo0fBcM9S41YmoeJQpGkZLtA==@lists.ozlabs.org
X-Gm-Message-State: AOJu0Yyj4hfrdTzDuf126n2+OD3SextKtGEfN/LuCqul2RAb7IbZP3ue
	pBC4SBIJuRX2Mt06XC1yWOaMci8DVVKTI+eJ50px7mYJAPcchtJc7MKOaFotKTV2VBtbeNmUWfn
	jmUN5NVbmadlbuQMZF6j1I6LvD4OKOrkhsHF9b9tUaKVAqygmpcIbDzukkriIGS/k9n+IXuOEXD
	YD+/OIXc6LY/MUBf7Zdnegp338g0K5wrjX/wGn
X-Gm-Gg: ASbGnctHKuIW/z/gxxAV+SL9jvM66YNUEauvrNECeegbfKhXJi9h8ey9lpmO70EYPQk
	rNTfFZXEyi545UZ+XHu845o8dNLa1smoTQJTqzQ==
X-Received: by 2002:a05:6402:4341:b0:5d3:e58c:25e2 with SMTP id 4fb4d7f45d1cf-5d7d556a032mr7458434a12.2.1734534630097;
        Wed, 18 Dec 2024 07:10:30 -0800 (PST)
X-Google-Smtp-Source: AGHT+IGPXB4Hx123hIFkjF3f0ABZNjkTu8BSyACv9a6CvqUYXqkqjaQQ+sXVlOZWB1mhhZKOt1MoxEBCl6ooO9B/teI=
X-Received: by 2002:a05:6402:4341:b0:5d3:e58c:25e2 with SMTP id
 4fb4d7f45d1cf-5d7d556a032mr7458383a12.2.1734534629616; Wed, 18 Dec 2024
 07:10:29 -0800 (PST)
MIME-Version: 1.0
References: <20241213135013.2964079-1-dhowells@redhat.com> <2964553.1734098664@warthog.procyon.org.uk>
In-Reply-To: <2964553.1734098664@warthog.procyon.org.uk>
From: Alex Markuze <amarkuze@redhat.com>
Date: Wed, 18 Dec 2024 17:10:18 +0200
Message-ID: <CAO8a2ShjqL=-jk8_8Lk5+V13Tf60B+c8K6XovXEQH7F-gPP4-Q@mail.gmail.com>
Subject: Re: ceph xfstests failures [was Re: [PATCH 00/10] netfs, ceph, nfs,
 cachefiles: Miscellaneous fixes/changes]
To: David Howells <dhowells@redhat.com>
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: pux4qs_vaH3Mlj2XY0dEhnKH8O0bV_VEvy7qoRPm_LI_1734534630
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
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
Cc: linux-cifs@vger.kernel.org, Max Kellermann <max.kellermann@ionos.com>, v9fs@lists.linux.dev, Jeff Layton <jlayton@kernel.org>, linux-nfs@vger.kernel.org, Matthew Wilcox <willy@infradead.org>, linux-kernel@vger.kernel.org, linux-mm@kvack.org, ceph-devel@vger.kernel.org, Christian Brauner <christian@brauner.io>, linux-fsdevel@vger.kernel.org, netfs@lists.linux.dev, Ilya Dryomov <idryomov@gmail.com>, Xiubo Li <xiubli@redhat.com>, linux-erofs@lists.ozlabs.org, linux-afs@lists.infradead.org, Trond Myklebust <trondmy@kernel.org>
Errors-To: linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org
Sender: "Linux-erofs" <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>

Hey David.
Thanks, for the find. I've seen your mail, but it was a busy week.
If you can, please open a https://tracker.ceph.com/ bug and assign it to me=
.

On Fri, Dec 13, 2024 at 4:05=E2=80=AFPM David Howells <dhowells@redhat.com>=
 wrote:
>
> David Howells <dhowells@redhat.com> wrote:
>
> > With these patches, I can run xfstest -g quick to completion on ceph wi=
th a
> > local cache.
>
> I should qualify that.  The thing completes and doesn't hang, but I get 6
> failures:
>
>     Failures: generic/604 generic/633 generic/645 generic/696 generic/697=
 generic/732
>
> Though these don't appear to be anything to do with netfslib (see attache=
d).
> There are two cases where the mount is busy and the rest seems to be due =
to
> id-mapped mounts and/or user namespaces.
>
> The xfstest local.config file looks something like:
>
>     export FSTYP=3Dceph
>     export TEST_DEV=3D<ipaddr>:/test
>     export TEST_DIR=3D/xfstest.test
>     TEST_FS_MOUNT_OPTS=3D'-o name=3Dadmin,mds_namespace=3Dtest,fs=3Dtest,=
fsc'
>     export SCRATCH_DEV=3D<ipaddr>:/scratch
>     export SCRATCH_MNT=3D/xfstest.scratch
>     export MOUNT_OPTIONS=3D'-o name=3Dadmin,mds_namespace=3Dscratch,fs=3D=
scratch,fsc=3Dscratch'
>
> David
> ---
> # ./check -E .exclude generic/604 generic/633 generic/645 generic/696 gen=
eric/697 generic/732
> FSTYP         -- ceph
> PLATFORM      -- Linux/x86_64 andromeda 6.13.0-rc2-build3+ #5311 SMP Fri =
Dec 13 09:03:34 GMT 2024
> MKFS_OPTIONS  -- <ipaddr>:/scratch
> MOUNT_OPTIONS -- -o name=3Dadmin,mds_namespace=3Dscratch,fs=3Dscratch,fsc=
=3Dscratch -o context=3Dsystem_u:object_r:root_t:s0 <ipaddr>:/scratch /xfst=
est.scratch
>
> generic/604 2s ... [failed, exit status 1]- output mismatch (see /root/xf=
stests-dev/results//generic/604.out.bad)
>     --- tests/generic/604.out   2024-09-12 12:36:14.187441830 +0100
>     +++ /root/xfstests-dev/results//generic/604.out.bad 2024-12-13 13:18:=
51.910900871 +0000
>     @@ -1,2 +1,4 @@
>      QA output created by 604
>     -Silence is golden
>     +mount error 16 =3D Device or resource busy
>     +mount -o name=3Dadmin,mds_namespace=3Dscratch,fs=3Dscratch,fsc=3Dscr=
atch -o context=3Dsystem_u:object_r:root_t:s0 <ipaddr>:/scratch /xfstest.sc=
ratch failed
>     +(see /root/xfstests-dev/results//generic/604.full for details)
>     ...
>     (Run 'diff -u /root/xfstests-dev/tests/generic/604.out /root/xfstests=
-dev/results//generic/604.out.bad'  to see the entire diff)
> generic/633       [failed, exit status 1]- output mismatch (see /root/xfs=
tests-dev/results//generic/633.out.bad)
>     --- tests/generic/633.out   2024-09-12 12:36:14.187441830 +0100
>     +++ /root/xfstests-dev/results//generic/633.out.bad 2024-12-13 13:18:=
55.958979531 +0000
>     @@ -1,2 +1,4 @@
>      QA output created by 633
>      Silence is golden
>     +idmapped-mounts.c: 307: tcore_create_in_userns - Input/output error =
- failure: open file
>     +vfstest.c: 2418: run_test - Success - failure: create operations in =
user namespace
>     ...
>     (Run 'diff -u /root/xfstests-dev/tests/generic/633.out /root/xfstests=
-dev/results//generic/633.out.bad'  to see the entire diff)
> generic/645       [failed, exit status 1]- output mismatch (see /root/xfs=
tests-dev/results//generic/645.out.bad)
>     --- tests/generic/645.out   2024-09-12 12:36:14.191441810 +0100
>     +++ /root/xfstests-dev/results//generic/645.out.bad 2024-12-13 13:19:=
25.526908024 +0000
>     @@ -1,2 +1,4 @@
>      QA output created by 645
>      Silence is golden
>     +idmapped-mounts.c: 6671: nested_userns - Invalid argument - failure:=
 sys_mount_setattr
>     +vfstest.c: 2418: run_test - Invalid argument - failure: test that ne=
sted user namespaces behave correctly when attached to idmapped mounts
>     ...
>     (Run 'diff -u /root/xfstests-dev/tests/generic/645.out /root/xfstests=
-dev/results//generic/645.out.bad'  to see the entire diff)
> generic/696       - output mismatch (see /root/xfstests-dev/results//gene=
ric/696.out.bad)
>     --- tests/generic/696.out   2024-09-12 12:36:14.195441791 +0100
>     +++ /root/xfstests-dev/results//generic/696.out.bad 2024-12-13 13:19:=
30.254804087 +0000
>     @@ -1,2 +1,6 @@
>      QA output created by 696
>     +idmapped-mounts.c: 7763: setgid_create_umask_idmapped - Input/output=
 error - failure: create
>     +vfstest.c: 2418: run_test - Success - failure: create operations by =
using umask in directories with setgid bit set on idmapped mount
>     +idmapped-mounts.c: 7763: setgid_create_umask_idmapped - Input/output=
 error - failure: create
>     +vfstest.c: 2418: run_test - Success - failure: create operations by =
using umask in directories with setgid bit set on idmapped mount
>      Silence is golden
>     ...
>     (Run 'diff -u /root/xfstests-dev/tests/generic/696.out /root/xfstests=
-dev/results//generic/696.out.bad'  to see the entire diff)
>
> HINT: You _MAY_ be missing kernel fix:
>       ac6800e279a2 fs: Add missing umask strip in vfs_tmpfile 1639a49ccdc=
e fs: move S_ISGID stripping into the vfs_*() helpers
>
> generic/697       - output mismatch (see /root/xfstests-dev/results//gene=
ric/697.out.bad)
>     --- tests/generic/697.out   2024-09-12 12:36:14.195441791 +0100
>     +++ /root/xfstests-dev/results//generic/697.out.bad 2024-12-13 13:19:=
31.749225548 +0000
>     @@ -1,2 +1,4 @@
>      QA output created by 697
>     +idmapped-mounts.c: 8218: setgid_create_acl_idmapped - Input/output e=
rror - failure: create
>     +vfstest.c: 2418: run_test - Success - failure: create operations by =
using acl in directories with setgid bit set on idmapped mount
>      Silence is golden
>     ...
>     (Run 'diff -u /root/xfstests-dev/tests/generic/697.out /root/xfstests=
-dev/results//generic/697.out.bad'  to see the entire diff)
>
> HINT: You _MAY_ be missing kernel fix:
>       1639a49ccdce fs: move S_ISGID stripping into the vfs_*() helpers
>
> generic/732 1s ... [failed, exit status 1]- output mismatch (see /root/xf=
stests-dev/results//generic/732.out.bad)
>     --- tests/generic/732.out   2024-09-12 12:36:14.195441791 +0100
>     +++ /root/xfstests-dev/results//generic/732.out.bad 2024-12-13 13:19:=
34.482858235 +0000
>     @@ -1,2 +1,5 @@
>      QA output created by 732
>      Silence is golden
>     +mount error 16 =3D Device or resource busy
>     +mount -o name=3Dadmin,mds_namespace=3Dscratch,fs=3Dscratch,fsc=3Dscr=
atch -o context=3Dsystem_u:object_r:root_t:s0 <ipaddr>:/scratch /xfstest.te=
st/mountpoint2-732 failed
>     +(see /root/xfstests-dev/results//generic/732.full for details)
>     ...
>     (Run 'diff -u /root/xfstests-dev/tests/generic/732.out /root/xfstests=
-dev/results//generic/732.out.bad'  to see the entire diff)
> Ran: generic/604 generic/633 generic/645 generic/696 generic/697 generic/=
732
> Failures: generic/604 generic/633 generic/645 generic/696 generic/697 gen=
eric/732
> Failed 6 of 6 tests
>
>

