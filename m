Return-Path: <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>
X-Original-To: lists+linux-erofs@lfdr.de
Delivered-To: lists+linux-erofs@lfdr.de
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	by mail.lfdr.de (Postfix) with ESMTPS id C9EAB97E54B
	for <lists+linux-erofs@lfdr.de>; Mon, 23 Sep 2024 06:30:35 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=lists.ozlabs.org;
	s=201707; t=1727065831;
	bh=3rB2W6Lgz/pcqes322XxbpuIQPVMOz1AQp/A2mceDMo=;
	h=References:In-Reply-To:Date:Subject:To:List-Id:List-Unsubscribe:
	 List-Archive:List-Post:List-Help:List-Subscribe:From:Reply-To:Cc:
	 From;
	b=HxY/Xg4apxzAToALDWBdlhzdYt59ndieic1PYeV/xi2IG+fex1RSlaqNMZTxESJSB
	 C4NbQzjdUaKvL9H1njN3je08MtU5NA8o6rafMTICmnfTnw426E37w5zq7894fPKCBX
	 G1meYAyCazwb+G+jn0wva6BXkhv6KLJIXD58EM28n9yBsCq4J0Rtubp22yBPDIdJzg
	 9OMHjrp/ECaW66x9nTUoW89QN35JIRB82yBpK/IhQ3a39YHBG400Y+4oDHrxy1YRYi
	 W0efBl9uZIGChwaA8fpye8cp+A6c+CGb74h3oMbJ9KbivmgXldb9BsdToR4DrduFbo
	 VzetKLc3uHZuw==
Received: from boromir.ozlabs.org (localhost [IPv6:::1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4XBqmR1S0xz2yVj
	for <lists+linux-erofs@lfdr.de>; Mon, 23 Sep 2024 14:30:31 +1000 (AEST)
X-Original-To: linux-erofs@lists.ozlabs.org
Delivered-To: linux-erofs@lists.ozlabs.org
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip="2607:f8b0:4864:20::534"
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1727065829;
	cv=none; b=Hru46knPZ8u5UzwWru9hgY2Gv85RQemeJ5PVrZALl2Mrx5prU9zRRIrKPM1DXv2SVBdSSsP/GndIoSSrRrUGm94LWrC2E3GP4RZYvdsjWgQo7WpWOj2sQ0CO6nMtTliwkfz0MzoL4HVq7EE2pBSRGc/Wl2TegAfUQxALkGYcePG1fb+etZqZoU5Xi+AMEzPhgaRDE4Q5qK9v9Fn9QBxPHF2T7B6nI9dbBgrnuo5140BaRBf/8QiocU0Kt1GthD6uYynLaPyQZZC29FG4C0hUAtlfmH//MM1lL/em7HEoAUbPYGv86vB1PLDA49RdvKvEgvb3D37OkCVRS1J4AiHztQ==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1727065829; c=relaxed/relaxed;
	bh=3rB2W6Lgz/pcqes322XxbpuIQPVMOz1AQp/A2mceDMo=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=E8NFrtv3UqIttCS+2kFyk+N3wDR9mYIYBenHek//c9Q/qKMma6MdA9PRPFZN0XUnJMnAS9atdz+6GjB7lxPedn6uJKibogidi9XPdvb9r9ZKw/yX+1QW99EroAZLwNV8YbhYuB66BItm5tIYyZQHCiTaiVKcKLpYT2Wwb31kFFGOpf3rv5xUCOkj+thHoJagCvunGtK+ZGsYybWEBXJATCmwFFWA8Lwhe3ZgzwrBo/yrEFT1qXHrYvIm7nWy0fT5Fkpl0kNQDaYWqhYxsyd58A8R61c5ymJd+catrSAYqvCRpzXVH+FVVwp1cI0EWbsbN57ADQ+10beRTtCwX+FVUA==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=reject dis=none) header.from=orbstack.dev; dkim=pass (2048-bit key; secure) header.d=orbstack.dev header.i=@orbstack.dev header.a=rsa-sha256 header.s=google header.b=KpmY4c0q; dkim-atps=neutral; spf=pass (client-ip=2607:f8b0:4864:20::534; helo=mail-pg1-x534.google.com; envelope-from=danny@orbstack.dev; receiver=lists.ozlabs.org) smtp.mailfrom=orbstack.dev
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=reject dis=none) header.from=orbstack.dev
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; secure) header.d=orbstack.dev header.i=@orbstack.dev header.a=rsa-sha256 header.s=google header.b=KpmY4c0q;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=orbstack.dev (client-ip=2607:f8b0:4864:20::534; helo=mail-pg1-x534.google.com; envelope-from=danny@orbstack.dev; receiver=lists.ozlabs.org)
Received: from mail-pg1-x534.google.com (mail-pg1-x534.google.com [IPv6:2607:f8b0:4864:20::534])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4XBqmN6H2Nz2xGr
	for <linux-erofs@lists.ozlabs.org>; Mon, 23 Sep 2024 14:30:27 +1000 (AEST)
