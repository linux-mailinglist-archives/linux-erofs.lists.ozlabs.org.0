Return-Path: <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>
X-Original-To: lists+linux-erofs@lfdr.de
Delivered-To: lists+linux-erofs@lfdr.de
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2404:9400:2:0:216:3eff:fee1:b9f1])
	by mail.lfdr.de (Postfix) with ESMTPS id BBCA77A5AA4
	for <lists+linux-erofs@lfdr.de>; Tue, 19 Sep 2023 09:14:27 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=lists.ozlabs.org;
	s=201707; t=1695107665;
	bh=T7nfawYenRjk+4ZCMjkKSaoE2W7ZD+Q1umpTZ/cT6R4=;
	h=Subject:To:Date:In-Reply-To:References:List-Id:List-Unsubscribe:
	 List-Archive:List-Post:List-Help:List-Subscribe:From:Reply-To:Cc:
	 From;
	b=IFZgdZBsyOUgDm059hCjz1MLy0JNjPtK2dekf0CjwAfctZJhXx5mnFoTwFUV+E8Ra
	 x4ExndnPUCeoo0ajgNhfUGvsIHa+yBb3faqY+X5xJJoGuvNfjHRx3ZAWxvorchcip2
	 N656AdcfVcDnGJ3dk7ZDOs/WVfwSSPZmyGqwqEn+9L0G9rOH3DIG18MqZQuKPrGRgJ
	 q0xrnIteWoDh54uGbGUv/gHce+9ipgDHrRSAL1C5zLsnul/GXYaL+Aly4n4SRRijQC
	 6cJJptMDBtM9KH9pRFYEeOEiaeAz367aXB3F4PlFnLs37MdVQPPVncKKg3i05NVIda
	 yUKIYofcTisvg==
