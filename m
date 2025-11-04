Return-Path: <linux-erofs+bounces-1349-lists+linux-erofs=lfdr.de@lists.ozlabs.org>
X-Original-To: lists+linux-erofs@lfdr.de
Delivered-To: lists+linux-erofs@lfdr.de
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	by mail.lfdr.de (Postfix) with ESMTPS id 9F0BBC30532
	for <lists+linux-erofs@lfdr.de>; Tue, 04 Nov 2025 10:45:59 +0100 (CET)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4d13VY3RK7z3bf8;
	Tue,  4 Nov 2025 20:45:57 +1100 (AEDT)
X-Original-To: linux-erofs@lists.ozlabs.org
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip="2a00:1450:4864:20::536"
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1762249557;
	cv=none; b=UY1pxWfcV6D2Ez2n6EjSskY9TyDP2EU38zJu+ah2hSUt63m3dZXOXEfg34ZnHea7LgN+C7yqsTOp3Pg7GUcQtIX2DQAppDgYQAJ86QKPrYHdoLcvM+GKoMXpjp6DLQqKpclLGbmxeyeMkvy0BU3w/suM36MMJgJ9fVf3gCdqm1izqaz90t3Z+fNvOMUyi//PvpTKakvlhWiCG5ufJdFNc8DW2hdw+MgOuTMsEb+5Cy/riXcKvkDIHZvOAlrZutvRzEqtJlHhcEhI07/TIXQEBGKtz0lFwLk5ZxioMdEd9hI0zq9VlfxjJHGTOnpxrH7UtXMjCaNgN0puTBFN/0bsGg==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1762249557; c=relaxed/relaxed;
	bh=xKJdWvkPbuojvyFkWrgOJDggLZVTca+r/oAisy+M4uA=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=e7SQ03c2JRDMIyz7z0NDKBErQIT+F9zAjDSmvjzZ02tdbEBju0iFobNbkB44Z1gHhZWdeXUzZtvkNgmdXIKEVd1w5mehdcDpPl0nA0/GelDyqIhd8VIJKN1AZKhx39f1uNsE2MDGQ5YMbdna9OPQKz6hsWig25+RlC0HZj1+nhz9cIXunn1hjvhxDj6u3QSmSUbDgN19/pTGoVjTam+zMzKYtqdfRHkaSUmZTW6RTdVBag+v7iunhQ5wYPmPp81Vddtkq6txLCxbfHphLTmU0Q/F0gXxoMaw90146ccUXCEsHnxanMNzC7vuAIbSw5qfNb8AeKFgLdGLN8deY4ZmoQ==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=gmail.com; dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20230601 header.b=HKjLub3l; dkim-atps=neutral; spf=pass (client-ip=2a00:1450:4864:20::536; helo=mail-ed1-x536.google.com; envelope-from=amir73il@gmail.com; receiver=lists.ozlabs.org) smtp.mailfrom=gmail.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20230601 header.b=HKjLub3l;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=gmail.com (client-ip=2a00:1450:4864:20::536; helo=mail-ed1-x536.google.com; envelope-from=amir73il@gmail.com; receiver=lists.ozlabs.org)
Received: from mail-ed1-x536.google.com (mail-ed1-x536.google.com [IPv6:2a00:1450:4864:20::536])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4d13VX3b5vz3bf3
	for <linux-erofs@lists.ozlabs.org>; Tue,  4 Nov 2025 20:45:55 +1100 (AEDT)
Received: by mail-ed1-x536.google.com with SMTP id 4fb4d7f45d1cf-63bea08a326so7583656a12.3
        for <linux-erofs@lists.ozlabs.org>; Tue, 04 Nov 2025 01:45:55 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1762249547; x=1762854347; darn=lists.ozlabs.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=xKJdWvkPbuojvyFkWrgOJDggLZVTca+r/oAisy+M4uA=;
        b=HKjLub3lCTVbV7XSRVyxuQOSqnt+Espqv5+HDjJYvf507By99rWgAj9Yg4e1c2YJB0
         Xa+Og7F/Cx+wcIemY9Pm0Hgbwfh+QXmxDc4oauFJ9SVrq3aRMCsUeVspJJaBeLVv4y31
         rSl78wWEgAVrvDDRz8zk82l51cJYTT/DM9EdDBRmuZJ782WmjMQkE8hacB0y/+Igpqmo
         39NyAKbdNAzAt3vi6z2cJe9HPpfEOC9dgHJczynhzmd/+cb6AQCARMdQWzxMp8VX4Cqc
         gJwqTSMWA75whV6Vgg9Wfqh6KeYFtnMQTGQLqW+UlvyC5ixXZ0KkVvM+xhK2OCUVtidd
         jl6A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1762249547; x=1762854347;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=xKJdWvkPbuojvyFkWrgOJDggLZVTca+r/oAisy+M4uA=;
        b=v0aXsHbGEb01zR9da6IDpJPC3Uj2E9XquM3jJ2k2S4e964fbTpBZg600r1QioEqLcF
         M/0jDCWDCeXCNsRed10kaCnzzplODSh4RtvTqzzvDHfKeYc4rLFt3Az1NGJTsLJAJ3Po
         MfYqDAJ/dujriakx7kcYdg3vNchEUG1Cy/TSP2ZBiaRDiBq6kmUUpKPO5MDHC25lQXwV
         XU++RXwVs/vk1ZXiqG815PufopxebdBgp1MZgLHtfa5KS04qBRKjn2GY4NK9SS+Nb1Ta
         Ry6pXsaZm74erkrja1ir5Kl19j3KdMMmuzpP9bYZXvwl70z8VfgS7kvTuPJYKE48sfC8
         5nMA==
