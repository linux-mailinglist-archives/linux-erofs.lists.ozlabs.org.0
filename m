Return-Path: <linux-erofs+bounces-2846-lists+linux-erofs=lfdr.de@lists.ozlabs.org>
Delivered-To: lists+linux-erofs@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 8LVmFiXZu2k6pAIAu9opvQ
	(envelope-from <linux-erofs+bounces-2846-lists+linux-erofs=lfdr.de@lists.ozlabs.org>)
	for <lists+linux-erofs@lfdr.de>; Thu, 19 Mar 2026 12:08:21 +0100
X-Original-To: lists+linux-erofs@lfdr.de
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2404:9400:21b9:f100::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 65A6A2CA11A
	for <lists+linux-erofs@lfdr.de>; Thu, 19 Mar 2026 12:08:20 +0100 (CET)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4fc2xF4xFJz2ynW;
	Thu, 19 Mar 2026 22:08:17 +1100 (AEDT)
X-Original-To: linux-erofs@lists.ozlabs.org
Authentication-Results: lists.ozlabs.org; arc=pass smtp.remote-ip="2607:f8b0:4864:20::f33" arc.chain=google.com
ARC-Seal: i=2; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1773918497;
	cv=pass; b=Te+qIiLwp1atyYJcuv7t9hi7ZarpUjP+TctW97YMkkcaG4EQwmUXUswQfNyT74LaO1SJDFZNH2I1vLuufE/+OMGf5mRWG9bNbNoEZzAS0nDjiE4VibBY+TJR2p6nvP7aVyT/ib+oFggpPgs+zqixxsyXSfnF+5Aftuftk+2116IEJxRJ0u5CY9uEvubEV3cLwSxg6GuaKLG7vdkB37WoF3N2ILVA7rVPVtc0N9oSfdevoMEJgRW7g02e/DYy8rUOttbU98dPpEy/mVbcazL7+2KAZwW66TjutD89xgY6qmIk6S/68riUKrp6uZp6gl5kNFmniNlcSsWGPJ3G7DAMEg==
ARC-Message-Signature: i=2; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1773918497; c=relaxed/relaxed;
	bh=mgSSxNlilEyRbvJ/Dl1SRHIVHwdCoXHiogp/tKM1mPU=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=QaIoKmdfN7PrAAhLo3RnMgckYClsXq82ZKbhPON33f8fALqfAYESS61r8D5jYPpmyE+PL1G13e/7zcX++W8opUnZNCnoyDMxg8aBIA4j53lXe4wD5evrHusQt9A45Ewi6K8lRLsG39MjmEKJO3L1FoVR42Hiz0p9YOhnlRqk2omJg6diFhg7EfG7KnDx9Pks5Y9z3X8Y+DH4gCiYmq02vX64dQ6w/1pEJ7eQlab6UBXx/hS/QHG/qf4SrXDfvr76HP5ttT8f+yKMoy6OP1xZ9SbY9UgEBOWnE3EP6Mg9Rlk/z5UieTsZmGIhLkQ+EldN9AZjomKKs6Lnij2mTsjbMA==
ARC-Authentication-Results: i=2; lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=gmail.com; dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20230601 header.b=NzAfLg2Z; dkim-atps=neutral; spf=pass (client-ip=2607:f8b0:4864:20::f33; helo=mail-qv1-xf33.google.com; envelope-from=singhutkal015@gmail.com; receiver=lists.ozlabs.org) smtp.mailfrom=gmail.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20230601 header.b=NzAfLg2Z;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=gmail.com (client-ip=2607:f8b0:4864:20::f33; helo=mail-qv1-xf33.google.com; envelope-from=singhutkal015@gmail.com; receiver=lists.ozlabs.org)
Received: from mail-qv1-xf33.google.com (mail-qv1-xf33.google.com [IPv6:2607:f8b0:4864:20::f33])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4fc2xD4HWJz2ySj
	for <linux-erofs@lists.ozlabs.org>; Thu, 19 Mar 2026 22:08:15 +1100 (AEDT)