Received: from boromir.ozlabs.org (localhost [IPv6:::1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4RqXwK4BxTz30fd
	for <lists+linux-erofs@lfdr.de>; Tue, 19 Sep 2023 17:14:25 +1000 (AEST)
X-Original-To: linux-erofs@lists.ozlabs.org
Delivered-To: linux-erofs@lists.ozlabs.org
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=linuxfromscratch.org header.i=@linuxfromscratch.org header.a=rsa-sha256 header.s=cert4 header.b=aqoK/Ilc;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=linuxfromscratch.org (client-ip=208.118.68.85; helo=rivendell.linuxfromscratch.org; envelope-from=xry111@linuxfromscratch.org; receiver=lists.ozlabs.org)
X-Greylist: delayed 498 seconds by postgrey-1.37 at boromir; Tue, 19 Sep 2023 17:14:20 AEST
Received: from rivendell.linuxfromscratch.org (rivendell.linuxfromscratch.org [208.118.68.85])
	by lists.ozlabs.org (Postfix) with ESMTP id 4RqXwD0XFkz2xpp
	for <linux-erofs@lists.ozlabs.org>; Tue, 19 Sep 2023 17:14:20 +1000 (AEST)
Received: from [192.168.3.211] (unknown [36.44.140.33])
	by rivendell.linuxfromscratch.org (Postfix) with ESMTPSA id 26A431C1DD6;
	Tue, 19 Sep 2023 07:05:30 +0000 (GMT)
X-Virus-Status: Clean
X-Virus-Scanned: clamav-milter 1.0.0 at rivendell.linuxfromscratch.org
Message-ID: <bf0524debb976627693e12ad23690094e4514303.camel@linuxfromscratch.org>
Subject: Re: [PATCH v7 12/13] ext4: switch to multigrain timestamps
To: Jeff Layton <jlayton@kernel.org>, Alexander Viro
 <viro@zeniv.linux.org.uk>,  Christian Brauner <brauner@kernel.org>, Eric
 Van Hensbergen <ericvh@kernel.org>, Latchesar Ionkov <lucho@ionkov.net>,
 Dominique Martinet <asmadeus@codewreck.org>, Christian Schoenebeck
 <linux_oss@crudebyte.com>, David Howells <dhowells@redhat.com>, Marc Dionne
 <marc.dionne@auristor.com>, Chris Mason <clm@fb.com>, Josef Bacik
 <josef@toxicpanda.com>, David Sterba <dsterba@suse.com>, Xiubo Li
 <xiubli@redhat.com>, Ilya Dryomov <idryomov@gmail.com>, Jan Harkes
 <jaharkes@cs.cmu.edu>, coda@cs.cmu.edu, Tyler Hicks <code@tyhicks.com>, Gao
 Xiang <xiang@kernel.org>, Chao Yu <chao@kernel.org>, Yue Hu
 <huyue2@coolpad.com>,  Jeffle Xu <jefflexu@linux.alibaba.com>, Namjae Jeon
 <linkinjeon@kernel.org>, Sungjong Seo <sj1557.seo@samsung.com>, Jan Kara
 <jack@suse.com>, Theodore Ts'o <tytso@mit.edu>,  Andreas Dilger
 <adilger.kernel@dilger.ca>, Jaegeuk Kim <jaegeuk@kernel.org>, OGAWA
 Hirofumi <hirofumi@mail.parknet.co.jp>, Miklos Szeredi <miklos@szeredi.hu>,
 Bob Peterson <rpeterso@redhat.com>, Andreas Gruenbacher
 <agruenba@redhat.com>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
 Tejun Heo <tj@kernel.org>, Trond Myklebust
 <trond.myklebust@hammerspace.com>, Anna Schumaker <anna@kernel.org>, 
 Konstantin Komarov <almaz.alexandrovich@paragon-software.com>, Mark Fasheh
 <mark@fasheh.com>, Joel Becker <jlbec@evilplan.org>, Joseph Qi
 <joseph.qi@linux.alibaba.com>, Mike Marshall <hubcap@omnibond.com>, Martin
 Brandenburg <martin@omnibond.com>, Luis Chamberlain <mcgrof@kernel.org>,
 Kees Cook <keescook@chromium.org>, Iurii Zaikin <yzaikin@google.com>, 
 Steve French <sfrench@samba.org>, Paulo Alcantara <pc@manguebit.com>,
 Ronnie Sahlberg <ronniesahlberg@gmail.com>, Shyam Prasad N
 <sprasad@microsoft.com>, Tom Talpey <tom@talpey.com>, Sergey Senozhatsky
 <senozhatsky@chromium.org>, Richard Weinberger <richard@nod.at>, Hans de
 Goede <hdegoede@redhat.com>, Hugh Dickins <hughd@google.com>,  Andrew
 Morton <akpm@linux-foundation.org>, Amir Goldstein <amir73il@gmail.com>,
 "Darrick J. Wong" <djwong@kernel.org>, Benjamin Coddington
 <bcodding@redhat.com>
Date: Tue, 19 Sep 2023 15:05:24 +0800
In-Reply-To: <20230807-mgctime-v7-12-d1dec143a704@kernel.org>
References: <20230807-mgctime-v7-0-d1dec143a704@kernel.org>
	 <20230807-mgctime-v7-12-d1dec143a704@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.50.0 
MIME-Version: 1.0
X-Spam-Status: No, score=-3.0 required=5.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
	RCVD_IN_ZEN_BLOCKED_OPENDNS,RDNS_NONE,SPF_FAIL,URIBL_BLOCKED,
	URIBL_DBL_BLOCKED_OPENDNS,URIBL_ZEN_BLOCKED_OPENDNS autolearn=ham
	autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	rivendell.linuxfromscratch.org
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
From: Xi Ruoyao via Linux-erofs <linux-erofs@lists.ozlabs.org>
Reply-To: Xi Ruoyao <xry111@linuxfromscratch.org>
Cc: Jan Kara <jack@suse.cz>, linux-kernel@vger.kernel.org, linux-mm@kvack.org, linux-mtd@lists.infradead.org, linux-afs@lists.infradead.org, linux-cifs@vger.kernel.org, bug-gnulib@gnu.org, codalist@coda.cs.cmu.edu, cluster-devel@redhat.com, linux-ext4@vger.kernel.org, devel@lists.orangefs.org, ecryptfs@vger.kernel.org, ocfs2-devel@lists.linux.dev, ceph-devel@vger.kernel.org, linux-nfs@vger.kernel.org, v9fs@lists.linux.dev, samba-technical@lists.samba.org, linux-unionfs@vger.kernel.org, linux-f2fs-devel@lists.sourceforge.net, linux-xfs@vger.kernel.org, linux-fsdevel@vger.kernel.org, ntfs3@lists.linux.dev, linux-erofs@lists.ozlabs.org, linux-btrfs@vger.kernel.org
Errors-To: linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org
Sender: "Linux-erofs" <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>

On Mon, 2023-08-07 at 15:38 -0400, Jeff Layton wrote:
> Enable multigrain timestamps, which should ensure that there is an
> apparent change to the timestamp whenever it has been written after
> being actively observed via getattr.
>=20
> For ext4, we only need to enable the FS_MGTIME flag.

Hi Jeff,

This patch causes a gnulib test failure:

$ ~/sources/lfs/grep-3.11/gnulib-tests/test-stat-time
test-stat-time.c:141: assertion 'statinfo[0].st_mtime < statinfo[2].st_mtim=
e || (statinfo[0].st_mtime =3D=3D statinfo[2].st_mtime && (get_stat_mtime_n=
s (&statinfo[0]) < get_stat_mtime_ns (&statinfo[2])))' failed
Aborted (core dumped)

The source code of the test:
https://git.savannah.gnu.org/cgit/gnulib.git/tree/tests/test-stat-time.c

Is this an expected change?

> Acked-by: Theodore Ts'o <tytso@mit.edu>
> Reviewed-by: Jan Kara <jack@suse.cz>
> Signed-off-by: Jeff Layton <jlayton@kernel.org>
> ---
> =C2=A0fs/ext4/super.c | 2 +-
> =C2=A01 file changed, 1 insertion(+), 1 deletion(-)
>=20
> diff --git a/fs/ext4/super.c b/fs/ext4/super.c
> index b54c70e1a74e..cb1ff47af156 100644
> --- a/fs/ext4/super.c
> +++ b/fs/ext4/super.c
> @@ -7279,7 +7279,7 @@ static struct file_system_type ext4_fs_type =3D {
> =C2=A0	.init_fs_context	=3D ext4_init_fs_context,
> =C2=A0	.parameters		=3D ext4_param_specs,
> =C2=A0	.kill_sb		=3D kill_block_super,
> -	.fs_flags		=3D FS_REQUIRES_DEV | FS_ALLOW_IDMAP,
> +	.fs_flags		=3D FS_REQUIRES_DEV | FS_ALLOW_IDMAP |
> FS_MGTIME,
> =C2=A0};
> =C2=A0MODULE_ALIAS_FS("ext4");
> =C2=A0
>=20

