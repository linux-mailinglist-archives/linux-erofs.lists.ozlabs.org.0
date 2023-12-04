Return-Path: <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>
X-Original-To: lists+linux-erofs@lfdr.de
Delivered-To: lists+linux-erofs@lfdr.de
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	by mail.lfdr.de (Postfix) with ESMTPS id 85A9A802A8F
	for <lists+linux-erofs@lfdr.de>; Mon,  4 Dec 2023 04:42:06 +0100 (CET)
Authentication-Results: lists.ozlabs.org;
	dkim=fail reason="signature verification failed" (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20230601 header.b=MgnOrQqa;
	dkim-atps=neutral
Received: from boromir.ozlabs.org (localhost [IPv6:::1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4Sk8c80m22z3cNV
	for <lists+linux-erofs@lfdr.de>; Mon,  4 Dec 2023 14:42:00 +1100 (AEDT)
X-Original-To: linux-erofs@lists.ozlabs.org
Delivered-To: linux-erofs@lists.ozlabs.org
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20230601 header.b=MgnOrQqa;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=gmail.com (client-ip=2a00:1450:4864:20::333; helo=mail-wm1-x333.google.com; envelope-from=qkrwngud825@gmail.com; receiver=lists.ozlabs.org)
Received: from mail-wm1-x333.google.com (mail-wm1-x333.google.com [IPv6:2a00:1450:4864:20::333])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4Sk8c11pczz30gH
	for <linux-erofs@lists.ozlabs.org>; Mon,  4 Dec 2023 14:41:51 +1100 (AEDT)
Received: by mail-wm1-x333.google.com with SMTP id 5b1f17b1804b1-40bd5eaa66cso22791355e9.2
        for <linux-erofs@lists.ozlabs.org>; Sun, 03 Dec 2023 19:41:51 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1701661302; x=1702266102; darn=lists.ozlabs.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=usQamIUqJZ6NZB++HaV6GhUTfmbqwQpVT+aSIq6Nbqw=;
        b=MgnOrQqaEpKcBPgwk6tHUBM1pfYa2ZF5gyqM8tzUFeRguKCUMFu8qWNhK/14voGNPq
         qnsoexdQH7W9WzxIwAasq6TL1FlAUR3bOQBqNeRt59VojLtNj/KTswI3uxD0AiaKXE/h
         E04UwI0CdKkOkPpy1UTD5HJ/aVHKVQaWbROIxIjPfXjRW07EH5bFUxSfupbRJeJER0LN
         gjmtcUXi68XpR5JDWVj/BXBUao+LYkOFtpyN7iPCkAa7PRhDD6XKZ2B5CNphrDmLibvM
         Ms+vUDZe+/2ZMg52dz69Ts1tkKss+00Zm6mpLKiouN3YgIIkkexJiUVP9jbS5dg9pbtb
         cqvA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1701661302; x=1702266102;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=usQamIUqJZ6NZB++HaV6GhUTfmbqwQpVT+aSIq6Nbqw=;
        b=No/bXxWxk2buBubDM4fsiFEZpRB3mGt1tVI4Z03yosz4fgoeNqOWFvztZYQRg7cFhZ
         q+vsBD130PW8cvADw45A12Fm4BAQwJWbPB0QPBsJxmnmvHwfjuqgX3No/+w7q+c0Wxrx
         KjvDWrAig5AbTuTiTRORLIcKUgSpKjAEpKxmz7k1DjZk9H9++WF8LNA8CfFC6UwqT9Gl
         8GbDIRDPmmcxGKpUXXLHtVhlcXYK8MI8XUpBYzV1wfK8x9+rEhydAihDuJ2zeQ2DRoRd
         /TYbmaEbwEAbgXluGKnwqF13P0ALSyRrHGBxjkORus1G602PS76bo6sX3yPO7ywHk4lM
         ffYA==
X-Gm-Message-State: AOJu0Yzf0SEZpmdI0ELePxIEagI4sF2PBsdquNCdpYrdlTwRVFfxPBR6
	Tmx8vb/OAWQYbwRwlpuecQMAMJjANkeLu36UdzQ=
X-Google-Smtp-Source: AGHT+IG5oJnJaoA+nIclssRYj99iohYwftln0Lz/CH7rQ1GGFQboKyYj2w+QFJMZ3+/uWoKOphk4mUbKdSlkFqeEY7U=
X-Received: by 2002:a05:600c:4ba5:b0:40b:5e59:cca1 with SMTP id
 e37-20020a05600c4ba500b0040b5e59cca1mr2118600wmp.130.1701661301960; Sun, 03
 Dec 2023 19:41:41 -0800 (PST)
MIME-Version: 1.0
References: <CAD14+f2AVKf8Fa2OO1aAUdDNTDsVzzR6ctU_oJSmTyd6zSYR2Q@mail.gmail.com>
 <5a0e8b44-6feb-b489-cdea-e3be3811804a@linux.alibaba.com> <CAD14+f2G-buxTaWgb23DYW-HSd1sch6tJNKV2strt=toASZXQQ@mail.gmail.com>
 <649a3bc4-58bb-1dc8-85fb-a56e47b3d5c9@linux.alibaba.com> <CAD14+f1u6gnHLhGSoQxL9wLq9vDYse+Ac8zxep-O2E8hHreT2w@mail.gmail.com>
 <275f025d-e2f1-eaff-6af1-e909d370cee0@linux.alibaba.com>
In-Reply-To: <275f025d-e2f1-eaff-6af1-e909d370cee0@linux.alibaba.com>
From: Juhyung Park <qkrwngud825@gmail.com>
Date: Mon, 4 Dec 2023 12:41:30 +0900
Message-ID: <CAD14+f3zgwgUugjnB7UGCYh4j3iXYsvv_DJ3yvwduA1xf3xn=A@mail.gmail.com>
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

On Mon, Dec 4, 2023 at 12:28=E2=80=AFPM Gao Xiang <hsiangkao@linux.alibaba.=
com> wrote:
>
>
>
> On 2023/12/4 01:32, Juhyung Park wrote:
> > Hi Gao,
>
> ...
>
> >>>
> >>>>
> >>>> What is the difference between these two machines? just different CP=
U or
> >>>> they have some other difference like different compliers?
> >>>
> >>> I fully and exclusively control both devices, and the setup is almost=
 the same.
> >>> Same Ubuntu version, kernel/compiler version.
> >>>
> >>> But as I said, on my laptop, the issue happens on kernels that someon=
e
> >>> else (Canonical) built, so I don't think it matters.
> >>
> >> The only thing I could say is that the kernel side has optimized
> >> inplace decompression compared to fuse so that it will reuse the
> >> same buffer for decompression but with a safe margin (according to
> >> the current lz4 decompression implementation).  It shouldn't behave
> >> different just due to different CPUs.  Let me find more clues
> >> later, also maybe we should introduce a way for users to turn off
> >> this if needed.
> >
> > Cool :)
> >
> > I'm comfortable changing and building my own custom kernel for this
> > specific laptop. Feel free to ask me to try out some patches.
>
> Thanks, I need to narrow down this issue:
>
> -  First, could you apply the following diff to test if it's still
>     reproducable?
>
> diff --git a/fs/erofs/decompressor.c b/fs/erofs/decompressor.c
> index 021be5feb1bc..40a306628e1a 100644
> --- a/fs/erofs/decompressor.c
> +++ b/fs/erofs/decompressor.c
> @@ -131,7 +131,7 @@ static void *z_erofs_lz4_handle_overlap(struct z_erof=
s_lz4_decompress_ctx *ctx,
>
>         if (rq->inplace_io) {
>                 omargin =3D PAGE_ALIGN(ctx->oend) - ctx->oend;
> -               if (rq->partial_decoding || !may_inplace ||
> +               if (1 || rq->partial_decoding || !may_inplace ||
>                     omargin < LZ4_DECOMPRESS_INPLACE_MARGIN(rq->inputsize=
))
>                         goto docopy;

Yup, that fixes it.

The hash output is the same for 50 runs.

>
> - Could you share the full message about the output of `lscpu`?

Sure:

Architecture:            x86_64
  CPU op-mode(s):        32-bit, 64-bit
  Address sizes:         39 bits physical, 48 bits virtual
  Byte Order:            Little Endian
CPU(s):                  8
  On-line CPU(s) list:   0-7
Vendor ID:               GenuineIntel
  BIOS Vendor ID:        Intel(R) Corporation
  Model name:            11th Gen Intel(R) Core(TM) i7-1185G7 @ 3.00GHz
    BIOS Model name:     11th Gen Intel(R) Core(TM) i7-1185G7 @ 3.00GHz Non=
e CPU
                          @ 3.0GHz
    BIOS CPU family:     198
    CPU family:          6
    Model:               140
    Thread(s) per core:  2
    Core(s) per socket:  4
    Socket(s):           1
    Stepping:            1
    CPU(s) scaling MHz:  60%
    CPU max MHz:         4800.0000
    CPU min MHz:         400.0000
    BogoMIPS:            5990.40
    Flags:               fpu vme de pse tsc msr pae mce cx8 apic sep mtrr p=
ge mc
                         a cmov pat pse36 clflush dts acpi mmx fxsr sse sse=
2 ss
                         ht tm pbe syscall nx pdpe1gb rdtscp lm constant_ts=
c art
                          arch_perfmon pebs bts rep_good nopl xtopology non=
stop_
                         tsc cpuid aperfmperf tsc_known_freq pni pclmulqdq =
dtes6
                         4 monitor ds_cpl vmx smx est tm2 ssse3 sdbg fma cx=
16 xt
                         pr pdcm pcid sse4_1 sse4_2 x2apic movbe popcnt tsc=
_dead
                         line_timer aes xsave avx f16c rdrand lahf_lm abm 3=
dnowp
                         refetch cpuid_fault epb cat_l2 cdp_l2 ssbd ibrs ib=
pb st
                         ibp ibrs_enhanced tpr_shadow flexpriority ept vpid=
 ept_
                         ad fsgsbase tsc_adjust bmi1 avx2 smep bmi2 erms in=
vpcid
                          rdt_a avx512f avx512dq rdseed adx smap avx512ifma=
 clfl
                         ushopt clwb intel_pt avx512cd sha_ni avx512bw avx5=
12vl
                         xsaveopt xsavec xgetbv1 xsaves split_lock_detect d=
therm
                          ida arat pln pts hwp hwp_notify hwp_act_window hw=
p_epp
                          hwp_pkg_req vnmi avx512vbmi umip pku ospke avx512=
_vbmi
                         2 gfni vaes vpclmulqdq avx512_vnni avx512_bitalg t=
me av
                         x512_vpopcntdq rdpid movdiri movdir64b fsrm avx512=
_vp2i
                         ntersect md_clear ibt flush_l1d arch_capabilities
Virtualization features:
  Virtualization:        VT-x
Caches (sum of all):
  L1d:                   192 KiB (4 instances)
  L1i:                   128 KiB (4 instances)
  L2:                    5 MiB (4 instances)
  L3:                    12 MiB (1 instance)
NUMA:
  NUMA node(s):          1
  NUMA node0 CPU(s):     0-7
Vulnerabilities:
  Gather data sampling:  Vulnerable
  Itlb multihit:         Not affected
  L1tf:                  Not affected
  Mds:                   Not affected
  Meltdown:              Not affected
  Mmio stale data:       Not affected
  Retbleed:              Not affected
  Spec rstack overflow:  Not affected
  Spec store bypass:     Vulnerable
  Spectre v1:            Vulnerable: __user pointer sanitization and userco=
py ba
                         rriers only; no swapgs barriers
  Spectre v2:            Vulnerable, IBPB: disabled, STIBP: disabled, PBRSB=
-eIBR
                         S: Vulnerable
  Srbds:                 Not affected
  Tsx async abort:       Not affected


>
> Thanks,
> Gao Xiang