Received: by mail-qv1-xf33.google.com with SMTP id 6a1803df08f44-899f50ab3f2so1158296d6.0
        for <linux-erofs@lists.ozlabs.org>; Thu, 19 Mar 2026 04:08:15 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1773918494; cv=none;
        d=google.com; s=arc-20240605;
        b=MJp5EVVX4CN7vUTEtdOqCxUis/vrowGJdmV1VH+XCdzDtrslg3E2Rbrmt6fVgjWC0W
         bMcVhMAaFcE3U7pJy8O75E7rU9lQ3oxZiq+mAXlET73xAw4v0cSaudYOEuVc9qYkr5TI
         gEbx3jPshaKRp+uhO4i+yLjw6PtSwkTjkJA4amglIz5AZxTiDLss5g3crnuQ7hUdFY5f
         /4/EZ3jiMTWLcDsxpiw2yrENPFMoDo95QsAID4Rrr/9jMlEcZHMIqOtEoyOlgisUuxZ5
         dGIdztgy7G/Pg6FG8G01aNwoZvSsH/Jq88/5vNZyDffJV7gLzNo7P5qF/1ZbXkItm4GM
         nlQw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:dkim-signature;
        bh=mgSSxNlilEyRbvJ/Dl1SRHIVHwdCoXHiogp/tKM1mPU=;
        fh=Ne6WJFA2cRGUVYndfjlYvfeWelWXaHazsfKSbXZs3FA=;
        b=E6ycQdn2faNyoLZEjRkvAe0uksB9oNWP7aKvlV8EX8BK7jxiDDRUqnXtwM3QH4K3nW
         qCrbjRFMH7y/18IRpl2XOf7vGstr2o6SV2p8wEPjywz3JTrblVG7Hb6zPxPr3jnUKIZe
         BBK9O/535fL2XXJpxojzKpgD2lQ7ppmYjihtoMN4TAutiTerhObnaXmqb/nJl2JKVd4w
         FAZmua41u2QbT7PZ+0vhZCLONMJW7ucR3MmPK0rHpSqSd6hKNLGKvVPAKADZx387IRbQ
         ydrKg5bbDR50IipktX5CBRqQ3oCAcD83IaxuoyKZej1HvzZa9JqaKNjZpDYYp4FrInJ7
         DXBA==;
        darn=lists.ozlabs.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1773918494; x=1774523294; darn=lists.ozlabs.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=mgSSxNlilEyRbvJ/Dl1SRHIVHwdCoXHiogp/tKM1mPU=;
        b=NzAfLg2ZJ914lpzgT7cNp+v1XruHyRx9vpxUZX7aU9IABYBWCUOyDs+QEhUNXcCtJ2
         auG4DxGUyahLOfz/PIMly23TNEUfdaXmpvM6ON1lI0JEPpXBWtIf6KyON6q+47H99Mdl
         LtHwDhIhoSNBEBSqx6kfNgJNCkmkxrbz0u64zydFKOGJ+gsQUQ5Z1FXAxFYmu4HMyPIm
         p7cjkHp8WMm+o+w2g7GwCzE+FwMY0509YpIgUQK22GsiQS5pOxzuKrvDHJMELcQvNrnf
         9NU4OaAbTQ3TwGpbwFyLfsun0NeaIAqWrJwCtIQrUom6hUmx9Dw1Ik1lOgTiK5bla0Pv
         zg/g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1773918494; x=1774523294;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=mgSSxNlilEyRbvJ/Dl1SRHIVHwdCoXHiogp/tKM1mPU=;
        b=hf1yONZfBTxyJEyTDNtTbmQFkZetRocUdUwbvXV5bCv9Cux/MSbcMKORqzY1gVsv1E
         5EYHWQNxFYR959usSr+DSyB5yxt7V0iQv8n/F/jb0vXSU0CKjJtpdbU3XN7hqW50nRL/
         pLLkr/KqX7yQkleGciSQq+lYvx/Sw9QGuYjL4MhkZ6wOhJWEHvHX8/qUkxRInFOIUc7H
         lJSBBLRXmPE6azsHXTGY7ZYH59TmI1MXZNyEM2axt8TB0ODfsMubghfXUH4ckYpwV2JX
         JvbaGZ9HBtRooXEL6aNIs96ej4uy9yJNeqfCcGIrPxxHrOF3S6o8GBO2rU1yS2dUH2iZ
         rysg==
