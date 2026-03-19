Return-Path: <linux-erofs+bounces-2858-lists+linux-erofs=lfdr.de@lists.ozlabs.org>
Delivered-To: lists+linux-erofs@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id CFWLCMgcvGlEsQIAu9opvQ
	(envelope-from <linux-erofs+bounces-2858-lists+linux-erofs=lfdr.de@lists.ozlabs.org>)
	for <lists+linux-erofs@lfdr.de>; Thu, 19 Mar 2026 16:56:56 +0100
X-Original-To: lists+linux-erofs@lfdr.de
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	by mail.lfdr.de (Postfix) with ESMTPS id 3684D2CE1CE
	for <lists+linux-erofs@lfdr.de>; Thu, 19 Mar 2026 16:56:55 +0100 (CET)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4fc9LD6DlYz2ypW;
	Fri, 20 Mar 2026 02:56:52 +1100 (AEDT)
X-Original-To: linux-erofs@lists.ozlabs.org
Authentication-Results: lists.ozlabs.org; arc=pass smtp.remote-ip="2607:f8b0:4864:20::62d" arc.chain=google.com
ARC-Seal: i=2; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1773935812;
	cv=pass; b=AVCYoUOaWQdmS8A3vFcP+lIpjijkEBfEfFioXR10u+wdEGD3vgpL0iXEKQptXO2ugFGo7m2D2wNFO2KO/+mNz6U2x5varYZgDkgBd1Tthj4M6Y0ddcr5aOb7XLvUkPlYOrVmlnrmq+g+z2hwSekBJcCjP2a09sGDCs0javHHdYvLSJql0jAnQGmL6R0ZwumRby/GpAqbOw9KJIXBIIoz6DsSCKxalieO69pX6M5rEfjGxxoa7xhu0ZKAkflSkwkGKklp2p8qo9zsb3C1V9OsMtAhUyUlR4IM8aBmxo3bsEbSid8SXdh6ok5BW2s6gKxoE6unQ1iyBqez6og+bcWBvw==
ARC-Message-Signature: i=2; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1773935812; c=relaxed/relaxed;
	bh=TpNQ4RrfxDr8OIdp6sqWlPi70JqpMY9icBlXfAIsbA8=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=RWveZdEJkg+x4IFNlXpqLM2k2TiO+iWCRA21ddh3ln4JFn2lnSUYgG0yD6jknr0QLpQPfFNCRLlumHr5tSFyXgmmHB9bLphOD3SHU0jPHTo/BmU1r+CKc74nII7nr+h0+WbP/Vx6tYPSjucN5SWSkL1T8FfRKXwX/tiny8LxfSV7nWRlRAIrw/TDpacth5+2vfhEdN2zbrtw9GUEZAXvQdNRQRZ81Smvxo95BamvP6RfZpX/an34HSZzC46cR3ZRAlXb5ld6E33Lpzjf9ea0fkq0KlOZOxvLMFDp5BCwZxz3m9cm+MONmoSFpjR8F1yNva39MMDhyk+Q617Ylh4euw==
ARC-Authentication-Results: i=2; lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=paul-moore.com; dkim=pass (2048-bit key; unprotected) header.d=paul-moore.com header.i=@paul-moore.com header.a=rsa-sha256 header.s=google header.b=FK+/HmKL; dkim-atps=neutral; spf=pass (client-ip=2607:f8b0:4864:20::62d; helo=mail-pl1-x62d.google.com; envelope-from=paul@paul-moore.com; receiver=lists.ozlabs.org) smtp.mailfrom=paul-moore.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=paul-moore.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=paul-moore.com header.i=@paul-moore.com header.a=rsa-sha256 header.s=google header.b=FK+/HmKL;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=paul-moore.com (client-ip=2607:f8b0:4864:20::62d; helo=mail-pl1-x62d.google.com; envelope-from=paul@paul-moore.com; receiver=lists.ozlabs.org)
Received: from mail-pl1-x62d.google.com (mail-pl1-x62d.google.com [IPv6:2607:f8b0:4864:20::62d])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4fc9LD0nNnz2ynv
	for <linux-erofs@lists.ozlabs.org>; Fri, 20 Mar 2026 02:56:51 +1100 (AEDT)
