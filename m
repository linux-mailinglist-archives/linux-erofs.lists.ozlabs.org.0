Return-Path: <linux-erofs+bounces-1808-lists+linux-erofs=lfdr.de@lists.ozlabs.org>
X-Original-To: lists+linux-erofs@lfdr.de
Delivered-To: lists+linux-erofs@lfdr.de
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	by mail.lfdr.de (Postfix) with ESMTPS id AD632D0D43E
	for <lists+linux-erofs@lfdr.de>; Sat, 10 Jan 2026 10:52:11 +0100 (CET)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4dpDSZ3SnDz2y8c;
	Sat, 10 Jan 2026 20:51:58 +1100 (AEDT)
X-Original-To: linux-erofs@lists.ozlabs.org
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip=209.85.208.47
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1768038718;
	cv=none; b=FPkR6VcTbjAA56b3HH0odDK/GeuN6TZjmNnHbg1nBcmVv5qQOvz2vzqophL9cTr4/BQl+F0FwzSqRyFsceQYo47XcZvmiUSjG+poOa/ZPL15MAti3PpfhG8/noBI4VlfBO43bBydSFA6zg7xE2VwBnoO/LtTZZl/8kZk7dTgxpW8gj6u3LldOexEiQ/XYdPpbyVgyWqcHwFnMt4aJrpq/Dppj/p/MwuaD6N9VlaTsizXWCNvDwiFVKFiDEgTtaE4+l6lIl/AIkVGFvrkxF3OKre5xjF5JUmkHKJwkqeEbcsGISUkoC/G5QwWrvzhNaoZjpMI90LtpSS99EEKywTCPQ==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1768038718; c=relaxed/relaxed;
	bh=fvI7APxkjQKclSSS1XvsYwgz2EP12MpFkKAG7hnsm8U=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Content-Type; b=gw6ZA8avJwm5pNuuGfZS1XdVTI4qslH2msSOi96N803EzmW7g3wiyioG4ubryjGfsRzkTlUJ0CRkMqxyexPFNnOSx8Q42O/qoSpzXzyp5fo6IaftPCtv4l6qF5hUvOZqSCRLZ1g9Inr3D4PniowNmUkSUk6odsv2gWheCjFbMN7HRzhsyP6WDz1UPp/85vteKA1JDiHJxMa7cH4k9oxpXPvmzNJqsv9nqAs0fhKWyRLl++q1NNrwMl1B4LyJcXQs/4v2iNbXpyX8G3SFS70HRiX7azjxMnyqY/ssz41LKkJOtgltRY47F8D6POQC3nWkWcLBH/+w/4QLOIgDU4raYg==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=gmail.com; dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20230601 header.b=a/ddcFV8; dkim-atps=neutral; spf=pass (client-ip=209.85.208.47; helo=mail-ed1-f47.google.com; envelope-from=amir73il@gmail.com; receiver=lists.ozlabs.org) smtp.mailfrom=gmail.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20230601 header.b=a/ddcFV8;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=gmail.com (client-ip=209.85.208.47; helo=mail-ed1-f47.google.com; envelope-from=amir73il@gmail.com; receiver=lists.ozlabs.org)
Received: from mail-ed1-f47.google.com (mail-ed1-f47.google.com [209.85.208.47])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4dpDSX4Mr9z2xQs
	for <linux-erofs@lists.ozlabs.org>; Sat, 10 Jan 2026 20:51:55 +1100 (AEDT)