X-Forwarded-Encrypted: i=1; AJvYcCWrJA4+e2X5PZFdCKlMvz8Spc/7psbcYFOxnQgDPMww1yfwkX3T0hQAxOXa8jD7OwKpPf/geH0EeniXQQ==@lists.ozlabs.org
X-Gm-Message-State: AOJu0YyK01wlKjwT40sdNL47o1lGPVn3T7plirgl0xf72lMeQuJhm62Y
	JUSseupXxgLbSF1E/BKEs1gqZCmwbLclBN22qeb3LHOASnVRBxFiLc8tM/o4tAW4zg5aIR3OzCf
	Iq//ZhLL/rnqzTvyEFJaEHz1DsPQ6B9c=
X-Gm-Gg: ATEYQzwPVfzbOHFgAoAI2Sx5MpnPtDl19bkNNawCfS5RNxMbZwyq9tN9YGDkqSD2+Uh
	pfj7PBP/qGC8ib5AhAz0L58J5W1CI4WbYrw9z0R9LoI8tnzcHznLOt6sE30UEKL00DJ/Qcp6FG5
	4oasVv4vR10Zcft590iIcN6m+zT6etYUD1n2Y0Hawtxl7HoGKSdoEl4aC7ptReY3VDTShAXn3jC
	J1vSlQjzK+LM9n2SeZ6kqCE2DmjFtGtpIWV0IhidtA2Q90xle9wKQ4h5g0AoS9RoTOc9tA57vC9
	X/8VGVPYTZ1yao4CtNFq0wUXQv3v05gkD299x2RuPmnvWhIT6OKpLX445q3z+PkH5NpRQG9ahVY
	21iR+uVJg1w62fMDMgSP5cK0nZVE=
X-Received: by 2002:a05:6214:acf:b0:89c:69f6:a1f4 with SMTP id
 6a1803df08f44-89c6b5f5232mr75422516d6.8.1773918493618; Thu, 19 Mar 2026
 04:08:13 -0700 (PDT)
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
References: <CAGSu4WNAFw=yChmynVCYSfJiSJ3LbohTjV97JsJK5EBipwz38g@mail.gmail.com>
 <0f4ece6c-c957-476d-8cc4-fa79bf459acc@linux.alibaba.com>
In-Reply-To: <0f4ece6c-c957-476d-8cc4-fa79bf459acc@linux.alibaba.com>
From: Utkal Singh <singhutkal015@gmail.com>
Date: Thu, 19 Mar 2026 16:38:07 +0530
X-Gm-Features: AaiRm50_h89HP4qPvNs119JNHpulChRHHMh8dg6dNwLpADSKKHQnAYVE8AZIsLg
Message-ID: <CAGSu4WPcm1CQ8MzdKCrCvQyxhheC7OepaLVWxPFy4iDkEn04kQ@mail.gmail.com>
Subject: Re: Incorrect Cc addresses in my recent emails
To: Gao Xiang <hsiangkao@linux.alibaba.com>
Cc: Gao Xiang <xiang@kernel.org>, linux-erofs@lists.ozlabs.org
Content-Type: multipart/alternative; boundary="000000000000ac33b7064d5e957b"
X-Spam-Status: No, score=0.1 required=3.0 tests=ARC_SIGNED,ARC_VALID,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
	FREEMAIL_ENVFROM_END_DIGIT,FREEMAIL_FROM,HTML_MESSAGE,SPF_HELO_NONE,
	SPF_PASS autolearn=disabled version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-25) on lists.ozlabs.org
