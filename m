Return-Path: <linux-erofs+bounces-2856-lists+linux-erofs=lfdr.de@lists.ozlabs.org>
Delivered-To: lists+linux-erofs@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 8EVUKhoOvGlErwIAu9opvQ
	(envelope-from <linux-erofs+bounces-2856-lists+linux-erofs=lfdr.de@lists.ozlabs.org>)
	for <lists+linux-erofs@lfdr.de>; Thu, 19 Mar 2026 15:54:18 +0100
X-Original-To: lists+linux-erofs@lfdr.de
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2404:9400:21b9:f100::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 71B332CD3C1
	for <lists+linux-erofs@lfdr.de>; Thu, 19 Mar 2026 15:54:17 +0100 (CET)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4fc7xy7542z2ynv;
	Fri, 20 Mar 2026 01:54:14 +1100 (AEDT)
X-Original-To: linux-erofs@lists.ozlabs.org
Authentication-Results: lists.ozlabs.org; arc=pass smtp.remote-ip="2a00:1450:4864:20::62d" arc.chain=google.com
ARC-Seal: i=2; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1773932054;
	cv=pass; b=WH04ZvCDJ3n6C/nOBf5HM5+d/Xj5ag/I4wqB2c3PGU704Be7HvqP+KgeaGo+wESDTDpDpd7uC41AgQzwFvetDaccubTXBw62e2iMJXRTy/5nXYNoqph2OJ15VcCjKXUSubcTy3/ebB0hgLAISg/lLVctDHJgL4XVGCPhW6fuykxOHMwPqP03aYRcRlfUNg7n66isJVNXn2cJT/vdIb/Jc/Phtg+tTt5fhmJaPSp0CmIGW9BzT2JlBZUrrIa5TdjGuBbT5U8iLry0qLTCmjeYcGaq+5d7euStAkrzS72MP/3EYPuziXZI3MbAERpUvviWiCRSW7Q//jwHuG3zcsPJgA==
ARC-Message-Signature: i=2; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1773932054; c=relaxed/relaxed;
	bh=Jw0GH/4mNtxvnbd70gE+2uTwAn5ypE+g4jyg0EIdEpQ=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=R7EJiXPd0QfyuB8qEqxrxoyTgC2cXX6awLdpI2+bxKEeA2HsadTE4DXlw9F8Hhs5B8pTzXHF5F/izK/YsnO3AUsdUd2+opxyCaOj3nC5F7OW/NoSjRCuy5BQekiKZ/tJ74dxcSqr8R2OYaZ4ZJ0/MG46IEGu5w6ybsfnJgGjkJGu6To6de0XYTNxtrrMB/tahkHCcBQjjpGRUi+FOPPJHfYOrlBOezMKa70TzuA8NbvK1OOF7i9ebd+szwful89rekkKrhB07/h9nfcMJ8WGHEE1q6LgbQjpS78v4l8cWT7DXGuMoVU339ET1kJsNAveeI8yLTihn3fI7nJQEgNfgw==
ARC-Authentication-Results: i=2; lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=gmail.com; dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20230601 header.b=GlkMRaIA; dkim-atps=neutral; spf=pass (client-ip=2a00:1450:4864:20::62d; helo=mail-ej1-x62d.google.com; envelope-from=amir73il@gmail.com; receiver=lists.ozlabs.org) smtp.mailfrom=gmail.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20230601 header.b=GlkMRaIA;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=gmail.com (client-ip=2a00:1450:4864:20::62d; helo=mail-ej1-x62d.google.com; envelope-from=amir73il@gmail.com; receiver=lists.ozlabs.org)
Received: from mail-ej1-x62d.google.com (mail-ej1-x62d.google.com [IPv6:2a00:1450:4864:20::62d])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4fc7xx5z7dz2yng
	for <linux-erofs@lists.ozlabs.org>; Fri, 20 Mar 2026 01:54:13 +1100 (AEDT)
