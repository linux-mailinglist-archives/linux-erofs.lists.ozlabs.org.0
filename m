Return-Path: <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>
X-Original-To: lists+linux-erofs@lfdr.de
Delivered-To: lists+linux-erofs@lfdr.de
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2404:9400:2:0:216:3eff:fee1:b9f1])
	by mail.lfdr.de (Postfix) with ESMTPS id 470BB7BC86E
	for <lists+linux-erofs@lfdr.de>; Sat,  7 Oct 2023 16:52:17 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=lists.ozlabs.org;
	s=201707; t=1696690333;
	bh=rYxTb89jy3sP1vlQzWN/MCmDnAWPjcoWpCJ0j22p9x4=;
	h=References:In-Reply-To:Date:Subject:To:List-Id:List-Unsubscribe:
	 List-Archive:List-Post:List-Help:List-Subscribe:From:Reply-To:Cc:
	 From;
	b=V11LSQ1c30I+z84P8gskY9BywTuAX2nl1/GC3dgAEz2Dp3TqwYHhbN24li05Pd8iJ
	 ZGqdVwKCQtduE3e+3/ZT14F86WpY8xSiLTjSXboxA7mPhKL6Fsqo2Mrkp35cqm8qW2
	 2rNgHe7WWKrBdGP3wHiZ2SRB/0MALL22mTHe2iTFBdLPboyoTNPEEg6GmQUPTdbsO6
	 HsaB5oR7kA6w0G6ooZhpLCoYvfhaDXQSVwIlavlm4ssZxzTx26y6DaNZu7cEbPHNCk
	 lmhF+BIjES43U3Q6mZB56bBOmwCvdcEM0QmoqdZqlZXW86BWCdjMCa1rYU3R0L3n/P
	 T1Bzb6LRGuIxw==