Received: by mail-ed1-f47.google.com with SMTP id 4fb4d7f45d1cf-64b9cb94ff5so7192299a12.2
        for <linux-erofs@lists.ozlabs.org>; Sat, 10 Jan 2026 01:51:55 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1768038653; x=1768643453; darn=lists.ozlabs.org;
        h=content-transfer-encoding:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=fvI7APxkjQKclSSS1XvsYwgz2EP12MpFkKAG7hnsm8U=;
        b=a/ddcFV8nVp008HUO2up/Up/rBYUooL5nrlNAhBaSmW14YlO1+ukT/ANRQ5JJSBmFy
         3HC3bgV8H5EIJybwzqQyeP0mXr8tW/7qqwVBxMnUuKtQxQcDs1QNfF79MH2/ZkAztG0O
         sjfsxM5NhOFMc6cPRmG5ZAd18kNETudYC3hfUjAH3gtv/gubVv/xWNHk+J7Yi+7Uzr/y
         I/Zghh73XFDgqxY9xKkRcNgYKyhs6ijenMKij46TmSRUoU6WUo9IfiVEASNE7JOgOWbe
         Jlu5MrNjmTh2c26yBQwR4b1k6rSXw9595zi/DR/mxibqXjN5J60lG31QhKsGedoOx+/l
         fL3g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1768038653; x=1768643453;
        h=content-transfer-encoding:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=fvI7APxkjQKclSSS1XvsYwgz2EP12MpFkKAG7hnsm8U=;
        b=n5mlmAjuYd01ya2Nkchz/Ycqe14ospGB4xaMDzrBgQCgbQ8jHPaqN5tVeugKYKK0mM
         nW5V9Y04gk4rAkUlORJ0WjLsRw5jAshr3g/u74piwrLWDmTa4MpX79fMxGwrvUy7EC48
         rigJtGQC8dDKUWrZhKAnxPITFmd0k3358zBanGg1ywpJwwhO3HPWBqvh4l/HVjPQyXgt
         q2sSHdEqM9n0eR0+m+ZXwUpOTjMEO8hEkwURjA923uS40F6zLEE7h7HsIREKMpIv9nSb
         c5ya/TxgczuHn/ro254REWk8DeUQZ2pbjHlQtMJSrcuZYcv45kj/jAcov0ogOKMYh3px
         mE6g==
X-Forwarded-Encrypted: i=1; AJvYcCW8FCZYpfpuGpSB1a9GBVTRsxAietRhxfnpVDobER2jRVVRaxjtJ/VBc9Dnhz+WiBLPugJpdyVIjEsIAA==@lists.ozlabs.org
X-Gm-Message-State: AOJu0YxTuBOnsRB0NXZ7hKjwWKAHIbtv+8X/gUwlkgiQPcA0LwoME3F9
	WayMZB42WW397Bu+NQnnO96SRhtcPxoHjqit2DyyjJr5jK+H4QQpL6ISfL9sH7L1d2VSRbiGA7O
	jyzmcZSu5QkabnhgsbRpC1A3tcxIQYHc=
X-Gm-Gg: AY/fxX7e1NVsAgrkNIZPC89KbAjXv/OWzGv1jbvkLQlGKcAOK+HXZnk2TnsUOw7DgFW
	WbgAc+2bzlYncMboWvlJjHPSvRhqu/f4K8/6Qp06OSu3ieM97qi00sC3UmltSBtXFOortKVoF3s
	cisKEk86RDLJJyn4A8i2hAsdlrT1CbCPTIOpOAhaY3Ofrx3dTaoqZswA89SIApqpULjMjhE74bS
	hJJGJEZEuTKBFWuAM1V2BGmnfhDYDvJLJQ+7zmo8W9POpdpTFETTbKJJlSf4q3R6v6p0B6uaIGS
	RhoO7CRUORSVmGR9TDaJkEL8QWNO