Received: by mail-ej1-x62d.google.com with SMTP id a640c23a62f3a-b96d784828bso143216566b.3
        for <linux-erofs@lists.ozlabs.org>; Thu, 19 Mar 2026 07:54:13 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1773932050; cv=none;
        d=google.com; s=arc-20240605;
        b=RyOQ9z4caBih53XuBfbtNIqrKTdoR5IQvlA1jq2ngoHqcQWchVhisbW47PytjHBHN1
         zq+NjQFWRE9OdGu9u5c5Y2KOnKn1r5nzoCgt3ExlEmU9rmFe5aQqliDHdiygygXNG/zH
         ZMPgIrtwTh14txAUt6MVKtmzF0XU9FbRsbWpkUvwJ1gSWOfXPLwBiQkUUEaGMwaQ5S5f
         35CWpFETZOk3XbwEzAZ+Kq33go9qdWmN0a6b3Djtf62rnW7cMQaEwYcvaTfHvx20lTcx
         AeAhh76phRLgxlFx+1nw2E0PTLCPnTIPLzASKB/HyEVrSbGkbnq9XtgOba8rSv5PsDs/
         qnog==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=Jw0GH/4mNtxvnbd70gE+2uTwAn5ypE+g4jyg0EIdEpQ=;
        fh=UBp4hiBkHxaBte4IxwA8CihTIsNMKvyoqSEh2gKL4nQ=;
        b=UgdzSO1sfwoe9gI2PT3Oq4ua8pX7b4xOWKyyJIhpc05hw/PLg4jRmE5XykqVtmSTtN
         srIi0E+7S9KgqFDJeXTJuqxrKgR+LzX/jezT8zB3UA9by2AvGyTnCIKmWZIokgNN1ruc
         QfrwkVOgHvfkv/4tNmVpn79pO1xv1XJw/7r7ubBkxq5lrf2Zd0MIjnT4D0IJdX78gfGe
         W+7bGVCF+rEWjt7/+erOfIBoVWzep1/cOl/QP+T3XrYBNCndvrvdiWm0gjHmoXNcbySV
         /irw9poUwym89AB9PubxDTv2UMbuP1sQO5Wm+T1F+lUfd9fBHWa0hCu5cNYiBEqkZmPP
         lukw==;
        darn=lists.ozlabs.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1773932050; x=1774536850; darn=lists.ozlabs.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Jw0GH/4mNtxvnbd70gE+2uTwAn5ypE+g4jyg0EIdEpQ=;
        b=GlkMRaIAhV2W2AZbuzqP8eb/TgisEfXY+FnOm1xqeeP1HL/mlKJ6nYC7M+gc5EcLPn
         31fDdsdwz5c2YO5d/ngrcqqscC0KZumOduBVbccpRLNMorcGEH1HPAWE1bfvwD00K3Dz
         i79gG95O+xTO5Pf54WMg6TcYZtUlU/ZnnoD8ghjmkkxK/mET/fD3oJMSOgftc/dZfVPb
         t4u32dYpD6VnPYYkZdwH41+JkFYVv33krtvaVnRgeYykBzIf+62Mp/Ocdey07gc0E2jx
         mv9DantD/vz7mu+DmoibxDPqFd0pR/ufLNSbwU0lhDLEIsr8AkgxkF2MBwOiB3mdhEfl
         n6iw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1773932050; x=1774536850;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=Jw0GH/4mNtxvnbd70gE+2uTwAn5ypE+g4jyg0EIdEpQ=;
        b=KmMTx7hXBZ5Q9rg3i6SvG8q+Ofw5rLB5W4rFjFLwgLrfO1U8efYJfsG6vNhpeVutBr
         mqk5CBGMTHQ0eqwo4h5EWQjCDUa/YGu9JoKH68yfO168eq5kkHsEN7y1oWbhe8GYziBn
         DNr1RflcfGXzL+5BCj/65l0nrV5ma7jCN/cCssZ9sB6LrsVZYovicypPtRSdRH9fiUEq
         v6+kEdUwgwlz0p65fUQYZKfBKCCctVrkOnz7Eq6dEX2tI1JXJyvthYMZ1Tz9VTQmHtQh
         SRcdyEHGU4syCGyJ6t+ibARg4NMg5GCAscY3v19DHLe/Z6K3N3SKA3lwU1Q5vc4kv9st
         wb1Q==
