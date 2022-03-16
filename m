Return-Path: <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>
X-Original-To: lists+linux-erofs@lfdr.de
Delivered-To: lists+linux-erofs@lfdr.de
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	by mail.lfdr.de (Postfix) with ESMTPS id EBE614DAF5E
	for <lists+linux-erofs@lfdr.de>; Wed, 16 Mar 2022 13:10:45 +0100 (CET)
Received: from boromir.ozlabs.org (localhost [IPv6:::1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4KJTcz5zgsz30Dr
	for <lists+linux-erofs@lfdr.de>; Wed, 16 Mar 2022 23:10:43 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org;
	dkim=fail reason="signature verification failed" (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.a=rsa-sha256 header.s=google header.b=mOOgeqCP;
	dkim-atps=neutral
X-Original-To: linux-erofs@lists.ozlabs.org
Delivered-To: linux-erofs@lists.ozlabs.org
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized)
 smtp.mailfrom=konsulko.com (client-ip=2607:f8b0:4864:20::82d;
 helo=mail-qt1-x82d.google.com; envelope-from=trini@konsulko.com;
 receiver=<UNKNOWN>)
Authentication-Results: lists.ozlabs.org; dkim=pass (1024-bit key;
 unprotected) header.d=konsulko.com header.i=@konsulko.com header.a=rsa-sha256
 header.s=google header.b=mOOgeqCP; dkim-atps=neutral
Received: from mail-qt1-x82d.google.com (mail-qt1-x82d.google.com
 [IPv6:2607:f8b0:4864:20::82d])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 4KJTcq70WHz307C
 for <linux-erofs@lists.ozlabs.org>; Wed, 16 Mar 2022 23:10:35 +1100 (AEDT)
Received: by mail-qt1-x82d.google.com with SMTP id 11so1523762qtt.9
 for <linux-erofs@lists.ozlabs.org>; Wed, 16 Mar 2022 05:10:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=konsulko.com; s=google;
 h=date:from:to:cc:subject:message-id:references:mime-version
 :content-disposition:in-reply-to;
 bh=Nx58HxIgKwU3kvrTDE8+12P/sGhwV2IDxebOc6DZg68=;
 b=mOOgeqCPuZNt7sWPSJr0SURdg84viR3erdRmbATQP5E72N44w412ZFyAwMlYupCyMu
 h2GtqaszGIcQa46GkLs1ni+qQYysHaVU5P9zftbRzAQ/sxCZXucIDLzQ8/S7cdwlZY8E
 uGmaF6z384DtQMQ3itxe0xTfF2fcJzTdaMJ38=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=x-gm-message-state:date:from:to:cc:subject:message-id:references
 :mime-version:content-disposition:in-reply-to;
 bh=Nx58HxIgKwU3kvrTDE8+12P/sGhwV2IDxebOc6DZg68=;
 b=7UAUKrfOEu80Q8XkQYNZnaRTXo4e9YTUgoiFpR3UUz7pzzN34rwxpQNFwe6D5nr1pL
 p4E6qWMh3PiPrbpR/SyKeva0MbduQUNTt2ZHFoVleN7G2S1GZRV0fQSyOhfTGDiEwq79
 3xsRd0jREGLscblSK/8QiCy017SAXx9FiDzxeZTZaywL+BAxCwgmKJgcbtMnl5bPa9c4
 /+jT71Ng5vfuVXwbfOnaZ9utEOaPyn1nAokoaeuNEFZVwuoJzPdFdccmHtU++tQ8VhbX
 jJmeTBaQn5NOCxSorSfXRD2RHuDXHhXLEuqbnvcMrtgeI8+8+DNEUr2AFnajhTr16unX
 iouA==
X-Gm-Message-State: AOAM532pFLJQ62AG0bmJHr2ZbhcBBZz5RRAci1rOHJd7hM1x8sxH01Em
 IiGad9r1AiMNRE+DZqCJ3RybBw==
X-Google-Smtp-Source: ABdhPJx9VSnRGqo1T9sNy6L1BQWMIM7hoLNCAKKya/yBmza6tT1++6NSUKnAtGszTYig2c463Eg+OQ==
X-Received: by 2002:a05:622a:1a1d:b0:2e1:be1f:a4e8 with SMTP id
 f29-20020a05622a1a1d00b002e1be1fa4e8mr18508411qtb.371.1647432633112; 
 Wed, 16 Mar 2022 05:10:33 -0700 (PDT)
Received: from bill-the-cat
 (2603-6081-7b01-cbda-2ef0-5dff-fedb-a8ba.res6.spectrum.com.
 [2603:6081:7b01:cbda:2ef0:5dff:fedb:a8ba])
 by smtp.gmail.com with ESMTPSA id
 w17-20020ac857d1000000b002e19feda592sm1193442qta.85.2022.03.16.05.10.32
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 16 Mar 2022 05:10:32 -0700 (PDT)
Date: Wed, 16 Mar 2022 08:10:30 -0400
From: Tom Rini <trini@konsulko.com>
To: Huang Jianan <jnhuang95@gmail.com>
Subject: Re: [PATCH v4 2/5] lib/lz4: update LZ4 decompressor module
Message-ID: <20220316121030.GH577378@bill-the-cat>
References: <20220226070551.9833-1-jnhuang95@gmail.com>
 <20220226070551.9833-3-jnhuang95@gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature"; boundary="6cMF9JLEeZkfJjkP"
Content-Disposition: inline
In-Reply-To: <20220226070551.9833-3-jnhuang95@gmail.com>
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
Cc: u-boot@lists.denx.de, linux-erofs@lists.ozlabs.org
Errors-To: linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org
Sender: "Linux-erofs"
 <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>


--6cMF9JLEeZkfJjkP
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Sat, Feb 26, 2022 at 03:05:48PM +0800, Huang Jianan wrote:

> Update the LZ4 compression module based on LZ4 v1.8.3 in order to
> use the newest LZ4_decompress_safe_partial() which can now decode
> exactly the nb of bytes requested.
>=20
> Signed-off-by: Huang Jianan <jnhuang95@gmail.com>

Applied to u-boot/next, thanks!

--=20
Tom

--6cMF9JLEeZkfJjkP
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQGzBAABCgAdFiEEGjx/cOCPqxcHgJu/FHw5/5Y0tywFAmIx07YACgkQFHw5/5Y0
tyxVYAv+ILvWrCeFn/zPRA+Vhc8Y59qtfQrwll+EXDweQ/ICjJxGRTfRYKK1nO8A
YZT9UYnRafqHf4hsXiMqiClbPzxVQR0hlKA06mNMS+CvMwXiCLkWakbqewFbAmWd
NMtc3vkNNPQl7rDB70h3fGmYnMQlbtk4csdLTVbepO7dZvkEkKEHXtUUyBzdJP9M
DDn9O1fidMOsnDcmdZtrzqN37jUlLI0jBUfHwAhXz9RO7fP3RC4JywvoPly2E1hd
yFfASc3v9KZglgRd5kgMyAlTadEJ4M43aa6ugLl80I/B8S5s7TrRAJB4C+nHtVGv
55padIbb8HjCRUDr/33v9F8DnV3Z/kITMnEd9zQPwnBW3Un/PANyw74H5LWWyak/
7eetbRK1p5xUZY9d0qVZ4A+lPMA2ii0bF4Oo9h62NZTvpLay9ZQqaDdhSG87EmzQ
6jHBLzMkl7StWWIJgU/cwL1ZxQrEUND7YDoCDd00jJxnW3rkDsr7btrjcSf5NGvl
lUu+100d
=fcEt
-----END PGP SIGNATURE-----

--6cMF9JLEeZkfJjkP--
