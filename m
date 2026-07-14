Return-Path: <linux-erofs+bounces-3887-lists+linux-erofs=lfdr.de@lists.ozlabs.org>
Delivered-To: lists+linux-erofs@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id l5Z/O8GHVWrVpgAAu9opvQ
	(envelope-from <linux-erofs+bounces-3887-lists+linux-erofs=lfdr.de@lists.ozlabs.org>)
	for <lists+linux-erofs@lfdr.de>; Tue, 14 Jul 2026 02:50:10 +0200
X-Original-To: lists+linux-erofs@lfdr.de
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	by mail.lfdr.de (Postfix) with ESMTPS id 4F84774FE96
	for <lists+linux-erofs@lfdr.de>; Tue, 14 Jul 2026 02:50:08 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=cyphar.com header.s=MBO0001 header.b=IGKrcvi8;
	spf=pass (mail.lfdr.de: domain of "linux-erofs+bounces-3887-lists+linux-erofs=lfdr.de@lists.ozlabs.org" designates 112.213.38.117 as permitted sender) smtp.mailfrom="linux-erofs+bounces-3887-lists+linux-erofs=lfdr.de@lists.ozlabs.org";
	dmarc=pass (policy=reject) header.from=cyphar.com;
	arc=pass ("lists.ozlabs.org:s=201707:i=1")
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4gzggx0PCxz2yY0;
	Tue, 14 Jul 2026 10:50:05 +1000 (AEST)
X-Original-To: linux-erofs@lists.ozlabs.org
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1783990204;
	cv=none; b=P6DrNlIQsFIwNd1r0UeU+Zt3Nh2dn/szDbBBI7ZDht/Qdzi0MF2IYoSLKbZmJthuBKJ7l2jsOOq8VvSQRgya2/mCHYM8JK1OA3bv2sNTtgMf7CutxHu/tpg8Obr3k0xKeWeyILPgRskA97U7i8P6dhcTotcvcd3OVVItIhAfc47NJKaFnBhXQFHGUwjcY07GspWA0tjvywfZ6P90lUrsYziRIhRkCchu8+gHyv02HHRH+crznZAMGHgPXtA7nGOIfn9IC3lK8F7pnNbt4qdscOfV3gZGK5ZiEeW8s9rl2vOdsgWW6fDTnEupHDapwJqEsjIJ2GEWqkbCxjIYZAQ11Q==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1783990204; c=relaxed/relaxed;
	bh=pi+aB6YMCYhiJWt1pTb8a7/h/MvI2o3bfTPFrZ8+JGo=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=FxN9GrS2Mbp5HNH8DKtaj6Bur9TNbahol0UawnUjp8OJWvlYL7NzBkemJ5gCAbULWxpNdN65kNRpDN883ZXequJEgeT4IirJVaBXbE5+cV44+uSLN3w3uQXaTAxqcm08YMzgBMDp4UOSoqnto07C38n49dqgAjMs5UBMbiMxabE8CSa9ImlYXaltigAAYpvHmt38KxlHKlSZJD7jpaKa/uAJpB37bhwbEQDpJGs9E1s5xQZWpp0faPmzvrObSaQjDCR/mxMfhX9DbGXT0xhZ0MrRhhRsdrXHsCV6xWfDob2RcyEj6h7BRBK9LzEuu1XhLt9l6PpAy436cevSlu5WHw==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=reject dis=none) header.from=cyphar.com; dkim=pass (2048-bit key; secure) header.d=cyphar.com header.i=@cyphar.com header.a=rsa-sha256 header.s=MBO0001 header.b=IGKrcvi8; dkim-atps=neutral; spf=pass (client-ip=2001:67c:2050:0:465::201; helo=mout-p-201.mailbox.org; envelope-from=cyphar@cyphar.com; receiver=lists.ozlabs.org) smtp.mailfrom=cyphar.com
Received: from mout-p-201.mailbox.org (mout-p-201.mailbox.org [IPv6:2001:67c:2050:0:465::201])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bit raw public key) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4gzggv553Gz2y8p
	for <linux-erofs@lists.ozlabs.org>; Tue, 14 Jul 2026 10:50:02 +1000 (AEST)