Received: from boromir.ozlabs.org (localhost [IPv6:::1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4S2pDF39gCz3cnS
	for <lists+linux-erofs@lfdr.de>; Sun,  8 Oct 2023 01:52:13 +1100 (AEDT)
X-Original-To: linux-erofs@lists.ozlabs.org
Delivered-To: linux-erofs@lists.ozlabs.org
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=google.com header.i=@google.com header.a=rsa-sha256 header.s=20230601 header.b=rwta92Ln;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=google.com (client-ip=2607:f8b0:4864:20::932; helo=mail-ua1-x932.google.com; envelope-from=dhavale@google.com; receiver=lists.ozlabs.org)
Received: from mail-ua1-x932.google.com (mail-ua1-x932.google.com [IPv6:2607:f8b0:4864:20::932])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4S2pD641gzz3c5L
	for <linux-erofs@lists.ozlabs.org>; Sun,  8 Oct 2023 01:52:05 +1100 (AEDT)
Received: by mail-ua1-x932.google.com with SMTP id a1e0cc1a2514c-7abe4fa15ceso2006307241.1
        for <linux-erofs@lists.ozlabs.org>; Sat, 07 Oct 2023 07:52:05 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1696690320; x=1697295120;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=rYxTb89jy3sP1vlQzWN/MCmDnAWPjcoWpCJ0j22p9x4=;
        b=DVYMYG2JiVQWtLBWcVnBqT3jiTFwSP4D0xp83RfcaLk+hSh7Vn1uxjLZbxA3kebwws
         G6Z3rsZ9IcZpE2HvTzP/UELWN9VzlCeOc8qqkfGfX2SUcAFjCC2/u/Ve/XRa5ytg4S/X
         5KukGbuLMCOz4iLuRu2B4wTmI8y0DHGWGf7pARfgSeWeFZvyIC4LZlNaRhGWEEHwzjxy
         II3tKYukdL1UxhPAPAkce6/Js99x2zixI+YiGOcQLu3p5cb26Vth6suTkjSMP4PiG9ma
         v9zT3+A+X4FhYZbzsCJFpyIgPtdOv3QkaUXwK3PKYmdV4TTkq5c8ZN4SaiLxUdaUtkvz
         anQA==
X-Gm-Message-State: AOJu0YykvIJ1PojWzEi8BNKyX4oH+a7Rep//H3hjRceTl+OTubMg+pD2
	yAJ9EQ5MFpfMQlWS7BC7Fi1Ec+iWbm4KjsFI5Dprfg==
X-Google-Smtp-Source: AGHT+IG3d/7xltJ+caeS0OgcCWkSS62QiAkShCU7cRBxXsvDye1fDxVxh6uQB0tDK0wJeqdmgKOgeb3XcmtH+LaNd0o=
X-Received: by 2002:a05:6102:3a13:b0:452:5a50:e0ff with SMTP id
 b19-20020a0561023a1300b004525a50e0ffmr4916315vsu.17.1696690319481; Sat, 07
 Oct 2023 07:51:59 -0700 (PDT)
MIME-Version: 1.0
References: <20231005224008.817830-1-dhavale@google.com> <531b8a1b-efbb-8fcb-a0f8-018c8650611f@linux.alibaba.com>
 <CAB=BE-RR4MsevBPbrmr-QmH8ihzTnQhrQuJoh1Fr6BquP9AS8A@mail.gmail.com> <9ef1b3c3-9d3c-5639-1859-6d419b2a9594@linux.alibaba.com>
In-Reply-To: <9ef1b3c3-9d3c-5639-1859-6d419b2a9594@linux.alibaba.com>
Date: Sat, 7 Oct 2023 07:51:48 -0700
Message-ID: <CAB=BE-RrTeqUUqvkYCckoJXou4tf9zKd_xN4KTCk0kh5yp9Saw@mail.gmail.com>
Subject: Re: [PATCH v1] erofs-utils: Fix cross compile with autoconf
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
From: Sandeep Dhavale via Linux-erofs <linux-erofs@lists.ozlabs.org>
Reply-To: Sandeep Dhavale <dhavale@google.com>
Cc: kernel-team@android.com, linux-erofs@lists.ozlabs.org
Errors-To: linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org
Sender: "Linux-erofs" <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>

On Sat, Oct 7, 2023 at 1:25=E2=80=AFAM Gao Xiang <hsiangkao@linux.alibaba.c=
om> wrote:
>
>
>
> On 2023/10/7 15:16, Sandeep Dhavale wrote:
> > On Fri, Oct 6, 2023 at 8:27=E2=80=AFPM Gao Xiang <hsiangkao@linux.aliba=
ba.com> wrote:
> >>
> >> Hi Sandeep!
> >>
> >> On 2023/10/6 06:40, Sandeep Dhavale wrote:
> >>> AC_RUN_IFELSE expects the action if cross compiling. If not provided
> >>> cross compilation fails with error "configure: error: cannot run test
> >>> program while cross compiling".
> >>> Use 4096 as the buest guess PAGESIZE if cross compiling as it is stil=
l
> >>> the most common page size.
> >>
> >> Thanks for your report!
> >>
> >>>
> >>> Reported-in: https://lore.kernel.org/all/0101018aec71b531-0a354b1a-0b=
70-47a1-8efc-fea8c439304c-000000@us-west-2.amazonses.com/
> >>> Fixes: 8ee2e591dfd6 ("erofs-utils: support detecting maximum block si=
ze")
> >>> Signed-off-by: Sandeep Dhavale <dhavale@google.com>
> >>> ---
> >>>    configure.ac | 4 ++--
> >>>    1 file changed, 2 insertions(+), 2 deletions(-)
> >>>
> >>> diff --git a/configure.ac b/configure.ac
> >>> index 13ee616..a546310 100644
> >>> --- a/configure.ac
> >>> +++ b/configure.ac
> >>> @@ -284,8 +284,8 @@ AS_IF([test "x$MAX_BLOCK_SIZE" =3D "x"], [
> >>>        return 0;
> >>>    ]])],
> >>>                                 [erofs_cv_max_block_size=3D`cat conft=
est.out`],
> >>> -                             [],
> >>> -                             []))
> >>> +                             [erofs_cv_max_block_size=3D4096],
> >>> +                             [erofs_cv_max_block_size=3D4096]))
> >>>    ], [erofs_cv_max_block_size=3D$MAX_BLOCK_SIZE])
> >>
> >> Actually the following check will reset erofs_cv_max_block_size to 409=
6
> >> if needed. But it seems that it has syntax errors.
> >>
> > Hi Gao,
> > If I understand this correctly, the problem here is not having defined
> > action if we are cross compiling for AC_RUN_IFELSE(). The cross
> > compilation will fail until we have an action defined.
> >
> > While at it I specified erofs_cv_max_block_size=3D4096 for the second
> > action which will be the value if the test program fails to detect the
> > page size.
>
> Oh, thanks! got it.  How about updating erofs_cv_max_block_size to
> $MAX_BLOCK_SIZE first, and fallback to 4096 if MAX_BLOCK_SIZE is
> not defined? (We need to use $MAX_BLOCK_SIZE if defined anyway...)
>
> I mean applying the following diff in addition to the previous diff too?
>
> +                             [erofs_cv_max_block_size=3D$MAX_BLOCK_SIZE]=
,
> +                             [erofs_cv_max_block_size=3D$MAX_BLOCK_SIZE]=
))
>      ], [erofs_cv_max_block_size=3D$MAX_BLOCK_SIZE])
>
Hi Gao,
That cannot work because AS_RUN_IFELSE() is only invoked if
MAX_BLOCK_SIZE is not set.

  # Detect maximum block size if necessary
  AS_IF([test "x$MAX_BLOCK_SIZE" =3D "x"], [
    AC_CACHE_CHECK([sysconf (_SC_PAGESIZE)], [erofs_cv_max_block_size],
                 AC_RUN_IFELSE([AC_LANG_PROGRAM(
  [[
  #include <unistd.h>
  #include <stdio.h>
...

Cross compilation works if MAX_BLOCK_SIZE is set today as is without
any fix. Cross compilation only fails when MAX_BLOCK_SIZE is not set
AND the configure script tries to detect because there is no action
defined regarding what should be erofs_cv_max_block_size.

Thanks,
Sandeep.

> If it works, I could apply this version.
>
> Thanks,
> Gao Xiang
>
> >
> > With your suggested patch, cross compilation still fails with the error
> >> configure: error: cannot run test program while cross compiling
> >> See `config.log' for more details
> >
> > Thanks,
> > Sandeep.
> >
> >> I wonder if the following diff could fix the issue too?
> >>
> >> Thanks,
> >> Gao Xiang
> >>
> >> diff --git a/configure.ac b/configure.ac
> >> index 13ee616..94eec01 100644
> >> --- a/configure.ac
> >> +++ b/configure.ac
> >> @@ -288,6 +288,9 @@ AS_IF([test "x$MAX_BLOCK_SIZE" =3D "x"], [
> >>                                 []))
> >>    ], [erofs_cv_max_block_size=3D$MAX_BLOCK_SIZE])
> >>
> >> +AS_IF([test "x$erofs_cv_max_block_size" =3D "x"],
> >> +      [erofs_cv_max_block_size=3D4096], [])
> >> +
> >>    # Configure debug mode
> >>    AS_IF([test "x$enable_debug" !=3D "xno"], [], [
> >>      dnl Turn off all assert checking.
> >> @@ -501,9 +504,6 @@ if test "x$have_libdeflate" =3D "xyes"; then
> >>    fi
> >>
> >>    # Dump maximum block size
> >> -AS_IF([test "x$erofs_cv_max_block_size" =3D "x"],
> >> -      [$erofs_cv_max_block_size =3D 4096], [])
> >> -
> >>    AC_DEFINE_UNQUOTED([EROFS_MAX_BLOCK_SIZE], [$erofs_cv_max_block_siz=
e],
> >>                     [The maximum block size which erofs-utils supports=
])