Received: by mail-pl1-x62d.google.com with SMTP id d9443c01a7336-2aecefc7503so6324275ad.1
        for <linux-erofs@lists.ozlabs.org>; Thu, 19 Mar 2026 08:56:51 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1773935810; cv=none;
        d=google.com; s=arc-20240605;
        b=KUzYNIsZGSweNkJCHyA0RScULsOlpVzU8r/t9vTsvK2RNyKRqwSk8myWmTZ3vlJ+Bz
         bxbYULvNQ2BGE7G2ZNw5XQY2+BrQL3wXU5H92KnTETF2hofQK/7Mp3Udb2sg4b28KzeW
         Lxwkxlz4ETBSYSCJZ+NONFChKYfU6z/MCQBWydMCu6A/wZedeFts4Iuda9HlRrwcFK8s
         r4HETWd9E4XV3HFEJAaMEi5VIfjR+bScNIqdB1lDpcFUN3SM981e+WmhmbmNWmjtudt/
         dYF/fNDb857dX2wpGKL8SNPU3sBwq8eE+Y4zPeVDBISGOzRvxWm1+IDYbkAPVylD8zAC
         Is5Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=TpNQ4RrfxDr8OIdp6sqWlPi70JqpMY9icBlXfAIsbA8=;
        fh=yCPXORj1I5VfFMQrQboK1s8KJm9bv2QThwIjw9P0F30=;
        b=lIzoIRpM+9mKEbRtEX0kBIgwTspprCYG6l0I54OkJh/S6yTFgx8i8UMWPcevAHQPax
         VCm0Fs5k2wBSp31MDu7IcBOPbTM4qoaPI6ibiNryyhHf87WIcdnMSAV1RxPh/CBh9ZT+
         69EKONu/7SJISiAY+8z3n6zva89RjbguzOw7K2gDOSku3Le2oC0dJMtLHwYjkruLTP/o
         zQ0rdHPG5pCth/WiUQlGw22V/U2IrpxOKpDcoEmxLahKzDohZM4qpC2Rvf+MFh65T9lH
         ddwGdUYLeBpqFMgJb4KQa4iHLRyW2bupUB9AvguA9sUhDjKowz7FsGo1qf7kRET+zZWe
         xPUw==;
        darn=lists.ozlabs.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=paul-moore.com; s=google; t=1773935810; x=1774540610; darn=lists.ozlabs.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=TpNQ4RrfxDr8OIdp6sqWlPi70JqpMY9icBlXfAIsbA8=;
        b=FK+/HmKLovfoaN/oaxk3FgfFKEsX2dsDsNd+u20REna22qcjyPBwMLQARP8va6tvpZ
         yO8dswpE4+55vXGLDHr12y5B+Q73tmq4PHoaCTjLXH5XJbEPGByCA2nkTmfFdOyGjiS1
         TVkY9rkm9AP4/PjJB1kE1VeteCNj8Q/SDXI14B3P3IwRnqhqpxObt+htiGkDbLDznScy
         cTbTytEvn1+LyKu1ZMXRZgl//bTOKVlxj9ARWUh2SF1lC3WRCUnakQgjFd4mKWGs+ZhE
         LB1s8SNDyWRuZAhGyjBXgSTHncx6NGCSAFjb26JPEYv5bLIhD0AaJBvx6o3sj6W72tLo
         objw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1773935810; x=1774540610;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=TpNQ4RrfxDr8OIdp6sqWlPi70JqpMY9icBlXfAIsbA8=;
        b=SI1nSX0b1JaNpWm4cc1J4hPgmQOwLkXnw6RdiHe2iYBPjBioZRZHj6U2XlBUz5YaGk
         /AR+1SArcFZFKBQ9Ao9cHn2JLK9Ve0snHiCI5/OfOEsYsbk830MkTy2/CaYvKZh6lc56
         sJP5DnyvKl5S1MJK+LuwVoqY68kxVTDcbL0SJoiLJapJ02fiL6Q9No5sNuVjsiLSDTGu
         3r6RJFcQSEFO8ApIRHB+9Q1WKfj+TEF+M9JpjwajkLUbiOEsctmgjYH5XCMDajsRsdOd
         6hTxWSSjOsoEoT0SdxvKwltVvcPkVteWWWXz9YiekPNf0/YcwBOS+VUZUsSh9H1/9MSO
         1Oew==
