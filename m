Return-Path: <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>
X-Original-To: lists+linux-erofs@lfdr.de
Delivered-To: lists+linux-erofs@lfdr.de
Received: from lists.ozlabs.org (lists.ozlabs.org [203.11.71.2])
	by mail.lfdr.de (Postfix) with ESMTPS id 80BDF8355B
	for <lists+linux-erofs@lfdr.de>; Tue,  6 Aug 2019 17:34:46 +0200 (CEST)
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2401:3900:2:1::3])
	by lists.ozlabs.org (Postfix) with ESMTP id 462zGB6h98zDr0l
	for <lists+linux-erofs@lfdr.de>; Wed,  7 Aug 2019 01:34:42 +1000 (AEST)
X-Original-To: linux-erofs@lists.ozlabs.org
Delivered-To: linux-erofs@lists.ozlabs.org
Received: from ozlabs.org (bilbo.ozlabs.org [203.11.71.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 462zG23JmYzDqcw
 for <linux-erofs@lists.ozlabs.org>; Wed,  7 Aug 2019 01:34:34 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; dmarc=none (p=none dis=none)
 header.from=canb.auug.org.au
Authentication-Results: lists.ozlabs.org; dkim=pass (2048-bit key;
 secure) header.d=canb.auug.org.au header.i=@canb.auug.org.au
 header.b="dcShrCbs"; dkim-atps=neutral
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange ECDHE (P-256) server-signature RSA-PSS (4096 bits) server-digest
 SHA256) (No client certificate requested)
 by mail.ozlabs.org (Postfix) with ESMTPSA id 462zFv3F9sz9sMr;
 Wed,  7 Aug 2019 01:34:27 +1000 (AEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=canb.auug.org.au;
 s=201702; t=1565105672;
 bh=5FHAJ2a0H+dgGw8qV5krRpvfMTW4QMVUNBiIFTz7ukc=;
 h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
 b=dcShrCbsau/hwzLIEVX+xCQkjw8ytUmuBphP7Wzk0Os+PeYJL4E9AZojKIxsW/XCC
 xTyuNmwgEnwSEW6/Kz8amhaNxd/QkXfyj6TN7B3JHn6lyvGiqz9io4rs24B6/81qqU
 aHhTQCVVCoPKVEFdalsWvjQTI3tUyZFaUFc133mkcqknYyDVNSEChFStksBky28u+/
 GQO177sJv9EuIy1iyMEkE5ZTlNxx7pwHSxx0QCJI51C+dfkT0hpyUbfm+uzI+0mdxe
 ZEqmwK2hiOD8JXrhyc//NCp7AK7xY6zJ2JDZpiGvVhYTi+uG79dj7xnbSdH/Jt6dGk
 vLa4gCEEgqDLA==
Date: Wed, 7 Aug 2019 01:34:23 +1000
From: Stephen Rothwell <sfr@canb.auug.org.au>
To: Gao Xiang <gaoxiang25@huawei.com>
Subject: Re: [PATCH RFC] erofs: move erofs out of staging
Message-ID: <20190807013423.02fd6990@canb.auug.org.au>
In-Reply-To: <20190806094925.228906-1-gaoxiang25@huawei.com>
References: <20190806094925.228906-1-gaoxiang25@huawei.com>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="Sig_/3zuq9Mbh_pVR5QZxswgd1wJ";
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
Cc: devel@driverdev.osuosl.org, linux-erofs@lists.ozlabs.org,
 Theodore Ts'o <tytso@mit.edu>, "Darrick J . Wong" <darrick.wong@oracle.com>,
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Jan Kara <jack@suse.cz>,
 Amir Goldstein <amir73il@gmail.com>, Dave Chinner <david@fromorbit.com>,
 David Sterba <dsterba@suse.cz>, LKML <linux-kernel@vger.kernel.org>,
 Christoph Hellwig <hch@infradead.org>, Miao Xie <miaoxie@huawei.com>,
 Alexander Viro <viro@zeniv.linux.org.uk>, Pavel Machek <pavel@denx.de>,
 linux-fsdevel@vger.kernel.org, Jaegeuk Kim <jaegeuk@kernel.org>,
 Andrew Morton <akpm@linux-foundation.org>,
 Linus Torvalds <torvalds@linux-foundation.org>
Errors-To: linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org
Sender: "Linux-erofs"
 <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>

--Sig_/3zuq9Mbh_pVR5QZxswgd1wJ
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable

Hi Gao,

One small suggestion: just remove the file names from the comments at
the top of the files rather than change them to reflect that they have
moved.  We can usually tell the name of a file by its name :-)

--=20
Cheers,
Stephen Rothwell

--Sig_/3zuq9Mbh_pVR5QZxswgd1wJ
Content-Type: application/pgp-signature
Content-Description: OpenPGP digital signature

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEENIC96giZ81tWdLgKAVBC80lX0GwFAl1Jnf8ACgkQAVBC80lX
0GyktAf/awWVta3LRhqpez+RTEQC6IzKAlgR8ULIAJpHB3OZFNlv6Lxvbg3l/Jdq
XZAoR3RqQTr49hpHePfnENWdxIFa7DUCyOjO5MeWyP7VpVBEk48YSFnBUtPIzh7m
+UdrAt+zOdjzdRd6/v2DGhd8dXLZ+rsupL9XA75ak2iVEGjEnlTorjwKDaYy2VR+
cV0mFcFNBEHs2Ok2wTfYYzUx7id7/tcVfjWuzvyvd1d0Y53FLgWLvIVCsJNM0HmH
LlpVkiVpMFDCC3SMSiffhkOkNigEV1vY3wxlS2qniRz+qXbAMqPv8CRbtdO92bkM
LBThN5N6CBu+SqQgGSvGv08yzx+eqg==
=sZOX
-----END PGP SIGNATURE-----

--Sig_/3zuq9Mbh_pVR5QZxswgd1wJ--
