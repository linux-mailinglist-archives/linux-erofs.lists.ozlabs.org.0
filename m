Return-Path: <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>
X-Original-To: lists+linux-erofs@lfdr.de
Delivered-To: lists+linux-erofs@lfdr.de
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	by mail.lfdr.de (Postfix) with ESMTPS id 0E3A77A81E5
	for <lists+linux-erofs@lfdr.de>; Wed, 20 Sep 2023 14:49:52 +0200 (CEST)
Authentication-Results: lists.ozlabs.org;
	dkim=fail reason="signature verification failed" (2048-bit key; unprotected) header.d=clisp.org header.i=@clisp.org header.a=rsa-sha256 header.s=strato-dkim-0002 header.b=O12Jm8Bs;
	dkim=fail reason="signature verification failed" header.d=clisp.org header.i=@clisp.org header.a=ed25519-sha256 header.s=strato-dkim-0003 header.b=muQUVTl0;
	dkim-atps=neutral
Received: from boromir.ozlabs.org (localhost [IPv6:::1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4RrJJl2bkjz3c27
	for <lists+linux-erofs@lfdr.de>; Wed, 20 Sep 2023 22:49:43 +1000 (AEST)
X-Original-To: linux-erofs@lists.ozlabs.org
Delivered-To: linux-erofs@lists.ozlabs.org
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=clisp.org header.i=@clisp.org header.a=rsa-sha256 header.s=strato-dkim-0002 header.b=O12Jm8Bs;
	dkim=pass header.d=clisp.org header.i=@clisp.org header.a=ed25519-sha256 header.s=strato-dkim-0003 header.b=muQUVTl0;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.helo=mo4-p03-ob.smtp.rzone.de (client-ip=81.169.146.174; helo=mo4-p03-ob.smtp.rzone.de; envelope-from=bruno@clisp.org; receiver=lists.ozlabs.org)
Received: from mo4-p03-ob.smtp.rzone.de (mo4-p03-ob.smtp.rzone.de [81.169.146.174])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4RrJJc3PkMz3byH
	for <linux-erofs@lists.ozlabs.org>; Wed, 20 Sep 2023 22:49:34 +1000 (AEST)
ARC-Seal: i=1; a=rsa-sha256; t=1695214142; cv=none;
    d=strato.com; s=strato-dkim-0002;
    b=KK4wxmcg11bDhbWnUFC83uZ811y/mpb0I1TmJbK4Xk4jnQh4eSC/Y+vtwGlPKLxw9f
    ZQJV08gwelI0hs7Nko3i2MdGYFFoM9tT1tP4c6kr2+FD/bMZ5Us4S1IamSJP7z2u2Tni
    VGrvJR9cFI9cNWYNVXlV4wEMgQPoFUsGO26ode4TY1Iyrfpxra0unC1MrVpv8ibEB9+j
    zFGTjBklu569rK9lelqLmPbUbCvydW08SWCBN0VIPOuJD6DxdrrJwE7b+oQvIZvbb2gB
    gvGEBEb/Y1uiuRnorDANT4ornmti5i01W1zbKwyhST0ousOicmaYHuksmnMxb6uUQJSc
    GcjQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; t=1695214142;
    s=strato-dkim-0002; d=strato.com;
    h=References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:Cc:Date:
    From:Subject:Sender;
    bh=zlon1NnZN5jZFLvNv3xx2YjDrrfzc/zzmMPbj7gP0jk=;
    b=d2z+l5GTzEzeupyyKoEO/+801nRO2I8xrBbgDMbJ0FszbQsZ7OWKerKKY869DbFMSr
    DA55dD3c8Iy22q32azarKo9LmVUAE/wwLMEkbofjeQtY2NHv5KyEQ5lCwDIcZj6/Dssl
    rR06w99QqJPCaVp01TF7Yn083P4ftn6AoEorFHVtk+giqDT7I9UeWxfbrgljCBX0K9NB
    27KHTBXszEyKAusPHW96Eg39CS+TryRIAsU+dqtvvDkSuODIRZZtwIQ1GsA7NETvfjHn
    VcnTxIDslnv+v3qX0yKYPfHAa3QFZGq2mRblvL54+mqYfwy9M1pc+w1udoTKxkxma9Q+
    sJBw==
ARC-Authentication-Results: i=1; strato.com;
    arc=none;
    dkim=none
X-RZG-CLASS-ID: mo03
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; t=1695214142;
    s=strato-dkim-0002; d=clisp.org;
    h=References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:Cc:Date:
    From:Subject:Sender;
    bh=zlon1NnZN5jZFLvNv3xx2YjDrrfzc/zzmMPbj7gP0jk=;
    b=O12Jm8BsjyLsoq3xcyYi16mtuh91ZCa5znbPcUnLqZstPIUAkcvAVtfQJ5y2yLTnkG
    Bbd1Vjx8o91hiawH0LIwFIUvSMwyAjpO+JZjkt3g+Qpq83IYi33H61+PZsHsDjUPV+gY
    5VkfMVdagu9bFaEq9tpHPC8aYSffOTVdZHc9t/Mr9BI62tRv6l/vCIVCxLdoBqlXpQ01
    P1/x918UXZr3OP5PUsCgWe+NPzvAlgR7TOhOMxOk5E0RnLfQmpNp6vkh2VWa4G4mfKF1
    8rEFhafAogS/DwPxgDZRaiLuEskuztanzAxVYeOjpAoKDywwLsnNuTQKZWxS/0d3sF8x
    RUJQ==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; t=1695214142;
    s=strato-dkim-0003; d=clisp.org;
    h=References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:Cc:Date:
    From:Subject:Sender;
    bh=zlon1NnZN5jZFLvNv3xx2YjDrrfzc/zzmMPbj7gP0jk=;
    b=muQUVTl0scIb2+N29B0TOhmsUwAw8Fpx6zlqzw9owQDn3QGFXl2h7ouqcgMeKa+h7z
    NeiR9RifaRHNd7IhFiCQ==
X-RZG-AUTH: ":Ln4Re0+Ic/6oZXR1YgKryK8brlshOcZlIWs+iCP5vnk6shH0WWb0LN8XZoH94zq68+3cfpPHj6eWWaUQFt689wZebbvySt9BLA=="
Received: from nimes.localnet
    by smtp.strato.de (RZmta 49.8.2 AUTH)
    with ESMTPSA id m03934z8KCmwmFD
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256 bits))
	(Client did not present a certificate);
    Wed, 20 Sep 2023 14:48:58 +0200 (CEST)