X-Forwarded-Encrypted: i=1; AJvYcCXMrepuBeVf5kPltd59NcJg17E/DWuB7ELBH/CVLafu46kzWX8pIBiChz7ELjP33RmRkqyKseaNHU3f0g==@lists.ozlabs.org
X-Gm-Message-State: AOJu0Yz0g5vwepEPtPjyofLt7JzIEQgpFOqzAcdxHrWtWociM0EO9g3X
	Sr84N4oaiDZ0TRNR6n65i++CUxpO/FDNf8ELHDgwV0IzKRADY2eWSIJj7ac3A95x4iLxr5p2HVZ
	OmzZ8RtNiQtNee3/i5wU6OgO7buZ4yduJ0w3yAunJ
X-Gm-Gg: ATEYQzzOYfv8OJS/1+Sr52KHDpk/eaOoLDFwzTv1/GP2yzpd/HJoAWnDq1iTdpwixTl
	3Ew32Kc6UhoSahToM6kwPPRROsanapQRmlsj6eT1c8BiqgGdqt1VhlZf09garhTISlnAw8nO6UF
	K3j5W0LjjKnlPtEXDUJ7dFM05hqCSK9hgakmU1X4xkQtp6RBWGapN4Wt5SEz0kaM9DWsgUYbX58
	9LuREmcm1e5oJSiVSlo/NhpNZ+RPAk+rm9AM640tfh5B2YSyIyqCrXQ2NgsmU/MuR8nbpSqpvMO
	kknW25Q=
X-Received: by 2002:a17:903:1c3:b0:2ae:478f:2ec with SMTP id
 d9443c01a7336-2b06e3dd59emr76386305ad.29.1773935809817; Thu, 19 Mar 2026
 08:56:49 -0700 (PDT)
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
 <CAOQ4uxj8SZqaFbrVifw0uw7skbUvJP1_nLWj4PYCeZuaLy5t_A@mail.gmail.com>
In-Reply-To: <CAOQ4uxj8SZqaFbrVifw0uw7skbUvJP1_nLWj4PYCeZuaLy5t_A@mail.gmail.com>
From: Paul Moore <paul@paul-moore.com>
Date: Thu, 19 Mar 2026 11:56:37 -0400
X-Gm-Features: AaiRm50nhjVBL81kDULwvCn8PsB2aebm_MIqZayk9nG17bPp4IlB5KlFJeWc6p4
Message-ID: <CAHC9VhTXfiENo3MVSv+LZFx4VJGTDqErMBKx0wx+jKNOc=NjSQ@mail.gmail.com>
Subject: Re: [PATCH v6] backing_file: store user_path_file
To: Amir Goldstein <amir73il@gmail.com>
Cc: Christian Brauner <brauner@kernel.org>, Miklos Szeredi <miklos@szeredi.hu>, Gao Xiang <xiang@kernel.org>, 
	linux-security-module@vger.kernel.org, selinux@vger.kernel.org, 
	linux-erofs@lists.ozlabs.org, linux-fsdevel@vger.kernel.org, 
	linux-unionfs@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-0.2 required=3.0 tests=ARC_SIGNED,ARC_VALID,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
	SPF_HELO_NONE,SPF_PASS autolearn=disabled version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-25) on lists.ozlabs.org
