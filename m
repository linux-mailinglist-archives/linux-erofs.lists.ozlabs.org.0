Return-Path: <linux-erofs+bounces-1-lists+linux-erofs=lfdr.de@lists.ozlabs.org>
X-Original-To: lists+linux-erofs@lfdr.de
Delivered-To: lists+linux-erofs@lfdr.de
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2404:9400:2:0:216:3eff:fee1:b9f1])
	by mail.lfdr.de (Postfix) with ESMTPS id 3E8EDA4D3FE
	for <lists+linux-erofs@lfdr.de>; Tue,  4 Mar 2025 07:40:39 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=lists.ozlabs.org;
	s=201707; t=1741070436;
	bh=9mYhK+mHcBTfJmZMuuCoTRrWvh6qabo+dIU13NfHBew=;
	h=Date:From:To:Subject:List-Id:List-Help:List-Owner:List-Post:
	 List-Subscribe:List-Unsubscribe:From;
	b=S+fmv2RPEB9gkGa1sRsIaTZjpjH4XBQSuviv6c3ZjV9eKQ9KjmkmfRrRdckDnZDOP
	 x5cume1VruBFwOhrYmroYnsObribKitXsnfwHIhQqUH/B0knVj45O6/p64fvMqLIMK
	 jOszvjeKa1w1tz6RGxUn9n7m96wjJobVWXR4i1g1nCs69EbNMHlzUgdjVQFpBZ2JVh
	 XcBYOSVaeN/UKTeeAbJG96BBkvRj8t482Tss+Cji0XlZNuITYZGcI5ed43ocK/OjDL
	 cZBfD0kINUOapWLbneCtfs0Dp+HVMof6laN5RmRxIWPSLZQGbSlwFXEvBImvnWXFXC
	 2QZzs3co0AGmA==
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4Z6Qzm5kGKz30MZ;
	Tue,  4 Mar 2025 17:40:36 +1100 (AEDT)
X-Original-To: linux-erofs@lists.ozlabs.org
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip=150.107.74.76
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1741070207;
	cv=none; b=lpNrgYG0nTZdoGDXv5c0IoTq1jXtPHexbCvSLjEypUXEd2QQbpjgIjzf0bg1OS/X3MOXjBacr4wGGXIU8fa02TNGZSIFDqpudt89yvB77aCqh1DAq6ZY/YB+2LQdOw2ekDK3uhaZJW/OSQNX95B8AuLSRKNw7mpUt6Jtn9rlwOkFCISv+8+fHk7+azct8WkTm0dSHR8dog28+IeaY09zQIdkQ/NZlPVWDSzlBLLU07IsO4jrbtKS6yocYMeirKsN/WK24qOtrf7LiXh7JSb88irquHCWqeHWsRwZBvVcOXRheMMQ0DZI3TCvSHhyvyptdzwc9ZWgjunbb6aruBiypw==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1741070207; c=relaxed/relaxed;
	bh=9mYhK+mHcBTfJmZMuuCoTRrWvh6qabo+dIU13NfHBew=;
	h=Date:From:To:Subject:Message-ID:MIME-Version:Content-Type; b=S7qjkGt0VlWwZ8jQUDAcx0BhYZLNpQf8caVJY+N6AW234lCBS+w6gaMhXRuOjqumvC/GhuUVlCq3qdeQktOOCX4SUEXNxjqoCJuGEYpvQertpNQr5R0vhoovMzpSZhftI5GCvPjIkk65/ctqhn54ElUXbPFT/Rq6CnmubHjaputBE9wCukRHYPCPIc0mgVwk1m3ryCG/eWEquniGXH60gj9g70af810g8b4pGOv28RqCCMhZrIsGcSylisA7Ct/TxeQGzhMIssNEK6KBpjH2IkImq/iFCSyM3WJNdABI3LOaFdbXmDtgjY7e5Tpbw2VpI7ovwWsX544npKjMH/toXQ==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=lists.ozlabs.org; dkim=pass (2048-bit key; secure) header.d=lists.ozlabs.org header.i=@lists.ozlabs.org header.a=rsa-sha256 header.s=201707 header.b=Q0KjQsYJ; dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=lists.ozlabs.org
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; secure) header.d=lists.ozlabs.org header.i=@lists.ozlabs.org header.a=rsa-sha256 header.s=201707 header.b=Q0KjQsYJ;
	dkim-atps=neutral
