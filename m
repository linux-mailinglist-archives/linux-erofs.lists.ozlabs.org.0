Return-Path: <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>
X-Original-To: lists+linux-erofs@lfdr.de
Delivered-To: lists+linux-erofs@lfdr.de
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	by mail.lfdr.de (Postfix) with ESMTPS id 17495A1BBCC
	for <lists+linux-erofs@lfdr.de>; Fri, 24 Jan 2025 19:00:06 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=lists.ozlabs.org;
	s=201707; t=1737741599;
	bh=4rrjsE+MvicrrQ6Y6gD9cIT/HyQUToaWe+K01zQPoq8=;
	h=Date:To:Subject:In-Reply-To:References:List-Id:List-Unsubscribe:
	 List-Archive:List-Post:List-Help:List-Subscribe:From:Reply-To:Cc:
	 From;
	b=KyNIAAMcocRxhhYr4X4ISKiFNkqjN7/ST17eeCn0emWfcyxtd3Cx3AtYtPZYg6HeL
	 qiUPu36EaNknBrdLaZj8bqs4kmzHZ2e6rhZNFMwx/EGrWWHSr1GIVCsHER/kGhjgII
	 f3+m/oe8TLl4EF+49MJVgibEEP5LBPAd+bl0QnAeY5vjBtHPAjN2wfcGgRiDz/nJK3
	 wbcgAeF7hBIl4drSAbbJcQzGyKNb+88pTiRyFzg+Rpm3wzQrKYfRUfklzFRB1QoTw6
	 2+VNucPl5jsigfJ3l11idGSwDg2lF98OQMqWMc8tWUR8bHjVszvLXIro1bqufLJc8L
	 OZAxOZ1svsMWA==