From: Bruno Haible <bruno@clisp.org>
To: Jan Kara <jack@suse.cz>, Christian Brauner <brauner@kernel.org>, Jeff Layton <jlayton@kernel.org>
Subject: Re: [PATCH v7 12/13] ext4: switch to multigrain timestamps
Date: Wed, 20 Sep 2023 14:48:57 +0200
Message-ID: <5317021.Rkz2Fa4CmG@nimes>
In-Reply-To: <317d84b1b909b6c6519a2406fcb302ce22dafa41.camel@kernel.org>
References: <20230807-mgctime-v7-0-d1dec143a704@kernel.org> <20230920101731.ym6pahcvkl57guto@quack3> <317d84b1b909b6c6519a2406fcb302ce22dafa41.camel@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset="UTF-8"
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
Cc: Latchesar Ionkov <lucho@ionkov.net>, Martin Brandenburg <martin@omnibond.com>, Konstantin Komarov <almaz.alexandrovich@paragon-software.com>, linux-xfs@vger.kernel.org, "Darrick J. Wong" <djwong@kernel.org>, Dominique Martinet <asmadeus@codewreck.org>, Christian Schoenebeck <linux_oss@crudebyte.com>, linux-unionfs@vger.kernel.org, David Howells <dhowells@redhat.com>, Chris Mason <clm@fb.com>, Andreas Dilger <adilger.kernel@dilger.ca>, Hans de Goede <hdegoede@redhat.com>, Marc Dionne <marc.dionne@auristor.com>, codalist@coda.cs.cmu.edu, linux-afs@lists.infradead.org, linux-mtd@lists.infradead.org, Mike Marshall <hubcap@omnibond.com>, Paulo Alcantara <pc@manguebit.com>, Amir Goldstein <l@gmail.com>, Eric Van Hensbergen <ericvh@kernel.org>, bug-gnulib@gnu.org, Andreas Gruenbacher <agruenba@redhat.com>, Miklos Szeredi <miklos@szeredi.hu>, Richard Weinberger <richard@nod.at>, Mark Fasheh <mark@fasheh.com>, Hugh Dickins <hughd@google.com>, Benjamin Coddington <bcodding@redhat.com>, Tyl
 er Hicks <code@tyhicks.com>, cluster-devel@redhat.com, coda@cs.cmu.edu, linux-mm@kvack.org, Iurii Zaikin <yzaikin@google.com>, Namjae Jeon <linkinjeon@kernel.org>, Trond Myklebust <trond.myklebust@hammerspace.com>, Xi Ruoyao <xry111@linuxfromscratch.org>, Shyam Prasad N <sprasad@microsoft.com>, ecryptfs@vger.kernel.org, Kees Cook <keescook@chromium.org>, ocfs2-devel@lists.linux.dev, linux-cifs@vger.kernel.org, Josef Bacik <josef@toxicpanda.com>, Tom Talpey <tom@talpey.com>, Tejun Heo <tj@kernel.org>, Yue Hu <huyue2@coolpad.com>, Alexander Viro <viro@zeniv.linux.org.uk>, Ronnie Sahlberg <ronniesahlberg@gmail.com>, David Sterba <dsterba@suse.com>, Jaegeuk Kim <jaegeuk@kernel.org>, ceph-devel@vger.kernel.org, Xiubo Li <xiubli@redhat.com>, Ilya Dryomov <idryomov@gmail.com>, OGAWA Hirofumi <hirofumi@mail.parknet.co.jp>, Jan Harkes <jaharkes@cs.cmu.edu>, linux-nfs@vger.kernel.org, linux-ext4@vger.kernel.org, Theodore Ts'o <tytso@mit.edu>, Joseph Qi <joseph.qi@linux.alibaba.com>, Greg Kroa
 h-Hartman <gregkh@linuxfoundation.org>, v9fs@lists.linux.dev, ntfs3@lists.linux.dev, samba-technical@lists.samba.org, linux-kernel@vger.kernel.org, linux-f2fs-devel@lists.sourceforge.net, Steve French <sfrench@samba.org>, Sergey Senozhatsky <senozhatsky@chromium.org>, Luis Chamberlain <mcgrof@kernel.org>, devel@lists.orangefs.org, Anna Schumaker <anna@kernel.org>, Jan Kara <jack@suse.com>, Bo b Peterson <rpeterso@redhat.com>, linux-fsdevel@vger.kernel.org, Andrew Morton <akpm@linux-foundation.org>, Sungjong Seo <sj1557.seo@samsung.com>, linux-erofs@lists.ozlabs.org, linux-btrfs@vger.kernel.org, Joel Becker <jlbec@evilplan.org>
