Return-Path: <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>
X-Original-To: lists+linux-erofs@lfdr.de
Delivered-To: lists+linux-erofs@lfdr.de
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2404:9400:2:0:216:3eff:fee1:b9f1])
	by mail.lfdr.de (Postfix) with ESMTPS id C982158075C
	for <lists+linux-erofs@lfdr.de>; Tue, 26 Jul 2022 00:29:08 +0200 (CEST)
Received: from boromir.ozlabs.org (localhost [IPv6:::1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4LsF810d7rz3bsS
	for <lists+linux-erofs@lfdr.de>; Tue, 26 Jul 2022 08:29:05 +1000 (AEST)
Authentication-Results: lists.ozlabs.org;
	dkim=fail reason="signature verification failed" (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.a=rsa-sha256 header.s=google header.b=NcqMdFDo;
	dkim-atps=neutral
X-Original-To: linux-erofs@lists.ozlabs.org
Delivered-To: linux-erofs@lists.ozlabs.org
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=konsulko.com (client-ip=2607:f8b0:4864:20::72c; helo=mail-qk1-x72c.google.com; envelope-from=trini@konsulko.com; receiver=<UNKNOWN>)
Authentication-Results: lists.ozlabs.org;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.a=rsa-sha256 header.s=google header.b=NcqMdFDo;
	dkim-atps=neutral
Received: from mail-qk1-x72c.google.com (mail-qk1-x72c.google.com [IPv6:2607:f8b0:4864:20::72c])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4LsF7t6mtYz2xss
	for <linux-erofs@lists.ozlabs.org>; Tue, 26 Jul 2022 08:28:56 +1000 (AEST)
Received: by mail-qk1-x72c.google.com with SMTP id n2so9788125qkk.8
        for <linux-erofs@lists.ozlabs.org>; Mon, 25 Jul 2022 15:28:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=konsulko.com; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=+xQtkdVaNJTMiU1u+MD8iiV+11h/TXTsRFBJEbK7Xz0=;
        b=NcqMdFDo6vPwMuVMeXUfcDR55bYPgtIb/sYI/LO6MBRPjbpVjxBQoB6GtH5nu/leu0
         l05lEHaSJAjdxEl6QygQ4TcDE6M3mASmPUFv+Ua1y1D3MJmxL/COlHtldokZFaYZe1L/
         uZ08CIFEQMqM+KGJZcC5nRgeS6QSMq3cEfLzM=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=+xQtkdVaNJTMiU1u+MD8iiV+11h/TXTsRFBJEbK7Xz0=;
        b=M4k5XGCJKXsxfyaWorODyADrSjY7zFzGZQ7yUqsqE29A/S4qtmX907BuaEqNvJ39V6
         06ZtWP+Uq23Kq9x4AgkfjfdaxZ5OL/SmIte9HJPWvnMvVz59UT2V91MsnrARhM59133W
         Y/nFdqCl23/bqj0DgUG06lzYBgzbxgF2Cn7piaIhnEbQtscmrouZHAhICohPCKt0+vtS
         A/uK0EV65BxyjgmSTDiklfHbzeQr/oBDdX7kbODv6AnfObe5opEoK0CI4U744sgb5Cs5
         pbllqwD83PQQDy3SQ1sCiwJJJg6q1s4GBHNTjz52c37AXlEuvvjRIWrQxVzDOrjVsQy1
         24rA==
X-Gm-Message-State: AJIora+e2hmvCz2mTMYwORVanmb4TX7/GBJd9kRt2CTJXg3GJLRSW1L7
	XQQySrtbYkypQ6ugH8sWU5Qrzw==
X-Google-Smtp-Source: AGRyM1sQ8FUKeGgrHslcELzZIe6d6F2Fc9q2i4k9e+Tfb53eheHW1EJ65xaUrQmLewB6k14ykr5l8w==
X-Received: by 2002:a05:620a:e1d:b0:6af:33de:ed35 with SMTP id y29-20020a05620a0e1d00b006af33deed35mr10928525qkm.270.1658788133280;
        Mon, 25 Jul 2022 15:28:53 -0700 (PDT)
Received: from bill-the-cat (cpe-65-184-195-139.ec.res.rr.com. [65.184.195.139])
        by smtp.gmail.com with ESMTPSA id n5-20020a05620a294500b006b5df4d2c81sm10494676qkp.94.2022.07.25.15.28.51
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 25 Jul 2022 15:28:52 -0700 (PDT)
Date: Mon, 25 Jul 2022 18:28:50 -0400
From: Tom Rini <trini@konsulko.com>
To: Qu Wenruo <wqu@suse.com>
Subject: Re: [PATCH 1/8] fs: fat: unexport file_fat_read_at()
Message-ID: <20220725222850.GA3420905@bill-the-cat>
References: <cover.1656502685.git.wqu@suse.com>
 <b28b8d554dd3d1fc6bed8fc7f5b9cb71e1880e38.1656502685.git.wqu@suse.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="UlVJffcvxoiEqYs2"
Content-Disposition: inline
In-Reply-To: <b28b8d554dd3d1fc6bed8fc7f5b9cb71e1880e38.1656502685.git.wqu@suse.com>
X-Clacks-Overhead: GNU Terry Pratchett
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
Cc: joaomarcos.costa@bootlin.com, marek.behun@nic.cz, u-boot@lists.denx.de, thomas.petazzoni@bootlin.com, miquel.raynal@bootlin.com, linux-erofs@lists.ozlabs.org, linux-btrfs@vger.kernel.org
Errors-To: linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org
Sender: "Linux-erofs" <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>


--UlVJffcvxoiEqYs2
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, Jun 29, 2022 at 07:38:22PM +0800, Qu Wenruo wrote:

> That function is only utilized inside fat driver, unexport it.
>=20
> Signed-off-by: Qu Wenruo <wqu@suse.com>

The series has a fails to build on nokia_rx51:
https://source.denx.de/u-boot/u-boot/-/jobs/471877#L483
which to me says doing 64bit division (likely related to block size,
etc) without using the appropriate helper macros to turn them in to bit
shifts instead.

--=20
Tom

--UlVJffcvxoiEqYs2
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQGzBAABCgAdFiEEGjx/cOCPqxcHgJu/FHw5/5Y0tywFAmLfGR4ACgkQFHw5/5Y0
tywnkgv7BsMaSsvuizP3WkNmfj7bbjU584W+IHj4/nIQ1dpJk3fAAok6dFAJOYR+
BbRTRensgyG00SXOeGBQBCULE/bQ5eeiGrxMjg7ThSpIUx1llXMmQBrLmXS+IJb5
4aFFZ74J5v8kLjt20lstTWhdcgd8OJoCBVvp/Q6NarkxlQFbhZwL3y/hy+6eNG9B
Jd70zBy8898rUkKvNiOtgen1WKOPOU0eMhOlfryzXW+1tve/so/D+G8WTTOe71nd
W2YPAALogpMwIbBgfi8A4vE0qDNw6o/7JYjGxHOHxLGb4CLmHp8HNxx0ln0xxNsG
2BKDLWVuoAk9Lff9yqYQSyl3t6iqgQ2eLtZ+iYq0G8/qu3hxH8to6wfwZCPVfiwz
XSmAzm9qrF1vOW9bwOEnSk6fQYd+8bqsZssIEobJJww33Y89VBQkvln/A2sDvsdN
SbcsDI8GLKWy8o06JLOrgjhAqPC6RV9NBNdT54obaDyn/NPIoZislmRzc9eiaPu0
hz1eGx+P
=Om0f
-----END PGP SIGNATURE-----

--UlVJffcvxoiEqYs2--