X-Google-Smtp-Source: AGHT+IGla1h37c9BEnRZ0jdBfCikYMgAIlq2BU3HXM8UNagSpAD7MIRzZrnZut5vrw8bVwjLnQuLJsMxLiq1DVGbez8=
X-Received: by 2002:a05:6402:1e8c:b0:64b:6007:d8dc with SMTP id
 4fb4d7f45d1cf-65097dcd890mr11021299a12.7.1768038652737; Sat, 10 Jan 2026
 01:50:52 -0800 (PST)
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
References: <aWHibOkAT18Hc/G5@debian> <aWH/dP4xD51Rqwa+@debian>
In-Reply-To: <aWH/dP4xD51Rqwa+@debian>
From: Amir Goldstein <amir73il@gmail.com>
Date: Sat, 10 Jan 2026 10:50:41 +0100
X-Gm-Features: AZwV_QiKYDqrloOJSZbU5K877XUrk2MCBuJblo5vbzdENREIh0X0VATkTNd8ZEo
Message-ID: <CAOQ4uxht2EWvryy9bZw6uRsCyAc6WCHHvAjP=X92x9Pk9CaM0g@mail.gmail.com>
Subject: Re: [GIT PULL] erofs fix for 6.19-rc5 (fix the stupid mistake)
To: Linus Torvalds <torvalds@linux-foundation.org>, linux-erofs@lists.ozlabs.org, 
	LKML <linux-kernel@vger.kernel.org>, Amir Goldstein <amir73il@gmail.com>, 
	Alexander Larsson <alexl@redhat.com>, Dusty Mabe <dusty@dustymabe.com>, Chao Yu <chao@kernel.org>, 
	Sheng Yong <shengyong1@xiaomi.com>, Zhiguo Niu <zhiguo.niu@unisoc.com>, 
	Christian Brauner <brauner@kernel.org>, Miklos Szeredi <mszeredi@redhat.com>, Gao Xiang <xiang@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-0.2 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,RCVD_IN_DNSWL_NONE,
	RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS autolearn=disabled
	version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-25) on lists.ozlabs.org

On Sat, Jan 10, 2026 at 8:27=E2=80=AFAM Gao Xiang <xiang@kernel.org> wrote:
>
> Hi Linus,
>
> Very sorry I sent an incorrect pull request which used an
> outdated PATCH version (I just manually applied tags on the
> incorrect version, but I didn't realize), I shouldn't make
> the stupid mistake in the beginning.
>
> Someone reminded me the mistake just now.
>
> Could you please apply this pull request, I promise that I
> won't make the similar fault again and I should be blamed.
>
> Thanks,
> Gao Xiang
>
> The following changes since commit 072a7c7cdbea4f91df854ee2bb216256cd619f=
2a:
>
>   erofs: don't bother with s_stack_depth increasing for now (2026-01-10 1=
3:01:15 +0800)
>
> are available in the Git repository at:
>
>   git://git.kernel.org/pub/scm/linux/kernel/git/xiang/erofs.git tags/erof=
s-for-6.19-rc5-fixes-2
>
> for you to fetch changes up to 0a7468a8de7a2721cc0cce30836726f2a3ac2120:
>
>   erofs: don't bother with s_stack_depth increasing for now [real fix] (2=
026-01-10 15:13:12 +0800)
>
> ----------------------------------------------------------------
> Changes since last update:
>
>  - Revert the incorrect outdated PATCH version
>
>  - Apply the correct fix of
>    "erofs: don't bother with s_stack_depth increasing for now"
>
> ----------------------------------------------------------------
> Gao Xiang (2):
>       Revert "erofs: don't bother with s_stack_depth increasing for now"
>       erofs: don't bother with s_stack_depth increasing for now [real fix=
]
>

Gao,

You merged the wrong patch version by mistake - no real harm done.

But now that it was merged, for the sake of git history, I think it would
be better to merge a fix patch rather than revert + patch with same title.

If you merge a fix patch you could properly attribute Report/Review/Tested-=
by
to Sheng Yong [1].

It's true that the merged patch already claims to work for Android APEX,
but it had a braino bug and this is what fix patches are for.

Thanks,
Amir.

[1] https://lore.kernel.org/linux-fsdevel/243f57b8-246f-47e7-9fb1-27a771e8e=
9e8@gmail.com/