Received: by mail-pg1-x534.google.com with SMTP id 41be03b00d2f7-7cf5e179b68so3177200a12.1
        for <linux-erofs@lists.ozlabs.org>; Sun, 22 Sep 2024 21:30:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=orbstack.dev; s=google; t=1727065824; x=1727670624; darn=lists.ozlabs.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=3rB2W6Lgz/pcqes322XxbpuIQPVMOz1AQp/A2mceDMo=;
        b=KpmY4c0qFqUJM9pqZNrnUDFc2HiXzrofyFpk/LajEFkTBKPzpb8LmWYe1wNNfd3sWc
         g+K5ZgSyUgD4WZM9MmhuiY9qDYvJbx1REKWsMGBwld51ahmUKxHrGvePPthTbettKVOn
         hX9ptAPQjzSlpNI68CS/PVhhfPbP34TN7yivpSLtPpewYjRzha8TQcQM36xF0G2XHP0I
         taCUyaDXsgcSnLiC6ziqvuGrSjeh9qWMwo5VUL/5HYXVrs2nLIwJtWuWDgAdK7enKl0n
         BhWqpYlpnsMxyOPMppwFOJDHCcQYmMDmgqxK96EnSIO2V2XyvsvW9u3Ohd5nZOYNwVdN
         N/6g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1727065824; x=1727670624;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=3rB2W6Lgz/pcqes322XxbpuIQPVMOz1AQp/A2mceDMo=;
        b=v2BhdTQkDaS5a4N4a/8EX5erEJvJNsLRpv3YvQQdoa3cUx7EC3NGKtQaOCpRVyXl05
         AzXNxA3iTyXVd4EwdOrMTrso9s6Vrs4fkW8SFQJQynrVGqaaZyxsR1HJ/XCmYz77KD5/
         hwYqYNWGIJhoVTiJiEAq0RajsgK85POH7qcVwP7i1R+Wp4zKpbpWvZWviPl2sOZUWV7G
         Z7tH0cEqCCWIRu0siMX+MFZ286OdWe7RaKU692VJ+mEvq67R/omM94ekIQIspr7dl1QR
         YSZAszVE22OdhPx+t6AHRIxHiaY6ajyYHpU4NKSUEknyfdYm2nunmF7oZ+emFci8TWdO
         pepA==
X-Gm-Message-State: AOJu0YwGFCwqk07xJIu6jd5iYCMM4GQ2Tpak5tsor2szOIJtDxHp85ei
	Ypf5D3p27LyTYC5AH4C2dkgirL6sbxWpj4ANzpqip4Y1sUsnrXPP9hs7NxFsfW0t+KeIq1STxWt
	ex5YnO1iWlInNifEuNsQkCKnw7e86XlqSaaVuuA==
X-Google-Smtp-Source: AGHT+IHPNjhlX7GsofHKO2cVHNyNNiv1hhQElUDVhXZkvYbYw8UZjFgKF10OxEWustcMz/qaZjOQY8De4MBVgbG5hoc=
X-Received: by 2002:a05:6a20:e687:b0:1c0:f114:100c with SMTP id
 adf61e73a8af0-1d30a9ab6f5mr16218660637.17.1727065824487; Sun, 22 Sep 2024
 21:30:24 -0700 (PDT)
MIME-Version: 1.0
References: <20240916073835.77470-1-danny@orbstack.dev> <CAEFvpLe92-nS+4zOv5a=UOMW2whBtsGZ98D_MHv+x_KujEaroQ@mail.gmail.com>
 <63307dbc-da27-42e6-86fb-ed446f04ede5@linux.alibaba.com> <2ada73ab-66c2-437c-bbc2-fd07cb42c265@linux.alibaba.com>
In-Reply-To: <2ada73ab-66c2-437c-bbc2-fd07cb42c265@linux.alibaba.com>
Date: Sun, 22 Sep 2024 21:30:13 -0700
Message-ID: <CAEFvpLcEKEhRVCDggHbmFeFJQqte_8BWAyc-40e4TZJPEQTUhA@mail.gmail.com>
Subject: Re: [PATCH] erofs-utils: lib: fix compressed packed inodes
To: Gao Xiang <hsiangkao@linux.alibaba.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
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
From: Danny Lin via Linux-erofs <linux-erofs@lists.ozlabs.org>
Reply-To: Danny Lin <danny@orbstack.dev>
Cc: linux-erofs@lists.ozlabs.org
Errors-To: linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org
Sender: "Linux-erofs" <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>

On Sun, Sep 22, 2024 at 8:03=E2=80=AFPM Gao Xiang <hsiangkao@linux.alibaba.=
com> wrote:
>
> Hi Danny,
>
> On 2024/9/23 08:08, Gao Xiang wrote:
> > Hi Danny,
> >
> > Thanks for the patch!
> > Sorry I somewhat missed the previous email..
> >
> > On 2024/9/22 13:08, Danny Lin wrote:
> >> Gentle bump =E2=80=94 let me know if anything needs to be changed!
> >
> > Does the following change resolve the issue too?

Thanks for the suggestion. I tried your patch and it segfaults instead.

From a quick glance at the surrounding code, it doesn't seem correct
because the calls to erofs_prepare_inode_buffer and
erofs_write_tail_end are skipped if ret =3D=3D 0.

> >
> > Also I think it
> > Fixes: 2fdbd28ad4a3 ("erofs-utils: lib: fix uncompressed packed inode")

Ah, nice catch. Do you want me to resubmit or will you fix it when
applying the patch?

> >
> > @@ -1927,7 +1926,7 @@ struct erofs_inode *erofs_mkfs_build_special_from=
_fd(struct erofs_sb_info *sbi,
> >
> >                  DBG_BUGON(!ictx);
> >                  ret =3D erofs_write_compressed_file(ictx);
> > -               if (ret && ret !=3D -ENOSPC)
> > +               if (ret !=3D -ENOSPC)
> >                           return ERR_PTR(ret);
> >
> >                  ret =3D lseek(fd, 0, SEEK_SET);
>
> Add some more words, I'm on releasing erofs-utils 1.8.2
> this week.
>
> So if the diff above also fixes the issue, could you
> submit a patch for this so I could merge in time?
>
> Thanks,
> Gsao Xiang
>
> >
> > Thanks,
> > Gao Xiang
> >
> >>
> >> Thanks,
> >> Danny
>

Thanks,
Danny
