Return-Path: <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>
X-Original-To: lists+linux-erofs@lfdr.de
Delivered-To: lists+linux-erofs@lfdr.de
Received: from lists.ozlabs.org (lists.ozlabs.org [203.11.71.2])
	by mail.lfdr.de (Postfix) with ESMTPS id 0C48E841F6
	for <lists+linux-erofs@lfdr.de>; Wed,  7 Aug 2019 03:51:51 +0200 (CEST)
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2401:3900:2:1::3])
	by lists.ozlabs.org (Postfix) with ESMTP id 463DyD4D1qzDqq0
	for <lists+linux-erofs@lfdr.de>; Wed,  7 Aug 2019 11:51:48 +1000 (AEST)
X-Original-To: linux-erofs@lists.ozlabs.org
Delivered-To: linux-erofs@lists.ozlabs.org
Received: from ozlabs.org (bilbo.ozlabs.org [IPv6:2401:3900:2:1::2])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 463Dy66LB1zDqpH
 for <linux-erofs@lists.ozlabs.org>; Wed,  7 Aug 2019 11:51:42 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; dmarc=none (p=none dis=none)
 header.from=canb.auug.org.au
Authentication-Results: lists.ozlabs.org; dkim=pass (2048-bit key;
 secure) header.d=canb.auug.org.au header.i=@canb.auug.org.au
 header.b="FAdBHtEi"; dkim-atps=neutral
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange ECDHE (P-256) server-signature RSA-PSS (4096 bits) server-digest
 SHA256) (No client certificate requested)
 by mail.ozlabs.org (Postfix) with ESMTPSA id 463Dy34Y5hz9sDB;
 Wed,  7 Aug 2019 11:51:39 +1000 (AEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=canb.auug.org.au;
 s=201702; t=1565142702;
 bh=VeIbhaZVUjebNvzkG6IBGnOOmwzkmjPxm/rSjwrHZoE=;
 h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
 b=FAdBHtEiCRkCClZrOxjx+YjFKEl1GkEhZBHY4+noeXINNg9c4fSSuIWUHyFsbvT7P
 2GSafOOi9fgWmJhVDT7GC/swkNz34D0kf4+MXvi1hWAmBVc9i8HVtDShBUNO95GKiq
 p6fiqGtam/JgnziFJwNtN2WluqW48ERgyuvj21sgfYdRToBmTwQGEDqOqEWDMv9MEe
 jZdqTkTHmps9kSeo4Jv5LgtnPhP5P6gmW/evpapYV4TdPBSmg3HNAWrnDSi+qmacM0
 WCmpKDS5oWRNX/lpSR41iT7/bJgFgApDs/IlHyiDws6XHmmk+eHtM7R9czjotrwzJp
 IG2ZxsH8954UQ==
Date: Wed, 7 Aug 2019 11:51:38 +1000
From: Stephen Rothwell <sfr@canb.auug.org.au>
To: Gao Xiang <hsiangkao@aol.com>
Subject: Re: [PATCH RFC] erofs: move erofs out of staging
Message-ID: <20190807115138.216fcb70@canb.auug.org.au>
In-Reply-To: <20190806170252.GB29093@hsiangkao-HP-ZHAN-66-Pro-G1>
References: <20190806094925.228906-1-gaoxiang25@huawei.com>
 <20190807013423.02fd6990@canb.auug.org.au>
 <20190806170252.GB29093@hsiangkao-HP-ZHAN-66-Pro-G1>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="Sig_/gC.BuFJhkfrfyrKHDgetbAs";
 protocol="application/pgp-signature"; micalg=pgp-sha256
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
Cc: devel@driverdev.osuosl.org, "Darrick J . Wong" <darrick.wong@oracle.com>,
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Jan Kara <jack@suse.cz>,
 Amir Goldstein <amir73il@gmail.com>, Dave Chinner <david@fromorbit.com>,
 David Sterba <dsterba@suse.cz>, LKML <linux-kernel@vger.kernel.org>,
 Christoph Hellwig <hch@infradead.org>,
 Linus Torvalds <torvalds@linux-foundation.org>, Miao Xie <miaoxie@huawei.com>,
 Alexander Viro <viro@zeniv.linux.org.uk>, Pavel Machek <pavel@denx.de>,
 linux-fsdevel@vger.kernel.org, Theodore Ts'o <tytso@mit.edu>,
 Jaegeuk Kim <jaegeuk@kernel.org>, linux-erofs@lists.ozlabs.org,
 Andrew Morton <akpm@linux-foundation.org>
Errors-To: linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org
Sender: "Linux-erofs"
 <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>

--Sig_/gC.BuFJhkfrfyrKHDgetbAs
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable

Hi Gao,

On Wed, 7 Aug 2019 01:02:58 +0800 Gao Xiang <hsiangkao@aol.com> wrote:
>
> On Wed, Aug 07, 2019 at 01:34:23AM +1000, Stephen Rothwell wrote:
> >=20
> > One small suggestion: just remove the file names from the comments at
> > the top of the files rather than change them to reflect that they have
> > moved.  We can usually tell the name of a file by its name :-) =20
>=20
> Thanks for your reply :)
>=20
> For this part, EROFS initially followed what ext4, f2fs, even fsverity do,
> https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/tree/f=
s/ext4/namei.c
> https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/tree/f=
s/f2fs/namei.c
> https://git.kernel.org/pub/scm/linux/kernel/git/ebiggers/linux.git/tree/f=
s/verity/verify.c?h=3Dfsverity
>=20
> I think I can remove these filenames as you suggested in the next version.
> I thought these are some common practice and there is no obvious right or
> wrong of this kind of stuffs.

Fair enough.

--=20
Cheers,
Stephen Rothwell

--Sig_/gC.BuFJhkfrfyrKHDgetbAs
Content-Type: application/pgp-signature
Content-Description: OpenPGP digital signature

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEENIC96giZ81tWdLgKAVBC80lX0GwFAl1KLqoACgkQAVBC80lX
0Gxjdwf+K7Z5+Ja83AA54PTZcXIHB9g+PdWvrL3aangZfmAt86GXDFF91vO1NlYp
QNmMTIr9j0lMhNdCseZUWB8ejrFfWSbrq654EtAo+1ydYSZXBmjGXQ5FQtWMhfpZ
e+4IRlkrOybVtYgU9nRfI2CIfCh8Z9Ol53Jh1M2bxDJw94XrZJug1N1S2j4+0Mta
jaV8MWN/niTb4SsWls1Uha3DwvvpVHqc9645UMwJ5yFqzvsk7tJ/ViQWHQNvjGFH
XdUqEMv40XEYGt3HrC8wzMPfubVVpdke556Ou5aQuTgYbsNOU5bTblzNvpIG9jpX
xRDrkTjcnjGG6jRyqHN4XMzVrdPtwQ==
=iqs3
-----END PGP SIGNATURE-----

--Sig_/gC.BuFJhkfrfyrKHDgetbAs--
