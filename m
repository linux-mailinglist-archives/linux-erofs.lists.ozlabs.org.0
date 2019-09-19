Return-Path: <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>
X-Original-To: lists+linux-erofs@lfdr.de
Delivered-To: lists+linux-erofs@lfdr.de
Received: from lists.ozlabs.org (lists.ozlabs.org [203.11.71.2])
	by mail.lfdr.de (Postfix) with ESMTPS id 254B5B7D38
	for <lists+linux-erofs@lfdr.de>; Thu, 19 Sep 2019 16:50:50 +0200 (CEST)
Received: from bilbo.ozlabs.org (lists.ozlabs.org [IPv6:2401:3900:2:1::3])
	by lists.ozlabs.org (Postfix) with ESMTP id 46Z0C94LsLzF53B
	for <lists+linux-erofs@lfdr.de>; Fri, 20 Sep 2019 00:50:45 +1000 (AEST)
X-Original-To: linux-erofs@lists.ozlabs.org
Delivered-To: linux-erofs@lists.ozlabs.org
Authentication-Results: lists.ozlabs.org;
 spf=pass (mailfrom) smtp.mailfrom=sirena.co.uk
 (client-ip=172.104.155.198; helo=heliosphere.sirena.org.uk;
 envelope-from=broonie@sirena.co.uk; receiver=<UNKNOWN>)
Authentication-Results: lists.ozlabs.org;
 dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: lists.ozlabs.org; dkim=pass (1024-bit key;
 unprotected) header.d=sirena.org.uk header.i=@sirena.org.uk
 header.b="KH/uzNdo"; dkim-atps=neutral
Received: from heliosphere.sirena.org.uk (heliosphere.sirena.org.uk
 [172.104.155.198])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange ECDHE (P-256) server-signature RSA-PSS (2048 bits) server-digest
 SHA256) (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 46Z0C35rVCzF52j
 for <linux-erofs@lists.ozlabs.org>; Fri, 20 Sep 2019 00:50:39 +1000 (AEST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sirena.org.uk; s=20170815-heliosphere; h=In-Reply-To:Content-Type:
 MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
 Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
 Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
 List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=i5pPM1UVZiw2ro3IsHlJxo7Ng7y6//q+LO3x8Z1chDQ=; b=KH/uzNdorkpdZdauBKjNzdsW0
 v8T0QAXw9O1uyGEVBrBKM/lLDUrZJvrG3xNXO9MtsHXmeay/lYiMDiuK9raVee9GoQKYStPaw/HY0
 bTIFwGnyici/MynZSGOG67U0aV14E3kBOIS2WsMgpdElSO6IJD0mCZxn+ze9tgL/hP9E8=;
Received: from cpc102320-sgyl38-2-0-cust46.18-2.cable.virginm.net
 ([82.37.168.47] helo=ypsilon.sirena.org.uk)
 by heliosphere.sirena.org.uk with esmtpsa
 (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256) (Exim 4.92)
 (envelope-from <broonie@sirena.co.uk>)
 id 1iAxlM-00045Z-Ng; Thu, 19 Sep 2019 14:50:28 +0000
Received: by ypsilon.sirena.org.uk (Postfix, from userid 1000)
 id E907F2742939; Thu, 19 Sep 2019 15:50:27 +0100 (BST)
Date: Thu, 19 Sep 2019 15:50:27 +0100
From: Mark Brown <broonie@kernel.org>
To: Gao Xiang <hsiangkao@aol.com>
Subject: Re: erofs -next tree inclusion request
Message-ID: <20190919145027.GN3642@sirena.co.uk>
References: <20190919120110.GA48697@architecture4>
 <20190919121739.GG3642@sirena.co.uk>
 <20190919122328.GA82662@architecture4>
 <20190919143722.GA5363@hsiangkao-HP-ZHAN-66-Pro-G1>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature"; boundary="BFVE2HhgxTpCzM8t"
Content-Disposition: inline
In-Reply-To: <20190919143722.GA5363@hsiangkao-HP-ZHAN-66-Pro-G1>
X-Cookie: I'll be Grateful when they're Dead.
User-Agent: Mutt/1.10.1 (2018-07-13)
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
Cc: Stephen Rothwell <sfr@canb.auug.org.au>, linux-erofs@lists.ozlabs.org,
 Miao Xie <miaoxie@huawei.com>, LKML <linux-kernel@vger.kernel.org>,
 linux-next@vger.kernel.org, Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
 Linus Torvalds <torvalds@linux-foundation.org>
Errors-To: linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org
Sender: "Linux-erofs"
 <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>


--BFVE2HhgxTpCzM8t
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Thu, Sep 19, 2019 at 10:37:22PM +0800, Gao Xiang wrote:

> The fixes only -fixes branch is
> git://git.kernel.org/pub/scm/linux/kernel/git/xiang/erofs.git fixes

> Thanks for taking time on this stuff...

OK, thanks - I've added that for tomorrow and I'll try to remember to
add it onto the end of today's build too.  Like I said before you might
need to remind Stephen about the trees when he gets back on the 30th but
hopefully he'll see these mails.

Thanks for adding your subsystem tree as a participant of linux-next.  As
you may know, this is not a judgement of your code.  The purpose of
linux-next is for integration testing and to lower the impact of
conflicts between subsystems in the next merge window.

You will need to ensure that the patches/commits in your tree/series have
been:
     * submitted under GPL v2 (or later) and include the Contributor's
        Signed-off-by,
     * posted to the relevant mailing list,
     * reviewed by you (or another maintainer of your subsystem tree),
     * successfully unit tested, and
     * destined for the current or next Linux merge window.

Basically, this should be just what you would send to Linus (or ask him
to fetch).  It is allowed to be rebased if you deem it necessary.

--BFVE2HhgxTpCzM8t
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAl2DlbMACgkQJNaLcl1U
h9CtrAf/QZhYKXrySmeiRMDhvrDKON7tTT7HiDarVbXpM8AghCMJ68vbO1nCFXEP
bDqHLECUOo24cPg2s/GD8JnLwRl8EGRLAfUer9tOm6xf0LI0bV1JOMIndpjuEe+z
7gkKr2yc8fGrB0c6rMMbna/2RkjCEQv9UaHMQM/Pul1w/qzLtb2GQaK4JXuiEPrS
kB6yDckRoZ+VdVLBb1UqiLjVvtCZDfZBTyJxPHhpKI7T7DjskMbpbsq6YMfGX8Th
7L3a6XeYIwYCJ4HDXC7SNvqeP9M/srct6FPdT9/A6lus8ttTw6hDW7LbUslyIrY7
X2++vlLneip8APqQRxByANt2h+vyaw==
=dwhx
-----END PGP SIGNATURE-----

--BFVE2HhgxTpCzM8t--