X-Spamd-Result: default: False [-2.20 / 15.00];
	ARC_ALLOW(-1.00)[lists.ozlabs.org:s=201707:i=2];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_SPF_ALLOW(-0.20)[+ip6:2404:9400:21b9:f100::1:c];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20230601];
	MAILLIST(-0.19)[generic];
	MIME_GOOD(-0.10)[multipart/alternative,text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-2846-lists,linux-erofs=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	RCVD_COUNT_THREE(0.00)[3];
	FORGED_SENDER(0.00)[singhutkal015@gmail.com,linux-erofs@lists.ozlabs.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	FORGED_RECIPIENTS(0.00)[m:hsiangkao@linux.alibaba.com,m:xiang@kernel.org,m:linux-erofs@lists.ozlabs.org,s:lists@lfdr.de];
	MIME_TRACE(0.00)[0:+,1:+,2:~];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORWARDED(0.00)[linux-erofs@lists.ozlabs.org];
	FROM_HAS_DN(0.00)[];
	RCPT_COUNT_THREE(0.00)[3];
	FREEMAIL_FROM(0.00)[gmail.com];
	PREVIOUSLY_DELIVERED(0.00)[linux-erofs@lists.ozlabs.org];
	NEURAL_HAM(-0.00)[-0.985];
	FORGED_SENDER_FORWARDING(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[singhutkal015@gmail.com,linux-erofs@lists.ozlabs.org];
	DKIM_TRACE(0.00)[gmail.com:+];
	MID_RHS_MATCH_FROMTLD(0.00)[];
	TAGGED_RCPT(0.00)[linux-erofs];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	MISSING_XM_UA(0.00)[];
	ASN(0.00)[asn:133159, ipnet:2404:9400:2000::/36, country:AU];
	DBL_BLOCKED_OPENRESOLVER(0.00)[mail.gmail.com:mid,alibaba.com:email,lists.ozlabs.org:helo,lists.ozlabs.org:rdns,linux.dev:email]
X-Rspamd-Queue-Id: 65A6A2CA11A
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

--000000000000ac33b7064d5e957b
Content-Type: text/plain; charset="UTF-8"

Hi Gao Xiang,

You are correct. I was careless in my previous email and apologized for a
patch that was not mine. I will be more precise in the future.

Regarding AI: I hear your concerns. I commit that I will not use AI to
write, generate, or suggest any patches or commit messages I submit. All
future work will be my own code and my own analysis.

I will also ensure that I use scripts/get_maintainer.pl and git send-email
correctly to avoid any further CC or formatting issues.

Best regards, Utkal Singh

On Thu, 19 Mar 2026 at 15:57, Gao Xiang <hsiangkao@linux.alibaba.com> wrote:

>
>
> On 2026/3/19 12:22, Utkal Singh wrote:
> > Hi Gao Xiang,
> >
> > I owe you and the list an apology.
> >
> > The incorrect Cc addresses in my recent emails (gaoxiang25@kernel.org
> and
>
> Why "gaoxiang25@kernel.org" was your fault?
>
> The patch with the incorrect "gaoxiang25@kernel.org" Cc
> https://lore.kernel.org/r/20260316085300.19229-1-lasyaprathipati@gmail.com
>
> is not sent by you, correct?
>
> > yifan.yfzhao@linux.dev) were my fault. I used stale entries from Gmail
> > autocomplete without verifying them against lore.kernel.org or the
>
> I don't think Gmail web UI can send patches directly.
>
> > MAINTAINERS file. That was careless, and I understand why it raised
> > concerns.
> >
> > I have removed every stale address from my contacts. Going forward, I
> will
> > verify all recipients against get_maintainer.pl and the existing thread
> > headers on lore before every send.
> >
> > I also recognize that the volume of my patches over the past two weeks
> has
> > made your review work harder, not easier. I will slow down, consolidate
> > related fixes into proper series, and focus on quality over quantity.
> >
> > I appreciate the time you have spent reviewing my work, and I take your
> > feedback seriously.
>
> Please claim here that you are not using and will not using
> any AI to write patches in public, otherwise I will simply
> ignore your following patches unless your contribution is
> necessary to be fixed.
>
> Everyone can do vibe-coding (including me), I don't think
> it's fair that everyone throws "raw" patches made by AI to
> me and let me take my own time to review.
>
> Thanks,
> Gao Xiang
>
> >
> > Best regards,
> > Utkal Singh
> >
>
>

--000000000000ac33b7064d5e957b
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr"><p>Hi Gao Xiang,</p><p>You are correct. I was careless in =
my previous email and apologized for a patch that was not mine. I will be m=
ore precise in the future.</p><p>Regarding AI: I hear your concerns. I comm=
it that I will not use AI to write, generate, or suggest any patches or com=
mit messages I submit. All future work will be my own code and my own analy=
sis.</p><p>I will also ensure that I use <code>scripts/<a href=3D"http://ge=
t_maintainer.pl">get_maintainer.pl</a></code> and <code>git send-email</cod=
e> correctly to avoid any further CC or formatting issues.</p><p>Best regar=
ds,
Utkal Singh</p></div><br><div class=3D"gmail_quote gmail_quote_container"><=
div dir=3D"ltr" class=3D"gmail_attr">On Thu, 19 Mar 2026 at 15:57, Gao Xian=
g &lt;<a href=3D"mailto:hsiangkao@linux.alibaba.com">hsiangkao@linux.alibab=
a.com</a>&gt; wrote:<br></div><blockquote class=3D"gmail_quote" style=3D"ma=
rgin:0px 0px 0px 0.8ex;border-left:1px solid rgb(204,204,204);padding-left:=
1ex"><br>
<br>
On 2026/3/19 12:22, Utkal Singh wrote:<br>
&gt; Hi Gao Xiang,<br>
&gt; <br>
&gt; I owe you and the list an apology.<br>
&gt; <br>
&gt; The incorrect Cc addresses in my recent emails (<a href=3D"mailto:gaox=
iang25@kernel.org" target=3D"_blank">gaoxiang25@kernel.org</a> and<br>
<br>
Why &quot;<a href=3D"mailto:gaoxiang25@kernel.org" target=3D"_blank">gaoxia=
ng25@kernel.org</a>&quot; was your fault?<br>
<br>
The patch with the incorrect &quot;<a href=3D"mailto:gaoxiang25@kernel.org"=
 target=3D"_blank">gaoxiang25@kernel.org</a>&quot; Cc<br>
<a href=3D"https://lore.kernel.org/r/20260316085300.19229-1-lasyaprathipati=
@gmail.com" rel=3D"noreferrer" target=3D"_blank">https://lore.kernel.org/r/=
20260316085300.19229-1-lasyaprathipati@gmail.com</a><br>
<br>
is not sent by you, correct?<br>
<br>
&gt; <a href=3D"mailto:yifan.yfzhao@linux.dev" target=3D"_blank">yifan.yfzh=
ao@linux.dev</a>) were my fault. I used stale entries from Gmail<br>
&gt; autocomplete without verifying them against <a href=3D"http://lore.ker=
nel.org" rel=3D"noreferrer" target=3D"_blank">lore.kernel.org</a> or the<br=
>
<br>
I don&#39;t think Gmail web UI can send patches directly.<br>
<br>
&gt; MAINTAINERS file. That was careless, and I understand why it raised<br=
>
&gt; concerns.<br>
&gt; <br>
&gt; I have removed every stale address from my contacts. Going forward, I =
will<br>
&gt; verify all recipients against <a href=3D"http://get_maintainer.pl" rel=
=3D"noreferrer" target=3D"_blank">get_maintainer.pl</a> and the existing th=
read<br>
&gt; headers on lore before every send.<br>
&gt; <br>
&gt; I also recognize that the volume of my patches over the past two weeks=
 has<br>
&gt; made your review work harder, not easier. I will slow down, consolidat=
e<br>
&gt; related fixes into proper series, and focus on quality over quantity.<=
br>
&gt; <br>
&gt; I appreciate the time you have spent reviewing my work, and I take you=
r<br>
&gt; feedback seriously.<br>
<br>
Please claim here that you are not using and will not using<br>
any AI to write patches in public, otherwise I will simply<br>
ignore your following patches unless your contribution is<br>
necessary to be fixed.<br>
<br>
Everyone can do vibe-coding (including me), I don&#39;t think<br>
it&#39;s fair that everyone throws &quot;raw&quot; patches made by AI to<br=
>
me and let me take my own time to review.<br>
<br>
Thanks,<br>
Gao Xiang<br>
<br>
&gt; <br>
&gt; Best regards,<br>
&gt; Utkal Singh<br>
&gt; <br>
<br>
</blockquote></div>

--000000000000ac33b7064d5e957b--

