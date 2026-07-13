Return-Path: <linux-erofs+bounces-3879-lists+linux-erofs=lfdr.de@lists.ozlabs.org>
Delivered-To: lists+linux-erofs@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id qlxFLnpxVGpumAMAu9opvQ
	(envelope-from <linux-erofs+bounces-3879-lists+linux-erofs=lfdr.de@lists.ozlabs.org>)
	for <lists+linux-erofs@lfdr.de>; Mon, 13 Jul 2026 07:02:50 +0200
X-Original-To: lists+linux-erofs@lfdr.de
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2404:9400:21b9:f100::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 10A3E747304
	for <lists+linux-erofs@lfdr.de>; Mon, 13 Jul 2026 07:02:49 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=cyphar.com header.s=MBO0001 header.b=TrJbaXEA;
	dmarc=pass (policy=reject) header.from=cyphar.com;
	spf=pass (mail.lfdr.de: domain of "linux-erofs+bounces-3879-lists+linux-erofs=lfdr.de@lists.ozlabs.org" designates 2404:9400:21b9:f100::1 as permitted sender) smtp.mailfrom="linux-erofs+bounces-3879-lists+linux-erofs=lfdr.de@lists.ozlabs.org";
	arc=pass ("lists.ozlabs.org:s=201707:i=1")
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4gz9Kw3L0Gz2xWY;
	Mon, 13 Jul 2026 15:02:44 +1000 (AEST)
X-Original-To: linux-erofs@lists.ozlabs.org
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1783918964;
	cv=none; b=JPZFX5Vj6cVRp0mOsZw9JiVQ+s4h7Lx3/Z0FzxbJcLA4PPZSP5Nda22LI6RVjjDSIfwJ87CeScQze+M7A/ALd12KD9GWoHrUVALOf+nb7yLg10UpGFTucTOjhsJj8e0vutktGmklo7ncKnrQgD+/j2DPurGahv/+2prYnoxWg+2D6PKH/PiXyi4oNbPXLZy+KrpHV8g7/INliq29NtdBd6VgrfhxugqGwB6kJrzw1gLSOIzIMmHLXf9jURuw3nzOkIAe/Z7PskoD/3N5LaBhA7Jty+3k9fgZaTceVCl+OD/WpKZDQLghKW+3D4uNqh3djdb25JDGxPxbbOzhhr6xGA==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1783918964; c=relaxed/relaxed;
	bh=YCQJ8K3hqH0LIhTBV9jc6pRjrXoDZJgmWS96ChvNcrs=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=GZi2gM8ilVaf1zo60O75ReEw7TfhD1NleWeIcuApgfcPUs2+Sg13Cz4Y53b6wwjHEWWIWGXNzvIzXzpz2Mm4gwSTakWKAssJldWuyi+o87FEW14U2ciRS2kZI3M0fJM+VXQZQpRtWoNO3rdq389yXb4AALGwosnxtCxcFO7ZsoY3fBV5+CE63u+Dj1OoGxY4S/Zj6o75RfDf266DV0e1UGI//YmQ1tABwuCPwzzA0O90CJsif+cIIqNDudUYcpTb5Ndwt5c/Nz8uRQeAEFMQW053eqKe6y1Unze8RRgxkZQN8KIraztzrRsYTOIQiqLKXXtZRyaPlxqOKqw/swosAQ==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=reject dis=none) header.from=cyphar.com; spf=pass (client-ip=2001:67c:2050:0:465::102; helo=mout-p-102.mailbox.org; envelope-from=cyphar@cyphar.com; receiver=lists.ozlabs.org) smtp.mailfrom=cyphar.com
X-Greylist: delayed 585 seconds by postgrey-1.37 at boromir; Mon, 13 Jul 2026 15:02:34 AEST
Received: from mout-p-102.mailbox.org (mout-p-102.mailbox.org [IPv6:2001:67c:2050:0:465::102])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bit raw public key) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4gz9Kk3d13z2xVY
	for <linux-erofs@lists.ozlabs.org>; Mon, 13 Jul 2026 15:02:33 +1000 (AEST)