Received: from boromir.ozlabs.org (localhost [IPv6:::1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4Yflvg4JkSz30V0
	for <lists+linux-erofs@lfdr.de>; Sat, 25 Jan 2025 04:59:59 +1100 (AEDT)
X-Original-To: linux-erofs@lists.ozlabs.org
Delivered-To: linux-erofs@lists.ozlabs.org
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip=185.70.43.22
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1737741597;
	cv=none; b=VowHl7VK8e105PRhZLtvgRowdzFZ3+kn//mQ7nR5RAvUuoJQUOSz94qQuU9Gk798o9gN+ehl+garI7NJHUmwXE7vyMqwYOm9iC5PJZ9eyPsMMTlbR+y9YCH7TBiZbgQtouBFDA/873SCrReNcMsxYzbhoDXsn2KNuNKR6qLvcJO01clF85+okvMWw2f7okvTsoyWp6SJ6o7iPrYpcDdsRHnlNlp+C+4syAJg0naJLSubsn6cfoZX/Bte2gJ8jCFGruTXnTV18uXNG78bqtL5+TuSP9pzY1MA1xYujE9MWML9BLZ8PKNkmY0H75eou1xExPjPqekzUCWTdmuwZ0MLpA==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1737741597; c=relaxed/relaxed;
	bh=4rrjsE+MvicrrQ6Y6gD9cIT/HyQUToaWe+K01zQPoq8=;
	h=Date:To:From:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=EqjA3Lo+1SDeX+sh65PVrr4Ma5xDzUfhJcHANYWn1ezXy0/pUe6IgFM4wt8hwRP6PdpOonjA2QlqAKKVbw4Zvjv1MbcR6YD9wqu0QJVIAoQ0Hg5L3w8mPQoqfufE0epLWJMbeD7BQt7V1t2HUyXdjIqpm3osoOXu2As85sdPLdMIqbCMPmcwhJ5A8erG2DhDUQYYixQbbq1XlU+JGGX3BhcO8a7DyAWJ8bhHAH44VvXLCbO8gqsCYVSS1WVHrpdCmwYJoPC5x7EX38FexzpLwJvfhQtboeshcWbUDPIrYYfKuUioIQgc5z09XnHo9wTJ0Ot59pGF3DuTGFNWp4Cw/w==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=pm.me; dkim=pass (2048-bit key; secure) header.d=pm.me header.i=@pm.me header.a=rsa-sha256 header.s=protonmail3 header.b=JIbIB9RK; dkim-atps=neutral; spf=pass (client-ip=185.70.43.22; helo=mail-4322.protonmail.ch; envelope-from=ihor.solodrai@pm.me; receiver=lists.ozlabs.org) smtp.mailfrom=pm.me
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=pm.me
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; secure) header.d=pm.me header.i=@pm.me header.a=rsa-sha256 header.s=protonmail3 header.b=JIbIB9RK;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=pm.me (client-ip=185.70.43.22; helo=mail-4322.protonmail.ch; envelope-from=ihor.solodrai@pm.me; receiver=lists.ozlabs.org)
Received: from mail-4322.protonmail.ch (mail-4322.protonmail.ch [185.70.43.22])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4Yflvb5k9sz2yMF
	for <linux-erofs@lists.ozlabs.org>; Sat, 25 Jan 2025 04:59:55 +1100 (AEDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pm.me;
	s=protonmail3; t=1737741587; x=1738000787;
	bh=4rrjsE+MvicrrQ6Y6gD9cIT/HyQUToaWe+K01zQPoq8=;
	h=Date:To:From:Cc:Subject:Message-ID:In-Reply-To:References:
	 Feedback-ID:From:To:Cc:Date:Subject:Reply-To:Feedback-ID:
	 Message-ID:BIMI-Selector:List-Unsubscribe:List-Unsubscribe-Post;
	b=JIbIB9RK1AoMS0k9EJR6pJxIvCsuc8wWj0+M0dglHO9q1JpdzdAmkHasYCrL6Xtg3
	 yZLr3M62KQpW6QElSB9M+pcd4aMm0HT2wqw0UCCvPmLAHp0lzj3Ee1K42YrTJnD1ZJ
	 iMniNpaAOj+ZqKs0nfS4IhVd194HyBZ9cNCQm9XctxK4WpskYdAABH7CX2J5lBkY13
	 e0IfEJyknM5ANHMu9Kt8dKBp9jMsb84bURnBlrw52rQdtq+69a5McLcAQtpO65sGdt
	 41iS4elHgn1exDbKEeUD8x2Poaxtujd+Vr2jIZyVsNGCPiSgDJOwnEXYL+xEoaLsuF
	 mLAK+CeNGGy/w==
Date: Fri, 24 Jan 2025 17:59:39 +0000
To: David Howells <dhowells@redhat.com>
Subject: Re: [PATCH v5 27/32] netfs: Change the read result collector to only use one work item
Message-ID: <a7x33d4dnMdGTtRivptq6S1i8btK70SNBP2XyX_xwDAhLvgQoPox6FVBOkifq4eBinfFfbZlIkMZBe3QarlWTxoEtHZwJCZbNKtaqrR7PvI=@pm.me>
In-Reply-To: <20241216204124.3752367-28-dhowells@redhat.com>
References: <20241216204124.3752367-1-dhowells@redhat.com> <20241216204124.3752367-28-dhowells@redhat.com>
Feedback-ID: 27520582:user:proton
X-Pm-Message-ID: 2d63f4f4ff77fa7cfd9219388b78b772c9c2eebe
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-0.2 required=5.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS
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
From: Ihor Solodrai via Linux-erofs <linux-erofs@lists.ozlabs.org>
Reply-To: Ihor Solodrai <ihor.solodrai@pm.me>
Cc: Dominique Martinet <asmadeus@codewreck.org>, linux-mm@kvack.org, Marc Dionne <marc.dionne@auristor.com>, linux-afs@lists.infradead.org, Paulo Alcantara <pc@manguebit.com>, linux-cifs@vger.kernel.org, Matthew Wilcox <willy@infradead.org>, Steve French <smfrench@gmail.com>, Gao Xiang <hsiangkao@linux.alibaba.com>, Ilya Dryomov <idryomov@gmail.com>, Shyam Prasad N <sprasad@microsoft.com>, Tom Talpey <tom@talpey.com>, ceph-devel@vger.kernel.org, Eric Van Hensbergen <ericvh@kernel.org>, Christian Brauner <christian@brauner.io>, linux-nfs@vger.kernel.org, netdev@vger.kernel.org, v9fs@lists.linux.dev, Jeff Layton <jlayton@kernel.org>, linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org, netfs@lists.linux.dev, bpf <bpf@vger.kernel.org>, linux-erofs@lists.ozlabs.org
Errors-To: linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org
Sender: "Linux-erofs" <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>

On Monday, December 16th, 2024 at 12:41 PM, David Howells <dhowells@redhat.=
com> wrote:

> Change the way netfslib collects read results to do all the collection fo=
r
> a particular read request using a single work item that walks along the
> subrequest queue as subrequests make progress or complete, unlocking foli=
os
> progressively rather than doing the unlock in parallel as parallel reques=
ts
> come in.
>=20
> The code is remodelled to be more like the write-side code, though only
> using a single stream. This makes it more directly comparable and thus
> easier to duplicate fixes between the two sides.
>=20
> This has a number of advantages:
>=20
> (1) It's simpler. There doesn't need to be a complex donation mechanism
> to handle mismatches between the size and alignment of subrequests and
> folios. The collector unlocks folios as the subrequests covering each
> complete.
>=20
> (2) It should cause less scheduler overhead as there's a single work item
> in play unlocking pages in parallel when a read gets split up into a
> lot of subrequests instead of one per subrequest.
>=20
> Whilst the parallellism is nice in theory, in practice, the vast
> majority of loads are sequential reads of the whole file, so
> committing a bunch of threads to unlocking folios out of order doesn't
> help in those cases.
>=20
> (3) It should make it easier to implement content decryption. A folio
> cannot be decrypted until all the requests that contribute to it have
> completed - and, again, most loads are sequential and so, most of the
> time, we want to begin decryption sequentially (though it's great if
> the decryption can happen in parallel).
>=20
> There is a disadvantage in that we're losing the ability to decrypt and
> unlock things on an as-things-arrive basis which may affect some
> applications.
>=20
> Signed-off-by: David Howells dhowells@redhat.com
>=20
> cc: Jeff Layton jlayton@kernel.org
>=20
> cc: netfs@lists.linux.dev
> cc: linux-fsdevel@vger.kernel.org
> ---
> fs/9p/vfs_addr.c | 3 +-
> fs/afs/dir.c | 8 +-
> fs/ceph/addr.c | 9 +-
> fs/netfs/buffered_read.c | 160 ++++----
> fs/netfs/direct_read.c | 60 +--
> fs/netfs/internal.h | 21 +-
> fs/netfs/main.c | 2 +-
> fs/netfs/objects.c | 34 +-
> fs/netfs/read_collect.c | 716 ++++++++++++++++++++---------------
> fs/netfs/read_pgpriv2.c | 203 ++++------
> fs/netfs/read_retry.c | 207 +++++-----
> fs/netfs/read_single.c | 37 +-
> fs/netfs/write_collect.c | 4 +-
> fs/netfs/write_issue.c | 2 +-
> fs/netfs/write_retry.c | 14 +-
> fs/smb/client/cifssmb.c | 2 +
> fs/smb/client/smb2pdu.c | 5 +-
> include/linux/netfs.h | 16 +-
> include/trace/events/netfs.h | 79 +---
> 19 files changed, 819 insertions(+), 763 deletions(-)

Hello David.

After recent merge from upstream BPF CI started consistently failing
with a task hanging in v9fs_evict_inode. I bisected the failure to
commit e2d46f2ec332, pointing to this patch.

Reverting the patch seems to have helped:
https://github.com/kernel-patches/vmtest/actions/runs/12952856569

Could you please investigate?

Examples of failed jobs:
  * https://github.com/kernel-patches/bpf/actions/runs/12941732247
  * https://github.com/kernel-patches/bpf/actions/runs/12933849075

A log snippet:

    2025-01-24T02:15:03.9009694Z [  246.932163] INFO: task ip:1055 blocked =
for more than 122 seconds.
    2025-01-24T02:15:03.9013633Z [  246.932709]       Tainted: G           =
OE      6.13.0-g2bcb9cf535b8-dirty #149
    2025-01-24T02:15:03.9018791Z [  246.933249] "echo 0 > /proc/sys/kernel/=
hung_task_timeout_secs" disables this message.
    2025-01-24T02:15:03.9025896Z [  246.933802] task:ip              state:=
D stack:0     pid:1055  tgid:1055  ppid:1054   flags:0x00004002
    2025-01-24T02:15:03.9028228Z [  246.934564] Call Trace:
    2025-01-24T02:15:03.9029758Z [  246.934764]  <TASK>
    2025-01-24T02:15:03.9032572Z [  246.934937]  __schedule+0xa91/0xe80
    2025-01-24T02:15:03.9035126Z [  246.935224]  schedule+0x41/0xb0
    2025-01-24T02:15:03.9037992Z [  246.935459]  v9fs_evict_inode+0xfe/0x17=
0
    2025-01-24T02:15:03.9041469Z [  246.935748]  ? __pfx_var_wake_function+=
0x10/0x10
    2025-01-24T02:15:03.9043837Z [  246.936101]  evict+0x1ef/0x360
    2025-01-24T02:15:03.9046624Z [  246.936340]  __dentry_kill+0xb0/0x220
    2025-01-24T02:15:03.9048855Z [  246.936610]  ? dput+0x3a/0x1d0
    2025-01-24T02:15:03.9051128Z [  246.936838]  dput+0x114/0x1d0
    2025-01-24T02:15:03.9053548Z [  246.937069]  __fput+0x136/0x2b0
    2025-01-24T02:15:03.9056154Z [  246.937305]  task_work_run+0x89/0xc0
    2025-01-24T02:15:03.9058593Z [  246.937571]  do_exit+0x2c6/0x9c0
    2025-01-24T02:15:03.9061349Z [  246.937816]  do_group_exit+0xa4/0xb0
    2025-01-24T02:15:03.9064401Z [  246.938090]  __x64_sys_exit_group+0x17/=
0x20
    2025-01-24T02:15:03.9067235Z [  246.938390]  x64_sys_call+0x21a0/0x21a0
    2025-01-24T02:15:03.9069924Z [  246.938672]  do_syscall_64+0x79/0x120
    2025-01-24T02:15:03.9072746Z [  246.938941]  ? clear_bhb_loop+0x25/0x80
    2025-01-24T02:15:03.9075581Z [  246.939230]  ? clear_bhb_loop+0x25/0x80
    2025-01-24T02:15:03.9079275Z [  246.939510]  entry_SYSCALL_64_after_hwf=
rame+0x76/0x7e
    2025-01-24T02:15:03.9081976Z [  246.939875] RIP: 0033:0x7fb86f66f21d
    2025-01-24T02:15:03.9087533Z [  246.940153] RSP: 002b:00007ffdb3cf93f8 =
EFLAGS: 00000202 ORIG_RAX: 00000000000000e7
    2025-01-24T02:15:03.9092590Z [  246.940689] RAX: ffffffffffffffda RBX: =
00007fb86f785fa8 RCX: 00007fb86f66f21d
    2025-01-24T02:15:03.9097722Z [  246.941201] RDX: 00000000000000e7 RSI: =
ffffffffffffff80 RDI: 0000000000000000
    2025-01-24T02:15:03.9102762Z [  246.941705] RBP: 00007ffdb3cf9450 R08: =
00007ffdb3cf93a0 R09: 0000000000000000
    2025-01-24T02:15:03.9107940Z [  246.942215] R10: 00007ffdb3cf92ff R11: =
0000000000000202 R12: 0000000000000001
    2025-01-24T02:15:03.9113002Z [  246.942723] R13: 0000000000000000 R14: =
0000000000000000 R15: 00007fb86f785fc0
    2025-01-24T02:15:03.9114614Z [  246.943244]  </TASK>
    2025-01-24T02:15:03.9115895Z [  246.943415]
    2025-01-24T02:15:03.9119326Z [  246.943415] Showing all locks held in t=
he system:
    2025-01-24T02:15:03.9122278Z [  246.943865] 1 lock held by khungtaskd/3=
2:
    2025-01-24T02:15:03.9128640Z [  246.944162]  #0: ffffffffa9195d90 (rcu_=
read_lock){....}-{1:3}, at: debug_show_all_locks+0x2e/0x180
    2025-01-24T02:15:03.9131426Z [  246.944792] 2 locks held by kworker/0:2=
/86:
    2025-01-24T02:15:03.9132752Z [  246.945102]
    2025-01-24T02:15:03.9136561Z [  246.945222] =3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D

It's worth noting that that the hanging does not happen on *every*
test run, but often enough to fail the CI pipeline.

You may try reproducing with a container I used for bisection:

    docker pull ghcr.io/theihor/bpf:v9fs_evict_inode-repro
    docker run -d --privileged --device=3D/dev/kvm --cap-add ALL -v /path/t=
o/your/kernel/source:/ci/workspace ghcr.io/theihor/bpf:v9fs_evict_inode-rep=
ro
    docker exec -it <container_id_or_name> /bin/bash
    /ci/run.sh # in the container shell

Note that inside the container it's an "ubuntu" user, and you might
have to run `chown -R ubuntu:ubuntu /ci/workspace` first, or switch to
root.

> [...]

