Return-Path: <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>
X-Original-To: lists+linux-erofs@lfdr.de
Delivered-To: lists+linux-erofs@lfdr.de
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	by mail.lfdr.de (Postfix) with ESMTPS id 67B183F2DCE
	for <lists+linux-erofs@lfdr.de>; Fri, 20 Aug 2021 16:14:45 +0200 (CEST)
Received: from boromir.ozlabs.org (localhost [IPv6:::1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4GrkD32jPVz3cJ6
	for <lists+linux-erofs@lfdr.de>; Sat, 21 Aug 2021 00:14:43 +1000 (AEST)
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20161025 header.b=gRASQLlT;
	dkim-atps=neutral
X-Original-To: linux-erofs@lists.ozlabs.org
Delivered-To: linux-erofs@lists.ozlabs.org
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized)
 smtp.mailfrom=gmail.com (client-ip=2607:f8b0:4864:20::d33;
 helo=mail-io1-xd33.google.com; envelope-from=igoreisberg@gmail.com;
 receiver=<UNKNOWN>)
Authentication-Results: lists.ozlabs.org; dkim=pass (2048-bit key;
 unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256
 header.s=20161025 header.b=gRASQLlT; dkim-atps=neutral
Received: from mail-io1-xd33.google.com (mail-io1-xd33.google.com
 [IPv6:2607:f8b0:4864:20::d33])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 4GrkCz3Xf4z3btZ
 for <linux-erofs@lists.ozlabs.org>; Sat, 21 Aug 2021 00:14:38 +1000 (AEST)
Received: by mail-io1-xd33.google.com with SMTP id f6so4903473iox.0
 for <linux-erofs@lists.ozlabs.org>; Fri, 20 Aug 2021 07:14:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to;
 bh=WSZVvU6jBnJ0HfEsNJPTs+aQbJle1QCjQGw88mdQlUg=;
 b=gRASQLlTHCD1Zvq7i8jVTfeHk0p5I8AfwlEFH+YQgGnSzJCkyKz9w1kn6Ex9CFj+sS
 LeH/Qo9LQ09PMfZu/4/K6zidDwUBSkzRa3jtO1MDGMwYStht/7nS10JREel+f6Yz1x6E
 Gpkkqln46EkifPwT1pbZpPUMaLVxspduYKIFKfzOmfpJyHX93ME0UGLfgrNrQjvql303
 qEPv4DdfN9H1MHL0mvSpgtaPsJOMfTOtlwTbQJ+UTfUz0VLlpWB8+839VDXN3+DNKpub
 NG7JTS0rOH2ZRmAKfVo0IC1KcrfylnF7c6DhMep3S8b3LVfB4n7TN2x7zGrKZ1nliDZo
 ODeA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to;
 bh=WSZVvU6jBnJ0HfEsNJPTs+aQbJle1QCjQGw88mdQlUg=;
 b=rIh2yoUtlIFIQ53zL9fEi30JAw96WYocmGjBM8cQdu1c2rj/22Ddezsbs2GiU9C3PT
 KUM6nG44/pz7nDRnEvkoy023D3MLdAKJGb/hWvHoLHsm6dNCK0AVEigRXbCcRL2jcnW4
 OPBjr0peZZ1RFRorct9Fg6tDGO5GkJ1lNeL56tm/IFhBLXCJqzNVC43RKM9dUJOer7HE
 rT04Ipk2GN+LqmyC7ecMM1Vtn+5/tMvkc+Cad9B+7FrS9hEUOSZULPnwKW+q8bsFsFeT
 +8JXqR7qIyPYZbEYEGbj+IihxU+CPhYQig+3/1pGZ+XzZ9cQ+A6tCwKu4eA3vwa37mxr
 Affw==
X-Gm-Message-State: AOAM532vFfGasJBRwAjJsMNYhodHKeMQc9KoPdfLAtsCcJlqaMFulEoB
 Xowm59WxzajuCECbZQoap40Bu9kierdJdrwMzCQ=
X-Google-Smtp-Source: ABdhPJyU/RFgNsg4Rv8PfrRpk6MW+vigZSVijd2gkdgjLeE6pRyQUXt1STLTGo61ZobUL0R3oD9KpoDXpN6ZnWFPuKs=
X-Received: by 2002:a05:6638:1410:: with SMTP id
 k16mr5962159jad.32.1629468874975; 
 Fri, 20 Aug 2021 07:14:34 -0700 (PDT)
MIME-Version: 1.0
References: <CABjEcnGniBcadC4DDV4xCio8UmZyhSGWt+_gi_ESbYwoOQ2E0w@mail.gmail.com>
 <20210820124831.GA25021@hsiangkao-HP-ZHAN-66-Pro-G1>
 <CABjEcnEg6TSuCCTfpttXBT+Ue+iGGKv1PWNAn+WrpVE4qEQmfw@mail.gmail.com>
 <20210820132656.GA25885@hsiangkao-HP-ZHAN-66-Pro-G1>
 <CABjEcnFcM+Yib-SzNHBegabTjhoNvv7vH6WAkdZO1Vx13s-9xw@mail.gmail.com>
 <20210820134248.GB25885@hsiangkao-HP-ZHAN-66-Pro-G1>
 <CABjEcnFhPRg6unbsprCGSom284bHvnotTLk-s-0K078st_VR5Q@mail.gmail.com>
 <20210820140547.GC25885@hsiangkao-HP-ZHAN-66-Pro-G1>
In-Reply-To: <20210820140547.GC25885@hsiangkao-HP-ZHAN-66-Pro-G1>
From: Igor Eisberg <igoreisberg@gmail.com>
Date: Fri, 20 Aug 2021 17:14:24 +0300
Message-ID: <CABjEcnEXyy0j_667wbiHPiHFJtpk2TvfaEaTrWrXm5b1GsaTHg@mail.gmail.com>
Subject: Re: An issue with erofsfuse
To: Igor Eisberg <igoreisberg@gmail.com>, linux-erofs@lists.ozlabs.org
Content-Type: multipart/alternative; boundary="000000000000772b1805c9fe497b"
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
Errors-To: linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org
Sender: "Linux-erofs"
 <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>

--000000000000772b1805c9fe497b
Content-Type: text/plain; charset="UTF-8"

Ah you actually do have an option for that, I was looking at some old docs
probably.

" --fs-config-file=X    X=fs_config file\n"
>

Mate, I thank you sincerely, may the file system prosper.
Have a great weekend!

On Fri, 20 Aug 2021 at 17:06, Gao Xiang <xiang@kernel.org> wrote:

> On Fri, Aug 20, 2021 at 04:58:38PM +0300, Igor Eisberg wrote:
> > Ah yes, silly me, got liblz4-1 confused with liblz4-dev, had to download
> > the 1.9.3 *.deb packages manually cause apt-get is pushing 1.8.3.
> > Now everything is working top-notch.
> >
> > Regarding mkfs.erofs, I know it can take file_contexts, but how should we
> > handle fs_config, if it's even necessary?
>
> I think you need mkfs.erofs from latest AOSP tree, we don't directly
> enable fs_config for generic Linux build.
>
> Thanks,
> Gao Xiang
>

--000000000000772b1805c9fe497b
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr"><div dir=3D"ltr">Ah you actually do have an option for tha=
t, I was looking at some old docs probably.<div><br></div><blockquote class=
=3D"gmail_quote" style=3D"margin:0px 0px 0px 0.8ex;border-left:1px solid rg=
b(204,204,204);padding-left:1ex">&quot; --fs-config-file=3DX=C2=A0 =C2=A0 X=
=3Dfs_config file\n&quot;<br></blockquote><div><br></div><div>Mate, I thank=
 you sincerely, may the file system prosper.</div><div>Have a great weekend=
!=C2=A0</div></div></div><br><div class=3D"gmail_quote"><div dir=3D"ltr" cl=
ass=3D"gmail_attr">On Fri, 20 Aug 2021 at 17:06, Gao Xiang &lt;<a href=3D"m=
ailto:xiang@kernel.org">xiang@kernel.org</a>&gt; wrote:<br></div><blockquot=
e class=3D"gmail_quote" style=3D"margin:0px 0px 0px 0.8ex;border-left:1px s=
olid rgb(204,204,204);padding-left:1ex">On Fri, Aug 20, 2021 at 04:58:38PM =
+0300, Igor Eisberg wrote:<br>
&gt; Ah yes, silly me, got liblz4-1 confused with liblz4-dev, had to downlo=
ad<br>
&gt; the 1.9.3 *.deb packages manually cause apt-get is pushing 1.8.3.<br>
&gt; Now everything is working top-notch.<br>
&gt; <br>
&gt; Regarding mkfs.erofs, I know it can take file_contexts, but how should=
 we<br>
&gt; handle fs_config, if it&#39;s even necessary?<br>
<br>
I think you need mkfs.erofs from latest AOSP tree, we don&#39;t directly<br=
>
enable fs_config for generic Linux build.<br>
<br>
Thanks,<br>
Gao Xiang<br>
</blockquote></div>

--000000000000772b1805c9fe497b--