X-Forwarded-Encrypted: i=1; AJvYcCWJUDhFkp6f42J+wHqhSInRGECeIbn1fz0NJvD8VKy6Ue5ujae6M7jT+puN2QjtfqOcIEYdahxLxWMG/w==@lists.ozlabs.org
X-Gm-Message-State: AOJu0YxaBVIhTSKXlBIXN2mIWNFTOLcBxX42RD+oGy9eHU3QsaSia5ja
	p7NWXDD5xGiZTg9kgPv1C8OL0UGgAwUzAxYsE22yQW+Gwt8FtzjsSTjF9HHSX5W5E+n264cODhW
	VH/9c0bNj367xj6/+/lRNE5GiWbol+eA=
X-Gm-Gg: ATEYQzwspCOF9WXtRnefKupUGDxJ0kTCQOKZMISvjnlu3opaMeQUL5W0fNaqpEOg1cz
	RMCzufU9ZgiZkdu1I/f5/O/IR1jkdkHxC302tw6xkpLkysUb8oBMzMaNjYnhCHfz5jnn11PVqc5
	hL2aQB201EA4v9f7RXBdHSlJpllDCsUD9k7na5MIkzOBvGpq8X4Vj9NSw05y5PLZACKqOek7hwO
	k8w6HoRoGiJcrfBvCMpuRGpBOYV+tiWCK/bbdPZY30AZdCyfaEXr4mXVp5zVWZ5wPY1Z8VWVv1S
	d9x9U9GoTq5VqUIwCqwBW1qX5BUwfsjbvMY6U2jJHtzque8Ao2rX
X-Received: by 2002:a17:906:945:b0:b97:d76f:3790 with SMTP id
 a640c23a62f3a-b97f4948e4dmr422735566b.24.1773932049652; Thu, 19 Mar 2026
 07:54:09 -0700 (PDT)
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
References: <20260318131258.1457101-1-amir73il@gmail.com> <CAHC9VhTKvOzMS2ZyawE=qBN-EpyucfxvwcHZYjXF5zugRhE2rw@mail.gmail.com>
In-Reply-To: <CAHC9VhTKvOzMS2ZyawE=qBN-EpyucfxvwcHZYjXF5zugRhE2rw@mail.gmail.com>
From: Amir Goldstein <amir73il@gmail.com>
Date: Thu, 19 Mar 2026 15:53:58 +0100
X-Gm-Features: AaiRm53ob940soSsJtP2tgmiMXVCsKvszmwMYDw08PfOi4CUawSVTSX4zhGKxzI
Message-ID: <CAOQ4uxj8SZqaFbrVifw0uw7skbUvJP1_nLWj4PYCeZuaLy5t_A@mail.gmail.com>
Subject: Re: [PATCH v6] backing_file: store user_path_file
To: Paul Moore <paul@paul-moore.com>
Cc: Christian Brauner <brauner@kernel.org>, Miklos Szeredi <miklos@szeredi.hu>, Gao Xiang <xiang@kernel.org>, 
	linux-security-module@vger.kernel.org, selinux@vger.kernel.org, 
	linux-erofs@lists.ozlabs.org, linux-fsdevel@vger.kernel.org, 
	linux-unionfs@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-0.2 required=3.0 tests=ARC_SIGNED,ARC_VALID,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
	RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=disabled
	version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-25) on lists.ozlabs.org