Received: from mail.ozlabs.org (gandalf.ozlabs.org [150.107.74.76])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits))
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4Z6QvL5PjTz2xpn
	for <linux-erofs@lists.ozlabs.org>; Tue,  4 Mar 2025 17:36:46 +1100 (AEDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=lists.ozlabs.org;
	s=201707; t=1741070206;
	bh=9mYhK+mHcBTfJmZMuuCoTRrWvh6qabo+dIU13NfHBew=;
	h=Date:From:To:Subject:From;
	b=Q0KjQsYJlN56QbfRVJaqPIBtIX0GC1n5n2CeqK4BMOGe+0SI9YfEqpqqRtQa66n/r
	 6uFhOuOKdtOP/z60TtjRIkblhCRm9JXt3bBkpN03/h0T0bVaq5HRMrA9LofnjdAHzf
	 jK9U/IYJtqgQ6EGR/5Mik6BGMvvjnP3onhQI3MphVVV4uaJ6X9PN3jFiH+DKCBVb+Y
	 8BdT/GWuC8rBmF4wD0LweDGB6Y9rse+e2GnnxFn2QpI/sfGtRG2apw2zqr1W0rmrAF
	 zITB5Tp4kjHTopg7nYv9bwwszCtjrC6SzdIVOfYsLoY0JqLz7lyrPr77QPn7OfXowA
	 l9ciLk63tOX4w==
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (prime256v1) server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(Client did not present a certificate)
	by mail.ozlabs.org (Postfix) with ESMTPSA id 4Z6QvL45glz4wcw
	for <linux-erofs@lists.ozlabs.org>; Tue,  4 Mar 2025 17:36:46 +1100 (AEDT)
Date: Tue, 4 Mar 2025 17:36:45 +1100
From: Postmaster <postmaster@lists.ozlabs.org>
To: <linux-erofs@lists.ozlabs.org>
Subject: Change to this list
Message-ID: <20250304173645.54724774@canb.auug.org.au>
X-Mailing-List: linux-erofs@lists.ozlabs.org
List-Id: <linux-erofs.lists.ozlabs.org>
List-Help: <mailto:linux-erofs+help@lists.ozlabs.org>
List-Owner: <mailto:linux-erofs+owner@lists.ozlabs.org>
List-Post: <mailto:linux-erofs@lists.ozlabs.org>
List-Subscribe: <mailto:linux-erofs+subscribe@lists.ozlabs.org>,
  <mailto:linux-erofs+subscribe-digest@lists.ozlabs.org>,
  <mailto:linux-erofs+subscribe-nomail@lists.ozlabs.org>
List-Unsubscribe: <mailto:linux-erofs+unsubscribe@lists.ozlabs.org>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="Sig_/nZvuNy78.cu9Z9sf.b9/LPS";
 protocol="application/pgp-signature"; micalg=pgp-sha256
X-Spam-Status: No, score=-2.5 required=5.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_PASS,SPF_PASS
	autolearn=disabled version=4.0.0
X-Spam-Checker-Version: SpamAssassin 4.0.0 (2022-12-13) on lists.ozlabs.org

--Sig_/nZvuNy78.cu9Z9sf.b9/LPS
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable

Hi all,

Just to let you know that this list is now managed using Mlmmj rather
than Mailman.  To see how to manage your subscription, please send an
email to <linux-erofs+help@lists.ozlabs.org>.  The archives are still
available at http://lists.ozlabs.org/pipermail/lists-erofs and
https://lore.kernel.org/linux-erofs/ .

--=20
Cheers,
Stephen Rothwell	Postmaster at lists.ozlabs.org

--Sig_/nZvuNy78.cu9Z9sf.b9/LPS
Content-Type: application/pgp-signature
Content-Description: OpenPGP digital signature

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEENIC96giZ81tWdLgKAVBC80lX0GwFAmfGn30ACgkQAVBC80lX
0Gxz7Qf+IX3vjCKhIBGLG7Z9tyGtOuI236P09acPXK/AlSMrieBybQ+lQktPyMoe
rvaIiy1nyv5SoESTIdZVSGctcLD9TsrhlC6xPIfpCp2Ld6Vfl1b5aeD12LmAH7fe
No/aQA1T8WKYfzSdsUiOiBIYxCW4HuwDnJrDETjoXUToMvSXYx/lJ2/wFszdbwWk
qx95heysPyoMT0YoX7zwCT06QweKo0Bup9loVzsZ4aan1ezzZh971wQA07tmjUN3
eAnCYqCMe5ESJgcV79UeoJ6HRktFKpKIRw2mombm6bHnIiXtvUws7XLey8VUjERH
H02QaSuRByUbMRdV80TrKDud2jpwpg==
=ipip
-----END PGP SIGNATURE-----

--Sig_/nZvuNy78.cu9Z9sf.b9/LPS--