X-Forwarded-Encrypted: i=1; AJvYcCVc4SkeAltel6o/ydGJlu84yw5ofCX2phB+jVPM/4/2hRwF/eojSymFEZ7ECN2QG72c2nYewtjDJWv5Ew==@lists.ozlabs.org
X-Gm-Message-State: AOJu0YyJqB8DeS8GppBysCpDCL36eUGdOBMAAQvH6gbWaN2TMoN1Kq/n
	XcHeMz94HpTKmjdCgVChydtFOOlRIEeanUMzi5O38wwQYq2hoxcFAhOaUD8HWyt6BaxG9Thh7ws
	AfL7fsSHVbfVwlHZGnkY5qaCTm+Rryk8=
X-Gm-Gg: ASbGncvM50XIlWIYR2/HJD6nKybjdX9W+YP0fEeVkgI0KpEqw+OrY84eMes8nnpb0dL
	OuXBfhKJ1LemmPCaZ2YshdwX7FmXk8l08AGa1CHTqYCe5iFOckND0bksvQkjZHecG4IpK4lDdjY
	VdYBZgWq+AoTP6Avb4D7hvyy7fIoEk/Q2ho2ZdiaQ74g7/szLY66tOabZz92ePfsqdrcV0fc5F9
	pUb/NJfT3yoYXnN2ZNyihBfhYlo8jUMoVUzxnyUO8cLRjHCulIn9o+ZuCfSWzg9QcFOMvOKsUwJ
	WckHMH2AzS9Saq3w8S4=
X-Google-Smtp-Source: AGHT+IHXA2qJBi6f10DqUtNaDt/G9hT+Ey8B/WnoFdz3Hmrh6KCUpLdIDtROPfgXbvSfxz+h0BRwI+TkCKOqKrtbbyk=
X-Received: by 2002:a05:6402:1462:b0:640:ea21:8bfd with SMTP id
 4fb4d7f45d1cf-640ea219598mr1427481a12.31.1762249547237; Tue, 04 Nov 2025
 01:45:47 -0800 (PST)
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
References: <20251103-work-creds-guards-simple-v1-0-a3e156839e7f@kernel.org>
 <20251103-work-creds-guards-simple-v1-14-a3e156839e7f@kernel.org> <CAHk-=wiSmez2LFEpM05VUX=_GKJC8Ag68TJDByVPO=x4QwjyuA@mail.gmail.com>
In-Reply-To: <CAHk-=wiSmez2LFEpM05VUX=_GKJC8Ag68TJDByVPO=x4QwjyuA@mail.gmail.com>
From: Amir Goldstein <amir73il@gmail.com>
Date: Tue, 4 Nov 2025 10:45:36 +0100
X-Gm-Features: AWmQ_bn9rw0ha0qFFSykU1xP6jfkkEMSMAVkMSHJG30ZX97XNHwd3yxbJVnihQI
Message-ID: <CAOQ4uxhw2Tc4YXwhkS=5EVC3Tg4F+QyrA7LE3V29pNhQ4WJeyA@mail.gmail.com>
Subject: Re: [PATCH 14/16] act: use credential guards in acct_write_process()
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: Christian Brauner <brauner@kernel.org>, linux-fsdevel@vger.kernel.org, 
	linux-kernel@vger.kernel.org, linux-aio@kvack.org, 
	linux-unionfs@vger.kernel.org, linux-erofs@lists.ozlabs.org, 
	linux-nfs@vger.kernel.org, linux-cifs@vger.kernel.org, 
	samba-technical@lists.samba.org, cgroups@vger.kernel.org, 
	netdev@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-0.2 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,RCVD_IN_DNSWL_NONE,
	SPF_HELO_NONE,SPF_PASS autolearn=disabled version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-25) on lists.ozlabs.org

On Tue, Nov 4, 2025 at 12:04=E2=80=AFAM Linus Torvalds
<torvalds@linux-foundation.org> wrote:
>
> On Mon, 3 Nov 2025 at 20:27, Christian Brauner <brauner@kernel.org> wrote=
:
> >
> >         /* Perform file operations on behalf of whoever enabled account=
ing */
> > -       cred =3D override_creds(file->f_cred);
> > -
> > +       with_creds(file->f_cred);
>
> I'd almost prefer if we *only* did "scoped_with_creds()" and didn't
> have this version at all.
>
> Most of the cases want that anyway, and the couple of plain
> "with_creds()" cases look like they would only be cleaned up by making
> the cred scoping more explicit.
>
> What do you think?

I had a similar reaction but for another reason.

The 'with' lingo reminds me of python with statement (e.g.
with open_file('example.txt', 'w') as file:), which implies a scope.
So in my head I am reading "with_creds" as with_creds_do.

Add to that the dubious practice (IMO) of scoped statements
without an explicit {} scope and this can become a source of
human brainos, but maybe the only problematic brain is mine..

Thanks,
Amir.

