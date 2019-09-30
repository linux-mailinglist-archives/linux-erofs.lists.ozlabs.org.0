Return-Path: <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>
X-Original-To: lists+linux-erofs@lfdr.de
Delivered-To: lists+linux-erofs@lfdr.de
Received: from lists.ozlabs.org (lists.ozlabs.org [203.11.71.2])
	by mail.lfdr.de (Postfix) with ESMTPS id 4F5E8C286B
	for <lists+linux-erofs@lfdr.de>; Mon, 30 Sep 2019 23:16:28 +0200 (CEST)
Received: from bilbo.ozlabs.org (lists.ozlabs.org [IPv6:2401:3900:2:1::3])
	by lists.ozlabs.org (Postfix) with ESMTP id 46hwF567pzzDqPW
	for <lists+linux-erofs@lfdr.de>; Tue,  1 Oct 2019 07:16:25 +1000 (AEST)
X-Original-To: linux-erofs@lists.ozlabs.org
Delivered-To: linux-erofs@lists.ozlabs.org
Received: from ozlabs.org (bilbo.ozlabs.org [203.11.71.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 46hwDt36jQzDqPK
 for <linux-erofs@lists.ozlabs.org>; Tue,  1 Oct 2019 07:16:14 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; dmarc=none (p=none dis=none)
 header.from=canb.auug.org.au
Authentication-Results: lists.ozlabs.org; dkim=pass (2048-bit key;
 secure) header.d=canb.auug.org.au header.i=@canb.auug.org.au
 header.b="XdI8MqdU"; dkim-atps=neutral
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange ECDHE (P-256) server-signature RSA-PSS (4096 bits) server-digest
 SHA256) (No client certificate requested)
 by mail.ozlabs.org (Postfix) with ESMTPSA id 46hwDr1Bk1z9sNF;
 Tue,  1 Oct 2019 07:16:12 +1000 (AEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=canb.auug.org.au;
 s=201702; t=1569878172;
 bh=ABi3XTYRlRRy2dg9HbrG9Jm3gXd9hiGGIVOBtE75DO8=;
 h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
 b=XdI8MqdUpZu5VMnuImREiFb1niTwI+X8ObObiWReuj6IwfmblmO+cVyxUl8GQ2V4S
 CziSLB0CYj8sej+0FGfOUpYiqHHbAfSOCSpumvzRPJz5al1f8GAFRI00RhPdR1pGPo
 FRav3IDYfjdN4G0zcz9JlKSDVvGtr34iOY3EoyJbNn/MCRBRHR1ZflPDKWmeAWbrAG
 YaPuSIKVKTiu8gZrS5eOptxEDbDNu7jj76evUJvqegqttMi2esT0xh8zeGDye3NdfU
 rV7fJxwo7Ja6tCzAn/LY7ePedtQ2i70u4pl+ir2XsIwbmPQnEGEgmvh4l6Dm63VX8f
 gwToUk3fmfPyw==
Date: Tue, 1 Oct 2019 07:16:02 +1000
From: Stephen Rothwell <sfr@canb.auug.org.au>
To: Gao Xiang <hsiangkao@aol.com>
Subject: Re: erofs -next tree inclusion request
Message-ID: <20191001071602.5723e33d@canb.auug.org.au>
In-Reply-To: <20190930132925.GA10677@hsiangkao-HP-ZHAN-66-Pro-G1>
References: <20190919120110.GA48697@architecture4>
 <20190919121739.GG3642@sirena.co.uk>
 <20190919122328.GA82662@architecture4>
 <20190919143722.GA5363@hsiangkao-HP-ZHAN-66-Pro-G1>
 <20190930231439.37295a14@canb.auug.org.au>
 <20190930132925.GA10677@hsiangkao-HP-ZHAN-66-Pro-G1>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="Sig_/8u8oJwVrtwQVPX8=Bt=VocG";
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
Cc: linux-erofs@lists.ozlabs.org, Mark Brown <broonie@kernel.org>,
 Miao Xie <miaoxie@huawei.com>, LKML <linux-kernel@vger.kernel.org>,
 linux-next@vger.kernel.org, Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
 Linus Torvalds <torvalds@linux-foundation.org>
Errors-To: linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org
Sender: "Linux-erofs"
 <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>

--Sig_/8u8oJwVrtwQVPX8=Bt=VocG
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable

Hi Gao,

On Mon, 30 Sep 2019 21:32:22 +0800 Gao Xiang <hsiangkao@aol.com> wrote:
>=20
> I think xiang@kernel.org is preferred since it can always redirect
> to my workable email address.

OK, done.

--=20
Cheers,
Stephen Rothwell

--Sig_/8u8oJwVrtwQVPX8=Bt=VocG
Content-Type: application/pgp-signature
Content-Description: OpenPGP digital signature

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEENIC96giZ81tWdLgKAVBC80lX0GwFAl2ScJIACgkQAVBC80lX
0GzPQAf+MFU2QYjTEQ5TE9srpZ+8ctwTC7tAz42SidHNa3ODU5iFRT0fWQC7liis
qL9ibdkp3aH0wEw60i4ZgyC5WLNhACh37chxD7y1OH2Tm6RQvHSjda00U5TRqziX
T/9jAKratRrjqtICZg8JbUVzz66mq8u2UTxe4ic+Ys4G0FwVbkY41IuakBtzZYwa
9GO9+HUAH0gGi3mU9B60KnCqENWG8zl6vOWaewxUBbDlrXFaGhdANfC0NKnwJva6
ZwsKj8xPykSpMruDNqIk+8vffy3Q3oKuJzeDJA7wmfPzikq5B7TQExVwP8XpIRmG
jm+Kj/RKfXSif9+TePfW1hw/1jw1vA==
=mogZ
-----END PGP SIGNATURE-----

--Sig_/8u8oJwVrtwQVPX8=Bt=VocG--
