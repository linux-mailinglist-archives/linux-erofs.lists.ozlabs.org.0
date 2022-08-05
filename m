Return-Path: <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>
X-Original-To: lists+linux-erofs@lfdr.de
Delivered-To: lists+linux-erofs@lfdr.de
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2404:9400:2:0:216:3eff:fee1:b9f1])
	by mail.lfdr.de (Postfix) with ESMTPS id 943D758B108
	for <lists+linux-erofs@lfdr.de>; Fri,  5 Aug 2022 23:14:39 +0200 (CEST)
Received: from boromir.ozlabs.org (localhost [IPv6:::1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4Lzyyz1K2pz306l
	for <lists+linux-erofs@lfdr.de>; Sat,  6 Aug 2022 07:14:35 +1000 (AEST)
Authentication-Results: lists.ozlabs.org;
	dkim=fail reason="signature verification failed" (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.a=rsa-sha256 header.s=google header.b=ebV62zXa;
	dkim-atps=neutral
X-Original-To: linux-erofs@lists.ozlabs.org
Delivered-To: linux-erofs@lists.ozlabs.org
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=konsulko.com (client-ip=2607:f8b0:4864:20::833; helo=mail-qt1-x833.google.com; envelope-from=trini@konsulko.com; receiver=<UNKNOWN>)
Authentication-Results: lists.ozlabs.org;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.a=rsa-sha256 header.s=google header.b=ebV62zXa;
	dkim-atps=neutral
Received: from mail-qt1-x833.google.com (mail-qt1-x833.google.com [IPv6:2607:f8b0:4864:20::833])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4Lzyyr5wmHz2xGW
	for <linux-erofs@lists.ozlabs.org>; Sat,  6 Aug 2022 07:14:26 +1000 (AEST)
Received: by mail-qt1-x833.google.com with SMTP id b21so2916174qte.12
        for <linux-erofs@lists.ozlabs.org>; Fri, 05 Aug 2022 14:14:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=konsulko.com; s=google;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc;
        bh=zmIQUD9k3oMh2xY+Lf9iRiwwBZTO4inqzTNpKNqiUnI=;
        b=ebV62zXa/egD95xHYq60v5ND+BTzIWXpM3mOCD49LABCgpbKmKvXb+xy4YJWRRQM9L
         0rJCW2qZu/fPZtYfs7SicMyosjuFkfbGpjQsv5AJNlEihxUNvwWR5HqiGQaU7kaXnIQE
         GCBJU/r2RKmgdWX4h/6tCBfAQc2xCfPJ1DVQs=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc;
        bh=zmIQUD9k3oMh2xY+Lf9iRiwwBZTO4inqzTNpKNqiUnI=;
        b=JlhlwtPSeAOYQExZ51q6vbPqH4U16UOtBds5JkMm3wsXKel+qQ6Wa8Oc0BpO2xlN7m
         RQqR78Q4889brSm0I8KCV/rT85+0YyLT5vOQ7qRc90lGamajSLDaEQy4HWN2/Ucc9rkC
         pz6Caxtu5U/FzgQCgKFxVwXVP592I+ROl+BkcsUmERhwa4QNgn+ZDFwHyjW7Tyy7OLlh
         zmJaLlVmWsDRqHt9jhZdj+TFmOHFkWjU6/oQ63Jv1nLnw7FW7Pb0Ubpvx95cj1Dn/ec2
         9W+SOo8MXJClaAMkdlQYa1TF62Cce9bikuRTvd9Ut/CDvAsJQBacgK62nT3+tOKUQU9N
         a36w==
X-Gm-Message-State: ACgBeo3OFsZIMiql9MKxANOvq2nkoVhLOBrorT+xvNCAp4lAj7++sAcB
	JelZzfAdEYz5zdxRP293/cKSKQ==
X-Google-Smtp-Source: AA6agR6hdIK5rNSWh2Q8F6vp5nMGNFbxXbyqpr7lwsb1iYaN09spPJoYqETC1LYz4kYLN25wveGHiQ==
X-Received: by 2002:ac8:5a4c:0:b0:340:91d8:f217 with SMTP id o12-20020ac85a4c000000b0034091d8f217mr7686483qta.90.1659734063249;
        Fri, 05 Aug 2022 14:14:23 -0700 (PDT)
Received: from bill-the-cat (cpe-65-184-195-139.ec.res.rr.com. [65.184.195.139])
        by smtp.gmail.com with ESMTPSA id j2-20020ac806c2000000b00304fe5247bfsm3152129qth.36.2022.08.05.14.14.21
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 05 Aug 2022 14:14:22 -0700 (PDT)
Date: Fri, 5 Aug 2022 17:14:20 -0400
From: Tom Rini <trini@konsulko.com>
To: Qu Wenruo <wqu@suse.com>
Subject: Re: [PATCH v2 1/8] fs: fat: unexport file_fat_read_at()
Message-ID: <20220805211420.GA3027583@bill-the-cat>
References: <cover.1658812744.git.wqu@suse.com>
 <ee01c16f20f02230c3cfd0b266f06564fa211f62.1658812744.git.wqu@suse.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="ZGiS0Q5IWpPtfppv"
Content-Disposition: inline
In-Reply-To: <ee01c16f20f02230c3cfd0b266f06564fa211f62.1658812744.git.wqu@suse.com>
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


--ZGiS0Q5IWpPtfppv
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, Jul 26, 2022 at 01:22:09PM +0800, Qu Wenruo wrote:

> That function is only utilized inside fat driver, unexport it.
>=20
> Signed-off-by: Qu Wenruo <wqu@suse.com>

Unfortunately, the series fails CI:
https://source.denx.de/u-boot/u-boot/-/jobs/478838

--=20
Tom

--ZGiS0Q5IWpPtfppv
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQGzBAABCgAdFiEEGjx/cOCPqxcHgJu/FHw5/5Y0tywFAmLtiCEACgkQFHw5/5Y0
tyzViwwAjplcVzC8GpC7tnQx8Xb/E8+UYXJ5daXce5nIbeGOoOWnkQMgF4ZdzySK
UXYvQbpwToKHTLDzKhEBrmvZtsHC3nivADw1njcn+O+tQHOWJQk5tBd2ZHyTZhsE
b1ZskG3xeNqoZSjGqFpK3YkDWWHaSnWIjufZhuxbQ5yzv5EFnonJZvQ6bQYIZAwp
SDHhN4gTbWaR0Trlkv+FnQI5D8uu3d2fc0Eqav4IuKVakSjf6fulJODlnwcHcs9z
4Ux+btq6RkanERySlcP5aKi6oLKY56V5AwQM3h4V1yqYiYC7T7tnPIEx7J91HESc
6Q62mPAbjJ5+Wq3ogTNj61PGyLIMrEdAKPbeesI5uFz8/KWZXqxWQb6Hj2Znm1aY
k59RNKyIrzNyj0MiR1Rwsu5B9onlYK8CPTszIhGITTer27dnc2d2pKZA1pO4cESV
2EEnsXFEUBlMA99NEccpe5cNeT3BXPmBuvUEMmwxVyl0VYTt+GNro6hRB9G+Q9oI
tfapHCIR
=4wU9
-----END PGP SIGNATURE-----

--ZGiS0Q5IWpPtfppv--