Received: from smtp102.mailbox.org (smtp102.mailbox.org [IPv6:2001:67c:2050:b231:465::102])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (4096 bits) server-digest SHA512)
	(No client certificate requested)
	by mout-p-102.mailbox.org (Postfix) with ESMTPS id 4gz96B3CjVzKv3V;
	Mon, 13 Jul 2026 06:52:34 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cyphar.com; s=MBO0001;
	t=1783918354;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=YCQJ8K3hqH0LIhTBV9jc6pRjrXoDZJgmWS96ChvNcrs=;
	b=TrJbaXEApjznMLFa/3Q4wCMc8SRRK4tuqittd45MZhd4gKkiMhyQsbbcGGSyOlGuUVAEd0
	1FZM3tdbKwbSc39jb4uDHACoHVPJlzrEBL8mvr/7CLzzl5RAyHEuAH82pcDD/iz5LlZ/P5
	NaVJ3/X7n+alcXeWlI3SP8uKf2Z72uxd5ZOSwpd4l/5LfzO9SMXjVWLv8ElV/zyHhk53jS
	Zo5jdeVY/4AGTBofrCPMSKrHfgCDNVfyJ4zZKzzXpo+g143TJ/b2CPUR29x/We090YW4pw
	J7MRBO9MBLSjiNP38INhnUB1hPAc3SP60wCsgQXD5zCy7AEf6grpdx2rGaKYkg==
Date: Mon, 13 Jul 2026 14:52:25 +1000
From: Aleksa Sarai <cyphar@cyphar.com>
To: Giuseppe Scrivano <gscrivan@redhat.com>
Cc: linux-erofs@lists.ozlabs.org, linux-fsdevel@vger.kernel.org, 
	Christian Brauner <brauner@kernel.org>
Subject: Re: [PATCH v2] erofs: accept source file descriptor via fsconfig
Message-ID: <2026-07-13-dandy-better-exposure-wager-9hBmfv@cyphar.com>
References: <20260711071137.4130824-1-gscrivan@redhat.com>
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
	protocol="application/pgp-signature"; boundary="i5hxj75u4eskqb5k"
Content-Disposition: inline
In-Reply-To: <20260711071137.4130824-1-gscrivan@redhat.com>
X-Spam-Status: No, score=-0.2 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_PASS,SPF_PASS autolearn=disabled
	version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-25) on lists.ozlabs.org
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-4.30 / 15.00];
	SIGNED_PGP(-2.00)[];
	ARC_ALLOW(-1.00)[lists.ozlabs.org:s=201707:i=1];
	DMARC_POLICY_ALLOW(-0.50)[cyphar.com,reject];
	R_DKIM_ALLOW(-0.20)[cyphar.com:s=MBO0001];
	MIME_GOOD(-0.20)[multipart/signed,text/plain];
	R_SPF_ALLOW(-0.20)[+ip6:2404:9400:21b9:f100::1];
	MAILLIST(-0.19)[generic];
	HAS_LIST_UNSUB(-0.01)[];
	MIME_TRACE(0.00)[0:+,1:+,2:~];
	FORGED_SENDER(0.00)[cyphar@cyphar.com,linux-erofs@lists.ozlabs.org];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-3879-lists,linux-erofs=lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORWARDED(0.00)[linux-erofs@lists.ozlabs.org];
	FORGED_RECIPIENTS(0.00)[m:gscrivan@redhat.com,m:linux-erofs@lists.ozlabs.org,m:linux-fsdevel@vger.kernel.org,m:brauner@kernel.org,s:lists@lfdr.de];
	RCVD_COUNT_THREE(0.00)[3];
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
	ASN(0.00)[asn:133159, ipnet:2404:9400:2000::/36, country:AU];
	DBL_BLOCKED_OPENRESOLVER(0.00)[youtu.be:url,lists.ozlabs.org:from_smtp,lists.ozlabs.org:helo,lists.ozlabs.org:rdns]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 10A3E747304