X-Spamd-Result: default: False [-2.20 / 15.00];
	ARC_ALLOW(-1.00)[lists.ozlabs.org:s=201707:i=2];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20230601];
	R_SPF_ALLOW(-0.20)[+ip6:2404:9400:21b9:f100::1:c];
	MAILLIST(-0.19)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FROM_HAS_DN(0.00)[];
	TAGGED_FROM(0.00)[bounces-2856-lists,linux-erofs=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FORGED_RECIPIENTS(0.00)[m:paul@paul-moore.com,m:brauner@kernel.org,m:miklos@szeredi.hu,m:xiang@kernel.org,m:linux-security-module@vger.kernel.org,m:selinux@vger.kernel.org,m:linux-erofs@lists.ozlabs.org,m:linux-fsdevel@vger.kernel.org,m:linux-unionfs@vger.kernel.org,s:lists@lfdr.de];
	FORGED_SENDER(0.00)[amir73il@gmail.com,linux-erofs@lists.ozlabs.org];
	FORGED_SENDER_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	RCVD_COUNT_THREE(0.00)[3];
	MIME_TRACE(0.00)[0:+];
	FORWARDED(0.00)[linux-erofs@lists.ozlabs.org];
	DKIM_TRACE(0.00)[gmail.com:+];
	MISSING_XM_UA(0.00)[];
	FREEMAIL_FROM(0.00)[gmail.com];
	PREVIOUSLY_DELIVERED(0.00)[linux-erofs@lists.ozlabs.org];
	NEURAL_HAM(-0.00)[-0.954];
	FORGED_SENDER_FORWARDING(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[amir73il@gmail.com,linux-erofs@lists.ozlabs.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	MID_RHS_MATCH_FROMTLD(0.00)[];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	RCPT_COUNT_SEVEN(0.00)[9];
	ASN(0.00)[asn:133159, ipnet:2404:9400:2000::/36, country:AU];
	TAGGED_RCPT(0.00)[linux-erofs];
	DBL_BLOCKED_OPENRESOLVER(0.00)[lists.ozlabs.org:helo,lists.ozlabs.org:rdns,mail.gmail.com:mid]
X-Rspamd-Queue-Id: 71B332CD3C1
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

On Thu, Mar 19, 2026 at 12:47=E2=80=AFAM Paul Moore <paul@paul-moore.com> w=
rote:
>
> On Wed, Mar 18, 2026 at 9:13=E2=80=AFAM Amir Goldstein <amir73il@gmail.co=
m> wrote:
> >
> > Instead of storing the user_path, store an O_PATH file for the
> > user_path with the original user file creds and a security context.
> >
> > The user_path_file is only exported as a const pointer and its refcnt
> > is initialized to FILE_REF_DEAD, because it is not a refcounted object.
> >
> > The file_ref_init() helper was changed to accept the FILE_REF_ constant
> > instead of the fake +1 integer count.
> >
> > Signed-off-by: Amir Goldstein <amir73il@gmail.com>
> > ---
> >
> > Christian,
> >
> > My v5 patch was sent by Paul along with his LSM/selinux pataches [1].
> > Here are the changes you requested.
> >
> > I removed the ACKs and Tested-by because of the changes.
> >
> > Thanks,
> > Amir.
> >
> > Changes since v5:
> > - Restore file_ref_init() helper without refcnt -1 offset
> > - Future proofing errors from backing_file_open_user_path()
> >
> > [1] https://lore.kernel.org/r/20260316213606.374109-6-paul@paul-moore.c=
om/
> >
> >  fs/backing-file.c            | 26 ++++++++++--------
> >  fs/erofs/ishare.c            | 13 +++++++--
> >  fs/file_table.c              | 53 ++++++++++++++++++++++++++++--------
> >  fs/fuse/passthrough.c        |  3 +-
> >  fs/internal.h                |  5 ++--
> >  fs/overlayfs/dir.c           |  3 +-
> >  fs/overlayfs/file.c          |  1 +
> >  include/linux/backing-file.h | 29 ++++++++++++++++++--
> >  include/linux/file_ref.h     |  4 +--
> >  9 files changed, 103 insertions(+), 34 deletions(-)
>
> Still works for me.  I'm going to update lsm/stable-7.0 with this
> patch so we can get some more linux-next testing.
>
> Tested-by: Paul Moore <paul@paul-moore.com>
>

Paul,

As you saw, syzbot found a nasty bug in this patch and it is too hard
to fix it without introducing more hazards.

Therefore, per Christian's request I am withdrawing this patch.

Please see compile tested alternative solution for selinux without
intrusive vfs change at:
https://github.com/amir73il/linux/commits/user_path_file/

Thanks,
Amir.

