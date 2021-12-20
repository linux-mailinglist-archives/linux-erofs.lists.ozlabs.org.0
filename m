Return-Path: <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>
X-Original-To: lists+linux-erofs@lfdr.de
Delivered-To: lists+linux-erofs@lfdr.de
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2404:9400:2:0:216:3eff:fee1:b9f1])
	by mail.lfdr.de (Postfix) with ESMTPS id 9B9EF47AE95
	for <lists+linux-erofs@lfdr.de>; Mon, 20 Dec 2021 16:02:34 +0100 (CET)
Received: from boromir.ozlabs.org (localhost [IPv6:::1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4JHjVw3CLDz2ym7
	for <lists+linux-erofs@lfdr.de>; Tue, 21 Dec 2021 02:02:32 +1100 (AEDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=lists.ozlabs.org;
	s=201707; t=1640012552;
	bh=NwG/z6LaWMy2D6wYIyd1kImSwFlsrc7oO5HR9cF+VIo=;
	h=References:In-Reply-To:Date:Subject:To:List-Id:List-Unsubscribe:
	 List-Archive:List-Post:List-Help:List-Subscribe:From:Reply-To:Cc:
	 From;
	b=czNpm0q6W+xkpD3HyU0u30m13kUReqycyqA2Npywi7eHrtEuoZFC5enWonAsGnrUA
	 39PAxNkD99QOXyXLmCw0dt3ZxPkEd6QJp3BTQTux2oiC5W30XPRFyG+OVwSU7GHTkm
	 OST3WneWbrBB0o56pp/GERXgN8Ep9cXrgykVinvlJi1R9orCcGgBtJ7NOA54pi2059
	 D8YtAS0oge6RdVLBLu90h7HTnEDt94dAe9148EefAEYqMrkgexRAIpDrsodWouN9k/
	 0F1GCVVm+V80ElYCnMIAnfGU7BiK++VBRtMB/FhlbvXnFsNah9wIbTzq6mmJ7Iv/Gj
	 bOlZ0okXR1ycw==
X-Original-To: linux-erofs@lists.ozlabs.org
Delivered-To: linux-erofs@lists.ozlabs.org
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized)
 smtp.mailfrom=google.com (client-ip=2607:f8b0:4864:20::72c;
 helo=mail-qk1-x72c.google.com; envelope-from=zhangkelvin@google.com;
 receiver=<UNKNOWN>)
Authentication-Results: lists.ozlabs.org; dkim=pass (2048-bit key;
 unprotected) header.d=google.com header.i=@google.com header.a=rsa-sha256
 header.s=20210112 header.b=FjOFPJjy; dkim-atps=neutral
Received: from mail-qk1-x72c.google.com (mail-qk1-x72c.google.com
 [IPv6:2607:f8b0:4864:20::72c])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 4JHjVs6T2nz2xtF
 for <linux-erofs@lists.ozlabs.org>; Tue, 21 Dec 2021 02:02:27 +1100 (AEDT)
Received: by mail-qk1-x72c.google.com with SMTP id l25so9575764qkl.5
 for <linux-erofs@lists.ozlabs.org>; Mon, 20 Dec 2021 07:02:27 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=NwG/z6LaWMy2D6wYIyd1kImSwFlsrc7oO5HR9cF+VIo=;
 b=j/hO2LpFIF604/llTpCUfw4RbXsTikmd9jd/F7ONPYIl3SMYGTOJboEh+aSCtevfy/
 TU4DgUEkAMSCwpey75U+oUNk8Y8lEUW+mUGFntI5tWZi1EgaKKDTdFsxKDSJgsiSMdlr
 /aAdkR1cRzMNVERuUoWxCvfjDAofxCfghud5soDnISpwDQuAsPhnIzsA28dvtFixTf3+
 Q82G7J2HTk5d6qHUxU2w4P9EbhbozkVNjJjvgVC3aLPtRAyqSRKSoK9eqL4eMwWlhab5
 RWpdquli6ukosIEZ8Wk7mDe4K2g9evmKhH8dniywHcGSojJapluB+oYPSPUj/s7LLYly
 RPsw==
X-Gm-Message-State: AOAM532bxoSqn7etxq8yUJeBVu4/BYL3Co5IObw7EzSZF/0h3Meeo72g
 7NksHlDU+uBMldgtVepYHus8VuHXkYUK/dr1OfW7LG0tYEpMqg==
X-Google-Smtp-Source: ABdhPJwTDNj1VNwe3oxC7iJnA2m4sqyU/hoy3bHoSJEB+3TiblcE6aTxNfF/NervaxOqUgJlKitKSJSa5uC03eDrpwc=
X-Received: by 2002:a05:620a:440b:: with SMTP id
 v11mr7501647qkp.160.1640012544013; 
 Mon, 20 Dec 2021 07:02:24 -0800 (PST)
MIME-Version: 1.0
References: <CAOSmRzhPk4ykswcUTnK0bj2LdmJ9iwcNuzDpgPQj20d2_rf4Dw@mail.gmail.com>
 <YcCY1tmskGMy+QxV@B-P7TQMD6M-0146.local>
In-Reply-To: <YcCY1tmskGMy+QxV@B-P7TQMD6M-0146.local>
Date: Mon, 20 Dec 2021 10:02:13 -0500
Message-ID: <CAOSmRzhRDN62RbN1PQs=gCq0UmO9_q1F7QMd2WVPLcOLrbwZAA@mail.gmail.com>
Subject: Re: Practical Limit on EROFS lcluster size
To: Gao Xiang <hsiangkao@linux.alibaba.com>
Content-Type: text/plain; charset="UTF-8"
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
From: Kelvin Zhang via Linux-erofs <linux-erofs@lists.ozlabs.org>
Reply-To: Kelvin Zhang <zhangkelvin@google.com>
Cc: linux-erofs mailing list <linux-erofs@lists.ozlabs.org>
Errors-To: linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org
Sender: "Linux-erofs"
 <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>

On Mon, Dec 20, 2021 at 9:53 AM Gao Xiang <hsiangkao@linux.alibaba.com> wrote:
>
> Hi Kelvin,
>
> On Mon, Dec 20, 2021 at 08:45:42AM -0500, Kelvin Zhang wrote:
> > Hi Gao,
> >     I was playing with large pcluster sizes recently, I noticed a
> > quirk about EROFS. In summary, logical cluster size has a practical
> > limit of 8MB. Here's why:
> >
> >    Looking at https://git.kernel.org/pub/scm/linux/kernel/git/xiang/erofs-utils.git/tree/lib/compress.c?h=experimental&id=564adb0a852b38a1790db20516862fc31bca314d#n92
> > , line 92, we see the following code:
> >
> > if (d0 == 1 && erofs_sb_has_big_pcluster()) {
> >         type = Z_EROFS_VLE_CLUSTER_TYPE_NONHEAD;
> >         di.di_u.delta[0] = cpu_to_le16(ctx->compressedblks |
> >                 Z_EROFS_VLE_DI_D0_CBLKCNT); // This line
> >         di.di_u.delta[1] = cpu_to_le16(d1);
> > } else if (d0) {
> >         type = Z_EROFS_VLE_CLUSTER_TYPE_NONHEAD;
> >
> >         di.di_u.delta[0] = cpu_to_le16(d0);  // and this line
> >         di.di_u.delta[1] = cpu_to_le16(d1);
> > }
> >
> > When a compressed index has type NOHEAD, delta[0] stores d0(distance
> > to head block). But The 11th bit of d0 is also used as a flag bit to
> > indicate that d0 stores the pcluster size. This means d0 cannot exceed
> > Z_EROFS_VLE_DI_D0_CBLKCNT(2048), or else the parser will incorrectly
> > interpret d0 as pcluster size, rather than distance to head block.
> >     Is this an intentional design choice? It's not necessarily bad,
> > but it's something I think is worth documenting in code.
>
> Thanks for this great insight! Actually on-disk EROFS format doesn't
> have such limitation by design, since if it looks back to the delta0
> lcluster and it's still a NONHEAD lcluster, it will look back with
> new delta0 again until finding the final HEAD lcluster.
>
> But I'm not sure if mkfs code can handle > 8MiB lcluster properly yet,
> without modification since lcluster size is strictly limited with
> https://git.kernel.org/pub/scm/linux/kernel/git/xiang/erofs-utils.git/tree/include/erofs/compress.h#n14
> EROFS_CONFIG_COMPR_MAX_SZ * 2

Right, the current lcluster buffer is on stack, and has size
EROFS_CONFIG_COMPR_MAX_SZ*2.
I was working on a patch that moves lcluster buffer to heap and
increase it to way beyond 900KB.
With large pclusters it make sense to have a larger lcluster limit as
well, or else users wouldn't
be able to take full advantage of large pclusters.
Currently this fails during writing compressed indices. As
write_compacted_indexes
https://git.kernel.org/pub/scm/linux/kernel/git/xiang/erofs-utils.git/tree/lib/compress.c?h=experimental&id=564adb0a852b38a1790db20516862fc31bca314d#n313
would mistakenly interpret a large delta0 value as
Z_EROFS_VLE_DI_D0_CBLKCNT, resulting in
sanity check failure later on. Let me see if I can fix that... I
haven't  read the kernel code so I'm not
sure what the kernel is going to do with a large delta0 value which
happens to have the
Z_EROFS_VLE_DI_D0_CBLKCNT bit set.

>
> Yeah, I have to admit the current document might not be so detailed,
> partially due to my somewhat bad English written speed, and limited
> time...
>
> Thanks,
> Gao Xiang
>
> >
> >
> > --
> > Sincerely,
> >
> > Kelvin Zhang



-- 
Sincerely,

Kelvin Zhang
