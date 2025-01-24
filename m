Return-Path: <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>
X-Original-To: lists+linux-erofs@lfdr.de
Delivered-To: lists+linux-erofs@lfdr.de
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2404:9400:2:0:216:3eff:fee1:b9f1])
	by mail.lfdr.de (Postfix) with ESMTPS id 435C6A1BD05
	for <lists+linux-erofs@lfdr.de>; Fri, 24 Jan 2025 20:55:06 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=lists.ozlabs.org;
	s=201707; t=1737748503;
	bh=WPCmK7URrEy7NOqMZEP/caP4Gj0g1hUC7OKlgx+c3dY=;
	h=Date:To:Subject:In-Reply-To:References:List-Id:List-Unsubscribe:
	 List-Archive:List-Post:List-Help:List-Subscribe:From:Reply-To:Cc:
	 From;
	b=fwBuf2Rt1cQLPaMC2fGRj4mbcjzYbkVH/NbqyQaYytEBCKw6s1WPm0bP1a8cg69gP
	 Gtk1SAYG1ACUYEhIP0Ag0YuP15cIUKcCq7xMCr4fEy0DoxELkj5yyxyXwkTatYlLYp
	 M0cN18tul6OiqI1T06dLQv0Y42kWhwv+WHAjZgh7cBQtyey0ELbwUa5Px6JT2sZpk8
	 /BzrRt4Oaz1i6SU3/9ziaP4pUeJUf7wIjbT/Nj+kOOY460zl/PpbFqeOQsYm0/vYN2
	 rIFVD6zQ1pnECBFAYuMp4nR+b+rTaOVFFWDSVAQvfMU5bVTqg5mqvpLzqLOiLwM5Ye
	 Wss+5s13q4k9w==