X-Spamd-Result: default: False [-2.20 / 15.00];
	ARC_ALLOW(-1.00)[lists.ozlabs.org:s=201707:i=2];
	DMARC_POLICY_ALLOW(-0.50)[paul-moore.com,none];
	R_DKIM_ALLOW(-0.20)[paul-moore.com:s=google];
	R_SPF_ALLOW(-0.20)[+ip4:112.213.38.117:c];
	MAILLIST(-0.19)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	RCVD_COUNT_THREE(0.00)[3];
	FORGED_RECIPIENTS(0.00)[m:amir73il@gmail.com,m:brauner@kernel.org,m:miklos@szeredi.hu,m:xiang@kernel.org,m:linux-security-module@vger.kernel.org,m:selinux@vger.kernel.org,m:linux-erofs@lists.ozlabs.org,m:linux-fsdevel@vger.kernel.org,m:linux-unionfs@vger.kernel.org,s:lists@lfdr.de];
	FREEMAIL_TO(0.00)[gmail.com];
	FORGED_SENDER(0.00)[paul@paul-moore.com,linux-erofs@lists.ozlabs.org];
	MIME_TRACE(0.00)[0:+];
	TAGGED_FROM(0.00)[bounces-2858-lists,linux-erofs=lfdr.de];
	FORWARDED(0.00)[linux-erofs@lists.ozlabs.org];
	FORGED_SENDER_MAILLIST(0.00)[];
	FROM_HAS_DN(0.00)[];
	MISSING_XM_UA(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PREVIOUSLY_DELIVERED(0.00)[linux-erofs@lists.ozlabs.org];
	NEURAL_HAM(-0.00)[-0.992];
	FORGED_SENDER_FORWARDING(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[paul@paul-moore.com,linux-erofs@lists.ozlabs.org];
	DKIM_TRACE(0.00)[paul-moore.com:+];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	TAGGED_RCPT(0.00)[linux-erofs];
	RCPT_COUNT_SEVEN(0.00)[9];
	TO_DN_SOME(0.00)[];
	ASN(0.00)[asn:133159, ipnet:112.213.32.0/21, country:AU];
	DBL_BLOCKED_OPENRESOLVER(0.00)[mail.gmail.com:mid,lists.ozlabs.org:helo,lists.ozlabs.org:rdns,paul-moore.com:dkim,paul-moore.com:email,paul-moore.com:url]
X-Rspamd-Queue-Id: 3684D2CE1CE
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

On Thu, Mar 19, 2026 at 10:54=E2=80=AFAM Amir Goldstein <amir73il@gmail.com=
> wrote:
> On Thu, Mar 19, 2026 at 12:47=E2=80=AFAM Paul Moore <paul@paul-moore.com>=
 wrote:
> > On Wed, Mar 18, 2026 at 9:13=E2=80=AFAM Amir Goldstein <amir73il@gmail.=
com> wrote:
> > >
> > > Instead of storing the user_path, store an O_PATH file for the
> > > user_path with the original user file creds and a security context.
> > >
> > > The user_path_file is only exported as a const pointer and its refcnt
> > > is initialized to FILE_REF_DEAD, because it is not a refcounted objec=
t.
> > >
> > > The file_ref_init() helper was changed to accept the FILE_REF_ consta=
nt
> > > instead of the fake +1 integer count.
> > >
> > > Signed-off-by: Amir Goldstein <amir73il@gmail.com>
> > > ---
> > >
> > > Christian,
> > >
> > > My v5 patch was sent by Paul along with his LSM/selinux pataches [1].
> > > Here are the changes you requested.
> > >
> > > I removed the ACKs and Tested-by because of the changes.
> > >
> > > Thanks,
> > > Amir.
> > >
> > > Changes since v5:
> > > - Restore file_ref_init() helper without refcnt -1 offset
> > > - Future proofing errors from backing_file_open_user_path()
> > >
> > > [1] https://lore.kernel.org/r/20260316213606.374109-6-paul@paul-moore=
.com/
> > >
> > >  fs/backing-file.c            | 26 ++++++++++--------
> > >  fs/erofs/ishare.c            | 13 +++++++--
> > >  fs/file_table.c              | 53 ++++++++++++++++++++++++++++------=
--
> > >  fs/fuse/passthrough.c        |  3 +-
> > >  fs/internal.h                |  5 ++--
> > >  fs/overlayfs/dir.c           |  3 +-
> > >  fs/overlayfs/file.c          |  1 +
> > >  include/linux/backing-file.h | 29 ++++++++++++++++++--
> > >  include/linux/file_ref.h     |  4 +--
> > >  9 files changed, 103 insertions(+), 34 deletions(-)
> >
> > Still works for me.  I'm going to update lsm/stable-7.0 with this
> > patch so we can get some more linux-next testing.
> >
> > Tested-by: Paul Moore <paul@paul-moore.com>
> >
>
> Paul,
>
> As you saw, syzbot found a nasty bug in this patch and it is too hard
> to fix it without introducing more hazards.
>
> Therefore, per Christian's request I am withdrawing this patch.
>
> Please see compile tested alternative solution for selinux without
> intrusive vfs change at:
> https://github.com/amir73il/linux/commits/user_path_file/

Let's let this thread die in favor of the other.  I'll already
commented there, but the quick summary is that pushing the ugliness
into an individual LSM, or the LSM framework itself, is not a
solution.

--=20
paul-moore.com