Errors-To: linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org
Sender: "Linux-erofs" <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>

Jeff Layton wrote:
> > Surely this is a safe choice as it moves the responsibility to the sysa=
dmin
> > and the cases where finegrained timestamps are required. But I kind of
> > wonder how is the sysadmin going to decide whether mgtime is safe for h=
is
> > system or not? Because the possible breakage needn't be obvious at the
> > first sight...
>=20
> That's the main reason I really didn't want to go with a mount option.
> Documenting that may be difficult.

You could document it like this:

  The mgtime option enables more precise modification times (mtime)
  on some files, together with an optimization that limits the amount
  of metadata changes.
  Note that this option may, in some cases, after writing to file F1
  and then writing to file F2, report a lower mtime for F2 than for F2.
  Enabling this option may be useful on file systems shared via NFS.
  The safe choice is to disable this option.

=46or me as a user, there's no need to go into more details than that.

It's important to have this mount option, for people who want maximum
reliability. Personally, I always enable the 'strictatime' option on
all ext4 mounts, since 'relatime' optimizes too much for my use-cases.
If I fear wrong results of "make" runs, I will definitely opt for the
safe choice regarding mgtime as well =E2=80=94 since I don't want to spend
hours debugging binaries that were built incorrectly from correct
source code.

Bruno