Received: from boromir.ozlabs.org (localhost [IPv6:::1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4YfpSR3Gtwz30Tp
	for <lists+linux-erofs@lfdr.de>; Sat, 25 Jan 2025 06:55:03 +1100 (AEDT)
X-Original-To: linux-erofs@lists.ozlabs.org
Delivered-To: linux-erofs@lists.ozlabs.org
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip=185.70.40.134
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1737748501;
	cv=none; b=fkLYB4QCKi5/wFoXpsFXKdoLcH7A5FvI53BFHlTJITnYjiUekVPaRArwoFaxr55L5+ndrXXQKtwq+KqL0ObIBQx8U2KYe72Lf5Lv1bfjhCFO4zKDXhCYjnhCrIA1BKU4OVfX51G7Zv5T9pKAXkFX6hscTZ8nZJB/5R0gEy5iOwcgFzHWLLYe2igCknkGPaCE6XEhK2PVLm/e4hndoJh/x5QlR2DvL0sDBlXLShX5PzVnpJBj0YDypc0MkdZFegVV98sp9P40j8uEDVjWzLWLTz7eG/eZWI67mP3iwGvSxrEPaDSaRlimb0TpDWS/veG54lesvw5VS4elpeMJq1EzpQ==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1737748501; c=relaxed/relaxed;
	bh=WPCmK7URrEy7NOqMZEP/caP4Gj0g1hUC7OKlgx+c3dY=;
	h=Date:To:From:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=GndWcg0/PmqmcdwNIndCV1sXfjgChAvdrgdVW1jpqryJPJzB3FcdcKtvO+soNvuy7QdhKnnBM4TVVBp/433qmtYY68MCsRuLGE2zH1275Hs++dn8dgwSp9ZKLYT8onh/LxdOl2p8yG3zkcJ9bFt6f8VDrAmxEVf8zrfChseIF5n37fpjxJ46GzyAjspFPw/kI9zFO4qMaPv9TEL3t6FgUKmI7E4Dz9+JeKukl+0FVddrz4kqGIUjSJZPiALJLrS46EyoY1TlPdtT2t40EF+mHdET0eSvQ2ewOICl17NAWmurqX0LdCFTq4de5/sL1Zi+IQP4DfIbClWKb643US+1Qw==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=pm.me; dkim=pass (2048-bit key; secure) header.d=pm.me header.i=@pm.me header.a=rsa-sha256 header.s=protonmail3 header.b=UYR56BC5; dkim-atps=neutral; spf=pass (client-ip=185.70.40.134; helo=mail-40134.protonmail.ch; envelope-from=ihor.solodrai@pm.me; receiver=lists.ozlabs.org) smtp.mailfrom=pm.me
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=pm.me
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; secure) header.d=pm.me header.i=@pm.me header.a=rsa-sha256 header.s=protonmail3 header.b=UYR56BC5;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=pm.me (client-ip=185.70.40.134; helo=mail-40134.protonmail.ch; envelope-from=ihor.solodrai@pm.me; receiver=lists.ozlabs.org)
Received: from mail-40134.protonmail.ch (mail-40134.protonmail.ch [185.70.40.134])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4YfpSM5vN4z2y8X
	for <linux-erofs@lists.ozlabs.org>; Sat, 25 Jan 2025 06:54:58 +1100 (AEDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pm.me;
	s=protonmail3; t=1737748491; x=1738007691;
	bh=WPCmK7URrEy7NOqMZEP/caP4Gj0g1hUC7OKlgx+c3dY=;
	h=Date:To:From:Cc:Subject:Message-ID:In-Reply-To:References:
	 Feedback-ID:From:To:Cc:Date:Subject:Reply-To:Feedback-ID:
	 Message-ID:BIMI-Selector:List-Unsubscribe:List-Unsubscribe-Post;
	b=UYR56BC5UZLNsKXH/ITJM6m10LcrV9IMfcxYmVw7ezph9ldDjZxvHpLCf22NzsZXr
	 OrtdrGTe0IEg/2uXeHRqE+5QFrrGiI2O/3gOK3ahONeosAcRBmfMNVTgYI3czCtp6P
	 lHl5LYy7Jsr9Xv/6gVxQUo0MB89dVLszkRF5f1hFeaZiGXh9aqV7mjtL2bFljmbu7a
	 3msIkFFaWc0liztBJiH3nHT5tFsDxDRDjPShqVvhx96DZHE32OTL/1JmyNXzl6O68F
	 dloKSQtVQfYlyyCI178bmd1mUkfMqVTpBUkRzcp1MQMW3dOhvyM5pJFzqO7AQvZyIV
	 jGDp4MsJ6jk2g==
Date: Fri, 24 Jan 2025 19:54:43 +0000
To: Marc Dionne <marc.c.dionne@gmail.com>
Subject: Re: [PATCH v5 27/32] netfs: Change the read result collector to only use one work item
Message-ID: <ZWHFHDukzfc7hoFZ8s7ebITzzuXLdL3jtI1Gm7XASpFGprxofyelizx8oA4JZthmee_YlnO7okLF4aUNLXaiZ2Ib_JtUTWzbCcsrnl4LX5w=@pm.me>
In-Reply-To: <CAB9dFds_bPG1vThvOxhKcoFbUPGURYRHrY_zubPrAqpQrgHA7A@mail.gmail.com>
References: <20241216204124.3752367-1-dhowells@redhat.com> <20241216204124.3752367-28-dhowells@redhat.com> <a7x33d4dnMdGTtRivptq6S1i8btK70SNBP2XyX_xwDAhLvgQoPox6FVBOkifq4eBinfFfbZlIkMZBe3QarlWTxoEtHZwJCZbNKtaqrR7PvI=@pm.me> <CAB9dFdtVFgG7OWZRytL9Vpr=knNPnMe6b_Esg7rgfFfwLa8j0A@mail.gmail.com> <GHG6tQSGPRj9L93-skG-HGz4vGtXUxy6ibsUTKloUKncNmy8A7xgte0MEiI0iZJ7jD-SSrZiK2oswgvJCRan_0ZMi6xDlP11SHDi1Utf7mI=@pm.me> <CAB9dFds_bPG1vThvOxhKcoFbUPGURYRHrY_zubPrAqpQrgHA7A@mail.gmail.com>
Feedback-ID: 27520582:user:proton
X-Pm-Message-ID: 4f0aec3e0f4ce82aa482624e5964b7d886d7a0e5
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-0.2 required=5.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H3,
	RCVD_IN_MSPIKE_WL,SPF_HELO_PASS,SPF_PASS autolearn=disabled
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
From: Ihor Solodrai via Linux-erofs <linux-erofs@lists.ozlabs.org>
Reply-To: Ihor Solodrai <ihor.solodrai@pm.me>
Cc: Dominique Martinet <asmadeus@codewreck.org>, David Howells <dhowells@redhat.com>, linux-mm@kvack.org, linux-afs@lists.infradead.org, Paulo Alcantara <pc@manguebit.com>, linux-cifs@vger.kernel.org, Matthew Wilcox <willy@infradead.org>, Steve French <smfrench@gmail.com>, Gao Xiang <hsiangkao@linux.alibaba.com>, Ilya Dryomov <idryomov@gmail.com>, Shyam Prasad N <sprasad@microsoft.com>, Tom Talpey <tom@talpey.com>, ceph-devel@vger.kernel.org, Eric Van Hensbergen <ericvh@kernel.org>, Christian Brauner <christian@brauner.io>, linux-nfs@vger.kernel.org, netdev@vger.kernel.org, v9fs@lists.linux.dev, Jeff Layton <jlayton@kernel.org>, linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org, netfs@lists.linux.dev, bpf <bpf@vger.kernel.org>, linux-erofs@lists.ozlabs.org
Errors-To: linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org
Sender: "Linux-erofs" <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>

On Friday, January 24th, 2025 at 11:07 AM, Marc Dionne <marc.c.dionne@gmail=
.com> wrote:

>=20
>=20
> On Fri, Jan 24, 2025 at 2:46=E2=80=AFPM Ihor Solodrai ihor.solodrai@pm.me=
 wrote:
>=20
> > On Friday, January 24th, 2025 at 10:21 AM, Marc Dionne marc.dionne@auri=
stor.com wrote:
> >=20
> > > [...]
> > >=20
> > > > A log snippet:
> > > >=20
> > > > 2025-01-24T02:15:03.9009694Z [ 246.932163] INFO: task ip:1055 block=
ed for more than 122 seconds.
> > > > 2025-01-24T02:15:03.9013633Z [ 246.932709] Tainted: G OE 6.13.0-g2b=
cb9cf535b8-dirty #149
> > > > 2025-01-24T02:15:03.9018791Z [ 246.933249] "echo 0 > /proc/sys/kern=
el/hung_task_timeout_secs" disables this message.
> > > > 2025-01-24T02:15:03.9025896Z [ 246.933802] task:ip state:D stack:0 =
pid:1055 tgid:1055 ppid:1054 flags:0x00004002
> > > > 2025-01-24T02:15:03.9028228Z [ 246.934564] Call Trace:
> > > > 2025-01-24T02:15:03.9029758Z [ 246.934764] <TASK>
> > > > 2025-01-24T02:15:03.9032572Z [ 246.934937] __schedule+0xa91/0xe80
> > > > 2025-01-24T02:15:03.9035126Z [ 246.935224] schedule+0x41/0xb0
> > > > 2025-01-24T02:15:03.9037992Z [ 246.935459] v9fs_evict_inode+0xfe/0x=
170
> > > > 2025-01-24T02:15:03.9041469Z [ 246.935748] ? __pfx_var_wake_functio=
n+0x10/0x10
> > > > 2025-01-24T02:15:03.9043837Z [ 246.936101] evict+0x1ef/0x360
> > > > 2025-01-24T02:15:03.9046624Z [ 246.936340] __dentry_kill+0xb0/0x220
> > > > 2025-01-24T02:15:03.9048855Z [ 246.936610] ? dput+0x3a/0x1d0
> > > > 2025-01-24T02:15:03.9051128Z [ 246.936838] dput+0x114/0x1d0
> > > > 2025-01-24T02:15:03.9053548Z [ 246.937069] __fput+0x136/0x2b0
> > > > 2025-01-24T02:15:03.9056154Z [ 246.937305] task_work_run+0x89/0xc0
> > > > 2025-01-24T02:15:03.9058593Z [ 246.937571] do_exit+0x2c6/0x9c0
> > > > 2025-01-24T02:15:03.9061349Z [ 246.937816] do_group_exit+0xa4/0xb0
> > > > 2025-01-24T02:15:03.9064401Z [ 246.938090] __x64_sys_exit_group+0x1=
7/0x20
> > > > 2025-01-24T02:15:03.9067235Z [ 246.938390] x64_sys_call+0x21a0/0x21=
a0
> > > > 2025-01-24T02:15:03.9069924Z [ 246.938672] do_syscall_64+0x79/0x120
> > > > 2025-01-24T02:15:03.9072746Z [ 246.938941] ? clear_bhb_loop+0x25/0x=
80
> > > > 2025-01-24T02:15:03.9075581Z [ 246.939230] ? clear_bhb_loop+0x25/0x=
80
> > > > 2025-01-24T02:15:03.9079275Z [ 246.939510] entry_SYSCALL_64_after_h=
wframe+0x76/0x7e
> > > > 2025-01-24T02:15:03.9081976Z [ 246.939875] RIP: 0033:0x7fb86f66f21d
> > > > 2025-01-24T02:15:03.9087533Z [ 246.940153] RSP: 002b:00007ffdb3cf93=
f8 EFLAGS: 00000202 ORIG_RAX: 00000000000000e7
> > > > 2025-01-24T02:15:03.9092590Z [ 246.940689] RAX: ffffffffffffffda RB=
X: 00007fb86f785fa8 RCX: 00007fb86f66f21d
> > > > 2025-01-24T02:15:03.9097722Z [ 246.941201] RDX: 00000000000000e7 RS=
I: ffffffffffffff80 RDI: 0000000000000000
> > > > 2025-01-24T02:15:03.9102762Z [ 246.941705] RBP: 00007ffdb3cf9450 R0=
8: 00007ffdb3cf93a0 R09: 0000000000000000
> > > > 2025-01-24T02:15:03.9107940Z [ 246.942215] R10: 00007ffdb3cf92ff R1=
1: 0000000000000202 R12: 0000000000000001
> > > > 2025-01-24T02:15:03.9113002Z [ 246.942723] R13: 0000000000000000 R1=
4: 0000000000000000 R15: 00007fb86f785fc0
> > > > 2025-01-24T02:15:03.9114614Z [ 246.943244] </TASK>
> > >=20
> > > That looks very similar to something I saw in afs testing, with a
> > > similar stack but in afs_evict_inode where it hung waiting in
> > > netfs_wait_for_outstanding_io.
> > >=20
> > > David pointed to this bit where there's a double get in
> > > netfs_retry_read_subrequests, since netfs_reissue_read already takes
> > > care of getting a ref on the subrequest:
> > >=20
> > > diff --git a/fs/netfs/read_retry.c b/fs/netfs/read_retry.c
> > > index 2290af0d51ac..53d62e31a4cc 100644
> > > --- a/fs/netfs/read_retry.c
> > > +++ b/fs/netfs/read_retry.c
> > > @@ -152,7 +152,6 @@ static void netfs_retry_read_subrequests(struct
> > > netfs_io_request *rreq)
> > > __clear_bit(NETFS_SREQ_BOUNDARY,
> > > &subreq->flags);
> > >=20
> > > }
> > >=20
> > > - netfs_get_subrequest(subreq,
> > > netfs_sreq_trace_get_resubmit);
> > > netfs_reissue_read(rreq, subreq);
> > > if (subreq =3D=3D to)
> > > break;
> > >=20
> > > That seems to help for my afs test case, I suspect it might help in
> > > your case as well.
> >=20
> > Hi Marc. Thank you for the suggestion.
> >=20
> > I've just tried this diff on top of bpf-next (d0d106a2bd21):
> >=20
> > diff --git a/fs/netfs/read_retry.c b/fs/netfs/read_retry.c
> > index 2290af0d51ac..53d62e31a4cc 100644
> > --- a/fs/netfs/read_retry.c
> > +++ b/fs/netfs/read_retry.c
> > @@ -152,7 +152,6 @@ static void netfs_retry_read_subrequests(struct net=
fs_io_request *rreq)
> > __clear_bit(NETFS_SREQ_BOUNDARY, &subreq->flags);
> > }
> >=20
> > - netfs_get_subrequest(subreq, netfs_sreq_trace_get_resubmit);
> > netfs_reissue_read(rreq, subreq);
> > if (subreq =3D=3D to)
> > break;
> >=20
> > and I'm getting a hung task with the same stack
> >=20
> > [ 184.362292] INFO: task modprobe:2527 blocked for more than 20 seconds=
.
> > [ 184.363173] Tainted: G OE 6.13.0-gd0d106a2bd21-dirty #1
> > [ 184.363651] "echo 0 > /proc/sys/kernel/hung_task_timeout_secs" disabl=
es this message.
> > [ 184.364142] task:modprobe state:D stack:0 pid:2527 tgid:2527 ppid:213=
4 flags:0x00000002
> > [ 184.364743] Call Trace:
> > [ 184.364907] <TASK>
> > [ 184.365057] __schedule+0xa91/0xe80
> > [ 184.365311] schedule+0x41/0xb0
> > [ 184.365525] v9fs_evict_inode+0xfe/0x170
> > [ 184.365782] ? __pfx_var_wake_function+0x10/0x10
> > [ 184.366082] evict+0x1ef/0x360
> > [ 184.366312] __dentry_kill+0xb0/0x220
> > [ 184.366561] ? dput+0x3a/0x1d0
> > [ 184.366765] dput+0x114/0x1d0
> > [ 184.366962] __fput+0x136/0x2b0
> > [ 184.367172] __x64_sys_close+0x9e/0xd0
> > [ 184.367443] do_syscall_64+0x79/0x120
> > [ 184.367685] entry_SYSCALL_64_after_hwframe+0x76/0x7e
> > [ 184.368005] RIP: 0033:0x7f4c6fc7f60b
> > [ 184.368249] RSP: 002b:00007ffc7582beb8 EFLAGS: 00000297 ORIG_RAX: 000=
0000000000003
> > [ 184.368733] RAX: ffffffffffffffda RBX: 0000555e18cff7a0 RCX: 00007f4c=
6fc7f60b
> > [ 184.369176] RDX: 00007f4c6fd64ee0 RSI: 0000000000000001 RDI: 00000000=
00000000
> > [ 184.369634] RBP: 00007ffc7582bee0 R08: 0000000000000000 R09: 00000000=
00000007
> > [ 184.370078] R10: 0000555e18cff980 R11: 0000000000000297 R12: 00000000=
00000000
> > [ 184.370544] R13: 00007f4c6fd65030 R14: 0000555e18cff980 R15: 0000555e=
18d7b750
> > [ 184.371004] </TASK>
> > [ 184.371151]
> > [ 184.371151] Showing all locks held in the system:
> > [ 184.371560] 1 lock held by khungtaskd/32:
> > [ 184.371816] #0: ffffffff83195d90 (rcu_read_lock){....}-{1:3}, at: deb=
ug_show_all_locks+0x2e/0x180
> > [ 184.372397] 2 locks held by kworker/u8:21/2134:
> > [ 184.372695] #0: ffff9a5300104d48 ((wq_completion)events_unbound){+.+.=
}-{0:0}, at: process_scheduled_works+0x23a/0x600
> > [ 184.373376] #1: ffff9e9882187e20 ((work_completion)(&sub_info->work))=
{+.+.}-{0:0}, at: process_scheduled_works+0x25a/0x600
> > [ 184.374075]
> > [ 184.374182] =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D
> >=20
> > So this appears to be something different.
> >=20
> > > Marc
>=20
>=20
> Looks like there may be a similar issue with the
> netfs_get_subrequest() at line 196, which also precedes a call to
> netfs_reissue_read. Might be worth trying with that removed as well.

