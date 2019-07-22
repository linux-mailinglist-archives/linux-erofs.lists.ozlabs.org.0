Return-Path: <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>
X-Original-To: lists+linux-erofs@lfdr.de
Delivered-To: lists+linux-erofs@lfdr.de
Received: from lists.ozlabs.org (lists.ozlabs.org [203.11.71.2])
	by mail.lfdr.de (Postfix) with ESMTPS id D01806F7F1
	for <lists+linux-erofs@lfdr.de>; Mon, 22 Jul 2019 05:26:26 +0200 (CEST)
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2401:3900:2:1::3])
	by lists.ozlabs.org (Postfix) with ESMTP id 45sRpm2J55zDqHb
	for <lists+linux-erofs@lfdr.de>; Mon, 22 Jul 2019 13:26:24 +1000 (AEST)
X-Original-To: linux-erofs@lists.ozlabs.org
Delivered-To: linux-erofs@lists.ozlabs.org
Received: from ozlabs.org (bilbo.ozlabs.org [203.11.71.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 45sRpg2jxXzDqGM
 for <linux-erofs@lists.ozlabs.org>; Mon, 22 Jul 2019 13:26:19 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; dmarc=none (p=none dis=none)
 header.from=canb.auug.org.au
Authentication-Results: lists.ozlabs.org; dkim=pass (2048-bit key;
 secure) header.d=canb.auug.org.au header.i=@canb.auug.org.au
 header.b="CblAnu5M"; dkim-atps=neutral
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange ECDHE (P-256) server-signature RSA-PSS (4096 bits) server-digest
 SHA256) (No client certificate requested)
 by mail.ozlabs.org (Postfix) with ESMTPSA id 45sRpd1Ttlz9s4Y;
 Mon, 22 Jul 2019 13:26:16 +1000 (AEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=canb.auug.org.au;
 s=201702; t=1563765979;
 bh=izlUaNDnsxAjxbvmHOjmdpi6IZgjT2QLOfpi5tmaLcI=;
 h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
 b=CblAnu5MeM0hBxJbpABZdmp+zXc/2DaMCeUTHwqfUmYt6YMTw71TLvxnvEDfTrIly
 LfiCbZRVtkQVzDM3H2LNS9hkeMpdncFBdtVMxagT1V3yUtERezRQQ8PIqgW3DOVXUC
 znM198nB9t4HRnx/3T5RTRS/MH78L6OafwpHihAhQ83H/SheqBZ+3IKo8ShrAo0gtD
 F4CsE9zghsITOnKclF068MCgBOj9Hd1G5N8W9VEuIFnZOOFvoknIhI7lAiDaOOb2QN
 uLGzV68/XmpR7LRsToWKdH8y2/I2LWIe+FqpIRQJtO8n8cx7v5rLfkdaobVqevRGg4
 ZcD4NyG7f60fA==
Date: Mon, 22 Jul 2019 13:26:16 +1000
From: Stephen Rothwell <sfr@canb.auug.org.au>
To: Gao Xiang <gaoxiang25@huawei.com>
Subject: Re: [PATCH v3 01/24] erofs: add on-disk layout
Message-ID: <20190722132616.60edd141@canb.auug.org.au>
In-Reply-To: <20190722025043.166344-2-gaoxiang25@huawei.com>
References: <20190722025043.166344-1-gaoxiang25@huawei.com>
 <20190722025043.166344-2-gaoxiang25@huawei.com>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="Sig_/WUcwS=0enPg+/u1ca6ebcMn";
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
Cc: devel@driverdev.osuosl.org, Theodore Ts'o <tytso@mit.edu>,
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Miao Xie <miaoxie@huawei.com>,
 linux-erofs@lists.ozlabs.org, LKML <linux-kernel@vger.kernel.org>,
 Alexander Viro <viro@zeniv.linux.org.uk>, linux-fsdevel@vger.kernel.org,
 Andrew Morton <akpm@linux-foundation.org>,
 Linus Torvalds <torvalds@linux-foundation.org>
Errors-To: linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org
Sender: "Linux-erofs"
 <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>

--Sig_/WUcwS=0enPg+/u1ca6ebcMn
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable

Hi Gao,

On Mon, 22 Jul 2019 10:50:20 +0800 Gao Xiang <gaoxiang25@huawei.com> wrote:
>
> diff --git a/fs/erofs/erofs_fs.h b/fs/erofs/erofs_fs.h
> new file mode 100644
> index 000000000000..e418725abfd6
> --- /dev/null
> +++ b/fs/erofs/erofs_fs.h
> @@ -0,0 +1,316 @@
> +/* SPDX-License-Identifier: GPL-2.0 OR Apache-2.0 */

I think the preferred tag is now GPL-2.0-only (assuming that is what is
intended).

--=20
Cheers,
Stephen Rothwell

--Sig_/WUcwS=0enPg+/u1ca6ebcMn
Content-Type: application/pgp-signature
Content-Description: OpenPGP digital signature

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEENIC96giZ81tWdLgKAVBC80lX0GwFAl01LNgACgkQAVBC80lX
0Gx7dgf/U1zjLC4FYm3ODLxzwXPJq0Beid0tos0kzSrX0W8mbyk7heedRm4rJLg3
W24je4AYnli8U16tdWs2MFqcJc3Lf3vToB8AlX2x7HNxtA4gqSwZhC5IBszif8yT
CJaKj8CxSrrIgZqrlTDidx6N3ibdv0+dVaZi0MfyrbVsu8siwmH7II0faV9F+OBJ
CT5LN09VVMS4dSYtAwBORXvVlB06AmeV3k7/cw4rGppyLXY9hcyC5doFgWN3VBoC
MSn/YUDz1Sd2UkUx8hZm8jyAOvuCr9x8Hh5Wo3mSL/d3qPmMo2vDLx+etHqhgNGy
W+BwaAZMVfvs6GWfIQdWQiTm4EIU2w==
=KnjG
-----END PGP SIGNATURE-----

--Sig_/WUcwS=0enPg+/u1ca6ebcMn--