Received: from smtp2.mailbox.org (smtp2.mailbox.org [10.196.197.2])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (4096 bits) server-digest SHA512)
	(No client certificate requested)
	by mout-p-201.mailbox.org (Postfix) with ESMTPS id 4gzggf1WJhzMlBb;
	Tue, 14 Jul 2026 02:49:50 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cyphar.com; s=MBO0001;
	t=1783990190;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=pi+aB6YMCYhiJWt1pTb8a7/h/MvI2o3bfTPFrZ8+JGo=;
	b=IGKrcvi8eH0ST6ZUbo9P6C/vNbv8IDtvnryd9IJarNgZWvLIhwYT9opCPqND/YPvIvynlN
	HPg7GyryTaIgN1E/00FvtOywg5lzHW6C0hSjivQNLrxmnvQqhvYvlltYqkV41IgLYcDoZE
	89nOSpUTlTpzMbmXJBOPd7TYcvprJnYDDIrRTCTNI7iopz7qbjahdDgpxBsYrYsx0RTvvZ
	MXqLxi/rvA3kDXi6wnzPAYW0KML0jdtcK2TOrHmFoZ4xKiDBXG4NKGWNHcnUEUSe550vxi
	P6iNARi7dQmN1PgyDXNViT0a86PvGvIKPB9vHJn728k44+CAPa2VCrXYd1I1nA==
Date: Tue, 14 Jul 2026 10:49:40 +1000
From: Aleksa Sarai <cyphar@cyphar.com>
To: Giuseppe Scrivano <gscrivan@redhat.com>
Cc: linux-erofs@lists.ozlabs.org, linux-fsdevel@vger.kernel.org, 
	Christian Brauner <brauner@kernel.org>
Subject: Re: [PATCH v2] erofs: accept source file descriptor via fsconfig
Message-ID: <2026-07-14-drafty-folded-woes-volumes-Z93P4V@cyphar.com>
References: <20260711071137.4130824-1-gscrivan@redhat.com>
 <2026-07-13-dandy-better-exposure-wager-9hBmfv@cyphar.com>
 <871pd748kh.fsf@redhat.com>
 <2026-07-13-chief-single-carnival-graders-7dI4ue@cyphar.com>
 <87wluz2nnc.fsf@redhat.com>
X-Mailing-List: linux-erofs@lists.ozlabs.org
List-Id: <linux-erofs.lists.ozlabs.org>
List-Help: <mailto:linux-erofs+help@lists.ozlabs.org>
List-Owner: <mailto:linux-erofs+owner@lists.ozlabs.org>
List-Post: <mailto:linux-erofs@lists.ozlabs.org>
List-Subscribe: <mailto:linux-erofs+subscribe@lists.ozlabs.org>,
  <mailto:linux-erofs+subscribe-digest@lists.ozlabs.org>,
  <mailto:linux-erofs+subscribe-nomail@lists.ozlabs.org>