Just did that. Got lucky locally, but no changes on CI:
https://github.com/kernel-patches/vmtest/actions/runs/12956261831/job/36142=
811371

Do you know of any pending patches addressing the double-get issue?
Does this diff reliably fix the hang in afs_evict_inode?

Thanks.

diff --git a/fs/netfs/read_retry.c b/fs/netfs/read_retry.c
index 2290af0d51ac..6c8327f4227c 100644
--- a/fs/netfs/read_retry.c
+++ b/fs/netfs/read_retry.c
@@ -152,7 +152,6 @@ static void netfs_retry_read_subrequests(struct netfs_i=
o_request *rreq)
                                __clear_bit(NETFS_SREQ_BOUNDARY, &subreq->f=
lags);
                        }
=20
-                       netfs_get_subrequest(subreq, netfs_sreq_trace_get_r=
esubmit);
                        netfs_reissue_read(rreq, subreq);
                        if (subreq =3D=3D to)
                                break;
@@ -194,7 +193,6 @@ static void netfs_retry_read_subrequests(struct netfs_i=
o_request *rreq)
                        trace_netfs_sreq_ref(rreq->debug_id, subreq->debug_=
index,
                                             refcount_read(&subreq->ref),
                                             netfs_sreq_trace_new);
-                       netfs_get_subrequest(subreq, netfs_sreq_trace_get_r=
esubmit);
=20
                        list_add(&subreq->rreq_link, &to->rreq_link);
                        to =3D list_next_entry(to, rreq_link);

>=20
> Marc
