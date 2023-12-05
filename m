Return-Path: <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>
X-Original-To: lists+linux-erofs@lfdr.de
Delivered-To: lists+linux-erofs@lfdr.de
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2404:9400:2:0:216:3eff:fee1:b9f1])
	by mail.lfdr.de (Postfix) with ESMTPS id 99746805739
	for <lists+linux-erofs@lfdr.de>; Tue,  5 Dec 2023 15:24:11 +0100 (CET)
Authentication-Results: lists.ozlabs.org;
	dkim=fail reason="signature verification failed" (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20230601 header.b=dY12rDQO;
	dkim-atps=neutral
Received: from boromir.ozlabs.org (localhost [IPv6:::1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4Sl2pd0glyz3cY0
	for <lists+linux-erofs@lfdr.de>; Wed,  6 Dec 2023 01:24:09 +1100 (AEDT)
X-Original-To: linux-erofs@lists.ozlabs.org
Delivered-To: linux-erofs@lists.ozlabs.org
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20230601 header.b=dY12rDQO;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=gmail.com (client-ip=2a00:1450:4864:20::629; helo=mail-ej1-x629.google.com; envelope-from=qkrwngud825@gmail.com; receiver=lists.ozlabs.org)
Received: from mail-ej1-x629.google.com (mail-ej1-x629.google.com [IPv6:2a00:1450:4864:20::629])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4Sl2pY4wx9z3cRP
	for <linux-erofs@lists.ozlabs.org>; Wed,  6 Dec 2023 01:24:03 +1100 (AEDT)
Received: by mail-ej1-x629.google.com with SMTP id a640c23a62f3a-a1b6b65923eso318024966b.3
        for <linux-erofs@lists.ozlabs.org>; Tue, 05 Dec 2023 06:24:03 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1701786237; x=1702391037; darn=lists.ozlabs.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=T7XU6GHHiBgdkrXmdGsRu2k0uowM8mZD/GX6dh9pTT4=;
        b=dY12rDQO8HKwZuhnBhDKL+72uFAjP49jhN/cNt4VnrQyTvIKP1MJjQWeSO2JTwSAcr
         BNi2jRJTlNqiQMQ8IlMU4nuRPTKhZ6XmImlShV7uXA0Xhcb5gwGpTezarr0aG351jN0s
         7ZzJv1JqzwQoXKC4yUbYI9p5W7B9XjBdqlIfuHPJuk+KXZSdHDZyMPL8PnBwDnTlFD6u
         ju36NGFobUzhMSiu+3FPBf3wAO+VfNCyPmVKf73yhnsEQYo2gEkc8sskR6kCuA4eZ0dI
         EL+CthZZ+BU8Qg7j1O4b9p7B9r13T6tOaOc4hWJdJKdyjwWWjNo6p2PKXfbHCYFynIjh
         cVNQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1701786237; x=1702391037;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=T7XU6GHHiBgdkrXmdGsRu2k0uowM8mZD/GX6dh9pTT4=;
        b=GrKqtqykqNUTa3pLgeLvoaQExmQT+YdEre7sQwWKga7xV1qDJZto95dPMU/CrZtHsH
         JlCajTUH4tBR+Dn7yBxF1fSbu98c4ICWSFMKfz8X5fZ9kEGU++KmACIsWq8mk/A1h97e
         dpsFQO0yQ8WqIKueHfeTpPCIdrbdkePuo76T1VkfL3Ub60vzcJkG3kk42JJbxRfLXXxY
         o28bEqiEsbtUg/uS2F2QOIYOS3vMzzl8uYvkC/MxF3p9iCJz72RXB4uFBCOWDDDqhBYh
         d4FhDpXDjZ5SEkEaJxS8cSwI0f//XNbMOGWPTb0XYroX+mNco5EEBpH2FMMvsDVW174j
         Hs8g==
X-Gm-Message-State: AOJu0YxwRw+kutz1xkyZAjnTwLNPkbluFcJ6aDszLzpnltZrOShpbhaj
	ZJ8B864DXv/tam8K4+NPwrHxVjJ9ajcO+zEGjfA=
X-Google-Smtp-Source: AGHT+IHmjQYO8Lbz0AV3t/9F250TBl3CqhhD6m/ina5u1sK3EV3LtWkK0nPmDiX1Pkv1pnEGvjIvN7xUJ/csGiAx/rc=
X-Received: by 2002:a17:906:73cf:b0:a1c:c376:85ca with SMTP id
 n15-20020a17090673cf00b00a1cc37685camr248747ejl.216.1701786236507; Tue, 05
 Dec 2023 06:23:56 -0800 (PST)
MIME-Version: 1.0
References: <CAD14+f2AVKf8Fa2OO1aAUdDNTDsVzzR6ctU_oJSmTyd6zSYR2Q@mail.gmail.com>
 <5a0e8b44-6feb-b489-cdea-e3be3811804a@linux.alibaba.com> <CAD14+f2G-buxTaWgb23DYW-HSd1sch6tJNKV2strt=toASZXQQ@mail.gmail.com>
 <649a3bc4-58bb-1dc8-85fb-a56e47b3d5c9@linux.alibaba.com> <CAD14+f1u6gnHLhGSoQxL9wLq9vDYse+Ac8zxep-O2E8hHreT2w@mail.gmail.com>
 <275f025d-e2f1-eaff-6af1-e909d370cee0@linux.alibaba.com> <CAD14+f3zgwgUugjnB7UGCYh4j3iXYsvv_DJ3yvwduA1xf3xn=A@mail.gmail.com>
 <d7c7ea8c-6e2f-e8d8-88c3-4952c506ed13@linux.alibaba.com>
In-Reply-To: <d7c7ea8c-6e2f-e8d8-88c3-4952c506ed13@linux.alibaba.com>
From: Juhyung Park <qkrwngud825@gmail.com>
Date: Tue, 5 Dec 2023 23:23:44 +0900
Message-ID: <CAD14+f2hPLv6RPZdYyi8q8SQGiBox2fYUaWwuBEjEbZKQdyU7g@mail.gmail.com>
Subject: Re: Weird EROFS data corruption
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
Cc: Yann Collet <yann.collet.73@gmail.com>, linux-erofs@lists.ozlabs.org, linux-crypto@vger.kernel.org, linux-f2fs-devel@lists.sourceforge.net
Errors-To: linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org
Sender: "Linux-erofs" <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>

Hi Gao,

On Tue, Dec 5, 2023 at 4:32=E2=80=AFPM Gao Xiang <hsiangkao@linux.alibaba.c=
om> wrote:
>
> Hi Juhyung,
>
> On 2023/12/4 11:41, Juhyung Park wrote:
>
> ...
> >
> >>
> >> - Could you share the full message about the output of `lscpu`?
> >
> > Sure:
> >
> > Architecture:            x86_64
> >    CPU op-mode(s):        32-bit, 64-bit
> >    Address sizes:         39 bits physical, 48 bits virtual
> >    Byte Order:            Little Endian
> > CPU(s):                  8
> >    On-line CPU(s) list:   0-7
> > Vendor ID:               GenuineIntel
> >    BIOS Vendor ID:        Intel(R) Corporation
> >    Model name:            11th Gen Intel(R) Core(TM) i7-1185G7 @ 3.00GH=
z
> >      BIOS Model name:     11th Gen Intel(R) Core(TM) i7-1185G7 @ 3.00GH=
z None CPU
> >                            @ 3.0GHz
> >      BIOS CPU family:     198
> >      CPU family:          6
> >      Model:               140
> >      Thread(s) per core:  2
> >      Core(s) per socket:  4
> >      Socket(s):           1
> >      Stepping:            1
> >      CPU(s) scaling MHz:  60%
> >      CPU max MHz:         4800.0000
> >      CPU min MHz:         400.0000
> >      BogoMIPS:            5990.40
> >      Flags:               fpu vme de pse tsc msr pae mce cx8 apic sep m=
trr pge mc
> >                           a cmov pat pse36 clflush dts acpi mmx fxsr ss=
e sse2 ss
> >                           ht tm pbe syscall nx pdpe1gb rdtscp lm consta=
nt_tsc art
> >                            arch_perfmon pebs bts rep_good nopl xtopolog=
y nonstop_
> >                           tsc cpuid aperfmperf tsc_known_freq pni pclmu=
lqdq dtes6
> >                           4 monitor ds_cpl vmx smx est tm2 ssse3 sdbg f=
ma cx16 xt
> >                           pr pdcm pcid sse4_1 sse4_2 x2apic movbe popcn=
t tsc_dead
> >                           line_timer aes xsave avx f16c rdrand lahf_lm =
abm 3dnowp
> >                           refetch cpuid_fault epb cat_l2 cdp_l2 ssbd ib=
rs ibpb st
> >                           ibp ibrs_enhanced tpr_shadow flexpriority ept=
 vpid ept_
> >                           ad fsgsbase tsc_adjust bmi1 avx2 smep bmi2 er=
ms invpcid
> >                            rdt_a avx512f avx512dq rdseed adx smap avx51=
2ifma clfl
> >                           ushopt clwb intel_pt avx512cd sha_ni avx512bw=
 avx512vl
> >                           xsaveopt xsavec xgetbv1 xsaves split_lock_det=
ect dtherm
> >                            ida arat pln pts hwp hwp_notify hwp_act_wind=
ow hwp_epp
> >                            hwp_pkg_req vnmi avx512vbmi umip pku ospke a=
vx512_vbmi
> >                           2 gfni vaes vpclmulqdq avx512_vnni avx512_bit=
alg tme av
> >                           x512_vpopcntdq rdpid movdiri movdir64b fsrm a=
vx512_vp2i
>
> Sigh, I've been thinking.  Here FSRM is the most significant difference b=
etween
> our environments, could you only try the following diff to see if there's=
 any
> difference anymore? (without the previous disable patch.)
>
> diff --git a/arch/x86/lib/memmove_64.S b/arch/x86/lib/memmove_64.S
> index 1b60ae81ecd8..1b52a913233c 100644
> --- a/arch/x86/lib/memmove_64.S
> +++ b/arch/x86/lib/memmove_64.S
> @@ -41,9 +41,7 @@ SYM_FUNC_START(__memmove)
>   #define CHECK_LEN     cmp $0x20, %rdx; jb 1f
>   #define MEMMOVE_BYTES movq %rdx, %rcx; rep movsb; RET
>   .Lmemmove_begin_forward:
> -       ALTERNATIVE_2 __stringify(CHECK_LEN), \
> -                     __stringify(CHECK_LEN; MEMMOVE_BYTES), X86_FEATURE_=
ERMS, \
> -                     __stringify(MEMMOVE_BYTES), X86_FEATURE_FSRM
> +       CHECK_LEN
>
>         /*
>          * movsq instruction have many startup latency

Yup, that also seems to fix it.
Are we looking at a potential memmove issue?

>
> Thanks,
> Gao Xiang