List-Unsubscribe: <mailto:linux-erofs+unsubscribe@lists.ozlabs.org>
Precedence: list
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="aaxxywpo7g3ddiom"
Content-Disposition: inline
In-Reply-To: <87wluz2nnc.fsf@redhat.com>
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,SPF_HELO_PASS,SPF_PASS
	autolearn=disabled version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-25) on lists.ozlabs.org
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-4.30 / 15.00];
	SIGNED_PGP(-2.00)[];
	ARC_ALLOW(-1.00)[lists.ozlabs.org:s=201707:i=1];
	DMARC_POLICY_ALLOW(-0.50)[cyphar.com,reject];
	R_DKIM_ALLOW(-0.20)[cyphar.com:s=MBO0001];
	MIME_GOOD(-0.20)[multipart/signed,text/plain];
	R_SPF_ALLOW(-0.20)[+ip4:112.213.38.117];
	MAILLIST(-0.19)[generic];
	HAS_LIST_UNSUB(-0.01)[];
	MIME_TRACE(0.00)[0:+,1:+,2:~];
	FORGED_SENDER(0.00)[cyphar@cyphar.com,linux-erofs@lists.ozlabs.org];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-3887-lists,linux-erofs=lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORWARDED(0.00)[linux-erofs@lists.ozlabs.org];
	RCVD_COUNT_THREE(0.00)[3];
	FORGED_RECIPIENTS(0.00)[m:gscrivan@redhat.com,m:linux-erofs@lists.ozlabs.org,m:linux-fsdevel@vger.kernel.org,m:brauner@kernel.org,s:lists@lfdr.de];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FROM_HAS_DN(0.00)[];
	MISSING_XM_UA(0.00)[];
	RCPT_COUNT_THREE(0.00)[4];
	PREVIOUSLY_DELIVERED(0.00)[linux-erofs@lists.ozlabs.org];
	ALIAS_RESOLVED(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[cyphar@cyphar.com,linux-erofs@lists.ozlabs.org];
	DKIM_TRACE(0.00)[cyphar.com:+];
	MID_RHS_MATCH_FROM(0.00)[];
	TAGGED_RCPT(0.00)[linux-erofs];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	TO_DN_SOME(0.00)[];
	ASN(0.00)[asn:133159, ipnet:112.213.32.0/21, country:AU];
	DBL_BLOCKED_OPENRESOLVER(0.00)[cyphar.com:from_mime,cyphar.com:url,cyphar.com:mid,cyphar.com:dkim]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 4F84774FE96


--aaxxywpo7g3ddiom
Content-Type: text/plain; protected-headers=v1; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable
Subject: Re: [PATCH v2] erofs: accept source file descriptor via fsconfig
MIME-Version: 1.0

On 2026-07-13, Giuseppe Scrivano <gscrivan@redhat.com> wrote:
> thanks for the hints.
>=20
> I'll prepare a v3 if you are fine with the version below:

No worries, and this seems more reasonable at a first glance.

> diff --git a/fs/erofs/super.c b/fs/erofs/super.c
> index 86fa5c6a0c70..72c85cc53085 100644
> --- a/fs/erofs/super.c
> +++ b/fs/erofs/super.c
=2E..
> @@ -437,6 +439,38 @@ static bool erofs_fc_set_dax_mode(struct fs_context =
*fc, unsigned int mode)
>  	return false;
>  }
> =20
> +static int erofs_fc_parse_source(struct fs_context *fc,
> +				 struct fs_parameter *param)
> +{
> +	struct erofs_sb_info *sbi =3D fc->s_fs_info;
> +
> +	if (fc->source || sbi->dif0.file)
> +		return invalf(fc, "Multiple sources");
> +
> +	switch (param->type) {
> +	case fs_value_is_string:
> +		fc->source =3D param->string;
> +		param->string =3D NULL;
> +		return 0;
> +	case fs_value_is_file: {
> +		char *buf, *p;
> +
> +		sbi->dif0.file =3D get_file(param->file);

A very minor nit, but you can actually steal the file reference here
with

		sbi->dif0.file =3D no_free_ptr(param->file);

A few other places do this. (You'll also need to change the param->file
reference below.)

> +		buf =3D kmalloc(PATH_MAX, GFP_KERNEL);
> +		if (!buf)
> +			return -ENOMEM;
> +		p =3D file_path(param->file, buf, PATH_MAX);
> +		fc->source =3D kstrdup(IS_ERR(p) ? "(fd)" : p, GFP_KERNEL);

I think that /proc/self/fd/%d would be a more useful name for debugging
if file_path() fails (not that it is really possible here AFAICS). But
I'm not really too fussed.

--=20
Aleksa Sarai
Founding Engineer at Amutable
https://www.cyphar.com/

--aaxxywpo7g3ddiom
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iJEEABYKADkWIQS2TklVsp+j1GPyqQYol/rSt+lEbwUCalWHpBsUgAAAAAAEAA5t
YW51MiwyLjUrMS4xMiwyLDIACgkQKJf60rfpRG9cyAEA0mkCZe8zd2ugT6dnuZH7
QOJsOhGBEvEDsJWFGj/8K7oA/3pYpGWn5E8exPFb5/7UnaBOBC7QE6oul3Fi+q4W
044N
=6wik
-----END PGP SIGNATURE-----

--aaxxywpo7g3ddiom--