--i5hxj75u4eskqb5k
Content-Type: text/plain; protected-headers=v1; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable
Subject: Re: [PATCH v2] erofs: accept source file descriptor via fsconfig
MIME-Version: 1.0

On 2026-07-11, Giuseppe Scrivano <gscrivan@redhat.com> wrote:
> diff --git a/fs/erofs/super.c b/fs/erofs/super.c
> index 86fa5c6a0c70..3040d4cf9b85 100644
> --- a/fs/erofs/super.c
> +++ b/fs/erofs/super.c
> @@ -386,6 +386,7 @@ static void erofs_default_options(struct erofs_sb_inf=
o *sbi)
>  enum {
>  	Opt_user_xattr, Opt_acl, Opt_cache_strategy, Opt_dax, Opt_dax_enum,
>  	Opt_device, Opt_domain_id, Opt_directio, Opt_fsoffset, Opt_inode_share,
> +	Opt_source_fd,
>  };
> =20
>  static const struct constant_table erofs_param_cache_strategy[] =3D {
> @@ -413,6 +414,7 @@ static const struct fs_parameter_spec erofs_fs_parame=
ters[] =3D {
>  	fsparam_flag_no("directio",	Opt_directio),
>  	fsparam_u64("fsoffset",		Opt_fsoffset),
>  	fsparam_flag("inode_share",	Opt_inode_share),
> +	fsparam_fd("source",		Opt_source_fd),
>  	{}
>  };
> =20
> @@ -524,6 +526,11 @@ static int erofs_fc_parse_param(struct fs_context *f=
c,
>  		else
>  			set_opt(&sbi->opt, INODE_SHARE);
>  		break;
> +	case Opt_source_fd:
> +		if (sbi->dif0.file)
> +			return -EINVAL;
> +		sbi->dif0.file =3D get_file(param->file);
> +		break;

I don't think this handling is right for a few reasons:

 1. AFAICS this shadows the default "source" handling logic (because
    -ENOPARAM is not returned for the non-fd case), which means that
    this regresses existing erofs users -- everyone already uses
    "source" today. I must really be missing something if this worked
    when you tested it.

    Additionally, fsparam_fd unfortunately permits strings (where the
    string is the numerical value of the fd number), meaning that this
    will call get_file(<garbage>) if someone uses FSCONFIG_SET_STRING.
    You will need to check param->type at least to avoid that.

    I meant to send a patch for this earlier this year, but a nicer
    solution would be to have a custom helper similar to fs_lookup_param
    except that it permits FSCONFIG_SET_FD, FSCONFIG_SET_PATH,
    FSCONFIG_SET_PATH_EMPTY, and FSCONFIG_SET_STRING. This is sorely
    missing and people keep accidentally creating unusable interfaces as
    a result. I mentioned this in an LPC talk last year[1].

    proc_parse_pidns_param was my minimal version that only accepts
    FSCONFIG_SET_FD and FSCONFIG_SET_STRING, and if you don't want to
    add dirfd support yet then you should use something more like that.

 2. On a slightly less critical note, fc->source has special handling in
    the VFS in a few places and AFAICS this is the first example of
    someone adding an implementation of "source" that does not set
    fc->source to a proper value, which deserves some additional review.

    (At at quick glance it seems this just means that some stuff in
    procfs will show as "none" rather than fc->source debugging, but
    again it probably needs a closer look.)

[1]: https://youtu.be/NX5IzF6JXp0?t=3D72

--=20
Aleksa Sarai
Founding Engineer at Amutable
https://www.cyphar.com/

--i5hxj75u4eskqb5k
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iJEEABYKADkWIQS2TklVsp+j1GPyqQYol/rSt+lEbwUCalRvAxsUgAAAAAAEAA5t
YW51MiwyLjUrMS4xMiwyLDIACgkQKJf60rfpRG/kcQD+JC77qxpl/QwTgLzwoybn
nUi8Dq8fugnJpjdZLISEE+kBAN5kXLqQnmfO5oLeayumLCq0aLCpRkIXfGRSTgDP
76wF
=njuw
-----END PGP SIGNATURE-----

--i5hxj75u4eskqb5k--

